Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C85C982FE
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:08:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1D8642E10;
	Wed, 23 Sep 2026 03:07:59 +0200 (CEST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by mails.dpdk.org (Postfix) with ESMTP id 4B07242EA7
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:07:55 +0200 (CEST)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso430215a91.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125674; x=1790730474; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qq8R7N4rhZk/80KYS2m68eehf9Es+jT4KkfO8X3GFUo=;
 b=CTAw4Baqq0fm5WNV1A7p8BeIHJqo/K/4RjsDYUxZSU1I7QNKBc+2DMQfbd/fx9BOCP
 Wa2JACWbHUa0Op6zYmuLTr12wC7MYcF++5YbSdLUZcXLtJK6tyYKadkyA0ps8kDCFj/6
 RdmLgofRj9jDRCJTmdFs0MdVUwDOG09Wq8Wmxly8B/b6bkIUahJuPTKUbDDqymnGLMMQ
 5/Wq6MfhEPdU9qaFupnOwM1uBUWio93jAptjR8b4Dap3wx1tkm5yS+Y6kY+m3ezwcwg/
 yj/bKI9VDNvTO6pZDv73N4BrO5aBWv7YZbxzDxKhc8gkDt7bEtTt8ctbB+pLrEnbYZfh
 1psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125674; x=1790730474;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qq8R7N4rhZk/80KYS2m68eehf9Es+jT4KkfO8X3GFUo=;
 b=zT5+H9lIV3EYvm5pxh/u+vr/MgZQR7amGDc4yL2IXk9gcxvl/V1chnE27rvdx3o8U7
 V9+gsjCMI9s8cCn9XVxiIfEIfQV5sNd1KdxFa3Lq80tGxKcpniYcvCmB4L9d/8OQbg36
 BIKCGk7mdWRNmxmUmceBkjafS8JFab8Hebxe70hE3NWWZGWH8pKYCCLEM+6tg/P9jAn1
 QwONKLctnhPyxqWTdCYX9PD/G0cqlUsqsjFWwF2CMu7bjTMTRuECWnQft9LD9lySXVb5
 U0BncNgWi1k7biY2GJ/suCvulwomyRKY49WJI7FFUcFnVpo9VLIkcCBEGZR0m7wGh1RF
 B+mQ==
X-Gm-Message-State: AFuF++k/TYP1nzwON3RiBbi8K+b7SZ1mGaOPR706YLGAX0fHyP+Jcq5B
 VQz/beqQf/qfpBlLgoi106FYdNfG2h2ZvHPFhoCR8GKFF4jtSiE3wM4yAsXedpqmQCcCmUv161Y
 y4mNnuh4HDwloMQ==
X-Received: from plhz5.prod.google.com ([2002:a17:902:d9c5:b0:2df:4c93:9df6])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5748:b0:3a0:7591:ad7a with SMTP id
 98e67ed59e1d1-3a07e4f7b56mr1069361a91.5.1790125674218; 
 Tue, 22 Sep 2026 18:07:54 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:29 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-7-joshwash@google.com>
Subject: [PATCH v3 06/16] net/rnp: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
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

Base BITS_PER_BYTE and BITS_TO_LONGS definitions on whether
BITS_TO_LONGS is defined instead.

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/rnp/base/rnp_osdep.h | 5 ++---
 drivers/net/rnp/rnp_rxtx.c       | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/rnp/base/rnp_osdep.h b/drivers/net/rnp/base/rnp_osdep.h
index 58dcb40f90..b0e7906fab 100644
--- a/drivers/net/rnp/base/rnp_osdep.h
+++ b/drivers/net/rnp/base/rnp_osdep.h
@@ -53,10 +53,9 @@ typedef uint64_t u64;
 #define cpu_to_le32(v)	rte_cpu_to_le_32((u32)(v))
 #endif
 
-#ifndef DIV_ROUND_UP
-#define DIV_ROUND_UP(n, d)      (((n) + (d) - 1) / (d))
+#ifndef BITS_TO_LONGS
 #define BITS_PER_BYTE           (8)
-#define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
+#define BITS_TO_LONGS(nr)       RTE_DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
 #define fls(n)	rte_fls_u32(n)
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 81e8c6ba44..143cd11ffe 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -1165,7 +1165,7 @@ rnp_calc_pkt_desc(struct rte_mbuf *tx_pkt)
 	uint16_t count = 0;
 
 	while (txd != NULL) {
-		count += DIV_ROUND_UP(txd->data_len, RNP_MAX_TSO_SEG_LEN);
+		count += RTE_DIV_ROUND_UP(txd->data_len, RNP_MAX_TSO_SEG_LEN);
 		txd = txd->next;
 	}
 
-- 
2.55.0.1082.g2b9226bbc0-goog

