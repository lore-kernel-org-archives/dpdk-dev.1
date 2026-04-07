Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C95FD5F92
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 08:26:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55DFB40654;
	Wed,  8 Apr 2026 10:25:44 +0200 (CEST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by mails.dpdk.org (Postfix) with ESMTP id CE1DB4025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 16:20:00 +0200 (CEST)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-463a0e14abfso2809184b6e.2
 for <dev@dpdk.org>; Tue, 07 Apr 2026 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775571600; x=1776176400; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MENlSx4Ne/ayFhCdAhk03aU6tshnblVsa0L6Tx6zdE=;
 b=F7vqF9rUrKE2jKm+ClG6yYHeXEHYdZgYFydIjsvPZdN6ibc6zQiaVn8EmqZRYRdx8m
 iAte4cAPq8pJi4Ukb9sTXRSzVfMslRIoL/ZaQCw7KcRi5EmNr70OG2DqOp28SMNpq7I3
 TgbtyxQlIhhUaaN22RTkdmz2GvsS3Lqp4aNk9uEvwOmTkIiEPoPognmPy+9/MjpQ+d/o
 Fd39YIiclqSWifmsn4BM/Mz2sY4QhiaHJeAGX9xaB6Uz9+0eQXuxymLNRv4ecU3Uv1Gf
 CJgMXcjifD0I8uuAdQPzLsBI4uBMMLJyLJs37dhX0ETrxhrh/HzBhYQIvx8lrfZQTQhC
 lLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775571600; x=1776176400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2MENlSx4Ne/ayFhCdAhk03aU6tshnblVsa0L6Tx6zdE=;
 b=kAeDGp1zr55vAWcfm3aquR4t8CvWIr0RklHDkdJrJG/Z616plVijpG3Luxk5DqaopR
 ARlTDt6R1JXR9Wv9ybfOBz/w8oDxrH35O39wc17DXhP2ZF4w7tBw++tb+Wqys9eNvSQy
 i8AhSF5yCvuMS1qyw2Q5/cuj89IHPpNFq2A7lnJVTv44L/cElN/CIuPe14HLkbaaNZ1n
 8rpf3b0kr9/QC0buIvTXgRlWLQj+nz2P9oR6tmyKAYT50wMvN4osTEAPuceEuiHyHd2u
 e40HcLaA24KJ1z+kH6S3InK0r94+GpuUFzcol6FVTvMRCIT6D50XFgOQyutB25ftbenI
 nsHA==
X-Gm-Message-State: AOJu0Ywe/qJBlRE6GuiJ9kyV4iT67BR3WUQ6Mg8i7O9hLTZuLFJWIIUX
 oE7CE/DhMl3zCVMFVRju+NV8YDUaGn/H2Dfe8eyYDJw4ksFGcmG2+vRtgLieCfF+
X-Gm-Gg: AeBDievbOtvxt7oHEYsKOQ/qHOupsa4tAixzTpHiRFWQTlVqkXBFrRvVUusXSEgZYhr
 wtVqzBc76LIqb5cF7++Sf3bsQicZxNPDbtb7Tcwr9wfGkHeJueku8YjMiAgd26gvunLQqT9eHCF
 rgERVVEwGs3Sf7N8iPjiwlDJ05EAi0Lda/O7LGX47LEaLf5c7eg2UHz3Arq3AGywVoJ3X36bERZ
 dIcog/h4TKcjENduXGpui+eB+pNUXGSLLXq6x3j9ZqTfOUOhP51+2LAvmb9ysVXoiX0khis7NBi
 ocnI0D/Q/D8nEUe8njFqP4aLQdtjdU8lvo0p0D+M50xNCEVw3zjnG5Vaj0OPJzM2H2yPHD/ghYE
 C3RMrvi4o36yZDkC2MFc9oWstq/XTqCEKlTCmfyu2QRoxnlMCFcQBM1qsalQhxFVd8fKkzz9/Vg
 bLTJQuWLNnBV9v
X-Received: by 2002:a05:6808:320f:b0:460:f435:2a70 with SMTP id
 5614622812f47-46ef8845559mr9177889b6e.47.1775571600024; 
 Tue, 07 Apr 2026 07:20:00 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d9387a763sm9994080b6e.18.2026.04.07.07.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 07:19:59 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
X-Google-Original-From: Weijun Pan <wpan36@wisc.edu>
To: Rosen Xu <rosen.xu@altera.com>
Cc: dev@dpdk.org,
	Weijun Pan <wpan36@wisc.edu>
Subject: [PATCH] raw/ifpga: replace printf calls with logging
Date: Tue,  7 Apr 2026 09:19:28 -0500
Message-Id: <20260407141928.9426-2-wpan36@wisc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407141928.9426-1-wpan36@wisc.edu>
References: <20260407141928.9426-1-wpan36@wisc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 10:25:39 +0200
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

The ifpga rawdev driver uses printf() directly for runtime messages.
DPDK drivers should use the logging framework instead of printing
to standard output.

Replace the remaining direct printf() calls in ifpga_rawdev.c with
the driver logging macros.

Signed-off-by: Weijun Pan <wpan36@wisc.edu>
---
 drivers/raw/ifpga/ifpga_rawdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index 5b9b596435..e004e002b7 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -434,7 +434,7 @@ static int set_surprise_link_check_aer(
 	uint32_t aer_new0, aer_new1;
 
 	if (!ifpga_rdev || !ifpga_rdev->rawdev) {
-		printf("\n device does not exist\n");
+		IFPGA_RAWDEV_PMD_ERR("device does not exist");
 		return -EFAULT;
 	}
 
@@ -491,7 +491,7 @@ static int set_surprise_link_check_aer(
 		if (fd != -1)
 			close(fd);
 
-		printf(">>>>>>Set AER %x,%x %x,%x\n",
+		IFPGA_RAWDEV_PMD_INFO(">>>>>>Set AER %x,%x %x,%x",
 			ifpga_rdev->aer_old[0], ifpga_rdev->aer_old[1],
 			aer_new0, aer_new1);
 
@@ -527,7 +527,7 @@ ifpga_rawdev_gsd_handle(__rte_unused void *param)
 		}
 
 		if (gsd_enable)
-			printf(">>>>>>Pls Shutdown APP\n");
+			IFPGA_RAWDEV_PMD_WARN(">>>>>>Pls Shutdown APP");
 
 		rte_delay_us(100 * MS);
 	}
-- 
2.34.1

