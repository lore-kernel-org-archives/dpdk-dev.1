Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B4E109190B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 18:28:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75E77402C6;
	Thu, 19 Mar 2026 19:28:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 55A4C402B9
 for <dev@dpdk.org>; Thu, 19 Mar 2026 19:28:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773944926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8BUHzvMzUzjo0Q53sJVYrBjrs+waX1bXEa7r49dpAA=;
 b=jHXVj7jkxKXTimINR/Za6t1I3cKVgDlRBEuIVkZfX0OLmTG1UKLSz8EZIZum14GlLZFIs8
 OC1kfYXFYSb1nfX0eiSvaJ08yQsE3GDIsuUjJn/i6yq1EbH5yzaS5utrddaTm5e1IMIgyY
 okqO18MM5y1SPTJj4tkIh1UFeWTbRMQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-cAxry57zOGKedwnVJ9KIfA-1; Thu, 19 Mar 2026 14:28:43 -0400
X-MC-Unique: cAxry57zOGKedwnVJ9KIfA-1
X-Mimecast-MFC-AGG-ID: cAxry57zOGKedwnVJ9KIfA_1773944922
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a2778d515aso1550089e87.1
 for <dev@dpdk.org>; Thu, 19 Mar 2026 11:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773944922; x=1774549722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8BUHzvMzUzjo0Q53sJVYrBjrs+waX1bXEa7r49dpAA=;
 b=PVyNSWYJNXseydkTnM5+9NRtFQk4wiRQ/0NZE+GcFlOe3B2QNyzMsrrR4YCpJ7P7DZ
 dRGco79M6DHDX0EIWVyIYFtdR1CwvLmvS+bQ7FyniIBArytcYH7AGOsJEvejOSnSgw7K
 Ehtwsa5oMJ5le55EYw+Y/8sV3V/zLfJU9JZOs8N796V+jTyr955FOZsCKpoHqMtDO7bi
 3PC07y87IqspRElx8FeghulFdSqjKN16oY1gqpsemydpiCm+x9z+IQAoTCE//6S82JFL
 xXz+gnlGZGn4107ClKo1BD/dltwmNkOnruzW9FpjHSo132Mc2X4ZhFRfOI1JSMoHBhCa
 E10Q==
X-Gm-Message-State: AOJu0YzxMl4xvnfY011NQwn1oQw4HnKg+a5G4mNUnZWXA93Bh4bnmksU
 VB8tiLjypxVxKeMssh0rfBn/Ei+8Ao5cCOcqUj7vsorPESFK91s0pCeumH8QOsnLsQXiQbRTONy
 9S8/DvhNLlwa/LKSIi4+XkQVx9NOh/uf7GUzt33q85RGCy79HRCYNBmhsA+53+qp3ebftsph+mY
 X6YtwN9kYvSnkMWYKqaJ4=
X-Gm-Gg: ATEYQzyZ6t1+qXTopZ29lXXtzMqOgKipzCfM7frPZMtlgyaaQXGhrUlo3RXHxie/Cb/
 Hlf8Gq4niNJrbpZMwPPkDjmqvs/KuR3q/JCTjao3ya6oDw+ddgQ2L1WoNMdaJ5YquvObCCymW//
 1iSCHM6NfDsez3X2JgSv7+RjpXr9IN6r7m4xBz15t+Xoo2hC+KKtpTkLNZvzLOWQ7/K6+YnfPWM
 p0DWzd13iXN7IKWrpZCt+yn0K5gmZK8oGdexpESmuy/bGsjQgRMMN12iHNSob/SqsHS2A==
X-Received: by 2002:a05:6512:3b08:b0:5a2:7b19:71ac with SMTP id
 2adb3069b0e04-5a2856011b5mr122208e87.21.1773944921850; 
 Thu, 19 Mar 2026 11:28:41 -0700 (PDT)
X-Received: by 2002:a05:6512:3b08:b0:5a2:7b19:71ac with SMTP id
 2adb3069b0e04-5a2856011b5mr122186e87.21.1773944921334; Thu, 19 Mar 2026
 11:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260318163628.609968-1-david.marchand@redhat.com>
 <jnenabfqrgsmz4erfktd7osqcjw3vewajffyjwmuxhf6s4r4yw@zmlfmipdrpnr>
In-Reply-To: <jnenabfqrgsmz4erfktd7osqcjw3vewajffyjwmuxhf6s4r4yw@zmlfmipdrpnr>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 19 Mar 2026 19:28:29 +0100
X-Gm-Features: AaiRm50YeaFIixE6gWLLb5uzqrliKBXzPqhHg-a7CeJaRMBfLqhCrfi4cpLGHeI
Message-ID: <CAJFAV8w2ET9GKA6ifcg90kn+_J=VG1eOqL0yr0=g7xsCpZgsVA@mail.gmail.com>
Subject: Re: [PATCH] common/mlx5: fix mac deletion on Linux
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uju8oP-rksEWSsIGNnaC784ngtNdEEUIZgdg0hgcQ1I_1773944922
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

On Thu, 19 Mar 2026 at 17:06, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>
> On Wed, Mar 18, 2026 at 05:36:28PM +0100, David Marchand wrote:
> > Re-enable debug logs unconditionally, this helps understanding why mac
> > deletions were silently failing (while a bridge fdb del command was
> > working fine).
> >
> > testpmd> mac_addr add 0 FA:35:44:3F:58:31
> > testpmd> mac_addr remove 0 FA:35:44:3F:58:31
> > mlx5_common: Interface 35 cannot remove MAC address FA:35:44:3F:58:31
> >       Operation not supported
> >
> > Then, fix mac deletion as the NLM_F_CREATE == 0x200 flag is relevant
> > with a RTM_NEWNEIGH op.
> > For a RTM_DELNEIGH op, 0x200 == NLM_F_BULK and passing this flag
> > makes the deletion fail miserably for a single mac.
> >
> > Fixes: ccdcba53a3f4 ("net/mlx5: use Netlink to add/remove MAC addresses")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  drivers/common/mlx5/linux/mlx5_nl.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
> > index eceb3d796f..b50431fb61 100644
> > --- a/drivers/common/mlx5/linux/mlx5_nl.c
> > +++ b/drivers/common/mlx5/linux/mlx5_nl.c
> > @@ -581,8 +581,8 @@ mlx5_nl_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
> >       } req = {
> >               .hdr = {
> >                       .nlmsg_len = NLMSG_LENGTH(sizeof(struct ndmsg)),
> > -                     .nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE |
> > -                             NLM_F_EXCL | NLM_F_ACK,
> > +                     .nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK |
> > +                             add ? NLM_F_CREATE | NLM_F_EXCL : 0,
>
> It seems that this expression is constructed incorrectly.
> IIUC this will be "parenthesised" as follows:
>
>         ((NLM_F_REQUEST | NLM_F_ACK) | add) ? (NLM_F_CREATE | NLM_F_EXCL) : 0
>
> Since bitwise OR has higher precendence.
> So "add" value will be ignored and only "NLM_F_CREATE | NLM_F_EXCL"
> will be returned.
>
> Could you please add parenthesis around the ternary?

Ugh.
That's what happens when doing a last minute change with a ternary and
not testing the new patch...
I will send the right fix.


-- 
David Marchand

