Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8A6C4450A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 10:38:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22BD540698;
	Thu, 16 Jul 2026 12:38:38 +0200 (CEST)
Received: from flow-a7-smtp.messagingengine.com
 (flow-a7-smtp.messagingengine.com [103.168.172.142])
 by mails.dpdk.org (Postfix) with ESMTP id F0A93406B4
 for <dev@dpdk.org>; Thu, 16 Jul 2026 12:38:35 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.phl.internal (Postfix) with ESMTP id A743F13804A5;
 Thu, 16 Jul 2026 06:38:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 16 Jul 2026 06:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784198315;
 x=1784205515; bh=XB8MOpvjxHYYJJ3AlmR+/eTCzQHITu/g+0+fslo3Qhc=; b=
 Ko1FpnLUAz/27K+cKzUjdwIPskRzSAZLyJVq1oGHBJsieiIEMFlY5LygDnoA/TBP
 7vT7Nilsj89ft5Ah6n5645DhtY0ZM1G8hGja+BGmGbIqRMabE+tMUEpa1rr0f8HJ
 Nb+AoJGSy+rwb/DXe82ajp3klv/YfSv1ktL12gcamMpjteZYzrI25j9caEnI6G/x
 64dgnZkOpzQnkJ1BXsyW+LOVrRDyR20FMrsVDy/Po+BJ9W3g9mo82xmNJbdPIMS0
 jZ0036ROxWoySADyXnBBaNKaOmJk8YepVc2cMBxWhglEBWL8tVpHUcqpE70XgW/5
 Jw3/oAG0UPDiLTXqFwikMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784198315; x=
 1784205515; bh=XB8MOpvjxHYYJJ3AlmR+/eTCzQHITu/g+0+fslo3Qhc=; b=V
 6B48dH/dlQPN47aXOsd6x45dq2YbR1wXMq09FD9HNNckO26FEPADz0fxzVj7ZjtF
 ZjuD9jAkMM5jdQFspNzYHQyteHNJuz2T0cWz6qoDpBrVGNbQJzfYDdZqRlPNCARI
 GL9ynYtfjZAPV0OxsT1aENAYmkT7VMwtrI49N9aoHc3VSSgWs4YjheULSB8Bb3LI
 KQLU+F4Fp9lRpu6GiBp09bjuodo3vZUBQ4G9d+FC1YmFOTautkB3NVyrt7eud1z+
 xWIlXbnBx10L4/8XKSdRc2UXFvwv8dV0aNQZIRUgY37BUYjkYnhhnsXF9cZKYG1/
 hXmU/wDtdVA+5KJwtfL4A==
X-ME-Sender: <xms:qrRYakU4X6I0YidYiMDJwldmMr_1h_YraEJjyAkq1tNQHLuVgE3Axg>
 <xme:qrRYauCITTWoxQgYtwkYl1ftLWx8K4YxF2o3Mlzjr2M5P71YezsHAbV408O_mxdxk
 vck9XCXBXmVX4XLJMlKyUKmEKaiOrxCMSlQBqTY8tLHVqPPFVRahf0>
X-ME-Received: <xmr:qrRYatKmg5xW2J0IV4fVWbFOkxslRe9wV2cl3TYEGC4A5_hOQrePGKxiLCZnp7JtZiBSGk8T0NQKTUItjM9k8fA>
X-ME-Proxy-Cause: dmFkZTFqCW1mALm3XIBsHMv4Nj8W0NOgb6ga939CfMa41jWd6Cz8INnBP+vA7DzMz0QC89
 fxdXSpn3JsnWoD8PxWCa/6ijLbFYi5VmYc254ki5M3PZJKv2lV9synqGkd1l+nfymiqjsy
 jvNViM8lKPznAsNZ8gLnkRhGN2d1Mjger/Ur5qi8CuES7xFF8AiUVBAffs3GUIxJtQy7Cj
 clMr/LC1EmK/TIq/Cpl5+VYUACm/JlZ5wgQcN8kHjiIxCtXCMLUKx2NKcnW99ZCH7bJVHI
 GkeILlZgrli1z0E7WWmcH32abQ5dl+tZ3CQw+PdYfoeX790Da99BliymfOUm3XMsNL8RTC
 IzJG5hsLHUrQtJ5g4RwNLgwecTySBq8xiOZIO+DQm0kaQYXiM4Zg4vvGkH0T1D4MmDjslJ
 Q6eqTpRF2QGMCkW05sMdgem6NtXXa5jhWDWA7J0/aIBI+y7rw6jNjd/aZZHGYNMiQEqBXd
 2NWZulbRqeh+U3ENAITCMIrjyMaHIPfmMOEJXxTH/+24n5SxKq26fY2gbw0KCTgum/d0SO
 /xjOygQodT20Cb+kzYCWYrkSIt5Bi18qEvy4K0uGpQk3GjKc8WmJUqYiWmhS7GKYRWfFVC
 zRlgQXZ09xbRRAlSqw4m1w4uScg044cuv1wmRGe6KK4DKxCdMY20owkw63fRu6GfBz3Id1
 zKo6T7aNKtm086zqBBmaiwwjXdlgeV6LsnBZxa/UGFO5h24QMUW6Qcg969akXxvOMBoTlD
 ssm9N+c3c4ecPf9uf/sG9Q16ct+qO3aOKcS9xvR858nxujIaFF3XvFkZccaabCbGwpUwbI
 a5Ut8nNJZ57GCjJOp5feff9T9DjPWIwAYOiQu4eJNOZKVozFLz4L+MSWAssZpTrFGUXmnM
 93DSihYQ2xzxcyBx/ciGSbw0l2uGVum7SzO/VBb050oagTyegq+sEDaT0qyV2JroK+71Y/
 s41dhtM7QXBOm0c70qxrEYCAXLR5fUlr5TK95/ly04j/2kR+AjY
X-ME-Proxy: <xmx:qrRYakQc-hVuU2u4FDOYfnMTOGefXvXW7kDEKd8yun1AM4gscuY-8Q>
 <xmx:qrRYasHHQKouJFnPNkHDgOdm3-dholFRCJZDbMr8_AVdrtpJzrcX0A>
 <xmx:qrRYapVji3cuG1eklyZPd_qSJCr0acA2rPHIPZz3S8b5PLjWPe8JkQ>
 <xmx:qrRYamx53fhn4AHMTTzO_0HP96YtRfK-zmbXgXUjf0OWzGYqL3hp-Q>
 <xmx:q7RYauR9FxsiXRDh0zuRPcb5jdGg02rkVLQIjh_4KzuwoiDS6MaVMJ7L>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:38:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Nandini Persad <nandinipersad361@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 David Marchand <david.marchand@redhat.com>,	Kai Ji <kai.ji@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,	Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>,	Suanming Mou <suanmingm@nvidia.com>,
 Liron Himi <lironh@marvell.com>,	Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>,	Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,	Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Jiayu Hu <hujiayu.hu@foxmail.com>,	Jerin Jacob <jerinj@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH v3 8/8] doc: add prefixes to guide labels
Date: Thu, 16 Jul 2026 12:31:26 +0200
Message-ID: <20260716103632.711164-9-thomas@monjalon.net>
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

From: Nandini Persad <nandinipersad361@gmail.com>

Sphinx labels are global across the documentation.

Rename guide labels with document- or component-specific prefixes
to avoid collisions and make their ownership clear.

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/compressdevs/qat_comp.rst          |  2 +-
 doc/guides/contributing/abi_policy.rst        | 38 ++++----
 doc/guides/contributing/abi_versioning.rst    | 26 ++---
 doc/guides/contributing/coding_style.rst      |  8 +-
 doc/guides/contributing/design.rst            |  2 +-
 doc/guides/contributing/documentation.rst     | 26 ++---
 doc/guides/contributing/new_driver.rst        |  6 +-
 doc/guides/contributing/patches.rst           |  6 +-
 doc/guides/cryptodevs/qat.rst                 |  4 +-
 doc/guides/faq/faq.rst                        |  2 +-
 doc/guides/freebsd_gsg/build_dpdk.rst         |  6 +-
 doc/guides/freebsd_gsg/build_sample_apps.rst  |  6 +-
 doc/guides/freebsd_gsg/install_from_ports.rst |  8 +-
 doc/guides/howto/avx512.rst                   |  3 +-
 doc/guides/howto/flow_bifurcation.rst         |  2 +-
 doc/guides/howto/packet_capture_framework.rst |  7 +-
 .../howto/virtio_user_as_exception_path.rst   |  4 +-
 .../virtio_user_for_container_networking.rst  |  8 +-
 doc/guides/linux_gsg/build_dpdk.rst           |  2 +-
 doc/guides/linux_gsg/build_sample_apps.rst    |  3 +-
 .../linux_gsg/cross_build_dpdk_for_arm64.rst  |  8 +-
 doc/guides/linux_gsg/enable_func.rst          |  6 +-
 doc/guides/linux_gsg/linux_drivers.rst        | 14 +--
 doc/guides/linux_gsg/sys_reqs.rst             |  2 +-
 doc/guides/nics/cxgbe.rst                     | 26 ++---
 doc/guides/nics/dpaa2.rst                     |  4 +-
 doc/guides/nics/i40e.rst                      |  6 +-
 doc/guides/nics/intel_vf.rst                  | 18 ++--
 doc/guides/nics/ixgbe.rst                     |  2 +-
 doc/guides/nics/mlx4.rst                      |  8 +-
 doc/guides/nics/mlx5.rst                      |  8 +-
 doc/guides/nics/mvpp2.rst                     | 23 ++---
 doc/guides/nics/netvsc.rst                    |  4 +-
 doc/guides/platform/cnxk.rst                  | 14 +--
 doc/guides/platform/dpaa.rst                  |  4 +-
 doc/guides/platform/mlx5.rst                  |  2 +-
 doc/guides/platform/octeontx.rst              |  7 +-
 doc/guides/prog_guide/bbdev.rst               |  8 +-
 doc/guides/prog_guide/efd_lib.rst             | 52 +++++-----
 .../prog_guide/env_abstraction_layer.rst      | 22 ++---
 .../prog_guide/ethdev/qos_framework.rst       | 94 +++++++++----------
 .../ethdev/traffic_metering_and_policing.rst  |  4 +-
 .../prog_guide/eventdev/dispatcher_lib.rst    |  4 +-
 doc/guides/prog_guide/fib_lib.rst             |  4 +-
 .../generic_receive_offload_lib.rst           |  4 +-
 .../generic_segmentation_offload_lib.rst      |  8 +-
 doc/guides/prog_guide/graph_lib.rst           | 52 +++++-----
 doc/guides/prog_guide/mbuf_lib.rst            |  6 +-
 doc/guides/prog_guide/mempool_lib.rst         | 10 +-
 .../prog_guide/packet_classif_access_ctrl.rst |  2 +-
 doc/guides/prog_guide/packet_framework.rst    | 80 +++++++++-------
 doc/guides/prog_guide/rcu_lib.rst             |  4 +-
 doc/guides/prog_guide/rib_lib.rst             | 12 +--
 doc/guides/prog_guide/toeplitz_hash_lib.rst   | 12 +--
 doc/guides/sample_app_ug/compiling.rst        |  2 +-
 doc/guides/sample_app_ug/dist_app.rst         |  4 +-
 doc/guides/sample_app_ug/l2_forward_event.rst |  4 +-
 .../sample_app_ug/l2_forward_job_stats.rst    | 10 +-
 .../sample_app_ug/l2_forward_real_virtual.rst | 14 +--
 doc/guides/sample_app_ug/server_node_efd.rst  |  4 +-
 doc/guides/sample_app_ug/test_pipeline.rst    |  4 +-
 .../sample_app_ug/vm_power_management.rst     | 32 ++++---
 .../sample_app_ug/vmdq_dcb_forwarding.rst     |  5 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  6 +-
 doc/guides/tools/dts.rst                      | 20 ++--
 doc/guides/tools/graph.rst                    | 66 +++++++------
 doc/guides/tools/testeventdev.rst             | 16 ++--
 67 files changed, 459 insertions(+), 431 deletions(-)

diff --git a/doc/guides/compressdevs/qat_comp.rst b/doc/guides/compressdevs/qat_comp.rst
index e2044b2601..78b1ad9c23 100644
--- a/doc/guides/compressdevs/qat_comp.rst
+++ b/doc/guides/compressdevs/qat_comp.rst
@@ -55,4 +55,4 @@ Installation
 
 The QAT compression PMD is built by default with a standard DPDK build.
 
-It depends on a QAT kernel driver, see :ref:`building_qat`.
+It depends on a QAT kernel driver, see :ref:`qat_building`.
diff --git a/doc/guides/contributing/abi_policy.rst b/doc/guides/contributing/abi_policy.rst
index ee7775c1ec..7e65607e6c 100644
--- a/doc/guides/contributing/abi_policy.rst
+++ b/doc/guides/contributing/abi_policy.rst
@@ -15,23 +15,23 @@ General Guidelines
 
 #. Major ABI versions are declared no more frequently than yearly. Compatibility
    with the major ABI version is mandatory in subsequent releases until a
-   :ref:`new major ABI version <new_abi_version>` is declared.
+   :ref:`new major ABI version <abi_new_version>` is declared.
 #. Major ABI versions are usually but not always declared aligned with a
    :doc:`LTS release <stable>`.
 #. The ABI version is managed at a project level in DPDK, and is reflected in
-   all non-experimental :ref:`library's soname <what_is_soname>`.
+   all non-experimental :ref:`library's soname <abi_what_is_soname>`.
 #. The ABI should be preserved and not changed lightly. ABI changes must follow
    the outlined :ref:`deprecation process <abi_changes>`.
 #. The addition of symbols is generally not problematic.
    The modification of symbols is managed with :doc:`abi_versioning`.
 #. The removal of symbols is considered an :ref:`ABI breakage <abi_breakages>`,
    once approved these will form part of the next ABI version.
-#. Libraries or APIs marked as :ref:`experimental <experimental_apis>`
+#. Libraries or APIs marked as :ref:`experimental <abi_experimental_apis>`
    may be changed or removed without prior notice,
    as they are not considered part of an ABI version.
-   The :ref:`experimental <experimental_apis>` status of an API
+   The :ref:`experimental <abi_experimental_apis>` status of an API
    is not an indefinite state.
-#. Updates to the :ref:`minimum hardware requirements <hw_rqmts>`, which drop
+#. Updates to the :ref:`minimum hardware requirements <abi_hw_requirements>`, which drop
    support for hardware which was previously supported, should be treated as an
    ABI change.
 
@@ -65,14 +65,14 @@ An ABI version is an instance of a library's ABI at a specific release. Certain
 releases are considered to be milestone releases, the yearly LTS release for
 example. The ABI of a milestone release may be declared as a 'major ABI
 version', where this ABI version is then supported for some number of subsequent
-releases and is annotated in the library's :ref:`soname<what_is_soname>`.
+releases and is annotated in the library's :ref:`soname <abi_what_is_soname>`.
 
 ABI version support in subsequent releases facilitates application upgrades, by
 enabling applications built against the milestone release to upgrade to
 subsequent releases of a library without a rebuild.
 
 More details on major ABI version can be found in the :ref:`ABI versioning
-<major_abi_versions>` guide.
+<abi_major_versions>` guide.
 
 The DPDK ABI policy
 -------------------
@@ -143,7 +143,7 @@ The requirements for changing the ABI are:
      CPU vendors, end-users, etc.
 
 #. Backward compatibility with the major ABI version must be maintained through
-   :doc:`abi_versioning`, with :ref:`forward-only <forward-only>` compatibility
+   :doc:`abi_versioning`, with :ref:`forward-only <abi_forward_only>` compatibility
    offered for any ABI changes that are indicated to be part of the next ABI
    version.
 
@@ -152,7 +152,7 @@ The requirements for changing the ABI are:
 
    - No backward or forward compatibility is offered for API changes marked as
      ``experimental``, as described in the section on :ref:`Experimental APIs
-     and Libraries <experimental_apis>`.
+     and Libraries <abi_experimental_apis>`.
 
    - In situations in which an ``experimental`` symbol has been stable for some
      time. When promoting the symbol to become part of the next ABI version, the
@@ -164,7 +164,7 @@ The requirements for changing the ABI are:
    ``__rte_deprecated``.
 
     - The deprecated API should follow the notification process to be removed,
-      see  :ref:`deprecation_notices`.
+      see  :ref:`abi_deprecation_notices`.
 
     - At the declaration of the next major ABI version, those ABI changes then
       become a formal part of the new ABI and the requirement to preserve ABI
@@ -174,7 +174,7 @@ The requirements for changing the ABI are:
       with the original contributor of the ABI changes, failing that, then with
       the contributor's company and then finally with the maintainer.
 
-.. _forward-only:
+.. _abi_forward_only:
 
 .. Note::
 
@@ -186,7 +186,7 @@ The requirements for changing the ABI are:
    of these ABI changes can only ensure that its runtime dependencies are met
    through Operating System package versioning.
 
-.. _hw_rqmts:
+.. _abi_hw_requirements:
 
 .. Note::
 
@@ -228,14 +228,14 @@ declarations of major ABI versions.
   preserved through :doc:`abi_versioning`.
 
   - The new function may be marked with the ``__rte_experimental`` tag for a
-    number of releases, as described in the section :ref:`experimental_apis`.
+    number of releases, as described in the section :ref:`abi_experimental_apis`.
 
   - Once ``rte_foo(uint8_t bar)`` becomes non-experimental, ``rte_foo()`` is
     declared as ``__rte_deprecated`` and an deprecation notice is provided.
 
 * DPDK 20.11 is not re-released to include ``rte_foo(uint8_t bar)``, the new
   version of ``rte_foo`` only exists from DPDK 21.02 onwards as described in the
-  :ref:`note on forward-only compatibility<forward-only>`.
+  :ref:`note on forward-only compatibility <abi_forward_only>`.
 
 * DPDK 21.02 release defines the experimental function ``__rte_experimental
   rte_baz()``. This function may or may not exist in the DPDK 21.05 release.
@@ -250,7 +250,7 @@ declarations of major ABI versions.
   formally part of then new major ABI version DPDK ``22`` and ``rte_foo()`` may be
   removed.
 
-.. _deprecation_notices:
+.. _abi_deprecation_notices:
 
 Examples of Deprecation Notices
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -281,7 +281,7 @@ added to the Release Notes:
   require updating and recompilation.
 
 
-.. _new_abi_version:
+.. _abi_new_version:
 
 New ABI versions
 ----------------
@@ -299,9 +299,9 @@ and some amended rules apply during this cycle:
    as described in the section :ref:`abi_changes`.
  * Symbol versioning references to the old ABI version are updated
    to reference the new ABI version,
-   as described in the section :ref:`deprecating_entire_abi`.
+   as described in the section :ref:`abi_deprecating_entire_abi`.
  * Contributors of aliases to experimental in previous releases,
-   as described in section :ref:`aliasing_experimental_symbols`,
+   as described in section :ref:`abi_aliasing_experimental_symbols`,
    are now required to remove these aliases.
  * Finally, the *ABI breakage window* is *not* permission to circumvent
    the other aspects of the procedures to make ABI changes
@@ -309,7 +309,7 @@ and some amended rules apply during this cycle:
    to break the ABI and the observance of a deprecation notice
    are still considered mandatory.
 
-.. _experimental_apis:
+.. _abi_experimental_apis:
 
 Experimental
 ------------
diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
index 6861517c5d..6d093a6950 100644
--- a/doc/guides/contributing/abi_versioning.rst
+++ b/doc/guides/contributing/abi_versioning.rst
@@ -6,7 +6,7 @@ ABI Versioning
 
 This document details the mechanics of ABI version management in DPDK.
 
-.. _what_is_soname:
+.. _abi_what_is_soname:
 
 What is a library's soname?
 ---------------------------
@@ -29,7 +29,7 @@ ABI version. The library loaded at runtime therefore, may be a minor revision
 supporting the same major ABI version (e.g. ``librte_eal.21.2``), as the library
 used to link the application (e.g ``librte_eal.21.0``).
 
-.. _major_abi_versions:
+.. _abi_major_versions:
 
 Major ABI versions
 ------------------
@@ -68,7 +68,7 @@ persists over multiple releases.
 
 When an ABI change is made between major ABI versions to a given library, a new
 section is added to that library's version map describing the impending new ABI
-version, as described in the section :ref:`example_abi_macro_usage`. The
+version, as described in the section :ref:`abi_example_macro_usage`. The
 library's soname and filename however do not change, e.g. ``libacl.so.21``, as
 ABI compatibility with the last major ABI version continues to be preserved for
 that library.
@@ -93,7 +93,7 @@ that library.
 
 However when a new ABI version is declared, for example DPDK ``22``, old
 deprecated functions may be safely removed at this point and the entire old
-major ABI version removed, see the section :ref:`deprecating_entire_abi` on
+major ABI version removed, see the section :ref:`abi_deprecating_entire_abi` on
 how this may be done.
 
 .. code-block:: none
@@ -150,7 +150,7 @@ The macros are:
   to become part of the stable ABI, to provide an alias to experimental
   until the next major ABI version.
 
