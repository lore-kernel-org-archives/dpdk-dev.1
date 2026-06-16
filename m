Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4E4CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:21:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E979640E0C;
	Tue, 16 Jun 2026 14:21:09 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 9E40640DD5;
 Tue, 16 Jun 2026 14:21:06 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612463t847074db
X-QQ-Originating-IP: +kMY+mMEk1d+JySPg913Sbgz22dYRAmV+7dediqME50=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:21:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6045128082237027709
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 04/21] net/ngbe: fix VF promiscuous and allmulticast
Date: Tue, 16 Jun 2026 20:20:12 +0800
Message-Id: <20260616122030.9688-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NnKWXRC3r3tSLGSfKZDpq/X66EGz8JfnLHxzDU7+NlrE6lZLPr2kUFai
 WFf5k9QIrTLFyPuYfQuS99hspaFD7lZqFcJM9sfN5WwgjFkCWgMi/MVfFjmzhr4G7ecMzrx
 m1NfSa+sLkblLu3I8/iK///xIDMM9j6HCuSC+7sNNd3KWGA2vZIH5D/esu0cWZ6QiaHub+N
 2RAk5Q0XJYOS8fw/8yehWHzWm57k5u0IcWy8xV1IvS80dLG3PcUpNjBubDAsPXx1zobHsUm
 tjBVtBVx390WrSS+mR8HzvB4q4kl9mn7wyWWoVoWZgLzfv3DvzK8qMy6/FnXStyQTOpY/rC
 CaMKv1TzGPHXl55qDpQOhAPLF/7aVZF5WfXEx2cwqF6qNbJ2qQaOdgC3wRHpfZDz3j+Dtit
 HJGqbMa1w94XLJO1PxckZEYJXsQdvFWkZBCXxF83+1V7isyeaJoBAeREiqEMzZM6N3CqMCF
 ByiGBkv3vW5gYJcRESzmJoAWEPl4qkkEwXKcyOJKxTG+2tHiLLQNypqy2dJKBrM6YQXmbRL
 +K/3ZorYJqkfKlLoE1hWX/5uweyKlJrB6rebF4TMVZCtF/VHwLAz7kKICR0xNAJR1Ckj5YR
 TddJJSLm/ZPX0M49QCBySLlFNU1i3muJuRNZXw2TbM/ptbTjYStT8jnDxulSGf9e4E12Wvp
 iP3Ct6o2OKSH5/LTVJaQeugHp7OHYQNo+2WFLg3VKw5KdLGo7XLbaUXpKHP0mhenG+UHqOc
 VCd3PCy4D6WLtLvIJH/uG1dZZ7EMx1HfJunfu2HkMtgshN1pzzMXcyhgjdsXphTz7lqvtAD
 7Y3/8IIh1aYXqJz7gCaWACkQqtLtVlh/mfLzpoTEQHVN3mMRdkf6vVy2ls47qEc0L+JgF5i
 95zQOARjwSi3dQdIrzX81RqPCY42TCdNpEX/1Wx6wO2R52ARAXq9FIlkaXh4AizsZeav2ku
 YmkhfGcvlvh4j1K05J6JvAjpfNUfGQwxb4Lva0Qy/LBYNsbMEhiVdOZSOg6k49ewkh75mHe
 HU9LGldv57r3DnXO2K5hqowpQT2YWL07h03q5k/pu/ZhA7fMBFDQZlnRCBR6M=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

