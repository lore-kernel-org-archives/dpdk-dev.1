Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA9AC021A0
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 22:13:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEF6F40E0C;
	Tue, 11 Feb 2025 23:13:09 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id BF5D64027C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 23:13:08 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-21f6a47d617so63279275ad.2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 14:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739311988;
 x=1739916788; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlDp7xP7VJmxQm+r4dFFQjVW14l/du9giUaVKncf6iQ=;
 b=RdNdTnR7dxX8FW15YQnY/6NJZVfs0mSdv6/82aXxN2dQUemfNvcvhq+6WZpWVY2O9s
 2s1H7PIYcCGs/tlS+Kzd1NMTaiWjt4bZN4/7FjqvIszZqNAUn2lsWdipMxD5n/6+PWSu
 Q7gE3MHx6z1FHnOGoIwddsaD4SZMaYfDGu6ejxY0zXPAOS+NTRdy7OyDnbAefS4dTSke
 QfZ/+ArPjlIlVsIoaXUEdvnt10uVyibRuWVRQSqCrjDDbJWlhhnNOXXixwocFvLq54LQ
 +gWep+dKeOkbaDKiSmTVDarDrhDti20S+adxxB8gjyF28iFMoksgl2QLFLrJRkcLWUJZ
 lP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739311988; x=1739916788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlDp7xP7VJmxQm+r4dFFQjVW14l/du9giUaVKncf6iQ=;
 b=X/g3+bNuYxGAv2RUM87MbSCegtvSYO//X89Wln3c5Gpklz8U5qVu608WvPnqp9LGHj
 ImfabqnzvC/zNCHMJL6mNl0tolbD4p+nV5gpHlspSLjgBdKDpu+UOI1hxv1tvpuWefVY
 yENN8D6OLqW5eUX1/RykLHpGF2oItxH7rqMeKq4hHgvKxnIYyI3EjayiY3xCyh69/GEN
 oZbrHXswsDbWdmDz1cqXZOnirLF24WSl/kFYM7atbqFnvFZ0AA0gti+/+eQwXpXmqYBK
 24GAkVOljGfcI2vwKEF6IlMDgPRIC63cBGu/06Jo86uDzovxJg62eSrzqe70fSkWdezZ
 83hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTy5PP/DEVOKj+ESIUiYdmhAYSgCQRlzghXxVSWOufVGRKNBp14EQgBvmtQtDOE0+ng50=@dpdk.org
X-Gm-Message-State: AOJu0Yzt89Bpm9ZS838lYSzgDoEh6785OPpmJr5GG1t2dEuf0Z7r0YEI
 WYrvOOmsZubIFj1aRsyT5NRAfsxCalTUz6LJlI2LjNkyAMjv02/Yf8bn3WJzgbZwgw92lZbSWR5
 a
X-Gm-Gg: ASbGncuF/iVQG9Kbgna8mQZBFHr+RX61Qn43JJaE8aWAZD50eRpVAXims98/nQ8B3I+
 QVg09LTgqbSULCI8zuYh5D+tlTKzrd+8rGrvAWDZ0B+VbrMvKbZi1hgFw6N01+KcVu9qDCtPVt/
 QBQnr2erp8phsi0FiqSyPLR2SRbM8qsVi/0kbLxjJJK2F9uDaW6xYrQSrwRaMY957RwEhpeFUTT
 YhrBk07mMeSBtLFLRNEFlmyTxEIeo7+xkpusohN8YzAVhBW09/qkuDbF4ftvdztsPSVTwpsNEzR
 PrHG3iD7gpUM41M2mCwf/tRkEIzYl7OeREE8JluxwaPXS2K5RopXp/Qsmei7Od53EiQ3
X-Google-Smtp-Source: AGHT+IHBa47TYs8xWadwWj+VSNOSosDgLisrJwWXTggZwMXkQ66mFcG1KGgaVeu9Wv3sKfjTvSqu3w==
X-Received: by 2002:a17:902:f708:b0:21f:4144:a071 with SMTP id
 d9443c01a7336-220bbc8b737mr15913035ad.40.1739311987545; 
 Tue, 11 Feb 2025 14:13:07 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683db25sm100302805ad.134.2025.02.11.14.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:13:07 -0800 (PST)
Date: Tue, 11 Feb 2025 14:13:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH 09/10] test: add workaround for __builtin_constant_p in
 test_memcpy_perf
Message-ID: <20250211141305.0a46a1cb@hermes.local>
In-Reply-To: <1739311325-14425-10-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739311325-14425-10-git-send-email-andremue@linux.microsoft.com>
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

On Tue, 11 Feb 2025 14:02:05 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> There's no MSVC equivalent for compiler extension __builtin_constant_p,
> so a workaround is needed.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Prefer that __rte_constant worked on all platforms,
but template code is hard to maintain.
