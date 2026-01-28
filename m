Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EB4D3F091
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 16:22:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54ACE402AF;
	Wed, 28 Jan 2026 17:22:29 +0100 (CET)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 4D72C4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:22:28 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id B58E6EC01A3;
 Wed, 28 Jan 2026 11:22:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 28 Jan 2026 11:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1769617347; x=
 1769703747; bh=aagNFknvFLtb2ou6Gt6wrgbBwgF27FmRcHqbl+j47VY=; b=k
 oaiQBHTZCY2+ebvv/VirXW+pAPmpF9OMNnPPRjnsZ2G6wW1GrlkAbQT6SoQa21On
 e/AHv3vW0y5Hp1c3KAqJ1urH8hmzGOIuXPmRTv1Khy6bx84O+RvOOeZGBONdElab
 BQQpCnMYa/ASB3iCf10lHRZ1gKgcJfic9Zm6XRWhovCHX0iMRNm7MrjheKz0KnmG
 D9gGgabl+PF7CZh+b+zEYe0Sw6xxWMg/X68hQzw2Bfg4cFGqq705FlkL9XIxhSIu
 BWA9mOnCGWJzoBQLuFA5zS/llLKIRD4wqycy87diswS8JjGRxrmHKDvh4XDUfUE9
 bL/APiMFRAjmsuPXGMWZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769617347; x=1769703747; bh=a
 agNFknvFLtb2ou6Gt6wrgbBwgF27FmRcHqbl+j47VY=; b=XumfTNUdBtKBGKiYA
 HDCjBqMcR52/7fQPSPzXy60dy/abK3ApVNbnPLcQzfdPvI7VG0w8rQ2q07Cbr9sg
 +SQF59UDRE0qkGFC9rYEH7+gFduCv8SpbA5pEhIxhcKWPyDEfRG5W1e817Ap6irn
 cDoAGyJin+i55zoRtZjeZGELx67SceFPyUvoND+IC48+Kh6ih8S+UjzbKQplgdrO
 gkv1GICVKWQqEW1s56sHutnAbCTeH9kPZwvW45RXQpBWKIYOSZzIyYQCEp/KVEN4
 TldNRDWsAmZ39UT5CdFUSW9rEM6a8UwVtu4pADXVrxt2rnN4iPHzKr3lx501yeh9
 C1tyg==
X-ME-Sender: <xms:wjd6aUWeh_q3mnKIOYlShpGHnsC4WfMJzxULIt6ukAgJg4DzHagleQ>
 <xme:wjd6aeLAP_W5go0RzOZGp4xUKc9NfD7lElYdz840LW29tl2cdqylyzmi9DQsE-Ax9
 vtQLPv7WEJZ9-UJ9toYFEP8j-rPzI2CsfLwCTGQ5ztmRygi5YvU>
X-ME-Received: <xmr:wjd6aR-0GZR5N1W_meTBgCLx1sTLh-yLhUIbvJYVphrT8_ntKnOUoJlbtOLSPpJ8GP0T9KEsyFENWiKXE5B2MUqEGsiqarA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefjeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpefhveeutedvteelueejgfeiudeutdeljeeiieelfeektdelgeeiieet
 vdffgeetgfenucffohhmrghinhepshhpugigrdguvghvpdhmrghilhhmrghprdgtihenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgr
 shesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmh
 htphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohephhgv
 mhgrnhhtrdgrghhrrgifrghlsehngihprdgtohhmpdhrtghpthhtohepshgrtghhihhnrd
 hsrgigvghnrgesnhigphdrtghomhdprhgtphhtthhopehkrghirdhjihesihhnthgvlhdr
 tghomhdprhgtphhtthhopehgrdhsihhnghhhsehngihprdgtohhmpdhrtghpthhtohepih
 hruhhsshhkihhkhhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehsthgvvhgvnhdr
 figvsghsthgvrhesfihinhgurhhivhgvrhdrtghomhdprhgtphhtthhopehmrghtthdrph
 gvthgvrhhsseifihhnughrihhvvghrrdgtohhmpdhrtghpthhtohepkhhishhhohhrvgdr
 phgrughmrghnrggshhgrsegsrhhorggutghomhdrtghomh
X-ME-Proxy: <xmx:wjd6aUPJ3_TYbDUZP0y5MedzIMEL5Sq-m1xEJ2im-iB16UsWsHNcmg>
 <xmx:wjd6aV3_2ms-Uz3g2kNlu8IEadgAlZPG-0gh-Rj2FUmlB6QA4f8Ugw>
 <xmx:wjd6aVeUzo7e6qSU5KmKtKT0nmCmorCeZlkA_E6mGWlYDy3sANIWLA>
 <xmx:wjd6aeaQbml7Semq_oXGJ7ShCeWc0JiYhJGzWQ4kDJjmfw6TYL6O8w>
 <xmx:wzd6ae72Bv9ikWAk3C-wAB_0HLBt7Q9WRvgPIKVvhv-6oOII4sRQWa4d>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 11:22:24 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Kai Ji <kai.ji@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Igor Russkikh <irusskikh@marvell.com>,
 Steven Webster <steven.webster@windriver.com>,
 Matt Peters <matt.peters@windriver.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v2] license: standardize SPDX tag
Date: Wed, 28 Jan 2026 17:20:52 +0100
Message-ID: <20260128162219.2929316-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251112091335.662991-1-thomas@monjalon.net>
References: <20251112091335.662991-1-thomas@monjalon.net>
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

In the Linux Foundation SPDX recommendation,
there is no need of parentheses when 2 licenses are possible:
	https://spdx.dev/learn/handling-license-info/

