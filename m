Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F658E8383C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 21:43:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A17B540650;
	Mon, 16 Feb 2026 22:43:24 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 5B6FB40648
 for <dev@dpdk.org>; Mon, 16 Feb 2026 22:43:23 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so40282055e9.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 13:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771278203;
 x=1771883003; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWzZ0ylMa3Aw9LmsVQKJsR34wEyOp0s2PyrmPXYT/IE=;
 b=eIuLJmQGbHISahsaND/gZdcUFo5D7FhVywIGgT8zFX0f0c31LhENYqQBU5U5uT5dEB
 TNStVL++BqoBiowdggs5IIJP1VM2m7M2ExYqQhI3Q67NRkIuOnZkh2xxl2XlGSiddaFx
 XP2E4jJLFDgCYdhbnt2wCvS0hCbaPpy3GvoC8y5n5Q0eDTVxNfuUG7H+vCtXDLB0Xbcr
 3WnUNIgehqMCvAma4EEh2Ip8HwqFD0CxImANuSDW6EPoSQG5j14R8vwQx1GiWn9Rxj+p
 Wf5lmeSSvRPwwMXMKgkqwjltMMqaCd5p0W/eJnA6VAaNkHJRQd0+ohG0y/iuM7itKvhM
 xRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771278203; x=1771883003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EWzZ0ylMa3Aw9LmsVQKJsR34wEyOp0s2PyrmPXYT/IE=;
 b=uG+IGiZHzWOdSyrIqA7UODpwtCI5PNeBu0ugdJRGKj3Y+K9vcWiQAY2rKLtdLmFpB3
 9SOtfQ+SAFr/NzFpAOekk52ymndQEuYVPUReerdMUm5MZtVrKmbmh0eev2LjO04DCp3f
 oHRhF0xMkL7KXVBCR1AkPHkOJlhD/4gT9tFkSy+YsmNAHx832FYd8HbzrQl0wFfg8dc6
 f+Lh1m978hZhuDYgRIsB7PQkIYmceCd9GGWfGrx1V9tALkSbGpxX0yJC0FCz9gNEamWQ
 OK2qZM4nF7zRXr2HqWYh+rDOBrfzJiN4VZSYcbN7xTyaas4bc9C9nCQUjq/rGCahoyRK
 KhcQ==
X-Gm-Message-State: AOJu0YzuS2wZhDZUo9f7iDpxcoukeOKn0eohC7hTvo1+7j19TDzFQCVQ
 VEmngQLeRXxWJ/edPEm0mlRpL550qMXAasWdebnL/Ztyk9NPbLWlRH5MmwXmnqSsBgZI3Zd4xU8
 P/8w0dRI=
X-Gm-Gg: AZuq6aJEL3C9W77fNl77mZMFfQzF058TWuys+3iRI3bUWR32M6HrmboBLY+JDnbLt8b
 YE23fPeNMGuImVr15SDbwB+sQ6+w/CgRAAmwjZnBTVRc9InJZsqK2fVdWLS7gh6QDh9uwR8033B
 Nnanlgxwr2KVE4CE3z1enSaCRnzl09Qwu6TJ+Nf8poJvKvMMrOnhGFEyrQ2BUqvJQrZXHoZzeAt
 DUdNuhN8rZaAHQajZVojexu68QHZNlWz8kzyOjGMjJUj+WG0aL02VXALA6R8j0LzEDa04lV/h5d
 SG4DNIxTRErlz+TmfIUgt6dX39fgXX8tvBPpY4jodAHB30y7i5Y6m3rdHRPQpmp5SjP5dyd65iq
 ik4fE3G4ETGbPzdvtwt1EjQt9iSiDyhA1zQKAjKpfgOVEgPlv0//J9dDJIFzXeZ7Tfv6f0WD9Iz
 ZaNA5k4E8k+m89+PE/rrDAKITP3yRsBOcE5cOmYS5f1fKlyWm9k5RXtq1c5Rk4sA==
X-Received: by 2002:a05:600c:8183:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-48378d9ccc7mr160870945e9.9.1771278202908; 
 Mon, 16 Feb 2026 13:43:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm32146354f8f.3.2026.02.16.13.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 13:43:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 3/8] pcapng: add length checks to string arguments
Date: Mon, 16 Feb 2026 13:38:00 -0800
Message-ID: <20260216214311.717492-4-stephen@networkplumber.org>
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

