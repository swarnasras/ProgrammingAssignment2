#The first function, makeCacheMatrix creates a special
#"matrix" which is really a list containing a function to
#*set the value of the matrix
#*get the value of the matrix
#*set the value of the inverse
#*get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinverse <- function(solve) m <<- solve
  getinverse <- function() m
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse) 
}


#The following function calculates the inverse of the 
#special "matrix" created with the above function.
#However, it first checks to see if the inverse has 
#already been calculated. If so, it gets the inverse 
#from the cache and skips the computation. 
#Otherwise, it calculates the mean of the data and sets 
#the value of the inverse in the cache via the setinverse function.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getinverse()
  ##Has the inverse already been calculated?
  ##If so, returns the inverse from the cache
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  #Otherwise, it calculates the mean of the data and sets 
  #the value of the inverse in the cache via the setinverse function.
  data <- x$get()
  ##Using the solve function to
  ##compute the inverse of the square matrix
  m <- solve(data, ...)
  x$setinverse(m)
  m
}