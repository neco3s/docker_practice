# docker_practice

### 学んだこと

- docker login
- dockerはコンテナを起動するだけで環境構築が終わる。テスト環境と本番環境の統一(差異をなくす),他の開発者との開発環境の統一
- Kernel(核)はShell(殻)に囲まれてる僕らはKernelと直接コミュニケーションを取れないからShell(bash,zsh)に仲介してもらってコミュニケーションが可能になる
- docker runで何が起こるか (1run,2create,3execute,4exit),処理が終了すると勝手にexitする。
- docker run -it ubuntu bash,-itはbash起動時に必要なおまじない、bashはコンテナ起動時に実行するプログラム
- docker run イメージ,このとき指定したイメージがホストになければdockerHubからpullしてくれる
- docker run -it ubuntu bashで何が起こるか(1run,2create,3execute(bashの起動)),createしたコンテナ内のubuntu(os)内で起動しているbash(殻)と対話できる状態になる。`exit`とbashの標準入力に渡すとcreateしたコンテナを停止しホストのターミナルに戻る(デフォルトコマンドをbashで上書きしている)
- Docker imageは複数のImage layerで構成されている。これの何が嬉しいか？2つのコンテナで共通する部分のImage layerをシェアする事ができる。重複を省ける
- Docker file -> Docker image -> コンテナ
- Docker imageを更新する方法は2つある。1.Docker fileからDocker imageを作る、2.コンテナからDocker imageを作る。前者(1)の方が一般的
- docker ps(起動中のコンテナの表示),docker ps -a(停止中のコンテナも表示)
- docker exec \<container id> \<command>,(コンテナを指定してコマンドをexecuteする)
- docker exec -it \<container id> bash,(bashをコンテナで実行するときは-itが必要)
- detach(Hostのコンテナを動かすprocess(コンテナ内で実行中のプログラム)は残ったままなのでコンテナはUP状態のまま),Ctrl + p + q
- detachとexitの違い、(exitで出るのが一般的。 プロセスを残したまま出たいときはdetachを用いる)
- docker attach \<container id>で元のプロセス(exec -it \<container id> bash)に入る事ができる
- docker restart \<container id>,コンテナの状態をUP にする
- IMAGE名(REPOSITORY名:TAG名),例: library/ubuntu:latest, REPOSITORY名だけを指してIMAGE名と言う人もいる。TAGはdefaultで:latest =>repository名とimage名は一致しなければならない
- docker commit \<container> \<image>、コンテナからdocker imageを作成するコマンド
- docker tag \<source> \<target>,(イメージの名前をsource元の名前からtarget新しい名前に変更する) docker tag ubuntu:updated \<username>/repo-name
- docker imageの構成, \<hostname>:\<port>/\<username>/\<repository>:\<tag>、説明\<hostname>:\<port>(デフォルト=registry-1.docker.io)、\<username>(デフォルト=library)、\<repository>(デフォルトなし)、\<tag>(デフォルト=latest)=>この知識が何に役立つのか？=>dockerhubではなく他のホスティングサービスを使用する時役立つ、hostname,portを指定しなきゃいけないんだと分かる
- docker imagesでローカル(Host,君の目の前にあるパソコンの中)にあるdocker imageを一覧表示
- docker push \<image>、dockerhubなどのホスティングサービスのレポジトリにimageをアップロードすること
- docker rmi \<image>、ローカル(Host)にあるdocker imageの削除
- docker pull \<image>、dockerhubのレポジトリーからimageをダウンロードすること
- :zap:  上記のdocker でやったことの総活動画  <https://www.udemy.com/course/aidocker/learn/lecture/20294807#content>
- :zap: dockerの動きを詳細に理解 <https://www.udemy.com/course/aidocker/learn/lecture/20294833#content>
- docker run = docker create + docker start
- docker run -it ubuntu bash, -i(インプット可能) -t(表示が綺麗になる)
- docker rm \<container>,コンテナの削除
- docker stop \<container>,コンテナを止める
- docker system prune ,コンテナ全削除
- :wrench: command + t で新しいterminal、ブラウザのタブを開く
- :wrench: control + tab(->|) でterminal、ブラウザのタブの切り替え
- docker run --name sample_container ubuntu, (同じ名前のコンテナは作れない)
- docker run -d \<image>,(コンテナを起動後にdetachする、バックグラウンドで動かす)
- docker run --rm \<image>,(コンテナをExit後に削除する、一回きりのコンテナ)
- コンテナからcommitしてdocker imageを作るより、DockerfileからDocker imageを作ることの方が多い、なぜならdocker imageがどう言う構造になっているかがコンテナから作られたdocker imageだと分からないから、Dockerfileはdocker imageの構成が丸わかりな設計図だから、業務ではみんなdocker fileからdocker imageを作る
- Dockerfile = "INSTRUCTION arguments" の形でずらっと記載していく(FROM,RUN,CMD)
- docker build \<directory>,(directoryの階層にあるDockerfileからdocker imageを作成する、名前をつけずに作成するとrepository+tag=imageがnoneになる、このような名前を持たないimageをdangling imageと言う)
- docker images -f dangling=true,(dangling imageを表示する)
- docker build -t \<name> \<directory>
- FROM,(ベースとなるイメージを決定,このベースの上に全てのレイヤーが乗っかるイメージ)alpineが最低限のイメージ5MB
- RUN, (Linuxコマンドを実行、RUN毎にLayerが作られる)
- Dockerfileのベストプラクティス(Docker imageのLayer数は最小限にする!,Layerを作るのはRUN,COPY,ADDの３つ,コマンドを&&で繋げる、バックスラッシュ(\ )で改行する)
- ubuntuではapt-get(apt)というコマンドでパケージを管理する,apt-get update(新しいパッケージリストを取得),apt-get install \<package>(packageをインストール)
- Dockerfileを作っている最中はキャッシュを使って細かく分けてつくる(RUNコマンドを分けて細かくレイヤーを乗っけていく)
- ちゃんと通ること(docker buildできること)が分かれば、最後にDockerfileを(\ )を用いたLayerの数が最小限になるような形にしてDockerfileとして完成
- CMD, (コンテナのデフォルトのコマンドを指定,原則Dockerfileの最後に記述,CMD["executable","params1","params2"])
- RUN と CMD の違い(RUNはLayerを作る,CMDは作らない,保存したい内容はRUN,起動時に実行したい内容はCMD)
- docker build,()
- build context,(docker buildの際に指定していたフォルダーのことをbuild contextと呼ぶ、build時の状況、環境)
- ADDやCOPYでbuild contextの中にあるファイルをimageに持っていける
- docker architecture(client-server architecture,client->REST API->server,client cli->api->docker daemon)
- du -sh file.txt,fileのサイズがわかる
- COPY \<source> \<destination>
- COPYとADDの違い、(単純にファイルやフォルダをコピーする場合はCOPY,tarの圧縮ファイルをコピーして解凍したいときはADD)
- アーカイブは複数のファイルやフォルダを１つにまとめること、圧縮はファイルを潰すこと
- docker build -f \<dockerfilename> \<build context>,(Dockerfileという名のファイルがビルドコンテキストに入ってない場合,Dockerfile.dev,Dockerfile.testなどのファイル名の時に用いる,Dockerfileとbuild contextを分けて管理する事ができる)
- ENTRYPOINT(デフォルトのコマンドを指定する事ができる,run時に上書きできない,ENTRYPOINTがある場合はCMD は["params1","params2"]の形をとる引数をとる、run時に上書きできるのはCMD の部分のみ、コンテナをコマンドのようにして使いたい時に使う)
- ENV(環境変数を設定する, ENV \<key> \<value>,\<key>= \<value>でも良い)
- WORKDIR \<絶対path>,(Docker instructionの実行ディレクトリを変更する, WORKDIRで指定したフォルダーがなければ自動で作ってくれる)
- docker run -v \<host>:\<container>,(ホストのファイルシステムをコンテナにマウントする)
- docker run -u \<user id>:<group id>,(ユーザIDとグループIDを指定してコンテナをrunする)
- id -u(user idの表示),id -g(group idの表示)
- Dockerfile のコマンドはroot権限で実行される
- :bug: docker run -it -u $(id -u):$(id -g) -v ~/mounted_folder:/created_in_run 85069a27d3e0 bash
- docker run -p \<host_port>:\<container_port>,(ホストのポートをコンテナのポートに繋げる,-pはpublishの略)
- :bug docker run -it -p 8888:8888 jupyter/datascience-notebook bash
- OOM(Out Of Memory)
- docker inspect \<container id>,(コンテナにどれくらいのcpu,memoryなどのリソースが割り当てられているかが分かる)
- docker run --cpus \<#ofCPUs> --memory \<byte>,コンピュータリソースの上限


### 参考にした動画

<https://www.udemy.com/course/aidocker/learn/lecture/20294617#content>
