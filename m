Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C23C55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:54:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E71F240A73;
	Mon,  3 Aug 2026 18:53:25 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 1286F402D0
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:19 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso2880090a12.0
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785775998;
 x=1786380798; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nSePw0DPbWeH9/bbRkgYaQuTUEeKWEejiw5o7BReKZY=;
 b=ilYaOtkge3xjuXXk4SIC+Yl8+P8EW3nLqJDsgSmOwkWEI6qFWX+N4WkD/EjMMLaHVQ
 9GWqxTOFCqUnfRtb7VYsQAPai18D7MSg6Euq7h0DvaSRqguBTw4SY9gSovDTmV32vxNU
 uyu4QNMoMf78fUIaMibLPaTpzDW+o3jOCgGbPrgOs9D8xFfsyUAIFIthTBwg4B0pymVg
 PJ1pan4N9EaqgAUGZAEfr7QeWZdEe1norvfFB+eJc/qjL/Gy1CTuycF8bkH8BAokU6/O
 y6c/+G0hr/oVmBf1cW+gh2XJ9QFyjyGdkOoL6g2li5RI1rHVQKekSupJjWkvXEQ+flVx
 vImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785775998; x=1786380798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nSePw0DPbWeH9/bbRkgYaQuTUEeKWEejiw5o7BReKZY=;
 b=EPI/ZOdQ/M/Jh/X+MKL7uhW0jMoChUQ2jrqKza6RMSwyAm7uA7/9y4TL8LeZZltpj0
 Tcd0mVI8kZvPc5SztEMVB0UIQYi3vsnEKbE6bI+WGpEA5FOb97R8EYRzGt8yqnx9EH3U
 RXQiHfRqK1lMz4wTprfyLqybkDdDRPu0ln0llC71a53B/6vTbVA1o5GC3rttVflU2Gl1
 SPjIt6fTI+n11kbWi70phEVVpjmI0RRLXLyk1wbTxm544dTRYGY6DTb+knOvxFcWkKL8
 MTcd0sxEwyb2i4pjSwML24uKQQVRppVaU6XgyBLCaCYdKzffmczuzPkA1UckfimFmUGL
 DqVQ==
X-Gm-Message-State: AOJu0Yxr9k8W+82GqNWTWJDaLesxPJAe+EEf1R0L+/CoxZiybFWlrjro
 Uflva5FzsS5qLQQjy8c+v1Ew1Y0E4gHz71cTNOuibqmyUP9HF/2Lhvku7JvSZTxmmnbMcwpmuDs
 C7xWm
X-Gm-Gg: AR+sD11jaq0GviV1xorl5QN3XCTAW3U5qFkB16rfhpR6LTbQfjPIrXfTIMWEkjRM3Dj
 gFXl7a7Zhm2lqKmuRPAe1rnXE/VOs9sw7SgO4GTWXLvqS9svouPTX6zh3YGcm0O5E9GLg/g9rF2
 3y3YNSWUQfy661Uv4Tsen15SCjLqHo5c4Dlh+RCCfeq2V+aKsFx5BIZADnwlCrND842XhC+zvHe
 534u4hUbSz+6mgDA5YNLt5Aez3CEERbbEPJyngXg3XSC7lotcJbd6U3XOCJJCiTFt0ruSrLdd3b
 Z1l+a3CS+7lFXHwit1v0MMn7HhgIiW0CDX+WC8RGTKPR2yoM6xWv2yLODnYb3NvZKktl458L2CP
 kXo1F5ouoy/qOR4Yk8J+VVXoHs1ElU4XIzuzumNDFGAwZUp96QkvA2pzfQiFgcD/MnC/KjFYlWS
 uLywU97MKeeu8+Eggdx7s3D57CeeCb8+gG8i3ZE3RHxA3Q9VAmcfST2BEtWz60kd4ptkJmpGafq
 KHKyfkOFHAxEy/PclK0umbeveo=
X-Received: by 2002:a05:6a21:3388:b0:3bf:8604:9a3c with SMTP id
 adf61e73a8af0-3c92a7545camr10639582637.28.1785775998232; 
 Mon, 03 Aug 2026 09:53:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>, Akhil Goyal <gakhil@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v2 11/22] app/test: include headers directly
Date: Mon,  3 Aug 2026 09:51:57 -0700
Message-ID: <20260803165304.289869-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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
 app/test/test_bpf.c                      | 18 +++++++++++++-----
 app/test/test_security_inline_macsec.c   |  2 ++
 app/test/test_security_inline_proto.c    |  1 +
 4 files changed, 17 insertions(+), 5 deletions(-)

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
index 3205afaa63..2fea37396e 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -5,16 +5,26 @@
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
 
 #include "test.h"
 
@@ -30,8 +40,6 @@ test_bpf(void)
 #else
 
 #include <rte_bpf.h>
-#include <rte_ether.h>
-#include <rte_ip.h>
 
 
 /* Tests of most simple BPF programs (no instructions, one instruction etc.) */
@@ -1331,7 +1339,7 @@ test_jump2_check(uint64_t rc, const void *arg)
 	uint16_t eth_type;
 	uint64_t v = -1;
 
-	if (eth_hdr->ether_type == htons(0x8100)) {
+	if (eth_hdr->ether_type == rte_cpu_to_be_16(0x8100)) {
 		const struct rte_vlan_hdr *vlan_hdr =
 			(const void *)(eth_hdr + 1);
 		eth_type = vlan_hdr->eth_proto;
@@ -1341,7 +1349,7 @@ test_jump2_check(uint64_t rc, const void *arg)
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

