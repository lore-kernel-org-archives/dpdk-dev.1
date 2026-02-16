Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3519E8383C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 21:44:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9175840687;
	Mon, 16 Feb 2026 22:43:31 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 8D1CE4065A
 for <dev@dpdk.org>; Mon, 16 Feb 2026 22:43:29 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so3578166f8f.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 13:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771278209;
 x=1771883009; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsRAzgKjpv83C9eZAztUaAjhMOoJF2IhRoGtQm3+xC4=;
 b=qp1rUqPKeCaTFXzIvu4E5NLcJu3mX0Lmi88ncCR4oDRYKTelKSdf7nl7kldqSEkR/h
 GxnP02alRXvpgImqnBTXv8l8dJBlTjomTMGNexkN9L//QLM7o6sClp2/SYkxgzdnxzBv
 Jc8FR78qfGBFmnAq0C4Mrp1i0H6lFWaceNW7Y7ZTX8rWMeQf7bm1M3L94aJdLlWoXi3N
 5huIMO7iJM/0KvilkMMubETliRqHtmls5XHpJSrjdlibaVTRIh0ugapdo8Ha2Pu3cmei
 A51XV91+96XWjOG2yRTMtqsw9wU6T6XIgUvCI9hnt8YsFcFyI55aPIX8LpTW5lQY4yJT
 pLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771278209; x=1771883009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wsRAzgKjpv83C9eZAztUaAjhMOoJF2IhRoGtQm3+xC4=;
 b=WTINnswd8Pfsnw0P0z7zP9Z6mGGfA5SI6w9gvZfahu9sOi2sMAvco8yLKZwaWD3R99
 yjomP2Q7Y6K3W1zV0v5SLXRPkx8Ck0o8Q/0CZ9fI3cSQyRaFaPzrv5V3HP+yuk3udlYD
 zUdvNJ445MTug6j5VBBLj055V/2naSKxFZeZQOsSU2m26DA0e05oM+CG+sAhoI7d73x3
 PhEn15j5WtTG7+aPNCLWPRmR8RudHRexnscgHTg0pruozYPUIGpDrm5V4Sc4mgXNy82v
 0zhWgfWfBhn1K+UVzOjP8Hl99AR5zzLvg7ES8a7PbzLie3V5a98BjpvjclXDjCUb8Nb7
 115g==
X-Gm-Message-State: AOJu0YwjfrFQa3Glj7RgXv12ZkXKfTQsWZXcJsHNmsAjwR/Gv3VbtTiy
 XqgQpMQqoMAzVRToUmOya1ZPlSw45jIIWPyCnNtIMqhYL9HIibMIxdSzOF/4WEhcG8pviUH8Tjv
 mO7Yfb2E=
X-Gm-Gg: AZuq6aIUBjt7EkOu5/BGfJ8mKaPq+8YrGOJsXaa5eSeiZHUULy9OvlFsmkFVUBzRs5K
 RQqPXrTwd2T0gMJPFCJfOBDV0HGQ4TI/BgFHy9X4pAzaQ5l0NeH2tj4tJqkRFAgZW/pR0DQKNFd
 5+7D03VRRZm42jLyuN8W4g3Y7KqD4rIhrxFG25fmqvFP4LIqxPMEad9519oKqgEmveS00H1lLzY
 +AP8MhYTWZmRnEj8aPLAOOjK64+ZcKCc8yRmgQWcCuTk2U5ECAv4Y3MTW08dfBJRPI25sTG3kys
 8jKW/dIUzyqajYtUjr5+sq/83wp8XO0/ShJgAzYuLgqXsvKBIDWyGeJx9mZkfgR4IYSdGwcgj1H
 r6INzcOqkbF0N6jxnkDnGFS3JZAlYWzufDDArlhjkQ8h0jbGzeAJWInINwWhEv7wzDpibznsl3i
 u8n5BP9RsXbZitvjYPub+dnCyhX/iR0KDgNNoWy0sTY80Q2UUNANkzXrUb+a5W+pewkDAVWYO/
X-Received: by 2002:a05:6000:238a:b0:436:216:98d8 with SMTP id
 ffacd0b85a97d-437978c1a33mr22881356f8f.12.1771278209032; 
 Mon, 16 Feb 2026 13:43:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm32146354f8f.3.2026.02.16.13.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 13:43:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 6/8] pcapng: improve performance of timestamping
Date: Mon, 16 Feb 2026 13:38:03 -0800
Message-ID: <20260216214311.717492-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216214311.717492-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260216214311.717492-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Avoid doing expensive divide operations when converting
timestamps from cycles (TSC) to nanoseconds for pcapng.

Precompute a rte_reciprocal_u64 inverse of the TSC frequency
and a right-shift count chosen so that the intermediate
product (delta >> shift) * NSEC_PER_SEC cannot overflow
uint64_t. The per-packet conversion then requires only a
shift, a multiply, and a reciprocal divide—no division.

For TSC frequencies less than 18.4 GHz the shift value will
be zero but code is defensive to be future proof.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 97 +++++++++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 24 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 2cc2ea2f2f..38fc518515 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -37,12 +37,23 @@
 /* upper bound for strings in pcapng option data */
 #define PCAPNG_STR_MAX	UINT16_MAX
 
