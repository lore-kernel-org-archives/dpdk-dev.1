Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38E6C3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:40:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86C9040689;
	Wed, 14 Oct 2026 18:39:59 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id C0D1F40272
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:39:57 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-887beafb714so2220236b3a.1
 for <dev@dpdk.org>; Wed, 14 Oct 2026 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791995997; x=1792600797; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1CpGMjVrJcV3iu4f/hOy96tOMmEQXP+30mL+kMfoa9Y=;
 b=RDW/N24DA+RUGofLjatSdXZbEOyKn0ljqqe+nUVFEC5gb2x7KitY5uRdbGXw8gxI5d
 m91xIqEsXHsvSwYuBDzD0acCx0l38LVGx+6sngtxyzHaL5MllXtjo5dgnFC4GowvK11Y
 DANF8p9ikbwDYG0AUiuJwD75lsiNDX8HvzMVjJI2zxnkmsGHXGkjpgWfhVHUOs5RW6Mu
 s8JaYYJtjfFmbahgc48v4+qF7agXQoZDOWaX9nRUN8XDRWWY7SkSC4x98q428DkUUHAH
 r8A0S23Rw4qLngvLcnbFmvP3pBXaT5aLDgwipgprvalwlBzTAC0F06xdkfG+FF9NDlJK
 qqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791995997; x=1792600797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1CpGMjVrJcV3iu4f/hOy96tOMmEQXP+30mL+kMfoa9Y=;
 b=mELnn5AcEqjP6RsDlBRiMUh3UfaYJ0pKkrrABqHK9Gs2/ATczmgygpt2/FP1/hl6J5
 EoRVezRPpg1ExWrNB6aN49DFey49YC4w5V5laixL94CaxwLUPvpdZ4g3+IO/Mxkc9zqC
 ON6IMLv5SUpuKDUKFgvzvP+5z1eZIYMgCMzKvEOvNkvK4wHXI15nWsy8qA8gPrsAOveg
 Wkhk88N1kTVgdjENQGJpTu1kxdSEl52pRyw3bw2W+GWSKDcx8P1VKX7u6W39Y+fCcZ23
 4i0jbqwCxZo7z8N7ZVIqbBGjYpimZF4U+wFC5IztmfRc4C9Wq1SuUf2DlruvTfGQKgmM
 +C0g==
X-Gm-Message-State: AFq9FYLCbetQnIQgxumfltwV9EEJ+7nE4Olrcgg/qz/wfYA0/S5WwOTC
 lnIheAs3FA6uGwMrMy5IMNodKMGk5+dB0kzrpX9/duXbhxYRRVXvtPl3J8ZAEz5x
X-Gm-Gg: AYBFou1pAaGUFFI65bAYgEJVKPdbpXzxKL4LO0oFQwZme1AQQ7ITfWCWJMQYvqMsKsF
 wm9qVzvHPWuimitoOBpVjwh3XC0VCs5523pGTDWDFYQq1Enly4b5gbxpp8vgcPuhxWc6KEvBwry
 tySB90elxnzwYhVQUm8+S8Kl0xAOrP78ptq1WgYI6gCxhtqYXi7S9DpGqy40+s8bfX4nMiqylxy
 GSHKvoWXf79SLUAvTcvZBNNx8u0Dq9d40Mce313lmarTCAgCg6YiE38UXPKTUyqTM1UBv9BkAzN
 QFzdXQPvCLjabYDY+c+0/kXZPGgAB/txIwYyW1V/NP+VuSWNkbSw+neZhLzIoxkGJR/8x4VxCBH
 /mQnR8dRWUtgZHogek02Ad+7ZbE5aHnTaSQMhqOIMRa9YQ1vwVSHTfN8cFeaPiapKutBziaow+p
 lbcgqXivsT+WEC5bAigLefODfLWvcqmQkyMbqIAyXn408YpwhhJlO0eeeY1BEDdRn2poEcbIBiU
 qaVRFs=
X-Received: by 2002:a05:6a21:3284:b0:3e1:3a2c:8d21 with SMTP id
 adf61e73a8af0-3e16bed5447mr13434626637.31.1791995996911; 
 Wed, 14 Oct 2026 09:39:56 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635cd3b34sm83677a12.28.2026.10.14.09.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:39:56 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: Zhang Tengfei <zhtfdev@gmail.com>, jiawenwu@trustnetic.com,
 zaiyuwang@trustnetic.com, stephen@networkplumber.org, stable@dpdk.org
Subject: [PATCH v2 3/3] net/txgbe: disable flow director when no rule is left
Date: Thu, 15 Oct 2026 00:39:24 +0800
Message-ID: <2fe121933a3bdc1492fc1e36348e282f72a08ad9.1791995192.git.zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791995192.git.zhtfdev@gmail.com>
References: <cover.1791995192.git.zhtfdev@gmail.com>
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

