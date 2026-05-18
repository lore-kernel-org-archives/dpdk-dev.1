Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1668CD4F49
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 10:01:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E241E4064A;
	Mon, 18 May 2026 12:01:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 613A540615
 for <dev@dpdk.org>; Mon, 18 May 2026 12:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779098487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/hV1f+uRrzugn67nrLlWKMp2WG8QgsXVQAkP5MGYc4=;
 b=DXI7U+ey1X9PdFyPD6c41li7S2A7YZBYS0av2TLxCeSFCyZCmY4xRyntYZgWSUS7acVXeA
 1k6bGU1cWjGSqdtTSTnamYY2m3lMhhsu3tHOurRp+GttiQ9wrurcQ1qCgakhuyHgNnxUQR
 a3J0X7ZVRV/MnXnvjmgWoaaL8rlwd6I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-YFlGfZneN7mVp9O8b8Iiog-1; Mon,
 18 May 2026 06:01:24 -0400
X-MC-Unique: YFlGfZneN7mVp9O8b8Iiog-1
X-Mimecast-MFC-AGG-ID: YFlGfZneN7mVp9O8b8Iiog_1779098483
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BFC61956054; Mon, 18 May 2026 10:01:23 +0000 (UTC)
Received: from ringo.home (unknown [10.44.32.250])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 200241800465; Mon, 18 May 2026 10:01:21 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH dpdk 1/2] rib: rename nxt flag parameter to mode
Date: Mon, 18 May 2026 11:59:04 +0200
Message-ID: <20260518095900.29655-7-rjarry@redhat.com>
In-Reply-To: <20260518095900.29655-6-rjarry@redhat.com>
References: <20260518095900.29655-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6M3NdzuPA-T5qnWYdG3RQI8WCOaOsFEXyTouuNPR6Kw_1779098483
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The flag parameter in rte_rib_get_nxt() and rte_rib6_get_nxt() is a
plain int used as a typed enumeration. Give the anonymous enums proper
names (rte_rib_nxt_mode, rte_rib6_nxt_mode) and rename the parameter
from "flag" to "mode" to reflect its purpose.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/rib/rte_rib.c  |  4 ++--
 lib/rib/rte_rib.h  | 12 ++++++------
 lib/rib/rte_rib6.c |  4 ++--
 lib/rib/rte_rib6.h | 14 +++++++-------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 046db131ca00..89061829a23c 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -175,7 +175,7 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 RTE_EXPORT_SYMBOL(rte_rib_get_nxt)
 struct rte_rib_node *
 rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
-	uint8_t depth, struct rte_rib_node *last, int flag)
+	uint8_t depth, struct rte_rib_node *last, enum rte_rib_nxt_mode mode)
 {
 	struct rte_rib_node *tmp, *prev = NULL;
 
@@ -205,7 +205,7 @@ rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
 				(is_covered(tmp->ip, ip, depth) &&
 				(tmp->depth > depth))) {
 			prev = tmp;
-			if (flag == RTE_RIB_GET_NXT_COVER)
+			if (mode == RTE_RIB_GET_NXT_COVER)
 				return prev;
 		}
 		tmp = (tmp->left) ? tmp->left : tmp->right;
diff --git a/lib/rib/rte_rib.h b/lib/rib/rte_rib.h
index c325b3e3618c..0fabfb2a41a6 100644
--- a/lib/rib/rte_rib.h
+++ b/lib/rib/rte_rib.h
@@ -26,11 +26,11 @@ extern "C" {
 /**
  * rte_rib_get_nxt() flags
  */
-enum {
-	/** flag to get all subroutes in a RIB tree */
+enum rte_rib_nxt_mode {
+	/** get all subroutes in a RIB tree, excluding any exact match top-level route */
 	RTE_RIB_GET_NXT_ALL,
-	/** flag to get first matched subroutes in a RIB tree */
-	RTE_RIB_GET_NXT_COVER
+	/** get first matched subroutes in a RIB tree, excluding any exact match top-level route */
+	RTE_RIB_GET_NXT_COVER,
 };
 
 struct rte_rib;
@@ -120,7 +120,7 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth);
  *   pointer to the last returned prefix to get next prefix
  *   or
  *   NULL to get first more specific prefix
- * @param flag
+ * @param mode
  *  -RTE_RIB_GET_NXT_ALL
  *   get all prefixes from subtrie
  *  -RTE_RIB_GET_NXT_COVER
@@ -131,7 +131,7 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth);
  */
 struct rte_rib_node *
 rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip, uint8_t depth,
-	struct rte_rib_node *last, int flag);
+	struct rte_rib_node *last, enum rte_rib_nxt_mode mode);
 
 /**
  * Remove prefix from the RIB
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index ec8ff68e8700..c23881f6247e 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -195,7 +195,7 @@ RTE_EXPORT_SYMBOL(rte_rib6_get_nxt)
 struct rte_rib6_node *
 rte_rib6_get_nxt(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip,
-	uint8_t depth, struct rte_rib6_node *last, int flag)
+	uint8_t depth, struct rte_rib6_node *last, enum rte_rib6_nxt_mode mode)
 {
 	struct rte_rib6_node *tmp, *prev = NULL;
 	struct rte_ipv6_addr tmp_ip;
@@ -229,7 +229,7 @@ rte_rib6_get_nxt(struct rte_rib6 *rib,
 				(rte_ipv6_addr_eq_prefix(&tmp->ip, &tmp_ip, depth) &&
 				(tmp->depth > depth))) {
 			prev = tmp;
-			if (flag == RTE_RIB6_GET_NXT_COVER)
+			if (mode == RTE_RIB6_GET_NXT_COVER)
 				return prev;
 		}
 		tmp = (tmp->left != NULL) ? tmp->left : tmp->right;
diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
index d66d9e7c07c6..ed2761492bc8 100644
--- a/lib/rib/rte_rib6.h
+++ b/lib/rib/rte_rib6.h
@@ -25,13 +25,13 @@ extern "C" {
 #define RTE_RIB6_IPV6_ADDR_SIZE (RTE_DEPRECATED(RTE_RIB6_IPV6_ADDR_SIZE) RTE_IPV6_ADDR_SIZE)
 
 /**
- * rte_rib6_get_nxt() flags
+ * rte_rib6_get_nxt() mode
  */
-enum {
-	/** flag to get all subroutes in a RIB tree */
+enum rte_rib6_nxt_mode {
+	/** get all subroutes in a RIB tree, excluding any exact match top-level route */
 	RTE_RIB6_GET_NXT_ALL,
-	/** flag to get first matched subroutes in a RIB tree */
-	RTE_RIB6_GET_NXT_COVER
+	/** get first matched subroutes in a RIB tree, excluding any exact match top-level route */
+	RTE_RIB6_GET_NXT_COVER,
 };
 
 struct rte_rib6;
@@ -179,7 +179,7 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
  *   pointer to the last returned prefix to get next prefix
  *   or
  *   NULL to get first more specific prefix
- * @param flag
+ * @param mode
  *  -RTE_RIB6_GET_NXT_ALL
  *   get all prefixes from subtrie
  *  -RTE_RIB6_GET_NXT_COVER
@@ -191,7 +191,7 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
 struct rte_rib6_node *
 rte_rib6_get_nxt(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip,
-	uint8_t depth, struct rte_rib6_node *last, int flag);
+	uint8_t depth, struct rte_rib6_node *last, enum rte_rib6_nxt_mode mode);
 
 /**
  * Remove prefix from the RIB
-- 
2.54.0

