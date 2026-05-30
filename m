Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C26CD6E49
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 16:12:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A64D140611;
	Sat, 30 May 2026 18:11:59 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 3D9D540264
 for <dev@dpdk.org>; Sat, 30 May 2026 18:11:57 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1378943cd4aso5514072c88.0
 for <dev@dpdk.org>; Sat, 30 May 2026 09:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780157516;
 x=1780762316; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGkSWxMDvX6dQhJhr2JRc/aQQXbW1ypJ4z+blSWL/3g=;
 b=CpqS7tHjRa54jpCZpCGXRIlIVuXsOhwRktn2NApj/aEH97Ela0NNmJK3uwOzo0nsY6
 tqm4cLPGpGxWVNK7Fae/Um/GGCj7fLnqpKYf0eprX0wzbeEMi8++MFq7kTZfRMVdERK6
 cnrOBgB6MBDngLvxp08igH367mgrvwni3Oi0EoydmXZDUaWUOpz4FBwABQHv4goL0gMX
 SWRcb6qWFQ9qPLrw5y5FWMvfLmEJzzBWWzIYiHGDzBn9JES66p2rnm2yffm4UawwgtG8
 F7eg8n36ZazHxfgzqNC8GFNkKNrd5CPstXN1JRoIwmAXB+AS1xhPYHEkXo2Gd1cg2tuY
 +IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780157516; x=1780762316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EGkSWxMDvX6dQhJhr2JRc/aQQXbW1ypJ4z+blSWL/3g=;
 b=Y7rYD5AuIC5ljEZ4vPX6Rpa8iD1uYBODPUv9m2FupyJIxNYvabdj3FhlDgQfeJcEdL
 Z1Q8GmWiB9QirhWM6jI+mZxRACE3VGKjW/O4gNwaYCe98vvLs0nKmHQTm5NNIYARlJJ4
 95GsTQ1gBmjerd1qPWA2HjZIvEEh93L5A2yysw0qtXLyANhBorwUZMB3bhywCuO0pJaQ
 FmU0UnbaC1taYYlLVQZWLXRR7hF3ubAwodi85IJctpRVJj2K4T6nSuPho1mG1QhPaDBE
 naVavk+jj4XybUrfOTM9ONMT98RkU8LD5ntpisYae7E24s7CPMHIbITCArQAEY/rDm6y
 kxpg==
X-Gm-Message-State: AOJu0YxVGuww+aDyjkFrgBbwVQYLrRA1vqQtekspAU16nEciC805hRjC
 uqHrBXEfQo9moctdCmS/1M40OiJXoMhLJCa5VOPN5YhTRzXzekSpb0mdaUy2rJLoeAPxnK3lgS5
 +KEab
X-Gm-Gg: Acq92OHEg3p2HSnTaByxvVvy8R6Ix28fJlWsfaN0az1Jm+EfI6rk57VvCOk+qih54eU
 C5TXG4M02pcsPPMLym2cJiu1TiTwRG9Lb3AY3R1alSI76aYrZsZOfHRN5vVUxKkkFGZMSujXzPl
 0y81axZYXO5UUbXBJX91VDYydNOP4Ig7k/YCWD4m9hPS3Tw8bfxct7sbvV2lHiQaAg0wQAQyBXL
 NwFjorc4otajYu/B5fT+gqnE9SzZ1Movk4pJLuR5PQmL2j00sEvnXJPCsuQEgaqszm2ZNL0MdqL
 duxUoDbi6yhqtmUs4hVMz6vCD/97LQCfjCTdrW8zUA65QJffICJtM9vWI/Rvh4ius5xsvMK3gla
 gzAZpvWponQ+Q/antVuj7IHp4/PvaY4B0uOCGi7nEPehrWEJSlbh5EIzg8agm730wjuxAa0B/ip
 iUxRls4IOgC44I2jtlcv1MHyvXyMidGWPgopwG1K78/9E1QS4FuUcgDJlBCbe/dxGxG/K0GkQiC
 CKlKb8e3u8=
X-Received: by 2002:a05:7022:6283:b0:136:72f0:6c54 with SMTP id
 a92af1059eb24-137d427080bmr1750146c88.29.1780157516209; 
 Sat, 30 May 2026 09:11:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69bdfsm3305616c88.9.2026.05.30.09.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 09:11:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>
Subject: [RFC 2/7] net/enic: remove queue_stats_mapping ethdev_op
Date: Sat, 30 May 2026 09:09:57 -0700
Message-ID: <20260530161151.873199-3-stephen@networkplumber.org>
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

Better to just let compiler initialize fields to NULL since then
if fields change that driver doesn't use, the driver source
will not need to be changed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enic/enic_ethdev.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/enic/enic_ethdev.c b/drivers/net/enic/enic_ethdev.c
index a853a5047a..545edf12bd 100644
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

