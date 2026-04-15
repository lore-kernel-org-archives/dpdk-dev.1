Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E729F43828
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:50:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ADDA40B9C;
	Wed, 15 Apr 2026 16:48:31 +0200 (CEST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by mails.dpdk.org (Postfix) with ESMTP id CB72840BA2
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:29 +0200 (CEST)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-463f00cda04so3572447b6e.2
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264509;
 x=1776869309; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYqF4QjROE90sWvsYA4QbbeM6zEXxY5t92zIWOvCmsg=;
 b=gRFnIsvDNdgGymJP/AsJkViGlpS1QbOE1/tePxYzqu82RduoJtixPncMYxEIZq2jp8
 fG+9bz33mjP95Qqbe11Z/zPCmWwZxt22aCoCziyofnk/9kap4+DLGZWNtpBVA43279Lt
 /sKFDs9gZHYOMtPSu+BBdjLBVQsP9tNV8s8kU8pnK8G3H2j6oEcoxAiOTLZYWEegwmFu
 dzi5LOn5DnkYK8pkkXPYNsvVFQ5+661Gqa/hjJC/9NIrIinrVs9LSRLkS354CzUYgUAn
 I0azc4zofZPJgCl0Hz1VEGmF0p9eXI9ZZrEjjOIAmR9yUDSt1aQmAKoGT/Ck+A5G6CSf
 PFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264509; x=1776869309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZYqF4QjROE90sWvsYA4QbbeM6zEXxY5t92zIWOvCmsg=;
 b=fOzbQPOdkAfhZC8BG8FlQlezf1OI4T2ln1LSba8tL1LS3IJGTfPWSuO2qCYO2fD04A
 PXChu3NLOzmvbDAO8nq+NuPP5EAhQM3aw0wb+RpHWE2q+QYa8RlQuJnGgXwTZdYKVxl0
 szHxSj00n80M78HchaA+V5UsKZ82OA6h2YKCyDTF7tmxibkP+kGLBtMkevK0QB0TnbWT
 ZpEgDhAYj/Pj2P0fjd6w42JVpMOK+HJZ3d+C4fYRwL2mmrfqEmB4V/H4t+jD0uNwoKuy
 ls/5JXROgmvmP2PYivI5HKbOYZ5D2VlopXOgd7hiu2iTRJMmG79N7T9FPo3jIBw+Yo1r
 14Ag==
X-Gm-Message-State: AOJu0YwWq/HJ5U1yRyyMhAdp8aewx+hHmS1Hz8ARivmchlSTqwiNW2wI
 ZNyuDuSkvyUNBJ6nXDN2qjGK0HlrN4pm75cKHCBLjwlplyrz8hjV925mUYV8aoddcDnmV0v6rVN
 Nirqm
X-Gm-Gg: AeBDieuJRRPrBbbk/+sknEPzdu5ls54kP2+ibqR3NaMz0G0oQ1nuNy8/WecWE/vpsvr
 rwDmjpzB5/Gj5FpRNbW3p43Q68YwKj6H40I7Kx2jHiQ1cBWrAngFj8ZwsFEHCMb9vpCeRqpMSkD
 0zPIAx2Af9bnFm0BrZv6TL1/uk0XSKr0s+FuG2sbDnoHLXfpcYG5kPM8RY+VriwPLfQHEMdoN+Y
 FATgyUUBGblysbNY6C0LpX7+8MmwxTFEdxghG9dKJ58LxToWYv7qw1xJ3gmBikVbK5TdIBgKfFg
 bpsaXavIrEEhx17krXQXOiPVfDo1BSs16/0ISkZebxHcPlJlVIkiyMspsghWKAZysJKOiY4jWmm
 x6828BVC//IfncCLo9EQbgtQWlAlT8LLNIw/kzGo1GBCS2LyhuQdRL2SfwNTQXI6dkeOwINE/aq
 3tvPJCbOFKnmbKBnf+NpmjyaUJyLLCAn0Dp288MM5q09w=
X-Received: by 2002:a05:6808:c297:b0:467:1e7b:72d0 with SMTP id
 5614622812f47-4789c64ac25mr11318221b6e.5.1776264509096; 
 Wed, 15 Apr 2026 07:48:29 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v23 17/24] net/pcap: reduce scope of file-level variables
Date: Wed, 15 Apr 2026 07:46:06 -0700
Message-ID: <20260415144717.226161-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

Move errbuf from file scope to local variables in the two functions that
use it (open_iface_live and open_single_rx_pcap). This avoids potential
issues if these functions were called concurrently, since each call now
has its own error buffer.  Move iface_idx to a static local variable
within pmd_init_internals(), the only function that uses it. The
variable remains static to preserve the MAC address uniqueness counter
across calls.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 01b26184e6..99ffc29817 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -46,11 +46,9 @@
 
 #define RTE_PMD_PCAP_MAX_QUEUES 16
 
-static char errbuf[PCAP_ERRBUF_SIZE];
 static struct timespec start_time;
 static uint64_t start_cycles;
 static uint64_t hz;
-static uint8_t iface_idx;
 
 static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
@@ -622,6 +620,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -733,6 +732,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1490,6 +1491,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.53.0

