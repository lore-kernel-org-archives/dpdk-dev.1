Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566F8C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 06:54:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D11540DCA;
	Tue, 15 Sep 2026 08:54:33 +0200 (CEST)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by mails.dpdk.org (Postfix) with ESMTP id C7CA740C35
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:54:31 +0200 (CEST)
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d43ac6072so26435227b3.0
 for <dev@dpdk.org>; Mon, 14 Sep 2026 23:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789455271; cv=none;
 d=google.com; s=arc-20260327;
 b=EOpddRAAGx0JXmlH9ELamoCIwiu7kq2NtFnaum1yV/TgWuUHRilDP/qY2SrRWJ3w4R
 y7xnTT9aGpb7o9VVqvnxYp5xaR5iCNhdIjdB5Sb3Ca2q7D6be0+feAFyd+VjJw4dpEKo
 aBpHKXyE3jaXRXY2LfQDY9sjPD8cTic8jKk1tb7KDVAvQvcskq80jNa4e8R3rwaOR4zL
 pg9Kh1PEIN6Ve5x4StQjwSUjWwTCGPa9rvRdSo0CTC3ENLSMKpsND2jghVGwP58HTgiK
 ggUec8+yNUtWq7itXhvLRGfQtI55H/hRBNGUX6PW2f3InmwoZxTM+QPIUzXi0Gc9XsZH
 ivUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MiVGkOLXVCeR3DVBhezzO/qMH1mNMiiebXF8FdDZNh8=;
 fh=i+bHRtD3VCCO7UNIxBHxbDQxX3XYHGV4nyiaqEN++ec=;
 b=ZXLuS84KwC6FdrkAuaWBsprM2TNaJWpZ1SRt4D1nCuO711obZBg1yPJGeayGZkovrb
 M6ZnulKkdN/2zYmiMjYyyToDwmCi/prbm1qsOHT72A5x5h/6Zh6dxDQtSEDJmVvuOrrR
 h1yEPPAwZld+kF8Z9ALlNKzPrcvaslooC2MVfS/xn8m5G8AfTfc3eIG/2YhR9xI1sU95
 yzYK9rQDknhwVH7eEIXb8yqA6Kwa5vhvBm6zCrIYEBeD9zjq8Guaqy9myRCZdM6Id4oj
 uSTBt9D69HSnu271TXhQfCRO+2u5h8yamutqAx7r575AHjHV19LaUEJlFkAQbFWGejak
 vvlg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789455271; x=1790060071; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MiVGkOLXVCeR3DVBhezzO/qMH1mNMiiebXF8FdDZNh8=;
 b=dqzQzavdP2qyFxHcKH8D2WFIcxFr0DiSTPZ1/tyKup9uLjOLGeDpG0eIViMGJvR4w6
 rnheMDy1Ehsf5G7n6z0zK05Z7OwW5k4qlU8wnSICi4f55a7LwFRQuGtM/S2WJcg8IIw5
 1F+AigGfuufDX+T9udLvxWsU64QcB7vdu8mJoQ6wkxX4yBGqsAYwSgUzfQWGHczvjKoH
 2MBh42DW+/EBc5NNgTcw4apzrKKwFiBFxkNVGkeXrpq4eDSU5pI33t16hKxGJhNmadKb
 UpVlPPFSG8gFc57mBqkXBSfBE5vezXIKlURLrF4paDYbrL2ILkThndgypgsC3uQZUHAD
 0OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789455271; x=1790060071;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MiVGkOLXVCeR3DVBhezzO/qMH1mNMiiebXF8FdDZNh8=;
 b=cKjyNGW9nKJq+riYQ3q5LE3eYhi2YyIlar2VsBh/O62TIH2uUUD2AjFgKXtWs5y/mu
 b5vZeBFM/SfhQD+7S9fu2QAmF/fcd8ay2n6TDK5GESnBaEmX0XpMWlhX9HbF3E/HebTM
 kVijW9KNpzwNsdIKkaRgSbIApanMb4enJMf4HkFFE2HxwYSBnjCvQXGadlHvkdh3WLd2
 dv8mdggdT1v4mD1DgGxhPFqgCpPW7kkvfMz93HrBV4BDlo4FDIj5y6XgH6MIV7J+zVJn
 0v8COQw2g60LDPauJCPRgtrRDQq/FPV4VXC+icZ0kG8m/qEEJdu1VnPfY5UFaNqdIRiz
 culA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxL9sl46IJOsc5HgTAEJO3dpq32awmOoU3HSxSiHl+r/p9rXQ7nfiNiQ/2/zJiCPXBLVrs=@dpdk.org
