Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A068C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 21:08:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2024402D8;
	Tue,  8 Sep 2026 23:08:43 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 46044402D8
 for <dev@dpdk.org>; Tue,  8 Sep 2026 23:08:42 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so4158115a12.1
 for <dev@dpdk.org>; Tue, 08 Sep 2026 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788901721;
 x=1789506521; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u1YHrz5QQwAT+MxQbCDiYG3pVERrOts8WG7CzIyQXts=;
 b=jVFLoBi3IroXU0eXZePC9Y3zz95B1mDSc4XeBp0mJvc6goNNQvQ0MnOFErpPkWHdV2
 Tb2IyObZvnSTjhzhy6H6n6Cuk85Tcsa6cQQgvloJeyVi5xAhn6WuK5SR6gPygShKoUK4
 ZXP3uPsweR/9IycVFMeO/kYzTl8HdBWiwMWxdc4BrKKuLo45/gt5i+rd5CDKYInXL0xd
 c4u35f2kri3pevrHOX2ojK90pcdAohwQAPydhcbJXbKuv8iBsUzlKod48iFnT9UeNRp2
 4HSxPRI7suYn6boXMzw9Yx8x4/V/u+gfy/wP5SBYAE827py+UVHmo/lRNWGD6kmmFW77
 +1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788901721; x=1789506521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u1YHrz5QQwAT+MxQbCDiYG3pVERrOts8WG7CzIyQXts=;
 b=YrJ7KOqryB6iNaBp1yHFPUhx38BSclNWeKD2lcvULEG5LqvOAMuMCXq+fN8OGau8D1
 6cfP0OYApG8RyC2hMOCYrNJIVFr9jyRRkYIdMBHAfROxCDqBQg5ctu5S8yMeKT5iXHiy
 a7JymbSebvuZ1Pqmb9oqn9N6YEVPTyLSYq3KliFJgom3pby9yKTNpacvFR27Q4OOXAH9
 Abf4b4my46H7Fv8sCXLQok18D6F5IaSUk6T7utm+1kSCFkt3uxWcT/B5QPdoE85xKrvG
 ejxfbNDFwXtliArwZpeK57SkFRdigbPOLi4ToCGsE6W9VOmt1CWEyRkSvvBSjs4x98SX
 oczw==
X-Gm-Message-State: AFuF++kH3+gBhuTqlOxrRuemlFvLTpaM8B+9qsSKD9lHBgj+g/DfaFCW
 Xy55V8uZrW5YMv0xUMLG4YpOMTvtvShSjXCsmntfIq7i3zkVASoNXlVB6GJBENGAv+AHtAhnfrE
 ojR9O
X-Gm-Gg: AYBFou3K8EORxV/9DSgL1Zn2j5qGqPdlidcOiyOiceL8NHdvotNDThDITwtbI/m+UE6
 vLrmSDuTZqmnXQdr7BMBzkZzvZAV/blt8KRQTVZ1k6c1lVAMgHWu6GOe7jJN7puy+p+zWD/2pir
 ESqQ6yjwAswqd9o20kf//pq0QbbOd0wScHZbwIeeJ+m9b5r0xWyK/nGEaXzk9ldS/tEScChOv4/
 3+fkh7WiwzNihFlS4MGsTH1wa3ScnqsOtikXZMoDj7uVsFhQENuZL0HJ7M1s0ntRo0RD7hiQZUL
 Hqc5EsjgadSw5eTdEr6gqeDehrAWEsMxlPa3qIwKKnNdNb8IC0pcxsLvsdAkrbLgtkX2cRg6IRR
 iS9u33YBDwFUU9SxLggttqvlliDKK5HogDnHcQrjjD6xIVSybjLcWaIZhIvcbtpM2yOzfCrsiqy
 ft6qy9DX5EMzLhuRVKtS6yi3YO4n/6Ye8O1JxTR9dxZnkRShdSJFqIN2VX3iBCZRlDng+Sa6MH9
 gqwOhzPm+V7/fcz1toA5I66WxY=
X-Received: by 2002:a17:90b:2e0c:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-39b26169b1fmr46756998a91.11.1788901720591; 
 Tue, 08 Sep 2026 14:08:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b2615039asm28417456a91.15.2026.09.08.14.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 14:08:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH] examples/rpcapd: demo version of packet capture daemon
Date: Tue,  8 Sep 2026 14:07:17 -0700
Message-ID: <20260908210832.1556291-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

This example adds RPCAP support over localhost TCP
integrated with DPDK. It uses a secondary process that allows
connections from using tcpdump defacto protocol rpcap.

See: doc/guides/sample_app_ug/rpcap.rst for more info.
This does not preclude using pdump, dumpcap, or the wireshark
extcap integration.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---

 doc/guides/rel_notes/release_26_11.rst |    4 +
 doc/guides/sample_app_ug/index.rst     |    1 +
 doc/guides/sample_app_ug/rpcapd.rst    |  206 +++++
 examples/meson.build                   |    1 +
 examples/rpcapd/main.c                 | 1014 ++++++++++++++++++++++++
 examples/rpcapd/meson.build            |   11 +
 examples/rpcapd/rpcap-protocol.h       |   96 +++
 7 files changed, 1333 insertions(+)
 create mode 100644 doc/guides/sample_app_ug/rpcapd.rst
 create mode 100644 examples/rpcapd/main.c
 create mode 100644 examples/rpcapd/meson.build
 create mode 100644 examples/rpcapd/rpcap-protocol.h

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..9dabd80c56 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added an example of tcpdump remote pcap daemon.**
+
+  Added an example that implements rpcap to allow live capture in tcpdump.
+
 
 Removed Items
 -------------
