Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6155BCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 287BF42F05;
	Tue, 29 Sep 2026 18:39:34 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 24DCB42EA0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:41 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc78d45f78fso2702912a12.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699920;
 x=1791304720; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uPzCYj61HtOvh4SLRr0C355bltTgHUkR+bumLratOTg=;
 b=i06GUnWdHN9SV0Ffs9gdmTM+xhg4rhO8pLJI9Yhea72O1feJ/uDR0VBoaUu90cDUtk
 BhbMZ7RngSeVfbNjwPoHQVeVwaaCnhLxYDdRX/r4LMxajms06Lay3SpwG5R7NFMcc5qU
 6Z33gEYnbETce4lDgyrQUL3EuQL75oFTlzx0PKjTizg8WKOMZN3P5xw71TsoR+AtUvf1
 /32GzzaAhvrcsYvrjuU+V6AL8Kf6yzqp9HmZKzFkxNtsSkGlHr6lhWKl+6n46APagfJN
 j1dEWDmRtzSGQ/2IhHYoLuo/Mvl8TmAs1HujJLKBpXUqRvlnH1e99zulbHlpKE7N/WSd
 K/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699920; x=1791304720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uPzCYj61HtOvh4SLRr0C355bltTgHUkR+bumLratOTg=;
 b=IJpZJ2laIFws5IZnYP/iL5oYiTRSshXnJIegF0UyE7yTDi/M32bS/Dto9Rv5UOa61g
 8Z8fpIvqlWw5sdb3Rx36hM/lXjmsP7ywsLnioB6WC7Ue5j15jA9zoBt5I/HGk8MeTIoX
 k3Z51GOum7iurCd5ShNZCkPiOe4HmIq1u8RDHP3vdzii6TsezobncvKhWIZpCY1RUNMX
 ZO7CBPwLDzrl8s5XpoUodHlYkdLZs5qL4d7WvmbpsHSy518rz3e3jOxwToakW2WXWCD/
 TbflFdG6oi9Xy63+AfzRvq269byB7IwtDoAe4dZ1a2jPrZkzCI6knlLQPjoi2XeQnCSD
 N3TA==
X-Gm-Message-State: AFuF++kOfzzfgUVrYj0+tP0k8FEkJqZz1U/BWY7k44RIxj0Xz1wngZmR
 GQPWa0nQZ0Vn/Wl5vhuf/ayS/9PQ7PvNv9940Hw4+jm8un3SljJYAI1/d8Glvo1SPSHecgZpM2j
 MTVVXaq0=
X-Gm-Gg: AYBFou3H1S9t/7oO8vu+KN0bG0+HMfMF5/3Kb+wkaUlFTGfumAHtllmTEZndCpd6Inr
 QokPRECwUO3bsq1QQ9PkqPHo+Pp7VC7YbWz9VSLi4vKtSp3/1RX0gMhRAJqoTiaeVrprq/LtawP
 Tsa/13ESdapaCkNRZRPgPG1rTXP929NYEVjrG5XAy0Lo3u7ZHrL+MtVm9IUrpaDNPoicZMOoDzH
 xcemft6PM8g1GrcqLobMCYB2XdIj9/Km+fs7k3d5vOLPBqrSwpL2pXYVq/UJ/e5rPsuE4LUbuTB
 fDSumBVq3XtpTe/03Yh/TcsjWsgXwkx2tHxI+byaNGh2bPiGjeJR9ICr4u3uQhcgkqAzGb/gZ7l
 UicNwT4FrQGNkNzNQPkFAMRJbkd8/JY2LstpoKTODzlMeHQeXRoW4E8c85+KUbUmLldtJgx7yKL
 Tj6u3weli0dOWvINUcwpYVbn7N1fEyLoc3wkrciCxArwYV62zH22ZtxT9tj7qsbPuJW+p3PitRy
 usmcQ8joyg0mwqpwGLs79jIVZmicVvuCEBm1w==
X-Received: by 2002:a05:6a21:3943:b0:3dd:a197:ede6 with SMTP id
 adf61e73a8af0-3de0e8e1346mr14653188637.53.1790699920302; 
 Tue, 29 Sep 2026 09:38:40 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 36/61] net/cnxk: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:39 -0700
