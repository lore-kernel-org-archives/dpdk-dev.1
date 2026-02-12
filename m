Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F576EB491F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:54:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD63E40672;
	Thu, 12 Feb 2026 13:53:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3DFA840657
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:53:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900830; x=1802436830;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fyUmKvJmyNb1JnhowyKzgGeNTX8QxXYKETd5JXLYIsw=;
 b=mHePxMWcA3bn9msy28yo9+7K5VLxdb/Nstd6mVzab6jVZuPA70NvWAuN
 K0fxSF2W6Z3rzQzdtumj4AT0+RzZhxScZ61BiKx81ytKFYk18IHL7BQO3
 Y98OgdcDpILUZ0DLDqufU+FKQ4Sh6HX2g/2IdN3iEkJFx3Ju73QvCtXSM
 nMLfQMEKFMb3rKWnfVxVYbGuDbDGFv4MReKuG00P9B/qFFEsOSCs4D+/p
 WgC6a4tk8rSw/zItxLvU/hPj/M53zXX9KRPxlcFXq4HOaJRXicK0mWK9W
 g/hldgfu/ZheVn8CzVygZoFUF2VYIhcbmDsRGmZN86FY8iQ905yTXiDBk g==;
X-CSE-ConnectionGUID: LVKBs3OISDmeOPlSLnJYuw==
X-CSE-MsgGUID: D4hKmFf6SVC903FaIjKe8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71785487"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71785487"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:53:49 -0800
X-CSE-ConnectionGUID: LsNAAkeGShi1AxL91DdBGQ==
X-CSE-MsgGUID: +VRoyaVDTESdAqrI0WD77g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="243179142"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 12 Feb 2026 04:53:48 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v5 05/12] net/ixgbe: fix wrong pointer handling in IPsec
Date: Thu, 12 Feb 2026 12:53:28 +0000
Message-ID: <134252a49d330111781e4cb1baba470474091853.1770900758.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
References: 
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

The original IPsec "add SA from flow" function expected a void* pointer to
security session as its first argument. However, the actual code was not
passing that, instead it passed `rte_flow_action_security` which was a
*container* for security session pointer.

Fix it by passing correct pointer type, as well as make typing more
explicit to let compiler catch such bugs in the future.

Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c  | 14 ++++++++++++--
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 19 +++++++------------
 drivers/net/intel/ixgbe/ixgbe_ipsec.h | 16 +++++++++++++---
 3 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 90a24806d2..461fcf0857 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -221,6 +221,8 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 	act = next_no_void_action(actions, NULL);
 	if (act->type == RTE_FLOW_ACTION_TYPE_SECURITY) {
 		const void *conf = act->conf;
+		const struct rte_flow_action_security *sec_act;
+		struct ip_spec spec;
 
 		if (conf == NULL) {
 			rte_flow_error_set(error, EINVAL,
@@ -259,8 +261,16 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 		}
 
 		filter->proto = IPPROTO_ESP;
-		return ixgbe_crypto_add_ingress_sa_from_flow(conf, item->spec,
-					item->type == RTE_FLOW_ITEM_TYPE_IPV6);
+		sec_act = (const struct rte_flow_action_security *)conf;
+		spec.is_ipv6 = item->type == RTE_FLOW_ITEM_TYPE_IPV6;
+		if (spec.is_ipv6) {
+			const struct rte_flow_item_ipv6 *ipv6 = item->spec;
+			spec.spec.ipv6 = *ipv6;
+		} else {
+			const struct rte_flow_item_ipv4 *ipv4 = item->spec;
+			spec.spec.ipv4 = *ipv4;
+		}
+		return ixgbe_crypto_add_ingress_sa_from_flow(sec_act->security_session, &spec);
 	}
 #endif
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index df0964a51d..f76ce5b3ee 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -664,20 +664,15 @@ ixgbe_crypto_enable_ipsec(struct rte_eth_dev *dev)
 }
 
 int
-ixgbe_crypto_add_ingress_sa_from_flow(const void *sess,
-				      const void *ip_spec,
-				      uint8_t is_ipv6)
+ixgbe_crypto_add_ingress_sa_from_flow(struct rte_security_session *sess,
+		const struct ip_spec *spec)
 {
-	/**
-	 * FIXME Updating the session priv data when the session is const.
-	 * Typecasting done here is wrong and the implementation need to be corrected.
-	 */
-	struct ixgbe_crypto_session *ic_session = (void *)(uintptr_t)
-			((const struct rte_security_session *)sess)->driver_priv_data;
+	struct ixgbe_crypto_session *ic_session =
+			RTE_CAST_PTR(struct ixgbe_crypto_session *, sess->driver_priv_data);
 
 	if (ic_session->op == IXGBE_OP_AUTHENTICATED_DECRYPTION) {
-		if (is_ipv6) {
-			const struct rte_flow_item_ipv6 *ipv6 = ip_spec;
+		if (spec->is_ipv6) {
+			const struct rte_flow_item_ipv6 *ipv6 = &spec->spec.ipv6;
 			ic_session->src_ip.type = IPv6;
 			ic_session->dst_ip.type = IPv6;
 			rte_memcpy(ic_session->src_ip.ipv6,
@@ -685,7 +680,7 @@ ixgbe_crypto_add_ingress_sa_from_flow(const void *sess,
 			rte_memcpy(ic_session->dst_ip.ipv6,
 				   &ipv6->hdr.dst_addr, 16);
 		} else {
-			const struct rte_flow_item_ipv4 *ipv4 = ip_spec;
+			const struct rte_flow_item_ipv4 *ipv4 = &spec->spec.ipv4;
 			ic_session->src_ip.type = IPv4;
 			ic_session->dst_ip.type = IPv4;
 			ic_session->src_ip.ipv4 = ipv4->hdr.src_addr;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/intel/ixgbe/ixgbe_ipsec.h
index be39199be1..e7c7186264 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.h
@@ -6,6 +6,9 @@
 #define IXGBE_IPSEC_H_
 
 #include <rte_security.h>
+#include <rte_security_driver.h>
+
+#include <rte_flow.h>
 
 #define IPSRXIDX_RX_EN                                    0x00000001
 #define IPSRXIDX_TABLE_IP                                 0x00000002
@@ -109,9 +112,16 @@ struct ixgbe_ipsec {
 
 int ixgbe_ipsec_ctx_create(struct rte_eth_dev *dev);
 int ixgbe_crypto_enable_ipsec(struct rte_eth_dev *dev);
-int ixgbe_crypto_add_ingress_sa_from_flow(const void *sess,
-					  const void *ip_spec,
-					  uint8_t is_ipv6);
+
+struct ip_spec {
+	bool is_ipv6;
+	union {
+		struct rte_flow_item_ipv4 ipv4;
+		struct rte_flow_item_ipv6 ipv6;
+	} spec;
+};
+int ixgbe_crypto_add_ingress_sa_from_flow(struct rte_security_session *sess,
+		const struct ip_spec *ip_spec);
 
 
 
-- 
2.47.3

