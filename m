Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2078E7DF0D
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:09:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11F39402A2;
	Mon,  2 Feb 2026 18:09:30 +0100 (CET)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 95C924027D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:09:28 +0100 (CET)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-8947e6ffd20so61496066d6.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 09:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770052168; x=1770656968; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERnO4c6JFlAkoOxMHlcVW0BftQOGsywFhgFNpo1IPrs=;
 b=h2udO4XZsat4hx6ytbYnd+eyDupVmJLxzwuj11HqH07ydJDy0x47P9wLBX29sWEZM2
 X83COEOtbi57kq77GG06C4Byk/vEBLC2UqKaCtPiCHCXh64R3aXj+QS/vq6AMKjVjBo+
 JtRkVZGI0nWKO07G2n1ZBvSaHJ8rgnRyguxUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770052168; x=1770656968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ERnO4c6JFlAkoOxMHlcVW0BftQOGsywFhgFNpo1IPrs=;
 b=YYheBV9bm/870794rUZwfWNgtnAfQ2Sbv5FvIU6uJxCKOxWSlXtUr8RmrxZar/m4iT
 0xrNW5iBvAH3PxHF6TKempf5f2eJtqkb+cXyyYv9FoZ0T+ptdEaDi0Xv2f2cSWwEDNqC
 icqY5C8P1awB8XXX7Dq9IBRZGmGJkqplDlbQMI+yc6Q7T79LPhBzEhbJXliuxbHCN8LQ
 4FHdR017dMEc2Zcj/2OPT3qVK6vzC5EaNvDJ/K+7Uq/xihC4SXto31RA5MeDqkiXpIfh
 y7wJaIdVdwbO+KBeNGEHoXv3gu3YVH2Mk8i5Dexy3v61alprPqJreGZQBSNq7H5kdJ+J
 FaMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtcHlWB7jjrwpjLTxyVOz44DdMRRoFWAw32Q0h4+B2NTBpYo6xJldndYphjuYp5XWF/3o=@dpdk.org
X-Gm-Message-State: AOJu0YxgwLiWWzPxLnsjJfcDJ/9bJYymv5A5WfbjhvtBCWPpKEg7osrt
 3HmOFWk4U+IF3EzWtPYWveaFv9PyGkg+NONnjQB2GAiM7GAArnH8kBIRbo4Kgp+EVuI=
X-Gm-Gg: AZuq6aIiOTD7/lxBYwJEjQtgyEzgAHlmX+1kCyG5QuKS/hwLWDRY2vDJOFKhXEA2iK6
 ExjwnWtT3iShwdZ4WLx017nMSo1DWGz52TphYgrYFmdqfmbDjo9WltuwKL/gRV2efyAzwUxo2L/
 gBM9nluCrlLY1lL6Xf8mZz/SGEUprl63R7+q9HzKWLf9dtdkohV9lUaz/jWG8U/c02XyDQhiwAN
 scQ/Vlvj5RfFXwJDbXcKWIn3aZwaNHtHMz+8C82IUC4EFsj3TLOyB49DO1WRQm0fGbdBFxFOfMh
 vZ9yi+vAfxJGJhVfTmlLMBaJRKESzEFl7LGJuWEfJweRfOzzpMFCVOodMOXkUzobLGRc9GdPPGb
 d+ESgQhI9hDZspto4GwoNjmV1IOAq/ClwbxUsBITBFaEa2r323xFxTTR5uqhtTyVRZh1JuY1fte
 kEJwN1YOjYQURzLMHMVbLYIPVkTpSXv5suQINXtkn0LzvbCjCQrZ5jWOipwOppLE4=
X-Received: by 2002:a05:6214:1315:b0:894:6622:a6d4 with SMTP id
 6a1803df08f44-894ea0912c6mr161877566d6.61.1770052167711; 
 Mon, 02 Feb 2026 09:09:27 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d36a9b5bsm120465256d6.5.2026.02.02.09.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:09:27 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dmarx@iol.unh.edu, luca.vizzarro@arm.com, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: update testsuite named to be clear and consistent
Date: Mon,  2 Feb 2026 12:09:24 -0500
Message-ID: <20260202170924.398261-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251218150718.738116-1-abailey@iol.unh.edu>
References: <20251218150718.738116-1-abailey@iol.unh.edu>
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

Some test suites were prefixed with PMD which is not meaningful.
Other test suites used different naming schemes and this patch updates
this. For example, some abbreviated words that others had not. These
word are no longer abbreviated.

