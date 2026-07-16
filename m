Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B17BC4450A
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 10:37:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E41D40270;
	Thu, 16 Jul 2026 12:37:12 +0200 (CEST)
Received: from flow-a7-smtp.messagingengine.com
 (flow-a7-smtp.messagingengine.com [103.168.172.142])
 by mails.dpdk.org (Postfix) with ESMTP id 19C8A40270
 for <dev@dpdk.org>; Thu, 16 Jul 2026 12:37:10 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.phl.internal (Postfix) with ESMTP id C244013804A0;
 Thu, 16 Jul 2026 06:37:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 06:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1784198229; x=
 1784205429; bh=aWH85yOrmfHnyfUpXivQIVxFAbm+vyOqecWq7pLqj3w=; b=i
 bu0BwzFL/gh1CttyGVWMYqtgjTo+Cx3/zwC/EyqcW4nf1sp5Ovt3z88Vm08NAHy3
 pQAKA4J3hzz75KwgMVhtie4hNaOF6YxPUoCqlobQMAyZ6/8KwwEdoVu3tnozrsP3
 7/KiM1sRGmdTDz40s1lUmgICMJXdx95b0gISvNUhkK+btickgQGK88I7fm5wdLA5
 qFNLVXGEtyHpEDzPkgG/27tSk+wh3DH4jZR0+9B2BefhuntOmAL1P4uJK7SI2wLv
 pZTrQ5sp36X4nNfP8cJQktDbogLA82yH+JNm0ZOX7HF1eoquUyd6e0V7eEmb+GjF
 eRWVSoSOGThJPjoJb3aCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784198229; x=1784205429; bh=a
 WH85yOrmfHnyfUpXivQIVxFAbm+vyOqecWq7pLqj3w=; b=jJP6spYaXYZfJ2HZv
 KLh6PX6+ulHUmCdaKCvZjcRM7+CL8alIP9StxBSirH1MljIJn7aSr8gm4IoOBmBT
 UNboATBd9a+e160zHxhMuj7R4E8dgnXvuRxysNtP/pqqO9Z4Rm9+yQzluIq0GJFq
 fcs68e8Jjf5AnD8CfIM9Ve0IMZ6dAVkGQIr39DeL1WN1mjVgUHQEvRcTfLqoss5Q
 Dmlfo3SptN2q+BIb0LwmtvxNP+zC2CUqNIKN9ytQ9luY0W8amCACsewp7KzV3BOl
 BI4Pn9hRxbmyGj5GWotFxuoH6l6G2vphVULwPA0JoIgiIqGRKj78NMqbDAzS24OL
 WiPGQ==
X-ME-Sender: <xms:VLRYam8AE3nCsqN1GNO7wUjM4Ke2EAGgmiZGHSF7wCF-du7H20JH_g>
 <xme:VLRYan8FKcMAfE7QDo8U1uNk43tB0tviSvzOPBa-DGyO_K2VVXdyZC_Ls14Cl-sdw
 0haCHXm1n6TgmtPPMlWbLUbisatqpbMtqvVJ_q9LLRvX2FUrHZRqg>
X-ME-Received: <xmr:VLRYakd1Q6mo0_cXpU0DITSNtc0oOp7bDKh41eNP8iqXNi0GcpPx6slE1LC7cmdhWO1Fl58AL3suVK7qG8M9Xuk>
X-ME-Proxy-Cause: dmFkZTFYYMSCn63oy71jJ9dw/Lcls5Q/DPxOYf3UeDsiBuWjbz+N5ZIkyYyAjHE8RJjPNE
 Vz9UXM7MGbbcZXxe3VHmRp+KVUI0jsQj5Hl9OKzD5lycZ0B0b5cZktkZ/oxfaDcFMsRyXY
 ydnfcAE67QgDQrhWKn3pmT8utepYnrmMg/0VN4ZgtVeFTRBnGRV8kq3cOUAXV+2sAPXkHt
 PbRkNLaIgTwVuzQbR+l9Ci6m/NeYXzJfOEz7OFGlpkjuayAbxBJ4p1i6MJZIkVNAn58cul
 FxMtZ0g2k7lnY8ZkBV2NpweUcVOLihmtwrAULv8WoYthN1ARxKSLylicXVPz8eKJbxWFgc
 F7yvm+S7vXIb33PQeFWWFjEIK7CJQMa2Dv2hcyT7XS15kQQzeURVGD6v6Ddbe346SkFGhO
 +rXjsyl3V+eKrdsxF4G5sFVcQa///CGphKUkgUp0kPglC/nL9xIeQ/djgAkS9OTP/icSAP
 YZsKGMrNmK2UqofXe7Hbu3377q82vQ1i6YogCdRtxWOHZQJKL/dS48aCRzHv+xqMTJsWF7
 HbZ+uzBxFfHr8fbJJEQ70qM142gcbYvOYYPL8Q6jjckGxSdaRRZCpFW+mLzv6fUkPSegcW
 kD+1L9a5gsgub2seYe2l053smjR5NRMZ7TjLnvASk4o5lhl4CNTqcpmXGzGA
X-ME-Proxy: <xmx:VLRYakrK-663ZGo0nqRjp2zg3XbbMPDIvUmAzyNN9r7VXA_i23xhQg>
 <xmx:VLRYasokmGDA2wTJpR8Slj_qjd06uIQqEnvUdNWckYbIHVzJa1AE2A>
 <xmx:VLRYatjaR5rPoeKAPslmhUc5Wfi-lGYWFgOxU-YXNgZvbZat6o4hAw>
 <xmx:VLRYakFaOnCla_U946ygY4MHJsceXtubQcD4ytH-vaF60r69S5jb0A>
 <xmx:VbRYak2R-XA2D8J_xvhmfqKGUxwVQgAshfSV4ipgmumctl-_wHxX5emF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:36:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Zongyu Wu <wuzongyu1@huawei.com>,	Kai Ji <kai.ji@intel.com>,
 Ankur Dwivedi <adwivedi@marvell.com>,	Anoob Joseph <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Julien Aube <julien_dpdk@jaube.fr>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,	Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,	John Daley <johndale@cisco.com>,
 Hyong Youb Kim <hyonkim@cisco.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Liron Himi <lironh@marvell.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>,	Wenbo Cao <caowenbo@mucse.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,	Ori Kam <orika@nvidia.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>,	Zhirun Yan <yanzhirun_163@163.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Volodymyr Fialko <vfialko@marvell.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v3 2/8] doc: remove unused labels from guides
Date: Thu, 16 Jul 2026 12:31:20 +0200
Message-ID: <20260716103632.711164-3-thomas@monjalon.net>
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

From: David Marchand <david.marchand@redhat.com>

The documentation has unused anchors that were either left behind after
a documentation refactoring, or just unused since day 1.

The guidelines no longer mandate labels for all figures and tables.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/bbdevs/overview.rst                |   2 -
 doc/guides/bbdevs/turbo_sw.rst                |   2 -
 doc/guides/compressdevs/isal.rst              |   2 -
 doc/guides/compressdevs/overview.rst          |   2 -
 doc/guides/compressdevs/uadk.rst              |   2 -
 doc/guides/contributing/abi_policy.rst        |   4 -
 doc/guides/contributing/cheatsheet.rst        |   2 -
 doc/guides/contributing/documentation.rst     |  30 +--
 doc/guides/contributing/patches.rst           |   2 -
 doc/guides/cryptodevs/aesni_gcm.rst           |   2 -
 doc/guides/cryptodevs/aesni_mb.rst            |   2 -
 doc/guides/cryptodevs/cnxk.rst                |   2 -
 doc/guides/cryptodevs/overview.rst            |  12 --
 doc/guides/cryptodevs/qat.rst                 |   5 -
 doc/guides/cryptodevs/snow3g.rst              |   2 -
 doc/guides/cryptodevs/uadk.rst                |   2 -
 doc/guides/cryptodevs/zuc.rst                 |   2 -
 doc/guides/eventdevs/cnxk.rst                 |   2 -
 doc/guides/eventdevs/overview.rst             |  14 --
 doc/guides/howto/flow_bifurcation.rst         |   2 -
 doc/guides/howto/lm_bond_virtio_sriov.rst     |   2 -
 doc/guides/howto/lm_virtio_vhost_user.rst     |   2 -
 doc/guides/howto/pvp_reference_benchmark.rst  |   2 -
 doc/guides/howto/vfd.rst                      |   2 -
 .../howto/virtio_user_as_exception_path.rst   |   2 -
 .../virtio_user_for_container_networking.rst  |   2 -
 doc/guides/linux_gsg/build_dpdk.rst           |   2 -
 doc/guides/mempool/cnxk.rst                   |   2 -
 doc/guides/mldevs/cnxk.rst                    |   6 -
 doc/guides/nics/bnx2x.rst                     |   2 -
 doc/guides/nics/cnxk.rst                      |   2 -
 doc/guides/nics/enic.rst                      |   6 -
 doc/guides/nics/ice.rst                       |   2 -
 doc/guides/nics/mvpp2.rst                     |   2 -
 doc/guides/nics/overview.rst                  |   2 -
 doc/guides/nics/qede.rst                      |   4 -
 doc/guides/nics/rnp.rst                       |   2 -
 doc/guides/nics/virtio.rst                    |   2 -
 doc/guides/nics/vmxnet3.rst                   |   6 -
 doc/guides/platform/cnxk.rst                  |   2 -
 doc/guides/platform/dpaa2.rst                 |   2 -
 doc/guides/prog_guide/dmadev.rst              |   2 -
 doc/guides/prog_guide/efd_lib.rst             |   5 -
 .../prog_guide/env_abstraction_layer.rst      |   4 -
 doc/guides/prog_guide/ethdev/flow_offload.rst | 190 ------------------
 .../prog_guide/ethdev/qos_framework.rst       |  21 --
 .../eventdev/event_crypto_adapter.rst         |   4 -
 .../prog_guide/eventdev/event_dma_adapter.rst |   4 -
 doc/guides/prog_guide/eventdev/eventdev.rst   |   2 -
 doc/guides/prog_guide/graph_lib.rst           |   6 -
 doc/guides/prog_guide/hash_lib.rst            |   4 -
 doc/guides/prog_guide/member_lib.rst          |   8 -
 doc/guides/prog_guide/mempool_lib.rst         |   3 -
 doc/guides/prog_guide/mldev.rst               |   2 -
 doc/guides/prog_guide/multi_proc_support.rst  |   2 -
 doc/guides/prog_guide/overview.rst            |   2 -
 doc/guides/prog_guide/packet_framework.rst    |  11 -
 doc/guides/prog_guide/pdcp_lib.rst            |   2 -
 doc/guides/prog_guide/pdump_lib.rst           |   2 -
 doc/guides/prog_guide/ring_lib.rst            |  43 ----
 doc/guides/prog_guide/trace_lib.rst           |   8 -
 doc/guides/regexdevs/cn9k.rst                 |   2 -
 doc/guides/regexdevs/features_overview.rst    |   2 -
 doc/guides/rel_notes/release_20_02.rst        |   2 -
 doc/guides/sample_app_ug/dist_app.rst         |   2 -
 doc/guides/sample_app_ug/ip_pipeline.rst      |   4 -
 .../sample_app_ug/l2_forward_crypto.rst       |   2 -
 doc/guides/sample_app_ug/l2_forward_event.rst |  10 -
 .../sample_app_ug/l2_forward_real_virtual.rst |   2 -
 doc/guides/sample_app_ug/l3_forward.rst       |   4 -
 doc/guides/sample_app_ug/l3_forward_graph.rst |   2 -
 doc/guides/sample_app_ug/multi_process.rst    |   4 -
 doc/guides/sample_app_ug/ptpclient.rst        |   2 -
 doc/guides/sample_app_ug/qos_metering.rst     |   2 -
 doc/guides/sample_app_ug/qos_scheduler.rst    |   4 -
 doc/guides/sample_app_ug/test_pipeline.rst    |   2 -
 doc/guides/sample_app_ug/vdpa.rst             |   2 -
 doc/guides/sample_app_ug/vhost.rst            |   5 -
 doc/guides/sample_app_ug/vhost_blk.rst        |   2 -
 doc/guides/sample_app_ug/vhost_crypto.rst     |   2 -
 .../sample_app_ug/vm_power_management.rst     |   5 -
 doc/guides/tools/dts.rst                      |   4 -
 doc/guides/tools/graph.rst                    |   4 -
 doc/guides/tools/pdump.rst                    |   2 -
 doc/guides/tools/testeventdev.rst             |  28 ---
 doc/guides/tools/testmldev.rst                |  12 --
 doc/guides/vdpadevs/features_overview.rst     |   2 -
 doc/guides/windows_gsg/index.rst              |   2 -
 88 files changed, 2 insertions(+), 590 deletions(-)

diff --git a/doc/guides/bbdevs/overview.rst b/doc/guides/bbdevs/overview.rst
index 8dc35a3c1b..92dc290ca6 100644
--- a/doc/guides/bbdevs/overview.rst
+++ b/doc/guides/bbdevs/overview.rst
@@ -7,6 +7,4 @@ Baseband Device Supported Functionality Matrices
 Supported Feature Flags
 -----------------------
 
-.. _table_bbdev_pmd_features:
-
 .. include:: overview_feature_table.txt
