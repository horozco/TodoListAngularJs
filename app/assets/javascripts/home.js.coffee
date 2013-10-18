app = angular.module("TodoList", ["ngResource"])

app.factory "Task", ["$resource", ($resource) ->
  $resource("/tasks/:id", {id: "@id"},
    {
      update: {method: "PUT"},
      destroy: {method: "DELETE"}
    })
]

@FirstCtrl = ["$scope", "Task", ($scope, Task) ->
  $scope.tasks = Task.query()

  $scope.addTask = ->
    task = Task.save($scope.newTask)
    $scope.tasks.push(task)
    $scope.newTask = {}

  $scope.switchStatus = ->
    if @task.complete then @task.complete = false else @task.complete = true
    @task.$update()

  $scope.deleteTask = ->
    if confirm("Are you sure")
      index = $scope.tasks.indexOf(@task)
      @task.$destroy(
        success= ->
          $scope.tasks.splice(index, 1)
        , err = ->
          alert("there was a problem")
      )

]