Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42002CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 17:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96536406B7;
	Fri, 29 May 2026 19:14:32 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id AE7864067D
 for <dev@dpdk.org>; Fri, 29 May 2026 19:14:28 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-304d8362a58so1378323eec.1
 for <dev@dpdk.org>; Fri, 29 May 2026 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780074868;
 x=1780679668; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0JUrKDVy9AweR6vFrHzR7uEPz74qGBB2DUbvLiNFhc=;
 b=t2dNOEAsvv82fcm/gGT1UgFT3Q/OKM/4casZnsSzfO2A2/7AgcolGh58b0JLC3Vidh
 luM5PTfjOAqC5iPb0q2z+bjrBNbWyCqB+ahr0v+co/2ountyeJc6Dj/kSf5rUtjFtTOd
 XDYuKOkZKfQSELDztiiJpPVWNxAr4D8kv5CO+Hwc0obekWhAkhJJjpczfgpG8fyxa6an
 1q84QONrMGFDgMRG4JdBb2g9NDmcMo/EusWDQ7beSfbawkixck3Q7Ahp6LW+S2efvfSC
 zj1i+ssIC+kBfIstlpvzCYqA0rkLzkU1L+XDlWNfRLyvBhqF1OalF1JHUrzC7+t+CQDr
 bubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780074868; x=1780679668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F0JUrKDVy9AweR6vFrHzR7uEPz74qGBB2DUbvLiNFhc=;
 b=bHzgVkD1xU2QiqQF/xTleKKKn7wte1bhoZQfOA4Vnq02bHeyvP2VnbYUd/Yn8cD1kZ
 dI0xu4en0hgFfPumHeG3M59pnYtBLDRebeOGUdOkRBS8+4dBvWgiIIiXY2DqR1+Re0Zg
 7Qq8Bw/YISh8tbdLMamJscomnza2oZOYmW+6pqsmiBeR+qJD1+huf4K76d3MBOmLGkHD
 MCO9O2m4q7gGKGtZmjQBcKNX7rvDvilBS+AY9TLnGHxV5PY5nru4I/tJZIFVrw6dr/zN
 +pFjpWNG8LTsQc1DpGt3D+jl8xy4TwCbXaG2r1UQaRNwH69GLoQE6ZLb47TsMEAwu/A/
 EvTQ==
X-Gm-Message-State: AOJu0YwRkDVV7ez4dAz3V4PeK0eLKxCgMNwh0Zwj1x9F4UdhjnNeR+24
 +P4oCIPb7vW7jcQjm67QHn/rHHzR39qsLiwkTtTxFEb2jQKru7p1+HWqOGRdYwFoU0fw3WeVl1L
 5DaEj
X-Gm-Gg: Acq92OH9U7+U2EVCFtiqpSDf9l4+/riO7wsBtfG/UvOxaD5++lLcKovmf7Deh3/NApT
 VVlMV3n6jLxc3ve60nn/hUqgJMIM1qnhvv4xuRnPzsAi3+XorxYpGb/vz1XCfnGgyBdBuyWCCy4
 Zh4gbFVSD54L2WPfrWJBeMCu+8nO2r4RPpDT6jXxMrcC+b3tGBnju6aLv7OciDdsG9iW+ll3yK3
 4O7Skbpa+PJWkgN+zUHOG5xkC/7+SwRzpJp0DFngBLCqsrnuyM07tmRLNvwid2x6M5bwjW1kxIP
 U5lffOiLDTmS1V5/GAP4s8dpuFazpTjJDwy65I6WCfMI0albDM+ItDAkBx8KHFfywDjpoGiVeTG
 x+e38ljrNhTeTScW4x5Bba6rloxcdxPfAQ0+AsNSufd8mmewthyAkLeRCF8US8caqsQ4rTg6zcJ
 jtLatNXieiD2v35B5TZcvsToQbz/d9mJtbztak8/kAElD4dshWbs/xIoRTcMesmNlC9og8OIS5
X-Received: by 2002:a05:7301:678f:b0:2e7:190:41d6 with SMTP id
 5a478bee46e88-304fb1a8c84mr150587eec.2.1780074867714; 
 Fri, 29 May 2026 10:14:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c120csm1880350eec.4.2026.05.29.10.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:14:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 7/7] app/test/test_pmd_perf: skip if no device available
Date: Fri, 29 May 2026 10:11:00 -0700
Message-ID: <20260529171417.526892-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529171417.526892-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
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

Rather than exiting with FAILURE the test should exit
with SKIPPED status if it can't find a device to attach to.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_pmd_perf.c b/app/test/test_pmd_perf.c
index 995b0a6f20..8eff0a1223 100644
--- a/app/test/test_pmd_perf.c
+++ b/app/test/test_pmd_perf.c
@@ -691,7 +691,7 @@ test_pmd_perf(void)
 	if (nb_ports < NB_ETHPORTS_USED) {
 		printf("At least %u port(s) used for perf. test\n",
 		       NB_ETHPORTS_USED);
-		return -1;
+		return TEST_SKIPPED;
 	}
 
 	nb_lcores = rte_lcore_count();
-- 
2.53.0

