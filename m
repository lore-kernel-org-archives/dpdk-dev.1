Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B514ACCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 14:40:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7D9E40609;
	Wed, 29 Oct 2025 15:40:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DA4044042F
 for <dev@dpdk.org>; Wed, 29 Oct 2025 15:40:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761748830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNmKX/hEzm1E1/q5CdhMfwU91FdZLxmDD+1iCfM5COA=;
 b=c9ar++V3EhygnrWYD/TFuSO9ZllU8hgK1d0e63yiHUXVGc+4p5SHcEXK4P4NGfqX93KTgI
 3nBgVQeUlWhkLn1yhFd4MVYZv7YNNdr2Z+Li8Pv1uT6nyAwmSxHIxg/hZ6rP0625I4DdWh
 MQJ+Y4j/VWH4ilxMzomtIBvyzvj/TBg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-TkOyFL1yNmSnuXwuhBBadg-1; Wed, 29 Oct 2025 10:40:28 -0400
X-MC-Unique: TkOyFL1yNmSnuXwuhBBadg-1
X-Mimecast-MFC-AGG-ID: TkOyFL1yNmSnuXwuhBBadg_1761748827
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-57893a7d7b6so7076434e87.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 07:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761748827; x=1762353627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xNmKX/hEzm1E1/q5CdhMfwU91FdZLxmDD+1iCfM5COA=;
 b=g9ySyN6peffO8cZM7QSMWSYusxNft0Eptou8f/hVmtLdBVxF1ELkoFFIhMJwbEbSv3
 LW8jF2KjXrw5GymAIG5ACo/PCoilZ9foywOi+xmHL8O/yJ7VVY4zNpPD9TiUphOAeJL2
 +1D3ZqJIHDmhqVv2VBXbhBCdieVi62RaR8aMjPUJ+oDqDfUbbcoYpTYC40mW+8N6G60J
 3oJ5ECYVk2/J1JYht8Bes+qvgsf+0CtWJc4c8qzOGsPgV2lUjvbE0+v+9hbck7UJJPXu
 yZ8B884f4tXlQztLRyKvdcSb7mby7uynhPpadisIwlGeE1UHMy3+GrlKCsdDkJcEOL2z
 0DTw==
X-Gm-Message-State: AOJu0YyL/sjrhSMtQ/5myjejA5aH0htxzrX9shJjSlgSEujx2mzNVx9L
 L0cXf76LVvfnBX+23hyUMD2HLOvobfwjKpXXxm7nP4ok0Hs2p+fMrZmHr52FfslYmLfdovMvUwW
 8zyD4NdYhIvVgR/XRUg57/ojQ4cZH1Mq894g5rvHJqE1mbd4zQ2df03nmIg8jIWaLLcxqywTOKm
 02yMYdyLr7bF6BEv4vofU=
X-Gm-Gg: ASbGncvHNa9HJZgWMjfp5G8hbkEa1q8Edpa8x4F3jnTzOwvVBjWLr6jzhBQZeapWQ91
 rNkA7nr8NbkG5K7NunLCxUOp40r3AjSEnSI7invsOCw5/eHKtW8bku3wuA2RGzIL6equwM6WeXm
 hjAoqPCWlRiQaS9NKGrxIiqL2cFZ1wRAwkmi/P1blRvwRDhP6Zen/r4+tLkw==
X-Received: by 2002:a05:6512:3d22:b0:592:f573:65d3 with SMTP id
 2adb3069b0e04-594128738bfmr1223102e87.1.1761748827143; 
 Wed, 29 Oct 2025 07:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2QJBlAEjE+Ews7lHSrKqafx+/crvonIaA2xPY5IuqcQ+p0T0U6eDz1jJEo/P/9l0qc2x6XRMz1kutTgRdrDQ=
X-Received: by 2002:a05:6512:3d22:b0:592:f573:65d3 with SMTP id
 2adb3069b0e04-594128738bfmr1223081e87.1.1761748826658; Wed, 29 Oct 2025
 07:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251027164621.175861-1-stephen@networkplumber.org>
 <CAJFAV8zi5=hBo6wEWwqr=QZyzodkf1K-39m82Fj9CA+-2SX1PQ@mail.gmail.com>
 <20251029073215.494d130e@phoenix>
In-Reply-To: <20251029073215.494d130e@phoenix>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 29 Oct 2025 15:40:15 +0100
X-Gm-Features: AWmQ_bn0IzWrxeEsS85CzGCJsEH3WXRTvFTtPJGq8bVWVUqN_dY8DsQwuA4Cvwo
Message-ID: <CAJFAV8z=Vz9XjPhwfapgy5UZoKRVOwM4nt5JCFZ17e4EnqwKjQ@mail.gmail.com>
Subject: Re: [PATCH] dmadev: fix build if RTE_DMADEV_DEBUG enabled
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E-pH1LAXyX0rQ-kPozLmzPRHgYQL0speIyK53LCvYGI_1761748827
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

