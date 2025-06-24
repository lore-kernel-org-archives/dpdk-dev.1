Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A0C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 14:17:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 911D740DDB;
	Tue, 24 Jun 2025 16:17:21 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id D94704026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 16:17:19 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4536b8c183cso18183585e9.0
 for <dev@dpdk.org>; Tue, 24 Jun 2025 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750774639; x=1751379439; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7UWWnoQKnmjOfaxE4dApNEGDkgcMXXPajHKY+PJzuQ=;
 b=kXL7Ue7+sAR5dRlhQPj9n4/E5bLY4Gn4Eja3JklL4je5ZjuWEo6cyuctqIFnsjjsDT
 faRBGzdqxMUcLtw3N7fCdV3F/XfAwGtPTtTRogTrUd5bbPvo6Hqt7AGBV+k76gfuCtA4
 S5tboyh3ZcNKObGYJFMFTBukZYQElEUqxtcpVsDUGW7g5UmHMRZbfhiEyxoXKRp9SmZu
 2NyuqJqii7gsJzcy1YKZ6EsSFjQjz7xG3PyR4M950Icgq1kBshXXLPlQNxGN8cdk+lTh
 LjogdGWP65yIyrPUzwezOTHBOq4LBqpl0aAXbzeUmvSrUxGrARO5GPyX450SDnXD7Lzm
 okXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750774639; x=1751379439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7UWWnoQKnmjOfaxE4dApNEGDkgcMXXPajHKY+PJzuQ=;
 b=PoCSG2PSQA5El9qN4a5EvOvQdSde8Yjx4tOjtWRlIdBlNc2nIb6xwMedPC+Vnr9eMo
 /t2CYtuCzeI0c0cCA2mteOJUp6f21yaVLEbpJ37yTDPQWxBV9ccCPeHronAbufeDWx2w
 R6Csub9hZHAiKPs+NXwu/ZFiYn1l86zC/AT2zywCVaNaum93r5JlnwzbedPn/j3RZ2m7
 4uvEEUkC6rzhyigpn7/ohHJLF7tfhwZpautwpkpdMFj9adu3AR0Dm2K/5Q+gZ5zLCBWR
 oRLpoLeP2k6SBt2Q+5gqO9dOcNYReCRE1tFr30PkVLKARnZxBWsb0/PQuJr0r+dyHrGw
 sfyQ==
X-Gm-Message-State: AOJu0YzkXMTkaTxoe88z3cZbCXwH28SvS7kriRRuORgn1e7PwjMWgPo4
 vwPz5EbWZgrJvM581vavZeEbwQxkaX3M+Su2M4ms3A0pMabr6tmP0ciyinMJdmNL+k6EfKycQvE
 dkm4ANguSBwhBx8CwMBbSNNdN9KNv9sLW2LiaUMo=
X-Gm-Gg: ASbGnctt0F2T8xQU/DFzInYERiWsdveome8vL344C9ApCbK3qdHGRnnPAH7G9ph87fG
 1KRz6nzV5NdeNElu/WqYywDTlmY+cUts2Oud9wWEknhaZmA7j/nEykvK7KNGgfF0UQ2wav1N9WQ
 XUMsvkAnt7yuPpSdv75QznOvUo5EJYN6JZj+I2G4Aylg==
X-Google-Smtp-Source: AGHT+IGlMkb63CSHXDSwD/PZdl59kdaFW2QtxoP9vuGpP2lW9kPZ4Pl0J+O/NADQpja9W/gtt5/LtmWC250nzhoK68g=
X-Received: by 2002:a05:600c:620b:b0:43b:c857:e9d7 with SMTP id
 5b1f17b1804b1-4537c362937mr30989765e9.5.1750774638377; Tue, 24 Jun 2025
 07:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250624111253.2074168-1-edvard.fagerholm@gmail.com>
 <aFqtrSmrQJoAv3OM@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aFqtrSmrQJoAv3OM@bricha3-mobl1.ger.corp.intel.com>
From: Edvard Fagerholm <edvard.fagerholm@gmail.com>
Date: Tue, 24 Jun 2025 17:17:07 +0300
X-Gm-Features: Ac12FXxM5xbF3rDgAOXb7eD9IK5cM2zihvahbrw5WPguo3E1d30OfB7xjhDYe3U
Message-ID: <CAMF0iZ61ePVspLyViozgu3oMdv156ffEY57-k=7yWQhLEqL4qg@mail.gmail.com>
Subject: Re: [PATCH] cpp: Fix missing extern "C" closing bracket
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
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

On Tue, Jun 24, 2025 at 4:53=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Jun 24, 2025 at 02:12:53PM +0300, Edvard Fagerholm wrote:
> > RTE_FORCE_INTRINSICS with a C++ compiler causes rte_atomic.h and
> > rte_byteorder.h to emit on x86 an extern "C" without a closing
> > brace.
> > ---
>
> Unfortunately, patch is missing a signoff, so isn't eligible for merge. C=
an
> you please submit a v2 with the appropriate signoff included. See [1] for
> more details.
>
> For the patch itself, it looks ok to me, but really the various #endif an=
d
> #else tags need comments on them to indicate which #ifdef they belong to
> (unless it's a very short ifdef). If you do a v2 would you consider addin=
g
> those comments to help make the code clearer?
>
> With or without that suggestion, you can include my ack on v2.
>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
> Regards,
> /Bruce
>
> [1] https://doc.dpdk.org/guides/contributing/patches.html

Thanks. I'll make another patch with the signoff and add the comments.

Best,
Edvard

>
> >  lib/eal/x86/include/rte_atomic.h    | 4 ++--
> >  lib/eal/x86/include/rte_byteorder.h | 9 +++++----
> >  2 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte=
_atomic.h
> > index c72c47c83e..68629016b4 100644
> > --- a/lib/eal/x86/include/rte_atomic.h
> > +++ b/lib/eal/x86/include/rte_atomic.h
> > @@ -282,10 +282,10 @@ static inline int rte_atomic32_dec_and_test(rte_a=
tomic32_t *v)
> >       return ret !=3D 0;
> >  }
> >
> > -#ifdef __cplusplus
> > -}
> >  #endif
> >
> > +#ifdef __cplusplus
> > +}
> >  #endif
> >
> >  #ifdef RTE_ARCH_I686
> > diff --git a/lib/eal/x86/include/rte_byteorder.h b/lib/eal/x86/include/=
rte_byteorder.h
> > index 5a49ffcd50..62a87c1aa6 100644
> > --- a/lib/eal/x86/include/rte_byteorder.h
> > +++ b/lib/eal/x86/include/rte_byteorder.h
> > @@ -48,10 +48,6 @@ static inline uint32_t rte_arch_bswap32(uint32_t _x)
> >       return x;
> >  }
> >
> > -#ifdef __cplusplus
> > -}
> > -#endif
> > -
> >  #define rte_bswap16(x) ((uint16_t)(__builtin_constant_p(x) ?         \
> >                                  rte_constant_bswap16(x) :            \
> >                                  rte_arch_bswap16(x)))
> > @@ -69,6 +65,11 @@ static inline uint32_t rte_arch_bswap32(uint32_t _x)
> >  #else
> >  #include "rte_byteorder_64.h"
> >  #endif
> > +
> > +#endif
> > +
> > +#ifdef __cplusplus
> > +}
> >  #endif
> >
> >  #define rte_cpu_to_le_16(x) (x)
> > --
> > 2.34.1
> >
