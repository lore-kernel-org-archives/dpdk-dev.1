Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBE2FCD0A4
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 03:39:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A21A9402A0;
	Wed, 18 Mar 2026 04:39:01 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 4FCC74026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 04:39:00 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-356337f058aso4156162a91.2
 for <dev@dpdk.org>; Tue, 17 Mar 2026 20:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773805139;
 x=1774409939; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4JgkomD43L5+P+8MvhI82C5d3sndBMNhJk5IkLcy/9I=;
 b=qVErquygbnLhLETHJ3mijdB8LBxlt/FfHuNm/xNaRJPYDFoXuhIesI4v4LJUZLwFhW
 iQXgYwbgov7zvFstls5Aw/KTzmYNqcYpH2Izn0B6oCYg/UpqLigspS1zlHMfTfUc/r9l
 x4NCgT0QX9bxCmWymEdvvw9Uqtl5a/BDXxGhBg98V4icTaRmRIC5hf1zdqR744/29i1u
 eWtm8dSHwH24QFIN2vJpKnnl4+qciQTBE4/DkWCj/vHg8GOZBrgro9bwKzFd/hpM6xyg
 uywx9wiL5oBxD4l8jneiXJB3CWHI91nS1Yt0Y6vBauzWRoN3SGOKbXKOMtxmE3yt8l89
 gQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773805139; x=1774409939;
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JgkomD43L5+P+8MvhI82C5d3sndBMNhJk5IkLcy/9I=;
 b=Jk4eIf4YZToKdngURwhkTunWixbH6dRcYu6yuW+zuJcUbShCUqxBqtRtU5LqlWqHX2
 UuoZVZd13D+KL/9LCr/abIGqm+Rz+HL5lLCw8LQr8XlIDZFBa6INReQ5mXVGAId/nYb9
 9SsQB7Oi4X/ZpKDd3/M70t/A6Hx8vXRN2a0uWw7rlDwPHlYigkrlpGq+F3hecnI4e3ba
 GXdPTe0XQqC2xwCUWJshF3jS9crPhxkVImSfpPJ2Ly5Yr1MOE4xe2Z+DhdavQ5m5b7KQ
 fCDKzuPOfbJw2Sr4qnfIbpv+xEQR7WCDvW593WovyZCExb2+t7L0qXaW8K8sKr5AF6Yt
 L/mw==
X-Gm-Message-State: AOJu0YzW9iDW9t8qBeBZ16cl2iD7vpqpEHIICx4Yvj1N9LtLu4Sv6afA
 nfQGrY2o95IlWD4I4QlIQ4DGH9cRdmy5Ol/6PBqvlhwRr4L3T+S46P5/lP7YrbZit7jmyybRV8H
 7+Qwe
X-Gm-Gg: ATEYQzx3c5fxbyrReHsX1Rc2saq4aXvSYxPn+TjDu7MQ+Oj+0TDQ+kF+ILyyS7+NAku
 Djc4cwJNzUgfQnOph3TkYkO/ZjExJ+8/QordzdEPMNnEUGUjrSvN3LenQaqzo0WBGhDrxmtALFX
 U8n2wX/5LKPNHFS0fnO/zSYffQf5w38QcfQTxi4BSUXsDKy629PCaoM7t15qkmkONyCnNMgBLQT
 k4x98Eet2Q4kHUpzttAX89fI80taBdKN6k43NbknyDdD99YxwQo1BZLJhoP875yy9cCMCuLu2Ip
 ZL2QHq3lb0O4lro5ie/4By0cPj17bf+iKRBwft/qMS1NpMjNp/jKBtzfevIlqREi67QS8zIXI00
 WTn2+AgMbSGS5m/CCwRnUifWzX+K8H6cUA7ExLp7f1S0GITK7brjXQHm/36SmLAMEfm7kWEaPO9
 uVs6Ed6IAgQleJKhXJj8qqLToVeGc8juhIBfSnsEBHZ7MWAjC1a6Ym14Q320wJUG5sEbuVsqO7E
 PaLphUBeBpTRkFXemrcyg==
X-Received: by 2002:a17:903:2445:b0:2b0:51f6:d468 with SMTP id
 d9443c01a7336-2b06e35f408mr19053245ad.17.1773805139185; 
 Tue, 17 Mar 2026 20:38:59 -0700 (PDT)
Received: from stephen-xps.local
 (h216-87-238-89.thvror.broadband.dynamic.tds.net. [216.87.238.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e419b77sm10478255ad.17.2026.03.17.20.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 20:38:58 -0700 (PDT)
Date: Tue, 17 Mar 2026 20:38:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>, Luca Boccassi <bluca@debian.org>
Subject: [PATCH] test/tap: skip test if tap vdev not available
Message-ID: <20260317203856.3a4b208e@stephen-xps.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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


If tap can not be created, mark test as SKIPPED not FAILED.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_pmd_tap.c b/app/test/test_pmd_tap.c
index 482c70b3f6..dabd7d3506 100644
--- a/app/test/test_pmd_tap.c
+++ b/app/test/test_pmd_tap.c
@@ -719,7 +719,7 @@ test_tap_setup(void)
 		       rte_strerror(-ret));
 		rte_mempool_free(mp);
 		mp = NULL;
-		return -1;
+		return TEST_SKIPPED;
 	}
 
 	/* Create second TAP device */
-- 
2.53.0

