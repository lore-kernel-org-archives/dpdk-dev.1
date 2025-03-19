Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE230C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 16:19:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B867402C4;
	Wed, 19 Mar 2025 17:19:17 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id B2A644026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 17:19:15 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2241053582dso44473665ad.1
 for <dev@dpdk.org>; Wed, 19 Mar 2025 09:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742401155;
 x=1743005955; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGzvstRgzEPW7PjTzHfo0pvXUkrzlReFl1RFsvGI07o=;
 b=t4Nw1XDOOMZtgdCOTrVzUuVTYx7PL8rsJtmDyfrQOql/kt5SzOnXsIJz1GplY/ACiE
 1GhTpMtHJjxcr116G56306uhljHSrM7Jq3qgUQyxfnkIe/m2ey61qry9V18a2qWQsKnD
 OuQPI6di27yiOotj9u1O4Vc7aX8ZIiXywSxgv4lj4Z5TKONJwrmERhI39AS746hPaUKh
 knzMVQeWLdiHv6otFMl1f1xnC3bW/jbKFGQVAjyo0dFV+853YIGJ3fy8b0fGZMJWcBq6
 qF6woi/rEbIeKA9BuOcszDgLK5yQ4v9gbxLGEZkh2qlvUNUEoRx9tL0PoMmlospxYliN
 nlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742401155; x=1743005955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZGzvstRgzEPW7PjTzHfo0pvXUkrzlReFl1RFsvGI07o=;
 b=c9EeHF1j4Uu1Iw04vHcxdGcX6lZ/y0niWZySrpRB7IuYiqBOkTonwcvegOvXpN5CJE
 41DVywDml+u2sOe/rbBFGvs6Q6CHo7H0v7/H92Jsn79elCL/ItMXzXPEPgAgLUXOCxeL
 DLmVXiq+ZOlNViVTwlmlRp0zSzsg9Y0/lKo1fPBozBBatexaNLwvljdMDGlrUwqpDHtk
 N8a56Vr8vaA//vWHI0AweHRzeB/yTGBmeuNyLHTP3CORW3Ws5vzOlTgBe9MA2JSZ51GY
 qKD4lXWsvVJzpUQsuosmvIExSJiXXPgAxb9NEwO2fmM6Yodb+olZHPCtgzy+h7tv7DrR
 IFRg==
X-Gm-Message-State: AOJu0YxJABMIenEMbv9HJW6X+/0KrKgC1b6OLZZRpAKLEOV3G2Z09PeE
 6JSun8eh476Cpi1jQ8WL7xcsiDKTbkTqjVJhVe6N40XXny5p0xkxlBzEoJT07T0=
X-Gm-Gg: ASbGncvVK/S63zlaMb55o58cvqsRyeb0hf27Drup2bVPOW/u84YUNE5385Hpzjd2Dhy
 2VuexFxGjtP7j/s/Tx87RTK+cY5aqCN7FIwCy6Wqh/Mwqb4GBKw5m0b5/Ggr5+9bTMi50uCXdZ8
 U6ly2zeaYjw6WqtB8HiAiM3W0idR9M8/ctLBl1ZVtFS6/aHvTlzVZHbsbqTkPW7KMfocD+zHsuX
 2YpprMwcvHXYvwUKJWnzPN24V2pxiHsIsaIryl3d0b/2VOGnfUNf5qBE+oU1GcT0EE1ziUj6Zi0
 EwFHuVjzdi2dMHFMkOO7TIpIjqRnafFF0rhdR02kWclxtZ23H4qNayGGh15Lu9Zhk15s7M9FA67
 KzfeJH1ckQ1fMDCkaozrMjQ==
X-Google-Smtp-Source: AGHT+IEzMC/bmm4iifnkjlrxbwA3W9/d3TZxf28mGEyKFkdw/T1aEyNX5CVfYOrVWohB0D60iHQybA==
X-Received: by 2002:a17:902:d2cf:b0:224:1ce1:a3f4 with SMTP id
 d9443c01a7336-2264981ba8cmr49176985ad.1.1742401154635; 
 Wed, 19 Mar 2025 09:19:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6d16sm116568665ad.139.2025.03.19.09.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 09:19:14 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:19:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: Re: [RFC v4 5/8] build: generate symbol maps
Message-ID: <20250319091912.3b14713e@hermes.local>
In-Reply-To: <20250317154308.2782689-6-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250317154308.2782689-1-david.marchand@redhat.com>
 <20250317154308.2782689-6-david.marchand@redhat.com>
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

On Mon, 17 Mar 2025 16:43:01 +0100
David Marchand <david.marchand@redhat.com> wrote:

> Rather than maintain a file in parallel of the code, symbols to be
> exported can be marked with a token RTE_EXPORT_*SYMBOL.
> 
> From those marks, the build framework generates map files only for
> symbols actually compiled (which means that the WINDOWS_NO_EXPORT hack
> becomes unnecessary).
> 
> The build framework directly creates a map file in the format that the
> linker expects (rather than converting from GNU linker to MSVC linker).
> 
> Empty maps are allowed again as a replacement for drivers/version.map.
> 
> The symbol check is updated to only support the new format.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since RFC v3:
> - polished python,
> - fixed doc updates not belonging to this patch,
> - renamed map files,
> - changed msvc->mslinker as link mode,
> - added parsing of AVX sources,
> 
> Changes since RFC v2:
> - because of MSVC limitations wrt macro passed via cmdline,
>   used an internal header for defining RTE_EXPORT_* macros,
> - updated documentation and tooling,

Looks like a good idea.
Is there any way to make symbols in drivers local by default?
Right now if a driver defines a non-static function it will
be visible in other code when DPDK application is statically linked.

This can lead to problems where exports are missing or accidental
name conflicts. Gcc has -fvisiblity=hidden not sure about others.
