Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3D7C87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 17:00:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFC6140B9E;
	Fri,  8 Aug 2025 18:59:16 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 3CD6540B8D
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:59:15 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so20002705e9.3
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672355;
 x=1755277155; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVvAd44lB10d2k7CLQq6wYvGIxaKiO/hJZuNCcc3mxo=;
 b=mBb/3kM/H+X4uWFnU8oGtJczmpy5nsevzrfM+zgIXHONBKEUghFWbO3zM9hki5qeiE
 fI58bWLUK5Zy1p3d8q7ZmniGazYJ9q1JyFEYn/K4OYvFZwiCidNWh0qgplciJHGr9khN
 j5hUFLyWRBpFEiYGaIivbu310uqdHVqoBUg3NpahuQeDduAbxdm23QvjPt8TRw4qYVeg
 EtEinAse/FIEAv3fz9fVw0cPZs3HzNl6W8Z4q38U9Q0cuIidQrcEcgF1OQLwBDUwW6Nm
 E4vTcbDRmnG9Ro2BJAd1WaaJmBFi670fCGjiOW7pf4jYyvNsbEvSZzoktKYrv2geWJTi
 wDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672355; x=1755277155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVvAd44lB10d2k7CLQq6wYvGIxaKiO/hJZuNCcc3mxo=;
 b=TaRK5xEFDYYZfx1ej0GBx9JsYiH26V1YkVjPNyIhV9sW8nYpsSav7704Sq1lwrKZYb
 x9zgqwcwzG0e9/06IYzYqDlq0ySJyBg4VTm20E7GBGwUJWTB21aaX04XlASkvfe1h8Bb
 QvZqbar+kVVBD2gNBZ38tl1AlO+PR84ITq/zrARDbe8ktJXk9uMyVdeKdMUpni1+ayKO
 wU25wthsP76IfBf8aafOfdkZfJ1oxcbyKbBYd4DbQ5JJ0LYnx7v2XWjLAKhDGsv0Jqa4
 nuTkqJBb91fySO088NUN5lNCkGTAOvbJFuIs29qHA2L9HN+6iiJSc7q1oJ4/fa2qVWxS
 LACw==
X-Gm-Message-State: AOJu0YxYLlQIu/2uG4TAvTF3EPmcN40rXZmS7pd/57f+fDGe5qIzFOaN
 1ODUDE6UNilybC24iFqcKrTi07q9t+4YQ8ru4tDwNH/n3ThyHuqTQv/VPtu0MV2ZFzXAm4HIPnS
 /byMQ
X-Gm-Gg: ASbGncvRxL6xZXLAF1Dxf1tD0YQo+ENFrzODy4yqY9FNmhzmpJd7PaJ41K1bNvv13qM
 HlwOa/Q0UBjgx9bZHpU67+eUgQE9AciA6EkVAfvJ3AJdqLuO+yTTQtnsJXv6PuPAvebV8R2GJEm
 KIxYKKaaX0YQ9SkgbdWT4poPNg1FJANvyUPe2OAzY3eWaHj/40jziWFtshIW6q5euWTpLXGgnL+
 Gclq11DKwcXEPZQ+Psc8a6yDYUIUM5nKb5TGUgNgIdy2fiofaMqOOg5oTYAc9Dv0WjBFr2iSNfy
 4kiHxgtEmykdl6+h6WjToth5JbIRNZgsvSld3eyRLR5wmspVVKHD+RxhMSy7nWsCxuwnX853DMY
 CYT1f1AtvDCaqUTsPaZuCrLQWyP9F1Gz4acvMs8aE7x/hjz0WKSYkTaNExHTQSqVqPevtWIYa
X-Google-Smtp-Source: AGHT+IF85v090frYZAFUI9+y7M1vKSc4lCEhlOwxOtBFZBtrh7COQkVu9qkIS3u3DWvH3IzlIGj0Zg==
X-Received: by 2002:a05:600c:1caa:b0:456:e39:ec1a with SMTP id
 5b1f17b1804b1-459f4ec3a43mr38822085e9.14.1754672354705; 
 Fri, 08 Aug 2025 09:59:14 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:59:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v11 13/14] app/dumpcap: use port mirror instead of pdump
