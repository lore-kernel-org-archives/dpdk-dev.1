Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E335D3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:20:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C812B40A6D;
	Sun, 28 Dec 2025 21:19:56 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 8503840647
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:53 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so54041405e9.3
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953193;
 x=1767557993; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1sGtg/iCWobLclY5oukVNQNXBwpSC/wmMRN8/BXXAAY=;
 b=wbF/ZU9A0PSVrK304IDwkAlHiatEZqTYN9nEM06LAVaCdT54Nx007wT05gUo6Hap1G
 8NS0X3Hj59gRHuCUk+nqXeZwzgtwOnvMxC2fTmfok5CHp3yTTNR/M3wUgp3TDlWXQ6Vz
 rqdBRSbov5IXADUorSzN4voakAoPmCcYTqUtPB81NVLis7gXxKEy5Hx7MdQKEJbWM88v
 s5lWKaT2ieqYhUBBolggzJi/rykIVFNU7su8WgO+v56bE2SOg8n5kKB8R194MICPct1y
 uGayEIP0WgV0s6oBKd0AMb6j2MZXd2SWHg8yjp/f5BiGxcL4KEXnNIvgLbRt1IPZhwqQ
 dS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953193; x=1767557993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1sGtg/iCWobLclY5oukVNQNXBwpSC/wmMRN8/BXXAAY=;
 b=chPlM9mFo1n0jX163kStr8I0AJI8FH2vk2HFFr2hdVkkcBI+qX6dOLvjvnrJ2ILPow
 9NFDPjAd/tSvKiWarbPycCx61Xs/wyQOMWpS76WH++V68mm2/WcJRNEZRB/fomjP8U/1
 Smfa0AW34+hGsSHO4Ht98kuCc21eHoA7w52QUd38/rPZiYFJrLnQGnjjCXOoPEf8WMrN
 aTJZ/CQ4YK/CMaCC6OL5OZ26sk2KHfgQKST6lOLHa4RoYGzX2KikRYiVJopi7WGZxRoz
 +GriEdAP4Bv3Fn+ZhtRPUTgThc60A3Ohp6n98XWkZIjLknqXhZekI0cXZaE+7Dq4Bs3z
 PdOg==
X-Gm-Message-State: AOJu0YzYfAuCOTfHWJ9h2Hau3lMggrJs9FnPdhMSVeo0cJIedQGJtkKp
 xGKiu7FEwu7WT9LmYS8SRd6sl5e+iWsPE1UYRbhQlP2H5zkKhiEg2BEgsLLKLX3x/0UOdip8QFd
 r6G46KMk=
X-Gm-Gg: AY/fxX6Qvdv+pU1Vj9xfxdxEa2EXfVO/peRK5EWL7xneLyj/niJHSWAmAILv+Sj1Xm3
 q47IpHNiED396goVzERsNySRp9VyUnps9zIh0m/rDFCOhzGiYuWWjJRUl8ecKjA/lOZAvBYwWIG
 NvOJ0rNGJKyCtBz2KMoKYyN74aOPZH5PFxNr64eTiQACnsvRfuoT55LJL7xNr9ofmmlD6gC1ic1
 UEqhfMrE+QNoad/8s5CmtOcLmW2uf9mCXHNfo0bogir2baW5rdpClHsJHWhqacDzo2SIZubOHQI
 eFEOY4bs6UMauqcmIsOBexDtubz0glGvzpss9hsGR16511Ogh+kbSG8DS03qFlwS/u+kzwVcnLD
 Rx1lPi9YJIpGxLX5gWnVfHDFgFCA2UORSa1Y3gcdtQkmJHS/GsxBFXOEiSus/hAmGy6v65c9xd0
 o0feEY4DygaczTK2EENQo39tUCaC6EXwx6XXOJiFzWxwtxllQCmGWKuuOOJnDD
X-Google-Smtp-Source: AGHT+IHNuYCiMn38Q9Qz976Fv9cPakAXZzmFHcaBjgtAIk533xJW0y5+Vv+ysBLiagEVSkhAhDcQwA==
X-Received: by 2002:a05:600c:524f:b0:479:3a88:de5e with SMTP id
 5b1f17b1804b1-47d19593ca8mr283670695e9.37.1766953193055; 
 Sun, 28 Dec 2025 12:19:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 11/18] eal: limit maximum runtime directory and socket paths
Date: Sun, 28 Dec 2025 10:56:14 -0800
Message-ID: <20251228201236.547268-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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

