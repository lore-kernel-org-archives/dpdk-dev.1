Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF40CD6E49
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 16:12:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BCE14042E;
	Sat, 30 May 2026 18:11:58 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 30A6D40264
 for <dev@dpdk.org>; Sat, 30 May 2026 18:11:56 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-132830d8281so4488770c88.1
 for <dev@dpdk.org>; Sat, 30 May 2026 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780157515;
 x=1780762315; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUbGkch0wLLUUl7pHVfyK2jOx4/QuKgT3cxAoYrOr2c=;
 b=dlfASCpn1BhvFRpuRSzHSZHZVn+KYs548LCsaERBPTyLeqEAhdiw2p3bDJb3yY2wVm
 2tTJKQXgI5L0uZ+/o3w6sWvYiE5FLv4S9r26VNdMWlRmvhKfFtoWz/1BWSMjdULMRJ20
 yHOUqipbpy+BTNK1E5fQuMBvKjW89bsIAwmeNwaY0qaqFXXKfXWgg5x32xaYwdyrXzxu
 HRCVRvFBRuJBtAZDbL3ggB5mUTYZtrPPMUoC3ZFm54SOD2BxWwkayHjv9VmNDSbI6g/u
 H21+tUpX/gjGd6o+QQ5sSPjYSVUbMix0UilIJdTTr8riCL2A43oqihf1BHcB6apJcws9
 c07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780157515; x=1780762315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QUbGkch0wLLUUl7pHVfyK2jOx4/QuKgT3cxAoYrOr2c=;
 b=K2bft52Fp7FO5HLjsnXM1kF1MoTBo5ywceXQcFMJuofOiVwICZy05iyPLCRcc71hU5
 5wRL5jnRw4kkODU31XL00xnFJww3PAFWVLhKfd2oYmrR5GLF/e9VYe1yq61v8huyE3JV
 Rt20IeJ1zKvK+EuF9pEIdzEIEHbfu/prkcPe2ym0kD6/oCimk08jOCuJBnBO4jrkCORe
 m8qXJfShEwRoHHHXPLxQKuyuocX0Cp3mXZj76pCroflXtNVH9bHxVH+sGlVCZ/pZgNlx
 c7+rec8XpR+ScPWHs7ZcdysDcbfAyTtRvcCETfG0KNJR2fuZRLi17t/ORnqdaZoK/hsr
 2cxg==
X-Gm-Message-State: AOJu0YxfI/mNNgQmPXOjRweCYMxf1tMw1b8PbfKiSM69IWP/htDCNVuW
 KOyLJPkk132Laoqyw0QSiFBFOaD9jWSc0xm8KXlX+aTkcAuuwlXq9WUKF3TtsYK73ibpmX+bL9e
 Medav
X-Gm-Gg: Acq92OHNleI4F591H2P5IcxN4cq1QQ9ZimWgZV+NMjGFQfGVZFhDB3XRdnKMC3joq2r
 ayNP8uWUrjR1FTvWd8wBqnBUGWe5rJQwFgo8yjQzJ7L2TMiX+x0pcspmN/gaEUIlUoeq+Oa2Dek
 kQZeJe1ZMnLGRR86m6cs5zdxN2qnvVPOPX3EaIx4EVm83WK4Bqhd+gbkZlEFHtANtXGIr0XvTdz
 mw8Z8a/zofQBt/aTQDx7eF4+qM4GhYyxjWeWPFs5mfya1NEK60lTwC+BSM5i2kX3vzHPBEKQphW
 FAOHSfm2QAKy7fNQ2SjlEGQo30tBCcBTLLjgxrpE+ce31CkB6bQWHWw+3ecm4wFJsvucBqSGMhA
 APMQ461e89KbM9H97y9FYBiAzvCXqUTWZt1cQm814MrHOx37NDJBYWGTUtLTQDbhgFIGgsN+o7N
 KLcFl0wzCbGP47/JknfCitAOjDrLX0RZtzKJI5zQN3R6MCqwH8lIQi7XYE27OEwWcTnNi4y9kT
X-Received: by 2002:a05:7022:628b:b0:137:ab26:7ffb with SMTP id
 a92af1059eb24-137d3f193fcmr1908694c88.9.1780157515163; 
 Sat, 30 May 2026 09:11:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69bdfsm3305616c88.9.2026.05.30.09.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 09:11:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [RFC 1/7] net/virtio: remove unused queue stats mapping
Date: Sat, 30 May 2026 09:09:56 -0700
Message-ID: <20260530161151.873199-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530161151.873199-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
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

The queue_stats_mapping op in virtio looks like a vestiage
from when it was needed to get per queue stats. That hasn't
been true since 25.11 release.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/virtio/virtio_ethdev.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index 9fd746b80f..0b2574bd02 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -90,12 +90,6 @@ static int virtio_intr_disable(struct rte_eth_dev *dev);
 static int virtio_get_monitor_addr(void *rx_queue,
 				struct rte_power_monitor_cond *pmc);
 
-static int virtio_dev_queue_stats_mapping_set(
-	struct rte_eth_dev *eth_dev,
-	uint16_t queue_id,
-	uint8_t stat_idx,
-	uint8_t is_rx);
-
 static void virtio_notify_peers(struct rte_eth_dev *dev);
 static void virtio_ack_link_announce(struct rte_eth_dev *dev);
 
@@ -672,8 +666,6 @@ static const struct eth_dev_ops virtio_eth_dev_ops = {
 	.rss_hash_conf_get       = virtio_dev_rss_hash_conf_get,
 	.reta_update             = virtio_dev_rss_reta_update,
 	.reta_query              = virtio_dev_rss_reta_query,
-	/* collect stats per queue */
-	.queue_stats_mapping_set = virtio_dev_queue_stats_mapping_set,
 	.vlan_filter_set         = virtio_vlan_filter_set,
 	.mac_addr_add            = virtio_mac_addr_add,
 	.mac_addr_remove         = virtio_mac_addr_remove,
@@ -693,8 +685,6 @@ const struct eth_dev_ops virtio_user_secondary_eth_dev_ops = {
 	.xstats_get_names        = virtio_dev_xstats_get_names,
 	.stats_reset             = virtio_dev_stats_reset,
 	.xstats_reset            = virtio_dev_stats_reset,
-	/* collect stats per queue */
-	.queue_stats_mapping_set = virtio_dev_queue_stats_mapping_set,
 };
 
 static void
@@ -2823,16 +2813,5 @@ virtio_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	return 0;
 }
 
-/*
- * It enables testpmd to collect per queue stats.
- */
-static int
-virtio_dev_queue_stats_mapping_set(__rte_unused struct rte_eth_dev *eth_dev,
-__rte_unused uint16_t queue_id, __rte_unused uint8_t stat_idx,
-__rte_unused uint8_t is_rx)
-{
-	return 0;
-}
-
 RTE_LOG_REGISTER_SUFFIX(virtio_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(virtio_logtype_driver, driver, NOTICE);
-- 
2.53.0

