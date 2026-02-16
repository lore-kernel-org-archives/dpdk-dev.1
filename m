Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFDCE8383C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 21:43:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4D724066A;
	Mon, 16 Feb 2026 22:43:27 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id A1D8A4065B
 for <dev@dpdk.org>; Mon, 16 Feb 2026 22:43:25 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so30887885e9.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 13:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771278205;
 x=1771883005; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wK5lYXCR4GkVX5cGqItrM+jDQAhlrw2x9GF7OpdVbdY=;
 b=SZpzk4Kd/LWK0IUb103ZStDF+gcJzxzCzoPgzLhoq888H6G6rJGNS3H4F25nKT4hyX
 z9a9oJ4CMpUTzqPBD3xJFZOMAtc8RGAM+Q41dXsxvacXirZ3BCoofXt2TQOlF128PE05
 WIewOtlD0DI98gzlVpzlfl/e7P56G7qsOTNmYl4ynreMM+3ZLHVaWNcDuPeDkS8lFeT2
 CIfe6jbpVrXrfuS+dhRZusv44U8Xgz73q+wouAzS7q7m0IUYDYiR4uj7LxxzHz0gk4If
 PsIDSluhL+X7k425pT9261/Lnh43ubcqPozQk2/CxhodCDC3QLDRwnwKhQJtG19vdLUY
 UUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771278205; x=1771883005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wK5lYXCR4GkVX5cGqItrM+jDQAhlrw2x9GF7OpdVbdY=;
 b=mcgzOt1vUfT9uWoKVPXI3+HJh/nz9l/LyAhQGA/D5yTkhodgD3ZfgTaQu/Q0M9Bc6R
 +hdb7wOMjA0JxXI5MWMFEv1706j2xECVYzO6ibwYPqzAsE8QKJe7bHhB0nU6FN2Lo2TF
 aY2Z3eJhqoS5pFAP4K63ba7zEEGYjxWtpbk5RZu6FyrXxoiebGI55qybsCRukCoQen/E
 Em6nKiuHY3d8RJPYBC8pX62P6p2WpDX1TODe0l5z8ssTEySAuCgm6CkRv7jy1rXm5ORE
 nmjMVKqTwPVXpHVW73/zdfEWG1dT+rwVVyN7J1hnlsCJ+b1+awSrm0Wmzo7xZpkAANz3
 SOrA==
X-Gm-Message-State: AOJu0YwKjIHSuUpbb4m7ZmmMI1ZhzwR0xINmvT9UaUomRHSHBzkjICL/
 gTrbD7Mmw1b0rUHGqRz37HpKFY3VmpdI3wtune+RTzE1DuHjwapVYtvTHNH3k0hTIwV7F5/XvLb
 ndzG98ok=
X-Gm-Gg: AZuq6aKUxAU+HCjJsj6PPE3xsiEEUOIzvGqQT5oDSz3YO61I7ytz/RPj5mlHdlSGG/M
 cvnnrSLVvACr2Oe6sK8sfjU0AE6wtHMs39b8wX9i44+TEGzQi6JP/sDmHKiNKjS8nzsE30cTG0c
 DwT5Oe1r0veK1lpCecDrIsPxxvTl5Ti5IIxvoO/On3iR4kNemQa8T8UrwCYAucbEQs1NSZK5T4h
 lRlRtN7Vc2dKXN3K30duv+mhHYQ/O3+LlOFLLIoNio5336PoLv0bcuLikJjZ2qN6laJj8053J/s
 FsKoe3jcu57RsZWSaR5dnOh5NdCojqeWHWSphHK7uQI2M2Ar8f1hrCJ3FQ2T4YMC5vjuLYa0aLe
 7iMzfu9+R6JbfwnKXd9K8skBN3C80rMEQJyc1NrVROpBg2id6RVS2PDU0IVqF8fB+dwK8znxDPJ
 2RxnB8jlBB5SzGfkeIjbQnSpHzlH81Yk5rOazWXUGFG5gJqSIPNECfqvakX4x0XS9wnAZu8ikG
X-Received: by 2002:a05:600c:c16b:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-48371042fb1mr201841045e9.8.1771278205113; 
 Mon, 16 Feb 2026 13:43:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm32146354f8f.3.2026.02.16.13.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 13:43:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>, Ray Kinsella <mdr@ashroe.eu>
Subject: [PATCH v8 4/8] pcapng: use malloc instead of fixed buffer size
Date: Mon, 16 Feb 2026 13:38:01 -0800
Message-ID: <20260216214311.717492-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216214311.717492-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260216214311.717492-1-stephen@networkplumber.org>
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

The administrative APIs accept comments and other metadata as
strings. Since these strings can be arbitrarily long (up to
UINT16_MAX bytes), they may overflow the fixed-size stack buffers
previously used for block construction.

