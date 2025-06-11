Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAA8C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 08:46:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9828A402EA;
	Wed, 11 Jun 2025 10:46:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 26F9E402C6
 for <dev@dpdk.org>; Wed, 11 Jun 2025 10:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749631614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hzRk6aAR1nfhJ61vdnEJbuDlK+2J6qYgKTWm3CVWy5g=;
 b=hDoum3G1x83R49jO2lWwyaj+zv7dYCF4ltRGmY1wgErk5X83Us+p29j1lgkLsSer24ykVJ
 +1BlzBrb/Jx7IXd3zM8txDa9WPvk3t//72PO8slAUjphkDb6UAGftFKqYOIJZRVoX4BiXu
 RmpZEf5BpKXJ5HFrgI4wbda9vQzsKpI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Jm4or1pnMlWweH8AwDil5A-1; Wed, 11 Jun 2025 04:46:53 -0400
X-MC-Unique: Jm4or1pnMlWweH8AwDil5A-1
X-Mimecast-MFC-AGG-ID: Jm4or1pnMlWweH8AwDil5A_1749631612
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-551efecc173so3642935e87.0
 for <dev@dpdk.org>; Wed, 11 Jun 2025 01:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749631611; x=1750236411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzRk6aAR1nfhJ61vdnEJbuDlK+2J6qYgKTWm3CVWy5g=;
 b=QzpIf1Uk+aXmJ6GmwY7+4yauFrycR4WUdtqfqRyf1edpy49+vZWoOmuB4jGozOAN1n
 As8cNVJ3X49uPZ3DgtzWqExQFcpdMCJcuRzqPmOI7kaH4IVqu8MDGju3UnguHOW3iXnl
 5NsHwTlc36omaVni/REHqmGyOWNYckkWFkD4mjhZP3t+JkcVA4lbUZm3X3gs8zQ0K7Sy
 lYyrVn1Cz7a/3nPOVJqguKmW2BDtEyyxBAY347+FPY4pEBlIBaqfcEq6aI9OvOVtXVfX
 /Y3tqTofc/0vlOhx+Cttvr88e8/fzGHmU1u7CuugGK0f7e8cRLOljG533W8f12v5fg+c
 fy+g==
X-Gm-Message-State: AOJu0YySsv6HJ2XkroQXfujsj16tTMYXBPw132vCz60N9LgP38J6j1LT
 twXw7JnpCT+luOJX7SHWk5OAXUawzzt5O33I0xN2Pi2X17dsgR8hXaPKRN2Amv/f7d6lyEdgcsG
 K5KIVllO6CIxO4XxyOHFwpUjFSwTJ52yA9awdeT9GNFnia6UFxiK07x+oRmRPx8s/VZUOSldqIK
 Z33x5w6mCf6Mu9AuzKf0puApPqsdg=
X-Gm-Gg: ASbGncuCYb1Z+AFZQGWWDFeSfgaHUk6+FbI5l+Ej1RFqmdC4IcwdmSW817IrKmP4iQa
 BOH5cla229dMuKX8nVjzyMDxJ4mKl7rXYEOSbNrgLBZ3cNH13zzD7zus6wcnLd549b7fJu5Dczg
 Faiihwag==
X-Received: by 2002:a05:6512:33c8:b0:553:2154:7bda with SMTP id
 2adb3069b0e04-5539c22b4ebmr865628e87.38.1749631611541; 
 Wed, 11 Jun 2025 01:46:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz39U5REVBmR80y1oVmv5xFzJwE8iC2s1huj0IoUwrRlJefdavWgD37MyaZxHOvko0Q+m+qAzDERRi4CkJq00=
X-Received: by 2002:a05:6512:33c8:b0:553:2154:7bda with SMTP id
 2adb3069b0e04-5539c22b4ebmr865619e87.38.1749631611082; Wed, 11 Jun 2025
 01:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250610083643.8466-1-david.marchand@redhat.com>
 <20250610083643.8466-2-david.marchand@redhat.com>
In-Reply-To: <20250610083643.8466-2-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 11 Jun 2025 10:46:39 +0200
X-Gm-Features: AX0GCFvaRKdtnw8_IVrpv7smDBovEHzFSEvzwLdEwVReF9G24mFCLgoweW7gso4
Message-ID: <CAJFAV8z0AvkMf_JoGprpKDfyz08zN4Qz7RUbhH3fmbu_MUG3RA@mail.gmail.com>
Subject: Re: [PATCH 2/2] test/lcore: fix build with MSVC
To: dev@dpdk.org
Cc: thomas@monjalon.net, Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WM5T-BAF0_5ZnFGgxzd7bdSgriGK0i2Q7NX94gwdJkM_1749631612
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

On Tue, Jun 10, 2025 at 10:37=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> MSVC warns about atomic qualifier:
> ../app/test/test_per_lcore.c(101): error C2220: the following warning is
>         treated as an error
> ../app/test/test_per_lcore.c(101): warning C4090: 'function': different
>         '_Atomic' qualifiers
>
> Fixes: 7c37826c2b87 ("test/lcore: fix race in per-lcore test")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  app/test/test_per_lcore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/app/test/test_per_lcore.c b/app/test/test_per_lcore.c
> index 9c72f0fa21..e0674b0e70 100644
> --- a/app/test/test_per_lcore.c
> +++ b/app/test/test_per_lcore.c
> @@ -98,7 +98,7 @@ test_per_lcore(void)
>         }
>
>         /* test if it could do remote launch twice at the same time or no=
t */
> -       ret =3D rte_eal_mp_remote_launch(test_per_lcore_delay, &wait, SKI=
P_MAIN);
> +       ret =3D rte_eal_mp_remote_launch(test_per_lcore_delay, RTE_PTR_UN=
QUAL(&wait), SKIP_MAIN);
>         if (ret < 0) {
>                 printf("It fails to do remote launch but it should able t=
o do\n");
>                 return -1;

Series applied.


--=20
David Marchand

