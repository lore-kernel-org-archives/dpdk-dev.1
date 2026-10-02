Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3D7CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 10:16:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DD8E427BB;
	Fri,  2 Oct 2026 12:16:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8D3D24003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 12:16:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790936169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1a1+Q5/1TBuvAQyz+rGQK+Iq+BG2UbKKkPbddGPBC0=;
 b=GMfEMqoTf6yPhoZxr2qbQk/iq9K4NL0q9uJC0Jz/mtHgQ7vCD6GZZ+z4ObosW+HiOvmJOd
 zo6YjnaUF3L2rObX7u52JN38yHzFDwD+1cgxE7uaqdgI5Go8ZjkyP8sj3HNORlXu+HWW4f
 2Ve7I6LZsnL67yOax4ZSNoilYvdszpQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-OE7wlqbWPQGWZQU07fLC1Q-1; Fri,
 02 Oct 2026 06:16:07 -0400
X-MC-Unique: OE7wlqbWPQGWZQU07fLC1Q-1
X-Mimecast-MFC-AGG-ID: OE7wlqbWPQGWZQU07fLC1Q_1790936166
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFD871955F03; Fri,  2 Oct 2026 10:16:06 +0000 (UTC)
Received: from ringo.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C39CB1800370; Fri,  2 Oct 2026 10:16:05 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH dpdk v2 1/2] rib: rename nxt flag parameter to mode
Date: Fri,  2 Oct 2026 12:15:26 +0200
Message-ID: <20261002101523.383527-6-rjarry@redhat.com>
In-Reply-To: <20261002101523.383527-5-rjarry@redhat.com>
References: <20260518095900.29655-6-rjarry@redhat.com>
 <20261002101523.383527-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u4BBnnC3l1tBIElb60q86lC22BQofv7Ilir3563QZ5w_1790936166
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
 lib/rib/rte_rib.h  | 14 +++++++-------
 lib/rib/rte_rib6.c |  4 ++--
 lib/rib/rte_rib6.h | 14 +++++++-------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 046db131ca00..c1dcb054d4e5 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -175,7 +175,7 @@ rte_rib_lookup_exact(struct rte_rib *rib, uint32_t ip, uint8_t depth)
 RTE_EXPORT_SYMBOL(rte_rib_get_nxt)
 struct rte_rib_node *
 rte_rib_get_nxt(struct rte_rib *rib, uint32_t ip,
-	uint8_t depth, struct rte_rib_node *last, int flag)
+	uint8_t depth, struct rte_rib_node *last, enum rte_rib_get_nxt_mode mode)
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
index c325b3e3618c..bba9ad98823f 100644
--- a/lib/rib/rte_rib.h
+++ b/lib/rib/rte_rib.h
@@ -24,13 +24,13 @@ extern "C" {
 #endif
 
 /**
- * rte_rib_get_nxt() flags
+ * rte_rib_get_nxt() mode
  */
-enum {
-	/** flag to get all subroutes in a RIB tree */
+enum rte_rib_get_nxt_mode {
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
+	struct rte_rib_node *last, enum rte_rib_get_nxt_mode mode);
 
 /**
  * Remove prefix from the RIB
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index 918ddbdfd30c..41561c4291e3 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -196,7 +196,7 @@ RTE_EXPORT_SYMBOL(rte_rib6_get_nxt)
 struct rte_rib6_node *
 rte_rib6_get_nxt(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip,
-	uint8_t depth, struct rte_rib6_node *last, int flag)
+	uint8_t depth, struct rte_rib6_node *last, enum rte_rib6_get_nxt_mode mode)
 {
 	struct rte_rib6_node *tmp, *prev = NULL;
 	struct rte_ipv6_addr tmp_ip;
@@ -230,7 +230,7 @@ rte_rib6_get_nxt(struct rte_rib6 *rib,
 				(rte_ipv6_addr_eq_prefix(&tmp->ip, &tmp_ip, depth) &&
 				(tmp->depth > depth))) {
 			prev = tmp;
-			if (flag == RTE_RIB6_GET_NXT_COVER)
+			if (mode == RTE_RIB6_GET_NXT_COVER)
 				return prev;
 		}
 		tmp = (tmp->left != NULL) ? tmp->left : tmp->right;
diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
index e3fb464ae68e..1a013e8fb4aa 100644
--- a/lib/rib/rte_rib6.h
+++ b/lib/rib/rte_rib6.h
@@ -22,13 +22,13 @@ extern "C" {
 #endif
 
 /**
- * rte_rib6_get_nxt() flags
+ * rte_rib6_get_nxt() mode
  */
-enum {
-	/** flag to get all subroutes in a RIB tree */
+enum rte_rib6_get_nxt_mode {
+	/** get all subroutes in a RIB tree, excluding any exact match top-level route */
 	RTE_RIB6_GET_NXT_ALL,
-	/** flag to get first matched subroutes in a RIB tree */
-	RTE_RIB6_GET_NXT_COVER
+	/** get first matched subroutes in a RIB tree, excluding any exact match top-level route */
+	RTE_RIB6_GET_NXT_COVER,
 };
 
 struct rte_rib6;
@@ -105,7 +105,7 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
  *   pointer to the last returned prefix to get next prefix
  *   or
  *   NULL to get first more specific prefix
- * @param flag
+ * @param mode
  *  -RTE_RIB6_GET_NXT_ALL
  *   get all prefixes from subtrie
  *  -RTE_RIB6_GET_NXT_COVER
@@ -117,7 +117,7 @@ rte_rib6_lookup_exact(struct rte_rib6 *rib,
 struct rte_rib6_node *
 rte_rib6_get_nxt(struct rte_rib6 *rib,
 	const struct rte_ipv6_addr *ip,
-	uint8_t depth, struct rte_rib6_node *last, int flag);
+	uint8_t depth, struct rte_rib6_node *last, enum rte_rib6_get_nxt_mode mode);
 
 /**
  * Remove prefix from the RIB
-- 
2.55.0

