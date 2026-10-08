Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F45CA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CA3A4021F;
	Fri,  9 Oct 2026 01:37:35 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 43F43402EE
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:34 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-887fb6c0ad1so2010308b3a.0
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502653;
 x=1792107453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cd2ZaDFNTVmRhmn3FmQVWsFaq3/lXlpgh+Csh2aFOL8=;
 b=IrfvqFmiuZFSxyQAxl5cNT+Jq3gjrWes7RV9gElPFGsy+PkbQNlhh4MbZ04I4mi03o
 iyjycH3/Nw5yLemMuKOQSO9QSDTyryqYbrLioPkcjflT/UexuoUCn1SMx3mV2h0f0+mD
 eDAG4e3TDyq35p/xJzKBZrpAyRq2BRPtGc7LfDxaTxoKHTir2XIv3TOKZHxouYcxZk6T
 HQyBGwhXhw/IC45hYRZzoFa/+34Sx3RHhusoojnHRlL/LbKzC5CiFgHHKUZfDtJU27Ya
 MNxUPCnYHhZNe1PVysceJg1IdPdMT6D5pHyZOWD4LjGtpOpdVOfXd127fUNJyUUw87RY
 SXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502653; x=1792107453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cd2ZaDFNTVmRhmn3FmQVWsFaq3/lXlpgh+Csh2aFOL8=;
 b=J8dFGA+lN20U6HnTYL2eFCkpuPZCYzORt9HW/APE0G3Y/ZP/OO+mjGCFDFntLx4jo8
 eIE/HV4YtGjR3gYXQs74lmjzcbPvcmZWT+bjoIynJrmMVre8kAje2MhOtItXCQTqFbNV
 L+wgAZ6UsbiNkblzN3CvfF0f4qOilNUxlXjABpb6OH2sPqJGLg/93hQxbvGormQ1f1cu
 1Eu4/AoMr/p44m+hdAUvHRH0WasD9RXVXFOtlgZ1ylK9PANn/wJurZBx2sNxdyYe45PE
 RJfE4xxqUiPqCt0bBcadQeNkDujEkbVzvZ5clNAt6U8aLLY/B2msYVIcQ/8zbCfgpiOe
 ZTsg==
X-Gm-Message-State: AFq9FYJx+FBg26lohwqcsx9CgtTnGkN5NuL/htOGy4xeJKtHNf8KCsu6
 8ni0fxZHsBWLhaAQMjjz0X9DHU5CiZ++JGL1C8POU3BWiC5c4r6KY/Gu0Uc5qng7Km6LWfjXMb5
 sJS8loLY=
X-Gm-Gg: AYBFou3mvZBYL1rSylZlka+Lo1xkvSwqSdRkchD3uSE1RHECbZifQlqB8HVc/wqO6pR
 lw/1PXDJLfQD8BWApwxvPl0VyAif+ygCilfYiyVdMfH2zGc2KYXweYd4WwA1d444LM+Kf9uVgcI
 mxmkSX9xBh9YrQK03izGAS/o0aEeoU3/sKz2bOtjjrWzU67wCl3Pt/oMBfMUaF758ukrPGf6UCx
 9UN7gawxcctbsXVt116LSAws92UxtaDom8NtSPOgmtBql6tzrgRK2Og0mlrb61L6auOq9YVf2PF
 TklMxj3xflcXGGAjoTG7F1pGFth6XkM5IcXtfsl2Qa97AiQmvYlZoaWkjr99Zs5/NnrXKdZikdy
 e8bVq7HFYeu+c0bgKhGYdE3ZU0f2zKy/nt3vBzmZOpTEczYDgwosh+/tz4rDTKie8exPJv6M+H3
 bg2CrGWltipkl0g5CBnGts9gLWqfWG3GtI3P1uaCB0Gh8u3YOFE0PcavYRCOpWI++ZrIQOnMFsN
 6hZWbmmnIE67NnWlGnTFHxvvsOqsvMlxb4cBw==
X-Received: by 2002:a05:6a00:992:b0:885:8fb4:6b0f with SMTP id
 d2e1a72fcca58-897c7add988mr50506b3a.49.1791502653160; 
 Thu, 08 Oct 2026 16:37:33 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v3 16/29] crypto/octeontx: use IO barrier before doorbell
Date: Thu,  8 Oct 2026 16:35:09 -0700
Message-ID: <20261008233649.1260843-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

The doorbell is written with rte_write64_relaxed(), so the barrier
before it is what orders the queued instructions against the device.
That is device ordering, not SMP ordering: use rte_io_wmb().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/octeontx/otx_cryptodev_hw_access.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/octeontx/otx_cryptodev_hw_access.h b/drivers/crypto/octeontx/otx_cryptodev_hw_access.h
index 3104e6d31e..096dcf8f87 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_hw_access.h
+++ b/drivers/crypto/octeontx/otx_cryptodev_hw_access.h
@@ -203,8 +203,8 @@ static __rte_always_inline void
 otx_cpt_ring_dbell(struct cpt_instance *instance, uint16_t count)
 {
 	struct cpt_vf *cptvf = (struct cpt_vf *)instance;
-	/* Memory barrier to flush pending writes */
-	rte_smp_wmb();
+	/* Instructions must be visible to the device before the doorbell */
+	rte_io_wmb();
 	otx_cpt_write_vq_doorbell(cptvf, count);
 }
 
-- 
2.53.0

