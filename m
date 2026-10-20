Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1281606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=bh8QNLD2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB23540689;
	Tue, 20 Oct 2026 19:57:41 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 410A640151
 for <dev@dpdk.org>; Tue, 20 Oct 2026 19:57:37 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ea1e7fad99so6107675ad.1
 for <dev@dpdk.org>; Tue, 20 Oct 2026 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792519056;
 x=1793123856; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uVBDL/+6hx3oX9Cae2SkkJvgG1d7++PR38SBIyJyEAU=;
 b=bh8QNLD2l+kfe46Xgs4fGISwygycGpg2y4hIk0dWt8/z0op9OS3cva72dgP1Cs1zQb
 udfSUHMc9WRKHNTUMtm1tVaBY1mohD0mIBes+Q3BCEcPo3vrXD/0KaDw8iuoOXrul+tC
 vBJHHBa3Xz5NJte8dCBGZLZ7akImHdAHrynSugoKHmSH7TUgOjlKmUctZf/SnVGsC6Gi
 GPoZ5UduSBbMR6AlSlDio3IJAkOjD4GThYaWFo5vBU0CtoDThHHbLf7UcnWuu2m7zGWY
 hiJKboHymG7oWZyFdhxCMAm0XYPUzLvJcZdVxIrT5ww7iNumcvg2U/LJDnlKC0rk9stX
 4HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519056; x=1793123856;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uVBDL/+6hx3oX9Cae2SkkJvgG1d7++PR38SBIyJyEAU=;
 b=f96v5H8AbGgJufIJ0PeNSAce6TDoiJTpsqsv+KWB7ynROJ7ZgCpU5tXsAywfG1QcSE
 Clp2oQtzS9w5FXDcz0Vhzpltj7hX58PtGK1QoC816TC/6tsF6ENWt/sZM6a4tgevvgYg
 ko8D8hj8RznNqC6V0IhBmaGscX+7dT9iK5nSDHZMhEmhtAkt/C8JEfbBb4ulY2eyDkF/
 /BKwCkx4odIwYyX7g3AQD49zGTJXRPtRhtYd2+dy6OPvphI07fbNskyfEGv4lSOgq+Zi
 VuQg7A0pB6KJ7WZhbZg/YEfhzTYYN/23d0U01WXeC7duTb/9MkUvlS+WAExhn5QHIEYT
 vIEw==
X-Gm-Message-State: AFq9FYLh3XaH1fKCaYwk6P3ZX4ExkFAZnRDcURAxMDV+CULZBpOO0vF6
 taix7+IEplpi9WpA3hoDRYbIFf83OgNe4f2CJ1DqYWkUO6nY/XzYd4Mlh3AvW9zPn62oVDWKcPV
 GlegRRqk=
X-Gm-Gg: AYBFou3liLG1BwhkWwBhZmBzo605hfcj7PC72mKPEa/pjaEZuGih1kthMyqvsD6SRJJ
 VG29reUG3jseIg17twkUu5jDWWyFQViZJWVBjzm9aX+8L3zFtfTPbgxLmkS5q/uC6u4ufsUK9Kl
 umww/0UIB3gt9fo+ejT+TIQB5SBzzpXI3s+GvAIwRUNkdXEpveoUSpRNgZuynWX4IsFScnvicyG
 kw/piI01FRH0yFIZ9CpIbdLBtRqbiXHEggebEk4TSpLid5ef9vuYiuqwFGtVko3RoxlMJuoFd48
 pAbXvoz5Kn6JsJH4db91+iycb0o2rVJF6qhfQrXJazln5SR/VDy+gGJ3/mqbPeaKnL3Gu4Xq8ti
 k/9PcnZ57GFvHMzxD8mt312Kw2d3i41arX+5duqUWS0+t36Gin4gO/Mltir3vwFin2gpl/Qxitg
 7rWrffdz7bEzD3Igdou7H+EgCgOMH6G+Dxz3CeOVJYNAGA66BiDekN7IA9Uf4hAcsjH21BtLa/7
 N8qGyKAncEujVwp+560EjIXDMdqhjKJ82lFTy99/CZ6UxaS
X-Received: by 2002:a17:903:41cf:b0:2d9:520c:38e7 with SMTP id
 d9443c01a7336-2e9a68346e4mr98084735ad.1.1792519056324; 
 Tue, 20 Oct 2026 10:57:36 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b43236esm1997875ad.29.2026.10.20.10.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 10:57:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 2/3] pcapng: use EAL TSC to epoch conversion
Date: Tue, 20 Oct 2026 10:55:43 -0700
Message-ID: <20261020175732.1552406-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020175732.1552406-1-stephen@networkplumber.org>
References: <20261020152907.2607513-1-dawid.wesierski@intel.com>
 <20261020175732.1552406-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pcapng library carried its own TSC to nanoseconds conversion along
with the reference point it needs: the TSC and wall clock sampled when
the capture file was opened. EAL now records an equivalent reference
point at init and exposes rte_tsc_to_ns(), so the local copy is
redundant.

Convert timestamps with rte_tsc_to_ns() and drop the per-handle
reference point. The interface statistics block still reports when the
file was opened rather than when EAL started, so that time is kept in
the handle, now derived from the TSC like every other timestamp.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c  |  8 +++----
 lib/pcapng/rte_pcapng.c | 52 +++++------------------------------------
 2 files changed, 10 insertions(+), 50 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 688b58794e..060c479ba2 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -648,8 +648,8 @@ test_write_before_open(void)
 	mbuf1_prepare(&mbfs);
 	mbuf1_resize(&mbfs, rte_rand_max(MAX_DATA_SIZE));
 
