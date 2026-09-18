Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF39C982DA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 16:19:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CE084279C;
	Fri, 18 Sep 2026 18:19:34 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 6598A40285
 for <dev@dpdk.org>; Fri, 18 Sep 2026 18:19:32 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747eb79f6so6772805ad.0
 for <dev@dpdk.org>; Fri, 18 Sep 2026 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789748371;
 x=1790353171; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RwvZ1M9OADA69iVv5baQWK3AA1kVRFNubhzCQuMPCcc=;
 b=Q5f3LK12+VxXP5s7JWo0OENb89BS5aC83tC83MrRDYis2tRb+Owvo2ZTHT9wDUW5sI
 9TXj3iK99B5H+6WALXnCCxmHmVp8hn0Kd+sH2X1HUYxLhaZwA5W8STOPlNCRb6V7IOOP
 5NX8Wry3NmEGsJNZ1PzuhOdsdJ6pX3s6dJy7nvHP87knJhGHleDfNPc3yrR4Xyvk2WRC
 GB58Z+xkYFjuqIg5HpRJ7MDB0gZtja24S5vdYczJshjIyTOLWX4bIhtVEjwAROLHxMRO
 2iQGBxgMqIKSuWU4zaV9dGfSGaHkZA+2XedLBEdnldjaXvBbXT08AscGK1Y3teEUtZKe
 OYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789748371; x=1790353171;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RwvZ1M9OADA69iVv5baQWK3AA1kVRFNubhzCQuMPCcc=;
 b=sTcSfy2Yy1fm5RIo9+SjHxMFTN+K3RO7M3/N0+Douf+fJTm+NiIgI52B4U8CYLK7eo
 z3u+w4VB0XyKeWxjuiKb+N3+LLTwGvOuTxSBe046aUZI0oIW6DvfLGzsGgbACqyAGG74
 xDYVlA4UvcNXkgkpUXUyB1gCd1TDLqR//0EXCKpnnukg8Ea8KGkLGAeRBsWE7QTI9QpA
 2J6tsVWPVW0Bg580nIhyr18QavNxF+L3Id08aZVkfd46qkDe3Zxef4bX7VJSjqGIGrja
 cXpYCk2BJrzEn+w+KkRKY9VaPoaMGPqJa8AlVE2o3xA1SCldc/aWPYogxcBfDv4L7ti5
 l86g==
X-Gm-Message-State: AFuF++n2wwS9fDKUYvT6lOKy9Clw2PYWcGWmKMEpXxDs9ABwpWsJedN6
 +DtwkpXapt40P3t4jqM1i2cT+skzCLMgDe/Ak6voV5LylPfU6LbDbDA6z0pjq/cLALw=
X-Gm-Gg: AYBFou38Zqu1yCRLF0f87w/3g9zWWDCyN73TOUHqUmV1vhvxnbtVi7vzSUB6uPOAyiu
 c2JEjflgA0Lj0F+31oGD1oQ1QneNK2Za2DcV9h2V8gxVQh20OX0+US9duhQNBUFXSJ5FVKTg3xr
 Ptq/0Ew14TwROUukfCKFnnUGt9Ge0FHlxk9HicEvUYIjt/CXZuHFUQULk2bjntvj8kVNKGieTRM
 zFezhILcAV/FrJqpp/Aq87vNPsHklIXKefWrs78yxkuypLFVQ111d9dxYSrDRKrIjN9sB1HXSPc
 L/mNLxZHcnd9XSNYbl4C2owDAaINrBceVDVbq0mqBr2fpp/iz1u98UZKe/pLXU7xTO21GDCLaTc
 9TpIW4Z0E+hochDj6r/65Kj7qE1WvmhZAPW1w+sqMNutzQRIjD3tfEmKQvtfr1arxx/0mk/onD9
 SZ7Sr35u4xozLVavcn6uzl7+7Cnb08/BD4yuW2L+ocjl2xBe/gVIUeyaNsM/5zT8Q2MfdZaGKJd
 2OEqLQ6mWJh2Z+HOjIsOWTGWcJLN+juQqEvdSHYUQYBmK4cWVI=
X-Received: by 2002:a17:903:1b03:b0:2dd:c0ff:e725 with SMTP id
 d9443c01a7336-2ddc0ffe981mr1666285ad.55.1789748371446; 
 Fri, 18 Sep 2026 09:19:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb754b3c0sm11334465ad.40.2026.09.18.09.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 09:19:31 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:19:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Randy L Tice <rtice@cisco.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3 1/1] eal: add API to get CPU socket ID
Message-ID: <20260918091929.47cce1fb@phoenix.local>
In-Reply-To: <20260916145516.3-2-rtice@cisco.com>
References: <20260915150507.3-1-rtice@cisco.com>
 <20260916145516.3-1-rtice@cisco.com>
 <20260916145516.3-2-rtice@cisco.com>
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

On Wed, 16 Sep 2026 10:55:16 -0400
Randy L Tice <rtice@cisco.com> wrote:

> Add experimental rte_cpu_socket_id() so applications can map an OS
> logical CPU ID to its NUMA socket without requiring an EAL lcore ID.
> 
> Existing public socket APIs depend on EAL lcore configuration or the
> calling thread's EAL state. They do not cover code that needs to look
> up topology by OS CPU ID, such as building socket memory policy.
> 
> Reuse the existing per-OS EAL CPU socket lookup internally, while
> keeping the eal_cpu_socket_id() helper private to EAL.
> 
> Signed-off-by: Randy L Tice <rtice@cisco.com>
> ---

Applied to next-net. Put the release note in the New Features section
