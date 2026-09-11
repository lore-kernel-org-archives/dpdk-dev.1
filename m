Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1D8C88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 10:41:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBD7242DD1;
	Fri, 11 Sep 2026 12:41:24 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 78BA942DBD
 for <dev@dpdk.org>; Fri, 11 Sep 2026 12:41:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=5yS7ClCq2LD8XAX3WmafJLL84prYTkfQ1UrNgnqYRV4=;
 b=4SFDB4ZpID3/PlDK+mSyicEC3wQuENvaN8DcFlYy67NuJ78okmXDfJoNtnCFSySnYagwhBfxi
 Rjbazv4Ng+0OrEnGMAEGTRwkJO8j/IhjLwIRUZzjVmvvd0QVr76gO1nk6bCg2dI1CaFf+EzGoq+
 QXmuzC6XH4pRPjepJQxOgWY=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hhB001rBczJ467w
 for <dev@dpdk.org>; Fri, 11 Sep 2026 18:40:32 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 5AC2540584
 for <dev@dpdk.org>; Fri, 11 Sep 2026 18:41:18 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 12:41:18 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH 5/7] bpf/validate: add get current event API
Date: Fri, 11 Sep 2026 11:40:03 +0100
Message-ID: <20260911104006.34364-6-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911104006.34364-1-marat.khalili@huawei.com>
References: <20260911104006.34364-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500005.china.huawei.com (7.182.19.99) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Add API for retrieving the event currently processed by a callback.
Useful when single callback is registered for multiple events to put
less pressure on the context argument.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate_debug.c     | 13 +++++++++++++
 lib/bpf/rte_bpf_validate_debug.h | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
index 098a88026d6d..c8e9e5dd9227 100644
--- a/lib/bpf/bpf_validate_debug.c
+++ b/lib/bpf/bpf_validate_debug.c
@@ -43,6 +43,7 @@ struct rte_bpf_validate_debug {
 	const struct bpf_verifier *verifier;
 	const struct rte_bpf_prm_ex *bpf_prm;
 	struct point_list *breakpoint_lists;
+	enum rte_bpf_validate_debug_event current_event;
 	struct rte_bpf_validate_debug_point *last_point;
 	uint32_t pc;
 	/* Evaluate stage (only tracking `evaluate` part at the moment). */
@@ -236,6 +237,7 @@ debug_trigger_breakpoints(struct rte_bpf_validate_debug *debug, uint32_t pc)
 static int
 debug_send_event(struct rte_bpf_validate_debug *debug, debug_event_t event)
 {
+	debug->current_event = event;
 	return debug_points_call_back(debug, &debug->catchpoint_lists[event]);
 }
 
@@ -342,6 +344,17 @@ rte_bpf_validate_debug_get_ins(const struct rte_bpf_validate_debug *debug,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_get_event, 26.11)
+enum rte_bpf_validate_debug_event
+rte_bpf_validate_debug_get_event(const struct rte_bpf_validate_debug *debug)
+{
+	if (debug == NULL)
+		/* Just to be fool-proof, not really required by API. */
+		return -EINVAL;
+
+	return debug->current_event;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_validate_debug_get_last_point, 26.07)
 struct rte_bpf_validate_debug_point *
 rte_bpf_validate_debug_get_last_point(const struct rte_bpf_validate_debug *debug)
diff --git a/lib/bpf/rte_bpf_validate_debug.h b/lib/bpf/rte_bpf_validate_debug.h
index f1ee8769d06a..6d4bf53589e0 100644
--- a/lib/bpf/rte_bpf_validate_debug.h
+++ b/lib/bpf/rte_bpf_validate_debug.h
@@ -194,6 +194,19 @@ int
 rte_bpf_validate_debug_get_ins(const struct rte_bpf_validate_debug *debug,
 	const struct ebpf_insn **ins, uint32_t *nb_ins);
 
+/**
+ * Get event currently processed by a catchpoint callback.
+ *
+ * @param debug
+ *   Debug instance.
+ * @return
+ *   Event currently processed by a catchpoint callback.
+ *   Undefined if no event is currently being processed.
+ */
+__rte_experimental
+enum rte_bpf_validate_debug_event
+rte_bpf_validate_debug_get_event(const struct rte_bpf_validate_debug *debug);
+
 /**
  * Get last triggered breakpoint or catchpoint.
  *
-- 
2.43.0

