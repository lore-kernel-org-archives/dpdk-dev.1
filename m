Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535B7FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0404D40665;
	Wed, 29 Apr 2026 12:26:23 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id BB71340657;
 Wed, 29 Apr 2026 12:26:19 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458375t71f39c3d
X-QQ-Originating-IP: Q0KHExGNjKfNG7lehZ8+UEpCDOprHqsnpO/fspJyVB8=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16296575401213600124
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 04/20] net/ngbe: fix VF promiscuous and allmulticast
Date: Wed, 29 Apr 2026 18:24:58 +0800
Message-Id: <20260429102515.58880-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OSVqtYYytolwNBIa96VhGqYJ84BUa7zmoOATKxUbbmKUS2nxLBa44k1Z
 3nPzljrn5+KG9PxNzHlLdewG6QtwbyJH7tjcLjyeHnhm5SInQ8pcGgExZtWdUmssrmgyOXj
 igYRI+scexTSb0U0RTtHPmZPRtsUNG8yKCocOYw/V76nTaFy31qWxHdaP1N3iShc5p21I7Q
 bXuwqTKqniOvDuoD4MdX0OEwFrdPU4X/AMlTZZBx+3WTmqcIl/FhgY+xW+FLeqC3j4v3qnP
 B/cL2j3tjLkPt7/3ynhB5EBpLWf3OL8+MfSoPR1n3jPqf1etqebrDyks4O9LW5gd+PkPFru
 04Vd79VuxT7DlsC70FFiIkktahy+IxnS1nnmyC5fZ506eCMXTZloxD2dDEAMCKfRWOKfUJ1
 fbMAM8Dp6DdlTQnfvER+Lp+24qB/WVvAk383bt8pc7UgjMIz7lnCLJGoKIra9izPbtbp5Rg
 ePJULTVc2RpVPM32q8n/USs1YFIk6WUQ4zGfP1Sqt2lPmO+vufKpjWJGOlpIo/SDePa1A7O
 QtWOkUpqvETXlemxYME+z7tUT74vYPB/wKYpusE7wtBczCCHZOh4N2ecfUnxhuayLIeeC+S
 OrilQDvdpOB4OXRWlqObRHm7F1PVr/GrgSRRNYBGScAUL4G3qqCMisqIFrPjCBUE5v6IGJa
 j1LWL4yUSckc+bAQ5nbfVLH/GdkV2I+b+9arw4akJkrhJEzRvFExazjJ3ngA68baTxw+A6Y
 2BBcXoS0a6oIKmcdynbuAn7pEK5cz/OqaPbzQhLibYdgviheaM29Uq74x9bmL8mduDSk6wz
 THE8j1p2bGxpKgMghlwIXX0vWlfbzjPysxY1fGOqykTv0Kng4M7snL+0LzkK01yYbcq9G+Y
 LqTI+gboX2WkNi7mVEAaB/nTYrMvYzpib3pEOUd4O0QTyUlzKwrdjtELiomftxtS3jS+ZGY
 fQZ7evGNaHfm7vicGT2U5EvkMyiNYnKRe8WhXrBOQhTLGncLnzWqGvvl2CAUqY19+mU5zlP
 Ss0K7eD71+7Yu2376zTrlT/3lFMzxO6xEkPOcBhJWbXWVLkGW1un4HDT+My+SXAMldTMrSn
 xPubzrEXjZq
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

