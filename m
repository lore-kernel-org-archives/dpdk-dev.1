Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75218E9D408
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 16:12:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71ADC402F2;
	Wed,  4 Feb 2026 17:12:08 +0100 (CET)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id B53F2402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 17:12:07 +0100 (CET)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2b8397e3e09so941902eec.0
 for <dev@dpdk.org>; Wed, 04 Feb 2026 08:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770221526; x=1770826326; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UQn5rp2JtqJxh3MxazOSyL231buRUx+NYlxErSiN2UA=;
 b=DEIgCQGZoADN3Hr6UCJiYo6j+v+2wfkrUORSE5KRuxqqQpvXIy2kZVd+tTwQF+Jd3f
 4vheZNOqanMpLMK3MtfqHFeT+f/oQSJ1DniasrSlCLTkL7PV0JIPSe17aFQ2SauukUIb
 JqTtNh1NsGLJW1nWDgJEF+tGiKYk7P8ysKc69l9m90pm7o6uq6M63wt9X8RRlBVuz6oi
 75sy3/04doi3EHH1pt5Atj/DLx/ftaIdWvzyZiKIa7tPX2Sdss1dfmFHLarsiBWAIJFY
 NPUyca4Jdck5U6tyB0W2kyL17GVw7K5dGvLE4QEWcJB4xh40hnyhdIoDRhl2Nzg+9fBP
 fC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770221526; x=1770826326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQn5rp2JtqJxh3MxazOSyL231buRUx+NYlxErSiN2UA=;
 b=EPQDeuk4hcAZkVPzpL6qXVK2dFHE5NDZoZ42+YiYtLQRKIa5zqiBK6I0GMs3HGD9oc
 vbgwXaeds/UhcA3j1BVyIw05w1pr0syCitb7NJqTjKzDJ4F7+r1L5S9ZPArdx6smmGcI
 Uz0n7G2ksE1rF56VAKaZz4AG3XyYgZjvIc2KinZscfkMeyetLDpbiucLrfNgiktPOUQ4
 EJeHTJFBscByG0FWJJoDZkk8MQYLcCXDzeHOK1webupp0R7sOPSn3boj0S+yb5+dYmNL
 BVBJUeMXODhVqysNft33pQe8a2j/KQfuznMSz8C6Maly17z7usvkTEfsXxsxDGOBa+UW
 BNgg==
X-Gm-Message-State: AOJu0YxN05/KBK8WWpE+lRbOW9E6YUntu/zBIOc4NEWcp+6B6Dh7Rzgp
 O6cSSadX/2XvGeGwSez/UDIqqlYfAw9rfnS/WH7lz7Qr/Y5LAA8U3vcfpGasJQ==
X-Gm-Gg: AZuq6aLkjcsMEdvy//mqqjoh4ZaywVgOJeV/fWnkJe17qtHYAeCfiRzGMuz+VkjrqkN
 D4KshpFnU+ArNyg7bNicYV5OYXzyBfREuqCJTsI3CI7l1cI9p6pHdUb7OBphKh4j9EH8rgcICXO
 eJPJmRGIM1oNFBvjl/cgQ8EEWZxRETDMsYYS9fMPC1THdpVpWBPeJcJXewEP7vAgpFtk1gL2see
 MoT8dYurA8m91suoTtG0Edj/Q661PTIiAFqinSGMRviyxtr9RIllSGiVLdMVPMdp4HaPN9F6wjl
 Msoq5edvYsX4kdswDBGgPIVAyNTiNko3aOuhTVusRNfpIGdMk2pQAZ2/9MxaaOWTYVi4zRUEVcg
 5OSSqsvfZAZBQwlNH3hODsLuYlWX7Mbrmc0igI5JW25abGIEP1eebgCFLxADnDY+1P8+Qk3XnOl
 5uTCJndJcyazrQboeRbL0RFnIRJa8dMlDW4e/0RcCliI88S6RGOQ7Qfd2WbZMQ
X-Received: by 2002:a05:7300:d517:b0:2b1:76f9:e094 with SMTP id
 5a478bee46e88-2b832a45b9emr1494493eec.36.1770221526035; 
 Wed, 04 Feb 2026 08:12:06 -0800 (PST)
Received: from mr55p01nt-relayp04.apple.com
 ([2600:1010:b095:3086:9893:5045:c8ee:dfee])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832e4cd26sm1763161eec.12.2026.02.04.08.12.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 08:12:05 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: Scott <scott.k.mitch1@gmail.com>
Subject: [RFC v1] net/af_packet: add io_uring TX acceleration
Date: Wed,  4 Feb 2026 08:12:02 -0800
Message-Id: <20260204161202.36805-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Scott <scott.k.mitch1@gmail.com>

When user space application does sendto() to notify the kernel
there is data to process, the kernel synchronously processes
pending frames and the CPU cost is attributed to the application.
The kernel processing may also include kernel RX (netlink, ovs)
and packet manipulation. This can negatively impact performance
by limiting CPU to each dpdk network thread.

