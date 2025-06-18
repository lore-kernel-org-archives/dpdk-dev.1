Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6FCC7115B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 09:26:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DC0A427D1;
	Wed, 18 Jun 2025 11:26:46 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id 3823240EE2
 for <dev@dpdk.org>; Wed, 18 Jun 2025 11:26:45 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4a5a196f057so144000891cf.3
 for <dev@dpdk.org>; Wed, 18 Jun 2025 02:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750238804; x=1750843604; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tDZvPYcrD10RxMuqB/Hqb2WwmKFFcwwQW1AkxyPMmw=;
 b=Te4g4rwe9ufGVg2G99AJ8McN4MEW2cQ+wpa1GIawRXsWTAW+V5OvzYwFlHgBGla8zq
 ZGJbxVJXnIL9U1SIvkGA/P75ATRdsLvn1Xf6MsRPBddMd5R/0G/4pP7wafDQDoPptiwc
 044NDmFzyUPO0DHjk+knYrkSwlwAvkWUyURIrtYHznjDocGN/B74kcbgai9nsms+Kmde
 /mZdoBT5IXbKMbAIUL7cIXvVUENGimTEcxK/w5YBzEUFGJ681wR2VOaoACw76hONoPl/
 y2nrJWyPfAFTiZD3GixTkHstyoQJYa0ZJ2a5k0AoaONJrkc3IOuw+V6+/guK4BXAE/Th
 SdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750238804; x=1750843604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tDZvPYcrD10RxMuqB/Hqb2WwmKFFcwwQW1AkxyPMmw=;
 b=OVtIADTPUEAqLzSDdTzJJ6TUuyG0pvv4y83PMNH2t7WMzF4zuAWR/HusFcydBARl2m
 EzimmtI1MV1G+/P0hEibDD2Lm7XFbvT54yYdUTNHTjoKnGppONid3FAyPyFrIMm/sb3G
 a8oYfVmX1NRv2dXK1eA9z3vnaEBxBHkL8wHWHLDhd7zTXjrzczyk0J2510dyI9irgU5O
 ChKofbI/XS4dFOigFfL4q+ZPKFexHxoVMZkBnX75iSUP2pdohxk/yp37Su9olvpsY+qu
 0i8lTnmfpghdywptekse6op9WuwF5F/G2zFp2p7igETukFmMm2QlPCjRjNM7q/qvHvo2
 /7/g==
X-Gm-Message-State: AOJu0YxdSnTlmcyS2VVjEhvd1LmIjzOJ8DIM7DJqMWNRzrGg2KOSaBXv
 pHnFR2TM9otWw6uCspzn1c7tv+uiF69uv5u7NDEFoh30ujgRhDGWxgLCv/l0NbLR9G1ADU21HJ6
 XSFIxKSEg0Iy6loNsKfOG/u57lwSM+o8=
X-Gm-Gg: ASbGncv+4zoZKKY+elQv/DsmSByihVFAOi5Tmg9vNY37wTzCvA//NsnQoPP8+cNM5Jx
 /c8DJkucPZoBY4RtSsrJsShlRJJ+0J8pJ9sUmJyVv8J48nqQAK7tbP/6H9XKkB/C2D8tT8w6J6H
 iEy3+6CIiJ9CYy4PRXMIqEukLAIyuu3xxpehP/ItGYxw==
X-Google-Smtp-Source: AGHT+IGV77yMob8fo6yjwBcGc4V33bqGs0He2x13hhyCpf93TyF0QlqWUG+ZyJ9MBc0q0L18x9PzcghR/gp+KHYvmZ4=
X-Received: by 2002:ac8:5a8c:0:b0:4a3:adbb:494a with SMTP id
 d75a77b69052e-4a73c596f7emr280005051cf.28.1750238804507; Wed, 18 Jun 2025
 02:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250617182631.257612-1-pravin.pathak@intel.com>
 <20250617182631.257612-5-pravin.pathak@intel.com>
In-Reply-To: <20250617182631.257612-5-pravin.pathak@intel.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 18 Jun 2025 14:56:18 +0530
X-Gm-Features: AX0GCFttJTgg5UV-YXVoR-BeDfVJCfCcFldHrjxZyNfuT_hfun5u2dHc-OMj1qg
Message-ID: <CALBAE1OOfvi-+2bnkWteS1TVYjjNT26asMCXCZ7rswOJTsCPrQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] event/dlb2: support managing history list resource
To: Pravin Pathak <pravin.pathak@intel.com>
Cc: dev@dpdk.org, jerinj@marvell.com, mike.ximing.chen@intel.com, 
 bruce.richardson@intel.com, thomas@monjalon.net, david.marchand@redhat.com, 
 nipun.gupta@amd.com, chenbox@nvidia.com, tirthendu.sarkar@intel.com
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

