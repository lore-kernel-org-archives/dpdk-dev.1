Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9C5C83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 16:44:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F39AB40E3F;
	Thu, 10 Jul 2025 18:42:59 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id D433240E28
 for <dev@dpdk.org>; Thu, 10 Jul 2025 18:42:58 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-700c7e4c048so19879016d6.3
 for <dev@dpdk.org>; Thu, 10 Jul 2025 09:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752165778;
 x=1752770578; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdw41N5ahZ2DQUSTdCaEiXUXV/J7v2vhPGd8A5KVoTo=;
 b=rNLx+CVhST3kgk7ziXR1la0vxqHC/Na/C1bIypEt+Eyi7uksIoo1bCCVbtJyA8JVJl
 mJWAn8ysOTHfAOv5MqbdgnxKzdmY/PFyTsFPujODpxPKoi8vtMZg8bajfHeajLWHBHK9
 qb+ieIiQl/zWq5HbBhdQa11EobsuPy21SrhdNEXPF226oIMI5O/+mFrFmf1mKfsoBm54
 VjNidC6/dLl7UGsRptkkrjME3rL4ZIyyeiKvDjnaTwai0PfEmsaB+FqE+OFMk/SBDQ6g
 YfLdqfwmhlEJCu3/2lnxi0PBlMmgM9IykwacSeWHnIH9n/LW1GRmMUcTdSahOiCO8Hyr
 CndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165778; x=1752770578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdw41N5ahZ2DQUSTdCaEiXUXV/J7v2vhPGd8A5KVoTo=;
 b=F56numBzKeRfXs2Fkc2oVEqouyAq2Te0Ki5Z6F16fmkcwGpFMEYItt6aqFA2NhjOWG
 v2s5eKTkyJcc+rS7WOkoibX5FTo8y+0kCst+dnuPo+azO+3YTAgCO9SzkHP4Ovs2H59l
 vg68hzTvTnCbQhAGBFIFhruWmqjpaFY8g/KFpwP2SYuUDIALfHRlSn5oD0qKnvEydYu7
 nWBX1ZXdMwz0BRe2yRcK7vWmHR8hpX/YX/Mz2evSIzBZ8nUM3oVA2N2gcgC+antB3w9C
 qpLeQZRhY3SCpjt9JRkLin/3iIcq6TEHumOeKdYA7XIgTVRUt6bwkzMhwTPrPvBtJPDz
 L9JQ==
X-Gm-Message-State: AOJu0YzX7qcYrAmZ6QOa0Urz/JzVf9SccVYUPLmfRSiDcr78itLQmJYh
 5JSrFMHikEAclK0gnx5LHouePHW5GxLk+wFnuig4bF726Pdc8Al4wUN7juIMwWzuYSOU9rp7ZSQ
 2omIn
X-Gm-Gg: ASbGnctOuImtoPjRxOSExEevB3X8hcp0r2CwA+MFJM5eEotOfvGOH1eZp7EXa1d85aP
 EPN1X7gABzk7M3XcriFasMAbGDSIyl1GFrf9WLXji28AFBWst2m/KV/BMfpoalXIwE3+uycbQ+j
 zj0jpPjPQrMPAxrTBghNmKUkUi1tJXe0KdPK3y1x6SVS+0jTm75BmaN7kuqksK/aAuECyMj3+M7
 8je6+jVgAbc+obaNHU0LIX+5m+etUr6jXrxPM+5Zxua2tkYKglyFWMVGWUL9Niru6e5BciLVU61
 5VRYeEvnN5eV9TLNfy4eP3/TsQlP6Lk027bRjSv8WuAeqHMhy5m3zJvO/zOJAdXdx44tLcZ4uGH
 ztwLhosgYivfEOqxnNX+MpZ7gdW1RswnhTELU
X-Google-Smtp-Source: AGHT+IEdJQxy5jzOv3AnZNETbiT94Ve7xA+qac1vSClQcOHWh+rYTp9nHYAVsNfuUoe3oCJGivhZPg==
X-Received: by 2002:ad4:5bea:0:b0:6fb:15d3:7f3d with SMTP id
 6a1803df08f44-704a3393848mr1102816d6.13.1752165777805; 
 Thu, 10 Jul 2025 09:42:57 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979b49b3sm10167966d6.30.2025.07.10.09.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:42:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 12/13] app/dumpcap: use port mirror instead of pdump
