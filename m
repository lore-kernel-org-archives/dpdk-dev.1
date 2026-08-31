Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4894C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:27:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFDB34025A;
	Mon, 31 Aug 2026 10:27:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 26B94400D5
 for <dev@dpdk.org>; Mon, 31 Aug 2026 10:27:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788164858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VwumQcREpfxrkewouxDL7bl2WJjyB0dJLH96KzWhskA=;
 b=NSJA/ICcR75wgWNFPo3t6tNAZbT+ShqwvxY/rWd7ZrIltQyjG4Cxm8Nabm1DlWXi4aYFmm
 3pnUOzyvsqvU98HKtLkJzUUZl3tIoy9VJS817PFKivmCQwcY05hVACE95haMpJ8AEKyoN1
 BXaz2wtxzUviP6P2xYZVFML8jvGRSB4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-6eV9WWAmM7CoftB_zNTkJQ-1; Mon, 31 Aug 2026 04:27:36 -0400
X-MC-Unique: 6eV9WWAmM7CoftB_zNTkJQ-1
X-Mimecast-MFC-AGG-ID: 6eV9WWAmM7CoftB_zNTkJQ_1788164855
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b4a1b66efeso2665081e87.0
 for <dev@dpdk.org>; Mon, 31 Aug 2026 01:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164855; x=1788769655;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VwumQcREpfxrkewouxDL7bl2WJjyB0dJLH96KzWhskA=;
 b=dZFNdna7W3TclZTIKOlq21TNml2yq3Tm+AltRQRNeraBoGdyCi4qiL6v1Ca+DCQ3sM
 wawR2qKrqEuxvIK4lCHclW4Pp0nC3IcJ3SBUDaZK69mhKyGAdhPb7VBDqIHc6a5hBoIC
 1R0ZlyeMfWJdB+wGcbvqS1S69T6goQUuK/SpXaB2452+IQFOcdHN3nyI62v1kCciIPmQ
 ZqbXRi4cWVpO+UDhI7Ac1VuMceEba1CnwEKcYzbjAc0M+zJ18vHt1k/7sRVkvfnfXxWn
 hnb38gDT9oInqti7A53zuwNZ5ui6hefXIe4QhjP/RuicYQKwu2S76xdeU7ztM69p8FyB
 6ung==
X-Gm-Message-State: AFuF++mE4EGr8bHVrVC/d9mMCm/LQ/g4OpV5LoKs9vP1FyMjfY7NIA1C
 o8VopPA5pAIClvXVcSaas+UqAaq2G7G974LAd1ymGniQcgdFGIfcmWzGyOSN6wrUQ+hXPo03VGj
 KxVzfyEE0HYPTZrllIJ4LPA0UsdfJFuiepnNMG34RQ6B5Gp7nJxec1udsp6c7/4eWYrqyBnjPPV
 /MuxTWPPnMbg9poQNtgX0=
X-Gm-Gg: AYBFou0A+JxPXocl6EcXhwh81i6JQdn8tN2vUWTRkgWZUbuWHt0ZcKfHol9wYbGJTLy
 yIfcCGi4zHk7NbE3kzrssCVelGRZOgHGh0aT+EtsJj0yYv26LGsuonLHRalDRRIGXIrHV7/JAFO
 0Eqm56i89Y3XnIHTUdddWaT4HL6eunewfxH0E8TeaH+99GFa6H0IikYFKRqS+yMY5RwpIo6pzGE
 FqqifenYHKhZ86vk0VznKGxNpQqwB4Ib6692DYoTWl0P+/B
X-Received: by 2002:a05:6512:3d9e:b0:5b2:a22c:50ff with SMTP id
 2adb3069b0e04-5b5f6716cb6mr1926198e87.19.1788164855031; 
 Mon, 31 Aug 2026 01:27:35 -0700 (PDT)
X-Received: by 2002:a05:6512:3d9e:b0:5b2:a22c:50ff with SMTP id
 2adb3069b0e04-5b5f6716cb6mr1926191e87.19.1788164854497; Mon, 31 Aug 2026
 01:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260829154706.52169-1-stephen@networkplumber.org>
In-Reply-To: <20260829154706.52169-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 31 Aug 2026 10:27:22 +0200
X-Gm-Features: AcwNN1VRJF4aH6h95AqDQ3t5YMzPhgbWytvVjiBSOQvX_tbwwaijxTAFPvWanGY
Message-ID: <CAJFAV8z5MoC9ZmP=Xzef3U4+mi+imbDzkw1cgd+=B+u0dOosiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fix clang 23 unused but set warnings
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b1voSiL9-wkaAUz6BJ3f-6t54HWRshsTeFiivMTdbsc_1788164855
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

On Sat, 29 Aug 2026 at 17:47, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Clang 23 adds -Wunused-but-set-global, which reports file scope
> variables that are assigned but never read. It is enabled by -Wall and
> does not appear with gcc or with clang 20 through 22.
>
> Three of these are dead variables and are simply removed. The fourth,
> 'alive' in dpaa_of.c, is a real debug aid: it is only read by
> DPAAX_HWWARN, which discards its condition when RTE_LIBRTE_DPAAX_DEBUG
> is not defined. That one is fixed by making the empty expansion consume
> its argument, which keeps the condition compiled in both builds and
> covers every other DPAAX_HWWARN user as well.
>
> v2 - remove more unused code as suggested.
>
> Stephen Hemminger (4):
>   common/dpaax: fix unused variable warning in non-debug build
>   bus/dpaa: remove unused qman_clk variable
>   common/zsda: remove unused device counter
>   net/qede: remove unused app version variable
>
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  4 ----
>  drivers/common/dpaax/dpaax_logs.h         |  3 ++-
>  drivers/common/zsda/zsda_device.c         |  5 -----
>  drivers/net/qede/qede_debug.c             | 20 --------------------
>  4 files changed, 2 insertions(+), 30 deletions(-)

For the series:
Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