io_uring offers a mode (SQPOLL) to offload this processing
to a dedicated kernel thread. This makes the kernel processing
asynchronous, which can improve throughput by 30%+. The trade-off
is SQPOLL threads consume additional CPU but this follows the
same principle as virtio backends, and enables use cases that
can't adopt virtio (e.g. containerized workloads).

This patch adds optional io_uring support for TX kick operations
to replace synchronous sendto() syscalls. When enabled, uses
SQPOLL mode with kernel-side submission polling for reduced
syscall overhead.

Features:
- Optional liburing dependency (version >= 2.4 required)
- SQPOLL mode with configurable idle timeout
- CPU affinity for SQPOLL threads (IORING_SETUP_SQ_AFF)
- Shared workqueue support (IORING_SETUP_ATTACH_WQ)
- Registered file descriptors for IOSQE_FIXED_FILE optimization
- Single issuer and cooperative taskrun optimizations when available

New devargs:
- tx_io_uring_enabled: Enable io_uring TX (default: 0)
- tx_io_uring_sq_size: Submission queue size (default: 1024)
- tx_io_uring_sq_thread_idle: SQPOLL idle timeout in ms (default: 500)
- tx_io_uring_q_cpu: CPU affinity for SQPOLL threads (repeatable)
- tx_io_uring_wq_num: Number of shared workqueues (default: 0)

The TX path updates the ring tail pointer directly instead of calling
io_uring_submit() to avoid the io_uring_enter syscall, relying on
SQPOLL to pick up submissions. If the SQPOLL thread sleeps, we wake
it with IORING_ENTER_SQ_WAKEUP.

Falls back gracefully to sendto() when:
- liburing is not available at compile time
- SQPOLL is not supported by the kernel
- io_uring initialization fails for any reason

Signed-off-by: Scott <scott.k.mitch1@gmail.com>
---
Depends-on: series-37248 ("af_packet correctness, performance, cksum")

 doc/guides/nics/af_packet.rst             |  16 +-
 doc/guides/rel_notes/release_26_03.rst    |   1 +
 drivers/net/af_packet/meson.build         |  14 +
 drivers/net/af_packet/rte_eth_af_packet.c | 420 +++++++++++++++++++++-
 4 files changed, 435 insertions(+), 16 deletions(-)

diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_packet.rst
index 782a962c3f..b9f4ad9f69 100644
--- a/doc/guides/nics/af_packet.rst
+++ b/doc/guides/nics/af_packet.rst
@@ -33,6 +33,20 @@ Some of these, in turn, will be used to configure the PACKET_MMAP settings.
     space available to write to the kernel. If 1, call poll() and block until
     space is available to tx. If 0, don't call poll() and return from tx (optional,
     default 1).
+*   ``tx_io_uring_enabled`` - Use io_uring to notify the kernel on tx (optional,
+    default 0)
+*   ``tx_io_uring_sq_size`` - Number of entries for the io_uring ring (optional,
+    default 1024)
+*   ``tx_io_uring_sq_thread_idle`` - Idle time (in milliseconds) before an io_uring
+    SQPOLL thread goes to sleep (optional, default 500)
+*   ``tx_io_uring_q_cpu`` - This argument can be repeated to specify CPU core
+    affinity for each queue's io_uring SQPOLL kernel thread (see
+    ``io_uring_params.sq_thread_cpu``). The first value applies to queue 0,
+    the second to queue 1, etc. (optional, default empty)
+*   ``tx_io_uring_wq_num`` - Number of SQPOLL kernel threads. On kernels with
+    ``IORING_SETUP_ATTACH_WQ`` support, setting this lower than the queue count
+    enables thread sharing across queues. If 0 or unspecified, no sharing is configured
+    and each queue creates its own SQPOLL thread (optional, default 0)
 
 For details regarding ``fanout_mode`` argument, you can consult the
 `PACKET_FANOUT documentation <https://www.man7.org/linux/man-pages/man7/packet.7.html>`_.
@@ -79,7 +93,7 @@ framecnt=512):
 
 .. code-block:: console
 
-    --vdev=eth_af_packet0,iface=tap0,blocksz=4096,framesz=2048,framecnt=512,qpairs=1,qdisc_bypass=0,fanout_mode=hash,txpollnotrdy=0
+    --vdev=eth_af_packet0,iface=tap0,blocksz=4096,framesz=2048,framecnt=512,qpairs=1,qdisc_bypass=0,fanout_mode=hash,txpollnotrdy=0,tx_io_uring_enabled=1
 
 Features and Limitations
 ------------------------
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 5abdd7cbb2..87081e8b98 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -62,6 +62,7 @@ New Features
   * Added ``txpollnotrdy`` devarg to avoid ``poll()`` blocking calls
   * Added checksum offload support for ``IPV4_CKSUM``, ``UDP_CKSUM``,
     and ``TCP_CKSUM``
+  * Added io_uring to notify the kernel on tx
 
 * **Updated AMD axgbe ethernet driver.**
 
diff --git a/drivers/net/af_packet/meson.build b/drivers/net/af_packet/meson.build
index f45e4491d4..a672262656 100644
--- a/drivers/net/af_packet/meson.build
+++ b/drivers/net/af_packet/meson.build
@@ -5,5 +5,19 @@ if not is_linux
     build = false
     reason = 'only supported on Linux'
 endif
