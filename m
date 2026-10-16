Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C75ECCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 13:07:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A357406B8;
	Fri, 16 Oct 2026 15:06:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 74D6A40A6D
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792156000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+n7XsPLJfSOhoGBSQK9+aKZh6Xenfa598NO0cXGa/Q=;
 b=XYNSQqGHSMOSCVk3pnOdiXx0LYVyO4w2cP0A8dRGOqeqmfx+9rmGKq+g5QbWxucsr7+hVF
 r2rgAE1fyAuzM/8lRXytOkljWY4s1Tkv5ycwPLTpbDqpfGoKl/Z7aL8A8/e8lQX5DmQpyw
 SVjZjnG04FTuYD2UXlUzrlibH2ovVf0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-wL19h7iXPDmxz_bQ3Zt5Qw-1; Fri,
 16 Oct 2026 13:06:35 +0000
X-MC-Unique: wL19h7iXPDmxz_bQ3Zt5Qw-1
X-Mimecast-MFC-AGG-ID: wL19h7iXPDmxz_bQ3Zt5Qw_1792155994
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0BBE1956055; Fri, 16 Oct 2026 13:06:33 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AEF31956089; Fri, 16 Oct 2026 13:06:31 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Praveen Shetty <praveen.shetty@intel.com>,
 Harman Kalra <hkalra@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 7/8] ethdev: check RSS availability
Date: Fri, 16 Oct 2026 15:05:53 +0200
Message-ID: <20261016130555.1685102-8-david.marchand@redhat.com>
In-Reply-To: <20261016130555.1685102-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WwS3HC--zVZ5Ls7ERb7CJ34wp0WL6kLBhv-tbM-ykAA_1792155994
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

Add RSS capability check in rte_eth_dev_configure() using
dev_info.flow_type_rss_offloads.
When zero, reject Rx modes with RTE_ETH_MQ_RX_RSS_FLAG.
Remove redundant RSS checks from drivers.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 devtools/check-doc-vs-code.sh          | 14 +++++++++++++-
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 drivers/net/intel/cpfl/cpfl_ethdev.c   |  3 ---
 drivers/net/nfp/nfp_net_common.c       |  7 -------
 drivers/net/octeontx/octeontx_ethdev.c |  3 +--
 drivers/net/sfc/sfc_rx.c               |  9 +--------
 lib/ethdev/rte_ethdev.c                |  8 ++++++++
 7 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
index 81c9713f5a..da8398bfa4 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -89,6 +89,18 @@ check_mq_caps() # <driver>
 		fi
 	fi
 
+	if all_docs_agree $1 "RSS hash"; then
+		if has_doc_feature "$doc" "RSS hash"; then
+			git grep -qE 'flow_type_rss_offloads[[:space:]]*\|?=' -- "$code" ||
+				error "RSS documented but flow_type_rss_offloads not set for $1"
+		else
+			! git grep -qE 'flow_type_rss_offloads[[:space:]]*\|?=' -- "$code" ||
+				error "flow_type_rss_offloads set but RSS not documented for $1"
+			! git grep -qE 'RTE_ETH_MQ_RX.*RSS' -- "$code" ||
+				error "RSS mq_mode referenced but RSS not documented for $1"
+		fi
+	fi
+
 	if all_docs_agree $1 "VMDq"; then
 		if has_doc_feature "$doc" "VMDq"; then
 			git grep -qE 'max_vmdq_pools[[:space:]]*=' -- "$code" ||
@@ -131,7 +143,7 @@ if has_code_change 'RTE_FLOW_.*_TYPE_' ||
 		check_rte_flow $driver
 	done
 fi
-if has_code_change 'get_dcb_info\|max_vmdq_pools\|RTE_ETH_MQ_.*DCB\|RTE_ETH_MQ_.*VMDQ' ||
+if has_code_change 'get_dcb_info\|flow_type_rss_offloads\|max_vmdq_pools\|RTE_ETH_MQ_' ||
 		has_file_change 'doc/guides/nics/features'; then
 	for driver in $(changed_net_drivers); do
 		check_mq_caps $driver
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 9341769c32..caffd2a611 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -428,6 +428,8 @@ API Changes
 
   * DCB modes (Rx ``RTE_ETH_MQ_RX_DCB_FLAG``, Tx ``RTE_ETH_MQ_TX_DCB``/``RTE_ETH_MQ_TX_VMDQ_DCB``)
     are rejected if the driver has no ``get_dcb_info`` callback.
