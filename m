Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB917C3601A
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 06:59:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2388140156;
	Mon,  7 Apr 2025 08:59:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 866D540150
 for <dev@dpdk.org>; Mon,  7 Apr 2025 08:59:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744009179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGmULNYNNarCBDFLHFVLPsI7Mr78Xsar6Fi7pyOlHRg=;
 b=S2VeAqJZ4D7VwaGDL0mnvCK+yxTI0Fn33S/2QAiuRBIujytHoxRWoRUl39kYJTJRjU8RsR
 nJmDQ3+v4Xs+DD5KPBLb/xCytRpMnKsuxDTczLK30lpAYLgTKF968iVXQB+ctiXJJcvt1x
 OZJ92iGEjkD9H4GVvGTTk+GqgEiBdKc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-mAeDSmmoMd6Y_C_zfQg3eg-1; Mon, 07 Apr 2025 02:59:38 -0400
X-MC-Unique: mAeDSmmoMd6Y_C_zfQg3eg-1
X-Mimecast-MFC-AGG-ID: mAeDSmmoMd6Y_C_zfQg3eg_1744009177
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-30bf9ed6da1so18731771fa.2
 for <dev@dpdk.org>; Sun, 06 Apr 2025 23:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744009177; x=1744613977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGmULNYNNarCBDFLHFVLPsI7Mr78Xsar6Fi7pyOlHRg=;
 b=UbJ8+CKWb2wvfBSDUey4xx9VpVigh+Du30mRwaqeLQPkO76rYpt8Q0NWMtYDzxpXdj
 m0MpfHP+8skQpxyWrubCnxNUJSeie/PGY7THd0qgaH17cbQE/7vwJTvy+ScZt061pCtp
 QZylX8F/Fj8NJ+qSFjz5A4dcw5Le+8r7bcoc4STucH1VZbOtGLPAhMSZVHGLbORS5MIg
 qzYS/bmJyjAFpfJTVaVt/lXdGFHh4qpwSLMGUgWi+EDs2007/tNAkrxMqRItQVB1XdZf
 B5hLqfXxkISIVNY0a4BIiHmu1VLkbJ5s0dFof8ouQ1sWyBX9GDffDYFT+sF68SJhG80u
 NpMA==
X-Gm-Message-State: AOJu0Yycn1XxufWxbpsYnwIIPfLCjaQqCSu8PvyaOJJbcTCiJQUIDIe+
 ISfiJs3DGwc9HjjPngA8nAf0gp8nsJmQSzFAqnAvRajHnezeiFbjnaOCYab8jh3irByCqL/Xxkm
 q4+HsgY1XOxQrBPmpjpW/P9s2Rj06U3CVmUHfy1NdjHZ6X+br6rQjcC20pz3Ur+4SjQA2FcxaT/
 yofWduIEfwcNS+EZYNVELvOQQ=
X-Gm-Gg: ASbGncvKX/njktDJ9yLgphnNfhhglmeXmKwviAl4nheFRUG655eybLlqbSnj7EYdwDE
 zxUe9wEOV8PhU2qyaCx/TZ04D6h0GbiorQ0V2XuBw1FV3GhcEHCGHn7vpn1NRPY56q1lP4zHPzt
 M=
X-Received: by 2002:a05:6512:104f:b0:54a:fa5a:e9b1 with SMTP id
 2adb3069b0e04-54c297b71b3mr1740332e87.10.1744009177113; 
 Sun, 06 Apr 2025 23:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUU5Q2G7thIhhKbxLk3bNir0EOKYl/P5+FHWkRxW3jXKeR2z3uVy4s4lwkipVK545fmQjlGFTvdfktO3EpdrU=
X-Received: by 2002:a05:6512:104f:b0:54a:fa5a:e9b1 with SMTP id
 2adb3069b0e04-54c297b71b3mr1740318e87.10.1744009176491; Sun, 06 Apr 2025
 23:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250324173030.3733517-1-bruce.richardson@intel.com>
 <20250324173030.3733517-3-bruce.richardson@intel.com>
