Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA932CD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 18:00:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C626640666;
	Sat,  9 May 2026 20:00:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id A76A440670
 for <dev@dpdk.org>; Sat,  9 May 2026 20:00:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778349619; x=1809885619;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g3PBOqTDoU3SsfWcTm/7yhl14MKhTfyz8GLz3kk6FkE=;
 b=DLMYdaSfa2wkqvx/ohzJzjYuHs59nDbU1EGpi1QQjgMxWwcEMNobY/rG
 KrSCW0h4yLGYQ9QwslhFnpsuuqbO/Pf9VCLjTRi31QwHu4kgMVereq/wt
 JjS8TvaloWO1ZjJ5ZwSwTH/TF/Xcl1Fjdny786RKpWcujnK/yqCzSN1yn
 1XRbyVArf/ag/zIWBRXiZQmxP1k+ou2Z5+t0jX3LcqUiuCxtMFJErorWc
 0RhlhzlRsJ22wnr5MSRhK6cMXcVANnEISWwJhHiN9jgb0ToyPD6MYAYEV
 k1Z39EY99hR8vkZk64Hhmvyp3T7DfY0+p8Bhfbhx7GvV7ukfEJ32hAtXG w==;
X-CSE-ConnectionGUID: aLIFxcZzSxi9aNKXLp0TNQ==
X-CSE-MsgGUID: QnvPtGAlSYq7D8P8+sWWBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="96865027"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; d="scan'208";a="96865027"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2026 11:00:18 -0700
X-CSE-ConnectionGUID: eMricpZmQsKATRT5ZDaK0Q==
X-CSE-MsgGUID: 8SUZncroQhak7fWVuyabrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; d="scan'208";a="267426454"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by orviesa002.jf.intel.com with ESMTP; 09 May 2026 11:00:16 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH v8 4/4] examples/ptpclient: use shared PTP library definitions
Date: Sun, 10 May 2026 04:55:51 +0530
Message-ID: <20260509232551.2844201-5-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509232551.2844201-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260509232551.2844201-1-rajesh3.kumar@intel.com>
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

Update ptpclient to use the lib/net/rte_ptp.h library instead of
duplicated local PTP header structures and message type constants.

Changes:
  - Add #include <rte_ptp.h>
  - Replace local struct ptp_header with struct rte_ptp_hdr
  - Replace local struct tstamp with struct rte_ptp_timestamp
  - Replace local struct clock_id with uint8_t[8] arrays
  - Use RTE_PTP_MSGTYPE_* constants instead of local message types
  - Use hdr->msg_type bitfield and hdr->sequence_id direct access
  - Remove local PTP_PROTOCOL definition (use RTE_ETHER_TYPE_1588)

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 examples/ptpclient/meson.build |   1 +
 examples/ptpclient/ptpclient.c | 204 +++++++++++++--------------------
 2 files changed, 81 insertions(+), 124 deletions(-)

diff --git a/examples/ptpclient/meson.build b/examples/ptpclient/meson.build
index 2e9b7625fc..9087c987d5 100644
--- a/examples/ptpclient/meson.build
+++ b/examples/ptpclient/meson.build
@@ -7,6 +7,7 @@
 # DPDK instance, use 'make'
 
 allow_experimental_apis = true
+deps += ['net']
 sources = files(
         'ptpclient.c',
 )
diff --git a/examples/ptpclient/ptpclient.c b/examples/ptpclient/ptpclient.c
index 174ca5dd70..ee12623651 100644
--- a/examples/ptpclient/ptpclient.c
+++ b/examples/ptpclient/ptpclient.c
@@ -17,6 +17,7 @@
 #include <rte_lcore.h>
 #include <rte_mbuf.h>
 #include <rte_ip.h>
+#include <rte_ptp.h>
 #include <limits.h>
 #include <sys/time.h>
 #include <getopt.h>
@@ -30,21 +31,8 @@ static volatile bool force_quit;
 #define NUM_MBUFS            8191
 #define MBUF_CACHE_SIZE       250
 