The useless parentheses and spaces are removed,
the keyword "OR" is uppercased, and the comment starts with /*

The script check-spdx-tag.sh is updated to detect some syntax errors.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
v2: update the script and README, and remove useless parentheses
---
 devtools/check-spdx-tag.sh                    | 33 +++++++++++++++++--
 doc/guides/contributing/patches.rst           |  2 +-
 doc/guides/eventdevs/dpaa.rst                 |  2 +-
 drivers/bus/dpaa/base/fman/fman.c             |  2 +-
 drivers/bus/dpaa/base/fman/netcfg_layer.c     |  2 +-
 drivers/bus/dpaa/base/qbman/bman.c            |  2 +-
 drivers/bus/dpaa/base/qbman/bman.h            |  2 +-
 drivers/bus/dpaa/base/qbman/bman_driver.c     |  2 +-
 drivers/bus/dpaa/base/qbman/bman_priv.h       |  2 +-
 drivers/bus/dpaa/base/qbman/dpaa_alloc.c      |  2 +-
 drivers/bus/dpaa/base/qbman/dpaa_sys.c        |  2 +-
 drivers/bus/dpaa/base/qbman/dpaa_sys.h        |  2 +-
 drivers/bus/dpaa/base/qbman/process.c         |  2 +-
 drivers/bus/dpaa/base/qbman/qman.c            |  2 +-
 drivers/bus/dpaa/base/qbman/qman.h            |  2 +-
 drivers/bus/dpaa/base/qbman/qman_driver.c     |  2 +-
 drivers/bus/dpaa/base/qbman/qman_priv.h       |  2 +-
 drivers/bus/dpaa/include/fman.h               |  2 +-
 drivers/bus/dpaa/include/fsl_bman.h           |  2 +-
 drivers/bus/dpaa/include/fsl_fman.h           |  2 +-
 drivers/bus/dpaa/include/fsl_fman_crc64.h     |  2 +-
 drivers/bus/dpaa/include/fsl_qman.h           |  2 +-
 drivers/bus/dpaa/include/fsl_usd.h            |  2 +-
 drivers/bus/dpaa/include/netcfg.h             |  2 +-
 drivers/bus/dpaa/include/process.h            |  2 +-
 drivers/bus/fslmc/mc/dpbp.c                   |  2 +-
 drivers/bus/fslmc/mc/dpci.c                   |  2 +-
 drivers/bus/fslmc/mc/dpcon.c                  |  2 +-
 drivers/bus/fslmc/mc/dpio.c                   |  2 +-
 drivers/bus/fslmc/mc/dpmng.c                  |  2 +-
 drivers/bus/fslmc/mc/dprc.c                   |  2 +-
 drivers/bus/fslmc/mc/fsl_dpbp.h               |  2 +-
 drivers/bus/fslmc/mc/fsl_dpbp_cmd.h           |  2 +-
 drivers/bus/fslmc/mc/fsl_dpci.h               |  2 +-
 drivers/bus/fslmc/mc/fsl_dpci_cmd.h           |  2 +-
 drivers/bus/fslmc/mc/fsl_dpcon.h              |  2 +-
 drivers/bus/fslmc/mc/fsl_dpcon_cmd.h          |  2 +-
 drivers/bus/fslmc/mc/fsl_dpio.h               |  2 +-
 drivers/bus/fslmc/mc/fsl_dpio_cmd.h           |  2 +-
 drivers/bus/fslmc/mc/fsl_dpmng.h              |  2 +-
 drivers/bus/fslmc/mc/fsl_dpmng_cmd.h          |  2 +-
 drivers/bus/fslmc/mc/fsl_dpopr.h              |  2 +-
 drivers/bus/fslmc/mc/fsl_dprc.h               |  2 +-
 drivers/bus/fslmc/mc/fsl_dprc_cmd.h           |  2 +-
 drivers/bus/fslmc/mc/fsl_mc_cmd.h             |  2 +-
 drivers/bus/fslmc/mc/fsl_mc_sys.h             |  2 +-
 drivers/bus/fslmc/mc/mc_sys.c                 |  2 +-
 drivers/common/dpaax/caamflib.c               |  2 +-
 drivers/common/dpaax/caamflib/compat.h        |  2 +-
 drivers/common/dpaax/caamflib/desc.h          |  2 +-
 drivers/common/dpaax/caamflib/desc/algo.h     |  2 +-
 drivers/common/dpaax/caamflib/desc/common.h   |  2 +-
 drivers/common/dpaax/caamflib/desc/ipsec.h    |  2 +-
 drivers/common/dpaax/caamflib/desc/pdcp.h     |  2 +-
 drivers/common/dpaax/caamflib/rta.h           |  2 +-
 .../dpaax/caamflib/rta/fifo_load_store_cmd.h  |  2 +-
 .../common/dpaax/caamflib/rta/header_cmd.h    |  2 +-
 drivers/common/dpaax/caamflib/rta/jump_cmd.h  |  2 +-
 drivers/common/dpaax/caamflib/rta/key_cmd.h   |  2 +-
 drivers/common/dpaax/caamflib/rta/load_cmd.h  |  2 +-
 drivers/common/dpaax/caamflib/rta/math_cmd.h  |  2 +-
 drivers/common/dpaax/caamflib/rta/move_cmd.h  |  2 +-
 drivers/common/dpaax/caamflib/rta/nfifo_cmd.h |  2 +-
 .../common/dpaax/caamflib/rta/operation_cmd.h |  2 +-
 .../common/dpaax/caamflib/rta/protocol_cmd.h  |  2 +-
 .../dpaax/caamflib/rta/sec_run_time_asm.h     |  2 +-
 .../dpaax/caamflib/rta/seq_in_out_ptr_cmd.h   |  2 +-
 .../common/dpaax/caamflib/rta/signature_cmd.h |  2 +-
 drivers/common/dpaax/caamflib/rta/store_cmd.h |  2 +-
 drivers/common/dpaax/compat.h                 |  2 +-
 drivers/common/dpaax/dpaa_of.c                |  2 +-
 drivers/common/dpaax/dpaa_of.h                |  2 +-
 drivers/common/qat/qat_adf/adf_pf2vf_msg.h    |  2 +-
 .../qat/qat_adf/adf_transport_access_macros.h |  2 +-
 .../adf_transport_access_macros_gen4.h        |  2 +-
 .../adf_transport_access_macros_gen4vf.h      |  2 +-
 .../adf_transport_access_macros_gen_lce.h     |  2 +-
 .../adf_transport_access_macros_gen_lcevf.h   |  2 +-
 drivers/common/qat/qat_adf/icp_qat_fw.h       |  2 +-
 drivers/common/qat/qat_adf/icp_qat_fw_comp.h  |  2 +-
 drivers/common/qat/qat_adf/icp_qat_fw_la.h    |  2 +-
 drivers/common/qat/qat_adf/icp_qat_hw.h       |  2 +-
 .../common/qat/qat_adf/icp_qat_hw_gen4_comp.h |  2 +-
 .../qat/qat_adf/icp_qat_hw_gen4_comp_defs.h   |  2 +-
 drivers/crypto/dpaa2_sec/mc/dpseci.c          |  2 +-
 drivers/crypto/dpaa2_sec/mc/fsl_dpseci.h      |  2 +-
 drivers/crypto/dpaa2_sec/mc/fsl_dpseci_cmd.h  |  2 +-
 drivers/crypto/qat/qat_sym_session.c          |  2 +-
 drivers/event/dpaa/dpaa_eventdev.c            |  2 +-
 drivers/event/dpaa/dpaa_eventdev.h            |  2 +-
 drivers/net/atlantic/atl_hw_regs.c            |  5 +--
 drivers/net/atlantic/atl_hw_regs.h            |  5 +--
 drivers/net/atlantic/hw_atl/hw_atl_b0.c       |  5 +--
 drivers/net/atlantic/hw_atl/hw_atl_b0.h       |  5 +--
 .../net/atlantic/hw_atl/hw_atl_b0_internal.h  |  5 +--
 drivers/net/atlantic/hw_atl/hw_atl_llh.c      |  5 +--
 drivers/net/atlantic/hw_atl/hw_atl_llh.h      |  5 +--
 .../net/atlantic/hw_atl/hw_atl_llh_internal.h |  5 +--
 drivers/net/atlantic/hw_atl/hw_atl_utils.c    |  5 +--
 drivers/net/atlantic/hw_atl/hw_atl_utils.h    |  5 +--
 .../net/atlantic/hw_atl/hw_atl_utils_fw2x.c   |  5 +--
 drivers/net/avp/rte_avp_common.h              |  2 +-
 drivers/net/avp/rte_avp_fifo.h                |  2 +-
 drivers/net/bnxt/bnxt_nvm_defs.h              |  2 +-
 drivers/net/dpaa/fmlib/dpaa_integration.h     |  2 +-
 drivers/net/dpaa/fmlib/ncsw_ext.h             |  2 +-
 drivers/net/dpaa/fmlib/net_ext.h              |  2 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |  8 ++---
 drivers/net/dpaa2/dpaa2_recycle.c             |  6 ++--
 drivers/net/dpaa2/dpaa2_sparser.h             |  4 +--
 drivers/net/dpaa2/mc/dpdmux.c                 |  2 +-
 drivers/net/dpaa2/mc/dpkg.c                   |  2 +-
 drivers/net/dpaa2/mc/dpni.c                   |  2 +-
 drivers/net/dpaa2/mc/dprtc.c                  |  2 +-
 drivers/net/dpaa2/mc/fsl_dpdmux.h             |  2 +-
 drivers/net/dpaa2/mc/fsl_dpdmux_cmd.h         |  2 +-
 drivers/net/dpaa2/mc/fsl_dpkg.h               |  2 +-
 drivers/net/dpaa2/mc/fsl_dpmac.h              |  2 +-
 drivers/net/dpaa2/mc/fsl_dpni.h               |  2 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h           |  2 +-
 drivers/net/dpaa2/mc/fsl_dprtc.h              |  2 +-
 drivers/net/dpaa2/mc/fsl_dprtc_cmd.h          |  2 +-
 drivers/net/dpaa2/mc/fsl_net.h                |  2 +-
 drivers/net/mlx5/mlx5_flow_meter.c            |  3 +-
 kernel/linux/uapi/linux/vduse.h               |  3 +-
 lib/eal/include/rte_pci_dev_feature_defs.h    |  2 +-
 lib/eal/include/rte_pci_dev_features.h        |  2 +-
 license/README                                |  4 +--
 128 files changed, 185 insertions(+), 151 deletions(-)

diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
index 984825026e..2390941c74 100755
--- a/devtools/check-spdx-tag.sh
+++ b/devtools/check-spdx-tag.sh
@@ -19,17 +19,41 @@ no_license_list=\
 ':^.git* :^.mailmap :^.ci/* :^README :^*/README* :^MAINTAINERS :^VERSION :^ABI_VERSION '\
 ':^license/ :^config/ :^buildtools/ :^*.abignore :^*.cocci :^*/poetry.lock '\
 ':^*/Kbuild :^kernel/linux/uapi/version '\
-':^*.ini :^*.data :^*.json :^*.cfg :^*.txt :^*.svg :^*.png'
+':^*.ini :^*.data :^*.json :^*.cfg :^*.txt :^*.md :^*.svg :^*.png'
 
 check_spdx() {
     if $verbose ; then
 	echo "Files without SPDX License"
 	echo "--------------------------"
     fi
+
     git grep -L SPDX-License-Identifier -- $no_license_list > $tmpfile
 
     missing_spdx=$(wc -l < $tmpfile)
     $quiet || cat $tmpfile
+
+    if $verbose ; then
+	echo
+	echo "Files with wrong SPDX format"
+	echo "----------------------------"
+    fi
+
+    files_without_spdx=$(cat $tmpfile)
+    git grep -LE '(/\*|#|;|\.\.) *SPDX-License-Identifier: [A-Z(]' -- $no_license_list > $tmpfile
+    for file in $files_without_spdx ; do
+	sed -i "/^$file$/d" $tmpfile
+    done
+
+    warnings=$(($warnings + $(wc -l < $tmpfile)))
+    $quiet || cat $tmpfile
+
+    files_with_andor=$(git grep -lEi 'SPDX-License-Identifier:.*\<(AND|OR)\>' -- $no_license_list)
+    for file in $files_with_andor ; do
+	grep -LE 'SPDX-License-Identifier:.*\<(AND|OR)\>' "$file"
+    done > $tmpfile
+
+    warnings=$(($warnings + $(wc -l < $tmpfile)))
+    $quiet || cat $tmpfile
 }
 
 build_exceptions_list() {
@@ -46,6 +70,7 @@ check_licenses() {
 	echo "Files with wrong license and no exception"
 	echo "-----------------------------------------"
     fi
+
     exceptions=$(build_exceptions_list)
     git grep -l SPDX-License-Identifier: -- $no_license_list $exceptions |
     xargs grep -L -E 'SPDX-License-Identifier:[[:space:]]*(\(?|.* OR )BSD-3-Clause' > $tmpfile
@@ -63,7 +88,7 @@ check_boilerplate() {
     git grep -l Redistribution -- \
 	':^license/' ':^/devtools/check-spdx-tag.sh' > $tmpfile
 
-    warnings=$(wc -l <$tmpfile)
+    warnings=$(($warnings + $(wc -l <$tmpfile)))
     $quiet || cat $tmpfile
 }
 
@@ -89,5 +114,7 @@ $verbose && echo
 check_boilerplate
 $verbose && echo
 
-echo "total: $missing_spdx missing SPDX, $wrong_license license errors, $warnings warnings"
+if [ $missing_spdx -gt 0 -o $wrong_license -gt 0 -o $warnings -gt 0 ] || ! $quiet ; then
+    echo "total: $missing_spdx missing SPDX, $wrong_license license errors, $warnings warnings"
+fi
 exit $((missing_spdx + wrong_license))
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index 069a18e4ec..5f554d47e6 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -56,7 +56,7 @@ To label a file as dual-licensed with BSD-3-Clause and GPL-2.0 (e.g., for code
 that is shared between the kernel and userspace), the following text would be
 used:
 
-``SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)``
+``SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0``
 
 Refer to ``licenses/README`` for more details.
 
diff --git a/doc/guides/eventdevs/dpaa.rst b/doc/guides/eventdevs/dpaa.rst
index 33d41fc7c4..8fb1d469dd 100644
--- a/doc/guides/eventdevs/dpaa.rst
+++ b/doc/guides/eventdevs/dpaa.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier:        BSD-3-Clause
+.. SPDX-License-Identifier: BSD-3-Clause
    Copyright 2017 NXP
 
 NXP DPAA Eventdev Driver
diff --git a/drivers/bus/dpaa/base/fman/fman.c b/drivers/bus/dpaa/base/fman/fman.c
index fb30ab96b5..55311235f5 100644
--- a/drivers/bus/dpaa/base/fman/fman.c
+++ b/drivers/bus/dpaa/base/fman/fman.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2010-2016 Freescale Semiconductor Inc.
  * Copyright 2017-2024 NXP
diff --git a/drivers/bus/dpaa/base/fman/netcfg_layer.c b/drivers/bus/dpaa/base/fman/netcfg_layer.c
index 4cc9cb815c..e4afa28131 100644
--- a/drivers/bus/dpaa/base/fman/netcfg_layer.c
+++ b/drivers/bus/dpaa/base/fman/netcfg_layer.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2010-2016 Freescale Semiconductor Inc.
  * Copyright 2017-2019,2023 NXP
diff --git a/drivers/bus/dpaa/base/qbman/bman.c b/drivers/bus/dpaa/base/qbman/bman.c
index 6b8dbb8544..ee4232d0a0 100644
--- a/drivers/bus/dpaa/base/qbman/bman.c
+++ b/drivers/bus/dpaa/base/qbman/bman.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2017, 2024 NXP
diff --git a/drivers/bus/dpaa/base/qbman/bman.h b/drivers/bus/dpaa/base/qbman/bman.h
index b2aa93e046..d81902113e 100644
--- a/drivers/bus/dpaa/base/qbman/bman.h
+++ b/drivers/bus/dpaa/base/qbman/bman.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2010-2016 Freescale Semiconductor Inc.
  * Copyright 2017 NXP
diff --git a/drivers/bus/dpaa/base/qbman/bman_driver.c b/drivers/bus/dpaa/base/qbman/bman_driver.c
index ee35e03da1..23e44ac10b 100644
--- a/drivers/bus/dpaa/base/qbman/bman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/bman_driver.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2017 NXP
diff --git a/drivers/bus/dpaa/base/qbman/bman_priv.h b/drivers/bus/dpaa/base/qbman/bman_priv.h
index 5a3e330d9f..a2687824f6 100644
--- a/drivers/bus/dpaa/base/qbman/bman_priv.h
+++ b/drivers/bus/dpaa/base/qbman/bman_priv.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2017 NXP
diff --git a/drivers/bus/dpaa/base/qbman/dpaa_alloc.c b/drivers/bus/dpaa/base/qbman/dpaa_alloc.c
index a05803c230..d3437bab0b 100644
--- a/drivers/bus/dpaa/base/qbman/dpaa_alloc.c
+++ b/drivers/bus/dpaa/base/qbman/dpaa_alloc.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2009-2016 Freescale Semiconductor Inc.
  * Copyright 2017 NXP
diff --git a/drivers/bus/dpaa/base/qbman/dpaa_sys.c b/drivers/bus/dpaa/base/qbman/dpaa_sys.c
index 9d6bfd40a2..8348792677 100644
--- a/drivers/bus/dpaa/base/qbman/dpaa_sys.c
+++ b/drivers/bus/dpaa/base/qbman/dpaa_sys.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2017 NXP
diff --git a/drivers/bus/dpaa/base/qbman/dpaa_sys.h b/drivers/bus/dpaa/base/qbman/dpaa_sys.h
index 9377738dfa..81e21f8c78 100644
--- a/drivers/bus/dpaa/base/qbman/dpaa_sys.h
+++ b/drivers/bus/dpaa/base/qbman/dpaa_sys.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2017 NXP
diff --git a/drivers/bus/dpaa/base/qbman/process.c b/drivers/bus/dpaa/base/qbman/process.c
index 2d805c5bd9..9f7417f8ce 100644
--- a/drivers/bus/dpaa/base/qbman/process.c
+++ b/drivers/bus/dpaa/base/qbman/process.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2011-2016 Freescale Semiconductor Inc.
  * Copyright 2017,2020,2022,2024 NXP
diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 76a1d93032..5534e1846c 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2017,2019-2025 NXP
diff --git a/drivers/bus/dpaa/base/qbman/qman.h b/drivers/bus/dpaa/base/qbman/qman.h
index 4346d86537..43a16d1e3b 100644
--- a/drivers/bus/dpaa/base/qbman/qman.h
+++ b/drivers/bus/dpaa/base/qbman/qman.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2017 NXP
diff --git a/drivers/bus/dpaa/base/qbman/qman_driver.c b/drivers/bus/dpaa/base/qbman/qman_driver.c
index dc84260731..3bab8b8337 100644
--- a/drivers/bus/dpaa/base/qbman/qman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/qman_driver.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2017-2022, 2025 NXP
diff --git a/drivers/bus/dpaa/base/qbman/qman_priv.h b/drivers/bus/dpaa/base/qbman/qman_priv.h
index 8254729e66..c148414635 100644
--- a/drivers/bus/dpaa/base/qbman/qman_priv.h
+++ b/drivers/bus/dpaa/base/qbman/qman_priv.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2017,2019 NXP
diff --git a/drivers/bus/dpaa/include/fman.h b/drivers/bus/dpaa/include/fman.h
index 4d4a7c1756..c33fe81516 100644
--- a/drivers/bus/dpaa/include/fman.h
+++ b/drivers/bus/dpaa/include/fman.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2010-2012 Freescale Semiconductor, Inc.
  * All rights reserved.
diff --git a/drivers/bus/dpaa/include/fsl_bman.h b/drivers/bus/dpaa/include/fsl_bman.h
index 0107ced8c5..2d24b89889 100644
--- a/drivers/bus/dpaa/include/fsl_bman.h
+++ b/drivers/bus/dpaa/include/fsl_bman.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2012 Freescale Semiconductor, Inc.
  * Copyright 2024 NXP
diff --git a/drivers/bus/dpaa/include/fsl_fman.h b/drivers/bus/dpaa/include/fsl_fman.h
index 7acdcfc7f0..0af2fb259e 100644
--- a/drivers/bus/dpaa/include/fsl_fman.h
+++ b/drivers/bus/dpaa/include/fsl_fman.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2017 NXP
  *
diff --git a/drivers/bus/dpaa/include/fsl_fman_crc64.h b/drivers/bus/dpaa/include/fsl_fman_crc64.h
index 08ad630421..83f5419902 100644
--- a/drivers/bus/dpaa/include/fsl_fman_crc64.h
+++ b/drivers/bus/dpaa/include/fsl_fman_crc64.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2011 Freescale Semiconductor, Inc.
  *
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 0494ad709d..82269cdf99 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2012 Freescale Semiconductor, Inc.
  * Copyright 2019-2022 NXP
diff --git a/drivers/bus/dpaa/include/fsl_usd.h b/drivers/bus/dpaa/include/fsl_usd.h
index 5bf13c0b46..183ddac8aa 100644
--- a/drivers/bus/dpaa/include/fsl_usd.h
+++ b/drivers/bus/dpaa/include/fsl_usd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  * All rights reserved.
diff --git a/drivers/bus/dpaa/include/netcfg.h b/drivers/bus/dpaa/include/netcfg.h
index 4a902670fc..a7d4f54b17 100644
--- a/drivers/bus/dpaa/include/netcfg.h
+++ b/drivers/bus/dpaa/include/netcfg.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2010-2012 Freescale Semiconductor, Inc.
  * All rights reserved.
diff --git a/drivers/bus/dpaa/include/process.h b/drivers/bus/dpaa/include/process.h
index 610664672c..795604b23e 100644
--- a/drivers/bus/dpaa/include/process.h
+++ b/drivers/bus/dpaa/include/process.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  * All rights reserved.
diff --git a/drivers/bus/fslmc/mc/dpbp.c b/drivers/bus/fslmc/mc/dpbp.c
index 5529a1fe9c..1c4bed3af7 100644
--- a/drivers/bus/fslmc/mc/dpbp.c
+++ b/drivers/bus/fslmc/mc/dpbp.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2017, 2025 NXP
diff --git a/drivers/bus/fslmc/mc/dpci.c b/drivers/bus/fslmc/mc/dpci.c
index 9df3827f92..4188325fb9 100644
--- a/drivers/bus/fslmc/mc/dpci.c
+++ b/drivers/bus/fslmc/mc/dpci.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2017-2019 NXP
diff --git a/drivers/bus/fslmc/mc/dpcon.c b/drivers/bus/fslmc/mc/dpcon.c
index b9f2f50e12..cd909fcac4 100644
--- a/drivers/bus/fslmc/mc/dpcon.c
+++ b/drivers/bus/fslmc/mc/dpcon.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2017-2019 NXP
diff --git a/drivers/bus/fslmc/mc/dpio.c b/drivers/bus/fslmc/mc/dpio.c
index 8cdf8f432a..45789dc702 100644
--- a/drivers/bus/fslmc/mc/dpio.c
+++ b/drivers/bus/fslmc/mc/dpio.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2023 NXP
diff --git a/drivers/bus/fslmc/mc/dpmng.c b/drivers/bus/fslmc/mc/dpmng.c
index 47c85cd80d..cbb0b7a84d 100644
--- a/drivers/bus/fslmc/mc/dpmng.c
+++ b/drivers/bus/fslmc/mc/dpmng.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2015 Freescale Semiconductor Inc.
  * Copyright 2017 NXP
diff --git a/drivers/bus/fslmc/mc/dprc.c b/drivers/bus/fslmc/mc/dprc.c
index 5f04ead20c..578ab63f7b 100644
--- a/drivers/bus/fslmc/mc/dprc.c
+++ b/drivers/bus/fslmc/mc/dprc.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2021 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dpbp.h b/drivers/bus/fslmc/mc/fsl_dpbp.h
index c79b511715..491679b191 100644
--- a/drivers/bus/fslmc/mc/fsl_dpbp.h
+++ b/drivers/bus/fslmc/mc/fsl_dpbp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2017, 2025 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dpbp_cmd.h b/drivers/bus/fslmc/mc/fsl_dpbp_cmd.h
index 55c9fc9b43..dd47e43b74 100644
--- a/drivers/bus/fslmc/mc/fsl_dpbp_cmd.h
+++ b/drivers/bus/fslmc/mc/fsl_dpbp_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2017 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dpci.h b/drivers/bus/fslmc/mc/fsl_dpci.h
index 397b4bc2be..55b67244c1 100644
--- a/drivers/bus/fslmc/mc/fsl_dpci.h
+++ b/drivers/bus/fslmc/mc/fsl_dpci.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2017-2019 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dpci_cmd.h b/drivers/bus/fslmc/mc/fsl_dpci_cmd.h
index 92b85a820a..a0cc0de4a2 100644
--- a/drivers/bus/fslmc/mc/fsl_dpci_cmd.h
+++ b/drivers/bus/fslmc/mc/fsl_dpci_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  *
diff --git a/drivers/bus/fslmc/mc/fsl_dpcon.h b/drivers/bus/fslmc/mc/fsl_dpcon.h
index e3a626077e..f2668da1b1 100644
--- a/drivers/bus/fslmc/mc/fsl_dpcon.h
+++ b/drivers/bus/fslmc/mc/fsl_dpcon.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2017-2021, 2024 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dpcon_cmd.h b/drivers/bus/fslmc/mc/fsl_dpcon_cmd.h
index 1641e32033..ff8bdc76fe 100644
--- a/drivers/bus/fslmc/mc/fsl_dpcon_cmd.h
+++ b/drivers/bus/fslmc/mc/fsl_dpcon_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2017 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dpio.h b/drivers/bus/fslmc/mc/fsl_dpio.h
index eddce58a5f..6acbc8d561 100644
--- a/drivers/bus/fslmc/mc/fsl_dpio.h
+++ b/drivers/bus/fslmc/mc/fsl_dpio.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2023 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dpio_cmd.h b/drivers/bus/fslmc/mc/fsl_dpio_cmd.h
index 360c68eaa5..dad489915f 100644
--- a/drivers/bus/fslmc/mc/fsl_dpio_cmd.h
+++ b/drivers/bus/fslmc/mc/fsl_dpio_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2023 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dpmng.h b/drivers/bus/fslmc/mc/fsl_dpmng.h
index a7578766e0..f8a1268c8e 100644
--- a/drivers/bus/fslmc/mc/fsl_dpmng.h
+++ b/drivers/bus/fslmc/mc/fsl_dpmng.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2015 Freescale Semiconductor Inc.
  * Copyright 2017-2024 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dpmng_cmd.h b/drivers/bus/fslmc/mc/fsl_dpmng_cmd.h
index ac380be148..f0bd6e4bed 100644
--- a/drivers/bus/fslmc/mc/fsl_dpmng_cmd.h
+++ b/drivers/bus/fslmc/mc/fsl_dpmng_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2017 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dpopr.h b/drivers/bus/fslmc/mc/fsl_dpopr.h
index 74dd32f783..5ab1ae04e7 100644
--- a/drivers/bus/fslmc/mc/fsl_dpopr.h
+++ b/drivers/bus/fslmc/mc/fsl_dpopr.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2015 Freescale Semiconductor Inc.
  * Copyright 2018-2021 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dprc.h b/drivers/bus/fslmc/mc/fsl_dprc.h
index 8c9e482d26..dba0d2017d 100644
--- a/drivers/bus/fslmc/mc/fsl_dprc.h
+++ b/drivers/bus/fslmc/mc/fsl_dprc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2021 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_dprc_cmd.h b/drivers/bus/fslmc/mc/fsl_dprc_cmd.h
index d5ba35b5f0..b44309f258 100644
--- a/drivers/bus/fslmc/mc/fsl_dprc_cmd.h
+++ b/drivers/bus/fslmc/mc/fsl_dprc_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2023 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_mc_cmd.h b/drivers/bus/fslmc/mc/fsl_mc_cmd.h
index a768774c89..b4e79e687f 100644
--- a/drivers/bus/fslmc/mc/fsl_mc_cmd.h
+++ b/drivers/bus/fslmc/mc/fsl_mc_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2017 NXP
diff --git a/drivers/bus/fslmc/mc/fsl_mc_sys.h b/drivers/bus/fslmc/mc/fsl_mc_sys.h
index c91f14ade8..d7413dedb8 100644
--- a/drivers/bus/fslmc/mc/fsl_mc_sys.h
+++ b/drivers/bus/fslmc/mc/fsl_mc_sys.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2015 Freescale Semiconductor Inc.
  * Copyright 2017 NXP
diff --git a/drivers/bus/fslmc/mc/mc_sys.c b/drivers/bus/fslmc/mc/mc_sys.c
index ef4c8dd3b8..ad1eec0e36 100644
--- a/drivers/bus/fslmc/mc/mc_sys.c
+++ b/drivers/bus/fslmc/mc/mc_sys.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2015 Freescale Semiconductor Inc.
  * Copyright 2017,2022 NXP
diff --git a/drivers/common/dpaax/caamflib.c b/drivers/common/dpaax/caamflib.c
index 82a7413b5f..31864be341 100644
--- a/drivers/common/dpaax/caamflib.c
+++ b/drivers/common/dpaax/caamflib.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2020 NXP
  *
diff --git a/drivers/common/dpaax/caamflib/compat.h b/drivers/common/dpaax/caamflib/compat.h
index 43da6a4fe3..12e6f94c90 100644
--- a/drivers/common/dpaax/caamflib/compat.h
+++ b/drivers/common/dpaax/caamflib/compat.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
diff --git a/drivers/common/dpaax/caamflib/desc.h b/drivers/common/dpaax/caamflib/desc.h
index 4a1285c4d4..040114333c 100644
--- a/drivers/common/dpaax/caamflib/desc.h
+++ b/drivers/common/dpaax/caamflib/desc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016, 2019, 2023 NXP
diff --git a/drivers/common/dpaax/caamflib/desc/algo.h b/drivers/common/dpaax/caamflib/desc/algo.h
index e0848f0940..e2f5771e1a 100644
--- a/drivers/common/dpaax/caamflib/desc/algo.h
+++ b/drivers/common/dpaax/caamflib/desc/algo.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019-2021 NXP
diff --git a/drivers/common/dpaax/caamflib/desc/common.h b/drivers/common/dpaax/caamflib/desc/common.h
index 816baacfdb..c828c025c8 100644
--- a/drivers/common/dpaax/caamflib/desc/common.h
+++ b/drivers/common/dpaax/caamflib/desc/common.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
diff --git a/drivers/common/dpaax/caamflib/desc/ipsec.h b/drivers/common/dpaax/caamflib/desc/ipsec.h
index b902873970..230b40d737 100644
--- a/drivers/common/dpaax/caamflib/desc/ipsec.h
+++ b/drivers/common/dpaax/caamflib/desc/ipsec.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019-2022 NXP
diff --git a/drivers/common/dpaax/caamflib/desc/pdcp.h b/drivers/common/dpaax/caamflib/desc/pdcp.h
index 55159d53f0..1ea72e539c 100644
--- a/drivers/common/dpaax/caamflib/desc/pdcp.h
+++ b/drivers/common/dpaax/caamflib/desc/pdcp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause or GPL-2.0+
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
  * Copyright 2008-2013 Freescale Semiconductor, Inc.
  * Copyright 2019-2025 NXP
  */
diff --git a/drivers/common/dpaax/caamflib/rta.h b/drivers/common/dpaax/caamflib/rta.h
index 3817314812..4e8fa370da 100644
--- a/drivers/common/dpaax/caamflib/rta.h
+++ b/drivers/common/dpaax/caamflib/rta.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2021 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/fifo_load_store_cmd.h b/drivers/common/dpaax/caamflib/rta/fifo_load_store_cmd.h
index 51d54deb16..ed4286dcdc 100644
--- a/drivers/common/dpaax/caamflib/rta/fifo_load_store_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/fifo_load_store_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/header_cmd.h b/drivers/common/dpaax/caamflib/rta/header_cmd.h
index 779f84ebcb..c95bcf33b9 100644
--- a/drivers/common/dpaax/caamflib/rta/header_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/header_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/jump_cmd.h b/drivers/common/dpaax/caamflib/rta/jump_cmd.h
index 0ce5a3e7c6..9df0bed630 100644
--- a/drivers/common/dpaax/caamflib/rta/jump_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/jump_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/key_cmd.h b/drivers/common/dpaax/caamflib/rta/key_cmd.h
index 714918e18b..861a3bf0db 100644
--- a/drivers/common/dpaax/caamflib/rta/key_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/key_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/load_cmd.h b/drivers/common/dpaax/caamflib/rta/load_cmd.h
index 38e253c220..2e5011965f 100644
--- a/drivers/common/dpaax/caamflib/rta/load_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/load_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/math_cmd.h b/drivers/common/dpaax/caamflib/rta/math_cmd.h
index 532c70c518..fb21f88726 100644
--- a/drivers/common/dpaax/caamflib/rta/math_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/math_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/move_cmd.h b/drivers/common/dpaax/caamflib/rta/move_cmd.h
index ac1280c23a..08a65da4ae 100644
--- a/drivers/common/dpaax/caamflib/rta/move_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/move_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/nfifo_cmd.h b/drivers/common/dpaax/caamflib/rta/nfifo_cmd.h
index 8131acd9e4..8787b0edcb 100644
--- a/drivers/common/dpaax/caamflib/rta/nfifo_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/nfifo_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/operation_cmd.h b/drivers/common/dpaax/caamflib/rta/operation_cmd.h
index 563735eb88..b6ff23c9bd 100644
--- a/drivers/common/dpaax/caamflib/rta/operation_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/operation_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019-2021 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/protocol_cmd.h b/drivers/common/dpaax/caamflib/rta/protocol_cmd.h
index 5b33f103be..ad0f58b70c 100644
--- a/drivers/common/dpaax/caamflib/rta/protocol_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/protocol_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019,2023 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/sec_run_time_asm.h b/drivers/common/dpaax/caamflib/rta/sec_run_time_asm.h
index 5c2efeb2c5..cc9233d5d1 100644
--- a/drivers/common/dpaax/caamflib/rta/sec_run_time_asm.h
+++ b/drivers/common/dpaax/caamflib/rta/sec_run_time_asm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/seq_in_out_ptr_cmd.h b/drivers/common/dpaax/caamflib/rta/seq_in_out_ptr_cmd.h
index 5e6af0c834..4e1aea1efe 100644
--- a/drivers/common/dpaax/caamflib/rta/seq_in_out_ptr_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/seq_in_out_ptr_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/signature_cmd.h b/drivers/common/dpaax/caamflib/rta/signature_cmd.h
index 4f694ac239..59a8e08ee4 100644
--- a/drivers/common/dpaax/caamflib/rta/signature_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/signature_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
diff --git a/drivers/common/dpaax/caamflib/rta/store_cmd.h b/drivers/common/dpaax/caamflib/rta/store_cmd.h
index 5de47d0536..f2a77bea59 100644
--- a/drivers/common/dpaax/caamflib/rta/store_cmd.h
+++ b/drivers/common/dpaax/caamflib/rta/store_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
  * Copyright 2016,2019 NXP
diff --git a/drivers/common/dpaax/compat.h b/drivers/common/dpaax/compat.h
index d59207245c..d0635255da 100644
--- a/drivers/common/dpaax/compat.h
+++ b/drivers/common/dpaax/compat.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2011 Freescale Semiconductor, Inc.
  * All rights reserved.
diff --git a/drivers/common/dpaax/dpaa_of.c b/drivers/common/dpaax/dpaa_of.c
index 23035f530d..090ef87a5a 100644
--- a/drivers/common/dpaax/dpaa_of.c
+++ b/drivers/common/dpaax/dpaa_of.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2010-2016 Freescale Semiconductor Inc.
  * Copyright 2017 NXP
diff --git a/drivers/common/dpaax/dpaa_of.h b/drivers/common/dpaax/dpaa_of.h
index aed6bf98b0..c12206dcad 100644
--- a/drivers/common/dpaax/dpaa_of.h
+++ b/drivers/common/dpaax/dpaa_of.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2010-2016 Freescale Semiconductor, Inc.
  * Copyright 2017 NXP
diff --git a/drivers/common/qat/qat_adf/adf_pf2vf_msg.h b/drivers/common/qat/qat_adf/adf_pf2vf_msg.h
index 4029b1c14a..8e4d1446b1 100644
--- a/drivers/common/qat/qat_adf/adf_pf2vf_msg.h
+++ b/drivers/common/qat/qat_adf/adf_pf2vf_msg.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2021 Intel Corporation
  */
 #ifndef ADF_PF2VF_MSG_H_
diff --git a/drivers/common/qat/qat_adf/adf_transport_access_macros.h b/drivers/common/qat/qat_adf/adf_transport_access_macros.h
index 19bd812419..d5e308df97 100644
--- a/drivers/common/qat/qat_adf/adf_transport_access_macros.h
+++ b/drivers/common/qat/qat_adf/adf_transport_access_macros.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2015-2018 Intel Corporation
  */
 #ifndef ADF_TRANSPORT_ACCESS_MACROS_H
diff --git a/drivers/common/qat/qat_adf/adf_transport_access_macros_gen4.h b/drivers/common/qat/qat_adf/adf_transport_access_macros_gen4.h
index 3ab873db5e..08a63002bb 100644
--- a/drivers/common/qat/qat_adf/adf_transport_access_macros_gen4.h
+++ b/drivers/common/qat/qat_adf/adf_transport_access_macros_gen4.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2021 Intel Corporation
  */
 
diff --git a/drivers/common/qat/qat_adf/adf_transport_access_macros_gen4vf.h b/drivers/common/qat/qat_adf/adf_transport_access_macros_gen4vf.h
index 37e113c443..d6b71ad658 100644
--- a/drivers/common/qat/qat_adf/adf_transport_access_macros_gen4vf.h
+++ b/drivers/common/qat/qat_adf/adf_transport_access_macros_gen4vf.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2021 Intel Corporation
  */
 
diff --git a/drivers/common/qat/qat_adf/adf_transport_access_macros_gen_lce.h b/drivers/common/qat/qat_adf/adf_transport_access_macros_gen_lce.h
index eac0d30f49..75efad337e 100644
--- a/drivers/common/qat/qat_adf/adf_transport_access_macros_gen_lce.h
+++ b/drivers/common/qat/qat_adf/adf_transport_access_macros_gen_lce.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2024 Intel Corporation
  */
 
diff --git a/drivers/common/qat/qat_adf/adf_transport_access_macros_gen_lcevf.h b/drivers/common/qat/qat_adf/adf_transport_access_macros_gen_lcevf.h
index 3c7232de12..31377678bc 100644
--- a/drivers/common/qat/qat_adf/adf_transport_access_macros_gen_lcevf.h
+++ b/drivers/common/qat/qat_adf/adf_transport_access_macros_gen_lcevf.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2024 Intel Corporation
  */
 
diff --git a/drivers/common/qat/qat_adf/icp_qat_fw.h b/drivers/common/qat/qat_adf/icp_qat_fw.h
index 4c7bbf0f54..7edcaf5861 100644
--- a/drivers/common/qat/qat_adf/icp_qat_fw.h
+++ b/drivers/common/qat/qat_adf/icp_qat_fw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2015-2018 Intel Corporation
  */
 #ifndef _ICP_QAT_FW_H_
diff --git a/drivers/common/qat/qat_adf/icp_qat_fw_comp.h b/drivers/common/qat/qat_adf/icp_qat_fw_comp.h
index c89a2c2fd3..da45cb8f7d 100644
--- a/drivers/common/qat/qat_adf/icp_qat_fw_comp.h
+++ b/drivers/common/qat/qat_adf/icp_qat_fw_comp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2015-2018 Intel Corporation
  */
 #ifndef _ICP_QAT_FW_COMP_H_
diff --git a/drivers/common/qat/qat_adf/icp_qat_fw_la.h b/drivers/common/qat/qat_adf/icp_qat_fw_la.h
index 835674d91b..735dfb5103 100644
--- a/drivers/common/qat/qat_adf/icp_qat_fw_la.h
+++ b/drivers/common/qat/qat_adf/icp_qat_fw_la.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2015-2019 Intel Corporation
  */
 #ifndef _ICP_QAT_FW_LA_H_
diff --git a/drivers/common/qat/qat_adf/icp_qat_hw.h b/drivers/common/qat/qat_adf/icp_qat_hw.h
index e929b16df2..1c69a0dc41 100644
--- a/drivers/common/qat/qat_adf/icp_qat_hw.h
+++ b/drivers/common/qat/qat_adf/icp_qat_hw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2015-2018 Intel Corporation
  */
 #ifndef _ICP_QAT_HW_H_
diff --git a/drivers/common/qat/qat_adf/icp_qat_hw_gen4_comp.h b/drivers/common/qat/qat_adf/icp_qat_hw_gen4_comp.h
index ec69dc7105..afe82bd1a2 100644
--- a/drivers/common/qat/qat_adf/icp_qat_hw_gen4_comp.h
+++ b/drivers/common/qat/qat_adf/icp_qat_hw_gen4_comp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2021 Intel Corporation
  */
 
diff --git a/drivers/common/qat/qat_adf/icp_qat_hw_gen4_comp_defs.h b/drivers/common/qat/qat_adf/icp_qat_hw_gen4_comp_defs.h
index ad02d06b12..faf5c83d89 100644
--- a/drivers/common/qat/qat_adf/icp_qat_hw_gen4_comp_defs.h
+++ b/drivers/common/qat/qat_adf/icp_qat_hw_gen4_comp_defs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2021 Intel Corporation
  */
 
diff --git a/drivers/crypto/dpaa2_sec/mc/dpseci.c b/drivers/crypto/dpaa2_sec/mc/dpseci.c
index 773b4648e0..363c925a79 100644
--- a/drivers/crypto/dpaa2_sec/mc/dpseci.c
+++ b/drivers/crypto/dpaa2_sec/mc/dpseci.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2023 NXP
diff --git a/drivers/crypto/dpaa2_sec/mc/fsl_dpseci.h b/drivers/crypto/dpaa2_sec/mc/fsl_dpseci.h
index e371abdd64..3841801fcb 100644
--- a/drivers/crypto/dpaa2_sec/mc/fsl_dpseci.h
+++ b/drivers/crypto/dpaa2_sec/mc/fsl_dpseci.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2023 NXP
diff --git a/drivers/crypto/dpaa2_sec/mc/fsl_dpseci_cmd.h b/drivers/crypto/dpaa2_sec/mc/fsl_dpseci_cmd.h
index 065464b701..ca3bd54093 100644
--- a/drivers/crypto/dpaa2_sec/mc/fsl_dpseci_cmd.h
+++ b/drivers/crypto/dpaa2_sec/mc/fsl_dpseci_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2023 NXP
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 2ba4fc0a3a..ff01db4372 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2015-2022 Intel Corporation
  */
 
diff --git a/drivers/event/dpaa/dpaa_eventdev.c b/drivers/event/dpaa/dpaa_eventdev.c
index 400e0ecd1c..e5d93afca2 100644
--- a/drivers/event/dpaa/dpaa_eventdev.c
+++ b/drivers/event/dpaa/dpaa_eventdev.c
@@ -1,4 +1,4 @@
-/*   SPDX-License-Identifier:        BSD-3-Clause
+/*   SPDX-License-Identifier: BSD-3-Clause
  *   Copyright 2017-2019 NXP
  */
 
diff --git a/drivers/event/dpaa/dpaa_eventdev.h b/drivers/event/dpaa/dpaa_eventdev.h
index 047c9781bd..1794f4cde6 100644
--- a/drivers/event/dpaa/dpaa_eventdev.h
+++ b/drivers/event/dpaa/dpaa_eventdev.h
@@ -1,4 +1,4 @@
-/*   SPDX-License-Identifier:        BSD-3-Clause
+/*   SPDX-License-Identifier: BSD-3-Clause
  *   Copyright 2017 NXP
  */
 
diff --git a/drivers/net/atlantic/atl_hw_regs.c b/drivers/net/atlantic/atl_hw_regs.c
index bd42c8341e..c5c5dc1fb0 100644
--- a/drivers/net/atlantic/atl_hw_regs.c
+++ b/drivers/net/atlantic/atl_hw_regs.c
@@ -1,5 +1,6 @@
-// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
-/* Copyright (C) 2014-2017 aQuantia Corporation. */
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * Copyright (C) 2014-2017 aQuantia Corporation.
+ */
 
 /* File aq_hw_utils.c: Definitions of helper functions used across
  * hardware layer.
diff --git a/drivers/net/atlantic/atl_hw_regs.h b/drivers/net/atlantic/atl_hw_regs.h
index 9d63804960..804d02b333 100644
--- a/drivers/net/atlantic/atl_hw_regs.h
+++ b/drivers/net/atlantic/atl_hw_regs.h
@@ -1,5 +1,6 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0) */
-/* Copyright (C) 2014-2017 aQuantia Corporation. */
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * Copyright (C) 2014-2017 aQuantia Corporation.
+ */
 
 /* File aq_hw_utils.h: Declaration of helper functions used across hardware
  * layer.
diff --git a/drivers/net/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/atlantic/hw_atl/hw_atl_b0.c
index d0eb4af928..c74ab6cfce 100644
--- a/drivers/net/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/atlantic/hw_atl/hw_atl_b0.c
@@ -1,5 +1,6 @@
-// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
-/* Copyright (C) 2014-2017 aQuantia Corporation. */
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * Copyright (C) 2014-2017 aQuantia Corporation.
+ */
 
 /* File hw_atl_b0.c: Definition of Atlantic hardware specific functions. */
 
diff --git a/drivers/net/atlantic/hw_atl/hw_atl_b0.h b/drivers/net/atlantic/hw_atl/hw_atl_b0.h
index d1ba2aceb3..a93568dfa3 100644
--- a/drivers/net/atlantic/hw_atl/hw_atl_b0.h
+++ b/drivers/net/atlantic/hw_atl/hw_atl_b0.h
@@ -1,5 +1,6 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0) */
-/* Copyright (C) 2014-2017 aQuantia Corporation. */
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * Copyright (C) 2014-2017 aQuantia Corporation.
+ */
 
 /* File hw_atl_b0.h: Declaration of abstract interface for Atlantic hardware
  * specific functions.
diff --git a/drivers/net/atlantic/hw_atl/hw_atl_b0_internal.h b/drivers/net/atlantic/hw_atl/hw_atl_b0_internal.h
index 48152eada7..8a6952d958 100644
--- a/drivers/net/atlantic/hw_atl/hw_atl_b0_internal.h
+++ b/drivers/net/atlantic/hw_atl/hw_atl_b0_internal.h
@@ -1,5 +1,6 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0) */
-/* Copyright (C) 2014-2017 aQuantia Corporation. */
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * Copyright (C) 2014-2017 aQuantia Corporation.
+ */
 
 /* File hw_atl_b0_internal.h: Definition of Atlantic B0 chip specific
  * constants.
diff --git a/drivers/net/atlantic/hw_atl/hw_atl_llh.c b/drivers/net/atlantic/hw_atl/hw_atl_llh.c
index 2dc5be2ff1..6eef5d1ce8 100644
--- a/drivers/net/atlantic/hw_atl/hw_atl_llh.c
+++ b/drivers/net/atlantic/hw_atl/hw_atl_llh.c
@@ -1,5 +1,6 @@
-// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
-/* Copyright (C) 2014-2017 aQuantia Corporation. */
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * Copyright (C) 2014-2017 aQuantia Corporation.
+ */
 
 /* File hw_atl_llh.c: Definitions of bitfield and register access functions for
  * Atlantic registers.
diff --git a/drivers/net/atlantic/hw_atl/hw_atl_llh.h b/drivers/net/atlantic/hw_atl/hw_atl_llh.h
index e30083cea5..83d6a4e799 100644
--- a/drivers/net/atlantic/hw_atl/hw_atl_llh.h
+++ b/drivers/net/atlantic/hw_atl/hw_atl_llh.h
@@ -1,5 +1,6 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0) */
-/* Copyright (C) 2014-2017 aQuantia Corporation. */
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * Copyright (C) 2014-2017 aQuantia Corporation.
+ */
 
 /* File hw_atl_llh.h: Declarations of bitfield and register access functions for
  * Atlantic registers.
diff --git a/drivers/net/atlantic/hw_atl/hw_atl_llh_internal.h b/drivers/net/atlantic/hw_atl/hw_atl_llh_internal.h
index 27b9b9cb3b..8ba9350440 100644
--- a/drivers/net/atlantic/hw_atl/hw_atl_llh_internal.h
+++ b/drivers/net/atlantic/hw_atl/hw_atl_llh_internal.h
@@ -1,5 +1,6 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0) */
-/* Copyright (C) 2014-2017 aQuantia Corporation. */
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * Copyright (C) 2014-2017 aQuantia Corporation.
+ */
 
 /* File hw_atl_llh_internal.h: Preprocessor definitions
  * for Atlantic registers.
diff --git a/drivers/net/atlantic/hw_atl/hw_atl_utils.c b/drivers/net/atlantic/hw_atl/hw_atl_utils.c
index 06d79115b9..3eabedc71e 100644
--- a/drivers/net/atlantic/hw_atl/hw_atl_utils.c
+++ b/drivers/net/atlantic/hw_atl/hw_atl_utils.c
@@ -1,5 +1,6 @@
-// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
-/* Copyright (C) 2014-2017 aQuantia Corporation. */
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * Copyright (C) 2014-2017 aQuantia Corporation.
+ */
 
 /* File hw_atl_utils.c: Definition of common functions for Atlantic hardware
  * abstraction layer.
diff --git a/drivers/net/atlantic/hw_atl/hw_atl_utils.h b/drivers/net/atlantic/hw_atl/hw_atl_utils.h
index 9bdd7b8eee..98d93ce559 100644
--- a/drivers/net/atlantic/hw_atl/hw_atl_utils.h
+++ b/drivers/net/atlantic/hw_atl/hw_atl_utils.h
@@ -1,5 +1,6 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0) */
-/* Copyright (C) 2014-2017 aQuantia Corporation. */
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * Copyright (C) 2014-2017 aQuantia Corporation.
+ */
 
 /* File hw_atl_utils.h: Declaration of common functions for Atlantic hardware
  * abstraction layer.
diff --git a/drivers/net/atlantic/hw_atl/hw_atl_utils_fw2x.c b/drivers/net/atlantic/hw_atl/hw_atl_utils_fw2x.c
index 51ff718620..31d043599e 100644
--- a/drivers/net/atlantic/hw_atl/hw_atl_utils_fw2x.c
+++ b/drivers/net/atlantic/hw_atl/hw_atl_utils_fw2x.c
@@ -1,5 +1,6 @@
-// SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
-/* Copyright (C) 2014-2017 aQuantia Corporation. */
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+ * Copyright (C) 2014-2017 aQuantia Corporation.
+ */
 
 /* File hw_atl_utils_fw2x.c: Definition of firmware 2.x functions for
  * Atlantic hardware abstraction layer.
diff --git a/drivers/net/avp/rte_avp_common.h b/drivers/net/avp/rte_avp_common.h
index 906cf0b60a..ffdf07cd80 100644
--- a/drivers/net/avp/rte_avp_common.h
+++ b/drivers/net/avp/rte_avp_common.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR LGPL-2.1)
+/* SPDX-License-Identifier: BSD-3-Clause OR LGPL-2.1
  * Copyright(c) 2010-2013 Intel Corporation.
  * Copyright(c) 2014-2017 Wind River Systems, Inc.
  */
