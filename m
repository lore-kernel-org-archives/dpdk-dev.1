Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E979D37497
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:15:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FC8F402E7;
	Fri,  5 Dec 2025 21:15:49 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id D2EFD402B7
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:15:46 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so34026265e9.3
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965746;
 x=1765570546; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHfpngJsPBB1aice1mKsOtXuQPDGGzxV2T65XjfPegE=;
 b=bA28v2yl0t2owrnQFs+QSZ9IcHP6iZC670xedE8BIBGo50Yu3YQSXmNQMSKzhFKyRw
 pPtVa834tjfNBgRPMauy3teRMlEJ2J2qiM9m9q9GEWnvYnxdem1e4b2qxL6yLp503iG/
 SYTidy/t5vmh01bgReIIt+wK5v6HHu41PFmHaQLo4k4056VVJOGkZhdlbC4xAzTRoUGc
 OvYbJrc+QJnoWFjcd7499iuimIL/12JgeiqMGEEcfGtmFyhE2LHEMrFrIOP/f/gnml6l
 a7h2yHUBLXsA79wE+l/z9sj7NduxNpbzB/V6o4HthMzhlgx70oo9Xf7MZ4awQUyLWOqV
 HtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965746; x=1765570546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LHfpngJsPBB1aice1mKsOtXuQPDGGzxV2T65XjfPegE=;
 b=khUwUASNM6aA0GmM/d2/bJe9AaLC6Ajxo4FMM6ZKtC4CJPpUhBWcoomZbNMgccMIwV
 1Gf+I6zXhwfYGCQ5MJbuOxVmqX1zFx4+JuaHLrx+ygy/02qEupdNtvHxNiyOIqRKZqIT
 U51IShb9mSgUj8OP+Cv+mdf5zON3y/VOchENVAmrUvwUoZvl6jh+1LN1F5DVcyV/aUNw
 tgg8wbRYjYMGG/hcitXdDNuAV0bmmkxmltBvc1FqDvJ2vxMZd/JNteHPThVPmcOGE+e0
 Rc+LC4HYMfeYx0jghmXGDX1lilTgq65yFCpb+DSVm7OJEJ93NW27Pw4tsqncAfas/aFQ
 8mlQ==
X-Gm-Message-State: AOJu0YxU1zFD7n133FoM4luVqZchcYEJHnX7LlRXPJ4W3wWrsjauDxdz
 bu5Z2xdLJxU+1wgK0I5i1YxbGIBCPcvLNZa1D7GacUVEyC8pPjmnFj0BxfursPNkIaYAUZLYh7L
 6JiL5
X-Gm-Gg: ASbGncsQ7CaBBXHY6PLviO1WCqcfIxXVqTCpoTFQb//U3CdrB/f9EHmMy+QCzjPNkG+
 UcOlsrwpQkUchYN5kknSoNDXPSkb2ULOD1xpVWO+lop5Ge6c0NRUcajiNoKZXpgDW8Q3X4D2wXx
 9mQ6ROCLqtBW7kkY8I9WY3X3DgT40Cmgz2i18NQ02no8X3Qim43dxo4Jdlb8xwTLK/abjWBNy7x
 vTelyscIj5ye9ggyWGmmoFttWg/Xy4jCF1/66uI1/7s3iC8zl6w1KpijbXVaS1sGWIA4FNuVDcQ
 f+sdYVm+vzKOAb3wT8LK3QtIycm/+xh+lmehKcQyuKrdq8gdJAcL4AXYvH8Ntmn7suKiZIVSJ89
 EUA2QpW4WJ97A8wkXdcjOfXXv0vT1ctC4DG1iJht9uqlzRAuMJ/iL2lDs1UJhZnkAkzfU2IhSQU
 wO2Ba371ywYgShrlfdTLzzUaDXPmlg90WSyLpsnA6myxd7utPZz2M4FhKF7pNw
X-Google-Smtp-Source: AGHT+IGea7Zjxk4Il9e+nvkE2uRaebD95ROhZkpdRTMJimWoRv7/PsL1JA5Z1LU90G/uZEMYxcjzNw==
X-Received: by 2002:a05:600c:3549:b0:477:89d5:fdac with SMTP id
 5b1f17b1804b1-47939e3e525mr5561355e9.31.1764965746289; 
 Fri, 05 Dec 2025 12:15:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:15:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 02/16] lpm: restrict name size
Date: Fri,  5 Dec 2025 12:11:31 -0800
Message-ID: <20251205201537.251131-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

Since LPM uses ring internally with a prefix, limit the
maximum allowed LPM name.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/lpm/rte_lpm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lpm/rte_lpm.h b/lib/lpm/rte_lpm.h
index edfe77b458..21a93b7e44 100644
--- a/lib/lpm/rte_lpm.h
+++ b/lib/lpm/rte_lpm.h
@@ -26,7 +26,7 @@ extern "C" {
 #endif
 
 /** Max number of characters in LPM name. */
-#define RTE_LPM_NAMESIZE                32
+#define RTE_LPM_NAMESIZE  (RTE_RING_NAMESIZE - sizeof("LPM_RCU_") + 1)
 
 /** Maximum depth value possible for IPv4 LPM. */
 #define RTE_LPM_MAX_DEPTH               32
-- 
2.51.0

