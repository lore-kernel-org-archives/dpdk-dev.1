Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B83860A2603
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AyCDp0lE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 837F740283;
	Tue, 20 Oct 2026 17:28:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 574104025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:28:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792510105; x=1824046105;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1odfE5F1CdkaswjMNLVy/F9FewtnefBJV+GTAGZtkdc=;
 b=AyCDp0lE9wsrx9bQQrlYtnpxpledTSUMuJb83ARtI9WwEMHJbwHFQAVz
 Yd5/AG+Aanx7Sssmwuxmm7ozwTfA1/idTDM/QMChU0AH+H6KCiYvoNMBA
 l9ZvGgnN6MdX2jfrq30udTmPlpTivsB35P4eQp0zDmPlUFt91msFqq96I
 B4uRvOJ1XuKYhy+lU4fjt+ggx/Hwsu6t8AFSQCqX6Mzr8uPrjf55Nj2SS
 b7U7ARHCc1uVGXrggu/EqpFAsZ478oMk7JQEI4W0XrYYhsRbiy8FUaELI
 3HMWEhgTypz1gaGCZduMCgQtRD6B954Lrs4eqd8EEooPxVJoBewSCpZDf Q==;
X-CSE-ConnectionGUID: T/eqLOJxSbyQx55ZqV+S0A==
X-CSE-MsgGUID: qvJCcmNHQQ2VkUgQl632KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1100150"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1100150"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 08:28:22 -0700
X-CSE-ConnectionGUID: XRislK6nRryq5GImgtq9wg==
X-CSE-MsgGUID: FO48sZojTCSqA3LBJeIyVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2788725"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by orviesa001.jf.intel.com with ESMTP; 20 Oct 2026 08:28:18 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, reshma.pattan@intel.com, thomas@monjalon.net,
 mb@smartsharesystems.com, marek.kasiewicz@intel.com, jerinj@marvell.com,
 kirankumark@marvell.com, ndabilpuram@marvell.com, yanzhirun_163@163.com
Subject: [PATCH v8] pcapng: add user-supplied timestamp support
Date: Tue, 20 Oct 2026 15:29:07 +0000
Message-ID: <20261020152907.2607513-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014103858.5a454dac@phoenix.local>
References: <20261014172102.1090177-1-dawid.wesierski@intel.com>
 <20261014103858.5a454dac@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a timestamp parameter to rte_pcapng_copy(). An application that
has a better time for the packet than the TSC at copy time, for
example a hardware Rx timestamp, can then give it in nanoseconds
since the Unix epoch.

If the timestamp is 0, rte_pcapng_copy() stores the TSC with bit 63
set, and rte_pcapng_write_packets() converts it with the clock of the
capture file, as before. A different value goes into the file as it
is. The epoch time in nanoseconds sets bit 63 only in the year 2262,
so rte_pcapng_copy() rejects a timestamp that sets it.

This changes the API of rte_pcapng_copy(). The ABI version changes
in 26.11, so the old symbol is not kept.

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
v8:
- Remove rte_pcapng_tsc_to_ns(). The conversion does not need the
  capture file handle, and it can come later in EAL or without
  pcapng_open (Stephen Hemminger). The test no longer uses it.
- Say in the doc comment that rte_errno is EINVAL for a timestamp
  with bit 63 set, and say it in the release note.
- Rebase on 26.11-rc1.
v7:
- Rebase on main after the revert of the reciprocal divide.
 app/test/test_pcapng.c                 | 105 ++++++++++++++++++++++++-
 doc/guides/prog_guide/pcapng_lib.rst   |   3 +
 doc/guides/rel_notes/release_26_11.rst |   6 ++
 lib/graph/graph_pcap.c                 |   2 +-
 lib/pcapng/rte_pcapng.c                |  36 +++++++--
 lib/pcapng/rte_pcapng.h                |  12 ++-
 lib/pdump/rte_pdump.c                  |   2 +-
 7 files changed, 151 insertions(+), 15 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 688b58794e..3956ffa465 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -18,6 +18,7 @@
 #endif
 
 #include <rte_bus_vdev.h>
