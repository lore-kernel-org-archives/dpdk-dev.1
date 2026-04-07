Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76F5FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:53:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B61C94068E;
	Tue,  7 Apr 2026 05:52:30 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 747E540670
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:26 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso4323611eec.1
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533945;
 x=1776138745; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rt2lI4JyXpW8P9B+MTomDNpM3H2q4uLEd5fWqsABt0E=;
 b=NeJAHyyQXbOkQt2Jyu5rgVUi3OCNiQ1piKZhNCmz9iJEY9M0DT+gDncKHMtoh6215k
 hTEmmZ3aZ8FijmFbn5wL5YMrQ2riT99t+XhdViQLBF+10+EaMpC5Bn5yngf4SPT+m9Pm
 uGDeEkGuZIeaAHc2yCwosX/uDM3y3cMb5e9ys+R/9xFf9vKLpU00OFZ+bJ+GMJXxkQeI
 vTUuQ/KgJ7xTXZdnxO43BmbSqBL1soMPG9T/tW1NVY6MRS6XWVwIXAe94xnAMC4tSJwz
 cuXBjf4cpCrfiKce9VVjeFYQWUwziJUp39jDq07J5MkoGKDBTJanodRwzpxapszNuxc7
 5aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533945; x=1776138745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rt2lI4JyXpW8P9B+MTomDNpM3H2q4uLEd5fWqsABt0E=;
 b=swW0fqUXret4TvSJC6nTFlvsprzfI8uZkL7dBq44vLKYYNfHJDiX0RtR6L4ylCS7Ll
 CofaytFGfQ5dF3K9/iQpaswm0jugBVro9GVGaMfotaa67NFv0Xnzy7FXQfd5kvORoqWM
 Ym261gjw3z21nc4tCHLAXQ4DWD0ar1kqeo4E1G35uEWdnl6TYvSv6hTPucWiJuiazt9n
 lAPT3kxPsSvE5BqvwU/2oZDF6TIxUDNGbXKFDiajr1OyA4Ep+aYzOTxvzjjZp8oYAm3d
 nUKYEnXC1RdDsGacQ9KsP2cU0pplfBMeU+e3uB0lgLXzJcggz/IGY+KhEOfr57Qtq6hl
 lBfg==
X-Gm-Message-State: AOJu0Yx22ISmib9DjqMire+X3jZs7gHiTUUIXnjJJWAQVPJEC15ZrxQf
 rp6ToAE9msWqwgXhTR/09zYNnwQyecyBpKuy2HVIMbvodF81JEE3siZmKn88bAtLjCzmjtPpX8I
 L/kAE
X-Gm-Gg: AeBDieum48ZJEu4iShJEz9/PzqZJFkXkQcCVgSfXXzYFkaR1RQ7KUMMtUXhpj+V37qM
 ZOonaym8sf4CGl07XvJ2Y1R9dznWN36c6bkGtMx/wGYqB56cvCYU2OXYNxJgSqW4uaJiXgLNuJw
 r79gQfioW7CfK1Vb62p4T8e4MguAinQbCcVu8ZyxR2+UGMFGTAWdsV1uyJLFiut/Sq8+0Dqhued
 CCUoqhm/3tOFg32l6PaDCT3opicvmDO8FHip66o0xCgm9LqSpHfXTH9mANp2DZH/U2KxSj00mX8
 JSrUGWobYduy85BaO5Fa7a6lp5MGTl+eOgrZ0jg5/l5w80rGh7rZZBt/9JPSBFLg8ITuS2tHCZu
 927cFfwlI3ryU0D3o/r8Bft3PtxBdzJl8wkaRUA7KQy5SZiR9tAKe3fndmpeUu0/zGU0kC0eHbp
 NQKJHthZikCipWbldCelF4CXpVBJ756BFN
X-Received: by 2002:a05:7022:61f:b0:12a:6fb7:8801 with SMTP id
 a92af1059eb24-12bfb7074cfmr7164954c88.14.1775533945376; 
 Mon, 06 Apr 2026 20:52:25 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kirill Rybalchenko <kirill.rybalchenko@intel.com>