diff --git a/drivers/net/avp/rte_avp_fifo.h b/drivers/net/avp/rte_avp_fifo.h
index 879de3b1c0..3c27ca035a 100644
--- a/drivers/net/avp/rte_avp_fifo.h
+++ b/drivers/net/avp/rte_avp_fifo.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR LGPL-2.1)
+/* SPDX-License-Identifier: BSD-3-Clause OR LGPL-2.1
  * Copyright(c) 2010-2013 Intel Corporation.
  * Copyright(c) 2013-2017 Wind River Systems, Inc.
  */
diff --git a/drivers/net/bnxt/bnxt_nvm_defs.h b/drivers/net/bnxt/bnxt_nvm_defs.h
index 57ddefa7a1..b3132c2780 100644
--- a/drivers/net/bnxt/bnxt_nvm_defs.h
+++ b/drivers/net/bnxt/bnxt_nvm_defs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2014-2023 Broadcom
  * All rights reserved.
  */
diff --git a/drivers/net/dpaa/fmlib/dpaa_integration.h b/drivers/net/dpaa/fmlib/dpaa_integration.h
index 33b9619f93..d0aee4c6e1 100644
--- a/drivers/net/dpaa/fmlib/dpaa_integration.h
+++ b/drivers/net/dpaa/fmlib/dpaa_integration.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright 2009-2012 Freescale Semiconductor Inc.
  * Copyright 2017-2020 NXP
  */
