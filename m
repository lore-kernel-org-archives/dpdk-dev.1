Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FACC88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:54:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6AE9410E6;
	Mon, 14 Sep 2026 07:52:10 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id ED28640696
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:09 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso1632136a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365129;
 x=1789969929; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9GDAl+oaX7uJ+ckr78MbtmIaU7vTWppyx+lEzN4CgCk=;
 b=BTabLdxsqS3fgTnevHxBw6VfIm7THBpL1eVa6tSBwIFxrdI8ivDcAZ8ItnCBiMRzG8
 9z5skr74WO/3q0Z2FIxWK2ZUrS6Dbxw6RnoZ0C7TEItxv0Of4+sRK3TRmXwG8zNDN9li
 mLWYP5nqAcQe4KtFLBuPz7bgz5Pxap2U9MT4zDlPW+Xg8QkrnoPodSilTFSoU5ZRpYw8
 a/DaSEwlkRc7Fo+I7wDHzjeB6rUCZJMVK8sHcWhBRgEIuUqOatov1I5VgyC9x9md03IA
 WaMOtPDhFZimkDulDhmf7xJEspqMFGl42LKoiLLg3WyklonWBIROpLmnIBL+TmlFPixX
 WJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365129; x=1789969929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9GDAl+oaX7uJ+ckr78MbtmIaU7vTWppyx+lEzN4CgCk=;
 b=R2iVtuaXJ628cD3/njKII1XlIpjywkN/yP9Pw4musFUDAljMA3x/qsk63NrbLgYS6r
 Y76OpoCqHmHO3kcTVFLvEYzDbS0MG6/Vpoj+oWvmly79tRXdzJk7a+wmQLFH2ugcJibE
 HKfUKfxRtqwEyFKqWIMveOJ7W8r/YMMm6LyHtXkisyF9rUmrMuZZZT/v9epJFXAKWGp4
 7YvOvJ8/u9ssQocKxKqEMgBSP44225VeYgGR1pI0ffKAb10eGXw2enXG7qVAzp/awZ+H
 V6BZXduiLrSjoMZ8MIMYaEEL/j6v2HoIrEDdlNE3LGvEj0h551tgGRHr8daYw3ygCd2o
 8AeQ==
X-Gm-Message-State: AFuF++kjLmC7nbs4klIDC4tlIgFZQra/J6/XlwjKN9ZdkdnffUWZQLmT
 LuzUvwJsXDnicb957kdmVARZnmCgaUEaY5LRBXOI58WFXI16veHkzWlArU086c0yVfZyJqSKniw
 +jN7y
X-Gm-Gg: AYBFou1K1VbB7cZHY+B/8P/sIHXKtzVrM35iTJUMyXL4MaF5sH1Pe3GwwitYAbBHz63
 DJv/iMb3rcJ03IzodqiyvxMnSynKOsAktc5RK+6MloXztwAaXSFGZDhuFWyPRDIeX0NOh9CcMOm
 4p4Jf6WTYJSGyNQNjLk9NQdLE2rCisKQ6YAUO08aTePWjGcrCB1hhMfUnnX7H3YrCZpoXPXf41y
 3Lv1g1S/onCbAEw974FPSeYlqeZIpX3dvaIebFqHi8CeZ7UIquZQTsip9Lat7HOT+NdOoIiHE+1
 rhW4WJHD9gOtsKbn/FsD2xGa9eEFw0brhTbfo2cVGfU7Mu7s7XEyM0zM1Us+vxSe5u9rdK1Eey+
 rd2Obwg6z1EWa7QLVP4QkbzIbCABMANC5rkSbHNwebYY9c6DISaWRfVMfY9ENu8LgfBRkMBFtTy
 pSwbXRE6JIopunBfzpp+WbMRjnEQ2fKeX7TLKVn4iv3ik3EuSbEljFkxCY4w0L96rMNf6RVi4Wz
 /4mw5SCvQRqLWkx3xMV2Z7soQ/4YVhmvdFsfQ==
X-Received: by 2002:a17:90b:39cc:b0:398:c150:e7b3 with SMTP id
 98e67ed59e1d1-39debf54a04mr2729750a91.4.1789365129116; 
 Sun, 13 Sep 2026 22:52:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Michael Shamis <michaelsh@marvell.com>, Liron Himi <lironh@marvell.com>
Subject: [PATCH 49/62] crypto/mvsam: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:20 -0700
Message-ID: <20260914054912.755403-50-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

parse_integer_arg() uses atoi(), which cannot report an error, so a
malformed value such as "abc" becomes zero and the negative check never
fires.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/mvsam/rte_mrvl_pmd.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/mvsam/rte_mrvl_pmd.c b/drivers/crypto/mvsam/rte_mrvl_pmd.c
index a824719fb0..3fd39e20d8 100644
--- a/drivers/crypto/mvsam/rte_mrvl_pmd.c
+++ b/drivers/crypto/mvsam/rte_mrvl_pmd.c
@@ -1117,22 +1117,6 @@ cryptodev_mrvl_crypto_create(const char *name,
 	return ret;
 }
 
-/** Parse integer from integer argument */
-static int
-parse_integer_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	int *i = (int *) extra_args;
-
-	*i = atoi(value);
-	if (*i < 0) {
-		MRVL_LOG(ERR, "Argument has to be positive!");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 /** Parse name */
 static int
 parse_name_arg(const char *key __rte_unused,
@@ -1170,14 +1154,14 @@ mrvl_pmd_parse_input_args(struct mrvl_pmd_init_params *params,
 		/* Common VDEV parameters */
 		ret = rte_kvargs_process(kvlist,
 					 RTE_CRYPTODEV_PMD_MAX_NB_QP_ARG,
-					 &parse_integer_arg,
+					 rte_kvargs_handle_uint,
 					 &params->common.max_nb_queue_pairs);
 		if (ret < 0)
 			goto free_kvlist;
 
 		ret = rte_kvargs_process(kvlist,
 					 RTE_CRYPTODEV_PMD_SOCKET_ID_ARG,
-					 &parse_integer_arg,
+					 rte_kvargs_handle_socket_id,
 					 &params->common.socket_id);
 		if (ret < 0)
 			goto free_kvlist;
@@ -1191,7 +1175,7 @@ mrvl_pmd_parse_input_args(struct mrvl_pmd_init_params *params,
 
 		ret = rte_kvargs_process(kvlist,
 					 MRVL_PMD_MAX_NB_SESS_ARG,
-					 &parse_integer_arg,
+					 rte_kvargs_handle_u32,
 					 &params->max_nb_sessions);
 		if (ret < 0)
 			goto free_kvlist;
-- 
2.53.0

