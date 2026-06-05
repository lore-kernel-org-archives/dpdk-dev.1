Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593C5CD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 20:53:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C65C40672;
	Fri,  5 Jun 2026 22:53:04 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 97A2740667
 for <dev@dpdk.org>; Fri,  5 Jun 2026 22:53:02 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-9156b74006aso175516685a.0
 for <dev@dpdk.org>; Fri, 05 Jun 2026 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780692782;
 x=1781297582; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=da7MJCbmlm38VHysERl+CiyQw7M5F7w7fvyLt3oraJQ=;
 b=K3k2NLh4q2soYOKT8jQBTsrwiq1Q2lYOYX0ljR2nsnbflRIbd3Nzg3YIaZih/0wHIT
 VphmBluinSoiTgQyOCxALuUiDE/yX6k8msp/6BbgzeFT1cALuMsE7/TsqZUu4NPWN+yp
 xhm9AuqSJj4SHsyG43+v71dMNFZSiI72zbXFh2vcP54eskOkjQiuXsTzrCjCZv/mJcoJ
 VLuzkZfBwiIsCqaZjCRw6K30CkAjlLgZR8ZICDGnWIc/Rl6X4V/v2MdSLmBPxjaVKjwX
 q/iSmhoz3hpz5JNfERiUe/3PSHavc4/iMBEYZjDZ1NQNs0IhywiVfkJFDlUNmYzULGQ6
 iytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780692782; x=1781297582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=da7MJCbmlm38VHysERl+CiyQw7M5F7w7fvyLt3oraJQ=;
 b=fR8/kQpVMGENf5hPThHSRYuDNO83Ao2NO3c6FwTCwGIUiZXR77IOT754cDFqdLxVj8
 eFF7BygDDYjUtBxU4s+OLBiX8T1lWlbs4GgZ+4rGSFycCkLYPU/xVMOleAfYOjwWq5ZF
 HivYNqZeNxG4lic1x34dt0bZ0sjIlgoowiosvFoIxE6it6prTlM53mHZhxhHslGj6D1M
 wIVMBSBgeRpmGL6fpiGYTD4snUirra8yB/RYZhzj+wPCbMi8+DrZkGFAgJnW8+jFshBM
 +lolEf5B/EoWgUwmXcWB/jJclDP8UvpF9Je5zb1Rdhc9UZER4GXm0mI/mY47A3EmUy87
 FKAg==
X-Gm-Message-State: AOJu0Yx+xbHfr8I2poV2p6Uw32yYceqffVrJUs49/ycMFlKI6dPE9Ys8
 u5unNWzER/bmDSJC0ekJqQPE3xK5soWSr3fH9xNNfmaxY/e2ChMgb17cd/FXxMEJ5i8tBaXMgXJ
 Q6r7c
X-Gm-Gg: Acq92OG/pF7DpXL3FrlxsAg8IVQ/V0UDVLgS2LiBmdw9dJavTSKIwwDkjiwXUyTQLUy
 9olGpgY/iWyoxPbGDIpEopCvWO/VL3B7u5JqyVsFk7mTcqVrJcvF64ksWaq+hPLhAdJxA0M94Ud
 ZupHHH2VUU1sFZ2rDxLMwJMETJgjNnKSLxZ1NhzH9gLic4X5erJ5rGIiLtMCg6+cu3c8MZwIeD+
 4aBVZENx0iOH6cEduj1hwqSvjA48YtamRd17Dn5arcUR1jGcVtDUja+b3Y2HcTaNztJjERytZQv
 chOYL1JUDbKXwvYjoIvMrRRAWWs/E01CMoQU3KU6heqZC/OTUIwQgbsUwf8ajovtQSvgEdJJ2Gk
 DG5dRR09cHBa5UApoutBGc3EQUsbnqSRMCJNklSEpuHDmVSb0geYBN4pheOjerYenvXZnqy7pIL
 H7djN/L+en7Z4lbYmUIy4bG6XpE1H2MXDxqKpYIsEukAhJrSBbRsgfeWFE//O7GrJrWJHmXeWiC
 IX5IE3nUJQ=
X-Received: by 2002:a05:620a:6084:b0:8d1:d0db:392e with SMTP id
 af79cd13be357-915a9d60d46mr989562385a.32.1780692781870; 
 Fri, 05 Jun 2026 13:53:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd2629cesm90072906d6.41.2026.06.05.13.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 13:53:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Conor Walsh <conor.walsh@intel.com>,
 Sean Morrissey <sean.morrissey@intel.com>
