Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145B8CD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:19:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B59A40A6D;
	Mon, 22 Jun 2026 13:18:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id E3FD340A4B;
 Mon, 22 Jun 2026 13:18:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782127132; x=1813663132;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QO+urkl5tUqEpO3OBv6FxCa2P3DNvapFX6XlKJl33BI=;
 b=i5nIyUSoSJRXMT8osPB7lXgWnIyTN3pSkojhHGg/RbfztlNzN8+kXf0z
 ePL4K2zTvlq3Po7bRea9aYuI4ryfXm3vg7FjvESGr6xXREMDfZtUZC21V
 g/Qr93nRU6myc2GDhmPhNTO3vxBFNelwdEKpf2fKwgP1kgbGuoSDSbjKk
 gK8EXPRihcygl27tYK5JNM1FOeZfYlII0IDWDS3FrYRcMUCVOyplzE5z2
 fCkhii3u3Dt3gERKYpZUk8L6qBk/+FTZmelTIBNdp73OUjxRBq7g5vnpA
 inzz3dKdBe07LBjK1GZ2hUa90/MAlHGE0OBIb0yFK5sAx/XyzE15lx3J9 Q==;
X-CSE-ConnectionGUID: UW2sJdYsScmvxQWychFL1g==
X-CSE-MsgGUID: ytnFJG4fSCquD45xpjn8Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93219306"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="93219306"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 04:18:51 -0700
X-CSE-ConnectionGUID: jdAo3f1ZTvyNb3LD73Fj1Q==
X-CSE-MsgGUID: 86ixH3L8RSC0cDsAgcyR8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="246883943"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 22 Jun 2026 04:18:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Akhil Goyal <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 3/3] test/security_inline_proto: check for capabilities
Date: Mon, 22 Jun 2026 12:18:34 +0100
Message-ID: <20260622111835.233554-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622111835.233554-1-bruce.richardson@intel.com>
References: <20260622111835.233554-1-bruce.richardson@intel.com>
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

Skip the test cases when the HW doesn't support the necessary offloads,
skipping the whole suite if necessary, e.g. if no IPsec capabilities are
present. For event-based tests, skip those if no eventdev is present.

Fixes: 86e2487c5f2c ("test/security: add cases for inline IPsec offload")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_security_inline_proto.c | 57 ++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 81fce7364c..2e1ee17078 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -2043,10 +2043,25 @@ inline_ipsec_testsuite_setup(void)
 	}
 
 	memcpy(&local_port_conf, &port_conf, sizeof(port_conf));
+	local_port_conf.rxmode.offloads &= dev_info.rx_offload_capa;
+	local_port_conf.txmode.offloads &= dev_info.tx_offload_capa;
+
+	if (!(local_port_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SECURITY) ||
+	    !(local_port_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SECURITY)) {
+		printf("Inline IPsec unsupported: required security offloads are missing\n");
+		return TEST_SKIPPED;
+	}
+
 	/* Add Multi seg flags */
 	if (sg_mode) {
 		uint32_t max_data_room;
 
+		if (!(dev_info.rx_offload_capa & RTE_ETH_RX_OFFLOAD_SCATTER) ||
+		    !(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) {
+			printf("SG mode unsupported: required scatter or multi-seg offloads are missing\n");
+			return TEST_SKIPPED;
+		}
+
 		if (dev_info.rx_desc_lim.nb_seg_max == 0) {
 			printf("SG mode unsupported: invalid max Rx segments (0)\n");
 			return TEST_SKIPPED;
@@ -2112,6 +2127,25 @@ inline_ipsec_testsuite_setup(void)
 		plaintext_len = 0;
 	}
 
+	/* Check that at least one inline IPsec capability is registered */
+	void *sec_ctx = rte_eth_dev_get_sec_ctx(port_id);
+	const struct rte_security_capability *cap;
+
+	if (sec_ctx == NULL) {
+		printf("No security context on port %d\n", port_id);
+		return TEST_SKIPPED;
+	}
+	for (cap = rte_security_capabilities_get(sec_ctx);
+			cap != NULL && cap->action != RTE_SECURITY_ACTION_TYPE_NONE; cap++) {
+		if (cap->action == RTE_SECURITY_ACTION_TYPE_INLINE_PROTOCOL &&
+				cap->protocol == RTE_SECURITY_PROTOCOL_IPSEC)
+			break;
+	}
+	if (cap == NULL || cap->action == RTE_SECURITY_ACTION_TYPE_NONE) {
+		printf("No inline IPsec capabilities registered\n");
+		return TEST_SKIPPED;
+	}
+
 	return 0;
 }
 
@@ -2140,6 +2174,8 @@ event_inline_ipsec_testsuite_setup(void)
 	struct rte_event_dev_config eventdev_conf = {0};
 	struct rte_event_queue_conf eventq_conf = {0};
 	struct rte_event_port_conf ev_port_conf = {0};
+	struct rte_eth_conf local_port_conf;
+	struct rte_eth_dev_info dev_info;
 	const uint16_t nb_txd = 1024, nb_rxd = 1024;
 	uint16_t nb_rx_queue = 1, nb_tx_queue = 1;
 	uint8_t ev_queue_id = 0, tx_queue_id = 0;
@@ -2151,6 +2187,11 @@ event_inline_ipsec_testsuite_setup(void)
 
 	printf("Start event inline IPsec test.\n");
 
+	if (rte_event_dev_count() == 0) {
+		printf("Event inline IPsec unsupported: no event devices available\n");
+		return TEST_SKIPPED;
+	}
+
 	nb_ports = rte_eth_dev_count_avail();
 	if (nb_ports == 0) {
 		printf("Test require: 1 port, available: 0\n");
@@ -2182,9 +2223,23 @@ event_inline_ipsec_testsuite_setup(void)
 
 	/* configuring port 0 for the test is enough */
 	port_id = 0;
+	if (rte_eth_dev_info_get(port_id, &dev_info)) {
+		printf("Failed to get devinfo");
+		return -1;
+	}
+
+	memcpy(&local_port_conf, &port_conf, sizeof(port_conf));
+	local_port_conf.rxmode.offloads &= dev_info.rx_offload_capa;
+	local_port_conf.txmode.offloads &= dev_info.tx_offload_capa;
+	if ((local_port_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SECURITY) == 0 ||
+	    (local_port_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SECURITY) == 0) {
+		printf("Event inline IPsec unsupported: required security offloads are missing\n");
+		return TEST_SKIPPED;
+	}
+
 	/* port configure */
 	ret = rte_eth_dev_configure(port_id, nb_rx_queue,
-				    nb_tx_queue, &port_conf);
+				    nb_tx_queue, &local_port_conf);
 	if (ret < 0) {
 		printf("Cannot configure device: err=%d, port=%d\n",
 			 ret, port_id);
-- 
2.53.0

