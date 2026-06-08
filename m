Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A38CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9318406BA;
	Mon,  8 Jun 2026 18:14:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 01D31406BA
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:14:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780935263; x=1812471263;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wt18kuCSOd44WRnm9kiHmRaC8XzsuDhmSzNl4qDVGRo=;
 b=PPlzX6jztWbykOkoXn4G53Qjh78t6nCtY0KoSCpmn8o+oDTI3if61FRc
 mpZKkFHe8F+1nvBUGpynaNj1DhyxUGdU4JrkUGu1ApCnFzZbtjrNyhFh3
 BmbCzmgWdPWDb5LLpyW92Er2cyaMprsvi1TfxxkH2mc0xbQYBohhztY9o
 E9Yn3laRkgGLJ/mJqfoGvTfrJXz5IVh/vZMritpTALV+92lnyYiqo+SvH
 vlD5D4ADQ7//8X3Biek0sXzLWVL4aKEpm+cB9OfGoxHp6sRKJxzINV2/h
 CyAfHqBDpGDUx17WlD2alRQzStVcbFq/0HBD3mbUppw0mqrLTrVX8m4aw w==;
X-CSE-ConnectionGUID: ve190UrAQk+dJm8J28n4zQ==
X-CSE-MsgGUID: LRo8BD8JSh+Wtf9ikdEjhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="80809587"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="80809587"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:14:23 -0700
X-CSE-ConnectionGUID: zgHtds/dTECbHyPM7H9czA==
X-CSE-MsgGUID: JxcUgZBGTBypIqwJZ6R0xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245457477"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa008.jf.intel.com with ESMTP; 08 Jun 2026 09:14:21 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, reshma.pattan@intel.com,
 stephen@networkplumber.org, Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH 6/7] pcapng: add user-supplied timestamp support
Date: Mon,  8 Jun 2026 12:40:58 -0400
Message-ID: <20260608164059.65420-7-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608164059.65420-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

Add rte_pcapng_copy_ts() which accepts an optional timestamp parameter
in nanoseconds. When the timestamp is non-zero, it is used directly
instead of reading the TSC. This allows applications to provide
hardware PTP timestamps from the NIC, enabling accurate packet capture
with PTP-domain timing rather than host-local TSC values.

The existing rte_pcapng_copy() function is preserved as a static inline
wrapper that passes zero for backward compatibility.

The TSC-to-epoch conversion in the write path is removed since callers
providing hardware timestamps have already performed the conversion.


Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 lib/pcapng/rte_pcapng.c | 19 ++++---------------
 lib/pcapng/rte_pcapng.h | 41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b5d1026891..96b3aafeb6 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -546,14 +546,14 @@ pcapng_vlan_insert(struct rte_mbuf *m, uint16_t ether_type, uint16_t tci)
  */
 
 /* Make a copy of original mbuf with pcapng header and options */
-RTE_EXPORT_SYMBOL(rte_pcapng_copy)
+RTE_EXPORT_SYMBOL(rte_pcapng_copy_ts)
 struct rte_mbuf *
-rte_pcapng_copy(uint16_t port_id, uint32_t queue,
+rte_pcapng_copy_ts(uint16_t port_id, uint32_t queue,
 		const struct rte_mbuf *md,
 		struct rte_mempool *mp,
 		uint32_t length,
 		enum rte_pcapng_direction direction,
-		const char *comment)
+		const char *comment, uint64_t ts)
 {
 	struct pcapng_enhance_packet_block *epb;
 	uint32_t orig_len, pkt_len, padding, flags;
@@ -691,7 +691,7 @@ rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 	mc->port = port_id;
 
 	/* Put timestamp in cycles here - adjust in packet write */
-	timestamp = rte_get_tsc_cycles();
+	timestamp = ts ? ts : rte_get_tsc_cycles();
 	epb->timestamp_hi = timestamp >> 32;
 	epb->timestamp_lo = (uint32_t)timestamp;
 	epb->capture_length = pkt_len;
@@ -720,7 +720,6 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *m = pkts[i];
 		struct pcapng_enhance_packet_block *epb;
-		uint64_t cycles, timestamp;
 
 		/* sanity check that is really a pcapng mbuf */
 		epb = rte_pktmbuf_mtod(m, struct pcapng_enhance_packet_block *);
@@ -737,16 +736,6 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 			return -1;
 		}
 
-		/*
-		 * When data is captured by pcapng_copy the current TSC is stored.
-		 * Adjust the value recorded in file to PCAP epoch units.
-		 */
-		cycles = (uint64_t)epb->timestamp_hi << 32;
-		cycles += epb->timestamp_lo;
-		timestamp = tsc_to_ns_epoch(&self->clock, cycles);
-		epb->timestamp_hi = timestamp >> 32;
-		epb->timestamp_lo = (uint32_t)timestamp;
-
 		/*
 		 * Handle case of highly fragmented and large burst size
 		 * Note: this assumes that max segments per mbuf < IOV_MAX
diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
index d8d328f710..3d735e4ebe 100644
--- a/lib/pcapng/rte_pcapng.h
+++ b/lib/pcapng/rte_pcapng.h
@@ -109,7 +109,7 @@ enum rte_pcapng_direction {
 };
 
 /**
- * Format an mbuf for writing to file.
+ * Format an mbuf with time stamp for writing to file.
  *
  * @param port_id
  *   The Ethernet port on which packet was received
@@ -129,16 +129,53 @@ enum rte_pcapng_direction {
  * @param comment
  *   Optional per packet comment.
  *   Truncated to UINT16_MAX characters.
+ * @param ts
+ *   Optional timestamp in nanoseconds. If zero, the current TSC is used.
  *
  * @return
  *   - The pointer to the new mbuf formatted for pcapng_write
  *   - NULL on error such as invalid port or out of memory.
  */
 struct rte_mbuf *
+rte_pcapng_copy_ts(uint16_t port_id, uint32_t queue,
+		const struct rte_mbuf *m, struct rte_mempool *mp,
+		uint32_t length,
+		enum rte_pcapng_direction direction, const char *comment, uint64_t ts);
+
+/**
+ * Format an mbuf for writing to file.
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
+ *   Packet comment.
+ *
+ * @return
+ *   - The pointer to the new mbuf formatted for pcapng_write
+ *   - NULL if allocation fails.
+ */
+static inline struct rte_mbuf *
 rte_pcapng_copy(uint16_t port_id, uint32_t queue,
 		const struct rte_mbuf *m, struct rte_mempool *mp,
 		uint32_t length,
-		enum rte_pcapng_direction direction, const char *comment);
+		enum rte_pcapng_direction direction, const char *comment)
+{
+	return rte_pcapng_copy_ts(port_id, queue, m, mp, length, direction,
+				  comment, 0);
+}
 
 
 /**
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

