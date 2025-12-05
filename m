Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF4D3749B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4275E40673;
	Fri,  5 Dec 2025 21:16:07 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 5110A4066E
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:16:06 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso25275145e9.1
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965766;
 x=1765570566; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzyA3HkNRX9Tus5ZkFbRaNbbBPxBm1P3daJJ7bhrNF0=;
 b=wF/pYr5QGBvLgjdgXG6m0PnirJ7atMCcLDLxYufIOYJ1sa7fEzzkmHIRZQG7bM3AAB
 rBlq29V/3c1IfUPRm0JWm+m4q4Z5mIPvs8B394CVDge3thswJZm0vpKsOgSICslpOIKo
 dNm5ASXa5qaqQ13i+KQj464AXf6/bYngtx9CvM/2S5JMclisQOTpEfvPDwCP5uGpiPam
 Ofe9TeCyCNCaVHSSGgiJUM8ClU24AN+UjbRFqNpjKT/mpFyxlZkG3MH/BNSJFL9MDen2
 TtO4bHOc9gUrnWzOssqbRLX1hL1wVMv/zY+wAtQsJ17+zx/YG9dO3sB4xg2AE1cyFpKs
 rUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965766; x=1765570566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RzyA3HkNRX9Tus5ZkFbRaNbbBPxBm1P3daJJ7bhrNF0=;
 b=WJ75II5pQ0d6bhp+XuTjzwoodas5omLda5IU4+45TlSOzEaKmGtgP/hLs4iNtj3KrL
 ibMIppvZKLTWsKQNLelPqgt8osV2ltNWKXY4zZC02W3ukwBWHsd1zbvksgfZAygPQC/i
 RaJNr2VDWHw8UyEOuYTZf6/7zw8Sx/Zw6Ab4NnEoU3Y49i6szebcsK80j1xM+V+DIyCD
 f903A0OrZqt3Z9AXQW4+fZOay0J4AHSwZ6DvdNPG9VqWLCrcDjEFAimUT4D0mtluotPj
 6KeSHqlbRJUr5OHfgSSh8uTtgiQIA5yR4RJK0jF+96Pi0lM44i82Gc1PraOkbKx92yeX
 Mc4Q==
X-Gm-Message-State: AOJu0YyaafyP9L9DNpVee1f9Sp4ffIt84tODXrtvn7lxppFPMlDme4jI
 QCNvBcPjaQmvKMFdfvKlPqXM0/TwLXvf9Si8O70QdivxS/759ILXWgusA+7sLXMms5IHArHbpP5
 gYG1k
X-Gm-Gg: ASbGnctqqLOuUd8x6xg53cCVy+pjz++Uyong8PpTGSlq/RbYL3znkJu2QF4qeZUSLp9
 jft8Xnn7bC2IDwdzhUDu9ZwWRT+dIEtORYQHIIO+Q/OC/dkxHZi6Goo0cCRpF8adSm5Y/ld+WIv
 53QVZDtaYbNb8MSPCqD03NL20e1e1sFfFxme0CYeceLlYWrJL0b3eQDTCfaAdG+i6etFa3TYSCE
 D2sP/J/LcNfUakHmnSiiKF4uCtplu6EnTI3hjEKRRM+b9eGIhbjWGetU1dPjJRkQkCzm+b4LZdX
 7OuzbwGvYbxL1OasT0tGkUpYK7bvuHAbJSxHDtZer5xiv5rKjvWivcmwyXMaKxG/rRK/PY9A9D1
 QQcY0Unv4zd7V/jj9cKVUsXCoLWLjqLI1HckLj/77mDKiB3gTCo7XiqqOrTV3Wn+x/457WsrbHB
 JMSTvVRf/nWhzm/75FKxW1HFU8kzfyRwUUt8diBHwvyUzSkIjCtg==
X-Google-Smtp-Source: AGHT+IFgb0+hHwS5zLUldUC4oK/gFFZ6oKFEN1er+Csx/6MiRnnSPDlKSCCRlrfL2QTqcn8YdkjQzg==
X-Received: by 2002:a05:600c:46c6:b0:477:7588:c8cc with SMTP id
 5b1f17b1804b1-4792eb19ee1mr92215845e9.7.1764965765897; 
 Fri, 05 Dec 2025 12:16:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:16:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 12/16] eal: check tailq length
Date: Fri,  5 Dec 2025 12:11:41 -0800
Message-ID: <20251205201537.251131-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

The tailq name should not be allowed to exceed limits.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_tailqs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index 47080d75ac..7502836c6d 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -67,6 +67,11 @@ rte_eal_tailq_create(const char *name)
 {
 	struct rte_tailq_head *head = NULL;
 
+	if (strlen(name) >= sizeof(head->name)) {
+		EAL_LOG(ERR, "tailq name '%s' is too long", name);
+		return NULL;
+	}
+
 	if (!rte_eal_tailq_lookup(name) &&
 	    (rte_tailqs_count + 1 < RTE_MAX_TAILQ)) {
 		struct rte_mem_config *mcfg;
-- 
2.51.0