diff --git a/doc/guides/sample_app_ug/index.rst b/doc/guides/sample_app_ug/index.rst
index f12623bb66..61ed870318 100644
--- a/doc/guides/sample_app_ug/index.rst
+++ b/doc/guides/sample_app_ug/index.rst
@@ -31,6 +31,7 @@ Sample Applications User Guides
     l3_forward_graph
     l3_forward_power_man
     link_status_intr
+    rpcapd
     server_node_efd
     service_cores
     multi_process
diff --git a/doc/guides/sample_app_ug/rpcapd.rst b/doc/guides/sample_app_ug/rpcapd.rst
new file mode 100644
index 0000000000..e899a4d991
--- /dev/null
+++ b/doc/guides/sample_app_ug/rpcapd.rst
@@ -0,0 +1,206 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026
+
+.. _rpcapd_app:
+
+dpdk-rpcapd Sample Application
+==============================
+
+The ``dpdk-rpcapd`` sample application is a Data Plane Development Kit
+(DPDK) implementation of the remote packet capture daemon protocol
+(``rpcap``) used by libpcap.  It runs as a DPDK secondary process and
+allows libpcap-aware tools such as ``tcpdump`` and Wireshark to capture
+packets from a DPDK primary process live, without writing to an
+intermediate file.
+
+The ``dpdk-rpcapd`` tool implements a subset of the protocol spoken by
+the libpcap project's ``rpcapd``.  See
+https://github.com/the-tcpdump-group/libpcap/tree/master/rpcapd for the
+reference implementation.  Clients connect to ``dpdk-rpcapd`` using a
+``rpcap://`` URL, request the list of available interfaces (which are
+the ports of the DPDK primary), open one, and stream packets from it.
+
+The intended workflow is one-step capture: start the primary, start
+``dpdk-rpcapd``, and point a familiar tool at it.  No intermediate files,
+no separate post-processing step.
+
+.. warning::
+
+   ``dpdk-rpcapd`` listens on an unauthenticated, unencrypted TCP port
+   (default 2002, bound to ``127.0.0.1``).  Any local user able to
+   reach the port can list DPDK ports and capture all traffic flowing
+   through them.  This is a sample application intended for
+   development, debugging, and demonstration use only.  **Do not run
+   ``dpdk-rpcapd`` on a production system.**
+
+   The default bind address is ``127.0.0.1`` so the listener is not
+   reachable from other hosts.  An operator may override this with
+   ``--bind <addr>`` but should expect that the resulting deployment
+   exposes captured traffic to anyone who can reach that address; do
+   not do this on an untrusted network.
+
+
+.. note::
+
+   * The ``dpdk-rpcapd`` tool can only be used in conjunction with a
+     primary application that has the packet capture framework
+     initialized already.  In DPDK, only ``dpdk-testpmd`` is modified to
+     initialize the packet capture framework; other applications must
+     be modified to call ``rte_pdump_init()`` if they are to be
+     capturable.
+
+   * ``dpdk-rpcapd`` does not replace ``dpdk-dumpcap``.  ``dpdk-dumpcap``
+     produces pcapng files; ``dpdk-rpcapd`` produces a live rpcap
+     stream.  The two tools serve different workflows and may be used
+     in parallel.
+
+   * For Wireshark users specifically, the Wireshark ``extcap`` plugin
+     interface is the preferred live-capture path; see :doc:`extcap`.
+     ``extcap`` integrates directly with Wireshark and is simpler to
+     deploy.  ``dpdk-rpcapd`` is intended for users who want to use
+     ``tcpdump`` or other rpcap-aware libpcap clients, where ``extcap``
+     does not apply.
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
+    IPv4 address to bind the listener to.  Default is ``127.0.0.1``
+    (loopback only).  Setting any other address exposes captured
+    traffic to the network and should not be done on untrusted
+    networks.
+
+*   ``-N <ring_size>``
+
+    Size of the per-session capture ring in packets.  Default is 2048.
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
+Most Linux distributions ship libpcap built without ``rpcap`` support
+because the libpcap project leaves ``--enable-remote`` off by default.
+To use ``dpdk-rpcapd`` from ``tcpdump`` or Wireshark on Linux, libpcap
+must be rebuilt with remote support enabled.  Approximate steps:
+
+.. code-block:: console
+
+    wget https://www.tcpdump.org/release/libpcap-1.10.6.tar.xz
+    tar xf libpcap-1.10.6.tar.xz
+    cd libpcap-1.10.6
+    ./configure --enable-remote
+    make
+    sudo make install
+    sudo ldconfig
+
+To verify that the resulting library has rpcap support:
+
+.. code-block:: console
+
+    nm -D /usr/local/lib/libpcap.so | grep ' T pcap_open$'
+
+The symbol ``pcap_open`` should be present.  If not, the ``--enable-remote``
+flag did not take effect.
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
+    sudo ./<build_dir>/app/dpdk-testpmd -- --no-mlockall --vdev=net_tap0
+
+In another window, start ``dpdk-rpcapd``:
+
+.. code-block:: console
+
+    sudo ./<build_dir>/app/dpdk-rpcapd
+    RPCAPD: listening on TCP port 2002
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
+The following limitations apply to this initial version of
+``dpdk-rpcapd`` and are expected to be addressed in subsequent patches:
+
+*   **Single client.** Only one client may be connected at a time.
+    Subsequent clients are queued by the listening socket but not
+    serviced until the first disconnects.  Multi-client support
+    requires an event-driven main loop (planned).
+
+*   **No BPF filter support.** ``UPDATEFILTER`` requests are
+    acknowledged and ignored.  Capture-side filtering requires an
+    extension to ``rte_pdump`` to support filter updates on an active
+    callback.
+
+*   **No authentication.** ``AUTH`` requests are acknowledged with an
+    empty reply (libpcap "version 0, null auth" semantics).  This
+    sample application does not implement password authentication.
+
+*   **TCP transport only; not for production use.** The rpcap protocol
+    over TCP is unauthenticated and unencrypted; any client that can
+    reach the listening port has full access to captured traffic.
+    Binding to ``127.0.0.1`` by default mitigates remote exposure but
+    does not address local users on a shared host.  See the warning at
+    the top of this document.
+
+*   **Microsecond timestamp resolution.** The rpcap protocol carries
+    timestamps at microsecond resolution.
+
+
+See Also
+--------
+
+*   :doc:`extcap` -- Wireshark ``extcap`` plugin for direct integration
+    with Wireshark, without going through the rpcap protocol.
+
+*   :doc:`../tools/dumpcap` -- file-based capture writing pcapng
+    output.
+
+*   The libpcap project's ``rpcapd`` reference implementation:
+    https://github.com/the-tcpdump-group/libpcap/tree/master/rpcapd
diff --git a/examples/meson.build b/examples/meson.build
index 25d9c88457..24b6184353 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -45,6 +45,7 @@ all_examples = [
         'ptpclient',
         'qos_meter',
         'qos_sched',
+        'rpcapd',
         'rxtx_callbacks',
         'server_node_efd/efd_node',
         'server_node_efd/efd_server',
diff --git a/examples/rpcapd/main.c b/examples/rpcapd/main.c
new file mode 100644
index 0000000000..e16f5aa3e0
--- /dev/null
+++ b/examples/rpcapd/main.c
@@ -0,0 +1,1014 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026
+ *
+ * Proof-of-concept DPDK rpcapd: the libpcap remote packet capture
+ * daemon, implemented on top of DPDK pdump.  A libpcap client (e.g.
+ * Wireshark or tcpdump using "rpcap://host[:port]/portname") can
+ * connect, list DPDK ports, open one, and stream live packets from it.
+ *
+ * Based on the DPDK dumpcap application and on rpcapd from libpcap:
+ *   https://github.com/the-tcpdump-group/libpcap/tree/master/rpcapd
+ *
+ * Only the bits of the RPCAP protocol that are needed for an
+ * unauthenticated, passive-mode capture session are implemented.
+ * Configuration files, BPF filters, active mode, statistics, sampling,
+ * IPv6 and concurrent clients are intentionally omitted to keep the
+ * example small.
+ */
+
+#include <arpa/inet.h>
+#include <errno.h>
+#include <getopt.h>
+#include <netinet/in.h>
+#include <netdb.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+#include <rte_alarm.h>
+#include <rte_common.h>
+#include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_errno.h>
+#include <rte_ether.h>
+#include <rte_ethdev.h>
+#include <rte_lcore.h>
+#include <rte_log.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
+#include <rte_pdump.h>
+#include <rte_stdatomic.h>
+#include <rte_ring.h>
+#include <rte_version.h>
+
+#include "rpcap-protocol.h"
+
+#define BURST_SIZE                    32
+#define MBUF_CACHE_SIZE               32
+#define DEFAULT_RING_SIZE             2048
+#define DEFAULT_SNAPLEN               RTE_MBUF_DEFAULT_BUF_SIZE
+#define PRIMARY_MONITOR_INTERVAL_US   (500 * 1000)
+
+/* Logging.  Use --log-level=rpcapd:debug to enable debug output. */
+RTE_LOG_REGISTER(rpcapd_logtype, rpcapd, INFO);
+#define RTE_LOGTYPE_RPCAPD rpcapd_logtype
+
+/* Per-client capture session state. */
+struct session {
+	int      ctrl_fd;
+	int      data_fd;
+	uint16_t port;				/* DPDK ethdev port being captured */
+	char     name[RTE_ETH_NAME_MAX_LEN];
+	uint32_t snaplen;
+	uint32_t npkt;				/* packet sequence for rpcap_pkthdr */
+	bool     capture_on;
+	struct rte_ring    *ring;
+	struct rte_mempool *mp;
+};
+
+/* Command-line options */
+static uint16_t listen_port = RPCAP_DEFAULT_NETPORT;
+static uint32_t ring_size = DEFAULT_RING_SIZE;
+static const char *lcore_arg;
+static const char *file_prefix;
+static const char *bind_arg;		/* -b argument, resolved after option parsing */
+static const char *debug_file;		/* --debug-file argument */
+static bool ipv4_only;			/* -4: restrict to IPv4 */
+static bool debug_log;			/* -D: enable RPCAPD debug logging */
+
+/* Bind address for the listener and the per-session data port.
+ * Defaults to IPv4 loopback because the rpcap protocol is insecure.
+ * It exposes captured traffic to anyone who can reach the port.
+ * An operator who knowingly accepts that risk can override with
+ * --bind <addr>.  IPv4 and IPv6 numeric addresses are both accepted.
+ */
+static struct sockaddr_storage listen_addr;
+static socklen_t               listen_addrlen;
+
+static void stop_capture(struct session *s);
+
+static void
+set_sockaddr_port(struct sockaddr_storage *ss, uint16_t port)
+{
+	if (ss->ss_family == AF_INET6)
+		((struct sockaddr_in6 *)ss)->sin6_port = htons(port);
+	else
+		((struct sockaddr_in *)ss)->sin_port = htons(port);
+}
+
+static uint16_t
+get_sockaddr_port(const struct sockaddr_storage *ss)
+{
+	if (ss->ss_family == AF_INET6)
+		return ntohs(((const struct sockaddr_in6 *)ss)->sin6_port);
+	return ntohs(((const struct sockaddr_in *)ss)->sin_port);
+}
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
+		return IN6_IS_ADDR_LOOPBACK(&sin6->sin6_addr);
+	}
+	return false;
+}
+
+static void
+parse_bind_addr(const char *str, int family)
+{
+	struct addrinfo hints = {
+		.ai_family   = family,
+		.ai_socktype = SOCK_STREAM,
+		.ai_flags    = AI_NUMERICHOST | AI_PASSIVE,
+	};
+	struct addrinfo *res;
+	int rc;
+
+	rc = getaddrinfo(str, NULL, &hints, &res);
+	if (rc != 0)
+		rte_exit(EXIT_FAILURE, "Invalid bind address '%s': %s\n",
+			 str, gai_strerror(rc));
+	memcpy(&listen_addr, res->ai_addr, res->ai_addrlen);
+	listen_addrlen = res->ai_addrlen;
+	freeaddrinfo(res);
+}
+
+static RTE_ATOMIC(bool) quit_signal;
+
+static void
+signal_handler(int sig __rte_unused)
+{
+	rte_atomic_store_explicit(&quit_signal, true, rte_memory_order_relaxed);
+}
+
+/* Read exactly len bytes; return 0 on success, -1 on error or EOF. */
+static int
+recv_full(int fd, void *buf, size_t len)
+{
+	uint8_t *p = buf;
+
+	while (len > 0) {
+		ssize_t n = recv(fd, p, len, 0);
+		if (rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed))
+			return -1;
+
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
+static int
+send_iov_full(int fd, struct iovec *iov, int iovcnt, int flags)
+{
+	struct msghdr msg = {
+		.msg_iov    = iov,
+		.msg_iovlen = iovcnt,
+	};
+
+	while (sendmsg(fd, &msg, flags | MSG_NOSIGNAL) < 0) {
+		if (errno != EINTR)
+			return -1;
+	}
+	return 0;
+}
+
+static int
+rpcap_send_msg(int fd, uint8_t type, uint16_t value, const void *payload, uint32_t plen)
+{
+	struct rpcap_header hdr = {
+		.ver = RPCAP_VERSION,
+		.type = type,
+		.value = htons(value),
+		.plen = htonl(plen),
+	};
+	struct iovec iov[2] = {
+		{ .iov_base = &hdr,                        .iov_len = sizeof(hdr) },
+		{ .iov_base = (void *)(uintptr_t)payload,  .iov_len = plen },
+	};
+
+	return send_iov_full(fd, iov, plen > 0 ? 2 : 1, 0);
+}
+
+static int
+rpcap_send_error(int fd, uint16_t errcode, const char *msg)
+{
+	RTE_LOG(WARNING, RPCAPD, "sending error to client: %s\n", msg);
+	return rpcap_send_msg(fd, RPCAP_MSG_ERROR, errcode, msg, strlen(msg));
+}
+
+static int
+rpcap_recv_header(int fd, struct rpcap_header *hdr)
+{
+	if (recv_full(fd, hdr, sizeof(*hdr)) < 0)
+		return -1;
+	hdr->value = ntohs(hdr->value);
+	hdr->plen = ntohl(hdr->plen);
+	return 0;
+}
+
+/* Throw away plen bytes of payload we don't care about. */
+static int
+rpcap_discard(int fd, uint32_t plen)
+{
+	uint8_t buf[256];
+
+	while (plen > 0) {
+		size_t chunk = plen > sizeof(buf) ? sizeof(buf) : plen;
+
+		if (recv_full(fd, buf, chunk) < 0)
+			return -1;
+		plen -= chunk;
+	}
+	return 0;
+}
+
+/* Build and send the list of available DPDK ports. */
+static int
+handle_findallif(int fd)
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
+			RTE_LOG(INFO, RPCAPD, "can not find name for port %u\n", p);
+			continue;
+		}
+
+		RTE_LOG(INFO, RPCAPD, "findallif: port %u -> '%s'\n", p, name);
+		namelen = strlen(name);
+		desclen = strlen(desc);
+		entry = sizeof(struct rpcap_findalldevs_if) + namelen + desclen;
+
+		nb = realloc(buf, buflen + entry);
+		if (nb == NULL) {
+			RTE_LOG(ERR, RPCAPD, "out of memory in findallif\n");
+			free(buf);
+			return rpcap_send_error(fd, 0, "out of memory");
+		}
+		buf = nb;
+
+		struct rpcap_findalldevs_if iface = {
+			.namelen = htons(namelen),
+			.desclen = htons(desclen),
+			.flags = htonl(PCAP_IF_UP | PCAP_IF_RUNNING),
+		};
+		memcpy(buf + buflen, &iface, sizeof(iface));
+		memcpy(buf + buflen + sizeof(iface), name, namelen);
+		memcpy(buf + buflen + sizeof(iface) + namelen, desc, desclen);
+		buflen += entry;
+		nif++;
+	}
+
+	RTE_LOG(INFO, RPCAPD, "findallif: %u interface(s)\n", nif);
+	rc = rpcap_send_msg(fd, RPCAP_MSG_FINDALLIF_REPLY, nif, buf, buflen);
+	free(buf);
+	return rc;
+}
+
+/* OPEN_REQ: payload is the interface name (no NUL). */
+static int
+handle_open(int fd, uint32_t plen, struct session *s)
+{
+	struct rpcap_openreply reply = {
+		.linktype = htonl(DLT_EN10MB),
+	};
+	uint16_t port;
+
+	if (s->capture_on)
+		stop_capture(s);
+
+	if (plen >= sizeof(s->name)) {
+		rpcap_discard(fd, plen);
+		return rpcap_send_error(fd, 0, "interface name too long");
+	}
+	if (recv_full(fd, s->name, plen) < 0)
+		return -1;
+	s->name[plen] = '\0';
+
+	if (rte_eth_dev_get_port_by_name(s->name, &port) < 0) {
+		RTE_LOG(WARNING, RPCAPD, "open: no such port '%s'\n", s->name);
+		return rpcap_send_error(fd, 0, "unknown interface");
+	}
+	s->port = port;
+
+	RTE_LOG(DEBUG, RPCAPD, "open: '%s' -> dpdk port %u\n", s->name, port);
+	return rpcap_send_msg(fd, RPCAP_MSG_OPEN_REPLY, 0, &reply, sizeof(reply));
+}
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
+		RTE_LOG(ERR, RPCAPD, "data socket: %s\n", strerror(errno));
+		return -1;
+	}
+
+	alen = listen_addrlen;
+	if (bind(fd, (struct sockaddr *)&addr, alen) < 0 ||
+	    listen(fd, 1) < 0 ||
+	    getsockname(fd, (struct sockaddr *)&addr, &alen) < 0) {
+		RTE_LOG(ERR, RPCAPD, "data port bind/listen: %s\n", strerror(errno));
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
+	uint32_t mbuf_size = RTE_PKTMBUF_HEADROOM + snaplen;
+
+	snprintf(name, sizeof(name), "rpcapd_p_%u_%d", port, getpid());
+	return rte_pktmbuf_pool_create(name, ring_size * 2, MBUF_CACHE_SIZE, 0,
+				       mbuf_size, rte_socket_id());
+}
+
+/* Tear down anything that handle_startcap brought up.  Safe to call
+ * after partial setup as well as after a successful capture.
+ */
+static void
+stop_capture(struct session *s)
+{
+	struct rte_mbuf *pkts[BURST_SIZE];
+	unsigned int n;
+
+	if (s->capture_on) {
+		rte_pdump_disable(s->port, RTE_PDUMP_ALL_QUEUES, RTE_PDUMP_FLAG_RXTX);
+		RTE_LOG(INFO, RPCAPD, "capture stopped on %s (%u packets)\n",
+			s->name, s->npkt);
+	}
+	s->capture_on = false;
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
+	if (s->data_fd >= 0) {
+		close(s->data_fd);
+		s->data_fd = -1;
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
+static int
+handle_startcap(int fd, uint32_t plen, struct session *s)
+{
+	struct rpcap_startcapreq req;
+	uint16_t data_port;
+	int data_listen;
+	int data_fd;
+
+	if (s->capture_on)
+		stop_capture(s);
+
+	if (plen < sizeof(req)) {
+		rpcap_discard(fd, plen);
+		return rpcap_send_error(fd, 0, "short startcap request");
+	}
+	if (recv_full(fd, &req, sizeof(req)) < 0)
+		return -1;
+	/* Skip any embedded BPF filter; not supported here. */
+	if (rpcap_discard(fd, plen - sizeof(req)) < 0)
+		return -1;
+
+	s->snaplen = ntohl(req.snaplen);
+	if (s->snaplen == 0 || s->snaplen > DEFAULT_SNAPLEN)
+		s->snaplen = DEFAULT_SNAPLEN;
+
+	s->ring = create_capture_ring(s->port);
+	s->mp = create_capture_mempool(s->port, s->snaplen);
+	if (s->ring == NULL || s->mp == NULL) {
+		RTE_LOG(ERR, RPCAPD, "ring/mempool alloc failed: %s\n",
+			rte_strerror(rte_errno));
+		stop_capture(s);
+		return rpcap_send_error(fd, 0, "DPDK alloc failed");
+	}
+
+	data_listen = open_data_listener(&data_port);
+	if (data_listen < 0) {
+		stop_capture(s);
+		return rpcap_send_error(fd, 0, "data port setup failed");
+	}
+
+	struct rpcap_startcapreply reply = {
+		.bufsize = htonl(s->snaplen * BURST_SIZE),
+		.portdata = htons(data_port),
+	};
+	if (rpcap_send_msg(fd, RPCAP_MSG_STARTCAP_REPLY, 0, &reply, sizeof(reply)) < 0) {
+		close(data_listen);
+		stop_capture(s);
+		return -1;
+	}
+
+	RTE_LOG(INFO, RPCAPD, "awaiting connection\n");
+
+	data_fd = accept(data_listen, NULL, NULL);
+	close(data_listen);
+	if (data_fd < 0) {
+		RTE_LOG(ERR, RPCAPD, "accept on data port: %s\n", strerror(errno));
+		stop_capture(s);
+		return -1;
+	}
+
+	s->data_fd = data_fd;
+
+	if (rte_pdump_enable(s->port, RTE_PDUMP_ALL_QUEUES, RTE_PDUMP_FLAG_RXTX,
+			     s->ring, s->mp, NULL) < 0) {
+		RTE_LOG(ERR, RPCAPD, "rte_pdump_enable port %u failed: %s\n",
+			s->port, rte_strerror(rte_errno));
+		stop_capture(s);
+		return -1;
+	}
+	s->capture_on = true;
+	s->npkt = 0;
+
+	RTE_LOG(INFO, RPCAPD,
+		"capture started on %s (snaplen %u, data port %u)\n",
+		s->name, s->snaplen, data_port);
+	return 0;
+}
+
+/*
+ * Pull a burst from the ring, frame each packet into an RPCAP_MSG_PACKET
+ * message, and send it on the data connection.  MSG_MORE on all but the
+ * last send tells the kernel to coalesce the burst into full segments.
+ */
+static int
+process_ring(struct session *s)
+{
+	struct rte_mbuf *pkts[BURST_SIZE];
+	unsigned int i, n;
+
+	n = rte_ring_sc_dequeue_burst(s->ring, (void **)pkts, BURST_SIZE, NULL);
+	if (n == 0)
+		return 0;
+
+	for (i = 0; i < n; i++) {
+		struct rte_mbuf *m = pkts[i];
+		uint8_t buf[RTE_ETHER_MAX_JUMBO_FRAME_LEN];
+		uint32_t pktlen = rte_pktmbuf_pkt_len(m);
+		uint32_t caplen = pktlen < s->snaplen ? pktlen : s->snaplen;
+		const void *data;
+		struct timeval tv;
+
+		s->npkt++;
+
+		struct rpcap_header hdr = {
+			.ver = RPCAP_VERSION,
+			.type = RPCAP_MSG_PACKET,
+			.plen = htonl(sizeof(struct rpcap_pkthdr) + caplen),
+		};
+
+		gettimeofday(&tv, NULL);
+
+		struct rpcap_pkthdr pkthdr = {
+			.timestamp_sec = htonl((uint32_t)tv.tv_sec),
+			.timestamp_usec = htonl((uint32_t)tv.tv_usec),
+			.caplen = htonl(caplen),
+			.len = htonl(pktlen),
+			.npkt = htonl(s->npkt),
+		};
+
+		data = rte_pktmbuf_read(m, 0, caplen, buf);
+
+		struct iovec iov[3] = {
+			{ .iov_base = &hdr,                       .iov_len = sizeof(hdr) },
+			{ .iov_base = &pkthdr,                    .iov_len = sizeof(pkthdr) },
+			{ .iov_base = (void *)(uintptr_t)data,    .iov_len = caplen },
+		};
+		if (send_iov_full(s->data_fd, iov, 3,
+				  i + 1 < n ? MSG_MORE : 0) < 0) {
+			RTE_LOG(NOTICE, RPCAPD, "data connection closed: %s\n", strerror(errno));
+			goto error;
+		}
+		rte_pktmbuf_free(m);
+	}
+
+	return (int)n;
+
+error:
+	rte_pktmbuf_free_bulk(pkts + i, n - i);
+	return -1;
+}
+
+/*
+ * Stay in the capture loop until either:
+ *   - a control message arrives (typically ENDCAP),
+ *   - the data connection breaks, or
+ *   - a quit signal is delivered.
+ */
+static int
+capture_loop(int ctrl_fd, struct session *s)
+{
+	struct pollfd pfd = { .fd = ctrl_fd, .events = POLLIN };
+	unsigned int idle = 0;
+
+	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
+		int n;
+
+		if (poll(&pfd, 1, 0) > 0 && (pfd.revents & POLLIN))
+			return 0;
+
+		n = process_ring(s);
+		if (n < 0)
+			return -1;
+		if (n == 0) {
+			if (idle++ < 1000)
+				continue;
+			usleep(1000);
+			idle = 0;
+		} else {
+			idle = 0;
+		}
+	}
+	return 0;
+}
+
+static int
+handle_endcap(int fd, uint32_t plen, struct session *s)
+{
+	if (rpcap_discard(fd, plen) < 0)
+		return -1;
+	stop_capture(s);
+	return rpcap_send_msg(fd, RPCAP_MSG_ENDCAP_REPLY, 0, NULL, 0);
+}
+
+static int
+handle_stats(int fd, uint32_t plen, const struct session *s)
+{
+	struct rte_eth_stats es = { 0 };
+
+	if (rpcap_discard(fd, plen) < 0)
+		return -1;
+
+	if (s->capture_on)
+		rte_eth_stats_get(s->port, &es);
+
+	struct rpcap_stats reply = {
+		.ifrecv   = htonl((uint32_t)es.ipackets),
+		.ifdrop   = htonl((uint32_t)es.ierrors),
+		.krnldrop = 0,
+		.svrcapt  = htonl(s->npkt),
+	};
+	return rpcap_send_msg(fd, RPCAP_MSG_STATS_REPLY, 0, &reply, sizeof(reply));
+}
+
+/* Service a single client until it disconnects. */
+static void
+handle_client(int ctrl_fd)
+{
+	struct sockaddr_storage peer;
+	socklen_t plen = sizeof(peer);
+	char host[NI_MAXHOST] = "?";
+	struct session s = { .ctrl_fd = ctrl_fd, .data_fd = -1 };
+
+	if (getpeername(ctrl_fd, (struct sockaddr *)&peer, &plen) == 0)
+		getnameinfo((struct sockaddr *)&peer, plen,
+			    host, sizeof(host), NULL, 0, NI_NUMERICHOST);
+	RTE_LOG(INFO, RPCAPD, "client %s connected\n", host);
+
+	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
+		struct rpcap_header hdr;
+
+		if (rpcap_recv_header(ctrl_fd, &hdr) < 0)
+			break;
+
+		switch (hdr.type) {
+		case RPCAP_MSG_AUTH_REQ:
+			/* No auth: discard credentials, ack with empty reply.
+			 * libpcap treats a zero-length AUTH_REPLY as "version
+			 * 0 only, same byte order".
+			 */
+			if (rpcap_discard(ctrl_fd, hdr.plen) < 0 ||
+			    rpcap_send_msg(ctrl_fd, RPCAP_MSG_AUTH_REPLY, 0, NULL, 0) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_FINDALLIF_REQ:
+			if (rpcap_discard(ctrl_fd, hdr.plen) < 0 || handle_findallif(ctrl_fd) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_OPEN_REQ:
+			if (handle_open(ctrl_fd, hdr.plen, &s) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_STARTCAP_REQ:
+			if (handle_startcap(ctrl_fd, hdr.plen, &s) < 0)
+				goto done;
+			if (capture_loop(ctrl_fd, &s) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_UPDATEFILTER_REQ:
+			/* Filters not implemented; ack and ignore. */
+			if (rpcap_discard(ctrl_fd, hdr.plen) < 0 ||
+			    rpcap_send_msg(ctrl_fd, RPCAP_MSG_UPDATEFILTER_REPLY,
+					   0, NULL, 0) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_ENDCAP_REQ:
+			if (handle_endcap(ctrl_fd, hdr.plen, &s) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_STATS_REQ:
+			if (handle_stats(ctrl_fd, hdr.plen, &s) < 0)
+				goto done;
+			break;
+		case RPCAP_MSG_CLOSE:
+			rpcap_discard(ctrl_fd, hdr.plen);
+			goto done;
+		default:
+			RTE_LOG(WARNING, RPCAPD, "unsupported request type 0x%02x\n", hdr.type);
+			rpcap_discard(ctrl_fd, hdr.plen);
+			rpcap_send_error(ctrl_fd, 0, "unsupported request");
+			break;
+		}
+	}
+done:
+	stop_capture(&s);
+	close(ctrl_fd);
+	RTE_LOG(INFO, RPCAPD, "client %s disconnected\n", host);
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
+	RTE_LOG(INFO, RPCAPD, "listening on %s port %u\n", host, listen_port);
+
+	if (!is_loopback(&listen_addr))
+		RTE_LOG(WARNING, RPCAPD,
+			"bound to non-loopback address %s; "
+			"rpcap is unauthenticated and unencrypted, "
+			"captured traffic is exposed to the network\n",
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
+		"  -b, --bind <addr>     bind address (default 127.0.0.1)\n"
+		"  -4                    use only IPv4 (reject IPv6 bind addresses)\n"
+		"  -N <ring size>        ring size in packets (default %u)\n"
+		"  -D, --debug           enable rpcapd debug log messages\n"
+		"      --debug-file <f>  redirect log output to file <f> (append mode)\n"
+		"      --version         print version and exit\n"
+		"  -h, --help            print this help and exit\n"
+		"      --lcore=<core>    CPU core to run on (default: any)\n"
+		"      --file-prefix=<p> prefix to use for multi-process\n"
+		"\n"
+		"WARNING: rpcap is unauthenticated and unencrypted.  Binding to\n"
+		"any non-loopback address exposes captured traffic to the\n"
+		"network.  Sample application; not for production use.\n",
+		RPCAP_DEFAULT_NETPORT, DEFAULT_RING_SIZE);
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
+	};
+	static const struct option long_options[] = {
+		{ "port",        required_argument, NULL, 'p' },
+		{ "bind",        required_argument, NULL, 'b' },
+		{ "debug",       no_argument,       NULL, 'D' },
+		{ "help",        no_argument,       NULL, 'h' },
+		{ "version",     no_argument,       NULL, OPT_VERSION },
+		{ "debug-file",  required_argument, NULL, OPT_DEBUG_FILE },
+		{ "file-prefix", required_argument, NULL, 0 },
+		{ "lcore",       required_argument, NULL, 0 },
+		{ NULL, 0, NULL, 0 },
+	};
+	int option_index, c;
+
+	while ((c = getopt_long(argc, argv, "hD4p:b:N:",
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
+			bind_arg = optarg;
+			break;
+		case '4':
+			ipv4_only = true;
+			break;
+		case 'N':
+			ring_size = strtoul(optarg, NULL, 0);
+			if (ring_size < 64)
+				rte_exit(EXIT_FAILURE, "Ring size too small\n");
+			break;
+		case 'D':
+			debug_log = true;
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
+	/* Resolve the bind address now that -4 has been seen. */
+	parse_bind_addr(bind_arg ? bind_arg : "127.0.0.1",
+			ipv4_only ? AF_INET : AF_UNSPEC);
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
+	RTE_LOG(NOTICE, RPCAPD, "primary process exited, shutting down\n");
+	rte_atomic_store_explicit(&quit_signal, true, rte_memory_order_relaxed);
+}
+
+static void
+enable_primary_monitor(void)
+{
+	if (rte_eal_alarm_set(PRIMARY_MONITOR_INTERVAL_US, monitor_primary, NULL) < 0)
+		RTE_LOG(WARNING, RPCAPD, "failed to install primary process monitor\n");
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
+ * running primary DPDK application.  Mirrors dumpcap's approach: the
+ * RPCAP user sees a small set of options (port, ring size) rather
+ * than the full DPDK EAL command line.
+ */
+static int
+dpdk_init(void)
+{
+	static const char * const args[] = {
+		"rpcapd",
+		"--proc-type", "secondary",
+		"--log-level", "info",        /* EAL stays quiet */
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
+		RTE_LOG(INFO, RPCAPD,
+			 "Can not restore original CPU affinity\n");
+
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "rte_pdump_init failed\n");
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
+	if (debug_log)
+		rte_log_set_level(rpcapd_logtype, RTE_LOG_DEBUG);
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
+		int cfd = accept(srv_fd, NULL, NULL);
+		if (cfd < 0) {
+			if (errno == EINTR)
+				continue;
+			RTE_LOG(ERR, RPCAPD, "accept: %s\n", strerror(errno));
+			break;
+		}
+		handle_client(cfd);
+	}
+
+	disable_primary_monitor();
+	RTE_LOG(INFO, RPCAPD, "shutting down\n");
+	close(srv_fd);
+	rte_pdump_uninit();
+	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
+}
diff --git a/examples/rpcapd/meson.build b/examples/rpcapd/meson.build
new file mode 100644
index 0000000000..5eb1a8487c
--- /dev/null
+++ b/examples/rpcapd/meson.build
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026
+
+if is_windows
+    build = false
+    reason = 'not supported on Windows'
+    subdir_done()
+endif
+
+sources = files('main.c')
+deps += ['ethdev', 'pdump']
diff --git a/examples/rpcapd/rpcap-protocol.h b/examples/rpcapd/rpcap-protocol.h
new file mode 100644
index 0000000000..46d87928aa
--- /dev/null
+++ b/examples/rpcapd/rpcap-protocol.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026
+ *
+ * On-the-wire RPCAP protocol definitions, transcribed from libpcap's
+ * rpcap-protocol.h.  See:
+ *   https://github.com/the-tcpdump-group/libpcap/blob/master/rpcap-protocol.h
+ *
+ * Only the subset needed by the DPDK rpcd POC is included here.  All
+ * multi-byte fields in the structures below are big-endian on the wire.
+ */
+
+#ifndef _RPCAP_PROTOCOL_H_
+#define _RPCAP_PROTOCOL_H_
+
+#include <stdint.h>
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
+/* Subset of pcap interface flags (pcap.h) */
+#define PCAP_IF_UP                 0x00000002
+#define PCAP_IF_RUNNING            0x00000004
+
+/* DLT_EN10MB - ethernet, the only link type we report */
+#define DLT_EN10MB                 1
+
+struct rpcap_header {
+	uint8_t  ver;
+	uint8_t  type;
+	uint16_t value;
+	uint32_t plen;
+};
+
+struct rpcap_findalldevs_if {
+	uint16_t namelen;
+	uint16_t desclen;
+	uint32_t flags;
+	uint16_t naddr;
+	uint16_t dummy;
+};
+
+struct rpcap_openreply {
+	int32_t  linktype;
+	int32_t  tzoff;
+};
+
+struct rpcap_startcapreq {
+	uint32_t snaplen;
+	uint32_t read_timeout;
+	uint16_t flags;
+	uint16_t portdata;
+};
+
+struct rpcap_startcapreply {
+	int32_t  bufsize;
+	uint16_t portdata;
+	uint16_t dummy;
+};
+
+struct rpcap_stats {
+	uint32_t ifrecv;
+	uint32_t ifdrop;
+	uint32_t krnldrop;
+	uint32_t svrcapt;
+};
+
+struct rpcap_pkthdr {
+	uint32_t timestamp_sec;
+	uint32_t timestamp_usec;
+	uint32_t caplen;
+	uint32_t len;
+	uint32_t npkt;
+};
+
+#endif /* _RPCAP_PROTOCOL_H_ */
-- 
2.53.0

