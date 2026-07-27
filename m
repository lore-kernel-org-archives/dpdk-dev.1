Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA122C531D0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 22:44:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A48084060C;
	Tue, 28 Jul 2026 00:44:23 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 05D5F400D6
 for <dev@dpdk.org>; Tue, 28 Jul 2026 00:44:21 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8484f229529so2193821b3a.2
 for <dev@dpdk.org>; Mon, 27 Jul 2026 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785192261;
 x=1785797061; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wKwDqXeXdPDpmwrlwYFRSX1ychKCKVliZYz4yIKRgT4=;
 b=JDzPBwahRs4Ut7gKy+sgaCFML9FYxGnNUusrpL1Jagdh6AX/H9fADIm1q1UoSdMgyc
 ERmvddJe8O/CQ5iJuShH7OSteeGsjUZvABloHQTBC17mSTfh2ZW76fXo/v7zstFcHCQj
 zYiydBRJpuZHY2ohrvwDUci44aTighsuKg7JYbPXJMqA8sHjSNDW+oRRClmT6rX7WqIl
 sv6eUHeTLqabay2q2+f4cM7cJ7OdJgeIgA2muQ3iqxj/LIOkh992lkhBhgmYTwfDzxHv
 GXa94J9zasOR8xsAYjKSPmRKmpOGmPQ0dSKN0YVJmwvGnw62uSmBw8NYXmdXp9I4ef2Q
 NiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785192261; x=1785797061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wKwDqXeXdPDpmwrlwYFRSX1ychKCKVliZYz4yIKRgT4=;
 b=DxJ0gMCdEOJHQK6lHs+EqiwMEkIc0MmkXnDgp6KXM5Og6c35Zio2cPYbZPV3/4T3YP
 ef/XvCfv1ZJhnsT+8iBsugdp59UyGcmmPyGiUrODsJTVEOZIcHkhnAf1gi/UxlUro7n6
 7g7lCUmbylwx4IymRTqsvQEpMOVgkC6Ryq9wwwvCZIq2FU4Yg0e3X2i195lah06+An4k
 xZuLKXPmMrSlyS/f+zOA+yt7dhoZHbft8aLjxjVv4nll5mJyugadXWVd8HGnEoxApnOM
 OVOFWCAmMB2gP+ToWb/sYHmuuvlXF/GDkKu5oxP0JtBSbDY++zrHXJBMdDtBRfGskMLt
 ws/Q==
X-Gm-Message-State: AOJu0YwSZpR+VNFPpZz4BBVX1B74Dz0Otr1faDj+TMWkCtDMjbNjBP52
 DuDnEIHWlocgc1h9TP1LGS8a4Lq8JzTQxfvjJhCEJy0OxibmckkkVM4Eh0RWZ8SATK8X1cfryr8
 bisTe
X-Gm-Gg: AR+sD13T2Xo/anuwMokSyW25eamoiGjogO3VewW+r1BdYbIYxACNYoSvaYdVY5L2GZn
 QX/mfsVvERf49/qzHevO1UUFzCWGBk49fsL1IsGz3GhCldM4/UX8mHgwbfhN0fCiQMcLbEfoXxJ
 xWMip0hBhZt6t5fpqowQlJCDlxEJfU/1tf3C3BwibPT5Gummcb5yDvUYFCXbZ3gl9nf5TjOJD4i
 ZJ5c7EPT4v7AQaWa9SxbmMjpBajWcE37FYU+VKzxYk+3f3cS4U0FhGLBRkRROFudrFclaSOZD3j
 eQep+iFbo6mBICeMPKEBT88hHT5pCZAUT+6VLLGFc1tN2SvVKJewRj4bq5MElh0/BvmjFUQfRrW
 qtmNh5StrzYcY8ZgbCkjw8ZlW3Asrm9oF9RiCBJ/eqB43lWYR0uFfsdVHj5cF4TwStbXfPA3vHr
 eqQLXHZrwiAhfN11GoeOkR4AkqcWK4Y6NZylBcSoIs
X-Received: by 2002:a05:6a21:a8d:b0:3c0:adec:b3bd with SMTP id
 adf61e73a8af0-3c67df2af57mr9877579637.49.1785192260950; 
 Mon, 27 Jul 2026 15:44:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e5c921686sm20238078c88.4.2026.07.27.15.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 15:44:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 1/4] pcapng: extend interface statistics
Date: Mon, 27 Jul 2026 15:42:44 -0700
Message-ID: <20260727224417.1419663-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727224417.1419663-1-stephen@networkplumber.org>
References: <20260724212238.864798-1-stephen@networkplumber.org>
 <20260727224417.1419663-1-stephen@networkplumber.org>
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

