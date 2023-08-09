angular.module('todolist').controller('version', ['$scope','$state','api', function($scope,$state,api) {
    api.getVersion().then(function(response) {
        $scope.version = response.data.version;
        $scope.ts = response.data.ts;
    });
}])