Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E58C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 08:05:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D274402F0;
	Wed, 19 Feb 2025 09:05:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5BA58402D6
 for <dev@dpdk.org>; Wed, 19 Feb 2025 09:05:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739952318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXU6+O1nJysZLu1Lpa7EuSXC5JyH6C60X9oZ7CntqG4=;
 b=cSIawmJQHVTOO5hSXijVjhKt6Hev+EnHn+yNr4106Cr9MMCQHtcNl/PJ0wAAazKztMMCE4
 baRQYw94JHOxXhxSVxXr6KsesqFbGy8hphTT9zEVkTCqoynn5XAJSrl238b/WmbYQcHbzG
 JENKHvr+pwD1hC67w8ztn9dmasStYnc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-Y1uzMFi4M6O-s4Z43EFzgQ-1; Wed, 19 Feb 2025 03:05:17 -0500
X-MC-Unique: Y1uzMFi4M6O-s4Z43EFzgQ-1
X-Mimecast-MFC-AGG-ID: Y1uzMFi4M6O-s4Z43EFzgQ_1739952316
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-54525663c73so2971386e87.0
 for <dev@dpdk.org>; Wed, 19 Feb 2025 00:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739952316; x=1740557116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXU6+O1nJysZLu1Lpa7EuSXC5JyH6C60X9oZ7CntqG4=;
 b=sm0W+Ba68Q+uWS5HVj1bFHZuc1uZQEsyTXAFFLOfLaVG1dCj/NjjQ+9IlOPctxjW0b
 yBtByXELAzA5t+5M+qpbe+FGE9zB6DW9H1Jnp37wCOEwgwN/7C5mj20w2wfmOjGGFbxM
 PcLnroli5TyfILEVqCo/4CGnDOAtyNK60p2elyJ8x+ZEbR/ww/+cGMqZno12CGs88fdm
 AB1TCl4JeVcuABbDSVS5rvr/4RwfsoMVolkJSkry8YxLtjsAu099R1SdmFtplYZ6SkG/
 +auDDY1yZG1R6C+YhkRTiENpt3flVGTihoSUrBBbLuXd0OZRIjYu/s/NfEw/+0G2EUG3
 UtrA==
X-Gm-Message-State: AOJu0YwsFafW+5mbiMgsY1hLB2T01sqHpAIvmHD7QQYGId6pvXZ2ms8x
 InRNLqRGdNG6DVChKpFABNkbWP6Cko6rp2L8NVHNqQkOe3fL9RI8hYOKTB6P2NNEcwyzu6PJXFQ
 aGGtriYsASJnRUFM6CQFc4l23bzcV4qXZMXgbtmY7irI7Qs8QEGqzfQZVitZgR82vs1ZraSOLRU
 /8b/gXDVRHWQsNiVM=
X-Gm-Gg: ASbGncugkKQig4lDyZzx6Cpep7I1SJQNaXcxjAUZY/owSYh2PBil07q7QQZX0ktpAgH
 Y8+B/pL9he/96glti62pAQQ/PQO+Z5gdDUIj9FmZov/qLhUUpoSm5/lsonG8XOr3v
X-Received: by 2002:a05:6512:3e2a:b0:545:e2e:8443 with SMTP id
 2adb3069b0e04-5462ef1c5femr1254991e87.32.1739952316079; 
 Wed, 19 Feb 2025 00:05:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHetdAaCqL5pfiQXkwVN14l+ZFnfUtqbqrOibURSmr3ya0iOGAIHKRvhnscHPGf9xTKI3YbODakk91M4uYrodA=
X-Received: by 2002:a05:6512:3e2a:b0:545:e2e:8443 with SMTP id
 2adb3069b0e04-5462ef1c5femr1254971e87.32.1739952315685; Wed, 19 Feb 2025
 00:05:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
 <4fef69922f2220f57ea32cb4a31e015622590237.1739877266.git.anatoly.burakov@intel.com>
In-Reply-To: <4fef69922f2220f57ea32cb4a31e015622590237.1739877266.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Feb 2025 09:05:03 +0100
X-Gm-Features: AWEUYZnB-b_u7j1JexzrYIQLwhG_i9GmoKoemuRBnHZGFv-_G9oceXGsGDI4DY8
Message-ID: <CAJFAV8xGGW9bTvBXKA9Q90etQv97sW29hVC=ptkGPY2EUVMEJw@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] app: reduce app dependencies
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>, 
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Brian Dooley <brian.dooley@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Akhil Goyal <gakhil@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7ik6PrbLs9Ub3gYZgxni4EnsCR2oiTjDSharRk46gqQ_1739952316
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

Hello,

Cc: Akhil.

On Tue, Feb 18, 2025 at 12:16=E2=80=AFPM Anatoly Burakov
<anatoly.burakov@intel.com> wrote:
> diff --git a/app/test-crypto-perf/meson.build b/app/test-crypto-perf/meso=
n.build
> index fb48d9ec29..f056431bf4 100644
> --- a/app/test-crypto-perf/meson.build
> +++ b/app/test-crypto-perf/meson.build
> @@ -19,7 +19,7 @@ sources =3D files(
>          'cperf_test_verify.c',
>          'main.c',
>  )
> -deps +=3D ['cryptodev', 'net', 'security']
> +deps +=3D ['cryptodev']
>  optional_deps +=3D 'crypto_scheduler'
>
>  cflags +=3D no_wvla_cflag

- This app does seem to rely on lib/net.

[989/1266] Compiling C object
app/dpdk-test-crypto-perf.p/test-crypto-perf_cperf_ops.c.o
FAILED: app/dpdk-test-crypto-perf.p/test-crypto-perf_cperf_ops.c.o
ccache aarch64-linux-gnu-gcc -Iapp/dpdk-test-crypto-perf.p -Iapp
-I../app -Ilib/cryptodev -I../lib/cryptodev -Ilib/mbuf -I../lib/mbuf
-Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -I. -I..
-Iconfig -I../config -Ilib/eal/include -I../lib/eal/include
-Ilib/eal/linux/include -I../lib/eal/linux/include
-Ilib/eal/arm/include -I../lib/eal/arm/include -I../kernel/linux
-Ilib/eal/common -I../lib/eal/common -Ilib/eal -I../lib/eal
-Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics
-I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/rcu
-I../lib/rcu -fdiagnostics-color=3Dalways -pipe -D_FILE_OFFSET_BITS=3D64
-Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O3 -include rte_config.h
-Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral
-Wformat-security -Wmissing-declarations -Wmissing-prototypes
-Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compare
-Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned
-Wno-missing-field-initializers -D_GNU_SOURCE -mcpu=3Dcortex-a72
-DALLOW_EXPERIMENTAL_API -Wno-vla -MD -MQ
app/dpdk-test-crypto-perf.p/test-crypto-perf_cperf_ops.c.o -MF
app/dpdk-test-crypto-perf.p/test-crypto-perf_cperf_ops.c.o.d -o
app/dpdk-test-crypto-perf.p/test-crypto-perf_cperf_ops.c.o -c
../app/test-crypto-perf/cperf_ops.c
../app/test-crypto-perf/cperf_ops.c:6:10: fatal error: rte_ether.h: No
such file or directory
    6 | #include <rte_ether.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
ninja: build stopped: subcommand failed.


- Btw, rte_security.h is included in app/test-crypto-perf/cperf_ops.c.
However, given there is a #ifdef, I suspect the intention was to have
lib/security as an optional dep.


--=20
David Marchand