The number of packets filtered was not implemented in original
code but useful for analysis.
Modify the API for writing pcapng statistics.
Use a structure and make it extensible in future.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c                     | 16 ++++-----
 app/test/test_pcapng.c                 | 10 +++---
 doc/guides/rel_notes/release_26_11.rst |  9 +++++
 lib/pcapng/rte_pcapng.c                | 50 +++++++++++++++++++-------
 lib/pcapng/rte_pcapng.h                | 33 ++++++++++++-----
 5 files changed, 85 insertions(+), 33 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 46a6cb251e..baec68b0b9 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -574,8 +574,8 @@ static void
 report_packet_stats(dumpcap_out_t out)
 {
 	struct rte_pdump_stats pdump_stats;
+	struct rte_pcapng_interface_stats isb;
 	struct interface *intf;
-	uint64_t ifrecv, ifdrop;
 	double percent;
 
 	fputc('\n', stderr);
@@ -584,22 +584,22 @@ report_packet_stats(dumpcap_out_t out)
 			continue;
 
 		/* do what Wiretap does */
-		ifrecv = pdump_stats.accepted + pdump_stats.filtered;
-		ifdrop = pdump_stats.nombuf + pdump_stats.ringfull;
+		isb.ifrecv = pdump_stats.accepted + pdump_stats.filtered;
+		isb.ifdrop = pdump_stats.nombuf + pdump_stats.ringfull;
+		isb.filteraccept = pdump_stats.accepted;
 
 		if (use_pcapng)
-			rte_pcapng_write_stats(out.pcapng, intf->port,
-					       ifrecv, ifdrop, NULL);
+			rte_pcapng_write_stats(out.pcapng, intf->port, &isb, sizeof(isb), NULL);
 
-		if (ifrecv == 0)
+		if (isb.ifrecv == 0)
 			percent = 0;
 		else
-			percent = 100. * ifrecv / (ifrecv + ifdrop);
+			percent = 100. * isb.ifrecv / (isb.ifrecv + isb.ifdrop);
 
 		fprintf(stderr,
 			"Packets received/dropped on interface '%s': "
 			"%"PRIu64 "/%" PRIu64 " (%.1f)\n",
-			intf->name, ifrecv, ifdrop, percent);
+			intf->name, isb.ifrecv, isb.ifdrop, percent);
 	}
 }
 
diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index d14ea84f0d..c62fdc1458 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -558,8 +558,9 @@ test_write_packets(void)
 		goto fail;
 	}
 
-	/* write a statistics block */
-	ret = rte_pcapng_write_stats(pcapng, port_id, 0, 0, NULL);
+	/* write an initial statistics block */
+	struct rte_pcapng_interface_stats isb = { };
+	ret = rte_pcapng_write_stats(pcapng, port_id, &isb, sizeof(isb), NULL);
 	if (ret <= 0) {
 		printf("Write of statistics failed\n");
 		goto fail;
@@ -569,9 +570,10 @@ test_write_packets(void)
 	if (count < 0)
 		goto fail;
 
-	/* write a statistics block */
+	/* write a final statistics block with comment */
+	isb.ifrecv = count;
 	ret = rte_pcapng_write_stats(pcapng, port_id,
-				     count, 0, "end of test");
+				     &isb, sizeof(isb), "end of test");
 	if (ret <= 0) {
 		printf("Write of statistics failed\n");
 		goto fail;
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..cdc3c99f64 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -93,6 +93,11 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **pcapng: add packet filtering statistic.**
+
+  The API for ``rte_pcapng_write_stats`` was changed to include
+  recording the number of filtered packets.
+
 
 ABI Changes
 -----------
@@ -109,6 +114,10 @@ ABI Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **pcapng: add packet filtering statistic.**
+
+  The ABI for ``rte_pcapng_write_stats`` now takes pointer to statistics.
+
 
 Known Issues
 ------------
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b5d1026891..fed1581772 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -277,6 +277,9 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 	uint64_t speed = 0;
 	int ret;
 
+	if (self == NULL)
+		return -EINVAL;
+
 	ret = rte_eth_dev_info_get(port, &dev_info);
 	if (ret < 0)
 		return -1;  /* should be ret */
@@ -394,29 +397,43 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 RTE_EXPORT_SYMBOL(rte_pcapng_write_stats)
 ssize_t
 rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
-		       uint64_t ifrecv, uint64_t ifdrop,
-		       const char *comment)
+		       const struct rte_pcapng_interface_stats *stats,
+		       size_t stats_sz, const char *comment)
 {
+	struct rte_pcapng_interface_stats isb;
 	struct pcapng_statistics *hdr;
 	struct pcapng_option *opt;
-	uint64_t start_time = self->clock.ns_base;
-	uint64_t sample_time;
+	uint64_t start_time, sample_time;
 	uint32_t optlen, len;
 	uint32_t *buf;
 	ssize_t ret;
 
+	if (self == NULL)
+		return -EINVAL;
+
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -EINVAL);
 
