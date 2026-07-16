Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC9C4450A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 10:38:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE47A40270;
	Thu, 16 Jul 2026 12:38:26 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id D75DE400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 12:38:24 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 78E3BEC01B0;
 Thu, 16 Jul 2026 06:38:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Thu, 16 Jul 2026 06:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1784198304; x=
 1784284704; bh=KFOmQ0NTeH5AEi/lVy9CBmL806RQvY1OvYEAFvFv2Ng=; b=M
 dtUCR2CZ1bXFmDAmsgPqdU2PWymtxpLBJsLpt+QDzuhkyyN5ex4y6jN0x2LjaqLz
 hWuGwEkmOKidl3Z+qRKCUyS7q+Yuu4FI/XIrMcv/rNwHOVzhYh13YiWJ1v2eSrNL
 5KBphsEMVIpB8ZgtidgJjCZ8rf1EcgHeF/ImU1B315GWAutSP/dUHoGXGqV9o0Dn
 3V1+Ffm/V7is3NFmBq4To1Ug+bR2g3fE/7CBJQ62g/tARt/Hc3afnRagVab1mRyx
 wPfdyz72DJbF/3QGCvJ8qoVEldT4wCGij0vKP80fe7dMXUhsrd/Sis4ugFW/isqV
 Xsok3CPdHl/jrLcJpulfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784198304; x=1784284704; bh=K
 FOmQ0NTeH5AEi/lVy9CBmL806RQvY1OvYEAFvFv2Ng=; b=dGwnJ4Wb3UIsdPiQh
 UQPjozNxWGfbBI2qQxz3L6cRR50TG8MPB4zSrfQAJOuFjYWg7M3ntKDijl9o6AgF
 iVA/rjXjGgZb/NnJhoo1sTkv76JYKBlBDjqsVSNCaAtrFnVTDjTCxLIri/2euVcb
 M2o4n6q6Bm7PgGDzDdJc6FVu2ZlligJRoy1+fGR18AmBfow76YWksk/qKA3HrdUi
 3fIPNFGVlt99v1oslKe/k4kh3Q8gZQojAKWjAaGUNSHE972Nmxe73+Om7q7yfm2g
 gpL8NTA3y2CSnI9WVHwzY4dcTrIlx6qdnCkD7t8boameDCKaZMhYye9eXkf7v8Gd
 7sqyw==
X-ME-Sender: <xms:oLRYasfcPzAI1oltH1h0GibdvGCRRWB1mgsJRxogFYibyS-IvdPEtQ>
 <xme:oLRYapLpL5Rz1FIRLRjSorvhuzwufgc9qIZ9GWVFs1Tq1uaizfO1l3a4yauDD_6Gv
 hLSLZu7piFgDvjSEOtj7ngYZpOm5wGuwh_yHO6JsNX8_O7Bh5QfJw>
X-ME-Received: <xmr:oLRYasgV4CA0KiQ0-ALzLM91xgSrhtU6sGwLAPfFOZo0CYyKeYE_qRw8JYVunqIgBXjgpciTifqvv5a84mVHCw0>
X-ME-Proxy-Cause: dmFkZTGJfI1bIwjZCF5X0uZhxcnXXzmoRB9QBHF2xQ0DvIBa04bkaK3dnIqbIzLpz/b34k
 so4GtJLbM4luIhWuA7HpgJZ36cKrJ2aNwqoPKu0dJ7ieEGdiOOHOVaqdlqBpGBSg33H6Gk
 c1Wffo7jzgyilyGe2D/iE/7FQcs0a94SG8AAQZTHcUFbky5OkVn+vVCYPtwAi06LLJPAFM
 lPSHnDjdUZUUf1aaAeToRSsW972o6Jg5MlezXDCrkeUxtgh3HAv3W0Ts0sfz5MdwgESq8+
 RhsCbYvKeNUWFUORFg4VtwcsN1giupy9I8JeSDKEilyDd1HZFMjBBYBwk10wy5WhUv05Rx
 ZH+Q7pXiy7QH2mtnbTNKBUEC1DjcsnQdOIVtWjZoL7BLSPazrXtMkwibmyoXCyRMKnzcea
 1EYA8cLFB3QodFrbRqr613S7s5lNyE7qSUKxlTlAoMJh5fWQyOk8PmvVolQnbgm2ALicF8
 ++UEdzSOPNxbhfAnJvmAbuRw7O57QMtb7tKT+4zXPfJUq37OZdqcY1+l+wlQaPrkruwmpd
 j17LgUNaDKpfZCVRYN8ZS1hHjI/4BsJhfg2M5WYzbWlpFhk3+vGMP79UiqwvZb3XckPE84
 2lCVCHDeBNXNWkNfDiq2rR9miaSPw6fSJy3+P6l4vpMEeRIPWJM/6qrkkTGw
