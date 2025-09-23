Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA78CCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 09:29:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BA5C40658;
	Tue, 23 Sep 2025 11:29:05 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id A5567402EE
 for <dev@dpdk.org>; Tue, 23 Sep 2025 11:29:03 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4b7a8ceaad3so52529391cf.2
 for <dev@dpdk.org>; Tue, 23 Sep 2025 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758619743; x=1759224543; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LAVNcE8nwt4YjZ6nkm4Yd/K+v4JeMEYOqJYGyaAzjI=;
 b=eJgOVNdcdkQw4Q2qjjrWv1fREn0AfkQYKYDZ+Ra1o+Cqub6cUZwRfVM53SMoWecZlZ
 z9qrr0EOX38Jj9gN8DV8otQSIo9IULPAN8saa/UebopLTF+Hw3hkdaaZEFO34ZSDCh9o
 8wSn/bBvRbEM/fEFcnYhoGoKAERL+kxQz1zuwDFidLjq7DRoWULTs9r8VjI2WOX4l1N7
 napzyudNlbb1fXO0ydUP7Vw2nfPWWqRw3buAvIfYxUH0/NF9vv36thsdemtyVhyu6h9r
 ayPx0AgwpT5zAdRVGK0goIeHtMhsAHQvjrgVcYG7bqpMmx+mpg/08POJrmiMtzbDgwap
 J2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758619743; x=1759224543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8LAVNcE8nwt4YjZ6nkm4Yd/K+v4JeMEYOqJYGyaAzjI=;
 b=IJi+cIMVjOuDpG3Wl2TyUuyrwzNuYzleD1k2TqbuMwXOnj/gC8NWXMY18BvhWq8N2/
 wu9vnuSVaKg1eTzLgmjF1r7M+4vB0AMhfJxkS8wgWQLgaE4P6psYsollg/9vZZ99JvTW
 2nFOosRWNcAK3EdNjb5en8MUoSsMi+rLHYCeYqPepBI74EWOOUHOYM/R/+//LBekkj2l
 rka2uixLIe2Lpq29TSsUxISUMforN+6gI0BrZuzNQkQwrf3MKrQs42VxnfxeAv7rXdan
 XOE1HFnmVm3iNwWaIM0jQk5IpyTD+C8OGMSafs5l9TbTTynAzExZyGSOeZ4aZsVWDxUi
 K0fw==
X-Gm-Message-State: AOJu0YwCTMWA+mcJAR/wexHKgFD68dVUrZ5CwKoIimruHEOxUhs2mkjD
 Apgwax9cCBSDl7a/CpPwbOFK0+A2Y+q3d2Scli37Q/1P0tA2VDAyEmDKdxBD1Gq27uFaOYAhHtx
 7M+wMx7ra95HtBA0tNh16drG636DZbM4phdn+
X-Gm-Gg: ASbGncsvel7qmdCS0Zr/nrnaEduRxxZMc9Uc7PTlIexfHk3/V7rn5DnV/RjKFge/9nt
 ewMIsYC8Ro/5hueHFOF7m1d44Z5Hx7f7VetIntEEeVLegR7IUoWfq7HyQU+XKBj8tqBTQr6dgJN
 0TvNM7KUMwOgI1SfdmvBGdhUGOM8eMlEz1MURpxW6BxSRnbB2Vn/nV7cAcxaLffWoW5LcLSTuhM
 PrGwYYPlIz0B/3EggNqbxS7NW6jQlZ8CyV2VtvsCITAnPBF7fiO6mAeirZ6hA==
X-Google-Smtp-Source: AGHT+IG6/+/Kq9Dbs+rO61GEU8LzGQN+FEV3KZIJftiJjOhsrK13d8JJJ8NXjEb46guCBz4A2fZfD8R0++3hadiKews=
X-Received: by 2002:a05:622a:180f:b0:4d3:5418:d53d with SMTP id
 d75a77b69052e-4d36e5df14cmr18213881cf.49.1758619742448; Tue, 23 Sep 2025
 02:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250923044528.89132-2-stephen@networkplumber.org>
 <20250923044528.89132-3-stephen@networkplumber.org>
