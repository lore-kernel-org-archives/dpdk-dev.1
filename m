Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C20CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 16:30:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5D494026F;
	Thu, 30 Oct 2025 17:30:05 +0100 (CET)
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com
 [209.85.160.100])
 by mails.dpdk.org (Postfix) with ESMTP id 8D50A40150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 17:30:03 +0100 (CET)
Received: by mail-oa1-f100.google.com with SMTP id
 586e51a60fabf-3c9859913d0so883252fac.0
 for <dev@dpdk.org>; Thu, 30 Oct 2025 09:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761841803; x=1762446603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VOfRHTEsgNmh3Ea7weEthLtyKx4fuux9fIP1cfUfPvE=;
 b=BdC5KXT6n9e2eLOiU7Fmoe4+iS/emEJ4C+PUkuU6rBi9yvbtBiORZZkizjzgdIPdgl
 kCHraRqdW2mN6wg9iJPPgc7uChLldDT30sM8+kSS4WZLqRWQUC1rbRZGeLm49dgia57J
 seSGYVtYPqejgTzb+Lga/EpdAW9TB2XuIB+YdTZ7r+fwSzwfgURsq+O+gyMwccCGkN/H
 q3v3hGZWPpvvrR+xjh4Us00btCpXwa96zWjTu7+c6KZtOEcyDhDEZHJ5b4/GSfQLCkqQ
 fRLDT7LuvKToDrXM+x/odKsnUePtgwsItaSpXlDayG8yzp+1SZtnncbnpCLOSyYeQ4fO
 KZmA==
X-Gm-Message-State: AOJu0YzYuWC96G5MoPMHY6sxekzgl+A3xHWJlayJL5Z7ea2x71ypTpeh
 Q759PFO5Xn2OO7YiqW0MPwnN7w8kQcTKIEUZ7FiVRrzcdh/wNUyG/Wtbkl1+Q3LIEPQlo0kebAU
 38JcNQn6+bO2RNW/TYbAaBC2IU0eojBZ4t5eeZac3jjcvBKu8LGCWFdOenm+4ZJL0fp1b0HiodI
 8LSyAI5KmlTUrY68NlEWtcx6SgUSpyC2FwYI1bJkB1+AQcuwRL4Ejsc7CLzZScVeVuOCXT05k=
X-Gm-Gg: ASbGncsoVYtohTjHKEvaxhzXxHftsdC0PU3AmU6e69Z1jN+FJn/6xYHAhEnaNcc03LV
 oskI/AJ+hqUX44iMCjl9nTvKB0qQ90hJMtvIqB78rcwdsl6lxCTxYQp/iHkycmsk5ibKslsVXj9
 wjumN+qVs/CTRvPBppsljH7DyGz0CRU5AoytZs+DUoZ9dDi9DNEa69zgxXWDmu0l/mdL4GLAASy
 fXHK8qqVyxaZhgAR/gmPLjarP7HlNc/zsQuZW+TXxhYVg8cwgX9T23WmpwsHRbDnSvHODHAPhNM
 zrcVvSIZ1YFw8XYhMscwKT/ECPW/uojYDZp+chjsmMyf0A+MgrTkoE7puJiZihoVyVjOCge0ndK
 OqQshqGaMiuZQRGjPY50mZ1j5USZLTnqDe4ZrXChfIv8oZyXGGh60OdP5hS1C4crJUgoqbW+8vQ
 6MNrBuySeC9zECQ6qALiRZr08TmGgwM9N3pBn0XQ==
X-Google-Smtp-Source: AGHT+IHKtcsvZcyMM+UPU5Y5TdDP/rySLD1gfULqHunTzttjjpdo+h+4Gy+sik6w92CuZH3CbcvU3koCfQa7
X-Received: by 2002:a05:6870:d68f:b0:331:2b04:1353 with SMTP id
 586e51a60fabf-3dacc1c3c02mr86748fac.20.1761841802452; 
 Thu, 30 Oct 2025 09:30:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3d1e290e020sm1464796fac.7.2025.10.30.09.30.02
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Oct 2025 09:30:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-818bf399f8aso35113376d6.2
 for <dev@dpdk.org>; Thu, 30 Oct 2025 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761841801; x=1762446601; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VOfRHTEsgNmh3Ea7weEthLtyKx4fuux9fIP1cfUfPvE=;
 b=gvobFqM9mdNXlSdTgOhgx6Q14so8FVQsikfzsBQ1QSrI4Zh3IgsJVeRTlaDYGnrQwc
 Av9BtNj4WXUAwB7CReD1/8cXMrSbTm//YeXihHRHxpcx/fk+PD9pAz0d8l9dShx+Rq70
 EvS4gqV2apgIGKhAoWwZANWdwjkDCa8saZ5HU=
