Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27F3CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 03:41:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02EAD402DA;
	Tue, 13 Oct 2026 05:41:53 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id CFB5540272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 05:41:50 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc4e9e56e9aso740616a12.2
 for <dev@dpdk.org>; Mon, 12 Oct 2026 20:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791862910;
 x=1792467710; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vGjWL6DAjGMEpWXBSZdUkXyoblQR6KuZqXbwQ8Q8vVI=;
 b=ogSDWNbMSqH0dLajYqGoZUXiQckl8IXb2xq5+4RKlROJWRLKGWqhEdED2eB0R9qM63
 fO2bYlawXoTCbXlVw0okjszvBmgRoAmQ/GObh68pMFt/Yj5atnk8q9KKMyW+2afZw2wW
 g2FZyGqhMIpEiAa/NJxKsdItmfUAA5zmJBFLTxZDgTcC9TDbpJhR0TwqSj7gv6C15mPY
 dWnwN11apuqPpzPSlPAJiMewoUf6ujuLl9Z1RjbGVMLHiq6W8Xuw0w2DMnMavaUqWfvO
 fZ1KtoA7qfFmF+s9B65fyMdxK/4A27ervA4jn7qckceCL3PEffIu/6/lNiEaa10EvTMy
 jQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862910; x=1792467710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vGjWL6DAjGMEpWXBSZdUkXyoblQR6KuZqXbwQ8Q8vVI=;
 b=CGQVfKiSIrklwt1V0exHSw+337Gxn2SmT8fmfNk7iVNcwyDdlccch4DbKJCCq5ysI+
 nv1P58z1ZRmbEXbLTYR/BFgtWidfuYSh52NW7SR3fBdc1HGxis1pA6dPPbMBgZN8l8Vp
 fpnasTJRr9sQDMPVHLVfHEHHg7hQ0tMxCF7vbKEn9GJzpK+VPdp9/55oDUfPffHKMKO2
 qg6SrkTqrxHJQGaIlM8FIohUyMHfv/kjFjyJr+sPsvzVyKIwbRbABD4Z83jFBD7iYz/r
 XjU6MCeVJTE7ZKYtPwiNKg4D34bU7IjW/Kfh+P/qT2l9hP8NDZ8HFj7mRb/Jg5TYHfqi
 r2MA==
X-Gm-Message-State: AFq9FYIMSVX5+O2al48Kz2iUXVY9i4+NLjUB6CK3l1o/qCHjVAGLFmRe
 0sr7bA5+zTvenmFk4nGufYEmaaeMBztBdt9g0HZzenT9Q4BbWkUK//CL2wvOMabP+tsklueFxY8
 NB8YOJcI=
X-Gm-Gg: AYBFou2Kbjyv3BQoWAEDmoP9xAERoyfYDe22SjiHTEEjOe6FPIlUOH3cSQsuooCknjN
 f/QdIfc/BlJTHUxKCNHEfSMQTdrMIKoNMt55zpixl0LuaVOYf4JdId8kGz9A1crtwtWyL1m7t8R
 fVXaWIKH41K1odZDRZjDhtmcNT8OOnjrrIV9ozLtP3D6nD7lr8UOLSib3YNA7zx5IR24OPUfmET
 IlQlqfIfQxxrJtLwjdMknjrPoXB8JAdThMGiXW341hj9SXjjQICOV9R8ymbnUrNtkMegjz0qgdk
 50RUtp35WGi6f0Hz/8Ao5MMOzNp2ZcDzku0X7mGgWpe/WYTZcrm6m2lRxP5nYV7u0eVxjRKo+N7
 RKE16JzCTXbD7BBnhLoPr2GUMtU3y1OsWVJ9j18hbJHY1JyiTu3mp7sMLCYJc1dt046N7GyfByX
 G6KWX9h/5lEf7k3MKTwok9VQC99A+d34+Fd33AarGpmrJs8ULViiiJOa3HenRmvcEJT6qkrcqnG
 SjmdW30e74ANI2lTXProoqdiZlccI7JwDkqlQ==
