Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FAACC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 03:42:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6C9A402EF;
	Tue, 13 Oct 2026 05:41:53 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 9D672402C6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 05:41:50 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2e8da6ef7ddso7481805ad.3
 for <dev@dpdk.org>; Mon, 12 Oct 2026 20:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791862910;
 x=1792467710; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eK6R9TAePBQBXh33h67Pvmxgu9hPa/Dbr9lhIYLghdg=;
 b=y1oYtBa9toq7JYiQChyXgQzk16TmflEa7Kyug56pbAUu8hXVMYXRxOY/YUiy8zVZ/O
 sZYI0m3A20FK2E6yOexw10Mx04Qvy6EdxEz/M9ngc9iBwLp8HtailhNHsHTqvIolvGdf
 CPO8sUzOpdGVYOnTR2D5I3dHM2GOg6nGMrrozjelJfGgZ5NvD0E8SJaZjBC26x2LjlsH
 XeSYfWAMbRNGdDos/FoH25ekc2I9C7mVq+4bAcb/+codrbJVbHeo+o6aMB6DIBnNxCom
 pf0h798avdqMzh7a6hi0qBamArL2aSw6ujURSCSOIIf7JV/OvHE2JwLd4zKB5NUoHlMj
 MNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862910; x=1792467710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eK6R9TAePBQBXh33h67Pvmxgu9hPa/Dbr9lhIYLghdg=;
 b=Z1neUAKggqS0UIEFuXXCWUFxPLSWdUWZIm6mmp8rVmFETQjgdaFNV7QE7YyUVgKE0U
 xl4ZQTGxUlRgQVvH1zbOnLcbqYr46jy/7+Z3p6azVz/al8BAxOouoCaMnNdzkkGqVSn+
 UBc0iOBTnr+QK6O4PX9hZfoxLG8fOcsu3GILgBLYcnJag0ojzXjtB3DfzadSUzyQD+Sd
 2HbelUjjAZNYTkbCyL3IjqqM+WGjlw7cgKzMdptsepQffSl2OAoQPi7vxnMrGh/9wTKj
 gwXGxBR+GADeNMWpfXjnCMKgujxs8E2z1uS/9IsC9jhvDWjeVtvccelZH+vPkxEJ1CjO
 9etQ==
X-Gm-Message-State: AFq9FYKCllsJGAQqfBxWDA1XDOtKW26vJF72kWnGV4jObH9pUd7xhXeY
 xvWRJvdJUAOyoAocQIHSpNpa2R+PX37PD3TDYIKupGULpBP7JISD6WZpKaOprhaEzrHvLKCmQ0y
 twh0ErY8=
X-Gm-Gg: AYBFou29m5IgzvT/z+UvLLfc6NZESGF5c6LtYfN/3Qgad6svr42yAoPwdQmcwIMUCD+
 yFCtkfGco8lgzo1kc1Z7Xgl4L3Y/mZaJbx+wLAhYdqfOzir8GewpSYpe61XCvF0iNbqe/RXFn42
 CKchnpm6hRACYXCvDVr3I/T7dfCmDwwDX4rdE8u1TKkZzAj6n0jE85GriATb55y86fyF240QOgR
 FbSo+rVm8a8k9S5j7teHHyix+NRjRwPExM5FqSMyhmUj8ZowK/jydR3IkW8E/tnLr/Kk7BzG1aJ
 z+p+ZLxA7IYz8n+UQp4IC3N8rAGW36Phda/O2GG+J04c5YHJtsQIrICwynVSLhkAqDFRTGVyTiW
 ExcCPbV+yVdjPO3JyhkncvZyCEXk/YVv9ZEizQQk7Chy8aMwb1qa0rACYLXtVwOcmAN9R50o3SS
 3mW6N/MV5NPGQMt2PxNwaoPCeaWc0/V5Q6l3C1us2k8SqRRNJiUD82aT2+ujMEZKlDbw9vXUTYw
 0yxcdYeSh837ib7WP+W+s0UlhUN7h658sX/vg==
X-Received: by 2002:a17:90a:d006:b0:3a8:6a04:80ef with SMTP id
 98e67ed59e1d1-3ab3a2901c2mr7624484a91.6.1791862908952; 
 Mon, 12 Oct 2026 20:41:48 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab38ff0d34sm19928740a91.14.2026.10.12.20.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 20:41:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 1/3] capture: infrastructure wireshark packet capture
Date: Mon, 12 Oct 2026 20:41:03 -0700
Message-ID: <20261013034145.979361-2-stephen@networkplumber.org>
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

This provides a telemetry extension to provide packet capture.
It is intended to be used with a front end script to provide
external packet capture for wireshark.

Captures packets from both primary and secondary.
The notification mechanism is similar to what is already done in pdump.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                            |   1 +
 doc/guides/prog_guide/capture_lib.rst  | 159 +++++++
 doc/guides/prog_guide/index.rst        |   1 +
 doc/guides/rel_notes/release_26_11.rst |   4 +
 lib/capture/capture.c                  | 560 +++++++++++++++++++++++++
 lib/capture/datapath.c                 | 420 +++++++++++++++++++
 lib/capture/filter.c                   | 180 ++++++++
 lib/capture/meson.build                |  24 ++
 lib/capture/multiproc.c                | 246 +++++++++++
 lib/capture/output.c                   | 294 +++++++++++++
 lib/capture/private.h                  | 214 ++++++++++
 lib/meson.build                        |   1 +
 12 files changed, 2104 insertions(+)
 create mode 100644 doc/guides/prog_guide/capture_lib.rst
 create mode 100644 lib/capture/capture.c
 create mode 100644 lib/capture/datapath.c
 create mode 100644 lib/capture/filter.c
 create mode 100644 lib/capture/meson.build
 create mode 100644 lib/capture/multiproc.c
 create mode 100644 lib/capture/output.c
 create mode 100644 lib/capture/private.h

diff --git a/MAINTAINERS b/MAINTAINERS
index edc0cbc801..96adaebc1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1717,6 +1717,7 @@ F: doc/guides/sample_app_ug/qos_scheduler.rst
 Packet capture
 M: Reshma Pattan <reshma.pattan@intel.com>
 M: Stephen Hemminger <stephen@networkplumber.org>
+F: lib/capture/
 F: lib/pdump/
 F: doc/guides/prog_guide/pdump_lib.rst
 F: app/test/test_pdump.*
diff --git a/doc/guides/prog_guide/capture_lib.rst b/doc/guides/prog_guide/capture_lib.rst
new file mode 100644
index 0000000000..a9c9591bf2
--- /dev/null
+++ b/doc/guides/prog_guide/capture_lib.rst
@@ -0,0 +1,159 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Stephen Hemminger
+
+Packet Capture Library
+======================
+
+The capture library records packets going in and out of the Ethernet ports of a
+running DPDK primary process, and writes them in pcapng format to a FIFO.
+
+Unlike the older pdump library, no secondary process is involved and the
+application needs no source changes and no additional EAL arguments. The
+library registers itself at load time and is driven entirely over the
+:doc:`telemetry <telemetry_lib>` socket, so capture can be started on an
+already running application, including a sealed vendor appliance.
+
+Any telemetry client can drive it; see :doc:`../howto/telemetry` for the
+``dpdk-telemetry.py`` script used in the examples below.
+
+Operation
+---------
+
+When a capture is started the library installs Rx and Tx callbacks on the
+requested queues of the port. Each callback copies matching packets into a
+new mbuf already formatted as a pcapng Enhanced Packet Block
+(``rte_pcapng_copy``) and enqueues it on a ring. A dedicated capture thread
+drains that ring and writes the blocks to the output.
+The receive and transmit callbacks do not block, but the capture
+thread may block. The capture file is set into blocking mode so that if an
+external reader cannot keep up, the capture thread will block writing to FIFO.
+
+The callbacks copy the packet; the original mbuf is not modified and is
+returned to the datapath unchanged. Packets are dropped, and counted,
+if an mbuf cannot be allocated or if the ring is full.
+
+Several captures can be active at once, including on the same port and queue.
+Each has its own id, filter, ring, output and callbacks, and stopping one does
+not disturb the others. Each capture runs its own filter
+and copies the packets that match.
+
+Requirements
+------------
+
+* Capture can only be started in a primary process.
+
+* Filtering requires that DPDK was built with ``libpcap`` available. Without
+  it, a capture that specifies a filter will fail to start.
+
+* The library can be excluded from a build with
+  ``-Ddisable_libs=capture``.
+
+Telemetry commands
+------------------
+
+.. csv-table:: Capture telemetry commands
+   :header: "Command", "Parameters"
+   :widths: 30, 50
+
+   "``/ethdev/capture/start``", "port id and options, see below"
+   "``/ethdev/capture/stop``", "capture id"
+   "``/ethdev/capture/list``", "none"
+   "``/ethdev/capture/stats``", "capture id"
+
+``/ethdev/capture/start`` takes the port id as its first parameter, followed by
+``name=value`` options separated by commas:
+
+``out=<path>``
+   Required. Path of the output, which must already exist and be a FIFO.
+
+``snaplen=<n>``
+   Number of bytes to capture from each packet. Default is 262144;
+   ``snaplen=0`` means capture the whole packet.
+
+``queue=<n>``
+   Capture only this hardware queue. Default is all queues of the port.
+
+``filter=<expression>``
+   A libpcap filter expression, compiled to eBPF and run over each packet.
+
+Because the parameter string is split on commas, neither the output path nor
+the filter expression may contain one.
+
+On success the reply contains the capture ``id``, which is used to stop the
+capture and to query its statistics. On failure the reply contains an
+``error`` string. The whole parameter string is limited to 1024 bytes.
+
+.. note::
+
+   The telemetry commands for capture are experimental
+   and may change without warning in future releases.
+
+Output
+------
+
+The output must be an existing FIFO, otherwise the capture fails to start.
+Only a FIFO is allowed because the application opens the path itself: writing
+to a regular file would let a capture request create or truncate a file with
+the privileges of the application.
+
+The reader must have the FIFO open already, so that the capture thread does
+not block waiting for one.
+
+A capture runs until ``/ethdev/capture/stop`` is called,
+or an error is detected such as when the reader of a FIFO goes away.
+
+Statistics
+----------
+
+``/ethdev/capture/stats`` reports the configuration of a capture and the
+following counters, summed over all queues:
+
+``accepted``
+   Packets copied for capture.
+
+``filtered``
+   Packets rejected by the filter.
+
+``nombuf``
+   Packets missed because no mbuf was available for the copy.
+
+``ringfull``
+   Packets missed because the capture thread was not keeping up.
+
+The same values are mapped onto the Interface Statistics Block written at the
+end of the capture: ``ifrecv`` is the number of packets seen, ``filteraccept``
+the subset that passed the filter, and ``ifdrop`` the packets that were lost.
+
+Example
+-------
+
+Normally the capture API is driven by an external capture program, but it can
+be tested using ``dpdk-telemetry.py`` against a running application.
+
+An example, capturing TCP traffic on port 0. Create the FIFO and start a
+reader on it first, for example ``tshark -r /tmp/port0.fifo``, since the
+capture fails to start if the FIFO has no reader::
+
+   --> /ethdev/capture/start,0,out=/tmp/port0.fifo,snaplen=128,filter=tcp
+   {"/ethdev/capture/start": {"id": 0, "status": "running"}}
+
+   --> /ethdev/capture/stats,0
+   {"/ethdev/capture/stats": {"port_id": 0, "filter": "tcp", "running": 1, \
+    "snaplen": 128, "rx_queues": 4, "tx_queues": 4, "accepted": 1200, \
+    "filtered": 87, "nombuf": 0, "ringfull": 0}}
+
+   --> /ethdev/capture/stop,0
+   {"/ethdev/capture/stop": {"status": "stopped"}}
+
+Limitations
+-----------
+
+* Only the primary process can start and stop a capture. Packets handled by a
+  secondary are included, and its counters appear in the statistics, but a
+  secondary started after the capture began is missed until it is restarted.
+
+* Each capture covers a single port. Capturing several ports means starting
+  several captures.
+
+* Captured packets are those seen by the ethdev layer, so packets dropped by
+  the hardware or the driver do not appear.
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index b9c0d59728..7e869db132 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -129,6 +129,7 @@ Utility Libraries
     log_lib
     metrics_lib
     telemetry_lib
