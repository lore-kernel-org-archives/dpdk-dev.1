Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B59FAD3F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:41:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC4AA4066B;
	Thu, 23 Apr 2026 05:41:04 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 75C13402E0;
 Thu, 23 Apr 2026 05:41:00 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915656t5598ed58
X-QQ-Originating-IP: zyWSjIK8Rb7TyCbNcDGtRVaKNTx2v+JOYpvv8j8P1yk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:40:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17257714575413334979
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 04/18] net/ngbe: fix VF promiscuous and allmulticast
Date: Thu, 23 Apr 2026 11:40:09 +0800
Message-Id: <20260423034024.14404-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvWYEgjCCjcV0j6jwDp47Hl7ObwL+mcV95fOHVgYnbfn9/DXpsWWgROT
 X6iz9YOLe7HiITIA18jn/yN30SWeSSr3oFxY/uA/tgpMvGxLzY8fqZCZnXKNzIjECiB+HlC
 c6scKbAJlEHPThnlgRm4LgmmUEEx932dd7TvNDNEIlGhJxyaECJ8U1N0rfC2WGMiPVHR269
 2vaOXFY5kMYqabBzurnAN6+7ZVqIcdFrmnsrkxQ43YxHvJYZpRS0pn7mf2V1Gps22NvaLzJ
 buamL2HzH0qQ794UZWV9YBuVXJc74WLswwNotNWrkeYJEvKhEOj5OfMKjNsz63uajCBlQoG
 hwq/X+yGmN7OQZE9GZcE2urr7KjJS25p8Hn1t8k+KJqwwYcvnUc1H/+iuL6QFW/Ds9b8TBp
 3cIre2PRZAnm5skh8XC7sMHvJADlIWItImBjM/KeKSKMLwJBJixIqhbWRF6QHuKGXs7L/xO
 6Q8zFAFBwdxUYNgMpUHFuWpf+87I1nfJLzm2p/sOKL0LzI7bKDk/DELF3u5xHKKBBsfgHpg
 fqhZIJzHVoNTmSZmqUV4y/TvC9zCsRoF5Og548h3q72qFbX7MISiY0mIuuHAF1omV3sfkDP
 ttAI0IznYDqjDq87fXRQ8NqmbcjMac1Ywy4VRhiY0VTqqA7OUPCvbW7XMWwVxeI3sqLuXhs
 LmlECm/OdasTzRcdYwlq8dFdLh1bTF6r00t+avu7pJPSJT/umdyWEeXjKiwABAc7ZpLuXTt
 6AurQBfR+5GNjZDdB7qj9x5Mz1wvtQY2iN1++RL/60j9gDb9gU4XppInOSPGdUAyyppxRFY
 Zr6WTDJpDQbj4YXpjezqA8kUgMM84RxO3WMerTo/TmlE5dCvD0tGJZIABawsTLKOOT4b/Hn
 UOs1ng8yOC2G+IE1dsJLR4sRSxe5P9M2DjuzJNl1VKRPK9QO4zfg0Zf8XIreXOUHZIH18Xe
 3iUHwkHWfipqOh6eTExcdctebILismBNZaEW+k9x2OsJ7yHympC9RyM3byyz7NFkf1QMZkd
 5EWFFkCFudPI40mNN17WigkzRx3udKv9NQ1cVRmHzvm8htrLtQ
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

