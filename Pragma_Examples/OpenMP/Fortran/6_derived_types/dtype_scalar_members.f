! Original Author: Arjen Tamerus at DiRAC Hackathon Feb 2025
! Released to AMD as sample code
module dtype

        type :: my_dtype
                integer :: s, e
                integer,dimension(:),allocatable :: values
        end type

end module

program offload_types
        use dtype

        ! $omp declare mapper (my_dtype :: v) map(v, v%values(s:e))

        type(my_dtype),target :: my_instance
        integer,dimension(:),pointer :: values_ptr
        integer :: i

        ! $omp requires unified_shared_memory
        allocate(my_instance%values(1024))
        my_instance%s=1
        my_instance%e=1024

        values_ptr => my_instance%values

        !$omp target enter data map(to:my_instance)

        !$omp target teams distribute parallel do shared(values_ptr)
        do i = my_instance%s,my_instance%e
                values_ptr(i) = i
        end do

        !$omp target exit data map(from:my_instance%values)

        write(*,*) my_instance%values(10)

        !$omp target exit data map(release:my_instance)

        deallocate(my_instance%values)

end program
