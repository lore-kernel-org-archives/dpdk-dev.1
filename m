Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0947C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:28:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98E7640E4B;
	Tue,  8 Sep 2026 15:27:57 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 2B25F40E1D;
 Tue,  8 Sep 2026 15:27:54 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874072t65d7d0d9
X-QQ-Originating-IP: YWVmeHJmHVJ5WJ44KSGfJRX/b1PYII+BkoELKQ2yMjI=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:27:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 492225124313758233
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 03/15] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Tue,  8 Sep 2026 21:25:48 +0800
Message-ID: <C03D4655161CDE2B+20260908132742.2661-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OcYdpyN8sJlupV9BXW51u4awiQ9xZEt2QGfQ4YM3ytPTmHvoQHrqFbSC
 n1IxpLvwQvv59suBERCLKfhbaB0zUc1bgfqXjKg4pLkmvbfjy/cp/aSEXLSvS65ERzwkKFq
 Y5fNtU5zWlEUKKY28z0PQNhFz/ZBr4x0pbxai10s0doQONLk/D1OYe+vxxbpv/bOHZIebZv
 FSAou1nAW51zHSPTHLyfumFqIXR4FoXQwwP3d2J2TJ9DQ1DsURt66Qr+LzTDkheHC2TvSmK
 i++jEJwGBuuox1D3Z6Nh1iUc4Ueyt4wI/IIY75txImMCd0F6+pRI2TOKqo0W4d2TQJxJECW
 QZ+d1+qeLq4PGwODi01KWuHCV2HsRiwlmqa/ncshxwJrnM+CJcHuz+DZnhe/W5du4+12O2o
 tJ/bVyxomkopnIX90JQ0/+nqhCq0rIEoxgOdbKAWwXOhp28n1P9aYNOy4kJdO4Tx/GQIkES
 WNeSPZpL18yKiyU6Mi+rlmksuIy5cuEjPsPKPQjsOTApseZeNY1SyGifz07YM7WhjP4Qqi5
 zEFNx2kYerOhZrHIGfgvLMQD2+5QIH9J45WglOBLz+bHCWsYiAQueSFshPJDV/8fHIoqJyd
 0VlN+9MyIuz5GOu7kP/jU1cmxTiBdsTDVrFYZ+rMSHILF5LLiycOmDgdU/AAaZ7Dqw78XVq
 xFwHw/U/dwQGSjz3aYdpEEZ6P2B9NakRaAZmfRQBUIE3+GM+Fjw4d1MJCfImyymEjQXYvue
 k7yRFmrMEflW0T+rzYLFfj3wkd24JkG+X5cuEI1XnExWMa0ePamRXHE0087VNn6Q5KmgdO5
 vHNFiL4WSUJNkJs62b1qtV3GjFeGjUpxrH939+k2x+irRw6CW7sjq245fu2REO0d1lInpL9
 L9oq9lCtxwqW84HkyZxjO1Rq/LgJ8uGJd/vQoTmgdHNtdv/HUO4sK48qj1bF2Dxr5NJqCsl
 5U3cf/rSPKjAGpaxiJObLkfVBZO/QH/Yf6IQldUCKwj+TdnrUq/cDUqGLCeoqZzcUQYf+3K
 omDT9zR8armpGIvS3wbHQvPvxuu2p1/N6skmtCSRqvmwgPBAuSbj/Uq+BlZ/LKvJDhI/ABn
 axKR7Zjdz0QOZIyMy988cw/fXeuH71DLL0+Em4ZrAjp3TiJUDL4dlBuQup6+Zc19g==
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