X-Received: by 2002:a05:6214:519c:b0:880:2968:59a7 with SMTP id
 6a1803df08f44-8802f2d6a33mr2688026d6.15.1761841801159; 
 Thu, 30 Oct 2025 09:30:01 -0700 (PDT)
X-Received: by 2002:a05:6214:519c:b0:880:2968:59a7 with SMTP id
 6a1803df08f44-8802f2d6a33mr2687636d6.15.1761841800615; Thu, 30 Oct 2025
 09:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
Date: Thu, 30 Oct 2025 09:29:43 -0700
X-Gm-Features: AWmQ_blKvhZLvaiY7xEqevBQWicOWm2gDkBrKhpxdD1z3K4qdZ8VSFAK32RXucY
Message-ID: <CACZ4nhu=i=ro-U=r5Pek7=2fmS4VodJUsTUdbWZFc=M1GbCH6A@mail.gmail.com>
Subject: Re: [PATCH v5 00/57] bnxt patchset
To: Manish Kurup <manish.kurup@broadcom.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000bd9c47064262c266"
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

--000000000000bd9c47064262c266
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:07=E2=80=AFAM Manish Kurup <manish.kurup@broadcom=
.com> wrote:
>
> Apart from bug fixes, this patchset adds the following
> functionality:
>
> 1. Add the data, defines and enums for applications targeting
>    Wh+, P5, P7 product families.
> 2. Update HSI files (HWRM API defintions, enums, version number)
> 3. Dynamic UPAR support for THOR2.
> 4. Add support to allow multiple instances of applications to
>    exist at the same time.
> 5. Add hot upgrade support for applications.
> 6. Add MPLS packet offload support.
> 7. Improve backing store debug capabilities.
> 8. Add truflow global table scope support.
> 9. ULP parser support to handle GRE key.
>
> v1->v2:
> 1. Fixed typos in commit messages
> 2. Removed incorrect tabs in meson.build
> 3. Fixed ENODATA return value for BSD
> 4. Removed unused function bnxt_mpc_bds_in_hw()
> 5. Fixed questionable pointer cast warning
> 6. Ignoring function argument mispelling warnings
>
> v2->v3:
> 1. Fixed all sprintf format string warnings.
> 2. Fixed additional pointer size warnings.
>
> v3->v4:
> 1. Fixed additional pointer size warnings.
> 2. Split bnxt platform specific app data into multiple commits.
>
> v4->v5:
> 1. Overall patch cleanup consisting of many small aesthetic
>    changes (commit logs).
> 2. Fixed a "macro unused argument" warning.
>
> Please apply.
Patchset merged to dpdk-next-net-brcm repo. Thanks

