Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76ECC3601A
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 06:58:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0F5F40156;
	Mon,  7 Apr 2025 08:58:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 928DE40150
 for <dev@dpdk.org>; Mon,  7 Apr 2025 08:58:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744009113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJdDm0iK0cpBURpZD8E7byTAZGPk8RYguKD1yVjnLo4=;
 b=CxlYsBiIwCbvDU79U3dhU7OnUklYWeQT0Yd/U23gR+yQziqFae9OSEkVSysYdNlzgLIS0b
 Mb8xiYRX5xug/DHDKPEa4QoKJEqp+fnyBo0YYo1fCak5sRb6xv0fHECr7PjOwrB5KRddpi
 TDxljnCl1WWv16P5AQwTpOolJRJh1y0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-EvmMCtJZMWaCXANqduYPFQ-1; Mon, 07 Apr 2025 02:58:31 -0400
X-MC-Unique: EvmMCtJZMWaCXANqduYPFQ-1
X-Mimecast-MFC-AGG-ID: EvmMCtJZMWaCXANqduYPFQ_1744009110
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30bf6bae757so17098361fa.0
 for <dev@dpdk.org>; Sun, 06 Apr 2025 23:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744009110; x=1744613910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJdDm0iK0cpBURpZD8E7byTAZGPk8RYguKD1yVjnLo4=;
 b=HMvOBcksrh9msa2x0H86TRowLDdg2Q6CRyyKztU+H8GNpr4d6cCOA/CByNHNKoxotS
 aSr5Va2IF83DcslH/uJE00U649TCxxaIYF85E2Ex4uVnRgKqrFNio/uPy/gPqLu67u0p
 ituxGYJswG+nfbG64eq2DJkLuSiAKOkGS9QgW04kkBV0AbcGZnHO97jkhaFozZOdiK8/
 QBCx+DlCHkTkXPbLnD7E+qFid8dTwG9e7yhysgSed6X6X8bOgkpxR3kMIfAiXWxfe7LY
 DBfWzIPvLuRaF4JSS/T6zsJ2EfYzxRkVp0uyV6DtJDU3xTqii5l719JHoXzdSDDc9LDb
 TM2A==
X-Gm-Message-State: AOJu0Yxt03LUe+JYjYG6D65Z5MssTWWrDFYNY0kX6ZzTHYJ2GGf+77k1
 C/cVtF3TrKPpqOJ/ocblRGtOE9yjIyAVPmxe8Tlp+aDUnN65q0ez5qWcpEMubvSsOw6JcvIn/86
 XutkUdr/2evDwizDDf28Ggp+RbPwCwQpc4sS6NPWom9izFJbKE3Kjhm5bmTw0VPX6A/jzUmo8Hf
 kB1yd4oMfbjzs2Ajs=
X-Gm-Gg: ASbGncvpX7RnCMFSZFgDu5U3EWyGGJyU4NyPMPM9SjtVLOMdxYeMQUhEYgem8+uxwB4
 zGP9vrp27nW7m8af/7pUXo14m18OqrbK0GEMrhiP5Wnt0gdUgAagz8z6mMTb+JJkHo8SatZOdKj
 U=
X-Received: by 2002:a05:651c:502:b0:30c:2dbc:6e1c with SMTP id
 38308e7fff4ca-30f0a1826a3mr31706871fa.31.1744009110314; 
 Sun, 06 Apr 2025 23:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBQVtLaXqRCfm+8FgRxitjnJ6jcxMZTqxaHh1GTWSiOR3ynWq42D9GdVMf+d7HQOBrqzYWMpfb66yMBU9X4tQ=
X-Received: by 2002:a05:651c:502:b0:30c:2dbc:6e1c with SMTP id
 38308e7fff4ca-30f0a1826a3mr31706761fa.31.1744009109878; Sun, 06 Apr 2025
 23:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250324173030.3733517-1-bruce.richardson@intel.com>
 <20250324173030.3733517-2-bruce.richardson@intel.com>
In-Reply-To: <20250324173030.3733517-2-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 7 Apr 2025 08:58:17 +0200
X-Gm-Features: ATxdqUGwKU9P4MpB37mxLRLvV0oTnMJjo3Oy9_2EIChU1t5qQ_QT9qwS9Df1_hk
Message-ID: <CAJFAV8yiKs8HJDKCzJwWNDZAufj5B16ov=mX+vpv+qK9xy7vyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] eal: centralize core parameter parsing
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8VA6PjoliH2pXxO-31PpUR23W7EXTJbvAyYCpfbGjyg_1744009110
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
> Rather than parsing the lcore parameters as they are encountered, just
> save off the lcore parameters and then parse them at the end. This
> allows better knowledge of what parameters are available or not when
> parsing.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/eal/common/eal_common_options.c | 183 +++++++++++++---------------
>  1 file changed, 84 insertions(+), 99 deletions(-)
>
> diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_com=
mon_options.c
> index 79db9a47dd..55c49a923f 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -151,7 +151,13 @@ TAILQ_HEAD_INITIALIZER(devopt_list);
>
>  static int main_lcore_parsed;
>  static int mem_parsed;
> -static int core_parsed;
> +static struct lcore_options {
> +       const char *core_mask_opt;
> +       const char *core_list_opt;
> +       const char *core_map_opt;
> +       const char *service_mask_opt;
> +       const char *service_list_opt;
> +} lcore_options =3D {0};

