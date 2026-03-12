Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFF7106ACEE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 22:01:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B3D0402D0;
	Thu, 12 Mar 2026 23:01:55 +0100 (CET)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by mails.dpdk.org (Postfix) with ESMTP id B1918402D0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 23:01:54 +0100 (CET)
Received: from localhost.localdomain (unknown [82.65.104.223])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id B446078032A;
 Thu, 12 Mar 2026 23:01:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773352914;
 bh=ENtKm8hguZvwzcil4AQGGy4yI/8dJPlqsZqQ+SYVmZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=naRoqAmhCzVnoQKKGepM/9Zd2l8CBQflKJ5OwTOW5UEdz4OtNvhHi4ec5x8OgyOJB
 keGIYuUyedfc+LhyNq2FhOmF66j/M7L8HHdVTIZuzye8lsz0vs2P7LI5vRvt+bvc0p
 sknB9bLlDznz2oBOKQGGeSbFqrEc0sB1e5QlFR7pNBdHRs5w6QlltXgAcFS0WRXUwM
 fDwHwBCK0wDT4/Kng+rOH52Zv7tCFpThg/ABsu3Aod9dH+M+U1+h1fHqP3imbfpqML
 I3B2yZD28i6JGZywsApPgbyOXPTlnQT0A2clhJqmVp909W1x+609rmh1MR1ZsMNeom
 nxd8CDsJl7G3g==
From: Vincent Jardin <vjardin@free.fr>
To: dev@dpdk.org
Cc: rasland@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 stephen@networkplumber.org, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 01/9] doc/nics/mlx5: fix stale packet pacing documentation
Date: Thu, 12 Mar 2026 23:01:12 +0100
Message-ID: <20260312220120.3256755-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312220120.3256755-1-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260312220120.3256755-1-vjardin@free.fr>
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

The Tx Scheduling section incorrectly stated that timestamps can only
be put on the first packet in a burst. The driver actually checks every
packet's ol_flags for the timestamp dynamic flag and inserts a dedicated
WAIT WQE per timestamped packet. The eMPW path also breaks batches when
a timestamped packet is encountered.

Additionally, the ConnectX-7+ wait-on-time capability was only briefly
mentioned in the tx_pp parameter section with no explanation of how it
differs from the ConnectX-6 Dx Clock Queue approach.

This patch:
- Removes the stale first-packet-only limitation
- Documents both scheduling mechanisms (ConnectX-6 Dx Clock Queue and
  ConnectX-7+ wait-on-time) with separate requirements tables
- Clarifies that tx_pp is specific to ConnectX-6 Dx
- Fixes tx_skew applicability to cover both hardware generations
- Updates the Send Scheduling Counters intro to reflect that timestamp
  validation counters also apply to ConnectX-7+ wait-on-time mode

Fixes: 8f848f32fc24 ("net/mlx5: introduce send scheduling devargs")

Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 doc/guides/nics/mlx5.rst | 109 ++++++++++++++++++++++++++++-----------
 1 file changed, 78 insertions(+), 31 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 2529c2f4c8..5b097dbc90 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -553,27 +553,32 @@ for an additional list of options shared with other mlx5 drivers.
 
 - ``tx_pp`` parameter [int]
 
+  This parameter applies to **ConnectX-6 Dx** only.
   If a nonzero value is specified the driver creates all necessary internal
-  objects to provide accurate packet send scheduling on mbuf timestamps.
+  objects (Clock Queue and Rearm Queue) to provide accurate packet send
+  scheduling on mbuf timestamps using a cross-channel approach.
   The positive value specifies the scheduling granularity in nanoseconds,
   the packet send will be accurate up to specified digits. The allowed range is
   from 500 to 1 million of nanoseconds. The negative value specifies the module
   of granularity and engages the special test mode the check the schedule rate.
   By default (if the ``tx_pp`` is not specified) send scheduling on timestamps
-  feature is disabled.
+  feature is disabled on ConnectX-6 Dx.
 
-  Starting with ConnectX-7 the capability to schedule traffic directly
-  on timestamp specified in descriptor is provided,
-  no extra objects are needed anymore and scheduling capability
-  is advertised and handled regardless ``tx_pp`` parameter presence.
+  Starting with **ConnectX-7** the hardware provides a native wait-on-time
+  capability that inserts the scheduling delay directly in the WQE descriptor.
+  No Clock Queue or Rearm Queue is needed and the ``tx_pp`` parameter is not
+  required. The driver automatically advertises send scheduling support when
+  the HCA wait-on-time capability is detected. The ``tx_skew`` parameter can
+  still be used on ConnectX-7 and above to compensate for wire delay.
 
 - ``tx_skew`` parameter [int]
 
   The parameter adjusts the send packet scheduling on timestamps and represents
   the average delay between beginning of the transmitting descriptor processing
   by the hardware and appearance of actual packet data on the wire. The value
-  should be provided in nanoseconds and is valid only if ``tx_pp`` parameter is
-  specified. The default value is zero.
+  should be provided in nanoseconds and applies to both ConnectX-6 Dx
+  (with ``tx_pp``) and ConnectX-7+ (wait-on-time) scheduling modes.
+  The default value is zero.
 
 - ``tx_vec_en`` parameter [int]
 
@@ -883,9 +888,13 @@ Send Scheduling Counters
 
 The mlx5 PMD provides a comprehensive set of counters designed for
 debugging and diagnostics related to packet scheduling during transmission.
