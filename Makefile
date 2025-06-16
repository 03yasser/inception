
SOURCE_FILES = main.cpp PmergeMe.cpp

RM = rm -rf

NAME =  

all: $(NAME)


clean:
	$(RM) object_files

fclean: clean
	$(RM) $(NAME)

re: fclean all