When the last FDIR rule is destroyed, on flush, or when enabling
FDIR fails, the FDIR mode is reset to none, but Flow Director is
left enabled and the Rx packet buffer stays reduced.

Disable Flow Director and restore the Rx packet buffer size in
these cases, and when the first rule fails after FDIR was enabled.

Fixes: ea230dda16ad ("net/txgbe: configure flow director filter")
Fixes: 26048c25942f ("net/txgbe: fix FDIR mode clearing")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_ethdev.h |  1 +
 drivers/net/txgbe/txgbe_fdir.c   | 31 +++++++++++++++++++++++++++----
 drivers/net/txgbe/txgbe_flow.c   |  7 ++++++-
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index a617b70e3c..05c20fd58c 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -552,6 +552,7 @@ void txgbe_set_ivar_map(struct txgbe_hw *hw, int8_t direction,
  * Flow director function prototypes
  */
 int txgbe_fdir_configure(struct rte_eth_dev *dev);
+void txgbe_fdir_disable(struct txgbe_hw *hw);
 int txgbe_fdir_set_input_mask(struct rte_eth_dev *dev);
 uint16_t txgbe_fdir_get_flex_base(struct txgbe_fdir_rule *rule);
 int txgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index cee38a42b8..8e397c995c 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -368,6 +368,18 @@ txgbe_set_fdir_flex_conf(struct rte_eth_dev *dev, uint32_t flex)
 	return 0;
 }
 
+void
+txgbe_fdir_disable(struct txgbe_hw *hw)
+{
+	int i;
+
+	wr32(hw, TXGBE_FDIRCTL, 0);
+	wr32(hw, TXGBE_PBRXSIZE(0), hw->mac.rx_pb_size << 10);
+	for (i = 1; i < 8; i++)
+		wr32(hw, TXGBE_PBRXSIZE(i), 0);
+	txgbe_flush(hw);
+}
+
 int
 txgbe_fdir_configure(struct rte_eth_dev *dev)
 {
@@ -408,27 +420,31 @@ txgbe_fdir_configure(struct rte_eth_dev *dev)
 	err = txgbe_fdir_store_input_mask(dev);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD mask");
-		return err;
+		goto error;
 	}
 
 	err = txgbe_fdir_set_input_mask(dev);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD mask");
-		return err;
+		goto error;
 	}
 
 	err = txgbe_set_fdir_flex_conf(dev, flex);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on setting FD flexible arguments.");
-		return err;
+		goto error;
 	}
 
 	err = txgbe_fdir_enable(hw, fdirctrl);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on enabling FD.");
-		return err;
+		goto error;
 	}
 	return 0;
+
+error:
+	txgbe_fdir_disable(hw);
+	return err;
 }
 
 /*
@@ -1138,12 +1154,16 @@ txgbe_fdir_filter_restore(struct rte_eth_dev *dev)
 int
 txgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 {
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
 	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(dev);
 	struct txgbe_fdir_filter *fdir_filter;
 	struct txgbe_fdir_filter *filter_flag;
+	bool fdir_enabled;
 	int ret = 0;
 
+	fdir_enabled = fdir_conf->mode != RTE_FDIR_MODE_NONE;
+
 	/* flush flow director */
 	rte_hash_reset(fdir_info->hash_handle);
 	memset(fdir_info->hash_map, 0,
@@ -1161,5 +1181,8 @@ txgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 	if (filter_flag != NULL)
 		ret = txgbe_fdir_flush(dev);
 
+	if (fdir_enabled && txgbe_is_pf(hw))
+		txgbe_fdir_disable(hw);
+
 	return ret;
 }
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 0b7ce3aa2d..7016fb29d2 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3487,8 +3487,10 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 	rte_free(fdir_rule_ptr);
 	if (first_mask)
 		fdir_info->mask_added = FALSE;
-	if (fdir_configured)
+	if (fdir_configured) {
+		txgbe_fdir_disable(TXGBE_DEV_HW(dev));
 		fdir_conf->mode = RTE_FDIR_MODE_NONE;
+	}
 out:
 	TAILQ_REMOVE(&txgbe_flow_list,
 		txgbe_flow_mem_ptr, entries);
@@ -3641,6 +3643,9 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 				fdir_info->mask_added = false;
 				fdir_info->flex_relative = false;
 				fdir_info->flex_bytes_offset = 0;
+				if (fdir_conf->mode != RTE_FDIR_MODE_NONE &&
+				    txgbe_is_pf(TXGBE_DEV_HW(dev)))
+					txgbe_fdir_disable(TXGBE_DEV_HW(dev));
 				fdir_conf->mode = RTE_FDIR_MODE_NONE;
 			}
 		}
-- 
2.53.0

