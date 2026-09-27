Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABF9C9830E
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Sep 2026 04:26:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5D7840274;
	Sun, 27 Sep 2026 06:26:04 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 34E9F40274
 for <dev@dpdk.org>; Sun, 27 Sep 2026 06:26:04 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-343479e6005so370750eec.0
 for <dev@dpdk.org>; Sat, 26 Sep 2026 21:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790483163; x=1791087963; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pEoVNlxdS9lqNMyzNPMbNJ1I3a2kuVxfY1Z8qeZZ/JQ=;
 b=RODQ2rrmFau65Ganv/jcM7Jqz++kXK4lnW7ekogFcBaBXB11e3z7ELLeVxtun/la6/
 dKAGssR+q19DYMu3zq0Ci0zEAuCgXu7D8iiSH/ZUNDr1G/yM8aJtifCaK7+v0s/gzWEE
 Dnz2KXIwnoGm9tFoDjvGZncNYTYIJgO1HeU6YjETLw66fOQlBe6clkfFA/c2TRm0gWX7
 MQcelxNwe230u/g1DeaWv9ZO3RuxdWj1eX0vmUMvLdM+OrRBiwdxYC1aUIf3+x6uD6Tv
 5DT/tFm1N88LoGNhLp8K4YDG66VzCGkvismRo1Ef9/Q3Y4Kn9xE7rim/orCor6oM2tOP
 1ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790483163; x=1791087963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pEoVNlxdS9lqNMyzNPMbNJ1I3a2kuVxfY1Z8qeZZ/JQ=;
 b=mFusVhDaRagkC1qiUXMdQBGvtjBnh+7eFL28YtEiTEMA40y3USw3YL88f6GtPWjgaZ
 TlnYlgCNjaaci8ZY/A276V0rG2o+3QZMZXXqBvAGRBq4W3shMp3TMeCTrIn+vzNbjS5k
 AWmkOzIphzDVjke/3g7i59uyCGfdAKTlIb36xMHKuCdAubD8MHYhDrtUapFeUQBSDT4e
 QIC85BI0hul5OAjeOXzVQRhLbuU6Z7yscgCiPkP7RQ0J11q67oN6g40UKUjaNZ+gE0F/
 oDETYtVFI+vdxmOglWM1TV1/W9DNU3AnQmBVHkbF61Ztlgc7sxeGOxxN4D14kI6s3A+o
 yNJg==
X-Gm-Message-State: AFuF++liCbx+CoKLseAzKdpviuUleagN/ACbEdjST6Vb83joz+WwM2aw
 9dj3aYTIdvC7Litkw86+LxBx97zgsZy7hB920ETIQKcbHQeZ9XQVSUhVSgeSKio2
X-Gm-Gg: AYBFou20mZLi8Z22jaU1GbgDIgmgHVVX4bdmBnzayJnsYXA7vbXvcKql/YGXsv35LmR
 xyYxlxkbzf0M3FpFbzDzM67YpjCrrQEK62e5Zs6iLemNw8mbVA1COL9OaSRtx4d0vPTNIe5QaTo
 0DGc68YEQGrbSWx/VognmW+7roTcpAViZ+f8Kd5mFLepodZ1q/83orvV9GW0xq1abE21m7Q8jBh
 ciDUXBiezSFNnHSR0RUeKoqw7gYiwK7Z+B1TKr9b2/eaR1HWvuj6av2wbjau1P/eY+qE52fRyeK
 4P+jlib6QP37JE1AB1vIJaTHCcPHZOXVrY0/m3h520ZFEcdZzOsOjnVQgRLagpjCqOamFMRT6Sd
 CsaBdAQbmhxwoKcxcA9Ra9r1K4gyY2LZ3Pu7ROb+5vN6ztCcd2bklmVDGIdvy7UKfFIRaFGuulH
 H4SaBYBC2lMU2x+21rCZmESuWeYrmXctlCHo9fttl9JqqyTda138dLSBkdqmtRfZb8YRFSsH9Do
 HcLqLE=
X-Received: by 2002:a05:7301:fc82:b0:33b:e757:bb46 with SMTP id
 5a478bee46e88-34273a3fb21mr4329588eec.25.1790483162990; 
 Sat, 26 Sep 2026 21:26:02 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-341460f5166sm19731165eec.29.2026.09.26.21.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 21:26:02 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dongdong Liu <liudongdong3@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2] net/ixgbe: fix repeated Rx packet buffer shrink for FDIR
Date: Sun, 27 Sep 2026 12:25:44 +0800
Message-ID: <20260927042545.45152-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916135827.116145-1-zhtfdev@gmail.com>
References: <20260916135827.116145-1-zhtfdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enabling Flow Director reduces RXPBSIZE(0) to reserve packet buffer
memory for the filter table. The new size was computed from the current
register value, and nothing restored it when FDIR state was reset. After
the last FDIR rule was removed, or when the first rule failed after FDIR
had been enabled, the next rule created enabled FDIR again and reduced
the buffer a second time.