The pcapng file format uses a 16-bit length field in the option
TLV (Type-Length-Value) encoding, limiting strings to UINT16_MAX
bytes.

Add validation for string arguments to prevent silent truncation
or buffer issues when callers pass excessively long strings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |  5 ++++
 lib/pcapng/rte_pcapng.c                | 37 ++++++++++++++++++++++----
 lib/pcapng/rte_pcapng.h                |  3 ++-
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 39f381e561..eea01e44e9 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -148,6 +148,11 @@ API Changes
   * cfgfile: name must be less than CFG_NAME_LEN
     and value must be less than CFG_VALUE_LEN.
 
+* **Updated the pcapng library.**
+
+  * The length of comment strings is now validated.
+    Maximum allowable length is 2^16-1 because of pcapng file format.
+
 
 ABI Changes
 -----------
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 5789c2cdca..914d6e7095 100644
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
+		return -1;  /* should be ret */
 
 	/* make something like an interface name */
 	if (ifname == NULL) {
@@ -230,8 +235,14 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 			snprintf(ifname_buf, IF_NAMESIZE, "dpdk:%u", port);
 			ifname = ifname_buf;
 		}
+	} else if (strlen(ifname) > PCAPNG_STR_MAX) {
+		return -1; /* ENAMETOOLONG */
 	}
 
+	if ((ifdescr && strlen(ifdescr) > PCAPNG_STR_MAX) ||
+	    (filter && strlen(filter) > PCAPNG_STR_MAX))
+		return -1; /* EINVAL */
+
 	/* make a useful device hardware string */
 	dev = dev_info.device;
 	if (dev)
@@ -269,7 +280,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	len += sizeof(uint32_t);
 
 	if (len > sizeof(buf))
-		return -1;
+		return -1; /* EINVAL */
 
 	hdr = (struct pcapng_interface_block *)buf;
 	*hdr = (struct pcapng_interface_block) {
@@ -336,6 +347,9 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
 
+	if (comment && strlen(comment) > PCAPNG_STR_MAX)
+		return -EINVAL;
+
 	optlen = 0;
 
 	if (ifrecv != UINT64_MAX)
@@ -487,6 +501,10 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	bool rss_hash;
 
 #ifdef RTE_LIBRTE_ETHDEV_DEBUG
+	/*
+	 * Since this function is used in the fast path for packet capture
+	 * skip argument validation checks unless debug is enabled.
+	 */
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, NULL);
 #endif
 	orig_len = rte_pktmbuf_pkt_len(md);
@@ -535,8 +553,9 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	if (rss_hash)
 		optlen += pcapng_optlen(sizeof(uint8_t) + sizeof(uint32_t));
 
+	/* Comment is silently truncated if necessary */
 	if (comment)
-		optlen += pcapng_optlen(strlen(comment));
+		optlen += pcapng_optlen(strnlen(comment, PCAPNG_STR_MAX));
 
 	/* reserve trailing options and block length */
 	opt = (struct pcapng_option *)
@@ -577,7 +596,7 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 
 	if (comment)
 		opt = pcapng_add_option(opt, PCAPNG_OPT_COMMENT, comment,
-					strlen(comment));
+					strnlen(comment, PCAPNG_STR_MAX));
 
 	/* Note: END_OPT necessary here. Wireshark doesn't do it. */
 
@@ -692,6 +711,14 @@ rte_pcapng_fdopen(int fd,
 	struct timespec ts;
 	uint64_t cycles;
 
+	if ((osname && strlen(osname) > PCAPNG_STR_MAX) ||
+	    (hardware && strlen(hardware) > PCAPNG_STR_MAX) ||
+	    (appname && strlen(appname) > PCAPNG_STR_MAX) ||
+	    (comment && strlen(comment) > PCAPNG_STR_MAX)) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
 	self = malloc(sizeof(*self));
 	if (!self) {
 		rte_errno = ENOMEM;
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index 8d0974c3fd..68e13c67e4 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -127,7 +127,8 @@ enum rte_pcapng_direction {
  * @param direction
  *   The direction of the packer: receive, transmit or unknown.
  * @param comment
- *   Packet comment.
+ *   Optional per packet comment.
+ *   Truncated to UINT16_MAX characters.
  *
  * @return
  *   - The pointer to the new mbuf formatted for pcapng_write
-- 
2.51.0

