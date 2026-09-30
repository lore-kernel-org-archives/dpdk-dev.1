Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5FCCA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:47:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BA5142F55;
	Thu,  1 Oct 2026 00:44:26 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id 7D87D42EE5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:24 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 d9443c01a7336-2e2dd05994cso6092335ad.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808264;
 x=1791413064; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uPzCYj61HtOvh4SLRr0C355bltTgHUkR+bumLratOTg=;
 b=QL3yXvtl9N0gyKYz5ooTMVAMdkwUju8ZdpRhTeVmXSjiwN/tJPdvmF+yjiPhCMKSun
 uAZ2QoNH69ldzdQ3kk+IsygMY0KCGDjAviKbwsSo4eDxhTRV8JV/5YJrHzWfVpFJJkvE
 wO75iJapRFLM8IU9nEuPcXQsl0/CblhC7gfCHOiEVdb/Qr83jBJpPAfg4iuiSL8X0JXB
 QxPfVaeW8Z0lau0oNjqdfmBeIME5qGqxYuoqVCPiF4A7hkC6NI3uKh4Wlh16gt645wbU
 kfynZM4+WKV682N/14S6o93hf04Y8N3W6HCiA8Pb/Xwb1g+Uze01A/ZUYNjU78eB/SJV
 rhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808264; x=1791413064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uPzCYj61HtOvh4SLRr0C355bltTgHUkR+bumLratOTg=;
 b=eMIJgNGWN4q028v/10oqR4hFSZYoGxJ8LZo3FL6jlOtM9/AOJUWAPHiFAfo1idYPcd
 kcpKrCLEKwtZX1/Cbi6iSgdr+02aQJHtI6WlMzysQYU8y+7ZFfyRt5eKTdmDU2RFiATN
 IyQCvdt451XArR7wFzfTYc/KiV5k4Npdt0HjDpYjR/c1HBjeEyOjOG2aQRziiusXeH56
 ctKzwzMHpFeVrt7wQB1wI0z6JZrmOkL5FOxn9AqnFyeEHMX4BFfYxsJs08HWKSOQhQfR
 VUjLLpG5+ZUq+Qx0k/2jx6DmMwqIx+sRGVk/aue46vN99Dp2aNN5Oe8vvj6Oait0j37C
 36zw==
X-Gm-Message-State: AFq9FYLQqUjpNNapVhVnuT2frEChgfErhi6EnWSMkgP4GRKqqn8rBC5H
 VLInG0QrjCBlNWxBdXUs/Opuu4Oyw49maCsj2T77OJadDKmDY8kfNHll9cZ51B/o1wz8+d97JJ2
 GVlDrO10=
X-Gm-Gg: AYBFou3DZROpILZXOjFmsL/F0+Fmc39Id/qSYt5VlMsxwZEdPtZkuqIr4coRY51JXNN
 J5szaraxAa5duGNmLxmjcYsUuuN1Itzr3k7K5HlS6P6th3foG+FoE8H3zI1uDq+Of9eeD/I0Bat
 6GePzo/px98m5He0tRObRHp3SrJYhyZrlJKnOZmGMqlRivOePvEsbvt1loVruDfuW005Ha5pdlR
 MT/DgR+MV1yAjqzTw3mgji9ZAv8A6pjUnagEj6nshfv1mq7nQy8WWkIgZtpERacc5jjlZb45F3Q
 Nd9SZmxjQrieTkhnr/vA33l8XlS+kAUQdj+x7SGcR1hII7YXVmJHGlAZGR8dUr7QI7vaiSjyGgP
 zFz8JN3Omi2SK9csk/tHNeUbSfp6cCYf3jngi55Z1IuEDCBNgB3N1tU4ay2d5pPBwQ7OJ5I4wiv
 b0S2YBxqmsjV++jEFB+Imlsepv8OlfkZzWOo9zKPhl9a42aXaIwUE7gzgAalsVw8SdyjNthxKh8
 IR7FXvMXstu9JW0365Huylu+gL1bhdK8Sn6TA==
X-Received: by 2002:a17:903:1a03:b0:2dd:c0ff:e72c with SMTP id
 d9443c01a7336-2e2e4bbfdebmr20757925ad.62.1790808263568; 
 Wed, 30 Sep 2026 15:44:23 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v3 37/65] net/cnxk: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:55 -0700
Message-ID: <20260930224340.58580-38-stephen@networkplumber.org>
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