+
+deps += ['ethdev']
+
+liburing_dep = dependency('liburing', required: false)
+if not liburing_dep.found()
+    message('AF_PACKET PMD: liburing not found, fallback to sendto()')
+elif not liburing_dep.version().version_compare('>=2.4')
+    message('AF_PACKET PMD: liburing version too old, need >= 2.4. fallback to sendto()')
+else
+    ext_deps += liburing_dep
+    cflags += '-DRTE_NET_AF_PACKET_HAVE_LIBURING'
+    message('AF_PACKET PMD: liburing @0@ support enabled'.format(liburing_dep.version()))
+endif
+
 sources = files('rte_eth_af_packet.c')
 require_iova_in_mbuf = false
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 1c5f17af34..5b94a513f4 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -19,6 +19,10 @@
 #include <rte_kvargs.h>
 #include <bus_vdev_driver.h>
 
+#ifdef RTE_NET_AF_PACKET_HAVE_LIBURING
+#include <liburing.h>
+#endif
+
 #include <errno.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
@@ -42,10 +46,21 @@
 #define ETH_AF_PACKET_QDISC_BYPASS_ARG	"qdisc_bypass"
 #define ETH_AF_PACKET_FANOUT_MODE_ARG	"fanout_mode"
 #define ETH_AF_PACKET_TX_POLL_NOT_READY_ARG	"txpollnotrdy"
+#define ETH_AF_PACKET_TX_IO_URING_ENABLED_ARG	"tx_io_uring_enabled"
+#define ETH_AF_PACKET_TX_IO_URING_SQ_SIZE_ARG	"tx_io_uring_sq_size"
+#define ETH_AF_PACKET_TX_IO_URING_SQ_THREAD_IDLE_ARG	"tx_io_uring_sq_thread_idle"
+#define ETH_AF_PACKET_TX_IO_URING_Q_CPU	"tx_io_uring_q_cpu"
+#define ETH_AF_PACKET_TX_IO_URING_WQ_NUM	"tx_io_uring_wq_num"
 
 #define DFLT_FRAME_SIZE		(1 << 11)
 #define DFLT_FRAME_COUNT	(1 << 9)
 #define DFLT_TX_POLL_NOT_RDY	true
+#define DFLT_TX_IO_URING_ENABLED	false
+#define DFLT_TX_IO_URING_SQ_SIZE	1024
+#define DFLT_TX_IO_URING_SQ_THREAD_IDLE_MS	500
+
+/* io_uring registered file descriptor index for the socket fd */
+#define ETH_AF_PACKET_URING_SOCKFD_INDEX	0
 
 static const uint16_t eth_af_packet_frame_size_max = RTE_IPV4_MAX_PKT_LEN;
 #define ETH_AF_PACKET_FRAME_OVERHEAD (TPACKET2_HDRLEN - sizeof(struct sockaddr_ll))
