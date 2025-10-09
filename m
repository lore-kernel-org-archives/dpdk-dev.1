Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D699CCCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:16:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AECA40B9D;
	Fri, 10 Oct 2025 00:15:58 +0200 (CEST)
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com
 [209.85.160.97]) by mails.dpdk.org (Postfix) with ESMTP id E3C3E4067E
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:55 +0200 (CEST)
Received: by mail-oa1-f97.google.com with SMTP id
 586e51a60fabf-378aa12c13dso501397fac.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048155; x=1760652955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ij0hSuFP4lyPjAbN4hXlpNhbJAvcj6+7MhEvujeLGeg=;
 b=E2Vfn02kvfeWLe+PHqGRKdwqCWDsK+dOnvuKI2QS+sLw6s0ySnJ4zYjSPBqkRJzu78
 wjrgZi0/sjAbROA/6uXK5aHNQw12MzoR4lVMz9XaRRfXpXaGhrs85hybjvufM2/jRhT9
 tUmibJ2N0Nxd1+Ar6dqO3SPtZ60ZHyzbzcUwSegHAhIIJPY01YonCi90BYnUJiNqFWfH
 juNKS5oVdwPazdOUr78lFxkAkKO6AkdC+z1FwjlOWDKfYG5SDbi0ooAvQ1KMQ5g4VsDs
 LM9Xi5KwMIXaFN37YPcSBPd9rOGfBZ/tfZV7/BRMj6cwTiRNZkTQbZ1quWNVMLGNOzI4
 mYSg==
X-Gm-Message-State: AOJu0YyB6XPTpZf2OjfBGgtdJNTs24FPBcbjcdImTWTSEGicVFmdD9rS
 SpzJ0b/URvqQqh0JNovvTzVErA06BYum8D5oAD+hbNmBIMlrpfmj2BleTI7n97jKAG5E+vL+l1b
 qFW5AUKPIm3SY/OgeHD4N6JuFAmS714uvI6QdNzGjMkMpfX8zggPOavDf03uzCg/hoaEq51xQMn
 GWKRh/P91mQ5ilCr5ZUESEv4I8NVdyfWIhd5z1nOUyyeenfk2VR2J8mMofm4NBOi1r8NW9/Q==
X-Gm-Gg: ASbGncvi+YiGRq2J16xjXKk+SssiJBsUMcBGQFR240yPeYvwfjV+QbHkrYjX/njd6Vl
 RercGb9S/9n0dLIQ+eGxfGOIWjGIMY96TqpsvgNRaW0hbSI3+SM9cS/Q1oB2/e3GOuMrVxJ77Ci
 jtmt0CCOwA4GHqvhCTi/RNj/VcsWpe/98b8ToNyBvU60Al6/+fOv0+qrMMGNUwBWJqUxy69l+pI
 kME6T9DVnKIP4D0Kd8hdo7PgqdaOxD8uxM4YrCpX2f5YdfPSnC5s9tcFzy8Qs+F/MkuQNyp/1Dd
 cHMjEqhTKjozukopCJq+nl0or51qUfMrcYhxjjGnKXeSIWYOlFCrdT4rYeu15weCqIPQPD0epuC
 cCbaZDnrOXm+4lhJNSRv/D5x07XiqcxJPBj2QqKJL22XxNwqg65ai11DDmnd8Fmy1ch9BHzxvtZ
 VsoowSQ20=
X-Google-Smtp-Source: AGHT+IG7Vckq7x0S20cJlMEsh3oU2YBaYxD/QkIcb42jcirYofy7uIl/imDKSFgbwGkO02zu2yJsUErpaDc6
X-Received: by 2002:a05:6870:701f:b0:319:cad9:c6f1 with SMTP id
 586e51a60fabf-3c0f771c48bmr4266369fac.36.1760048155175; 
 Thu, 09 Oct 2025 15:15:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3c8c8f6abe4sm64026fac.22.2025.10.09.15.15.54
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-78eb8a9d229so42227026d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048154; x=1760652954; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ij0hSuFP4lyPjAbN4hXlpNhbJAvcj6+7MhEvujeLGeg=;
 b=RXtMAhoYXLEzzGj7oM1X+Bm9BGfg/r9PPzEFZOw6jyB0pXAEihIVvkG2Kh2JytXR3h
 rA2WJ5JNEjgYc7FR6/t2PNFgCofxr46/bHV1EnTLLlyCL9slkJ3ZHBbFXGIa2byPwhop
 tvh43tBRphqLRUq2RfORCGNhuxbZ6CLbXb2fU=
X-Received: by 2002:a05:6214:2309:b0:822:4bfd:239 with SMTP id
 6a1803df08f44-87b2ef6c77bmr119693726d6.40.1760048153967; 
 Thu, 09 Oct 2025 15:15:53 -0700 (PDT)
X-Received: by 2002:a05:6214:2309:b0:822:4bfd:239 with SMTP id
 6a1803df08f44-87b2ef6c77bmr119693396d6.40.1760048153397; 
 Thu, 09 Oct 2025 15:15:53 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:53 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Subject: [PATCH v2 25/54] net/bnxt: truflow remove redundant code for mpc init
Date: Thu,  9 Oct 2025 18:11:00 -0400
Message-Id: <20251009221129.28256-26-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

From: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>

This patch removes redundant code from two files which is used
during mpc init. The NULL condition check for mpc member in
bnxt_mpc.c file is not required as mpc will always be initialized
for P7 platform. The extra condition added in bnxt_ethdev.c to
enable mpc for tf apps is not required as it will be always be
enabled for P7 platform.

Signed-off-by: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_mpc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
index ff2f0d7043..2582b50782 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -719,20 +719,10 @@ int bnxt_mpc_send(struct bnxt *bp,
 		  bool batch)
 {
 	int rc;
-	struct bnxt_mpc_txq *mpc_queue;
+	struct bnxt_mpc_txq *mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
 	int retry = BNXT_MPC_RX_RETRY;
 	uint32_t pi = 0;
 
-	/*
-	 * TODO: This condition check is added to avoid
-	 * segmentation fault in case mpc argument is
-	 * missing in dev-args. Fix this by removing
-	 * mpc argument from dev args.
-	 */
-	if (!bp->mpc)
-		return -1;
-	mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
-
 	if (out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_SHORT &&
 	    out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_LONG)
 		return -1;
-- 
2.39.5 (Apple Git-154)

