Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE041606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:42:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A152540611;
	Tue, 27 Oct 2026 12:42:25 +0100 (CET)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTPS id 15843400D5;
 Tue, 27 Oct 2026 12:42:22 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101338t45ef3226
X-QQ-Originating-IP: odYBp37NNu+8IQNgSyR6DJde+L5r2WlTtpt85fzjdQM=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2294157718085051839
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v12 01/17] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Tue, 27 Oct 2026 19:38:17 +0800
Message-ID: <3335DBEBB0A509F0+20261027114218.9724-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261027114218.9724-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MfPhJ3En0/NFd3iri2ayT0r7QSM729ZslqqmL/kFXXyW/G878z5aU3/G
 2d8o2F+ZMi7XQdOPkIle2im7dBY1eHv5cPzgzaWcWX+Y6Du8UgTl0zopSj8C/63pd3E5KMD
 K3P81H+mwH9e2xcxkH+Z9jOOLVTYC14+u2n9iHCjTfxJQemjSC6cQt3X3GAsPGc4RKN9HVN
 YC3f0MG7A+oi/8ReNf+afJLQJTSA8S8zBprsLaXC19+v0XjC54nu52GMM84lbOCi5RYyRFf
 +pw5lPEAbCJd3yxM0k0lP41VS1aOqqVZN3km2gVUrqtZ1TOptyAZ9uqUrVfjb9wC2YuAh4J
 NRTiuPzCZIWMqx5wRXmiqz1bbc+KFpcOhNCuKCxMFx8MdFOZiHI/z5Ly9I5AxY4Ice04gxr
 nGtRwoXS1Uhs4TQxdSsr0EXkUfxFts4HNLB5QPyQka9mjwYARfYs9B0w91n4Nlux6YrssIz
 XrXIoomehSoY/Jp07MsWm2Emq1nSVvD/om6WRcl53RBJ/36PuFguHD9t/ZzmgFy7Mt951V1
 mTHAnj3Lx2OH3MjG6wYVLE6U4uZ7bMijz7FOJgqAnU5rWElHX0rn7shpxUr5qUWbg2h2xBS
 kOKHUgVNUw089rajCpgDNsX8xc9U9Ga98OXYdMsiS/NZryTMxSPhmwio2pGpbgfBQPwQwJi
 NAdYfjKn7/kY1hA173QJ8TwnUorVgLq6zBQNspJ6DpiXwBH/z7crqxSBq4Y0iJoY563K0tc
 qruDsbjbOUfiPbXMmuYIJMGVFAOyoZID4jxjBDABJjNDW3cQFIFaV6uYtB5d1Qv3hCNyQYQ
 ZNYNSKXXMsCIBm31SNv6a78baAmBZctvhZslj1Jhw4M03jHDCgN9IGtBwn3PNRoufPGYGai
 QBsaxHcXoFd7FD8tVEbZWSHuvQQ01uSq8nObHNqSWeeCni/08lwx8PMKFDlVIcdImcA8B96
 PJUxOL8fvFa1qQyD0CwEtL4lxoS8Aue+LUm/O75tx96W9mkOfN1XqkGRc96/ryemF6waMWv
 sXUSbBTOrQcf9OTSj/FIOaomVC/GIs/flOEeqA4pi8BP/bBdbD3V1ICtUNNh0=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Setting "port config speed 10000" on a 10G/40G dual-speed DAC cable
fails with LINK_SETUP_ERR, and the AN base page always advertises
only 40G.

Two checks independently blocked 10G:

1. allowed_speeds in dev_start was restricted to 40G, so the user
   request was rejected before reaching setup_link.
2. get_link_capabilities_aml40() returned only 40G for all DAC
   cables, so the link_capabilities mask in setup_phy_link_aml40()
   stripped any 10G bit from the caller speed.

Remove both restrictions so 10G flows through from user
configuration to the AN base page advertisement. On DAC cables the
capability is read from hw->phy.fiber_suppport_speed, which reflects
the actual SFP module.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 15 +++++++++++----
 drivers/net/txgbe/txgbe_ethdev.c     |  2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 1098efe5e6..7c72b53f64 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -98,11 +98,12 @@ s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
 {
 	if (hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core0 ||
 	    hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core1) {
-		*speed = TXGBE_LINK_SPEED_40GB_FULL;
-		*autoneg = true;
+		*speed = hw->phy.fiber_suppport_speed;
+		*autoneg = hw->devarg.auto_neg;
 	} else if (txgbe_is_backplane(hw)) {
-		*speed = TXGBE_LINK_SPEED_40GB_FULL;
-		*autoneg = true;
+		*speed = TXGBE_LINK_SPEED_40GB_FULL |
+			 TXGBE_LINK_SPEED_10GB_FULL;
+		*autoneg = hw->devarg.auto_neg;
 	} else {
 		/*
 		 * Temporary workaround: set speed to 40G even if sfp not present
@@ -176,6 +177,12 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		return status;
 	}
 
+	/* setup the highest link when no autoneg */
+	if (speed & TXGBE_LINK_SPEED_40GB_FULL)
+		speed = TXGBE_LINK_SPEED_40GB_FULL;
+	else if (speed & TXGBE_LINK_SPEED_10GB_FULL)
+		speed = TXGBE_LINK_SPEED_10GB_FULL;
+
 	if (txgbe_is_backplane(hw) || txgbe_is_dac_cable(hw) ||
 	    hw->phy.ffe_set) {
 		rte_spinlock_lock(&hw->phy_lock);
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 0734a1c63c..d4c635dc2f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1848,7 +1848,7 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 		goto error;
 
 	if (hw->mac.type == txgbe_mac_aml40)
-		allowed_speeds = RTE_ETH_LINK_SPEED_40G;
+		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_40G;
 	else if (hw->mac.type == txgbe_mac_aml)
 		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G;
 	else
-- 
2.55.0.windows.2

