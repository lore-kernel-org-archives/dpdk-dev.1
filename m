Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31468C88E56
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Sep 2026 07:04:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B9464029D;
	Sun, 13 Sep 2026 09:04:45 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 3B93B4027A
 for <dev@dpdk.org>; Sun, 13 Sep 2026 09:04:44 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb4so809349a91.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 00:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789283083; x=1789887883; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b+hcjxrlX4SWGZiqznNwbDw3QIVpXdwITzadbXFa5/4=;
 b=UR8ZdVb6wx86KVasvF6y+YvungIcW7PZGQIE1p5LXfYoukjOnqyjxVrxm1M1WP+YkO
 nZcRDsPC47CFT7ePpEJ2xduA/vUbTVEb1bA4c88lEq+xmONiNm1vDSM0r6Sgto7dPDoQ
 4lMVH8nLPw3MihewOh1SA2kuPESZUUhTHFbNGOHR8I/Rvi07fOayZ/VE5N6jtHi3d4nb
 kPujMnfc+A1BNpV+iUGitf2EpXgBYAN4k2hls3K3iHs92r+crxbI7cYI6xyG+feZtUxc
 2dHuuEdDgUOQ8ulmePHrwub+YxRZVGex2M7Eaxkio7dVqz0WcDnnrEzLGVCheE7vZ2G0
 GsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789283083; x=1789887883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b+hcjxrlX4SWGZiqznNwbDw3QIVpXdwITzadbXFa5/4=;
 b=H00578CsebSpVl0yhEVccKzZd40PciD02KPmLkf/yiiCK6Ew8Uh0eaHpLAyeViigFo
 bxUvKtCnasKiBsdFzXLTaY7K640vesLkrKTR2q0fhaAiOdCeo8/IvU19R6wsuXedpq4p
 Qtih7+ShRqAE36EnYlCugjXkY/26iihMS9dv6AENihOuBOgR7OqUWaP0bASigs6sP/9e
 RdhUfkRKr8pm0fM9B7Ogw9Uc4sUfBwOJQ0xWP8oaT38nn527NJ3BSRitLuWUBIHr6Utn
 H6IDf2ebA0OEP+88oXY1B7ZOcJ1X8RVT3bguTf6QP65dLSCPxABXEZwoMhQElEDbeR7N
 C9Xw==
X-Gm-Message-State: AFuF++mAG5ogT8/wE1md4byI7oZ9OFvf/tsj2Y0dFfi1LnA5OL9KI1xD
 zNW3/zdO9q92s23S0U9YjT7q8CQ25VAiw6Uz9C+5Ty7fmpDx7fnQKQQCMUS895RA
X-Gm-Gg: AYBFou3re8CEVSCMqXUMdv1n/MNBBTeY/CTGu4j1kTxTwsHWHyk946wj/8lcHt1vGQX
 klQM2KXF6X0LrnBgk+qkRDCWN8ILQxlo0cQ9IVkLb0KBSlkTSupWg5XSRblRm05HTp96lYza6pb
 rvn2a0GO771ZnkgOCeKbyhVUlXgsZQCThD714L4oha1ro+sfrdUWO+GL2grUGWg9kv0PgAy1ReO
 uJmG+c61qdeedp5ziPsrvkcgiUfHjWfQf3ftLUvc59sygV5ntZX5yEdLDjGzsb/RXIqe0dpMBNH
 rJBCxG74qjKSpa+Ehx5DuMNEtouRyxi1db7mNM3MG2QlPVZeUfTG3kn9mzHLuqtEGV06t69R+8a
 4YYUAUQ3j/Yp4mHT6TlI4s1HFJ/iI2JHvORKrZKa3QoJvcCtDdn/+j2kh6NEMoE/9hsCMsIuBwo
 o3E4GDu7sGcAMfmDvlQ/kibG+qLA1v02H8YJ8aTlBOYXSiCWzfj6k3bJsOVznbVV01HGPFL914d
 xvoxny477Yf6mdqhWZKZcqCxtGPFuvYI0ZY8NXiSTw6rWjs2Q==
X-Received: by 2002:a17:90b:5243:b0:398:c724:1bb1 with SMTP id
 98e67ed59e1d1-39dbc0c3777mr11868661a91.8.1789283082961; 
 Sun, 13 Sep 2026 00:04:42 -0700 (PDT)
