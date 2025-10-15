Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB28CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 19:46:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E31A940E7C;
	Wed, 15 Oct 2025 21:46:24 +0200 (CEST)
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com
 [209.85.166.228])
 by mails.dpdk.org (Postfix) with ESMTP id 7C08640273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 21:46:23 +0200 (CEST)
Received: by mail-il1-f228.google.com with SMTP id
 e9e14a558f8ab-42d7ef9a402so6179255ab.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760557583; x=1761162383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KUQzY6Jv6Fp+tWtyIF2AETKpz9gTHayioT2cOSMCm/M=;
 b=I67R9R8pZ3Vmy6qN2OArHSULgafDTpROD8Kfq7SjC82gFH8KB6xxteVbyCrY5kfDe+
 Re7q0lEdG0qk9pKy8j0QtYOFRcWGVf2nao/C7/PSHdKZxOsSIYOAIr2C4oVt7S70QxGp
 5ARf1m00dvOPQNWSht5O/x5Gw+dXrmWwvDKbxK8x+z+htqhvIsRNOtKu3bI1TRVdVHbu
 /ZZNxZwC/N7nr9PM5Tlmh6Vr8i9sOlaH8/UbHUNGQQvKdr0Gb87OG5zOL/eZVPkdRc3J
 6KfpSH2FQF15s6znlOsPUYTvDY6HGizOb2F1IBvLUXK6v1hCe7+CqpFNM/lzRGNbowj8
 4tEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxhpRWLoSE40rmGXabFhaAQQiexzkH7fa70vRCMXSz3eL/dUl1WZ4V3f386G+YXSLExlE=@dpdk.org
X-Gm-Message-State: AOJu0Yzyt0ba1R0Oof/tyaGPHVRW0LNStRaERoX6rTf71i4b74V3itVy
 hLXCEZSHmjyBq3zq8WdXYd9CWMmUb6RsizsFWf4ArWN4PI46ScQnJZGEG+0QbPG1VRe1jYTcsim
 K8rBnWJxcSpAnunjEKEvD6zVZUsgkYqLzRBRtm8gMx7o+rmTyhQjsD3tV1xq3fWsCBeyKUGVCov
 /+AsRfQRRtqGvIL1jaOeXijLlYXkhvy863NenvuC7i05X9+YYizHpU66fAIHwi+JFwhMOPAw==
X-Gm-Gg: ASbGnctnUY9ew8bnvCkZfYPEYOL1xJd3F/gjvBTsVVVCbBDHu2BkBXqqPk4gEMDBBkd
 Wq9b1FP2/ugmovALUJN9ENwA6W7hq220kMJJRA678seTcEHvx0dAYGB2VPaRusYM1YPCgHH2MBr
 F6rK/TfxvIzSVwa+ZXP0C66neUsViGB4WL42uPZP0DKGbcAug0/YfJ2PUc2F+EZJH7vVt9s0fg7
 HTdTq5BjKXJCErLeisVY+v0TrsfO+Bt9kVCbnbwBdt8v8k8VEVGBKQ2QLnnrI/7x4+Ydwanrace
 8upXUHEW83uRRr1o06J6Op0Kaau1W1lw+GKIx7UCMyS2YRxuxcw1S565BP2Tfo7oN0JYQWAz5Y/
 g0O9gQMtuvF7GNEAEFVz2aF+kh+8MUcrFVTWC2zQBOSdxP5lD+4PoGcUEQ3sNzIN8KGvZvEPCsL
 Mgog==
X-Google-Smtp-Source: AGHT+IGEZ+OcF1sdvLqskQC4reHGgjRwBT1QQOy+Ti7Y/nW95rwaLNqVdfZ0/85EIVu8aKEIjO65V/XbY+0p
X-Received: by 2002:a05:6e02:19ce:b0:430:b2a8:a9eb with SMTP id
 e9e14a558f8ab-430b433a427mr16507555ab.1.1760557582457; 
 Wed, 15 Oct 2025 12:46:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-58f7146c460sm1310283173.29.2025.10.15.12.46.21
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 12:46:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b58d1fe8cd7so243317866b.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760557579; x=1761162379; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KUQzY6Jv6Fp+tWtyIF2AETKpz9gTHayioT2cOSMCm/M=;
 b=PtqsNGLzdN4/O3v/vhab1YsoIYO0GglQnqE+KFesucQtMu35jDZ/LHYAZDgj3OWLcj
 yorSKO1oxvCu8cX8Becs5HbCXm+VE9PUgUbQxB5p1MYyY7AHuMYCxx+q7bAVT4X7ORe3
 DneXzc4WnXKD24bnoy4Gro4E5FinFIqun4ags=
X-Forwarded-Encrypted: i=1;
 AJvYcCVo866N/iCwSPxz11E6xY+X75L+moehcuct9Chon3FKIdpsjbX1T3FtIKdQ3RU52eNf410=@dpdk.org
X-Received: by 2002:a17:906:c7d4:b0:b55:c30d:c9fc with SMTP id
 a640c23a62f3a-b55c30dcb31mr1937590566b.11.1760557579022; 
 Wed, 15 Oct 2025 12:46:19 -0700 (PDT)