Subject: [PATCH 3/8] dmadev: validate telemetry parameters
Date: Fri,  5 Jun 2026 13:51:00 -0700
Message-ID: <20260605205253.520196-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605205253.520196-1-stephen@networkplumber.org>
References: <20260605205253.520196-1-stephen@networkplumber.org>
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

Tighten parsing of the dmadev telemetry device and vchan parameters:
reject non-numeric and out-of-range ids through a bounded helper rather
than narrowing strtoul()'s result to int and leaning on the downstream
int16_t/uint16_t API to revalidate. This also drops the thread-unsafe
strtok() in the stats handler.

Fixes: 39b5ab60df30 ("dmadev: add telemetry")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/dmadev/rte_dmadev.c | 44 ++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index b75b4f9bd1..822bb7c89f 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -4,6 +4,7 @@
  */
 
 #include <ctype.h>
+#include <errno.h>
 #include <inttypes.h>
 #include <stdlib.h>
 
@@ -1157,6 +1158,25 @@ dmadev_handle_dev_list(const char *cmd __rte_unused,
 	return 0;
 }
 
+/* Parse an unsigned integer telemetry parameter, returning the value or
+ * -EINVAL.  'max' must be <= INT_MAX.
+ */
+static int
+dmadev_parse_uint(const char *str, char **end, unsigned long max)
+{
+	unsigned long val;
+
+	if (str == NULL || !isdigit((unsigned char)*str))
+		return -EINVAL;
+
+	errno = 0;
+	val = strtoul(str, end, 0);
+	if (errno != 0 || val > max)
+		return -EINVAL;
+
+	return (int)val;
+}
+
 #define ADD_CAPA(td, dc, c) rte_tel_data_add_dict_int(td, dma_capability_name(c), !!(dc & c))
 
 static int
@@ -1169,10 +1189,9 @@ dmadev_handle_dev_info(const char *cmd __rte_unused,
 	uint64_t dev_capa;
 	char *end_param;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	dev_id = dmadev_parse_uint(params, &end_param, INT16_MAX);
+	if (dev_id < 0)
 		return -EINVAL;
-
-	dev_id = strtoul(params, &end_param, 0);
 	if (*end_param != '\0')
 		RTE_DMA_LOG(WARNING, "Extra parameters passed to dmadev telemetry command, ignoring");
 
@@ -1227,13 +1246,11 @@ dmadev_handle_dev_stats(const char *cmd __rte_unused,
 	struct rte_dma_stats dma_stats;
 	int dev_id, ret, vchan_id;
 	char *end_param;
-	const char *vchan_param;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	dev_id = dmadev_parse_uint(params, &end_param, INT16_MAX);
+	if (dev_id < 0)
 		return -EINVAL;
 
-	dev_id = strtoul(params, &end_param, 0);
-
 	/* Function info_get validates dev_id so we don't need to. */
 	ret = rte_dma_info_get(dev_id, &dma_info);
 	if (ret < 0)
@@ -1245,11 +1262,11 @@ dmadev_handle_dev_stats(const char *cmd __rte_unused,
 	if (dma_info.nb_vchans == 1 && *end_param == '\0')
 		vchan_id = 0;
 	else {
-		vchan_param = strtok(end_param, ",");
-		if (!vchan_param || strlen(vchan_param) == 0 || !isdigit(*vchan_param))
+		if (*end_param != ',')
+			return -EINVAL;
+		vchan_id = dmadev_parse_uint(end_param + 1, &end_param, UINT16_MAX);
+		if (vchan_id < 0)
 			return -EINVAL;
-
-		vchan_id = strtoul(vchan_param, &end_param, 0);
 	}
 	if (*end_param != '\0')
 		RTE_DMA_LOG(WARNING, "Extra parameters passed to dmadev telemetry command, ignoring");
@@ -1276,10 +1293,9 @@ dmadev_handle_dev_dump(const char *cmd __rte_unused,
 	int dev_id, ret;
 	FILE *f;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
+	dev_id = dmadev_parse_uint(params, &end_param, INT16_MAX);
+	if (dev_id < 0)
 		return -EINVAL;
-
-	dev_id = strtoul(params, &end_param, 0);
 	if (*end_param != '\0')
 		RTE_DMA_LOG(WARNING, "Extra parameters passed to dmadev telemetry command, ignoring");
 
-- 
2.53.0

