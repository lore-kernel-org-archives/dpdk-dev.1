Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC51DD3749B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:16:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 753814065E;
	Fri,  5 Dec 2025 21:16:04 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 1C27A40669
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:16:03 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso24729555e9.0
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965763;
 x=1765570563; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7uwZ10CzXnfZvCQJd4cwb0bomysP8yYpPv+9FoIiEk=;
 b=MbeYGEqR1uwhK/aDIN14tfmUkmde4nkqDr5GiGcDOkQqn3CnDKzlERQJ/Zl7D8/QwH
 dmsiD/IyuuR7Oc/5OGk7Jcri63XNOQufMry1FwXFMZK584vmKk0A3pRNsw33vgI0mjB5
 YRsSXcrb6SRQ6ubJqYPMMxyYjDs1g6tn8M8A03UKgOOCRGs3PGPVlXaAUdLX9lsbxLmC
 J/GPRU74IrJ3JpwJdCNdNZ3PqWwAURkJ/1lxch9GiU/m2hiOZmISKoQ6Lw3J6ymoIrni
 7cq6Nu7rrHNssbRjd/4wV5s4jmDQ7OrzSjksXYus5ymfFFlORX478UGDebAa6wJGiBMM
 BvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965763; x=1765570563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R7uwZ10CzXnfZvCQJd4cwb0bomysP8yYpPv+9FoIiEk=;
 b=j634j+ajm6rkScHDJtJMyIm0woL8VUjeInr/VGJnADrH5ti5DbG72nepDm0XcudlXG
 wzFRM6ZfweCKrUf4LEnZvDB0bIpVzB4gFD/3g/9QJDhG5IdE8tGS1rHmTAlo/K5DLkcn
 eTpg4MNfamC06uG2q9x4GHbGDHfQw3zYVjE9e03JikToD92V2QtlNIMXt87G67IKRmi8
 JUGtDvmKJO9R4i06O7nWNxmD0ASJVIP8bbtPPrDcen0M3L8ynrU6CcwjCJ6k8PXejK4M
 b2rg8y91/AaanNwDxsdYWVwkRjbnV0GAxrW6p0pE4CdPNenlU+qycpGHeontM6qjldw3
 ZlQw==
X-Gm-Message-State: AOJu0Yy+UgVuUu/mXBvftsKAL/wnvgTHbMM4iG9OSehFT9ewVACfPogd
 HRaQdMfuvQ50ho9oWGUy1M1jtyOYP81WV+qY48NNiQtXi+aBFoyzy+n10l7vgj83O60WThG7wBC
 gWh2J
X-Gm-Gg: ASbGnct9uWJLw3SlF26SRNixHpsmI1DDnXpo+PJjGHpqD4uPgpkIG1sixPOvlrq/7re
 a9Q5Y/GhWRZnKvS2zF0bOM9O98dRQHpZyJ6v1fPkc4ff3H0XmBRUhCdLmqmktmrRiZx+eEE6Ara
 rPzxuVCyOpE9TUC/KPolk29RjAqX6MAmYjQ/DmF7nTmaIIibvgznUBp8MuktomUj3q6LUldIDaZ
 6MJRW+bb7hsgR+lGfiHvXhb1Ui2D/Wz0hQ/xeMn55HqthJJ9PMg3LKpc/Fj4Coz1XLxRNXkJMrI
 DVzcQvpWcgPEl/PlnNjSptVoW9DaxK+In0nrPfG60hiiKeAdhw73MmWehG/ZJhcI7lS2LWLrl+S
 yBk0jiTM1Ny9m1FJ2yhpN+nFiu6CfwfnVwIB3dnIbun852XJDW8fDwy/5IcHVfu2KkA0EskP3D7
 LjzqFt8QOGmrUClC+vaz49LABar+aJvOCeSk1LGEzlTxa7l0t5yA==
X-Google-Smtp-Source: AGHT+IGwEFW+P2RuiB4uZMdYV+yIff6uhzkccBRmJDXAjyvpbSyxftFJh4UFDgkvZS85k+3znIXi+Q==
X-Received: by 2002:a7b:ce95:0:b0:479:3a8e:c85c with SMTP id
 5b1f17b1804b1-4793a8ec9f5mr893545e9.18.1764965762276; 
 Fri, 05 Dec 2025 12:16:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:16:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 10/16] eal: limit maximum runtime directory and socket paths
Date: Fri,  5 Dec 2025 12:11:39 -0800
Message-ID: <20251205201537.251131-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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
 lib/eal/common/eal_filesystem.h    |  7 ++-
 3 files changed, 64 insertions(+), 32 deletions(-)

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
index 5d21f07c20..ce52babb7f 100644
--- a/lib/eal/common/eal_filesystem.h
+++ b/lib/eal/common/eal_filesystem.h
@@ -17,6 +17,7 @@
 #include <limits.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <sys/un.h>
 
 #include <rte_string_fns.h>
 #include "eal_internal_cfg.h"
@@ -45,10 +46,14 @@ eal_runtime_config_path(void)
 
 /** Path of primary/secondary communication unix socket file. */
 #define MP_SOCKET_FNAME "mp_socket"
+
+/** Maximum length of unix domain socket path. */
+#define UNIX_PATH_MAX (sizeof(((struct sockaddr_un *)0)->sun_path))
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

