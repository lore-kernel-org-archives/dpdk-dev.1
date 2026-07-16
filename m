Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D707CC44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 07:31:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DEB740270;
	Thu, 16 Jul 2026 09:31:05 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id EE826400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 09:31:03 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-92e5c9211d2so494616885a.1
 for <dev@dpdk.org>; Thu, 16 Jul 2026 00:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784187063; cv=none;
 d=google.com; s=arc-20260327;
 b=D5Zri6ul4kso+y9tIGM0a6ZKSU+2K4sYEtAZ+5jz1Vp5DB0eIS4OqRgNvrxRhGAIMG
 k0oBqvOuclCCK0xJbHltZeDmj6CEPTgOUqAkrTqeaKuMlDfvUkPRv8NduIvI17oGzrVl
 9Wq7oIblvt4KtBLwvpwlx5QD3QmDsC9rXeMFPJiCSaCmwAJZOJz7l0e6Ae+gh75lJdxV
 aKmzQYMWnU1pCq3ZFeB3Wa/nxBmbziHt0FzdaKQmMzItYsC3o/0Cl0MAFdX8o9OLY+CN
 6PgY+RO72QV7yt1VrACj7uPgvSDa/JMN4keSCSb2atreidShsPZWP9JGFhFBdwrYjwkQ
 +hlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=0jUPIbk0Zoht1kYB0GYLKorIgQ08EiDKhl2xq7JW1+I=;
 fh=ut9BY5XxZJIdoqVSnlInYEPcEeHi1aKtqfWQsB7ov/Q=;
 b=LshNl+5PzSvM7snm9JsETSgkaYWSBGCC0KtG5bYBR+6hbrsUWqou5W8q+FTMQ+nNwe
 c5fan+FYijx2NKMp3UvQKGoy073EEsD/nh+VIsfsJwOmGfJnxlGkYoJ2syytDfsgC+To
 9dipfGRTrZIYl7eG9cX58sXf4FnPY90veOFtSHh+P7Z8cMp2a9ozn11aCPA1Qzj6BZe5
 RwbSxdBF4uZ2Q3q48elJ0tAYpF08hextxgN8JnBdskuJGdLJNwoTs8Vy7pMqxLU+hE5P
 OSop8meiFfWwV7L3OSYLaV3A2UjnhQVqSgsdwqUZALL0h+r9s0HE1DQVobSTB91bDvEc
 A8Nw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784187063; x=1784791863;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0jUPIbk0Zoht1kYB0GYLKorIgQ08EiDKhl2xq7JW1+I=;
 b=mk1jY//ok91j4h6GJnm0+bYOcrFDXxFf/YUu1wVDcNd6pfPmqJw3JulzNFW16TFy4D
 NUmbgJj8hsYq+1usiDsc3+Qa+XzfIEb5pIpKtCu/Rd11WfYOfQNa7WW8HPMDq1y8SlL0
 1omIllUTtPLCHHUmvybwp6Xh7tFNRd0psO6v6jd7vbRqiJpJqzflT9teBwK/HnWAYW7+
 xbO4cOX80eG+8eRZsQH+k2X79JGeklHPHn568Gziy+yXJyRUJGdLOOow4gsRCc2Uq07T
 a8LXS9u1I6RHLdJ+EKBeBy1VLI2OutEfT382K/FiIVogVN0vPpHCWe1x1wy9cqAx79JL
 l4MA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJtdHOT/0msvcKNAGZSIFHX73u2jKLzw3O7FmVkmEOyF3X/RO1BjfoGueJl4mLbzxu3mE=@dpdk.org
X-Gm-Message-State: AOJu0YwrHxYEO4doNgssUpzzKQZ7d1olBXLCs1BmP29LwhPWfEHxsYUY
 dK4sAJo7g6pMOFrUR1NmstTlhZlwE0ezz3Yd9rOWIj6uhVvcZpqnnGrt3m1xJTbrn1FnP2Pdkue
 2q2lth58P2Stnmgo/O7KQdz0iUFdeca8=
X-Gm-Gg: AfdE7cm8SBgyHoao09WgkpSQVCAbmlpLMB1iu6+ZY6UGbIAVUcR/uOnm4s55OFYN553
 G66HQi0QJ0ox2O7aHw3YnYnUfLRVrmpZ2QoB1ZXyYnAjZIyzzkAJ/8CZqvjAjh5DBjCXB/lP7LO
 ZYm935GI8bf+85RFvRUsdkadt5CrCN+Mj8pbmmA1d0l/AovjOQZSmHNwbC9WTtYXrBwOkn5pqdW
 dzxCXz9NnzVEdYxDCJeMLQoDz8/lI3WVfLDR+psQqke018ip4ztVINaEl+6T0c2rppCtz3sQopj
 winoGXEZl3H4ojE=
X-Received: by 2002:a05:620a:6cc2:b0:918:4137:6be with SMTP id
 af79cd13be357-93096375ec0mr611494685a.53.1784187063142; Thu, 16 Jul 2026
 00:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260331214117.142495-1-maxime@leroys.fr>
In-Reply-To: <20260331214117.142495-1-maxime@leroys.fr>
From: Maxime Leroy <maxime@leroys.fr>
Date: Thu, 16 Jul 2026 09:30:52 +0200
X-Gm-Features: AUfX_mxjUPyUbtKreIqyFP6zE1-OVKVgb9cOU3ekwx7680JYuTDv2a2EuC_4hb8
Message-ID: <CAHHRULXktNXUawidOa7PFkL_q-Mns1SU7GVxhMQxLPd4sx9ieg@mail.gmail.com>
Subject: Re: [RFC 0/5] fib: shared and resizable tbl8 pool
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: rjarry@redhat.com, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Vladimir,

On Tue, Mar 31, 2026 at 11:41=E2=80=AFPM Maxime Leroy <maxime@leroys.fr> wr=
ote:
>
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
>
> Shrinking (reducing pool capacity after usage drops) is not
> part of this series. It would always be best-effort since
> there is no compaction: if any tbl8 group near the end of the
> pool is still in use, the pool cannot shrink. The current LIFO
> free-list makes this less likely by immediately reusing freed
> high indices, which prevents a contiguous free tail from
> forming. A different allocation strategy (e.g. a min-heap
> favoring low indices) could improve shrink opportunities, but
> is better addressed separately.
>
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
>

I=E2=80=99m following up on this RFC, which I sent at the end of March. Cou=
ld
you please review it and let me know whether you have any feedback or
concerns?

Thanks,

-------------------------------
Maxime Leroy
maxime@leroys.fr
