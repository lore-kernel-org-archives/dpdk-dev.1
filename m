Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9D7CA5FFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:31:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9099140EDC;
	Tue,  6 Oct 2026 04:31:18 +0200 (CEST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by mails.dpdk.org (Postfix) with ESMTP id AC6A140EDC
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:17 +0200 (CEST)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so3023096a91.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253877; x=1791858677; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vIpHZ4sygBdMG9Pljim/M5Nuc8eqNHHRJkn1BKN70Hs=;
 b=RdhV9BLGaVfGq/YNDP8ZcrpKgNG91mcSyjp/+pvueUuwwaPWiKphC2x2aXVU4Eh6Lq
 pL8VnJWObMzJGtqA/hQ8f8tn8bZSCaGHcyKioS5YWp3sM6F3e8TazPEcn+PpBzNZUj6Q
 Xe7pEP97EUkzQMsyHrFTwJYyiuDmx1ZLXSCEynNwUmbAXYTs8MRIPVO7xjfB2aMFJWas
 +DorXbHDiQXZkKG8WXVpFD2VJ8kb6d5yBwx5TooYNmjmTzdgCuVHv69ohTAAffJRBchB
 1BzldcVTcqbK1wVAxeuPr568mGLs+TXcLt3toCqZCiSE8Fxv3GWbf9otnC3bXE6qNNSJ
 KoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253877; x=1791858677;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vIpHZ4sygBdMG9Pljim/M5Nuc8eqNHHRJkn1BKN70Hs=;
 b=05Wy2JNaT3AApw1i4xiT21TfJQvDlVT+/RzJoWC2mSvtDfHB4bkyUnv1fXLIqSE8yt
 mNUFNhqwoea+v2f8IqQMOLGR/6qebpqjV85v2YJFq1D4d/6sRC73u6cmHcNneDqrRz2h
 yEUyZ8zUB2lBNwEkZ6S8egQx9ZedOa2HIptP+k+LQILs1qvEc2XRlFymN1h4CYpRo+P4
 dXI1ycEuqDd4BVxiq0LpGL3/bjJtGRwFTjCM/OLUAdZtSDHiZq9qmH0Py7FNP7E/inTo
 5FzBKCwigbfhqrzTdh1yAysL8c/o2dICak9kpEOeK32IItGHMlPpLxQSMMSUPWtGBeLw
 uugA==
X-Gm-Message-State: AFq9FYKVbjW9fTk2DcPriPxQaFnhboXPaNYpudATdiWMtUrKifK2udn8
 Kri0A3L/lP+OKzvaCRdg/51FQ7Xjarz05fjCagBT6IwHodHBaepNT+OB/RCd5de5rwg4yHoLISf
 SDR2XXIhvGXkE+A==
X-Received: from pgp28-n1.prod.google.com
 ([2002:a05:6a02:62dc:10b0:cca:5338:9520])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c0f:b0:3a6:dc51:cce9 with SMTP id
 98e67ed59e1d1-3a6dc51ce8emr7264658a91.57.1791253876418; 
 Mon, 05 Oct 2026 19:31:16 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:47 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-12-joshwash@google.com>
Subject: [PATCH v4 11/15] net/ena: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v4:
  - Add rte_common.h include.
Changes in v3:
  - Leave call sites in base/ alone and map DIV_ROUND_UP to
    RTE_DIV_ROUND_UP in ena_plat_dpdk.h.
  - Remove extraneous blank line in ena_plat_dpdk.h.
---
 drivers/net/ena/base/ena_plat_dpdk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ena/base/ena_plat_dpdk.h b/drivers/net/ena/base/ena_plat_dpdk.h
index 83b354d9da..4a6d53d0a2 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -17,6 +17,7 @@
 #include <ethdev_driver.h>
 #include <rte_atomic.h>
 #include <rte_branch_prediction.h>
+#include <rte_common.h>
 #include <rte_cycles.h>
 #include <rte_io.h>
 #include <rte_log.h>
@@ -308,7 +309,7 @@ ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
 			rte_write64_relaxed(*from, to);			       \
 	} while(0)
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+#define DIV_ROUND_UP(n, d) RTE_DIV_ROUND_UP(n, d)
 
 #define ENA_FFS(x) ffs(x)
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

