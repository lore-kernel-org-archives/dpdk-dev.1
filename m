Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050F606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:29:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8791640DD6;
	Mon, 26 Oct 2026 13:27:28 +0100 (CET)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTPS id 632C640BA6;
 Mon, 26 Oct 2026 13:27:26 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017642t3ad3cb08
X-QQ-Originating-IP: EYFFHFn+MHQovabB5p6hnuQOKbg92d3ffTx5mxJCiYU=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:27:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17821241384208983688
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 16/17] net/txgbe: respect manual link-down on Amber-Lite
Date: Mon, 26 Oct 2026 20:22:02 +0800
Message-ID: <456FDF9B1F740189+20261026122638.9198-17-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OE5Co2iUKZ6k6ZxVPzWJ5cWMqzi1wTI1ixOqoFFk3vDy7jfXbMAJMJqb
 DRHCFCFs60JNbQWhtEgp5m+wTGCs4OYtAJtAX0SasX6PIr/HskPBGloF8zdVf5g12HL0LYU
 3qlCQJ0AcEBrY/EzDiCr99/3TqCpuTyfYhIHQ/G6QJHDxw2k3shA2c19QLRks90Y3ZCPKeE
 rzhhq2JzJpnrp3XYVDD3lFN96nnHaDakAZIvI3eZUoW8h+jqIp28wf+7/ifCc54JQHZfyVW
 z/l3oB//o5CHHoM/XroOylrm1OcV+RoyNohthcwqjKTbBut3tdBQjItt3/fP8d7EYf5TwQ4
 +BWukhJ5kJko/LWq4tUOkZ+pfPUQLS0+14N2YCuIAWWuGQLZI3I4vZjXVfYiYRUIortAyZv
 9xhdIHSG/06M2VITJCXMkPgicRAlz2kPOULVjdN7ouD4GoYpvNK0LDoTaetR0zdY2FxDugK
 E+d2tzmJshcaGySdVFNCDIlVXIvMOpwqXmlK0MZCEwFBa3gqpK8csNrJAOJlTY7A+uZxIRV
 UMUJ3Ty81XMrDB5VNRg+PyJNYvCk6oFKfj72CR6n5adxqPGb1AaTAOiH+dEXNT6IAQPHkb+
 TohEFu00fY0hS9rSn+h7fXu1Pw3wvm3hg7DLNrDOUtiRMbEKg89IWrIflUMUIg+1d8hlvtz
 JLX8V1vlOg0KUnlCbFHjjGfhvy+fodw8ryUkLZmCzGjNt7G4Adc5TS1jpdebQL9ECj2ZtvO
 BHNhi+hTu21ZdKbcdEVV7FzTHmbUeDOmc329jkQG/jyyXWSzRL/royicwvnKTR6YtDmjL+1
 jEkuow4BqVwGTWF5tw+hr1rjXf4n3PAyPwPAy/8/JSrpecHqjqs4bB52QgK6oVdIEuwP3wx
 mXprzm14mEXByMfIFzzho5DAf4izFzRYq258WNj301OgjS3vmy4ZkzwTcbRUFSZ96apTmAG
 7lgRpvDN6bTUyOHZ1MNJ8sDoFoyHjiZVjVtl1smEKYIjcj/eKe9V060ZNwuRDyJgOusHIub
 PtpdpDl5RqWqH3kQm9Gr1Y8EUj10NYxv/lj2/ZRt2tysCCE+RH3GVbxJws31XXVkiOQrJ+z
 jsYRn6QNVSzCC90ENDNp7DkyZ2j/gB3RCNl5aUvKrLza9OChvGakCI=
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
index 93e4b4db95..5fb10f6743 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3077,8 +3077,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	if (!hw->devarg.auto_neg)
 		return;
 
-	/* only continue if link is down */
-	if (dev->data->dev_link.link_status)
+	/* Continue only for an administratively up port with link down. */
+	if (!hw->dev_start || dev->data->dev_link.link_status)
 		goto out;
 
 	value = rd32_epcs(hw, VR_AN_INTR);
@@ -3416,6 +3416,11 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
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