> Farah Smith (8):
>   net/bnxt/tf_core: thor2 TF table scope sizing adjustments
>   net/bnxt/tf_core: tcam manager logical id free
>   net/bnxt/tf_core: thor2 hot upgrade ungraceful quit crash
>   net/bnxt/tf_core: truflow global table scope
>   net/bnxt/tf_ulp: socket direct enable
>   net/bnxt: Correctly account for udp_tunnel_ports
>   net/bnxt: thor2 truflow memory manager bug
>   net/bnxt/tf_core: truflow SR-IOV PF init cleanup
>
> Jay Ding (4):
>   net/bnxt: bnxt_rep functions cleanup
>   net/bnxt/tf_ulp: add meter stats support for Thor2
>   net/bnxt/tf_core: cleanup lkup table pool calculations
>   next/bnxt/tf_ulp: meter and mac_addr cache cleanup
>
> Kishore Padmanabha (18):
>   net/bnxt: enable vector mode processing
>   net/bnxt/tf_ulp: add support for global identifiers
>   net/bnxt/tf_core: add support for multi instance
>   net/bnxt/tf_core: table scope free cleanup
>   net/bnxt/tf_core: VFR cleanup and stats lockup handling
>   net/bnxt/tf_ulp: increase shared pool size to 32
>   net/bnxt/tf_ulp: add support for tcam priority update
>   net/bnxt/tf_ulp: hot upgrade support
>   net/bnxt/tf_ulp: stats counter memory cleanup
>   net/bnxt: Cleanup max VF calculation for thor2
>   net/bnxt/tf_ulp: enable support for global index table
>   net/bnxt/tf_ulp: optimize template enums
>   net/bnxt/tf_ulp: add non vfr mode capability
>   net/bnxt: Skip stats collection when rx queue inactive
>   net/bnxt: additional rss configuration cleanup
>   net/bnxt: packet drop after port stop and start
>   net/bnxt/tf_ulp: add support for unicast only feature
>   net/bnxt: add support for truflow promiscuous mode
>
> Manish Kurup (9):
>   net/bnxt/tf_ulp: add bnxt platform data for 25.11
>   net/bnxt/tf_ulp: add bnxt app data for 25.11 for Wh+
>   net/bnxt/tf_ulp: add bnxt app data for 25.11 - Thor
>   net/bnxt/tf_ulp: add bnxt app data for 25.11 - Thor2
>   net/bnxt/tf_core: dynamic UPAR support for THOR2
>   net/bnxt: add meson build options for TruFlow
>   net/bnxt: truflow HSI struct definition cleanup
>   net/bnxt/tf_ulp: TF functionality additions
>   net/bnxt/tf_ulp: remove Truflow DEBUG code
>
> Peter Spreadborough (6):
>   net/bnxt/tf_ulp: ovs-dpdk packet drop observed with thor2
>   net/bnxt/tf_core: add backing store debug to dpdk
>   net/bnxt/tf_core: handle out of order MPC completions
>   net/bnxt: avoid potential segfault in VFR handling
>   net/bnxt/tf_core: backing store cleanup
>   net/bnxt/tf_core: remove excessive debug logging
>
> Sangtani Parag Satishbhai (3):
>   net/bnxt/tf_ulp: Cleanup devargs argument parsing code
>   net/bnxt: truflow remove redundant code for mpc init
>   net/bnxt: truflow remove RTE devarg processing for mpc=3D1
>
> Shahaji Bhosle (4):
>   net/bnxt/tf_ulp: ulp parser support to handle gre key
>   net/bnxt/tf_ulp: change rte_mem_virt2iova to rte_mem_virt2phys
>   net/bnxt/tf_ulp: truflow add pf action handler
>   net/bnxt/tf_ulp: add feature bit rx miss handling
>
> Shuanglin Wang (2):
>   net/bnxt/tf_core: Cleanup flow scale option build flags
>   net/bnxt/tf_ulp: support MPLS packets
>
> Smitha Pisupati (1):
>   net/bnxt/tf_ulp: add support for special vxlan
>
> Sriharsha Basavapatna (2):
>   net/bnxt: cleanup default rss config
>   net/bnxt: avoid iova range check when external memory is used
>
>  drivers/net/bnxt/bnxt.h                       |     7 +
>  drivers/net/bnxt/bnxt_ethdev.c                |   256 +-
>  drivers/net/bnxt/bnxt_hwrm.c                  |    25 +-
>  drivers/net/bnxt/bnxt_mpc.c                   |    26 +-
>  drivers/net/bnxt/bnxt_mpc.h                   |     7 +-
>  drivers/net/bnxt/bnxt_reps.c                  |    37 +-
>  drivers/net/bnxt/bnxt_stats.c                 |     5 +
>  drivers/net/bnxt/bnxt_txr.c                   |     5 +-
>  drivers/net/bnxt/bnxt_vnic.c                  |    21 +-
>  .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |    33 +-
>  .../net/bnxt/hcapi/cfa_v3/include/cfa_types.h |    10 +
>  drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c     |    83 +-
>  .../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h    |     2 +-
>  drivers/net/bnxt/hsi_struct_def_dpdk.h        |  1123 +-
>  drivers/net/bnxt/tf_core/cfa_tcam_mgr.c       |    35 +-
>  .../net/bnxt/tf_core/cfa_tcam_mgr_device.h    |     6 +-
>  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c    |     2 +-
>  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c   |     2 +-
>  drivers/net/bnxt/tf_core/tf_resources.c       |     2 +-
>  drivers/net/bnxt/tf_core/tf_util.c            |     2 +
>  drivers/net/bnxt/tf_core/v3/meson.build       |     4 +-
>  drivers/net/bnxt/tf_core/v3/tfc.h             |   238 +-
>  drivers/net/bnxt/tf_core/v3/tfc_act.c         |    47 +-
>  drivers/net/bnxt/tf_core/v3/tfc_cpm.c         |    13 +
>  drivers/net/bnxt/tf_core/v3/tfc_debug.h       |    12 +-
>  drivers/net/bnxt/tf_core/v3/tfc_em.c          |   143 +-
>  drivers/net/bnxt/tf_core/v3/tfc_em.h          |   105 +-
>  drivers/net/bnxt/tf_core/v3/tfc_global_id.c   |    45 +-
>  drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c |   142 +
>  drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c     |    51 +-
>  drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c   |  1411 +
>  drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c   |   565 -
>  drivers/net/bnxt/tf_core/v3/tfc_msg.c         |   363 +-
>  drivers/net/bnxt/tf_core/v3/tfc_msg.h         |    41 +-
>  drivers/net/bnxt/tf_core/v3/tfc_resources.c   |    12 +-
>  drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c   |   246 +-
>  drivers/net/bnxt/tf_core/v3/tfc_tcam.c        |    55 +
>  drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c  |  1875 +
>  drivers/net/bnxt/tf_core/v3/tfc_util.c        |    23 +
>  drivers/net/bnxt/tf_core/v3/tfc_util.h        |    14 +
>  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c   |     3 +-
>  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h   |     4 +-
>  drivers/net/bnxt/tf_core/v3/tfo.c             |   211 +-
>  drivers/net/bnxt/tf_core/v3/tfo.h             |    53 +-
>  drivers/net/bnxt/tf_ulp/bnxt_tf_common.h      |     5 -
>  drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c    |     6 -
>  drivers/net/bnxt/tf_ulp/bnxt_ulp.h            |     6 +
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c       |    10 +
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c      |    55 +-
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c         |    27 +-
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c        |   147 +-
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h        |     5 +
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h      |    82 +-
>  .../generic_templates/ulp_template_db_act.c   |     6 +-
>  .../generic_templates/ulp_template_db_class.c |  8808 ++--
>  .../generic_templates/ulp_template_db_defs.h  |    88 +
>  .../generic_templates/ulp_template_db_field.h |     5 +-
>  .../generic_templates/ulp_template_db_tbl.c   |   267 +-
>  .../ulp_template_db_thor2_act.c               |  4637 +-
>  .../ulp_template_db_thor2_class.c             | 42439 +++++++++-------
>  .../ulp_template_db_thor_act.c                |    14 +-
>  .../ulp_template_db_thor_class.c              | 13247 ++---
>  .../ulp_template_db_wh_plus_act.c             |     2 +-
>  .../ulp_template_db_wh_plus_class.c           |    26 +-
>  drivers/net/bnxt/tf_ulp/meson.build           |    56 +-
>  drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c       |     4 -
>  drivers/net/bnxt/tf_ulp/ulp_def_rules.c       |    38 +-
>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c          |    50 +-
>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h          |    11 +
>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c       |     3 +-
>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c      |    64 +-
>  drivers/net/bnxt/tf_ulp/ulp_flow_db.c         |    10 +-
>  drivers/net/bnxt/tf_ulp/ulp_flow_db.h         |     6 +
>  drivers/net/bnxt/tf_ulp/ulp_gen_hash.c        |     2 +-
>  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c         |    24 +
>  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h         |    12 +
>  drivers/net/bnxt/tf_ulp/ulp_mapper.c          |   326 +-
>  drivers/net/bnxt/tf_ulp/ulp_mapper.h          |    56 +-
>  drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c       |    81 +-
>  drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c      |   347 +-
>  drivers/net/bnxt/tf_ulp/ulp_matcher.c         |     9 -
>  drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |     8 +-
>  drivers/net/bnxt/tf_ulp/ulp_rte_parser.c      |   141 +-
>  drivers/net/bnxt/tf_ulp/ulp_rte_parser.h      |    10 +
>  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |   137 +-
>  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h          |     4 +-
>  drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c      |     1 -
>  .../ulp_template_db_enum.h                    |   333 +-
>  drivers/net/bnxt/tf_ulp/ulp_template_struct.h |     5 +
>  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c      |   264 +
>  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h      |    40 +
>  meson_options.txt                             |     4 +
>  92 files changed, 48710 insertions(+), 30583 deletions(-)
>  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c
>  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
>  delete mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c
>  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
>  create mode 100644 drivers/net/bnxt/tf_ulp/generic_templates/ulp_templat=
e_db_defs.h
>  rename drivers/net/bnxt/tf_ulp/{generic_templates =3D> }/ulp_template_db=
_enum.h (88%)
>  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
>  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h
>
> --
> 2.39.5 (Apple Git-154)
>

