Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D69FC531C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 06:33:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 164154028A;
	Thu, 23 Jul 2026 08:33:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E66824027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 08:33:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784788401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=frQTnYH/56y9IfjWAmgPad981RVZTpyCFa6WzrQ6xrk=;
 b=OwWH9U/1+CJKDToXQi+aNI+CgNFC/m6lEBcIduNgYzP6xo+TYRSJKfu7MZ0wyrgkHfT01P
 5ewo1gxCA3+Ll++/sW6nPCBj74fYMsWfuAciAubhd9i8PrTpz+Am9WdZTeOqcM9smEFuRB
 WNwNpWJBpxjsFgjzfu+bUNioL298biM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-LEAprL2WPbu30MwxolhiYg-1; Thu, 23 Jul 2026 02:33:19 -0400
X-MC-Unique: LEAprL2WPbu30MwxolhiYg-1
X-Mimecast-MFC-AGG-ID: LEAprL2WPbu30MwxolhiYg_1784788398
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aeba93926fso190917e87.1
 for <dev@dpdk.org>; Wed, 22 Jul 2026 23:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784788398; x=1785393198;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=frQTnYH/56y9IfjWAmgPad981RVZTpyCFa6WzrQ6xrk=;
 b=UJnp5qhqSRp3hWf7RSTuWFqgS2Rw4Bpp+lqjH93nKjnHMZGAaq5KrC0ZrC0oT7BY2k
 UXhuHU/peK4KEWF8tjN6r0+1x1rTvIG2poHQU6vty6IxyZHgTqldTezPbrZ0zJOOKckY
 KfjTFWXX+rbXINCMYQdU6Sl01Cx02yCnIkw+9wjnP3oNJdFufAYiZ5u3ILD+rbPk2vOo
 r+viKLYuAzZ1ornpb/4TW7754avwKFLdiwsaEyCCFCi1Nf2yyZhQTv3Q5JY+dEO1TDmP
 zLBlsvOkBuFNuvP36GwG/8qWGcS9rY1wqnBO+z8slRoWBHa6jdeJu09tH3ADn7ba6MOK
 2+sw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoP7zD9uHydwKGqRhkWCc3b7wxytOi37e4Luo+82w1Q++xCpneHsBWftUYb7W2M6RXYSeE=@dpdk.org
X-Gm-Message-State: AOJu0YyrMsQfXyKbdP+xLhl2cIKjW2dUxNBNLVqyCXodjhWGbCOmCuik
 vSQvNF3nYtWbQTbxK8MbBkNxU9IRAWtww6BSTbu7ZdUxxSky7kshCvH7R7L2gwS7CdPDvS+jZ2A
 fJeIqbe9dRlrpaM9UutpF2QmAXUb5H4dZxdp0ASpbR8er17ZGKtRm6FPAaOxe6LPMLPQw1e+xDY
 YRpHXyD+vFZGbFbKuPhfU=
X-Gm-Gg: AR+sD10HG+UZIyqc9fqkKTlhuvSyCTO4mkkGY2e7u4UWN+RUKTBuQu+hLGBAGqnnHQo
 bikZ+slsBYcvHTVHGpTqkar22gzWVpn1cHmM+fCC3F1aQGur9Pa4Qhss+Y1XKECb6mbIHfbWs7s
 ZC9plJfeXVyLKTITu2DPBDJabmCIiWGK3rQ0iPLrwp57acncy165Y9YkNlfSrLNrx0XZ3Lhgy0q
 R8Rbx/Zo8nVa2ObMbGooTlP5mwAngd1LuGTcleI+JHXYLOV
X-Received: by 2002:a05:6512:31cf:b0:5b0:12e1:486c with SMTP id
 2adb3069b0e04-5b2b2f66cc5mr325984e87.24.1784788398266; 
 Wed, 22 Jul 2026 23:33:18 -0700 (PDT)
X-Received: by 2002:a05:6512:31cf:b0:5b0:12e1:486c with SMTP id
 2adb3069b0e04-5b2b2f66cc5mr325969e87.24.1784788397763; Wed, 22 Jul 2026
 23:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260707135044.7488-1-avanda@ptsecurity.com>
 <20260722160811.190a7b44@phoenix.local>
In-Reply-To: <20260722160811.190a7b44@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 23 Jul 2026 08:33:06 +0200
X-Gm-Features: AUfX_mzBqQ9NinW9b3JsSaF9jmVvlXrUomJWRo_fFMx-CD2csqOjKvvLwWuxmgE
Message-ID: <CAJFAV8wS3qg3TZcFb7=kbEP918pzWw-x2bMjv7mbDCK5Lnz47Q@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix null dereference in async packed dequeue
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Anton Vanda <avanda@ptsecurity.com>, Thomas Monjalon <thomas@monjalon.net>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Yuan Wang <yuanx.wang@intel.com>, Cheng Jiang <honest.jiang@foxmail.com>,
 dev@dpdk.org, stable@dpdk.org, cheng1.jiang@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hQ3IuG1mZOqqFt93b6yK6VeoSFOFjk4Sfd10bBZDItk_1784788398
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

On Thu, 23 Jul 2026 at 01:08, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 7 Jul 2026 16:50:44 +0300
> Anton Vanda <avanda@ptsecurity.com> wrote:
>
> > In the batch path of the asynchronous packed ring dequeue, the address
> > of the virtio net header is obtained from vhost_iova_to_vva(), which
> > returns 0 when a guest-provided descriptor address cannot be fully
> > translated.  The batch check only validates that the descriptor address
> > is non-zero and that the length is consistent. A malicious or buggy
> > guest could therefore trigger a NULL pointer dereference and crash the
> > vhost application (denial of service).
> >
> > Check the translation result and leave the batch fast path with an error
> > on failure, so the single-packet path handles the invalid descriptor, as
> > is already done for the non-batch async dequeue path.
> >
> > Perform the header translation before the DMA iovec setup so that the
> > early return cannot leave the async iterator state partially updated.
> >
> > Fixes: c2fa52bf1e5d ("vhost: add batch dequeue in async vhost packed ring")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Anton Vanda <avanda@ptsecurity.com>
> > ---
>
> Since vhost is so security sensitive asked for more detailed AI review (Claude Fable).
> It found some issues that need addressing before merge.

vhost async is unmaintained, and I don't know a user of it.
I would rather drop it and reduce vhost library attack surface.

I have this idea in the back of my mind for quite some time... I'll
post a RFC for removal.


-- 
David Marchand

