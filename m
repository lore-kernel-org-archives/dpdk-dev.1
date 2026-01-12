Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19E7D2502F
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 04:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1AC9406B6;
	Mon, 12 Jan 2026 05:54:08 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id A32A74028F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 05:54:07 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b921d9e67so10226886a12.3
 for <dev@dpdk.org>; Sun, 11 Jan 2026 20:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768193647;
 x=1768798447; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iuv3LJDzK9GajXQzwnSKoPqRBF3oNEKaIMxGCjcwkWs=;
 b=pVF6B2miXU203jJHuCyRCaChrVEJt3U5MPN954pzIVczPZk5yd2tgLmANWjSAOxw9z
 bsaqVOMxXSv58DME9rLjYr7iitB9bvKSK/OTzCMKCDiS9EfOqPQ6Ywn43XXjOqlZgIqt
 bt+Ve0397gWJ+gkRNPRRKd0bh0c5wSe2Os86jY4U1VnRQS9xP1t70S65bTC1YgBjBylY
 a1E3XRwoDzwzHnUk908KuZLehVq26JfoIvBo7KLpdTripmnBilWLWjBGYLN3kN8naX4b
 1Q8VytZ4Fc53D6fGkoq4tcgeyBvL0OlbX3h8nKg8g62G/v4PY3r5cqgLWUdjdGWs1Swi
 EuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768193647; x=1768798447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iuv3LJDzK9GajXQzwnSKoPqRBF3oNEKaIMxGCjcwkWs=;
 b=MwBAiHv5HRkYXQOEi1AJkfXhtrmAxD7NMm+kcLovfh2G0w8y+wfmrCktQLAilDn5eA
 EJj4xmJgoPqNRy3Nz46KnTzJyLHn9+Gb3uNyaO+ut2m6TneVB3Q6pXyVOWTuPaVPji0E
 2tvyL7CmeMSgRjXLTC+XwbteCtGgM2p0edYcogfY60lYRpX3qBKj6W1JziCaVOHokHNa
 htZDljRgzcC4OHlK4zZ5sZtWo2eo7al3o4ejlODskFTFOAi77/m3Hc20pHwItwOBuUCI
 CyuL1xFgpo1o05n9We02m5whTBc/y63gw7WUQIBgX2aqLorTUohVgkt06NXw1RcSb6dh
 mP+w==
X-Gm-Message-State: AOJu0YzGxrgoCKfoRTQL+wiBT2m5zhET6vLy7pIrVZSrg8v1VDAcdd6J
 1Vqs3qE7cjLmClCNzrbfMGel1yvez7cyuE+Jyt4rVrHiOh/rQVYRv5wid96+QIHj3HEDIfmBSuY
 VwcES
X-Gm-Gg: AY/fxX4ZXfpfiR5EcDm/ulFy1eo8ocLce80ZArQjpGVW0CadfvNsF9losamwgs5rguc
 NMMU+/MmfYrzPDiJjcn0xKQGYsc34EKgIrnu2T/hoJ0C59ceoAKIwQ7dTuQdv1wbb7hzbHNBIWj
 ntKVVWjyqDrb2EfotZvhUES3KPvQWLgqQQDIjpARA6n53RQQ7Gp2frZRugCT72vfhd9wlv+0lbq
 3r0+7L/6gGzeUNTN90s6xqEocdnrz0jbWrr3U6zbhMI8uee7vjw/B79WK+EKTwUL8t76EkDPkJg
 5iQfPpTkJPIomFJ/I6SbjBnfelX+ll9wfwPIxp7KLrYJFFi/MFSs/xkuiuS12ZqWw7lc5nchh5k
 4SPSwjohSBiP+Q0D0xvxHoKUsW0s31zvgFjvD2y9zmmpmfi/YElloBO9VlE9MM/upHMblEa3vMA
 3VZTHOnzrM3sru1PUgHfwsVr/zhnA6bgwZzX540hj89CxdX2Lgv4cRkpiN7HlI
X-Google-Smtp-Source: AGHT+IGh1Bo99l4vPFYZM2dsMhhm/jmf9bL910TPUNnh9pwTZwb/M33llYZZUQ6mVYDfU6d9qq/j3Q==
X-Received: by 2002:a17:907:e114:b0:b87:442:e9b6 with SMTP id
 a640c23a62f3a-b870442ee39mr323508666b.17.1768193646742; 
 Sun, 11 Jan 2026 20:54:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm534327166b.30.2026.01.11.20.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 20:54:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 1/7] pcapng: add length checks to string arguments
Date: Sun, 11 Jan 2026 20:50:14 -0800
Message-ID: <20260112045359.142999-2-stephen@networkplumber.org>
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

The pcapng file format has a maximum possible string length
of 16 bits since information is recorded as type, value, length.

The API should check these lengths before possible memory
allocation or overwrite failures. Update Doxygen comments
to include return value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 31 ++++++++++++++++++++++++++++---
 lib/pcapng/rte_pcapng.h |  8 +++++++-
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 21bc94cea1..863706a365 100644
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

