Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25174CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 09:18:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0481540695;
	Wed, 30 Sep 2026 11:18:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BD88240278
 for <dev@dpdk.org>; Wed, 30 Sep 2026 11:17:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790759877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmbLqlxMhGJopPBld5bEJnBaRLudkzUc8IQt1SbZXeA=;
 b=CboPg9bNjB+w5isPaXZO/exaV84BYU1Wizn+3gaqRBvyqlnHwvBmz41yTNPnGC3oMWqFHF
 960v2/6euXwKZuD/HcIIC6rABLFzH46zGU7Q5bKcIwv9/2g5efcSLZL5QW83bDPHshT022
 Lt/HX+OhZZxQnKvCN3hbeWdkA1OuYO0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-AYdL-OAVM9G68n17GjNsWw-1; Wed, 30 Sep 2026 05:17:56 -0400
X-MC-Unique: AYdL-OAVM9G68n17GjNsWw-1
X-Mimecast-MFC-AGG-ID: AYdL-OAVM9G68n17GjNsWw_1790759875
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5ba3ac62146so463892e87.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 02:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790759874; x=1791364674;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vmbLqlxMhGJopPBld5bEJnBaRLudkzUc8IQt1SbZXeA=;
 b=kdck7jffqi+eFEDj/i1JGtqntkg+J2qG7XjG8wf92CMg1TX01CBiijWJo1/dx4ZFfU
 n9lORESu3wM6KupkL3d5S1ZfUjETq3oHx/ZRGZ1TR2LvQ1LXWJqHTF0hnxVqRC1QLHWZ
 OglNhHGyMuxZv4s/5oaGt6EHDPLErSqAuFYWCFo1IXw9lerUvpj7hYE/j+L/3gVYFmfD
 UOeaaS0fruR8QbYIWBuZnjAuE0ZCYxhXob1hm7DKV75EpoA3CMfqqO0vR/271uUAytn8
 6bqBsY3E8IDg41OibzmnWiGkJic2nJuZzciu/kNgySxR0w/Q4yFhOI3k9BgcCp7RQvtm
 N+8Q==
X-Gm-Message-State: AFq9FYIp4pqGF0PwveejV0tcjRzUF4GqVbINAf3mh2SqbEClCOFBY8ZE
 jJtPPSaY4ZIbAGR+kQ/9wUFTLtoZvDzeSDePlESMLe+uy7KAXr9hcPpO6cIPyB+qlCaqMBpPeFB
 L1WDbqcq/ac8XDkKV+ZRVICynJbbjBo2tIg9JrI/DrS/FkRaOi2bAmo02zZLCZ1GAMWD+Vt1Btq
 zf5ZJVwCjfumRUcEIuIsg=
X-Gm-Gg: AYBFou1y8fbPymMaYOrbWnAU/XwqKqO2Tira7sBQR4h9FxRxmN5l1NzkOqJEJyT8RKY
 3mn560Gna/4rJYICvS1KqZHEQH7ZjrHTqplooAB7tna6/GssZN9N0U781og4fimdKRNef++3iAW
 JrixMOh4uzgtl/m3RxkMuVoEiuwEcnN1EmYLzO3WeEvlsTnVrztBKOkK4V82lnlZ1dgLa+x4Lcw
 5lbdk9iPAeTNIpA+1hgabwVd/z5AlcHt6KqwvlEWD0oWpPv
X-Received: by 2002:a05:6512:2508:b0:5b7:f75a:ea68 with SMTP id
 2adb3069b0e04-5ba405dc9c1mr312840e87.35.1790759874457; 
 Wed, 30 Sep 2026 02:17:54 -0700 (PDT)
X-Received: by 2002:a05:6512:2508:b0:5b7:f75a:ea68 with SMTP id
 2adb3069b0e04-5ba405dc9c1mr312836e87.35.1790759873986; Wed, 30 Sep 2026
 02:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260930084908.72055-1-david.marchand@redhat.com>
 <arzN7PorjHs67ucG@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <arzN7PorjHs67ucG@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 30 Sep 2026 11:17:42 +0200
X-Gm-Features: AclHuK-o1BAWiY-9fG5K1RiuFv-O5CkKdCCl3qlI3Yt7t9WeeSWV-Xqca6SdUL8
Message-ID: <CAJFAV8x_PrV7c3sp43yn5zCJpje8VuL7RwBh__n2-GTwm=_bbg@mail.gmail.com>
Subject: Re: [PATCH] hash: fix GFNI helpers for building with -O0
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lmTFjQlPGyX29uWGAK56u2erlHI56_Xt2tNa7iHAw2I_1790759875
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

On Wed, 30 Sept 2026 at 10:53, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Sep 30, 2026 at 10:49:08AM +0200, David Marchand wrote:
> > Similarly to commit da31ef54c865 ("hash: fix GFNI stubs export"),
> > fix "internal" helpers used by public inline helpers by removing the
> > incorrect __rte_internal annotation.
> >
> > The issue is usually not seen as those helpers get inlined under
> > standard compiler optimization level, but it becomes visible when
> > building with -O0.
> >
> > Fixes: 4fd8c4cb0de1 ("hash: add new Toeplitz hash implementation")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


-- 
David Marchand

