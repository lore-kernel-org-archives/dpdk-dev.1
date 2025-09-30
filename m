Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A1CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:05:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 538A540695;
	Tue, 30 Sep 2025 09:05:10 +0200 (CEST)
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com
 [209.85.210.228])
 by mails.dpdk.org (Postfix) with ESMTP id 4E23A402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:16 +0200 (CEST)
Received: by mail-pf1-f228.google.com with SMTP id
 d2e1a72fcca58-78127433a32so2348557b3a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192575; x=1759797375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejEaAl2Mbz0RguC1mEqjOA35Of0KqyWFD74RRQ03Qlk=;
 b=tJN9f41WMs3KwMUY1JuR0Hi5zE1kEVtUrhj7Z3iIEYK5MbDjFv/GiGaaX6FiIBejnO
 CyPCFXAX4zOJqOcnHofV1nJ6wdHKdiBGrM7DJt4P8Rm/j+gLWeJH6OI/u5PblFhLwNjK
 2W0p1gTt/XY4xGul0T5ttJhBYyfWR7P8m1RsDu3wRSJ3dznydBhaNBdz0N5/+00vsKoF
 dhoJCwdBmOQCf5D+lYyDzlfwui+h9xTcrMfRVp0ok1ObfVFyXgb1ysZhai/0wS6MU3fi
 DPk50YGVs4V6zBFl44revbReCtQBtQlof2a2Tryo8zqP0waobc1Gr2jnDIXYGbt1fQqo
 +JYg==
X-Gm-Message-State: AOJu0YwSP8vBE3Qpn5X2tWBZupLM6f3qTZ8N3Y83ePPm3gcRovvbuIDQ
 /ceipQExK6V3at5EUi3nZL2BR//RlD9jvT/yKNn7FYS5TUmPeeUS/cMurZoos2xKcNEK37AOUb/
 ONWy8VE/9Sri/0zc2bUoUUmOYqASj0LebAsBbU1UdKIgtOz5I4IXkY7nOxHq0+m42QW1nBlGYJP
 xgNtPl4lna1kKlpoX7ofvnAtTFAvMGu+x6v3t8STAr1EkBflbmRvPBvpQOuBpxss3wDQJ9lg==
X-Gm-Gg: ASbGncvCc8PSDJ1KVNb2CcBOYJ/ZJcTSqvDIeZhVUqtUhaxjoExnzFGLw4ESOLpsLXq
 KtOxsb1lJKTA6vcmw1wW1qCZ7Wd2tFe2+DOCWbI/TjhpmhhdAecu7wii8esrVMTQ9nz7a/iWtpb
 xrgGBLFG8ffISkSOuhfiiDIM31OE74weOBR51ClIkKSGYqpEBzOgn+AdPsmoRE1cOtjfz2zjFa5
 sxO2SevUNJuFO2q/sX9w8pElI7WBXw3aeijwLPCiYV1FtBxX+xlp2NS0LMsyBSCDOuqHsoVM038
 7MwJh5s09D2Xc1cL5ez7RKGsnQ0jjMkzw4oCvTdJsr+8qYi4NU2DVdeR6dq3w6L+z4sgYJGTvAd
 uiM4118FQrxz/76iY1XByVAivSsj/4sc8an4AzcuimSE8IOZwrxA1RBY6uYFaHDqS8BadG1MWud
 VGQQ==
X-Google-Smtp-Source: AGHT+IEWhfsCreCta/TgQcuVGc7xbqPWXl3wk9JQRRtGMerw2N/hprNKCoOsQATiFj3MOEBVTSS2f9RW0hUp
X-Received: by 2002:a05:6a20:3952:b0:261:b20d:3ee5 with SMTP id
 adf61e73a8af0-2e7c508ad90mr22211431637.23.1759192575337; 
 Mon, 29 Sep 2025 17:36:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-782208d748asm383062b3a.4.2025.09.29.17.36.14
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b57cf8dba28so3961305a12.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192573; x=1759797373; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ejEaAl2Mbz0RguC1mEqjOA35Of0KqyWFD74RRQ03Qlk=;
 b=hWALUugRHRwH7OSMXpI0QlNH6uKWTIiM+ZBVm7wH3RRlUeWl2AnO6mNV5X8gOW+1Qv
 cpvmrCq6/0kh9WfuYT/WWFszWKqkRZWnDb/BYEmm/NsrK7nfUt7Wee5qb2x3VNUS63Uc
 GlTwTwtM6BxnH3iknDwdXiNe07KR/Ed2hwyHM=
X-Received: by 2002:a05:6a21:3381:b0:2da:f4be:c8d9 with SMTP id
 adf61e73a8af0-2e7ce733c52mr22368548637.37.1759192573062; 
 Mon, 29 Sep 2025 17:36:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:3381:b0:2da:f4be:c8d9 with SMTP id
 adf61e73a8af0-2e7ce733c52mr22368520637.37.1759192572455; 
 Mon, 29 Sep 2025 17:36:12 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:11 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH 00/54] bnxt patchset
Date: Mon, 29 Sep 2025 20:35:10 -0400
Message-Id: <20250930003604.87108-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:06 +0200
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

