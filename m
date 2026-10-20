Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8C2606A325
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=WuxiwV62
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A21A406B4;
	Tue, 20 Oct 2026 19:57:42 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 9D34F40695
 for <dev@dpdk.org>; Tue, 20 Oct 2026 19:57:38 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e5fb79ce82so18838445ad.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792519058;
 x=1793123858; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZSY7KwLb+VqJZ1QMmP2abGrYflzl0Npl8cmVXcPgRkY=;
 b=WuxiwV62ZCnmkBh6hfnGZC5/2jnpEEYX7nLc9tddjrkrKmUhz/38NngeEPskJScANW
 wBWzF4XKu5C99CYC/9oJAb1AMgCll3FAoUa3OM/SWYEtTXiGLYegnHeCMfFP/5csxddD
 OQoRJ5LyxFMIBfS4X8AlVjOmBKMPVCPu9c5pLSwVDEeNphfAJoM+CiQJLH6+/suE6LyE
 BtGpaRU0Fn0MYqeyGhqpG/umw096bKcH+B2jSK2n7ujKw5oxo7pWOnliC4NzB9b6mGxQ
 AnGTGnLuGuRKAd3JmJG3sEh4XuQAkw8X2bZKUFnWrU+V4N2GOyauzx/9UGJrdZfaW/Au
 8+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519058; x=1793123858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZSY7KwLb+VqJZ1QMmP2abGrYflzl0Npl8cmVXcPgRkY=;
 b=Cqi2Wed2WBkhtsOCEzFz06Yy5io9aZUTx+EUiAN3NInBYJ+fYUe64xicr1kgjCc+IC
 8QRdBkbMeBZuiMHwNP+I6Dtoj4qqRKkeE8m07ychar9B3NrNnMVFcM4Ynh8Hua5vxNDX
 utH1I91I1HDcAwELsrl5zggO6beEvpa3MwKIAsFy7GVkhtiNJLG+8ZZdV66FxXWaqBzz
 CUuo/SoPu8U5qZCU4xnHfmoFh8k0Tfxr38ZjFvlJSQ2OBMIxDGK71LeBCoLyX4rc9Uoe
 tca0bF1N6KXjDeqthWrM69IgEWKkpoMPTR3qDT28jSLpV1VBfXc2yrIiADVCPNQ8ijtu
 JHZQ==
X-Gm-Message-State: AFq9FYJgsZ9+DVDPfpIk5v5DsHvLMxQ3ZNe1+9229DLt5xwOiwuQLxml
 oT/O1klyikoQyBgOUcjYCUTvVnlR/ZENy8voHyefUlTsgLvmdusrpTB9OfG5q1GtVd0EsPFtV4M
 5XyFdiXk=
X-Gm-Gg: AYBFou1EMGrWpUVN5LOZiIvLzkZOby5gsQ6DK90GTzmtuIB1lUK2bWfajeVJlHCI56C
 H3icKRCqsbgPH/y8J+kEkjS1FYBgjKSCkI0DIzlc9nkggYZzqqcMSV4Vx8hC3tgk6C3p8nnnljf
 Wpy/mvqTeogwPXmUXEONO4sHBLbc3j5KnY/1UuzUiELh66Qub92orqyyWPMqG/Hwy5GUww3+QhN
 VS8KUD8S/wrO6hKa1c6myQOOtT/shfyamU/rDzwsj525kUHrC8qRzq05CX6ZNRxFSzUKetb9HTh
 BrVEFl3m6/HKCelMmZ2mlgjm/c3W6HggVMy9pJc2tUfb1KAOdydBgS1T94KFSYNhnnu8tHDjfll
 i9eOqSx/0KXPCxjpkOVleoytDkCQdsCS/aeyV/VE9tp+ndIHOCrqy1zxhIQqdp04xLA8tku01c8
 yzRsv8QKSBQ4gSfB3Bi+Tg91WC51pNr12HTuQ3LFqpBMQqksuUH1EyGqsGW7+4hw4XHbLTtZ6f+
 1tKdXP+vq8vBDju5T0RkvmCtybHOXylvytxwQ==
X-Received: by 2002:a17:902:d492:b0:2e9:3d96:7e75 with SMTP id
 d9443c01a7336-2e9a6c1a318mr94187615ad.51.1792519057575; 
 Tue, 20 Oct 2026 10:57:37 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b43236esm1997875ad.29.2026.10.20.10.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 10:57:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Dawid Wesierski <dawid.wesierski@intel.com>,
 Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 3/3] pcapng: add user-supplied timestamp support
Date: Tue, 20 Oct 2026 10:55:44 -0700
Message-ID: <20261020175732.1552406-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020175732.1552406-1-stephen@networkplumber.org>
References: <20261020152907.2607513-1-dawid.wesierski@intel.com>
 <20261020175732.1552406-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dawid Wesierski <dawid.wesierski@intel.com>