diff --git a/doc/guides/bbdevs/turbo_sw.rst b/doc/guides/bbdevs/turbo_sw.rst
index 396531669e..9064f1cc52 100644
--- a/doc/guides/bbdevs/turbo_sw.rst
+++ b/doc/guides/bbdevs/turbo_sw.rst
@@ -78,8 +78,6 @@ To get the FlexRAN FEC SDK user manual, extract this `doxygen
 
 The following table maps DPDK versions with past FlexRAN SDK releases:
 
-.. _table_flexran_releases:
-
 .. table:: DPDK and FlexRAN FEC SDK releases compliance
 
    =====================  ============================
diff --git a/doc/guides/compressdevs/isal.rst b/doc/guides/compressdevs/isal.rst
index 029f8e23d2..1692897eb6 100644
--- a/doc/guides/compressdevs/isal.rst
+++ b/doc/guides/compressdevs/isal.rst
@@ -65,8 +65,6 @@ The ISA-L library does not support this, therefore compressdev level 0 is not su
 The compressdev API has 10 levels, 0-9. ISA-L has 4 levels of compression, 0-3.
 As a result the level mappings from the API to the PMD are shown below.
 
-.. _table_ISA-L_compression_levels:
-
 .. table:: Level mapping from Compressdev to ISA-L PMD.
 
    +-------------+----------------------------------------------+-----------------------------------------------+
diff --git a/doc/guides/compressdevs/overview.rst b/doc/guides/compressdevs/overview.rst
index 809e4e6e76..6f2acd25bc 100644
--- a/doc/guides/compressdevs/overview.rst
+++ b/doc/guides/compressdevs/overview.rst
@@ -7,8 +7,6 @@ Compression Device Supported Functionality Matrices
 Supported Feature Flags
 -----------------------
 
-.. _table_compression_pmd_features:
-
 .. include:: overview_feature_table.txt
 
 .. Note::
diff --git a/doc/guides/compressdevs/uadk.rst b/doc/guides/compressdevs/uadk.rst
index b7207478dc..27245da892 100644
--- a/doc/guides/compressdevs/uadk.rst
+++ b/doc/guides/compressdevs/uadk.rst
@@ -100,8 +100,6 @@ Test steps
 As a reference, the following table shows a mapping between the past DPDK versions
 and the UADK library version supported by them:
 
-.. _table_uadk_compress_pmd_versions:
-
 .. table:: DPDK and external UADK library version compatibility
 
    ==============  ============================
diff --git a/doc/guides/contributing/abi_policy.rst b/doc/guides/contributing/abi_policy.rst
index 9e9994c362..1b871dc05d 100644
--- a/doc/guides/contributing/abi_policy.rst
+++ b/doc/guides/contributing/abi_policy.rst
@@ -53,8 +53,6 @@ Therefore, in the case of dynamic linking, it is critical that an ABI is
 preserved, or (when modified), done in such a way that the application is unable
 to behave improperly or in an unexpected fashion.
 
-.. _figure_what_is_an_abi:
-
 .. figure:: img/what_is_an_abi.*
 
 	    Illustration of DPDK API and ABI.
@@ -104,8 +102,6 @@ An ABI version is supported in all new releases until the next major ABI version
 is declared. When changing the major ABI version, the release notes will detail
 all ABI changes.
 
-.. _figure_abi_stability_policy:
-
 .. figure:: img/abi_stability_policy.*
 
 	    Mapping of new ABI versions and ABI version compatibility to DPDK
diff --git a/doc/guides/contributing/cheatsheet.rst b/doc/guides/contributing/cheatsheet.rst
index 0debd118d7..a37628b4d7 100644
--- a/doc/guides/contributing/cheatsheet.rst
+++ b/doc/guides/contributing/cheatsheet.rst
@@ -4,8 +4,6 @@
 Patch Cheatsheet
 ================
 
-.. _figure_patch_cheatsheet:
-
 .. figure:: img/patch_cheatsheet.*
 
    Cheat sheet for submitting patches to dev@dpdk.org
diff --git a/doc/guides/contributing/documentation.rst b/doc/guides/contributing/documentation.rst
index df1a31da17..b8ef8131b5 100644
--- a/doc/guides/contributing/documentation.rst
+++ b/doc/guides/contributing/documentation.rst
@@ -133,8 +133,6 @@ added to by the developer.
 Building the Documentation
 --------------------------
 
-.. _doc_dependencies:
-
 Dependencies
 ~~~~~~~~~~~~
 
@@ -524,6 +522,7 @@ Images
 
   This would be rendered as: *A mempool in memory with its associated ring.*
 
+
 Tables
 ~~~~~~
 
@@ -531,32 +530,7 @@ Tables
   They are hard to format and to edit, and the same information
   can usually be shown just as clearly with a definition or bullet list.
 
-* Tables in the documentation should be formatted as follows:
-
-   * The table should be preceded by a label in the format ``.. _table_XXXX:`` with a leading underscore and where
-     ``XXXX`` is a unique descriptive name.
-
-   * Tables should be included using the ``.. table::`` directive and must have a caption.
-
-* Here is an example of the previous two guidelines::
-
-     .. _table_qos_pipes:
-
-     .. table:: Sample configuration for QOS pipes.
-
-        +----------+----------+----------+
-        | Header 1 | Header 2 | Header 3 |
-        |          |          |          |
-        +==========+==========+==========+
-        | Text     | Text     | Text     |
-        +----------+----------+----------+
-        | ...      | ...      | ...      |
-        +----------+----------+----------+
-
-* Tables can be linked to using the ``:numref:`` and ``:ref:`` directives, as shown in the previous section for images.
-  For example::
-
-     The QOS configuration is shown in :numref:`table_qos_pipes`.
+* Tables should be included using the ``.. table::`` directive and must have a caption.
 
 
 .. _links:
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index 7a6c3961ba..682f4fda28 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -452,8 +452,6 @@ For example::
      since 802.1AS can be supported through the same interfaces.
 
 
-.. _contrib_checkpatch:
-
 Checking the Patches
 --------------------
 
diff --git a/doc/guides/cryptodevs/aesni_gcm.rst b/doc/guides/cryptodevs/aesni_gcm.rst
index e18276b6c8..4683e9dd86 100644
--- a/doc/guides/cryptodevs/aesni_gcm.rst
+++ b/doc/guides/cryptodevs/aesni_gcm.rst
@@ -70,8 +70,6 @@ Once it is downloaded, extract it and follow these steps:
 As a reference, the following table shows a mapping between the past DPDK versions
 and the external crypto libraries supported by them:
 
-.. _table_aesni_gcm_versions:
-
 .. table:: DPDK and external crypto library version compatibility
 
    =============  ================================
diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index c3e3b29af4..ab7a6138a8 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -125,8 +125,6 @@ Once it is downloaded, extract it and follow these steps:
 As a reference, the following table shows a mapping between the past DPDK versions
 and the Multi-Buffer library version supported by them:
 
-.. _table_aesni_mb_versions:
-
 .. table:: DPDK and Multi-Buffer library version compatibility
 
    ==============  ============================
diff --git a/doc/guides/cryptodevs/cnxk.rst b/doc/guides/cryptodevs/cnxk.rst
index e6184956a2..42564872a6 100644
--- a/doc/guides/cryptodevs/cnxk.rst
+++ b/doc/guides/cryptodevs/cnxk.rst
@@ -214,8 +214,6 @@ Runtime Config Options
 Debugging Options
 -----------------
 
-.. _table_octeon_cnxk_crypto_debug_options:
-
 .. table:: OCTEON cnxk crypto PMD debug options
 
     +---+------------+-------------------------------------------------------+
diff --git a/doc/guides/cryptodevs/overview.rst b/doc/guides/cryptodevs/overview.rst
index 4f963ed24e..62632bdfd7 100644
--- a/doc/guides/cryptodevs/overview.rst
+++ b/doc/guides/cryptodevs/overview.rst
@@ -7,8 +7,6 @@ Crypto Device Supported Functionality Matrices
 Supported Feature Flags
 -----------------------
 
-.. _table_crypto_pmd_features:
-
 .. include:: overview_feature_table.txt
 
 .. Note::
@@ -56,34 +54,24 @@ Supported Feature Flags
 Supported Cipher Algorithms
 ---------------------------
 
-.. _table_crypto_pmd_cipher_algos:
-
 .. include:: overview_cipher_table.txt
 
 Supported Authentication Algorithms
 -----------------------------------
 
-.. _table_crypto_pmd_auth_algos:
-
 .. include:: overview_auth_table.txt
 
 Supported AEAD Algorithms
 -------------------------
 
-.. _table_crypto_pmd_aead_algos:
-
 .. include:: overview_aead_table.txt
 
 Supported Asymmetric Algorithms
 -------------------------------
 
-.. _table_crypto_pmd_asym_algos:
-
 .. include:: overview_asym_table.txt
 
 Supported Operating Systems
 ---------------------------
 
-.. _table_crypto_pmd_os:
-
 .. include:: overview_os_table.txt
diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index 7a056ce902..e72bdc4736 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -227,8 +227,6 @@ Configuring and Building the DPDK QAT PMDs
 Further information on configuring, building and installing DPDK is described
 :doc:`here <../linux_gsg/build_dpdk>`.
 
-.. _building_qat_config:
-
 Build Configuration
 ~~~~~~~~~~~~~~~~~~~
 
@@ -444,9 +442,6 @@ Available kernel drivers
 Kernel drivers for each device for each service are listed in the following table. (Scroll right
 to see the full table)
 
-
-.. _table_qat_pmds_drivers:
-
 .. table:: QAT device generations, devices and drivers
 
    +-----+-----+-----+-----+----------+---------------+---------------+------------+--------+------+--------+--------+
diff --git a/doc/guides/cryptodevs/snow3g.rst b/doc/guides/cryptodevs/snow3g.rst
index a11dda1744..e1db5d39ad 100644
--- a/doc/guides/cryptodevs/snow3g.rst
+++ b/doc/guides/cryptodevs/snow3g.rst
@@ -75,8 +75,6 @@ Once it is downloaded, extract it and follow these steps:
 As a reference, the following table shows a mapping between the past DPDK versions
 and the external crypto libraries supported by them:
 
-.. _table_snow3g_versions:
-
 .. table:: DPDK and external crypto library version compatibility
 
    =============  ================================
diff --git a/doc/guides/cryptodevs/uadk.rst b/doc/guides/cryptodevs/uadk.rst
index e017ce34ba..ae55e8ba64 100644
--- a/doc/guides/cryptodevs/uadk.rst
+++ b/doc/guides/cryptodevs/uadk.rst
@@ -114,8 +114,6 @@ Test steps
 As a reference, the following table shows a mapping between the past DPDK versions
 and the UADK library version supported by them:
 
-.. _table_uadk_crypto_pmd_versions:
-
 .. table:: DPDK and external UADK library version compatibility
 
    ==============  ============================
diff --git a/doc/guides/cryptodevs/zuc.rst b/doc/guides/cryptodevs/zuc.rst
index 61512d9d90..91b7267362 100644
--- a/doc/guides/cryptodevs/zuc.rst
+++ b/doc/guides/cryptodevs/zuc.rst
@@ -74,8 +74,6 @@ Once it is downloaded, extract it and follow these steps:
 As a reference, the following table shows a mapping between the past DPDK versions
 and the external crypto libraries supported by them:
 
-.. _table_zuc_versions:
-
 .. table:: DPDK and external crypto library version compatibility
 
    =============  ================================
diff --git a/doc/guides/eventdevs/cnxk.rst b/doc/guides/eventdevs/cnxk.rst
index 0bfa3d6f0a..163acbf609 100644
--- a/doc/guides/eventdevs/cnxk.rst
+++ b/doc/guides/eventdevs/cnxk.rst
@@ -202,8 +202,6 @@ This feature can be selected by configuring meson with ``RTE_ARM_USE_WFE`` enabl
 Debugging Options
 -----------------
 
-.. _table_octeon_cnxk_event_debug_options:
-
 .. table:: OCTEON cnxk event device debug options
 
    +---+------------+-------------------------------------------------------+
diff --git a/doc/guides/eventdevs/overview.rst b/doc/guides/eventdevs/overview.rst
index decae3bd4e..94c03013db 100644
--- a/doc/guides/eventdevs/overview.rst
+++ b/doc/guides/eventdevs/overview.rst
@@ -7,49 +7,35 @@ Event Device Supported Functionality Matrices
 Event device supported features
 -------------------------------
 
-.. _table_eventdev_pmd_features:
-
 .. include:: overview_feature_table.txt
 
 Ethernet Rx adapter supported features
 --------------------------------------
 
-.. _table_eventdev_rx_adapter_features:
-
 .. include:: overview_rx_adptr_feature_table.txt
 
 Ethernet Tx adapter supported features
 --------------------------------------
 
-.. _table_eventdev_tx_adapter_features:
-
 .. include:: overview_tx_adptr_feature_table.txt
 
 Crypto device adapter supported features
 ----------------------------------------
 
-.. _table_cryptodev_adapter_features:
-
 .. include:: overview_crypto_adptr_feature_table.txt
 
 DMA adapter supported features
 ------------------------------
 
-.. _table_dma_adapter_features:
-
 .. include:: overview_dma_adptr_feature_table.txt
 
 
 Timer adapter supported features
 --------------------------------
 
-.. _table_timer_adapter_features:
-
 .. include:: overview_timer_adptr_feature_table.txt
 
 Event vector adapter supported features
 ---------------------------------------
 
-.. _table_vector_adapter_features:
-
 .. include:: overview_vector_adptr_feature_table.txt
diff --git a/doc/guides/howto/flow_bifurcation.rst b/doc/guides/howto/flow_bifurcation.rst
index 5d2127bc31..69885e6eb6 100644
--- a/doc/guides/howto/flow_bifurcation.rst
+++ b/doc/guides/howto/flow_bifurcation.rst
@@ -36,8 +36,6 @@ the kernel driver while a DPDK application can receive specific traffic
 bypassing the Linux kernel by using drivers like VFIO or the DPDK ``igb_uio``
 module.
 
-.. _figure_flow_bifurcation_overview:
-
 .. figure:: img/flow_bifurcation_overview.*
 
    Flow Bifurcation Overview
diff --git a/doc/guides/howto/lm_bond_virtio_sriov.rst b/doc/guides/howto/lm_bond_virtio_sriov.rst
index 1d46ebb27f..c98cbc9023 100644
--- a/doc/guides/howto/lm_bond_virtio_sriov.rst
+++ b/doc/guides/howto/lm_bond_virtio_sriov.rst
@@ -40,8 +40,6 @@ The ip address of host_server_1 is 10.237.212.46
 
 The ip address of host_server_2 is 10.237.212.131
 
-.. _figure_lm_bond_virtio_sriov:
-
 .. figure:: img/lm_bond_virtio_sriov.*
 
 Live Migration steps
diff --git a/doc/guides/howto/lm_virtio_vhost_user.rst b/doc/guides/howto/lm_virtio_vhost_user.rst
index 94ab71d653..cef6aa87f2 100644
--- a/doc/guides/howto/lm_virtio_vhost_user.rst
+++ b/doc/guides/howto/lm_virtio_vhost_user.rst
@@ -32,8 +32,6 @@ The ip address of host_server_1 is 10.237.212.46
 
 The ip address of host_server_2 is 10.237.212.131
 
-.. _figure_lm_vhost_user:
-
 .. figure:: img/lm_vhost_user.*
 
 Live Migration steps
diff --git a/doc/guides/howto/pvp_reference_benchmark.rst b/doc/guides/howto/pvp_reference_benchmark.rst
index bec97b8675..c2de0bbc74 100644
--- a/doc/guides/howto/pvp_reference_benchmark.rst
+++ b/doc/guides/howto/pvp_reference_benchmark.rst
@@ -20,8 +20,6 @@ v16.11 using RHEL7 for both host and guest.
 Setup overview
 --------------
 
-.. _figure_pvp_2nics:
-
 .. figure:: img/pvp_2nics.*
 
    PVP setup using 2 NICs
diff --git a/doc/guides/howto/vfd.rst b/doc/guides/howto/vfd.rst
index 62bcdfe15a..61fb5d3205 100644
--- a/doc/guides/howto/vfd.rst
+++ b/doc/guides/howto/vfd.rst
@@ -33,8 +33,6 @@ application will configure the feature for the VF. Obviously, the PF
 application can also configure the VF features without a request from the VF
 application.
 
-.. _VF_daemon_overview:
-
 .. figure:: img/vf_daemon_overview.*
 
    VF daemon (VFd) Overview
diff --git a/doc/guides/howto/virtio_user_as_exception_path.rst b/doc/guides/howto/virtio_user_as_exception_path.rst
index 0d4c8aeb94..bb4b6e6fa2 100644
--- a/doc/guides/howto/virtio_user_as_exception_path.rst
+++ b/doc/guides/howto/virtio_user_as_exception_path.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2016 Intel Corporation.
 
-.. _virtio_user_as_exception_path:
-
 Virtio_user as Exception Path
 =============================
 
diff --git a/doc/guides/howto/virtio_user_for_container_networking.rst b/doc/guides/howto/virtio_user_for_container_networking.rst
index 23f53199da..1798cdf327 100644
--- a/doc/guides/howto/virtio_user_for_container_networking.rst
+++ b/doc/guides/howto/virtio_user_for_container_networking.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2016 Intel Corporation.
 
-.. _virtio_user_for_container_networking:
-
 Virtio_user for Container Networking
 ====================================
 
diff --git a/doc/guides/linux_gsg/build_dpdk.rst b/doc/guides/linux_gsg/build_dpdk.rst
index ed30e4a5f1..242c07718d 100644
--- a/doc/guides/linux_gsg/build_dpdk.rst
+++ b/doc/guides/linux_gsg/build_dpdk.rst
@@ -82,8 +82,6 @@ and the last step causing the dynamic loader `ld.so` to update its cache to take
    distributions, `/usr/local/lib` and `/usr/local/lib64` should be added
    to a file in `/etc/ld.so.conf.d/` before running `ldconfig`.
 
-.. _adjusting_build_options:
-
 Adjusting Build Options
 ~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/mempool/cnxk.rst b/doc/guides/mempool/cnxk.rst
index 323acc3f0e..7b27ef7aab 100644
--- a/doc/guides/mempool/cnxk.rst
+++ b/doc/guides/mempool/cnxk.rst
@@ -84,8 +84,6 @@ Runtime Config Options
 Debugging Options
 ~~~~~~~~~~~~~~~~~
 
-.. _table_cnxk_mempool_debug_options:
-
 .. table:: cnxk mempool debug options
 
    +---+------------+-------------------------------------------------------+
diff --git a/doc/guides/mldevs/cnxk.rst b/doc/guides/mldevs/cnxk.rst
index 17e58d81c0..afd0224fe2 100644
--- a/doc/guides/mldevs/cnxk.rst
+++ b/doc/guides/mldevs/cnxk.rst
@@ -345,8 +345,6 @@ Runtime Config Options
 Debugging Options
 -----------------
 
-.. _table_octeon_cnxk_ml_debug_options:
-
 .. table:: OCTEON cnxk ML PMD debug options
 
    +---+------------+-------------------------------------------------------+
@@ -363,8 +361,6 @@ Marvell cnxk ML PMD supports reporting the device and model extended statistics.
 
 PMD supports the below list of 4 device extended stats.
 
-.. _table_octeon_cnxk_ml_device_xstats_names:
-
 .. table:: OCTEON cnxk ML PMD device xstats names
 
    +---+---------------------+----------------------------------------------+
@@ -382,8 +378,6 @@ PMD supports the below list of 4 device extended stats.
 
 PMD supports the below list of 6 extended stats types per each model.
 
-.. _table_octeon_cnxk_ml_model_xstats_names:
-
 .. table:: OCTEON cnxk ML PMD model xstats names
 
    +---+---------------------+----------------------------------------------+
diff --git a/doc/guides/nics/bnx2x.rst b/doc/guides/nics/bnx2x.rst
index c24d32b9ab..c39fa7bfb0 100644
--- a/doc/guides/nics/bnx2x.rst
+++ b/doc/guides/nics/bnx2x.rst
@@ -99,8 +99,6 @@ enabling debugging options may affect system performance.
 
   Toggle display of register reads and writes.
 
-.. _bnx2x_driver-compilation:
-
 Driver compilation and testing
 ------------------------------
 
diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index ccd5236bff..30b2747787 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -815,8 +815,6 @@ Port representor PMD supports following operations:
 Debugging Options
 -----------------
 
-.. _table_cnxk_ethdev_debug_options:
-
 .. table:: cnxk ethdev debug options
 
    +---+------------+-------------------------------------------------------+
diff --git a/doc/guides/nics/enic.rst b/doc/guides/nics/enic.rst
index a400bbc4f7..6c468ea3af 100644
--- a/doc/guides/nics/enic.rst
+++ b/doc/guides/nics/enic.rst
@@ -219,8 +219,6 @@ There are two known limitations of the current SR-IOV implementation.
    and assign them to VMs as passthrough devices.
 
 
-.. _enic-generic-flow-api:
-
 Generic Flow API support
 ------------------------
 
@@ -279,8 +277,6 @@ the (stripped) VLAN header whether stripping is enabled or disabled.
 More features may be added in future firmware and new versions of the VIC.
 Please refer to the release notes.
 
-.. _overlay_offload:
-
 Overlay Offload
 ---------------
 
@@ -429,8 +425,6 @@ To verify the selected entry size, enable debug logging
     PMD: rte_enic_pmd: Supported CQ entry sizes: 16 32
     PMD: rte_enic_pmd: Using 16B CQ entry size
 
-.. _enic_limitations:
-
 Limitations
 -----------
 
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 413478b727..7e23a3cad3 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -892,8 +892,6 @@ Additional Options
 
     -a 18:01.0,cap=dcf,acl=off
 
-.. _figure_ice_dcf:
-
 .. figure:: img/ice_dcf.*
 
    DCF Communication flow.
diff --git a/doc/guides/nics/mvpp2.rst b/doc/guides/nics/mvpp2.rst
index 07be97dfb8..3ecb253ae6 100644
--- a/doc/guides/nics/mvpp2.rst
+++ b/doc/guides/nics/mvpp2.rst
@@ -2,8 +2,6 @@
     Copyright(c) 2017 Marvell International Ltd.
     Copyright(c) 2017 Semihalf.
 
-.. _mvpp2_poll_mode_driver:
-
 MVPP2 Poll Mode Driver
 ======================
 
diff --git a/doc/guides/nics/overview.rst b/doc/guides/nics/overview.rst
index 4553076481..3179629fa6 100644
--- a/doc/guides/nics/overview.rst
+++ b/doc/guides/nics/overview.rst
@@ -26,8 +26,6 @@ More details about features can be found in :doc:`features`.
 
 .. rst-class:: widepage
 
-.. _table_net_pmd_features:
-
 .. include:: overview_table.txt
 
 .. Note::
diff --git a/doc/guides/nics/qede.rst b/doc/guides/nics/qede.rst
index c99606877b..ddca443f36 100644
--- a/doc/guides/nics/qede.rst
+++ b/doc/guides/nics/qede.rst
@@ -155,8 +155,6 @@ actions.
 
 Patterns:
 
-.. _table_qede_supported_flow_item_types:
-
 .. table:: Item types
 
    +----+--------------------------------+
@@ -173,8 +171,6 @@ Patterns:
 
 Actions:
 
-.. _table_qede_supported_ingress_action_types:
-
 .. table:: Ingress action types
 
    +----+--------------------------------+
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index 706cd04fa7..8729cdd061 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -32,8 +32,6 @@ Chip Basic Overview
 N10 has two functions, each function support multiple ports (1 to 8),
 which is different of normal PCIe network card (one PF for each port).
 
-.. _figure_mucse_nic:
-
 .. figure:: img/mucse_nic_port.*
 
    rnp Mucse NIC port.
diff --git a/doc/guides/nics/virtio.rst b/doc/guides/nics/virtio.rst
index a7642d96ce..e8a6dd02fe 100644
--- a/doc/guides/nics/virtio.rst
+++ b/doc/guides/nics/virtio.rst
@@ -93,8 +93,6 @@ The following prerequisites apply:
 Virtio with qemu virtio Back End
 --------------------------------
 
-.. _figure_host_vm_comms_qemu:
-
 .. figure:: img/host_vm_comms_qemu.*
 
    Host2VM Communication Example Using qemu vhost Back End
diff --git a/doc/guides/nics/vmxnet3.rst b/doc/guides/nics/vmxnet3.rst
index 3f498b905d..743369995a 100644
--- a/doc/guides/nics/vmxnet3.rst
+++ b/doc/guides/nics/vmxnet3.rst
@@ -110,8 +110,6 @@ The following prerequisites apply:
 *   Before starting a VM, a VMXNET3 interface to a VM through VMware vSphere Client must be assigned.
     This is shown in the figure below.
 
-.. _figure_vmxnet3_int:
-
 .. figure:: img/vmxnet3_int.*
 
    Assigning a VMXNET3 interface to a VM using VMware vSphere Client
@@ -135,8 +133,6 @@ VMXNET3 with a Native NIC Connected to a vSwitch
 
 This section describes an example setup for Phy-vSwitch-VM-Phy communication.
 
-.. _figure_vswitch_vm:
-
 .. figure:: img/vswitch_vm.*
 
    VMXNET3 with a Native NIC Connected to a vSwitch
@@ -162,8 +158,6 @@ VMXNET3 Chaining VMs Connected to a vSwitch
 
 The following figure shows an example VM-to-VM communication over a Phy-VM-vSwitch-VM-Phy communication channel.
 
-.. _figure_vm_vm_comms:
-
 .. figure:: img/vm_vm_comms.*
 
    VMXNET3 Chaining VMs Connected to a vSwitch
diff --git a/doc/guides/platform/cnxk.rst b/doc/guides/platform/cnxk.rst
index c0e92dabbf..f5248dae54 100644
--- a/doc/guides/platform/cnxk.rst
+++ b/doc/guides/platform/cnxk.rst
@@ -248,8 +248,6 @@ compatible board:
 Debugging Options
 -----------------
 
-.. _table_cnxk_common_debug_options:
-
 .. table:: cnxk common debug options
 
    +---+------------+-------------------------------------------------------+
diff --git a/doc/guides/platform/dpaa2.rst b/doc/guides/platform/dpaa2.rst
index c9ec21334f..fe627bc0c1 100644
--- a/doc/guides/platform/dpaa2.rst
+++ b/doc/guides/platform/dpaa2.rst
@@ -94,8 +94,6 @@ separately:
   SDK and related information can be obtained from:  `NXP QorIQ SDK  <http://www.nxp.com/products/software-and-tools/run-time-software/linux-sdk/linux-sdk-for-qoriq-processors:SDKLINUX>`_.
 
 
