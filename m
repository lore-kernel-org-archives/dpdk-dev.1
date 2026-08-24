Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E668BC5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:39:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C62640270;
	Mon, 24 Aug 2026 18:39:32 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id A9E34400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:39:30 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2caed617615so37274455ad.3
 for <dev@dpdk.org>; Mon, 24 Aug 2026 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787589570;
 x=1788194370; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n3er7yhckeE424L5EJ+dcdaS43n4jz4gMKQ888Ub+NE=;
 b=mTcAndFagGpDM1KI8Gjv19daiGPnUd7rR+467hikIdtPeIf5GGoK3qzz7KGChVBLa6
 +5tROJNUrHWRL/M47Q6o8i76HGXP10Oly3gS2YOBze4zgacpw3W6Q4FcOBLXOmIqQrmh
 7BXyPhjsxEIP91kgW4MvJJ711CWUESsRqZDKvkF0EbBxsk4VSHBr2ks5npmN8qAkl25W
 TPQbZskXExcCsr1m/Qfzf708UYWeUBELdpclfFPnKIcVL9xUz5J8LCQMKFQfkxI51+ku
 m9Q6RwWmP+I6Qw3b5iOIiQ3uDCcImcfhdxnuEQI58wdLv1BDPObvjRziwkysdV7LaKv/
 FF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787589570; x=1788194370;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n3er7yhckeE424L5EJ+dcdaS43n4jz4gMKQ888Ub+NE=;
 b=eiAXU55qOj5IZJogb4opOPLbkLMzmA7HpqLa69PuP4+OD/76WVVhzfCLbyuiNrzCYR
 0hWLcqANoiT996d2g1bd/HqxNZxyhmwtnfHTeoCxa1qNMKQkBXykKLDeg+6Nb8sfmKwl
 lYUZSIIZ5usq12HZkhQhjuRk3gFTRMvhk1hIurkd+Ovqo34vOMmb2EF/bf8plAbTV+6C
 szGrxrSvnTKH20RU7t0OLyXgIMGGtOM69bXMheXQqPaol92g2Nd6A+XG3uNPyr2K+nat
 uhUJgXWXAnWomUaAU6Xf4bJa62lV3rt9t3TsFdIFB+wVHbqZYCMNlou6jzODJfNkeZtk
 xqIA==
X-Gm-Message-State: AFuF++mqCP4sTrpgaEZeCFURhkPbWh6/E0dZ/ad2aVvno086M2nK4HPT
 16Rx3od9VLQdJfHL25roWw1Nmi+Ie7OVjFDmBqFtl6nfuG9U9nxzlAJRsR1xjOl+CV4=
X-Gm-Gg: AR+sD12iX1mmvAmx8vwIJi6dYYILYW/FMbChUpShtFlgMdnqFDJg6BtY5egk4m0zF91
 afRcTKfAn9PnNfYo7qSud1bMTzRApdwCTezxIwgkQsGvmgbBkLkBb1/7b7hInWNusqpfMAwwoue
 x8zNAKX9baIcmLM1AmP0HNkhEPtcKF2RpxzIwDeSy4A+s0tKOZHkibyy3x7s5TVlXwr+Y27WmjF
 vr27pfJpAxCBfz+UOGsPYsQL82ZS4f38B5Oo+1/1JO5ZXD67QZfYrvIsxJDuofKFzp2A2OPWoYo
 eLynr1WbjF/lef3S+b7CCpWRhX2NW0FUGNTKBYOA3THVYkPbdp+vIr9eNqyddaWX/u1MEIepJ6z
 On/NsgX2yUEYnpyMZ2F4csBfXXz3wbYz/5IBuocsRdutsKJMHXVbtOouQI5vCu1SkbTXX29eZJX
 okpT2tPzwkhlnAJBjVv83fZ5ZmicymCUQh7PU8HZp2uHfcCeZGULplr5mz13McbRuYpTdFFqw3W
 riRjVYnsBkWVYZIMQrYPudutUER3A==
X-Received: by 2002:a17:903:fa6:b0:2d6:5beb:8692 with SMTP id
 d9443c01a7336-2d670bb5042mr397111635ad.6.1787589569786; 
 Mon, 24 Aug 2026 09:39:29 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d6768b9ad3sm19982555ad.58.2026.08.24.09.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:39:29 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:39:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, Sunil
 Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman
 Kalra <hkalra@marvell.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v6 2/3] ethdev: skip VMDq pools unless configured
Message-ID: <20260824093916.6ea3a84b@phoenix.local>
In-Reply-To: <CAJFAV8zjxCTcRV39H73cZs8N=AxqQm6NJahwAnXPxDOSLUQExQ@mail.gmail.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260824114207.312513-1-david.marchand@redhat.com>
 <20260824114207.312513-3-david.marchand@redhat.com>
 <20260824092125.4d074c3a@phoenix.local>
 <CAJFAV8zjxCTcRV39H73cZs8N=AxqQm6NJahwAnXPxDOSLUQExQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 24 Aug 2026 18:24:29 +0200
David Marchand <david.marchand@redhat.com> wrote:

> On Mon, 24 Aug 2026 at 18:21, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Mon, 24 Aug 2026 13:42:06 +0200
> > David Marchand <david.marchand@redhat.com> wrote:
> >  
> > > The mac_addr_add API describes that only the 0 pool should be passed
> > > unless VMDq has been enabled, though there was no validation so far.
> > > Add such a check, then cleanup the MAC related operations (adding,
> > > removing, restoring).
> > >
> > > As a side effect, the net/cnxk does not need to manually reset the
> > > mac_pool_sel[] array.
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> > > ---  
> >
> > Claude Fable AI review has some warnings.  
> 
> Enough bikeshedding please.
> I requested a merge one month ago and got ignored.
> 
> Those warnings below are pointless.
> 
> Thanks.

I was going to merge. Just wanted to post the current AI reviews
to make sure.
