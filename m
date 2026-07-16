Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA91C4450A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 10:38:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 533BE40270;
	Thu, 16 Jul 2026 12:37:59 +0200 (CEST)
Received: from flow-a7-smtp.messagingengine.com
 (flow-a7-smtp.messagingengine.com [103.168.172.142])
 by mails.dpdk.org (Postfix) with ESMTP id 347B8400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 12:37:58 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id C3F1E13804A0;
 Thu, 16 Jul 2026 06:37:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784198277;
 x=1784205477; bh=Px18XWjpbztYrdYXu4WShzEC0WlJUQofvf45Q5YbOs0=; b=
 cdyt07FLKFI5HNyo2dYhZbdKGbkNmpCDUUxW3TvLYZCrEcFiCnN3Wfrd7NpuBXSh
 AEwlWKOPjrK1aHMiHBjRhQ1dlPUcqeDuEsVNsmDgeeRxob5//cJBmZ9WG10zeZVM
 H8CBnu/2K1fhSxJNovGYukDhGpvqHZ9qzYs7+/MffQZPB5YvZ2fmap/84ddEHzCL
 hvsKIslZcJSfWw+Z9W00Q+gHJtXwF70XjrvNKcaSLavdFG6gmHy9T1LKpvVJtKvc
 2APD3p63zx9m3/hreuhsBjSgNRlRIoCMNXmD1EfkCKOS+Ps5fVh3x9M0iYKjSJgp
 v9zsAUV2Rq//NNAk1CzIwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784198277; x=
 1784205477; bh=Px18XWjpbztYrdYXu4WShzEC0WlJUQofvf45Q5YbOs0=; b=o
 +NiY+rktTa/utaClySmKRS1f4nQeSDwa0dCLki0uWuhtTBVLWVTyJr5lrHV0/rIQ
 lKD4SBzwWRBdPuci3VksTp7jUGrgUY/zWyS3TF85iscDoRPVPDmX1M1ro6+5Ut5n
 cujnKOg+MLXVY0O3o/rjUIFNorrsDsf/qTj9T8h2+4a+ddqe/BvBMsVMhCKyG8mI
 magwpV6Bvo5sxTF/CC5XauZcjSZWl4QASGIUwXhhUld3+wATFj/eEKb77Bphc7dn
 UJ9D4nHv+s9OB2YSCid+gimmnDhjXQ4OFAzxkFPPZRYdMfQ9bkX+qgfvS1338qyF
 AU7AOv4+m9W9CBH9wA0vA==
X-ME-Sender: <xms:hLRYagUaNb9mOnlfzj1C3BvBDBbdgn2lK9RucuBkRL4YotmEnbygFQ>
 <xme:hLRYaqak8bahuCvtmuyWVGp5OBEfXJEcMO6WeEi27izALjnyzH5FnL4Poesj7VSw7
 BceKhzJif8Lrko481y0wPJj3xLIfzVvQDwMm9tcEFFP0kSS_QRq3Ws>
X-ME-Received: <xmr:hLRYapt4WANYjqHTe8lbGRdFN6jWKZ0lZJkrKZW0Mg83NG5dBz5EBf5IuyuS7jM-XP9kUsWpWhRs-rL_1WlO3vc>
X-ME-Proxy-Cause: dmFkZTFPY5lj3ydOJ16aSHd806Ayc6oxxRqWBfAH5apc4HF7/+UeQ05D/CtCLxVHc/nG06
 Ktav/1QUl3Nvdg0ppGPm5ILCFQnaA3P3ifhQfNVFR5e1rpJLXhCG1YLRVmbVKFPvjhK0t0
 eqySIj23g2rPClvzkalJkALLMPk78uZRryhqf3euTkKI3UH+oWg6iIppCoYbIYIlgdVBDk
 yE9fKPEhzMueb0ZEsiu0r1NKgw4/o7ekpZmRJTHDy36IF6eJvpUyQnoUdiyQidZgFZs7SM
 Z3+ONGs/V8qrK6aSdsTuOSJzWOVAslPAib7mGesWfU2aw7ObRBRV9+JJKO6ZOfJd+OCHow
 V2R/oRrdiBKiTODhnTAyEL8OmcVlYC46uxxMdMAbX5G+JiBAjFqRM4T2GpTzUmx/G1AI/C
 gCnJioyhR/twymr8HHNjQg7sQUBaIpdT2drBJVaXWdpBLS8O4FPO5dKfZEUAuPsdsOVFv9
 ZqWelzAbzhejybVSSpkmvhSx7VBxfQ0xImwMyGcWthNhDACWuRCoXqddRUWqEgTfsu81mg
 pYK/3N0n1RnAC8eSjnAonqrpWlyhYOMpCA7NVlGTtxVcO6aK+e5Ezrump8DKaNJxvMfoXX
 8zd7TOZwkxsyPVJRgfsuiSwjaqVKDgCLYR+g1QmwpnzU/Odud47tgcoPTUGQ
X-ME-Proxy: <xmx:hLRYaprhxUSJNy5nvPbH3lAJqKSEJt_3d7Z2YAglEXqu8tp2w-Bv_A>
 <xmx:hbRYahJhSD81g5FTFkp7pJuCcD-W9YgvaVcbL5O_SBylyWYuSxYGuA>
 <xmx:hbRYao7qISyzdqSGAKUL3XIxNKq7b6KEm2WSxlffZUxnBaBgB5uQqQ>
 <xmx:hbRYaiTyQqIFpx9CRuJFPHI1Lel-gNyuBkfzrMYsduo41H1WfVjdYw>
 <xmx:hbRYakYif4NOB1K9CeK5lpiL1ImPisdhZbERfkRAsEy47iw2JmNzcvbf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:37:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Zongyu Wu <wuzongyu1@huawei.com>, Chengfei Han <han.chengfei@zte.com.cn>, 
 Ming Ran <ran.ming@zte.com.cn>,	Ankur Dwivedi <adwivedi@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>,
 Gagandeep Singh <g.singh@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,	Matan Azrad <matan@nvidia.com>,
 Kai Ji <kai.ji@intel.com>,	Vamsi Attunuru <vattunuru@marvell.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,	Jerin Jacob <jerinj@marvell.com>,
 Akhil Goyal <gakhil@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,	Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jakub Grajciar <jgrajcia@cisco.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,	Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>,	Suanming Mou <suanmingm@nvidia.com>,
 Liron Himi <lironh@marvell.com>,	Fan Zhang <fanzhang.oss@gmail.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>, Wisam Jaddo <wisamm@nvidia.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v3 4/8] doc: shorten page references in guides
Date: Thu, 16 Jul 2026 12:31:22 +0200
Message-ID: <20260716103632.711164-5-thomas@monjalon.net>
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

When linking to a document in a different guide,
using absolute path may be shorter than relative path.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/compressdevs/mlx5.rst              |  2 +-
 doc/guides/compressdevs/uadk.rst              |  2 +-
 doc/guides/compressdevs/zsda.rst              |  2 +-
 doc/guides/contributing/abi_policy.rst        |  2 +-
 doc/guides/contributing/abi_versioning.rst    |  9 ++--
 doc/guides/contributing/design.rst            |  4 +-
 doc/guides/contributing/documentation.rst     |  2 +-
 doc/guides/contributing/patches.rst           |  2 +-
 doc/guides/cryptodevs/cnxk.rst                |  4 +-
 doc/guides/cryptodevs/dpaa2_sec.rst           |  2 +-
 doc/guides/cryptodevs/dpaa_sec.rst            |  2 +-
 doc/guides/cryptodevs/mlx5.rst                |  2 +-
 doc/guides/cryptodevs/octeontx.rst            |  2 +-
 doc/guides/cryptodevs/qat.rst                 |  4 +-
 doc/guides/cryptodevs/uadk.rst                |  2 +-
 doc/guides/dmadevs/cnxk.rst                   |  2 +-
 doc/guides/dmadevs/dpaa.rst                   |  2 +-
 doc/guides/dmadevs/dpaa2.rst                  |  2 +-
 doc/guides/eventdevs/cnxk.rst                 |  2 +-
 doc/guides/eventdevs/dpaa.rst                 |  2 +-
 doc/guides/eventdevs/dpaa2.rst                |  2 +-
 doc/guides/eventdevs/octeontx.rst             |  2 +-
 doc/guides/faq/faq.rst                        |  2 +-
 doc/guides/howto/af_xdp_dp.rst                |  6 +--
 doc/guides/howto/flow_bifurcation.rst         |  2 +-
 doc/guides/howto/packet_capture_framework.rst |  6 +--
 doc/guides/howto/pvp_reference_benchmark.rst  |  4 +-
 doc/guides/howto/rte_flow.rst                 |  2 +-
 doc/guides/howto/security.rst                 | 46 +++++++++----------
 doc/guides/howto/telemetry.rst                |  2 +-
 doc/guides/linux_gsg/doc_roadmap.include.rst  | 28 +++++------
 doc/guides/linux_gsg/sys_reqs.rst             |  2 +-
 doc/guides/mempool/cnxk.rst                   |  2 +-
 doc/guides/mempool/octeontx.rst               |  2 +-
 doc/guides/mempool/ring.rst                   |  2 +-
 doc/guides/mempool/stack.rst                  |  2 +-
 doc/guides/mldevs/cnxk.rst                    |  2 +-
 doc/guides/nics/bnxt.rst                      |  2 +-
 doc/guides/nics/build_and_test.rst            |  2 +-
 doc/guides/nics/cnxk.rst                      |  2 +-
 doc/guides/nics/cpfl.rst                      |  4 +-
 doc/guides/nics/dpaa.rst                      |  2 +-
 doc/guides/nics/dpaa2.rst                     |  4 +-
 doc/guides/nics/features.rst                  |  2 +-
 doc/guides/nics/i40e.rst                      |  2 +-
 doc/guides/nics/ice.rst                       |  2 +-
 doc/guides/nics/idpf.rst                      |  4 +-
 doc/guides/nics/ixgbe.rst                     |  2 +-
 doc/guides/nics/memif.rst                     |  2 +-
 doc/guides/nics/mlx4.rst                      |  2 +-
 doc/guides/nics/mlx5.rst                      |  6 +--
 doc/guides/nics/mvpp2.rst                     |  6 +--
 doc/guides/nics/octeon_ep.rst                 |  2 +-
 doc/guides/nics/octeontx.rst                  |  2 +-
 doc/guides/platform/bluefield.rst             |  8 ++--
 doc/guides/platform/cnxk.rst                  | 20 ++++----
 doc/guides/platform/dpaa.rst                  |  6 +--
 doc/guides/platform/dpaa2.rst                 | 10 ++--
 doc/guides/platform/mlx5.rst                  | 12 ++---
 doc/guides/platform/octeontx.rst              | 10 ++--
 doc/guides/prog_guide/build-sdk-meson.rst     |  6 +--
 doc/guides/prog_guide/build_app.rst           |  2 +-
 doc/guides/prog_guide/cmdline.rst             |  2 +-
 doc/guides/prog_guide/cryptodev_lib.rst       |  4 +-
 doc/guides/prog_guide/devargs.rst             |  2 +-
 doc/guides/prog_guide/dmadev.rst              |  2 +-
 doc/guides/prog_guide/power_man.rst           |  2 +-
 doc/guides/prog_guide/profile_app.rst         |  2 +-
 doc/guides/prog_guide/rte_security.rst        |  4 +-
 doc/guides/prog_guide/source_org.rst          |  2 +-
 doc/guides/prog_guide/telemetry_lib.rst       |  2 +-
 doc/guides/prog_guide/trace_lib.rst           |  2 +-
 doc/guides/rawdevs/dpaa2_cmdif.rst            |  2 +-
 doc/guides/regexdevs/cn9k.rst                 |  2 +-
 doc/guides/regexdevs/mlx5.rst                 |  2 +-
 doc/guides/rel_notes/deprecation.rst          |  4 +-
 doc/guides/rel_notes/release_17_02.rst        |  4 +-
 doc/guides/rel_notes/release_17_11.rst        | 16 +++----
 doc/guides/rel_notes/release_18_02.rst        |  4 +-
 doc/guides/rel_notes/release_18_05.rst        | 14 +++---
 doc/guides/rel_notes/release_18_08.rst        |  4 +-
 doc/guides/rel_notes/release_18_11.rst        | 10 ++--
 doc/guides/rel_notes/release_19_02.rst        |  6 +--
 doc/guides/rel_notes/release_19_05.rst        |  4 +-
 doc/guides/rel_notes/release_19_08.rst        |  6 +--
 doc/guides/rel_notes/release_19_11.rst        | 14 +++---
 doc/guides/rel_notes/release_20_02.rst        |  4 +-
 doc/guides/rel_notes/release_20_05.rst        |  4 +-
 doc/guides/rel_notes/release_20_08.rst        |  4 +-
 doc/guides/rel_notes/release_20_11.rst        | 10 ++--
 doc/guides/rel_notes/release_21_02.rst        |  4 +-
 doc/guides/rel_notes/release_21_08.rst        |  4 +-
 doc/guides/rel_notes/release_21_11.rst        |  6 +--
 doc/guides/rel_notes/release_22_03.rst        |  2 +-
 doc/guides/rel_notes/release_22_07.rst        |  2 +-
 doc/guides/rel_notes/release_22_11.rst        | 12 ++---
 doc/guides/rel_notes/release_23_03.rst        |  2 +-
 doc/guides/rel_notes/release_23_07.rst        |  4 +-
 doc/guides/rel_notes/release_23_11.rst        |  2 +-
 doc/guides/rel_notes/release_24_07.rst        |  2 +-
 doc/guides/rel_notes/release_25_03.rst        |  2 +-
 doc/guides/rel_notes/release_25_07.rst        | 10 ++--
 doc/guides/sample_app_ug/dma.rst              |  4 +-
 doc/guides/sample_app_ug/intro.rst            |  4 +-
 doc/guides/sample_app_ug/ip_reassembly.rst    |  2 +-
 .../sample_app_ug/l3_forward_power_man.rst    |  2 +-
 doc/guides/testpmd_app_ug/run_app.rst         |  4 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  2 +-
 doc/guides/tools/dts.rst                      |  2 +-
 doc/guides/tools/flow-perf.rst                |  4 +-
 doc/guides/tools/securityperf.rst             |  4 +-
 doc/guides/tools/testbbdev.rst                |  2 +-
 doc/guides/vdpadevs/mlx5.rst                  |  2 +-
 doc/guides/windows_gsg/intro.rst              |  2 +-
 114 files changed, 257 insertions(+), 256 deletions(-)

diff --git a/doc/guides/compressdevs/mlx5.rst b/doc/guides/compressdevs/mlx5.rst
index 8eda954d4e..059854feca 100644
--- a/doc/guides/compressdevs/mlx5.rst
+++ b/doc/guides/compressdevs/mlx5.rst
@@ -24,7 +24,7 @@ So, using the BlueField device (starting from BlueField-2), the compress
 class operations can be supported in parallel to the net, vDPA and
 RegEx class operations.
 
-See :doc:`../../platform/mlx5` guide for more design details.
+See :doc:`/platform/mlx5` guide for more design details.
 
 Features
 --------
diff --git a/doc/guides/compressdevs/uadk.rst b/doc/guides/compressdevs/uadk.rst
index 27245da892..2f5218121d 100644
--- a/doc/guides/compressdevs/uadk.rst
+++ b/doc/guides/compressdevs/uadk.rst
@@ -78,7 +78,7 @@ Test steps
       ninja
       sudo ninja install
 
-#. Prepare hugepages for DPDK (see also :doc:`../tools/hugepages`)
+#. Prepare hugepages for DPDK (see also :doc:`/tools/hugepages`)
 
    .. code-block:: console
 