X-Received: by 2002:a17:90b:2d86:b0:3ab:3437:554f with SMTP id
 98e67ed59e1d1-3ab3a746d73mr9481949a91.29.1791862909676; 
 Mon, 12 Oct 2026 20:41:49 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab38ff0d34sm19928740a91.14.2026.10.12.20.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 20:41:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 2/3] test: add test for capture hooks
Date: Mon, 12 Oct 2026 20:41:04 -0700
Message-ID: <20261013034145.979361-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013034145.979361-1-stephen@networkplumber.org>
References: <20260727224417.1419663-1-stephen@networkplumber.org>
 <20261013034145.979361-1-stephen@networkplumber.org>
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

Provide tests to exercise telemetry based packet capture.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS             |   1 +
 app/test/meson.build    |   1 +
 app/test/test_capture.c | 688 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 690 insertions(+)
 create mode 100644 app/test/test_capture.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 96adaebc1d..2192de83e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1718,6 +1718,7 @@ Packet capture
 M: Reshma Pattan <reshma.pattan@intel.com>
 M: Stephen Hemminger <stephen@networkplumber.org>
 F: lib/capture/
+F: app/test/test_capture.c
 F: lib/pdump/
 F: doc/guides/prog_guide/pdump_lib.rst
 F: app/test/test_pdump.*
