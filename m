Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8F606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=cBLBPquo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SpyQFG6l
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6893440265;
	Tue,  3 Nov 2026 18:05:13 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTPS id 217E9400D6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 18:05:12 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 15D5914000B2
 for <dev@dpdk.org>; Tue,  3 Nov 2026 12:05:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 03 Nov 2026 12:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1793725511; x=1793811911; bh=UvtjayhLguikuJBAei3kI
 yFBZ0vfmHSIDB+Sw1eJ/l4=; b=cBLBPquo1rZSBUYV6V3vSNtYQva8UN8CMkNlK
 vAXxml1i7Sip/8xWI5WF5ORpooksvIYbh3GvJfoyJrfKuMSe8yITwJcPmtU6LAcR
 pGQrUIVPWtAGQetvn2qkXJzRvjfSxclIH2oUU8yWqWLpLe9bW8HH6EA/jHKlHxXu
 RWrFWV2/VtZBx4/Zi9MVRXdh1FZgTJhJlj/DlbS/MMnx324qykzDh3TsK7oMbjIJ
 35ev4L8aXV4WsEzPuH6p8+YNDPxT1p33uLT7AdtaBKNHymRQyNJhzaqk7aADVWFF
 6K8RfvWStTKCvCNFJHBx8tUY8bJfpqJZtPrUKp/6H2agjXYuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1793725511; x=1793811911; bh=UvtjayhLguikuJBAei3kIyFBZ0vfmHSIDB+
 Sw1eJ/l4=; b=SpyQFG6lcbz52+dJZydxoehujEtmeV8MlJFCLW9Sdw+awXYA6fE
 zh45o/ZYudUrLFexJsoaK5X9Uq/TbUbC326JWHZc7iXPgphAj0P5qOhiyiWvIhoV
 Fn1J7kJfwtKoLGMzxaxQuL97/9d1TX9VFUdEVbFG86SHu81Vv5p/KeJO2dBqcyfB
 x6elsOyRLQYi/CBrqRxZWnMjEOinJBygq+uYk3h43/LEuqvcCTnmFNcd7+uXh9yF
 YqK1/c4NmrNEjEntAEhRIRgxn6pFThQ1pfCepbQzUHyS8WVjkO+zjlZVuRrRD7Ru
 QCTtISZWOltlG6UvRWRx4DmJVdDgkypBXeg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793725511; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:xDDyffWkshN/WCHkh78P6eHVUCtmAIprnb69V3152Nc0QOt
 0GmQGsZW7nf0ygHHBrim5ax74cU8NVdi+dn7JsETTfs/CypMvqfdvXHxkTWjG988
 p6Jg6dIVhibNdGUvC355+2FbxqgNP7WJkxqkQJiR201/70F6z0Ja4U0bqyubrbmK
 1uoGRdCiSYMyatgxzgMeFzMDul6YP5jaMNriRwXAPuR0W1n3w7BYTP9S4mOeozjB
 469MnQa1RqfnnMteK57+sImNy+wsseI6Lvm+Z7bA7Sanulid6tn3BAdzQV889yca
 79BCWM2JfzWgBMf6wQEDodxvZO0EWL6WJb0mCWQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:8r03nOjyGpQdZcfcORTjSVmrAbBEAqNUddRbromuSPU=:P+YJN6xfL9sjLckTtpRAGdE/dloVqfrjw7Sg7hEqzJA=;
X-ME-Sender: <xms:RhTqaqfxIHVoS1jzg-2xf3OXEtN6Pu_hHvYgMNJHi41AGj7Uw8b0iA>
 <xme:RhTqavIMR5-Vgm_m1Tj83NUb3AfVTn6yaOfSM5mssJ9RNW-HwB06zfDq0T0vNuYzL
 dxwaVHTZHL4LjYk74unNe4sTEiBKqnEchVQXh9hyWbjoFAvYq5-EE4>