--000000000000bd9c47064262c266
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
MYymAUVcWV0wVj6phKCeHUoRXxK4X8pFfsbz0Sjt+EMT/qE/zZE0/2EcCBES5X48iDmzTwTcJ+TD
NOvJwY7xRNwUvbI9EUViKMHPr+tQIeHsuDT0CXRwjzvZrNSssqegLdpnnV24YK5bUiTUw52wxWoh
QTlMtZHRCyQg3RQ6GIJ7KRdR/sPpJmnPBKbgwweDUNv6ZbCxcuTu5mhdtMT7TUSNjCi5aSKn85zv
Xg41ku+Wm1cAeXwZUeZagNjdHHsOFQD1uqLsCsbLsTV8WaqksE8CAwEAAaOCAd4wggHaMA4GA1Ud
DwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNy
dDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2Ey
MDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8E
OjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5j
cmwwJQYDVR0RBB4wHIEaYWppdC5raGFwYXJkZUBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFPJnigXvVxTA
07l8oe1CkMEkw+YLMA0GCSqGSIb3DQEBCwUAA4ICAQBE7rCtjYFJ7tog+ee/1HnzPN4L1J2asifX
LdXeYICQse0kNEfXvUo1ayItAbuJnklmWwlP7IYPQyOlP3mJ4OGjvjuJhGF5d2Eb9iFuO+JW6vwf
EosKt72uSd8homroli/RVma5W2tjKM7kU1HoSnz4rQV0YRWNH7OEzezNOZF7+aTJYJSaUXkK85/9
M1KYO/S8x9Pd2WRn39KIrw1g03sTjiTL/wpEiJNClL4GE/M3YZ6uXciSJX4au5UCWuV8gFtAV0ql
aU36K35Grrc/xmzg6EDqNEDG0A9oTEWwLCTCYfxg+jO2lvpHj6gV+IE31MpZYzlR6/bQSe7NVz0g
yDiC1bPtj2QVqpMvrEi5cmqpI/97cqbsK6Ud7xCvep6oYUJ2QS4RPw0slATdJjSwlb4Uk1Y+xR4b
6FbGm1N40N146szaI8aoV46hcI98/rWIr6kvmxy0wcoYx3U6kYkA/ywFqCXX0BgFNpZX5K8i64D4
E4nhwQjGDbUfMEJyAUr955c7lBXB87fotrW+90jSrpl4vK2qP4+W8ntJTX30iR3NmPyUhBkbnewo
O0GHGnKcLdmowdbU5+n3HjvCoMiKOYbENHxJxar2zM+cPZ3EORk4rAW1TBGLLeZg5Y+5ScQgc5aa
YbbIKKKsxmMaZkoB62zWnWrb2T5WPPLjYcFfjutmoDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMC
QkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2
IFNNSU1FIENBIDIwMjMCDEkL1Rxtyl5iiSFALTANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0B
CQQxIgQgJoqtqmZH6VrvoThpIc8PhZkA7Sd98V0lXzlYklLjAhwwGAYJKoZIhvcNAQkDMQsGCSqG
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMDMwMTYzMDAxWjBcBgkqhkiG9w0BCQ8xTzBNMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3
DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAGKsmDfjVG/RwTDRcFDFYseSPBQo/
sPtnpB2MDaP2RmiXsVftg2qOklxYYx7D0O/rFGByZBn9ChFLXNUQs39oLTKTCi7fZaLUQrIq84Z6
Q9cLuQxo4q2GskUR9tpe5hs+LAXji40yVHErjQ9kXBsFFNodIbijQaA1RYk+y+6dhZ1zW2g5iaba
jhkJIMnyukaAgAN1f7Fdo7Qb3PyLLYJYTBO6GMfZ/hCSjVMyxJeR6qc+Nmyjduazneo2GQIB313K
KBs0UzYNrpEu5QS2gXKjp6v+qOfIlXZ82CM9dbQbXawV1KChgaI1EU3KwrcejJr9F3ZltFpOOCne
OVfx4YDWbg==
--000000000000bd9c47064262c266--