X-ME-Proxy: <xmx:oLRYanT6KNb-7eVqLIfj6uCEiKXxPVxeF6ks8zjyNYVePzVxT2vZnQ>
 <xmx:oLRYamW3qmbK7ljI10V_1BUFUylCD28XanIxiaGzkXxrimed_FrvyA>
 <xmx:oLRYajRCQE3kqYGjORsPBMkAfv4D06ZcsH2_BkvLlr4WZJd_YpBCVA>
 <xmx:oLRYaom8ewc1EsG9k1MKzNnGfvXy1KTIyI-9KYQVPGb9upAIB-XmEQ>
 <xmx:oLRYapWrwQLh6rPbEmGCrqzS-EWIBtMGVUpfpaJ3pcb4ROl-OiEQJhRe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:38:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Nicolas Chautru <nicolas.chautru@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v3 7/8] doc: avoid numbered guide references
Date: Thu, 16 Jul 2026 12:31:25 +0200
Message-ID: <20260716103632.711164-8-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716103632.711164-1-thomas@monjalon.net>
References: <20250527140435.21361-1-nandinipersad361@gmail.com>
 <20260716103632.711164-1-thomas@monjalon.net>
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

Chapter and section numbers may change as guides are reorganized.
Replace visible numbers with links to named sections or pages.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/bbdevs/acc100.rst                  |  4 +--
 doc/guides/bbdevs/fpga_5gnr_fec.rst           |  4 +--
 doc/guides/bbdevs/fpga_lte_fec.rst            |  4 +--
 doc/guides/bbdevs/la12xx.rst                  |  4 +--
 doc/guides/bbdevs/vrb1.rst                    |  4 +--
 doc/guides/bbdevs/vrb2.rst                    |  4 +--
 doc/guides/nics/mlx4.rst                      |  2 +-
 .../prog_guide/ethdev/qos_framework.rst       | 25 +++++++++++--------
 doc/guides/prog_guide/thread_safety.rst       |  2 +-
 9 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/doc/guides/bbdevs/acc100.rst b/doc/guides/bbdevs/acc100.rst
index 985fbb4d24..6582110f3a 100644
--- a/doc/guides/bbdevs/acc100.rst
+++ b/doc/guides/bbdevs/acc100.rst
@@ -78,9 +78,9 @@ ACC100 5G/4G FEC PMDs support the following BBDEV capabilities:
 Installation
 ------------
 
-Section 3 of the DPDK manual provides instructions on installing and compiling DPDK.
+See :doc:`/linux_gsg/build_dpdk` for build instructions.
 
-DPDK requires hugepages to be configured as detailed in section 2 of the DPDK manual.
+DPDK requires hugepages to be configured as described in :ref:`linux_gsg_hugepages`.
 The bbdev test application has been tested with a configuration 40 x 1GB hugepages. The
 hugepage configuration of a server may be examined using:
 
diff --git a/doc/guides/bbdevs/fpga_5gnr_fec.rst b/doc/guides/bbdevs/fpga_5gnr_fec.rst
index b181527c45..07ad51eada 100644
--- a/doc/guides/bbdevs/fpga_5gnr_fec.rst
+++ b/doc/guides/bbdevs/fpga_5gnr_fec.rst
@@ -53,9 +53,9 @@ FPGA 5GNR FEC does not support the following:
 Installation
 ------------
 
-Section 3 of the DPDK manual provides instructions on installing and compiling DPDK.
+See :doc:`/linux_gsg/build_dpdk` for build instructions.
 
-DPDK requires hugepages to be configured as detailed in section 2 of the DPDK manual.
+DPDK requires hugepages to be configured as described in :ref:`linux_gsg_hugepages`.
 The bbdev test application has been tested with a configuration 40 x 1GB hugepages. The
 hugepage configuration of a server may be examined using:
 
diff --git a/doc/guides/bbdevs/fpga_lte_fec.rst b/doc/guides/bbdevs/fpga_lte_fec.rst
index 74151cbef9..2ffc07891b 100644
--- a/doc/guides/bbdevs/fpga_lte_fec.rst
+++ b/doc/guides/bbdevs/fpga_lte_fec.rst
@@ -51,9 +51,9 @@ FPGA LTE FEC does not support the following:
 Installation
 ------------
 
