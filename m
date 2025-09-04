Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF63CA1002
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 14:55:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B3334278F;
	Thu,  4 Sep 2025 16:55:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A6B814275D
 for <dev@dpdk.org>; Thu,  4 Sep 2025 16:55:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756997716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xawsi6yFTU7Uo0q2qwzudDFxRHPUaRWjqwxLW/fm0rc=;
 b=igPeEdNwXff35IXYzD2beDRiZlos9uVV5Xs3l/TyA1YnLNLApESdsF6ZSYEQsIas9kT7Cx
 Rq7Wu1OfxWfFsthoP1VcTd/X8xXSGP+qc1YSSAR8wey/cEjlw9TK2eFirk0yqrWITPeyb8
 +wFc4aDefu8Wzntn4lHD/CEQu1Vk4Sk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-umAo3QnDOYWFXAjjd2Rymg-1; Thu, 04 Sep 2025 10:55:12 -0400
X-MC-Unique: umAo3QnDOYWFXAjjd2Rymg-1
X-Mimecast-MFC-AGG-ID: umAo3QnDOYWFXAjjd2Rymg_1756997711
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-56087e8494dso799607e87.3
 for <dev@dpdk.org>; Thu, 04 Sep 2025 07:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756997711; x=1757602511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xawsi6yFTU7Uo0q2qwzudDFxRHPUaRWjqwxLW/fm0rc=;
 b=H/mVb1I9XDtdPYe9zlYSUcJIQGBKf1pU0NFoPQsCRrNqlDucpoMhZs1uMEVYggLTGk
 sStAqKXvM6vtFoj8KQsolPaM/pPKXpOG5GojOhzMIzAL6DvalNAag+Sm+VSJfJaAU16z
 uQWxmpVyGy3vIEOBpuGxrmVCop7Q3KQdbZldojjpp+SXYfHfXFa3cqDfONyzZpHe1q3O
 KoPJhcrye1lEwask8Zzlfl/UhvYozHIXCFtlipu3ZYmxYR+gz/p9fuS2iH/QhE8DeYbz
 VvnPJFLkGRyTbtND7CCtm8EswHuChwKO5xHq5/FCV1OqX2n9Mr2Q8iLDEC18/pJ+/5En
 kL0Q==
X-Gm-Message-State: AOJu0YyjD7VbyKWXJePBR1EVdc6X4FhzOfBrt08EBDj6g23Z16SYabkm
 oEOLeh8xkmookADh+1QLJd7+E1hRQwCeL4jJUY8q4sQ5PRGxxjt1K9JYAmbftrFwpQJOS1Tpwi4
 dI4eYE6iBoD/+Iy6yKCjLyuPsVA8nClZsqmvHLDbjmBx+tQOpFbYCVNhhBDfIbGedPue7lT5Bw1
 arP1Qxc+viBj+fLQUbfi8=
X-Gm-Gg: ASbGncveGZ/WS+3emRxK+1VvrtGWG/OajelikbXy1+Pq9GqVxlbfSPVUCwjvpg7F9qr
 0LMOcTCHp3ff0EZthCXRicZOjnR+q/xFbgEs6Yiy24weh3I7aX90CSKT8zty58mRXj6wSTjRwGX
 2QwgVEn8OUECFk7htStJodb20=
X-Received: by 2002:a05:6512:608b:b0:55f:6831:6eef with SMTP id
 2adb3069b0e04-55f7089c58amr5455829e87.8.1756997711269; 
 Thu, 04 Sep 2025 07:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkiIY2gyxvW8Nt9l+cTct7iOsG2Z6R6JQApRVbNm34jiXREBTUaVswHx0KUK1Zz9OKYpf8xnQJo5M75qDlbso=
X-Received: by 2002:a05:6512:608b:b0:55f:6831:6eef with SMTP id
 2adb3069b0e04-55f7089c58amr5455810e87.8.1756997710831; Thu, 04 Sep 2025
 07:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250904141059.54626-1-luca.boccassi@gmail.com>
 <20250904141854.55944-1-luca.boccassi@gmail.com>