X-ME-Received: <xmr:RhTqaqhlAoB_3ZNb78VigV0GE9J9Qdrtptx-BKCY81A1bMdQZ-_aHx3320yUvWbTeMzAMgrlPvrLt9WzoJMjfP0UDp7u>
X-ME-Proxy-Cause: dmFkZTEcTHfOTM027UNTo5yQHBTIfZi25lofU0iPN5Snor154zd6NaOusGRQ4i9horxA7D
 6V7VS985tthx2TyGu8yMiqhDD5UQw+E5ntoHPzx0XtTgKV6nZkXmP6jm0G9Dlf6fhy+VYp
 ThVDLN6LVn7KYAHFZLtUSu9/Ow8+7frV+lS9c+EYd2VoMoqAkkGi93PT88uMsRIWUlgWZZ
 9eEjrydeZD/cJUcxd/z71z+8rFIj32DgWJofguPQXS4/+eHthYhX3vfpKtdigbkxbo94JE
 OOeS1XgKVhibiD1uWChD53bsKwv3HH4/vc+fwQUZq3Y84KKCS7iWxyPkPyf03J8a4Z7xoG
 Cbjn3kaXvB3WMiTXC6iiAXFF0VH7Ev42hxiQ6eIGx7QXXTtfG/5z0BDCetbgiPCTx/WEA8
 AiQBNKT1yIUMa9+95EeqcUPU835QwxCeCiXOKyJsaMRAu0E5m4Eo4+c1sMUMctYNoun8MC
 qCCHR3iqv3HTap6CDpmtipC6ssUeS3h7gnennsFxJ2jmk7Ct2E8aa+zK7UpaszjInAcMLk
 /ffZAu6BpTWqZb4ywlgQw+Z1OcYJ5G/Ew5Uv6NlrlNycg3XC3sUKmJyX1Axd11EfJikUk9
 C+PK2M/Wcv0lBX3lBqHDLYjrauYF173kjo7bmu33FhdibdOlP9BHfIBJhENg
X-ME-Proxy: <xmx:RhTqatQ8CA6AvSZryVxIRpIY6RZA86GBw-YwZXVJd0aV6Lnt-mcozw>
 <xmx:RhTqakU63DYZQH8snMUa3xGatrosC497sEPcEjqWm9DKMnPOcOTIeg>
 <xmx:RhTqapQ7alRpknkrNOet3D6u-xsUoiGU5MMtLBgYkOyZOTQBePwhVg>
 <xmx:RhTqamkq5-6-fYBsKljSA99XVWzIl7GnkmxcX5lRx5TqmgNU3k7lfA>
 <xmx:RxTqarHPqUw2rO4-zQ0E1SA8E8jjpJAgJv3_RwI7eG3MYIEmdO1_OaPC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 12:05:08 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 David Marchand <david.marchand@redhat.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH] eal: fix multi-process disabling
Date: Tue,  3 Nov 2026 18:04:51 +0100
Message-ID: <20261103170500.1241751-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IPC and hotplug operations checked --no-shconf incompatible option
but ignored the multi-process status changed by rte_mp_disable().
As a result, IPC was still attempted
and hotplug devargs remained subject to the IPC message size limit
even when secondary processes could no longer attach.

Change the multi-process status when --no-shconf is used,
also covering --in-memory,
so it becomes enough to check this status only.

Allow previously registered IPC actions to be unregistered
after multi-process has been disabled.

Fixes: 5c307ba2a5b1 ("eal: register non-EAL threads as lcores")
Fixes: d2fd16c8b003 ("eal: add multiprocess disable API")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/common/eal_common_dev.c  |  8 ++---
 lib/eal/common/eal_common_mcfg.c |  3 ++
 lib/eal/common/eal_common_proc.c | 56 ++++++++++++--------------------
 lib/eal/common/eal_private.h     |  5 +++
 lib/eal/windows/eal.c            |  6 ++++
 5 files changed, 37 insertions(+), 41 deletions(-)

diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index b43b0a4bb3..f42a8d2349 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -267,9 +267,7 @@ RTE_EXPORT_SYMBOL(rte_dev_probe)
 int
 rte_dev_probe(const char *devargs)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	bool do_mp = internal_conf->no_shconf == 0;
+	bool do_mp = eal_mp_is_enabled();
 	struct eal_dev_mp_req req;
 	struct rte_device *dev;
 	int ret;
@@ -426,9 +424,7 @@ RTE_EXPORT_SYMBOL(rte_dev_remove)
 int
 rte_dev_remove(struct rte_device *dev)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	bool do_mp = internal_conf->no_shconf == 0;
+	bool do_mp = eal_mp_is_enabled();
 	struct eal_dev_mp_req req;
 	char *devargs;
 	int ret;
diff --git a/lib/eal/common/eal_common_mcfg.c b/lib/eal/common/eal_common_mcfg.c
index 84ee3f3959..32f5f50015 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
+#include <rte_eal.h>
 #include <rte_eal_memconfig.h>
 #include <rte_version.h>
 
@@ -66,6 +67,8 @@ eal_mcfg_update_from_internal(void)
 
 	mcfg->legacy_mem = internal_conf->legacy_mem;
 	mcfg->single_file_segments = internal_conf->single_file_segments;
