Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC63C87FC9
	for <dpdk-dev@archiver.kernel.org>; Sat,  2 Aug 2025 20:59:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6225402A0;
	Sat,  2 Aug 2025 22:59:39 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 9E11840156
 for <dev@dpdk.org>; Sat,  2 Aug 2025 22:59:37 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-61571192c3aso2611374a12.2
 for <dev@dpdk.org>; Sat, 02 Aug 2025 13:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754168377;
 x=1754773177; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Hm+Kf9rpMvKJfcVoS+IxCVpPDvLftNPcj/1Qvu2SUk=;
 b=xBjufPXcIw1AcTAYH9P4tmM8HUrLQGmmt8EYpgr0VOhhpLRp8oophwluC6AJUHKgOn
 yWgKsBJF9nZWnP+Hqz4wyFQms/mjEgDrtg1uHRkpmlL30CKQZ1R9SM7rB8ZooSxVqfgK
 7xEg6d5YnXNUOtw/WSQIhdvzNaT1W6gP+CeDh1B2Bf64LghGnuusViRz7twY7509l7dZ
 wXtp9Q2YCYd8D3/9yQQC7zZi4dwf0W6Ys8lydUCffBiBeAyFOV9AteayYqJKmhyfqqPW
 oTkKXj+3ZVafKTijDZRrMerKhxIXSzkm6/02UEkPyMrJKxGJLv2JbcZGgUPMxk2n5sUR
 2f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754168377; x=1754773177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Hm+Kf9rpMvKJfcVoS+IxCVpPDvLftNPcj/1Qvu2SUk=;
 b=vH/MURSpqs2hKQJdLE1gG4uaT+w5eoR7Kutb3GBZBtSw1J7dqx0DFJ1WV+B741hI4h
 631xJ+eKOeVrGi74Bb5c71Yd/ZJpm7jL6TbADWSo1iZt0r4U8cr5OfVuIC3V4ogg7+Cy
 wT01MbNmPctKuuo3p4oV1QGx9zI8J5bH1ze/6+8qheOuzmvSXTTpMO7/Y5BNdTeKrVsf
 +xL1kQYMhuXEHT4MpgaclKj03iaWAl5p+ludBEWBwvQKzdG/b0AWrRth0KthoFYzRyjt
 wjr9vD1lPB/pVhPyVwd6APnzGXpDpZk20EEeodtRhQUnHfIe+iIN7VxnC/KduopeiDkI
 iBpQ==
X-Gm-Message-State: AOJu0YxaVTTTSqFgBd1Gr1MknM9vesZWTnTfp1/863qj9ppUHdSQUV+E
 iU8AOGdTUf3ze4II/0ffpcU8Ii6WQJg/Orz2NUqef674pU0pWBQYGC7TuRd1pl/Er0bnS1+1+ku
 fnrd47xk=
X-Gm-Gg: ASbGncu/E6Dao+3q275g4VE4ruHHPsu7DMvyIYUYjiiK3UEg19RKgyB+VBqS4rGRB3w
 yyTJRc2Wd+DNC48mik6NPASSHNbHIxmfGoYVefMS3gVLGE/M9EutmlgTeoZ9q8WaFf/nxlEupyO
 LUrsVrT+3xPB9aL856BEgFJrKtgVgirmUMMModwOv4NVP1zjdwwyn6jYRyW4PBC4hSDeE4nvbyq
 k3jgm9FmMJghsXJg8FUZ66lzO7uaf4aoI21EnPIGEeaQf9zwZKHHOeukh7BbPqijtsGe1qUEizi
 B/0EBu4IG0mW292i3Bb0SYptn5fHosTr8gy08ikccsNIPaX+sqPgjl/4+c7nAM/BhECG2AWK7lS
 5k5k8+VfzlFgdhe2PMqyjTFIbnpbSjB+Szemg6tOq0D2waAiu36qZtHehno6cjiWbAb1LUPwrM/
 0=
X-Google-Smtp-Source: AGHT+IEnPxx33z0ozkTGsl6/SHmNtVC5f6k09FAH6Sd1BgF3eFc1cFqGj6cK5jGxfcfq5K/9dalmxw==
X-Received: by 2002:a05:6402:3595:b0:615:c8df:a4b8 with SMTP id
 4fb4d7f45d1cf-615e6ebc14cmr3868250a12.4.1754168377021; 
 Sat, 02 Aug 2025 13:59:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8ffa3adsm4630743a12.50.2025.08.02.13.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 13:59:36 -0700 (PDT)
Date: Sat, 2 Aug 2025 13:59:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Andy
 Moreton <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH v2 0/2] common/sfc_efx/base: fix compiler warnings in X4
 netport API
Message-ID: <20250802135930.391bba59@hermes.local>
In-Reply-To: <20250802043010.39134-1-ivan.malov@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
 <20250802043010.39134-1-ivan.malov@arknetworks.am>
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

On Sat,  2 Aug 2025 08:30:08 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> The 25.07 release has got support for AMD Solarflare X45xx adapters [1].
> This series is a follow-up to [1] to fix compiler warnings in the base
> driver that are seen in Windows driver build, also based on this driver.
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=35095
> 
> v2:
> - re-group the changes the way Andrew suggested
> - include Cc to 'stable', to have this in 25.07
> 
> Ivan Malov (2):
>   common/sfc_efx/base: resolve warnings about unused variables
>   common/sfc_efx/base: clean up type-related compiler warnings
> 
>  drivers/common/sfc_efx/base/efx_np.c       | 7 ++-----
>  drivers/common/sfc_efx/base/medford4_phy.c | 1 -
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 

Queued to next-net for 25.11