diff --git a/doc/guides/compressdevs/zsda.rst b/doc/guides/compressdevs/zsda.rst
index aec859822d..d5f31094bb 100644
--- a/doc/guides/compressdevs/zsda.rst
+++ b/doc/guides/compressdevs/zsda.rst
@@ -60,7 +60,7 @@ Configuring and Building the DPDK ZSDA PMDs
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Further information on configuring, building and installing DPDK is described
-:doc:`here <../linux_gsg/build_dpdk>`.
+:doc:`here </linux_gsg/build_dpdk>`.
 
 
 Build Configuration
diff --git a/doc/guides/contributing/abi_policy.rst b/doc/guides/contributing/abi_policy.rst
index 1b871dc05d..09e72ef3aa 100644
--- a/doc/guides/contributing/abi_policy.rst
+++ b/doc/guides/contributing/abi_policy.rst
@@ -38,7 +38,7 @@ General Guidelines
 .. note::
 
    Please note that this policy does not currently apply to the
-   :doc:`Windows build <../windows_gsg/intro>`.
+   :doc:`Windows build </windows_gsg/intro>`.
 
 What is an ABI?
 ~~~~~~~~~~~~~~~
diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
index 2fa2b15edc..d81b9aeea6 100644
--- a/doc/guides/contributing/abi_versioning.rst
+++ b/doc/guides/contributing/abi_versioning.rst
@@ -267,10 +267,11 @@ used by newly built applications.
 Enabling versioning macros
 __________________________
 
-Finally, we need to indicate to the :doc:`meson/ninja build system
-<../prog_guide/build-sdk-meson>` to enable versioning macros when building the
-library or driver. In the libraries or driver where we have added symbol
-versioning, in the ``meson.build`` file we add the following
+Finally, we need to indicate
+to the :doc:`Meson/Ninja build system </prog_guide/build-sdk-meson>`
+to enable versioning macros when building the library or driver.
+In the libraries or driver where we have added symbol versioning,
+in the ``meson.build`` file we add the following
 
 .. code-block:: none
 
diff --git a/doc/guides/contributing/design.rst b/doc/guides/contributing/design.rst
index 5517613424..0e5cb60053 100644
--- a/doc/guides/contributing/design.rst
+++ b/doc/guides/contributing/design.rst
@@ -77,8 +77,8 @@ as to what is happening to the application at runtime.
 DPDK provides a number of built-in mechanisms to provide this introspection:
 
 * :ref:`Logging <dynamic_logging>`
-* :doc:`Tracing <../prog_guide/trace_lib>`
-* :doc:`Telemetry <../prog_guide/telemetry_lib>`
+* :doc:`Tracing </prog_guide/trace_lib>`
+* :doc:`Telemetry </prog_guide/telemetry_lib>`
 
 Each of these has its own strengths and suitabilities for use within DPDK components.
 
diff --git a/doc/guides/contributing/documentation.rst b/doc/guides/contributing/documentation.rst
index 10c35db0c1..8cca859c73 100644
--- a/doc/guides/contributing/documentation.rst
+++ b/doc/guides/contributing/documentation.rst
@@ -182,7 +182,7 @@ To build the documentation::
 
    ninja -C build doc
 
-See :doc:`../linux_gsg/build_dpdk` for more detail on compiling DPDK with meson.
+See :doc:`/linux_gsg/build_dpdk` for more detail on compiling DPDK with meson.
 
 The output is generated in the directory ``build/doc/``, with:
 
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index 027e6c0858..53cd20ff9c 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -730,7 +730,7 @@ We do our best to include CI and self-test infrastructure
 that can be used on an individual developer basis.
 
 For details on running the unit tests, see :doc:`unit_test`.
-It is also recommended to run the :doc:`DTS <../tools/dts>` comprehensive tests.
+It is also recommended to run the :doc:`DTS </tools/dts>` comprehensive tests.
 Finally, you can also push to a branch on the GitHub service
 to trigger a comprehensive set of compile and unit test runs.
 
diff --git a/doc/guides/cryptodevs/cnxk.rst b/doc/guides/cryptodevs/cnxk.rst
index 42564872a6..c0392f4f9c 100644
--- a/doc/guides/cryptodevs/cnxk.rst
+++ b/doc/guides/cryptodevs/cnxk.rst
@@ -94,7 +94,7 @@ Installation
 The OCTEON cnxk crypto PMD may be compiled natively on an OCTEON cnxk platform
 or cross-compiled on an x86 platform.
 
-Refer to :doc:`../platform/cnxk` for instructions to build your DPDK
+Refer to :doc:`/platform/cnxk` for instructions to build your DPDK
 application.
 
 .. note::
@@ -280,7 +280,7 @@ The OCTEON cnxk SoCs can accelerate IPsec traffic in lookaside protocol mode,
 with its **cryptographic accelerator (CPT)**. ``OCTEON cnxk crypto PMD`` implements
 this as an ``RTE_SECURITY_ACTION_TYPE_LOOKASIDE_PROTOCOL`` offload.
 
-Refer to :doc:`../prog_guide/rte_security` for more details on protocol offloads.
+Refer to :doc:`/prog_guide/rte_security` for more details on protocol offloads.
 
 This feature can be tested with ipsec-secgw sample application.
 
diff --git a/doc/guides/cryptodevs/dpaa2_sec.rst b/doc/guides/cryptodevs/dpaa2_sec.rst
index 6b1357d78a..209f56305c 100644
--- a/doc/guides/cryptodevs/dpaa2_sec.rst
+++ b/doc/guides/cryptodevs/dpaa2_sec.rst
@@ -161,7 +161,7 @@ Prerequisites
 DPAA2_SEC driver has similar pre-requisites as described in :ref:`dpaa2_overview`.
 The following dependencies are not part of DPDK and must be installed separately:
 
-See :doc:`../platform/dpaa2` for setup information
+See :doc:`/platform/dpaa2` for setup information
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
 
diff --git a/doc/guides/cryptodevs/dpaa_sec.rst b/doc/guides/cryptodevs/dpaa_sec.rst
index 9980c07e86..5ca0d90c41 100644
--- a/doc/guides/cryptodevs/dpaa_sec.rst
+++ b/doc/guides/cryptodevs/dpaa_sec.rst
@@ -106,7 +106,7 @@ Prerequisites
 
 DPAA_SEC driver has similar pre-requisites as described in :ref:`dpaa_overview`.
 
-See :doc:`../platform/dpaa` for setup information
+See :doc:`/platform/dpaa` for setup information
 
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
diff --git a/doc/guides/cryptodevs/mlx5.rst b/doc/guides/cryptodevs/mlx5.rst
index e0d3542ae9..01d58bb616 100644
--- a/doc/guides/cryptodevs/mlx5.rst
+++ b/doc/guides/cryptodevs/mlx5.rst
@@ -32,7 +32,7 @@ when the MKEY is configured to perform crypto operations.
 
 The encryption does not require text to be aligned to the AES block size (128b).
 
-See :doc:`../../platform/mlx5` guide for more design details.
+See :doc:`/platform/mlx5` guide for more design details.
 
 AES-GCM
 ~~~~~~~
diff --git a/doc/guides/cryptodevs/octeontx.rst b/doc/guides/cryptodevs/octeontx.rst
index 8b0eb8a979..d08c7e3628 100644
--- a/doc/guides/cryptodevs/octeontx.rst
+++ b/doc/guides/cryptodevs/octeontx.rst
@@ -66,7 +66,7 @@ Compilation
 The OCTEON TX crypto poll mode driver can be compiled either natively on
 **OCTEON TX** :sup:`®` board or cross-compiled on an x86 based platform.
 
-Refer :doc:`../platform/octeontx` for details about setting up the platform
+Refer :doc:`/platform/octeontx` for details about setting up the platform
 and building DPDK applications.
 
 .. note::
diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index e72bdc4736..d929e9d731 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -7,7 +7,7 @@ Intel(R) QuickAssist (QAT) Crypto Poll Mode Driver
 QAT documentation consists of three parts:
 
 * Details of the symmetric and asymmetric crypto services below.
-* Details of the :doc:`compression service <../compressdevs/qat_comp>`
+* Details of the :doc:`compression service </compressdevs/qat_comp>`
   in the compressdev drivers section.
 * Details of building the common QAT infrastructure and the PMDs to support the
   above services. See :ref:`building_qat` below.
@@ -225,7 +225,7 @@ Configuring and Building the DPDK QAT PMDs
 
 
 Further information on configuring, building and installing DPDK is described
-:doc:`here <../linux_gsg/build_dpdk>`.
+:doc:`here </linux_gsg/build_dpdk>`.
 
 Build Configuration
 ~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/cryptodevs/uadk.rst b/doc/guides/cryptodevs/uadk.rst
index ae55e8ba64..501475e6b1 100644
--- a/doc/guides/cryptodevs/uadk.rst
+++ b/doc/guides/cryptodevs/uadk.rst
@@ -92,7 +92,7 @@ Test steps
       ninja
       sudo meson install
 
-#. Prepare hugepages for DPDK (see also :doc:`../tools/hugepages`)
+#. Prepare hugepages for DPDK (see also :doc:`/tools/hugepages`)
 
    .. code-block:: console
 
diff --git a/doc/guides/dmadevs/cnxk.rst b/doc/guides/dmadevs/cnxk.rst
index b671c65644..e86ae83f01 100644
--- a/doc/guides/dmadevs/cnxk.rst
+++ b/doc/guides/dmadevs/cnxk.rst
@@ -19,7 +19,7 @@ The block supports following modes of DMA transfers:
 Prerequisites and Compilation procedure
 ---------------------------------------
 
-See :doc:`../platform/cnxk` for setup information.
+See :doc:`/platform/cnxk` for setup information.
 
 Device Setup
 ------------
diff --git a/doc/guides/dmadevs/dpaa.rst b/doc/guides/dmadevs/dpaa.rst
index e6565bab83..4056173fc1 100644
--- a/doc/guides/dmadevs/dpaa.rst
+++ b/doc/guides/dmadevs/dpaa.rst
@@ -27,7 +27,7 @@ Supported DPAA SoCs
 Prerequisites
 -------------
 
-See :doc:`../platform/dpaa` for setup information
+See :doc:`/platform/dpaa` for setup information
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
 
diff --git a/doc/guides/dmadevs/dpaa2.rst b/doc/guides/dmadevs/dpaa2.rst
index 646860843f..3d75b5ed48 100644
--- a/doc/guides/dmadevs/dpaa2.rst
+++ b/doc/guides/dmadevs/dpaa2.rst
@@ -34,7 +34,7 @@ Supported DPAA2 SoCs
 Prerequisites
 -------------
 
-See :doc:`../platform/dpaa2` for setup information
+See :doc:`/platform/dpaa2` for setup information
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
 
diff --git a/doc/guides/eventdevs/cnxk.rst b/doc/guides/eventdevs/cnxk.rst
index 163acbf609..dba350bd8c 100644
--- a/doc/guides/eventdevs/cnxk.rst
+++ b/doc/guides/eventdevs/cnxk.rst
@@ -56,7 +56,7 @@ Features of the OCTEON cnxk SSO PMD are:
 Prerequisites and Compilation procedure
 ---------------------------------------
 
-   See :doc:`../platform/cnxk` for setup information.
+   See :doc:`/platform/cnxk` for setup information.
 
 
 Runtime Config Options
diff --git a/doc/guides/eventdevs/dpaa.rst b/doc/guides/eventdevs/dpaa.rst
index fed66b79a1..578c133f82 100644
--- a/doc/guides/eventdevs/dpaa.rst
+++ b/doc/guides/eventdevs/dpaa.rst
@@ -31,7 +31,7 @@ Supported DPAA SoCs
 Prerequisites
 -------------
 
-See :doc:`../platform/dpaa` for setup information
+See :doc:`/platform/dpaa` for setup information
 
 Currently supported by DPDK:
 
diff --git a/doc/guides/eventdevs/dpaa2.rst b/doc/guides/eventdevs/dpaa2.rst
index 538d0be8b0..5b28999ceb 100644
--- a/doc/guides/eventdevs/dpaa2.rst
+++ b/doc/guides/eventdevs/dpaa2.rst
@@ -34,7 +34,7 @@ Supported DPAA2 SoCs
 Prerequisites
 -------------
 
-See :doc:`../platform/dpaa2` for setup information
+See :doc:`/platform/dpaa2` for setup information
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
 
diff --git a/doc/guides/eventdevs/octeontx.rst b/doc/guides/eventdevs/octeontx.rst
index 435e1e953f..ca3ef3db3b 100644
--- a/doc/guides/eventdevs/octeontx.rst
+++ b/doc/guides/eventdevs/octeontx.rst
@@ -39,7 +39,7 @@ Supported OCTEON TX SoCs
 Prerequisites
 -------------
 
-See :doc:`../platform/octeontx` for setup information.
+See :doc:`/platform/octeontx` for setup information.
 
 
 Initialization
diff --git a/doc/guides/faq/faq.rst b/doc/guides/faq/faq.rst
index c947002a85..9503bdec59 100644
--- a/doc/guides/faq/faq.rst
+++ b/doc/guides/faq/faq.rst
@@ -184,7 +184,7 @@ I350 has RSS support and 8 queue pairs can be used in RSS mode. It should work w
 How can hugepage-backed memory be shared among multiple processes?
 ------------------------------------------------------------------
 
-See the Primary and Secondary examples in the :doc:`../sample_app_ug/multi_process`.
+See the Primary and Secondary examples in the :doc:`/sample_app_ug/multi_process`.
 
 
 Why can't my application receive packets on my system with UEFI Secure Boot enabled?
diff --git a/doc/guides/howto/af_xdp_dp.rst b/doc/guides/howto/af_xdp_dp.rst
index 68e524305e..c194ead250 100644
--- a/doc/guides/howto/af_xdp_dp.rst
+++ b/doc/guides/howto/af_xdp_dp.rst
@@ -20,7 +20,7 @@ The AF_XDP DP provisions and advertises networking interfaces to Kubernetes,
 while the CNI configures and plumbs network interfaces for the Pod.
 
 This document explains how to use the `AF_XDP Device Plugin for Kubernetes`_
-with a DPDK application using the :doc:`../nics/af_xdp`.
+with a DPDK application using the :doc:`/nics/af_xdp`.
 
 .. _AF_XDP Device Plugin for Kubernetes: https://github.com/redhat-et/afxdp-plugins-for-kubernetes
 
@@ -28,7 +28,7 @@ with a DPDK application using the :doc:`../nics/af_xdp`.
 Background
 ----------
 
-The standard :doc:`../nics/af_xdp` initialization process involves loading an eBPF program
+The standard :doc:`/nics/af_xdp` initialization process involves loading an eBPF program
 onto the kernel netdev to be used by the PMD.
 This operation requires root or escalated Linux privileges
 and thus prevents the PMD from working in an unprivileged container.
@@ -130,7 +130,7 @@ Device Plugin and DPDK container prerequisites:
 
 * dpdk-testpmd application should have AF_XDP feature enabled.
 
-  For further information see the docs for the: :doc:`../../nics/af_xdp`.
+  For further information see the docs for the: :doc:`/nics/af_xdp`.
 
 
 Example
diff --git a/doc/guides/howto/flow_bifurcation.rst b/doc/guides/howto/flow_bifurcation.rst
index 69885e6eb6..c1e125072a 100644
--- a/doc/guides/howto/flow_bifurcation.rst
+++ b/doc/guides/howto/flow_bifurcation.rst
@@ -56,7 +56,7 @@ the :ref:`flow_isolated_mode` must be configured,
 so there is no default rule routing traffic to userspace.
 
 There is no specific instructions to follow.
