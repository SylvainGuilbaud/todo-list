angular.module('todolist').service('api',function($http) {
    return {
        getAllTasks: function() {
            return $http.get('/front-end/api/tasks')
        },
        getTask: function(id) {
            return $http.get('/front-end/api/task/' + id)
        },
        updateTask: function(id,data) {
            return $http.put('/front-end/api/task/' + id, data)
        },
        deleteTask: function(id) {
            return $http.delete('/front-end/api/task/' + id)
        },
        newTask: function(data) {
            return $http.post('/front-end/api/tasks', data)
        },
        finishTask: function(id) {
            return $http.put('/front-end/api/task/' + id, {"completed": 1})
        },
        getVersion: function() {
            return $http.get('/front-end/api/')
        }
    };
})