Apart from bug fixes, this patchset adds the following
functionality:

1. Add the data, defines and enums for applications targeting Wh+,
   P5, P7 product families.
2. Update HSI files (HWRM API defintions, enums, version number)
3. Dynamic UPAR support for THOR2.
4. Add support to allow multiple instances of applications to exist at
   the same time.
5. Add hot upgrade support for applications.
6. Add MPLS packet offload support.
7. Improve backing store debug capabilities.
8. Add truflow global table scope support.
9. ULP parser support to handle GRE key.

Please apply.

Farah Smith (8):
  net/bnxt/tf_core: thor2 TF table scope sizing adjustments
  net/bnxt/tf_core: tcam manager logical id free
  net/bnxt/tf_core: thor2 hot upgrade ungraceful quit crash
  net/bnxt/tf_core: truflow global table scope
  net/bnxt/tf_ulp: socket direct enable
  net/bnxt: fix adding udp_tunnel_port
  net/bnxt: thor2 truflow memory manager bug
  net/bnxt/tf_core: fix truflow PF init failure on sriov disabled

Jay Ding (4):
  net/bnxt: fix a NULL pointer dereference in bnxt_rep funcs
  net/bnxt/tf_ulp: add meter stats support for Thor2
  net/bnxt/tf_core: fix the miscalculation of the lkup table pool
  next/bnxt/tf_ulp: truflow fixes for meter and mac_addr cache

Kishore Padmanabha (18):
  net/bnxt: enable vector mode processing
  net/bnxt/tf_ulp: add support for global identifiers
  net/bnxt/tf_core: add support for multi instance
  net/bnxt/tf_core: fix table scope free
  net/bnxt/tf_core: fix vfr clean up and stats lockup
  net/bnxt/tf_ulp: increase shared pool size to 32
  net/bnxt/tf_ulp: add support for tcam priority update
  net/bnxt/tf_ulp: hot upgrade support
  net/bnxt/tf_ulp: fix stats counter memory initialization
  net/bnxt: fix max VFs count for thor2
  net/bnxt/tf_ulp: enable support for global index table
  net/bnxt/tf_ulp: optimize template enums
  net/bnxt/tf_ulp: add non vfr mode capability
  net/bnxt: fix stats collection when rx queue is not set
  net/bnxt: fix rss configuration when set to none
  net/bnxt: packet drop after port stop and start
  net/bnxt/tf_ulp: add support for unicast only feature
  net/bnxt: add support for truflow promiscuous mode

Manish Kurup (6):
  net/bnxt/tf_ulp: add bnxt app data for 25.11
  net/bnxt/tf_core: dynamic UPAR support for THOR2
  net/bnxt: add meson build options for TruFlow
  net/bnxt: truflow HSI struct fixes
  net/bnxt/tf_ulp: fixes to enable TF functionality
  net/bnxt/tf_ulp: remove Truflow DEBUG code

Peter Spreadborough (6):
  net/bnxt/tf_ulp: ovs-dpdk packet drop observed with thor2
  net/bnxt/tf_core: add backing store debug to dpdk
  net/bnxt/tf_core: handle out of order MPC completions
  net/bnxt: avoid potential segfault in VFR handling
  net/bnxt/tf_core: fix truflow crash on memory allocation failure
  net/bnxt/tf_core: remove excessive debug logging

Sangtani Parag Satishbhai (3):
  net/bnxt/tf_ulp: fix seg fault when devargs argument missing
  net/bnxt: truflow remove redundant code for mpc init
  net/bnxt: truflow remove RTE devarg processing for mpc=1

Shahaji Bhosle (4):
  net/bnxt/tf_ulp: ulp parser support to handle gre key
  net/bnxt/tf_ulp: change rte_mem_virt2iova to rte_mem_virt2phys
  net/bnxt/tf_ulp: truflow add pf action handler
  net/bnxt/tf_ulp: add feature bit rx miss handling

Shuanglin Wang (2):
  net/bnxt/tf_core: fix build failure with flow scale option
  net/bnxt/tf_ulp: support MPLS packets

Smitha Pisupati (1):
  net/bnxt/tf_ulp: add support for special vxlan

