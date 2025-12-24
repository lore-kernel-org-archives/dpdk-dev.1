Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B296E78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:14:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99FBE4068E;
	Wed, 24 Dec 2025 23:13:41 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 825604069F
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:40 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so3609195e9.3
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614420;
 x=1767219220; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1sGtg/iCWobLclY5oukVNQNXBwpSC/wmMRN8/BXXAAY=;
 b=zUQtK6d9k+d9AKo/3u6GSqayRSU7SH/MN291ZtYt+Z5mlUYZm0Be0PzhDoEl/sg2Ta
 0IA7fEwNLGEqAGEIYez7pzvMUSbC5itnT8bBfbCt6/u1gIOrywVeZl5vjFvcL0/2/upO
 HohaP0/D8yWxzuQzAPncezJu7c1tTvPy1RgH9LBxi11eCEJB/3FCU9A4EWVV1/xPphhm
 jI5g8IrAKXdklxiygMEk9tlNnV4y+lKv1PTbdTUySaKbPsQGelfxwnvR5rlCYlzBFTGx
 60nhYLVZrLgLEl7vvFBJVE6BY/CHzX2xWxyPGX8Rbjo1k91mCGuwFic0sr8PJRaenHwE
 9nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614420; x=1767219220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1sGtg/iCWobLclY5oukVNQNXBwpSC/wmMRN8/BXXAAY=;
 b=RH2tf/NXgzcshj+pFhcma3dWmVgtTDVC1JIKQ2QfACqqj9/gYok4He16JqGni3D+fc
 Fih0BH/SonBVZN1H3AbB6LFfLhkdmu0nso8Qtjk94a5tcdrSM6afHTIhIeOW/5hkwS7H
 YAvZEaxm27aptgQmAPK9MwQ0NUondVUDBqQ9aGb/FgCIPeQKS7+324gwfv+R11aJSYyq
 aUfxceLRIu7UC0o9c560tI6sYcq7xoPsQzveTUJXmjOcE7xWF+xk2Xblz+J0PvBS5mHA
 /HpXZUPi6wB3jGLcg+WTUOJ8mJygitiYPBaApB81FtJhNlNh/q6kRJFFnVRNOOzgHZ+q
 hkMw==
X-Gm-Message-State: AOJu0YzBHvpOGq/EUPTwcd9nDyk7hHRKinhVPQ046GMRqdKUoTxVLXFK
 JZHZkKyUsW06++7DKyI0lctqIUk0aVNd7LFk5JB1uHkov8L+kOydDoytnLUwsUsWTi4doLJYYGN
 VP5RppFY=
X-Gm-Gg: AY/fxX7MaYZnf9JyEC1A3BZqMeRQ8rpu8gJN0p0ivKRasBSLeU0WiZK33jz2A2PZx7s
 fTbXPIVRMEx9qyDybYi4m8gQQiwmxeooChBSRdOBzyxLmvYeOXDG2R+jWMM5ClnhDAuq3Q/sPY7
 +4QCD0Lo3a2DWuoevvtJ0THiJkl2Myi4A2mLQXPrs7wbrzxlAir5X+M1nXJKaNdwcUsJHqq3Fr8
 ILMuW5INNYq2IV9m95Fu2tzj2U9nCn4SmeJ7KB1cs1crC8EASFQcmFcmeEK2ypHySt+4cDZz5oM
 Zwg9Y9ISQusH1uRhiS31oUoAhaI2RdP7cAqOq3kXrFFbNspdgP0KAXHs+iao6rzBKPG8ONhQ6p+
 EkdqnnBXYgEqLcwDaBDG+7o960C4p7QvZOyq+prXpwVZYGX04/as34bFl9ZxJPUyyaVKLpZGvZP
 kcGz1MzLTMiF6deWPVjmv/6aQGvTEoUvOqqrdqY7zrg+ra2CuXJ32aCZ4rHaYU
X-Google-Smtp-Source: AGHT+IGtoI+shnDcdDpK/jg5vi3ETJWt3wTJQFByuQb6wIb0dBgqE/TKUc/0+cBfw7O7QYVutD1RAw==
X-Received: by 2002:a05:600c:64c5:b0:479:1348:c614 with SMTP id
 5b1f17b1804b1-47d1959e2b3mr186530055e9.26.1766614420076; 
 Wed, 24 Dec 2025 14:13:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 11/18] eal: limit maximum runtime directory and socket paths
Date: Wed, 24 Dec 2025 14:11:52 -0800
Message-ID: <20251224221301.52714-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

Linux has a limitation of 108 characters (including null character)
for AF_UNIX socket path. FreeBSD limit is smaller 104 characters
and Windows has same definition (108) in afunix.h header.

In current code, EAL will fail in telemetry, so this should
not break existing users.

 EAL: Multi-process socket /var/run/dpdk/x7Q9mP2a...
 EAL: Selected IOVA mode 'VA'
 TELEMETRY: Error with socket binding, path too long

Now long string fails on command line parsing:
 EAL: Runtime directory string too long
 EAL: Cannot create runtime directory
 EAL: Error parsing command line arguments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

