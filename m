Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88132C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 01:34:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 766E04021E;
	Wed,  9 Jul 2025 03:34:42 +0200 (CEST)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51])
 by mails.dpdk.org (Postfix) with ESMTP id 4844A4013F;
 Wed,  9 Jul 2025 03:34:40 +0200 (CEST)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-611998766c0so2544607eaf.1; 
 Tue, 08 Jul 2025 18:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752024879; x=1752629679; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQFNuVZ1c/n2ryQMUyqYcoxUZe5/kTWc36qPkKK/87c=;
 b=jDGXieLRlBRgtgYiylS2VW130Qem4aCFyCD7gSbZ3vkTkuR6H2vmHY/8AaSfurBsHJ
 eQMuZNkPYNZO6IdOa0sqsmBawFEL4eP/XODvKk9G2BrzcN6fUUbPDB6mjFPLZUNLwj8b
 /qoayQfBwZRoesUE4nu1VkMb8v7TY/3jQUc12fkLIHW+TzBx4kkAlOYmNeTVSEFuKLvH
 6WCEOsFF4V6w7ovrMm6i6GRnV1OCmvP3d4rLDS6txFbrKTc97110/WZT0/VIgS24YGBC
 tsIPYnLznjBY2RBv5BAuVNCNdzZHkmz7BzLI5P35mWhhkarA7tK/7VZMzCPQLoce0ES9
 lccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752024879; x=1752629679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQFNuVZ1c/n2ryQMUyqYcoxUZe5/kTWc36qPkKK/87c=;
 b=gammYmiTDb4Ae9qEZccmDWWBFV4v9MYC0OkyfDCDfFBBgk/SahZEtw3IpmXtV0SbQV
 CDOkNivudLjpJ3tcfxWyLCaHSfzhMEqgtpLpV+XFEsh6HWwuoeiotbfQL7eho8JUvD83
 3HGuId+re5FAHfg97u2OCHPRWgZs1Q8K+L2jdxaB5VWDIGObv2BTPR0KsSowim80hhfa
 tVB48/pVtoIHc6idu8llIVGbDBcqcqQH5rW0n9gfqRMxfv0XCZnyQ0DU3h+X5I09YHn/
 WiAt4j3REiq5EJ20aUsuIMkz+sz3T+HQwVH+RNz8HtC4gWSejO+NcRrgrO/trgcjAnnr
 R7/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfspg267xM4WGXZ7hX+688Q5tdXJt6akc67k09I9mACKhkJKLJzebXpzJy26qC8i3RL3sM9Ug=@dpdk.org
X-Gm-Message-State: AOJu0YyEBiZzGQ9xZY7sdldJS2m4ekilJXNmVxxxdaoadfNuSHsLpp53
 b8rAEJ4ukI2RfzXui5e+G0d4c3OL0nZ8PWSoSvvQuqazzyuR0A1YGEMb4b3pKkQ0mZLge3vx69V
 T//YLtTKZ4QijFeZuy0g59smSdsB3QHk=
X-Gm-Gg: ASbGnct6zIU/27IfIzWbxPUEkWXY+yQ4eVnd07VCFH4au6hOiywFy3zEUfUIcGwx9qP
 KtjtbPYbuQhdfhOyeaxZVY3ZhbSxadA+DN+DaIEMrg9zUO6U2FH/PeyyTcjQT5nRU37L0hsxp/N
 ASHxIqKqeeXtP3zQ9Arl5zB7RaLHBe62qTblr6M8ELGXc=
X-Google-Smtp-Source: AGHT+IH9hQzhGy7dcNMVQyX9VyV0a2t/Ovt34A/L/7pB+csos6A9iMr+MKTJbxu4/J/zaIShB5QPjWFnFQxs9ROCZtM=
X-Received: by 2002:a05:6820:1785:b0:611:befc:38e5 with SMTP id
 006d021491bc7-613cce5b606mr481630eaf.4.1752024879393; Tue, 08 Jul 2025
 18:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250708142305.3636707-1-david.marchand@redhat.com>
In-Reply-To: <20250708142305.3636707-1-david.marchand@redhat.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 9 Jul 2025 09:34:28 +0800
X-Gm-Features: Ac12FXzSw0ETYrDDDMlGBhyEDslzFjh16lHSPqVYgHTsVccM2Ld3oUyg5ekweiA
Message-ID: <CAEyhmHRsNi4ed7dTMswGBBm5dX4aQ7+p1cfmGsSvBVXciOKQCg@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: revert Tx free threshold fix
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, stable@dpdk.org, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Baoyuan Li <updoing@sina.com>
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

On Tue, Jul 8, 2025 at 10:23=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> This fix introduced a performance regression.
>
> The problem is under investigation, but we are too close to the release
> (and the virtio/vhost maintainer is not available) to get a fix before
> the v25.07 release.
>
> Revert this change for now, we can revisit during v25.11.
>

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

> Bugzilla ID: 1747
> Fixes: 3e3c7f3fa5ac ("net/virtio: fix check of threshold for Tx freeing")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/net/virtio/virtio_rxtx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/virtio=
_rxtx.c
> index ab97f03d7d..edecd2011f 100644
> --- a/drivers/net/virtio/virtio_rxtx.c
> +++ b/drivers/net/virtio/virtio_rxtx.c
> @@ -1873,7 +1873,7 @@ virtio_xmit_pkts(void *tx_queue, struct rte_mbuf **=
tx_pkts, uint16_t nb_pkts)
>
>         nb_used =3D virtqueue_nused(vq);
>
> -       if (likely(vq->vq_free_cnt < vq->vq_free_thresh))
> +       if (likely(nb_used > vq->vq_nentries - vq->vq_free_thresh))
>                 virtio_xmit_cleanup(vq, nb_used);
>
>         for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {
> --
> 2.50.0
>