-.. _example_abi_macro_usage:
+.. _abi_example_macro_usage:
 
 Examples of ABI Macro use
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -226,7 +226,7 @@ but now points to the above newly named function ``rte_acl_create_v21``.
 We have now mapped the original rte_acl_create symbol to the original function
 (but with a new name).
 
-Please see the section :ref:`enabling_versioning_macros`
+Please see the section :ref:`abi_enabling_versioning_macros`
 to enable this macro in the Meson/Ninja build.
 
 Next, we need to create the new version of the symbol. We create a new
@@ -256,11 +256,11 @@ used by newly built applications.
 .. note::
 
    **Before you leave**, please take care reviewing the sections on
-   :ref:`enabling_versioning_macros`,
+   :ref:`abi_enabling_versioning_macros`,
    and :ref:`ABI deprecation <abi_deprecation>`.
 
 
-.. _enabling_versioning_macros:
+.. _abi_enabling_versioning_macros:
 
 Enabling versioning macros
 __________________________
@@ -279,7 +279,7 @@ at the start of the head of the file. This will indicate to the tool-chain to
 enable the function version macros when building.
 
 
-.. _aliasing_experimental_symbols:
+.. _abi_aliasing_experimental_symbols:
 
 Aliasing experimental symbols
 _____________________________
@@ -291,7 +291,7 @@ promoting the symbol, the maintainer may choose to provide an alias to the
 This alias is then dropped in the next major ABI version.
 
 The process to provide an alias to ``experimental`` is similar to that, of
-:ref:`symbol versioning <example_abi_macro_usage>` described above.
+:ref:`symbol versioning <abi_example_macro_usage>` described above.
 Assume we have an experimental function ``rte_acl_create`` as follows:
 
 .. code-block:: c
@@ -327,7 +327,7 @@ When we promote the symbol to the stable ABI, we simply strip the
    }
 
 Although there are strictly no guarantees or commitments associated with
-:ref:`experimental symbols <experimental_apis>`, a maintainer may wish to offer
+:ref:`experimental symbols <abi_experimental_apis>`, a maintainer may wish to offer
 an alias to experimental. The process to add an alias to experimental,
 is similar to the symbol versioning process. Assuming we have an experimental
 symbol as before, we now add the symbol to both the ``EXPERIMENTAL``
@@ -372,7 +372,7 @@ Note that the internal function definition must also be removed, but it is used
 in our example by the newer version ``v22``, so we leave it in place and declare
 it as static. This is a coding style choice.
 
-.. _deprecating_entire_abi:
+.. _abi_deprecating_entire_abi:
 
 Deprecating an entire ABI version
 _________________________________
@@ -413,4 +413,4 @@ and <newdir> specifies the DPDK build directory to check the ABI of.
 
 The ABI compatibility is automatically verified when using a build script
 from ``devtools``, if the variable ``DPDK_ABI_REF_VERSION`` is set with a tag,
-as described in :ref:`ABI check recommendations<integrated_abi_check>`.
+as described in :ref:`ABI check recommendations <contrib_integrated_abi_check>`.
diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
index d5acbd3b97..8b7ae30cf8 100644
--- a/doc/guides/contributing/coding_style.rst
+++ b/doc/guides/contributing/coding_style.rst
@@ -34,7 +34,7 @@ Usual Comments
 ~~~~~~~~~~~~~~
 
 These comments should be used in normal cases.
-To document a public API, a doxygen-like format must be used: refer to :ref:`doxygen_guidelines`.
+To document a public API, a doxygen-like format must be used: refer to :ref:`style_doxygen_guidelines`.
 
 .. code-block:: c
 
@@ -588,7 +588,9 @@ Prototypes
 * Function prototypes should be listed in a logical order, preferably alphabetical unless there is a compelling reason to use a different ordering.
 * Functions that are used locally in more than one module go into a separate header file, for example, "extern.h".
 * Do not use the ``__P`` macro.
-* Functions that are part of an external API should be documented using Doxygen-like comments above declarations. See :ref:`doxygen_guidelines` for details.
+* Functions that are part of an external API
+  should be documented using Doxygen-like comments above declarations.
+  See :ref:`style_doxygen_guidelines` for details.
 * Functions that are part of the external API must have an ``rte_`` prefix on the function name.
 * Do not use uppercase letters - either in the form of ALL_UPPERCASE, or CamelCase - in function names. Lower-case letters and underscores only.
 * When prototyping functions, associate names with parameter types, for example:
@@ -825,7 +827,7 @@ Control Statements
                  /* NOTREACHED */
          }
 
-.. _dynamic_logging:
+.. _style_dynamic_logging:
 
 Dynamic Logging
 ---------------
diff --git a/doc/guides/contributing/design.rst b/doc/guides/contributing/design.rst
index 0e5cb60053..41431f063e 100644
--- a/doc/guides/contributing/design.rst
+++ b/doc/guides/contributing/design.rst
@@ -76,7 +76,7 @@ It is often desirable to provide information to the end-user
 as to what is happening to the application at runtime.
 DPDK provides a number of built-in mechanisms to provide this introspection:
 
-* :ref:`Logging <dynamic_logging>`
+* :ref:`Logging <style_dynamic_logging>`
 * :doc:`Tracing </prog_guide/trace_lib>`
 * :doc:`Telemetry </prog_guide/telemetry_lib>`
 
diff --git a/doc/guides/contributing/documentation.rst b/doc/guides/contributing/documentation.rst
index 41cbd03a4f..14ca10804c 100644
--- a/doc/guides/contributing/documentation.rst
+++ b/doc/guides/contributing/documentation.rst
@@ -56,7 +56,7 @@ Role of the Documentation
 The following items outline the roles of the different parts of the documentation and when they need to be updated or
 added to by the developer.
 
-.. _contrib_doc_guidelines_release_notes:
+.. _style_release_notes_guidelines:
 
 * **Release Notes**
 
@@ -489,8 +489,10 @@ Images
 
 * Images in the documentation should be formatted as follows:
 
-   * The image should be preceded by a label in the format ``.. _figure_XXXX:`` with a leading underscore and
-     where ``XXXX`` is a unique descriptive name.
+   * The image should be preceded by a label
+     in the format ``.. _prefix_figure_name:`` with a leading underscore,
+     where ``prefix`` is the document or component name,
+     and ``name`` makes it unique and descriptive.
 
    * Images should be included using the ``.. figure::`` directive and the file type should be set to ``*`` (not ``.svg``).
      This allows the format of the image to be changed if required, without updating the documentation.
@@ -499,26 +501,26 @@ Images
 
 * Here is an example of the previous three guidelines::
 
-     .. _figure_mempool:
+     .. _mempool_figure_cache:
 
      .. figure:: img/mempool.*
 
         A mempool in memory with its associated ring.
 
-.. _mock_label:
+.. _style_mock_label:
 
 * Images can then be linked to using the ``:numref:`` directive::
 
-     The mempool layout is shown in :numref:`figure_mempool`.
+     The mempool layout is shown in :numref:`mempool_figure_cache`.
 
-  This would be rendered as: *The mempool layout is shown in* :ref:`Fig 6.3 <mock_label>`.
+  This would be rendered as: *The mempool layout is shown in* :ref:`Fig 6.3 <style_mock_label>`.
 
   **Note**: The ``:numref:`` directive requires Sphinx 1.3.1 or later.
   With earlier versions it will still be rendered as a link but won't have an automatically generated number.
 
 * The caption of the image can be generated, with a link, using the ``:ref:`` directive::
 
-     :ref:`figure_mempool`
+     :ref:`mempool_figure_cache`
 
   This would be rendered as: *A mempool in memory with its associated ring.*
 
@@ -533,7 +535,7 @@ Tables
 * Tables should be included using the ``.. table::`` directive and must have a caption.
 
 
-.. _links:
+.. _style_links:
 
 Hyperlinks
 ~~~~~~~~~~
@@ -550,14 +552,14 @@ Hyperlinks
 
 * An internal link can be generated by placing labels in the document with the format ``.. _label_name``.
 
-* The following links to the top of this section: :ref:`links`::
+* The following links to the top of this section: :ref:`style_links`::
 
      .. _links:
 
      Hyperlinks
      ~~~~~~~~~~
 
-     * The following links to the top of this section: :ref:`links`:
+     * The following links to the top of this section: :ref:`style_links`:
 
 .. Note::
 
@@ -567,7 +569,7 @@ Hyperlinks
 * The use of a label is preferred since it works across files and will still work if the header text changes.
 
 
-.. _doxygen_guidelines:
+.. _style_doxygen_guidelines:
 
 Doxygen Guidelines
 ------------------
diff --git a/doc/guides/contributing/new_driver.rst b/doc/guides/contributing/new_driver.rst
index ea433b8d9a..c7976d042a 100644
--- a/doc/guides/contributing/new_driver.rst
+++ b/doc/guides/contributing/new_driver.rst
@@ -95,7 +95,7 @@ This approach ensures a clear and manageable development process.
 We suggest splitting patches following this approach:
 
 * Each patch should be organized logically as a new feature.
-* Run test tools per patch (See :ref:`tool_list`).
+* Run test tools per patch (See :ref:`contrib_tool_list`).
 * Update relevant documentation and `<driver>.ini` file with each patch.
 
 The following order in the patch series is as suggested below.
@@ -193,7 +193,7 @@ If the required dependency is not yet publicly available,
 then wait to submit the driver until the dependent library is available.
 
 
-.. _tool_list:
+.. _contrib_tool_list:
 
 Test Tools
 ----------
@@ -211,4 +211,4 @@ Be sure to run the following test tools per patch in a patch series:
 * `check-spdx-tag.sh`
 * Build documentation and validate how output looks
 * Optionally run ``review-patch.py`` for AI-assisted review
-  (see :ref:`ai_assisted_review` in the Contributing Guide)
+  (see :ref:`contrib_ai_assisted_review` in the Contributing Guide)
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index ab4d3ec916..4c7ffe5f36 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -168,7 +168,7 @@ Make your planned changes in the cloned ``dpdk`` repo. Here are some guidelines
 * When introducing a new device API, at least one driver should implement it.
 
 * Important changes will require an addition to the release notes in ``doc/guides/rel_notes/``.
-  See the :ref:`release notes guidelines <contrib_doc_guidelines_release_notes>`.
+  See the :ref:`release notes guidelines <style_release_notes_guidelines>`.
 
 * Test the compilation works with different targets, compilers and options, see :ref:`contrib_check_compilation`.
 
@@ -501,7 +501,7 @@ the ``dts-check-format.sh`` script in the ``devtools`` directory of the DPDK rep
 To run the script, extra :ref:`Python dependencies <dts_deps>` are needed.
 
 
-.. _ai_assisted_review:
+.. _contrib_ai_assisted_review:
 
 AI-Assisted Patch Review
 ------------------------
@@ -575,7 +575,7 @@ in a single subfolder called "__builds" created in the current directory.
 Setting ``DPDK_BUILD_TEST_DIR`` to an absolute directory path e.g. ``/tmp`` is also supported.
 
 
-.. _integrated_abi_check:
+.. _contrib_integrated_abi_check:
 
 Checking ABI compatibility
 --------------------------
diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index d929e9d731..6c96c5f88d 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -10,7 +10,7 @@ QAT documentation consists of three parts:
 * Details of the :doc:`compression service </compressdevs/qat_comp>`
   in the compressdev drivers section.
 * Details of building the common QAT infrastructure and the PMDs to support the
-  above services. See :ref:`building_qat` below.
+  above services. See :ref:`qat_building` below.
 
 
 Symmetric Crypto Service on QAT
@@ -203,7 +203,7 @@ Limitations
   in different threads.)
 * RSA-2560, RSA-3584 are not supported
 
-.. _building_qat:
+.. _qat_building:
 
 Building PMDs on QAT
 --------------------
diff --git a/doc/guides/faq/faq.rst b/doc/guides/faq/faq.rst
index 9503bdec59..5def8d453d 100644
--- a/doc/guides/faq/faq.rst
+++ b/doc/guides/faq/faq.rst
@@ -6,7 +6,7 @@ What does "EAL: map_all_hugepages(): open failed: Permission denied Cannot init
 
 This is most likely due to the test application not being run with sudo to promote the user to a superuser.
 Alternatively, applications can also be run as regular user.
-For more information, please refer to :ref:`Running_Without_Root_Privileges`.
+For more information, please refer to :ref:`linux_gsg_running_without_root_privileges`.
 
 
 If I want to change the number of hugepages allocated, how do I remove the original pages allocated?
diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
index faedee1384..9dafa64e84 100644
--- a/doc/guides/freebsd_gsg/build_dpdk.rst
+++ b/doc/guides/freebsd_gsg/build_dpdk.rst
@@ -65,7 +65,7 @@ the next section.
         variable.
 
 
-.. _loading_contigmem:
+.. _freebsd_gsg_loading_contigmem:
 
 Loading the DPDK contigmem Module
 ---------------------------------
@@ -153,7 +153,7 @@ available and can be verified via dmesg or ``/var/log/messages``::
 
 To avoid this error, reduce the number of buffers or the buffer size.
 
-.. _loading_nic_uio:
+.. _freebsd_gsg_loading_nic_uio:
 
 Loading the DPDK nic_uio Module
 -------------------------------
@@ -190,7 +190,7 @@ already bound to a driver other than ``nic_uio``. The following sub-section desc
 how to query and modify the device ownership of the ports to be used by
 DPDK applications.
 
-.. _binding_network_ports:
+.. _freebsd_gsg_binding_network_ports:
 
 Binding Network Ports to the nic_uio Module
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/freebsd_gsg/build_sample_apps.rst b/doc/guides/freebsd_gsg/build_sample_apps.rst
index a89518daa5..5cbe5fb0dd 100644
--- a/doc/guides/freebsd_gsg/build_sample_apps.rst
+++ b/doc/guides/freebsd_gsg/build_sample_apps.rst
@@ -42,7 +42,7 @@ the installation of DPDK using `meson install` as described previously::
         ln -sf helloworld-shared build/helloworld
 
 
-.. _running_sample_app:
+.. _freebsd_gsg_running_sample_app:
 
 Running a Sample Application
 ----------------------------
@@ -50,14 +50,14 @@ Running a Sample Application
 #.  The ``contigmem`` and ``nic_uio`` modules must be set up prior to running an application.
 
 #.  Any ports to be used by the application must be already bound to the ``nic_uio`` module,
-    as described in section :ref:`binding_network_ports`, prior to running the application.
+    as described in section :ref:`freebsd_gsg_binding_network_ports`, prior to running the application.
     The application is linked with the DPDK target environment's Environment
     Abstraction Layer (EAL) library, which provides some options that are generic
     to every DPDK application.
 
 You can refer to :doc:`freebsd_eal_parameters` for the list of EAL options.
 
-.. _running_non_root:
+.. _freebsd_gsg_running_non_root:
 
 Running DPDK Applications Without Root Privileges
 -------------------------------------------------
diff --git a/doc/guides/freebsd_gsg/install_from_ports.rst b/doc/guides/freebsd_gsg/install_from_ports.rst
index d2e19a1248..888ab3e0fc 100644
--- a/doc/guides/freebsd_gsg/install_from_ports.rst
+++ b/doc/guides/freebsd_gsg/install_from_ports.rst
@@ -26,8 +26,8 @@ DPDK can be installed on FreeBSD using the command::
 After the installation of the DPDK package, instructions will be printed on
 how to install the kernel modules required to use the DPDK. A more
 complete version of these instructions can be found in the sections
-:ref:`loading_contigmem` and :ref:`loading_nic_uio`. Normally, lines like
-those below would be added to the file ``/boot/loader.conf``.
+:ref:`freebsd_gsg_loading_contigmem` and :ref:`freebsd_gsg_loading_nic_uio`.
+Normally, lines like those below would be added to the file ``/boot/loader.conf``.
 
 .. code-block:: shell
 
@@ -115,9 +115,9 @@ via the contigmem module, and 4 NIC ports bound to the nic_uio module::
 
    To run a DPDK process as a non-root user, adjust the permissions on
    the ``/dev/contigmem`` and ``/dev/uio device`` nodes as described in section
-   :ref:`running_non_root`
+   :ref:`freebsd_gsg_running_non_root`
 
 .. note::
 
    For an explanation of the command-line parameters that can be passed to an
-   DPDK application, see section :ref:`running_sample_app`.
+   DPDK application, see section :ref:`freebsd_gsg_running_sample_app`.
diff --git a/doc/guides/howto/avx512.rst b/doc/guides/howto/avx512.rst
index a9ff770740..c417a90b71 100644
--- a/doc/guides/howto/avx512.rst
+++ b/doc/guides/howto/avx512.rst
@@ -22,7 +22,8 @@ which does not allow for AVX-512.
    rte_vect_set_max_simd_bitwidth(RTE_VECT_SIMD_512);
 
 This API should only be called once at initialization, before EAL init.
-For more information on the possible enum values to use as a parameter, go to :ref:`max_simd_bitwidth`:
+For more information on the possible enum values to use as a parameter,
+go to :ref:`eal_max_simd_bitwidth`:
 
 
 Using the command-line argument
diff --git a/doc/guides/howto/flow_bifurcation.rst b/doc/guides/howto/flow_bifurcation.rst
index c1e125072a..4bbe207dc8 100644
--- a/doc/guides/howto/flow_bifurcation.rst
+++ b/doc/guides/howto/flow_bifurcation.rst
@@ -44,7 +44,7 @@ module.
 Using Flow Bifurcation on NVIDIA ConnectX
 -----------------------------------------
 
-The NVIDIA devices are :ref:`natively bifurcated <bifurcated_driver>`,
+The NVIDIA devices are :ref:`natively bifurcated <linux_gsg_bifurcated_driver>`,
 so there is no need to split into SR-IOV PF/VF
 in order to get the flow bifurcation mechanism.
 The full device is already shared with the kernel driver.
diff --git a/doc/guides/howto/packet_capture_framework.rst b/doc/guides/howto/packet_capture_framework.rst
index b0db8bde04..3d12901d68 100644
--- a/doc/guides/howto/packet_capture_framework.rst
+++ b/doc/guides/howto/packet_capture_framework.rst
@@ -70,10 +70,9 @@ Test Environment
 ----------------
 
 The overview of using the Packet Capture Framework and the ``dpdk-dumpcap`` utility
-for packet capturing on the DPDK port in
-:numref:`figure_packet_capture_framework`.
+for packet capturing on the DPDK port in :numref:`packet_capture_framework_figure_overview`.
 
-.. _figure_packet_capture_framework:
+.. _packet_capture_framework_figure_overview:
 
 .. figure:: img/packet_capture_framework.*
 
@@ -84,7 +83,7 @@ Running the Application
 -----------------------
 
 The following steps demonstrate how to run the ``dpdk-dumpcap`` tool to capture
-Rx side packets on dpdk_port0 in :numref:`figure_packet_capture_framework` and
+Rx side packets on dpdk_port0 in :numref:`packet_capture_framework_figure_overview` and
 inspect them using ``tcpdump``.
 
 #. Launch testpmd as the primary application::
diff --git a/doc/guides/howto/virtio_user_as_exception_path.rst b/doc/guides/howto/virtio_user_as_exception_path.rst
index 9593831575..03d061498e 100644
--- a/doc/guides/howto/virtio_user_as_exception_path.rst
+++ b/doc/guides/howto/virtio_user_as_exception_path.rst
@@ -39,9 +39,9 @@ This solution has a number of advantages over alternatives such as KNI:
     which minimises the impact on the polling DPDK threads.
 
 The overview of an application using virtio-user as exception path is shown
-in :numref:`figure_virtio_user_as_exception_path`.
+in :numref:`virtio_user_exception_path_figure_overview`.
 
-.. _figure_virtio_user_as_exception_path:
+.. _virtio_user_exception_path_figure_overview:
 
 .. figure:: img/virtio_user_as_exception_path.*
 
diff --git a/doc/guides/howto/virtio_user_for_container_networking.rst b/doc/guides/howto/virtio_user_for_container_networking.rst
index 1798cdf327..be4425bef5 100644
--- a/doc/guides/howto/virtio_user_for_container_networking.rst
+++ b/doc/guides/howto/virtio_user_for_container_networking.rst
@@ -8,9 +8,9 @@ Container becomes more and more popular for strengths, like low overhead, fast
 boot-up time, and easy to deploy, etc. How to use DPDK to accelerate container
 networking becomes a common question for users. There are two use models of
 running DPDK inside containers, as shown in
-:numref:`figure_use_models_for_running_dpdk_in_containers`.
+:numref:`virtio_user_container_figure_use_models`.
 
-.. _figure_use_models_for_running_dpdk_in_containers:
+.. _virtio_user_container_figure_use_models:
 
 .. figure:: img/use_models_for_running_dpdk_in_containers.*
 
@@ -26,9 +26,9 @@ for high performance user space container networking or inter-process
 communication (IPC).
 
 The overview of accelerating container networking by virtio-user is shown
-in :numref:`figure_virtio_user_for_container_networking`.
+in :numref:`virtio_user_container_figure_networking`.
 