Date: Thu, 10 Jul 2025 09:16:53 -0700
Message-ID: <20250710164237.8630-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710164237.8630-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250710164237.8630-1-stephen@networkplumber.org>
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
 app/dumpcap/main.c      | 444 +++++++++++++++++++++++++++++++++-------
 app/dumpcap/meson.build |   2 +-
 2 files changed, 374 insertions(+), 72 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..4613cfc808 100644
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
@@ -92,16 +90,28 @@ struct capture_options {
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
+static int mirror_origin_dynfield = -1;
+static uint64_t mirror_origin_dynflag;
+static uint64_t mirror_ingress_dynflag;
+static uint64_t mirror_egress_dynflag;
+
+static bool filtering;
+
 TAILQ_HEAD(interface_list, interface);
 static struct interface_list interfaces = TAILQ_HEAD_INITIALIZER(interfaces);
+static struct interface *port2intf[RTE_MAX_ETHPORTS];
 
 /* Can do either pcap or pcapng format output */
 typedef union {
@@ -239,14 +249,16 @@ static void find_interfaces(void)
 
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
 
@@ -266,6 +278,10 @@ static void set_default_interface(void)
 
 		intf = add_interface(name);
 		intf->port = p;
+
+		if (rte_eth_stats_get(intf->port, &intf->start_stats) < 0)
+			rte_exit(EXIT_FAILURE,
+				 "Could not read stats for port %u\n", intf->port);
 		return;
 	}
 	rte_exit(EXIT_FAILURE, "No usable interfaces found\n");
@@ -295,10 +311,17 @@ static void compile_filters(void)
 		struct bpf_program bf;
 		pcap_t *pcap;
 
+		/* cache for filter packets */
+		port2intf[intf->port] = intf;
+
+		if (intf->opts.filter == NULL)
+			continue;
+
 		pcap = pcap_open_dead(DLT_EN10MB, intf->opts.snap_len);
 		if (!pcap)
 			rte_exit(EXIT_FAILURE, "can not open pcap\n");
 
+
 		if (pcap_compile(pcap, &bf, intf->opts.filter,
 				 1, PCAP_NETMASK_UNKNOWN) != 0) {
 			fprintf(stderr,
@@ -316,7 +339,7 @@ static void compile_filters(void)
 				 rte_strerror(rte_errno), rte_errno);
 
 		if (dump_bpf) {
-			printf("cBPF program (%u insns)\n", bf.bf_len);
+			printf("cops program (%u insns)\n", bf.bf_len);
 			bpf_dump(&bf, 1);
 			printf("\neBPF program (%u insns)\n",
 			       bpf_prm->nb_ins);
@@ -324,11 +347,18 @@ static void compile_filters(void)
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
 		pcap_close(pcap);
+
+		filtering = true;
 	}
 }
 
@@ -518,13 +548,12 @@ static void statistics_loop(void)
 }
 
 static void
