Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A13C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72C65402DC;
	Mon, 21 Jul 2025 17:34:29 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 8B50A40297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:34:27 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7e32c95775aso453733585a.3
 for <dev@dpdk.org>; Mon, 21 Jul 2025 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753112067;
 x=1753716867; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NIktGylL5It/UmwAnVsdx9VAoE0A5OQkzfQ5+2202Ug=;
 b=Cj6kSuyx8U4L6Prez9LMR9BPFmJwXSMdVoUb7vtZA4jTdkHMpyj07BxiRDGNkjRaQg
 rOi9PdqS+FzcvpVEmyEWnT6eqlyu6N1FbV+w3Q7Xq3bHUcmTLfTVOB2Umjvhbl3kT5jp
 yT+MVQif9173hXGYodVkk0Nk/dVU4LdY1EdbNtHRED/PVPLUvSHKuxZ4nwV34MlOTS+y
 2KA2uNU3sPo8q8AxJGhRNBZxgzEXDOwaz8fnjDJAg8rx5mJc9IHSx+OMwBfmpQXcaxR8
 RAr1TC/tMOjlNwcKF1tBSwAbqZOU/4ldIA5DygrEnj/+GyXyvgCy51Cy/q+mp3cB3YMI
 nwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753112067; x=1753716867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NIktGylL5It/UmwAnVsdx9VAoE0A5OQkzfQ5+2202Ug=;
 b=PdjpR8ibrpxDG0pFypfkM+fGm+rI19mhHbZxdkPmIbHWPVbX3VtC/kwv0O7H9h0D4r
 vHEJ3goH460cIhUunZYxAMoHuz/r/iikUqVFD46ACKvvcagybcOT545AACWTiRS+2MWn
 6h3R65obO3HUCiValS62Pk45kc29cWZXhh11fElkyxeM19PEOBw2fJ3kXmWh90bUkoZq
 F6Ow7YB5p4nr1RSHzeQEy5bTjwqw/hwb95ymS+JWltqUA35QiNrVco2NXxTugc2+5lgV
 X5q4evGO3OvdqTqCobmgW3qZZJSibjVyHmWFy5G+q+KO+96Zf3bGQ9mmf38CLgVhTl4C
 EdUA==
X-Gm-Message-State: AOJu0YymzfXXBdctCdLzELSKH4qKA37NONRNdOXCwrJ5LkDEapWGcKH3
 QgSC6u7bfOf3Ief5kK/87MQDs+xXs3GNLgNSZw2xj9y/Ha+2PspoOk+SX5roGmx1RoaF+8EZ7zW
 e7NpQ
X-Gm-Gg: ASbGncvZ72U2E1EXYLhtm0bJt5k7BhGRjxGgNvzfo+bebPng7wpIfA/Kdtev5Us1u4O
 vRnoqxbEuBUew+VkGHOZ+4tfMCC7h198PS7+Tf+5OuWnI2SHtzyOnJ1KJnSQacauO5RVjWyjZCg
 YE1QhFPrlJpwz04zwRh4iDpJfIRx2beeT1cIZ/52kwoGiDWlG8zQkJ/1iJNi1L0Eng1zXihHaXG
 wh7Wwyhph4Lpk05IukyITvJp+ZmBc+xKyeMlBGBvD0K4fJPXG23CZV11yaAFNWJIw4z731KSAWa
 CPjsPEN8iFm9+p3t6wF0Torm+bb9EQfYNvVoxwXRZTY6b18vP/dspcQ29FQXbv68G/aiN7A0aha
 KEX0NbyT8n257sbL2mX+HC8ok68VQPbT/j+6gXdOLNxRD991sCUY3ps5/HgzOuMSZLqv1zz5hpV
 F7kaZb/ivAtg==
X-Google-Smtp-Source: AGHT+IFYdvPnxLOqZe2Hyf0JN16lk/sHHYiqGDw3YGGYLH8LDTORYKScBn1yNr+Izlb4PFj7HO7Xag==
X-Received: by 2002:a05:620a:1b9b:b0:7e0:cb93:6fb1 with SMTP id
 af79cd13be357-7e3433511a5mr3083818985a.9.1753112066856; 
 Mon, 21 Jul 2025 08:34:26 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051ba6b728sm40918196d6.69.2025.07.21.08.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:34:26 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:34:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 13/14] net/sxe: add virtual function
Message-ID: <20250721083424.716a8ff8@hermes.local>
In-Reply-To: <20250719090537.699357-13-liujie5@linkdatatechnology.com>
References: <20250716082930.83026-14-liujie5@linkdatatechnology.com>
 <20250719090537.699357-1-liujie5@linkdatatechnology.com>
 <20250719090537.699357-13-liujie5@linkdatatechnology.com>
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

On Sat, 19 Jul 2025 17:05:36 +0800
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> diff --git a/drivers/net/sxe/base/sxevf_hw.c b/drivers/net/sxe/base/sxevf_hw.c
> new file mode 100644
> index 0000000000..7425bafedb
> --- /dev/null
> +++ b/drivers/net/sxe/base/sxevf_hw.c
> @@ -0,0 +1,951 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (C), 2022, Linkdata Technology Co., Ltd.
> + */
> +#if defined(__KERNEL__) || defined(SXE_KERNEL_TEST)
> +#include <linux/etherdevice.h>
> +

It is preferred that for base code you use a tool like unifdef
to remove any direct kernel parts. Seeing the stuff used by Linux
kernel driver can confuse readers and simple searches for code.
Plus AI tools really know nothing about code and what an ifdef is!