+	if (internal_conf->no_shconf)
+		rte_mp_disable(); /* multi-process requires shared config */
 	/* record current DPDK version */
 	mcfg->version = RTE_VERSION;
 }
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 73c6a53013..1e9541d61f 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -233,14 +233,12 @@ int
 rte_mp_action_register(const char *name, rte_mp_t action)
 {
 	struct action_entry *entry;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
 	if (validate_action_name(name) != 0)
 		return -1;
 
-	if (internal_conf->no_shconf) {
-		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
+	if (!eal_mp_is_enabled()) {
+		EAL_LOG(DEBUG, "Multi-process support is disabled");
 		rte_errno = ENOTSUP;
 		return -1;
 	}
@@ -270,17 +268,10 @@ void
 rte_mp_action_unregister(const char *name)
 {
 	struct action_entry *entry;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
 	if (validate_action_name(name) != 0)
 		return;
 
-	if (internal_conf->no_shconf) {
-		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
-		return;
-	}
-
 	pthread_mutex_lock(&mp_mutex_action);
 	entry = find_action_entry_by_name(name);
 	if (entry == NULL) {
@@ -656,14 +647,9 @@ rte_mp_channel_init(void)
 {
 	char path[UNIX_PATH_MAX];
 	int dir_fd;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
-	/* in no shared files mode, we do not have secondary processes support,
-	 * so no need to initialize IPC.
-	 */
-	if (internal_conf->no_shconf) {
-		EAL_LOG(DEBUG, "No shared files mode enabled, IPC will be disabled");
+	if (!eal_mp_is_enabled()) {
+		EAL_LOG(DEBUG, "Multi-process support is disabled");
 		rte_errno = ENOTSUP;
 		return -1;
 	}
@@ -912,14 +898,11 @@ RTE_EXPORT_SYMBOL(rte_mp_sendmsg)
 int
 rte_mp_sendmsg(struct rte_mp_msg *msg)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
 	if (check_input(msg) != 0)
 		return -1;
 
-	if (internal_conf->no_shconf) {
-		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
+	if (!eal_mp_is_enabled()) {
+		EAL_LOG(DEBUG, "Multi-process support is disabled");
 		rte_errno = ENOTSUP;
 		return -1;
 	}
@@ -1073,8 +1056,6 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	DIR *mp_dir;
 	struct dirent *ent;
 	struct timespec now, end;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
 	EAL_LOG(DEBUG, "request: %s", req->name);
 
@@ -1085,8 +1066,8 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	if (check_input(req) != 0)
 		goto end;
 
-	if (internal_conf->no_shconf) {
-		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
+	if (!eal_mp_is_enabled()) {
+		EAL_LOG(DEBUG, "Multi-process support is disabled");
 		rte_errno = ENOTSUP;
 		return -1;
 	}
@@ -1182,16 +1163,14 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	struct timespec now;
 	struct timespec *end;
 	bool dummy_used = false;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
 	EAL_LOG(DEBUG, "request: %s", req->name);
 
 	if (check_input(req) != 0)
 		return -1;
 
-	if (internal_conf->no_shconf) {
-		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
+	if (!eal_mp_is_enabled()) {
+		EAL_LOG(DEBUG, "Multi-process support is disabled");
 		rte_errno = ENOTSUP;
 		return -1;
 	}
@@ -1378,8 +1357,6 @@ int
 rte_mp_reply(struct rte_mp_msg *msg, const char *peer)
 {
 	EAL_LOG(DEBUG, "reply: %s", msg->name);
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
 	if (check_input(msg) != 0)
 		return -1;
@@ -1390,8 +1367,8 @@ rte_mp_reply(struct rte_mp_msg *msg, const char *peer)
 		return -1;
 	}
 
-	if (internal_conf->no_shconf) {
-		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
+	if (!eal_mp_is_enabled()) {
+		EAL_LOG(DEBUG, "Multi-process support is disabled");
 		return 0;
 	}
 
@@ -1438,3 +1415,12 @@ __rte_mp_enable(void)
 {
 	return set_mp_status(MP_STATUS_ENABLED);
 }
+
+bool
+eal_mp_is_enabled(void)
+{
+	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+
+	return rte_atomic_load_explicit(&mcfg->mp_status,
+			rte_memory_order_relaxed) != MP_STATUS_DISABLED;
+}
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 8905464f64..6a2a16dcb5 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -741,6 +741,11 @@ eal_rand_init(void);
  */
 bool __rte_mp_enable(void);
 
+/**
+ * Check whether multi-process is enabled.
+ */
+bool eal_mp_is_enabled(void);
+
 /**
  * Init per-lcore info in current thread.
  *
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index cac8faa53d..63a24b6a14 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -81,6 +81,12 @@ rte_mp_disable(void)
 	return true;
 }
 
+bool
+eal_mp_is_enabled(void)
+{
+	return false;
+}
+
 static int
 sync_func(void *arg __rte_unused)
 {
-- 
2.55.0

