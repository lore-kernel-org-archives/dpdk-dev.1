Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378D8C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 06:45:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB68240274;
	Fri, 10 Jul 2026 08:45:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4AE084026A
 for <dev@dpdk.org>; Fri, 10 Jul 2026 08:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783665899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M/PRCjv4l3DnOy1PRxst2hjoD7FOfiRZjXAooUvW4JI=;
 b=icUahwD3uYUCXYRkwa4i/1Pb/A9qEzgUxMb5cVjLztfjX+DjD9+ZeZP3dK6g8dBQ2DOIdo
 KWbdqtQowI6iwUjAXm7g3MFg5uH5kzLotIarYMersjj2ziOvzDWfVePFCvrs7jyfhtEKpy
 HyXHN8GmEUrXa3OOCT9BsM2JNRg4SAs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-ceage_nLNN2piFu_kYxaKQ-1; Fri, 10 Jul 2026 02:44:58 -0400
X-MC-Unique: ceage_nLNN2piFu_kYxaKQ-1
X-Mimecast-MFC-AGG-ID: ceage_nLNN2piFu_kYxaKQ_1783665897
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39c84c18406so4236611fa.1
 for <dev@dpdk.org>; Thu, 09 Jul 2026 23:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665896; x=1784270696;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M/PRCjv4l3DnOy1PRxst2hjoD7FOfiRZjXAooUvW4JI=;
 b=SezkuxH2C7st/yC163XPhgiB9ZYay4w4MMy3jriftXMVHDNQZawwyDFZ4GdFd6I/xW
 om7Flk1IWe6K5yNVOX6EVTBybidhgG/WPSIcqmWGEVj3sh00UITXbzEtfUcZW+UHJmIH
 85s1ee1HBePDVXo2tHdeO3Q6nUcdF/sdJlkzNOOgI18q+yR3L4FuDNEII6LiaKJKhlXO
 KK8qCiMBiivygtJtpmNdQdROK1dkb20lrqlt1934Lsd0jVUITYnhVIKE78Pz/61/anAu
 fMKPUp0HUiPrElktsMR2r7vhkV1rYqdMwOwkSWUOtViMFycekiV2PwRwcUuoqcXvyuOa
 dqHw==
X-Gm-Message-State: AOJu0YwiqwaAYdOu3fTwwBYSDChZXxvcZSuDToK3OPsW3TssSFa2z3Bu
 SjDLp2IWcPKleljwj6WMyIWhKK8n1vcFBdjX4ft6WVW6BsuVlvJwef9+j2CGy2CmMSZs1vhcHb1
 8Q3x7SVyltxLhvoHATfhbDM/tnrANYe1bpQ6vuCsgmzvEV/Uazw5oWcypbWpWW9ljZ/cGG2Qmlk
 52p9n2s24Yjo8lHUPiyZ2nPMLfqZA=
X-Gm-Gg: AfdE7ckwdLwE4kqgh7MEWYBqmtbWEB1JSDvYH00QQnnEaRj+ICYmxgrNbKlTvNzcFZh
 yuFMOrD7jUz+wvcicFdyenjEw5EVebHzSl1Lhs6Uiw/ibdk+rFdOLT5Blb11lzN+uaxDsHYk32U
 FRy1bGKVwQsOsLed1kXD4q20z+ONg68WVBX4i0jm28xfelR9xv1bh9i0/1wB1r5et/h4tsGT8LX
 bCw52Z5bYc4mExv7jrNWX6hmUm1KHwjSzexziMTse/0SlhRf6VC72HA7og=
X-Received: by 2002:a05:6512:618c:b0:5b0:17c9:a4fd with SMTP id
 2adb3069b0e04-5b017c9a70bmr1329102e87.47.1783665896300; 
 Thu, 09 Jul 2026 23:44:56 -0700 (PDT)
X-Received: by 2002:a05:6512:618c:b0:5b0:17c9:a4fd with SMTP id
 2adb3069b0e04-5b017c9a70bmr1329088e87.47.1783665895736; Thu, 09 Jul 2026
 23:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260709160247.1798575-1-david.marchand@redhat.com>
 <20260709160247.1798575-11-david.marchand@redhat.com>
In-Reply-To: <20260709160247.1798575-11-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 10 Jul 2026 08:44:43 +0200
X-Gm-Features: AVVi8CfL2wtTD6ovBWncwOPa7VwkfaD-2m1S6edUKRuexmI4R7-SKfCo21bujho
Message-ID: <CAJFAV8zm2trB8BSmuaa73c23efXGb=3ikXttMLXVQoeGbW9X6g@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] net/mlx5: accept more unicast MAC addresses
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pn_JKtp38OP2jWFQi5wPE0S6YZ1M3AKaKxZdoUASnyo_1783665897
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

On Thu, 9 Jul 2026 at 18:04, David Marchand <david.marchand@redhat.com> wrote:
> diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
> index 1cad6e1091..23632f55af 100644
> --- a/drivers/net/mlx5/linux/mlx5_os.c
> +++ b/drivers/net/mlx5/linux/mlx5_os.c

[snip]

> @@ -1762,8 +1788,8 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
>                 mlx5_nl_mac_addr_sync(priv->nl_socket_route,
>                                       mlx5_ifindex(eth_dev),
>                                       eth_dev->data->mac_addrs,
> -                                     MLX5_MAX_UC_MAC_ADDRESSES,
> -                                     MLX5_MAX_MAC_ADDRESSES);
> +                                     sh->dev_cap.max_mac_addrs,
> +                                     sh->dev_cap.max_uc_mac_addrs);
>         priv->ctrl_flows = 0;
>         rte_spinlock_init(&priv->flow_list_lock);
>         TAILQ_INIT(&priv->flow_meters);

Oops, I swapped those two arguments when cleaning up the patches...

I'll need a new revision anyway when sending the series rebased on 26.11-rc0.


-- 
David Marchand