On Wed, Jun 18, 2025 at 12:52=E2=80=AFAM Pravin Pathak <pravin.pathak@intel=
.com> wrote:
>
> Add support for setting application specified port history
> Set HL equal to CQ depth when inflight control is enabled
> Added command line parameters 'use_default_hl' (default: 1)
>    and 'alloc_hl_entries'
>  - When 'use_default_hl =3D 1'
>    * Per port HL is set to DLB2_FIXED_CQ_HL_SIZE (32)
>    * Recommended CQ depth by dlb2_eventdev_port_default_conf_get()
>      is DLB2_FIXED_CQ_HL_SIZE/2
>    * command line parameter alloc_hl_entries is ignored
>  - When 'use_default_hl =3D 0'
>    * Per LDB port HL =3D 2 * CQ depth
>    * Recommended CQ depth by dlb2_eventdev_port_default_conf_get()
>      is DLB2_FIXED_CQ_HL_SIZE
>    * User should calculate needed HL entries based on CQ depths the
>      application will use and specify it as command line parameter
>      'alloc_hl_entries'.  This will be used to allocate HL entries.
>       alloc_hl_entries =3D (Sum of all LDB ports CQ depths * 2)
>    * If alloc_hl_entries is not specified, then
>      Total HL entries for the eventdev  =3D num_ldb_ports * 64
>
> Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> ---

> -/*!
> +/**
>   * @warning
>   * @b EXPERIMENTAL: this API may change, or be removed, without prior no=
tice
>   *
> @@ -91,6 +91,52 @@ rte_pmd_dlb2_set_token_pop_mode(uint8_t dev_id,
>                                 uint8_t port_id,
>                                 enum dlb2_token_pop_mode mode);
>
> +/** Set inflight threshold for flow migration */
> +#define DLB2_SET_PORT_FLOW_MIGRATION_THRESHOLD RTE_BIT64(0)
> +
> +/** Set port history list */
> +#define DLB2_SET_PORT_HL RTE_BIT64(1)
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior no=
tice

This is NOT API

> + *
> + * Sets TDT threshold and HL size for a DLB2 port.
> + */
> +struct rte_pmd_dlb2_port_param {
> +       uint16_t inflight_threshold : 12;
> +       uint16_t port_hl;

Doxygen comments for each field is missing.


> +};
> +
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change, or be removed, without prior no=
tice
> + *
> + * Configure various port parameters.
> + * This function must be called before calling rte_event_port_setup()
> + * for the port, and after calling rte_event_dev_configure().
> + *
> + * @param dev_id
> + *    The identifier of the event device.
> + * @param port_id
> + *    The identifier of the event port.
> + * @param flags
> + *    Bitmask of the parameters being set.
> + * @param val
> + *    Structure coantaining the values of parameters being set.

coantaining - Typo


> + *
> + * @return
> + * - 0: Success
> + * - EINVAL: Invalid dev_id, port_id, or mode
> + * - EINVAL: The DLB2 is not configured, is already running, or the port=
 is
> + *   already setup
> + */
> +__rte_experimental
> +int
> +rte_pmd_dlb2_set_port_param(uint8_t dev_id,
> +                           uint8_t port_id,
> +                           uint64_t flags,
> +                           void *val);

Why void * - Is it rte_pmd_dlb2_port_param * pointer. Right?

Also fix following issues

1)[for-main]dell[dpdk-next-eventdev] $ git diff HEAD~7..HEAD | grep \(void\=
)
+       (void) enqueue_depth;

use RTE_SET_USED

2)

### [PATCH] event/dlb2: support managing history list resource

Warning in drivers/event/dlb2/dlb2.c:
Using %l format, prefer %PRI*64 if type is [u]int64_t

### [PATCH] event/dlb2: fix qid depth xstat in vector path

WARNING:LINE_CONTINUATIONS: Avoid unnecessary line continuations
#21: FILE: drivers/event/dlb2/dlb2.c:4148:
+               DLB2_INC_STAT(qm_port->ev_port->stats.queue[ev_qid3].\

WARNING:LINE_CONTINUATIONS: Avoid unnecessary line continuations
#30: FILE: drivers/event/dlb2/dlb2.c:4157:
+               DLB2_INC_STAT(qm_port->ev_port->stats.queue[ev_qid2].\

WARNING:LINE_CONTINUATIONS: Avoid unnecessary line continuations
#39: FILE: drivers/event/dlb2/dlb2.c:4167:
+               DLB2_INC_STAT(qm_port->ev_port->stats.queue[ev_qid1].\

WARNING:LINE_CONTINUATIONS: Avoid unnecessary line continuations
#48: FILE: drivers/event/dlb2/dlb2.c:4176:
+               DLB2_INC_STAT(qm_port->ev_port->stats.queue[ev_qid0].\

total: 0 errors, 4 warnings, 32 lines checked




>  #ifdef __cplusplus
>  }
>  #endif
> --
> 2.39.1
>
