Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935C8C83F34
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 14:55:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 647E7402E3;
	Tue, 15 Jul 2025 16:55:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 92C344028C
 for <dev@dpdk.org>; Tue, 15 Jul 2025 16:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752591298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6HXoKp6r3SbAJtjlAU5LPzPQ71gfDTCMvN71rT4w3o=;
 b=E/Xd/6QjZd0IgS8aRDa8xmFJllDYxDyznV6UyqXqsN3eShCubKzSdvR6BumUqMdOmtIjjB
 /SX9jfgkrzjN2zgvJ2gMASnxNU4FVg+1GCX41CX5zHWIjB1d+IQduXlVtb2/w9v1tMINWi
 2hqI4neUjwFPMlGNQs/OJxUJdhikpYc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-wvCNxUR9MaCwz6OnL7gQuQ-1; Tue, 15 Jul 2025 10:54:56 -0400
X-MC-Unique: wvCNxUR9MaCwz6OnL7gQuQ-1
X-Mimecast-MFC-AGG-ID: wvCNxUR9MaCwz6OnL7gQuQ_1752591295
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-32b8579063bso28791341fa.2
 for <dev@dpdk.org>; Tue, 15 Jul 2025 07:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752591295; x=1753196095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6HXoKp6r3SbAJtjlAU5LPzPQ71gfDTCMvN71rT4w3o=;
 b=vED8widP3V6iA9LCsRCoDNOfAmcpwhplqiRyx6z1ugjVS9bREQzq/YuTCiQ2xbVn8i
 uCxIjvnXQA0xXkuvzdpiU5N1fOhKCC3AF3txUMVjL6HHakt0vgexVu6joe2j3+DBzNKQ
 9OZWszJwDDS0mqRQvxwzBfdP8Sejb1I4BBA7sEYVzEIETO2zaPVbvmmleKpnE5l19GAw
 BVWbw8xDZDvxHvNTazyh8G4mLy8dHPWqopsux1a+BG924Pj07WWwF8g74uCd8GqX6DqL
 b9A0Rx9ZbrlpTu+ZdWArqlmC1OWkHV2UMUIUcnS7pXe8ZcKpY4iEIL2QYrAsKtrrgVj5
 Ws7g==
X-Gm-Message-State: AOJu0Yy3WvraZmwCfpuzrL++ezxzMeAbPNsofpwdmuk9zko/bl46t7SF
 kSisJ08HWuUcQUTNIFF7dad9JgTHGTsFuoWLfXSALT7MAwDzCexL1rnbaDSA7th2+V9jXE0EnNJ
 Tbunb0LS8+vOysV7NGP2G7mel1GrAXXaNayK77MFSgra3coqrEhSBaCvcN1F9C5L3X5LsvGQK5l
 JXEtLxMqd9WsR3pTl6Fp4=
X-Gm-Gg: ASbGncuGPK5rAYhNJ8HqTHJ5wRvGd9FcztieiWB7H1XJ6AFlQ2/f8sLCO8QGfqQlw7r
 0a/J/tH+ql8w1KzGX/I9gz2byXqbDQF1ZCW+YB6vRBz5XGd57t7Pu+z9sxK/bd6q2pSmGOd+Jqz
 ibfKKMBBsaLRstpT6mzf6WYOg=
X-Received: by 2002:a2e:bc1b:0:b0:32b:3879:ce7f with SMTP id
 38308e7fff4ca-33052f73f81mr51653881fa.0.1752591295191; 
 Tue, 15 Jul 2025 07:54:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6qK6ga9EDL+dbHSzlqZgsLoVPyqTHpCK4GkAL9t4Idr4BhMiid/6cadtiid7UbEyg2THgtiyKadF5J2MrGVM=
X-Received: by 2002:a2e:bc1b:0:b0:32b:3879:ce7f with SMTP id
 38308e7fff4ca-33052f73f81mr51653721fa.0.1752591294642; Tue, 15 Jul 2025
 07:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-9-david.marchand@redhat.com>
 <70c7ba78c4324495bfd317e38e926958@huawei.com>
 <CAJFAV8zAz27vKfA_zry8h6oJYA-kKTpOyzTpt-_PCMTvKmL_WA@mail.gmail.com>
 <ab72d9487cfa40ce94e27f6f067278c6@huawei.com>
 <CAJFAV8xGBHUHD7MEymHJ4yovZUwiTGeZAoGPrZEJNtCvJ=h=Sg@mail.gmail.com>
 <c7850966167843bdb9fdb2b3ff2c335c@huawei.com>
In-Reply-To: <c7850966167843bdb9fdb2b3ff2c335c@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 15 Jul 2025 16:54:43 +0200
X-Gm-Features: Ac12FXxtlE3WQ72oLawTq2xN6COszWKa69RS-ZZlKgeE9EKfx-Lpo6lVybdcPzg
Message-ID: <CAJFAV8xQ32qWPKAzXSvLpfMx3otAes-Uvz2jva6FrEohcoUXFg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] hash: fix unaligned access in predictable RSS
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Yipeng Wang <yipeng1.wang@intel.com>, 
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 John McNamara <john.mcnamara@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IJ7q2CKbnGpOE7bspQ-t8maAqJza-b3nnwM2DQTXSI4_1752591295
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

On Tue, Jul 15, 2025 at 3:33=E2=80=AFPM Konstantin Ananyev
<konstantin.ananyev@huawei.com> wrote:
> > > BTW, would our 'unaligned_uint32_t' type help here?
> >
> > Since most DPDK code rely on aligned types, using an unaligned type
> > can work if we have a function that serves as a conversion from
> > unaligned to aligned types.
> > In this code, since the next operation is a byte swap operation on
> > 32bits, I don't think we have many option but to memcpy().
>
> [] For clarity, I am talking about something like that:
> https://godbolt.org/z/vv6qzPMTz

I did not think just the cast would be enough, but it seems to work,
ok I'll respin.


--=20
David Marchand

