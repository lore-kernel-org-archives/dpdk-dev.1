Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE63CAC583
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 14:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15FDB40281;
	Tue,  9 Sep 2025 16:57:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 12CBF4026D
 for <dev@dpdk.org>; Tue,  9 Sep 2025 16:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757429818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZjIxeF9Dw+Gg8WXbI9E+Pkv7SLz3xSZhWiq7sPdwAEo=;
 b=AAfyrYiO5V3k7j5rmOFzK3hCLp5qzQfXkK4jNtLXmif4oxjJPKA4NqYi1jOakfw8Nb0lna
 udn84eTmancAtqohIinp46MX/f4vG2xQUMkSlQJrZdR8hZNjkCJ22HXbzADIIHARaVct5G
 VjaDFBuBHimmZ+oGTgGB3ySpyxNSVns=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-o4ypC6a9M6eGIfPz4tizWw-1; Tue, 09 Sep 2025 10:56:57 -0400
X-MC-Unique: o4ypC6a9M6eGIfPz4tizWw-1
X-Mimecast-MFC-AGG-ID: o4ypC6a9M6eGIfPz4tizWw_1757429816
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-336e1c46feeso27281621fa.3
 for <dev@dpdk.org>; Tue, 09 Sep 2025 07:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757429815; x=1758034615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZjIxeF9Dw+Gg8WXbI9E+Pkv7SLz3xSZhWiq7sPdwAEo=;
 b=I0Wr9KLavcE22ULyezoCCXOkY6yTueXdDcYZU/XDJuV4hePJK6rtgs5I6jnUnaDnLt
 eyylPCWuLxHYOYGw/pPL4kvk4MwirdQkXe4CJ12DbtgyNSDDtScFIq7SZNn4WTIjjiyT
 82ff97UD4N7rfJbkpy0vPzOPLZvnndvkDSMRCK+COEMDHharQKNs4yghfy/jWUnuqKhQ
 5s/2YXpYXdhcDGzQWEKCdgA/SMlWpM+fvwc5wNibuGOawixpt9HIGTknRAqMXyhc/vX9
 YzAidxu3hVws7SYvBEiFWqCIuh3FlV/AOcuqdaXahR4ndzh0cJxoM/f32odWhGeRSzia
 I2dA==
X-Gm-Message-State: AOJu0YyYerCzmNHoGsKY0vVCzmAUY40p0uZtH9YKbBJjJY6Ms93ntGYS
 +sefdQYv6xI2ps/UMGdaziLxAicF/IPtA69NEmr0mB4j41wmbhmHv/LybxxuHQp4/hYnmvya/KH
 df+lrhZkQ8nhUwQ+7+/VF0xkjqnl0RAF+BzSpSWmJW+AVmCJN33RyUSGkEW4/RvNsXKo9/2XQuU
 1kwmTW6yWqC89P7nCo7ys=
X-Gm-Gg: ASbGncsEBG1SrEkf7JEMUACMTg5Rr5z8FXbFECI1CVyssytd0OiSdcd26viaj9yWSx8
 7oIpmQd8zaXSEqn+iaK8LTmaseuTwWgSyy3UjgGjKXnoobQK4HM2ICgl29jkORSBxJWIZUn7P+Y
 9R69WqFVY91m/vF5XE73v1II0=
X-Received: by 2002:a05:651c:418c:b0:336:e46c:5eea with SMTP id
 38308e7fff4ca-33b5621084emr27320421fa.31.1757429815498; 
 Tue, 09 Sep 2025 07:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr86U2Q7Sypw2f9pR4jal4SfVH0Y2FUXmKdcLpAo7An4NveJPxQiDkUa5/ZRn6bcZsOIn2DLACBn4dHN6HmdM=
X-Received: by 2002:a05:651c:418c:b0:336:e46c:5eea with SMTP id
 38308e7fff4ca-33b5621084emr27320251fa.31.1757429814629; Tue, 09 Sep 2025
 07:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1756133896-9216-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1756133896-9216-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 9 Sep 2025 16:56:41 +0200
X-Gm-Features: Ac12FXyUA5_ld3ShLmrmN8GdR0IJG2p5Sj8IyVeVYygQWgGkZsZJMs2DGAu6YX4
Message-ID: <CAJFAV8wai43o0nd2AEcZTKhykqpN4=EH4J2Rno2W=ijQn_wGbQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 0/3] enable drivers to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3emEAS_XOyJYCrSK83j1cbEH1F4IK270YaXOMsqI_nw_1757429816
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

On Mon, 25 Aug 2025 at 16:58, Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> This patchset solves the last issues preventing drivers from being
> compiled with MSVC and enables drivers to be built with it.
>
> v5:
> - Remove unnecessary parentheses from macros
>
> v4:
> - Add explicit casts to avoid warnings in mlx5 driver
> (https://bugs.dpdk.org/show_bug.cgi?id=1758).
> - Add cast to drivers\net\mlx5\mlx5_rx.c to avoid warnings
> about signed/unsigned comparison.
>
> v3:
> - Add a patch to enable drivers to be compiled with MSVC.
>
> v2:
> - Rebase on top of latest main.
>
> Andre Muezerie (3):
>   app/test: remove use of non-standard array range initialization
>   drivers/net: make code compatible with MSVC
>   drivers: enable drivers to be compiled with MSVC
>
>  app/test/test_cryptodev_zuc_test_vectors.h | 156 ++++++++++++++++++++-
>  drivers/common/mlx5/mlx5_malloc.h          |   4 +-
>  drivers/meson.build                        |   4 -
>  drivers/net/mlx5/mlx5_flow_dv.c            |   5 +-
>  drivers/net/mlx5/mlx5_rx.c                 |   4 +-
>  drivers/net/mlx5/mlx5_utils.c              |   4 +-
>  drivers/net/octeon_ep/otx_ep_mbox.c        |  24 +++-
>  7 files changed, 183 insertions(+), 18 deletions(-)

This series needs a (trivial) rebase.
The CI has been a bit bumpy with new drivers and changes in mlx5.

Please send a v6.


-- 
David Marchand