-.. _figure_virtio_user_for_container_networking:
+.. _virtio_user_container_figure_networking:
 
 .. figure:: img/virtio_user_for_container_networking.*
 
diff --git a/doc/guides/linux_gsg/build_dpdk.rst b/doc/guides/linux_gsg/build_dpdk.rst
index 4388e0a1ec..00bf3262da 100644
--- a/doc/guides/linux_gsg/build_dpdk.rst
+++ b/doc/guides/linux_gsg/build_dpdk.rst
@@ -291,7 +291,7 @@ By adhering to these guidelines, you will ensure the most optimized build
 for ARM-based DPDK targets.
 
 
-.. _building_app_using_installed_dpdk:
+.. _linux_gsg_building_app_using_installed_dpdk:
 
 Building Applications Using Installed DPDK
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index 4f5930a5f6..57ce568359 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -10,7 +10,8 @@ It also provides a pointer to where sample applications are stored.
 Compiling a Sample Application
 ------------------------------
 
-Please refer to :ref:`building_app_using_installed_dpdk` for details on compiling sample apps.
+Please refer to :ref:`linux_gsg_building_app_using_installed_dpdk`
+for details on compiling sample apps.
 
 Running a Sample Application
 ----------------------------
diff --git a/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst b/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
index 6485943da0..e443be6369 100644
--- a/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
+++ b/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
@@ -64,7 +64,7 @@ For aarch32, install ``pkg-config-arm-linux-gnueabihf``::
 GNU toolchain
 -------------
 
-.. _obtain_GNU_toolchain:
+.. _linux_gsg_obtain_gnu_toolchain:
 
 Get the cross toolchain
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -94,7 +94,7 @@ For aarch32::
    For the host requirements and other info, refer to the release note section:
    https://releases.linaro.org/components/toolchain/binaries/
 
-.. _augment_the_gnu_toolchain_with_numa_support:
+.. _linux_gsg_augment_the_gnu_toolchain_with_numa_support:
 
 Augment the GNU toolchain with NUMA support
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -198,7 +198,7 @@ https://developer.arm.com/tools-and-software/open-source-software/developer-tool
 
 The LLVM/Clang toolchain does not implement the standard c library.
 The GNU toolchain ships an implementation we can use.
-Refer to obtain_GNU_toolchain_ to get the GNU toolchain.
+Refer to linux_gsg_obtain_gnu_toolchain_ to get the GNU toolchain.
 
 Unzip and add into the PATH
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -214,7 +214,7 @@ Cross Compiling DPDK with LLVM/Clang toolchain using Meson
 .. note::
 
    To use the NUMA library follow the same steps as for
-   augment_the_gnu_toolchain_with_numa_support_.
+   linux_gsg_augment_the_gnu_toolchain_with_numa_support_.
 
 The paths to GNU stdlib must be specified in a cross file.
 Augmenting the default cross-file's ``c_args`` and ``c_link_args``
diff --git a/doc/guides/linux_gsg/enable_func.rst b/doc/guides/linux_gsg/enable_func.rst
index c3f5be481a..d99fafbde0 100644
--- a/doc/guides/linux_gsg/enable_func.rst
+++ b/doc/guides/linux_gsg/enable_func.rst
@@ -6,7 +6,7 @@
 Enabling Additional Functionality
 =================================
 
-.. _Running_Without_Root_Privileges:
+.. _linux_gsg_running_without_root_privileges:
 
 Running DPDK Applications Without Root Privileges
 -------------------------------------------------
@@ -83,7 +83,7 @@ need to be adjusted in order to ensure normal DPDK operation:
 The above limits can usually be adjusted by editing
 ``/etc/security/limits.conf`` file, and rebooting.
 
-See :ref:`hugepage_mapping` section to learn how these limits affect EAL.
+See :ref:`eal_hugepage_mapping` section to learn how these limits affect EAL.
 
 Device Control
 ~~~~~~~~~~~~~~
@@ -160,7 +160,7 @@ Also see
 `CPU isolation example <https://www.suse.com/c/cpu-isolation-practical-example-part-5/>`_
 and `systemd core isolation example <https://www.rcannings.com/systemd-core-isolation/>`_.
 
-.. _High_Precision_Event_Timer:
+.. _linux_gsg_high_precision_event_timer:
 
 High Precision Event Timer (HPET) Functionality
 -----------------------------------------------
diff --git a/doc/guides/linux_gsg/linux_drivers.rst b/doc/guides/linux_gsg/linux_drivers.rst
index 08e72ace56..12e9faf4a2 100644
--- a/doc/guides/linux_gsg/linux_drivers.rst
+++ b/doc/guides/linux_gsg/linux_drivers.rst
@@ -21,14 +21,14 @@ Binding and Unbinding Network Ports to/from the Kernel Modules
 
    PMDs which use the bifurcated driver should not be unbound from their kernel drivers.
    This section is for PMDs which use the UIO or VFIO drivers.
-   See :ref:`bifurcated_driver` section for more details.
+   See :ref:`linux_gsg_bifurcated_driver` section for more details.
 
 .. note::
 
    It is recommended that ``vfio-pci`` be used as the kernel module for DPDK-bound ports in all cases.
-   If an IOMMU is unavailable, the ``vfio-pci`` can be used in :ref:`no-iommu<vfio_noiommu>` mode.
+   If an IOMMU is unavailable, the ``vfio-pci`` can be used in :ref:`no-iommu <linux_gsg_vfio_noiommu>` mode.
    If, for some reason, vfio is unavailable, then UIO-based modules, ``igb_uio`` and ``uio_pci_generic`` may be used.
-   See section :ref:`uio` for details.
+   See section :ref:`linux_gsg_uio` for details.
 
 Most devices require that the hardware to be used by DPDK be unbound from the kernel driver it uses,
 and instead be bound to the ``vfio-pci`` kernel module before the application is run.
@@ -130,10 +130,10 @@ to use IO virtualization (such as Intel\ |reg| VT-d).
    configure the Linux kernel to use IOMMU.
 
 For proper operation of VFIO when running DPDK applications as a non-privileged user, correct permissions should also be set up.
-For more information, please refer to :ref:`Running_Without_Root_Privileges`.
+For more information, please refer to :ref:`linux_gsg_running_without_root_privileges`.
 
 
-.. _vfio_noiommu:
+.. _linux_gsg_vfio_noiommu:
 
 VFIO no-IOMMU mode
 ~~~~~~~~~~~~~~~~~~
@@ -359,7 +359,7 @@ running on these systems.
 Consult your distribution's documentation to make sure that is the case.
 
 
-.. _bifurcated_driver:
+.. _linux_gsg_bifurcated_driver:
 
 Bifurcated Driver
 -----------------
@@ -384,7 +384,7 @@ More about the bifurcated driver can be found in
 NVIDIA `bifurcated PMD
 <https://www.dpdk.org/wp-content/uploads/sites/23/2016/10/Day02-Session04-RonyEfraim-Userspace2016.pdf>`_ presentation.
 
-.. _uio:
+.. _linux_gsg_uio:
 
 UIO
 ---
diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index a596400178..0e6a2e2e78 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -131,7 +131,7 @@ System Software
     *   PROC_PAGE_MONITOR support
 
     *   HPET and HPET_MMAP configuration options should also be enabled if HPET support is required.
-        See the section on :ref:`High_Precision_Event_Timer` for more details.
+        See the section on :ref:`linux_gsg_high_precision_event_timer` for more details.
 
 .. _linux_gsg_hugepages:
 
diff --git a/doc/guides/nics/cxgbe.rst b/doc/guides/nics/cxgbe.rst
index aa46f0bd82..063cb16d85 100644
--- a/doc/guides/nics/cxgbe.rst
+++ b/doc/guides/nics/cxgbe.rst
@@ -15,7 +15,7 @@ and has support for the latest Linux operating systems.
 More information can be found at `Chelsio Communications Official Website
 <http://www.chelsio.com>`_.
 
-.. _t5-nics:
+.. _cxgbe_t5_nics:
 
 Supported Chelsio T5 NICs
 -------------------------
@@ -25,7 +25,7 @@ Supported Chelsio T5 NICs
 - 40G NICs: T580-CR, T580-LP-CR, T580-SO-CR
 - Other T5 NICs: T522-CR
 
-.. _t6-nics:
+.. _cxgbe_t6_nics:
 
 Supported Chelsio T6 NICs
 -------------------------
@@ -37,7 +37,7 @@ Supported SR-IOV Chelsio NICs
 -----------------------------
 
 SR-IOV virtual functions are supported on all the Chelsio NICs listed
-in :ref:`t5-nics` and :ref:`t6-nics`.
+in :ref:`cxgbe_t5_nics` and :ref:`cxgbe_t6_nics`.
 
 Features
 --------
@@ -73,7 +73,7 @@ Prerequisites
   repository.
 
   Instructions on how to manually flash the firmware are given in section
-  :ref:`linux-installation` for Linux and section :ref:`freebsd-installation`
+  :ref:`cxgbe_linux_installation` for Linux and section :ref:`cxgbe_freebsd_installation`
   for FreeBSD.
 
 
@@ -319,7 +319,7 @@ CXGBE PF Only Runtime Options
 
      dpdk-testpmd -a 02:00.4,filtermode=0x88,filtermask=0x80 -- -i
 
-.. _driver-compilation:
+.. _cxgbe_driver_compilation:
 
 Driver compilation and testing
 ------------------------------
@@ -330,7 +330,7 @@ for details.
 Linux
 -----
 
-.. _linux-installation:
+.. _cxgbe_linux_installation:
 
 Linux Installation
 ~~~~~~~~~~~~~~~~~~
@@ -468,8 +468,8 @@ devices managed by librte_net_cxgbe in Linux operating system.
 
    .. note::
 
-      Flow control pause TX/RX is disabled by default and can be enabled via
-      testpmd. Refer section :ref:`flow-control` for more details.
+      Flow control pause TX/RX is disabled by default and can be enabled via testpmd.
+      Refer section :ref:`cxgbe_flow_control` for more details.
 
 Configuring SR-IOV Virtual Functions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -582,7 +582,7 @@ virtual functions.
 FreeBSD
 -------
 
-.. _freebsd-installation:
+.. _cxgbe_freebsd_installation:
 
 FreeBSD Installation
 ~~~~~~~~~~~~~~~~~~~~
@@ -652,7 +652,7 @@ This section demonstrates how to launch **testpmd** with Chelsio
 devices managed by librte_net_cxgbe in FreeBSD operating system.
 
 #. Change to DPDK source directory where the target has been compiled in
-   section :ref:`driver-compilation`:
+   section :ref:`cxgbe_driver_compilation`:
 
    .. code-block:: console
 
@@ -778,13 +778,13 @@ devices managed by librte_net_cxgbe in FreeBSD operating system.
 
 .. note::
 
-   Flow control pause TX/RX is disabled by default and can be enabled via
-   testpmd. Refer section :ref:`flow-control` for more details.
+   Flow control pause TX/RX is disabled by default and can be enabled via testpmd.
+   Refer section :ref:`cxgbe_flow_control` for more details.
 
 Sample Application Notes
 ------------------------
 
-.. _flow-control:
+.. _cxgbe_flow_control:
 
 Enable/Disable Flow Control
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 6e2884b897..ae8b32af2c 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -407,7 +407,7 @@ Features of the DPAA2 PMD are:
 - Link flow control
 - Scattered and gather for TX and RX
 - Rx queue interrupts
-- :ref:`dptmapi`
+- :ref:`dpaa2_dptmapi`
 
 
 Supported DPAA2 SoCs
@@ -589,7 +589,7 @@ Other Limitations
 - RSS hash key cannot be modified.
 - RSS RETA cannot be configured.
 
-.. _dptmapi:
+.. _dpaa2_dptmapi:
 
 Traffic Management API
 ----------------------
diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 69b0fae10f..f71191b686 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -699,7 +699,7 @@ Mirror rule limitation for X722
 
 Due to firmware restriction of X722, the same VSI cannot have more than one mirror rule.
 
-.. _net_i40e_testpmd_commands:
+.. _i40e_testpmd_commands:
 
 Testpmd driver specific commands
 --------------------------------
@@ -924,9 +924,9 @@ The following is an example of running the DPDK ``l3fwd`` sample application to
 server with Intel Xeon processors and Intel Ethernet CNA XL710.
 
 The example scenario is to get best performance with two Intel Ethernet CNA XL710 40GbE ports.
-See :numref:`figure_intel_perf_test_setup` for the performance test setup.
+See :numref:`i40e_figure_intel_perf_test_setup` for the performance test setup.
 
-.. _figure_intel_perf_test_setup:
+.. _i40e_figure_intel_perf_test_setup:
 
 .. figure:: img/intel_perf_test_setup.*
 
diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index e010f852cf..8f8ce32cac 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -24,9 +24,9 @@ SR-IOV Mode Utilization in a DPDK Environment
 The DPDK uses the SR-IOV feature for hardware-based I/O sharing in IOV mode.
 Therefore, it is possible to partition SR-IOV capability on Ethernet controller NIC resources logically and
 expose them to a virtual machine as a separate PCI function called a "Virtual Function".
-Refer to :numref:`figure_single_port_nic`.
+Refer to :numref:`intel_vf_figure_single_port_nic`.
 
-Therefore, a NIC is logically distributed among multiple virtual machines (as shown in :numref:`figure_single_port_nic`),
+Therefore, a NIC is logically distributed among multiple virtual machines (as shown in :numref:`intel_vf_figure_single_port_nic`),
 while still having global data in common to share with the Physical Function and other Virtual Functions.
 The DPDK fm10kvf, iavf, igbvf or ixgbevf as a Poll Mode Driver (PMD) serves for the Intel® 82576 Gigabit Ethernet Controller,
 Intel® Ethernet Controller I350 family, Intel® 82599 10 Gigabit Ethernet Controller NIC,
@@ -47,7 +47,7 @@ For more detail on SR-IOV, please refer to the following documents:
 
 *   `Scalable I/O Virtualized Servers <http://www.intel.com/content/www/us/en/virtualization/server-virtualization/scalable-i-o-virtualized-servers-paper.html>`_
 
-.. _figure_single_port_nic:
+.. _intel_vf_figure_single_port_nic:
 
 .. figure:: img/single_port_nic.*
 
@@ -585,9 +585,9 @@ The setup procedure is as follows:
         can also be used to bind and unbind devices to a virtual machine in Ubuntu.
         If this option is used, step 6 in the instructions provided will be different.
 
-    *   The Virtual Machine Monitor (see :numref:`figure_perf_benchmark`) is equivalent to a Host OS with KVM installed as described in the instructions.
+    *   The Virtual Machine Monitor (see :numref:`intel_vf_figure_perf_benchmark`) is equivalent to a Host OS with KVM installed as described in the instructions.
 
-.. _figure_perf_benchmark:
+.. _intel_vf_figure_perf_benchmark:
 
 .. figure:: img/perf_benchmark.*
 
@@ -607,10 +607,10 @@ the DPDK VF PMD performs the same throughput result as a non-VT native environme
 With such host instance fast packet processing, lots of services such as filtering, QoS,
 DPI can be offloaded on the host fast path.
 
-:numref:`figure_fast_pkt_proc` shows the scenario where some VMs directly communicate externally via a VFs,
+:numref:`intel_vf_figure_fast_pkt_proc` shows the scenario where some VMs directly communicate externally via a VFs,
 while others connect to a virtual switch and share the same uplink bandwidth.
 
-.. _figure_fast_pkt_proc:
+.. _intel_vf_figure_fast_pkt_proc:
 
 .. figure:: img/fast_pkt_proc.*
 
@@ -626,7 +626,7 @@ So VF-to-VF traffic within the same physical port (VM0<->VM1) have hardware acce
 However, when VF crosses physical ports (VM0<->VM2), there is no such hardware bridge.
 In this case, the DPDK PMD PF driver provides host forwarding between such VMs.
 
-:numref:`figure_inter_vm_comms` shows an example.
+:numref:`intel_vf_figure_inter_vm_comms` shows an example.
 In this case an update of the MAC address lookup tables in both the NIC and host DPDK application is required.
 
 In the NIC, writing the destination of a MAC address belongs to another cross device VM to the PF specific pool.
@@ -637,7 +637,7 @@ that is, the packet is forwarded to the correct PF pool.
 The SR-IOV NIC switch forwards the packet to a specific VM according to the MAC destination address
 which belongs to the destination VF on the VM.
 
-.. _figure_inter_vm_comms:
+.. _intel_vf_figure_inter_vm_comms:
 
 .. figure:: img/inter_vm_comms.*
 
diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index db1c8b1aea..5f7131e925 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -379,7 +379,7 @@ the VFs which are required.::
 Currently hot-plugging of representor ports is not supported so all required
 representors must be specified on the creation of the PF.
 
-.. _net_ixgbe_testpmd_commands:
+.. _ixgbe_testpmd_commands:
 
 Testpmd driver specific commands
 --------------------------------
diff --git a/doc/guides/nics/mlx4.rst b/doc/guides/nics/mlx4.rst
index 1d3e42bcbb..852df1b789 100644
--- a/doc/guides/nics/mlx4.rst
+++ b/doc/guides/nics/mlx4.rst
@@ -221,9 +221,9 @@ Current RDMA core package and Linux kernel (recommended)
     ninja
     ninja install
 
-.. _`RDMA core installation documentation`: https://raw.githubusercontent.com/linux-rdma/rdma-core/master/README.md
+.. _RDMA core installation documentation: https://raw.githubusercontent.com/linux-rdma/rdma-core/master/README.md
 
-.. _OFED_as_a_fallback:
+.. _mlx4_ofed_as_a_fallback:
 
 NVIDIA MLNX_OFED as a fallback
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -231,7 +231,7 @@ NVIDIA MLNX_OFED as a fallback
 - `NVIDIA MLNX_OFED`_ version: **4.4, 4.5, 4.6**.
 - firmware version: **2.42.5000** and above.
 
-.. _`NVIDIA MLNX_OFED`: https://network.nvidia.com/products/infiniband-drivers/linux/mlnx_ofed/
+.. _NVIDIA MLNX_OFED: https://network.nvidia.com/products/infiniband-drivers/linux/mlnx_ofed/
 
 .. note::
 
@@ -283,7 +283,7 @@ Quick Start Guide
 
         If using NVIDIA MLNX_OFED one can permanently set the port link
         to Ethernet using connectx_port_config tool provided by it.
-        :ref:`OFED_as_a_fallback`:
+        :ref:`mlx4_ofed_as_a_fallback`:
 
 .. _mlx4_QSG_2:
 
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 3a419d7d97..9f4cc28bf2 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -893,7 +893,7 @@ Extended statistics can be queried using ``rte_eth_xstats_get()``.
 The extended statistics expose a wider set of counters counted by the device.
 The extended port statistics counts the number of packets
 received or sent successfully by the port.
-As NVIDIA NICs are using a :ref:`bifurcated Linux driver <bifurcated_driver>`,
+As NVIDIA NICs are using a :ref:`bifurcated Linux driver <linux_gsg_bifurcated_driver>`,
 those counters counts also packet received or sent by the Linux kernel.
 
 Finally per-flow statistics can by queried using ``rte_flow_query()``
@@ -1499,7 +1499,7 @@ Limitations
 Bifurcated Driver
 ~~~~~~~~~~~~~~~~~
 
-The same device is managed by both :ref:`kernel <bifurcated_driver>` and DPDK drivers.
+The same device is managed by both :ref:`kernel <linux_gsg_bifurcated_driver>` and DPDK drivers.
 
 After enabling the :ref:`isolated mode <flow_isolated_mode>`,
 non-matched packets are routed directly from the hardware to the kernel.
@@ -4786,14 +4786,14 @@ Port Attach with Socket Path
 It is possible to allocate a port with ``libibverbs`` from external application.
 For importing the external port with extra device arguments,
 there is a specific testpmd command
-similar to :ref:`port attach command <port_attach>`::
+similar to :ref:`port attach command <testpmd_port_attach>`::
 
    testpmd> mlx5 port attach (identifier) socket=(path)
 
 where:
 
 * ``identifier``: device identifier with optional parameters
-  as same as :ref:`port attach command <port_attach>`.
+  as same as :ref:`port attach command <testpmd_port_attach>`.
 * ``path``: path to IPC server socket created by the external application.
 
 This command performs:
diff --git a/doc/guides/nics/mvpp2.rst b/doc/guides/nics/mvpp2.rst
index f20987b4d7..72e301bbb4 100644
--- a/doc/guides/nics/mvpp2.rst
+++ b/doc/guides/nics/mvpp2.rst
@@ -35,13 +35,13 @@ Features of the MVPP2 PMD are:
 - L4 checksum offload
 - Packet type parsing
 - Basic stats
-- :ref:`extstats`
+- :ref:`mvpp2_extstats`
 - RX flow control
 - Scattered TX frames
-- :ref:`QoS <extconf>`
-- :ref:`flowapi`
-- :ref:`mtrapi`
-- :ref:`tmapi`
+- :ref:`QoS <mvpp2_extconf>`
+- :ref:`mvpp2_flowapi`
+- :ref:`mvpp2_mtrapi`
+- :ref:`mvpp2_tmapi`
 
 Limitations
 -----------
