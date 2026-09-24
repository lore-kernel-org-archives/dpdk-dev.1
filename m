Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F4AC98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 19:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 424DE40288;
	Thu, 24 Sep 2026 21:13:40 +0200 (CEST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42]) by mails.dpdk.org (Postfix) with ESMTP id 0F3044026A
 for <dev@dpdk.org>; Thu, 24 Sep 2026 21:13:39 +0200 (CEST)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5b8b3c8c4bbso925779e87.0
 for <dev@dpdk.org>; Thu, 24 Sep 2026 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nfware.com; s=google; t=1790277218; x=1790882018; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=62Q7JnbtNZ/O1fw7uu1275wg8rJgwGLFpek65eXE1jc=;
 b=Z7iCeDniM63+azxF50JHq016/p5Ph82Gkbnz179eG1gCEJMLtETmADrHIlX3O8MtBO
 9dghmlsrI+XxmYI1jZqgbs0oVvpXv4LbqyfQeALrAI1IAbI11lTS1282Yi1SuaClYTxB
 Ds2wxK4Yf4A289pNIxGkJf8b9uQopjP4W61qgiZC5ZWoxhRXSE1pTjouL8LU+xFX19rf
 F88EsmldpGjgkUG16iMzxF/l+nmLasMtefLhxIdKCfOz72o4L+P63OqMHktmT60cjHSb
 zrTORuLHQFfPIdaA2PVobGjzyvIVKNZNfjADJ4xVlQaCM1yWdHfrOJxVF6AyPRgyygiK
 Hunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790277218; x=1790882018;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=62Q7JnbtNZ/O1fw7uu1275wg8rJgwGLFpek65eXE1jc=;
 b=wu8w1UirTtICmol1Efn4qq9UuEE6NQYI8RYSaQ1STN1HL0s9cxOQdNcFrTOh2zmeA/
 X6W5N0xZsKR3+0ffDbg8qIQQ0WSZKw9wcZVhVlOBHdTZKk9NtawWAsfECNnApG2OZW1M
 00z+jaFUF5BTsYvw9v/5nJ4a7Zzfa2PXhhJQpm3z+3b3oFvkV0dL/Q6rfFFzVAciRGPA
 TT/nOl+9cpYhMgxmP1K4t5cNuMPeaqNJMZ0PEF+09oMmAW5MhQmT7J+Cwnf1ZLfZB6Zr
 i564WTThYk9F2eEIJHQ1B2h10/xFZUoImZ0VycykFnRcmQ4tV2V1+yEhXNquNRqWq5ep
 E1lQ==
X-Gm-Message-State: AFuF++mzhxIWYRHER26/bjARv5PdPiRMPiYyzfDSQyRAP8JUjRX7XNsc
 VbelKN+O0MbUbv5WdiDbYcdhtdV8TfdCqQjlMfpaJDxP1Yh3xu77KF/AWgh71cYcAi5G1IPbN3D
 wQwWvT9tZrg==
X-Gm-Gg: AYBFou1FTlr0f3Yb5btSL7oA8JCWV2Kzf4Mhr0Gee2SueAI5LSWp8uqVsHNpuZkZP7G
 zsK1A1752BCEe3EKT+AVwEwNMXyWUyL6UmJRVOn+v4hORud/p7zT+L8RSx6//8RRc9Trs39klbZ
 hKh4yqWI4693uwlBnTV4bf6H2o0rYaYYOJ/mdF90zgF0RzN2YnaflMJk1WedGvkbZgXDONOErAG
 kIJUUE8aWJYYB2ahH4H2VvoWz6EECeZ5iapqV41ZAsmHA6ntQvAhRyez8m4mE3zsj6/1ARZ3djL
 84YPBV4Qx0QWNzek/8N/zyKmzc9GnS+1r89j3GSgr9MjivVAb0b63WmP9/TFdf2WmBzyyvhJR7l
 mjRfTNZ6qOMSND48GXQFGDHOml8gnhUuoqiS+2+ayRqIPKqqrt1B8KkaPpTZyFADnkCiwjxXAlI
 7nJtSc/jZitcQtEpxRr7mZRk65I8dseogH+S7B6Q3TarrGlMCJSj3aRTDBxYem2qCAswGEZHS6L
 s3YlxeOBXTNGu9MGPIMGeWNpKLKH5aX4QsMbLoxw5zB48kHNj2hkv5V/eD1MkmoMVHGxXqKshMy
 W4i/+L6E8A==
X-Received: by 2002:a05:6512:1512:20b0:5b5:f1bc:f358 with SMTP id
 2adb3069b0e04-5b8df0c3a43mr816273e87.8.1790277218348; 
 Thu, 24 Sep 2026 12:13:38 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-52-58-67-95.eu-central-1.compute.amazonaws.com. [52.58.67.95])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8e68e4167sm10841e87.50.2026.09.24.12.13.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 12:13:36 -0700 (PDT)
