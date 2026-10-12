Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86452CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9042440279;
	Mon, 12 Oct 2026 23:08:47 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 23B9E40272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:08:45 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-88b5f43cb8aso655235b3a.3
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791839324;
 x=1792444124; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hfzuVVw7G24V2eVXpFwPMR2j640/2/fMYfnIseXByxE=;
 b=Ns+ln/xKSqGibG9z7qnmSZmOMBonEQk5ZcQmPW/et+uogdLcMUJ7gwZd5nSAogQVB8
 RNud0Pvi/xgM5Od3pzITN3ExmFyztzbkkEh7SZXwE2o1lfEHEJoc9aw8h7avnGNHseI0
 k4LXpTFcAx2m8Ab2i3G6f8hdjxvkQteRET7oE1x1dXhDg08BJwmyf2gkdvkUHhpdISK1
 ELL3aDxMJAleYWB+44I60EHNxG+3H/6EBftjVjMBuzl6wmS5S74GMRQnP+BCsPkYelJU
 g2SNP2I72Zu6M8y457rkzCZ3ST3BKY0L4lG9Zj65z7eOTmmIRJTJJ0RR2PWqdc7DIGkn
 a0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839324; x=1792444124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hfzuVVw7G24V2eVXpFwPMR2j640/2/fMYfnIseXByxE=;
 b=D0+IBxrjgcglKcqioIG663eZds7TKozWGq0r47KzR8poamMNGBoCT3eOqv8k14xJg7
 uM0BcxFkAN5zhwUALRbwJptItoUge3ZhhTB1VOOkHX9qr6sJNeZOmCSDdfcOrsN2lo4a
 fvK+69HvhyDQjWcRDErX5C/kbAQUn67gyxf0ces64TNhAVWEHKlD/kZYecl0z4bHCYwh
 Hn+mzcfYu/qD2k2uxcOS7vRO6+D/scF+2A4cpQ+wD9HvBiogvfVilVF6fivJVFstIFuq
 YjtcYySUZ570Y2zrUeDCpBnVQEs0OuAyQzHIYZqGVNSEpujm6Iz8jkGxMDvwQjorhgAf
 9E9w==
X-Gm-Message-State: AFq9FYIRq8kiPyUw5MOGkM0OYHmwyDAAwIrFP3pmFmVv2PVUKTzDzdWz
 XiZY/gOXWbZecFPw4X7IXCOKRPgnrkYQ5UQqgd4mLegGm2X7gieJDgOUij/CrzW7XqHYi3BpgrJ
 65fu2+xM=
X-Gm-Gg: AYBFou2VNzCpmxvtQA/6nYF9T/CXTHymw2elFMR05shAp+eiZjieLAolqE1t5XMyfI7
 cAmoLtVLLDZlbqm49Laz++qtOfwkvLSe4adMAmDlTmqpJcuoo/kJzN+hOQMWRENjkTTGLP4a2uH
 hhmTuUZCvH7hfL1XFASy2gdlNTe1eMGnY8tyYd42rY99XFaCz4sgHwrqvrMDJrsxjo3AFXjaLC2
 Ve+6thYgnYXtScmtI2anlAhkJIO0i7HloIDLggTifJzjWOzYfO+yGk2AXaJAJtAHKOJcLN+m9B3
 onRTXcGt4aKpIqQHguB6V4fQp2NhqLTWCZChYcNYmeNW9dKfRklQbQtgb3IyiXsCGrYTZZS67KQ
 U3vUYbiySUlR9/iFUgTIypVQxJllZdF7NOfwttVfRJbHLmDt54ZmlVlHgyY2MDuHCNX5r+hadpF
 niktXoFme1wwrKiyRTBDiWchcdG7R8JtR9KfMkmwZoe61NLhPCBiCZjwJEtQSiuocoMxoCih9Ij
 pMd1ljG1nVypRpzWImkUJfjF7eXHGC0XUNZ+Q==
X-Received: by 2002:a05:6a00:450b:b0:881:e266:c3c5 with SMTP id
 d2e1a72fcca58-897c3ef90d0mr8476952b3a.2.1791839323038; 
 Mon, 12 Oct 2026 14:08:43 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c469ea49sm4268639b3a.53.2026.10.12.14.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:08:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5] examples/rpcapd: remote pcap daemon
Date: Mon, 12 Oct 2026 14:06:15 -0700
Message-ID: <20261012210840.1189106-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908210832.1556291-1-stephen@networkplumber.org>
References: <20260908210832.1556291-1-stephen@networkplumber.org>
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

This example provides a mechanism for doing live capture with
tcpdump of a DPDK application. It uses libpcap tools (requires
rebuild to enable rpcap). The example daemon uses the rpcap protocol
that libpcap uses. It runs as a DPDK secondary process and takes
packets from the existing pdump infrastructure.

There are security issues with opening up general rpcap access
so the daemon is bound to loopback address only.

