Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A85606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:08:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7083140299;
	Fri, 23 Oct 2026 13:08:02 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id A59C1402B6;
 Fri, 23 Oct 2026 13:07:58 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753675td1c06e31
X-QQ-Originating-IP: ZMSrzDofCiyvcjDyqdD5cWf3TBAk1fdPrYbRxZjd5Tc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:07:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7473993375938952555
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 04/17] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Fri, 23 Oct 2026 19:03:42 +0800
Message-ID: <955BA6D3DD9AA99F+20261023110728.3975-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NpwLs+EI9KdrQ5Af06p+RuojCzDByXWs0dZXmga23mnn+kPaPmhWyJPU
 c+FD8Q7TJ/Kv1U8X0Ih0ZqJ+BqJzYoK/zYfZ38k3xd76I/6G5L5nuCkDF1KiWCY1pRz5Qlh
 Jknex8DPaKvIMCwTYHhdTBDPxYGy/QMkNn7zwtDfoiClIzTPnoX+TY6PYvSuCPu3udDLkP3
 DszxfHnSzNmyXRq8qPu9U5sni8GRnYit1z0m52AZVGxJzfLRQvRjAlSLb9vmCwAGtbfLQSJ
 oCGQ17nS5J4v9icGS551kyvWKmRVkH1xn66kGsWOnEgk3zqzmNSG2j2X5+SnNsQ1c0z3nHk
 Bs8D+t12Tni5Yfo5tuPXvZV2DY/gkaE1RwBuHe1UZMzYfQ3speV7f88dqs2/5Mo/gS5SWmd
 YsTSIVUmjRgurVuyeRDXTSYffJ+m81poMFdopW10MYdVGde83n9UH5I0WwiOzNhY8xAh3S/
 EJYLEkHF7g8kcuECEOgcCkm2Aay/ixf94boDVP6dcJhWMrhVAZ2BigE5K+S/FqDevmF7nxx
 jdpQHaWcDDQ3TbmtvUuAnYiwbbxUMEw6sYR7xidNpaPEctNywuJFor0GlJRzpz54BooKY1E
 Vt7yqqQOvSJyF6Zyo5l4bHDEsveEpcPCx73uNzeTqsjflYpYCsOqlqzjTaEgv/nwFYAbaun
 5ExlvBSi4vjvKA1BNX6jwcpIHq+RgBBN/tMkwfUMR6pDrtJE4x+jEciNdNjH2j9mYKrwWOr
 iRWgbWIS5rBIx8kHEvITWVGgEEMPvJT8FrFQ0BVhEABTZkal1omELVoFByJ51NC3KfxOkqS
 OoC8BuuZt9cCTDtBfkf2KX49kXgAwhjCI50+eDqfVe/VIoqterIdsn+avOm24diQjotlmlE
 9jkUGOtJkWkrsqfDuSDXJL0hNcJyYj8X2ctVwYTjbrO7eR3W0MZRzxdhuiJ9hHKLIb4U2vW
 jIUMvkcFdZc8Nc5k5PvQqNqLg49zkrPJYNz9ZHqYfcnk2I6m9klHUAAU4jD493VYHSPX9up
 dZ01BW/JT92esv3qHZ/Fkma0tMpsUWeLtqRhNnD06gK0dpR/JIOd6cim7Xdx6+lS9JO9pNk
 AsNzHIOhvraB3auxqSud5lhfTAyMHYntw==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

