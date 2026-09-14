Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9E8C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:52:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 937C540E3E;
	Mon, 14 Sep 2026 07:51:05 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 4EECB40E36
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:04 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398c066106cso1274507a91.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365063;
 x=1789969863; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ll9EybOeEEndmxTxAdJJca1ShJO3LQrgnh1ABoUxWw=;
 b=KcC0duLSTHwRSx6QI02xBncNvc42xNkJ74rlwogfFIPdMGseE77ac4cpQ/gHOoBeQw
 rigmCDz69Apq3m94CjXbXcz5eG+SzIEzojJ5gIphgAlUgUiuDWth/b1smC2XmhubmSPp
 4yDERQhJAvKHDxUJFwUtWwb7mPiLuY3RrK+li0jiqXysuD2lMdH9AiXKUym6JAdwzh6X
 0XPUZWNgcnxuf5oYp8bLwRLDhObqffjeOF/ho9KZiFeg3M+De+HDgxX0OJxZskgwX1n8
 8s9omAqbV910s9raioxJgP/zBAdAcu7Wvol4YGAxZpQQyhxDpBE/3m6fYLDHBlR4kF0a
 Xm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365063; x=1789969863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ll9EybOeEEndmxTxAdJJca1ShJO3LQrgnh1ABoUxWw=;
 b=i84LPlLsi/J/AgzdTYpTvU8g+1t0MEAyFfE3+b6qdcdOw473uwxIG/qHBz53ls2CHl
 6z/1/s0OXtiv5idk3fwJAM3/Jhu9JIabBu/7m64hA2BlLRjH0lsPWOpkXeIdOX6gOL4E
 G6+RvY9ggHDcIN81FiTBvta/sxUxHa8VeL00P6iGMY6FuVTZGbA8mBN+aoxhVZkesAK3
 /jhgVFArqvIh4zVyNqCW8Knn0gh9Oegt5AGIKZZZRp5AypmIBeh6QKf2psohcyjygs64
 HRccovMbWj1+Vx8z2zLyb5RjDPnSP5/bgnn0QL0lntkx0x8NZuDgo0zmd4B/pZqiPISG
 w/RA==
X-Gm-Message-State: AFuF++nxQMGQtqydTmjuddc+tHR3LJPZXmdip4W90Twv6UrQ7AHjxaYa
 F5vqma+7Fvkt2Ffgvggo0W6ZzyTjL+uQu6xcesvak56eTqAKlleDq5UxEwe4a2zC5U3tqfx/uAF
 c8m48TYk=
X-Gm-Gg: AYBFou1+vAGJTUfyDKPjDESKcfTHCJeAdiWD/7sVG5nkBFtJoKTdZ8SZNVVQOyT8Zvj
 1ewQ//6v1XTrgvsLl/08XdhwQZJ5RjXJnnt2V4U3LJEiNdv8kTx9OaMgAMe2OoEPy6qyRS17uXQ
 YEKo6P4dG6ahZ3rAQ7p9n+mQhlLUv7pP1HA9pwvwy084+BeGFFMZdZn9FFOGC80olvWw4AXWCEd
 es66zoZsf+lkHlOmayr45w9obqkXYLrumPdgGBDgnODsKJ2zkzZHbxmYn1djkfrKUJRxbc5UQs9
 AqQqM+t9hBnQP58h3vppAAEQfmOASQZiJc01hDH5prww5GqnaY3FIV0ePEPZxF3zSKOKGjuKBvq
 IKR9VqkNDPWaV1/5sZAs6oizc3zeH99MhdHi9CzyLv1hjqboMKyEIFXNoiYG8Jn06EJxjfbrW3w
 N5+BT1WLgqTpaQRfL8k2okIFocCFIW9dL7tBVpAtgXnzUjxNZmTIsjEV8+SLlwTBYwrlAyvDhow
 57UgHdFJtkjA+NQjvzcNgcG3GHpHfJ8axUVtKodOurra4On
X-Received: by 2002:a17:90b:3b85:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-39debdd9c94mr2556379a91.0.1789365063409; 
 Sun, 13 Sep 2026 22:51:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 30/62] net/txgbe: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:01 -0700
Message-ID: <20260914054912.755403-31-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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
 drivers/net/txgbe/txgbe_ethdev.c | 91 +++++++++++++++-----------------
 1 file changed, 42 insertions(+), 49 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 814840b3f5..b99e1ad1bc 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -501,22 +501,6 @@ txgbe_swfw_lock_reset(struct txgbe_hw *hw)
 }
 
 static int
-txgbe_handle_devarg(__rte_unused const char *key, const char *value,
-		  void *extra_args)
-{
-	uint16_t *n = extra_args;
-
-	if (value == NULL || extra_args == NULL)
-		return -EINVAL;
-
-	*n = (uint16_t)strtoul(value, NULL, 10);
-	if (*n == USHRT_MAX && errno == ERANGE)
-		return -1;
-
-	return 0;
-}
-
-static void
 txgbe_parse_devargs(struct rte_eth_dev *dev)
 {
 	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
@@ -524,10 +508,10 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
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
@@ -536,9 +520,10 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
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
@@ -547,34 +532,37 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
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
@@ -590,6 +578,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 
 	fdir_conf->pballoc = pballoc;
 	fdir_conf->drop_queue = drop_queue;
+
+	return 0;
 }
 
 static void
@@ -690,7 +680,10 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
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

