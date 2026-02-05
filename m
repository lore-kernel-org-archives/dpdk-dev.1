Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA024ECD996
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 18:35:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F35CB4279E;
	Thu,  5 Feb 2026 19:35:39 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id BC99842670
 for <dev@dpdk.org>; Thu,  5 Feb 2026 19:35:37 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12339e2e2c1so766805c88.1
 for <dev@dpdk.org>; Thu, 05 Feb 2026 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770316536; x=1770921336; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NifZ9PbbPwne9hO7ybB2mvddkrZ6Gyn3t/SNrweG64w=;
 b=SzqdpRquVuSs4V6ckj+mVtJifIipvU3z7PEhmUhxSoh+EnuyG+BBeK60IYLT0s2Q91
 zjroIvzG0niXNPs24UxZNCA/TYStCqnBeQ+b5MZJpoSBppjFeqUDOWdDZyyh/oD4s/pP
 K+nnigwwgfmOi+Kt5U2yLHZcpD9cOBjIyiqrfC0M3dwDMqh6kkOCg7G0WnLP2iOF/o0b
 +aZQFR9WfLpd3nfp0NCdDrV3y4n/GyciskJ3q6Bcc+OaRaZjfr5EVD5UxecchlAlh3Fc
 ZtHyxTj0Mp/f+3Y8CM9yg0SIGlMqyzaQTEhJLLlyD/Igj3TfRy5ppuVSzfcho1DAA56V
 e3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770316536; x=1770921336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NifZ9PbbPwne9hO7ybB2mvddkrZ6Gyn3t/SNrweG64w=;
 b=k/bbmmAs2GhwtxpSWPlEfwVHlKn1hQULU27zVceh+vAU6niBjgccu/E14xPK4FlaJ0
 qpr1u0XRG27YKseL08HOZUzbDGFSSZIws+EQ0S++XlcVMT+NfHnuWX6XrLK1T6eLyz5m
 WFkLRe5XjgWgjD5ZaXPV2/xLjBjzuDihAAAVlwfWylD/QtHCP6nAaxWFAtGVr6wW25zi
 V28yH//uE0/1KeBoOx+GVOTgkNWovS5iN6NlFFBU9Jms7lUu+8TOHmB9cCGGsQMw9/38
 C3fp/n2N1j2BHKD+YkUvgphZBAYOxBMAh/8b+kzTARFIDxzVtaO9UMlFT2fqCh2wA4li
 /XPQ==
X-Gm-Message-State: AOJu0YzpamyUdueCY6s9dEFThIevFBsRKarVtqRFIiZKUZ5PwSYPPiLj
 lqseQvbXcfATbm8Y6+FLTlMLx4H98dkXpPyL+HwqNTRcxAqABHBeV84832lWDw==
X-Gm-Gg: AZuq6aLdvK3PyltIW11gWWkea1Hekb82YxMz+WpCcHmjMiyFgGfGGQWB+T7orfiVzo1
 V9KMKHJF0kdf0CM4Hqaz5k0CK0pmyfDW9Ggq6jRTr+JMaR6N+dCiGTAt+rzhUWlpsSjxf+kQ3Nu
 fKz+KmB93xyV/GcYK6zfwarSpcImyN8KzIojC5Jsz4PDsyVwuF0EQtGffWCq98P3Iq7RIVIzR6b
 5zktHnnzBJD81w+oqf5VaUWQdH455INx/cwyL+ctgfK20OCCs6nMgB/rRVNNtp0y3SOlcSA7AsP
 TIARC4kLjd8Lx620oevreu52ASuVoJBd0ia90T6MM094C2dXjBwDfxjVbBjkzpZUwSTO6MpNIWk
 L0KyEDBAZR6etVl5GzZfwG5Oq1uqQCf13eo4O9AaaJogATnTpRhsDjJcm1jfAlCEA/EbF4XAgLn
 hJLA98xywTM4rOYWpIgzxsoO2zlYPDDjHFRlh4rvGZJPGrV6GLDA==