An application may have a better time for a packet than the TSC at
copy time, for example a hardware Rx timestamp, but rte_pcapng_copy()
always timestamps with the TSC.

Add rte_pcapng_copy_ts(), which takes the time of the packet in
nanoseconds since the Unix epoch. Both entry points share one
implementation: rte_pcapng_copy() reads the TSC and sets bit 63 to
mark it, and rte_pcapng_write_packets() converts a marked value with
rte_tsc_to_ns(). Epoch time in nanoseconds sets bit 63 only in the
year 2262, so rte_pcapng_copy_ts() rejects a timestamp that sets it.

rte_pcapng_copy() keeps its signature, so no API or ABI is broken and
no deprecation notice is needed. The new function is experimental.

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c                 | 100 +++++++++++++++++++++++++
 doc/guides/prog_guide/pcapng_lib.rst   |   4 +
 doc/guides/rel_notes/release_26_11.rst |   7 ++
 lib/pcapng/rte_pcapng.c                |  72 +++++++++++++++---
 lib/pcapng/rte_pcapng.h                |  54 ++++++++++++-
 5 files changed, 224 insertions(+), 13 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 060c479ba2..4d5ce65f23 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -18,6 +18,7 @@
 #endif
 
 #include <rte_bus_vdev.h>
+#include <rte_errno.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_ip.h>
@@ -714,6 +715,104 @@ test_write_before_open(void)
 	return -1;
 }
 
+static int
+test_pcapng_timestamp(void)
+{
+	char file_name[PATH_MAX] = "/tmp/pcapng_test_XXXXXX.pcapng";
+	char errbuf[PCAP_ERRBUF_SIZE];
+	rte_pcapng_t *pcapng = NULL;
+	struct dummy_mbuf mbfs;
+	struct pcap_pkthdr h;
+	struct rte_mbuf *mc;
+	uint64_t pcap_ts, ns;
+	pcap_t *pcap;
+	int ret, tmp_fd;
+
+	tmp_fd = mkstemps(file_name, strlen(".pcapng"));
+	if (tmp_fd == -1) {
+		perror("mkstemps() failure");
+		return -1;
+	}
+
+	pcapng = rte_pcapng_fdopen(tmp_fd, NULL, NULL, "pcapng_ts_test", NULL);
+	if (pcapng == NULL) {
+		printf("rte_pcapng_fdopen failed\n");
+		close(tmp_fd);
+		goto fail;
+	}
+
+	ret = rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB, NULL, NULL, NULL);
+	if (ret < 0) {
+		printf("can not add port %u\n", port_id);
+		goto fail;
+	}
+
+	mbuf1_prepare(&mbfs);
+
+	/* Bit 63 marks a TSC value, so a caller timestamp must not set it. */
+	mc = rte_pcapng_copy_ts(port_id, 0, &mbfs.mb[0], mp,
+				rte_pktmbuf_pkt_len(&mbfs.mb[0]),
+				RTE_PCAPNG_DIRECTION_IN, NULL,
+				UINT64_C(1) << 63);
+	if (mc != NULL || rte_errno != EINVAL) {
+		printf("rte_pcapng_copy_ts accepted a timestamp with bit 63 set\n");
+		rte_pktmbuf_free(mc);
+		goto fail;
+	}
+
+	/* One second ahead, so that it cannot be the TSC of the copy. */
+	pcap_ts = current_timestamp() + NS_PER_S;
+	mc = rte_pcapng_copy_ts(port_id, 0, &mbfs.mb[0], mp,
+				rte_pktmbuf_pkt_len(&mbfs.mb[0]),
+				RTE_PCAPNG_DIRECTION_IN, "custom_ts", pcap_ts);
+	if (mc == NULL) {
+		printf("rte_pcapng_copy_ts failed\n");
+		goto fail;
+	}
+
+	ret = rte_pcapng_write_packets(pcapng, &mc, 1);
+	rte_pktmbuf_free(mc);
+	if (ret <= 0) {
+		printf("Write of custom timestamp packet failed\n");
+		goto fail;
+	}
+
+	rte_pcapng_close(pcapng);
+	pcapng = NULL;
+
+	pcap = pcap_open_offline_with_tstamp_precision(file_name,
+						       PCAP_TSTAMP_PRECISION_NANO,
+						       errbuf);
+	if (pcap == NULL) {
+		printf("pcap_open_offline failed: %s\n", errbuf);
+		goto fail;
+	}
+
+	if (pcap_next(pcap, &h) == NULL) {
+		printf("No packets in file\n");
+		pcap_close(pcap);
+		goto fail;
+	}
+	pcap_close(pcap);
+
+	/* With nanosecond precision, tv_usec holds nanoseconds. */
+	ns = (uint64_t)h.ts.tv_sec * NS_PER_S + h.ts.tv_usec;
+	if (ns != pcap_ts) {
+		printf("Timestamp mismatch: expected %"PRIu64" got %"PRIu64"\n",
+		       pcap_ts, ns);
+		goto fail;
+	}
+
+	remove(file_name);
+	return 0;
+
+fail:
+	if (pcapng)
+		rte_pcapng_close(pcapng);
+	remove(file_name);
+	return -1;
+}
+
 static void
 test_cleanup(void)
 {
@@ -826,6 +925,7 @@ unit_test_suite test_pcapng_suite  = {
 		TEST_CASE(test_write_packets),
 		TEST_CASE(test_write_before_open),
 		TEST_CASE(test_long_timestamp),
+		TEST_CASE(test_pcapng_timestamp),
 		TEST_CASES_END()
 	}
 };