X-Gm-Message-State: AFuF++kTT3yam11Dp7Lc5SKuhO2e758CLR3PjBSUgv6uVYdWVIGtMMND
 3rH7tzibvFrz8YVdvMx3QEpW5uERaIjYFQnjYP9jwVxGY90ZF8kWa5K09ChHVx4Yh9i+WFJ0EJG
 H2eU360fGHkhZIdAjunVf0Ht3P4vUa6c=
X-Gm-Gg: AYBFou3TyUfReR/Ea0U7useSDpknyFHk/x72KQtqezR25Y9ljTjlif8gDJKgr10sNG5
 hRyWsgNvU7v7EFAJsLNJY7RClZqGuvKWTN6pKNgh9MI99KZNHg2HxAS6CZexh9lCPKdPIpbTX5r
 36crOwO1YbrDAQphQgEJKCAofLGDQ1xkuUoyjRzKWJI8+p038zKgwN4xusHvINioqC1eB8wRdu2
 4mmVRvXWEob0ThM5zroXVaxDknHWZeC1ugTqWagqNcq6NxF4Sgj7+BC5FgpZi5Bgu+wM4Zj814H
 DI+SNzLE+UKiFeZ1bB8qkjV6nn3UkfqNR7NpMhU4m8t1JlD6iGVCKltzn2KAPIwfThBb8GCpG9H
 J36IW5XGlE9JnXvQoXT0liWbJKjuJdDOO/X0FFyXgxlCK82oO7BxaAj7eUHuggRSgdL6qBPvhhN
 5WNyBJg9FTxvqMONEl
X-Received: by 2002:a05:690c:1c:b0:878:cee5:9885 with SMTP id
 00721157ae682-88d21b31ca6mr16870797b3.43.1789455271273; Mon, 14 Sep 2026
 23:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260901095312.1088024-1-hkalra@marvell.com>
In-Reply-To: <20260901095312.1088024-1-hkalra@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 15 Sep 2026 12:24:05 +0530
X-Gm-Features: AcwNN1VQ4FyrccpSoLGWPT-IloRD_xNTopUvQUcN2hL22bcVrE0KnxL6AWgOjsU
Message-ID: <CALBAE1Nu7ebAytcUbbhQtrgL4e8MG8WUEj_5Egb55eX_Kx_QBQ@mail.gmail.com>
Subject: Re: [PATCH] common/cnxk: fix mailbox message size underflow
To: Harman Kalra <hkalra@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, dev@dpdk.org, stable@dpdk.org
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

On Tue, Sep 1, 2026 at 3:23=E2=80=AFPM Harman Kalra <hkalra@marvell.com> wr=
ote:
>
> When the PF forwards a VF mailbox message to the AF, it computes the
> message size from an offset supplied by the VF without validating it. A
> malicious VF can pick a small offset that wraps the size to a huge value
> used as the copy length, so the copy overruns the mailbox region and
> crashes the PF. Validate the size before use, as other paths already do.
>
> Bugzilla ID: 2024
> Fixes: 585bb3e538f9 ("common/cnxk: add VF support to base device class")
> Cc: stable@dpdk.org
>
> Signed-off-by: Harman Kalra <hkalra@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks

> ---
>  drivers/common/cnxk/roc_dev.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/common/cnxk/roc_dev.c b/drivers/common/cnxk/roc_dev.=
c
> index 61aa4b3075..433aca1dd3 100644
> --- a/drivers/common/cnxk/roc_dev.c
> +++ b/drivers/common/cnxk/roc_dev.c
> @@ -286,6 +286,17 @@ vf_pf_process_msgs(struct dev *dev, uint16_t vf)
>                 msg =3D (struct mbox_msghdr *)((uintptr_t)mdev->mbase + o=
ffset);
>                 size =3D mbox->rx_start + msg->next_msgoff - offset;
>
> +               /*
> +                * next_msgoff is VF-controlled. Reject a message whose s=
ize is
> +                * smaller than the header or larger than the maximum req=
uest so
> +                * an underflowed size cannot be used as the copy length =
below.
> +                */
> +               if (size < sizeof(struct mbox_msghdr) ||
> +                   (size - sizeof(struct mbox_msghdr)) > MBOX_MSG_REQ_SI=
ZE_MAX) {
> +                       plt_err("VF%d: invalid mbox msg size %zu", vf, si=
ze);
> +                       break;
> +               }
> +
>                 /* RVU_PF_FUNC_S */
>                 msg->pcifunc =3D dev_pf_func(dev->pf, vf);
>
> --
> 2.43.0
>
