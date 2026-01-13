Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F31BCF45D4
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 00:52:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1255040615;
	Tue, 13 Jan 2026 01:52:06 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id DEA314064C
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:52:04 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-430f5ecaa08so3316464f8f.3
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768265524;
 x=1768870324; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDdue5NnT8vGqMvdHE0wnDDxGpF0zEbxL8PVq5ZpE0M=;
 b=KPBNGt0va9eyT61key/h/UvVRCUZXimvGEj0U1qLinBD4lmFAPPp5l1L/FfqkCo9bg
 iAYM5Jn6CCHosQY35P5YomYok5RjnkQqJKjmnN4m3Ou4nV7xHsYd/q7pBkCxVGWNi9Sy
 PZTuU8uguhxQ/egqbhdC22L5ajQ5BShrWBJmRZfakphjy7SLpMnsNSdaOYlpJe4Ux/Cl
 C8izXRSffHIq83+sJAd27VoJbu0Upf1b3mmGKzDeGgp9HnhDgVvKl3IiRexb+cV5DmPO
 fV4jgOjc0Q+7dkGF89udhDUQsz91YHAfpRhG3J8LVqS1TnFdwgE1ELamimRNLjzO9nkX
 6WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768265524; x=1768870324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CDdue5NnT8vGqMvdHE0wnDDxGpF0zEbxL8PVq5ZpE0M=;
 b=vMHxK0S4Z8PaYIP1+iARZYuhroE8H9tWNkvDV2PkVobQGf8l8HsIJf1xNRdmWegfgv
 iuy5w5boz7Xq4yffgB/xx/2/rvStyoIRr+GYUjs4v7QkluQ2Y1qr+q9WDrx0l4zqoDlJ
 IozUZY7ybfQFtpHANw6XwW3MiJyT7HkeH8SfD4PLeeCUxrPf5YIvBXCt5YKVw8GWa7+/
 dvA1zD5JthOhEx4O3g7IgX4SQ6bHbJrh5UHJcxZb1r+U+Fs+ZTUDw3ThzOB7BmwmDgNR
 2CQkjRsKfNC1ijlg4xj1anEyh5wi3aD7jDRDg/QiKgMRkSU9IpKCn80RMH3mWEQsDXab
 sdxA==
X-Gm-Message-State: AOJu0Ywe+q7cX8LThiP/EGH3jKoX1r6dtsE7YZOSQj3P++U8skDLZauw
 6enB+451foWc2593ZT9GLw15hVwqwptbf8PpR5Yym+Bqrm6xz+HJUdb+PXhsenB1aVLSpKDRj6P
 N3Cn7
X-Gm-Gg: AY/fxX7nJotW0ivQ2TOWjaBauOOfq9JChkOX4Sf3PYFxZWOLCW+OKcApmlUMOiAQf78
 44qoOzOE8dGm14hQPLazelkDLJBxQK3tANxz2W5YKGRowXsPlRGfi79xTeNmt57yp+iFH8ahW2O
 DaJtBHEWETRLsOsmqY/BrWhO10zMXff72T3DerbtA60/A0LtTLPhUr2tw5zG/H8A/ndsWG4vLH6
 SElTMLEuGQaqGBSDzOXbNxM2QSPrVCjRMKiQjfVg8LmbDiMfLuLeVYHqbyJY2JH9vr/uOf8wfHc
 C2AO2Eaomc2FU7IC5SmRsqOznIQJ0samYQvPv/uKTbxSbqPni1T3QTiC9iAc5o2Tdfdb1RAeIPY
 aeZrxiw9+m4Pf65UIw6cH02oJXF32U1JVnOA5Qrmf6xG2TUq5xJUXHsGr/HHYxUGovv3qCev1UX
 4NuShKTBlCzWEzs5yQLv04SAiGtpXSttBAZ03B6mCEMvz262p+0g==
X-Google-Smtp-Source: AGHT+IEb8pUHClOdglz5uaF39Vee5a16qSudgau6aUDwB9qgNJUia5AHPRqq8shtLShKH1+UkW9Icw==
X-Received: by 2002:a5d:588f:0:b0:431:8f8:7f1a with SMTP id
 ffacd0b85a97d-432c3750285mr22817547f8f.31.1768265524474; 
 Mon, 12 Jan 2026 16:52:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm41603051f8f.8.2026.01.12.16.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 16:52:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>, Ray Kinsella <mdr@ashroe.eu>
Subject: [PATCH v4 2/7] pcapng: use malloc instead of fixed buffer size
Date: Mon, 12 Jan 2026 16:51:25 -0800
Message-ID: <20260113005154.44551-3-stephen@networkplumber.org>
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
 lib/pcapng/rte_pcapng.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 863706a365..c2635d8b03 100644
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
@@ -279,8 +281,11 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	len += pcapng_optlen(0);
 	len += sizeof(uint32_t);
 
-	if (len > sizeof(buf))
+	buf = malloc(len);
+	if (buf == NULL) {
+		errno = ENOMEM;
 		return -1;
+	}
 
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
@@ -327,7 +332,9 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	/* remember the file index */
 	self->port_index[port] = self->ports++;
 
-	return write(self->outfd, buf, len);
+	ret = write(self->outfd, buf, len);
+	free(buf);
+	return ret;
 }
 
 /*
@@ -344,7 +351,7 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	uint64_t start_time = self->offset_ns;
 	uint64_t sample_time;
 	uint32_t optlen, len;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
 
@@ -367,8 +374,11 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
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
@@ -399,7 +409,9 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
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