-.. _extra_scripts:
-
 - **DPDK Extra Scripts**
 
   DPAA2 based resources can be configured easily with the help of ready scripts
diff --git a/doc/guides/prog_guide/dmadev.rst b/doc/guides/prog_guide/dmadev.rst
index df25b52461..98f88ad8eb 100644
--- a/doc/guides/prog_guide/dmadev.rst
+++ b/doc/guides/prog_guide/dmadev.rst
@@ -17,8 +17,6 @@ physical (hardware) and virtual (software) DMA devices, as well as a generic DMA
 API which allows DMA devices to be managed and configured, and supports DMA
 operations to be provisioned on DMA poll mode driver.
 
-.. _figure_dmadev:
-
 .. figure:: img/dmadev.*
 
 The above figure shows the model on which the DMA framework is built on:
diff --git a/doc/guides/prog_guide/efd_lib.rst b/doc/guides/prog_guide/efd_lib.rst
index 7941c83821..b6296961db 100644
--- a/doc/guides/prog_guide/efd_lib.rst
+++ b/doc/guides/prog_guide/efd_lib.rst
@@ -155,7 +155,6 @@ In summary, EFD is a set separation data structure that supports millions of
 keys. It is used to distribute a given key to an intended target. By itself
 EFD is not a FIB data structure with an exact match the input flow key.
 
-.. _Efd_example:
 
 Example of EFD Library Usage
 ----------------------------
@@ -199,7 +198,6 @@ the flows served at each node is used and is
 exact matched with the input key to rule out new never seen before
 flows.
 
-.. _Efd_api:
 
 Library API Overview
 --------------------
@@ -281,7 +279,6 @@ in the prev_value argument.
    This function is not multi-thread safe and should only be called
    from one thread.
 
-.. _Efd_internals:
 
 Library Internals
 -----------------
@@ -414,8 +411,6 @@ balanced key distribution across these four is selected the mapping result
 is stored in these two bits.
 
 
-.. _Efd_references:
-
 References
 ----------
 
diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index 29af5dc9be..f63325bd24 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -52,8 +52,6 @@ A check is also performed at initialization time to ensure that the micro archit
 Then, the main() function is called. The core initialization and launch is done in rte_eal_init() (see the API documentation).
 It consist of calls to the pthread library (more specifically, pthread_self(), pthread_create(), and pthread_setaffinity_np()).
 
-.. _figure_linux_launch:
-
 .. figure:: img/linuxapp_launch.*
 
    EAL Initialization in a Linux Application Environment
@@ -1058,8 +1056,6 @@ The key fields of the heap structure and their function are described below
 
 *   last - this points to the last element in the heap.
 
-.. _figure_malloc_heap:
-
 .. figure:: img/malloc_heap.*
 
    Example of a malloc heap and malloc elements within the malloc library
diff --git a/doc/guides/prog_guide/ethdev/flow_offload.rst b/doc/guides/prog_guide/ethdev/flow_offload.rst
index bb2986b67c..60b26d868b 100644
--- a/doc/guides/prog_guide/ethdev/flow_offload.rst
+++ b/doc/guides/prog_guide/ethdev/flow_offload.rst
@@ -259,8 +259,6 @@ Usage restrictions and expected behavior:
 
 Example of an item specification matching an Ethernet header:
 
-.. _table_rte_flow_pattern_item_example:
-
 .. table:: Ethernet item
 
    +----------+----------+-----------------------+
@@ -300,8 +298,6 @@ Patterns are terminated by END items.
 
 Examples:
 
-.. _table_rte_flow_tcpv4_as_l4:
-
 .. table:: TCPv4 as L4
 
    +-------+----------+
@@ -318,8 +314,6 @@ Examples:
 
 |
 
-.. _table_rte_flow_tcpv6_in_vxlan:
-
 .. table:: TCPv6 in VXLAN
 
    +-------+------------+
@@ -344,8 +338,6 @@ Examples:
 
 |
 
-.. _table_rte_flow_tcpv4_as_l4_meta:
-
 .. table:: TCPv4 as L4 with meta items
 
    +-------+----------+
@@ -372,8 +364,6 @@ The above example shows how meta items do not affect packet data matching
 items, as long as those remain stacked properly. The resulting matching
 pattern is identical to "TCPv4 as L4".
 
-.. _table_rte_flow_udpv6_anywhere:
-
 .. table:: UDPv6 anywhere
 
    +-------+------+
@@ -394,8 +384,6 @@ It is unspecified whether the payload of supported encapsulations
 (e.g. VXLAN payload) is matched by such a pattern, which may apply to inner,
 outer or both packets.
 
-.. _table_rte_flow_invalid_l3:
-
 .. table:: Invalid, missing L3
 
    +-------+----------+
@@ -430,8 +418,6 @@ ending the pattern.
 - PMD support is mandatory.
 - ``spec``, ``last`` and ``mask`` are ignored.
 
-.. _table_rte_flow_item_end:
-
 .. table:: END
 
    +----------+---------+