@@ -163,7 +163,7 @@ In order to run testpmd example application following command can be used:
      --burst=128 --txd=2048 --rxd=1024 --rxq=2 --txq=2  --nb-cores=2 \
      -i -a --rss-udp
 
-.. _extstats:
+.. _mvpp2_extstats:
 
 Extended stats
 --------------
@@ -185,7 +185,7 @@ MVPP2 PMD supports the following extended statistics:
 	- ``tx_errors``: number of TX MAC errors
 
 
-.. _extconf:
+.. _mvpp2_extconf:
 
 External Configuration
 ----------------------
@@ -390,7 +390,7 @@ Usage example
    ./dpdk-testpmd --vdev=eth_mvpp2,iface=eth0,iface=eth2,cfg=/home/user/mrvl.conf \
      -l 0-2 -- -i -a --disable-hw-vlan-strip --rxq=3 --txq=3
 
-.. _flowapi:
+.. _mvpp2_flowapi:
 
 Flow API
 --------
@@ -562,7 +562,7 @@ Following limitations need to be taken into account while creating flow rules:
 For additional information about classifier please consult
 ``doc/musdk_cls_user_guide.txt``.
 
-.. _mtrapi:
+.. _mvpp2_mtrapi:
 
 Traffic metering and policing
 -----------------------------
@@ -577,7 +577,8 @@ MVPP2 PMD supports DPDK traffic metering and policing that allows the following:
 
 For an additional description please refer to DPDK :doc:`/prog_guide/ethdev/traffic_metering_and_policing`.
 
-The policer objects defined by this feature can work with the default policer defined via config file as described in :ref:`QoS Support <extconf>`.
+The policer objects defined by this feature can work with the default policer
+defined via config file as described in :ref:`QoS Support <mvpp2_extconf>`.
 
 Limitations
 ~~~~~~~~~~~
@@ -618,7 +619,7 @@ Usage example
 For a detailed usage description please refer to :ref:`testpmd_traffic_metering_and_policing`.
 
 
-.. _tmapi:
+.. _mvpp2_tmapi:
 
 Traffic Management API
 ----------------------
diff --git a/doc/guides/nics/netvsc.rst b/doc/guides/nics/netvsc.rst
index 213d6d4745..de2754bf2d 100644
--- a/doc/guides/nics/netvsc.rst
+++ b/doc/guides/nics/netvsc.rst
@@ -60,7 +60,7 @@ store it in a shell variable:
 	DEV_UUID=$(basename $(readlink /sys/class/net/eth1/device))
 
 
-.. _`UUID`: https://en.wikipedia.org/wiki/Universally_unique_identifier
+.. _UUID: https://en.wikipedia.org/wiki/Universally_unique_identifier
 
 There are several possible ways to assign the UIO device driver for a device.
 The easiest way (but only on 4.18 or later)
@@ -71,7 +71,7 @@ the normal kernel device.
 
 	driverctl -b vmbus set-override $DEV_UUID uio_hv_generic
 
-.. _`driverctl Device Driver control utility`: https://gitlab.com/driverctl/driverctl
+.. _driverctl Device Driver control utility: https://gitlab.com/driverctl/driverctl
 
 Any settings done with driverctl are by default persistent and will be reapplied
 on reboot.
diff --git a/doc/guides/platform/cnxk.rst b/doc/guides/platform/cnxk.rst
index 06202bcbc2..2c6de1ae7d 100644
--- a/doc/guides/platform/cnxk.rst
+++ b/doc/guides/platform/cnxk.rst
@@ -23,10 +23,10 @@ Supported OCTEON cnxk SoCs
 Resource Virtualization Unit architecture
 -----------------------------------------
 
-The :numref:`figure_cnxk_resource_virtualization` diagram depicts the
+The :numref:`cnxk_figure_resource_virtualization` diagram depicts the
 RVU architecture and a resource provisioning example.
 
-.. _figure_cnxk_resource_virtualization:
+.. _cnxk_figure_resource_virtualization:
 
 .. figure:: img/cnxk_resource_virtualization.*
 
@@ -41,11 +41,11 @@ Each functional block has multiple local functions (LFs) for
 provisioning to different PCIe devices. RVU supports multiple PCIe SRIOV
 physical functions (PFs) and virtual functions (VFs).
 
-The :numref:`table_cnxk_rvu_dpdk_mapping` shows the various local
+The :numref:`cnxk_table_rvu_dpdk_mapping` shows the various local
 functions (LFs) provided by the RVU and its functional mapping to
 DPDK subsystem.
 
-.. _table_cnxk_rvu_dpdk_mapping:
+.. _cnxk_table_rvu_dpdk_mapping:
 
 .. table:: RVU managed functional blocks and its mapping to DPDK subsystem
 
@@ -94,7 +94,7 @@ handle provisioning/configuration requests sent by any device from any domain.
 The AF driver does not receive or process any data.
 It is only a configuration driver used in control path.
 
-The :numref:`figure_cnxk_resource_virtualization` diagram also shows a
+The :numref:`cnxk_figure_resource_virtualization` diagram also shows a
 resource provisioning example where,
 
 #. PFx and PFx-VF0 bound to Linux netdev driver.
@@ -145,10 +145,10 @@ The primary use case for SDP is to enable the smart NIC use case. Typical usage
 cnxk packet flow
 ----------------
 
-The :numref:`figure_cnxk_packet_flow_hw_accelerators` diagram depicts
+The :numref:`cnxk_figure_packet_flow_hw_accelerators` diagram depicts
 the packet flow on cnxk SoC in conjunction with use of various HW accelerators.
 
-.. _figure_cnxk_packet_flow_hw_accelerators:
+.. _cnxk_figure_packet_flow_hw_accelerators:
 
 .. figure:: img/cnxk_packet_flow_hw_accelerators.*
 
diff --git a/doc/guides/platform/dpaa.rst b/doc/guides/platform/dpaa.rst
index 76e2d1588d..9536401b42 100644
--- a/doc/guides/platform/dpaa.rst
+++ b/doc/guides/platform/dpaa.rst
@@ -67,7 +67,7 @@ compatible board:
    This tool can be obtained from `NXP (Freescale) Public Git Repository <https://source.codeaurora.org/external/qoriq/qoriq-components/fmc>`_.
 
    This tool needs configuration files which are available in the
-   :ref:`DPDK Extra Scripts <extra_scripts>`, described below for DPDK usages.
+   :ref:`DPDK Extra Scripts <dpaa_extra_scripts>`, described below for DPDK usages.
 
    Note that DPAA PMD can also be executed using images provided
    as part of SDK from NXP. The SDK includes all the above prerequisites
@@ -96,7 +96,7 @@ separately:
   SDK and related information can be obtained from:  `NXP QorIQ SDK  <http://www.nxp.com/products/software-and-tools/run-time-software/linux-sdk/linux-sdk-for-qoriq-processors:SDKLINUX>`_.
 
 
-.. _extra_scripts:
+.. _dpaa_extra_scripts:
 
 - **DPDK Extra Scripts**
 
diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index 611d9bec19..81924ee7ea 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -433,7 +433,7 @@ Run as Non-Root
 ^^^^^^^^^^^^^^^
 
 Hugepage and resource limit setup are documented
-in the :ref:`common Linux guide <Running_Without_Root_Privileges>`.
+in the :ref:`common Linux guide <linux_gsg_running_without_root_privileges>`.
 This PMD can operate without access to physical addresses,
 therefore it does not require ``SYS_ADMIN`` to access ``/proc/self/pagemaps``.
 Note that this requirement may still come from other drivers.
diff --git a/doc/guides/platform/octeontx.rst b/doc/guides/platform/octeontx.rst
index f266f81f4e..7015050b31 100644
--- a/doc/guides/platform/octeontx.rst
+++ b/doc/guides/platform/octeontx.rst
@@ -43,7 +43,7 @@ OCTEON TX compatible board:
 
       The PF driver and the required microcode for the crypto offload block will be
       available with OCTEON TX SDK only. So for using crypto offload, follow the steps
-      mentioned in :ref:`setup_platform_using_OCTEON_TX_SDK`.
+      mentioned in :ref:`octeontx_setup_platform_using_octeon_tx_sdk`.
 
 #. **ARM64 Tool Chain**
 
@@ -58,11 +58,12 @@ OCTEON TX compatible board:
 
    As an alternative method, Platform drivers can also be executed using images provided
    as part of SDK from Cavium. The SDK includes all the above prerequisites necessary
-   to bring up a OCTEON TX board. Please refer :ref:`setup_platform_using_OCTEON_TX_SDK`.
+   to bring up a OCTEON TX board.
+   Please refer :ref:`octeontx_setup_platform_using_octeon_tx_sdk`.
 
 #. Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
-.. _setup_platform_using_OCTEON_TX_SDK:
+.. _octeontx_setup_platform_using_octeon_tx_sdk:
 
 Setup Platform Using OCTEON TX SDK
 ----------------------------------
diff --git a/doc/guides/prog_guide/bbdev.rst b/doc/guides/prog_guide/bbdev.rst
index 6fd849436d..dc1e2b7c7f 100644
--- a/doc/guides/prog_guide/bbdev.rst
+++ b/doc/guides/prog_guide/bbdev.rst
@@ -641,7 +641,7 @@ is 1. Therefore, it requires to get processed in TB-mode.
 The figure below visualizes the encoding of CBs using BBDEV interface in
 TB-mode. CB-mode is a reduced version, where only one CB exists:
 
-.. _figure_turbo_tb_encode:
+.. _bbdev_figure_turbo_tb_encode:
 
 .. figure:: img/turbo_tb_encode.*
 
@@ -733,7 +733,7 @@ with enough room for the output data.
 The figure below visualizes the decoding of CBs using BBDEV interface in
 TB-mode. CB-mode is a reduced version, where only one CB exists:
 
-.. _figure_turbo_tb_decode:
+.. _bbdev_figure_turbo_tb_decode:
 
 .. figure:: img/turbo_tb_decode.*
 
@@ -878,7 +878,7 @@ calculated by BBDEV before signalling to the driver.
 The number of CBs in the group should not be confused with ``c``, the
 total number of CBs in the full TB (``C`` as per 3GPP TS 38.212 section 5.2.2)
 
-Figure :numref:`figure_turbo_tb_encode` above
+Figure :numref:`bbdev_figure_turbo_tb_encode` above
 showing the Turbo encoding of CBs using BBDEV interface in TB-mode
 is also valid for LDPC encode.
 
@@ -1112,7 +1112,7 @@ total number of CBs in the full TB (``C`` as per 3GPP TS 38.212 section 5.2.2)
 The ``length`` is total size of the CBs inclusive of any CRC24A and CRC24B in
 case they were appended by the application.
 
-Figure :numref:`figure_turbo_tb_decode` above
+Figure :numref:`bbdev_figure_turbo_tb_decode` above
 showing the Turbo decoding of CBs using BBDEV interface in TB-mode
 is also valid for LDPC decode.
 
diff --git a/doc/guides/prog_guide/efd_lib.rst b/doc/guides/prog_guide/efd_lib.rst
index b6296961db..df91c62a85 100644
--- a/doc/guides/prog_guide/efd_lib.rst
+++ b/doc/guides/prog_guide/efd_lib.rst
@@ -42,26 +42,26 @@ function can be used to direct a certain flow to a target based on
 the flow key (e.g. ``h(key) mod n``) where h(key) is the hash value of the
 flow key and n is the number of possible targets.
 
-.. _figure_efd1:
+.. _efd_figure_1:
 
 .. figure:: img/efd_i1.*
 
   Load Balancing Using Front End Node
 
-In this scheme (:numref:`figure_efd1`), the front end server/distributor/load balancer
+In this scheme (:numref:`efd_figure_1`), the front end server/distributor/load balancer
 extracts the flow key from the input packet and applies a computation to determine where
 this flow should be directed. Intuitively, this scheme is very simple
 and requires no state to be kept at the front end node, and hence,
 storage requirements are minimum.
 
-.. _figure_efd2:
+.. _efd_figure_2:
 
 .. figure:: img/efd_i2.*
 
   Consistent Hashing
 
 A widely used flow distributor that belongs to the same category of
-computation-based schemes is ``consistent hashing``, shown in :numref:`figure_efd2`.
+computation-based schemes is ``consistent hashing``, shown in :numref:`efd_figure_2`.
 Target destinations (shown in red) are hashed into the same space as the flow
 keys (shown in blue), and keys are mapped to the nearest target in a clockwise
 fashion. Dynamically adding and removing targets with consistent hashing
@@ -87,13 +87,13 @@ has the flexibility of assigning a given flow to any given
 target. The flow table (e.g. DPDK RTE Hash Library) will simply store
 both the flow key and the target value.
 
-.. _figure_efd3:
+.. _efd_figure_3:
 
 .. figure:: img/efd_i3.*
 
   Table Based Flow Distribution
 
-As shown in :numref:`figure_efd3`, when doing a lookup, the flow-table
+As shown in :numref:`efd_figure_3`, when doing a lookup, the flow-table
 is indexed with the hash of the flow key and the keys (more than one is possible,
 because of hash collision) stored in this index and corresponding values
 are retrieved. The retrieved key(s) is matched with the input flow key
@@ -114,7 +114,7 @@ schemes. It doesn't require the large storage necessary for
 flow-table based schemes (because EFD doesn't store the key as explained
 below), and it supports any arbitrary value for any given key.
 
-.. _figure_efd4:
+.. _efd_figure_4:
 
 .. figure:: img/efd_i4.*
 
@@ -122,7 +122,7 @@ below), and it supports any arbitrary value for any given key.
 
 The basic idea of EFD is when a given key is to be inserted, a family of
 hash functions is searched until the correct hash function that maps the
-input key to the correct value is found, as shown in :numref:`figure_efd4`.
+input key to the correct value is found, as shown in :numref:`efd_figure_4`.
 However, rather than explicitly storing all keys and their associated values,
 EFD stores only indices of hash functions that map keys to values, and
 thereby consumes much less space than conventional flow-based tables.
@@ -130,7 +130,7 @@ The lookup operation is very simple, similar to a computational-based
 scheme: given an input key the lookup operation is reduced to hashing
 that key with the correct hash function.
 
-.. _figure_efd5:
+.. _efd_figure_5:
 
 .. figure:: img/efd_i5.*
 
@@ -138,7 +138,7 @@ that key with the correct hash function.
 
 Intuitively, finding a hash function that maps each of a large number
 (millions) of input keys to the correct output value is effectively
