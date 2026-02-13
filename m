Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC72EDF023
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 09:10:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE51E40661;
	Fri, 13 Feb 2026 10:10:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1F4744065A
 for <dev@dpdk.org>; Fri, 13 Feb 2026 10:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770973829; x=1802509829;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=U6R0u4hAnxNXZ0tIItpE20pizIj3GXyUER6j3g1pTbk=;
 b=nhYkKFqAVgq3CfFbKx7wgv9j2nIAWYNNsN3VaZzkC/jMAdxelh7TKsfr
 K5LFCGUi6dRtTLQB/2ELI89TC4C+P3jTIL3u38oY/OG0CVcEOVKRTrZfP
 ll6gGFIGyG5CYgdY52EiVgQvMi0PgEdhXg0eZudHHdKCJT816lMoJITOF
 3xbDSJRR8Df2quKKuSKmNcIkKy7zBdx3x8felFEWpSwlg8QOvgy5Nd5OT
 Jsk0whlxGB6zBE1AsWVcYxTTz5rIq6hqc1wYHAqFfP9zoYTWl+1mFPJdp
 6X7rATLpDYV35g9PpkRX68KFU1ZksAP2E5Uq5qlOq7xo/veIEpCQ6paAa A==;
X-CSE-ConnectionGUID: KVc8nOjbQ3a7QaXUFwslAw==
X-CSE-MsgGUID: TpXX0pkQQgSjR115YdPUOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89567866"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="89567866"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 01:10:29 -0800
X-CSE-ConnectionGUID: 4vjfO1U0TPWsz+nyRrALdQ==
X-CSE-MsgGUID: a8xs5w+HRFiIDuOUG7Eaeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="211966070"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 13 Feb 2026 01:10:27 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v6 05/12] net/ixgbe: fix wrong pointer handling in IPsec
Date: Fri, 13 Feb 2026 09:10:07 +0000
Message-ID: <193b851bacfcaa64b6772fe970ae444a86a3eb9e.1770973745.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770973745.git.anatoly.burakov@intel.com>
 <cover.1770973745.git.anatoly.burakov@intel.com>
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
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c  | 24 ++++++++++++++++++++++--
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 18 ++++++------------
 drivers/net/intel/ixgbe/ixgbe_ipsec.h | 16 +++++++++++++---
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 90a24806d2..6a7edc6377 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -221,6 +221,9 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 	act = next_no_void_action(actions, NULL);
 	if (act->type == RTE_FLOW_ACTION_TYPE_SECURITY) {
 		const void *conf = act->conf;
+		const struct rte_flow_action_security *sec_act;
+		struct rte_security_session *session;
+		struct ip_spec spec;
 
 		if (conf == NULL) {
 			rte_flow_error_set(error, EINVAL,
@@ -259,8 +262,25 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
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
+
+		/*
+		 * we get pointer to security session from security action,
+		 * which is const. however, we do need to act on the session, so
+		 * either we do some kind of pointer based lookup to get session
+		 * pointer internally (which quickly gets unwieldy for lots of
+		 * flows case), or we simply cast away constness.
+		 */
+		session = RTE_CAST_PTR(struct rte_security_session *, sec_act->security_session);
+		return ixgbe_crypto_add_ingress_sa_from_flow(session, &spec);
 	}
 #endif
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index df0964a51d..fe9a96c54d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -664,20 +664,14 @@ ixgbe_crypto_enable_ipsec(struct rte_eth_dev *dev)
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
+	struct ixgbe_crypto_session *ic_session = SECURITY_GET_SESS_PRIV(sess);
 
 	if (ic_session->op == IXGBE_OP_AUTHENTICATED_DECRYPTION) {
-		if (is_ipv6) {
-			const struct rte_flow_item_ipv6 *ipv6 = ip_spec;
+		if (spec->is_ipv6) {
+			const struct rte_flow_item_ipv6 *ipv6 = &spec->spec.ipv6;
 			ic_session->src_ip.type = IPv6;
 			ic_session->dst_ip.type = IPv6;
 			rte_memcpy(ic_session->src_ip.ipv6,
@@ -685,7 +679,7 @@ ixgbe_crypto_add_ingress_sa_from_flow(const void *sess,
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

