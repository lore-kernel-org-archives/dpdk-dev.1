Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DC9C369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 15:31:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39AA34025E;
	Wed, 23 Apr 2025 17:30:59 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 64691400D5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 17:30:57 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso6381338b3a.1
 for <dev@dpdk.org>; Wed, 23 Apr 2025 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745422256;
 x=1746027056; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wy9HVV3Q99t8kht3GwH/nGT6iTMaupsS3DneBA+H2DI=;
 b=XTon0EFevB0tfba5maQZSqJAn46KRi3y2gevrYhHhk1OZngmSukIfmiR8BZXKGJ5FA
 JAlvwa7qtOvNHH9jSl/a6MeoY0WTxP931JYsMavpdvgt5r+H6kelGlSGJuo41QI6sx2j
 dgmfCxCaBzoTjhdKV/uwyCU2hECLJX/lVbAg+SLV/6GvSwKu7t12e0df7PwtxzQcK1Ls
 BaOppFxAodg7gag2vChvzeX1rL6puZ2sZJwfdZYmlUqfzlVXzZxMN7Pj4rZbiBPCcgfj
 mj/gZa74TwWXSeAgwwIwWo1YD2aNpdkkm4ioLi4a5Mvq3hvOLuEXcAHMULyR/XuJDvG6
 LLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745422256; x=1746027056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wy9HVV3Q99t8kht3GwH/nGT6iTMaupsS3DneBA+H2DI=;
 b=E31vV3rteMU/ElZzSajsJK/E5aaExcDKtq5cBwjjlCZTFZk+/+qdSQRgWpSvQEtQF3
 xPQQg7gRoJ7SciW/easAU/HA77D4x+TO7FC8/QPH6yzybZ59w5AdhYOgM72g2wijlCf3
 IaZeHo8WCeV7LzSyDs5nOPU3g4+ABitMCKPlSYUAQiAUPn2ImZ13HGgKS0wcmQQ0Ljmk
 SxUCe5+Nm4+2od+X8pL1nENUYgZUqKPa+cRFZMqllSX6Rq/K0juEBO7+3MVmymhW6iIm
 O9BmD5dMXZeNGTECe/ZjJ82dkgtzymZdG3gN/AW6R0gusR7RSc+HXu1nkFwFJoJ6rfzX
 AnxA==
X-Gm-Message-State: AOJu0YyHrpYQUMEDiwjq7mBLm7z99EjJ1t7z+BzuEKp7leOAUBhpFwG4
 +HUNnV5kwJn3zP2P8ry387C71QXcvm/6UrWBqxsE28EVutZHo4NKnHfwnVe8kE4=
X-Gm-Gg: ASbGncsSxq9KNN7DvtLI+Vg9DraAk23TwiWYccvz3zu0LOojGJWA81/UEeTEfcEF+HM
 GsYCQrrv74Q2qIdxbJQojo4xGODZKRU9EAAW/7C21qeydE+HDOsga+UKA8EfJ/ioAAdaf0ICrew
 mIIfuUt3kaWWW4a+kMr47uCDotWzWF1I7z7ebp3W/jxUYKvMNZMw1q4Wf5awLn0INsqxe7sLTMm
 mOwGOdg9BSLJPE28eblkurWBHjc3mKuVmkZDX9v2yq33rhS1NGhAEXT1Q/blUZ86t1Gm68OUFj7
 8VnO44+2bbzLgAA35nnGYIBNu55AyCD79pDnXhr1nLH5JRBjRocfG++R+YyiEVVqQDOsVqFs3CV
 +eCdFVXgjsdhx9/dy
X-Google-Smtp-Source: AGHT+IFWELCRXXGPf9cW3vaZlVd5WPVStHIMxH060Zk6yGWcFp5qlQBqPClQWkqzVNG6uOu7tRyE9g==
X-Received: by 2002:a17:90b:2801:b0:2fe:99cf:f566 with SMTP id
 98e67ed59e1d1-3087bb573d8mr27645986a91.13.1745422256222; 
 Wed, 23 Apr 2025 08:30:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fe0460sm106215385ad.255.2025.04.23.08.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 08:30:56 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:30:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: edwin.brossette@6wind.com
Cc: dev@dpdk.org, olivier.matz@6wind.com, didier.pallard@6wind.com,
 lauren.hardy@6wind.com, dsinghrawat@marvell.com, palok@marvell.com,
 stable@dpdk.org
Subject: Re: [PATCH 2/5] net/qede: fix bad sanity check on Rx queue release
Message-ID: <20250423083052.63bed101@hermes.local>
In-Reply-To: <20250422155143.3893525-2-edwin.brossette@6wind.com>
References: <CANDF9xDNq9Yy+FujvGcc3r1ycjbJDJmnP4_ih+LEm-07=jHDcA@mail.gmail.com>
 <20250422155143.3893525-1-edwin.brossette@6wind.com>
 <20250422155143.3893525-2-edwin.brossette@6wind.com>
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

On Tue, 22 Apr 2025 17:51:40 +0200
edwin.brossette@6wind.com wrote:

> From: Edwin Brossette <edwin.brossette@6wind.com>
> 
> As per the rte_mbuf API: the driver is responsible of initializing all
> the required fields. This is not done at qede alloc, meaning there can
> be garbage data in mbufs memory, although this garbage data should be
> overwritten when the mbufs are used. Since a sanity check is done when
> freeing the queues, its possible some remaining garbage data causes a
> panic when trying to release the queues if some mbufs are being
> processed.
> 
> Use rte_pktmbuf_raw_free() instead of rte_pktmbuf_free() as the sanity
> check is more relaxed.
> 
> Fixes: 2ea6f76aff40 ("qede: add core driver")
> CC: stable@dpdk.org

Patch looks fine, but DPDK is trying to follow the inclusive naming
guidelines. The term "sanity check" is on the not allowed list.

I will reword the commit message.

https://inclusivenaming.org/word-lists/tier-2/sanity-check/
