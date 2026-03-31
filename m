Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89CE10F9306
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6D7F40275;
	Wed,  1 Apr 2026 00:17:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 992604026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774995475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ci5yZgRdQXDCqhTyl+R0ZgF1FgrFqZZF5ESpQYg4msU=;
 b=GUX7KEOVCPpzAJsJhCWpYlA3rKEHpQkh5ShgvsJ0elWXRsfN+aa0cSj3v6IsZdHA3y/r/K
 T6F0N7YitfGOo1VFmvgX3VQw7gJpuWZ+5ZnKdDsS9tHmTRLgMhDMpKGLw4MhMnWyq2A/Yz
 YBeeZsCztfR1kNRjxrOIvnLecYS4WOI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-jeU69RI8Pp-KOl4L2Tw0QQ-1; Tue, 31 Mar 2026 18:17:54 -0400
X-MC-Unique: jeU69RI8Pp-KOl4L2Tw0QQ-1
X-Mimecast-MFC-AGG-ID: jeU69RI8Pp-KOl4L2Tw0QQ_1774995473
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d03ae4f2aso1672839f8f.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774995473; x=1775600273;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ci5yZgRdQXDCqhTyl+R0ZgF1FgrFqZZF5ESpQYg4msU=;
 b=isis3PinPKAHXyZC5diPouOYH8IdrIJ8CAeeuu7STCzuc6HvfyztJHBzwxZcRXt4cb
 UtE/EU9RcSjj2UX9n5YHEyPA4McZdkElUzGpmLl+1Q4XoPwLslthAtoFOFjxUzHAwrgU
 JhY/qBBxZPu0S+eOOZrr1M1MX+Ldrjd6cKVoYNUAZ6tEyw90goS/O8R2MST6tGxZbe/j
 cUnXhrRkGiJFCcz3S0ADwoKARaeIlj/t/InrVdv5IfykfqguG+7i5E2j7+l9mcLConwl
 T85IXybMJP9W1zlLl3rnzRFJhuPf/KT/nTzVwaZ1hAvvUOcsZ7sPWrqYNJhnna+nxj5o
 m8lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQiomVku1KpPbdWPU/9YEG7Pw/CG0UyML5WbF3dk3a8hA4qIJVqOAWUNMMha52CiMoZWY=@dpdk.org
X-Gm-Message-State: AOJu0YyfaaxdlorBD+y1rXNsIi8/BCYVJtoaHkCwppKaBd/lrnsM8H9p
 4uwJDJAJCgq+47lXAJ4ydvcos4NpCTh+LJPNQVDMU47/bjoNBvECrgUtBVDnG1iJ6VXvWY5G0Pa
 6SSlJS3YJCW/jLbTZtCslF8CHslsRbP8jSCmempRZibkN
X-Gm-Gg: ATEYQzxjNC0Xq7HwcSWFQLmBB7T1GoJWeacwwt20O3DDX0ro03ivrmeNe7t4aQoYuFu
 FCmvjY+2pPFzUSA9eyFJGgD6eQnfcuFZnTMPYxt4c49n4FCAvrvQ10Gwe7BzGFedecuq2QaBMq2
 eF+OIQK0IKdJxvoP4qht42iRGnvML0/xzaboCHrlQ9yVGHTD3ZQu0DijjwBK976trg3gEJdv7mM
 JhBW1wjjOOcYEWK0n4Ata8SI8txeexyOqXRtY6wGMRZW63rnIJ3+KJXyHWHoV7L6ckHt2wRjHHo
 s+lzJolSrjrm+PVSGzHW6/smez/S1eobnZDWorRz+AZGwquHeugrCPZUv3OESMR8lVQ3/B0sSRk
 FjJvSWowF7amF0bdC8sjY68ktcjFzjIpwu1UrQtd4Sj9VbGHUlBCzdmS1FfXp3+qSk7vUdy3PB4
 90UmJe
X-Received: by 2002:a05:600c:8488:b0:487:1fbf:e0a1 with SMTP id
 5b1f17b1804b1-48883569e15mr17662675e9.4.1774995473299; 
 Tue, 31 Mar 2026 15:17:53 -0700 (PDT)
X-Received: by 2002:a05:600c:8488:b0:487:1fbf:e0a1 with SMTP id
 5b1f17b1804b1-48883569e15mr17662305e9.4.1774995472756; 
 Tue, 31 Mar 2026 15:17:52 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e952b0bsm59409015e9.12.2026.03.31.15.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 15:17:52 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 01 Apr 2026 00:17:51 +0200
