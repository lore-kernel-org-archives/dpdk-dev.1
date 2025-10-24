Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83272CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 21:55:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0E5740609;
	Fri, 24 Oct 2025 23:55:04 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id F1C8B40289
 for <dev@dpdk.org>; Fri, 24 Oct 2025 23:55:01 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-33ba37b3ff7so2629932a91.1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761342901;
 x=1761947701; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCYjS8lCU4ey/Xq/QimMFCgJnsxEn9LlKb03adqG16o=;
 b=r6W19DdkMqszTzWEKeDWJViavlWqpmdKh2YPJfMQ8P4de2781zx0SDRI6l78CI41MK
 z5J0V7/JFIjMregQeHwRBBKmBRcCzTetxjyr1h6Htz28/vxVLQZz4GYEyUV2pM9/x22T
 j7FqAYnu+znoGFkgCyjvX39aibj6q7p7AL4fljBrPIN7eQPWz/o5npUkjnqHcofvg76e
 4ZV5C7o1tC5/EjlqZ7Plh/ziiH4qW1LRcNH/0otzhfmOVGvfqyx43RFdhe+69T6r+ZgP
 igs0W2GBybXchEfnNo+UTXDNisYry0Opf5NpioMZ7uxqEQ+8HJfO7s8TjT+qb5ow0qa6
 wV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761342901; x=1761947701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DCYjS8lCU4ey/Xq/QimMFCgJnsxEn9LlKb03adqG16o=;
 b=SGLn5tTgEIQON9D+L1AotLpc+FKQU+TAnpB24j76dAN0jFyBXejdFQ54pRkcIZvGY5
 S52nLtTer6F2n9f1ghvlQc4PoboUqUikX2p3vIN37Yubz9z86t+HB+LAVATk/LsebO8t
 YK8TUbE+s+HA/ttkt9g1PeHdGSnBH2uOrw5T9P+Qk7WRJeCGt5ePZY5F4lp6w2O2hPB4
 5WLoO+dU48uklvCZL2CJngZlc2nIv6E4C6EDF/bdm2jaguYVZ1BHtJE1sYX6UQRYdj8h
 iBQT8hGwa8ewlDFeYzHqL2Q1r2GXuC1J69GyzAdHlxfVBNWYuxlCVMHRDU7FVadSu7v3
 9BWg==
X-Gm-Message-State: AOJu0YxbO/O1UfjjBHwVuGR0cnhbSYgAgQCOyndvsUHMRe4HcWNE61ln
 s49iU475tPbPIEcnuZdjFX+J8n3uv+u5NMevVOtKRhDMAV+1jdrDWl6/LUZqkOmPeaEKom61ydg
 Rym7z
X-Gm-Gg: ASbGnctSVP+QbHHo3u3I+VOGWJwlP52Pm3XPPGdARCbZMXAOG97ctI/VjxtYGf09vM7
 TRPx3Ogp0HJIXJoas8cEALyi/VGdqbeEOM1XHGO0BtpAxRP9IN1qnNKwuhZDrpr1Ru2IAOuuRzQ
 swPkKkm1yYD128FGQUrX6o7JD7swHLkCJGkz1QhV6VOfAQQcc1oxvDW6gHKQ7bP9ZAViHTuXSP9
 vIYHTUD8pKQjS1UQnNu7VTKem5Nia2+68Wb2ajLwVf0DQuBB6M9XPi+/3Yq82mek6QL4hrylN/b
 td7YmjdoafGUxOxCelhvrwoUf3DCL5xZ8mEuEtsOtJB7lPDao92pDbzXlQNcs7CljOVlU4RAubR
 5oHJHMnirid9L1GTcBcyJRnViNG7Df7M2RtfhfJcdg0sCLqcbdr9dDxuRkarjVk+sC+fkHPURcZ
 hLy1MHC52yIJs+QTm+kEkGM41Nb7wQWtsNk5Pr4cg=
X-Google-Smtp-Source: AGHT+IGHfA/0Yje3jKWO11l/ZQ+Fe2NdGFble6EaWTz+oqma9JS+4hpyecI4sbD+CWvcD+RcF7ktSA==
X-Received: by 2002:a17:90b:4b11:b0:32e:8ff9:d124 with SMTP id
 98e67ed59e1d1-33fd3bdcdc7mr4916064a91.15.1761342901100; 
 Fri, 24 Oct 2025 14:55:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012de3sm252530b3a.2.2025.10.24.14.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 14:55:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Suanming Mou <suanmingm@nvidia.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 2/8] pdump: handle primary process exit
Date: Fri, 24 Oct 2025 14:53:57 -0700
Message-ID: <20251024215456.282171-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024215456.282171-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251024215456.282171-1-stephen@networkplumber.org>
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

If primary process exits, then it is not possible (or needed)
to cleanup resources. Instead just exit after closing the
capture file.

Bugzilla ID: 1760
Fixes: a99a311ba101 ("app/pdump: exit with primary process")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/pdump/main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index fa85859703..1741d7e709 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -1028,13 +1028,15 @@ main(int argc, char **argv)
 	dump_packets();
 
 	disable_primary_monitor();
-	cleanup_pdump_resources();
+
 	/* dump debug stats */
 	print_pdump_stats();
 
-	ret = rte_eal_cleanup();
-	if (ret)
-		printf("Error from rte_eal_cleanup(), %d\n", ret);
+	/* If primary has exited, do not try and communicate with it */
+	if (!rte_eal_primary_proc_alive(NULL))
+		return 0;
 
-	return 0;
+	cleanup_pdump_resources();
+
+	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
 }
-- 
2.51.0