-cleanup_pdump_resources(void)
+disable_mirror_ports(uint16_t mirror_port)
 {
 	struct interface *intf;
 
 	TAILQ_FOREACH(intf, &interfaces, next) {
-		rte_pdump_disable(intf->port,
-				  RTE_PDUMP_ALL_QUEUES, RTE_PDUMP_FLAG_RXTX);
+		rte_eth_remove_mirror(intf->port, mirror_port);
 		if (intf->opts.promisc_mode)
 			rte_eth_promiscuous_disable(intf->port);
 	}
@@ -552,7 +581,6 @@ enable_primary_monitor(void)
 {
 	int ret;
 
-	/* Once primary exits, so will pdump. */
 	ret = rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
 	if (ret < 0)
 		fprintf(stderr, "Fail to enable monitor:%d\n", ret);
@@ -571,23 +599,24 @@ disable_primary_monitor(void)
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
@@ -668,12 +697,21 @@ static void dpdk_init(void)
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
@@ -686,17 +724,60 @@ static struct rte_ring *create_ring(void)
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
@@ -796,7 +877,7 @@ static dumpcap_out_t create_output(void)
 					   version(), capture_comment);
 		if (ret.pcapng == NULL)
 			rte_exit(EXIT_FAILURE, "pcapng_fdopen failed: %s\n",
-				 strerror(rte_errno));
+				 rte_strerror(rte_errno));
 		free(os);
 
 		TAILQ_FOREACH(intf, &interfaces, next) {
@@ -823,37 +904,32 @@ static dumpcap_out_t create_output(void)
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
+			.target = mirror_port,
+			.snaplen = intf->opts.snap_len,
+			.flags = RTE_ETH_MIRROR_ORIGIN_FLAG | RTE_ETH_MIRROR_TIMESTAMP_FLAG,
+			.direction = RTE_ETH_MIRROR_DIRECTION_INGRESS |
+				     RTE_ETH_MIRROR_DIRECTION_EGRESS,
+		};
+
+		ret = rte_eth_add_mirror(intf->port, &conf);
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
@@ -868,6 +944,60 @@ static void enable_pdump(struct rte_ring *r, struct rte_mempool *mp)
 		}
 		++count;
 	}