-/* Values for the PTP messageType field. */
-#define SYNC                  0x0
-#define DELAY_REQ             0x1
-#define PDELAY_REQ            0x2
-#define PDELAY_RESP           0x3
-#define FOLLOW_UP             0x8
-#define DELAY_RESP            0x9
-#define PDELAY_RESP_FOLLOW_UP 0xA
-#define ANNOUNCE              0xB
-#define SIGNALING             0xC
-#define MANAGEMENT            0xD
-
 #define NSEC_PER_SEC        1000000000L
 #define KERNEL_TIME_ADJUST_LIMIT  20000
-#define PTP_PROTOCOL             0x88F7
 
 struct rte_mempool *mbuf_pool;
 uint32_t ptp_enabled_port_mask;
@@ -55,69 +43,39 @@ static const struct rte_ether_addr ether_multicast = {
 	.addr_bytes = {0x01, 0x1b, 0x19, 0x0, 0x0, 0x0}
 };
 
-/* Structs used for PTP handling. */
-struct __rte_packed_begin tstamp {
-	uint16_t   sec_msb;
-	uint32_t   sec_lsb;
-	uint32_t   ns;
-} __rte_packed_end;
-
-struct clock_id {
-	uint8_t id[8];
-};
-
-struct __rte_packed_begin port_id {
-	struct clock_id        clock_id;
-	uint16_t               port_number;
-} __rte_packed_end;
-
-struct __rte_packed_begin ptp_header {
-	uint8_t              msg_type;
-	uint8_t              ver;
-	uint16_t             message_length;
-	uint8_t              domain_number;
-	uint8_t              reserved1;
-	uint8_t              flag_field[2];
-	int64_t              correction;
-	uint32_t             reserved2;
-	struct port_id       source_port_id;
-	uint16_t             seq_id;
-	uint8_t              control;
-	int8_t               log_message_interval;
-} __rte_packed_end;
-
+/* Structs used for PTP handling - using library definitions from rte_ptp.h */
 struct __rte_packed_begin sync_msg {
-	struct ptp_header   hdr;
-	struct tstamp       origin_tstamp;
+	struct rte_ptp_hdr       hdr;
+	struct rte_ptp_timestamp origin_tstamp;
 } __rte_packed_end;
 
 struct __rte_packed_begin follow_up_msg {
-	struct ptp_header   hdr;
-	struct tstamp       precise_origin_tstamp;
+	struct rte_ptp_hdr       hdr;
+	struct rte_ptp_timestamp precise_origin_tstamp;
 	uint8_t             suffix[];
 } __rte_packed_end;
 
 struct __rte_packed_begin delay_req_msg {
-	struct ptp_header   hdr;
-	struct tstamp       origin_tstamp;
+	struct rte_ptp_hdr       hdr;
+	struct rte_ptp_timestamp origin_tstamp;
 } __rte_packed_end;
 
 struct __rte_packed_begin delay_resp_msg {
-	struct ptp_header    hdr;
-	struct tstamp        rx_tstamp;
-	struct port_id       req_port_id;
-	uint8_t              suffix[];
+	struct rte_ptp_hdr       hdr;
+	struct rte_ptp_timestamp rx_tstamp;
+	struct rte_ptp_port_id   req_port_id;
+	uint8_t             suffix[];
 } __rte_packed_end;
 