@@ -453,8 +439,6 @@ PMDs.
 - PMD support is mandatory.
 - ``spec``, ``last`` and ``mask`` are ignored.
 
-.. _table_rte_flow_item_void:
-
 .. table:: VOID
 
    +----------+---------+
@@ -470,8 +454,6 @@ PMDs.
 One usage example for this type is generating rules that share a common
 prefix quickly without reallocating memory, only by updating item types:
 
-.. _table_rte_flow_item_void_example:
-
 .. table:: TCP, UDP or ICMP as L4
 
    +-------+--------------------+
@@ -497,8 +479,6 @@ Inverted matching, i.e. process packets that do not match the pattern.
 
 - ``spec``, ``last`` and ``mask`` are ignored.
 
-.. _table_rte_flow_item_invert:
-
 .. table:: INVERT
 
    +----------+---------+
@@ -513,8 +493,6 @@ Inverted matching, i.e. process packets that do not match the pattern.
 
 Usage example, matching non-TCPv4 packets only:
 
-.. _table_rte_flow_item_invert_example:
-
 .. table:: Anything but TCPv4
 
    +-------+----------+
@@ -546,8 +524,6 @@ underlying PMD and related to the device the flow rule is created against.
 
 - Default ``mask`` matches the specified DPDK port ID.
 
-.. _table_rte_flow_item_port_id:
-
 .. table:: PORT_ID
 
    +----------+----------+-----------------------------+
@@ -576,8 +552,6 @@ the physical device, with virtual groups in the PMD or not at all.
 
 - Default ``mask`` matches any integer value.
 
-.. _table_rte_flow_item_mark:
-
 .. table:: MARK
 
    +----------+----------+---------------------------+
@@ -598,8 +572,6 @@ Matches tag item set by other flows. Multiple tags are supported by specifying
 
 - Default ``mask`` matches the specified tag value and index.
 
-.. _table_rte_flow_item_tag:
-
 .. table:: TAG
 
    +----------+----------+----------------------------------------+
@@ -630,8 +602,6 @@ action sets metadata for a packet and the metadata will be reported via
 
 - Default ``mask`` matches the specified Rx metadata value.
 
-.. _table_rte_flow_item_meta:
-
 .. table:: META
 
    +----------+----------+---------------------------------------+
@@ -662,8 +632,6 @@ protocol anywhere in a packet.
 
 - Default ``mask`` stands for any number of layers.
 
-.. _table_rte_flow_item_any:
-
 .. table:: ANY
 
    +----------+----------+--------------------------------------+
@@ -680,8 +648,6 @@ Example for VXLAN TCP payload matching regardless of outer L3 (IPv4 or IPv6)
 and L4 (UDP) both matched by the first ANY specification, and inner L3 (IPv4
 or IPv6) matched by the second ANY specification:
 
-.. _table_rte_flow_item_any_example:
-
 .. table:: TCP in VXLAN with wildcards
 
    +-------+------+----------+----------+-------+
@@ -721,8 +687,6 @@ offset for subsequent items.
 - This type does not support ranges (``last`` field).
 - Default ``mask`` matches all fields exactly.
 
-.. _table_rte_flow_item_raw:
-
 .. table:: RAW
 
    +----------+--------------+-------------------------------------------------+
@@ -750,8 +714,6 @@ offset for subsequent items.
 Example pattern looking for several strings at various offsets of a UDP
 payload, using combined RAW items:
 
-.. _table_rte_flow_item_raw_example:
-
 .. table:: UDP payload matching
 
    +-------+------+----------+--------------+-------+
@@ -1026,8 +988,6 @@ range of threshold and map to different accuracy levels that device support.
 Threshold 0 means perfect match (no fuzziness), while threshold 0xffffffff
 means fuzziest match.
 
-.. _table_rte_flow_item_fuzzy:
-
 .. table:: FUZZY
 
    +----------+---------------+--------------------------------------------------+
@@ -1042,8 +1002,6 @@ means fuzziest match.
 
 Usage example, fuzzy match a TCPv4 packets:
 
-.. _table_rte_flow_item_fuzzy_example:
-
 .. table:: Fuzzy matching
 
    +-------+----------+
@@ -1421,8 +1379,6 @@ at the opposite end of the "wire" leading to the ethdev.
 - Incompatible with `Attribute: Traffic direction`_.
 - Requires `Attribute: Transfer`_.
 
-.. _table_rte_flow_item_ethdev:
-
 .. table:: ``struct rte_flow_item_ethdev``
 
    +----------+-------------+---------------------------+
@@ -1623,8 +1579,6 @@ Like matching patterns, action lists are terminated by END items.
 
 Example of action that redirects packets to queue index 10:
 
-.. _table_rte_flow_action_example:
-
 .. table:: Queue action
 
    +-----------+-------+
@@ -1635,8 +1589,6 @@ Example of action that redirects packets to queue index 10:
 
 Actions are performed in list order:
 
-.. _table_rte_flow_count_then_drop:
-
 .. table:: Count then drop
 
    +-------+--------+
@@ -1651,8 +1603,6 @@ Actions are performed in list order:
 
 |
 
-.. _table_rte_flow_mark_count_redirect:
-
 .. table:: Mark, count then redirect
 
    +-------+--------+------------+-------+
@@ -1669,8 +1619,6 @@ Actions are performed in list order:
 
 |
 
-.. _table_rte_flow_redirect_queue_5:
-
 .. table:: Redirect to queue 5
 
    +-------+--------+-----------+-------+
@@ -1689,8 +1637,6 @@ have to happen before reaching END. Only QUEUE has a visible effect.
 Note that such a list may be thought as ambiguous and rejected on that
 basis.
 
-.. _table_rte_flow_redirect_queue_5_3:
-
 .. table:: Redirect to queues 5 and 3
 
    +-------+--------+-----------+-------+
@@ -1724,8 +1670,6 @@ ending the list.
 - PMD support is mandatory.
 - No configurable properties.
 
-.. _table_rte_flow_action_end:
-
 .. table:: END
 
    +---------------+
@@ -1743,8 +1687,6 @@ PMDs.
 - PMD support is mandatory.
 - No configurable properties.
 
-.. _table_rte_flow_action_void:
-
 .. table:: VOID
 
    +---------------+
@@ -1761,8 +1703,6 @@ a flow rule non-terminating.
 
 - No configurable properties.
 
-.. _table_rte_flow_action_passthru:
-
 .. table:: PASSTHRU
 
    +---------------+
@@ -1774,8 +1714,6 @@ a flow rule non-terminating.
 Example to copy a packet to a queue and continue processing by subsequent
 flow rules:
 
-.. _table_rte_flow_action_passthru_example:
-
 .. table:: Copy to queue 8
 
    +-------+--------+-----------+-------+
@@ -1810,8 +1748,6 @@ definitions of jump actions, applications should be aware that it may be
 possible to define flow rules which trigger an undefined behavior causing
 flows to loop between groups.
 
-.. _table_rte_flow_action_jump:
-
 .. table:: JUMP
 
    +-----------+------------------------------+
@@ -1833,8 +1769,6 @@ If a matched flow is redirected to a non-existing template table
 or the table which doesn't contain a rule at the specified index,
 then the behavior is undefined and the resulting behavior is up to driver.
 
-.. _table_rte_flow_action_jump_to_table_index:
-
 .. table:: JUMP_TO_TABLE_INDEX
 
    +-----------+-------------------------------------------+
@@ -1855,8 +1789,6 @@ This value is arbitrary and application-defined. Maximum allowed value
 depends on the underlying implementation. It is returned in the
 ``hash.fdir.hi`` mbuf field.
 
-.. _table_rte_flow_action_mark:
-
 .. table:: MARK
 
    +--------+--------------------------------------+
@@ -1873,8 +1805,6 @@ sets the ``RTE_MBUF_F_RX_FDIR`` mbuf flag.
 
 - No configurable properties.
 
-.. _table_rte_flow_action_flag:
-
 .. table:: FLAG
 
    +---------------+
@@ -1888,8 +1818,6 @@ Action: ``QUEUE``
 
 Assigns packets to a given queue index.
 
-.. _table_rte_flow_action_queue:
-
 .. table:: QUEUE
 
    +-----------+--------------------+
@@ -1905,8 +1833,6 @@ Drop packets.
 
 - No configurable properties.
 
-.. _table_rte_flow_action_drop:
-
 .. table:: DROP
 
    +---------------+
@@ -1926,8 +1852,6 @@ Skip congestion management on received packets.
   Once applied, packets congestion configuration is bypassed
   on that particular ethdev Rx queue for all packets directed to that queue.
 
-.. _table_rte_flow_action_skip_cman:
-
 .. table:: SKIP_CMAN
 
    +---------------+
@@ -1951,8 +1875,6 @@ Counters can be retrieved and reset through ``rte_flow_query()``, see
 For ports within the same switch domain then the counter id namespace extends
 to all ports within that switch domain.
 
-.. _table_rte_flow_action_count:
-
 .. table:: COUNT
 
    +------------+---------------------------------+
@@ -1963,8 +1885,6 @@ to all ports within that switch domain.
 
 Query structure to retrieve and reset flow rule counters:
 
-.. _table_rte_flow_query_count:
-
 .. table:: COUNT query
 
    +---------------+-----+-----------------------------------+
@@ -2032,8 +1952,6 @@ behavior. For predictable results, it is recommended to make the flow rule
 pattern match packet headers up to the requested encapsulation level so that
 only matching traffic goes through.
 
-.. _table_rte_flow_action_rss:
-
 .. table:: RSS
 
    +---------------+-------------------------------------------------+
@@ -2066,8 +1984,6 @@ Directs matching traffic to the physical function (PF) of the current device.
 
 - No configurable properties.
 
-.. _table_rte_flow_action_pf:
-
 .. table:: PF
 
    +---------------+
@@ -2091,8 +2007,6 @@ instead of the specified one. This parameter may not be available and is
 not guaranteed to work properly if the VF part is matched by a prior flow
 rule or if packets are not addressed to a VF in the first place.
 
-.. _table_rte_flow_action_vf:
-
 .. table:: VF
 
    +--------------+--------------------------------+
@@ -2114,8 +2028,6 @@ Directs matching traffic to a given DPDK port ID.
 
 See `Item: PORT_ID`_.
 
-.. _table_rte_flow_action_port_id:
-
 .. table:: PORT_ID
 
    +--------------+---------------------------------------+
@@ -2137,8 +2049,6 @@ action parameter. More than one flow can use the same MTR object through
 the meter action. The MTR object can be further updated or queried using
 the rte_mtr* API.
 
-.. _table_rte_flow_action_meter:
-
 .. table:: METER
 
    +--------------+---------------+
@@ -2172,8 +2082,6 @@ direction.
 
 Multiple flows can be configured to use the same security session.
 
-.. _table_rte_flow_action_security:
-
 .. table:: SECURITY
 
    +----------------------+--------------------------------------+
@@ -2189,8 +2097,6 @@ The encryption algorithm, keys and salt are part of the opaque
 ``rte_security_session``. The SA is identified according to the IP and ESP
 fields in the pattern items.
 
-.. _table_rte_flow_item_esp_inline_example:
-
 .. table:: IPsec inline crypto flow pattern items.
 
    +-------+----------+
@@ -2205,8 +2111,6 @@ fields in the pattern items.
    | 3     | END      |
    +-------+----------+
 
-.. _table_rte_flow_action_esp_inline_example:
-
 .. table:: IPsec inline flow actions.
 
    +-------+----------+
@@ -2224,8 +2128,6 @@ This is a legacy action. Consider `Action: MODIFY_FIELD`_ as alternative.
 Implements ``OFPAT_DEC_NW_TTL`` ("decrement IP TTL") as defined by the
 `OpenFlow Switch Specification`_.
 
-.. _table_rte_flow_action_of_dec_nw_ttl:
-
 .. table:: OF_DEC_NW_TTL
 
    +---------------+
@@ -2240,8 +2142,6 @@ Action: ``OF_POP_VLAN``
 Implements ``OFPAT_POP_VLAN`` ("pop the outer VLAN tag") as defined
 by the `OpenFlow Switch Specification`_.
 
-.. _table_rte_flow_action_of_pop_vlan:
-
 .. table:: OF_POP_VLAN
 
    +---------------+
@@ -2256,8 +2156,6 @@ Action: ``OF_PUSH_VLAN``
 Implements ``OFPAT_PUSH_VLAN`` ("push a new VLAN tag") as defined by the
 `OpenFlow Switch Specification`_.
 
-.. _table_rte_flow_action_of_push_vlan:
-
 .. table:: OF_PUSH_VLAN
 
    +---------------+-----------+
@@ -2272,8 +2170,6 @@ Action: ``OF_SET_VLAN_VID``
 Implements ``OFPAT_SET_VLAN_VID`` ("set the 802.1q VLAN id") as defined by
 the `OpenFlow Switch Specification`_.
 
-.. _table_rte_flow_action_of_set_vlan_vid:
-
 .. table:: OF_SET_VLAN_VID
 
    +--------------+---------+
@@ -2288,8 +2184,6 @@ Action: ``OF_SET_VLAN_PCP``
 Implements ``OFPAT_SET_LAN_PCP`` ("set the 802.1q priority") as defined by
 the `OpenFlow Switch Specification`_.
 
-.. _table_rte_flow_action_of_set_vlan_pcp:
-
 .. table:: OF_SET_VLAN_PCP
 
    +--------------+---------------+
@@ -2304,8 +2198,6 @@ Action: ``OF_POP_MPLS``
 Implements ``OFPAT_POP_MPLS`` ("pop the outer MPLS tag") as defined by the
 `OpenFlow Switch Specification`_.
 
-.. _table_rte_flow_action_of_pop_mpls:
-
 .. table:: OF_POP_MPLS
 
    +---------------+-----------+
@@ -2320,8 +2212,6 @@ Action: ``OF_PUSH_MPLS``
 Implements ``OFPAT_PUSH_MPLS`` ("push a new MPLS tag") as defined by the
 `OpenFlow Switch Specification`_.
 
-.. _table_rte_flow_action_of_push_mpls:
-
 .. table:: OF_PUSH_MPLS
 
    +---------------+-----------+
@@ -2344,8 +2234,6 @@ Area Network (VXLAN): A Framework for Overlaying Virtualized Layer 2 Networks
 over Layer 3 Networks). The pattern must be terminated with the
 RTE_FLOW_ITEM_TYPE_END item type.
 
-.. _table_rte_flow_action_vxlan_encap:
-
 .. table:: VXLAN_ENCAP
 
    +----------------+-------------------------------------+
@@ -2354,8 +2242,6 @@ RTE_FLOW_ITEM_TYPE_END item type.
    | ``definition`` | Tunnel end-point overlay definition |
    +----------------+-------------------------------------+
 
-.. _table_rte_flow_action_vxlan_encap_example:
-
 .. table:: IPv4 VxLAN flow pattern example.
 
    +-------+----------+
