Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9DFC3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 14:46:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83EDC4025D;
	Mon,  5 May 2025 16:46:14 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DC65340156
 for <dev@dpdk.org>; Mon,  5 May 2025 16:46:12 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1FEC42115DC1; Mon,  5 May 2025 07:46:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1FEC42115DC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746456372;
 bh=mB6+ZC7s0QIn/ojM8vFtVTqACrpxsk8mxPkBPgKvj3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UZWKjUbN8D3ZxsVX5/MXUnqXzea99vZXmE0wN6Ip2ccxwuBNl/XozT16X3Me7Mzqs
 zFs382sa56ZyJ43qsBVvhOJrdCu46bXPQb/dBNl5NWLlIGgQTyqC+2tudMnN8PrWuM
 mwxQ+WjEyWVrxZDzphU8f7OlFhsKyyy05ZCwt8K4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 1/1] net/mlx5: unresolved symbol mlx5_geneve_tlv_parser_create
Date: Mon,  5 May 2025 07:45:37 -0700
Message-Id: <1746456337-6278-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746456337-6278-1-git-send-email-andremue@linux.microsoft.com>
References: <1746456337-6278-1-git-send-email-andremue@linux.microsoft.com>
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

When compiling DPDK with mlx5 using clang on Windows with
"debug" buildtype the error below is hit:

net_mlx5_mlx5_flow_dv.c.obj : error LNK2019: unresolved external symbol
    mlx5_geneve_tlv_parser_create referenced in function
    flow_dv_discover_priorities
drivers\rte_net_mlx5-25.dll : fatal error LNK1120: 1 unresolved externals

With a "release" buildtype the error is not seen, which explains why this
issue was not reported earlier.

The same problem will show up with MSVC, but patches which are still under
review are needed for this to be hit with MSVC.

The cause of this problem seems to be that mlx5_flow_geneve.c is only
compiled on Linux. This patch fixes the issue by compiling the file on all
operating systems. It also sorts the file names in meson.build in
alphabetical order.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/net/mlx5/meson.build | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mlx5/meson.build b/drivers/net/mlx5/meson.build
index 78a8648b43..6a91692759 100644
--- a/drivers/net/mlx5/meson.build
+++ b/drivers/net/mlx5/meson.build
@@ -17,41 +17,41 @@ endif
 headers = files('rte_pmd_mlx5.h')
 sources = files(
         'mlx5.c',
+        'mlx5_devx.c',
         'mlx5_ethdev.c',
         'mlx5_flow.c',
-        'mlx5_flow_meter.c',
-        'mlx5_flow_dv.c',
         'mlx5_flow_aso.c',
+        'mlx5_flow_dv.c',
         'mlx5_flow_flex.c',
+        'mlx5_flow_geneve.c',
+        'mlx5_flow_meter.c',
         'mlx5_mac.c',
+        'mlx5_nta_rss.c',
         'mlx5_rss.c',
         'mlx5_rx.c',
         'mlx5_rxmode.c',
         'mlx5_rxq.c',
         'mlx5_rxtx.c',
         'mlx5_stats.c',
-        'mlx5_trigger.c',
         'mlx5_trace.c',
+        'mlx5_trigger.c',
         'mlx5_tx.c',
         'mlx5_tx_empw.c',
         'mlx5_tx_mpw.c',
         'mlx5_tx_nompw.c',
         'mlx5_tx_txpp.c',
-        'mlx5_txq.c',
         'mlx5_txpp.c',
-        'mlx5_vlan.c',
+        'mlx5_txq.c',
         'mlx5_utils.c',
-        'mlx5_devx.c',
-        'mlx5_nta_rss.c',
+        'mlx5_vlan.c',
 )
 
 if is_linux
     sources += files(
-            'mlx5_flow_geneve.c',
             'mlx5_flow_hw.c',
-            'mlx5_hws_cnt.c',
             'mlx5_flow_quota.c',
             'mlx5_flow_verbs.c',
+            'mlx5_hws_cnt.c',
             'mlx5_nta_split.c',
     )
 endif
-- 
2.49.0.vfs.0.0

