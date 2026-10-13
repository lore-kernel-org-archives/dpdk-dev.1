Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA13CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88B9340BA2;
	Wed, 14 Oct 2026 00:35:13 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id D4A2340B99
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:11 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2e7e742a2c7so23441455ad.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930911;
 x=1792535711; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i44jwQBOEGAULy+WJDBHE8WSa9mfIvcvbKfK6YTf4X0=;
 b=PpXTUy4ONpu72jhm6/nMbtYWKEuyijvzp92FwlLzV1oj8rpgVgDI8YgDqlokh9tmoR
 xOODTdeusKMZkx+X4dBmwEcYROpslInHPMnP6R7+rzYm4J+UQMUDJMAqLb2+N09DZat7
 ECwPvHW/o+tliiowiYez26iDwo36T4uKDo9ULlasBRccWAt23fzWVAD3MA3Bz7s3gbUc
 JjjfuiJPF+7Cs//7kBm4h2L/DlERKL+gMndUuR/T+pplK1NZya3T8nGLbKX6XNRYAHy6
 MqLVKcDKLf6Tuy0Ly2EArf+Ff/V+Tp3YS/6Ya5dTUcsK9kRxTp1/qq8TE6RTAEk5OcC8
 euHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930911; x=1792535711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i44jwQBOEGAULy+WJDBHE8WSa9mfIvcvbKfK6YTf4X0=;
 b=FgjawI2dMzxRfzTvPnCx41xEvefMm3Qq1ms8NUYIwGvdNNwOEmKZaRirkTgeZGadcv
 buy3BNPDjfKDyVsM2oHHQKDLlKgD1ElYHNTxE3GriAbiG+gUgrm1lgzTYWkYk3kbZ8jb
 TLNLpTPfYzFIEdJTFIqEYMPdxmmKeI7lrGw9g1KAHMiOJL2MoX0T1xVtYniHZGuyvzrP
 5Igm1g/NXbqNSosCGsxZqNTuYeLr09KQpfIlIPXQmrFD5XPrfw2qBlXudpEbkxpIduCU
 YG0W15YhAYYkufY71c3H9R1LppjOFqfkeQitPN0bEkzVtZ8nzA+qsTejQlSbCQKUVIFy
 7Vgg==
X-Gm-Message-State: AFq9FYJ/hNUmY+aPD68iOEkiXdH15/4BzGgCiHiG8+yLVzyftM6kLon4
 a7RDQ85SVDqh45r+Rk9WaORhxu8Bdppq82+dKkZvd6HtjvK5x/Dy3QUdJvWetNb3Jfhz1AcsEet
 1iFTb3jo=
X-Gm-Gg: AYBFou18wRcRkWV3mC+0yZlrcTwbQyp67cUEtAqeBhlEGlW7GiMb7KjyPGL3m57GAM3
 WBlpalODbSQOIiXUzvmeS4IO3YM6PK0BYFMF7RT7MK56STH9wCnIIUYFi6RkC8LwO1SOvUBrGCR
 Xb9mPUUVVri+/hJirmh9sQmugdyRDhC51dKn9pR+fTdzWNgAt6ZwmzcNda42IshUJdMbYKr1TxZ
 lpgl0iBlnFE9trn8zrPJaDeiLxQj2OC4enS9EoFhA3X3o4ZzRZ2ahNMFb0rkcF14TXwUtAZiH6o
 kLdtmZC3vEoDRUyKkW9u046/YLnuyO0yysezb0i7lCgOraETYIA3lZ5fcT6baV1c6EIH+/LKT2y
 VJoPHclAZlXRpXpc4S4p0111rGW0Mk61sVv39k/ziVcAHWDIKkxIBPYr1BZ3FjthRQmvKlwfKSj
 VC/pzH/thSh/4iHxFKptExg0TjVlFOlOCCZo1BI1psgTGH1YKr2MCm7fn6R7jFXTtLhgDc0QXZV
 0HeLnbBjfQo6ks0vansdV2uCWJrNqdjIUopTTTRCJ18RAyT
X-Received: by 2002:a17:902:ce0e:b0:2dd:c053:b9cb with SMTP id
 d9443c01a7336-2e842cfd1b0mr87351565ad.28.1791930910942; 
 Tue, 13 Oct 2026 15:35:10 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 15/29] crypto/caam_jr: use IO barrier before job ring
 doorbell
Date: Tue, 13 Oct 2026 15:22:28 -0700
Message-ID: <20261013222410.2257622-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

The barrier orders the input ring descriptor write in DMA memory
against the MMIO doorbell write. That is device ordering, not SMP
ordering, so rte_io_wmb() is the barrier that expresses it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/crypto/caam_jr/caam_jr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
index a7d314bfab..01a9bed1ff 100644
--- a/drivers/crypto/caam_jr/caam_jr.c
+++ b/drivers/crypto/caam_jr/caam_jr.c
@@ -1451,7 +1451,8 @@ caam_jr_enqueue_op(struct rte_crypto_op *op, struct caam_jr_qp *qp)
 	/* Set ptr in input ring to current descriptor	*/
 	sec_write_addr(&ring->input_ring[ring->pidx],
 			(phys_addr_t)caam_jr_vtop_ctx(ctx, ctx->jobdes.desc));
-	rte_smp_wmb();
+	/* Descriptor must be visible to the device before the doorbell */
+	rte_io_wmb();
 
 	/* Notify HW that a new job is enqueued */
 	hw_enqueue_desc_on_job_ring(ring);
-- 
2.53.0