Replace the fixed-size buffers with dynamically allocated memory
sized to the actual block length. Return appropriate error codes
on allocation failure.

Bugzilla ID: 1820
Fixes: 8d23ce8f5ee9 ("pcapng: add new library for writing pcapng files")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 50 ++++++++++++++++++++++++++---------------
 lib/pcapng/rte_pcapng.h |  1 +
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 914d6e7095..a5a9a827bb 100644
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
@@ -148,8 +145,9 @@ pcapng_section_block(rte_pcapng_t *self,
 {
 	struct pcapng_section_header *hdr;
 	struct pcapng_option *opt;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 	uint32_t len;
+	ssize_t ret;
 
 	len = sizeof(*hdr);
 	if (hw)
@@ -165,8 +163,9 @@ pcapng_section_block(rte_pcapng_t *self,
 	len += pcapng_optlen(0);
 	len += sizeof(uint32_t);
 
-	if (len > sizeof(buf))
-		return -1;
+	buf = malloc(len);
+	if (buf == NULL)
+		return -ENOMEM;
 
 	hdr = (struct pcapng_section_header *)buf;
 	*hdr = (struct pcapng_section_header) {
@@ -199,7 +198,9 @@ pcapng_section_block(rte_pcapng_t *self,
 	/* clone block_length after option */
 	memcpy(opt, &hdr->block_length, sizeof(uint32_t));
 
-	return write(self->outfd, buf, len);
+	ret = write(self->outfd, buf, len);
+	free(buf);
+	return ret < 0 ? -errno : 0;
 }
 
 /* Write an interface block for a DPDK port */
@@ -217,7 +218,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	struct pcapng_option *opt;
 	const uint8_t tsresol = 9;	/* nanosecond resolution */
 	uint32_t len;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 	char ifname_buf[IF_NAMESIZE];
 	char ifhw[256];
 	uint64_t speed = 0;
@@ -279,8 +280,9 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	len += pcapng_optlen(0);
 	len += sizeof(uint32_t);
 
-	if (len > sizeof(buf))
-		return -1; /* EINVAL */
+	buf = malloc(len);
+	if (buf == NULL)
+		return -1; /* ENOMEM */
 
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
@@ -323,10 +325,14 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	/* clone block_length after options */
 	memcpy(opt, &hdr->block_length, sizeof(uint32_t));
 
-	/* remember the file index */
-	self->port_index[port] = self->ports++;
+	ret = write(self->outfd, buf, len);
+	free(buf);
+
+	/* remember the file index only after successful write */
+	if (ret > 0)
+		self->port_index[port] = self->ports++;
 
-	return write(self->outfd, buf, len);
+	return ret;
 }
 
 /*
@@ -343,7 +349,8 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	uint64_t start_time = self->offset_ns;
 	uint64_t sample_time;
 	uint32_t optlen, len;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
+	ssize_t ret;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
 
@@ -366,8 +373,9 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 		optlen += pcapng_optlen(0);
 
 	len = sizeof(*hdr) + optlen + sizeof(uint32_t);
-	if (len > sizeof(buf))
-		return -1;
+	buf = malloc(len);
+	if (buf == NULL)
+		return -ENOMEM;
 
 	hdr = (struct pcapng_statistics *)buf;
 	opt = (struct pcapng_option *)(hdr + 1);
@@ -398,7 +406,9 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	/* clone block_length after option */
 	memcpy(opt, &len, sizeof(uint32_t));
 
-	return write(self->outfd, buf, len);
+	ret = write(self->outfd, buf, len);
+	free(buf);
+	return ret;
 }
 
 RTE_EXPORT_SYMBOL(rte_pcapng_mbuf_size)
@@ -710,6 +720,7 @@ rte_pcapng_fdopen(int fd,
 	rte_pcapng_t *self;
 	struct timespec ts;
 	uint64_t cycles;
+	int ret;
 
 	if ((osname && strlen(osname) > PCAPNG_STR_MAX) ||
 	    (hardware && strlen(hardware) > PCAPNG_STR_MAX) ||
@@ -737,8 +748,11 @@ rte_pcapng_fdopen(int fd,
 	for (i = 0; i < RTE_MAX_ETHPORTS; i++)
 		self->port_index[i] = UINT32_MAX;
 
-	if (pcapng_section_block(self, osname, hardware, appname, comment) < 0)
+	ret = pcapng_section_block(self, osname, hardware, appname, comment);
+	if (ret < 0) {
+		rte_errno = -ret;
 		goto fail;
+	}
 
 	return self;
 fail:
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 68e13c67e4..d8d328f710 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -199,6 +199,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
  *  On success number of bytes written to file,
  *   -1 on failure to write file (and errno is set)
  *   - (-EINVAL) if bad parameter.
+ *   - (-ENOMEM) if unable to allocate resources.
  */
 ssize_t
 rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port,
-- 
2.51.0

