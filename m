Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD826EA7943
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 22:01:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC00402EE;
	Wed,  4 Feb 2026 23:01:02 +0100 (CET)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 4CCA9400D5
 for <dev@dpdk.org>; Wed,  4 Feb 2026 23:01:01 +0100 (CET)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1249b9f5703so642994c88.0
 for <dev@dpdk.org>; Wed, 04 Feb 2026 14:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770242460; x=1770847260; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HY17X4Du7lVmMAz+gvhoGn3zlRp+l1QNh49paQF6p/A=;
 b=MD6H/Bwr4rn6TOpw46/AvvKtGhGUQxLRKvV5nGfJ33WgpNXxoTCScYANj2lzYQxagA
 BEHf+rQKU8AFBW16w/v0PhheihdVIJAhQVgfG878ZzxUKlrywdMKVP4SZJrec9ciEpDi
 jdVV9KDlD26rZ7wNj6NONVMqkF/KnmkFYmCqFGqt5kAueJmM02LtpGZ0pEUeqOWyf6g7
 WW9oYcuG22qN4ephxXQ6+w2QAWEMqIoo7poms/j2wK6LF+RbvupBTuSJRGn5nIRPF6tP
 /5sO3a23mCnXvCYumnB7IifLGAfR7FY9L0UxkROfR8avQGCyN4wVA8vYLR3OWFe3xi5r
 WwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770242460; x=1770847260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HY17X4Du7lVmMAz+gvhoGn3zlRp+l1QNh49paQF6p/A=;
 b=ZDOX6H3MGvz0uTnSCxfOcyxAL7wKG1CB0oyitu1p21DpVg46f2gCk2JjvrnwUelhfL
 sJu/AS6Pwjgb5rTFwQGozIY9LnBrvp3Hf3wL5Q/mq2kMqCeFo8IZT9DxDDkUQCmdowks
 uQ3bKH4ykZn01FbVYaHKVLApsJw9vwveCK6pfnblPaQTtl2U2sAA4CvmiN/60poHEGGc
 pVYBZkB2VG9vzGTYEQ4bMJrwcpfZHi+qsl/9/mZjJJO8hVvafExGKvOxQZKtJFrstE3R
 p6X4Ff5DBEPDX+volQ5ROWyDzPPCAOwiVdsmtuzg21xOW8Ff/05c+GiAmDRKKH9c/E2U
 paDg==
X-Gm-Message-State: AOJu0Ywh9nxTilaykYYsxKtckzpDxDizCtwftvkeFfxMDBYDjEL6Tgio
 rItrgXfvwhAmjtej2cH3G3eDK9bOocyFVtBani9lWurP5EB+3Df5qa5JnIfFmw==
X-Gm-Gg: AZuq6aI2NCo10xl/aDjaQiYZ9onwlk0iX7tfnCZNmXXHr7AGwhEyrtXjLdPsmq86gWc
 wHGnLu7Rqy8Cpo5GvaGSl2JOpXajrCWH5PcPpN16WgfWukDr5QroY3HlJrnt8EBKLJ/UCFLJoQg
 6IyMolcbuDWgnLWHLI+7eUqSULenGatMWesN1lMuvZJH7fnBixq7rh+QDqdOksqiCYf4wGtkuIQ
 akybjf2YsJ17Dyynl5wRKXkA8/4jsMMjrL93o7VstbJWpCI3piXxOOsnc6VTlV0mIRB/nFIdHx3
 mYqklFhcv2BQH5M0vLnlv93y/4vYoijO5DeCA0yufP3h6H6UYDd3FPfzC2C68FIjsHz+pL9oVvO
 ZhwYledUMeYcgKNSFwDl86/LPy48ca23km9x+29qJsM6W1R/R5QBWXOpyg+Z/lagRn+VU2ITs9T
 UbQhjEBYidwWiGaTs+ZlgyLFgTxCJ+hFbjdepCtvhJPNyDjsFVeg==
X-Received: by 2002:a05:7022:4384:b0:123:3103:b248 with SMTP id
 a92af1059eb24-126f477950emr1973868c88.5.1770242459534; 
 Wed, 04 Feb 2026 14:00:59 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832fb564fsm2126935eec.25.2026.02.04.14.00.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 14:00:58 -0800 (PST)
From: Yehor Malikov <malikovyehor@gmail.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com, stephen@networkplumber.org,
 Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v5] vhost: fix use-after-free in fdset during shutdown
Date: Wed,  4 Feb 2026 23:00:37 +0100
Message-ID: <20260204220037.23760-1-malikovyehor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204213559.15659-1-malikovyehor@gmail.com>
References: <20260204213559.15659-1-malikovyehor@gmail.com>
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
index ae95e7e6b0..b73d3e75a9 100644
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
@@ -1198,11 +1200,8 @@ rte_vhost_driver_start(const char *path)
 			vsocket->extbuf, vsocket->linearbuf);
 
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
@@ -1210,3 +1209,18 @@ rte_vhost_driver_start(const char *path)
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
index 0b5d158fee..ad0588ef9f 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -27,6 +27,7 @@
 
 #define VHOST_VDUSE_API_VERSION 0
 #define VDUSE_CTRL_PATH "/dev/vduse/control"
+#define VDUSE_FDSET_NAME "vduse-evt"
 
 struct vduse {
 	struct fdset *fdset;
@@ -685,11 +686,8 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
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
@@ -942,3 +940,18 @@ vduse_device_destroy(const char *path)
 
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

