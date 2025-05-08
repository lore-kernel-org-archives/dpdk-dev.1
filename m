Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19DFC3ABC0
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 07:51:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A59E402B3;
	Thu,  8 May 2025 09:51:53 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id C65EE4027C
 for <dev@dpdk.org>; Thu,  8 May 2025 09:51:50 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-22e8e4423ecso6637425ad.0
 for <dev@dpdk.org>; Thu, 08 May 2025 00:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746690710; x=1747295510; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hjse1/Ovf7qx80hLutBpllZFO/d7TrKr1ZCHr3acrAs=;
 b=GJLZt/koElyuKD4YTb3f9AU3Xu92gWC8ECvyKTjrWBxD3p5EfJQProvm/CXiHHuSEV
 w+b2zYydZv9g7Q/ziV5VD5BhWTdI/C8E7Wp0m2KamNoM2vmBwhMYFtritW8eOibGIfhK
 Y4zqzZ/fZVt8k/y6Gh8Vcn7gC586FxBXQH8UwWEPeyXEYbFF36QPrhuTubAF1CT4cWM/
 7oExbqVEeoT3H+QZ9ATCdXodYd+6m3kf5Ia2JbGwsoCabsF913zi/1AQhEYRGRdgylzS
 66xy1hgVbaJmiuLndDVcL7sa3PeYoCF/sWxtraIYBVEmrWGU6DOn+eHpiUeDBwyerxB1
 gwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746690710; x=1747295510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hjse1/Ovf7qx80hLutBpllZFO/d7TrKr1ZCHr3acrAs=;
 b=V5Qc4r9jDYt0SA/Rcbq7Hkw/dLQC+NPaZ+T9pElg7catNaf7+LXPPBXeJpQbK9UJSg
 JecMbKTelBaZQXgxrYeWSvTRIjQ4sZbigW+W0TD6u8GUp293Ddvm+sdD6nEQDwdx8MVa
 MVUW/YSGFH3SEHt2b6rbaajPR4Yt1OsQ9QX5ATNAVdZmeEtTnVw5ff7nqo4JISlnYsu7
 kB/7To+3OoHPzlm64QO8pd6gexg38wRLEv9Lu5UoxHEQYOFrm8qWNIrhq1HASyjCEW8p
 g12Q0AXRHLkyixUMqxP/x6xvy7krIWj57UzV+F6jSnNlt9cgejT7SRRqb5w4hqU69I9I
 B0gw==
X-Gm-Message-State: AOJu0YyH7n868NqhTi+3PXtitJpAaSL3tH028vEFyyIiLTJ8MlLppaDG
 3sFiKSGCH60rinmbLiPjGPV5Os+NkicglBI3WsAGFCMR+nl1RqSuoX/ir2PCRek=
X-Gm-Gg: ASbGnct5HqTxK3BmvMF7OZmYMMPY2azbd5eZRNOiq0lsFdjv2FwZC6Ks/S2mqlmGQyr
 onuX6zIlbqPvcNS8AgKmnllQFCI48pQcNBuaLRfyf/yR5d4GOJaqEpVHNmLG1FaawLeJaicgRrz
 PiwWUGZrci4tQsToxwnXusi9jkmOoXt7XbbILzJTwkLOAWBHM2bXbladMX95CtZvERLTu/5ONn1
 513PKtOXocjK1Ih5fZR15gxD6MJWlLE9bJPeaCKBSOxm1qHGa86rTXOfGTs6S+5fYfYGcczmBDM
 tN8rLWofyN9BYDxqo2R4gmUf5Qy7T/YLWtdorM6Zfg==
X-Google-Smtp-Source: AGHT+IFhFWqGx1o/5lWquY0pkmB7D/gabjewr0juSmbjVQR0zylQ/mu1WUD5QNqDVizSZONYidZIQw==
X-Received: by 2002:a17:902:d510:b0:223:669f:ca2d with SMTP id
 d9443c01a7336-22e865f7877mr38748775ad.35.1746690709739; 
 Thu, 08 May 2025 00:51:49 -0700 (PDT)
