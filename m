Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32560C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:04:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57D9642DE4;
	Thu, 13 Aug 2026 20:04:24 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 4A75D4026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:04:22 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso86592a12.2
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644261;
 x=1787249061; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EbS3+sjzFFKeOy2b9UxtL0PnguDIJr/SUVsbw7JV4f8=;
 b=rvRB1OarhAYsA5NyGJLm/ypQ1wY1RTfkO0Bnujh6RVbx/uSmYv9fdtECVMKgYO8zgz
 1/bOppTGTnbSiWuHJaG3zbynXbo0mYId5snVFRWwY9oYX1pR2UE6rSjoqgA4jNa2mvdj
 u0A3sCSh6W92lkL4BNyjNLManyy4c7ajQWlNVi2VupfVXi9UmAZEJdDZemvYbLxi0k5e
 B0tTrza0xx+LvFzk50rRs/EdFmuReXx8uDwg57kGlKaPgxFTkXTebZs0JiXR+bcxG0gW
 EtZ5l9YHCX+gSEdVAyA48piJfgHecQMazd6T6Z6CLrn8gbXngm2h5oo1DJGth2KiB6D1
 xpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644261; x=1787249061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EbS3+sjzFFKeOy2b9UxtL0PnguDIJr/SUVsbw7JV4f8=;
 b=Gh4+zBSnD6SZxnJjjAFVkGX4iVO5Z/6qg05yuKSX4uQV1z9r7k0i7CnUhQhL8pj4H/
 UTxbIDDRe5q022IeIB1NgRsaksIcecC5qw0E061Z0wAl9iEM4Q6tslhnwlTT5/HfWxKk
 lbN9t9yMtSndAm5clHNaKYUidr9LzARo4tg7+44g66XQ7BHR2ZmikqT9pJPRWGuYxbVQ
 //HTx3XCMBLHWVkRak/hmX0IPbyhHDFfy4JxIPR/rJ8tixxkGpBRKhpjlYDDF5cl62t+
 x5N3mr7FJj2hzqP3BuJbkT+N7eE6Qi9CtaMgBgOchhGGp7Q+W3PEPGXjupFyCJxMBZtj
 PVYw==
X-Gm-Message-State: AOJu0YyiABK0wlURGFc5ymwocXjWLW88T370s75az2KhAcF49SqN7NwK
 QNsBaBmlubkMwpUtU8y5KgVfxitVdeL/hY5rplQnqoNQCvdzmf7oNI2fcsNAMG4Pf/033DIGCEl
 xkgGl
X-Gm-Gg: AR+sD13uBXin74r3BYbc+qwnOzFEUlvM6l2trP8YKWC+4UWEfPIzRu01uVYOnvng0uI
 V2GdVkkwJHxT1HO5rvDVXaiojHcybiyB5seVRLPbGMCeWNbxIZxZxj1nmOtA0kO9uz9r1xxj3wg
 Bf3sTY3c4CkTGXp2BY9eoq64DEd7Ty5TwFwcFn+8gyWSntaKKRhlpQG8S0BTnxLBpvzox5Ai4p7
 yt41AnkCdrffiMlqE8NKLUTC0NguU6Q7/yA3kytQFsErcicnmhUILamYXMn9F0H9rvGZR8NyXfq
 sFOHenndzsy4RRWYrcLEsuN2DnG1cR3to/BzaQqW7roXJje0yRQPG5ekxxkMRl4/9zjfuhkvR77
 g8jEQcQhgGhN+OJlhMN9Zx0iOk310+kQil1sWpYjEpDi/CfI+5LVOQuzqMFpwYR3ftPwQXiSYQP
 41CAi6flrgld3/lK9C9u53ykXQV5a9EFKYd9nUqicAhTqfJWEcsEMC6KsQTK9QwKncqgcRZTVZh
 nNW0K/t9yLlrm1To7a+xVb3GtA=
X-Received: by 2002:a05:6a20:6f9c:b0:3c3:8315:80b7 with SMTP id
 adf61e73a8af0-3cc5504ea26mr10943492637.9.1786644261294; 
 Thu, 13 Aug 2026 11:04:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hyong Youb Kim <hyonkim@cisco.com>, John Daley <johndale@cisco.com>
Subject: [PATCH v3 03/16] net/enic: remove unneeded ops initialization
Date: Thu, 13 Aug 2026 10:55:02 -0700
Message-ID: <20260813180402.622784-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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

Better to just let compiler initialize fields to NULL since then
if fields change that driver doesn't use, the driver source
will not need to be changed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hyong Youb Kim <hyonkim@cisco.com>
---
 drivers/net/enic/enic_ethdev.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/enic/enic_ethdev.c b/drivers/net/enic/enic_ethdev.c
index 2e5cd186f9..648aa67a85 100644
--- a/drivers/net/enic/enic_ethdev.c
+++ b/drivers/net/enic/enic_ethdev.c
@@ -1119,8 +1119,6 @@ static const struct eth_dev_ops enicpmd_eth_dev_ops = {
 	.dev_configure        = enicpmd_dev_configure,
 	.dev_start            = enicpmd_dev_start,
 	.dev_stop             = enicpmd_dev_stop,
-	.dev_set_link_up      = NULL,
-	.dev_set_link_down    = NULL,
 	.dev_close            = enicpmd_dev_close,
 	.promiscuous_enable   = enicpmd_dev_promiscuous_enable,
 	.promiscuous_disable  = enicpmd_dev_promiscuous_disable,
@@ -1129,14 +1127,10 @@ static const struct eth_dev_ops enicpmd_eth_dev_ops = {
 	.link_update          = enicpmd_dev_link_update,
 	.stats_get            = enicpmd_dev_stats_get,
 	.stats_reset          = enicpmd_dev_stats_reset,
-	.queue_stats_mapping_set = NULL,
 	.dev_infos_get        = enicpmd_dev_info_get,
 	.dev_supported_ptypes_get = enicpmd_dev_supported_ptypes_get,
 	.mtu_set              = enicpmd_mtu_set,
-	.vlan_filter_set      = NULL,
-	.vlan_tpid_set        = NULL,
 	.vlan_offload_set     = enicpmd_vlan_offload_set,
-	.vlan_strip_queue_set = NULL,
 	.rx_queue_start       = enicpmd_dev_rx_queue_start,
 	.rx_queue_stop        = enicpmd_dev_rx_queue_stop,
 	.tx_queue_start       = enicpmd_dev_tx_queue_start,
@@ -1151,11 +1145,6 @@ static const struct eth_dev_ops enicpmd_eth_dev_ops = {
 	.txq_info_get         = enicpmd_dev_txq_info_get,
 	.rx_burst_mode_get    = enicpmd_dev_rx_burst_mode_get,
 	.tx_burst_mode_get    = enicpmd_dev_tx_burst_mode_get,
-	.dev_led_on           = NULL,
-	.dev_led_off          = NULL,
-	.flow_ctrl_get        = NULL,
-	.flow_ctrl_set        = NULL,
-	.priority_flow_ctrl_set = NULL,
 	.mac_addr_add         = enicpmd_add_mac_addr,
 	.mac_addr_remove      = enicpmd_remove_mac_addr,
 	.mac_addr_set         = enicpmd_set_mac_addr,
-- 
2.53.0