Message-ID: <20260929163800.1108305-37-stephen@networkplumber.org>
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

Most handlers in this file used atoi(), which cannot report an error, so
a malformed value was silently taken as zero. Several of them also
assigned a uint32_t into a uint16_t without a range check, so a value
such as "65536" wrapped to zero.

parse_ipsec_in_spi_range(), parse_ipsec_out_max_sa() and
parse_meta_bufsize() went further and deliberately swallowed the error,
setting the value to zero and returning success.

Seven of the handlers were left doing nothing beyond a plain range
checked store, so drop them and pass rte_kvargs_handle_u16() or
rte_kvargs_handle_u32() to rte_kvargs_process() directly. The rest keep
a local handler because they have a narrower range or non-numeric
syntax.

Since the handlers can now fail, propagate the rte_kvargs_process()
return value instead of discarding it, so that a bad argument fails
probe rather than being ignored.

The pre_l2 header and SDP channel mask parsers are left alone: each
packs several fields into one value separated by punctuation, as in
flow_pre_l2_info=0x2/0x7e/0x1, which no single arg_handler_t can parse.

The eleven boolean arguments become bool and use
rte_kvargs_handle_bool(): scalar_enable, tx_compl_ena, tag_as_xor,
lock_rx_ctx, no_inl_dev, custom_sa_act, rx_inj_ena,
custom_meta_aura_dis, custom_inb_sa, force_tail_drop and
disable_xqe_drop. Most of the fields behind them are already bool, so
the "!!" coercions on the way in are no longer needed. A bare key now
enables the option, and the usual spellings are accepted.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_ethdev_devargs.c | 283 +++++++++----------------
 1 file changed, 97 insertions(+), 186 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_devargs.c b/drivers/net/cnxk/cnxk_ethdev_devargs.c
index ea18090919..887349fe24 100644
--- a/drivers/net/cnxk/cnxk_ethdev_devargs.c
+++ b/drivers/net/cnxk/cnxk_ethdev_devargs.c
@@ -5,6 +5,8 @@
 #include <inttypes.h>
 #include <math.h>
 