@@ -82,6 +97,12 @@ struct __rte_cache_aligned pkt_tx_queue {
 	unsigned int framecount;
 	unsigned int framenum;
 
+#ifdef RTE_NET_AF_PACKET_HAVE_LIBURING
+	struct io_uring uring_ring;
+	bool uring_enabled;
+	uint32_t uring_sqe_since_cq_advance;
+#endif
+
 	bool txpollnotrdy;
 	bool sw_cksum;
 
@@ -104,6 +125,11 @@ struct pmd_internals {
 	uint8_t vlan_strip;
 	uint8_t timestamp_offloading;
 	bool tx_sw_cksum;
+
+#ifdef RTE_NET_AF_PACKET_HAVE_LIBURING
+	struct io_uring **shared_uring_rings;
+	uint32_t shared_uring_count;
+#endif
 };
 
 static const char *valid_arguments[] = {
@@ -115,6 +141,11 @@ static const char *valid_arguments[] = {
 	ETH_AF_PACKET_QDISC_BYPASS_ARG,
 	ETH_AF_PACKET_FANOUT_MODE_ARG,
 	ETH_AF_PACKET_TX_POLL_NOT_READY_ARG,
+	ETH_AF_PACKET_TX_IO_URING_ENABLED_ARG,
+	ETH_AF_PACKET_TX_IO_URING_SQ_SIZE_ARG,
+	ETH_AF_PACKET_TX_IO_URING_SQ_THREAD_IDLE_ARG,
+	ETH_AF_PACKET_TX_IO_URING_Q_CPU,
+	ETH_AF_PACKET_TX_IO_URING_WQ_NUM,
 	NULL
 };
 
@@ -157,6 +188,195 @@ tpacket_write_status(volatile void *tp_status, uint32_t status)
 	rte_smp_wmb();
 }
 
+#ifdef RTE_NET_AF_PACKET_HAVE_LIBURING
+static bool
+af_packet_io_uring_supports(const uint32_t flags)
+{
+	struct io_uring_params p = {
+		.flags = flags
+	};
+	const int ring_fd = io_uring_setup(1, &p);
+	if (ring_fd < 0)
+		return false;
+	close(ring_fd);
+	return true;
+}
+#endif /* RTE_NET_AF_PACKET_HAVE_LIBURING */
+
+static void
+af_packet_io_uring_share_uring_init(struct pmd_internals *internals,
+				const unsigned int numa_node,
+				const unsigned int nb_queues,
+				const bool tx_io_uring_enabled,
+				const uint32_t tx_io_uring_kq_cores_size,
+				const uint32_t tx_io_uring_wq_num)
+{
+#ifdef RTE_NET_AF_PACKET_HAVE_LIBURING
+	if (!tx_io_uring_enabled)
+		return;
+
+	if (!af_packet_io_uring_supports(IORING_SETUP_SQPOLL)) {
+		PMD_LOG(NOTICE, "AF_PACKET PMD io_uring IORING_SETUP_SQPOLL not supported");
+		return;
+	}
+
+	if (tx_io_uring_wq_num <= 0)
+		return;
+
+	/* Allocate shared io_uring rings if ATTACH_WQ mode will be used */
+	if (!af_packet_io_uring_supports(IORING_SETUP_ATTACH_WQ | IORING_SETUP_SQPOLL)) {
+		PMD_LOG(WARNING, "AF_PACKET PMD IORING_SETUP_ATTACH_WQ not supported, "
+			"%s=%" PRIu32 " will be ignored", ETH_AF_PACKET_TX_IO_URING_WQ_NUM,
+			tx_io_uring_wq_num);
+	} else {
+		internals->shared_uring_rings =
+			rte_calloc_socket("af_packet_shared_uring", tx_io_uring_wq_num,
+				sizeof(*internals->shared_uring_rings), 0, numa_node);
+		if (!internals->shared_uring_rings) {
+			PMD_LOG(ERR, "Failed to allocate shared io_uring rings");
+			return;
+		}
+		internals->shared_uring_count = tx_io_uring_wq_num;
+
+		if (tx_io_uring_kq_cores_size > tx_io_uring_wq_num) {
+			PMD_LOG(WARNING,
+				"AF_PACKET PMD %s count=%" PRIu32 " > %s=%" PRIu32 ", "
+				"extra CPU affinities will be ignored",
+				ETH_AF_PACKET_TX_IO_URING_Q_CPU, tx_io_uring_kq_cores_size,
+				ETH_AF_PACKET_TX_IO_URING_WQ_NUM, tx_io_uring_wq_num);
+		}
+
+		if (nb_queues % tx_io_uring_wq_num != 0) {
+			PMD_LOG(INFO,
+				"AF_PACKET PMD %s=%u not divisible by %s=%" PRIu32 ", "
+				"SQPOLL thread work may be imbalanced",
+				ETH_AF_PACKET_NUM_Q_ARG, nb_queues,
+				ETH_AF_PACKET_TX_IO_URING_WQ_NUM, tx_io_uring_wq_num);
+		}
+	}
+#else
+	if (tx_io_uring_enabled) {
+		PMD_LOG(NOTICE,
+			"AF_PACKET PMD %s enabled, but feature not enabled at compile time.",
+			ETH_AF_PACKET_TX_IO_URING_ENABLED_ARG);
+	}
+	RTE_SET_USED(internals);
+	RTE_SET_USED(numa_node);
+	RTE_SET_USED(nb_queues);
+	RTE_SET_USED(tx_io_uring_kq_cores_size);
+	RTE_SET_USED(tx_io_uring_wq_num);
+#endif /* RTE_NET_AF_PACKET_HAVE_LIBURING */
+}
+
+static void
+af_packet_io_uring_tx_queue_init(struct pmd_internals *internals,
+				const unsigned int q,
+				const bool tx_io_uring_enabled,
+				const uint32_t tx_io_uring_sq_size,
+				const uint32_t tx_io_uring_sq_thread_idle_ms,
+				const uint32_t *tx_io_uring_kq_cores,
+				const uint32_t tx_io_uring_kq_cores_size)
+{
+#ifdef RTE_NET_AF_PACKET_HAVE_LIBURING
+	if (!tx_io_uring_enabled || !af_packet_io_uring_supports(IORING_SETUP_SQPOLL))
+		return;
+
+	int rc;
+	struct pkt_tx_queue *tx_queue = &internals->tx_queue[q];
+	struct io_uring_params uring_params = {
+		.sq_thread_idle = tx_io_uring_sq_thread_idle_ms,
+		.flags = IORING_SETUP_SQPOLL,
+	};
+
+	/* Determine if attaching to existing ring or creating new one */
+	uint32_t ring_idx = internals->shared_uring_rings ? q % internals->shared_uring_count : 0;
+	bool attach_mode = internals->shared_uring_rings && ring_idx < q &&
+			internals->shared_uring_rings[ring_idx];
+
+	if (attach_mode) {
+		/* Attach to existing ring queue, IORING_SETUP_ATTACH_WQ support already checked.
+		 * Each io_uring_queue_init_params initializes independent memory. Life cycle
+		 * management is still per-queue, and wq_fd shares the SQPOLL thread.
+		 */
+		uring_params.flags |= IORING_SETUP_ATTACH_WQ;
+		uring_params.wq_fd = internals->shared_uring_rings[ring_idx]->ring_fd;
+	} else {
+		/* Create new ring: add CPU affinity if configured */
+		if (tx_io_uring_kq_cores_size > 0) {
+			uint32_t cpu_idx = internals->shared_uring_rings ? ring_idx : q;
+			if (cpu_idx < tx_io_uring_kq_cores_size) {
+				if (af_packet_io_uring_supports(uring_params.flags |
+						IORING_SETUP_SQ_AFF)) {
+					uring_params.flags |= IORING_SETUP_SQ_AFF;
+					uring_params.sq_thread_cpu = tx_io_uring_kq_cores[cpu_idx];
+				} else if (q == 0) {
+					PMD_LOG(INFO,
+						"AF_PACKET PMD IORING_SETUP_SQ_AFF not supported, "
+						"SQPOLL CPU pinning disabled");
+				}
+			} else {
+				PMD_LOG(DEBUG,
+					"AF_PACKET PMD io_uring tx_queue=%u > %s size=%" PRIu32 " "
+					"and will not be CPU pinned", q,
+					ETH_AF_PACKET_TX_IO_URING_Q_CPU,
+					tx_io_uring_kq_cores_size);
+			}
+		}
+
+		/* Add optional optimizations for new rings */
+		if (af_packet_io_uring_supports(uring_params.flags | IORING_SETUP_SINGLE_ISSUER))
+			uring_params.flags |= IORING_SETUP_SINGLE_ISSUER;
+		else if (q == 0)
+			PMD_LOG(DEBUG, "AF_PACKET PMD IORING_SETUP_SINGLE_ISSUER not supported");
+
+		if (af_packet_io_uring_supports(uring_params.flags | IORING_SETUP_COOP_TASKRUN))
+			uring_params.flags |= IORING_SETUP_COOP_TASKRUN;
+		else if (q == 0)
+			PMD_LOG(DEBUG, "AF_PACKET PMD IORING_SETUP_COOP_TASKRUN not supported");
+	}
+
+	rc = io_uring_queue_init_params(tx_io_uring_sq_size, &tx_queue->uring_ring,
+			&uring_params);
+	if (rc < 0) {
+		PMD_LOG(WARNING, "AF_PACKET PMD Failed io_uring_queue_init_params (error %d: %s), "
+			"tx_queue=%u sq_size=%" PRIu32 " flags=0x%X sq_thread_cpu=%u "
+			"sq_thread_idle=%u, falling back to synchronous sendto()",
+			-rc, strerror(-rc), q, tx_io_uring_sq_size, uring_params.flags,
+			uring_params.sq_thread_cpu, uring_params.sq_thread_idle);
+		return;
+	}
+
+	/* Register the sockfd at index ETH_AF_PACKET_URING_SOCKFD_INDEX */
+	rc = io_uring_register_files(&tx_queue->uring_ring, &tx_queue->sockfd, 1);
+	if (rc < 0) {
+		PMD_LOG(WARNING, "AF_PACKET PMD Failed io_uring_register_files (error %d: %s)",
+				-rc, strerror(-rc));
+		io_uring_queue_exit(&tx_queue->uring_ring);
+		return;
+	}
+
+	tx_queue->uring_enabled = true;
+	tx_queue->uring_sqe_since_cq_advance = 0;
+
+	if (!attach_mode && internals->shared_uring_rings)
+		internals->shared_uring_rings[ring_idx] = &tx_queue->uring_ring;
+
+	PMD_LOG(DEBUG, "AF_PACKET PMD io_uring SQPOLL%s enabled tx_queue=%u ring_idx=%u "
+		"tx_io_uring_sq_size=%" PRIu32 " kthread_cpu=%u sq_thread_idle=%u flags=0x%X",
+		attach_mode ? "+ATTACH_WQ" : "", q, ring_idx, tx_io_uring_sq_size,
+		uring_params.sq_thread_cpu, uring_params.sq_thread_idle, uring_params.flags);
+
+#else
+	RTE_SET_USED(internals);
+	RTE_SET_USED(q);
+	RTE_SET_USED(tx_io_uring_enabled);
+	RTE_SET_USED(tx_io_uring_sq_size);
+	RTE_SET_USED(tx_io_uring_sq_thread_idle_ms);
+	RTE_SET_USED(tx_io_uring_kq_cores);
+	RTE_SET_USED(tx_io_uring_kq_cores_size);
+#endif /* RTE_NET_AF_PACKET_HAVE_LIBURING */
+}
+
 static uint16_t
 eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
@@ -251,6 +471,71 @@ tx_ring_status_available(uint32_t tp_status)
 	return tp_status == TP_STATUS_AVAILABLE;
 }
 