Date: Fri,  8 Aug 2025 09:55:51 -0700
Message-ID: <20250808165843.39075-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
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
This makes a new temporary ring PMD port and redirects
packets to that vdev.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c      | 392 ++++++++++++++++++++++++++++++++--------
 app/dumpcap/meson.build |   3 +-
 2 files changed, 318 insertions(+), 77 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..7e2e3c136a 100644
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
@@ -95,13 +93,23 @@ struct interface {
 	struct capture_options opts;
 	struct rte_bpf_prm *bpf_prm;
 	char name[RTE_ETH_NAME_MAX_LEN];
+	struct bpf_insn *bpf;
 
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
 TAILQ_HEAD(interface_list, interface);
 static struct interface_list interfaces = TAILQ_HEAD_INITIALIZER(interfaces);
+static struct interface *port2intf[RTE_MAX_ETHPORTS];
 
 /* Can do either pcap or pcapng format output */
 typedef union {
@@ -239,14 +247,16 @@ static void find_interfaces(void)
 
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
 
@@ -266,6 +276,10 @@ static void set_default_interface(void)
 
 		intf = add_interface(name);
 		intf->port = p;
+
+		if (rte_eth_stats_get(intf->port, &intf->start_stats) < 0)
+			rte_exit(EXIT_FAILURE,
+				 "Could not read stats for port %u\n", intf->port);
 		return;
 	}
 	rte_exit(EXIT_FAILURE, "No usable interfaces found\n");
@@ -291,24 +305,29 @@ static void compile_filters(void)
 	struct interface *intf;
 
 	TAILQ_FOREACH(intf, &interfaces, next) {
-		struct rte_bpf_prm *bpf_prm;
 		struct bpf_program bf;
 		pcap_t *pcap;
 
+		/* cache for filter packets */
+		port2intf[intf->port] = intf;
+
+		if (intf->opts.filter == NULL) {
+			intf->bpf = NULL;
+			continue;
+		}
+
 		pcap = pcap_open_dead(DLT_EN10MB, intf->opts.snap_len);
 		if (!pcap)
 			rte_exit(EXIT_FAILURE, "can not open pcap\n");
 
-		if (pcap_compile(pcap, &bf, intf->opts.filter,
-				 1, PCAP_NETMASK_UNKNOWN) != 0) {
+		if (pcap_compile(pcap, &bf, intf->opts.filter, 1, PCAP_NETMASK_UNKNOWN) != 0) {
 			fprintf(stderr,
 				"Invalid capture filter \"%s\": for interface '%s'\n",
 				intf->opts.filter, intf->name);
-			rte_exit(EXIT_FAILURE, "\n%s\n",
-				 pcap_geterr(pcap));
+			rte_exit(EXIT_FAILURE, "\n%s\n", pcap_geterr(pcap));
 		}
 
-		bpf_prm = rte_bpf_convert(&bf);
+		struct rte_bpf_prm *bpf_prm = rte_bpf_convert(&bf);
 		if (bpf_prm == NULL)
 			rte_exit(EXIT_FAILURE,
 				 "BPF convert interface '%s'\n%s(%d)\n",
@@ -518,13 +537,12 @@ static void statistics_loop(void)
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
@@ -541,7 +559,7 @@ monitor_primary(void *arg __rte_unused)
 		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
 	} else {
 		fprintf(stderr,
-			"Primary process is no longer active, exiting...\n");
+			"\nPrimary process is no longer active, exiting...\n");
 		rte_atomic_store_explicit(&quit_signal, true, rte_memory_order_relaxed);
 	}
 }
@@ -552,7 +570,6 @@ enable_primary_monitor(void)
 {
 	int ret;
 
-	/* Once primary exits, so will pdump. */
 	ret = rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
 	if (ret < 0)
 		fprintf(stderr, "Fail to enable monitor:%d\n", ret);
@@ -571,23 +588,24 @@ disable_primary_monitor(void)
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
@@ -668,12 +686,22 @@ static void dpdk_init(void)
 		rte_exit(EXIT_FAILURE, "Can not restore original CPU affinity\n");
 }
 
-/* Create packet ring shared between callbacks and process */
-static struct rte_ring *create_ring(void)
+/*
+ * Create ring port to redirect packet to.
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
@@ -686,17 +714,61 @@ static struct rte_ring *create_ring(void)
 		ring_size = size;
 	}
 
-	/* Want one ring per invocation of program */
-	snprintf(ring_name, sizeof(ring_name),
-		 "dumpcap-%d", getpid());
+	/* Use owner as unique ID for ring and to isolate instances of dumpcap */
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
+	snprintf(vdev_name, RTE_DEV_NAME_MAX_LEN, "net_ring-dumpcap%"PRIu64, owner.id);
+	snprintf(vdev_args, sizeof(vdev_args), "ring=%s", ring_name);
+
+	if (rte_eal_hotplug_add("vdev", vdev_name, vdev_args) < 0) {
+		fprintf(stderr, "rte_eal_hotplug_add of %s failed:%s\n",
+			 vdev_name, rte_strerror(rte_errno));
+		goto ringfree;
+	}
+
+	ret = rte_eth_dev_get_port_by_name(vdev_name, &port);
+	if (ret != 0) {
+		fprintf(stderr, "Could not find port for %s: %s\n",
+			vdev_name, strerror(-ret));
+		goto unplug;
+	}
+
+	ret = rte_eth_dev_owner_set(port, &owner);
+	if (ret != 0) {
+		fprintf(stderr, "Could not set owner for port %u: %s\n",
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
+ringfree:
+	rte_ring_free(ring);
+	rte_eal_cleanup();
+	exit(EXIT_FAILURE);
 }
 
 static struct rte_mempool *create_mempool(void)
@@ -796,7 +868,7 @@ static dumpcap_out_t create_output(void)
 					   version(), capture_comment);
 		if (ret.pcapng == NULL)
 			rte_exit(EXIT_FAILURE, "pcapng_fdopen failed: %s\n",
-				 strerror(rte_errno));
+				 rte_strerror(rte_errno));
 		free(os);
 
 		TAILQ_FOREACH(intf, &interfaces, next) {
@@ -823,37 +895,34 @@ static dumpcap_out_t create_output(void)
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
+			.flags = RTE_ETH_MIRROR_ORIGIN_FLAG |
+				RTE_ETH_MIRROR_TIMESTAMP_FLAG |
+				RTE_ETH_MIRROR_DIRECTION_INGRESS |
+				RTE_ETH_MIRROR_DIRECTION_EGRESS,
+			.filter = intf->bpf_prm,
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
@@ -868,6 +937,60 @@ static void enable_pdump(struct rte_ring *r, struct rte_mempool *mp)
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
+	offset = rte_mbuf_dynflag_lookup(RTE_MBUF_DYNFLAG_TX_TIMESTAMP_NAME, NULL);
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
@@ -898,6 +1021,47 @@ static void show_count(uint64_t count)
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
@@ -930,16 +1094,75 @@ pcap_write_packets(pcap_dumper_t *dumper,
 	return total;
 }
 
+/* Make sure configuration of mbuf pool has enough headroom for both VLAN's */
+static_assert(RTE_PKTMBUF_HEADROOM > 2 * sizeof(struct rte_vlan_hdr),
+	"not enough mbuf headroom for VLAN insertion");
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
@@ -948,11 +1171,12 @@ static int process_ring(dumpcap_out_t out, struct rte_ring *r)
 			usleep(10);
 		return 0;
 	}
