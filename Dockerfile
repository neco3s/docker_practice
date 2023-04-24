FROM ubuntu:latest
# 新しいパッケージリストを取得 && packageのインストール(-yはインテラクティブな質問に対して自動でyesと答えてくれるオプション)
# RUN apt-get update && apt-get install -y \
#   curl \
#   cvs
# RUN apt-get install -y nginx

# CMD ["pwd"]

# RUN mkdir /new_dir
# COPY something /new_dir/

# ADD compressed.tar /

# RUN touch test
# RUN touch hh
# ENTRYPOINT [ "ls" ]
# CMD ["--help"]

# ENV key1=value

# RUN mkdir sample_folder
# RUN cd sample_folder
# RUN touch sample_file

# RUN mkdir sample_folder \
#   && cd sample_folder \
#   && touch sample_file


# RUN mkdir sample_folder
# WORKDIR /sample_folder
# RUN touch sample_file

# RUN mkdir /new_directory
# RUN mkdir /hellosss

RUN mkdir created_in_dockerfile