Sriharsha Basavapatna (2):
  net/bnxt: fix default rss config
  net/bnxt: avoid iova range check when external memory is used

 drivers/net/bnxt/bnxt.h                       |     7 +
 drivers/net/bnxt/bnxt_compat.h                |   433 +
 drivers/net/bnxt/bnxt_ethdev.c                |   256 +-
 drivers/net/bnxt/bnxt_hwrm.c                  |    25 +-
 drivers/net/bnxt/bnxt_mpc.c                   |    43 +-
 drivers/net/bnxt/bnxt_mpc.h                   |     7 +-
 drivers/net/bnxt/bnxt_reps.c                  |    37 +-
 drivers/net/bnxt/bnxt_stats.c                 |     5 +
 drivers/net/bnxt/bnxt_txr.c                   |     5 +-
 drivers/net/bnxt/bnxt_vnic.c                  |    21 +-
 .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |    33 +-
 .../net/bnxt/hcapi/cfa_v3/include/cfa_types.h |    10 +
 drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c     |    83 +-
 .../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h    |     2 +-
 drivers/net/bnxt/hsi_struct_def_dpdk.h        |  1123 +-
 drivers/net/bnxt/tf_core/cfa_tcam_mgr.c       |    35 +-
 .../net/bnxt/tf_core/cfa_tcam_mgr_device.h    |     6 +-
 drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c    |     2 +-
 drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c   |     2 +-
 drivers/net/bnxt/tf_core/tf_resources.c       |     2 +-
 drivers/net/bnxt/tf_core/tf_util.c            |     2 +
 drivers/net/bnxt/tf_core/v3/meson.build       |    38 +-
 drivers/net/bnxt/tf_core/v3/tfc.h             |   238 +-
 drivers/net/bnxt/tf_core/v3/tfc_act.c         |    47 +-
 drivers/net/bnxt/tf_core/v3/tfc_cpm.c         |    13 +
 drivers/net/bnxt/tf_core/v3/tfc_debug.h       |    12 +-
 drivers/net/bnxt/tf_core/v3/tfc_em.c          |   143 +-
 drivers/net/bnxt/tf_core/v3/tfc_em.h          |   105 +-
 drivers/net/bnxt/tf_core/v3/tfc_global_id.c   |    45 +-
 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c |   142 +
 drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c     |    51 +-
 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c   |  1411 +
 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c   |   565 -
 drivers/net/bnxt/tf_core/v3/tfc_msg.c         |   363 +-
 drivers/net/bnxt/tf_core/v3/tfc_msg.h         |    41 +-
 drivers/net/bnxt/tf_core/v3/tfc_resources.c   |    12 +-
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c   |   246 +-
 drivers/net/bnxt/tf_core/v3/tfc_tcam.c        |    55 +
 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c  |  1875 +
 drivers/net/bnxt/tf_core/v3/tfc_util.c        |    23 +
 drivers/net/bnxt/tf_core/v3/tfc_util.h        |    14 +
 drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c   |     3 +-
 drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h   |     4 +-
 drivers/net/bnxt/tf_core/v3/tfo.c             |   211 +-
 drivers/net/bnxt/tf_core/v3/tfo.h             |    53 +-
 drivers/net/bnxt/tf_ulp/bnxt_tf_common.h      |     5 -
 drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c    |     6 -
 drivers/net/bnxt/tf_ulp/bnxt_ulp.h            |     6 +
 drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c       |    10 +
 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c      |    55 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c         |    27 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c        |   147 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h        |     5 +
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h      |    82 +-
 .../generic_templates/ulp_template_db_act.c   |     6 +-
 .../generic_templates/ulp_template_db_class.c |  8808 ++--
 .../generic_templates/ulp_template_db_defs.h  |    88 +
 .../generic_templates/ulp_template_db_field.h |     5 +-
 .../generic_templates/ulp_template_db_tbl.c   |   267 +-
 .../ulp_template_db_thor2_act.c               |  4637 +-
 .../ulp_template_db_thor2_class.c             | 42439 +++++++++-------
 .../ulp_template_db_thor_act.c                |    14 +-
 .../ulp_template_db_thor_class.c              | 13247 ++---
 .../ulp_template_db_wh_plus_act.c             |     2 +-
 .../ulp_template_db_wh_plus_class.c           |    26 +-
 drivers/net/bnxt/tf_ulp/meson.build           |    56 +-
 drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c       |     4 -
 drivers/net/bnxt/tf_ulp/ulp_def_rules.c       |    38 +-
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c          |    50 +-
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h          |    11 +
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c       |     3 +-
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c      |    64 +-
 drivers/net/bnxt/tf_ulp/ulp_flow_db.c         |    10 +-
 drivers/net/bnxt/tf_ulp/ulp_flow_db.h         |     6 +
 drivers/net/bnxt/tf_ulp/ulp_gen_hash.c        |     2 +-
 drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c         |    24 +
 drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h         |    12 +
 drivers/net/bnxt/tf_ulp/ulp_mapper.c          |   326 +-
 drivers/net/bnxt/tf_ulp/ulp_mapper.h          |    56 +-
 drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c       |    81 +-
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c      |   347 +-
 drivers/net/bnxt/tf_ulp/ulp_matcher.c         |     9 -
 drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |     8 +-
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c      |   141 +-
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.h      |    10 +
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |   135 +-
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h          |     4 +-
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c      |     1 -
 .../ulp_template_db_enum.h                    |   333 +-
 drivers/net/bnxt/tf_ulp/ulp_template_struct.h |     5 +
 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c      |   264 +
 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h      |    40 +
 meson_options.txt                             |     4 +
 93 files changed, 49176 insertions(+), 30599 deletions(-)
 create mode 100644 drivers/net/bnxt/bnxt_compat.h
 create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c
 create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
 delete mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c
 create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
 create mode 100644 drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_defs.h
 rename drivers/net/bnxt/tf_ulp/{generic_templates => }/ulp_template_db_enum.h (88%)
 create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
 create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h

-- 
2.39.5 (Apple Git-154)