Subject: [PATCH 14/23] examples/ptpclient: fix shadow variable warnings
Date: Mon,  6 Apr 2026 20:49:40 -0700
Message-ID: <20260407035209.650419-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

Rename function parameters that shadow global variables.
In port_init() rename mbuf_pool to mp, and in print_clock_info(),
delta_eval(), parse_sync(), parse_fup(), and parse_drsp()
rename ptp_data to ptp.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/ptpclient/meson.build |   1 -
 examples/ptpclient/ptpclient.c | 138 ++++++++++++++++-----------------
 2 files changed, 69 insertions(+), 70 deletions(-)

diff --git a/examples/ptpclient/meson.build b/examples/ptpclient/meson.build
index 2e9b7625fc..47d091ea21 100644
--- a/examples/ptpclient/meson.build
+++ b/examples/ptpclient/meson.build
@@ -10,4 +10,3 @@ allow_experimental_apis = true
 sources = files(
         'ptpclient.c',
 )
-cflags += no_shadow_cflag
diff --git a/examples/ptpclient/ptpclient.c b/examples/ptpclient/ptpclient.c
index 174ca5dd70..8e1560a3ac 100644
--- a/examples/ptpclient/ptpclient.c
+++ b/examples/ptpclient/ptpclient.c
@@ -173,7 +173,7 @@ ns_to_timeval(int64_t nsec)
  * coming from the mbuf_pool passed as a parameter.
  */
 static inline int
-port_init(uint16_t port, struct rte_mempool *mbuf_pool)
+port_init(uint16_t port, struct rte_mempool *mp)
 {
 	struct rte_eth_dev_info dev_info;
 	struct rte_eth_conf port_conf;
@@ -223,7 +223,7 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 		rxconf->offloads = port_conf.rxmode.offloads;
 
 		retval = rte_eth_rx_queue_setup(port, q, nb_rxd,
-				rte_eth_dev_socket_id(port), rxconf, mbuf_pool);
+				rte_eth_dev_socket_id(port), rxconf, mp);
 
 		if (retval < 0)
 			return retval;
@@ -266,42 +266,42 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 }
 
 static void
-print_clock_info(struct ptpv2_time_receiver_ordinary *ptp_data)
+print_clock_info(struct ptpv2_time_receiver_ordinary *ptp)
 {
 	int64_t nsec;
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
+		ptp->transmitter_clock_id.id[0],
+		ptp->transmitter_clock_id.id[1],
+		ptp->transmitter_clock_id.id[2],
+		ptp->transmitter_clock_id.id[3],
+		ptp->transmitter_clock_id.id[4],
+		ptp->transmitter_clock_id.id[5],
+		ptp->transmitter_clock_id.id[6],
+		ptp->transmitter_clock_id.id[7]);
 
 	printf("\nT2 - time receiver clock.  %lds %ldns",
-			(ptp_data->tstamp2.tv_sec),
-			(ptp_data->tstamp2.tv_nsec));
+			(ptp->tstamp2.tv_sec),
+			(ptp->tstamp2.tv_nsec));
 
 	printf("\nT1 - time transmitter clock.  %lds %ldns ",
-			ptp_data->tstamp1.tv_sec,
-			(ptp_data->tstamp1.tv_nsec));
+			ptp->tstamp1.tv_sec,
+			(ptp->tstamp1.tv_nsec));
 
 	printf("\nT3 - time receiver clock.  %lds %ldns",
-			ptp_data->tstamp3.tv_sec,
-			(ptp_data->tstamp3.tv_nsec));
+			ptp->tstamp3.tv_sec,
+			(ptp->tstamp3.tv_nsec));
 
 	printf("\nT4 - time transmitter clock.  %lds %ldns\n",
-			ptp_data->tstamp4.tv_sec,
-			(ptp_data->tstamp4.tv_nsec));
+			ptp->tstamp4.tv_sec,
+			(ptp->tstamp4.tv_nsec));
 
 	printf("\nDelta between transmitter and receiver clocks:%"PRId64"ns\n",
-		ptp_data->delta);
+		ptp->delta);
 
 	clock_gettime(CLOCK_REALTIME, &sys_time);
