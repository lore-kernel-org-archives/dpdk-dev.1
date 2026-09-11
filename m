Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2451FC88E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:55:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55D7440269;
	Fri, 11 Sep 2026 11:55:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7CACE40264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:55:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789120539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/EalpoZrTO6dakUnVgN9vt6KdBBsd17HqW5j/F2EMs=;
 b=COiml7zTZpbGgndBOiPxvXDcPyLqgU9+DL0w+v6nf2fKa+vvN9jVGbXejZguxvu064ZC67
 pp2fZw6rvkOqN/qNiyW3UDkkEBpYEJEucQWtE92mU47HWkG4fKqvEaY7Me+KFmViunwgW4
 CTT6NfbXJgB3LWjXBP0gzGguwFBfCqI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-UtwGdrkTNvy0wMY6JRaTxw-1; Fri, 11 Sep 2026 05:55:37 -0400
X-MC-Unique: UtwGdrkTNvy0wMY6JRaTxw-1
X-Mimecast-MFC-AGG-ID: UtwGdrkTNvy0wMY6JRaTxw_1789120536
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a33567d27dso3308891fa.2
 for <dev@dpdk.org>; Fri, 11 Sep 2026 02:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789120536; x=1789725336;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1/EalpoZrTO6dakUnVgN9vt6KdBBsd17HqW5j/F2EMs=;
 b=YcOS60MvxWmHgTuGGpfxN3pKSmg/iQ0j1UnQgWcNM/sF4ZY/aEqL9c10igj25B3IUP
 wCY5BO0tarPVUj+RUQPdOTWYLkct7pAi3bc+AMXjICgkno7AxwjMl8CxezhOC1ck/nlT
 xGe3oy/OJjgwi5+ZKVRtYM8uT+Pna5rfU9hKh9HyEqpSCZCx35y/qYOliXGjuPEgY6a+
 p/nEgSzOguk7QXv5ota8FJCzc9IvxLxT2AcK1dUSZ64nzOUYzQKEOERDHaFXymXXPXnq
 GCQ9zUwrJhRhRaQNTtWSqra7NC3JfiEFpGI2wBrGVwfHj7Agq4oCY7Vf/c8g3wPmhI9u
 IXHA==
X-Gm-Message-State: AFuF++lWRB2yLWLmxYLAyeeB/ZaBLup7OhEMDnJ76aKm4/hUvDPrb0MI
 nAr0sB55YYnss6CfnpnNyJdw1rtTSRpK/FZ2B40n/yL39B5fprUoplYPO9iIUI3Y6nS94/azolU
 2zf9QaVVfdpLDigzLBH9htdY2+Pl3/m/ALZuo8+8aMTr9KAC/IiJlxHmniDJFzCZMQcnzOlHtk+
 HBHWvlQM0s3/viBeNFc54=
X-Gm-Gg: AYBFou3ziqnoeylZeyBCcaJ2NUeJtAgitmSJaPxtT8DhArNombqKsurILZ206iBrTwd
 UI/I37E8eytto4V95x5hhOZYFArYXr+swM5spUXoP3rriUImuRT4owUX9I2NawG57iB2biYK0C2
 VqWMXq+7avSLZYB+LXK/5WFbC2Sv45oXelQaO1KIfU/lJuD21vfCgzmlVZbSfUQyyyRQgqthTHb
 AooQ0QRZYaaQHYaLei+ZMXQIsGeDoPG0K3Q5mvtT7uUUAeK
X-Received: by 2002:a05:651c:222c:b0:3a4:a4b1:c0d3 with SMTP id
 38308e7fff4ca-3a5a52219demr3450731fa.27.1789120536101; 
 Fri, 11 Sep 2026 02:55:36 -0700 (PDT)
X-Received: by 2002:a05:651c:222c:b0:3a4:a4b1:c0d3 with SMTP id
 38308e7fff4ca-3a5a52219demr3450611fa.27.1789120535591; Fri, 11 Sep 2026
 02:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260908092743.3439825-1-david.marchand@redhat.com>
 <20260908092743.3439825-5-david.marchand@redhat.com>
 <p2wa2mfhpzprrdekf4zc2lq5wcp3lit7vmqbidbkuklvanwjnh@jyzvzl5tpuwk>
In-Reply-To: <p2wa2mfhpzprrdekf4zc2lq5wcp3lit7vmqbidbkuklvanwjnh@jyzvzl5tpuwk>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 11 Sep 2026 11:55:23 +0200
X-Gm-Features: AcwNN1WE2WWX9T5OGJ9h9-KWaHt1U3TC-sivRjI5dxIs2tSaQkGkFLWc0cmaw60
Message-ID: <CAJFAV8yeOj3pD5f2ZYWMjfbjPdQEu8onhA+cAGWxu3ZVf25yYg@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] net/mlx5: accept more unicast MAC addresses
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fa2Ub4Ufs_TsUcYIDoJ9VYRNxyH29GaTeVm_hilCs2Q_1789120536
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

Hello Dariusz,

Thanks for the review.

On Fri, 11 Sept 2026 at 11:00, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> > @@ -1963,17 +1989,15 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
> >                       mlx5_flex_item_port_cleanup(eth_dev);
> >               mlx5_free(priv->ext_rxqs);
> >               mlx5_free(priv->ext_txqs);
> > +             mlx5_free(priv->mac);
> > +             eth_dev->data->mac_addrs = NULL;
>
> This can segfault because eth_dev is allocated later than priv.
> Previous version of the error rollback accounted for that
> (where mac_addrs was reset only if eth_dev != NULL).
> The same logic applies in Windows code.
>
> Could you please revert that?

Well, the code before looked fishy to me.
Resetting mac_addrs if (eth_dev != NULL) outside of the if (priv !=
NULL) block seems incorrect.


> > +             mlx5_free(priv->mac_own);
> >               mlx5_free(priv);
> >               if (eth_dev != NULL)
> >                       eth_dev->data->dev_private = NULL;

I would rather reset mac_addrs to NULL along the dev_private reset in
the if (eth_dev != NULL) block right after.
The comment about mac_addrs (see below) being in dev_private can also
be removed.

WDYT?


> >       }
> > -     if (eth_dev != NULL) {
> > -             /* mac_addrs must not be freed alone because part of
> > -              * dev_private
> > -              **/
> > -             eth_dev->data->mac_addrs = NULL;
> > +     if (eth_dev != NULL)
> >               rte_eth_dev_release_port(eth_dev);
> > -     }
> >       if (sh)
> >               mlx5_free_shared_dev_ctx(sh);
> >       if (nl_rdma >= 0)


-- 
David Marchand

