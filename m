Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AC1CCD1BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 16:15:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A6B240262;
	Wed, 22 Oct 2025 18:15:48 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 5E37E4025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:15:46 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-28a5b8b12a1so71546415ad.0
 for <dev@dpdk.org>; Wed, 22 Oct 2025 09:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761149745; x=1761754545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WmUuNHFp0fpxq2pzSYG9A20QU7KYDY99YWdOVVmzvKo=;
 b=oayiPMDq8MJjqq6tFHco5Exb+vo+mhi0g0+B/cisyIyMthAvdyo/+EgKrzQRyp3tVY
 u2a8U3d/DPtT3gYqcF0oVIPANw4rweoh79I7f75oRw4sA33UFWTUa/AKe6oDolbt3ehA
 D1n3k6DxDA+DEu1oFDIxznTGiIEiVww6C0b1PVW+dx9zKoG82ZnuAACCkTuo2f4uyoBg
 7iMcSZNYJw7kpy3kAAFlsXtMq4F1Kr0avV4ikz2t0kvqDKduqiear8l4jt33385d7VI6
 jRYgCUtoWtrjy7MmJ2ZodU0b0p6qOIDeAY6V7f3ucSBGyW1oqSb9qFePmTAAYPm7kqsW
 T+xg==
X-Gm-Message-State: AOJu0YzIR8VELQKtP8Om4+pCfkNF0g45fvOMBfWDWd/xfJpw+az1Zpl4
 XtQeI995qIlMekLz0nZPVC+CY3riSzqWasenRT7OXJhrJrPhq7wyv113dN1HNeLGaucj8Dt5X/v
 xMe5tbK0lgk7DUXWaRR0vj16UuMkoNB+Ehyf0O/HyGcGU4GiG6jXfkzym/+KSZzLiF1FoT84LNA
 S6xDqTldurLMNeJjU1ecdpyCpwSwCKtJkdVamLfniB4d39Rr1mOZ+p21gpMhan8NDHKyIu4w==
X-Gm-Gg: ASbGnct9NzJaqKdg1TMNO4kNDvbGzw6qGuc78LInWeH5muN+z+D9dSE1Nv12vhCvqEx
 yooGDFDmx+mZ9gmHA7VifnbeOM0UD5QSZiFAOLVZ5rlkwiyJ1P/rhNUThfnz9mqQ5OcrmVXXG6W
 6xYL/1a+TVpfY6QE0jpeeLShBInrAilL55igLldjgBQpU6PACSagZyZOPF2UdIPq1U0KuH5VNQD
 JTpvSxKDYhlXnzvu1NlcrCiOpEvm/RsEmsMgdotbRfCGDx9HVXTGF/PjjCvF8Kq721nKln2SUvT
 ghemnHLfZqO5GAq9CSmeJ8ByTzMe2cgiJKtXV79lavAA8xrn2bwLAdHI3A19OPKJWo9O7lnb2lG
 dPb3Tunzrx2otupePTFpJHDLDv3g9f9JQb7X9nzT+DfpCvlvRg8fDMz6atiIO/It5IibrzD+FX8
 ujyqATqbeaJNwjRJ4TM2Ur9GhA5gXhrPxvFQ==
X-Google-Smtp-Source: AGHT+IFOQJrGhBHl/g4P6VLJF72wsCYP0qmJ8Jwr22GV4RzuMRSCE8Ww2AykWlcDghxGeyzIGLhovgbWu+p9
X-Received: by 2002:a17:902:e841:b0:290:c902:759 with SMTP id
 d9443c01a7336-290ccab6c0amr221511685ad.51.1761149745082; 
 Wed, 22 Oct 2025 09:15:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-293108dbcaesm1540355ad.14.2025.10.22.09.15.44
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Oct 2025 09:15:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-63e0da26ae3so7916275d50.0
 for <dev@dpdk.org>; Wed, 22 Oct 2025 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761149744; x=1761754544; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WmUuNHFp0fpxq2pzSYG9A20QU7KYDY99YWdOVVmzvKo=;
 b=dyRW6iK/LtaqDBN5dRh1/mN6fcGb6vhx6uXa3+vDTU/207HAI9/l/PJExFQQmLyfkN
 vBCCBEblgomECIwdb9Pbnt/jzp57AtO7/Mee4mJ9xrq8faXcTx3+RRbMpvysll32gjR4
 8WSY0rAehab0cfCZnxuJI6EyA9qiZvpKPM1BM=
X-Received: by 2002:a05:690e:1514:b0:63f:2b69:9a32 with SMTP id
 956f58d0204a3-63f2b699d2cmr2274274d50.63.1761149743870; 
 Wed, 22 Oct 2025 09:15:43 -0700 (PDT)
