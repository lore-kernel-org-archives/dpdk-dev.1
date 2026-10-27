Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F5606A328
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:42:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E6D140695;
	Tue, 27 Oct 2026 12:42:36 +0100 (CET)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTPS id F1D5740693;
 Tue, 27 Oct 2026 12:42:32 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101346t82693a31
X-QQ-Originating-IP: 3N3wKbrp2PPZZrf1VPFwXgoI6otpvZDmm1s9kiYzfRk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13504157135055106097
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v12 04/17] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Tue, 27 Oct 2026 19:38:20 +0800
Message-ID: <FAC265FDAF0D2C4C+20261027114218.9724-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261027114218.9724-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OLAm9mAwKyf5nj5cPRYeDq1+m6zgp/5AaBykXbqO8/KI9v31H5sMosQy
 hJuvjhsgC4xJCiA6uzUe3+vd0FeMtjWOX8oupA64Fh24QtC3IvxrCd4wrJT2cfCfcbPWPXk
 w3UsrsEwwTQeBU5Oe+QqK1Yse6tEPOTattmeDmkx2oeipBggnpIOkpywWwc9xZAUsi/lP4N
 9wixlTCcy7BwBL+EoUx5lW5V50q/guh9IVEuNsU0EUf/3caDDFBKRQ9CPWqH7lOJWGaZsxa
 4jHX1hpEQjz6ws5Eo/j4O4sPwmilOqZaWe2a7xYFgrXo7TKRS/YrykfirWjeE/8Pbvl2Nw3
 IclkBL9uHLlhTCqCs0fpxTevwoWUjdWEcwFMusFVw17g4MjQrV/OhkPPIyqC87RtLjNxQrr
 6VOlpexpsayk3cI+EjrnAQD54e5hU6i6oghugrYobGkOD9NRxOULGxVPDNLIWE/Dz3a3AKh
 TbyGMjmiREeXIvkeb/Dzt8bTwknHcYHpBx7ZzUP0Fuaqpb43byEXmjrWSyvXU/FZGXOHcEN
 Qq6WMPFB9my0tLQ2NFtwL55DXGwb/SdXHmmezperl4TAB3yiAsESEBYF3DNJVsJRCGTFsWH
 VE/iAeOraWPcTVJSZN2WnKjGD+W8tVhKS7VrUZIS5DrIthDFb58VMV7ji+XbJxt2hZ5yCgM
 C4A6Zbz+afmFGWyQf4rZtIVGvBrkhRyxaJV7W4WF1qm5q50YQu43263AekcGjQsVECzAd8c
 5min3GQzhCgtqLeelwF/3oqqzBu1SvkOw5UWmdU5QlWeG2jXPg2ZH5HzCP6WoBUZPVU/BBC
 quswL6IghkY0Su+jt45PLGYjcrv7Lu7MjorByFQRNYx8m1GLUoq+bLD5iS64Bsvdjqu9qPk
 0PwHGsLDBhm3fXw5tRq45+7GY/HT0T0pN9HqgTc0rNecHpMvWfCsViZVhINfsFaTG31Qq/w
 LcB5xn0sHK9m9Xf918t9iJxDn4AYbXEGn3R7TDlcVGKU4iQJhZ2RcYGbK7v9jKvWgZLnVyI
 USPIgRJW0y42GWcW5hj+JxtxY+eL3/RitkB7ni6TcUczvjy1c/yZ/Dm25mcRCOPHdo2BAeN
 63hqkMuIO4IK8APjIfXd72EneGGMVuGdw==
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