X-Received: by 2002:a17:906:c7d4:b0:b55:c30d:c9fc with SMTP id
 a640c23a62f3a-b55c30dcb31mr1937587166b.11.1760557578281; Wed, 15 Oct 2025
 12:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251015104335.24dd7db0@hermes.local>
 <CACZ4nhttzP9F_f0km797TYyA+AOdFSfuajqnijnMYm_Lroa0Ww@mail.gmail.com>
 <CAEKskBUo25Nx=5DhgdcsPL5roRY_C-ZyuGr7rzV30-E9zWpBgQ@mail.gmail.com>
 <20251015120921.4db1212e@hermes.local>
In-Reply-To: <20251015120921.4db1212e@hermes.local>
From: Manish Kurup <manish.kurup@broadcom.com>
Date: Wed, 15 Oct 2025 15:46:06 -0400
X-Gm-Features: AS18NWAldQcgP-ouUMxOXCtlvUYGbi6a7tzK9ajJX8IFuNES0A4svqBw7lKFlGo
Message-ID: <CAEKskBV=t-3tR+qBGBDPNiEj1=6UKSPGP=-LA5Ztmxr5viwizw@mail.gmail.com>
Subject: Re: [PATCH v3 00/54] bnxt patchset
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000274520064137c1bd"
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

--000000000000274520064137c1bd
Content-Type: multipart/alternative; boundary="0000000000000f8e49064137c13a"

--0000000000000f8e49064137c13a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok I=E2=80=99ll do that the next time Stephen. Could you please allow this =
one
through?

Also, how would you recommend I split it? Can I do it by file?

What=E2=80=99s the patch limit?

Thanks,

;) Manish (x1380)


On Wed, Oct 15, 2025 at 15:09 Stephen Hemminger <stephen@networkplumber.org=
>
wrote:

