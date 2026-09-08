Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA447C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:41:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B9D340E50;
	Tue,  8 Sep 2026 14:41:08 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 2C88140E27;
 Tue,  8 Sep 2026 14:41:05 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871263t39c46358
X-QQ-Originating-IP: +6werFsoAc9DNkeXnv7aq5ZU8AE1x+BhWbAOvxxKn7s=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:41:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6634938408008231318
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 03/15] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Tue,  8 Sep 2026 20:38:48 +0800
Message-ID: <8B6C3795EFE90AC8+20260908124047.2284-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NWth7vBa++Gd119jbbVrR+np5QWNI6W3LMRfBvPne3bX6mIAYQGR17Mr
 Ny1fKCZ2Hm2Lwc30wx1yJZUQZ8jYylldcF0bVA1b66HzoWZ7sGlz8UqUSABAS1aY3XmPlkP
 da2g8e6vnpVoW9G+sPxUICFxatiMxpYBopyoqyGA9B2X1X0ZNonV0wos+56iaipxYCA/cQg
 m9jSXvf1GrdAlB54kDHuRN0VzKIq+4oRdrBpn+DcxHFFsA1j0Rhf6DGQkEcBRmHefSU+UX+
 8CvWR5PASqDdhlCvr0M3XMaFQ74AYtS9PHDlyqRT4NmsGR55Tp9DXRNnHsd81xBkU3HavDX
 KzLLJhulTUUJjyldO0ArLQIOFWvuKhIpd22CqTAa2L3dgdTT2krfUl6NjH9erI1kVFIbWvj
 UtUUKUozqx2eAU8jrodZ2Rxij24SUrrB8fSkg7PhM3/HVZKkklIApzvN4UqjnsxirnavFh5
 WEfLVFk/DrYABFfpbUgoDd2ZFmN/Hb7lJUldcQDQXkC7J9wLTMqfFa0C2amWhpp7rCD3MMb
 IluFKTLWTwpl1WYu6qN3vCLzV+RlOkVfhV0Xcds8ZslsgdGzT/G2LkbjbzqLa0uunh2GHaf
 tC5NdMN/THuB2dYkm+PUCwGB46/JQGhK7vZtTA+7jyIA52MlXhtFMB4QW02HlRjgJzwVATX
 eB3eSY89o4t8eluhFaE54lrjBFOQW6uw/B4PJOxvJxL10/5FRJHvdJr/e6vtKCoZAVRNTmI
 wAWu4098wlvzp0qphNdGJqTi0i6mCDpW/jEl4OWJT2bzO/T2976CgY7fkEF1sAFP/WKM4qh
 tX2fbMC4C4oDW0Iu18r57J55twwGfDneEZ1Vg7NnLwzpDJrNAuiQY28za7FsBhyMUf8wAEZ
 Ni3x1SkKzL3zODxrRH2OdeQcgnI6BXC4kR8TqPtuQTHv+xrK8gfbujTICalr8fqjO7UlRst
 e/X0zAsMX+2zGxSwB0T/CGm59EpLKM9TkUIrB3r1za+haGx8rI9lOLXPhagOSgVitmeW/Ua
 t7YleENlXSojEvbuJ5KvBvkvCYEXPCN5xKj+6RU1TNj5pFwQ1Xt9ugwuFoJjOCE/OjAgfSc
 icZfyi+pXWl
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

