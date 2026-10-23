Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDBC606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:09:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1347540B92;
	Fri, 23 Oct 2026 13:08:37 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id BF8FD40664;
 Fri, 23 Oct 2026 13:08:34 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753713t8d848a56
X-QQ-Originating-IP: EoznUYbOk7bnHlMqQ8I3YPoopkL9tN6Ti4XB7m0NBsg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:08:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4737255703899236957
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 16/17] net/txgbe: respect manual link-down on Amber-Lite
Date: Fri, 23 Oct 2026 19:03:54 +0800
Message-ID: <952A1444A959D74F+20261023110728.3975-17-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nzc98Th+6mOzsLoT7UqoiEDGS9mub9rHCocAVTTS9b67nyxZK4E2dIl7
 B/zwpHC8hqLzJXt52YQZpKVQPYSxoC/hnV+3vz1DU8crqTo6ZBSJUWzQYLY5lI7iIjlbeEc
 UZ0M5huVTnpPOjtzoFWCHSesrNshbRpyYsfQ/LIh/Kky5JVXsRNa6ZyB12E+X8XvAMkqpSO
 sTR4RyNkL/BQrY2A3m6rURa1AX7I2xAR1sDAmFPV8VSS42j7wqtnc5/DuyRW3SxrMLng4pH
 rDFFoj0UWhOK2EacTtm8dwZcR1GwrcNIYVS/Bw8jX66ikLU9UGY2+aqWtFCKsopKqScqh2z
 a3mFzpftkq7sWNuiCWgH/cfQm2dpQndiXD4dowkMJ7jRy96Dp2hErV98srrAhToPDP066g0
 zZ0LSp9WBNMcK/0qtU2wswtS/yxvS8yjgNAwLWDg8KcSYBcZqJMW5xT61qhGft+2rlY5unG
 7uimDQG8qYB4Ph8BxiOWnVwaQEspYx/0o2lpw/omcJYHD3fQibDdZiiP66/jKk8bZzzvCoq
 yOCOADwRIsl+/TFKZE64Ny4Qeo49i/KFov33baRx0j2l/ogVJMA4f4DtYawVVuhj5+YmmoP
 aXoxhSlKeA7KvnaHAMht7G1OPyBTGgCYJaNdfNtLJ7hy8GqXV7AcZUn1mTvYAAWj/vZEfsW
 emPvyoEpWbv1F66L/pPYlQVIj6Xi99jYUamNTpJrAZEW3kDjxWH80a6GnsDLUencROQ5dk6
 vZFdQGHuhjRgaFzazyylRTVANTQQGfW8OMhht+TDZ+z66huHIYL8DtCKYheRqXjq8KMW12Z
 LHZK9q2Lwhy3FxP6EOmEq7SrB1zRyGvY5WoGxFPe6lW0AfEqahACVj5agrYZ2QPTE7PI0Jn
 /+0Qgn3OLPubSi6hCZMd3iZH3tKjO5nMpsfZe+kFshtyfxRiy/aNSMiVKsKE2zqQjY1XJHI
 PSaqTVpJnWjw3DHfl2P8gzd4LprxR9LiybFdWh5tX9wpr3opr2KvlKegLNhGoQ1FCe6x26w
 bjhhG7eG+7BbCFAphvJnXdcIRtMIYToNR60AVNh8xT0OER9ZGxYHoNgb+hqWkgU6grDZZ8f
 vFzx7Bdtsj5jrGn3uTY9AN0r3MpwfdEzg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
index b5d8e34f87..07208035af 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3057,8 +3057,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	if (!hw->devarg.auto_neg)
 		return;
 
-	/* only continue if link is down */
-	if (dev->data->dev_link.link_status)
+	/* Continue only for an administratively up port with link down. */
+	if (!hw->dev_start || dev->data->dev_link.link_status)
 		goto out;
 
 	value = rd32_epcs(hw, VR_AN_INTR);
@@ -3396,6 +3396,11 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
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

