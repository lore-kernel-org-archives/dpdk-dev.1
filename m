Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AC7CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:47:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB5CA42F03;
	Thu,  1 Oct 2026 00:44:17 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id E056542EFF
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:15 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-3a49573b8bdso1986714a91.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808255;
 x=1791413055; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gNQO6qDNFOCyEMEY4D/q9dN8aF1GdjMLfZXfGnOK/UU=;
 b=zwi9JilE892ZxF2Xy1W/D7C36RdHK/Yg8R9F4TuuWMajplVU2ZkCa3cdQAal3Ua/q0
 sAHP7lzu918vczHjdOQ3Bovro1yChRFo/XA6/rGOClPeEVJx5s70/ErGX5TejuzzbTpo
 UHGh9ePRTmDAnH/5MaWc/YtUJT1JWKZ/ZnNaT8uneKRe4dZ1LJjjiQU+Z41H1xxN+jG+
 mc0QBEb/E2Um5aX/Eks860BMEfp0M/MI/+SVtNEmsXhguFLkBHj/eKM4jG3kknQzslLW
 zyG8AZu0qiNGLSZ2jksVIDcWFYntCSkJTGDQus72P6QngLCMu9ZBWf/RSuwuiHxOwroh
 cD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808255; x=1791413055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gNQO6qDNFOCyEMEY4D/q9dN8aF1GdjMLfZXfGnOK/UU=;
 b=jO3yQZLud8lR4y0TvZuVuzr0cl7Jt2fjW5ymn49Xxzp5TYalCXlcKB0yfyzV/l+e+F
 NrisDKl/NJkChwjchsoEwr91npHHbwSmkK4ehCUd9frQJu158aO8juMSlSdEYAcvOYlZ
 BUz7fP60LKzZh4J0Lzmcww9tXMAoGA/c0I9T6lW7MRA5uQSG0/rH0xmBjRs4GrXsVkNT
 idreiapgBn2wKknS4smcfW/cOrb5/ApbM0PBbwYaBiIuHuodJyooJCnnJJNa2jxlCYAF
 dfMC+v5Xbj94lJRxK/2oTS0OYZO9pJGTlvJaAIluSe2byBlKHkikWo0zqNcA6qY3JkzC
 aR3w==
X-Gm-Message-State: AFq9FYJx+Qdf4PD3vBoHdXUR5TE6yZ0D7fAg/tMVDLk5m7IbLsX/c9st
 pql2/vH4kJQcMv0yP/umbqVF9ccGbfuQS5YvKD6WDH2k+Rh1gcEe2FGqaI9etdCh/4VKRb/YGlz
 O/7swwDI=
X-Gm-Gg: AYBFou2xK21zrsND9jCE5NBVT9KZRz3KJywFqVC//ajxSgO0TSmgAarqCUMKlWVOW/g
 j59UTCShfBoRHnSJeCiduZhi9vHwWLLXa02YdS7SHlFCNFSd4zS0b7Ac4DGbSvwF8XiFX/oJa++
 EZIjprzbDmOpPASwDpJ4VQ9QG5QxBoXVINYpj4S0iSqRejZ46MG/UN8EKOoNhnHuR7vuIzWSI2G
 3NVv8UnJ8kNy+ZVb0JOmlQTs5vFU/IjXkh6uVDIznGCbJlE+uaE2zmLOJ+apkVAngH8lOQ2WZ35
 nTFuDGIVePNS1rU6cvUCi/6qOXTruMW1qfpFJZ5Jsk2h74ZdJyXVo4yonLf5rTxUy8mOFBP/cnV
 +kA0KP+fQLjiCC2LYXfUGOjoubas9GROonj0/xdGXvEwfC1R22i9fZkZbETlTGkwNiIlaEQ4xyK
 7ExuGsWH9JHqNWVhhFN6ymBM5A4kIgrAmrtjdwnANELDJ+qw6z8YjHVBZaGf44mh7RbkXq1XUIJ
 LSV6JmDGYsZPSY/HUr40HG+hcZ2cjvqCew/rA==
X-Received: by 2002:a17:90b:5450:b0:3a0:9aa4:f9bf with SMTP id
 98e67ed59e1d1-3a4d154254bmr2454937a91.12.1790808255044; 
 Wed, 30 Sep 2026 15:44:15 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v3 30/65] net/txgbe: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:48 -0700
Message-ID: <20260930224340.58580-31-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

txgbe_handle_devarg() truncates the strtoul() result into a uint16_t and
then infers overflow from the truncated value being USHRT_MAX, so a
value such as "65536" is silently accepted as zero. It also never
checked the end pointer, and read errno without clearing it first.

All thirteen rte_kvargs_process() results were discarded, so a bad
value was ignored and the default used instead. Collect them and fail
the probe, which makes a malformed devarg visible rather than silently
changing the configuration the user asked for.

auto_neg, poll, present, sgmii, tx_headwb and rx_desc_merge are
booleans, so parse them with rte_kvargs_handle_bool() into a bool. The
struct txgbe_devargs fields stay u16, since they live in base code
shared with the vendor tree; a bool assigned into them still yields 0
or 1. A bare key now enables the option, and the usual spellings are
accepted.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/txgbe/txgbe_ethdev.c | 97 ++++++++++++++------------------
 1 file changed, 42 insertions(+), 55 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 0734a1c63c..815bb3b486 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -447,28 +447,6 @@ txgbe_swfw_lock_reset(struct txgbe_hw *hw)
 }
 
 static int
