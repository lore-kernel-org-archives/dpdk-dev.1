Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E04C44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 10:37:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 123EE40270;
	Thu, 16 Jul 2026 12:37:37 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id C7124400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 12:37:35 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 7AF6DEC0193;
 Thu, 16 Jul 2026 06:37:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 06:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784198255;
 x=1784284655; bh=wQ6N0DuJKso2bbJI8Y5MkJnHdBoEbI1GwlI00/Qrmkw=; b=
 X24utPTMj/mLUQsFvaaToLgcGCy1UzVnGGPlkpVjdP5imle5AVgI0YT02uY3J82j
 vs7hitWpGXpxHe0eFBaSMGAjIaF7RrQoZ1TMyohXrEoo2Y25YmyQpgNpCGHnU5a7
 kx2l4sHPnnBr/ayKZR/cYhNXU5WhKT7Ajw4FqdM3mJpV66/2OOdfYG1G0BVDtQ8q
 DdatfxoMGRXtxqGnaknw49II0CdsvsBwpMzpNiSTF67fIcqTS4WScjjbG8kfcXLZ
 bRf6aIPQNs55GWNJxO5cXP72DAM1LlsWXXzs6aj+CPrIT9OdYCwdmA4ts/eDrER+
 fMAptqp3WrfHcHzlJuXRAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784198255; x=
 1784284655; bh=wQ6N0DuJKso2bbJI8Y5MkJnHdBoEbI1GwlI00/Qrmkw=; b=E
 n1P9On9L2lXj3mjvw5VYjicKRDCsYgfQvUulgtq6C/+EOVyER5YEbZurNsQ/tzRP
 B0o4bVphINYuhF8ScBcND28umQJYoBO66iqzwy1ON4BetjzpkIfqFQVGyKei0ID/
 xM/qF+utyX07784JKlWFzcoxor49l8/9RmuxqAn43Z7k3IpQnOU4GYtnln393R2J
 tKAF0+6efEioJ/HK7A6/0cnAht6OwRl4w5lPBURu8UPZDjjZrHM3u9YVtbJd7q/f
 g7q/FO+ANr6Ahwb3k6zHzgjb7g/pPAJF5u7/vU/9EfbPs80P1s957jeuknYYnb9N
 RVNRXvpe/7OYk0fwZ4JPQ==
X-ME-Sender: <xms:b7RYarwfa6flRk01UWIvTAS8DIYOBU1_GSm59CjKWzbCz69_Ysh3wQ>
 <xme:b7RYai1VKrVp23amlqgvk7VQ9wLY-300HsQs7uOc24R5T44gUiddl3JQGeHRCDPyt
 Alo7C1GQEq-2Vkhey6hur1xq_WVpS1IQBTeSMcKswa8V0KaIfszWgk>
X-ME-Received: <xmr:b7RYaus1VDMYGFhobOBdUtRGExsHzYsghggcjeacuSOonaVC7NRCh8_o87J-wAwa65Cx6EqII7E4XdkKB6nha4c>
X-ME-Proxy-Cause: dmFkZTGNBC+CFsdjtcQY7QQWHAoEKmgJ2iqaSTgtltvlqClz+QCtGqMH404t+M1NHFs8i6
 uURsezKhjl6IPtC/oI47t45IjI8mmliXmCARxcReBxwE2lgvgEdbZWtJGYVGCms7UbVxxJ
 6oCZGx6z/pQFfGIp/v9yGnbSsJr2DnJmArhiysk0z+d6h4GOn0x9yxdPIf9t7ByIN0HS5Q
 hZR00+b1SwVBbw+IuBUEhzAVl25/6Ng0hh6t/QTtFXXRWn40loPK/19ynIfDgKWM+JJUTF
 vkfxGitYdkblPDWqiTXGGD+8dIUnCkwZAsEmME/AoZPoGWP2h99HGLPgpLWCuooqgXmDTO
 vsLvnvHNNArYFnnddc3f7ojkUrxJg1Cbzi7KLNYA60gSDA+o+Qqxla5fhxQnB1yH4YNZgI
 7MwSi83YeSKVitlSTJFhj0ArVBpPDZmNIZt32rSBTbZCSTEK/RzK9DSndHOtGOE6IfVVAE
 do2vUycK+NWvxuvrP6G17+r4AOa3TJA/G24p8ZNYv5HLjucU7RZsJ90cfZfX2RZh0s6pb4
 8EWnPUDU57JlI6XKgrhVLIUIA5RRR5Yi0QqMaDzCMQUdkXkzIqmS4X3Nix1HYT8tHmMQCb
 lWJE/KblLZ59d6fy4M89oZNcBGQ7CNYm865Ob1D++ui2yjYvduUdLRMPueiQ
