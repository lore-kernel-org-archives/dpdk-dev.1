Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ADACCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 18:20:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 117E540E38;
	Wed, 15 Oct 2025 20:20:18 +0200 (CEST)
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com
 [209.85.160.100])
 by mails.dpdk.org (Postfix) with ESMTP id 9C1FF40273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 20:20:16 +0200 (CEST)
Received: by mail-oa1-f100.google.com with SMTP id
 586e51a60fabf-36e4d00ebfdso2065441fac.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552416; x=1761157216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=69k/U7awsgrfecmQpKX/Iof5AWw+QAXETTI8IpO0Uew=;
 b=W4mQyUdxg4zLcL7eI56hRpPO9RpWjVMD+O+65vnaandB4TxNokjZtIKBCVrFGer+n2
 juBheZN5XcR5ASykRCk69laelUTLpLTFtQKQwzJHeCAyt7iapakPhGWQYZTx2ryyZ6lV
 /A3xGFcsr3Ml7Z+eLTADh0FshBonEQipeQuHErc1BjrxaSWujNfazjv6vDweT5M5SWIp
 3l884tHqndmEm9Y1N7CEbKYZt33B6OR+JoIMiaiGxbbg0hZQCWCdpJ7TNmnC5wPxDp7c
 PC3qcWOlL8CktRrYiQW+YsJerbh7Yi5eJLb6qtjK/w4wkCHqlpoK/edUUrfB6mlb9A2N
 HF2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/09z6fAuWzshG7Wa5Q+ErC2cs5nVgSS8eLJSRs/WQ473Ub+Od7EsqNBXAMvl5Al6189M=@dpdk.org
X-Gm-Message-State: AOJu0YyX2fBfpBgmTY94eZumWSc1G4OCZDEp8b82aobmWCkWEqK3haht
 p4ykK5sv9V9fSChnxM9teJGiCVU7a0ROEKy/j7WcQ69j7UsXPw5JS3svjC1bY2gHg3LJSmoHwFq
 FbxPr2H6ymO/f1Oc8eHFS1/Re01rETY7zXime+/XqUMoFx8G+C6zRwGh/ASBx1Rx0NeTkkDY9Ah
 iPCcVyERdl47gK92SG/vUG/zVodYBC4NeLy8SJU3D5uFHmPrlQsGS6Y/XgFVyBOj2SI0G/cQ==
X-Gm-Gg: ASbGncv562CsAq30/wtaGu6pp2gFqxVsG2A8xQZ3Vvto/OGwM3bygDuGoH1FXSP8+Bb
 v0Px26un7IKrdxbCo2cUXJDMyGgCy+EOeFPJU+WjQoBy3uqKoLIOFwJS+4115IX38RalGWzbUnP
 amvOBytuym6Db2WyLIAk05SU5W3dC3/ldWgOQMHxlgr6QCP8BnWNBYVMnkow74ApWQsVoezPJNL
 x1tRSB2bwK7sHqzFWxgu/SAmYyF0OZYm7jN+Nlu5NAKM9rPZnPRVTsVRTiJN2UGQjpuhj87Mtsi
 CAnZg7Afh6O7TJ56svpj6M+5RIXLPwYyxMlY/CiCx8cJOILh+1K8q96OlPoD51mSUSH+Mksby9D
 B0WEr54YsOB+TtPP6qzaxKupwEgqEwnb1+4haw5nrj7K3NPsoECJOldOz7TxcYA1bOvFvgTLKgI
 c=
X-Google-Smtp-Source: AGHT+IFSRqhSqTqEv7bkbMy03eVXX2LzUvYLiR1Wf+MqdN6WxNWDG94uLqTzF4mSDW4H1xGr31iBs+KYdco4
X-Received: by 2002:a05:6870:e0a6:b0:315:3103:6e7a with SMTP id
 586e51a60fabf-3c0f978eeb8mr11866204fac.43.1760552415415; 
 Wed, 15 Oct 2025 11:20:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3c8c8bf9760sm1537280fac.11.2025.10.15.11.20.14
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:20:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b548c516b79so623935966b.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760552413; x=1761157213; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=69k/U7awsgrfecmQpKX/Iof5AWw+QAXETTI8IpO0Uew=;
 b=DJ3S2n3YJ0d863/5jSqED0QrKpsr+7zF1FPIRXm3WTUPJO93Bog6T5b5J5Y1Tb5M7C
 DCAk/g4C55tms/hac2rbSiob7O0movxV3M0CXKMrcGZIFb9V05Iny0Duptqe9SGNqG2S
 thqzcZgnXUB5L19pkNIScuJU/sin92N1MntAw=
X-Forwarded-Encrypted: i=1;
 AJvYcCVCPwfqmR/0QAHHN7egvzBa9fCPeey0tt4KPrelsaVlluRQPo3cCDVgJocX+lOXjwjXn14=@dpdk.org