@@ -2398,8 +2284,6 @@ NVGRE network overlay which conforms with RFC 7637 (NVGRE: Network
 Virtualization Using Generic Routing Encapsulation). The pattern must be
 terminated with the RTE_FLOW_ITEM_TYPE_END item type.
 
-.. _table_rte_flow_action_nvgre_encap:
-
 .. table:: NVGRE_ENCAP
 
    +----------------+-------------------------------------+
@@ -2408,8 +2292,6 @@ terminated with the RTE_FLOW_ITEM_TYPE_END item type.
    | ``definition`` | NVGRE end-point overlay definition  |
    +----------------+-------------------------------------+
 
-.. _table_rte_flow_action_nvgre_encap_example:
-
 .. table:: IPv4 NVGRE flow pattern example.
 
    +-------+----------+
@@ -2449,8 +2331,6 @@ decap layer 3 tunnel (for example MPLSoGRE) or complete tunnel definition
 starting from layer 2 and moving to the tunnel item itself. When applied to
 the original packet the resulting packet must be a valid packet.
 
-.. _table_rte_flow_action_raw_encap:
-
 .. table:: RAW_ENCAP
 
    +----------------+----------------------------------------+
@@ -2476,8 +2356,6 @@ tunnel definition starting from layer 2 and moving to the tunnel item itself.
 When applied to the original packet the resulting packet must be a
 valid packet.
 
-.. _table_rte_flow_action_raw_decap:
-
 .. table:: RAW_DECAP
 
    +----------------+----------------------------------------+
@@ -2497,8 +2375,6 @@ Set a new IPv4 source address in the outermost IPv4 header.
 It must be used with a valid RTE_FLOW_ITEM_TYPE_IPV4 flow pattern item.
 Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
 
-.. _table_rte_flow_action_set_ipv4_src:
-
 .. table:: SET_IPV4_SRC
 
    +-----------------------------------------+
@@ -2516,8 +2392,6 @@ Set a new IPv4 destination address in the outermost IPv4 header.
 It must be used with a valid RTE_FLOW_ITEM_TYPE_IPV4 flow pattern item.
 Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
 
-.. _table_rte_flow_action_set_ipv4_dst:
-
 .. table:: SET_IPV4_DST
 
    +---------------+------------------------------+
@@ -2535,8 +2409,6 @@ Set a new IPv6 source address in the outermost IPv6 header.
 It must be used with a valid RTE_FLOW_ITEM_TYPE_IPV6 flow pattern item.
 Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
 
-.. _table_rte_flow_action_set_ipv6_src:
-
 .. table:: SET_IPV6_SRC
 
    +---------------+-------------------------+
@@ -2554,8 +2426,6 @@ Set a new IPv6 destination address in the outermost IPv6 header.
 It must be used with a valid RTE_FLOW_ITEM_TYPE_IPV6 flow pattern item.
 Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
 
-.. _table_rte_flow_action_set_ipv6_dst:
-
 .. table:: SET_IPV6_DST
 
    +---------------+------------------------------+
@@ -2595,8 +2465,6 @@ Set a new source port number in the outermost TCP/UDP header.
 It must be used with a valid RTE_FLOW_ITEM_TYPE_TCP or RTE_FLOW_ITEM_TYPE_UDP
 flow pattern item. Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
 
-.. _table_rte_flow_action_set_tp_src:
-
 .. table:: SET_TP_SRC
 
    +----------+-------------------------+
@@ -2614,8 +2482,6 @@ Set a new destination port number in the outermost TCP/UDP header.
 It must be used with a valid RTE_FLOW_ITEM_TYPE_TCP or RTE_FLOW_ITEM_TYPE_UDP
 flow pattern item. Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
 
-.. _table_rte_flow_action_set_tp_dst:
-
 .. table:: SET_TP_DST
 
    +----------+------------------------------+
@@ -2633,8 +2499,6 @@ header.
 It must be used with a valid RTE_FLOW_ITEM_TYPE_ETH flow pattern item.
 Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
 
-.. _table_rte_flow_action_mac_swap:
-
 .. table:: MAC_SWAP
 
    +---------------+
@@ -2652,8 +2516,6 @@ Decrease TTL value.
 If there is no valid RTE_FLOW_ITEM_TYPE_IPV4 or RTE_FLOW_ITEM_TYPE_IPV6
 in pattern, Some PMDs will reject rule because behavior will be undefined.
 
-.. _table_rte_flow_action_dec_ttl:
-
 .. table:: DEC_TTL
 
    +---------------+
@@ -2671,8 +2533,6 @@ Assigns a new TTL value.
 If there is no valid RTE_FLOW_ITEM_TYPE_IPV4 or RTE_FLOW_ITEM_TYPE_IPV6
 in pattern, Some PMDs will reject rule because behavior will be undefined.
 
-.. _table_rte_flow_action_set_ttl:
-
 .. table:: SET_TTL
 
    +---------------+--------------------+
@@ -2690,8 +2550,6 @@ Set source MAC address.
 It must be used with a valid RTE_FLOW_ITEM_TYPE_ETH flow pattern item.
 Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
 
-.. _table_rte_flow_action_set_mac_src:
-
 .. table:: SET_MAC_SRC
 
    +--------------+---------------+
@@ -2709,8 +2567,6 @@ Set destination MAC address.
 It must be used with a valid RTE_FLOW_ITEM_TYPE_ETH flow pattern item.
 Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
 
-.. _table_rte_flow_action_set_mac_dst:
-
 .. table:: SET_MAC_DST
 
    +--------------+---------------+
@@ -2764,8 +2620,6 @@ Set Tag.
 Tag is a transient data used during flow matching. This is not delivered to
 application. Multiple tags are supported by specifying index.
 
-.. _table_rte_flow_action_set_tag:
-
 .. table:: SET_TAG
 
    +-----------+----------------------------+
@@ -2801,8 +2655,6 @@ the other path depending on HW capability.
 In hairpin case with Tx explicit flow mode, metadata could (not mandatory) be
 used to connect the Rx and Tx flows if it can be propagated from Rx to Tx path.
 
-.. _table_rte_flow_action_set_meta:
-
 .. table:: SET_META
 
    +----------+----------------------------+
@@ -2824,8 +2676,6 @@ Modify DSCP in IPv4 header.
 It must be used with RTE_FLOW_ITEM_TYPE_IPV4 in pattern.
 Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
 
-.. _table_rte_flow_action_set_ipv4_dscp:
-
 .. table:: SET_IPV4_DSCP
 
    +-----------+---------------------------------+
@@ -2845,8 +2695,6 @@ Modify DSCP in IPv6 header.
 It must be used with RTE_FLOW_ITEM_TYPE_IPV6 in pattern.
 Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
 
-.. _table_rte_flow_action_set_ipv6_dscp:
-
 .. table:: SET_IPV6_DSCP
 
    +-----------+---------------------------------+
@@ -2872,8 +2720,6 @@ Set ageing timeout configuration to a flow.
 Event RTE_ETH_EVENT_FLOW_AGED will be reported if
 timeout passed without any matching on the flow.
 
-.. _table_rte_flow_action_age:
-
 .. table:: AGE
 
    +--------------+---------------------------------+
@@ -2889,8 +2735,6 @@ timeout passed without any matching on the flow.
 Query structure to retrieve ageing status information of a
 shared AGE action, or a flow rule using the AGE action:
 
-.. _table_rte_flow_query_age:
-
 .. table:: AGE query
 
    +------------------------------+-----+----------------------------------------+
@@ -2906,8 +2750,6 @@ shared AGE action, or a flow rule using the AGE action:
 Update structure to modify the parameters of an indirect AGE action.
 The update structure is used by ``rte_flow_action_handle_update()`` function.
 
-.. _table_rte_flow_update_age:
-
 .. table:: AGE update
 
    +-------------------+--------------------------------------------------------------+
@@ -2935,8 +2777,6 @@ When the ``ratio`` is set to 1 then the packets will be 100% mirrored.
 ``actions`` represent the different set of actions for the sampled or mirrored
 packets, and must have a fate action.
 
-.. _table_rte_flow_action_sample:
-
 .. table:: SAMPLE
 
    +--------------+---------------------------------+
@@ -2995,8 +2835,6 @@ when the device is stopped.
 Indirect actions of a kept kind that are created when the device is stopped,
 including the ones created for the test, will be kept after the device start.
 
-.. _table_rte_flow_action_handle:
-
 .. table:: INDIRECT
 
    +---------------+
@@ -3084,8 +2922,6 @@ Otherwise it points to an array of n flow mutable configuration pointers.
 - Cflow[i] updates handle's Ai flow mutable configuration if
   the Ci was not masked in action template.
 
-.. _table_rte_flow_action_indirect_list:
-
 .. table:: INDIRECT_LIST
 
    +------------------+----------------------------------+
@@ -3212,8 +3048,6 @@ For example, to replace the third byte of second DW in Geneve option data
 with value ``0x85``, the application should specify destination width as ``8``,
 destination offset as ``48``, and provide immediate value ``0xXXXX85XX``.
 
-.. _table_rte_flow_action_modify_field:
-
 .. table:: MODIFY_FIELD
 
    +---------------+-------------------------+
@@ -3228,8 +3062,6 @@ destination offset as ``48``, and provide immediate value ``0xXXXX85XX``.
    | ``width``     | number of bits to use   |
    +---------------+-------------------------+
 
-.. _table_rte_flow_field_data:
-
 .. table:: destination/source field definition
 
    +-----------------+----------------------------------------------------------+
@@ -3290,8 +3122,6 @@ The ``struct rte_flow_modify_conntrack`` should be used for an updating.
 The current conntrack context information could be queried via the
 ``rte_flow_action_handle_query()`` interface.
 
-.. _table_rte_flow_action_conntrack:
-
 .. table:: CONNTRACK
 
    +--------------------------+-------------------------------------------------------------+
@@ -3332,8 +3162,6 @@ The current conntrack context information could be queried via the
    | ``last_end``             | sum of ack number and length of the last passed packet      |
    +--------------------------+-------------------------------------------------------------+
 
-.. _table_rte_flow_tcp_dir_param:
-
 .. table:: configuration parameters for each direction
 
    +---------------------+---------------------------------------------------------+
@@ -3356,8 +3184,6 @@ The current conntrack context information could be queried via the
    | ``max_ack``         | max{ack} + seen in sent packets                         |
    +---------------------+---------------------------------------------------------+
 
-.. _table_rte_flow_modify_conntrack:
-
 .. table:: update a conntrack context
 
    +----------------+-------------------------------------------------+
@@ -3383,8 +3209,6 @@ Set the meter color in the mbuf to the selected color.
 The meter color action output color is the output color of the packet,
 which is set in the packet meta-data (i.e. struct ``rte_mbuf::sched::color``)
 
-.. _table_rte_flow_action_meter_color:
-
 .. table:: METER_COLOR
 
    +-----------------+--------------+
@@ -3435,8 +3259,6 @@ at the opposite end of the "wire" leading to the ethdev.
 
 - Requires `Attribute: Transfer`_.
 
-.. _table_rte_flow_action_ethdev:
-
 .. table:: ``struct rte_flow_action_ethdev``
 
    +-------------+----------------+
@@ -3507,8 +3329,6 @@ Pointers to these objects are used as action parameters
 and need to be retrieved using the rte_mtr_profile_get() API
 and rte_mtr_policy_get() API respectively.
 
-.. _table_rte_flow_action_meter_mark:
-
 .. table:: METER_MARK
 
    +------------------+----------------------+
@@ -3530,8 +3350,6 @@ Otherwise, the packet quota state is set to ``RTE_FLOW_QUOTA_STATE_BLOCK``.
 
 The ``quota`` value is reduced according to ``mode`` setting.
 
-.. _table_rte_flow_action_quota:
-
 .. table:: QUOTA
 
    +------------------+------------------------+
@@ -3542,8 +3360,6 @@ The ``quota`` value is reduced according to ``mode`` setting.
    | ``quota``        | Quota value            |
    +------------------+------------------------+
 
-.. _rte_flow_quota_mode:
-
 .. table:: Quota update modes
 
    +---------------------------------+-------------------------------------+
@@ -4728,8 +4544,6 @@ specific types.
 
 Consider the following pattern:
 
-.. _table_rte_flow_unsupported_any:
-
 .. table:: Pattern with ANY as L3
 
    +-------+-----------------------+
@@ -4747,8 +4561,6 @@ Consider the following pattern:
 Knowing that TCP does not make sense with something other than IPv4 and IPv6
 as L3, such a pattern may be translated to two flow rules instead:
 
-.. _table_rte_flow_unsupported_any_ipv4:
-
 .. table:: ANY replaced with IPV4
 
    +-------+--------------------+
@@ -4765,8 +4577,6 @@ as L3, such a pattern may be translated to two flow rules instead:
 
 |
 
-.. _table_rte_flow_unsupported_any_ipv6:
-
 .. table:: ANY replaced with IPV6
 
    +-------+--------------------+
diff --git a/doc/guides/prog_guide/ethdev/qos_framework.rst b/doc/guides/prog_guide/ethdev/qos_framework.rst
index 03191d6602..f7089190fd 100644
--- a/doc/guides/prog_guide/ethdev/qos_framework.rst
+++ b/doc/guides/prog_guide/ethdev/qos_framework.rst
@@ -11,8 +11,6 @@ Packet Pipeline with QoS Support
 
 An example of a complex packet processing pipeline with QoS support is shown in the following figure.
 
-.. _figure_pkt_proc_pipeline_qos:
-
 .. figure:: ../img/pkt_proc_pipeline_qos.*
 
    Complex Packet Processing Pipeline with QoS Support
@@ -22,8 +20,6 @@ This pipeline can be built using reusable DPDK software libraries.
 The main blocks implementing QoS in this pipeline are: the policer, the dropper and the scheduler.
 A functional description of each block is provided in the following table.
 
-.. _table_qos_1:
-
 .. table:: Packet Processing Pipeline Implementing QoS
 
    +---+------------------------+--------------------------------------------------------------------------------+
@@ -73,8 +69,6 @@ A functional description of each block is provided in the following table.
 
 The infrastructure blocks used throughout the packet processing pipeline are listed in the following table.
 
-.. _table_qos_2:
-
 .. table:: Infrastructure Blocks Used by the Packet Processing Pipeline
 
    +---+-----------------------+-----------------------------------------------------------------------+
@@ -112,8 +106,6 @@ It typically acts like a buffer that is able to temporarily store a large number
 as the NIC TX is requesting more packets for transmission,
 these packets are later on removed and handed over to the NIC TX with the packet selection logic observing the predefined SLAs (dequeue operation).
 
-.. _figure_hier_sched_blk:
-
 .. figure:: ../img/hier_sched_blk.*
 
    Hierarchical Scheduler Block Internal Diagram
@@ -144,8 +136,6 @@ Each queue hosts packets from one or multiple connections of the same type belon
 
 The functionality of each hierarchical level is detailed in the following table.
 
-.. _table_qos_3:
-
 .. table:: Port Scheduling Hierarchy
 
    +---+--------------------+----------------------------+---------------------------------------------------------------+