X-ME-Proxy: <xmx:b7RYauV-VS5RWk9Jrz0jXO72Inc82qf9DqwtGiK1xPMOTxqB5zBomA>
 <xmx:b7RYaquljInas2v7ssx_6q-0FecRqrx5uPKs6oBl1DjVQgdI_Daxxg>
 <xmx:b7RYagOKNOz5yuukL9SVIS-6RW8hVOdQXUOOsKRDN1QDWIIHGIbVUw>
 <xmx:b7RYapm0Fi9rbWYKhYtoR4p9NAjcP9x-E-3RISxm9NmbJFl4bJ9wsA>
 <xmx:b7RYasIbLw4Ifz2arPvB1pmHb6RoTY3eFc-BIMCX79kHRU7Z-qVxs8Vj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:37:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>,	Ron Beider <rbeider@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Andrew Boyer <andrew.boyer@amd.com>,	Rosen Xu <rosen.xu@altera.com>,
 Liron Himi <lironh@marvell.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 John McNamara <john.mcnamara@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v3 3/8] doc: replace vague references with precise links
Date: Thu, 16 Jul 2026 12:31:21 +0200
Message-ID: <20260716103632.711164-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716103632.711164-1-thomas@monjalon.net>
References: <20250527140435.21361-1-nandinipersad361@gmail.com>
 <20260716103632.711164-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Some guide references describe another section or document
without linking to it, or link only to a broader page.

Use precise links to the referenced sections or documents.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/contributing/documentation.rst            |  2 ++
 doc/guides/contributing/patches.rst                  |  2 +-
 doc/guides/faq/faq.rst                               |  2 +-
 doc/guides/howto/openwrt.rst                         |  2 +-
 doc/guides/linux_gsg/build_sample_apps.rst           |  8 ++++----
 doc/guides/linux_gsg/sys_reqs.rst                    |  2 ++
 doc/guides/nics/ark.rst                              |  9 ++++-----
 doc/guides/nics/axgbe.rst                            |  3 +--
 doc/guides/nics/dpaa2.rst                            |  2 +-
 doc/guides/nics/ena.rst                              |  7 +++----
 doc/guides/nics/features.rst                         |  6 ++++--
 doc/guides/nics/i40e.rst                             |  4 ++--
 doc/guides/nics/ice.rst                              |  4 ++--
 doc/guides/nics/ionic.rst                            |  5 ++---
 doc/guides/nics/ipn3ke.rst                           |  4 ++--
 doc/guides/nics/mvpp2.rst                            |  5 ++---
 doc/guides/nics/softnic.rst                          | 11 +++++------
 doc/guides/nics/txgbe.rst                            |  4 ++--
 doc/guides/nics/vhost.rst                            |  2 +-
 doc/guides/nics/virtio.rst                           |  2 +-
 doc/guides/nics/vmxnet3.rst                          |  6 ++++--
 doc/guides/prog_guide/ethdev/ethdev.rst              |  4 ++--
 doc/guides/prog_guide/multi_proc_support.rst         |  7 +++----
 doc/guides/prog_guide/power_man.rst                  | 10 +++-------
 doc/guides/sample_app_ug/dma.rst                     |  4 ++--
 doc/guides/sample_app_ug/eventdev_pipeline.rst       |  9 +++++----
 doc/guides/sample_app_ug/l2_forward_event.rst        |  5 +++--
 doc/guides/sample_app_ug/l2_forward_job_stats.rst    |  4 ++--
 doc/guides/sample_app_ug/l2_forward_real_virtual.rst |  4 ++--
 doc/guides/sample_app_ug/link_status_intr.rst        |  4 ++--
 doc/guides/sample_app_ug/ptpclient.rst               |  4 ++--
 doc/guides/sample_app_ug/qos_scheduler.rst           |  3 ++-
 doc/guides/sample_app_ug/skeleton.rst                |  4 ++--
 doc/guides/sample_app_ug/vhost.rst                   |  2 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst          |  4 ++++
 35 files changed, 82 insertions(+), 78 deletions(-)

diff --git a/doc/guides/contributing/documentation.rst b/doc/guides/contributing/documentation.rst
index b8ef8131b5..10c35db0c1 100644
--- a/doc/guides/contributing/documentation.rst
+++ b/doc/guides/contributing/documentation.rst
@@ -58,6 +58,8 @@ Role of the Documentation
 The following items outline the roles of the different parts of the documentation and when they need to be updated or
 added to by the developer.
 
+.. _contrib_doc_guidelines_release_notes:
+
 * **Release Notes**
 
   The Release Notes document which features have been added in the current and previous releases of DPDK and highlight
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index 682f4fda28..027e6c0858 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -169,7 +169,7 @@ Make your planned changes in the cloned ``dpdk`` repo. Here are some guidelines
 * When introducing a new device API, at least one driver should implement it.
 
 * Important changes will require an addition to the release notes in ``doc/guides/rel_notes/``.
-  See the :ref:`Release Notes section of the Documentation Guidelines <doc_guidelines>` for details.
+  See the :ref:`release notes guidelines <contrib_doc_guidelines_release_notes>`.
 
 * Test the compilation works with different targets, compilers and options, see :ref:`contrib_check_compilation`.
 