diff --git a/drivers/net/dpaa/fmlib/ncsw_ext.h b/drivers/net/dpaa/fmlib/ncsw_ext.h
index ae5f0c8847..1a6e337f49 100644
--- a/drivers/net/dpaa/fmlib/ncsw_ext.h
+++ b/drivers/net/dpaa/fmlib/ncsw_ext.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright 2008-2012 Freescale Semiconductor Inc.
  * Copyright 2017-2020 NXP
  */
diff --git a/drivers/net/dpaa/fmlib/net_ext.h b/drivers/net/dpaa/fmlib/net_ext.h
index 4cd5209317..7a22096724 100644
--- a/drivers/net/dpaa/fmlib/net_ext.h
+++ b/drivers/net/dpaa/fmlib/net_ext.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright 2008-2012 Freescale Semiconductor Inc.
  * Copyright 2017-2019 NXP
  */
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index fdf3e0f220..b3a79f18d3 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1,8 +1,6 @@
-/* * SPDX-License-Identifier: BSD-3-Clause
- *
- *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2025 NXP
- *
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright 2016-2025 NXP
  */
 
 #include <time.h>
diff --git a/drivers/net/dpaa2/dpaa2_recycle.c b/drivers/net/dpaa2/dpaa2_recycle.c
index d1e21dd4d1..1893979748 100644
--- a/drivers/net/dpaa2/dpaa2_recycle.c
+++ b/drivers/net/dpaa2/dpaa2_recycle.c
@@ -1,7 +1,5 @@
-/* * SPDX-License-Identifier: BSD-3-Clause
- *
- *   Copyright 2019-2021 NXP
- *
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2019-2021 NXP
  */
 
 #include <time.h>