+    capture_lib
     pdump_lib
     pcapng_lib
     bpf_lib
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index a6df347411..bc1d62d423 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -163,6 +163,10 @@ New Features
   Added ``rte_bbdev_queue_stats_get()`` function to retrieve statistics
   for a specific queue, complementing the existing device-level statistics API.
 
+* **Added wireshark capture support.**
+
+  * New ``capture`` library for packet capture accessed via telemetry API.
+
 
 Removed Items
 -------------
diff --git a/lib/capture/capture.c b/lib/capture/capture.c
new file mode 100644
index 0000000000..e8a9d4b485
--- /dev/null
+++ b/lib/capture/capture.c
@@ -0,0 +1,560 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <net/if.h>
+#include <poll.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/queue.h>
+#include <sys/stat.h>
+#include <sys/utsname.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_errno.h>
+#include <rte_ethdev.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_memory.h>
+#include <rte_mempool.h>
+#include <rte_mbuf.h>
+#include <rte_pcapng.h>
+#include <rte_pause.h>
+#include <rte_ring.h>
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+#include <rte_string_fns.h>
+#include <rte_telemetry.h>
+#include <rte_thread.h>
+#include <rte_version.h>
+
+#include "private.h"
+
+#define CAPTURE_EXTCAP_PREFIX	"dpdk"
+#define CAP_CMD_MAX		1024
+#define DEFAULT_SNAPLEN		262144u	/* from tcpdump et.al. */
+#define MBUF_POOL_CACHE_SIZE	32
+#define CAPTURE_RING_SIZE	256
+#define CAPTURE_POOL_SIZE	1024
+#define SLEEP_THRESHOLD		100
+#define SLEEP_US		100
+
+RTE_LOG_REGISTER_DEFAULT(rte_capture_logtype, NOTICE);
+
+/*
+ * Active captures owned by this process. Control plane only, touched from the
+ * telemetry handler and the drain threads but never the dataplane, so a plain
+ * spinlock is enough.
+ *
+ * Only the creator has a capture on this list; the drain thread, output file
+ * and ring lifetime all belong to it. A secondary reaches a capture through
+ * the pointer in the IPC request, so no shared tailq is needed.
+ */
+static struct capture_list capture_list = TAILQ_HEAD_INITIALIZER(capture_list);
+rte_spinlock_t capture_lock = RTE_SPINLOCK_INITIALIZER;
+
+
+/* Parameter values: only used on stack inside parsing */
+struct capture_config {
+	uint16_t port_id;
+	uint16_t queue;
+	uint32_t snaplen;
+	const char *filter_str;
+	const char *output;
+};
+
+/* Helper that returns error to telemetry and logs it */
+static void __rte_format_printf(2, 3)
+capture_err(struct rte_tel_data *d, const char *format, ...)
+{
+	va_list ap;
+	char msg[1024];
+
+	va_start(ap, format);
+	vsnprintf(msg, sizeof(msg), format, ap);
+	va_end(ap);
+
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_string(d, "error", msg);
+
+	CAPTURE_LOG(NOTICE, "%s", msg);
+}
+
+static int
+parse_uint32(const char *str, uint32_t *result, uint32_t limit)
+{
+	unsigned long val;
+	char *endp;
+
+	errno = 0;
+	val = strtoul(str, &endp, 10);
+	if (errno != 0 || *endp != '\0' || val >= limit)
+		return -1;
+
+	*result = val;
+	return 0;
+}
+
+/*
+ * Break the comma separated parameter string into tokens
+ * and fill in the capture config structure.
+ *
+ * Does not use rte_kvargs because that would mangle [] etc in filter expression.
+ */
+static int
+parse_params(char *str, struct capture_config *cfg, struct rte_tel_data *d)
+{
+	uint32_t snaplen = DEFAULT_SNAPLEN;
+	char *args[8];
+	int nargs;
+
+	/* Need at least the port id */
+	nargs = rte_strsplit(str, strlen(str), args, RTE_DIM(args), ',');
+	if (nargs < 1) {
+		capture_err(d, "missing parameters '%s'", str);
+		return -1;
+	}
+
+	/* Parse port id (required) */
+	uint32_t port_id;
+	if (parse_uint32(args[0], &port_id, RTE_MAX_ETHPORTS) < 0) {
+		capture_err(d, "invalid port_id='%s'", args[0]);
+		return -1;
+	}
+
+	/* parse remainder as name=value parameters */
+	for (int i = 1; i < nargs; i++) {
+		char *key = args[i];
+
+		/* split at the = */
+		char *eq = strchr(args[i], '=');
+
+		/* all current options require argument after = */
+		if (eq == NULL || eq[1] == '\0') {
+			capture_err(d,  "missing value for '%s'", key);
+			return -1;
+		}
+		*eq = '\0';
+		char *value = eq + 1;
+
+		if (strcmp(key, "out") == 0) {
+			cfg->output = value;
+		} else if (strcmp(key, "filter") == 0) {
+			cfg->filter_str = value;
+		} else if (strcmp(key, "queue") == 0) {
+			uint32_t q;
+
+			if (parse_uint32(value, &q, RTE_MAX_QUEUES_PER_PORT) < 0) {
+				capture_err(d, "invalid queue '%s'", value);
+				return -1;
+			}
+			cfg->queue = q;
+		} else if (strcmp(key, "snaplen") == 0) {
+			if (parse_uint32(value, &snaplen, UINT32_MAX) < 0) {
+				capture_err(d, "invalid snaplen '%s'", value);
+				return -1;
+			}
+		} else {
+			capture_err(d, "unknown parameter '%s'", key);
+			return -1;
+		}
+	}
+
+	if (cfg->output == NULL) {
+		capture_err(d, "missing output parameter");
+		return -1;
+	}
+
+	cfg->port_id = port_id;
+
+	/*
+	 * Default is 256K from tcpdump legacy
+	 * using snaplen=0 means everything.
+	 */
+	cfg->snaplen = snaplen > 0 ? snaplen : UINT32_MAX;
+	return 0;
+}
+
+static void
+capture_link(struct capture *cap)
+{
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_INSERT_TAIL(&capture_list, cap, next);
+	rte_spinlock_unlock(&capture_lock);
+}
+
+void
+capture_unlink(struct capture *cap)
+{
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_REMOVE(&capture_list, cap, next);
+	rte_spinlock_unlock(&capture_lock);
+}
+
+void
+capture_free(struct capture *cap)
+{
+	if (cap == NULL)
+		return;
+
+	free(cap->output);
+	__rte_capture_filter_free(cap->filter);
+	rte_ring_free(cap->ring);
+	rte_mempool_free(cap->mp);
+	rte_free(cap);
+}
+
+/* Generate unique id for naming and telemetry */
+static unsigned int
+get_unique_id(void)
+{
+	static RTE_ATOMIC(unsigned int) capture_instance;
+
+	return rte_atomic_fetch_add_explicit(&capture_instance, 1, rte_memory_order_relaxed);
+}
+
+/*
+ * Convert configuration into running state
+ */
+static struct capture *
+capture_alloc(const struct capture_config *cfg,
+	      const struct rte_eth_dev_info *dev_info,
+	      struct rte_tel_data *d)
+{
+	struct capture *cap;
+	char ring_name[RTE_RING_NAMESIZE];
+	uint16_t mbuf_size;
+
+	/* try and put capture data struct on same node as device. */
+	int socket_id = rte_eth_dev_socket_id(cfg->port_id);
+	if (socket_id < 0)
+		socket_id = SOCKET_ID_ANY;
+
+	uint16_t num_queues = dev_info->nb_tx_queues + dev_info->nb_rx_queues;
+	size_t cb_size = sizeof(*cap) + num_queues * sizeof(cap->cbs[0]);
+	cap = rte_zmalloc_socket("capture", cb_size, RTE_CACHE_LINE_SIZE, socket_id);
+	if (cap == NULL) {
+		capture_err(d, "Could not allocate capture struct");
+		goto error;
+	}
+
+	rte_spinlock_init(&cap->cbs_lock);
+	TAILQ_INIT(&cap->attached);
+
+	cap->idx = get_unique_id();
+	snprintf(ring_name, sizeof(ring_name), "capture-%u", cap->idx);
+	cap->ring = rte_ring_create(ring_name, CAPTURE_RING_SIZE, socket_id, 0);
+	if (cap->ring == NULL) {
+		capture_err(d, "Could not create ring");
+		goto error;
+	}
+
+	/*
+	 * If snapshot length is smaller than one mbuf segment then pool
+	 * element size can be reduced; otherwise can just use the default
+	 * and rte_pktmbuf_copy handle multiple segments.
+	 */
+	if (cfg->snaplen < RTE_MBUF_DEFAULT_BUF_SIZE)
+		mbuf_size = rte_pcapng_mbuf_size(cfg->snaplen);
+	else
+		mbuf_size = RTE_MBUF_DEFAULT_BUF_SIZE;
+
+	cap->mp = rte_pktmbuf_pool_create_by_ops(ring_name, CAPTURE_POOL_SIZE,
+						 MBUF_POOL_CACHE_SIZE, 0, mbuf_size,
+						 socket_id, "ring_mp_mc");
+	if (cap->mp == NULL) {
+		capture_err(d,  "Could not create mempool");
+		goto error;
+	}
+
+	if (cfg->filter_str) {
+		cap->filter = __rte_capture_filter_create(cfg->filter_str);
+		if (cap->filter == NULL) {
+			capture_err(d,  "Could not compile filter: %s", cfg->filter_str);
+			goto error;
+		}
+	}
+
+	cap->port_id = cfg->port_id;
+	cap->output = strdup(cfg->output);
+	if (cap->output == NULL) {
+		capture_err(d, "Could not strdup '%s'", cfg->output);
+		goto error;
+	}
+	rte_atomic_store_explicit(&cap->running, true, rte_memory_order_relaxed);
+	cap->snaplen = cfg->snaplen;
+	cap->queue = cfg->queue;
+	cap->socket_id = socket_id;
+	cap->tx_queues = dev_info->nb_tx_queues;
+	cap->rx_queues = dev_info->nb_rx_queues;
+
+	return cap;
+
+error:
+	capture_free(cap);
+	return NULL;
+}
+/*
+ * Callback handler for telemetry library to start capture.
+ *
+ * Need to handle: <iface>,snaplen=<n>,filter=<str>
+ */
+static int
+capture_start_req(const char *cmd, const char *params, struct rte_tel_data *d)
+{
+	struct capture *cap = NULL;
+	struct capture_config cfg = { .queue = ALL_QUEUES };
+	struct rte_eth_dev_info dev_info;
+
+	if (params == NULL || *params == '\0') {
+		CAPTURE_LOG(ERR, "missing parameters");
+		return -1;
+	}
+
+	CAPTURE_LOG(DEBUG, "telemetry: %s %s", cmd, params);
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		CAPTURE_LOG(ERR, "capture can only be started from primary");
+		return -1;
+	}
+
+	/* Note: params is const so need non-const copy for parsing
+	 * Alternative would be to change telemetry to allow this.
+	 */
+	char tmp[CAP_CMD_MAX];
+	if (strlcpy(tmp, params, CAP_CMD_MAX) >= CAP_CMD_MAX) {
+		CAPTURE_LOG(ERR, "params too long");
+		return -1;
+	}
+
+	if (parse_params(tmp, &cfg, d) < 0)
+		return 0;
+
+	/* Lookup number of queues etc, also validates port_id */
+	if (rte_eth_dev_info_get(cfg.port_id, &dev_info) < 0) {
+		capture_err(d, "can not get info for port %u", cfg.port_id);
+		return 0;
+	}
+
+	if (cfg.queue != ALL_QUEUES &&
+	    cfg.queue >= RTE_MAX(dev_info.nb_rx_queues, dev_info.nb_tx_queues)) {
+		capture_err(d, "queue %d out of range", cfg.queue);
+		return 0;
+	}
+
+	struct stat sb;
+	if (lstat(cfg.output, &sb) < 0) {
+		capture_err(d, "output %s:%s", cfg.output, strerror(errno));
+		return 0;
+	}
+
+	if (!is_fifo(&sb)) {
+		capture_err(d, "output %s is not empty", cfg.output);
+		return 0;
+	}
+
+	cap = capture_alloc(&cfg, &dev_info, d);
+	if (cap == NULL)
+		return 0;
+
+	if (capture_add_callbacks(cap) < 0) {
+		capture_err(d, "can not register callbacks");
+		goto error_callback_remove;
+	}
+
+	/*
+	 * Have the secondaries attach to their own queues. A secondary that
+	 * cannot is reported but does not fail the capture: what this process
+	 * sees is still captured.
+	 */
+	if (capture_mp_broadcast(cap, CAPTURE_MP_START) < 0)
+		CAPTURE_LOG(NOTICE, "capture %u: not all secondaries attached", cap->idx);
+
+	/*
+	 * Publish into the active list before starting the drain thread so the
+	 * thread is guaranteed to find itself there when it removes itself on
+	 * exit (it may exit immediately, e.g. if the FIFO reader is already
+	 * gone). On thread-create failure we undo the insertion here.
+	 */
+	uint32_t idx = cap->idx;
+	capture_link(cap);
+
+	/*
+	 * Make a new thread to do the capture work
+	 * Thread will inherit affinity from the telemetry handler that calls us
+	 */
+	rte_thread_t thread_id;
+	int ret = rte_thread_create(&thread_id, NULL, capture_thread, cap);
+	if (ret != 0) {
+		capture_err(d, "thread start failed: %s", strerror(ret));
+		goto error_unlink;
+	}
+
+	rte_thread_detach(thread_id);
+
+	/* Return id back for later use. */
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_uint(d, "id", idx);
+	rte_tel_data_add_dict_string(d, "status", "running");
+	return 0;
+
+error_unlink:
+	/* the drain thread never ran, so undo the attach here */
+	if (capture_mp_broadcast(cap, CAPTURE_MP_STOP) < 0) {
+		CAPTURE_LOG(ERR,
+			    "capture %u: secondary still attached, leaking ring and pool",
+			    cap->idx);
+		capture_unlink(cap);
+		capture_remove_callbacks(cap);
+		return 0;
+	}
+	capture_unlink(cap);
+error_callback_remove:
+	capture_remove_callbacks(cap);
+	capture_free(cap);
+
+	/* return 0 since error reported "error":"XXX" in response */
+	return 0;
+}
+
+/* Telemetry: stop active capture. */
+static int
+capture_stop_req(const char *cmd, const char *params, struct rte_tel_data *d)
+{
+	if (params == NULL || *params == '\0') {
+		CAPTURE_LOG(ERR, "missing parameters");
+		return -1;
+	}
+
+	CAPTURE_LOG(DEBUG, "telemetry %s %s", cmd, params);
+
+	uint32_t idx;
+	if (parse_uint32(params, &idx, UINT32_MAX) < 0) {
+		capture_err(d, "invalid capture index '%s'", params);
+		return 0;
+	}
+
+	rte_spinlock_lock(&capture_lock);
+	struct capture *cap;
+	TAILQ_FOREACH(cap, &capture_list, next) {
+		if (cap->idx == idx)
+			break;
+	}
+	if (cap == NULL) {
+		rte_spinlock_unlock(&capture_lock);
+		CAPTURE_LOG(DEBUG, "capture index %" PRIu32 " not found", idx);
+		return 0;
+	}
+
+	rte_atomic_store_explicit(&cap->running, false, rte_memory_order_relaxed);
+	rte_spinlock_unlock(&capture_lock);
+
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_string(d, "status", "stopped");
+	return 0;
+}
+
+/* Telemetry: list the ids of all active captures. */
+static int
+capture_list_req(const char *cmd __rte_unused, const char *params __rte_unused,
+		 struct rte_tel_data *d)
+{
+	struct capture *cap;
+
+	CAPTURE_LOG(DEBUG, "telemetry %s", cmd);
+	rte_tel_data_start_array(d, RTE_TEL_UINT_VAL);
+
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_FOREACH(cap, &capture_list, next)
+		rte_tel_data_add_array_uint(d, cap->idx);
+	rte_spinlock_unlock(&capture_lock);
+
+	return 0;
+}
+
+
+/* Telemetry: report configuration and counters for one capture. */
+static int
+capture_stats_req(const char *cmd, const char *params,
+		  struct rte_tel_data *d)
+{
+	struct capture *cap;
+	struct capture_total t;
+
+	if (params == NULL || *params == '\0') {
+		CAPTURE_LOG(ERR, "missing parameters");
+		return -1;
+	}
+
+	CAPTURE_LOG(DEBUG, "telemetry %s %s", cmd, params);
+
+	uint32_t idx;
+	if (parse_uint32(params, &idx, UINT32_MAX) < 0) {
+		capture_err(d, "invalid capture index '%s'", params);
+		return 0;
+	}
+
+	/* Find the instance and snapshot what we need while holding the lock. */
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_FOREACH(cap, &capture_list, next) {
+		if (cap->idx == idx)
+			break;
+	}
+	if (cap == NULL) {
+		rte_spinlock_unlock(&capture_lock);
+		capture_err(d, "capture index %" PRIu32 " not found", idx);
+		return 0;
+	}
+
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_uint(d, "port_id", cap->port_id);
+	if (cap->filter)
+		rte_tel_data_add_dict_string(d, "filter",
+					     __rte_capture_filter_string(cap->filter));
+	rte_tel_data_add_dict_int(d, "running",
+				  rte_atomic_load_explicit(&cap->running,
+							   rte_memory_order_relaxed));
+	rte_tel_data_add_dict_uint(d, "snaplen", cap->snaplen);
+	rte_tel_data_add_dict_uint(d, "rx_queues", cap->rx_queues);
+	rte_tel_data_add_dict_uint(d, "tx_queues", cap->tx_queues);
+	/* cbs_lock nests inside capture_lock, never the other way round */
+	rte_spinlock_lock(&cap->cbs_lock);
+	capture_sum_stats(cap, &t);
+	rte_spinlock_unlock(&cap->cbs_lock);
+	rte_spinlock_unlock(&capture_lock);
+
+	rte_tel_data_add_dict_uint(d, "accepted", t.accepted);
+	rte_tel_data_add_dict_uint(d, "filtered", t.filtered);
+	rte_tel_data_add_dict_uint(d, "nombuf", t.nombuf);
+	rte_tel_data_add_dict_uint(d, "ringfull", t.ringfull);
+
+	return 0;
+}
+
+RTE_INIT(capture_telemetry)
+{
+	capture_mp_register();
+
+	rte_telemetry_register_cmd("/ethdev/capture/list", capture_list_req,
+		"List ids of active captures. Takes no parameters.");
+	rte_telemetry_register_cmd("/ethdev/capture/stats", capture_stats_req,
+		"Report configuration and counters for a capture. Parameters: id");
+	rte_telemetry_register_cmd("/ethdev/capture/start", capture_start_req,
+		"Start capture. Parameters: "
+		"port_id,out=<fifo>,snaplen=N(optional),queue=N(optional),filter=string(optional)");
+	rte_telemetry_register_cmd("/ethdev/capture/stop", capture_stop_req,
+				   "Stop an active capture. Parameters: id");
+}
diff --git a/lib/capture/datapath.c b/lib/capture/datapath.c
new file mode 100644
index 0000000000..68d8c71f46
--- /dev/null
+++ b/lib/capture/datapath.c
@@ -0,0 +1,420 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+/*
+ * Datapath side of capture: the ethdev callbacks that copy packets into the
+ * ring, and the callback blocks they run on.
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/queue.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_common.h>
+#include <rte_debug.h>
+#include <rte_ethdev.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
+#include <rte_pcapng.h>
+#include <rte_ring.h>
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+
+#include "private.h"
+
+/*
+ * Idle blocks, guarded by capture_lock. A block is here when no capture owns
+ * it; they are never freed. Per-process, since cb and stale only mean
+ * anything in the process that registered the ethdev callback.
+ */
+static struct capture_cb_list capture_cb_freelist =
+	TAILQ_HEAD_INITIALIZER(capture_cb_freelist);
+
+
+/*
+ * Detach a callback block and wait for the datapath to let go of it.
+ */
+static void
+capture_cb_detach(struct capture_rxtx_cb *cbs)
+{
+	/* detach the callback */
+	rte_atomic_store_explicit(&cbs->cap, NULL, rte_memory_order_relaxed);
+
+	/* the store of cap must be visible before the use_count load below */
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+	/* wait until no reader is inside */
+	RTE_WAIT_UNTIL_MASKED(&cbs->use_count, UINT32_MAX, ==, 0, rte_memory_order_acquire);
+}
+
+/*
+ * Reader increment use count.
+ *
+ * Pairs with check in capture_cb_detach.
+ */
+static inline void
+capture_cb_hold(struct capture_rxtx_cb *cbs)
+{
+	rte_atomic_fetch_add_explicit(&cbs->use_count, 1, rte_memory_order_seq_cst);
+}
+
+/* Reader done */
+static inline void
+capture_cb_release(struct capture_rxtx_cb *cbs)
+{
+	rte_atomic_fetch_sub_explicit(&cbs->use_count, 1, rte_memory_order_release);
+}
+
+/*
+ * Create a clone of mbuf to be placed into ring.
+ * Note: for case of lockfree transmit statistics may not be correct due to races.
+ */
+static inline void
+capture_copy_burst(uint16_t port_id, uint16_t queue_id,
+		   enum rte_pcapng_direction direction,
+		   struct rte_mbuf **pkts, unsigned int nb_pkts,
+		   const struct capture *cap,
+		   const struct capture_filter_prog *prog,
+		   struct capture_stats *stats)
+{
+	unsigned int i, ring_enq, d_pkts = 0;
+	struct rte_mbuf *dup_bufs[CAPTURE_BURST_SIZE]; /* duplicated packets */
+	struct rte_ring *ring = cap->ring;
+	struct rte_mempool *mp = cap->mp;
+	uint32_t snaplen = cap->snaplen;
+	struct rte_mbuf *p;
+
+	RTE_ASSERT(nb_pkts <= CAPTURE_BURST_SIZE);
+
+	for (i = 0; i < nb_pkts; i++) {
+		/*
+		 * This uses same BPF return value convention as socket filter
+		 * and pcap_offline_filter. If program returns zero then packet
+		 * doesn't match the filter (will be ignored).
+		 */
+		if (prog != NULL) {
+			if (__rte_capture_filter(prog, pkts[i]) == 0) {
+				stats->filtered++;
+				continue;
+			}
+		}
+
+		p = rte_pcapng_copy(port_id, queue_id, pkts[i], mp, snaplen, direction, NULL);
+		if (unlikely(p == NULL))
+			stats->nombuf++;
+		else
+			dup_bufs[d_pkts++] = p;
+	}
+
+	if (d_pkts == 0)
+		return;
+
+	stats->accepted += d_pkts;
+
+	ring_enq = rte_ring_enqueue_burst(ring, (void *)&dup_bufs[0], d_pkts, NULL);
+	if (unlikely(ring_enq < d_pkts)) {
+		unsigned int drops = d_pkts - ring_enq;
+
+		stats->ringfull += drops;
+		rte_pktmbuf_free_bulk(&dup_bufs[ring_enq], drops);
+	}
+}
+
+/* Create a clone of mbuf to be placed into ring. */
+static inline void
+capture_copy(uint16_t port_id, uint16_t queue_id,
+	     enum rte_pcapng_direction direction,
+	     struct rte_mbuf **pkts, uint16_t nb_pkts,
+	     const struct capture *cap,
+	     const struct capture_filter_prog *prog,
+	     struct capture_stats *stats)
+{
+	unsigned int offs = 0;
+
+	do {
+		unsigned int n = RTE_MIN(nb_pkts - offs, CAPTURE_BURST_SIZE);
+
+		capture_copy_burst(port_id, queue_id, direction, &pkts[offs], n,
+				   cap, prog, stats);
+		offs += n;
+	} while (offs < nb_pkts);
+}
+
+static uint16_t
+capture_rx(uint16_t port, uint16_t queue,
+	struct rte_mbuf **pkts, uint16_t nb_pkts,
+	uint16_t max_pkts __rte_unused, void *user_params)
+{
+	struct capture_rxtx_cb *cbs = user_params;
+	const struct capture *cap;
+
+	capture_cb_hold(cbs);
+	cap = rte_atomic_load_explicit(&cbs->cap, rte_memory_order_seq_cst);
+	if (likely(cap != NULL))
+		capture_copy(port, queue, RTE_PCAPNG_DIRECTION_IN,
+			     pkts, nb_pkts, cap, cbs->prog, &cbs->stats);
+
+	capture_cb_release(cbs);
+
+	return nb_pkts;
+}
+
+static uint16_t
+capture_tx(uint16_t port, uint16_t queue,
+	   struct rte_mbuf **pkts, uint16_t nb_pkts, void *user_params)
+{
+	struct capture_rxtx_cb *cbs = user_params;
+	const struct capture *cap;
+
+	capture_cb_hold(cbs);
+	cap = rte_atomic_load_explicit(&cbs->cap, rte_memory_order_seq_cst);
+	if (likely(cap != NULL))
+		capture_copy(port, queue, RTE_PCAPNG_DIRECTION_OUT,
+			     pkts, nb_pkts, cap, cbs->prog, &cbs->stats);
+
+	capture_cb_release(cbs);
+
+	return nb_pkts;
+}
+
+
+/*
+ * Take an idle block for a port/queue/direction, allocating one if all are in
+ * use. Several captures may cover a queue, each with its own filter and
+ * callback, so this hands out one block per capture.
+ */
+static struct capture_rxtx_cb *
+capture_cb_get(struct capture *cap, uint16_t queue, bool is_rx)
+{
+	struct capture_rxtx_cb *cbs;
+
+	rte_spinlock_lock(&capture_lock);
+
+	TAILQ_FOREACH(cbs, &capture_cb_freelist, next) {
+		if (cbs->port_id == cap->port_id && cbs->queue == queue &&
+		    cbs->is_rx == is_rx) {
+			TAILQ_REMOVE(&capture_cb_freelist, cbs, next);
+			break;
+		}
+	}
+
+	rte_spinlock_unlock(&capture_lock);
+
+	if (cbs == NULL) {
+		cbs = rte_zmalloc_socket("capture_cb", sizeof(*cbs),
+					 RTE_CACHE_LINE_SIZE, cap->socket_id);
+		if (cbs == NULL)
+			return NULL;
+		cbs->port_id = cap->port_id;
+		cbs->queue = queue;
+		cbs->is_rx = is_rx;
+	}
+
+	return cbs;
+}
+
+/* Hand a detached block back for reuse. */
+static void
+capture_cb_put(struct capture_rxtx_cb *cbs)
+{
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_INSERT_TAIL(&capture_cb_freelist, cbs, next);
+	rte_spinlock_unlock(&capture_lock);
+}
+
+/*
+ * Install one callback, on a block that is now ours.
+ *
+ * Returns the block so the caller can record it for detach; the block is also
+ * linked into the capture's shared attached list for stats.
+ */
+static struct capture_rxtx_cb *
+capture_attach(struct capture *cap, uint16_t queue, bool is_rx,
+	       struct capture_filter_prog *prog)
+{
+	struct capture_rxtx_cb *cbs;
+
+	cbs = capture_cb_get(cap, queue, is_rx);
+	if (cbs == NULL) {
+		CAPTURE_LOG(ERR, "No callback block for %u:%u %s",
+			    cap->port_id, queue, is_rx ? "rx" : "tx");
+		return NULL;
+	}
+
+	/* the block may have been used by an earlier capture of this queue */
+	memset(&cbs->stats, 0, sizeof(cbs->stats));
+
+	/* one program per process per capture, shared by its queues */
+	cbs->prog = prog;
+
+	/*
+	 * Release the object left by an earlier capture. It cannot be freed at
+	 * removal time because ethdev reads cb->next after the callback
+	 * returns; deferring to the next attach puts a whole session between.
+	 */
+	rte_free((void *)(uintptr_t)cbs->stale);
+	cbs->stale = NULL;
+
+	/* publish before the callback can be reached by the datapath */
+	rte_atomic_store_explicit(&cbs->cap, cap, rte_memory_order_release);
+
+	if (is_rx)
+		cbs->cb = rte_eth_add_rx_callback(cap->port_id, queue, capture_rx, cbs);
+	else
+		cbs->cb = rte_eth_add_tx_callback(cap->port_id, queue, capture_tx, cbs);
+
+	if (cbs->cb == NULL) {
+		rte_atomic_store_explicit(&cbs->cap, NULL, rte_memory_order_relaxed);
+		capture_cb_put(cbs);
+		CAPTURE_LOG(ERR, "Register %s callback for %u:%u failed",
+			    is_rx ? "rx" : "tx", cap->port_id, queue);
+		return NULL;
+	}
+
+	rte_spinlock_lock(&cap->cbs_lock);
+	TAILQ_INSERT_TAIL(&cap->attached, cbs, attached);
+	rte_spinlock_unlock(&cap->cbs_lock);
+
+	return cbs;
+}
+
+/*
+ * Install callbacks on every queue this capture covers, recording them in
+ * cbs[] for detach. A secondary passes its own array.
+ *
+ * The filter program is per-process, so it is loaded here and returned in
+ * *progp; the caller passes it to capture_detach_queues() to release.
+ */
+int
+capture_attach_queues(struct capture *cap, struct capture_rxtx_cb **cbs, uint16_t *nb_cbs,
+		      struct capture_filter_prog **progp)
+{
+	struct capture_filter_prog *prog = NULL;
+
+	if (cap->filter != NULL) {
+		prog = __rte_capture_filter_load(cap->filter);
+		if (prog == NULL) {
+			/*
+			 * Attaching without the filter would put unwanted
+			 * packets in the capture file, so do not attach.
+			 */
+			CAPTURE_LOG(ERR, "Could not load filter for port %u",
+				    cap->port_id);
+			return -1;
+		}
+	}
+	*progp = prog;
+
+	for (uint16_t q = 0; q < cap->tx_queues; q++) {
+		if (cap->queue != ALL_QUEUES && cap->queue != q)
+			continue;
+
+		cbs[*nb_cbs] = capture_attach(cap, q, false, prog);
+		if (cbs[*nb_cbs] == NULL)
+			return -1;
+		++*nb_cbs;
+	}
+
+	for (uint16_t q = 0; q < cap->rx_queues; q++) {
+		if (cap->queue != ALL_QUEUES && cap->queue != q)
+			continue;
+
+		cbs[*nb_cbs] = capture_attach(cap, q, true, prog);
+		if (cbs[*nb_cbs] == NULL)
+			return -1;
+		++*nb_cbs;
+	}
+	return 0;
+}
+
+/* Install callbacks of the process that created the capture. */
+int
+capture_add_callbacks(struct capture *cap)
+{
+	return capture_attach_queues(cap, cap->cbs, &cap->nb_cbs, &cap->prog);
+}
+
+static void
+capture_sum_one(struct capture_total *t, const struct capture_stats *s)
+{
+	t->accepted += s->accepted;
+	t->filtered += s->filtered;
+	t->nombuf   += s->nombuf;
+	t->ringfull += s->ringfull;
+}
+
+/*
+ * Sum the counters of the queues still attached, in any process, plus those
+ * already detached. Caller holds cap->cbs_lock.
+ */
+void
+capture_sum_stats(const struct capture *cap, struct capture_total *t)
+{
+	const struct capture_rxtx_cb *cbs;
+
+	*t = cap->total;
+
+	TAILQ_FOREACH(cbs, &cap->attached, attached)
+		capture_sum_one(t, &cbs->stats);
+}
+
+/*
+ * Detach the blocks this process attached and hand them back for reuse.
+ *
+ * Once this returns no datapath thread in this process can reach the capture.
+ * The blocks themselves stay behind for the next capture on the same queue.
+ */
+void
+capture_detach_queues(struct capture *cap, struct capture_rxtx_cb **cbs, uint16_t *nb_cbs,
+		      struct capture_filter_prog *prog)
+{
+	for (uint16_t i = 0; i < *nb_cbs; i++) {
+		struct capture_rxtx_cb *cb = cbs[i];
+
+		if (cb->is_rx)
+			rte_eth_remove_rx_callback(cap->port_id, cb->queue, cb->cb);
+		else
+			rte_eth_remove_tx_callback(cap->port_id, cb->queue, cb->cb);
+
+		/* freed by the next capture that attaches to this queue */
+		cb->stale = cb->cb;
+		cb->cb = NULL;
+
+		capture_cb_detach(cb);
+		cb->prog = NULL;
+	}
+
+	/*
+	 * The blocks leave the capture, so fold their counters into the total
+	 * first: whoever picks them up next zeroes the stats.
+	 */
+	rte_spinlock_lock(&cap->cbs_lock);
+	for (uint16_t i = 0; i < *nb_cbs; i++) {
+		capture_sum_one(&cap->total, &cbs[i]->stats);
+		TAILQ_REMOVE(&cap->attached, cbs[i], attached);
+	}
+	rte_spinlock_unlock(&cap->cbs_lock);
+
+	rte_spinlock_lock(&capture_lock);
+	for (uint16_t i = 0; i < *nb_cbs; i++)
+		TAILQ_INSERT_TAIL(&capture_cb_freelist, cbs[i], next);
+	rte_spinlock_unlock(&capture_lock);
+
+	*nb_cbs = 0;
+
+	/* no datapath thread can reach the program now */
+	__rte_capture_filter_unload(prog);
+}
+
+/* Cleanup callbacks of the process that created the capture. */
+void
+capture_remove_callbacks(struct capture *cap)
+{
+	capture_detach_queues(cap, cap->cbs, &cap->nb_cbs, cap->prog);
+	cap->prog = NULL;
+}
diff --git a/lib/capture/filter.c b/lib/capture/filter.c
new file mode 100644
index 0000000000..9820845fc5
--- /dev/null
+++ b/lib/capture/filter.c
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <pcap/pcap.h>
+
+#include <rte_bpf.h>
+#include <rte_errno.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_string_fns.h>
+
+#include "private.h"
+
+/*
+ * Compiled filter, split in two because of where rte_bpf puts things.
+ * rte_bpf_convert() returns the eBPF instructions in rte_malloc memory, which
+ * is shared and position independent and references no external symbols.
+ * rte_bpf_load() puts the rte_bpf object in a MAP_PRIVATE mapping and the JIT
+ * output has to be privately executable, so neither can be shared.
+ *
+ * The instructions are therefore compiled once, by whoever starts the
+ * capture, and each process loads its own program from them. Only the process
+ * doing the compile needs libpcap.
+ */
+struct rte_capture_filter {
+	struct ebpf_insn *ins;	/* eBPF program, shared */
+	uint32_t nb_ins;
+	char expr[];		/* original filter text */
+};
+
+/* Per-process loaded form of the above, not shared. */
+struct capture_filter_prog {
+	struct rte_bpf *bpf;
+	struct rte_bpf_jit jit;
+};
+
+/*
+ * Convert text string into an eBPF program
+ */
+struct rte_capture_filter *
+__rte_capture_filter_create(const char *filter)
+{
+	struct rte_bpf_prm *prm = NULL;
+
+	/* libpcap needs a handle */
+	pcap_t *pcap = pcap_open_dead(DLT_EN10MB, UINT16_MAX);
+	if (!pcap) {
+		CAPTURE_LOG(ERR, "pcap: can not open handle");
+		return NULL;
+	}
+
+	size_t filter_len = strlen(filter) + 1;
+	struct rte_capture_filter *flt;
+	flt = rte_zmalloc("capture_filter", sizeof(*flt) + filter_len, 0);
+	if (flt == NULL) {
+		CAPTURE_LOG(ERR, "could not allocate for filter");
+		goto error;
+	}
+
+	/* convert string to cBPF program */
+	struct bpf_program bf;
+	if (pcap_compile(pcap, &bf, filter, 1, PCAP_NETMASK_UNKNOWN) != 0) {
+		CAPTURE_LOG(ERR, "pcap: can not compile filter: %s",
+			    pcap_geterr(pcap));
+		goto error;
+	}
+	strlcpy(flt->expr, filter, filter_len);
+
+	/* convert cBPF to eBPF */
+	prm = rte_bpf_convert(&bf);
+	pcap_freecode(&bf); /* drop the cBPF program */
+
+	if (prm == NULL)  {
+		CAPTURE_LOG(ERR, "BPF convert interface %s(%d)",
+			    rte_strerror(rte_errno), rte_errno);
+		goto error;
+	}
+
+	/*
+	 * Keep the instructions in shared memory. Only the primary has libpcap
+	 * do the compile; every process loads the result from here.
+	 */
+	flt->ins = rte_malloc("capture_filter_ins",
+			      prm->nb_ins * sizeof(*flt->ins), 0);
+	if (flt->ins == NULL) {
+		CAPTURE_LOG(ERR, "could not allocate for filter program");
+		goto error;
+	}
+	memcpy(flt->ins, prm->ins, prm->nb_ins * sizeof(*flt->ins));
+	flt->nb_ins = prm->nb_ins;
+
+	pcap_close(pcap);
+	rte_free(prm);
+	return flt;
+
+error:
+	pcap_close(pcap);
+	rte_free(prm);
+	if (flt != NULL)
+		rte_free(flt->ins);
+	rte_free(flt);
+	return NULL;
+}
+
+/*
+ * Load the shared program into this process. The JIT-ed code and the rte_bpf
+ * object are process private mappings, so each process that runs the filter
+ * needs its own.
+ */
+struct capture_filter_prog *
+__rte_capture_filter_load(const struct rte_capture_filter *filter)
+{
+	struct rte_bpf_prm prm = {
+		.ins = filter->ins,
+		.nb_ins = filter->nb_ins,
+		.prog_arg = {
+			.type = RTE_BPF_ARG_PTR_MBUF,
+			.size = sizeof(struct rte_mbuf),
+		},
+	};
+	struct capture_filter_prog *prog;
+
+	prog = calloc(1, sizeof(*prog));
+	if (prog == NULL) {
+		CAPTURE_LOG(ERR, "could not allocate filter program");
+		return NULL;
+	}
+
+	prog->bpf = rte_bpf_load(&prm);
+	if (prog->bpf == NULL) {
+		CAPTURE_LOG(ERR, "BPF load failed: %s(%d)",
+			    rte_strerror(rte_errno), rte_errno);
+		free(prog);
+		return NULL;
+	}
+
+	rte_bpf_get_jit(prog->bpf, &prog->jit);
+	if (prog->jit.func == NULL)
+		CAPTURE_LOG(NOTICE, "No JIT available for filter");
+
+	return prog;
+}
+
+void
+__rte_capture_filter_unload(struct capture_filter_prog *prog)
+{
+	if (prog == NULL)
+		return;
+
+	rte_bpf_destroy(prog->bpf);
+	free(prog);
+}
+
+const char *__rte_capture_filter_string(struct rte_capture_filter *filter)
+{
+	return filter ? filter->expr : NULL;
+}
+
+void __rte_capture_filter_free(struct rte_capture_filter *filter)
+{
+	if (filter == NULL)
+		return;
+
+	rte_free(filter->ins);
+	rte_free(filter);
+}
+
+uint64_t __rte_capture_filter(const struct capture_filter_prog *prog, struct rte_mbuf *mb)
+{
+	if (prog->jit.func)
+		return prog->jit.func(mb);
+	else
+		return rte_bpf_exec(prog->bpf, mb);
+}
diff --git a/lib/capture/meson.build b/lib/capture/meson.build
new file mode 100644
index 0000000000..f6a3b3a1f8
--- /dev/null
+++ b/lib/capture/meson.build
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+if is_windows
+    build = false
+    reason = 'not supported on Windows'
+    subdir_done()
+endif
+
+sources = files(
+        'capture.c',
+        'datapath.c',
+        'multiproc.c',
+        'output.c',
+)
+
+deps += ['ethdev', 'pcapng', 'bpf']
+
+if dpdk_conf.has('RTE_HAS_LIBPCAP')
+    sources += files('filter.c')
+    ext_deps += pcap_dep
+else
+    warning('libpcap is missing, capture filtering will be disabled')
+endif
diff --git a/lib/capture/multiproc.c b/lib/capture/multiproc.c
new file mode 100644
index 0000000000..b37882bd94
--- /dev/null
+++ b/lib/capture/multiproc.c
@@ -0,0 +1,246 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+/*
+ * Multi-process support.
+ *
+ * The ethdev callback lists are per-process, so the primary passes the capture
+ * to the other processes over EAL IPC and each attaches to its own queues.
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/queue.h>
+
+#include <rte_eal.h>
+#include <rte_errno.h>
+#include <rte_ethdev.h>
+#include <rte_log.h>
+#include <rte_spinlock.h>
+#include <rte_string_fns.h>
+
+#include "private.h"
+
+/* IPC endpoint used to tell secondaries to attach/detach their callbacks. */
+#define CAPTURE_MP		"mp_capture"
+#define CAPTURE_MP_VERSION	1
+#define CAPTURE_MP_TIMEOUT_S	1
+
+struct capture_mp_request {
+	uint16_t version;
+	uint16_t op;
+	/*
+	 * Capture in shared memory. Valid in every process because it comes
+	 * from rte_zmalloc; the secondary only reads the datapath fields and
+	 * never the creator's (output, drain thread state).
+	 */
+	struct capture *cap;
+};
+
+struct capture_mp_response {
+	uint16_t version;
+	uint16_t op;
+	int32_t err;
+};
+
+
+/*
+ * Callbacks this process attached to a capture created elsewhere.
+ *
+ * A secondary cannot record its blocks in cap->cbs[], which is sized for one
+ * process's queues, so it keeps them here. Guarded by capture_lock.
+ */
+struct capture_secondary {
+	TAILQ_ENTRY(capture_secondary) next;
+	struct capture *cap;
+	struct capture_filter_prog *prog;
+	uint16_t nb_cbs;
+	struct capture_rxtx_cb *cbs[];
+};
+
+static TAILQ_HEAD(, capture_secondary) capture_secondary_list =
+	TAILQ_HEAD_INITIALIZER(capture_secondary_list);
+
+/* Attach this process's callbacks to a capture owned by the primary. */
+static int
+capture_mp_attach(struct capture *cap)
+{
+	struct capture_secondary *sec;
+	struct rte_eth_dev_info dev_info;
+	uint16_t num_queues;
+
+	if (rte_eth_dev_info_get(cap->port_id, &dev_info) < 0)
+		return -EINVAL;
+
+	/*
+	 * Queue counts come from this process's view of the device: it is the
+	 * one registering the callbacks.
+	 */
+	num_queues = dev_info.nb_tx_queues + dev_info.nb_rx_queues;
+	sec = calloc(1, sizeof(*sec) + num_queues * sizeof(sec->cbs[0]));
+	if (sec == NULL)
+		return -ENOMEM;
+
+	sec->cap = cap;
+	if (capture_attach_queues(cap, sec->cbs, &sec->nb_cbs, &sec->prog) < 0) {
+		capture_detach_queues(cap, sec->cbs, &sec->nb_cbs, sec->prog);
+		free(sec);
+		return -ENOBUFS;
+	}
+
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_INSERT_TAIL(&capture_secondary_list, sec, next);
+	rte_spinlock_unlock(&capture_lock);
+
+	return 0;
+}
+
+/* Detach this process's callbacks from a capture owned by the primary. */
+static int
+capture_mp_detach(struct capture *cap)
+{
+	struct capture_secondary *sec;
+
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_FOREACH(sec, &capture_secondary_list, next) {
+		if (sec->cap == cap) {
+			TAILQ_REMOVE(&capture_secondary_list, sec, next);
+			break;
+		}
+	}
+	rte_spinlock_unlock(&capture_lock);
+
+	if (sec == NULL)
+		return -ENOENT;
+
+	capture_detach_queues(cap, sec->cbs, &sec->nb_cbs, sec->prog);
+	free(sec);
+	return 0;
+}
+
+/*
+ * Runs on the IPC thread, but attaching sends nothing, so unlike pdump there
+ * is no need to defer to the interrupt thread.
+ */
+static int
+capture_mp_handler(const struct rte_mp_msg *msg, const void *peer)
+{
+	const struct capture_mp_request *req;
+	struct rte_mp_msg reply = { };
+	struct capture_mp_response *resp = (struct capture_mp_response *)reply.param;
+
+	resp->err = -EINVAL;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		/* the primary sends these and attaches its own callbacks */
+		resp->err = -EPERM;
+	} else if (msg->len_param != sizeof(*req)) {
+		CAPTURE_LOG(ERR, "Invalid capture request length %d", msg->len_param);
+	} else {
+		req = (const struct capture_mp_request *)msg->param;
+
+		if (req->version != CAPTURE_MP_VERSION) {
+			CAPTURE_LOG(ERR, "Unsupported capture request version %u",
+				    req->version);
+		} else {
+			resp->version = req->version;
+			resp->op = req->op;
+
+			switch (req->op) {
+			case CAPTURE_MP_START:
+				resp->err = capture_mp_attach(req->cap);
+				break;
+			case CAPTURE_MP_STOP:
+				resp->err = capture_mp_detach(req->cap);
+				break;
+			default:
+				CAPTURE_LOG(ERR, "Unknown capture op %u", req->op);
+			}
+		}
+	}
+
+	rte_strscpy(reply.name, CAPTURE_MP, sizeof(reply.name));
+	reply.len_param = sizeof(*resp);
+
+	return rte_mp_reply(&reply, peer);
+}
+
+/*
+ * Registered from the constructor so no rte_pdump_init() equivalent is needed.
+ * Only inserts into a list, so it is safe this early.
+ *
+ * The process type is not yet known here (it defaults to primary until EAL
+ * init parses the arguments), so both ends register and the handler rejects
+ * a request that arrives in the sending process.
+ */
+void
+capture_mp_register(void)
+{
+	if (rte_mp_action_register(CAPTURE_MP, capture_mp_handler) < 0 &&
+	    rte_errno != ENOTSUP)
+		CAPTURE_LOG(NOTICE, "Could not register ipc action: %s",
+			    rte_strerror(rte_errno));
+}
+
+/*
+ * Must not be called holding a lock, the reply timeout is in seconds.
+ * On stop the result decides whether the ring can be freed.
+ */
+int
+capture_mp_broadcast(struct capture *cap, enum capture_mp_op op)
+{
+	struct rte_mp_msg msg = { };
+	struct capture_mp_request *req = (struct capture_mp_request *)msg.param;
+	struct rte_mp_reply mp_reply = { };
+	struct timespec ts = { .tv_sec = CAPTURE_MP_TIMEOUT_S };
+	int ret;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	req->version = CAPTURE_MP_VERSION;
+	req->op = op;
+	req->cap = cap;
+
+	rte_strscpy(msg.name, CAPTURE_MP, sizeof(msg.name));
+	msg.len_param = sizeof(*req);
+
+	if (rte_mp_request_sync(&msg, &mp_reply, &ts) != 0) {
+		/* no secondary running at all is the common case */
+		if (rte_errno == ENOTSUP)
+			return 0;
+
+		CAPTURE_LOG(ERR, "Capture %s request failed: %s",
+			    op == CAPTURE_MP_START ? "start" : "stop",
+			    rte_strerror(rte_errno));
+		return -1;
+	}
+
+	ret = 0;
+	for (int i = 0; i < mp_reply.nb_received; i++) {
+		const struct capture_mp_response *resp
+			= (const struct capture_mp_response *)mp_reply.msgs[i].param;
+
+		/*
+		 * A secondary that has no callbacks to detach replies ENOENT,
+		 * which happens whenever it was not polling this port.
+		 */
+		if (resp->err != 0 && resp->err != -ENOENT) {
+			CAPTURE_LOG(ERR, "Secondary could not %s capture: %s",
+				    op == CAPTURE_MP_START ? "start" : "stop",
+				    rte_strerror(-resp->err));
+			ret = -1;
+		}
+	}
+
+	if (mp_reply.nb_received != mp_reply.nb_sent) {
+		CAPTURE_LOG(ERR, "Only %u of %u secondaries replied",
+			    mp_reply.nb_received, mp_reply.nb_sent);
+		ret = -1;
+	}
+
+	free(mp_reply.msgs);
+	return ret;
+}
diff --git a/lib/capture/output.c b/lib/capture/output.c
new file mode 100644
index 0000000000..9a52703d8e
--- /dev/null
+++ b/lib/capture/output.c
@@ -0,0 +1,294 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+/*
+ * Output side of capture: opening the pcapng stream, and the per-capture
+ * thread that drains the ring into it.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <net/if.h>
+#include <poll.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/queue.h>
+#include <sys/stat.h>
+#include <sys/utsname.h>
+#include <unistd.h>
+
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_ethdev.h>
+#include <rte_log.h>
+#include <rte_mbuf.h>
+#include <rte_pcapng.h>
+#include <rte_pause.h>
+#include <rte_ring.h>
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+#include <rte_thread.h>
+#include <rte_version.h>
+
+#include "private.h"
+
+/*
+ * Create the file handle for pcapng output
+ * Note: can't really tell wireshark about errors since this in an
+ * independent thread.
+ */
+static rte_pcapng_t *
+capture_pcapng_open(const char *path, int *fd, uint16_t port_id, const char *filter)
+{
+	rte_pcapng_t *pcapng = NULL;
+	char port_name[RTE_ETH_NAME_MAX_LEN];
+	char appname[128];
+	char ifname[IFNAMSIZ];
+	char *ifdescr = NULL;
+	struct utsname uts;
+	char *osname = NULL;
+
+	/* OS name is optional, just keep going if not found */
+	if (uname(&uts) == 0 && asprintf(&osname, "%s %s", uts.sysname, uts.release) < 0)
+		osname = NULL;
+
+	/* add DPDK internal name */
+	if (rte_eth_dev_get_name_by_port(port_id, port_name) != 0) {
+		CAPTURE_LOG(NOTICE, "Could not find port name for %u", port_id);
+		goto cleanup;
+	}
+
+	/* match name convention used by dpdk-wireshark-extcap */
+	snprintf(ifname, sizeof(ifname), CAPTURE_EXTCAP_PREFIX ":%u", port_id);
+	if (asprintf(&ifdescr, "DPDK %s", port_name) < 0)
+		ifdescr = NULL;
+
+	/* mirror what other applications do for name */
+	snprintf(appname, sizeof(appname), CAPTURE_EXTCAP_PREFIX " (%s)", rte_version());
+
+	/*
+	 * Open the output in non-block mode in case it is a FIFO without a reader.
+	 * Wireshark must open the read end before asking us to capture.
+	 */
+	*fd = open(path, O_WRONLY | O_CLOEXEC | O_NOFOLLOW | O_NONBLOCK);
+	if (*fd < 0) {
+		CAPTURE_LOG(ERR, "Could not open %s: %s", path, strerror(errno));
+		goto cleanup;
+	}
+
+	/* recheck that it is ok to use */
+	struct stat sb;
+	if (fstat(*fd, &sb) < 0 || !is_fifo(&sb)) {
+		CAPTURE_LOG(ERR, "Not safe to use %s", path);
+		goto close_fd;
+	}
+
+	/* writes in the drain loop should block normally */
+	int flags = fcntl(*fd, F_GETFL, 0);
+	if (flags < 0 || fcntl(*fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
+		CAPTURE_LOG(ERR, "fcntl %s: %s",  path,  strerror(errno));
+		goto close_fd;
+	}
+
+	/* put pcapng header on and setup */
+	pcapng = rte_pcapng_fdopen(*fd, osname, NULL, appname, NULL);
+	if (pcapng == NULL) {
+		CAPTURE_LOG(ERR, "Add section block failed");
+		goto close_fd;
+	}
+
+	if (rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB, ifname, ifdescr, filter) < 0) {
+		CAPTURE_LOG(ERR, "Add interface for port %u:%s failed", port_id, ifname);
+		rte_pcapng_close(pcapng);  /* closes fd */
+		pcapng = NULL;
+	}
+	goto cleanup;
+
+close_fd:
+	close(*fd);
+cleanup:
+	free(osname);
+	free(ifdescr);
+	return pcapng;
+}
+
+
+
+static void
+capture_write_stats(rte_pcapng_t *pcapng, struct capture *cap)
+{
+	struct capture_total t;
+
+	rte_spinlock_lock(&cap->cbs_lock);
+	capture_sum_stats(cap, &t);
+	rte_spinlock_unlock(&cap->cbs_lock);
+
+	/* TODO: extend pcapng to have more stats */
+	rte_pcapng_write_stats(pcapng, cap->port_id,
+			       t.accepted + t.filtered + t.nombuf, /* ifrecv */
+			       t.nombuf + t.ringfull, /* ifdrop */
+			       NULL);
+}
+
+/* Check that output file is still ok to write (i.e FIFO not closed).
+ * Used to detect when wireshark has exited, and idle.
+ */
+static int
+check_fifo_status(int fd)
+{
+	struct pollfd pfd = { .fd = fd };
+
+	if (poll(&pfd, 1, 0) < 0) {
+		CAPTURE_LOG(ERR, "poll failed: %s", strerror(errno));
+		return -1;
+	}
+	if (pfd.revents & (POLLERR | POLLHUP | POLLNVAL)) {
+		CAPTURE_LOG(NOTICE, "fifo reader closed");
+		return -1;
+	}
+	return 0;
+}
+
+static ssize_t
+capture_process_ring(struct rte_ring *ring, rte_pcapng_t *pcapng,
+		     unsigned int *available)
+{
+	struct rte_mbuf *pkts[CAPTURE_BURST_SIZE];
+	unsigned int n;
+	ssize_t written;
+
+	n = rte_ring_sc_dequeue_burst(ring, (void **) pkts,
+				      CAPTURE_BURST_SIZE, available);
+	if (n == 0)
+		return 0;
+
+	written = rte_pcapng_write_packets(pcapng, pkts, n);
+	rte_pktmbuf_free_bulk(pkts, n);
+
+	return written;
+}
+
+static void
+capture_flush_ring(struct rte_ring *ring)
+{
+	for (;;) {
+		struct rte_mbuf *pkts[CAPTURE_BURST_SIZE];
+		unsigned int n;
+
+		n = rte_ring_sc_dequeue_burst(ring, (void **) pkts,
+					      CAPTURE_BURST_SIZE, NULL);
+		if (n == 0)
+			break;
+
+		rte_pktmbuf_free_bulk(pkts, n);
+	}
+}
+
+/* The capture thread that moves packets from ring to the pcapng out */
+uint32_t __rte_hot
+capture_thread(void *arg)
+{
+	struct capture *cap = arg;
+	unsigned int empty_count = 0;
+	bool reader_gone = false;
+	bool orphaned = false;
+	int fd = -1;
+
+	CAPTURE_LOG(INFO, "capture thread starting");
+
+	char name[RTE_THREAD_NAME_SIZE];
+	snprintf(name, sizeof(name), "cap-%u", cap->idx);
+	rte_thread_set_prefixed_name(rte_thread_self(), name);
+
+	/* This thread wants to detect when file gets closed (for FIFO) */
+	sigset_t set;
+	sigemptyset(&set);
+	sigaddset(&set, SIGPIPE);
+	pthread_sigmask(SIG_BLOCK, &set, NULL);
+
+	rte_pcapng_t *pcapng = capture_pcapng_open(cap->output, &fd, cap->port_id,
+						   __rte_capture_filter_string(cap->filter));
+	if (pcapng == NULL) {
+		/* secondaries attached before this thread started */
+		if (capture_mp_broadcast(cap, CAPTURE_MP_STOP) < 0)
+			orphaned = true;
+		capture_remove_callbacks(cap);
+		goto error;
+	}
+
+	while (rte_atomic_load_explicit(&cap->running, rte_memory_order_relaxed)) {
+		ssize_t written;
+		unsigned int avail;
+
+		written = capture_process_ring(cap->ring, pcapng, &avail);
+		if (written < 0) {
+			if (errno == EPIPE)
+				CAPTURE_LOG(DEBUG, "FIFO closed by reader");
+			else
+				CAPTURE_LOG(ERR, "write to file failed: %s", strerror(errno));
+
+			reader_gone = true;
+			break;
+		}
+
+		if (written > 0) {
+			/* are there more packets? */
+			empty_count = (avail == 0);
+		} else if (empty_count < SLEEP_THRESHOLD) {
+			/* spin a few times before checking */
+			++empty_count;
+			rte_pause();
+		} else if (check_fifo_status(fd) == 0) {
+			/* avoid consuming 100% CPU polling */
+			rte_delay_us_sleep(SLEEP_US);
+		} else {
+			/* output FIFO has closed */
+			reader_gone = true;
+			break;
+		}
+	}
+
+	/*
+	 * Secondaries must stop first, they enqueue into the ring freed below.
+	 * Their counters are in shared blocks, so still counted in the stats.
+	 */
+	CAPTURE_LOG(INFO, "capture thread stopping");
+	if (capture_mp_broadcast(cap, CAPTURE_MP_STOP) < 0)
+		orphaned = true;
+	capture_remove_callbacks(cap);
+
+	/* Process residual */
+	if (reader_gone)
+		capture_flush_ring(cap->ring);
+	else {
+		while (capture_process_ring(cap->ring, pcapng, NULL) > 0)
+			continue;
+
+		capture_write_stats(pcapng, cap);
+	}
+
+	rte_pcapng_close(pcapng);
+
+error:
+	capture_unlink(cap);
+	if (orphaned) {
+		/*
+		 * A secondary did not confirm that it detached, so it may still
+		 * be inside a burst holding this capture. Freeing the ring it
+		 * writes into would corrupt that process, so leak instead.
+		 */
+		CAPTURE_LOG(ERR,
+			    "capture %u: secondary still attached, leaking ring and pool",
+			    cap->idx);
+	} else {
+		capture_free(cap);
+	}
+
+	return 0;
+}
diff --git a/lib/capture/private.h b/lib/capture/private.h
new file mode 100644
index 0000000000..97ecfa5bba
--- /dev/null
+++ b/lib/capture/private.h
@@ -0,0 +1,214 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+#ifndef CAPTURE_PRIVATE_H
+#define CAPTURE_PRIVATE_H
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <sys/queue.h>
+#include <sys/stat.h>
+
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+
+#define RTE_LOGTYPE_CAPTURE rte_capture_logtype
+extern int rte_capture_logtype;
+#define CAPTURE_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, CAPTURE, "%s(): ", __func__, __VA_ARGS__)
+
+/* Shared between the control, datapath, output and multi-process parts. */
+#define ALL_QUEUES		UINT16_MAX
+#define CAPTURE_BURST_SIZE	32u
+#define CAPTURE_EXTCAP_PREFIX	"dpdk"
+#define SLEEP_THRESHOLD		100
+#define SLEEP_US		100
+
+/* Per port/queue/direction counters. */
+struct capture_stats {
+	uint64_t accepted;	/**< Number of packets accepted by filter. */
+	uint64_t filtered;	/**< Number of packets rejected by filter. */
+	uint64_t nombuf;	/**< Number of mbuf allocation failures. */
+	uint64_t ringfull;	/**< Number of missed packets due to ring full. */
+};
+
+/* Aggregate per-queue counters of a capture instance. */
+struct capture_total {
+	uint64_t accepted;
+	uint64_t filtered;
+	uint64_t nombuf;
+	uint64_t ringfull;
+};
+
+/*
+ * Callback data, one per capture per port/queue/direction.
+ *
+ * Never freed, as in lib/bpf/bpf_pkt.c: rte_eth_remove_{rx,tx}_callback()
+ * only unlinks, so a datapath thread can still enter the callback afterwards
+ * and needs something valid to synchronize on. Recycled only by a later
+ * capture of the same port/queue/direction.
+ */
+struct __rte_cache_aligned capture_rxtx_cb {
+	/* used by both data and control path */
+	RTE_ATOMIC(uint32_t) use_count;
+	RTE_ATOMIC(struct capture *) cap;	/* owner, NULL when idle */
+	struct capture_stats stats;
+
+	/* owner's attached list, guarded by cap->cbs_lock; this is how the
+	 * primary sees a secondary's counters. Separate from 'next' because an
+	 * idle block is on the free list at the same time.
+	 */
+	TAILQ_ENTRY(capture_rxtx_cb) attached;
+
+	/* filter loaded by this process, NULL if the capture has none */
+	struct capture_filter_prog *prog;
+
+	/* used by control path only, in the process that attached this block */
+	TAILQ_ENTRY(capture_rxtx_cb) next;	/* links into capture_cb_freelist */
+	const struct rte_eth_rxtx_callback *cb;
+	const struct rte_eth_rxtx_callback *stale;
+	uint16_t port_id;
+	uint16_t queue;
+	bool is_rx;
+};
+
+/*
+ * Idle callback blocks, guarded by capture_lock. Per-process: cb and stale
+ * are only meaningful in the process that registered the ethdev callback.
+ */
+TAILQ_HEAD(capture_cb_list, capture_rxtx_cb);
+
+/*
+ * Per-capture state, in shared memory. A secondary gets this pointer in the
+ * IPC request. It must not follow filter (process-private eBPF) or touch the
+ * creator-only fields marked below.
+ */
+struct capture {
+	RTE_ATOMIC(bool) running;
+	struct rte_capture_filter *filter;
+	struct rte_ring *ring;		/* ring from dataplane to capture thread */
+	struct rte_mempool *mp;		/* mempool for capture mbufs */
+
+	uint32_t snaplen;		/* amount of data to copy */
+	uint16_t queue;
+	uint16_t tx_queues;
+	uint16_t rx_queues;
+	uint16_t port_id;
+	int socket_id;
+
+	uint32_t idx;
+	char *output;			/* filename of out, creator only */
+
+	TAILQ_ENTRY(capture) next;	/* links into capture_list, creator only */
+
+	/* blocks attached by any process, so the lock cannot be capture_lock */
+	rte_spinlock_t cbs_lock;
+	struct capture_cb_list attached;
+
+	/* counters of queues already detached; guarded by cbs_lock */
+	struct capture_total total;
+
+	/* what this process attached; sized for one process's queues, so a
+	 * secondary keeps its own record. Creator only.
+	 */
+	struct capture_filter_prog *prog;
+	uint16_t nb_cbs;
+	struct capture_rxtx_cb *cbs[];
+};
+
+/* Captures owned by this process. The lock also guards the cb free list. */
+TAILQ_HEAD(capture_list, capture);
+extern rte_spinlock_t capture_lock;
+
+/* The application may be privileged and extcap not, so only write to a FIFO. */
+static inline bool
+is_fifo(const struct stat *stb)
+{
+	return S_ISFIFO(stb->st_mode);
+}
+
+/* datapath.c */
+int capture_attach_queues(struct capture *cap, struct capture_rxtx_cb **cbs,
+			  uint16_t *nb_cbs, struct capture_filter_prog **progp);
+void capture_detach_queues(struct capture *cap, struct capture_rxtx_cb **cbs,
+			   uint16_t *nb_cbs, struct capture_filter_prog *prog);
+int capture_add_callbacks(struct capture *cap);
+void capture_remove_callbacks(struct capture *cap);
+void capture_sum_stats(const struct capture *cap, struct capture_total *t);
+
+/* capture.c */
+void capture_unlink(struct capture *cap);
+void capture_free(struct capture *cap);
+
+/* output.c */
+uint32_t capture_thread(void *arg);
+
+/* multiproc.c */
+enum capture_mp_op {
+	CAPTURE_MP_START,
+	CAPTURE_MP_STOP,
+};
+
+void capture_mp_register(void);
+int capture_mp_broadcast(struct capture *cap, enum capture_mp_op op);
+
+/* Shared eBPF instructions, plus the per-process loaded program. */
+struct rte_capture_filter;
+struct capture_filter_prog;
+
+#ifdef RTE_HAS_LIBPCAP
+struct rte_capture_filter *__rte_capture_filter_create(const char *str);
+const char *__rte_capture_filter_string(struct rte_capture_filter *filter);
+void __rte_capture_filter_free(struct rte_capture_filter *filter);
+
+struct capture_filter_prog *__rte_capture_filter_load(const struct rte_capture_filter *filter);
+void __rte_capture_filter_unload(struct capture_filter_prog *prog);
+uint64_t __rte_capture_filter(const struct capture_filter_prog *prog, struct rte_mbuf *mb);
+
+#else /* !RTE_HAS_LIBPCAP */
+
+/* Stub version if pcap is not available */
+static inline struct rte_capture_filter *
+__rte_capture_filter_create(const char *str)
+{
+	RTE_SET_USED(str);
+	return NULL; /* not supported */
+}
+
+static inline const char *
+__rte_capture_filter_string(struct rte_capture_filter *filter)
+{
+	RTE_SET_USED(filter);
+	return NULL;
+}
+
+static inline void
+__rte_capture_filter_free(struct rte_capture_filter *filter)
+{
+	RTE_SET_USED(filter);
+}
+
+static inline struct capture_filter_prog *
+__rte_capture_filter_load(const struct rte_capture_filter *filter)
+{
+	RTE_SET_USED(filter);
+	return NULL;
+}
+
+static inline void
+__rte_capture_filter_unload(struct capture_filter_prog *prog)
+{
+	RTE_SET_USED(prog);
+}
+
+/* Zero if the packet does not match the filter. */
+static inline uint64_t
+__rte_capture_filter(const struct capture_filter_prog *prog, struct rte_mbuf *mb)
+{
+	RTE_SET_USED(prog);
+	RTE_SET_USED(mb);
+	return 1;
+}
+
+#endif  /* !RTE_HAS_LIBPCAP */
+#endif /* CAPTURE_PRIVATE_H */
diff --git a/lib/meson.build b/lib/meson.build
index af5c160cb8..6d9992f61f 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -49,6 +49,7 @@ libraries = [
         'lpm',
         'member',
         'pcapng',
+        'capture', # depends on pcapng and bpf
         'power',
         'rawdev',
         'regexdev',
-- 
2.53.0