Bugzilla ID: 1826

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/api/dts/tests.TestSuite_buffer_scatter.rst            | 8 ++++++++
 doc/api/dts/tests.TestSuite_flow_offload.rst              | 8 ++++++++
 ...uite_virtio_fwd.rst => tests.TestSuite_l2_forward.rst} | 4 ++--
 doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst        | 8 --------
 doc/api/dts/tests.TestSuite_pmd_rss.rst                   | 8 --------
 doc/api/dts/tests.TestSuite_queue_start_stop.rst          | 8 --------
 doc/api/dts/tests.TestSuite_queue_toggle.rst              | 8 ++++++++
 ...{tests.TestSuite_l2fwd.rst => tests.TestSuite_rss.rst} | 6 +++---
 doc/api/dts/tests.TestSuite_rte_flow.rst                  | 8 --------
 doc/api/dts/tests.TestSuite_uni_pkt.rst                   | 8 --------
 doc/api/dts/tests.TestSuite_unified_packet.rst            | 8 ++++++++
 doc/api/dts/tests.TestSuite_virtio_forward.rst            | 8 ++++++++
 ..._pmd_buffer_scatter.py => TestSuite_buffer_scatter.py} | 4 ++--
 .../{TestSuite_rte_flow.py => TestSuite_flow_offload.py}  | 6 +++---
 dts/tests/{TestSuite_l2fwd.py => TestSuite_l2_forward.py} | 2 +-
 ...uite_queue_start_stop.py => TestSuite_queue_toggle.py} | 6 +++---
 dts/tests/{TestSuite_pmd_rss.py => TestSuite_rss.py}      | 2 +-
 .../{TestSuite_uni_pkt.py => TestSuite_unified_packet.py} | 2 +-
 ...estSuite_virtio_fwd.py => TestSuite_virtio_forward.py} | 2 +-
 19 files changed, 57 insertions(+), 57 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_buffer_scatter.rst
 create mode 100644 doc/api/dts/tests.TestSuite_flow_offload.rst
 rename doc/api/dts/{tests.TestSuite_virtio_fwd.rst => tests.TestSuite_l2_forward.rst} (60%)
 delete mode 100644 doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
 delete mode 100644 doc/api/dts/tests.TestSuite_pmd_rss.rst
 delete mode 100644 doc/api/dts/tests.TestSuite_queue_start_stop.rst
 create mode 100644 doc/api/dts/tests.TestSuite_queue_toggle.rst
 rename doc/api/dts/{tests.TestSuite_l2fwd.rst => tests.TestSuite_rss.rst} (52%)
 delete mode 100644 doc/api/dts/tests.TestSuite_rte_flow.rst
 delete mode 100644 doc/api/dts/tests.TestSuite_uni_pkt.rst
 create mode 100644 doc/api/dts/tests.TestSuite_unified_packet.rst
 create mode 100644 doc/api/dts/tests.TestSuite_virtio_forward.rst
 rename dts/tests/{TestSuite_pmd_buffer_scatter.py => TestSuite_buffer_scatter.py} (98%)
 rename dts/tests/{TestSuite_rte_flow.py => TestSuite_flow_offload.py} (99%)
 rename dts/tests/{TestSuite_l2fwd.py => TestSuite_l2_forward.py} (98%)
 rename dts/tests/{TestSuite_queue_start_stop.py => TestSuite_queue_toggle.py} (97%)
 rename dts/tests/{TestSuite_pmd_rss.py => TestSuite_rss.py} (99%)
 rename dts/tests/{TestSuite_uni_pkt.py => TestSuite_unified_packet.py} (99%)
 rename dts/tests/{TestSuite_virtio_fwd.py => TestSuite_virtio_forward.py} (99%)

diff --git a/doc/api/dts/tests.TestSuite_buffer_scatter.rst b/doc/api/dts/tests.TestSuite_buffer_scatter.rst
new file mode 100644
index 0000000000..ce764ff0d6
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_buffer_scatter.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+buffer_scatter Test Suite
+=========================
+
+.. automodule:: tests.TestSuite_buffer_scatter
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_flow_offload.rst b/doc/api/dts/tests.TestSuite_flow_offload.rst
new file mode 100644
index 0000000000..5fcd3f57c3
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_flow_offload.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+flow_offload Test Suite
+=======================
+
+.. automodule:: tests.TestSuite_flow_offload
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_virtio_fwd.rst b/doc/api/dts/tests.TestSuite_l2_forward.rst
similarity index 60%
rename from doc/api/dts/tests.TestSuite_virtio_fwd.rst
rename to doc/api/dts/tests.TestSuite_l2_forward.rst
index e40cc4ca2b..3570a1e101 100644
--- a/doc/api/dts/tests.TestSuite_virtio_fwd.rst
+++ b/doc/api/dts/tests.TestSuite_l2_forward.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: BSD-3-Clause
 
