Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9098606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EoUGpkSE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03BE540687;
	Wed, 21 Oct 2026 19:20:50 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 31D2740608
 for <dev@dpdk.org>; Wed, 21 Oct 2026 19:20:48 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-91c162febb9so7834686d6.3
 for <dev@dpdk.org>; Wed, 21 Oct 2026 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792603247; x=1793208047; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MG9rUkztGy2ckz571GAZR0BZto2Zums3gmshxU63qEQ=;
 b=EoUGpkSEFjOtteKdeF1NxdzhMXvTm+1Svg9v2X9Fdfbn6UZYxhkdLiXM2CvbogONyC
 FxAU2AZwU15T46qX3qVyF9jiMPcW2C4ccowGA9yA0VtEJyYvCb9Ss0AE/Q77vV6sxn8A
 N/Ow3gxJnhN1EXNmeBtRBtkFpLZc8AYeKPHUUIiO0TK4MX/M9P9McDijyr/vVzruoLTp
 ZGQxsFuGF1hTGmsRTjo/VK8iyPGhvzECy6Fxn9xEZOVDofvu9z9llU9dBTrp+5yiKPwi
 iT6/eqoW1n1rbyL6bp5sB2JkmePa8aCiAC/qC7vKXwDUlMWuEYmXB+LGsweOm85c/hxY
 kCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792603247; x=1793208047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MG9rUkztGy2ckz571GAZR0BZto2Zums3gmshxU63qEQ=;
 b=zPmlnDQwNwAPScrobvGdjd2ndvnhOtPT1lUpT/OSY8F9rwDR7ETlMjMfm73ESqQgX2
 VJRuHAE+RbM6QpNwBOcCSpIVQA9fW6b3ZWw7kzAEY5SWQxvOx8m46K2zsg4DRw1G3YFa
 jbhNGIBaJ5sZIm5vYKHNIsW0fR+KKJWDf+jefOZdhFiT61YrpODahfSnApRMdGJWtXLJ
 DKEeqJ/q0dLAzfyBTcykl/9DJ+dQ9iG9dUz+QSVFn0KU53oKvY/qNnNZpcKd8GxqAdQQ
 xxWf2lBV4JfgbWeVAT8VYLbMIWcloDyckBgVxlDAmd6vlV+talpzUKbLya3dvOWjaEfI
 lvmQ==
X-Gm-Message-State: AFq9FYIPESB+LWmh/P5U0/d8BG+ZA4D5zZPWjnLqPGzgJmUoJjKeg5CU
 3n/wqV+rIn6U+uq2PXmVi3R3xxoRf5E3uHIvaF+gRJDpNvaLwhhzkxdCum+3d/15sns=
X-Gm-Gg: AYBFou24bFP3KbP/xG7DVDonHucIHNAPSkwf6FQBBMUDFCXXsXyTSw4afuXyy68v8Yc
 F6DY6gLsCYPeMnhmmcEjsEOs6xuiX6c8T5PltZUzUFePEL079lzt79nTfXMLffZcI8s/2bP6SYP
 wO7tJCPnZSjrFzoTc0apbRKVA4qKNIEyPX3Pvz7NDPTVlFcucnzYcsHDfkRtsPe2PgOPN6HZJxt
 BL4QJjngCHZJmWbEexvSAm5pB98ZyaPfOAnNROYr0x50rZW642qU+jn0QrBA81gOhu/lNAUnVUs
 9+PVILpVLK6yRDK6tTbtriDdCfGBRoxYnDNxT0HGSltqZb+ahy4TH2rNbEyLAclKAAnOYFsHj13
 gkPgKJD+mkokqsMTJ74LN7w5hCAEw7gWD4MG5ZohTVC3SYgJ75XDKe4Xth6PhMFBY1K/qxSg296
 8VbRLUFW4220jH1CsDnQg+Kx0bIyqhBzwrfMTFm+qxxcQ/Hc4vPKbBaG1v3HP5z0BhrlXe3b58H
 4bTuS/IZzLBE9/AxBOXf77ijGwPAtYDVs8K6nSiwR+7JKUxvu1hKEdwBcv66PPod1mHP28eJuab
 hBEaAn6YacC5j4UWaXNnaSGVXtVG3cWPlhojY9V88wx5HXA=
X-Received: by 2002:a05:6214:1247:b0:917:b048:8611 with SMTP id
 6a1803df08f44-91c12eb35damr46930236d6.20.1792603247297; 
 Wed, 21 Oct 2026 10:20:47 -0700 (PDT)
Received: from pravin-HP-Z840 (ool-944c2ac1.dyn.optonline.net. [148.76.42.193])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c10b736adsm28823896d6.7.2026.10.21.10.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:20:46 -0700 (PDT)
From: Pravin Pathak <pravinpathakdev@gmail.com>
X-Google-Original-From: Pravin Pathak <pravin.pathak.dev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, tirthendu.sarkar@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, pravin.pathak.dev@gmail.com
Subject: [PATCH v1] event/dlb2: race condition during dynamic linking
Date: Wed, 21 Oct 2026 13:20:41 -0400
Message-ID: <20261021172041.433881-1-pravin.pathak.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dlb2 handles dynamic linking and linking asynchronously if queues
being linked/unlinked have traffic. It starts a thread if not already
started to handle the process. This change avoids the race condition
in thread creation where sometimes the thread starts immediately,
descheduling the calling thread and finishes the job and exits, and then
caller sets worker launched true when the thread is not running.

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 drivers/event/dlb2/pf/base/dlb2_osdep.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/event/dlb2/pf/base/dlb2_osdep.h b/drivers/event/dlb2/pf/base/dlb2_osdep.h
index 382a49090a..1505563f83 100644
--- a/drivers/event/dlb2/pf/base/dlb2_osdep.h
+++ b/drivers/event/dlb2/pf/base/dlb2_osdep.h
@@ -208,14 +208,16 @@ static inline void os_schedule_work(struct dlb2_hw *hw)
 
 	dlb2_dev = container_of(hw, struct dlb2_dev, hw);
 
+	dlb2_dev->worker_launched = true;
+
 	ret = rte_thread_create_internal_control(&complete_queue_map_unmap_thread,
 			"dlb-qunmap", dlb2_complete_queue_map_unmap, dlb2_dev);
-	if (ret)
+	if (ret) {
 		DLB2_ERR(dlb2_dev,
 			 "Could not create queue complete map/unmap thread, err=%d\n",
 			 ret);
-	else
-		dlb2_dev->worker_launched = true;
+		dlb2_dev->worker_launched = false;
+	}
 }
 
 /**
-- 
2.53.0

