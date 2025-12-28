Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9461E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 18:45:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76105402EB;
	Sun, 28 Dec 2025 19:45:43 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 2035240267
 for <dev@dpdk.org>; Sun, 28 Dec 2025 19:45:40 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so5001400f8f.2
 for <dev@dpdk.org>; Sun, 28 Dec 2025 10:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766947540;
 x=1767552340; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xFDGIABKehAqUGpvyqmRaLuugurynesvxqL+XBLOsw=;
 b=jGmxBSPxWcdD1zKEiLwmfCpbmnHEjIbyjpI3rIKL3/cWLOJaSdJdnOj9ClNl3n4iI+
 hMYBbEz+a2P5VcwUOlzbvw1rkmCBp5AEN+gGVeCVPR+uAXQe6cyO/nxr+2UMlDOYCjN4
 g7/jhTkkl7AAbU55KznS5JbSCEXuuujkRGZg9eLsKK6DsARCqyFSL5uqsiVmErka+rrd
 s8sIFgnPeSHOGt8OLdLaIAJG22FdZ0m8tn3gR0vRZaO76KmUfDgdB91UdwHOnovnXtz8
 PZ2Wrw6R3dyFRx6L1/xLX+H/Wpjv71d86lc2yXIA9JPVOONlP7r2i9vQR4FhY4nKocvS
 PBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766947540; x=1767552340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4xFDGIABKehAqUGpvyqmRaLuugurynesvxqL+XBLOsw=;
 b=Gzfv1a55nlonKPPTNioqabLnuC3n0cOLXd8L3SZEFqwdnbjMJUPGHOeT2uvHJPxYqz
 QuOWvdCIbL4CRRGsylqxO68woIoaHlAYnzeQ9MA94dQXfmawAcwjh5J6BnELJqA9bIVu
 AE11aboWcrfLubQerXfcGri3QYYg+nJarMU4wx1bBBCpFsLtSWK925SMF2Vkba1Bl7mU
 UMgHvY26CO7CswzUqFaqGAB+t04wjS38GhrZdU0DSain8haWgGjtldVCHR0H0W19Mg5n
 BNOK8Mr/swXkcjpzrfd5JA1DLr1jvcbIPBfkYcVC05FtBWlPAziDnuLrvVrvpqtgB2zv
 ic/w==
X-Gm-Message-State: AOJu0YwtZYRnO+Wz2CmJ1wMvv2tXhIaBLj886iaf28W6/PpWsTraMeI2
 uY39DxDt2By/bzaTKYjAUyW6ojsqhoyD8NHKsrTiLprM3P5Dg/3+zQ7P3K4NFrhqxJfAn9p9UCf
 lqWVh3J4=
X-Gm-Gg: AY/fxX7DWaxsdj8n/ySkPHS4MdAe8YIh62MBzt4YHO05HJfdmQnDBCQC5FW3Y6SGgk+
 3RiANMo14iCUet0CpXxgNbzJToGpGrp7MoQ+bIF338vDhY3sBhko0pwCnIirWr6BjHtS4AwiO1/
 ighGFedAQurVX2Ea8ZPRHsYk+AXWZEaBl3xRNDP+qfDjklBrq7AaAzvx0A3xSAyvzjP8NBPV2e/
 0RjbE91hN3wa9lAM7y3MyBEQZkhQEewRK/pK8KOcuR0fZBuwCmBAf2bqeqoG+mvM3AY875PJyxq
 tC+v7tIU029sXLuFuHST2h+MsaWsF+K35B9OH4X9SpfFZK9mHs1DnQGcm6H1ploaxXGSaQOxZ7h
 lf8EGJU0uarAB8QlggA/cbj7Vz6U7i2UuDM+uIA5mxLzh1ccq5/r9XaqzlfCOAGbIJMxE9Q1IN6
 vaGGoM+cNcAUU6MtxP5QzT8NnNbutMrI5wl+mPR8liMwszdMDdhA==
X-Google-Smtp-Source: AGHT+IFmdOU6beKqRjLd6V9incqLZfzUBOGDrBHxIB+otD6JENHlLL6yX6ZS45+1LU55ND5iw00P3Q==
X-Received: by 2002:a05:6000:1842:b0:431:32f:3159 with SMTP id
 ffacd0b85a97d-4324e4c6975mr31326517f8f.7.1766947538959; 
 Sun, 28 Dec 2025 10:45:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm59150275f8f.32.2025.12.28.10.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 10:45:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 1/7] pcapng: use alloca instead of fixed buffer
Date: Sun, 28 Dec 2025 10:40:14 -0800
Message-ID: <20251228184300.541639-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228184300.541639-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
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

