Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEDED340A6
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:34:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEF0940FB5;
	Tue, 27 Jan 2026 17:33:26 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id DCCE9410E7
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:25 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so4402363f8f.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531605;
 x=1770136405; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cms/yEoCB+r3xOVJA6C3i0iJd3QBOxRVoBBOU66gAMo=;
 b=QUDg/IM9brh/n9DLseBf3PFNmEetj555ySD+sdfyBvfzBw5pPaSItp1gtCXU3YVjby
 k6y16v/LWv9arYmw22wlQd5Zhi3+2IbL6RFjVC1xe8ppwTJGxpPQA22GJxWGf+3HArtL
 DHaFhbkrZc31DxN8JgabYMdDeHCkr4NzcC7Tz5YJcU2eOQDsJZP2+NbkmhhL82JJ7yP3
 GHUniQbd7wrsWglhsKjPjf2xh3pGylL0VKyLnBjR6sKhPJUukkSCnkRI32tRaesUrJNN
 GDAlIE+79S3TVbTYdgHWmjbR77EAJadrFP2FGqH/4ROkRdUmU7TYQt14Ls3qmSSZpyaG
 DM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531605; x=1770136405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cms/yEoCB+r3xOVJA6C3i0iJd3QBOxRVoBBOU66gAMo=;
 b=VDW5MbDn9fLKjjHG4pbpLQ6GijYM9Lu6BWd6CfJ91W8sInBbStJfExqWO9xOuhFO3I
 zqOZ3XKbmcUG0aqfCypbWSra9QvwLn6vdu2DPgCS0lY9oEyZ5HAmzsHawwtt/bDpzimK
 uX7PEhnAsp9eZvUNT1D/O4HZDEov7X7FtlzRGtLEXUpTtZivmiGePMgJ6vsuPU2OTfoj
 A/r/gPS4QXPtLHVYpjwwNCs7Wan9kmLbYyK3NrEaE9FTlmnDMVxRam0RSKzb0jmC3zIt
 +Sp1EQ8bdLqTnwGKYA0hRvOpMUjRM8UhYCeeOAQGOguT2MGNpSW7ycbiHWppKPrprW07
 ONpQ==
X-Gm-Message-State: AOJu0YxGqtUGkssvS7J4kBcCJm53BDbn2xKd3XWFRbTMgB0ucpDxYQfK
 eKN/j+bi+pv0vduku++ODvZ/5moIBhnnrJNC++/+tcePDJt9GNJ7O7csl5uZOyXJ6QbYj+VACxw
 QHEbm
X-Gm-Gg: AZuq6aIzaFUIEAep/+hhQGFJWA4UxizZWfqpFheEAkNhUj5L6zBCcEuRlsSrFlFq/Bc
 e3jfJ/RjCx2JTO1PKR27cv17TWt/ljIBGzdpKxZpq56pGGbfBXYyDuObbkIDLxEXExbLM2m7Bx/
 Td1P9nNGR0bNGjk2ey/Jhwzokk+Srn2bc/set/qQt5a/VnVbw6oYGQBSmM2Orb8DrfhLcB3TqFY
 fV0bBgpdPZKCit7MAUSmfuS+cXS9AnoGwzyyY5WMlJGkMtVdwH/1pzcBAWwslbcqgEP/o5dUvEl
 spDwiEshdw8jnzF05/UXe/QF3UimKGZ8wPKIyIdjjlZVxw1CZpqolDBJlCyqvA9yY134eDzRU/q
 +K1CJhpxwkCwOgM30+9nh30qAJTTx43vlo8weWvlbpcQtQCJpWXhr0U2iaE7YIylBiv0F+hNJTQ
 2fCqP7pI6yftaLjmRlslq2C7jK7TzREFbzwSWv5u4/Su0v8DV/+g==
X-Received: by 2002:a5d:5d0a:0:b0:430:f68f:ee96 with SMTP id
 ffacd0b85a97d-435dd1c1cccmr3225305f8f.36.1769531605423; 
 Tue, 27 Jan 2026 08:33:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v13 10/17] eal: limit maximum runtime directory and socket
 paths
Date: Tue, 27 Jan 2026 08:30:24 -0800
Message-ID: <20260127163258.75566-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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
 lib/eal/common/eal_common_proc.c   | 85 +++++++++++++++++++-----------
 lib/eal/common/eal_filesystem.h    | 17 +++++-
 3 files changed, 74 insertions(+), 34 deletions(-)

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
index 62fd4ba88f..244d8a8d3f 100644
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
+/*
+ * Combine prefix and name(optional) to return unix domain socket path
+ * return the number of characters that would have been put into buffer.
+ */
+static int
+create_socket_path(const char *name, char *buf, size_t len)
 {
 	const char *prefix = eal_mp_socket_path();
 
 	if (strlen(name) > 0)
-		snprintf(buf, len, "%s_%s", prefix, name);
+		return snprintf(buf, len, "%s_%s", prefix, name);
 	else
-		strlcpy(buf, prefix, len);
+		return strlcpy(buf, prefix, len);
 }
 
 RTE_EXPORT_SYMBOL(rte_eal_primary_proc_alive)
@@ -565,24 +569,25 @@ async_reply_handle(void *arg)
 static int
 open_socket_fd(void)
 {
-	struct sockaddr_un un;
+	struct sockaddr_un un = { .sun_family = AF_UNIX };
 
 	peer_name[0] = '\0';
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
 		snprintf(peer_name, sizeof(peer_name),
 				"%d_%"PRIx64, getpid(), rte_rdtsc());
 
+	if (create_socket_path(peer_name, un.sun_path, sizeof(un.sun_path))
+	    >= (int)sizeof(un.sun_path)) {
+		EAL_LOG(ERR, "peer '%s' socket path too long", peer_name);
+		return -1;
+	}
+
 	mp_fd = socket(AF_UNIX, SOCK_DGRAM, 0);
 	if (mp_fd < 0) {
 		EAL_LOG(ERR, "failed to create unix socket");
 		return -1;
 	}
 
-	memset(&un, 0, sizeof(un));
-	un.sun_family = AF_UNIX;
-
-	create_socket_path(peer_name, un.sun_path, sizeof(un.sun_path));
-
 	unlink(un.sun_path); /* May still exist since last run */
 
 	if (bind(mp_fd, (struct sockaddr *)&un, sizeof(un)) < 0) {
@@ -599,17 +604,20 @@ open_socket_fd(void)
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
+		EAL_LOG(ERR, "file prefix path for peer '%s' too long", peer_name);
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
@@ -624,7 +632,12 @@ rte_mp_channel_init(void)
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
 
@@ -779,14 +792,17 @@ mp_send(struct rte_mp_msg *msg, const char *peer, int type)
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
@@ -1055,13 +1071,18 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 
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
@@ -1200,15 +1221,17 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
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
index 5d21f07c20..70ae21b078 100644
--- a/lib/eal/common/eal_filesystem.h
+++ b/lib/eal/common/eal_filesystem.h
@@ -45,10 +45,25 @@ eal_runtime_config_path(void)
 
 /** Path of primary/secondary communication unix socket file. */
 #define MP_SOCKET_FNAME "mp_socket"
+
+#ifdef RTE_EXEC_ENV_WINDOWS
+/*
+ * UNIX_PATH_MAX is defined in afunux.h but that file is not in MingGW 9
+ * which is the version in Ubuntu 22.04, in future this can change.
+ * Also, Unix domain sockets are not uses in DPDK on Windows (yet).
+ */
+#define UNIX_PATH_MAX 108
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