-The recommended reading is the :doc:`../prog_guide/ethdev/flow_offload` guide.
+The recommended reading is the :doc:`/prog_guide/ethdev/flow_offload` guide.
 Below is an example of testpmd commands
 for receiving VXLAN 42 in 4 queues of the DPDK port 0,
 while all other packets go to the kernel:
diff --git a/doc/guides/howto/packet_capture_framework.rst b/doc/guides/howto/packet_capture_framework.rst
index 4099c419aa..417bd7ba7b 100644
--- a/doc/guides/howto/packet_capture_framework.rst
+++ b/doc/guides/howto/packet_capture_framework.rst
@@ -19,16 +19,16 @@ There are two sample applications: ``dpdk-dumpcap`` and older ``dpdk-pdump``.
 Introduction
 ------------
 
-The :doc:`librte_pdump <../prog_guide/pdump_lib>` library provides the API
+The :doc:`librte_pdump </prog_guide/pdump_lib>` library provides the API
 required to allow users to initialize the packet capture framework
 and to enable or disable packet capture.
 The library works on a multi-process communication model
 and its usage is recommended for debugging purposes.
 
-The :doc:`librte_pcapng <../prog_guide/pcapng_lib>` library provides the API
+The :doc:`librte_pcapng </prog_guide/pcapng_lib>` library provides the API
 to format packets and write them to a file in Pcapng format.
 
-The :doc:`dpdk-dumpcap <../tools/dumpcap>` is a tool that captures packets in
+The :doc:`dpdk-dumpcap </tools/dumpcap>` is a tool that captures packets in
 like Wireshark dumpcap does for Linux.
 It runs as a DPDK secondary process and captures packets
 from one or more interfaces and writes them to a file in Pcapng format.
diff --git a/doc/guides/howto/pvp_reference_benchmark.rst b/doc/guides/howto/pvp_reference_benchmark.rst
index c2de0bbc74..d35456c2ac 100644
--- a/doc/guides/howto/pvp_reference_benchmark.rst
+++ b/doc/guides/howto/pvp_reference_benchmark.rst
@@ -97,7 +97,7 @@ Build Qemu:
 DPDK build
 ~~~~~~~~~~
 
-See :doc:`../linux_gsg/build_dpdk` for details.
+See :doc:`/linux_gsg/build_dpdk` for details.
 
 
 Testpmd launch
@@ -304,7 +304,7 @@ Guest tuning
 DPDK build
 ~~~~~~~~~~
 
-See :doc:`../linux_gsg/build_dpdk` for details.
+See :doc:`/linux_gsg/build_dpdk` for details.
 
 
 Testpmd launch
diff --git a/doc/guides/howto/rte_flow.rst b/doc/guides/howto/rte_flow.rst
index 428ec3f411..8b1cb85108 100644
--- a/doc/guides/howto/rte_flow.rst
+++ b/doc/guides/howto/rte_flow.rst
@@ -8,7 +8,7 @@ This document demonstrates some concrete examples for programming flow rules
 with the ``rte_flow`` APIs.
 
 * Detail of the rte_flow APIs can be found in the following link:
-  :doc:`../prog_guide/ethdev/flow_offload`.
+  :doc:`/prog_guide/ethdev/flow_offload`.
 
 * Details of the TestPMD commands to set the flow rules can be found in the
   following link: :ref:`TestPMD Flow rules <testpmd_rte_flow>`
diff --git a/doc/guides/howto/security.rst b/doc/guides/howto/security.rst
index ce786852aa..21a33b7d65 100644
--- a/doc/guides/howto/security.rst
+++ b/doc/guides/howto/security.rst
@@ -19,20 +19,20 @@ Related Documentation
 Here is a list of related documents that provide detail of each library,
 its capabilities and what level of support it currently has within DPDK.
 
-:doc:`../prog_guide/cryptodev_lib`
+:doc:`/prog_guide/cryptodev_lib`
    This section contains the design of the crypto API.
 
-:doc:`../cryptodevs/index`
+:doc:`/cryptodevs/index`
    This section contains information about all the crypto drivers in DPDK,
    such as feature support availability, cipher algorithms and authentication algorithms.
 
-:doc:`../prog_guide/rte_security`
+:doc:`/prog_guide/rte_security`
    This library is the session-level glue between ethdev and cryptodev APIs
    for the supported protocols.
 
 High-level protocol processing
-   * :doc:`../prog_guide/ipsec_lib`
-   * :doc:`../prog_guide/pdcp_lib`
+   * :doc:`/prog_guide/ipsec_lib`
+   * :doc:`/prog_guide/pdcp_lib`
 
 
 Protocols
@@ -55,15 +55,15 @@ Standard Link
 
 Level of Support in DPDK
   * Supported
-  * :doc:`Sample Application <../sample_app_ug/l2_forward_macsec>`
+  * :doc:`Sample Application </sample_app_ug/l2_forward_macsec>`
 
 Supported Algorithms
   * As specified by MACsec specification: AES-128-GCM, AES-256-GCM
 
 Drivers
-  * Marvell :doc:`cnxk <../nics/cnxk>`
-  * Marvell/Aquantia :doc:`atlantic <../nics/atlantic>` with PMD-specific API
-  * Intel :doc:`ixgbe <../nics/ixgbe>` with PMD-specific API
+  * Marvell :doc:`cnxk </nics/cnxk>`
+  * Marvell/Aquantia :doc:`atlantic </nics/atlantic>` with PMD-specific API
+  * Intel :doc:`ixgbe </nics/ixgbe>` with PMD-specific API
 
 Facts
   * Uses the AES-GCM cryptography algorithm.
@@ -100,8 +100,8 @@ Standard Link
 
 Level of Support in DPDK
   * Supported
-  * :doc:`High-level library <../prog_guide/ipsec_lib>`
-  * :doc:`Sample application <../sample_app_ug/ipsec_secgw>`
+  * :doc:`High-level library </prog_guide/ipsec_lib>`
+  * :doc:`Sample application </sample_app_ug/ipsec_secgw>`
 
 Supported Algorithms
   * AES-GCM and ChaCha20-Poly1305
@@ -109,13 +109,13 @@ Supported Algorithms
   * HMAC-SHA1/SHA2 for integrity protection and authenticity
 
 Drivers
-  * Intel :doc:`ixgbe <../nics/ixgbe>`, :doc:`iavf <../nics/intel_vf>`,
-    :doc:`qat <../cryptodevs/qat>`, :doc:`ipsec_mb <../cryptodevs/aesni_mb>`
-  * Marvell :doc:`cnxk <../nics/cnxk>`, :doc:`mvsam <../cryptodevs/mvsam>`
-  * Netronome :doc:`nfp <../nics/nfp>`
-  * NXP :doc:`caam_jr <../cryptodevs/caam_jr>`,
-    :doc:`dpaa_sec <../cryptodevs/dpaa_sec>`, :doc:`dpaa2_sec <../cryptodevs/dpaa2_sec>`
-  * Wangxun :doc:`txgbe <../nics/txgbe>`
+  * Intel :doc:`ixgbe </nics/ixgbe>`, :doc:`iavf </nics/intel_vf>`,
+    :doc:`qat </cryptodevs/qat>`, :doc:`ipsec_mb </cryptodevs/aesni_mb>`
+  * Marvell :doc:`cnxk </nics/cnxk>`, :doc:`mvsam </cryptodevs/mvsam>`
+  * Netronome :doc:`nfp </nics/nfp>`
+  * NXP :doc:`caam_jr </cryptodevs/caam_jr>`,
+    :doc:`dpaa_sec </cryptodevs/dpaa_sec>`, :doc:`dpaa2_sec </cryptodevs/dpaa2_sec>`
+  * Wangxun :doc:`txgbe </nics/txgbe>`
 
 Pros
   * Uses public keys to create an encrypted, authenticated tunnel.
@@ -219,7 +219,7 @@ Supported Algorithms
   * CHACHA20-POLY1305
 
 Drivers
-  * Marvell :doc:`cnxk <../cryptodevs/cnxk>`
+  * Marvell :doc:`cnxk </cryptodevs/cnxk>`
 
 
 PDCP
@@ -239,7 +239,7 @@ Standard Link
 
 Level of Support in DPDK
   * Supported
-  * :doc:`High-level library <../prog_guide/pdcp_lib>`
+  * :doc:`High-level library </prog_guide/pdcp_lib>`
   * rte_security based PDCP sessions are also supported
 
 Supported Algorithms
@@ -247,11 +247,11 @@ Supported Algorithms
   * Authentication: NULL, AES-CMAC, SNOW 3G, ZUC
 
 Drivers supporting rte_security API (and used with the PDCP library)
-  * NXP :doc:`dpaa_sec <../cryptodevs/dpaa_sec>`, :doc:`dpaa2_sec <../cryptodevs/dpaa2_sec>`
+  * NXP :doc:`dpaa_sec </cryptodevs/dpaa_sec>`, :doc:`dpaa2_sec </cryptodevs/dpaa2_sec>`
 
 Drivers supported only with the PDCP library
-  * Intel :doc:`qat <../cryptodevs/qat>`, :doc:`ipsec_mb <../cryptodevs/aesni_mb>`
-  * Marvell :doc:`cnxk <../nics/cnxk>`
+  * Intel :doc:`qat </cryptodevs/qat>`, :doc:`ipsec_mb </cryptodevs/aesni_mb>`
+  * Marvell :doc:`cnxk </nics/cnxk>`
 
 Pros
   * Compresses the IP header of user plane packets
diff --git a/doc/guides/howto/telemetry.rst b/doc/guides/howto/telemetry.rst
index 5a6f6667bc..b3f25c1113 100644
--- a/doc/guides/howto/telemetry.rst
+++ b/doc/guides/howto/telemetry.rst
@@ -13,7 +13,7 @@ ethdev port list, and eal parameters.
 Telemetry Interface
 -------------------
 
