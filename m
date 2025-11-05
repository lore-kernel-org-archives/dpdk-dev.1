Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F049FCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 21:07:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41D4F40B90;
	Wed,  5 Nov 2025 22:07:04 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 835DC402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 22:07:02 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-29555415c5fso3816135ad.1
 for <dev@dpdk.org>; Wed, 05 Nov 2025 13:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762376821;
 x=1762981621; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xFDGIABKehAqUGpvyqmRaLuugurynesvxqL+XBLOsw=;
 b=Nf59DrsyBfLmAlAoB9dgbECnSCr+df8udw01rCxUjsfh9PXGSrKkKiJHdR4Hwm8drJ
 1SDFR4wQ9AKJHl9lAfDIRjKUM4qeIfh5N+OBGdZfseHsYIJSKeWpfBADHdeYKCpuKFm3
 02IcG7l2QxPiwGYbBWeX4nOgwf73gh5CdXmlGKlW2k3BG6OVPEkyQirjRTck8CtX/4Vw
 XTxQx/my+LjIFhCQKiZdJTxw8pyN7cQxyetM/7bnZowDy/9LBr4S2Nd4Xbd9r/UO/okP
 3QDvylIZ15y7hDlWc+3ISKjgyphIkqPbKDvVe2s8v/gyUFCfs69ux1VE70AtNWzXo08i
 yL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762376821; x=1762981621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xFDGIABKehAqUGpvyqmRaLuugurynesvxqL+XBLOsw=;
 b=kdQBi+RnpfX4dCqlkjDFEnZGNDfe0ECRKs0necKZcBHwmoCrGM717MM9yA+tqnkL2I
 M9AVYcMO9KIhgTZwZ1j6gP1pBM/ecEjGOSJ0cyOPpcCLWHtyUFu/+/+qLK1sWp8wkJCC
 oKaEqxzzc/XS9q2+/XrHmT93+xlVoS5DxW29lf/kVCcHjpO8ZU0fVURRKgytjDyZ+wkg
 HvIkM2iH9QQIVZW4l/cXFvFIdKlt3VeXGwesOJjw7K1mKDHHk4hmeMURaKPH6GKO0TUm
 uyUj2bsaT4CnYM20ykAwAfIV3BosqcU0jIrMtx6mGASJn7TLsFYUNCo2oWHehHIwnXI7
 YDkA==
X-Gm-Message-State: AOJu0YyCKjIUZofJY4mEINnSsBkILmWFbeyKMB2e5zhueVonx/sCm6eA
 LujkzHTGd8WOv3ZM/MRG9+bh8HvrE/PZmlni4yCIZW5YLLy4nXkheMmXvkqeaYqleUGD4uKIai1
 1QtTT
X-Gm-Gg: ASbGnctTWyAj94WnKDAy1osfz6YnpO2QvLr5GroZvX6iS9DD+As2QZTs+gcQ8R4/lsP
 zmau2lCsicNi/fbsG+a8ePnfxcP9B2tM/48Ti6rtsiZ73Ly6ZSVUSJbuC6TBB0soKeg41qF5bmN
 zWK1aphM3NNy7QaZTm6O53wkXpTb2jaRudKwTUTRho2JAhz9rertKkVPAwV/3v5L4SOIGFgoiBF
 DHxDaRuh42TDGUjZIfA6WaDXVEa0QTGhClj4+L3ArNrc5A2JGGY/a2AdPqiDvapzqruMopXV7HB
 MCrJ0eCMrKmrL5lQFkgUYf/ullmUgc9Zt3uoVA09WMppf/zydNSxWd5bhb4cBK4Dl8wJwMLvooh
 vZqq256V85jnL/GFVsXCBDC2AECPdNHtA75iH5P4QG5nBeu1fMxEEOlUy96IhBUkjJhDXG69/At
 Vc1rx8TU3VXuj1edzy54vwiLgtYWKUYh8bIpI3m0g=
X-Google-Smtp-Source: AGHT+IGg0TxJ6DQne619WiG7U7kaIRDuJL05SG95maClGbwrt4qq9PXS3SAN5IXPmXJSk1iFPktjgA==
X-Received: by 2002:a17:903:244d:b0:296:3f23:b939 with SMTP id
 d9443c01a7336-2963f23bebbmr33554055ad.42.1762376821586; 
 Wed, 05 Nov 2025 13:07:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650c5ee4dsm4725895ad.45.2025.11.05.13.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 13:07:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/2] pcapng: use alloca instead of fixed buffer
Date: Wed,  5 Nov 2025 13:03:58 -0800
Message-ID: <20251105210657.871310-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105210657.871310-1-stephen@networkplumber.org>
References: <20251105210657.871310-1-stephen@networkplumber.org>
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

