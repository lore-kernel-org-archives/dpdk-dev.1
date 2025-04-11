Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A8AC369AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 23:51:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F07B140E54;
	Sat, 12 Apr 2025 01:49:57 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 59AB040E2A
 for <dev@dpdk.org>; Sat, 12 Apr 2025 01:49:51 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3014678689aso2101023a91.0
 for <dev@dpdk.org>; Fri, 11 Apr 2025 16:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744415390;
 x=1745020190; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsH72RlOTFHnndUd7UdNFki04Fnxc94ogqsB/lipzMg=;
 b=v+Y1RTEhqtM1PrT5EGeKxviSNnjEvQCFG1nJ+1A1cXrPyWXEOUil6TBI2Ay6j1oZYM
 EBlgONmufavl0icgld5BzxV49lRiB81hhXaKzC9fX9/EUYfO6u1fr2T23htFQfgGaARJ
 ptk7mlmbaxcxv1aU9eD9om+QATcTSDreS2ATUw1UwRyh9kCduz3Jhhqjj65FlFvKPsuC
 zuCBrBsUeBRgdfQ4obJIgiUGDy5bWSg4DB83WAGzLzmXHPlRYX+rS4Q/An4BUStr3h9l
 Z6Y6rJnZSU5qcNwY6Cfh3m8eajh8FJhRQT93Jjya95FbBtfYRceTRfHJLWbF7TKpJLcd
 /N1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744415390; x=1745020190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bsH72RlOTFHnndUd7UdNFki04Fnxc94ogqsB/lipzMg=;
 b=WZ8Vt5UQyOK1S1sPvaYAz7tJlJW+6LTDhYA/QOYgHtxzqbYSuBLuMgdAGARLdo22FE
 eDvtweZifyPq+pni5BQquc9NO0mYXEOuVn9f2EQABO5gI62JvuR5mbj+IDyt94lLsYEA
 bBRj9t0+W18tzBbYE2thhtvDE+ATrrMP6GBGmvPUeHv/hamRjI4ATCg1sIwZXmIYdKNj
 2mk4O9YYQEGFwGY+D+4S2ntKpMIvHRXe42K+LjXm/NnYPlszUtUupkccB9FOJCat4nHp
 0K74PwvfrQblBLUYWbdVxqWYLStmlCZ/6xg3U2YAiO++efM7kIZz1PLas0zauBbnmF5h
 tS2g==
X-Gm-Message-State: AOJu0YzGky81DtMnM25CEQYvCqkKpAPBaGPnRvjXyAzX4udqnfVuiOGc
 Tnu4750zduub7tCLT9fW1+nn7jALUEaL9Fz+Z2Q102W3bIdSV3g3qpgohD7CTS3EpDXFhywLELS
 s
X-Gm-Gg: ASbGncsJRWieqySmKXxmD4syz8B/W5ZTPoLSYb7MoEwHmnn0VXMYhhyeP4xe8PBsLNw
 JVPEBuX6PQLaIKjho3Ro+Ps8reOlrWpnucEyNhm+hTsom8ir1lFLV8dp1hYVldVhiPs72ej7Nlu
 bqPdadrgi4rhfKV2RdVPmmSHG1J76mDekNAkcod8YxkZJyyUCJ3YpsNTV0jpXLAYhxBOw1iu8B6
 uD0giZbU33ehheOU2bLEQDKeCQg+lIh2FjaycJd8lTachFon5GpFdESNrkq4ZJkAxsvtcAZkBve
 OwJn20WxePyebzi7fPgLcYYoc/q24Ku2QrBr8dmNhwb44Zcpsb9ORobVDvzrdWgiDB5n3gOlYtq
 lsAWpQ78bcD/34NgR