-The :doc:`../prog_guide/telemetry_lib` opens a socket with path
+The :doc:`/prog_guide/telemetry_lib` opens a socket with path
 *<runtime_directory>/dpdk_telemetry.<version>*. The version represents the
 telemetry version, the latest is v2. For example, a client would connect to a
 socket with path  */var/run/dpdk/\*/dpdk_telemetry.v2* (when the primary process
diff --git a/doc/guides/linux_gsg/doc_roadmap.include.rst b/doc/guides/linux_gsg/doc_roadmap.include.rst
index 5042c386c2..64210b3614 100644
--- a/doc/guides/linux_gsg/doc_roadmap.include.rst
+++ b/doc/guides/linux_gsg/doc_roadmap.include.rst
@@ -6,7 +6,7 @@
 
 The following is a list of DPDK documents in the suggested reading order:
 
-*   :doc:`../rel_notes/index`: Provides release-specific information, including supported
+*   :doc:`/rel_notes/index`: Provides release-specific information, including supported
     features, limitations, fixed issues, known issues and so on.  Also, provides the
     answers to frequently asked questions in FAQ format.
 
@@ -14,7 +14,7 @@ The following is a list of DPDK documents in the suggested reading order:
     configure the DPDK; designed to get users up and running quickly with the
     software.
 
-*   :doc:`../prog_guide/index`: Describes:
+*   :doc:`/prog_guide/index`: Describes:
 
     *   The software architecture and how to use it (through examples),
         specifically in a Linux* application environment
@@ -31,31 +31,31 @@ The following is a list of DPDK documents in the suggested reading order:
 *   `API Reference <../../../api/html/index.html>`_: Provides detailed information about DPDK functions,
     data structures and other programming constructs.
 
-*   :doc:`../sample_app_ug/index`: Describes a set of sample applications.
+*   :doc:`/sample_app_ug/index`: Describes a set of sample applications.
     Each chapter describes a sample application that showcases specific functionality
     and provides instructions on how to compile, run and use the sample application.
 
 *   **Driver Reference Guides**: Provides details on each driver inside a particular category.
     Separate guides exist for each of:
 
-    * :doc:`../bbdevs/index`
+    * :doc:`/bbdevs/index`
 
-    * :doc:`../compressdevs/index`
+    * :doc:`/compressdevs/index`
 
-    * :doc:`../cryptodevs/index`
+    * :doc:`/cryptodevs/index`
 
-    * :doc:`../dmadevs/index`
+    * :doc:`/dmadevs/index`
 
-    * :doc:`../eventdevs/index`
+    * :doc:`/eventdevs/index`
 
-    * :doc:`../gpus/index`
+    * :doc:`/gpus/index`
 
-    * :doc:`../mempool/index`
+    * :doc:`/mempool/index`
 
-    * :doc:`../nics/index`
+    * :doc:`/nics/index`
 
-    * :doc:`../rawdevs/index`
+    * :doc:`/rawdevs/index`
 
-    * :doc:`../regexdevs/index`
+    * :doc:`/regexdevs/index`
 
-    * :doc:`../vdpadevs/index`
+    * :doc:`/vdpadevs/index`
diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index a3eef5b93d..3e0c902555 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -88,7 +88,7 @@ For libraries the additional dependencies include:
 
 For poll-mode drivers, the additional dependencies for each driver can be
 found in that driver's documentation in the relevant DPDK guide document,
-e.g. :doc:`../nics/index`
+e.g. :doc:`/nics/index`
 
 .. _linux_gsg_running_apps:
 
diff --git a/doc/guides/mempool/cnxk.rst b/doc/guides/mempool/cnxk.rst
index 7b27ef7aab..9879261454 100644
--- a/doc/guides/mempool/cnxk.rst
+++ b/doc/guides/mempool/cnxk.rst
@@ -38,7 +38,7 @@ CN20k NPA supports:
 Prerequisites and Compilation procedure
 ---------------------------------------
 
-   See :doc:`../platform/cnxk` for setup information.
+   See :doc:`/platform/cnxk` for setup information.
 
 Pre-Installation Configuration
 ------------------------------
diff --git a/doc/guides/mempool/octeontx.rst b/doc/guides/mempool/octeontx.rst
index eeaa7fb1dc..3260e253e5 100644
--- a/doc/guides/mempool/octeontx.rst
+++ b/doc/guides/mempool/octeontx.rst
@@ -46,7 +46,7 @@ Please note that enabling debugging options may affect system performance.
 Driver Compilation
 ~~~~~~~~~~~~~~~~~~
 
-See :doc:`../linux_gsg/build_dpdk` for more information on compiling DPDK.
+See :doc:`/linux_gsg/build_dpdk` for more information on compiling DPDK.
 
 
 Initialization
diff --git a/doc/guides/mempool/ring.rst b/doc/guides/mempool/ring.rst
index 37c67b3299..3461ab5fa1 100644
--- a/doc/guides/mempool/ring.rst
+++ b/doc/guides/mempool/ring.rst
@@ -49,4 +49,4 @@ mode is usually the most suitable and the fastest one. For overcommitted
 scenarios (multiple threads share same set of cores) the ``ring_mt_rts`` or
 ``ring_mt_hts`` modes usually provide a better alternative.
 For more information about ``rte_ring`` structure, behaviour and available
-synchronisation modes please refer to: :doc:`../prog_guide/ring_lib`.
+synchronisation modes please refer to: :doc:`/prog_guide/ring_lib`.
diff --git a/doc/guides/mempool/stack.rst b/doc/guides/mempool/stack.rst
index ab71716bdf..80ea07e65d 100644
--- a/doc/guides/mempool/stack.rst
+++ b/doc/guides/mempool/stack.rst
@@ -40,4 +40,4 @@ be preempted at any point during a push or pop operation and will not impede
 the progress of any other thread.
 
 For a more detailed description of the stack implementations, please refer to
-:doc:`../prog_guide/stack_lib`.
+:doc:`/prog_guide/stack_lib`.
diff --git a/doc/guides/mldevs/cnxk.rst b/doc/guides/mldevs/cnxk.rst
index afd0224fe2..6a25acddd0 100644
--- a/doc/guides/mldevs/cnxk.rst
+++ b/doc/guides/mldevs/cnxk.rst
@@ -157,7 +157,7 @@ it is required to update environment variables as below:
    CMAKE_PREFIX_PATH='<install_prefix>/lib/cmake/tvm:<install_prefix>/lib/cmake/dlpack:<install_prefix>/lib/cmake/dmlc'
    PKG_CONFIG_PATH='<install_prefix>/lib/pkgconfig'
 
-Refer to :doc:`../platform/cnxk` for instructions to build your DPDK application.
+Refer to :doc:`/platform/cnxk` for instructions to build your DPDK application.
 
 
 Initialization
diff --git a/doc/guides/nics/bnxt.rst b/doc/guides/nics/bnxt.rst
index 0667affe46..45529a89ee 100644
--- a/doc/guides/nics/bnxt.rst
+++ b/doc/guides/nics/bnxt.rst
@@ -77,7 +77,7 @@ It can direct some traffic, for example data plane traffic, to DPDK.
 Rest of the traffic, for example control plane traffic, would be redirected to
 the traditional Linux networking stack.
 
-Refer to :doc:`../howto/flow_bifurcation`
+Refer to :doc:`/howto/flow_bifurcation`
 
 Benefits of the flow bifurcation include:
 
diff --git a/doc/guides/nics/build_and_test.rst b/doc/guides/nics/build_and_test.rst
index 65264b9dbc..57e9e5c382 100644
--- a/doc/guides/nics/build_and_test.rst
+++ b/doc/guides/nics/build_and_test.rst
@@ -24,7 +24,7 @@ as described in the "Getting Started Guide" for your platform.
 This will also build testpmd.
 
 Detailed instructions are available
-in the :doc:`meson build guide <../prog_guide/build-sdk-meson>`.
+in the :doc:`meson build guide </prog_guide/build-sdk-meson>`.
 
 The ethdev layer supports below build options for debug purpose:
 
diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index 30b2747787..441b3ce5c4 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -46,7 +46,7 @@ Features of the CNXK Ethdev PMD are:
 Prerequisites
 -------------
 
-See :doc:`../platform/cnxk` for setup information.
+See :doc:`/platform/cnxk` for setup information.
 
 
 Driver compilation and testing
diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
index 377397e621..3e2788ba03 100644
--- a/doc/guides/nics/cpfl.rst
+++ b/doc/guides/nics/cpfl.rst
@@ -15,10 +15,10 @@ for more information.
 Linux Prerequisites
 -------------------
 
-Follow the DPDK :doc:`../linux_gsg/index` to setup the basic DPDK environment.
+Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 To get better performance on Intel platforms,
-please follow the :doc:`../linux_gsg/nic_perf_intel_platform`.
+please follow the :doc:`/linux_gsg/nic_perf_intel_platform`.
 
 
 Recommended Matching List
diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index 8ffe31ce32..4354c57828 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -188,7 +188,7 @@ Supported DPAA SoCs
 Prerequisites
 -------------
 
-See :doc:`../platform/dpaa` for setup information
+See :doc:`/platform/dpaa` for setup information
 
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 4fdb7383c3..2368173432 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -420,7 +420,7 @@ Supported DPAA2 SoCs
 Prerequisites
 -------------
 
-See :doc:`../platform/dpaa2` for setup information
+See :doc:`/platform/dpaa2` for setup information
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
 
@@ -619,7 +619,7 @@ of configured tx queues.
 
 After hierarchy is complete it can be committed.
 
-For an additional description please refer to DPDK :doc:`../prog_guide/ethdev/traffic_management`.
+For an additional description please refer to DPDK :doc:`/prog_guide/ethdev/traffic_management`.
 
 Supported Features
 ~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index 43db96c3e1..0b0c69e7cd 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -1018,7 +1018,7 @@ PMD power management using monitor addresses
 --------------------------------------------
 
 Supports getting a monitoring condition to use together with Ethernet PMD power
-management (see :doc:`../prog_guide/power_man` for more details).
+management (see :doc:`/prog_guide/power_man` for more details).
 
 * **[implements] eth_dev_ops**: ``get_monitor_addr``
 
diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index a2858ef8bc..3e43ab3d2a 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -78,7 +78,7 @@ Linux Prerequisites
 Windows Prerequisites
 ---------------------
 
-- Follow the :doc:`guide for Windows <../windows_gsg/run_apps>`
+- Follow the :doc:`guide for Windows </windows_gsg/run_apps>`
   to setup the basic DPDK environment.
 
 - Identify the Intel® Ethernet adapter and get the latest NVM/FW version.
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 3f3d36586d..f5d575d22f 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -34,7 +34,7 @@ Linux Prerequisites
 Windows Prerequisites
 ---------------------
 
-- Follow the :doc:`guide for Windows <../windows_gsg/run_apps>`
+- Follow the :doc:`guide for Windows </windows_gsg/run_apps>`
   to setup the basic DPDK environment.
 
 - Identify the Intel® Ethernet adapter and get the latest NVM/FW version.
diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index cc89d22cf0..f4cd69ba7d 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -13,10 +13,10 @@ Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100.
 Linux Prerequisites
 -------------------
 
-Follow the DPDK :doc:`../linux_gsg/index` to setup the basic DPDK environment.
+Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 To get better performance on Intel platforms,
-please follow the :doc:`../linux_gsg/nic_perf_intel_platform`.
+please follow the :doc:`/linux_gsg/nic_perf_intel_platform`.
 
 
 Recommended Matching List
diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index 90fdf0a39f..db1c8b1aea 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -102,7 +102,7 @@ By default, IXGBE_MAX_RING_DESC is set to 8192 and RTE_PMD_IXGBE_RX_MAX_BURST is
 Windows Prerequisites and Pre-conditions
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-- Follow the :doc:`guide for Windows <../windows_gsg/run_apps>`
+- Follow the :doc:`guide for Windows </windows_gsg/run_apps>`
   to setup the basic DPDK environment.
 
 - Identify the Intel\ |reg| Ethernet adapter and get the latest NVM/FW version.
diff --git a/doc/guides/nics/memif.rst b/doc/guides/nics/memif.rst
index 79b048865f..f8b629ab1f 100644
--- a/doc/guides/nics/memif.rst
+++ b/doc/guides/nics/memif.rst
@@ -238,7 +238,7 @@ Show status::
 
     testpmd> show port stats 0
 
-For more details on testpmd please refer to :doc:`../testpmd_app_ug/index`.
+For more details on testpmd please refer to :doc:`/testpmd_app_ug/index`.
 
 Example: testpmd and VPP
 ------------------------
diff --git a/doc/guides/nics/mlx4.rst b/doc/guides/nics/mlx4.rst
index 364f2c3741..63b1c548d2 100644
--- a/doc/guides/nics/mlx4.rst
+++ b/doc/guides/nics/mlx4.rst
@@ -306,7 +306,7 @@ Quick Start Guide
         service openibd restart
 
 #. Install DPDK and you are ready to go.
-   See :doc:`compilation instructions <../linux_gsg/build_dpdk>`.
+   See :doc:`compilation instructions </linux_gsg/build_dpdk>`.
 
 Performance tuning
 ------------------
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 9b035b878e..3a419d7d97 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -126,7 +126,7 @@ with :ref:`hardware steering (HWS) <mlx5_hws>`,
 a WQE-based high scaling and safer flow insertion/destruction.
 It allows inserting millions of rules per second.
 
-While using the :doc:`synchronous flow API <../prog_guide/ethdev/flow_offload>`
+While using the :doc:`synchronous flow API </prog_guide/ethdev/flow_offload>`
 is convenient and easy to manage,
 it is not efficient enough at a large scale.
 That's why mlx5 allows offloading many features asynchronously.
@@ -154,7 +154,7 @@ All references to these flows held by the application
 should be discarded directly but neither destroyed nor flushed.
 The application should re-create the flows as required after the port restart.
 
-See :doc:`../../platform/mlx5` guide for more design details,
+See :doc:`/platform/mlx5` guide for more design details,
 including prerequisites installation.
 
 :ref:`All the features are detailed in a chapter below. <mlx5_net_features>`
@@ -1332,7 +1332,7 @@ Flow Rule Creation
 
 In mlx5 devices, the flow rules are inserted in HW tables.
 
-As explained in the :doc:`flow API documentation <../prog_guide/ethdev/flow_offload>`,
+As explained in the :doc:`flow API documentation </prog_guide/ethdev/flow_offload>`,
 a rule can be created synchronously (``rte_flow_create``)
 or asynchronously (``rte_flow_async_create``)
 with the help of a template table (``rte_flow_template_table_create``).
diff --git a/doc/guides/nics/mvpp2.rst b/doc/guides/nics/mvpp2.rst
index 48cbe97f23..304ec25351 100644
--- a/doc/guides/nics/mvpp2.rst
+++ b/doc/guides/nics/mvpp2.rst
@@ -401,7 +401,7 @@ can be configured via generic flow API offered by DPDK.
 
 The :ref:`flow_isolated_mode` is supported.
 
-For an additional description please refer to DPDK :doc:`../prog_guide/ethdev/flow_offload`.
+For an additional description please refer to DPDK :doc:`/prog_guide/ethdev/flow_offload`.
 
 Supported flow actions
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -576,7 +576,7 @@ MVPP2 PMD supports DPDK traffic metering and policing that allows the following:
 
 #. Gather statistics.
 
-For an additional description please refer to DPDK :doc:`../prog_guide/ethdev/traffic_metering_and_policing`.
+For an additional description please refer to DPDK :doc:`/prog_guide/ethdev/traffic_metering_and_policing`.
 
 The policer objects defined by this feature can work with the default policer defined via config file as described in :ref:`QoS Support <extconf>`.
 
@@ -655,7 +655,7 @@ of configured tx queues.
 After hierarchy is complete it can be committed.
 
 
-For an additional description please refer to DPDK :doc:`../prog_guide/ethdev/traffic_management`.
+For an additional description please refer to DPDK :doc:`/prog_guide/ethdev/traffic_management`.
 
 Limitations
 ~~~~~~~~~~~
diff --git a/doc/guides/nics/octeon_ep.rst b/doc/guides/nics/octeon_ep.rst
index b48cca62b2..e47f5f697e 100644
--- a/doc/guides/nics/octeon_ep.rst
+++ b/doc/guides/nics/octeon_ep.rst
@@ -40,4 +40,4 @@ must be installed separately:
   allocates resources such as number of VFs, input/output queues for itself and
   the number of i/o queues each VF can use.
 
-See :doc:`../platform/cnxk` for SDP interface information which provides PCIe endpoint support for a remote host.
+See :doc:`/platform/cnxk` for SDP interface information which provides PCIe endpoint support for a remote host.
diff --git a/doc/guides/nics/octeontx.rst b/doc/guides/nics/octeontx.rst
index f963eca648..a13e3659ef 100644
--- a/doc/guides/nics/octeontx.rst
+++ b/doc/guides/nics/octeontx.rst
@@ -47,7 +47,7 @@ The features supported by the device and not yet supported by this PMD include:
 Prerequisites
 -------------
 
-See :doc:`../platform/octeontx` for setup information.
+See :doc:`/platform/octeontx` for setup information.
 
 Configuration
 -------------
diff --git a/doc/guides/platform/bluefield.rst b/doc/guides/platform/bluefield.rst
index 67a70b1313..97f7a410a1 100644
--- a/doc/guides/platform/bluefield.rst
+++ b/doc/guides/platform/bluefield.rst
@@ -33,12 +33,12 @@ Common Offload HW Drivers
 
 #. **NIC Driver**
 
-   See :doc:`../nics/mlx5` for NVIDIA mlx5 NIC driver information.
+   See :doc:`/nics/mlx5` for NVIDIA mlx5 NIC driver information.
 
 #. **Cryptodev Driver**
 
    This is based on the crypto extension support of armv8. See
-   :doc:`../cryptodevs/armv8` for armv8 crypto driver information.
+   :doc:`/cryptodevs/armv8` for armv8 crypto driver information.
 
 .. note::
 
@@ -71,7 +71,7 @@ an x86 based platform.
 Native Compilation
 ~~~~~~~~~~~~~~~~~~
 
-Refer to :doc:`../nics/mlx5` for prerequisites. Either NVIDIA MLNX_OFED/EN or
+Refer to :doc:`/nics/mlx5` for prerequisites. Either NVIDIA MLNX_OFED/EN or
 rdma-core library with corresponding kernel drivers is required.
 
 .. code-block:: console
@@ -82,7 +82,7 @@ rdma-core library with corresponding kernel drivers is required.
 Cross Compilation
 ~~~~~~~~~~~~~~~~~
 
-Refer to :doc:`../linux_gsg/cross_build_dpdk_for_arm64` to install the cross
+Refer to :doc:`/linux_gsg/cross_build_dpdk_for_arm64` to install the cross
 toolchain for ARM64. Base on that, additional header files and libraries are
 required:
 
diff --git a/doc/guides/platform/cnxk.rst b/doc/guides/platform/cnxk.rst
index f5248dae54..06202bcbc2 100644
--- a/doc/guides/platform/cnxk.rst
+++ b/doc/guides/platform/cnxk.rst
@@ -160,25 +160,25 @@ HW Offload Drivers
 This section lists dataplane H/W block(s) available in cnxk SoC.
 
 #. **Ethdev Driver**
-   See :doc:`../nics/cnxk` for NIX Ethdev driver information.
+   See :doc:`/nics/cnxk` for NIX Ethdev driver information.
 
 #. **Mempool Driver**
-   See :doc:`../mempool/cnxk` for NPA mempool driver information.
+   See :doc:`/mempool/cnxk` for NPA mempool driver information.
 
 #. **Baseband PHY Driver**
-   See :doc:`../rawdevs/cnxk_bphy` for Baseband PHY driver information.
+   See :doc:`/rawdevs/cnxk_bphy` for Baseband PHY driver information.
 
 #. **Dmadev Driver**
-   See :doc:`../dmadevs/cnxk` for DPI Dmadev driver information.
+   See :doc:`/dmadevs/cnxk` for DPI Dmadev driver information.
 
 #. **Regex Device Driver**
-   See :doc:`../regexdevs/cn9k` for REE Regex device driver information.
+   See :doc:`/regexdevs/cn9k` for REE Regex device driver information.
 
 #. **ML Device Driver**
-   See :doc:`../mldevs/cnxk` for Machine Learning device driver information.
+   See :doc:`/mldevs/cnxk` for Machine Learning device driver information.
 
 #. **RVU LF Driver**
-   See :doc:`../rawdevs/cnxk_rvu_lf` for RVU LF driver information.
+   See :doc:`/rawdevs/cnxk_rvu_lf` for RVU LF driver information.
 
 Procedure to Setup Platform
 ---------------------------
@@ -242,7 +242,7 @@ compatible board:
    Alternatively, the Marvell SDK provides the buildroot based root filesystem.
    The SDK includes all the above prerequisites necessary to bring up the cnxk board.
 
-- Follow the DPDK :doc:`../linux_gsg/index` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 
 Debugging Options
@@ -597,7 +597,7 @@ Disabling the iova field in the mbuf frees it up to be used as a dynamic field.
 Native Compilation
 ~~~~~~~~~~~~~~~~~~
 
-Refer to :doc:`../linux_gsg/build_dpdk` for generic native builds.
+Refer to :doc:`/linux_gsg/build_dpdk` for generic native builds.
 
 CN9K:
 
@@ -616,7 +616,7 @@ CN10K:
 Cross Compilation
 ~~~~~~~~~~~~~~~~~
 
-Refer to :doc:`../linux_gsg/cross_build_dpdk_for_arm64` for generic arm64 details.
+Refer to :doc:`/linux_gsg/cross_build_dpdk_for_arm64` for generic arm64 details.
 
 CN9K:
 
diff --git a/doc/guides/platform/dpaa.rst b/doc/guides/platform/dpaa.rst
index 68ef4a8d7b..caeeb03254 100644
--- a/doc/guides/platform/dpaa.rst
+++ b/doc/guides/platform/dpaa.rst
@@ -24,15 +24,15 @@ Common Offload HW Block Drivers
 
 #. **Nics Driver**
 
-   See :doc:`../nics/dpaa` for NXP dpaa nic driver information.
+   See :doc:`/nics/dpaa` for NXP dpaa nic driver information.
 
 #. **Cryptodev Driver**
 
-   See :doc:`../cryptodevs/dpaa_sec` for NXP dpaa cryptodev driver information.
+   See :doc:`/cryptodevs/dpaa_sec` for NXP dpaa cryptodev driver information.
 
 #. **Eventdev Driver**
 
-   See :doc:`../eventdevs/dpaa` for NXP dpaa eventdev driver information.
+   See :doc:`/eventdevs/dpaa` for NXP dpaa eventdev driver information.
 
 
 Steps To Setup Platform
diff --git a/doc/guides/platform/dpaa2.rst b/doc/guides/platform/dpaa2.rst
index fe627bc0c1..589c55d0b2 100644
--- a/doc/guides/platform/dpaa2.rst
+++ b/doc/guides/platform/dpaa2.rst
@@ -26,23 +26,23 @@ Common Offload HW Block Drivers
 
 #. **Nics Driver**
 
-   See :doc:`../nics/dpaa2` for NXP dpaa2 nic driver information.
+   See :doc:`/nics/dpaa2` for NXP dpaa2 nic driver information.
 
 #. **Cryptodev Driver**
 
-   See :doc:`../cryptodevs/dpaa2_sec` for NXP dpaa2 cryptodev driver information.
+   See :doc:`/cryptodevs/dpaa2_sec` for NXP dpaa2 cryptodev driver information.
 
 #. **Eventdev Driver**
 
-   See :doc:`../eventdevs/dpaa2` for NXP dpaa2 eventdev driver information.
+   See :doc:`/eventdevs/dpaa2` for NXP dpaa2 eventdev driver information.
 
 #. **Rawdev AIOP CMDIF Driver**
 
-   See :doc:`../rawdevs/dpaa2_cmdif` for NXP dpaa2 AIOP command interface driver information.
+   See :doc:`/rawdevs/dpaa2_cmdif` for NXP dpaa2 AIOP command interface driver information.
 
 #. **DMA Driver**
 
-   See :doc:`../dmadevs/dpaa2` for NXP dpaa2 QDMA driver information.
+   See :doc:`/dmadevs/dpaa2` for NXP dpaa2 QDMA driver information.
 
 
 Steps To Setup Platform
diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index 23cfba3356..611d9bec19 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -64,11 +64,11 @@ For example: ``class=crypto:regex`` will probe both Crypto and RegEx PMDs.
 Supported Classes
 ~~~~~~~~~~~~~~~~~
 
-- ``class=compress`` for :doc:`../../compressdevs/mlx5`.
-- ``class=crypto`` for :doc:`../../cryptodevs/mlx5`.
-- ``class=eth`` for :doc:`../../nics/mlx5`.
-- ``class=regex`` for :doc:`../../regexdevs/mlx5`.
-- ``class=vdpa`` for :doc:`../../vdpadevs/mlx5`.
+- ``class=compress`` for :doc:`/compressdevs/mlx5`.
+- ``class=crypto`` for :doc:`/cryptodevs/mlx5`.
+- ``class=eth`` for :doc:`/nics/mlx5`.
+- ``class=regex`` for :doc:`/regexdevs/mlx5`.
+- ``class=vdpa`` for :doc:`/vdpadevs/mlx5`.
 
 By default, the mlx5 device will be probed by the ``eth`` PMD.
 
@@ -207,7 +207,7 @@ to match the kernel modules and libraries they come with.
 
    Several versions of NVIDIA MLNX_OFED/EN are available. Installing the version
    this DPDK release was developed and tested against is strongly recommended.
-   Please check the "Tested Platforms" section in the :doc:`../../rel_notes/index`.
+   Please check the "Tested Platforms" section in the :doc:`/rel_notes/index`.
 
 
 .. _mlx5_windows_prerequisites:
diff --git a/doc/guides/platform/octeontx.rst b/doc/guides/platform/octeontx.rst
index b01f51ba4d..f266f81f4e 100644
--- a/doc/guides/platform/octeontx.rst
+++ b/doc/guides/platform/octeontx.rst
@@ -16,15 +16,15 @@ Common Offload HW Block Drivers
 -------------------------------
 
 #. **Crypto Driver**
-   See :doc:`../cryptodevs/octeontx` for octeontx crypto driver
+   See :doc:`/cryptodevs/octeontx` for octeontx crypto driver
    information.
 
 #. **Eventdev Driver**
-   See :doc:`../eventdevs/octeontx` for octeontx ssovf eventdev driver
+   See :doc:`/eventdevs/octeontx` for octeontx ssovf eventdev driver
    information.
 
 #. **Mempool Driver**
-   See :doc:`../mempool/octeontx` for octeontx fpavf mempool driver
+   See :doc:`/mempool/octeontx` for octeontx fpavf mempool driver
    information.
 
 Steps To Setup Platform
@@ -60,7 +60,7 @@ OCTEON TX compatible board:
    as part of SDK from Cavium. The SDK includes all the above prerequisites necessary
    to bring up a OCTEON TX board. Please refer :ref:`setup_platform_using_OCTEON_TX_SDK`.
 
-#. Follow the DPDK :doc:`../linux_gsg/index` to setup the basic DPDK environment.
+#. Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 .. _setup_platform_using_OCTEON_TX_SDK:
 
@@ -111,7 +111,7 @@ The DPDK applications can be cross-compiled on any x86 based platform. The
 OCTEON TX SDK need to be installed on the build system. The SDK package will
 provide the required toolchain etc.
 
-Refer to :doc:`../linux_gsg/cross_build_dpdk_for_arm64` for generic arm64 details.
+Refer to :doc:`/linux_gsg/cross_build_dpdk_for_arm64` for generic arm64 details.
 
 The following steps can be used to perform cross-compilation with OCTEON TX
 SDK 6.2.0 patch 3:
diff --git a/doc/guides/prog_guide/build-sdk-meson.rst b/doc/guides/prog_guide/build-sdk-meson.rst
index 74465d52c3..c54729701f 100644
--- a/doc/guides/prog_guide/build-sdk-meson.rst
+++ b/doc/guides/prog_guide/build-sdk-meson.rst
@@ -48,9 +48,9 @@ https://ninja-build.org/
 
 It is best advised to go over the following links for the complete dependencies:
 
-* :doc:`Linux <../linux_gsg/sys_reqs>`
-* :doc:`FreeBSD <../freebsd_gsg/build_dpdk>`
-* :doc:`Windows <../windows_gsg/build_dpdk>`
+* :doc:`Linux </linux_gsg/sys_reqs>`
+* :doc:`FreeBSD </freebsd_gsg/build_dpdk>`
+* :doc:`Windows </windows_gsg/build_dpdk>`
 
 
 Configuring the Build
diff --git a/doc/guides/prog_guide/build_app.rst b/doc/guides/prog_guide/build_app.rst
index 855897c5aa..56a8a1e3fd 100644
--- a/doc/guides/prog_guide/build_app.rst
+++ b/doc/guides/prog_guide/build_app.rst
@@ -21,7 +21,7 @@ The binary is generated in the build directory by default:
     ~/DPDK/examples/helloworld$ ls build/app
     helloworld helloworld.map
 
-Please refer to :doc:`../linux_gsg/build_dpdk` for details on compiling with meson.
+Please refer to :doc:`/linux_gsg/build_dpdk` for details on compiling with meson.
 
 Build Your Own Application Outside the Development Kit
 ------------------------------------------------------
diff --git a/doc/guides/prog_guide/cmdline.rst b/doc/guides/prog_guide/cmdline.rst
index e20281ceb5..12da665f39 100644
--- a/doc/guides/prog_guide/cmdline.rst
+++ b/doc/guides/prog_guide/cmdline.rst
@@ -208,7 +208,7 @@ Those two commands will be:
 .. note::
 
    For further examples of use of the command-line, see
-   :doc:`cmdline example application <../sample_app_ug/cmd_line>`
+   :doc:`cmdline example application </sample_app_ug/cmd_line>`
 
 Defining Command Result Structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/prog_guide/cryptodev_lib.rst b/doc/guides/prog_guide/cryptodev_lib.rst
index 817d39dd62..ef4c25dd93 100644
--- a/doc/guides/prog_guide/cryptodev_lib.rst
+++ b/doc/guides/prog_guide/cryptodev_lib.rst
@@ -10,7 +10,7 @@ APIs which support a number of different Crypto operations. The framework
 currently only supports cipher, authentication, chained cipher/authentication
 and AEAD symmetric and asymmetric Crypto operations.
 
-The usages in security protocols are discussed in the :doc:`../howto/security` guide.
+The usages in security protocols are discussed in the :doc:`/howto/security` guide.
 
 Design Principles
 -----------------
@@ -1127,4 +1127,4 @@ are shown below.
      capabilities>], "crypto_caps_n": <number of capabilities>}}
 
 For more information on how to use the Telemetry interface, see