Compute RXPBSIZE(0) from the default packet buffer size, and disable
FDIR and restore the buffer when the last rule is removed, on flush, and
on the enable error paths.

Fixes: 301abd26b118 ("net/ixgbe: reset flow state on clear paths")
Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
v2:
- Drop the rx_pb_reduced flag and keep resetting the FDIR mode to NONE
  when the last rule is removed (Bruce).
- Compute RXPBSIZE(0) from hw->mac.rx_pb_size, and disable FDIR and
  restore the buffer when the last rule is removed or on flush, based
  on Anatoly's draft.
- Disable FDIR again if the first rule fails after enabling it.
- Do not fail flush if re-initializing the FDIR tables fails, as FDIR
  is disabled right after.
- Add Fixes tag for the first-rule failure path.
- Compile tested only.
- Author name follows the pending .mailmap update: <https://patches.dpdk.org/project/dpdk/patch/20260927035949.36887-1-zhtfdev@gmail.com/>

 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  1 +
 drivers/net/intel/ixgbe/ixgbe_fdir.c   | 70 +++++++++++++-------------
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 34 ++++++++-----
 3 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 2e9d166e29..dfc8fce1a8 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -700,6 +700,7 @@ void ixgbe_filterlist_flush(struct rte_eth_dev *dev);
 int ixgbe_fdir_configure(struct rte_eth_dev *dev,
 			 const struct rte_eth_fdir_conf *fdir_conf,
 			 const struct ixgbe_hw_fdir_mask *fdir_mask);
+void ixgbe_fdir_disable(struct ixgbe_hw *hw);
 int ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter,
 			      const struct ixgbe_hw_fdir_mask *mask,
 			      enum rte_fdir_mode mode);
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index 0159c5b3b7..ffa9f5cc4d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -101,7 +101,6 @@ static int fdir_write_perfect_filter_82599(struct ixgbe_hw *hw,
 static int fdir_add_signature_filter_82599(struct ixgbe_hw *hw,
 		union ixgbe_atr_input *input, u8 queue, uint32_t fdircmd,
 		uint32_t fdirhash);
-static int ixgbe_fdir_flush(struct rte_eth_dev *dev);
 
 /**
  * This function is based on ixgbe_fdir_enable_82599() in base/ixgbe_82599.c.
@@ -554,6 +553,19 @@ ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
+void
+ixgbe_fdir_disable(struct ixgbe_hw *hw)
+{
+	int i;
+
+	IXGBE_WRITE_REG(hw, IXGBE_FDIRCTRL, 0);
+	IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(0),
+			hw->mac.rx_pb_size << IXGBE_RXPBSIZE_SHIFT);
+	for (i = 1; i < 8; i++)
+		IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(i), 0);
+	IXGBE_WRITE_FLUSH(hw);
+}
+
 int
 ixgbe_fdir_configure(struct rte_eth_dev *dev,
 		const struct rte_eth_fdir_conf *fdir_conf,
@@ -601,12 +613,12 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev,
 
 	/*
 	 * Before enabling Flow Director, the Rx Packet Buffer size
-	 * must be reduced.  The new value is the current size minus
+	 * must be reduced.  The new value is the default size minus
 	 * flow director memory usage size.
 	 */
 	pbsize = (1 << (PBALLOC_SIZE_SHIFT + (fdirctrl & FDIRCTRL_PBALLOC_MASK)));
 	IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(0),
-	    (IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(0)) - pbsize));
+	    (hw->mac.rx_pb_size << IXGBE_RXPBSIZE_SHIFT) - pbsize);
 
 	/*
 	 * The defaults in the HW for RX PB 1-7 are not zero and so should be
@@ -620,21 +632,25 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev,
 	err = ixgbe_fdir_set_input_mask(adapter, fdir_mask, mode);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD mask");
-		return err;
+		goto error;
 	}
 	err = ixgbe_set_fdir_flex_conf(adapter, &fdir_conf->flex_conf,
 				       &fdirctrl);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD flexible arguments.");
-		return err;
+		goto error;
 	}
 
 	err = fdir_enable_82599(hw, fdirctrl);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on enabling FD.");
-		return err;
+		goto error;
 	}
 	return 0;
+
+error:
+	ixgbe_fdir_disable(hw);
+	return err;
 }
 
 /*
@@ -1191,28 +1207,6 @@ ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
 	return err;
 }
 
-static int
-ixgbe_fdir_flush(struct rte_eth_dev *dev)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	int ret;
-
-	ret = ixgbe_reinit_fdir_tables_82599(hw);
-	if (ret < 0) {
-		PMD_INIT_LOG(ERR, "Failed to re-initialize FD table.");
-		return ret;
-	}
-
-	info->f_add = 0;
-	info->f_remove = 0;
-	info->add = 0;
-	info->remove = 0;
-
-	return ret;
-}
-
 #define FDIRENTRIES_NUM_SHIFT 10
 void
 ixgbe_fdir_info_get(struct rte_eth_dev *dev, struct rte_eth_fdir_info *fdir_info)
@@ -1371,13 +1365,22 @@ int
 ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 {
 	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_fdir_filter *fdir_filter;
-	bool had_flows;
-	int ret = 0;
 
-	had_flows = (fdir_info->n_flows != 0);
+	if (fdir_conf->mode != RTE_FDIR_MODE_NONE) {
+		if (ixgbe_reinit_fdir_tables_82599(hw) < 0)
+			PMD_DRV_LOG(WARNING, "Failed to re-initialize FD table");
+
+		fdir_info->f_add = 0;
+		fdir_info->f_remove = 0;
+		fdir_info->add = 0;
+		fdir_info->remove = 0;
+
+		ixgbe_fdir_disable(hw);
+	}
 
 	/* flush flow director */
 	rte_hash_reset(fdir_info->hash_handle);