diff --git a/doc/guides/faq/faq.rst b/doc/guides/faq/faq.rst
index d42c4314e2..c947002a85 100644
--- a/doc/guides/faq/faq.rst
+++ b/doc/guides/faq/faq.rst
@@ -6,7 +6,7 @@ What does "EAL: map_all_hugepages(): open failed: Permission denied Cannot init
 
 This is most likely due to the test application not being run with sudo to promote the user to a superuser.
 Alternatively, applications can also be run as regular user.
-For more information, please refer to :ref:`DPDK Getting Started Guide <linux_gsg>`.
+For more information, please refer to :ref:`Running_Without_Root_Privileges`.
 
 
 If I want to change the number of hugepages allocated, how do I remove the original pages allocated?
diff --git a/doc/guides/howto/openwrt.rst b/doc/guides/howto/openwrt.rst
index be902c505f..0b125308d6 100644
--- a/doc/guides/howto/openwrt.rst
+++ b/doc/guides/howto/openwrt.rst
@@ -150,7 +150,7 @@ Running DPDK
 ~~~~~~~~~~~~
 
 More detailed info about how to run a DPDK application please refer to
-``Running DPDK Applications`` section of :ref:`the DPDK documentation <linux_gsg>`.
+:ref:`linux_gsg_running_apps`.
 
 .. note::
 
diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index 5195af67ad..4d233c7d05 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -39,9 +39,9 @@ Copy the DPDK application binary to your target, then run the application as fol
 .. note::
 
     The ``--proc-type`` and ``--file-prefix`` EAL options are used for running
-    multiple DPDK processes. See the "Multi-process Sample Application"
-    chapter in the *DPDK Sample Applications User Guide* and the *DPDK
-    Programmers Guide* for more details.
+    multiple DPDK processes.
+    See :doc:`/sample_app_ug/multi_process`
+    and :doc:`/prog_guide/multi_proc_support` for more details.
 
 Logical Core Use by Applications
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -123,5 +123,5 @@ Additional Sample Applications
 
 Additional sample applications are included in the DPDK examples directory.
 These sample applications may be built and run in a manner similar to that described in earlier sections in this manual.
-In addition, see the *DPDK Sample Applications User Guide* for a description of the application,
+In addition, see :doc:`/sample_app_ug/index` for descriptions of the applications,
 specific instructions on compilation and execution and some explanation of the code.
diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 869584c344..a3eef5b93d 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -90,6 +90,8 @@ For poll-mode drivers, the additional dependencies for each driver can be
 found in that driver's documentation in the relevant DPDK guide document,
 e.g. :doc:`../nics/index`
 
+.. _linux_gsg_running_apps:
+
 Running DPDK Applications
 -------------------------
 
diff --git a/doc/guides/nics/ark.rst b/doc/guides/nics/ark.rst
index c8ed57289b..078435cfe7 100644
--- a/doc/guides/nics/ark.rst
+++ b/doc/guides/nics/ark.rst
@@ -272,8 +272,7 @@ extension file generated above.  For example:
 Building DPDK
 -------------
 
-See the :ref:`DPDK Getting Started Guide for Linux <linux_gsg>` for
-instructions on how to build DPDK.
+See :doc:`/linux_gsg/build_dpdk` for instructions.
 
 By default the ARK PMD library will be built into the DPDK library.
 
@@ -354,9 +353,9 @@ are required, please contact Atomic Rules support.
 Supported Operating Systems
 ---------------------------
 
-Any Linux distribution fulfilling the conditions described in ``System Requirements``
-section of :ref:`the DPDK documentation <linux_gsg>` or refer to *DPDK
-Release Notes*.  ARM and PowerPC architectures are not supported at this time.
+Any Linux distribution fulfilling the conditions described in
+:doc:`/linux_gsg/sys_reqs` or refer to :doc:`/rel_notes/index`.
+ARM and PowerPC architectures are not supported at this time.
 
 
 Supported Features
diff --git a/doc/guides/nics/axgbe.rst b/doc/guides/nics/axgbe.rst
index 961b5c967d..176d0c9133 100644
--- a/doc/guides/nics/axgbe.rst
+++ b/doc/guides/nics/axgbe.rst
@@ -30,8 +30,7 @@ AXGBE PMD has support for:
 Building DPDK
 -------------
 
-See the :ref:`DPDK Getting Started Guide for Linux <linux_gsg>` for
-instructions on how to build DPDK.
+See :doc:`/linux_gsg/build_dpdk` for instructions.
 
 By default the AXGBE PMD library will be built into the DPDK library.
 
diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index d8fe99ae40..4fdb7383c3 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -638,7 +638,7 @@ The following capabilities are supported:
 Usage example
 ~~~~~~~~~~~~~
 
