Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218F3C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:41:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77CCA40EA5;
	Tue,  8 Sep 2026 14:41:16 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 7237440E3F;
 Tue,  8 Sep 2026 14:41:14 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871271t3c744005
X-QQ-Originating-IP: crMtVbmTseKZUSl0OfKd7jzy/Z0n5lkNfyWVdfY2kSs=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:41:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1570199784855264526
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 06/15] net/txgbe: fix link speed display info for 10G mode
Date: Tue,  8 Sep 2026 20:38:51 +0800
Message-ID: <674DD06AFF6AAE7C+20260908124047.2284-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MOfz9TzWtqads0fPA2bnt1j8gpSkvnJ8lDUF9YBIjFVKouhB1kJSrrVH
 jsNCziNDFC0yCKdqGjdpF/cFequfCZiArujHa+w7EyN6Q9Ey0E6o6MsKeBdPEBHBq37GRal
 tStxq5/02IjDKfxPdn9v60149r/GNxn8gQwKow7OUFfxCYldyOYT3Jw8EFLCk3yVi4GDMJZ
 JKYU5DJcBh2Zn0yHcrJpH1AE16kzOcvYtC8NxuQGhdsY7SfEpJRfqaG0K2vkn16Dqd+ePrW
 /CcRkCduDw42N2o0HBONF+Vj21Nae3S8LkhfoLIaCOe+otlbn817Tsj9x83fzFlm8Ts6ykR
 pyzMl4+b5TwdbKwLLwnrHfjiSRHmnQ4eTYYwOn+jppz3U3SgX7hcDY6FAKuexZhh/Rbink4
 D15/3jQYoEgPtQKb/JGhtDjFGr4C0VU/hb+RrBFNTNxYH+1QXRmP6HvtcGjJsTtuvpIsKVU
 0+JPVbeFcHUMQFeNq4JlOCa6AysjecJBWLMJqSph/AK+H1cTTYFyKZ3Bc5dQF4YclzGhWDK
 wN9D7CW3Eso4B5EjFsI8EdP8tO9uMltqx4tmG6QAO9lFH+i2lvH4S0vAR9uJGU3knrA2UmF
 cOT11ZUjMosqz5Ocb3DnuOVB4qhA5nBUza5Gzgi0V3/cHqGfqleyH3pGWkok3hR9hlb6MK+
 N7CI2S7xkZ2IXwFtkvo2FAuQMv1MDJ0tXcIVV7IBGgJcnuCSYQNjsOEsvFPUPPyI306eRwr
 bbtYMnXzpHesG0kln54liqR27ygHauuvM0fKL6Dh7sfBduG4nSfj6pbqi6y8lQbj6GolPFg
 W/0GzH6o12JUwp8W2hetQXtELvsXZMs+0iYd57Ibm+xUR4JZQl+Xc/rLesSVLaBNX78IgVS
 VvJ5zRT9wPPN28wWPn/NDDSFf8qYWUU5hCYviKFOgvcMbVmfFR7uYIaFsbz6pjy37cB3DH1
 pQEqxPvKciDSPuo8QzNySN8sjPQA5D5mo1hoqTCwfWqbWMpiMoa+zGahaeZea5+sSlsiaip
 YKLpdvX9fpJVjPrfXUZ10MV9WLnsBc3WBZet5S32kr5VV/nLDQ6CoTizcUwCsBFj6tf4XH4
 ON7nfgDCd5kQLMLDSiRXiAmODdCDMFGPA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
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

When an AML40 port links up at 10G, DPDK reports the speed as 100M
instead of 10G. The 10G link status bit is not recognized in
txgbe_check_mac_link_aml40(), so any non-40G speed falls through to
the default case (UNKNOWN) which is then reported as 100M.

Add the 10G port status bit recognition, and include 10G in the
default advertised speed mask in txgbe_dev_start() so a 10G link is
reported with the correct speed.

Fixes: abf042d32b39 ("net/txgbe: add Amber-Lite 25G/40G NICs")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 3 +++
 drivers/net/txgbe/txgbe_ethdev.c     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 5fa7c6a243..d812adac69 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -85,6 +85,9 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
 			TXGBE_CFG_PORT_ST_AML_LINK_40G)
 			*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) ==
+			TXGBE_CFG_PORT_ST_AML_LINK_10G)
+			*speed = TXGBE_LINK_SPEED_10GB_FULL;
 	} else {
 		*speed = TXGBE_LINK_SPEED_UNKNOWN;
 	}
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 9e4eca40cf..bb4ff3c492 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1912,7 +1912,8 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	speed = 0x0;
 	if (*link_speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
 		if (hw->mac.type == txgbe_mac_aml40) {
-			speed = TXGBE_LINK_SPEED_40GB_FULL;
+			speed = TXGBE_LINK_SPEED_40GB_FULL |
+				TXGBE_LINK_SPEED_10GB_FULL;
 		} else  if (hw->mac.type == txgbe_mac_aml) {
 			speed = (TXGBE_LINK_SPEED_10GB_FULL |
 				 TXGBE_LINK_SPEED_25GB_FULL);
-- 
2.55.0.windows.2

