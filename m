Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74322C282EC
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 15:37:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D06DE4114B;
	Thu, 13 Mar 2025 16:37:40 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id D648540ED3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 16:37:38 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2239aa5da08so23111165ad.3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741880258;
 x=1742485058; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zg6xiH9I8qG7xl7KWuK99Cy++dAkBhaeETjjxNc7MYY=;
 b=DlWotDiJaGdAkVHARU0/+yMpXgUKTCtYo+Lt2K4RhB3iby+2CaIEDOoXam4cbo201Z
 o6bDp/Z5gAlBKKQY1aCSzhAHL/bRVWVCAcu92Uz8hFJwv6/bmZHwz0g66UqNYhLikSdF
 4220UlC5Pq3Lo6k5mLLvt0dEe22XMBapoidpiz91Px9uNbp7Ts2ixfzRMpMDv+qOPhCm
 e6XC7rm+zDHIInVL5Ci324IQYsLWBorlDUtBMaxwzYmNChlKUeQnNZFE/K5iaM9SCsMy
 wHFFCaQBSMsuCd/IOvGQibNUdJHdP67UI8mnc18kK95mGKacHVWasr/1bg192JUk1qrG
 UVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741880258; x=1742485058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zg6xiH9I8qG7xl7KWuK99Cy++dAkBhaeETjjxNc7MYY=;
 b=Y98ALlSCywgyMO1KqEyMjFhdjsshoTjQFN2/jL/xCLHB4xW6+fiFSl/tDWGT+wGQsU
 mSKk9tpd6LAXHBTh1XDDBa9F2gHM3U4noQkKEqhWUv/we0WRcS/exyvU879XeqfcF27m
 3f0Vy3Y1nId/u5t4kI6sdqzG3+tt7ml08L/Y/6boXcQ+nTwRtUUVzGJYdutWVgDpOiue
 NtWULDapWjrXPITMmXbT8F3rDQo84u4WGo4h823gmpBDxxPysImQU++oilUzlBRKhJJm
 WugKQZ72dHa1TPpiMnf4nQnI07UdQjJ5vtANUyuHnswdvIqQ9fNoKOBpKkR/QJu4pZkL
 pbQg==
X-Gm-Message-State: AOJu0YxNklBEP6ONhQvFV/GhKdvcqv6j2bYXr4ZRAA8UGcUgP8q67JrG
 y4M8XeV3/xknn7rXR7zfzfd0aW27OJ/9LL1Ry11MPnkJ63t5NIGCPXPK8NgeSrk=
X-Gm-Gg: ASbGncuny9TmpAueFitH6hDg/mDUG9p9ucVccPRjnyyYIp+2dhExxDW6/YKhXcGKo3s
 O6CBA9D6w9QXyRcEwjGCSXwr35Npahy43NF+y3mfmPYqJvBCQ6rtpvgSHG0/Be0estmHXhS+oKu
 MjEIUVMSUmeL+wMIC9Yq5whSj1z2MBgH7NkjtJABUnplj41Po/XQ9Wtobw4+OFF+pdpFKaZHpyf
 6KcvpiryQspaY7dSq0qzxrLiqwYqfaAFGbW/X2aNXFBIXgpdEaBUH65+p42NIIh1Q9P74Kew3nG
 uyFoa1qYDOT5qul6PMtHKZ2GksMXdg9OxBfXYCooKNzmAuWi4fxW53qtaQN80n+V3UPaw6fXVEs
 se2p7VNC8GnFFIHbs4RybQA==
X-Google-Smtp-Source: AGHT+IFk+4ZaEypK0QhRpZ+aNvK977ME7WyS1scBZMXRt6aa151P3ktsUXKCXV1ydG6gCrwbLVt6zA==
X-Received: by 2002:a17:903:3d0f:b0:223:f9a4:3fa8 with SMTP id
 d9443c01a7336-225dd874712mr24025ad.19.1741880257816; 
 Thu, 13 Mar 2025 08:37:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd53b5sm14618045ad.241.2025.03.13.08.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 08:37:37 -0700 (PDT)
Date: Thu, 13 Mar 2025 08:37:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] eal/linux: improve ASLR check
Message-ID: <20250313083733.203d132c@hermes.local>
In-Reply-To: <20250313061904.1466-1-ming.1.yang@nokia-sbell.com>
References: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
 <20250313061904.1466-1-ming.1.yang@nokia-sbell.com>
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

On Thu, 13 Mar 2025 14:19:03 +0800
Yang Ming <ming.1.yang@nokia-sbell.com> wrote:

> This change ensures that the current process is checked for
> being run with 'setarch' before verifying the value of
> '/proc/sys/kernel/randomize_va_space'. The '-R' or
> '--addr-no-randomize' parameter of the 'setarch' command is used
> to disable the randomization of the virtual address space.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
