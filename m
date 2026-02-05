Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1848FEC1EB2
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 13:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8CC2410DC;
	Thu,  5 Feb 2026 14:49:46 +0100 (CET)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 660C840684
 for <dev@dpdk.org>; Thu,  5 Feb 2026 12:16:39 +0100 (CET)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2b751c8b6beso1028368eec.0
 for <dev@dpdk.org>; Thu, 05 Feb 2026 03:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770290198; x=1770894998; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/fopdJGO8PPzY4lPdFCmZRKKHHRM3T6AVCC7nJJsRxE=;
 b=HrWWy+k/dtLt1NdUbHq+0wF/W52arLOOQnuXeHiCYNNtZpLPTSjm4aULyJkQaNniLu
 e7qmSxMq9XcVxngPwqOCSxigEV3HgpzoVJh7PzO8rlbPbv2MHisKVrTz1sV1JJyKYgoJ
 u7IhIbDOkLLb1g0Hs7YAJXtE25vzBsZBQ3XXeqaS8ksl9tYEcTYdX64PnfXGygxJ2IDB
 s9ZJaWkOnFQCtBqkQiMDQJnS0xRkspQq9HtFu40M2WiXxxqVY2dh2ioH695s/vunWpn1
 aKhtepCzoPNozQ4N4ujWUtFXKrFR3+TVXLyQmQkrgCdYY7A3VNTJNtk6v4cUavECwcjl
 srag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770290198; x=1770894998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/fopdJGO8PPzY4lPdFCmZRKKHHRM3T6AVCC7nJJsRxE=;
 b=fk0JUCJOtDtb5gTE53Lq+d+1dlpU65vr6uviE/SyVV880rds4Jv7NXyh8ChGA+mI6v
 G42dKU4YDWhPePrkDeUUQXq4zVa3TRVRvYpjOwtrVIMI6JDD4XRMmAPAd8GCjmtIPyYw
 rgbld6oKVPzdYErpJdSZlxnpsEPVMfhErs6FWh2b1w2ezzeTW24Jj046nCN8JcDHSAid
 AjGyGTMc6aQUN08dzM1rycfthO7twCk96wpaYNB8KxFAuqBME8akBiphErOEj7FOuEGz
 x1aL0QtTZpzMsfkxu4OfSVPaime55rZhHbfh9gztuOUu97DjVr8PunGfCzEuczp6kqGP
 GReA==
X-Gm-Message-State: AOJu0YyvoCkqYr1j//d46xRZ/JtatFK2Jvd2zwbgy+vXQ37jjdFSyraS
 PwDkA88o1bIP9bueLQHPpy+s9Rfs3C0C5goZL+7VeM+Rg5SniuqTLj54HV5EAQ==
X-Gm-Gg: AZuq6aKWPyxGdNPI5pZgTjhqascAO3233XrvbCL5anDG8vtFcAW7u+glHj7HeCqoPCD
 vOjNPuN46rWRefohcpEJi4LzJvz0/FCw1l+oxs/DyYAr/5dz7h/F05h3Sc6XhwviTFEpRg45+CK
 5+wldpLFvmKcQQwQjNQAe1TYqab5KjvJ4cPJFbC0bs7mvmlgv7cZqe6NJTq//8GvPxGa1G+hYXd
 +NTwqK9WQhoiySjUcwKQWVB0TSoBol62Ohr2mZs1dhoazdIoWrHkE1ayz7K2qOjVsO/ZzCsI4M1
 qtjytdwaAzPwMSYo8Pd1A9P6LbZMUiTKGgPrSJa0TThb784nxVHEQSGDALfmbMD4CSKDULcJMi+
 1cEx7WreOuQshTHs4wyae46EqnYUHXKJERHeX4X+yaX3o7YLG99qEIItcWiOk0ESCSFWgUrZNWO
 gqiiNtso5q1e3D1ct6453C9TAvP9jhRe8jyKJ3Y6JgDTcARwVAeA==
X-Received: by 2002:a05:7301:2f9b:b0:2a4:646c:e096 with SMTP id
 5a478bee46e88-2b84591937fmr1023531eec.0.1770290197763; 
 Thu, 05 Feb 2026 03:16:37 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832f93808sm3317142eec.19.2026.02.05.03.16.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Feb 2026 03:16:36 -0800 (PST)
From: Yehor Malikov <malikovyehor@gmail.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com, stephen@networkplumber.org,
 Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v7] vhost: fix use-after-free in fdset during shutdown
Date: Thu,  5 Feb 2026 12:16:30 +0100
Message-ID: <20260205111630.48009-1-malikovyehor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204230502.24983-1-malikovyehor@gmail.com>
References: <20260204230502.24983-1-malikovyehor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Feb 2026 14:49:44 +0100
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

