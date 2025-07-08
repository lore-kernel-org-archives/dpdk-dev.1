Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4FC83F0F
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 07:32:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D1CF40608;
	Tue,  8 Jul 2025 09:32:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3AD624028C
 for <dev@dpdk.org>; Tue,  8 Jul 2025 09:32:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751959952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YykXMCxVy63e50qjcVEfOVtZWSrAWYdDvP5lXjyAVw4=;
 b=TqPHNZzkj5fgjmplLSlLECZwD+qWIFqBzG2ytEPFW6i3u3Rg6kERUnIEztLQ+lCeu24UF5
 bUcLfK5Di0PmtW+6nb4Q/WqtRinpPMTrOl1Cv2vxi/7XxNLuiy1KpkXsbGwdGGfqwsCvcX
 x6gTh3Uoa4VTQhWDgKPaNxJyLTK4Z5I=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-Go9ZnKc0PomQxxOE8q1H4Q-1; Tue, 08 Jul 2025 03:32:31 -0400
X-MC-Unique: Go9ZnKc0PomQxxOE8q1H4Q-1
X-Mimecast-MFC-AGG-ID: Go9ZnKc0PomQxxOE8q1H4Q_1751959950
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-32b43616ba0so17389761fa.0
 for <dev@dpdk.org>; Tue, 08 Jul 2025 00:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751959950; x=1752564750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YykXMCxVy63e50qjcVEfOVtZWSrAWYdDvP5lXjyAVw4=;
 b=tWZMP0TsBP6PJCY8MhpiNEqJnhU9NGtpwVZiqq6fipkIP5fDozRo0SMaACOjNJGKNA
 F7Y0K09DRQlzahSoPklUNbkXwpPojH4lzY3dqp60vm5TAQI3/dfq43SdMNrwr50ovi8v
 iU3wdnj+OXAnfJodcD4pKK2euQcHjCyrXtmjVv8/g2xG58ldJoGo/lSX52scfmrei7LR
 M62bcLGv3AHe6y899fqfbNBPXVOISj3LtEDBeJX9eAUR1/CcSYsL8qEnbmbfSa0PsPE2
 782R9U8fFNdR1+eQjvZKRxxj/4e276wdYvkpLTEblE6DGmdY8c/e+sssQc1atp37OFs5
 1e3w==
X-Gm-Message-State: AOJu0YzenezOU3M1xiy3IsTQ7NAQKKojIykacSel3/vIKxguesHgBuY/
 WvcnKLfCZUrtpYMyG96LGoq1Ug5xcrOvKKgx/GLVcE19fp631kxFGCYj20LF6kf5n0MBktZTRAQ
 VniYVBS/cPdthaAUIWkhgfwDLHznX90s4xcuNWLp39is/LTjXapz8rxZRNOSrj0Q8lQ9qUd8fvX
 TkIoMq4GT+u7YFWmoOZ3o=
X-Gm-Gg: ASbGncsuLo3pupPbhyF21sDRlnZFyg1U8QZ2wEEYbVW9EbdhZu0wdj6vOwwMQJ35gdJ
 LwqVGusHU7Bkwljz99m88CxIpkWMVWHTKMFgsK0S2fCQXtBvxLL0gcBSiVP1YgzxaQ08l89Bqrg
 /A8+EeOw==
X-Received: by 2002:a2e:be83:0:b0:32b:7ddd:2758 with SMTP id
 38308e7fff4ca-32f39b9fc91mr4977611fa.0.1751959950005; 
 Tue, 08 Jul 2025 00:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyv9nz9uHnefPDFKFlNFNI/03PABrzGzm61MBjtutxLS5aZusoLW6OEc/RInOgMnNCaWb3f6DJSDcVZWOForc=
X-Received: by 2002:a2e:be83:0:b0:32b:7ddd:2758 with SMTP id
 38308e7fff4ca-32f39b9fc91mr4977171fa.0.1751959948848; Tue, 08 Jul 2025
 00:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-9-david.marchand@redhat.com>
 <70c7ba78c4324495bfd317e38e926958@huawei.com>
In-Reply-To: <70c7ba78c4324495bfd317e38e926958@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 8 Jul 2025 09:32:15 +0200
X-Gm-Features: Ac12FXyKV9zq-jHP7ouTZMIluAPDbth9lnKi6TRCsnRLHJgabuQn7rAGzlpGjDs
Message-ID: <CAJFAV8zAz27vKfA_zry8h6oJYA-kKTpOyzTpt-_PCMTvKmL_WA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Yipeng Wang <yipeng1.wang@intel.com>, 
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 John McNamara <john.mcnamara@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KdmTFYEgfIUr1zBsAP7LHvbkIP30QNBkEwYJnR4C4dc_1751959950
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

On Tue, Jul 1, 2025 at 10:36=E2=80=AFAM Konstantin Ananyev
<konstantin.ananyev@huawei.com> wrote:
> > Caught by UBSan:
> >
> > ../lib/hash/rte_thash.c:421:8: runtime error: load of misaligned addres=
s
> >       0x0001816c2da3 for type 'uint32_t' (aka 'unsigned int'),
> >       which requires 4 byte alignment
> >
> > Fixes: 28ebff11c2dc ("hash: add predictable RSS")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  lib/hash/rte_thash.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
> > index 6c662bf14f..6d4dbea6d7 100644
> > --- a/lib/hash/rte_thash.c
> > +++ b/lib/hash/rte_thash.c
> > @@ -415,10 +415,10 @@ generate_subkey(struct rte_thash_ctx *ctx, struct=
 thash_lfsr *lfsr,
> >  static inline uint32_t
> >  get_subvalue(struct rte_thash_ctx *ctx, uint32_t offset)
> >  {
> > -     uint32_t *tmp, val;
> > +     uint32_t tmp, val;
> >
> > -     tmp =3D (uint32_t *)(&ctx->hash_key[offset >> 3]);
> > -     val =3D rte_be_to_cpu_32(*tmp);
> > +     memcpy(&tmp, &ctx->hash_key[offset >> 3], sizeof(tmp));
> > +     val =3D rte_be_to_cpu_32(tmp);
>
> Just wonder do you guys consider it as a real one?
> AFAIK, all architectures that we care about do support unaligned load for=
 32-bit integers.

Well this is undefined behavior, regardless of what the architecture suppor=
t.
And the compiler may end up generating wrong code.

I could revisit this change with the aliasing trick (used for rte_memcpy).


--=20
David Marchand