diff --git a/drivers/net/dpaa2/dpaa2_sparser.h b/drivers/net/dpaa2/dpaa2_sparser.h
index ed0897928b..0187cde113 100644
--- a/drivers/net/dpaa2/dpaa2_sparser.h
+++ b/drivers/net/dpaa2/dpaa2_sparser.h
@@ -1,5 +1,5 @@
-/* * SPDX-License-Identifier: BSD-3-Clause
- *   Copyright 2018-2019 NXP
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2018-2019 NXP
  */
 
 /**
diff --git a/drivers/net/dpaa2/mc/dpdmux.c b/drivers/net/dpaa2/mc/dpdmux.c
index f4feef3840..c3cc992e4c 100644
--- a/drivers/net/dpaa2/mc/dpdmux.c
+++ b/drivers/net/dpaa2/mc/dpdmux.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2018-2023 NXP
diff --git a/drivers/net/dpaa2/mc/dpkg.c b/drivers/net/dpaa2/mc/dpkg.c
index 280c1b0764..3937fc5292 100644
--- a/drivers/net/dpaa2/mc/dpkg.c
+++ b/drivers/net/dpaa2/mc/dpkg.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2017-2021, 2023-2024 NXP
  *
diff --git a/drivers/net/dpaa2/mc/dpni.c b/drivers/net/dpaa2/mc/dpni.c
index a1f168dd04..d0a9fefd31 100644
--- a/drivers/net/dpaa2/mc/dpni.c
+++ b/drivers/net/dpaa2/mc/dpni.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2025 NXP
diff --git a/drivers/net/dpaa2/mc/dprtc.c b/drivers/net/dpaa2/mc/dprtc.c
index 18f23e2fe3..253d9f6fb1 100644
--- a/drivers/net/dpaa2/mc/dprtc.c
+++ b/drivers/net/dpaa2/mc/dprtc.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright 2019-2024 NXP
  */
 #include <fsl_mc_sys.h>
