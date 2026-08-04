Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989A6C55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A59D40663;
	Tue,  4 Aug 2026 17:46:00 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 8EB5240285
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:45:58 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so4974064a91.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858357;
 x=1786463157; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SgL7c7IObXoiG3HwTS93AdQuWUp5B0BuI+WbIoHoCNI=;
 b=CBY+vEnSCecQpgTrSyjAxgDQPtr72/TIHjl3PNTIeIh6TGHAAV254B9MJYoeaT8OFU
 RYStMWLPW2qYVyFW4991aSd9W4Fx0TAGNpouZO2vpU4F7KG9m36LWa6yCqj2y6Rtyi82
 aOktX8ao/YqOcl6O6249eZj9IUL8CkIw1YVvUvFejEV5NY6d0v7CMiWckJjAQhPhL/NO
 P6vGOGBb+I/0jTuKsABDyODxZj3TVbE27JxPF9pWp+bK/Io14nq6yK3hmbbLd/WjyytN
 TIEa1p3HBc4iQqX744kkxIG88vfGnsfqq1Kv2cyBNEv2wTr1NvTJ2VWBa1XkjFZiSYBL
 YEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858357; x=1786463157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SgL7c7IObXoiG3HwTS93AdQuWUp5B0BuI+WbIoHoCNI=;
 b=gI+A5qkfOFdjXuVFTxR5zGKr3MJpgnE6km7phHdtmkWAICbSwyvq0DvwC8zaKLpPso
 c7HNrXVCkgSfMJj7OXpVf8pdK6ktkhGGrCjDjo9cffOKtRTpCn7RZEMsLDgCDzXRVg8+
 c9Gba9EzyZpE4N+nDzBXTrVPg74+6Yf/zzHGLCvB1WOV2E5ymChCV5FOn2MTTxkN393H
 0ItGt6REHA2s2m51vBgZBQ/4cneXeUYyZosPcHSbOkk9jIibHk9ySuzPNv+jMf55G2DP
 pA7JJp/kGzq/LVrsWkuVpFpC2ck0oJwEnB5T8BpaLUTOLcDtlDqNHm8o3HEIUr/uHz/j
 Ncog==
X-Gm-Message-State: AOJu0Yy1S+Q4XRIJF4tlXhJQJPfBH0PW9P+fM1tAfpMRptfb8n2w4WIR
 LLCyWclkBFfLcU7bvfUrNfm3zkWymkw/gejgLg8AFePortwuBtGza4bmJFQplVcis7ywFowQXlJ
 AoA6K
X-Gm-Gg: AR+sD11/nkL1AlYThB/sy83h9y64nWzuVdwJCVli4qLuTPK2rOxPzLl3AnYhciIKmSm
 8FnVb8cJ+5SRZSvWqe6ZenYw7qbYMUVDx0IX8GZglLGmU3u+/Zpaq5O20v4ff9eOB0jpRAFMFPM
 II13ZXk+4lOlOgSV0i3LSm+CUAYNL0w1EtCvK/HoeUE7VPFV7is0rWNLiL8fbLwTPBq9eyDH51w
 airTcGc2Vwrh8iuVFrvB+TfEdO0f1dZTtQdAsZ/IlMTWtgiXA484XCPCbsfFzHcWOVyX9glACnr
 68qa28fCr9CZJ69HPx8KK3iRYBUpZaS2WsljxQ4zPor6JWurO+L7nomELvs9hT49q4sWWlqwHK+
 nPhixoI+Eo2auJZbc2hpAZ/1IAqcwpII9uzoydGVEl2gFvJcdylsRl6fAETwgGYfPhZcdfboeEb
 mISsRgk2OoED8drMeutMyzoFGh3mEJLPbGa3ewe3s1g30ZwBXWuMmLuSjXSqHf++s9kvfzdcFL5
 PAFVF7jhV6On3fzo0s5aKIKw1bcMXGljZ3N+zM=
X-Received: by 2002:a17:90b:2f03:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-3903c53404amr183738a91.7.1785858357350; 
 Tue, 04 Aug 2026 08:45:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:45:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 01/23] drivers/net: remove unused include in dpaa
Date: Tue,  4 Aug 2026 08:44:49 -0700
Message-ID: <20260804154549.148691-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804154549.148691-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
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

rte_eth_ctrl.h is deprecated and its contents are not used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa/dpaa_ptp.c   | 1 -
 drivers/net/dpaa2/dpaa2_ptp.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ptp.c b/drivers/net/dpaa/dpaa_ptp.c
index e9b332c571..f91d3f9ce3 100644
--- a/drivers/net/dpaa/dpaa_ptp.c
+++ b/drivers/net/dpaa/dpaa_ptp.c
@@ -9,7 +9,6 @@
 
 #include <rte_ethdev.h>
 #include <rte_log.h>
-#include <rte_eth_ctrl.h>
 #include <rte_malloc.h>
 #include <rte_time.h>
 
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 751e558c73..77d5d82b44 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -12,7 +12,6 @@
 
 #include <ethdev_driver.h>
 #include <rte_log.h>
-#include <rte_eth_ctrl.h>
 #include <rte_malloc.h>
 #include <rte_time.h>
 
-- 
2.53.0

