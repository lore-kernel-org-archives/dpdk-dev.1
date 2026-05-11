Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF572CD37BE
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 16:00:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8959402D9;
	Mon, 11 May 2026 18:00:26 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id A93A6402D5
 for <dev@dpdk.org>; Mon, 11 May 2026 18:00:25 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-8b45dff1eebso43342036d6.2
 for <dev@dpdk.org>; Mon, 11 May 2026 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778515225; x=1779120025; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38tL7+Yj57GU099anHDUiC2wIPweQFNbdKQLgDiVjK0=;
 b=cwVIPovSel+0ntrjqzA9KjH0XwtDPWeH4EuPXkY6uVEL1DGkFSg3Ki0hXiHVbX2Rzv
 hfpRZFtdCz2Om401YruRKGmM59BTzVuTDVmnUSfCJB9TnvDD/O2nBr8/aqipuTW6oU1o
 BMVtQEzlVH6PvMjq34WV1NTWcEANTi+FOGmYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778515225; x=1779120025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=38tL7+Yj57GU099anHDUiC2wIPweQFNbdKQLgDiVjK0=;
 b=MoiZHi/UlAbvYsA8lFCkGPKXvN+B5LDwffSymFQH9bT49ehdklI0Rk+wg4QxRPueM1
 HH3E0JlxsGqeExnD8x6IEOmfVMbobMN/a6X43iEQikPDX8pxXZJsGKPJ4WMUW2caZaOz
 0RRBPvUPB6w9ovON2zYwFE05q/Lg0B4UGEpl5iC1Nfp0nKE92x55eUKqFyIaclnp8Fcd
 TZZKqRqHWhhzf2jpCiXzjA/knweaMPiHp7lepbdsX977uQLh0v+8H26JDg7EoCaiqoqt
 OXAF+pU1g7Ecqn0G6dlX9UxhzgT+M0rnWVFl6NHWyzB8zl51Uab9w20Lf3EqxNbSamxr
 QxCw==
X-Gm-Message-State: AOJu0YzWyQ4h2Dwy7cFd+Whv/7g3FT/leyeAw6KIsDiG1+eKx7HCgC5R
 0Cv2CbgVUiS4E1xZm++UigFsiV2gF62jIXjLWrmCACKQE+AlmqnzfwGkJotA1YqC9FA=
X-Gm-Gg: Acq92OEyQm/Rq+etjlh+S1xaLY6zImICBDp7+GXm+toe17KCnc8R3c47DQW6839YUDn
 1lNPrJBYTDS+dNjeNnLBwm9wr9K0nVYS37jBvxay3dYH3igSV6ehQU5zvqTvhk2R6nYLNCql5fV
 EpU6CarAVYw6M0yNw9r/gvl7eZX1iR3FSTOgpHZeoyFNw/h6LFJxq1BqKx9GwZevDj2MLDN+pyx
 TkSnwMuhgV1NbSKHgXGfyiA87XUvI94BKv3PYdTnIS06AYar8IplIFIA2y849/RJmAWw/GuvXRs
 CgJyzNaeNcigZl4RVzSaqB4GRBw9E2Gqiperz0syL3HINAKm+FiQfhleNHuN6Q5jQo7mPdwMtpI
 qZujyczhWY1j0UbSnCCaTgAljg1WMPdJ2ey0VkmSC/fNPVPR7OUvJen5pS6SkMJPM79REyauv22
 zPm0ApvyUcpVrdXFGE0qQK8aJnBWWLyLEMu1fr8TCJYDCX754CMcPtWY4CbR8J6BeB/x8D5/U8x
 QA=
X-Received: by 2002:a05:6214:3292:b0:8ac:b4b3:3ce2 with SMTP id
 6a1803df08f44-8bc453692b5mr377253986d6.41.1778515224540; 
 Mon, 11 May 2026 09:00:24 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53ca982a1sm346255656d6.38.2026.05.11.09.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 09:00:24 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, knimoji@iol.unh.edu,
 ahassick@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4] dts: update test suite names to be clear and consistent