+#include <rte_errno.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_ip.h>
@@ -303,7 +304,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng)
 			mbuf1_resize(&mbfs, rte_rand_max(MAX_DATA_SIZE));
 
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
-					     RTE_PCAPNG_DIRECTION_IN, comment);
+					     RTE_PCAPNG_DIRECTION_IN, comment, 0);
 			if (mc == NULL) {
 				printf("Cannot copy packet\n");
 				return -1;
@@ -654,7 +655,7 @@ test_write_before_open(void)
 	for (i = 0; i < (int)count; i++) {
 		clones[i] = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp,
 					    rte_pktmbuf_pkt_len(&mbfs.mb[0]),
-					    RTE_PCAPNG_DIRECTION_IN, NULL);
+					    RTE_PCAPNG_DIRECTION_IN, NULL, 0);
 		if (clones[i] == NULL) {
 			fprintf(stderr, "Cannot copy packet before open\n");
 			rte_pktmbuf_free_bulk(clones, i);
@@ -714,6 +715,103 @@ test_write_before_open(void)
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
+	mc = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp,
+			     rte_pktmbuf_pkt_len(&mbfs.mb[0]),
+			     RTE_PCAPNG_DIRECTION_IN, NULL, UINT64_C(1) << 63);
+	if (mc != NULL || rte_errno != EINVAL) {
+		printf("rte_pcapng_copy accepted a timestamp with bit 63 set\n");
+		rte_pktmbuf_free(mc);
+		goto fail;
+	}
+
+	/* One second ahead, so that it cannot be the TSC of the copy. */
+	pcap_ts = current_timestamp() + NS_PER_S;
+	mc = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp,
+			     rte_pktmbuf_pkt_len(&mbfs.mb[0]),
+			     RTE_PCAPNG_DIRECTION_IN, "custom_ts", pcap_ts);
+	if (mc == NULL) {
+		printf("rte_pcapng_copy failed\n");
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
@@ -758,7 +856,7 @@ test_long_timestamp(void)
 
 		mc = rte_pcapng_copy(port_id, 0, &mbfs.mb[0], mp,
 				     rte_pktmbuf_pkt_len(&mbfs.mb[0]),
-				     RTE_PCAPNG_DIRECTION_IN, NULL);
+				     RTE_PCAPNG_DIRECTION_IN, NULL, 0);
 		TEST_ASSERT(mc != NULL, "rte_pcapng_copy failed");
 
 		tmp_fd = mkstemps(file_name, strlen(".pcapng"));
@@ -826,6 +924,7 @@ unit_test_suite test_pcapng_suite  = {
 		TEST_CASE(test_write_packets),
 		TEST_CASE(test_write_before_open),
 		TEST_CASE(test_long_timestamp),
+		TEST_CASE(test_pcapng_timestamp),
 		TEST_CASES_END()
 	}
 };
diff --git a/doc/guides/prog_guide/pcapng_lib.rst b/doc/guides/prog_guide/pcapng_lib.rst
index d18ebdbd1f..cc17b42eed 100644
--- a/doc/guides/prog_guide/pcapng_lib.rst
+++ b/doc/guides/prog_guide/pcapng_lib.rst
@@ -32,6 +32,9 @@ to determine the lower bound based on MTU.
 Collecting packets is done in two parts.
 The function ``rte_pcapng_copy`` is used to format and copy mbuf data
 and ``rte_pcapng_write_packets`` writes a burst of packets to the output file.
+The timestamp of each packet is the time in nanoseconds
+that the caller gives to ``rte_pcapng_copy``.
+If the caller gives 0, it is the TSC at the time of ``rte_pcapng_copy``.
 
 The function ``rte_pcapng_write_stats`` can be used
 to write statistics information into the output file.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c02..d57db4471d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -545,6 +545,12 @@ API Changes
   * ``rte_tel_data_add_dict_uint_hex``
   * ``rte_telemetry_register_cmd_arg``
 
+* pcapng: Added a ``timestamp`` parameter to ``rte_pcapng_copy``.
+  The application can give the time of the packet,
+  for example a hardware Rx timestamp, in nanoseconds since the Unix epoch.
+  The value 0 keeps the previous behavior: the TSC at copy time is used.
+  A timestamp with bit 63 set is rejected.
+
 
 ABI Changes
 -----------
diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
index 78859ec2d4..4d907c78aa 100644
--- a/lib/graph/graph_pcap.c
+++ b/lib/graph/graph_pcap.c
@@ -216,7 +216,7 @@ graph_pcap_dispatch(struct rte_graph *graph,
 		struct rte_mbuf *mc;
 		mbuf = (struct rte_mbuf *)objs[i];
 
-		mc = rte_pcapng_copy(mbuf->port, 0, mbuf, pkt_mp, mbuf->pkt_len, 0, comment);
+		mc = rte_pcapng_copy(mbuf->port, 0, mbuf, pkt_mp, mbuf->pkt_len, 0, comment, 0);
 		if (mc == NULL)
 			break;
 
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index df38e4819c..d727fc67d8 100644
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
@@ -515,12 +518,12 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
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
@@ -532,6 +535,12 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	 */
 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, NULL);
 #endif
+	/* Bit 63 marks a TSC value, see rte_pcapng_write_packets(). */
+	if (unlikely(timestamp & PCAPNG_TSC_FLAG)) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
 	orig_len = rte_pktmbuf_pkt_len(md);
 
 	/* Take snapshot of the data */
@@ -652,8 +661,13 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	/* Interface index is filled in later during write */
 	mc->port = port_id;
 
-	/* Put timestamp in cycles here - adjust in packet write */
-	timestamp = rte_get_tsc_cycles();
+	/*
+	 * Without a caller timestamp, put the TSC here and set the flag.
+	 * rte_pcapng_write_packets() converts it to epoch nanoseconds.
+	 */
+	if (timestamp == 0)
+		timestamp = rte_get_tsc_cycles() | PCAPNG_TSC_FLAG;
+
 	epb->timestamp_hi = timestamp >> 32;
 	epb->timestamp_lo = (uint32_t)timestamp;
 	epb->capture_length = pkt_len;
@@ -699,12 +713,18 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 			return -1;
 		}
 
-		/* adjust timestamp recorded in packet */
+		/*
+		 * If rte_pcapng_copy() stored the TSC (flag bit set),
+		 * convert it to PCAP epoch units. Else the caller gave
+		 * the time in nanoseconds since the epoch: keep it.
+		 */
 		cycles = (uint64_t)epb->timestamp_hi << 32;
 		cycles += epb->timestamp_lo;
-		timestamp = pcapng_timestamp(self, cycles);
-		epb->timestamp_hi = timestamp >> 32;
-		epb->timestamp_lo = (uint32_t)timestamp;
+		if (cycles & PCAPNG_TSC_FLAG) {
+			timestamp = pcapng_timestamp(self, cycles & ~PCAPNG_TSC_FLAG);
+			epb->timestamp_hi = timestamp >> 32;
+			epb->timestamp_lo = (uint32_t)timestamp;
+		}
 
 		/*
 		 * Handle case of highly fragmented and large burst size
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index d8d328f710..3399b79ea6 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -129,16 +129,24 @@ enum rte_pcapng_direction {
  * @param comment
  *   Optional per packet comment.
  *   Truncated to UINT16_MAX characters.
+ * @param timestamp
+ *   Time of the packet in nanoseconds since the Unix epoch,
+ *   for example a hardware timestamp. Bit 63 must be zero.
+ *   If zero, the current TSC is used,
+ *   and rte_pcapng_write_packets() converts it to the epoch.
  *
  * @return
  *   - The pointer to the new mbuf formatted for pcapng_write
- *   - NULL on error such as invalid port or out of memory.
+ *   - NULL on error such as invalid port, invalid timestamp
+ *     or out of memory. rte_errno is EINVAL if bit 63 of
+ *     the timestamp is set.
  */
 struct rte_mbuf *
 rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 		const struct rte_mbuf *m, struct rte_mempool *mp,
 		uint32_t length,
-		enum rte_pcapng_direction direction, const char *comment);
+		enum rte_pcapng_direction direction,
+		const char *comment, uint64_t timestamp);
 
 
 /**
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index ac94efe7ff..a85a95a808 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -176,7 +176,7 @@ pdump_copy_burst(uint16_t port_id, uint16_t queue_id,
 		 */
 		if (cbs->ver == V2)
 			p = rte_pcapng_copy(port_id, queue_id, pkts[i], mp, cbs->snaplen,
-					    direction, NULL);
+					    direction, NULL, 0);
 		else
 			p = rte_pktmbuf_copy(pkts[i], mp, 0, cbs->snaplen);
 

base-commit: 9a45341f18a1ab47af7123e63d942b90c1b79f38
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

