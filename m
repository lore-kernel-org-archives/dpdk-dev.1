Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DF4FD5307
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 07:57:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 229594027F;
	Fri, 27 Feb 2026 08:57:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6F5204003C
 for <dev@dpdk.org>; Fri, 27 Feb 2026 08:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772179036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y74LBKc1Bv7ueEahx7TP4EnRWuYu38jcFtazt5XVnrQ=;
 b=COs6YYmM/jWSEb3j3fV4vXCqr5NiVX7jdUtQHzg2s0+j119gVTWXp3YbMfMwkbNDFWSfXa
 JvlXHxJVSAhQuLCg+9KcgIIn2WByAifpI7/xzs4p2/InFhEbSKEX1aXJASkou0V31pFBHN
 Z8vzOKBgXGzodT/140m4UMvOX+v4sG4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-qd0DSRU4OIaZLVW6pFhmzw-1; Fri, 27 Feb 2026 02:57:14 -0500
X-MC-Unique: qd0DSRU4OIaZLVW6pFhmzw-1
X-Mimecast-MFC-AGG-ID: qd0DSRU4OIaZLVW6pFhmzw_1772179033
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-389f0dae101so12295701fa.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 23:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772179033; x=1772783833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y74LBKc1Bv7ueEahx7TP4EnRWuYu38jcFtazt5XVnrQ=;
 b=ZwOqbRmXNp3m6/gjBgQTm3AS97Cl1SgSFTQ4jTnzPOcDu4yr7oit7eAR4uyaf5EbTR
 y9GO9ssAxbY0EvGhBHT9DVRxXGkGO0w1nYENpRuQA3InPrr9y6X5zQeR7yLiamRE3rqg
 MBEqvGqbmUMzOLUs9sToP1OzmM4taF1URnduCu+8GHeQkk2I+rdKKPHK3X4WTPSjy4Fv
 xpVfkfNIvPil5hLuGOfjIS4A9VEYuPTfrMOAkf7Kz5QvZcMS4tNtdIgdOzCcuDBIC8bd
 vgfjDLYR1bonAuHyjAHGqKvDlmuV5sA0DWpaLmgT+d4bnPncfhXfj9FsQrWHlA85pLzw
 oFMg==
X-Gm-Message-State: AOJu0YyjHd9+drMCCY30jp0uDhnoZ/lcuiK45ADk6qeuIIfOefeBaNDB
 oyWXnJ8k1ANlWLD8O5RgFcbda0I+ME8HmFwcIq00SCWozP9LV2NOqVuDq8+PCwHMJ6NvBY+YjQR
 AEUnnxCY3IO94UEohYbnu4p/g6DxhGHYnuE9BWIjl5bid5CnbdNZJzznK+ok7XxcO4NeMLN31AW
 4gl803McaNXr1Z+kTcYtY=
X-Gm-Gg: ATEYQzz9XcVEyBx2tZs04soZ+DCNU7tKQljcD9NbY1VyrrSJEL60nXxNPqUtzlvq8Be
 +qHJ+teLz0kD24BkwOG7Nqv1xsdENWt+UraETMGakBqNvau2jY3j48Z3IPNdj5OGhZFmYDO3kGz
 RUTp/caXiSVa1JIOIUpDci9GWv0axdYv1SicI0Y0cCFALkktMYAhzDgvaFaMM6SGpuIkXa5K7rv
 kS0gXAN51Z0LHVp3PG+ra8JN8J7V32WBNAWjwjxwdiJrOq22BRvrrFao6ZVPqzylSATgg==
X-Received: by 2002:a05:651c:1c7:b0:387:17e6:1dd9 with SMTP id
 38308e7fff4ca-389ff34cc65mr11488491fa.23.1772179032725; 
 Thu, 26 Feb 2026 23:57:12 -0800 (PST)
X-Received: by 2002:a05:651c:1c7:b0:387:17e6:1dd9 with SMTP id
 38308e7fff4ca-389ff34cc65mr11488311fa.23.1772179032307; Thu, 26 Feb 2026
 23:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
In-Reply-To: <20260205175750.653353-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 27 Feb 2026 08:57:00 +0100
X-Gm-Features: AaiRm50XIMpMWjlisyBE0W6uYk9HQxFGOg1K4NSXSogdvfRuwsAknAqyKO4oA3M
Message-ID: <CAJFAV8yWXL_NRQRewka+c2ki5hQR+CGPGDT15yJ0y=WOcO4GAg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Fix LTO compilation warnings
To: Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BSWJfUAtYtnZaWVBQcKA1lxSjyqQUMx22xsb0l7H1BM_1772179033
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

Hi Marvell guys,

On Thu, 5 Feb 2026 at 18:58, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This series fixes compilation warnings and one buffer overflow bug
> exposed when building DPDK with Link Time Optimization (LTO) enabled.
>
> v6:
>   - net/mlx5: use __rte_assume() instead of runtime bounds check
>     per Dariusz Sosnowski's review, avoiding any overhead on the
>     flow creation fast path
>
> Stephen Hemminger (6):
>   common/cnxk: replace variable length state array
>   common/cnxk: replace variable length array
>   common/cnxk: re-enable vla warnings
>   common/cnxk: fix buffer overflow in SA setup
>   ring: use inline instead of always inline in soring
>   net/mlx5: fix LTO stringop-overflow warning
>
>  drivers/common/cnxk/meson.build      |  1 -
>  drivers/common/cnxk/roc_aes.c        |  3 ++-
>  drivers/common/cnxk/roc_nix_inl.c    |  2 +-
>  drivers/common/cnxk/roc_platform.c   |  4 ++--
>  drivers/net/mlx5/hws/mlx5dr_action.c | 11 +++++++++++
>  lib/ring/soring.c                    |  4 ++--
>  6 files changed, 18 insertions(+), 7 deletions(-)

Could you look at those common/cnxk patches please?


-- 
David Marchand

