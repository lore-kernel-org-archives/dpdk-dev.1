Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6CFD1951A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 21:06:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB90A40A6D;
	Mon, 26 Jan 2026 22:06:32 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 1CE5D406BB
 for <dev@dpdk.org>; Mon, 26 Jan 2026 22:06:30 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4801d98cf39so36561075e9.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 13:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769461590;
 x=1770066390; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0W+iuY5pkcGPzbQ1tBm6Y58aYsiLmWuGFrBqDowXXd8=;
 b=bQ0yyeIFtzI9SHHFCSaWQop+I4r26BGOGCJHGimEw5FvM8aAirmW/jAxWqvGCUq9Si
 WoqH9DdXz3BSgar+2eXziA+Ahn5wwAvVDRAEdA0XlMFEcEzuNplplxdTT+++yq971MMz
 HBoK1rJxp6knyNc2G1ObQBjTBtfIOmPBUQh9c4xP3XFjHh78poMwZV6qpvbNH7U3K7g+
 kyjXEYImHzZ4ootZU9GlqxaNmzcd2hjMByNgRZQEmvSmOY9Hxfvq/QwjZHevvJFnWpFH
 WGhUkfIxs8hMg7Lz2rOvl6nWkbSKAAK0v6kOaQtKMNlWSDlUHYgC1i1mOUEz2fNLyTdl
 ReAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461590; x=1770066390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0W+iuY5pkcGPzbQ1tBm6Y58aYsiLmWuGFrBqDowXXd8=;
 b=ooC629YBFKmzfMViY5nA1PLhJJDp4CTJQi0tn9hTM2xPzGkuXZh5w6P4fiy1V0LjFU
 xCBK/6leX4xPc4F4hSDVj06LUWVnVi6BC5vzsF3+v6LsURoE4Gqwo0btuChz35WvYmFE
 KlFSukpZ4oxkuedYEfmFoH9bWjwiDr/EcAWFVRMtLw0ruJZJMGKepIZmRRPT4asPjf85
 LRX8YEZ4dv6FnZ+BevOyqMSv02oO/po2C3K164aToTlnrXsPwCtk+AWFBzybM/JaNpbD
 LTZfBp1Lvp+TZu1CFASwI7Eo7fD3V/fCryY09DEspq1O63jhyM/LWNvl/ratljjwz5Ya
 R8Cg==
X-Gm-Message-State: AOJu0YwTsRtMGZEu5Ge7bmDoA7J8zXF8YF60m5W/w6d62wwZPOZsoIGj
 JsphFU/X0He1WK9Q11euQV2E84WN8lu79XKR+iKHPBBNPC3cdsCOKegcJAHy9DPvZFv2gI49FTv
 OQ/8l
X-Gm-Gg: AZuq6aL720B2T6gXInsCfKtoVRxzY797cFTW9NbooDE3sry/uVEV8GXwjZgolFncXU2
 hHI8ST+V1bR0wMvpVOb2xXKGrLtmCyN5Tu80rDHzTrc8GF/98jH8YLHiGTViiGyNtn1FJlmP4Fe
 mx2piSv/bxAkYf/itOOFqjtca1BuFX4kZWVgTXeV433RmDno15HVZ06pqZDd8f8IWC0ckkf7pma
 T9/3k3vlSRD+xtf7um308fn+F+36oIswvUB/W+Af0hagHNw5+lpBZieH4VbJ/2vZcH+a+/qMkw5
 WvWZlY6RsM5utsIFczBLcEt9PqVntpbSHrb/vKwU9Eo/brfMoCLWR+pP/iRKNkyetITvNxG4moX
 vpDYsHvoSFfOhK36+ZBvSaKvFDxVqX70B4PlCO7NkHUdkGf4W5TpFVDsQqLC5lVqUETZ71heNYs
 gKBoB1xWfNqZgTID7Lo46e3ebIgqzUn5e50LLTLXKNnxTZ3+h0kjCmQruZTUU4
X-Received: by 2002:a05:600c:64cf:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-4805cf5f4aemr94569065e9.17.1769461589629; 
 Mon, 26 Jan 2026 13:06:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7704sm15166915e9.1.2026.01.26.13.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:06:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v6 4/5] pcapng: improve performance of timestamping
Date: Mon, 26 Jan 2026 13:04:37 -0800
Message-ID: <20260126210615.175816-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126210615.175816-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260126210615.175816-1-stephen@networkplumber.org>
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

