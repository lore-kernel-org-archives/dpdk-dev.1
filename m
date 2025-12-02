Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58182D1171A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 17:27:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09D3940674;
	Tue,  2 Dec 2025 18:26:44 +0100 (CET)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 5B3F14066D
 for <dev@dpdk.org>; Tue,  2 Dec 2025 18:26:42 +0100 (CET)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-8a3eac7ca30so365574685a.2
 for <dev@dpdk.org>; Tue, 02 Dec 2025 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764696402;
 x=1765301202; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8Rn2az/yLenihgJjeCSBz8tUh9b/BCaG1tRqhYAhB0=;
 b=vl2cbvIkzPQmXhIXQLSkmXftH1j66xunm06QQF3CfNxc4ieNZo/O9xr64eGGd2nVxi
 Q/tTlT3we7YVDdaeIguqziVQaiTNZmq2IXxeJRvwLLVgBFoonI48s6/wSCPGIZp5Pyos
 ujwafyPh2yumecipFd9xLEEGPfFUoX1x8XOVqBoDLi7RivznhjFrRN3NT7AwSY1FRBPe
 2DMLwrWgqWNYQpMwm7FvWzi2U1jW4og2Qo1NVqc0CJtLUKOjTKWIcXYOXC9Da0Nc9tvx
 ZYzkyNen9QnWmXDlh6CJc0kenQTfs/mhPDgzUeDdiDF5u/kWSupYHCrLUMpHrhSWkoOL
 P2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764696402; x=1765301202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O8Rn2az/yLenihgJjeCSBz8tUh9b/BCaG1tRqhYAhB0=;
 b=AajRXNOR2Q6DSS5sTrw12PlbUJBeRLExNSMIt3Oe1hNneO6sMazq4384YOm4C0JHJ5
 33CX0EPVeHfHH5O+KNRCYc9DeMiiM3PJwHrPZYKE14XtKCHPi1BqzE+I5yo4/IKcQzVP
 SQNYbXS6nnbIY5t678+S2vJB8Tc5SPLsQ/Ffuc4emai03FJFztY9RclJ6hPUo478eME7
 K4yHT/LGWCHloj90eoOsBI/bLHGYDXTamSmskRFGpqY8JKl2/cbuVVqjc0bahVkgTBpD
 UHCG7moCRUBgx1hrVynp4mkEyTM2CzcU7+2NdNrb/L9zS0xVCyBoO7zWWycR1wnsqSV0
 gkOA==
X-Gm-Message-State: AOJu0Ywcc71m81U35MK7AKyDAhftGC5Jkr2CWE3ejk6AjhVtf3bAchJn
 d0VkQ6k1EjvWrjWWaUc9RP5BSGJVxvnZCkp3VflWH6EfRJCmuSp6dE4caZjabkSXHghXWVkOT6r
 uIp+A
X-Gm-Gg: ASbGnctJwSmh53wxmbugD81ONVwdh7EonhZjiXhJq01OEIJcvG75X4OhM5kgOETFqcn
 3IbqQ2S6kC910GaOjop57t8v/CMsIHHGLs4H9pXRtw6qLS2vnW2TEnhkXZKG1usVWc8a2LvHZFJ
 EB8ca4o8JhjwGOPOi3RXpGglxSIe1gFHx8E6u3hy65ZciqPt520vY5U8uK0TctK2hbvhm5V2Eik
 EmXorNI5fq1EWB/IvF7Q89hUvIg9B1vY7HKti28d3X+6+xpmvhuJjTbaEWzPRTSOp/OwjNDM2hd
 N4rrkjks9ZB6wK7XMjQTqhVJSlgC4TAnv2fdl6Dv3UO1uSlEh2PnMdvewa75yEqV+XP6S1VZ1xc
 BymWyJXEe8a8T3Sy9i+NMF4Ml3PiNVxSXW6qhnrpYRpao19eEAkFAgU8/kjOgRWaWJfAp85EzRb
 sFD8VgzIUfOIXy8pj+zDaCN0Zs8MBZHvU1knJJVNq6S+uAl0W41A==
X-Google-Smtp-Source: AGHT+IF5MWH/12FiFu4quPMKoMFeg9PLsILbG+BIowjoYfzymRz9NoJqN6l8rMaPp5ZzBKH8rxowTw==
X-Received: by 2002:a05:620a:390b:b0:89e:a9ea:a374 with SMTP id
 af79cd13be357-8b4ebdad207mr3916689085a.67.1764696401518; 
 Tue, 02 Dec 2025 09:26:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1c8405sm1113724885a.38.2025.12.02.09.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:26:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC 8/8] eal: limit maximum runtime directory and socket paths
Date: Tue,  2 Dec 2025 09:24:34 -0800
Message-ID: <20251202172626.283094-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202172626.283094-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
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
 lib/eal/common/eal_common_config.c |  6 ++++--
 lib/eal/common/eal_common_proc.c   | 18 +++++++++---------
 lib/eal/common/eal_filesystem.h    |  6 +++++-
 3 files changed, 18 insertions(+), 12 deletions(-)

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
index 62fd4ba88f..3c4a1850ff 100644
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
@@ -599,7 +599,7 @@ open_socket_fd(void)
 static void
 close_socket_fd(int fd)
 {
-	char path[PATH_MAX];
+	char path[UNIX_PATH_MAX];
 
 	close(fd);
 	create_socket_path(peer_name, path, sizeof(path));
@@ -609,7 +609,7 @@ close_socket_fd(int fd)
 int
 rte_mp_channel_init(void)
 {
-	char path[PATH_MAX];
+	char path[UNIX_PATH_MAX];
 	int dir_fd;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
@@ -779,7 +779,7 @@ mp_send(struct rte_mp_msg *msg, const char *peer, int type)
 	}
 
 	while ((ent = readdir(mp_dir))) {
-		char path[PATH_MAX];
+		char path[UNIX_PATH_MAX];
 
 		if (fnmatch(mp_filter, ent->d_name, 0) != 0)
 			continue;
@@ -1055,7 +1055,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 
 	pthread_mutex_lock(&pending_requests.lock);
 	while ((ent = readdir(mp_dir))) {
-		char path[PATH_MAX];
+		char path[UNIX_PATH_MAX];
 
 		if (fnmatch(mp_filter, ent->d_name, 0) != 0)
 			continue;
@@ -1200,7 +1200,7 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	}
 
 	while ((ent = readdir(mp_dir))) {
-		char path[PATH_MAX];
+		char path[UNIX_PATH_MAX];
 
 		if (fnmatch(mp_filter, ent->d_name, 0) != 0)
 			continue;
diff --git a/lib/eal/common/eal_filesystem.h b/lib/eal/common/eal_filesystem.h
index 5d21f07c20..5371d9f1d6 100644
--- a/lib/eal/common/eal_filesystem.h
+++ b/lib/eal/common/eal_filesystem.h
@@ -45,10 +45,14 @@ eal_runtime_config_path(void)
 
 /** Path of primary/secondary communication unix socket file. */
 #define MP_SOCKET_FNAME "mp_socket"
+
+/** Maximum length of unix domain socket path as defined in sys/un.h */
+#define UNIX_PATH_MAX 108
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