@@ -269,15 +259,10 @@ Internal Data Structures per Port
 
 A schematic of the internal data structures in shown in with details in.
 
-.. _figure_data_struct_per_port:
-
 .. figure:: ../img/data_struct_per_port.*
 
     Internal Data Structures per Port
 
-
-.. _table_qos_4:
-
 .. table:: Scheduler Internal Data Structures per Port
 
    +---+----------------------+-------------------------+---------------------+------------------------------+---------------------------------------------------+
@@ -452,8 +437,6 @@ The dequeue pipe state machine exploits the data presence into the processor cac
 therefore it tries to send as many packets from the same pipe TC and pipe as possible (up to the available packets and credits) before
 moving to the next active TC from the same pipe (if any) or to another active pipe.
 
-.. _figure_pipe_prefetch_sm:
-
 .. figure:: ../img/pipe_prefetch_sm.*
 
    Pipe Prefetch State Machine for the Hierarchical Scheduler Dequeue
@@ -557,8 +540,6 @@ As the greatest common divisor for all packet lengths is one byte, the unit of c
 The number of credits required for the transmission of a packet of n bytes is equal to (n+h),
 where h is equal to the number of framing overhead bytes per packet.
 
-.. _table_qos_5:
-
 .. table:: Ethernet Frame Overhead Fields
 
    +---+--------------------------------+----------------+---------------------------------------------------------------------------+
@@ -948,8 +929,6 @@ Solution Space
 summarizes some of the possible approaches for handling this problem,
 with the third approach selected for implementation.
 
-.. _table_qos_13:
-
 .. table:: Subport Traffic Class Oversubscription
 
    +-----+---------------------------+-------------------------------------------------------------------------+
diff --git a/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst b/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
index bf449bcf52..9bbba69777 100644
--- a/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
@@ -45,8 +45,6 @@ In this mode, events dequeued from the adapter will be treated as new events.
 The application needs to specify event information (response information)
 which is needed to enqueue an event after the crypto operation is completed.
 
-.. _figure_event_crypto_adapter_op_new:
-
 .. figure:: ../img/event_crypto_adapter_op_new.*
 
    Working model of ``RTE_EVENT_CRYPTO_ADAPTER_OP_NEW`` mode
@@ -72,8 +70,6 @@ to enqueue a crypto operation in addition to the event information (response
 information) needed to enqueue an event after the crypto operation has
 completed.
 
-.. _figure_event_crypto_adapter_op_forward:
-
 .. figure:: ../img/event_crypto_adapter_op_forward.*
 
    Working model of ``RTE_EVENT_CRYPTO_ADAPTER_OP_FORWARD`` mode
diff --git a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
index 6339dddc2b..436be45a62 100644
--- a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
@@ -45,8 +45,6 @@ In this mode, events dequeued from the adapter are treated as new events.
 The application has to specify event information (response information)
 which is needed to enqueue an event after the DMA operation is completed.
 
-.. _figure_event_dma_adapter_op_new:
-
 .. figure:: ../img/event_dma_adapter_op_new.*
 
    Working model of ``RTE_EVENT_DMA_ADAPTER_OP_NEW`` mode
@@ -75,8 +73,6 @@ In this mode, events dequeued from the adapter will be treated as forwarded even
 Application has to specify event information (response information)
 needed to enqueue the event after the DMA operation has completed.
 
-.. _figure_event_dma_adapter_op_forward:
-
 .. figure:: ../img/event_dma_adapter_op_forward.*
 
    Working model of ``RTE_EVENT_DMA_ADAPTER_OP_FORWARD`` mode
diff --git a/doc/guides/prog_guide/eventdev/eventdev.rst b/doc/guides/prog_guide/eventdev/eventdev.rst
index 9ec566925c..ea34f74032 100644
--- a/doc/guides/prog_guide/eventdev/eventdev.rst
+++ b/doc/guides/prog_guide/eventdev/eventdev.rst
@@ -167,8 +167,6 @@ illustration, refer to Eventdev Adapter documentation for further details.
 The diagram below shows the final state of the application after this
 walk-through:
 
-.. _figure_eventdev-usage1:
-
 .. figure:: ../img/eventdev_usage.*
 
    Sample eventdev usage, with RX, two atomic stages and a single-link to TX.
diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/graph_lib.rst
index 8dd49c19d2..c72065c9f3 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -58,8 +58,6 @@ Programming model
 Anatomy of Node:
 ~~~~~~~~~~~~~~~~
 
-.. _figure_anatomy_of_a_node:
-
 .. figure:: img/anatomy_of_a_node.*
 
    Anatomy of a node
@@ -146,7 +144,6 @@ Node creation and registration
 
 Link the Nodes to create the graph topology
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-.. _figure_link_the_nodes:
 
 .. figure:: img/link_the_nodes.*
 
@@ -387,7 +384,6 @@ Example of intermediate node implementation with home run:
 
 Graph object memory layout
 --------------------------
-.. _figure_graph_mem_layout:
 
 .. figure:: img/graph_mem_layout.*
 
@@ -931,8 +927,6 @@ Inbuilt Nodes
 DPDK provides a set of nodes for data processing.
 The following diagram depicts inbuilt nodes data flow.
 
-.. _figure_graph_inbuit_node_flow:
-
 .. figure:: img/graph_inbuilt_node_flow.*
 
    Inbuilt nodes data flow
diff --git a/doc/guides/prog_guide/hash_lib.rst b/doc/guides/prog_guide/hash_lib.rst
index 0c2276c88b..43da83a560 100644
--- a/doc/guides/prog_guide/hash_lib.rst
+++ b/doc/guides/prog_guide/hash_lib.rst
@@ -207,8 +207,6 @@ are evicted to their secondary location.
 
 See the tables below showing example entry distribution as table utilization increases.
 
-.. _table_hash_lib_1:
-
 .. table:: Entry distribution measured with an example table with 1024 random entries using jhash algorithm
 
    +--------------+-----------------------+-------------------------+
@@ -231,8 +229,6 @@ See the tables below showing example entry distribution as table utilization inc
 
 |
 
-.. _table_hash_lib_2:
-
 .. table:: Entry distribution measured with an example table with 1 million random entries using jhash algorithm
 
    +--------------+-----------------------+-------------------------+
diff --git a/doc/guides/prog_guide/member_lib.rst b/doc/guides/prog_guide/member_lib.rst
index 61700a51ad..72b9902f3b 100644
--- a/doc/guides/prog_guide/member_lib.rst
+++ b/doc/guides/prog_guide/member_lib.rst
@@ -39,7 +39,6 @@ reduce space requirement and significantly improve the performance of set
 membership queries at the cost of introducing a very small membership test error
 probability.
 
-.. _figure_membership1:
 .. figure:: img/member_i1.*
 
   Example Usages of Membership Library
@@ -109,7 +108,6 @@ Y is a member of the set with certain false positive probability. As shown in
 the next equation, the false positive probability can be made arbitrarily small
 by changing the number of hash functions (``k``) and the vector length (``m``).
 
-.. _figure_membership2:
 .. figure:: img/member_i2.*
 
   Bloom Filter False Positive Probability
@@ -121,7 +119,6 @@ small bit-vector, which can be easily optimized. Hence the lookup throughput
 (set membership test) can be significantly faster than a normal hash table
 lookup with element comparison.
 
-.. _figure_membership3:
 .. figure:: img/member_i3.*
 
   Detecting Routing Loops Using BF
@@ -134,8 +131,6 @@ node will then check this embedded BF in the packet header for its own id, and
 if the BF indicates that the current node is definitely not in the set then a
 loop-free route is guaranteed.
 
-
-.. _figure_membership4:
 .. figure:: img/member_i4.*
 
   Vector Bloom Filter (vBF) Overview
@@ -149,7 +144,6 @@ them. The basic idea of vBF is shown in the above figure where an element is
 used to address multiple bloom filters concurrently and the bloom filter
 index(es) with a hit is returned.
 
-.. _figure_membership5:
 .. figure:: img/member_i5.*
 
   vBF for Flow Scheduling to Worker Thread
@@ -184,7 +178,6 @@ requires testing a series of Bloom Filters each corresponding to one set.
 As a result, generally speaking vBF is more adequate for the case of a small limited number of sets
 while HTSS should be used with a larger number of sets.
 
-.. _figure_membership6:
 .. figure:: img/member_i6.*
 
   Using HTSS for Attack Signature Matching
@@ -237,7 +230,6 @@ set-summary. It is worth noting that the set-summary still has false positive
 probability, which means the application either can tolerate certain false positive
 or it has fall-back path when false positive happens.
 
-.. _figure_membership7:
 .. figure:: img/member_i7.*
 
   Using HTSS with False Negatives for Wild Card Classification
diff --git a/doc/guides/prog_guide/mempool_lib.rst b/doc/guides/prog_guide/mempool_lib.rst
index 09c70af811..9bbe829411 100644
--- a/doc/guides/prog_guide/mempool_lib.rst
+++ b/doc/guides/prog_guide/mempool_lib.rst
@@ -78,9 +78,6 @@ When creating a new pool, the user can specify to use this feature or not.
    As a result, the load is distributed evenly in all cases,
    including the above described, rendering this feature unnecessary.
 
-
-.. _mempool_local_cache:
-
 Local Cache
 -----------
 
diff --git a/doc/guides/prog_guide/mldev.rst b/doc/guides/prog_guide/mldev.rst
index 61661b998b..4d305b6bf2 100644
--- a/doc/guides/prog_guide/mldev.rst
+++ b/doc/guides/prog_guide/mldev.rst
@@ -12,8 +12,6 @@ The ML model creation and training is outside of the scope of this library.
 
 The ML framework is built on the following model:
 
-.. _figure_mldev_work_flow:
-
 .. figure:: img/mldev_flow.*
 
    Work flow of inference on MLDEV
diff --git a/doc/guides/prog_guide/multi_proc_support.rst b/doc/guides/prog_guide/multi_proc_support.rst
index edc5524e87..b465c47727 100644
--- a/doc/guides/prog_guide/multi_proc_support.rst
+++ b/doc/guides/prog_guide/multi_proc_support.rst
@@ -70,8 +70,6 @@ and point to the same objects, in both processes.
     ``--single-file-segments`` switch, secondary processes must be run with the
     same switch specified. Otherwise, memory corruption may occur.
 
-.. _figure_multi_process_memory:
-
 .. figure:: img/multi_process_memory.*
 
    Memory Sharing in the DPDK Multi-process Sample Application
diff --git a/doc/guides/prog_guide/overview.rst b/doc/guides/prog_guide/overview.rst
index c70023e8a1..8341d3c7bc 100644
--- a/doc/guides/prog_guide/overview.rst
+++ b/doc/guides/prog_guide/overview.rst
@@ -86,8 +86,6 @@ Core Components
 The *core components* are a set of libraries that provide all the elements needed
 for high-performance packet processing applications.
 
-.. _figure_architecture-overview:
-
 .. figure:: img/architecture-overview.*
 
    Core Components Architecture
diff --git a/doc/guides/prog_guide/packet_framework.rst b/doc/guides/prog_guide/packet_framework.rst
index 17010b07dc..a6b80899c3 100644
--- a/doc/guides/prog_guide/packet_framework.rst
+++ b/doc/guides/prog_guide/packet_framework.rst
@@ -108,8 +108,6 @@ Each input/output port is required to implement an abstract interface that
 defines the initialization and run-time operation of the port.
 The port abstract interface is described in.
 
-.. _table_qos_20:
-
 .. table:: 20 Port Abstract Interface
 
    +---+----------------+-----------------------------------------------------------------------------------------+
@@ -426,8 +424,6 @@ The possible options are:
     the search continues beyond the first group of 4 keys, potentially until all keys in this bucket are examined.
     The extendable bucket logic requires maintaining specific data structures per table and per each bucket.
 
-.. _table_qos_23:
-
 .. table:: Configuration Parameters Specific to Extendable Bucket Hash Table
 
    +---+---------------------------+--------------------------------------------------+
@@ -455,8 +451,6 @@ The possible options for key signature computation are:
     The same CPU core reads the key from the packet meta-data, uses it to compute the key signature
     and also performs the bucket search step of the key lookup operation.
 
-.. _table_qos_24:
-
 .. table:: Configuration Parameters Specific to Pre-computed Key Signature Hash Table
 
    +---+------------------+-----------------------------------------------------------------------+
@@ -885,16 +879,11 @@ and detail the bucket search pipeline used to implement 8-byte and 16-byte key h
 either with pre-computed signature or "do-sig").
 For each pipeline stage, the described operations are applied to each of the two packets handled by that stage.
 
-.. _figure_figure39:
-
 .. figure:: img/figure39.*
 
    Bucket Search Pipeline for Key Lookup Operation (Single Key Size Hash
    Tables)
 
-
-.. _table_qos_32:
-
 .. table:: Description of the Bucket Search Pipeline Stages (8-byte and 16-byte Key Hash Tables)
 
    +---+---------------------------+-----------------------------------------------------------------------------+
diff --git a/doc/guides/prog_guide/pdcp_lib.rst b/doc/guides/prog_guide/pdcp_lib.rst
index 266abb8574..328ce526b6 100644
--- a/doc/guides/prog_guide/pdcp_lib.rst
+++ b/doc/guides/prog_guide/pdcp_lib.rst
@@ -21,8 +21,6 @@ PDCP would involve the following operations:
 #. Uplink data compression
 #. Ciphering and integrity protection
 
-.. _figure_pdcp_functional_overview:
-
 .. figure:: img/pdcp_functional_overview.*
 
    PDCP functional overview
diff --git a/doc/guides/prog_guide/pdump_lib.rst b/doc/guides/prog_guide/pdump_lib.rst
index 5bacb49ffc..be9dc80553 100644
--- a/doc/guides/prog_guide/pdump_lib.rst
+++ b/doc/guides/prog_guide/pdump_lib.rst
@@ -18,8 +18,6 @@ to facilitate communication between the primary and secondary processes.
 This mechanism allows enabling or disabling packet capture
 on specific ports or queues.
 
-.. _figure_pdump_overview:
-
 .. figure:: img/pdump_overview.*
 
    Packet Capture enable and disable sequence
diff --git a/doc/guides/prog_guide/ring_lib.rst b/doc/guides/prog_guide/ring_lib.rst
index e13588553d..545f2cd5ce 100644
--- a/doc/guides/prog_guide/ring_lib.rst
+++ b/doc/guides/prog_guide/ring_lib.rst
@@ -45,8 +45,6 @@ The disadvantages:
 
 A simplified representation of a Ring is shown in with consumer and producer head and tail pointers to objects stored in the data structure.
 
-.. _figure_ring1:
-
 .. figure:: img/ring1.*
 
    Ring Structure
@@ -112,9 +110,6 @@ The prod_next local variable points to the next element of the table, or several
 
 If there is not enough room in the ring (this is detected by checking cons_tail), it returns an error.
 
-
-.. _figure_ring-enqueue1:
-
 .. figure:: img/ring-enqueue1.*
 
    Enqueue first step
@@ -127,9 +122,6 @@ The second step is to modify *ring->prod_head* in ring structure to point to the
 
 The added object is copied in the ring (obj4).
 
-
-.. _figure_ring-enqueue2:
-
 .. figure:: img/ring-enqueue2.*
 
    Enqueue second step
@@ -141,9 +133,6 @@ Enqueue Last Step
 Once the object is added in the ring, ring->prod_tail in the ring structure is modified to point to the same location as *ring->prod_head*.
 The enqueue operation is finished.
 
-
-.. _figure_ring-enqueue3:
-
 .. figure:: img/ring-enqueue3.*
 
    Enqueue last step
@@ -165,9 +154,6 @@ The cons_next local variable points to the next element of the table, or several
 
 If there are not enough objects in the ring (this is detected by checking prod_tail), it returns an error.
 
-
-.. _figure_ring-dequeue1:
-
 .. figure:: img/ring-dequeue1.*
 
    Dequeue first step
@@ -180,9 +166,6 @@ The second step is to modify ring->cons_head in the ring structure to point to t
 
 The dequeued object (obj1) is copied in the pointer given by the user.
 
-
-.. _figure_ring-dequeue2:
-
 .. figure:: img/ring-dequeue2.*
 
    Dequeue second step
@@ -194,9 +177,6 @@ Dequeue Last Step
 Finally, ring->cons_tail in the ring structure is modified to point to the same location as ring->cons_head.
 The dequeue operation is finished.
 
-
-.. _figure_ring-dequeue3:
-
 .. figure:: img/ring-dequeue3.*
 
    Dequeue last step
@@ -219,9 +199,6 @@ or several elements after in the case of bulk enqueue.
 
 If there is not enough room in the ring (this is detected by checking cons_tail), it returns an error.
 
-
-.. _figure_ring-mp-enqueue1:
-
 .. figure:: img/ring-mp-enqueue1.*
 
    Multiple producer enqueue first step
@@ -241,9 +218,6 @@ This operation is done using a Compare And Swap (CAS) instruction, which does th
 
 In the figure, the operation succeeded on core 1, and step one restarted on core 2.
 
-
-.. _figure_ring-mp-enqueue2:
-
 .. figure:: img/ring-mp-enqueue2.*
 
    Multiple producer enqueue second step
@@ -256,9 +230,6 @@ The CAS operation is retried on core 2 with success.
 
 The core 1 updates one element of the ring(obj4), and the core 2 updates another one (obj5).
 
-
-.. _figure_ring-mp-enqueue3:
-
 .. figure:: img/ring-mp-enqueue3.*
 
    Multiple producer enqueue third step
@@ -271,9 +242,6 @@ Each core now wants to update ring->prod_tail.
 A core can only update it if ring->prod_tail is equal to the prod_head local variable.
 This is only true on core 1. The operation is finished on core 1.
 
-
-.. _figure_ring-mp-enqueue4:
-
 .. figure:: img/ring-mp-enqueue4.*
 
    Multiple producer enqueue fourth step
@@ -285,9 +253,6 @@ Multiple Producers Enqueue Last Step
 Once ring->prod_tail is updated by core 1, core 2 is allowed to update it too.
 The operation is also finished on core 2.
 
-
-.. _figure_ring-mp-enqueue5:
-
 .. figure:: img/ring-mp-enqueue5.*
 
    Multiple producer enqueue last step
@@ -310,9 +275,6 @@ The following are two examples that help to explain how indexes are used in a ri
     In addition, the four indexes are defined as unsigned 16-bit integers,
     as opposed to unsigned 32-bit integers in the more realistic case.
 
-
-.. _figure_ring-modulo1:
-
 .. figure:: img/ring-modulo1.*
 
    Modulo 32-bit indexes - Example 1
@@ -320,9 +282,6 @@ The following are two examples that help to explain how indexes are used in a ri
 
 This ring contains 11000 entries.
 
-
-.. _figure_ring-modulo2:
-
 .. figure:: img/ring-modulo2.*
 
       Modulo 32-bit indexes - Example 2
@@ -536,8 +495,6 @@ On that picture ``obj5`` and ``obj4`` elements are acquired by stage 0,
 ``obj2`` and ``obj3`` are acquired by stage 1,
 while ``obj1`` was already released by stage 1 and is ready to be consumed.
 
-.. _figure_soring1:
-
 .. figure:: img/soring-pic1.*
 
 Along with traditional flavor there are enhanced versions for
diff --git a/doc/guides/prog_guide/trace_lib.rst b/doc/guides/prog_guide/trace_lib.rst
index d9b17abe90..6cf8e21641 100644
--- a/doc/guides/prog_guide/trace_lib.rst
+++ b/doc/guides/prog_guide/trace_lib.rst
@@ -287,8 +287,6 @@ on the first trace emission.
 Trace memory layout
 ~~~~~~~~~~~~~~~~~~~
 
-.. _table_trace_mem_layout:
-
 .. table:: Trace memory layout.
 
   +-------------------+
@@ -312,8 +310,6 @@ Trace memory layout
 packet.header
 ^^^^^^^^^^^^^
 
-.. _table_packet_header:
-
 .. table:: Packet header layout.
 
   +-------------------+
@@ -325,8 +321,6 @@ packet.header
 packet.context
 ^^^^^^^^^^^^^^
 
-.. _table_packet_context:
-
 .. table:: Packet context layout.
 
   +----------------------+
@@ -338,8 +332,6 @@ packet.context
 trace.header
 ^^^^^^^^^^^^
 
-.. _table_trace_header:
-
 .. table:: Trace header layout.
 
   +----------------------+
diff --git a/doc/guides/regexdevs/cn9k.rst b/doc/guides/regexdevs/cn9k.rst
index 0c58c095f4..fe117e0e25 100644
--- a/doc/guides/regexdevs/cn9k.rst
+++ b/doc/guides/regexdevs/cn9k.rst
@@ -38,8 +38,6 @@ those devices alone.
 Debugging Options
 -----------------
 
-.. _table_cn9k_regex_debug_options:
-
 .. table:: CN9K regex device debug options
 
    +---+------------+-------------------------------------------------------+
diff --git a/doc/guides/regexdevs/features_overview.rst b/doc/guides/regexdevs/features_overview.rst
index 3e7ab409bf..b4864e706a 100644
--- a/doc/guides/regexdevs/features_overview.rst
+++ b/doc/guides/regexdevs/features_overview.rst
@@ -90,8 +90,6 @@ References
 Features Table
 ==============
 
-.. _table_regex_pmd_features:
-
 .. include:: overview_feature_table.txt
 
 .. Note::
diff --git a/doc/guides/rel_notes/release_20_02.rst b/doc/guides/rel_notes/release_20_02.rst
index 925985b4f8..461ab16286 100644
--- a/doc/guides/rel_notes/release_20_02.rst
+++ b/doc/guides/rel_notes/release_20_02.rst
@@ -230,8 +230,6 @@ API Changes
 * No change in this release.
 
 
-.. _20_02_abi_changes:
-
 ABI Changes
 -----------
 
diff --git a/doc/guides/sample_app_ug/dist_app.rst b/doc/guides/sample_app_ug/dist_app.rst
index 30b4184d40..154d08d989 100644
--- a/doc/guides/sample_app_ug/dist_app.rst
+++ b/doc/guides/sample_app_ug/dist_app.rst
@@ -22,8 +22,6 @@ into each other.
 This application can be used to benchmark performance using the traffic
 generator as shown in the figure below.
 
-.. _figure_dist_perf:
-
 .. figure:: img/dist_perf.*
 
    Performance Benchmarking Setup (Basic Environment)
diff --git a/doc/guides/sample_app_ug/ip_pipeline.rst b/doc/guides/sample_app_ug/ip_pipeline.rst
index f9e8caa0a8..9a5cb517a2 100644
--- a/doc/guides/sample_app_ug/ip_pipeline.rst
+++ b/doc/guides/sample_app_ug/ip_pipeline.rst
@@ -117,8 +117,6 @@ During this stage, EAL layer is initialised and application specific arguments a
 (i.e. linked lists) for application objects are initialized. In case of any initialization error, an error message
 is displayed and the application is terminated.
 
-.. _ip_pipeline_runtime:
-
 Run-time
 ~~~~~~~~
 
@@ -136,8 +134,6 @@ executes two tasks in time-sharing mode:
 Examples
 --------
 
-.. _table_examples:
-
 .. tabularcolumns:: |p{3cm}|p{5cm}|p{4cm}|p{4cm}|
 
 .. table:: Pipeline examples provided with the application
diff --git a/doc/guides/sample_app_ug/l2_forward_crypto.rst b/doc/guides/sample_app_ug/l2_forward_crypto.rst
index ba38d9f22e..6ff693a8a1 100644
--- a/doc/guides/sample_app_ug/l2_forward_crypto.rst
+++ b/doc/guides/sample_app_ug/l2_forward_crypto.rst
@@ -193,8 +193,6 @@ on a packet received on an RX PORT before forwarding it to a TX PORT.
 The following figure illustrates a sample flow of a packet in the application,
 from reception until transmission.
 
-.. _figure_l2_fwd_encrypt_flow:
-
 .. figure:: img/l2_fwd_encrypt_flow.*
 
    Encryption flow through the L2 Forwarding with Crypto Application
diff --git a/doc/guides/sample_app_ug/l2_forward_event.rst b/doc/guides/sample_app_ug/l2_forward_event.rst
index 1d52211b9a..01f7ca88ae 100644
--- a/doc/guides/sample_app_ug/l2_forward_event.rst
+++ b/doc/guides/sample_app_ug/l2_forward_event.rst
@@ -123,8 +123,6 @@ Explanation
 
 The following sections provide an explanation of the code.
 
-.. _l2_fwd_event_app_cmd_arguments:
-
 Command Line Arguments
 ~~~~~~~~~~~~~~~~~~~~~~
 
@@ -175,8 +173,6 @@ and mbuf initializers, respectively ``rte_pktmbuf_pool_init()`` and ``rte_pktmbu
 An advanced application may want to use the mempool API to create the
 mbuf pool with more control.
 
-.. _l2_fwd_event_app_drv_init:
-
 Driver Initialization
 ~~~~~~~~~~~~~~~~~~~~~
 
@@ -230,8 +226,6 @@ structure called struct lcore_queue_conf.
 The values n_rx_port and rx_port_list[] are used in the main packet processing
 loop (see :ref:`l2_fwd_event_app_rx_tx_packets`).
 
-.. _l2_fwd_event_app_tx_init:
-
 TX Queue Initialization
 ~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -252,8 +246,6 @@ To configure eventdev support, the application sets up following components:
 *   Rx/Tx adapters
 *   Ethernet ports
 
-.. _l2_fwd_event_app_event_dev_init:
-
 Event device Initialization
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -294,8 +286,6 @@ Ethernet ports.
 In case of S/W scheduler, an extra event queue is created which will be used for
 Tx adapter service function for enqueue operation.
 
-.. _l2_fwd_app_event_port_init:
-
 Event port Initialization
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/sample_app_ug/l2_forward_real_virtual.rst b/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
index dbe880e1b3..bf848ce2db 100644
--- a/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
+++ b/doc/guides/sample_app_ug/l2_forward_real_virtual.rst
@@ -54,8 +54,6 @@ when MAC addresses updating is disabled.
 
 The L2 Forwarding application can also be used as a starting point for developing a new application based on the DPDK.
 
-.. _l2_fwd_vf_setup:
-
 Virtual Function Setup Instructions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/sample_app_ug/l3_forward.rst b/doc/guides/sample_app_ug/l3_forward.rst
index e797222eb4..452bd8cc6c 100644
--- a/doc/guides/sample_app_ug/l3_forward.rst
+++ b/doc/guides/sample_app_ug/l3_forward.rst
@@ -239,8 +239,6 @@ setup:
 Refer to the *DPDK Getting Started Guide* for general information on running applications and
 the Environment Abstraction Layer (EAL) options.
 
-.. _l3_fwd_explanation:
-
 Explanation
 -----------
 
@@ -288,8 +286,6 @@ R<destination_ip><source_ip><destination_port><source_port><protocol><output_por
 
 *   A typical IPv4 ACL rule line should have a format as shown below:
 
-.. _figure_ipv4_acl_rule:
-
 .. figure:: img/ipv4_acl_rule.*
 
    A typical IPv4 ACL rule
diff --git a/doc/guides/sample_app_ug/l3_forward_graph.rst b/doc/guides/sample_app_ug/l3_forward_graph.rst
index 57afdf2e9c..e4316779de 100644
--- a/doc/guides/sample_app_ug/l3_forward_graph.rst
+++ b/doc/guides/sample_app_ug/l3_forward_graph.rst
@@ -145,8 +145,6 @@ In this command:
 Refer to the *DPDK Getting Started Guide* for general information on running applications and
 the Environment Abstraction Layer (EAL) options.
 
-.. _l3_fwd_graph_explanation:
-
 Explanation
 -----------
 
diff --git a/doc/guides/sample_app_ug/multi_process.rst b/doc/guides/sample_app_ug/multi_process.rst
index 1bd858bfb5..3342417a7a 100644
--- a/doc/guides/sample_app_ug/multi_process.rst
+++ b/doc/guides/sample_app_ug/multi_process.rst
@@ -127,8 +127,6 @@ The symmetric multi process example demonstrates how a set of processes can run
 with each process performing the same set of packet- processing operations.
 The following diagram shows the data-flow through the application, using two processes.
 
-.. _figure_sym_multi_proc_app:
-
 .. figure:: img/sym_multi_proc_app.*
 
    Example Data Flow in a Symmetric Multi-process Application
@@ -208,8 +206,6 @@ by sending each packet out on a different network port.
 
 The following diagram shows the data-flow through the application, using two client processes.
 
-.. _figure_client_svr_sym_multi_proc_app:
-
 .. figure:: img/client_svr_sym_multi_proc_app.*
 
    Example Data Flow in a Client-Server Symmetric Multi-process Application
diff --git a/doc/guides/sample_app_ug/ptpclient.rst b/doc/guides/sample_app_ug/ptpclient.rst
index 0df465bcb4..4959234826 100644
--- a/doc/guides/sample_app_ug/ptpclient.rst
+++ b/doc/guides/sample_app_ug/ptpclient.rst
@@ -30,8 +30,6 @@ In order to keep the application simple the following assumptions are made:
 How the Application Works
 -------------------------
 
-.. _figure_ptpclient_highlevel:
-
 .. figure:: img/ptpclient.*
 
    PTP Synchronization Protocol
diff --git a/doc/guides/sample_app_ug/qos_metering.rst b/doc/guides/sample_app_ug/qos_metering.rst
index e7101559aa..a3f1b0a06f 100644
--- a/doc/guides/sample_app_ug/qos_metering.rst
+++ b/doc/guides/sample_app_ug/qos_metering.rst
@@ -79,8 +79,6 @@ The traffic meter parameters are configured in the application source code with
 Assuming the input traffic is generated at line rate and all packets are 64 bytes Ethernet frames (IPv4 packet size of 46 bytes)
 and green, the expected output traffic should be marked as shown in the following table:
 
