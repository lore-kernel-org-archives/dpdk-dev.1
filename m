Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63141C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:32:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FF414060F;
	Sat,  8 Feb 2025 21:32:01 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 49689402C9
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:31:59 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-21f50895565so26204275ad.2
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046718;
 x=1739651518; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcYIAyKKPVd2crCbWEA0Sl9FDyUYM+KXlQOy5mPq3wg=;
 b=r7ICHBuxG26ffu33e2YFROW0c6oWBVrxqLf55ZQPA6I8usP1xc+W2b6pW4MMB62XNC
 ZOgf6htMFxW2jeN8LeBB141eoGCgyGgU1acFxkLfXl90HrY5sCI6+wfPfxF+wfBIZ9cE
 QGYsQpfUDJATiLcY4ZSYX1gH9zRdrSyvONfFI2B0uQenZi5WIhnugHCi3cfWf64asogK
 C634isqy9mA7w3JRqLvK/AU7XKhvBI1pxF8/DfCipEpJ7gGAwEDm3Y9cMK7fS6QP3PXv
 YlJeYmWwflyERpDhTvNQjiOaIoBdtFRGsn8WuG10xlzMye15AwYU+qsYSt35lYQCVpuH
 ywlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046718; x=1739651518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcYIAyKKPVd2crCbWEA0Sl9FDyUYM+KXlQOy5mPq3wg=;
 b=KfWXdSaA9GbsenPhVN4u4Lx0uBtULvBwnrcim9r5dnvj9itkEmB8tYMnLVHBddIvSM
 7mepWhfbj3Czl7dFkDi5dhP5ShYCR8pYyq0bXd0ybpPkSgL9xxM+25+xwg3XEtWIFAq7
 EZBpugrJPSNrLbHuZizct/uGzUMZBoEu4YsIpnxoANsbihsvKabJFfc0C4m7k11wLzyH
 ewTWiMdqHBJvrUhcsYrFnT74MMB6V5MMd6SIv7a8KRxG5ZrvuEk2kuWRNRSC13ToLO2W
 o5nVp5hJ28sQ/lEHAG/HviYnU7rcfyKuG6aXkZltTOdoIu6V82lppGa73PKbFzafaw4/
 fbEw==
X-Gm-Message-State: AOJu0YxLCf5xSpnadn736QuVqEz7inBVCaDRzbKlKClZwJ0h72qNfZoU
 9rZHIOP7C8rndYbZnNIb+eLZCy1/t6SwD+huXxzcHp4ShOG25l52nOO45dhz4Et+H4O5Ljl2tcz
 5T8U=
X-Gm-Gg: ASbGnctWF7qxh0OjNrBj2HtfL8PbHSB2Yg1goLorLNu8mfZzWN5Qz2eAI8C9/PCXcSD
 lXNF+Vzz5BNuo7NeqSopV23dfU1kY9kVLfbabLJxNhX5In7GseNfh0cyN2E9d16cT/jShkmhorL
 o35PET/Q4QgNepdbo2zYHXi9xbuueLq8brhB5BSYfyc1Pm51OcnqmE0/kDODwNXud/qBPjnKUkL
 cwKBsZPmCIR3hl/zqmntTFettBLihdzsB/KdAFJ5ZZh8gbTgXaF1CTu3hi8x25yI+zBMmBgXxz2
 XUecDcc5ZyFj1H9Scze3UrKL/eAuy67YQn0RDgnF+jWxv5Dtf8ta+QMaC1keBpXSrCRa
X-Google-Smtp-Source: AGHT+IGvrN15lSmnanXOIUSA6dnRmeT0MsVmIkzHasV1FzR0Ow05GEiaS0ekxcTIaClquoaA2P6xQQ==
X-Received: by 2002:a05:6a21:918b:b0:1e1:ce4d:a144 with SMTP id
 adf61e73a8af0-1ee038c2641mr14307607637.0.1739046718512; 
 Sat, 08 Feb 2025 12:31:58 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:31:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 04/32] crypto/dpaa_sec: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:21:56 -0800
Message-ID: <20250208203142.242284-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by cocci/struct_assign.cocci

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/dpaa_sec/dpaa_sec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index 3fa88ca968..af605d2025 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -680,7 +680,7 @@ dpaa_sec_dump(struct dpaa_sec_op_ctx *ctx, struct dpaa_sec_qp *qp, FILE *f)
 	}
 
 	cdb = &sess->cdb;
-	rte_memcpy(&c_cdb, cdb, sizeof(struct sec_cdb));
+	c_cdb = *cdb;
 #ifdef RTE_LIB_SECURITY
 	fprintf(f, "\nsession protocol type = %d\n", sess->proto_alg);
 #endif
-- 
2.47.2