Date: Mon, 11 May 2026 12:00:13 -0400
Message-ID: <20260511160013.78676-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260508141319.52648-1-abailey@iol.unh.edu>
References: <20260508141319.52648-1-abailey@iol.unh.edu>
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
Other test suites used inconsistent naming schemes which this patch
makes uniform. For example, some suites had abbreviated words that
others had not. These words are no longer abbreviated among any test
suite.

Bugzilla ID: 1826

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/api/dts/tests.TestSuite_buffer_scatter.rst            | 8 ++++++++
 doc/api/dts/tests.TestSuite_flow_offload.rst              | 8 ++++++++
 doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst        | 8 --------
 doc/api/dts/tests.TestSuite_pmd_rss.rst                   | 8 --------
 doc/api/dts/tests.TestSuite_queue_start_stop.rst          | 8 --------
 doc/api/dts/tests.TestSuite_queue_toggle.rst              | 8 ++++++++
 ...ests.TestSuite_uni_pkt.rst => tests.TestSuite_rss.rst} | 6 +++---
 doc/api/dts/tests.TestSuite_rte_flow.rst                  | 8 --------
 doc/api/dts/tests.TestSuite_unified_packet.rst            | 8 ++++++++
 doc/api/dts/tests.TestSuite_virtio_forward.rst            | 8 ++++++++
 doc/api/dts/tests.TestSuite_virtio_fwd.rst                | 8 --------
 ..._pmd_buffer_scatter.py => TestSuite_buffer_scatter.py} | 2 +-
 .../{TestSuite_rte_flow.py => TestSuite_flow_offload.py}  | 4 ++--
 ...uite_queue_start_stop.py => TestSuite_queue_toggle.py} | 2 +-
 dts/tests/{TestSuite_pmd_rss.py => TestSuite_rss.py}      | 4 ++--
 .../{TestSuite_uni_pkt.py => TestSuite_unified_packet.py} | 2 +-
 ...estSuite_virtio_fwd.py => TestSuite_virtio_forward.py} | 2 +-
 17 files changed, 51 insertions(+), 51 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_buffer_scatter.rst
 create mode 100644 doc/api/dts/tests.TestSuite_flow_offload.rst
 delete mode 100644 doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
 delete mode 100644 doc/api/dts/tests.TestSuite_pmd_rss.rst
 delete mode 100644 doc/api/dts/tests.TestSuite_queue_start_stop.rst
 create mode 100644 doc/api/dts/tests.TestSuite_queue_toggle.rst
 rename doc/api/dts/{tests.TestSuite_uni_pkt.rst => tests.TestSuite_rss.rst} (50%)
 delete mode 100644 doc/api/dts/tests.TestSuite_rte_flow.rst
 create mode 100644 doc/api/dts/tests.TestSuite_unified_packet.rst
 create mode 100644 doc/api/dts/tests.TestSuite_virtio_forward.rst
 delete mode 100644 doc/api/dts/tests.TestSuite_virtio_fwd.rst
 rename dts/tests/{TestSuite_pmd_buffer_scatter.py => TestSuite_buffer_scatter.py} (99%)
 rename dts/tests/{TestSuite_rte_flow.py => TestSuite_flow_offload.py} (99%)
 rename dts/tests/{TestSuite_queue_start_stop.py => TestSuite_queue_toggle.py} (99%)
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
diff --git a/doc/api/dts/tests.TestSuite_uni_pkt.rst b/doc/api/dts/tests.TestSuite_rss.rst
similarity index 50%
rename from doc/api/dts/tests.TestSuite_uni_pkt.rst
rename to doc/api/dts/tests.TestSuite_rss.rst
index 95c5a5a28b..ecd8676b09 100644
--- a/doc/api/dts/tests.TestSuite_uni_pkt.rst
+++ b/doc/api/dts/tests.TestSuite_rss.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: BSD-3-Clause
 