diff --git a/doc/guides/prog_guide/pcapng_lib.rst b/doc/guides/prog_guide/pcapng_lib.rst
index d18ebdbd1f..598cc6c93b 100644
--- a/doc/guides/prog_guide/pcapng_lib.rst
+++ b/doc/guides/prog_guide/pcapng_lib.rst
@@ -32,6 +32,10 @@ to determine the lower bound based on MTU.
 Collecting packets is done in two parts.
 The function ``rte_pcapng_copy`` is used to format and copy mbuf data
 and ``rte_pcapng_write_packets`` writes a burst of packets to the output file.
+The timestamp of each packet is the TSC at the time of ``rte_pcapng_copy``.
+An application that has a better time for the packet,
+for example a hardware timestamp,
+can give it in nanoseconds to ``rte_pcapng_copy_ts`` instead.
 
 The function ``rte_pcapng_write_stats`` can be used
 to write statistics information into the output file.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 5f960692e2..4ff5fca0c3 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -79,6 +79,13 @@ New Features
   to convert a TSC value into nanoseconds since 1/1/1970,
   using a reference point recorded during EAL initialization.
 
+* **Added pcapng support for user-supplied timestamps.**
+
+  Added the experimental ``rte_pcapng_copy_ts()`` function,
+  which takes the time of the packet in nanoseconds since the Unix epoch,
+  for example a hardware Rx timestamp.
+  ``rte_pcapng_copy()`` is unchanged and still uses the TSC at copy time.
+
 * **Added pile stack and mempool driver.**
 
   Introduced pile, a lock-free, stack-like implementation,
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index f910896a61..952cc24ce4 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -36,6 +36,9 @@
 /* upper bound for strings in pcapng option data */
 #define PCAPNG_STR_MAX	UINT16_MAX
 
+/* Flag to indicate timestamp is in TSC cycles (bit 63) */
+#define PCAPNG_TSC_FLAG	(1ULL << 63)
+
 /* Format of the capture file handle */
 struct rte_pcapng {
 	int  outfd;		/* output file */
@@ -473,20 +476,24 @@ pcapng_vlan_insert(struct rte_mbuf *m, uint16_t ether_type, uint16_t tci)
  *    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
  */
 
-/* Make a copy of original mbuf with pcapng header and options */
-RTE_EXPORT_SYMBOL(rte_pcapng_copy)
-struct rte_mbuf *
-rte_pcapng_copy(uint16_t port_id, uint32_t queue,
+/*
+ * Make a copy of original mbuf with pcapng header and options.
+ *
+ * The timestamp is stored as given: either epoch nanoseconds from the
+ * caller, or the TSC with PCAPNG_TSC_FLAG set for conversion at write.
+ */
+static struct rte_mbuf *
+pcapng_copy(uint16_t port_id, uint32_t queue,
 		const struct rte_mbuf *md,
 		struct rte_mempool *mp,
 		uint32_t length,
 		enum rte_pcapng_direction direction,
-		const char *comment)
+		const char *comment,
+		uint64_t timestamp)
 {
 	struct pcapng_enhance_packet_block *epb;
 	uint32_t orig_len, pkt_len, padding, flags;
 	struct pcapng_option *opt;
-	uint64_t timestamp;
 	uint16_t optlen;
 	struct rte_mbuf *mc;
 	bool rss_hash;
@@ -618,8 +625,6 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	/* Interface index is filled in later during write */
 	mc->port = port_id;
 
-	/* Put timestamp in cycles here - adjust in packet write */
-	timestamp = rte_get_tsc_cycles();
 	epb->timestamp_hi = timestamp >> 32;
 	epb->timestamp_lo = (uint32_t)timestamp;
 	epb->capture_length = pkt_len;
@@ -635,6 +640,43 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	return NULL;
 }
 
+RTE_EXPORT_SYMBOL(rte_pcapng_copy)
+struct rte_mbuf *
+rte_pcapng_copy(uint16_t port_id, uint32_t queue,
+		const struct rte_mbuf *md,
+		struct rte_mempool *mp,
+		uint32_t length,
+		enum rte_pcapng_direction direction,
+		const char *comment)
+{
+	/*
+	 * Record the TSC and flag it, so rte_pcapng_write_packets() knows
+	 * to convert it rather than treat it as an epoch time.
+	 */
+	return pcapng_copy(port_id, queue, md, mp, length, direction, comment,
+			   rte_get_tsc_cycles() | PCAPNG_TSC_FLAG);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pcapng_copy_ts, 26.11)
+struct rte_mbuf *
+rte_pcapng_copy_ts(uint16_t port_id, uint32_t queue,
+		   const struct rte_mbuf *md,
+		   struct rte_mempool *mp,
+		   uint32_t length,
+		   enum rte_pcapng_direction direction,
+		   const char *comment,
+		   uint64_t timestamp)
+{
+	/* Bit 63 is reserved to mark a TSC, see rte_pcapng_copy(). */
+	if (unlikely(timestamp & PCAPNG_TSC_FLAG)) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	return pcapng_copy(port_id, queue, md, mp, length, direction, comment,
+			   timestamp);
+}
+
 /* Write pre-formatted packets to file. */
 RTE_EXPORT_SYMBOL(rte_pcapng_write_packets)
 ssize_t
@@ -665,12 +707,18 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 			return -1;
 		}
 