-virtio_fwd Test Suite
+l2_forward Test Suite
 =====================
 
-.. automodule:: tests.TestSuite_virtio_fwd
+.. automodule:: tests.TestSuite_l2_forward
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst b/doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
deleted file mode 100644
index cdf30fd879..0000000000
--- a/doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-pmd_buffer_scatter Test Suite
-=============================
-
-.. automodule:: tests.TestSuite_pmd_buffer_scatter
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_pmd_rss.rst b/doc/api/dts/tests.TestSuite_pmd_rss.rst
deleted file mode 100644
index 942fa5ebdc..0000000000
--- a/doc/api/dts/tests.TestSuite_pmd_rss.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-pmd_rss Test Suite
-==================
-
-.. automodule:: tests.TestSuite_pmd_rss
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_queue_start_stop.rst b/doc/api/dts/tests.TestSuite_queue_start_stop.rst
deleted file mode 100644
index 87121676fb..0000000000
--- a/doc/api/dts/tests.TestSuite_queue_start_stop.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-queue_start_stop Test Suite
-===========================
-
-.. automodule:: tests.TestSuite_queue_start_stop
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_queue_toggle.rst b/doc/api/dts/tests.TestSuite_queue_toggle.rst
new file mode 100644
index 0000000000..1d6345511f
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_queue_toggle.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+queue_toggle Test Suite
+=======================
+
+.. automodule:: tests.TestSuite_queue_toggle
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_l2fwd.rst b/doc/api/dts/tests.TestSuite_rss.rst
similarity index 52%
rename from doc/api/dts/tests.TestSuite_l2fwd.rst
rename to doc/api/dts/tests.TestSuite_rss.rst
index 5a0ca312e9..ecd8676b09 100644
--- a/doc/api/dts/tests.TestSuite_l2fwd.rst
+++ b/doc/api/dts/tests.TestSuite_rss.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: BSD-3-Clause
 
-l2fwd Test Suite
-================
+rss Test Suite
+==============
 
-.. automodule:: tests.TestSuite_l2fwd
+.. automodule:: tests.TestSuite_rss
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_rte_flow.rst b/doc/api/dts/tests.TestSuite_rte_flow.rst
deleted file mode 100644
index eacbfd3a2a..0000000000
--- a/doc/api/dts/tests.TestSuite_rte_flow.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-rte_flow Test Suite
-===================
-
-.. automodule:: tests.TestSuite_rte_flow
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_uni_pkt.rst b/doc/api/dts/tests.TestSuite_uni_pkt.rst
deleted file mode 100644
index 95c5a5a28b..0000000000
--- a/doc/api/dts/tests.TestSuite_uni_pkt.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-uni_pkt Test Suite
-==================
-
-.. automodule:: tests.TestSuite_uni_pkt
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_unified_packet.rst b/doc/api/dts/tests.TestSuite_unified_packet.rst
new file mode 100644
index 0000000000..dddf12b18a
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_unified_packet.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+unified_packet Test Suite
+=========================
+
+.. automodule:: tests.TestSuite_unified_packet
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_virtio_forward.rst b/doc/api/dts/tests.TestSuite_virtio_forward.rst
new file mode 100644
index 0000000000..9178c73be5
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_virtio_forward.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+virtio_forward Test Suite
+=========================
+
+.. automodule:: tests.TestSuite_virtio_forward
+   :members:
+   :show-inheritance:
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_buffer_scatter.py
similarity index 98%
rename from dts/tests/TestSuite_pmd_buffer_scatter.py
rename to dts/tests/TestSuite_buffer_scatter.py
index 96da67ee7d..48c0167de6 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_buffer_scatter.py
@@ -35,8 +35,8 @@
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
-class TestPmdBufferScatter(TestSuite):
-    """DPDK PMD packet scattering test suite.
+class TestBufferScatter(TestSuite):
+    """DPDK packet scattering test suite.
 
     Configure the Rx queues to have mbuf data buffers
     whose sizes are smaller than the maximum packet size.
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_flow_offload.py
similarity index 99%
rename from dts/tests/TestSuite_rte_flow.py
rename to dts/tests/TestSuite_flow_offload.py
index 207cbce2d3..7339749908 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_flow_offload.py
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2025 University of New Hampshire
 