From: Pavel Ivashchenko <pivashchenko@nfware.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, dsosnowski@nvidia.com, viacheslavo@nvidia.com,
 bingz@nvidia.com, orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 mb@smartsharesystems.com, andrew.rybchenko@oktetlabs.ru,
 thomas@monjalon.net, mmamatov@nfware.com,
 Pavel Ivashchenko <pivashchenko@nfware.com>
Subject: [PATCH] net/mlx5: restore fake mbuf guards on Rx replenish failure
Date: Thu, 24 Sep 2026 22:13:03 +0300
Message-ID: <20260924191303.18938-1-pivashchenko@nfware.com>
X-Mailer: git-send-email 2.50.1
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

From: Mikhail Mamatov <mmamatov@nfware.com>

Vectorized Rx keeps MLX5_VPMD_DESCS_PER_LOOP entries of elts[] pointing
to rxq->fake_mbuf after the allocated mbufs. Both rxq_cq_process_v() and
rxq_cq_decompress_v() write mbuf metadata for full SIMD groups. In
particular, CQE decompression may write through these guard entries
when processing a partial trailing group.

Both mlx5_rx_replenish_bulk_mbuf() and
mlx5_rx_mprq_replenish_bulk_mbuf() pass the guard slots directly to
rte_mempool_get_bulk(). Since a2833ecc5ea4, the mempool get path copies
available objects from the per-lcore cache to the output array before
fetching the remaining objects from the backend. If the cache contains
fewer objects than requested and the backend cannot supply the rest,
the operation restores the cache length but leaves the output array
partially overwritten.

Returning from replenishment without restoring the guards therefore
leaves them pointing to mbufs still owned by the mempool. A later
allocation can hand these mbufs to the application, after which CQE
decompression may corrupt their metadata through the stale pointers.

Restore the four fake mbuf pointers on allocation failure in both the
regular and MPRQ vector Rx paths. The producer index does not advance
on failure, so restoring the guards at the original allocation position
is sufficient. This adds work only on the allocation failure path.

Fixes: a2833ecc5ea4 ("mempool: fix get objects from mempool with cache")
Cc: stable@dpdk.org

Signed-off-by: Mikhail Mamatov <mmamatov@nfware.com>
Signed-off-by: Pavel Ivashchenko <pivashchenko@nfware.com>
---
 .mailmap                         |  1 +
 drivers/net/mlx5/mlx5_rxtx_vec.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..3b10eff3fc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1089,6 +1089,7 @@ Mike Pattrick <mkp@redhat.com>
 Mike Sowka <msowka@gmail.com>
 Mike Stolarchuk <mike.stolarchuk@bigswitch.com>
 Mike Ximing Chen <mike.ximing.chen@intel.com>
+Mikhail Mamatov <mmamatov@nfware.com>
 Mikolaj Filar <mikolajx.filar@intel.com>
 Milena Olech <milena.olech@intel.com>
 Min Cao <min.cao@intel.com>
diff --git a/drivers/net/mlx5/mlx5_rxtx_vec.c b/drivers/net/mlx5/mlx5_rxtx_vec.c
index 1b701801c5..1684f760d4 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec.c
+++ b/drivers/net/mlx5/mlx5_rxtx_vec.c
@@ -105,6 +105,15 @@ mlx5_rx_replenish_bulk_mbuf(struct mlx5_rxq_data *rxq)
 		n = RTE_MIN(n - MLX5_VPMD_DESCS_PER_LOOP, q_n - elts_idx);
 		if (rte_mempool_get_bulk(rxq->mp, (void *)elts, n) < 0) {
 			rxq->stats.rx_nombuf += n;
+			/*
+			 * A failed bulk get may have partially filled elts[]
+			 * from the cache without dequeueing those objects.
+			 * Restore the fake_mbuf guards so a following
+			 * decompression does not write into mbufs that are
+			 * still owned by the mempool (or by the application).
+			 */
+			for (i = 0; i < MLX5_VPMD_DESCS_PER_LOOP; ++i)
+				elts[i] = &rxq->fake_mbuf;
 			return;
 		}
 		if (unlikely(mlx5_mr_btree_len(&rxq->mr_ctrl.cache_bh) > 1)) {
@@ -169,6 +178,9 @@ mlx5_rx_mprq_replenish_bulk_mbuf(struct mlx5_rxq_data *rxq)
 		n = RTE_MIN(n, rxq->rq_repl_thresh);
 		if (rte_mempool_get_bulk(rxq->mp, (void *)elts, n) < 0) {
 			rxq->stats.rx_nombuf += n;
+			/* See mlx5_rx_replenish_bulk_mbuf(). */
+			for (i = 0; i < MLX5_VPMD_DESCS_PER_LOOP; ++i)
+				elts[i] = &rxq->fake_mbuf;
 			return;
 		}
 		rxq->elts_ci += n;
-- 
2.50.1 (Apple Git-155)