-uni_pkt Test Suite
-==================
+rss Test Suite
+==============
 
-.. automodule:: tests.TestSuite_uni_pkt
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
diff --git a/doc/api/dts/tests.TestSuite_virtio_fwd.rst b/doc/api/dts/tests.TestSuite_virtio_fwd.rst
deleted file mode 100644
index e40cc4ca2b..0000000000
--- a/doc/api/dts/tests.TestSuite_virtio_fwd.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-virtio_fwd Test Suite
-=====================
-
-.. automodule:: tests.TestSuite_virtio_fwd
-   :members:
-   :show-inheritance:
diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_buffer_scatter.py
similarity index 99%
rename from dts/tests/TestSuite_pmd_buffer_scatter.py
rename to dts/tests/TestSuite_buffer_scatter.py
index 96da67ee7d..539082f2e4 100644
--- a/dts/tests/TestSuite_pmd_buffer_scatter.py
+++ b/dts/tests/TestSuite_buffer_scatter.py
@@ -35,7 +35,7 @@
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
-class TestPmdBufferScatter(TestSuite):
+class TestBufferScatter(TestSuite):
     """DPDK PMD packet scattering test suite.
 
     Configure the Rx queues to have mbuf data buffers
diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_flow_offload.py
similarity index 99%
rename from dts/tests/TestSuite_rte_flow.py
rename to dts/tests/TestSuite_flow_offload.py
index 6255e4c36d..be11d09875 100644
--- a/dts/tests/TestSuite_rte_flow.py
+++ b/dts/tests/TestSuite_flow_offload.py
@@ -402,8 +402,8 @@ def generate(
 
 
 @requires_nic_capability(NicCapability.FLOW_CTRL)
-class TestRteFlow(TestSuite):
-    """RTE Flow test suite.
+class TestFlowOffload(TestSuite):
+    """Flow offload test suite.
 
     This suite consists of 4 test cases:
     1. Queue Action: Verifies queue actions with multi-protocol patterns
diff --git a/dts/tests/TestSuite_queue_start_stop.py b/dts/tests/TestSuite_queue_toggle.py
similarity index 99%
rename from dts/tests/TestSuite_queue_start_stop.py
rename to dts/tests/TestSuite_queue_toggle.py
index e9048d4245..e4edc89123 100644
--- a/dts/tests/TestSuite_queue_start_stop.py
+++ b/dts/tests/TestSuite_queue_toggle.py
@@ -32,7 +32,7 @@
 @requires_link_topology(LinkTopology.TWO_LINKS)
 @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
 @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
-class TestQueueStartStop(TestSuite):
+class TestQueueToggle(TestSuite):
     """DPDK Queue start/stop test suite.
 
     Ensures Rx/Tx queue on a port can be disabled and enabled.
diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_rss.py
similarity index 99%
rename from dts/tests/TestSuite_pmd_rss.py
rename to dts/tests/TestSuite_rss.py
index f6adf262c3..2747c8a36c 100644
--- a/dts/tests/TestSuite_pmd_rss.py
+++ b/dts/tests/TestSuite_rss.py
@@ -55,8 +55,8 @@ class HashAlgorithm(StrEnum):
 
 @requires_link_topology(LinkTopology.ONE_LINK)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_RSS_HASH)
-class TestPmdRss(TestSuite):
-    """PMD RSS test suite."""
+class TestRss(TestSuite):
+    """RSS test suite."""
 
     config: Config
 
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_unified_packet.py
similarity index 99%
rename from dts/tests/TestSuite_uni_pkt.py
rename to dts/tests/TestSuite_unified_packet.py
index 222276ce67..fcc7f7fbbb 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_unified_packet.py
@@ -31,7 +31,7 @@
 from framework.test_suite import TestSuite, func_test
 
 
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

