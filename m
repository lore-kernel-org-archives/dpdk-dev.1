Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31392D3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1C4A4066A;
	Sat,  6 Dec 2025 19:44:36 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 936044066A
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:35 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso39127085e9.3
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046675;
 x=1765651475; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lx+L4kp/NUgLqm749CDYZhsFfP5jPRUjRQ5l+i6C6Co=;
 b=2H2r3isrQbtbyRKMKE3oF5CHDcfe1VcyIpIe1+efk/DIhA3yBMsRLDweGzjj0A1KRF
 ivCsQkMqctZI35qZlZRcm2nvNhICE5RTpN5gNuFJgrBrz2lBn7jeWQYSvQHz0ui/AlWe
 gAuKhk+k6D7NJuCSOFYLKReXZxe8Ey3dGA51yhmi1SqAzmkjZgJ0rxgDGRuMmHuN7IjN
 u4BlMIY3BHL831tOZ9l8boJrDpYUVZ2tUwWJ+yBX4g+FHFYSYeOysOKNkp4+9FWMGR7c
 guITykwNTeZuA9NP/GuTwpqKkF66Etb57rIfdsefqX7cURS0RLHHP9awJt9omAzEcsK9
 X3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046675; x=1765651475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lx+L4kp/NUgLqm749CDYZhsFfP5jPRUjRQ5l+i6C6Co=;
 b=aLXlILaCcHi56DmZIHhGofVaG3b8JCeUWpxW8IOTogjgl6F7AXuga55xOZAoEqnBhX
 FyDpzprpigtvb6gS94616KIWBs9FAqoWVETZqo84RO3x5V68wbJuRt9rswJrx6LIeyU8
 u4NlhPlsh/t/rfyMhocnB84dJitKsYUyLXOuXn4DtElITUku5S7rMjWbYsZhzcMyGmuD
 Jx3AmcJqu12J5iSdeSM7cfBsR1YaWlThih0un6fnFAZ9fl66dyLyZk20hcOWGQQk5KLz
 kaSPjqxJ7W4owNG3xO0l4E/LkxCy3fpOq+DKmiOVaKB8D/nG1AbVRKKyEx5xmbAXajTk
 nnQQ==
X-Gm-Message-State: AOJu0YxBWdQoniqPVkq4320SFnNUa0NEyfNIzeDkcR+b6xejJcg5Ijtm
 53qRw9EoMXy9yZKD/Es266vTaPD8levf/LVdmWo1p4WsrzTKvksmJyw4JL2Oz2S5+HO5dOkclDp
 lrX3V
X-Gm-Gg: ASbGnctcOLHAiQ4bzGvf+H8ZpWO/HMV1eW2MVF3S3m5EBTeUMWAKCi0e+ioF2ii2S2s
 EPASNv4Ec51V68w4Fw+9k/NXxP1fJnrunRlT+k1LCgSdzgcw9V/+QEOqT0heZKfPzNF+zyTppMB
 yz+WVM3LEXnXwEardjnOYFKZplxgtVMsDVU5ZRVEAilshTyg9+w+V9HWTK05YQmgQpkoDo/aO0c
 FT40dT0skzWHtuSgI5MQv4lGXRHyVs7J98lrMJmee50wd54gDYSrpepTbZW/UvlqxpgK2epN5ao
 xplZ5qG1sxt+YnwxeDgRxja3Bn0iU3hwFOAc7wHu29hXdIP8iiJMPnm3D14+tiv/6r8UJ1ERVox
 ob5l+JLmWjyc5vhM7FN3NQN1jIb1htcOUoLCInb4Id3u25BwtRNiSLpAD1ZSsWvwDbF6CPa8ZdV
 jjIkvg68YvFaN6/HoBrUgs3EwY39gshSa3HqB9PhNTH9EYB9t8Gh+i8cz45I4s
X-Google-Smtp-Source: AGHT+IE1yVjpLTwKt7T6HRdFMZynfzrftVTQzcGicNcSjBniMhNofRrv9cI3pdHagCPzSjxM1vfrQg==
X-Received: by 2002:a05:600c:1d01:b0:477:abea:9023 with SMTP id
 5b1f17b1804b1-47939dfa0e3mr32266375e9.9.1765046675174; 
 Sat, 06 Dec 2025 10:44:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 10/16] eal: limit maximum runtime directory and socket paths
Date: Sat,  6 Dec 2025 10:43:11 -0800
Message-ID: <20251206184410.542725-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

Linux (and FreeBSD) has a limitation of 108 characters for
any unix domain socket path. Therefore DPDK would not work
if a really large runtime directory was used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_config.c |  6 ++-
 lib/eal/common/eal_common_proc.c   | 83 +++++++++++++++++++-----------
 lib/eal/common/eal_filesystem.h    | 13 ++++-
 3 files changed, 70 insertions(+), 32 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 7fc7611a07..e2e69a75fb 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -6,6 +6,7 @@
 
 #include <eal_export.h>
 #include "eal_private.h"
