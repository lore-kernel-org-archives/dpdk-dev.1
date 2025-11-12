Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B07CD343E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 18:14:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12B7340DDD;
	Wed, 12 Nov 2025 19:14:27 +0100 (CET)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 991D54014F
 for <dev@dpdk.org>; Wed, 12 Nov 2025 19:14:25 +0100 (CET)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7aab7623f42so1326168b3a.2
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762971265;
 x=1763576065; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xFDGIABKehAqUGpvyqmRaLuugurynesvxqL+XBLOsw=;
 b=qwHG1k0ZiOIUMmeK51P+wIJB99EnT4gkHTOk/Eey/DlDqkP6VmDMCawfHb0lSnekSy
 nLkC9VJoaw/VQTJDxNPWSc13X16+ElImBugOvTPECcDP80wZ8AX4A7VCQEx5MbpKdrVQ
 IHFIZQpygF//sChgemFnrvIqqEyx1RTkeyi4It1d5ZtzcUuj64RRp8syJI7ADw3qIt8N
 YdzY5yTgwVcJULyo177UnwkYN2+rzPSqYFZ+LZI5VB1wF/0usCDuQ+FcUcmRC8PZfUZl
 0O7Z4oEPCqxAIR4b4brY34cojQTifFwWV5rwyQmVmo/wVj90imAhki3qtvC59M/Qe1n4
 c4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762971265; x=1763576065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4xFDGIABKehAqUGpvyqmRaLuugurynesvxqL+XBLOsw=;
 b=vFNt6SJLReahgksp5W8dD0f/j7MvnrivSZRvCOA2XkayF5ZMMpNjzIpAGVF+W6gMsu
 MnLlp0N4+e17BT+p8jKNcxiqdK1qi924Gbhkkqpaq1VzmDTcdi2EeiWhH1Hoql7Jr0bd
 g1AwHNaQlSI+FG5cTW/TVx922Qief6GI9fRatuXAjFOqkzSURAlhU36fb0+t+4vVTrfy
 qAzBjJaQLaD+cuK0KAR0KtS/CzbCRbRunLDkQ4MSCmzqNCFZ3ps/09259cRIqkFa3o0m
 5xAXGp1roSI7/uHyYeSlifEC3fzfU8QSZWQdJY1vC7c9dregXwIQPbvVdAMQgcgR/eSk
 cesQ==
X-Gm-Message-State: AOJu0YypvqzPjbh4Y+DbCRNZpMPS7Mjk10ektesl50xDFHmrWtkjo8Ng
 EeN1wgPEODH3OBe8Wrq2Sg+Ee4hx871xvUwn/+S8oEBpDk5SWY2Rz8TVZMR4oWNJOGCqggCWJU0
 VXh8a
X-Gm-Gg: ASbGnctJI9MLUBQxqTNA5C1/0rZ+uPUoiFbOvKL7lk8PMSlXMhfCzbb4DiH6Tew55Jv
 B4F2ImMVFNW/kBXP4smaRx+3jDuigKp9KnNNty9kUnFiEQerzdkYYgBxCjUXRy1wShAJrSR/5/y
 KCP3dNVHH07Wp7iR+JXi8KHXPIrnBhzskwagMigi7XzkjB6awqGxT3N8XXL4Nww8tF3YjDQjGmL
 Hm7EaZu78adcFD8fzgHFVkA7jaOqwZ1NMpBbsPa8WRB/aoxyZvsUty5FFs1Eb6EGjNyLpskE0R+
 wocOz94kjef+DST/G3tq4EoA9DWBW8x8UroHpVKcmRVthfielcN5qKeJ0/PSayeiTsS65gvetp+
 Isky7wAD8D3LHBDN9dC95JWGufxu4hZAOr+6lQva4s2lS+SCZGd5fhBUuiz/mj4rlm6PS7JaavO
 xBb1b2waadCrn4kKKK9affvEjru2a9nWNCSPi0MbQ=
X-Google-Smtp-Source: AGHT+IE+9t+RDoRIPv1GeJESrJf4AakGxd1zJv6pPG9dedEeQujUpIzlw6cj23CjqjhFNYzA3dXkhw==
X-Received: by 2002:a05:6a00:2ea5:b0:7b7:828b:f569 with SMTP id
 d2e1a72fcca58-7b7a4afa57emr4676668b3a.25.1762971264605; 
 Wed, 12 Nov 2025 10:14:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0cc17b0b5sm19294006b3a.35.2025.11.12.10.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 10:14:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 1/4] pcapng: use alloca instead of fixed buffer
Date: Wed, 12 Nov 2025 10:12:47 -0800
Message-ID: <20251112181421.285119-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112181421.285119-1-stephen@networkplumber.org>
References: <20251105210657.871310-1-stephen@networkplumber.org>
 <20251112181421.285119-1-stephen@networkplumber.org>
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

This is an API that accepts strings as options, and user could
potentially ask for very large string as comment.
The dynamic way to fix is to use alloca() to allocate the buffer
used to hold options.

Bugzilla ID: 1820

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 21bc94cea1..3067033e89 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -34,9 +34,6 @@
 /* conversion from DPDK speed to PCAPNG */
 #define PCAPNG_MBPS_SPEED 1000000ull
 
-/* upper bound for section, stats and interface blocks (in uint32_t) */
-#define PCAPNG_BLKSIZ	(2048 / sizeof(uint32_t))
-
 /* Format of the capture file handle */
 struct rte_pcapng {
 	int  outfd;		/* output file */
@@ -145,7 +142,7 @@ pcapng_section_block(rte_pcapng_t *self,
 {
 	struct pcapng_section_header *hdr;
 	struct pcapng_option *opt;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 	uint32_t len;
 
 	len = sizeof(*hdr);
@@ -162,7 +159,8 @@ pcapng_section_block(rte_pcapng_t *self,
 	len += pcapng_optlen(0);
 	len += sizeof(uint32_t);
 
-	if (len > sizeof(buf))
+	buf = alloca(len);
+	if (buf == NULL)
 		return -1;
 
 	hdr = (struct pcapng_section_header *)buf;
@@ -214,7 +212,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	struct pcapng_option *opt;
 	const uint8_t tsresol = 9;	/* nanosecond resolution */
 	uint32_t len;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 	char ifname_buf[IF_NAMESIZE];
 	char ifhw[256];
 	uint64_t speed = 0;
@@ -268,7 +266,8 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	len += pcapng_optlen(0);
 	len += sizeof(uint32_t);
 
-	if (len > sizeof(buf))
+	buf = alloca(len);
+	if (buf == NULL)
 		return -1;
 
 	hdr = (struct pcapng_interface_block *)buf;
@@ -333,7 +332,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	uint64_t start_time = self->offset_ns;
 	uint64_t sample_time;
 	uint32_t optlen, len;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
 
@@ -353,7 +352,9 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 		optlen += pcapng_optlen(0);
 
 	len = sizeof(*hdr) + optlen + sizeof(uint32_t);
-	if (len > sizeof(buf))
+
+	buf = alloca(len);
+	if (buf == NULL)
 		return -1;
 
 	hdr = (struct pcapng_statistics *)buf;
-- 
2.51.0