diff --git a/drivers/net/dpaa2/mc/fsl_dpdmux.h b/drivers/net/dpaa2/mc/fsl_dpdmux.h
index 2db4abf234..a167cd09c6 100644
--- a/drivers/net/dpaa2/mc/fsl_dpdmux.h
+++ b/drivers/net/dpaa2/mc/fsl_dpdmux.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2018-2024 NXP
diff --git a/drivers/net/dpaa2/mc/fsl_dpdmux_cmd.h b/drivers/net/dpaa2/mc/fsl_dpdmux_cmd.h
index a94f1bf91a..506e9f1756 100644
--- a/drivers/net/dpaa2/mc/fsl_dpdmux_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dpdmux_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2018-2023 NXP
diff --git a/drivers/net/dpaa2/mc/fsl_dpkg.h b/drivers/net/dpaa2/mc/fsl_dpkg.h
index 19fbae224b..41b918d832 100644
--- a/drivers/net/dpaa2/mc/fsl_dpkg.h
+++ b/drivers/net/dpaa2/mc/fsl_dpkg.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright 2013-2015 Freescale Semiconductor Inc.
  * Copyright 2016-2024 NXP
  *
diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
index 61d7573a4b..b5c0c84496 100644
--- a/drivers/net/dpaa2/mc/fsl_dpmac.h
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2018-2025 NXP
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index 5a0482129f..fcc6d4726e 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2025 NXP
diff --git a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
index 1878002fa0..bb4939031b 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016-2025 NXP
diff --git a/drivers/net/dpaa2/mc/fsl_dprtc.h b/drivers/net/dpaa2/mc/fsl_dprtc.h
index 06ff8ecb19..9f64ea0570 100644
--- a/drivers/net/dpaa2/mc/fsl_dprtc.h
+++ b/drivers/net/dpaa2/mc/fsl_dprtc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright 2019-2024 NXP
  */
 #ifndef __FSL_DPRTC_H