> On Wed, 15 Oct 2025 14:20:00 -0400
> Manish Kurup <manish.kurup@broadcom.com> wrote:
>
> > Hi Stephen,
> >
> > To reiterate, this happened for V2 as well. I remember seeing a warning
> > about the size of the patch, and that being the reason it was dropped.
> >
> > Could you please explain why this happens? How can I ensure that this
> > doesnt happen again?
> >
> > Thanks a lot!
> >
> >
> > On Wed, Oct 15, 2025 at 1:52=E2=80=AFPM Ajit Khaparde <
> ajit.khaparde@broadcom.com>
> > wrote:
> >
> > > On Wed, Oct 15, 2025 at 10:43=E2=80=AFAM Stephen Hemminger
> > > <stephen@networkplumber.org> wrote:
> > > >
> > > > On Wed, 15 Oct 2025 04:59:30 -0400
> > > > Manish Kurup <manish.kurup@broadcom.com> wrote:
> > > >
> > > > > Apart from bug fixes, this patchset adds the following
> > > > > functionality:
> > > > >
> > > > > 1. Add the data, defines and enums for applications targeting
> > > > >    Wh+, P5, P7 product families.
> > > > > 2. Update HSI files (HWRM API defintions, enums, version number)
> > > > > 3. Dynamic UPAR support for THOR2.
> > > > > 4. Add support to allow multiple instances of applications to
> > > > >    exist at the same time.
> > > > > 5. Add hot upgrade support for applications.
> > > > > 6. Add MPLS packet offload support.
> > > > > 7. Improve backing store debug capabilities.
> > > > > 8. Add truflow global table scope support.
> > > > > 9. ULP parser support to handle GRE key.
> > > > >
> > > > > v1->v2:
> > > > > 1. Fixed typos in commit messages
> > > > > 2. Removed incorrect tabs in meson.build
> > > > > 3. Fixed ENODATA return value for BSD
> > > > > 4. Removed unused function bnxt_mpc_bds_in_hw()
> > > > > 5. Fixed questionable pointer cast warning
> > > > > 6. Ignoring function argument mispelling warnings
> > > > >
> > > > > v2->v3:
> > > > > 1. Fixed all sprintf format string warnings.
> > > > > 2. Fixed additional pointer size warnings.
> > > > >
> > > > > Please apply.
> > > > >
> > > > > Farah Smith (8):
> > > > >   net/bnxt/tf_core: thor2 TF table scope sizing adjustments
> > > > >   net/bnxt/tf_core: tcam manager logical id free
> > > > >   net/bnxt/tf_core: thor2 hot upgrade ungraceful quit crash
> > > > >   net/bnxt/tf_core: truflow global table scope
> > > > >   net/bnxt/tf_ulp: socket direct enable
> > > > >   net/bnxt: fix adding udp_tunnel_port
> > > > >   net/bnxt: thor2 truflow memory manager bug
> > > > >   net/bnxt/tf_core: fix truflow PF init failure on sriov disabled
> > > > >
> > > > > Jay Ding (4):
> > > > >   net/bnxt: fix a NULL pointer dereference in bnxt_rep funcs
> > > > >   net/bnxt/tf_ulp: add meter stats support for Thor2
> > > > >   net/bnxt/tf_core: fix the miscalculation of the lkup table pool
> > > > >   next/bnxt/tf_ulp: truflow fixes for meter and mac_addr cache
> > > > >
> > > > > Kishore Padmanabha (18):
> > > > >   net/bnxt: enable vector mode processing
> > > > >   net/bnxt/tf_ulp: add support for global identifiers
> > > > >   net/bnxt/tf_core: add support for multi instance
> > > > >   net/bnxt/tf_core: fix table scope free
> > > > >   net/bnxt/tf_core: fix vfr clean up and stats lockup
> > > > >   net/bnxt/tf_ulp: increase shared pool size to 32
> > > > >   net/bnxt/tf_ulp: add support for tcam priority update
> > > > >   net/bnxt/tf_ulp: hot upgrade support
> > > > >   net/bnxt/tf_ulp: fix stats counter memory initialization
> > > > >   net/bnxt: fix max VFs count for thor2
> > > > >   net/bnxt/tf_ulp: enable support for global index table
> > > > >   net/bnxt/tf_ulp: optimize template enums
> > > > >   net/bnxt/tf_ulp: add non vfr mode capability
> > > > >   net/bnxt: fix stats collection when rx queue is not set
> > > > >   net/bnxt: fix rss configuration when set to none
> > > > >   net/bnxt: packet drop after port stop and start
> > > > >   net/bnxt/tf_ulp: add support for unicast only feature
> > > > >   net/bnxt: add support for truflow promiscuous mode
> > > > >
> > > > > Manish Kurup (6):
> > > > >   net/bnxt/tf_ulp: add bnxt app data for 25.11
> > > > >   net/bnxt/tf_core: dynamic UPAR support for THOR2
> > > > >   net/bnxt: add meson build options for TruFlow
> > > > >   net/bnxt: truflow HSI struct fixes
> > > > >   net/bnxt/tf_ulp: fixes to enable TF functionality
> > > > >   net/bnxt/tf_ulp: remove Truflow DEBUG code
> > > > >
> > > > > Peter Spreadborough (6):
> > > > >   net/bnxt/tf_ulp: ovs-dpdk packet drop observed with thor2
> > > > >   net/bnxt/tf_core: add backing store debug to dpdk
> > > > >   net/bnxt/tf_core: handle out of order MPC completions
> > > > >   net/bnxt: avoid potential segfault in VFR handling
> > > > >   net/bnxt/tf_core: fix truflow crash on memory allocation failur=
e
> > > > >   net/bnxt/tf_core: remove excessive debug logging
> > > > >
> > > > > Sangtani Parag Satishbhai (3):
> > > > >   net/bnxt/tf_ulp: fix seg fault when devargs argument missing
> > > > >   net/bnxt: truflow remove redundant code for mpc init
> > > > >   net/bnxt: truflow remove RTE devarg processing for mpc=3D1
> > > > >
> > > > > Shahaji Bhosle (4):
> > > > >   net/bnxt/tf_ulp: ulp parser support to handle gre key
> > > > >   net/bnxt/tf_ulp: change rte_mem_virt2iova to rte_mem_virt2phys
> > > > >   net/bnxt/tf_ulp: truflow add pf action handler
> > > > >   net/bnxt/tf_ulp: add feature bit rx miss handling
> > > > >
> > > > > Shuanglin Wang (2):
> > > > >   net/bnxt/tf_core: fix build failure with flow scale option
> > > > >   net/bnxt/tf_ulp: support MPLS packets
> > > > >
> > > > > Smitha Pisupati (1):
> > > > >   net/bnxt/tf_ulp: add support for special vxlan
> > > > >
> > > > > Sriharsha Basavapatna (2):
> > > > >   net/bnxt: fix default rss config
> > > > >   net/bnxt: avoid iova range check when external memory is used
> > > > >
> > > > >  drivers/net/bnxt/bnxt.h                       |     7 +
> > > > >  drivers/net/bnxt/bnxt_ethdev.c                |   256 +-
> > > > >  drivers/net/bnxt/bnxt_hwrm.c                  |    25 +-
> > > > >  drivers/net/bnxt/bnxt_mpc.c                   |    26 +-
> > > > >  drivers/net/bnxt/bnxt_mpc.h                   |     7 +-
> > > > >  drivers/net/bnxt/bnxt_reps.c                  |    37 +-
> > > > >  drivers/net/bnxt/bnxt_stats.c                 |     5 +
> > > > >  drivers/net/bnxt/bnxt_txr.c                   |     5 +-
> > > > >  drivers/net/bnxt/bnxt_vnic.c                  |    21 +-
> > > > >  .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |    33 +-
> > > > >  .../net/bnxt/hcapi/cfa_v3/include/cfa_types.h |    10 +
> > > > >  drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c     |    83 +-
> > > > >  .../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h    |     2 +-
> > > > >  drivers/net/bnxt/hsi_struct_def_dpdk.h        |  1123 +-
> > > > >  drivers/net/bnxt/tf_core/cfa_tcam_mgr.c       |    35 +-
> > > > >  .../net/bnxt/tf_core/cfa_tcam_mgr_device.h    |     6 +-
> > > > >  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c    |     2 +-
> > > > >  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c   |     2 +-
> > > > >  drivers/net/bnxt/tf_core/tf_resources.c       |     2 +-
> > > > >  drivers/net/bnxt/tf_core/tf_util.c            |     2 +
> > > > >  drivers/net/bnxt/tf_core/v3/meson.build       |     4 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc.h             |   238 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_act.c         |    47 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_cpm.c         |    13 +
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_debug.h       |    12 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_em.c          |   143 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_em.h          |   105 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_global_id.c   |    45 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c |   142 +
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c     |    51 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c   |  1411 +
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c   |   565 -
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_msg.c         |   363 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_msg.h         |    41 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_resources.c   |    12 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c   |   246 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_tcam.c        |    55 +
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c  |  1875 +
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_util.c        |    23 +
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_util.h        |    14 +
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c   |     3 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h   |     4 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfo.c             |   211 +-
> > > > >  drivers/net/bnxt/tf_core/v3/tfo.h             |    53 +-
> > > > >  drivers/net/bnxt/tf_ulp/bnxt_tf_common.h      |     5 -
> > > > >  drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c    |     6 -
> > > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp.h            |     6 +
> > > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c       |    10 +
> > > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c      |    55 +-
> > > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c         |    27 +-
> > > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c        |   147 +-
> > > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h        |     5 +
> > > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h      |    82 +-
> > > > >  .../generic_templates/ulp_template_db_act.c   |     6 +-
> > > > >  .../generic_templates/ulp_template_db_class.c |  8808 ++--
> > > > >  .../generic_templates/ulp_template_db_defs.h  |    88 +
> > > > >  .../generic_templates/ulp_template_db_field.h |     5 +-
> > > > >  .../generic_templates/ulp_template_db_tbl.c   |   267 +-
> > > > >  .../ulp_template_db_thor2_act.c               |  4637 +-
> > > > >  .../ulp_template_db_thor2_class.c             | 42439
> +++++++++-------
> > > > >  .../ulp_template_db_thor_act.c                |    14 +-
> > > > >  .../ulp_template_db_thor_class.c              | 13247 ++---
> > > > >  .../ulp_template_db_wh_plus_act.c             |     2 +-
> > > > >  .../ulp_template_db_wh_plus_class.c           |    26 +-
> > > > >  drivers/net/bnxt/tf_ulp/meson.build           |    56 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c       |     4 -
> > > > >  drivers/net/bnxt/tf_ulp/ulp_def_rules.c       |    38 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c          |    50 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h          |    11 +
> > > > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c       |     3 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c      |    64 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_flow_db.c         |    10 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_flow_db.h         |     6 +
> > > > >  drivers/net/bnxt/tf_ulp/ulp_gen_hash.c        |     2 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c         |    24 +
> > > > >  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h         |    12 +
> > > > >  drivers/net/bnxt/tf_ulp/ulp_mapper.c          |   326 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_mapper.h          |    56 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c       |    81 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c      |   347 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_matcher.c         |     9 -
> > > > >  drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |     8 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_rte_parser.c      |   141 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_rte_parser.h      |    10 +
> > > > >  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |   137 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h          |     4 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c      |     1 -
> > > > >  .../ulp_template_db_enum.h                    |   333 +-
> > > > >  drivers/net/bnxt/tf_ulp/ulp_template_struct.h |     5 +
> > > > >  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c      |   264 +
> > > > >  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h      |    40 +
> > > > >  meson_options.txt                             |     4 +
> > > > >  92 files changed, 48710 insertions(+), 30583 deletions(-)
> > > > >  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c
> > > > >  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
> > > > >  delete mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c
> > > > >  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
> > > > >  create mode 100644
> > > drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_defs.h
> > > > >  rename drivers/net/bnxt/tf_ulp/{generic_templates =3D>
> > > }/ulp_template_db_enum.h (88%)
> > > > >  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
> > > > >  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h
> > > > >
> > > >
> > > > I was looking to see if the bug detected with LTO (misuse of
> rte_free)
> > > > was in this patchset.
> > > Stephen,
> > > I don't see patch [01/54] on patchwork yet.
> > > From what I am told, that patch adds the ulp_template_db_defs.h
> > >
> > > Thanks
> > >
> > > >
> > > > But it fails to build:
> > > > [838/3632] Compiling C object
> > > drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o
> > > > FAILED: drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o
> > > > cc -Idrivers/libtmp_rte_net_bnxt.a.p -Idrivers -I../drivers
> > > -Idrivers/net/bnxt -I../drivers/net/bnxt -Idrivers/net/bnxt/tf_ulp
> > > -I../drivers/net/bnxt/tf_ulp
> -Idrivers/net/bnxt/tf_ulp/generic_templates
> > > -I../drivers/net/bnxt/tf_ulp/generic_templates
> -Idrivers/net/bnxt/tf_core
> > > -I../drivers/net/bnxt/tf_core -Idrivers/net/bnxt/tf_core/v3
> > > -I../drivers/net/bnxt/tf_core/v3 -Idrivers/net/bnxt/hcapi/cfa
> > > -I../drivers/net/bnxt/hcapi/cfa -Idrivers/net/bnxt/hcapi/cfa_v3
> > > -I../drivers/net/bnxt/hcapi/cfa_v3
> > > -I../drivers/net/bnxt/hcapi/cfa_v3/include
> > > -I../drivers/net/bnxt/hcapi/cfa_v3/include/platform/dpdk
> > > -I../drivers/net/bnxt/hcapi/cfa_v3/bld/p70
> > > -I../drivers/net/bnxt/hcapi/cfa_v3/bld/p70/host
> > > -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include
> > > -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include/host
> > > -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include/p70
> > > -I../drivers/net/bnxt/hcapi/cfa_v3/mm/include
> > > -I../drivers/net/bnxt/hcapi/cfa_v3/tim/include
> > > -I../drivers/net/bnxt/hcapi/cfa_v3/tpm/include -Ilib/ethdev
> -I../lib/ethdev
> > > -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config
> > > -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include
> > > -I../lib/eal/linux/include -Ilib/eal/x86/include
> -I../lib/eal/x86/include
> > > -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs
> > > -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry
> > > -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net
> -I../lib/net
> > > -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring
> > > -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci
> > > -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pc=
i
> > > -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/hash -I../lib/hash
> -Ilib/rcu
> > > -I../lib/rcu -I/usr/include/x86_64-linux-gnu -flto=3Dauto
> > > -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid=
-pch
> > > -Wextra -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual
> -Wdeprecated
> > > -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations
> > > -Wmissing-prototypes -Wnested-externs -Wold-style-definition
> > > -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef
> -Wwrite-strings
> > > -Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE
> > > -ffat-lto-objects -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_AP=
I
> > > -DALLOW_INTERNAL_API -Wno-format-truncation
> -Wno-address-of-packed-member
> > > -Wno-vla -DBNXT_TF_APP_ID=3D0 -DSUPPORT_CFA_HW_P70=3D1
> -DCFA_BLD_PRINT_OBJ=3D1
> > > -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.bnxt -MD -MQ
> > > drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o -MF
> > > drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o.d -o
> > > drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o -c
> > > ../drivers/net/bnxt/bnxt_cpr.c
> > > > In file included from ../drivers/net/bnxt/tf_ulp/bnxt_ulp.h:18,
> > > >                  from ../drivers/net/bnxt/bnxt.h:28,
> > > >                  from ../drivers/net/bnxt/bnxt_cpr.c:10:
> > > > ../drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h:9:10: fatal
> error:
> > > ulp_template_db_defs.h: No such file or directory
> > > >     9 | #include "ulp_template_db_defs.h"
> > > >       |          ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > compilation terminated.
> > > >
> > >
> >
> >
>
> I think mailing list and patchwork have size limits.
> You might need to split big ones.
>