+/*
+ * Kick the kernel to transmit packets in the ring.
+ *
+ * The sendto() call with NULL buffer is a notification to the kernel that
+ * frames have been queued (marked TP_STATUS_SEND_REQUEST) in the ring.
+ * The kernel will eventually process all queued frames regardless of whether
+ * this kick succeeds or fails. We don't check for errors because:
+ *
+ * 1. Data is already in the ring - the PMD's work is complete
+ * 2. ENOBUFS/EAGAIN just mean "try again later" - kernel will still process ring
+ * 3. Fatal errors (EBADF) indicate socket is broken - subsequent ops will fail
+ * 4. Consistent with io_uring path which doesn't check completion status
+ */
+static inline void
+eth_af_packet_tx_kick(struct pkt_tx_queue *pkt_q)
+{
+#ifdef RTE_NET_AF_PACKET_HAVE_LIBURING
+	if (pkt_q->uring_enabled) {
+		/* Batch CQ advancement: only advance every sq_size submissions to amortize
+		 * memory barrier cost (2 load_acquire + 1 store_release). With
+		 * IOSQE_CQE_SKIP_SUCCESS, CQ is mostly empty (successes don't generate CQEs).
+		 * This prevents rare failure CQEs from accumulating while minimizing overhead.
+		 */
+		if (++pkt_q->uring_sqe_since_cq_advance >= pkt_q->uring_ring.sq.ring_entries) {
+			io_uring_cq_advance(&pkt_q->uring_ring,
+					io_uring_cq_ready(&pkt_q->uring_ring));
+			pkt_q->uring_sqe_since_cq_advance = 0;
+		}
+
+		struct io_uring_sqe *sqe = io_uring_get_sqe(&pkt_q->uring_ring);
+		/* If no sqe available skip this notification and wait for kernel to catch up.
+		 * Avoid fall back sendto() so we don't block the application thread and it is
+		 * highly likely the kernel will process pending events and/or subsequent TX
+		 * will generate new notification.
+		 */
+		if (unlikely(sqe == NULL))
+			return;
+
+		/* Use registered fd (see io_uring_register_files call during setup) */
+		io_uring_prep_send(sqe, ETH_AF_PACKET_URING_SOCKFD_INDEX, NULL, 0, MSG_DONTWAIT);
+		io_uring_sqe_set_flags(sqe, IOSQE_FIXED_FILE | IOSQE_CQE_SKIP_SUCCESS);
+		io_uring_sqe_set_data(sqe, NULL);
+
+		/* io_uring_submit does a io_uring_enter syscall,
+		 * update tail pointer directly instead.
+		 */
+		io_uring_smp_store_release(pkt_q->uring_ring.sq.ktail,
+				pkt_q->uring_ring.sq.sqe_tail);
+
+		/* io_uring in sqpoll mode the kthread will sleep after sq_thread_idle
+		 * ms idle time. Check if we need to force wake up to avoid waiting
+		 * unknown time.
+		 */
+		if (unlikely(IO_URING_READ_ONCE(*pkt_q->uring_ring.sq.kflags) &
+				IORING_SQ_NEED_WAKEUP))
+			io_uring_enter(pkt_q->uring_ring.ring_fd, 0, 0, IORING_ENTER_SQ_WAKEUP,
+					NULL);
+	} else {
+		sendto(pkt_q->sockfd, NULL, 0, MSG_DONTWAIT, NULL, 0);
+	}
+#else
+	sendto(pkt_q->sockfd, NULL, 0, MSG_DONTWAIT, NULL, 0);
+#endif
+}
+
 /*
  * Callback to handle sending packets through a real NIC.
  */
