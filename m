Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E74606B352
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DJfUJKJf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 555F2427BC;
	Fri, 13 Nov 2026 09:49:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 867174029D;
 Fri, 13 Nov 2026 09:49:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794559760; x=1826095760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gpsseinsbPl7bECGSNOMTA2G5ZWQX7TTAuNxH0cpx5U=;
 b=DJfUJKJfMHarEK6wHt1uE0aaKaSd0A5PAwQl/xvgG1DzSTqPPRc8kxOk
 HbPk5Md8EQqsBqKP9FWrOMqCRNkpubuCk5MdZBITi6Sv06+GVtpWJRB5M
 OF9x1z1aykvmr9dDamMZw4IY1M6WSUbrbaGDZxhM7Fmy/gpeeh+D0y+Wq
 hZWftedEUhpgXPGUkDxYfexTnXlKpLbcjWLc3yfudaItPgDSA1FEpG0S+
 G1bkt6PudSR4nWQyBWVe2X+BkIe1Bzrrb/d3RL6EqtOqEpkcL2Wdq62Ad
 0CbdAfA9Z9F9b99VItwd7ClAelCUjMfjRBio0ivtKLoPw0g7otIlLZiwc w==;
X-CSE-ConnectionGUID: G6H44ETFTx6pZQjE5nWGZg==
X-CSE-MsgGUID: 20e8hhsjQ4y2ObcfaC05sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3278022"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3278022"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 00:49:19 -0800
X-CSE-ConnectionGUID: rVKoVniRQeOv3mijKO1QnQ==
X-CSE-MsgGUID: 7BP+4ecZS+uuGTKOoITq+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8795306"
Received: from icx008-fc43.iind.intel.com ([10.190.212.196])
 by fmviesa004.fm.intel.com with ESMTP; 13 Nov 2026 00:49:18 -0800
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	aman.deep.singh@intel.com,
	stable@dpdk.org
Subject: [PATCH v1 1/1] net/e1000: limit 2.5G inter-packet gap workaround to
 I225
Date: Fri, 13 Nov 2026 14:17:26 +0530
Message-ID: <20261113084726.4059806-2-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113084726.4059806-1-rajesh3.kumar@intel.com>
References: <20261113084726.4059806-1-rajesh3.kumar@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

eth_igc_link_update() unconditionally programs TIPG.IPGT to 0x0b
(15-byte inter-packet gap) whenever the link comes up at 2.5 Gb/s.

This is a workaround for an I225 erratum: when two I225 controllers are
connected back-to-back at 2.5 Gb/s, the receiving MAC can drop packets
that arrive with an inter-packet gap smaller than 8 bytes. Widening the
transmit IPG from the 12-byte default to 15 bytes keeps the link partner
above that threshold. The wider gap costs roughly 0.2% of transmit rate
with small frames.

The erratum is specific to early I225 steppings. Applying the workaround
to every 2.5G-capable device also penalises I226 and later I225
steppings, which do not need it, for no benefit.

Gate the workaround on the I225 device IDs and on revision_id below the
first fixed stepping, and restore the default gap at other speeds.

Fixes: 4f09bc55ac3d ("net/igc: implement device base operations")
Cc: stable@dpdk.org

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 drivers/net/intel/e1000/igc_ethdev.c | 39 +++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index 2c8ff57e6b..5fb245f46b 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -50,6 +50,10 @@
 #define IGC_CTRL_SPEED_MASK		(7u << 8)
 #define IGC_CTRL_SPEED_2500		(6u << 8)
 
+/* TIPG.IPGT values for the I225 2.5G inter-packet-gap erratum workaround */
+#define IGC_TIPG_IPGT_DEFAULT		0x08	/* 12-byte IPG (hardware default) */
+#define IGC_TIPG_IPGT_2500_WA		0x0b	/* 15-byte IPG */
+
 /* External VLAN Ether Type bit mask and shift */
 #define IGC_VET_EXT			0xFFFF0000
 #define IGC_VET_EXT_SHIFT		16
@@ -469,6 +473,24 @@ eth_igc_interrupt_get_status(struct rte_eth_dev *dev)
 		intr->flags |= IGC_FLAG_NEED_LINK_UPDATE;
 }
 
+/* I226 is a later stepping that does not carry the I225 IPG erratum. */
+static bool
+igc_is_i225(const struct e1000_hw *hw)
+{
+	switch (hw->device_id) {
+	case E1000_DEV_ID_I225_LM:
+	case E1000_DEV_ID_I225_V:
+	case E1000_DEV_ID_I225_I:
+	case E1000_DEV_ID_I225_K:
+	case E1000_DEV_ID_I225_K2:
+	case E1000_DEV_ID_I225_IT:
+	case E1000_DEV_ID_I225_LMVP:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* return 0 means link status changed, -1 means not changed */
 static int
 eth_igc_link_update(struct rte_eth_dev *dev, int wait_to_complete)
@@ -528,11 +550,22 @@ eth_igc_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 		link.link_speed = speed;
 		link.link_status = RTE_ETH_LINK_UP;
 
-		if (speed == SPEED_2500) {
+		/*
+		 * I225 back-to-back 2.5G receive-IPG erratum: widen the TX
+		 * inter-packet gap (TIPG.IPGT) from the 0x08 default (12 byte
+		 * times) to 0x0b (15 byte times) so a link-partner I225 does
+		 * not drop packets; restore the default at other speeds. Only
+		 * affected I225 steppings (revision_id < E1000_REVISION_2) need
+		 * this; later I225 steppings and I226 are excluded.
+		 */
+		if (igc_is_i225(hw) && hw->revision_id < E1000_REVISION_2) {
 			uint32_t tipg = E1000_READ_REG(hw, E1000_TIPG);
-			if ((tipg & E1000_TIPG_IPGT_MASK) != 0x0b) {
+			uint32_t ipgt = (speed == SPEED_2500) ?
+				IGC_TIPG_IPGT_2500_WA : IGC_TIPG_IPGT_DEFAULT;
+
+			if ((tipg & E1000_TIPG_IPGT_MASK) != ipgt) {
 				tipg &= ~E1000_TIPG_IPGT_MASK;
-				tipg |= 0x0b;
+				tipg |= ipgt;
 				E1000_WRITE_REG(hw, E1000_TIPG, tipg);
 			}
 		}
-- 
2.43.0