X-Received: by 2002:a17:907:6ea4:b0:b57:78fa:db61 with SMTP id
 a640c23a62f3a-b5778fae293mr1673196566b.52.1760552413243; 
 Wed, 15 Oct 2025 11:20:13 -0700 (PDT)
X-Received: by 2002:a17:907:6ea4:b0:b57:78fa:db61 with SMTP id
 a640c23a62f3a-b5778fae293mr1673192966b.52.1760552412622; Wed, 15 Oct 2025
 11:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251015104335.24dd7db0@hermes.local>
 <CACZ4nhttzP9F_f0km797TYyA+AOdFSfuajqnijnMYm_Lroa0Ww@mail.gmail.com>
In-Reply-To: <CACZ4nhttzP9F_f0km797TYyA+AOdFSfuajqnijnMYm_Lroa0Ww@mail.gmail.com>
From: Manish Kurup <manish.kurup@broadcom.com>
Date: Wed, 15 Oct 2025 14:20:00 -0400
X-Gm-Features: AS18NWA5OW3UZOQ9WO9Kysb2m9cn0wMyLsHbiBBetGx4bNLRyNuRob_kBGE-iCQ
Message-ID: <CAEKskBUo25Nx=5DhgdcsPL5roRY_C-ZyuGr7rzV30-E9zWpBgQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/54] bnxt patchset
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000003b40610641368d80"
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

--0000000000003b40610641368d80
Content-Type: multipart/alternative; boundary="00000000000029c93c0641368d1d"

--00000000000029c93c0641368d1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

To reiterate, this happened for V2 as well. I remember seeing a warning
about the size of the patch, and that being the reason it was dropped.

Could you please explain why this happens? How can I ensure that this
doesnt happen again?

Thanks a lot!


On Wed, Oct 15, 2025 at 1:52=E2=80=AFPM Ajit Khaparde <ajit.khaparde@broadc=
om.com>
wrote:

> On Wed, Oct 15, 2025 at 10:43=E2=80=AFAM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Wed, 15 Oct 2025 04:59:30 -0400
> > Manish Kurup <manish.kurup@broadcom.com> wrote:
> >
> > > Apart from bug fixes, this patchset adds the following
> > > functionality:
> > >
> > > 1. Add the data, defines and enums for applications targeting
> > >    Wh+, P5, P7 product families.
> > > 2. Update HSI files (HWRM API defintions, enums, version number)
> > > 3. Dynamic UPAR support for THOR2.
> > > 4. Add support to allow multiple instances of applications to
> > >    exist at the same time.
> > > 5. Add hot upgrade support for applications.
> > > 6. Add MPLS packet offload support.
> > > 7. Improve backing store debug capabilities.
> > > 8. Add truflow global table scope support.
> > > 9. ULP parser support to handle GRE key.
> > >
> > > v1->v2:
> > > 1. Fixed typos in commit messages
> > > 2. Removed incorrect tabs in meson.build
> > > 3. Fixed ENODATA return value for BSD
> > > 4. Removed unused function bnxt_mpc_bds_in_hw()
> > > 5. Fixed questionable pointer cast warning
> > > 6. Ignoring function argument mispelling warnings
> > >
> > > v2->v3:
> > > 1. Fixed all sprintf format string warnings.
> > > 2. Fixed additional pointer size warnings.
> > >
> > > Please apply.
> > >
> > > Farah Smith (8):
> > >   net/bnxt/tf_core: thor2 TF table scope sizing adjustments
> > >   net/bnxt/tf_core: tcam manager logical id free
> > >   net/bnxt/tf_core: thor2 hot upgrade ungraceful quit crash
> > >   net/bnxt/tf_core: truflow global table scope
> > >   net/bnxt/tf_ulp: socket direct enable
> > >   net/bnxt: fix adding udp_tunnel_port
> > >   net/bnxt: thor2 truflow memory manager bug
> > >   net/bnxt/tf_core: fix truflow PF init failure on sriov disabled
> > >
> > > Jay Ding (4):
> > >   net/bnxt: fix a NULL pointer dereference in bnxt_rep funcs
> > >   net/bnxt/tf_ulp: add meter stats support for Thor2
> > >   net/bnxt/tf_core: fix the miscalculation of the lkup table pool
> > >   next/bnxt/tf_ulp: truflow fixes for meter and mac_addr cache
> > >
> > > Kishore Padmanabha (18):
> > >   net/bnxt: enable vector mode processing
> > >   net/bnxt/tf_ulp: add support for global identifiers
> > >   net/bnxt/tf_core: add support for multi instance
> > >   net/bnxt/tf_core: fix table scope free
> > >   net/bnxt/tf_core: fix vfr clean up and stats lockup
> > >   net/bnxt/tf_ulp: increase shared pool size to 32
> > >   net/bnxt/tf_ulp: add support for tcam priority update
> > >   net/bnxt/tf_ulp: hot upgrade support
> > >   net/bnxt/tf_ulp: fix stats counter memory initialization
> > >   net/bnxt: fix max VFs count for thor2
> > >   net/bnxt/tf_ulp: enable support for global index table
> > >   net/bnxt/tf_ulp: optimize template enums
> > >   net/bnxt/tf_ulp: add non vfr mode capability
> > >   net/bnxt: fix stats collection when rx queue is not set
> > >   net/bnxt: fix rss configuration when set to none
> > >   net/bnxt: packet drop after port stop and start
> > >   net/bnxt/tf_ulp: add support for unicast only feature
> > >   net/bnxt: add support for truflow promiscuous mode
> > >
> > > Manish Kurup (6):
> > >   net/bnxt/tf_ulp: add bnxt app data for 25.11
> > >   net/bnxt/tf_core: dynamic UPAR support for THOR2
> > >   net/bnxt: add meson build options for TruFlow
> > >   net/bnxt: truflow HSI struct fixes
> > >   net/bnxt/tf_ulp: fixes to enable TF functionality
> > >   net/bnxt/tf_ulp: remove Truflow DEBUG code
> > >
> > > Peter Spreadborough (6):
> > >   net/bnxt/tf_ulp: ovs-dpdk packet drop observed with thor2
> > >   net/bnxt/tf_core: add backing store debug to dpdk
> > >   net/bnxt/tf_core: handle out of order MPC completions
> > >   net/bnxt: avoid potential segfault in VFR handling
> > >   net/bnxt/tf_core: fix truflow crash on memory allocation failure
> > >   net/bnxt/tf_core: remove excessive debug logging
> > >
> > > Sangtani Parag Satishbhai (3):
> > >   net/bnxt/tf_ulp: fix seg fault when devargs argument missing
> > >   net/bnxt: truflow remove redundant code for mpc init
> > >   net/bnxt: truflow remove RTE devarg processing for mpc=3D1
> > >
> > > Shahaji Bhosle (4):
> > >   net/bnxt/tf_ulp: ulp parser support to handle gre key
> > >   net/bnxt/tf_ulp: change rte_mem_virt2iova to rte_mem_virt2phys
> > >   net/bnxt/tf_ulp: truflow add pf action handler
> > >   net/bnxt/tf_ulp: add feature bit rx miss handling
> > >
> > > Shuanglin Wang (2):
> > >   net/bnxt/tf_core: fix build failure with flow scale option
> > >   net/bnxt/tf_ulp: support MPLS packets
> > >
> > > Smitha Pisupati (1):
> > >   net/bnxt/tf_ulp: add support for special vxlan
> > >
> > > Sriharsha Basavapatna (2):
> > >   net/bnxt: fix default rss config
> > >   net/bnxt: avoid iova range check when external memory is used
> > >
> > >  drivers/net/bnxt/bnxt.h                       |     7 +
> > >  drivers/net/bnxt/bnxt_ethdev.c                |   256 +-
> > >  drivers/net/bnxt/bnxt_hwrm.c                  |    25 +-
> > >  drivers/net/bnxt/bnxt_mpc.c                   |    26 +-
> > >  drivers/net/bnxt/bnxt_mpc.h                   |     7 +-
> > >  drivers/net/bnxt/bnxt_reps.c                  |    37 +-
> > >  drivers/net/bnxt/bnxt_stats.c                 |     5 +
> > >  drivers/net/bnxt/bnxt_txr.c                   |     5 +-
> > >  drivers/net/bnxt/bnxt_vnic.c                  |    21 +-
> > >  .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |    33 +-
> > >  .../net/bnxt/hcapi/cfa_v3/include/cfa_types.h |    10 +
> > >  drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c     |    83 +-
> > >  .../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h    |     2 +-
> > >  drivers/net/bnxt/hsi_struct_def_dpdk.h        |  1123 +-
> > >  drivers/net/bnxt/tf_core/cfa_tcam_mgr.c       |    35 +-
> > >  .../net/bnxt/tf_core/cfa_tcam_mgr_device.h    |     6 +-
> > >  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c    |     2 +-
> > >  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c   |     2 +-
> > >  drivers/net/bnxt/tf_core/tf_resources.c       |     2 +-
> > >  drivers/net/bnxt/tf_core/tf_util.c            |     2 +
> > >  drivers/net/bnxt/tf_core/v3/meson.build       |     4 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc.h             |   238 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_act.c         |    47 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_cpm.c         |    13 +
> > >  drivers/net/bnxt/tf_core/v3/tfc_debug.h       |    12 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_em.c          |   143 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_em.h          |   105 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_global_id.c   |    45 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c |   142 +
> > >  drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c     |    51 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c   |  1411 +
> > >  drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c   |   565 -
> > >  drivers/net/bnxt/tf_core/v3/tfc_msg.c         |   363 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_msg.h         |    41 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_resources.c   |    12 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c   |   246 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_tcam.c        |    55 +
> > >  drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c  |  1875 +
> > >  drivers/net/bnxt/tf_core/v3/tfc_util.c        |    23 +
> > >  drivers/net/bnxt/tf_core/v3/tfc_util.h        |    14 +
> > >  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c   |     3 +-
> > >  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h   |     4 +-
> > >  drivers/net/bnxt/tf_core/v3/tfo.c             |   211 +-
> > >  drivers/net/bnxt/tf_core/v3/tfo.h             |    53 +-
> > >  drivers/net/bnxt/tf_ulp/bnxt_tf_common.h      |     5 -
> > >  drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c    |     6 -
> > >  drivers/net/bnxt/tf_ulp/bnxt_ulp.h            |     6 +
> > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c       |    10 +
> > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c      |    55 +-
> > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c         |    27 +-
> > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c        |   147 +-
> > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h        |     5 +
> > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h      |    82 +-
> > >  .../generic_templates/ulp_template_db_act.c   |     6 +-
> > >  .../generic_templates/ulp_template_db_class.c |  8808 ++--
> > >  .../generic_templates/ulp_template_db_defs.h  |    88 +
> > >  .../generic_templates/ulp_template_db_field.h |     5 +-
> > >  .../generic_templates/ulp_template_db_tbl.c   |   267 +-
> > >  .../ulp_template_db_thor2_act.c               |  4637 +-
> > >  .../ulp_template_db_thor2_class.c             | 42439 +++++++++-----=
--
> > >  .../ulp_template_db_thor_act.c                |    14 +-
> > >  .../ulp_template_db_thor_class.c              | 13247 ++---
> > >  .../ulp_template_db_wh_plus_act.c             |     2 +-
> > >  .../ulp_template_db_wh_plus_class.c           |    26 +-
> > >  drivers/net/bnxt/tf_ulp/meson.build           |    56 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c       |     4 -
> > >  drivers/net/bnxt/tf_ulp/ulp_def_rules.c       |    38 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c          |    50 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h          |    11 +
> > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c       |     3 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c      |    64 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_flow_db.c         |    10 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_flow_db.h         |     6 +
> > >  drivers/net/bnxt/tf_ulp/ulp_gen_hash.c        |     2 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c         |    24 +
> > >  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h         |    12 +
> > >  drivers/net/bnxt/tf_ulp/ulp_mapper.c          |   326 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_mapper.h          |    56 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c       |    81 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c      |   347 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_matcher.c         |     9 -
> > >  drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |     8 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_rte_parser.c      |   141 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_rte_parser.h      |    10 +
> > >  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |   137 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h          |     4 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c      |     1 -
> > >  .../ulp_template_db_enum.h                    |   333 +-
> > >  drivers/net/bnxt/tf_ulp/ulp_template_struct.h |     5 +
> > >  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c      |   264 +
> > >  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h      |    40 +
> > >  meson_options.txt                             |     4 +
> > >  92 files changed, 48710 insertions(+), 30583 deletions(-)
> > >  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c
> > >  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
> > >  delete mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c
> > >  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
> > >  create mode 100644
> drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_defs.h
> > >  rename drivers/net/bnxt/tf_ulp/{generic_templates =3D>
> }/ulp_template_db_enum.h (88%)
> > >  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
> > >  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h
> > >
> >
> > I was looking to see if the bug detected with LTO (misuse of rte_free)
> > was in this patchset.
> Stephen,
> I don't see patch [01/54] on patchwork yet.
> From what I am told, that patch adds the ulp_template_db_defs.h
>
> Thanks
>
> >
> > But it fails to build:
> > [838/3632] Compiling C object
> drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o
> > FAILED: drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o
> > cc -Idrivers/libtmp_rte_net_bnxt.a.p -Idrivers -I../drivers
> -Idrivers/net/bnxt -I../drivers/net/bnxt -Idrivers/net/bnxt/tf_ulp
> -I../drivers/net/bnxt/tf_ulp -Idrivers/net/bnxt/tf_ulp/generic_templates
> -I../drivers/net/bnxt/tf_ulp/generic_templates -Idrivers/net/bnxt/tf_core
> -I../drivers/net/bnxt/tf_core -Idrivers/net/bnxt/tf_core/v3
> -I../drivers/net/bnxt/tf_core/v3 -Idrivers/net/bnxt/hcapi/cfa
> -I../drivers/net/bnxt/hcapi/cfa -Idrivers/net/bnxt/hcapi/cfa_v3
> -I../drivers/net/bnxt/hcapi/cfa_v3
> -I../drivers/net/bnxt/hcapi/cfa_v3/include
> -I../drivers/net/bnxt/hcapi/cfa_v3/include/platform/dpdk
> -I../drivers/net/bnxt/hcapi/cfa_v3/bld/p70
> -I../drivers/net/bnxt/hcapi/cfa_v3/bld/p70/host
> -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include
> -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include/host
> -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include/p70
> -I../drivers/net/bnxt/hcapi/cfa_v3/mm/include
> -I../drivers/net/bnxt/hcapi/cfa_v3/tim/include
> -I../drivers/net/bnxt/hcapi/cfa_v3/tpm/include -Ilib/ethdev -I../lib/ethd=
ev
> -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config
> -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include
> -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include
> -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs
> -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry
> -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I../lib/ne=
t
> -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring
> -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci
> -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci
> -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/hash -I../lib/hash -Ilib/r=
cu
> -I../lib/rcu -I/usr/include/x86_64-linux-gnu -flto=3Dauto
> -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch
> -Wextra -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecat=
ed
> -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations
> -Wmissing-prototypes -Wnested-externs -Wold-style-definition
> -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-string=
s
> -Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE
> -ffat-lto-objects -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API
> -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-member
> -Wno-vla -DBNXT_TF_APP_ID=3D0 -DSUPPORT_CFA_HW_P70=3D1 -DCFA_BLD_PRINT_OB=
J=3D1
> -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.bnxt -MD -MQ
> drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o -MF
> drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o.d -o
> drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o -c
> ../drivers/net/bnxt/bnxt_cpr.c
> > In file included from ../drivers/net/bnxt/tf_ulp/bnxt_ulp.h:18,
> >                  from ../drivers/net/bnxt/bnxt.h:28,
> >                  from ../drivers/net/bnxt/bnxt_cpr.c:10:
> > ../drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h:9:10: fatal error:
> ulp_template_db_defs.h: No such file or directory
> >     9 | #include "ulp_template_db_defs.h"
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> >
>


