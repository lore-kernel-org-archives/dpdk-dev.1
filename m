Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB4AC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:22:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21C2240A84;
	Wed,  1 Jul 2026 18:21:41 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 1E5F240693
 for <dev@dpdk.org>; Wed,  1 Jul 2026 18:21:38 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-37fc01881f2so785971a91.1
 for <dev@dpdk.org>; Wed, 01 Jul 2026 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782922897;
 x=1783527697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTY9Z+25lOu5AOfuzl+tQSUUOi8o6p4dfnzVIH38ndo=;
 b=psC6huk+npGHofJ8b6BNiVjnrQwgHrMK+qUEzipJptPoc9kSP4f5P6uqad9aTti6YR
 y05jnO82MMJXCIqSHiOlFm/3CDYKx5y4XePsSh90XdtJyzmVWkat9msjr2zbHffuIW7K
 IrQIWJYKg7LTErq3IOa+AHXWq64+MgS3vUE5WOfeUMmDEErTxfFfoHY9E2a3o+N5OYZP
 cPlFsJ4a00OvdaojXaS1i6dcE8OzhVsGMa8MJu0TEd8dPjV1a3SLsUPfgpnrVvL8+rxZ
 mXXVnj7VMF7iGrw0qH372j7pSF06zey/kEwJkIxsaUbk7JM+UMDB6cGKvwqNS1hdQcBu
 z4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922897; x=1783527697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qTY9Z+25lOu5AOfuzl+tQSUUOi8o6p4dfnzVIH38ndo=;
 b=kTsXIfKlh1iHUKI6b6yxoJrHU6Af9DEARgW5s3/92lXTDbZD1mGpIwFxVikTrmmkNX
 Im7BPxbyxDDEMgMgzO2JHIa2lPZCdrLQIrjFYefFKFhxEOVCPzQn9z8Bw38fkyMKz562
 iGJn7WPfyIR03BaFhcwSqF2CPo6A+KBdROT+8e2dgPLUwlli1Qzjwuo9Crk26GIKpAq0
 SbxelXpPJ1CqzKbp+R0PfJ0OdM4ffebqcahVgGVB8uplGBuQjzM+Va5kKdHgXP+NPFnd
 aIr/vdkUPEDm4NkOL9FbqoZX1eVq6QSNzIK1P1Y8x7vuNAApu71Nm4lFnULaA5wbBuq4
 9o7Q==
X-Gm-Message-State: AOJu0YwWbUdIVTlqrTumqnxP2yXoFDMF/p6o4oSSlQLXNizd5015IsDg
 1UszqKe+8ypE8zUFLPOKz4wF5oilCp4drp/BhQwVqXIS833OFB/XvGhUBlatFuH14+0gcfzrrSX
 FmJI6
X-Gm-Gg: AfdE7cmARlL0kNTkCk2D6Q4QvN3p+HJytHE2K/GNCS1Lc91+WMbZ/dWfS24TVQaLURZ
 QAQdeIYc+ljMcCegnjPUjOciV3x+dfOGQKjIGkxqqMMVmQrQu8RTBHx1KDXP+ei2H+O4FLFNokE
 YzOxgn7LHxGM3AJeui/Apg8kEtE3VF8spCNpeIgKu94zSkRNd/ChGjBYB3awIEYRuljIkkjIsgD
 Y5mrfKbOF4kUIkxG53+Ohk89Gcp6Ghwknpo7Gk4oa/bxjmgMcs6JG6qG288auZytyIJdrXSJi6M
 QTVt2GW64lxN1jUtr0JyIXDaXAGwa1pEgxkC7FmF/dNmPNoMXUEXy5Ziu0cvoC1Z+TjR2e/0u/y
 Gx6YKGgPnrBIjB91aoVc1hAOf4Zj4sgDjscPAXT22WrzrK8TtqWLKzUE64WcD3GX5ZknR/XDKPP
 zpsiS9fx5v7aOw2wTO6iCkdktrmB84gggfXjsYQJ75vnmQ3y3hmH4=
X-Received: by 2002:a17:90b:534e:b0:37f:a94e:10b0 with SMTP id
 98e67ed59e1d1-380ba966cd9mr1417988a91.24.1782922897240; 
 Wed, 01 Jul 2026 09:21:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee32519aesm22039877eec.27.2026.07.01.09.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:21:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 7/8] ip_frag: remove use of rte_memcpy
Date: Wed,  1 Jul 2026 09:20:32 -0700
Message-ID: <20260701162127.207318-8-stephen@networkplumber.org>
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

Replace rte_memcpy with assignment or plain memcpy to
get more static checking.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ip_frag/rte_ipv6_fragmentation.c | 3 +--
 lib/ip_frag/rte_ipv6_reassembly.c    | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/ip_frag/rte_ipv6_fragmentation.c b/lib/ip_frag/rte_ipv6_fragmentation.c
index c81f2402e3..86dd2e65ce 100644
--- a/lib/ip_frag/rte_ipv6_fragmentation.c
+++ b/lib/ip_frag/rte_ipv6_fragmentation.c
@@ -6,7 +6,6 @@
 #include <errno.h>
 
 #include <eal_export.h>
-#include <rte_memcpy.h>
 
 #include "ip_frag_common.h"
 
@@ -24,7 +23,7 @@ __fill_ipv6hdr_frag(struct rte_ipv6_hdr *dst,
 {
 	struct rte_ipv6_fragment_ext *fh;
 
-	rte_memcpy(dst, src, sizeof(*dst));
+	*dst = *src;
 	dst->payload_len = rte_cpu_to_be_16(len);
 	dst->proto = IPPROTO_FRAGMENT;
 
diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_reassembly.c
index 9aa2f2d08b..cae4266f97 100644
--- a/lib/ip_frag/rte_ipv6_reassembly.c
+++ b/lib/ip_frag/rte_ipv6_reassembly.c
@@ -5,7 +5,6 @@
 #include <stddef.h>
 
 #include <eal_export.h>
-#include <rte_memcpy.h>
 
 #include "ip_frag_common.h"
 
@@ -145,8 +144,8 @@ rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 	int32_t ip_len;
 	int32_t trim;
 
-	rte_memcpy(&key.src_dst[0], &ip_hdr->src_addr, 16);
-	rte_memcpy(&key.src_dst[2], &ip_hdr->dst_addr, 16);
+	memcpy(&key.src_dst[0], &ip_hdr->src_addr, 16);
+	memcpy(&key.src_dst[2], &ip_hdr->dst_addr, 16);
 
 	key.id = frag_hdr->id;
 	key.key_len = IPV6_KEYLEN;
-- 
2.53.0