-impossible, as a result EFD, as shown in :numref:`figure_efd5`,
+impossible, as a result EFD, as shown in :numref:`efd_figure_5`,
 breaks the problem into smaller pieces (divide and conquer).
 EFD divides the entire input key set into many small groups.
 Each group consists of approximately 20-28 keys (a configurable parameter
@@ -162,7 +162,7 @@ Example of EFD Library Usage
 EFD can be used along the data path of many network functions and middleboxes.
 As previously mentioned, it can used as an index table for
 <key,value> pairs, meta-data for objects, a flow-level load balancer, etc.
-:numref:`figure_efd6` shows an example of using EFD as a flow-level load
+:numref:`efd_figure_6` shows an example of using EFD as a flow-level load
 balancer, where flows are received at a front end server before being forwarded
 to the target back end server for processing. The system designer would
 deterministically co-locate flows together in order to minimize cross-server
@@ -170,13 +170,13 @@ interaction.
 (For example, flows requesting certain webpage objects are co-located
 together, to minimize forwarding of common objects across servers).
 
-.. _figure_efd6:
+.. _efd_figure_6:
 
 .. figure:: img/efd_i6.*
 
   EFD as a Flow-Level Load Balancer
 
-As shown in :numref:`figure_efd6`, the front end server will have an EFD table that
+As shown in :numref:`efd_figure_6`, the front end server will have an EFD table that
 stores for each group what is the perfect hash index that satisfies the
 correct output. Because the table size is small and fits in cache (since
 keys are not stored), it sustains a large number of flows (N*X, where N
@@ -307,30 +307,30 @@ stores two version of the <key,value> table:
    the online version, as previously mentioned, the keys are not stored
    but rather only the hash index for each group.
 
-.. _figure_efd7:
+.. _efd_figure_7:
 
 .. figure:: img/efd_i7.*
 
   Group Assignment
 
-:numref:`figure_efd7` depicts the group assignment for 7 flow keys as an example.
+:numref:`efd_figure_7` depicts the group assignment for 7 flow keys as an example.
 Given a flow key, a hash function (in our implementation CRC hash) is
 used to get the group id. As shown in the figure, the groups can be
 unbalanced. (We highlight group rebalancing further below).
 
-.. _figure_efd8:
+.. _efd_figure_8:
 
 .. figure:: img/efd_i8.*
 
   Perfect Hash Search - Assigned Keys & Target Value
 
-Focusing on one group that has four keys, :numref:`figure_efd8` depicts the search
+Focusing on one group that has four keys, :numref:`efd_figure_8` depicts the search
 algorithm to find the perfect hash function. Assuming that the target
 value bit for the keys is as shown in the figure, then the online EFD
 table will store a 16 bit hash index and 16 bit lookup table per group
 per value bit.
 
-.. _figure_efd9:
+.. _efd_figure_9:
 
 .. figure:: img/efd_i9.*
 
@@ -338,11 +338,11 @@ per value bit.
 
 For a given keyX, a hash function ``(h(keyX, seed1) + index * h(keyX, seed2))``
 is used to point to certain bit index in the 16bit lookup_table value,
-as shown in :numref:`figure_efd9`.
+as shown in :numref:`efd_figure_9`.
 The insert function will brute force search for all possible values for the
 hash index until a non conflicting lookup_table is found.
 
-.. _figure_efd10:
+.. _efd_figure_10:
 
 .. figure:: img/efd_i10.*
 
@@ -352,7 +352,7 @@ For example, since both key3 and key7 have a target bit value of 1, it
 is okay if the hash function of both keys point to the same bit in the
 lookup table. A conflict will occur if a hash index is used that maps
 both Key4 and Key7 to the same index in the lookup_table,
-as shown in :numref:`figure_efd10`, since their target value bit are not the same.
+as shown in :numref:`efd_figure_10`, since their target value bit are not the same.
 Once a hash index is found that produces a lookup_table with no
 contradictions, this index is stored for this group. This procedure is
 repeated for each bit of target value.
@@ -365,13 +365,13 @@ inserts, and hence, EFD's design optimizes for the lookups which are
 faster and much simpler than the slower insert procedure (inserts are
 slow, because of perfect hash search as previously discussed).
 
-.. _figure_efd11:
+.. _efd_figure_11:
 
 .. figure:: img/efd_i11.*
 
   EFD Lookup Operation
 
-:numref:`figure_efd11` depicts the lookup operation for EFD. Given an input key,
+:numref:`efd_figure_11` depicts the lookup operation for EFD. Given an input key,
 the group id is computed (using CRC hash) and then the hash index for this
 group is retrieved from the EFD table. Using the retrieved hash index,
 the hash function ``h(key, seed1) + index *h(key, seed2)`` is used which will
@@ -394,17 +394,17 @@ index. In order to achieve this target, groups are rebalanced during
 runtime inserts, and keys are moved around from a busy group to a less
 crowded group as the more keys are inserted.
 
-.. _figure_efd12:
+.. _efd_figure_12:
 
 .. figure:: img/efd_i12.*
 
   Runtime Group Rebalancing
 
-:numref:`figure_efd12` depicts the high level idea of group rebalancing, given an
+:numref:`efd_figure_12` depicts the high level idea of group rebalancing, given an
 input key the hash result is split into two parts a chunk id and 8-bit
 bin id. A chunk contains 64 different groups and 256 bins (i.e. for any
 given bin it can map to 4 distinct groups). When a key is inserted, the
-bin id is computed, for example in :numref:`figure_efd12` bin_id=2,
+bin id is computed, for example in :numref:`efd_figure_12` bin_id=2,
 and since each bin can be mapped to one of four different groups (2 bit storage),
 the four possible mappings are evaluated and the one that will result in a
 balanced key distribution across these four is selected the mapping result
diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index f63325bd24..f8d172097b 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -241,7 +241,7 @@ Multiple page sizes can be specified by repeating the option::
     can later be mapped into that preallocated VA space (if dynamic memory mode
     is enabled), and can optionally be mapped into it at startup.
 
-.. _hugepage_mapping:
+.. _eal_hugepage_mapping:
 
 Hugepage Mapping
 ^^^^^^^^^^^^^^^^
@@ -277,7 +277,7 @@ that share a hugetlbfs mount point.
 Each backing file by default corresponds to one hugepage,
 it is opened and locked for the entire time the hugepage is used.
 This may exhaust the number of open files limit (``NOFILE``).
-See :ref:`segment-file-descriptors` section
+See :ref:`eal_segment_file_descriptors` section
 on how the number of open backing file descriptors can be reduced.
 
 In dynamic memory mode, EAL removes a backing hugepage file
@@ -291,7 +291,7 @@ if ``--huge-unlink`` is given to avoid polluting hugetlbfs.
 However, since it disables multi-process anyway,
 using anonymous mapping (``--in-memory``) is recommended instead.
 
-:ref:`EAL memory allocator <malloc>` relies on hugepages being zero-filled.
+:ref:`EAL memory allocator <eal_malloc>` relies on hugepages being zero-filled.
 Hugepages are cleared by the kernel when a file in hugetlbfs or its part
 is mapped for the first time system-wide
 to prevent data leaks from previous users of the same hugepage.
@@ -320,10 +320,10 @@ DPDK memory manager can provide file descriptors for memory segments,
 which are required for VirtIO with vhost-user backend.
 This can exhaust the number of open files limit (``NOFILE``)
 despite not creating any visible files.
-See :ref:`segment-file-descriptors` section
+See :ref:`eal_segment_file_descriptors` section
 on how the number of open file descriptors used by EAL can be reduced.
 
-.. _segment-file-descriptors:
+.. _eal_segment_file_descriptors:
 
 Segment File Descriptors
 ^^^^^^^^^^^^^^^^^^^^^^^^
@@ -663,7 +663,7 @@ the desired addressing mode when virtual devices that are not directly attached
 To facilitate forcing the IOVA mode to a specific value the EAL command line option ``--iova-mode`` can
 be used to select either physical addressing('pa') or virtual addressing('va').
 
-.. _max_simd_bitwidth:
+.. _eal_max_simd_bitwidth:
 
 
 Max SIMD bitwidth
@@ -782,7 +782,7 @@ There are two kinds of non-EAL pthreads:
 
 For non registered non-EAL pthread (with a LCORE_ID_ANY *_lcore_id*), some libraries will use an alternative unique ID (e.g. TID), some will not be impacted at all, and some will work but with limitations (e.g. timer and mempool libraries).
 
-All these impacts are mentioned in :ref:`known_issue_label` section.
+All these impacts are mentioned in :ref:`eal_known_issue_label` section.
 
 Public Thread API
 ~~~~~~~~~~~~~~~~~
@@ -819,7 +819,7 @@ controlled with tools like taskset (Linux) or cpuset (FreeBSD),
 - with affinity restricted to 2-3, the Control Threads will end up on
   CPU 2 (main lcore, which is the default when no CPU is available).
 
-.. _known_issue_label:
+.. _eal_known_issue_label:
 
 Known Issues
 ~~~~~~~~~~~~
@@ -977,7 +977,7 @@ We expect only 50% of CPU spend on packet IO.
     echo 100000 > pkt_io/cpu.cfs_period_us
     echo  50000 > pkt_io/cpu.cfs_quota_us
 
-.. _malloc:
+.. _eal_malloc:
 
 Malloc
 ------
@@ -1061,7 +1061,7 @@ The key fields of the heap structure and their function are described below
    Example of a malloc heap and malloc elements within the malloc library
 
 
-.. _malloc_elem:
+.. _eal_malloc_elem:
 
 Structure: malloc_elem
 """"""""""""""""""""""
@@ -1142,7 +1142,7 @@ Memory Allocation
 ^^^^^^^^^^^^^^^^^
 
 On EAL initialization, all preallocated memory segments are setup as part of the
-malloc heap. This setup involves placing an :ref:`element header<malloc_elem>`
+malloc heap. This setup involves placing an :ref:`element header <eal_malloc_elem>`
 with ``FREE`` at the start of each virtually contiguous segment of memory.
 The ``FREE`` element is then added to the ``free_list`` for the malloc heap.
 
diff --git a/doc/guides/prog_guide/ethdev/qos_framework.rst b/doc/guides/prog_guide/ethdev/qos_framework.rst
index fcefa9d481..ef48b2a1b1 100644
--- a/doc/guides/prog_guide/ethdev/qos_framework.rst
+++ b/doc/guides/prog_guide/ethdev/qos_framework.rst
@@ -118,7 +118,7 @@ See `Worst Case Scenarios for Performance`_ for a more detailed discussion.
 Scheduling Hierarchy
 ~~~~~~~~~~~~~~~~~~~~
 
-The scheduling hierarchy is shown in :numref:`figure_sched_hier_per_port`.
+The scheduling hierarchy is shown in :numref:`qos_figure_sched_hier_per_port`.
 The first level of the hierarchy is the Ethernet TX port 1/10/40 GbE,
 with subsequent hierarchy levels defined as subport, pipe, traffic class and queue.
 
@@ -127,7 +127,7 @@ Each traffic class is the representation of a different traffic type with specif
 delay and jitter requirements, such as voice, video or data transfers.
 Each queue hosts packets from one or multiple connections of the same type belonging to the same user.
 
-.. _figure_sched_hier_per_port:
+.. _qos_figure_sched_hier_per_port:
 
 .. figure:: ../img/sched_hier_per_port.*
 
@@ -394,10 +394,10 @@ the processor should not attempt to access the data structure currently under pr
 The only other work available is to execute different stages of the enqueue sequence of operations on other input packets,
 thus resulting in a pipelined implementation for the enqueue operation.
 
-:numref:`figure_prefetch_pipeline` illustrates a pipelined implementation for the enqueue operation with 4 pipeline stages and each stage executing 2 different input packets.
+:numref:`qos_figure_prefetch_pipeline` illustrates a pipelined implementation for the enqueue operation with 4 pipeline stages and each stage executing 2 different input packets.
 No input packet can be part of more than one pipeline stage at a given time.
 
-.. _figure_prefetch_pipeline:
+.. _qos_figure_prefetch_pipeline:
 
 .. figure:: ../img/prefetch_pipeline.*
 
@@ -570,9 +570,9 @@ Traffic Shaping
 The traffic shaping for subport and pipe is implemented using a token bucket per subport/per pipe.
 Each token bucket is implemented using one saturated counter that keeps track of the number of available credits.
 
-The token bucket generic parameters and operations are presented in :numref:`table_qos_6` and :numref:`table_qos_7`.
+The token bucket generic parameters and operations are presented in :numref:`qos_table_6` and :numref:`qos_table_7`.
 
-.. _table_qos_6:
+.. _qos_table_6:
 
 .. table:: Token Bucket Generic Parameters
 
@@ -587,7 +587,7 @@ The token bucket generic parameters and operations are presented in :numref:`tab
    |   |                        |                    |                                                         |
    +---+------------------------+--------------------+---------------------------------------------------------+
 
-.. _table_qos_7:
+.. _qos_table_7:
 
 .. table:: Token Bucket Generic Operations
 
@@ -612,10 +612,10 @@ The token bucket generic parameters and operations are presented in :numref:`tab
    +---+------------------------+------------------------------------------------------------------------------+
 
 To implement the token bucket generic operations described above,
-the current design uses the persistent data structure presented in :numref:`table_qos_8`,
-while the implementation of the token bucket operations is described in :numref:`table_qos_9`.
+the current design uses the persistent data structure presented in :numref:`qos_table_8`,
+while the implementation of the token bucket operations is described in :numref:`qos_table_9`.
 
-.. _table_qos_8:
+.. _qos_table_8:
 
 .. table:: Token Bucket Persistent Data Structure
 
@@ -651,7 +651,7 @@ The bucket rate (in bytes per second) can be computed with the following formula
 
 where, r = port line rate (in bytes per second).
 
-.. _table_qos_9:
+.. _qos_table_9:
 
 .. table:: Token Bucket Operations
 
@@ -732,9 +732,9 @@ so there is no token bucket maintained in this context.
 The upper limit for the traffic classes at the subport and
 pipe levels is enforced by periodically refilling the subport / pipe traffic class credit counter,
 out of which credits are consumed every time a packet is scheduled for that subport / pipe,
-as described in :numref:`table_qos_10` and :numref:`table_qos_11`.
+as described in :numref:`qos_table_10` and :numref:`qos_table_11`.
 
-.. _table_qos_10:
+.. _qos_table_10:
 
 .. table:: Subport/Pipe Traffic Class Upper Limit Enforcement Persistent Data Structure
 
@@ -764,7 +764,7 @@ as described in :numref:`table_qos_10` and :numref:`table_qos_11`.
    |   |                       |       |                                                                       |
    +---+-----------------------+-------+-----------------------------------------------------------------------+
 
-.. _table_qos_11:
+.. _qos_table_11:
 
 .. table:: Subport/Pipe Traffic Class Upper Limit Enforcement Operations
 
@@ -804,9 +804,9 @@ as described in :numref:`table_qos_10` and :numref:`table_qos_11`.
 Weighted Round Robin (WRR)
 """"""""""""""""""""""""""
 
-The evolution of the WRR design solution for the lowest priority traffic class (best effort TC) from simple to complex is shown in :numref:`table_qos_12`.
+The evolution of the WRR design solution for the lowest priority traffic class (best effort TC) from simple to complex is shown in :numref:`qos_table_12`.
 
-.. _table_qos_12:
+.. _qos_table_12:
 
 .. table:: Weighted Round Robin (WRR)
 
@@ -995,9 +995,9 @@ as a result of demand increase (when the watermark needs to be lowered) or deman
 
 When demand is low, the watermark is set high to prevent it from impeding the subport member pipes from consuming more bandwidth.
 The highest value for the watermark is picked as the highest rate configured for a subport member pipe.
-:numref:`table_qos_14` and :numref:`table_qos_15` illustrates the watermark operation.
+:numref:`qos_table_14` and :numref:`qos_table_15` illustrates the watermark operation.
 
-.. _table_qos_14:
+.. _qos_table_14:
 
 .. table:: Watermark Propagation from Subport Level to Member Pipes at the Beginning of Each Traffic Class Upper Limit Enforcement Period
 
@@ -1048,7 +1048,7 @@ The highest value for the watermark is picked as the highest rate configured for
    |     |                                 |                                                    |
    +-----+---------------------------------+----------------------------------------------------+
 
-.. _table_qos_15:
+.. _qos_table_15:
 
 .. table:: Watermark Calculation
 
@@ -1137,7 +1137,7 @@ If the number of queues is small,
 then the performance of the port scheduler for the same level of active traffic is expected to be worse than
 the performance of a small set of message passing queues.
 
-.. _Droppers:
+.. _qos_droppers:
 
 Droppers
 --------
@@ -1145,11 +1145,11 @@ Droppers
 The purpose of the DPDK dropper is to drop packets arriving at a packet scheduler to avoid congestion.
 The dropper supports the Proportional Integral Controller Enhanced (PIE), Random Early Detection (RED),
 Weighted Random Early Detection (WRED), and tail drop algorithms.
-:numref:`figure_blk_diag_dropper` illustrates how the dropper integrates with the scheduler.
+:numref:`qos_figure_blk_diag_dropper` illustrates how the dropper integrates with the scheduler.
 The DPDK currently does not support congestion management
 so the dropper provides the only method for congestion avoidance.
 
-.. _figure_blk_diag_dropper:
+.. _qos_figure_blk_diag_dropper:
 
 .. figure:: ../img/blk_diag_dropper.*
 
@@ -1177,10 +1177,10 @@ In the case of severe congestion, the dropper resorts to tail drop.
 This occurs when a packet queue has reached maximum capacity and cannot store any more packets.
 In this situation, all arriving packets are dropped.
 
-The flow through the dropper is illustrated in :numref:`figure_flow_tru_dropper`,
+The flow through the dropper is illustrated in :numref:`qos_figure_flow_tru_dropper`,
 The RED/WRED/PIE algorithm is exercised first and tail drop second.
 
-.. _figure_flow_tru_dropper:
+.. _qos_figure_flow_tru_dropper:
 
 .. figure:: ../img/flow_tru_dropper.*
 
@@ -1207,18 +1207,18 @@ The use cases supported by the dropper are:
 
 *   *    Mark empty (record the time at which a packet queue becomes empty)
 
-The configuration use case is explained in :ref:`Configuration`,
-the enqueue operation is explained in :ref:`Enqueue_Operation`
-and the mark empty operation is explained in :ref:`Queue_Empty_Operation`.
+The configuration use case is explained in :ref:`qos_dropper_configuration`,
+the enqueue operation is explained in  :ref:`qos_dropper_enqueue_operation`
+and the mark empty operation is explained in :ref:`qos_dropper_queue_empty_operation`.
 
-.. _Configuration:
+.. _qos_dropper_configuration:
 
 Configuration
 ~~~~~~~~~~~~~
 
-A RED configuration contains the parameters given in :numref:`table_qos_16`.
+A RED configuration contains the parameters given in :numref:`qos_table_16`.
 
-.. _table_qos_16:
+.. _qos_table_16:
 
 .. table:: RED Configuration Parameters
 
@@ -1249,9 +1249,9 @@ to a mark probability of 1/10 (that is, 1 in 10 packets will be dropped).
 The EWMA filter weight parameter is specified as an inverse log value,
 for example, a filter weight parameter value of 9 corresponds to a filter weight of 1/29.
 
-A PIE configuration contains the parameters given in :numref:`table_qos_16a`.
+A PIE configuration contains the parameters given in :numref:`qos_table_16a`.
 
-.. _table_qos_16a:
+.. _qos_table_16a:
 
 .. table:: PIE Configuration Parameters
 
@@ -1279,16 +1279,16 @@ The format of these parameters is specified to the dropper module API
 and can be fine-tuned within applications.
 They could be made self-calculated for fine tuning within the apps.
 
-.. _Enqueue_Operation:
+.. _qos_dropper_enqueue_operation:
 
 Enqueue Operation
 ~~~~~~~~~~~~~~~~~
 
-In the example shown in :numref:`figure_ex_data_flow_tru_dropper`, q (actual queue size) is the input value,
+In the example shown in :numref:`qos_figure_ex_data_flow_tru_dropper`, q (actual queue size) is the input value,
 avg (average queue size) and count (number of packets since the last drop) are run-time values,
 decision is the output value and the remaining values are configuration parameters.
 
-.. _figure_ex_data_flow_tru_dropper:
+.. _qos_figure_ex_data_flow_tru_dropper:
 
 .. figure:: ../img/ex_data_flow_tru_dropper.*
 
@@ -1324,7 +1324,7 @@ Where:
 .. note::
 
    The filter weight, wq = 1/2^n, where n is the filter weight parameter value
-   passed to the dropper module on configuration (see :ref:`Configuration`).
+   passed to the dropper module on configuration (see :ref:`qos_dropper_configuration`).
 
 Average Queue Size Calculation when the Queue is Empty
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -1414,10 +1414,10 @@ The method described in the :ref:`implementation section <qos_dropper_implementa
 outperforms all of these approaches
 in terms of run-time performance and memory requirements and
 also achieves accuracy comparable to floating-point evaluation.
-:numref:`table_qos_17` lists the performance of each of these alternative approaches relative to the method that is used in the dropper.
+:numref:`qos_table_17` lists the performance of each of these alternative approaches relative to the method that is used in the dropper.
 As can be seen, the floating-point implementation achieved the worst performance.
 
-.. _table_qos_17:
+.. _qos_table_17:
 
 .. table:: Relative Performance of Alternative Approaches
 
@@ -1425,7 +1425,7 @@ As can be seen, the floating-point implementation achieved the worst performance
    | Method                                                                             | Relative Performance |
    |                                                                                    |                      |
    +====================================================================================+======================+
-   | Current dropper method (see :ref:`Droppers`)                                       | 100%                 |
+   | Current dropper method (see :ref:`qos_droppers`)                                   | 100%                 |
    |                                                                                    |                      |
    +------------------------------------------------------------------------------------+----------------------+
    | Fixed-point method with small (512B) look-up table                                 | 148%                 |
@@ -1481,13 +1481,13 @@ Where:
 
 *   *maxth*  = maximum threshold
 
-The calculation of the packet drop probability using Equation 3 is illustrated in :numref:`figure_pkt_drop_probability`.
+The calculation of the packet drop probability using Equation 3 is illustrated in :numref:`qos_figure_pkt_drop_probability`.
 If the average queue size is below the minimum threshold, an arriving packet is enqueued.
 If the average queue size is at or above the maximum threshold, an arriving packet is dropped.
 If the average queue size is between the minimum and maximum thresholds,
 a drop probability is calculated to determine if the packet should be enqueued or dropped.
 
-.. _figure_pkt_drop_probability:
+.. _qos_figure_pkt_drop_probability:
 
 .. figure:: ../img/pkt_drop_probability.*
 
@@ -1513,7 +1513,7 @@ given in the reference document where a value of 1 is used instead.
 It should be noted that the value pa computed from can be negative or greater than 1.
 If this is the case, then a value of 1 should be used instead.
 
-The initial and actual drop probabilities are shown in :numref:`figure_drop_probability_graph`.
+The initial and actual drop probabilities are shown in :numref:`qos_figure_drop_probability_graph`.
 The actual drop probability is shown for the case where
 the formula given in the reference document1 is used (blue curve)
 and also for the case where the formula implemented in the dropper module,
@@ -1523,7 +1523,7 @@ compared to the mark probability configuration parameter specified by the user.
 The choice to deviate from the reference document is simply a design decision and
 one that has been taken by other RED implementations, for example, FreeBSD* ALTQ RED.
 
-.. _figure_drop_probability_graph:
+.. _qos_figure_drop_probability_graph:
 
 .. figure:: ../img/drop_probability_graph.*
 
@@ -1531,7 +1531,7 @@ one that has been taken by other RED implementations, for example, FreeBSD* ALTQ
    a Factor 1 (Blue Curve) and a Factor 2 (Red Curve)
 
 
-.. _Queue_Empty_Operation:
+.. _qos_dropper_queue_empty_operation:
 
 Queue Empty Operation
 ~~~~~~~~~~~~~~~~~~~~~
@@ -1565,7 +1565,7 @@ Integration with the DPDK QoS Scheduler Sample Application
 
 The DPDK QoS Scheduler Application reads a configuration file on start-up.
 The configuration file includes a section containing RED parameters.
-The format of these parameters is described in :ref:`Configuration`.
+The format of these parameters is described in :ref:`qos_dropper_configuration`.
 A sample RED configuration is shown below. In this example, the queue size is 64 packets.
 
 .. note::
@@ -1645,9 +1645,9 @@ A sample RED configuration is shown below. In this example, the queue size is 64
    tc 12 wred weight = 9 9 9
 
 With this configuration file, the RED configuration that applies to green,
-yellow and red packets in traffic class 0 is shown in :numref:`table_qos_18`.
+yellow and red packets in traffic class 0 is shown in :numref:`qos_table_18`.
 
-.. _table_qos_18:
+.. _qos_table_18:
 
 .. table:: RED Configuration Corresponding to RED Configuration File
 
diff --git a/doc/guides/prog_guide/ethdev/traffic_metering_and_policing.rst b/doc/guides/prog_guide/ethdev/traffic_metering_and_policing.rst
index de8d643fb1..50ae832f61 100644
--- a/doc/guides/prog_guide/ethdev/traffic_metering_and_policing.rst
+++ b/doc/guides/prog_guide/ethdev/traffic_metering_and_policing.rst
@@ -72,7 +72,7 @@ The processing done for each input packet hitting an MTR object is:
 API walk-through
 ----------------
 
-.. _figure_rte_mtr_chaining:
+.. _mtr_figure_chaining:
 
 .. figure:: ../img/rte_mtr_meter_chaining.*
 
@@ -107,7 +107,7 @@ traffic meter and policing library.
 
    * Adding one (or multiple) actions of the type ``RTE_FLOW_ACTION_TYPE_METER``
      to the list of meter actions (``struct rte_mtr_meter_policy_params::actions``)
-     specified per color as shown in :numref:`figure_rte_mtr_chaining`.
+     specified per color as shown in :numref:`mtr_figure_chaining`.
 
 #. The ``rte_mtr_meter_profile_get()`` and ``rte_mtr_meter_policy_get()``
    API functions are available for getting the object pointers directly.
diff --git a/doc/guides/prog_guide/eventdev/dispatcher_lib.rst b/doc/guides/prog_guide/eventdev/dispatcher_lib.rst
index 262343d1bf..265787c569 100644
--- a/doc/guides/prog_guide/eventdev/dispatcher_lib.rst
+++ b/doc/guides/prog_guide/eventdev/dispatcher_lib.rst
@@ -200,7 +200,7 @@ further decouple sub-modules. However, the dispatcher may impose an
 upper limit of the number of handlers. In addition, installing a large
 number of handlers increase dispatcher overhead, although this does
 not necessarily translate to a system-level performance degradation. See
-the section on :ref:`Event Clustering` for more information.
+the section on :ref:`dispatcher_event_clustering` for more information.
 
 Handler registration and unregistration cannot safely be done while
 the dispatcher's service function is running on any lcore.
@@ -242,7 +242,7 @@ until the destination handler for both events have been determined.
 The events provided in a single process call always belong to the same
 event port dequeue burst.
 
-.. _Event Clustering:
+.. _dispatcher_event_clustering:
 
 Event Clustering
 ^^^^^^^^^^^^^^^^
diff --git a/doc/guides/prog_guide/fib_lib.rst b/doc/guides/prog_guide/fib_lib.rst
index ea99670b5a..162ae93ea7 100644
--- a/doc/guides/prog_guide/fib_lib.rst
+++ b/doc/guides/prog_guide/fib_lib.rst
@@ -99,9 +99,9 @@ The main elements of the dataplane struct for the DIR-24-8 algorithm are:
 
 * TBL8: An array of ``num_tbl8`` tbl8 groups.
 
-The lookup algorithms logic can be seen in :numref:`figure_dir_24_8_alg`:
+The lookup algorithms logic can be seen in :numref:`fib_figure_dir_24_8_alg`:
 
-.. _figure_dir_24_8_alg:
+.. _fib_figure_dir_24_8_alg:
 
 .. figure:: img/dir_24_8_alg.*
 
diff --git a/doc/guides/prog_guide/generic_receive_offload_lib.rst b/doc/guides/prog_guide/generic_receive_offload_lib.rst
index f2b5ff9eed..565a630c7f 100644
--- a/doc/guides/prog_guide/generic_receive_offload_lib.rst
+++ b/doc/guides/prog_guide/generic_receive_offload_lib.rst
@@ -109,7 +109,7 @@ In DPDK GRO, we use a key-based algorithm to address the two challenges.
 Key-based Reassembly Algorithm
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-:numref:`figure_gro-key-algorithm` illustrates the procedure of the
+:numref:`gro_figure_key_algorithm` illustrates the procedure of the
 key-based algorithm. Packets are classified into "flows" by some header
 fields (we call them as "key"). To process an input packet, the algorithm
 searches for a matched "flow" (i.e., the same value of key) for the
@@ -131,7 +131,7 @@ The key-based algorithm has two characters:
 - storing out-of-order packets makes it possible to merge later (address
   challenge 2).
 
-.. _figure_gro-key-algorithm:
+.. _gro_figure_key_algorithm:
 
 .. figure:: img/gro-key-algorithm.*
    :align: center
diff --git a/doc/guides/prog_guide/generic_segmentation_offload_lib.rst b/doc/guides/prog_guide/generic_segmentation_offload_lib.rst
index 618297044b..817b18588c 100644
--- a/doc/guides/prog_guide/generic_segmentation_offload_lib.rst
+++ b/doc/guides/prog_guide/generic_segmentation_offload_lib.rst
@@ -91,9 +91,9 @@ original packet.
 
 The combination of the 'header' segment and the 'data' segment constitutes a
 single logical output GSO segment of the original packet. This is illustrated
-in :numref:`figure_gso-output-segment-format`.
+in :numref:`gso_figure_output_segment_format`.
 
-.. _figure_gso-output-segment-format:
+.. _gso_figure_output_segment_format:
 
 .. figure:: img/gso-output-segment-format.*
    :align: center
@@ -126,14 +126,14 @@ all of the data 'contained' in the output segment reaches ``segsz``. This
 ensures that the amount of data contained within each output segment is uniform,
 with the possible exception of the last segment, as previously described.
 
-:numref:`figure_gso-three-seg-mbuf` illustrates an example of a three-part
+:numref:`gso_figure_three_seg_mbuf` illustrates an example of a three-part
 output segment. In this example, the output segment needs to include data from
 the end of one input segment, and the beginning of another. To achieve this,
 an additional indirect mbuf is chained to the second part of the output segment,
 and is attached to the next input segment (i.e. it points to the data in the
 next input segment).
 
-.. _figure_gso-three-seg-mbuf:
+.. _gso_figure_three_seg_mbuf:
 
 .. figure:: img/gso-three-seg-mbuf.*
    :align: center
diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/graph_lib.rst
index f1264fdcb6..03559f3b32 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -418,7 +418,7 @@ Graph feature arc is an abstraction to manage more than one network protocols
    Feature arc abstraction is introduced as an optional functionality
    to the graph library.
    Feature arc is a ``NOP`` to application which skips
-   :ref:`feature arc initialization <Feature_Arc_Initialization>`
+   :ref:`feature arc initialization <graph_feature_arc_initialization>`
 
 Runtime network configurability
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -456,7 +456,7 @@ Feature arc provides application to overload default node path
 by providing hook points (like netfilter)
 to insert out-of-tree or another protocol nodes in packet path.
 
-.. _Control_Data_Plane_Synchronization:
+.. _graph_control_data_plane_synchronization:
 
 Control/Data plane synchronization
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -477,7 +477,7 @@ Furthermore, when IPsec gets disabled for same ``[feature, index]`` in later poi
 cleanup would be required to free resources associated with SA.
 Cleanup can only be done in control thread when it ensures that no worker thread is using the SA.
 For this use case, application can use RCU mechanism provided with enable/disable API.
-See :ref:`notifier_cb <Feature_Notifier_Cb>`.
+See :ref:`notifier_cb <graph_feature_notifier_cb>`.
 
 Objects
 ~~~~~~~
@@ -487,7 +487,7 @@ Feature
 
 Feature is analogous to a protocol.
 
-.. _Feature_Nodes:
+.. _graph_feature_nodes:
 
 Features nodes
 ^^^^^^^^^^^^^^
@@ -498,7 +498,7 @@ and are part of a unique arc.
 
 Not all nodes in graph required to be made feature nodes.
 
-.. _Start_Node:
+.. _graph_start_node:
 
 Start node
 ^^^^^^^^^^
@@ -509,7 +509,7 @@ Each feature arc object has unique ``start node``.
 It can be a new node or any existing node in a graph.
 Start node is not counted as a feature node in an arc.
 
-.. _End_Feature_Node:
+.. _graph_end_feature_node:
 
 End feature node
 ^^^^^^^^^^^^^^^^
@@ -525,7 +525,7 @@ this node does not uses any feature arc fast path API.
 Feature arc
 ^^^^^^^^^^^
 
-.. _Figure_Arc_1:
+.. _graph_figure_arc_1:
 
 .. figure:: img/feature_arc-1.*
    :alt: feature-arc-1
@@ -537,13 +537,13 @@ Feature arc
 An ordered list of feature nodes in a given network layer is called as feature arc.
 It consists of three objects:
 
-- :ref:`Start_Node`
-- :ref:`End_Feature_Node`
-- :ref:`Zero or more feature nodes <Feature_Nodes>`
+- :ref:`graph_start_node`
+- :ref:`graph_end_feature_node`
+- :ref:`Zero or more feature nodes <graph_feature_nodes>`
 
-In order to :ref:`create <Feature_Arc_Registration>` a feature arc object,
+In order to :ref:`create <graph_feature_arc_registration>` a feature arc object,
 only ``start node`` and ``end feature node`` are required.
-Once created, feature nodes can be :ref:`added <Feature_Registration>` to the arc.
+Once created, feature nodes can be :ref:`added <graph_feature_registration>` to the arc.
 
 Feature data
 ^^^^^^^^^^^^
@@ -565,18 +565,18 @@ the feature registration adds provided node to a feature arc object.
    During registration, no memory is allocated associated with any feature arc.
    Actual memory allocation, object creation and connecting of nodes via edges
    corresponding to all registered feature arcs happens as part of
-   :ref:`feature arc initialization <Feature_Arc_Initialization>`.
+   :ref:`feature arc initialization <graph_feature_arc_initialization>`.
 
-.. _Feature_Arc_Registration:
+.. _graph_feature_arc_registration:
 
 Feature arc registration
 ************************
 
 A feature arc object creation require ``feature arc registration``.
 Once registered, feature arc is created as part of
-:ref:`initialization <Feature_Arc_Initialization>`.
+:ref:`initialization <graph_feature_arc_initialization>`.
 A feature arc is registered via ``RTE_GRAPH_FEATURE_ARC_REGISTER()``.
-An arc shown in :ref:`figure <Figure_Arc_1>` can be registered as follows:
+An arc shown in :ref:`figure <graph_figure_arc_1>` can be registered as follows:
 
 .. code-block:: c
 
@@ -608,7 +608,7 @@ An arc shown in :ref:`figure <Figure_Arc_1>` can be registered as follows:
 
    Feature arc can also be created using ``rte_graph_feature_arc_create()`` API as well.
 
-.. _Feature_Registration:
+.. _graph_feature_registration:
 
 Feature registration
 ********************
@@ -618,7 +618,7 @@ which would be added to a unique ``arc``.
 A feature nodes needs to know ``arc name`` to which it wants to connect to.
 Registration happens via ``RTE_GRAPH_FEATURE_REGISTER()``.
 
-A ``Feature-1`` shown in :ref:`figure <Figure_Arc_1>` can be registered as follows:
+A ``Feature-1`` shown in :ref:`figure <graph_figure_arc_1>` can be registered as follows:
 
 .. code-block:: c
 
@@ -645,7 +645,7 @@ A ``Feature-1`` shown in :ref:`figure <Figure_Arc_1>` can be registered as follo
 Advance parameters
 ``````````````````
 
-.. _Figure_Arc_2:
+.. _graph_figure_arc_2:
 
 .. figure:: img/feature_arc-2.*
    :alt: feature-arc-2
@@ -692,7 +692,7 @@ it can be defined as shown above.
 Similarly, if ``Feature-2`` needs to run before ``Custom-Feature`` but after ``Feature-1``,
 it can be done as shown above.
 
-.. _Feature_Notifier_Cb:
+.. _graph_feature_notifier_cb:
 
 notifier_cb()
 .............
@@ -713,14 +713,14 @@ Application also needs to call ``rte_rcu_qsbr_quiescent()`` in worker thread
 override_index_cb()
 ....................
 
-A feature arc is :ref:`registered <Feature_Arc_Registration>`
+A feature arc is :ref:`registered <graph_feature_arc_registration>`
 to operate on certain number of ``max_indexes``.
 If particular feature like to overload this ``max_indexes``
 with a larger value, it can do so by returning larger value in this callback.
 In case of multiple features, largest value returned by any feature
 would be selected for creating feature arc.
 
-.. _Feature_Arc_Initialization:
+.. _graph_feature_arc_initialization:
 
 Initializing Feature arc
 ^^^^^^^^^^^^^^^^^^^^^^^^
@@ -774,8 +774,8 @@ using ``rte_graph_feature_enable()`` and ``rte_graph_feature_disable()`` functio
 .. note::
 
    RCU argument is optional argument to enable/disable API.
-   See :ref:`Control_Data_Plane_Synchronization`
-   and :ref:`notifier_cb <Feature_Notifier_Cb>` for more details on when RCU is needed.
+   See :ref:`graph_control_data_plane_synchronization`
+   and :ref:`notifier_cb <graph_feature_notifier_cb>` for more details on when RCU is needed.
 
 Fast path traversal rules
 ^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -783,7 +783,7 @@ Fast path traversal rules
 ``Start node``
 **************
 
-If feature arc is :ref:`initialized <Feature_Arc_Initialization>`,
+If feature arc is :ref:`initialized <graph_feature_arc_initialization>`,
 ``start_node_feature_process_fn()`` will be called by ``rte_graph_walk()``
 instead of node's original ``process()``.
 This function should allow packets to enter arc path
@@ -845,7 +845,7 @@ whenever any feature is enabled at runtime.
 *****************
 
 Following code-snippet explains fast path traversal rule for ``Feature-1``
-:ref:`Feature_Nodes` shown in :ref:`figure <Figure_Arc_2>`.
+:ref:`graph_feature_nodes` shown in :ref:`figure <graph_figure_arc_2>`.
 
 .. code-block:: c
 
diff --git a/doc/guides/prog_guide/mbuf_lib.rst b/doc/guides/prog_guide/mbuf_lib.rst
index 8c4c038cbf..a7278a0b63 100644
--- a/doc/guides/prog_guide/mbuf_lib.rst
+++ b/doc/guides/prog_guide/mbuf_lib.rst
@@ -42,16 +42,16 @@ Message buffers may be used to carry control information, packets, events,
 and so on between different entities in the system.
 Message buffers may also use their buffer pointers to point to other message buffer data sections or other structures.
 
-:numref:`figure_mbuf1` and :numref:`figure_mbuf2` show some of these scenarios.
+:numref:`mbuf_figure_1` and :numref:`mbuf_figure_2` show some of these scenarios.
 
-.. _figure_mbuf1:
+.. _mbuf_figure_1:
 
 .. figure:: img/mbuf1.*
 
    An mbuf with One Segment
 
 
-.. _figure_mbuf2:
+.. _mbuf_figure_2:
 
 .. figure:: img/mbuf2.*
 
diff --git a/doc/guides/prog_guide/mempool_lib.rst b/doc/guides/prog_guide/mempool_lib.rst
index 9bbe829411..7d8fb27b01 100644
--- a/doc/guides/prog_guide/mempool_lib.rst
+++ b/doc/guides/prog_guide/mempool_lib.rst
@@ -47,9 +47,9 @@ When running an application, the EAL command line options provide the ability to
 
 
 Examples of alignment for different DIMM architectures are shown in
-:numref:`figure_memory-management` and :numref:`figure_memory-management2`.
+:numref:`mempool_figure_memory_management` and :numref:`mempool_figure_memory_management2`.
 
-.. _figure_memory-management:
+.. _mempool_figure_memory_management:
 
 .. figure:: img/memory-management.*
 
@@ -61,7 +61,7 @@ In this case, the assumption is that a packet is 16 blocks of 64 bytes, which is
 The Intel® 5520 chipset has three channels, so in most cases,
 no padding is required between objects (except for objects whose size are n x 3 x 64 bytes blocks).
 
-.. _figure_memory-management2:
+.. _mempool_figure_memory_management2:
 
 .. figure:: img/memory-management2.*
 
@@ -98,9 +98,9 @@ This internal cache can be enabled or disabled at creation of the pool.
 
 The maximum size of the cache is static and is defined at compilation time (RTE_MEMPOOL_CACHE_MAX_SIZE).
 
-:numref:`figure_mempool` shows a cache in operation.
+:numref:`mempool_figure_cache` shows a cache in operation.
 
-.. _figure_mempool:
+.. _mempool_figure_cache:
 
 .. figure:: img/mempool.*
 
diff --git a/doc/guides/prog_guide/packet_classif_access_ctrl.rst b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
index ea446ed2ab..ba25e9e3e4 100644
--- a/doc/guides/prog_guide/packet_classif_access_ctrl.rst
+++ b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
@@ -410,7 +410,7 @@ At startup ACL library determines the highest available classify method for the
 .. note::
 
      Runtime algorithm selection obeys EAL max SIMD bitwidth parameter.
-     For more details about expected behaviour please see :ref:`max_simd_bitwidth`
+     For more details about expected behaviour please see :ref:`eal_max_simd_bitwidth`
 
 Application Programming Interface (API) Usage
 ---------------------------------------------
diff --git a/doc/guides/prog_guide/packet_framework.rst b/doc/guides/prog_guide/packet_framework.rst
index a6b80899c3..5d43242539 100644
--- a/doc/guides/prog_guide/packet_framework.rst
+++ b/doc/guides/prog_guide/packet_framework.rst
@@ -39,9 +39,9 @@ one of the table entries (on lookup hit) or the default table entry (on lookup m
 provides the set of actions to be applied on the current packet,
 as well as the next hop for the packet, which can be either another table, an output port or packet drop.
 
-An example of packet processing pipeline is presented in :numref:`figure_figure32`:
+An example of packet processing pipeline is presented in :numref:`packet_framework_figure_32`:
 
-.. _figure_figure32:
+.. _packet_framework_figure_32:
 
 .. figure:: img/figure32.*
 
@@ -55,9 +55,10 @@ Port Library Design
 Port Types
 ~~~~~~~~~~
 
-:numref:`table_qos_19` is a non-exhaustive list of ports that can be implemented with the Packet Framework.
+:numref:`packet_framework_table_qos_19` is a non-exhaustive list of ports
+that can be implemented with the Packet Framework.
 
-.. _table_qos_19:
+.. _packet_framework_table_qos_19:
 
 .. table:: Port Types
 
@@ -136,9 +137,10 @@ Table Library Design
 Table Types
 ~~~~~~~~~~~
 
-:numref:`table_qos_21` is a non-exhaustive list of types of tables that can be implemented with the Packet Framework.
+:numref:`packet_framework_table_qos_21` is a non-exhaustive list of types of tables
+that can be implemented with the Packet Framework.
 
-.. _table_qos_21:
+.. _packet_framework_table_qos_21:
 
 .. table:: Table Types
 
@@ -207,9 +209,9 @@ Table Interface
 
 Each table is required to implement an abstract interface that defines the initialization
 and run-time operation of the table.
-The table abstract interface is described in :numref:`table_qos_29_1`.
+The table abstract interface is described in :numref:`packet_framework_table_qos_29_1`.
 
-.. _table_qos_29_1:
+.. _packet_framework_table_qos_29_1:
 
 .. table:: Table Abstract Interface
 
@@ -316,9 +318,10 @@ considering *n_bits* as the number of bits set in *bucket_mask = n_buckets - 1*,
 this means that all the keys that end up in the same hash table bucket have the lower *n_bits* of their signature identical.
 In order to reduce the number of keys in the same bucket (collisions), the number of hash table buckets needs to be increased.
 
-In packet processing context, the sequence of operations involved in hash table operations is described in :numref:`figure_figure33`:
+In packet processing context, the sequence of operations involved in hash table operations
+is described in :numref:`packet_framework_figure_33`:
 
-.. _figure_figure33:
+.. _packet_framework_figure_33:
 
 .. figure:: img/figure33.*
 
@@ -363,9 +366,10 @@ The MAC address of the next hop station becomes the destination MAC address of t
 Hash Table Types
 ^^^^^^^^^^^^^^^^
 
-:numref:`table_qos_22` lists the hash table configuration parameters shared by all different hash table types.
+:numref:`packet_framework_table_qos_22` lists the hash table configuration parameters
+shared by all different hash table types.
 
-.. _table_qos_22:
+.. _packet_framework_table_qos_22:
 
 .. table:: Configuration Parameters Common for All Hash Table Types
 
@@ -522,17 +526,19 @@ This avoids the important cost associated with flushing the CPU core execution p
 Configurable Key Size Hash Table
 """"""""""""""""""""""""""""""""
 
-:numref:`figure_figure34`, :numref:`table_qos_25` and :numref:`table_qos_26` detail the main data structures used to implement configurable key size hash tables (either LRU or extendable bucket,
-either with pre-computed signature or "do-sig").
+:numref:`packet_framework_figure_34`, :numref:`packet_framework_table_qos_25`
+and :numref:`packet_framework_table_qos_26`
+detail the main data structures used to implement configurable key size hash tables
+(either LRU or extendable bucket, either with pre-computed signature or "do-sig").
 
-.. _figure_figure34:
+.. _packet_framework_figure_34:
 
 .. figure:: img/figure34.*
 
    Data Structures for Configurable Key Size Hash Tables
 
 
-.. _table_qos_25:
+.. _packet_framework_table_qos_25:
 
 .. table:: Main Large Data Structures (Arrays) used for Configurable Key Size Hash Tables
 
@@ -556,7 +562,7 @@ either with pre-computed signature or "do-sig").
    |   |                         |                              |                           |                               |
    +---+-------------------------+------------------------------+---------------------------+-------------------------------+
 
-.. _table_qos_26:
+.. _packet_framework_table_qos_26:
 
 .. table:: Field Description for Bucket Array Entry (Configurable Key Size Hash Tables)
 
@@ -595,11 +601,12 @@ either with pre-computed signature or "do-sig").
    +---+------------------+--------------------+------------------------------------------------------------------+
 
 
-:numref:`figure_figure35` and :numref:`table_qos_27` detail the bucket search pipeline stages (either LRU or extendable bucket,
-either with pre-computed signature or "do-sig").
+:numref:`packet_framework_figure_35` and :numref:`packet_framework_table_qos_27`
+detail the bucket search pipeline stages
+(either LRU or extendable bucket, either with pre-computed signature or "do-sig").
 For each pipeline stage, the described operations are applied to each of the two packets handled by that stage.
 
-.. _figure_figure35:
+.. _packet_framework_figure_35:
 
 .. figure:: img/figure35.*
 
@@ -607,7 +614,7 @@ For each pipeline stage, the described operations are applied to each of the two
    Tables)
 
 
-.. _table_qos_27:
+.. _packet_framework_table_qos_27:
 
 .. table:: Description of the Bucket Search Pipeline Stages (Configurable Key Size Hash Tables)
 
@@ -699,9 +706,9 @@ Additional notes:
 
 **Key Signature Comparison Logic**
 
-The key signature comparison logic is described in :numref:`table_qos_28`.
+The key signature comparison logic is described in :numref:`packet_framework_table_qos_28`.
 
-.. _table_qos_28:
+.. _packet_framework_table_qos_28:
 
 .. table:: Lookup Tables for Match, Match_Many and Match_Pos
 
@@ -761,12 +768,13 @@ The key signature comparison logic is described in :numref:`table_qos_28`.
 The input *mask* hash bit X (X = 0 .. 3) set to 1 if input signature is equal to bucket signature X and set to 0 otherwise.
 The outputs *match*, *match_many* and *match_pos* are 1 bit, 1 bit and 2 bits in size respectively and their meaning has been explained above.
 
-As displayed in :numref:`table_qos_29`, the lookup tables for *match* and *match_many* can be collapsed into a single 32-bit value and the lookup table for
-*match_pos* can be collapsed into a 64-bit value.
+As displayed in :numref:`packet_framework_table_qos_29`,
+the lookup tables for *match* and *match_many* can be collapsed into a single 32-bit value
+and the lookup table for *match_pos* can be collapsed into a 64-bit value.
 Given the input *mask*, the values for *match*, *match_many* and *match_pos* can be obtained by indexing their respective bit array to extract 1 bit,
 1 bit and 2 bits respectively with branchless logic.
 
-.. _table_qos_29:
+.. _packet_framework_table_qos_29:
 
 .. table:: Collapsed Lookup Tables for Match, Match_Many and Match_Pos
 
@@ -796,24 +804,26 @@ The pseudo-code for match, match_many and match_pos is::
 Single Key Size Hash Tables
 """""""""""""""""""""""""""
 
-:numref:`figure_figure37`, :numref:`figure_figure38`, :numref:`table_qos_30` and :numref:`table_qos_31` detail the main data structures used to implement 8-byte and 16-byte key hash tables
+:numref:`packet_framework_figure_37`, :numref:`packet_framework_figure_38`,
+:numref:`packet_framework_table_qos_30` and :numref:`packet_framework_table_qos_31`
+detail the main data structures used to implement 8-byte and 16-byte key hash tables
 (either LRU or extendable bucket, either with pre-computed signature or "do-sig").
 
-.. _figure_figure37:
+.. _packet_framework_figure_37:
 
 .. figure:: img/figure37.*
 
    Data Structures for 8-byte Key Hash Tables
 
 
-.. _figure_figure38:
+.. _packet_framework_figure_38:
 
 .. figure:: img/figure38.*
 
    Data Structures for 16-byte Key Hash Tables
 
 
-.. _table_qos_30:
+.. _packet_framework_table_qos_30:
 
 .. table:: Main Large Data Structures (Arrays) used for 8-byte and 16-byte Key Size Hash Tables
 
@@ -843,7 +853,7 @@ Single Key Size Hash Tables
    |   |                         |                              |                      |                                    |
    +---+-------------------------+------------------------------+----------------------+------------------------------------+
 
-.. _table_qos_31:
+.. _packet_framework_table_qos_31:
 
 .. table:: Field Description for Bucket Array Entry (8-byte and 16-byte Key Hash Tables)
 
@@ -1004,9 +1014,9 @@ The reserved actions are handled directly by the Packet Framework without the us
 through the table action handler configuration.
 A special category of the reserved actions is represented by the next hop actions, which regulate the packet flow between input ports,
 tables and output ports through the pipeline.
-:numref:`table_qos_33` lists the next hop actions.
+:numref:`packet_framework_table_qos_33` lists the next hop actions.
 
-.. _table_qos_33:
+.. _packet_framework_table_qos_33:
 
 .. table:: Next Hop Actions (Reserved)
 
@@ -1035,9 +1045,9 @@ and their associated meta-data is private to each table.
 Within the same table, all the table entries (including the table default entry) share the same definition
 for the user actions and their associated meta-data,
 with each table entry having its own set of enabled user actions and its own copy of the action meta-data.
-:numref:`table_qos_34` contains a non-exhaustive list of user action examples.
+:numref:`packet_framework_table_qos_34` contains a non-exhaustive list of user action examples.
 
-.. _table_qos_34:
+.. _packet_framework_table_qos_34:
 
 .. table:: User Action Examples
 
diff --git a/doc/guides/prog_guide/rcu_lib.rst b/doc/guides/prog_guide/rcu_lib.rst
index 9f3654f398..4b8c2d0d5f 100644
--- a/doc/guides/prog_guide/rcu_lib.rst
+++ b/doc/guides/prog_guide/rcu_lib.rst
@@ -40,14 +40,14 @@ the application to determine its quiescent state.
 
 Let us consider the following diagram:
 
-.. _figure_quiescent_state:
+.. _rcu_figure_quiescent_state:
 
 .. figure:: img/rcu_general_info.*
 
    Phases in the Quiescent State model.
 
 
-As shown in :numref:`figure_quiescent_state`, reader thread 1 accesses data
+As shown in :numref:`rcu_figure_quiescent_state`, reader thread 1 accesses data
 structures D1 and D2. When it is accessing D1, if the writer has to remove an
 element from D1, the writer cannot free the memory associated with that
 element immediately. The writer can return the memory to the allocator only
diff --git a/doc/guides/prog_guide/rib_lib.rst b/doc/guides/prog_guide/rib_lib.rst
index 40b7de3f1d..533033c37c 100644
--- a/doc/guides/prog_guide/rib_lib.rst
+++ b/doc/guides/prog_guide/rib_lib.rst
@@ -27,9 +27,9 @@ Next hop IDs are represented by ``uint64_t`` values.
    Everything within this document except for the size of the prefixes is applicable to  the
    ``rte_rib6`` API.
 
-Internally RIB is represented as a binary tree as shown in :numref:`figure_rib_internals`:
+Internally RIB is represented as a binary tree as shown in :numref:`rib_figure_internals`:
 
-.. _figure_rib_internals:
+.. _rib_figure_internals:
 
 .. figure:: img/rib_internals.*
 
@@ -66,7 +66,7 @@ The main methods within the ``rte_rib`` API are:
 
 * ``rte_rib_get_nxt()``: Traverse a subtree within the structure.
 
-Given a RIB structure with the routes depicted in :numref:`figure_rib_internals`,
+Given a RIB structure with the routes depicted in :numref:`rib_figure_internals`,
 here are several usage examples:
 
 * The best route for ``10.0.0.1`` can be found by calling:
@@ -92,7 +92,7 @@ This returns an ``rte_rib_node`` pointing to the ``10.0.0.128/25`` prefix.
 This returns ``NULL`` as no exact match can be found.
 
 * To retrieve a group of routes under the common prefix ``10.0.0.0/24``
-  (yellow triangle in :numref:`figure_rib_internals`):
+  (yellow triangle in :numref:`rib_figure_internals`):
 
 .. code-block:: c
 
@@ -119,10 +119,10 @@ It is possible to implement a prefix independent convergence using the RIB exten
 If the routing daemon can provide a feasible next hop ID along with a best (active) next hop ID,
 it is possible to react to a neighbour failing relatively fast.
 Consider a RIB with a number of routes with different next hops (A and B) as
-shown in :numref:`figure_rib_pic`. Every route can have a feasible next hop
+shown in :numref:`rib_figure_pic`. Every route can have a feasible next hop
 provided by the routing daemon.
 
-.. _figure_rib_pic:
+.. _rib_figure_pic:
 
 .. figure:: img/rib_pic.*
 
diff --git a/doc/guides/prog_guide/toeplitz_hash_lib.rst b/doc/guides/prog_guide/toeplitz_hash_lib.rst
index 5ebe958f2f..384e258ea8 100644
--- a/doc/guides/prog_guide/toeplitz_hash_lib.rst
+++ b/doc/guides/prog_guide/toeplitz_hash_lib.rst
@@ -9,7 +9,7 @@ to calculate the Toeplitz hash function and to use its properties.
 The Toeplitz hash function is commonly used in a wide range of NICs
 to calculate the RSS hash sum to spread the traffic among the queues.
 
-.. _figure_rss_queue_assign:
+.. _toeplitz_figure_rss_queue_assign:
 
 .. figure:: img/rss_queue_assign.*
 
@@ -72,7 +72,7 @@ Predictable RSS
 ---------------
 
 In some use cases it is useful to have a way to find partial collisions of the
-Toeplitz hash function. In figure :numref:`figure_rss_queue_assign` only a few
+Toeplitz hash function. In figure :numref:`toeplitz_figure_rss_queue_assign` only a few
 of the least significant bits (LSB) of the hash value are used to indicate an
 entry in the RSS Redirection Table (ReTa) and thus the index of the queue. So,
 in this case it would be useful to find another tuple whose hash has the same
@@ -216,9 +216,9 @@ tag allocation, etc. In the following we will consider a SNAT application.
 
 Packets of a single bidirectional flow belonging to different directions can
 end up being assigned to different queues and thus processed by different
-lcores, as shown in :numref:`figure_predictable_snat_1`:
+lcores, as shown in :numref:`toeplitz_figure_predictable_snat_1`:
 
-.. _figure_predictable_snat_1:
+.. _toeplitz_figure_predictable_snat_1:
 
 .. figure:: img/predictable_snat_1.*
 
@@ -241,9 +241,9 @@ penalties, for example:
 
 We can avoid all these penalties if it can be guaranteed that packets
 belonging to one bidirectional flow will be assigned to the same queue, as
-shown in :numref:`figure_predictable_snat_2`:
+shown in :numref:`toeplitz_figure_predictable_snat_2`:
 
-.. _figure_predictable_snat_2:
+.. _toeplitz_figure_predictable_snat_2:
 
 .. figure:: img/predictable_snat_2.*
 
diff --git a/doc/guides/sample_app_ug/compiling.rst b/doc/guides/sample_app_ug/compiling.rst
index d3e77f49e8..e360c43804 100644
--- a/doc/guides/sample_app_ug/compiling.rst
+++ b/doc/guides/sample_app_ug/compiling.rst
@@ -63,7 +63,7 @@ Using Make
 ~~~~~~~~~~
 
 Pkg-config is used when building an example app standalone using make, please
-see :ref:`building_app_using_installed_dpdk` for more information.
+see :ref:`linux_gsg_building_app_using_installed_dpdk` for more information.
 
 Go to the sample application directory. Unless otherwise specified the sample
 applications are located in ``dpdk/examples/``.
diff --git a/doc/guides/sample_app_ug/dist_app.rst b/doc/guides/sample_app_ug/dist_app.rst
index 154d08d989..b1e4a9f46f 100644
--- a/doc/guides/sample_app_ug/dist_app.rst
+++ b/doc/guides/sample_app_ug/dist_app.rst
@@ -63,7 +63,7 @@ Explanation
 The distributor application consists of four types of threads: a receive
 thread (``lcore_rx()``), a distributor thread (``lcore_dist()``), a set of
 worker threads (``lcore_worker()``), and a transmit thread(``lcore_tx()``).
-How these threads work together is shown in :numref:`figure_dist_app` below.
+How these threads work together is shown in :numref:`dist_app_figure_overview` below.
 The ``main()`` function launches  threads of these four types.  Each thread
 has a while loop which will be doing processing and which is terminated
 only upon SIGINT or ctrl+C.
@@ -95,7 +95,7 @@ Users who wish to terminate the running of the application have to press ctrl+C
 in the application will terminate all running threads gracefully and print
 final statistics to the user.
 
-.. _figure_dist_app:
+.. _dist_app_figure_overview:
 
 .. figure:: img/dist_app.*
 
diff --git a/doc/guides/sample_app_ug/l2_forward_event.rst b/doc/guides/sample_app_ug/l2_forward_event.rst
index a71620469e..b07f989117 100644
--- a/doc/guides/sample_app_ug/l2_forward_event.rst
+++ b/doc/guides/sample_app_ug/l2_forward_event.rst
@@ -29,9 +29,9 @@ Application receives packets from Rx port using these methods:
 *   Eventdev mode (default)
 
 This application can be used to benchmark performance using a traffic-generator,
-as shown in the :numref:`figure_l2fwd_event_benchmark_setup`.
+as shown in the :numref:`l2_fwd_event_figure_benchmark_setup`.
 
-.. _figure_l2fwd_event_benchmark_setup:
+.. _l2_fwd_event_figure_benchmark_setup:
 
 .. figure:: img/l2_fwd_benchmark_setup.*
 
diff --git a/doc/guides/sample_app_ug/l2_forward_job_stats.rst b/doc/guides/sample_app_ug/l2_forward_job_stats.rst
index 67ea125c41..5056b30e57 100644
--- a/doc/guides/sample_app_ug/l2_forward_job_stats.rst
+++ b/doc/guides/sample_app_ug/l2_forward_job_stats.rst
@@ -29,19 +29,21 @@ The MAC addresses are affected as follows:
 
 *   The destination MAC address is replaced by ``02:00:00:00:00:TX_PORT_ID``
 
-This application can be used to benchmark performance using a traffic-generator, as shown in the :numref:`figure_l2_fwd_benchmark_setup_jobstats`.
+This application can be used to benchmark performance using a traffic-generator,
+as shown in the :numref:`l2_fwd_job_stats_figure_benchmark_setup`.
 
-The application can also be used in a virtualized environment as shown in :numref:`figure_l2_fwd_virtenv_benchmark_setup_jobstats`.
+The application can also be used in a virtualized environment
+as shown in :numref:`l2_fwd_job_stats_figure_virtenv_benchmark_setup`.
 
 The L2 Forwarding application can also be used as a starting point for developing a new application based on the DPDK.
 
-.. _figure_l2_fwd_benchmark_setup_jobstats:
+.. _l2_fwd_job_stats_figure_benchmark_setup:
 
 .. figure:: img/l2_fwd_benchmark_setup.*
 
    Performance Benchmark Setup (Basic Environment)
 
-.. _figure_l2_fwd_virtenv_benchmark_setup_jobstats:
+.. _l2_fwd_job_stats_figure_virtenv_benchmark_setup:
 
 .. figure:: img/l2_fwd_virtenv_benchmark_setup.*
 
diff --git a/doc/guides/sample_app_ug/l2_forward_real_virtual.rst b/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
index aff7af7c57..178ea054dd 100644
--- a/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
+++ b/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
@@ -28,25 +28,27 @@ Also, if MAC address updating is enabled, the MAC addresses are affected as foll
 
 *   The destination MAC address is replaced by  02:00:00:00:00:TX_PORT_ID
 
-This application can be used to benchmark performance using a traffic-generator, as shown in the :numref:`figure_l2_fwd_benchmark_setup`,
-or in a virtualized environment as shown in :numref:`figure_l2_fwd_virtenv_benchmark_setup`.
+This application can be used to benchmark performance using a traffic-generator,
+as shown in the :numref:`l2_fwd_figure_benchmark_setup`,
+or in a virtualized environment as shown in :numref:`l2_fwd_figure_virtenv_benchmark_setup`.
 
-.. _figure_l2_fwd_benchmark_setup:
+.. _l2_fwd_figure_benchmark_setup:
 
 .. figure:: img/l2_fwd_benchmark_setup.*
 
    Performance Benchmark Setup (Basic Environment)
 
-.. _figure_l2_fwd_virtenv_benchmark_setup:
+.. _l2_fwd_figure_virtenv_benchmark_setup:
 
 .. figure:: img/l2_fwd_virtenv_benchmark_setup.*
 
    Performance Benchmark Setup (Virtualized Environment)
 
-This application may be used for basic VM to VM communication as shown in :numref:`figure_l2_fwd_vm2vm`,
+This application may be used for basic VM to VM communication
+as shown in :numref:`l2_fwd_figure_vm2vm`,
 when MAC addresses updating is disabled.
 
-.. _figure_l2_fwd_vm2vm:
+.. _l2_fwd_figure_vm2vm:
 
 .. figure:: img/l2_fwd_vm2vm.*
 
diff --git a/doc/guides/sample_app_ug/server_node_efd.rst b/doc/guides/sample_app_ug/server_node_efd.rst
index d25b39e89b..ab3de35333 100644
--- a/doc/guides/sample_app_ug/server_node_efd.rst
+++ b/doc/guides/sample_app_ug/server_node_efd.rst
@@ -18,13 +18,13 @@ Overview
 The architecture of the EFD flow-based load balancer sample application is
 presented in the following figure.
 
-.. _figure_efd_sample_app_overview:
+.. _server_node_efd_figure_overview:
 
 .. figure:: img/server_node_efd.*
 
    Using EFD as a Flow-Level Load Balancer
 
-As shown in :numref:`figure_efd_sample_app_overview`,
+As shown in :numref:`server_node_efd_figure_overview`,
 the sample application consists of a front-end node (server)
 using the EFD library to create a load-balancing table for flows,
 for each flow a target backend worker node is specified. The EFD table does not
diff --git a/doc/guides/sample_app_ug/test_pipeline.rst b/doc/guides/sample_app_ug/test_pipeline.rst
index 014c00121f..e53d77a170 100644
--- a/doc/guides/sample_app_ug/test_pipeline.rst
+++ b/doc/guides/sample_app_ug/test_pipeline.rst
@@ -53,7 +53,7 @@ The PORTMASK parameter must contain 2 or 4 ports.
 Table Types and Behavior
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-:numref:`table_test_pipeline_1` describes the table types used and how they are populated.
+:numref:`test_pipeline_table_1` describes the table types used and how they are populated.
 
 The hash tables are pre-populated with 16 million keys.
 For hash tables, the following parameters can be selected:
@@ -68,7 +68,7 @@ For hash tables, the following parameters can be selected:
 *   **Table type (e.g. hash-spec-16-ext or hash-spec-16-lru).**
     The available options are ext (extendable bucket) or lru (least recently used).
 
-.. _table_test_pipeline_1:
+.. _test_pipeline_table_1:
 
 .. table:: Table Types
 
diff --git a/doc/guides/sample_app_ug/vm_power_management.rst b/doc/guides/sample_app_ug/vm_power_management.rst
index 6ad669e4d6..174eecfd99 100644
--- a/doc/guides/sample_app_ug/vm_power_management.rst
+++ b/doc/guides/sample_app_ug/vm_power_management.rst
@@ -38,13 +38,14 @@ This application demonstrates the following features:
   policy independent of the VM application. For example, the
   policy can contain time-of-day information for busy/quiet
   periods, and the host application can scale up/down the relevant
-  cores when required. See :ref:`sending_policy` for information on
-  setting policy values.
+  cores when required.
+  See :ref:`vm_power_sending_policy` for information on setting policy values.
 
 - **Out-of-band monitoring of workloads using core hardware event counters.**
   The host application can manage power for an application by looking
   at the event counters of the cores and taking action based on the
-  branch miss/hit ratio. See :ref:`enabling_out_of_band`.
+  branch miss/hit ratio.
+  See :ref:`vm_power_enabling_out_of_band`.
 
   **Note**: This functionality also applies in non-virtualised environments.
 
@@ -116,8 +117,8 @@ management requests. Once the VM sends the policy to the host, the VM no
 longer needs to worry about power management, because the host now
 manages the power for the VM based on the policy. The policy can specify
 power behavior that is based on incoming traffic rates or time-of-day
-power adjustment (busy/quiet hour power adjustment for example). See
-:ref:`sending_policy` for more information.
+power adjustment (busy/quiet hour power adjustment for example).
+See :ref:`vm_power_sending_policy` for more information.
 
 One method of power management is to sense how busy a core is when
 processing packets and adjusting power accordingly. One technique for
@@ -127,13 +128,14 @@ on the premise that when a core is not processing packets, the ratio of
 branch misses to branch hits is very low, but when the core is
 processing packets, it is measurably higher. The implementation of this
 capability is as a policy of type ``BRANCH_RATIO``.
-See :ref:`sending_policy` for more information on using the
+See :ref:`vm_power_sending_policy` for more information on using the
 BRANCH_RATIO policy option.
 
 A JSON interface enables the specification of power management requests
 and policies in JSON format. The JSON interfaces provide a more
 convenient and more easily interpreted interface for the specification
-of requests and policies. See :ref:`power_man_requests` for more information.
+of requests and policies.
+See :ref:`vm_power_requests` for more information.
 
 Performance Considerations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -393,7 +395,7 @@ Set the current frequency for the specified core by scaling up/down/min/max:
 
    set_cpu_freq {core_num} up|down|min|max
 
-.. _enabling_out_of_band:
+.. _vm_power_enabling_out_of_band:
 
 Command Line Options for Enabling Out-of-band Branch Ratio Monitoring
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -513,7 +515,7 @@ run on cores 0, 1, 2 and 3:
 
    ./<build_dir>/examples/dpdk-guest_vm_power_mgr -l 0-3
 
-.. _sending_policy:
+.. _vm_power_sending_policy:
 
 Command Line Options Available When Sending a Policy to the Host
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -594,7 +596,7 @@ will send the policy to the host:
 Once the policy is sent to the host, the host application takes over the power monitoring
 of the specified cores in the policy.
 
-.. _power_man_requests:
+.. _vm_power_requests:
 
 JSON Interface for Power Management Requests and Policies
 ---------------------------------------------------------
@@ -633,11 +635,11 @@ pairs are different depending on which type is sent.
 
 The pairs are in the format of standard JSON name-value pairs. The value
 type varies between the different name-value pairs, and may be integers,
-strings, arrays, and so on. See :ref:`json_interface_ex`
-for examples of policies and instructions and
-:ref:`json_name_value_pair` for the supported names and value types.
+strings, arrays, and so on.
+See :ref:`vm_power_json_interface_examples` for examples of policies and instructions
+and :ref:`vm_power_json_name_value_pairs` for the supported names and value types.
 
-.. _json_interface_ex:
+.. _vm_power_json_interface_examples:
 
 JSON Interface Examples
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -708,7 +710,7 @@ will send the policy to the host:
 Once the policy is sent to the host, the host application takes over the power monitoring
 of the specified cores in the policy.
 
-.. _json_name_value_pair:
+.. _vm_power_json_name_value_pairs:
 
 JSON Name-value Pairs
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst b/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
index efb133c11c..61fb959485 100644
--- a/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
+++ b/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
@@ -23,7 +23,8 @@ All traffic is read from a single incoming port (port 0) and output on port 1, w
 With Intel® 82599 NIC, for example, the traffic is split into 128 queues on input, where each thread of the application reads from
 multiple queues. When run with 8 threads, that is, with the -c FF option, each thread receives and forwards packets from 16 queues.
 
-As supplied, the sample application configures the VMDQ feature to have 32 pools with 4 queues each as indicated in :numref:`figure_vmdq_dcb_example`.
+As supplied, the sample application configures the VMDQ feature
+to have 32 pools with 4 queues each as indicated in :numref:`vmdq_dcb_figure_example`.
 The Intel® 82599 10 Gigabit Ethernet Controller NIC also supports the splitting of traffic into 16 pools of 8 queues. While the
 Intel® X710 or XL710 Ethernet Controller NICs support many configurations of VMDQ pools of 4 or 8 queues each. For simplicity, only 16
 or 32 pools is supported in this sample. And queues numbers for each VMDQ pool can be changed by setting RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM
@@ -36,7 +37,7 @@ The nb-pools, nb-tcs and enable-rss parameters can be passed on the command line
 
 where, NP can be 16 or 32, TC can be 4 or 8, rss is disabled by default.
 
-.. _figure_vmdq_dcb_example:
+.. _vmdq_dcb_figure_example:
 
 .. figure:: img/vmdq_dcb_example.*
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 3501f10a4a..e65376df54 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1951,7 +1951,7 @@ The following sections show functions for configuring ports.
 
    Port configuration changes only become active when forwarding is started/restarted.
 
-.. _port_attach:
+.. _testpmd_port_attach:
 
 port attach
 ~~~~~~~~~~~
@@ -5750,5 +5750,5 @@ Some drivers provide specific features.
 See:
 
 - :ref:`net/bonding testpmd driver specific commands <bonding_testpmd_commands>`
-- :ref:`net/i40e testpmd driver specific commands <net_i40e_testpmd_commands>`
-- :ref:`net/ixgbe testpmd driver specific commands <net_ixgbe_testpmd_commands>`
+- :ref:`net/i40e testpmd driver specific commands <i40e_testpmd_commands>`
+- :ref:`net/ixgbe testpmd driver specific commands <ixgbe_testpmd_commands>`
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 9a877eef8a..9cdd1ccd77 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -138,7 +138,7 @@ There are two areas that need to be set up on a System Under Test:
 
 #. **User with administrator privileges**
 
-.. _sut_admin_user:
+.. _dts_sut_admin_user:
 
    DTS needs administrator privileges to run DPDK applications (such as testpmd) on the SUT.
    The SUT user must be able run commands in privileged mode without asking for password.
@@ -264,7 +264,7 @@ These need to be set up on a Traffic Generator Node:
 
    Similarly to the System Under Test, traffic generators need administrator privileges
    to be able to use the devices.
-   Refer to the `System Under Test section <sut_admin_user>` for details.
+   Refer to the `System Under Test section <dts_sut_admin_user>` for details.
 
 
 Running DTS
@@ -286,12 +286,12 @@ and must respect the model definitions
 as documented in the DTS API docs under the ``config`` page.
 The root of the configuration is represented by the ``Configuration`` model.
 By default, DTS will try to use the ``dts/configurations/test_run.example.yaml``
-:ref:`config file <test_run_configuration_example>`,
+:ref:`config file <dts_test_run_configuration_example>`,
 and ``dts/configurations/nodes.example.yaml``
-:ref:`config file <nodes_configuration_example>`
+:ref:`config file <dts_nodes_configuration_example>`
 which are templates that illustrate what can be configured in DTS.
 
-The user must have :ref:`administrator privileges <sut_admin_user>`
+The user must have :ref:`administrator privileges <dts_sut_admin_user>`
 which don't require password authentication.
 
 
@@ -386,12 +386,12 @@ Framework Coding Guidelines
 When contributing code to the DTS framework,
 follow existing conventions to ensure consistency.
 The :ref:`dts_dev_tools` will flag basic issues.
-Also, be sure to :ref:`build the API documentation <building_api_docs>`
+Also, be sure to :ref:`build the API documentation <dts_building_api_docs>`
 to catch any problems during the build.
 
 The API documentation is a helpful reference during development.
 It can be viewed in the code directly
-or generated using the :ref:`API docs build steps <building_api_docs>`.
+or generated using the :ref:`API docs build steps <dts_building_api_docs>`.
 If you add new files or change the directory structure,
 update the corresponding sources in ``doc/api/dts``.
 
@@ -560,7 +560,7 @@ the DTS code check and format script.
 Refer to the script for usage: ``devtools/dts-check-format.sh -h``.
 
 
-.. _building_api_docs:
+.. _dts_building_api_docs:
 
 Building DTS API docs
 ---------------------
@@ -595,7 +595,7 @@ And they both have two network ports which are physically connected to each othe
    This example assumes that you have setup SSH keys in both the system under test
    and traffic generator nodes.
 
-.. _test_run_configuration_example:
+.. _dts_test_run_configuration_example:
 
 ``dts/configurations/test_run.example.yaml``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -604,7 +604,7 @@ And they both have two network ports which are physically connected to each othe
    :language: yaml
    :start-at: # Define
 
-.. _nodes_configuration_example:
+.. _dts_nodes_configuration_example:
 
 
 ``dts/configurations/nodes.example.yaml``
diff --git a/doc/guides/tools/graph.rst b/doc/guides/tools/graph.rst
index ebb5218c76..edd1909ec2 100644
--- a/doc/guides/tools/graph.rst
+++ b/doc/guides/tools/graph.rst
@@ -169,40 +169,44 @@ Supported CLI commands
 This section provides details on commands which can be used in ``<usecase>.cli``
 file to express the requested use case configuration.
 
+.. |graph_scope1| replace:: :ref:`1 <graph_command_scopes>`
+.. |graph_scope2| replace:: :ref:`2 <graph_command_scopes>`
+.. |graph_scope3| replace:: :ref:`3 <graph_command_scopes>`
+
 .. table:: Exposed CLIs
    :widths: auto
 
    +--------------------------------------+-----------------------------------+-------------------+----------+
    |               Command                |             Description           |     Scope         | Optional |
    +======================================+===================================+===================+==========+
-   | | graph <usecases> [bsz <size>]      | | Command to express the desired  | :ref:`1 <scopes>` |    No    |
+   | | graph <usecases> [bsz <size>]      | | Command to express the desired  | |graph_scope1|    |    No    |
    | | [tmo <ns>] [coremask <bitmask>]    | | use case. Also enables/disable  |                   |          |
    | | model <rtc/mcd/default> pcap_enable| | pcap capturing.                 |                   |          |
    | | <0/1> num_pcap_pkts <num> pcap_file|                                   |                   |          |
    | | <output_capture_file>              |                                   |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | graph start                          | | Command to start the graph.     | :ref:`1 <scopes>` |    No    |
+   | graph start                          | | Command to start the graph.     | |graph_scope1|    |    No    |
    |                                      | | This command triggers that no   |                   |          |
    |                                      | | more commands are left to be    |                   |          |
    |                                      | | parsed and graph initialization |                   |          |
    |                                      | | can be started now. It must be  |                   |          |
    |                                      | | the last command in usecase.cli |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | graph stats show                     | | Command to dump current graph   | :ref:`2 <scopes>` |    Yes   |
+   | graph stats show                     | | Command to dump current graph   | |graph_scope2|    |    Yes   |
    |                                      | | statistics.                     |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | help graph                           | | Command to dump graph help      | :ref:`2 <scopes>` |    Yes   |
+   | help graph                           | | Command to dump graph help      | |graph_scope2|    |    Yes   |
    |                                      | | message.                        |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | mempool <mempool_name> size        | | Command to create mempool which | :ref:`1 <scopes>` |    No    |
+   | | mempool <mempool_name> size        | | Command to create mempool which | |graph_scope1|    |    No    |
    | | <mbuf_size> buffers                | | will be further associated to   |                   |          |
    | | <number_of_buffers>                | | RxQ to dequeue the packets.     |                   |          |
    | | cache <cache_size> numa <numa_id>  |                                   |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | help mempool                         | | Command to dump mempool help    | :ref:`2 <scopes>` |    Yes   |
+   | help mempool                         | | Command to dump mempool help    | |graph_scope2|    |    Yes   |
    |                                      | | message.                        |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | ethdev <ethdev_name> rxq <n_queues>| | Command to create DPDK port with| :ref:`1 <scopes>` |    No    |
+   | | ethdev <ethdev_name> rxq <n_queues>| | Command to create DPDK port with| |graph_scope1|    |    No    |
    | | txq <n_queues> <mempool_name>      | | given number of Rx and Tx queues|                   |          |
    |                                      | | . Also attach RxQ with given    |                   |          |
    |                                      | | mempool. Each port can have     |                   |          |
@@ -210,95 +214,95 @@ file to express the requested use case configuration.
    |                                      | | RxQs will share the same mempool|                   |          |
    |                                      | | .                               |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | ethdev <ethdev_name> mtu <mtu_sz>    | | Command to configure MTU of DPDK| :ref:`3 <scopes>` |    Yes   |
+   | ethdev <ethdev_name> mtu <mtu_sz>    | | Command to configure MTU of DPDK| |graph_scope3|    |    Yes   |
    |                                      | | port.                           |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | ethdev forward <tx_dev_name>       | | Command to configure port       | :ref:`1 <scopes>` |    Yes   |
+   | | ethdev forward <tx_dev_name>       | | Command to configure port       | |graph_scope1|    |    Yes   |
    | | <rx_dev_name>                      | | forwarding of DPDK              |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | ethdev <ethdev_name> promiscuous   | | Command to enable/disable       | :ref:`3 <scopes>` |    Yes   |
+   | | ethdev <ethdev_name> promiscuous   | | Command to enable/disable       | |graph_scope3|    |    Yes   |
    | | <on/off>                           | | promiscuous mode on DPDK port.  |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | ethdev <ethdev_name> show            | | Command to dump current ethdev  | :ref:`2 <scopes>` |    Yes   |
+   | ethdev <ethdev_name> show            | | Command to dump current ethdev  | |graph_scope2|    |    Yes   |
    |                                      | | configuration.                  |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | ethdev <ethdev_name> stats           | | Command to dump current ethdev  | :ref:`2 <scopes>` |    Yes   |
+   | ethdev <ethdev_name> stats           | | Command to dump current ethdev  | |graph_scope2|    |    Yes   |
    |                                      | | statistics.                     |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | ethdev <ethdev_name> ip4 addr add  | | Command to configure IPv4       | :ref:`3 <scopes>` |    Yes   |
+   | | ethdev <ethdev_name> ip4 addr add  | | Command to configure IPv4       | |graph_scope3|    |    Yes   |
    | | <ip> netmask <mask>                | | address on given PCI device. It |                   |          |
    |                                      | | is needed if user wishes to use |                   |          |
    |                                      | | ``ipv4_lookup`` node.           |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | ethdev <ethdev_name> ip6 addr add  | | Command to configure IPv6       | :ref:`3 <scopes>` |    Yes   |
+   | | ethdev <ethdev_name> ip6 addr add  | | Command to configure IPv6       | |graph_scope3|    |    Yes   |
    | | <ip> netmask <mask>                | | address on given PCI device. It |                   |          |
    |                                      | | is needed if user wishes to use |                   |          |
    |                                      | | ``ipv6_lookup`` node.           |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | help ethdev                          | | Command to dump ethdev help     | :ref:`2 <scopes>` |    Yes   |
+   | help ethdev                          | | Command to dump ethdev help     | |graph_scope2|    |    Yes   |
    |                                      | | message.                        |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | ipv4_lookup route add ipv4 <ip>    | | Command to add a route into     | :ref:`3 <scopes>` |    Yes   |
+   | | ipv4_lookup route add ipv4 <ip>    | | Command to add a route into     | |graph_scope3|    |    Yes   |
    | |  netmask <mask> via <ip>           | | ``ipv4_lookup`` LPM table or    |                   |          |
    |                                      | | FIB. It is needed if user wishes|                   |          |
    |                                      | | to route the packets based on   |                   |          |
    |                                      | | LPM lookup table or FIB.        |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | ipv4_lookup mode <lpm|fib>         | | Command to set ipv4 lookup mode | :ref:`1 <scopes>` |    Yes   |
+   | | ipv4_lookup mode <lpm|fib>         | | Command to set ipv4 lookup mode | |graph_scope1|    |    Yes   |
    |                                      | | to either LPM or FIB. By default|                   |          |
    |                                      | | the lookup mode is LPM.         |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | help ipv4_lookup                     | | Command to dump ``ipv4_lookup`` | :ref:`2 <scopes>` |    Yes   |
+   | help ipv4_lookup                     | | Command to dump ``ipv4_lookup`` | |graph_scope2|    |    Yes   |
    |                                      | | help message.                   |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | ipv6_lookup route add ipv6 <ip>    | | Command to add a route into     | :ref:`3 <scopes>` |    Yes   |
+   | | ipv6_lookup route add ipv6 <ip>    | | Command to add a route into     | |graph_scope3|    |    Yes   |
    | |  netmask <mask> via <ip>           | | ``ipv6_lookup`` LPM table or.   |                   |          |
    |                                      | | FIB. It is needed if user wishes|                   |          |
    |                                      | | to route the packets based on   |                   |          |
    |                                      | | LPM6 lookup table or FIB.       |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | ipv6_lookup mode <lpm|fib>         | | Command to set ipv6 lookup mode | :ref:`1 <scopes>` |    Yes   |
+   | | ipv6_lookup mode <lpm|fib>         | | Command to set ipv6 lookup mode | |graph_scope1|    |    Yes   |
    |                                      | | to either LPM or FIB. By default|                   |          |
    |                                      | | the lookup mode is LPM.         |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | help ipv6_lookup                     | | Command to dump ``ipv6_lookup`` | :ref:`2 <scopes>` |    Yes   |
+   | help ipv6_lookup                     | | Command to dump ``ipv6_lookup`` | |graph_scope2|    |    Yes   |
    |                                      | | help message.                   |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | neigh add ipv4 <ip> <mac>            | | Command to add a neighbour      | :ref:`3 <scopes>` |    Yes   |
+   | neigh add ipv4 <ip> <mac>            | | Command to add a neighbour      | |graph_scope3|    |    Yes   |
    |                                      | | information into                |                   |          |
    |                                      | | ``ipv4_rewrite`` node.          |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | neigh add ipv6 <ip> <mac>            | | Command to add a neighbour      | :ref:`3 <scopes>` |    Yes   |
+   | neigh add ipv6 <ip> <mac>            | | Command to add a neighbour      | |graph_scope3|    |    Yes   |
    |                                      | | information into                |                   |          |
    |                                      | | ``ipv6_rewrite`` node.          |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | help neigh                           | | Command to dump neigh help      | :ref:`2 <scopes>` |    Yes   |
+   | help neigh                           | | Command to dump neigh help      | |graph_scope2|    |    Yes   |
    |                                      | | message.                        |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | ethdev_rx map port <ethdev_name>   | | Command to add port-queue-core  | :ref:`1 <scopes>` |    No    |
+   | | ethdev_rx map port <ethdev_name>   | | Command to add port-queue-core  | |graph_scope1|    |    No    |
    | | queue <q_num> core <core_id>       | | mapping to ``ethdev_rx`` node.  |                   |          |
    |                                      | | ``ethdev_rx`` node instance will|                   |          |
    |                                      | | be pinned on given core and will|                   |          |
    |                                      | | poll on requested port/queue    |                   |          |
    |                                      | | pair.                           |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | help ethdev_rx                       | | Command to dump ethdev_rx help  | :ref:`2 <scopes>` |    Yes   |
+   | help ethdev_rx                       | | Command to dump ethdev_rx help  | |graph_scope2|    |    Yes   |
    |                                      | | message.                        |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | help feature                         | | Command to dump feature arc     | :ref:`2 <scopes>` |    Yes   |
+   | help feature                         | | Command to dump feature arc     | |graph_scope2|    |    Yes   |
    |                                      | | help message.                   |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | feature arcs                         | | Command to dump all created     | :ref:`2 <scopes>` |    Yes   |
+   | feature arcs                         | | Command to dump all created     | |graph_scope2|    |    Yes   |
    |                                      | | feature arcs                    |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | feature enable <arc name>          | | Enable <feature name> of <arc   | :ref:`2 <scopes>` |    Yes   |
+   | | feature enable <arc name>          | | Enable <feature name> of <arc   | |graph_scope2|    |    Yes   |
    | | <feature name> <interface index>   | | name> on an interface.          |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
-   | | feature disable <arc name>         | | Disable <feature name> of <arc  | :ref:`2 <scopes>` |    Yes   |
+   | | feature disable <arc name>         | | Disable <feature name> of <arc  | |graph_scope2|    |    Yes   |
    | | <feature name> <interface index>   | | name> on an interface.          |                   |          |
    +--------------------------------------+-----------------------------------+-------------------+----------+
 
-.. _scopes:
+.. _graph_command_scopes:
 
 1. Script only
 2. Telnet only
diff --git a/doc/guides/tools/testeventdev.rst b/doc/guides/tools/testeventdev.rst
index d5b280bdad..41dc838c0d 100644
--- a/doc/guides/tools/testeventdev.rst
+++ b/doc/guides/tools/testeventdev.rst
@@ -545,7 +545,7 @@ This is a performance test case that aims at testing the following:
 #. Measure the number of events can be processed in a second.
 #. Measure the latency to forward an event.
 
-.. _table_eventdev_perf_queue_test:
+.. _testeventdev_table_perf_queue_test:
 
 .. table:: Perf queue test eventdev configuration.
 
@@ -572,7 +572,7 @@ This is a performance test case that aims at testing the following:
 
 The perf queue test configures the eventdev with Q queues and P ports, where
 Q and P is a function of the number of workers, the number of producers and
-number of stages as mentioned in :numref:`table_eventdev_perf_queue_test`.
+number of stages as mentioned in :numref:`testeventdev_table_perf_queue_test`.
 
 The user can choose the number of workers, the number of producers and number of
 stages through the ``--wlcores``, ``--plcores`` and the ``--stlist`` application
@@ -681,7 +681,7 @@ This is a performance test case that aims at testing the following with
 #. Measure the number of events can be processed in a second.
 #. Measure the latency to forward an event.
 
-.. _table_eventdev_perf_atq_test:
+.. _testeventdev_table_perf_atq_test:
 
 .. table:: Perf all types queue test eventdev configuration.
 
@@ -709,7 +709,7 @@ This is a performance test case that aims at testing the following with
 
 The ``all types queues(atq)`` perf test configures the eventdev with Q queues
 and P ports, where Q and P is a function of the number of workers and number of
-producers as mentioned in :numref:`table_eventdev_perf_atq_test`.
+producers as mentioned in :numref:`testeventdev_table_perf_atq_test`.
 
 
 The atq queue test functions as same as ``perf_queue`` test. The difference
@@ -784,7 +784,7 @@ This is a pipeline test case that aims at testing the following:
 #. Measure the end-to-end performance of an event dev with a ethernet dev.
 #. Maintain packet ordering from Rx to Tx.
 
-.. _table_eventdev_pipeline_queue_test:
+.. _testeventdev_table_pipeline_queue_test:
 
 .. table:: Pipeline queue test eventdev configuration.
 
@@ -821,7 +821,7 @@ This is a pipeline test case that aims at testing the following:
 
 The pipeline queue test configures the eventdev with Q queues and P ports,
 where Q and P is a function of the number of workers, the number of producers
-and number of stages as mentioned in :numref:`table_eventdev_pipeline_queue_test`.
+and number of stages as mentioned in :numref:`testeventdev_table_pipeline_queue_test`.
 
 The user can choose the number of workers and number of stages through the
 ``--wlcores`` and the ``--stlist`` application command line arguments
@@ -906,7 +906,7 @@ This is a pipeline test case that aims at testing the following with
 #. Measure the end-to-end performance of an event dev with a ethernet dev.
 #. Maintain packet ordering from Rx to Tx.
 
-.. _table_eventdev_pipeline_atq_test:
+.. _testeventdev_table_pipeline_atq_test:
 
 .. table:: Pipeline atq test eventdev configuration.
 
@@ -946,7 +946,7 @@ This is a pipeline test case that aims at testing the following with
 
 The pipeline atq test configures the eventdev with Q queues and P ports,
 where Q and P is a function of the number of workers, the number of producers
-and number of stages as mentioned in :numref:`table_eventdev_pipeline_atq_test`.
+and number of stages as mentioned in :numref:`testeventdev_table_pipeline_atq_test`.
 
 The atq queue test functions as same as ``pipeline_queue`` test. The difference
 is, It uses, ``all type queue scheme`` instead of separate queues for each
-- 
2.54.0