-	rte_eth_timesync_read_time(ptp_data->current_ptp_port,
+	rte_eth_timesync_read_time(ptp->current_ptp_port,
 					&net_time);
 
 	time_t ts = net_time.tv_sec;
@@ -313,14 +313,14 @@ print_clock_info(struct ptpv2_time_receiver_ordinary *ptp_data)
 
 	nsec = (int64_t)timespec64_to_ns(&net_time) -
 		(int64_t)timespec64_to_ns(&sys_time);
-	ptp_data->new_adj = ns_to_timeval(nsec);
+	ptp->new_adj = ns_to_timeval(nsec);
 
-	gettimeofday(&ptp_data->new_adj, NULL);
+	gettimeofday(&ptp->new_adj, NULL);
 
-	time_t tp = ptp_data->new_adj.tv_sec;
+	time_t tp = ptp->new_adj.tv_sec;
 
 	printf("\nCurrent SYS Time: %.24s %.6ld ns",
-		ctime(&tp), ptp_data->new_adj.tv_usec);
+		ctime(&tp), ptp->new_adj.tv_usec);
 
 	printf("\nDelta between PTP and Linux Kernel time:%"PRId64"ns\n",
 		nsec);
@@ -332,7 +332,7 @@ print_clock_info(struct ptpv2_time_receiver_ordinary *ptp_data)
 }
 
 static int64_t
