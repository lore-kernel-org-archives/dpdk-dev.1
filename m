Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B441BCCD195
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 19:09:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F1D640671;
	Wed, 15 Oct 2025 21:09:27 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id B9AB340273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 21:09:25 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7841da939deso6339927b3a.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760555365;
 x=1761160165; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GslqMNvKrSFsa0H890XIuUTJoArudB94QPTRrmPM7E=;
 b=PHcGAcpK6mZvrggWoMbw5Byr3IUrJb0o5XfZyVERbCi9fcxEcEdq+r3NynrJGa3LCa
 wXRf2TzQfk7hLypyWOe5LJ/8D1UeXqKQQ3YFdHWUYJo+ESxLJMFSybCVcQkER9IGxWLR
 k1+1TZxgkvkzLLv5l2ftE5LCgqh79E/Ns5u2R4PLLhLjHsECFv/LReoBiKNBhzysxVnS
 8ieS8ePKPqK/K7KDgEg73Bl7aCNFFMFP/+NR215RdxHgMFcjmQ45c5A9f1fcGiD3Isdn
 0IXcCgTcmDuM3E5OQ3Qoogcf6r2FeJnqoh3345EcWdRXjyqtwnbzE18ry58BTMnS3dpi
 62TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760555365; x=1761160165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7GslqMNvKrSFsa0H890XIuUTJoArudB94QPTRrmPM7E=;
 b=aOLlH9VQuysa+iFvfMdHuYES9DDQUALZOPLRrZvm3ioRnkNBWcsSAh2HkT78MKR03M
 oNyR8GWUESMVzwzIZ+fQ2hON9JzgNhw7I6xNunXuqacHgvdbaTJcOMOjWmD1BJT58x+m
 ZRJarzB5u08aw6TB+si7vpZD/UMaq6hoq6B3j5K2O7yeGGsslm1QsL9A1pYroRtfB5qX
 OejBHavOQjN595cyvLrcC11XKaXtCzRG76tQn3t5x0GYuew+6JdkhUXXxfiieaI/WQbb
 Z4js7xcRoCo/O3z772kCQrXnoeZ7yTzgmbratYU699MKHpXp9sI5dx3QGVZKnd9HXx4T
 UqaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtQNIjHHjEQwd7vambvnvDbBMT0P/Sj27mqJNzEjKhb+zzUEQJ0bf8iFcX58wUAnaXkwI=@dpdk.org
X-Gm-Message-State: AOJu0YwkxVu/+BzgYGroya2iT6z4tuaSU5xPf9sKgSbZmC09RzddwPN3
 PANrheNY7bcRXnGqfZoNTmqItDALdL6ObcZORU3njNneeTSFGUK9Z7ikfrUYuY7Ljk8=
X-Gm-Gg: ASbGnctEHicxdo3sw/B+98XaNy63ubyLKs0Enn5MuN74S1dKRBQ5omGlJ9cRt0SrRN3
 4hBDdKLXFSAEop0qokTM54PoHMSUjzvkxd6Qd6qKEUqGD+Lw/wZOgMpI1BCelEY329Rw619URSL
 S0SWhufQ3qnHJ3vyUxbRoemxBbwiEoc0b+kXRFqQ35/TnBRKuRUvzF9jg/86vwhPLUs8vQvQEZS
 I8h6/yZoQtfVwWV9sQOiw4V74xzv7Uc0uUgBx3axdflPQ0V5TIY5CfOW8BZi7RO+fhvuNbLs5uL
 GWzioQwnuAvV+Vqinqfhk2l++YOBHMB+2ayxlFSucMX6EXWQ21qPfkSwR119ZVCkw2eTsf/1+GK
 xePT3AS8QM+o0OeZiMZqgntTmfaA6tlcubRuXTAydQNWYt0szmsH8mF9AkzqEYEUAUcQIY1VIes
 M5sbAJDEcflFjPBak1Xw==
X-Google-Smtp-Source: AGHT+IFmJMJK2Cd0Ll9DmIMIITUl3dotExC5c13TCZW3dj3AmrDeLIzQmbVNHq9rFGGMR5YhWrl9/g==
X-Received: by 2002:a05:6a00:a8c:b0:7a1:7f3d:45dd with SMTP id
 d2e1a72fcca58-7a17f3d4987mr5175155b3a.0.1760555364516; 
 Wed, 15 Oct 2025 12:09:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a1394139c8sm4434194b3a.18.2025.10.15.12.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 12:09:24 -0700 (PDT)