-the :doc:`../howto/telemetry`.
+the :doc:`/howto/telemetry`.
diff --git a/doc/guides/prog_guide/devargs.rst b/doc/guides/prog_guide/devargs.rst
index e4076e0e33..c8a7224aa0 100644
--- a/doc/guides/prog_guide/devargs.rst
+++ b/doc/guides/prog_guide/devargs.rst
@@ -183,7 +183,7 @@ Devargs can be specified on the command line when starting a DPDK application:
 
    ./myapp --vdev net_ring0 --vdev 'net_pcap0,rx_pcap=input.pcap'
 
-See :doc:`../linux_gsg/linux_eal_parameters` for complete EAL parameter documentation.
+See :doc:`/linux_gsg/linux_eal_parameters` for complete EAL parameter documentation.
 
 
 At Runtime (Hotplug)
diff --git a/doc/guides/prog_guide/dmadev.rst b/doc/guides/prog_guide/dmadev.rst
index 98f88ad8eb..e0ac3c9542 100644
--- a/doc/guides/prog_guide/dmadev.rst
+++ b/doc/guides/prog_guide/dmadev.rst
@@ -171,7 +171,7 @@ are shown below.
      {"/dmadev/stats": {"submitted": 0, "completed": 0, "errors": 0}}
 
 For more information on how to use the Telemetry interface, see
-the :doc:`../howto/telemetry`.
+the :doc:`/howto/telemetry`.
 
 
 Inter-domain DMA Transfers
diff --git a/doc/guides/prog_guide/power_man.rst b/doc/guides/prog_guide/power_man.rst
index 915d9da3fd..61d5b77069 100644
--- a/doc/guides/prog_guide/power_man.rst
+++ b/doc/guides/prog_guide/power_man.rst
@@ -179,7 +179,7 @@ The "monitor" mode is only supported in the following configurations and scenari
 
 * Not all Ethernet drivers support monitoring, even if the underlying
   platform may support the necessary CPU instructions. Please refer to
-  :doc:`../nics/overview` for more information.
+  :doc:`/nics/overview` for more information.
 
 
 API Overview for Ethernet PMD Power Management
diff --git a/doc/guides/prog_guide/profile_app.rst b/doc/guides/prog_guide/profile_app.rst
index 2f47680d5d..7fc48919fd 100644
--- a/doc/guides/prog_guide/profile_app.rst
+++ b/doc/guides/prog_guide/profile_app.rst
@@ -129,7 +129,7 @@ an ARMv8 machine.
     make
     sudo insmod pmu_el0_cycle_counter.ko
 
-Please refer to :doc:`../linux_gsg/build_dpdk` for generic details on compiling DPDK with meson.
+Please refer to :doc:`/linux_gsg/build_dpdk` for generic details on compiling DPDK with meson.
 
 In order to enable ``PMU`` based ``rte_rdtsc()``, user needs to configure the
 build with ``-Dc_args='-DRTE_ARM_EAL_RDTSC_USE_PMU'``.
diff --git a/doc/guides/prog_guide/rte_security.rst b/doc/guides/prog_guide/rte_security.rst
index 7bd9691080..ad9c1e4f16 100644
--- a/doc/guides/prog_guide/rte_security.rst
+++ b/doc/guides/prog_guide/rte_security.rst
@@ -10,7 +10,7 @@ library defines generic APIs to create and free security sessions which can
 support full protocol offload as well as inline crypto operation with
 NIC or crypto devices.
 
-The security protocols are discussed in the :doc:`../howto/security` guide.
+The security protocols are discussed in the :doc:`/howto/security` guide.
 
 Design Principles
 -----------------
@@ -884,4 +884,4 @@ are shown below.
 	 capabilities>], "crypto_caps_n": <number of capabilities>}}
 
 For more information on how to use the Telemetry interface, see
-the :doc:`../howto/telemetry`.
+the :doc:`/howto/telemetry`.
diff --git a/doc/guides/prog_guide/source_org.rst b/doc/guides/prog_guide/source_org.rst
index 3d5f7f3bdd..49682d4249 100644
--- a/doc/guides/prog_guide/source_org.rst
+++ b/doc/guides/prog_guide/source_org.rst
@@ -40,4 +40,4 @@ They are located in the ``dpdk/app`` and ``dpdk/examples`` directories.
 The app directory contains sample applications that are used to test DPDK (such as autotests)
 or the Poll Mode Drivers (test-pmd).
 
-The examples directory contains :doc:`Sample applications<../sample_app_ug/index>` that show how libraries can be used.
+The examples directory contains :doc:`Sample applications </sample_app_ug/index>` that show how libraries can be used.
diff --git a/doc/guides/prog_guide/telemetry_lib.rst b/doc/guides/prog_guide/telemetry_lib.rst
index b0529aa580..a693021f0e 100644
--- a/doc/guides/prog_guide/telemetry_lib.rst
+++ b/doc/guides/prog_guide/telemetry_lib.rst
@@ -168,4 +168,4 @@ Using Commands
 
 To use commands, with a DPDK app running (e.g. testpmd), use the
 ``dpdk-telemetry.py`` script.
-For details on its use, see the :doc:`../howto/telemetry`.
+For details on its use, see the :doc:`/howto/telemetry`.
diff --git a/doc/guides/prog_guide/trace_lib.rst b/doc/guides/prog_guide/trace_lib.rst
index 6cf8e21641..3ca1a2e8bd 100644
--- a/doc/guides/prog_guide/trace_lib.rst
+++ b/doc/guides/prog_guide/trace_lib.rst
@@ -164,7 +164,7 @@ the trace buffers to the filesystem. By default, the trace files are stored in
 It can be overridden by the ``--trace-dir=<directory path>`` EAL command line
 option.
 
-For more information, refer to :doc:`../linux_gsg/linux_eal_parameters` for
+For more information, refer to :doc:`/linux_gsg/linux_eal_parameters` for
 trace EAL command line options.
 
 View and analyze the recorded events
diff --git a/doc/guides/rawdevs/dpaa2_cmdif.rst b/doc/guides/rawdevs/dpaa2_cmdif.rst
index 4eed661c8e..0da0be0638 100644
--- a/doc/guides/rawdevs/dpaa2_cmdif.rst
+++ b/doc/guides/rawdevs/dpaa2_cmdif.rst
@@ -29,7 +29,7 @@ Supported DPAA2 SoCs
 Prerequisites
 -------------
 
