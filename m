Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4481C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:24:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1034C40697;
	Thu, 20 Aug 2026 07:24:01 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 469704067C
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:59 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2caea3f742bso26248865ad.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203438;
 x=1787808238; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rbFU7ITdxdSOr7PlTvO2l1RAHGdWybsZOg/jDZhr7ak=;
 b=vk33dGjx6zwx34CVzxTtnzVqVXNwSPXc9KpVpOUoTPwGsRLYeMAS2j5rqvX1XWf9HT
 ge6WO7RKzggsOGEM1x98scY1hrWCXczJdLSDpU1DGYEO9KMrD8X/W7Cd21i2GpDjOED+
 JdXqipky4nVtaTa8HBagnj3iATHPcLDUNDjeZij68G/69SI6CzuCD/v5KtNvX+awCZdz
 JHef76F+1hq7Vk1Pi2gESoDt/Lm3RT/YdeVbz/7Xs/0LY6iz8e315NK9amkOrSM3IewQ
 KYTEXLNQ2yLxzPdVjH0a+MUM3EKJCoO2G2JfLzUcbkOptO2Ls4nlzjDwYDLB6tIKlkk0
 //Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203438; x=1787808238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rbFU7ITdxdSOr7PlTvO2l1RAHGdWybsZOg/jDZhr7ak=;
 b=VjeqaMvHtfPHEgDP5kUCAKwIceJPq3qFKhFVl9Ukpzjjgvzj7+EI2OCvQ1NHPsgTT9
 4SUpgdoPDH42egprgrDLyJls3xGT50UXzMC68aJC3sNc6dmRxz5cw7VNzXVIMLLJkWtn
 JwDKYxR7qzwEjGQVc6FLios4d5KsNBCH0S1Ehs4cagtna4WZVoy68hZM2JMMLKL01xQw
 Sj02UHx+I8RyPxHmIaWsx5Eq1EnobFsLkPA6q2r0ckzkYpMEyJ6Ju189564pN1iaEKMS
 kmjDN6rQ6lybCF7LbOaANFOH70JRKT8xZ/GtkYEnkgG16n0xsoxBURRIq0ZDNF0qB4Gn
 Uzuw==
X-Gm-Message-State: AFuF++lHrehu88SVKEbhhXbNlTFS6oRcd9ZP+nrFQaY1x5xXe2T8Tmkr
 /N8/NLzWFko4TXNB5Xx0jlDzYJmK1c7rTVU96IA5tSYNORNBknAdeZUrPfkFzhqtWhsspyyDcNV
 eGN4v
X-Gm-Gg: AR+sD10TRRzP4ctz4Ax8Oss2Cbvz9wk7Be50ie7nrNP7Nsr/4x8oKu7kThB5QfbQSZs
 +JCku4siMMLfPvnphvq5tAD4EMbfd/GIUN5+r9lVnASeuZn5G8qtoG5OUsh5zPcqq/6MJEugsG7
 +JAdVmE9BEv6QgQBIoC79An5I+U/9X8P/JZfPziarKsA7WrutcSYVeylI92Z4jFcPKhJbFsuf9e
 hvnPo35NCfkj8Ji0+9HcBv+/peGqIFmzFxuhwVhrmtHiqDgpz47zZdw4RSzHNyYMb73LmD73gsw
 ZrJIldpKDW4mMLVXOpnYMvI2Cacbbdnix+HyaODi8qM8nFereCNV5XWL+ywlQSU9zBLUZnkW1Zo
 coFfib33BEnYgq/Oueu4CimDwoR++60OpMmC8n6mbwJKkOR1zmbFsmVlcT8OAZiSHR8KjrR2Kic
 rwlfCyBcZdIn7qcT8zEHWKakrPMMTkUU5ml21UwswTB48PZkKQzueEoT/LnjWgOXVepTAy2tjwC
 vUFSUAEovRWHFf7AoHAp9/6n2Q=
X-Received: by 2002:a17:90b:3c06:b0:38e:8300:af51 with SMTP id
 98e67ed59e1d1-39580edaf9fmr20222585a91.8.1787203438313; 
 Wed, 19 Aug 2026 22:23:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>,
 Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, Kai Ji <kai.ji@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Matan Azrad <matan@nvidia.com>, Chengfei Han <han.chengfei@zte.com.cn>,
 Ming Ran <ran.ming@zte.com.cn>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 14/61] cryptodev: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:04 -0700