--=20
;) Manish (x1380)

--00000000000029c93c0641368d1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hi Stephen,</div><div class=3D"gmail_default" style=3D"font-fami=
ly:tahoma,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-=
family:tahoma,sans-serif">To reiterate, this happened for V2 as well. I rem=
ember=C2=A0seeing a warning about the size of the patch, and that being the=
 reason it was dropped.</div><div class=3D"gmail_default" style=3D"font-fam=
ily:tahoma,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font=
-family:tahoma,sans-serif">Could you please explain why this happens? How c=
an I ensure that this doesnt happen again?</div><div class=3D"gmail_default=
" style=3D"font-family:tahoma,sans-serif"><br></div><div class=3D"gmail_def=
ault" style=3D"font-family:tahoma,sans-serif">Thanks a lot!</div><div class=
=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br></div></div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Oct 15, 2025 at 1:52=E2=80=AFPM Ajit Khaparde &lt;<=
a href=3D"mailto:ajit.khaparde@broadcom.com">ajit.khaparde@broadcom.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On W=
ed, Oct 15, 2025 at 10:43=E2=80=AFAM Stephen Hemminger<br>
&lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank">stephen=
@networkplumber.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, 15 Oct 2025 04:59:30 -0400<br>
&gt; Manish Kurup &lt;<a href=3D"mailto:manish.kurup@broadcom.com" target=
=3D"_blank">manish.kurup@broadcom.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Apart from bug fixes, this patchset adds the following<br>
&gt; &gt; functionality:<br>
&gt; &gt;<br>
&gt; &gt; 1. Add the data, defines and enums for applications targeting<br>
&gt; &gt;=C2=A0 =C2=A0 Wh+, P5, P7 product families.<br>
&gt; &gt; 2. Update HSI files (HWRM API defintions, enums, version number)<=
br>
&gt; &gt; 3. Dynamic UPAR support for THOR2.<br>
&gt; &gt; 4. Add support to allow multiple instances of applications to<br>
&gt; &gt;=C2=A0 =C2=A0 exist at the same time.<br>
&gt; &gt; 5. Add hot upgrade support for applications.<br>
&gt; &gt; 6. Add MPLS packet offload support.<br>
&gt; &gt; 7. Improve backing store debug capabilities.<br>
&gt; &gt; 8. Add truflow global table scope support.<br>
&gt; &gt; 9. ULP parser support to handle GRE key.<br>
&gt; &gt;<br>
&gt; &gt; v1-&gt;v2:<br>
&gt; &gt; 1. Fixed typos in commit messages<br>
&gt; &gt; 2. Removed incorrect tabs in meson.build<br>
&gt; &gt; 3. Fixed ENODATA return value for BSD<br>
&gt; &gt; 4. Removed unused function bnxt_mpc_bds_in_hw()<br>
&gt; &gt; 5. Fixed questionable pointer cast warning<br>
&gt; &gt; 6. Ignoring function argument mispelling warnings<br>
&gt; &gt;<br>
&gt; &gt; v2-&gt;v3:<br>
&gt; &gt; 1. Fixed all sprintf format string warnings.<br>
&gt; &gt; 2. Fixed additional pointer size warnings.<br>
&gt; &gt;<br>
&gt; &gt; Please apply.<br>
&gt; &gt;<br>
&gt; &gt; Farah Smith (8):<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: thor2 TF table scope sizing adjustm=
ents<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: tcam manager logical id free<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: thor2 hot upgrade ungraceful quit c=
rash<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: truflow global table scope<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: socket direct enable<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: fix adding udp_tunnel_port<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: thor2 truflow memory manager bug<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix truflow PF init failure on srio=
v disabled<br>
&gt; &gt;<br>
&gt; &gt; Jay Ding (4):<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: fix a NULL pointer dereference in bnxt_rep =
funcs<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add meter stats support for Thor2<br=
>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix the miscalculation of the lkup =
table pool<br>
&gt; &gt;=C2=A0 =C2=A0next/bnxt/tf_ulp: truflow fixes for meter and mac_add=
r cache<br>
&gt; &gt;<br>
&gt; &gt; Kishore Padmanabha (18):<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: enable vector mode processing<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add support for global identifiers<b=
r>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: add support for multi instance<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix table scope free<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix vfr clean up and stats lockup<b=
r>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: increase shared pool size to 32<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add support for tcam priority update=
<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: hot upgrade support<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: fix stats counter memory initializat=
ion<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: fix max VFs count for thor2<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: enable support for global index tabl=
e<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: optimize template enums<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add non vfr mode capability<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: fix stats collection when rx queue is not s=
et<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: fix rss configuration when set to none<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: packet drop after port stop and start<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add support for unicast only feature=
<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: add support for truflow promiscuous mode<br=
>
&gt; &gt;<br>
&gt; &gt; Manish Kurup (6):<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add bnxt app data for 25.11<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: dynamic UPAR support for THOR2<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: add meson build options for TruFlow<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: truflow HSI struct fixes<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: fixes to enable TF functionality<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: remove Truflow DEBUG code<br>
&gt; &gt;<br>
&gt; &gt; Peter Spreadborough (6):<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: ovs-dpdk packet drop observed with t=
hor2<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: add backing store debug to dpdk<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: handle out of order MPC completions=
<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: avoid potential segfault in VFR handling<br=
>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix truflow crash on memory allocat=
ion failure<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: remove excessive debug logging<br>
&gt; &gt;<br>
&gt; &gt; Sangtani Parag Satishbhai (3):<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: fix seg fault when devargs argument =
missing<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: truflow remove redundant code for mpc init<=
br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: truflow remove RTE devarg processing for mp=
c=3D1<br>
&gt; &gt;<br>
&gt; &gt; Shahaji Bhosle (4):<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: ulp parser support to handle gre key=
<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: change rte_mem_virt2iova to rte_mem_=
virt2phys<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: truflow add pf action handler<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add feature bit rx miss handling<br>
&gt; &gt;<br>
&gt; &gt; Shuanglin Wang (2):<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix build failure with flow scale o=
ption<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: support MPLS packets<br>
&gt; &gt;<br>
&gt; &gt; Smitha Pisupati (1):<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add support for special vxlan<br>
&gt; &gt;<br>
&gt; &gt; Sriharsha Basavapatna (2):<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: fix default rss config<br>
&gt; &gt;=C2=A0 =C2=A0net/bnxt: avoid iova range check when external memory=
 is used<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/bnxt.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A07 +<br=
