Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7025ECCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:53:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65CCC40E36;
	Tue, 21 Oct 2025 19:52:37 +0200 (CEST)
Received: from mail-oi1-f227.google.com (mail-oi1-f227.google.com
 [209.85.167.227])
 by mails.dpdk.org (Postfix) with ESMTP id 9FC9E40E34
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:36 +0200 (CEST)
Received: by mail-oi1-f227.google.com with SMTP id
 5614622812f47-4439fc3abfeso2418950b6e.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069156; x=1761673956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CxB7wWO80ywp52HefvVp8FWJFunxq6ZTbeR8TZkk02E=;
 b=tFRijv9iTojxUmKYyaHB7tHbixi2z9DN6/BCAsdDqTTv5y62qmQQQ4+wp6h8lqpViU
 WHoMlueiuOWG4FjrfDg07nJHaWnPqLxr+ppX3HEDIooP/qpk/cNYGrhCDVmu8pv0cIwm
 C5aAbGdzPtGossF8jxVd5CvmnJS/Ci78HjkGEuMjP3fbqw6xF2dHYuvL1MkvkP0jQY/x
 I3+ReGyP1zQuLqBrDyv3OULKYw7YQfY5It1jr6BKwTguc0GDNDjg2SX8aqL8tr6tft2r
 QMIIP8Iwgv8JjeXzJK5GUZvXMscoZJ8aorEl+RqazlUcc3r5N55hCUsI5WpS8GW3sx7Z
 a8+Q==
X-Gm-Message-State: AOJu0Yx6QkutYRbtssNqYI15ikXBc5ReZRSPruX0IQeU/N3d9ZIr9PLl
 hIG0A/3399dF76owWb78MryvxpfDy4ny96789+RLXlo2qF4GnjxmJDCwECn6fkNvDHYcvJJK/k/
 YC8swMe1cSKeyI/JACpAJ73keaxaPNHSUx42LBCuPivH2WhikjylcWaG2Pj7O+gPcEoSWqoOaD7
 SPcX9FAWIOi4kpOadX5YLTniHLjKxpikup5YnzXr4TkzLaQA5LIInd9UYmC5vL0CUJr68WVA==
X-Gm-Gg: ASbGncuRTwbbbqnQE23tK4HcNhq2NOvriSP9WkbfsP+MID55I3ykdT9aMK8nC6n1PmU
 EkAuOoz/1JhVDb4Iixawrb/Q798nV8uQs+4oNItPeCq+TVKTWnBKY0/En0UBL/FO7HiW6i0voG6
 divXnSIzXhVL7aT9RfyNml5J4lzbf/ch2QORdsgVA7vGQHcHJNsJk/bX+8r5DK1BbjQNzWcx6Zt
 ya18+tAM+RCrvGxIh9oFlrHWULzERGgpZKMqfWZh8Pb2fmX3ocYpNiICdEZA2fy9GunR47mANhU
 VfidUO/r2apVL9YWhgSXvDtr6nhlBN3ud3K9BL/9xN42dmMDTaJ3+Nn8368wuCAQcUCH3w9CEGt
 OL9PTX5W5OReeUdN1iUXLlC0sFcHXCKZbscNP3nQD6u85yF2Q9spmzZxPMXJZ+l/593VkU2O/F1
 ccGSnddRAPyOsrnP6tffRaGlDcrXZf5xc=
X-Google-Smtp-Source: AGHT+IHUjVaRMgdIHLOyrlS9IicWw+7zoYOzbib6Npy/n05+9qD722ppVb1RNhhwQa3v0NB5Ztcee4NcceRY
X-Received: by 2002:a05:6808:1907:b0:441:8f74:f25 with SMTP id
 5614622812f47-443a31c9a6emr8074223b6e.63.1761069155881; 
 Tue, 21 Oct 2025 10:52:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-651d3dcca10sm258172eaf.10.2025.10.21.10.52.35
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b5535902495so3424771a12.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069154; x=1761673954; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxB7wWO80ywp52HefvVp8FWJFunxq6ZTbeR8TZkk02E=;
 b=hNYdaxMH8nk4PdPHTVK3B6qux2brkfX8mA659IAVtc6tl0Moio3R/qYhG6QO7KaWAm
 gqcMAiyJwTqfFY6wRBYDveNvl/ogUVFn+DdIop1h36JK5e3kq+vytTtBw1s1kdosy4Eq
 ziBJGR0Da9pnjQm88WYJ1V0k/lJTHIRFcpl/0=
X-Received: by 2002:a17:903:4b30:b0:27e:e55f:c6c3 with SMTP id
 d9443c01a7336-290ccaca5cemr219624415ad.55.1761069153938; 
 Tue, 21 Oct 2025 10:52:33 -0700 (PDT)
X-Received: by 2002:a17:903:4b30:b0:27e:e55f:c6c3 with SMTP id
 d9443c01a7336-290ccaca5cemr219624035ad.55.1761069153259; 
 Tue, 21 Oct 2025 10:52:33 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:32 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v4 16/57] net/bnxt/tf_ulp: increase shared pool size to 32
Date: Tue, 21 Oct 2025 13:50:08 -0400
Message-Id: <20251021175049.46092-17-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Increased the shared pool size for table scopes from 8 to 32.
So that 32 instances of application can be created.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index e7778f8b1f..e4c9bfcff6 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -373,7 +373,7 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 	if ((feat_bits & BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE)) {
 		if (!BNXT_PF(bp)) {
 			shared = true;
-			max_pools = 8;
+			max_pools = 32;
 		}
 	}
 
-- 
2.39.5 (Apple Git-154)

