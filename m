Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A394CD5BA4
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 16:47:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBABE4042F;
	Wed, 20 May 2026 18:47:45 +0200 (CEST)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50]) by mails.dpdk.org (Postfix) with ESMTP id D1B95400EF
 for <dev@dpdk.org>; Wed, 20 May 2026 18:47:44 +0200 (CEST)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-651c7ddf514so4793581d50.1
 for <dev@dpdk.org>; Wed, 20 May 2026 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779295664;
 x=1779900464; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRVAnkxsxoWKPiplylt4TnHc4VAamx72gj30V8BnZW4=;
 b=t9leK6fcMHUPEErXoy2Gb44xAp5rFgpWtEcTD8QOTU02BnQT0dfcBPbllCcYii3E+M
 UDtAT5hfdPBNu0ZVlTO4wQ9uJlb3hPpX8zArLhcp6U1fLkEO2Vuizr7V0SGGslFgl9MU
 xiv7fN6TwuZGBS2VSYZZDV+p8B+YXUTjNid1qslYGE7C+KpJWq8bWm+YaEjLWaeL9uTC
 Wf9G010kXkm1YhddGm9jtleyFSPWQwSxwunOu2TGDkaILpm1Qj0M8IbNARbz1mSI7njW
 L5HzV4YdYzBnQc4rCypfsiwugqmwmbYgZAg9aN9fXqxS98aiTsF2fmZMmI/Sd+AObvrS
 nLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779295664; x=1779900464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aRVAnkxsxoWKPiplylt4TnHc4VAamx72gj30V8BnZW4=;
 b=F2xtJTJaUH/g+fqQh68QqcLCTSU6k6OYAdGNyD/mMiuw0xDEb99BOc4ikWbjYz409j
 pPbT6UKR89x0jM3tKXR142MP74BsREB9F+hqKP4r+UPOUMNjle/e9MGTJlNyE4JqzSye
 /hqcsrOM7SdAEMvkim9JMot4FEO1UFsIvAdvwh97OAZm3bRPSgB6kOfnW2X8ovAiMJo3
 RDx3KeVCNhlSWdgpGNL085A0HhMo2LnsFrYJJWTTbRAOIlUjhoXCTjJ9OPZ+2rc6cfgE
 6J6qZhRPnxm2R80K9AB5JxchKbxIfTWhUpHijD/airaATA4XB7++DhaQdgyjZ0uCLho9
 VhQg==
X-Gm-Message-State: AOJu0YyR13IabXi1ChXyKkTFsQpkQ+rRUujuuVbTX/RlUx/AEHOWWiN4
 jR28xtZ/5uvT21nVWwI+ZR53JIbkPz4yaZCjVVGlmMW4v1l7agLcvhrwyezCkw4BiwE=
X-Gm-Gg: Acq92OEAwhqWKd7FVyegZxD68VsdbHLEZ7bkCoQFXm2OGfH+yogavfO+LgosesyrAc0
 muJBEWRuq3FV1sG1uyX/hoyicEvihEPTF3mIYzA4d3RJzhnkVufB629Ol5pHrEWdKG+M63X6Ayd
 AjcetoS73vHI8MjM4Dv5lHaHjUTTZcUOPUrcpGmUGCNYwyyj7NlXC0u6PATIrl9l7CMQY9D/zQZ
 WDbRwPri5u4MkajzNvLHrsg0L+PUOyWy44mAocnWICzs2nsUqQAxVe5hrJ/8Tpdz0tH8Hatjn8Y
 hQsB2gjVYwhjTy9UHjDf4j/coJPLrVBFNhENN9t7QNDKgF0CMlcNsWeFNihj3r4Rr2cDSu2PSvZ
 4WMCU7ghn9tSWB1qlyhwi6bJL9vl89tI2krytorYTaDQCALh/vdB6stDhuhwrQsKnLJj+8yKIH0
 fDpUdo9K58fzjbxy3DXax683zwKu0ptCDOx6YvzTXbMOVA2TyiqkivEmHauGbDt+zd
X-Received: by 2002:a05:690e:151b:b0:652:fc9b:4a1b with SMTP id
 956f58d0204a3-65e227be43cmr21773326d50.40.1779295663809; 
 Wed, 20 May 2026 09:47:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65e0d89b130sm9586106d50.5.2026.05.20.09.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:47:43 -0700 (PDT)
Date: Wed, 20 May 2026 09:47:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michal Sieron <michal.sieron@nokia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] linux/mem: atomically prefault hugepages in alloc_seg
Message-ID: <20260520094740.209a4a94@phoenix.local>
In-Reply-To: <20260520125756.530808-1-michal.sieron@nokia.com>
References: <20260520125756.530808-1-michal.sieron@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 20 May 2026 14:57:56 +0200
Michal Sieron <michal.sieron@nokia.com> wrote:

> In rare cases, when a secondary process calls rte_eal_init() it can
> cause a data race during page prefaulting in alloc_seg().
>=20
> An atomic compare-exchange in a loop should eliminate the data race.
>=20
> Signed-off-by: Michal Sieron <michal.sieron@nokia.com>
> ---

Build fails. Fix and resubmit.
Looks like you did this against older version of DPDK before stdatomic.

FAILED: [code=3D1] lib/librte_eal.a.p/eal_linux_eal_memalloc.c.o=20
ccache clang -Ilib/librte_eal.a.p -Ilib -I../lib -Ilib/eal/common -I../lib/=
eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/inc=
lude -Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/inclu=
de -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/=
kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metric=
s -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Xcla=
ng -fcolor-diagnostics -fsanitize=3Dundefined -pipe -D_FILE_OFFSET_BITS=3D6=
4 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -include rte_config.h -Wvl=
a -Wcast-qual -Wcomma -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-se=
curity -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-s=
tyle-definition -Wpointer-arith -Wshadow -Wsign-compare -Wstrict-prototypes=
 -Wundef -Wwrite-strings -Wno-missing-field-initializers -D_GNU_SOURCE -fPI=
C -march=3Dcorei7 -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API '-DAB=
I_VERSION=3D"26.2"' -DRTE_EAL_PTHREAD_ATTR_SETAFFINITY_NP -DRTE_LOG_DEFAULT=
_LOGTYPE=3Dlib.eal -DRTE_ANNOTATE_LOCKS -Wthread-safety -MD -MQ lib/librte_=
eal.a.p/eal_linux_eal_memalloc.c.o -MF lib/librte_eal.a.p/eal_linux_eal_mem=
alloc.c.o.d -o lib/librte_eal.a.p/eal_linux_eal_memalloc.c.o -c ../lib/eal/=
linux/eal_memalloc.c
../lib/eal/linux/eal_memalloc.c:605:10: error: implicit declaration of func=
tion 'rte_atomic_compare_exchange_strong' is invalid in C99 [-Werror,-Wimpl=
icit-function-declaration]
        while (!rte_atomic_compare_exchange_strong((volatile int *)addr, &s=
napshot, snapshot))
                ^
../lib/eal/linux/eal_memalloc.c:605:10: note: did you mean '__atomic_compar=
e_exchange_n'?
../lib/eal/include/generic/rte_rwlock.h:189:6: note: '__atomic_compare_exch=
ange_n' declared here
            rte_atomic_compare_exchange_weak_explicit(&rwl->cnt, &x, x + RT=
E_RWLOCK_WRITE,
            ^
../lib/eal/include/rte_stdatomic.h:151:2: note: expanded from macro 'rte_at=
omic_compare_exchange_weak_explicit'
        __atomic_compare_exchange_n(ptr, expected, desired, 1, \
        ^
1 error generated.
