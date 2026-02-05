Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C845EC1EA2
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 11:21:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6496340684;
	Thu,  5 Feb 2026 12:21:00 +0100 (CET)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id EB0884026D
 for <dev@dpdk.org>; Thu,  5 Feb 2026 12:20:58 +0100 (CET)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so790462eec.1
 for <dev@dpdk.org>; Thu, 05 Feb 2026 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770290457; x=1770895257; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/fopdJGO8PPzY4lPdFCmZRKKHHRM3T6AVCC7nJJsRxE=;
 b=nX/F4IKQo0fm6+KkWmuz903droRNjhBVpwr+kZr3aXB/BVjU7DxUFve4mle6RS8C4Z
 GDffWG2RGsNrcOF8llsGwTpLM/PcUgoMZliYhMg6TKwig2RfKlq8nSQMwD0LTiOAFLQr
 3ClaRbUfBSgJFipOYzrx6oTdRgkvjgHgQaqClc/JD52vXjnStO+vmk/N48RkMDePEXQw
 avJHO7NlLMhbFI4ZzlwuJL/mqZdvkzga2bGG5ng8HzVrTmnkDttNEyEy6rJnxbloM3Jh
 DF1FdpD+qnph9Sas32wnVw5yDb9Rt8gX4OAldi5Ur0joc6Z3uKlyVTQQzNWjewcuqh66
 4eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770290457; x=1770895257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/fopdJGO8PPzY4lPdFCmZRKKHHRM3T6AVCC7nJJsRxE=;
 b=v9Uk8moTZisrsgkVLH0e1laiQmJrSZkhbBcrCdSccy1C5KlohwkweMb2h8XhPzFPzj
 BcTCu25D/XAFeultUm9r0VlNikpWlbcKC7NBuDofChyIsfklD/bzeoZ8uAoo/uds4IBR
 SE5+8byd3XC8AcLy+uVT4340+wZUB2cW3QKSO3cqYwbgAq9dveGsWVk5I7yGkpJq+BXB
 2cJsx96w/pJcEzOVWI/lzJsdCMiossC/rjOMnzj0EyT0Qb1tp7MoxVBUrLhiYqxLJdo+
 28+IMN8cevgtnSl0GK3ivDSvAPn+SjLTeDNS7y81GbLH8of6InxQRws+YxqTX2q4jcNq
 HShA==
X-Gm-Message-State: AOJu0Yy7Iu8H8n0cgICkKPyyy7ZSjoNwkOSJMrUBQVNatQ4DHNGltlMo
 /SoKNg0I/fGREhGZdteYc7vL+9Qsc6ORCqvUvWpLALDU0dKifZoFysHW5jh/sw==
X-Gm-Gg: AZuq6aJ6fk75PqSS3n3Yb50Oew+D3vP2Nlnbwr19Ix3Fo8ikQ+DiLbKu6IutddFjT9w
 rj4jW3TOGk1uvgZnUaJBe9czeArF4ZJsNS8j9jwzNCnxlIJsQXk3ioDbXtRgDfdSn9xpibV40oG
 2MYgna0rRK5JlrEyXLIWjn662kkiumLIzkv8S+x/ejq9wtXHAcK9NH8VHs296qV476KcuhLzyr1
 vds6rccsUsE4Xyfpua5M+frWeiFfQr5vl9ugvF3zICKeNgxr8AVqa5bFTjRp9lmvS2Y+Xkp+rbI
 LWOX/7Tm2pIFHLnESyuK1VbcB/WrH/AgP0PG17fPSuV+EpU0dwMZa6V3cNa7Ev8bkUmlLzTKdWR
 M22nf3/Thrjt0nrxEJiZK8hmifuZmbDIRSYBg4vAFmigoxCsm2iGY6nPimZLpteCvGxO5fZSpPU
 kOJmYZVrO3l+biqSUdBDNgy7SskOXFa+E5ESaUWJ+1y4ONdTm7hw==