@@ -1397,8 +1400,5 @@ ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 	fdir_info->mask_added = FALSE;
 	fdir_conf->mode = RTE_FDIR_MODE_NONE;
 
-	if (had_flows)
-		ret = ixgbe_fdir_flush(dev);
-
-	return ret;
+	return 0;
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index ff56d7b279..a8d1b269c7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2625,6 +2625,7 @@ ixgbe_fdir_flow_program(struct rte_eth_dev *dev,
 	struct rte_eth_fdir_conf local_fdir_conf = *fdir_conf;
 	struct ixgbe_hw_fdir_info *fdir_info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
+	bool fdir_enabled = false;
 	int ret;
 
 	if (fdir_rule->queue >= dev->data->nb_rx_queues) {
@@ -2647,6 +2648,7 @@ ixgbe_fdir_flow_program(struct rte_eth_dev *dev,
 				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 				NULL, "Failed to configure fdir mode");
 		}
+		fdir_enabled = true;
 	} else if (fdir_conf->mode != fdir_rule->mode) {
 		return rte_flow_error_set(error, EINVAL,
 			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
@@ -2657,17 +2659,25 @@ ixgbe_fdir_flow_program(struct rte_eth_dev *dev,
 	ret = ixgbe_fdir_process_rule(adapter, fdir_info, fdir_rule,
 		first_mask, error);
 	if (ret)
-		return ret;
+		goto error;
 
 	/* Program the filter */
 	ret = ixgbe_fdir_filter_program(adapter, &local_fdir_conf,
 			fdir_rule, FALSE, FALSE);
-	if (ret)
-		return rte_flow_error_set(error, EINVAL,
+	if (ret) {
+		ret = rte_flow_error_set(error, EINVAL,
 			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 			NULL, "Failed to add fdir filter");
+		goto error;
+	}
 
 	return 0;
+
+error:
+	/* FDIR mode is only recorded on success, so undo the enable */
+	if (fdir_enabled)
+		ixgbe_fdir_disable(IXGBE_DEV_PRIVATE_TO_HW(adapter));
+	return ret;
 }
 
 /* Flow actions check specific to RSS filter */
@@ -3159,16 +3169,16 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
 		fdir_rule = fdir_rule_ptr->filter_info;
-		ret = ixgbe_fdir_filter_program(adapter, fdir_conf, &fdir_rule, TRUE, FALSE);
-		if (!ret) {
-			rte_free(fdir_rule_ptr);
-			if (fdir_info->n_flows > 0 && --(fdir_info->n_flows) == 0) {
-				fdir_info->mask_added = false;
-				fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
-				fdir_info->flex_bytes_offset = 0;
-				fdir_conf->mode = RTE_FDIR_MODE_NONE;
-			}
+		if (fdir_info->n_flows == 1) {
+			ret = ixgbe_clear_all_fdir_filter(dev);
+		} else {
+			ret = ixgbe_fdir_filter_program(adapter, fdir_conf,
+					&fdir_rule, TRUE, FALSE);
+			if (!ret && fdir_info->n_flows > 0)
+				fdir_info->n_flows--;
 		}
+		if (!ret)
+			rte_free(fdir_rule_ptr);
 		break;
 	case RTE_ETH_FILTER_L2_TUNNEL:
 		l2_tn_filter_ptr = (struct ixgbe_eth_l2_tunnel_conf_ele *)
-- 
2.53.0

