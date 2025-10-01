Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B8ACCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 08:43:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B73640BA5;
	Wed,  1 Oct 2025 10:43:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2829B406BB
 for <dev@dpdk.org>; Wed,  1 Oct 2025 10:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759308204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pgIjqoRsM8k5nu6h1Wqfj5RyG0tU+SDVGW3liE0IcS4=;
 b=UFqMJCQYhOJ6h8MMKNnrfMPJ7tFkRPpHxHVEaXHlCQkKAnClwFsqKuUH6XWiZr6q7va17e
 8udHHiQT9iTCT20mTesfP/siIfhxLN9IK2WgINfDovx2FatiSWa3nTGwYRU0j/eLHQV0F3
 G+Kdx+VpVVIsJE9awyGgsZucfe357Tg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-lBD6gC4xN_y_ifyivviRfA-1; Wed, 01 Oct 2025 04:43:23 -0400
X-MC-Unique: lBD6gC4xN_y_ifyivviRfA-1
X-Mimecast-MFC-AGG-ID: lBD6gC4xN_y_ifyivviRfA_1759308202
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-333f8ddf072so37911191fa.0
 for <dev@dpdk.org>; Wed, 01 Oct 2025 01:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759308202; x=1759913002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pgIjqoRsM8k5nu6h1Wqfj5RyG0tU+SDVGW3liE0IcS4=;
 b=ZopSydn0EDzsMtcXYXweuOqsiHe4BCA5N9gYa5ZxPIzBckXmj0TyRmowSZo1o7UnAM
 A+HMZtpscYQSnXxPjCClYNO9cxcEwDwR62j1C9Jaq275bUqqSltC845RnWK/wKHH9UOM
 4XrQd3dd9RcUyDY+bAwvoyDg6idO3NUjTqb6LuiguveDJuSnprt9woTG3erKxm0qzbht
 8lFW3G544Zxh93Ya1L7rK9MKWbEBmkxif5IguNo8FwQgYGtOKM08RnEp9ImBHNNFk8zW
 3xroHlNnfAswEwFIeEXT9+OUsvZL3ei/GJcMmx9whTrCXUdlVZZJtWP3aeKQc5ch/hlc
 tjEg==
X-Gm-Message-State: AOJu0YyB1oPqbx2k2NQShXe06YCltCezM5RKPcvL2absyuZpUGVoUzmE
 qq2d3CC7NITAKiHBRJ+y6p97SmQ+2nxzxdQDMT9tVrALnLSJ/9PaX96tCBBirdgRt0VA4D0AN9J
 oEkqHqEhl0GxriJ+kUSF9pe0bTu6aaNR4b5+EKUJXVmgvVmrCQxJDY7rF41N8jr0bLpp3tKDPEB
 +rG0uLhSv6vBUyelMfvqE=
X-Gm-Gg: ASbGncvgsSC/WLubTffXKiapD8KGUg8eHQb1lp/ChEKTQrjhwvqMb+M0St2fbYH6j4q
 sm8fRfw7kciBJ6vCq9LXDlAlnrihR3lDYp/DC556AO12Y6FQVWEn0uJcaiIkG5MnANdnLWumUGt
 cEVF9dVQwZB0Lv4b+d048WLw7Ia38Q
X-Received: by 2002:a2e:a817:0:b0:371:fb14:39bb with SMTP id
 38308e7fff4ca-373a710b419mr7431441fa.16.1759308201715; 
 Wed, 01 Oct 2025 01:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH60Lc2Yp/n7GtEyrG9tARn2fDnmuLgnS2pNr5TMtaz+otH85t6XorS/t0lYY68ArpBJxpV5wsRGJlHbS5bgiA=
X-Received: by 2002:a2e:a817:0:b0:371:fb14:39bb with SMTP id
 38308e7fff4ca-373a710b419mr7431321fa.16.1759308201278; Wed, 01 Oct 2025
 01:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250916093550.1345901-1-maxime.coquelin@redhat.com>
 <20250916093550.1345901-3-maxime.coquelin@redhat.com>
In-Reply-To: <20250916093550.1345901-3-maxime.coquelin@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 1 Oct 2025 10:43:07 +0200
X-Gm-Features: AS18NWDyl_YDXJQ_dugERj-ZeoypjHvT5iEJi5MUTpG_a-o8AMaUBsE1Zdwkpoc
Message-ID: <CAJFAV8wNmHDs45nh6bnt9ELJAKDKJ=Y895u9Myy3EKWyTMnE1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vhost: fix uninitialized VQ info in VDUSE vring
 setup
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, chenbox@nvidia.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6Pf_3IMIflvLiuULPqxQ7HWCjYnQMVWtwwPPMb2uJkM_1759308202
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

On Tue, 16 Sept 2025 at 11:36, Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Initialize vduse_vq_info structure to zero to avoid using
> uninitialized memory when setting up VDUSE virtual rings.
> This ensures all fields start with known values.
>
> Fixes: a9120db8b98b ("vhost: add VDUSE device startup")
> Cc: stable@dpdk.org
>
> Reported-by: David Marchand <david.marchand@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

There may be similar issues for ioctl != VDUSE_VQ_GET_INFO.
But this patch itself lgtm.

Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

