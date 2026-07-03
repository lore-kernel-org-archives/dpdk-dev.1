Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E4C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 11:53:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01AC840A4B;
	Fri,  3 Jul 2026 13:53:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9FD9D402D4
 for <dev@dpdk.org>; Fri,  3 Jul 2026 13:53:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783079611; x=1814615611;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k5EPiXn5abSRZrL/Dnb771fKAvEgFfae5yC9mIywF7g=;
 b=oEiRSbrShSGYjL39Y4nghFLo/GkyoMyZO6RlOCxmfutMKcLIqgODrenx
 DqKTj5evhTx9lSSTqSGPrQHs3fo0LLdS0vbPffouv24GzxRHlJifrUvZN
 Dv9PUR58O4RKh0nsH/Zd1dUBe8DgchCKP5WahbFzJPW9cFjmK4JbIPrBC
 +xy3PlnJMMYZkL5ltxCQjY6e7rKAYzmVTw3/LAGYYYR7LEqTVQM+HsbU4
 ur9+uDpP2RQp80CeLJTbbKUU8WyEumQ0OaR27Ky5LI/Yqx6CnFFzVasvF
 VgsN+duRv4AiMfFR8Eh36rTbgfr5GD/F/4EbixEHk/5B/lbfoWPvwwi1H A==;
X-CSE-ConnectionGUID: ReOIgWMDTS+E0CV4uNCDIA==
X-CSE-MsgGUID: 9hdW49inT+u1fugE0ZN2nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101253817"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="101253817"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 04:53:31 -0700
X-CSE-ConnectionGUID: jPwl1YsWRqeR5wH/N4ABpw==
X-CSE-MsgGUID: tyhH14U+SkmQpUnxsIPwIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="291240263"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa001.jf.intel.com with ESMTP; 03 Jul 2026 04:53:28 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v4 4/5] net/iavf: disable runtime queue setup capability
Date: Fri,  3 Jul 2026 08:19:51 -0400
Message-ID: <20260703121952.1277387-5-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703121952.1277387-1-dawid.wesierski@intel.com>
References: <20260630120657.1046588-1-dawid.wesierski@intel.com>
 <20260703121952.1277387-1-dawid.wesierski@intel.com>
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
index 43b20b97e2..124e074a11 100644
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

