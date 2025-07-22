Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C51FC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 03:56:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C33F402CC;
	Tue, 22 Jul 2025 05:56:30 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 9670F402CA
 for <dev@dpdk.org>; Tue, 22 Jul 2025 05:56:29 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b321bd36a41so4067478a12.2
 for <dev@dpdk.org>; Mon, 21 Jul 2025 20:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753156589;
 x=1753761389; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZCusr9viLVhaMLChO4vj6cewnPVylOB+zEtny4dFOQ=;
 b=d7O3sDPeGx5GZL8HSIAXLsuPLe6JYs24zsiIfelD7NTS3kypc+nGT1ETNtbrLVsJHG
 n1SzJpbVscmWssbyxWVlQRqvxgb8vdwUPOHhiVSVCv4Hv0TtTBwA+l3Ucdsj9MkUJHP9
 jb0hRKgN3Qggzxv4VEutntFDITKBfQ9gdJHLVe37qiujqC1znJ3oRiI/q7kOgwwK94iL
 aTsaWpnfMgO4p9STyfklwsX+yiBCpVKmBc2cb4CtmW6YD99Dez/Q0IbPkE+bZcFx57Oo
 ivy8VTqQXErDkpJ+KMhhjOeOYwH3/rP+xv9VUXK1n5K+/pGuy5q54WyrEic+dSHSe8FQ
 k4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753156589; x=1753761389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZCusr9viLVhaMLChO4vj6cewnPVylOB+zEtny4dFOQ=;
 b=I+gmTCBTIKK4nG4YdgjrDNehz4SU9lVS7UWtMtJZM4zhFePVO78hYLgJenzbVl2+Pz
 pH/MoOUrXdug6GebxxXU4aPULac5XQEH5f6TgSCuJC3RdBy/0xC2IgsMjqNsDYtH1jOi
 WLInWuArvgzltVSnkxjgD5AqSwZdE0vv2wI1BU/HnD5vQ1nSzBm4YGjnv2+cItKE8j2s
 SXWCDmibQ0wIIpGaWmjIZR7zJ2reDoN54m1M3W8BxyVsHj/y31Tp0OEhbQm7x+u2wWJC
 acUO1uEUhaFvUukt4+Vo/mhUEx6KmBm1RDBUFwEGCGYUpkEBGDXxOPbrbC2VOpMiIVmp
 Vlyg==
X-Gm-Message-State: AOJu0YwwJOIXwDo9Ldb+q0CIpaHMwbnAhnfRcr01cj8+qAr3lXKHIGG9
 NwT8G/NndI5u6SfVnrNRQJPrFVt2BPxUsNEu5akWzTUKeoqz3ngEyo8E+mu6QfCg+rY=
X-Gm-Gg: ASbGncuFx6acfz1o9zHh9hZ9DLDwdbEOCBqDtEzV/MT6piFV8th99x7VL1O4qOiRdWJ
 g8YVzvcmuda4BIleWu448QJ3cKpD0QfhKD2wQ5yDYtsZPOeHYunCzTwqZ0TOwOPP5jFr0Gw2wdc
 mgI1ExL8YeweaM/qdklufIaQRR2c92mbN/4+B6bvKPMPuznYA0GGfVcxutKSCg99TaV1FFvi1my
 LTzLjcEvvmtfKCSuKY5+o9sxQoA57o0xhG3AdDusmaJjpyapd6ccYtvkgbHpqnJWft1kl8VNKqG
 UlO2PJe4LGfwCuPXaqAPYOs6MjpVW8cpV+fhYreo2s5ILwlXXC1RPebk4CvUBXmcpNqOdkyYysU
 GXcCgK3D6rTTTN4sz4KC3BjTs17m2IwF5fggv5Pc0t0OZQAnDaADI1EXhcQnK9oyLjkx6KRMldf
 g=
X-Google-Smtp-Source: AGHT+IHfeWbxDK0KuxneW8AHNstfbu3nF5BW8XeKK3EbvTMsLCF0Vn1jKPO8ZMKMBi9UfkXWYHBKzA==
X-Received: by 2002:a17:902:da4b:b0:234:d399:f948 with SMTP id
 d9443c01a7336-23e2572fe5bmr243964085ad.33.1753156588592; 
 Mon, 21 Jul 2025 20:56:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e2d86sm67075365ad.3.2025.07.21.20.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 20:56:28 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:56:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] app/testpmd: fix set cores list string size
Message-ID: <20250721205626.2a919132@hermes.local>
In-Reply-To: <20250708125159.2457578-1-huangdengdui@huawei.com>
References: <20250708125159.2457578-1-huangdengdui@huawei.com>
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

On Tue, 8 Jul 2025 20:51:59 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> The cmdline_fixed_string_t has a length of only 128, which will
> become insufficient when there are many cores, so it should be
> replaced with a cmdline_multi_string_t of larger capacity.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>

Queued to next-net for 25.11
