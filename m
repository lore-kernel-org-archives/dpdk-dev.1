Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF526CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 16:27:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 859EF4065C;
	Fri, 15 Aug 2025 18:26:49 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 13D514065B
 for <dev@dpdk.org>; Fri, 15 Aug 2025 18:26:48 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b9dc5c2f0eso1290045f8f.1
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755275207;
 x=1755880007; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qO1RKIkmmOj2M55phhV7NpOzLei+0VUFkPZ6iPjtjUo=;
 b=Qof8g0Hko9tMEn1aJ52sVsXUWq9GZm0IIBUJ0zj+LfjeHF0gF0nPXvX5QmMjZGGi35
 ktuPJOorVJBl03VMgnQw4BlyYHS9Vxms/qtKCs2KUPWbxx2ucfYJ7eFd3N+U44yChVVC
 dVUpXS7+mJraOQ7xd0FfY1a0uXDMIRFPDMUv+TYHZQRXa2mxp2Lq/M6k1d2VbPTxSScA
 qlT7V+drSoD2Jwp6qLjSL0riRTjs9A2T1h6gGolWFwWNZfXbTZwqAivnCKbMlxF03waQ
 N361bc6eQcBr9ST7yoMJnVZCcXfCItNuRKMtCGUZUCEwgbme8tb+ppyJbYnVmUFZtbPg
 DE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755275207; x=1755880007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qO1RKIkmmOj2M55phhV7NpOzLei+0VUFkPZ6iPjtjUo=;
 b=vLKNrennT/BayZjveOV6xBBsnk1KfxTxUnsIk5r8XBvStd8A+C+64IdXYWBYbDD8BD
 mDnzCyjpxWITAnKfXI+3K+mBPYWGQ5shj/GaOKPwHkIJC66DakkOndF7Od0AcKtD98Tw
 ZzBcjaOiho94BinmDMuRWyA/RE6QcRV3Cpq/WbW9IrL6/dpXkIk+4+kv+e12qHVajiSe
 YKZSzGC/A5iy2+BUMT5DfBhHfDk/xZY/BbX2roV7Rnya9XiufE+DHMgcMmj8A0vK5s6e
 MWl2MejeCGTYKuTh+Ds3OWhnEPDFIg0QH452dPBjq8ameAVFwgQ35peP7uuue5L6Lx35
 mP5Q==
X-Gm-Message-State: AOJu0Yz2cph5xLFNt4PJupjSnv8L0KBMQ4ScuWf8XYzwMLARgrgvOUTj
 s+RD9XM+F//E5uAtH3t0nd063HZgLDB5pFKmOjGal93F3nO7ewn1/EBVeUbIGG51mMhSWQVewt1
 3vWZu
X-Gm-Gg: ASbGnctY1EBGlX3k3dnbSiTigjUZYj5aaWdm6um4K97JXMCCYCI/hF0FP1ihjl8AdBs
 55BsyNLfMaoyBflCH7DRMqdx0+gdqmFxD9AhTedWEWzyYOI5ZLNLAAsD5NNseXeIUAm/ZeBftIn
 zP+LLF9BiURyFRTT9pa2838zlGn4/ZyF2Y2qD8fA4nZkkZPRcYbeXLIJvO8CHInJ4egjL0IRMdb
 OX8NmDsJitiZ4v4hKpRtl0PWfmqfjNcW9mZBjv9jVW5ofEi/7n3Y6tC/3zl+OMjO2CH/LKXXQP1
 GSAQyUdPkYFZZL+DLfp9tOlqW+hhsqUooqNpQkkbTWXrvUEFXmcvYepznnvxjVndZ4m6Be7F755
 4Ox5BrGg85x+Ml78PbitSQ5qCJ3kZPWSvFsQn5jGNQIoEg++/f672TPbWKDnMTsi/Hxxg5426bQ
 QsFsh+aOk=
X-Google-Smtp-Source: AGHT+IGIfNaAGAxqShVW6dppqkKbrq4I/ndFLeJdaiGDSiocXX832D90eTYDgG95RDrt0FbWCB7ZwA==
X-Received: by 2002:a05:6000:2dc2:b0:3b7:8410:22b5 with SMTP id
 ffacd0b85a97d-3bb66d21b09mr2117540f8f.13.1755275207513; 
 Fri, 15 Aug 2025 09:26:47 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb676c9431sm2665278f8f.40.2025.08.15.09.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:26:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v3 5/7] app/testpmd: replace comma operator with bracket
Date: Fri, 15 Aug 2025 09:26:21 -0700
Message-ID: <20250815162629.161782-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815162629.161782-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250815162629.161782-1-stephen@networkplumber.org>
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

Use while with brackets in favor of comma operator.

In flow print replace with temporary variable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline_flow.c |  6 ++++--
 app/test-pmd/config.c       | 10 ++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 83d398f8ee..a54463f718 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -8333,8 +8333,10 @@ parse_prefix(struct context *ctx, const struct token *token,
 		if (!ctx->object)
 			return len;
 		extra -= u;
-		while (u--)
-			(v <<= 1, v |= 1);
+		while (u--) {
+			v <<= 1;
+			v |= 1;
+		}
 		v <<= extra;
 		if (!arg_entry_bf_fill(ctx->object, v, arg) ||
 		    !arg_entry_bf_fill(ctx->objmask, -1, arg))
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 0fda8e99f8..14af69bce5 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -1497,7 +1497,7 @@ port_flow_complain(struct rte_flow_error *error)
 		[RTE_FLOW_ERROR_TYPE_ACTION] = "specific action",
 	};
 	const char *errstr;
-	char buf[32];
+	char cause_buf[32] = "";
 	int err = rte_errno;
 
 	if ((unsigned int)error->type >= RTE_DIM(errstrlist) ||
@@ -1505,10 +1505,12 @@ port_flow_complain(struct rte_flow_error *error)
 		errstr = "unknown type";
 	else
 		errstr = errstrlist[error->type];
+
+	if (error->cause)
+		snprintf(cause_buf, sizeof(cause_buf), "cause: %p, ", error->cause);
+
 	fprintf(stderr, "%s(): Caught PMD error type %d (%s): %s%s: %s\n",
-		__func__, error->type, errstr,
-		error->cause ? (snprintf(buf, sizeof(buf), "cause: %p, ",
-					 error->cause), buf) : "",
+		__func__, error->type, errstr, cause_buf,
 		error->message ? error->message : "(no stated reason)",
 		rte_strerror(err));
 
-- 
2.47.2