--0000000000000f8e49064137c13a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ok I=E2=80=99ll do that the next time Stephen. Could you =
please allow this one through?</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Also, how would you recommend I split it? Can I do it by file?<br cl=
ear=3D"all"><br>What=E2=80=99s the patch limit?</div><div dir=3D"auto"><br>=
Thanks,</div><div dir=3D"auto"><br clear=3D"all"><div dir=3D"auto"><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr"><font face=3D"tahoma, sans-serif">;) Manish (x1380)</font></div=
></div></div></div><div><br></div><div><br><div class=3D"gmail_quote gmail_=
quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 15, 2025=
 at 15:09 Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.or=
g">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">On Wed, 15 Oct 2025 14:20:00 -0400<br>
Manish Kurup &lt;<a href=3D"mailto:manish.kurup@broadcom.com" target=3D"_bl=
ank">manish.kurup@broadcom.com</a>&gt; wrote:<br>
<br>
&gt; Hi Stephen,<br>
&gt; <br>
&gt; To reiterate, this happened for V2 as well. I remember seeing a warnin=
g<br>
&gt; about the size of the patch, and that being the reason it was dropped.=
<br>
&gt; <br>
&gt; Could you please explain why this happens? How can I ensure that this<=
br>
&gt; doesnt happen again?<br>
&gt; <br>
&gt; Thanks a lot!<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Oct 15, 2025 at 1:52=E2=80=AFPM Ajit Khaparde &lt;<a href=3D"m=
ailto:ajit.khaparde@broadcom.com" target=3D"_blank">ajit.khaparde@broadcom.=
com</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Wed, Oct 15, 2025 at 10:43=E2=80=AFAM Stephen Hemminger<br>
&gt; &gt; &lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_blan=
k">stephen@networkplumber.org</a>&gt; wrote:=C2=A0 <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, 15 Oct 2025 04:59:30 -0400<br>
&gt; &gt; &gt; Manish Kurup &lt;<a href=3D"mailto:manish.kurup@broadcom.com=
" target=3D"_blank">manish.kurup@broadcom.com</a>&gt; wrote:<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt; &gt; Apart from bug fixes, this patchset adds the following<=
br>
&gt; &gt; &gt; &gt; functionality:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; 1. Add the data, defines and enums for applications tar=
geting<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 Wh+, P5, P7 product families.<br>
&gt; &gt; &gt; &gt; 2. Update HSI files (HWRM API defintions, enums, versio=
n number)<br>
&gt; &gt; &gt; &gt; 3. Dynamic UPAR support for THOR2.<br>
&gt; &gt; &gt; &gt; 4. Add support to allow multiple instances of applicati=
ons to<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 exist at the same time.<br>
&gt; &gt; &gt; &gt; 5. Add hot upgrade support for applications.<br>
&gt; &gt; &gt; &gt; 6. Add MPLS packet offload support.<br>
&gt; &gt; &gt; &gt; 7. Improve backing store debug capabilities.<br>
&gt; &gt; &gt; &gt; 8. Add truflow global table scope support.<br>
&gt; &gt; &gt; &gt; 9. ULP parser support to handle GRE key.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; v1-&gt;v2:<br>
&gt; &gt; &gt; &gt; 1. Fixed typos in commit messages<br>
&gt; &gt; &gt; &gt; 2. Removed incorrect tabs in meson.build<br>
&gt; &gt; &gt; &gt; 3. Fixed ENODATA return value for BSD<br>
&gt; &gt; &gt; &gt; 4. Removed unused function bnxt_mpc_bds_in_hw()<br>
&gt; &gt; &gt; &gt; 5. Fixed questionable pointer cast warning<br>
&gt; &gt; &gt; &gt; 6. Ignoring function argument mispelling warnings<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; v2-&gt;v3:<br>
&gt; &gt; &gt; &gt; 1. Fixed all sprintf format string warnings.<br>
&gt; &gt; &gt; &gt; 2. Fixed additional pointer size warnings.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Please apply.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Farah Smith (8):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: thor2 TF table scope sizi=
ng adjustments<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: tcam manager logical id f=
ree<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: thor2 hot upgrade ungrace=
ful quit crash<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: truflow global table scop=
e<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: socket direct enable<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: fix adding udp_tunnel_port<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: thor2 truflow memory manager bug<=
br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix truflow PF init failu=
re on sriov disabled<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Jay Ding (4):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: fix a NULL pointer dereference in=
 bnxt_rep funcs<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add meter stats support fo=