Received: from amiya73TMT9m.aristanetworks.com ([49.207.230.155])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e51449sm15630535eec.5.2026.09.13.00.04.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 13 Sep 2026 00:04:42 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: ndabilpuram@marvell.com, jerinj@marvell.com, skori@marvell.com,
 asekhar@marvell.com, Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Subject: [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt handling
Date: Sun, 13 Sep 2026 12:34:28 +0530
Message-Id: <20260913070428.66628-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260913040800.60274-1-amiyaranjan.mohakud@gmail.com>
References: <20260913040800.60274-1-amiyaranjan.mohakud@gmail.com>
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

NPA_POOL_ERR_INT_RANGE fires spuriously between pool creation
(ptr_start/ptr_end default to 0/~0) and the actual range install
via roc_npa_pool_op_range_set().  On CN10K this drains the pool
stack and makes the pool unusable.

Fix by masking NPA_POOL_ERR_INT_RANGE at pool creation time, then
re-enabling it (along with OVFLS and PERR) after the valid range
is installed.  Add roc_npa_pool_range_int_enable() for this and
call it from both cnxk_mempool_populate() (regular mempools) and
sqb_pool_populate() (NIX SQ buffer pools).

Fixes: f765f5611240 ("common/cnxk: add NPA pool HW operations")
Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/common/cnxk/roc_nix_queue.c           |  5 ++
 drivers/common/cnxk/roc_npa.c                 | 46 ++++++++++++++++++-
 drivers/common/cnxk/roc_npa.h                 |  1 +
 .../common/cnxk/roc_platform_base_symbols.c   |  1 +
 drivers/mempool/cnxk/cnxk_mempool_ops.c       |  5 ++
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index 075c9c1591..879cb217c0 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -1666,6 +1666,11 @@ sqb_pool_populate(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
 	}
 
 	roc_npa_pool_op_range_set(sq->aura_handle, (uint64_t)sq->sqe_mem, iova);
+
+	rc = roc_npa_pool_range_int_enable(sq->aura_handle);
+	if (rc)
+		goto npa_fail;
+
 	roc_npa_aura_limit_modify(sq->aura_handle, nb_sqb_bufs);
 	sq->aura_sqb_bufs = nb_sqb_bufs;
 
diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index 4a3e96a97a..6209f1676b 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -738,7 +738,12 @@ npa_aura_pool_pair_alloc(struct npa_lf *lf, const uint32_t block_size,
 	pool->ptr_end = ~0;
 	pool->stack_caching = 1;
 	pool->err_int_ena = BIT(NPA_POOL_ERR_INT_OVFLS);
-	pool->err_int_ena |= BIT(NPA_POOL_ERR_INT_RANGE);
+	/* NPA_POOL_ERR_INT_RANGE omitted: ptr_start/ptr_end are initialized to
+	 * 0/~0 and the actual IOVA range is set later via roc_npa_pool_op_range_set().
+	 * On CN10K the RANGE interrupt fires spuriously in the window between pool
+	 * creation and the range update, causing pool stack drain.  Mask it here
+	 * and rely on the range being set correctly before any alloc/free.
+	 */
 	pool->err_int_ena |= BIT(NPA_POOL_ERR_INT_PERR);
 	pool->avg_con = 0;
 
@@ -1171,6 +1176,45 @@ roc_npa_aura_destroy(uint64_t aura_handle)
 	return rc;
 }
 
+int
+roc_npa_pool_range_int_enable(uint64_t aura_handle)
+{
+	struct npa_cn20k_aq_enq_req *pool_req_cn20k;
+	struct npa_aq_enq_req *pool_req;
+	struct npa_lf *lf;
+	struct mbox *mbox;
+	int rc;
+
+	lf = idev_npa_obj_get();
+	if (lf == NULL)
+		return NPA_ERR_DEVICE_NOT_BOUNDED;
+
+	mbox = mbox_get(lf->mbox);
+	if (roc_model_is_cn20k()) {
+		pool_req_cn20k = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
+		pool_req = (struct npa_aq_enq_req *)pool_req_cn20k;
+	} else {
+		pool_req = mbox_alloc_msg_npa_aq_enq(mbox);
+	}
+	if (pool_req == NULL) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+
+	pool_req->aura_id = roc_npa_aura_handle_to_aura(aura_handle);
+	pool_req->ctype = NPA_AQ_CTYPE_POOL;
+	pool_req->op = NPA_AQ_INSTOP_WRITE;
+	pool_req->pool.err_int_ena = BIT(NPA_POOL_ERR_INT_OVFLS) |
+				     BIT(NPA_POOL_ERR_INT_RANGE) |
+				     BIT(NPA_POOL_ERR_INT_PERR);
+	pool_req->pool_mask.err_int_ena = ~pool_req->pool_mask.err_int_ena;
+
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 int
 roc_npa_pool_range_update_check(uint64_t aura_handle)
 {
diff --git a/drivers/common/cnxk/roc_npa.h b/drivers/common/cnxk/roc_npa.h
index db610cbd2c..8555765db8 100644
--- a/drivers/common/cnxk/roc_npa.h
+++ b/drivers/common/cnxk/roc_npa.h
@@ -852,6 +852,7 @@ int __roc_api roc_npa_aura_limit_modify(uint64_t aura_handle,
 					uint16_t aura_limit);
 int __roc_api roc_npa_pool_destroy(uint64_t aura_handle);
 int __roc_api roc_npa_pool_range_update_check(uint64_t aura_handle);
+int __roc_api roc_npa_pool_range_int_enable(uint64_t aura_handle);
 void __roc_api roc_npa_aura_op_range_set(uint64_t aura_handle,
 					 uint64_t start_iova,
 					 uint64_t end_iova);
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 063cb21aae..1a4fb11286 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -447,6 +447,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_create)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_limit_modify)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_destroy)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_range_int_enable)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_range_update_check)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_zero_aura_handle)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_bp_configure)
diff --git a/drivers/mempool/cnxk/cnxk_mempool_ops.c b/drivers/mempool/cnxk/cnxk_mempool_ops.c
index 01b6247fbb..7e81f4347d 100644
--- a/drivers/mempool/cnxk/cnxk_mempool_ops.c
+++ b/drivers/mempool/cnxk/cnxk_mempool_ops.c
@@ -2,6 +2,7 @@
  * Copyright(C) 2021 Marvell.
  */
 
+#include <rte_eal.h>
 #include <rte_mbuf_pool_ops.h>
 #include <rte_mempool.h>
 
@@ -180,6 +181,10 @@ cnxk_mempool_populate(struct rte_mempool *mp, unsigned int max_objs,
 	if (roc_npa_pool_range_update_check(mp->pool_id) < 0)
 		return -EBUSY;
 
+	if (rte_eal_iova_mode() == RTE_IOVA_VA &&
+	    roc_npa_pool_range_int_enable(mp->pool_id) < 0)
+		return -EBUSY;
+
 	return rte_mempool_op_populate_helper(
 		mp, RTE_MEMPOOL_POPULATE_F_ALIGN_OBJ, max_objs, vaddr, iova,
 		len, obj_cb, obj_cb_arg);
-- 
2.39.5 (Apple Git-154)

