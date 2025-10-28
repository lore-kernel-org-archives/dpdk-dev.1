Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E90CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 12:56:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B1044060A;
	Tue, 28 Oct 2025 13:56:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 922054021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 13:56:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761656195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkkMQG/+jw1tt//AIG1hok+V1jxJNM3Vdk149zsBCGk=;
 b=Vfl6JtQwozRzA9N5NlQkDHdj/BIrfD9wodgIOrU0UbRe0+C6ZugPIk8E/5dTOZHFKGTo3M
 ZlfOc5OD7i+Y6o5sTt6MFB+y5/yCsmG7jPeHf5sQElQNBGih0dT3mMl1cD5J1ZLE1iz/gC
 ot6mVeAqYPMEVOcEHW1WGF113gr6pak=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-yFFNBUoXP9eZ12L5TrxXGw-1; Tue, 28 Oct 2025 08:56:34 -0400
X-MC-Unique: yFFNBUoXP9eZ12L5TrxXGw-1
X-Mimecast-MFC-AGG-ID: yFFNBUoXP9eZ12L5TrxXGw_1761656191
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-378d710cb33so26917001fa.3
 for <dev@dpdk.org>; Tue, 28 Oct 2025 05:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761656191; x=1762260991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkkMQG/+jw1tt//AIG1hok+V1jxJNM3Vdk149zsBCGk=;
 b=NrlsBogIgK1i2KJBIZTqCH0C+A7yV5bn+Gn6JdB6dF9UVBgznHQSUFNF/knoYAxOWP
 MfoqHHPPsnmylh539pZwA86626Komo8JUDG+EYZbINmw94CRCTg+Ndp3qeVqVAntGYzc
 rg8rvd9E5ceyE7c9CQpkmAXakg++mOolmyjIoeF2+Zv7NWKIECSR69detCG+VXB6pRFM
 /9azvIGDPFX0vLiT4NtGzyzxW7N44b4fRClP8aY9AohZU6je0MPv2/plPhgES3ZFXm1j
 0tCmloqDn4qJU9zmnAOxKZmqEdL8dVSc//woXoFz63iAiOBPN1c1aF4hOoG4s6Oe0njS
 ZX8w==
X-Gm-Message-State: AOJu0YxJsHP2jmJa7Dxi2GxOL2swJx85ZsFx/+gePrYrivTBmd1lIxo7
 UY6Vkf5cXDKdde9aBG4BHyNMZmEJCuzvat6BrPL70ce9t3dGiVrvApKaaiZb0aNEql9yhwheAYc
 yqfg73kUr3g1+O614o3VhUlceXjrDL1kE6Pun7hQwOHhc2yjhbaufy+WdLpkwImxyeCs0oZ7OeN
 Ql32PUKLwhgoowsgbAJQo=
X-Gm-Gg: ASbGncu1yML6LdK+KSsxWSRW8dubmag/QHEOCCPmAxxzo6DCdxlD/AqKHaGC8Wukb1Z
 /7P4b6Vqm1gCu9vD30F9/lAWrov6yIIqmCgCY1tbCWyhC6EzglI9lP3utEWdkRow2rmatw47xrr
 xtG6nbbr2sNEfSYSTb3SqiyhAtP+9P2J8VSPlmYpRGy0cio3fq5AIh3A==
X-Received: by 2002:a05:651c:3543:10b0:36b:b0eb:9d64 with SMTP id
 38308e7fff4ca-3790773c7a6mr9004201fa.30.1761656191313; 
 Tue, 28 Oct 2025 05:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG27qzf2ZoLthZ/5HFH+pPK5nFyMCVKZiLRPSeMkEYKEkQ9J1ydKnS3OT/ZvxDjcjymWr6xkRO9QsUagHVURPg=
X-Received: by 2002:a05:651c:3543:10b0:36b:b0eb:9d64 with SMTP id
 38308e7fff4ca-3790773c7a6mr9004051fa.30.1761656190870; Tue, 28 Oct 2025
 05:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20251028123453.4127525-1-david.marchand@redhat.com>
In-Reply-To: <20251028123453.4127525-1-david.marchand@redhat.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Tue, 28 Oct 2025 13:56:20 +0100
X-Gm-Features: AWmQ_bkXgPnYIj0DtlY3RVEIndDwmyWvNUMuhQDzlQF_syN8KMQ_y5uiVBku8Mo
Message-ID: <CAO55csz6nhyG3kuBYMpWC5VnF8x0SrG5xmKsDtkowOGtocG+rQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix external buffer in VDUSE
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, jmeng@redhat.com, stable@dpdk.org, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WSd0tPcCuKKVNZyWdeadzLnAgtZbTk-KP0FTHJ2pSXw_1761656191
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

On Tue, Oct 28, 2025 at 1:35=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> extbuf and linearbuf features are required for (enhanced) TSO support
> in OVS.
>
> VDUSE ports were generating multi-segments mbufs in case of "TSO"
> buffers which resulted in OVS generating wrong packets after tunnel
> encapsulation.
>
> Enable the missing datapath features.
>
> Fixes: 0adb8eccc6a6 ("vhost: add VDUSE device creation and destruction")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/vhost/socket.c | 3 ++-
>  lib/vhost/vduse.c  | 8 +++++++-
>  lib/vhost/vduse.h  | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
>

Thanks for working on this!

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Maxime