-txgbe_handle_devarg(__rte_unused const char *key, const char *value,
-		  void *extra_args)
-{
-	uint16_t *arg = extra_args;
-	char *endp;
-	unsigned long num;
-
-	if (value == NULL || extra_args == NULL)
-		return -EINVAL;
-
-	errno = 0;
-	num = strtoul(value, &endp, 10);
-	if (*value == '\0' || *endp != '\0')
-		return -EINVAL;
-
-	if (num > UINT16_MAX || errno == ERANGE)
-		return -ERANGE;
-	*arg = (uint16_t)num;
-	return 0;
-}
-
-static void
 txgbe_parse_devargs(struct rte_eth_dev *dev)
 {
 	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
@@ -476,10 +454,10 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	struct rte_devargs *devargs = pci_dev->device.devargs;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct rte_kvargs *kvlist;
-	u16 auto_neg = 1;
-	u16 poll = 0;
-	u16 present = 0;
-	u16 sgmii = 0;
+	bool auto_neg = true;
+	bool poll = false;
+	bool present = false;
+	bool sgmii = false;
 	u16 ffe_set = 0;
 	u16 ffe_main = 27;
 	u16 ffe_pre = 8;
@@ -488,9 +466,10 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 pballoc = 0;
 	u16 drop_queue = 127;
 	/* New devargs for amberlite config */
-	u16 tx_headwb = 1;
+	bool tx_headwb = true;
 	u16 tx_headwb_size = 16;
-	u16 rx_desc_merge = 1;
+	bool rx_desc_merge = true;
+	int ret;
 
 	if (devargs == NULL)
 		goto null;
@@ -499,34 +478,37 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	if (kvlist == NULL)
 		goto null;
 
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_BP_AUTO,
-			   &txgbe_handle_devarg, &auto_neg);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_KR_POLL,
-			   &txgbe_handle_devarg, &poll);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_KR_PRESENT,
-			   &txgbe_handle_devarg, &present);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_KX_SGMII,
-			   &txgbe_handle_devarg, &sgmii);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_SET,
-			   &txgbe_handle_devarg, &ffe_set);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_MAIN,
-			   &txgbe_handle_devarg, &ffe_main);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE,
-			   &txgbe_handle_devarg, &ffe_pre);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_POST,
-			   &txgbe_handle_devarg, &ffe_post);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_PBALLOC,
-			   &txgbe_handle_devarg, &pballoc);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_DROP_QUEUE,
-			   &txgbe_handle_devarg, &drop_queue);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_TX_HEAD_WB,
-			   &txgbe_handle_devarg, &tx_headwb);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_TX_HEAD_WB_SIZE,
-			   &txgbe_handle_devarg, &tx_headwb_size);
-	rte_kvargs_process(kvlist, TXGBE_DEVARG_RX_DESC_MERGE,
-			   &txgbe_handle_devarg, &rx_desc_merge);
+	ret = rte_kvargs_process_opt(kvlist, TXGBE_DEVARG_BP_AUTO,
+				     rte_kvargs_handle_bool, &auto_neg);
+	ret |= rte_kvargs_process_opt(kvlist, TXGBE_DEVARG_KR_POLL,
+				      rte_kvargs_handle_bool, &poll);
+	ret |= rte_kvargs_process_opt(kvlist, TXGBE_DEVARG_KR_PRESENT,
+				      rte_kvargs_handle_bool, &present);
+	ret |= rte_kvargs_process_opt(kvlist, TXGBE_DEVARG_KX_SGMII,
+				      rte_kvargs_handle_bool, &sgmii);
+	ret |= rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_SET,
+				  rte_kvargs_handle_u16, &ffe_set);
+	ret |= rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_MAIN,
+				  rte_kvargs_handle_u16, &ffe_main);
+	ret |= rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_PRE,
+				  rte_kvargs_handle_u16, &ffe_pre);
+	ret |= rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_POST,
+				  rte_kvargs_handle_u16, &ffe_post);
+	ret |= rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_PBALLOC,
+				  rte_kvargs_handle_u16, &pballoc);
+	ret |= rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_DROP_QUEUE,
+				  rte_kvargs_handle_u16, &drop_queue);
+	ret |= rte_kvargs_process_opt(kvlist, TXGBE_DEVARG_TX_HEAD_WB,
+				      rte_kvargs_handle_bool, &tx_headwb);
+	ret |= rte_kvargs_process(kvlist, TXGBE_DEVARG_TX_HEAD_WB_SIZE,
+				  rte_kvargs_handle_u16, &tx_headwb_size);
+	ret |= rte_kvargs_process_opt(kvlist, TXGBE_DEVARG_RX_DESC_MERGE,
+				      rte_kvargs_handle_bool, &rx_desc_merge);
 	rte_kvargs_free(kvlist);
 
+	if (ret != 0)
+		return -EINVAL;
+
 null:
 	hw->devarg.auto_neg = auto_neg;
 	hw->devarg.poll = poll;
@@ -542,6 +524,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 
 	fdir_conf->pballoc = pballoc;
 	fdir_conf->drop_queue = drop_queue;
+
+	return 0;
 }
 
 static void
@@ -642,7 +626,10 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	hw->isb_dma = TMZ_PADDR(mz);
 	hw->isb_mem = TMZ_VADDR(mz);
 
-	txgbe_parse_devargs(eth_dev);
+	err = txgbe_parse_devargs(eth_dev);
+	if (err != 0)
+		return err;
+
 	/* Initialize the shared code (base driver) */
 	err = txgbe_init_shared_code(hw);
 	if (err != 0) {
-- 
2.53.0

