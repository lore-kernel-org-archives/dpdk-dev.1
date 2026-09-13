Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2396C88E40
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Sep 2026 04:08:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 656C04027A;
	Sun, 13 Sep 2026 06:08:13 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 08CCC4021E
 for <dev@dpdk.org>; Sun, 13 Sep 2026 06:08:12 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc1so420751a12.0
 for <dev@dpdk.org>; Sat, 12 Sep 2026 21:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789272491; x=1789877291; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=elgqUVq7Ak28LIYTYKuSeC6YJx48tWwGU9jj2jNyEx0=;
 b=DpsSw/hbgTrAHm/kPpNjNEYodcnEPOd6QcaeH9LKxdxvOZDuF/qu5wkBQexE3wUpfK
 0aYiswHFQPdZ9/NdN6Igc1vrFCO+0F2ZMwVpKjySD+dWYoV+I4V6qvExdpquu24LZ5/q
 FmgmhpKgDs+1hn3+t+NWGrugeDDoJy6Al5PZhCBMRgjKd9j21SORcEIX4FjwXuikxc1A
 z1cHpLoQUm0NQM/+CLfuo4FU3gWy/6y7dr5X8mX6EnxoX+VwYQ6n7c4Ed5qKdr2XIIub
 LJx5pDvTE9zDx4NtQEeCEaOyoiQ1DF6p6YGl4BIklvuaX2Q00SRdc2JXdfYQ1URKYZwS
 a5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789272491; x=1789877291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=elgqUVq7Ak28LIYTYKuSeC6YJx48tWwGU9jj2jNyEx0=;
 b=rVLTnEUfM5PjTCcVnNhq9vzgYsf/mdN3XLlk8xJZW7tTrsiIz6Fjh/s+imFIoUiVK5
 cc3mv1KNNng9WLlGNfXhGL3G9rWOnKXj+ZD62k2Uuhywq+XvxW1pFSWa4MMnia3pCFE7
 c4ZImOjyzj8TKKS1fuU79RQKd/t0uQN2v9DRtgiQkFvAzBKotABR2FqgeUSNfL10R3rY
 STf4X+ng+MzZclhtBoWqc6FG1A7MR0MdbNSNxHLD3t7SVbY5oWeoCMgJAJ0CJOrYZ49H
 w8uUpvoZERcPZEATzZLxVn8A05YJl0ApcDwKopFdbRedFlMpq4cxDd0BY9qSSZQw27Wg
 c5xA==
X-Gm-Message-State: AFuF++lPwPQ11KfO3CtrX5aUyD6+Yb13lwVy/L6//BqqL99za3rkC4F2
 sYROb6MtY5wYss7COGn9OtyoG2mTO090q/BJzc8WNhyY5Gq7kbk6yz+B/Ii5Gx42
X-Gm-Gg: AYBFou1AqPlO9g3Up7CfUl9GJhD6YOzo7YMTPd7D4u8/X6WWnzz8Rq0O+1BqVkPTVVK
 CkuK325B+ph9rpUOVbWSVJ/Z24T2EqTXX9Jk4T9fPDg30yC48DZgAmU6niPfmSp7PiuEovqPbqr
 lY02bGukbdBI8vOKhM9aRSEb+Md3wycB3La8NZhY6GWE3b0jgadXAEsGm7iudVnpLgoJpKwbw3W
 JmAk6EXV1AUICfjee2YtbfCa+ogBtXso0IgDH9kQrchhHmPdWUOT4s1cWqA0rLsu3U+pFp+AP1s
 w82BHi+iKP0xwDlcF+kCfCDTRXHoHzBs1sAUOfOlvlJZ9PxqYBh9LXv2wOe9aSN3I9prRGEgopc
 IdI3dNRjkiaaXyoV7mFfmq5WivoEuTmKh12sZ2/pDJrcutqQb9xpxzXZ21eTT6aAhoM15w8zOAB
 7mAHissrgf6nCEmfwvbuo6ydC2lmriB0dv+Z77VH3lg9qVyhcIaFv/km6QiLKVZJEgqWjRrwp7C
 xRM97sMud+/O0KxC/RB/fmTGMS5tCRDrq7Ml3AbQGAkp6tE
X-Received: by 2002:a05:6a20:a124:b0:3cc:917f:f302 with SMTP id
 adf61e73a8af0-3db0e0ea4ecmr10599457637.9.1789272490720; 
 Sat, 12 Sep 2026 21:08:10 -0700 (PDT)
Received: from amiya73TMT9m.aristanetworks.com ([49.207.230.155])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf72dbsm18792687eec.3.2026.09.12.21.08.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 12 Sep 2026 21:08:10 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: ndabilpuram@marvell.com, jerinj@marvell.com, skori@marvell.com,
 asekhar@marvell.com, Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Subject: [PATCH] common/cnxk: fix NPA pool RANGE interrupt handling
Date: Sun, 13 Sep 2026 09:38:00 +0530
Message-Id: <20260913040800.60274-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
 drivers/common/cnxk/roc_nix_queue.c     |  5 +++
 drivers/common/cnxk/roc_npa.c           | 46 ++++++++++++++++++++++++-
 drivers/common/cnxk/roc_npa.h           |  1 +
 drivers/mempool/cnxk/cnxk_mempool_ops.c |  5 +++
 4 files changed, 56 insertions(+), 1 deletion(-)

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

