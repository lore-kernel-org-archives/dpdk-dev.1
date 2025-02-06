Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EA8C02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 08:42:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60EE9402CE;
	Thu,  6 Feb 2025 09:42:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D49744026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 09:42:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738831321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MFXZs8qN36asQKWZBtaLvBSXI9+mzsQTAJJ9YuzEgIU=;
 b=FDpVioGrJs6Ki+I8cwWblfh0wcpnDDF+eNUEb4092AK2eLXTd0phUOxktNOlkpob6Q/COO
 RDmCsKfXOSj9rw54ny07xdr3DmxXHk4g1ObNM3bTCzAjkhST8lxlUQgWi0GE+oFOTTnEYS
 wmWf7iVfAtbTZePMlrf36zSIw7nQEOM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-ygHkuAfROqG4bEZkKTFVfQ-1; Thu,
 06 Feb 2025 03:42:00 -0500
X-MC-Unique: ygHkuAfROqG4bEZkKTFVfQ-1
X-Mimecast-MFC-AGG-ID: ygHkuAfROqG4bEZkKTFVfQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 253A11800871; Thu,  6 Feb 2025 08:41:59 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.45.242.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA1CA19560A3; Thu,  6 Feb 2025 08:41:56 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: dev@dpdk.org,
	david.marchand@redhat.com,
	chenbox@nvidia.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
	stable@dpdk.org
Subject: [PATCH] vhost: fix FD entries cleanup
Date: Thu,  6 Feb 2025 09:41:54 +0100
Message-ID: <20250206084154.2230766-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YHRs9P1yL3ufhCjni9J5MHn0jbyksXVkeK1PZ1w0GZk_1738831319
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

With the recent rework of the FD manager to use epoll,
an error message is emitted with Vhost-user at FD entry
removal:

ERR|VHOST_FDMAN: could not remove 102 fd from 101 epfd: No such file or directory

It occurs because the read callback closes the file
descriptor before it is removed from the FD set.
This patch defers the close() after the FD entry is removed
from the set.

Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/fd_man.c | 12 +++++++-----
 lib/vhost/fd_man.h |  2 +-
 lib/vhost/socket.c | 11 +++++------
 lib/vhost/vduse.c  |  9 ++++-----
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c
index 9bc7e50b93..f9147edee7 100644
--- a/lib/vhost/fd_man.c
+++ b/lib/vhost/fd_man.c
@@ -333,7 +333,7 @@ fdset_event_dispatch(void *arg)
 	fd_cb rcb, wcb;
 	void *dat;
 	int fd, numfds;
-	int remove1, remove2;
+	int close1, close2;
 	struct fdset *pfdset = arg;
 
 	if (pfdset == NULL)
@@ -357,7 +357,7 @@ fdset_event_dispatch(void *arg)
 				continue;
 			}
 
-			remove1 = remove2 = 0;
+			close1 = close2 = 0;
 
 			rcb = pfdentry->rcb;
 			wcb = pfdentry->wcb;
@@ -367,9 +367,9 @@ fdset_event_dispatch(void *arg)
 			pthread_mutex_unlock(&pfdset->fd_mutex);
 
 			if (rcb && events[i].events & (EPOLLIN | EPOLLERR | EPOLLHUP))
-				rcb(fd, dat, &remove1);
+				rcb(fd, dat, &close1);
 			if (wcb && events[i].events & (EPOLLOUT | EPOLLERR | EPOLLHUP))
-				wcb(fd, dat, &remove2);
+				wcb(fd, dat, &close2);
 			pfdentry->busy = 0;
 			/*
 			 * fdset_del needs to check busy flag.
@@ -381,8 +381,10 @@ fdset_event_dispatch(void *arg)
 			 * fdentry not to be busy, so we can't call
 			 * fdset_del_locked().
 			 */
-			if (remove1 || remove2)
+			if (close1 || close2) {
 				fdset_del(pfdset, fd);
+				close(fd);
+			}
 		}
 
 		if (pfdset->destroy)
diff --git a/lib/vhost/fd_man.h b/lib/vhost/fd_man.h
index 6398343a6a..eadcc6fb42 100644
--- a/lib/vhost/fd_man.h
+++ b/lib/vhost/fd_man.h
@@ -12,7 +12,7 @@ struct fdset;
 
 #define MAX_FDS 1024
 
-typedef void (*fd_cb)(int fd, void *dat, int *remove);
+typedef void (*fd_cb)(int fd, void *dat, int *close);
 
 struct fdset *fdset_init(const char *name);
 
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 433a42bf80..b27020ae8d 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -84,8 +84,8 @@ struct vhost_user {
 
 #define MAX_VIRTIO_BACKLOG 128
 
-static void vhost_user_server_new_connection(int fd, void *data, int *remove);
-static void vhost_user_read_cb(int fd, void *dat, int *remove);
+static void vhost_user_server_new_connection(int fd, void *data, int *close);
+static void vhost_user_read_cb(int fd, void *dat, int *close);
 static int create_unix_socket(struct vhost_user_socket *vsocket);
 static int vhost_user_start_client(struct vhost_user_socket *vsocket);
 
@@ -290,7 +290,7 @@ vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
 
 /* call back when there is new vhost-user connection from client  */
 static void
-vhost_user_server_new_connection(int fd, void *dat, int *remove __rte_unused)
+vhost_user_server_new_connection(int fd, void *dat, int *close __rte_unused)
 {
 	struct vhost_user_socket *vsocket = dat;
 
@@ -303,7 +303,7 @@ vhost_user_server_new_connection(int fd, void *dat, int *remove __rte_unused)
 }
 
 static void
-vhost_user_read_cb(int connfd, void *dat, int *remove)
+vhost_user_read_cb(int connfd, void *dat, int *close)
 {
 	struct vhost_user_connection *conn = dat;
 	struct vhost_user_socket *vsocket = conn->vsocket;
@@ -313,8 +313,7 @@ vhost_user_read_cb(int connfd, void *dat, int *remove)
 	if (ret < 0) {
 		struct virtio_net *dev = get_device(conn->vid);
 
-		close(connfd);
-		*remove = 1;
+		*close = 1;
 
 		if (dev)
 			vhost_destroy_device_notify(dev);
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 8ba58555f9..9d39e71c68 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -117,7 +117,7 @@ static struct vhost_backend_ops vduse_backend_ops = {
 };
 
 static void
-vduse_control_queue_event(int fd, void *arg, int *remove __rte_unused)
+vduse_control_queue_event(int fd, void *arg, int *close __rte_unused)
 {
 	struct virtio_net *dev = arg;
 	uint64_t buf;
@@ -350,7 +350,7 @@ vduse_device_stop(struct virtio_net *dev)
 }
 
 static void
-vduse_events_handler(int fd, void *arg, int *remove __rte_unused)
+vduse_events_handler(int fd, void *arg, int *close __rte_unused)
 {
 	struct virtio_net *dev = arg;
 	struct vduse_dev_request req;
@@ -563,14 +563,13 @@ vduse_reconnect_log_check(struct virtio_net *dev, uint64_t features, uint32_t to
 }
 
 static void
-vduse_reconnect_handler(int fd, void *arg, int *remove)
+vduse_reconnect_handler(int fd __rte_unused, void *arg, int *close)
 {
 	struct virtio_net *dev = arg;
 
 	vduse_device_start(dev, true);
 
-	close(fd);
-	*remove = 1;
+	*close = 1;
 }
 
 static int
-- 
2.48.1

