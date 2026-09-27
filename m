Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61719C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Sep 2026 19:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9329140299;
	Sun, 27 Sep 2026 21:50:21 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3BE124026D
 for <dev@dpdk.org>; Sun, 27 Sep 2026 21:50:20 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98dso1369034a91.0
 for <dev@dpdk.org>; Sun, 27 Sep 2026 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790538619;
 x=1791143419; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tyFHOCCqnLPeNY3gx4vw5wj7xlhbvY4daz7rhprHXBc=;
 b=gNuxFnpiWBggzy9oSsoB7DFXokTONMWlEnnqpt5cyJHdn+xmqwN2TQNVHjWDB+2HuB
 c468DsHGTjl/zhajmq7Q4aHwHHEYQXqCNLBWO+LsvyhTPoiFyuM/BzwARHg/EBGApF3l
 HR/mkIWQm7H8gfrzwBpltc2b0iEIjWL6XUT47m9KSGspJHV0715kJa54tb7KBvURh3iT
 QtasxXFNRcLRAu+IH6Q2WZbCN9P31+zIxnITSN3IVrWZ+DclVtuukZxmvWG+kIIetfp5
 EYTxYeOGDFq5esP6hT9ACuF2LA6de9B1uTeCj7Aw9MmEBmD4jDutqKuRxcP16pb9yuJO
 ro2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790538619; x=1791143419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tyFHOCCqnLPeNY3gx4vw5wj7xlhbvY4daz7rhprHXBc=;
 b=2C0quUQshUeSF4rTn9Ia4MUfrFwFXMXbLqCcRvEWco8o66bOsDPCUxh5kBbMa49wEW
 yFvzqno71N9+1P3EP6z2pOndGMqCEeXJfA7SADMmRib9jvLvYk7m5L7QT2UgY4wW6gmT
 ifp1pPzRpsWOE5G2JzLVnSy+tgQBMjMJZWVLySo8yz0CSYiyBfSDZJvyEiw4O69C3b0p
 d16ptvssioEFOuwfJlWgHa5kQkjauoRVePrcm+ozfbRXdW1vJN8zWpVR9+LpzuFOEU+r
 BA2IVYAL4KlapI5kinLoOA6p7929foLAjq6iN7ZjGlXbvqQ84vc2z6JWMIr/agG/lpmI
 Pm7A==
X-Gm-Message-State: AFq9FYLhf68LjTKpD3d4tdD91pJ8Vb6zsTpSu2Q3J3jBL4DzH/LEqVTl
 Q16zZhRI7klhrSk30LLoHDPo80dH5GIB11fGmMi4Ax3hJaPpQNqDBqimY6pSNH3KdRbBJRfBq4q
 R14026iM=
X-Gm-Gg: AYBFou1cjiTlI+WVq32MmGa07aTNTFo5iRm+YAc2SoWvvO/BFuB0IrpzPOux9k8J5Hp
 4SQermU3qh4f6LfffFw6WIcJMXpsP54fn0e21XquyqcaqLfSD9R+QK1aGORSJnOYHYY1APc1RTS
 05xuQvHEaK8dxrlepTVfDd2MJjdk2E6X1Kb4L5RIqnV6MzC+w0hJTIb3r1bM7WNjXZ7LCWaveRz
 L4r7Q1+hTbmgDLBaMDqA8SUGx/bvt7Knuu2YzfPzelR1FQHdfe03frr+8uS3V6ja8C6RmTCP8fD
 G2OMso1/N99JoXz6uU2cHj0faLbrk7hOK37kwo5/Xte0UsVwdpe04GFNAZcpL483YjRskLw6aoS
 xSXUu4SUdRraIBrW9WqMQQyjXJwEMZTQdFALSchNQpwvxAZ4qN+mzdX60EMceiuM+P40qS+a9n3
 8JuIQDecu4R/GeoU7EllQUCNyOEihX5w2e2hP/MOMRRAPbOd+lbjJVOUvBLQkgXtvnZS/4wfpEE
 Mn0h5q+QEhOBspExB9itzhBwBWf7rbQEAcHisE=
