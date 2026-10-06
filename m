Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2756CCA5FFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:31:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 474EB40A6B;
	Tue,  6 Oct 2026 04:31:02 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id 64DF5406BA
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:01 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2db8e9fe9c7so25890875ad.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253860; x=1791858660; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7F8UqmrROLjIhSjJOvk5tzNTS7Pr1vFzt+TJPu7iN2A=;
 b=u2F8Q+9Ss/JAwHmGwhtwhVt8+rYut6ZIBUeD/tgDF7Ly3AQmN4UV63CAYuKmmuboZF
 8vV6rZ9rQNC01qQp8zWdS2gLvggSushs0TVzvdcoQ9l6UVtvYPrZjDec/Nva4YSl0kT1
 mmJx7/vXO4W88ZZBvFgZGEpwUSHqmZppRz+00bGqGQWDUTfXOMcI/SLgNfLiqYnXPmKf
 T3FfwtEG52hjCiRChqpeNkPfggXN27jvT+LHMIc4DPk6EXhEKP+sScUIZyc/i5Yb5WRe
 Fz5hxOh5USCSyqdqvMn1b+0BJduAU2dab2o/0HD8dmzpMqcXGEqlAI+zp8KqlpDBCHlD
 JbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253860; x=1791858660;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7F8UqmrROLjIhSjJOvk5tzNTS7Pr1vFzt+TJPu7iN2A=;
 b=MyXenY1CZUU4eyivyC6mdCMi0fMNa2ImOuC6Tf4ELm1z3yn+jYS4CBQFmhgVaEygeK
 MfRX7To57MYlJscITS1B4PMj/2JSeSBNPhzouKxBbQzmNCzTu3kz3u8gSEOMjF3Rtk+Y
 4O1NMKpr658QyXt0vv3Zbs4RDGnOUF8iaPP6DGWq6x4WbJeIG8NLhf66DDNplD/sxm7F
 PgL1Sn1aaFaqDY37Piqil3Fkc+6McjMg3Yq4yW2mC9KTtx/7M44Kpcf/a16abGEBzNrZ
 UHWZQ/WnGiEywS7qeb/TQ+zVDI1bF/xJ3kNg+a+i+JvgDrJFdvkqsxODQjS210h2zp72
 npIQ==
X-Gm-Message-State: AFq9FYKcZbF5/zcff+ZtkKLqDPWT65UaaeVGeF4pEjK6XhpwootbiJ3j
 VwckWxWQAWTKMR1b1zn7jDrDr9VSipZ+aNajZtwF3A5zttidF8acJL0gOBk04ATyqqdt0r2c/op
 FViee3FrhqG3oiA==
X-Received: from plgl2.prod.google.com ([2002:a17:902:f682:b0:2e2:bc36:1c75])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e812:b0:2e5:41dc:9ac2 with SMTP id
 d9443c01a7336-2e5dcd8f230mr579265ad.9.1791253860304; 
 Mon, 05 Oct 2026 19:31:00 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:39 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-4-joshwash@google.com>
Subject: [PATCH v4 03/15] net/idpf: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/idpf/idpf_osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_osdep.h b/drivers/net/intel/idpf/idpf_osdep.h
index 9c758fb3c0..7d99a23cf8 100644
--- a/drivers/net/intel/idpf/idpf_osdep.h
+++ b/drivers/net/intel/idpf/idpf_osdep.h
@@ -293,13 +293,12 @@ idpf_hweight32(u32 num)
 	return bits;
 }
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us(x)
 #define idpf_usec_delay(x) rte_delay_us(x)
 #define idpf_msec_delay(x, y) rte_delay_us(1000 * (x))
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 #ifndef IDPF_DBG_TRACE
 #define IDPF_DBG_TRACE	  BIT_ULL(0)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