+  * RSS mode (Rx ``RTE_ETH_MQ_RX_RSS_FLAG``) is rejected if the driver reports no
+    ``flow_type_rss_offloads``.
   * VMDq modes (Rx ``RTE_ETH_MQ_RX_VMDQ_FLAG``,
     Tx ``RTE_ETH_MQ_TX_VMDQ_DCB``/``RTE_ETH_MQ_TX_VMDQ_ONLY``) are rejected
     if the driver reports no VMDq pool.
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 0863043a2e..f425181bf2 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -752,9 +752,6 @@ cpfl_dev_configure(struct rte_eth_dev *dev)
 			PMD_INIT_LOG(ERR, "Failed to init rss");
 			return ret;
 		}
-	} else if (conf->rxmode.mq_mode == RTE_ETH_MQ_RX_RSS) {
-		PMD_INIT_LOG(ERR, "RSS is not supported.");
-		return -ENOTSUP;
 	}
 
 	vport->max_pkt_len =
diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index afa0bc0faf..f9957086d2 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -373,13 +373,6 @@ nfp_net_configure(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	/* Checking RX mode */
-	if ((rxmode->mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) != 0 &&
-			(hw->super.cap & NFP_NET_CFG_CTRL_RSS_ANY) == 0) {
-		PMD_DRV_LOG(ERR, "RSS not supported.");
-		return -EINVAL;
-	}
-
 	/* Checking MTU set */
 	if (rxmode->mtu > hw->max_mtu + NFP_ETH_OVERHEAD) {
 		PMD_DRV_LOG(ERR, "MTU (%u) larger than the maximum possible frame size (%u).",
diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index e173535d29..e0df23049c 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -499,8 +499,7 @@ octeontx_dev_configure(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	if (rxmode->mq_mode != RTE_ETH_MQ_RX_NONE &&
-		rxmode->mq_mode != RTE_ETH_MQ_RX_RSS) {
+	if (rxmode->mq_mode != RTE_ETH_MQ_RX_NONE) {
 		octeontx_log_err("unsupported rx qmode %d", rxmode->mq_mode);
 		return -EINVAL;
 	}
diff --git a/drivers/net/sfc/sfc_rx.c b/drivers/net/sfc/sfc_rx.c
index 1d4101b9e9..aa59931f06 100644
--- a/drivers/net/sfc/sfc_rx.c
+++ b/drivers/net/sfc/sfc_rx.c
@@ -1668,21 +1668,14 @@ sfc_rx_qinit_info(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 static int
 sfc_rx_check_mode(struct sfc_adapter *sa, struct rte_eth_rxmode *rxmode)
 {
-	struct sfc_adapter_shared * const sas = sfc_sa2shared(sa);
 	uint64_t offloads_supported = sfc_rx_get_dev_offload_caps(sa) |
 				      sfc_rx_get_queue_offload_caps(sa);
-	struct sfc_rss *rss = &sas->rss;
 	int rc = 0;
 
 	switch (rxmode->mq_mode) {
 	case RTE_ETH_MQ_RX_NONE:
-		/* No special checks are required */
-		break;
 	case RTE_ETH_MQ_RX_RSS:
-		if (rss->context_type == EFX_RX_SCALE_UNAVAILABLE) {
-			sfc_err(sa, "RSS is not available");
-			rc = EINVAL;
-		}
+		/* No special checks are required */
 		break;
 	default:
 		sfc_err(sa, "Rx multi-queue mode %u not supported",
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 39a895c9e4..44b20697ae 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1526,6 +1526,14 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		goto rollback;
 	}
 
+	if (dev_info.flow_type_rss_offloads == 0 &&
+			(dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) != 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=%u does not support RSS rx mode",
+			port_id);
+		ret = -EINVAL;
+		goto rollback;
+	}
+
 	dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf =
 		rte_eth_rss_hf_refine(dev_conf->rx_adv_conf.rss_conf.rss_hf);
 
-- 
2.54.0

