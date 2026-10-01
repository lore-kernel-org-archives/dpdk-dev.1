Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041A8CA5FC1
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 02:59:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35D0C42D7F;
	Thu,  1 Oct 2026 04:59:01 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id B789D402EE
 for <dev@dpdk.org>; Thu,  1 Oct 2026 04:58:59 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so4004469a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 19:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790823539;
 x=1791428339; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9kU4qp48EFk5r6gEoANgmaS2vcWORMcA0Ishdu8YL58=;
 b=o1P2aFQRPgWnqAAdUEibhTDkX8oyPANc5LQ8/4LXI8cuVwonzSvAFe0RMSTtV5HC20
 iPXyC/hs0cY+cbHLFpqaFHWAyJ0rzUl17Onj7n+bwwbFgZ6OdBh8cJ/VMyXGE6BcQAlW
 eocpVpbKQ7pFZA0LmoE1vhmw6Xtn03NST7w7YN4oMOK/Ub/muSoYyHa9KRuHPSiq9Nta
 JhfkbcTDhJ/ihC1E/MUof08tRZ9xkC+1xND1SMqtFYTuOBmDC7LwrC6Uxw/85sBDgirB
 4QPSYuigBe+6n5n+ghDgIa8cojfen2YDOvL//j/5HxJgqzF4E/GjjwemUnWxliE6sKkn
 kFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790823539; x=1791428339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9kU4qp48EFk5r6gEoANgmaS2vcWORMcA0Ishdu8YL58=;
 b=hhKeiRql+aUNiYbK/Kj9fGSM7WP2Pe6E6ynLGg71lFqaz45P+28tA0Al9p8HTnHOQ0
 NuA4UcgS69RoBZxXpK6itG+fcVQfeTfMhF7WM9yc61T2dhT0h/aX/4hoUx/LR5II/xfW
 2Q1gtoUuJWqC9FB7CufgW/43QTe52J4J5eNIHbqU3yez22Dc5s7KRvW7aXmvUsG/CJPJ
 PpeakAvr0bGHZd6rB5+Jype7rqntH/L9y4CPZTUE1K/PSpN4k2wHn3i3feg74AdPpHaR
 k+AanceqVDmLwzaCyrg9Qz75oj8dvBCPLgj7LG6LLro5tkBbqIWUxBBHVfQw07fzLCPM
 q+tg==
X-Gm-Message-State: AFq9FYKKJPOahXKnE7bPfIO2PCzST4maN47aTi7446k8xiEQdysR/Hka
 wPwBe0mwAbLswgXQjB4XfHPjrMRRwJxQgYW3LAPXa+2P3rB5KkCcoTO0QQlwzccT1+uhhEl62R8
 p4s9tLME=
X-Gm-Gg: AYBFou3Ae8vz5FKp0xjXp/hbB2hCq0+o16iRrleamHIvqrwvX1T+J5oEIJwXMJJdjk8
 S21BYLrA3VYltAmWFUr6fQyDTWRu4q2MwRsCgp5d9U2/3DrN17f/JQ9mjwDtrX0tXXW3nGrmF5v
 BWlmJ4bexTFHO1kpAvZbolhpt7TqTIzfaw5J8ANzdeVsG/OBNKe4tVrmKx3exSyAmTh3ML7CYMq
 RI3g3sCHMoWjfVB9BgU9T/jkbYDKQgBzLO3Gv6VYDIoDYg8XegqHj0uvUJmu/nfgTF/UEh+lpog
 Vr683TwPp7SMnOQWWJ+PDmTxhOE//2uPInx7s4T9WAt6vfR7gD+I3hNS5qFJQB0YsLvUAG2qHJ5
 Pd9jH2pPU3zFEo2rdnVZTiMUegsckykEjgjkePfLfznzxhjqgXMzZ9NmhcrkmR2NtpdYDZpXlIj
 0VwdyuWsRQjR9XMKkiQCwmbOF/fxSZg6KmJjLX4rBBUMOu3tgP3v796BB99xad5DrkJxaOg1Axq
 lj0CPEGlCKyE0ufNA39yYhYF+HfnzUPOoBPJg==
X-Received: by 2002:a17:90b:2787:b0:3a0:bbd8:5ba7 with SMTP id
 98e67ed59e1d1-3a4d19263b8mr2920750a91.62.1790823538006; 
 Wed, 30 Sep 2026 19:58:58 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f471b16asm2024487a91.9.2026.09.30.19.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:58:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 2/4] app/rpcapd: remote pcap daemon
Date: Wed, 30 Sep 2026 19:35:27 -0700
Message-ID: <20261001025853.319860-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001025853.319860-1-stephen@networkplumber.org>
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20261001025853.319860-1-stephen@networkplumber.org>
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

Add RPCAP support over localhost TCP integrated with DPDK.
It runs as a secondary process that allows connections from
tools using tcpdump's defacto protocol rpcap.

See: doc/guides/tools/rpcapd.rst for more info

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                            |   2 +
 app/meson.build                        |   1 +
 app/rpcapd/capture.c                   | 526 ++++++++++++++++++++++
 app/rpcapd/filter.c                    | 164 +++++++
 app/rpcapd/main.c                      | 577 +++++++++++++++++++++++++
 app/rpcapd/meson.build                 |  25 ++
 app/rpcapd/rpcap-protocol.h            | 142 ++++++
 app/rpcapd/rpcapd.h                    | 105 +++++
 app/rpcapd/session.c                   | 136 ++++++
 app/rpcapd/sock.c                      | 315 ++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |   5 +
 doc/guides/tools/index.rst             |   1 +
 doc/guides/tools/rpcapd.rst            | 199 +++++++++
 13 files changed, 2198 insertions(+)
 create mode 100644 app/rpcapd/capture.c
 create mode 100644 app/rpcapd/filter.c
 create mode 100644 app/rpcapd/main.c
 create mode 100644 app/rpcapd/meson.build
 create mode 100644 app/rpcapd/rpcap-protocol.h
 create mode 100644 app/rpcapd/rpcapd.h
 create mode 100644 app/rpcapd/session.c
 create mode 100644 app/rpcapd/sock.c
 create mode 100644 doc/guides/tools/rpcapd.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 482bc7df76..fd56b6b440 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1722,6 +1722,8 @@ F: app/pdump/
 F: doc/guides/tools/pdump.rst
 F: app/dumpcap/
 F: doc/guides/tools/dumpcap.rst
+F: app/rpcapd/
+F: doc/guides/tools/rpcapd.rst
 
 
 Packet Framework
