Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3769DEA794A
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 23:05:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 513A74028E;
	Thu,  5 Feb 2026 00:05:14 +0100 (CET)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 3D1D440264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 00:05:12 +0100 (CET)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2b834e17c3fso281807eec.0
 for <dev@dpdk.org>; Wed, 04 Feb 2026 15:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770246311; x=1770851111; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MARs1L/Ut5lKYfSaJsZ9K0Wfu5N1T5Yi5YC87Tx53Y=;
 b=KVwEwTYpeI9cuz8hg4MoFzDoJtKEE0n2zqsXvW/upe+zQEkJ7V08ZbHA1002SukEvz
 SB23DICK9iM7OWkAeomoIdWD9/aRdEAX136Xwr4BAEc9rK0h3qA3aBnA91FJvsLvr5Kd
 HCJfWcdhNsB4X5k6zImXsCjaAJDqKyHNQ3+6pUD8vsEU8X8FCJZaUPVK2UEWkZTRoLFn
 gMTK+O/naX4dAs/t3yOGWyiVWyetXfEY9kcrROC8K2cymm1bXAvPSgB18ubndPpOl5Uo
 sk3ucILMYkU8tecEwW7SLd1mJB0qkHmlTEysx6cI3eVKhzxTcxEZd6fcq35WvUbDsaSz
 N3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770246311; x=1770851111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5MARs1L/Ut5lKYfSaJsZ9K0Wfu5N1T5Yi5YC87Tx53Y=;
 b=vBxVQH95ZK9ftx8DA+cw8Y3LplULjQ/H8Az6s9C0yPWkLUqiRMKgfDvtcAgE6zrd2d
 wp4VlG+jW9u4YB9UNDHnLfqLi9GFT2+B2ky+ALrz3Dti++qMnS8vbaTEX8yjA8wZdRGr
 34s7zzoYGxVwiUdIhljD+ky9KxFAZZg5OQVWPcdZ0u2Sw7wB1u7bQLZKZyJ8qHW5b7OH
 QZJZxv5hJCqdx+wXNrZ2a1HqchTmQfvWSKiU7kY73vQv+WdsnDDJeLmVTka2KqHuHBSh
 MfPMwqCXICkjFGu6gehrCNVoBsbMXQ7WZq+5zn9kmD+EDB8gmYpqjAwDh1w/CcWguAV/
 QTag==
X-Gm-Message-State: AOJu0Yz9oQ5Dq/i02MMsZf7OL5Kk/cAFwCkQaCg99ti0nwvY+wja5Z2b
 jzBIZQnJth+JdGHblOFhyNNDR4xS+V0fQmguEP+lM93bTeZuQP0GsFXqzlVtZQ==
X-Gm-Gg: AZuq6aI3ZUCGlgIv37t2BpL7bNCyTP/aPx9xmxFAH+VoNMvt5ZI87rmfi09O8fDxE62
 t/dxz/+/PFf4fLYz3gcJJhizyA8o/VaGSv86AL5qZjp5TOCXfmHlk2oFegQf/8mHjZO2Ypv0d6z
 QWrHVCOrzpNBc/YsnjPO3w1rBAh21PSXsyfhZYM2D8B4lB0L2RlM53Eh9syPLGVSB5y6sagnqdU
 TQHojACAks0oq7WW4VJjNqyf+P94hr99iODgZ7P+dWpz6nfmL9GMCmy60UVhd1SlfkdYL8FvekD
 exlDvsUkRguR/zsRlfJ7KupjRWwl88BeCccklG2guvY1Va6hFj2DLZrZ5XguGA8Cd7lc2JmO7Sn
 VTkXzzn8xqUYunNMVlk2ki2Ekwn1l3oSJSdD4fvkx9GyvUGocIu2dn9FaCuIqlmNvr5m6NYWLne
 csBDvw19xHHkt+0V8uGCuulK9xOeKYGgIagt2TzeFlDSgSh+IbXw==
X-Received: by 2002:a05:7300:bc1a:b0:2b7:1008:9f51 with SMTP id
 5a478bee46e88-2b832876cdamr2279365eec.8.1770246310250; 
 Wed, 04 Feb 2026 15:05:10 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832f8ea26sm2539425eec.21.2026.02.04.15.05.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 15:05:09 -0800 (PST)
From: Yehor Malikov <malikovyehor@gmail.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com, stephen@networkplumber.org,
 Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v6] vhost: fix use-after-free in fdset during shutdown
Date: Thu,  5 Feb 2026 00:05:02 +0100
Message-ID: <20260204230502.24983-1-malikovyehor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204220037.23760-1-malikovyehor@gmail.com>
References: <20260204220037.23760-1-malikovyehor@gmail.com>
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
 .mailmap           |  1 +
 lib/vhost/fd_man.c | 16 ++++++++++++++++
 lib/vhost/fd_man.h |  1 +
 lib/vhost/socket.c | 12 +++++++++++-
 lib/vhost/vduse.c  | 11 ++++++++++-
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index fc53ed2a55..998185a66e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1839,6 +1839,7 @@ Yaron Illouz <yaroni@radcom.com>
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
index ae95e7e6b0..91680fbbaa 100644
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
@@ -1210,3 +1212,11 @@ rte_vhost_driver_start(const char *path)
 	else
 		return vhost_user_start_client(vsocket);
 }
+
+RTE_FINI(vhost_user_fdset_fini)
+{
+	if (vhost_user.fdset != NULL) {
+		fdset_deinit(vhost_user.fdset);
+		vhost_user.fdset = NULL;
+	}
+}
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 0b5d158fee..8d1846b491 100644
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
@@ -942,3 +943,11 @@ vduse_device_destroy(const char *path)
 
 	return 0;
 }
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