>
&gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0256 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_hwrm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 25 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_mpc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 26 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_mpc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A07 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_reps.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 37 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_stats.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A05 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_txr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A05 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_vnic.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 21 +-<br>
&gt; &gt;=C2=A0 .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |=C2=A0 =C2=
=A0 33 +-<br>
&gt; &gt;=C2=A0 .../net/bnxt/hcapi/cfa_v3/include/cfa_types.h |=C2=A0 =C2=
=A0 10 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 83 +-<br>
&gt; &gt;=C2=A0 .../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h=C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/hsi_struct_def_dpdk.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1123 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/cfa_tcam_mgr.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 35 +-<br>
&gt; &gt;=C2=A0 .../net/bnxt/tf_core/cfa_tcam_mgr_device.h=C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 =C2=A06 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c=C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c=C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/tf_resources.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/tf_util.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A02 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/meson.build=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A04 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0238 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_act.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 47 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_cpm.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 13 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_debug.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 12 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_em.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0143 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_em.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0105 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_global_id.c=C2=A0 =C2=A0|=
=C2=A0 =C2=A0 45 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c |=C2=A0 =C2=
=A0142 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 51 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c=C2=A0 =C2=A0|=
=C2=A0 1411 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c=C2=A0 =C2=A0|=
=C2=A0 =C2=A0565 -<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_msg.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0363 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_msg.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 41 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_resources.c=C2=A0 =C2=A0|=
=C2=A0 =C2=A0 12 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c=C2=A0 =C2=A0|=
=C2=A0 =C2=A0246 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_tcam.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 55 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c=C2=A0 |=C2=A0 =
1875 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_util.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 23 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_util.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 14 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c=C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A03 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h=C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A04 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfo.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0211 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfo.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 53 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_tf_common.h=C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 =C2=A05 -<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c=C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 =C2=A06 -<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A06 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 10 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c=C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 55 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 27 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0147 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 =C2=A05 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h=C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 82 +-<br>
&gt; &gt;=C2=A0 .../generic_templates/ulp_template_db_act.c=C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A06 +-<br>
&gt; &gt;=C2=A0 .../generic_templates/ulp_template_db_class.c |=C2=A0 8808 =
++--<br>
&gt; &gt;=C2=A0 .../generic_templates/ulp_template_db_defs.h=C2=A0 |=C2=A0 =
=C2=A0 88 +<br>
&gt; &gt;=C2=A0 .../generic_templates/ulp_template_db_field.h |=C2=A0 =C2=
=A0 =C2=A05 +-<br>
&gt; &gt;=C2=A0 .../generic_templates/ulp_template_db_tbl.c=C2=A0 =C2=A0|=
=C2=A0 =C2=A0267 +-<br>
&gt; &gt;=C2=A0 .../ulp_template_db_thor2_act.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4637 +-<br>
&gt; &gt;=C2=A0 .../ulp_template_db_thor2_class.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 42439 +++++++++-------<br>
&gt; &gt;=C2=A0 .../ulp_template_db_thor_act.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 14 +-<br>
&gt; &gt;=C2=A0 .../ulp_template_db_thor_class.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 13247 ++---<br>
&gt; &gt;=C2=A0 .../ulp_template_db_wh_plus_act.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 .../ulp_template_db_wh_plus_class.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 26 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 56 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A04 -<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_def_rules.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 38 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 50 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 11 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A03 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c=C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 64 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_flow_db.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 10 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_flow_db.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A06 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_gen_hash.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 24 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 12 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_mapper.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0326 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_mapper.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 56 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0 81 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c=C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0347 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_matcher.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A09 -<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |=C2=A0 =C2=
=A0 =C2=A08 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c=C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0141 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_rte_parser.h=C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 10 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0137 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A04 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c=C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 =C2=A01 -<br>
&gt; &gt;=C2=A0 .../ulp_template_db_enum.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0333 +-<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_template_struct.h |=C2=A0 =C2=
=A0 =C2=A05 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c=C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0264 +<br>
&gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h=C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 40 +<br>
&gt; &gt;=C2=A0 meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 =C2=A04 +<br>
&gt; &gt;=C2=A0 92 files changed, 48710 insertions(+), 30583 deletions(-)<b=
r>
&gt; &gt;=C2=A0 create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_hot_upgr=
ade.c<br>
&gt; &gt;=C2=A0 create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_debu=
g.c<br>
&gt; &gt;=C2=A0 delete mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_tabl=
e.c<br>
&gt; &gt;=C2=A0 create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_tcam_deb=
ug.c<br>
&gt; &gt;=C2=A0 create mode 100644 drivers/net/bnxt/tf_ulp/generic_template=
s/ulp_template_db_defs.h<br>
&gt; &gt;=C2=A0 rename drivers/net/bnxt/tf_ulp/{generic_templates =3D&gt; }=
/ulp_template_db_enum.h (88%)<br>
&gt; &gt;=C2=A0 create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c=
<br>
&gt; &gt;=C2=A0 create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h=
<br>
&gt; &gt;<br>
&gt;<br>
&gt; I was looking to see if the bug detected with LTO (misuse of rte_free)=
<br>
&gt; was in this patchset.<br>
Stephen,<br>
I don&#39;t see patch [01/54] on patchwork yet.<br>
From what I am told, that patch adds the ulp_template_db_defs.h<br>
<br>
Thanks<br>
<br>
&gt;<br>
&gt; But it fails to build:<br>
&gt; [838/3632] Compiling C object drivers/libtmp_rte_net_bnxt.a.p/net_bnxt=
_bnxt_cpr.c.o<br>
&gt; FAILED: drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o<br>
&gt; cc -Idrivers/libtmp_rte_net_bnxt.a.p -Idrivers -I../drivers -Idrivers/=
net/bnxt -I../drivers/net/bnxt -Idrivers/net/bnxt/tf_ulp -I../drivers/net/b=
nxt/tf_ulp -Idrivers/net/bnxt/tf_ulp/generic_templates -I../drivers/net/bnx=
t/tf_ulp/generic_templates -Idrivers/net/bnxt/tf_core -I../drivers/net/bnxt=
/tf_core -Idrivers/net/bnxt/tf_core/v3 -I../drivers/net/bnxt/tf_core/v3 -Id=
rivers/net/bnxt/hcapi/cfa -I../drivers/net/bnxt/hcapi/cfa -Idrivers/net/bnx=
t/hcapi/cfa_v3 -I../drivers/net/bnxt/hcapi/cfa_v3 -I../drivers/net/bnxt/hca=
pi/cfa_v3/include -I../drivers/net/bnxt/hcapi/cfa_v3/include/platform/dpdk =
-I../drivers/net/bnxt/hcapi/cfa_v3/bld/p70 -I../drivers/net/bnxt/hcapi/cfa_=
v3/bld/p70/host -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include -I../drivers=
/net/bnxt/hcapi/cfa_v3/bld/include/host -I../drivers/net/bnxt/hcapi/cfa_v3/=
bld/include/p70 -I../drivers/net/bnxt/hcapi/cfa_v3/mm/include -I../drivers/=
net/bnxt/hcapi/cfa_v3/tim/include -I../drivers/net/bnxt/hcapi/cfa_v3/tpm/in=
clude -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common -I.=
 -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal=
