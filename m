Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7DECCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 10:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F833402EE;
	Tue,  4 Nov 2025 11:14:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2B67C4028C
 for <dev@dpdk.org>; Tue,  4 Nov 2025 11:14:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762251253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7DEO1MxcsZMh9/AiUQoX6MMzUgjhITNYKlsktVJgg4=;
 b=dsujcjtpEYwezZ8HxxfsL1dHFmpo5pO9Rxh18IwlsZa3qyf6z9wJRcr5h2HWL2o+XRoJbo
 3kMJpbk7YGCi8DN5eWhpDxZUj+ZADjaSs5Sm99iWrWC2ybHuaUor/6I0Xoejf3pxs8edSr
 PWBKfoBF/RCNH15Y+F97h5SZVwoNMcc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-rLKjKiXFOvukNAj5uiAEvg-1; Tue, 04 Nov 2025 05:14:12 -0500
X-MC-Unique: rLKjKiXFOvukNAj5uiAEvg-1
X-Mimecast-MFC-AGG-ID: rLKjKiXFOvukNAj5uiAEvg_1762251251
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-36d99707249so26768621fa.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 02:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762251251; x=1762856051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7DEO1MxcsZMh9/AiUQoX6MMzUgjhITNYKlsktVJgg4=;
 b=TVRCa7eJKv3i6asXliNnUPcYvuGiB5bek0P4HyykvYAZJZgmaNVkKYj+NP3OGeYSre
 qSQPQ+VodcAhf8cFCNl8IjrfLMA4PAS8GbkcZhqG+bMX5mU0z8TVv4M3dC+XHoz9g2Qp
 UVO8MmOswHMRF7wkMTZeEHX8o51IYCYey9HTbzkQvgZ6Wz3YVP3np2ALhUIq6qlViyLN
 T5Fo/9VrzzvxbCDmFBtVtnMRJ8KXF/pi80l/HwW0CTMGzNwu0ilPs8qPk0hv5ZIIaSbC
 gvDRyci6Dq40ohzfteqYgh/7OnhpPuBkNLP9li+Rs7XGiO93EoqINN2NzHQgk2YKCCAD
 c4kQ==
X-Gm-Message-State: AOJu0Yz7KWxcXgCMCistipQE6n+YK5yllHIUrLZCDdMVEn7k8A9nCfRV
 n1T2xmpP98aejUCdEsWUEUOQHwmcI+iSIa3heZ+GMHjYeIQSh2F9KwilIvwnl/YJdWSVuQ+U2yv
 LgZZW7u9diL1HJFliZLmlVMkww0KT0syjx6xX6sNFBzOnhSyIX5oNkT5y82yyN9pFgpzYG67LuM
 1nipJDhZOvKSFlZvycKSo=
X-Gm-Gg: ASbGnctbbTyzHy7Ffm93N0eLpr8Zot4MTwIHZdb6xYg2VghycsL2qjsJvUcl9Sc4imh
 nifB7/spCPsytqEkmZTMMtlxd7YYh9KvEsV/d5LOdeFAaiJBghHzOrFw0OhH7fMv4WDByqAuo71
 zqEwWj8Fo9/ZL2tSkYF8hkJYRNGHrNMFNxFwxJ4CHblQ4520S5f9MS2HdvFA==
X-Received: by 2002:a05:6512:2249:b0:594:35c4:fed2 with SMTP id
 2adb3069b0e04-59435c501bemr551877e87.3.1762251250753; 
 Tue, 04 Nov 2025 02:14:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER3UCRGVuHgTcemBMujhWgfSydqkRNnNTvczKH6HppNVIJE/lMcYqIK8W7gvbN8Zn/p60rtESqG74oBXmLjMs=
X-Received: by 2002:a05:6512:2249:b0:594:35c4:fed2 with SMTP id
 2adb3069b0e04-59435c501bemr551858e87.3.1762251250292; Tue, 04 Nov 2025
 02:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20251027164621.175861-1-stephen@networkplumber.org>
In-Reply-To: <20251027164621.175861-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 4 Nov 2025 11:13:58 +0100
X-Gm-Features: AWmQ_bm1Jv46UlT5bRejSLvarI9SoAgtk8V6rvXcj59Gi-m2Lpjlut8-ZsFO9Io
Message-ID: <CAJFAV8yVqckdhv4ST0JRsCCO8mV-eqN-wtE_S1wU9raNLLkf2A@mail.gmail.com>
Subject: Re: [PATCH] dmadev: fix build if RTE_DMADEV_DEBUG enabled
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h4wiHwPYBzQZdd_etj3oJneGDPQP5sMb4roF3QLbVxk_1762251251
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

On Mon, 27 Oct 2025 at 17:46, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Missing definition of errnos causes build failure:
>
> In file included from ../lib/dmadev/rte_dmadev_trace.h:16,
>                  from ../lib/dmadev/rte_dmadev_trace_points.c:8:
> ../lib/dmadev/rte_dmadev.h: In function =E2=80=98rte_dma_copy=E2=80=99:
> ../lib/dmadev/rte_dmadev.h:1183:25: error: =E2=80=98EINVAL=E2=80=99 undec=
lared (first use in this function)
>  1183 |                 return -EINVAL;
>       |                         ^~~~~~
>
> Bugzilla ID: 1814
Fixes: 91e581e5c924 ("dmadev: add data plane API")
Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.


--=20
David Marchand

