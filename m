Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FF5D3B9AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 01:46:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77E4E40289;
	Thu, 11 Dec 2025 02:46:34 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id BCD9C40285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 02:46:33 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-297ef378069so5004575ad.3
 for <dev@dpdk.org>; Wed, 10 Dec 2025 17:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765417593;
 x=1766022393; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S87C7q2++8OeE4xtILR/1ZaxRWJMOMWjngb2+DKd7Zs=;
 b=C3yDja71m5lks3wMPp6mGYU42aAYFwLtwwDg+Ug1i/Ar0Auso/1l9l3GSeFVR9jdQN
 FgOTwlBGCIHjezyLzu/3+xV3pi3Boolg8P262L9v3EZ5lA8Kg6G/X1mD2bI/TOGWxsS/
 Gh6Q5j02BBcefcZLcu2V2EMmwgLof42gVxul24Lram7kNFcCplnPdEaTUFL+pO7h1wQZ
 Pr9ljg3f+guomHpLX4mm5C7KrpJGzb0iFHcjU0cddBls1orWsTUBYuiKg5puBARP1icR
 pRYU/b08/Xkj+Ttb3skzfmu1t1zVc8HfgM4IVWoFK7XE9jtlkW9nDwyZTazLLnBRq5Q/
 G9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765417593; x=1766022393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S87C7q2++8OeE4xtILR/1ZaxRWJMOMWjngb2+DKd7Zs=;
 b=mLowKZswn01pgfJB7qqZmbN5t0/PZea7yo+72vZy1+UxjYMiAVCjlFs5tYOcvHu4NR
 39Llajy2scEJXuFDv2lROch2R0t9SqjfRS7KyQ4ahOzhc6+ToFOZL/nbE4RuhOipT9Eo
 2fG2clPeXJIXGu5/hwgd3UJzfsfuv+fgWe/bA3LpLlU6GBYgYDO0WbtkHuxL7OWyZHEW
 OVHN3x8YtDzYCNKSkULcOSK9Oj9riQDHkA4V/VQIujRQf8V130NrDdLmRzW7OwRRSQMh
 YOuWIGcYilTYlhoTpSoOd/2IBwOwm5dVyLCX0UwfML+g9PAYWzOKrog1oAzdh8yj8QxF
 GVfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Esy8cPY85gKLOvogUKtgKpwHETLCECrU4UwAnT3U/ekZABZXVlKQ04v+FWddVoolDd4=@dpdk.org
X-Gm-Message-State: AOJu0Yw38ZotmJ1Buv7E3uNziwDdXCGpeOKM9D7a2fIykiG3qglTXKxh
 hHyLVNvJq9WUmzm7MIentXW6vrlfI7EuEUL/grQ4blU3FmBUc88OADrkVJOvOEU062A=
X-Gm-Gg: AY/fxX5USZBPXqylo0LhQF/GxPEuUtvQIPpnOyTcQ9Ph+Iq+ufmKyyW36GtmchIVvjI
 6AjZbOgRq04PExj6fpuMyw1Jy7SG5wCPF1n+b5UauNjMzVX6THfr9zYkHnRY8r2ETt2Y3+HHxx8
 IqTukcB1RcfnU5HNS4iQRLq8DwbayusrVjtw0iQknlf5dK8jVY13BmUaQiXX2Bu7eNRJsQrcoKR
 cV/BXXYg6PGFIBGb4Jn5AkSD98xV8/N9jLm3PvlSFPOS3JYUlI7WHn9Dm/1fMYla+2OqRUwZjDw
 ksqsfVrmQX3/hbGn8ERbrjuHGTVO3h8eKtsEwmOztlMjsrFDi4GlWTrjzAgRlL3kK4l/y+Q74p8
 ftyda8Qu/ulbacpvxR1pWd3loqdOxQr6xk9bNoONT5BbLfe9Q0qqjBLQ3GLDfhWcA2NUjdZctRx
 NhYs7nSqvw6Z7syKigqguOaHykOKggzQK7QBfnqyRrsEdJrXC9OuXLY9UIQXOdnpIItrRWCg==
X-Google-Smtp-Source: AGHT+IHHbpkQSFnXERwNvV5TmR4xpDduzaGrfEUBI0mTAsUdUzCphr5sY6pwuaHfouGX52Sf0HT2lw==
X-Received: by 2002:a17:902:f60f:b0:295:9b3a:16b6 with SMTP id
 d9443c01a7336-29ec27ce459mr45893865ad.49.1765417592746; 
 Wed, 10 Dec 2025 17:46:32 -0800 (PST)
Received: from stephen-xps.local (p99249-ipoefx.ipoe.ocn.ne.jp.
 [153.246.134.248]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea016ef4sm6032835ad.56.2025.12.10.17.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 17:46:32 -0800 (PST)
Date: Thu, 11 Dec 2025 10:46:25 +0900
From: Stephen Hemminger <stephen@networkplumber.org>
To: "=?UTF-8?B?bWFubnl3YW5n?=(=?UTF-8?B?546L5rC45bOw?=)"
 <mannywang@tencent.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH v3] acl: support custom memory allocator
Message-ID: <20251211104625.39632870@stephen-xps.local>
In-Reply-To: <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 25 Nov 2025 12:14:46 +0000
"mannywang(=E7=8E=8B=E6=B0=B8=E5=B3=B0)" <mannywang@tencent.com> wrote:

> Reduce memory fragmentation caused by dynamic memory allocations
> by allowing users to provide custom memory allocator.
>=20
> Add new members to struct rte_acl_config to allow passing custom
> allocator callbacks to rte_acl_build:
>=20
> - running_alloc: allocator callback for run-time internal memory
> - running_free: free callback for run-time internal memory
> - running_ctx: user-defined context passed to running_alloc/free
>=20
> - temp_alloc: allocator callback for temporary memory during ACL build
> - temp_reset: reset callback for temporary allocator
> - temp_ctx: user-defined context passed to temp_alloc/reset
>=20
> These callbacks allow users to provide their own memory pools or
> allocators for both persistent runtime structures and temporary
> build-time data.
>=20
> A typical approach is to pre-allocate a static memory region
> for rte_acl_ctx, and to provide a global temporary memory manager
> that supports multipleallocations and a single reset during ACL build.
>=20
> Since tb_mem_pool handles allocation failures using siglongjmp,
> temp_alloc follows the same approach for failure handling.
>=20
> Signed-off-by: YongFeng Wang <mannywang@tencent.com>
> ---

Rather than custom allocators, I did a couple of quick AI queries about
alternatives. It looks like there are some big global gains possible
here:

Summary of Recommendations
Improvement	Benefit	Complexity	Priority
ACL Object Pooling	Eliminates ACL-specific fragmentation	Medium	High
Size-Class Segregation	Reduces general fragmentation	High	High
Slab Allocator for Build	Better hugepage utilization	Medium	Medium
Deferred Coalescing	Reduces fragmentation from churn	Medium	Medium
Thread-Local Caching	Reduces contention, improves locality	Medium	Medium

Also adding some malloc_trim() would help.

https://claude.ai/share/75fcf73c-17e3-4f41-8590-f2ab640f9512

