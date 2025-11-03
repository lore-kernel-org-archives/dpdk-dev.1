Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96291CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:50:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C72C406B8;
	Mon,  3 Nov 2025 17:49:43 +0100 (CET)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id D4D6A40A4B
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:39 +0100 (CET)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b55517e74e3so4536999a12.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188579;
 x=1762793379; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nmEK7+QOmytXdp4x4RQrzfZfkjLxsXIhbFrhPa72gw=;
 b=pWraZWiBYPsoCdKcUMNPoIT6Z1qTcKmdOeTpthwzCfobkh2eqm8n4BpSV5DZUALt9n
 +K437q6ygKHGL/VRc9mAH7xQKrJ4Gob/ZtvzW06IdwlHuAwSGk0mndXSTqJjgVmXCoSR
 iPzxiQh2rrxGdlyACXtUvYOxPInnH2yjfdYn7fTw3yPsg3OGnDznj8HqOEfFYFyubjr5
 /deJVTMg40HWO9yivdNlppt0/sByN9CwGfMDhWcZgRqdHzv1Afa7qpbLJ3Eik4tANUCn
 dWfRQdflKS6M6Jwk7XtPFXW6VbsoygTx/3K/td/XdCGjTf/S3Vz5WprP5kNS8ZOZ3QSM
 eULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188579; x=1762793379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nmEK7+QOmytXdp4x4RQrzfZfkjLxsXIhbFrhPa72gw=;
 b=ngCsqRgsUnc1ATuzTORtV1l+139PWxh/nS32+Cj7tIIFnwb7S3v4Q9pbjznuara78M
 dxOnX6ip36uO4xEhNKerDuA/OBPPryGaXc/zkOvysx6X9GHKY42LIXuSyLymMV6Mw1PR
 HdsiqWI3EgAFEcAyK031W+iDWkIlX9MdTHi1mpB55h3NI2rU3TyOooRCrTR8rOPk32HC
 uZk76iB6Y/JBq45rUebWLw/Sc/OyAQyqNaQ6SQKzBmXGn08XM6E/asCneCZO7QIiR9+k
 BcHU5E8mUuXyABpwxyrOvJGSDjRcLRNpbUSWoOqqihadk92jk1az2E6G85kQ+Q2ZMNLU
 yXVQ==
X-Gm-Message-State: AOJu0YwqR6Cxm+nremWyEu2gffXp/PtpfSwhwfSsSBw4UTxOmjjCRyA8
 yP0RRZwU9l37aihv5+aPxo5dHbx97aduOIWvmHWOFjCh9Kl9f7/KtZpGac+1B6i4gx/xoKeZzLt
 kddPl
X-Gm-Gg: ASbGncsedB9RE34p2yFeW17fQZ4AwYgM6oOJhHICO5lIK7tI86yuZ/c5TahuOcIIu/L
 cvHpBwcfCWgpRHEeovYLUqXn66/QixXlKEyaMuBQfiVYY3yaMPtdJn8Sz/7R2fTKfSUeP7h3rCp
 KA4GOHutto07yKwyhm7BG/w1iMVKkSTUU8BP8Z2uril0aJ5jInob3E3sXYFkaIwLRVGNY7+b/N7
 bdzHlsVaZ2vMckQl9IGYhBQpWlspZ5LxqNdg3SjO50KbcUnY5H/hvnaVKsysFpOWHEofDOgr3wB
 SDPXfHQhG7iO8Kr9gHxrjIh2od9h3ZyALwMSTy0hgqBsfB8/U5uulxHVkDCHtCTRTSmzyYjbTSN
 AYYbYWIzj61ATVAGk4t91Z7uJvxtNGgPUGu60o29ACHZjjyk5pv2YIgYLxB/yiEdPoeINjuBSZl
 u/JytGq+nG5VyUxSrBAZ0T4yIPx029HpRZ9lketZs=
X-Google-Smtp-Source: AGHT+IE3zgIfsWsuz+tSyxdQoU4spi8JNsanIEE5x0wtM1bOX99AHIZ2MHkQJKQb/TO56BKeWZd57g==
X-Received: by 2002:a17:902:ea10:b0:295:7f1d:b02d with SMTP id
 d9443c01a7336-2957f1db220mr87142825ad.22.1762188578886; 
 Mon, 03 Nov 2025 08:49:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v3 13/44] net/nfp: use rte_bsd_queue.h
Date: Mon,  3 Nov 2025 08:47:18 -0800
Message-ID: <20251103164915.101713-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Can use common macro.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_mtr.c | 7 -------
 drivers/net/nfp/nfp_mtr.h | 1 +
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/nfp/nfp_mtr.c b/drivers/net/nfp/nfp_mtr.c
index 4833ebd881..904d2126e7 100644
--- a/drivers/net/nfp/nfp_mtr.c
+++ b/drivers/net/nfp/nfp_mtr.c
@@ -12,13 +12,6 @@
 #include "flower/nfp_flower_representor.h"
 #include "nfp_logs.h"
 
-#ifndef LIST_FOREACH_SAFE
-#define	LIST_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = LIST_FIRST((head));				\
-	    (var) && ((tvar) = LIST_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
-
 #define NFP_MAX_POLICY_CNT             NFP_MAX_MTR_CNT
 #define NFP_MAX_PROFILE_CNT            NFP_MAX_MTR_CNT
 
diff --git a/drivers/net/nfp/nfp_mtr.h b/drivers/net/nfp/nfp_mtr.h
index 7ab0324721..c8ce03385c 100644
--- a/drivers/net/nfp/nfp_mtr.h
+++ b/drivers/net/nfp/nfp_mtr.h
@@ -7,6 +7,7 @@
 #define __NFP_MTR_H__
 
 #include <rte_mtr.h>
+#include <rte_bsd_queue.h>
 
 #include "flower/nfp_flower_cmsg.h"
 
-- 
2.51.0

