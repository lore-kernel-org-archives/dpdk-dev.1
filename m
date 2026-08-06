Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DA0C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84D97406BB;
	Thu,  6 Aug 2026 07:10:24 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 51921409FA
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:22 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38e7109321dso1223573a91.3
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993021;
 x=1786597821; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gs2jNRR6r2gYtYbcXZ8B4yo7gyTcmNT3ebiTgHgK82w=;
 b=hJ5dWVppaPBCh+X+XmZtVg8uDqsfyt/JYtmAw6tkIDT1qpQ3KyfUWSPPMQIGmEPZ7m
 CG9D+XZ4Nq4mpqnqDQWJEyZcy9KQ9p/Eji9O6sH54v7JXraW0SsaCRgIadiygLLDdI7u
 0T7r6d93aY36aVXolspdAFQ0+ySlmz5Bzb5KoVGM7Of4o1pnF7cq2rSv5pC7pK0iM0TS
 tsmYuTMSi1Gw9HmMLkZRWZFveOGpOaiDOiUU/vB3CpnA13KtlAkQqmsZ553Pm51DDrZX
 pqza8YlKA2aSrWHokvDbYWAkSBb/LENqLaxo77YAdAsAc03Def50k1gEXEdE9LcPZFEG
 zoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993021; x=1786597821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gs2jNRR6r2gYtYbcXZ8B4yo7gyTcmNT3ebiTgHgK82w=;
 b=j1owvqbFi8+L6nQc/0bRT8hWPkIq+0M2xpr4AWLOqms5zAabwRNVll9P+ecEQGlufB
 hYVMTc+xaOBmoTBh2jewnYROUpjhMP8IxFO0caXGB/3DEuZzcXnnrUqXe+4r8U+NKusa
 GGFhweLyHBiRNjNSZIuVh9A7MG0D225kEwA/X2OYT4oeimppkirVHqkDfhOKIYjqMdq8
 I9l2+02fUSqIQSoxj93gb1lI6afgqzi8qbPPJTkuZQYt0eRG5auhtsQIphAsUyTvUOa2
 HjwdrOnacF9Xvriu4KLDpKPLZvEN1GmCJB2WeVOytYXIGaJN9XRBL1QP99T8EVfFYCvj
 CTGw==
X-Gm-Message-State: AOJu0YzWm6PL0tFOVbeDYG+5NUrzVtPI88+ri88SvnL6KMLDXuhwA90Z
 BRwBGptKJGvlf49EQ95a+nF9EzoH92B7VV0dQ4P8GX6clbEt63d9Q1zB4wssdEzUZfF+SkhrcTo
 7yzxt6UU=
X-Gm-Gg: AR+sD12eATRZ2cUYQP800co+ebN3IeD/q3HkeiwdxR/KDnVMOk9BuF45dzmbK14T76k
 oyD8DXJyndE7CJIgVMEhz2cyQ8S+8KN2rIH6Kl/NYmbVrZsBm5YH+7zkC9NyY2XD5Q5uHNYdkkX
 hf0B2XK1A5+K21Mua1suapBsYrFxoqR+2z6FbvRejCIca6KjIlb3ofMvCyonJth3xma1I+2Tjbn
 pRZTk0m3+8OSc6BNP7sqpsavXczHW+ZAGVccNpSR+RDd+gJsbosV7FtM5oaoJUaFVRZ9xZ8iiHR
 pwDC+4rzWXl0fe5rg+2CZOkPGnqaNEJL96DXOkXreKweK1YBj84SeDBXRPsp95wAMUpb2vJLHM9
 XsNNYy14DqS916mtcyRQnnUsKT/AAeeuiupj65CLrhtKDS4sf7oXms7Gd9Y0QV16VjNrcIYLT5s
 KNzh5BJJmwI8SLKqRVwVu0gASC+AWNeQRjKTMdI1Hayz1kO7CtxGDxbpC49ST1WlGUZOwJI/lrs
 FUf1ij1fPUs3i4v3NsAhAs33VQh2fYxJS3u4A==
