Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0DBFD5F88
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 08:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EEE740659;
	Wed,  8 Apr 2026 10:25:45 +0200 (CEST)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46]) by mails.dpdk.org (Postfix) with ESMTP id 5A0604025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 16:37:55 +0200 (CEST)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-67e0d3f288aso3200374eaf.0
 for <dev@dpdk.org>; Tue, 07 Apr 2026 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775572674; x=1776177474; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/eRLUHgMuSo55cXxCCKLTUiCqMsyU6B7NqUQ6ZNskak=;
 b=QM7tXuRc9PHMWUFZzOJ8Fx5N/jqwsTOfi2YYK3oD7BiGNsNiRXLamU7k0NMRb5AWsZ
 t6Dkt0EDmsxEKLBZg+ReIRvu0V8w/Et6k0xmw+SgHfrUm19sMWrPysccH1/Yxgl0ywBu
 JTNTKDvFJa11n2k96jWSLNRV4OxgDCh7hHI4DZaSaB+kQ/M41U4WE0frPVrB4dhtX2ZS
 ogageIvok1BuT8pK9iuqYBK2Kq1wTjHIFH01cSyX3icvvuAj+kE62Z1xlblUQXcR9kHF
 +lX4g65yB53dL9ML/oPKYIv5Mwrnsd2VcFNhky814OZmKUolJU5meZHs3Mt4XINJAnyo
 r3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775572674; x=1776177474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/eRLUHgMuSo55cXxCCKLTUiCqMsyU6B7NqUQ6ZNskak=;
 b=YJPbvW/MYRtttjzN9zDCGK4YlwNsMxL8seOTc8o9S4oHphnmEBZct5+BfrR0OecJEG
 B9dgLtWZLv3s1he0N+Htw2Czj2tsx+52aSUURPiVBeHyiZt62Blj3ipAqfXJL0mEsvQy
 ta3TnmIRFOpT/mn+0n1/Pi4bLRE8B6WbDL/3H06htInMTRXwxO+BfjlfzcZ9TSir+P6h
 vu5u2WXFFhYaGFLrjzXZP+S+kt5kMKVwHO8+cGIRRhgXGDaSiL7TzPh1m3N8AUNm2NuY
 5bKWNdYftB6fLgxusmqQTY3itc4QPEduQd6IV/gNiD75ZlDyB7bJdyqcwJhs+X/eZyFO
 86XQ==
X-Gm-Message-State: AOJu0YxtphGs90moDynkvo6gTe2rtAXO5F+eXq9gke4234RNUy60R2Bd
 Xvbc5XkPmYfbjltwy3KxZZ0V54ojBuVzQyEsVEILGvWc9eI7XxPF6x4X
X-Gm-Gg: AeBDievV01LWoQuxfpikGmUfZHHLUJjuQdyjf3Z3uWZyL5e53rvg/F4PFK3t5nefYPk
 zIJzs009JXyvM+SubF89H52mUSazrCEXBsr2ng9iWKmexxbSa0lTub0eQFwk33//ap3H+g+ZyTO
 g8oZWka+FBEi47ImyvbA+yTlfqxqSQAPDPUiYn/iQjwYlHBO37qIXkYBJkdbLaptdTN81GBy86j
 FR/gBWvoyjxmCwf2F2fgrIJbxaDIxQBMiB1qcWL3vmRvlFtovdudW1eg5rxCrKjAPcqeIYnlZqI
 aREwOhb20/MD2owUAucEonUk//DosbJGdUkEob2TPqQfZcKwetC5JEcURB2UULX6zO9JNaDfZRj
 8a7j/UIYUjmE9ksWVUUnuinM4nGLx9FUw0WSI4wO9pF65WOWITz5ZxkR5zo0pttT013NA34do9k
 sO/coP4xrE0ajg
X-Received: by 2002:a05:6820:81c4:b0:67b:b8d0:a7d5 with SMTP id
 006d021491bc7-6822024fab7mr10092694eaf.53.1775572674476; 
 Tue, 07 Apr 2026 07:37:54 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6823d419d09sm7870603eaf.15.2026.04.07.07.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 07:37:53 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
X-Google-Original-From: Weijun Pan <wpan36@wisc.edu>
To: Rosen Xu <rosen.xu@altera.com>
Cc: dev@dpdk.org,
	Weijun Pan <wpan36@wisc.edu>
Subject: [PATCH v2] raw/ifpga: replace printf calls with logging
Date: Tue,  7 Apr 2026 09:36:56 -0500
Message-Id: <20260407143656.9960-1-wpan36@wisc.edu>
X-Mailer: git-send-email 2.34.1
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

Resend as a standalone patch after the previous submission was
accidentally sent together with an unrelated patch.

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