X-Received: by 2002:a05:690e:1514:b0:63f:2b69:9a32 with SMTP id
 956f58d0204a3-63f2b699d2cmr2274247d50.63.1761149743332; Wed, 22 Oct 2025
 09:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
 <CAEKskBVy9_N0MuS0HkSoG=jnR0om3nJHxQEMFvChSu-dVVV0Cg@mail.gmail.com>
In-Reply-To: <CAEKskBVy9_N0MuS0HkSoG=jnR0om3nJHxQEMFvChSu-dVVV0Cg@mail.gmail.com>
From: Manish Kurup <manish.kurup@broadcom.com>
Date: Wed, 22 Oct 2025 12:15:29 -0400
X-Gm-Features: AS18NWDj_oi2A98XQKYEs8qAKrMZEvGHtiC208PSCTQpvm9G6ZYThHoGvuP24QQ
Message-ID: <CAEKskBXG90f8nUc+yHGgJfPMkFkudD0_id5NQiQVm09WJkqb5A@mail.gmail.com>
Subject: Re: [PATCH v4 00/57] bnxt patchset
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, ajit.khaparde@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000e77e9a0641c1a003"
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

--000000000000e77e9a0641c1a003
Content-Type: multipart/alternative; boundary="000000000000d918e00641c1a077"

--000000000000d918e00641c1a077
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:17=E2=80=AFPM Manish Kurup <manish.kurup@broadcom=
.com>
wrote:

> On Tue, Oct 21, 2025 at 1:50=E2=80=AFPM Manish Kurup <manish.kurup@broadc=
om.com>
> wrote:
>
>> Apart from bug fixes, this patchset adds the following
>> functionality:
>>
>> 1. Add the data, defines and enums for applications targeting
>>    Wh+, P5, P7 product families.
>> 2. Update HSI files (HWRM API defintions, enums, version number)
>> 3. Dynamic UPAR support for THOR2.
>> 4. Add support to allow multiple instances of applications to
>>    exist at the same time.
>> 5. Add hot upgrade support for applications.
>> 6. Add MPLS packet offload support.
>> 7. Improve backing store debug capabilities.
>> 8. Add truflow global table scope support.
>> 9. ULP parser support to handle GRE key.
>>
>> v1->v2:
>> 1. Fixed typos in commit messages
>> 2. Removed incorrect tabs in meson.build
>> 3. Fixed ENODATA return value for BSD
>> 4. Removed unused function bnxt_mpc_bds_in_hw()
>> 5. Fixed questionable pointer cast warning
>> 6. Ignoring function argument mispelling warnings
>>
>> v2->v3:
>> 1. Fixed all sprintf format string warnings.
>> 2. Fixed additional pointer size warnings.
>>
>> v3->v4:
>> 1. Fixed additional pointer size warnings.
>> 2. Split bnxt platform specific app data into multiple commits.
>>
>> Please apply.
>>
>>
> Hi Stephen,
Thanks for allowing patches 03/57 and 04/57 through!

I noticed one more build failure that is the result of me breaking up patch
e-mailing.

Patch 31/57 (Support MPLS packets) is failing build because it depends on
common options that were added as part of patch 48/57 (meson.build options)=
.

Ajit/Stephen, is there a way we could kick off a rebuild now that all
patches are in?

Thanks a lot!


