Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E87CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:18:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA292406BA;
	Mon, 22 Jun 2026 13:18:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 011614042F;
 Mon, 22 Jun 2026 13:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782127124; x=1813663124;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bXiVAmePNe7xS2SccDf/AP7+Lze0HR4vTltMuFql2iI=;
 b=VdzFFkJmSgUQZIKq+D5kku6aaXCZxcD7GbuS9WgViI8ikSdWVjp8GMtN
 fB7UHDrVRGH6An5UUK3hAvuz1flnpqy1D2gucSIw648jP+uwgxKtx2Nz7
 LbwRez+vGYzX3Y6VC+F+fotHZxtJbF7K98w/AhLu5YH6Npy48za8RM3dn
 OpAwzI/2tPgE9dqVgBoDUHtd72KTf89BTHePX5WhGhYedSkh0AGZbY9+n
 oUBbEO6EfbeHfsvuDrY88qFBXojRBGCc3wNqWAUPW/IgbDCd03YkfaGtu
 /lGn6y/MdGaPPlJL5XoSESEZBhVZpSCGln7Ptr/4zTt3ymt0weB2QCzN9 g==;
X-CSE-ConnectionGUID: T3GrH+vaRT6DmQD0iqZjww==
X-CSE-MsgGUID: XsDPdYLUSa+uGdlEa+6aHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93219301"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="93219301"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 04:18:43 -0700
X-CSE-ConnectionGUID: tEv4wJcZQA2FJm44QhAjZg==
X-CSE-MsgGUID: Q237/7QyTyCtp6C+lhtvBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="246883938"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 22 Jun 2026 04:18:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Akhil Goyal <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>
Subject: [PATCH 2/3] test/security_inline_proto: fix MTU calculation underflow
Date: Mon, 22 Jun 2026 12:18:33 +0100
Message-ID: <20260622111835.233554-3-bruce.richardson@intel.com>
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

When testing with some NICs it was observed that the max MTU calculation
could underflow. Despite the RTE_MIN, due to integer promotion, this
lead to the configuring of the port with an excessively large, invalid
value. For example, if lim_nb_seg_max == 0, that meant that
max_data_room - 256 is -256 for comparison purposes using standard
integers (promoted from uint16_t). That is lower than the max mtu so the
-256 value is chosen, which becomes >65000 when converted back to
uint16_t.

Fix this by a) checking for seg_max == 0 b) doing calculations using
uint32_t and c) checking explicitly for underflow before subtracting.

Fixes: 3edd1197a605 ("test/security: add multi-segment inline IPsec cases")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_security_inline_proto.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index bc3ef54f71..81fce7364c 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -2045,8 +2045,19 @@ inline_ipsec_testsuite_setup(void)
 	memcpy(&local_port_conf, &port_conf, sizeof(port_conf));
 	/* Add Multi seg flags */
 	if (sg_mode) {
-		uint16_t max_data_room = RTE_MBUF_DEFAULT_DATAROOM *
-			dev_info.rx_desc_lim.nb_seg_max;
+		uint32_t max_data_room;
+
+		if (dev_info.rx_desc_lim.nb_seg_max == 0) {
+			printf("SG mode unsupported: invalid max Rx segments (0)\n");
+			return TEST_SKIPPED;
+		}
+
+		max_data_room = RTE_MBUF_DEFAULT_DATAROOM * dev_info.rx_desc_lim.nb_seg_max;
+		if (max_data_room <= 256) {
+			printf("SG mode unsupported: max data room (%u) too small\n",
+				max_data_room);
+			return TEST_SKIPPED;
+		}
 
 		local_port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_SCATTER;
 		local_port_conf.txmode.offloads |= RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
-- 
2.53.0