-Section 3 of the DPDK manual provides instructions on installing and compiling DPDK.
+See :doc:`/linux_gsg/build_dpdk` for build instructions.
 
-DPDK requires hugepages to be configured as detailed in section 2 of the DPDK manual.
+DPDK requires hugepages to be configured as described in :ref:`linux_gsg_hugepages`.
 The bbdev test application has been tested with a configuration 40 x 1GB hugepages. The
 hugepage configuration of a server may be examined using:
 
diff --git a/doc/guides/bbdevs/la12xx.rst b/doc/guides/bbdevs/la12xx.rst
index b2224cc90b..3191fc5116 100644
--- a/doc/guides/bbdevs/la12xx.rst
+++ b/doc/guides/bbdevs/la12xx.rst
@@ -23,9 +23,9 @@ LA12xx PMD supports the following features:
 Installation
 ------------
 
-Section 3 of the DPDK manual provides instructions on installing and compiling DPDK.
+See :doc:`/linux_gsg/build_dpdk` for build instructions.
 
-DPDK requires hugepages to be configured as detailed in section 2 of the DPDK manual.
+DPDK requires hugepages to be configured as described in :ref:`linux_gsg_hugepages`.
 
 Initialization
 --------------
diff --git a/doc/guides/bbdevs/vrb1.rst b/doc/guides/bbdevs/vrb1.rst
index e16d6b9dbe..f60ead1ec9 100644
--- a/doc/guides/bbdevs/vrb1.rst
+++ b/doc/guides/bbdevs/vrb1.rst
@@ -83,9 +83,9 @@ The Intel vRAN Boost v1.0 PMD supports the following bbdev capabilities:
 Installation
 ------------
 
-Section 3 of the DPDK manual provides instructions on installing and compiling DPDK.
+See :doc:`/linux_gsg/build_dpdk` for build instructions.
 
-DPDK requires hugepages to be configured as detailed in section 2 of the DPDK manual.
+DPDK requires hugepages to be configured as described in :ref:`linux_gsg_hugepages`.
 The bbdev test application has been tested with a configuration 40 x 1GB hugepages.
 The hugepage configuration of a server may be examined using:
 
diff --git a/doc/guides/bbdevs/vrb2.rst b/doc/guides/bbdevs/vrb2.rst
index 3a9ae1bf82..c7488b4dd1 100644
--- a/doc/guides/bbdevs/vrb2.rst
+++ b/doc/guides/bbdevs/vrb2.rst
@@ -100,9 +100,9 @@ The Intel vRAN Boost v2.0 PMD supports the following bbdev capabilities:
 Installation
 ------------
 
-Section 3 of the DPDK manual provides instructions on installing and compiling DPDK.
+See :doc:`/linux_gsg/build_dpdk` for build instructions.
 
-DPDK requires hugepages to be configured as detailed in section 2 of the DPDK manual.
+DPDK requires hugepages to be configured as described in :ref:`linux_gsg_hugepages`.
 The bbdev test application has been tested with a configuration 40 x 1GB hugepages.
 The hugepage configuration of a server may be examined using:
 
diff --git a/doc/guides/nics/mlx4.rst b/doc/guides/nics/mlx4.rst
index 63b1c548d2..1d3e42bcbb 100644
--- a/doc/guides/nics/mlx4.rst
+++ b/doc/guides/nics/mlx4.rst
@@ -267,7 +267,7 @@ Installing NVIDIA MLNX_OFED
 
         connectx_port_config
 
-#. Continue with :ref:`section 2 of the Quick Start Guide <mlx4_QSG_2>`.
+#. Continue with the :ref:`Quick Start Guide <mlx4_QSG_2>`.
 
 
 Quick Start Guide
diff --git a/doc/guides/prog_guide/ethdev/qos_framework.rst b/doc/guides/prog_guide/ethdev/qos_framework.rst
index f7089190fd..fcefa9d481 100644
--- a/doc/guides/prog_guide/ethdev/qos_framework.rst
+++ b/doc/guides/prog_guide/ethdev/qos_framework.rst
@@ -456,6 +456,8 @@ Usually, once the occupancy of the NIC TX input queue drops below a predefined t
 the port scheduler is woken up (interrupt based or polling based,
 by continuously monitoring the queue occupancy) to push more packets into the queue.
 