r Thor2<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix the miscalculation of=
 the lkup table pool<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0next/bnxt/tf_ulp: truflow fixes for meter a=
nd mac_addr cache<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Kishore Padmanabha (18):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: enable vector mode processing<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add support for global ide=
ntifiers<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: add support for multi ins=
tance<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix table scope free<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix vfr clean up and stat=
s lockup<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: increase shared pool size =
to 32<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add support for tcam prior=
ity update<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: hot upgrade support<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: fix stats counter memory i=
nitialization<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: fix max VFs count for thor2<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: enable support for global =
index table<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: optimize template enums<br=
>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add non vfr mode capabilit=
y<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: fix stats collection when rx queu=
e is not set<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: fix rss configuration when set to=
 none<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: packet drop after port stop and s=
tart<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add support for unicast on=
ly feature<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: add support for truflow promiscuo=
us mode<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Manish Kurup (6):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add bnxt app data for 25.1=
1<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: dynamic UPAR support for =
THOR2<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: add meson build options for TruFl=
ow<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: truflow HSI struct fixes<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: fixes to enable TF functio=
nality<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: remove Truflow DEBUG code<=
br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Peter Spreadborough (6):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: ovs-dpdk packet drop obser=
ved with thor2<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: add backing store debug t=
o dpdk<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: handle out of order MPC c=
ompletions<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: avoid potential segfault in VFR h=
andling<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix truflow crash on memo=
ry allocation failure<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: remove excessive debug lo=
gging<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Sangtani Parag Satishbhai (3):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: fix seg fault when devargs=
 argument missing<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: truflow remove redundant code for=
 mpc init<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: truflow remove RTE devarg process=
