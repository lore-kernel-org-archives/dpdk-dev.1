Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA4606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=b73ABo6i;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xd5955H8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F17CC40299;
	Wed,  4 Nov 2026 18:10:59 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTPS id E5E2A40299
 for <dev@dpdk.org>; Wed,  4 Nov 2026 18:10:58 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 13874EC09CF
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:10:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 12:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1793812258; x=
 1793898658; bh=Ll6bSY7LofJArD2L/AiFNc41T9nsfDnInbxsuYUyCu8=; b=b
 73ABo6i7IoHl0mV63VTUT1oMiFEZ8Gpmgq8tyPayGLalBhCWihT3GBeCZgKsHvTp
 OWtxFBaMZfdZYMWJVi1YjBhUN6yAojf8FiRoJ7yxZPxqLIWXAfhBQkVTxUJATb3b
 /o9k+vsOaWB8ew1TIvLwYZqAIUU5Fl4c79Th7CKU90Mvx8XqOQ0OPOnnt2ufVamD
 UOQ4zZl+pcWcgX/6o7L0HrtLnbKxSY9/sqFJvcVFRpe8DbDWsOIwB8+pgDKARzFt
 THyw8arUGYm6ZsdRzoUZ7ysp+/zBP67otIpOMM3/Kbx4GhM9Lc4t0BEWJILYF+/L
 zvmaLh+W5TtqZ8USD0JFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1793812258; x=1793898658; bh=L
 l6bSY7LofJArD2L/AiFNc41T9nsfDnInbxsuYUyCu8=; b=xd5955H8aWI/kyqrB
 v+BVV6NPSoNRNOMlAh1RL5eqFr7jULeLP6QJiEPpTXZQAEvwMippgn3603CjN9bq
 Qm/cMKVeh1aWTQbfApuRb4SLg4WKyyPGpOXo3aDr880qT9k+scfAXTB5ODxD29fM
 wpwQWN2J1sE77cbjoxu2yHWlBABjg7yOk2dPKWq8pWtMFahdhBrqvw/+FQ+cuH8s
 Ih/pjCXIrqspEVHAnYN1iISzNijwJv6GzpJQIFPMdTFDNrzmpxcCSy2cAzG7gEjL
 cMiI9xp34Xgbe8SgV2EsuSGiL0U8J6DhkUTeIYW/xH1vlA/pY8ws8G2fs9b8Cqcl
 2PtTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793812258; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:VTTeSTu8db+jqu00P+cvsXO4W0Sh4Fy7zmsmPpRszYWzekx
 /8WeDXDYPKvRCdKty3XBUYKw4WD3ZnPHONCt3qqi7/SRw5wp97hqUWRgWaq5H3VP
 X3EnOcItjLwlCL7W11/H9IYS5She/G6HJQXtDYCHUMmVC3tQQ0dvqmzLjN+xr8xL
 DYm34vz12fMrg29pgJyP59jVCf/cLhaktWZqSwTz+9yqocxUEtNUPLiQs9L4A12P
 2yG33bh61VjayriSEd1rc7ewe3s8oA3gChH1dcMEILDtVZkz4unJMza7CpAtzMJ+
 U6VtNpW6QtHMART1rgJxZik92ez1D7gsJS4AHbQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:BNuWrv2IAd+w/9jyLT1riKicblsSnpj/0Iujbq8T/7Q=:XmvRE/VWtzJE6gdT6O6rEpQIqZe2NTCTLrqzXVCRsdE=;
X-ME-Sender: <xms:IGfratj9pragUSJgzeJyjhkNB2SlJpwnCt7pduDweyzI09BZpHPR2w>
 <xme:IGfras9Deq_cKVIIUYM9Vv-eu0VVhzVEQ1tZyJcODdtMAE1mAbOBo6fD32D8l4lfM
 IC2_7U_EI_3--qyGrx7RDS71R807ZduK9VGYYRQEiuw5vpWeJLyvdE>
