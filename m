Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD19ED25030
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 04:54:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 121B940B90;
	Mon, 12 Jan 2026 05:54:21 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 04FF34013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 05:54:19 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b8715a4d9fdso68822866b.0
 for <dev@dpdk.org>; Sun, 11 Jan 2026 20:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768193658;
 x=1768798458; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxcyJrSTRdwyWN7QPA0PhNKYUveXZNVgAWgPsc/PO98=;
 b=EygZLeicXukthWBXUQWa0r2BqgpqbHpNv2zAqJBuh7dmdpQETVnRt290MtmcKoNTmN
 LzoV6eSkJf+xsOWWxWt45bK/bCFooudn4wRRdnh36XHWDYfJZEe+eNEOSlj3F6Ei0usP
 v5jv5kDF0oHezuXpQq9JqROleEB9C41NZSmx1YUeJj8SxqPeGvpBpnQLkkt1k9D/jyBA
 qTTnAF3rYnY/BF9GN2S3g5l5vTufYu1JuXMegkd5LYMg6BYuPGpGmVw14B21sAlJ9MZA
 vx4xzvKHHVY/Dbk1NONWAyjR7VhUpey8rElaHp/4ebbp0szJs1p1MTVagT71Ihj8WaJ/
 ksoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768193658; x=1768798458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gxcyJrSTRdwyWN7QPA0PhNKYUveXZNVgAWgPsc/PO98=;
 b=Nt0uMtvyi0MExrRBXBQqNCnQIEjWybTNSzYdauJvadbGmb0aL3d3Gn1MRCo3QPzGI7
 cL+0pFAKEscGgxQ1xbAh47SZSJWVoUbVkRh8XUSoL63ao5h6vmcJ5OLIAr4a8fQqRIKK
 llKYg24azBEb+pUyeucj6Vl8DNch/SQwakowPLNRoe8DAyxTJNCCzNqpdTm+OYjYoAgS
 nfZWV0v6dY84F+B2SNJgs8hmNttWx4Y6m6xZdynkLEv79Qr0JwTnr+DGHg42FpIQ7wd2
 /tPi9OMJCDP4hEC77HlmxJDQS6KkKRQWzA6s/9yNazxJc1lh/wjEi3I8TN4Ydcj6aUN1
 +YgQ==
X-Gm-Message-State: AOJu0Yyi/oTFEQmT4snuBbqImwN7wwf5/O3kiBh/3DOW1alZ1JKnmk1F
 BT3PLngEmQm4OF6L5fpp5ajJseW0cB5kGDFRz8qIUc7OjX+XPOI3KtDU2MstqbGIAQXTJRrr1hC
 UnRjq
X-Gm-Gg: AY/fxX4gq8mD4qk4YWCeLwgO5t1oq+03F7Kcu6hC4CLT3dETnerlNYPzatpjqWEW4/G
 KIh3CcDE1/7dzbbDyy/jgUIWbiK1dVMKmnXJaq14UUk1DH1L4ARZVPX3gMm08ZkSf3b38Idj0yt
 8RFF5vLAdHFkvKkiLL2VbN92nUCVZkNpLMEFDvstuQqoO/OMUYIZYe3SO07UvJT8qHpxKEptVB7
 LyDT28EI6HMNG0n0o1FRgQ7y0ysJDXOLRyK3m42NDnUtlknXLFaJdNCn7CPAD36xLz1oj5Hu89C
 Zn+lxwEU4KD5BBHpCB0qDdCYAamZNJYovfadIUd4wGRItchviOV0INQkvQSTMQpG2kHD8xdp8CD
 UPv+hizPfIO153JMTZxmeHzrXz219O4TleJL9r4ZgkC+v8FWBR5zT/X5TWdKuzge0Z+M7yt2mZA
 7nvNPkeJoXAMc35Rm9RR3nUeKY1ZfniZkmWbzlDcsprxfJR54mmA==
X-Google-Smtp-Source: AGHT+IHhpjKR3E3QPf1GJHrUc1VDw0sKBYtCARV+Iekk4ktugN40QbyB/psATbT+MMoirOB5JICBng==
X-Received: by 2002:a17:906:6a27:b0:b87:15a7:85e7 with SMTP id
 a640c23a62f3a-b8715a78db5mr251047966b.27.1768193658559; 
 Sun, 11 Jan 2026 20:54:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm534327166b.30.2026.01.11.20.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 20:54:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 7/7] pcapng: improve performance of timestamping
Date: Sun, 11 Jan 2026 20:50:20 -0800
Message-ID: <20260112045359.142999-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112045359.142999-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260112045359.142999-1-stephen@networkplumber.org>
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

