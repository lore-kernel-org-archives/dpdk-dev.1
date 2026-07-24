Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9D3C531C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 21:22:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD6064064C;
	Fri, 24 Jul 2026 23:22:46 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 89A6B40274
 for <dev@dpdk.org>; Fri, 24 Jul 2026 23:22:44 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cc891373e0so10599565ad.2
 for <dev@dpdk.org>; Fri, 24 Jul 2026 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784928163;
 x=1785532963; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b5aK46gLn4ExPTkeNsN6cGY7dmSWqNjyhfB9yZ37FaY=;
 b=oawbQu1FtNE2qoArUkyHgPwb62E3lXwYnYJRjpRfwV+TRDq/5NfWe2hV7S0dyWHnxv
 ElT3EoE/CUBYOAIOLcl4y0FB+pUDsC9A+xY9+WUubTWssjuxeYnAwDpatmuQD0zeJ022
 SDrYdw4457XNzZmqpajEHxfAD4NyaoxE1V31lzn+TDnALo0hkt1eJs8sWUPP0xI/jtjh
 fIhpWXQMMMpEd2MTu9DIn9xNTRRiU2aE7xj2SoUcniaJ71LC1zAiDl9HrkfQV2ASh6o2
 /p9DUmZNW8rqQm7U/xPya+YPVIN4oAoDhJoiVzWMEHwF2N7PQ2Ul1ODAw+onH7tzXAmM
 LXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784928163; x=1785532963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b5aK46gLn4ExPTkeNsN6cGY7dmSWqNjyhfB9yZ37FaY=;
 b=YCIrIb6ljkiFQCd+yvJ0DV/rULDULIOIfklSb6WZVv16L4Ju788EToWu/BtIblU4Tm
 xXPa3woRsrpUFxi1L6wmOzGIkjL00xX5gjZrisxsPhwNptZ866EMbHpq5NjFJEXFQU5/
 koyfKClrRlzPZ6/XI/UMRAxApuBBkqsmrPOB/PUrrzqjdmyr2LO9zPfCgvylX7Vs43VB
 /ncH474NuO+iNRiW+M6Snip030KDo+/AOd8YSMIWtD8+Xjyi7SMicx6Q4qgIGpawBE2K
 DcYsfqgvhZyf2dvlZGDqwOi2aAnQX2jEiae2mK5S9FUOpoHCSKhBMy73aI0UfPouO1WL
 UOZw==
X-Gm-Message-State: AOJu0YxEaAa4tLbo01oqt62bFx/UZHLV3HezlEoIkNJIe40NvoVbV9lm
 WduIgQBO5edsLTXqP3FCw5SiUZib7Hp7nbnLbdLGklyqMfeYmrvH+K9b7VFRhIAURuo9XvMlIMd
 zwVF1
X-Gm-Gg: AR+sD13o0+o7DaoxhpCuSV00NuiWpIt3i1/L2EIZQ68W1RwRc/jpcQRGyORMrrjeCX+
 q/yRNiqtT6EasLAFehV0I+56FIgzcQVIfNM/FA0nTMnCZ4FhrJwVRN5pFfZAwwwrvVs8Oku0b3j
 g3CVThrXdf6JsbrewwV+xWOdgb6tVDRwmwA+1oP0o059Rzat48GVOGNQnP22sk0q3zL7OXXeJwp
 IxQ0FqztSeH2/9fs/r1hWPCkAMWHusjbLQPrJDQiQT8mKofDDXGppGWYKOYwfhy94UK9eUwtXcI
 CK7dQCa93S2egFucGktcWo2eB/Mae1vU7fwLlLWsRKcWhRsA0XTCafHgiFiqGKUkzBHd/eeAUU4
 SU2vGP321PkkjpiB/jRLew0BrCF1ZC9XlwoEnF5DEp1b0iMckgT9sBOVwZpiYqnhtYoxfK8mLEH
 ixEm0pHrAP1Th/jiOzU8u5MSwDAFDNNeyoI1fiXaaV
X-Received: by 2002:a17:902:d4c9:b0:2ce:b8c5:5de3 with SMTP id
 d9443c01a7336-2cfde868024mr1132605ad.36.1784928163522; 
 Fri, 24 Jul 2026 14:22:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc548efesm2612725eec.14.2026.07.24.14.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 14:22:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/5] pcapng: extend interface statistics
Date: Fri, 24 Jul 2026 14:11:53 -0700
Message-ID: <20260724212238.864798-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724212238.864798-1-stephen@networkplumber.org>
References: <20260724212238.864798-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c                     | 16 ++++++-------
 app/test/test_pcapng.c                 |  6 +++--
 doc/guides/rel_notes/release_26_11.rst |  5 ++++
 lib/pcapng/rte_pcapng.c                | 32 ++++++++++++++++++--------
 lib/pcapng/rte_pcapng.h                | 30 ++++++++++++++++--------
 5 files changed, 60 insertions(+), 29 deletions(-)

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
index d14ea84f0d..f6fd85faad 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -570,8 +570,10 @@ test_write_packets(void)
 		goto fail;
 
 	/* write a statistics block */
-	ret = rte_pcapng_write_stats(pcapng, port_id,
-				     count, 0, "end of test");
+	struct rte_pcapng_interface_stats isb = {
+		.ifrecv = count,
+	};
+	ret = rte_pcapng_write_stats(pcapng, port_id, &isb, sizeof(isb), "end of test");
 	if (ret <= 0) {
 		printf("Write of statistics failed\n");
 		goto fail;
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 938617ca75..b27494fee7 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -84,6 +84,11 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **pcapng: add packet filtering statistic.**
+
+  The API for ``rte_pcapng_write_stats`` was changed to include
+  recording the number of filtered packets.
+
 
 ABI Changes
 -----------
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b5d1026891..455809d412 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -394,9 +394,10 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 RTE_EXPORT_SYMBOL(rte_pcapng_write_stats)
 ssize_t
 rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
-		       uint64_t ifrecv, uint64_t ifdrop,
-		       const char *comment)
+		       const struct rte_pcapng_interface_stats *stats,
+		       size_t size, const char *comment)
 {
+	struct rte_pcapng_interface_stats isb;
 	struct pcapng_statistics *hdr;
 	struct pcapng_option *opt;
 	uint64_t start_time = self->clock.ns_base;
@@ -410,12 +411,19 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
 	if (comment && strlen(comment) > PCAPNG_STR_MAX)
 		return -EINVAL;
 
+	/* Future proof for more/less stats - all UINT64_MAX */
+	memset(&isb, 0xff, sizeof(isb));
+	memcpy(&isb, stats, RTE_MIN(size, sizeof(*stats)));
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
 
 	if (start_time != 0)
 		optlen += pcapng_optlen(sizeof(start_time));
@@ -439,12 +447,16 @@ rte_pcapng_write_stats(rte_pcapng_t *self, uint16_t port_id,
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
 
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index d8d328f710..172455af60 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -178,21 +178,33 @@ ssize_t
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
  * @param comment
  *  Optional comment to add to statistics.
  * @return
@@ -203,8 +215,8 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
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