X-ME-Received: <xmr:IGfrasFP16I5VXSC4p01BhCNddIW1QXNFZh6vyArezwcY1KTLP0JrXZkOu-as4GtV-TzqfjW_yWY4ByskNiMpaqKTtKC>
X-ME-Proxy-Cause: dmFkZTE/o1NMjsYvjHfKjamtHIY7Jf5z0kirYhGK8Km2p5h98o3VwZNSthDGpbe5fz0vfg
 TJW7O6ZM727b/kGmsW1kRv+Um4vno2At6NW0LDYvvXXaEkTCmsY0H1k+QFXuNIPB39khWH
 HZM6JnuJ50EKHVJRJzMei4TgXT4aI1ZB4FsenV7qIK9GtDmWLKn60s9IcUMwj3fFe3sd6r
 mHypxVGEthrI6LPxg5kcoRnQ76Jb3LLRcmyc9bm3ebzTvuoJDYs98HtuAVU3WGRpeo/GNo
 gI3wc7NFFBK+tosDTcJa82SOo8bQYldwETx5gQPgro0a0d2lgK2wl9nKkA6uATynrrMOXI
 ZrxBP55KL9NsV9Ur50vxH3HkhAyVFc/Tr47A9ptYX8ftjd1XTytpY0jzW39d7eaDyOoNcO
 cCJTd7CcvaUx3n9GaKo/5/bF+qji2kDyUwYbEQM4dqdrGG0c5Fk75s1pFhlJMi75N7j0cR
 JMtKOk7hWmEjg6m87Br0Y1/2yP28G/FFfaz4zDKPFsLP9B1D7czL6DXPDTE+g6I7SN1Hpm
 LPV6uSjdRdQn0FgMUo5axpdElqzHppTJmUp3kr2xhEvBqhOmVPI7NSDcom9YujDgnmI4qT
 GLKx3c607ioY1/I6sk+AmMzoPySK4xsB075Otkjsy3meKSG/2EQPDTL+7PaQ
X-ME-Proxy: <xmx:IGfranlfDqr1--gBJiuV-Phh0ZDEnakv3MGhH4f8CDuPggHZu4GN1w>
 <xmx:IGfraoY4tS4BQIGEgd-su86oyroCU8D39ph2DHNjIxqICi3jIVdz2w>
 <xmx:IGfrakHjKJKfFBxRqFz1RfpLV9Cte4tcL_JCic_YKo-azKF--qwQZg>
 <xmx:IGfrahL9NR2E_0wwFUA5sgrnU1bECgCGqZKxrQv86jyBRB4-OYPmtw>
 <xmx:Imfrai6vwbzHopnMumOdryXVG4d6rg6RMCmmiAzMoxNaaMvZz0jMPrX0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 12:10:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 David Marchand <david.marchand@redhat.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2] ipc: fix multi-process disabling
Date: Wed,  4 Nov 2026 18:07:57 +0100
Message-ID: <20261104171044.2236004-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103170500.1241751-1-thomas@monjalon.net>
References: <20261103170500.1241751-1-thomas@monjalon.net>
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
v2: reverse the logic eal_mp_is_enabled -> eal_mp_is_disabled
    to map the meaning of the values in enum mp_status
    (enabled is not unknown)
---
 lib/eal/common/eal_common_dev.c  |  8 ++---
 lib/eal/common/eal_common_mcfg.c |  3 ++
 lib/eal/common/eal_common_proc.c | 56 ++++++++++++--------------------
 lib/eal/common/eal_private.h     |  5 +++
 lib/eal/windows/eal.c            |  6 ++++
 5 files changed, 37 insertions(+), 41 deletions(-)

diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index b43b0a4bb3..39d5745142 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -267,9 +267,7 @@ RTE_EXPORT_SYMBOL(rte_dev_probe)
 int
 rte_dev_probe(const char *devargs)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	bool do_mp = internal_conf->no_shconf == 0;
+	bool do_mp = !eal_mp_is_disabled();
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
+	bool do_mp = !eal_mp_is_disabled();
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
index 73c6a53013..b70e9189a4 100644
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
+	if (eal_mp_is_disabled()) {
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
+	if (eal_mp_is_disabled()) {
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
+	if (eal_mp_is_disabled()) {
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
+	if (eal_mp_is_disabled()) {
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
+	if (eal_mp_is_disabled()) {
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
+	if (eal_mp_is_disabled()) {
+		EAL_LOG(DEBUG, "Multi-process support is disabled");
 		return 0;
 	}
 
@@ -1438,3 +1415,12 @@ __rte_mp_enable(void)
 {
 	return set_mp_status(MP_STATUS_ENABLED);
 }
+
+bool
+eal_mp_is_disabled(void)
+{
+	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+
+	return rte_atomic_load_explicit(&mcfg->mp_status,
+			rte_memory_order_relaxed) == MP_STATUS_DISABLED;
+}
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 8905464f64..60441ac0f2 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -741,6 +741,11 @@ eal_rand_init(void);
  */
 bool __rte_mp_enable(void);
 
+/**
+ * Check whether multi-process is disabled.
+ */
+bool eal_mp_is_disabled(void);
+
 /**
  * Init per-lcore info in current thread.
  *
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index cac8faa53d..7309986910 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -81,6 +81,12 @@ rte_mp_disable(void)
 	return true;
 }
 
+bool
+eal_mp_is_disabled(void)
+{
+	return true;
+}
+
 static int
 sync_func(void *arg __rte_unused)
 {
-- 
2.55.0