diff --git a/app/meson.build b/app/meson.build
index 4515688471..b9227f1fe4 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -17,6 +17,7 @@ apps = [
         'graph',
         'pdump',
         'proc-info',
+        'rpcapd',
         'test-acl',
         'test-bbdev',
         'test-cmdline',
diff --git a/app/rpcapd/capture.c b/app/rpcapd/capture.c
new file mode 100644
index 0000000000..17fce3fbca
--- /dev/null
+++ b/app/rpcapd/capture.c
@@ -0,0 +1,526 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ *
+ * Starting and stopping a capture, and streaming the captured packets
+ * to the client over the data connection.
+ */
+
+#include <errno.h>
+#include <poll.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <sys/uio.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <rte_byteorder.h>
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_errno.h>
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
+#include <rte_pcapng.h>
+#include <rte_pdump.h>
+#include <rte_ring.h>
+#include <rte_stdatomic.h>
+#include <rte_time.h>
+
+#include "rpcap-protocol.h"
+#include "rpcapd.h"
+
+#define BURST_SIZE                    32
+#define MBUF_CACHE_SIZE               32
+#define SLEEP_THRESHOLD		      100
+#define SLEEP_US		      100
+#define DATA_ACCEPT_TIMEOUT_MS        10000
+
+/* Reference point for converting a captured TSC to a time of day.
+ * The TSC is the same counter in the primary that did the capture.
+ */
+static uint64_t tsc_base;
+static uint64_t ns_base;
+
+void
+timestamp_init(void)
+{
+	struct timespec ts;
+	uint64_t cycles;
+
+	cycles = rte_get_tsc_cycles();
+	clock_gettime(CLOCK_REALTIME, &ts);
+	ns_base = rte_timespec_to_ns(&ts);
+	tsc_base = (cycles + rte_get_tsc_cycles()) / 2;
+}
+
+/* Convert a captured TSC to nanoseconds since the Unix epoch.  Whole
+ * seconds come out first so scaling the remainder cannot overflow, and
+ * a packet copied before startup is behind the reference point.
+ */
+static uint64_t
+timestamp_to_ns(uint64_t cycles)
+{
+	const uint64_t hz = rte_get_tsc_hz();
+	uint64_t delta, secs, rem;
+	bool before;
+
+	before = cycles < tsc_base;
+	delta = before ? tsc_base - cycles : cycles - tsc_base;
+
+	secs = delta / hz;
+	rem = delta % hz;
+	delta = secs * NSEC_PER_SEC + (rem * NSEC_PER_SEC) / hz;
+
+	return before ? ns_base - delta : ns_base + delta;
+}
+
+
+/* Open an ephemeral TCP listening socket; return fd, set *port_out. */
+static int
+open_data_listener(uint16_t *port_out)
+{
+	struct sockaddr_storage addr = listen_addr;
+	socklen_t alen;
+	int fd;
+
+	set_sockaddr_port(&addr, 0);
+
+	fd = socket(addr.ss_family, SOCK_STREAM, 0);
+	if (fd < 0) {
+		RPCAPD_LOG(ERR, "data socket: %s", strerror(errno));
+		return -1;
+	}
+
+	alen = listen_addrlen;
+	if (bind(fd, (struct sockaddr *)&addr, alen) < 0 ||
+	    listen(fd, 1) < 0 ||
+	    getsockname(fd, (struct sockaddr *)&addr, &alen) < 0) {
+		RPCAPD_LOG(ERR, "data port bind/listen: %s", strerror(errno));
+		close(fd);
+		return -1;
+	}
+	*port_out = get_sockaddr_port(&addr);
+	return fd;
+}
+
+static struct rte_ring *
+create_capture_ring(uint16_t port)
+{
+	char name[RTE_RING_NAMESIZE];
+
+	snprintf(name, sizeof(name), "rpcapd_r_%u_%d", port, getpid());
+	return rte_ring_create(name, ring_size, rte_socket_id(), 0);
+}
+
+static struct rte_mempool *
+create_capture_mempool(uint16_t port, uint32_t snaplen)
+{
+	char name[RTE_MEMPOOL_NAMESIZE];
+	/* Leaves room for the pcapng block header, the options and the
+	 * trailer, as well as the packet itself.
+	 */
+	uint32_t mbuf_size = rte_pcapng_mbuf_size(snaplen);
+
+	snprintf(name, sizeof(name), "rpcapd_p_%u_%d", port, getpid());
+	return rte_pktmbuf_pool_create(name, ring_size * 2, MBUF_CACHE_SIZE, 0,
+				       mbuf_size, rte_socket_id());
+}
+
+
+/* Tear down anything that handle_startcap brought up.
+ * Safe to call after partial setup as well as after a successful capture.
+ */
+void
+stop_capture(struct session *s)
+{
+	struct rte_mbuf *pkts[BURST_SIZE];
+	unsigned int n;
+
+	if (s->capture_on) {
+		rte_pdump_disable(s->port, RTE_PDUMP_ALL_QUEUES, s->pdump_flags);
+		RPCAPD_LOG(NOTICE, "capture stopped on %s (%u packets)",
+			s->name, s->npkt);
+	}
+	s->capture_on = false;
+
+	if (s->promisc_set) {
+		rte_eth_promiscuous_disable(s->port);
+		s->promisc_set = false;
+	}
+
+	if (s->ring != NULL) {
+		while ((n = rte_ring_sc_dequeue_burst(s->ring, (void **)pkts,
+						      BURST_SIZE, NULL)) > 0)
+			rte_pktmbuf_free_bulk(pkts, n);
+		rte_ring_free(s->ring);
+		s->ring = NULL;
+	}
+	if (s->mp != NULL) {
+		rte_mempool_free(s->mp);
+		s->mp = NULL;
+	}
+
+	/* Only safe once pdump is disabled */
+	rte_free(s->prm);
+	s->prm = NULL;
+	if (s->data.fd >= 0) {
+		close(s->data.fd);
+		s->data.fd = -1;
+	}
+}
+
+/*
+ * STARTCAP_REQ: open the data connection and arm the pdump callback.
+ * We use passive mode with the server-allocated data port:
+ *   - the server picks an ephemeral port and listens on it
+ *   - the server returns that port in startcapreply.portdata
+ *   - the client connects back to that port for the packet stream
+ */
+int
+handle_startcap(const struct conn *c, uint32_t plen, struct session *s)
+{
+	struct rpcap_startcapreq req;
+	uint16_t data_port;
+	uint16_t flags;
+	struct rte_bpf_prm *recorded;
+	int data_listen;
+	int data_fd;
+	int ret;
+
+	/* Keep a filter set before the capture started, drop one from a
+	 * capture being restarted: this request brings its own.
+	 */
+	recorded = s->capture_on ? NULL : s->prm;
+	if (recorded != NULL)
+		s->prm = NULL;
+	stop_capture(s);
+	s->prm = recorded;
+
+	if (!s->opened) {
+		rpcap_discard(c, plen);
+		return rpcap_send_error(c, 0, "no interface open");
+	}
+
+	if (plen < sizeof(req)) {
+		rpcap_discard(c, plen);
+		return rpcap_send_error(c, 0, "short startcap request");
+	}
+	if (recv_full(c, &req, sizeof(req)) < 0)
+		return -1;
+
+	flags = rte_be_to_cpu_16(req.flags);
+	if (flags & RPCAP_STARTCAPREQ_FLAG_DGRAM) {
+		rpcap_discard(c, plen - sizeof(req));
+		return rpcap_send_error(c, 0, "UDP data transfer not supported");
+	}
+
+	ret = read_filter(c, plen - sizeof(req), s);
+	if (ret != 0)
+		return ret < 0 ? -1 : 0;	/* error already reported to client */
+
+	/* Direction flags map onto pdump's RX/TX selection; neither (or both)
+	 * means capture in both directions.
+	 */
+	s->pdump_flags = RTE_PDUMP_FLAG_RXTX;
+	if ((flags & (RPCAP_STARTCAPREQ_FLAG_INBOUND |
+		      RPCAP_STARTCAPREQ_FLAG_OUTBOUND)) ==
+	    RPCAP_STARTCAPREQ_FLAG_INBOUND)
+		s->pdump_flags = RTE_PDUMP_FLAG_RX;
+	else if ((flags & (RPCAP_STARTCAPREQ_FLAG_INBOUND |
+			   RPCAP_STARTCAPREQ_FLAG_OUTBOUND)) ==
+		 RPCAP_STARTCAPREQ_FLAG_OUTBOUND)
+		s->pdump_flags = RTE_PDUMP_FLAG_TX;
+
+	s->snaplen = rte_be_to_cpu_32(req.snaplen);
+	if (s->snaplen == 0 || s->snaplen > DEFAULT_SNAPLEN)
+		s->snaplen = DEFAULT_SNAPLEN;
+
+	s->ring = create_capture_ring(s->port);
+	s->mp = create_capture_mempool(s->port, s->snaplen);
+	if (s->ring == NULL || s->mp == NULL) {
+		RPCAPD_LOG(ERR, "ring/mempool alloc failed: %s",
+			rte_strerror(rte_errno));
+		stop_capture(s);
+		return rpcap_send_error(c, 0, "DPDK alloc failed");
+	}
+
+	data_listen = open_data_listener(&data_port);
+	if (data_listen < 0) {
+		stop_capture(s);
+		return rpcap_send_error(c, 0, "data port setup failed");
+	}
+
+	/* Leave the port alone if it is already promiscuous: it belongs to
+	 * the primary process, and stop_capture() must not turn off
+	 * something this daemon did not turn on.
+	 */
+	if ((flags & RPCAP_STARTCAPREQ_FLAG_PROMISC) &&
+	    rte_eth_promiscuous_get(s->port) != 1) {
+		if (rte_eth_promiscuous_enable(s->port) == 0)
+			s->promisc_set = true;
+		else
+			RPCAPD_LOG(NOTICE, "cannot enable promiscuous mode on %s",
+				s->name);
+	}
+
+	/* Setup packet capture callbacks. */
+	if (rte_pdump_enable_bpf(s->port, RTE_PDUMP_ALL_QUEUES,
+				 s->pdump_flags | RTE_PDUMP_FLAG_PCAPNG,
+				 s->snaplen, s->ring, s->mp, s->prm) < 0) {
+		RPCAPD_LOG(ERR, "rte_pdump_enable_bpf port %u failed: %s",
+			s->port, rte_strerror(rte_errno));
+		close(data_listen);
+		stop_capture(s);
+		return rpcap_send_error(c, 0, "cannot enable capture");
+	}
+	s->capture_on = true;
+	s->npkt = 0;
+
+	struct rpcap_startcapreply reply = {
+		.bufsize = rte_cpu_to_be_32(s->snaplen * BURST_SIZE),
+		.portdata = rte_cpu_to_be_16(data_port),
+	};
+	if (rpcap_send_msg(c, RPCAP_MSG_STARTCAP_REPLY, 0, &reply, sizeof(reply)) < 0) {
+		close(data_listen);
+		stop_capture(s);
+		return -1;
+	}
+
+	RPCAPD_LOG(DEBUG, "awaiting connection");
+
+	data_fd = accept_from(data_listen, &s->peer, DATA_ACCEPT_TIMEOUT_MS);
+	close(data_listen);
+	if (data_fd < 0) {
+		stop_capture(s);
+		return -1;
+	}
+
+	/* Bound how long a send can block. */
+	if (send_timeout > 0) {
+		struct timeval tv = {
+			.tv_sec = send_timeout,
+		};
+
+		if (setsockopt(data_fd, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(tv)) < 0)
+			RPCAPD_LOG(NOTICE, "cannot set data send timeout: %s",
+				   strerror(errno));
+	}
+
+	s->data.fd = data_fd;
+
+	RPCAPD_LOG(NOTICE,
+		   "capture started on %s (snaplen %u, data port %u)",
+		   s->name, s->snaplen, data_port);
+	return 0;
+}
+
+/*
+ * Frame each packet from the ring into an RPCAP_MSG_PACKET message and
+ * send it on the data connection.  MSG_MORE corks the socket until the
+ * ring drains, so a backlog coalesces into full segments.  pdump wraps
+ * packets in a pcapng enhanced packet block, which carries the capture
+ * time and the pre-truncation length.
+ */
+static ssize_t
+process_ring(struct session *s, unsigned int *avail)
+{
+	struct rte_mbuf *pkts[BURST_SIZE];
+	unsigned int i, n;
+	ssize_t written = 0;
+
+	n = rte_ring_sc_dequeue_burst(s->ring, (void **)pkts, BURST_SIZE, avail);
+	if (n == 0)
+		return 0;
+
+	for (i = 0; i < n; i++) {
+		struct rte_mbuf *m = pkts[i];
+		uint8_t buf[MAX_CAPTURE_LEN];
+		struct rte_pcapng_pkt pkt;
+		uint32_t caplen, wirelen;
+		const void *data;
+
+		if (unlikely(rte_pcapng_pkt_info(m, &pkt) != 0)) {
+			RPCAPD_LOG(ERR, "malformed capture mbuf on %s", s->name);
+			goto error;
+		}
+
+		caplen = pkt.captured_len;
+		if (unlikely(caplen > sizeof(buf)))
+			caplen = sizeof(buf);
+
+		/* clients reject a packet whose len is below its caplen */
+		wirelen = RTE_MAX(pkt.original_len, caplen);
+		data = rte_pktmbuf_read(m, pkt.data_offset, caplen, buf);
+		if (unlikely(data == NULL)) {
+			RPCAPD_LOG(ERR, "short capture mbuf on %s", s->name);
+			goto error;
+		}
+
+		s->npkt++;
+
+		struct rpcap_header hdr = {
+			.ver = RPCAP_VERSION,
+			.type = RPCAP_MSG_PACKET,
+			.plen = rte_cpu_to_be_32(sizeof(struct rpcap_pkthdr) + caplen),
+		};
+
+		/* rpcap protocol has timestamp in microseconds. */
+		uint64_t us = timestamp_to_ns(pkt.cycles) / 1000;
+		struct rpcap_pkthdr pkthdr = {
+			.timestamp_sec = rte_cpu_to_be_32(us / US_PER_S),
+			.timestamp_usec = rte_cpu_to_be_32(us % US_PER_S),
+			.caplen = rte_cpu_to_be_32(caplen),
+			.len = rte_cpu_to_be_32(wirelen),
+			.npkt = rte_cpu_to_be_32(s->npkt),
+		};
+
+		struct iovec iov[3] = {
+			{
+				.iov_base = &hdr,
+				.iov_len = sizeof(hdr),
+			},
+			{
+				.iov_base = &pkthdr,
+				.iov_len = sizeof(pkthdr),
+			},
+			{
+				.iov_base = (void *)(uintptr_t)data,
+				.iov_len = caplen,
+			},
+		};
+
+		/* more to come in this burst, or still queued in the ring */
+		bool more = (i + 1 < n) || (*avail > 0);
+
+		if (send_iov_full(&s->data, iov, 3, more ? MSG_MORE : 0) < 0) {
+			if (errno == EPIPE || errno == ECONNRESET)
+				RPCAPD_LOG(DEBUG, "data connection closed by client");
+			else if (errno == EAGAIN || errno == EWOULDBLOCK)
+				RPCAPD_LOG(NOTICE,
+					   "client stopped reading data connection, closing");
+			else
+				RPCAPD_LOG(NOTICE, "send on data connection failed: %s",
+					   strerror(errno));
+			goto error;
+		}
+		rte_pktmbuf_free(m);
+		written += sizeof(hdr) + sizeof(pkthdr) + caplen;
+	}
+
+	return written;
+
+error:
+	rte_pktmbuf_free_bulk(pkts + i, n - i);
+	return -1;
+}
+
+/* Poll the control socket while idle.
+ * Returns 0 to keep capturing, 1 if a control message (typically
+ * ENDCAP) is pending, or -1 if the client has gone away.
+ */
+static int
+check_socket_status(const struct conn *ctrl)
+{
+	struct pollfd pfd = { .fd = ctrl->fd, .events = POLLIN };
+
+	if (poll(&pfd, 1, 0) < 0) {
+		if (errno == EINTR)
+			return 0;
+		RPCAPD_LOG(ERR, "poll failed: %s", strerror(errno));
+		return -1;
+	}
+	if (pfd.revents & (POLLERR | POLLHUP | POLLNVAL)) {
+		RPCAPD_LOG(DEBUG, "client closed control connection");
+		return -1;
+	}
+	if (pfd.revents & POLLIN)
+		return 1;
+	return 0;
+}
+
+/*
+ * Drain the ring until a control message arrives, the data connection
+ * breaks, or a quit signal is delivered.  Returns 0 if the session
+ * should continue, -1 if the client is gone.
+ *
+ * The control socket is polled every iteration, not only when the ring
+ * is empty: a client waiting for a reply stops draining the data
+ * socket, and both ends wedge once the buffers fill.
+ */
+int
+capture_loop(const struct conn *ctrl, struct session *s)
+{
+	unsigned int empty_count = 0;
+
+	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
+		ssize_t written;
+		unsigned int avail = 0;
+
+		switch (check_socket_status(ctrl)) {
+		case 1:
+			/* control message pending, let caller service it */
+			return 0;
+		case 0:
+			break;
+		default:
+			/* client is gone */
+			return -1;
+		}
+
+		written = process_ring(s, &avail);
+		if (written < 0) {
+			/* process_ring has already logged the reason */
+			return -1;
+		}
+
+		if (written > 0) {
+			/* are there more packets? */
+			empty_count = (avail == 0);
+			continue;
+		}
+
+		if (empty_count < SLEEP_THRESHOLD) {
+			/* spin a few times before checking */
+			++empty_count;
+			rte_pause();
+			continue;
+		}
+
+		/* ring has been empty for a while: stop spinning */
+		rte_delay_us_sleep(SLEEP_US);
+	}
+	return 0;
+}
+
+int
+handle_endcap(const struct conn *c, uint32_t plen, struct session *s)
+{
+	if (rpcap_discard(c, plen) < 0)
+		return -1;
+	stop_capture(s);
+	return rpcap_send_msg(c, RPCAP_MSG_ENDCAP_REPLY, 0, NULL, 0);
+}
+
+int
+handle_stats(const struct conn *c, uint32_t plen, const struct session *s)
+{
+	struct rte_eth_stats es = { 0 };
+
+	if (rpcap_discard(c, plen) < 0)
+		return -1;
+
+	if (s->capture_on)
+		rte_eth_stats_get(s->port, &es);
+
+	struct rpcap_stats reply = {
+		.ifrecv   = rte_cpu_to_be_32((uint32_t)es.ipackets),
+		.ifdrop   = rte_cpu_to_be_32((uint32_t)es.ierrors),
+		.krnldrop = 0,
+		.svrcapt  = rte_cpu_to_be_32(s->npkt),
+	};
+	return rpcap_send_msg(c, RPCAP_MSG_STATS_REPLY, 0, &reply, sizeof(reply));
+}
diff --git a/app/rpcapd/filter.c b/app/rpcapd/filter.c
new file mode 100644
index 0000000000..bdf7b8eaf1
--- /dev/null
+++ b/app/rpcapd/filter.c
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ *
+ * Capture filters.  The client compiles the filter, so it arrives as
+ * cBPF and has to be converted to the DPDK form that pdump takes.
+ */
+
+#include <stdlib.h>
+
+#include <pcap/pcap.h>
+
+#include <rte_bpf.h>
+#include <rte_byteorder.h>
+#include <rte_errno.h>
+#include <rte_malloc.h>
+#include <rte_pdump.h>
+
+#include "rpcap-protocol.h"
+#include "rpcapd.h"
+
+#define MAX_FILTER_INSNS              4096
+
+/*
+ * Read the optional capture filter that follows a start-capture request,
+ * and convert it for pdump. Client passes cBPF.
+ */
+int
+read_filter(const struct conn *c, uint32_t plen, struct session *s)
+{
+	struct rpcap_filterbpf_insn winsn;
+	struct rpcap_filter filter;
+	struct bpf_program bf;
+	struct bpf_insn *insns;
+	uint32_t i, nitems;
+
+	if (plen == 0)
+		return 0;		/* no filter: capture everything */
+
+	if (plen < sizeof(filter)) {
+		if (rpcap_discard(c, plen) < 0)
+			return -1;
+		return rpcap_send_error(c, 0, "short filter header") < 0 ? -1 : 1;
+	}
+
+	if (recv_full(c, &filter, sizeof(filter)) < 0)
+		return -1;
+	plen -= sizeof(filter);
+
+	if (rte_be_to_cpu_16(filter.filtertype) != RPCAP_UPDATEFILTER_BPF) {
+		if (rpcap_discard(c, plen) < 0)
+			return -1;
+		return rpcap_send_error(c, 0, "unsupported filter type") < 0 ? -1 : 1;
+	}
+
+	/* nitems is client-supplied; bound it before trusting the length. */
+	nitems = rte_be_to_cpu_32(filter.nitems);
+	if (nitems == 0)
+		return rpcap_discard(c, plen) < 0 ? -1 : 0;
+
+	if (nitems > MAX_FILTER_INSNS || plen < nitems * sizeof(winsn)) {
+		if (rpcap_discard(c, plen) < 0)
+			return -1;
+		return rpcap_send_error(c, 0, "bad filter length") < 0 ? -1 : 1;
+	}
+
+	insns = calloc(nitems, sizeof(*insns));
+	if (insns == NULL) {
+		if (rpcap_discard(c, plen) < 0)
+			return -1;
+		return rpcap_send_error(c, 0, "out of memory") < 0 ? -1 : 1;
+	}
+
+	for (i = 0; i < nitems; i++) {
+		if (recv_full(c, &winsn, sizeof(winsn)) < 0) {
+			free(insns);
+			return -1;
+		}
+		insns[i].code = rte_be_to_cpu_16(winsn.code);
+		insns[i].jt   = winsn.jt;
+		insns[i].jf   = winsn.jf;
+		insns[i].k    = rte_be_to_cpu_32(winsn.k);
+	}
+	plen -= nitems * sizeof(winsn);
+
+	/* Anything after the instructions is padding we do not need. */
+	if (rpcap_discard(c, plen) < 0) {
+		free(insns);
+		return -1;
+	}
+
+	bf.bf_len = nitems;
+	bf.bf_insns = insns;
+
+	/* Reject a malformed program here */
+	if (!bpf_validate(bf.bf_insns, bf.bf_len)) {
+		free(insns);
+		return rpcap_send_error(c, 0, "invalid filter program") < 0 ? -1 : 1;
+	}
+
+	/* A filter recorded by an earlier UPDATEFILTER may still be here */
+	rte_free(s->prm);
+	s->prm = rte_bpf_convert(&bf);
+	free(insns);
+	if (s->prm == NULL) {
+		RPCAPD_LOG(ERR, "rte_bpf_convert failed: %s",
+			rte_strerror(rte_errno));
+		return rpcap_send_error(c, 0, "cannot convert filter") < 0 ? -1 : 1;
+	}
+
+	RPCAPD_LOG(DEBUG, "capture filter: %u instructions", nitems);
+	return 0;
+}
+
+/*
+ * UPDATEFILTER_REQ: replace the capture filter.
+ *
+ * pdump takes its filter when the callback is setup.
+ * To replace need to drop old callback and put in new one.
+ * Packets already in the ring are kept.
+ *
+ * Before the capture starts this just records the filter for the
+ * eventual STARTCAP.
+ */
+int
+handle_updatefilter(const struct conn *c, uint32_t plen, struct session *s)
+{
+	struct rte_bpf_prm *old = s->prm;
+	int ret;
+
+	s->prm = NULL;
+	ret = read_filter(c, plen, s);
+	if (ret != 0) {
+		/* Malformed request: keep running with the old filter. */
+		rte_free(s->prm);
+		s->prm = old;
+		return ret < 0 ? -1 : 0;	/* error already reported */
+	}
+
+	if (!s->capture_on) {
+		rte_free(old);
+		return rpcap_send_msg(c, RPCAP_MSG_UPDATEFILTER_REPLY, 0, NULL, 0);
+	}
+
+	rte_pdump_disable(s->port, RTE_PDUMP_ALL_QUEUES, s->pdump_flags);
+	s->capture_on = false;
+
+	if (rte_pdump_enable_bpf(s->port, RTE_PDUMP_ALL_QUEUES,
+				 s->pdump_flags | RTE_PDUMP_FLAG_PCAPNG,
+				 s->snaplen, s->ring, s->mp, s->prm) < 0) {
+		RPCAPD_LOG(ERR, "rte_pdump_enable_bpf port %u failed: %s",
+			s->port, rte_strerror(rte_errno));
+		rte_free(old);
+		/* The capture cannot be resumed */
+		stop_capture(s);
+		return rpcap_send_error(c, 0, "cannot apply filter");
+	}
+	s->capture_on = true;
+
+	/* Safe now that the old program is no longer referenced. */
+	rte_free(old);
+
+	RPCAPD_LOG(DEBUG, "capture filter updated on %s", s->name);
+	return rpcap_send_msg(c, RPCAP_MSG_UPDATEFILTER_REPLY, 0, NULL, 0);
+}
diff --git a/app/rpcapd/main.c b/app/rpcapd/main.c
new file mode 100644
index 0000000000..7b7288785d
--- /dev/null
+++ b/app/rpcapd/main.c
@@ -0,0 +1,577 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ *
+ * Demonstration server for the rpcap protocol for DPDK.
+ * This allows a libpcap client (e.g. Wireshark or tcpdump)
+ * to use "rpcap://host[:port]/portname" as capture device.
+ *
+ * Based on the DPDK dumpcap application and on rpcapd from libpcap:
+ *   https://github.com/the-tcpdump-group/libpcap/tree/master/rpcapd
+ *
+ * Only the bits of the RPCAP protocol that are needed for an
+ * unauthenticated, passive-mode capture session are implemented.
+ * Configuration files, active mode, sampling and concurrent clients
+ * are intentionally omitted.
+ *
+ * Options, startup and the control connection dispatcher live here; the
+ * request handlers are in session.c, capture.c and filter.c.
+ */
+
+#include <arpa/inet.h>
+#include <errno.h>
+#include <getopt.h>
+#include <netinet/in.h>
+#include <netdb.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <rte_alarm.h>
+#include <rte_byteorder.h>
+#include <rte_common.h>
+#include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_ethdev.h>
+#include <rte_lcore.h>
+#include <rte_log.h>
+#include <rte_pdump.h>
+#include <rte_stdatomic.h>
+#include <rte_version.h>
+
+#include "rpcap-protocol.h"
+#include "rpcapd.h"
+
+#define DEFAULT_RING_SIZE             2048
+#define MAX_RING_SIZE                 (1U << 20)
+#define PRIMARY_MONITOR_INTERVAL_US   (500 * 1000)
+#define DATA_SEND_TIMEOUT_SEC         10
+
+/* Command-line options */
+static uint16_t listen_port = RPCAP_DEFAULT_NETPORT;
+uint32_t ring_size = DEFAULT_RING_SIZE;
+static const char *lcore_arg;
+static const char *file_prefix;
+static const char *bind_addr;		/* -b argument; NULL means loopback */
+static int bind_family = AF_UNSPEC;
+static const char *debug_file;		/* --debug-file argument */
+static unsigned int debug_log;		/* -D count: raise RPCAPD log verbosity */
+uint32_t send_timeout = DATA_SEND_TIMEOUT_SEC;	/* 0 means no limit */
+
+struct sockaddr_storage listen_addr;
+socklen_t               listen_addrlen;
+
+RTE_ATOMIC(bool) quit_signal;
+
+static bool
+is_loopback(const struct sockaddr_storage *ss)
+{
+	if (ss->ss_family == AF_INET) {
+		const struct sockaddr_in *sin = (const void *)ss;
+
+		return (ntohl(sin->sin_addr.s_addr) >> 24) == 127;
+	}
+	if (ss->ss_family == AF_INET6) {
+		const struct sockaddr_in6 *sin6 = (const void *)ss;
+
+		/* A v4 client on a dual-stack socket arrives as
+		 * ::ffff:127.0.0.1, which is loopback too.
+		 */
+		if (IN6_IS_ADDR_V4MAPPED(&sin6->sin6_addr))
+			return sin6->sin6_addr.s6_addr[12] == 127;
+
+		return IN6_IS_ADDR_LOOPBACK(&sin6->sin6_addr);
+	}
+	return false;
+}
+
+static void
+parse_bind_addr(void)
+{
+	struct addrinfo hints = {
+		.ai_family   = bind_family,
+		.ai_socktype = SOCK_STREAM,
+		.ai_flags    = AI_NUMERICHOST | AI_PASSIVE,
+	};
+	struct addrinfo *res;
+	int rc;
+
+	/* Loopback by default; the wildcard address is not a safe default. */
+	if (bind_addr == NULL)
+		bind_addr = (bind_family == AF_INET6) ? "::1" : "127.0.0.1";
+
+	rc = getaddrinfo(bind_addr, NULL, &hints, &res);
+	if (rc != 0)
+		rte_exit(EXIT_FAILURE, "Invalid bind address '%s': %s\n",
+			 bind_addr, gai_strerror(rc));
+	memcpy(&listen_addr, res->ai_addr, res->ai_addrlen);
+	listen_addrlen = res->ai_addrlen;
+	freeaddrinfo(res);
+}
+
+
+static void
+signal_handler(int sig __rte_unused)
+{
+	rte_atomic_store_explicit(&quit_signal, true, rte_memory_order_relaxed);
+}
+
+/* Service a single client until it disconnects. */
+static void
+handle_client(int ctrl_fd)
+{
+	struct sockaddr_storage peer;
+	socklen_t peerlen = sizeof(peer);
+	char host[NI_MAXHOST] = "?";
+	struct conn ctrl = { .fd = ctrl_fd };
+	struct session s = { .data.fd = -1 };
+
+	/* Remembered so the data connection can be restricted to this peer. */
+	if (getpeername(ctrl_fd, (struct sockaddr *)&peer, &peerlen) != 0) {
+		RPCAPD_LOG(ERR, "getpeername: %s", strerror(errno));
+		return;
+	}
+	s.peer = peer;
+	getnameinfo((struct sockaddr *)&peer, peerlen,
+		    host, sizeof(host), NULL, 0, NI_NUMERICHOST);
+	RPCAPD_LOG(NOTICE, "client %s connected", host);
+
+	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
+		struct rpcap_header hdr;
+		uint32_t plen;
+
+		/* Drain the ring whenever a capture is running */
+		if (s.capture_on && capture_loop(&ctrl, &s) < 0)
+			goto done;
+
+		if (recv_full(&ctrl, &hdr, sizeof(hdr)) < 0)
+			break;
+
+		plen = rte_be_to_cpu_32(hdr.plen);
+
+		/* Only version 0 is spoken here */
+		if (hdr.ver != RPCAP_VERSION) {
+			RPCAPD_LOG(WARNING, "unsupported protocol version %u",
+				hdr.ver);
+			if (rpcap_discard(&ctrl, plen) < 0 ||
+			    rpcap_send_error(&ctrl, PCAP_ERR_WRONGVER,
+					     "unsupported protocol version") < 0)
+				goto done;
+			continue;
+		}
+
+		switch (hdr.type) {
+		case RPCAP_MSG_AUTH_REQ:
+			/* libpcap treats a zero-length AUTH_REPLY as "version
+			 * 0 only, same byte order".
+			 */
+			if (handle_auth(&ctrl, plen) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_FINDALLIF_REQ:
+			if (rpcap_discard(&ctrl, plen) < 0 || handle_findallif(&ctrl) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_OPEN_REQ:
+			if (handle_open(&ctrl, plen, &s) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_STARTCAP_REQ:
+			if (handle_startcap(&ctrl, plen, &s) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_UPDATEFILTER_REQ:
+			if (handle_updatefilter(&ctrl, plen, &s) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_ENDCAP_REQ:
+			if (handle_endcap(&ctrl, plen, &s) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_STATS_REQ:
+			if (handle_stats(&ctrl, plen, &s) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_CLOSE:
+			rpcap_discard(&ctrl, plen);
+			goto done;
+		default:
+			RPCAPD_LOG(WARNING, "unsupported request type 0x%02x", hdr.type);
+			if (rpcap_discard(&ctrl, plen) < 0 ||
+			    rpcap_send_error(&ctrl, 0, "unsupported request") < 0)
+				goto done;
+			break;
+		}
+	}
+done:
+	stop_capture(&s);
+	close(ctrl_fd);
+	RPCAPD_LOG(NOTICE, "client %s disconnected", host);
+}
+
+static int
+open_listen_socket(uint16_t port)
+{
+	struct sockaddr_storage addr = listen_addr;
+	char host[NI_MAXHOST];
+	int fd, one = 1;
+
+	set_sockaddr_port(&addr, port);
+
+	fd = socket(addr.ss_family, SOCK_STREAM, 0);
+	if (fd < 0)
+		rte_exit(EXIT_FAILURE, "socket: %s\n", strerror(errno));
+	setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+
+	if (bind(fd, (struct sockaddr *)&addr, listen_addrlen) < 0)
+		rte_exit(EXIT_FAILURE, "bind(%u): %s\n", port, strerror(errno));
+
+	int err = getnameinfo((struct sockaddr *)&listen_addr, listen_addrlen,
+			      host, sizeof(host), NULL, 0, NI_NUMERICHOST);
+	if (err != 0)
+		rte_exit(EXIT_FAILURE, "Listen address lookup failed: %s\n",
+			 gai_strerror(err));
+
+	RPCAPD_LOG(NOTICE, "listening on %s port %u", host, listen_port);
+
+	if (!is_loopback(&listen_addr))
+		RPCAPD_LOG(WARNING,
+			"non-loopback address %s; "
+			"rpcap is unauthenticated and unencrypted, captured traffic is exposed to the network",
+			host);
+
+	if (listen(fd, 1) < 0)
+		rte_exit(EXIT_FAILURE, "listen: %s\n", strerror(errno));
+
+	return fd;
+}
+
+static void
+usage(FILE *f, const char *progname)
+{
+	fprintf(f, "Usage: %s [options]\n", progname);
+	fprintf(f,
+		"  -p, --port <port>     listen port (default %u)\n"
+		"  -b, --bind <addr>     bind address (default 127.0.0.1, ::1 with -6)\n"
+		"  -4                    use only IPv4\n"
+		"  -6                    use only IPv6\n"
+		"  -N <ring size>        ring size in packets (default %u)\n"
+		"  -D, --debug           increase log verbosity (-D info, -DD debug)\n"
+		"      --debug-file <f>  redirect log output to file <f> (append mode)\n"
+		"      --send-timeout <s> seconds a data send may block before the\n"
+		"                        client is treated as dead (default %u, 0 waits\n"
+		"                        forever)\n"
+		"      --version         print version and exit\n"
+		"  -h, --help            print this help and exit\n"
+		"      --lcore=<core>    CPU core to run on (default: any)\n"
+		"      --file-prefix=<p> prefix to use for multi-process\n"
+		"\n"
+		"WARNING: rpcap is unauthenticated and unencrypted.  Binding to\n"
+		"any non-loopback address exposes captured traffic to the\n"
+		"network.  Not for production use.\n",
+		RPCAP_DEFAULT_NETPORT, DEFAULT_RING_SIZE,
+		DATA_SEND_TIMEOUT_SEC);
+}
+
+static void
+print_version(void)
+{
+	printf("rpcapd, a remote packet capture daemon (DPDK pdump backend)\n"
+	       "Built against %s\n", rte_version());
+}
+
+static void
+parse_opts(int argc, char **argv)
+{
+	enum {
+		OPT_LONG_ONLY = 0x100,
+		OPT_DEBUG_FILE,
+		OPT_VERSION,
+		OPT_SEND_TIMEOUT,
+	};
+	static const struct option long_options[] = {
+		{ "port",         required_argument, NULL, 'p' },
+		{ "bind",         required_argument, NULL, 'b' },
+		{ "debug",        no_argument,       NULL, 'D' },
+		{ "help",         no_argument,       NULL, 'h' },
+		{ "version",      no_argument,       NULL, OPT_VERSION },
+		{ "debug-file",   required_argument, NULL, OPT_DEBUG_FILE },
+		{ "send-timeout", required_argument, NULL, OPT_SEND_TIMEOUT },
+		{ "file-prefix",  required_argument, NULL, 0 },
+		{ "lcore",        required_argument, NULL, 0 },
+		{ NULL, 0, NULL, 0 },
+	};
+	int option_index, c;
+
+	while ((c = getopt_long(argc, argv, "hD46p:b:N:",
+				long_options, &option_index)) != -1) {
+		switch (c) {
+		case 'p': {
+			unsigned long u = strtoul(optarg, NULL, 0);
+
+			if (u == 0 || u > UINT16_MAX)
+				rte_exit(EXIT_FAILURE, "Invalid port: %s\n", optarg);
+			listen_port = (uint16_t)u;
+			break;
+		}
+		case 'b':
+			bind_addr = optarg;
+			break;
+		case '4':
+			bind_family = AF_INET;
+			break;
+		case '6':
+			bind_family = AF_INET6;
+			break;
+		case 'N': {
+			unsigned long u = strtoul(optarg, NULL, 0);
+
+			/* Check the full value before narrowing it: an upper
+			 * bound is needed anyway because rte_align32pow2()
+			 * wraps to zero above 2^31, and that failure would
+			 * otherwise only surface in rte_ring_create() on the
+			 * first capture.
+			 */
+			if (u < 64 || u > MAX_RING_SIZE)
+				rte_exit(EXIT_FAILURE,
+					 "Ring size must be between 64 and %u\n",
+					 MAX_RING_SIZE);
+			ring_size = (uint32_t)u;
+			/* rte_ring_create() requires a power of two. */
+			if (!rte_is_power_of_2(ring_size)) {
+				ring_size = rte_align32pow2(ring_size);
+				RPCAPD_LOG(NOTICE, "ring size rounded up to %u",
+					ring_size);
+			}
+			break;
+		}
+		case 'D':
+			debug_log++;
+			break;
+		case 'h':
+			usage(stdout, argv[0]);
+			exit(0);
+		case OPT_VERSION:
+			print_version();
+			exit(0);
+		case OPT_DEBUG_FILE:
+			debug_file = optarg;
+			break;
+		case OPT_SEND_TIMEOUT: {
+			unsigned long u = strtoul(optarg, NULL, 0);
+
+			/* Zero means wait forever, which is what the socket
+			 * does without SO_SNDTIMEO.
+			 */
+			if (u > INT32_MAX)
+				rte_exit(EXIT_FAILURE,
+					 "Invalid send timeout: %s\n", optarg);
+			send_timeout = (uint32_t)u;
+			break;
+		}
+		case 0: {
+			const char *longopt = long_options[option_index].name;
+
+			if (!strcmp(longopt, "lcore")) {
+				lcore_arg = optarg;
+				break;
+			} else if (!strcmp(longopt, "file-prefix")) {
+				file_prefix = optarg;
+				break;
+			}
+		}
+			/* fallthrough */
+		default:
+			usage(stderr, argv[0]);
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	/* Resolve the bind address now that -4/-6/-b have been seen. */
+	parse_bind_addr();
+}
+
+/*
+ * Periodic check that the DPDK primary process is still alive.
+ * If it dies our shared-memory state (rings, mempools, pdump) becomes
+ * unsafe to touch, so we set quit_signal and let the main loop tear
+ * down cleanly on its next iteration.  The callback runs on the EAL
+ * interrupt thread; quit_signal is atomic so the read in the main
+ * loop is well-defined.
+ */
+static void
+monitor_primary(void *arg __rte_unused)
+{
+	if (rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed))
+		return;
+
+	if (rte_eal_primary_proc_alive(NULL)) {
+		rte_eal_alarm_set(PRIMARY_MONITOR_INTERVAL_US, monitor_primary, NULL);
+		return;
+	}
+
+	RPCAPD_LOG(NOTICE, "primary process exited, shutting down");
+	rte_atomic_store_explicit(&quit_signal, true, rte_memory_order_relaxed);
+}
+
+static void
+enable_primary_monitor(void)
+{
+	if (rte_eal_alarm_set(PRIMARY_MONITOR_INTERVAL_US, monitor_primary, NULL) < 0)
+		RPCAPD_LOG(WARNING, "failed to install primary process monitor");
+}
+
+static void
+disable_primary_monitor(void)
+{
+	rte_eal_alarm_cancel(monitor_primary, NULL);
+}
+
+/*
+ * Bring up EAL as a secondary process so that pdump can attach to a
+ * running primary DPDK application. Hide most of the EAL
+ * complexity and only show serious messages from EAL.
+ */
+static int
+dpdk_init(void)
+{
+	static const char * const args[] = {
+		"rpcapd",
+		"--proc-type", "secondary",
+		"--log-level", "lib.eal:warning",
+	};
+	int eal_argc = RTE_DIM(args);
+	rte_cpuset_t cpuset = { };
+	char **eal_argv;
+	unsigned int i;
+
+	if (file_prefix != NULL)
+		eal_argc += 2;
+
+	if (lcore_arg != NULL)
+		eal_argc += 2;
+
+	eal_argv = calloc(eal_argc + 1, sizeof(char *));
+	if (eal_argv == NULL)
+		return -1;
+
+	for (i = 0; i < RTE_DIM(args); i++) {
+		eal_argv[i] = strdup(args[i]);
+		if (eal_argv[i] == NULL)
+			return -1;
+	}
+
+	if (file_prefix != NULL && *file_prefix != '\0') {
+		eal_argv[i++] = strdup("--file-prefix");
+		eal_argv[i++] = strdup(file_prefix);
+		if (eal_argv[i - 1] == NULL || eal_argv[i - 2] == NULL)
+			return -1;
+	}
+
+	if (lcore_arg != NULL) {
+		eal_argv[i++] = strdup("--lcores");
+		eal_argv[i++] = strdup(lcore_arg);
+		if (eal_argv[i - 1] == NULL || eal_argv[i - 2] == NULL)
+			return -1;
+	}
+	eal_argc = i;
+
+	/*
+	 * Need to get the original cpuset, before EAL init changes
+	 * the affinity of this thread (main lcore).
+	 */
+	if (lcore_arg == NULL &&
+	    rte_thread_get_affinity_by_id(rte_thread_self(), &cpuset) != 0)
+		rte_panic("rte_thread_getaffinity failed\n");
+
+	if (rte_eal_init(eal_argc, eal_argv) < 0)
+		rte_exit(EXIT_FAILURE, "EAL init failed: is the primary process running?\n");
+
+	/*
+	 * If no lcore argument was specified,
+	 * then run this program as a normal process
+	 * which can be scheduled on any non-isolated CPU.
+	 */
+	if (lcore_arg == NULL &&
+	    rte_thread_set_affinity_by_id(rte_thread_self(), &cpuset) != 0)
+		RPCAPD_LOG(INFO, "Can not restore original CPU affinity");
+
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "rte_pdump_init failed\n");
+
+	/* Needs the TSC frequency, so must follow rte_eal_init(). */
+	timestamp_init();
+
+	return 0;
+}
+
+int
+main(int argc, char **argv)
+{
+	struct sigaction action = {
+		.sa_handler = signal_handler,
+	};
+	int srv_fd;
+
+	parse_opts(argc, argv);
+
+	/*
+	 * Redirect log output before EAL init so EAL's own messages are
+	 * captured too.  The FILE handle is intentionally never closed:
+	 * the kernel reclaims it at process exit.
+	 */
+	if (debug_file != NULL) {
+		FILE *fp = fopen(debug_file, "a");
+
+		if (fp == NULL)
+			rte_exit(EXIT_FAILURE, "Cannot open debug file '%s': %s\n",
+				 debug_file, strerror(errno));
+		setvbuf(fp, NULL, _IOLBF, 0);
+		rte_openlog_stream(fp);
+	}
+
+	if (dpdk_init() < 0)
+		rte_exit(EXIT_FAILURE, "EAL init failure\n");
+
+	/* Default to NOTICE: only things the operator needs to see.
+	 * Each -D steps down one level, to INFO then DEBUG.
+	 */
+	rte_log_set_level(RTE_LOGTYPE_RPCAPD,
+			  debug_log >= 2 ? RTE_LOG_DEBUG :
+			  debug_log == 1 ? RTE_LOG_INFO : RTE_LOG_NOTICE);
+
+	if (rte_eth_dev_count_avail() == 0)
+		rte_exit(EXIT_FAILURE, "No Ethernet ports found\n");
+
+	sigaction(SIGTERM, &action, NULL);
+	sigaction(SIGINT, &action, NULL);
+
+	/* If peer closes, this detected in next recv() */
+	signal(SIGPIPE, SIG_IGN);
+
+	srv_fd = open_listen_socket(listen_port);
+
+	enable_primary_monitor();
+
+	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
+		int cfd = accept_timeout(srv_fd, -1);
+
+		if (cfd < 0) {
+			if (errno == EINTR)
+				continue;
+			break;
+		}
+		handle_client(cfd);
+	}
+
+	disable_primary_monitor();
+	RPCAPD_LOG(NOTICE, "shutting down");
+	close(srv_fd);
+	rte_pdump_uninit();
+	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
+}
diff --git a/app/rpcapd/meson.build b/app/rpcapd/meson.build
new file mode 100644
index 0000000000..61f4dc0a95
--- /dev/null
+++ b/app/rpcapd/meson.build
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+# relies on primary/secondary process, so Linux only
+if not is_linux
+    build = false
+    reason = 'only supported on Linux'
+    subdir_done()
+endif
+
+if not dpdk_conf.has('RTE_HAS_LIBPCAP')
+    build = false
+    reason = 'missing dependency, "libpcap"'
+    subdir_done()
+endif
+
+sources = files(
+        'capture.c',
+        'filter.c',
+        'main.c',
+        'session.c',
+        'sock.c',
+)
+ext_deps += pcap_dep
+deps += ['ethdev', 'pdump', 'bpf', 'pcapng']
diff --git a/app/rpcapd/rpcap-protocol.h b/app/rpcapd/rpcap-protocol.h
new file mode 100644
index 0000000000..438fd8dd84
--- /dev/null
+++ b/app/rpcapd/rpcap-protocol.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ *
+ * On-the-wire RPCAP protocol definitions, transcribed from libpcap's
+ * rpcap-protocol.h which is an internal file and not exported.
+ * See:
+ *   https://github.com/the-tcpdump-group/libpcap/blob/master/rpcap-protocol.h
+ *
+ * Only the subset needed by dpdk-rpcapd is included here.
+ * All multi-byte fields in the structures below are big-endian on the wire.
+ */
+
+#ifndef _RPCAP_PROTOCOL_H_
+#define _RPCAP_PROTOCOL_H_
+
+#include <stdint.h>
+
+#include <rte_byteorder.h>
+
+#define RPCAP_VERSION              0
+#define RPCAP_DEFAULT_NETPORT      2002
+
+/* Message types */
+#define RPCAP_MSG_ERROR            0x01
+#define RPCAP_MSG_FINDALLIF_REQ    0x02
+#define RPCAP_MSG_OPEN_REQ         0x03
+#define RPCAP_MSG_STARTCAP_REQ     0x04
+#define RPCAP_MSG_UPDATEFILTER_REQ 0x05
+#define RPCAP_MSG_CLOSE            0x06
+#define RPCAP_MSG_PACKET           0x07
+#define RPCAP_MSG_AUTH_REQ         0x08
+#define RPCAP_MSG_STATS_REQ        0x09
+#define RPCAP_MSG_ENDCAP_REQ       0x0a
+#define RPCAP_MSG_IS_REPLY         0x80
+
+#define RPCAP_MSG_FINDALLIF_REPLY    (RPCAP_MSG_FINDALLIF_REQ    | RPCAP_MSG_IS_REPLY)
+#define RPCAP_MSG_OPEN_REPLY         (RPCAP_MSG_OPEN_REQ         | RPCAP_MSG_IS_REPLY)
+#define RPCAP_MSG_STARTCAP_REPLY     (RPCAP_MSG_STARTCAP_REQ     | RPCAP_MSG_IS_REPLY)
+#define RPCAP_MSG_UPDATEFILTER_REPLY (RPCAP_MSG_UPDATEFILTER_REQ | RPCAP_MSG_IS_REPLY)
+#define RPCAP_MSG_AUTH_REPLY         (RPCAP_MSG_AUTH_REQ         | RPCAP_MSG_IS_REPLY)
+#define RPCAP_MSG_ENDCAP_REPLY       (RPCAP_MSG_ENDCAP_REQ       | RPCAP_MSG_IS_REPLY)
+#define RPCAP_MSG_STATS_REPLY	     (RPCAP_MSG_STATS_REQ	 | RPCAP_MSG_IS_REPLY)
+
+/* Error codes carried in the 'value' field of RPCAP_MSG_ERROR */
+#define PCAP_ERR_WRONGVER          17
+#define PCAP_ERR_AUTH_TYPE_NOTSUP  20
+
+/* Authentication types in rpcap_auth.type */
+#define RPCAP_RMTAUTH_NULL         0	/* no credentials supplied */
+#define RPCAP_RMTAUTH_PWD          1	/* username and password follow */
+
+/* Filter encoding: the filter is a BPF/NPF program */
+#define RPCAP_UPDATEFILTER_BPF     1
+
+/* Flags in rpcap_startcapreq.flags */
+#define RPCAP_STARTCAPREQ_FLAG_PROMISC     0x00000001	/* promiscuous mode */
+#define RPCAP_STARTCAPREQ_FLAG_DGRAM       0x00000002	/* use UDP for data */
+#define RPCAP_STARTCAPREQ_FLAG_SERVEROPEN  0x00000004	/* server connects out */
+#define RPCAP_STARTCAPREQ_FLAG_INBOUND     0x00000008	/* capture inbound only */
+#define RPCAP_STARTCAPREQ_FLAG_OUTBOUND    0x00000010	/* capture outbound only */
+
+/* Subset of pcap interface flags (pcap.h) */
+#define PCAP_IF_UP                 0x00000002
+#define PCAP_IF_RUNNING            0x00000004
+
+/* DLT_EN10MB - ethernet, the only link type we report */
+#define DLT_EN10MB                 1
+
+struct rpcap_header {
+	uint8_t     ver;
+	uint8_t     type;
+	rte_be16_t  value;
+	rte_be32_t  plen;
+};
+
+struct rpcap_findalldevs_if {
+	rte_be16_t  namelen;
+	rte_be16_t  desclen;
+	rte_be32_t  flags;
+	rte_be16_t  naddr;
+	uint16_t    dummy;
+};
+
+struct rpcap_openreply {
+	rte_be32_t  linktype;
+	rte_be32_t  tzoff;
+};
+
+struct rpcap_auth {
+	rte_be16_t  type;	/* RPCAP_RMTAUTH_* */
+	uint16_t    dummy;
+	rte_be16_t  slen1;	/* length of username, if any */
+	rte_be16_t  slen2;	/* length of password, if any */
+};
+
+struct rpcap_startcapreq {
+	rte_be32_t  snaplen;
+	rte_be32_t  read_timeout;
+	rte_be16_t  flags;
+	rte_be16_t  portdata;
+};
+
+struct rpcap_startcapreply {
+	rte_be32_t  bufsize;
+	rte_be16_t  portdata;
+	uint16_t    dummy;
+};
+
+/*
+ * A filter, sent either after rpcap_startcapreq or in an
+ * RPCAP_MSG_UPDATEFILTER_REQ, followed by nitems instructions.
+ */
+struct rpcap_filter {
+	rte_be16_t  filtertype;
+	uint16_t    dummy;
+	rte_be32_t  nitems;
+};
+
+/* One cBPF instruction, repeated nitems times after rpcap_filter. */
+struct rpcap_filterbpf_insn {
+	rte_be16_t  code;
+	uint8_t     jt;
+	uint8_t     jf;
+	rte_be32_t  k;
+};
+
+struct rpcap_stats {
+	rte_be32_t  ifrecv;
+	rte_be32_t  ifdrop;
+	rte_be32_t  krnldrop;
+	rte_be32_t  svrcapt;
+};
+
+struct rpcap_pkthdr {
+	rte_be32_t  timestamp_sec;
+	rte_be32_t  timestamp_usec;
+	rte_be32_t  caplen;
+	rte_be32_t  len;
+	rte_be32_t  npkt;
+};
+
+#endif /* _RPCAP_PROTOCOL_H_ */
diff --git a/app/rpcapd/rpcapd.h b/app/rpcapd/rpcapd.h
new file mode 100644
index 0000000000..df38231bfb
--- /dev/null
+++ b/app/rpcapd/rpcapd.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ *
+ * State and helpers shared between the parts of the rpcap daemon.
+ */
+
+#ifndef _RPCAPD_H_
+#define _RPCAPD_H_
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <sys/socket.h>
+#include <sys/uio.h>
+
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_log.h>
+#include <rte_mbuf.h>
+#include <rte_stdatomic.h>
+
+struct rte_bpf_prm;
+struct rte_mempool;
+struct rte_ring;
+
+#define RTE_LOGTYPE_RPCAPD RTE_LOGTYPE_USER1
+#define RPCAPD_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, RPCAPD, "%s(): ", __func__, __VA_ARGS__)
+
+/* Largest snaplen a client can be given. */
+#define DEFAULT_SNAPLEN		RTE_MBUF_DEFAULT_DATAROOM
+
+/*
+ * rte_pcapng_copy() truncates to the snaplen and then re-inserts any
+ * VLAN or QinQ tag the NIC stripped, so a capture can exceed the
+ * snaplen by up to two tags.
+ */
+#define MAX_CAPTURE_LEN		(DEFAULT_SNAPLEN + 2 * sizeof(struct rte_vlan_hdr))
+
+/* A connection to the client. */
+struct conn {
+	int fd;
+};
+
+/* Per-client capture session state. */
+struct session {
+	struct conn data;			/* data connection */
+	struct sockaddr_storage peer;		/* control connection peer */
+	uint16_t port;				/* DPDK ethdev port being captured */
+	char     name[RTE_ETH_NAME_MAX_LEN];
+	uint32_t snaplen;
+	uint32_t npkt;				/* packet sequence for rpcap_pkthdr */
+	uint32_t pdump_flags;			/* direction bits handed to pdump */
+	bool     opened;			/* OPEN_REQ has selected a port */
+	bool     capture_on;
+	bool     promisc_set;			/* we enabled promiscuous mode */
+	struct rte_ring    *ring;
+	struct rte_mempool *mp;
+	struct rte_bpf_prm *prm;		/* capture filter, NULL if none */
+};
+
+/* Set once by the signal handler to unwind the main and capture loops. */
+extern RTE_ATOMIC(bool) quit_signal;
+
+/* Command-line settings needed outside of main.c */
+extern uint32_t ring_size;
+extern uint32_t send_timeout;		/* seconds; 0 means no limit */
+
+/* Address the control socket is bound to; the data socket uses the same
+ * address with an ephemeral port.
+ */
+extern struct sockaddr_storage listen_addr;
+extern socklen_t               listen_addrlen;
+
+/* sock.c: transport and message framing */
+int wait_readable(const struct conn *c, int timeout_ms);
+int accept_timeout(int listen_fd, int timeout_ms);
+int accept_from(int listen_fd, const struct sockaddr_storage *want,
+		int timeout_ms);
+int recv_full(const struct conn *c, void *buf, size_t len);
+int send_iov_full(const struct conn *c, struct iovec *iov, int iovcnt, int flags);
+int rpcap_send_msg(const struct conn *c, uint8_t type, uint16_t value,
+		   const void *payload, uint32_t plen);
+int rpcap_send_error(const struct conn *c, uint16_t errcode, const char *msg);
+int rpcap_discard(const struct conn *c, uint32_t plen);
+void set_sockaddr_port(struct sockaddr_storage *ss, uint16_t port);
+uint16_t get_sockaddr_port(const struct sockaddr_storage *ss);
+
+/* session.c: control requests handled before a capture starts */
+int handle_auth(const struct conn *c, uint32_t plen);
+int handle_findallif(const struct conn *c);
+int handle_open(const struct conn *c, uint32_t plen, struct session *s);
+
+/* filter.c */
+int read_filter(const struct conn *c, uint32_t plen, struct session *s);
+int handle_updatefilter(const struct conn *c, uint32_t plen, struct session *s);
+
+/* capture.c */
+void timestamp_init(void);
+int handle_startcap(const struct conn *c, uint32_t plen, struct session *s);
+int handle_endcap(const struct conn *c, uint32_t plen, struct session *s);
+int handle_stats(const struct conn *c, uint32_t plen, const struct session *s);
+void stop_capture(struct session *s);
+int capture_loop(const struct conn *ctrl, struct session *s);
+
+#endif /* _RPCAPD_H_ */
diff --git a/app/rpcapd/session.c b/app/rpcapd/session.c
new file mode 100644
index 0000000000..cc14f26335
--- /dev/null
+++ b/app/rpcapd/session.c
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ *
+ * Control requests handled before a capture starts: authentication,
+ * the interface list, and selecting an interface.
+ */
+
+#include <stdlib.h>
+#include <string.h>
+
+#include <rte_byteorder.h>
+#include <rte_ethdev.h>
+
+#include "rpcap-protocol.h"
+#include "rpcapd.h"
+
+/* Build and send the list of available DPDK ports. */
+int
+handle_findallif(const struct conn *c)
+{
+	uint8_t *buf = NULL;
+	size_t buflen = 0;
+	uint16_t nif = 0;
+	uint16_t p;
+	int rc;
+
+	RTE_ETH_FOREACH_DEV(p) {
+		static const char desc[] = "DPDK port";
+		char name[RTE_ETH_NAME_MAX_LEN];
+		size_t namelen, desclen, entry;
+		uint8_t *nb;
+
+		if (rte_eth_dev_get_name_by_port(p, name) < 0) {
+			RPCAPD_LOG(DEBUG, "can not find name for port %u", p);
+			continue;
+		}
+
+		RPCAPD_LOG(DEBUG, "findallif: port %u -> '%s'", p, name);
+		namelen = strlen(name);
+		desclen = strlen(desc);
+		entry = sizeof(struct rpcap_findalldevs_if) + namelen + desclen;
+
+		nb = realloc(buf, buflen + entry);
+		if (nb == NULL) {
+			RPCAPD_LOG(ERR, "out of memory in findallif");
+			free(buf);
+			return rpcap_send_error(c, 0, "out of memory");
+		}
+		buf = nb;
+
+		struct rpcap_findalldevs_if iface = {
+			.namelen = rte_cpu_to_be_16(namelen),
+			.desclen = rte_cpu_to_be_16(desclen),
+			.flags = rte_cpu_to_be_32(PCAP_IF_UP | PCAP_IF_RUNNING),
+		};
+		memcpy(buf + buflen, &iface, sizeof(iface));
+		memcpy(buf + buflen + sizeof(iface), name, namelen);
+		memcpy(buf + buflen + sizeof(iface) + namelen, desc, desclen);
+		buflen += entry;
+		nif++;
+	}
+
+	RPCAPD_LOG(DEBUG, "findallif: %u interface(s)", nif);
+	rc = rpcap_send_msg(c, RPCAP_MSG_FINDALLIF_REPLY, nif, buf, buflen);
+	free(buf);
+	return rc;
+}
+
+/*
+ * AUTH_REQ: check the authentication type only.
+ *
+ * There is no credential store, so a username and password cannot be
+ * verified; refuse them rather than reply that they were accepted.
+ */
+int
+handle_auth(const struct conn *c, uint32_t plen)
+{
+	struct rpcap_auth auth;
+	uint16_t type;
+
+	if (plen < sizeof(auth)) {
+		rpcap_discard(c, plen);
+		return rpcap_send_error(c, 0, "short authentication request");
+	}
+
+	if (recv_full(c, &auth, sizeof(auth)) < 0)
+		return -1;
+
+	/* Discard any username and password that followed. */
+	if (rpcap_discard(c, plen - sizeof(auth)) < 0)
+		return -1;
+
+	type = rte_be_to_cpu_16(auth.type);
+	if (type != RPCAP_RMTAUTH_NULL) {
+		RPCAPD_LOG(NOTICE, "rejecting authentication type %u", type);
+		return rpcap_send_error(c, PCAP_ERR_AUTH_TYPE_NOTSUP,
+					"this server cannot check credentials; "
+					"connect without a username or password");
+	}
+
+	return rpcap_send_msg(c, RPCAP_MSG_AUTH_REPLY, 0, NULL, 0);
+}
+
+/* OPEN_REQ: payload is the interface name (no NUL). */
+int
+handle_open(const struct conn *c, uint32_t plen, struct session *s)
+{
+	struct rpcap_openreply reply = {
+		.linktype = rte_cpu_to_be_32(DLT_EN10MB),
+	};
+	uint16_t port;
+
+	stop_capture(s);
+
+	if (plen >= sizeof(s->name)) {
+		rpcap_discard(c, plen);
+		return rpcap_send_error(c, 0, "interface name too long");
+	}
+	if (recv_full(c, s->name, plen) < 0)
+		return -1;
+	s->name[plen] = '\0';
+
+	if (rte_eth_dev_get_port_by_name(s->name, &port) < 0) {
+		RPCAPD_LOG(WARNING, "open: no such port '%s'", s->name);
+		/* s->name has already been overwritten; make sure a later
+		 * STARTCAP cannot capture the previously opened port.
+		 */
+		s->opened = false;
+		return rpcap_send_error(c, 0, "unknown interface");
+	}
+	s->port = port;
+	s->opened = true;
+
+	RPCAPD_LOG(DEBUG, "open: '%s' -> dpdk port %u", s->name, port);
+	return rpcap_send_msg(c, RPCAP_MSG_OPEN_REPLY, 0, &reply, sizeof(reply));
+}
diff --git a/app/rpcapd/sock.c b/app/rpcapd/sock.c
new file mode 100644
index 0000000000..179c1a31c1
--- /dev/null
+++ b/app/rpcapd/sock.c
@@ -0,0 +1,315 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ *
+ * Socket helpers and rpcap message framing, used by both the control
+ * connection and the data connection.
+ */
+
+#include <errno.h>
+#include <netdb.h>
+#include <netinet/in.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/uio.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <rte_byteorder.h>
+#include <rte_common.h>
+#include <rte_stdatomic.h>
+
+#include "rpcap-protocol.h"
+#include "rpcapd.h"
+
+#define POLL_INTERVAL_MS              500
+
+/* Monotonic milliseconds, for timing out across repeated waits. */
+static int64_t
+get_monotonic_ms(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return (int64_t)ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
+}
+
+void
+set_sockaddr_port(struct sockaddr_storage *ss, uint16_t port)
+{
+	if (ss->ss_family == AF_INET6)
+		((struct sockaddr_in6 *)ss)->sin6_port = htons(port);
+	else
+		((struct sockaddr_in *)ss)->sin_port = htons(port);
+}
+
+uint16_t
+get_sockaddr_port(const struct sockaddr_storage *ss)
+{
+	if (ss->ss_family == AF_INET6)
+		return ntohs(((const struct sockaddr_in6 *)ss)->sin6_port);
+	return ntohs(((const struct sockaddr_in *)ss)->sin_port);
+}
+
+
+/* Wait for a connection to become readable with timeout */
+int
+wait_readable(const struct conn *c, int timeout_ms)
+{
+	struct pollfd pfd = { .fd = c->fd, .events = POLLIN };
+
+	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
+		int wait_ms = POLL_INTERVAL_MS;
+		int rc;
+
+		if (timeout_ms >= 0) {
+			if (timeout_ms == 0)
+				return 0;
+			if (timeout_ms < wait_ms)
+				wait_ms = timeout_ms;
+			timeout_ms -= wait_ms;
+		}
+
+		rc = poll(&pfd, 1, wait_ms);
+		if (rc < 0) {
+			if (errno == EINTR)
+				continue;
+			RPCAPD_LOG(ERR, "poll failed: %s", strerror(errno));
+			return -1;
+		}
+		if (rc > 0)
+			return 1;
+	}
+	return -1;
+}
+
+/* accept() with a timeout, so a stalled client cannot wedge the daemon. */
+int
+accept_timeout(int listen_fd, int timeout_ms)
+{
+	struct conn listener = { .fd = listen_fd };
+	int fd;
+
+	switch (wait_readable(&listener, timeout_ms)) {
+	case 1:
+		break;
+	case 0:
+		RPCAPD_LOG(ERR, "timed out waiting for data connection");
+		return -1;
+	default:
+		return -1;
+	}
+
+	fd = accept(listen_fd, NULL, NULL);
+	if (fd < 0)
+		RPCAPD_LOG(ERR, "accept: %s", strerror(errno));
+	return fd;
+}
+
+/* Compare the host part of two addresses, ignoring the port: the data
+ * connection comes from an ephemeral port, not the control one.
+ */
+static bool
+same_host(const struct sockaddr_storage *a, const struct sockaddr_storage *b)
+{
+	if (a->ss_family != b->ss_family)
+		return false;
+
+	if (a->ss_family == AF_INET) {
+		const struct sockaddr_in *sa = (const void *)a;
+		const struct sockaddr_in *sb = (const void *)b;
+
+		return sa->sin_addr.s_addr == sb->sin_addr.s_addr;
+	}
+	if (a->ss_family == AF_INET6) {
+		const struct sockaddr_in6 *sa = (const void *)a;
+		const struct sockaddr_in6 *sb = (const void *)b;
+
+		return IN6_ARE_ADDR_EQUAL(&sa->sin6_addr, &sb->sin6_addr);
+	}
+	return false;
+}
+
+/*
+ * Accept a data connection only from the control connection's peer;
+ * the port is handed to the client in the clear, so any local user
+ * could otherwise race for the stream.  A mismatch is rejected and the
+ * wait continues.
+ */
+int
+accept_from(int listen_fd, const struct sockaddr_storage *want, int timeout_ms)
+{
+	struct conn listener = { .fd = listen_fd };
+	int remaining = timeout_ms;
+
+	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
+		struct sockaddr_storage peer;
+		socklen_t peerlen = sizeof(peer);
+		char host[NI_MAXHOST] = "?";
+		int64_t start, waited;
+		int fd;
+
+		start = get_monotonic_ms();
+		switch (wait_readable(&listener, remaining)) {
+		case 1:
+			break;
+		case 0:
+			RPCAPD_LOG(ERR, "timed out waiting for data connection");
+			return -1;
+		default:
+			return -1;
+		}
+
+		fd = accept(listen_fd, (struct sockaddr *)&peer, &peerlen);
+		if (fd < 0) {
+			if (errno == EINTR || errno == ECONNABORTED)
+				goto next;
+			RPCAPD_LOG(ERR, "accept: %s", strerror(errno));
+			return -1;
+		}
+
+		if (same_host(&peer, want))
+			return fd;
+
+		getnameinfo((struct sockaddr *)&peer, peerlen,
+			    host, sizeof(host), NULL, 0, NI_NUMERICHOST);
+		RPCAPD_LOG(WARNING,
+			   "rejected data connection from %s: does not match control peer",
+			   host);
+		close(fd);
+next:
+		if (remaining >= 0) {
+			waited = get_monotonic_ms() - start;
+			remaining -= (waited > 0) ? (int)waited : 0;
+			if (remaining <= 0) {
+				RPCAPD_LOG(ERR,
+					   "timed out waiting for data connection");
+				return -1;
+			}
+		}
+	}
+	return -1;
+}
+
+/* Read exactly len bytes; return 0 on success, -1 on error or EOF. */
+int
+recv_full(const struct conn *c, void *buf, size_t len)
+{
+	uint8_t *p = buf;
+
+	while (len > 0) {
+		ssize_t n;
+
+		/* Timed wait, so a quit signal or a dead primary is acted
+		 * on promptly.
+		 */
+		if (wait_readable(c, -1) != 1)
+			return -1;
+
+		n = recv(c->fd, p, len, 0);
+		if (n < 0 && errno == EINTR)
+			continue;
+
+		if (n <= 0)
+			return -1;
+
+		p += n;
+		len -= n;
+	}
+	return 0;
+}
+
+/*
+ * Send all of iov, resending the remainder if sendmsg() reports a short
+ * count (possible when the connection breaks or a signal arrives after
+ * some bytes were copied).  Consumes iov, so pass a scratch copy.
+ */
+int
+send_iov_full(const struct conn *c, struct iovec *iov, int iovcnt, int flags)
+{
+	struct msghdr msg = {
+		.msg_iov    = iov,
+		.msg_iovlen = iovcnt,
+	};
+
+	while (msg.msg_iovlen > 0) {
+		ssize_t n = sendmsg(c->fd, &msg, flags | MSG_NOSIGNAL);
+
+		if (n < 0) {
+			/*
+			 * Send blocks rather than polling first; the data
+			 * socket has a send timeout so a client that stops
+			 * reading fails with EAGAIN.
+			 */
+			if (errno == EINTR &&
+			    !rte_atomic_load_explicit(&quit_signal,
+						      rte_memory_order_relaxed))
+				continue;
+			return -1;
+		}
+		if (n == 0)
+			return -1;
+
+		/* Drop whole iovecs that were fully sent, then trim the
+		 * partially sent one.
+		 */
+		while (msg.msg_iovlen > 0 && (size_t)n >= msg.msg_iov->iov_len) {
+			n -= msg.msg_iov->iov_len;
+			msg.msg_iov++;
+			msg.msg_iovlen--;
+		}
+		if (n > 0) {
+			msg.msg_iov->iov_base = (char *)msg.msg_iov->iov_base + n;
+			msg.msg_iov->iov_len -= n;
+		}
+	}
+	return 0;
+}
+
+int
+rpcap_send_msg(const struct conn *c, uint8_t type, uint16_t value,
+	       const void *payload, uint32_t plen)
+{
+	struct rpcap_header hdr = {
+		.ver = RPCAP_VERSION,
+		.type = type,
+		.value = rte_cpu_to_be_16(value),
+		.plen = rte_cpu_to_be_32(plen),
+	};
+	struct iovec iov[2] = {
+		{
+			.iov_base = &hdr,
+			.iov_len = sizeof(hdr),
+		},
+		{
+			.iov_base = (void *)(uintptr_t)payload,
+			.iov_len = plen,
+		},
+	};
+
+	return send_iov_full(c, iov, plen > 0 ? 2 : 1, 0);
+}
+
+int
+rpcap_send_error(const struct conn *c, uint16_t errcode, const char *msg)
+{
+	RPCAPD_LOG(WARNING, "sending error to client: %s", msg);
+	return rpcap_send_msg(c, RPCAP_MSG_ERROR, errcode, msg, strlen(msg));
+}
+
+/* Throw away plen bytes of payload we don't care about. */
+int
+rpcap_discard(const struct conn *c, uint32_t plen)
+{
+	uint8_t buf[256];
+
+	while (plen > 0) {
+		size_t chunk = plen > sizeof(buf) ? sizeof(buf) : plen;
+
+		if (recv_full(c, buf, chunk) < 0)
+			return -1;
+		plen -= chunk;
+	}
+	return 0;
+}
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 5b5a9f006e..8e107b48b6 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -143,6 +143,11 @@ New Features
   Added ``rte_bbdev_queue_stats_get()`` function to retrieve statistics
   for a specific queue, complementing the existing device-level statistics API.
 
+* **Added libpcap remote capture daemon.**
+
+  Added the ``dpdk-rpcapd`` application, which implements the rpcap
+  protocol to allow live capture in tcpdump and Wireshark.
+
 
 Removed Items
 -------------
diff --git a/doc/guides/tools/index.rst b/doc/guides/tools/index.rst
index 13f75a5bc6..a23333f763 100644
--- a/doc/guides/tools/index.rst
+++ b/doc/guides/tools/index.rst
@@ -13,6 +13,7 @@ DPDK Tools User Guides
     proc_info
     pmdinfo
     dumpcap
+    rpcapd
     pdump
     telemetrywatcher
     dmaperf
diff --git a/doc/guides/tools/rpcapd.rst b/doc/guides/tools/rpcapd.rst
new file mode 100644
index 0000000000..a8b026a409
--- /dev/null
+++ b/doc/guides/tools/rpcapd.rst
@@ -0,0 +1,199 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Stephen Hemminger
+
+.. _rpcapd_tool:
+
+dpdk-rpcapd Application
+=======================
+
+The ``dpdk-rpcapd`` application is a Data Plane Development Kit
+(DPDK) implementation of the remote packet capture daemon protocol
+(``rpcap``) used by libpcap.  It runs as a DPDK secondary process and
+allows libpcap-aware tools such as ``tcpdump`` and Wireshark to capture
+packets from a DPDK primary process live, without writing to an
+intermediate file.
+
+The ``dpdk-rpcapd`` tool implements a subset of the protocol spoken by
+the libpcap project's ``rpcapd``.
+See
+https://github.com/the-tcpdump-group/libpcap/tree/master/rpcapd
+for the reference implementation.
+Clients connect to ``dpdk-rpcapd`` using a ``rpcap://`` URL,
+request the list of available interfaces(which are the ports of the DPDK primary),
+open one, and stream packets from it.
+
+.. warning::
+
+   ``dpdk-rpcapd`` listens on an unauthenticated, unencrypted TCP port
+   (default 2002).  Anyone able to reach the port can list DPDK ports
+   and capture all traffic flowing through them.  The default bind
+   address is ``127.0.0.1``, so the listener is not reachable from
+   other hosts; overriding this with ``--bind`` exposes captured
+   traffic to anyone who can reach that address.  **Do not run
+   ``dpdk-rpcapd`` on a production system.**
+
+
+Running the Application
+-----------------------
+
+The application has a small set of command-line options:
+
+*   ``-p <port>``, ``--port <port>``
+
+    TCP port to listen on.  Default is 2002, the IANA-assigned rpcap
+    port.
+
+*   ``-b <addr>``, ``--bind <addr>``
+
+    Numeric IPv4 or IPv6 address to bind the listener to.  Default is
+    ``127.0.0.1``, or ``::1`` when ``-6`` is given (loopback only).
+    See the warning above before using any other address.
+
+*   ``-4``
+
+    Use only IPv4; an IPv6 argument to ``-b`` is rejected.
+
+*   ``-6``
+
+    Use only IPv6; an IPv4 argument to ``-b`` is rejected.  The default
+    bind address becomes ``::1``.
+
+*   ``-N <ring_size>``
+
+    Size of the per-session capture ring in packets.  Default is 2048.
+    Rounded up to a power of two if necessary.
+
+*   ``-D``, ``--debug``
+
+    Increase log verbosity.  A single ``-D`` adds informational
+    messages; ``-DD`` adds per-request protocol detail.
+
+*   ``--debug-file <file>``
+
+    Append log output to ``<file>`` instead of writing it to standard
+    error.
+
+*   ``--send-timeout <seconds>``
+
+    How long a send on the data connection may block before the client
+    is treated as dead and the capture stopped.  Default is 10 seconds;
+    zero waits forever.
+
+*   ``--lcore <core>``
+
+    CPU core to run on.  By default the daemon runs as an ordinary
+    process on any non-isolated CPU.
+
+*   ``--file-prefix <prefix>``
+
+    EAL file prefix of the primary process to attach to.  Needed when
+    the primary was started with a non-default prefix.
+
+*   ``--version``
+
+    Print the version and exit.
+
+*   ``-h``, ``--help``
+
+    Print usage and exit.
+
+EAL options are supplied automatically; the application runs as a
+secondary process and does not need EAL options on its command line for
+typical use.
+
+
+Client Setup
+------------
+
+Most Linux distributions ship libpcap built without ``rpcap`` support,
+since ``--enable-remote`` is off by default.  To use ``dpdk-rpcapd``
+from ``tcpdump`` or Wireshark on Linux, rebuild libpcap with it:
+
+.. code-block:: console
+
+    wget https://www.tcpdump.org/release/libpcap-1.10.7.tar.xz
+    tar xf libpcap-1.10.7.tar.xz
+    cd libpcap-1.10.7
+    ./configure --enable-remote
+    make
+    sudo make install
+
+Only the client side of ``rpcap`` is used for ``dpdk-rpcapd``.
+Do not run libpcap's version of ``rpcapd``.
+
+``tcpdump`` rebuilt against this libpcap can be used as a client without
+further changes.  Wireshark on Windows and macOS ships with rpcap support
+enabled by default.
+
+
+Example
+-------
+
+Start a primary application with the packet capture framework
+initialized.  ``dpdk-testpmd`` is the simplest:
+
+.. code-block:: console
+
+    sudo ./<build_dir>/app/dpdk-testpmd --vdev=net_tap0 -- -i
+
+In another window, start ``dpdk-rpcapd``:
+
+.. code-block:: console
+
+    sudo ./<build_dir>/app/dpdk-rpcapd
+    RPCAPD: open_listen_socket(): listening on 127.0.0.1 port 2002
+
+In a third window, list available interfaces using a libpcap-based
+``tcpdump`` rebuilt with remote support:
+
+.. code-block:: console
+
+    sudo /usr/local/sbin/tcpdump --list-remote-interfaces=rpcap://localhost:2002/
+    rpcap://localhost:2002/net_tap0  Network adapter 'DPDK port' on remote node localhost
+
+Capture live from a port:
+
+.. code-block:: console
+
+    sudo /usr/local/sbin/tcpdump -i rpcap://localhost:2002/net_tap0 -nn -c 20
+
+Or save to a file readable by any pcap consumer:
+
+.. code-block:: console
+
+    sudo /usr/local/sbin/tcpdump -i rpcap://localhost:2002/net_tap0 -w /tmp/capture.pcap
+
+
+Limitations
+-----------
+
+The following features of the reference ``rpcapd`` are not implemented
+in this initial version:
+
+*   **Single client.** Only one client may be connected at a time.
+    Subsequent clients are queued by the listening socket but not
+    serviced until the first disconnects.
+
+*   **No authentication.** Password authentication is refused with
+    ``PCAP_ERR_AUTH_TYPE_NOTSUP``; clients must connect without
+    credentials, which is what a ``rpcap://`` URL with no userinfo does.
+    With the default loopback bind, reaching the port already requires
+    an account on the host.
+
+*   **No TLS.** The ``-S`` option of the reference ``rpcapd`` is not
+    implemented, so the connection is always in the clear.  This is
+    reasonable for the default loopback bind, where the traffic never
+    leaves the host, but means ``--bind`` to any other address sends
+    captured packets over the network unencrypted.
+
+*   **TCP data transport only.** A client requesting UDP is refused.
+
+
+See Also
+--------
+
+*   :doc:`dumpcap` -- file-based capture writing pcapng
+    output.
+
+*   The libpcap project's ``rpcapd`` reference implementation:
+    https://github.com/the-tcpdump-group/libpcap/tree/master/rpcapd
-- 
2.53.0