ing for mpc=3D1<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Shahaji Bhosle (4):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: ulp parser support to hand=
le gre key<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: change rte_mem_virt2iova t=
o rte_mem_virt2phys<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: truflow add pf action hand=
ler<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add feature bit rx miss ha=
ndling<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Shuanglin Wang (2):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_core: fix build failure with fl=
ow scale option<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: support MPLS packets<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Smitha Pisupati (1):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt/tf_ulp: add support for special vx=
lan<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Sriharsha Basavapatna (2):<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: fix default rss config<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0net/bnxt: avoid iova range check when exter=
nal memory is used<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/bnxt.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =
=C2=A07 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_ethdev.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0256 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_hwrm.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 25 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_mpc.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 26 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_mpc.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A07 +-<b=
r>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_reps.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 37 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_stats.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A05 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_txr.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A05 +-<b=
r>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/bnxt_vnic.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 21 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |=
=C2=A0 =C2=A0 33 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 .../net/bnxt/hcapi/cfa_v3/include/cfa_types.h |=
=C2=A0 =C2=A0 10 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c=C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 83 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 .../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h=C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/hsi_struct_def_dpdk.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 1123 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/cfa_tcam_mgr.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 35 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 .../net/bnxt/tf_core/cfa_tcam_mgr_device.h=C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 =C2=A06 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c=C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c=C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/tf_resources.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/tf_util.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A02 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/meson.build=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A04 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0238 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_act.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 47 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_cpm.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 13 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_debug.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 12 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_em.c=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0143 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_em.h=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0105 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_global_id.c=C2=A0=
 =C2=A0|=C2=A0 =C2=A0 45 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c |=
