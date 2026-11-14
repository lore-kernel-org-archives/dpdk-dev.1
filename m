Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D43606A323
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Nov 2026 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=c+bppRxL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A9AB4025A;
	Sat, 14 Nov 2026 19:57:07 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mails.dpdk.org (Postfix) with ESMTPS id D34D74021E
 for <dev@dpdk.org>; Sat, 14 Nov 2026 19:57:05 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3b179528d56so983568a91.3
 for <dev@dpdk.org>; Sat, 14 Nov 2026 10:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794682624;
 x=1795287424; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A+Td/NIXZG6xWP1jt1OmlmD9LoKvqG7nM5b72PyIXxs=;
 b=c+bppRxL/Vna9Lxd5ACOL31DqxPEFCp2qk91T/EZ6FUUAEFrEa0BcaEByk85++j5jK
 z1GtusQtqWT3e8VDE8z1gQhPFVI33S7AhzSIHSQImJ9jWS7neZBI/9FOuBVa8VrQazDv
 MAvU01y0yolYx2yoeXn3O/QQyJXuhfk624CJ0RhuHUKOReiA5ulGr0zWsTjwPBhtLChE
 mJqkpEzzgmuhjaEi2SpMTxewvk0Al3d5m5F5qDGYV3SDo33cNA20UmT2z9NmEAfsQFxz
 T8gnlpBbqmrIslTtNp84zS+0M/jOripHQ12XFNkn67uZmgix5GVi0dVlxnqxDjlWcWvk
 6nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794682624; x=1795287424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A+Td/NIXZG6xWP1jt1OmlmD9LoKvqG7nM5b72PyIXxs=;
 b=MUDW/QXNZrP+0/GHbJzlvzjafar51Thy0DuWtwgaieuAGVpFB1C6/OkfcC54XER6wH
 j1U39Q1sexnsqTJoOHYo+ug0oQT/S95OE6Xu7eJQmCwnjeJz42wC/jE0F3Zs3/JSFWpz
 TztA6R0/GacVqhlyENJ9rpHtRdeB1ECbizTMwLZP65v7dSsGkiDddV1zBDCEJ3nzaV7S
 oKUDT2a1pZx91UP7puA6fFolY/ukJ3wBZ1X3vC057kt4L+U4LRZV4KAJxhQugcRdC/3i
 YuhLs9xVlqZgUXjSWs2vd/VR946zrG0m0AqPlCLsvQ/AG6XBHqx6NBDV1gSZl0cZX7QJ
 CYJg==
X-Gm-Message-State: APuU4Z9jMItElOesV6LnwOTr3z3Ru7qiZlTjHeSm0LXHPPSJfKc7FFKk
 rTcUCQ0YBGmzjmeYffuWktgIzWCpbrmTXGZUUjoH+Nk0pFAvvJNKiIKN15I4a5K04V+utfZv5yo
 tnpDJAno=
X-Gm-Gg: AYBFou1zfAZe4E8b577VjxZh066bZyzqTcS1thvpaexvqcxaIxEFodFZuGpNMCr8f80
 nrn5eoQCxrFwRauC+uey1CqW0uph2wyfuFCdpxOtLuHnbO5wzNdkCDi0mHxGV8R+nxuo0vSbYg4
 GlnaYx14+pzA80+/06RNmyEUGue7mMmmkheT/xdsWgQjWdL0hp7BF3cVX1hz+mbacq6S66yMTQY
 UVz2hLD76NyTTLKI6b70kCCP4v4kHy5hh0Lwzy5AhLcPjBOu/iTNneNMTRgdc7GnjYAE1XdsKmb
 G5pYIhN4ADkpBIHYfJh3Rhd1P4rwiu3AceLDtNKhhezOLK9dBNTEo5XUwOIHg7kasHhQiJER8vF
 YnW9tZNg9EuVSAC88qes3VoyC27xA+oebt1a+nehbgItlVBzxZLhRNo27647v2xCsup2IOnln8R
 NNkA8UTj8xp0KG3qEn1qtjEh1JgwGOknEd86Bax1pPvUx+3HvTmacaJraJjmr54/J5gmBiJj37V
 X6t++EW3K4rH6jChLCu+clVVdO/BT2ur4I1QbwyiKa3xQb8bnVxd4bmxOMTl/qt47V3oq74ofhp
 Bh0nUELNS3TETw8hzrlNPQjX6x97UmIk8wTjLhox+1Am6gM8JWOkqtigl6EGL/LCbe2wiFU=