-	/* Copy packets BEFORE opening the pcapng file.
-	 * This exercises the negative TSC delta path.
+	/* Copy packets BEFORE opening the pcapng file, so their
+	 * timestamps precede the capture start time.
 	 */
 	for (i = 0; i < (int)count; i++) {
 		clones[i] = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp,
@@ -662,7 +662,7 @@ test_write_before_open(void)
 		}
 	}
 
-	/* Small delay so fdopen's tsc_base is measurably after the copies */
+	/* Small delay so the capture start is measurably after the copies */
 	rte_delay_us_block(100);
 
 	now = current_timestamp();
@@ -689,7 +689,7 @@ test_write_before_open(void)
 		goto fail;
 	}
 
-	/* Write the pre-captured packets — timestamps precede tsc_base */
+	/* Write the pre-captured packets */
 	len = rte_pcapng_write_packets(pcapng, clones, count);
 	rte_pktmbuf_free_bulk(clones, count);
 	if (len <= 0) {
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index df38e4819c..f910896a61 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -40,8 +40,7 @@
 struct rte_pcapng {
 	int  outfd;		/* output file */
 	unsigned int ports;	/* number of interfaces added */
-	uint64_t offset_ns;	/* ns since 1/1/1970 when initialized */
-	uint64_t tsc_base;	/* TSC when started */
+	uint64_t start_time;	/* ns since 1/1/1970 when opened */
 
 	/* DPDK port id to interface index in file */
 	uint32_t port_index[RTE_MAX_ETHPORTS];
@@ -97,39 +96,6 @@ static ssize_t writev(int fd, const struct iovec *iov, int iovcnt)
 #define if_indextoname(ifindex, ifname) NULL
 #endif
 
-/*
- * Convert a count of cycles to nanoseconds.
- *
- * Compute the whole seconds first, so that the remainder is always
- * less than the frequency and scaling it by NS_PER_S cannot wrap.
- */
-static uint64_t
-pcapng_cycles_to_ns(uint64_t delta)
-{
-	const uint64_t hz = rte_get_tsc_hz();
-	uint64_t secs = delta / hz;
-	uint64_t rem = delta % hz;
-
-	return secs * NS_PER_S + (rem * NS_PER_S) / hz;
-}
-
-/* Convert from TSC (CPU cycles) to nanoseconds */
-static uint64_t
-pcapng_timestamp(const rte_pcapng_t *self, uint64_t cycles)
-{
-	/*
-	 * A packet may be copied before the file was opened, so the TSC
-	 * can be behind the reference point.  Handle both directions on
-	 * an unsigned magnitude.
-	 */
-	if (unlikely(cycles < self->tsc_base))
-		return self->offset_ns -
-			pcapng_cycles_to_ns(self->tsc_base - cycles);
-
-	return self->offset_ns +
-		pcapng_cycles_to_ns(cycles - self->tsc_base);
-}
-
 /* length of option including padding */
 static uint16_t pcapng_optlen(uint16_t len)
 {
@@ -361,7 +327,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 {
 	struct pcapng_statistics *hdr;
 	struct pcapng_option *opt;
-	uint64_t start_time = self->offset_ns;
+	uint64_t start_time = self->start_time;
 	uint64_t sample_time;
 	uint32_t optlen, len;
 	uint32_t *buf;
@@ -414,7 +380,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	hdr->block_length = len;
 	hdr->interface_id = self->port_index[port_id];
 
-	sample_time = pcapng_timestamp(self, rte_get_tsc_cycles());
+	sample_time = rte_tsc_to_ns(rte_get_tsc_cycles());
 	hdr->timestamp_hi = sample_time >> 32;
 	hdr->timestamp_lo = (uint32_t)sample_time;
 
@@ -702,7 +668,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 		/* adjust timestamp recorded in packet */
 		cycles = (uint64_t)epb->timestamp_hi << 32;
 		cycles += epb->timestamp_lo;
-		timestamp = pcapng_timestamp(self, cycles);
+		timestamp = rte_tsc_to_ns(cycles);
 		epb->timestamp_hi = timestamp >> 32;
 		epb->timestamp_lo = (uint32_t)timestamp;
 
@@ -748,8 +714,6 @@ rte_pcapng_fdopen(int fd,
 {
 	unsigned int i;
 	rte_pcapng_t *self;
-	struct timespec ts;
-	uint64_t cycles;
 	int ret;
 
 	if ((osname && strlen(osname) > PCAPNG_STR_MAX) ||
@@ -769,17 +733,13 @@ rte_pcapng_fdopen(int fd,
 	self->outfd = fd;
 	self->ports = 0;
 
-	/* If Hz is zero, something is seriously broken. */
+	/* Timestamps come from the TSC; if Hz is zero it is unusable. */
 	if (rte_get_tsc_hz() == 0) {
 		rte_errno = ENODEV;
 		goto fail;
 	}
 
-	/* record start time in ns since 1/1/1970 */
-	cycles = rte_get_tsc_cycles();
-	clock_gettime(CLOCK_REALTIME, &ts);
-	self->tsc_base = (cycles + rte_get_tsc_cycles()) / 2;
-	self->offset_ns = rte_timespec_to_ns(&ts);
+	self->start_time = rte_tsc_to_ns(rte_get_tsc_cycles());
 
 	for (i = 0; i < RTE_MAX_ETHPORTS; i++)
 		self->port_index[i] = UINT32_MAX;
-- 
2.53.0