=C2=A0 =C2=A0142 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c=C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 51 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c=C2=A0=
 =C2=A0|=C2=A0 1411 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c=C2=A0=
 =C2=A0|=C2=A0 =C2=A0565 -<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_msg.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0363 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_msg.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 41 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_resources.c=C2=A0=
 =C2=A0|=C2=A0 =C2=A0 12 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c=C2=A0=
 =C2=A0|=C2=A0 =C2=A0246 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_tcam.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 55 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c=C2=
=A0 |=C2=A0 1875 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_util.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 23 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_util.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 14 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c=C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A03 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h=C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A04 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfo.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0211 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_core/v3/tfo.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 53 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_tf_common.h=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A05 -<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c=C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 =C2=A06 -<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A06 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 10 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 55 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 27 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0147 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A05 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 82 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 .../generic_templates/ulp_template_db_act.c=C2=A0=
 =C2=A0|=C2=A0 =C2=A0 =C2=A06 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 .../generic_templates/ulp_template_db_class.c |=
=C2=A0 8808 ++--<br>
&gt; &gt; &gt; &gt;=C2=A0 .../generic_templates/ulp_template_db_defs.h=C2=
=A0 |=C2=A0 =C2=A0 88 +<br>
&gt; &gt; &gt; &gt;=C2=A0 .../generic_templates/ulp_template_db_field.h |=
=C2=A0 =C2=A0 =C2=A05 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 .../generic_templates/ulp_template_db_tbl.c=C2=A0=
 =C2=A0|=C2=A0 =C2=A0267 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 .../ulp_template_db_thor2_act.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4637 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 .../ulp_template_db_thor2_class.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 42439 +++++++++-------<br>
&gt; &gt; &gt; &gt;=C2=A0 .../ulp_template_db_thor_act.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 14 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 .../ulp_template_db_thor_class.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 13247 ++---<br>
&gt; &gt; &gt; &gt;=C2=A0 .../ulp_template_db_wh_plus_act.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 .../ulp_template_db_wh_plus_class.c=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 26 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/meson.build=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 56 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A04 -<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_def_rules.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 38 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 50 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 11 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A03 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 64 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_flow_db.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 10 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_flow_db.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A06 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_gen_hash.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 24 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 12 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_mapper.c=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0326 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_mapper.h=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 56 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 81 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0347 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_matcher.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A09 -<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |=
=C2=A0 =C2=A0 =C2=A08 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0141 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_rte_parser.h=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 10 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0137 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A04 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A01 -<br>
&gt; &gt; &gt; &gt;=C2=A0 .../ulp_template_db_enum.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0333 +-<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_template_struct.h |=
=C2=A0 =C2=A0 =C2=A05 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0264 +<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h=C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 40 +<br>
&gt; &gt; &gt; &gt;=C2=A0 meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A04 +<br>
&gt; &gt; &gt; &gt;=C2=A0 92 files changed, 48710 insertions(+), 30583 dele=
tions(-)<br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 drivers/net/bnxt/tf_core/v3/tf=
c_hot_upgrade.c<br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 drivers/net/bnxt/tf_core/v3/tf=
c_mpc_debug.c<br>
&gt; &gt; &gt; &gt;=C2=A0 delete mode 100644 drivers/net/bnxt/tf_core/v3/tf=
c_mpc_table.c<br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 drivers/net/bnxt/tf_core/v3/tf=
c_tcam_debug.c<br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644=C2=A0 <br>
&gt; &gt; drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_defs.h=
=C2=A0 <br>
&gt; &gt; &gt; &gt;=C2=A0 rename drivers/net/bnxt/tf_ulp/{generic_templates=
 =3D&gt;=C2=A0 <br>
&gt; &gt; }/ulp_template_db_enum.h (88%)=C2=A0 <br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tf=
c_ha_mgr.c<br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tf=
c_ha_mgr.h<br>
&gt; &gt; &gt; &gt;=C2=A0 <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I was looking to see if the bug detected with LTO (misuse of=
 rte_free)<br>