eal_parse_main_lcore() still checks if selected main lcore is a
service lcore. I think this check is useless now.


>
>  /* Allow the application to print its usage message too if set */
>  static rte_usage_hook_t rte_application_usage_hook;
> @@ -674,7 +680,7 @@ eal_parse_service_coremask(const char *coremask)
>         if (count =3D=3D 0)
>                 return -1;
>
> -       if (core_parsed && taken_lcore_count !=3D count) {
> +       if (taken_lcore_count !=3D count) {
>                 EAL_LOG(WARNING,
>                         "Not all service cores are in the coremask. "
>                         "Please ensure -c or -l includes service cores");
> @@ -684,17 +690,6 @@ eal_parse_service_coremask(const char *coremask)
>         return 0;
>  }
>
> -static int
> -eal_service_cores_parsed(void)
> -{
> -       int idx;
> -       for (idx =3D 0; idx < RTE_MAX_LCORE; idx++) {
> -               if (lcore_config[idx].core_role =3D=3D ROLE_SERVICE)
> -                       return 1;
> -       }
> -       return 0;
> -}
> -
>  static int
>  update_lcore_config(int *cores)
>  {
> @@ -903,7 +898,7 @@ eal_parse_service_corelist(const char *corelist)
>         if (count =3D=3D 0)
>                 return -1;
>
> -       if (core_parsed && taken_lcore_count !=3D count) {
> +       if (taken_lcore_count !=3D count) {
>                 EAL_LOG(WARNING,
>                         "Not all service cores were in the coremask. "
>                         "Please ensure -c or -l includes service cores");
> @@ -1673,83 +1668,20 @@ eal_parse_common_option(int opt, const char *opta=
rg,
>                 a_used =3D 1;
>                 break;
>         /* coremask */
> -       case 'c': {
> -               int lcore_indexes[RTE_MAX_LCORE];
> -
> -               if (eal_service_cores_parsed())
> -                       EAL_LOG(WARNING,
> -                               "Service cores parsed before dataplane co=
res. Please ensure -c is before -s or -S");
> -               if (rte_eal_parse_coremask(optarg, lcore_indexes) < 0) {
> -                       EAL_LOG(ERR, "invalid coremask syntax");
> -                       return -1;
> -               }
> -               if (update_lcore_config(lcore_indexes) < 0) {
> -                       char *available =3D available_cores();
> -
> -                       EAL_LOG(ERR,
> -                               "invalid coremask, please check specified=
 cores are part of %s",
> -                               available);
> -                       free(available);
> -                       return -1;
> -               }
> -
> -               if (core_parsed) {
> -                       EAL_LOG(ERR, "Option -c is ignored, because (%s) =
is set!",
> -                               (core_parsed =3D=3D LCORE_OPT_LST) ? "-l"=
 :
> -                               (core_parsed =3D=3D LCORE_OPT_MAP) ? "--l=
cores" :
> -                               "-c");
> -                       return -1;
> -               }
> -
> -               core_parsed =3D LCORE_OPT_MSK;
> +       case 'c':
> +               lcore_options.core_mask_opt =3D optarg;
>                 break;
> -       }
>         /* corelist */
> -       case 'l': {
> -               int lcore_indexes[RTE_MAX_LCORE];
> -
> -               if (eal_service_cores_parsed())
> -                       EAL_LOG(WARNING,
> -                               "Service cores parsed before dataplane co=
res. Please ensure -l is before -s or -S");
> -
> -               if (eal_parse_corelist(optarg, lcore_indexes) < 0) {
> -                       EAL_LOG(ERR, "invalid core list syntax");
> -                       return -1;
> -               }
> -               if (update_lcore_config(lcore_indexes) < 0) {
> -                       char *available =3D available_cores();
> -
> -                       EAL_LOG(ERR,
> -                               "invalid core list, please check specifie=
d cores are part of %s",
> -                               available);
> -                       free(available);
> -                       return -1;
> -               }
> -
> -               if (core_parsed) {
> -                       EAL_LOG(ERR, "Option -l is ignored, because (%s) =
is set!",
> -                               (core_parsed =3D=3D LCORE_OPT_MSK) ? "-c"=
 :
> -                               (core_parsed =3D=3D LCORE_OPT_MAP) ? "--l=
cores" :
> -                               "-l");
> -                       return -1;
> -               }
> -
> -               core_parsed =3D LCORE_OPT_LST;
> +       case 'l':
> +               lcore_options.core_list_opt =3D optarg;
>                 break;
> -       }
>         /* service coremask */
>         case 's':
> -               if (eal_parse_service_coremask(optarg) < 0) {
> -                       EAL_LOG(ERR, "invalid service coremask");
> -                       return -1;
> -               }
> +               lcore_options.service_mask_opt =3D optarg;
>                 break;
>         /* service corelist */
>         case 'S':
> -               if (eal_parse_service_corelist(optarg) < 0) {
> -                       EAL_LOG(ERR, "invalid service core list");
> -                       return -1;
> -               }
> +               lcore_options.service_list_opt =3D optarg;
>                 break;
>         /* size of memory */
>         case 'm':
> @@ -1918,21 +1850,7 @@ eal_parse_common_option(int opt, const char *optar=
g,
>  #endif /* !RTE_EXEC_ENV_WINDOWS */
>
>         case OPT_LCORES_NUM:
> -               if (eal_parse_lcores(optarg) < 0) {
> -                       EAL_LOG(ERR, "invalid parameter for --"
> -                               OPT_LCORES);
> -                       return -1;
> -               }
> -
> -               if (core_parsed) {
> -                       EAL_LOG(ERR, "Option --lcores is ignored, because=
 (%s) is set!",
> -                               (core_parsed =3D=3D LCORE_OPT_LST) ? "-l"=
 :
> -                               (core_parsed =3D=3D LCORE_OPT_MSK) ? "-c"=
 :
> -                               "--lcores");
> -                       return -1;
> -               }
> -
> -               core_parsed =3D LCORE_OPT_MAP;
> +               lcore_options.core_map_opt =3D optarg;
>                 break;
>         case OPT_LEGACY_MEM_NUM:
>                 conf->legacy_mem =3D 1;
> @@ -1973,6 +1891,7 @@ eal_parse_common_option(int opt, const char *optarg=
,
>
>         }
>
> +

Unneeded empty line.

>         return 0;
>
>  ba_conflict:
> @@ -2046,8 +1965,74 @@ eal_adjust_config(struct internal_config *internal=
_cfg)
>         struct internal_config *internal_conf =3D
>                 eal_get_internal_configuration();
>
> -       if (!core_parsed)
> +       /* handle all the various core options, ignoring order of them.

Handle

> +        * First check that multiple lcore options (coremask, corelist, c=
oremap) are
> +        * not used together. Then check that the service options (corema=
sk, corelist)
> +        * are not both set. In both cases error out if multiple options =
are set.
> +        */
> +       if ((lcore_options.core_mask_opt && lcore_options.core_list_opt) =
||
> +                       (lcore_options.core_mask_opt && lcore_options.cor=
e_map_opt) ||
> +                       (lcore_options.core_list_opt && lcore_options.cor=
e_map_opt)) {
> +               EAL_LOG(ERR, "Only one of -c, -l and --"OPT_LCORES" may b=
e given at a time");
> +               return -1;
> +       }
> +       if ((lcore_options.service_mask_opt && lcore_options.service_list=
_opt)) {
> +               EAL_LOG(ERR, "Only one of -s and -S may be given at a tim=
e");
> +               return -1;
> +       }
> +
> +       if (lcore_options.core_mask_opt) {
> +               int lcore_indexes[RTE_MAX_LCORE];
> +
> +               if (rte_eal_parse_coremask(lcore_options.core_mask_opt, l=
core_indexes) < 0) {
> +                       EAL_LOG(ERR, "invalid coremask syntax");
> +                       return -1;
> +               }
> +               if (update_lcore_config(lcore_indexes) < 0) {
> +                       char *available =3D available_cores();
> +
> +                       EAL_LOG(ERR,
> +                               "invalid coremask, please check specified=
 cores are part of %s",
> +                               available);
> +                       free(available);
> +                       return -1;
> +               }
> +       } else if (lcore_options.core_list_opt) {
> +               int lcore_indexes[RTE_MAX_LCORE];
> +
> +               if (eal_parse_corelist(lcore_options.core_list_opt, lcore=
_indexes) < 0) {
> +                       EAL_LOG(ERR, "invalid core list syntax");
> +                       return -1;
> +               }
> +               if (update_lcore_config(lcore_indexes) < 0) {
> +                       char *available =3D available_cores();
> +
> +                       EAL_LOG(ERR,
> +                               "invalid core list, please check specifie=
d cores are part of %s",
> +                               available);
> +                       free(available);
> +                       return -1;
> +               }
> +       } else if (lcore_options.core_map_opt) {
> +               if (eal_parse_lcores(lcore_options.core_map_opt) < 0) {
> +                       EAL_LOG(ERR, "invalid parameter for --" OPT_LCORE=
S);
> +                       return -1;
> +               }
> +       } else {
>                 eal_auto_detect_cores(cfg);
> +       }
> +
> +       if (lcore_options.service_mask_opt) {
> +               if (eal_parse_service_coremask(lcore_options.service_mask=
_opt) < 0) {
> +                       EAL_LOG(ERR, "invalid service coremask");
> +                       return -1;
> +               }
> +       } else if (lcore_options.service_list_opt) {
> +               if (eal_parse_service_corelist(lcore_options.service_list=
_opt) < 0) {
> +                       EAL_LOG(ERR, "invalid service core list");
> +                       return -1;
> +               }
> +       }
>
>         if (internal_conf->process_type =3D=3D RTE_PROC_AUTO)
>                 internal_conf->process_type =3D eal_proc_type_detect();
> --
> 2.45.2
>


--=20
David Marchand

