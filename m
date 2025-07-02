Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9376CC8303D
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 02:42:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB01D40687;
	Wed,  2 Jul 2025 04:42:47 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 0A7DE40684
 for <dev@dpdk.org>; Wed,  2 Jul 2025 04:42:46 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-313910f392dso3010393a91.2
 for <dev@dpdk.org>; Tue, 01 Jul 2025 19:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751424165; x=1752028965; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0ViEMmxxMDenk0WhzYY6h9awYBojCSJYmjri6GXihc=;
 b=rQUlLcpds4SQZX4qHY7JWA6/QwSlXpXjNfVc7qhNJtfWCErCMOFwPOamlGfunUEGZX
 EpX5OdW/6w62qM9UyV8t976NqCbJJBkBRCxBlj7Ac3+P/Esf9gy1j2usY1ieP6KHHrCY
 uVf4DcX3krW+X94c2vg8D8e58UeMtekKQZdI2lgRPwzNuwU+ThL+KWU6sh+IOCavKmEb
 iZlSQDBfZ5cRlf28nfGFjC4WqZhD0aNGqkhmjkvRe4X1ohQ1DQNXIX6Ptwp8fNuDc2CG
 5DkUPBjO/eFVRScyIdsOBqHI+okl9JfaSTJVeAXXPIdlMyxs2QiGNTtJqqWS3loPxp0K
 vDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751424165; x=1752028965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F0ViEMmxxMDenk0WhzYY6h9awYBojCSJYmjri6GXihc=;
 b=Lkq1dfmhQ0tA/AEIMiej0044xxK5PLtUAVMZIC7/GHz7XWZebVLu7w74YOBT/Zm4pu
 JOrJbdJjdc6Bt0UAHKAcGmJL33rn7D9ETGvQd7JRx1baTQhWe9Fhxv+vy5pkdGfGYNTr
 BpnpBsgXK1+BjcsQOJg+4/C4VV+eGXs5GsSTD7heul0eJ5NPJJsOUpMl2+322DzccurW
 h//e+DiQJwsS0ol8Zah5XgxmXYTxpxDGj7QYf9EA1CjGuYeEBOZWsCJiMsb7vb8QSTaF
 umW3G/ZKuC2xK1fpBpUnd9ho/IycelrIceVf4sens/mxc99OtoPL3kiGNAhvGEc4Ysqi
 zkPA==
X-Gm-Message-State: AOJu0Yym1R0d7T5AIUdn5tggyc6lrSSiv7fJ1LLh7y2b+dOvZ92CTLPn
 P1Alwq5TGHJ0vJvW/u/mLSAKO1tXZ3wmGm+3GhQfcRTsoWfDr/6oJOf/2oABbzCbH4g=
X-Gm-Gg: ASbGncvyu39iSwZu2pD8FzIhqFbkbgeUS8F+eLYWypiBk9IWd9C/YFowfFWaiqIOvZR
 hj2yIdJYSNKcRzvQdXP4mWFTlKI7XIc/MluKW2hnUTlnDBxJ3HOL935XO1opcJ3BEEK7t8J2/Km
 OJOCcBouxNkOKRcJVUu7Zt2kpD4i0MpR3YmTLUoOHR0fv6shDFxf2uk0Pa7bn0kecE03K1mAwie
 REUZbqK526bndVTbofpmn8AKievH6tWPw9BW7zoTBeUbqVV8IoaoOb2ERheejEkB19fDduwJNHs
 SaRdUfoKpd062jEQxnf7Wc0Mp1z663qjXllqOr5Ah/aX+nzTJXmcYD4abbGpWNGe
X-Google-Smtp-Source: AGHT+IHyvd7hxI6qSAF4cSXtUCGFToMbvt6XPiO6iGmV9g1MnMATUUcYTtUDa0VlwNQ2QjU5CMADyQ==
X-Received: by 2002:a17:90b:2fc8:b0:311:ea13:2e6d with SMTP id
 98e67ed59e1d1-31a90c0eecamr1862767a91.29.1751424165035; 
 Tue, 01 Jul 2025 19:42:45 -0700 (PDT)