+.. _qos_internal_time_reference:
+
 Internal Time Reference
 """""""""""""""""""""""
 
@@ -625,8 +627,8 @@ while the implementation of the token bucket operations is described in :numref:
    |   |                        |       | or CPU cycles for ease of credit consumption operation               |
    |   |                        |       | (as the current time is also maintained in bytes).                   |
    |   |                        |       |                                                                      |
-   |   |                        |       | See  Section 26.2.4.5.1 "Internal Time Reference" for an             |
-   |   |                        |       | explanation of why the time is maintained in byte units.             |
+   |   |                        |       | See :ref:`qos_internal_time_reference` for an                        |
+   |   |                        |       | explanation of why time is maintained in byte units.                 |
    |   |                        |       |                                                                      |
    +---+------------------------+-------+----------------------------------------------------------------------+
    | 2 | tb_period              | Bytes | Time period that should elapse since the last credit update in order |
@@ -1205,9 +1207,9 @@ The use cases supported by the dropper are:
 
 *   *    Mark empty (record the time at which a packet queue becomes empty)
 
-The configuration use case is explained in :ref:`Section 2.23.3.1 <Configuration>`,
-the enqueue operation is explained in  :ref:`Section 2.23.3.2 <Enqueue_Operation>`
-and the mark empty operation is explained in :ref:`Section 2.23.3.3 <Queue_Empty_Operation>`.
+The configuration use case is explained in :ref:`Configuration`,
+the enqueue operation is explained in :ref:`Enqueue_Operation`
+and the mark empty operation is explained in :ref:`Queue_Empty_Operation`.
 
 .. _Configuration:
 
@@ -1321,8 +1323,8 @@ Where:
 
 .. note::
 
-    The filter weight, wq = 1/2^n, where n is the filter weight parameter value passed to the dropper module
-	on configuration (see :ref:`Section2.23.3.1 <Configuration>` ).
+   The filter weight, wq = 1/2^n, where n is the filter weight parameter value
+   passed to the dropper module on configuration (see :ref:`Configuration`).
 
 Average Queue Size Calculation when the Queue is Empty
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -1368,6 +1370,8 @@ Since the time reference is in bytes, the port speed is implied in the expressio
 The dropper does not have to be configured with the actual port speed.
 It adjusts automatically to low speed and high speed links.
 
+.. _qos_dropper_implementation:
+
 Implementation
 """"""""""""""
 
@@ -1406,7 +1410,8 @@ These approaches include:
 
 *   Large look-up table (76 KB)
 
-The method that was finally selected (described above in Section 26.3.2.2.1) outperforms all of these approaches
+The method described in the :ref:`implementation section <qos_dropper_implementation>`
+outperforms all of these approaches
 in terms of run-time performance and memory requirements and
 also achieves accuracy comparable to floating-point evaluation.
 :numref:`table_qos_17` lists the performance of each of these alternative approaches relative to the method that is used in the dropper.
@@ -1420,7 +1425,7 @@ As can be seen, the floating-point implementation achieved the worst performance
    | Method                                                                             | Relative Performance |
    |                                                                                    |                      |
    +====================================================================================+======================+
-   | Current dropper method (see :ref:`Section 23.3.2.1.3 <Droppers>`)                  | 100%                 |
+   | Current dropper method (see :ref:`Droppers`)                                       | 100%                 |
    |                                                                                    |                      |
    +------------------------------------------------------------------------------------+----------------------+
    | Fixed-point method with small (512B) look-up table                                 | 148%                 |
@@ -1560,7 +1565,7 @@ Integration with the DPDK QoS Scheduler Sample Application
 
 The DPDK QoS Scheduler Application reads a configuration file on start-up.
 The configuration file includes a section containing RED parameters.
-The format of these parameters is described in :ref:`Section2.23.3.1 <Configuration>`.
+The format of these parameters is described in :ref:`Configuration`.
 A sample RED configuration is shown below. In this example, the queue size is 64 packets.
 
 .. note::
diff --git a/doc/guides/prog_guide/thread_safety.rst b/doc/guides/prog_guide/thread_safety.rst
index f7cda8bb32..f1e0ea4578 100644
--- a/doc/guides/prog_guide/thread_safety.rst
+++ b/doc/guides/prog_guide/thread_safety.rst
@@ -44,7 +44,7 @@ The mempool library is based on the DPDK lockless ring library and therefore is
 Performance Insensitive API
 ---------------------------
 
-Outside of the performance sensitive areas described in Section 25.1,
+Outside of the performance sensitive areas described above,
 the DPDK provides a thread-safe API for most other libraries.
 For example, malloc and memzone functions are safe for use in multi-threaded and multi-process environments.
 
-- 
2.54.0