X-Received: by 2002:a17:90b:274e:b0:39e:4546:fb13 with SMTP id
 98e67ed59e1d1-3a0bb5788femr6099702a91.19.1790538618944; 
 Sun, 27 Sep 2026 12:50:18 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0976ca5f9sm23133053a91.14.2026.09.27.12.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 12:50:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 1/2] pcapng: revert use of reciprocal divide for timestamps
Date: Sun, 27 Sep 2026 12:50:14 -0700
Message-ID: <20260927195015.78109-1-stephen@networkplumber.org>
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

The use of recprocal divide caused in calculating timestamps
caused overflow wraparound. This bug was introduced by confusion
about bits, shift, and the test was too short to catch the
problem.

Go back to just doing the divide which ends up faster on many
than having to do 128 bit math on many CPU types.

This is not a pure git revert because there were other
good things in that commit like handling earlier packets,
and catching if TSC hz was zero.

Fixes: 4fc65615b274 ("pcapng: improve performance of timestamping")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 108 ++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 70 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b5d1026891..df38e4819c 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -26,7 +26,6 @@
 #include <rte_mbuf.h>
 #include <rte_os_shim.h>
 #include <rte_pcapng.h>
-#include <rte_reciprocal.h>
 #include <rte_time.h>
 
 #include "pcapng_proto.h"
@@ -37,23 +36,12 @@
 /* upper bound for strings in pcapng option data */
 #define PCAPNG_STR_MAX	UINT16_MAX
 
