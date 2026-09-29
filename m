Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAFBCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B5EB42E8E;
	Tue, 29 Sep 2026 18:39:27 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 015144026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:35 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-8693af0d7c4so2602202b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699914;
 x=1791304714; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gNQO6qDNFOCyEMEY4D/q9dN8aF1GdjMLfZXfGnOK/UU=;
 b=u04Yb/8u0jD1UDe++Y7r8f7GJBrThKXhbBMd0aEqUPrfoUeC1tzTJZ+oGdTQogcKoh
 ayK02OY7Bk8CF3AnqOVMbtRlPYzUJHR05OnGfXgWE7VQA8c8UJolSEQPTDEH376ZYQvj
 R1Sc7ogh+qfdTKJ0JiHZNzC3b4MpJk9bt1CFlG5Ss5TERUmsmw5pb/icIEKJjED0CM5r
 V1GvmvKX/8FOMaAIUPom6UL+TH60uejLxzGjrxOMTeOYzWuKz4hr5vCimnqiKSkCCg5p
 rQle/b4SfOa9u5B3o4s/YTjdzR1xNcnJJFjrcNgFbujzyoHYONElXgWmO7ZJ2AQ/giuJ
 za5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699914; x=1791304714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gNQO6qDNFOCyEMEY4D/q9dN8aF1GdjMLfZXfGnOK/UU=;
 b=xfREHV+80R70CkpAiueHpD5aODiXxfZaeteaoAqJJj7EjmegmgYZ8k8byGtxnWhiSf
 nUa0xzzF3IXLmy+ogxXINve0uQt176wOQbOZ0kDVJR+uZUDzSkWMCZT5nNz5ioionsbE
 yLNoaqECKMVNQLGAsvE2BAGX/dGHCkSVNxXPGtWS/DU3qwBRbUKR12+gjJBZC5Jf/av0
 dQEoiNItqmtQ04iavdVXRe0Y0gTMq38hM7QvzOLQ287QJV9DVDNVga35ymLntv0ng7i2
 fZikwP2VyUa87ETU2S/WztyygydaVp+GjXLXm+X72f4hj3iXL5DfqgR3jqYZA/SxZ5vg
 jj/w==
X-Gm-Message-State: AFuF++miRw3cVJux7wdFg3Lj00xyykvTq+Bf9YMHqx+YNEGd2i5eHZUW
 w1M0Mh5DGExp3S/qx+XLfNrNN/Iny/F263fNCLAnPWUJvHYih8TSBNa9wlIzr0K6tno891qoarC
 W1BwizaM=
X-Gm-Gg: AYBFou1tQKE/m/6v3qyDVkrfFRptBDH969rjlsJUm23bcnb4Qd+ElsFurQ3JcYzxWH1
 mRwPbfxmfRE06ylIjiJVz+q8JUKR/kdhyiyn9r2lbHdfiHw4xaxpXxR6esBveb8G5nTzSI10swW
 Qnde18I8juCuXvBO5fcyvDT4Y6fOSYZoo1udglshoBqWPIHQciz/eJ1M0E546McfN+sM9YXrnSZ
 aHOIgoKCK5S8nDStEu9nYAnq2p9RTCTRSym+3qI1YSzjMFOlyz2CfaYexQ0Dmwfx2rV9BRFE91B
 pBQaUWNtqsYqpksRaF8m5VR/ofLXOWYtmgzWz8V0KBUioHLy/KExxpxrlvwNwXWvXIBN+TJvVJq
 aR8VqQC6dBGOZcBALWnmTjILIXGORjHPevUNkSnIUmaOzaCHSF7f+OS0Y3lW5CgQk/A+cIBKM4g
 PKC2Oi92HrUp68piGlF6GABHMQNpHk00kcMeVN2QjzcCNmoIkXHCOCMqfSgMf4lJd/EAsqVwU8N
 WmoZTsChzUqXHadcWApIuQi+lI9B2nvIbsUdA==
X-Received: by 2002:a05:6a00:ad8d:b0:874:705d:f64f with SMTP id
 d2e1a72fcca58-87e9b3b66c2mr12486789b3a.29.1790699914058; 
 Tue, 29 Sep 2026 09:38:34 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v2 29/61] net/txgbe: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:32 -0700
Message-ID: <20260929163800.1108305-30-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