Received: from gmail.com ([121.37.54.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4f55825sm1504542a91.31.2025.05.08.00.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:51:49 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>
Cc: dev@dpdk.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 2/2] crypto/uadk: use async mode to replace sync mode
Date: Thu,  8 May 2025 07:41:19 +0000
Message-Id: <20250508074119.356011-3-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508074119.356011-1-zhangfei.gao@linaro.org>
References: <20250508074119.356011-1-zhangfei.gao@linaro.org>
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

To get better performance, using async mode to replace sync mode

However, case UADK_CHAIN_CIPHER_AUTH and UADK_CHAIN_AUTH_CIPHER
still use sync mode for the first operation and async mode for
the second operation since the dependence.

Also RTE_CRYPTO_AUTH_OP_VERIFY will hold the generated auth in
qp->temp_digest[idx % BURST_MAX] to verify later.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/crypto/uadk/uadk_crypto_pmd.c         | 321 +++++++++++++-----
 drivers/crypto/uadk/uadk_crypto_pmd_private.h |   8 +-
 2 files changed, 236 insertions(+), 93 deletions(-)

diff --git a/drivers/crypto/uadk/uadk_crypto_pmd.c b/drivers/crypto/uadk/uadk_crypto_pmd.c
index e4b1a32398..bbbc96231e 100644
--- a/drivers/crypto/uadk/uadk_crypto_pmd.c
+++ b/drivers/crypto/uadk/uadk_crypto_pmd.c
@@ -15,6 +15,9 @@
 
 #include "uadk_crypto_pmd_private.h"
 
+#define MAX_ALG_NAME 64
+#define UADK_CIPHER_DEF_CTXS    2
+
 static uint8_t uadk_cryptodev_driver_id;
 
 static const struct rte_cryptodev_capabilities uadk_crypto_v2_capabilities[] = {
@@ -359,12 +362,10 @@ static int
 uadk_crypto_pmd_config(struct rte_cryptodev *dev __rte_unused,
 		       struct rte_cryptodev_config *config)
 {
-	char env[128];
+	struct uadk_crypto_priv *priv = dev->data->dev_private;
 
-	/* set queue pairs num via env */
-	sprintf(env, "sync:%d@0", config->nb_queue_pairs);
-	setenv("WD_CIPHER_CTX_NUM", env, 1);
-	setenv("WD_DIGEST_CTX_NUM", env, 1);
+	if (config->nb_queue_pairs != 0)
+		priv->nb_qpairs = config->nb_queue_pairs;
 
 	return 0;
 }
@@ -388,14 +389,14 @@ uadk_crypto_pmd_close(struct rte_cryptodev *dev)
 {
 	struct uadk_crypto_priv *priv = dev->data->dev_private;
 
-	if (priv->env_cipher_init) {
-		wd_cipher_env_uninit();
-		priv->env_cipher_init = false;
+	if (priv->cipher_init) {
+		wd_cipher_uninit2();
+		priv->cipher_init = false;
 	}
 
-	if (priv->env_auth_init) {
-		wd_digest_env_uninit();
-		priv->env_auth_init = false;
+	if (priv->auth_init) {
+		wd_digest_uninit2();
+		priv->auth_init = false;
 	}
 
 	return 0;
@@ -584,15 +585,11 @@ uadk_set_session_cipher_parameters(struct rte_cryptodev *dev,
 	struct rte_crypto_cipher_xform *cipher = &xform->cipher;
 	struct wd_cipher_sess_setup setup = {0};
 	struct sched_params params = {0};
+	struct wd_ctx_params cparams = {0};
+	struct wd_ctx_nums *ctx_set_num;
+	char alg_name[MAX_ALG_NAME];
 	int ret;
 
-	if (!priv->env_cipher_init) {
-		ret = wd_cipher_env_init(NULL);
-		if (ret < 0)
-			return -EINVAL;
-		priv->env_cipher_init = true;
-	}
-
 	sess->cipher.direction = cipher->op;
 	sess->iv.offset = cipher->iv.offset;
 	sess->iv.length = cipher->iv.length;
@@ -603,15 +600,18 @@ uadk_set_session_cipher_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_CIPHER_AES;
 		setup.mode = WD_CIPHER_CTR;
 		sess->cipher.req.out_bytes = 64;
+		rte_strscpy(alg_name, "ctr(aes)", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_CIPHER_AES_ECB:
 		setup.alg = WD_CIPHER_AES;
 		setup.mode = WD_CIPHER_ECB;
 		sess->cipher.req.out_bytes = 16;
+		rte_strscpy(alg_name, "ecb(aes)", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_CIPHER_AES_CBC:
 		setup.alg = WD_CIPHER_AES;
 		setup.mode = WD_CIPHER_CBC;
+		rte_strscpy(alg_name, "cbc(aes)", sizeof(alg_name));
 		if (cipher->key.length == 16)
 			sess->cipher.req.out_bytes = 16;
 		else
@@ -620,14 +620,45 @@ uadk_set_session_cipher_parameters(struct rte_cryptodev *dev,
 	case RTE_CRYPTO_CIPHER_AES_XTS:
 		setup.alg = WD_CIPHER_AES;
 		setup.mode = WD_CIPHER_XTS;
+		rte_strscpy(alg_name, "xts(aes)", sizeof(alg_name));
 		if (cipher->key.length == 16)
 			sess->cipher.req.out_bytes = 32;
 		else
 			sess->cipher.req.out_bytes = 512;
 		break;
 	default:
-		ret = -ENOTSUP;
-		goto env_uninit;
+		return -ENOTSUP;
+	}
+
+	if (!priv->cipher_init) {
+		ctx_set_num = calloc(1, sizeof(*ctx_set_num));
+		if (!ctx_set_num) {
+			UADK_LOG(ERR, "failed to alloc ctx_set_size!");
+			return -WD_ENOMEM;
+		}
+
+		cparams.op_type_num = 1;
+		cparams.ctx_set_num = ctx_set_num;
+		cparams.bmp = numa_allocate_nodemask();
+		if (!cparams.bmp) {
+			UADK_LOG(ERR, "failed to create nodemask!");
+			ret = -WD_ENOMEM;
+			goto out_freectx;
+		}
+
+		numa_bitmask_setall(cparams.bmp);
+		ctx_set_num->sync_ctx_num = priv->nb_qpairs;
+		ctx_set_num->async_ctx_num = priv->nb_qpairs;
+
+		ret = wd_cipher_init2_(alg_name, SCHED_POLICY_RR, TASK_HW, &cparams);
+		numa_free_nodemask(cparams.bmp);
+		free(ctx_set_num);
+
+		if (ret) {
+			UADK_LOG(ERR, "failed to do cipher init2!");
+			return ret;
+		}
+		priv->cipher_init = true;
 	}
 
 	params.numa_id = -1;	/* choose nearby numa node */
@@ -636,7 +667,7 @@ uadk_set_session_cipher_parameters(struct rte_cryptodev *dev,
 	if (!sess->handle_cipher) {
 		UADK_LOG(ERR, "uadk failed to alloc session!");
 		ret = -EINVAL;
-		goto env_uninit;
+		goto uninit;
 	}
 
 	ret = wd_cipher_set_key(sess->handle_cipher, cipher->key.data, cipher->key.length);
@@ -644,14 +675,17 @@ uadk_set_session_cipher_parameters(struct rte_cryptodev *dev,
 		wd_cipher_free_sess(sess->handle_cipher);
 		UADK_LOG(ERR, "uadk failed to set key!");
 		ret = -EINVAL;
-		goto env_uninit;
+		goto uninit;
 	}
 
 	return 0;
 
-env_uninit:
-	wd_cipher_env_uninit();
-	priv->env_cipher_init = false;
+uninit:
+	wd_cipher_uninit2();
+	priv->cipher_init = false;
+	return ret;
+out_freectx:
+	free(ctx_set_num);
 	return ret;
 }
 
@@ -664,15 +698,11 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 	struct uadk_crypto_priv *priv = dev->data->dev_private;
 	struct wd_digest_sess_setup setup = {0};
 	struct sched_params params = {0};
+	struct wd_ctx_params cparams = {0};
+	struct wd_ctx_nums *ctx_set_num;
+	char alg_name[MAX_ALG_NAME];
 	int ret;
 
-	if (!priv->env_auth_init) {
-		ret = wd_digest_env_init(NULL);
-		if (ret < 0)
-			return -EINVAL;
-		priv->env_auth_init = true;
-	}
-
 	sess->auth.operation = xform->auth.op;
 	sess->auth.digest_length = xform->auth.digest_length;
 
@@ -684,6 +714,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_DIGEST_MD5;
 		sess->auth.req.out_buf_bytes = 16;
 		sess->auth.req.out_bytes = 16;
+		rte_strscpy(alg_name, "md5", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_AUTH_SHA1:
 	case RTE_CRYPTO_AUTH_SHA1_HMAC:
@@ -692,6 +723,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_DIGEST_SHA1;
 		sess->auth.req.out_buf_bytes = 20;
 		sess->auth.req.out_bytes = 20;
+		rte_strscpy(alg_name, "sha1", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_AUTH_SHA224:
 	case RTE_CRYPTO_AUTH_SHA224_HMAC:
@@ -700,6 +732,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_DIGEST_SHA224;
 		sess->auth.req.out_buf_bytes = 28;
 		sess->auth.req.out_bytes = 28;
+		rte_strscpy(alg_name, "sha224", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_AUTH_SHA256:
 	case RTE_CRYPTO_AUTH_SHA256_HMAC:
@@ -708,6 +741,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_DIGEST_SHA256;
 		sess->auth.req.out_buf_bytes = 32;
 		sess->auth.req.out_bytes = 32;
+		rte_strscpy(alg_name, "sha256", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_AUTH_SHA384:
 	case RTE_CRYPTO_AUTH_SHA384_HMAC:
@@ -716,6 +750,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_DIGEST_SHA384;
 		sess->auth.req.out_buf_bytes = 48;
 		sess->auth.req.out_bytes = 48;
+		rte_strscpy(alg_name, "sha384", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_AUTH_SHA512:
 	case RTE_CRYPTO_AUTH_SHA512_HMAC:
@@ -724,10 +759,42 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_DIGEST_SHA512;
 		sess->auth.req.out_buf_bytes = 64;
 		sess->auth.req.out_bytes = 64;
+		rte_strscpy(alg_name, "sha512", sizeof(alg_name));
 		break;
 	default:
-		ret = -ENOTSUP;
-		goto env_uninit;
+		return -ENOTSUP;
+	}
+
+	if (!priv->auth_init) {
+		ctx_set_num = calloc(1, sizeof(*ctx_set_num));
+		if (!ctx_set_num) {
+			UADK_LOG(ERR, "failed to alloc ctx_set_size!");
+			return -WD_ENOMEM;
+		}
+
+		cparams.op_type_num = 1;
+		cparams.ctx_set_num = ctx_set_num;
+		cparams.bmp = numa_allocate_nodemask();
+		if (!cparams.bmp) {
+			UADK_LOG(ERR, "failed to create nodemask!");
+			ret = -WD_ENOMEM;
+			goto out_freectx;
+		}
+
+		numa_bitmask_setall(cparams.bmp);
+		ctx_set_num->sync_ctx_num = priv->nb_qpairs;
+		ctx_set_num->async_ctx_num = priv->nb_qpairs;
+
+		ret = wd_digest_init2_(alg_name, SCHED_POLICY_RR, TASK_HW, &cparams);
+		numa_free_nodemask(cparams.bmp);
+		free(ctx_set_num);
+
+		if (ret) {
+			UADK_LOG(ERR, "failed to do digest init2!");
+			return ret;
+		}
+
+		priv->auth_init = true;
 	}
 
 	params.numa_id = -1;	/* choose nearby numa node */
@@ -736,7 +803,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 	if (!sess->handle_digest) {
 		UADK_LOG(ERR, "uadk failed to alloc session!");
 		ret = -EINVAL;
-		goto env_uninit;
+		goto uninit;
 	}
 
 	/* if mode is HMAC, should set key */
@@ -749,15 +816,18 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 			wd_digest_free_sess(sess->handle_digest);
 			sess->handle_digest = 0;
 			ret = -EINVAL;
-			goto env_uninit;
+			goto uninit;
 		}
 	}
 
 	return 0;
 
-env_uninit:
-	wd_digest_env_uninit();
-	priv->env_auth_init = false;
+uninit:
+	wd_digest_uninit2();
+	priv->auth_init = false;
+	return ret;
+out_freectx:
+	free(ctx_set_num);
 	return ret;
 }
 
@@ -854,78 +924,98 @@ static struct rte_cryptodev_ops uadk_crypto_pmd_ops = {
 		.sym_session_clear	= uadk_crypto_sym_session_clear,
 };
 
+static void *uadk_cipher_async_cb(struct wd_cipher_req *req __rte_unused,
+					 void *data __rte_unused)
+{
+	struct rte_crypto_op *op = req->cb_param;
+
+	if (op->status == RTE_CRYPTO_OP_STATUS_NOT_PROCESSED)
+		op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+
+	return NULL;
+}
+
 static void
 uadk_process_cipher_op(struct rte_crypto_op *op,
 		       struct uadk_crypto_session *sess,
-		       struct rte_mbuf *msrc, struct rte_mbuf *mdst)
+		       struct rte_mbuf *msrc, struct rte_mbuf *mdst,
+		       bool async)
 {
 	uint32_t off = op->sym->cipher.data.offset;
+	struct wd_cipher_req *req = &sess->cipher.req;
 	int ret;
 
-	if (!sess) {
-		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
-		return;
-	}
+	req->src = rte_pktmbuf_mtod_offset(msrc, uint8_t *, off);
+	req->in_bytes = op->sym->cipher.data.length;
+	req->dst = rte_pktmbuf_mtod_offset(mdst, uint8_t *, off);
+	req->out_buf_bytes = sess->cipher.req.in_bytes;
+	req->iv_bytes = sess->iv.length;
+	req->iv = rte_crypto_op_ctod_offset(op, uint8_t *, sess->iv.offset);
+	req->cb = uadk_cipher_async_cb;
+	req->cb_param = op;
 
-	sess->cipher.req.src = rte_pktmbuf_mtod_offset(msrc, uint8_t *, off);
-	sess->cipher.req.in_bytes = op->sym->cipher.data.length;
-	sess->cipher.req.dst = rte_pktmbuf_mtod_offset(mdst, uint8_t *, off);
-	sess->cipher.req.out_buf_bytes = sess->cipher.req.in_bytes;
-	sess->cipher.req.iv_bytes = sess->iv.length;
-	sess->cipher.req.iv = rte_crypto_op_ctod_offset(op, uint8_t *,
-							sess->iv.offset);
 	if (sess->cipher.direction == RTE_CRYPTO_CIPHER_OP_ENCRYPT)
-		sess->cipher.req.op_type = WD_CIPHER_ENCRYPTION;
+		req->op_type = WD_CIPHER_ENCRYPTION;
 	else
-		sess->cipher.req.op_type = WD_CIPHER_DECRYPTION;
+		req->op_type = WD_CIPHER_DECRYPTION;
 
 	do {
-		ret = wd_do_cipher_sync(sess->handle_cipher, &sess->cipher.req);
+		if (async)
+			ret = wd_do_cipher_async(sess->handle_cipher, req);
+		else
+			ret = wd_do_cipher_sync(sess->handle_cipher, req);
 	} while (ret == -WD_EBUSY);
 
 	if (ret)
 		op->status = RTE_CRYPTO_OP_STATUS_ERROR;
 }
 
+static void *uadk_digest_async_cb(void *param)
+{
+	struct wd_digest_req *req = param;
+	struct rte_crypto_op *op = req->cb_param;
+
+	if (op->status == RTE_CRYPTO_OP_STATUS_NOT_PROCESSED)
+		op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+
+	return NULL;
+}
+
 static void
 uadk_process_auth_op(struct uadk_qp *qp, struct rte_crypto_op *op,
 		     struct uadk_crypto_session *sess,
-		     struct rte_mbuf *msrc, struct rte_mbuf *mdst)
+		     struct rte_mbuf *msrc, struct rte_mbuf *mdst,
+		     bool async, int idx)
 {
+	struct wd_digest_req *req = &sess->auth.req;
 	uint32_t srclen = op->sym->auth.data.length;
 	uint32_t off = op->sym->auth.data.offset;
-	uint8_t *dst = qp->temp_digest;
+	uint8_t *dst = NULL;
 	int ret;
 
-	if (!sess) {
-		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
-		return;
-	}
-
-	sess->auth.req.in = rte_pktmbuf_mtod_offset(msrc, uint8_t *, off);
-	sess->auth.req.in_bytes = srclen;
-	sess->auth.req.out = dst;
-
-	do {
-		ret = wd_do_digest_sync(sess->handle_digest, &sess->auth.req);
-	} while (ret == -WD_EBUSY);
-
 	if (sess->auth.operation == RTE_CRYPTO_AUTH_OP_VERIFY) {
-		if (memcmp(dst, op->sym->auth.digest.data,
-				sess->auth.digest_length) != 0) {
-			op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
-		}
+		dst = qp->temp_digest[idx % BURST_MAX];
 	} else {
-		uint8_t *auth_dst;
-
-		auth_dst = op->sym->auth.digest.data;
-		if (auth_dst == NULL)
-			auth_dst = rte_pktmbuf_mtod_offset(mdst, uint8_t *,
+		dst = op->sym->auth.digest.data;
+		if (dst == NULL)
+			dst = rte_pktmbuf_mtod_offset(mdst, uint8_t *,
 					op->sym->auth.data.offset +
 					op->sym->auth.data.length);
-		memcpy(auth_dst, dst, sess->auth.digest_length);
 	}
 
+	req->in = rte_pktmbuf_mtod_offset(msrc, uint8_t *, off);
+	req->in_bytes = srclen;
+	req->out = dst;
+	req->cb = uadk_digest_async_cb;
+	req->cb_param = op;
+
+	do {
+		if (async)
+			ret = wd_do_digest_async(sess->handle_digest, req);
+		else
+			ret = wd_do_digest_sync(sess->handle_digest, req);
+	} while (ret == -WD_EBUSY);
+
 	if (ret)
 		op->status = RTE_CRYPTO_OP_STATUS_ERROR;
 }
@@ -935,13 +1025,14 @@ uadk_crypto_enqueue_burst(void *queue_pair, struct rte_crypto_op **ops,
 			  uint16_t nb_ops)
 {
 	struct uadk_qp *qp = queue_pair;
-	struct uadk_crypto_session *sess = NULL;
 	struct rte_mbuf *msrc, *mdst;
 	struct rte_crypto_op *op;
 	uint16_t enqd = 0;
 	int i, ret;
 
 	for (i = 0; i < nb_ops; i++) {
+		struct uadk_crypto_session *sess = NULL;
+
 		op = ops[i];
 		op->status = RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
 		msrc = op->sym->m_src;
@@ -953,29 +1044,31 @@ uadk_crypto_enqueue_burst(void *queue_pair, struct rte_crypto_op **ops,
 					op->sym->session);
 		}
 
+		if (!sess) {
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			continue;
+		}
+
 		switch (sess->chain_order) {
 		case UADK_CHAIN_ONLY_CIPHER:
-			uadk_process_cipher_op(op, sess, msrc, mdst);
+			uadk_process_cipher_op(op, sess, msrc, mdst, true);
 			break;
 		case UADK_CHAIN_ONLY_AUTH:
-			uadk_process_auth_op(qp, op, sess, msrc, mdst);
+			uadk_process_auth_op(qp, op, sess, msrc, mdst, true, i);
 			break;
 		case UADK_CHAIN_CIPHER_AUTH:
-			uadk_process_cipher_op(op, sess, msrc, mdst);
-			uadk_process_auth_op(qp, op, sess, mdst, mdst);
+			uadk_process_cipher_op(op, sess, msrc, mdst, false);
+			uadk_process_auth_op(qp, op, sess, mdst, mdst, true, i);
 			break;
 		case UADK_CHAIN_AUTH_CIPHER:
-			uadk_process_auth_op(qp, op, sess, msrc, mdst);
-			uadk_process_cipher_op(op, sess, msrc, mdst);
+			uadk_process_auth_op(qp, op, sess, msrc, mdst, false, i);
+			uadk_process_cipher_op(op, sess, msrc, mdst, true);
 			break;
 		default:
 			op->status = RTE_CRYPTO_OP_STATUS_ERROR;
 			break;
 		}
 
-		if (op->status == RTE_CRYPTO_OP_STATUS_NOT_PROCESSED)
-			op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
-
 		if (op->status != RTE_CRYPTO_OP_STATUS_ERROR) {
 			ret = rte_ring_enqueue(qp->processed_pkts, (void *)op);
 			if (ret < 0)
@@ -1000,13 +1093,60 @@ uadk_crypto_dequeue_burst(void *queue_pair, struct rte_crypto_op **ops,
 			  uint16_t nb_ops)
 {
 	struct uadk_qp *qp = queue_pair;
+	struct uadk_crypto_session *sess = NULL;
+	struct rte_crypto_op *op;
 	unsigned int nb_dequeued;
+	unsigned int recv = 0, count = 0, i;
+	int ret;
 
 	nb_dequeued = rte_ring_dequeue_burst(qp->processed_pkts,
 			(void **)ops, nb_ops, NULL);
+
+	for (i = 0; i < nb_dequeued; i++) {
+		op = ops[i];
+		if (op->sess_type != RTE_CRYPTO_OP_WITH_SESSION)
+			continue;
+
+		sess = CRYPTODEV_GET_SYM_SESS_PRIV(op->sym->session);
+
+		if (!sess) {
+			op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+			continue;
+		}
+
+		switch (sess->chain_order) {
+		case UADK_CHAIN_ONLY_CIPHER:
+		case UADK_CHAIN_AUTH_CIPHER:
+			do {
+				ret = wd_cipher_poll(1, &recv);
+			} while (ret == -WD_EAGAIN);
+			break;
+		case UADK_CHAIN_ONLY_AUTH:
+		case UADK_CHAIN_CIPHER_AUTH:
+			do {
+				ret = wd_digest_poll(1, &recv);
+			} while (ret == -WD_EAGAIN);
+			break;
+		default:
+			op->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			break;
+		}
+
+		if (sess->auth.operation == RTE_CRYPTO_AUTH_OP_VERIFY) {
+			uint8_t *dst = qp->temp_digest[i % BURST_MAX];
+
+			if (memcmp(dst, op->sym->auth.digest.data,
+				   sess->auth.digest_length) != 0)
+				op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
+		}
+
+		count += recv;
+		recv = 0;
+	}
+
 	qp->qp_stats.dequeued_count += nb_dequeued;
 
-	return nb_dequeued;
+	return count;
 }
 
 static int
@@ -1056,6 +1196,7 @@ uadk_cryptodev_probe(struct rte_vdev_device *vdev)
 	priv = dev->data->dev_private;
 	priv->version = version;
 	priv->max_nb_qpairs = init_params.max_nb_queue_pairs;
+	priv->nb_qpairs = UADK_CIPHER_DEF_CTXS;
 
 	rte_cryptodev_pmd_probing_finish(dev);
 
diff --git a/drivers/crypto/uadk/uadk_crypto_pmd_private.h b/drivers/crypto/uadk/uadk_crypto_pmd_private.h
index 1f55d09a54..cb60cc2ffa 100644
--- a/drivers/crypto/uadk/uadk_crypto_pmd_private.h
+++ b/drivers/crypto/uadk/uadk_crypto_pmd_private.h
@@ -8,6 +8,7 @@
 
 /* Maximum length for digest (SHA-512 needs 64 bytes) */
 #define DIGEST_LENGTH_MAX 64
+#define BURST_MAX 64
 
 struct __rte_cache_aligned uadk_qp {
 	/* Ring for placing process packets */
@@ -22,7 +23,7 @@ struct __rte_cache_aligned uadk_qp {
 	 * by the driver when verifying a digest provided
 	 * by the user (using authentication verify operation)
 	 */
-	uint8_t temp_digest[DIGEST_LENGTH_MAX];
+	uint8_t temp_digest[BURST_MAX][DIGEST_LENGTH_MAX];
 };
 
 enum uadk_chain_order {
@@ -64,10 +65,11 @@ enum uadk_crypto_version {
 };
 
 struct __rte_cache_aligned uadk_crypto_priv {
-	bool env_cipher_init;
-	bool env_auth_init;
+	bool cipher_init;
+	bool auth_init;
 	enum uadk_crypto_version version;
 	unsigned int max_nb_qpairs;
+	unsigned int nb_qpairs;
 };
 
 extern int uadk_crypto_logtype;
-- 
2.25.1

