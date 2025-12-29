Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AFDE92FF7
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 23:03:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 629AD4065F;
	Tue, 30 Dec 2025 00:02:42 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id 57DBE4067A
 for <dev@dpdk.org>; Tue, 30 Dec 2025 00:02:39 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so11466726a12.2
 for <dev@dpdk.org>; Mon, 29 Dec 2025 15:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767049359;
 x=1767654159; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSjOtCGKn4cyx9UfvmLiyCDSR7JJF1FazPZhjiHdqSU=;
 b=qbGXWBsLPv1Zgx/b0RSBRDiJnyB+AhPgAbWYJd3lDpAslWdY6pjpZQ8pVSzsATk1Zc
 oonSemMrh6c+orKKRvkZj0dpnubCEJ9MOtG1nizsLn2Lhiw6f0o89Ps+iqggGUFgrcK1
 zuTuJn1Mbr8VOFIEOOxRQwmjMKYrYUx5m7qkPwRmd9vm/ap8DDFNwH7NTBIFvMRDMv8O
 8B1mFnx873n2mx8ALs7CMvLO7ZW2Uh2OdmROxheM5ZdNw5OMP8+R2BCPsLuShDGs0lni
 VWvfWOPLrCz8HKcb7l6U7K278emlFm3LlUjAEhFHfGrhVFIn9c4fOW0LH3pgr7CCyiw1
 Z+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767049359; x=1767654159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZSjOtCGKn4cyx9UfvmLiyCDSR7JJF1FazPZhjiHdqSU=;
 b=KNdPs4E3zySBdJD49U+RZbTXz3xjKACaxEK7cayqBGNDD84DFEV4iKxJEu+ZbKhmHb
 +RLOs7EckHnnpuqA0z7RhyaiQ7EZTISudlgZzUm7imMDeFGgzZz9hO2zlvs7JgDm5+4R
 T/V8C0gBWSVHEid606THKW7O60emZ7R7bFU4mhGk5sIsCVjx7n2BT2X9EUNKffskZfn4
 Aph/zrTKzPhSiBufGQsvHdHv0hdyvUP8vYulxeMP3coRWnZEE7w7963kEDmpAQfKb/Jf
 pyOhXRqfNFBjfjOqV8hkm5WzyirLdnkQk2qJvfKDB/AsRaDKPGztbM8XiHlnRXNc4ZO9
 SgRQ==
X-Gm-Message-State: AOJu0YxKmhgVCGBJTj0Mzzj+Wt0aI09msMjBp728U9BqsaivOUq7Aaj2
 kUZLv6SkIPTIFi8OCEXwswnbCk6jG6/6h6DwPLhS/Ui2NHsxb0LO9Tw/vziBx8LCYH4Rm6u8r+F
 4a4nCczU=
X-Gm-Gg: AY/fxX7JU0XOBXFRQ6xELlWiq0yKTmf59WBa2Ip/z+5cnKUpFSDBp+DpFGIf4KViA8E
 y4x9fTnBfpmYOvrYLNk32H3U+yMAk7Wd6fPP+fwc4QctcgJmveTT0vTJCn5MFCBmjpp3JwAVLh5
 xIEWf0Ej+U6DpQNSCCER4g2x0y7SvgLr62hjPDkSErKivoap0BTKMjga9yvAL+acHrqVm6q8716
 4S9l+bwnMyKOUnYcLQdwtUN5cIF1SHqUJUm1FHnHsg5Qpjdg+TdygJR5mIgxiWoJ9w+2WPgAV/S
 D2DBp08a0qmwoKMmAIbvPpxLxfK7BIBk8btoRnRDMqIWaLOq87SC/mZCLa3F25SlM9HYLSnoe/i
 EZUsbl3bmXb5MF3L6sLAuD0eJQ7LELTJiqh9sGXE5UfCWfKHfvov88xEEIqMJNdKIvN5zxcU/wg
 ZmpovelMqHo/nFxqCXETHFATbHgMgfkoyszNLJIyZo+/s7g/5sIw==
X-Google-Smtp-Source: AGHT+IGLGWH3GSlCXDWh8ANTqshorLaUxeVVkK2U5y+bV2F80GCXsmp32BDdN3xlSFxG1CEP5Zr2OA==
X-Received: by 2002:a17:906:fe41:b0:b76:f57f:a2c3 with SMTP id
 a640c23a62f3a-b8036f343ecmr3083734466b.12.1767049358735; 
 Mon, 29 Dec 2025 15:02:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b830b5fe8cfsm1933148166b.59.2025.12.29.15.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 15:02:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 6/6] pcapng: improve performance of timestamping
Date: Mon, 29 Dec 2025 15:01:09 -0800
Message-ID: <20251229230223.151874-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229230223.151874-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20251229230223.151874-1-stephen@networkplumber.org>
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
 lib/pcapng/rte_pcapng.c | 63 ++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 7c3c400c71..b12814e305 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -38,8 +38,14 @@
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
@@ -95,21 +101,38 @@ static ssize_t writev(int fd, const struct iovec *iov, int iovcnt)
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
@@ -309,7 +332,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 
 	opt = pcapng_add_option(opt, PCAPNG_OPT_END, NULL, 0);
 
-	/* clone block_length after optionsa */
+	/* clone block_length after options */
 	memcpy(opt, &hdr->block_length, sizeof(uint32_t));
 
 	/* remember the file index */
@@ -329,7 +352,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 {
 	struct pcapng_statistics *hdr;
 	struct pcapng_option *opt;
-	uint64_t start_time = self->offset_ns;
+	uint64_t start_time = self->tc.ns_base;
 	uint64_t sample_time;
 	uint32_t optlen, len;
 	uint32_t *buf;
@@ -379,7 +402,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	hdr->block_length = len;
 	hdr->interface_id = self->port_index[port_id];
 
-	sample_time = pcapng_timestamp(self, rte_get_tsc_cycles());
+	sample_time = pcapng_timestamp(&self->tc, rte_get_tsc_cycles());
 	hdr->timestamp_hi = sample_time >> 32;
 	hdr->timestamp_lo = (uint32_t)sample_time;
 
@@ -658,7 +681,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 		/* adjust timestamp recorded in packet */
 		cycles = (uint64_t)epb->timestamp_hi << 32;
 		cycles += epb->timestamp_lo;
-		timestamp = pcapng_timestamp(self, cycles);
+		timestamp = pcapng_timestamp(&self->tc, cycles);
 		epb->timestamp_hi = timestamp >> 32;
 		epb->timestamp_lo = (uint32_t)timestamp;
 
@@ -704,8 +727,6 @@ rte_pcapng_fdopen(int fd,
 {
 	unsigned int i;
 	rte_pcapng_t *self;
-	struct timespec ts;
-	uint64_t cycles;
 
 	self = malloc(sizeof(*self));
 	if (!self) {
@@ -716,11 +737,7 @@ rte_pcapng_fdopen(int fd,
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