-.. _table_qos_metering_1:
-
 .. table:: Output Traffic Marking
 
    +-------------+------------------+-------------------+----------------+
diff --git a/doc/guides/sample_app_ug/qos_scheduler.rst b/doc/guides/sample_app_ug/qos_scheduler.rst
index cd33beecb0..7805d240f9 100644
--- a/doc/guides/sample_app_ug/qos_scheduler.rst
+++ b/doc/guides/sample_app_ug/qos_scheduler.rst
@@ -11,8 +11,6 @@ Overview
 
 The architecture of the QoS scheduler application is shown in the following figure.
 
-.. _figure_qos_sched_app_arch:
-
 .. figure:: img/qos_sched_app_arch.*
 
    QoS Scheduler Application Architecture
@@ -213,8 +211,6 @@ The Port/Subport/Pipe/Traffic Class/Queue are the hierarchical entities in a typ
 The traffic flows that need to be configured are application dependent.
 This application classifies based on the QinQ double VLAN tags and the IP destination address as indicated in the following table.
 
-.. _table_qos_scheduler_1:
-
 .. table:: Entity Types
 
    +----------------+-------------------------+--------------------------------------------------+----------------------------------+
diff --git a/doc/guides/sample_app_ug/test_pipeline.rst b/doc/guides/sample_app_ug/test_pipeline.rst
index 818be93cd6..014c00121f 100644
--- a/doc/guides/sample_app_ug/test_pipeline.rst
+++ b/doc/guides/sample_app_ug/test_pipeline.rst
@@ -22,8 +22,6 @@ The application uses three CPU cores:
 
 *   Core C ("TX core") receives traffic from core B through software queues and sends it to the NIC ports for transmission.
 
-.. _figure_test_pipeline_app:
-
 .. figure:: img/test_pipeline_app.*
 
    Test Pipeline Application
diff --git a/doc/guides/sample_app_ug/vdpa.rst b/doc/guides/sample_app_ug/vdpa.rst
index 873efbf7c7..68985e11ae 100644
--- a/doc/guides/sample_app_ug/vdpa.rst
+++ b/doc/guides/sample_app_ug/vdpa.rst
@@ -78,8 +78,6 @@ Then we can create 2 vdpa ports in interactive cmdline.
         vdpa> create /tmp/vdpa-socket0 0000:06:00.3
         vdpa> create /tmp/vdpa-socket1 0000:06:00.4
 
-.. _vdpa_app_run_vm:
-
 Start the VMs
 ~~~~~~~~~~~~~
 
diff --git a/doc/guides/sample_app_ug/vhost.rst b/doc/guides/sample_app_ug/vhost.rst
index 4c944a844a..72dad16434 100644
--- a/doc/guides/sample_app_ug/vhost.rst
+++ b/doc/guides/sample_app_ug/vhost.rst
@@ -67,8 +67,6 @@ Start the vswitch example
 Check the `Parameters`_ section for the explanations on what do those
 parameters mean.
 
-.. _vhost_app_run_dpdk_inside_guest:
-
 Run testpmd inside guest
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -101,9 +99,6 @@ log from the dpdk-vhost console. It means you get it work::
 
     VHOST_DATA: (0) mac 52:54:00:00:00:14 and vlan 1000 registered
 
-
-.. _vhost_app_parameters:
-
 Parameters
 ----------
 
diff --git a/doc/guides/sample_app_ug/vhost_blk.rst b/doc/guides/sample_app_ug/vhost_blk.rst
index f33b3b6eaf..d8aaf7f43f 100644
--- a/doc/guides/sample_app_ug/vhost_blk.rst
+++ b/doc/guides/sample_app_ug/vhost_blk.rst
@@ -38,8 +38,6 @@ Start the vhost_blk example
 
         ./dpdk-vhost_blk -m 1024
 
-.. _vhost_blk_app_run_vm:
-
 Start the VM
 ~~~~~~~~~~~~
 
diff --git a/doc/guides/sample_app_ug/vhost_crypto.rst b/doc/guides/sample_app_ug/vhost_crypto.rst
index 5c4475342c..9ed2cc0ce7 100644
--- a/doc/guides/sample_app_ug/vhost_crypto.rst
+++ b/doc/guides/sample_app_ug/vhost_crypto.rst
@@ -65,8 +65,6 @@ the specified crypto operation are available on application initialization.
 This means that HW crypto device/s must be bound to a DPDK driver or
 a SW crypto device/s (virtual crypto PMD) must be created (using --vdev).
 
-.. _vhost_crypto_app_run_vm:
-
 Start the VM
 ~~~~~~~~~~~~
 
diff --git a/doc/guides/sample_app_ug/vm_power_management.rst b/doc/guides/sample_app_ug/vm_power_management.rst
index 1955140bb3..6ad669e4d6 100644
--- a/doc/guides/sample_app_ug/vm_power_management.rst
+++ b/doc/guides/sample_app_ug/vm_power_management.rst
@@ -54,8 +54,6 @@ directs frequency changes and policies to the host monitor rather than
 the APCI ``cpufreq`` ``sysfs`` interface used on the host in non-virtualised
 environments.
 
-.. _figure_vm_power_mgr_highlevel:
-
 .. figure:: img/vm_power_mgr_highlevel.*
 
    Highlevel Solution
@@ -108,9 +106,6 @@ determined automatically at runtime based on the environment. On
 receiving a request, the host translates the vCPU to a pCPU using the
 libvirt API before forwarding it to the host ``librte_power``.
 
-
-.. _figure_vm_power_mgr_vm_request_seq:
-
 .. figure:: img/vm_power_mgr_vm_request_seq.*
 
 In addition to the ability to send power management requests to the
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 5b9a348016..6c1d8bb951 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -580,8 +580,6 @@ The output is generated in ``build/doc/api/dts/html``.
 
    Make sure to fix any Sphinx warnings when adding or updating docstrings.
 
-.. _configuration_example:
-
 Configuration Example
 ---------------------
 
@@ -623,8 +621,6 @@ to demonstrate custom test suite configuration:
    You do not need to supply configurations for all test suites,
    and not all test suites will support or need additional configuration.
 
-.. _tests_config_example:
-
 ``dts/configurations/tests_config.example.yaml``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/tools/graph.rst b/doc/guides/tools/graph.rst
index 0ffd29e41f..ebb5218c76 100644
--- a/doc/guides/tools/graph.rst
+++ b/doc/guides/tools/graph.rst
@@ -365,13 +365,9 @@ This section mentions the created graph for each use case.
 l3fwd
 ~~~~~
 
-.. _figure_l3fwd_graph:
-
 .. figure:: img/graph-usecase-l3fwd.*
 
 l2fwd
 ~~~~~
 
-.. _figure_l2fwd_graph:
-
 .. figure:: img/graph-usecase-l2fwd.*
diff --git a/doc/guides/tools/pdump.rst b/doc/guides/tools/pdump.rst
index 6f9bd77ab1..e46588061e 100644
--- a/doc/guides/tools/pdump.rst
+++ b/doc/guides/tools/pdump.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2016 Intel Corporation.
 
-.. _pdump_tool:
-
 dpdk-pdump Application
 ======================
 
diff --git a/doc/guides/tools/testeventdev.rst b/doc/guides/tools/testeventdev.rst
index f4687ecf6b..d5b280bdad 100644
--- a/doc/guides/tools/testeventdev.rst
+++ b/doc/guides/tools/testeventdev.rst
@@ -260,8 +260,6 @@ This is a functional test case that aims at testing the following:
 #. Verify the ingress order maintenance.
 #. Verify the exclusive(atomic) access to given atomic flow per eventdev port.
 
-.. _table_eventdev_order_queue_test:
-
 .. table:: Order queue test eventdev configuration.
 
    +---+--------------+----------------+------------------------+
@@ -282,8 +280,6 @@ This is a functional test case that aims at testing the following:
    |   |              |                | port n                 |
    +---+--------------+----------------+------------------------+
 
-.. _figure_eventdev_order_queue_test:
-
 .. figure:: img/eventdev_order_queue_test.*
 
    order queue test operation.
@@ -343,8 +339,6 @@ but differs in two critical ways:
 #. Atomicity is verified using spinlocks
    for each combination of flow id and queue id.
 
-.. _table_eventdev_atomic_queue_test:
-
 .. table:: Atomic queue test eventdev configuration.
 
    +---+--------------+----------------+---------------------------+
@@ -365,8 +359,6 @@ but differs in two critical ways:
    |   |              |                | port n.                   |
    +---+--------------+----------------+---------------------------+
 
-.. _figure_eventdev_atomic_queue_test:
-
 .. figure:: img/eventdev_atomic_queue_test.*
 
    atomic queue test operation.
@@ -433,8 +425,6 @@ This test verifies the same aspects of ``order_queue`` test, the difference is
 the number of queues used, this test operates on a single ``all types queue(atq)``
 instead of two different queues for ordered and atomic.
 
-.. _table_eventdev_order_atq_test:
-
 .. table:: Order all types queue test eventdev configuration.
 
    +---+--------------+----------------+------------------------+
@@ -455,8 +445,6 @@ instead of two different queues for ordered and atomic.
    |   |              |                | port n.                |
    +---+--------------+----------------+------------------------+
 
-.. _figure_eventdev_order_atq_test:
-
 .. figure:: img/eventdev_order_atq_test.*
 
    order all types queue test operation.
@@ -497,8 +485,6 @@ the difference is the number of queues used,
 this test operates on a single ``all types queue(atq)``
 instead of two different atomic queues.
 
-.. _table_eventdev_atomic_atq_test:
-
 .. table:: Order all types queue test eventdev configuration.
 
    +---+--------------+----------------+-------------------------+
@@ -519,8 +505,6 @@ instead of two different atomic queues.
    |   |              |                | port n.                 |
    +---+--------------+----------------+-------------------------+
 
-.. _figure_eventdev_atomic_atq_test:
-
 .. figure:: img/eventdev_atomic_atq_test.*
 
    atomic all types queue test operation.
@@ -582,8 +566,6 @@ This is a performance test case that aims at testing the following:
    |   |              | nb_producers   | Producers use port n to port p          |
    +---+--------------+----------------+-----------------------------------------+
 
-.. _figure_eventdev_perf_queue_test:
-
 .. figure:: img/eventdev_perf_queue_test.*
 
    perf queue test operation.
@@ -720,8 +702,6 @@ This is a performance test case that aims at testing the following with
    |   |              | nb_producers   | Producers use port n to port p          |
    +---+--------------+----------------+-----------------------------------------+
 
-.. _figure_eventdev_perf_atq_test:
-
 .. figure:: img/eventdev_perf_atq_test.*
 
    perf all types queue test operation.
@@ -833,12 +813,8 @@ This is a pipeline test case that aims at testing the following:
    |   |              |                | depending on the Tx adapter capability. |
    +---+--------------+----------------+-----------------------------------------+
 
-.. _figure_eventdev_pipeline_queue_test_generic:
-
 .. figure:: img/eventdev_pipeline_queue_test_generic.*
 
-.. _figure_eventdev_pipeline_queue_test_internal_port:
-
 .. figure:: img/eventdev_pipeline_queue_test_internal_port.*
 
    pipeline queue test operation.
@@ -962,12 +938,8 @@ This is a pipeline test case that aims at testing the following with
    |   |              |                | depending on the Tx adapter capability. |
    +---+--------------+----------------+-----------------------------------------+
 
-.. _figure_eventdev_pipeline_atq_test_generic:
-
 .. figure:: img/eventdev_pipeline_atq_test_generic.*
 
-.. _figure_eventdev_pipeline_atq_test_internal_port:
-
 .. figure:: img/eventdev_pipeline_atq_test_internal_port.*
 
    pipeline atq test operation.
diff --git a/doc/guides/tools/testmldev.rst b/doc/guides/tools/testmldev.rst
index e3182c960f..05ad44297e 100644
--- a/doc/guides/tools/testmldev.rst
+++ b/doc/guides/tools/testmldev.rst
@@ -209,8 +209,6 @@ when handling with `N` number of models.
 executes the sequence of load / start / stop / unload for a model in order,
 followed by next model.
 
-.. _figure_mldev_model_ops_subtest_a:
-
 .. figure:: img/mldev_model_ops_subtest_a.*
 
    Execution sequence of model_ops subtest A.
@@ -219,8 +217,6 @@ followed by next model.
 executes load for all models, followed by a start for all models.
 Upon successful start of all models, stop is invoked for all models followed by unload.
 
-.. _figure_mldev_model_ops_subtest_b:
-
 .. figure:: img/mldev_model_ops_subtest_b.*
 
    Execution sequence of model_ops subtest B.
@@ -229,8 +225,6 @@ Upon successful start of all models, stop is invoked for all models followed by
 loads all models, followed by a start and stop of all models in order.
 Upon completion of stop, unload is invoked for all models.
 
-.. _figure_mldev_model_ops_subtest_c:
-
 .. figure:: img/mldev_model_ops_subtest_c.*
 
    Execution sequence of model_ops subtest C.
@@ -239,8 +233,6 @@ Upon completion of stop, unload is invoked for all models.
 executes load and start for all models available.
 Upon successful start of all models, stop is executed for the models.
 
-.. _figure_mldev_model_ops_subtest_d:
-
 .. figure:: img/mldev_model_ops_subtest_d.*
 
    Execution sequence of model_ops subtest D.
@@ -334,8 +326,6 @@ The model is unloaded upon completion of all inferences for the model.
 The test would continue loading and executing inference requests for all models
 specified through ``filelist`` option in an ordered manner.
 
-.. _figure_mldev_inference_ordered:
-
 .. figure:: img/mldev_inference_ordered.*
 
    Execution of inference_ordered on single model.
@@ -390,8 +380,6 @@ Total number of inferences enqueued for a model are equal to the repetitions spe
 An additional pool of threads would dequeue the inferences from the device.
 Models would be unloaded upon completion of inferences for all models loaded.
 
-.. _figure_mldev_inference_interleave:
-
 .. figure:: img/mldev_inference_interleave.*
 
    Execution of inference_interleave on single model.
diff --git a/doc/guides/vdpadevs/features_overview.rst b/doc/guides/vdpadevs/features_overview.rst
index 991c0998a5..1391e1692d 100644
--- a/doc/guides/vdpadevs/features_overview.rst
+++ b/doc/guides/vdpadevs/features_overview.rst
@@ -145,8 +145,6 @@ References
 Features Table
 ==============
 
-.. _table_vdpa_pmd_features:
-
 .. include:: overview_feature_table.txt
 
 .. Note::
diff --git a/doc/guides/windows_gsg/index.rst b/doc/guides/windows_gsg/index.rst
index e945935727..e98be2462d 100644
--- a/doc/guides/windows_gsg/index.rst
+++ b/doc/guides/windows_gsg/index.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2019 Intel Corporation.
 
-.. _windows_gsg:
-
 Getting Started Guide for Windows
 =================================
 
-- 
2.54.0

