Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17829EA7943
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 21:36:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6302402EE;
	Wed,  4 Feb 2026 22:36:11 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id AAC39400D5
 for <dev@dpdk.org>; Wed,  4 Feb 2026 22:36:09 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-126ea4e9694so554071c88.1
 for <dev@dpdk.org>; Wed, 04 Feb 2026 13:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770240968; x=1770845768; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qz5JYX8hQuWyd/4ny+exN8EDAee3msctpEBfwuIzI64=;
 b=UqGdeQUixoL6We713i/hr+DxYr+Ii0ETiVPqNxM5hPw3yjHOaR3S1uAs0p0QYMPbTX
 5Wf4egKsqeIEcePCiLKiJStghjiQ8BcZoGdzkUSh9Jb1lFE7ebme/tkZfaW2+6eVmSqG
 LUSH9oxro9ghRNxZSiG5DX3mLJ2ZcLmAjPFF8QVndtdK3xGaqvGJhzqPRApoJO/ME0Ys
 0kp9gdwQ+75viZEPBqShhIWI+8y4kMBWZiVZpmQlFqdMDuQ53WfPC+/j/ciB3qUFz91j
 1kaP6+3gpZldgoJhTL2eZdKfFuoWKMgxuHee7B7LdNTYtgkYdmor/C3kW4KAeKDFtHg0
 Hu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770240968; x=1770845768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qz5JYX8hQuWyd/4ny+exN8EDAee3msctpEBfwuIzI64=;
 b=eL1PGCc82ZKaEElm4NkuglMQcbdWxYxFpH5fbjr7E06pvv5XX1f9tMyLZdtU7aY7qT
 j9ita59qrkEFEv2qplPrmblmCM14xzPY4s+B1vBH81DJGF0NZnU2f7sxUDzgrRD+jG/s
 Bij/j9Nm98xH7sGkO/EKA6VKGglgfcZIj7nYhddJNY33XbpC9oNZ7HC8vmTGEezYT/jl
 l7toA/vyCxkMt2MMpPHq5YOZIhf2XGeo9XmWtuRGpAsDA1b8hw9pLrBe/NQ7pwg3JUz9
 sQcFVcltsrDZSQK1arGdblrqWGOqHfUIaieUa4Dyux6GbK8WpvNxPwI0kGR/scEA/iTs
 JAaQ==
X-Gm-Message-State: AOJu0YxNGOr4qEQOTxXFScR1k8kDcbTKXuZlTMdz1UrXO/U+GIxIdN+J
 Zw4Re9C3VQiaOtoZwMzBkqoc0Fh8nwi+o5lIyzm+j58ejWIuFtR8An3fObLZCg==
X-Gm-Gg: AZuq6aK4ia3cJJiG14q+6lVDTZhPquyBeGYVeahXFLsq2qqbr5bQmVjGj65o2/QYBV7
 vB4colauZUzuE9RE1sh+4bJEooOY2esBTmQbvKu39K9jyj1ntlIzd0ucj0OMHbJWOcba/k7ssLd
 hQAtFDOBmftSoWPQr9D1bXT+au7U9WVGXoPJXjGeB8I0E/poJmDXMlCvmjnWUl3zxeQPtJqlO9a
 FpipOX75BXeWgRWDbymEJzNlVLH6ROPOgYxC4wkCaSO286anFUUxbcoq06dZBt6VnTBPj7s4XiS
 gvUuzdyzgF0a0ldYaiCyEn0LW3B2Wc60sLsf4Mdw5fyVwmqNxBA06tlr7aQmddBvPQqZnrzhwh0
 3LHJEgMaK5WqbrnsiDUAvKZd9PgUaWfFVmofeK5m4b8d9Ku5G1CTljRPR2vS+skwdeGlHDKwnDB
 2ME89uVOZD26u6bEWYWvqx2BMyst2lIt6lI32KARZd8nyOh3wRn9KkHJ6fkvEU
X-Received: by 2002:a05:7300:2303:b0:2b7:2bf3:ce01 with SMTP id
 5a478bee46e88-2b832a7c450mr1818572eec.30.1770240968108; 
 Wed, 04 Feb 2026 13:36:08 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832f8e829sm2060442eec.22.2026.02.04.13.36.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 13:36:07 -0800 (PST)
From: Yehor Malikov <malikovyehor@gmail.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com, stephen@networkplumber.org,
 Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v4] vhost: fix use-after-free in fdset during shutdown
