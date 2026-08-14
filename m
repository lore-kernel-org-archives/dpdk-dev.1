Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C59C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:20:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4B8440288;
	Fri, 14 Aug 2026 22:20:05 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id DA7E7402DF
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:03 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cbed97fa26fso935562a12.0
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738803;
 x=1787343603; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EbS3+sjzFFKeOy2b9UxtL0PnguDIJr/SUVsbw7JV4f8=;
 b=MbdKyJmJ+aNirLwKIjjb91L3UCY0XSZ1C3oHI6Uefwih5lQ+HoPpb1vyoHcEQNiRof
 6FuwdTZ+7GLS3Pebfo3tIq+rjrJhcDdbsVNH7cu7BGX+gRsCj6ce4VZrYs7pgHiOfb0/
 uJFaV+vH6aiv1SjavDfYHP+z89yY5z/LMAUGrCIeVVKo/Xpp2CalLWPbmcvj0fWYy6Bt
 a/iisdQUZYMsjryv8/G3ybwKLp0Ohjpc25A3uyRx9eglF3Hlyuz6suDfRBRGN8/mkAGn
 UKZppF2B2EKTbzelQRHCp8J+IoIEYACZsjgfudWqvQiBIycmKoxwWU9uM/fBZtVI459c
 l+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738803; x=1787343603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EbS3+sjzFFKeOy2b9UxtL0PnguDIJr/SUVsbw7JV4f8=;
 b=QcKXM+kA9WPkWD/uhjwr37rP/6BMFtyxbJYcLtXTLVSqplidzxfEAN+Zeg6lFidpYy
 ssql0sIbylHW394EV22JnIqZKZLWT8MRA8UfEc8bSbakSsS1kjcJbwS9BHPEvSyQhu/z
 xjWLuDSSrjpEX2CJf1ZEj495Rqu5besMidZnt8NgTGkat6UvzKqhJYcxFMJY9TRciier
 ck14X8sBhonbeQidYDUpyRPuA02EFR03Fbos/nraQHpaauaaYrpBFhGLBEk+1KJV6Lnv
 RMofHs3NJUfu2F2ex3X7A9kDrqmLINW3WT7gk2GrtZA3gxyUXM4VkjJWltFCGvB/qYLh
 NhDA==
X-Gm-Message-State: AOJu0YzegziysMhjUjgc5dW7QsKHVF5fLX+9FJQ6215Yeh8TVNj0tLZe
 7v+3b6uO7gPUOSQ7h1O7aYK6TIbcZV0oLp9GGZMA8HK0FXEP8NcP6utVO5JsN9/QkD3cYiSkdyh
 +FBFD
X-Gm-Gg: AR+sD13ApiXI6/dQ3KwFL6CGxGjuFC4abqEH8hCzbi6dGqwmNQVl24X/+6RSoRDCX66
 wePDSFF2HVFha/qWzssgagTfLSzK+C4aulogPneAvS32EldKCU/3HJV/4RTZn+XhR37v1vCVd4l
 +7/FImx55G7zYC9Ty+vF9ZPwYLwdczAAS7rV9th887rrkKi9+YdocEHG/wJyGT/KbnUSiy7rI+p
 S+66j9rHBYlKkUgc01hfE7eprtANa/loM4Q6qvpCU8654NeXsLcY8oGzF4NeAmxHXuc8Wr0qQf3
 w4p815hAw8hNbAylh1HeBah6QijPEe6X96wmmhg7ZLWICDRlLAh/zbbzAYLdI8T6tXzF/u6vJKN
 OYk6cRREEnYNpEtP7mcWsViw+mh017XFCE0gzyIdJh8FO588o68okSqHxk6F5XenpH3/RDYv19m
 OnVk/o67Z+mTSNI187yAy8WoOd5e2Yt7EjpFVuK8wDec4nyvt6Gx5EoWDQJuChyGQvQo0V/ik8E
 vke/f0C8DKxMHgDMUWTgBQHe8v8xHpSXyxniwo=
X-Received: by 2002:a17:90b:5445:b0:380:8bb9:aba9 with SMTP id
 98e67ed59e1d1-3931f450eb6mr12439732a91.3.1786738803002; 
 Fri, 14 Aug 2026 13:20:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:20:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hyong Youb Kim <hyonkim@cisco.com>, John Daley <johndale@cisco.com>
Subject: [PATCH v4 03/16] net/enic: remove unneeded ops initialization
Date: Fri, 14 Aug 2026 12:45:59 -0700
Message-ID: <20260814194757.329424-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814194757.329424-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
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

