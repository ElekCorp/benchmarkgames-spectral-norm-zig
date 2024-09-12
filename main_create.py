from math import exp, log

main_dynamic = open("main.c",'r')
main_code=main_dynamic.read()
main_dynamic.close()

res = main_code.split("//#define STATIC 2000",1)

max_i=10000
num_of_points=1000

for j in range(1,num_of_points):
    i=int(exp(j/num_of_points*log(max_i)))
    main_static = open("./static_mains/main"+str(i)+".c",'w+')
    main_static.write(res[0])
    main_static.write("#define STATIC 2000\n")
    main_static.write(res[1])