Date: Wed,  4 Feb 2026 22:35:59 +0100
Message-ID: <20260204213559.15659-1-malikovyehor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204185800.9299-1-malikovyehor@gmail.com>
References: <20260204185800.9299-1-malikovyehor@gmail.com>
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

Use symmetric RTE_INIT/RTE_FINI constructors and destructors for both
vhost-user and VDUSE fdsets to ensure proper initialization at library
load and cleanup before EAL teardown.

Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")

Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>
---
 .mailmap           |  1 +
 lib/vhost/fd_man.c | 16 ++++++++++++++++
 lib/vhost/fd_man.h |  1 +
 lib/vhost/socket.c | 24 +++++++++++++++++++-----
 lib/vhost/vduse.c  | 23 ++++++++++++++++++-----
 5 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..6fb87ca810 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1800,6 +1800,7 @@ Yaron Illouz <yaroni@radcom.com>
 Yaroslav Brustinov <ybrustin@cisco.com>
 Yash Sharma <ysharma@marvell.com>
 Yasufumi Ogawa <ogawa.yasufumi@lab.ntt.co.jp> <yasufum.o@gmail.com>
+Yehor Malikov <Yehor.Malikov@solidigm.com>
 Yelena Krivosheev <yelena@marvell.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
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
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 9b4f332f94..93d129774f 100644
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
@@ -1197,11 +1199,8 @@ rte_vhost_driver_start(const char *path)
 		return vduse_device_create(path, vsocket->net_compliant_ol_flags);
 
 	if (vhost_user.fdset == NULL) {
-		vhost_user.fdset = fdset_init("vhost-evt");
-		if (vhost_user.fdset == NULL) {
-			VHOST_CONFIG_LOG(path, ERR, "failed to init Vhost-user fdset");
-			return -1;
-		}
+		VHOST_CONFIG_LOG(path, ERR, "Vhost-user fdset not initialized");
+		return -1;
 	}
 
 	if (vsocket->is_server)
@@ -1209,3 +1208,18 @@ rte_vhost_driver_start(const char *path)
 	else
 		return vhost_user_start_client(vsocket);
 }
+
+RTE_INIT(vhost_user_fdset_init)
+{
+	vhost_user.fdset = fdset_init(VHOST_USER_FDSET_NAME);
+	if (vhost_user.fdset == NULL)
+		VHOST_CONFIG_LOG(VHOST_USER_FDSET_NAME, ERR, "failed to init Vhost-user fdset");
+}
+
+RTE_FINI(vhost_user_fdset_fini)
+{
+	if (vhost_user.fdset != NULL) {
+		fdset_deinit(vhost_user.fdset);
+		vhost_user.fdset = NULL;
+	}
+}
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 9de7f04a4f..e770bd61d4 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -27,6 +27,7 @@
 
 #define VHOST_VDUSE_API_VERSION 0
 #define VDUSE_CTRL_PATH "/dev/vduse/control"
+#define VDUSE_FDSET_NAME "vduse-evt"
 
 struct vduse {
 	struct fdset *fdset;
@@ -627,11 +628,8 @@ vduse_device_create(const char *path, bool compliant_ol_flags)
 	bool reconnect = false;
 
 	if (vduse.fdset == NULL) {
-		vduse.fdset = fdset_init("vduse-evt");
-		if (vduse.fdset == NULL) {
-			VHOST_CONFIG_LOG(path, ERR, "failed to init VDUSE fdset");
-			return -1;
-		}
+		VHOST_CONFIG_LOG(path, ERR, "VDUSE fdset not initialized");
+		return -1;
 	}
 
 	control_fd = open(VDUSE_CTRL_PATH, O_RDWR);
@@ -878,3 +876,18 @@ vduse_device_destroy(const char *path)
 
 	return 0;
 }
+
+RTE_INIT(vduse_fdset_init)
+{
+	vduse.fdset = fdset_init(VDUSE_FDSET_NAME);
+	if (vduse.fdset == NULL)
+		VHOST_CONFIG_LOG(VDUSE_FDSET_NAME, ERR, "failed to init VDUSE fdset");
+}
+
+RTE_FINI(vduse_fdset_fini)
+{
+	if (vduse.fdset != NULL) {
+		fdset_deinit(vduse.fdset);
+		vduse.fdset = NULL;
+	}
+}
-- 
2.52.0

