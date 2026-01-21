Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B01D262B5
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 14:38:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D3DA427E1;
	Wed, 21 Jan 2026 15:38:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B8CFB400EF
 for <dev@dpdk.org>; Wed, 21 Jan 2026 15:38:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769006284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3dKrhxww5/1H+arA8bDAXY0WPSym6OFz9noqxPAkdSI=;
 b=NHWibp+LdZcJ6boCurCAlK7mUfXjS5koQobmUNbdpQykLTE9VL82AKl9h/Kn8GQT08DiiW
 1dH+6G17SMscVKpKLC0uM07nfMKd7WHhWSLmheWYviho67LZpB/zJyQVjXrNbWljCJsV3S
 ZcHFdLFXKUoWwZY2LyeF7A7obz7h0yY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-fiLAUhL1OHS2JMH9BinKWA-1; Wed, 21 Jan 2026 09:38:02 -0500
X-MC-Unique: fiLAUhL1OHS2JMH9BinKWA-1
X-Mimecast-MFC-AGG-ID: fiLAUhL1OHS2JMH9BinKWA_1769006281
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-385ba7acdb9so2785531fa.1
 for <dev@dpdk.org>; Wed, 21 Jan 2026 06:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769006281; x=1769611081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dKrhxww5/1H+arA8bDAXY0WPSym6OFz9noqxPAkdSI=;
 b=RcDYLOa2TUPOPRdMEM95R8FTtfa5uY7PzrnLECf8cNyQz9EIS72mfLRQbbqQujm8iy
 Q2jMx7EPCcPy2mQ2TXEiez2yZcnMPhybR/cfQbMTFmFH+cfs75aGCA1V3fwcV5KCD+TW
 NhpIPAhJDAIHRn+TqUzmIZF2z0TeBo4MQiDfKlGKHi8aT/0Xb6OffSDrN9XsdI1K16Ee
 WzQDAvGxheJp5kfGEgORPmbOaiy7urbsGDcRrYlJBoXrWf+n+FOkZfd7lX5EBMlcha+l
 Xr7a6u82DqQKs7OV8meycl47cwF5Y0fQUhJJWhdGmt3+GBUD6+ZprKfh66uh6Apwdm+i
 OzsA==
X-Gm-Message-State: AOJu0YwTwYQjIem0dHI4Qk1GuXu1w5H3xgmMhz2/3t9Gf8zdQSmUTsAH
 MuxscSf2BYVGh03INkeb3OIvqYLQ9VaIwRnkEoRb3jULVPLq0KaPL54RaZOPEkCVhdBZt4UguZb
 X4IrWmBJu3YZZ4J8fq+FBa+5B1Qve3OG1s40GMgT2UjamV2/ptxZBhCg8G3IUoBcKeeb0l+6eHh
 k+eyQoWmnD8Uxf/D7vfiM=
X-Gm-Gg: AZuq6aLs1rYKx0ik9GhyqGBERG9jWPJ7ddFqGK2JLg9Lk4KzYVQbEomAraKX1MWCw80
 FLNj1u26EUh6QodAZoVDX7uAULhP/ovNdPUfzp3jASpk9l8zU6nJDTy1VIjOfbzWVd5zLlERZDl
 aScSnqHKpJfBy+RBvupN37IkVGTjvAscO2qUMS8QVwSLs5kg8orZpsphotNGnkG+Y/iGHd
X-Received: by 2002:a05:651c:b13:b0:37a:4085:c83d with SMTP id
 38308e7fff4ca-383842ac9f3mr72472621fa.29.1769006280724; 
 Wed, 21 Jan 2026 06:38:00 -0800 (PST)
X-Received: by 2002:a05:651c:b13:b0:37a:4085:c83d with SMTP id
 38308e7fff4ca-383842ac9f3mr72472501fa.29.1769006280265; Wed, 21 Jan 2026
 06:38:00 -0800 (PST)
MIME-Version: 1.0
References: <20260121110757.1948723-1-thomas@monjalon.net>
In-Reply-To: <20260121110757.1948723-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 15:37:47 +0100
X-Gm-Features: AZwV_QiDJD2VekHtH3lmib1gLSSHEmmQgRdpMQm_mN3ITIyqE9zQFwiFCwkYzwc
Message-ID: <CAJFAV8yZy5dUSvy427rR-U1=bFCjhUy=8Fh28y82wpKQBGBSBg@mail.gmail.com>
Subject: Re: [PATCH 0/2] More fixes after enabling -Wshadow
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, bruce.richardson@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PCnypnP194dqXWaYLtiH1jk8SX6kHUBBy1Wx5HI_Fdw_1769006281
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

On Wed, 21 Jan 2026 at 12:08, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> The drivers mvpp2 and mlx5 for Windows
> were not checked when enabling -Wshadow.
> Here are the missing small fixes.
>
> Thomas Monjalon (2):
>   common/mlx5: fix variable shadowing
>   net/mvpp2: fix variable shadowing
>
>  drivers/common/mlx5/windows/mlx5_glue.h | 2 +-
>  drivers/net/mvpp2/mrvl_ethdev.c         | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Series applied, merci Thomas.


-- 
David Marchand

