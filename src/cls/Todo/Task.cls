Class Todo.Task Extends (%Persistent, %JSON.Adaptor)
{

Property text As %String(MAXLEN = 250);

Property completed As %Boolean;

Property important As %Boolean [ InitialExpression = 0 ];

ClassMethod reset() As %Status
{
    set sc = $$$OK
    Do ##class(Todo.Task).%DeleteExtent()
    Set tasks = [
        {"text": "Make dinner reservations", "important": 0, "completed": 0},
        {"text": "Get coffee", "important": 1, "completed": 0},
        {"text": "Read the InterSystems Official news on Developer Community", "important": 0, "completed": 0},
        {"text": "Upgrade IRIS", "important": 0, "completed": 0},
        {"text": "Publish on Developer Community", "important": 0, "completed": 1},
        {"text": "Check InterSystems Certification Program", "important": 1, "completed": 1}
    ]
    
    Set iter = tasks.%GetIterator()
    While iter.%GetNext(,.obj) {
        Set task = ##class(Todo.Task).%New()
        set sc = task.%JSONImport(obj)
        #; Set task.text = obj.text
        #; Set task.important = obj.important
        #; Set task.completed = obj.completed
        set sc = task.%Save()
        if sc {
            write "successfully imported task ",task.%Id()," : ",task.text,!
        }
    }
    return sc
}

Storage Default
{
<Data name="TaskDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>text</Value>
</Value>
<Value name="3">
<Value>completed</Value>
</Value>
<Value name="4">
<Value>important</Value>
</Value>
</Data>
<DataLocation>^Todo.TaskD</DataLocation>
<DefaultData>TaskDefaultData</DefaultData>
<ExtentSize>6</ExtentSize>
<IdLocation>^Todo.TaskD</IdLocation>
<IndexLocation>^Todo.TaskI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="completed">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="important">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="text">
<AverageFieldSize>19.17</AverageFieldSize>
<Selectivity>16.6667%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Todo.TaskS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