In-Reply-To: <20250324173030.3733517-3-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 7 Apr 2025 08:59:25 +0200
X-Gm-Features: ATxdqUHj9LVAj8XXqnTQDz5oLTy-Okqe5nRDUpvZPIYyPdc3SoOUL6B4SuiGjUk
Message-ID: <CAJFAV8zzXMQBLBL1=P4KvU+r98GCG4bTCUXCsA_Du68FE-_9Kg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] eal: convert core masks and lists to core sets
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Pravin Pathak <pravin.pathak@intel.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 21T5RDDMiiDBfnN9-VhgbidnAjWmX-K5F_xmoQMxNhc_1744009177
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Mar 24, 2025 at 6:31=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Rather than directly parsing and working with the core mask and core
> list parameters, convert them into core maps, and centralise all core
> parsing there. This allows future work to adjust the mappings of cores
> when generating that mapping parameter.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>
> NOTE: this patch changes the behaviour of the exported, but internal API
> rte_eal_parse_core_mask, used by dlb driver. Since this is an internal
> API changing behaviour is allowed. However, to prevent issues -  in case
> any external app is using the API - we rename the function to
> rte_eal_expand_coremask.

An external app is not supposed to call this but I agree a build error
is more explicit.


> ---
>  drivers/event/dlb2/dlb2_priv.h             |   2 -
>  drivers/event/dlb2/pf/base/dlb2_resource.c |  48 ++---
>  lib/eal/common/eal_common_options.c        | 195 +++++----------------
>  lib/eal/include/rte_eal.h                  |  12 +-
>  lib/eal/version.map                        |   2 +-
>  5 files changed, 60 insertions(+), 199 deletions(-)
>
> diff --git a/drivers/event/dlb2/dlb2_priv.h b/drivers/event/dlb2/dlb2_pri=
v.h
> index 52da31ed31..63c0bea155 100644
> --- a/drivers/event/dlb2/dlb2_priv.h
> +++ b/drivers/event/dlb2/dlb2_priv.h
> @@ -737,8 +737,6 @@ void dlb2_event_build_hcws(struct dlb2_port *qm_port,
>                            uint8_t *sched_type,
>                            uint8_t *queue_id);
>
> -/* Extern functions */
> -extern int rte_eal_parse_coremask(const char *coremask, int *cores);

Ugly...