X-Google-Smtp-Source: AGHT+IHLyUALyyKrUh9wYJA3FcSRKiYD1tT++loC3whvd3ZR0JPgSdairkaIziH2CKv3LhkbYFFrcg==
X-Received: by 2002:a17:90b:1f8b:b0:306:b6f7:58ba with SMTP id
 98e67ed59e1d1-30823623389mr6395305a91.6.1744415390252; 
 Fri, 11 Apr 2025 16:49:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm6538661a91.12.2025.04.11.16.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 16:49:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [RFC 13/13] app/dumpcap: use port mirror instead of pdump
Date: Fri, 11 Apr 2025 16:44:50 -0700
Message-ID: <20250411234927.114568-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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

Use the new port mirror API instead of pdump.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c      | 361 +++++++++++++++++++++++++++++++---------
 app/dumpcap/meson.build |   2 +-
 2 files changed, 284 insertions(+), 79 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..7adbab71c8 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -36,8 +36,6 @@
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
 #include <rte_pcapng.h>
-#include <rte_pdump.h>
-#include <rte_ring.h>
 #include <rte_string_fns.h>
 #include <rte_thread.h>
 #include <rte_time.h>
@@ -92,16 +90,22 @@ struct capture_options {
 struct interface {
 	TAILQ_ENTRY(interface) next;
 	uint16_t port;
+	struct rte_bpf *filter;
+	uint64_t filteraccept;
 	struct capture_options opts;
-	struct rte_bpf_prm *bpf_prm;
 	char name[RTE_ETH_NAME_MAX_LEN];
 
+	struct rte_eth_stats start_stats;
 	const char *ifname;
 	const char *ifdescr;
 };
 
+static int timestamp_dynfield = -1;
+static uint64_t timestamp_dynflag;
+
 TAILQ_HEAD(interface_list, interface);
 static struct interface_list interfaces = TAILQ_HEAD_INITIALIZER(interfaces);
+static struct interface *port2intf[RTE_MAX_ETHPORTS];
 
 /* Can do either pcap or pcapng format output */
 typedef union {
@@ -239,14 +243,16 @@ static void find_interfaces(void)
 
 	TAILQ_FOREACH(intf, &interfaces, next) {
 		/* if name is valid then just record port */
-		if (rte_eth_dev_get_port_by_name(intf->name, &intf->port) == 0)
-			continue;
+		if (rte_eth_dev_get_port_by_name(intf->name, &intf->port) != 0) {
+			/* maybe got passed port number string as name */
+			intf->port = get_uint(intf->name, "port_number", UINT16_MAX);
+			if (rte_eth_dev_get_name_by_port(intf->port, intf->name) < 0)
+				rte_exit(EXIT_FAILURE, "Invalid port number %u\n",
+					 intf->port);
+		}
 
-		/* maybe got passed port number string as name */
-		intf->port = get_uint(intf->name, "port_number", UINT16_MAX);
-		if (rte_eth_dev_get_name_by_port(intf->port, intf->name) < 0)
-			rte_exit(EXIT_FAILURE, "Invalid port number %u\n",
-				 intf->port);
+		if (rte_eth_stats_get(intf->port, &intf->start_stats) < 0)
+			rte_exit(EXIT_FAILURE, "Could not read stats for port %u\n", intf->port);
 	}
 }
 
@@ -266,6 +272,9 @@ static void set_default_interface(void)
 
 		intf = add_interface(name);
 		intf->port = p;
+
+		if (rte_eth_stats_get(intf->port, &intf->start_stats) < 0)
+			rte_exit(EXIT_FAILURE, "Could not read stats for default port %u\n", intf->port);
 		return;
 	}
 	rte_exit(EXIT_FAILURE, "No usable interfaces found\n");
@@ -295,6 +304,9 @@ static void compile_filters(void)
 		struct bpf_program bf;
 		pcap_t *pcap;
 
+		/* cache for filter packets */
+		port2intf[intf->port] = intf;
+
 		pcap = pcap_open_dead(DLT_EN10MB, intf->opts.snap_len);
 		if (!pcap)
 			rte_exit(EXIT_FAILURE, "can not open pcap\n");