+#include "eal_filesystem.h"
 #include "eal_memcfg.h"
 
 /* early configuration structure, when memory config is not mmapped */
@@ -24,7 +25,7 @@ static struct rte_config rte_config = {
 };
 
 /* platform-specific runtime dir */
-static char runtime_dir[PATH_MAX];
+static char runtime_dir[UNIX_PATH_MAX];
 
 /* internal configuration */
 static struct internal_config internal_config;
@@ -39,7 +40,8 @@ rte_eal_get_runtime_dir(void)
 int
 eal_set_runtime_dir(const char *run_dir)
 {
-	if (strlcpy(runtime_dir, run_dir, PATH_MAX) >= PATH_MAX) {
+	/* runtime directory limited by maximum allowable unix domain socket */
+	if (strlcpy(runtime_dir, run_dir, UNIX_PATH_MAX) >= UNIX_PATH_MAX) {
 		EAL_LOG(ERR, "Runtime directory string too long");
 		return -1;
 	}
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 62fd4ba88f..dbf749c5b8 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -36,10 +36,10 @@
 
 static RTE_ATOMIC(int) mp_fd = -1;
 static rte_thread_t mp_handle_tid;
-static char mp_filter[PATH_MAX];   /* Filter for secondary process sockets */
-static char mp_dir_path[PATH_MAX]; /* The directory path for all mp sockets */
+static char mp_filter[UNIX_PATH_MAX];   /* Filter for secondary process sockets */
+static char mp_dir_path[UNIX_PATH_MAX]; /* The directory path for all mp sockets */
 static pthread_mutex_t mp_mutex_action = PTHREAD_MUTEX_INITIALIZER;
-static char peer_name[PATH_MAX];
+static char peer_name[UNIX_PATH_MAX];
 
 struct action_entry {
 	TAILQ_ENTRY(action_entry) next;
@@ -78,7 +78,7 @@ struct pending_request {
 		REQUEST_TYPE_SYNC,
 		REQUEST_TYPE_ASYNC
 	} type;
-	char dst[PATH_MAX];
+	char dst[UNIX_PATH_MAX];
 	struct rte_mp_msg *request;
 	struct rte_mp_msg *reply;
 	int reply_received;
@@ -132,15 +132,19 @@ find_pending_request(const char *dst, const char *act_name)
 	return r;
 }
 
-static void
-create_socket_path(const char *name, char *buf, int len)
+static int
+create_socket_path(const char *name, char *buf, size_t len)
 {
 	const char *prefix = eal_mp_socket_path();
 
-	if (strlen(name) > 0)
-		snprintf(buf, len, "%s_%s", prefix, name);
-	else
-		strlcpy(buf, prefix, len);
+	if (strlen(name) > 0) {
+		if (snprintf(buf, len, "%s_%s", prefix, name) >= (int)len)
+			return -1;
+	} else {
+		if (strlcpy(buf, prefix, len) >= len)
+			return -1;
+	}
+	return 0;
 }
 
 RTE_EXPORT_SYMBOL(rte_eal_primary_proc_alive)
@@ -572,6 +576,11 @@ open_socket_fd(void)
 		snprintf(peer_name, sizeof(peer_name),
 				"%d_%"PRIx64, getpid(), rte_rdtsc());
 
+	if (create_socket_path(peer_name, un.sun_path, sizeof(un.sun_path)) < 0) {
+		EAL_LOG(ERR, "peer '%s' socket path too long", peer_name);
+		return -1;
+	}
+
 	mp_fd = socket(AF_UNIX, SOCK_DGRAM, 0);
 	if (mp_fd < 0) {
 		EAL_LOG(ERR, "failed to create unix socket");
@@ -581,8 +590,6 @@ open_socket_fd(void)
 	memset(&un, 0, sizeof(un));
 	un.sun_family = AF_UNIX;
 
-	create_socket_path(peer_name, un.sun_path, sizeof(un.sun_path));
-
 	unlink(un.sun_path); /* May still exist since last run */
 
 	if (bind(mp_fd, (struct sockaddr *)&un, sizeof(un)) < 0) {
@@ -599,17 +606,20 @@ open_socket_fd(void)
 static void
 close_socket_fd(int fd)
 {
-	char path[PATH_MAX];
+	char path[UNIX_PATH_MAX];
 
 	close(fd);
-	create_socket_path(peer_name, path, sizeof(path));
-	unlink(path);
+
+	if (create_socket_path(peer_name, path, sizeof(path)) < 0)
+		EAL_LOG(ERR, "file prefix path for peerr '%s' too long", peer_name);
+	else
+		unlink(path);
 }
 
 int
 rte_mp_channel_init(void)
 {
-	char path[PATH_MAX];
+	char path[UNIX_PATH_MAX];
 	int dir_fd;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
@@ -624,7 +634,12 @@ rte_mp_channel_init(void)
 	}
 
 	/* create filter path */
-	create_socket_path("*", path, sizeof(path));
+	if (create_socket_path("*", path, sizeof(path)) < 0) {
+		EAL_LOG(ERR, "file prefix path too long");
+		rte_errno = ENAMETOOLONG;
+		return -1;
+	}
+
 	rte_basename(path, mp_filter, sizeof(mp_filter));
 	strlcpy(mp_dir_path, dirname(path), sizeof(mp_dir_path));
 
@@ -779,14 +794,17 @@ mp_send(struct rte_mp_msg *msg, const char *peer, int type)
 	}
 
 	while ((ent = readdir(mp_dir))) {
-		char path[PATH_MAX];
+		char path[UNIX_PATH_MAX];
 
 		if (fnmatch(mp_filter, ent->d_name, 0) != 0)
 			continue;
 
-		snprintf(path, sizeof(path), "%s/%s", mp_dir_path,
-			 ent->d_name);
-		if (send_msg(path, msg, type) < 0)
+		if (snprintf(path, sizeof(path), "%s/%s",
+			     mp_dir_path, ent->d_name) >= (int)sizeof(path)) {
+			EAL_LOG(ERR, "Unix domain path %s/%s too long",
+				mp_dir_path, ent->d_name);
+			ret = -1;
+		} else if (send_msg(path, msg, type) < 0)
 			ret = -1;
 	}
 	/* unlock the dir */
@@ -1055,13 +1073,18 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 
 	pthread_mutex_lock(&pending_requests.lock);
 	while ((ent = readdir(mp_dir))) {
-		char path[PATH_MAX];
+		char path[UNIX_PATH_MAX];
 
 		if (fnmatch(mp_filter, ent->d_name, 0) != 0)
 			continue;
 
-		snprintf(path, sizeof(path), "%s/%s", mp_dir_path,
-			 ent->d_name);
+		if (snprintf(path, sizeof(path), "%s/%s",
+			     mp_dir_path, ent->d_name) >= (int)sizeof(path)) {
+			EAL_LOG(ERR, "Unix domain socket path '%s/%s' too long",
+				mp_dir_path, ent->d_name);
+			rte_errno = ENAMETOOLONG;
+			goto unlock_end;
+		}
 
 		/* unlocks the mutex while waiting for response,
 		 * locks on receive
@@ -1200,15 +1223,17 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	}
 
 	while ((ent = readdir(mp_dir))) {
-		char path[PATH_MAX];
+		char path[UNIX_PATH_MAX];
 
 		if (fnmatch(mp_filter, ent->d_name, 0) != 0)
 			continue;
 
-		snprintf(path, sizeof(path), "%s/%s", mp_dir_path,
-			 ent->d_name);
-
-		if (mp_request_async(path, copy, param, ts))
+		if (snprintf(path, sizeof(path), "%s/%s",
+			     mp_dir_path, ent->d_name) >= (int)sizeof(path)) {
+			EAL_LOG(ERR, "Unix domain path %s/%s too long",
+				mp_dir_path, ent->d_name);
+			ret = -1;
+		} else if (mp_request_async(path, copy, param, ts))
 			ret = -1;
 	}
 	/* if we didn't send anything, put dummy request on the queue */
diff --git a/lib/eal/common/eal_filesystem.h b/lib/eal/common/eal_filesystem.h
index 5d21f07c20..2de88d7cc2 100644
--- a/lib/eal/common/eal_filesystem.h
+++ b/lib/eal/common/eal_filesystem.h
@@ -45,10 +45,21 @@ eal_runtime_config_path(void)
 
 /** Path of primary/secondary communication unix socket file. */
 #define MP_SOCKET_FNAME "mp_socket"
+
+#ifdef RTE_EXEC_ENV_WINDOWS
+#include <winsock2.h>
+#include <afunix.h>
+#else
+#include <sys/un.h>
+
+/** Maximum length of unix domain socket path. */
+#define UNIX_PATH_MAX (sizeof(((struct sockaddr_un *)0)->sun_path))
+#endif
+
 static inline const char *
 eal_mp_socket_path(void)
 {
-	static char buffer[PATH_MAX]; /* static so auto-zeroed */
+	static char buffer[UNIX_PATH_MAX]; /* static so auto-zeroed */
 
 	snprintf(buffer, sizeof(buffer), "%s/%s", rte_eal_get_runtime_dir(),
 			MP_SOCKET_FNAME);
-- 
2.51.0

