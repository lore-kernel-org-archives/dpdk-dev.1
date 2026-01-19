Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77D7D29C58
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 18:20:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 337E0402E8;
	Mon, 19 Jan 2026 19:20:25 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id 180AD402E6
 for <dev@dpdk.org>; Mon, 19 Jan 2026 19:20:23 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b5ed53d0aso6450559a12.3
 for <dev@dpdk.org>; Mon, 19 Jan 2026 10:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768846823;
 x=1769451623; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aivX3hAZGMb9LR8PvNtPoBr+tF8UrSE4dH0NUjz8e8Y=;
 b=kstAnVXz40/2/F96YDAlV75my2fecx4zShNSzf1GMFxJ9Q+xa0CJZeZ5RCy0jsXlCR
 DmGuf/qNgEodPgV8WpkOL8sFfjRyJRHhUlq8MRYnTtihQUync3a0DLyBQEho1/MEvVwU
 ujDpgZikp1Zp6/W16g02BZ8Pw2Cx3TUSJd92BjUmqgMKmiWwrF3/xMzaK56i/dlbayB2
 zYa59Lxw1wzaK/Utkff3xvQkngnYZw5IJy+Zfq4Yt8s2RNMwvhuJBaE3LKXuJLqa8PTG
 a6ALRoa5xhPWnYuVueySamBUQM5INff9kWMYQPz4ZrX5kx+qifylkZkc7BY0w8jCDhIZ
 u07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768846823; x=1769451623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aivX3hAZGMb9LR8PvNtPoBr+tF8UrSE4dH0NUjz8e8Y=;
 b=rGz1t1hi+eJcvEcUYyAyFOiaaJPeGUJHPe4eRHKrLk1iCMK4G0XcD2VnuDujPS8ton
 Oy17R6k3L7bb+WdiVG6WZ+/sLtemUKjWFRxIi3RVLpnQLQ+Ar4dFHTv3lg+KG42fMviM
 OOx+0BK/P37h92dnLsMBHBKcOPu9cYHYLsJYL4WWeA+gNUp7Oehte5qkIA1QtGwyo2Ea
 AJ7bmMxXQ8K8z+3Va491GHSICzAsMf+K4iyNzFYNTP52c7XuvPfusUALv1PrcTev27nW
 oJ7BMvkSPZM7osJROHEuEnaJLlkqMymONd2bNuBp8KqWtbJHHmmiGHg+nyseVL1lYdmM
 DiPw==
X-Gm-Message-State: AOJu0YxHlW3dv8GVB7BczbQBy1F8KQw0NXax2vOpxR3qtxWLadkmLkjc
 O10uu8eMmXtNU8sVf242CyzTBE8JSdvZhdY2SOYSlNYB8EK0Sa8TtyeK72LaKxleqPQaF2nHJXL
 4FY8h
X-Gm-Gg: AY/fxX4FPCVY+PnqFG1Hdn0gJpTATWnSSDlI1ypG4gnU//DNnwkFwf4z5VDkB+iDfoF
 rwpg4EjV1PS0TcPUD3tnZ7JdAvgrUwZXPI6kGSUrsDzJzIA0tOE57jqFffpGxGXAnj+5/onF3fG
 NAfy7P9nRh/ndxSqs8CSj2gfYxjkHDL7Ff1QiHyKMygIn98UhZRYvb8WX9EXlqs6PYiGnu4Dna0
 Xjp6jbLE0/pY+yozL8SVLZBcc+nrjjxneL58aFqJcyVcuvrJPvfeWO1Dd2dmnpk9yg7umB9wSsB
 h8P6EMeZfrGzyVuV2pyBZxqkGtRlhVImxdLSuE2Z8PGuoEm2ju/eeB/nM6vA6yzW2GqDLVFmOTD
 dPohF5jyHIIo1E5TEAH87IQQdI3E7XP1t0yIlPnA4UUW5E0GUFEsThdvEYfpCqpPi9BWV7OwBiW
 sJPgDx4M5r/+mbp6d5l002z8VwzqTNOa5wUdME5sHEe+PIZV9RWFI2hignHg0A
X-Received: by 2002:a17:907:d1d:b0:b83:32b7:21b0 with SMTP id
 a640c23a62f3a-b8792d65c51mr1067706266b.17.1768846823077; 
 Mon, 19 Jan 2026 10:20:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdab55sm10878829a12.10.2026.01.19.10.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 10:20:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 1/5] pcapng: add length checks to string arguments
Date: Mon, 19 Jan 2026 10:18:59 -0800
Message-ID: <20260119182016.44769-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119182016.44769-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260119182016.44769-1-stephen@networkplumber.org>
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

The pcapng file format has a maximum possible string length
of 16 bits since information is recorded as type, value, length.

The API should check these lengths before possible memory
allocation or overwrite failures. Update Doxygen comments
to include return value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 33 +++++++++++++++++++++++++++++----
 lib/pcapng/rte_pcapng.h |  8 +++++++-
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 21bc94cea1..ac46e43b38 100644
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
@@ -337,6 +348,9 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
 
+	if (comment && strlen(comment) > PCAPNG_STR_MAX)
+		return -1;
+
 	optlen = 0;
 
 	if (ifrecv != UINT64_MAX)
@@ -489,6 +503,9 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 
 #ifdef RTE_LIBRTE_ETHDEV_DEBUG
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, NULL);
+
+	if (comment && strlen(comment) > PCAPNG_STR_MAX)
+		return NULL;
 #endif
 	orig_len = rte_pktmbuf_pkt_len(md);
 
@@ -693,8 +710,16 @@ rte_pcapng_fdopen(int fd,
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
index de1bf953e9..4f085f5c86 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -89,6 +89,12 @@ rte_pcapng_close(rte_pcapng_t *self);
  * Interfaces must be added to the output file after opening
  * and before any packet record. All ports used in packet capture
  * must be added.
+ *
+ * @return
+ *   - (0) if successful.
+ *   - (-ENOTSUP) if support for dev_infos_get() does not exist for the device.
+ *   - (-ENODEV) if *port_id* invalid.
+ *   - (-EINVAL) if bad parameter.
  */
 int
 rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
@@ -192,7 +198,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
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