X-Received: by 2002:a05:7301:6794:b0:2b8:26b8:3446 with SMTP id
 5a478bee46e88-2b83291c7e0mr2705639eec.2.1770290457301; 
 Thu, 05 Feb 2026 03:20:57 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832fd7ae9sm2998335eec.31.2026.02.05.03.20.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Feb 2026 03:20:56 -0800 (PST)
From: Yehor Malikov <malikovyehor@gmail.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com, stephen@networkplumber.org,
 Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v7] vhost: fix use-after-free in fdset during shutdown
Date: Thu,  5 Feb 2026 12:20:51 +0100
Message-ID: <20260205112051.48107-1-malikovyehor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204230502.24983-1-malikovyehor@gmail.com>
References: <20260204230502.24983-1-malikovyehor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Yehor Malikov <Yehor.Malikov@solidigm.com>

The fdset_event_dispatch thread runs in a loop checking the destroy
flag after each epoll_wait iteration. During process exit,
rte_eal_cleanup() frees hugepages memory while the fdset thread is
still running, causing use-after-free when accessing the fdset
structure.

Add fdset_deinit() function to stop the dispatch thread by setting
the destroy flag and waiting for thread completion. Resource cleanup
(epoll fd, fdsets array, memory) is intentionally skipped since the
function is only called during process exit when the OS will reclaim
all resources anyway, avoiding potential deadlocks from mutex
operations in destructor context.

Use symmetric RTE_FINI destructors for both vhost-user and VDUSE fdsets
to ensure proper cleanup before EAL teardown.

Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")

Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>
---
 .mailmap              |  1 +
 lib/vhost/fd_man.c    | 16 ++++++++++++++++
 lib/vhost/fd_man.h    |  1 +
 lib/vhost/rte_vhost.h | 15 +++++++++++++++
 lib/vhost/socket.c    | 29 ++++++++++++++++++++++++++++-
 lib/vhost/vduse.c     | 17 ++++++++++++++++-
 lib/vhost/vduse.h     |  1 +
 7 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index fc53ed2a55..711a6ceff5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1840,6 +1840,7 @@ Yaroslav Brustinov <ybrustin@cisco.com>
 Yash Sharma <ysharma@marvell.com>
 Yasufumi Ogawa <ogawa.yasufumi@lab.ntt.co.jp> <yasufum.o@gmail.com>
 Yelena Krivosheev <yelena@marvell.com>
+Yehor Malikov <Yehor.Malikov@solidigm.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
 Yi Chen <chenyi221@huawei.com>
diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c
index f9147edee7..9790c8a586 100644
--- a/lib/vhost/fd_man.c
+++ b/lib/vhost/fd_man.c
@@ -149,6 +149,22 @@ fdset_init(const char *name)
 	return NULL;
 }
 