On Wed, 29 Oct 2025 at 15:32, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 29 Oct 2025 14:48:13 +0100
> David Marchand <david.marchand@redhat.com> wrote:
>
> > On Mon, 27 Oct 2025 at 17:46, Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > Missing definition of errnos causes build failure:
> > >
> > > In file included from ../lib/dmadev/rte_dmadev_trace.h:16,
> > >                  from ../lib/dmadev/rte_dmadev_trace_points.c:8:
> > > ../lib/dmadev/rte_dmadev.h: In function =E2=80=98rte_dma_copy=E2=80=
=99:
> > > ../lib/dmadev/rte_dmadev.h:1183:25: error: =E2=80=98EINVAL=E2=80=99 u=
ndeclared (first use in this function)
> > >  1183 |                 return -EINVAL;
> > >       |                         ^~~~~~
> > >
> > > Bugzilla ID: 1814
> > > Fixes: 8f1d23ece06a ("eal: deprecate RTE_FUNC_PTR_* macros")
> >
> > I am not following the rationale... 8f1d23ece06a removed a macro but
> > use of errno was already there, so I am skeptical this is the right
> > Fixes: tag.
> >
> > The issue was present from the start, so:
> > Fixes: 91e581e5c924 ("dmadev: add data plane API")
> >
> > > Cc: david.marchand@redhat.com
> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> >
> >
>
> Yes, the fixes tag is incorrect. The issue probably goes back further
> in time. Might be related to tracepoints not including errno.h

Tracepoints were added later.

$ git blame 91e581e5c924 -- lib/dmadev/rte_dmadev.h | grep -A3 -E
'#include|RTE_DMADEV_DEBUG'
b36970f2e13 (Chengwen Feng 2021-10-13 20:24:55 +0800  147) #include <stdint=
.h>
b36970f2e13 (Chengwen Feng 2021-10-13 20:24:55 +0800  148)
b36970f2e13 (Chengwen Feng 2021-10-13 20:24:55 +0800  149) #include
<rte_bitops.h>
b36970f2e13 (Chengwen Feng 2021-10-13 20:24:55 +0800  150) #include
<rte_common.h>
b36970f2e13 (Chengwen Feng 2021-10-13 20:24:55 +0800  151) #include
<rte_compat.h>
b36970f2e13 (Chengwen Feng 2021-10-13 20:24:55 +0800  152) #include <rte_de=
v.h>
b36970f2e13 (Chengwen Feng 2021-10-13 20:24:55 +0800  153)
b36970f2e13 (Chengwen Feng 2021-10-13 20:24:55 +0800  154) #ifdef __cpluspl=
us
b36970f2e13 (Chengwen Feng 2021-10-13 20:24:55 +0800  155) extern "C" {
--
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  739) #include
"rte_dmadev_core.h"
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  740)
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  741) /**@{@name
DMA operation flag
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  742)  * @see
rte_dma_copy()
--
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  801) #ifdef
RTE_DMADEV_DEBUG
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  802)     if
(!rte_dma_is_valid(dev_id) || length =3D=3D 0)
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  803)
return -EINVAL;
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  804)
RTE_FUNC_PTR_OR_ERR_RET(*obj->copy, -ENOTSUP);
--
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  851) #ifdef
RTE_DMADEV_DEBUG
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  852)     if
(!rte_dma_is_valid(dev_id) || src =3D=3D NULL || dst =3D=3D NULL ||
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  853)
nb_src =3D=3D 0 || nb_dst =3D=3D 0)
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  854)
return -EINVAL;
--
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  898) #ifdef
RTE_DMADEV_DEBUG
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  899)     if
(!rte_dma_is_valid(dev_id) || length =3D=3D 0)
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  900)
return -EINVAL;
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  901)
RTE_FUNC_PTR_OR_ERR_RET(*obj->fill, -ENOTSUP);
--
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  931) #ifdef
RTE_DMADEV_DEBUG
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  932)     if
(!rte_dma_is_valid(dev_id))
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  933)
return -EINVAL;
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  934)
RTE_FUNC_PTR_OR_ERR_RET(*obj->submit, -ENOTSUP);
--
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  972) #ifdef
RTE_DMADEV_DEBUG
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  973)     if
(!rte_dma_is_valid(dev_id) || nb_cpls =3D=3D 0)
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  974)         return 0=
;
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800  975)
RTE_FUNC_PTR_OR_ERR_RET(*obj->completed, 0);
--
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800 1032) #ifdef
RTE_DMADEV_DEBUG
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800 1033)     if
(!rte_dma_is_valid(dev_id) || nb_cpls =3D=3D 0 || status =3D=3D NULL)
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800 1034)         return 0=
;
91e581e5c92 (Chengwen Feng 2021-10-13 20:24:57 +0800 1035)
RTE_FUNC_PTR_OR_ERR_RET(*obj->completed_status, 0);


--=20
David Marchand