-For a detailed usage description please refer to "Traffic Management" section in DPDK :doc:`../testpmd_app_ug/testpmd_funcs`.
+For a detailed usage description please refer to :ref:`testpmd_traffic_management`.
 
 #. Run testpmd as follows:
 
diff --git a/doc/guides/nics/ena.rst b/doc/guides/nics/ena.rst
index ee5bfaeab8..52156a9fdf 100644
--- a/doc/guides/nics/ena.rst
+++ b/doc/guides/nics/ena.rst
@@ -175,8 +175,7 @@ ENA Configuration Parameters
 Building DPDK
 -------------
 
-See the :ref:`DPDK Getting Started Guide for Linux <linux_gsg>` for
-instructions on how to build DPDK.
+See :doc:`/linux_gsg/build_dpdk` for instructions.
 
 By default the ENA PMD library will be built into the DPDK library.
 
@@ -186,8 +185,8 @@ documentation that comes with DPDK suite <linux_gsg>`.
 Supported Operating Systems
 ---------------------------
 
-Any Linux distribution fulfilling the conditions described in ``System Requirements``
-section of :ref:`the DPDK documentation <linux_gsg>` or refer to *DPDK Release Notes*.
+Any Linux distribution fulfilling the conditions described in
+:doc:`/linux_gsg/sys_reqs` or refer to :doc:`/rel_notes/index`.
 
 Prerequisites
 -------------
diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index 26357036ca..43db96c3e1 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -443,7 +443,8 @@ Inline crypto
 
 Supports inline crypto processing defined by rte_security library to perform crypto
 operations of security protocol while packet is received in NIC. NIC is not aware
-of protocol operations. See Security library and PMD documentation for more details.
+of protocol operations.
+See :doc:`/prog_guide/rte_security` and PMD documentation for more details.
 
 * **[uses]       rte_eth_rxconf,rte_eth_rxmode**: ``offloads:RTE_ETH_RX_OFFLOAD_SECURITY``,
 * **[uses]       rte_eth_txconf,rte_eth_txmode**: ``offloads:RTE_ETH_TX_OFFLOAD_SECURITY``.
@@ -465,7 +466,8 @@ Inline protocol
 Supports inline protocol processing defined by rte_security library to perform
 protocol processing for the security protocol (e.g. IPsec, MACSEC) while the
 packet is received at NIC. The NIC is capable of understanding the security
-protocol operations. See security library and PMD documentation for more details.
+protocol operations.
+See :doc:`/prog_guide/rte_security` and PMD documentation for more details.
 
 * **[uses]       rte_eth_rxconf,rte_eth_rxmode**: ``offloads:RTE_ETH_RX_OFFLOAD_SECURITY``,
 * **[uses]       rte_eth_txconf,rte_eth_txmode**: ``offloads:RTE_ETH_TX_OFFLOAD_SECURITY``.
diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index fdfe257ba4..a2858ef8bc 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -54,8 +54,8 @@ Linux Prerequisites
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
 
-- To get better performance on Intel platforms, please follow the "How to get best performance with NICs on Intel platforms"
-  section of the :ref:`Getting Started Guide for Linux <linux_gsg>`.
+- To get better performance on Intel platforms,
+  please follow :doc:`/linux_gsg/nic_perf_intel_platform`.
 
 - Upgrade the NVM/FW version following the `Intel® Ethernet NVM Update Tool Quick Usage Guide for Linux
   <https://www-ssl.intel.com/content/www/us/en/embedded/products/networking/nvm-update-tool-quick-linux-usage-guide.html>`_ and `Intel® Ethernet NVM Update Tool: Quick Usage Guide for EFI <https://www.intel.com/content/www/us/en/embedded/products/networking/nvm-update-tool-quick-efi-usage-guide.html>`_ if needed.
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 7e23a3cad3..3f3d36586d 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -19,8 +19,8 @@ Linux Prerequisites
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
 
-- To get better performance on Intel platforms, please follow the "How to get best performance with NICs on Intel platforms"
-  section of the :ref:`Getting Started Guide for Linux <linux_gsg>`.
+- To get better performance on Intel platforms,
+  please follow :doc:`/linux_gsg/nic_perf_intel_platform`.
 
 - Please follow the matching list to download specific kernel driver, firmware and DDP package from
   `https://www.intel.com/content/www/us/en/search.html?ws=text#q=e810&t=Downloads&layout=table`.
diff --git a/doc/guides/nics/ionic.rst b/doc/guides/nics/ionic.rst
index 2709a888fb..90c5aabec8 100644
--- a/doc/guides/nics/ionic.rst
+++ b/doc/guides/nics/ionic.rst
@@ -57,6 +57,5 @@ Runtime Configuration
 Building DPDK
 -------------
 
