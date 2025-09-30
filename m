Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7350CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:02:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6318D40A67;
	Tue, 30 Sep 2025 12:01:12 +0200 (CEST)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id 712A240A6D
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:01:10 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226464tedd72ce0
X-QQ-Originating-IP: +WQc+99DG+pKG9f4bDKnr0SoRQrb3wfLINY1PmXHPDI=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:01:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4731497485129363524
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 19/20] net/txgbe: add RSS for Amber-Lite NICs
Date: Tue, 30 Sep 2025 17:59:51 +0800
Message-Id: <20250930095953.18508-20-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: ONMinSPvVgZRXaw7VJOQ9aH9yjQ3X1RGXvf8ipVHHs7hjjDl7KOqwqz9
 FYniCaDjlo/RZNs//nVclvRPHdjyRVR7tiO1a0GadhVGa0eWylTD480GNWzOnmRSzH5Qzb7
 wp5vs20vj6VZZLgOTWwx0UmNnv/rW9F+fKNhKxqyjxseOiHqYd8R3bK24hAGv/wq0yxcKhE
 h/XZKBICqpDz5MdOfmjxrMaHCJe3lVJZ3j6dXNfEnMMtkoME5Rl1SHCDMt8deCkRNEKCaQ2
 BeG+VxRVYzGfx/awUCv3JG5RepzryGSS+gbFwDpp1rUqIOqSFN7T4tOX9PpVlrp0HQEHfjX
 me82yDPDulrrvwn9tF7T0Fui2oGHgjhHPeDDtDr061pd4PmbGSJHjFGDXd+OoPelxVBI2T9
 2JgCJMBvw73+rpk1IIZYss55LFXB11yI3FDFNOqjtBBpIx77Tg6a8pLwupaF8rkycAc9iQl
 gxSmxnw0nVBR8r55nzwakTe5+PzpgqkKeHVDoaSsLLCExzNlc0wLgC8cGS9Q7PZxk+F0Qal
 vVFwmIuMKLkPwFVtIGsKTmEXx/KvzxlZp1dgM2cyIJIYoKtyjbrtYN3KTHATMiBbmyA7dy6
 niaZy2KpdK2zvsvgR1Uitr6v1/Zurp644AejyxypEE83jYvszdMpom8dw7Q3oX3mfpKxjHf
 DFwdaURWg3bvRVpDBJOiTXTyrO0Cpgekx4cJfLUB6sA9hld68daLQrO4cnm1lyteWuIj6nT
 QIZvMBnRhp6UnmAkzk0B+hrA/qBORuXnlocEQ4kdo6JF6FfXFD+AnIj1/Qk2yyfYrecd9DD
 3/g6j0gE3PdoJRYjEFqz5rzPWhGt6xC98waZI6uWMq1Vcwx0/VO6Nc7nVmSkUQ14beFyDwx
 O8RqqLYqM0Byx24VlhlDxIihBWb9AEDAFg7YL6LPLdVcJWEhTSsqYvMntILC2VlGlVr7D3P
 WReF/mRE0UYLo2rtN11aEGQznS889lHCM4iIrhFqOHZpXxS+DgZXKOAnNG/m7MRvkYLgBp9
 5Mu+oUljUahuOEjy70mSt2lcBlxL4LcJOFbN7YvWtZXtDxaJy+fK7bknsC1CzHg3S9g1XKX
 eKkOE8L/KxP
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

Add RSS (Receive Side Scaling) functionality for Amber-Lite NICs.
The Amber-Lite NIC series provides comprehensive RSS support with
hardware implementation identical to Sapphire NICs. This commit
enables RSS by applying the existing RSS configuration directly
to Amber-Lite NICs without requiring architectural changes.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 7 +++++--
 drivers/net/txgbe/txgbe_ethdev.h | 2 +-
 drivers/net/txgbe/txgbe_rxtx.c   | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index c7c3668066..768a4b4997 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3849,7 +3849,7 @@ txgbe_dev_rss_reta_update(struct rte_eth_dev *dev,
 
 	PMD_INIT_FUNC_TRACE();
 
-	if (!txgbe_rss_update_sp(hw->mac.type)) {
+	if (!txgbe_rss_update(hw->mac.type)) {
 		PMD_DRV_LOG(ERR, "RSS reta update is not supported on this "
 			"NIC.");
 		return -ENOTSUP;
@@ -5174,11 +5174,14 @@ txgbe_get_module_eeprom(struct rte_eth_dev *dev,
 }
 
 bool
-txgbe_rss_update_sp(enum txgbe_mac_type mac_type)
+txgbe_rss_update(enum txgbe_mac_type mac_type)
 {
 	switch (mac_type) {
 	case txgbe_mac_sp:
 	case txgbe_mac_sp_vf:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
+	case txgbe_mac_aml_vf:
 		return 1;
 	default:
 		return 0;
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 9295d8fbd0..15fa888aa2 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -517,7 +517,7 @@ int txgbe_dev_rss_hash_update(struct rte_eth_dev *dev,
 int txgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 				struct rte_eth_rss_conf *rss_conf);
 
-bool txgbe_rss_update_sp(enum txgbe_mac_type mac_type);
+bool txgbe_rss_update(enum txgbe_mac_type mac_type);
 
 int txgbe_add_del_ntuple_filter(struct rte_eth_dev *dev,
 			struct rte_eth_ntuple_filter *filter,
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 957aa5c6eb..4110e7b681 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -3111,7 +3111,7 @@ txgbe_dev_rss_hash_update(struct rte_eth_dev *dev,
 	uint64_t rss_hf;
 	uint16_t i;
 
-	if (!txgbe_rss_update_sp(hw->mac.type)) {
+	if (!txgbe_rss_update(hw->mac.type)) {
 		PMD_DRV_LOG(ERR, "RSS hash update is not supported on this "
 			"NIC.");
 		return -ENOTSUP;
-- 
2.21.0.windows.1