diff --git a/drivers/net/dpaa2/mc/fsl_dprtc_cmd.h b/drivers/net/dpaa2/mc/fsl_dprtc_cmd.h
index eaefe18460..a3cbc1c203 100644
--- a/drivers/net/dpaa2/mc/fsl_dprtc_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dprtc_cmd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright 2019-2024 NXP
  */
 #include <fsl_mc_sys.h>
diff --git a/drivers/net/dpaa2/mc/fsl_net.h b/drivers/net/dpaa2/mc/fsl_net.h
index 2d26d5d6c3..9ace8f3226 100644
--- a/drivers/net/dpaa2/mc/fsl_net.h
+++ b/drivers/net/dpaa2/mc/fsl_net.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2015 Freescale Semiconductor Inc.
  * Copyright 2018-2019 NXP
diff --git a/drivers/net/mlx5/mlx5_flow_meter.c b/drivers/net/mlx5/mlx5_flow_meter.c
index cd6a804593..312cf38f94 100644
--- a/drivers/net/mlx5/mlx5_flow_meter.c
+++ b/drivers/net/mlx5/mlx5_flow_meter.c
@@ -1,5 +1,4 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright 2018 Mellanox Technologies, Ltd
  */
 #include <math.h>
diff --git a/kernel/linux/uapi/linux/vduse.h b/kernel/linux/uapi/linux/vduse.h
index f46269af34..b7ffdf878f 100644
--- a/kernel/linux/uapi/linux/vduse.h
+++ b/kernel/linux/uapi/linux/vduse.h
@@ -1,4 +1,5 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause */
+
 #ifndef _VDUSE_H_
 #define _VDUSE_H_
 
