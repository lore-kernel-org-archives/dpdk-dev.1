Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8508606A31B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:27:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8ECB40693;
	Mon, 26 Oct 2026 13:27:02 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTPS id 1E3F340659;
 Mon, 26 Oct 2026 13:26:57 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017614tab2d953c
X-QQ-Originating-IP: yI2idDVmRz6zYEHZct5JiMUxoWWcxXTjNY5rppeykb8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:26:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4752019684146268001
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 04/17] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Mon, 26 Oct 2026 20:21:50 +0800
Message-ID: <36DC8DC7B372CBE2+20261026122638.9198-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MH7t2Urb3BzzOH4mhJdRPDAbJfeShcCBB6p3mnlxUnYEDpSzrxaagwff
 Xl/Yn2J23Z0wkz9bmNEhCCCPzokTD/UMwsiD+Ku2H16U/xp+PESVjBjG6CuzxPg5iqHECJc
 cTJUwJzDFAauxmWEPjRrMQNW9u21pLjqb0pe+2FQacXZ/QDNMk+M5u2h+pe4xrMD3HsEZ2R
 qooWXObqH1c7+TM//zdjb16HDMnWYZU66L9QSwr3I3QW4LtnCps0cF5CE453qv3OXP9bxxr
 YmiE/D4d8Tx626Si5yawTE5fXLzMCC2XZ75ax8E3OPimgVUAAx4RlcK3jSV84nWvHQm27Ui
 XXoff+V4St5WdiGdvhO1+UJyBpPw1O3JYK9E/8sMNTiRUkr0Ix+hjAmSKQ4kXhJt6Wk2Fhh
 SdKOXL73R3stabIakwXsz5FUEvPk6RPZzL4fLywVxIQ26S99AajZ2qIMvx7kDwycAAxWfYl
 kcldWYDVpwkuKz1VnjcBoKv+R0iLkDpbyLnwkmDnTcjy0mtjKHHwd8gJpdUVjSvPXx43M4Y
 o4mHyRw5e2aCBO6LjH/b0XLwc49LZiVETtMzpKHB2EUUA0NQ1ZFJsESNh2N84Z3JnyvZkwl
 OHyVC1K/bvIrIfB9GRhP1NO84nHOYWRcMpsDq2EpRcIzw3/eJdZ0gfR8Vmb21m+r6ZBbzau
 5KcMqRjzSgJMNdf8udWVo2ZlaSvm5FfY3wlETZeYctuYGsTmQ8c8o9/2xkhQB5p/hhXtFuY
 C4k3uFjU5MXHta1wlrfpM09Ez5qjwhSfp31yTK+wsR2PF8kb/2jgnopUbEJHy81bkIS2hCD
 NKTuLQYVmiWoi5sIEwnxb0V3HrZ58XjAaJrxMvcBlHuZR90PUlewh1JO+hwwa1wBZSFdWMH
 zUHbECbWFRA4smTiZWR45rTtt1KKPNCPrxCyfgnxP6W5Z6vz1db1stwRkY2WXRsERLrgYRB
 XuwmTAMf7N4X/Hc6qKQyKwmIZzH4JjJqQlla9/iwIWgdWHWPl/qOSJrrpQLN/d+dZQsBHFq
 UmHSw7GRmZHABGNVGqBuCz1Tm/JrdajGTbBpXUo2Z42tqKRmu+kQa5iH+ouZSjNKyIVXI9n
 nj0nMSCNAKTxLOYPJpWAtZkJLj9/FRDcSwVwgBXiVUA
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

