Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36276CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:07:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B1D04025E;
	Wed, 29 Oct 2025 17:07:36 +0100 (CET)
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by mails.dpdk.org (Postfix) with ESMTP id 148F840150
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:07:35 +0100 (CET)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-78af743c232so81752b3a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754054; x=1762358854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FG0QnB+EwwVnGIq2SkUtmJh00GAdkjslJf6lQV5Fscs=;
 b=RFuqcOQdL5p0r3GeBn4Lb8QEu8L+CfxC/k13TjEP8/PRdJ9yntgiNRhn8EPdAOirhE
 5u+7yG12S9xrVF8fG9NOxAkOk+T83xdZYeNf0OFGonpdYQQZRZjCJ1CM9XUvJcScbwhV
 y51QJnHGndk+zHx9T26uoe2uwqZ0gYapcVRVDZDPpB5L0HW3pJQGjkfoyJ716lY2fjZo
 M/gFPmbNFrWHKMLxrgLehkXk+g/FdCG1upfwNy1doAieHtYtkwvywqK75HhipA+Wc2Ra
 wgY/ZVznej0KW5s0IdFcdUvFWPuO3miac8l0+xgOY/RIRV/0aL66Oc9cESwgckDTTw1z
 fn+Q==
X-Gm-Message-State: AOJu0YxNZgykhLvhcUa1D9ZKzGcox5UQsZtpmF2R9OkNo0c4opb5cQZH
 VevYNIwCTNVZTNk0TcQTLUCbo2EoquFj0LjIi/RT8gBXVg8INme4JWuyCKxZdGPoIoXw5feNqaz
 i9FtPwIyE/OR5x2mOItE9ev38uLiCWWs6sHeltyokAvpRVDw139GI6WzBVrDVCAGb6svAqT7Xyw
 WyRMwqSIc25sE8vNiQvXAnPHV6XfPOIZr5KocFhzq7jzkZN3TYzhG7xVF3teuhdJ+/cBg7uw==
X-Gm-Gg: ASbGncs4WeoNcp2Ktj85DbBJ+0ORcqmiIoQrY7dvFQhGFUoxzRfLW3MK7IIjeJqRlni
 //NFWHzBYcn3AztgNiXn+fyDqGp6lzKn1IkFH4OICjMZUeOOn5Z4iGtSYOOFV5w8R5WKKR9hOjR
 e9jRhosCUYEUVT9QQfUho7qDWWCnjv2lT/ueM6QVA/GQPOdUzeQnb8mivdQc6ezGNsKmTQxxxJ6
 3s4iUNdzG8AJn3fKkGTY5+47asGt1ZQwYnHLptUiV6+E+gpcop5gE67GFNCk+7VnBKLkgOxEvOV
 1D48YLTyH/lXnpaAisXn1BoKiZGzfBbT7uC3fip/2k3o/lq5mxnVisZ93L1BIZpT76CyxJ6frA0
 fmYNLLCEIAaSxrILEASiNsq3zcVxZvVwEat9D7eAGRqfIDHZ5ohXWcw3Mlkirp8v8nSWYzDJhpk
 qJh/cMuA+yKgzHWLYACPOoRi5Mat+XikDfkyq9
X-Google-Smtp-Source: AGHT+IEHM0rSmyRVpXSQA765LRKm47z+jAf7mcHexUGASGD514lo5+F1DutqUWMrcNwRQkdAX2/fuXOCXkNY
X-Received: by 2002:a05:6a00:987:b0:7a2:6b48:5351 with SMTP id
 d2e1a72fcca58-7a4e2dfb60amr3961202b3a.8.1761754053956; 
 Wed, 29 Oct 2025 09:07:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-7a41408a4ddsm1067750b3a.5.2025.10.29.09.07.33
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:07:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a0aa0df911so1303854585a.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754052; x=1762358852; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FG0QnB+EwwVnGIq2SkUtmJh00GAdkjslJf6lQV5Fscs=;
 b=MlKG2qrjy8x9Xptd0QTCockmZNT/QOkNvr28erFAs/7ZGiAl1hrxaHS0kd3V6RRpwk
 nRXtxcWZLWzhYbn+aJJQICMTV+TM02yrV6AfhNIsH4Q9bo8bhMcd1Fc6XRoSqUZGL1SX
 lOA9TOmhA4h/6mTI7+UjONK0sogPY35YnZ9BY=
X-Received: by 2002:a05:620a:40c6:b0:892:ce2b:f84d with SMTP id
 af79cd13be357-8a8ed72d388mr452648685a.33.1761754050384; 
 Wed, 29 Oct 2025 09:07:30 -0700 (PDT)
X-Received: by 2002:a05:620a:40c6:b0:892:ce2b:f84d with SMTP id
 af79cd13be357-8a8ed72d388mr452640085a.33.1761754049670; 
 Wed, 29 Oct 2025 09:07:29 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.07.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:07:29 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v5 00/57] bnxt patchset
Date: Wed, 29 Oct 2025 12:06:15 -0400
Message-Id: <20251029160712.58519-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

1. Add the data, defines and enums for applications targeting
   Wh+, P5, P7 product families.
2. Update HSI files (HWRM API defintions, enums, version number)
3. Dynamic UPAR support for THOR2.
4. Add support to allow multiple instances of applications to
   exist at the same time.
5. Add hot upgrade support for applications.
6. Add MPLS packet offload support.
7. Improve backing store debug capabilities.
8. Add truflow global table scope support.
9. ULP parser support to handle GRE key.