Message-ID: <20260820052251.1453273-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Using regular memcpy is as fast and safer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/ccp/ccp_crypto.c                    | 14 +++++---------
 drivers/crypto/cnxk/cnxk_se.h                      |  2 +-
 drivers/crypto/ipsec_mb/pmd_snow3g.c               |  4 ++--
 drivers/crypto/mlx5/mlx5_crypto_gcm.c              | 10 +++++-----
 drivers/crypto/scheduler/rte_cryptodev_scheduler.c |  6 +++---
 drivers/crypto/scheduler/scheduler_failover.c      | 12 ++++++------
 drivers/crypto/zsda/zsda_crypto_session.c          |  6 +++---
 lib/cryptodev/rte_cryptodev.c                      | 12 ++++--------
 8 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/crypto/ccp/ccp_crypto.c b/drivers/crypto/ccp/ccp_crypto.c
index b07a786d8e..e754dd16dc 100644
--- a/drivers/crypto/ccp/ccp_crypto.c
+++ b/drivers/crypto/ccp/ccp_crypto.c
@@ -168,7 +168,7 @@ static int partial_hash_sha1(uint8_t *data_in, uint8_t *data_out)
 	if (!SHA1_Init(&ctx))
 		return -EFAULT;
 	SHA1_Transform(&ctx, data_in);
-	rte_memcpy(data_out, &ctx, SHA_DIGEST_LENGTH);
+	memcpy(data_out, &ctx, SHA_DIGEST_LENGTH);
 	return 0;
 }
 
@@ -179,8 +179,7 @@ static int partial_hash_sha224(uint8_t *data_in, uint8_t *data_out)
 	if (!SHA224_Init(&ctx))
 		return -EFAULT;
 	SHA256_Transform(&ctx, data_in);
-	rte_memcpy(data_out, &ctx,
-		   SHA256_DIGEST_LENGTH);
+	memcpy(data_out, &ctx, SHA256_DIGEST_LENGTH);
 	return 0;
 }
 
@@ -191,8 +190,7 @@ static int partial_hash_sha256(uint8_t *data_in, uint8_t *data_out)
 	if (!SHA256_Init(&ctx))
 		return -EFAULT;
 	SHA256_Transform(&ctx, data_in);
-	rte_memcpy(data_out, &ctx,
-		   SHA256_DIGEST_LENGTH);
+	memcpy(data_out, &ctx, SHA256_DIGEST_LENGTH);
 	return 0;
 }
 
@@ -203,8 +201,7 @@ static int partial_hash_sha384(uint8_t *data_in, uint8_t *data_out)
 	if (!SHA384_Init(&ctx))
 		return -EFAULT;
 	SHA512_Transform(&ctx, data_in);
-	rte_memcpy(data_out, &ctx,
-		   SHA512_DIGEST_LENGTH);
+	memcpy(data_out, &ctx, SHA512_DIGEST_LENGTH);
 	return 0;
 }
 
@@ -215,8 +212,7 @@ static int partial_hash_sha512(uint8_t *data_in, uint8_t *data_out)
 	if (!SHA512_Init(&ctx))
 		return -EFAULT;
 	SHA512_Transform(&ctx, data_in);
-	rte_memcpy(data_out, &ctx,
-		   SHA512_DIGEST_LENGTH);
+	memcpy(data_out, &ctx, SHA512_DIGEST_LENGTH);
 	return 0;
 }
 
diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index 505a5fcd37..cf26373828 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -1252,7 +1252,7 @@ cpt_sm_prep(uint32_t flags, uint64_t d_offs, uint64_t d_lens, struct roc_se_fc_p
 			void *dst = PLT_PTR_ADD(offset_vaddr, ROC_SE_OFF_CTRL_LEN);
 			const uint64_t *src = fc_params->iv_buf;
 
-			rte_memcpy(dst, src, 16);
+			memcpy(dst, src, 16);
 		}
 		inst->w4.u64 = cpt_inst_w4.u64;
 	} else {
diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index 35fe23c157..6e84e34dc3 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -292,8 +292,8 @@ process_snow3g_hash_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 
 			/* Copy back digest from src to auth.digest.data */
 			if (digest_appended)
-				rte_memcpy(ops[i]->sym->auth.digest.data,
-					dst, SNOW3G_DIGEST_LENGTH);
+				memcpy(ops[i]->sym->auth.digest.data, dst,
+				       SNOW3G_DIGEST_LENGTH);
 		}
 		processed_ops++;
 	}