X-Received: by 2002:a17:90b:498f:b0:3b1:4018:bfdd with SMTP id
 98e67ed59e1d1-3b1b07e8596mr4965128a91.7.1794682623747; 
 Sat, 14 Nov 2026 10:57:03 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197ce460csm14591624a91.5.2026.11.14.10.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 10:57:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH 1/2] net/pcap: fix Rx timestamp in secondary process
Date: Sat, 14 Nov 2026 10:57:00 -0800
Message-ID: <20261114185701.833180-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The offset and flag of the Rx timestamp dynamic field are the same
in all processes, but the driver keeps them in static variables
which are only set in dev_configure. A secondary process does not
configure the port, so its copy of the offset is still -1 while the
shared device data says the offload is enabled. The Rx burst then
stores the timestamp over buf_addr of the mbuf.

Move the offset and flag into the device private data, which is
shared with secondary processes.

Bugzilla ID: 2128
Fixes: 32fd14bf07f8 ("net/pcap: support nanosecond timestamp precision")
Cc: stable@dpdk.org

Reported-by: Anthropic OSS Scanner (ANT-2026-80N5ICNL)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 1e114e0008..b89f4a0c2e 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -60,9 +60,6 @@ static struct timespec start_time;
 static uint64_t start_cycles;
 static uint64_t hz;
 
-static uint64_t timestamp_rx_dynflag;
-static int timestamp_dynfield_offset = -1;
-
 struct queue_stat {
 	volatile unsigned long pkts;
 	volatile unsigned long bytes;
@@ -122,6 +119,8 @@ struct pmd_internals {
 	bool rx_scatter;
 	bool timestamp_offloading;
 	bool lsc_active;
+	int timestamp_dynfield_offset;
+	uint64_t timestamp_rx_dynflag;
 };
 
 struct pmd_process_private {
@@ -268,6 +267,7 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	int i;
 	struct pcap_rx_queue *pcap_q = queue;
+	struct pmd_internals *internals = rte_eth_devices[pcap_q->port_id].data->dev_private;
 	uint32_t rx_bytes = 0;
 
 	if (unlikely(nb_pkts == 0))
@@ -296,9 +296,9 @@ eth_pcap_rx_infinite(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			struct timespec ts;
 
 			timespec_get(&ts, TIME_UTC);
-			*RTE_MBUF_DYNFIELD(bufs[i], timestamp_dynfield_offset,
+			*RTE_MBUF_DYNFIELD(bufs[i], internals->timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) = rte_timespec_to_ns(&ts);
-			bufs[i]->ol_flags |= timestamp_rx_dynflag;
+			bufs[i]->ol_flags |= internals->timestamp_rx_dynflag;
 		}
 
 		rx_bytes += bufs[i]->data_len;
@@ -420,10 +420,10 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			uint64_t ns = (uint64_t)header->ts.tv_sec * NSEC_PER_SEC
 				+  header->ts.tv_usec;
 
-			*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset,
+			*RTE_MBUF_DYNFIELD(mbuf, internals->timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) = ns;
 
-			mbuf->ol_flags |= timestamp_rx_dynflag;
+			mbuf->ol_flags |= internals->timestamp_rx_dynflag;
 		}
 
 		mbuf->port = pcap_q->port_id;
@@ -1027,9 +1027,9 @@ eth_dev_configure(struct rte_eth_dev *dev)
 	internals->rx_scatter = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_SCATTER);
 	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 
-	if (internals->timestamp_offloading && timestamp_rx_dynflag == 0) {
-		int ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
-							     &timestamp_rx_dynflag);
+	if (internals->timestamp_offloading && internals->timestamp_rx_dynflag == 0) {
+		int ret = rte_mbuf_dyn_rx_timestamp_register(&internals->timestamp_dynfield_offset,
+							     &internals->timestamp_rx_dynflag);
 		if (ret != 0) {
 			PMD_LOG(ERR, "Failed to register Rx timestamp field/flag");
 			return ret;
-- 
2.53.0

