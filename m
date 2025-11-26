Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114AAD1037D
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 05:12:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51BC940B9C;
	Wed, 26 Nov 2025 06:12:29 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id D85A44026F
 for <dev@dpdk.org>; Wed, 26 Nov 2025 06:12:24 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8a479c772cfso391447985a.0
 for <dev@dpdk.org>; Tue, 25 Nov 2025 21:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764133944;
 x=1764738744; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4HQ1R6EvJpYnD9hN0xQVX8FgbeaOknQjkBJBW/31LAE=;
 b=dkgWT03BcAVNLrzqWGTugAnolfKr/v8l9ThN6cSbQKRsCjkz1BZD9+E8S3ngxyFu50
 hdtMeN5slFqQJm5BROFh4baMB6tWnTRzSVvhB9Fcp59EtG6qcKFFVp78NPGNb3NMxMSt
 fdn3f7pgACahi/npRevAX1aMqeM9ERLJPbA4h2y7CCuePbTbLuQWskNoMUlI1R6lTw+I
 3ippJY7L2HB8SIgBi6Q/KaCo7ScxbKehspD+cki0GM55iN4m/ecvcbTD+BV7rrD9nEjd
 cQiUAtqAVreTAN55pHb65riwHrVj+4RgDk8+t4IOmsX409TAHRL68ZkJTznkAlrjzSiu
 h5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764133944; x=1764738744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HQ1R6EvJpYnD9hN0xQVX8FgbeaOknQjkBJBW/31LAE=;
 b=YeOUxaDaaj/eMJ/kPnAxGnxjmV6d9SH7LOAK6uWrU4s8+cX9H8eAbE9GA2wV2Y5z/f
 XDmHF6vr06WSsF8uRqiplYKCv8GOjYE1FUTlZJLVykXIT26Ja8PlcAKfZTJITe9OzdUN
 Dig4gn6zzLwGYTFMURLAw5UxJl/++YJM84y9+MuuT8LWNnDcI3HMQioNf6bAdXXS82J5
 eIk6hyM5JpcM6AEFUFfF+q7bzQdR7nfIk2v0odPUdgmGNU05t99iSRHN9BhryrfAR6N1
 18QIuJbX6cJlJ4rfjom8NYkpvilF/XG2+yhVTi1MYaGsBA1s1t+OnNtIXBnH9r5kY4Gm
 hATw==
X-Gm-Message-State: AOJu0YyWKqNJ8ggYxHjZqdplELPUh/o8fSvfSIxsk0UqXa9n3SZqirol
 OEqbBA2PeWKLQ6d92/b5QprxwhUgAW8nYUaJJsLLQmbAUybaVOjWx7i/AWh3nOFkgllyWSqdPuX
 2phsS
X-Gm-Gg: ASbGncv/IqNTk+fe6S7fe1Zb8gFkw55en0bk1vWbDC7c1CfhPAsbqzb1hrOnoo6TIMy
 Bb4EDuuK/Vd3gYZpKR9Kir2JWr0RylvqLjEJ1s1JMUm1nSpIwEGNh7NfRxT4qQ/5crHQ8rUSqYr
 Es+H2WOqeNOvaw9yxi0sVcZXq8xK3U18SXvmrFKpWg1hYifyi9//9KBosaudfQb7poFUTK3/Gjo
 D/Pp3bYyLQN5Yc9sVC39UvBpVRvuTmN8o7qOvDPMtdA2Mae02nTC/zjgg8w25RBoPwOyHWOs5HZ
 RNTz+kwYwe7Vkgn/atXdC0UbT7qKEdIFwws/jHTvA1lG4Al2KhH0mp+IORsJ6iINH3lUmKCGmpl
 7d9wrfKMwr8tfh04neesy4+YAUxb9oSKhqYBIgQ5TObNnuUU9lyP0Pv7WR+SQ43yJEUq0jmV+I/
 HHjIBMVqMX4tGsTlP2q2m6qld0kaMxw5a7VyZvWEXOdzGdNQNNiw==
X-Google-Smtp-Source: AGHT+IFoELV0g7xO2xMIHZtyV2TGYA70iebQg9ut7b29in950hYtn4oJWb0gW8dWDBQxEfuxkoPxeQ==
X-Received: by 2002:a05:620a:45a3:b0:8b2:9a8a:118b with SMTP id
 af79cd13be357-8b4ebdad5e6mr693570685a.73.1764133944021; 
 Tue, 25 Nov 2025 21:12:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295e8338sm1327936385a.46.2025.11.25.21.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 21:12:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC] pcapng: improve performance of timestamping
Date: Tue, 25 Nov 2025 21:12:18 -0800
Message-ID: <20251126051218.50568-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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
index 7c3c400c71..283962fa2d 100644
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
+		uint64_t tsc_base; 	/* TSC when started */
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
+	/* Compute baseline TSC which occured during clock_gettime */
+	tc->tsc_base = (cycles + rte_get_tsc_cycles()) / 2;
+	tc->ns_base = (uint64_t)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+
+	/* Set conversion factors for reasonabl prescision with no overflow */
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