X-Received: by 2002:a17:90b:1b07:b0:36b:77b9:5c8c with SMTP id
 98e67ed59e1d1-3903c5cfe5dmr10822096a91.17.1785993021362; 
 Wed, 05 Aug 2026 22:10:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>, Akhil Goyal <gakhil@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v4 07/23] app/test: include headers directly
Date: Wed,  5 Aug 2026 22:09:01 -0700
Message-ID: <20260806051004.166778-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

The test code was getting network headers indirectly via inclusion
of rte_ethdev.h. This will change in the future, instead get the
headers directly.

For BPF test, use the tool "iwyu" to get more complete set of headers.
Replace use of htons() with equivalent DPDK byteorder macro.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-eventdev/test_pipeline_common.h |  1 +
 app/test/test_bpf.c                      | 20 +++++++++++++++-----
 app/test/test_security_inline_macsec.c   |  2 ++
 app/test/test_security_inline_proto.c    |  1 +
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/app/test-eventdev/test_pipeline_common.h b/app/test-eventdev/test_pipeline_common.h
index 61370fb799..e9f20e7f62 100644
--- a/app/test-eventdev/test_pipeline_common.h
+++ b/app/test-eventdev/test_pipeline_common.h
@@ -12,6 +12,7 @@
 #include <rte_cycles.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
+#include <rte_ip.h>
 #include <rte_event_eth_rx_adapter.h>
 #include <rte_event_eth_tx_adapter.h>
 #include <rte_eventdev.h>
diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 3205afaa63..5b71f94a71 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -5,16 +5,28 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdint.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdalign.h>
 #include <inttypes.h>
+#include <errno.h>
+#include <limits.h>
 #include <unistd.h>
 
-#include <rte_memory.h>
+#include <rte_bitops.h>
 #include <rte_debug.h>
 #include <rte_hexdump.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
+#include <rte_mbuf.h>
 #include <rte_random.h>
 #include <rte_byteorder.h>
 #include <rte_errno.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
 
 #include "test.h"
 
@@ -30,8 +42,6 @@ test_bpf(void)
 #else
 
 #include <rte_bpf.h>
-#include <rte_ether.h>
-#include <rte_ip.h>
 
 
 /* Tests of most simple BPF programs (no instructions, one instruction etc.) */
@@ -1331,7 +1341,7 @@ test_jump2_check(uint64_t rc, const void *arg)
 	uint16_t eth_type;
 	uint64_t v = -1;
 
-	if (eth_hdr->ether_type == htons(0x8100)) {
+	if (eth_hdr->ether_type == rte_cpu_to_be_16(0x8100)) {
 		const struct rte_vlan_hdr *vlan_hdr =
 			(const void *)(eth_hdr + 1);
 		eth_type = vlan_hdr->eth_proto;
@@ -1341,7 +1351,7 @@ test_jump2_check(uint64_t rc, const void *arg)
 		next = eth_hdr + 1;
 	}
 
-	if (eth_type == htons(0x0800)) {
+	if (eth_type == rte_cpu_to_be_16(0x0800)) {
 		ipv4_hdr = next;
 		if ((ipv4_hdr->dst_addr & rte_cpu_to_be_32(TEST_NETMASK)) ==
 		    rte_cpu_to_be_32(TEST_SUBNET)) {
diff --git a/app/test/test_security_inline_macsec.c b/app/test/test_security_inline_macsec.c
index a929ff5326..43672ef237 100644
--- a/app/test/test_security_inline_macsec.c
+++ b/app/test/test_security_inline_macsec.c
@@ -8,6 +8,8 @@
 #include <rte_ethdev.h>
 #include <rte_malloc.h>
 #include <rte_security.h>
+#include <rte_flow.h>
+#include <rte_macsec.h>
 
 #include "test.h"
 #include "test_security_inline_macsec_vectors.h"
diff --git a/app/test/test_security_inline_proto.c b/app/test/test_security_inline_proto.c
index 0b1f7fbbab..99111e5432 100644
--- a/app/test/test_security_inline_proto.c
+++ b/app/test/test_security_inline_proto.c
@@ -7,6 +7,7 @@
 #include <inttypes.h>
 
 #include <rte_ethdev.h>
+#include <rte_flow.h>
 #include <rte_malloc.h>
 #include <rte_security.h>
 
-- 
2.53.0