-See :doc:`../platform/dpaa2` for setup information
+See :doc:`/platform/dpaa2` for setup information
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
 
diff --git a/doc/guides/regexdevs/cn9k.rst b/doc/guides/regexdevs/cn9k.rst
index fe117e0e25..773dce59f7 100644
--- a/doc/guides/regexdevs/cn9k.rst
+++ b/doc/guides/regexdevs/cn9k.rst
@@ -22,7 +22,7 @@ Features of the CN9K REE PMD are:
 Prerequisites and Compilation procedure
 ---------------------------------------
 
-   See :doc:`../platform/cnxk` for setup information.
+   See :doc:`/platform/cnxk` for setup information.
 
 Device Setup
 ------------
diff --git a/doc/guides/regexdevs/mlx5.rst b/doc/guides/regexdevs/mlx5.rst
index be45b54147..4094eb9a79 100644
--- a/doc/guides/regexdevs/mlx5.rst
+++ b/doc/guides/regexdevs/mlx5.rst
@@ -16,7 +16,7 @@ This PMD is configuring the RegEx HW engine.
 For the PMD to work, the application must supply
 a precompiled rule file in rof2 format.
 
-See :doc:`../../platform/mlx5` guide for more design details.
+See :doc:`/platform/mlx5` guide for more design details.
 
 Features
 --------
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index f5c12cc747..b74215341f 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -4,8 +4,8 @@
 ABI and API Deprecation
 =======================
 
-See the guidelines document for details of the :doc:`ABI policy
-<../contributing/abi_policy>`.
+See the guidelines document for details
+of the :doc:`ABI policy </contributing/abi_policy>`.
 
 With DPDK 23.11, there will be a new major ABI version: 24.
 This means that during the development of 23.11,
diff --git a/doc/guides/rel_notes/release_17_02.rst b/doc/guides/rel_notes/release_17_02.rst
index 929ba770ae..5ae8c5fae6 100644
--- a/doc/guides/rel_notes/release_17_02.rst
+++ b/doc/guides/rel_notes/release_17_02.rst
@@ -43,7 +43,7 @@ New Features
   higher-level than the legacy filtering framework, which it encompasses and
   supersedes (including all functions and filter types) .
 
-  See the :doc:`../prog_guide/ethdev/flow_offload` documentation for more information.
+  See the :doc:`/prog_guide/ethdev/flow_offload` documentation for more information.
 
 * **Added firmware version get API.**
 
@@ -215,7 +215,7 @@ New Features
   therefore, it can better fit in CPU cache and scale to millions of flow
   keys.
 
-  See the :doc:`../prog_guide/efd_lib` documentation in
+  See the :doc:`/prog_guide/efd_lib` documentation in
   the Programmers Guide document, for more information.
 
 
diff --git a/doc/guides/rel_notes/release_17_11.rst b/doc/guides/rel_notes/release_17_11.rst
index 9ecf38c9d5..5942135a98 100644
--- a/doc/guides/rel_notes/release_17_11.rst
+++ b/doc/guides/rel_notes/release_17_11.rst
@@ -22,7 +22,7 @@ New Features
 * **Added a new driver for Marvell Armada 7k/8k devices.**
 
   Added the new ``mrvl`` net driver for Marvell Armada 7k/8k devices. See the
-  :doc:`../nics/mvpp2` NIC guide for more details on this new driver.
+  :doc:`/nics/mvpp2` NIC guide for more details on this new driver.
 
 * **Updated mlx4 driver.**
 
@@ -77,7 +77,7 @@ New Features
   * DPAA Mempool driver for supporting offloaded packet memory pool
   * DPAA PMD for DPAA devices
 
-  See the :doc:`../nics/dpaa` document for more details of this new driver.
+  See the :doc:`/nics/dpaa` document for more details of this new driver.
 
 * **Updated support for Cavium OCTEONTX Device.**
 
@@ -87,7 +87,7 @@ New Features
   * OCTEONTX Ethdev PMD
   * OCTEONTX Eventdev-Ethdev Rx adapter
 
-  See the :doc:`../nics/octeontx` document for more details of this new driver.
+  See the :doc:`/nics/octeontx` document for more details of this new driver.
 
 * **Added PF support to the Netronome NFP PMD.**
 
@@ -132,7 +132,7 @@ New Features
   * The DES DOCSIS BPI algorithm.
 
   This change requires version 0.47 of the IPsec Multi-buffer library. For
-  more details see the :doc:`../cryptodevs/aesni_mb` documentation.
+  more details see the :doc:`/cryptodevs/aesni_mb` documentation.
 
 * **Updated the OpenSSL PMD.**
 
@@ -144,13 +144,13 @@ New Features
 * **Added NXP DPAA SEC crypto PMD.**
 
   A new ``dpaa_sec`` hardware based crypto PMD for NXP DPAA devices has been
-  added. See the :doc:`../cryptodevs/dpaa_sec` document for more details.
+  added. See the :doc:`/cryptodevs/dpaa_sec` document for more details.
 
 * **Added MRVL crypto PMD.**
 
   A new crypto PMD has been added, which provides several ciphering and hashing
   algorithms. All cryptography operations use the MUSDK library crypto API.
-  See the :doc:`../cryptodevs/mvsam` document for more details.
+  See the :doc:`/cryptodevs/mvsam` document for more details.
 
 * **Add new benchmarking mode to dpdk-test-crypto-perf application.**
 
@@ -164,7 +164,7 @@ New Features
   for protocols like IPsec using inline ipsec offload to ethernet devices or
   full protocol offload with lookaside crypto devices.
 
-  See the :doc:`../prog_guide/rte_security` section of the DPDK Programmers
+  See the :doc:`/prog_guide/rte_security` section of the DPDK Programmers
   Guide document for more information.
 
 * **Updated the DPAA2_SEC crypto driver to support rte_security.**
@@ -227,7 +227,7 @@ New Features
   return not only whether the element has been inserted in one of the sets but
   also which set it belongs to.
 
-  See the :doc:`../prog_guide/member_lib` documentation in the Programmers
+  See the :doc:`/prog_guide/member_lib` documentation in the Programmers
   Guide, for more information.
 
 * **Added the Generic Segmentation Offload Library.**
diff --git a/doc/guides/rel_notes/release_18_02.rst b/doc/guides/rel_notes/release_18_02.rst
index af437e4153..691fbdf023 100644
--- a/doc/guides/rel_notes/release_18_02.rst
+++ b/doc/guides/rel_notes/release_18_02.rst
@@ -132,7 +132,7 @@ New Features
   The current release only supports 3GPP CRC, Turbo Coding and Rate
   Matching operations, as specified in 3GPP TS 36.212.
 
-  See the :doc:`../prog_guide/bbdev` programmer's guide for more details.
+  See the :doc:`/prog_guide/bbdev` programmer's guide for more details.
 
 * **Added New eventdev Ordered Packet Distribution Library (OPDL) PMD.**
 
@@ -175,7 +175,7 @@ New Features
   structures/buffers. Also, southbound APIs provide a means of integrating devices
   either as part of a physical bus (PCI, FSLMC etc) or through ``vdev``.
 
-  See the :doc:`../prog_guide/rawdev` programmer's guide for more details.
+  See the :doc:`/prog_guide/rawdev` programmer's guide for more details.
 
 * **Added new multi-process communication channel.**
 
diff --git a/doc/guides/rel_notes/release_18_05.rst b/doc/guides/rel_notes/release_18_05.rst
index 77b378c7c0..6b063e154a 100644
--- a/doc/guides/rel_notes/release_18_05.rst
+++ b/doc/guides/rel_notes/release_18_05.rst
@@ -124,7 +124,7 @@ New Features
 * **Added Ethernet poll mode driver for AMD XGBE devices.**
 
   Added the new ``axgbe`` ethernet poll mode driver for AMD XGBE devices.
-  See the :doc:`../nics/axgbe` nic driver guide for more details on this
+  See the :doc:`/nics/axgbe` nic driver guide for more details on this
   new driver.
 
 * **Updated szedata2 PMD.**
@@ -186,13 +186,13 @@ New Features
 
   Added a new Poll Mode Driver for virtio crypto devices, which provides
   AES-CBC ciphering and AES-CBC with HMAC-SHA1 algorithm-chaining. See the
-  :doc:`../cryptodevs/virtio` crypto driver guide for more details on
+  :doc:`/cryptodevs/virtio` crypto driver guide for more details on
   this new driver.
 
 * **Added AMD CCP Crypto PMD.**
 
   Added the new ``ccp`` crypto driver for AMD CCP devices. See the
-  :doc:`../cryptodevs/ccp` crypto driver guide for more details on
+  :doc:`/cryptodevs/ccp` crypto driver guide for more details on
   this new driver.
 
 * **Updated AESNI MB PMD.**
@@ -209,7 +209,7 @@ New Features
 * **Added a new compression poll mode driver using Intels ISA-L.**
 
    Added the new ``ISA-L`` compression driver, for compression and decompression
-   operations in software. See the :doc:`../compressdevs/isal` compression driver
+   operations in software. See the :doc:`/compressdevs/isal` compression driver
    guide for details on this new driver.
 
 * **Added the Event Timer Adapter Library.**
@@ -224,7 +224,7 @@ New Features
   The OcteonTx Timer block enables software to schedule events for a future
   time, it is exposed to an application via the Event timer adapter library.
 
-  See the :doc:`../eventdevs/octeontx` guide for more details
+  See the :doc:`/eventdevs/octeontx` guide for more details
 
 * **Added Event Crypto Adapter Library.**
 
@@ -245,7 +245,7 @@ New Features
   with OPAE (Open Programmable Acceleration Engine) shared code to provide common FPGA
   management ops for FPGA operation.
 
-  See the :doc:`../rawdevs/ifpga` programmer's guide for more details.
+  See the :doc:`/rawdevs/ifpga` programmer's guide for more details.
 
 * **Added DPAA2 QDMA Driver (in rawdev).**
 
@@ -264,7 +264,7 @@ New Features
   between GPP and AIOP is achieved via using DPCI devices exposed by MC for
   GPP <--> AIOP interaction.
 
-  See the :doc:`../rawdevs/dpaa2_cmdif` guide for more details.
+  See the :doc:`/rawdevs/dpaa2_cmdif` guide for more details.
 
 * **Added device event monitor framework.**
 
diff --git a/doc/guides/rel_notes/release_18_08.rst b/doc/guides/rel_notes/release_18_08.rst
index 314723f1e0..6ca1c77a25 100644
--- a/doc/guides/rel_notes/release_18_08.rst
+++ b/doc/guides/rel_notes/release_18_08.rst
@@ -10,7 +10,7 @@ New Features
 * **Added support for Hyper-V netvsc PMD.**
 
   The new ``netvsc`` poll mode driver provides native support for
-  networking on Hyper-V. See the :doc:`../nics/netvsc` NIC driver guide
+  networking on Hyper-V. See the :doc:`/nics/netvsc` NIC driver guide
   for more details on this new driver.
 
 * **Added Flow API support for CXGBE PMD.**
@@ -73,7 +73,7 @@ New Features
 * **Added a new compression PMD using Intel's QuickAssist (QAT) device family.**
 
   Added the new ``QAT`` compression driver, for compression and decompression
-  operations in software. See the :doc:`../compressdevs/qat_comp` compression
+  operations in software. See the :doc:`/compressdevs/qat_comp` compression
   driver guide for details on this new driver.
 
 * **Updated the ISA-L PMD.**
diff --git a/doc/guides/rel_notes/release_18_11.rst b/doc/guides/rel_notes/release_18_11.rst
index 708bc9d4dd..8ddbf697a4 100644
--- a/doc/guides/rel_notes/release_18_11.rst
+++ b/doc/guides/rel_notes/release_18_11.rst
@@ -86,17 +86,17 @@ New Features
 * **Added a new net driver for Marvell Armada 3k device.**
 
   Added the new ``mvneta`` net driver for Marvell Armada 3k device. See the
-  :doc:`../nics/mvneta` NIC guide for more details on this new driver.
+  :doc:`/nics/mvneta` NIC guide for more details on this new driver.
 
 * **Added NXP ENETC PMD.**
 
   Added the new enetc driver for the NXP enetc platform. See the
-  :doc:`../nics/enetc` NIC driver guide for more details on this new driver.
+  :doc:`/nics/enetc` NIC driver guide for more details on this new driver.
 
 * **Added Ethernet poll mode driver for Aquantia aQtion family of 10G devices.**
 
   Added the new ``atlantic`` ethernet poll mode driver for Aquantia XGBE devices.
-  See the :doc:`../nics/atlantic` NIC driver guide for more details on this
+  See the :doc:`/nics/atlantic` NIC driver guide for more details on this
   driver.
 
 * **Updated mlx5 driver.**
@@ -185,7 +185,7 @@ New Features
 * **Added NXP CAAM JR PMD.**
 
   Added the new caam job ring driver for NXP platforms. See the
-  :doc:`../cryptodevs/caam_jr` guide for more details on this new driver.
+  :doc:`/cryptodevs/caam_jr` guide for more details on this new driver.
 
 * **Added support for GEN3 devices to Intel QAT driver.**
 
@@ -239,7 +239,7 @@ New Features
   executed per core and uses the number of empty polls as a hint for system
   power management.
 
-  See the :doc:`../prog_guide/power_man` section of the DPDK Programmers
+  See the :doc:`/prog_guide/power_man` section of the DPDK Programmers
   Guide document for more information.
 
 * **Added JSON power policy interface for containers.**
diff --git a/doc/guides/rel_notes/release_19_02.rst b/doc/guides/rel_notes/release_19_02.rst
index e2b8200739..3aa91e84e3 100644
--- a/doc/guides/rel_notes/release_19_02.rst
+++ b/doc/guides/rel_notes/release_19_02.rst
@@ -82,7 +82,7 @@ New Features
 * **Added ICE net PMD.**
 
   Added the new ``ice`` net driver for Intel(R) Ethernet Network Adapters E810.
-  See the :doc:`../nics/ice` NIC guide for more details on this new driver.
+  See the :doc:`/nics/ice` NIC guide for more details on this new driver.
 
 * **Added support for SW-assisted VDPA live migration.**
 
@@ -112,7 +112,7 @@ New Features
   algorithm-chaining, and AES-GCM and NULL algorithms only at present. It is
   planned to add more algorithms in future releases.
 
-  See :doc:`../prog_guide/ipsec_lib` for more information.
+  See :doc:`/prog_guide/ipsec_lib` for more information.
 
 * **Updated the ipsec-secgw sample application.**
 
@@ -126,7 +126,7 @@ New Features
   ipsec-secgw application. It is planned to add the outstanding functionality
   in future releases.
 
-  See :doc:`../sample_app_ug/ipsec_secgw` for more information.
+  See :doc:`/sample_app_ug/ipsec_secgw` for more information.
 
 * **Enabled checksum support in the ISA-L compressdev driver.**
 
diff --git a/doc/guides/rel_notes/release_19_05.rst b/doc/guides/rel_notes/release_19_05.rst
index 89ae425bdb..1a852753ab 100644
--- a/doc/guides/rel_notes/release_19_05.rst
+++ b/doc/guides/rel_notes/release_19_05.rst
@@ -60,12 +60,12 @@ New Features
 * **Added a net PMD NFB.**
 
   Added the new ``nfb`` net driver for Netcope NFB cards. See
