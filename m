Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B11C28B2E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B587B40E28;
	Thu, 13 Mar 2025 00:17:33 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4511940E17
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:17:30 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-224100e9a5cso7309565ad.2
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741821449;
 x=1742426249; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqEnkletO/25ZjMIFhkBuwkI8DovamjeT9ITQh/WphI=;
 b=2+/Z3Z6WPK1fLcCWRncgoC/MlzcDc6y0kKIZqFRzYe1CMQRrae851TCTJJ1A1VDC+8
 g7XKiedJEe0fwh1GrSjfItkExc9Ju8Giq4sAn/2b/XWIK+lAHi4vLvTCcluD4ThH0ihD
 lHzaIokuXjsX7ZVIxsQmvpgy1mfUTnJbp2PuAUa7F10d6KgIsUhKPQSwskmnYs9Q7Qkt
 xEHqV56ikvinEpZ3P/KoowcmtCkshY8aMdM4i4U4nF/am4+LVvgcrrW+t/YuddJFqPqU
 huUX/lqw7yDcXvPJ+pw/AxnvMpe++Gjk+oBd7/jOGLAIYMslqWIw8RZBcnk3oC+trjS0
 6f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741821449; x=1742426249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqEnkletO/25ZjMIFhkBuwkI8DovamjeT9ITQh/WphI=;
 b=EGmlzsixDepzNUzTiRWgi5Ih5YvNrY2DNulnKxnTz/1PMMSV8veIYFoiLviprVT3n+
 U7QpwyZuGNxt+KFM0n/t2StpRF9z0mXxAqADXdbJPhToyKWP89c2VghVu0DTbwhEyQez
 5bRfowCAbJe6hbWer9zwzk4aSRQRxuf+ZNgycTZWVvuQJbwkVtFB7/wFwCc869WWw7CG
 XpCy+acZCAL0DVW3KmRIMzqxxPb+2Twf7NwLCCqaBDtVxN/+sNFl+dcWcvtqLIKylYgl
 kuQvc3OwsQNrLPzy5vJqC9KAL0VKDN/NU2R9IJHDSDAl5mkMG0lQPg0DccaEu6ZbtCX6
 GPuQ==
X-Gm-Message-State: AOJu0Yy7LwZaxcciMbaVgPfKMBWNSitN9418fN4duDS36iSUF944TTlB
 UYgPUxGHt2jfICkFX0DX9vXz+QgDRJz1iCVuXMQQPYxjqcCPgw7nPpgAl1zHi59w5qPsrm20Z6h
 p
X-Gm-Gg: ASbGncsOId4t3xSvMob0pFYdH1Y5ZIiIKcVrete87FlYken4PGvgmuCmIYcxTs7zXKu
 IWtGwL/8/5oS37O13av/yfdIYWSeW3er7FLKPdk7LXFyCzcPKt6SFeLGmpeixwxwPfPumRLwVWN
 GqYq9wxK9bdR7Nx1JWLo9I1EqnVoNgvzrUrS2jB+xhiXbLW4636IIkdf3y7w9u1Ga1phNHylKLF
 9tWZXm4+f7s25JXmlAg7EMaXtfgpKF5g6ff0TV1VrDf4/FzjhDHyCENWO2C3Df/HR3tcPj9YGau
 oRTJlvoWH33LmaaGmB4dN5HcGV16UP7M65G3dtlEQe9aeZ970XQl5DfNAJlF62XbvLu4BkRzVGQ
 u2GsWaewdgBN6EIfmqq48EA==
X-Google-Smtp-Source: AGHT+IE3f0/WIxDWCdVt8taCKJ46gmQQYdouxwCNgwQQEp39ERn7ScxoaK3ZQaBD0HkIDreNxiClOg==
X-Received: by 2002:a17:902:eccb:b0:223:37b8:c213 with SMTP id
 d9443c01a7336-22428c288eamr321944625ad.52.1741821449491; 
 Wed, 12 Mar 2025 16:17:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f38sm1028305ad.129.2025.03.12.16.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:17:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v3 4/9] net/bnxt: fix use after free
Date: Wed, 12 Mar 2025 16:15:33 -0700
Message-ID: <20250312231715.222149-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312231715.222149-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
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

The filter cleanup loop was using STAILQ_FOREACH and rte_free
and would dereference the filter after free.

Found by build with -Dbsanitize=address,undefined

Fixes: e8fe0e067b68 ("net/bnxt: fix allocation of PF info struct")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_filter.c b/drivers/net/bnxt/bnxt_filter.c
index 7b90ba651f..f083f3aa94 100644
--- a/drivers/net/bnxt/bnxt_filter.c
+++ b/drivers/net/bnxt/bnxt_filter.c
@@ -3,14 +3,12 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
-
 #include <rte_byteorder.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_flow.h>
 #include <rte_flow_driver.h>
-#include <rte_tailq.h>
+#include <rte_queue.h>
 
 #include "bnxt.h"
 #include "bnxt_filter.h"
@@ -151,7 +149,9 @@ void bnxt_free_filter_mem(struct bnxt *bp)
 	bp->filter_info = NULL;
 
 	for (i = 0; i < bp->pf->max_vfs; i++) {
-		STAILQ_FOREACH(filter, &bp->pf->vf_info[i].filter, next) {
+		struct bnxt_filter_info *tmp;
+
+		STAILQ_FOREACH_SAFE(filter, &bp->pf->vf_info[i].filter, next, tmp) {
 			rte_free(filter);
 			STAILQ_REMOVE(&bp->pf->vf_info[i].filter, filter,
 				      bnxt_filter_info, next);
-- 
2.47.2