See doc/guides/sample_app_ug/rpcapd.rst for more info.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v5 - simplify only do what is needed for demo
   - put in examples/
   - only bind to loopback no option to allow remote
   - document restrictions and security limitations
   - don't bother with auth or TLS
   - accept worse latency in timestamp instead of having
     to change pcapng
   - repeated AI review scans

 MAINTAINERS                            |   2 +
 doc/guides/rel_notes/release_26_11.rst |   6 +
 doc/guides/sample_app_ug/index.rst     |   1 +
 doc/guides/sample_app_ug/rpcapd.rst    | 199 ++++++++
 examples/meson.build                   |   1 +
 examples/rpcapd/Makefile               |  41 ++
 examples/rpcapd/capture.c              | 645 ++++++++++++++++++++++++
 examples/rpcapd/filter.c               | 163 ++++++
 examples/rpcapd/main.c                 | 669 +++++++++++++++++++++++++
 examples/rpcapd/meson.build            |  28 ++
 examples/rpcapd/rpcap-protocol.h       | 143 ++++++
 examples/rpcapd/rpcapd.h               | 119 +++++
 examples/rpcapd/session.c              | 136 +++++
 examples/rpcapd/sock.c                 | 292 +++++++++++
 14 files changed, 2445 insertions(+)
 create mode 100644 doc/guides/sample_app_ug/rpcapd.rst
 create mode 100644 examples/rpcapd/Makefile
 create mode 100644 examples/rpcapd/capture.c
 create mode 100644 examples/rpcapd/filter.c
 create mode 100644 examples/rpcapd/main.c
 create mode 100644 examples/rpcapd/meson.build
 create mode 100644 examples/rpcapd/rpcap-protocol.h
 create mode 100644 examples/rpcapd/rpcapd.h
 create mode 100644 examples/rpcapd/session.c
 create mode 100644 examples/rpcapd/sock.c

diff --git a/MAINTAINERS b/MAINTAINERS
index edc0cbc801..c41499483c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1727,6 +1727,8 @@ F: app/pdump/
 F: doc/guides/tools/pdump.rst
 F: app/dumpcap/
 F: doc/guides/tools/dumpcap.rst
+F: examples/rpcapd/
+F: doc/guides/sample_app_ug/rpcapd.rst
 
 
 Packet Framework
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index b3cd38fc71..ca02734479 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -158,6 +158,12 @@ New Features
   Added ``rte_bbdev_queue_stats_get()`` function to retrieve statistics
   for a specific queue, complementing the existing device-level statistics API.
 
+* **Added libpcap remote capture daemon example.**
+
+  Added the ``dpdk-rpcapd`` example application, which implements the
+  rpcap protocol over loopback to allow live capture in tcpdump and
+  Wireshark.
+
 
 Removed Items
 -------------
diff --git a/doc/guides/sample_app_ug/index.rst b/doc/guides/sample_app_ug/index.rst
index 28c4c9a5b2..2a93c4657e 100644
--- a/doc/guides/sample_app_ug/index.rst
+++ b/doc/guides/sample_app_ug/index.rst
@@ -50,6 +50,7 @@ Sample Applications User Guides
     vm_power_management
     ptpclient
     ptp_tap_relay_sw
+    rpcapd
     fips_validation
     ipsec_secgw
     bbdev_app