+void
+fdset_deinit(struct fdset *pfdset)
+{
+	unsigned int val;
+
+	if (pfdset == NULL)
+		return;
+
+	/* Signal the dispatch thread to stop */
+	pfdset->destroy = true;
+
+	/* Wait for the dispatch thread to exit */
+	if (rte_thread_join(pfdset->tid, &val) != 0)
+		VHOST_FDMAN_LOG(ERR, "Failed to join %s event dispatch thread", pfdset->name);
+}
+
 static int
 fdset_insert_entry(struct fdset *pfdset, int fd, fd_cb rcb, fd_cb wcb, void *dat)
 {
diff --git a/lib/vhost/fd_man.h b/lib/vhost/fd_man.h
index eadcc6fb42..c9e51badaa 100644
--- a/lib/vhost/fd_man.h
+++ b/lib/vhost/fd_man.h
@@ -15,6 +15,7 @@ struct fdset;
 typedef void (*fd_cb)(int fd, void *dat, int *close);
 
 struct fdset *fdset_init(const char *name);
+void fdset_deinit(struct fdset *pfdset);
 
 int fdset_add(struct fdset *pfdset, int fd,
 	fd_cb rcb, fd_cb wcb, void *dat);
diff --git a/lib/vhost/rte_vhost.h b/lib/vhost/rte_vhost.h
index 2f7c4c0080..31cbbe6039 100644
--- a/lib/vhost/rte_vhost.h
+++ b/lib/vhost/rte_vhost.h
@@ -464,6 +464,21 @@ int rte_vhost_driver_register(const char *path, uint64_t flags);
 /* Unregister vhost driver. This is only meaningful to vhost user. */
 int rte_vhost_driver_unregister(const char *path);
 
+/**
+ * Cleanup vhost library resources.
+ *
+ * This function stops the fdset event dispatch threads for both vhost-user
+ * and VDUSE backends. It should be called before rte_eal_cleanup() to ensure
+ * proper shutdown without use-after-free issues.
+ *
+ * The function is safe to call multiple times or even if no vhost driver
+ * was ever started.
+ *
+ * @return
+ *  0 on success
+ */
+int rte_vhost_cleanup(void);
+
 /**
  * Set the vdpa device id, enforce single connection per socket
  *
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index ae95e7e6b0..e378028fe1 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -76,6 +76,8 @@ struct vhost_user_connection {
 };
 
 #define MAX_VHOST_SOCKET 1024
+#define VHOST_USER_FDSET_NAME "vhost-evt"
+
 struct vhost_user {
 	struct vhost_user_socket *vsockets[MAX_VHOST_SOCKET];
 	struct fdset *fdset;
@@ -1198,7 +1200,7 @@ rte_vhost_driver_start(const char *path)
 			vsocket->extbuf, vsocket->linearbuf);
 
 	if (vhost_user.fdset == NULL) {
-		vhost_user.fdset = fdset_init("vhost-evt");
+		vhost_user.fdset = fdset_init(VHOST_USER_FDSET_NAME);
 		if (vhost_user.fdset == NULL) {
 			VHOST_CONFIG_LOG(path, ERR, "failed to init Vhost-user fdset");
 			return -1;
@@ -1210,3 +1212,28 @@ rte_vhost_driver_start(const char *path)
 	else
 		return vhost_user_start_client(vsocket);
 }
+
+static void
+vhost_user_fdset_cleanup(void)
+{
+	if (vhost_user.fdset != NULL) {
+		fdset_deinit(vhost_user.fdset);
+		vhost_user.fdset = NULL;
+	}
+}
+
+RTE_EXPORT_SYMBOL(rte_vhost_cleanup)
+int
+rte_vhost_cleanup(void)
+{
+	vhost_user_fdset_cleanup();
+	vduse_fdset_cleanup();
+
+	return 0;
+}
+
+RTE_FINI(vhost_fini)
+{
+	vhost_user_fdset_cleanup();
+	vduse_fdset_cleanup();
+}
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 0b5d158fee..2633871472 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -27,6 +27,7 @@
 
 #define VHOST_VDUSE_API_VERSION 0
 #define VDUSE_CTRL_PATH "/dev/vduse/control"
+#define VDUSE_FDSET_NAME "vduse-evt"
 
 struct vduse {
 	struct fdset *fdset;
@@ -685,7 +686,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 	bool reconnect = false;
 
 	if (vduse.fdset == NULL) {
-		vduse.fdset = fdset_init("vduse-evt");
+		vduse.fdset = fdset_init(VDUSE_FDSET_NAME);
 		if (vduse.fdset == NULL) {
 			VHOST_CONFIG_LOG(path, ERR, "failed to init VDUSE fdset");
 			return -1;
@@ -942,3 +943,17 @@ vduse_device_destroy(const char *path)
 
 	return 0;
 }
+
+void
+vduse_fdset_cleanup(void)
+{
+	if (vduse.fdset != NULL) {
+		fdset_deinit(vduse.fdset);
+		vduse.fdset = NULL;
+	}
+}
+
+RTE_FINI(vduse_fdset_fini)
+{
+	vduse_fdset_cleanup();
+}
diff --git a/lib/vhost/vduse.h b/lib/vhost/vduse.h
index b2515bb9df..53f16b0238 100644
--- a/lib/vhost/vduse.h
+++ b/lib/vhost/vduse.h
@@ -11,5 +11,6 @@
 
 int vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool linearbuf);
 int vduse_device_destroy(const char *path);
+void vduse_fdset_cleanup(void);
 
 #endif /* _VDUSE_H */
-- 
2.52.0