In-Reply-To: <20250923044528.89132-3-stephen@networkplumber.org>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 23 Sep 2025 14:58:44 +0530
X-Gm-Features: AS18NWCtG4qJujmfyTpAiZrH4HxSI3-N4T71iTLaAzn8J-JKVIyrPTcoRVFdBp0
Message-ID: <CALBAE1NcUbxGZD2jTEDK4C1W+tE50chUUwgYww7TXeydERtp=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/cnxk: fix overrun in dis_xqe_drop
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, rbhansali@marvell.com, stable@dpdk.org
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

On Tue, Sep 23, 2025 at 10:25=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The function parse_flag expects 16 bit value for flag,
> but dis_xqe_drop is a byte. Detected when LTO enabled as:
>
> ../drivers/net/cnxk/cnxk_ethdev_devargs.c:166: warning: writing 2 bytes i=
nto a region of size 1 [-Wstringop-overflow=3D]
>   166 |         *(uint16_t *)extra_args =3D atoi(value);
> ../drivers/net/cnxk/cnxk_ethdev_devargs.c: In function =E2=80=98cnxk_ethd=
ev_parse_devargs=E2=80=99:
> ../drivers/net/cnxk/cnxk_ethdev_devargs.c:312:17: note: destination objec=
t =E2=80=98dis_xqe_drop=E2=80=99 of size 1
>   312 |         uint8_t dis_xqe_drop =3D 0;
>       |                 ^
>
> Bugzilla ID: 1790
> Fixes: 0344fb5a59c2 ("net/cnxk: add option to disable XQE drop")
> Cc: rbhansali@marvell.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>


Series applied to dpdk-next-net-mrvl/for-main after fixing following warnin=
gs.


Wrong headline format:
        net/cnxk: fix overrun in dis_xqe_drop
Line too long:
            inlined from =E2=80=98kvargs_process_common=E2=80=99 at
../lib/kvargs/rte_kvargs.c:187:9,
            inlined from =E2=80=98cnxk_ethdev_parse_devargs=E2=80=99 at
../drivers/net/cnxk/cnxk_ethdev_devargs.c:371:2:
        ../drivers/net/cnxk/cnxk_ethdev_devargs.c:166: warning:
writing 2 bytes into a region of size 1 [-Wstringop-overflow=3D]
        ../drivers/net/cnxk/cnxk_ethdev_devargs.c: In function
=E2=80=98cnxk_ethdev_parse_devargs=E2=80=99:
        ../drivers/net/cnxk/cnxk_ethdev_devargs.c:306:17: note:
destination object =E2=80=98force_tail_drop=E2=80=99 of size 1
        ../drivers/net/cnxk/cnxk_ethdev_devargs.c:166: warning:
writing 2 bytes into a region of size 1 [-Wstringop-overflow=3D]
        ../drivers/net/cnxk/cnxk_ethdev_devargs.c: In function
=E2=80=98cnxk_ethdev_parse_devargs=E2=80=99:
        ../drivers/net/cnxk/cnxk_ethdev_devargs.c:312:17: note:
destination object =E2=80=98dis_xqe_drop=E2=80=99 of size 1

Invalid patch(es) found - checked 2 patches
check-git-log failed

### [PATCH] net/cnxk: fix overrun when processing tail drop arg

WARNING:COMMIT_LOG_LONG_LINE: Prefer a maximum 75 chars per line
(possible unwrapped commit description?)
#14:
    inlined from =E2=80=98kvargs_process_common=E2=80=99 at ../lib/kvargs/r=
te_kvargs.c:187:9,

total: 0 errors, 1 warnings, 0 checks, 8 lines check






> ---
>  drivers/net/cnxk/cnxk_ethdev_devargs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/cnxk/cnxk_ethdev_devargs.c b/drivers/net/cnxk/cn=
xk_ethdev_devargs.c
> index 5d774e0d70..68e6b1d190 100644
> --- a/drivers/net/cnxk/cnxk_ethdev_devargs.c
> +++ b/drivers/net/cnxk/cnxk_ethdev_devargs.c
> @@ -309,7 +309,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs=
, struct cnxk_eth_dev *dev)
>         uint16_t custom_sa_act =3D 0;
>         uint16_t custom_inb_sa =3D 0;
>         struct rte_kvargs *kvlist;
> -       uint8_t dis_xqe_drop =3D 0;
> +       uint16_t dis_xqe_drop =3D 0;
>         uint32_t meta_buf_sz =3D 0;
>         uint16_t lock_rx_ctx =3D 0;
>         uint16_t rx_inj_ena =3D 0;
> --
> 2.47.3
>
