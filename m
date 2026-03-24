Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3460AF54ACF
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 15:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81123402BE;
	Tue, 24 Mar 2026 16:48:06 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id D4E4D4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 16:48:04 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-50b351eaf81so36821651cf.3
 for <dev@dpdk.org>; Tue, 24 Mar 2026 08:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367284; cv=none;
 d=google.com; s=arc-20240605;
 b=jD0MRQySd7IuKmzuT8ez+gHA9UhaYvTOqUsjowhYubcnp8L+Ewn+v+3HafeAwJntsd
 ATIhGS1yikU2GBvfbhvA34x268ch5Au6DC3rWctF4beB0GzPTfUEHWemw/enuk3eHPJJ
 vJw32ctzQJgV8J3F/Btc25CEB+PT/+wUKZwEtJZ+w7B7PZsN/tUYg1hT+x7Z9M/UdjnT
 uv6Mm7xBtbE+KlFVFfYOJTzIUB5v6puhVoi/wvGjh963wJ7QnNeInHAeiS6HmphW8Zy4
 4p0SfhS558d1j0jhfKVA+/Cp614T84+Z0HQh6gQGMGqZNE7jD8MCA+HME2ArS9yaZSoI
 38iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p5nicaFfg9BSg2j3YVXYP7tQVFFyUMl4TB+pDh8OYB4=;
 fh=9hopF22WS6rcyiGIQiCZEh1VGxIFjqDMk/SKNceIjQ8=;
 b=kOefDI2J7rCpgnH0WiFJ0ChzIA10AqlZiJjB3TFpFaZLhZy0RVre8JLvb0qJI7BwUU
 jon45/wSzIFs9jfK4CsKa44pUYISC+jEktJHk8h1pJznokaQHUGqlIUWQzGnuFbPJOXY
 yCvf+m9SR2hwj1196TNyEvcDp1d6XhCu4dVNzgSn+/atyjgiC57ghyDmqBUDKs/gXOZB
 JwO4GHVzSbo1uEjoRPuDek/67JIh/MCdqRj7+lmmDSy2pvb+BvDt79ywLPWeeOGsooj5
 jKiQ9HGRxeOFx/GRcrtbpd58KEa3lBuEY5omd1bsCbqHnc9DkL5GwMtYQI2AN6mZ6/S8
 f8/A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774367284; x=1774972084; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5nicaFfg9BSg2j3YVXYP7tQVFFyUMl4TB+pDh8OYB4=;
 b=L8+XvpG8shOa1SZGNwOyTe+s530LntlB57pbEhmkQp9Mm6fEGRNxwgniMYzvFZD7eE
 Lw8bFGdZTYtp8OQmUuSxI4MI7L9ss5bLKROnUxjLP/ZrBWKU1k7BK1jy8Yb0pTMEIzmG
 CYuemuzUo9NBZBSvaJR6XBSk1/unwo3ZmhHnRqoc/mhn8+rHxybqTn2rZWwfxjnL30nH
 O7cbSKSce6vMYu1Z5VlYiBQwk0OpG+fG3RvDw+omDchZIuqm8jEfPwgUp5acmZF6g96j
 TtB57BIhQS81Nj5yLTmwQ7tBGKa6sMh5hVlF2rweGre6KdNl1Kby5gVBD+qnZ9nQy2tX
 TQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774367284; x=1774972084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p5nicaFfg9BSg2j3YVXYP7tQVFFyUMl4TB+pDh8OYB4=;
 b=qay7nCjOTVQZcU5Vb+KY8jqs4ddPMmxXpStgUZISGq0Aqh1CtkLihkkjXBBQsYpPK9
 iEcYZvHdOTjlwkzSXQ6TrxC+06UogiC0fm2pOWx1a8/Sqii8cOVTpP3w5jaTt4TC0m9X
 Z0iHKgHvgSwjaEzbIGKiOsFaOLtdD/eimUx6PTT/2ow/aBJOxp7Vz8PDI6qWwkHo7dYj
 rz5av18dM0IYyVuWhbRNu9rNf3FJWDFzSivwIepp+zkvKjioVQpfPs0AHVuhe9GpOsKw
 GQxNd4FaKfifNQqMtaO4ngrsLLLliLDg+fyznHY2zlBI5K+61cxNR62O7VHd84qFJ7Ex
 6GIQ==
X-Gm-Message-State: AOJu0YxZ/06Dq1EY3GKEnxEOXadfLZZYJHFoWcRYX2/mfyYa5dOqgf1A
 gIFNkcndyFypLt9wp/Fj5jjZ5ib15ILNFo4amicgNkBKu5AWDpHx7YkQtxA11RhSORIOP1xMCxI
 syGVbcU1SPtVYZER7Kn2OPjGemA2sYRM=
X-Gm-Gg: ATEYQzyYmS8HL1svkIMQSYZk2fbzfBXRQ3ZC+4BqbA/CwyQM7jICtxMyf2g/xEePS9n
 b/Au4TGIDLGrVOYk6wmU0cax42gOGnlKT7b9m6qlpOUiDQJL0b3N2leh+RucyUGyNTA6OGESFBG
 Yr5gPhu08f8gYfQZ3Qh/iwcnhTp4GUoRshXCS9F1fNxCiKcwe6MHBXjQaNFJiKtKM5qatNIBPv2
 zVpxCLTFlegbO5xWcGr/2TVVwtq8W1iYXNou/qCz6qomeJPXzTpAj/Oya/O2s+ZrBD1U9tH9VcM
 NdI=
X-Received: by 2002:a05:622a:1488:b0:50b:3014:22a1 with SMTP id
 d75a77b69052e-50b80f367c7mr1242981cf.67.1774367284071; Tue, 24 Mar 2026
 08:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260302135319.1971488-1-rbhansali@marvell.com>
 <20260302135319.1971488-2-rbhansali@marvell.com>
In-Reply-To: <20260302135319.1971488-2-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 24 Mar 2026 21:17:37 +0530
X-Gm-Features: AaiRm52eggYC8cERkIRVwwjAHkzNlGNeBJA3a3cIR40SXdDulInwSx82LYujDGY
Message-ID: <CALBAE1PC1dRRxsqoQgwVughjtr8Mx2CqMc+YLN_qWf=xaPitPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/cnxk: config option for RXC time step
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com
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

On Mon, Mar 2, 2026 at 7:40=E2=80=AFPM Rahul Bhansali <rbhansali@marvell.co=
m> wrote:
>
> Provide devarg option to configure RXC time granularity
> for reassembly handling.
>
> It will be set as rxc_step=3D<val> for nix device.
> e.g.: 0002:02:00.0,rxc_step=3D10000
>
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>

Series applied to dpdk-next-net-mrvl/for-main. Thanks
