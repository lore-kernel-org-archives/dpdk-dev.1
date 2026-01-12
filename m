Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F750D25030
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 04:54:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF9C8406BB;
	Mon, 12 Jan 2026 05:54:10 +0100 (CET)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id 3BBAE406BA
 for <dev@dpdk.org>; Mon, 12 Jan 2026 05:54:09 +0100 (CET)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-64b9d01e473so9924633a12.2
 for <dev@dpdk.org>; Sun, 11 Jan 2026 20:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768193649;
 x=1768798449; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDdue5NnT8vGqMvdHE0wnDDxGpF0zEbxL8PVq5ZpE0M=;
 b=XG6ZwQBmOQFq69gOauU2Itz5S7MvngCIBYCbO+NZvp9DOGvRJG+cn0ZTIuUqvfqCCv
 TRl1hntg8Wq1/d5KSsWNtJfZLKSoDpKqpKtHIQiKYrj9DloGMjSEQls785P8Kd1p5YVS
 1ls+FxSv9TDkMQaM9eAo59x12hHwQ3WH5vUbFuzcW8Xd4S9hHYVlrriGT4QWJGxYgJuz
 5BX/mnz8gl2uzL1O0nGj1LrW5fD/fYWs+GOKElzbrGFGz+bmm0ILBAMpVeP7MxMl4C8Y
 V3dAOZuTh6GYAJ1kHEsEwPYuRt7M4rb60PpL7DMY1b4npCKk+GdM0hedGqyp3r3J2KPG
 lMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768193649; x=1768798449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CDdue5NnT8vGqMvdHE0wnDDxGpF0zEbxL8PVq5ZpE0M=;
 b=bCDj9HoW7+pgNX5iDqjsEtHKHvwxSiF6NPh/i4KWHI/qgiEKFRYbnPpuOUwZ3HEnQc
 sBZhjFeIYPga89E22DP+mgrrgNrQXECorns1G6qniFehQ6DvWw2epNSHyNgbXTi/6pkw
 ExPFXXhtm2x/BtcZHQPWI9icowiWTBuqK30LwanlaiLbnguW7EISnNOKwQIrJnxFt4Sr
 G2BKSQyVNaxbb9tKTw3IA3OTaYaGsk586hgTpR8nyfiOZzGUncY2P+qxmY2b5lPZWkrI
 Tw8930AxGfxa6Caq+vWRcT1Fs4pY17nsOVD/zcieBLkaCh47e+jDTZSnqvhqf2f9YQg2
 BhVw==
X-Gm-Message-State: AOJu0YyjwsVfUwyEAtjfz7vzO07aGbIQo+q8+NxXWNC0ZrD5afnz8sfu
 XO9FHHfuojuLMMNxDkmB99Z+unbIOEbufOPuWZlHm+sYAUKt+2DwLnW09h1Xw36pB121qm3YS8M
 DLTA5
X-Gm-Gg: AY/fxX6h8lCw/wijqfSlSRjqn4W3QyxqIp5DwkoAt/TC+rP/C4jUoe7bLz6nJ2Kj9o2
 k+OI1vlOV/B4KhZwJqncLRC9PK270Ljuu1Gk0/FJV8STzr1yQo67tOC2u1xxDeTZ6iR2nj8aire
 /VECpnOZm6aONNsd5NuXm4iuUrJQIofvxgRooP3rPVti7XXs9Wfj6U2Lucqk7ntb3Vslfsas+Wh
 7xQVRadxbUNnwPwlcITkI1iEMaPx+fnAPVaPquZjWslwOAZH9W5S8rtRFZP3PcFczfxz8i1aRbA
 jqO8XddX5YWgTrDteiRvnn2qfR/EWu9DcQR0YZT/8MNFddWm7rkROUSoOvRy1NCeBcvCf6HYUGC
 E1rofHsC/M0aaOOQ3b7yFjm0h9xVPGfVLo51E1gUQseCKikZKudVHowzhx3tOdgxmSU6BaHpJFM
 i0+PabjrAeYGLN6SGao/2fYsR+jky1XHwu2TvcMJ9mMlf0C1CYpw==
X-Google-Smtp-Source: AGHT+IH8Bw3CiyHcq752jjOVGriv4vPS0ii/vvIDsPqi0iQUU2kOH0mmZOqGCSclMCVa8LDdsDA3FA==
X-Received: by 2002:a17:907:980e:b0:b83:3294:9c56 with SMTP id
 a640c23a62f3a-b8444c4d0bfmr1715260766b.9.1768193648780; 
 Sun, 11 Jan 2026 20:54:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm534327166b.30.2026.01.11.20.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 20:54:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>, Ray Kinsella <mdr@ashroe.eu>
Subject: [PATCH v3 2/7] pcapng: use malloc instead of fixed buffer size
Date: Sun, 11 Jan 2026 20:50:15 -0800
Message-ID: <20260112045359.142999-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112045359.142999-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260112045359.142999-1-stephen@networkplumber.org>
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