&gt; &gt; &gt; was in this patchset.=C2=A0 <br>
&gt; &gt; Stephen,<br>
&gt; &gt; I don&#39;t see patch [01/54] on patchwork yet.<br>
&gt; &gt; From what I am told, that patch adds the ulp_template_db_defs.h<b=
r>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; But it fails to build:<br>
&gt; &gt; &gt; [838/3632] Compiling C object=C2=A0 <br>
&gt; &gt; drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o=C2=A0 <br>
&gt; &gt; &gt; FAILED: drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.=
o<br>
&gt; &gt; &gt; cc -Idrivers/libtmp_rte_net_bnxt.a.p -Idrivers -I../drivers=
=C2=A0 <br>
&gt; &gt; -Idrivers/net/bnxt -I../drivers/net/bnxt -Idrivers/net/bnxt/tf_ul=
p<br>
&gt; &gt; -I../drivers/net/bnxt/tf_ulp -Idrivers/net/bnxt/tf_ulp/generic_te=
mplates<br>
&gt; &gt; -I../drivers/net/bnxt/tf_ulp/generic_templates -Idrivers/net/bnxt=
/tf_core<br>
&gt; &gt; -I../drivers/net/bnxt/tf_core -Idrivers/net/bnxt/tf_core/v3<br>
&gt; &gt; -I../drivers/net/bnxt/tf_core/v3 -Idrivers/net/bnxt/hcapi/cfa<br>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa -Idrivers/net/bnxt/hcapi/cfa_v3<b=
r>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa_v3<br>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa_v3/include<br>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa_v3/include/platform/dpdk<br>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa_v3/bld/p70<br>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa_v3/bld/p70/host<br>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include<br>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include/host<br>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include/p70<br>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa_v3/mm/include<br>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa_v3/tim/include<br>
&gt; &gt; -I../drivers/net/bnxt/hcapi/cfa_v3/tpm/include -Ilib/ethdev -I../=
lib/ethdev<br>
&gt; &gt; -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../confi=
g<br>
&gt; &gt; -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include<br=
>
&gt; &gt; -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86=
/include<br>
&gt; &gt; -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kv=
args<br>
&gt; &gt; -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telem=
etry<br>
&gt; &gt; -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I.=
./lib/net<br>
&gt; &gt; -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/rin=
g<br>
&gt; &gt; -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci<br>
&gt; &gt; -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../li=
b/pci<br>
&gt; &gt; -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/hash -I../lib/hash=
 -Ilib/rcu<br>
&gt; &gt; -I../lib/rcu -I/usr/include/x86_64-linux-gnu -flto=3Dauto<br>
&gt; &gt; -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winv=
alid-pch<br>
&gt; &gt; -Wextra -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -W=
deprecated<br>
&gt; &gt; -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarat=
ions<br>
&gt; &gt; -Wmissing-prototypes -Wnested-externs -Wold-style-definition<br>
&gt; &gt; -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrit=
e-strings<br>
&gt; &gt; -Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SO=
URCE<br>
&gt; &gt; -ffat-lto-objects -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTA=
L_API<br>
&gt; &gt; -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packe=
d-member<br>
&gt; &gt; -Wno-vla -DBNXT_TF_APP_ID=3D0 -DSUPPORT_CFA_HW_P70=3D1 -DCFA_BLD_=
PRINT_OBJ=3D1<br>
&gt; &gt; -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.bnxt -MD -MQ<br>
&gt; &gt; drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o -MF<br>
&gt; &gt; drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o.d -o<br>
&gt; &gt; drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o -c<br>
&gt; &gt; ../drivers/net/bnxt/bnxt_cpr.c=C2=A0 <br>
&gt; &gt; &gt; In file included from ../drivers/net/bnxt/tf_ulp/bnxt_ulp.h:=
18,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 from ../drivers/net/bnxt/bnxt.h:28,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 from ../drivers/net/bnxt/bnxt_cpr.c:10:<br>
&gt; &gt; &gt; ../drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h:9:10: fata=
l error:=C2=A0 <br>
&gt; &gt; ulp_template_db_defs.h: No such file or directory=C2=A0 <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A09 | #include &quot;ulp_template_db_defs.h=
&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~~~~~~~~~~~~~~~~~~~~~~<br>
&gt; &gt; &gt; compilation terminated.<br>
&gt; &gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 <br>
&gt; <br>
&gt; <br>
<br>
I think mailing list and patchwork have size limits.<br>
You might need to split big ones.<br>
</blockquote></div></div>

--0000000000000f8e49064137c13a--

--000000000000274520064137c1bd
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
MjAyMwIMNmKeINO4t964SBkFMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBt1/9j
JSEn/nxvhaKx25TqLo9P6AIDYPso6uXFSPN5NzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTEwMTUxOTQ2MTlaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCQDRFeI97VmypooG2uxRr0JXQGMscysgp+UyzVzmfT
/EuajX/vLWMfwOiYThUEC043TMJW+2GctbLxq90zyeop2dbktS58LAn2nK9IFDdugKeEW9FpthaV
l+fPagoMDPRqbcJ4BDlMm28uzn3muokcF7fH8h/Cm4nxsgBUqJpiog9l/P98xHeSnlEmfmibVVIX
3hYWe+rABXSdbwk07ksFlw5wOvPAx2MFnZjb09tph3pSQ3f9TP/Vp1EnWoy7ltvnDADVsT8gs8gh
ETv+bpr7SsBYQvUfQpD1t4qvhFXADm1Y6UFmtilvcnNPqFXmiVqK9SbfhggSNAq80u5fbkyc
--000000000000274520064137c1bd--
