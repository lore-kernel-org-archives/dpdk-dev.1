Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83552C55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:46:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55C6740A81;
	Tue,  4 Aug 2026 17:46:06 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4A7C440A75
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:05 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso2914993a12.2
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858364;
 x=1786463164; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gs2jNRR6r2gYtYbcXZ8B4yo7gyTcmNT3ebiTgHgK82w=;
 b=QUiMKqQINOwa36fNZ3yV8nQN7XHzLtfoHK4aUb4JdtWBLqM/FTq/DpqeTrUeJQUkGR
 7PvgE40OZAGKCV+d37TkNFA3UEJ9IKU/0wolbNQ6XYeigDyf+TxT9Qgp81qB2Ne9l3mC
 jjVsiBqTA/q6aQ6aks7Wsx6Ap7kd9ZW2I/aH/b7yJ0hcKt7/HPsTs7sGXT6oApNpTWPz
 G23q2x4A5wOVf/9nRFGmDqlVVVyarfeBUKYPR5W7XelJOUuuZ748tbey2P7mfl7wnjFS
 2GoSFcOBQb+f6ZMsGz6FpI0qM0evIf6ESZ1adw7MEr/t8c9lX/se+zBhyiDQE0o6zvx9
 5erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858364; x=1786463164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gs2jNRR6r2gYtYbcXZ8B4yo7gyTcmNT3ebiTgHgK82w=;
 b=V7+CXNeglVMb2BUkaSQ5mtR91/8S0LxNm69DSUKsO3JeQ4OGw402a1qTJ5owMZUSWT
 Da2cU8iuRWf5UDt9jLRRwMeRmciu6kLxi/UaRAa9/ZhdH+uVCPE3/L8z3IRUcu6ZuFwo
 GKSHY+cZVptft9dK1E1FuKojbOFfrYruel/4NrL6UhK+WXLUtX4G0l0KpltJ5K/yOtj0
 2G4JcE16gRhjRlPIlZHYN6qlCF0wl+G1CeqeA0uxqnu3KTN/lDJlsBexEkdo1JtmG5up
 qFOURlZ/nPbeW4sowLhE6LJuV7i7XGXoh0oLwI2pMHYYXR3eXAKlw6E1l5NcbBVP2Ynh
 28Nw==
X-Gm-Message-State: AOJu0Yw+v+unSFRlNVJg3JepbX1VU+G0/ib//pn5ukG4Dxdbh1r4Tt9R
 PSG/DbT/0sCVM/swFzG9vq+v0B5g4TJVsbibAUurf+PxxyswBmBtnIggnBy6YOh/PmQ1+pwEBIJ
 35Dq+
X-Gm-Gg: AR+sD13eewJpUJ/ASsY48XKSbc8GA9TnRo1ufow7PHL+P1WPsJgVL3+ows/kb4mJ/dY
 uQgxsaZLOzlnJEiw5Vxg0lpN7RGjuExkjS96tAKfuzuGZm+OwUvUkQv/MBNOSoBpCsGJR8P6Qav
 E7oq9DhOHSWWwQLqyGWebd/p+3FIh9WmDs5Rjg6rnrH6hHnpXOpERQ2ftfgvhX4BUueQ3H97SfQ
 sDRadgfkLZ4lARteEOzYdWl0VA8/sglm49RON4qKcwmzkIO0rRjkWC9H/RNUlAbh/I1bI8jixk/
 frpkZoJHw7SpjgKi6cHZP/fIw3LCmhuVwdxyP3a86OVFOXj3cMUTvav+WxM3mlJhiVrmTpZ5aUi
 fsj+UHwiyTYNYEdW5vAGcs/8MP666ihDqQBVHBBX/kloXIaxPQmS8K9cIkVQqEktzEE7wi+KzLX
 6RevY63Va8AN87zGA/9qszz324Lk0F1VP/Gk7Y4Pgyyuyz0Vz3zFI36SwHdG91EuiCbpK8GtPSw
 EenyIuA4OD+2H6ba8BR+flgiFd+kTM9ha7Crw==
X-Received: by 2002:a05:6a21:1fc8:b0:3bf:9b3d:61bb with SMTP id
 adf61e73a8af0-3c92a588f6dmr15287265637.16.1785858364415; 
 Tue, 04 Aug 2026 08:46:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>, Akhil Goyal <gakhil@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v3 07/23] app/test: include headers directly
Date: Tue,  4 Aug 2026 08:44:55 -0700
Message-ID: <20260804154549.148691-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804154549.148691-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
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

