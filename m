Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0656CA1016
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 07:54:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96A5940264;
	Mon,  8 Sep 2025 09:54:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7CFCD400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 09:54:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757318064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MpVDGW0STb+ztd11tCa3bQ99d6JhaJVvjwqEgCdKC4c=;
 b=YpZl2g+vmWHbdeuFjzdrBIJr1/sycza5hsNmVej6J7K1ls1jwsupn+pJhXPxmaCSZU+o9G
 9tqqUWWx3LUZw26yrqCxgZzvcfoJoocFlrKOHx98jSf1wbW4ZjuGVNIca8VZo08QPkpFUW
 i6wUI/CanVbl+H3xgxqUlHqmVKkkfAs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573--cvIzWALM4mG854auqnUwg-1; Mon, 08 Sep 2025 03:54:23 -0400
X-MC-Unique: -cvIzWALM4mG854auqnUwg-1
X-Mimecast-MFC-AGG-ID: -cvIzWALM4mG854auqnUwg_1757318062
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-329745d6960so4188186a91.0
 for <dev@dpdk.org>; Mon, 08 Sep 2025 00:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757318062; x=1757922862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MpVDGW0STb+ztd11tCa3bQ99d6JhaJVvjwqEgCdKC4c=;
 b=VYW0FL2AtodTO9jpj6HsUQxmF+ftQm3VCeZGrWRN9dbXj8OFeuu/Zd0eC39F1Ci3Ok
 I5JS2q2YwcLj2SXI8UpMt7fQ2eJFe97pGZ7TNav5nl/DlfvBqEcFfzA5d9NDVYecRklh
 A3OGIBGeEvcXQyCD9ELf6LyPumheu/rmjtUiYB7WzHv4WsdZMZgYee+pTgwJ7bMjKqct
 zPvScZ7wQEIDiqXNTHG/sVPy8eEkL52v/TMpAC4OX1BzOKwhFIhLCReg+HgAuqT1p5lp
 wye3UXJeMi9ER2JBpu0epZH/IX9c8/qW7m6BTBQpn73oXgcjkG0dlN5KrJZHbT4hQA5v
 7yMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLpD7n4K//DbrH8t8vUgVCZ40BDfWscRz1OEIqfrv7qyQg/JgAREG6Ta9wMn8MNbU8j1g=@dpdk.org
X-Gm-Message-State: AOJu0YwD0TLGeMpIfxP5Zo2IdchwOfaIZcS/eLuPJKIT/FCVKVl1Lhaa
 jVnN39/R9J9AqSyftZQPrwjckxFquKboOyaLJGVo5p+JpMn2XQ3eJwyThZODzd1snHtA+iJnCaP
 dMHETcdpRG/y+mAM8Lu0jnSXNdTM7yFg+tl4Hlz0YRaw7PxpDAtDDDEpPNPZ0qyVXZPIYZmx8Ey
 5ds5FD1GGkMBWAtepuvVE=
X-Gm-Gg: ASbGnct1P7mriBMR9OLRUB7YzGJjw+SmPZMq1UvgcVA+nuIfDBO9qZb9ArLCYqAU3mG
 oFwOS93lrUn4Evtz+dmM6tMxa5eNuZhOI2XnO9dcwUsEpjpCkLwbtQb9HTR1IRcUhlSvz2I61HP
 DQZgtEWAr2KWUOy4BlGJgGPAE=
X-Received: by 2002:a17:90b:1346:b0:32b:cafc:e339 with SMTP id
 98e67ed59e1d1-32d43f92516mr8797837a91.36.1757318062385; 
 Mon, 08 Sep 2025 00:54:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjLItg5TZQ7/N6RJ6XSJ4hbSTJxkcp2jD8D7Aw5vNtBbBuGtGv3dWZST8Dizz/FjX/5KrY9d93+xrPVIAuxWM=
X-Received: by 2002:a17:90b:1346:b0:32b:cafc:e339 with SMTP id
 98e67ed59e1d1-32d43f92516mr8797817a91.36.1757318062089; Mon, 08 Sep 2025
 00:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250828025957.30917-1-fengchengwen@huawei.com>
 <20250903020547.12347-1-fengchengwen@huawei.com>
 <CAJFAV8yTwKR3oBJ-N68je_=aUL5Dg4_h_H8zgB3ZvLzrLbQtNQ@mail.gmail.com>
 <abd687d3-acb9-4692-98a4-73ec03154efe@huawei.com>
In-Reply-To: <abd687d3-acb9-4692-98a4-73ec03154efe@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 8 Sep 2025 09:54:09 +0200
X-Gm-Features: Ac12FXxR18NmIPC5OIn3kJvERwtnbj-ffZAecKWqiExcSY249bQlNQFzTCwBhUA
Message-ID: <CAJFAV8xY-hNK2yYoo7_KD5TAOxgPJt4RkR+kRnHDNh1jYuTHTQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] add semicolon when export any symbol
To: fengchengwen <fengchengwen@huawei.com>
Cc: thomas@monjalon.net, stephen@networkplumber.org, dev@dpdk.org, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ofs4vJ_M7rGNbYmdQf4Mrthc8yLX0eI8iTge2uEZEVU_1757318062
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

Hello,

On Thu, 4 Sept 2025 at 02:24, fengchengwen <fengchengwen@huawei.com> wrote:
> On 9/3/2025 3:04 PM, David Marchand wrote:
> > The current positionning should be seen as an additional info on the
> > return type, in the definition of the symbol.
> > Does it mean that this IDE would fail if we add any kind of
> > macros/attribute involving the symbol name?
>
> I tried vscode and SI (source insight), and found user could use "token macro" in SI
> to make the IDE skip such symbol (so use ctrl+ will quick jump to definition), but
> I can't find such setting for vscode.

I asked someone who is more familiar with vscode than me (though she
is not used to C language).
Out of the box, this IDE could not understand C language, so she
installed the C/C++ extension pack (version 1.3.1, on some Ubuntu).

And it seems the symbols are correctly found with current main branch.
For example, opening only testpmd.c, rte_eal_init() mouse over shows
the header content.
In the same context, ctrl+clicking on rte_eal_init() in testpmd.c
proposes to open lib/eal/linux/eal.c, with the focus on the symbol
itself (and the RTE_EXPORT_SYMBOL macro is skipped).

Are you trying something different?


> >
> > Afaics, ctags can be taught to skip those macros and just behaves
> > correctly by adding in its config file:
> > -DRTE_EXPORT_EXPERIMENTAL_SYMBOL(a)=
> > -DRTE_EXPORT_INTERNAL_SYMBOL(a)=
> > -DRTE_EXPORT_SYMBOL(a)=
>
> How about add note in DPDK document if don't apply this commit?

We can add a generic mention that it might be necessary to configure
the IDE, and give an example for ctags.


-- 
David Marchand