X-Received: by 2002:a05:7022:ba8:b0:11a:4ffb:984f with SMTP id
 a92af1059eb24-12703f45aeamr97270c88.11.1770316535955; 
 Thu, 05 Feb 2026 10:35:35 -0800 (PST)
Received: from C9HFQX6C61.corp.nandps.com ([130.41.236.144])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127041e5460sm36646c88.6.2026.02.05.10.35.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Feb 2026 10:35:35 -0800 (PST)
From: Yehor Malikov <malikovyehor@gmail.com>
To: dev@dpdk.org
Cc: maxime.coquelin@redhat.com, chenbox@nvidia.com, stephen@networkplumber.org,
 Yehor Malikov <Yehor.Malikov@solidigm.com>
Subject: [PATCH v9] vhost: fix use-after-free in fdset during shutdown
Date: Thu,  5 Feb 2026 19:35:29 +0100
Message-ID: <20260205183529.66909-1-malikovyehor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205183004.66631-1-malikovyehor@gmail.com>
References: <20260205183004.66631-1-malikovyehor@gmail.com>
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
rte_eal_cleanup() releases resources (like hugepages via
rte_eal_memory_detach) while the fdset thread is still running.
This race condition can lead to use-after-free errors if the thread
accesses memory that has been freed.

Standard destructors (RTE_FINI) run after rte_eal_cleanup() returns,
which is too late to prevent this race.

To address this, introduce a mechanism to register cleanup callbacks
that run within rte_eal_cleanup() before memory is detached:
1. Add rte_eal_cleanup_register() API to EAL.
2. Implement fdset_deinit() in vhost to synchronously stop the
   dispatch thread, close the epoll fd, and release resources.
3. Register the vhost cleanup handler during initialization to
   ensure proper shutdown ordering via EAL.

Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")

Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>
---
 .mailmap                            |  1 +
 lib/eal/common/eal_common_cleanup.c | 48 +++++++++++++++++++++++++++++
 lib/eal/common/eal_private.h        |  5 +++
 lib/eal/common/meson.build          |  1 +
 lib/eal/freebsd/eal.c               |  1 +
 lib/eal/include/rte_eal.h           | 15 +++++++++
 lib/eal/linux/eal.c                 |  1 +
 lib/eal/windows/eal.c               |  1 +
 lib/vhost/fd_man.c                  | 16 ++++++++++
 lib/vhost/fd_man.h                  |  1 +
 lib/vhost/rte_vhost.h               | 15 +++++++++
 lib/vhost/socket.c                  | 35 ++++++++++++++++++++-
 lib/vhost/vduse.c                   | 12 +++++++-
 lib/vhost/vduse.h                   |  1 +
 14 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 lib/eal/common/eal_common_cleanup.c

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
diff --git a/lib/eal/common/eal_common_cleanup.c b/lib/eal/common/eal_common_cleanup.c
new file mode 100644
index 0000000000..933484e254
--- /dev/null
+++ b/lib/eal/common/eal_common_cleanup.c
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Red Hat, Inc.
+ */
+
+#include <stdlib.h>
+#include <rte_spinlock.h>
+#include <rte_eal.h>
+
+#include <eal_export.h>
+#include "eal_private.h"
+
+#define MAX_CLEANUP_CALLBACKS 16
+
+static rte_eal_cleanup_callback_t cleanup_callbacks[MAX_CLEANUP_CALLBACKS];
+static int num_cleanup_callbacks;
+static rte_spinlock_t cleanup_lock = RTE_SPINLOCK_INITIALIZER;
+
+RTE_EXPORT_SYMBOL(rte_eal_cleanup_register)
+int
+rte_eal_cleanup_register(rte_eal_cleanup_callback_t callback)
+{
+	int ret = -1;
+
+	if (callback == NULL)
+		return -1;
+
+	rte_spinlock_lock(&cleanup_lock);
+	if (num_cleanup_callbacks < MAX_CLEANUP_CALLBACKS) {
+		cleanup_callbacks[num_cleanup_callbacks++] = callback;
+		ret = 0;
+	}
+	rte_spinlock_unlock(&cleanup_lock);
+
+	return ret;
+}
+
+void
+eal_cleanup_callbacks_run(void)
+{
+	int i;
+
+	rte_spinlock_lock(&cleanup_lock);
+	for (i = 0; i < num_cleanup_callbacks; i++) {
+		if (cleanup_callbacks[i] != NULL)
+			cleanup_callbacks[i]();
+	}
+	rte_spinlock_unlock(&cleanup_lock);
+}
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index e032dd10c9..3443960f13 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -479,6 +479,11 @@ struct rte_bus *rte_bus_find_by_device_name(const char *str);
  */
 int eal_bus_cleanup(void);
 
