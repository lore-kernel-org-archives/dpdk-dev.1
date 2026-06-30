Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4FCC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:40:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3CDB4066B;
	Tue, 30 Jun 2026 13:40:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3F3B540278
 for <dev@dpdk.org>; Tue, 30 Jun 2026 13:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782819627; x=1814355627;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JFeVTYWNTG7qdAeFGN2HZi3KrzWnhAmyH8SdExCfOc0=;
 b=KQsK2XMX3K/s3RR1PkghNtpoI7DTPb7kH91zQQ4JTqxIGWngGx0AdbH6
 pQTwU32AsKCjgaDwBHTojcpZ5XC6Thgso4khQ1+KfXc+CaltVKcqGASSe
 Mbq5nNKymJwrGxpu2Kdj0N/Ub9dlcGPpGGj5NSENTOvvGlRuBlOU1CxRW
 nIjXwLgrurvM495LHZd+rvuNQcQYWVH4sT7gi5U1dQ4yPRdpwa+sWnkk9
 qAnn0fEc2jV9SdiRNTutbhRUV7bX1qhG1n/oeS5A+LOslqk4zP7BiFutE
 OMXQHfSbeCjBPNHKdwM+G+wnSUSNNXXb6pH2cg0/AiM1tB8cn8TLZYU5n w==;
X-CSE-ConnectionGUID: kD3pxywxRXKN1u8BFtCilQ==
X-CSE-MsgGUID: c3Q3NVPBT7OyypVNQPQbaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82643749"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="82643749"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 04:40:27 -0700
X-CSE-ConnectionGUID: sjfLqbrrToOt+06BdNIBkQ==
X-CSE-MsgGUID: vgWiC6oFRcqrdcPXHzl69w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="245891155"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2026 04:40:25 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v3 5/6] net/iavf: disable runtime queue setup capability
Date: Tue, 30 Jun 2026 08:06:55 -0400
Message-ID: <20260630120657.1046588-6-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630120657.1046588-1-dawid.wesierski@intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
 <20260630120657.1046588-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

Remove the advertisement of RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP
and RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP capabilities from the
iavf VF driver.

Runtime queue setup on E810 VFs causes queue state corruption when
queues are dynamically reconfigured while the hardware rate limiter
is actively pacing TX queues. Queue configuration messages to the PF
via virtchnl can race with ongoing TX operations, leading to undefined
behavior.

By not advertising these capabilities, all queues are configured at
port start and remain stable throughout the port lifecycle.

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 doc/guides/nics/intel_vf.rst           |  9 +++++++++
 doc/guides/rel_notes/release_26_07.rst |  2 ++
 drivers/net/intel/iavf/iavf.h          |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c   | 22 ++++++++++++++++++----
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index e010f852cf..86878330f2 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -131,6 +131,15 @@ IAVF PMD parameters
     * ``segment``: Check number of mbuf segments does not exceed HW limits.
     * ``offload``: Check for use of an unsupported offload flag.
 
+``no_runtime_queue_setup``
+    Runtime (post-start) Rx/Tx queue setup can race with the hardware Tx rate
+    limiter on E810 VFs and corrupt queue state.
+    It is advertised by default.
+    Applications that pace queues through the traffic manager can opt out
+    of advertising the runtime queue setup capability
+    by setting ``no_runtime_queue_setup`` to 1,
+    for example, ``-a 18:01.0,no_runtime_queue_setup=1``.
+
 
 HW-Specific Notes For IAVF
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index db8c4d5b16..d3e9dc6cf4 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -135,6 +135,8 @@ New Features
 
   * Added support for transmitting LLDP packets based on mbuf packet type.
   * Implemented AVX2 context descriptor transmit paths.
+  * Added ``no_runtime_queue_setup`` devarg to disable runtime queue setup
+    on devices that pace queues through the traffic manager.
 
 * **Updated Intel ice driver.**
 
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 4444602a30..146f02ea13 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -326,6 +326,7 @@ struct iavf_devargs {
 	int no_poll_on_link_down;
 	uint64_t mbuf_check;
 	int enable_ptype_lldp;
+	int no_runtime_queue_setup;
 };
 
 struct iavf_security_ctx;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index ec1ad02826..be733f9edf 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -46,6 +46,7 @@
 #define IAVF_NO_POLL_ON_LINK_DOWN_ARG "no-poll-on-link-down"
 #define IAVF_MBUF_CHECK_ARG       "mbuf_check"
 #define IAVF_ENABLE_PTYPE_LLDP_ARG "enable_ptype_lldp"
+#define IAVF_NO_RUNTIME_QUEUE_SETUP_ARG "no_runtime_queue_setup"
 uint64_t iavf_timestamp_dynflag;
 int iavf_timestamp_dynfield_offset = -1;
 int rte_pmd_iavf_tx_lldp_dynfield_offset = -1;
@@ -59,6 +60,7 @@ static const char * const iavf_valid_args[] = {
 	IAVF_NO_POLL_ON_LINK_DOWN_ARG,
 	IAVF_MBUF_CHECK_ARG,
 	IAVF_ENABLE_PTYPE_LLDP_ARG,
+	IAVF_NO_RUNTIME_QUEUE_SETUP_ARG,
 	NULL
 };
 
@@ -1160,9 +1162,15 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->reta_size = vf->vf_res->rss_lut_size;
 	dev_info->flow_type_rss_offloads = IAVF_RSS_OFFLOAD_ALL;
 	dev_info->max_mac_addrs = IAVF_NUM_MACADDR_MAX;
-	dev_info->dev_capa =
-		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
-		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
+	/*
+	 * Runtime queue setup can race with the hardware Tx rate limiter on
+	 * E810 VFs and corrupt queue state. Applications that pace queues via
+	 * the traffic manager can opt out with no_runtime_queue_setup=1.
+	 */
+	if (!adapter->devargs.no_runtime_queue_setup)
+		dev_info->dev_capa =
+			RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
+			RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
 		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
@@ -2533,6 +2541,11 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
+	ret = rte_kvargs_process(kvlist, IAVF_NO_RUNTIME_QUEUE_SETUP_ARG,
+				 &parse_bool, &ad->devargs.no_runtime_queue_setup);
+	if (ret)
+		goto bail;
+
 bail:
 	rte_kvargs_free(kvlist);
 	return ret;
@@ -3619,7 +3632,8 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
 RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
-RTE_PMD_REGISTER_PARAM_STRING(net_iavf, "cap=dcf");
+RTE_PMD_REGISTER_PARAM_STRING(net_iavf, "cap=dcf"
+			      IAVF_NO_RUNTIME_QUEUE_SETUP_ARG "=<0|1>");
 RTE_LOG_REGISTER_SUFFIX(iavf_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(iavf_logtype_driver, driver, NOTICE);
 #ifdef RTE_ETHDEV_DEBUG_RX
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

