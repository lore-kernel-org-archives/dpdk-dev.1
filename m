Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581EECCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 21:55:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12D5640661;
	Fri, 24 Oct 2025 23:55:09 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 87234402E4
 for <dev@dpdk.org>; Fri, 24 Oct 2025 23:55:04 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-33067909400so1910869a91.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761342904;
 x=1761947704; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0J06KJzDzXhPV3N4fCx7IN8y3PaQHpxuTDCF2EhH3Q=;
 b=HMC4qHhkbxHN/jKLsng3053fzaoaUrpQkF59OJ0ZBRxH7Ymw+kYc8YbFHyKHXn29P+
 Ake5YKc/rASHWQyNIdjO3PiifCEHlqOSWhLe9hFNB0A5deDdP83/UW+In5w/goz1HzqS
 6S1Sun28IBrIjWs9Wca1CC6mMg1yWReTjZUEdqDLVLB730exxSupwu1KR1SSh4WPHN/R
 rvHsX1uTu1cKuFMIQids1S9sSxLB/HzemBHEiWoJtTuyGuG6OxB+mKlmLIK3vM+DZ+18
 sb66ywJLflOwV+UFP1+bfaWjGxZDvwP+aPr+5ws58APxkFUyJkUu04vbELNfA8UDFOgR
 9FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761342904; x=1761947704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0J06KJzDzXhPV3N4fCx7IN8y3PaQHpxuTDCF2EhH3Q=;
 b=HeOkdRjjbJFeQZiLPT5x2+WMM8YyE9KDeUxnPVDp1t2xJDX+BiMoUb/jeXeMWsjXUs
 tndcWKs/XIABCN3kMMZza2Ipgbmh3RbpVSbAMHDF5EFMijur4+QIz2Emd55IeHF1JeM0
 jy6BFQDxhY+1PJTjjjPOC2e7eMnGCBQzx5FA/r6zjT56ZQyl21jkU8CfSaUvI5AoO1Az
 qnBaQoyrxfQSScRWfOlL0CoE0tiqkQE+t4+zUIBTggPAc6UCaDPoF4uEadvk1u+Yf0Em
 5amFGuw0sbNg8HosTsjfbL7TqKQ7a9rH6MTc8ZvBfe+CcWblpxc9LNX8JD1YNWgncLAS
 dDBQ==
X-Gm-Message-State: AOJu0YzkWK0ABXE7Jlo2NMZZicMVJYwfCahdzM+b1kawFEzLZfYFKZ5i
 NUwdrmLzHJ1E1V/rFIPJLE5BRS05AbMax2uSAKLrgZYLUc5i2FWACjQ7u2G+zaDTBNB6JkcKAfy
 ubTmi
X-Gm-Gg: ASbGnctRh5UbwUFSARQ/N7PgB/7JPSXS/weu2P46RRYUcf+CfUrd+pHA342eFJ5gyzN
 psO9z9UKcmvBaxMY9d30Qvy+5Bz0OgjyiOIKtQ5SW5t04RXV+9M+fuowr/B4Zw0yn77sSjYmZru
 ACcxgloVk+vsnQOZgyIseh1AziRhelMa40/9xFm0RMwdqpzAubYLszyErvF8tz9DrRXvvB+kd+n
 SjdzN+KtJE+86JGWCU8XS5MrWFgufQGGZqVPgKwItM6PU7uIeNy06mPIvA2xqrSU3kN977PAQBl
 atryVnOSE82I5OJnMTQQo52y7SoFLfIYzTzLs8TCSIcYIiP/u5cxiEAs+XX99wEi1zmfTAnwTVe
 2xXUXjeRaeNfrgq3FdZwbT0Hv0fy5f/YbjLz7ZNuIaLL21bymWjyIIeVKLoKfuFPkfzp3ErsY67
 MtuuOK2jc8CjhB4GKv2ki10baClddd4hJkZFiNU4VQGtLVFlu5Ew==
X-Google-Smtp-Source: AGHT+IEWV/QMP4jJQGNBgIMzhYPuqc/kQd9EAo9JT6MKFjWD0j1edK0kXuicbJejATvdXDa7sdoBsg==
X-Received: by 2002:a17:90b:38cc:b0:313:1c7b:fc62 with SMTP id
 98e67ed59e1d1-33fafc1eb1bmr9212906a91.22.1761342903719; 
 Fri, 24 Oct 2025 14:55:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012de3sm252530b3a.2.2025.10.24.14.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 14:55:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 5/8] pdump: handle pdump requests from primary
Date: Fri, 24 Oct 2025 14:54:00 -0700
Message-ID: <20251024215456.282171-6-stephen@networkplumber.org>
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

The primary process will start to notify all secondary processes
about pdump changes. The pdump secondary process can just call
rte_pdump_init() and it take care of that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/pdump/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index 1741d7e709..626ba0ce93 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -552,6 +552,7 @@ cleanup_pdump_resources(void)
 		}
 
 	}
+	rte_pdump_uninit();
 	cleanup_rings();
 }
 
@@ -822,6 +823,9 @@ enable_pdump(void)
 	struct pdump_tuples *pt;
 	int ret = 0, ret1 = 0;
 
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "pdump init failed\n");
+
 	for (i = 0; i < num_tuples; i++) {
 		pt = &pdump_t[i];
 		if (pt->dir == RTE_PDUMP_FLAG_RXTX) {
-- 
2.51.0

