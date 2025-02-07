Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3264C02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 19:02:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F41A42EEE;
	Fri,  7 Feb 2025 20:02:02 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 339BF42EEB
 for <dev@dpdk.org>; Fri,  7 Feb 2025 20:02:00 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21ddab8800bso35587645ad.3
 for <dev@dpdk.org>; Fri, 07 Feb 2025 11:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738954919;
 x=1739559719; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+g79xyhQ5J1QZDig7S7K4RCQCKXSDeWXRPTD7o4plV8=;
 b=3dNhZ+xlqc3bAjPnODkcVlGD+c8AxVdQ531xe0ufmoL++mC7AiUw3uGbEx43IGTONL
 yvm6IxWpBxDBuk025WRQclcU6mtL/DzFOzWwKixkSmLj8uf4ksZT1LuGvaE/FNsDtbhc
 7koXv4nBmyBwbfNQR88t+yZY3fNhJR74MfTuhw52oSCcqdMzsGOHbrIrKiDLZmAuHcrv
 2U5WwZW+XELTYH6iI6beXQcIs2KqvezQmKHBq1hd9cxhhAiOx1qbw80J1mqtHBEXxz4Y
 Vu/xddGhtNYJg3dhTJO9XuKvYvB8HuFtr1usz7sBfswR6tedozi2D41wslbx6L4lsVKl
 GCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738954919; x=1739559719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+g79xyhQ5J1QZDig7S7K4RCQCKXSDeWXRPTD7o4plV8=;
 b=uftlJ8hvmT6FcyPCv08rtv1x+yQpVsrKbuJ4UmeQEEzp3RKOmr+VpmOtuq/OEG2bPE
 SjFQwwaQSC2Qz7dLqHZOmwbQeqAV/Oo59nBBcyss7f7Bork1MtMWT7oafo+YViW1iw6+
 f85YEIKr4uwfMTrl+BMHFNvFNjaNtu7qNzEqgyK9Z4RZqYJsd6Fex4UK3uxKrR0EQvfK
 ERewsC8A6MGccGPAv/tKVRtiDD2v0INW4UmQHlDoBQ4y9V1W1caQw+Ew3T46wGkJtE4d
 v41d/i9k6hPcNHVwj5i5Ups7XyDhyApSAqJxwxtPZ2sTxgAAZ5AlhkyqUIY0wb1rVVkc
 k15w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsRnFutSaCLbHJalwR0f+UyVjv1fhAq2hc93aPZ+gDJa8mrf7J6dmWDVSEmcesxLGkPRA=@dpdk.org
X-Gm-Message-State: AOJu0YxJHJPL+883G6dvyMeiUi4iolyG+/JWjFPgGA0W1/ZSTP7k3Qm9
 NwUIz+eJRp8pkbHkI1CR1wwH4c+v6Z1lHaADwd8VwWUGy8ZlHjiTWPLJU5G4ZEw=
X-Gm-Gg: ASbGncsB1uVfPopWWqzVNQehlzYb5wXvmfAkW7U2czT0KLqkj9GYigr9YYfy1by6AZb
 GhYbw4ixW8YErq66WcojEoWbOmyyVHtgYv2S2nZbbbcmOdasUCfqtmQgbQ2KZ3ejiNfzMKSJfAp
 xj6pHr/a2ScrjBfpoJlclq6BeB3KISRiSnoPTkApFXRpJxJmIgxLTzpY5ueL5lmx8ARkf6SZwDZ
 DxY2/Fv30PCC0a3ShJ2ZO/TOOrA0fz5TlLoUlm1+TeyhZIEt4mM1Rx1O8M/TZPBl0OF6S0Cy/d4
 ZzETGGhqdOqna3CxRRbn1BwauEAap8vXbx1vLeXxH2/jiLPo33LN7WiMJ+DUN4mwtalS
X-Google-Smtp-Source: AGHT+IGwfjxDIKL6+bOz9DQEgSnKBnrwd0uTSBR9xlllXjM9qL3oj2+2qTl4v932gle+/Fnz8MThAA==
X-Received: by 2002:a05:6a00:2e09:b0:724:f86e:e3d9 with SMTP id
 d2e1a72fcca58-7305d492d87mr7873642b3a.14.1738954919309; 
 Fri, 07 Feb 2025 11:01:59 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048bf14ebsm3386597b3a.104.2025.02.07.11.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 11:01:59 -0800 (PST)
Date: Fri, 7 Feb 2025 11:01:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: anatoly.burakov@intel.com, bruce.richardson@intel.com, dev@dpdk.org,
 ian.stokes@intel.com, jochen.behrens@broadcom.com,
 vladimir.medvedkin@intel.com
Subject: Re: [PATCH v5 0/1] use 64-bit shift, avoid signed/unsigned mismatch
Message-ID: <20250207110157.1283d121@hermes.local>
In-Reply-To: <1738950069-21059-1-git-send-email-andremue@linux.microsoft.com>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
 <1738950069-21059-1-git-send-email-andremue@linux.microsoft.com>
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

On Fri,  7 Feb 2025 09:41:08 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> This patch avoids warnings like the ones below emitted by MSVC:
> 
> 1)
> ../drivers/net/ice/base/ice_flg_rd.c(71): warning C4334: '<<':
>     result of 32-bit shift implicitly converted to 64 bits
>     (was 64-bit shift intended?)
> 
> 2)
> ../drivers/net/ice/ice_dcf_sched.c(177): warning C4018: '>=':
>     signed/unsigned mismatch
> 
> The fix for (1) is to use 64-bit shifting when appropriate
> (according to what the result is used for).
> 
> The fix for (2) is to explicitly cast the variables used in the
> comparison.
> 
> v5:
>  * rebase
>  * use uint32_t instead of uint32, to better conform to DPDK standards
>  * rename variable rqID to rq_id to better conform to DPDK standards
>    and avoid checkpatch warning
>  * use 2U instead of (uint32)2, which is shorter
>  * simplify expression in meson.build using compiler id "gcc"
> 
> Andre Muezerie (1):
>   drivers/net: use 64-bit shift and avoid signed/unsigned mismatch
> 
>  drivers/net/intel/i40e/i40e_ethdev.c   | 22 +++++++++++-----------
>  drivers/net/intel/iavf/iavf_ethdev.c   |  2 +-
>  drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
>  drivers/net/intel/iavf/iavf_vchnl.c    |  2 +-
>  drivers/net/intel/ice/base/meson.build | 19 +++++++++++++------
>  drivers/net/intel/ice/ice_dcf_sched.c  |  2 +-
>  drivers/net/intel/ice/ice_ethdev.c     |  4 ++--
>  drivers/net/intel/ice/ice_rxtx.c       |  2 +-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c |  2 +-
>  9 files changed, 32 insertions(+), 25 deletions(-)


Since all intel, this should get picked up by next-intel
