Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE2606A329
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:40:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B75E94068A;
	Wed, 28 Oct 2026 11:40:11 +0100 (CET)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTPS id E23EC40151;
 Wed, 28 Oct 2026 11:40:06 +0100 (CET)
X-QQ-mid: esmtpgz13t1793183999t277720b6
X-QQ-Originating-IP: 4IBr0n2xoisAjUAc24iNXOJ5A5o5ccZUTy3XFfTsw6M=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:39:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10324828153106678115
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 01/17] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Wed, 28 Oct 2026 18:33:50 +0800
Message-ID: <DB3F70173FCF1FF2+20261028103913.10188-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MowohnWo6wX751zYbs/PYf1lvON4U133m8FNk3WDH9hPNCqsGTHV3Pwg
 /ggIOQIKuN4k9UdbheHMFDasIi1UQUrfRudnDRLaTxHWsyld9Ws9/zpbAIG9Yg9HNV/c10i
 9DvTUWxSJMxMSgdBXiStyj20uUfCR/4G4OhKr921h+raACt+noHeQnqEAxg+Zp4X5ZTb9WR
 wyyu4XW159ZE17ujxzxjdSUeGUL0lLwP81w3Q8BX6SNEDy7ijvHJAqZ7vNFeXvoOmcvfcvH
 UlpjFutiIQDg9gIBmqDmUjQGsbox30xaXD9VI04+6oOyhHHJgoGKiQTYQej2BmLyqQtGAi9
 wHDBpkcTdzxd6we8rYOTbqiKXTWdGEu/OO7jime+8UWorCdC5yPXS55gB5IcZrBGVJT64hp
 SQcDikwlEFXuf5SwKVNcl32G00iDvSPF0zJ35XzJM5xjwWv4VGfJHlQQjXUREMjZ6URaANv
 W1tHYav2zmydp08efPdiNxTlfyBHtySjN34FOHy5fYpnj/tKxBFGUssb2zzL3nrjiD/TyWo
 tRmQo4t5lc0g0F2d8tv0NvUgs7+Xu1Gdl7czN2x4YTAQ4dC6J+TsoXyMXdrnEyIOlZewsIr
 ZyRh/Lxbi/hEISKAB/gkRSnJ4Es3MgclRDO/pf/qaB0QJomxaHes7POvL1LWeqznwIimVV5
 EgkTIxG3/VRFY5ysaAz51ov8YbLNSVaeAX5q1v7sSwOPRpisjaOny6D1pQBfqMZE+AzNp2b
 xZJ1R18ZxM+DuTX++C00IFa5lPVhZBouplInZHkE2zDZAH7OzQaOl/SDHcCMJIzT1Bs0129
 GuglOIbpfbH74ChKU9r+rmcTN+QzOtd324I5vAbTzlCYoSBdlZsx9t0/wOhwm3t8/9ylkpK
 2LsZWw7WbUvi8pUXICrwmYoBq29Qnfqf4Q6NjUA/VocAfU7a+2J+9fQOe9M8KwuatZFL4iq
 clvDiO2BXxWEBGhUqx4kyY9DGVqo0U7S4ED8yism9lJACmLZKcSTr0OzK/qYw0nWeUAHOy7
 q4w6uOUGkSzXOrqlF2mdzd1tvmY8tX1ReeEd7P5BJi5d7Cd5ot
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

