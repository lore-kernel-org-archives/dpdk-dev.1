Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2F6CDB471
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:55:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0B0A40E1E;
	Wed, 24 Jun 2026 13:53:56 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id F3D9640DCE;
 Wed, 24 Jun 2026 13:53:48 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782302026ted66b0a1
X-QQ-Originating-IP: AuRHr4kCuExpjQvBYG39ccOIWOKzycY2Xl3H7jiG4/Q=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3617895363466790829
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 21/21] net/txgbe: fix temperature track for AML NIC
Date: Wed, 24 Jun 2026 19:52:53 +0800
Message-Id: <20260624115254.20348-22-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MyNcQibNhlwY4EvCHionNUlyjUKfpZqoK6vDqrJYYmd/R6E77Qum3LGa
 38v+7vfKfS1pifeFcJR375Ks4IZsIFh8BVmZ8/vaC2PseQxF32IMN3cBIMe3ba+VQ+HxWxA
 moctiUTi8aH9TXvGlDBmDuod6+791/fgiF9ItfMi4UcyIMbyWUsrY3UANBOdN35+qc/esvj
 8mFS/k4QM54zLUKwtU4byMa7+3ZSb+MD5kAJMTT4+L19y6dO5cYkC/Utnc51QqH55RW1fVJ
 Rh/OODEMQR58ZbCaTZYfoyB7w8Wp/M5Ru64QKlWifrZbXyJNGAaNuToahlsdkZH1DWsOKZn
 TUJJAjXNkH1EstlVuXftrJjiCWXRIOnDyolxBylGlx7SiawGNlPlG5Y7oYQyb2TP7OYIbQy
 TJxGekhO4VMV/3vzCxge0KHv/U9ECi2QFH82WVQ9RyDfupt4p2el2CsJIqVpXIhybkylDZ6
 HQAfKOaOKJOo7JD7LiD00SiTidqtX2/Aa6h5qocF1EMMJarhaPtvvukPE/MPUIyurJUIS9N
 fUS2uwONXG13nZKX8sY55iyfhwA8T99fVlwc1dvEPfCVERZ95L8+s/UbRkfm8nQ3jaIpHIy
 Uoy4JpDBLhyJn40iVX3fLY7vSm8WmBL+CDWEJi9rotl0TQsjjpG3cNb4iRC8TKELSHszG3e
 DaPMBEVMVf3KoZ8KCTRXX1PzviVNYUO66rpUw0/la1/UYB+YSX/mqf9iJwG/+25+yZTEZNB
 JhT6MOvgQbyDLNlY74kZFLZf470DB6iOL+fsFdJu7psRC2P/QE+T2UaO2yEvHT2bTq5M4zv
 WiAX2ghdcY9V9PW7+FbjiGuz7Ua3j87qfW8QuVuJ2O+WDeijq+wJwxBLf8vPzzX2EtFRfD2
 V/ae5CUpILe9H2DPJhtgt99ReM0h95Zgj3fvGIi47Kkj/Qi7/Vw4wiUlGhcMmUOmfl5QUXz
 axEJZKcJ7keHCjQwdXkQuI3CFjTX438pJ4aaRACIVgOIQaQhbhS7uTLByqcu+BqPgJwVLWb
 tzpCDjNcS+IFOfhai9WI8YUZLHwD59qKcb3hTnqz2nuF3uILd5YNbYuv9V9IcajI0N0kqLw
 Ain5NQu29W308P40zwuSEBRXCESenr/7kSXsXB1xjic
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

Previously, temperature tracking for the amlite NIC was handled by
firmware together with the hardware setup. However, the firmware-based
PHY configuration has proven to be unstable.

Re-add the temperature tracking function directly in the driver and
invoke it periodically to ensure the PHY remains calibrated. According
to the hardware recommendation, the tracking sequence should be run at
least every 100 ms to keep temperature drift within 5 °C. Considering
the software and hardware overhead, a 2-second interval is used as a
practical trade-off that still meets stability requirements while
minimizing performance impact.

The periodic tracking is implemented using a timer in the driver, and
the sequence itself is the same as the one originally performed during
link setup.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 44 +++++++++++++++++++++++++++++++-
 drivers/net/txgbe/txgbe_ethdev.h |  1 +
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 1dd849f578..5626527d75 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2011,8 +2011,10 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	txgbe_filter_restore(dev);
 
 	hw->bp_event_interval = 100 * 1000;
-	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
 		rte_eal_alarm_set(hw->bp_event_interval, txgbe_dev_e56_check_bp_event, dev);
+		rte_eal_alarm_set(1000 * 1000 * 2, txgbe_dev_check_aml_temp_event, dev);
+	}
 
 	if (tm_conf->root && !tm_conf->committed)
 		PMD_DRV_LOG(WARNING,
@@ -2060,6 +2062,7 @@ txgbe_dev_stop(struct rte_eth_dev *dev)
 
 	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
 		rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
+		rte_eal_alarm_cancel(txgbe_dev_check_aml_temp_event, dev);
 		rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
 	}
 
@@ -2932,6 +2935,45 @@ txgbe_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 	return NULL;
 }
 
+void txgbe_dev_check_aml_temp_event(void *param)
+{
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	uint32_t link_speed = 0, val = 0;
+	s32 status = 0;
+	int temp;
+
+	if (hw == NULL)
+		return;
+
+	status = txgbe_e56_get_temp(hw, &temp);
+	if (status)
+		temp = DEFAULT_TEMP;
+
+	if (!(temp - hw->temperature > 4 ||
+		hw->temperature - temp > 4))
+		goto out;
+
+	hw->temperature = temp;
+	val = rd32(hw, TXGBE_PORT);
+	if (val & TXGBE_AMLITE_LED_LINK_40G)
+		link_speed = TXGBE_LINK_SPEED_40GB_FULL;
+	else if (val & TXGBE_AMLITE_LED_LINK_25G)
+		link_speed = TXGBE_LINK_SPEED_25GB_FULL;
+	else
+		link_speed = TXGBE_LINK_SPEED_10GB_FULL;
+
+	rte_spinlock_lock(&hw->phy_lock);
+	if (hw->mac.type == txgbe_mac_aml)
+		txgbe_temp_track_seq(hw, link_speed);
+	else if (hw->mac.type == txgbe_mac_aml40)
+		txgbe_temp_track_seq_40g(hw, link_speed);
+	rte_spinlock_unlock(&hw->phy_lock);
+
+out:
+	rte_eal_alarm_set(1000 * 1000 * 2, txgbe_dev_check_aml_temp_event, dev);
+}
+
 void txgbe_dev_e56_check_bp_event(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 309db3bfe9..c32c61d8bf 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -747,5 +747,6 @@ void txgbe_vlan_hw_strip_bitmap_set(struct rte_eth_dev *dev,
 		uint16_t queue, bool on);
 void txgbe_config_vlan_strip_on_all_queues(struct rte_eth_dev *dev,
 						  int mask);
+void txgbe_dev_check_aml_temp_event(void *param);
 void txgbe_dev_e56_check_bp_event(void *param);
 #endif /* _TXGBE_ETHDEV_H_ */
-- 
2.21.0.windows.1

