Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80988EF99CF
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:20:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A33C840654;
	Fri, 13 Feb 2026 20:20:49 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id D1AAC4064C
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:20:48 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48370174e18so8701565e9.2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771010448;
 x=1771615248; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iU5ZcLNclmvZG8SAnHrzS7FTXzHUEMPBJOjqowxSlmw=;
 b=nYYofKzM007PuH92LcyVDwoVCUAQhz8mDSsEMnNcYRfZo+MrBQONNQIVptV871KZA+
 pm6SyVRX1Wys1Hyp8ji7XO27h2TGyZpCYDMvYZ0Kx4RkMQfA7JWtEohTKHxWuORzHqv9
 sLbAAXYOhB9LsxF/qTu2j2eU/sGQOeQvFY1Cm0MgAVL9oh11JBb/zyY5a2ow5dUFr9MN
 PK4rsVvKyV2usZ/J3Qhvz5JyCheRPFDkOL4Q5Srg4HqRE6ytTiYhk2GzP6548J4JqNKx
 NVN90T50buK51iokcdJefU1N2hiK37WxsFabepyUD88CJZbw0xHsYhi1btWMqJ6Ol7m7
 94Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771010448; x=1771615248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iU5ZcLNclmvZG8SAnHrzS7FTXzHUEMPBJOjqowxSlmw=;
 b=QoVbWanTk4bwojUk1S2d8xVfzjLJhNdZBd/lkXdRYtBx9iq4AoEII5G+/WkcS4cw2R
 yw2gGrMCTOI//pEyO2KF6exuNQM39kRw+wBSpH5hJa5tQhw/t8GWXiHOovggXGzNhGG7
 cvl4XAlgnuRWIjLW+SrJPvXZA+LkhT5zqIEtUZOKNMG3FqE7myaV3+m0fT6LaQJuf8FK
 nfSH48BFzn+1ivBIoWDQ0KYscZryxDnAEXxm2G2TIjy3gd8Jpz7VNgNqo5LCBPkS5y+r
 WE5k8eP9wszU0DIFf87CLj5UeIFHJLixfB1UWhEMD0SuXBxg2C+T0o8sJ1iqSsFeJuZ+
 bK6A==
X-Gm-Message-State: AOJu0YwYoUpQGXMBaeen+hbAldXVTWYUdY+JIClJ8WgWELKPROZCUiqu
 jCa08rMSl8VJtG3OEKQ6+lwwNWIRVIxmG2GaIDvw/c3vihyJIpMc52Xzw08dSWGTBdBSfKbBwL+
 Plice
X-Gm-Gg: AZuq6aIct9/UMcbINjNeQlIywzFkNSS8GWlGG9LqqkmFS11/9yqlIgbBL9BVpmZANEC
 EIQELJSsEjCNCGQVmveNfJnndYw/41XMDxe2sr8FHFV1/13V2VRc61b6b7B+5zG8Tz9XKAy5cCj
 UcOQery6QNMhoC14Dk0ZsSoTekIedbGxvURvwo75LcACcEblrRBb/vOjGherCeKUxwUtKP66viv
 lZFVURLDn9RVNsj/kQySG25HuLk57bMwq+ZmxpIX7T3+67IX1AYJMn32/dIdUIlaKhx1mBNfk1O
 ExKTRwj1uMjtvfH/brSxtebl+Lr5FwNQDTmrED2WY7DoKMMjUuyHHA/rWxClmW5I2SgmoTCsgrv
 83ed21tmzW6wtILdJCpb0dOapmxdM9bFN3vIt/wqcn+lQp7Aaxv43YLQObFZwFG4M4PANG0P/Pv
 TUrhCCZr42b+nc8bhs+UtLODL0I/qspePTKPbcuTjbEudSuAtoBxzoOrn3PHUbBQ==
X-Received: by 2002:a05:600c:3496:b0:47e:e779:36d with SMTP id
 5b1f17b1804b1-48379bd72a9mr4861895e9.23.1771010448287; 
 Fri, 13 Feb 2026 11:20:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm7758723f8f.31.2026.02.13.11.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:20:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>, Ray Kinsella <mdr@ashroe.eu>
Subject: [PATCH v7 2/7] pcapng: use malloc instead of fixed buffer size
Date: Fri, 13 Feb 2026 11:18:19 -0800
Message-ID: <20260213192039.221213-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213192039.221213-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260213192039.221213-1-stephen@networkplumber.org>
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
 lib/pcapng/rte_pcapng.c | 44 ++++++++++++++++++++++++++---------------
 lib/pcapng/rte_pcapng.h |  1 +
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 4ccf833777..413e6f1f4a 100644
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
-		return -EINVAL;
+	buf = malloc(len);
+	if (buf == NULL)
+		return -ENOMEM;
 
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
@@ -326,7 +328,9 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	/* remember the file index */
 	self->port_index[port] = self->ports++;
 
-	return write(self->outfd, buf, len);
+	ret = write(self->outfd, buf, len);
+	free(buf);
+	return ret;
 }
 
 /*
@@ -343,7 +347,8 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	uint64_t start_time = self->offset_ns;
 	uint64_t sample_time;
 	uint32_t optlen, len;
-	uint32_t buf[PCAPNG_BLKSIZ];
+	uint32_t *buf;
+	ssize_t ret;
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
 
@@ -366,8 +371,9 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 		optlen += pcapng_optlen(0);
 
 	len = sizeof(*hdr) + optlen + sizeof(uint32_t);
-	if (len > sizeof(buf))
-		return -1;
+	buf = malloc(len);
+	if (buf == NULL)
+		return -ENOMEM;
 
 	hdr = (struct pcapng_statistics *)buf;
 	opt = (struct pcapng_option *)(hdr + 1);
@@ -398,7 +404,9 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	/* clone block_length after option */
 	memcpy(opt, &len, sizeof(uint32_t));
 
-	return write(self->outfd, buf, len);
+	ret = write(self->outfd, buf, len);
+	free(buf);
+	return ret;
 }
 
 RTE_EXPORT_SYMBOL(rte_pcapng_mbuf_size)
@@ -712,6 +720,7 @@ rte_pcapng_fdopen(int fd,
 	rte_pcapng_t *self;
 	struct timespec ts;
 	uint64_t cycles;
+	int ret;
 
 	if ((osname && strlen(osname) > PCAPNG_STR_MAX) ||
 	    (hardware && strlen(hardware) > PCAPNG_STR_MAX) ||
@@ -739,8 +748,11 @@ rte_pcapng_fdopen(int fd,
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
index 2dd438842d..ff39fa7b49 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -200,6 +200,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
  *   -1 on failure to write file (and errno is set)
  *   - (-ENODEV) if *port_id* is invalid.
  *   - (-EINVAL) if bad parameter
+ *   - (-ENOMEM) could not allocate memory for buffer
  */
 ssize_t
 rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port,
-- 
2.51.0

