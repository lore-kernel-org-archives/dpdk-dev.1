Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D894E10F9951
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 15:41:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03E04402C1;
	Wed,  8 Apr 2026 17:41:24 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id BD29A4014F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 17:41:22 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-82cf976ecacso2580625b3a.1
 for <dev@dpdk.org>; Wed, 08 Apr 2026 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775662882;
 x=1776267682; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8BI1pLe2WXQhPlUlQetonOu4HqyPJGDeyvrEmT4nfw=;
 b=VeJqFWovP5NbIoTy9BZkpbSMS3iHpcjLyQtDqf08OpKFZCRGw+vCm7T8F7cmL1dKAK
 C+ixsDNPVhuTgwnYWZ33tYpYrH7UYKZOIcB462QliEvtWJfgmJvUWWheLAlm5/rtNzeD
 xUZ0iE1QEvDtBmASPH3Pf30PdnwGxEm/rlsBhDl0vCZZ37Su4zuRglJgMlGqCSJil+wQ
 pRB2Q0FzZTdh9L1dKIb7qFSxlPBTAOooOpmdj2SSGFDrJH3boV/2ztW5CxjZNau35PAe
 EBNS/wsVvpe/FqjbQ/yUyTQiLXziGGqihJjob0OHIgC9uaRWmz6nimn+wnWn4R9yT51C
 V24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775662882; x=1776267682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w8BI1pLe2WXQhPlUlQetonOu4HqyPJGDeyvrEmT4nfw=;
 b=BCGBbp5y8qX4YTFdw/GfZ92QaqEa+UnYJtJcXEZRaBoRupNOKSQ7Rg65iO8szZLJHm
 p7THhkcGxKlT8UHDRHDWarxMXN0gdmMmQ96XYIdrjiqR6ReUNgdPezP9NSgRldEhEb1m
 bkHjrGtrB9xQwG5+brVzcahHPXz1OnH4cpWzg8MlWS2cTseLFoe6+lqTJMVJJH1OwEUe
 gH602jiIP9DE0ofN0gqBtkUJKMZGO4ie1A0TCLzjIkp7Sh6k7AzwDhNyyfEjUpTDo/aB
 4TSJbMp7FQ90K3FLCaQHpwkmmH27589k6N2jcbpk8VMQ4O143T/cj8Qh+9vMBynvAb+e
 +DZg==
X-Gm-Message-State: AOJu0Yy5S3bZqBgyj5qED3mstEiEjwKRqaiKOQGxRrf7kYftKbG2SJVr
 cCjfNWUMnaOxUtEGIuuBNVRjLno1wXTU0tJD6L+vXHjRQ3lgBka1Nk/Oj+E7tBFyL5U=
X-Gm-Gg: AeBDiesqatC0Xf/g+2/cNd9dD8P5Xl0IvlMEkh3elmakHXO7Mn5rtEaF6CUZ3qlSSfJ
 3yb+pjM5Xt3CbNW1PBI4sqrin1qHKSdCXHdwA2iNj76agv3qz6S52iKuy+0C2z6rSUfYtzlkvGO
 /bMVuov0sZoK9g4OWWkn0TSWkmmUmnqY0I/b/1uFWBbWCrG0Rnz1PlyQ1Fb7qFromZYpUjTHEuY
 yhEHCsrgajmNYwoGvojGkBfvCNQOzc6Nh90KPOClU6aWvV2OX5vWZx0FYGKfb5piOpoTJdpx7PY
 loLMRCbOSxiRqayWslPgyaGmIWSX82Qy1VZ1FJ4ahvD8KEV9Moc90MyaGMkJo/+NxgMXQgMFQgg
 wSSBZKyuoOGlE2VFwk77HMR25RREIR8Duy5GDSu/JLqIrsEpl2dsEuflkXZOgDV5KR843XFBHGP
 UhG/H6oeuFTKOuo+PzvdXczLjEmvgP2VpsNsA=
X-Received: by 2002:a05:6a00:22c4:b0:82c:651f:3385 with SMTP id
 d2e1a72fcca58-82d0db4fdefmr23562144b3a.34.1775662881592; 
 Wed, 08 Apr 2026 08:41:21 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b5fb22sm27032903b3a.26.2026.04.08.08.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 08:41:21 -0700 (PDT)
Date: Wed, 8 Apr 2026 08:41:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Bruce
 Richardson <bruce.richardson@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
Subject: Re: [PATCH] mempool: improve cache behaviour and performance
Message-ID: <20260408084114.59cee3f0@phoenix.local>
In-Reply-To: <20260408141315.904381-1-mb@smartsharesystems.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
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

