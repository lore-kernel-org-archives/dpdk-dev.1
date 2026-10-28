Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26D606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:40:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DF6E4060C;
	Wed, 28 Oct 2026 11:40:13 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTPS id 373EC40679;
 Wed, 28 Oct 2026 11:40:10 +0100 (CET)
X-QQ-mid: esmtpgz13t1793184007t60ec2a2b
X-QQ-Originating-IP: bf8sspicLSg76Yl1lB64BixwYWypHqIHvKeqkni1zIE=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:40:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7509363721295729717
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 04/17] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Wed, 28 Oct 2026 18:33:53 +0800
Message-ID: <8BCD0F44E285F98B+20261028103913.10188-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M3uTjkO5QXGxa2mgoUdrLbnqBL5TxTNPWZ2CsNMcOymqNOSOHQc46LJ/
 rCtjGRXqDlx3lWa8jb4qqpZgqk5yHZz4fcQiXXHuQP2GaVZdWhOrqh/t1VhZTKa4Jv9rgTw
 Mxxcdrh1o7TP8xNiBWD3qFUpWV+3NRUSvJSbkJUJUJvUxt5L2cr1+WQviPkg9kHR5SRiaWQ
 ZWvJ/TXOF+TgdvMef25FEh/7kFDjibzMot5ArWkW7hl+hFC/B5yQKhI+XonemeRIli/7AYj
 EA35m2uyvCf/0o5+YUFu+RBW31D1c8isnpIUE0Ta/oSxtfPTpwyD4iJ5WsShRMAqr3Qp0VH
 Jt9uKV44PadOtZxJcyhAOA1TptvRuBeElxoHctjC3a+QM6tBoVPCIzYPko54xw3tW46uy4s
 Ag/OESbPeF6vd0VcmfH1cDGaxVmE6181VBofsb3N1KS5T4wz5VFH5xmT6eqnePoJN5Oc/Xy
 fB0Yj2d45KlpGlb6uJVO05Mis48rKmkdQSTIrOyCVlnm5afwXNeVlc+pTYhZazQeCL9lDVR
 Lk521fhzFVT65diGZUIkjLSCiavniuLVvszeO6FpwUnog2VkX+RYHOCLrd+elfNTOsx3/q/
 b/gHAeGbxFRvznRiWtqmWYqo5+11MlzWXqS88qcwJ4vRb/PtCJgdk4ouxMZkmuDgO8Rny01
 u1v39M/WYqU25cDeR27CQI5walGk/AufB1igEzhUZk5P0emPELLnxvsxZ/Ha1bfC19NVjfd
 BJHSKNqHBfuh9hg57UHxfzLl3oYx6zeElzhkILNrRenZuiGfBNJm/7zGaq4O8f37wwHp3k5
 tH014itLPsPpmmt4/II/Moqw9CIxJQ1kC7mSXMy2giNmAUa7vmtcJ/F2b+/F/7tC/ZuAGrs
 1OO7FxLB6ebykIh/CAXcxhn8ewT0E6OGEe7TyvxIBrmcnsBvCAkH6zN6oSejWqSOZQTcg69
 /bp5sd5VEa21PI9YFuBZj9HgOXI3eTeHcIQSe0JCwFk3RWXmO1dYParNWUEueIMBFvyMoAA
 3/hAPVQJ7OLcVfTI4kn99Vt99GctOLkC7X0b72ggUfvPdEZfwcHHz3Lf1WE3sxWa2Sqy+Gz
 d2OTQ+lqzjaa/Fnk75sMOvzxHSGTgEioQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