diff --git a/app/test/meson.build b/app/test/meson.build
index 881b919b63..872d1ecfbe 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -41,6 +41,7 @@ source_file_deps = {
     'test_bpf.c': ['bpf', 'net'],
     'test_bpf_validate.c': ['bpf'],
     'test_byteorder.c': [],
+    'test_capture.c': ['net_null', 'net', 'ethdev', 'bus_vdev', 'capture'],
     'test_cfgfile.c': ['cfgfile'],
     'test_cksum.c': ['net'],
     'test_cksum_perf.c': ['net'],
diff --git a/app/test/test_capture.c b/app/test/test_capture.c
new file mode 100644
index 0000000000..7c8bd49653
--- /dev/null
+++ b/app/test/test_capture.c
@@ -0,0 +1,688 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+/*
+ * Functional test for the capture library.
+ *
+ * The capture library has no public C API: it is driven entirely through the
+ * telemetry socket. The output is a path ('out=') that the primary opens
+ * itself and writes pcapng into; the caller never receives packet data over
+ * the control socket. This test therefore behaves like an external capture
+ * tool.
+ *
+ * The suite setup builds the fixture shared by every case:
+ *
+ *   - a virtual ethdev backed by net_null. Rx synthesizes packets and Tx is a
+ *     sink that frees whatever it is handed, which is all this test needs and
+ *     avoids the per-queue ring bookkeeping of net_ring. The port is given
+ *     NB_QUEUES queues so per-queue selection can be exercised;
+ *   - a FIFO for capture output;
+ *   - a connection to this process's own telemetry socket.
+ *
+ * Each case then runs with the FIFO read end open (the primary's non-blocking
+ * O_WRONLY open needs a reader present) and hands it back in the common
+ * teardown, which is also what tears down a capture left running by a failed
+ * assertion.
+ *
+ * The cases are:
+ *
+ *   lifecycle
+ *     start an all-queue capture, check a pcapng stream appears, the capture
+ *     is listed, stats account for traffic injected on every queue in both
+ *     directions, and it tears down when the reader disconnects;
+ *   bad_queue
+ *     an out-of-range queue index is rejected, not started;
+ *   queue_select
+ *     a queue=CAPTURE_QUEUE capture installs callbacks on that queue only, so
+ *     traffic on any other queue is not captured while traffic on that one is,
+ *     in both directions. The selected queue is neither the first nor the last
+ *     of NB_QUEUES, so an off-by-one in either install loop is caught. Both
+ *     directions are steerable here: the test names the queue in
+ *     rte_eth_rx_burst()/rte_eth_tx_burst() and net_null sources or sinks on
+ *     whichever queue it is handed.
+ *   dual
+ *     two captures of the same queues coexist, each with its own output and
+ *     its own counters. This case makes a second FIFO, with its own reader,
+ *     since the library only writes to a FIFO.
+ *
+ * The suite is skipped (not failed) if telemetry is not enabled or the
+ * net_null driver is not available.
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/select.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/un.h>
+
+#include <rte_bus_vdev.h>
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_eal.h>
+#include <rte_ethdev.h>
+#include <rte_lcore.h>
+#include <rte_log.h>
+#include <rte_mbuf.h>
+
+#include "test.h"
+
+#define TELEMETRY_VERSION	"v2"
+#define CAPTURE_START		"/ethdev/capture/start"
+#define CAPTURE_LIST		"/ethdev/capture/list"
+#define CAPTURE_STATS		"/ethdev/capture/stats"
+#define CAPTURE_STOP		"/ethdev/capture/stop"
+
+#define NULL_VDEV_NAME		"net_null_capture"
+#define NB_QUEUES		4
+#define CAPTURE_QUEUE		2	/* not first or last of NB_QUEUES */
+#define RING_SIZE		256
+#define NB_MBUFS		1024
+#define MBUF_CACHE		32
+#define NB_PKTS			32
+#define PKT_LEN			64
+#define REPLY_LEN		16384
+
+/* pcapng Section Header Block type, byte-order independent on disk. */
+static const uint8_t pcapng_shb_magic[4] = { 0x0a, 0x0d, 0x0d, 0x0a };
+
+static struct rte_mempool *test_mp;
+static uint16_t test_port = RTE_MAX_ETHPORTS;
+static char fifo_path[PATH_MAX];
+static int tel_sock = -1;
+static int fifo_rd = -1;
+
+/* --- telemetry client helpers ------------------------------------------ */
+
+/* Connect to this process's telemetry socket; -1 if unavailable. */
+static int
+tel_connect(void)
+{
+	struct sockaddr_un addr = { .sun_family = AF_UNIX };
+	char buf[REPLY_LEN];
+	int s;
+
+	snprintf(addr.sun_path, sizeof(addr.sun_path), "%s/dpdk_telemetry.%s",
+		 rte_eal_get_runtime_dir(), TELEMETRY_VERSION);
+
+	s = socket(AF_UNIX, SOCK_SEQPACKET, 0);
+	if (s < 0)
+		return -1;
+
+	if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		close(s);
+		return -1;
+	}
+
+	/* Server greets with an info message; consume it. */
+	if (recv(s, buf, sizeof(buf), 0) <= 0) {
+		close(s);
+		return -1;
+	}
+	return s;
+}
+
+/* Send a command and read the reply. */
+static int
+tel_cmd(const char *cmd, char *reply, size_t reply_sz)
+{
+	ssize_t n;
+
+	if (send(tel_sock, cmd, strlen(cmd), 0) < 0)
+		return -1;
+	n = recv(tel_sock, reply, reply_sz - 1, 0);
+	if (n < 0)
+		return -1;
+	reply[n] = '\0';
+	return 0;
+}
+
+/* Minimal JSON scanning: find "key" and read the unsigned number after it. */
+static int
+json_uint(const char *s, const char *key, uint64_t *out)
+{
+	const char *p = strstr(s, key);
+
+	if (p == NULL)
+		return -1;
+	for (p += strlen(key); *p != '\0' && !isdigit((unsigned char)*p); p++)
+		;
+	if (*p == '\0')
+		return -1;
+	*out = strtoull(p, NULL, 10);
+	return 0;
+}
+
+/* Read the first element of the array in a list reply; -1 if empty/absent. */
+static int
+json_first_array_uint(const char *s, uint64_t *out)
+{
+	const char *p = strchr(s, '[');
+
+	if (p == NULL)
+		return -1;
+	for (p++; *p == ' '; p++)
+		;
+	if (*p == ']' || !isdigit((unsigned char)*p))
+		return -1;
+	*out = strtoull(p, NULL, 10);
+	return 0;
+}
+
+/* Query the accepted counter for a capture id via telemetry. */
+static int
+capture_accepted(uint64_t id, uint64_t *accepted)
+{
+	char cmd[64], reply[REPLY_LEN];
+
+	snprintf(cmd, sizeof(cmd), "%s,%" PRIu64, CAPTURE_STATS, id);
+	if (tel_cmd(cmd, reply, sizeof(reply)) < 0)
+		return -1;
+	return json_uint(reply, "\"accepted\"", accepted);
+}
+
+/*
+ * Poll the capture list until it is empty (the capture has torn down).
+ * Returns 0 once empty, -1 on timeout (~2s) or telemetry failure.
+ */
+static int
+wait_list_empty(void)
+{
+	char reply[REPLY_LEN];
+	uint64_t id;
+
+	for (int i = 0; i < 200; i++) {
+		if (tel_cmd(CAPTURE_LIST, reply, sizeof(reply)) < 0)
+			return -1;
+		if (json_first_array_uint(reply, &id) < 0)
+			return 0;
+		rte_delay_ms(10);
+	}
+	return -1;
+}
+
+/* --- packet injection --------------------------------------------------- */
+
+/*
+ * Pull count packets from a queue. net_null synthesizes them and pulling runs
+ * the capture Rx callback on each; the mbufs are ours to free.
+ */
+static int
+inject_rx(uint16_t queue, unsigned int count)
+{
+	struct rte_mbuf *bufs[NB_PKTS];
+	uint16_t got;
+
+	if (count > NB_PKTS)
+		count = NB_PKTS;
+
+	got = rte_eth_rx_burst(test_port, queue, bufs, count);
+	rte_pktmbuf_free_bulk(bufs, got);
+	return got == count ? 0 : -1;	/* net_null fills the whole request */
+}
+
+/*
+ * Transmit count packets on a queue. The capture Tx callback runs first (it
+ * only copies) and net_null then frees the originals, so only mbufs it did not
+ * take are reclaimed here.
+ */
+static int
+inject_tx(uint16_t queue, unsigned int count)
+{
+	struct rte_mbuf *bufs[NB_PKTS];
+	uint16_t sent;
+
+	if (count > NB_PKTS)
+		count = NB_PKTS;
+
+	for (unsigned int i = 0; i < count; i++) {
+		struct rte_mbuf *m = rte_pktmbuf_alloc(test_mp);
+
+		if (m == NULL) {
+			rte_pktmbuf_free_bulk(bufs, i);
+			return -1;
+		}
+		m->pkt_len = m->data_len = PKT_LEN;
+		memset(rte_pktmbuf_mtod(m, void *), 0, PKT_LEN);
+		bufs[i] = m;
+	}
+
+	/* net_null accepts the whole burst; free the tail if it ever does not. */
+	sent = rte_eth_tx_burst(test_port, queue, bufs, count);
+	if (sent < count) {
+		rte_pktmbuf_free_bulk(&bufs[sent], count - sent);
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * Inject on every queue except skip; pass NB_QUEUES to cover them all.
+ */
+static int
+inject_rx_except(uint16_t skip, unsigned int count)
+{
+	for (uint16_t q = 0; q < NB_QUEUES; q++) {
+		if (q != skip && inject_rx(q, count) < 0)
+			return -1;
+	}
+	return 0;
+}
+
+static int
+inject_tx_except(uint16_t skip, unsigned int count)
+{
+	for (uint16_t q = 0; q < NB_QUEUES; q++) {
+		if (q != skip && inject_tx(q, count) < 0)
+			return -1;
+	}
+	return 0;
+}
+
+/* --- fixture ------------------------------------------------------------ */
+
+static int
+build_port(void)
+{
+	struct rte_eth_conf conf = { 0 };
+
+	test_mp = rte_pktmbuf_pool_create("capture_test_mp", NB_MBUFS, MBUF_CACHE,
+					  0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+	if (test_mp == NULL)
+		return -1;
+
+	if (rte_vdev_init(NULL_VDEV_NAME, NULL) < 0)
+		return -1;
+	if (rte_eth_dev_get_port_by_name(NULL_VDEV_NAME, &test_port) != 0)
+		return -1;
+
+	if (rte_eth_dev_configure(test_port, NB_QUEUES, NB_QUEUES, &conf) < 0)
+		return -1;
+	for (uint16_t q = 0; q < NB_QUEUES; q++) {
+		if (rte_eth_rx_queue_setup(test_port, q, RING_SIZE, rte_socket_id(),
+					   NULL, test_mp) < 0)
+			return -1;
+		if (rte_eth_tx_queue_setup(test_port, q, RING_SIZE, rte_socket_id(),
+					   NULL) < 0)
+			return -1;
+	}
+
+	return rte_eth_dev_start(test_port);
+}
+
+static void
+teardown_port(void)
+{
+	if (test_port != RTE_MAX_ETHPORTS) {
+		rte_eth_dev_stop(test_port);
+		/*
+		 * Uninit drives the driver's remove, which closes and releases
+		 * the ethdev port and removes the vdev in one path. No separate
+		 * rte_eth_dev_close() is needed and null's close is idempotent,
+		 * so this is safe even if a tree's close already released it.
+		 */
+		rte_vdev_uninit(NULL_VDEV_NAME);
+		test_port = RTE_MAX_ETHPORTS;
+	}
+	rte_mempool_free(test_mp);
+	test_mp = NULL;
+}
+
+/*
+ * Create a capture FIFO in the runtime dir; -1 on failure.
+ *
+ * The capture library only writes to a FIFO, so every output in this test is
+ * one. 'tag' keeps the names of concurrent captures apart.
+ */
+static int
+make_fifo(char *path, size_t pathlen, const char *tag)
+{
+	snprintf(path, pathlen, "%s/capture_test%s.%d",
+		 rte_eal_get_runtime_dir(), tag, (int)getpid());
+	unlink(path);				/* clear any stale node */
+	if (mkfifo(path, 0600) < 0)
+		return -1;
+	return 0;
+}
+
+/*
+ * Release everything the suite setup built. Idempotent, because the runner
+ * does not call the suite teardown when the suite setup fails, so the setup
+ * has to unwind itself by calling this directly.
+ */
+static void
+testsuite_teardown(void)
+{
+	if (fifo_rd >= 0) {
+		close(fifo_rd);
+		fifo_rd = -1;
+	}
+	if (fifo_path[0] != '\0') {
+		unlink(fifo_path);
+		fifo_path[0] = '\0';
+	}
+	if (tel_sock >= 0) {
+		close(tel_sock);
+		tel_sock = -1;
+	}
+	teardown_port();
+}
+
+static int
+testsuite_setup(void)
+{
+	int ret = TEST_SKIPPED;
+
+	fifo_path[0] = '\0';
+
+	/*
+	 * The library writes to the FIFO; a closed reader must give the writer
+	 * EPIPE, not a fatal SIGPIPE. The library masks SIGPIPE on its drain
+	 * thread, but ignore it here too so the test process is safe regardless.
+	 */
+	signal(SIGPIPE, SIG_IGN);
+
+	tel_sock = tel_connect();
+	if (tel_sock < 0) {
+		printf("telemetry socket not available, skipping\n");
+		goto error;
+	}
+
+	if (build_port() < 0) {
+		printf("could not build net_null test port, skipping\n");
+		goto error;
+	}
+
+	if (make_fifo(fifo_path, sizeof(fifo_path), "") < 0) {
+		printf("could not create fifo %s: %s\n", fifo_path, strerror(errno));
+		ret = TEST_FAILED;
+		goto error;
+	}
+
+	return TEST_SUCCESS;
+
+error:
+	testsuite_teardown();
+	return ret;
+}
+
+/*
+ * Open the read end before each case: the library opens the FIFO
+ * O_WRONLY|O_NONBLOCK and would get ENXIO with no reader present.
+ * O_RDONLY|O_NONBLOCK returns immediately even with no writer yet.
+ */
+static int
+ut_setup(void)
+{
+	fifo_rd = open(fifo_path, O_RDONLY | O_NONBLOCK);
+	if (fifo_rd < 0) {
+		printf("open %s: %s\n", fifo_path, strerror(errno));
+		return TEST_FAILED;
+	}
+	return TEST_SUCCESS;
+}
+
+/*
+ * Common cleanup. Closing the read end is the hangup that makes any capture
+ * still running -- including one that a failed assertion returned out from
+ * under -- tear itself down, so no case can leak a capture into the next.
+ */
+static void
+ut_teardown(void)
+{
+	if (fifo_rd >= 0) {
+		close(fifo_rd);
+		fifo_rd = -1;
+	}
+	if (wait_list_empty() < 0)
+		printf("warning: capture still active after test case\n");
+}
+
+/* --- test cases --------------------------------------------------------- */
+
+static int
+test_capture_lifecycle(void)
+{
+	char cmd[PATH_MAX + 64], reply[REPLY_LEN], pcapng[REPLY_LEN];
+	uint64_t id, accepted;
+	struct timeval tv;
+	fd_set rfds;
+	ssize_t n;
+
+	snprintf(cmd, sizeof(cmd), "%s,%u,out=%s", CAPTURE_START, test_port, fifo_path);
+	TEST_ASSERT_SUCCESS(tel_cmd(cmd, reply, sizeof(reply)),
+			    "capture start command failed");
+	TEST_ASSERT(strstr(reply, "error") == NULL,
+		    "capture start returned an error: %s", reply);
+
+	/*
+	 * Inject traffic on every queue: with no queue= the callbacks must be
+	 * installed on all of them. Rx callbacks run synchronously inside
+	 * rx_burst, so the accepted counter is up to date as soon as this
+	 * returns.
+	 */
+	TEST_ASSERT_SUCCESS(inject_rx_except(NB_QUEUES, NB_PKTS),
+			    "rx injection failed");
+
+	/* A pcapng stream (at least the section header) must appear. */
+	FD_ZERO(&rfds);
+	FD_SET(fifo_rd, &rfds);
+	tv = (struct timeval){ .tv_sec = 2 };
+	TEST_ASSERT(select(fifo_rd + 1, &rfds, NULL, NULL, &tv) > 0,
+		    "no pcapng output within timeout");
+	n = read(fifo_rd, pcapng, sizeof(pcapng));
+	TEST_ASSERT(n >= 4, "short pcapng read (%zd)", n);
+	TEST_ASSERT(memcmp(pcapng, pcapng_shb_magic, sizeof(pcapng_shb_magic)) == 0,
+		    "output does not start with a pcapng section header block");
+
+	/* The capture must show up in the list. */
+	TEST_ASSERT_SUCCESS(tel_cmd(CAPTURE_LIST, reply, sizeof(reply)),
+			    "capture list command failed");
+	TEST_ASSERT_SUCCESS(json_first_array_uint(reply, &id),
+			    "no capture id in list reply: %s", reply);
+
+	/* Stats must report exactly the packets we injected, on every queue. */
+	TEST_ASSERT_SUCCESS(capture_accepted(id, &accepted),
+			    "capture stats query failed");
+	TEST_ASSERT_EQUAL(accepted, (uint64_t)(NB_QUEUES * NB_PKTS),
+			  "accepted %" PRIu64 " != %d", accepted, NB_QUEUES * NB_PKTS);
+
+	/* Same for the Tx side of every queue. */
+	TEST_ASSERT_SUCCESS(inject_tx_except(NB_QUEUES, NB_PKTS),
+			    "tx injection failed");
+	TEST_ASSERT_SUCCESS(capture_accepted(id, &accepted),
+			    "capture stats query failed");
+	TEST_ASSERT_EQUAL(accepted, (uint64_t)(2 * NB_QUEUES * NB_PKTS),
+			  "accepted %" PRIu64 " != %d", accepted, 2 * NB_QUEUES * NB_PKTS);
+
+	/*
+	 * Close the reader: the capture should detect the hangup and tear down.
+	 * The drain thread's idle poll notices POLLERR on the write end on its
+	 * own; the extra injection just shortens the wait if it was mid-drain.
+	 * Done here rather than left to the teardown because the hangup is what
+	 * this case is asserting.
+	 */
+	close(fifo_rd);
+	fifo_rd = -1;
+	inject_rx(0, NB_PKTS);	/* any queue; all are captured here */
+	TEST_ASSERT_SUCCESS(wait_list_empty(),
+			    "capture did not tear down after reader closed");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * An out-of-range queue index must be rejected. The range check runs before
+ * the output is opened, so no capture should be left behind even though a
+ * reader is attached.
+ */
+static int
+test_capture_bad_queue(void)
+{
+	char cmd[PATH_MAX + 64], reply[REPLY_LEN];
+
+	snprintf(cmd, sizeof(cmd), "%s,%u,out=%s,queue=%u",
+		 CAPTURE_START, test_port, fifo_path, NB_QUEUES);
+	TEST_ASSERT_SUCCESS(tel_cmd(cmd, reply, sizeof(reply)),
+			    "capture start command failed");
+	TEST_ASSERT(strstr(reply, "error") != NULL,
+		    "out-of-range queue=%u was not rejected: %s", NB_QUEUES, reply);
+	TEST_ASSERT_SUCCESS(wait_list_empty(),
+			    "rejected start left a capture behind");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * With queue=CAPTURE_QUEUE the callbacks are installed on that queue only:
+ * traffic on any other queue must not be captured, traffic on that one must
+ * be, in both directions. The counters are bumped synchronously inside
+ * rx_burst/tx_burst, so every check here is race-free.
+ */
+static int
+test_capture_queue_select(void)
+{
+	char cmd[PATH_MAX + 64], reply[REPLY_LEN];
+	uint64_t id, accepted;
+
+	snprintf(cmd, sizeof(cmd), "%s,%u,out=%s,queue=%u",
+		 CAPTURE_START, test_port, fifo_path, CAPTURE_QUEUE);
+	TEST_ASSERT_SUCCESS(tel_cmd(cmd, reply, sizeof(reply)),
+			    "queue=%u capture start failed", CAPTURE_QUEUE);
+	TEST_ASSERT(strstr(reply, "error") == NULL,
+		    "queue=%u capture start returned an error: %s",
+		    CAPTURE_QUEUE, reply);
+	TEST_ASSERT_SUCCESS(json_uint(reply, "\"id\"", &id),
+			    "no id in start reply: %s", reply);
+
+	/* Unselected queues: callbacks never installed, nothing captured. */
+	TEST_ASSERT_SUCCESS(inject_rx_except(CAPTURE_QUEUE, NB_PKTS),
+			    "rx inject on unselected queues failed");
+	TEST_ASSERT_SUCCESS(inject_tx_except(CAPTURE_QUEUE, NB_PKTS),
+			    "tx inject on unselected queues failed");
+	TEST_ASSERT_SUCCESS(capture_accepted(id, &accepted),
+			    "capture stats query failed");
+	TEST_ASSERT_EQUAL(accepted, (uint64_t)0,
+			  "other queues captured under queue=%u (accepted %" PRIu64 ")",
+			  CAPTURE_QUEUE, accepted);
+
+	/* Selected queue: captured, on Rx and on Tx. */
+	TEST_ASSERT_SUCCESS(inject_rx(CAPTURE_QUEUE, NB_PKTS),
+			    "rx inject on queue %u failed", CAPTURE_QUEUE);
+	TEST_ASSERT_SUCCESS(capture_accepted(id, &accepted),
+			    "capture stats query failed");
+	TEST_ASSERT_EQUAL(accepted, (uint64_t)NB_PKTS,
+			  "rx queue %u not captured (accepted %" PRIu64 ")",
+			  CAPTURE_QUEUE, accepted);
+
+	TEST_ASSERT_SUCCESS(inject_tx(CAPTURE_QUEUE, NB_PKTS),
+			    "tx inject on queue %u failed", CAPTURE_QUEUE);
+	TEST_ASSERT_SUCCESS(capture_accepted(id, &accepted),
+			    "capture stats query failed");
+	TEST_ASSERT_EQUAL(accepted, (uint64_t)(2 * NB_PKTS),
+			  "tx queue %u not captured (accepted %" PRIu64 ")",
+			  CAPTURE_QUEUE, accepted);
+
+	/* The teardown closes the reader, which stops this capture. */
+	return TEST_SUCCESS;
+}
+
+/* Body of test_capture_dual(), which owns the second fifo. */
+static int
+dual_capture(const char *path2)
+{
+	char cmd[PATH_MAX + 64], reply[REPLY_LEN];
+	uint64_t id1, id2, a1, a2;
+
+	snprintf(cmd, sizeof(cmd), "%s,%u,out=%s", CAPTURE_START, test_port, fifo_path);
+	TEST_ASSERT_SUCCESS(tel_cmd(cmd, reply, sizeof(reply)), "first start failed");
+	TEST_ASSERT_SUCCESS(json_uint(reply, "\"id\"", &id1), "no id in reply: %s", reply);
+
+	snprintf(cmd, sizeof(cmd), "%s,%u,out=%s", CAPTURE_START, test_port, path2);
+	TEST_ASSERT_SUCCESS(tel_cmd(cmd, reply, sizeof(reply)), "second start failed");
+	TEST_ASSERT(strstr(reply, "error") == NULL,
+		    "second capture of the same queues was rejected: %s", reply);
+	TEST_ASSERT_SUCCESS(json_uint(reply, "\"id\"", &id2), "no id in reply: %s", reply);
+	TEST_ASSERT_NOT_EQUAL(id1, id2, "both captures got id %" PRIu64, id1);
+
+	/* one burst on a queue both cover must be counted twice */
+	TEST_ASSERT_SUCCESS(inject_rx(0, NB_PKTS), "rx injection failed");
+	TEST_ASSERT_SUCCESS(capture_accepted(id1, &a1), "stats query failed");
+	TEST_ASSERT_SUCCESS(capture_accepted(id2, &a2), "stats query failed");
+	TEST_ASSERT_EQUAL(a1, (uint64_t)NB_PKTS,
+			  "first capture accepted %" PRIu64 " != %d", a1, NB_PKTS);
+	TEST_ASSERT_EQUAL(a2, (uint64_t)NB_PKTS,
+			  "second capture accepted %" PRIu64 " != %d", a2, NB_PKTS);
+
+	/* the fifo one is stopped by the teardown closing the reader */
+	snprintf(cmd, sizeof(cmd), "%s,%" PRIu64, CAPTURE_STOP, id2);
+	TEST_ASSERT_SUCCESS(tel_cmd(cmd, reply, sizeof(reply)), "stop command failed");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Two captures may cover the same queue, each with its own filter and its own
+ * callback. Both must start, both must be listed separately, and traffic on a
+ * shared queue must be counted by both.
+ */
+static int
+test_capture_dual(void)
+{
+	char path2[PATH_MAX];
+	int rd2, ret;
+
+	/* the second capture needs an output of its own, with its own reader */
+	if (make_fifo(path2, sizeof(path2), "2") < 0) {
+		printf("could not create %s: %s\n", path2, strerror(errno));
+		return TEST_FAILED;
+	}
+
+	rd2 = open(path2, O_RDONLY | O_NONBLOCK);
+	if (rd2 < 0) {
+		printf("open %s: %s\n", path2, strerror(errno));
+		unlink(path2);
+		return TEST_FAILED;
+	}
+
+	ret = dual_capture(path2);
+
+	/* closing the reader stops the second capture if an assertion bailed out */
+	close(rd2);
+	unlink(path2);
+
+	return ret;
+}
+
+static struct unit_test_suite capture_testsuite = {
+	.suite_name = "capture autotest",
+	.setup = testsuite_setup,
+	.teardown = testsuite_teardown,
+	.unit_test_cases = {
+		TEST_CASE_ST(ut_setup, ut_teardown, test_capture_lifecycle),
+		TEST_CASE_ST(ut_setup, ut_teardown, test_capture_bad_queue),
+		TEST_CASE_ST(ut_setup, ut_teardown, test_capture_queue_select),
+		TEST_CASE_ST(ut_setup, ut_teardown, test_capture_dual),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_capture(void)
+{
+	return unit_test_suite_runner(&capture_testsuite);
+}
+
+REGISTER_FAST_TEST(capture_autotest, NOHUGE_OK, ASAN_OK, test_capture);
-- 
2.53.0