Avoid doing expensive divide operations when converting
timestamps from cycles (TSC) to pcapng scaled value (ns).
This logic was derived from the math used by Linux kernel
virtual system call with help from AI.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 61 ++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b9de51849b..27ae5e1fd6 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -41,8 +41,14 @@
 struct rte_pcapng {
 	int  outfd;		/* output file */
 	unsigned int ports;	/* number of interfaces added */
-	uint64_t offset_ns;	/* ns since 1/1/1970 when initialized */
-	uint64_t tsc_base;	/* TSC when started */
+
+	struct pcapng_time_conv {
+		uint64_t tsc_base;	/* TSC when started */
+		uint64_t ns_base;	/* ns since 1/1/1970 when initialized */
+		uint64_t mult;		/* scaling factor relative to TSC hz */
+		uint32_t shift;		/* shift for scaling (24) */
+		uint64_t mask;		/* mask of bits used (56) */
+	} tc;
 
 	/* DPDK port id to interface index in file */
 	uint32_t port_index[RTE_MAX_ETHPORTS];
@@ -98,21 +104,38 @@ static ssize_t writev(int fd, const struct iovec *iov, int iovcnt)
 #define if_indextoname(ifindex, ifname) NULL
 #endif
 
+/* Initialize time conversion based on logic similar to rte_cyclecounter */
+static void
+pcapng_timestamp_init(struct pcapng_time_conv *tc)
+{
+	struct timespec ts;
+	uint64_t cycles = rte_get_tsc_cycles();
+
+	/* record start time in ns since 1/1/1970 */
+	clock_gettime(CLOCK_REALTIME, &ts);
+
+	/* Compute baseline TSC which occurred during clock_gettime */
+	tc->tsc_base = (cycles + rte_get_tsc_cycles()) / 2;
+	tc->ns_base = (uint64_t)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+
+	/* Set conversion factors for reasonable precision with no overflow */
+	uint64_t tsc_hz = rte_get_tsc_hz();
+	tc->shift = 24;
+	tc->mult = ((uint64_t)1000000000ULL << tc->shift) / tsc_hz;
+	tc->mask = RTE_BIT64(56) - 1;
+}
+
 /* Convert from TSC (CPU cycles) to nanoseconds */
 static uint64_t
-pcapng_timestamp(const rte_pcapng_t *self, uint64_t cycles)
+pcapng_timestamp(const struct pcapng_time_conv *tc, uint64_t cycles)
 {
-	uint64_t delta, rem, secs, ns;
-	const uint64_t hz = rte_get_tsc_hz();
-
-	delta = cycles - self->tsc_base;
+	/* Compute TSC delta with mask to avoid wraparound */
+	uint64_t delta = (cycles - tc->tsc_base) & tc->mask;
 
-	/* Avoid numeric wraparound by computing seconds first */
-	secs = delta / hz;
-	rem = delta % hz;
-	ns = (rem * NS_PER_S) / hz;
+	/* Convert TSC delta to nanoseconds (no division) */
+	uint64_t ns_delta = (delta * tc->mult) >> tc->shift;
 
-	return secs * NS_PER_S + ns + self->offset_ns;
+	return tc->ns_base + ns_delta;
 }
 
 /* length of option including padding */
@@ -346,7 +369,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 {
 	struct pcapng_statistics *hdr;
 	struct pcapng_option *opt;
-	uint64_t start_time = self->offset_ns;
+	uint64_t start_time = self->tc.ns_base;
 	uint64_t sample_time;
 	uint32_t optlen, len;
 	uint32_t *buf;
@@ -399,7 +422,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	hdr->block_length = len;
 	hdr->interface_id = self->port_index[port_id];
 
-	sample_time = pcapng_timestamp(self, rte_get_tsc_cycles());
+	sample_time = pcapng_timestamp(&self->tc, rte_get_tsc_cycles());
 	hdr->timestamp_hi = sample_time >> 32;
 	hdr->timestamp_lo = (uint32_t)sample_time;
 
@@ -690,7 +713,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 		/* adjust timestamp recorded in packet */
 		cycles = (uint64_t)epb->timestamp_hi << 32;
 		cycles += epb->timestamp_lo;
-		timestamp = pcapng_timestamp(self, cycles);
+		timestamp = pcapng_timestamp(&self->tc, cycles);
 		epb->timestamp_hi = timestamp >> 32;
 		epb->timestamp_lo = (uint32_t)timestamp;
 
@@ -736,8 +759,6 @@ rte_pcapng_fdopen(int fd,
 {
 	unsigned int i;
 	rte_pcapng_t *self;
-	struct timespec ts;
-	uint64_t cycles;
 
 	if ((osname && strlen(osname) > PCAPNG_STR_MAX) ||
 	    (hardware && strlen(hardware) > PCAPNG_STR_MAX) ||
@@ -756,11 +777,7 @@ rte_pcapng_fdopen(int fd,
 	self->outfd = fd;
 	self->ports = 0;
 
-	/* record start time in ns since 1/1/1970 */
-	cycles = rte_get_tsc_cycles();
-	clock_gettime(CLOCK_REALTIME, &ts);
-	self->tsc_base = (cycles + rte_get_tsc_cycles()) / 2;
-	self->offset_ns = rte_timespec_to_ns(&ts);
+	pcapng_timestamp_init(&self->tc);
 
 	for (i = 0; i < RTE_MAX_ETHPORTS; i++)
 		self->port_index[i] = UINT32_MAX;
-- 
2.51.0

