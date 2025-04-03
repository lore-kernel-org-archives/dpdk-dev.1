Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0779EC36014
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 01:42:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02C504029A;
	Thu,  3 Apr 2025 03:42:29 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 69B454014F
 for <dev@dpdk.org>; Thu,  3 Apr 2025 03:42:28 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso439974b3a.0
 for <dev@dpdk.org>; Wed, 02 Apr 2025 18:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743644547;
 x=1744249347; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPOcit8qM2SBUxEl6PFkxtU5onvUfUV9sJ/fyUqyIfw=;
 b=VnaVgtftrbw9MDEs3c6xmnkrgNirl06tdIWJMJZAQNa0/cNE1G1A2eAbkSeJXHDpiU
 9DACCQYxFFLVL4ns53BmbFFHuWZAuI0WKYWHJt625ZVE1tVK1EZGOB8PoJ0Um8bCbto7
 uRmzJvPs007PmVwHdci62JKlkgUzeyCAXUU7DWddTggCnNj3NHshoLrSXoo8W4ftg3kZ
 8s3f8e8MlfqbmUqmPeNVrSMx3lK7lATOE92stv7z5fglBnehlYr+4zU2ZNiDYDRLmX6y
 L3E1+lP/3kQkMkoO6mzC5IvCTIqEdvQSrXILox777QarmKkt9qPqd9bBjLfXU32Ukcm0
 jssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743644547; x=1744249347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPOcit8qM2SBUxEl6PFkxtU5onvUfUV9sJ/fyUqyIfw=;
 b=RxHiH3EpGe+w6mcuguAWOf8WMn2Z2vp1G5utZHLpS14s4LeZZBdFdfQgx3dbh+S6kE
 iVfA+dSWP8NUcR809N9hv3XGAYPkJPOw8iN9FP17ZAqvtqZmMZ38ed29gCpqWHbVlfyo
 Jy9V64Zr/d+djyGWVvJy7JoALkLVghZ9F4/tg8g6sZHtyD6h9XSLW/JCymA60c+dcZjs
 axZdU9m+XUMB+3jOFhta8KeAmrcDf68UlcPLxkYsNoGsQ95sXfv7d4pwoFbrHhuvVKiy
 LVw6yvAP7g3gLYnht9wemrC0ndhe+TmmLKJoOI2UG/yEX1B4wYbzEJbLRl0lwOQjrAMg
 LTfw==
X-Gm-Message-State: AOJu0Yz8k/d9drfFdWonXRBIjHVQfwsw0JxHwwm9QXy2RCzNS0+bSmyJ
 14A2MRFtFlm9Deeb+rox9YxejIRsLS+CFyWvZMdtCF/z/QVwmPFH3ti3sLg/U0JqVotanFDH00+
 c
X-Gm-Gg: ASbGncsjVRMXAZ1bKoSa+RpfSjTtoY/owlh4+LfjlftUlj+BKh2GiKZAIxSbRK+JPFD
 +p+9uPA8j+5mhfCcp+IK8NY4u8WLOVHk1PizyQU60ywiJS07AnyTfvXOEo5qKVLquW76MaCTnUM
 igX8dIPK95syg26Kb6hMxmrlDrO7eoyFN1dYRe0vHxLjjhIAQLK/u9GrHg4S4WraWl2VEt73OcH
 uXXOukesEnDvCAW1Z4CqDW199I5XFKXFhOJert6mHMl64ltCeuVtI3H8+r9o87szKKS4fzFrK1Y
 f+IR9SXfcWsz9t2ffB2XZ7PRo9pbUdZsuKzzoyptcbalpibqS5dde9TqUHWbcnk6t9OwR7bvNFI
 +XgzDFeRnMqztUuQbzioo9UyjvbKAjRA=
X-Google-Smtp-Source: AGHT+IETpycscv06uhMO6wetmyoUQ0ow8iYjDYmvOwbmTRMNjMoIlUG6B+ppf2K9i0UXhLynYfd4jg==
X-Received: by 2002:a05:6a00:22c2:b0:736:55ec:ea94 with SMTP id
 d2e1a72fcca58-739c7965b8amr6392595b3a.20.1743644545406; 
 Wed, 02 Apr 2025 18:42:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9806f87sm227722b3a.80.2025.04.02.18.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 18:42:25 -0700 (PDT)
Date: Wed, 2 Apr 2025 18:42:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 1/4] usertools/dpdk-devbind: add bind/unbind for
 platform device
Message-ID: <20250402184208.389d8df5@hermes.local>
In-Reply-To: <1743577112-119739-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577112-119739-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed,  2 Apr 2025 06:58:32 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> This patch mainly adds functions for bind and unbind platform devices,
> such as bind_platform_one and unbind_platform_one.
> 
> Signed-off-by: liwencheng <liwencheng@phytium.com.cn>

Please add your name and email to .mailmap