In-Reply-To: <20250904141854.55944-1-luca.boccassi@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 4 Sep 2025 16:54:58 +0200
X-Gm-Features: Ac12FXz64ay_1kB125sqhZ2-cp8aQIVkrExkPsX7gy1J7e5-7u8RqbYF3f-oNVQ
Message-ID: <CAJFAV8yUUCXX0CmxPmTrUZdMqRb_Ebb0EjvGFxXQeM_QAeyBVQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/zxdh: fix building check for arm64
To: luca.boccassi@gmail.com
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FFYocyzC_-e14aSKBVME_8Ydmmsup1u-9TEGFOOLJ_8_1756997711
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 4 Sept 2025 at 16:19, <luca.boccassi@gmail.com> wrote:
>
> From: Luca Boccassi <luca.boccassi@gmail.com>
>
> The comment and docs say this should be built on x86_64 and aarch64,
> but RTE_ARCH_64 is not aarch64, that's RTE_ARCH_ARM64, so fix it.
>
> Also the check makes the build skip unless RTE_ARCH_X86_64 is true,
> so switch it to an 'and' instead of an 'or', to build on both arm64
> and x86_64, and skip elsewhere.
>
> Fixes: 29e89288ff14 ("net/zxdh: add driver skeleton")
> Cc: stable@dpdk.org
>
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>

Good catch.

It seems we have similar construct in other drivers (and some of them
look buggy, like net/hns3 X and Y or Z without parens).
Could we align all on a single way of checking this combination?


$ git grep -B4 'only supported on x86_64 and aarch64'
drivers/common/sfc_efx/meson.build-endif
drivers/common/sfc_efx/meson.build-
drivers/common/sfc_efx/meson.build-if (arch_subdir != 'x86' and
arch_subdir != 'arm') or (not dpdk_conf.get('RTE_ARCH_64'))
drivers/common/sfc_efx/meson.build-    build = false
drivers/common/sfc_efx/meson.build:    reason = 'only supported on
x86_64 and aarch64'
--
drivers/dma/hisilicon/meson.build-endif
drivers/dma/hisilicon/meson.build-
drivers/dma/hisilicon/meson.build-if (arch_subdir != 'x86' and
arch_subdir != 'arm') or (not dpdk_conf.get('RTE_ARCH_64'))
drivers/dma/hisilicon/meson.build-    build = false
drivers/dma/hisilicon/meson.build:    reason = 'only supported on
x86_64 and aarch64'
--
drivers/net/hns3/meson.build-endif
drivers/net/hns3/meson.build-
drivers/net/hns3/meson.build-if arch_subdir != 'x86' and arch_subdir
!= 'arm' or not dpdk_conf.get('RTE_ARCH_64')
drivers/net/hns3/meson.build-    build = false
drivers/net/hns3/meson.build:    reason = 'only supported on x86_64 and aarch64'
--
drivers/net/sfc/meson.build-endif
drivers/net/sfc/meson.build-
drivers/net/sfc/meson.build-if (arch_subdir != 'x86' and arch_subdir
!= 'arm') or (not dpdk_conf.get('RTE_ARCH_64'))
drivers/net/sfc/meson.build-    build = false
drivers/net/sfc/meson.build:    reason = 'only supported on x86_64 and aarch64'
--
drivers/net/zxdh/meson.build-endif
drivers/net/zxdh/meson.build-
drivers/net/zxdh/meson.build-if not dpdk_conf.has('RTE_ARCH_X86_64')
or not dpdk_conf.get('RTE_ARCH_64')
drivers/net/zxdh/meson.build-    build = false
drivers/net/zxdh/meson.build:    reason = 'only supported on x86_64 and aarch64'
--
drivers/vdpa/sfc/meson.build-if ((arch_subdir != 'x86' or not
dpdk_conf.get('RTE_ARCH_64')) and
drivers/vdpa/sfc/meson.build-        (arch_subdir != 'arm' or not
drivers/vdpa/sfc/meson.build-
host_machine.cpu_family().startswith('aarch64')))
drivers/vdpa/sfc/meson.build-    build = false
drivers/vdpa/sfc/meson.build:    reason = 'only supported on x86_64 and aarch64'


-- 
David Marchand

