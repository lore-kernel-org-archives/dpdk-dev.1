Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C46CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:42:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEDA14029D;
	Wed, 20 May 2026 14:42:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B061340144
 for <dev@dpdk.org>; Wed, 20 May 2026 14:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779280957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SpprrMVvjNmPmIeSe4anXoYHIptDAg4CSvlxC0JCkHI=;
 b=hpX6jtmzdhdV3YgkXTeBMqUwmSWbJALi9D+rjYECxlv9h3eZCXkCg0f43cQTfrRaue1gks
 rZBSHMdt2brCr8G/FRTxHlW6Gl5Lwd4+6V7CXrqni6Q7wr10fsw8ctjgHsDqBz7o0tfUPQ
 49BRnurZypzkaDUQ2t+4291UXUNkzxE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-WxC-URgLOlypKf-5Zwp3_Q-1; Wed, 20 May 2026 08:42:35 -0400
X-MC-Unique: WxC-URgLOlypKf-5Zwp3_Q-1
X-Mimecast-MFC-AGG-ID: WxC-URgLOlypKf-5Zwp3_Q_1779280954
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a8d66acdbdso2242881e87.1
 for <dev@dpdk.org>; Wed, 20 May 2026 05:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779280954; x=1779885754;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpprrMVvjNmPmIeSe4anXoYHIptDAg4CSvlxC0JCkHI=;
 b=Dil2Ty7WFdv/IjjE4Rt0lSApRUbj3Rb92wPWbtF9t5Q6dXhHhoEkceQj87FobAaFn5
 7z3BgmpL5VKKc+zDffEHiYpmyjVA5B1NOauMSomOURWWpOtwwSaF7o7D+ZkdMYRBBshj
 AZRP1p4de5nN7klKmFKB0tJoTMniGZU7141YIKDrvCjbO23PH6fN2so7xvyzvSduSQff
 ujW7PWebiOq2+wZEbzLb9RGOZAqREDmCgeV93seC5Yts4yf5rEKdpE3ev9DQUWM+3vHQ
 omOI9tHmNya/2zZkCCvPa/pInnlRc89oXvbJKO/25slmYp36ww0K+vvQRHOVD3HUpKhB
 229w==
X-Gm-Message-State: AOJu0Yx7TziponEtjGTNBjEXUeYRM6qzKDmtzgYuXiewn218YyIVIVQi
 eG9z9d5UkTObBnGMNHw/dS3wwqJtJI/SjPTGC+bZX9bPu2sWC53MXiGXYwJwhjwpeuJsx0KVdO2
 W6SIcWH3GDK34In7h2cvWsWEv4eQCnUhv3e3Xn+TV6b+5RWljJ9Yp2SnKntWEywnkvonWoH5c41
 tJlGGiPoBPH0OHNfNpnFM=
X-Gm-Gg: Acq92OHSVeG4HQoJ3fGx7uy1QhDxJzkh3veM1rHDYeir85z+IbO6U3MFig3XCiYBhxU
 odO3shTdKL3N5pAyYCOTPJgwuIsjBXf7rOiYVElhw/DnGB9cvln9UBUuqHDmHEWyUK26slI4VNp
 4U11D4tOuGLtGqLf7JetRXMt+6dbC+K7Aue5a1OeTzk9cSNHUAJuayXB/eDFM4aIkKb7aLMxJV7
 QAZ8GygeTRyDZ85qM4ifyMeUtU21ymd6g5NjBBMlEM/8rTYcMUjTUdcwAsxTnn4FBv2TQ==
X-Received: by 2002:a05:6512:1285:b0:5a4:d44:99f0 with SMTP id
 2adb3069b0e04-5aa0e733f63mr8924188e87.6.1779280954360; 
 Wed, 20 May 2026 05:42:34 -0700 (PDT)
X-Received: by 2002:a05:6512:1285:b0:5a4:d44:99f0 with SMTP id
 2adb3069b0e04-5aa0e733f63mr8924161e87.6.1779280953786; Wed, 20 May 2026
 05:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
 <20260518132712.70913-10-rjarry@redhat.com>
 <CAJFAV8xdkhcmY53VRJf3qbsVsYB-hM3DaxMxr=GS5MNvb1MPGA@mail.gmail.com>
 <DINGHEW3M9WT.3F4XUUTLNKEL3@redhat.com>
In-Reply-To: <DINGHEW3M9WT.3F4XUUTLNKEL3@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 20 May 2026 14:42:21 +0200
X-Gm-Features: AVHnY4LOxHvqb3ou0W4-8wsP7SGwvFsVyJ5W-dixZYL9p16wQprIGQ2NsaEIk5c
Message-ID: <CAJFAV8yTyFoWYCNhzcJUBM=DdTDz4qQaN7-=m9_HGQeTc3P0eg@mail.gmail.com>
Subject: Re: [PATCH dpdk v5 2/5] net: support multiple stacked VLAN tags
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Kevin Traynor <ktraynor@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ue6nqE--SpKnroaUfODzmamtGo7pmHfkHKhQrAazsPc_1779280954
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

On Wed, 20 May 2026 at 13:09, Robin Jarry <rjarry@redhat.com> wrote:
> >> -       } else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
> >> -               const struct rte_vlan_hdr *vh;
> >> -               struct rte_vlan_hdr vh_copy;
> >> +               if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN))
> >> +                       pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
> >> +               else
> >> +                       pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
> >> +
> >> +               do {
> >> +                       vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
> >> +                       if (unlikely(vh == NULL))
> >> +                               return pkt_type;
> >
> > Kevin noted that it is weird to report back some packet type when the
> > packet is malformed.
> > Maybe return RTE_PTYPE_UNKNOWN here so that the application is forced
> > to validate the packet? (it should already be doing it, in any
> > case..).
>
> If we do this, we need to fix it in the entire function. There are
> several other places where the "current" value of pkt_type is returned
> on error.

There is this point and the code has been behaving like this for
years, so some applications may have been relying on this behavior.
I don't mind leaving as is.


-- 
David Marchand