+	if (stats == NULL || stats_sz == 0 || stats_sz > sizeof(*stats))
+		return -EINVAL;
+
 	if (comment && strlen(comment) > PCAPNG_STR_MAX)
 		return -EINVAL;
 
+	/* Future proof for more/less stats - all UINT64_MAX */
+	memset(&isb, 0xff, sizeof(isb));
+	memcpy(&isb, stats, stats_sz);
+
 	optlen = 0;
 
-	if (ifrecv != UINT64_MAX)
-		optlen += pcapng_optlen(sizeof(ifrecv));
-	if (ifdrop != UINT64_MAX)
-		optlen += pcapng_optlen(sizeof(ifdrop));
+	/* compute how many stats will be added. */
+	if (isb.ifrecv != UINT64_MAX)
+		optlen += pcapng_optlen(sizeof(isb.ifrecv));
+	if (isb.ifdrop != UINT64_MAX)
+		optlen += pcapng_optlen(sizeof(isb.ifdrop));
+	if (isb.filteraccept != UINT64_MAX)
+		optlen += pcapng_optlen(sizeof(isb.filteraccept));
 
+	start_time = self->clock.ns_base;
 	if (start_time != 0)
 		optlen += pcapng_optlen(sizeof(start_time));
 
@@ -439,12 +456,16 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	if (start_time != 0)
 		opt = pcapng_add_option(opt, PCAPNG_ISB_STARTTIME,
 					 &start_time, sizeof(start_time));
-	if (ifrecv != UINT64_MAX)
+	if (isb.ifrecv != UINT64_MAX)
 		opt = pcapng_add_option(opt, PCAPNG_ISB_IFRECV,
-				&ifrecv, sizeof(ifrecv));
-	if (ifdrop != UINT64_MAX)
+					&isb.ifrecv, sizeof(uint64_t));
+	if (isb.ifdrop != UINT64_MAX)
 		opt = pcapng_add_option(opt, PCAPNG_ISB_IFDROP,
-				&ifdrop, sizeof(ifdrop));
+					&isb.ifdrop, sizeof(uint64_t));
+	if (isb.filteraccept != UINT64_MAX)
+		opt = pcapng_add_option(opt, PCAPNG_ISB_FILTERACCEPT,
+					&isb.filteraccept, sizeof(uint64_t));
+
 	if (optlen != 0)
 		opt = pcapng_add_option(opt, PCAPNG_OPT_END, NULL, 0);
 
@@ -717,6 +738,11 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 	unsigned int i, cnt = 0;
 	ssize_t ret, total = 0;
 
+	if (self == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *m = pkts[i];
 		struct pcapng_enhance_packet_block *epb;
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index d8d328f710..495b6d3204 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -178,21 +178,36 @@ ssize_t
 rte_pcapng_write_packets(rte_pcapng_t *self,
 			 struct rte_mbuf *pkts[], uint16_t nb_pkts);
 
+/**
+ * A structure to store interface statistics in pcapng
+ * Interface statistics block.
+ * If the statistic is unavailable or unknown, use UINT64_MAX.
+ *
+ * Subset of definitions come from IETF pcapng standard.
+ * The osdrop and usrdeliv statistics are not included because
+ * DPDK does not use OS and does not deliver to application over sockets.
+ */
+struct rte_pcapng_interface_stats {
+	uint64_t ifrecv;	/**< Packets received on interface during capture. */
+	uint64_t ifdrop;	/**< Packets dropped by interface due to lack of resources. */
+	uint64_t filteraccept;	/**< Packets accepted by filter. */
+};
+
 /**
  * Write an Interface statistics block.
- * For statistics, use 0 if don't know or care to report it.
  * Should be called before closing capture to report results.
  *
  * @param self
  *  The handle to the packet capture file
  * @param port
  *  The Ethernet port to report stats on.
- * @param ifrecv
- *  The number of packets received by capture.
- *  Optional: use UINT64_MAX if not known.
- * @param ifdrop
- *  The number of packets missed by the capture process.
- *  Optional: use UINT64_MAX if not known.
+ * @param stats
+ *  The statistics to write.
+ * @param stats_sz
+ *  The sizeof statistics structure.
+ *  Must be greater than 0 and not more than sizeof(*stats).
+ *  This allows for future expansion of interface statistics but
+ *  with ABI compatibility.
  * @param comment
  *  Optional comment to add to statistics.
  * @return
@@ -203,8 +218,8 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
  */
 ssize_t
 rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port,
-		       uint64_t ifrecv, uint64_t ifdrop,
-		       const char *comment);
+		       const struct rte_pcapng_interface_stats *stats,
+		       size_t stats_sz, const char *comment);
 
 #ifdef __cplusplus
 }
-- 
2.53.0