@@ -342,19 +627,8 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	rte_pktmbuf_free_bulk(&bufs[0], i);
 
-	/* kick-off transmits */
-	if (unlikely(num_tx > 0 &&
-		     sendto(pkt_q->sockfd, NULL, 0, MSG_DONTWAIT, NULL, 0) == -1 &&
-		     errno != ENOBUFS && errno != EAGAIN)) {
-		/*
-		 * In case of a ENOBUFS/EAGAIN error all of the enqueued
-		 * packets will be considered successful even though only some
-		 * are sent.
-		 */
-
-		num_tx = 0;
-		num_tx_bytes = 0;
-	}
+	if (likely(num_tx > 0))
+		eth_af_packet_tx_kick(pkt_q);
 
 	pkt_q->framenum = framenum;
 	pkt_q->tx_pkts += num_tx;
@@ -560,11 +834,22 @@ eth_dev_close(struct rte_eth_dev *dev)
 		internals->rx_queue[q].sockfd = -1;
 		internals->tx_queue[q].sockfd = -1;
 
+#ifdef RTE_NET_AF_PACKET_HAVE_LIBURING
+		if (internals->tx_queue[q].uring_enabled) {
+			io_uring_unregister_files(&internals->tx_queue[q].uring_ring);
+			io_uring_queue_exit(&internals->tx_queue[q].uring_ring);
+			internals->tx_queue[q].uring_enabled = false;
+		}
+#endif
+
 		munmap(internals->rx_queue[q].map,
 			2 * req->tp_block_size * req->tp_block_nr);
 		rte_free(internals->rx_queue[q].rd);
 		rte_free(internals->tx_queue[q].rd);
 	}
+#ifdef RTE_NET_AF_PACKET_HAVE_LIBURING
+	rte_free(internals->shared_uring_rings);
+#endif
 	rte_free(internals->if_name);
 	rte_free(internals->rx_queue);
 	rte_free(internals->tx_queue);
