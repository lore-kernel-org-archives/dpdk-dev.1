Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2DCD29C56
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 18:20:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CA6B4060C;
	Mon, 19 Jan 2026 19:20:27 +0100 (CET)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id A1DAE4042E
 for <dev@dpdk.org>; Mon, 19 Jan 2026 19:20:25 +0100 (CET)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-64b83949fdaso7093063a12.2
 for <dev@dpdk.org>; Mon, 19 Jan 2026 10:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768846825;
 x=1769451625; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5PcBQe1Ebz30G+0RtsYyBCbMoS7gu/sxoIIu/wDIFgQ=;
 b=u0c3z+7SIwJkfaY1AzYVVtY0yPTbrZkn+lLtLki2G9rDY/oF8cFW4rKEIWxRB1b3W+
 VgFNb98o9pFEjyshDB4dIei7KBhJGQsaPTL2uzeXs42Az0l3S7zAN00v/4i2WefAttOa
 /+T9m8Xq+HwJRYpVO1o9Nzx7yHYoYL488IAPq+WdihfOGlpXJE6G22w2+sV+uJZO3+hI
 APpqUPan8aYMliizHie1v/YB/N9NjDksaE7b6S+ij/Ff2Ei0nwRwajFGbhPrEcDlLOgf
 yWY1fLUQcAcakz1oJ6Qo9tSKK/yIGRVjF1kpuKcISmuakC7Suq1yk3FJsmu2IPCmMfYa
 E1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768846825; x=1769451625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5PcBQe1Ebz30G+0RtsYyBCbMoS7gu/sxoIIu/wDIFgQ=;
 b=KJnjeNAkN5vXi9bFUOcWkcg9ZgF3rg6eejNiIP0H74RPo0GOgmHDzBR+gwhLMlrVCI
 b1wlMM4dMy2rlDaAxGzLKlg/NFfzQeSb3ngAknPHz3mJ2ATKmM2KcbZfeMuOpeagBzcp
 BeeRn6sb/aUaZlecKRyE8fdJwYQYldve+PIFGNx4Tht/2BwaE3IAHLnVBwgiRBOAr0xU
 uhfT5f8ITzyAFDYcoiZU3SDGtLJjaJz8Zfa3vdUqOGCLXNuXmbAbIkcdPssAsOQMZA0g
 ZC+8OIv4Ae1JqmnRokGVFstaNAlp1z2kQorgdx/oM7o9RyZfVQTasTZZ0WhWfThoqvsq
 9nkw==
X-Gm-Message-State: AOJu0Yx0MebvLE9RGPzbKJLybZiuF8zKSxZ2hXQDYSanEpaiNc1RyVLR
 Ma+CpckLUQV9TA7sunqXiJMQxF0WJSPqg38qHuW2cgzuzeQbGcQcVhm2ktPw+oiGm1g1BxL/gKE
 fPGb0
X-Gm-Gg: AZuq6aJnuTUNxg2ZvATOiYYK4GlePa9U3aOtahNuy17VmB1vn+N/C+E4cU6XVSMWwjo
 1rtpw8NeHILgjdv5RRmb8uYEzpQdCnzitixQaP5xTH/kS1jny399f2eE6yeGPeSnt+dThqsM0mG
 v331KK58YPtQ97vv74/uEq30wsmrg2chmvEA339/koC6B3il82TaVmmkdbUAt/3MmSw2FUdaX2t
 Kqmy3PDCJgyhwDKsij95bGOfgCeKyNIu3x8o9dqW9uuBdanjMp6jdwvUclWM+j5Dk8SQVL6e9QB
 JeRK81XK3PQgqpVfY1bLAJmxGbuqS7a1GaceY18JZc/i4aPGwe4qtbci3cCIjnsWMbukohr78D7
 gg9hBd+a6/IKeW4edMDnq165HHfJw4m/M6KOd9cuImA/pDX0K+msDUrkFhb84SblZoDy/HCkPRO
 nnovsdqT8GsTUIqRHjm1P2aljIToxC6mPb+ocN7B3kUsPhDs21pA==
