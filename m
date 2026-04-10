Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FFCF3ED40
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Apr 2026 13:58:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19514402D9;
	Sat, 11 Apr 2026 15:58:16 +0200 (CEST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by mails.dpdk.org (Postfix) with ESMTP id 46ED0400D5
 for <dev@dpdk.org>; Fri, 10 Apr 2026 18:29:00 +0200 (CEST)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-46fc5b8a06bso1372860b6e.0
 for <dev@dpdk.org>; Fri, 10 Apr 2026 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775838539; x=1776443339; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8iECH6CB1Rffp9F9B5I5/LJJpWIZz+tD1dFu5D4u9g=;
 b=K0c5bQU0ykZNY4txbeDkxnbtPCcT47psuHydfuZCR6Q3mNQJ+iUgtMeBqghpnuWK2s
 6/p9LoLm8q7T0HAptRGaauULndPPOl7dNhIaRM5DC2qohP+9FATC2X3tNs1BeZZobuSY
 UcQs3wVQj6bWhbC2tajnsC1VwxZ56NWtgCSBlIOc6NKuodqB3GUqg56thVKmqALbNyTZ
 4ybmFJGYtx+h0u7C8+5WSxXyoT6cUzKSqs+xzejFsagO3l+Lbw+v4DsqmAslPi4chwB0
 21JwT973POyFFYBt5umQH2lKc4GIBzjzzRrVj3l7wdAEK5BV3yCcLKuzbtRij7Bfz0uP
 +pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775838539; x=1776443339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J8iECH6CB1Rffp9F9B5I5/LJJpWIZz+tD1dFu5D4u9g=;
 b=EtuOn4tBZiswVStKefmP0ahCYwUVKdH0b66xMKyQzhKXh3iRnfn8s+7s2P9YxWdgmL
 7aSy4Igb6tgcWuxY56cL7rMLpStUBn+JC0zRcsy+NVz2/B9ogtXrPh/oxIFWa9G0j3Sy
 LetCWGCeQG0xKFCS2PTDBmyXFS1sN7aA1FGIaEpaoxkTpyGKq95iNJYucetFRfx6aRR8
 eZS7dmyyTXDIgSxV2IFvUixtTuMfPR+WvNsG1jkErZiC8JYLoOkWM+L2ml+X0bFdGr9R
 p3IfdYMtMJP+YSEFtABXtFj1hs4nFrabHxePDHs8U3mjUODb8VY0LHXapwuLeTcrF/TZ
 zCbQ==
X-Gm-Message-State: AOJu0Yw9DqgE9ck9LXP3TpdVDv+t/kpGOXtMpLKwrelzFMG90ggp8oRz
 z5DevuwEJ3A7ikANrIiy+QIrgRKLDSjvz8xMxLPYrDvf3T+nF+pWkh00
X-Gm-Gg: AeBDiesGpNNZGDl9MHDjzKFBXxGSCqJcxh0UxSfZvmuRZoB9zH8Omzr1GyuOW4lajbi
 W+QZvetkAyg/xSxaMMQxRbLBOmUQ/qnubcyISiGb58B5EPLNCMac3EXF7X5gj+SKXhsZ4wEiFuy
 FNxPWYB21nz+AZdrjPh3XgYRJOfflXUF69ShdAvPX5yuwhPm9TvNAXkWeLMxiRAyaX9hdgnd4fS
 bm1A8+pDeRRuE9lgninguh7NIX083rK4zknXoKkftzY8dE7YUANa5mMTY5VmzalipRJr3hRbliH
 MiJ7sQ+yQhfuGBIkPVBdIOyUDZe1dBjLCC62iDn3AdwEHa1WSoFyFSlPWLs52/WhtyeDerA0BqK
 G+iKbjT1KiWGOxOiVmxnrYpK0f7bOBGaNH+3RsLBwnZ2RgCcnPaILVeEx6/J3Kfq+inhExNHtTp
 J2XYSt1qBV7Zik
X-Received: by 2002:a05:6808:1405:b0:468:bfe3:17b1 with SMTP id
 5614622812f47-4772c8a4eddmr3649399b6e.23.1775838539419; 
 Fri, 10 Apr 2026 09:28:59 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2660fd06sm2267156a34.11.2026.04.10.09.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 09:28:59 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
X-Google-Original-From: Weijun Pan <wpan36@wisc.edu>
To: Rosen Xu <rosen.xu@altera.com>
Cc: dev@dpdk.org, Weijun Pan <wpan36@wisc.edu>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3] raw/ifpga: replace printf calls with logging
Date: Fri, 10 Apr 2026 11:28:26 -0500
Message-Id: <20260410162826.15485-1-wpan36@wisc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407143656.9960-1-wpan36@wisc.edu>
References: <20260407143656.9960-1-wpan36@wisc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 15:58:13 +0200
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

---
v3:
- change AER register-value log from INFO to DEBUG
---
 drivers/raw/ifpga/ifpga_rawdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index 5b9b596435..c6a1b193f7 100644
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
+		IFPGA_RAWDEV_PMD_DEBUG(">>>>>>Set AER %x,%x %x,%x",
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

