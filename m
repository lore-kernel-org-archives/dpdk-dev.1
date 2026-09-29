Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B706CA5FAC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:06:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CB35427E4;
	Tue, 29 Sep 2026 15:06:29 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 37730427DB;
 Tue, 29 Sep 2026 15:06:26 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687183t70d75938
X-QQ-Originating-IP: wQE+CLfrVlsF/vsDcn9zznPd+ZrO9CX9woMlmVmUr+Y=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8823224436401034357
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 04/15] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Tue, 29 Sep 2026 21:04:35 +0800
Message-ID: <481E72C6812458FF+20260929130611.4871-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ODape9HLJUgbsE3wHy097uZwF6U+bOKCQsLgkz1xBoNphHxmgn1kAGBH
 ZFsC4378+q8HCOxhL3N+mahzlREhOQCmrxWkIx532wE31wzbmplJGaSKocdE+a0lBDQPsDm
 2DcHYMFzWMqbm3N3xoGchKa317zSvuICrh7lzWbuRVl22QmVjaWLshw7B2ocjUn32qlnpuZ
 G60GJ6UZ6UXJG523oM13YJj7giUBr6emtkzc2QBwb3U+uvTUmOBryEAoq9MqPoUWVWLSJxL
 hthLDdJX7NqsZE+KhsYeFW1rEhcM2u0+F4XicLOQVPHTVanHlNgwsMk5U9cvPnctZYc8/Zq
 jvYcbM7wKuuALS/vDpapfehu02I2eOCBVHenwXJqAi69k+ZvW3HwUF63g11NzySC+VDYVtc
 MG35Z9+BmFqefs66kQBP3su2BtMQGb4mqUxOS8ioc0G5f2oBc2pQshTskD71bGJ5PF0Imwq
 EVNzk9dDUIwSUTQkS85GD0/89Cjxo4jYgL1nlOZ8moU3HPn8Nh8QfwrBPcBLnHJJaaEJztl
 nj0wXBPJWSqvhNQLJghisd5t+bsymlArl1oqTBZJO5om6/zl6G0A1qBQc7UN4k1GxRS6JWR
 l0H2PcIl+rRtbRCio+p8NUSngfT/SUcwjWhIFmSi4cEQYr6Tb+WK+kpL+TVojp9V5T0oBCX
 /VKOaWjzPRj74TKLlIMBytkJsugDkNQgFNhgiXOH8nmuKqbNXSuboivkHJLFXgzimOqTAQl
 I5fdBoRkl8WDA6Q0NUHv7uMlKgnpAwe1eh4IM4Kn7HSTpV3mFmT/4sgRdspNgGrMvah/dto
 WTxB+P3llP+I/GR4pqdOFICYbFnYiM3H3yWUjTKbZ5homa7Xn0doXcCB54ytc5X2WY+vzY4
 xJKjuPbmIQJZk0OcWgZEv1i6VuvXUHzUNxB/v9R2T/f0yYTPUnjkxpQ0X9SN8R6/WSGB8Pq
 iqZluRlWuTwTwdUtXEH1QNKNt3U7IH4eqtWY3aerkoBFXLhpI/07RZbP4aovkujkwzSVPoM
 X7rel1md79X5Qdff6oOm3l374hZSVADVQVIXNOcrCCgsimmPUXQRXN9oJv3tqZMlTvj7SPX
 RiU4TOsGhBx4R6RpK1wiauv5Krq3WeM4ER37WhcZ5RgVDqQkMpsRw6dXiX4oFG8rdfVt7t2
 spE2
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