-The ionic PMD supports UIO and VFIO. Please refer to the
-:ref:`DPDK documentation that comes with the DPDK suite <linux_gsg>`
-for instructions on how to build DPDK.
+The ionic PMD supports UIO and VFIO.
+Please refer to :doc:`/linux_gsg/build_dpdk` for instructions.
diff --git a/doc/guides/nics/ipn3ke.rst b/doc/guides/nics/ipn3ke.rst
index 410da3b4a9..c86037a3c2 100644
--- a/doc/guides/nics/ipn3ke.rst
+++ b/doc/guides/nics/ipn3ke.rst
@@ -24,8 +24,8 @@ Prerequisites
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
 
-- To get better performance on Intel platforms, please follow the "How to get best performance with NICs on Intel platforms"
-  section of the :ref:`Getting Started Guide for Linux <linux_gsg>`.
+- To get better performance on Intel platforms,
+  please follow :doc:`/linux_gsg/nic_perf_intel_platform`.
 
 
 Configuration
diff --git a/doc/guides/nics/mvpp2.rst b/doc/guides/nics/mvpp2.rst
index 3ecb253ae6..48cbe97f23 100644
--- a/doc/guides/nics/mvpp2.rst
+++ b/doc/guides/nics/mvpp2.rst
@@ -616,8 +616,7 @@ Usage example
 
 		testpmd> flow create 0 ingress pattern ipv4 src is 10.10.10.1 / end actions meter mtr_id 0 / end
 
-For a detailed usage description please refer to "Traffic Metering and Policing" section in DPDK :doc:`Testpmd Runtime Functions <../testpmd_app_ug/testpmd_funcs>`.
-
+For a detailed usage description please refer to :ref:`testpmd_traffic_metering_and_policing`.
 
 
 .. _tmapi:
@@ -672,7 +671,7 @@ The following capabilities are not supported:
 Usage example
 ~~~~~~~~~~~~~
 
-For a detailed usage description please refer to "Traffic Management" section in DPDK :doc:`../testpmd_app_ug/testpmd_funcs`.
+For a detailed usage description please refer to :ref:`testpmd_traffic_management`.
 
 #. Run testpmd as follows:
 
diff --git a/doc/guides/nics/softnic.rst b/doc/guides/nics/softnic.rst
index 70a313be94..603fdb49c4 100644
--- a/doc/guides/nics/softnic.rst
+++ b/doc/guides/nics/softnic.rst
@@ -9,9 +9,9 @@ is DIY and reconfigurable through ``firmware`` (DPDK Packet Framework script).
 
 The Soft NIC leverages the DPDK Packet Framework libraries (librte_port,
 librte_table and librte_pipeline) to make it modular, flexible and extensible
-with new functionality. Please refer to DPDK Programmer's Guide, Chapter
-``Packet Framework`` and DPDK Sample Application User Guide,
-Chapter ``IP Pipeline Application`` for more details.
+with new functionality.
+Please refer to :doc:`/prog_guide/packet_framework` and
+:doc:`/sample_app_ug/ip_pipeline` for more details.
 
 The Soft NIC is configured through the standard DPDK ethdev API (ethdev, flow,
 QoS, security). The internal framework is not externally visible.
@@ -47,9 +47,8 @@ Flow
 Supported Operating Systems
 ---------------------------
 
-Any Linux distribution fulfilling the conditions described in ``System Requirements``
-section of :ref:`the DPDK documentation <linux_gsg>` or refer to *DPDK
-Release Notes*.
+Any Linux distribution fulfilling the conditions described in
+:doc:`/linux_gsg/sys_reqs` or refer to :doc:`/rel_notes/index`.
 
 
 Runtime Configuration
diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 44b60647a5..35159fee11 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -204,7 +204,7 @@ For example, create a flow rule:
 
 	testpmd> flow create 0 ingress pattern eth type is 0x0806 / end actions queue index 2 / end
 
-For a detailed usage description please refer to "Flow rules management" section in DPDK :doc:`../testpmd_app_ug/testpmd_funcs`.
+For a detailed usage description please refer to :ref:`testpmd_rte_flow`.
 
 Traffic Management API
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -219,7 +219,7 @@ For example, add shaper profile
 
 	testpmd> add port tm node shaper profile 0 0 0 0 25000000 0 0
 
-For a detailed usage description please refer to "Traffic Management" section in DPDK :doc:`../testpmd_app_ug/testpmd_funcs`.
+For a detailed usage description please refer to :ref:`testpmd_traffic_management`.
 
 Limitations or Known issues
 ---------------------------
diff --git a/doc/guides/nics/vhost.rst b/doc/guides/nics/vhost.rst
index d7341c22ee..d977fca9aa 100644
--- a/doc/guides/nics/vhost.rst
+++ b/doc/guides/nics/vhost.rst
@@ -10,7 +10,7 @@ The user can handle virtqueues as one of normal DPDK port.
 Vhost Implementation in DPDK
 ----------------------------
 
-Please refer to Chapter "Vhost Library" of *DPDK Programmer's Guide* to know detail of vhost.
+Please refer to :doc:`/prog_guide/vhost_lib` for details about vhost.
 
 Features and Limitations of vhost PMD
 -------------------------------------
