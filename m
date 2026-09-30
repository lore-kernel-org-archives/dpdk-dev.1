Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6175CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7D6B432B0;
	Thu,  1 Oct 2026 00:44:55 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id D4EF04327A
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:50 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso3028053a91.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808290;
 x=1791413090; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=muwbnt9yHJ8n5DKp3Zy9IbtMYQj5misNiZv+wDRArA0=;
 b=KXeFU9XzyTXwp1w5Bb3Ty7syBH4FFpMb8IkOswrkHOyuuOV8YvSXA+3zCO9QLYIcft
 3jfR9iSPMKFq2dDisEhMJ3BsoOoynNQeFES83VG35KWFNaxTDZgQSO/6HWfk2N9+JP2y
 dlf9DUm+67Khfo17pW6gHVJpHTU66wOSZTad7ppGL1coGZYiHhVy/Z6zj4eey1VfrF50
 trvlXs0SiTq5ySx/E0V4ba5ula6dsQGilYCDIREHrUS6q+ORoy7jqaHmwkP83dq8Fys7
 Rc3Rt2Ty3MhPajIW5rZrE6KrOmuyhAl6gXA92K2k6KCYGeu/0jZy1nWEN1ZsCIrX0+bR
 6/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808290; x=1791413090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=muwbnt9yHJ8n5DKp3Zy9IbtMYQj5misNiZv+wDRArA0=;
 b=Jkuyw7bkLMzIRErXIxbiAkIaLUEk+ldxf1nZnI3Lu3wfDlCPeyU0X5veQjqwydOYx/
 Awp3wgLQeS7eZIDO3/4y8auBLgpRm2orWOZb/JpLwNfStn+PvAJQGbIpZX9crvUj9T8b
 /yTk5hP3SWhH40ACwMbAjr+V3wnXaoBpq9uI8IAxewaQEJY6OFnyLeD5mhSriGombFUc
 mx9Ewazx72WeXS8+n0DvCR0GdsuXXVZ1oaRoGFBpf4AtcT/Rxhmsi/IgUwtYMn28+K00
 UUZuSyXmnnXW4WPOMdujlMIMrfyPBwR+kRyUrofUK8d3/Ulf0k2eDVZCtH4xP7SgX1OC
 n/WQ==
X-Gm-Message-State: AFq9FYKEJmup9TvsI0z+bkHK7MJo4JjeeEGwW5L4qx/SIYl7QNkwRSTC
 ZBbBGa9GJcdKCx5O8pc7UfRBKyzAAOjji4bUhU77Om/BkUcqh4wa13tzeYDIBwpzMPCehMY/6q8
 jMtwKqHU=
X-Gm-Gg: AYBFou0iawUmuijfu7j2qI/kII5e5dZYgGMLuw19QOYpcvtD8pw7qg8f2a5QFvJ/mJJ
 70RHOv4M1eC+nL1IkMIs0LLCS8n5z+eiKR1OxBw4GmnLC7KTRXD1muUXHgBvO3/k1hwi/NFBmN8
 6RmT0uNaDIDTVxiz6CYUW7CIBfp09Gtls7w5EjzUZjHx55w4YIADkMZZGAcQWNF12MC8ksGkCsh
 RZQQUxSC+Xmg1TbnRP3YjV6S/hL26cAQw5C+KNz6N9brqE+w/KYcwARdAJxM1gTuG2gLOIkgnQC
 HdoWkhk3/ChlT6Ow5g8Hcvnu4eJBeIUG/ZMWWczruUwnuCDPO+cb7uUrLeaZk6s/3pNqmGFbytp
 IBfKc2iPwgjuwvcrTd+4JKk/6JikxvksjE4m4ZRrf+/rApaDbbFwPqHG2M216zHWrIhUA/ed+cD
 V1nx8YZ+98+20OOK0sYIXBWARETl/ugXx1nHo1kb21kaPdsLpwveeWAkYY/6SRQ2Hqt1/LchybZ
 Kn6VKS1bRzD9gK1pD31ffbyeNHTnfUEXcZnqm/2/7R+Cei7
X-Received: by 2002:a17:90b:3c4b:b0:39e:6a7e:ee1a with SMTP id
 98e67ed59e1d1-3a4d1b1b27amr2244953a91.38.1790808289556; 
 Wed, 30 Sep 2026 15:44:49 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v3 64/65] net/cnxk: use kvargs range handlers
Date: Wed, 30 Sep 2026 15:41:22 -0700
Message-ID: <20260930224340.58580-65-stephen@networkplumber.org>
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

Five of the six handlers here applied a range and stored the result,
and returned -EINVAL without logging, so a value out of range was
rejected with nothing to say what the range was.

