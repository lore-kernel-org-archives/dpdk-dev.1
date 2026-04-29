Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D1DCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:18:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECD7F40151;
	Wed, 29 Apr 2026 16:18:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7FBDC400EF
 for <dev@dpdk.org>; Wed, 29 Apr 2026 16:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777472313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wx+hXap3So/BYyKjB3Oj32LPU2xdOM4guMeK7JMg2GQ=;
 b=Ub8JlMRjjWS9MrmBHrfuACFA6zMXPLPSumheV+LvzaeRmTo/SuWZ5paZ0nbN+VP91Ri7k4
 IAu0AuaileEnbPBLeX9UqfuF/ZovBC8hvNkgeS2qHzvCG1JsBT6wmxlrz5RapZZtzGOzeN
 ygBFf4f2ci43nKYWMBoNLiFup4ZwG84=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-dZZmOo9HN2e1_cPV3j1ybA-1; Wed, 29 Apr 2026 10:18:30 -0400
X-MC-Unique: dZZmOo9HN2e1_cPV3j1ybA-1
X-Mimecast-MFC-AGG-ID: dZZmOo9HN2e1_cPV3j1ybA_1777472309
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-38cd8390a28so63740311fa.2
 for <dev@dpdk.org>; Wed, 29 Apr 2026 07:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472309; x=1778077109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wx+hXap3So/BYyKjB3Oj32LPU2xdOM4guMeK7JMg2GQ=;
 b=l5Ux1wzSi8RtWGpXpbK7kbN09iqdDowD4oWf0jcgSRArhsoi6/CS2iJFmclQ5ftQ4j
 HPfW/efuQDVkuH4t28UYwZ2PUPguFGoyBtbsUKKCLlkKXxGtTA1A7NKJnmjwKbS/c2rQ
 a4kYQ4/BbXPzHpxiBNFody25NZDl8g6STAI85a3I5Gy3B4o13xLKMSwejVbNOfVDnBbs
 cZdC+gE1z21+FWjTM5JGrBAM8v4buqu8HWHHgVjoVJpvJIjHcqloufuF7jFhxBPllt7H
 I1L2RPPnzP9r4GGawNPgMslMjhiL6qzrr18KrZYjCnBD4BkkWleu6m3FuOmWl3vgkjQx
 vzsw==
X-Gm-Message-State: AOJu0YxXY0K85CY1ToF18X+HM2+I7OyEBQfVw53XPhz5j0EP/SIqwL4T
 RZzFO6xMRar8zJwj85AE7yEBPxLkGgsTi4B1grUysTR9/rT7VfJKEN2I2IhISoiGCAruYo9Gd2I
 xM0f3zhB1kOeYBGTQBFMuxCfS07V4lCRKAA3bK5R+Ro54EjmeZ928Mj3a8gurQUlmr/OSIwbwwO
 hO/+t/n/QjM1ade6F/jEQ=
X-Gm-Gg: AeBDieu3e2+SAjU2Nb0njwvjSTSNLbIjaRVi11AsYiIPPf9HFQ0RODfDHv2YaXTHR4v
 sYh6cmiZpeBcBDVNR3SPwhxSZ8ucmo1sh2L10X6kxvejD/cfwcj2SFdCwiEeamHmXsfTwc/78RV
 PN8mI/XI7kMXiqrl/4a8S3pdRjbc9bgAppiMqwj4PrHWq9KPUnJshn3kKkrEEIYg9swUdVhTUsD
 yPORVYYDnesVYoCBwpeMcPTOHfN8OZMmN300Fa3TOlOuVXoqX4vsibio/iJsAwUbrtFTfOYgUVj
 bg/s
X-Received: by 2002:a05:651c:2114:b0:38a:27e:b931 with SMTP id
 38308e7fff4ca-39240cdd058mr30895681fa.6.1777472309170; 
 Wed, 29 Apr 2026 07:18:29 -0700 (PDT)
X-Received: by 2002:a05:651c:2114:b0:38a:27e:b931 with SMTP id
 38308e7fff4ca-39240cdd058mr30895451fa.6.1777472308655; Wed, 29 Apr 2026
 07:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260403091836.1073484-3-david.marchand@redhat.com>
 <CA+BST0nbexjrKN7EMd3MerKxbf0syDErkGd+QrKDfEVOWwS=7Q@mail.gmail.com>
In-Reply-To: <CA+BST0nbexjrKN7EMd3MerKxbf0syDErkGd+QrKDfEVOWwS=7Q@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 29 Apr 2026 16:18:17 +0200
X-Gm-Features: AVHnY4LrJZDsXKeXLCpibwAJM1hzrqNdWj3wvSy-i9h7LRFBGjEf7ql_XkIzmAM
Message-ID: <CAJFAV8wGDsx+SD4JerfduxVvOOj5KJ-FxXeLS-78JOZiAtTgDA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ethdev: announce VMDq capability
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Rosen Xu <rosen.xu@altera.com>, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Zaiyu Wang <zaiyuwang@trustnetic.com>, Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lXEZSJep7BaGhlyu39Pl3Np96SYckCfwpFSUS8RdKro_1777472309
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

On Tue, 7 Apr 2026 at 00:22, Kishore Padmanabha
<kishore.padmanabha@broadcom.com> wrote:
>> diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
>> index b677f9491d..0f783b9e98 100644
>> --- a/drivers/net/bnxt/bnxt_ethdev.c
>> +++ b/drivers/net/bnxt/bnxt_ethdev.c
>> @@ -1214,7 +1214,8 @@ static int bnxt_dev_info_get_op(struct rte_eth_dev *eth_dev,
>>
>>         dev_info->speed_capa = bnxt_get_speed_capabilities(bp);
>>         dev_info->dev_capa = RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
>> -                            RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
>> +                            RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP |
>> +                            RTE_ETH_DEV_CAPA_VMDQ;
>
> We have not been testing the VMDq feature for sometime, planning to deprecate this feature. Please remove this change.

Currently, the driver supports VMDq:
$ git grep -i vmdq doc/guides/nics/features/bnxt.ini
doc/guides/nics/features/bnxt.ini:VMDq                 = Y

I don't intend to own this feature drop with my series :-).
Please announce such a deprecation and flag it properly.


-- 
David Marchand