diff --git a/doc/guides/nics/virtio.rst b/doc/guides/nics/virtio.rst
index e8a6dd02fe..38375636f3 100644
--- a/doc/guides/nics/virtio.rst
+++ b/doc/guides/nics/virtio.rst
@@ -12,7 +12,7 @@ for fast guest VM to guest VM communication and guest VM to host communication.
 Vhost is a kernel acceleration module for virtio qemu backend.
 
 For basic qemu-KVM installation and other Intel EM poll mode driver in guest VM,
-please refer to Chapter "Driver for VM Emulated Devices".
+please refer to :doc:`/nics/e1000em`.
 
 In this chapter, we will demonstrate usage of virtio PMD with two backends,
 standard qemu vhost back end.
diff --git a/doc/guides/nics/vmxnet3.rst b/doc/guides/nics/vmxnet3.rst
index 743369995a..6c42f7c036 100644
--- a/doc/guides/nics/vmxnet3.rst
+++ b/doc/guides/nics/vmxnet3.rst
@@ -125,8 +125,10 @@ The following prerequisites apply:
 
 .. note::
 
-    Follow the *DPDK Sample Application's User Guide*, L2 Forwarding/L3 Forwarding and
-    TestPMD for instructions on how to run a DPDK application using an assigned VMXNET3 device.
+   Follow the :doc:`L2 Forwarding </sample_app_ug/l2_forward_real_virtual>`,
+   :doc:`L3 Forwarding </sample_app_ug/l3_forward>` and
+   :doc:`TestPMD </testpmd_app_ug/index>` guides
+   for instructions on how to run a DPDK application using an assigned VMXNET3 device.
 
 VMXNET3 with a Native NIC Connected to a vSwitch
 ------------------------------------------------
diff --git a/doc/guides/prog_guide/ethdev/ethdev.rst b/doc/guides/prog_guide/ethdev/ethdev.rst
index 0f076d6eaf..6521fe14a5 100644
--- a/doc/guides/prog_guide/ethdev/ethdev.rst
+++ b/doc/guides/prog_guide/ethdev/ethdev.rst
@@ -360,8 +360,8 @@ Two scenarios exist where an application may want the mbuf released immediately:
   for each destination interface used
   to request it to release all used mbufs.
 
-To determine if a driver supports this API, check for the *Free Tx mbuf on demand* feature
-in the *Network Interface Controller Drivers* document.
+To determine if a driver supports this API, check for the
+:ref:`nic_features_free_tx_mbuf_on_demand` feature.
 
 
 Hardware Offload
diff --git a/doc/guides/prog_guide/multi_proc_support.rst b/doc/guides/prog_guide/multi_proc_support.rst
index b465c47727..453d815fba 100644
--- a/doc/guides/prog_guide/multi_proc_support.rst
+++ b/doc/guides/prog_guide/multi_proc_support.rst
@@ -43,8 +43,7 @@ two additional command-line parameters are available to the EAL:
 *   ``--file-prefix:`` to allow processes that do not want to co-operate to have different memory regions
 
 A number of example applications are provided that demonstrate how multiple DPDK processes can be used together.
-These are more fully documented in the "Multi- process Sample Application" chapter
-in the *DPDK Sample Application's User Guide*.
+These are more fully documented in :doc:`/sample_app_ug/multi_process`.
 
 Memory Sharing
 --------------
@@ -91,7 +90,7 @@ In this model, the first of the processes spawned should be spawned using the ``
 while all subsequent instances should be spawned using the ``--proc-type=secondary`` flag.
 
 The simple_mp and symmetric_mp sample applications demonstrate this usage model.
-They are described in the "Multi-process Sample Application" chapter in the *DPDK Sample Application's User Guide*.
+They are described in :doc:`/sample_app_ug/multi_process`.
 
 Asymmetric/Non-Peer Processes
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -102,7 +101,7 @@ server distributing received packets among worker or client threads, which are r
 In this case, extensive use of rte_ring objects is made, which are located in shared hugepage memory.
 
 The client_server_mp sample application shows this usage model.
-It is described in the "Multi-process Sample Application" chapter in the *DPDK Sample Application's User Guide*.
+It is described in :doc:`/sample_app_ug/multi_process`.
 
 Running Multiple Independent DPDK Applications
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/prog_guide/power_man.rst b/doc/guides/prog_guide/power_man.rst
index 74039e5786..915d9da3fd 100644
--- a/doc/guides/prog_guide/power_man.rst
+++ b/doc/guides/prog_guide/power_man.rst
@@ -290,10 +290,6 @@ Get Num Dies
 References
 ----------
 