Use rte_kvargs_handle_urange() for those five. parse_reta_size() keeps
its handler since it rounds the value up to a supported table size
rather than rejecting it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_ethdev_devargs.c | 112 +++++--------------------
 1 file changed, 21 insertions(+), 91 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_devargs.c b/drivers/net/cnxk/cnxk_ethdev_devargs.c
index 887349fe24..18472d54b8 100644
--- a/drivers/net/cnxk/cnxk_ethdev_devargs.c
+++ b/drivers/net/cnxk/cnxk_ethdev_devargs.c
@@ -21,67 +21,6 @@ struct flow_pre_l2_size_info {
 	uint8_t pre_l2_size_shift_dir;
 };
 
-static int
-parse_outb_nb_crypto_qs(const char *key, const char *value, void *extra_args)
-{
-	uint64_t val;
-
-	RTE_SET_USED(key);
-
-	if (rte_kvargs_to_uint(value, 1, 64, &val) < 0)
-		return -EINVAL;
-
-	*(uint16_t *)extra_args = val;
-
-	return 0;
-}
-
-static int
-parse_rxc_step(const char *key, const char *value, void *extra_args)
-{
-	uint64_t val;
-
-	RTE_SET_USED(key);
-
-	if (rte_kvargs_to_uint(value, 0, ROC_NIX_INL_REAS_STEP_MAX, &val) < 0)
-		return -EINVAL;
-
-	*(uint32_t *)extra_args = val;
-
-	return 0;
-}
-
-static int
-parse_flow_max_priority(const char *key, const char *value, void *extra_args)
-{
-	uint64_t val;
-
-	RTE_SET_USED(key);
-
-	if (rte_kvargs_to_uint(value, 1, ROC_NPC_MAX_MCAM_PRIORITY, &val) < 0)
-		return -EINVAL;
-
-	*(uint16_t *)extra_args = val;
-
-	return 0;
-}
-
-static int
-parse_flow_prealloc_size(const char *key, const char *value, void *extra_args)
-{
-	uint64_t val;
-
-	RTE_SET_USED(key);
-
-	/* Limit the prealloc size to 32 */
-	if (rte_kvargs_to_uint(value, 1, 32, &val) < 0)
-		return -EINVAL;
-
-	*(uint16_t *)extra_args = val;
-
-	return 0;
-}
-
 static int
 parse_reta_size(const char *key, const char *value, void *extra_args)
 {
@@ -158,21 +97,6 @@ parse_switch_header_type(const char *key, const char *value, void *extra_args)
 	return 0;
 }
 
-static int
-parse_skip_size_info(const char *key, const char *value, void *extra_args)
-{
-	uint64_t val;
-
-	RTE_SET_USED(key);
-
-	if (rte_kvargs_to_uint(value, 0, 255, &val) < 0)
-		return -EINVAL;
-
-	*(uint16_t *)extra_args = val;
-
-	return 0;
-}
-
 static int
 parse_sdp_channel_mask(const char *key, const char *value, void *extra_args)
 {
@@ -234,11 +158,15 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	uint16_t sqb_slack = ROC_NIX_SQB_SLACK;
 	uint32_t ipsec_out_max_sa = BIT(12);
 	bool custom_meta_aura_dis = false;
-	uint16_t flow_prealloc_size = 1;
+	struct rte_kvargs_urange flow_prealloc_size = {
+		.min = 1, .max = 32, .val = 1 };
 	uint16_t switch_header_type = 0;
-	uint16_t skip_size_info = 0;
-	uint16_t flow_max_priority = 3;
-	uint16_t outb_nb_crypto_qs = 1;
+	struct rte_kvargs_urange skip_size_info = {
+		.min = 0, .max = 255, .val = 0 };
+	struct rte_kvargs_urange flow_max_priority = {
+		.min = 1, .max = ROC_NPC_MAX_MCAM_PRIORITY, .val = 3 };
+	struct rte_kvargs_urange outb_nb_crypto_qs = {
+		.min = 1, .max = 64, .val = 1 };
 	uint32_t ipsec_in_min_spi = 0;
 	uint16_t outb_nb_desc = 8200;
 	struct sdp_channel sdp_chan;
@@ -254,7 +182,8 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	bool lock_rx_ctx = false;
 	bool rx_inj_ena = false;
 	bool no_inl_dev = false;
-	uint32_t rxc_step = 0;
+	struct rte_kvargs_urange rxc_step = {
+		.min = 0, .max = ROC_NIX_INL_REAS_STEP_MAX, .val = 0 };
 	int ret;
 
 	memset(&sdp_chan, 0, sizeof(sdp_chan));
@@ -277,9 +206,9 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	ret |= rte_kvargs_process(kvlist, CNXK_MAX_SQB_COUNT, rte_kvargs_handle_u16,
 				  &sqb_count);
 	ret |= rte_kvargs_process(kvlist, CNXK_FLOW_PREALLOC_SIZE,
-				  &parse_flow_prealloc_size, &flow_prealloc_size);
+				  rte_kvargs_handle_urange, &flow_prealloc_size);
 	ret |= rte_kvargs_process(kvlist, CNXK_FLOW_MAX_PRIORITY,
-				  &parse_flow_max_priority, &flow_max_priority);
+				  rte_kvargs_handle_urange, &flow_max_priority);
 	ret |= rte_kvargs_process(kvlist, CNXK_SWITCH_HEADER_TYPE,
 				  &parse_switch_header_type, &switch_header_type);
 	ret |= rte_kvargs_process_opt(kvlist, CNXK_RSS_TAG_AS_XOR, rte_kvargs_handle_bool,
@@ -295,7 +224,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	ret |= rte_kvargs_process(kvlist, CNXK_OUTB_NB_DESC, rte_kvargs_handle_u16,
 				  &outb_nb_desc);
 	ret |= rte_kvargs_process(kvlist, CNXK_OUTB_NB_CRYPTO_QS,
-				  &parse_outb_nb_crypto_qs, &outb_nb_crypto_qs);
+				  rte_kvargs_handle_urange, &outb_nb_crypto_qs);
 	ret |= rte_kvargs_process_opt(kvlist, CNXK_NO_INL_DEV, rte_kvargs_handle_bool,
 				  &no_inl_dev);
 	ret |= rte_kvargs_process(kvlist, CNXK_SDP_CHANNEL_MASK,
@@ -320,8 +249,9 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 				  &force_tail_drop);
 	ret |= rte_kvargs_process_opt(kvlist, CNXK_DIS_XQE_DROP, rte_kvargs_handle_bool,
 				  &dis_xqe_drop);
