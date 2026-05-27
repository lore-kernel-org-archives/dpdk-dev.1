Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C91CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:03:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4EC740685;
	Wed, 27 May 2026 15:03:26 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id A248540661;
 Wed, 27 May 2026 15:03:23 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887000t513339b4
X-QQ-Originating-IP: +8+ehxjHyPHxw9FrZO0RmD4LXklHwhfQLWj8huDcgNY=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3092623019518746495
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 04/21] net/ngbe: fix VF promiscuous and allmulticast
Date: Wed, 27 May 2026 21:02:04 +0800
Message-Id: <20260527130222.24348-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MAMW4dxoxFytU24cJuiE/goI5kp4JttuKvMujUAxQVjSVydsihd+RZCW
 +ggghTF8K/Y1ZToilfYxpGlGI/wd1OHfunuvLItGZuM/V4FQsFQUdFxC0Hq+14ALk0ZIDiY
 Y9edcIDKPfhcJH9s8mP9sP0aHc/MRemR26wSj9BBRUt/zMsyQAS8DkyXE+0x5x0o0MWARbg
 oJ2Pe6gPJNMQnbh4oIa4FqdvuyVB4nQvW/i/6ZKrwYdqi4TlsooQyym8JK0xR7baGkv5WMA
 pNlkp7XpJmJyWcU7HRrmVp86pTknv28Z2DY+1ApWmxLRXnGItaF5yXSOWlq3b/V/Z3vn0iL
 huZvHT5fsIRo346t9ahtKTx10aURzkac2LAyxVSgWlE+sYUkE1qzDhK92KtPpS7eciAvZie
 A8iZ8VBZBpx+LfbFPnbr7n9gE/QpbKqrTzYMWI1r9DYzKTTBZPQdwo3GeIRnjjE3IM6BiBF
 ieCKiByGGHIzXV/BCFPRzKwiP592VIifF1NSDde1+2KLZjNqY/vTr79o/soo+F+1ug48Cpd
 366FgK0QBZhyXEYJdJVgqtYzLOkdcIXtgYts2GahnZaPijWti+0bXVmoFDXJ10dmbAPbxih
 pYlaXz94zFYBQsvEYARXkB3iu4eVAh2riJpAClq4iNATDUxh0RSBci6efM8dPORSCOcc2x+
 Su27Y0fQDT6lZOEVjrEZz7D0QBCqcnmPQjkRbmWJ0SKP8bmr56NKPloQUg25ByGcLyFXkB+
 sgACRxvHB9G0o2E6FTJ24FP407xl+nVL3NyXq01pz4ERmiRv8o/LT8nsMr35Pof2dgigoPi
 AzSqqM96VN7COmYUrM57sjyVHAs8X5PTnceFtJeHRXuafkbprXdcUZS6ExHoNTjgJSJaCfG
 9mrnm1+xjpUxasQruUSJkq14t6YWUGWcx2V0wCaFfloEMqHGVzMeRy0GTi7QpSQTKrzwPJe
 REWTYgoZAGbpucbCFNJ9iT2EKV4v06tcAmEmOTlBSTLFWyOf6dFodLYsc4bH9bvD3CWUsdM
 FlfNN87hvrD8pcbYRK3VhRGiXJiTJO8fJzwtV2kEQwsf82B0DRtbNB3CaYYcE=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

