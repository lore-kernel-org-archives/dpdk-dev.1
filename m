Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC780CD98E6
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F55440B9D;
	Wed, 17 Jun 2026 05:34:36 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id DB8E140696;
 Wed, 17 Jun 2026 05:34:31 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667269t346ce055
X-QQ-Originating-IP: CSr29zf+8QNuDfAwpAJ5aeiP+CaFEPyL48Sx1z869xY=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:34:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5267499830145035683
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 04/21] net/ngbe: fix VF promiscuous and allmulticast
Date: Wed, 17 Jun 2026 11:33:42 +0800
Message-Id: <20260617033400.376-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M75I2DDAzREFgMc4VkUu0Utqxj46YbNrSJvhRqDalZ6QQ5mFXpJt2Iiu
 F17T7x1yF0PvSvSPI1GlksTd2fj5NypnGcDgTSXcx4hVS0Y4zrQZgTl4jQINXK3vdwJ0Z+f
 Ho14zQMCAzbD9pUv9fKFDSaj2VoEfvBs++MHffYf456bJ7+lgBd3b9432ZnOd04Bpel1UJQ
 tjewGsQfDCu3mdwZgoGrl72Y7XiQdsRlxuwjpuTj7YVL5SipLuCH94raD9blpASFDtDy9qx
 Db5rT371MsQQ5TuHaD6J6xaOvfeu5ZTA1wRf89y9Ane9FMRpAgokH4qvgnxH3LSvvkXYlwv
 egOG7JPmrZe+XOIBG+M4vmKRirT6NyL9z2QDOzDaGv+NhwyzxoAzNgoXuw/IJkcrKIVfHIj
 5dMI64O57+QoWBjEy1bOvs/Aext65il1YXNtv8MVM5+6TkZidY8jl3JgM6DwhmmRwDL5dqF
 kgoG1vs0GghwJUX+sj1319taOz41ZnqCMUXSufzGx56mXIiCDffBOKGw3T7S3MZUQqjnbql
 nr7J4fNokMDbR7LBjMzZxDww+C3g5cBNjOQy3aDz6JovGfJSwuDGQOd7gOlhTjwPS9s1js+
 CRAxjn/czuIK8RdID9A4hqC7/fedkPjHuC+avR4ULoGQFOuTkJw4FlNP22UNqkHqZjfniAP
 tDNTqa/eDD3ve3aNtM2+Bbl4himW4cieIv2ACtls4drXd9gjChwN2A+bgv8bu9m1670D56N
 Uw/zfyFak4o08dRXqkOI4SwMnuXxY3o1firKMzo4JZFRVpKNCAfqpYF1xiSiL/rzJWCniqr
 S4UDLuc8ShpSh1iOSP1Hs+weG1hm/a2WktJarLec8nGScKUTWGJ66Ff20Fof3pCbv4CCQ0r
 5BnHZAqZWezgwVj93nuZmYCyh42OxGVDscWKnMKZZ7vgHQmtumfAvSoOevf5ONgDzac/zYn
 DONFEcm/MbpyYpYcX7md4E/dFM25h1PQRUzEx18gkmxNLtCz7yYpllj9YLghbaMJ4qI4gIa
 xIAz+bUd/1FhxnTNTNILBysV2ehXeESCYO0MP0SqBk6jf/nfw/cXLg1NZA63Gf7e7fYdwVs
 w==
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

