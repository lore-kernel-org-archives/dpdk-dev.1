Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCA5CA0EF5
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 08:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D016040289;
	Tue, 19 Aug 2025 10:16:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3AB3C40262
 for <dev@dpdk.org>; Tue, 19 Aug 2025 10:16:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755591409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6f1IaGtPKuzzhc0OCcc1h27Hwafi9QCqTmWsbw6gMHU=;
 b=ZSrsEHWBJH8cRka8/66Sb5LBbutHtlQZZh+d7VoSnBV1mAWXJ3XXWmqjRZ2CfieNrQyxMn
 yPzyMyRVkavWUmN/bp9/FVlmErUGuWwXG9wJkTNl2lqIyKx3Nwz+rDnttBWx4T2a9m2AX8
 oIFnMOoSgJlBYBvJeQXs0QpBxUeVOpc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-lAewq95zOnWZ1Quoc2M_SA-1; Tue, 19 Aug 2025 04:16:48 -0400
X-MC-Unique: lAewq95zOnWZ1Quoc2M_SA-1
X-Mimecast-MFC-AGG-ID: lAewq95zOnWZ1Quoc2M_SA_1755591407
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-55ce52729d5so2555523e87.3
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755591407; x=1756196207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6f1IaGtPKuzzhc0OCcc1h27Hwafi9QCqTmWsbw6gMHU=;
 b=Q7V2MTD5Bie4Wo1UYJHhFFDbn4SGtjau39Yg1jA8p3AtRPsKOd+6lvVSAtVsTOLOEb
 ac+wP5fR5SonzhI1LFvDEgI5KJyXGHQwqqGjIZQdBSu8/WV9FgC0+t4UA3ZRPeLHAucA
 12hBUcWibsKu/nFT/G8UvycT01ZkZtgeLODfm7o/kGz4bpYr1S4NuuS0+t/y0+UPqyV1
 ha48XOqG8n65nX1g/GbFH7gdSwRGwBhU5xioZKw6WsJ4rL4ka/1HNirWqIVBU8qx7r1s
 mtLYCA1Fy4G7pSrJ83/AvLnF8Pur9c8hZZL/DeB/ihfrGGw0AcaDp2p3rokV9WGUDUF9
 xN/A==
X-Gm-Message-State: AOJu0Yz+clytBClU361/ELcs1Uc17X+iBe0omORvaTyjHBdyR1nw9PJb
 nHjhoLEw6mPHiEBwfJ98ISQpcg6wdtbvT6qZHK5DAHlLgtTg32qKV+2Nxee16zdHH4JnzfwzDSR
 Da4sG9JoWoJm7ihanCA75ewqzPUED/x7cEH2e2v/5aEL4R7rdSLzIwZVRdseh3/e8OLLF7+/48Z
 mK02Gk6gfwgEhBuZFwb6E=
X-Gm-Gg: ASbGncvV0kinW01as1cD2KA5cl/1/6I5rHpKAp+jCVkglnj/XHp+lEMpwaLAOBe62LO
 ohYlUz6O3ZpGwr3qpihJaWxoGFwYfialNRkoqRiYjomfEJJ7GjoanM+JFKkGQHsN/j6Ybkg8qjT
 tsMvlUz6vqcbgbJWLBTPpSGlc=
X-Received: by 2002:a05:6512:3e19:b0:553:d211:eb7e with SMTP id
 2adb3069b0e04-55e007bfc12mr455823e87.41.1755591406601; 
 Tue, 19 Aug 2025 01:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYgFeJCcUcouQWd9RIRU36oF3wMkwWOxVWkttCI56UKnm0vuA4isnX8uEkoQSqptHaUBR0rBSKyr1xRiOVW60=
X-Received: by 2002:a05:6512:3e19:b0:553:d211:eb7e with SMTP id
 2adb3069b0e04-55e007bfc12mr455816e87.41.1755591406136; Tue, 19 Aug 2025
 01:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250630132904.1704901-1-bruce.richardson@intel.com>
 <20250728151908.338534-1-bruce.richardson@intel.com>
 <20250728151908.338534-4-bruce.richardson@intel.com>
In-Reply-To: <20250728151908.338534-4-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 19 Aug 2025 10:16:34 +0200
X-Gm-Features: Ac12FXzObqbfXsWZZVBM1lEMsVB-1rYN17rN629pu23bpUt_hAvbw4MipkYTkQc
Message-ID: <CAJFAV8x6BR=C82u=3UO+z4K1y4Roki_PL6uLkk=S9DCB0YrE0w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] memif: : remove fallbacks for old Linux versions
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zutJE8iWS6dynILK7yiIysjbRnAtXxCbfE1XGAPaLZs_1755591407
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

On Mon, Jul 28, 2025 at 5:19=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> All supported linux versions support F_ADD_SEALS (Linux 3.17+) and
> MFD_HUGETLB (Linux 4.14+), so no need to have #ifdefs and fallbacks to
> support systems which do not support those features.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/memif/rte_eth_memif.h | 41 -------------------------------
>  1 file changed, 41 deletions(-)
>
> diff --git a/drivers/net/memif/rte_eth_memif.h b/drivers/net/memif/rte_et=
h_memif.h
> index 8e45a3ab78..d4e625ab51 100644
> --- a/drivers/net/memif/rte_eth_memif.h
> +++ b/drivers/net/memif/rte_eth_memif.h
> @@ -169,37 +169,6 @@ int memif_init_regions_and_queues(struct rte_eth_dev=
 *dev);
>   */
>  const char *memif_version(void);
>
> -#ifndef MFD_HUGETLB
> -#ifndef __NR_memfd_create
> -
> -#if defined __x86_64__
> -#define __NR_memfd_create 319
> -#elif defined __x86_32__
> -#define __NR_memfd_create 1073742143
> -#elif defined __arm__
> -#define __NR_memfd_create 385
> -#elif defined __aarch64__
> -#define __NR_memfd_create 279
> -#elif defined __powerpc__
> -#define __NR_memfd_create 360
> -#elif defined __i386__
> -#define __NR_memfd_create 356
> -#elif defined __riscv
> -#define __NR_memfd_create 279
> -#elif defined __loongarch__
> -#define __NR_memfd_create 279
> -#else
> -#error "__NR_memfd_create unknown for this architecture"
> -#endif
> -
> -#endif                         /* __NR_memfd_create */
> -
> -static inline int memfd_create(const char *name, unsigned int flags)
> -{
> -       return syscall(__NR_memfd_create, name, flags);
> -}
> -#endif                         /* MFD_HUGETLB */
> -
>  #ifndef F_LINUX_SPECIFIC_BASE
>  #define F_LINUX_SPECIFIC_BASE 1024
>  #endif
> @@ -208,14 +177,4 @@ static inline int memfd_create(const char *name, uns=
igned int flags)
>  #define MFD_ALLOW_SEALING       0x0002U
>  #endif

I suspect more stuff could be removed in this header.. but this is a
different topic than what the series deals with.
Thanks for the cleanup.


--=20
David Marchand