>
>  /* Extern globals */
>  extern struct process_local_port_data dlb2_port[][DLB2_NUM_PORT_TYPES];
> diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.c b/drivers/event/d=
lb2/pf/base/dlb2_resource.c
> index 3004902118..9b087b03b5 100644
> --- a/drivers/event/dlb2/pf/base/dlb2_resource.c
> +++ b/drivers/event/dlb2/pf/base/dlb2_resource.c
> @@ -922,49 +922,31 @@ dlb2_resource_probe(struct dlb2_hw *hw, const void =
*probe_args)
>  {
>         const struct dlb2_devargs *args =3D (const struct dlb2_devargs *)=
probe_args;
>         const char *mask =3D args ? args->producer_coremask : NULL;
> -       int cpu =3D 0, cnt =3D 0, cores[RTE_MAX_LCORE], i;
> +       int cpu =3D 0;
>
>         if (args) {
>                 mask =3D (const char *)args->producer_coremask;
>         }

I have some trouble with this code:

        const char *mask =3D args ? args->producer_coremask : NULL;
...
        if (args) {
                mask =3D (const char *)args->producer_coremask;
        }

It seems redundant...



>
> -       if (mask && rte_eal_parse_coremask(mask, cores)) {
> -               DLB2_HW_ERR(hw, ": Invalid producer coremask=3D%s\n", mas=
k);
> -               return -1;
> -       }
> -
> +       cpu =3D rte_get_next_lcore(-1, 1, 0);
>         hw->num_prod_cores =3D 0;
> -       for (i =3D 0; i < RTE_MAX_LCORE; i++) {
> -               bool is_pcore =3D (mask && cores[i] !=3D -1);
> -
> -               if (rte_lcore_is_enabled(i)) {
> -                       if (is_pcore) {
> -                               /*
> -                                * Populate the producer cores from parse=
d
> -                                * coremask
> -                                */
> -                               hw->prod_core_list[cores[i]] =3D i;
> -                               hw->num_prod_cores++;
> -
> -                       } else if ((++cnt =3D=3D DLB2_EAL_PROBE_CORE ||
> -                          rte_lcore_count() < DLB2_EAL_PROBE_CORE)) {
> -                               /*
> -                                * If no producer coremask is provided, u=
se the
> -                                * second EAL core to probe
> -                                */
> -                               cpu =3D i;
> -                               break;
> -                       }
> -               } else if (is_pcore) {
> -                       DLB2_HW_ERR(hw, "Producer coremask(%s) must be a =
subset of EAL coremask\n",
> -                                    mask);
> +       if (mask) {
> +               int n =3D rte_eal_expand_coremask(mask, hw->prod_core_lis=
t);
> +               if (n <=3D 0) {
> +                       DLB2_HW_ERR(hw, ": Invalid producer coremask=3D%s=
\n", mask);
>                         return -1;
>                 }
> +               hw->num_prod_cores =3D n;
> +               cpu =3D hw->prod_core_list[0];
>
> +               for (u8 i =3D 0; i < hw->num_prod_cores; i++) {
> +                       if (!rte_lcore_is_enabled(hw->prod_core_list[i]))=
 {
> +                               DLB2_HW_ERR(hw, "Producer coremask(%s) mu=
st be a subset of EAL coremask\n",
> +                                            mask);
> +                               return -1;
> +                       }
> +               }
>         }
> -       /* Use the first core in producer coremask to probe */
> -       if (hw->num_prod_cores)
> -               cpu =3D hw->prod_core_list[0];
>
>         dlb2_get_pp_allocation(hw, cpu, DLB2_LDB_PORT);
>         dlb2_get_pp_allocation(hw, cpu, DLB2_DIR_PORT);
> diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_com=
mon_options.c
> index 55c49a923f..22ea6b24e4 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -690,33 +690,6 @@ eal_parse_service_coremask(const char *coremask)
>         return 0;
>  }
>
> -static int
> -update_lcore_config(int *cores)
> -{
> -       struct rte_config *cfg =3D rte_eal_get_configuration();
> -       unsigned int count =3D 0;
> -       unsigned int i;
> -       int ret =3D 0;
> -
> -       for (i =3D 0; i < RTE_MAX_LCORE; i++) {
> -               if (cores[i] !=3D -1) {
> -                       if (eal_cpu_detected(i) =3D=3D 0) {
> -                               EAL_LOG(ERR, "lcore %u unavailable", i);
> -                               ret =3D -1;
> -                               continue;
> -                       }
> -                       cfg->lcore_role[i] =3D ROLE_RTE;
> -                       count++;
> -               } else {
> -                       cfg->lcore_role[i] =3D ROLE_OFF;
> -               }
> -               lcore_config[i].core_index =3D cores[i];
> -       }
> -       if (!ret)
> -               cfg->lcore_count =3D count;
> -       return ret;
> -}
> -
>  static int
>  check_core_list(int *lcores, unsigned int count)
>  {
> @@ -756,10 +729,9 @@ check_core_list(int *lcores, unsigned int count)
>  }
>
>  int
> -rte_eal_parse_coremask(const char *coremask, int *cores)
> +rte_eal_expand_coremask(const char *coremask, int *cores)
>  {
>         const char *coremask_orig =3D coremask;
> -       int lcores[RTE_MAX_LCORE];
>         unsigned int count =3D 0;
>         int i, j, idx;
>         int val;
> @@ -803,30 +775,19 @@ rte_eal_parse_coremask(const char *coremask, int *c=
ores)
>                                                 RTE_MAX_LCORE);
>                                         return -1;
>                                 }
> -                               lcores[count++] =3D idx;
> +                               cores[count++] =3D idx;
>                         }
>                 }
>         }
>         if (count =3D=3D 0) {
> -               EAL_LOG(ERR, "No lcores in coremask: [%s]",
> -                       coremask_orig);
> +               EAL_LOG(ERR, "No lcores in coremask: [%s]", coremask_orig=
);
>                 return -1;
>         }
>
> -       if (check_core_list(lcores, count))
> +       if (check_core_list(cores, count) !=3D 0)
>                 return -1;
>
> -       /*
> -        * Now that we've got a list of cores no longer than RTE_MAX_LCOR=
E,
> -        * and no lcore in that list is greater than RTE_MAX_LCORE, popul=
ate
> -        * the cores array.
> -        */
> -       do {
> -               count--;
> -               cores[lcores[count]] =3D count;
> -       } while (count !=3D 0);
> -
> -       return 0;
> +       return count;
>  }
>
>  static int
> @@ -911,7 +872,6 @@ static int
>  eal_parse_corelist(const char *corelist, int *cores)
>  {
>         unsigned int count =3D 0, i;
> -       int lcores[RTE_MAX_LCORE];
>         char *end =3D NULL;
>         int min, max;
>         int idx;
> @@ -949,7 +909,7 @@ eal_parse_corelist(const char *corelist, int *cores)
>
>                                 /* Check if this idx is already present *=
/
>                                 for (i =3D 0; i < count; i++) {
> -                                       if (lcores[i] =3D=3D idx)
> +                                       if (cores[i] =3D=3D idx)
>                                                 dup =3D true;
>                                 }
>                                 if (dup)
> @@ -959,7 +919,7 @@ eal_parse_corelist(const char *corelist, int *cores)
>                                                 RTE_MAX_LCORE);
>                                         return -1;
>                                 }
> -                               lcores[count++] =3D idx;
> +                               cores[count++] =3D idx;
>                         }
>                         min =3D -1;
>                 } else
> @@ -967,23 +927,15 @@ eal_parse_corelist(const char *corelist, int *cores=
)
>                 corelist =3D end + 1;
>         } while (*end !=3D '\0');
>
> -       if (count =3D=3D 0)
> +       if (count =3D=3D 0) {
> +               EAL_LOG(ERR, "No lcores in corelist");
>                 return -1;
> +       }
>
> -       if (check_core_list(lcores, count))
> +       if (check_core_list(cores, count))
>                 return -1;
>
> -       /*
> -        * Now that we've got a list of cores no longer than RTE_MAX_LCOR=
E,
> -        * and no lcore in that list is greater than RTE_MAX_LCORE, popul=
ate
> -        * the cores array.
> -        */
> -       do {
> -               count--;
> -               cores[lcores[count]] =3D count;
> -       } while (count !=3D 0);
> -
> -       return 0;
> +       return count;
>  }
>
>  /* Changes the lcore id of the main thread */
> @@ -1500,75 +1452,6 @@ eal_parse_base_virtaddr(const char *arg)
>         return 0;
>  }
>
> -/* caller is responsible for freeing the returned string */
> -static char *
> -available_cores(void)
> -{
> -       char *str =3D NULL;
> -       int previous;
> -       int sequence;
> -       char *tmp;
> -       int idx;
> -
> -       /* find the first available cpu */
> -       for (idx =3D 0; idx < RTE_MAX_LCORE; idx++) {
> -               if (eal_cpu_detected(idx) =3D=3D 0)
> -                       continue;
> -               break;
> -       }
> -       if (idx >=3D RTE_MAX_LCORE)
> -               return NULL;
> -
> -       /* first sequence */
> -       if (asprintf(&str, "%d", idx) < 0)
> -               return NULL;
> -       previous =3D idx;
> -       sequence =3D 0;
> -
> -       for (idx++ ; idx < RTE_MAX_LCORE; idx++) {
> -               if (eal_cpu_detected(idx) =3D=3D 0)
> -                       continue;
> -
> -               if (idx =3D=3D previous + 1) {
> -                       previous =3D idx;
> -                       sequence =3D 1;
> -                       continue;
> -               }
> -
> -               /* finish current sequence */
> -               if (sequence) {
> -                       if (asprintf(&tmp, "%s-%d", str, previous) < 0) {
> -                               free(str);
> -                               return NULL;
> -                       }
> -                       free(str);
> -                       str =3D tmp;
> -               }
> -
> -               /* new sequence */
> -               if (asprintf(&tmp, "%s,%d", str, idx) < 0) {
> -                       free(str);
> -                       return NULL;
> -               }
> -               free(str);
> -               str =3D tmp;
> -               previous =3D idx;
> -               sequence =3D 0;
> -       }
> -
> -       /* finish last sequence */
> -       if (sequence) {
> -               if (asprintf(&tmp, "%s-%d", str, previous) < 0) {
> -                       free(str);
> -                       return NULL;
> -               }
> -               free(str);
> -               str =3D tmp;
> -       }
> -
> -       return str;
> -}
> -

