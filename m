Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0834C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC3EB42E4B;
	Thu, 13 Aug 2026 19:23:01 +0200 (CEST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mails.dpdk.org (Postfix) with ESMTP id 12C7A42DB4
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:23:00 +0200 (CEST)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbe77d6864dso51265a12.2
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641779; x=1787246579; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+8MrpwUdfsCQKwEGUjspuUU69Bboa5FK4pBktgdcd8c=;
 b=OOvwRCDCEpqc6jSZysHEDghoJrL7WpgjH1iTjz+8HSCsfApFZucN8atUCDtPQ6BOAG
 QsQwfRcdcq4ygwHYCuvaI2yvYLdAuWCO1fYpXztmQSDdPJeWaAXghK/VQkPFLThSVfpG
 uGWTm/u7BTWVvA+q2ayqLB20fbGpEk/j4NfOj1uvxArCyGT9QMHzpeXnL/q2S93axx88
 mvvrf5jHF0P/MhD1+fBv0y7liuy6r+GNQk8dguQpkrXcwVwreFGkJVEBzYtvAY8jG47v
 y0YS35rmnimSPKnfRXXkDbDxODE+y2hWzEu3Kr1S+kMiI+0/21W6AUwrhiWw6LwdlWHj
 tg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641779; x=1787246579;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+8MrpwUdfsCQKwEGUjspuUU69Bboa5FK4pBktgdcd8c=;
 b=RmkVB3KW+MgfoWqm7zG+Zr6Qmkhl8hdQhj8lFt/zRp4tNyC58hEHgcy8sSY6yTD40b
 zr2scg0lX++DpzRVXsdJ7dP2lL6vWSAaTllMwHO34vGJGP4Y4+qz4YjdeAsmRtVARVqd
 nOJdPPzC/eC0VSFs+c43k3W+ZOEaZ6nRhCyys2ogrytqG5z8KateADBtxKXoGchAPHo1
 IHa1qeZETlzTUDk2Wg8ZEo1yXuiJHtPCsqndQOauSISAI7qzwzoiPYF1/mv+QZViUgAB
 wi1PQysnZa3z28CMhfhZjF5Mcdt7Mm31gvLsMQr1Smt88fGJXi3/zHewGYBWuRe9gc+u
 Ft3g==
X-Gm-Message-State: AOJu0YwLTKn7V/Bd6vL8+cByBM/+UU8TOWjN6rZTZgXvgWmzh7Je9a2H
 zVtnYlTS6koOLcqMCetyAwlQg4L018CIf6LrE3lSNHzmh5W05upT2LnR8p7RHrCApL2A/DshvZN
 Qyh8bo0A9Xx3dfA==
X-Received: from pgcz17.prod.google.com ([2002:a63:7e11:0:b0:c8b:2f5f:81a4])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:389:b0:3c3:935a:af2c with SMTP id
 adf61e73a8af0-3cc54f4a0f8mr10169028637.3.1786641778961; 
 Thu, 13 Aug 2026 10:22:58 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:31 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-7-joshwash@google.com>
Subject: [PATCH v2 06/14] net/rnp: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Wenbo Cao <caowenbo@mucse.com>
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

Base BITS_PER_BYTE and BITS_TO_LONGS definitions on whether
BITS_TO_LONGS is defined instead.

Signed-off-by: Joshua Washington <joshwash@google.com>
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
2.55.0.691.gc56d675ccc-goog