+#include <rte_kvargs.h>
+
 #include "cnxk_ethdev.h"
 
 struct sdp_channel {
@@ -19,28 +21,14 @@ struct flow_pre_l2_size_info {
 	uint8_t pre_l2_size_shift_dir;
 };
 
-static int
-parse_outb_nb_desc(const char *key, const char *value, void *extra_args)
-{
-	RTE_SET_USED(key);
-	uint32_t val;
-
-	val = atoi(value);
-
-	*(uint16_t *)extra_args = val;
-
-	return 0;
-}
-
 static int
 parse_outb_nb_crypto_qs(const char *key, const char *value, void *extra_args)
 {
-	RTE_SET_USED(key);
-	uint32_t val;
+	uint64_t val;
 
-	val = atoi(value);
+	RTE_SET_USED(key);
 
-	if (val < 1 || val > 64)
+	if (rte_kvargs_to_uint(value, 1, 64, &val) < 0)
 		return -EINVAL;
 
 	*(uint16_t *)extra_args = val;
@@ -48,51 +36,15 @@ parse_outb_nb_crypto_qs(const char *key, const char *value, void *extra_args)
 	return 0;
 }
 
-static int
-parse_ipsec_in_spi_range(const char *key, const char *value, void *extra_args)
-{
-	RTE_SET_USED(key);
-	uint32_t val;
-
-	errno = 0;
-	val = strtoul(value, NULL, 0);
-	if (errno)
-		val = 0;
-
-	*(uint32_t *)extra_args = val;
-
-	return 0;
-}
-
 static int
 parse_rxc_step(const char *key, const char *value, void *extra_args)
 {
-	RTE_SET_USED(key);
-	uint32_t val;
+	uint64_t val;
 
-	errno = 0;
-	val = strtoul(value, NULL, 0);
-	if (errno)
-		return -EINVAL;
-
-	if (val > ROC_NIX_INL_REAS_STEP_MAX)
-		return -EINVAL;
-
-	*(uint32_t *)extra_args = val;
-
-	return 0;
-}
-
-static int
-parse_ipsec_out_max_sa(const char *key, const char *value, void *extra_args)
-{
 	RTE_SET_USED(key);
-	uint32_t val;
 
-	errno = 0;
-	val = strtoul(value, NULL, 0);
-	if (errno)
-		val = 0;
+	if (rte_kvargs_to_uint(value, 0, ROC_NIX_INL_REAS_STEP_MAX, &val) < 0)
+		return -EINVAL;
 
 	*(uint32_t *)extra_args = val;
 
@@ -102,12 +54,11 @@ parse_ipsec_out_max_sa(const char *key, const char *value, void *extra_args)
 static int
 parse_flow_max_priority(const char *key, const char *value, void *extra_args)
 {
-	RTE_SET_USED(key);
-	uint16_t val;
+	uint64_t val;
 
-	val = atoi(value);
+	RTE_SET_USED(key);
 
-	if (val < 1 || val > ROC_NPC_MAX_MCAM_PRIORITY)
+	if (rte_kvargs_to_uint(value, 1, ROC_NPC_MAX_MCAM_PRIORITY, &val) < 0)
 		return -EINVAL;
 
 	*(uint16_t *)extra_args = val;
@@ -118,13 +69,12 @@ parse_flow_max_priority(const char *key, const char *value, void *extra_args)
 static int
 parse_flow_prealloc_size(const char *key, const char *value, void *extra_args)
 {
-	RTE_SET_USED(key);
-	uint16_t val;
+	uint64_t val;
 
-	val = atoi(value);
+	RTE_SET_USED(key);
 
 	/* Limit the prealloc size to 32 */
-	if (val < 1 || val > 32)
+	if (rte_kvargs_to_uint(value, 1, 32, &val) < 0)
 		return -EINVAL;
 
 	*(uint16_t *)extra_args = val;
@@ -135,10 +85,12 @@ parse_flow_prealloc_size(const char *key, const char *value, void *extra_args)
 static int
 parse_reta_size(const char *key, const char *value, void *extra_args)
 {
+	uint64_t val;
+
 	RTE_SET_USED(key);
-	uint32_t val;
 
-	val = atoi(value);
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &val) < 0)
+		return -EINVAL;
 
 	if (val <= RTE_ETH_RSS_RETA_SIZE_64)
 		val = ROC_NIX_RSS_RETA_SZ_64;
@@ -177,45 +129,6 @@ parse_pre_l2_hdr_info(const char *key, const char *value, void *extra_args)
 	return 0;
 }
 
-static int
-parse_flag(const char *key, const char *value, void *extra_args)
-{
-	RTE_SET_USED(key);
-
-	*(uint16_t *)extra_args = atoi(value);
-
-	return 0;
-}
-
-static int
-parse_sqb_count(const char *key, const char *value, void *extra_args)
-{
-	RTE_SET_USED(key);
-	uint32_t val;
-
-	val = atoi(value);
-
-	*(uint16_t *)extra_args = val;
-
-	return 0;
-}
-
-static int
-parse_meta_bufsize(const char *key, const char *value, void *extra_args)
-{
-	RTE_SET_USED(key);
-	uint32_t val;
-
-	errno = 0;
-	val = strtoul(value, NULL, 0);
-	if (errno)
-		val = 0;
-
-	*(uint32_t *)extra_args = val;
-
-	return 0;
-}
-
 static int
 parse_switch_header_type(const char *key, const char *value, void *extra_args)
 {
@@ -248,12 +161,11 @@ parse_switch_header_type(const char *key, const char *value, void *extra_args)
 static int
 parse_skip_size_info(const char *key, const char *value, void *extra_args)
 {
+	uint64_t val;
+
 	RTE_SET_USED(key);
-	uint32_t val;
 
-	errno = 0;
-	val = strtoul(value, NULL, 0);
-	if (errno || val > 255)
+	if (rte_kvargs_to_uint(value, 0, 255, &val) < 0)
 		return -EINVAL;
 
 	*(uint16_t *)extra_args = val;
@@ -282,19 +194,6 @@ parse_sdp_channel_mask(const char *key, const char *value, void *extra_args)
 	return 0;
 }
 
-static int
-parse_val_u16(const char *key, const char *value, void *extra_args)
-{
-	RTE_SET_USED(key);
-	uint16_t val;
-
-	val = atoi(value);
-
-	*(uint16_t *)extra_args = val;
-
-	return 0;
-}
-
 #define CNXK_RSS_RETA_SIZE	"reta_size"
 #define CNXK_SCL_ENABLE		"scalar_enable"
 #define CNXK_TX_COMPL_ENA       "tx_compl_ena"
@@ -334,7 +233,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	uint32_t ipsec_in_max_spi = BIT(8) - 1;
 	uint16_t sqb_slack = ROC_NIX_SQB_SLACK;
 	uint32_t ipsec_out_max_sa = BIT(12);
-	uint16_t custom_meta_aura_dis = 0;
+	bool custom_meta_aura_dis = false;
 	uint16_t flow_prealloc_size = 1;
 	uint16_t switch_header_type = 0;
 	uint16_t skip_size_info = 0;
@@ -343,19 +242,20 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	uint32_t ipsec_in_min_spi = 0;
 	uint16_t outb_nb_desc = 8200;
 	struct sdp_channel sdp_chan;
-	uint16_t rss_tag_as_xor = 0;
-	uint16_t force_tail_drop = 0;
-	uint16_t scalar_enable = 0;
-	uint16_t tx_compl_ena = 0;
-	uint16_t custom_sa_act = 0;
-	uint16_t custom_inb_sa = 0;
+	bool rss_tag_as_xor = false;
+	bool force_tail_drop = false;
+	bool scalar_enable = false;
+	bool tx_compl_ena = false;
+	bool custom_sa_act = false;
+	bool custom_inb_sa = false;
 	struct rte_kvargs *kvlist;
-	uint16_t dis_xqe_drop = 0;
+	bool dis_xqe_drop = false;
 	uint32_t meta_buf_sz = 0;
-	uint16_t lock_rx_ctx = 0;
-	uint16_t rx_inj_ena = 0;
-	uint16_t no_inl_dev = 0;
+	bool lock_rx_ctx = false;
+	bool rx_inj_ena = false;
+	bool no_inl_dev = false;
 	uint32_t rxc_step = 0;
+	int ret;
 
 	memset(&sdp_chan, 0, sizeof(sdp_chan));
 	memset(&pre_l2_info, 0, sizeof(struct flow_pre_l2_size_info));
@@ -367,60 +267,71 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	if (kvlist == NULL)
 		goto exit;
 
-	rte_kvargs_process(kvlist, CNXK_RSS_RETA_SIZE, &parse_reta_size,
-			   &reta_sz);
-	rte_kvargs_process(kvlist, CNXK_SCL_ENABLE, &parse_flag,
-			   &scalar_enable);
-	rte_kvargs_process(kvlist, CNXK_TX_COMPL_ENA, &parse_flag,
-			   &tx_compl_ena);
-	rte_kvargs_process(kvlist, CNXK_MAX_SQB_COUNT, &parse_sqb_count,
-			   &sqb_count);
-	rte_kvargs_process(kvlist, CNXK_FLOW_PREALLOC_SIZE,
-			   &parse_flow_prealloc_size, &flow_prealloc_size);
-	rte_kvargs_process(kvlist, CNXK_FLOW_MAX_PRIORITY,
-			   &parse_flow_max_priority, &flow_max_priority);
-	rte_kvargs_process(kvlist, CNXK_SWITCH_HEADER_TYPE,
-			   &parse_switch_header_type, &switch_header_type);
-	rte_kvargs_process(kvlist, CNXK_RSS_TAG_AS_XOR, &parse_flag,
-			   &rss_tag_as_xor);
-	rte_kvargs_process(kvlist, CNXK_LOCK_RX_CTX, &parse_flag, &lock_rx_ctx);
-	rte_kvargs_process(kvlist, CNXK_IPSEC_IN_MIN_SPI,
-			   &parse_ipsec_in_spi_range, &ipsec_in_min_spi);
-	rte_kvargs_process(kvlist, CNXK_IPSEC_IN_MAX_SPI,
-			   &parse_ipsec_in_spi_range, &ipsec_in_max_spi);
-	rte_kvargs_process(kvlist, CNXK_IPSEC_OUT_MAX_SA,
-			   &parse_ipsec_out_max_sa, &ipsec_out_max_sa);
-	rte_kvargs_process(kvlist, CNXK_OUTB_NB_DESC, &parse_outb_nb_desc,
-			   &outb_nb_desc);
-	rte_kvargs_process(kvlist, CNXK_OUTB_NB_CRYPTO_QS,
-			   &parse_outb_nb_crypto_qs, &outb_nb_crypto_qs);
-	rte_kvargs_process(kvlist, CNXK_NO_INL_DEV, &parse_flag, &no_inl_dev);
-	rte_kvargs_process(kvlist, CNXK_SDP_CHANNEL_MASK,
-			   &parse_sdp_channel_mask, &sdp_chan);
-	rte_kvargs_process(kvlist, CNXK_FLOW_PRE_L2_INFO,
-			   &parse_pre_l2_hdr_info, &pre_l2_info);
-	rte_kvargs_process(kvlist, CNXK_CUSTOM_SA_ACT, &parse_flag,
-			   &custom_sa_act);
-	rte_kvargs_process(kvlist, CNXK_SQB_SLACK, &parse_sqb_count,
-			   &sqb_slack);
-	rte_kvargs_process(kvlist, CNXK_NIX_META_BUF_SZ, &parse_meta_bufsize, &meta_buf_sz);
-	rte_kvargs_process(kvlist, CNXK_FLOW_AGING_POLL_FREQ, &parse_val_u16,
-			   &aging_thread_poll_freq);
-	rte_kvargs_process(kvlist, CNXK_NIX_RX_INJ_ENABLE, &parse_flag, &rx_inj_ena);
-	rte_kvargs_process(kvlist, CNXK_CUSTOM_META_AURA_DIS, &parse_flag,
-			   &custom_meta_aura_dis);
-	rte_kvargs_process(kvlist, CNXK_CUSTOM_INB_SA, &parse_flag, &custom_inb_sa);
-	rte_kvargs_process(kvlist, CNXK_FORCE_TAIL_DROP, &parse_flag, &force_tail_drop);
-	rte_kvargs_process(kvlist, CNXK_DIS_XQE_DROP, &parse_flag, &dis_xqe_drop);
-	rte_kvargs_process(kvlist, CNXK_RXC_STEP, &parse_rxc_step, &rxc_step);
-	rte_kvargs_process(kvlist, CNXK_SKIP_SIZE_INFO, &parse_skip_size_info,
-			   &skip_size_info);
+	ret = 0;
+	ret |= rte_kvargs_process(kvlist, CNXK_RSS_RETA_SIZE, &parse_reta_size,
+				  &reta_sz);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_SCL_ENABLE, rte_kvargs_handle_bool,
+				  &scalar_enable);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_TX_COMPL_ENA, rte_kvargs_handle_bool,
+				  &tx_compl_ena);
+	ret |= rte_kvargs_process(kvlist, CNXK_MAX_SQB_COUNT, rte_kvargs_handle_u16,
+				  &sqb_count);
+	ret |= rte_kvargs_process(kvlist, CNXK_FLOW_PREALLOC_SIZE,
+				  &parse_flow_prealloc_size, &flow_prealloc_size);
+	ret |= rte_kvargs_process(kvlist, CNXK_FLOW_MAX_PRIORITY,
+				  &parse_flow_max_priority, &flow_max_priority);
+	ret |= rte_kvargs_process(kvlist, CNXK_SWITCH_HEADER_TYPE,
+				  &parse_switch_header_type, &switch_header_type);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_RSS_TAG_AS_XOR, rte_kvargs_handle_bool,
+				  &rss_tag_as_xor);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_LOCK_RX_CTX, rte_kvargs_handle_bool,
+				  &lock_rx_ctx);
+	ret |= rte_kvargs_process(kvlist, CNXK_IPSEC_IN_MIN_SPI,
+				  rte_kvargs_handle_u32, &ipsec_in_min_spi);
+	ret |= rte_kvargs_process(kvlist, CNXK_IPSEC_IN_MAX_SPI,
+				  rte_kvargs_handle_u32, &ipsec_in_max_spi);
+	ret |= rte_kvargs_process(kvlist, CNXK_IPSEC_OUT_MAX_SA,
+				  rte_kvargs_handle_u32, &ipsec_out_max_sa);
+	ret |= rte_kvargs_process(kvlist, CNXK_OUTB_NB_DESC, rte_kvargs_handle_u16,
+				  &outb_nb_desc);
+	ret |= rte_kvargs_process(kvlist, CNXK_OUTB_NB_CRYPTO_QS,
+				  &parse_outb_nb_crypto_qs, &outb_nb_crypto_qs);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_NO_INL_DEV, rte_kvargs_handle_bool,
+				  &no_inl_dev);
+	ret |= rte_kvargs_process(kvlist, CNXK_SDP_CHANNEL_MASK,
+				  &parse_sdp_channel_mask, &sdp_chan);
+	ret |= rte_kvargs_process(kvlist, CNXK_FLOW_PRE_L2_INFO,
+				  &parse_pre_l2_hdr_info, &pre_l2_info);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_CUSTOM_SA_ACT, rte_kvargs_handle_bool,
+				  &custom_sa_act);
+	ret |= rte_kvargs_process(kvlist, CNXK_SQB_SLACK, rte_kvargs_handle_u16,
+				  &sqb_slack);
+	ret |= rte_kvargs_process(kvlist, CNXK_NIX_META_BUF_SZ, rte_kvargs_handle_u32,
+				  &meta_buf_sz);
+	ret |= rte_kvargs_process(kvlist, CNXK_FLOW_AGING_POLL_FREQ, rte_kvargs_handle_u16,
+				  &aging_thread_poll_freq);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_NIX_RX_INJ_ENABLE, rte_kvargs_handle_bool,
+				  &rx_inj_ena);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_CUSTOM_META_AURA_DIS, rte_kvargs_handle_bool,
+				  &custom_meta_aura_dis);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_CUSTOM_INB_SA, rte_kvargs_handle_bool,
+				  &custom_inb_sa);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_FORCE_TAIL_DROP, rte_kvargs_handle_bool,
+				  &force_tail_drop);
+	ret |= rte_kvargs_process_opt(kvlist, CNXK_DIS_XQE_DROP, rte_kvargs_handle_bool,
+				  &dis_xqe_drop);
+	ret |= rte_kvargs_process(kvlist, CNXK_RXC_STEP, &parse_rxc_step, &rxc_step);
+	ret |= rte_kvargs_process(kvlist, CNXK_SKIP_SIZE_INFO, &parse_skip_size_info,
+				  &skip_size_info);
 	rte_kvargs_free(kvlist);
 
