Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B4DCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 13:48:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A69E40291;
	Thu, 15 Oct 2026 15:48:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5E82D400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 15:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792072079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n6Gzi8Rzh0Jw3DWRIKDMvN5TlujGUL5geoXgtMD0mpk=;
 b=hgDWS+dEEk57dzQGAU4oan9fBd9cDP517tEIlx14JiL0+8Iv9DvzIHuZ1gBwbBzJJN6CHc
 69gGSl7eqq5AljRGcbLKQHBPOYW/Y4nUykg48oKSXE7P8xLURK0/Q/ETkXfXTSDI7BFY5q
 SzHU8rb4bkJ2G5fOs6pkYapJ25WbMWk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ejFojJV6N5i5v_e9S1OyHw-1; Thu, 15 Oct 2026 13:47:57 +0000
X-MC-Unique: ejFojJV6N5i5v_e9S1OyHw-1
X-Mimecast-MFC-AGG-ID: ejFojJV6N5i5v_e9S1OyHw_1792072076
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5bcf03751deso992349e87.2
 for <dev@dpdk.org>; Thu, 15 Oct 2026 06:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792072076; x=1792676876;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n6Gzi8Rzh0Jw3DWRIKDMvN5TlujGUL5geoXgtMD0mpk=;
 b=E6agkIRbia7X5ovxTwRkz/W7WOdGlAztd3HMOwg5dgJOQ3VE9NiAqrVzUYFuQjtzA1
 cm7Y4P5FmkD3U1aLzZ2sM9uzDJf+m+F82IAYQNJF0RNcczjzMP4quL4Nwxo59Qp1DUQl
 ZDxGi7hgKxBlQxxsffs4A/9LbflgCujP/WTEtaIEOAkK6A7Ey3PHrdrktgymE8f1FKOn
 OlaRMbO7raTFLSDU8WPs1vG+/FYLyr0KlZ4SIHTsBWbGqF9Rz0P1kFzK5e8Prmu0i49+
 u7iPYx2dAJ9kBE9enIeLkTwScvuUD5WmcjRfYD6Ysb7ubc32qBI62GdrJbI3rot0U06r
 5fBg==
X-Gm-Message-State: AFq9FYKzhmmHEWbOnH5pHVa7K7dFvA50y7wkqPHY2MUdhuakJNa6Bwvc
 iwlkg15dcbP+6XqfhaGNJ7i3hpG9b+6lDrGA+ADbjsk/SF8+l680sz9pGIqJARFqK3HJgAU/TIw
 pvYJwTiKZvjRJQiDw6xre1/Avq0guSef8mN3ISVyqkNCMGjTQQ7c5QF1V7ExtSbWP9OYYwUFfPP
 mJd58H0vPP56JPIYe1cvM=
X-Gm-Gg: AYBFou3XZO5FhcEjGZoaA8crT3W1yWAe4VJpjfi838Qm+lEYFmb3G6eaIRUJ9V5K+Hk
 iWIlkR4WqyOWs36UunzX56vmqGRpz3EczkZv9yJc2AsRArjZOG4jpY0qLIsg/0dlpKbsUEi8vYI
 J+qoQNRAgIVQDHi7SnfBzMdyaiUUrqFnEpyxN5htE+BGSnPFBsirq0DnZJfJtLrQniCWOeyqDj6
 ntlNsHwC8WftCVGAzQMBfU5sff32o7mrMmayq34TMvBmGJL
X-Received: by 2002:a05:6512:1289:b0:5b8:ef97:e372 with SMTP id
 2adb3069b0e04-5bcde8c3d93mr7560991e87.46.1792072075539; 
 Thu, 15 Oct 2026 06:47:55 -0700 (PDT)
X-Received: by 2002:a05:6512:1289:b0:5b8:ef97:e372 with SMTP id
 2adb3069b0e04-5bcde8c3d93mr7560967e87.46.1792072074121; Thu, 15 Oct 2026
 06:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20261005110613.473007-1-bruce.richardson@intel.com>
 <atDYWtn8lwvGspyT@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <atDYWtn8lwvGspyT@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 15:47:41 +0200
X-Gm-Features: AclHuK-861dEIH-dngrFw_a9xGL2hqfWumB7D08ds4SyjcTGkYEx4vbyQuWyA1s
Message-ID: <CAJFAV8x_-WcbE6i5vh_vaTXPUqYwaNXNY7eFgQpqLjzHWP1CVg@mail.gmail.com>
Subject: Re: [PATCH] net/iavf: set interrupt throttling register
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u5DBmxC2VVydmlDkLBcx3uJkR5i8_JiXqBapbURpwX4_1792072076
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

On Thu, 15 Oct 2026 at 15:43, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Mon, Oct 05, 2026 at 12:06:13PM +0100, Bruce Richardson wrote:
> > The interrupt throttling register(ITR) bank 0 value is set to 2, but
> > to ensure best performance across all systems also set the bank 1 value
> > to match.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/iavf/iavf_ethdev.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
>
> Further testing has indicated that this patch is simply working around a
> config issue on kernel driver side[1] and should not be necessary in DPDK.
>
> Dropping as rejected in patchwork.
>
> /Bruce
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb096882095e5a8d6b5159e43793d4a38a0c5b1f
>
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> > index a8abe0154c..dc3cea0b95 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -899,10 +899,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
> >                                      (0 << IAVF_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
> >                                      IAVF_VFINT_DYN_CTLN1_WB_ON_ITR_MASK |
> >                                      (2UL << IAVF_VFINT_DYN_CTLN1_INTERVAL_SHIFT));
> > -                     /* debug - check for success! the return value
> > -                      * should be 2, offset is 0x2800
> > -                      */
> > -                     /* IAVF_READ_REG(hw, IAVF_VFINT_ITRN1(0, 0)); */
> > +                     IAVF_WRITE_REG(hw, IAVF_VFINT_ITRN1(1, vf->msix_base - 1), 2);
> >               } else {
> >                       /* If no WB_ON_ITR offload flags, need to set
> >                        * interrupt for descriptor write back.

Why keep this dead code then?


-- 
David Marchand