-  the :doc:`../nics/nfb` NIC guide for more details on this new driver.
+  the :doc:`/nics/nfb` NIC guide for more details on this new driver.
 
 * **Added IPN3KE net PMD.**
 
   Added the new ``ipn3ke`` net driver for the Intel® FPGA PAC (Programmable
-  Acceleration Card) N3000. See the :doc:`../nics/ipn3ke` NIC guide for more
+  Acceleration Card) N3000. See the :doc:`/nics/ipn3ke` NIC guide for more
   details on this new driver.
 
   In addition ``ifpga_rawdev`` was also updated to support Intel® FPGA PAC
diff --git a/doc/guides/rel_notes/release_19_08.rst b/doc/guides/rel_notes/release_19_08.rst
index 31fcebdf95..08aeb0f485 100644
--- a/doc/guides/rel_notes/release_19_08.rst
+++ b/doc/guides/rel_notes/release_19_08.rst
@@ -54,7 +54,7 @@ New Features
 
   Added the new ``hinic`` net driver for Huawei Intelligent PCIE Network
   Adapters based on the Huawei Ethernet Controller Hi1822.
-  See the :doc:`../nics/hinic` guide for more details on this new driver.
+  See the :doc:`/nics/hinic` guide for more details on this new driver.
 
 * **Updated the Intel ice driver.**
 
@@ -93,7 +93,7 @@ New Features
 * **Added memif PMD.**
 
   Added a new Shared Memory Packet Interface (``memif``) PMD.
-  See the :doc:`../nics/memif` guide for more details on this new driver.
+  See the :doc:`/nics/memif` guide for more details on this new driver.
 
 * **Updated the AF_XDP PMD.**
 
@@ -122,7 +122,7 @@ New Features
 
   Added a new ``fpga_lte_fec`` bbdev driver for the Intel\ |reg| FPGA PAC
   (Programmable  Acceleration Card) N3000.  See the
-  :doc:`../bbdevs/fpga_lte_fec` BBDEV guide for more details on this new driver.
+  :doc:`/bbdevs/fpga_lte_fec` BBDEV guide for more details on this new driver.
 
 * **Updated the TURBO_SW bbdev PMD.**
 
diff --git a/doc/guides/rel_notes/release_19_11.rst b/doc/guides/rel_notes/release_19_11.rst
index 79f3475ae6..dc5c84b5a8 100644
--- a/doc/guides/rel_notes/release_19_11.rst
+++ b/doc/guides/rel_notes/release_19_11.rst
@@ -81,12 +81,12 @@ New Features
 
   Added the new ``hns3`` net driver for the inbuilt Hisilicon Network
   Subsystem 3 (HNS3) network engine found in the Hisilicon Kunpeng 920 SoC.
-  See the :doc:`../nics/hns3` guide for more details on this new driver.
+  See the :doc:`/nics/hns3` guide for more details on this new driver.
 
 * **Added NXP PFE PMD.**
 
   Added the new PFE driver for the NXP LS1012A platform. See the
-  :doc:`../nics/pfe` NIC driver guide for more details on this new driver.
+  :doc:`/nics/pfe` NIC driver guide for more details on this new driver.
 
 * **Updated Broadcom bnxt driver.**
 
@@ -180,7 +180,7 @@ New Features
 * **Added Marvell NITROX symmetric crypto PMD.**
 
   Added a symmetric crypto PMD for Marvell NITROX V security processor.
-  See the :doc:`../cryptodevs/nitrox` guide for more details on this new PMD.
+  See the :doc:`/cryptodevs/nitrox` guide for more details on this new PMD.
 
 * **Added asymmetric support to Marvell OCTEON TX crypto PMD.**
 
@@ -281,7 +281,7 @@ New Features
   compilers store their internal representation of the source code that
   the linker uses at the final stage of the compilation process.
 
-  See :doc:`../prog_guide/lto` for more information:
+  See :doc:`/prog_guide/lto` for more information:
 
 * **Added IOVA as VA support for KNI.**
 
@@ -301,8 +301,8 @@ Removed Items
 
 * Removed library-level ABI versions. These have been replaced with a single
   project-level ABI version for non-experimental libraries and an ABI version of
-  ``0`` for experimental libraries. Review the :doc:`../contributing/abi_policy`
-  and :doc:`../contributing/abi_versioning` guides for more information.
+  ``0`` for experimental libraries. Review the :doc:`/contributing/abi_policy`
+  and :doc:`/contributing/abi_versioning` guides for more information.
 
 * Removed duplicated set of commands for Rx offload configuration from testpmd::
 
@@ -418,7 +418,7 @@ API Changes
 ABI Changes
 -----------
 
-* policy: Please note the revisions to the :doc:`../contributing/abi_policy`
+* policy: Please note the revisions to the :doc:`/contributing/abi_policy`
   introducing major ABI versions, with DPDK 19.11 becoming the first major
   version ``v20``. ABI changes to add new features continue to be permitted in
   subsequent releases, with the condition that ABI compatibility with the major
diff --git a/doc/guides/rel_notes/release_20_02.rst b/doc/guides/rel_notes/release_20_02.rst
index 461ab16286..3eb58c132a 100644
--- a/doc/guides/rel_notes/release_20_02.rst
+++ b/doc/guides/rel_notes/release_20_02.rst
@@ -34,7 +34,7 @@ New Features
 * **Added IONIC net PMD.**
 
   Added the new ``ionic`` net driver for Pensando Ethernet Network Adapters.
-  See the :doc:`../nics/ionic` NIC guide for more details on this new driver.
+  See the :doc:`/nics/ionic` NIC guide for more details on this new driver.
 
 * **Updated Broadcom bnxt driver.**
 
@@ -104,7 +104,7 @@ New Features
 * **Add new vDPA PMD based on Mellanox devices.**
 
   Added a new Mellanox vDPA  (``mlx5_vdpa``) PMD.
-  See the :doc:`../vdpadevs/mlx5` guide for more details on this driver.
+  See the :doc:`/vdpadevs/mlx5` guide for more details on this driver.
 
 * **Added support for virtio-PMD notification data.**
 
diff --git a/doc/guides/rel_notes/release_20_05.rst b/doc/guides/rel_notes/release_20_05.rst
index a38c6c673d..b7fb077401 100644
--- a/doc/guides/rel_notes/release_20_05.rst
+++ b/doc/guides/rel_notes/release_20_05.rst
@@ -91,7 +91,7 @@ New Features
 * **Added a new driver for Intel Foxville I225 devices.**
 
   Added the new ``igc`` net driver for Intel Foxville I225 devices. See the
-  :doc:`../nics/igc` NIC guide for more details on this new driver.
+  :doc:`/nics/igc` NIC guide for more details on this new driver.
 
 * **Updated Intel i40e driver.**
 
@@ -211,7 +211,7 @@ New Features
 
   Added a new ``fpga_5gnr_fec`` bbdev driver for the Intel\ |reg| FPGA PAC
   (Programmable  Acceleration Card) N3000.  See the
-  :doc:`../bbdevs/fpga_5gnr_fec` BBDEV guide for more details on this new driver.
+  :doc:`/bbdevs/fpga_5gnr_fec` BBDEV guide for more details on this new driver.
 
 * **Updated the DSW event device.**
 
diff --git a/doc/guides/rel_notes/release_20_08.rst b/doc/guides/rel_notes/release_20_08.rst
index 619c3dd59f..36163249d5 100644
--- a/doc/guides/rel_notes/release_20_08.rst
+++ b/doc/guides/rel_notes/release_20_08.rst
@@ -216,14 +216,14 @@ New Features
 
   Added new command line option ``--portmap="(port, port)[,(port, port)]"`` to
   pass forwarding port details.
-  See the :doc:`../sample_app_ug/l2_forward_real_virtual` for more
+  See the :doc:`/sample_app_ug/l2_forward_real_virtual` for more
   details of this parameter usage.
 
 * **Updated ipsec-secgw sample application.**
 
   Added ``rte_flow`` based rules, which allows hardware parsing and steering
   of ingress packets to specific NIC queues.
-  See the :doc:`../sample_app_ug/ipsec_secgw` for more details.
+  See the :doc:`/sample_app_ug/ipsec_secgw` for more details.
 
 
 Removed Items
diff --git a/doc/guides/rel_notes/release_20_11.rst b/doc/guides/rel_notes/release_20_11.rst
index 76fd7372b8..fd454f3e4f 100644
--- a/doc/guides/rel_notes/release_20_11.rst
+++ b/doc/guides/rel_notes/release_20_11.rst
@@ -194,7 +194,7 @@ New Features
 
   Added a new PMD for Wangxun 10 Gigabit Ethernet NICs.
 
-  See the :doc:`../nics/txgbe` for more details.
+  See the :doc:`/nics/txgbe` for more details.
 
 * **Updated Virtio driver.**
 
@@ -252,7 +252,7 @@ New Features
 * **Added Broadcom BCMFS symmetric crypto PMD.**
 
   Added a symmetric crypto PMD for Broadcom FlexSparc crypto units.
-  See :doc:`../cryptodevs/bcmfs` guide for more details on this new PMD.
+  See :doc:`/cryptodevs/bcmfs` guide for more details on this new PMD.
 
 * **Updated NXP DPAA2_SEC crypto PMD.**
 
@@ -279,7 +279,7 @@ New Features
 
   Added a new ``acc100`` bbdev driver for the Intel\ |reg| ACC100 accelerator
   also known as Mount Bryce.  See the
-  :doc:`../bbdevs/acc100` BBDEV guide for more details on this new driver.
+  :doc:`/bbdevs/acc100` BBDEV guide for more details on this new driver.
 
 * **Updated rte_security library to support SDAP.**
 
@@ -304,7 +304,7 @@ New Features
 * **Added a new driver for the Intel Dynamic Load Balancer v2.0 device.**
 
   Added the new ``dlb2`` eventdev driver for the Intel DLB V2.0 device. See the
-  :doc:`../eventdevs/dlb2` eventdev guide for more details on this new driver.
+  :doc:`/eventdevs/dlb2` eventdev guide for more details on this new driver.
 
 * **Added Ice Lake (Gen4) support for Intel NTB.**
 
@@ -380,7 +380,7 @@ New Features
 
   Added vhost asynchronous APIs support, which demonstrates how the application
   can leverage IOAT DMA channels with vhost asynchronous APIs.
-  See the :doc:`../sample_app_ug/vhost` for more details.
+  See the :doc:`/sample_app_ug/vhost` for more details.
 
 
 Removed Items
diff --git a/doc/guides/rel_notes/release_21_02.rst b/doc/guides/rel_notes/release_21_02.rst
index b47593b214..ffa52bd580 100644
--- a/doc/guides/rel_notes/release_21_02.rst
+++ b/doc/guides/rel_notes/release_21_02.rst
@@ -137,13 +137,13 @@ New Features
 
   Added a new compress PMD for BlueField-2 adapters.
 
-  See the :doc:`../compressdevs/mlx5` for more details.
+  See the :doc:`/compressdevs/mlx5` for more details.
 
 * **Added python script to run crypto perf tests and graph the results.**
 
   A new Python script has been added to automate running crypto performance
   tests and output graphed results to PDF files.
-  See the :doc:`../tools/cryptoperf` guide for more details.
+  See the :doc:`/tools/cryptoperf` guide for more details.
 
 * **Added Windows support to pmdinfogen.**
 
diff --git a/doc/guides/rel_notes/release_21_08.rst b/doc/guides/rel_notes/release_21_08.rst
index 369452b40b..08d0eca2fc 100644
--- a/doc/guides/rel_notes/release_21_08.rst
+++ b/doc/guides/rel_notes/release_21_08.rst
@@ -68,7 +68,7 @@ New Features
 * **Added Wangxun ngbe PMD.**
 
   Added a new PMD for Wangxun 1Gb Ethernet NICs.
-  See the :doc:`../nics/ngbe` for more details.
+  See the :doc:`/nics/ngbe` for more details.
 
 * **Added inflight packets clear API in vhost library.**
 
@@ -107,7 +107,7 @@ New Features
   Added Baseband PHY PMD which allows configuration of the BPHY hardware block
   comprising accelerators and DSPs specifically tailored for 5G/LTE inline
   use cases. Configuration happens via standard rawdev enq/deq operations. See
-  the :doc:`../rawdevs/cnxk_bphy` rawdev guide for more details on this driver.
+  the :doc:`/rawdevs/cnxk_bphy` rawdev guide for more details on this driver.
 
 * **Added support for Marvell CN10K, CN9K, event Rx/Tx adapter.**
 
diff --git a/doc/guides/rel_notes/release_21_11.rst b/doc/guides/rel_notes/release_21_11.rst
index b9df58734b..144e9b2ab3 100644
--- a/doc/guides/rel_notes/release_21_11.rst
+++ b/doc/guides/rel_notes/release_21_11.rst
@@ -199,7 +199,7 @@ New Features
 * **Added NXP ENETFEC PMD [EXPERIMENTAL].**
 
   Added the new ENETFEC driver for the NXP IMX8MMEVK platform. See the
-  :doc:`../nics/enetfec` NIC driver guide for more details on this new driver.
+  :doc:`/nics/enetfec` NIC driver guide for more details on this new driver.
 
 * **Updated Solarflare network PMD.**
 
@@ -240,7 +240,7 @@ New Features
 * **Added new vDPA PMD based on Xilinx devices.**
 
   Added a new Xilinx vDPA  (``sfc_vdpa``) PMD.
-  See the :doc:`../vdpadevs/sfc` guide for more details on this driver.
+  See the :doc:`/vdpadevs/sfc` guide for more details on this driver.
 
 * **Added telemetry callbacks to the cryptodev library.**
 
@@ -322,7 +322,7 @@ New Features
 * **Added NXP LA12xx baseband PMD.**
 
   * Added a new baseband PMD for NXP LA12xx Software defined radio.
-  * See the :doc:`../bbdevs/la12xx` for more details.
+  * See the :doc:`/bbdevs/la12xx` for more details.
 
 * **Updated Mellanox compress driver.**
 
diff --git a/doc/guides/rel_notes/release_22_03.rst b/doc/guides/rel_notes/release_22_03.rst
index 3c25561f27..b6a97e1ffe 100644
--- a/doc/guides/rel_notes/release_22_03.rst
+++ b/doc/guides/rel_notes/release_22_03.rst
@@ -177,7 +177,7 @@ New Features
   for applications that as well as providing standard dataplane functionality
   also want to have fast and low latency access to GPIO pin state.
 
-  See the :doc:`../rawdevs/cnxk_gpio` rawdev guide for more details on this
+  See the :doc:`/rawdevs/cnxk_gpio` rawdev guide for more details on this
   driver.
 
 * **Updated testpmd to support software UDP/TCP checksum over multiple segments.**
diff --git a/doc/guides/rel_notes/release_22_07.rst b/doc/guides/rel_notes/release_22_07.rst
index 7312a29789..442dd4554b 100644
--- a/doc/guides/rel_notes/release_22_07.rst
+++ b/doc/guides/rel_notes/release_22_07.rst
@@ -118,7 +118,7 @@ New Features
 * **Updated Intel igc driver.**
 
   Added Intel Foxville I226 devices in ``igc`` driver.
-  See the :doc:`../nics/igc` NIC guide for more details.
+  See the :doc:`/nics/igc` NIC guide for more details.
 
 * **Updated Mellanox mlx5 driver.**
 
diff --git a/doc/guides/rel_notes/release_22_11.rst b/doc/guides/rel_notes/release_22_11.rst
index 91414573bd..a8d48344c3 100644
--- a/doc/guides/rel_notes/release_22_11.rst
+++ b/doc/guides/rel_notes/release_22_11.rst
@@ -109,7 +109,7 @@ New Features
 * **Added GVE net PMD.**
 
   * Added the new ``gve`` net driver for Google Virtual Ethernet devices.
