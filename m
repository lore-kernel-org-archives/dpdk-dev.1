Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA82FCCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 03:32:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09F9240150;
	Fri, 24 Oct 2025 05:32:25 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id C88B440144
 for <dev@dpdk.org>; Fri, 24 Oct 2025 05:32:23 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-292322d10feso13558935ad.0
 for <dev@dpdk.org>; Thu, 23 Oct 2025 20:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761276743; x=1761881543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WbvTSRgA9Llk3dvngDo8bIcXbSGs08QWSvc422jRRFE=;
 b=PnePs1jXX6dFoUuq6GqJwP03EY94whsRyD+VgphbfFB/pHsbasKdZNo0rU/BnAdXxn
 ryJtbkhc/MsZLeasBioW/oZnHD5Go40QDB88NDx8TtOssRD3j8X/0WCnK7YtZ4W44Oim
 M91oOnLg5HNXyaYbKiCUOXHJxwLbK1gSiYPnjyWnxo4vAMeHeh4QdDVEzED7N2XWR6p8
 xyFwAXi6bRtVM8UaC/siAJsP8HzjrcMUSqRujdmb/aAadq/BZhuxY0n5XEeQl4QwdN/E
 bkR6RiOihhO1G0EZ7wOjyYaobC+ABG9LPSHxjzGa0047Gxg+MoWb1C7m4CyBfWRZPX3j
 h2sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzH7kbn6/YPxm5ISGcBhmpfZ2eoqHjzhtKLLkIIso/PW+YD5a6wfColv6uMiT148pR/1A=@dpdk.org
X-Gm-Message-State: AOJu0YxglbmhxmHCN6+DRTAheVH17kwHV2BdG6NJgbakt3TdYmZnCX55
 XAaR9aG44sMQz5143+k8Y3xHFniPKLObgnASEAih1YuoT429rNWxAJJdYG+lBZ6P9A+bg8vRl+1
 oAFoo4KuHLyID5lXHv23fSHl/WD3UaVmWm7Ton+Se0ezkW8mbPy+68EXtOdv2ycbkkZ0VrZoR/d
 ExmYCyk4A11jKYQzCx8KBrYXszdxgTjrW9glBDjOLecyWYHM6Zl3/SyseEIRLIpWbyj/ar0UA=
X-Gm-Gg: ASbGncv8TghCRddawJXejA+WkpXyk1m/kPnLMbkRCFB1byJBAx51Ko8C2awlYbYYXY/
 sd23weUNlwXEECh1bDgiwhSoIFb8gxvEpg7vAsO0w4qXgdNbacM8+wS2pS8JVyHXcFr3VHn8yo5
 gGmW7lD3gSKMMSS1p9XNwba3zomfUdYWMWyHJgVyhGYuW3wluwiJ4W/zx08YaQpxrTelMh+y2cf
 FP/RMNSESFEa3CvfdZk8bI17cJaeHDGxovgdmaOFTLKAMjX6zDThm9Sz2ntv87EtDoojnsC2ghn
 WbGRH3jG2r+v9c2b3ShAz793/udxaX1PTxS1XB1H+usFzmsaqjqnu/BaZ0sE/bELvsMDyzsdmQ+
 mSqmArTth4a+SoHgBHQeldMUfxx5EXeWp7Jf816hWQLjwVLYAt9mBbzHAr7Oppo+Lm3XXLvkNA3
 BV0cQf1tKNkQI3Rqhcn+bCR4QEmkYd6NUYXZY=
X-Google-Smtp-Source: AGHT+IGDnD5Dlas9lgMZH2H2n5Pia0gktm7ze6MNfhG7Wq7jaS69ykgrT7Es2k7kAZFRGUFXSowGwnuLU28d
X-Received: by 2002:a17:903:1ac3:b0:27e:f03e:c6b7 with SMTP id
 d9443c01a7336-29489d96ecdmr14687465ad.10.1761276742630; 
 Thu, 23 Oct 2025 20:32:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2946dfe313fsm4253895ad.61.2025.10.23.20.32.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Oct 2025 20:32:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-87c171369aaso50595356d6.0
 for <dev@dpdk.org>; Thu, 23 Oct 2025 20:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761276741; x=1761881541; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WbvTSRgA9Llk3dvngDo8bIcXbSGs08QWSvc422jRRFE=;
 b=MwLe3URq2Yryv9R2t+29412ArXgfk6DDsUh6a0k0cBNylQymnqyp7YUKr7LPWC1kB6
 VW2qMcyITrv1DzyWCqHhVp5EHGkTpj0222aTI7sxjo6TNDI/zZLOUlmOQfaPAh0VaHY7
 72TSq+mY+82G2vyI++2LYqWc30tP7CKe3M/3U=