-/*
- * Converter from TSC values to nanoseconds since Unix epoch.
- * Uses reciprocal multiply to avoid runtime division.
- */
-struct tsc_clock {
-	uint64_t tsc_base;          /* TSC value at initialization. */
-	uint64_t ns_base;           /* Nanoseconds since epoch at init. */
-	struct rte_reciprocal_u64 tsc_hz_inv; /* Reciprocal of TSC frequency. */
-	uint32_t shift;             /* Pre-shift to avoid overflow. */
-};
-
 /* Format of the capture file handle */
 struct rte_pcapng {
 	int  outfd;		/* output file */
 	unsigned int ports;	/* number of interfaces added */
-
-	struct tsc_clock clock;
+	uint64_t offset_ns;	/* ns since 1/1/1970 when initialized */
+	uint64_t tsc_base;	/* TSC when started */
 
 	/* DPDK port id to interface index in file */
 	uint32_t port_index[RTE_MAX_ETHPORTS];
@@ -110,62 +98,36 @@ static ssize_t writev(int fd, const struct iovec *iov, int iovcnt)
 #endif
 
 /*
- * Initialize TSC-to-epoch-ns converter.
+ * Convert a count of cycles to nanoseconds.
  *
- * Captures current TSC and system clock as a reference point.
+ * Compute the whole seconds first, so that the remainder is always
+ * less than the frequency and scaling it by NS_PER_S cannot wrap.
  */
-static int
-tsc_clock_init(struct tsc_clock *clk)
+static uint64_t
+pcapng_cycles_to_ns(uint64_t delta)
 {
-	struct timespec ts;
-	uint64_t cycles, tsc_hz, divisor;
-	uint32_t shift;
-
-	memset(clk, 0, sizeof(*clk));
-
-	/* If Hz is zero, something is seriously broken. */
-	tsc_hz = rte_get_tsc_hz();
-	if (tsc_hz == 0)
-		return -1;
-
-	/*
-	 * Choose shift so (delta >> shift) * NSEC_PER_SEC fits in uint64_t.
-	 * For typical GHz-range TSC and ~1s deltas this is 0.
-	 */
-	shift = 0;
-	divisor = tsc_hz;
-	while (divisor > UINT64_MAX / NSEC_PER_SEC) {
-		divisor >>= 1;
-		shift++;
-	}
-
-	clk->shift = shift;
-	clk->tsc_hz_inv = rte_reciprocal_value_u64(divisor);
+	const uint64_t hz = rte_get_tsc_hz();
+	uint64_t secs = delta / hz;
+	uint64_t rem = delta % hz;
 
-	/* Sample TSC and system clock as close together as possible. */
-	cycles = rte_get_tsc_cycles();
-	clock_gettime(CLOCK_REALTIME, &ts);
-	clk->tsc_base = (cycles + rte_get_tsc_cycles()) / 2;
-	clk->ns_base = (uint64_t)ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
-
-	return 0;
+	return secs * NS_PER_S + (rem * NS_PER_S) / hz;
 }
 
-/* Convert a TSC value to nanoseconds since Unix epoch. */
-static inline uint64_t
-tsc_to_ns_epoch(const struct tsc_clock *clk, uint64_t tsc)
+/* Convert from TSC (CPU cycles) to nanoseconds */
+static uint64_t
+pcapng_timestamp(const rte_pcapng_t *self, uint64_t cycles)
 {
-	uint64_t delta, ns;
-
-	if (unlikely(tsc < clk->tsc_base)) {
-		delta = clk->tsc_base - tsc;
-		ns = (delta >> clk->shift) * NSEC_PER_SEC;
-		return clk->ns_base - rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
-	}
+	/*
+	 * A packet may be copied before the file was opened, so the TSC
+	 * can be behind the reference point.  Handle both directions on
+	 * an unsigned magnitude.
+	 */
+	if (unlikely(cycles < self->tsc_base))
+		return self->offset_ns -
+			pcapng_cycles_to_ns(self->tsc_base - cycles);
 
-	delta = tsc - clk->tsc_base;
-	ns = (delta >> clk->shift) * NSEC_PER_SEC;
-	return clk->ns_base + rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
+	return self->offset_ns +
+		pcapng_cycles_to_ns(cycles - self->tsc_base);
 }
 
 /* length of option including padding */
@@ -399,7 +361,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 {
 	struct pcapng_statistics *hdr;
 	struct pcapng_option *opt;
-	uint64_t start_time = self->clock.ns_base;
+	uint64_t start_time = self->offset_ns;
 	uint64_t sample_time;
 	uint32_t optlen, len;
 	uint32_t *buf;
@@ -452,7 +414,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	hdr->block_length = len;
 	hdr->interface_id = self->port_index[port_id];
 
-	sample_time = tsc_to_ns_epoch(&self->clock, rte_get_tsc_cycles());
+	sample_time = pcapng_timestamp(self, rte_get_tsc_cycles());
 	hdr->timestamp_hi = sample_time >> 32;
 	hdr->timestamp_lo = (uint32_t)sample_time;
 
@@ -737,13 +699,10 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 			return -1;
 		}
 
-		/*
-		 * When data is captured by pcapng_copy the current TSC is stored.
-		 * Adjust the value recorded in file to PCAP epoch units.
-		 */
+		/* adjust timestamp recorded in packet */
 		cycles = (uint64_t)epb->timestamp_hi << 32;
 		cycles += epb->timestamp_lo;
-		timestamp = tsc_to_ns_epoch(&self->clock, cycles);
+		timestamp = pcapng_timestamp(self, cycles);
 		epb->timestamp_hi = timestamp >> 32;
 		epb->timestamp_lo = (uint32_t)timestamp;
 
@@ -789,6 +748,8 @@ rte_pcapng_fdopen(int fd,
 {
 	unsigned int i;
 	rte_pcapng_t *self;
+	struct timespec ts;
+	uint64_t cycles;
 	int ret;
 
 	if ((osname && strlen(osname) > PCAPNG_STR_MAX) ||
@@ -808,11 +769,18 @@ rte_pcapng_fdopen(int fd,
 	self->outfd = fd;
 	self->ports = 0;
 
-	if (tsc_clock_init(&self->clock) < 0) {
+	/* If Hz is zero, something is seriously broken. */
+	if (rte_get_tsc_hz() == 0) {
 		rte_errno = ENODEV;
 		goto fail;
 	}
 
+	/* record start time in ns since 1/1/1970 */
+	cycles = rte_get_tsc_cycles();
+	clock_gettime(CLOCK_REALTIME, &ts);
+	self->tsc_base = (cycles + rte_get_tsc_cycles()) / 2;
+	self->offset_ns = rte_timespec_to_ns(&ts);
+
 	for (i = 0; i < RTE_MAX_ETHPORTS; i++)
 		self->port_index[i] = UINT32_MAX;
 
-- 
2.53.0

