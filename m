Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA712CA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8925A402C6;
	Fri,  9 Oct 2026 01:37:17 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 041C340678
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:16 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-884062f3296so2313684b3a.0
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502635;
 x=1792107435; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+toDJcO+IBhy0znUe5s4dpV6ckQ/Z213y0w8eDUQJVk=;
 b=LQgiQpvLwrYSOkffiryiGM/hk0wW02PU2uDw715+BJnsxTSju17oJEOFDWwSDQbsFZ
 dAqXilSf+WIwgs+mT7FA2/u9rOKd23URGgn1Tfu4kL8kbe0hOa0f4n4k293rhZiwq9yy
 kuJsYnQ3dZVE0TKKqfWyTX7yoqRlGBcaiTpTkhPUOZHZbgtTdqwQdSOX6ZeDq79OWMOd
 i3+j5CTX4OQtLcGmQ5sDVSPh7zZIMdB3fKisYuSL3Kzn3mTJHBfDLmx5UM6IsD2Rucq9
 gNJayr47yaSfXQhJJd8LrGA78tn2VFNmzvEmkJt+jkTFb050AZQmR2elB+ev5aSCbYIS
 DGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502635; x=1792107435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+toDJcO+IBhy0znUe5s4dpV6ckQ/Z213y0w8eDUQJVk=;
 b=DubGWtbp3/ttaw/Yyim2a+Bd759wjkaznEktyKQme4bXst3odCZhuA9kFeGvW3TPqR
 FX08v6gsYHmfVrs+1hNF7X3j0mYOe7uFUYgf+zJbtSNYKUIoUal+WrGRZr397uoRbJhf
 uFrc4Hwb+cs+C+Rq2xVTDD4e1ALNv/GJY0YBLsmhBXRctrN8q5YPfxYldc+e0iIK0Ipa
 /dOKdwgEre5pl4QQI9e15OcVNDp2YMZQVKx51MpQf7GPLDTZHjGj69SOwLlgwnuHYTLR
 p+TiwnoElvx0vAQO8/Bj0CZuQyv/p7mQZcWqSIaaU4y0hJmjSjgnx63m4X8V3nXhqJRo
 Vb0Q==
X-Gm-Message-State: AFq9FYL9P32bQGxlNA97W6Cw+MbV54xRaaHRW1x6uZYoZ4cDJWmJzRxY
 xNfUQBFo247fwTDPZcJQ5mF/p4hiDlu/vrx2Q1j3NM9UKbf3nh2tmER2OXLiiroJK17N/pHmqgb
 NmodaHNk=
X-Gm-Gg: AYBFou0Rz8nDgkgQYBLxd4OvuORhSAuKXk84jhKmIoYnvxqTe696Da3k7PS+jUdK9zI
 NcrJodOYQdlY3u3s8BSvX/iEHaedzk+TemKMwJw4RXgMDAp0G7+qaBTbiBRg/vqNmNwT07TVjui
 NbkoDbufaKW+TQrkeO6OL/UpTReA3Duebx9WjaP0EMr8YQbxkP7gkUI+jryuLLn0DsSRzeOi+1V
 ANNSLhYSihOr9kLyOBOx88YQ1e8tt3OrphDmHHRfwwdb+WT6pi70I6b45+vj8WB10zkdeRpqgLj
 jMlAhHeKevVakzY/0wUCD5YwT241XgpeOEsi/v3XiCMEe3vkwVgt0nro9z5nPJfOD/khDT5/pOC
 Y4Jeeg8MdBjj2IXPP+Fosu9Z8ZarDUwhNOTJXwBeh2Uma0vf6TSNpFNsQK7nDsTFm4mFm0TwUiG
 84PGoXzXNCgsR1Q4SL+StBBWUj4HPb7+3qZByXT0MREJU0ruliY1r3sS1Q8/iPogdkznWXqn/d6
 OLroQfMsRGN7f0GlcA723ZPyy6umGiAInWgPw==
X-Received: by 2002:a05:6a00:181f:b0:892:597f:37d8 with SMTP id
 d2e1a72fcca58-897c7010883mr65892b3a.15.1791502635233; 
 Thu, 08 Oct 2026 16:37:15 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 14/29] crypto/caam_jr: replace rte_smp_rmb
Date: Thu,  8 Oct 2026 16:35:07 -0700
Message-ID: <20261008233649.1260843-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

Replace rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/crypto/caam_jr/caam_jr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
index 104ce52d11..a7d314bfab 100644
--- a/drivers/crypto/caam_jr/caam_jr.c
+++ b/drivers/crypto/caam_jr/caam_jr.c
@@ -572,7 +572,7 @@ hw_poll_job_ring(struct sec_job_ring_t *job_ring,
 		job_ring, job_ring->pidx, job_ring->cidx,
 		limit, number_of_jobs_available, jobs_no_to_notify);
 
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	while (jobs_no_to_notify > notified_descs_no) {
 		static uint64_t false_alarm;
-- 
2.53.0

