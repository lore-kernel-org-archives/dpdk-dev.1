Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998CAF5A8AB
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 18:48:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 716BF402A2;
	Mon, 20 Apr 2026 20:48:21 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 5213F4028D
 for <dev@dpdk.org>; Mon, 20 Apr 2026 20:48:19 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8acae26e564so40268306d6.2
 for <dev@dpdk.org>; Mon, 20 Apr 2026 11:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776710898; x=1777315698; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NQ75bROMpA+4m7tOq8L/VKdCGjn4UpnZbbb/nuY07+E=;
 b=p5ubuQaNUFOUP8PIdI9dRCyN0GqmCwqe0Aq2lES974zloUDcgEImqdStORMilgCl3w
 ckhl8V8GvWod+DPB9p7VkpUpcQu/gWz5H3GMAgQKUB1JRvrQ0FKltKxBtAR3DvK5oEpC
 sy49pTmue5443lJSDAyduE6meiyg6CQ3anjLdURfibPZPhO+Npe0vl0evWdSsVFFwjKE
 kr9XIep1DDtdWfT6/Gu5VlXus/SW/WiPNWifBLHaBoETUKiMSZ0zVKRYOKbV+AgSmUUg
 9WD4A8CZhbU0O8qu223ZjAAgS1pdEKmHBDYwx+dBXmp588xW4wj6pF7Z1529HaINPfpB
 CtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776710898; x=1777315698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQ75bROMpA+4m7tOq8L/VKdCGjn4UpnZbbb/nuY07+E=;
 b=N0/1ufGeM545qd6g/WJPCJYrjYVLxkmYubJHRjuDnEWu/plg3t3MJGMEaUrd/PTI69
 /o/w6CdzylHm3bZIE5OqnlUVAvTH2ADk38Hu74j05mfrWkzBlj/kAdhHTq1geB9a7KRG
 D/xopMn8rGVxojqIMvHzpZyeHCFONJPsxE7AGPPg5DDqrXvkAeIZERMfdqxWkO2BVFzJ
 Py/+o4n0jwbB32/RdE1D3Sx4A70n9g9La01jH4o9ANmMqcSIOcrUxQ+I5oJsO223CQKh
 /brw4lNsNjxDJhjcirXUftx4AllxGfSDP3xuEUrYxPUwEdOjOUPwp695Q+4fFnzncaQO
 L8Ew==
X-Gm-Message-State: AOJu0Yzjvuar37P34jq1GYgEQjM0MIjj3Jgfl8z/aUbWuQ6Rnm33qqyB
 91yr/Z8n4cqn1jlnggWi9ACLq1TgsKDjxW4h8rRu4N1zWrEV3zu9Jg7NRkG5oqMsBb0=
X-Gm-Gg: AeBDies0cV7y4DcTmqBPCrshxE17ZUApSZEX4W2Qk+8zWOODhq3/avqllQHvg2WEwaR
 d9o8+dWEPOcnIka98S/V565WVYsspq3NdVqts3twaVFRvRcPftC3fUIozohXatwMGxxzEA/CWdr
 oli/rQ3BuMydF5+2WrSZJov3CNv9bmxNZ1julTTB/KuXXsJSwVjfnRgFTsJqC4yeLsDowCBfi9R
 /xSgTgJw+QRrg8rXA7/Qx2DafO1NCiqIiJD4G2gAY4ox+SYeeGR6Uz7jgbz2Y9z7AsqEsGjXj5N
 zGA10s3shvKKGM8bwmfABU45U21N44SXGkw5WXjcZJ1ankyL0zu7+Om91uWGd7UdgrW0YDoxXfH
 I8xczHac0pGdg9XQ66woBg1wHsGxRZMRC20JSRZHCLBcZc/uGzUV6pFkAz4wxqoEgPlMJj/ybFK
 Y/OxIgrl1s10BmSjt/7+aURUJ3eG7N+g4tL+d00wVjZp7i5xUj8ESW2ZCdY35wEmb4vxCWtoNLO
 R6JyL0n8Iyh0YjkGYdqXrRwqiiavBk7yQ==
X-Received: by 2002:ad4:5d63:0:b0:89c:e371:2b3d with SMTP id
 6a1803df08f44-8b028226f8cmr246526296d6.45.1776710897886; 
 Mon, 20 Apr 2026 11:48:17 -0700 (PDT)
Received: from LAPTOP-T809MHP1.home
 (bras-base-hullpq2034w-grc-10-74-14-173-40.dsl.bell.ca. [74.14.173.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac4513asm80505746d6.1.2026.04.20.11.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 11:48:17 -0700 (PDT)
From: Rayane Boussanni <rboussanni@gmail.com>
To: dev@dpdk.org
Cc: rasland@nvidia.com,
	Rayane Boussanni <rboussanni@gmail.com>
Subject: [PATCH] net/mlx5: query hardware capability for max lro size
Date: Mon, 20 Apr 2026 14:48:08 -0400
Message-Id: <20260420184808.751-1-rboussanni@gmail.com>
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

Resolve a FIXME in mlx5_dev_infos_get() by dynamically checking the
hardware lro_cap flag instead of unconditionally advertising
MLX5_MAX_LRO_SIZE. Retains the standard 32-byte fallback for
min_rx_bufsize.

Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>
---
 drivers/net/mlx5/mlx5_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index a29cdeeb50..fb51de031b 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -363,9 +363,9 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	info->min_mtu = priv->min_mtu;
 	info->max_mtu = priv->max_mtu;
 	info->max_rx_pktlen = info->max_mtu + MLX5_ETH_OVERHEAD;
-	/* FIXME: we should ask the device for these values. */
 	info->min_rx_bufsize = 32;
-	info->max_lro_pkt_size = MLX5_MAX_LRO_SIZE;
+	info->max_lro_pkt_size = priv->sh->cdev->config.hca_attr.lro_cap ?
+				 MLX5_MAX_LRO_SIZE : 0;
 	/*
 	 * Since we need one CQ per QP, the limit is the minimum number
 	 * between the two values.
-- 
2.34.1

