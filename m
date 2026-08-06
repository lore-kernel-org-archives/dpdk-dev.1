Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC42C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:10:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 026CC4060F;
	Thu,  6 Aug 2026 07:10:17 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 784434021E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:15 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so22172395ad.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993014;
 x=1786597814; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SgL7c7IObXoiG3HwTS93AdQuWUp5B0BuI+WbIoHoCNI=;
 b=idxLrkO/f1/jqsJsZuavbinvGh7lVlgNuqyDkLs4FICsu4xL5jEe5ahXhPXj9M+D48
 7vcuAFTbpW3yeLuQQ4zbZVYyQrhSK4zWAVLxzaW7+OPiXjZB95E12VTOLsSvYTS/K/qO
 TZPPyLI7c41ZzGQoZ5U6S7JKTsMJP/r1HeF22oKOTHq2mhXyZWFsjfhQPtWOCJ25gUh7
 FLQ4FN54v1Up2yijujB0s2PDvai5FpMzaR27wRhO2dV/2UfEZbtinysTgwKrVp9feg3q
 rYgm9V7x5Ow6OQuqLkN87uM1qlrIx6d3sv3Nn2K08Eh04/G+B+NLIvwwaApq4GhxfXTX
 vQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993014; x=1786597814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SgL7c7IObXoiG3HwTS93AdQuWUp5B0BuI+WbIoHoCNI=;
 b=Oo3F5isqaDTqHmm1PxDr1efY5XeB+OnimmYB1pjK0ZbDmQNz7TpM3NzAqnp6zyt5SH
 DTLwxjq6pgE9bvGtTuCjNhVSVytl8m9FsnDmZoKUjSfT1TUbBWdlY86gQBaEl8Ool+BW
 UVJC2dbOW0Htd+xE4t4UKV+swm9/u5TpfY2wrzE744cWorlcstvoHl8oZSICUgBNB8PJ
 epykeWCBM6Bxkr360LyZ6pCa5TBL0XfvM4TGn+2VNk2h9ou3us1xbKyCCZly7PRndtRA
 jSRlqyCEK8ls0UTadhSx987wOe11bOWXKVexwsq18o1r1KDShsAKVq980guE4nWxmiF/
 HNDg==
X-Gm-Message-State: AOJu0YxSxoxeW+yMOzWoxPYPeGBFTpKI4bWmOnz8VfPV9GlH6QDCiqo8
 s1OTqdnK/Cdp9y/04pB6zODcPdeZY4cIpnZTeoKYriw1I0RdUxJgGzgTO4cKY7xonJ4RQ09Nw4O
 IBw3IT8U=
X-Gm-Gg: AR+sD129fRmtXtObh8a3hRWCsryHJA6ZKEBVthzziUHQ8sB7JzVa4fEcem1uEnSySE/
 11nrvD7O+dtqaW6wuktsQOpXGif6BpreQlnlO+c011b1qYTnl2MbQ8jis/jGbRJXLyW1B+pRDag
 e1bmX4mLyhMEfndl+Vv/GpBVfvimJBmV/+ol7eY9uUICP8Pchz7/EaDueTdb0oQYmJEjQ/LCExi
 Q9Cv66/5/jspl+q+xJO3FxRWTvKAjRr3scR/qC1RZ3SqbOgkkAD/Stj28FGYdgEWUTpOTGxfPTJ
 jRNnl5JVINB+Qyug/9A5z3NSSE4xvZ5EjpRKRwKzJZabBxAEQJQXoxFM6IbNW9+uRHx+PbC8KDv
 3sWZblt3JBIAu+XaQwE2hFmnpQlZkhG+9sv2MucyWYc5oPR2HFUXY4ognygy9Jf2B+jNH/UfAe/
 MrzoXzLDQ7Z7/epSVmYSOu/scNc5gAsS7RY1i6D72OF5NhGsgFQoYqBVlMTS3eRm2kIou/nmZqc
 3Wi3F8cAeqnatmsJaiuh6Zk+xw=
X-Received: by 2002:a05:6a20:4309:b0:3c8:ead5:bf7b with SMTP id
 adf61e73a8af0-3cb85ded991mr14210546637.4.1785993014382; 
 Wed, 05 Aug 2026 22:10:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 01/23] drivers/net: remove unused include in dpaa and dpaa2
Date: Wed,  5 Aug 2026 22:08:55 -0700
Message-ID: <20260806051004.166778-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

