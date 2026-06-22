Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A6CD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:12:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36CCB4066B;
	Mon, 22 Jun 2026 13:11:47 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 2B1604065F;
 Mon, 22 Jun 2026 13:11:43 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126700tf406a180
X-QQ-Originating-IP: M5WyQcW485F83D3x835CCzx2eM5/xi+K+xS9wXhVpms=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:11:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6775411952785327554
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 04/21] net/ngbe: fix VF promiscuous and allmulticast
Date: Mon, 22 Jun 2026 19:10:52 +0800
Message-Id: <20260622111111.21024-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NYzMHWjxYhxlLgb/o2q4KHsN6RrnG35tneEFjqPrw50HZCcyon/Dn202
 K+KUPlsKYYXSki8Z7t4qH86F5o/ytVzIkgxSEWtp5qKadt7hwmAeUXgreDnMRqfE0u+6y5O
 gZRf3srlwxqnR31/Rypr9KFh0ZHkKkH2Ei+6evbH+awVlp/rfSgPHfAQCZbAUYjbYa/TW+w
 iH87ys+E8Zl6u5mu8jtXpptpbsEF16+9X7IWgE0N3B/eRkLqYdxqNNsRYmwg0YbH8ZgP4pC
 fKEdkl3uIjvzZps/4o8xlON9sPRz+vhdHPwe12DfYLL8cTFMdGW1bYo3lhzyAKfrsSmIjxr
 99dwijzIOUCYC8L7FudeucZ7rHnue4ZkoEtCzXdzCFyNein8L3Dkr2+ON/iRfrvIp+yyPMK
 y9jhwxV1JnMNkywYZQvfCBKZHoL3UImJ50SNKvXfgwl9OLF6rSHUAADb9XlUbgQxCYlUu9B
 sBDxgTbYHTpcD4LBIRybp5xsGy27k9QHqkwtXJ7zpYOPDA6RTXzx7aOM22HWJqoCX9oAVG7
 u0BCxwBRcZqDADaJ4Y7EebImbtgtVob8aASR6mnVuCp1b9uNNcWhvvcCPLpAkhPSXY1ib0X
 J+4sJEsNB+UfQDCilX/l8JRqvBE4hbSITS3FJ8UKnWm9gjMV74r+yAXIpcttXfoogpT9Q10
 hz3U66hNeP2brOx+ckxdGXibYQUXMvOnQjWcjDfAZ+4GxBAO32PAP7Kg6nBFz9h7BDdR1XC
 x+mspL8APT8D0jhh547erY6wO/lxKy+CteXyzEQ5gcjSRXXu57jib8c9CWzfBZHR5RTw/0I
 31/fEUXob/Bc/QdQwD62vf69YNoW2B5Tq1M5oE3oDfKWxIFi/ufBrdJazYF+Ap4v/vPzj1M
 dkO2kxJ5OTBZ2aYr/Rj0s4+29il3iwaiHrgozhWrFUnN8bbrxhWSnMA2DhP9nk2PGhJxfdP
 zJa/2aZhUvPzv9RHr0PWE+c3ZQ2Cqr3sTpb9j+mkaymyEa9dWQe0N8SjbwhOepJbLFQjFpC
 ETs3/bejj016Al7SSk1m2UM0nsNU9laLDMsrnFOAoZzA8FZd2Gnq3QDLtLgCtHazbhjk87h
 w==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

The configuration of allmulti and promiscuous modes conflicts
together. For instance, if we enable promiscuous mode, then enable and
disable allmulti, then the promiscuous mode is wrongly disabled.

To resolve this, the following changes are made:
- do nothing when we set/unset allmulti if promiscuous mode is on
- restore the proper mode (none or allmulti) when we disable
  promiscuous mode

Fixes: 7744e90805b5 ("net/ngbe: add promiscuous and allmulticast ops for VF device")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/ngbe_ethdev_vf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index ea3a988df6..c440e02369 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -1196,9 +1196,13 @@ static int
 ngbevf_dev_promiscuous_disable(struct rte_eth_dev *dev)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
+	int mode = NGBEVF_XCAST_MODE_NONE;
 	int ret;
 
-	switch (hw->mac.update_xcast_mode(hw, NGBEVF_XCAST_MODE_NONE)) {
+	if (dev->data->all_multicast)
+		mode = NGBEVF_XCAST_MODE_ALLMULTI;
+
+	switch (hw->mac.update_xcast_mode(hw, mode)) {
 	case 0:
 		ret = 0;
 		break;
@@ -1219,7 +1223,7 @@ ngbevf_dev_allmulticast_enable(struct rte_eth_dev *dev)
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	int ret;
 
-	if (dev->data->promiscuous == 1)
+	if (dev->data->promiscuous)
 		return 0;
 
 	switch (hw->mac.update_xcast_mode(hw, NGBEVF_XCAST_MODE_ALLMULTI)) {
@@ -1243,6 +1247,9 @@ ngbevf_dev_allmulticast_disable(struct rte_eth_dev *dev)
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	int ret;
 
+	if (dev->data->promiscuous)
+		return 0;
+
 	switch (hw->mac.update_xcast_mode(hw, NGBEVF_XCAST_MODE_MULTI)) {
 	case 0:
 		ret = 0;
-- 
2.21.0.windows.1