On Wed,  8 Apr 2026 14:13:15 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> This patch refactors the mempool cache to eliminate some unexpected
> behaviour and reduce the mempool cache miss rate.
>=20
> 1.
> The actual cache size was 1.5 times the cache size specified at run-time
> mempool creation.
> This was obviously not expected by application developers.
>=20
> 2.
> In get operations, the check for when to use the cache as bounce buffer
> did not respect the run-time configured cache size,
> but compared to the build time maximum possible cache size
> (RTE_MEMPOOL_CACHE_MAX_SIZE, default 512).
> E.g. with a configured cache size of 32 objects, getting 256 objects
> would first fetch 32 + 256 =3D 288 objects into the cache,
> and then move the 256 objects from the cache to the destination memory,
> instead of fetching the 256 objects directly to the destination memory.
> This had a performance cost.
> However, this is unlikely to occur in real applications, so it is not
> important in itself.
>=20
> 3.
> When putting objects into a mempool, and the mempool cache did not have
> free space for so many objects,
> the cache was flushed completely, and the new objects were then put into
> the cache.
> I.e. the cache drain level was zero.
> This (complete cache flush) meant that a subsequent get operation (with
> the same number of objects) completely emptied the cache,
> so another subsequent get operation required replenishing the cache.
>=20
> Similarly,
> When getting objects from a mempool, and the mempool cache did not hold so
> many objects,
> the cache was replenished to cache->size + remaining objects,
> and then (the remaining part of) the requested objects were fetched via
> the cache,
> which left the cache filled (to cache->size) at completion.
> I.e. the cache refill level was cache->size (plus some, depending on
> request size).
>=20
> (1) was improved by generally comparing to cache->size instead of
> cache->flushthresh.
> The cache->flushthresh field is kept for API/ABI compatibility purposes,
> and initialized to cache->size instead of cache->size * 1.5.
>=20
> (2) was improved by generally comparing to cache->size instead of
> RTE_MEMPOOL_CACHE_MAX_SIZE.
>=20
> (3) was improved by flushing and replenishing the cache by half its size,
> so an flush/replenish can be followed randomly by get or put requests.
> This also reduced the number of objects in each flush/replenish operation.
>=20
> As a consequence of these changes, the size of the array holding the
> objects in the cache (cache->objs[]) no longer needs to be
> 2 * RTE_MEMPOOL_CACHE_MAX_SIZE, and was reduced to
> RTE_MEMPOOL_CACHE_MAX_SIZE.
> For ABI compatibility purposes, keeping the size of the rte_mempool_cache
> unchanged, a filler array (cache->unused_objs[]) was added.
>=20
> Performance data:
> With a real WAN Optimization application, where the number of allocated
> packets varies (as they are held in e.g. shaper queues), the mempool
> cache miss rate dropped from ca. 1/20 objects to ca. 1/48 objects.
> This was deployed in production at an ISP, and using an effective cache
> size of 384 objects.
>=20
> In addition to the Mempool library changes, some Intel network drivers
> bypassing the Mempool API to access the mempool cache were updated
> accordingly.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

AI review had some good feedback. Mostly about adding a good release note.

Review of: [PATCH] mempool: improve cache behaviour and performance
From: Morten Br=C3=B8rup <mb@smartsharesystems.com>

This is a substantial and well-motivated rework of the mempool cache.
The half-size flush/refill strategy is sound and the performance data
is compelling. A few observations:

Warning:

1. drivers/net/intel/common/tx.h: The reworked fast-free path removes
the (n & 31) =3D=3D 0 alignment requirement. The old code required 32-byte
alignment because it used a memcpy loop in 32-element chunks. The new
code calls rte_mbuf_raw_free_bulk() which has no such requirement, so
removing the condition is correct. However, the old code also bypassed
rte_pktmbuf_prefree_seg() for the entire batch when the cache was
available. The new code still bypasses prefree (raw_free_bulk doesn't
call it), but now does so for ANY value of n, not just multiples of 32.
Previously, non-aligned counts fell through to the "normal" path which
called rte_pktmbuf_prefree_seg() per mbuf. If any of those mbufs have
a non-zero refcount or external buffers, the old code handled that for
non-aligned batches but the new code will not. This is gated by
fast_free_mp being non-NULL (i.e. RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
is enabled), which contractually means single-pool, refcnt=3D=3D1, no
external buffers =E2=80=94 so functionally safe, but the behavioral change
should be called out in the commit message.

2. drivers/net/intel/idpf/idpf_common_rxtx_avx512.c: The new fallback
to idpf_singleq_rearm_common() when IDPF_RXQ_REARM_THRESH > cache->size / 2
is a correctness guard, but it means that for any mempool with
cache_size < 128, the vectorized rearm path silently degrades to the
scalar path. This is a performance cliff that applications won't expect
from reducing cache_size. Worth a comment or documentation note.

Info:

3. lib/mempool/rte_mempool.h: The __rte_restrict addition to all public
put/get API signatures is an ABI-compatible but API-visible change. The
restrict qualifier is a promise by the caller, not the callee. Callers
using the deprecated non-restrict signatures via function pointers or
wrappers will still compile, but documenting this in the release notes
would help downstream users understand the new aliasing contract.

4. lib/mempool/rte_mempool.h: In the put path flush branch, the
enqueue_bulk call now flushes objects from the middle of the cache
array (at offset len - size/2) rather than from offset 0. The objects
being flushed are the oldest in the cache (LIFO bottom). This changes
the access pattern for the backend ring =E2=80=94 previously it saw the full
cache contents, now it sees the bottom half. This is fine for
correctness but changes the cache residency pattern, which is
presumably the intended improvement.

5. lib/mempool/rte_mempool.c: The validation in rte_mempool_create_empty
changes from cache_size * 1.5 > n to cache_size > n. This relaxes the
constraint =E2=80=94 pools that were previously rejected (e.g. n=3D100,
cache_size=3D70, where 70*1.5=3D105 > 100 failed) will now succeed. This
is a user-visible behavioral change worth noting in release notes.
