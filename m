Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990AACA1002
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Sep 2025 17:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8366440269;
	Sat,  6 Sep 2025 19:37:14 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id CC4DE40261
 for <dev@dpdk.org>; Sat,  6 Sep 2025 19:37:12 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-45ddc7d5731so7157805e9.1
 for <dev@dpdk.org>; Sat, 06 Sep 2025 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757180232;
 x=1757785032; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wend+4fMW7DTTxPy5ubS2PGRxUwk4xgaLSz8TsPiSss=;
 b=DQSPBlFA0BLSkLdT3cHCHpdTc+rSzcamyR1hvEnveLtr5NUE5e8o2sBegBbL/9zyer
 8mbYyr5lEYXFbTkPfJk1LRUOpM4+4L+31JT6hhnJeZGtRrh2+x9ccTJnPoHXqa0pvpKp
 nQtHbJEY8GdOrPfGI5KlApmhT5dFnrSBDVJ6Sti2jQ/JETi2LR/KNvnydxUaPscvZ6x4
 P8k9VagF2durSWri/dem5SIgkcQDJXwd97aPB8ANlqg+yrdfDo7pPVqrhGLlm7snrbHw
 qUG/+EWAdJWZGkchdR048qg8jbOaG+GoD/L7BZIbtWVldZcVbKFVIlEom8zwKQ077mog
 luFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757180232; x=1757785032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wend+4fMW7DTTxPy5ubS2PGRxUwk4xgaLSz8TsPiSss=;
 b=KtwV24XTDFz4gukyOjDamXXjn026Mmtf/2yjDudWMtUow9WvktrchSJ1oN0Gpoo5Fn
 gXNz7IP+wFM2MOGGxGUaIcNgTAX19YKdMJd8I71kG858zzZdYGvmvtonVSd6zmQa796o
 aCRu4VZqdPyNCBi96vcF0U+M0zhS7bnWfcw+1WSjf0o4kL4NInCUxHxkwDdpIOFjDp+m
 o6XplElx0sQolTpOrIpd9X+gDwyCbHUhzRJDLyAjgJyRncjfRMa78Ha29dsxEt5rfzTq
 P6C66e4zwo6jj/C90O4aoyTXGT5U1W+w6Kmr8R3ERIbjQiayf5WhJELqSzoHH0Ho9c8s
 HIqw==
X-Gm-Message-State: AOJu0YzOeh6J3LSd57bsSyJwre3SHeIxxzpYiGcYU3LeMMkbR03bZjNW
 bHON33a6gEDPweqcxbPO8JhPtPB+ML7m6ZbLHYuhv32oGdnEMESD7oGM/ul00omGRgk=
X-Gm-Gg: ASbGnctOgs78xYMDLI67XI875Olfze9osok10/78qc2vnH3nOh/ErAICK6IOu4iKdM1
 JQHqry4d3gKIQaj2iwVcGC+9b9WJO3NI0uje+MoSYN19wJ9e03xPDgADkslL+kCUgf8KR8u4EIS
 ZiMcJiGhgxqfLtihDKtShMPlifn9E0aaVY7cYXRVhhnxCCBDlnsDR9bcqpFbKgVW7GSI6j9mtOh
 3utgc+rJkdyHHH8DlzRskkPOby0RlzthOaSDKKX+MBUWivziPRzHGf+qZPKHBjhUKslDf33o4kf
 hp44SQJd+GVTI/3p6iWZS9PkMuqqcseq8B3PD4z/1OzhjRXeagy1fXB7Y7XbSvrv+1ZmdmnnuX8
 tPbVM17VhWr3fgpHiEXPvSQbyB+afljvg7aOYRBTtczoiFZToeaiLHsyGWp020TLl/fl1sFAVh8
 akZZUOx/zgBQ==
X-Google-Smtp-Source: AGHT+IHOIk0UETSG4DdC2n1jtZZUlDiP7HaI9896AU0xu5azl4R3ukxS3uK0Vei2dthwHtmLoCGICw==
X-Received: by 2002:a05:600c:314b:b0:45d:e111:de7e with SMTP id
 5b1f17b1804b1-45de111df85mr14079955e9.19.1757180232145; 
 Sat, 06 Sep 2025 10:37:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9db4sm35496647f8f.47.2025.09.06.10.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Sep 2025 10:37:11 -0700 (PDT)
Date: Sat, 6 Sep 2025 10:37:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: luca.boccassi@gmail.com
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/zxdh: fix building check for arm64
Message-ID: <20250906103706.6c68b63c@hermes.local>
In-Reply-To: <20250904141059.54626-1-luca.boccassi@gmail.com>
References: <20250904141059.54626-1-luca.boccassi@gmail.com>
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

On Thu,  4 Sep 2025 15:10:44 +0100
luca.boccassi@gmail.com wrote:

> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> The comment and docs say this should be built on x86_64 and aarch64,
> but RTE_ARCH_64 is not aarch64, that's RTE_ARCH_ARM64, so fix it.
> 
> Also the check makes the build skip unless RTE_ARCH_X86_64 is true,
> so switch it to an 'and' instead of an 'or', to build on both arm64
> and x86_64, and skip elsewhere.
> 
> Fixes: 29e89288ff14 ("net/zxdh: add driver skeleton")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>

There already was a patch submitted and queued in next-net.
Your version is more succinct, it would be better to have one way of doing this
for all drivers.

commit 4916569f552ee881adbd54bf5446f1c06a607289
Author: Junlong Wang <wang.junlong1@zte.com.cn>
Date:   Thu Jul 10 18:56:38 2025 +0800

    net/zxdh: fix meson.build issues in compilation
    
    fix meson.build issues in compilation, which
    caused the inability to compile in the arm64 environment.
    
    Fixes: 29e89288ff14 ("net/zxdh: add driver skeleton")
    Cc: stable@dpdk.org
    
    Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