-
 	empty_count = (avail == 0);
 
+	remove_vlan_offload(pkts, n);
+
 	if (use_pcapng)
-		written = rte_pcapng_write_packets(out.pcapng, pkts, n);
+		written = pcapng_write_packets(out.pcapng, pkts, n);
 	else
 		written = pcap_write_packets(out.dumper, pkts, n);
 
@@ -971,15 +1195,18 @@ static int process_ring(dumpcap_out_t out, struct rte_ring *r)
 
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
@@ -1018,12 +1245,21 @@ int main(int argc, char **argv)
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
@@ -1031,7 +1267,7 @@ int main(int argc, char **argv)
 	}
 
 	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
-		if (process_ring(out, r) < 0) {
+		if (process_ring(out, ring) < 0) {
 			fprintf(stderr, "pcapng file write failed; %s\n",
 				strerror(errno));
 			break;
@@ -1048,20 +1284,24 @@ int main(int argc, char **argv)
 			break;
 	}
 
-	disable_primary_monitor();
-
 	if (rte_eal_primary_proc_alive(NULL))
 		report_packet_stats(out);
 
+cleanup:
+	disable_primary_monitor();
+
 	if (use_pcapng)
 		rte_pcapng_close(out.pcapng);
 	else
 		pcap_dump_close(out.dumper);
 
-	cleanup_pdump_resources();
+	if (rte_eal_primary_proc_alive(NULL)) {
+		disable_mirror_ports(mirror_port);
 
-	rte_ring_free(r);
-	rte_mempool_free(mp);
+		rte_eal_hotplug_remove("vdev", vdev_name);
+		rte_ring_free(ring);
+		rte_mempool_free(mp);
+	}
 
 	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
 }
diff --git a/app/dumpcap/meson.build b/app/dumpcap/meson.build
index 69c016c780..82c0407450 100644
--- a/app/dumpcap/meson.build
+++ b/app/dumpcap/meson.build
@@ -14,4 +14,5 @@ endif
 
 ext_deps += pcap_dep
 sources = files('main.c')
-deps += ['ethdev', 'pdump', 'pcapng', 'bpf']
+
+deps += ['net_ring', 'ethdev', 'pcapng', 'bpf' ]
-- 
2.47.2