Not sure why you remove this helper, it was supposed to help users
with better logs.


>  #define HUGE_UNLINK_NEVER "never"
>
>  static int
> @@ -1981,43 +1864,43 @@ eal_adjust_config(struct internal_config *interna=
l_cfg)
>                 return -1;
>         }
>
> -       if (lcore_options.core_mask_opt) {
> -               int lcore_indexes[RTE_MAX_LCORE];
> -
> -               if (rte_eal_parse_coremask(lcore_options.core_mask_opt, l=
core_indexes) < 0) {
> -                       EAL_LOG(ERR, "invalid coremask syntax");
> -                       return -1;
> -               }
> -               if (update_lcore_config(lcore_indexes) < 0) {
> -                       char *available =3D available_cores();
>
> -                       EAL_LOG(ERR,
> -                               "invalid coremask, please check specified=
 cores are part of %s",
> -                               available);
> -                       free(available);
> -                       return -1;
> -               }
> -       } else if (lcore_options.core_list_opt) {
> +       if (lcore_options.core_mask_opt || lcore_options.core_list_opt) {
>                 int lcore_indexes[RTE_MAX_LCORE];
> +               int nb_indexes =3D lcore_options.core_list_opt ?
> +                               eal_parse_corelist(lcore_options.core_lis=
t_opt, lcore_indexes) :
> +                               rte_eal_expand_coremask(lcore_options.cor=
e_mask_opt, lcore_indexes);
>
> -               if (eal_parse_corelist(lcore_options.core_list_opt, lcore=
_indexes) < 0) {
> -                       EAL_LOG(ERR, "invalid core list syntax");
> +               if (nb_indexes < 0)
>                         return -1;
> -               }
> -               if (update_lcore_config(lcore_indexes) < 0) {
> -                       char *available =3D available_cores();
>
> -                       EAL_LOG(ERR,
> -                               "invalid core list, please check specifie=
d cores are part of %s",
> -                               available);
> -                       free(available);
> -                       return -1;
> +               char *core_map_opt =3D malloc(RTE_MAX_LCORE * 10);
> +               size_t core_map_len =3D 0;
> +               for (i =3D 0; i < nb_indexes; i++) {
> +                       if (!eal_cpu_detected(lcore_indexes[i])) {
> +                               EAL_LOG(ERR, "core %d not present", lcore=
_indexes[i]);

core_map_opt is leaked (idem in next return).


> +                               return -1;

I would not return here, but instead provide a full report of which
cores are invalid before returning an error.


> +                       }
> +                       int n =3D snprintf(core_map_opt + core_map_len,
> +                                       (RTE_MAX_LCORE * 10) - core_map_l=
en,
> +                                       "%s%d", i =3D=3D 0 ? "" : ",", lc=
ore_indexes[i]);
> +                       if (n < 0 || (size_t)n >=3D (RTE_MAX_LCORE * 10) =
- core_map_len) {
> +                               EAL_LOG(ERR, "core map string too long");
> +                               return -1;

Or use asprintf.


> +                       }
> +                       core_map_len +=3D n;
>                 }
> -       } else if (lcore_options.core_map_opt) {
> +               lcore_options.core_map_opt =3D core_map_opt;
> +               EAL_LOG(DEBUG, "Generated core map: '%s'", lcore_options.=
core_map_opt);
> +       }
> +
> +       if (lcore_options.core_map_opt) {
>                 if (eal_parse_lcores(lcore_options.core_map_opt) < 0) {
>                         EAL_LOG(ERR, "invalid parameter for --" OPT_LCORE=
S);
>                         return -1;
>                 }
> +               if (lcore_options.core_mask_opt || lcore_options.core_lis=
t_opt)
> +                       free(RTE_CAST_PTR(void *, lcore_options.core_map_=
opt));
>         } else {
>                 eal_auto_detect_cores(cfg);
>         }
> diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
> index c826e143f1..013075487c 100644
> --- a/lib/eal/include/rte_eal.h
> +++ b/lib/eal/include/rte_eal.h
> @@ -493,22 +493,20 @@ rte_eal_get_runtime_dir(void);
>  /**
>   * Convert a string describing a mask of core ids into an array of core =
ids.
>   *
> - * On success, the passed array is filled with the orders of the core id=
s
> - * present in the mask (-1 indicating that a core id is absent).
> - * For example, passing a 0xa coremask results in cores[1] =3D 0, cores[=
3] =3D 1,
> - * and the rest of the array is set to -1.
> + * On success, the passed array is filled with the core ids present in t=
he mask.
>   *
>   * @param coremask
>   *   A string describing a mask of core ids.
>   * @param cores
> - *   An array where to store the core ids orders.
> + *   The output array to store the core ids.
>   *   This array must be at least RTE_MAX_LCORE large.
>   * @return
> - *   0 on success, -1 if the string content was invalid.
> + *  The number of cores in the coremask, and in the returned "cores" arr=
ay,
> + *  -1 if the string content was invalid.
>   */
>  __rte_internal
>  int
> -rte_eal_parse_coremask(const char *coremask, int *cores);
> +rte_eal_expand_coremask(const char *coremask, int *cores);
>
>  #ifdef __cplusplus
>  }
> diff --git a/lib/eal/version.map b/lib/eal/version.map
> index a20c713eb1..b51051ee38 100644
> --- a/lib/eal/version.map
> +++ b/lib/eal/version.map
> @@ -405,8 +405,8 @@ INTERNAL {
>
>         rte_bus_register;
>         rte_bus_unregister;
> +       rte_eal_expand_coremask;
>         rte_eal_get_baseaddr;
> -       rte_eal_parse_coremask;
>         rte_firmware_read;
>         rte_intr_allow_others;
>         rte_intr_cap_multiple;
> --
> 2.45.2
>

--=20
David Marchand

