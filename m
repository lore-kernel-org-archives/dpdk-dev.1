Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5802CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:43:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9F5842F5F;
	Tue, 29 Sep 2026 18:40:03 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 95BEF42ED6
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:51 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-881d9da69b1so990915b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699931;
 x=1791304731; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zjQxHwWra9VECMTF5QrFVGN7ypRQxN+ubNghPHmRiqc=;
 b=wso7e7kIKLZOMOzXnJ4cGgOFK/xyEGEInoUOKxU+mBjxubqI9iSyexj8hADn7UJ7V4
 PJJd/ST1NUHaMYqndWGeygnu0XO4qIw30XdGigSbwiE0L5Jz1Z9Qs17RSwTXlINeooXX
 1oNK1chkoqBdBF1HX7eJavUcjRz8OIU3/xYxLNeNyjJMCgxtQ8ZznM9YtjgorUWGPndc
 o0sdVSwMJEDV3M4HuWqTDAJTscUCbTSYuW3bBaupQrfr2O0zwGLltjT5Qagm5TT/QYNI
 IOa1XWqgCdS73o2oMcX9UcBnr128H9kNiiOv8NUQXAlsNvv5vBINctmOmPYhsdArSafa
 6UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699931; x=1791304731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zjQxHwWra9VECMTF5QrFVGN7ypRQxN+ubNghPHmRiqc=;
 b=YtJXssp/d+WOHJI9VJaTL+zZxjRvgkQe8gACuRP0aHSS5yEem+Gss0Oxgi9KOWfVtg
 /Gi+tG+D1bVhlLOlwwU8L3k5bbvmbO+TTgTRp/lA9rSZEfdHU4PnCVTnfCJoa7Ta/Z4K
 SrAo3kXXSaEi8kluvcnoCaH4hORqcHBhs1ysEOtV58jW0H/Mu/uKmQYNuYEzYQa0S22M
 mqN/qcxadE6+LhNaVZRDnx1xvyYnnD6W+at3OD5eWAexDdCruCbImP5f+4J0TVSi6aq5
 YQ1JNYY0M0SKH6vb97UbOJL8wHRlUaZ/e6YiDfzDtMd0fSxQAZ99t5TJC0WP8h6R290E
 KB9w==
X-Gm-Message-State: AFuF++lpKL3VNt/1obnJqcMDvn9ArxYS8IKyaLNP0ZdCz0tw5uSw7Lu9
 Wp2tT7seV//TDL3mLhYIYbrgWGtUZbRx1yl5Tg/LpW2p7WJSYzFHPBssV6XgJ9+HeJEfktNaqDj
 1glIpesU=
X-Gm-Gg: AYBFou3wRlF2EzXBAva/dTCz3vq9r9cJ+YdttIISymvG/k1SLgF6nrqoX4RwMW0cbna
 w09UlfPMNuVGFz682NArsrx2Yn+7EoQB/Vr11AiTIN6szjuyoYSGbS4rMsYCn+wm+NH0scMK8Gn
 2zFs37YM3RE8fEpBNvCe1U0ZxwhXAq0uArlAQatE2REld/CLtOcZr4Nb5g21U4n+w77IKeQ14cc
 WuUY4BAgLzjm9gXp7qzanU6aQO8zp8MDpnqIZ+z8K/NJRM9g704XscEj8VrEbCa/Lr3/sTZyVmj
 H+VHPDtDFomWveU0uh6nsbrB5+5aGyIMQtIsFML2tl1/HwMtpBLWU1pC33RAHLZMVF95aZwjpIT
 7mrYUbOnvASoxHOGy5nP0+39yBYIIgXdLQ6g53oRcEC0vLXKcnvSmfbysl8AkyX51wyLMu2BNH3
 4i75pVQkGnrybzjZqjoV52Kttcug+gq8OjC4ydoWdvRPI4omJwwUZjUxM8oBDcmt57Uu/ayYOT5
 qH1VMKGQINVswLtryTa0Qo53FyGU/gB9iyiTIzSMDV6ox9r
X-Received: by 2002:a05:6a00:84d:b0:878:3658:23dc with SMTP id
 d2e1a72fcca58-87e9cb1da4bmr15243768b3a.53.1790699930726; 
 Tue, 29 Sep 2026 09:38:50 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Michael Shamis <michaelsh@marvell.com>, Liron Himi <lironh@marvell.com>
Subject: [PATCH v2 48/61] crypto/mvsam: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:51 -0700
Message-ID: <20260929163800.1108305-49-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

