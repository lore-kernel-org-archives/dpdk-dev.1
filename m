Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC662CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:21:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39EE5427DE;
	Thu, 16 Oct 2025 13:20:11 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 71FAA427DE
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:20:09 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613605t596f4452
X-QQ-Originating-IP: kWnvcOEIcKJ0lOheF+sPUFUUODdkHeZyTfpd58RNxhs=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:20:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13531527434320973123
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 19/21] net/txgbe: add RSS for Amber-Lite NICs
Date: Thu, 16 Oct 2025 19:17:33 +0800
Message-Id: <20251016111736.25372-20-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Nz0ZcpMglVeMAWXIF5AvV7DbdJW7epD2Ka13db2I1uZ8PVSgARzIVQHd
 en2WypdjUvmud5t6raJ5MkqsLzw9KyvTdMCzGDaB4VQS88OBsP9RTTxIAexYjyV0ytCZAfI
 7yNozxUvZsbd2OMA9t7Y6BzHoHl58jTjpVci9sf6rNpRT3wszXJyiMEaiMCHvNILJegeFhO
 h9EeK7hJJKUfRhn5HUJhivu40NfA3UdSRry3IJ/nVZ8JwrZbVOxDtiHb1XW7Tqh5hdQoopT
 T2ivTZN+7xDGxH33lhq3SmP3hwCwM2nEE3UNLCXp5RrDs2IzfWfzlD7EqgIMGeJiOj4cPP0
 TmgbZU8AKDEKJQlzYV7l0lu9YC7CsAN4r8OQXsMOJbtdAoAHjJIxqd9i1QOfmjqy7gyofKQ
 X7i+sCZPAIzgYvAEnDBlyIC5L3inzyIk04aUSHKtwJw5iZQ8PkoN525T91z8i9YeRCdGKHq
 v1i70Yeadffgqmqd8ejJWYBDq2FC7zbWW+rhmUWjHyfFTIntzd+/HdGFJ2z0iUIq7wGMkQp
 Nq9jDQEGFtm7JIigQTlHtUkXy9Wa7Br76eSx3+DXks0Ur+MkAaMfZ2TMKNeJy9C8aQcWdCC
 bI0OR98YTpTQCIRO4WBq08wC4XhBhOufhxyE6LnKwxzOBUDw7jm43dxwn5AJUeBxaF6RV0E
 BL3kXo67p5XG8hD0GVwBfsdTjz+nkhk8d9sWoOv24fTCxiLaWP+KFTCEgauqMZPCCuxYEGF
 QVkYHx+Gvg2fNE3rkhSJZ5GjHrI7dbA+uTtByzQvJrkxJFAp+CgnVddRDFifiSq9UHFttgk
 sPAwBN7gPLlYU0m3f8IT06pj6/tvTz1vJZmmw3QoqzCqOlydPCLjjB0rg0rr1gfUz0QFvLy
 Hz607vg1v8Z0OQxlzo2pfTMLiBwNi2yI8ov0pfHdERpzFxTpCd3rr9kT/HYkzbARw48HISK
 SYw2uEnqceLix66+4hhX3CyV/QckVWmlZnjF6yXodXy337SuPTR+LiuetNq6wHgpdBCY1dR
 7b3aBzcEqRUwibVWoNYgxL5S3llTHzpoEaUNFiUr0U2Pd6UH7/aEAVy282tonO0UXbZiHHM
 b2wkFsq2SX3jB9snOwKGBk=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
index 23e8348051..053aa1645f 100644
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
index 9c2b740d2a..167bda8019 100644
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