diff --git a/drivers/crypto/mlx5/mlx5_crypto_gcm.c b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
index 1a2600655a..77a0e14715 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_gcm.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
@@ -1061,9 +1061,9 @@ mlx5_crypto_gcm_ipsec_enqueue_burst(void *queue_pair,
 		 * shrink AAD before payload. First backup the mem,
 		 * then do shrink.
 		 */
-		rte_memcpy(&qp->ipsec_mem[idx],
-			   RTE_PTR_SUB(payload, MLX5_CRYPTO_GCM_IPSEC_IV_SIZE),
-			   MLX5_CRYPTO_GCM_IPSEC_IV_SIZE);
+		memcpy(&qp->ipsec_mem[idx],
+		       RTE_PTR_SUB(payload, MLX5_CRYPTO_GCM_IPSEC_IV_SIZE),
+		       MLX5_CRYPTO_GCM_IPSEC_IV_SIZE);
 		/* If no memory overlap, do copy directly, otherwise memmove. */
 		if (likely(pkt_iv_len >= sess->aad_len))
 			rte_memcpy(gcm_data.src_addr, op->sym->aead.aad.data, sess->aad_len);
@@ -1107,8 +1107,8 @@ mlx5_crypto_gcm_restore_ipsec_mem(struct mlx5_crypto_qp *qp,
 		if (unlikely(sess->aad_len > MLX5_CRYPTO_GCM_IPSEC_IV_SIZE))
 			memmove(op->sym->aead.aad.data,
 				RTE_PTR_SUB(payload, sess->aad_len), sess->aad_len);
-		rte_memcpy(RTE_PTR_SUB(payload, MLX5_CRYPTO_GCM_IPSEC_IV_SIZE),
-			   &qp->ipsec_mem[idx], MLX5_CRYPTO_GCM_IPSEC_IV_SIZE);
+		memcpy(RTE_PTR_SUB(payload, MLX5_CRYPTO_GCM_IPSEC_IV_SIZE),
+		       &qp->ipsec_mem[idx], MLX5_CRYPTO_GCM_IPSEC_IV_SIZE);
 		m_dst = op->sym->m_dst;
 		if (m_dst && m_dst != m_src) {
 			uint32_t bytes_to_copy;
diff --git a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
index 1ca8443431..95e4a69913 100644
--- a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
+++ b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
@@ -80,7 +80,7 @@ sync_caps(struct rte_cryptodev_capabilities *caps,
 
 		/* remove a uncommon cap from the array */
 		for (j = i; j < sync_nb_caps - 1; j++)
-			rte_memcpy(&caps[j], &caps[j+1], sizeof(*cap));
+			memcpy(&caps[j], &caps[j + 1], sizeof(*cap));
 
 		memset(&caps[sync_nb_caps - 1], 0, sizeof(*cap));
 		sync_nb_caps--;
@@ -217,8 +217,8 @@ sync_sec_caps(uint32_t worker_idx,
 		 * caps, from the arrays
 		 */
 		for (j = i; j < nb_sec_caps - 1; j++) {
-			rte_memcpy(&sec_caps[j], &sec_caps[j+1],
-					sizeof(*sec_cap));
+			memcpy(&sec_caps[j], &sec_caps[j + 1],
+			       sizeof(*sec_cap));
 
 			rte_memcpy(&sec_crypto_caps[j][0],
 					&sec_crypto_caps[j+1][0],
diff --git a/drivers/crypto/scheduler/scheduler_failover.c b/drivers/crypto/scheduler/scheduler_failover.c
index 52ff2ffbb7..e7c6d19d25 100644
--- a/drivers/crypto/scheduler/scheduler_failover.c
+++ b/drivers/crypto/scheduler/scheduler_failover.c
@@ -171,12 +171,12 @@ scheduler_start(struct rte_cryptodev *dev)
 		sched_ctx->workers[PRIMARY_WORKER_IDX].qp_id = i;
 		sched_ctx->workers[SECONDARY_WORKER_IDX].qp_id = i;
 
-		rte_memcpy(&qp_ctx->primary_worker,
-				&sched_ctx->workers[PRIMARY_WORKER_IDX],
-				sizeof(struct scheduler_worker));
-		rte_memcpy(&qp_ctx->secondary_worker,
-				&sched_ctx->workers[SECONDARY_WORKER_IDX],
-				sizeof(struct scheduler_worker));
+		memcpy(&qp_ctx->primary_worker,
+		       &sched_ctx->workers[PRIMARY_WORKER_IDX],
+		       sizeof(struct scheduler_worker));
+		memcpy(&qp_ctx->secondary_worker,
+		       &sched_ctx->workers[SECONDARY_WORKER_IDX],
+		       sizeof(struct scheduler_worker));
 	}
 
 	return 0;
diff --git a/drivers/crypto/zsda/zsda_crypto_session.c b/drivers/crypto/zsda/zsda_crypto_session.c
index 5087ae248a..c01141dd94 100644
--- a/drivers/crypto/zsda/zsda_crypto_session.c
+++ b/drivers/crypto/zsda/zsda_crypto_session.c
@@ -178,7 +178,7 @@ u32_to_u8(uint32_t *u_int32_t_data, uint8_t *u8_data)
 {
 	uint32_t be_data = rte_cpu_to_be_32(*u_int32_t_data);
 
-	rte_memcpy(u8_data, &be_data, sizeof(be_data));
+	memcpy(u8_data, &be_data, sizeof(be_data));
 }
 
 static void
@@ -283,8 +283,8 @@ zsda_decry_key_set(uint8_t key[64], const uint8_t *key1_ptr, uint8_t skey_len,
 				    : ZSDA_AES512_ROUND_NUM;
 		zsda_aes_key_expansion(aes_round_key, round_num, key1_ptr,
 				       skey_len);
-		rte_memcpy(dec_key1,
-			   ((uint8_t *)aes_round_key + (16 * round_num)), 16);
+		memcpy(dec_key1,
+		       ((uint8_t *)aes_round_key + (16 * round_num)), 16);
 
 		if (skey_len == ZSDA_SYM_XTS_512_SKEY_LEN &&
 			(16 * round_num) <= ZSDA_AES_MAX_EXP_BYTE_SIZE) {
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index 829a5d0846..cdbaf54e1e 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -16,7 +16,6 @@
 #include <rte_debug.h>
 #include <dev_driver.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_memzone.h>
 #include <rte_eal.h>
 #include <rte_common.h>
@@ -2566,8 +2565,7 @@ rte_cryptodev_sym_session_set_user_data(void *_sess, void *data,
 	if (sess->user_data_sz < size)
 		return -ENOMEM;
 
-	rte_memcpy(sess->driver_priv_data + sess->sess_data_sz, data, size);
-
+	memcpy(sess->driver_priv_data + sess->sess_data_sz, data, size);
 	rte_cryptodev_trace_sym_session_set_user_data(sess, data, size);
 
 	return 0;
@@ -2601,9 +2599,7 @@ rte_cryptodev_asym_session_set_user_data(void *session, void *data, uint16_t siz
 	if (sess->user_data_sz < size)
 		return -ENOMEM;
 
-	rte_memcpy(sess->sess_private_data +
-			sess->max_priv_data_sz,
-			data, size);
+	memcpy(sess->sess_private_data + sess->max_priv_data_sz, data, size);
 
 	rte_cryptodev_trace_asym_session_set_user_data(sess, data, size);
 
@@ -2750,7 +2746,7 @@ rte_cryptodev_session_event_mdata_set(uint8_t dev_id, void *sess,
 			if (s->event_mdata == NULL)
 				return -ENOMEM;
 		}
-		rte_memcpy(s->event_mdata, ev_mdata, size);
+		memcpy(s->event_mdata, ev_mdata, size);
 
 		return 0;
 	} else
@@ -3098,7 +3094,7 @@ crypto_caps_array(struct rte_tel_data *d,
 	while ((dev_caps = &capabilities[i++])->op !=
 			RTE_CRYPTO_OP_TYPE_UNDEFINED) {
 		memset(&caps_val, 0, CRYPTO_CAPS_SZ * sizeof(caps_val[0]));
-		rte_memcpy(caps_val, dev_caps, sizeof(capabilities[0]));
+		memcpy(caps_val, dev_caps, sizeof(capabilities[0]));
 		for (j = 0; j < CRYPTO_CAPS_SZ; j++)
 			rte_tel_data_add_array_uint(d, caps_val[j]);
 	}
-- 
2.53.0