> Hi Stephen,
>
> There were a couple of issues uploading this patchset:
> 1. I broke up the really large commit into 4 smaller ones (1 for platform
> common defines and 3 platform/chip specific ones), #1 and #2 were
> acceptable sizes, but #3 and #4 were still too big, and they are being he=
ld
> awaiting moderator approval. Could you please let them through?
> 2. I had to retry "git send-email" a few times to get all the patches
> through. I kept getting error messages saying that I was sending patches
> beyond what rate was acceptable.
>
> The patches have all been uploaded, but I dont see them in patchwork, jus=
t
> the 1st 31 that went through fine.
>
> Could you please help?
>
> Thanks, regards,
>
> -Manish
>
>
>
>> Farah Smith (8):
>>   net/bnxt/tf_core: thor2 TF table scope sizing adjustments
>>   net/bnxt/tf_core: tcam manager logical id free
>>   net/bnxt/tf_core: thor2 hot upgrade ungraceful quit crash
>>   net/bnxt/tf_core: truflow global table scope
>>   net/bnxt/tf_ulp: socket direct enable
>>   net/bnxt: fix adding udp_tunnel_port
>>   net/bnxt: thor2 truflow memory manager bug
>>   net/bnxt/tf_core: fix truflow PF init failure on sriov disabled
>>
>> Jay Ding (4):
>>   net/bnxt: fix a NULL pointer dereference in bnxt_rep funcs
>>   net/bnxt/tf_ulp: add meter stats support for Thor2
>>   net/bnxt/tf_core: fix the miscalculation of the lkup table pool
>>   next/bnxt/tf_ulp: truflow fixes for meter and mac_addr cache
>>
>> Kishore Padmanabha (18):
>>   net/bnxt: enable vector mode processing
>>   net/bnxt/tf_ulp: add support for global identifiers
>>   net/bnxt/tf_core: add support for multi instance
>>   net/bnxt/tf_core: fix table scope free
>>   net/bnxt/tf_core: fix vfr clean up and stats lockup
>>   net/bnxt/tf_ulp: increase shared pool size to 32
>>   net/bnxt/tf_ulp: add support for tcam priority update
>>   net/bnxt/tf_ulp: hot upgrade support
>>   net/bnxt/tf_ulp: fix stats counter memory initialization
>>   net/bnxt: fix max VFs count for thor2
>>   net/bnxt/tf_ulp: enable support for global index table
>>   net/bnxt/tf_ulp: optimize template enums
>>   net/bnxt/tf_ulp: add non vfr mode capability
>>   net/bnxt: fix stats collection when rx queue is not set
>>   net/bnxt: fix rss configuration when set to none
>>   net/bnxt: packet drop after port stop and start
>>   net/bnxt/tf_ulp: add support for unicast only feature
>>   net/bnxt: add support for truflow promiscuous mode
>>
>> Manish Kurup (9):
>>   net/bnxt/tf_ulp: add bnxt platform data for 25.11
>>   net/bnxt/tf_ulp: add bnxt app data for 25.11 for Wh+
>>   net/bnxt/tf_ulp: add bnxt app data for 25.11 - Thor
>>   net/bnxt/tf_ulp: add bnxt app data for 25.11 - Thor2
>>   net/bnxt/tf_core: dynamic UPAR support for THOR2
>>   net/bnxt: add meson build options for TruFlow
>>   net/bnxt: truflow HSI struct fixes
>>   net/bnxt/tf_ulp: fixes to enable TF functionality
>>   net/bnxt/tf_ulp: remove Truflow DEBUG code
>>
>> Peter Spreadborough (6):
>>   net/bnxt/tf_ulp: ovs-dpdk packet drop observed with thor2
>>   net/bnxt/tf_core: add backing store debug to dpdk
>>   net/bnxt/tf_core: handle out of order MPC completions
>>   net/bnxt: avoid potential segfault in VFR handling
>>   net/bnxt/tf_core: fix truflow crash on memory allocation failure
>>   net/bnxt/tf_core: remove excessive debug logging
>>
>> Sangtani Parag Satishbhai (3):
>>   net/bnxt/tf_ulp: fix seg fault when devargs argument missing
>>   net/bnxt: truflow remove redundant code for mpc init
>>   net/bnxt: truflow remove RTE devarg processing for mpc=3D1
>>
>> Shahaji Bhosle (4):
>>   net/bnxt/tf_ulp: ulp parser support to handle gre key
>>   net/bnxt/tf_ulp: change rte_mem_virt2iova to rte_mem_virt2phys
>>   net/bnxt/tf_ulp: truflow add pf action handler
>>   net/bnxt/tf_ulp: add feature bit rx miss handling
>>
>> Shuanglin Wang (2):
>>   net/bnxt/tf_core: fix build failure with flow scale option
>>   net/bnxt/tf_ulp: support MPLS packets
>>
>> Smitha Pisupati (1):
>>   net/bnxt/tf_ulp: add support for special vxlan
>>
>> Sriharsha Basavapatna (2):
>>   net/bnxt: fix default rss config
>>   net/bnxt: avoid iova range check when external memory is used
>>
>>  drivers/net/bnxt/bnxt.h                       |     7 +
>>  drivers/net/bnxt/bnxt_ethdev.c                |   256 +-
>>  drivers/net/bnxt/bnxt_hwrm.c                  |    25 +-
>>  drivers/net/bnxt/bnxt_mpc.c                   |    26 +-
>>  drivers/net/bnxt/bnxt_mpc.h                   |     7 +-
>>  drivers/net/bnxt/bnxt_reps.c                  |    37 +-
>>  drivers/net/bnxt/bnxt_stats.c                 |     5 +
>>  drivers/net/bnxt/bnxt_txr.c                   |     5 +-
>>  drivers/net/bnxt/bnxt_vnic.c                  |    21 +-
>>  .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |    33 +-
>>  .../net/bnxt/hcapi/cfa_v3/include/cfa_types.h |    10 +
>>  drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c     |    83 +-
>>  .../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h    |     2 +-
>>  drivers/net/bnxt/hsi_struct_def_dpdk.h        |  1123 +-
>>  drivers/net/bnxt/tf_core/cfa_tcam_mgr.c       |    35 +-
>>  .../net/bnxt/tf_core/cfa_tcam_mgr_device.h    |     6 +-
>>  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c    |     2 +-
>>  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c   |     2 +-
>>  drivers/net/bnxt/tf_core/tf_resources.c       |     2 +-
>>  drivers/net/bnxt/tf_core/tf_util.c            |     2 +
>>  drivers/net/bnxt/tf_core/v3/meson.build       |     4 +-
>>  drivers/net/bnxt/tf_core/v3/tfc.h             |   238 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_act.c         |    47 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_cpm.c         |    13 +
>>  drivers/net/bnxt/tf_core/v3/tfc_debug.h       |    12 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_em.c          |   143 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_em.h          |   105 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_global_id.c   |    45 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c |   142 +
>>  drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c     |    51 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c   |  1411 +
>>  drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c   |   565 -
>>  drivers/net/bnxt/tf_core/v3/tfc_msg.c         |   363 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_msg.h         |    41 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_resources.c   |    12 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c   |   246 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_tcam.c        |    55 +
>>  drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c  |  1875 +
>>  drivers/net/bnxt/tf_core/v3/tfc_util.c        |    23 +
>>  drivers/net/bnxt/tf_core/v3/tfc_util.h        |    14 +
>>  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c   |     3 +-
>>  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h   |     4 +-
>>  drivers/net/bnxt/tf_core/v3/tfo.c             |   211 +-
>>  drivers/net/bnxt/tf_core/v3/tfo.h             |    53 +-
>>  drivers/net/bnxt/tf_ulp/bnxt_tf_common.h      |     5 -
>>  drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c    |     6 -
>>  drivers/net/bnxt/tf_ulp/bnxt_ulp.h            |     6 +
>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c       |    10 +
>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c      |    55 +-
>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c         |    27 +-
>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c        |   147 +-
>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h        |     5 +
>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h      |    82 +-
>>  .../generic_templates/ulp_template_db_act.c   |     6 +-
>>  .../generic_templates/ulp_template_db_class.c |  8808 ++--
>>  .../generic_templates/ulp_template_db_defs.h  |    88 +
>>  .../generic_templates/ulp_template_db_field.h |     5 +-
>>  .../generic_templates/ulp_template_db_tbl.c   |   267 +-
>>  .../ulp_template_db_thor2_act.c               |  4637 +-
>>  .../ulp_template_db_thor2_class.c             | 42439 +++++++++-------
>>  .../ulp_template_db_thor_act.c                |    14 +-
>>  .../ulp_template_db_thor_class.c              | 13247 ++---
>>  .../ulp_template_db_wh_plus_act.c             |     2 +-
>>  .../ulp_template_db_wh_plus_class.c           |    26 +-
>>  drivers/net/bnxt/tf_ulp/meson.build           |    56 +-
>>  drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c       |     4 -
>>  drivers/net/bnxt/tf_ulp/ulp_def_rules.c       |    38 +-
>>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c          |    50 +-
>>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h          |    11 +
>>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c       |     3 +-
>>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c      |    64 +-
>>  drivers/net/bnxt/tf_ulp/ulp_flow_db.c         |    10 +-
>>  drivers/net/bnxt/tf_ulp/ulp_flow_db.h         |     6 +
>>  drivers/net/bnxt/tf_ulp/ulp_gen_hash.c        |     2 +-
>>  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c         |    24 +
>>  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h         |    12 +
>>  drivers/net/bnxt/tf_ulp/ulp_mapper.c          |   326 +-
>>  drivers/net/bnxt/tf_ulp/ulp_mapper.h          |    56 +-
>>  drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c       |    81 +-
>>  drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c      |   347 +-
>>  drivers/net/bnxt/tf_ulp/ulp_matcher.c         |     9 -
>>  drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |     8 +-
>>  drivers/net/bnxt/tf_ulp/ulp_rte_parser.c      |   141 +-
>>  drivers/net/bnxt/tf_ulp/ulp_rte_parser.h      |    10 +
>>  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |   137 +-
>>  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h          |     4 +-
>>  drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c      |     1 -
>>  .../ulp_template_db_enum.h                    |   333 +-
>>  drivers/net/bnxt/tf_ulp/ulp_template_struct.h |     5 +
>>  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c      |   264 +
>>  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h      |    40 +
>>  meson_options.txt                             |     4 +
>>  92 files changed, 48710 insertions(+), 30583 deletions(-)
>>  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c
>>  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
>>  delete mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c
>>  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
>>  create mode 100644
>> drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_defs.h
>>  rename drivers/net/bnxt/tf_ulp/{generic_templates =3D>
>> }/ulp_template_db_enum.h (88%)
>>  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
>>  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h
>>
>> --
>> 2.39.5 (Apple Git-154)
>>
>>
>
> --
> ;) Manish (x1380)
>