@@ -826,7 +1111,7 @@ get_fanout(const char *fanout_mode, int if_index)
 static int
 rte_pmd_init_internals(struct rte_vdev_device *dev,
                        const int sockfd,
-                       const unsigned nb_queues,
+			const unsigned int nb_queues,
                        unsigned int blocksize,
                        unsigned int blockcnt,
                        unsigned int framesize,
@@ -834,6 +1119,12 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		       unsigned int qdisc_bypass,
 		       const char *fanout_mode,
 			bool txpollnotrdy,
+			bool tx_io_uring_enabled,
+			uint32_t tx_io_uring_sq_size,
+			uint32_t tx_io_uring_sq_thread_idle_ms,
+			uint32_t *tx_io_uring_kq_cores,
+			uint32_t tx_io_uring_kq_cores_size,
+			uint32_t tx_io_uring_wq_num,
                        struct pmd_internals **internals,
                        struct rte_eth_dev **eth_dev,
                        struct rte_kvargs *kvlist)
@@ -939,6 +1230,9 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		goto error;
 	}
 
+	af_packet_io_uring_share_uring_init(*internals, numa_node, nb_queues,
+			tx_io_uring_enabled, tx_io_uring_kq_cores_size, tx_io_uring_wq_num);
+
 	for (q = 0; q < nb_queues; q++) {
 		/* Open an AF_PACKET socket for this queue... */
 		qsockfd = socket(AF_PACKET, SOCK_RAW, 0);
@@ -1073,6 +1367,10 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 				goto error;
 			}
 		}
+
+		af_packet_io_uring_tx_queue_init(*internals, q, tx_io_uring_enabled,
+			tx_io_uring_sq_size, tx_io_uring_sq_thread_idle_ms, tx_io_uring_kq_cores,
+			tx_io_uring_kq_cores_size);
 	}
 
 	/* reserve an ethdev entry */
@@ -1106,6 +1404,13 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 	if (qsockfd != -1)
 		close(qsockfd);
 	for (q = 0; q < nb_queues; q++) {
+#ifdef RTE_NET_AF_PACKET_HAVE_LIBURING
+		if ((*internals)->tx_queue[q].uring_enabled) {
+			io_uring_unregister_files(&(*internals)->tx_queue[q].uring_ring);
+			io_uring_queue_exit(&(*internals)->tx_queue[q].uring_ring);
+			(*internals)->tx_queue[q].uring_enabled = false;
+		}
+#endif
 		if ((*internals)->rx_queue[q].map != MAP_FAILED)
 			munmap((*internals)->rx_queue[q].map,
 			       2 * req->tp_block_size * req->tp_block_nr);
@@ -1117,6 +1422,9 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 			close((*internals)->rx_queue[q].sockfd);
 	}
 free_internals:
+#ifdef RTE_NET_AF_PACKET_HAVE_LIBURING
+	rte_free((*internals)->shared_uring_rings);
+#endif
 	rte_free((*internals)->rx_queue);
 	rte_free((*internals)->tx_queue);
 	rte_free((*internals)->if_name);
@@ -1143,6 +1451,12 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	unsigned int qdisc_bypass = 1;
 	const char *fanout_mode = NULL;
 	bool txpollnotrdy = DFLT_TX_POLL_NOT_RDY;
+	bool tx_io_uring_enabled = DFLT_TX_IO_URING_ENABLED;
+	uint32_t tx_io_uring_sq_size = DFLT_TX_IO_URING_SQ_SIZE;
+	uint32_t tx_io_uring_sq_thread_idle_ms = DFLT_TX_IO_URING_SQ_THREAD_IDLE_MS;
+	uint32_t tx_io_uring_kq_cores[RTE_MAX_QUEUES_PER_PORT] = {};
+	uint32_t tx_io_uring_kq_cores_size = 0;
+	uint32_t tx_io_uring_wq_num = 0;
 
 	/* do some parameter checking */
 	if (*sockfd < 0)
@@ -1211,6 +1525,61 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			txpollnotrdy = atoi(pair->value) != 0;
 			continue;
 		}
