Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A704ACD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:36:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CEE040679;
	Mon, 11 May 2026 12:36:41 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 649B040664;
 Mon, 11 May 2026 12:36:36 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495793tad9c81bf
X-QQ-Originating-IP: 32rd6UDFykh2DbNazVfb+kR9+nA8jQOR+l/qZJh+TqQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:36:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17326141470727229993
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 04/20] net/ngbe: fix VF promiscuous and allmulticast
Date: Mon, 11 May 2026 18:35:46 +0800
Message-Id: <20260511103604.19724-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MDlC9u6qHHGcu1WcI8TZHnn2PCnbszuJgazyPbPrfmgdyaoN9WJ+Dzc4
 S3IhyVOLdybUIox70S53fC+MLFwdAtTWjjskSSEUaPZgf65zS6KI9UwUtqQoB6yJdICWm4q
 Hhg2ADAVwuWWtTnM2AEr2LDvWsnF8TojY8bxb6maOi72fa3vWIE+fFxLgBhIDUyzxaQIVIX
 bIfqdeTo57HCSjRM5VnaBTf6+sizA/Yb67r52M0NkBbQsgOSNsBEpm/MZhwU9Cj2Xmw23oN
 qCnwp1Pcv+TEfJ89haLx/a1TJTLacypVdCzMPNPGqFQOT++aucxEpdpR92Rm61m1Z9ydq8W
 Um9D/SYUTWbCR0CpB0vQ/TsQWpMt5adEkOo4qM798TxpbyX6JnrzVi5mYvIyCAp5M02BHMl
 /hzexopPjk5ezqUZffpgdktW3u3yL2Jqt4v4yLUIYHj6kv/xpRRMhmJKa6FVJBlikgN9921
 tVe2b4gnqgkcz2tOlBOAHOdqN6OKxcpeF/LbskW0Q9knMuEfgVIhZt2bJ4VyPSWJ7OXry6A
 majjlLeiFUtocQ9IYx/KcucWMTFdB2BNkmMPPqQFRe4rZrSqluU1qd1wGPvgkYwP/7yfkhY
 nVJdgSQdDVAMyrZqHS5z+xOzvIoAMVUmlyPHKpjuPz1wQIY4L732l8JLjn+M+hs8beDWFba
 6XFbhna5YbFYWgl8mK6tyFT5Do3URCpezB8t0iWJXsyO1wppTcI/qdaj9BO9CmDv5MZ+tD0
 Espq3SHWpexBwIGP6NnvsFvRDGKmMBye16T4GbTtV7WzJ0PPa4JQxRai8ZT8Zn4GKBqHQ9J
 QqJxtnNFjbUg6nq8qv/MNYuxB0JcMQCVKqDud7QI5/MheEsAa2Is2CqnU7aArHMylI4yaQX
 0KdpvzprStRaDOC8T7O/HvimEYfLA606l5LYOInsWK0fif+53AOPvuj2E+A32yJ4pjFKTtz
 fPyCDjgSCC5H0RGzcXyVe92oOzEThVIv0WHgWFpTU5lN5xCXOSUwZllP6GRC2pfSL7snRR1
 f1lLzEtdjzFoShkzjA1/csyr6mdMhHdo07atwnPJDUTS0cnu7TxCOpSDumgIg=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
index 6406df40d0..81511fed8a 100644
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