-*   The :doc:`../sample_app_ug/l3_forward_power_man`
-    chapter in the :doc:`../sample_app_ug/index` section.
-
-*   The :doc:`../sample_app_ug/vm_power_management`
-    chapter in the :doc:`../sample_app_ug/index` section.
-
-*   The :doc:`../nics/overview` chapter in the :doc:`../nics/index` section
+* :doc:`../sample_app_ug/l3_forward_power_man`
+* :doc:`../sample_app_ug/vm_power_management`
+* :doc:`../nics/overview`
diff --git a/doc/guides/sample_app_ug/dma.rst b/doc/guides/sample_app_ug/dma.rst
index 7d177fd44d..a455f9c8ad 100644
--- a/doc/guides/sample_app_ug/dma.rst
+++ b/doc/guides/sample_app_ug/dma.rst
@@ -135,8 +135,8 @@ used by the application:
     :end-before: >8 End of allocates mempool to hold the mbufs.
     :dedent: 1
 
-Mbufs are the packet buffer structure used by DPDK. They are explained in
-detail in the "Mbuf Library" section of the *DPDK Programmer's Guide*.
+Mbufs are the packet buffer structure used by DPDK.
+They are explained in detail in the :doc:`/prog_guide/mbuf_lib`.
 
 The ``main()`` function also initializes the ports:
 
diff --git a/doc/guides/sample_app_ug/eventdev_pipeline.rst b/doc/guides/sample_app_ug/eventdev_pipeline.rst
index 19ff53803e..237bfdd471 100644
--- a/doc/guides/sample_app_ug/eventdev_pipeline.rst
+++ b/doc/guides/sample_app_ug/eventdev_pipeline.rst
@@ -61,8 +61,8 @@ will print an error message:
           rx: 0
           tx: 1
 
-Configuration of the eventdev is covered in detail in the programmers guide,
-see the Event Device Library section.
+Configuration of the eventdev is covered in detail in the programmer's guide,
+see :doc:`/prog_guide/eventdev/eventdev`.
 
 
 Observing the Application
@@ -143,5 +143,6 @@ transmitted, and an overview of the distribution of work across worker cores.
 To get a full dump of the state of the eventdev PMD, pass the ``-D`` flag to
 this application. When the app is terminated using ``Ctrl+C``, the
 ``rte_event_dev_dump()`` function is called, resulting in a dump of the
-statistics that the PMD provides. The statistics provided depend on the PMD
-used, see the Event Device Drivers section for a list of eventdev PMDs.
+statistics that the PMD provides.
+The statistics provided depend on the PMD used,
+see :doc:`/eventdevs/index` for a list of eventdev PMDs.
diff --git a/doc/guides/sample_app_ug/l2_forward_event.rst b/doc/guides/sample_app_ug/l2_forward_event.rst
index 01f7ca88ae..a71620469e 100644
--- a/doc/guides/sample_app_ug/l2_forward_event.rst
+++ b/doc/guides/sample_app_ug/l2_forward_event.rst
@@ -178,8 +178,9 @@ Driver Initialization
 
 The main part of the code in the ``main()`` function relates to the initialization
 of the driver. To fully understand this code, it is recommended to study the
-chapters related to the Poll Mode and Event mode Driver in the
-*DPDK Programmer's Guide* - Rel 1.4 EAR and the *DPDK API Reference*.
+chapters related to :doc:`/prog_guide/ethdev/ethdev`
+and :doc:`/prog_guide/eventdev/eventdev`,
+as well as the DPDK API Reference.
 
 .. literalinclude:: ../../../examples/l2fwd-event/main.c
         :language: c
diff --git a/doc/guides/sample_app_ug/l2_forward_job_stats.rst b/doc/guides/sample_app_ug/l2_forward_job_stats.rst
index 23448f23a4..67ea125c41 100644
--- a/doc/guides/sample_app_ug/l2_forward_job_stats.rst
+++ b/doc/guides/sample_app_ug/l2_forward_job_stats.rst
@@ -163,8 +163,8 @@ Driver Initialization
 ~~~~~~~~~~~~~~~~~~~~~
 
 The main part of the code in the ``main()`` function relates to the initialization of the driver.
-To fully understand this code, it is recommended to study the chapters that related to the Poll Mode Driver
-in the *DPDK Programmer's Guide* and the *DPDK API Reference*.
+To fully understand this code, it is recommended to study
+:doc:`/prog_guide/ethdev/ethdev` and the DPDK API Reference.
 
 .. literalinclude:: ../../../examples/l2fwd-jobstats/main.c
     :language: c
diff --git a/doc/guides/sample_app_ug/l2_forward_real_virtual.rst b/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
index bf848ce2db..aff7af7c57 100644
--- a/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
+++ b/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
@@ -189,8 +189,8 @@ Driver Initialization
 ~~~~~~~~~~~~~~~~~~~~~
 
 The main part of the code in the ``main()`` function relates to the initialization of the driver.
-To fully understand this code, it is recommended to study the chapters related to the Poll Mode Driver
-in the *DPDK Programmer's Guide* - Rel 1.4 EAR and the *DPDK API Reference*.
+To fully understand this code, it is recommended to study
+:doc:`/prog_guide/ethdev/ethdev` and the DPDK API Reference.
 
 .. literalinclude:: ../../../examples/l2fwd/main.c
     :language: c
