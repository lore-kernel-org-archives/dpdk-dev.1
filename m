Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64620CD3445
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 14:13:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FA6440150;
	Fri,  8 May 2026 16:13:34 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id D2CBC4013F
 for <dev@dpdk.org>; Fri,  8 May 2026 16:13:32 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8b45dff1eebso19374416d6.2
 for <dev@dpdk.org>; Fri, 08 May 2026 07:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778249612; x=1778854412; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGvnH6bixu3GjPXZhm1qDeooqeo7zNw28GvC5KljtFU=;
 b=QSOJ/Hnbw9kMV6Wa4ssXAANC5p+aYdO4auPBXlq5kpUBakeUwVt2CsxPS1jNMRKh8n
 bmvO0Onw7iI5YeNppMNfFHJhlBnqII657wNfFg374H521ppTgsD5EAXHE3+rCqo9B9US
 K2ff5kaJXso08oRrEc20W4s8NqNNWhxq7+AcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778249612; x=1778854412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YGvnH6bixu3GjPXZhm1qDeooqeo7zNw28GvC5KljtFU=;
 b=J1ayoux8zs0bJbDzqiy+uO6MbtaMPt3SLTnhxwbSouLApT5mCZac59FBrgVmESFpWa
 z39NbPbv7fHtBiWmBCf2yisFXzVmD/ulzdtWIzgiDJyBc7p7Wuh6DBdp61xAzkg7E19b
 DoVwYoBr7j6aF3dobwQjLuuGi/qm6keCZ7daCT8PqFKIaETQXYvjF+egmnqifrgqzoVd
 uOlw0Zy4cKCQrjFr12i5p3GNCHysi/Nb8BORyqxFkGW6WcEZWvSvBglpRMJaRkC29rRX
 wAxUzTflEWxvqBaSue5HPBiuvez/Xx0byT8dGCOKaZo08a4sOvatlw/+qQqBEXzQx4HA
 tBCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rKf2NWckV0yrBLcykGILmN0Ssb2RcCDlltwzXwFLHfDVrkKAKVnv161TDOQqzDBbaoIw=@dpdk.org
X-Gm-Message-State: AOJu0Ywf8olJc0n6KyYwi0Q+4k58S1vHpnsUthedt2uu4uhCg2VJIPHy
 jgXq9wxp7ZYrHiUl4ZpP8JVrpaF/SjHBulZiNLfU54fpEpb/FPzjm/TryB64Wduvvog=
X-Gm-Gg: Acq92OGGJDNHqhvaC11zudKHKjrL065odXW9QR/5fcfFV0c/iEb83lpuPLBxHZtYYSh
 uDHaJl/DTHCIb74fQWR+YCHEucwDbP5yQyd/+ElnIFB/AKDQQ9c8ba3o+U0YMVTDVwEwdoaR6+h
 QueyT8BbIOt5X9Cep8hYrzgGPWEsMezn54+od4gTkwe4amvxxkQ1VggUkLcx/wwPuhQKC8ZdNTw
 Icfd/IsD7/vX4hj+N9/97NMIDrEPq+ur/ht+e58lpvYBX2lkTzFE4+5rGVDqYukA/1T0nzoMa7z
 XszLUEM9iDnwNbA2dQtn4zxLEgcDxB/bVgptQqH8WaGsXIBqjfPgdCRanOEK+BjubhlZo0HIQfs
 uNRi3nSsxaVeWQfBJuujYXXzxXiM4T3cOiN4NmH5EiTkWsHFI8bETX8UrS2c4yCup3IOrqVZa66
 NK/V1juLRrzy5ownexvRQyIchni1FjAiuaNR48WR9gIHWp1e+jfkA9hsIqIdh2cn5x
X-Received: by 2002:a05:6214:19cc:b0:8a5:fcce:1da5 with SMTP id
 6a1803df08f44-8bc41bcde52mr192103886d6.10.1778249611813; 
 Fri, 08 May 2026 07:13:31 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7e032sm18418136d6.32.2026.05.08.07.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 07:13:31 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: lylavoie@iol.unh.edu, ahassick@iol.unh.edu, knimoji@iol.unh.edu,
 dev@dpdk.org, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3] dts: update test suite names to be clear and consistent
Date: Fri,  8 May 2026 10:13:19 -0400
Message-ID: <20260508141319.52648-1-abailey@iol.unh.edu>
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
Other test suites used inconsistent naming schemes which this patch
makes uniform. For example, some suites had abbreviated words that
others had not. These words are no longer abbreviated among any test
suite.

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
 ..._pmd_buffer_scatter.py => TestSuite_buffer_scatter.py} | 2 +-
 .../{TestSuite_rte_flow.py => TestSuite_flow_offload.py}  | 4 ++--
 dts/tests/{TestSuite_l2fwd.py => TestSuite_l2_forward.py} | 2 +-
 ...uite_queue_start_stop.py => TestSuite_queue_toggle.py} | 2 +-
 dts/tests/{TestSuite_pmd_rss.py => TestSuite_rss.py}      | 4 ++--
 .../{TestSuite_uni_pkt.py => TestSuite_unified_packet.py} | 2 +-
 ...estSuite_virtio_fwd.py => TestSuite_virtio_forward.py} | 2 +-
 19 files changed, 54 insertions(+), 54 deletions(-)
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
 rename dts/tests/{TestSuite_pmd_buffer_scatter.py => TestSuite_buffer_scatter.py} (99%)
 rename dts/tests/{TestSuite_rte_flow.py => TestSuite_flow_offload.py} (99%)
 rename dts/tests/{TestSuite_l2fwd.py => TestSuite_l2_forward.py} (98%)
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

