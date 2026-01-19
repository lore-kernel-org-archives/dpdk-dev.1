Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE33D29C58
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 18:20:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59DE040616;
	Mon, 19 Jan 2026 19:20:33 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id BF12640616
 for <dev@dpdk.org>; Mon, 19 Jan 2026 19:20:31 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-652fdd043f9so8526243a12.1
 for <dev@dpdk.org>; Mon, 19 Jan 2026 10:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768846831;
 x=1769451631; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F53S7UpatJIjvo3gYozbgI1UTneHEc62h6KhI6UN3i0=;
 b=i3Vu8rRJLGQrwe58F0YRBIRzYc9NaOtq7+XwskqQkBkXSGeAiQxnoA4kP1GUHqC9++
 z674hbK7SRXF+Shfm74c6LwiIggh/gdZoH4ERyNunwTyUeoSliX77NybXgo0GmZEeKPz
 43JPegbQxzfycEp4n8GfTXJUCaU1y4HjYlP2473no/mXUFj0aqQwEtVfLNFEa0jk/0nm
 6SD1qjLnujuFw7YA697NOzE26cT0i7Bwy6QuL78CAxsudrm0/JZr/K9H/0tsoAH0xX27
 4ycv9b55sFecT6B0o6cRQxMI9YWtzfo12HdCie+YAHhvuT01EXD5syELQo3EhyuivpFJ
 DThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768846831; x=1769451631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F53S7UpatJIjvo3gYozbgI1UTneHEc62h6KhI6UN3i0=;
 b=WBJ+cOohRROkdKwoBCZaxnjQOyAqWDZ35tr6C7cHdLFavT8Of0eCDoKsCqUAY95XR4
 0YZqsXDMrBJ9+qOrFQkhixUvoe2ElmR/xh6YH3oMSYjOOyu31klbTtbwfpNRLhnwuYEh
 /qWI1AWLZRuLnDdOI8WXVoYpl98vaTaaQ8Jt7gAZSpAqhZ8yNP1fbXGFD8XS1BQA0bQQ
 MIgkFrtBnLnuRcAhXXg2nbNDBXQkXIsn+AHYNw6y341kkQnI9Z89avaXMhn1QCGDR0xi
 A40IY2M0ksgvyIufSiSGVBVF4tOLhZvDNxA1/fQB/8xYKzDmj0BMOnwtyQ88omu3DV1G
 Y1PA==
X-Gm-Message-State: AOJu0Yxuc/Hz2hFy8xgEyCaysk7XSiNc6/NJT6b8Wl23h19/1kUGsps/
 k8zwRryJkby6vn+uXSn4AkhHyVTr8I9kXjTApbvN4wENJhddilpx/TZ9JqTgggEM3SLLHg1zY7B
 eW7O1
X-Gm-Gg: AZuq6aKaenwZAatmaqw9IxCzM8ZCWZYhPp7eeFf/qdTk2WjGp+L7dg5PIDoybupfqOM
 U13yFJm8ff+l+1kgBfrgM58qS26Pg61piYwQ5PlKyqfztuJaNsLVhr1r/GQE/ZlKEbtclnBBKR4
 3XUzPonH/xDwGjxyDlox3UgyeK9Oarl1oelw5/7Vs+o/SjDty1wBMyt3fs3kGcD6Jcrd/aQK1Ye
 tATZgabwppIWkamD3fFdd3JX/qLShwCvgAXXnrPId8FHSIP+2FiXR3S5q9PjgkQ31AL5kgHc82G
 A4cycr8Dml5K5clQwU1PWa+l692OMsanPSEkOQpmwMw0KoVRSiC5CWvl3rdSQoNGJTGand13bVZ
 Jsh5MzrtDqayYhT3DQnLW3FOJj3u85Q+jtb0enFbfL6hLWMGnvXc/GuPRxLn5d1sBOT240/gzse
 jT/eASdNRjBpjDRm9waOzet25eZsxl6KVvO6LdqS7TekRM3phhNoHYdxIKoIYM
X-Received: by 2002:a05:6402:1ec9:b0:64d:1ce9:54b7 with SMTP id
 4fb4d7f45d1cf-65452ad1124mr9859516a12.18.1768846831197; 
 Mon, 19 Jan 2026 10:20:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdab55sm10878829a12.10.2026.01.19.10.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 10:20:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 4/5] pcapng: improve performance of timestamping
Date: Mon, 19 Jan 2026 10:19:02 -0800
Message-ID: <20260119182016.44769-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119182016.44769-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260119182016.44769-1-stephen@networkplumber.org>
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
 lib/pcapng/rte_pcapng.c | 61 ++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 7deef7639f..8572fe9e7b 100644
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
@@ -400,7 +423,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	hdr->block_length = len;
 	hdr->interface_id = self->port_index[port_id];
 
-	sample_time = pcapng_timestamp(self, rte_get_tsc_cycles());
+	sample_time = pcapng_timestamp(&self->tc, rte_get_tsc_cycles());
 	hdr->timestamp_hi = sample_time >> 32;
 	hdr->timestamp_lo = (uint32_t)sample_time;
 
@@ -684,7 +707,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 		/* adjust timestamp recorded in packet */
 		cycles = (uint64_t)epb->timestamp_hi << 32;
 		cycles += epb->timestamp_lo;
-		timestamp = pcapng_timestamp(self, cycles);
+		timestamp = pcapng_timestamp(&self->tc, cycles);
 		epb->timestamp_hi = timestamp >> 32;
 		epb->timestamp_lo = (uint32_t)timestamp;
 
@@ -730,8 +753,6 @@ rte_pcapng_fdopen(int fd,
 {
 	unsigned int i;
 	rte_pcapng_t *self;
-	struct timespec ts;
-	uint64_t cycles;
 
 	if ((osname && strlen(osname) > PCAPNG_STR_MAX) ||
 	    (hardware && strlen(hardware) > PCAPNG_STR_MAX) ||
@@ -750,11 +771,7 @@ rte_pcapng_fdopen(int fd,
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