Date: Wed, 15 Oct 2025 12:09:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Manish Kurup <manish.kurup@broadcom.com>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org
Subject: Re: [PATCH v3 00/54] bnxt patchset
Message-ID: <20251015120921.4db1212e@hermes.local>
In-Reply-To: <CAEKskBUo25Nx=5DhgdcsPL5roRY_C-ZyuGr7rzV30-E9zWpBgQ@mail.gmail.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251015104335.24dd7db0@hermes.local>
 <CACZ4nhttzP9F_f0km797TYyA+AOdFSfuajqnijnMYm_Lroa0Ww@mail.gmail.com>
 <CAEKskBUo25Nx=5DhgdcsPL5roRY_C-ZyuGr7rzV30-E9zWpBgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 15 Oct 2025 14:20:00 -0400
Manish Kurup <manish.kurup@broadcom.com> wrote:

> Hi Stephen,
>=20
> To reiterate, this happened for V2 as well. I remember seeing a warning
> about the size of the patch, and that being the reason it was dropped.
>=20
> Could you please explain why this happens? How can I ensure that this
> doesnt happen again?
>=20
> Thanks a lot!
>=20
>=20
> On Wed, Oct 15, 2025 at 1:52=E2=80=AFPM Ajit Khaparde <ajit.khaparde@broa=
dcom.com>
> wrote:
>=20
> > On Wed, Oct 15, 2025 at 10:43=E2=80=AFAM Stephen Hemminger
> > <stephen@networkplumber.org> wrote: =20
> > >
> > > On Wed, 15 Oct 2025 04:59:30 -0400
> > > Manish Kurup <manish.kurup@broadcom.com> wrote:
> > > =20
> > > > Apart from bug fixes, this patchset adds the following
> > > > functionality:
> > > >
> > > > 1. Add the data, defines and enums for applications targeting
> > > >    Wh+, P5, P7 product families.
> > > > 2. Update HSI files (HWRM API defintions, enums, version number)
> > > > 3. Dynamic UPAR support for THOR2.
> > > > 4. Add support to allow multiple instances of applications to
> > > >    exist at the same time.
> > > > 5. Add hot upgrade support for applications.
> > > > 6. Add MPLS packet offload support.
> > > > 7. Improve backing store debug capabilities.
> > > > 8. Add truflow global table scope support.
> > > > 9. ULP parser support to handle GRE key.
> > > >
> > > > v1->v2:
> > > > 1. Fixed typos in commit messages
> > > > 2. Removed incorrect tabs in meson.build
> > > > 3. Fixed ENODATA return value for BSD
> > > > 4. Removed unused function bnxt_mpc_bds_in_hw()
> > > > 5. Fixed questionable pointer cast warning
> > > > 6. Ignoring function argument mispelling warnings
> > > >
> > > > v2->v3:
> > > > 1. Fixed all sprintf format string warnings.
> > > > 2. Fixed additional pointer size warnings.
> > > >
> > > > Please apply.
> > > >
> > > > Farah Smith (8):
> > > >   net/bnxt/tf_core: thor2 TF table scope sizing adjustments
> > > >   net/bnxt/tf_core: tcam manager logical id free
> > > >   net/bnxt/tf_core: thor2 hot upgrade ungraceful quit crash
> > > >   net/bnxt/tf_core: truflow global table scope
> > > >   net/bnxt/tf_ulp: socket direct enable
> > > >   net/bnxt: fix adding udp_tunnel_port
> > > >   net/bnxt: thor2 truflow memory manager bug
> > > >   net/bnxt/tf_core: fix truflow PF init failure on sriov disabled
> > > >
> > > > Jay Ding (4):
> > > >   net/bnxt: fix a NULL pointer dereference in bnxt_rep funcs
> > > >   net/bnxt/tf_ulp: add meter stats support for Thor2
> > > >   net/bnxt/tf_core: fix the miscalculation of the lkup table pool
> > > >   next/bnxt/tf_ulp: truflow fixes for meter and mac_addr cache
> > > >
> > > > Kishore Padmanabha (18):
> > > >   net/bnxt: enable vector mode processing
> > > >   net/bnxt/tf_ulp: add support for global identifiers
> > > >   net/bnxt/tf_core: add support for multi instance
> > > >   net/bnxt/tf_core: fix table scope free
> > > >   net/bnxt/tf_core: fix vfr clean up and stats lockup
> > > >   net/bnxt/tf_ulp: increase shared pool size to 32
> > > >   net/bnxt/tf_ulp: add support for tcam priority update
> > > >   net/bnxt/tf_ulp: hot upgrade support
> > > >   net/bnxt/tf_ulp: fix stats counter memory initialization
> > > >   net/bnxt: fix max VFs count for thor2
> > > >   net/bnxt/tf_ulp: enable support for global index table
> > > >   net/bnxt/tf_ulp: optimize template enums
> > > >   net/bnxt/tf_ulp: add non vfr mode capability
> > > >   net/bnxt: fix stats collection when rx queue is not set
> > > >   net/bnxt: fix rss configuration when set to none
> > > >   net/bnxt: packet drop after port stop and start
> > > >   net/bnxt/tf_ulp: add support for unicast only feature
> > > >   net/bnxt: add support for truflow promiscuous mode
> > > >
> > > > Manish Kurup (6):
> > > >   net/bnxt/tf_ulp: add bnxt app data for 25.11
> > > >   net/bnxt/tf_core: dynamic UPAR support for THOR2
> > > >   net/bnxt: add meson build options for TruFlow
> > > >   net/bnxt: truflow HSI struct fixes
> > > >   net/bnxt/tf_ulp: fixes to enable TF functionality
> > > >   net/bnxt/tf_ulp: remove Truflow DEBUG code
> > > >
> > > > Peter Spreadborough (6):
> > > >   net/bnxt/tf_ulp: ovs-dpdk packet drop observed with thor2
> > > >   net/bnxt/tf_core: add backing store debug to dpdk
> > > >   net/bnxt/tf_core: handle out of order MPC completions
> > > >   net/bnxt: avoid potential segfault in VFR handling
> > > >   net/bnxt/tf_core: fix truflow crash on memory allocation failure
> > > >   net/bnxt/tf_core: remove excessive debug logging
> > > >
> > > > Sangtani Parag Satishbhai (3):
> > > >   net/bnxt/tf_ulp: fix seg fault when devargs argument missing
> > > >   net/bnxt: truflow remove redundant code for mpc init
> > > >   net/bnxt: truflow remove RTE devarg processing for mpc=3D1
> > > >
> > > > Shahaji Bhosle (4):
> > > >   net/bnxt/tf_ulp: ulp parser support to handle gre key
> > > >   net/bnxt/tf_ulp: change rte_mem_virt2iova to rte_mem_virt2phys
> > > >   net/bnxt/tf_ulp: truflow add pf action handler
> > > >   net/bnxt/tf_ulp: add feature bit rx miss handling
> > > >
> > > > Shuanglin Wang (2):
> > > >   net/bnxt/tf_core: fix build failure with flow scale option
> > > >   net/bnxt/tf_ulp: support MPLS packets
> > > >
> > > > Smitha Pisupati (1):
> > > >   net/bnxt/tf_ulp: add support for special vxlan
> > > >
> > > > Sriharsha Basavapatna (2):
> > > >   net/bnxt: fix default rss config
> > > >   net/bnxt: avoid iova range check when external memory is used
> > > >
> > > >  drivers/net/bnxt/bnxt.h                       |     7 +
> > > >  drivers/net/bnxt/bnxt_ethdev.c                |   256 +-
> > > >  drivers/net/bnxt/bnxt_hwrm.c                  |    25 +-
> > > >  drivers/net/bnxt/bnxt_mpc.c                   |    26 +-
> > > >  drivers/net/bnxt/bnxt_mpc.h                   |     7 +-
> > > >  drivers/net/bnxt/bnxt_reps.c                  |    37 +-
> > > >  drivers/net/bnxt/bnxt_stats.c                 |     5 +
> > > >  drivers/net/bnxt/bnxt_txr.c                   |     5 +-
> > > >  drivers/net/bnxt/bnxt_vnic.c                  |    21 +-
> > > >  .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |    33 +-
> > > >  .../net/bnxt/hcapi/cfa_v3/include/cfa_types.h |    10 +
> > > >  drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c     |    83 +-
> > > >  .../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h    |     2 +-
> > > >  drivers/net/bnxt/hsi_struct_def_dpdk.h        |  1123 +-
> > > >  drivers/net/bnxt/tf_core/cfa_tcam_mgr.c       |    35 +-
> > > >  .../net/bnxt/tf_core/cfa_tcam_mgr_device.h    |     6 +-
> > > >  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c    |     2 +-
> > > >  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c   |     2 +-
> > > >  drivers/net/bnxt/tf_core/tf_resources.c       |     2 +-
> > > >  drivers/net/bnxt/tf_core/tf_util.c            |     2 +
> > > >  drivers/net/bnxt/tf_core/v3/meson.build       |     4 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc.h             |   238 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_act.c         |    47 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_cpm.c         |    13 +
> > > >  drivers/net/bnxt/tf_core/v3/tfc_debug.h       |    12 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_em.c          |   143 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_em.h          |   105 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_global_id.c   |    45 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c |   142 +
> > > >  drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c     |    51 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c   |  1411 +
> > > >  drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c   |   565 -
> > > >  drivers/net/bnxt/tf_core/v3/tfc_msg.c         |   363 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_msg.h         |    41 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_resources.c   |    12 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c   |   246 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_tcam.c        |    55 +
> > > >  drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c  |  1875 +
> > > >  drivers/net/bnxt/tf_core/v3/tfc_util.c        |    23 +
> > > >  drivers/net/bnxt/tf_core/v3/tfc_util.h        |    14 +
> > > >  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c   |     3 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h   |     4 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfo.c             |   211 +-
> > > >  drivers/net/bnxt/tf_core/v3/tfo.h             |    53 +-
> > > >  drivers/net/bnxt/tf_ulp/bnxt_tf_common.h      |     5 -
> > > >  drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c    |     6 -
> > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp.h            |     6 +
> > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c       |    10 +
> > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c      |    55 +-
> > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c         |    27 +-
> > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c        |   147 +-
> > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h        |     5 +
> > > >  drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h      |    82 +-
> > > >  .../generic_templates/ulp_template_db_act.c   |     6 +-
> > > >  .../generic_templates/ulp_template_db_class.c |  8808 ++--
> > > >  .../generic_templates/ulp_template_db_defs.h  |    88 +
> > > >  .../generic_templates/ulp_template_db_field.h |     5 +-
> > > >  .../generic_templates/ulp_template_db_tbl.c   |   267 +-
> > > >  .../ulp_template_db_thor2_act.c               |  4637 +-
> > > >  .../ulp_template_db_thor2_class.c             | 42439 +++++++++---=
----
> > > >  .../ulp_template_db_thor_act.c                |    14 +-
> > > >  .../ulp_template_db_thor_class.c              | 13247 ++---
> > > >  .../ulp_template_db_wh_plus_act.c             |     2 +-
> > > >  .../ulp_template_db_wh_plus_class.c           |    26 +-
> > > >  drivers/net/bnxt/tf_ulp/meson.build           |    56 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c       |     4 -
> > > >  drivers/net/bnxt/tf_ulp/ulp_def_rules.c       |    38 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c          |    50 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h          |    11 +
> > > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c       |     3 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c      |    64 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_flow_db.c         |    10 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_flow_db.h         |     6 +
> > > >  drivers/net/bnxt/tf_ulp/ulp_gen_hash.c        |     2 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c         |    24 +
> > > >  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h         |    12 +
> > > >  drivers/net/bnxt/tf_ulp/ulp_mapper.c          |   326 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_mapper.h          |    56 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c       |    81 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c      |   347 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_matcher.c         |     9 -
> > > >  drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |     8 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_rte_parser.c      |   141 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_rte_parser.h      |    10 +
> > > >  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |   137 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h          |     4 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c      |     1 -
> > > >  .../ulp_template_db_enum.h                    |   333 +-
> > > >  drivers/net/bnxt/tf_ulp/ulp_template_struct.h |     5 +
> > > >  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c      |   264 +
> > > >  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h      |    40 +
> > > >  meson_options.txt                             |     4 +
> > > >  92 files changed, 48710 insertions(+), 30583 deletions(-)
> > > >  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c
> > > >  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
> > > >  delete mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c
> > > >  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
> > > >  create mode 100644 =20
> > drivers/net/bnxt/tf_ulp/generic_templates/ulp_template_db_defs.h =20
> > > >  rename drivers/net/bnxt/tf_ulp/{generic_templates =3D> =20
> > }/ulp_template_db_enum.h (88%) =20
> > > >  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
> > > >  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h
> > > > =20
> > >
> > > I was looking to see if the bug detected with LTO (misuse of rte_free)
> > > was in this patchset. =20
> > Stephen,
> > I don't see patch [01/54] on patchwork yet.
> > From what I am told, that patch adds the ulp_template_db_defs.h
> >
> > Thanks
> > =20
> > >
> > > But it fails to build:
> > > [838/3632] Compiling C object =20
> > drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o =20
> > > FAILED: drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o
> > > cc -Idrivers/libtmp_rte_net_bnxt.a.p -Idrivers -I../drivers =20
> > -Idrivers/net/bnxt -I../drivers/net/bnxt -Idrivers/net/bnxt/tf_ulp
> > -I../drivers/net/bnxt/tf_ulp -Idrivers/net/bnxt/tf_ulp/generic_templates
> > -I../drivers/net/bnxt/tf_ulp/generic_templates -Idrivers/net/bnxt/tf_co=
re
> > -I../drivers/net/bnxt/tf_core -Idrivers/net/bnxt/tf_core/v3
> > -I../drivers/net/bnxt/tf_core/v3 -Idrivers/net/bnxt/hcapi/cfa
> > -I../drivers/net/bnxt/hcapi/cfa -Idrivers/net/bnxt/hcapi/cfa_v3
> > -I../drivers/net/bnxt/hcapi/cfa_v3
> > -I../drivers/net/bnxt/hcapi/cfa_v3/include
> > -I../drivers/net/bnxt/hcapi/cfa_v3/include/platform/dpdk
> > -I../drivers/net/bnxt/hcapi/cfa_v3/bld/p70
> > -I../drivers/net/bnxt/hcapi/cfa_v3/bld/p70/host
> > -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include
> > -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include/host
> > -I../drivers/net/bnxt/hcapi/cfa_v3/bld/include/p70
> > -I../drivers/net/bnxt/hcapi/cfa_v3/mm/include
> > -I../drivers/net/bnxt/hcapi/cfa_v3/tim/include
> > -I../drivers/net/bnxt/hcapi/cfa_v3/tpm/include -Ilib/ethdev -I../lib/et=
hdev
> > -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config
> > -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include
> > -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/inclu=
de
> > -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs
> > -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry
> > -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I../lib/=
net
> > -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring
> > -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci
> > -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci
> > -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/hash -I../lib/hash -Ilib=
/rcu
> > -I../lib/rcu -I/usr/include/x86_64-linux-gnu -flto=3Dauto
> > -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-p=
ch
> > -Wextra -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprec=
ated
> > -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations
> > -Wmissing-prototypes -Wnested-externs -Wold-style-definition
> > -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-stri=
ngs
> > -Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE
> > -ffat-lto-objects -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API
> > -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-memb=
er
> > -Wno-vla -DBNXT_TF_APP_ID=3D0 -DSUPPORT_CFA_HW_P70=3D1 -DCFA_BLD_PRINT_=
OBJ=3D1
> > -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.bnxt -MD -MQ
> > drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o -MF
> > drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o.d -o
> > drivers/libtmp_rte_net_bnxt.a.p/net_bnxt_bnxt_cpr.c.o -c
> > ../drivers/net/bnxt/bnxt_cpr.c =20
> > > In file included from ../drivers/net/bnxt/tf_ulp/bnxt_ulp.h:18,
> > >                  from ../drivers/net/bnxt/bnxt.h:28,
> > >                  from ../drivers/net/bnxt/bnxt_cpr.c:10:
> > > ../drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h:9:10: fatal error: =
=20
> > ulp_template_db_defs.h: No such file or directory =20
> > >     9 | #include "ulp_template_db_defs.h"
> > >       |          ^~~~~~~~~~~~~~~~~~~~~~~~
> > > compilation terminated.
> > > =20
> > =20
>=20
>=20

I think mailing list and patchwork have size limits.
You might need to split big ones.
