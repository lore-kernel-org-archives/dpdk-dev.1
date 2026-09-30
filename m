Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81793CA5FBA
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:21:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 404B342DC3;
	Wed, 30 Sep 2026 12:21:05 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 7329E427AF;
 Wed, 30 Sep 2026 12:20:59 +0200 (CEST)
X-QQ-mid: zesmtpgz3t1790763656tc78e3b0d
X-QQ-Originating-IP: th49HgTBkOcBqNyZUZl4A6V92rwG6fJFtz7mkTYdXc4=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.241.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 18:20:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16939612337218861025
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 04/15] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Wed, 30 Sep 2026 18:17:51 +0800
Message-ID: <555602DD1FA00E55+20260930102042.2214-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260930102042.2214-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260930102042.2214-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NNy2EF7VZJee6qs6vIi18I/mlaiuBn2w8q6+IFjwjYRGUbNWzpPYPnZj
 plbXIOTe36x9B4f7jCO3td8TbvpVaCtujppo4uU9Qkc5o0T26taFUa9g6HIj9G4T9sFcmms
 92lMM2FnzNzZGjiBrNW7Cvv2IrAKgnrbGUEdJvhUQ6ncuq10Zu6Y8mC8mnIzRyAgVaE6kLn
 QUApGcE3oSd2I1QwdVFfrFEqXI5OshfKvquDUhdvpjrLzH8k7nANQDlZ11VtVye3Kn3GFCE
 UK1rNYO/qj2QLioHCEKwDIlog3xAVN5j11+2O/zUD9kfq4QYnZy+Qw1Sv5J9GRUWfonAQIj
 DeyVG8ALvkS5Illf85cg2BE6DLkF6jJWZwtCk8dnQ7ZvosNoNPAfQNd6rE3ycYVLQbOuib+
 qNhPnHBGf1AlZTdJ16BIAU/clovDbXty4zZp9heKngRaSjtNeoS1IPn4Uja5k4FPPdJu7J6
 Ttnk7ANZYTt+vG7B3YbbxOSUl0J/fTuYjtTgenioH6VVOQXxz/suql7R8tEUnXFbpld5Xc7
 VTM1IjrPv8rXsc5M9CR0tgDkk+QNDvyfxNfu5T28mnjx+Gp+YmJtYKtT80fSrE+fzayUGEC
 u2ikW4GAqknfvk7GnQNlaBfSB9eAEMZ/7vl9V+ilT8Mt6iG89OPPvVBM/G/S+40xMbOq/jU
 x3o4m8pGTzSCnmerts+HOKewGKdi9haHVH9rqGCuXqLaNEOEqafT3Bylypl2Th0caM+oSEG
 brkVkhkcJlQJMU0mtFCQbY9CT6ZNl/LKlLFstAFcIIfEbGz2B1fgVj7BIK+Mr6sGuL6FiNk
 39CgDs4Nmh8/PizuaPZGphCvSc/WvAqZcGYDX4j8fj4asWwigLPhDL2vR/tEZFxNH6QiXCN
 PQlHpNfFuaOZ02aGOqYgrewSpRNzharIXHp25pgpEB8481vwTNGQ1vT8lnKmXExNzzB/7By
 UjhwB8WQZJW0THFjavVKTWqsHLyBijW9R10NhbpKd+HIG8eYA+/FXFeSi8/5lOFvm2fGzmE
 ZJWKh//gBUIPXtS0wmbIGyFzJbuS6nAC40taJofqd7PsbPBikvBhM/PrOVBSzcvNC5fR6cE
 c/Pon4nMjHPhQ5H2prjkkvs6vtwhmjJhEs7qJ7ZZSIMC2xnk0Wd9N0=
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

When an AML40 port is configured in 10G forced mode (auto_neg=0),
the hardware can link up but the driver keeps reporting link down
after a peer link failure: link_valid is cleared on timeout but
never restored when the peer recovers, so the link stays down until
the port is restarted.

Restore hw->link_valid = true in the success path of
txgbe_setup_phy_link_aml40(), symmetric to the 40G path. Handle
TXGBE_ERR_PHY_INIT_NOT_DONE before the timeout split and leave
link_valid untouched, matching the 25G path in
txgbe_setup_phy_link_aml(); the alarm retry then attempts the
setup again.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 7476759d4d..5fa7c6a243 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -202,9 +202,18 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 
 	rte_spinlock_lock(&hw->phy_lock);
 	ret_status = txgbe_set_link_to_amlite(hw, speed);
+	rte_spinlock_unlock(&hw->phy_lock);
+
+	/* The PHY did not come out of reset; leave link_valid alone and
+	 * let the retry in the alarm handler attempt the setup again.
+	 */
+	if (ret_status == TXGBE_ERR_PHY_INIT_NOT_DONE)
+		goto out;
+
 	if (ret_status == TXGBE_ERR_TIMEOUT)
 		hw->link_valid = false;
-	rte_spinlock_unlock(&hw->phy_lock);
+	else
+		hw->link_valid = true;
 
 	for (i = 0; i < 4; i++) {
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
-- 
2.55.0.windows.2

