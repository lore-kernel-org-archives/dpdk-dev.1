Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85061D1951A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 21:06:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 335874068A;
	Mon, 26 Jan 2026 22:06:26 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id CABFF40653
 for <dev@dpdk.org>; Mon, 26 Jan 2026 22:06:23 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso42959595e9.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 13:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769461583;
 x=1770066383; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnX5FALhJhxb9K3/lzJapYTQbdUqnsGWASEY1P68vnw=;
 b=SsDAIjpnqDoB5x9H1pIsznjs3om6rHPOM/XZIbYM37OfDGWVDKRQCfy/CUcel0aSZT
 QF3t3Vgd/xQL5grdnlZxN5GT/7Pnljefbyzrz/dswBaaSP1r58BUaoEHQmbV1uU8MnJA
 LUDwz9c1oslAXt0JOaE9dMX3emyG6lxDe9gDb7QHP+jrZesI7Jni+IrQXnyWlSLCwmQf
 Bv0TcQObQtgCPQ3/PeB4IN78Dw7KCfLcl68Fa/rgu5qrrZHseHdG6Ga35A152Dc+fGDJ
 zPNX59vi3qEB3FfPobl6no7DYopY8GFJNMKs8qcNINnG2uVwsPCQaaQqWDVT2/p2Sxvy
 vCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461583; x=1770066383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HnX5FALhJhxb9K3/lzJapYTQbdUqnsGWASEY1P68vnw=;
 b=PJKOwhT63FDuFkXLoC5/djZsf3l5kgqgezg017MULhhcBEKa/wFANOUwpo5nOZoMgY
 UyMtkhQOFbakYzhxLFMMcLrl0pN2CHiY3K0yFInCqYU11Xzi8SzGQgjtWWfR0zA6V2g1
 WXEIeY9OXhBx0qJfBQx3Fc2Np9jnzEo5GdvTypUaqp9l1gYp9Y8H8AAGFliH0cLZtbk6
 x+7zs1TCPqZALooGvbvW+7lzA4q7ZcCXRG/Sv5pPwlMKbS9ay1mvmbl9ivhQBd2CzFUS
 JFNATUz4Z8N1NVKaKEfQdEeLENDE3NxZk72vb3kloWWKjCNg3QLm4DQAcagxiEbav9gd
 /+Wg==
X-Gm-Message-State: AOJu0YxKm5+PGQeS51+eE3e89ToRriakOIyLrckM6DyR7ijFFA6dPwOn
 txKb7JilMsxXrt2RDw5tCKNBnseJQemrbQEpRYKu6A502vIjbVPP3wu2XEvPBhAh7hiTgvkPlLn
 bvLts
X-Gm-Gg: AZuq6aJR3UDq74XTLRYc67JbwY0LQyX+uOjOoqaqN6+NYTn9N9QbDdb7s4r/yQcs2lJ
 0rMSE+yIrYAJceVRzWkaXLJ7o1H3leOXRjdPooPE/x/stW6/UYs7ZCyHSsWcSpozxdYprXPgWPN
 FPrjrLH6qOKRYHfo+Tp0i2mmyU14DzCGA1b0SOb3xz7CggKDtMP9rQ9VULx2HYjlYnEyJe+ZoXQ
 NPoHil/Vro5jDx0iZPOg41lMabcheU37BPmgIUEFYhvK7G3FKA+14W74OOF50Zeg8OtvJtnWJ1y
 JZvj1wh46/mxjFEqHFHDbOQozZw/jxBWi8WMzf13yn8kDTfVTYiqJdkcsUIimrity1iCKZ+mfQj
 q44VosOEMTJZyY4Rn5fAmrqu8muDqCiwTA/Dily5AtOhLNw3G/3+yxn1zl0aKUTJ3MaYFESzIoS
 69Aoim7iJycEtO/2Ykk7bYmgUqKClOjb0ExfJstgvybLEF6zzkrpy6wxdxK/Pg
X-Received: by 2002:a05:600c:5297:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-4805cd2026amr101188565e9.5.1769461583230; 
 Mon, 26 Jan 2026 13:06:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7704sm15166915e9.1.2026.01.26.13.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:06:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v6 1/5] pcapng: add length checks to string arguments
Date: Mon, 26 Jan 2026 13:04:34 -0800
Message-ID: <20260126210615.175816-2-stephen@networkplumber.org>
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

The pcapng file format uses a 16-bit length field in the option
TLV (Type-Length-Value) encoding, limiting strings to UINT16_MAX
bytes.