--=20
;) Manish (x1380)

--000000000000d918e00641c1a077
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:tahoma,sans-serif"><br></div></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 21,=
 2025 at 8:17=E2=80=AFPM Manish Kurup &lt;<a href=3D"mailto:manish.kurup@br=
oadcom.com">manish.kurup@broadcom.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div=
 style=3D"font-family:tahoma,sans-serif"><span style=3D"font-family:Arial,H=
elvetica,sans-serif">On Tue, Oct 21, 2025 at 1:50=E2=80=AFPM Manish Kurup &=
lt;<a href=3D"mailto:manish.kurup@broadcom.com" target=3D"_blank">manish.ku=
rup@broadcom.com</a>&gt; wrote:</span></div></div><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Apart from bug fixes, t=
his patchset adds the following<br>
functionality:<br>
<br>
1. Add the data, defines and enums for applications targeting<br>
=C2=A0 =C2=A0Wh+, P5, P7 product families.<br>
2. Update HSI files (HWRM API defintions, enums, version number)<br>
3. Dynamic UPAR support for THOR2.<br>
4. Add support to allow multiple instances of applications to<br>
=C2=A0 =C2=A0exist at the same time.<br>
5. Add hot upgrade support for applications.<br>
6. Add MPLS packet offload support.<br>
7. Improve backing store debug capabilities.<br>
8. Add truflow global table scope support.<br>
9. ULP parser support to handle GRE key.<br>
<br>
v1-&gt;v2:<br>
1. Fixed typos in commit messages<br>
2. Removed incorrect tabs in meson.build<br>
3. Fixed ENODATA return value for BSD<br>
4. Removed unused function bnxt_mpc_bds_in_hw()<br>
5. Fixed questionable pointer cast warning<br>
6. Ignoring function argument mispelling warnings<br>
<br>
v2-&gt;v3:<br>
1. Fixed all sprintf format string warnings.<br>
2. Fixed additional pointer size warnings.<br>
<br>
v3-&gt;v4:<br>
1. Fixed additional pointer size warnings.<br>
2. Split bnxt platform specific app data into multiple commits.<br>
<br>
Please apply.<br>
<br></blockquote><div><br></div></div></div></blockquote><div><span class=
=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Hi Stephen,</spa=
n></div><div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-=
serif"></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-=
serif">Thanks for allowing patches 03/57 and 04/57 through!</div><div class=
=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br></div><div c=
lass=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">I noticed on=
e more build failure that is the result of me breaking up patch e-mailing.<=
/div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><=
br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-seri=
f">Patch 31/57 (Support MPLS packets) is failing build because it depends o=
n common options that were added as part of patch 48/57 (meson.build option=
s).<br><br></div><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Ajit/Stephen, is there a way we could kick off a rebuild now tha=
t all patches are in?</div><div class=3D"gmail_default" style=3D"font-famil=
y:tahoma,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:tahoma,sans-serif">Thanks a lot!<br>=C2=A0</div></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quo=
te"><div></div><div><div style=3D"font-family:tahoma,sans-serif">Hi Stephen=
,</div><div style=3D"font-family:tahoma,sans-serif"><br></div><div style=3D=
"font-family:tahoma,sans-serif">There were a couple of issues uploading thi=
s patchset:</div><div style=3D"font-family:tahoma,sans-serif">1. I broke up=
 the really large commit into 4 smaller ones (1 for platform common defines=
 and 3 platform/chip specific ones), #1 and #2 were acceptable sizes, but #=