+/*
+ * Converter from TSC values to nanoseconds since Unix epoch.
+ * Uses reciprocal multiply to avoid runtime division.
+ */
+struct tsc_clock {
+	uint64_t tsc_base;          /* TSC value at initialization. */
+	uint64_t ns_base;           /* Nanoseconds since epoch at init. */
+	struct rte_reciprocal_u64 tsc_hz_inv; /* Reciprocal of TSC frequency. */
+	uint32_t shift;             /* Pre-shift to avoid overflow. */
+};
+
 /* Format of the capture file handle */
 struct rte_pcapng {
 	int  outfd;		/* output file */
 	unsigned int ports;	/* number of interfaces added */
-	uint64_t offset_ns;	/* ns since 1/1/1970 when initialized */
-	uint64_t tsc_base;	/* TSC when started */
+
+	struct tsc_clock clock;
 
 	/* DPDK port id to interface index in file */
 	uint32_t port_index[RTE_MAX_ETHPORTS];
@@ -98,21 +109,59 @@ static ssize_t writev(int fd, const struct iovec *iov, int iovcnt)
 #define if_indextoname(ifindex, ifname) NULL
 #endif
 
-/* Convert from TSC (CPU cycles) to nanoseconds */
-static uint64_t
-pcapng_timestamp(const rte_pcapng_t *self, uint64_t cycles)
+/*
+ * Initialize TSC-to-epoch-ns converter.
+ *
+ * Captures current TSC and system clock as a reference point.
+ */
+static int
+tsc_clock_init(struct tsc_clock *clk)
 {
-	uint64_t delta, rem, secs, ns;
-	const uint64_t hz = rte_get_tsc_hz();
+	struct timespec ts;
+	uint64_t cycles, tsc_hz, divisor;
+	uint32_t shift;
+
+	memset(clk, 0, sizeof(*clk));
+
+	/* If Hz is zero, something is seriously broken. */
+	tsc_hz = rte_get_tsc_hz();
+	if (tsc_hz == 0)
+		return -1;
+
+	/*
+	 * Choose shift so (delta >> shift) * NSEC_PER_SEC fits in uint64_t.
+	 * For typical GHz-range TSC and ~1s deltas this is 0.
+	 */
+	shift = 0;
+	divisor = tsc_hz;
+	while (divisor > UINT64_MAX / NSEC_PER_SEC) {
+		divisor >>= 1;
+		shift++;
+	}
+
+	clk->shift = shift;
+	clk->tsc_hz_inv = rte_reciprocal_value_u64(divisor);
+
+	/* Sample TSC and system clock as close together as possible. */
+	cycles = rte_get_tsc_cycles();
+	clock_gettime(CLOCK_REALTIME, &ts);
+	clk->tsc_base = (cycles + rte_get_tsc_cycles()) / 2;
+	clk->ns_base = (uint64_t)ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
+
+	return 0;
+}
 
-	delta = cycles - self->tsc_base;
+/* Convert a TSC value to nanoseconds since Unix epoch. */
+static inline uint64_t
+tsc_to_ns_epoch(const struct tsc_clock *clk, uint64_t tsc)
+{
+	uint64_t delta, ns;
 
-	/* Avoid numeric wraparound by computing seconds first */
-	secs = delta / hz;
-	rem = delta % hz;
-	ns = (rem * NS_PER_S) / hz;
+	delta = tsc - clk->tsc_base;
+	ns = (delta >> clk->shift) * NSEC_PER_SEC;
+	ns = rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
 
-	return secs * NS_PER_S + ns + self->offset_ns;
+	return clk->ns_base + ns;
 }
 
 /* length of option including padding */
@@ -346,7 +395,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 {
 	struct pcapng_statistics *hdr;
 	struct pcapng_option *opt;
-	uint64_t start_time = self->offset_ns;
+	uint64_t start_time = self->clock.ns_base;
 	uint64_t sample_time;
 	uint32_t optlen, len;
 	uint32_t *buf;
@@ -399,7 +448,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	hdr->block_length = len;
 	hdr->interface_id = self->port_index[port_id];
 
-	sample_time = pcapng_timestamp(self, rte_get_tsc_cycles());
+	sample_time = tsc_to_ns_epoch(&self->clock, rte_get_tsc_cycles());
 	hdr->timestamp_hi = sample_time >> 32;
 	hdr->timestamp_lo = (uint32_t)sample_time;
 
@@ -684,10 +733,13 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 			return -1;
 		}
 
-		/* adjust timestamp recorded in packet */
+		/*
+		 * When data is captured by pcapng_copy the current TSC is stored.
+		 * Adjust the value recorded in file to PCAP epoch units.
+		 */
 		cycles = (uint64_t)epb->timestamp_hi << 32;
 		cycles += epb->timestamp_lo;
-		timestamp = pcapng_timestamp(self, cycles);
+		timestamp = tsc_to_ns_epoch(&self->clock, cycles);
 		epb->timestamp_hi = timestamp >> 32;
 		epb->timestamp_lo = (uint32_t)timestamp;
 
@@ -733,8 +785,6 @@ rte_pcapng_fdopen(int fd,
 {
 	unsigned int i;
 	rte_pcapng_t *self;
-	struct timespec ts;
-	uint64_t cycles;
 	int ret;
 
 	if ((osname && strlen(osname) > PCAPNG_STR_MAX) ||
@@ -754,11 +804,10 @@ rte_pcapng_fdopen(int fd,
 	self->outfd = fd;
 	self->ports = 0;
 
-	/* record start time in ns since 1/1/1970 */
-	cycles = rte_get_tsc_cycles();
-	clock_gettime(CLOCK_REALTIME, &ts);
-	self->tsc_base = (cycles + rte_get_tsc_cycles()) / 2;
-	self->offset_ns = rte_timespec_to_ns(&ts);
+	if (tsc_clock_init(&self->clock) < 0) {
+		rte_errno = ENODEV;
+		goto fail;
+	}
 
 	for (i = 0; i < RTE_MAX_ETHPORTS; i++)
 		self->port_index[i] = UINT32_MAX;
-- 
2.51.0