diff --git a/doc/guides/sample_app_ug/link_status_intr.rst b/doc/guides/sample_app_ug/link_status_intr.rst
index fd4e32560c..3038fe030a 100644
--- a/doc/guides/sample_app_ug/link_status_intr.rst
+++ b/doc/guides/sample_app_ug/link_status_intr.rst
@@ -84,8 +84,8 @@ Driver Initialization
 ~~~~~~~~~~~~~~~~~~~~~
 
 The main part of the code in the main() function relates to the initialization of the driver.
-To fully understand this code, it is recommended to study the chapters that related to the Poll Mode Driver in the
-*DPDK Programmer's Guide and the DPDK API Reference*.
+To fully understand this code, it is recommended to study
+:doc:`/prog_guide/ethdev/ethdev` and the DPDK API Reference.
 
 .. literalinclude:: ../../../examples/link_status_interrupt/main.c
         :language: c
diff --git a/doc/guides/sample_app_ug/ptpclient.rst b/doc/guides/sample_app_ug/ptpclient.rst
index 4959234826..8d802ac08b 100644
--- a/doc/guides/sample_app_ug/ptpclient.rst
+++ b/doc/guides/sample_app_ug/ptpclient.rst
@@ -116,8 +116,8 @@ used by the application:
     :end-before:  >8 End of a new mempool in memory to hold the mbufs.
     :dedent: 1
 
-Mbufs are the packet buffer structure used by DPDK. They are explained in
-detail in the "Mbuf Library" section of the *DPDK Programmer's Guide*.
+Mbufs are the packet buffer structure used by DPDK.
+They are explained in detail in the :doc:`/prog_guide/mbuf_lib`.
 
 The ``main()`` function also initializes all the ports using the user defined
 ``port_init()`` function with portmask provided by user:
diff --git a/doc/guides/sample_app_ug/qos_scheduler.rst b/doc/guides/sample_app_ug/qos_scheduler.rst
index 7805d240f9..23d68aba48 100644
--- a/doc/guides/sample_app_ug/qos_scheduler.rst
+++ b/doc/guides/sample_app_ug/qos_scheduler.rst
@@ -233,4 +233,5 @@ This application classifies based on the QinQ double VLAN tags and the IP destin
    |                | Lowest Priority TC: 4   | class (Best effort) serviced in WRR              |                                  |
    +----------------+-------------------------+--------------------------------------------------+----------------------------------+
 
-Please refer to the "QoS Scheduler" chapter in the *DPDK Programmer's Guide* for more information about these parameters.
+Please refer to the :doc:`/prog_guide/ethdev/qos_framework`
+for more information about these parameters.
diff --git a/doc/guides/sample_app_ug/skeleton.rst b/doc/guides/sample_app_ug/skeleton.rst
index 5f7f18dbc2..4c2c8a8bd5 100644
--- a/doc/guides/sample_app_ug/skeleton.rst
+++ b/doc/guides/sample_app_ug/skeleton.rst
@@ -69,8 +69,8 @@ used by the application:
     :end-before: >8 End of allocating mempool to hold mbuf.
     :dedent: 1
 
-Mbufs are the packet buffer structure used by DPDK. They are explained in
-detail in the "Mbuf Library" section of the *DPDK Programmer's Guide*.
+Mbufs are the packet buffer structure used by DPDK.
+They are explained in detail in the :doc:`/prog_guide/mbuf_lib`.
 
 The ``main()`` function also initializes all the ports using the user defined
 ``port_init()`` function which is explained in the next section:
diff --git a/doc/guides/sample_app_ug/vhost.rst b/doc/guides/sample_app_ug/vhost.rst
index 72dad16434..2726dba604 100644
--- a/doc/guides/sample_app_ug/vhost.rst
+++ b/doc/guides/sample_app_ug/vhost.rst
@@ -87,7 +87,7 @@ Then start testpmd for packet forwarding testing.
     > start tx_first
 
 For more information about vIOMMU and NO-IOMMU and VFIO please refer to
-:doc:`/../linux_gsg/linux_drivers` section of the DPDK Getting started guide.
+the :doc:`Linux Drivers </../linux_gsg/linux_drivers>` section of the documentation.
 
 Inject packets
 --------------
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index cbaa616a52..0bc267950a 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2439,6 +2439,8 @@ manage link bonding devices from within testpmd interactive prompt.
 
 See :doc:`../prog_guide/link_bonding_poll_mode_drv_lib` for more information.
 
+.. _testpmd_traffic_metering_and_policing:
+
 Traffic Metering and Policing
 -----------------------------
 
@@ -2651,6 +2653,8 @@ where:
 * ``clear``: Flag that indicates whether the statistics counters should
   be cleared (i.e. set to zero) immediately after they have been read or not.
 
+.. _testpmd_traffic_management:
+
 Traffic Management
 ------------------
 
-- 
2.54.0