-  * See the :doc:`../nics/gve` NIC guide for more details on this new driver.
+  * See the :doc:`/nics/gve` NIC guide for more details on this new driver.
 
 * **Updated Intel iavf driver.**
 
@@ -123,7 +123,7 @@ New Features
 
   Added the new ``idpf`` net driver
   for Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100.
-  See the :doc:`../nics/idpf` NIC guide for more details on this new driver.
+  See the :doc:`/nics/idpf` NIC guide for more details on this new driver.
 
 * **Updated Marvell cnxk driver.**
 
@@ -209,7 +209,7 @@ New Features
 * **Added UADK crypto driver.**
 
   Added a new crypto driver for the UADK library. See the
-  :doc:`../cryptodevs/uadk` guide for more details on this new driver.
+  :doc:`/cryptodevs/uadk` guide for more details on this new driver.
 
 * **Added bbdev operation for FFT processing.**
 
@@ -263,17 +263,17 @@ New Features
 
   Added new application to test ``rte_security`` session create/destroy
   performance.
-  See the :doc:`../tools/securityperf` for more details.
+  See the :doc:`/tools/securityperf` for more details.
 
 * **Updated IPsec sample application.**
 
   Added support for lookaside sessions in event mode.
-  See the :doc:`../sample_app_ug/ipsec_secgw` for more details.
+  See the :doc:`/sample_app_ug/ipsec_secgw` for more details.
 
 * **Updated FIPS validation sample application.**
 
   Added support for asymmetric crypto algorithms.
-  See the :doc:`../sample_app_ug/fips_validation` for more details.
+  See the :doc:`/sample_app_ug/fips_validation` for more details.
 
 * **Rewrote pmdinfo script.**
 
diff --git a/doc/guides/rel_notes/release_23_03.rst b/doc/guides/rel_notes/release_23_03.rst
index 898aa09af9..b6532696aa 100644
--- a/doc/guides/rel_notes/release_23_03.rst
+++ b/doc/guides/rel_notes/release_23_03.rst
@@ -112,7 +112,7 @@ New Features
 
   Added the new cpfl net driver
   for Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100.
-  See the :doc:`../nics/cpfl` NIC guide for more details on this new driver.
+  See the :doc:`/nics/cpfl` NIC guide for more details on this new driver.
 
 * **Updated Intel igc driver.**
 
diff --git a/doc/guides/rel_notes/release_23_07.rst b/doc/guides/rel_notes/release_23_07.rst
index 30cc70bcd4..699bde0196 100644
--- a/doc/guides/rel_notes/release_23_07.rst
+++ b/doc/guides/rel_notes/release_23_07.rst
@@ -185,7 +185,7 @@ New Features
   PDCP features such as IV generation, sequence number handling, etc are supported.
   It is planned to add more features such as packet caching in future releases.
 
-  See :doc:`../prog_guide/pdcp_lib` for more information.
+  See :doc:`/prog_guide/pdcp_lib` for more information.
 
 * **Added TCP/IPv6 support in GRO library.**
 
@@ -203,7 +203,7 @@ New Features
 
   Added an application to test the performance of DMA device and CPU.
 
-  See the :doc:`../tools/dmaperf` for more details.
+  See the :doc:`/tools/dmaperf` for more details.
 
 
 Removed Items
diff --git a/doc/guides/rel_notes/release_23_11.rst b/doc/guides/rel_notes/release_23_11.rst
index 6d83682d73..92efc31bcb 100644
--- a/doc/guides/rel_notes/release_23_11.rst
+++ b/doc/guides/rel_notes/release_23_11.rst
@@ -118,7 +118,7 @@ New Features
 * **Added a new vDPA PMD for Corigine NFP devices.**
 
   Added a new Corigine NFP vDPA (``nfp_vdpa``) PMD.
-  See the :doc:`../vdpadevs/nfp` guide for more details on this driver.
+  See the :doc:`/vdpadevs/nfp` guide for more details on this driver.
 
 * **Updated Corigine/Netronome nfp driver.**
 
diff --git a/doc/guides/rel_notes/release_24_07.rst b/doc/guides/rel_notes/release_24_07.rst
index bc11b20789..df7ab9ef3d 100644
--- a/doc/guides/rel_notes/release_24_07.rst
+++ b/doc/guides/rel_notes/release_24_07.rst
@@ -115,7 +115,7 @@ New Features
 * **Added UADK compress driver.**
 
   Added a new compress driver for the UADK library. See the
-  :doc:`../compressdevs/uadk` guide for more details on this new driver.
+  :doc:`/compressdevs/uadk` guide for more details on this new driver.
 
 * **Updated Marvell CNXK DMA driver.**
 
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 652562a71c..ac3919a489 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -125,7 +125,7 @@ New Features
   Added a compress driver for ZSDA devices
   to support the deflate compression and decompression algorithm.
 
-  See the :doc:`../compressdevs/zsda` guide for more details on the new driver.
+  See the :doc:`/compressdevs/zsda` guide for more details on the new driver.
 
 * **Added atomic tests to the eventdev test application.**
 
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index c25266b0fb..b83b9b286b 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -19,7 +19,7 @@ New Features
   Now, it is possible to use the shortened ``-l`` form
   to map lcore IDs to threads running on specific CPUs.
 
-  See the :doc:`../linux_gsg/eal_args.include` guide for examples.
+  See the :doc:`/linux_gsg/eal_args.include` guide for examples.
 
 * **Added PMU library.**
 
@@ -38,7 +38,7 @@ New Features
 * **Added Mucse rnp net driver.**
 
   Added a new network PMD which supports Mucse 10 Gigabit Ethernet NICs.
-  See the :doc:`../nics/rnp` for more details.
+  See the :doc:`/nics/rnp` for more details.
 
 * **Added RSS type for RoCE v2.**
 
@@ -75,7 +75,7 @@ New Features
   Added a crypto driver for ZSDA devices
   to support some encrypt, decrypt and hash algorithms.
 
-  See the :doc:`../cryptodevs/zsda` guide for more details on the new driver.
+  See the :doc:`/cryptodevs/zsda` guide for more details on the new driver.
 
 * **Updated Marvell cnxk crypto driver.**
 
@@ -96,7 +96,7 @@ New Features
 
   Added vector adapter producer mode in eventdev test to measure performance.
 
-  See the :doc:`../prog_guide/eventdev/event_vector_adapter` guide
+  See the :doc:`/prog_guide/eventdev/event_vector_adapter` guide
   for more details on the new library.
 
 * **Added event vector adapter support in CN20K event device driver.**
@@ -111,7 +111,7 @@ New Features
   to manage multiple network protocols/features with runtime configurability,
   in-built node-reusability and optimized control/data plane synchronization.
 
-  See section ``Graph feature arc`` in :doc:`../prog_guide/graph_lib` for more details.
+  See section ``Graph feature arc`` in :doc:`/prog_guide/graph_lib` for more details.
 
   Added ``ip4 output`` feature arc processing in ``ip4_rewrite`` node.
 
diff --git a/doc/guides/sample_app_ug/dma.rst b/doc/guides/sample_app_ug/dma.rst
index a455f9c8ad..d22a41b4c8 100644
--- a/doc/guides/sample_app_ug/dma.rst
+++ b/doc/guides/sample_app_ug/dma.rst
@@ -38,7 +38,7 @@ Running the Application
 In order to run the hardware copy application, the copying device
 needs to be bound to user-space IO driver.
 
-Refer to the :doc:`../prog_guide/dmadev` for information on using the library.
+Refer to the :doc:`/prog_guide/dmadev` for information on using the library.
 
 The application requires a number of command line options:
 
@@ -320,4 +320,4 @@ The metadata in this example is copied from ``rx_descriptor_fields1`` marker of
 ``rte_mbuf`` struct up to ``buf_len`` member.
 
 In order to understand why software packet copying is done as shown
-above, please refer to the :doc:`../prog_guide/mbuf_lib`.
+above, please refer to the :doc:`/prog_guide/mbuf_lib`.
diff --git a/doc/guides/sample_app_ug/intro.rst b/doc/guides/sample_app_ug/intro.rst
index a19c0b8c13..d9d6320470 100644
--- a/doc/guides/sample_app_ug/intro.rst
+++ b/doc/guides/sample_app_ug/intro.rst
@@ -15,8 +15,8 @@ Running Sample Applications
 
 Some sample applications may have their own command-line parameters described in
 their respective guides. However, they all also share the same EAL parameters.
-Please refer to :doc:`EAL parameters (Linux) <../linux_gsg/linux_eal_parameters>`
-or :doc:`EAL parameters (FreeBSD) <../freebsd_gsg/freebsd_eal_parameters>` for
+Please refer to :doc:`EAL parameters (Linux) </linux_gsg/linux_eal_parameters>`
+or :doc:`EAL parameters (FreeBSD) </freebsd_gsg/freebsd_eal_parameters>` for
 a list of available EAL command-line options.
 
 
diff --git a/doc/guides/sample_app_ug/ip_reassembly.rst b/doc/guides/sample_app_ug/ip_reassembly.rst
index 5a71644e38..b998c1b370 100644
--- a/doc/guides/sample_app_ug/ip_reassembly.rst
+++ b/doc/guides/sample_app_ug/ip_reassembly.rst
@@ -124,7 +124,7 @@ The following sections describe aspects that are specific to the IP reassemble s
 IPv4 Fragment Table Initialization
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-This application uses the :doc:`../prog_guide/ip_fragment_reassembly_lib` library.
+This application uses the :doc:`/prog_guide/ip_fragment_reassembly_lib` library.
 The fragment table maintains information about already received fragments of the packet.
 Each IP packet is uniquely identified by triple <Source IP address>, <Destination IP address>, <ID>.
 To avoid lock contention, each Rx queue has its own fragment table.
diff --git a/doc/guides/sample_app_ug/l3_forward_power_man.rst b/doc/guides/sample_app_ug/l3_forward_power_man.rst
index 5888e393d1..4a771bbe9b 100644
--- a/doc/guides/sample_app_ug/l3_forward_power_man.rst
+++ b/doc/guides/sample_app_ug/l3_forward_power_man.rst
@@ -304,7 +304,7 @@ and has three available power management schemes:
   The reaction time of the scale mode is longer
   than the pause and monitor mode.
 
-See :doc:`Power Management<../prog_guide/power_man>` chapter
+See :doc:`Power Management </prog_guide/power_man>` chapter
 in the DPDK Programmer's Guide for more details on PMD power management.
 
 .. code-block:: console
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index d654484546..fc9e4f02a9 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -7,8 +7,8 @@ Running the Application
 EAL Command-line Options
 ------------------------
 
-Please refer to :doc:`EAL parameters (Linux) <../linux_gsg/linux_eal_parameters>`
-or :doc:`EAL parameters (FreeBSD) <../freebsd_gsg/freebsd_eal_parameters>` for
+Please refer to :doc:`EAL parameters (Linux) </linux_gsg/linux_eal_parameters>`
+or :doc:`EAL parameters (FreeBSD) </freebsd_gsg/freebsd_eal_parameters>` for
 a list of available EAL command-line options.
 
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 0bc267950a..f06856070b 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2437,7 +2437,7 @@ Link Bonding Functions
 The Link Bonding functions make it possible to dynamically create and
 manage link bonding devices from within testpmd interactive prompt.
 
-See :doc:`../prog_guide/link_bonding_poll_mode_drv_lib` for more information.
+See :doc:`/prog_guide/link_bonding_poll_mode_drv_lib` for more information.
 
 .. _testpmd_traffic_metering_and_policing:
 
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 6c1d8bb951..fc47f23007 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -566,7 +566,7 @@ Building DTS API docs
 ---------------------
 
 The documentation is built using the standard DPDK build system.
-See :doc:`../linux_gsg/build_dpdk` for more details on compiling DPDK with meson.
+See :doc:`/linux_gsg/build_dpdk` for more details on compiling DPDK with meson.
 
 After executing the meson command, build the documentation with:
 
diff --git a/doc/guides/tools/flow-perf.rst b/doc/guides/tools/flow-perf.rst
index 657f06fec7..1a437ed9d4 100644
--- a/doc/guides/tools/flow-perf.rst
+++ b/doc/guides/tools/flow-perf.rst
@@ -44,8 +44,8 @@ Running the Application
 EAL Command-line Options
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Please refer to :doc:`EAL parameters (Linux) <../linux_gsg/linux_eal_parameters>`
-or :doc:`EAL parameters (FreeBSD) <../freebsd_gsg/freebsd_eal_parameters>` for
+Please refer to :doc:`EAL parameters (Linux) </linux_gsg/linux_eal_parameters>`
+or :doc:`EAL parameters (FreeBSD) </freebsd_gsg/freebsd_eal_parameters>` for
 a list of available EAL command-line options.
 
 
diff --git a/doc/guides/tools/securityperf.rst b/doc/guides/tools/securityperf.rst
index 5890eda436..fb70beb976 100644
--- a/doc/guides/tools/securityperf.rst
+++ b/doc/guides/tools/securityperf.rst
@@ -19,8 +19,8 @@ Running the Application
 EAL Command-line Options
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Please refer to :doc:`EAL parameters (Linux) <../linux_gsg/linux_eal_parameters>`
-or :doc:`EAL parameters (FreeBSD) <../freebsd_gsg/freebsd_eal_parameters>`
+Please refer to :doc:`EAL parameters (Linux) </linux_gsg/linux_eal_parameters>`
+or :doc:`EAL parameters (FreeBSD) </freebsd_gsg/freebsd_eal_parameters>`
 for a list of available EAL command-line options.
 
 Security Performance Options
diff --git a/doc/guides/tools/testbbdev.rst b/doc/guides/tools/testbbdev.rst
index 58de4a2fbe..a7c433aacd 100644
--- a/doc/guides/tools/testbbdev.rst
+++ b/doc/guides/tools/testbbdev.rst
@@ -41,7 +41,7 @@ The following are the command-line options:
 
 ``-e EAL_PARAMS, --eal_params EAL_PARAMS``
  Specifies EAL arguments which are passed to the test app. For more details,
- refer to DPDK documentation at :doc:`../linux_gsg/linux_eal_parameters`.
+ refer to DPDK documentation at :doc:`/linux_gsg/linux_eal_parameters`.
 
 ``-t TIMEOUT, --timeout TIMEOUT``
  Specifies timeout in seconds. If not specified timeout is set to 300 seconds.
diff --git a/doc/guides/vdpadevs/mlx5.rst b/doc/guides/vdpadevs/mlx5.rst
index 2ee8112131..4b604d5446 100644
--- a/doc/guides/vdpadevs/mlx5.rst
+++ b/doc/guides/vdpadevs/mlx5.rst
@@ -9,7 +9,7 @@ NVIDIA MLX5 vDPA Driver
 The mlx5 vDPA (vhost data path acceleration) driver (``librte_vdpa_mlx5``)
 provides support for NVIDIA NIC and DPU device families.
 
-See :doc:`../../platform/mlx5` guide for design details,
+See :doc:`/platform/mlx5` guide for design details,
 and which PMDs can be combined with vDPA PMD.
 
 
diff --git a/doc/guides/windows_gsg/intro.rst b/doc/guides/windows_gsg/intro.rst
index 4ac7f97828..37be379060 100644
--- a/doc/guides/windows_gsg/intro.rst
+++ b/doc/guides/windows_gsg/intro.rst
@@ -19,6 +19,6 @@ compile. Support is being added in pieces so as to limit the overall scope
 of any individual patch series. The goal is to be able to run any DPDK
 application natively on Windows.
 
-The :doc:`../contributing/abi_policy` does not apply to the Windows build,
+The :doc:`/contributing/abi_policy` does not apply to the Windows build,
 as function versioning is not supported on Windows,
 therefore minor ABI versions may be incompatible.
-- 
2.54.0