3 and #4 were still too big, and they are being held awaiting moderator app=
roval. Could you please let them through?</div><div style=3D"font-family:ta=
homa,sans-serif">2. I had to retry &quot;git send-email&quot; a few times t=
o get all the patches through. I kept getting error messages saying that I =
was sending patches beyond what rate was acceptable.</div><div style=3D"fon=
t-family:tahoma,sans-serif"><br></div><div style=3D"font-family:tahoma,sans=
-serif">The patches have all been uploaded, but I dont=C2=A0see them in pat=
chwork, just the 1st 31 that went through fine.</div><div style=3D"font-fam=
ily:tahoma,sans-serif"><br></div><div style=3D"font-family:tahoma,sans-seri=
f">Could you please help?</div><div style=3D"font-family:tahoma,sans-serif"=
><br></div><div style=3D"font-family:tahoma,sans-serif">Thanks, regards,</d=
iv><div style=3D"font-family:tahoma,sans-serif"><br></div><div style=3D"fon=
t-family:tahoma,sans-serif">-Manish</div><br></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
Farah Smith (8):<br>
=C2=A0 net/bnxt/tf_core: thor2 TF table scope sizing adjustments<br>
=C2=A0 net/bnxt/tf_core: tcam manager logical id free<br>
=C2=A0 net/bnxt/tf_core: thor2 hot upgrade ungraceful quit crash<br>
=C2=A0 net/bnxt/tf_core: truflow global table scope<br>
=C2=A0 net/bnxt/tf_ulp: socket direct enable<br>
=C2=A0 net/bnxt: fix adding udp_tunnel_port<br>
=C2=A0 net/bnxt: thor2 truflow memory manager bug<br>
=C2=A0 net/bnxt/tf_core: fix truflow PF init failure on sriov disabled<br>
<br>
Jay Ding (4):<br>
=C2=A0 net/bnxt: fix a NULL pointer dereference in bnxt_rep funcs<br>
=C2=A0 net/bnxt/tf_ulp: add meter stats support for Thor2<br>
=C2=A0 net/bnxt/tf_core: fix the miscalculation of the lkup table pool<br>
=C2=A0 next/bnxt/tf_ulp: truflow fixes for meter and mac_addr cache<br>
<br>
Kishore Padmanabha (18):<br>
=C2=A0 net/bnxt: enable vector mode processing<br>
=C2=A0 net/bnxt/tf_ulp: add support for global identifiers<br>
=C2=A0 net/bnxt/tf_core: add support for multi instance<br>
=C2=A0 net/bnxt/tf_core: fix table scope free<br>
=C2=A0 net/bnxt/tf_core: fix vfr clean up and stats lockup<br>
=C2=A0 net/bnxt/tf_ulp: increase shared pool size to 32<br>
=C2=A0 net/bnxt/tf_ulp: add support for tcam priority update<br>
=C2=A0 net/bnxt/tf_ulp: hot upgrade support<br>
=C2=A0 net/bnxt/tf_ulp: fix stats counter memory initialization<br>
=C2=A0 net/bnxt: fix max VFs count for thor2<br>
=C2=A0 net/bnxt/tf_ulp: enable support for global index table<br>
=C2=A0 net/bnxt/tf_ulp: optimize template enums<br>
=C2=A0 net/bnxt/tf_ulp: add non vfr mode capability<br>
=C2=A0 net/bnxt: fix stats collection when rx queue is not set<br>
=C2=A0 net/bnxt: fix rss configuration when set to none<br>
=C2=A0 net/bnxt: packet drop after port stop and start<br>
=C2=A0 net/bnxt/tf_ulp: add support for unicast only feature<br>
=C2=A0 net/bnxt: add support for truflow promiscuous mode<br>
<br>
Manish Kurup (9):<br>
=C2=A0 net/bnxt/tf_ulp: add bnxt platform data for 25.11<br>
=C2=A0 net/bnxt/tf_ulp: add bnxt app data for 25.11 for Wh+<br>
=C2=A0 net/bnxt/tf_ulp: add bnxt app data for 25.11 - Thor<br>
=C2=A0 net/bnxt/tf_ulp: add bnxt app data for 25.11 - Thor2<br>
=C2=A0 net/bnxt/tf_core: dynamic UPAR support for THOR2<br>
=C2=A0 net/bnxt: add meson build options for TruFlow<br>
=C2=A0 net/bnxt: truflow HSI struct fixes<br>
=C2=A0 net/bnxt/tf_ulp: fixes to enable TF functionality<br>
=C2=A0 net/bnxt/tf_ulp: remove Truflow DEBUG code<br>
<br>
Peter Spreadborough (6):<br>
=C2=A0 net/bnxt/tf_ulp: ovs-dpdk packet drop observed with thor2<br>
=C2=A0 net/bnxt/tf_core: add backing store debug to dpdk<br>
=C2=A0 net/bnxt/tf_core: handle out of order MPC completions<br>
=C2=A0 net/bnxt: avoid potential segfault in VFR handling<br>
=C2=A0 net/bnxt/tf_core: fix truflow crash on memory allocation failure<br>
=C2=A0 net/bnxt/tf_core: remove excessive debug logging<br>
<br>
Sangtani Parag Satishbhai (3):<br>
=C2=A0 net/bnxt/tf_ulp: fix seg fault when devargs argument missing<br>
=C2=A0 net/bnxt: truflow remove redundant code for mpc init<br>
=C2=A0 net/bnxt: truflow remove RTE devarg processing for mpc=3D1<br>
<br>
Shahaji Bhosle (4):<br>
=C2=A0 net/bnxt/tf_ulp: ulp parser support to handle gre key<br>
=C2=A0 net/bnxt/tf_ulp: change rte_mem_virt2iova to rte_mem_virt2phys<br>
=C2=A0 net/bnxt/tf_ulp: truflow add pf action handler<br>
=C2=A0 net/bnxt/tf_ulp: add feature bit rx miss handling<br>
<br>
Shuanglin Wang (2):<br>
=C2=A0 net/bnxt/tf_core: fix build failure with flow scale option<br>
=C2=A0 net/bnxt/tf_ulp: support MPLS packets<br>
<br>
Smitha Pisupati (1):<br>
=C2=A0 net/bnxt/tf_ulp: add support for special vxlan<br>
<br>
Sriharsha Basavapatna (2):<br>
=C2=A0 net/bnxt: fix default rss config<br>
=C2=A0 net/bnxt: avoid iova range check when external memory is used<br>
<br>
=C2=A0drivers/net/bnxt/bnxt.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A07 +<br>
=C2=A0drivers/net/bnxt/bnxt_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0256 +-<br>
=C2=A0drivers/net/bnxt/bnxt_hwrm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 25 +-<br>
=C2=A0drivers/net/bnxt/bnxt_mpc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 26 +-<br>
=C2=A0drivers/net/bnxt/bnxt_mpc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A07 +-<br>
=C2=A0drivers/net/bnxt/bnxt_reps.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 37 +-<br>
=C2=A0drivers/net/bnxt/bnxt_stats.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A05 +<br>
=C2=A0drivers/net/bnxt/bnxt_txr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A05 +-<br>
=C2=A0drivers/net/bnxt/bnxt_vnic.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 21 +-<br>
=C2=A0.../bnxt/hcapi/cfa_v3/include/cfa_resources.h |=C2=A0 =C2=A0 33 +-<br=
>
=C2=A0.../net/bnxt/hcapi/cfa_v3/include/cfa_types.h |=C2=A0 =C2=A0 10 +<br>
=C2=A0drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 83 +-<br>
=C2=A0.../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 =C2=A02 +-<br>
=C2=A0drivers/net/bnxt/hsi_struct_def_dpdk.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1123 +-<br>
=C2=A0drivers/net/bnxt/tf_core/cfa_tcam_mgr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 35 +-<br>
=C2=A0.../net/bnxt/tf_core/cfa_tcam_mgr_device.h=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 =C2=A06 +-<br>
=C2=A0drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 =C2=A02 +-<br>
=C2=A0drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A0 =C2=A02 +-<br>
=C2=A0drivers/net/bnxt/tf_core/tf_resources.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A02 +-<br>
=C2=A0drivers/net/bnxt/tf_core/tf_util.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 =C2=A02 +<br>
=C2=A0drivers/net/bnxt/tf_core/v3/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A04 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0238 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_act.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 47 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_cpm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 13 +<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_debug.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 12 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_em.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0143 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_em.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0105 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_global_id.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A0 45 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c |=C2=A0 =C2=A0142 +<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 51 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c=C2=A0 =C2=A0|=C2=A0 1411 =
+<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A0565 -<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_msg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0363 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_msg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 41 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_resources.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A0 12 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A0246 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_tcam.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 55 +<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c=C2=A0 |=C2=A0 1875 +<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_util.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 23 +<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_util.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 14 +<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A0 =C2=A03 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h=C2=A0 =C2=A0|=C2=A0 =C2=
=A0 =C2=A04 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0211 +-<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfo.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 53 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_tf_common.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 =C2=A05 -<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 =C2=A06 -<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_ulp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 =C2=A06 +<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 10 +<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 55 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 27 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0147 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 =C2=A05 +<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 82 +-<br>
=C2=A0.../generic_templates/ulp_template_db_act.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A0 =C2=A06 +-<br>
=C2=A0.../generic_templates/ulp_template_db_class.c |=C2=A0 8808 ++--<br>
=C2=A0.../generic_templates/ulp_template_db_defs.h=C2=A0 |=C2=A0 =C2=A0 88 =
+<br>
=C2=A0.../generic_templates/ulp_template_db_field.h |=C2=A0 =C2=A0 =C2=A05 =
+-<br>
=C2=A0.../generic_templates/ulp_template_db_tbl.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A0267 +-<br>
=C2=A0.../ulp_template_db_thor2_act.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 4637 +-<br>
=C2=A0.../ulp_template_db_thor2_class.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 42439 +++++++++-------<br>
=C2=A0.../ulp_template_db_thor_act.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 14 +-<br>
=C2=A0.../ulp_template_db_thor_class.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 13247 ++---<br>
=C2=A0.../ulp_template_db_wh_plus_act.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A02 +-<br>
=C2=A0.../ulp_template_db_wh_plus_class.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 26 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 56 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A04 -<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_def_rules.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 38 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 50 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 11 +<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A03 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 64 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_flow_db.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 10 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_flow_db.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 =C2=A06 +<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_gen_hash.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 =C2=A02 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 24 +<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 12 +<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_mapper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0326 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_mapper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 56 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 81 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0347 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_matcher.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 =C2=A09 -<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |=C2=A0 =C2=A0 =C2=A08 =
+-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_rte_parser.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0141 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_rte_parser.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 10 +<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0137 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 =C2=A04 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 =C2=A01 -<br>
=C2=A0.../ulp_template_db_enum.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0333 +-<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_template_struct.h |=C2=A0 =C2=A0 =C2=A05 =
+<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0264 +<br>
=C2=A0drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 40 +<br>
=C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A04 =
+<br>
=C2=A092 files changed, 48710 insertions(+), 30583 deletions(-)<br>
=C2=A0create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c<br>
=C2=A0create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c<br>
=C2=A0delete mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c<br>
=C2=A0create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c<br>
=C2=A0create mode 100644 drivers/net/bnxt/tf_ulp/generic_templates/ulp_temp=
late_db_defs.h<br>
=C2=A0rename drivers/net/bnxt/tf_ulp/{generic_templates =3D&gt; }/ulp_templ=
ate_db_enum.h (88%)<br>
=C2=A0create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c<br>
=C2=A0create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h<br>
<br>
-- <br>
2.39.5 (Apple Git-154)<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"tahoma, sans-serif">;) Manish (x13=
80)</font></div></div></div>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"tahoma, sans-serif">;) Manish (x13=
80)</font></div></div></div>