v1->v2:
1. Fixed typos in commit messages
2. Removed incorrect tabs in meson.build
3. Fixed ENODATA return value for BSD
4. Removed unused function bnxt_mpc_bds_in_hw()
5. Fixed questionable pointer cast warning
6. Ignoring function argument mispelling warnings

v2->v3:
1. Fixed all sprintf format string warnings.
2. Fixed additional pointer size warnings.

v3->v4:
1. Fixed additional pointer size warnings.
2. Split bnxt platform specific app data into multiple commits.

v4->v5:
1. Overall patch cleanup consisting of many small aesthetic
   changes (commit logs).
2. Fixed a "macro unused argument" warning.

Please apply.
Farah Smith (8):
  net/bnxt/tf_core: thor2 TF table scope sizing adjustments
  net/bnxt/tf_core: tcam manager logical id free
  net/bnxt/tf_core: thor2 hot upgrade ungraceful quit crash
  net/bnxt/tf_core: truflow global table scope
  net/bnxt/tf_ulp: socket direct enable
  net/bnxt: Correctly account for udp_tunnel_ports
  net/bnxt: thor2 truflow memory manager bug
  net/bnxt/tf_core: truflow SR-IOV PF init cleanup

Jay Ding (4):
  net/bnxt: bnxt_rep functions cleanup
  net/bnxt/tf_ulp: add meter stats support for Thor2
  net/bnxt/tf_core: cleanup lkup table pool calculations
  next/bnxt/tf_ulp: meter and mac_addr cache cleanup

Kishore Padmanabha (18):
  net/bnxt: enable vector mode processing
  net/bnxt/tf_ulp: add support for global identifiers
  net/bnxt/tf_core: add support for multi instance
  net/bnxt/tf_core: table scope free cleanup
  net/bnxt/tf_core: VFR cleanup and stats lockup handling
  net/bnxt/tf_ulp: increase shared pool size to 32
  net/bnxt/tf_ulp: add support for tcam priority update
  net/bnxt/tf_ulp: hot upgrade support
  net/bnxt/tf_ulp: stats counter memory cleanup
  net/bnxt: Cleanup max VF calculation for thor2
  net/bnxt/tf_ulp: enable support for global index table
  net/bnxt/tf_ulp: optimize template enums
  net/bnxt/tf_ulp: add non vfr mode capability
  net/bnxt: Skip stats collection when rx queue inactive
  net/bnxt: additional rss configuration cleanup
  net/bnxt: packet drop after port stop and start
  net/bnxt/tf_ulp: add support for unicast only feature
  net/bnxt: add support for truflow promiscuous mode

Manish Kurup (9):
  net/bnxt/tf_ulp: add bnxt platform data for 25.11
  net/bnxt/tf_ulp: add bnxt app data for 25.11 for Wh+
  net/bnxt/tf_ulp: add bnxt app data for 25.11 - Thor
  net/bnxt/tf_ulp: add bnxt app data for 25.11 - Thor2
  net/bnxt/tf_core: dynamic UPAR support for THOR2
  net/bnxt: add meson build options for TruFlow
  net/bnxt: truflow HSI struct definition cleanup
  net/bnxt/tf_ulp: TF functionality additions
  net/bnxt/tf_ulp: remove Truflow DEBUG code

Peter Spreadborough (6):
  net/bnxt/tf_ulp: ovs-dpdk packet drop observed with thor2
  net/bnxt/tf_core: add backing store debug to dpdk
  net/bnxt/tf_core: handle out of order MPC completions
  net/bnxt: avoid potential segfault in VFR handling
  net/bnxt/tf_core: backing store cleanup
  net/bnxt/tf_core: remove excessive debug logging

Sangtani Parag Satishbhai (3):
  net/bnxt/tf_ulp: Cleanup devargs argument parsing code
  net/bnxt: truflow remove redundant code for mpc init
  net/bnxt: truflow remove RTE devarg processing for mpc=1

Shahaji Bhosle (4):
  net/bnxt/tf_ulp: ulp parser support to handle gre key
  net/bnxt/tf_ulp: change rte_mem_virt2iova to rte_mem_virt2phys
  net/bnxt/tf_ulp: truflow add pf action handler
  net/bnxt/tf_ulp: add feature bit rx miss handling

Shuanglin Wang (2):
  net/bnxt/tf_core: Cleanup flow scale option build flags
  net/bnxt/tf_ulp: support MPLS packets

Smitha Pisupati (1):
  net/bnxt/tf_ulp: add support for special vxlan

Sriharsha Basavapatna (2):
  net/bnxt: cleanup default rss config
  net/bnxt: avoid iova range check when external memory is used

 drivers/net/bnxt/bnxt.h                       |     7 +
 drivers/net/bnxt/bnxt_ethdev.c                |   256 +-
 drivers/net/bnxt/bnxt_hwrm.c                  |    25 +-
 drivers/net/bnxt/bnxt_mpc.c                   |    26 +-
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
 drivers/net/bnxt/tf_core/v3/meson.build       |     4 +-
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
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |   137 +-
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h          |     4 +-
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c      |     1 -
 .../ulp_template_db_enum.h                    |   333 +-
 drivers/net/bnxt/tf_ulp/ulp_template_struct.h |     5 +
 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c      |   264 +
 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h      |    40 +
 meson_options.txt                             |     4 +
 92 files changed, 48710 insertions(+), 30583 deletions(-)
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

