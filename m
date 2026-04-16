Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DBCF8E489
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 22:40:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B28740278;
	Fri, 17 Apr 2026 00:40:57 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id A55DD4003C
 for <dev@dpdk.org>; Fri, 17 Apr 2026 00:40:56 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-8a3b0242631so369076d6.3
 for <dev@dpdk.org>; Thu, 16 Apr 2026 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776379255; x=1776984055; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DoCrn5+xTTUddHPzGdbism7ReViueh8VYD3LlESb9e8=;
 b=ID/Oh0u4b0C4CDdpv5YWNke8JFR/ND4cE9FnRp1XBFMJeAUYsW2jNpGjcFkHlj2CCL
 szBZNp+HFMtCB9UbpnHGxqcStRE83He+brv3STF8iy9eHAmofKAmgVvs4QopMVxRjDxh
 UFT4XZk62qYMC9iSLGc33+p17DCNDu2uUGY+eCa9SxJL8LBinV72ge7eSRZFfHzT4nBI
 TYh4ajs3w0xPx8Z617IzVoBVYpodkSWkgPeV4Mz3ys6QYC5G+xvzrJgPl5WAZmPKnTcz
 KQK0TFn+MtoIFq8CZ5Zr50+hH1QrGJrsNTWNEu5GS+GvH4stdtpYa4uleeCCZC2cWCyZ
 LEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776379255; x=1776984055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoCrn5+xTTUddHPzGdbism7ReViueh8VYD3LlESb9e8=;
 b=mEQ7jUvlEEKa5WbwFKt09BXqi8ilBZ9ALJcobFs57bdjCjNB2SpjSRXdhOd56bLe6e
 xtWuGACWGkD2EONhjd+Q/fbsLanWErnoJ18bQnrpIEk9I6o6l6KdR8OnOlOvWpRMJqMV
 YJYa4eT5nFEpP3Dy8kWzrUdR//NTWmV2biTD3mTT3DjGvxkCTr8ijD4YrEAJOazVlpaY
 /6HCQF+5xAghPeC1opxx3JiNM5f6rD5+pVrSZsclYOYYqLop7TVvsFjyEU7vdPILwIsy
 F/YuOaUX4L3IZU8+w+YxXuNPznEWk6TnfUXwnVH0X9WmRM3XQVkAYqTYPNGI2JTKe0NS
 A/cQ==
X-Gm-Message-State: AOJu0YyiVrzTmsHJZlvN8c0j+u7mHAQnxAJhO75mQgLuLOZ8yCG4cbW0
 /g+gmD4XlcSph4NiSVqxIlCpqiGzOin2E67691m+nQB1hE/KccF9/Gz69u0mhTDreDM=
X-Gm-Gg: AeBDiesN732GKS32GLcSBroFsptfESvRJcnZ3ywbkyPiG+s1yeMxt5AO6uNznNZYwUE
 +V8m0LuoxlUTkgXnVRxKgE9qVHEMv88rT6C/ASKPLh+S7KnSDGcnTsPEmwY6nUpHoR+lG2wPGC1
 v9rmjWvXWJcjKcL6mRD6RDmrzOD1x7sMRgl1tXDIQxd4IkKowj9OCxK3RBdFo+dyaoqBsqznwMd
 ySQaoi6K0mjbeBjIbw2yE4lCMjkO8qkm91qHNOFv+UbGLZnuKERnbe6kCUiP13Ae29Ocy4DmPp7
 VZjDVPGwVo20uL3x6Ta4qaRhFfwSdJZqafF3ty6gsiajhrtfN53+lPWUsbX1iO0D0gF01/Xgggr
 3s0IS4Efy0i0VmsX9Lzf4DdSNV4zojzrzDy/x1rndY/b7bZRp8gk8L2exU8vT+ofwZ9ZPsJnbg3
 +Ij78DqE/leNMYX5BvOHaqrHklNd+avfJkR5uQ3j3MvII=
X-Received: by 2002:a05:6214:c84:b0:89c:4b7a:6a6c with SMTP id
 6a1803df08f44-8b0281607acmr7254456d6.46.1776379255392; 
 Thu, 16 Apr 2026 15:40:55 -0700 (PDT)
