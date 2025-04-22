Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AC8C369C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Apr 2025 06:40:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C0CE402A9;
	Tue, 22 Apr 2025 08:40:00 +0200 (CEST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by mails.dpdk.org (Postfix) with ESMTP id BFAEC40299;
 Tue, 22 Apr 2025 08:39:58 +0200 (CEST)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-5ec9d24acfbso10156878a12.0; 
 Mon, 21 Apr 2025 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745303998; x=1745908798; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4COOiqkXPyhFsucYecwPz+Z+96d9a0IarEUJKAYI9PQ=;
 b=TBWyyY0IW6LHGAi20PqHGnzdiIahgTbxLiUHwjlUGDzHNssbuw0fSuxT7w2ItykPyB
 39Oxf5RnEN1UbthPRmJuWw9sSkNWSZqYVsmX3+UJS5C4c3gdZl0wVBd/lFTifH1oSPQA
 +akSomPPMPTnUZZwLEzSONeAhDzqyNobUONjGyl9QhsKEIchPqpRZnbI8NgXEW7bBgDp
 gVnuiuyUBEN6WpUW5V+jrd4DzGlrpJxFfMvauN1ds7Ynnmm7XMR34SjhdJtmz8pgmE7f
 ndsso4ELLH2bPJtLJ5gy7DPPUaEJYvPhlMCTs2NIRX/aEsMA/yFPXlC+g+6DOd0hw0xy
 YO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745303998; x=1745908798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4COOiqkXPyhFsucYecwPz+Z+96d9a0IarEUJKAYI9PQ=;
 b=IrqT19JQoMRFraY2ZBGXTR8up7vZMo1RoDk1qXl381QBd5d9yOuUiv5RzbQ7O998QP
 EQgOu+CCimz9MrwxGuwA++U6DUYCutv2JPCG+lnmEHjdZ2vuo9d42+WCtM5bk39sabLc
 egEPz+MdNT6UD7k7a/hT70Pc5eAMywkWj/6ZKEz9fOeBWYrp+26+HjpPvOEqR6zoZsJ5
 NoLi8+x05RRBDM4SppG/4qxFtQPXkpDCTV93nxKf2CjcWE+i6fZF2G2jXD5jxZGqBn+q
 5Zt9n9YcqtXIF3KsnMnaIUFwSeUVl/AtKjhf+OZq0czKbzn0iQM7niYBx7+k/FVGUTDF
 GgMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCi+rKoP3Pde4MbZUfqvTiL+R0uIRIKeNghoiB1iL0LjPcdQhWDWPaE9WZkTVBcwjpIQtKwMA=@dpdk.org
X-Gm-Message-State: AOJu0Yz6JCpK+CVR9ZSCLEcR63ROoLAcUZ/ezGr8yeAX/YawBFqsdUEK
 GX9Q8xixYOrZRGsl0OSlVX8N/mC0rq9FgsTP+F4jx5KBCjnn/oON
X-Gm-Gg: ASbGncvMj3wCRcUK+1At532exRY/GnJLGxxtZwApnl2vvOook7W/VwuonSAJOTMML/E
 PXorwTFcODlHzpSGMABGc29hPDPnaxlUQa+HdzikCbsri42Xoo92le/XO4GaVwJ6vRy9D7N3xJG
 fpwfYdcnQjNdEJGSnwvSag7nmVYiVsv6kg2lQ1bVXRRPr2enIyb/U8eTTO/q4tR2Z0IlSTAV/Wr
 dMlJJ0hy7oiquh343TR7+fQ+wmoejJ8RUBNvJHZ+uP4KrIkHOHFhMvl4PepJG5pxXzhym7IkGC4
 G5hbD6iiOKOH+Oosjkg6lA7bI9x/aweGP3x3rAdgJdGRsdbiKwd37hHalp9EqhxZpSG7/Jd99un
 HUIX+mQsLkg8Ok0idSWg=
X-Google-Smtp-Source: AGHT+IFtab4HfwwBDCeRaKMuK91D/Q2XZFhNlZSTBOadH9jBhyDx+xOfUvl2cQUiazRFUwi40P2wTA==
X-Received: by 2002:a17:907:d17:b0:ac7:981d:b137 with SMTP id
 a640c23a62f3a-acb6ee24847mr1063728466b.22.1745303998035; 
 Mon, 21 Apr 2025 23:39:58 -0700 (PDT)
Received: from localhost.localdomain (apn-78-30-81-147.dynamic.gprs.plus.pl.
 [78.30.81.147]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb94140bb8sm430433766b.17.2025.04.21.23.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 23:39:57 -0700 (PDT)
From: patrykochal@gmail.com
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Yongseok Koh <yskoh@mellanox.com>
Cc: dev@dpdk.org, "Patryk Ochal (Redge Technologies)" <patrykochal@gmail.com>,
 stable@dpdk.org
Subject: [PATCH] net/mlx5: fix out-of-bounds write in Rx software ring
Date: Tue, 22 Apr 2025 08:37:54 +0200
Message-Id: <20250422063754.3429965-1-patrykochal@gmail.com>
X-Mailer: git-send-email 2.30.2
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

From: "Patryk Ochal (Redge Technologies)" <patrykochal@gmail.com>

If the vectorized Rx burst function runs short on available mbufs,
the CQ processing may write past the end of the RX software ring.

This happens because `rxq_cq_process_v()` populates the software ring
and accesses mbufs before validating the associated CQEs. If the number
of available mbufs is insufficient, this can result in out-of-bounds
access.

This patch adds a limit to ensure CQ processing does not exceed the
number of mbufs that have actually been replenished and posted.

Fixes: 03e0868b4cd7 ("net/mlx5: fix deadlock due to buffered slots in Rx SW ring")
Cc: yskoh@mellanox.com
Cc: stable@dpdk.org

Signed-off-by: Patryk Ochal (Redge Technologies) <patrykochal@gmail.com>
---
 drivers/net/mlx5/mlx5_rxtx_vec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_rxtx_vec.c b/drivers/net/mlx5/mlx5_rxtx_vec.c
index 2363d7ed27..67a1e168d8 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec.c
+++ b/drivers/net/mlx5/mlx5_rxtx_vec.c
@@ -320,8 +320,10 @@ rxq_burst_v(struct mlx5_rxq_data *rxq, struct rte_mbuf **pkts,
 	}
 	elts_idx = rxq->rq_pi & e_mask;
 	elts = &(*rxq->elts)[elts_idx];
+	/* Not to move past the allocated mbufs. */
+	pkts_n = RTE_MIN(pkts_n - rcvd_pkt, rxq->rq_ci - rxq->rq_pi);
 	/* Not to overflow pkts array. */
-	pkts_n = RTE_ALIGN_FLOOR(pkts_n - rcvd_pkt, MLX5_VPMD_DESCS_PER_LOOP);
+	pkts_n = RTE_ALIGN_FLOOR(pkts_n, MLX5_VPMD_DESCS_PER_LOOP);
 	/* Not to cross queue end. */
 	pkts_n = RTE_MIN(pkts_n, q_n - elts_idx);
 	pkts_n = RTE_MIN(pkts_n, q_n - cq_idx);
-- 
2.30.2

