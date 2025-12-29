Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60504E92FF7
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 23:02:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 347A5402E6;
	Tue, 30 Dec 2025 00:02:32 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id 78CA4402DC
 for <dev@dpdk.org>; Tue, 30 Dec 2025 00:02:30 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso1261746766b.3
 for <dev@dpdk.org>; Mon, 29 Dec 2025 15:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767049350;
 x=1767654150; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xFDGIABKehAqUGpvyqmRaLuugurynesvxqL+XBLOsw=;
 b=LKkVhTpaMX2gmDGRyLx1ROiS2LeGUZH9Cp5dmLNpC6DTwrmXOx6ilupaMbz9Bi1JRb
 feQnQdQ3G60Z3iD1IUMQqQ5Kmse5/Ko9LJf8Nd5UvUDZ1hm198bhXchpEMIr1vjZooxw
 C3Mdw4J6oRgYHXqPVj0PXyc4sQ9WuV7ezBj6pt6/fouKimPSI3A7i15H7duiivlRcAEW
 sw4F3jYHzl7EhRK4sFdbN8IC7919y05Vdps0CBrFOwBtcPV1PYxEIzsG7gWhfnExEiDC
 c8ZXyUusGE4Vez9TIn8lB8m57sRb+CaAHTOtXV/PkL82HRXr1zqfmL/nUSWT5KCOQ217
 bMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767049350; x=1767654150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4xFDGIABKehAqUGpvyqmRaLuugurynesvxqL+XBLOsw=;
 b=Vfr5cD9lkrR5WtVuH+cdho/eF/qh/4r6mz2/+QvCIlmBMOW5ve8VSSctgUSCvdvrcR
 CGtrLH1UGC5cOceKEcn8AbMiFiTxB3/7WQNpSalEiKnR4JTstxIxBk3bAx+8woHYCRU8
 6capupeWR11iB0YHl5FTXEkZoa9frWMrJY+uacvCCvUydFFG3FoHDgDp/X//RDdoIXJv
 c/qMajjiLMPzhb4JpOIvkFMKdLx8fNNJYIQb7o8PYly8iaUIXr5PDalaJEGyLWSILLZA
 ZnUoez6DFZXOpF76nY9Nk5pEcPH+/1uP0d+1cupbWWniH9S50S3PK3jBkC+pK3dTmPuo
 QScQ==
X-Gm-Message-State: AOJu0Ywc0YbIP9t1ohg8D8JJ12K2n25SXUysA8OApQIjGvA+AwaVrxY6
 lnpToXKb7ebqPTHLnFeOfGFiqTVjT3p6K5toItGTLc7Uq1URoYljLGsKeVOqSunZ54Wwat6DBmn
 3bGJxR8I=
X-Gm-Gg: AY/fxX6a20RwOuOfSnME10RKWE78AetTjqMA5N0ZVWbPezA3twj6ahyA7wdv+AWBYwf
 MI+rhzOtDIwCRu5sgniRopWevi/Qzh5aMYMmNX5F8Al0A+vznOtu98QrYPC00FvHHan3HHLumVy
 +MZL7IQ3MHp00d/gELY/lYi40+XZgR0ZCX5WCoHI3VWhSgfekSXyUKV9FWWEsaJW85+JiqKKRhv
 cx++Bhy3q5TqEyCAYgFCOofDyG/VA0nIC4Yt1h8vfG/8Jfl//aGveFgft5pIBi9dKXeLEjz1hk5
 1vzIQ0w/scaKF+FQQ1B3j/qnPfBu/g7iqZKzrURugVnzvMo8ITKi7bE77YTuhXJ3xJu9ORZqYqa
 BEkQap6UoBIvh98jeDia/zcvWqPw5J5CjapCFzwwuTtQkLienyYzn8J+tAOj77a4iU4NAhe0Xvr
 IKej0tiDYrqQIJ+ruqTy3IDFbq3XvzrQHiyjzxicHv1oimzNqf8w==
X-Google-Smtp-Source: AGHT+IHkOYnILGgQiAJ5VaRBOgFO+WAj8KHS1omlhepTmiNnAs31EaA6z1CkSSqr20VbvEEu7RvUxQ==
X-Received: by 2002:a17:907:d0c:b0:b6d:573d:bbc5 with SMTP id
 a640c23a62f3a-b80371a3da2mr3348121366b.37.1767049349635; 
 Mon, 29 Dec 2025 15:02:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b830b5fe8cfsm1933148166b.59.2025.12.29.15.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 15:02:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 1/6] pcapng: use alloca instead of fixed buffer
Date: Mon, 29 Dec 2025 15:01:04 -0800
Message-ID: <20251229230223.151874-2-stephen@networkplumber.org>
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

