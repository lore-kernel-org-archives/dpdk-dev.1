Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E36CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:01:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4124E4067B;
	Tue, 13 Oct 2026 16:01:41 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id A960740608
 for <dev@dpdk.org>; Tue, 13 Oct 2026 16:01:39 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so1484291a91.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791900099; x=1792504899; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BRWk6YxO5WREtLoMVh0tZI4GtuKIpfKjioOnfZaBFqg=;
 b=ZS/FmxYIlZbaQHYn8KSHF+brutjz6/wcw0yx6witllBxVn55uEMLTI4Pd/m7HKsYv6
 b6mU/cMfi7+j2Hefev8FIzlYDYcciDROsrAdv89MWmvrH6H8Fw0P7h0pFKlOs/1b6V7q
 w5XwHsCVXGPMDMxjd6r+87M9+9oKoebvj3n+eZpGceB5s/QGKF4C+R21y3FRXoO7IAQl
 YP7/ffKpUfqz/VaZHPCHtN9/hcTsqSMZkxcPRZVtcsQzfWgBSTUQPUGUejffcBuxRXew
 PiL2C4CH0+VG4KkxctjKnT9ZDeAHqq2755axYNPQzUAGH9H9GDAZy2Eazcgt/DyZ9fxH
 cIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791900099; x=1792504899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BRWk6YxO5WREtLoMVh0tZI4GtuKIpfKjioOnfZaBFqg=;
 b=o5fMN61ae2WPECnZKFFT8MZs1ug0ULeSDrtr9oaiFPaFtWpmh/L/XLInBAQNBUJcnI
 FWSGVz11bG0QfdfWwoNhmdnQI7LCDlz4z2leR5SZh3FcKCd01OAr7txGscUESV7ggWcQ
 xaIEd9v1oxXu10SOyIDvIdUmDhHAijv1WM8VzmtEnZTU8ubEfDqY5l/7r0tnH0Th7Vqs
 uUNG6oWiQ3uQir+OP04geAXDIRzqKUIMHFpcdkeFGmjlMaX9O9lUAmUqsPVCZ9tJ+Pn9
 5cDlIiRaOm4yEYXuaI8Lm7W5cvPC+pyEldmTFcXiBzQNhEcAfFqUfIQvtyu5PoIA1JMS
 X1xw==
X-Gm-Message-State: AFq9FYLz5LziInbBbxgWJv+sBlT7YAnYUb6gN2Z3iE6/PpVLXZDkYQRE
 BMfqskRr0eLZUAQQAuquexotGfx6JlQTthAo7AKJgsm8TDT4h3OIbIddLDSnRBuD
X-Gm-Gg: AYBFou29GvhRJTf2ghESrE9V8iZc9+fAs84DqLUg7P0wAvOTDW8JdPZlg8CmCTfgMzE
 mfjhMJHkMoU3ioTVdaoz44hiNOxIr/72jytnGSyIxrksMyHJXNWqOtC130qMGMbCZwChFVo47xu
 SC4rw+/X38IhyZAXgElmpE5MO2jT4rAJ3Wz1QJzxxvU5i40gb+Wx4ObdYV1Bvd/EXxJLsNVcoeT
 4Lwz84InwnUak4dVD9uiKbuJjcPzWwvowQab0fMp8Ky+VAA3eZbn3C4F2LlYfLKF8wfdJt5jRYd
 5ccZLxkkvtflUsJLAF3D0OCIuVwc1w9XwMAD22F4AfteTKap6LZLemwGFn68dLQ4mKsBuuf/TDp
 5pxKpfX8zWq89LIqrKFEzMOf0FeqMNgIEVgFUt7xYOHxb7L5rGFdakAHEDzhv/ct9YcCFajqP2D
 MtdzCh2oBIW2NM3bvi4VaRJ5IsoHgZuBIF7VRFLZ70dOYIjkoegm8yAj/gPd7F+TXow9gP4RMiR
 TM03rk=
X-Received: by 2002:a17:90b:5444:b0:3aa:fc22:8aa7 with SMTP id
 98e67ed59e1d1-3ab3ac72e81mr10096147a91.53.1791900098456; 
 Tue, 13 Oct 2026 07:01:38 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371c32cesm20733947a91.16.2026.10.13.07.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:01:37 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Zhang Tengfei <zhtfdev@gmail.com>,
 jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com, stable@dpdk.org
Subject: [PATCH 3/3] net/txgbe: disable flow director when no rule is left
Date: Tue, 13 Oct 2026 22:00:19 +0800
Message-ID: <c16eb4a095e8ce67edb43592b9be90826ce3dcff.1791898970.git.zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791898970.git.zhtfdev@gmail.com>
References: <cover.1791898970.git.zhtfdev@gmail.com>
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
index f2fc589a10..9fa79fc064 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3483,8 +3483,10 @@ txgbe_flow_create(struct rte_eth_dev *dev,
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
@@ -3637,6 +3639,9 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
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