-	ret |= rte_kvargs_process(kvlist, CNXK_RXC_STEP, &parse_rxc_step, &rxc_step);
-	ret |= rte_kvargs_process(kvlist, CNXK_SKIP_SIZE_INFO, &parse_skip_size_info,
+	ret |= rte_kvargs_process(kvlist, CNXK_RXC_STEP, rte_kvargs_handle_urange,
+				  &rxc_step);
+	ret |= rte_kvargs_process(kvlist, CNXK_SKIP_SIZE_INFO, rte_kvargs_handle_urange,
 				  &skip_size_info);
 	rte_kvargs_free(kvlist);
 
@@ -337,7 +267,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	dev->inb.custom_meta_aura_dis = custom_meta_aura_dis;
 	dev->outb.max_sa = ipsec_out_max_sa;
 	dev->outb.nb_desc = outb_nb_desc;
-	dev->outb.nb_crypto_qs = outb_nb_crypto_qs;
+	dev->outb.nb_crypto_qs = outb_nb_crypto_qs.val;
 	dev->nix.ipsec_out_max_sa = ipsec_out_max_sa;
 	dev->nix.rss_tag_as_xor = rss_tag_as_xor;
 	dev->nix.max_sqb_count = sqb_count;
@@ -350,15 +280,15 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	if (roc_feature_nix_has_own_meta_aura())
 		dev->nix.meta_buf_sz = meta_buf_sz;
 
-	dev->npc.flow_prealloc_size = flow_prealloc_size;
+	dev->npc.flow_prealloc_size = flow_prealloc_size.val;
 
 	if (roc_model_is_cn20k())
 		dev->npc.flow_max_priority = ROC_NPC_MAX_MCAM_PRIORITY;
 	else
-		dev->npc.flow_max_priority = flow_max_priority;
+		dev->npc.flow_max_priority = flow_max_priority.val;
 
 	dev->npc.switch_header_type = switch_header_type;
-	dev->npc.skip_size = skip_size_info;
+	dev->npc.skip_size = skip_size_info.val;
 	dev->npc.sdp_channel = sdp_chan.channel;
 	dev->npc.sdp_channel_mask = sdp_chan.mask;
 	dev->npc.is_sdp_mask_set = sdp_chan.is_sdp_mask_set;
@@ -370,7 +300,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 		dev->nix.rx_inj_ena = rx_inj_ena;
 	dev->nix.force_tail_drop = force_tail_drop;
 	dev->nix.dis_xqe_drop = dis_xqe_drop;
-	dev->nix.rxc_step = rxc_step;
+	dev->nix.rxc_step = rxc_step.val;
 	return 0;
 exit:
 	return -EINVAL;
-- 
2.53.0