X-Forwarded-Encrypted: i=1;
 AJvYcCWWQBWNt4TC5m1Jt/P3SvHrNHL0Qe1quHDNNEIjkUQdK7CJE5H9DM9LrES3tFcqIY37Gnk=@dpdk.org
X-Received: by 2002:ad4:5c6d:0:b0:87d:f550:ebc8 with SMTP id
 6a1803df08f44-87fb402409amr15345086d6.15.1761276741147; 
 Thu, 23 Oct 2025 20:32:21 -0700 (PDT)
X-Received: by 2002:ad4:5c6d:0:b0:87d:f550:ebc8 with SMTP id
 6a1803df08f44-87fb402409amr15344956d6.15.1761276740692; Thu, 23 Oct 2025
 20:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
 <CAEKskBVy9_N0MuS0HkSoG=jnR0om3nJHxQEMFvChSu-dVVV0Cg@mail.gmail.com>
 <CAEKskBXG90f8nUc+yHGgJfPMkFkudD0_id5NQiQVm09WJkqb5A@mail.gmail.com>
In-Reply-To: <CAEKskBXG90f8nUc+yHGgJfPMkFkudD0_id5NQiQVm09WJkqb5A@mail.gmail.com>
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
Date: Thu, 23 Oct 2025 20:32:04 -0700
X-Gm-Features: AWmQ_bnrSX7b-fdhjskN7GpRoaJ36f_AYjG6I9rMfRJSpTVe3VjvKPjv242GzGc
Message-ID: <CACZ4nhsRmuav3rHUQ3ODsQdywanv6qP8bXw4g4stUd9v1GUc1w@mail.gmail.com>
Subject: Re: [PATCH v4 00/57] bnxt patchset
To: Manish Kurup <manish.kurup@broadcom.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000008770a20641df32fd"
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

--0000000000008770a20641df32fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 9:15=E2=80=AFAM Manish Kurup <manish.kurup@broadcom=
.com> wrote:
>
>
>
> On Tue, Oct 21, 2025 at 8:17=E2=80=AFPM Manish Kurup <manish.kurup@broadc=
om.com> wrote:
>>
>> On Tue, Oct 21, 2025 at 1:50=E2=80=AFPM Manish Kurup <manish.kurup@broad=
com.com> wrote:
>>>
>>> Apart from bug fixes, this patchset adds the following
>>> functionality:
>>>
>>> 1. Add the data, defines and enums for applications targeting
>>>    Wh+, P5, P7 product families.
>>> 2. Update HSI files (HWRM API defintions, enums, version number)
>>> 3. Dynamic UPAR support for THOR2.
>>> 4. Add support to allow multiple instances of applications to
>>>    exist at the same time.
>>> 5. Add hot upgrade support for applications.
>>> 6. Add MPLS packet offload support.
>>> 7. Improve backing store debug capabilities.
>>> 8. Add truflow global table scope support.
>>> 9. ULP parser support to handle GRE key.
>>>
>>> v1->v2:
>>> 1. Fixed typos in commit messages
>>> 2. Removed incorrect tabs in meson.build
>>> 3. Fixed ENODATA return value for BSD
>>> 4. Removed unused function bnxt_mpc_bds_in_hw()
>>> 5. Fixed questionable pointer cast warning
>>> 6. Ignoring function argument mispelling warnings
>>>
>>> v2->v3:
>>> 1. Fixed all sprintf format string warnings.
>>> 2. Fixed additional pointer size warnings.
>>>
>>> v3->v4:
>>> 1. Fixed additional pointer size warnings.
>>> 2. Split bnxt platform specific app data into multiple commits.
>>>
>>> Please apply.

This patchset got split into two because of message rate limits on the serv=
er.
Here is the bundle which stitches them[1]
So we had to use the periodic testing on next-net-brcm branch to
check if the set build fine and pass the basic tests.[2]

Based on the results [2], the patch set looks good.
So I merged them to the next-net-brcm tree.
Please apply to the main repo.

[1] https://patchwork.dpdk.org/bundle/ajitkhaparde/BNXT%2025.11/
[2] https://lab.dpdk.org/results/dashboard/tarballs/35304/

Thanks
Ajit