Received: from LAPTOP-T809MHP1.home ([74.14.173.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6ceb4a5fsm61863266d6.45.2026.04.16.15.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 15:40:54 -0700 (PDT)
From: Rayane Boussanni <rboussanni@gmail.com>
To: dev@dpdk.org
Cc: rasland@nvidia.com,
	Rayane Boussanni <rboussanni@gmail.com>
Subject: [PATCH] net/mlx5: add hardware query for basic stats
Date: Thu, 16 Apr 2026 18:40:12 -0400
Message-Id: <20260416224011.14862-1-rboussanni@gmail.com>
X-Mailer: git-send-email 2.34.1
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

When MLX5_PMD_SOFT_COUNTERS is not defined, the basic dev statistics
(rte_eth_stats) previously fell back to returning zeroed values for
all packet and byte metrics.

This patch resolves the FIXMEs in mlx5_stats_get and mlx5_stats_reset
by falling back to the target's dev counters map. It utilizes
mlx5_os_read_dev_counters to retrieve the bulk arrays from the hardware
and strategically filters them against the xstats_ctrl index to
summarize the basic opackets, obytes, ipackets, ibytes, oerrors,
and ierrors without duplicating the context-switch overhead.

Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>
---
 drivers/net/mlx5/mlx5_stats.c | 57 +++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_stats.c b/drivers/net/mlx5/mlx5_stats.c
index 5cd3e303cc..198f231559 100644
--- a/drivers/net/mlx5/mlx5_stats.c
+++ b/drivers/net/mlx5/mlx5_stats.c
@@ -280,7 +280,46 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		tmp.imissed = stats_ctrl->imissed;
 	}
 #ifndef MLX5_PMD_SOFT_COUNTERS
-	/* FIXME: retrieve and add hardware counters. */
+	{
+		uint64_t counters[MLX5_MAX_XSTATS];
+		struct mlx5_xstats_ctrl *xstats_ctrl = &priv->xstats_ctrl;
+		bool bond_master = (priv->master && priv->pf_bond >= 0);
+
+		ret = mlx5_os_read_dev_counters(dev, bond_master, counters);
+		if (ret) {
+			DRV_LOG(WARNING, "port %u unable to read device counters",
+				dev->data->port_id);
+			return ret;
+		}
+		for (i = 0; i != xstats_ctrl->mlx5_stats_n; ++i) {
+			const char *name = xstats_ctrl->info[i].dpdk_name;
+			uint64_t val = (counters[i] - xstats_ctrl->base[i]);
+
+			if (!strcmp(name, "rx_unicast_packets") ||
+			    !strcmp(name, "rx_multicast_packets") ||
+			    !strcmp(name, "rx_broadcast_packets"))
+				tmp.ipackets += val;
+			else if (!strcmp(name, "rx_unicast_bytes") ||
+				 !strcmp(name, "rx_multicast_bytes") ||
+				 !strcmp(name, "rx_broadcast_bytes"))
+				tmp.ibytes += val;
+			else if (!strcmp(name, "tx_unicast_packets") ||
+				 !strcmp(name, "tx_multicast_packets") ||
+				 !strcmp(name, "tx_broadcast_packets"))
+				tmp.opackets += val;
+			else if (!strcmp(name, "tx_unicast_bytes") ||
+				 !strcmp(name, "tx_multicast_bytes") ||
+				 !strcmp(name, "tx_broadcast_bytes"))
+				tmp.obytes += val;
+			else if (!strcmp(name, "rx_wqe_errors") ||
+				 !strcmp(name, "rx_phy_crc_errors") ||
+				 !strcmp(name, "rx_phy_in_range_len_errors") ||
+				 !strcmp(name, "rx_phy_symbol_errors"))
+				tmp.ierrors += val;
+			else if (!strcmp(name, "tx_phy_errors"))
+				tmp.oerrors += val;
+		}
+	}
 #endif
 	*stats = tmp;
 	return 0;
@@ -319,7 +358,21 @@ mlx5_stats_reset(struct rte_eth_dev *dev)
 	mlx5_os_read_dev_stat(priv, "out_of_buffer", &stats_ctrl->imissed_base);
 	stats_ctrl->imissed = 0;
 #ifndef MLX5_PMD_SOFT_COUNTERS
-	/* FIXME: reset hardware counters. */
+	{
+		uint64_t counters[MLX5_MAX_XSTATS];
+		struct mlx5_xstats_ctrl *xstats_ctrl = &priv->xstats_ctrl;
+		bool bond_master = (priv->master && priv->pf_bond >= 0);
+		int ret;
+
+		ret = mlx5_os_read_dev_counters(dev, bond_master, counters);
+		if (ret) {
+			DRV_LOG(WARNING, "port %u unable to read device counters",
+				dev->data->port_id);
+			return ret;
+		}
+		for (i = 0; i != xstats_ctrl->mlx5_stats_n; ++i)
+			xstats_ctrl->base[i] = counters[i];
+	}
 #endif
 
 	return 0;
-- 
2.34.1