Add validation for string arguments to prevent silent truncation
or buffer issues when callers pass excessively long strings.
Also update the Doxygen comments for rte_pcapng_add_interface()
and rte_pcapng_write_stats() to document return values.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |  3 ++
 lib/pcapng/rte_pcapng.c                | 39 ++++++++++++++++++++++----
 lib/pcapng/rte_pcapng.h                |  6 +++-
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..0909be140e 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -84,6 +84,9 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* pcapng: The maximum length of option strings is now validated.
+  The pcapng file format only allows up to 65536 characters.
+
 
 ABI Changes
 -----------
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 2cc9e2040d..61d37b4462 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -34,6 +34,9 @@
 /* conversion from DPDK speed to PCAPNG */
 #define PCAPNG_MBPS_SPEED 1000000ull
 
+/* upper bound for strings in pcapng option data */
+#define PCAPNG_STR_MAX	UINT16_MAX
+
 /* upper bound for section, stats and interface blocks (in uint32_t) */
 #define PCAPNG_BLKSIZ	(2048 / sizeof(uint32_t))
 
@@ -218,9 +221,11 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	char ifname_buf[IF_NAMESIZE];
 	char ifhw[256];
 	uint64_t speed = 0;
+	int ret;
 
-	if (rte_eth_dev_info_get(port, &dev_info) < 0)
-		return -1;
+	ret = rte_eth_dev_info_get(port, &dev_info);
+	if (ret < 0)
+		return ret;
 
 	/* make something like an interface name */
 	if (ifname == NULL) {
@@ -230,8 +235,14 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 			snprintf(ifname_buf, IF_NAMESIZE, "dpdk:%u", port);
 			ifname = ifname_buf;
 		}
+	} else if (strlen(ifname) > PCAPNG_STR_MAX) {
+		return -EINVAL;
 	}
 
+	if ((ifdescr && strlen(ifdescr) > PCAPNG_STR_MAX) ||
+	    (filter && strlen(filter) > PCAPNG_STR_MAX))
+		return -EINVAL;
+
 	/* make a useful device hardware string */
 	dev = dev_info.device;
 	if (dev)
@@ -269,7 +280,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	len += sizeof(uint32_t);
 
 	if (len > sizeof(buf))
-		return -1;
+		return -EINVAL;
 
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
@@ -334,7 +345,10 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	uint32_t optlen, len;
 	uint32_t buf[PCAPNG_BLKSIZ];
 
-	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	if (comment && strlen(comment) > PCAPNG_STR_MAX)
+		return -EINVAL;
 
 	optlen = 0;
 
@@ -487,7 +501,14 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	bool rss_hash;
 
 #ifdef RTE_LIBRTE_ETHDEV_DEBUG
+	/*
+	 * Since this function is used in the fast path for packet capture
+	 * skip argument validation checks unless debug is enabled.
+	 */
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, NULL);
+
+	if (comment && strlen(comment) > PCAPNG_STR_MAX)
+		return NULL;
 #endif
 	orig_len = rte_pktmbuf_pkt_len(md);
 
@@ -692,8 +713,16 @@ rte_pcapng_fdopen(int fd,
 	struct timespec ts;
 	uint64_t cycles;
 
+	if ((osname && strlen(osname) > PCAPNG_STR_MAX) ||
+	    (hardware && strlen(hardware) > PCAPNG_STR_MAX) ||
+	    (appname && strlen(appname) > PCAPNG_STR_MAX) ||
+	    (comment && strlen(comment) > PCAPNG_STR_MAX)) {
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	self = malloc(sizeof(*self));
-	if (!self) {
+	if (self == NULL) {
 		rte_errno = ENOMEM;
 		return NULL;
 	}
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index de1bf953e9..d866042b66 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -89,6 +89,10 @@ rte_pcapng_close(rte_pcapng_t *self);
  * Interfaces must be added to the output file after opening
  * and before any packet record. All ports used in packet capture
  * must be added.
+ *
+ * @return
+ *   - returns number of bytes written on success,
+ *     or negative errno on failure.
  */
 int
 rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
@@ -192,7 +196,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
  * @param comment
  *  Optional comment to add to statistics.
  * @return
- *  number of bytes written to file, -1 on failure to write file
+ *  number of bytes written to file, -1 on failure to write file or memory allocation failure.
  */
 ssize_t
 rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port,
-- 
2.51.0