--000000000000d918e00641c1a077--

--000000000000e77e9a0641c1a003
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Ax6wtLQLOKzBPadeA5b964iGGF3eiFykVJL6g32dfXCnhU2bC4aHqGbwcUuOGXr64brR8refD0ND
tkUDm6Ck36ZJa4c0kk/tp2BL24XeUHIQ7tGVlMcPFYCTUHOpIduE8C8yqCqj8UVbn4s1px4U/81h
nHyA+wACG3xqA+4ZIOxA36btkSRaxCDqBde1JXJAwd4KaaE57ggUAbbGyyS3U4fEg7ivnwTqe/xr
BMUe5dkJKlUevcRI+KUbCyPBFdydjWo6pqrDx98CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWFuaXNoLmt1cnVwQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUlTJzl+DMv+RTNsn0e8FosYo2
buowDQYJKoZIhvcNAQELBQADggIBAK0fhbUPytWTCdQbZ8oyh042mBx9U+pfy5c35DLRRyrMMZhJ
A92wjuSEnUhN+OHWsDpr9nhnAJMujiRCAjPOSZslPVpjUa0/SizbixjAqmnmbKH573MB30KzN/1P
YWUlo2S2FNJcgAhzGzcCm97HbgvXMp1J8Vffh7r1tgNJMCTtIGJ5iETXbLUv2bmtP4tv+7o7ChMi
qyersTJNXcGGT5h8BwJLirAE1sqI0OWoNj/gBCowPOF6LUy7H+9kpRreFuvwpPVpUTlYvC5PiJxa
xyirfam81v/M411xzXS9zAeeeb9m/Krztjlnr14CEKXzRdMMqKoklNscF6WL5umL0q2na3YPc3u0
UFQZvVFymYPeJIccvb0GtdzmWvVBWcz8YTaA1eaooFYJ4y/SV93+bToTDCFd3IhMNsH18fnFtWO0
qu2WfDfQaGXRlPKurR4YHVDxru38j8b/KPFBlNkK9NZfZNCDbxse/H4pSXxOyJprOv7a72fItdW4
XPsuwBD9KoXLrjpfElqyF+z9jEPg+5cDA7Ff2wiNxfs1K5SdL7LV5me38wZhAHLRrYK9y4XXHYmc
QBmV6o+ACc3LZVapWaPlpHtQkmTDX7LhF3aP+RpoyIz2q/rgaEX7tHHHRulX1Bj96M5CvkNp3ccl
I7P9UEWAXb5llaVGoyR1/8ypT3Y9MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMNmKeINO4t964SBkFMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDtJhn0
hDVxBJiRRiNCE8qN4eg/vVzIGVI9j6z8t5LGbDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMjIxNjE1NDRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCGydU6bFRMzbNUIhLqjfS3oonHQghMquoiKkUSfSY+
d8bELKy/mnXIxcQMFMFJYP0z8T+Z/wEQtyj+SqR8jYfe0fSSY1B7ccMcEuFs3ISZvf8eDqIS+HcX
ai5LuO29/QluSe+sVD7pVinAUKCvlLsSz76DQX4M3q9x6IM8GGVRmiHyihIqRzpw/ddhaFrFOgKG
/pXEue+9gYQUPJn4sQNL7GNwCA/l/E3iQ5eXgT/i7IfWZSb/2gbfcqS1P9muEMetD466oUIemeaX
eQ2P5rgND4Vz5XnIgNRmUZDTK+47FyfWhx+BuKlvnsX5TSEwwBSkiVUHl8zD/bnSdhF7uKGH
--000000000000e77e9a0641c1a003--