-struct ptp_message {
+struct __rte_packed_begin ptp_message {
 	union __rte_packed_begin {
-		struct ptp_header          header;
-		struct sync_msg            sync;
-		struct delay_req_msg       delay_req;
-		struct follow_up_msg       follow_up;
-		struct delay_resp_msg      delay_resp;
+		struct rte_ptp_hdr         header;
+		struct sync_msg      sync;
+		struct delay_req_msg delay_req;
+		struct follow_up_msg follow_up;
+		struct delay_resp_msg delay_resp;
 	} __rte_packed_end;
-};
+} __rte_packed_end;
 
 struct ptpv2_time_receiver_ordinary {
 	struct rte_mbuf *m;
@@ -125,8 +83,8 @@ struct ptpv2_time_receiver_ordinary {
 	struct timespec tstamp2;
 	struct timespec tstamp3;
 	struct timespec tstamp4;
-	struct clock_id client_clock_id;
-	struct clock_id transmitter_clock_id;
+	uint8_t client_clock_id[8];
+	uint8_t transmitter_clock_id[8];
 	struct timeval new_adj;
 	int64_t delta;
 	uint16_t portid;
@@ -272,14 +230,14 @@ print_clock_info(struct ptpv2_time_receiver_ordinary *ptp_data)
 	struct timespec net_time, sys_time;
 
 	printf("time transmitter clock id: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x",
-		ptp_data->transmitter_clock_id.id[0],
-		ptp_data->transmitter_clock_id.id[1],
-		ptp_data->transmitter_clock_id.id[2],
-		ptp_data->transmitter_clock_id.id[3],
-		ptp_data->transmitter_clock_id.id[4],
-		ptp_data->transmitter_clock_id.id[5],
-		ptp_data->transmitter_clock_id.id[6],
-		ptp_data->transmitter_clock_id.id[7]);
+		ptp_data->transmitter_clock_id[0],
+		ptp_data->transmitter_clock_id[1],
+		ptp_data->transmitter_clock_id[2],
+		ptp_data->transmitter_clock_id[3],
+		ptp_data->transmitter_clock_id[4],
+		ptp_data->transmitter_clock_id[5],
+		ptp_data->transmitter_clock_id[6],
+		ptp_data->transmitter_clock_id[7]);
 
 	printf("\nT2 - time receiver clock.  %lds %ldns",
 			(ptp_data->tstamp2.tv_sec),
@@ -356,20 +314,21 @@ delta_eval(struct ptpv2_time_receiver_ordinary *ptp_data)
 static void
 parse_sync(struct ptpv2_time_receiver_ordinary *ptp_data, uint16_t rx_tstamp_idx)
 {
-	struct ptp_header *ptp_hdr;
+	struct rte_ptp_hdr *ptp_hdr;
 
-	ptp_hdr = rte_pktmbuf_mtod_offset(ptp_data->m, struct ptp_header *,
+	ptp_hdr = rte_pktmbuf_mtod_offset(ptp_data->m, struct rte_ptp_hdr *,
 					  sizeof(struct rte_ether_hdr));
-	ptp_data->seqID_SYNC = rte_be_to_cpu_16(ptp_hdr->seq_id);
+	ptp_data->seqID_SYNC = rte_be_to_cpu_16(ptp_hdr->sequence_id);
 
 	if (ptp_data->ptpset == 0) {
-		ptp_data->transmitter_clock_id = ptp_hdr->source_port_id.clock_id;
+		memcpy(ptp_data->transmitter_clock_id,
+		       ptp_hdr->source_port_id.clock_id, 8);
 		ptp_data->ptpset = 1;
 	}
 
-	if (memcmp(&ptp_data->transmitter_clock_id,
-			&ptp_hdr->source_port_id.clock_id,
-			sizeof(struct clock_id)) == 0) {
+	if (memcmp(ptp_data->transmitter_clock_id,
+			ptp_hdr->source_port_id.clock_id,
+			8) == 0) {
 
 		if (ptp_data->ptpset == 1)
 			rte_eth_timesync_read_rx_timestamp(ptp_data->portid,
@@ -386,12 +345,11 @@ parse_fup(struct ptpv2_time_receiver_ordinary *ptp_data)
 {
 	struct rte_ether_hdr *eth_hdr;
 	struct rte_ether_addr eth_addr;
-	struct ptp_header *ptp_hdr;
-	struct clock_id *client_clkid;
+	struct rte_ptp_hdr *ptp_hdr;
 	struct ptp_message *ptp_msg;
 	struct delay_req_msg *req_msg;
 	struct rte_mbuf *created_pkt;
-	struct tstamp *origin_tstamp;
+	struct rte_ptp_timestamp *origin_tstamp;
 	struct rte_ether_addr eth_multicast = ether_multicast;
 	size_t pkt_size;
 	int wait_us;
@@ -399,22 +357,22 @@ parse_fup(struct ptpv2_time_receiver_ordinary *ptp_data)
 	int ret;
 
 	eth_hdr = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
-	ptp_hdr = rte_pktmbuf_mtod_offset(m, struct ptp_header *,
+	ptp_hdr = rte_pktmbuf_mtod_offset(m, struct rte_ptp_hdr *,
 					  sizeof(struct rte_ether_hdr));
-	if (memcmp(&ptp_data->transmitter_clock_id,
-			&ptp_hdr->source_port_id.clock_id,
-			sizeof(struct clock_id)) != 0)
+	if (memcmp(ptp_data->transmitter_clock_id,
+			ptp_hdr->source_port_id.clock_id,
+			8) != 0)
 		return;
 
-	ptp_data->seqID_FOLLOWUP = rte_be_to_cpu_16(ptp_hdr->seq_id);
+	ptp_data->seqID_FOLLOWUP = rte_be_to_cpu_16(ptp_hdr->sequence_id);
 	ptp_msg = rte_pktmbuf_mtod_offset(m, struct ptp_message *,
 					  sizeof(struct rte_ether_hdr));
 
 	origin_tstamp = &ptp_msg->follow_up.precise_origin_tstamp;
-	ptp_data->tstamp1.tv_nsec = ntohl(origin_tstamp->ns);
+	ptp_data->tstamp1.tv_nsec = rte_be_to_cpu_32(origin_tstamp->nanoseconds);
 	ptp_data->tstamp1.tv_sec =
-		((uint64_t)ntohl(origin_tstamp->sec_lsb)) |
-		(((uint64_t)ntohs(origin_tstamp->sec_msb)) << 32);
+		((uint64_t)rte_be_to_cpu_32(origin_tstamp->seconds_lo)) |
+		(((uint64_t)rte_be_to_cpu_16(origin_tstamp->seconds_hi)) << 32);
 
 	if (ptp_data->seqID_FOLLOWUP == ptp_data->seqID_SYNC) {
 		ret = rte_eth_macaddr_get(ptp_data->portid, &eth_addr);
@@ -441,34 +399,30 @@ parse_fup(struct ptpv2_time_receiver_ordinary *ptp_data)
 		/* Set multicast address 01-1B-19-00-00-00. */
 		rte_ether_addr_copy(&eth_multicast, &eth_hdr->dst_addr);
 
-		eth_hdr->ether_type = htons(PTP_PROTOCOL);
+		eth_hdr->ether_type = htons(RTE_ETHER_TYPE_1588);
 		req_msg = rte_pktmbuf_mtod_offset(created_pkt,
 			struct delay_req_msg *, sizeof(struct
 			rte_ether_hdr));
 
-		req_msg->hdr.seq_id = htons(ptp_data->seqID_SYNC);
-		req_msg->hdr.msg_type = DELAY_REQ;
-		req_msg->hdr.ver = 2;
-		req_msg->hdr.control = 1;
-		req_msg->hdr.log_message_interval = 127;
-		req_msg->hdr.message_length =
+		req_msg->hdr.sequence_id = htons(ptp_data->seqID_SYNC);
+		req_msg->hdr.msg_type = RTE_PTP_MSGTYPE_DELAY_REQ;
+		req_msg->hdr.version = 2;
+		req_msg->hdr.msg_length =
 			htons(sizeof(struct delay_req_msg));
 		req_msg->hdr.domain_number = ptp_hdr->domain_number;
 
 		/* Set up clock id. */
-		client_clkid =
-			&req_msg->hdr.source_port_id.clock_id;
-
-		client_clkid->id[0] = eth_hdr->src_addr.addr_bytes[0];
-		client_clkid->id[1] = eth_hdr->src_addr.addr_bytes[1];
-		client_clkid->id[2] = eth_hdr->src_addr.addr_bytes[2];
-		client_clkid->id[3] = 0xFF;
-		client_clkid->id[4] = 0xFE;
-		client_clkid->id[5] = eth_hdr->src_addr.addr_bytes[3];
-		client_clkid->id[6] = eth_hdr->src_addr.addr_bytes[4];
-		client_clkid->id[7] = eth_hdr->src_addr.addr_bytes[5];
-
-		ptp_data->client_clock_id = *client_clkid;
+		ptp_data->client_clock_id[0] = eth_hdr->src_addr.addr_bytes[0];
+		ptp_data->client_clock_id[1] = eth_hdr->src_addr.addr_bytes[1];
+		ptp_data->client_clock_id[2] = eth_hdr->src_addr.addr_bytes[2];
+		ptp_data->client_clock_id[3] = 0xFF;
+		ptp_data->client_clock_id[4] = 0xFE;
+		ptp_data->client_clock_id[5] = eth_hdr->src_addr.addr_bytes[3];
+		ptp_data->client_clock_id[6] = eth_hdr->src_addr.addr_bytes[4];
+		ptp_data->client_clock_id[7] = eth_hdr->src_addr.addr_bytes[5];
+
+		memcpy(req_msg->hdr.source_port_id.clock_id,
+		       ptp_data->client_clock_id, 8);
 
 		/* Enable flag for hardware timestamping. */
 		created_pkt->ol_flags |= RTE_MBUF_F_TX_IEEE1588_TMST;
@@ -534,21 +488,21 @@ parse_drsp(struct ptpv2_time_receiver_ordinary *ptp_data)
 {
 	struct rte_mbuf *m = ptp_data->m;
 	struct ptp_message *ptp_msg;
-	struct tstamp *rx_tstamp;
+	struct rte_ptp_timestamp *rx_tstamp;
 	uint16_t seq_id;
 
 	ptp_msg = rte_pktmbuf_mtod_offset(m, struct ptp_message *,
 					  sizeof(struct rte_ether_hdr));
-	seq_id = rte_be_to_cpu_16(ptp_msg->delay_resp.hdr.seq_id);
-	if (memcmp(&ptp_data->client_clock_id,
-		   &ptp_msg->delay_resp.req_port_id.clock_id,
-		   sizeof(struct clock_id)) == 0) {
+	seq_id = rte_be_to_cpu_16(ptp_msg->delay_resp.hdr.sequence_id);
+	if (memcmp(ptp_data->client_clock_id,
+		   ptp_msg->delay_resp.req_port_id.clock_id,
+		   8) == 0) {
 		if (seq_id == ptp_data->seqID_FOLLOWUP) {
 			rx_tstamp = &ptp_msg->delay_resp.rx_tstamp;
-			ptp_data->tstamp4.tv_nsec = ntohl(rx_tstamp->ns);
+			ptp_data->tstamp4.tv_nsec = rte_be_to_cpu_32(rx_tstamp->nanoseconds);
 			ptp_data->tstamp4.tv_sec =
-				((uint64_t)ntohl(rx_tstamp->sec_lsb)) |
-				(((uint64_t)ntohs(rx_tstamp->sec_msb)) << 32);
+				((uint64_t)rte_be_to_cpu_32(rx_tstamp->seconds_lo)) |
+				(((uint64_t)rte_be_to_cpu_16(rx_tstamp->seconds_hi)) << 32);
 
 			/* Evaluate the delta for adjustment. */
 			ptp_data->delta = delta_eval(ptp_data);
@@ -575,27 +529,29 @@ parse_drsp(struct ptpv2_time_receiver_ordinary *ptp_data)
 /* Parse ptp frames. 8< */
 static void
 parse_ptp_frames(uint16_t portid, struct rte_mbuf *m) {
-	struct ptp_header *ptp_hdr;
+	struct rte_ptp_hdr *ptp_hdr;
 	struct rte_ether_hdr *eth_hdr;
 	uint16_t eth_type;
+	uint8_t msg_type;
 
 	eth_hdr = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
 	eth_type = rte_be_to_cpu_16(eth_hdr->ether_type);
 
-	if (eth_type == PTP_PROTOCOL) {
+	if (eth_type == RTE_ETHER_TYPE_1588) {
 		ptp_data.m = m;
 		ptp_data.portid = portid;
-		ptp_hdr = rte_pktmbuf_mtod_offset(m, struct ptp_header *,
+		ptp_hdr = rte_pktmbuf_mtod_offset(m, struct rte_ptp_hdr *,
 						  sizeof(struct rte_ether_hdr));
 
-		switch (ptp_hdr->msg_type) {
-		case SYNC:
+		msg_type = ptp_hdr->msg_type;
+		switch (msg_type) {
+		case RTE_PTP_MSGTYPE_SYNC:
 			parse_sync(&ptp_data, m->timesync);
 			break;
-		case FOLLOW_UP:
+		case RTE_PTP_MSGTYPE_FU:
 			parse_fup(&ptp_data);
 			break;
-		case DELAY_RESP:
+		case RTE_PTP_MSGTYPE_DELAY_RESP:
 			parse_drsp(&ptp_data);
 			print_clock_info(&ptp_data);
 			break;
-- 
2.53.0

