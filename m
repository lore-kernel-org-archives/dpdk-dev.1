Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED249CA5FFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:31:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC5A640E36;
	Tue,  6 Oct 2026 04:31:08 +0200 (CEST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mails.dpdk.org (Postfix) with ESMTP id CD6DA40E49
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:07 +0200 (CEST)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc51591102fso1786134a12.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253867; x=1791858667; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5JcDnp5L/YxKH2L5v3bL9iGNFXk2xM2yOCPpFyVOh6k=;
 b=SomU72nDvw92WnevLmoCfjaJXOjOPqBJ5ya3YqjYVLxpwx4wYpdll/XdcKDwJ/PEri
 xAaCpdYa2QreL5ZGt3zV0E9H56LW/IgcJ5HViHErLPd5TOP6uhLLS5fCGy6DcsU6JMDk
 1PEVCkUzuMt4SxpPqRabJNszJ7+fpHR801a1+3gcmNAJlk7KEhqEx4g3ofx6/cJvaOq5
 R3H6Rb1xIRmngJN9MubUOjtqPXEObV6Bm9X08IubmkIn4HgOzslb5642BNscUEtY8joo
 0EQ8FkK22bWsLC3rlJHXI7okOGVVwVQy8l+25+shKJ/LK7lzpxO5cxiyC2pzk7oqUVFg
 xrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253867; x=1791858667;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5JcDnp5L/YxKH2L5v3bL9iGNFXk2xM2yOCPpFyVOh6k=;
 b=qnFcqjGXK6NsQtDiIEAeQZIxYaqGaR0XgT79q8aBvf9pCyhEK4F0Rpw9w8A4P/fd7j
 /iqC7i/GLBLDTk+Lp16YSZ5AERP1gkn4wGXV94ho8RZ4jWZL2fAMgadOpYmQCNekGaN+
 6GIsRmktR8Db/Rjf9D8ZjHhmprf7lZo9KSb0JjMKJMNelbxZNoYdnxkJtnIZGuReUJ4x
 GPRFcDlx9KA8QPVtKJMSHSACiUgDhXXjqzWymJFsfNTrae2pgA9MlJoFbUCPHQDWR4cU
 nhs9O1ejiXVzKiVVqtyIoKvi26ApO3++eTujvZnFyp6xL8dKAQUk+ORFxLVaW2dL9mQQ
 bEXQ==
X-Gm-Message-State: AFuF++noPfi6ErwJPcq0Q+JWZ7fqKpcJZ08y/4GKefJulr8d7ME8NmMs
 sKoMreqSalXzy0VIx5ZwVaeVNghsSL89A4AWF2SmhAt8XulWChfOXFi5+tLrIcV5yAeS65N3iDC
 wSucm1fJMA8gPMw==
X-Received: from pgbj17-n2.prod.google.com
 ([2002:a05:6a02:61d1:20b0:cc7:a32b:2d82])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:e188:b0:3dd:a006:ed96 with SMTP id
 adf61e73a8af0-3e0bd15082fmr12885480637.44.1791253866685; 
 Mon, 05 Oct 2026 19:31:06 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:42 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-7-joshwash@google.com>
Subject: [PATCH v4 06/15] net/rnp: use common division round up macro
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
index a95a37f2fe..c03de79e7e 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog

