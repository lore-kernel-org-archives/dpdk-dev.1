Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F10CC44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 10:36:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B51D14067D;
	Thu, 16 Jul 2026 12:36:55 +0200 (CEST)
Received: from flow-a7-smtp.messagingengine.com
 (flow-a7-smtp.messagingengine.com [103.168.172.142])
 by mails.dpdk.org (Postfix) with ESMTP id 52B01400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 12:36:54 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailflow.phl.internal (Postfix) with ESMTP id B6F68138049B;
 Thu, 16 Jul 2026 06:36:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 06:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784198213;
 x=1784205413; bh=xHAW9nUetk3XfdnaCC5laJLL+mvnVeDDv7JOvZ70sTg=; b=
 Arb71qjnSt7NmuLlkkaMITCim0mT8f6EKi+wijo0Jsp4lNv2T3fHNOJ/gWNi3wdy
 /YMIWMjLdl+WCZV3rBWdF2Qvcr3cKSZLqUHdrr7nX3ZT9sRaRJP6A+ulzroQQV9O
 R7VU0T8yPA30eYUZm+VIuK9lRlGZ19MVn7TdoGaeBP/cu08mwOuTsYTVUTaGiE/F
 jv7/p2IvdEnrUwcEdM7wbHrq9Oo1mVxPx0F6oJaMgaexGmDK+iL7qAcfQVAJekyc
 OyBP6CYhhojui2ZFuY3tqErmo07Bo+DxINC8y1a4Dte194rBywHtQCM4A5g64Kvc
 KIKsHkJwvL9Yx3EyNO7Yhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784198213; x=
 1784205413; bh=xHAW9nUetk3XfdnaCC5laJLL+mvnVeDDv7JOvZ70sTg=; b=P
 ynshWrzfeqFun2KqG5sTUvSQkr5zTuxte0BUtvRk3NoRtrwC0UyYOOcsWhCms9Ih
 eT1+buZF1srKtR484sPq9WrJocf/RynWCCkAJJ6oeqbUkrDcBNr0oCL3v6hepASZ
 rlOYnyucVWpUgrUahioflrD0bx5r/58P+sneaFt7ITXnsB5ZtBIJ9rbuoQostUnS
 4/L0E/T7QM2bJP/MY60H1rOOqOA2nZ69we9Y/xVl1yr4ji90mYGFc1JWyKAPyreq
 i8w/Bhhmu2xcCGrT+DV4bYAWTb+w/gzvvSW2as06wvL7qOCso+PebxOJQP/Friuz
 4vt+1o70JzMQBx2bDbJfA==
X-ME-Sender: <xms:RLRYan8jdEGC2jqGR0AK5_r0H3pNmgzBrrMsDF4hgeIT22SjHWnpMg>
 <xme:RLRYaoYe-n-mODT6O55tZH0d1TP6xG7zjfWgVntxqwmrQjxUnVl8Zmg_Ucoi5hMgU
 p_KqmaA8PLsRJIW9zcRjrC6ExKaKzO72-NSyKTZ-6b02vcsrO_kjw>
X-ME-Received: <xmr:RLRYas5F5MesQXNxEM8fwLHxpgR9AiSdSb-J471R88dRjlglH8lTtK0KrCcT_JbOx2I5Dal0okOVBCzf818qins>
X-ME-Proxy-Cause: dmFkZTEZmaLrmgmvguyRPElh3U8y2/3iCKDsUuFkCi8/Ft8MengdIGU9NIFsHX7ramgLcm
 n4bd1LHshO89Lzn+miQ1W/u5oST0rw24J4Gzpbgfj3jHFtJV27UUhw0RGqdjT4uJSDI5aW
 tg/jQDkV5ISl+uE5h2EmVK9PydbMlOr80yfwO+7kZHOWP63ELCrlXCTvRTgP5XinPECCe/
 PVjdWNUpP6fY07jRG0Q9G+rA73VzAsAhh6wd03dmkUgpyzdzed/neeCY03coPvGOqv4+bJ
 FrIZaH86sUEu8VNXGw85ahZ8TqCoqvEFfIPoD5pQ7TezzR7Qxre1po0gth1PdWjj9HDBXs
 1FDNzX6SLd433W56mUkDZ5XmTP+h8cjptlkeFObTiYL9wDWVOXnSHFEPO06hHHkj3SwP3u
 HV4Pm/P89qt7M723FtDU4NOZo7UbTmgO5IFYNQ+cjYYE1dbzFSC24qh1WnVudQ4P+YxbpY
 o3I23x2zPkaEDmfuoE2e0+YZLyGRgqvkCHByAUtzHVavZ6f7wtuYrVAJv/GYaxqcmdGO9G
 g0rBL8bWecdrRcPqKkKjOEQrt0iII7tz/6td1gd36RFfi3E4NOnA1JrdBMn9P3OBLX3di+
 7ozXwJHDNpOgRu0FucQody5UEKWG4F+p2YXYjsg2X7pDqCtHbN/4Dq+lk0/A
X-ME-Proxy: <xmx:RLRYanP5g2MnaKn26G5YJLiTRbY8iNOvsJ5zK4DPmEjKivrNsHnOLQ>
 <xmx:RLRYaqPSzw8yqYfRFz7qOVLf3YL3Vov-9Q2_XQS6hhYKHygf-JhTKw>
 <xmx:RLRYasJx3PjpCBV6pFtPNHBV8Ce5mdn4SS5L2SI5QfZcraOS8woQqQ>
 <xmx:RLRYatbXQpoFzNItgnP-Sjogy36Wbm1zVWfXJAM51K26idBrJyc5fg>
 <xmx:RbRYamIZsN2Dn_NiRx2NCZTAk_DqqRwJcvI2rpfL4pJI_cCMZdUJimZN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:36:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Nicolas Chautru <nicolas.chautru@intel.com>,
 Sunila Sahu <ssahu@marvell.com>,	Gagandeep Singh <g.singh@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,	Kai Ji <kai.ji@intel.com>,
 Vamsi Attunuru <vattunuru@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>,	Conor Walsh <conor.walsh@intel.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,	Liang Ma <liangma@bytedance.com>,
 Peter Mccarthy <peter.mccarthy@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Steven Webster <steven.webster@windriver.com>,
 Matt Peters <matt.peters@windriver.com>,
 Xingui Yang <yangxingui@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jakub Grajciar <jgrajcia@cisco.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,	Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,	Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>,	Akhil Goyal <gakhil@marvell.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,	Ori Kam <orika@nvidia.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Chas Williams <3chas3@gmail.com>,	"Min Hu (Connor)" <humin29@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Volodymyr Fialko <vfialko@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>,	Rosen Xu <rosen.xu@altera.com>,
 Liron Himi <lironh@marvell.com>,	Rajesh Kumar <rajesh3.kumar@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,	Aman Singh <aman.deep.singh@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v3 1/8] doc: adjust heading underline lengths
Date: Thu, 16 Jul 2026 12:31:19 +0200
Message-ID: <20260716103632.711164-2-thomas@monjalon.net>
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

Reduce underlines to match the length of the headings.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/bbdevs/acc100.rst                   |  2 +-
 doc/guides/bbdevs/fpga_lte_fec.rst             |  4 ++--
 doc/guides/bbdevs/null.rst                     |  2 +-
 doc/guides/compressdevs/zlib.rst               |  2 +-
 doc/guides/contributing/abi_policy.rst         |  2 +-
 doc/guides/contributing/coding_style.rst       |  2 +-
 doc/guides/cryptodevs/caam_jr.rst              |  2 +-
 doc/guides/cryptodevs/dpaa_sec.rst             |  2 +-
 doc/guides/cryptodevs/overview.rst             |  2 +-
 doc/guides/cryptodevs/qat.rst                  |  2 +-
 doc/guides/dmadevs/cnxk.rst                    |  2 +-
 doc/guides/dmadevs/hisi_acc.rst                |  4 ++--
 doc/guides/dmadevs/idxd.rst                    | 18 +++++++++---------
 doc/guides/dmadevs/ioat.rst                    | 16 ++++++++--------
 doc/guides/eventdevs/dpaa.rst                  |  4 ++--
 doc/guides/eventdevs/opdl.rst                  |  2 +-
 doc/guides/faq/faq.rst                         |  2 +-
 doc/guides/howto/af_xdp_dp.rst                 |  2 +-
 doc/guides/howto/avx512.rst                    |  2 +-
 doc/guides/howto/rte_flow.rst                  |  2 +-
 .../howto/virtio_user_as_exception_path.rst    |  2 +-
 .../linux_gsg/cross_build_dpdk_for_arm64.rst   |  2 +-
 doc/guides/linux_gsg/linux_drivers.rst         |  4 ++--
 doc/guides/nics/af_xdp.rst                     |  2 +-
 doc/guides/nics/avp.rst                        |  2 +-
 doc/guides/nics/hns3.rst                       |  2 +-
 doc/guides/nics/i40e.rst                       |  8 ++++----
 doc/guides/nics/ice.rst                        |  4 ++--
 doc/guides/nics/igc.rst                        |  2 +-
 doc/guides/nics/memif.rst                      |  2 +-
 doc/guides/nics/pfe.rst                        |  2 +-
 doc/guides/nics/qede.rst                       |  2 +-
 doc/guides/platform/cnxk.rst                   |  2 +-
 doc/guides/platform/dpaa.rst                   |  2 +-
 doc/guides/prog_guide/bbdev.rst                |  4 ++--
 doc/guides/prog_guide/build-sdk-meson.rst      | 12 ++++++------
 doc/guides/prog_guide/compressdev.rst          |  6 +++---
 doc/guides/prog_guide/cryptodev_lib.rst        |  2 +-
 doc/guides/prog_guide/devargs.rst              |  2 +-
 doc/guides/prog_guide/efd_lib.rst              |  2 +-
 .../prog_guide/env_abstraction_layer.rst       |  2 +-
 doc/guides/prog_guide/ethdev/flow_offload.rst  | 14 +++++++-------
 doc/guides/prog_guide/ethdev/qos_framework.rst |  2 +-
 .../eventdev/event_ethernet_rx_adapter.rst     |  2 +-
 .../eventdev/event_ethernet_tx_adapter.rst     |  2 +-
 doc/guides/prog_guide/hash_lib.rst             |  6 +++---
 doc/guides/prog_guide/index.rst                |  2 +-
 doc/guides/prog_guide/ipsec_lib.rst            |  4 ++--
 .../link_bonding_poll_mode_drv_lib.rst         |  2 +-
 doc/guides/prog_guide/member_lib.rst           |  2 +-
 doc/guides/prog_guide/mempool_lib.rst          |  2 +-
 doc/guides/prog_guide/multi_proc_support.rst   |  2 +-
 .../prog_guide/packet_classif_access_ctrl.rst  |  2 +-
 doc/guides/prog_guide/regexdev.rst             |  2 +-
 doc/guides/prog_guide/reorder_lib.rst          |  8 ++++----
 doc/guides/prog_guide/rte_security.rst         |  2 +-
 doc/guides/prog_guide/stack_lib.rst            |  2 +-
 doc/guides/prog_guide/toeplitz_hash_lib.rst    |  2 +-
 doc/guides/rawdevs/ifpga.rst                   |  4 ++--
 doc/guides/regexdevs/cn9k.rst                  |  2 +-
 doc/guides/sample_app_ug/dma.rst               |  2 +-
 doc/guides/sample_app_ug/flow_filtering.rst    |  2 +-
 doc/guides/sample_app_ug/ip_reassembly.rst     |  2 +-
 doc/guides/sample_app_ug/packet_ordering.rst   |  2 +-
 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst  |  2 +-
 doc/guides/sample_app_ug/vhost_blk.rst         |  4 ++--
 doc/guides/sample_app_ug/vmdq_forwarding.rst   |  2 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst    | 12 ++++++------
 doc/guides/tools/testbbdev.rst                 |  4 ++--
 doc/guides/tools/testeventdev.rst              |  4 ++--
 70 files changed, 122 insertions(+), 122 deletions(-)

diff --git a/doc/guides/bbdevs/acc100.rst b/doc/guides/bbdevs/acc100.rst
index 1621cc782f..253ed3e81f 100644
--- a/doc/guides/bbdevs/acc100.rst
+++ b/doc/guides/bbdevs/acc100.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2020 Intel Corporation
 
 Intel(R) ACC100 5G/4G FEC Poll Mode Drivers
-======================================================
+===========================================
 
 The BBDEV ACC100 5G/4G FEC poll mode driver (PMD) supports an
 implementation of a VRAN FEC wireless acceleration function.
diff --git a/doc/guides/bbdevs/fpga_lte_fec.rst b/doc/guides/bbdevs/fpga_lte_fec.rst
index 990eeb087b..b85112dae4 100644
--- a/doc/guides/bbdevs/fpga_lte_fec.rst
+++ b/doc/guides/bbdevs/fpga_lte_fec.rst
@@ -49,7 +49,7 @@ FPGA LTE FEC does not support the following:
 
 
 Installation
---------------
+------------
 
 Section 3 of the DPDK manual provides instructions on installing and compiling DPDK.
 
@@ -80,7 +80,7 @@ For more details on how to bind the PF device and create VF devices, see
 
 
 Configure the VFs through PF
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The PCI virtual functions must be configured before working or getting assigned
 to VMs/Containers. The configuration involves allocating the number of hardware
diff --git a/doc/guides/bbdevs/null.rst b/doc/guides/bbdevs/null.rst
index 0b885d17fc..4c3391af6a 100644
--- a/doc/guides/bbdevs/null.rst
+++ b/doc/guides/bbdevs/null.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2017 Intel Corporation
 
 BBDEV null Poll Mode Driver
-============================
+===========================
 
 The (**baseband_null**) is a bbdev poll mode driver which provides a minimal
 implementation of a software bbdev device. As a null device it does not modify
diff --git a/doc/guides/compressdevs/zlib.rst b/doc/guides/compressdevs/zlib.rst
index 8afa7dfbbb..3f452c6e04 100644
--- a/doc/guides/compressdevs/zlib.rst
+++ b/doc/guides/compressdevs/zlib.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2018 Cavium Networks.
 
 ZLIB Compression Poll Mode Driver
-==================================
+=================================
 
 The ZLIB PMD (**librte_compress_zlib**) provides poll mode compression &
 decompression driver based on SW zlib library,
diff --git a/doc/guides/contributing/abi_policy.rst b/doc/guides/contributing/abi_policy.rst
index f03a7467ac..9e9994c362 100644
--- a/doc/guides/contributing/abi_policy.rst
+++ b/doc/guides/contributing/abi_policy.rst
@@ -288,7 +288,7 @@ added to the Release Notes:
 .. _new_abi_version:
 
 New ABI versions
-------------------
+----------------
 
 A new ABI version may be declared aligned with a given release.
 The requirement to preserve compatibility with the previous major ABI version
diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
index 5c50ccfcb1..d6219cb6af 100644
--- a/doc/guides/contributing/coding_style.rst
+++ b/doc/guides/contributing/coding_style.rst
@@ -579,7 +579,7 @@ Casts and sizeof
   The redundant parenthesis rules do not apply to sizeof(var) instances.
 
 C Function Definition, Declaration and Use
--------------------------------------------
+------------------------------------------
 
 Prototypes
 ~~~~~~~~~~
diff --git a/doc/guides/cryptodevs/caam_jr.rst b/doc/guides/cryptodevs/caam_jr.rst
index d7b0f14234..ac1a26c5e6 100644
--- a/doc/guides/cryptodevs/caam_jr.rst
+++ b/doc/guides/cryptodevs/caam_jr.rst
@@ -73,7 +73,7 @@ AEAD algorithms:
 * ``RTE_CRYPTO_AEAD_AES_GCM``
 
 Supported DPAA SoCs
---------------------
+-------------------
 
 * LS1046A/LS1026A
 * LS1043A/LS1023A
diff --git a/doc/guides/cryptodevs/dpaa_sec.rst b/doc/guides/cryptodevs/dpaa_sec.rst
index 0c8d6cf3da..9980c07e86 100644
--- a/doc/guides/cryptodevs/dpaa_sec.rst
+++ b/doc/guides/cryptodevs/dpaa_sec.rst
@@ -77,7 +77,7 @@ AEAD algorithms:
 * ``RTE_CRYPTO_AEAD_AES_GCM``
 
 Supported DPAA SoCs
---------------------
+-------------------
 
 * LS1046A/LS1026A
 * LS1043A/LS1023A
diff --git a/doc/guides/cryptodevs/overview.rst b/doc/guides/cryptodevs/overview.rst
index b068d0d19c..4f963ed24e 100644
--- a/doc/guides/cryptodevs/overview.rst
+++ b/doc/guides/cryptodevs/overview.rst
@@ -82,7 +82,7 @@ Supported Asymmetric Algorithms
 .. include:: overview_asym_table.txt
 
 Supported Operating Systems
--------------------------------
+---------------------------
 
 .. _table_crypto_pmd_os:
 
diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index cb53772f5b..7a056ce902 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -353,7 +353,7 @@ To use this feature the user must set the devarg on process start as a device ad
 
 
 Running QAT PMD with Intel IPsec MB library
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The QAT PMD requires IPsec MB library
 for HMAC partial hash calculation in symmetric precomputes function.
diff --git a/doc/guides/dmadevs/cnxk.rst b/doc/guides/dmadevs/cnxk.rst
index 797301f226..b671c65644 100644
--- a/doc/guides/dmadevs/cnxk.rst
+++ b/doc/guides/dmadevs/cnxk.rst
@@ -22,7 +22,7 @@ Prerequisites and Compilation procedure
 See :doc:`../platform/cnxk` for setup information.
 
 Device Setup
--------------
+------------
 
 The ``dpdk-devbind.py`` script, included with DPDK,
 can be used to show the presence of supported hardware.
diff --git a/doc/guides/dmadevs/hisi_acc.rst b/doc/guides/dmadevs/hisi_acc.rst
index bd08e7a4da..2b2b765793 100644
--- a/doc/guides/dmadevs/hisi_acc.rst
+++ b/doc/guides/dmadevs/hisi_acc.rst
@@ -16,7 +16,7 @@ Supported Kunpeng SoCs
 
 
 Device Setup
--------------
+------------
 
 In order to use the device in DPDK, user should
 insmod `uacce.ko`, `hisi_qm.ko`
@@ -45,7 +45,7 @@ named ``hisi_zip-0-dma0`` and ``hisi_zip-0-dma1``.
    and algorithms contain ``udma``.
 
 Device Configuration
-~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~
 
 Configuration requirements:
 
diff --git a/doc/guides/dmadevs/idxd.rst b/doc/guides/dmadevs/idxd.rst
index 6c2a12b4ba..1b33e23d30 100644
--- a/doc/guides/dmadevs/idxd.rst
+++ b/doc/guides/dmadevs/idxd.rst
@@ -14,7 +14,7 @@ data operations, such as data copies, to hardware, freeing up CPU cycles for
 other tasks.
 
 Hardware Requirements
-----------------------
+---------------------
 
 The ``dpdk-devbind.py`` script, included with DPDK, can be used to show the
 presence of supported hardware. Running ``dpdk-devbind.py --status-dev dma``
@@ -24,13 +24,13 @@ as devices with type “0b25”, due to the absence of pci-id database entries f
 them at this point.
 
 Compilation
-------------
+-----------
 
 For builds using ``meson`` and ``ninja``, the driver will be built when the
 target platform is x86-based. No additional compilation steps are necessary.
 
 Device Setup
--------------
+------------
 
 Intel\ |reg| DSA devices can use the IDXD kernel driver or DPDK-supported drivers,
 such as ``vfio-pci``. Both are supported by the IDXD PMD.
@@ -42,7 +42,7 @@ such as ``vfio-pci``. Both are supported by the IDXD PMD.
    Multi-process is not supported when using the kernel IDXD driver.
 
 Intel\ |reg| DSA devices using IDXD kernel driver
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 To use an Intel\ |reg| DSA device bound to the IDXD kernel driver, the device must first be configured.
 The `accel-config <https://github.com/intel/idxd-config>`_ utility library can be used for configuration.
@@ -121,7 +121,7 @@ giving each an equal share of resources::
 
 
 Devices using VFIO/UIO drivers
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The HW devices to be used will need to be bound to a user-space IO driver for use.
 The ``dpdk-devbind.py`` script can be used to view the state of the devices
@@ -138,7 +138,7 @@ For example::
    ``0000:6a:01.0-q0``, ``00006a:01.0-q1``, etc.
 
 Device Probing and Initialization
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 For devices bound to a suitable DPDK-supported VFIO/UIO driver, the HW devices will
 be found as part of the device scan done at application initialization time without
@@ -177,12 +177,12 @@ that is a "DMA device type" inside DPDK, and can be accessed using APIs from the
 ``rte_dmadev`` library.
 
 Using IDXD DMAdev Devices
---------------------------
+-------------------------
 
 To use the devices from an application, the dmadev API can be used.
 
 Device Configuration
-~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~
 
 IDXD configuration requirements:
 
@@ -195,7 +195,7 @@ Once configured, the device can then be made ready for use by calling the
 ``rte_dma_start()`` API.
 
 Performing Data Copies
-~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~
 
 Refer to the :ref:`Enqueue / Dequeue APIs <dmadev_enqueue_dequeue>` section of the dmadev library
 documentation for details on operation enqueue, submission and completion API usage.
diff --git a/doc/guides/dmadevs/ioat.rst b/doc/guides/dmadevs/ioat.rst
index 9ac90e3108..9ee7852dde 100644
--- a/doc/guides/dmadevs/ioat.rst
+++ b/doc/guides/dmadevs/ioat.rst
@@ -4,7 +4,7 @@
 .. include:: <isonum.txt>
 
 IOAT DMA Device Driver
-=======================
+======================
 
 The ``ioat`` dmadev driver provides a poll-mode driver (PMD) for Intel\
 |reg| QuickData Technology which is part of part of Intel\ |reg| I/O
@@ -15,7 +15,7 @@ cloning packet data, to be accelerated by IOAT hardware rather than having to
 be done by software, freeing up CPU cycles for other tasks.
 
 Hardware Requirements
-----------------------
+---------------------
 
 The ``dpdk-devbind.py`` script, included with DPDK, can be used to show the
 presence of supported hardware. Running ``dpdk-devbind.py --status-dev dma``
@@ -30,13 +30,13 @@ absence of pci-id database entries for them at this point.
         Cascade Lake.
 
 Compilation
-------------
+-----------
 
 For builds using ``meson`` and ``ninja``, the driver will be built when the
 target platform is x86-based. No additional compilation steps are necessary.
 
 Device Setup
--------------
+------------
 
 Intel\ |reg| IOAT devices will need to be bound to a suitable DPDK-supported
 user-space IO driver such as ``vfio-pci`` in order to be used by DPDK.
@@ -51,7 +51,7 @@ For example::
 	$ dpdk-devbind.py -b vfio-pci 00:01.0 00:01.1
 
 Device Probing and Initialization
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 For devices bound to a suitable DPDK-supported driver (``vfio-pci``), the HW
 devices will be found as part of the device scan done at application
@@ -69,12 +69,12 @@ Once probed successfully, the device will appear as a ``dmadev``, that is a
 ``rte_dmadev`` library.
 
 Using IOAT DMAdev Devices
---------------------------
+-------------------------
 
 To use IOAT devices from an application, the ``dmadev`` API can be used.
 
 Device Configuration
-~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~
 
 IOAT configuration requirements:
 
@@ -87,7 +87,7 @@ Once configured, the device can then be made ready for use by calling the
 ``rte_dma_start()`` API.
 
 Performing Data Copies
-~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~
 
 Refer to the :ref:`Enqueue / Dequeue APIs <dmadev_enqueue_dequeue>` section of the dmadev library
 documentation for details on operation enqueue, submission and completion API usage.
diff --git a/doc/guides/eventdevs/dpaa.rst b/doc/guides/eventdevs/dpaa.rst
index 8fb1d469dd..fed66b79a1 100644
--- a/doc/guides/eventdevs/dpaa.rst
+++ b/doc/guides/eventdevs/dpaa.rst
@@ -2,7 +2,7 @@
    Copyright 2017 NXP
 
 NXP DPAA Eventdev Driver
-=========================
+========================
 
 The dpaa eventdev is an implementation of the eventdev API, that provides a
 wide range of the eventdev features. The eventdev relies on a dpaa based
@@ -23,7 +23,7 @@ The DPAA EVENTDEV implements many features in the eventdev API;
 - Atomic flows
 
 Supported DPAA SoCs
---------------------
+-------------------
 
 - LS1046A/LS1026A
 - LS1043A/LS1023A
diff --git a/doc/guides/eventdevs/opdl.rst b/doc/guides/eventdevs/opdl.rst
index f220959249..42c015c8ca 100644
--- a/doc/guides/eventdevs/opdl.rst
+++ b/doc/guides/eventdevs/opdl.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2017 Intel Corporation.
 
 OPDL Eventdev Poll Mode Driver
-==================================
+==============================
 
 The OPDL (Ordered Packet Distribution Library) eventdev is a specific\
 implementation of the eventdev API. It is particularly suited to packet\
diff --git a/doc/guides/faq/faq.rst b/doc/guides/faq/faq.rst
index d675c870ff..d42c4314e2 100644
--- a/doc/guides/faq/faq.rst
+++ b/doc/guides/faq/faq.rst
@@ -141,7 +141,7 @@ and <MAC address> being the desired MAC address.
 
 
 Is it safe to add an entry to the hash table while running?
-------------------------------------------------------------
+-----------------------------------------------------------
 Currently the table implementation is not a thread safe implementation and assumes that locking between threads and processes is handled by the user's application.
 This is likely to be supported in future releases.
 
diff --git a/doc/guides/howto/af_xdp_dp.rst b/doc/guides/howto/af_xdp_dp.rst
index b3681af2f7..68e524305e 100644
--- a/doc/guides/howto/af_xdp_dp.rst
+++ b/doc/guides/howto/af_xdp_dp.rst
@@ -137,7 +137,7 @@ Example
 -------
 
 Build a DPDK container image (using Docker)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 1. Create a Dockerfile (should be placed in top level DPDK directory):
 
diff --git a/doc/guides/howto/avx512.rst b/doc/guides/howto/avx512.rst
index 6c034b617d..a9ff770740 100644
--- a/doc/guides/howto/avx512.rst
+++ b/doc/guides/howto/avx512.rst
@@ -26,7 +26,7 @@ For more information on the possible enum values to use as a parameter, go to :r
 
 
 Using the command-line argument
----------------------------------------------
+-------------------------------
 
 The user can select to use AVX-512 at runtime, using the following argument to set the max bitwidth::
 
diff --git a/doc/guides/howto/rte_flow.rst b/doc/guides/howto/rte_flow.rst
index 7852b6e509..428ec3f411 100644
--- a/doc/guides/howto/rte_flow.rst
+++ b/doc/guides/howto/rte_flow.rst
@@ -106,7 +106,7 @@ Terminal 1: output log::
   received packet with src ip = 176.80.50.4
 
 Range IPv4 drop
-----------------
+---------------
 
 Description
 ~~~~~~~~~~~
diff --git a/doc/guides/howto/virtio_user_as_exception_path.rst b/doc/guides/howto/virtio_user_as_exception_path.rst
index 212abc8e54..0d4c8aeb94 100644
--- a/doc/guides/howto/virtio_user_as_exception_path.rst
+++ b/doc/guides/howto/virtio_user_as_exception_path.rst
@@ -51,7 +51,7 @@ in :numref:`figure_virtio_user_as_exception_path`.
 
 
 Example Usage With Testpmd
----------------------------
+--------------------------
 
 .. note::
 
diff --git a/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst b/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
index 82dde17c35..6485943da0 100644
--- a/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
+++ b/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
@@ -186,7 +186,7 @@ LLVM/Clang toolchain
 --------------------
 
 Obtain the cross toolchain
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The latest LLVM/Clang cross compiler toolchain can be downloaded from:
 https://developer.arm.com/tools-and-software/open-source-software/developer-tools/llvm-toolchain.
diff --git a/doc/guides/linux_gsg/linux_drivers.rst b/doc/guides/linux_gsg/linux_drivers.rst
index 8b117f92c2..8ffd281330 100644
--- a/doc/guides/linux_gsg/linux_drivers.rst
+++ b/doc/guides/linux_gsg/linux_drivers.rst
@@ -168,7 +168,7 @@ After that, VFIO can be used with hardware devices as usual.
    in situations where IOMMU is not available.
 
 VFIO Memory Mapping Limits
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 For DMA mapping of either external memory or hugepages, VFIO interface is used.
 VFIO does not support partial unmap of once mapped memory. Hence DPDK's memory is
@@ -198,7 +198,7 @@ Alternatively, one can also change this value in an already loaded kernel module
    echo 512000 > /sys/module/vfio_iommu_type1/parameters/dma_entry_limit
 
 Creating Virtual Functions using vfio-pci
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Since Linux version 5.7,
 the ``vfio-pci`` module supports the creation of virtual functions.
diff --git a/doc/guides/nics/af_xdp.rst b/doc/guides/nics/af_xdp.rst
index 8bd17f04ae..c455b4c066 100644
--- a/doc/guides/nics/af_xdp.rst
+++ b/doc/guides/nics/af_xdp.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2019-2020 Intel Corporation.
 
 AF_XDP Poll Mode Driver
-==========================
+=======================
 
 AF_XDP is an address family that is optimized for high performance
 packet processing. AF_XDP sockets enable the possibility for an XDP program to
diff --git a/doc/guides/nics/avp.rst b/doc/guides/nics/avp.rst
index a749f2a0f6..6d319b0fc6 100644
--- a/doc/guides/nics/avp.rst
+++ b/doc/guides/nics/avp.rst
@@ -3,7 +3,7 @@
     All rights reserved.
 
 AVP Poll Mode Driver
-=================================================================
+====================
 
 The Accelerated Virtual Port (AVP) device is a shared memory based device
 only available on `virtualization platforms <http://www.windriver.com/products/titanium-cloud/>`_
diff --git a/doc/guides/nics/hns3.rst b/doc/guides/nics/hns3.rst
index 5e0fdd5bbb..0d36f135f5 100644
--- a/doc/guides/nics/hns3.rst
+++ b/doc/guides/nics/hns3.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2018-2019 HiSilicon Limited.
 
 HNS3 Poll Mode Driver
-===============================
+=====================
 
 The hns3 PMD (**librte_net_hns3**) provides poll mode driver support
 for the inbuilt HiSilicon Network Subsystem(HNS) network engine
diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index e67498aef4..fdfe257ba4 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2016 Intel Corporation.
 
 I40E Poll Mode Driver
-======================
+=====================
 
 The i40e PMD (**librte_net_i40e**) provides poll mode driver support for
 10/25/40 Gbps Intel® Ethernet 700 Series Network Adapters based on
@@ -447,7 +447,7 @@ Check the flow director status:
 
 
 Floating VEB
-~~~~~~~~~~~~~
+~~~~~~~~~~~~
 
 The Intel® Ethernet 700 Series support a feature called
 "Floating VEB".
@@ -550,7 +550,7 @@ For example, to use only 48bit prefix for IPv6 src address for IPv6 TCP RSS:
    testpmd> port config 0 pctype 43 hash_inset set field 15
 
 Queue region configuration
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 The Intel® Ethernet 700 Series supports a feature of queue regions
 configuration for RSS in the PF, so that different traffic classes or
 different packet classification types can be separated to different
@@ -572,7 +572,7 @@ APIs are used.
    testpmd> show port (port_id) queue-region
 
 Generic flow API
-~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~
 
 - ``RSS Flow``
 
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 5589ce934f..413478b727 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2018 Intel Corporation.
 
 ICE Poll Mode Driver
-======================
+====================
 
 The ice PMD (**librte_net_ice**) provides poll mode driver support for
 10/25/50/100/200 Gbps Intel® Ethernet 800 Series Network Adapters based on
@@ -399,7 +399,7 @@ report a MDD event and drop the packets.
 The APPs based on DPDK should avoid providing such packets.
 
 Device Config Function (DCF)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This section demonstrates ICE DCF PMD, which shares the core module with ICE
 PMD and iAVF PMD.
diff --git a/doc/guides/nics/igc.rst b/doc/guides/nics/igc.rst
index d19a572b83..3de4d6d2fc 100644
--- a/doc/guides/nics/igc.rst
+++ b/doc/guides/nics/igc.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2020 Intel Corporation.
 
 IGC Poll Mode Driver
-======================
+====================
 
 The IGC PMD (**librte_net_e1000**) provides poll mode driver support for Foxville
 I225 and I226 Series Network Adapters.
diff --git a/doc/guides/nics/memif.rst b/doc/guides/nics/memif.rst
index 2867b2f66d..79b048865f 100644
--- a/doc/guides/nics/memif.rst
+++ b/doc/guides/nics/memif.rst
@@ -211,7 +211,7 @@ Only single file segments mode (EAL option --single-file-segments) is supported,
 offset from multiple segments is too expensive.
 
 Example: testpmd
-----------------------------
+----------------
 In this example we run two instances of testpmd application and transmit packets over memif.
 
 First create ``server`` interface::
diff --git a/doc/guides/nics/pfe.rst b/doc/guides/nics/pfe.rst
index 172ae80984..df33a50237 100644
--- a/doc/guides/nics/pfe.rst
+++ b/doc/guides/nics/pfe.rst
@@ -2,7 +2,7 @@
    Copyright 2019 NXP
 
 PFE Poll Mode Driver
-======================
+====================
 
 The PFE NIC PMD (**librte_net_pfe**) provides poll mode driver
 support for the inbuilt NIC found in the **NXP LS1012** SoC.
diff --git a/doc/guides/nics/qede.rst b/doc/guides/nics/qede.rst
index c067a4c796..c99606877b 100644
--- a/doc/guides/nics/qede.rst
+++ b/doc/guides/nics/qede.rst
@@ -3,7 +3,7 @@
     Copyright(c) 2017 Cavium, Inc
 
 QEDE Poll Mode Driver
-======================
+=====================
 
 The QEDE poll mode driver library (**librte_net_qede**) implements support
 for **QLogic FastLinQ QL4xxxx 10G/25G/40G/50G/100G Intelligent Ethernet Adapters (IEA) and Converged Network Adapters (CNA)** family of adapters as well as SR-IOV virtual functions (VF). It is supported on
diff --git a/doc/guides/platform/cnxk.rst b/doc/guides/platform/cnxk.rst
index 4aa900dd63..c0e92dabbf 100644
--- a/doc/guides/platform/cnxk.rst
+++ b/doc/guides/platform/cnxk.rst
@@ -143,7 +143,7 @@ The primary use case for SDP is to enable the smart NIC use case. Typical usage
    vice-versa.
 
 cnxk packet flow
-----------------------
+----------------
 
 The :numref:`figure_cnxk_packet_flow_hw_accelerators` diagram depicts
 the packet flow on cnxk SoC in conjunction with use of various HW accelerators.
diff --git a/doc/guides/platform/dpaa.rst b/doc/guides/platform/dpaa.rst
index 282a2f45ee..68ef4a8d7b 100644
--- a/doc/guides/platform/dpaa.rst
+++ b/doc/guides/platform/dpaa.rst
@@ -9,7 +9,7 @@ based layerscape platform and information about common offload
 hw block drivers of **NXP QorIQ DPAA** SoC family.
 
 Supported DPAA SoCs
---------------------
+-------------------
 
 * LS1046A/LS1026A
 * LS1043A/LS1023A
diff --git a/doc/guides/prog_guide/bbdev.rst b/doc/guides/prog_guide/bbdev.rst
index bdd2d87471..6fd849436d 100644
--- a/doc/guides/prog_guide/bbdev.rst
+++ b/doc/guides/prog_guide/bbdev.rst
@@ -740,7 +740,7 @@ TB-mode. CB-mode is a reduced version, where only one CB exists:
     Turbo decoding of Code Blocks in mbuf structure
 
 BBDEV LDPC Encode Operation
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The operation flags that can be set for each LDPC encode operation are
 given below.
@@ -883,7 +883,7 @@ showing the Turbo encoding of CBs using BBDEV interface in TB-mode
 is also valid for LDPC encode.
 
 BBDEV LDPC Decode Operation
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The operation flags that can be set for each LDPC decode operation are
 given below.
diff --git a/doc/guides/prog_guide/build-sdk-meson.rst b/doc/guides/prog_guide/build-sdk-meson.rst
index fdb5d484fa..74465d52c3 100644
--- a/doc/guides/prog_guide/build-sdk-meson.rst
+++ b/doc/guides/prog_guide/build-sdk-meson.rst
@@ -5,7 +5,7 @@ Installing DPDK Using the meson build system
 ============================================
 
 Summary
---------
+-------
 For many platforms, compiling and installing DPDK should work using the
 following set of commands::
 
@@ -29,7 +29,7 @@ More detail on each of these steps can be got from the following sections.
 
 
 Getting the Tools
-------------------
+-----------------
 
 The ``meson`` tool is used to configure a DPDK build. On most Linux
 distributions this can be got using the local package management system,
@@ -54,7 +54,7 @@ It is best advised to go over the following links for the complete dependencies:
 
 
 Configuring the Build
-----------------------
+---------------------
 
 To configure a build, run the meson tool, passing the path to the directory
 to be used for the build e.g. ``meson setup build``, as shown above. If calling
@@ -150,7 +150,7 @@ example::
 
 
 Performing the Build
----------------------
+--------------------
 
 Use ``ninja`` to perform the actual build inside the build folder
 previously configured. In most cases no arguments are necessary.
@@ -163,7 +163,7 @@ printing each command on a new line as it runs.
 
 
 Installing the Compiled Files
-------------------------------
+-----------------------------
 
 Use ``meson install`` to install the required DPDK files onto the system.
 The install prefix defaults to ``/usr/local`` but can be used as with other
@@ -205,7 +205,7 @@ and other build tools to be used, as well as characteristics of the target
 machine.
 
 Using the DPDK within an Application
--------------------------------------
+------------------------------------
 
 To compile and link against DPDK within an application, pkg-config should
 be used to query the correct parameters. Examples of this are given in the
diff --git a/doc/guides/prog_guide/compressdev.rst b/doc/guides/prog_guide/compressdev.rst
index 2a59c434c1..a4df01f89f 100644
--- a/doc/guides/prog_guide/compressdev.rst
+++ b/doc/guides/prog_guide/compressdev.rst
@@ -291,7 +291,7 @@ enough to store digest, which is 20 bytes for SHA-1 and
 32 bytes for SHA2-256.
 
 Compression API Stateless operation
-------------------------------------
+-----------------------------------
 
 An op is processed stateless if it has
 - op_type set to RTE_COMP_OP_STATELESS
@@ -305,7 +305,7 @@ complete. The application can enqueue multiple stateless ops in a single burst
 and must attach priv_xform handle to such ops.
 
 priv_xform in Stateless operation
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 A priv_xform is private data managed internally by the PMD to do stateless processing.
 A priv_xform is initialized by an application providing a generic xform structure
@@ -427,7 +427,7 @@ processed i.e. dequeued with status = RTE_COMP_OP_STATUS_SUCCESS.
 .. _compressdev_stateful_op:
 
 Compression API Stateful operation
------------------------------------
+----------------------------------
 
 The compression API provides RTE_COMP_FF_STATEFUL_COMPRESSION and
 RTE_COMP_FF_STATEFUL_DECOMPRESSION feature flag for the PMD to reflect
diff --git a/doc/guides/prog_guide/cryptodev_lib.rst b/doc/guides/prog_guide/cryptodev_lib.rst
index f0ee44eb54..817d39dd62 100644
--- a/doc/guides/prog_guide/cryptodev_lib.rst
+++ b/doc/guides/prog_guide/cryptodev_lib.rst
@@ -158,7 +158,7 @@ packet processing pipeline.
 
 
 Device Features and Capabilities
----------------------------------
+--------------------------------
 
 Crypto devices define their functionality through two mechanisms, global device
 features and algorithm capabilities. Global devices features identify device
diff --git a/doc/guides/prog_guide/devargs.rst b/doc/guides/prog_guide/devargs.rst
index 19e1e9e050..e4076e0e33 100644
--- a/doc/guides/prog_guide/devargs.rst
+++ b/doc/guides/prog_guide/devargs.rst
@@ -217,7 +217,7 @@ See :doc:`device_hotplug` for detailed information on runtime device management.
 
 
 Parsing Devargs in Drivers
----------------------------
+--------------------------
 
 PMD drivers can parse devargs using the kvargs library:
 
diff --git a/doc/guides/prog_guide/efd_lib.rst b/doc/guides/prog_guide/efd_lib.rst
index 68404d5f33..7941c83821 100644
--- a/doc/guides/prog_guide/efd_lib.rst
+++ b/doc/guides/prog_guide/efd_lib.rst
@@ -417,7 +417,7 @@ is stored in these two bits.
 .. _Efd_references:
 
 References
------------
+----------
 
 1- EFD is based on collaborative research work between Intel and
 Carnegie Mellon University (CMU), interested readers can refer to the paper
diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index 62e6a793d2..29af5dc9be 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -212,7 +212,7 @@ variables:
 Normally, these options do not need to be changed.
 
 Runtime Override of Per-Page-Size Memory Limits
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 By default, DPDK uses compile-time configured limits
 for memory allocation per page size (as set by ``RTE_MAX_MEM_MB_PER_TYPE``).
diff --git a/doc/guides/prog_guide/ethdev/flow_offload.rst b/doc/guides/prog_guide/ethdev/flow_offload.rst
index 08cbb05bb7..bb2986b67c 100644
--- a/doc/guides/prog_guide/ethdev/flow_offload.rst
+++ b/doc/guides/prog_guide/ethdev/flow_offload.rst
@@ -619,7 +619,7 @@ Matches tag item set by other flows. Multiple tags are supported by specifying
    +----------+-----------+---------------------------------------+
 
 Item: ``META``
-^^^^^^^^^^^^^^^^^
+^^^^^^^^^^^^^^
 
 Matches 32 bit metadata item set.
 
@@ -1314,7 +1314,7 @@ Matches a IP Authentication Header (RFC 4302).
 - Default ``mask`` matches spi.
 
 Item: ``HIGIG2``
-^^^^^^^^^^^^^^^^^
+^^^^^^^^^^^^^^^^
 
 Matches a HIGIG2 header field. It is layer 2.5 protocol and used in
 Broadcom switches.
@@ -2464,7 +2464,7 @@ the original packet the resulting packet must be a valid packet.
    +----------------+----------------------------------------+
 
 Action: ``RAW_DECAP``
-^^^^^^^^^^^^^^^^^^^^^^^
+^^^^^^^^^^^^^^^^^^^^^
 
 Remove outer header whose template is provided in its data buffer,
 as defined in the ``rte_flow_action_raw_decap``
@@ -2587,7 +2587,7 @@ This action modifies the payload of matched flow
 and the packet should be valid after removing.
 
 Action: ``SET_TP_SRC``
-^^^^^^^^^^^^^^^^^^^^^^^^^
+^^^^^^^^^^^^^^^^^^^^^^
 This is a legacy action. Consider `Action: MODIFY_FIELD`_ as alternative.
 
 Set a new source port number in the outermost TCP/UDP header.
@@ -2606,7 +2606,7 @@ flow pattern item. Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
    +---------------+--------------------+
 
 Action: ``SET_TP_DST``
-^^^^^^^^^^^^^^^^^^^^^^^^^
+^^^^^^^^^^^^^^^^^^^^^^
 This is a legacy action. Consider `Action: MODIFY_FIELD`_ as alternative.
 
 Set a new destination port number in the outermost TCP/UDP header.
@@ -2625,7 +2625,7 @@ flow pattern item. Otherwise, RTE_FLOW_ERROR_TYPE_ACTION error will be returned.
    +---------------+-------------------------+
 
 Action: ``MAC_SWAP``
-^^^^^^^^^^^^^^^^^^^^^^^^^
+^^^^^^^^^^^^^^^^^^^^
 
 Swap the source and destination MAC addresses in the outermost Ethernet
 header.
@@ -2779,7 +2779,7 @@ application. Multiple tags are supported by specifying index.
    +-----------+----------------------------+
 
 Action: ``SET_META``
-^^^^^^^^^^^^^^^^^^^^^^^
+^^^^^^^^^^^^^^^^^^^^
 This is a legacy action. Consider `Action: MODIFY_FIELD`_ as alternative.
 
 Set metadata. Item ``META`` matches metadata.
diff --git a/doc/guides/prog_guide/ethdev/qos_framework.rst b/doc/guides/prog_guide/ethdev/qos_framework.rst
index 0f61264ccc..03191d6602 100644
--- a/doc/guides/prog_guide/ethdev/qos_framework.rst
+++ b/doc/guides/prog_guide/ethdev/qos_framework.rst
@@ -1567,7 +1567,7 @@ The source files for the DPDK dropper are located at:
 *   DPDK/lib/sched/rte_red.c
 
 Integration with the DPDK QoS Scheduler
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 RED functionality in the DPDK QoS scheduler is disabled by default.
 The parameter is found in the build configuration files in the DPDK/config directory.
diff --git a/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst b/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
index c7fb15d10d..3e3b3dd04e 100644
--- a/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
@@ -258,7 +258,7 @@ The ``rte_event_eth_rx_adapter_instance_get()`` function reports
 Rx adapter instance ID for a specified ethernet device ID and Rx queue index.
 
 Interrupt Based Rx Queues
-~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The service core function is typically set up to poll ethernet Rx queues for
 packets. Certain queues may have low packet rates and it would be more
diff --git a/doc/guides/prog_guide/eventdev/event_ethernet_tx_adapter.rst b/doc/guides/prog_guide/eventdev/event_ethernet_tx_adapter.rst
index 79727c0e8a..e6a2bf937d 100644
--- a/doc/guides/prog_guide/eventdev/event_ethernet_tx_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_ethernet_tx_adapter.rst
@@ -134,7 +134,7 @@ This function calls the start callback of the eventdev PMD if supported,
 and the ``rte_service_run_state_set()`` to enable the service function if one exists.
 
 Enqueuing Packets to the Adapter
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The application needs to notify the adapter about the transmit port and queue used
 to send the packet. The transmit port is set in the ``struct rte_mbuf::port`` field
diff --git a/doc/guides/prog_guide/hash_lib.rst b/doc/guides/prog_guide/hash_lib.rst
index fdbb99fd5e..0c2276c88b 100644
--- a/doc/guides/prog_guide/hash_lib.rst
+++ b/doc/guides/prog_guide/hash_lib.rst
@@ -73,7 +73,7 @@ multi-process mode).
 
 
 Multi-thread support
----------------------
+--------------------
 
 The hash library supports multithreading, and the user specifies the needed mode of operation at the creation time of the hash table
 by appropriately setting the flag. In all modes of operation lookups are thread-safe meaning lookups can be called from multiple
@@ -106,7 +106,7 @@ For concurrent writes, and concurrent reads and writes the following flag values
 
 
 Extendable Bucket Functionality support
-----------------------------------------
+---------------------------------------
 An extra flag is used to enable this functionality (flag is not set by default). When the (RTE_HASH_EXTRA_FLAGS_EXT_TABLE) is set and
 in the very unlikely case due to excessive hash collisions that a key has failed to be inserted, the hash table bucket is extended with a linked
 list to insert these failed keys. This feature is important for the workloads (e.g. telco workloads) that need to insert up to 100% of the
@@ -178,7 +178,7 @@ readers are not referencing the position anymore. User can configure integrated
 
 
 Implementation Details (with Extendable Bucket)