-These counters are applicable only if the port was configured with the ``tx_pp`` devarg
-and reflect the status of the PMD scheduling infrastructure
-based on Clock and Rearm Queues, used as a workaround on ConnectX-6 DX NICs.
+The first group of counters (prefixed ``tx_pp_``) reflects the status of the
+Clock Queue and Rearm Queue infrastructure used on ConnectX-6 Dx and is
+applicable only if the port was configured with the ``tx_pp`` devarg.
+The timestamp validation counters
+(``tx_pp_timestamp_past_errors``, ``tx_pp_timestamp_future_errors``,
+``tx_pp_timestamp_order_errors``) are also reported on ConnectX-7 and above
+in wait-on-time mode, without requiring ``tx_pp``.
 
 ``tx_pp_missed_interrupt_errors``
   Indicates that the Rearm Queue interrupt was not serviced on time.
@@ -1960,31 +1969,54 @@ Limitations
 Tx Scheduling
 ~~~~~~~~~~~~~
 
-When PMD sees the ``RTE_MBUF_DYNFLAG_TX_TIMESTAMP_NAME`` set on the packet
-being sent it tries to synchronize the time of packet appearing on
-the wire with the specified packet timestamp. If the specified one
-is in the past it should be ignored, if one is in the distant future
-it should be capped with some reasonable value (in range of seconds).
-These specific cases ("too late" and "distant future") can be optionally
-reported via device xstats to assist applications to detect the
-time-related problems.
-
-The timestamp upper "too-distant-future" limit
-at the moment of invoking the Tx burst routine
-can be estimated as ``tx_pp`` option (in nanoseconds) multiplied by 2^23.
+When the PMD sees ``RTE_MBUF_DYNFLAG_TX_TIMESTAMP_NAME`` set on a packet
+being sent it inserts a dedicated WAIT WQE to synchronize the time of the
+packet appearing on the wire with the specified timestamp. Every packet
+in a burst that carries the timestamp dynamic flag is individually
+scheduled -- there is no restriction to the first packet only.
+
+If the specified timestamp is in the past, the packet is sent immediately.
+If it is in the distant future it should be capped with some reasonable
+value (in range of seconds). These specific cases ("too late" and
+"distant future") can be optionally reported via device xstats to assist
+applications to detect time-related problems.
+
+The eMPW (enhanced Multi-Packet Write) data path automatically breaks
+the batch when a timestamped packet is encountered, ensuring each
+scheduled packet gets its own WAIT WQE.
+
+Two hardware mechanisms are supported:
+
+**ConnectX-6 Dx -- Clock Queue (cross-channel)**
+   The driver creates a Clock Queue and a Rearm Queue that together
+   provide a time reference for scheduling. This mode requires the
+   :ref:`tx_pp <mlx5_tx_pp_param>` devarg. The timestamp upper
+   "too-distant-future" limit at the moment of invoking the Tx burst
+   routine can be estimated as ``tx_pp`` (in nanoseconds) multiplied
+   by 2^23.
+
+**ConnectX-7 and above -- wait-on-time**
+   The hardware supports placing the scheduling delay directly inside
+   the WQE descriptor. No Clock Queue or Rearm Queue is needed and the
+   ``tx_pp`` devarg is **not** required. The driver automatically
+   advertises send scheduling support when the HCA wait-on-time
+   capability is detected.
+
 Please note, for the testpmd txonly mode,
 the limit is deduced from the expression::
 
    (n_tx_descriptors / burst_size + 1) * inter_burst_gap
 
-There is no any packet reordering according timestamps is supposed,
-neither within packet burst, nor between packets, it is an entirely
-application responsibility to generate packets and its timestamps
-in desired order.
+There is no packet reordering according to timestamps,
+neither within a packet burst, nor between packets. It is entirely the
+application's responsibility to generate packets and their timestamps
+in the desired order.
 
 Requirements
 ^^^^^^^^^^^^
 
+ConnectX-6 Dx (Clock Queue mode):
+
 =========  =============
 Minimum    Version
 =========  =============
@@ -1996,20 +2028,35 @@ rdma-core
 DPDK       20.08
 =========  =============
 
+ConnectX-7 and above (wait-on-time mode):
+
+=========  =============
+Minimum    Version
+=========  =============
+hardware   ConnectX-7
+=========  =============
+
 Firmware configuration
 ^^^^^^^^^^^^^^^^^^^^^^
 
 Runtime configuration
 ^^^^^^^^^^^^^^^^^^^^^
 
-To provide the packet send scheduling on mbuf timestamps the ``tx_pp``
-parameter should be specified.
+**ConnectX-6 Dx**: the :ref:`tx_pp <mlx5_tx_pp_param>` parameter must be
+specified to enable send scheduling on mbuf timestamps.
+
+**ConnectX-7+**: no devarg is required. Send scheduling is automatically
+enabled when the HCA reports the wait-on-time capability.
+
+On both hardware generations the ``tx_skew`` parameter can be used to
+compensate for the delay between descriptor processing and actual wire
+time.
 
 Limitations
 ^^^^^^^^^^^
 
-#. The timestamps can be put only in the first packet
-   in the burst providing the entire burst scheduling.
+#. On ConnectX-6 Dx (Clock Queue mode) timestamps too far in the future
+   are capped (see the ``tx_pp`` x 2^23 limit above).
 
 
 .. _mlx5_tx_inline:
-- 
2.43.0