+	return count;
+}
+
+static int setup_mbuf(void)
+{
+	int offset;
+
+	offset = rte_mbuf_dynfield_lookup(RTE_MBUF_DYNFIELD_TIMESTAMP_NAME, NULL);
+	if (offset < 0) {
+		fprintf(stderr, "Could not find timestamp dynamic field\n");
+		return -1;
+	}
+	timestamp_dynfield = offset;
+
+	offset = rte_mbuf_dynflag_lookup(RTE_MBUF_DYNFLAG_RX_TIMESTAMP_NAME, NULL);
+	if (offset < 0) {
+		fprintf(stderr, "Could not find timestamp flag\n");
+		return -1;
+	}
+	timestamp_dynflag = RTE_BIT64(offset);
+
+	offset = rte_mbuf_dynfield_lookup(RTE_MBUF_DYNFIELD_MIRROR_ORIGIN, NULL);
+	if (offset < 0) {
+		fprintf(stderr, "Could not find mirror origin dynamic field\n");
+		return -1;
+	}
+	mirror_origin_dynfield = offset;
+
+	offset = rte_mbuf_dynflag_lookup(RTE_MBUF_DYNFLAG_MIRROR_ORIGIN, NULL);
+	if (offset < 0) {
+		fprintf(stderr, "Could not find mirror origin dynamic flag\n");
+		return -1;
+	}
+	mirror_origin_dynflag = RTE_BIT64(offset);
+
+	offset = rte_mbuf_dynflag_lookup(RTE_MBUF_DYNFLAG_MIRROR_INGRESS, NULL);
+	if (offset < 0) {
+		fprintf(stderr, "Could not find mirror ingress flag\n");
+		return -1;
+	}
+	mirror_ingress_dynflag = RTE_BIT64(offset);
+
+	offset = rte_mbuf_dynflag_lookup(RTE_MBUF_DYNFLAG_MIRROR_EGRESS, NULL);
+	if (offset < 0) {
+		fprintf(stderr, "Could not find mirror egress flag\n");
+		return -1;
+	}
+	mirror_egress_dynflag = RTE_BIT64(offset);
+	return 0;
+}
+
+static void show_capturing(unsigned int count)
+{
+	struct interface *intf;
 
 	fputs("Capturing on ", stdout);
 	TAILQ_FOREACH(intf, &interfaces, next) {
@@ -898,6 +1028,47 @@ static void show_count(uint64_t count)
 	bt = fprintf(stderr, "%"PRIu64" ", count);
 }
 
+static ssize_t
+pcapng_write_packets(rte_pcapng_t *pcapng, struct rte_mbuf *pkts[], uint16_t n)
+{
+	struct rte_mbuf *towrite[BURST_SIZE];
+	unsigned int count = 0;
+
+	for (unsigned int i = 0; i < n; i++) {
+		struct rte_mbuf *m = pkts[i];
+		enum rte_pcapng_direction direction = RTE_PCAPNG_DIRECTION_UNKNOWN;
+
+		/* If no origin flag then why did we get this? */
+		if (unlikely(!(m->ol_flags & mirror_origin_dynflag))) {
+			fprintf(stderr, "Missing origin info in packet\n");
+			return -1;
+		}
+
+		const struct rte_mbuf_origin *origin
+			= RTE_MBUF_DYNFIELD(m, mirror_origin_dynfield, rte_mbuf_origin_t *);
+
+		if (m->ol_flags & mirror_ingress_dynflag)
+			direction = RTE_PCAPNG_DIRECTION_IN;
+		else if (m->ol_flags & mirror_egress_dynflag)
+			direction = RTE_PCAPNG_DIRECTION_OUT;
+
+		uint64_t timestamp;
+		if (m->ol_flags & timestamp_dynflag)
+			timestamp = *RTE_MBUF_DYNFIELD(m, timestamp_dynfield,
+						       rte_mbuf_timestamp_t *);
+		else
+			timestamp = rte_get_tsc_cycles();
+
+		if (rte_pcapng_insert(m, origin->queue_id, direction, origin->original_len,
+				      timestamp, NULL) < 0)
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
@@ -930,16 +1101,127 @@ pcap_write_packets(pcap_dumper_t *dumper,
 	return total;
 }
 
+/* Do packet filter on incoming packets.
+ * Some issues to note here:
+ *  - would be better to do before putting into ring
+ *    but that causes ethdev to have dependency on BPF.
+ *  - the filter is per-interface and there maybe more than one interface
+ *    combined into the ring. That means filter is executed once
+ *    per packet (not as burst).
+ */
+static unsigned int
+filter_packets(struct rte_mbuf *pkts[], unsigned int n)
+{
+	uint64_t results[BURST_SIZE];
+	uint32_t matches = 0;
+
+	for (unsigned int i = 0; i < n; i++) {
+		struct rte_mbuf *m = pkts[i];
+
+		/* all packets should have origin info, if not just skip */
+		if (unlikely(!(m->ol_flags & mirror_origin_dynflag)))
+			continue;
+
+		const struct rte_mbuf_origin *origin
+			= RTE_MBUF_DYNFIELD(m, mirror_origin_dynfield, rte_mbuf_origin_t *);
+		uint16_t port_id = origin->port_id;
+
+		if (unlikely(port_id >= RTE_MAX_ETHPORTS))
+			continue;
+
+		const struct interface *intf = port2intf[port_id];
+		if (intf == NULL || intf->filter == NULL)
+			continue;
+
+		if (rte_bpf_exec_burst(intf->filter, (void **)&m, &results[i], 1) == 1)
+			++matches;
+	}
+
+	if (matches == n)
+		return n;	/* no packets skipped */
+
+	/* need to shuffle out the skipped packets */
+	unsigned int count = 0;
+	struct rte_mbuf *towrite[BURST_SIZE];
+	for (unsigned int i = 0; i < n; i++) {
+		if (results[i])
+			towrite[count++] = pkts[i];
+		else
+			rte_pktmbuf_free(pkts[i]);
+	}
+	memcpy(pkts, towrite, count * sizeof(struct rte_mbuf *));
+	return count;
+}
+
+/* Make sure configuration of mbuf pool has enough headroom for both vlans */
+static_assert(RTE_PKTMBUF_HEADROOM > 2 * sizeof(struct rte_vlan_hdr),
+	"not enough mbuf headroom for vlan insertion");
+
+/*
+ * More general version of rte_vlan_insert()
+ * Note: mbufs are allocated by rte_eth_mirror_burst() from the
+ * pool that was passed when setting up mirror.
+ */
+static void
+vlan_insert(struct rte_mbuf *m, uint16_t ether_type, uint16_t tci)
+{
+	struct rte_ether_hdr *nh, tmph;
+	const struct rte_ether_hdr *oh;
+	struct rte_vlan_hdr *vh;
+
+	RTE_ASSERT(!RTE_MBUF_DIRECT(m));
+	RTE_ASSERT(rte_mbuf_refcnt_read(m) == 1);
+
+	oh = rte_pktmbuf_read(m, 0, sizeof(*oh), &tmph);
+	RTE_ASSERT(oh != NULL);
+
+	/* overlay new header */
+	nh = (struct rte_ether_hdr *)
+		rte_pktmbuf_prepend(m, sizeof(struct rte_vlan_hdr));
+
+	RTE_ASSERT(nh != NULL);
+
+	memmove(nh, oh, 2 * RTE_ETHER_ADDR_LEN);
+	nh->ether_type = rte_cpu_to_be_16(ether_type);
+
+	vh = (struct rte_vlan_hdr *) (nh + 1);
+	vh->vlan_tci = rte_cpu_to_be_16(tci);
+}
+
+/* Filtering and pcap file format require that VLAN not be offloaded */
+static void
+remove_vlan_offload(struct rte_mbuf *pkts[], unsigned int n)
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++) {
+		struct rte_mbuf *m = pkts[i];
+
+		if (m->ol_flags & mirror_ingress_dynflag) {
+			if (m->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED)
+				vlan_insert(m, RTE_ETHER_TYPE_VLAN, m->vlan_tci);
+			if (m->ol_flags & RTE_MBUF_F_RX_QINQ_STRIPPED)
+				vlan_insert(m, RTE_ETHER_TYPE_QINQ, m->vlan_tci_outer);
+		}
+		if (m->ol_flags & mirror_egress_dynflag) {
+			if (m->ol_flags & RTE_MBUF_F_TX_VLAN)
+				vlan_insert(m, RTE_ETHER_TYPE_VLAN, m->vlan_tci);
+			if (m->ol_flags & RTE_MBUF_F_TX_QINQ)
+				vlan_insert(m, RTE_ETHER_TYPE_QINQ, m->vlan_tci_outer);
+
+		}
+	}
+}
+
 /* Process all packets in ring and dump to capture file */
-static int process_ring(dumpcap_out_t out, struct rte_ring *r)
+static int process_ring(dumpcap_out_t out, struct rte_ring *ring)
 {
 	struct rte_mbuf *pkts[BURST_SIZE];
-	unsigned int avail, n;
+	unsigned int n, avail;
 	static unsigned int empty_count;
 	ssize_t written;
 
-	n = rte_ring_sc_dequeue_burst(r, (void **) pkts, BURST_SIZE,
-				      &avail);
+	n = rte_ring_sc_dequeue_burst(ring, (void **)pkts, BURST_SIZE, &avail);
 	if (n == 0) {
 		/* don't consume endless amounts of cpu if idle */
 		if (empty_count < SLEEP_THRESHOLD)
@@ -948,11 +1230,18 @@ static int process_ring(dumpcap_out_t out, struct rte_ring *r)
 			usleep(10);
 		return 0;
 	}
-
 	empty_count = (avail == 0);
 
+	remove_vlan_offload(pkts, n);
+
+	if (filtering) {
+		n = filter_packets(pkts, n);
+		if (n == 0)
+			return 0;
+	}
+
 	if (use_pcapng)
-		written = rte_pcapng_write_packets(out.pcapng, pkts, n);
+		written = pcapng_write_packets(out.pcapng, pkts, n);
 	else
 		written = pcap_write_packets(out.dumper, pkts, n);
 
@@ -971,15 +1260,18 @@ static int process_ring(dumpcap_out_t out, struct rte_ring *r)
 
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
@@ -1018,12 +1310,21 @@ int main(int argc, char **argv)
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
+	ret = setup_mbuf();
+	if (ret < 0)
+		goto cleanup;
+
+	show_capturing(ret);
+
 	start_time = time(NULL);
-	enable_pdump(r, mp);
 
 	if (!quiet) {
 		fprintf(stderr, "Packets captured: ");
@@ -1031,7 +1332,7 @@ int main(int argc, char **argv)
 	}
 
 	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
-		if (process_ring(out, r) < 0) {
+		if (process_ring(out, ring) < 0) {
 			fprintf(stderr, "pcapng file write failed; %s\n",
 				strerror(errno));
 			break;
@@ -1048,19 +1349,20 @@ int main(int argc, char **argv)
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
+	disable_mirror_ports(mirror_port);
 
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

