Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BD2CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 16:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C458441140;
	Thu, 16 Oct 2025 18:16:00 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id CECD34026D
 for <dev@dpdk.org>; Thu, 16 Oct 2025 18:15:59 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2681660d604so12307315ad.0
 for <dev@dpdk.org>; Thu, 16 Oct 2025 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760631359;
 x=1761236159; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMqUODv6UzUhScGw438aaW02kV30MusyeuEXCT+nXbM=;
 b=vu9eW7xz62EmZVd2M3+HaqPFtsFXrYm8ZfdICA3xwvpieq7x4rg0W1Bvq3HeO5zwV6
 C/C1vpGDzQDSEc+IwNvyjsLu7edahwr0s7/jgqpiwk68sL6soJgyd8ZmHHSde1NvEjQQ
 innSqVjxw+wyhjGFUBio+1WsOo6kUD/uBAx6YG5wmEpoaoIUMFgSgELSPc/1YGDSZYt/
 5fEht32oT92DySOnp/cNVJmfhbKY0iFTLioI343CvtjMSCII2zy1XjYnkMci3ATChPVd
 r4nqQAvwRaqncZ8BSpMmIE6vvFOSDvA8QwaVyT9IQe2Fxs5BUKyGDwOKVk8yKiUku7I/
 gz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760631359; x=1761236159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMqUODv6UzUhScGw438aaW02kV30MusyeuEXCT+nXbM=;
 b=X+88HJP23gBYJMtCFjNC/JYEXor96cHTk7niZIjQxxMl2D+8D17LTV3BQ6UmUwQqlg
 2TmN/9uekK7M0xpTBNzG1OkDyvOmhRsTaCHEzvOtJ1PQbdZkQ94JKLCEEuAc7xz+WbMH
 YBW88eQG0uyh+sjZwg0sxX2RqDM+5LRgyvJS6Xuryt8mO4bfuJhovn9ngiCrChlOPT2i
 Cvl47Q1emWP20ioY+AaeUQ2qMTw+Mbf6lqWqJvmD/oGATRg9nyeB4G00fqGBdJa/XEan
 MYxjPKQtkIt+sLHVjzRlyBvBR1ukoREff6xyVwZIgCSgtk/J9VuGiWhVr1yef+iX9dXw
 u3jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULUMfZyj6mzZGNixVIFvaYAlYneuknQRhSR7DzWp/fBdtx08ruRyM0LdE1/Qd8t17PUMs=@dpdk.org
X-Gm-Message-State: AOJu0Yzoi4/zFrY5Up8C6CgrRlXqNwXt1S/QZ8DAT5B75tW5b+FAzHfC
 YPATH3UzLTLKDnCFx/skybnLa1sLt+3SdZesX2nOCa0ptLoI372MPU3eXT0hXydo2H0=
X-Gm-Gg: ASbGncsWO0jlvhCQExaT2uWFAlhW3s+a+MqXKgf0bYiSXDLqcxGY9m9FBCesjFAaK2j
 0eIwEjjGhy5+wkQojHcsg00ZhZ4PQ6pneQ98sFqvtJTC6YwIR6KnByRsagnlNqaqn5bcbcBvwEy
 dfQ4000PCFrXJsKya7nEtDd/BjWZcZLe6qti5vGdd7vsrKZJc5GnGMGquFPU+p/SsGv3TsbggkT
 m1WMivt9LigsvWiCpsQzYjv4DCDqavYyyBFbCVfsjFsx7AZj/Z9lvNwQp0pybbGoqyEuCSmtqgR
 o8UKCifTqCA67LG6mWS2bcREpJ4BJzyzayDmD5e3+quqxkNsOsZHBKdlT64MG0XECUymVLOwPng
 VS4EEddzAL2qQvufCxjdcZiOKMctl3NT1kaCx9BwkiS0zdKvbeCQR2zJ//ul5pSjd1mLpm2/A3v
 Q9tECpl8AXRoBaN7FBPicjb1gLgDeKPv2cyW78XNqo0DR075JmnPWFfTFzygeV7ug=
X-Google-Smtp-Source: AGHT+IHl5kyqZ30pmXs9nDqlC6/E+beXJMWLSUeGVz79q+scw/42J5oZnBKQhYtWABRcDpGdUv3HFQ==
X-Received: by 2002:a17:902:db0b:b0:24c:d6c6:c656 with SMTP id
 d9443c01a7336-290c9c8a84bmr5928135ad.4.1760631358955; 
 Thu, 16 Oct 2025 09:15:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm34946175ad.65.2025.10.16.09.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 09:15:58 -0700 (PDT)
Date: Thu, 16 Oct 2025 09:15:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1] net/zxdh: support multiple PF process flow table
Message-ID: <20251016091556.05c370d9@hermes.local>
In-Reply-To: <20250924082331.39962-1-zhang.tianhao2@zte.com.cn>
References: <20250924082331.39962-1-zhang.tianhao2@zte.com.cn>
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

On Wed, 24 Sep 2025 16:23:31 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> Support multiple PF process flow table.
> 
> Signed-off-by: Tianhao Zhang <zhang.tianhao2@zte.com.cn>

Your email is not in .mailmap which we keep up to date in DPDK.
Can I add that when merging?
