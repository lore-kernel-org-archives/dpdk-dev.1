Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F697C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:21:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53C304065A;
	Wed,  1 Jul 2026 18:21:34 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 5C1F440278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 18:21:32 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so497373a91.2
 for <dev@dpdk.org>; Wed, 01 Jul 2026 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782922891;
 x=1783527691; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MSziaTriju5DyBOpv4fkIbsn++AVoA68cfGSuGqt0o8=;
 b=MrvOIFibkqpRB9r3BFUp4/IvtxezUG0U8Pv2U1Ur0MKBSi/PIciCni8zWeZoZHLA6g
 sxLOVX3ftzXo5fj8G7xENVlSa6Gmqzf7xMugDmKywHDsdu4omqmdM8x0Fj9Iok2fVA4q
 aA0h27wXkatZ932tS9XWaU2My62Spr016j/zwxpB/JjO9spSLPkyPdH2JOMN3pl2kvNc
 XVJCEhpw/Mzht5nyKBT2K5ByOJ2KVoNpRAB14NBlWV1t6vXQc1FCsPfAxg3W7RpYDl+3
 zL9wMs1a0pWrzXjX8u6J1W6ksVl23U46fDfdbicUwDypSPqmvtOvuCjWI0RCC+BAJFdC
 uZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922891; x=1783527691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MSziaTriju5DyBOpv4fkIbsn++AVoA68cfGSuGqt0o8=;
 b=Rw2cUpmiMuSqL/M1G/oqhTCnJK7CtODbESLPrmU0FRL9DsA/mBFADgikTgsvP9wkps
 MsOtyyVWYCulQCmDy/pJktihdmAdc0rbfDDX5h95m7qZRHnlv5xQe7GmfkxK++wuR10M
 o1+sLE79w/7jDtj1jhF/nuv3pHECTQ5qs8iNLfYLIeuspqXEP8r89KMkiGzsO7EsRvUL
 BqxHULb1icCQeHTkxXS+mvU7KIYIV1NRX7GXhVuJ+XFzg8KWuATe1Cqo49oM07aYOq1v
 PRKOez+DYxmzvJ0hBFR1Asm/QPtKEQ/c/FXkFiRVtZBbkxRMkmRT8uBcMNij0EmC4JZR
 OCHQ==
X-Gm-Message-State: AOJu0Yy1+VVoYaS2cjH6x1fXKhehnHazlyZJLjZPeQwmc73Bj5ZA3EdT
 lSaGlltsTyxsDn6m0CbzhQCT8Q890fC+kDPyfWklA9otlp+lFu6hPLxGZtdFV80XoeN7AH4q8vH
 PcWMm
X-Gm-Gg: AfdE7cnYllApHzi7I1eWPgFlfwrZCupQZg0XC7898cUqXJhvf24twlWbv0dgrmcGT8s
 hynP7lfkHqGDO5qrQ68P9llXZrOHSV9brp9Hz9PHb0irmS2xbJuxYcDMPP5FjbvrNsmfWO1qAGv
 ezNYV4C17+mbT4jVsDW587J6bOMlJxLItkEajciqArAc4RB88yoUYLaa2wM76cXKQtmHG2pGC0u
 ljOyVnaYzaC/TkMtGzHCa0kcKY54DexEsquSXfKWrDZOA6FpdivaPSlxKJJR9ex7ZxABj/YdZdx
 Bzn4i1ceGbnMy4geAFh4qvXQPmrch9Dv/A5c90p4KBA1YWYt6M5VJFY4yT3VOtEg0oIvsjGQ219
 Z9sixpSmG6eJGfp6rh6ZNJQ0olWKLyHu0QP/K+pIOFXtIo0ka5yZluSTBaNnOfPjIJV/WuTcyTH
 a35o5tlsk7AmxeFLkKErgqR8LVyHnDi7ftSeALQRpgBrW65WN+vX4=
X-Received: by 2002:a17:90b:3e50:b0:37f:9ce1:7359 with SMTP id
 98e67ed59e1d1-380ba91d27emr1195255a91.26.1782922891319; 
 Wed, 01 Jul 2026 09:21:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee32519aesm22039877eec.27.2026.07.01.09.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:21:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Samyak Jain <samyak.jain@amantyatech.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 1/8] ip_frag: tolerate duplicate fragments
Date: Wed,  1 Jul 2026 09:20:26 -0700
Message-ID: <20260701162127.207318-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701162127.207318-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260701162127.207318-1-stephen@networkplumber.org>
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

The reassembly code tracked only a running byte total and reserved slots
for the first and last fragments, with no check for a fragment
duplicating data already received. A single duplicate could destroy a
recoverable datagram:
 - a duplicate first or last fragment collided with the reserved slot and
   sent the whole entry down the error path, freeing every collected
   fragment;
 - a duplicate intermediate fragment was appended to a new slot, inflating
   frag_size past total_size so reassembly never completed.

RFC 791 reassembly tolerates duplicates: a fragment covering bytes
already present carries no new information. Check for an exact duplicate
(stored fragment with the same offset and length) and drop only that
mbuf, before frag_size is updated, leaving the entry's accounting
unchanged.

Overlapping fragments with differing bounds are a separate issue
addressed in the next patch.

Reported-by: Samyak Jain <samyak.jain@amantyatech.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ip_frag/ip_frag_internal.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/ip_frag/ip_frag_internal.c b/lib/ip_frag/ip_frag_internal.c
index 382f42d0e1..9a03ef995a 100644
--- a/lib/ip_frag/ip_frag_internal.c
+++ b/lib/ip_frag/ip_frag_internal.c
@@ -89,7 +89,23 @@ struct rte_mbuf *
 ip_frag_process(struct ip_frag_pkt *fp, struct rte_ip_frag_death_row *dr,
 	struct rte_mbuf *mb, uint16_t ofs, uint16_t len, uint16_t more_frags)
 {
-	uint32_t idx;
+	uint32_t i, idx;
+
+	/*
+	 * Discard an exact duplicate fragment. If a previously stored fragment
+	 * already covers the same offset and length, this fragment carries no
+	 * new data. Reassembly is tolerant of duplicates (RFC 791), so drop
+	 * only this mbuf and keep the reassembly entry intact rather than
+	 * treating it as an error. Fragments overlapping an existing one with
+	 * different bounds are not handled here.
+	 */
+	for (i = 0; i != fp->last_idx; i++) {
+		if (fp->frags[i].mb != NULL && fp->frags[i].ofs == ofs &&
+				fp->frags[i].len == len) {
+			IP_FRAG_MBUF2DR(dr, mb);
+			return NULL;
+		}
+	}
 
 	fp->frag_size += len;
 
-- 
2.53.0

