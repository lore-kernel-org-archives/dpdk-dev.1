Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4631BCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 20:44:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E96CF40262;
	Tue, 28 Oct 2025 21:44:36 +0100 (CET)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id D4D954021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 21:44:35 +0100 (CET)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b6cf07258e8so4421340a12.1
 for <dev@dpdk.org>; Tue, 28 Oct 2025 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761684275;
 x=1762289075; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J93lOw1oqsROzGwzqkS+iY3dZBaQbvQYgo0Eigo9MWM=;
 b=Mw7AaH0M2nDXg9JFFkRqji0fTfBPVIEqT8mZY8WuNRZSlOE8Lb4Migo0BvdGSfLKjN
 dAW8iShi6Xc87FI3DmZ/DUBEuhgz05zvpefr54omWaf/KYJQVPmne8iW0d7Ibb/o6Jdk
 1eiM8uNwnehsgEH1OkHQPzXFnccQrSdRju+TRztqnTAguErCRs1R6h7NFQT9S8/SidTi
 80ZErSB/O6KrWRCLPCDlKZLObKNJWWOWD8dEqshCqto2DmzU4bkrXz9lhegnpevRZwXJ
 eMyxzdeipnRH2tK22LxZAJlk2ZNA8jwctOojpv2ZN4dtF/uQvRMvSWKWeslCewWtqdHp
 iZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761684275; x=1762289075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J93lOw1oqsROzGwzqkS+iY3dZBaQbvQYgo0Eigo9MWM=;
 b=Jlb7vJiGcQxbs/wRWKDi71Bjxj3pP0IG/shjW9kocgDJD2nrb7AncIC9hmelH+8RDL
 ZCta8cbVNSEEMEl7uhaSCTQII5U6PM1VQJsOfloiXr/8tvcCY1Wwr3yH0ElcnlaGUEH7
 6Ja+vQ/5U7wng9Kg9s9BUHVBeHK2tT5oVFBjliJzRDgJg5S2NpXkMLr9c+IzTDMx64Et
 bDp4LFug1xDnX8Vd2P5fI3lVrmHj5H1XGZ4cFUyeiLkYlvGrIRafOgWanjF+VN9ZILAz
 v4rrjtoRpvqpVwi58l4LPTRo8Cb3HgV1oHRhVqp3Xjc3rEyh1cDuJnEoLdQDyQxAoPoY
 GxqA==
X-Gm-Message-State: AOJu0YxB/0PQLr3W/dOT4HhdLHmiIZCQZKHzJGKVIs/3peEhGqDw+75d
 64K/7un7klSxyyl1ZIWjtMagDmlInrf7kAvQGyuHUIBFNlg+KHAc5pJP9OT13SgBKfU7fVY8NhC
 fVXEIUtA=
X-Gm-Gg: ASbGnctCz0gy8L4hAlyeTszZt9aJMS0JIpmA8v3rHmX+BdEL8VRbT1kOil2f2djSyYJ
 JbESGIRq95R3oyjFY2EmIu1oj+LYjMreBnds3lB26pQ4+FyGOeMskV8Kikg6BXpHYRaRl4mjfU3
 Tq9Gmv9WnrQywL+vTH9d6QWjQ71AbfrvqaHU/Qtuemf/cG9mRH7UKJscY3+Sz+c304EnYygbjyn
 anmDss4JyUEnHS4/hVtKfrlmkk6ntDU+VzZsV4FZ1qSr5EmWVzrfYzT4HQr9ASY8kip2BlxQ4WR
 bjQnX+FGGReA8rC0heAzmWDCGanpd4JtO9lHrruLD2kvuG48vK7esNQuJZEtilGAoffg5MRtf2o
 Wz/9AnHkQ0v8sHM8ie9Z2y9zovh8nF/20oUWh3FRsaxRaXYxmNlyFkwiLIILCMLbI73uC92SzI0
 I4cWXVAF8k73737BdDe7Kuy/z4gI3x52R3ExL3QHQ=
X-Google-Smtp-Source: AGHT+IEGjaw5m346YnbRIIQrm7FSoi66RHHHUVLQPNJkPu66YlZfJEkn7lwgaeyr478jW7INQ3zfCA==
X-Received: by 2002:a17:902:d48b:b0:294:9132:75a6 with SMTP id
 d9443c01a7336-294deefd438mr5840085ad.53.1761684274854; 
 Tue, 28 Oct 2025 13:44:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3402915612esm2018380a91.2.2025.10.28.13.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 13:44:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH] bitmap: change return value of rte_bitmap_free
Date: Tue, 28 Oct 2025 13:44:32 -0700
Message-ID: <20251028204432.880074-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

No existing code is checking the return value of rte_bitmap_free
and other functions like rte_free do not return an int.
Change it to just a stub void function.

This was motivated by Coverity warnings about unchecked return
value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_25_11.rst |  3 +++
 lib/eal/include/rte_bitmap.h           | 14 +++-----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c5ba335cfc..4b8e084204 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -220,6 +220,9 @@ API Changes
   The link type was previously hardcoded to the Ethernet link type in the API.
   This argument is added to ``rte_pcapng_add_interface``.
 
+* bitmap: Changed the return type of ``rte_bitmap_free()`` to void
+  for consistency with other free functions.
+
 
 ABI Changes
 -----------
diff --git a/lib/eal/include/rte_bitmap.h b/lib/eal/include/rte_bitmap.h
index abb102f1d3..5a4a68cc2d 100644
--- a/lib/eal/include/rte_bitmap.h
+++ b/lib/eal/include/rte_bitmap.h
@@ -280,22 +280,14 @@ rte_bitmap_init_with_all_set(uint32_t n_bits, uint8_t *mem, uint32_t mem_size)
 }
 
 /**
- * Bitmap free
+ * Bitmap free does nothing in current version.
  *
  * @param bmp
  *   Handle to bitmap instance
- * @return
- *   0 upon success, error code otherwise
  */
-static inline int
-rte_bitmap_free(struct rte_bitmap *bmp)
+static inline void
+rte_bitmap_free(struct rte_bitmap *bmp __rte_unused)
 {
-	/* Check input arguments */
-	if (bmp == NULL) {
-		return -1;
-	}
-
-	return 0;
 }
 
 /**
-- 
2.51.0