@@ -324,7 +336,12 @@ static void compile_filters(void)
 			exit(0);
 		}
 
-		intf->bpf_prm = bpf_prm;
+
+		intf->filter = rte_bpf_load(bpf_prm);
+		if (intf->filter == NULL)
+			rte_exit(EXIT_FAILURE,
+				 "BPF load failed '%s'\n%s(%d)\n",
+				 intf->name, rte_strerror(rte_errno), rte_errno);
 
 		/* Don't care about original program any more */
 		pcap_freecode(&bf);
@@ -518,13 +535,12 @@ static void statistics_loop(void)
 }
 
 static void
-cleanup_pdump_resources(void)
+disable_mirror_ports(void)
 {
 	struct interface *intf;
 
 	TAILQ_FOREACH(intf, &interfaces, next) {
-		rte_pdump_disable(intf->port,
-				  RTE_PDUMP_ALL_QUEUES, RTE_PDUMP_FLAG_RXTX);
+		rte_eth_remove_mirror(intf->port);
 		if (intf->opts.promisc_mode)
 			rte_eth_promiscuous_disable(intf->port);
 	}
@@ -552,7 +568,6 @@ enable_primary_monitor(void)
 {
 	int ret;
 
-	/* Once primary exits, so will pdump. */
 	ret = rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
 	if (ret < 0)
 		fprintf(stderr, "Fail to enable monitor:%d\n", ret);
@@ -571,23 +586,24 @@ disable_primary_monitor(void)
 static void
 report_packet_stats(dumpcap_out_t out)
 {
-	struct rte_pdump_stats pdump_stats;
 	struct interface *intf;
-	uint64_t ifrecv, ifdrop;
-	double percent;
 
 	fputc('\n', stderr);
+
 	TAILQ_FOREACH(intf, &interfaces, next) {
-		if (rte_pdump_stats(intf->port, &pdump_stats) < 0)
+		uint64_t ifrecv, ifdrop;
+		struct rte_eth_stats stats;
+		double percent;
+
+		if (rte_eth_stats_get(intf->port, &stats) < 0)
 			continue;
 
-		/* do what Wiretap does */
-		ifrecv = pdump_stats.accepted + pdump_stats.filtered;
-		ifdrop = pdump_stats.nombuf + pdump_stats.ringfull;
+		ifrecv = stats.ipackets - intf->start_stats.ipackets;
+		ifdrop = (stats.rx_nombuf - intf->start_stats.rx_nombuf)
+			+ (stats.imissed - intf->start_stats.imissed);
 
 		if (use_pcapng)
-			rte_pcapng_write_stats(out.pcapng, intf->port,
-					       ifrecv, ifdrop, NULL);
+			rte_pcapng_write_stats(out.pcapng, intf->port, ifrecv, ifdrop, NULL);
 
 		if (ifrecv == 0)
 			percent = 0;
@@ -668,12 +684,21 @@ static void dpdk_init(void)
 		rte_exit(EXIT_FAILURE, "Can not restore original CPU affinity\n");
 }
 
-/* Create packet ring shared between callbacks and process */
-static struct rte_ring *create_ring(void)
+/* Create ring port to redirect packet to.
+ * This could be much simpler if the ring PMD API (rte_eth_from_rings)
+ * worked from a secondary process, but it doesn't.
+ */
+static struct rte_ring *
+create_ring_dev(char *vdev_name, uint16_t *mirror_port)
 {
-	struct rte_ring *ring;
+	struct rte_eth_dev_owner owner = { 0 };
+	struct rte_eth_conf dev_conf = { 0 };
+	struct rte_ring *ring = NULL;
 	char ring_name[RTE_RING_NAMESIZE];
+	char vdev_args[128];
 	size_t size, log2;
+	uint16_t port;
+	int ret;
 
 	/* Find next power of 2 >= size. */
 	size = ring_size;
@@ -686,17 +711,60 @@ static struct rte_ring *create_ring(void)
 		ring_size = size;
 	}
 
-	/* Want one ring per invocation of program */
-	snprintf(ring_name, sizeof(ring_name),
-		 "dumpcap-%d", getpid());
+	ret = rte_eth_dev_owner_new(&owner.id);
+	if (ret < 0)
+		rte_exit(EXIT_FAILURE, "rte_eth_dev_owner_new failed: %s\n",
+			 strerror(-ret));
 
-	ring = rte_ring_create(ring_name, ring_size,
-			       rte_socket_id(), 0);
+	/* Give the vdev a unique name */
+	snprintf(ring_name, sizeof(ring_name), "dumpcap%"PRIu64, owner.id);
+	ring = rte_ring_create(ring_name, ring_size, rte_socket_id(),
+			       RING_F_MP_RTS_ENQ | RING_F_SC_DEQ);
 	if (ring == NULL)
 		rte_exit(EXIT_FAILURE, "Could not create ring :%s\n",
 			 rte_strerror(rte_errno));
 
+	strlcpy(owner.name, ring_name, sizeof(owner.name));
+
+	snprintf(vdev_name, RTE_DEV_NAME_MAX_LEN,
+		 "net_ring-dumpcap%"PRIu64, owner.id);
+	snprintf(vdev_args, sizeof(vdev_args),
+		 "ring=%s,timestamp", ring_name);
+
+	if (rte_eal_hotplug_add("vdev", vdev_name, vdev_args) < 0)
+		rte_exit(EXIT_FAILURE,
+			 "rte_eal_hotplug_add of %s failed:%s\n",
+			 vdev_name, rte_strerror(rte_errno));
+
+	ret = rte_eth_dev_get_port_by_name(vdev_name, &port);
+	if (ret != 0) {
+		fprintf(stderr, "Could not port for %s: %s\n",
+			vdev_name, strerror(-ret));
+		goto unplug;
+	}
+
+	ret = rte_eth_dev_owner_set(port, &owner);
+	if (ret != 0) {
+		fprintf(stderr, "Could not set owner for port for %u: %s\n",
+			port, strerror(-ret));
+		goto unplug;
+	}
+
+	ret = rte_eth_dev_configure(port, 1, 1, &dev_conf);
+	if (ret < 0) {
+		fprintf(stderr, "Could not configure port %u: %s\n",
+			port, strerror(-ret));
+		goto unplug;
+	}
+
+	*mirror_port = port;
 	return ring;
+
+unplug:
+	rte_eal_hotplug_remove("vdev", vdev_name);
+	rte_ring_free(ring);
+	rte_eal_cleanup();
+	exit(EXIT_FAILURE);
 }
 
 static struct rte_mempool *create_mempool(void)
@@ -796,7 +864,7 @@ static dumpcap_out_t create_output(void)
 					   version(), capture_comment);
 		if (ret.pcapng == NULL)
 			rte_exit(EXIT_FAILURE, "pcapng_fdopen failed: %s\n",
-				 strerror(rte_errno));
+				 rte_strerror(rte_errno));
 		free(os);
 
 		TAILQ_FOREACH(intf, &interfaces, next) {
@@ -823,37 +891,30 @@ static dumpcap_out_t create_output(void)
 	return ret;
 }
 
