Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ECFCD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:29:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3827F40670;
	Sat,  9 May 2026 13:29:04 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id C790540667;
 Sat,  9 May 2026 13:29:01 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326138t12a2b70f
X-QQ-Originating-IP: YlCq30dmcfV5nYjY6vsjVcnyQJOGaP3+fRRRAwlU2HQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:28:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10382975971416493406
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 04/20] net/ngbe: fix VF promiscuous and allmulticast
Date: Sat,  9 May 2026 19:28:06 +0800
Message-Id: <20260509112823.7728-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NV9lVvsB36Op4Yp6UIZyYdkI7p38inL8dbcxp/iC7hYBZyi7axW71B+G
 27Wo45+k8wepuo8nPyHJXefBCVl0cGdB2qHjAMlbmukFkQmYZZT6b4l+E8jPJQvxEUI5e1F
 lfYM1F2sR5wV+wAse1LxZgqwSMcTWzjKoxn4K2yaPqwfP/ISmhm95Ca8ZbvAeEbKZNznDz3
 x1kD//VSWshGteHqXA3oI5OD31+K+Xk3sZ/q68TQoU8px+BF8xWcoprkf6etnPEfF/0+hAs
 emMgfm/o/7jbpbFYkRMnLuyl43ic0ATI13QN1nG3jMQ6Xf1MLSe3MsjH5zfjtwYyMrdpfRp
 Iw/sFctP69HF+XG7OagVf6qYBQJ1hP/4wLVqkTWgO8bdlyin1a8024gEMhENjyWWTgeijdu
 ZjDeIiYe2bRvof9Jo0n67LpqaO+7h5dBix9Gf2874/91fcGAW7Wx8lIuYZnGv4Dc3X7AS6U
 d5Y2sthOZHhTAg3mp84OqeTaBDXSomczEMUnsCkMwMfjZNM1yy6j/mTb0zOUN1QnmVWPDuD
 cGK1whzCMfzqz7Gef+gAnuHTH5VnnGSC9CMW95E2bNpJwxVXfnMsDxPiPm8xBGzh5loeQo0
 nQXXuPhSb36JDWDIv2tzmI213B+BHD1H6+7lRj5UYUbziMyru4E0sjijGpuxkmWzmFNh3IN
 138oGqo3DjGnXmwfi4UaUjNpkDeVhwJMYgOHmC0R9DnCA70N7N2VB+SQMGku6jq4F3cVtda
 70x+6kFS2Dl1xCKQfTNBAdkkGxjBaE+Wz5cUPl90lJpILnD8HUJcoFa413sajHr9H3kE6z5
 dUk7070Q3XLiBMZF6LufaKpyxYKggC8YYxfqTESqpDUuIMuvsq4y9Sr0XkoPelOFYSXFLrM
 Vtx/+yn+7ngjoEzaNcdv6Fx68Vgz+OBk44g818OQJE3aM7Vx1Se0sFJ55rXkaIaSYAyUpEy
 X8ZDRP6fwkylRgOfRvlwbLkPQTJsEklh0tTCrxAvxYRbQWbmGnVTMJIvVuTBFczZERWZIXG
 wSmV4YdYaVdBxVJ71Mhy+vR6YAk7eDH56gUte7LY+1VdokJ6xhnlpUH0+SMkA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

Fix this behavior by:
- doing nothing when we set/unset allmulti if promiscuous mode is on
- restorting the proper mode (none or allmulti) when we disable
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

