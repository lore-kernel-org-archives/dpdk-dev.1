Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12563C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 21:44:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 213924026D;
	Thu, 20 Feb 2025 22:44:33 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id F3E8D40263
 for <dev@dpdk.org>; Thu, 20 Feb 2025 22:44:31 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-220d398bea9so21245525ad.3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 13:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740087871;
 x=1740692671; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPQRfik+InbsADUZBmSCiqIwymUNZRM+wn9bwFIRTZ4=;
 b=sQSc9FADQBUEnrnWrLcQRnNRaQXX7aL/hwdCugzhVCG8MOHrBB0LCUIvvLhSPG77/H
 FDqSJNVqLDWZfX0IZX0ImPcB1/r61ifwVTPA2ht8cDUL6mZKS0zkcYyJD8k2S6r6kg0Y
 mbm5Mj/sYgFuKRixBGdIyVz6QUFBpA4vFD1fYlSMQGn6CeHCWRuFUS8YfW84ipXysbKU
 PP1Mu5OZrEBMNxj/EAB1MBIOfR7sX15pVYSN05BgvQAM6Y+/Uxg7Apk9yNCdjlyF1bDl
 8LPNEEBoHyq+Hr8tuWkDAujUkMnNxkqck/xAmfRufd/M35rXlZNCwxGOFgwD8Cv/Py3v
 C39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740087871; x=1740692671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPQRfik+InbsADUZBmSCiqIwymUNZRM+wn9bwFIRTZ4=;
 b=TbGf3Frh6jxVGxy5vG8AT4VPZ5uknGaHk8fEAEkCPGMllWZy9+iMctugl0Xx/rgmrx
 tAtZj7dMwv6lull8KvykF2SlICP+78JHfH1u90stb9wEqN2v8SPllovsu3x79B2WIkXd
 rkbWXSKVAuKDyjls9K7AwAxusiYembcjvJFzLF2J5Bng2QSl4ogpxbnckOnktCwRBp+m
 dWV23Kqw7EY4qGLOCSjVtUQ8zHlKiXuY7VzFeXfpmUN8EsLOv8J/SxLt7P23o657JVB5
 nqv7IKU9Pw0QWRlMufdl2sOvONFCQPFlKgugJKhV2+O7wbN8iRPW7YCTkpIKatqEX1YR
 9pTg==
X-Gm-Message-State: AOJu0Ywhfow6zSvaYZrAPC5y6mhjLOWcvtLoquBKRUBu9TUepY97Mbnx
 XF76+aW2Rsg+snhb5LL4liJPltGeRXd5NpgSqqetlk4HWeseZzTKyiYrG8fGoPo=
X-Gm-Gg: ASbGncvuoJqOEaAgdHeFldqMZ9k5mheiUnHBEIOwdbR7AcGOvzosYYUmVpUYYEWnqQs
 DZrjPI7D8/dSIzPn+qnuWRdJukbM5+G5MPj+j/jHHiXZ3lMrrmwCaAcWqPbWtALpl8dI49brtr0
 yqynQaSmLFNTHhDeC5nmlOZXOgaNe7c5AcQAgD/ajK9vF0NsLgh/r7NIQfjotEE33UdfZqacjn0
 BpcaJ6kD3f14MaU3g4o8Vuz03AZOApmHyNWtffR3lBsj/HdZ35p3X03liEfRW3InkI/6hJxVqp5
 EQ2ecOZeJeN6oj+Q1IfHNQOOmSXS0sibUcQSki6Fak3ARfzl1rGJaDxtN4OeQ6REJ95K
X-Google-Smtp-Source: AGHT+IEScxalVdD6yHc5RXTpJPLFRPoopLxuXTbrW8F93oddU4ksX2yiIedT92Z+a8CdssHYbuclXg==
X-Received: by 2002:a17:90b:5202:b0:2fa:b8e:3d26 with SMTP id
 98e67ed59e1d1-2fce875bd28mr481806a91.30.1740087871025; 
 Thu, 20 Feb 2025 13:44:31 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc0ca14c04sm14841475a91.33.2025.02.20.13.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 13:44:30 -0800 (PST)
Date: Thu, 20 Feb 2025 13:44:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 00/10] enable "app" to be compiled with MSVC
Message-ID: <20250220134427.61f8449c@hermes.local>
In-Reply-To: <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740087064-18680-1-git-send-email-andremue@linux.microsoft.com>
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

On Thu, 20 Feb 2025 13:30:54 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> v4:
> - add explanation about the expression used in __rte_constant during v3.
> 
> v3:
> - use clever expression with _Generic for __rte_constant and use it
>   where __builtin_constant_p was being used.
> - use %u in csumonly.c and just cast variables to unsigned int.
> 
> v2:
> - use lcore_count as atomic always, not only when RTE_USE_C11_MEM_MODEL
>   is set.
> - use PRIu64 in csumonly.c instead of casting variables to int.
> 
> This series fixes many issues that prevent the "app" directory
> from being compiled with MSVC.
> 
> Andre Muezerie (10):
>   eal: add workaround for __builtin_constant_p
>   test_alarm: avoid warning about different qualifiers
>   test-pmd: fix printf format string mismatch
>   test-pmd: do explicit 64-bit shift to avoid implicit conversion
>   test-pmd: avoid undefined behavior
>   test-pmd: avoid non-constant initializer
>   test-pmd: don't return value from void function
>   test-pmd: declare lcore_count atomic
>   test: add workaround for __builtin_constant_p in test_memcpy_perf
>   app: enable app directory to be compiled with MSVC
> 
>  app/meson.build                     |  4 ---
>  app/test-pmd/cmdline.c              | 16 +++++----
>  app/test-pmd/cmdline_flow.c         | 22 ++++++------
>  app/test-pmd/csumonly.c             | 23 ++++++------
>  app/test-pmd/meson.build            |  1 -
>  app/test-pmd/testpmd.c              |  2 +-
>  app/test-pmd/testpmd.h              |  2 ++
>  app/test-pmd/util.c                 |  2 +-
>  app/test/test_alarm.c               | 12 +++----
>  app/test/test_memcpy_perf.c         | 54 ++++++++++++++---------------
>  app/test/test_ring_perf.c           |  6 +---
>  lib/eal/include/generic/rte_pause.h |  2 +-
>  lib/eal/include/rte_common.h        | 34 +++++++++++++++++-
>  13 files changed, 105 insertions(+), 75 deletions(-)
> 
> --
> 2.48.1.vfs.0.0
> 

Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>
