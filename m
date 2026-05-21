Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15675CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 04:07:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2457A40290;
	Thu, 21 May 2026 06:07:13 +0200 (CEST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTP id 443914028D
 for <dev@dpdk.org>; Thu, 21 May 2026 06:07:12 +0200 (CEST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7c2fa14795aso42880357b3.1
 for <dev@dpdk.org>; Wed, 20 May 2026 21:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779336431;
 x=1779941231; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j1w5lH5zd/LFKdyM95Xkwu5i/kDNH1ax5WszuUQzGrY=;
 b=kVQQm3wC/gwKZgWqYigxj4pm39mjKruvGGkYHPFCiKNtFwOH6j0L3adLFlmwltLbhA
 p4BiioAv/vnSxoVWj9hDRqDXPMFh8zShHl2ohLSQQ5BRzOMnyLZ9/8cEg98kxJgcANR9
 6DEE2jcf2OgBKtICN81RY2r2JHJxV041t0KfU+yozP32EvEIyjqrS0p3RAaJhxiNEZVL
 kooJgue433YY0/UIhXeLzkzpYMg5497DyuLUZvC+nTBiOoTPX2r1E8bBTA6xhdtpc2uc
 48gjOxVWXc7ZZ0KZU9i+kHt+ZdF7gKkClW+DW7GYiovDItwSUkffxXBu9smerWm1qYDG
 gqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779336431; x=1779941231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1w5lH5zd/LFKdyM95Xkwu5i/kDNH1ax5WszuUQzGrY=;
 b=IlvCpvIKAGQ8oebJhLZlY9n7/UXYdLpGrM/4/Xosk7bq0Pv52b/NasUZYicrLwU02f
 jT7vDSZvyq9waKYSP1e5ujA4f5F6Knfog/qw762HQ+NxhiGt2nKjUFpo9uRV59TMTeFr
 eZqhr3e4x+Ys7MdNf0SBE3Sj3mzf2Gm3b3RjIGaR0frOSLtbbOB9IspB2N/pPEgaOBHh
 2GOdcoZ2SBxK0CJlJ1vLSiTPHZKfhxiFymw88Bv6bEN7daoD5aCDpTvZhGUNgsM8aoJ6
 em1esYbpn3ahu86P+Xse4eWeeEi9e1OkEILA2Mjm0BAmDqqcep7ecgq2r1mDfk8/lo49
 1+qQ==
X-Gm-Message-State: AOJu0YynCbPhg7gQ7dFaVPUxwnUtW1LnqNo1pGzI+M0NkpDLGv8LOjxG
 FfirdswV94l81DLrJIojXduqQ+3t7+44ee3PTylE8o94o7zhwaMlmVjnR6tlQMkxtM9ni2KzIov
 q7/Ka
X-Gm-Gg: Acq92OFlzLTNbptkYMzu/UPpvYZbQVPVAGkuCe7lkOG8au0vOqItuGeMOE5UHUtIGrr
 dmTNt7HIc5/Sf4q+IJpBYo4KnE/079sogoCvIHzjI9eitaFezUE6Hbpk36rs69Ys7sDzqUSa+Vw
 rY6sgncfWtprz216nN0v0Uzflgr71gm3AD/PNEn64+ulmYW7r+naqlzdJLB+hWLMFUSsFG7eDVY
 lzYMERBN0iIgcbu0jp1/Wl+ljg+hBPHOj5J/biPnD+w/DCz+T6VT4JIx+vgTsy9fVoolxxCKNAp
 pKJetIAej3padsZryDYA2ICNuqm2iy+hiK8DLQhOmH/DIHn9k5BfGHrmyO21oTR8J0MiQOkNAvE
 YBqmsU7zWDl9SymlX9q8WnOsVWkbxLRfe0gTFN3D5gr3KiiOaY/7NXYasIH+sMz6VE3GnET/1xV
 JhdrzXWRVlQmGg3nSBIkEXuBLkArUmUDaQZgbQ48nfN8UumZ1IL6XCwGlDFOHf1g==
X-Received: by 2002:a05:690c:4987:b0:7a0:4a34:16d6 with SMTP id
 00721157ae682-7d20cf2b227mr13450837b3.44.1779336431286; 
 Wed, 20 May 2026 21:07:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7cc9d18dcddsm61518587b3.49.2026.05.20.21.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 21:07:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Ron Beider <rbeider@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 Wajeeh Atrash <atrwajee@amazon.com>
Subject: [PATCH] net/ena: use C11 atomic operations in platform header
Date: Wed, 20 May 2026 21:07:07 -0700
Message-ID: <20260521040707.1553463-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Convert the legacy rte_atomic32_t and rte_atomic32_{inc,dec,set,read}
macros to C11 stdatomic equivalents. This clears another user of the
rte_atomicNN_*() family ahead of its deprecation.

Memory ordering is kept at seq_cst, matching the implicit ordering of
the legacy API. The ena_com access patterns can be audited and orderings
tightened in a follow-up.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ena/base/ena_plat_dpdk.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ena/base/ena_plat_dpdk.h b/drivers/net/ena/base/ena_plat_dpdk.h
index c84420de22..83b354d9da 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -40,7 +40,7 @@ typedef uint64_t dma_addr_t;
 #endif
 
 #define ENA_PRIu64 PRIu64
-#define ena_atomic32_t rte_atomic32_t
+typedef RTE_ATOMIC(int32_t) ena_atomic32_t;
 #define ena_mem_handle_t const struct rte_memzone *
 
 #define SZ_256 (256U)
@@ -267,10 +267,14 @@ ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
 #define ENA_REG_READ32(bus, reg)					       \
 	__extension__ ({ (void)(bus); rte_read32_relaxed((reg)); })
 
-#define ATOMIC32_INC(i32_ptr) rte_atomic32_inc(i32_ptr)
-#define ATOMIC32_DEC(i32_ptr) rte_atomic32_dec(i32_ptr)
-#define ATOMIC32_SET(i32_ptr, val) rte_atomic32_set(i32_ptr, val)
-#define ATOMIC32_READ(i32_ptr) rte_atomic32_read(i32_ptr)
+#define ATOMIC32_INC(i32_ptr)							\
+	rte_atomic_fetch_add_explicit((i32_ptr), 1, rte_memory_order_seq_cst)
+#define ATOMIC32_DEC(i32_ptr)							\
+	rte_atomic_fetch_sub_explicit((i32_ptr), 1, rte_memory_order_seq_cst)
+#define ATOMIC32_SET(i32_ptr, val)						\
+	rte_atomic_store_explicit((i32_ptr), (val), rte_memory_order_seq_cst)
+#define ATOMIC32_READ(i32_ptr)							\
+	rte_atomic_load_explicit((i32_ptr), rte_memory_order_seq_cst)
 
 #define msleep(x) rte_delay_us(x * 1000)
 #define udelay(x) rte_delay_us(x)
-- 
2.53.0

