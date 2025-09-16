Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38327CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 08:59:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF680402CD;
	Tue, 16 Sep 2025 10:59:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DD9D34028C
 for <dev@dpdk.org>; Tue, 16 Sep 2025 10:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758013157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0g07RQhAdrl7zacZzQVbdeuw4NzlXSTXEJUrKwzGR08=;
 b=BOcih3eIfnh7+oyGO9Gtc8JUXp3gvakUoAyzAW8QfqjDZPEeBHtAai/cw3LuaW0hRFWM6d
 tuzrqHq5yX0npDNWlJwNj1sybt3JUN/96onWfyDswaYeLYvsrvRDCs6qE1ajpkctSFBCzB
 t6PgTouVwgTTaE7pAV0RrygTPHrvRwU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-QFVEP2GMP-WJNS8xc9j4tQ-1; Tue, 16 Sep 2025 04:59:14 -0400
X-MC-Unique: QFVEP2GMP-WJNS8xc9j4tQ-1
X-Mimecast-MFC-AGG-ID: QFVEP2GMP-WJNS8xc9j4tQ_1758013153
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-56f85820d70so3890227e87.3
 for <dev@dpdk.org>; Tue, 16 Sep 2025 01:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758013153; x=1758617953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0g07RQhAdrl7zacZzQVbdeuw4NzlXSTXEJUrKwzGR08=;
 b=PvpVkF2A1VvBnFRaLx9H5KSm0Rey9nQJaZZJ6QPvrXC7APFwE9pG3W4Hgmp2QsbBIE
 wpJLh+Az9laFlHa8gXKpO8bIZM9Hvq7k764RgoiMvl+AGW5Nh6GlLn1wKUI1NprfbVQm
 MUYbxl9YGlkuDLWcnFfG0/tkUjw8oE6tqdtY1+2w/6Hox4hfJ52MO8LNe1qw5VUm1cNc
 dokSmP0ZH3eNceoHTjbSt82vmRQbnrD4gWdd7eyhKqOgS4caRusjp1OLDvo1OONwl64f
 lQHEUD9MV8k6GjeR7WTIyQdRD+kjXNWJz4VR5eJc8Qw/9u8CSSYwK/Svrupn7fEMO3iq
 Twvw==
X-Gm-Message-State: AOJu0Yxke8WAmQihF8gXF/2Vzygr01pvxGG4q83B2KTBYcj/W5WECbjp
 z55+a7/RuzfHNLhFw895Q0CA+/mbCJrhPly8KFqwj5/Du6FrkRkvc9vfAHBeYUbPgiQu4pq3sji
 BTP+QrHO48IHCOKhGsgHitfOz9kqV0bkSyAG0Ab1unKBLWR1VVHN2WCy8rdGKiJFypjEZY4pT2b
 SCyp9Uh8UkrlsJAdOw010=
X-Gm-Gg: ASbGncvEt7H8eV2BG4pE1XK5FOcAXHf0KvIHrRPudbZy/9qdV231L90qwS+0EvRxxGj
 yvXOsOQQkPYqDlK/mDqyIvHqHMm/FEMQRDB1cFZaxEYTSeu/yxgo7tPrEi/PAzU1UTTID7t4VH9
 m6nPM0F+kur4ULLrMvTZa7C1M=
X-Received: by 2002:a05:6512:3192:b0:55f:701f:933 with SMTP id
 2adb3069b0e04-57050828c63mr4977304e87.41.1758013152577; 
 Tue, 16 Sep 2025 01:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5z2d9jUaO08XZ55YXrdmQEdy3FUz0gLYNKRYVRTAnRKHQS8vj+cVE6MeJchG2Nqnhk8Z4+laHJVGPvbc5AJE=
X-Received: by 2002:a05:6512:3192:b0:55f:701f:933 with SMTP id
 2adb3069b0e04-57050828c63mr4977295e87.41.1758013152143; Tue, 16 Sep 2025
 01:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250908070414.1297844-1-thierry.herbelot@6wind.com>
 <20250909054023.3263401-1-thierry.herbelot@6wind.com>
 <20250909091724.2ea0615e@hermes.local>
 <151c401a-87dc-423c-8bae-89d325dc8c90@6wind.com>
 <20250910090926.204ff85d@hermes.local>
In-Reply-To: <20250910090926.204ff85d@hermes.local>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 16 Sep 2025 10:59:00 +0200
X-Gm-Features: AS18NWCqbhNN6DDVhfys6tJcYtO9UHh1FTZ-rhbgyjn9FSis1FbJfNB_VcKQkwg
Message-ID: <CAJFAV8ytULR3Gr21Y2kUCgOigGJuRiU7DWb7QZLNzWLhsXDVFA@mail.gmail.com>
Subject: Re: [V3] net/qede: reduce the optimization level for gcc > 11
To: Stephen Hemminger <stephen@networkplumber.org>, 
 Thierry Herbelot <thierry.herbelot@6wind.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Devendra Singh Rawat <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, Olivier Matz <olivier.matz@6wind.com>, 
 Edwin Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _5FNGjNA6wctDFwUbtmSrl48mM7hBFGhzfTqQpQZLLI_1758013153
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

On Wed, 10 Sept 2025 at 18:42, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Wed, 10 Sep 2025 08:49:38 +0200
> Thierry Herbelot <thierry.herbelot@6wind.com> wrote:
> > The error chain is:
> >
> > RX-nombufs
> >   => (testpmd) stats.rx_nombuf
> >    => (qede) p_stats->common.no_buff_discards
> >     => (qede/base) HILO_64_REGPAIR(mstats.no_buff_discard)
> >           (internal to the NIC)
> >
>
> Thanks, lets root cause this (rather than paper it over) because

+1

> other drivers may have same issue. Since no mbufs are present
> looks like rx discriptor never made it to NIC

I would add that if the descs do make it to the nic, maybe the (IOVA)
addresses are incorrect.
We changed the default IOVA not so long ago.. so maybe play with
--iova-mode to continue investigations.


-- 
David Marchand

