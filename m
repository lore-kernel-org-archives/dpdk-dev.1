Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD27C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:27:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B476740E41;
	Thu, 20 Aug 2026 07:26:03 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9AD8240E3B
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:56 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cedda2ce6fso10259285ad.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203556;
 x=1787808356; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5GFMU6eLUo9VkwyxM8F6SqCmPOOC4RYks46v9/yVcVA=;
 b=zQqc70T3Y1lsosAR6DaDmnuXPSuy6cz26wHudojRnunxRw8Ack0sHIiPKw2Xbociyl
 oNAkBnkLSM83zyKbbaz+wRUTArkwkP/Thz1nebQuBjPKH0iTsmPHlaudW+PTd1n+d5ad
 DdaxL+aZIc7g9nGo7yiLM5nPZXKOTpR6dp1gaEOyTg9WMRmJqJV85AphxJjMDTRt4VaM
 PGMUmfvoQ75sfFBUgRb0XK0pxDX9phFemD8i2mvpY9LjgxDER/sGvdGaKcwvpBs+XHP3
 2BIgrrLmlflhWaH512yJHrlkeMsTbjJ+iJicDCFwFOuPhmV9qqi3hHe0ic7zXE9tc0LO
 zkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203556; x=1787808356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5GFMU6eLUo9VkwyxM8F6SqCmPOOC4RYks46v9/yVcVA=;
 b=IMS+Luj/NE5H0fh+r6PhpqfuZH6kQGuCkrx7sjiO3zoDJr3i9kUcDFiA8m5sM7GAfw
 FBkgxQlxReSmQUQYWB7EIBZORcmvlchH9BG2g5hpqEcRoLPe9v3XzF2gThBaoQL03oi5
 FOhdOav/pmiyL4TuwbawOjx/pWGn69BgsZB4+nhCvMACHG1Vv2NdRZAZ5RfZfWm/Ujht
 rk1PrjUYdI/o3qiA6wixZdMsLTslS79bY/x1zEYQRPADSksoTxd9K3gC01xw4vsmrGiM
 VhKBgHEBTtoxsh5fQpSY0D49P0EDvC3oRN0mA4qT8BedhQFK8sIqxrht5LfIzuC6lwm9
 0IGQ==
X-Gm-Message-State: AFuF++lYcs/Qmzq0MeD/BXovSVdHsFqp6zYjRaNS4UWhiICCrDBTwQU0
 xAqbbNLcLGt8hiJaOw+gZaegs8G60E0LOiVp10rZ5amWNBUOAvqMiCQuisHVwLSp7qwrxRENAAU
 YEcul
X-Gm-Gg: AR+sD12jPC/1Dl769V15fx1CXmVY+A90XY7Zylsk/MtmvaflNorbINg9mBbu4aPXFPT
 ydD2HbtlyGfOzF7Guk/219v1+5YJmFoPJ6+TL1oOtSUb/gpUFILUJIm9q0acOAKNY/1J7l1QWUL
 3C8ooO29Bk+Y99LTl1rXsZbrh/IiXQtJoL0J5rVVreESP5f3AJ83uRlxvozlPRVC5uCAoDjS1+K
 Tg2SBi84GvVNBJIwk08xJ2fVJFS8xm4D1C824lT6eIPWrqJ3/6g6suh+BAvC+4oBm9rmr0fKweK
 q3CM/lG1nB45u72fhAf3Sgr83ZVmhaWbxy+yETF/CCjdUiFW5w7gyOSBUUz1zHDf+bPST68226t
 Rw66K19m/a8FnSbAj0nsgzWHNAx/vw3gyrWjmrNJRp4/GNAw2zMSKrV0AxaN8oFNrOVekyvH7C2
 KOQ4/pjxSFqp2elb0Z58DU9VNhSAjqe8iUdxw3dEzv7BAnTkUAOgWeg0ESlhl0jL+fDRsHvXVxx
 wx8wYeNYrcJf2xo067r5pqyBmI=
X-Received: by 2002:a17:90b:3cc5:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-39580f3bcdemr19634914a91.10.1787203555726; 
 Wed, 19 Aug 2026 22:25:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH 48/61] test-bbdev: remove unnecessary include rte_memcpy.h
Date: Wed, 19 Aug 2026 22:12:38 -0700
Message-ID: <20260820052251.1453273-49-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

rte_memcpy not used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-bbdev/test_bbdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test-bbdev/test_bbdev.c b/app/test-bbdev/test_bbdev.c
index 2422312f6b..5028e844ea 100644
--- a/app/test-bbdev/test_bbdev.c
+++ b/app/test-bbdev/test_bbdev.c
@@ -6,7 +6,6 @@
 #include <rte_hexdump.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_cycles.h>
 
 #include <rte_bus_vdev.h>
-- 
2.53.0