-		/* adjust timestamp recorded in packet */
+		/*
+		 * If rte_pcapng_copy() stored the TSC (flag bit set),
+		 * convert it to epoch nanoseconds. Else the caller gave
+		 * the time in nanoseconds since the epoch: keep it.
+		 */
 		cycles = (uint64_t)epb->timestamp_hi << 32;
 		cycles += epb->timestamp_lo;
-		timestamp = rte_tsc_to_ns(cycles);
-		epb->timestamp_hi = timestamp >> 32;
-		epb->timestamp_lo = (uint32_t)timestamp;
+		if (cycles & PCAPNG_TSC_FLAG) {
+			timestamp = rte_tsc_to_ns(cycles & ~PCAPNG_TSC_FLAG);
+			epb->timestamp_hi = timestamp >> 32;
+			epb->timestamp_lo = (uint32_t)timestamp;
+		}
 
 		/*
 		 * Handle case of highly fragmented and large burst size
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index d8d328f710..792f34acb1 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -133,12 +133,64 @@ enum rte_pcapng_direction {
  * @return
  *   - The pointer to the new mbuf formatted for pcapng_write
  *   - NULL on error such as invalid port or out of memory.
+ *
+ * The packet is timestamped with the TSC, which
+ * rte_pcapng_write_packets() converts to epoch time.
+ * Use rte_pcapng_copy_ts() to give the time of the packet directly.
  */
 struct rte_mbuf *
 rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 		const struct rte_mbuf *m, struct rte_mempool *mp,
 		uint32_t length,
-		enum rte_pcapng_direction direction, const char *comment);
+		enum rte_pcapng_direction direction,
+		const char *comment);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Format an mbuf for writing to file, with the time of the packet.
+ *
+ * Same as rte_pcapng_copy(), except that the caller gives the time of
+ * the packet instead of it being taken from the TSC at copy time.
+ *
+ * @param port_id
+ *   The Ethernet port on which packet was received
+ *   or is going to be transmitted.
+ * @param queue
+ *   The queue on the Ethernet port where packet was received
+ *   or is going to be transmitted.
+ * @param mp
+ *   The mempool from which the "clone" mbufs are allocated.
+ * @param m
+ *   The mbuf to copy
+ * @param length
+ *   The upper limit on bytes to copy.  Passing UINT32_MAX
+ *   means all data (after offset).
+ * @param direction
+ *   The direction of the packer: receive, transmit or unknown.
+ * @param comment
+ *   Optional per packet comment.
+ *   Truncated to UINT16_MAX characters.
+ * @param timestamp
+ *   Time of the packet in nanoseconds since the Unix epoch,
+ *   for example a hardware timestamp.
+ *   Bit 63 is reserved and must be zero;
+ *   epoch time in nanoseconds sets it only in the year 2262.
+ *
+ * @return
+ *   - The pointer to the new mbuf formatted for pcapng_write
+ *   - NULL on error such as invalid port, invalid timestamp
+ *     or out of memory. rte_errno is EINVAL if bit 63 of
+ *     the timestamp is set.
+ */
+__rte_experimental
+struct rte_mbuf *
+rte_pcapng_copy_ts(uint16_t port_id, uint32_t queue,
+		   const struct rte_mbuf *m, struct rte_mempool *mp,
+		   uint32_t length,
+		   enum rte_pcapng_direction direction,
+		   const char *comment, uint64_t timestamp);
 
 
 /**
-- 
2.53.0

