Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1528C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:22:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 900EA42DA1;
	Thu, 13 Aug 2026 19:22:48 +0200 (CEST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by mails.dpdk.org (Postfix) with ESMTP id 8093042D89
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:22:46 +0200 (CEST)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso59455a91.2
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641765; x=1787246565; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IAz56QaU9c7yKiYg7f9sq2OL/0zZixn228xBptzWjog=;
 b=sHxHUMMw8i7UFFXarpQQPcPNvyVjpR5ao/5zxTWHNQQSWIc5rGmkSWOAeK9+toVCkA
 BNyR8b76QRiFQQxiASvPJ4VdqtUXUrpQwBa6uM2UUNT5IYl2JMU/P2sTgzsTJB3mJBzH
 RllXYyqbO+dRIl+aQsdbzRKN7SvR9MwdqQ4lejDHh35pW+2so/WPtuCS7WWyU1pLfoRh
 gGIHH5t7VvVWPzA0A3I5wAXZA4Bu5Dq3NNcTmccvuyNEbgUkwq+FewOt4l6yRxeBIWva
 euax4HHCRYAEU+I/K6b3OS6oLx8yJHgp9s7PH+jmauT3nruoSNzP592gcNnYkUA3vi0Z
 GA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641765; x=1787246565;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IAz56QaU9c7yKiYg7f9sq2OL/0zZixn228xBptzWjog=;
 b=k7sL/VYXadXET4a4SrsJlyMACT5/ge5atkeoW+rgujzLgWZR+1mywkRMdkYlSdqgyF
 X/FJUgdiBq7GFCFCoRI0Ooi/pumIVcHFgZIM4CGKJp/LA+tVdLBHMG7cmlBe7Acj8xRw
 peqhRxZcANETK8HGWOnavi9nqmtGtvwtt6HLz++FOJPS/NzZflDNIs/+4g7x+EpF8yeF
 sj9uqKIC1KoTCY+1b1NHPq9JeIqzLGWPTRjWjXv8SlqsS33CvARq7Y0Zlsp60Bw/ePql
 KrkdXcemi/P5Zn2R8Iug5t6UvrFrQtfgJ8GIiSeYm1aAIQY8jhpiTwyqhKUwwM/nY3YF
 RV6A==
X-Gm-Message-State: AOJu0YzaBRnQfLexogYmAm3I3ItCzcg2n0NcDQrLefNNaAQox4jTV67d
 igaF1TaufKR2lSvKIodaK5OFFxeQdE7+Cn4pyqqLGfMDL3UeW+v8DQb9uzrRKoJVp6OKluv50Qc
 PEQGJ74z5gIH2AYxu1IoU9QNCzyIocPhvZVC5bUX9z7Czuf8c/C1XLFYS3H7FIrCy+fK51Q/aaT
 2a8S9EYub2nIIU8+AhdyYNVC2NcxOe2e8NjQ==
X-Received: from pjse9.prod.google.com ([2002:a17:90a:77c9:b0:384:934b:9128])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f07:b0:38f:18f9:785 with SMTP id
 98e67ed59e1d1-3931e06845fmr8450695a91.8.1786641765297; 
 Thu, 13 Aug 2026 10:22:45 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:26 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-2-joshwash@google.com>
Subject: [PATCH v2 01/14] eal: introduce division round up macro
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

A number of drivers define the DIV_ROUND_UP macro -- add it to
rte_common.h so that other code looking to use that functionality
doesn't have to re-define it.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v2:
  - Split out patches replacing usages
---
 lib/eal/include/rte_common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 79d2a0ab93..168b0fe592 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -717,6 +717,11 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 		(ceil - (v)) > ((v) - floor) ? floor : ceil;	\
 	})
 
+/**
+ * Macro to divide dividend n by divisor d, rounding up if d does not divide n.
+ */
+#define RTE_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
 /**
  * Checks if a pointer is aligned to a given power-of-two value
  *
-- 
2.55.0.691.gc56d675ccc-goog

