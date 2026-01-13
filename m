Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14009CF45DB
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 00:52:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8813340431;
	Tue, 13 Jan 2026 01:52:03 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 414A140395
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:52:02 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so3989948f8f.3
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768265522;
 x=1768870322; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iuv3LJDzK9GajXQzwnSKoPqRBF3oNEKaIMxGCjcwkWs=;
 b=gLQgwIBFXLrCdzddwkhA4x+rrFnf1PyFJ3vIJejqXooDsa/XQ7ktBHyoJ2t1azhLJt
 hhNSY5Z2ttRpZpS5eB1e6aAARWnsvsJbFRHVu0X4+Fn4De7iUCHeFV5sarKrSv1aOjAp
 RD48Sf6VVMagBzIvvYSQZcrfl4btuFQOwAhbhj74ozV414KhpgASsguun6tE1WeOBqq3
 ltOrzLtSVdSMalbqJ2IMNxAngMff43tjjyDL6EfTlsAFWowe1+Fi5d6n7tGaV/wOVRY7
 BA0FLKll2EYMKS8vwjjUNy/VdIbAt+bm5pxb07jmpXEdrrxfUSv9gs8uKnfeugTKeO7G
 lUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768265522; x=1768870322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iuv3LJDzK9GajXQzwnSKoPqRBF3oNEKaIMxGCjcwkWs=;
 b=orx81iW8M8MOHt8CM5DRRBQIze2RAokS3N9yAovUSDCfNo0sVmrA44qyWpQwx9vbEX
 l4pLb7XVzRbFHP5WnO/XOeHTegAmIIF1AGxNIBCG+6HVQ23JlINIAIEO8EkD04aXyqiU
 314y8cEzS9u1bskNCU7/kw989ZSM687o+iUzp13CJkMm0d3jpEQbrl6aYPWhRCg9BQ2h
 1fhRzI7cZ36HrDTtoJuALYJAgLZvW75K31+8+7kTpbO6zJjZvkXUOXufCeIf1WNKO/fw
 rH/l08b6W1ErTk1ZRNwP418ePso3G+ksgbBKyHraZFFEpVC3SLjhFcStioj1GsKmIVAS
 PrYA==
X-Gm-Message-State: AOJu0Yxsf6pLS6vVlzGvWTcL9J9lzVstRUYClksrV++wraU7ikADjeOr
 JJ9GnqWDQg36eZ8QH7kqoYgtleoXCzwzwmndXa7EiZEKH6PBFrBjsE4kelX4KsEg3bxiFKCPn52
 VK2tA
X-Gm-Gg: AY/fxX6SIlzeHbpCqDjYQXciMjPCIS4EPFm7wAGbP7sTqIG0hHSduPCRgf8mrRDhoyF
 j23TBBYBrwndat8cahA68Mu8f8hSxmTQYqLmBj3FWfpQuLhOIknPL4oneOB/+kjJ5//olFAEaXH
 fZX69bRqmCWJvl2Y4RZji+Z7lPp+TfKAWthtBDOHZxGFI4lLdZzK1RKkxNvRTlK3x4zqCzEzYqJ
 BuE82uOl+iim5lVC39YxqiNMyAeqlg1/9TkkrCFsRBkBrv3jh7L4mAkXqg/Ek5OoL3cy64ELFoD
 tX4xhuwgPap33e/CJh3dT2ZPYCgWKoblXGw6fC7Uyw8RYIt+ccRkVrJaLTjamSJN0MYGrzSaEvQ
 EnreeMwVrOj6/jkkT9ih1H6HGKW3DNhmfHQtZOmzyn8oKqgr0mfgB2iDouFDphF9JVkl7jZWYAo
 Kh73GhJSDnkUrjrUadgCrMoucAp9Mq19tTawiwLwSeDTUKwMUw9w==
X-Google-Smtp-Source: AGHT+IFP+Z/v+tA6xQ1Gseb9p6hRrY7I7VD5fwiM1PQgNDk76HSpJjarkut/ap/ETUG6er68y+d4Jg==
X-Received: by 2002:a05:6000:22c7:b0:432:586f:2a9d with SMTP id
 ffacd0b85a97d-432c379d04amr22208721f8f.32.1768265521671; 
 Mon, 12 Jan 2026 16:52:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm41603051f8f.8.2026.01.12.16.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 16:52:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 1/7] pcapng: add length checks to string arguments
Date: Mon, 12 Jan 2026 16:51:24 -0800
Message-ID: <20260113005154.44551-2-stephen@networkplumber.org>
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

