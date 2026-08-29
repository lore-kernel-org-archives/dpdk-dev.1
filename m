Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CF1C61DD9
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 15:47:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 999274060B;
	Sat, 29 Aug 2026 17:47:24 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 0F23540431
 for <dev@dpdk.org>; Sat, 29 Aug 2026 17:47:23 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d58efc7356so23716885ad.1
 for <dev@dpdk.org>; Sat, 29 Aug 2026 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788018442;
 x=1788623242; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uNjPmQ5YpQKP6zzvlvJsRVjqlKxAcGHqRDOm/udk2cI=;
 b=HnrIswqfHy+cjMwkWCUBrK5sI/BDLtAna+0nx7tMo5UDiyMe2R1sfA/krfqgu0+PQl
 N9LCaGd+slRcBa/96HHqcYJh8axfM7U1c7rPfkLWdQJHPFj/sbO8Bp6nmbErt3WNxcoY
 yfQb9GNVo/hJyYdaBFtjl97gJ9tJ7vofYK1iVBazwn9oeVc/sK57rlexYqiphhDeZtzH
 SptWlcQh8Q2czxTJXfpgMU04yq5hEIJxVvWVokq63INKvASRi/gYUi+meTMRxP+4nVNd
 neZ7FjdYiXvruOcXGQIiw3o2bgf3q4GLnP2GtXKjdSF2sBHJ8clWUDDiV1Qxna3mAo/r
 NayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788018442; x=1788623242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uNjPmQ5YpQKP6zzvlvJsRVjqlKxAcGHqRDOm/udk2cI=;
 b=RIvq/9/Ua/x5XajtjikRuFSr34/RzZAO5pAib1kqavy/1V1wWgBo1KqJPNx8J31Zos
 guKeU9m+1mOYxDKbvX6JiNbi7uFchaksKUP1HX8MBB6Q6rAL2+f4qMYcmKEkaYMfeoR3
 RUs5rogl+gQcAXWYb9DzL/jbRpaq2PbGQMdtkvXCV14PfZoN17vtGMZn4MSqrRWzHuR9
 On7cXmq6nw3zcDN+fHau4z1CdiXqMr+QEB6d/hbix1wboFgs6Tqy74p0uN9uGkkMBlug
 z+Gsb0lIVWubQIlKuDaYMOgigqhavnH1XKuEd8Q0WxKWxTDIIMC046KgFYAWM9i2c48G
 C5Nw==
X-Gm-Message-State: AFuF++lbrnptIqyBUZuA+eYBaSALsLTlmA3nGQLSJPwRDY9bYnqZ07XE
 RXCINh76VDaw07eRt5H7eGreYLhoK+zG5JV2hkxvC6qrM+OyQMSX/aBdKdra32B6g1rhpHyNqhY
 dBb7y
X-Gm-Gg: AYBFou3+mUxIv+vmeUHy5sODkbV0/RrirX+Sl+FSnJxxcZnyrsjeLwJH0qnJAMnLzKk
 OyT2z6T1+oe5oFimti4WD1fE/s3qv8oQPNIs+kUdmb642U4atKnYoX6K7wqGM5aYuF17q/pt4cw
 Kx3nuwXx/FGXotF/8ASenoU8x8sC//wc9oVildRyhbL0LHvGOqtdYo8c5QPl+6ZxMnbyuP6k8qG
 dWTdVHcNLTWIcmo2GG/AExmI++Y2z5IDAy5Q5uKSoM3a/v7wBz03ItAEYIqlXsYWt2GrGtoUC17
 HhITSjA04UVVTdaOQNRwuygQNfnMTZjSzhGlS8f5TizrwxdzPc8HkDG5v724Azlamq4m+EKHRB6
 fekCyVo4wI637BYpEyKyd7Qc4meSvUO/BNFmg7KWoJGRptQp9Blo0zHf7HBSuKuuWzSj9RKwWjb
 NCQEfZiYqk1UxvU6GYWYfRM4MvBcdaSGPJReks01uQ85Ia8HBG2c5ndsV5ZTCtenFWsNMGbWw0J
 ZpYkxL5NiPWUdcUOL4R0imzNwA=
X-Received: by 2002:a17:90b:4a52:b0:393:288:29e3 with SMTP id
 98e67ed59e1d1-396d0eda189mr23109424a91.10.1788018441885; 
 Sat, 29 Aug 2026 08:47:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e41837c6sm13221356c88.11.2026.08.29.08.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 08:47:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 2/4] bus/dpaa: remove unused qman_clk variable
Date: Sat, 29 Aug 2026 08:44:46 -0700
Message-ID: <20260829154706.52169-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829154706.52169-1-stephen@networkplumber.org>
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260829154706.52169-1-stephen@networkplumber.org>
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

The driver was recording the clock frequency and never using it.

clang 23 reports:

  qman_driver.c:27:12: warning: variable 'qman_clk' set but not used
        [-Wunused-but-set-global]

Remove the variable and the dead store.

Fixes: f6fadc3e6310 ("bus/dpaa: add QMAN interface driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman_driver.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman_driver.c b/drivers/bus/dpaa/base/qbman/qman_driver.c
index 45b094e0c6..bbe2640c52 100644
--- a/drivers/bus/dpaa/base/qbman/qman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/qman_driver.c
@@ -23,8 +23,6 @@ u16 qm_channel_pme = QMAN_CHANNEL_PME;
 
 /* Ccsr map address to access ccsrbased register */
 static void *qman_ccsr_map;
-/* The qman clock frequency */
-static u32 qman_clk;
 
 static __thread int qmfd = -1;
 static __thread struct qm_portal_config qpcfg;
@@ -371,8 +369,6 @@ int qman_global_init(void)
 	clk = of_get_property(dt_node, "clock-frequency", NULL);
 	if (!clk)
 		pr_warn("Can't find Qman clock frequency\n");
-	else
-		qman_clk = be32_to_cpu(*clk);
 
 #ifdef CONFIG_FSL_QMAN_FQ_LOOKUP
 	return qman_setup_fq_lookup_table(CONFIG_FSL_QMAN_FQ_LOOKUP_MAX);
-- 
2.53.0