X-Received: by 2002:a05:6402:23c4:b0:655:ad4d:66a2 with SMTP id
 4fb4d7f45d1cf-655ad4d67eemr7381514a12.1.1768846825215; 
 Mon, 19 Jan 2026 10:20:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdab55sm10878829a12.10.2026.01.19.10.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 10:20:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>, Ray Kinsella <mdr@ashroe.eu>
Subject: [PATCH v5 2/5] pcapng: use malloc instead of fixed buffer size
Date: Mon, 19 Jan 2026 10:19:00 -0800
Message-ID: <20260119182016.44769-3-stephen@networkplumber.org>
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

The administrative APIs accept comments and other meta data
as strings. This leads to possibility of very large strings
which can overrun the use of fixed size buffers.

Instead, use malloc to allocate a buffer of the necessary
size and handle potential allocation failures.

Bugzilla ID: 1820
Fixes: 8d23ce8f5ee9 ("pcapng: add new library for writing pcapng files")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index ac46e43b38..49fac60a3d 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -37,9 +37,6 @@
 /* upper bound for strings in pcapng option data */
 #define PCAPNG_STR_MAX	UINT16_MAX
 
-/* upper bound for section, stats and interface blocks (in uint32_t) */
-#define PCAPNG_BLKSIZ	(2048 / sizeof(uint32_t))
-
 /* Format of the capture file handle */
 struct rte_pcapng {
 	int  outfd;		/* output file */
@@ -148,7 +145,7 @@ pcapng_section_block(rte_pcapng_t *self,
 {
 	struct pcapng_section_header *hdr;
 	struct pcapng_option *opt;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 	uint32_t len;
 
 	len = sizeof(*hdr);
@@ -165,8 +162,11 @@ pcapng_section_block(rte_pcapng_t *self,
 	len += pcapng_optlen(0);
 	len += sizeof(uint32_t);
 
-	if (len > sizeof(buf))
+	buf = malloc(len);
+	if (buf == NULL) {
+		errno = ENOMEM;
 		return -1;
+	}
 
 	hdr = (struct pcapng_section_header *)buf;
 	*hdr = (struct pcapng_section_header) {
@@ -199,7 +199,9 @@ pcapng_section_block(rte_pcapng_t *self,
 	/* clone block_length after option */
 	memcpy(opt, &hdr->block_length, sizeof(uint32_t));
 
-	return write(self->outfd, buf, len);
+	ssize_t ret = write(self->outfd, buf, len);
+	free(buf);
+	return ret;
 }
 
 /* Write an interface block for a DPDK port */
@@ -217,7 +219,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	struct pcapng_option *opt;
 	const uint8_t tsresol = 9;	/* nanosecond resolution */
 	uint32_t len;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 	char ifname_buf[IF_NAMESIZE];
 	char ifhw[256];
 	uint64_t speed = 0;
@@ -279,8 +281,9 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	len += pcapng_optlen(0);
 	len += sizeof(uint32_t);
 
-	if (len > sizeof(buf))
-		return -EINVAL;
+	buf = malloc(len);
+	if (buf == NULL)
+		return -ENOMEM;
 
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
@@ -327,7 +330,9 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	/* remember the file index */
 	self->port_index[port] = self->ports++;
 
-	return write(self->outfd, buf, len);
+	ret = write(self->outfd, buf, len);
+	free(buf);
+	return ret;
 }
 
 /*
@@ -344,7 +349,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	uint64_t start_time = self->offset_ns;
 	uint64_t sample_time;
 	uint32_t optlen, len;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
 
@@ -367,8 +372,11 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 		optlen += pcapng_optlen(0);
 
 	len = sizeof(*hdr) + optlen + sizeof(uint32_t);
-	if (len > sizeof(buf))
+	buf = malloc(len);
+	if (buf == NULL) {
+		errno = ENOMEM;
 		return -1;
+	}
 
 	hdr = (struct pcapng_statistics *)buf;
 	opt = (struct pcapng_option *)(hdr + 1);
@@ -399,7 +407,9 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	/* clone block_length after option */
 	memcpy(opt, &len, sizeof(uint32_t));
 
-	return write(self->outfd, buf, len);
+	ssize_t ret = write(self->outfd, buf, len);
+	free(buf);
+	return ret;
 }
 
 RTE_EXPORT_SYMBOL(rte_pcapng_mbuf_size)
-- 
2.51.0

