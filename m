Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D78D1951B
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 21:06:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 706FA40673;
	Mon, 26 Jan 2026 22:06:29 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 01F954068E
 for <dev@dpdk.org>; Mon, 26 Jan 2026 22:06:25 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so12895825e9.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 13:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769461585;
 x=1770066385; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyKflly/u10qv0B5eiGruVhDnKnXsmlsYEyxqOpphPY=;
 b=Neo8hk1excywB6Hdi618ZYag/bIcgiXYduyzj9WsZifGi1OmMDVXNfazfDhJEnUV4j
 bYhecUzXzoOxVMuZzi2aO4Ugk47ZbHb40M9s39HfrSuOY0uW+Uyx76C8Dzy1cWcUpYfu
 VFSx7hxgqwYNEz1MLKLAU/u9gC045CVL3J6abFHbfxCH0+ZyCbS60FqDhVC55oEshFT0
 +3Q/DVkSgLSgIylRfQOj+KdpkES3kaUGOgsPOaXNTLaLPpZVq908FMYaaJXFMLD48TfL
 rGMUaCsdJzbfGPNClSwsW3dp8EDPWprP/Wp103zodSClV7sGC6MHHNlVfnpk076DJ+J8
 kQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461585; x=1770066385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TyKflly/u10qv0B5eiGruVhDnKnXsmlsYEyxqOpphPY=;
 b=Xv6lUQkzBhNFljCjDLubJhOHMB70vs+fgq6+W+CQW16+Q0ymyytmxblUbHqrIMPmuR
 ZHqsuj9zOpj2fpODqoOs5ka1y5yOSWMHACmGD3ZFifPTxIOtYw/WlhIp3jGjQq80Ym4M
 VYM52Btw+HFu1/IoPt7oFQs46ZB4AVneT1R4DccGWZX883P2/h8jLbrybdu4BnilzgED
 kfYvmJxrJs7ZnQWjhpX6QMq44O2VNCcwk5U1t4TFSfZrOeoLh76IOogW0UiVMJ4g1Aoi
 g0dgh0Poj6AwYTzT7/lQ/HMSekFGEIk57xnH2KVGYZsydZtGlXK8MLEnysIMvPVE4acN
 s0hQ==
X-Gm-Message-State: AOJu0YyeYYg7i5g6V2d5awC5lueMrvAvQkwn2dTvW931GAdtFkQrwJJF
 5Jv2BIMeYQ5P2v7o/lF2JJsZBCTpYz3BtyPfXIEKwrVkAzB5P7Z2I3csu9Tk6Sq1/Y64VWw7W4C
 UNPW7
X-Gm-Gg: AZuq6aLQsjAQWvjUEwC3y0xkoqBWBnQcQ3n8+3VprtqqoOpKYUKXO047+517sqqSHA1
 qjDKbdFWQHK0wRdKYp6XYH4pw7ruMWqJyY7nBslI4WiC8koIonr6HGDtgLcm2Xk1voSAJn9y0g5
 kiz2I/vGNuBFpbMsxuFeG9g7CBhQZbr2Ub0ticJAqVSgKFfBA/5nzqu8YfiTDIWZLkYtHJKsaXR
 D26JAq87S8/qoGiQM805Anxon7dllVzKcpdKuJnWsKE4De+ZEPMJm9EY6l/PzLOb/z/uvnb6LHJ
 xzA917YuKZvOcZO5DaEmDeuvMChY5IV7sc4cDgfqyYJd7II7b0zcS7pbkCKJGijcdY/xIV9Tu1q
 j1TTIbeVn3wwp1ngtqutAVoN+QT8sOiVn2YqYOXJFz+RXhaJYii7as7N0ffn2qqIk+mcnYV6/NQ
 L3UT0OIhHxonh2yXzwpuKeDiJAF1xjVozjnXZfLdybqJHbHZP3Ig==
X-Received: by 2002:a05:600c:4fd6:b0:480:1d0b:2d15 with SMTP id
 5b1f17b1804b1-4805cf63e02mr91673505e9.27.1769461585433; 
 Mon, 26 Jan 2026 13:06:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7704sm15166915e9.1.2026.01.26.13.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:06:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>, Ray Kinsella <mdr@ashroe.eu>
Subject: [PATCH v6 2/5] pcapng: use malloc instead of fixed buffer size
Date: Mon, 26 Jan 2026 13:04:35 -0800
Message-ID: <20260126210615.175816-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126210615.175816-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260126210615.175816-1-stephen@networkplumber.org>
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
 lib/pcapng/rte_pcapng.c | 39 +++++++++++++++++++++++++--------------
 lib/pcapng/rte_pcapng.h |  3 ++-
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 61d37b4462..d5b3a0cd29 100644
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
@@ -165,8 +163,11 @@ pcapng_section_block(rte_pcapng_t *self,
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
@@ -199,7 +200,9 @@ pcapng_section_block(rte_pcapng_t *self,
 	/* clone block_length after option */
 	memcpy(opt, &hdr->block_length, sizeof(uint32_t));
 
-	return write(self->outfd, buf, len);
+	ret = write(self->outfd, buf, len);
+	free(buf);
+	return ret;
 }
 
 /* Write an interface block for a DPDK port */
@@ -217,7 +220,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	struct pcapng_option *opt;
 	const uint8_t tsresol = 9;	/* nanosecond resolution */
 	uint32_t len;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
 	char ifname_buf[IF_NAMESIZE];
 	char ifhw[256];
 	uint64_t speed = 0;
@@ -279,8 +282,9 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	len += pcapng_optlen(0);
 	len += sizeof(uint32_t);
 
-	if (len > sizeof(buf))
-		return -EINVAL;
+	buf = malloc(len);
+	if (buf == NULL)
+		return -ENOMEM;
 
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
@@ -326,7 +330,9 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	/* remember the file index */
 	self->port_index[port] = self->ports++;
 
-	return write(self->outfd, buf, len);
+	ret = write(self->outfd, buf, len);
+	free(buf);
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
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 
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
@@ -398,7 +406,10 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	/* clone block_length after option */
 	memcpy(opt, &len, sizeof(uint32_t));
 
-	return write(self->outfd, buf, len);
+	ret = write(self->outfd, buf, len);
+	free(buf);
+
+	return ret < 0 ? -errno : ret;
 }
 
 RTE_EXPORT_SYMBOL(rte_pcapng_mbuf_size)
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index d866042b66..85abf1d93f 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -196,7 +196,8 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
  * @param comment
  *  Optional comment to add to statistics.
  * @return
- *  number of bytes written to file, -1 on failure to write file or memory allocation failure.
+ *  number of bytes written to file on success,
+ *  negative errno value on error.
  */
 ssize_t
 rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port,
-- 
2.51.0