diff --git a/lib/eal/include/rte_pci_dev_feature_defs.h b/lib/eal/include/rte_pci_dev_feature_defs.h
index e12c22081f..ad740a636c 100644
--- a/lib/eal/include/rte_pci_dev_feature_defs.h
+++ b/lib/eal/include/rte_pci_dev_feature_defs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
diff --git a/lib/eal/include/rte_pci_dev_features.h b/lib/eal/include/rte_pci_dev_features.h
index 6104123d27..a4707dc252 100644
--- a/lib/eal/include/rte_pci_dev_features.h
+++ b/lib/eal/include/rte_pci_dev_features.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
diff --git a/license/README b/license/README
index c78cfd9f65..7ffa1a247d 100644
--- a/license/README
+++ b/license/README
@@ -34,13 +34,13 @@ To label a file as dual-licensed with BSD-3-Clause and GPL-2.0 (e.g., for code
 that is shared between the kernel and userspace), the following text would be
 used:
 
-SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
 
 To label a file as dual-licensed with BSD-3-Clause and LGPL-2.1 (e.g., for code
 that is shared between the kernel and userspace), the following text would be
 used:
 
-SPDX-License-Identifier: (BSD-3-Clause OR LGPL-2.1)
+SPDX-License-Identifier: BSD-3-Clause OR LGPL-2.1
 
 Any new file contributions in DPDK shall adhere to the above scheme.
 It is also being recommended to replace the existing license text in the code
-- 
2.52.0

