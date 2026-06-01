Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B06CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 15:30:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3F1440651;
	Mon,  1 Jun 2026 17:30:45 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id B481C4042C
 for <dev@dpdk.org>; Mon,  1 Jun 2026 17:30:44 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-3045c195251so10652446eec.1
 for <dev@dpdk.org>; Mon, 01 Jun 2026 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780327844;
 x=1780932644; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdnaF5bgXCUbmdzHDE7wMUYHVQ9SzbbETIbXk3X02Vk=;
 b=Rn8AhAHadHqjehzVqZbjNQYjrJuk0L3K7ppyqs29jyx72pJqZoW4AXhO/Qgk3Xcz32
 fnp598+V5eFb04zeC/vUiPQqVMz4ThWmOMcfd32nJtf08z6wdIOzE8e4Ja9suqdWbs/T
 T8xvgWhoiVZNmakXd3p6ZwTwI3j1Ja03S5xpu/dmq7c2UB75PGyaOcVDBkDdsoirDJzZ
 TswUj54ZNxAkl9Y4YIsMoBXU84dunw+qL4treQau44B4jpGjiAXtO/dy8tcWYThWIAJE
 TElpY4mwBE7ug73Vb+vrH7fRU2EtuKJZtylxoVgj5NgUNQz8ZTgxxzX4WXPKu4zMRztj
 vRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780327844; x=1780932644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IdnaF5bgXCUbmdzHDE7wMUYHVQ9SzbbETIbXk3X02Vk=;
 b=CNndQuozBmZeETegjj3PESbnCOjDZiBtjbmCN/+WLf3bL7dVyLOBaYrEyxmPf2YDep
 wpUkTXbXc83wPgKooKomWoxGX4LCvu8qI+HBWjOgXWpss91FQXo6TqBkc6pJIynZ1y5M
 6Fbdy/E1288FW1tpdflcvg94gdANjMxpRyY4OfxTZUJ9MZrVnX76LyPWT83ANu2G/Yvo
 vNNqcUkvhRwAsBgjN+QuCYqbp2ZqBt5/IbIr3D7BoVma01uhyOPpvHkbyuSBGsz9pTsL
 aa3AH0W9gr6g1QP0uGPuNz8FPPG2Xbx28n9kQay0/+kZnhyXou27pOHYpnYwUmWk1IKA
 PhXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UJXCaYsZu0Jn3izxLMUata6sYmvYl7Kev2UyRhWKwvHSpwg1tGfA+RckfLxCQMNRnelU=@dpdk.org
X-Gm-Message-State: AOJu0Yw7bBOUGBnstwzxBvTnhZOKeAvbLHe2ZCi8emZECCouW+zwEG+c
 7iILPi2aDCoKYDHcmfh4tfKlc1F0KZpfb2wsemKzsDAEmm1c5bajlZfHXsraCDLy60w=
X-Gm-Gg: Acq92OHvI2d0P/4K1+XK5Mo5NDGKJ1f+U6/UiFs3LgZVbcj2hLHjtzhLnwlpqwTxE/X
 q+prE3DqGrUQ1SzSQnGL3TzVsRLy1cfW/ESB6mui7/ctm+oj6JqEUaTkZlnvUdkPvNHwmPqz9PM
 SYNwdPP3DFJOrVFRMkwNyDdXnoOpJxx2Y3mwvNQ6NnbUO877hXr0z6LReT+c2qMyDcWhca6Zdf3
 JL8vWO/U08XFRV4myuroqMAziPRZPrPzzblh7Tz6ZxOBUblP1BU9bStIaAEDxr14Wj2ZsZ3AojT
 7tNP2pKImgb8s9ISETkQFKYN90Uz5Y9eAP4FRRLH58+E2uNbo3NMX2LwcOlFXEOW6ti0/pul2fg
 Xww26Z+ZPvQyS7o6FYM6XP6whf3vLSngxsQ9Hv97y3VwTWNqLOmRlCNgDPccE752dmMUsc4Mxne
 PPdENJRCN1eyEg3gJ68g9+Jd8KPdXq2QkHuhj8Mq76ZgiygKsfAqyOuaHGje2CANxu9TEdpUqO1
 aA=
X-Received: by 2002:a05:693c:68da:b0:307:c10:71a2 with SMTP id
 5a478bee46e88-3070c10742emr1782241eec.14.1780327843641; 
 Mon, 01 Jun 2026 08:30:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c154fsm8253581eec.3.2026.06.01.08.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:30:43 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:30:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, Thomas
 Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] ethdev: promote experimental API's to stable
Message-ID: <20260601083041.31c6db22@phoenix.local>
In-Reply-To: <CAJFAV8ztviupv0rcjvL9MkBQSzY+yfak0RK8GzNbe-8s5JiyEw@mail.gmail.com>
References: <20260527144407.160830-1-stephen@networkplumber.org>
 <CAJFAV8ztviupv0rcjvL9MkBQSzY+yfak0RK8GzNbe-8s5JiyEw@mail.gmail.com>
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

On Mon, 1 Jun 2026 13:55:13 +0200
David Marchand <david.marchand@redhat.com> wrote:

> On Wed, 27 May 2026 at 16:44, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> > +  * ``rte_eth_macaddrs_get``  
> 
> I am not enthousiastic on marking this stable.
> It more or less sets in stone that the mac addresses are stored in an array.

The device could store the mac addresses in any form.
Your right that right now the implementation of the API depends on dev->data->mac_addrs.
But if that changed, having API to walk the macs would be good.

Maybe rte_eth_macaddrs_get should scrub out empty zero slots now?
