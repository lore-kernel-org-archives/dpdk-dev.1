Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF75ECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:49:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1523040652;
	Mon,  3 Nov 2025 17:49:22 +0100 (CET)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id B178D402EB
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:20 +0100 (CET)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b9a6ff216faso1278929a12.3
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188560;
 x=1762793360; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0xGKvb4s3y76CRxUEFcf/y9Rl/0w7aHHiEz7NmqzZY=;
 b=EMGqTgzEd/JeB3JCJwFL0GeuYTrmtC3k5ckJQrZPFfzAvLiPcGIqtbVW2s+9qq35Qa
 MRY7vOiQiOnCxdPO0hRP78ikv1Y3dM4gzwDBqWh+zTubxXaY0upDQgOcQEauas/k1Tjo
 Wa99OzoELToV0mSFwJqu/8hg7oGnXkpIXEzZmgpac12BHltGW+tukXAvG94gbhRnWGOf
 /BrcGug0OAQV3dOQg614B6AtmD7AFS/iOEu6+Bv6W4ncGIosvqRlXBj+M+CGvAPte4qe
 UkB5jIkRiZvKG4vtIkdA8IdGGsihplC6NfWu7XyHLuDfoiIgVG8hrsdyi3K+LAxtf3/W
 v30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188560; x=1762793360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0xGKvb4s3y76CRxUEFcf/y9Rl/0w7aHHiEz7NmqzZY=;
 b=CHY8TuZY5SvbLOO97SdF4cNawCWhsO5kDSJs/wm2lXRIM1xZckfTmMy0nqVg926ZRP
 MyshGCtsEDB3q4/C8Ot53vyP6xvJbCdc/O2NyMBFwYzUDuGn4fE42jGZ5HeIDmoKpwk1
 akCd0+QIA1mJHPYQb0GUkx6kCfmHcXyYEMoRIoqGqSlTwhmPNpbGZNmCFaJDUbBI7Bv3
 +xRL74fPjli+WHnI3hSHYebEoA1D09Hw3Ld9yeJxt0fhAAXVUVDdaM5tGtpNwMzkYAbG
 Fk3dTEtKj9re0vQaUEFUwu+HICPMmr7lDh76cvIFmxAkSEb5F6aibuZJPNsnLLsSrFXl
 6G7w==
X-Gm-Message-State: AOJu0YwTPohvJGGXD+sx0p2Mvfsal2WAYreNy9mu/IErt1Y0drbKrRHX
 k0MWf2QSjakwambIzftJURLaZHGszytbIdHT6pOJlSIg823Whx8gXTgdtD6n+Peq5nSXyC/zH45
 oXDNB
X-Gm-Gg: ASbGncsrUEmH8QfegEQWpfhXwdMWENLxrAy4ikcK1sZmLaAJTbF5FokZ1exU/ImMkj8
 kCQHpKj9jA0u9Q5nSIktXyUXgTALVVP79o8rq1V0KdoE0JRDDi67rOg6aIaemyZnIN5+Q+rLhJH
 ws6qiwlVKQB/bxJhc8VKz/YNqskgGFnLR9HUor+rV8PrQmymhApddk8xVm747IcB9FPR3Jrvliz
 HxOnQ8bOPBUIJZaGTrEeur7MwkjXFExP06tilcB4CMQytL9VWeqr8aErmSftyxBC2jPF5XoOuu8
 DxKKrUQCGNRlbP5b9FoZVtsJqN5+0PldLeZk8+xozxekDu+gffVQM4FzFYnu5bEgZ4BnKeKflHe
 YZbrCWOCF60lOt43MoDccJCfpMylWB1B+PUkAcOj9QEs/ZRw8B1u5fRm+uA9JuYIyseATcDkpoY
 WU/7TAiLV9PeFv/fErHNKEAuEmqS2ngsY9lEL67sR5E62fEzKuKQ==
X-Google-Smtp-Source: AGHT+IFl2HWe8xTdOwm3H70AXonxYzFEJbeUASvnLj8m42UiftD/v1DPZbw8kikTWkq2GPqomuHp6Q==
X-Received: by 2002:a17:902:ea0d:b0:295:7bbd:52fa with SMTP id
 d9443c01a7336-2957bbd5b0dmr84510955ad.56.1762188559470; 
 Mon, 03 Nov 2025 08:49:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, jin.liu@corigine.com,
 stable@dpdk.org, Chaoyong He <chaoyong.he@corigine.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
 Peng Zhang <peng.zhang@corigine.com>
Subject: [PATCH v3 01/44] net/nfp: fix use after free
Date: Mon,  3 Nov 2025 08:47:06 -0800
Message-ID: <20251103164915.101713-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

The code to cleanup metering was using the objects after calling
rte_free(). Fix by using LISTFOREACH_SAFE

Fixes: 2caf84a71cfd ("net/nfp: add meter options")
Cc: jin.liu@corigine.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_mtr.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/nfp/nfp_mtr.c b/drivers/net/nfp/nfp_mtr.c
index d4f2c4f2f0..4833ebd881 100644
--- a/drivers/net/nfp/nfp_mtr.c
+++ b/drivers/net/nfp/nfp_mtr.c
@@ -12,6 +12,13 @@
 #include "flower/nfp_flower_representor.h"
 #include "nfp_logs.h"
 
+#ifndef LIST_FOREACH_SAFE
+#define	LIST_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = LIST_FIRST((head));				\
+	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
 #define NFP_MAX_POLICY_CNT             NFP_MAX_MTR_CNT
 #define NFP_MAX_PROFILE_CNT            NFP_MAX_MTR_CNT
 
@@ -1124,10 +1131,10 @@ nfp_mtr_priv_init(struct nfp_pf_dev *pf_dev)
 void
 nfp_mtr_priv_uninit(struct nfp_pf_dev *pf_dev)
 {
-	struct nfp_mtr *mtr;
+	struct nfp_mtr *mtr, *tmp_mtr;
 	struct nfp_mtr_priv *priv;
-	struct nfp_mtr_policy *mtr_policy;
-	struct nfp_mtr_profile *mtr_profile;
+	struct nfp_mtr_policy *mtr_policy, *tmp_policy;
+	struct nfp_mtr_profile *mtr_profile, *tmp_profile;
 	struct nfp_app_fw_flower *app_fw_flower;
 
 	app_fw_flower = NFP_PRIV_TO_APP_FW_FLOWER(pf_dev->app_fw_priv);
@@ -1135,17 +1142,17 @@ nfp_mtr_priv_uninit(struct nfp_pf_dev *pf_dev)
 
 	rte_eal_alarm_cancel(nfp_mtr_stats_request, (void *)app_fw_flower);
 
-	LIST_FOREACH(mtr, &priv->mtrs, next) {
+	LIST_FOREACH_SAFE(mtr, &priv->mtrs, next, tmp_mtr) {
 		LIST_REMOVE(mtr, next);
 		rte_free(mtr);
 	}
 
-	LIST_FOREACH(mtr_profile, &priv->profiles, next) {
+	LIST_FOREACH_SAFE(mtr_profile, &priv->profiles, next, tmp_profile) {
 		LIST_REMOVE(mtr_profile, next);
 		rte_free(mtr_profile);
 	}
 
-	LIST_FOREACH(mtr_policy, &priv->policies, next) {
+	LIST_FOREACH_SAFE(mtr_policy, &priv->policies, next, tmp_policy) {
 		LIST_REMOVE(mtr_policy, next);
 		rte_free(mtr_policy);
 	}
-- 
2.51.0