-"""RTE Flow testing suite.
+"""Flow Offload testing suite.
 
 This suite verifies a range of flow rules built using patterns
 and actions from the RTE Flow API. It would be impossible to cover
@@ -32,8 +32,8 @@
 
 
 @requires_nic_capability(NicCapability.FLOW_CTRL)
-class TestRteFlow(TestSuite):
-    """RTE Flow test suite.
+class TestFlowOffload(TestSuite):
+    """Flow Offload test suite.
 
     This suite consists of 12 test cases:
     1. Queue Action Ethernet: Verifies queue actions with ethernet patterns
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2_forward.py
similarity index 98%
rename from dts/tests/TestSuite_l2fwd.py
rename to dts/tests/TestSuite_l2_forward.py
index 596b892730..95f9c62bdc 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2_forward.py
@@ -28,7 +28,7 @@
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_link_topology(LinkTopology.TWO_LINKS)
-class TestL2fwd(TestSuite):
+class TestL2Forward(TestSuite):
     """L2 forwarding test suite."""
 
     #: The total number of packets to generate and send for forwarding.
diff --git a/dts/tests/TestSuite_queue_start_stop.py b/dts/tests/TestSuite_queue_toggle.py
similarity index 97%
rename from dts/tests/TestSuite_queue_start_stop.py
rename to dts/tests/TestSuite_queue_toggle.py
index e9048d4245..50d371e975 100644
--- a/dts/tests/TestSuite_queue_start_stop.py
+++ b/dts/tests/TestSuite_queue_toggle.py
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2024 University of New Hampshire
 
-"""Rx/Tx queue start and stop functionality suite.
+"""Rx/Tx queue toggle functionality suite.
 
 This suite tests the ability of the poll mode driver to start and
 stop either the Rx or Tx queue (depending on the port) during runtime,
@@ -32,8 +32,8 @@
 @requires_link_topology(LinkTopology.TWO_LINKS)
 @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
 @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
-class TestQueueStartStop(TestSuite):
-    """DPDK Queue start/stop test suite.
+class TestQueueToggle(TestSuite):
+    """DPDK Queue toggle test suite.
 
     Ensures Rx/Tx queue on a port can be disabled and enabled.
     Verifies packets are not received when either queue is disabled.
diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_rss.py
similarity index 99%
rename from dts/tests/TestSuite_pmd_rss.py
rename to dts/tests/TestSuite_rss.py
index f6adf262c3..f941248d7a 100644
--- a/dts/tests/TestSuite_pmd_rss.py
+++ b/dts/tests/TestSuite_rss.py
@@ -55,7 +55,7 @@ class HashAlgorithm(StrEnum):
 
 @requires_link_topology(LinkTopology.ONE_LINK)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_RSS_HASH)
-class TestPmdRss(TestSuite):
+class TestRss(TestSuite):
     """PMD RSS test suite."""
 
     config: Config
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_unified_packet.py
similarity index 99%
rename from dts/tests/TestSuite_uni_pkt.py
rename to dts/tests/TestSuite_unified_packet.py
index 97d61cd03a..a35e25d25b 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_unified_packet.py
@@ -34,7 +34,7 @@
 
 
 @requires_link_topology(LinkTopology.TWO_LINKS)
-class TestUniPkt(TestSuite):
+class TestUnifiedPacket(TestSuite):
     """DPDK Unified packet test suite.
 
     This testing suite uses testpmd's verbose output hardware/software
diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio_forward.py
similarity index 99%
rename from dts/tests/TestSuite_virtio_fwd.py
rename to dts/tests/TestSuite_virtio_forward.py
index bdecdb76fd..6efaa4e156 100644
--- a/dts/tests/TestSuite_virtio_fwd.py
+++ b/dts/tests/TestSuite_virtio_forward.py
@@ -20,7 +20,7 @@
 from framework.testbed_model.virtual_device import VirtualDevice
 
 
-class TestVirtioFwd(TestSuite):
+class TestVirtioForward(TestSuite):
     """Virtio forwarding test suite."""
 
     virtio_user_vdev = VirtualDevice(
-- 
2.50.1

