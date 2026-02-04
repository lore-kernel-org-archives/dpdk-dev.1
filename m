Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680F6EA7944
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 20:49:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B7DB40B91;
	Wed,  4 Feb 2026 21:49:52 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id C33AF402AA
 for <dev@dpdk.org>; Wed,  4 Feb 2026 21:49:50 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 4EFD4EC0096;
 Wed,  4 Feb 2026 15:49:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 04 Feb 2026 15:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770238190; x=
 1770324590; bh=1tmoRJ0gIKcKQ5c0Y4CBovleVXqaHdTuWY2gLsMYrlM=; b=m
 uqmShxaSHCXBLxJpVfj5mKC6QBeOhYJTQWrnkWyfxJwjG0xh61BRh+HI+fwxqD92
 5h2Ew4pZii03VmA5iE+bP5YCT0jifsHpmstG4t52Cn5jalt2dCMRA/bElHyLzHfO
 IF4K2rltpyPEUmF8lmKdwOHLVnycqKCLEn4a4xK/DvO1vDDCvrSxeNTYgEPi45dv
 fbLPR6ZT6khbWOCM++XUCuuR1JGWXxwOrAoculck4LogEQ3zj9+g/F1jTFcDnIEI
 AEM+XzrOZ2jBy1/aq4H7ySOMV+2ENIWV9n9pEd5DPD1YrTi+owLtDMR8USSDFNVo
 4xk7TCrR/3FSe/ebGXE+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1770238190; x=1770324590; bh=1tmoRJ0gIKcKQ5c0Y4CBovleVXqa
 HdTuWY2gLsMYrlM=; b=Uc1F+zwb9+mteu3KiDyLUbAvAanYZBl0S8a7/nM+tRqZ
 D6yvfVzcYRmwYcVVpunbOpBuXvS+/aVSY0wyUFSameRq8aKpZcRlK6m6r+d8gEfn
 nM1BujOH6CxcHrpPh6z59AjSupy1EYibQSUf0aussjI7VNwI8cA+RAMjqzICl89h
 RfpIiWrTW5aa1Fvn+Rc615O/Zv5wWWl7KVB4/cIciGp1TDttWCUBznCiEDYEgfJM
 la3QYcvsFKXpu2JGndZtTHpyQoUKSDUoIIpszuN7z5PrCOUmcbi+myAm9S5e0Yk1
 yK3C28DZbRPkoVRGxl67kGUQBTL1YmNAqzbFi7L2Ow==
X-ME-Sender: <xms:7rCDaRWNZ--XqQ9adQDTHDy7-JDrLlqdy3hYZakL3ejsWYItaZ2PVg>
 <xme:7rCDaXeB0a-zs2yhXe0qSiThlNBw3TFbVz19TafDRs5q2QNsdKaIIPqkKl_lEkk_m
 xx3uDAg64KnpKy_k25neQWIIset52jYGvhwztVgFsiTzULIidBz>
X-ME-Received: <xmr:7rCDaYfW6apJPEcVo4sMHR_1yeup4cBRUH7enG3F8aACjcMpWwUa4sonLc28rXUkH2xu3aU_pNRDjC0F8GL5g3-ekcx0YPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefgeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
 dttdenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedvhefgiedvjeegtdevheefhf
 etleefgfeivefgffevfeejgedtgfeutdehtdegveenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:7rCDaRK2YVnnyrFFlJKsxKIObdMeExy3CN9liGHs6GdLQeCGlil7WA>
 <xmx:7rCDafIc6ch7zD5rIce_If4u5Su4j94pSKn2V-ReBh73M8cnur6OoQ>
 <xmx:7rCDaTFA0O7FiYso4ao8OWrMieBrnXS9oxteqASpGJGZNHWOP2E8RA>
 <xmx:7rCDaUlQqBTlRpaPu8birIXrY6RxMjjn21NLATKYJM8WANg6WO7Jrw>
 <xmx:7rCDaZXNzDfaFWR8PAKazToOjV-LvTgrpUOHvH9NQnfVLRlt0qxLptCn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Wed, 4 Feb 2026 15:49:49 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH v3 0/2] standardize SPDX tag
Date: Wed,  4 Feb 2026 21:46:04 +0100
Message-ID: <20260204204945.3893117-1-thomas@monjalon.net>
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

SPDX lines are fixed to be more standard,
and the checker is improved to detect some of the fixed issues.
For readability, the script changes are in a separate patch,
but for the sake of atomicity, the patches should be squashed.

v2: update the script and README, and remove useless parentheses
v3: keep Linux uAPI imported file untouched

Thomas Monjalon (2):
  license: standardize SPDX tag
  devtools: check SPDX syntax

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
 lib/eal/include/rte_pci_dev_feature_defs.h    |  2 +-
 lib/eal/include/rte_pci_dev_features.h        |  2 +-
 license/README                                |  4 +--
 127 files changed, 183 insertions(+), 150 deletions(-)

-- 
2.52.0

