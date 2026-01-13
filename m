Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49781CF45D4
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 00:52:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5007940689;
	Tue, 13 Jan 2026 01:52:16 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 6D6E540684
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:52:15 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so66014865e9.3
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768265535;
 x=1768870335; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxcyJrSTRdwyWN7QPA0PhNKYUveXZNVgAWgPsc/PO98=;
 b=GayEcW3z98+w6hUMtm5NUFQKGfDDqQcEMwGAoGp6Eu/mPRf5nmi8vjUepM9qywGcUM
 gBjqDhlE4bw3vEwRtjNGorEobhAT7u1ZQuJ3elcPMW+5d33hLA9wEnKyiZCCCcvdioPf
 ZqAF/TXtj1U/vEaR82xRJ6kcIqkESTHnIJNShmdN8RCWi94va+tyAeKdz0sj9uNKO2MR
 zgusihrae3HpP7OZ7lITwM3TBX3nGcpIVd8fvO3scYCPEAqMyNy/r/I/BjIeEoXsG8of
 B3ZIMnfWvNVysQa4k0Hg5tAAItorbwgK+2b1E8hwIpfnGYqRsORMBP49RcQ9HyCQLZ7N
 whlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768265535; x=1768870335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gxcyJrSTRdwyWN7QPA0PhNKYUveXZNVgAWgPsc/PO98=;
 b=mXowwuR3/cVKXN6idy/DcfjDB6WttqQrp9t169juR2kinN7Dg9lZyIjBoKTETjDOEE
 oM175w3IOPjzMFV7Wk0mpyER636Vt2Y3J0+3abvnpuGcK9dgxrtpZD9iWubY5MrTjPjt
 njFAilz0U7HCklj8IUW/Sr2x/V0c5kcFJGH2Y1tdeRZPF8HxRYAK5g3UtECMNTAc6oJP
 6YlZzOmCcIAt4Prv7+F6tRgEnmD6VOPpYxQnLDe/FTuWKMg8Gfe2rVn+n8cFJqsTnWWX
 ZW/V/ZwBy2yNRvAurUJLOQ2GxyAF+am3SIDqJdXmbMAwzLmTXT/8eiwyUeamjA7vKall
 sK6A==
X-Gm-Message-State: AOJu0Yy2ryOkYjUmcWa1tXWbYXhVKOh78NmNfBZo6EhduKA5iLgvLPSM
 xyG1l1YR6e/e6AiZxolAMUETsNO/reQsUadk0jp0xxwTvWsAelpGo/mU5c3RewqG4x5JlrG5SwF
 68E0S
X-Gm-Gg: AY/fxX4AQwewLgijQ4oh/e8D1mnXHRWA2AdG32AeVtYpdKbAgTurysfghuimKOtmNAv
 4n9NTKQ+xfd7oHEVkNXLAB4QlzKaKpfFfD66f/z0P5f/fjBBUxWPWEei6dvVq6ttUgm6ko6whdF
 J8mHIl7hX0LvPrzc6Tt31By7mKcKy2CGwumUVmKpakDNY76PV58U+eGVr1vl3AzdUw+sILhzU9v
 TkvTSijgIQj76CDlexKxGzr7jU40lBq80aPDy2tVNxs6XPX3GZD1od7c09J/Kt6fqADoA1mlWTi
 U0cV5eGPBUK/wtoRKeyYF19Y4gRTRil5pblRHUzpofksckoKviMg9MUNAe373kGiO09w96kNnCJ
 2FTxOPNwlypPdbzOLqXuTokicyzOpcP3tH2/7dGjRqcwJ88+UYNs3D+cSEPj5iQxHxeUdsgjHMh
 eSNKXJI+D5PYgKP/h3HW507bNuoKUEf97sZrt4iCS1WMgZCkhnJA==
X-Google-Smtp-Source: AGHT+IFTPoHmMKygQLifXWWt/aPUZZqDOpZNeYG3Mj3qF8PuQEwKSC9yDeXjoyXWX/c59lZrwHjhOg==
X-Received: by 2002:a05:600c:4694:b0:479:3a88:de5f with SMTP id
 5b1f17b1804b1-47d84b3fa0fmr207048145e9.36.1768265534980; 
 Mon, 12 Jan 2026 16:52:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm41603051f8f.8.2026.01.12.16.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 16:52:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 7/7] pcapng: improve performance of timestamping
Date: Mon, 12 Jan 2026 16:51:30 -0800
Message-ID: <20260113005154.44551-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113005154.44551-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260113005154.44551-1-stephen@networkplumber.org>
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

Also fix a typo.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 63 ++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index f53e6dfecd..b5333aca7a 100644
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
@@ -326,7 +349,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 
 	opt = pcapng_add_option(opt, PCAPNG_OPT_END, NULL, 0);
 
-	/* clone block_length after optionsa */
+	/* clone block_length after options */
 	memcpy(opt, &hdr->block_length, sizeof(uint32_t));
 
 	/* remember the file index */
@@ -348,7 +371,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 {
 	struct pcapng_statistics *hdr;
 	struct pcapng_option *opt;
-	uint64_t start_time = self->offset_ns;
+	uint64_t start_time = self->tc.ns_base;
 	uint64_t sample_time;
 	uint32_t optlen, len;
 	uint32_t *buf;
@@ -402,7 +425,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	hdr->block_length = len;
 	hdr->interface_id = self->port_index[port_id];
 
-	sample_time = pcapng_timestamp(self, rte_get_tsc_cycles());
+	sample_time = pcapng_timestamp(&self->tc, rte_get_tsc_cycles());
 	hdr->timestamp_hi = sample_time >> 32;
 	hdr->timestamp_lo = (uint32_t)sample_time;
 
@@ -686,7 +709,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 		/* adjust timestamp recorded in packet */
 		cycles = (uint64_t)epb->timestamp_hi << 32;
 		cycles += epb->timestamp_lo;
-		timestamp = pcapng_timestamp(self, cycles);
+		timestamp = pcapng_timestamp(&self->tc, cycles);
 		epb->timestamp_hi = timestamp >> 32;
 		epb->timestamp_lo = (uint32_t)timestamp;
 
@@ -732,8 +755,6 @@ rte_pcapng_fdopen(int fd,
 {
 	unsigned int i;
 	rte_pcapng_t *self;
-	struct timespec ts;
-	uint64_t cycles;
 
 	if ((osname && strlen(osname) > PCAPNG_STR_MAX) ||
 	    (hardware && strlen(hardware) > PCAPNG_STR_MAX) ||
@@ -752,11 +773,7 @@ rte_pcapng_fdopen(int fd,
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

