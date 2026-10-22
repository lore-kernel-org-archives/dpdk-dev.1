Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F8E606A325
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14C0140DF8;
	Thu, 22 Oct 2026 13:11:16 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 00289402C8;
 Thu, 22 Oct 2026 13:11:12 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667470tf11246db
X-QQ-Originating-IP: D2Zj0XbQ7vFBFhKqnz6Pnu/zZYdj3r0js+WdNXPVFIY=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:11:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18297303224081187124
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 16/16] net/txgbe: respect manual link-down on Amber-Lite
Date: Thu, 22 Oct 2026 19:03:22 +0800
Message-ID: <471BD4529CD3593F+20261022111017.3605-17-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MAu4Ycv3Xufa73L7rAMo9B17Htgv9/6yvDREmoyRiLI4rHbvtAz361YT
 SZcPZBozKWJ2IGFIW1w+78G4MCfMjIP6Rr3PN1iLTErdf8xB021eEbt8RcmB+vzcq1vOEFP
 FKOCmqPIash886trpPAl61oMejQqdKJsDhr6IiIdFM9dJcmnJVth6YSN1isEpNVm0oTmb71
 /ZxsaUqYa+Ha5cLrugbW0hLF3yZGZjljUvp+mCrv9VPVAD2PGs9qtQNDKfr890ZBxDRLsDA
 dVWmEmlR1+34x/JDfTYs8brqeQD24YWTUEmt499F0oEV2c+e+nTva0J+3dE6wVm09BgCS8V
 o1s4ayiA4MEjwgN08bt3n86JiVpgxhXb4lGpS2Mhl9OgUhkMOgzDPafMYwLWOMCe5PY+9J3
 dKBy598i/TUmL0IrP6UBVgviOboAYOeJS7wUzOYCsRduyKz1BLLymxVT/7giCml8yufBltT
 0GoiEvWRJBgPwXOLcaSGlkaL+js3SzI515Co6jnt8jMZYnyr3g1RIPb4f6IwhSUCmU2HJm0
 WseQQirVwlRBu4e4LhUnV+d2wMyQyEkgZGM2IxFzM9j6gpkJOt3Q0jLqus+tgdK3pwwJv0l
 JZ5imsL8+uxM202spQYWe+5Zr8tJfekeGCum4Py+8gHvNxnwaNBw2Z2cNzRyEk9mnTsCLca
 L7K+w11JmZMQNuljNMRHH9yav0tfFEemvmJB01ELVmCIbWGdUMTmqQM1fneWAqqIXJXO7fV
 onx+ULuzdPUgDXneYB0hP7TFWJXYBHJ/Vyw38yD6LblTHcu+kY0ZOKiX2yxdpkHx6lwo9qP
 kaZpYaUnJ7twyhpz6quVKwUDDs8somizMurBDFoaaxkdE0eqWmNnlCQC+jvzwxyEaTJyDPe
 LulyXQj09xul49Ye6JvtAk/P2tLS6eoM2HkLY4UX0/ikisD6ZMiOfd0RTp1m4fUt2OWKTpE
 CZYPb07r8Kn+HjsWa+AMHLlv6uIyyquHxIKkKRj5s5HeeEVMpergqc2Bn0wTGxPg/t6/FlS
 Xs9/J08m2bMqz5swAMiMplmUCCLkmz7/2GVB9wBrhcn6C0NWvNLjb52yTFFn0leNXDIQhWQ
 +qIb989hjTAj16TduAPIWdfB+4W6AIP7A==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

txgbe_dev_set_link_down() clears hw->dev_start, but the Amber-Lite
AN73 watchdog treats a down link as a recovery condition and can start
negotiation again. The setup-link alarm handler can likewise configure
the PHY after a link update or a previous setup retry.

As a result, a port brought down through rte_eth_dev_set_link_down()
can link up again without a matching rte_eth_dev_set_link_up() call.

Use hw->dev_start as the administrative link gate. Keep the AN73
watchdog armed so that monitoring resumes after link-up, but skip link
recovery while the port is administratively down. Also make the
setup-link alarm handler return before it configures the PHY in that
state.

This keeps the link down until rte_eth_dev_set_link_up() explicitly
re-enables it. The link-up path then restores the required PHY
configuration.

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 22ca36210d..f53fd4cdde 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3045,8 +3045,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	if (!hw->devarg.auto_neg)
 		return;
 
-	/* only continue if link is down */
-	if (dev->data->dev_link.link_status)
+	/* Continue only for an administratively up port with link down. */
+	if (!hw->dev_start || dev->data->dev_link.link_status)
 		goto out;
 
 	value = rd32_epcs(hw, VR_AN_INTR);
@@ -3384,6 +3384,11 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
 	bool autoneg = false;
 	u32 gssr = hw->phy.phy_semaphore_mask;
 
+	if (!hw->dev_start) {
+		intr->flags &= ~TXGBE_FLAG_NEED_LINK_CONFIG;
+		return;
+	}
+
 	speed = hw->phy.autoneg_advertised;
 	if (!speed)
 		hw->mac.get_link_capabilities(hw, &speed, &autoneg);
-- 
2.55.0.windows.2

