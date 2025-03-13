Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC92C35FF3
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 17:23:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 818B7427A5;
	Thu, 13 Mar 2025 18:23:22 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id BEE7C41141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 18:23:19 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-224100e9a5cso26975205ad.2
 for <dev@dpdk.org>; Thu, 13 Mar 2025 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741886599;
 x=1742491399; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iM1P0GEwlwx6G6xM48uXD/zw223qV3ECHYMEYWRJmUs=;
 b=lBSX0XQRMFTBXJXmw22TJ9L/kG6kd8k5nw4jONHV/8lK5ojNo3j0WIb1WNN4+0vObN
 9HQqidIJTf1DBzMtLnIRZw9Cp0ZPEtDeYOz2+2y8yO/dw8bMvgyjULrKhkFZuyYBr7bk
 kYsieGr4Zw7X5nawtF1RB04JgYRMgc6L3GCXrtoknYt3AAKlX8LJDD0KRLqHU92HnSDJ
 k8d95kVmkUskZOWnqJK5Y7R8tDVI7RP0WgiHsEde3KxCHExB6yBeXrG56R0xNsbHZHeH
 MiX5XZPp5eyDitsuNTz10lroVsQKb9LLfZW//iNBcwiV9jGdINDR/LrkxfP32ep7VIaF
 plFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741886599; x=1742491399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iM1P0GEwlwx6G6xM48uXD/zw223qV3ECHYMEYWRJmUs=;
 b=O955T+8nJ8HDUNT1Vdo4DOzWbx7vK0myXalT84O4Qkwwxdr1ZvdAa5M/iHhdmBVETn
 GA9u6mCRQH5vxVM0o9oe5FBmTfBe81cEvqwx2KMLlpAuwQdxDmR7f4Io/aZujZaVGIMo
 piObAL9qhInN6bh81uPgAuolxF35u8wRrjspDw9DS8n3s7pHvfxjhYBLYHy2K5hU4vYd
 C4QY0Z4J0ojTPPZCve0qP47pUknhWf6uNb078bJWsGxvGI5qt22okSjHkIru5wvwrzQB
 ePp12y7HI0/mk5zAsz3jGLo3CvgVWU1EqHCUNt4/L0BBHaqMIr6QrZiLv/KGPLl4EkHc
 3HiA==
X-Gm-Message-State: AOJu0YzL/Itbl78A3NHXszi0oB8XlfANIupn/mfmcwkXStlSsPTGHZ94
 HRVcJHdQv6S1XXGSzafd6njbTWiQ+Xr1Ienf6rkoKvv56EeN8HSdljn8CGvK1jwM/lv/19/cXS1
 y
X-Gm-Gg: ASbGncv7YWhUl4tlPqcVEAiaBhMO3kBTH7KYMQN+1nuAONwlCB8pwigJbeq2x9DBY3h
 05hgOmbnZKQceJqyxresaa//2IfXDjUEmF79V1keYKDvdo//Kw66ZGtH2bWnkPfsO1dU15P7BwZ
 SdyYnowpQC9ruYR5+8Tg7FVYA71hS6d6yP+dyAK2IRSX9xsUWreFaM8J8uOQSxAsQK6/0LVuUx6
 j9njv79xIJQp6tLn+aGnh2fhC1J0tDhdkvTXzYKmnCpwf/DcMrYeN5oZfRkS/vAYeivkWCzxRp8
 iHyXJkczcV1XfmrrnEVd3pl3twAlpeIVrEBO7e64+lMqeHYV4adDxTb0oDFMWdtM+1IDXD1/dYX
 JJYtjhRQ82N1nS9aiDbr2EQ==
X-Google-Smtp-Source: AGHT+IGNsex3HU1yf+z21F7BZFcf4syHGkP8+r1GvbzppDDY1RsELrvNgDoUW7UdWf6sCExRzWq4Ow==
X-Received: by 2002:a17:902:cf4a:b0:224:2a6d:55ae with SMTP id
 d9443c01a7336-225dd8b714fmr5741475ad.48.1741886598946; 
 Thu, 13 Mar 2025 10:23:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c5csm15867995ad.124.2025.03.13.10.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 10:23:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, shreyansh.jain@nxp.com,
 stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 2/2] bus/fslmc: fix use after free
Date: Thu, 13 Mar 2025 10:22:04 -0700
Message-ID: <20250313172307.274109-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313172307.274109-1-stephen@networkplumber.org>
References: <20250313172307.274109-1-stephen@networkplumber.org>
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

The cleanup loop would deference the dpio_dev after freeing.
Use TAILQ_FOREACH_SAFE to fix that.
Found by building with sanitizer undefined flag.

Fixes: e55d0494ab98 ("bus/fslmc: support secondary process")
Cc: shreyansh.jain@nxp.com
Cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 2dfcf7a498..bc03b4dd05 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -38,6 +38,13 @@
 #include "dpaa2_hw_dpio.h"
 #include <mc/fsl_dpmng.h>
 
+#ifndef TAILQ_FOREACH_SAFE
+#define	TAILQ_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = TAILQ_FIRST((head));				\
+	    (var) && ((tvar) = TAILQ_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
 #define NUM_HOST_CPUS RTE_MAX_LCORE
 
 struct dpaa2_io_portal_t dpaa2_io_portal[RTE_MAX_LCORE];
@@ -403,6 +410,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 	struct rte_dpaa2_device *obj)
 {
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
+	struct dpaa2_dpio_dev *dpio_tmp;
 	struct vfio_region_info reg_info = { .argsz = sizeof(reg_info)};
 	struct qbman_swp_desc p_des;
 	struct dpio_attr attr;
@@ -588,7 +596,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 	rte_free(dpio_dev);
 
 	/* For each element in the list, cleanup */
-	TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
+	TAILQ_FOREACH_SAFE(dpio_dev, &dpio_dev_list, next, dpio_tmp) {
 		if (dpio_dev->dpio) {
 			dpio_disable(dpio_dev->dpio, CMD_PRI_LOW,
 				dpio_dev->token);
-- 
2.47.2