-delta_eval(struct ptpv2_time_receiver_ordinary *ptp_data)
+delta_eval(struct ptpv2_time_receiver_ordinary *ptp)
 {
 	int64_t delta;
 	uint64_t t1 = 0;
@@ -340,10 +340,10 @@ delta_eval(struct ptpv2_time_receiver_ordinary *ptp_data)
 	uint64_t t3 = 0;
 	uint64_t t4 = 0;
 
-	t1 = timespec64_to_ns(&ptp_data->tstamp1);
-	t2 = timespec64_to_ns(&ptp_data->tstamp2);
-	t3 = timespec64_to_ns(&ptp_data->tstamp3);
-	t4 = timespec64_to_ns(&ptp_data->tstamp4);
+	t1 = timespec64_to_ns(&ptp->tstamp1);
+	t2 = timespec64_to_ns(&ptp->tstamp2);
+	t3 = timespec64_to_ns(&ptp->tstamp3);
+	t4 = timespec64_to_ns(&ptp->tstamp4);
 
 	delta = -((int64_t)((t2 - t1) - (t4 - t3))) / 2;
 
@@ -354,26 +354,26 @@ delta_eval(struct ptpv2_time_receiver_ordinary *ptp_data)
  * Parse the PTP SYNC message.
  */
 static void
-parse_sync(struct ptpv2_time_receiver_ordinary *ptp_data, uint16_t rx_tstamp_idx)
+parse_sync(struct ptpv2_time_receiver_ordinary *ptp, uint16_t rx_tstamp_idx)
 {
 	struct ptp_header *ptp_hdr;
 
-	ptp_hdr = rte_pktmbuf_mtod_offset(ptp_data->m, struct ptp_header *,
+	ptp_hdr = rte_pktmbuf_mtod_offset(ptp->m, struct ptp_header *,
 					  sizeof(struct rte_ether_hdr));
-	ptp_data->seqID_SYNC = rte_be_to_cpu_16(ptp_hdr->seq_id);
+	ptp->seqID_SYNC = rte_be_to_cpu_16(ptp_hdr->seq_id);
 
-	if (ptp_data->ptpset == 0) {
-		ptp_data->transmitter_clock_id = ptp_hdr->source_port_id.clock_id;
-		ptp_data->ptpset = 1;
+	if (ptp->ptpset == 0) {
+		ptp->transmitter_clock_id = ptp_hdr->source_port_id.clock_id;
+		ptp->ptpset = 1;
 	}
 
-	if (memcmp(&ptp_data->transmitter_clock_id,
+	if (memcmp(&ptp->transmitter_clock_id,
 			&ptp_hdr->source_port_id.clock_id,
 			sizeof(struct clock_id)) == 0) {
 
-		if (ptp_data->ptpset == 1)
-			rte_eth_timesync_read_rx_timestamp(ptp_data->portid,
-					&ptp_data->tstamp2, rx_tstamp_idx);
+		if (ptp->ptpset == 1)
+			rte_eth_timesync_read_rx_timestamp(ptp->portid,
+					&ptp->tstamp2, rx_tstamp_idx);
 	}
 
 }
@@ -382,7 +382,7 @@ parse_sync(struct ptpv2_time_receiver_ordinary *ptp_data, uint16_t rx_tstamp_idx
  * Parse the PTP FOLLOWUP message and send DELAY_REQ to the main clock.
  */
 static void
-parse_fup(struct ptpv2_time_receiver_ordinary *ptp_data)
+parse_fup(struct ptpv2_time_receiver_ordinary *ptp)
 {
 	struct rte_ether_hdr *eth_hdr;
 	struct rte_ether_addr eth_addr;
@@ -395,32 +395,32 @@ parse_fup(struct ptpv2_time_receiver_ordinary *ptp_data)
 	struct rte_ether_addr eth_multicast = ether_multicast;
 	size_t pkt_size;
 	int wait_us;
-	struct rte_mbuf *m = ptp_data->m;
+	struct rte_mbuf *m = ptp->m;
 	int ret;
 
 	eth_hdr = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
 	ptp_hdr = rte_pktmbuf_mtod_offset(m, struct ptp_header *,
 					  sizeof(struct rte_ether_hdr));
-	if (memcmp(&ptp_data->transmitter_clock_id,
+	if (memcmp(&ptp->transmitter_clock_id,
 			&ptp_hdr->source_port_id.clock_id,
 			sizeof(struct clock_id)) != 0)
 		return;
 
-	ptp_data->seqID_FOLLOWUP = rte_be_to_cpu_16(ptp_hdr->seq_id);
+	ptp->seqID_FOLLOWUP = rte_be_to_cpu_16(ptp_hdr->seq_id);
 	ptp_msg = rte_pktmbuf_mtod_offset(m, struct ptp_message *,
 					  sizeof(struct rte_ether_hdr));
 
 	origin_tstamp = &ptp_msg->follow_up.precise_origin_tstamp;
-	ptp_data->tstamp1.tv_nsec = ntohl(origin_tstamp->ns);
-	ptp_data->tstamp1.tv_sec =
+	ptp->tstamp1.tv_nsec = ntohl(origin_tstamp->ns);
+	ptp->tstamp1.tv_sec =
 		((uint64_t)ntohl(origin_tstamp->sec_lsb)) |
 		(((uint64_t)ntohs(origin_tstamp->sec_msb)) << 32);
 
-	if (ptp_data->seqID_FOLLOWUP == ptp_data->seqID_SYNC) {
-		ret = rte_eth_macaddr_get(ptp_data->portid, &eth_addr);
+	if (ptp->seqID_FOLLOWUP == ptp->seqID_SYNC) {
+		ret = rte_eth_macaddr_get(ptp->portid, &eth_addr);
 		if (ret != 0) {
 			printf("\nCore %u: port %u failed to get MAC address: %s\n",
-				rte_lcore_id(), ptp_data->portid,
+				rte_lcore_id(), ptp->portid,
 				rte_strerror(-ret));
 			return;
 		}
@@ -446,7 +446,7 @@ parse_fup(struct ptpv2_time_receiver_ordinary *ptp_data)
 			struct delay_req_msg *, sizeof(struct
 			rte_ether_hdr));
 
-		req_msg->hdr.seq_id = htons(ptp_data->seqID_SYNC);
+		req_msg->hdr.seq_id = htons(ptp->seqID_SYNC);
 		req_msg->hdr.msg_type = DELAY_REQ;
 		req_msg->hdr.ver = 2;
 		req_msg->hdr.control = 1;
@@ -468,25 +468,25 @@ parse_fup(struct ptpv2_time_receiver_ordinary *ptp_data)
 		client_clkid->id[6] = eth_hdr->src_addr.addr_bytes[4];
 		client_clkid->id[7] = eth_hdr->src_addr.addr_bytes[5];
 
-		ptp_data->client_clock_id = *client_clkid;
+		ptp->client_clock_id = *client_clkid;
 
 		/* Enable flag for hardware timestamping. */
 		created_pkt->ol_flags |= RTE_MBUF_F_TX_IEEE1588_TMST;
 
 		/*Read value from NIC to prevent latching with old value. */
-		rte_eth_timesync_read_tx_timestamp(ptp_data->portid,
-				&ptp_data->tstamp3);
+		rte_eth_timesync_read_tx_timestamp(ptp->portid,
+				&ptp->tstamp3);
 
 		/* Transmit the packet. */
-		rte_eth_tx_burst(ptp_data->portid, 0, &created_pkt, 1);
+		rte_eth_tx_burst(ptp->portid, 0, &created_pkt, 1);
 
 		wait_us = 0;
-		ptp_data->tstamp3.tv_nsec = 0;
-		ptp_data->tstamp3.tv_sec = 0;
+		ptp->tstamp3.tv_nsec = 0;
+		ptp->tstamp3.tv_sec = 0;
 
 		/* Wait at least 1 us to read TX timestamp. */
-		while ((rte_eth_timesync_read_tx_timestamp(ptp_data->portid,
-				&ptp_data->tstamp3) < 0) && (wait_us < 1000)) {
+		while ((rte_eth_timesync_read_tx_timestamp(ptp->portid,
+				&ptp->tstamp3) < 0) && (wait_us < 1000)) {
 			rte_delay_us(1);
 			wait_us++;
 		}
@@ -530,9 +530,9 @@ update_kernel_time(void)
  * Parse the DELAY_RESP message.
  */
 static void
-parse_drsp(struct ptpv2_time_receiver_ordinary *ptp_data)
+parse_drsp(struct ptpv2_time_receiver_ordinary *ptp)
 {
-	struct rte_mbuf *m = ptp_data->m;
+	struct rte_mbuf *m = ptp->m;
 	struct ptp_message *ptp_msg;
 	struct tstamp *rx_tstamp;
 	uint16_t seq_id;
@@ -540,26 +540,26 @@ parse_drsp(struct ptpv2_time_receiver_ordinary *ptp_data)
 	ptp_msg = rte_pktmbuf_mtod_offset(m, struct ptp_message *,
 					  sizeof(struct rte_ether_hdr));
 	seq_id = rte_be_to_cpu_16(ptp_msg->delay_resp.hdr.seq_id);
-	if (memcmp(&ptp_data->client_clock_id,
+	if (memcmp(&ptp->client_clock_id,
 		   &ptp_msg->delay_resp.req_port_id.clock_id,
 		   sizeof(struct clock_id)) == 0) {
-		if (seq_id == ptp_data->seqID_FOLLOWUP) {
+		if (seq_id == ptp->seqID_FOLLOWUP) {
 			rx_tstamp = &ptp_msg->delay_resp.rx_tstamp;
-			ptp_data->tstamp4.tv_nsec = ntohl(rx_tstamp->ns);
-			ptp_data->tstamp4.tv_sec =
+			ptp->tstamp4.tv_nsec = ntohl(rx_tstamp->ns);
+			ptp->tstamp4.tv_sec =
 				((uint64_t)ntohl(rx_tstamp->sec_lsb)) |
 				(((uint64_t)ntohs(rx_tstamp->sec_msb)) << 32);
 
 			/* Evaluate the delta for adjustment. */
-			ptp_data->delta = delta_eval(ptp_data);
+			ptp->delta = delta_eval(ptp);
 
-			rte_eth_timesync_adjust_time(ptp_data->portid,
-							ptp_data->delta);
+			rte_eth_timesync_adjust_time(ptp->portid,
+							ptp->delta);
 
-			ptp_data->current_ptp_port = ptp_data->portid;
+			ptp->current_ptp_port = ptp->portid;
 
 			/* Update kernel time if enabled in app parameters. */
-			if (ptp_data->kernel_time_set == 1)
+			if (ptp->kernel_time_set == 1)
 				update_kernel_time();
 
 
-- 
2.53.0