+/**
+ * Call all registered cleanup callbacks.
+ */
+void eal_cleanup_callbacks_run(void);
+
 /**
  * Create the unix channel for primary/secondary communication.
  *
diff --git a/lib/eal/common/meson.build b/lib/eal/common/meson.build
index e273745e93..c36a82c34b 100644
--- a/lib/eal/common/meson.build
+++ b/lib/eal/common/meson.build
@@ -8,6 +8,7 @@ cflags += [ '-DABI_VERSION="@0@"'.format(abi_version) ]
 sources += files(
         'eal_common_bus.c',
         'eal_common_class.c',
+        'eal_common_cleanup.c',
         'eal_common_config.c',
         'eal_common_debug.c',
         'eal_common_dev.c',
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 6215245ad5..fdb8927b2b 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -777,6 +777,7 @@ rte_eal_cleanup(void)
 
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	eal_cleanup_callbacks_run();
 	rte_service_finalize();
 	eal_bus_cleanup();
 	rte_mp_channel_cleanup();
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index 7241f3be5d..06d2820010 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -126,6 +126,21 @@ int rte_eal_init(int argc, char **argv);
  */
 int rte_eal_cleanup(void);
 
+/**
+ * Cleanup callback function type.
+ */
+typedef void (*rte_eal_cleanup_callback_t)(void);
+
+/**
+ * Register a function to be called during rte_eal_cleanup().
+ *
+ * @param callback
+ *   The cleanup callback function to register.
+ * @return
+ *   0 on success, -1 on failure.
+ */
+int rte_eal_cleanup_register(rte_eal_cleanup_callback_t callback);
+
 /**
  * Check if a primary process is currently alive
  *
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b12f325ddd..ba552f60c8 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -976,6 +976,7 @@ rte_eal_cleanup(void)
 			internal_conf->hugepage_file.unlink_existing)
 		rte_memseg_walk(mark_freeable, NULL);
 
+	eal_cleanup_callbacks_run();
 	rte_service_finalize();
 	eal_bus_cleanup();
 	vfio_mp_sync_cleanup();
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 21fe7cb1d9..3ac61bfd2a 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -142,6 +142,7 @@ rte_eal_cleanup(void)
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
+	eal_cleanup_callbacks_run();
 	eal_intr_thread_cancel();
 	eal_mem_virt2iova_cleanup();
 	eal_bus_cleanup();
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
index ae95e7e6b0..78d177e24b 100644
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
@@ -1210,3 +1212,34 @@ rte_vhost_driver_start(const char *path)
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
+static void
+vhost_cleanup_handler(void)
+{
+	rte_vhost_cleanup();
+}
+
+RTE_INIT(vhost_cleanup_register)
+{
+	if (rte_eal_cleanup_register(vhost_cleanup_handler) < 0)
+		RTE_LOG_LINE(ERR, VHOST_CONFIG, "Failed to register vhost cleanup");
+}
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 0b5d158fee..5c9e77f11e 100644
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
@@ -942,3 +943,12 @@ vduse_device_destroy(const char *path)
 
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