-static void enable_pdump(struct rte_ring *r, struct rte_mempool *mp)
+static int enable_mirror(uint16_t mirror_port, struct rte_mempool *mpool)
 {
 	struct interface *intf;
 	unsigned int count = 0;
-	uint32_t flags;
 	int ret;
 
-	flags = RTE_PDUMP_FLAG_RXTX;
-	if (use_pcapng)
-		flags |= RTE_PDUMP_FLAG_PCAPNG;
+	ret = rte_eth_dev_start(mirror_port);
+	if (ret < 0)
+		rte_exit(EXIT_FAILURE, "Could not start mirror port %u: %s\n",
+			 mirror_port, strerror(-ret));
 
 	TAILQ_FOREACH(intf, &interfaces, next) {
-		ret = rte_pdump_enable_bpf(intf->port, RTE_PDUMP_ALL_QUEUES,
-					   flags, intf->opts.snap_len,
-					   r, mp, intf->bpf_prm);
+		struct rte_eth_mirror_conf conf = {
+			.mp = mpool,
+			.snaplen = intf->opts.snap_len,
+			.direction = RTE_MIRROR_DIRECTION_INGRESS |
+				     RTE_MIRROR_DIRECTION_EGRESS,
+		};
+
+		ret = rte_eth_add_mirror(intf->port, mirror_port, &conf);
 		if (ret < 0) {
-			const struct interface *intf2;
-
-			/* unwind any previous enables */
-			TAILQ_FOREACH(intf2, &interfaces, next) {
-				if (intf == intf2)
-					break;
-				rte_pdump_disable(intf2->port,
-						  RTE_PDUMP_ALL_QUEUES, RTE_PDUMP_FLAG_RXTX);
-				if (intf2->opts.promisc_mode)
-					rte_eth_promiscuous_disable(intf2->port);
-			}
-			rte_exit(EXIT_FAILURE,
-				"Packet dump enable on %u:%s failed %s\n",
-				intf->port, intf->name,
-				rte_strerror(rte_errno));
+			fprintf(stderr, "Port mirror on %u:%s failed %s\n",
+				intf->port, intf->name, strerror(-ret));
+			return -1;
 		}
 
 		if (intf->opts.promisc_mode) {
@@ -868,6 +929,31 @@ static void enable_pdump(struct rte_ring *r, struct rte_mempool *mp)
 		}
 		++count;
 	}
+	return count;
+}
+
+static void setup_mbuf(void)
+{
+	int offset;
+
+	offset = rte_mbuf_dynfield_lookup(RTE_MBUF_DYNFIELD_TIMESTAMP_NAME, NULL);
+	if (offset < 0) {
+		fprintf(stderr, "Could not find timestamp dynamic field\n");
+		return;
+	}
+	timestamp_dynfield = offset;
+
+	offset = rte_mbuf_dynflag_lookup(RTE_MBUF_DYNFLAG_RX_TIMESTAMP_NAME, NULL);
+	if (offset < 0) {
+		fprintf(stderr, "Could not find timestamp flag\n");
+		return;
+	}
+	timestamp_dynflag = RTE_BIT64(offset);
+}
+
+static void show_capturing(unsigned int count)
+{
+	struct interface *intf;
 
 	fputs("Capturing on ", stdout);
 	TAILQ_FOREACH(intf, &interfaces, next) {
@@ -898,6 +984,42 @@ static void show_count(uint64_t count)
 	bt = fprintf(stderr, "%"PRIu64" ", count);
 }
 
+static ssize_t
+pcapng_write_packets(rte_pcapng_t *pcapng,
+		     struct rte_mbuf *pkts[], uint16_t n)
+{
+	struct rte_mbuf *towrite[BURST_SIZE];
+	unsigned int count = 0;
+	unsigned int i;
+
+	for (i = 0; i < n; i++) {
+		struct rte_mbuf *m = pkts[i];
+		const struct rte_mbuf_mirror *orig = &m->hash.mirror;
+		enum rte_pcapng_direction direction;
+		uint64_t ts;
+
+		if (orig->direction == RTE_MIRROR_DIRECTION_INGRESS)
+			direction = RTE_PCAPNG_DIRECTION_IN;
+		else if (orig->direction == RTE_MIRROR_DIRECTION_EGRESS)
+			direction = RTE_PCAPNG_DIRECTION_OUT;
+		else
+			direction = RTE_PCAPNG_DIRECTION_UNKNOWN;
+
+		if (likely(m->ol_flags & timestamp_dynflag))
+			ts = *RTE_MBUF_DYNFIELD(m, timestamp_dynfield, rte_mbuf_timestamp_t *);
+		else
+			ts = rte_get_tsc_cycles();
+
+		if (unlikely(rte_pcapng_insert(m, orig->queue_id, direction,
+					       orig->orig_len, ts, NULL) < 0))
+			continue;  /* skip no headroom? */
+
+		towrite[count++] = m;
+	}
+
+	return rte_pcapng_write_packets(pcapng, towrite, count);
+}
+
 /* Write multiple packets in older pcap format */
 static ssize_t
 pcap_write_packets(pcap_dumper_t *dumper,
@@ -930,16 +1052,82 @@ pcap_write_packets(pcap_dumper_t *dumper,
 	return total;
 }
 
+static unsigned int
+filter_burst(struct interface *intf, struct rte_mbuf *pkts[], unsigned int n)
+{
+	uint64_t results[BURST_SIZE];
+	struct rte_mbuf *towrite[BURST_SIZE];
+	unsigned int i, count;
+	uint32_t matches;
+
+	matches = rte_bpf_exec_burst(intf->filter, (void **)pkts, results, n);
+	if (matches == n)
+		return n;
+	intf->filteraccept += matches;
+
+	for (i = 0, count = 0; i < n; i++) {
+		if (results[i])
+			towrite[count++] = pkts[i];
+		else
+			rte_pktmbuf_free(pkts[i]);
+	}
+	memcpy(pkts, towrite, count * sizeof(struct rte_mbuf *));
+	return count;
+}
+
+static ssize_t
+process_burst(uint16_t in_port, dumpcap_out_t out,
+	      struct rte_mbuf *pkts[], unsigned int n)
+{
+	struct interface *intf;
+	ssize_t written;
+
+	if (in_port >= RTE_MAX_ETHPORTS)
+		goto invalid_port;
+
+	intf = port2intf[in_port];
+	if (intf == NULL)
+		goto invalid_port;
+
+	if (intf->filter) {
+		n = filter_burst(intf, pkts, n);
+		if (n == 0)
+			return 0;
+	}
+
+	packets_received += n;
+	if (use_pcapng)
+		written = pcapng_write_packets(out.pcapng, pkts, n);
+	else
+		written = pcap_write_packets(out.dumper, pkts, n);
+
+	if (written > 0)
+		file_size += written;
+
+	rte_pktmbuf_free_bulk(pkts, n);
+	return written;
+
+invalid_port:
+	static bool warn_once = true;
+	if (warn_once) {
+		warn_once = false;
+		fprintf(stderr, "Packet in ring from port %u\n", in_port);
+	}
+
+	rte_pktmbuf_free_bulk(pkts, n);
+	return 0;
+}
+
 /* Process all packets in ring and dump to capture file */
-static int process_ring(dumpcap_out_t out, struct rte_ring *r)
+static int process_ring(dumpcap_out_t out, struct rte_ring *ring)
 {
 	struct rte_mbuf *pkts[BURST_SIZE];
-	unsigned int avail, n;
+	uint16_t in_port;
+	unsigned int i, n, start, avail;
 	static unsigned int empty_count;
-	ssize_t written;
+	int ret;
 
-	n = rte_ring_sc_dequeue_burst(r, (void **) pkts, BURST_SIZE,
-				      &avail);
+	n = rte_ring_sc_dequeue_burst(ring, (void **)pkts, BURST_SIZE, &avail);
 	if (n == 0) {
 		/* don't consume endless amounts of cpu if idle */
 		if (empty_count < SLEEP_THRESHOLD)
@@ -951,18 +1139,24 @@ static int process_ring(dumpcap_out_t out, struct rte_ring *r)
 
 	empty_count = (avail == 0);
 
-	if (use_pcapng)
-		written = rte_pcapng_write_packets(out.pcapng, pkts, n);
-	else
-		written = pcap_write_packets(out.dumper, pkts, n);
+	/* process all packets mirrored from same port */
+	start = 0;
+	in_port = pkts[start]->port;
+	for (i = 1; i < n; i++) {
+		if (likely(pkts[i]->port == in_port))
+			continue;
+		ret = process_burst(in_port, out, pkts + start, i - start);
+		if (ret < 0)
+			return ret;	/* stop on file write error */
 
-	rte_pktmbuf_free_bulk(pkts, n);
+		start = i;
+		in_port = pkts[i]->port;
+	}
 
-	if (written < 0)
-		return -1;
+	ret = process_burst(in_port, out, pkts + start, n - start);
+	if (ret < 0)
+		return ret;
 
-	file_size += written;
-	packets_received += n;
 	if (!quiet)
 		show_count(packets_received);
 
@@ -971,15 +1165,18 @@ static int process_ring(dumpcap_out_t out, struct rte_ring *r)
 
 int main(int argc, char **argv)
 {
-	struct rte_ring *r;
 	struct rte_mempool *mp;
 	struct sigaction action = {
 		.sa_flags = SA_RESTART,
 		.sa_handler = signal_handler,
 	};
 	struct sigaction origaction;
+	struct rte_ring *ring = NULL;
+	char vdev_name[RTE_DEV_NAME_MAX_LEN];
+	uint16_t mirror_port = UINT16_MAX;
 	dumpcap_out_t out;
 	char *p;
+	int ret;
 
 	p = strrchr(argv[0], '/');
 	if (p == NULL)
@@ -1018,12 +1215,19 @@ int main(int argc, char **argv)
 		exit(0);
 	}
 
-	r = create_ring();
 	mp = create_mempool();
+	ring = create_ring_dev(vdev_name, &mirror_port);
 	out = create_output();
 
+	ret = enable_mirror(mirror_port, mp);
+	if (ret < 0)
+		goto cleanup;
+
+	setup_mbuf();
+
+	show_capturing(ret);
+
 	start_time = time(NULL);
-	enable_pdump(r, mp);
 
 	if (!quiet) {
 		fprintf(stderr, "Packets captured: ");
@@ -1031,7 +1235,7 @@ int main(int argc, char **argv)
 	}
 
 	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
-		if (process_ring(out, r) < 0) {
+		if (process_ring(out, ring) < 0) {
 			fprintf(stderr, "pcapng file write failed; %s\n",
 				strerror(errno));
 			break;
@@ -1048,19 +1252,20 @@ int main(int argc, char **argv)
 			break;
 	}
 
-	disable_primary_monitor();
-
 	if (rte_eal_primary_proc_alive(NULL))
 		report_packet_stats(out);
 
+cleanup:
 	if (use_pcapng)
 		rte_pcapng_close(out.pcapng);
 	else
 		pcap_dump_close(out.dumper);
 
-	cleanup_pdump_resources();
+	disable_primary_monitor();
+	disable_mirror_ports();
 
-	rte_ring_free(r);
+	rte_eal_hotplug_remove("vdev", vdev_name);
+	rte_ring_free(ring);
 	rte_mempool_free(mp);
 
 	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
diff --git a/app/dumpcap/meson.build b/app/dumpcap/meson.build
index 69c016c780..6212291d40 100644
--- a/app/dumpcap/meson.build
+++ b/app/dumpcap/meson.build
@@ -14,4 +14,4 @@ endif
 
 ext_deps += pcap_dep
 sources = files('main.c')
-deps += ['ethdev', 'pdump', 'pcapng', 'bpf']
+deps += ['net_ring', 'ethdev', 'pcapng', 'bpf']
-- 
2.47.2

