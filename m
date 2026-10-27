Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C9606A33C
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:44:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 194CA4068E;
	Tue, 27 Oct 2026 12:43:05 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTPS id 1822840DD5;
 Tue, 27 Oct 2026 12:43:00 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101377tbc1974be
X-QQ-Originating-IP: I2B8NNsGISFlzn9kzdg90y0UDYPH1kodkjahD4g45Hc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7614391868193185871
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v12 16/17] net/txgbe: respect manual link-down on Amber-Lite
Date: Tue, 27 Oct 2026 19:38:32 +0800
Message-ID: <7DFF83FB89E01083+20261027114218.9724-17-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261027114218.9724-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M5/msJgRun51eDknJ+UOTkbwlUXq0embAdC8EoVhY5aA7+a2qBgEjEcv
 Lcsf2u9HfAZW5plh5apC0GDFA015Ek9HRHshU2Q/hmP63VPEwgWssfn3de3heAHdW0CHa+r
 4IaRR4IstttFGyhIbZ/pkpTA4uTYZcADqd1FyxAysPQs/IbxhRcvE2v1ZCAgNHxiTAKECcX
 zGgTNHPlJ0/nxWky3RMNv+BGAfGBrAu7pQfSQ73l0BqzdXfYySnAB96ZDilgU/lIjMnPM8q
 gs+Ra3TxLCjXPEoCHQGr7cmuJIMD3R+whWGO5so70BA+keUbEbulrmKrzoj63pwkOgIVtJ7
 FVuQbGGIbod1hEWZRiPaFnuDyByFBPjyAsAXrvLgUbGJFbZBNdbbqnMjblFHeCm+gxmwDvN
 K2DezrSeGsgV9XmxGNCeyvfXAnF6hVKQaAJ38vbvTuUmkOkDBdjNxpyS96TTMN/Uhr/cVoG
 +YzPMsxa8fTJ+d7ZXzXc7oXiy+xglK9JiqGNPoFUS3XisI5sevr1UbKFgihfNDrwFWLMMIy
 lmK4XRTNF9K6qpTzcA5T7eHLqQKqUjDPm2TfVwOeHgxUA118wVB3V6XWbMzPGsh2bkrN3IJ
 uY4EYnRvuU/HU8yn7Nfi5GLplK54BRTu3Pmp8eLHOGA8qsTihdFBng2IHcUY85cMU1afYch
 JcpM9IU6A78YQo61FfwGU4LGxM3kZ6eMRgVGmHAvj4K6LG8MV4JQY3IL28dWxqWgZPwWUfb
 6L7dU+CRyTJvBSgcHqyxD2LozdbEnkiCe0t5CRtpOs4TwW4xfoR4MEJBOXvrSvdhJyxjd30
 P5egp8MS7AcExfPkOPD0tHxTYjimy0oZeMc1W4V3fs1TADySofd1DN2R0ZPlhgfAlmsoUvp
 H8DktHa2up9OZiwrNVU9tDAXX8Y8689U8mhTdZ6gpaoxyvYnGo0+BLxdMmOGTfbvGcf9ve7
 buyul3cpAOOqrbyrF1zfrsSFcY1vBTdf0oPI5souBmA4bUor64BNRKfq3lSU2uKnPNNgtvC
 ZrGgtUqeU+MRploXPngvk5CaIMkTj6IhaBT4NzaKZ6NPAjMRo3VIAdhdQja/Oc1FQYj4cJD
 Pz6zBiJEfXoib185MoIIbfDL7WLsIUvsurPIZItnWtqXYp3lImZiqQ=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

Use hw->dev_start as the administrative link gate, and skip link
recovery while the port is administratively down.

The gate alone is not enough. A setup-link run that started before
link-down keeps going and rewrites the PMD transmit and receive
enables, so the port reports down while the peer still sees a signal.
Stop the AN73 watchdog and the setup-link alarm, wait for a running
link thread to finish, and only then drop the transmitter.

Arm the watchdog again on link-up so that monitoring resumes, and
cancel it first. The alarm list keeps every entry registered for the
same callback, and each entry re-arms itself, so arming without
cancelling would leave two watchdog chains running.

This keeps the link down until rte_eth_dev_set_link_up() explicitly
re-enables it. The link-up path then restores the required PHY
configuration.

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 34 +++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 043c96b747..fc3c5539c2 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2227,12 +2227,33 @@ txgbe_dev_set_link_up(struct rte_eth_dev *dev)
 		}
 
 		hw->dev_start = true;
+		if (hw->mac.type == txgbe_mac_aml ||
+		    hw->mac.type == txgbe_mac_aml40) {
+			rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
+			rte_eal_alarm_set(hw->bp_event_interval,
+					  txgbe_dev_e56_check_bp_event, dev);
+		}
 		txgbe_dev_link_update(dev, 0);
 	}
 
 	return 0;
 }
 
+static void
+txgbe_stop_link_handlers(struct rte_eth_dev *dev)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+
+	if (hw->mac.type != txgbe_mac_aml &&
+	    hw->mac.type != txgbe_mac_aml40)
+		return;
+
+	rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
+	rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
+	txgbe_dev_wait_setup_link_complete(dev, 0);
+	rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
+}
+
 /*
  * Set device link down: disable tx.
  */
@@ -2245,9 +2266,11 @@ txgbe_dev_set_link_down(struct rte_eth_dev *dev)
 		/* Turn off the copper */
 		hw->phy.set_phy_power(hw, false);
 	} else {
+		hw->dev_start = false;
+		txgbe_stop_link_handlers(dev);
+
 		/* Turn off the laser */
 		hw->mac.disable_tx_laser(hw);
-		hw->dev_start = false;
 		txgbe_dev_link_update(dev, 0);
 	}
 
@@ -3073,8 +3096,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	if (!hw->devarg.auto_neg)
 		return;
 
-	/* only continue if link is down */
-	if (dev->data->dev_link.link_status)
+	/* Continue only for an administratively up port with link down. */
+	if (!hw->dev_start || dev->data->dev_link.link_status)
 		goto out;
 
 	value = rd32_epcs(hw, VR_AN_INTR);
@@ -3412,6 +3435,11 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
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