/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/ea=
l/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../li=
b/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/teleme=
try -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I../lib/=
net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I..=
/lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci=
 -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../=
drivers/bus/vdev -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -I/usr/inc=
lude/x86_64-linux-gnu -flto=3Dauto -fdiagnostics-color=3Dalways -D_FILE_OFF=
SET_BITS=3D64 -Wall -Winvalid-pch -Wextra -std=3Dc11 -O3 -include rte_confi=
g.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-se=
curity -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-s=
tyle-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef =
-Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initializers -D_=
GNU_SOURCE -ffat-lto-objects -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENT=
AL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-m=
ember -Wno-vla -DBNXT_TF_APP_ID=3D0 -DSUPPORT_CFA_HW_P70=3D1 -DCFA_BLD_PRIN=
T_OBJ=3D1 -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.bnxt -MD -MQ drivers/libtmp_r=
te_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o -MF drivers/libtmp_rte_net_bnxt.a.p/n=
et_bnxt_bnxt_cpr.c.o.d -o drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr=
.c.o -c ../drivers/net/bnxt/bnxt_cpr.c<br>
&gt; In file included from ../drivers/net/bnxt/tf_ulp/bnxt_ulp.h:18,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from ../=
drivers/net/bnxt/bnxt.h:28,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from ../=
drivers/net/bnxt/bnxt_cpr.c:10:<br>
&gt; ../drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h:9:10: fatal error: u=
lp_template_db_defs.h: No such file or directory<br>
&gt;=C2=A0 =C2=A0 =C2=A09 | #include &quot;ulp_template_db_defs.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~=
~~~~~~~~~~~~~~~~<br>
&gt; compilation terminated.<br>
&gt;<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"tahoma, sans-serif">;) Manish (x13=
80)</font></div></div>

--00000000000029c93c0641368d1d--

--0000000000003b40610641368d80
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
MjAyMwIMNmKeINO4t964SBkFMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAnG2Aa
JOHYxgu0YEamrYSAlpxdUf6EkUG+ggBEo5811DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMTUxODIwMTNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBRJMnqJrbMoc+jmvCnq7zMV2GOtVsshWUrLY1EuSCu
VDN1dxxR4kWy7TOhd0YvhzRJQGnlYryuT3EAgs/GgxC7Y6Pom9GEOuDPPoX/K2IpqLoetSlBjEqd
bQ11oUYoEz+wUJQEJXppZpGnfRrriaFjKK1tx1/e4ffsI5FcpigAjq7bJUCeB3SPpTkksVOq7UL2
f+rDnhSz7SpIluMPcfkSug4uemDcbyujbcV1e98c3eAi/bm7uDa2ZooMheK5Vq16z9dqp8vxh3wF
oBIoEt+UpFjDku1GgVSHlfdPb8gwbEkqvpYJ2e8c1fvWVvTOt8CUl4YEwOWKMvcEdq9Hjm0s
--0000000000003b40610641368d80--