Message-Id: <DHHBDQLPUP7N.N5BQQQHV8Z4J@redhat.com>
Cc: <vladimir.medvedkin@intel.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Maxime Leroy" <maxime@leroys.fr>, <dev@dpdk.org>
Subject: Re: [RFC 0/5] fib: shared and resizable tbl8 pool
User-Agent: aerc/0.21.0-127-g39acbf663345
References: <20260331214117.142495-1-maxime@leroys.fr>
In-Reply-To: <20260331214117.142495-1-maxime@leroys.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EMNEtt1OcPy6QWwtpmKAzNabQwG9nneuO-USyjqdtOE_1774995473
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Hi Maxime,

Maxime Leroy, Mar 31, 2026 at 23:41:
> This RFC proposes an optional shared tbl8 pool for FIB/FIB6,
> to address the difficulty of sizing num_tbl8 upfront.
>
> In practice, tbl8 usage depends on prefix distribution and
> evolves over time. In multi-VRF environments, some VRFs are
> elephants (full table, thousands of tbl8 groups) while others
> consume very little (mostly /24 or shorter). Per-FIB sizing
> forces each instance to provision for its worst case, leading
> to significant memory waste.
>
> A shared pool solves this: all FIBs draw from the same tbl8
> memory, so elephant VRFs use what they need while light VRFs
> cost almost nothing. The sharing granularity is flexible: one pool per
> VRF, per address family, a global pool, or no sharing at all.
>
> This series adds:
>
>   - A shared tbl8 pool, replacing per-backend allocation
>     (bitmap in dir24_8, stack in trie) with a common
>     refcounted O(1) stack allocator.
>   - An optional resizable mode (grow via alloc + copy + QSBR
>     synchronize), removing the need to guess peak usage at
>     creation time.
>   - A stats API (rte_fib_tbl8_pool_get_stats()) exposing
>     used/total/max counters.
>
> All features are opt-in:
>
>   - Existing per-FIB allocation remains the default.
>   - Shared pool is enabled via the tbl8_pool config field.
>   - Resize is enabled by setting max_tbl8 > 0 with QSBR.

The shared pool is nice, but dynamic resize is awesome.

I have gone over the implementation and it seems sane to me. The only
concern I might have is the change of tbl8 pool allocator for DIR24_8
from a O(n/64) slab to O(1) stack. I don't know if it can have
a performance impact on lookup or if it only affects the control plane
operations (add/del).

> Shrinking (reducing pool capacity after usage drops) is not
> part of this series. It would always be best-effort since
> there is no compaction: if any tbl8 group near the end of the
> pool is still in use, the pool cannot shrink. The current LIFO
> free-list makes this less likely by immediately reusing freed
> high indices, which prevents a contiguous free tail from
> forming. A different allocation strategy (e.g. a min-heap
> favoring low indices) could improve shrink opportunities, but
> is better addressed separately.

Shrinking would be nice to have but not critical in my opinion. I would
prefer if we could add a dynamic resize feature (and possibly RIB node
mempool sharing) for rte_rib* as well so that FIB objects can really be
scaled up on demand. For now, if you run out of space in the RIB, you
will get an ENOSPC error even if the FIB tbl8 pool still has room.

Nice work, thanks!

> A working integration in Grout is available:
> https://github.com/DPDK/grout/pull/581 (still a draft)
>
> Maxime Leroy (5):
>   test/fib6: zero-initialize config struct
>   fib: share tbl8 definitions between fib and fib6
>   fib: add shared tbl8 pool
>   fib: add resizable tbl8 pool
>   fib: add tbl8 pool stats API
>
>  app/test/test_fib6.c        |  10 +-
>  lib/fib/dir24_8.c           | 234 ++++++++++---------------
>  lib/fib/dir24_8.h           |  17 +-
>  lib/fib/fib_tbl8.h          |  50 ++++++
>  lib/fib/fib_tbl8_pool.c     | 337 ++++++++++++++++++++++++++++++++++++
>  lib/fib/fib_tbl8_pool.h     | 113 ++++++++++++
>  lib/fib/meson.build         |   5 +-
>  lib/fib/rte_fib.h           |   3 +
>  lib/fib/rte_fib6.h          |   3 +
>  lib/fib/rte_fib_tbl8_pool.h | 149 ++++++++++++++++
>  lib/fib/trie.c              | 230 +++++++++---------------
>  lib/fib/trie.h              |  15 +-
>  12 files changed, 844 insertions(+), 322 deletions(-)
>  create mode 100644 lib/fib/fib_tbl8.h
>  create mode 100644 lib/fib/fib_tbl8_pool.c
>  create mode 100644 lib/fib/fib_tbl8_pool.h
>  create mode 100644 lib/fib/rte_fib_tbl8_pool.h


--=20
Robin

> For recreational use only.