diff --git a/doc/guides/sample_app_ug/rpcapd.rst b/doc/guides/sample_app_ug/rpcapd.rst
new file mode 100644
index 0000000000..f91cbc46fe
--- /dev/null
+++ b/doc/guides/sample_app_ug/rpcapd.rst
@@ -0,0 +1,199 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Stephen Hemminger
+
+.. _rpcapd_example:
+
+Remote Packet Capture Daemon Sample Application
+===============================================
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
+request the list of available interfaces (which are the ports of the DPDK
+primary),
+open one, and stream packets from it.
+
+This is an example, not a supported application, for three reasons:
+
+*   ``rpcap`` is not a secure protocol.  See `Security`_ below.
+
+*   Clients need rebuilding.  ``--enable-remote`` is off by default in
+    libpcap, so the ``tcpdump`` and libpcap that distributions ship
+    cannot speak ``rpcap`` at all.  See `Client Setup`_.
+
+*   Linux only.  Capturing from a running application means attaching to
+    it as a DPDK secondary process, and multi-process support only works
+    on Linux.
+
+
+Security
+--------
+
+The protocol has no authentication and no encryption, so the listener is
+bound to the loopback addresses only and is never reachable from another
+host.
+
+A connection grants read access to all traffic of the primary
+process.  Any client can list its ports and capture from any of them,
+including traffic belonging to other users of that application, and
+can turn on promiscuous mode on a port the primary owns.
+
+The listener is reachable by every user on the host.  Since
+``dpdk-rpcapd`` normally runs as root, starting it gives any local
+user that access.  Running this on a production system is not
+advisable.
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
+from ``tcpdump`` or Wireshark on Linux, rebuild libpcap with it.
+The ``rpcap`` client was added in libpcap 1.9.0, so any release from
+that one on will do:
+
+.. code-block:: console
+
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
+    sudo ./<build_dir>/examples/dpdk-rpcapd
+    RPCAPD: open_listen_sockets(): listening on 127.0.0.1 port 2002
+
+In a third window, list available interfaces using a libpcap-based
+``tcpdump`` rebuilt with remote support:
+
+.. code-block:: console
+
+    sudo /usr/local/sbin/tcpdump --list-remote-interfaces=rpcap://127.0.0.1:2002/
+    rpcap://127.0.0.1:2002/net_tap0  Network adapter 'DPDK port' on remote node 127.0.0.1
+
+Capture live from a port:
+
+.. code-block:: console
+
+    sudo /usr/local/sbin/tcpdump -i rpcap://127.0.0.1:2002/net_tap0 -nn -c 20
+
+Or save to a file readable by any pcap consumer:
+
+.. code-block:: console
+
+    sudo /usr/local/sbin/tcpdump -i rpcap://127.0.0.1:2002/net_tap0 -w /tmp/capture.pcap
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
+*   **No TLS and no password authentication.** See `Security`_ above.
+    A password is refused with ``PCAP_ERR_AUTH_TYPE_NOTSUP``; clients
+    must connect without credentials, which is what a ``rpcap://`` URL
+    with no userinfo does.
+
+*   **TCP data transport only.** A client requesting UDP is refused.
+
+*   **Approximate timestamps.** Packets are stamped when sent
+    to the client, not when the port received them.
+
+See Also
+--------
+
+*   :doc:`../tools/dumpcap` -- file-based capture writing pcapng
+    output.
+
+*   The libpcap project's ``rpcapd`` reference implementation:
+    https://github.com/the-tcpdump-group/libpcap/tree/master/rpcapd
diff --git a/examples/meson.build b/examples/meson.build
index 544ec5eadd..50af0fd8d3 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -44,6 +44,7 @@ all_examples = [
         'ptpclient',
         'qos_meter',
         'qos_sched',
+        'rpcapd',
         'rxtx_callbacks',
         'server_node_efd/efd_node',
         'server_node_efd/efd_server',
diff --git a/examples/rpcapd/Makefile b/examples/rpcapd/Makefile
new file mode 100644
index 0000000000..70e2e29fdc
--- /dev/null
+++ b/examples/rpcapd/Makefile
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+# binary name
+APP = rpcapd
+
+# all source are stored in SRCS-y
+SRCS-y := capture.c filter.c main.c session.c sock.c
+
+PKGCONF ?= pkg-config
+
+# Build using pkg-config variables if possible
+ifneq ($(shell $(PKGCONF) --exists libdpdk && echo 0),0)
+$(error "no installation of DPDK found")
+endif
+
+all: shared
+.PHONY: shared static
+shared: build/$(APP)-shared
+	ln -sf $(APP)-shared build/$(APP)
+static: build/$(APP)-static
+	ln -sf $(APP)-static build/$(APP)
+
+PC_FILE := $(shell $(PKGCONF) --path libdpdk 2>/dev/null)
+CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
+LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk) -lpcap
+LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk) -lpcap
+
+build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
+	$(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_SHARED)
+
+build/$(APP)-static: $(SRCS-y) Makefile $(PC_FILE) | build
+	$(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_STATIC)
+
+build:
+	@mkdir -p $@
+
+.PHONY: clean
+clean:
+	rm -f build/$(APP) build/$(APP)-static build/$(APP)-shared
+	test -d build && rmdir -p build || true
diff --git a/examples/rpcapd/capture.c b/examples/rpcapd/capture.c
new file mode 100644
index 0000000000..71b27fa954
--- /dev/null
+++ b/examples/rpcapd/capture.c
@@ -0,0 +1,645 @@
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
+#include <sys/eventfd.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <sys/uio.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <rte_byteorder.h>
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_eal.h>
+#include <rte_errno.h>
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
+#include <rte_pdump.h>
+#include <rte_ring.h>
+#include <rte_stdatomic.h>
+
+#include "rpcap-protocol.h"
+#include "rpcapd.h"
+
+#define BURST_SIZE                    32
+#define POLL_INTERVAL_MS              500
+
+/* Two rpcap headers plus the segments of one captured packet. */
+#define PKT_MAX_IOV                   34
+
+/* A capture is sent from the mbuf segments, so a packet at the snaplen
+ * has to fit in the iovecs left after the two headers.
+ */
+static_assert(MAX_SNAPLEN <= (PKT_MAX_IOV - 2) * RTE_MBUF_DEFAULT_DATAROOM,
+	      "snaplen needs more iovecs than PKT_MAX_IOV");
+#define SLEEP_THRESHOLD		      100
+#define SLEEP_US		      100
+#define DATA_ACCEPT_TIMEOUT_MS        10000
+
+/*
+ * Open an ephemeral TCP listening socket for the data connection;
+ * return fd, set *port_out.
+ *
+ * The local address of the control connection is used, not the bind
+ * address: the daemon may be listening on several addresses, and the
+ * data connection has to be reachable the way the client reached the
+ * control connection.
+ */
+static int
+open_data_listener(const struct conn *ctrl, uint16_t *port_out)
+{
+	struct sockaddr_storage addr;
+	socklen_t alen = sizeof(addr);
+	int fd;
+
+	if (getsockname(ctrl->fd, (struct sockaddr *)&addr, &alen) < 0) {
+		RPCAPD_LOG(ERR, "getsockname: %s", strerror(errno));
+		return -1;
+	}
+	set_sockaddr_port(&addr, 0);
+
+	fd = socket(addr.ss_family, SOCK_STREAM, 0);
+	if (fd < 0) {
+		RPCAPD_LOG(ERR, "data socket: %s", strerror(errno));
+		return -1;
+	}
+
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
+create_capture_mempool(uint16_t port)
+{
+	char name[RTE_MEMPOOL_NAMESIZE];
+
+	snprintf(name, sizeof(name), "rpcapd_p_%u_%d", port, getpid());
+
+	/*
+	 * No per-lcore cache: the primary allocates from this pool in the
+	 * pdump callback and this process frees, and both would index
+	 * local_cache[] by an lcore id that the two processes can share.
+	 * Multi-process ops are named explicitly for the same reason.
+	 */
+	return rte_pktmbuf_pool_create_by_ops(name, ring_size * 2, 0, 0,
+					      RTE_MBUF_DEFAULT_BUF_SIZE,
+					      rte_socket_id(), "ring_mp_mc");
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
+	/* First: nothing below may run while the data thread is still
+	 * dequeuing from the ring or writing to the data socket.
+	 */
+	stop_data_thread(s);
+
+	/*
+	 * If the primary is gone the shared memory state cannot be trusted:
+	 * pdump IPC has no one to answer it, the port belongs to a dead
+	 * process, and the ring, mempool and heap locks may have been held
+	 * when it died.  Drop the references and leave the memory alone.
+	 */
+	if (!rte_eal_primary_proc_alive(NULL)) {
+		s->capture_on = false;
+		s->promisc_set = false;
+		s->ring = NULL;
+		s->mp = NULL;
+		s->prm = NULL;
+		if (s->data.fd >= 0) {
+			close(s->data.fd);
+			s->data.fd = -1;
+		}
+		return;
+	}
+
+	if (s->capture_on) {
+		rte_pdump_disable(s->port, RTE_PDUMP_ALL_QUEUES, s->pdump_flags);
+		RPCAPD_LOG(NOTICE, "capture stopped on %s (%u packets)",
+			s->name,
+			rte_atomic_load_explicit(&s->npkt, rte_memory_order_relaxed));
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
+	if (s->snaplen == 0)
+		s->snaplen = DEFAULT_SNAPLEN;
+	else if (s->snaplen > MAX_SNAPLEN)
+		s->snaplen = MAX_SNAPLEN;
+
+	s->ring = create_capture_ring(s->port);
+	s->mp = create_capture_mempool(s->port);
+	if (s->ring == NULL || s->mp == NULL) {
+		RPCAPD_LOG(ERR, "ring/mempool alloc failed: %s",
+			rte_strerror(rte_errno));
+		stop_capture(s);
+		return rpcap_send_error(c, 0, "DPDK alloc failed");
+	}
+
+	data_listen = open_data_listener(c, &data_port);
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
+	/*
+	 * Setup packet capture callbacks.  The copy into the ring is of the
+	 * whole packet: the snapshot is applied when it leaves the ring, so
+	 * that the length before truncation is still known and can be
+	 * reported to the client as the wire length.  A zero snaplen is how
+	 * pdump is asked not to truncate.
+	 */
+	if (rte_pdump_enable_bpf(s->port, RTE_PDUMP_ALL_QUEUES, s->pdump_flags,
+				 0, s->ring, s->mp, s->prm) < 0) {
+		RPCAPD_LOG(ERR, "rte_pdump_enable_bpf port %u failed: %s",
+			s->port, rte_strerror(rte_errno));
+		close(data_listen);
+		stop_capture(s);
+		return rpcap_send_error(c, 0, "cannot enable capture");
+	}
+	s->capture_on = true;
+	rte_atomic_store_explicit(&s->npkt, 0, rte_memory_order_relaxed);
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
+	s->data.fd = data_fd;
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
+	if (start_data_thread(s) < 0) {
+		stop_capture(s);
+		return rpcap_send_error(c, 0, "cannot start capture thread");
+	}
+
+	RPCAPD_LOG(NOTICE,
+		   "capture started on %s (snaplen %u, data port %u)",
+		   s->name, s->snaplen, data_port);
+	return 0;
+}
+
+/*
+ * Point iovecs at len bytes of an mbuf chain, starting at off.  The
+ * capture is sent straight from the mbufs: a copy into one flat buffer
+ * would cost a memcpy per packet on the datapath for no benefit, since
+ * sendmsg() takes a scatter list.
+ *
+ * Returns the number of iovecs used, or -1 if the chain needs more than
+ * the caller allows.
+ */
+static int
+mbuf_to_iov(const struct rte_mbuf *m, uint32_t off, uint32_t len,
+	    struct iovec *iov, int maxiov)
+{
+	int n = 0;
+
+	while (m != NULL && len > 0) {
+		uint32_t seg = rte_pktmbuf_data_len(m);
+
+		if (off >= seg) {
+			/* Not reached the data yet. */
+			off -= seg;
+			m = m->next;
+			continue;
+		}
+
+		if (n == maxiov)
+			return -1;
+
+		seg -= off;
+		if (seg > len)
+			seg = len;
+
+		iov[n].iov_base = rte_pktmbuf_mtod_offset(m, void *, off);
+		iov[n].iov_len = seg;
+		n++;
+
+		len -= seg;
+		off = 0;
+		m = m->next;
+	}
+
+	return (len == 0) ? n : -1;
+}
+
+/*
+ * Frame each packet from the ring into an RPCAP_MSG_PACKET message and
+ * send it on the data connection.  MSG_MORE corks the socket until the
+ * ring drains, so a backlog coalesces into full segments.
+ *
+ * pdump copies the whole packet, so both the snapshot and the timestamp
+ * are applied here: the wire length is still the full length, and the
+ * time of day is taken once per burst rather than per packet.
+ */
+static ssize_t
+process_ring(struct session *s, unsigned int *avail)
+{
+	struct rte_mbuf *pkts[BURST_SIZE];
+	struct timespec now;
+	unsigned int i, n;
+	ssize_t written = 0;
+
+	n = rte_ring_sc_dequeue_burst(s->ring, (void **)pkts, BURST_SIZE, avail);
+	if (n == 0)
+		return 0;
+
+	clock_gettime(CLOCK_REALTIME, &now);
+
+	for (i = 0; i < n; i++) {
+		struct rte_mbuf *m = pkts[i];
+		struct iovec iov[PKT_MAX_IOV];
+		uint32_t caplen, wirelen, npkt;
+		int niov;
+
+		wirelen = rte_pktmbuf_pkt_len(m);
+		caplen = RTE_MIN(wirelen, s->snaplen);
+
+		/* Only this thread writes npkt, so a load and store is
+		 * enough; the STATS reader just needs a torn-free value.
+		 */
+		npkt = rte_atomic_load_explicit(&s->npkt,
+						rte_memory_order_relaxed) + 1;
+		rte_atomic_store_explicit(&s->npkt, npkt,
+					  rte_memory_order_relaxed);
+
+		struct rpcap_header hdr = {
+			.ver = RPCAP_VERSION,
+			.type = RPCAP_MSG_PACKET,
+			.plen = rte_cpu_to_be_32(sizeof(struct rpcap_pkthdr) + caplen),
+		};
+
+		/* rpcap protocol has timestamp in microseconds. */
+		struct rpcap_pkthdr pkthdr = {
+			.timestamp_sec = rte_cpu_to_be_32(now.tv_sec),
+			.timestamp_usec = rte_cpu_to_be_32(now.tv_nsec / 1000),
+			.caplen = rte_cpu_to_be_32(caplen),
+			.len = rte_cpu_to_be_32(wirelen),
+			.npkt = rte_cpu_to_be_32(npkt),
+		};
+
+		iov[0].iov_base = &hdr;
+		iov[0].iov_len = sizeof(hdr);
+		iov[1].iov_base = &pkthdr;
+		iov[1].iov_len = sizeof(pkthdr);
+
+		niov = mbuf_to_iov(m, 0, caplen, iov + 2, PKT_MAX_IOV - 2);
+		if (unlikely(niov < 0)) {
+			RPCAPD_LOG(ERR, "short capture mbuf on %s", s->name);
+			goto error;
+		}
+		niov += 2;
+
+		/* more to come in this burst, or still queued in the ring */
+		bool more = (i + 1 < n) || (*avail > 0);
+
+		if (send_iov_full(&s->data, iov, niov, more ? MSG_MORE : 0) < 0) {
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
+/*
+ * Data thread: drain the ring and stream packets until asked to stop.
+ *
+ * This runs separately from the control connection because the ring has
+ * no file descriptor to poll.  A single thread would have to choose
+ * between blocking on the control socket (and not draining the ring) or
+ * spinning on the ring (and answering requests late); worse, a blocking
+ * send to a slow client would stall control requests entirely, which is
+ * what a client does when it asks for statistics and waits for a reply
+ * without reading packets.
+ */
+static uint32_t
+data_thread_main(void *arg)
+{
+	struct session *s = arg;
+	unsigned int empty_count = 0;
+
+	while (!rte_atomic_load_explicit(&s->data_stop, rte_memory_order_relaxed) &&
+	       !rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
+		unsigned int avail = 0;
+		ssize_t written;
+
+		written = process_ring(s, &avail);
+		if (written < 0) {
+			/* process_ring has logged the reason */
+			break;
+		}
+
+		if (written > 0) {
+			/* are there more packets? */
+			empty_count = (avail == 0);
+			continue;
+		}
+
+		if (empty_count < SLEEP_THRESHOLD) {
+			/* spin a few times before sleeping */
+			++empty_count;
+			rte_pause();
+			continue;
+		}
+
+		/* ring has been empty for a while: stop spinning */
+		rte_delay_us_sleep(SLEEP_US);
+	}
+
+	/* Wake the control thread: it polls this alongside the control
+	 * socket, so a client that closes only the data connection is
+	 * noticed without waiting for it to send a request.
+	 */
+	if (eventfd_write(s->data_done_fd, 1) < 0)
+		RPCAPD_LOG(DEBUG, "cannot signal data thread exit: %s",
+			   strerror(errno));
+	return 0;
+}
+
+int
+start_data_thread(struct session *s)
+{
+	int rc;
+
+	rte_atomic_store_explicit(&s->data_stop, false, rte_memory_order_relaxed);
+
+	s->data_done_fd = eventfd(0, EFD_CLOEXEC);
+	if (s->data_done_fd < 0) {
+		RPCAPD_LOG(ERR, "eventfd: %s", strerror(errno));
+		return -1;
+	}
+
+	rc = rte_thread_create_control(&s->data_thread, "rpcapd-data",
+				       data_thread_main, s);
+	if (rc != 0) {
+		RPCAPD_LOG(ERR, "cannot create data thread: %s", rte_strerror(-rc));
+		close(s->data_done_fd);
+		s->data_done_fd = -1;
+		return -1;
+	}
+	s->data_running = true;
+	return 0;
+}
+
+/*
+ * Wait until the control connection has a request or the data thread has
+ * exited, whichever comes first.  The thread signals an eventfd on its
+ * way out, which makes its exit just another pollable event: a client
+ * that closes only the data connection is noticed straight away instead
+ * of when it next sends a request.
+ *
+ * Returns 1 if a request is waiting, 0 if the data thread is done, or -1.
+ */
+int
+wait_ctrl_or_data_exit(const struct conn *ctrl, const struct session *s)
+{
+	struct pollfd pfd[2] = {
+		{ .fd = ctrl->fd,         .events = POLLIN },
+		{ .fd = s->data_done_fd,  .events = POLLIN },
+	};
+	int nfds = (s->data_running && s->data_done_fd >= 0) ? 2 : 1;
+
+	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
+		int rc = poll(pfd, nfds, POLL_INTERVAL_MS);
+
+		if (rc < 0) {
+			if (errno == EINTR)
+				continue;
+			RPCAPD_LOG(ERR, "poll failed: %s", strerror(errno));
+			return -1;
+		}
+		if (pfd[0].revents != 0)
+			return 1;
+		if (nfds > 1 && pfd[1].revents != 0)
+			return 0;
+	}
+	return -1;
+}
+
+void
+stop_data_thread(struct session *s)
+{
+	if (!s->data_running)
+		return;
+
+	rte_atomic_store_explicit(&s->data_stop, true, rte_memory_order_relaxed);
+	rte_thread_join(s->data_thread, NULL);
+	s->data_running = false;
+
+	close(s->data_done_fd);
+	s->data_done_fd = -1;
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
+	struct rte_pdump_stats ps = { 0 };
+	uint64_t ifrecv = 0, dropped = 0;
+
+	if (rpcap_discard(c, plen) < 0)
+		return -1;
+
+	/* Report what the capture saw, not the port's lifetime counters:
+	 * port stats include traffic from before the capture started and
+	 * say nothing about packets pdump had to drop.  Same accounting as
+	 * dpdk-dumpcap.  The client maps krnldrop to the "dropped by
+	 * kernel" count and ifdrop to interface drops, which pdump does
+	 * not distinguish, so the drops are reported as the former.
+	 */
+	if (s->capture_on && rte_pdump_stats(s->port, &ps) == 0) {
+		ifrecv = ps.accepted + ps.filtered;
+		dropped = ps.nombuf + ps.ringfull;
+	}
+
+	struct rpcap_stats reply = {
+		.ifrecv   = rte_cpu_to_be_32((uint32_t)ifrecv),
+		.ifdrop   = 0,
+		.krnldrop = rte_cpu_to_be_32((uint32_t)dropped),
+		.svrcapt  = rte_cpu_to_be_32(
+			rte_atomic_load_explicit(&s->npkt, rte_memory_order_relaxed)),
+	};
+	return rpcap_send_msg(c, RPCAP_MSG_STATS_REPLY, 0, &reply, sizeof(reply));
+}
diff --git a/examples/rpcapd/filter.c b/examples/rpcapd/filter.c
new file mode 100644
index 0000000000..74eda2089e
--- /dev/null
+++ b/examples/rpcapd/filter.c
@@ -0,0 +1,163 @@
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
+	if (rte_pdump_enable_bpf(s->port, RTE_PDUMP_ALL_QUEUES, s->pdump_flags,
+				 0, s->ring, s->mp, s->prm) < 0) {
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
diff --git a/examples/rpcapd/main.c b/examples/rpcapd/main.c
new file mode 100644
index 0000000000..b2c8e96142
--- /dev/null
+++ b/examples/rpcapd/main.c
@@ -0,0 +1,669 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ *
+ * Server for the rpcap protocol, which lets a libpcap client such as
+ * Wireshark or tcpdump use "rpcap://host[:port]/portname" as a capture
+ * device.
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
+#define POLL_INTERVAL_MS              500
+
+/* Command-line options */
+static uint16_t listen_port = RPCAP_DEFAULT_NETPORT;
+uint32_t ring_size = DEFAULT_RING_SIZE;
+static const char *lcore_arg;
+static const char *file_prefix;
+static const char *debug_file;		/* --debug-file argument */
+static unsigned int debug_log;		/* -D count: raise RPCAPD log verbosity */
+uint32_t send_timeout = DATA_SEND_TIMEOUT_SEC;	/* 0 means no limit */
+
+RTE_ATOMIC(bool) quit_signal;
+
+/* strtoul() that rejects an empty string and trailing garbage. */
+static unsigned long
+parse_number(const char *arg, const char *what)
+{
+	char *end;
+	unsigned long val;
+
+	errno = 0;
+	val = strtoul(arg, &end, 0);
+	if (errno != 0 || end == arg || *end != '\0')
+		rte_exit(EXIT_FAILURE, "Invalid %s: %s\n", what, arg);
+
+	return val;
+}
+
+/*
+ * Open a listening socket for every loopback address.  "localhost"
+ * normally gives both 127.0.0.1 and ::1 and a client may use either, so
+ * bind them all rather than picking one.  Returns the number of sockets.
+ *
+ * Only loopback is bound: the protocol has no authentication or
+ * encryption, so anything reachable from another host would expose all
+ * captured traffic.
+ */
+static unsigned int
+open_listen_sockets(uint16_t port, int *fds)
+{
+	static const char bind_addr[] = "localhost";
+	struct addrinfo hints = {
+		.ai_family   = AF_UNSPEC,
+		.ai_socktype = SOCK_STREAM,
+		.ai_flags    = AI_PASSIVE,
+	};
+	struct sockaddr_storage bound[MAX_LISTEN_SOCKETS];
+	struct addrinfo *res, *ai;
+	unsigned int n = 0;
+	int rc;
+
+	rc = getaddrinfo(bind_addr, NULL, &hints, &res);
+	if (rc != 0)
+		rte_exit(EXIT_FAILURE, "Cannot resolve '%s': %s\n",
+			 bind_addr, gai_strerror(rc));
+
+	for (ai = res; ai != NULL && n < MAX_LISTEN_SOCKETS; ai = ai->ai_next) {
+		struct sockaddr_storage addr;
+		char host[NI_MAXHOST];
+		unsigned int j;
+		int fd, one = 1;
+
+		/* Zeroed first: only ai_addrlen bytes are copied in and the
+		 * duplicate check below compares the whole structure.
+		 */
+		memset(&addr, 0, sizeof(addr));
+		memcpy(&addr, ai->ai_addr, ai->ai_addrlen);
+		set_sockaddr_port(&addr, port);
+
+		/* The resolver can return the same address twice, for
+		 * instance from both /etc/hosts and DNS; binding it again
+		 * would fail with EADDRINUSE.
+		 */
+		for (j = 0; j < n; j++)
+			if (memcmp(&bound[j], &addr, sizeof(addr)) == 0)
+				break;
+		if (j < n)
+			continue;
+		bound[n] = addr;
+
+		if (getnameinfo((struct sockaddr *)&addr, ai->ai_addrlen,
+				host, sizeof(host), NULL, 0, NI_NUMERICHOST) != 0)
+			snprintf(host, sizeof(host), "?");
+
+		fd = socket(ai->ai_family, SOCK_STREAM, 0);
+		if (fd < 0) {
+			/* A kernel booted with ipv6.disable=1 has no AF_INET6
+			 * at all; 127.0.0.1 is still usable.
+			 */
+			if (errno == EAFNOSUPPORT) {
+				RPCAPD_LOG(NOTICE, "skipping %s: %s",
+					   host, strerror(errno));
+				continue;
+			}
+			rte_exit(EXIT_FAILURE, "socket: %s\n", strerror(errno));
+		}
+
+		setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+
+		/* Do not let the v6 socket also answer for v4, which would
+		 * make it overlap with the 127.0.0.1 socket on the same port.
+		 */
+		if (ai->ai_family == AF_INET6)
+			setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &one, sizeof(one));
+
+		if (bind(fd, (struct sockaddr *)&addr, ai->ai_addrlen) < 0) {
+			/* The address resolved but is not configured, as
+			 * happens for ::1 with disable_ipv6 set on lo.
+			 */
+			if (errno == EADDRNOTAVAIL) {
+				RPCAPD_LOG(NOTICE, "skipping %s: %s",
+					   host, strerror(errno));
+				close(fd);
+				continue;
+			}
+			rte_exit(EXIT_FAILURE, "bind(%s port %u): %s\n",
+				 host, port, strerror(errno));
+		}
+
+		if (listen(fd, 1) < 0)
+			rte_exit(EXIT_FAILURE, "listen: %s\n", strerror(errno));
+
+		RPCAPD_LOG(NOTICE, "listening on %s port %u", host, port);
+
+		fds[n++] = fd;
+	}
+
+	if (ai != NULL)
+		RPCAPD_LOG(WARNING, "'%s' has more than %u addresses, ignoring the rest",
+			bind_addr, MAX_LISTEN_SOCKETS);
+
+	freeaddrinfo(res);
+
+	if (n == 0)
+		rte_exit(EXIT_FAILURE, "No address to listen on\n");
+
+	return n;
+}
+
+static void
+signal_handler(int sig __rte_unused)
+{
+	rte_atomic_store_explicit(&quit_signal, true, rte_memory_order_relaxed);
+}
+
+/*
+ * Wait for a connection on any listening socket and accept it.
+ *
+ * accept(2) reports an error pending on the new connection as if the
+ * accept() itself had failed; those are specific to that connection, so
+ * keep waiting instead of returning a failure the caller would have to
+ * classify.
+ */
+static int
+accept_any(const int *fds, unsigned int nfds)
+{
+	struct pollfd pfd[MAX_LISTEN_SOCKETS];
+	unsigned int i;
+
+	for (i = 0; i < nfds; i++) {
+		pfd[i].fd = fds[i];
+		pfd[i].events = POLLIN;
+	}
+
+	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
+		int rc = poll(pfd, nfds, POLL_INTERVAL_MS);
+
+		if (rc < 0) {
+			if (errno == EINTR)
+				continue;
+			RPCAPD_LOG(ERR, "poll failed: %s", strerror(errno));
+			return -1;
+		}
+
+		for (i = 0; i < nfds; i++) {
+			int fd;
+
+			if ((pfd[i].revents & POLLIN) == 0)
+				continue;
+
+			fd = accept(fds[i], NULL, NULL);
+			if (fd >= 0)
+				return fd;
+
+			switch (errno) {
+			case EINTR:
+			case EAGAIN:
+			case ECONNABORTED:
+			case EHOSTUNREACH:
+			case ENETDOWN:
+			case ENETUNREACH:
+			case ENOPROTOOPT:
+			case EPROTO:
+				RPCAPD_LOG(DEBUG, "accept: %s", strerror(errno));
+				break;
+			default:
+				RPCAPD_LOG(ERR, "accept: %s", strerror(errno));
+				return -1;
+			}
+		}
+	}
+	return -1;
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
+	/* Remembered so the data connection can be matched against it. */
+	if (getpeername(ctrl_fd, (struct sockaddr *)&peer, &peerlen) != 0) {
+		RPCAPD_LOG(ERR, "getpeername: %s", strerror(errno));
+		close(ctrl_fd);
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
+		/* While capturing, the data thread's exit is an event too:
+		 * the client may have dropped only the data connection.
+		 */
+		if (s.capture_on && wait_ctrl_or_data_exit(&ctrl, &s) == 0) {
+			RPCAPD_LOG(NOTICE, "data connection finished, ending session");
+			goto done;
+		}
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
+			    rpcap_send_error(&ctrl, PCAP_ERR_WRONGMSG,
+					     "unsupported request") < 0)
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
+
+static void
+usage(FILE *f, const char *progname)
+{
+	fprintf(f, "Usage: %s [options]\n", progname);
+	fprintf(f,
+		"  -p, --port <port>     listen port (default %u)\n"
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
+		"The listener is bound to the loopback addresses only: rpcap is\n"
+		"unauthenticated and unencrypted.\n",
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
+	while ((c = getopt_long(argc, argv, "hDp:N:",
+				long_options, &option_index)) != -1) {
+		switch (c) {
+		case 'p': {
+			unsigned long u = parse_number(optarg, "port");
+
+			if (u == 0 || u > UINT16_MAX)
+				rte_exit(EXIT_FAILURE, "Invalid port: %s\n", optarg);
+			listen_port = (uint16_t)u;
+			break;
+		}
+		case 'N': {
+			unsigned long u = parse_number(optarg, "ring size");
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
+			unsigned long u = parse_number(optarg, "send timeout");
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
+	return 0;
+}
+
+int
+main(int argc, char **argv)
+{
+	struct sigaction action = {
+		.sa_handler = signal_handler,
+	};
+	int srv_fds[MAX_LISTEN_SOCKETS];
+	unsigned int nsrv, i;
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
+	nsrv = open_listen_sockets(listen_port, srv_fds);
+
+	enable_primary_monitor();
+
+	while (!rte_atomic_load_explicit(&quit_signal, rte_memory_order_relaxed)) {
+		int cfd = accept_any(srv_fds, nsrv);
+
+		/* Per-connection failures are retried inside; anything
+		 * returned here is fatal or a quit signal.
+		 */
+		if (cfd < 0)
+			break;
+
+		handle_client(cfd);
+	}
+
+	disable_primary_monitor();
+	RPCAPD_LOG(NOTICE, "shutting down");
+	for (i = 0; i < nsrv; i++)
+		close(srv_fds[i]);
+
+	/* If the primary has exited, do not try to communicate with it. */
+	if (!rte_eal_primary_proc_alive(NULL))
+		return 0;
+
+	rte_pdump_uninit();
+	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
+}
diff --git a/examples/rpcapd/meson.build b/examples/rpcapd/meson.build
new file mode 100644
index 0000000000..76958969ba
--- /dev/null
+++ b/examples/rpcapd/meson.build
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+# meson file, for building this example as part of a main DPDK build.
+#
+# To build this example as a standalone application with an already-installed
+# DPDK instance, use 'make'
+
+# relies on primary/secondary process, so Linux only
+if not is_linux
+    build = false
+    subdir_done()
+endif
+
+if not dpdk_conf.has('RTE_HAS_LIBPCAP')
+    build = false
+    subdir_done()
+endif
+
+ext_deps += pcap_dep
+deps += ['pdump', 'bpf']
+sources = files(
+        'capture.c',
+        'filter.c',
+        'main.c',
+        'session.c',
+        'sock.c',
+)
diff --git a/examples/rpcapd/rpcap-protocol.h b/examples/rpcapd/rpcap-protocol.h
new file mode 100644
index 0000000000..0c261c980d
--- /dev/null
+++ b/examples/rpcapd/rpcap-protocol.h
@@ -0,0 +1,143 @@
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
+#define PCAP_ERR_WRONGMSG          16	/* request was not understood */
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
diff --git a/examples/rpcapd/rpcapd.h b/examples/rpcapd/rpcapd.h
new file mode 100644
index 0000000000..1b35322c3b
--- /dev/null
+++ b/examples/rpcapd/rpcapd.h
@@ -0,0 +1,119 @@
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
+#include <rte_thread.h>
+
+struct rte_bpf_prm;
+struct rte_mempool;
+struct rte_ring;
+
+#define RTE_LOGTYPE_RPCAPD RTE_LOGTYPE_USER1
+#define RPCAPD_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, RPCAPD, "%s(): ", __func__, __VA_ARGS__)
+
+/*
+ * Largest snaplen a client can be given, the classic pcap maximum.
+ * A client asking for more, as tcpdump does by default, gets this.
+ * Nothing can be captured above it anyway: an mbuf packet length is
+ * 32 bits but a port cannot deliver a frame this large to begin with.
+ * What the value does bound is how many mbuf segments one capture can
+ * span, which has to stay within the iovec budget of a single send.
+ */
+#define MAX_SNAPLEN		UINT16_MAX
+
+/* Used when a client asks for no limit. */
+#define DEFAULT_SNAPLEN		MAX_SNAPLEN
+
+/* A connection to the client. */
+struct conn {
+	int fd;
+};
+
+/*
+ * Per-client capture session state.
+ *
+ * While a capture runs the data connection belongs to a separate thread.
+ * The ring has no file descriptor, so one thread cannot wait for both
+ * packets and control requests without starving one of them.  Fields
+ * shared with that thread are marked; the rest are set before it starts
+ * and read-only while it runs.
+ */
+struct session {
+	struct conn data;			/* data connection (data thread) */
+	struct sockaddr_storage peer;		/* control connection peer */
+	uint16_t port;				/* DPDK ethdev port being captured */
+	char     name[RTE_ETH_NAME_MAX_LEN];
+	uint32_t snaplen;
+	RTE_ATOMIC(uint32_t) npkt;		/* shared: rpcap_pkthdr sequence */
+	uint32_t pdump_flags;			/* direction bits handed to pdump */
+	bool     opened;			/* OPEN_REQ has selected a port */
+	bool     capture_on;
+	bool     promisc_set;			/* we enabled promiscuous mode */
+	struct rte_ring    *ring;
+	struct rte_mempool *mp;
+	struct rte_bpf_prm *prm;		/* capture filter, NULL if none */
+
+	rte_thread_t     data_thread;		/* valid while data_running */
+	bool             data_running;
+	int              data_done_fd;		/* eventfd: data thread exited */
+	RTE_ATOMIC(bool) data_stop;		/* shared: asks it to finish */
+};
+
+/* Set once by the signal handler to unwind the main and capture loops. */
+extern RTE_ATOMIC(bool) quit_signal;
+
+/* Command-line settings needed outside of main.c */
+extern uint32_t ring_size;
+extern uint32_t send_timeout;		/* seconds; 0 means no limit */
+
+/* Largest number of addresses the listener will bind. */
+#define MAX_LISTEN_SOCKETS	8
+
+/* sock.c: transport and message framing */
+int wait_readable(const struct conn *c, int timeout_ms);
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
+int handle_startcap(const struct conn *c, uint32_t plen, struct session *s);
+int handle_endcap(const struct conn *c, uint32_t plen, struct session *s);
+int handle_stats(const struct conn *c, uint32_t plen, const struct session *s);
+void stop_capture(struct session *s);
+int start_data_thread(struct session *s);
+void stop_data_thread(struct session *s);
+int wait_ctrl_or_data_exit(const struct conn *ctrl, const struct session *s);
+
+#endif /* _RPCAPD_H_ */
diff --git a/examples/rpcapd/session.c b/examples/rpcapd/session.c
new file mode 100644
index 0000000000..cc14f26335
--- /dev/null
+++ b/examples/rpcapd/session.c
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
diff --git a/examples/rpcapd/sock.c b/examples/rpcapd/sock.c
new file mode 100644
index 0000000000..ff1dafb2cd
--- /dev/null
+++ b/examples/rpcapd/sock.c
@@ -0,0 +1,292 @@
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
+monotonic_ms(void)
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
+ * Accept the data connection only from the control peer's host.  This
+ * does not stop other local users: on loopback they all connect from
+ * the same address.  A mismatch is rejected and the wait continues.
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
+		start = monotonic_ms();
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
+			waited = monotonic_ms() - start;
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
-- 
2.53.0