Received: from gmail.com ([121.37.54.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f539e69fsm18171096a91.11.2025.07.01.19.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 19:42:44 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>
Cc: dev@dpdk.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 2/2] crypto/uadk: use async mode to replace sync mode
Date: Wed,  2 Jul 2025 02:42:16 +0000
Message-Id: <20250702024216.49587-3-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702024216.49587-1-zhangfei.gao@linaro.org>
References: <20250702024216.49587-1-zhangfei.gao@linaro.org>
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
 doc/guides/cryptodevs/uadk.rst                |  15 +
 doc/guides/rel_notes/release_25_07.rst        |   5 +
 drivers/crypto/uadk/meson.build               |   4 +-
 drivers/crypto/uadk/uadk_crypto_pmd.c         | 297 ++++++++++++------
 drivers/crypto/uadk/uadk_crypto_pmd_private.h |   8 +-
 5 files changed, 234 insertions(+), 95 deletions(-)

diff --git a/doc/guides/cryptodevs/uadk.rst b/doc/guides/cryptodevs/uadk.rst
index d38dffbcd9..7591c0e94b 100644
--- a/doc/guides/cryptodevs/uadk.rst
+++ b/doc/guides/cryptodevs/uadk.rst
@@ -112,6 +112,21 @@ Test steps
       RTE>>quit
 
 
+As a reference, the following table shows a mapping between the past DPDK versions
+and the UADK library version supported by them:
+
+.. _table_uadk_crypto_pmd_versions:
+
+.. table:: DPDK and external UADK library version compatibility
+
+   ==============  ============================
+   DPDK version    UADK library version
+   ==============  ============================
+   22.11 - 25.03   2.4  - 2.8
+   25.07+          2.9.1
+   ==============  ============================
+
+
 Initialization
 --------------
 
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index e57cf546c2..5e8cb0e512 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -98,6 +98,11 @@ New Features
 
   * Added support for AMD Solarflare X45xx adapters.
 
+* **Updated UADK crypto & compress driver.**
+
+  * Update to init2 interface which requires v2.9 of the UADK library.
+  * Update to asynchronous mode for better performance.
+
 * **Updated virtio driver.**
 
   * Added support for Rx and Tx burst mode query.
diff --git a/drivers/crypto/uadk/meson.build b/drivers/crypto/uadk/meson.build
index e46abd21e5..00cd7d1c44 100644
--- a/drivers/crypto/uadk/meson.build
+++ b/drivers/crypto/uadk/meson.build
@@ -13,7 +13,7 @@ sources = files(
 )
 
 deps += 'bus_vdev'
-dep = dependency('libwd_crypto', required: false, method: 'pkg-config')
+dep = dependency('libwd_crypto', version: '>=2.9', required: false, method: 'pkg-config')
 if not dep.found()
     build = false
     reason = 'missing dependency, "libwd_crypto"'
@@ -21,7 +21,7 @@ else
     ext_deps += dep
 endif
 
-dep = dependency('libwd', required: false, method: 'pkg-config')
+dep = dependency('libwd', version: '>=2.9', required: false, method: 'pkg-config')
 if not dep.found()
     build = false
     reason = 'missing dependency, "libwd"'
diff --git a/drivers/crypto/uadk/uadk_crypto_pmd.c b/drivers/crypto/uadk/uadk_crypto_pmd.c
index e4b1a32398..3c4e83e56f 100644
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
@@ -620,14 +620,36 @@ uadk_set_session_cipher_parameters(struct rte_cryptodev *dev,
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
+		ctx_set_num->sync_ctx_num = priv->nb_qpairs;
+		ctx_set_num->async_ctx_num = priv->nb_qpairs;
+
+		ret = wd_cipher_init2_(alg_name, SCHED_POLICY_RR, TASK_MIX, &cparams);
+		free(ctx_set_num);
+
+		if (ret) {
+			UADK_LOG(ERR, "failed to do cipher init2!");
+			return ret;
+		}
+		priv->cipher_init = true;
 	}
 
 	params.numa_id = -1;	/* choose nearby numa node */
@@ -636,7 +658,7 @@ uadk_set_session_cipher_parameters(struct rte_cryptodev *dev,
 	if (!sess->handle_cipher) {
 		UADK_LOG(ERR, "uadk failed to alloc session!");
 		ret = -EINVAL;
-		goto env_uninit;
+		goto uninit;
 	}
 
 	ret = wd_cipher_set_key(sess->handle_cipher, cipher->key.data, cipher->key.length);
@@ -644,14 +666,14 @@ uadk_set_session_cipher_parameters(struct rte_cryptodev *dev,
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
 	return ret;
 }
 
@@ -664,15 +686,11 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
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
 
@@ -684,6 +702,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_DIGEST_MD5;
 		sess->auth.req.out_buf_bytes = 16;
 		sess->auth.req.out_bytes = 16;
+		rte_strscpy(alg_name, "md5", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_AUTH_SHA1:
 	case RTE_CRYPTO_AUTH_SHA1_HMAC:
@@ -692,6 +711,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_DIGEST_SHA1;
 		sess->auth.req.out_buf_bytes = 20;
 		sess->auth.req.out_bytes = 20;
+		rte_strscpy(alg_name, "sha1", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_AUTH_SHA224:
 	case RTE_CRYPTO_AUTH_SHA224_HMAC:
@@ -700,6 +720,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_DIGEST_SHA224;
 		sess->auth.req.out_buf_bytes = 28;
 		sess->auth.req.out_bytes = 28;
+		rte_strscpy(alg_name, "sha224", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_AUTH_SHA256:
 	case RTE_CRYPTO_AUTH_SHA256_HMAC:
@@ -708,6 +729,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_DIGEST_SHA256;
 		sess->auth.req.out_buf_bytes = 32;
 		sess->auth.req.out_bytes = 32;
+		rte_strscpy(alg_name, "sha256", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_AUTH_SHA384:
 	case RTE_CRYPTO_AUTH_SHA384_HMAC:
@@ -716,6 +738,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 		setup.alg = WD_DIGEST_SHA384;
 		sess->auth.req.out_buf_bytes = 48;
 		sess->auth.req.out_bytes = 48;
+		rte_strscpy(alg_name, "sha384", sizeof(alg_name));
 		break;
 	case RTE_CRYPTO_AUTH_SHA512:
 	case RTE_CRYPTO_AUTH_SHA512_HMAC:
@@ -724,10 +747,33 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
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
+		ctx_set_num->sync_ctx_num = priv->nb_qpairs;
+		ctx_set_num->async_ctx_num = priv->nb_qpairs;
+
+		ret = wd_digest_init2_(alg_name, SCHED_POLICY_RR, TASK_HW, &cparams);
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
@@ -736,7 +782,7 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
 	if (!sess->handle_digest) {
 		UADK_LOG(ERR, "uadk failed to alloc session!");
 		ret = -EINVAL;
-		goto env_uninit;
+		goto uninit;
 	}
 
 	/* if mode is HMAC, should set key */
@@ -749,15 +795,15 @@ uadk_set_session_auth_parameters(struct rte_cryptodev *dev,
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
 	return ret;
 }
 
@@ -854,78 +900,98 @@ static struct rte_cryptodev_ops uadk_crypto_pmd_ops = {
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
@@ -935,13 +1001,14 @@ uadk_crypto_enqueue_burst(void *queue_pair, struct rte_crypto_op **ops,
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
@@ -953,29 +1020,31 @@ uadk_crypto_enqueue_burst(void *queue_pair, struct rte_crypto_op **ops,
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
@@ -1000,13 +1069,60 @@ uadk_crypto_dequeue_burst(void *queue_pair, struct rte_crypto_op **ops,
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
@@ -1056,6 +1172,7 @@ uadk_cryptodev_probe(struct rte_vdev_device *vdev)
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