>>>
>>
> Hi Stephen,
> Thanks for allowing patches 03/57 and 04/57 through!
>
> I noticed one more build failure that is the result of me breaking up pat=
ch e-mailing.
>
> Patch 31/57 (Support MPLS packets) is failing build because it depends on=
 common options that were added as part of patch 48/57 (meson.build options=
).
>
> Ajit/Stephen, is there a way we could kick off a rebuild now that all pat=
ches are in?
>
> Thanks a lot!
>
>>
>> Hi Stephen,
>>
>> There were a couple of issues uploading this patchset:
>> 1. I broke up the really large commit into 4 smaller ones (1 for platfor=
m common defines and 3 platform/chip specific ones), #1 and #2 were accepta=
ble sizes, but #3 and #4 were still too big, and they are being held awaiti=
ng moderator approval. Could you please let them through?
>> 2. I had to retry "git send-email" a few times to get all the patches th=
rough. I kept getting error messages saying that I was sending patches beyo=
nd what rate was acceptable.
>>
>> The patches have all been uploaded, but I dont see them in patchwork, ju=
st the 1st 31 that went through fine.
>>
>> Could you please help?
>>
>> Thanks, regards,
>>
>> -Manish
>>
>>
>>>
>>> Farah Smith (8):
>>>   net/bnxt/tf_core: thor2 TF table scope sizing adjustments
>>>   net/bnxt/tf_core: tcam manager logical id free
>>>   net/bnxt/tf_core: thor2 hot upgrade ungraceful quit crash
>>>   net/bnxt/tf_core: truflow global table scope
>>>   net/bnxt/tf_ulp: socket direct enable
>>>   net/bnxt: fix adding udp_tunnel_port
>>>   net/bnxt: thor2 truflow memory manager bug
>>>   net/bnxt/tf_core: fix truflow PF init failure on sriov disabled
>>>
>>> Jay Ding (4):
>>>   net/bnxt: fix a NULL pointer dereference in bnxt_rep funcs
>>>   net/bnxt/tf_ulp: add meter stats support for Thor2
>>>   net/bnxt/tf_core: fix the miscalculation of the lkup table pool
>>>   next/bnxt/tf_ulp: truflow fixes for meter and mac_addr cache
>>>
>>> Kishore Padmanabha (18):
>>>   net/bnxt: enable vector mode processing
>>>   net/bnxt/tf_ulp: add support for global identifiers
>>>   net/bnxt/tf_core: add support for multi instance
>>>   net/bnxt/tf_core: fix table scope free
>>>   net/bnxt/tf_core: fix vfr clean up and stats lockup
>>>   net/bnxt/tf_ulp: increase shared pool size to 32
>>>   net/bnxt/tf_ulp: add support for tcam priority update
>>>   net/bnxt/tf_ulp: hot upgrade support
>>>   net/bnxt/tf_ulp: fix stats counter memory initialization
>>>   net/bnxt: fix max VFs count for thor2
>>>   net/bnxt/tf_ulp: enable support for global index table
>>>   net/bnxt/tf_ulp: optimize template enums
>>>   net/bnxt/tf_ulp: add non vfr mode capability
>>>   net/bnxt: fix stats collection when rx queue is not set
>>>   net/bnxt: fix rss configuration when set to none
>>>   net/bnxt: packet drop after port stop and start
>>>   net/bnxt/tf_ulp: add support for unicast only feature
>>>   net/bnxt: add support for truflow promiscuous mode
>>>
>>> Manish Kurup (9):
>>>   net/bnxt/tf_ulp: add bnxt platform data for 25.11
>>>   net/bnxt/tf_ulp: add bnxt app data for 25.11 for Wh+
>>>   net/bnxt/tf_ulp: add bnxt app data for 25.11 - Thor
>>>   net/bnxt/tf_ulp: add bnxt app data for 25.11 - Thor2
>>>   net/bnxt/tf_core: dynamic UPAR support for THOR2
>>>   net/bnxt: add meson build options for TruFlow
>>>   net/bnxt: truflow HSI struct fixes
>>>   net/bnxt/tf_ulp: fixes to enable TF functionality
>>>   net/bnxt/tf_ulp: remove Truflow DEBUG code
>>>
>>> Peter Spreadborough (6):
>>>   net/bnxt/tf_ulp: ovs-dpdk packet drop observed with thor2
>>>   net/bnxt/tf_core: add backing store debug to dpdk
>>>   net/bnxt/tf_core: handle out of order MPC completions
>>>   net/bnxt: avoid potential segfault in VFR handling
>>>   net/bnxt/tf_core: fix truflow crash on memory allocation failure
>>>   net/bnxt/tf_core: remove excessive debug logging
>>>
>>> Sangtani Parag Satishbhai (3):
>>>   net/bnxt/tf_ulp: fix seg fault when devargs argument missing
>>>   net/bnxt: truflow remove redundant code for mpc init
>>>   net/bnxt: truflow remove RTE devarg processing for mpc=3D1
>>>
>>> Shahaji Bhosle (4):
>>>   net/bnxt/tf_ulp: ulp parser support to handle gre key
>>>   net/bnxt/tf_ulp: change rte_mem_virt2iova to rte_mem_virt2phys
>>>   net/bnxt/tf_ulp: truflow add pf action handler
>>>   net/bnxt/tf_ulp: add feature bit rx miss handling
>>>
>>> Shuanglin Wang (2):
>>>   net/bnxt/tf_core: fix build failure with flow scale option
>>>   net/bnxt/tf_ulp: support MPLS packets
>>>
>>> Smitha Pisupati (1):
>>>   net/bnxt/tf_ulp: add support for special vxlan
>>>
>>> Sriharsha Basavapatna (2):
>>>   net/bnxt: fix default rss config
>>>   net/bnxt: avoid iova range check when external memory is used
>>>
>>>  drivers/net/bnxt/bnxt.h                       |     7 +
>>>  drivers/net/bnxt/bnxt_ethdev.c                |   256 +-
>>>  drivers/net/bnxt/bnxt_hwrm.c                  |    25 +-
>>>  drivers/net/bnxt/bnxt_mpc.c                   |    26 +-
>>>  drivers/net/bnxt/bnxt_mpc.h                   |     7 +-
>>>  drivers/net/bnxt/bnxt_reps.c                  |    37 +-
>>>  drivers/net/bnxt/bnxt_stats.c                 |     5 +
>>>  drivers/net/bnxt/bnxt_txr.c                   |     5 +-
>>>  drivers/net/bnxt/bnxt_vnic.c                  |    21 +-
>>>  .../bnxt/hcapi/cfa_v3/include/cfa_resources.h |    33 +-
>>>  .../net/bnxt/hcapi/cfa_v3/include/cfa_types.h |    10 +
>>>  drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c     |    83 +-
>>>  .../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h    |     2 +-
>>>  drivers/net/bnxt/hsi_struct_def_dpdk.h        |  1123 +-
>>>  drivers/net/bnxt/tf_core/cfa_tcam_mgr.c       |    35 +-
>>>  .../net/bnxt/tf_core/cfa_tcam_mgr_device.h    |     6 +-
>>>  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p4.c    |     2 +-
>>>  drivers/net/bnxt/tf_core/cfa_tcam_mgr_p58.c   |     2 +-
>>>  drivers/net/bnxt/tf_core/tf_resources.c       |     2 +-
>>>  drivers/net/bnxt/tf_core/tf_util.c            |     2 +
>>>  drivers/net/bnxt/tf_core/v3/meson.build       |     4 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc.h             |   238 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_act.c         |    47 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_cpm.c         |    13 +
>>>  drivers/net/bnxt/tf_core/v3/tfc_debug.h       |    12 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_em.c          |   143 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_em.h          |   105 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_global_id.c   |    45 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c |   142 +
>>>  drivers/net/bnxt/tf_core/v3/tfc_idx_tbl.c     |    51 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c   |  1411 +
>>>  drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c   |   565 -
>>>  drivers/net/bnxt/tf_core/v3/tfc_msg.c         |   363 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_msg.h         |    41 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_resources.c   |    12 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c   |   246 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_tcam.c        |    55 +
>>>  drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c  |  1875 +
>>>  drivers/net/bnxt/tf_core/v3/tfc_util.c        |    23 +
>>>  drivers/net/bnxt/tf_core/v3/tfc_util.h        |    14 +
>>>  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.c   |     3 +-
>>>  drivers/net/bnxt/tf_core/v3/tfc_vf2pf_msg.h   |     4 +-
>>>  drivers/net/bnxt/tf_core/v3/tfo.c             |   211 +-
>>>  drivers/net/bnxt/tf_core/v3/tfo.h             |    53 +-
>>>  drivers/net/bnxt/tf_ulp/bnxt_tf_common.h      |     5 -
>>>  drivers/net/bnxt/tf_ulp/bnxt_tf_pmd_shim.c    |     6 -
>>>  drivers/net/bnxt/tf_ulp/bnxt_ulp.h            |     6 +
>>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_flow.c       |    10 +
>>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c      |    55 +-
>>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c         |    27 +-
>>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c        |   147 +-
>>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h        |     5 +
>>>  drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h      |    82 +-
>>>  .../generic_templates/ulp_template_db_act.c   |     6 +-
>>>  .../generic_templates/ulp_template_db_class.c |  8808 ++--
>>>  .../generic_templates/ulp_template_db_defs.h  |    88 +
>>>  .../generic_templates/ulp_template_db_field.h |     5 +-
>>>  .../generic_templates/ulp_template_db_tbl.c   |   267 +-
>>>  .../ulp_template_db_thor2_act.c               |  4637 +-
>>>  .../ulp_template_db_thor2_class.c             | 42439 +++++++++-------
>>>  .../ulp_template_db_thor_act.c                |    14 +-
>>>  .../ulp_template_db_thor_class.c              | 13247 ++---
>>>  .../ulp_template_db_wh_plus_act.c             |     2 +-
>>>  .../ulp_template_db_wh_plus_class.c           |    26 +-
>>>  drivers/net/bnxt/tf_ulp/meson.build           |    56 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_alloc_tbl.c       |     4 -
>>>  drivers/net/bnxt/tf_ulp/ulp_def_rules.c       |    38 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c          |    50 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr.h          |    11 +
>>>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tf.c       |     3 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c      |    64 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_flow_db.c         |    10 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_flow_db.h         |     6 +
>>>  drivers/net/bnxt/tf_ulp/ulp_gen_hash.c        |     2 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.c         |    24 +
>>>  drivers/net/bnxt/tf_ulp/ulp_gen_tbl.h         |    12 +
>>>  drivers/net/bnxt/tf_ulp/ulp_mapper.c          |   326 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_mapper.h          |    56 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_mapper_tf.c       |    81 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c      |   347 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_matcher.c         |     9 -
>>>  drivers/net/bnxt/tf_ulp/ulp_rte_handler_tbl.c |     8 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_rte_parser.c      |   141 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_rte_parser.h      |    10 +
>>>  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |   137 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.h          |     4 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c      |     1 -
>>>  .../ulp_template_db_enum.h                    |   333 +-
>>>  drivers/net/bnxt/tf_ulp/ulp_template_struct.h |     5 +
>>>  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c      |   264 +
>>>  drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h      |    40 +
>>>  meson_options.txt                             |     4 +
>>>  92 files changed, 48710 insertions(+), 30583 deletions(-)
>>>  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_hot_upgrade.c
>>>  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
>>>  delete mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c
>>>  create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
>>>  create mode 100644 drivers/net/bnxt/tf_ulp/generic_templates/ulp_templ=
ate_db_defs.h
>>>  rename drivers/net/bnxt/tf_ulp/{generic_templates =3D> }/ulp_template_=
db_enum.h (88%)
>>>  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.c
>>>  create mode 100644 drivers/net/bnxt/tf_ulp/ulp_tfc_ha_mgr.h
>>>
>>> --
>>> 2.39.5 (Apple Git-154)
>>>
>>
>>
>> --
>> ;) Manish (x1380)
>
>
>
> --
> ;) Manish (x1380)

--0000000000008770a20641df32fd
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
CQQxIgQgsd5O1eQJqw3kk9G3Fyj/RHSbrDnw4eezAptGnRELhfEwGAYJKoZIhvcNAQkDMQsGCSqG
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMDI0MDMzMjIxWjBcBgkqhkiG9w0BCQ8xTzBNMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3
DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAKZFUctelAwc6iiA776N4EAYrzlVj
aPXiPVCn2TwI5UJJY2ylrONV3wcrUacThFySZQyBu8Gqz+6rzSvE75GqNjbUuYG8JaF1obRAvPs0
HfafPu7A0gt3U2cvjzLfk31YmlRh8LLcquilQ4U9mooehEllKoH8iqm+j+v0FzlEKnqULQRlTi6F
Da+e38tF0+PCt2NyydyPUDCFc83l/1YHX06ZYNbkrQBiQ/wi/m/eWhICvaVw2P7mGC+ASOe8RPEK
0RuP+6mhaGLrig7DLWA4JlHuYQb1lW0BSCaHiFapaS5OE+cybw+vbUX0SsdBHX3JrHiZxwmGFBJH
3fxPEqS/nA==
--0000000000008770a20641df32fd--
