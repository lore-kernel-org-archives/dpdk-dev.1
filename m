Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A83C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 05:06:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2253240647;
	Wed, 12 Aug 2026 07:06:17 +0200 (CEST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by mails.dpdk.org (Postfix) with ESMTP id 63487402B8
 for <dev@dpdk.org>; Wed, 12 Aug 2026 07:06:16 +0200 (CEST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-81ff017d420so24725787b3.0
 for <dev@dpdk.org>; Tue, 11 Aug 2026 22:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786511176; cv=none;
 d=google.com; s=arc-20260327;
 b=llgUfqoIeWVFINb7rYMl9QWBfkFqRfVi2bLbj+oB3gFlAcbfAR+VtdDLhjqdrT0AMY
 qvmc54mmMq0lkhdwwJ3JQtzvfdpuchaNpO4aXJ8zHdDjh2jgIF15Ab6fdz7j2dDITQBR
 fBGHOgFyk8gmfFl7vy1uicJYluYJ6BgYE4Do1ShOpa5Ej7yx86p6YlbqUL+jOKz7nmfI
 8KRoVnVORusUtXQ1pvLeXGvxldGy4JZ2v6FHrZ3ErAK9K8gWxp+zhoaR5kADGXrpf+0Y
 G8W9N8Rp+0h9vIEYwhZHMNZiVAiuLzEQhOpWtbOJps0PouJ6nDm8DxPsUlsEARIyGHnM
 xLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8ckEIcv1c6HCurBPnLcopw3rvl8bQCMG9TFAjWnfP7s=;
 fh=HDcQ3EzVf+LvpYbNMIwQkjpYBwARXbgh4H3CEXqDL74=;
 b=giU92tVKCliv1eC9panWN7wqekyZ/HOT52UTBuSgQp9KEZokxb3tTUKiWnBL1X7OhY
 ysWYDu71Khp33omjqZFWwGdvwjvkfpRYUAYFYQfBw9PVc9QElWQHc0msbubXUMhCOCMC
 urNmGViVOMJd4e82rsONHtcLPHualrdBxVG7rDbBdYCn/ae6LmbxqiifymfreK4iSmEl
 B0qjUFWnz6gGNF786F/UyAFs9aV1Yw+rc4Gb4KqgFRjAYyDdvmZmrKFe0mt2JcrL+xm/
 IUvAwymilCGCs2RVmP9qTBcS+NYQMCRJb6MU6pO+LscK+L3BfgcYDnDkwYfWrQI1l08Y
 IWEA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786511176; x=1787115976; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8ckEIcv1c6HCurBPnLcopw3rvl8bQCMG9TFAjWnfP7s=;
 b=keHJM9ZXy9uHEy8AwRyny8VLVC/F0HP4DiFk5VZiZVqQk1TlE2yiK5doo6xnBqTDRp
 +tm3knVU0tdRz3GqVoEZ/33KJJJoC2SJWtJs1mn1rljG2KBeS+eKnMpUqySlHcbrXhYq
 cJdAjwQTVeQVg3qDIoKTv9xTSYuUekN78tFRfNm1zaEbcB/JOmu7kakZ37hhfjCD8g9I
 qyhW5400KLWJZGpTsudXW52eeGPGOI5ePV4xNO/zfCGFCIONSSbNRqR7InbXO1HmzyOU
 RUEfyENSCUr0iQ0KFKN5vAHZ/pQ67ecS+rqdJcKegIaGjDWay1ObxzyzqUgVXar3ADVN
 yDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786511176; x=1787115976;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ckEIcv1c6HCurBPnLcopw3rvl8bQCMG9TFAjWnfP7s=;
 b=nFpViZmfDRV+pw+vpjDqgcrexOphsQ8R3ItuAth6W/XPDqujrgUdxmXEnoG5iPIleR
 E2O+As6cCnc+9uH3Er+Rppoun21VxwIF5IhcGfE8sXZiHmmeD2cL8aJPddH5zQ8b9YCs
 kF/Reb3v7Y/apqlL69ecaEKdhqEwuh9Ew2EhZTomqtQUkLnvtt/mubohSCJcG687a8sT
 wH9VimINgO8ENyirNEOKk3oDPCCfKOsUSj8KdegQDiiiwSpGSncVHxzm/OTWwSpkbkki
 FgEKMM916KNDR9I4SN7VxUv0xspeSDfFkvB94AKUwFLjpZ8e1wd+xbWyjrdT1r2AjTdI
 FoIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgV9qdSfGdkaNcklBV+0Cj1mDYrMLCJHjBFWtyR3Nx8DcgzBxfV3AFx1ORXSqxYfjnzgc=@dpdk.org
X-Gm-Message-State: AOJu0Yz3XzUfNOYVxwlzjZiwYz+e2h9FN3qOR3tesu8xHrl8LpSJOrV1
 Vs+b7ha1MDs9j8dv1KMxlGKDiG37QL7eEUTrzD6ZTwnmOOAVluAzMDPWaKSGfAexn9j8pM9zBsJ
 WcFL6cm+WsiJo94ncms4Wd28rF403W6U=
X-Gm-Gg: AR+sD11PDqU7MR86xAjplffcRY8M+OIVfWRtUkbLl/YG5KObpxhtXa5Vkaeddr6HEa1
 X4f7TA7vcdY5TYaa/xY2HCrVtstdJTn8nKKKytwkZy8An0/LTRn4YXSp0lzXX0rOtt4/hcgeKW8
 PnCPGI+/uqGzDTpKbfvBL/c2OixzKOThj+vFxbQ1qluGleCJ1pi63M7hAhohh9x2ZYgwCQWsPQ9
 xIWZVHOHHT8aBcdgBUovXsgQDJ+TRhSt4s80K88sIucy1OxdpOYgFjAButSMFycgsuWs+CFZm1P
 M/4/9oeSXoP+omwnykLWaOrmqfyY52kH8wzG3FLuAFhh7tbxTRFu0XW8nVFgMNsCxjo1LYNdZsj
 p7kjLKodu3V7m/yJoV7S7
X-Received: by 2002:a05:690c:6206:b0:81e:a373:47ad with SMTP id
 00721157ae682-8303f8cec17mr39017607b3.2.1786511175633; Tue, 11 Aug 2026
 22:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260727211003.22590-1-kobikenzi@gmail.com>
In-Reply-To: <20260727211003.22590-1-kobikenzi@gmail.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 12 Aug 2026 10:35:49 +0530
X-Gm-Features: AUfX_mzsFonYOxFwLdueisNqngYbJDx-1-3Zgexnw85TQJlzc3zBwSG_LNUnMZk
Message-ID: <CALBAE1MX1F-0XjxGcv1ZMWT1VgTkQ7dg80bDdD4AB9tFrHNFyA@mail.gmail.com>
Subject: Re: [PATCH] doc: fix typo in CNXK guide
To: Kobi Kenzi <kobikenzi@gmail.com>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Rakesh Kudurumalla <rkudurumalla@marvell.com>, dev@dpdk.org, stable@dpdk.org
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

On Wed, Jul 29, 2026 at 4:47=E2=80=AFPM Kobi Kenzi <kobikenzi@gmail.com> wr=
ote:
>
> Correct a spelling error in the transmit completion handler documentation=
.
>
> Fixes: dd9446991212 ("net/cnxk: add transmit completion handler")
> Cc: stable@dpdk.org
> Signed-off-by: Kobi Kenzi <kobikenzi@gmail.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks

> ---
>  .mailmap                 | 1 +
>  doc/guides/nics/cnxk.rst | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index fcb3d1bb3f..f44296a218 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -887,6 +887,7 @@ Kiran Vedere <kiranv@nvidia.com>
>  Kirill Rybalchenko <kirill.rybalchenko@intel.com>
>  Kishore Padmanabha <kishore.padmanabha@broadcom.com>
>  Klaus Degner <kd@allegro-packets.com>
> +Kobi Kenzi <kobikenzi@gmail.com>
>  Kommula Shiva Shankar <kshankar@marvell.com>
>  Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.v.ananyev=
@yandex.ru>
>  Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.ananyev@i=
ntel.com>
> diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
> index cb7a86e8fc..56ad9dc7cf 100644
> --- a/doc/guides/nics/cnxk.rst
> +++ b/doc/guides/nics/cnxk.rst
> @@ -409,7 +409,7 @@ Runtime Config Options
>     When transmit completion handler is enabled,
>     the PMD invokes the callback handler provided by the application
>     for every packet which has external buf attached to mbuf
> -   and frees main mbuf, external buffer is provided to applicatoin.
> +   and frees main mbuf, external buffer is provided to application.
>     Once external buffer is handed over to application,
>     it is application responsibility either to free or reuse external buf=
fer
>     using ``tx_compl_ena`` devargs parameter.
> --
> 2.43.0
>
