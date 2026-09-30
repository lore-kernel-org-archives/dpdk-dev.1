Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D99CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:49:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE7D742FAF;
	Thu,  1 Oct 2026 00:44:39 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id CFCD442DAC
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:36 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4c276e1c7so708206a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808276;
 x=1791413076; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zjQxHwWra9VECMTF5QrFVGN7ypRQxN+ubNghPHmRiqc=;
 b=xP4ehIPneGWkoN/Gr/00a4wZmfP+iGYEZavKzt9YkHOdOvnIdX8chOwlTSGn8fjNss
 AipQywOHXHNTu73ncnFMh0ddT5IavI7AzI3SszV6uLGK8c8gLntu9zgVEsPvnuDiMxOo
 2BaiuVy6YgWp79P9g1lgnDjXmOhABtCWVZQGkJIPR2c4w4TaixOQX//yYH09eNwhcF7f
 rOH6ZOqW8GCfIURPenY3lPcKDZy1WaeS+5O8Nkitv5QS/LVYEuuO0IRH7mYbUbA2um3Z
 zOj7HoHpEoZxb5RGo2aBsdn0WnsHOql1X3Xei1RYgL+zC/4MAVmM77Gb+8tutzOZbogP
 iC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808276; x=1791413076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zjQxHwWra9VECMTF5QrFVGN7ypRQxN+ubNghPHmRiqc=;
 b=nG9Mcj0iKCCjarsX8ZcEPgjAOYdrSngUVNUlab3A4M+PNDBqlIrReSDQgFDc7Vqcqh
 K1kprEhn3yq7zQpKSWqg+PUkK9ubTLwaFWjOOJBX2nAoIaMNQl7ce0AhVmT/xR7u+wes
 c69JDehRXG+nV1lJdmlDga2vBv3rCSDDjXy/Y7eTF60Ls5vKscxRIt6W+m0Lhk2Vbysm
 x4y/UMcaVF5bV5+viNHaN9jeTJUW3WTlrd6jFCIv7/GNPFs2Esrh5Urexvl9NYQfgdC8
 U4RRALb/tpDRtmC5z/ghFxp1LObemiQVOIJE81u1xSm5sL5JY2Viy2DICZzojB5qvRzH
 vSmw==
X-Gm-Message-State: AFq9FYIcv+Mr1CAAJlitZppzQsumhiJBWX369pJ4zmHVReoQDyu++px/
 5Ya0/sEzlGmIr8IjLf2bfKe2sZsdBooKH9ZgEgvQfPfpFoR3v1nAQbihsU5tX5/zpntdWhEPHVB
 dhkJGMro=
X-Gm-Gg: AYBFou03uHZWy2l8Dap5l4dvaABCNRS6nEwlSInb3+RrFzttOuetiphxIsw0dUUyj0f
 fau6DPDdH4M39zujfjuK7vXUi0RD77l6bkweZlwZiCwMGMDXyn47gwwFk2Prc3sPibDO2ntQvYm
 tbXzFY7cc/9Zkce6d2WBP6X0u/8eMp7q58FEiMxskkD1DC+D7rMM2kvC26DGndX4PJYk2IKk6Wz
 Oa/hR0Z0i91H5fQ2MquPpa/r396tpxqpeAVxCrW+M58PQrZcf3EQGtRmOoPC8t2JU7BZFheF/yo
 ey+qYzAvFuQBLn2tBW3LdcuuBk1sDCXD5J/e4engSh4f5NbUqD6GjhXCF8XdvbWDPCdhpypjcSi
 8hC9T48ZUqlGYg+jOpo1vvW/l360N2iU8TP1Ms+s/JWJjMc3TcATdDzQ+7iKhmIafS6oCc5IhS8
 enuA7jKuOJDlZcqBae96DQXP0U3StC3cdYXA5hSJRQrL1emtvhGiy0oGkX/bqU1hOE6rpMMsjVL
 IM4mC0YfO/fvP9j6LUhh+rqQptCB9EJdMniaaY=
X-Received: by 2002:a17:90a:d2cf:b0:3a4:df8c:a4c1 with SMTP id
 98e67ed59e1d1-3a4f4ebce10mr349120a91.57.1790808275935; 
 Wed, 30 Sep 2026 15:44:35 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Michael Shamis <michaelsh@marvell.com>, Liron Himi <lironh@marvell.com>
Subject: [PATCH v3 49/65] crypto/mvsam: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:07 -0700
Message-ID: <20260930224340.58580-50-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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
index 65a63c9d62..4ac9e209df 100644
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