+		if (strstr(pair->key, ETH_AF_PACKET_TX_IO_URING_ENABLED_ARG) != NULL) {
+			tx_io_uring_enabled = atoi(pair->value) != 0;
+			continue;
+		}
+		if (strstr(pair->key, ETH_AF_PACKET_TX_IO_URING_SQ_SIZE_ARG) != NULL) {
+			int tx_io_uring_sq_size_value = atoi(pair->value);
+			if (tx_io_uring_sq_size_value > 0) {
+				tx_io_uring_sq_size = tx_io_uring_sq_size_value;
+			} else {
+				PMD_LOG(ERR, "%s: invalid %s %d (must >0)", name,
+					ETH_AF_PACKET_TX_IO_URING_SQ_SIZE_ARG,
+					tx_io_uring_sq_size_value);
+				return -1;
+			}
+			continue;
+		}
+		if (strstr(pair->key, ETH_AF_PACKET_TX_IO_URING_SQ_THREAD_IDLE_ARG) != NULL) {
+			int tx_io_uring_sq_thread_idle_value = atoi(pair->value);
+			if (tx_io_uring_sq_thread_idle_value >= 0) {
+				tx_io_uring_sq_thread_idle_ms = tx_io_uring_sq_thread_idle_value;
+			} else {
+				PMD_LOG(ERR, "%s: invalid %s %d (must >=0)", name,
+						ETH_AF_PACKET_TX_IO_URING_SQ_THREAD_IDLE_ARG,
+						tx_io_uring_sq_thread_idle_value);
+				return -1;
+			}
+			continue;
+		}
+		if (strstr(pair->key, ETH_AF_PACKET_TX_IO_URING_Q_CPU) != NULL) {
+			char *end;
+			errno = 0;
+			long lvalue = strtol(pair->value, &end, 10);
+			if (*end != '\0' || errno != 0 || lvalue < 0 || lvalue > UINT32_MAX) {
+				PMD_LOG(ERR, "%s: CPU '%s' must be [0, %" PRIu32 "] for %s", name,
+					pair->value, UINT32_MAX, ETH_AF_PACKET_TX_IO_URING_Q_CPU);
+				return -1;
+			} else if (tx_io_uring_kq_cores_size >= RTE_MAX_QUEUES_PER_PORT) {
+				PMD_LOG(ERR, "%s: too many %s args, max of %d", name,
+					ETH_AF_PACKET_TX_IO_URING_Q_CPU, RTE_MAX_QUEUES_PER_PORT);
+				return -1;
+			}
+			tx_io_uring_kq_cores[tx_io_uring_kq_cores_size++] = (uint32_t)lvalue;
+			continue;
+		}
+		if (strstr(pair->key, ETH_AF_PACKET_TX_IO_URING_WQ_NUM) != NULL) {
+			int tx_io_uring_wq_num_value = atoi(pair->value);
+			if (tx_io_uring_wq_num_value >= 0) {
+				tx_io_uring_wq_num = (uint32_t)tx_io_uring_wq_num_value;
+			} else {
+				PMD_LOG(ERR, "%s: invalid %s %d (must >=0)", name,
+					ETH_AF_PACKET_TX_IO_URING_WQ_NUM, tx_io_uring_wq_num_value);
+				return -1;
+			}
+			continue;
+		}
 	}
 
 	if (framesize > blocksize) {
@@ -1281,12 +1650,28 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 		PMD_LOG(DEBUG, "%s:\tfanout mode %s", name, "default PACKET_FANOUT_HASH");
 	PMD_LOG(INFO, "%s:\ttxpollnotrdy %d", name, txpollnotrdy ? 1 : 0);
 
+	PMD_LOG(INFO, "%s:\t%s %d", name,
+		ETH_AF_PACKET_TX_IO_URING_ENABLED_ARG, tx_io_uring_enabled ? 1 : 0);
+	PMD_LOG(INFO, "%s:\t%s %" PRIu32, name,
+		ETH_AF_PACKET_TX_IO_URING_SQ_SIZE_ARG, tx_io_uring_sq_size);
+	PMD_LOG(INFO, "%s:\t%s %" PRIu32, name,
+		ETH_AF_PACKET_TX_IO_URING_SQ_THREAD_IDLE_ARG, tx_io_uring_sq_thread_idle_ms);
+	for (uint32_t cpu_i = 0; cpu_i < tx_io_uring_kq_cores_size; cpu_i++) {
+		PMD_LOG(INFO, "%s:\t%s[%" PRIu32 "] %" PRIu32, name,
+			ETH_AF_PACKET_TX_IO_URING_Q_CPU, cpu_i, tx_io_uring_kq_cores[cpu_i]);
+	}
+	PMD_LOG(INFO, "%s:\t%s %" PRIu32, name,
+		ETH_AF_PACKET_TX_IO_URING_WQ_NUM, tx_io_uring_wq_num);
+
 	if (rte_pmd_init_internals(dev, *sockfd, qpairs,
 				   blocksize, blockcount,
 				   framesize, framecount,
 				   qdisc_bypass,
 				   fanout_mode,
 				   txpollnotrdy,
+				   tx_io_uring_enabled, tx_io_uring_sq_size,
+				   tx_io_uring_sq_thread_idle_ms, tx_io_uring_kq_cores,
+				   tx_io_uring_kq_cores_size, tx_io_uring_wq_num,
 				   &internals, &eth_dev,
 				   kvlist) < 0)
 		return -1;
@@ -1385,4 +1770,9 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_packet,
 	"framecnt=<int> "
 	"qdisc_bypass=<0|1> "
 	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm> "
-	"txpollnotrdy=<0|1>");
+	"txpollnotrdy=<0|1> "
+	"tx_io_uring_enabled=<0|1> "
+	"tx_io_uring_sq_size=<int> "
+	"tx_io_uring_sq_thread_idle=<int> "
+	"tx_io_uring_q_cpu=<int> "
+	"tx_io_uring_wq_num=<int>");
-- 
2.39.5 (Apple Git-154)

