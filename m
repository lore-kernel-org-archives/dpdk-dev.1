Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D50DC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 20:53:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D89440653;
	Mon, 26 May 2025 22:53:14 +0200 (CEST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id 1D570402B5
 for <dev@dpdk.org>; Mon, 26 May 2025 22:53:12 +0200 (CEST)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso5045621a12.3
 for <dev@dpdk.org>; Mon, 26 May 2025 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748292791;
 x=1748897591; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fhc8iQ4NR1PDzPSxwpYcsdg1kKz2wY4PlwddRHzu0GY=;
 b=lc1s2BMPB+KrrwK3hB5kNb7V9Vxlr79nwVJ2FbKf2rDjFmbrrdGgcYRIO0EqVIyodE
 enX9dzCROrjjvpCo/048+xI6FnLMOLhheTjWO/3PJanyB6pIbunOkPxcNz4QJD8YfWRT
 A+xhhFv2JlfMksRRaMlDR1pqyxft8Fxc3NgyvNkCdRgXjvDqfPU8lp0lddghwoj1ZPrU
 C5qO18J9bk3dZZ/0tu4UrkltW+flLeT+QCT5h6th8ZCH2aZXzaOBUvedklU43/ZTsbkb
 4IvJwIW65yIR99pJ89K5n0uNeIAHA7in9QV3gw0oB1uCwFF9W6+qZVq9tlOX3wmTClE8
 n8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748292791; x=1748897591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fhc8iQ4NR1PDzPSxwpYcsdg1kKz2wY4PlwddRHzu0GY=;
 b=ek2wGRarUBQEk0JjE/RC4pOCEeOr6qCuCjjXAKahusoRmb9H/kj5B4LFvMBrMjykei
 7F2f4CX02ScQR/xC1NHIbMrQRakWSQQoybZQx8PcmpoKjmY9zTXHTZZdrWWyDlsGWp81
 EAbgWByylOPcsBeZHKbffxLyC/IsmlZXtQHoosiR5i8DogADy/wV4DPqPICl1wRQT2qF
 iXEOny3spBsnVrxO4CI5iDVOlwJOIL6Cgl8bUyFw0Kh8iNn2UffhpmOYwlbAw1Kn+r+m
 W6oroVrBbC+z7razyEvfl/8ggIrbdzEYPiTKAsgFKj7+mjuSHUggtrKjoeNFl3uW/nyv
 v94Q==
X-Gm-Message-State: AOJu0YyEIPdUZ9ao+69kKqNFEfTwH/K/lL0UDSJh1nbkB7Z884ko1Uzn
 xGJLPn1/CpjXUVaNrjQiQtB1IWJDcjmMXaTVstxDP4YtozcuCFWhWmx47GfqJ+C+pec=
X-Gm-Gg: ASbGnctEVU8Nnj0bWw0lQBvZdH0io0FIwJbOqIBTm0i0KjUWifuGL39OI6xl9BtVQC4
 igTjPnK71i6gi5r8azYR5yBWnPJ0B7sLBJYL/85LoFadXLqo/tew9j7tVxg7mDdRZFkwQ3sMgKK
 2fsKc24hVWXoBCFI+HGS3pQI7nuTVROiVgWrqai1TRznyWCujMH7uL6yI3t4Kmg4SvlXpQileeP
 lMJ154hMXg46xJIOHb+k8i4C1aLZw0Mwyq2HTC6mc6yLfkLoaoksrlMLCsbLZQghrVUgGJPEdjX
 41LHGs9Y1X6OoOVxx/NSFFLa88Vs2si++1xsLoTgSv4y+KKhK4UqcmTw1ymKSCNKneDCEzl7MRS
 x+M8JdhWXSE7IRNXFcSqtpBEdbTw9
X-Google-Smtp-Source: AGHT+IFM0umfp//c+wWTLyR0bz86Z+4S5ymMOHgTyH6iI0DozQa6fvpp0ZwTdTRWRSFrrRzuRwOOcw==
X-Received: by 2002:a05:6402:28a5:b0:602:b6fd:150a with SMTP id
 4fb4d7f45d1cf-602da9d8a34mr6735990a12.33.1748292791401; 
 Mon, 26 May 2025 13:53:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6004d502742sm16667103a12.28.2025.05.26.13.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 13:53:11 -0700 (PDT)
Date: Mon, 26 May 2025 13:53:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <jasvinder.singh@intel.com>, <thomas@monjalon.net>,
 <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>
Subject: Re: [PATCH v4 1/3] net: fix GTP packet parsing
Message-ID: <20250526135305.653c12ac@hermes.local>
In-Reply-To: <20250523025557.905502-1-huangdengdui@huawei.com>
References: <20250411084303.770040-1-huangdengdui@huawei.com>
 <20250523025557.905502-1-huangdengdui@huawei.com>
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

On Fri, 23 May 2025 10:55:55 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> After parsing the GTP packet header, the next protocol type should
> be converted from RTE_GTP_TYPE_IPV4/IPV6 to RTE_ETHER_TYPE_IPV4/IPV6.
> Otherwise, the next protocol cannot be parsed.
> 
> Bugzilla ID: 1672
> Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> Acked-by: Jie Hai <haijie1@huawei.com>

Looks good but there are failures in CI test of hardware L4 checksum.
Please fix (or rerun the test).

