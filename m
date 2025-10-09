Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89020CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:11:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68AD44027A;
	Fri, 10 Oct 2025 00:11:44 +0200 (CEST)
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com
 [209.85.128.228])
 by mails.dpdk.org (Postfix) with ESMTP id 715AD4014F
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:11:43 +0200 (CEST)
Received: by mail-yw1-f228.google.com with SMTP id
 00721157ae682-7501c24a731so18634447b3.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760047902; x=1760652702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xt0gQfSIoHOyyXXQK5s8JH+QynBpVgMqQJ6QuIg8t5o=;
 b=DMiRF6cGArVIBq52FjPLWmpYrTIghgTNStfK2P6oySOtPfk5jjr3WIvpwIls7G2QCA
 BC6ZbYWFT8lbuGWMamc1j7eZi4Hl5j8tthY4YUmxLKaKd6x5g/A2zVULFoBl6ShhRH3p
 IjwS4BcbigBOjYtiGNwd8ZHx/NS43UlFUrieBrmSafUcDQeq/XWHxJKXSYhElHbhIMr0
 9ngY/1qJr8qEcKQsEmu1sQMbM/8TBR9RZFvNAs9LqeYTq8b6XvsiY3YiZgI0qaZAklxQ
 L01AsXCrjHGFhIWrB3miVRO8FdSoSh7D3lRtRWm8ljqadGHgwBPcPwtwx+PauhGfHcQn
 Jerw==
X-Gm-Message-State: AOJu0YycFhrzsOHEmtegFs+4tbeSq7pm7cP47EZCFbt0JXu9Ar+w/HcJ
 r8BDrOqmZVAnvLJk75iiLDoL1tybsdY0ukCQi3mKAilYJGmVg6sWyPlPaPqI//IyLyLTUMsLmHY
 XZ/cXtUiHGmhYGl4hDLbNGjW5a9xqIhQMfRkr/Cdcyfed8slnA9JALlobgFq05A+a+JnpQbZtsQ
 8ubCeEAgDLl+Afmt/a4UQ0nVyXEdhVt+VTM3V4d/WlJHugZgywVrO+A8z9WfPv3p0QTfacNQ==
X-Gm-Gg: ASbGncu/6gKqRhdVLS9rS4UE4+/Hx5+Db6mRWexGi6lqSl6lSAln+k7rHvN5cv6jcKe
 QCeYftdde8Smg3t751KOvysa4CVvZ7RB9EpVTcVArAPehtfYkQVm2Lb7UxlX9MRyumejf97qxHM
 W7dpqYcrsynaStG7EeTnJptJtVIax+88X7z3Qnl2/WB6MkeGo4gn8LwmOVDIW38yj9JglsZeQng
 jKRwd6Xplc/o5ag+9o6fAhITX6s7JoBs+eKtilPkueAbZHHZm5B69a/9Y8ze66dfe7Qox6LOcJy
 IUg+gzCDO1loaH37Sz+Q4DZsS/nS6kny4agaGqkD74T5xyztGyvGLqQ7W34ZNv6vR887aFXrK4k
 frHPN6KVa/kzCgiRk8oY6T6qmmpiLvdPBFQst/r80IFsUwxpPh5IunnJ/IEG6Jv+GUxPOHlkaxE
 LDQFqY
X-Google-Smtp-Source: AGHT+IHs7z1jlVh8drkovnqhX0CcfdlL/NNe07sQV1zUyMX8/VzmQMLhjOJpcwUoUgj9H7pAYDsnAniOUJWT
X-Received: by 2002:a05:690c:6702:b0:77f:a47e:e7c7 with SMTP id
 00721157ae682-780e15f62e1mr109127537b3.49.1760047902436; 
 Thu, 09 Oct 2025 15:11:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-78106d47ac5sm406657b3.10.2025.10.09.15.11.42
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:11:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4dfc05dec2fso82351821cf.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760047901; x=1760652701; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xt0gQfSIoHOyyXXQK5s8JH+QynBpVgMqQJ6QuIg8t5o=;
 b=NEujgvC5mHLURReUGSsUfuYtdwSSHekSzGKBxZYU/B/uhEDTnovteECCYJ+j0P8V4f
 Pj5TVCqY26qEXnIzxEJbXj/YYBeOZntyIx19Je3rOjEyQOc1OYyrvb6GtrQnFW96eYX3
 WMno65IS5l11GfzyRkciheIaUM//JTt2YE3ig=
X-Received: by 2002:a05:6214:130e:b0:81b:23d:55a8 with SMTP id
 6a1803df08f44-87b2ef70553mr112414046d6.59.1760047901092; 
 Thu, 09 Oct 2025 15:11:41 -0700 (PDT)
X-Received: by 2002:a05:6214:130e:b0:81b:23d:55a8 with SMTP id
 6a1803df08f44-87b2ef70553mr112413656d6.59.1760047900482; 
 Thu, 09 Oct 2025 15:11:40 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.11.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:11:39 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v2 00/54] bnxt patchset
Date: Thu,  9 Oct 2025 18:10:35 -0400
Message-Id: <20251009221129.28256-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
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

v1->v2:
1. Fixed typos in commit messages
2. Removed incorrect tabs in meson.build
3. Fixed ENODATA return value for BSD
4. Removed unused function bnxt_mpc_bds_in_hw()
5. Fixed questionable pointer cast warning
6. Ignoring function argument mispelling warnings

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