--------------------------------------------------
+-----------------------------------------------
 When the RTE_HASH_EXTRA_FLAGS_EXT_TABLE flag is set, the hash table implementation still uses the same Cuckoo Hash algorithm to store the keys into
 the first and second tables. However, in the very unlikely event that a key can't be inserted after certain number of the Cuckoo displacements is
 reached, the secondary bucket of this key is extended
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index e6f24945b0..b9c0d59728 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -136,7 +136,7 @@ Utility Libraries
 
 
 Howto Guides
--------------
+------------
 
 .. toctree::
     :maxdepth: 1
diff --git a/doc/guides/prog_guide/ipsec_lib.rst b/doc/guides/prog_guide/ipsec_lib.rst
index 458a82828c..56aa88ef23 100644
--- a/doc/guides/prog_guide/ipsec_lib.rst
+++ b/doc/guides/prog_guide/ipsec_lib.rst
@@ -152,7 +152,7 @@ To accommodate future custom implementations function pointers
 model is used for both *crypto_prepare* and *process* implementations.
 
 SA database API
-----------------
+---------------
 
 SA database(SAD) is a table with <key, value> pairs.
 
@@ -322,7 +322,7 @@ Supported features
 
 
 Telemetry support
-------------------
+-----------------
 
 Telemetry support implements SA details and IPsec packet add data counters
 statistics. Per SA telemetry statistics can be enabled using
diff --git a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
index 4c1d69175e..e7edf5b7d1 100644
--- a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
+++ b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
@@ -210,7 +210,7 @@ All settings are managed through the bonding port API and always are propagated
 in one direction (from bonding to members).
 
 Link Status Change Interrupts / Polling
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Link bonding devices support the registration of a link status change callback,
 using the ``rte_eth_dev_callback_register`` API, this will be called when the
diff --git a/doc/guides/prog_guide/member_lib.rst b/doc/guides/prog_guide/member_lib.rst
index d2f76de35c..61700a51ad 100644
--- a/doc/guides/prog_guide/member_lib.rst
+++ b/doc/guides/prog_guide/member_lib.rst
@@ -379,7 +379,7 @@ implementation of vBF does not support deletion [1]_. An error code ``-EINVAL``
 .. [1] Traditional bloom filter does not support proactive deletion. Supporting proactive deletion require additional implementation and performance overhead.
 
 References
------------
+----------
 
 [Member-bloom] B H Bloom, "Space/Time Trade-offs in Hash Coding with Allowable Errors," Communications of the ACM, 1970.
 
diff --git a/doc/guides/prog_guide/mempool_lib.rst b/doc/guides/prog_guide/mempool_lib.rst
index 8b4793afff..09c70af811 100644
--- a/doc/guides/prog_guide/mempool_lib.rst
+++ b/doc/guides/prog_guide/mempool_lib.rst
@@ -117,7 +117,7 @@ In contrast to the default caches, user-owned caches can be used by unregistered
 .. _Mempool_Handlers:
 
 Mempool Handlers
-------------------------
+----------------
 
 This allows external memory subsystems, such as external hardware memory
 management systems and software based memory allocators, to be used with DPDK.
diff --git a/doc/guides/prog_guide/multi_proc_support.rst b/doc/guides/prog_guide/multi_proc_support.rst
index 8f9d42f959..edc5524e87 100644
--- a/doc/guides/prog_guide/multi_proc_support.rst
+++ b/doc/guides/prog_guide/multi_proc_support.rst
@@ -324,7 +324,7 @@ pointer. The resulting response will then be delivered to the correct requestor.
     to do so will cause the requestor to time out while waiting on a response.
 
 Misc considerations
-~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~
 
 Due to the underlying IPC implementation being single-threaded, recursive
 requests (i.e. sending a request while responding to another request) is not
diff --git a/doc/guides/prog_guide/packet_classif_access_ctrl.rst b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
index 13337dd27f..ea446ed2ab 100644
--- a/doc/guides/prog_guide/packet_classif_access_ctrl.rst
+++ b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
@@ -360,7 +360,7 @@ For example:
      }
 
 Custom Memory Hooks
-~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~
 
 The ACL library supports custom memory allocation for runtime structures.
 
diff --git a/doc/guides/prog_guide/regexdev.rst b/doc/guides/prog_guide/regexdev.rst
index 3bf3b154b4..80c34f1714 100644
--- a/doc/guides/prog_guide/regexdev.rst
+++ b/doc/guides/prog_guide/regexdev.rst
@@ -147,7 +147,7 @@ require global locks and hinder performance.
 
 
 Device Features and Capabilities
----------------------------------
+--------------------------------
 
 RegEx devices may support different feature set.
 In order to get the supported PMD feature ``rte_regexdev_info_get``
diff --git a/doc/guides/prog_guide/reorder_lib.rst b/doc/guides/prog_guide/reorder_lib.rst
index 3fb5df5570..d7bf736d42 100644
--- a/doc/guides/prog_guide/reorder_lib.rst
+++ b/doc/guides/prog_guide/reorder_lib.rst
@@ -2,13 +2,13 @@
     Copyright(c) 2015 Intel Corporation.
 
 Reorder Library
-=================
+===============
 
 The Reorder Library provides a mechanism for reordering mbufs based on their
 sequence number.
 
 Operation
-----------
+---------
 
 The reorder library is essentially a buffer that reorders mbufs.
 The user inserts out of order mbufs into the reorder buffer and pulls in-order
@@ -34,7 +34,7 @@ mbufs.
 
 
 Implementation Details
--------------------------
+----------------------
 
 The reorder library is implemented as a pair of buffers, which referred to as
 the *Order* buffer and the *Ready* buffer.
@@ -67,7 +67,7 @@ buffer first and then from the Order buffer until a gap is found (mbufs that
 have not arrived yet).
 
 Use Case: Packet Distributor
--------------------------------
+----------------------------
 
 An application using the DPDK packet distributor could make use of the reorder
 library to transmit packets in the same order they were received.
diff --git a/doc/guides/prog_guide/rte_security.rst b/doc/guides/prog_guide/rte_security.rst
index 5cfa39a71d..7bd9691080 100644
--- a/doc/guides/prog_guide/rte_security.rst
+++ b/doc/guides/prog_guide/rte_security.rst
@@ -475,7 +475,7 @@ Supported Versions
 * DTLS 1.2
 
 Device Features and Capabilities
----------------------------------
+--------------------------------
 
 Device Capabilities For Security Operations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/prog_guide/stack_lib.rst b/doc/guides/prog_guide/stack_lib.rst
index 975d3ad796..45e0b29e3a 100644
--- a/doc/guides/prog_guide/stack_lib.rst
+++ b/doc/guides/prog_guide/stack_lib.rst
@@ -40,7 +40,7 @@ spinlock.
 .. _Stack_Library_LF_Stack:
 
 Lock-free Stack
-------------------
+---------------
 
 The lock-free stack consists of a linked list of elements, each containing a
 data pointer and a next pointer, and an atomic stack depth counter. The
diff --git a/doc/guides/prog_guide/toeplitz_hash_lib.rst b/doc/guides/prog_guide/toeplitz_hash_lib.rst
index 61eaafd169..5ebe958f2f 100644
--- a/doc/guides/prog_guide/toeplitz_hash_lib.rst
+++ b/doc/guides/prog_guide/toeplitz_hash_lib.rst
@@ -186,7 +186,7 @@ same as in ``desired_hash``.
 
 
 Adjust tuple API
-~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~
 
 The ``rte_thash_get_complement()`` function is a user-friendly wrapper around
 a number of other functions. It alters a passed tuple to meet the above
diff --git a/doc/guides/rawdevs/ifpga.rst b/doc/guides/rawdevs/ifpga.rst
index c0901ddeae..f26f447999 100644
--- a/doc/guides/rawdevs/ifpga.rst
+++ b/doc/guides/rawdevs/ifpga.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2018-2022 Intel Corporation.
 
 IFPGA Rawdev Driver
-======================
+===================
 
 FPGA is used more and more widely in Cloud and NFV, one primary reason is
 that FPGA not only provides ASIC performance but also it's more flexible
@@ -203,7 +203,7 @@ Each AFU device has specific configuration data, they are defined in ``rte_pmd_a
 
 
 Open FPGA Stack
