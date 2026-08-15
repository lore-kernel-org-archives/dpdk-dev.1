Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C861C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Aug 2026 15:44:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B556E40278;
	Sat, 15 Aug 2026 17:44:40 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id F045E40272
 for <dev@dpdk.org>; Sat, 15 Aug 2026 17:44:38 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cf452def93so24433295ad.1
 for <dev@dpdk.org>; Sat, 15 Aug 2026 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786808678;
 x=1787413478; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B1OzVeXPpDdJZr3hoHJ2QBVqY2M2AgRk750kBbr92B8=;
 b=R2XhFzytijFZyX2nPd+YpM7T2n0gfI87e5yMGVy9CN+n9e4oCmNWN38uPOdqD1aXY6
 X7Pu4/zo9bUhrsM2NL2odALFohGMjCLV+Q3iCCz3zdQTaMMU9Mf/QqacglfRUZN4UmLD
 o9+KUc98FUYLo4AgMbuZlgFIDG/xoKn/De6I60Oh8JzU6NJD4kuUHAAHA/k4lrUR4GQ6
 UUPqk7BA7KadiVtv1Eis9cH8h90XjtiipM9jh4i42QI7gL4yahtVqQtNGl9yuPq2MZXg
 6YtOZ/zEXmWY6rVdWJaQHD7lujqfXTbheTbTgwfxIMjubosXdH19eVwGM0MWpC+7f4mV
 u4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786808678; x=1787413478;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B1OzVeXPpDdJZr3hoHJ2QBVqY2M2AgRk750kBbr92B8=;
 b=WdXIj3rmw8xtBTITX47prX9W6QBcoLsyLO0cF4eEzCq1Oh4NK6lxKBTRl90v0V6q90
 6sF75yA9hDf8Nadj+xVR/8ARZZqF72uUZa55q1upzte4xQfMpTf9CaDfLHBXMcxbQ4/L
 FNslEc58RBRrS+t2rYnQXtxsrW04AeOUz7vvz/MpmKf2OJ552eX5Bil+jLK/dfXzzZB3
 ziUueJNTvUKf8u2ijxZQURf6vL6P7e6CJIftLMXb40AGO8F68veQsjFgOQbbnZsMnOWr
 zSvATglUQWPDP/KrMXRe+Yp0jJkpdZyLXxt7jO6aNKGtgXrXpKsUrnfNX35x5dqsLY4Y
 vgEw==
X-Gm-Message-State: AOJu0Yyy7cMVTWjuVYEPJbVe2utpH6slubZE6wT6+V+kuPJGUBWKIXVA
 WjtpSSzWq2xkRELQjMbhm0rptcbNF5RQOs10p5CpqkYB2pkCmRiX8JKsiAvYk9QWlT8=
X-Gm-Gg: AR+sD10WN6on0r7d+IxmrO2zDGlfaYKjJksSu3T2ruUVznqGuK7B3J8cGYdUkXp+aHi
 BU14QsvFNDuQhcUc3FVt2P7aAKDdANkobXzywrl0q5kEk0bVkHSaayoYX/aUtZrf5abiugYUCiG
 X7esnT4DPy5RREoHTA7KQGWmDCdYyANmowjWzRrYk2qf42qt+PprCJQt0zIf1n1bHlMGcMQI47X
 /KUuk4wZHCc0xpAvUZaUvm7wDlfI18UC5XpW2404lAHoLOliq73j5E/whC5cq26lPMMYsQ7Ltdf
 CU+YZATAJGtrWWIAwjeNo+S28MvVIuYdp7uZ4NKfk44LGwToND8BNkwJqggPcIDp8ij1DzzSujy
 GW5QREkpYSIhv2mCHJYVwlajEoaBOGi5rJXLwJC1hPgA3He5nEV5weFMRrJ16BWWcw4zA6V4YEE
 3FPdKVwYE669W4+m7uS55h251I4m+c/OaUi+Ep9WZh5vSYhnkVuDGj7R6JnMT/dg2jA8Ut/c9Pr
 xE1AJ+fQHeVnNFs45pMpOFTbW46lOwO0+cXNUSX
X-Received: by 2002:a17:903:28f:b0:2cc:db7a:251 with SMTP id
 d9443c01a7336-2d37f5cdcebmr223960565ad.2.1786808677969; 
 Sat, 15 Aug 2026 08:44:37 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320d5bd9fd3sm16200855eec.4.2026.08.15.08.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 08:44:37 -0700 (PDT)
Date: Sat, 15 Aug 2026 08:44:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, Viacheslav
 Galaktionov <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 00/14] common/sfc_efx/base: fix code analysis issues
Message-ID: <20260815084427.0bfc0aa6@phoenix.local>
In-Reply-To: <20260814125438.13283-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125438.13283-1-ivan.malov@arknetworks.am>
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

On Fri, 14 Aug 2026 16:54:24 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> This series addresses code analysis defects in the
> common/sfc_efx/base library.
> 
> The first four patches fix excessive stack consumption in
> MCDI helper functions, each exceeding 1 KB on-stack, by
> switching to heap-allocated payload buffers.
> 
> The remaining ten patches correct SAL annotations, add
> assertions and bounds checks across netport and filter
> helpers to address uninitialised memory, buffer overrun,
> and potential dereference issues. The final patch widens
> loop variable types to address a CodeQL warning.
> 
> 
> v3:
> 
> - addressed https://mails.dpdk.org/archives/dev/2026-August/343201.html
>   -- patches 01-04: switched to EFX_MCDI_BUF_SIZE
>   -- patch 05: replaced the unreachable NULL guard with
>      EFSYS_ASSERT; corrected the commit message
>   -- patches 09, 13: moved __success to the declaration line
>   -- patch 11: added stride and count bounds check before the loop
>   -- patch 13: documented the TECH_AUTO default behaviour


This all looks good, applied to next-net.
Still going through the later patches.
