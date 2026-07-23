Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C894FC531CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 20:29:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0918940A82;
	Thu, 23 Jul 2026 22:29:47 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 7476D40678
 for <dev@dpdk.org>; Thu, 23 Jul 2026 22:29:43 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso817101a91.1
 for <dev@dpdk.org>; Thu, 23 Jul 2026 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784838582;
 x=1785443382; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5jiW7s+gZOu81CdfQGfqDsXdisYV65wVJramdIriUUA=;
 b=uzpaYGYOlQorirXC0rTyWt01w65I+CgA9m9rNEdgUjsWy6fr/cTqGz1RumzpDYd2wi
 Z5m3TRumF32l2pnSbARBKLVJn2NB7d4NuMXKqfpbJcB3OGCXdi+yIAbDqsU3kY2OHeBI
 j/8Q+HqcloRO7ZBNtG7oVfxhPeQ/VyEGjN93ZLXv+fBqNLbMdRSXx1PGFU17tItAbbGb
 CCoxwwk10OABHg7hmdvY2W1qny2GsNITY8TXU7x6xe+TP2I7W1X1QGYQnNhLizmtZHSs
 sCGwVF/UTZIyQNvloVLRJc+cV6mqTA7KkBYDuB5cggrZyYQNnnPDE1wrv21dlUBgH8YC
 v86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838582; x=1785443382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5jiW7s+gZOu81CdfQGfqDsXdisYV65wVJramdIriUUA=;
 b=Yb5cqu6imPVkUY0PdRs17lwI+9iQpNnAHzTuYwBbK4UqZYvMk8mRhfJ3NzblyscAyT
 d7+k85rvx9DlUjnODd/FZRUzgH7+QUXdSrnfrAKT2//8Apk06NjXaiGmQdFQeZWw8OFy
 V8lX66vEE6A+kWx6FYIt78lfPi+CR6/NPTJOBy0Ad/l0A7zJYqQfylug/y3UksjoTkvG
 Y0PTKnRy/IUKuBBLkCeVKpltnVNjHU74DxlfPBCf5PRyWnJpIoH9QDbDu0YrsJ+kcW9I
 k1n+OLDp/hvKtlnVpzaDCkz7p6pmRLD2dgmhOa0pph97DUkX0HmLGgEceG8anVpr/kks
 wSeg==
X-Gm-Message-State: AOJu0YyRSsPkxAFXZnqo3/E0d11gsoZuN/Mym5Lq6cOzOchV6LLTnPwf
 PKSLamV1zXO7M1nO3siapXhQFBtE9pnMXib3gYntznTcN8lOdxHfjxesKUJmFYAu0UlHYyCUGgh
 GhkBq
X-Gm-Gg: AR+sD135pFQvo9jtzQrw3RMPkWT43Aen0ZHaELbwEiUsvrZtQE6Nl5/UAoGFu/DcTDl
 GA+IhqL+qDJWvyJVtkRwafzKuCsuXMwEzvFvAV9SGpGPleTz4o0lrV1aP72XHw0IaX82/sgw713
 k9dmXH+ZoCsNGD8C/Z599p8W1RIbBl68+moRJTdD0NeZffdI2QH2xaUMypiBbNhse2Y4JpV1b6V
 fNfAP9SivM9n4tsQr1h1EtmPFLkgpYyqR29lx4LMc873DndUqUYqJWZ0BrjjPtKt6pAHpqsDZ+4
 na1jdarX7rNDmYltXP3CSz+/Qew+LF6pXwBVBYNgdLo1MhOsxzMFRQSWqP9LCeACZnGaCQLp5ld
 gEgVuFbK/ZMnCf+yaMSk7TzfjKzAvM+bBKK27LCPhOGV9+mUqGKI4rctheWfio+oITcRBFWKE2r
 QkBawAc1Oa3hF7RjM6HAgX8p99OiTkjzRrIdF1FkHH
X-Received: by 2002:a17:90a:5895:b0:38f:a81:15b1 with SMTP id
 98e67ed59e1d1-38f0a81287emr107308a91.19.1784838582574; 
 Thu, 23 Jul 2026 13:29:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d12f267fdsm18864877c88.0.2026.07.23.13.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:29:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>
Subject: [PATCH v2 3/9] net/enic: remove unneeded ops initialization
Date: Thu, 23 Jul 2026 13:28:08 -0700
Message-ID: <20260723202936.378793-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723202936.378793-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
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