-=====================
+===============
 
 Open FPGA Stack (OFS) is a collection of RTL and open source software providing
 interfaces to access the instantiated RTL easily in an FPGA. OFS leverages the
diff --git a/doc/guides/regexdevs/cn9k.rst b/doc/guides/regexdevs/cn9k.rst
index c23c295b93..0c58c095f4 100644
--- a/doc/guides/regexdevs/cn9k.rst
+++ b/doc/guides/regexdevs/cn9k.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2020 Marvell International Ltd.
 
 CN9K REE Regexdev Driver
-==============================
+========================
 
 The CN9K REE PMD (**librte_regex_cn9k**) provides poll mode
 regexdev driver support for the inbuilt regex device found in the **Marvell CN9K**
diff --git a/doc/guides/sample_app_ug/dma.rst b/doc/guides/sample_app_ug/dma.rst
index 9605996c6c..7d177fd44d 100644
--- a/doc/guides/sample_app_ug/dma.rst
+++ b/doc/guides/sample_app_ug/dma.rst
@@ -304,7 +304,7 @@ if it was enabled. After that, copies are sent in burst mode using ``rte_eth_tx_
     :dedent: 0
 
 The Packet Copying Functions
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In order to perform SW packet copy, there are user-defined functions to the first copy
 the packet metadata (``pktmbuf_metadata_copy()``) and then the packet data
diff --git a/doc/guides/sample_app_ug/flow_filtering.rst b/doc/guides/sample_app_ug/flow_filtering.rst
index 179e978942..b3a23c0c33 100644
--- a/doc/guides/sample_app_ug/flow_filtering.rst
+++ b/doc/guides/sample_app_ug/flow_filtering.rst
@@ -172,7 +172,7 @@ This action closes the port and device using ``rte_eth_dev_stop`` and ``rte_eth_
 
 
 Flow API Snippets
-------------------
+-----------------
 
 The ``snippets`` directory offers additional customization options through code snippets.
 These snippets cover various aspects of flow configuration, allowing developers to reuse them.
diff --git a/doc/guides/sample_app_ug/ip_reassembly.rst b/doc/guides/sample_app_ug/ip_reassembly.rst
index 04b581a489..5a71644e38 100644
--- a/doc/guides/sample_app_ug/ip_reassembly.rst
+++ b/doc/guides/sample_app_ug/ip_reassembly.rst
@@ -156,7 +156,7 @@ each Rx queue uses its own mempool.
     :dedent: 1
 
 Packet Reassembly and Forwarding
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 For each input packet, the packet forwarding operation is done by the l3fwd_simple_forward() function.
 If the packet is an IPv4 or IPv6 fragment, then it calls ``rte_ipv4_reassemble_packet()`` for IPv4 packets,
diff --git a/doc/guides/sample_app_ug/packet_ordering.rst b/doc/guides/sample_app_ug/packet_ordering.rst
index f96c0ad697..8b6f6be940 100644
--- a/doc/guides/sample_app_ug/packet_ordering.rst
+++ b/doc/guides/sample_app_ug/packet_ordering.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2015 Intel Corporation.
 
 Packet Ordering Application
-============================
+===========================
 
 The Packet Ordering sample app simply shows the impact of reordering a stream.
 It's meant to stress the library with different configurations for performance.
diff --git a/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst b/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
index 466879cd46..e4c0aa04ed 100644
--- a/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
+++ b/doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
@@ -96,7 +96,7 @@ Prerequisites
 * A PTP time transmitter reachable on the same L2 network.
 
 Start the relay
-~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~
 
 .. code-block:: console
 
diff --git a/doc/guides/sample_app_ug/vhost_blk.rst b/doc/guides/sample_app_ug/vhost_blk.rst
index 788eef0d5f..f33b3b6eaf 100644
--- a/doc/guides/sample_app_ug/vhost_blk.rst
+++ b/doc/guides/sample_app_ug/vhost_blk.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2010-2017 Intel Corporation.
 
 Vhost_blk Sample Application
-=============================
+============================
 
 The vhost_blk sample application implemented a simple block device,
 which used as the  backend of Qemu vhost-user-blk device. Users can extend
@@ -32,7 +32,7 @@ The application is located in the ``examples`` sub-directory.
 You will also need to build DPDK both on the host and inside the guest
 
 Start the vhost_blk example
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. code-block:: console
 
diff --git a/doc/guides/sample_app_ug/vmdq_forwarding.rst b/doc/guides/sample_app_ug/vmdq_forwarding.rst
index c998a5a223..30a3ad42ce 100644
--- a/doc/guides/sample_app_ug/vmdq_forwarding.rst
+++ b/doc/guides/sample_app_ug/vmdq_forwarding.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2020 Intel Corporation.
 
 VMDq Forwarding Sample Application
-==========================================
+==================================
 
 The VMDq Forwarding sample application is a simple example of packet processing using the DPDK.
 The application performs L2 forwarding using VMDq to divide the incoming traffic into queues.
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 364d348372..cbaa616a52 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1866,7 +1866,7 @@ To have a different decapsulation header, one of those commands must be called
 before the flow rule creation.
 
 Config Raw Encapsulation
-~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~
 
 Configure the raw data to be used when encapsulating a packet by
 rte_flow_action_raw_encap::
@@ -2158,7 +2158,7 @@ Switch on/off deferred start of a specific port queue::
    testpmd> port (port_id) (rxq|txq) (queue_id) deferred_start (on|off)
 
 port setup queue
-~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~
 
 Setup a rx/tx queue on a specific port::
 
@@ -2952,7 +2952,7 @@ Suspend port traffic management hierarchy node
    testpmd> suspend port tm node (port_id) (node_id)
 
 Resume port traffic management hierarchy node
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
    testpmd> resume port tm node (port_id) (node_id)
 
@@ -4961,7 +4961,7 @@ Query indirect action having id 100::
    testpmd> flow indirect_action 0 query 100
 
 Enqueueing query of indirect actions
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 ``flow queue indirect_action query`` adds query operation for an indirect
 action to a queue. It is bound to ``rte_flow_async_action_handle_query()``::
@@ -5359,7 +5359,7 @@ ESP rules can be created by the following commands::
         actions queue index 3 / end
 
 Sample AH rules
-~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~
 
 AH rules can be created by the following commands::
 
@@ -5567,7 +5567,7 @@ Match with comparison rule can be created as following using ``compare``.
 	     actions count / drop / end
 
 BPF Functions
---------------
+-------------
 
 The following sections show functions to load/unload eBPF based filters.
 
diff --git a/doc/guides/tools/testbbdev.rst b/doc/guides/tools/testbbdev.rst
index 8677cd2c43..58de4a2fbe 100644
--- a/doc/guides/tools/testbbdev.rst
+++ b/doc/guides/tools/testbbdev.rst
@@ -571,7 +571,7 @@ Following statuses can be used:
     OK
 
 LDPC decoder test vectors template
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 For LDPC decoder it has to be always set to ``RTE_BBDEV_OP_LDPC_DEC``
 
@@ -695,7 +695,7 @@ Following statuses can be used:
 
 
 LDPC encoder test vectors template
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 For turbo encoder it has to be always set to ``RTE_BBDEV_OP_LDPC_ENC``
 
diff --git a/doc/guides/tools/testeventdev.rst b/doc/guides/tools/testeventdev.rst
index cd367eb2a2..f4687ecf6b 100644
--- a/doc/guides/tools/testeventdev.rst
+++ b/doc/guides/tools/testeventdev.rst
@@ -691,7 +691,7 @@ Example command to run perf queue test with event DMA adapter:
                --prod_type_dmadev --dma_adptr_mode=1
 
 PERF_ATQ Test
-~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~
 
 This is a performance test case that aims at testing the following with
 ``all types queue`` eventdev scheme.
@@ -922,7 +922,7 @@ Example command to run pipeline atq test with vector events:
         --enable_vector  --vector_size 512
 
 PIPELINE_ATQ Test
-~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~
 
 This is a pipeline test case that aims at testing the following with
 ``all types queue`` eventdev scheme.
-- 
2.54.0