+	if (ret != 0)
+		goto exit;
+
 null_devargs:
-	dev->scalar_ena = !!scalar_enable;
-	dev->tx_compl_ena = !!tx_compl_ena;
-	dev->inb.no_inl_dev = !!no_inl_dev;
+	dev->scalar_ena = scalar_enable;
+	dev->tx_compl_ena = tx_compl_ena;
+	dev->inb.no_inl_dev = no_inl_dev;
 	dev->inb.min_spi = ipsec_in_min_spi;
 	dev->inb.max_spi = ipsec_in_max_spi;
 	dev->inb.custom_meta_aura_dis = custom_meta_aura_dis;
@@ -428,7 +339,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	dev->outb.nb_desc = outb_nb_desc;
 	dev->outb.nb_crypto_qs = outb_nb_crypto_qs;
 	dev->nix.ipsec_out_max_sa = ipsec_out_max_sa;
-	dev->nix.rss_tag_as_xor = !!rss_tag_as_xor;
+	dev->nix.rss_tag_as_xor = rss_tag_as_xor;
 	dev->nix.max_sqb_count = sqb_count;
 	dev->nix.reta_sz = reta_sz;
 	dev->nix.lock_rx_ctx = lock_rx_ctx;
@@ -458,7 +369,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	if (roc_feature_nix_has_rx_inject())
 		dev->nix.rx_inj_ena = rx_inj_ena;
 	dev->nix.force_tail_drop = force_tail_drop;
-	dev->nix.dis_xqe_drop = !!dis_xqe_drop;
+	dev->nix.dis_xqe_drop = dis_xqe_drop;
 	dev->nix.rxc_step = rxc_step;
 	return 0;
 exit:
-- 
2.53.0

