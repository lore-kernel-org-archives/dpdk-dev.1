Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081811061B22
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 20:55:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E44F9402D8;
	Mon, 30 Mar 2026 22:55:01 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 0FFA2402CE
 for <dev@dpdk.org>; Mon, 30 Mar 2026 22:55:00 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso617773c88.0
 for <dev@dpdk.org>; Mon, 30 Mar 2026 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774904099;
 x=1775508899; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wp6FH1Q9bM1GhDk4pxiScUTHfCMjmjBLdPJRbpMRgUM=;
 b=bA7cJNkcmdFDe52aHuFVxfXylf8uKVIKEBMdrj34PuIjmGsH93pO+PW/bF0zNyBChu
 +BHLPUCFlPhNlqjwb5QziHwcyL+WXYj8KLEScMhXiOJDYSn0Gl5T0zHbyNv8dttNxd9D
 cL+sWJuNT9OkxV5jtqxK6MiEXSc/HYn5Kz+k1NJ7kYkQ/Ntf90HiIrrdGqdCtGjbwcih
 rG8NP2b4pvS49AjbffDsLulZx7vU45+SwINzz3YviBE/8ZUcCde7Oaf/Pb2iMLR6KDGo
 74X7FpkFmh6QS05yw/7Qy7xNM3D6oO86keTL7vkMG8NF+xkQtjPlxeQ0KxVtru80SLDe
 ytXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774904099; x=1775508899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wp6FH1Q9bM1GhDk4pxiScUTHfCMjmjBLdPJRbpMRgUM=;
 b=eVlu1sXwgSNWBrgoADl5MvN7VRC7RjDoEoKJNELrVaSgjrab4/oA3LMffvLyhsYT9r
 4JRwMj3OMVlOIbAvUSgFReJeXRxeF6zOawynyBn5+zlKeHR/mnDFozKa1QMVshFHSLdL
 C2l2x/us2v7ktq15MaFpOjhN8NdJrtKDgzf4GxeITk0atqGShNGthfnwnbdE4fovES9V
 cJ4sZQPRH+6etoOZvR57oAS2d6iOGuEZJoXIi13Nv+QcblK9NpTVC6mrLR3m9ia+xq8M
 r4+X6VfvBiAeqENUOuoumqUJ3eAuRpoY8ogpaFbgki/6ThVhT6EM50dhCKAVW7wQJa17
 4i5w==
X-Gm-Message-State: AOJu0Yy75zvcU8q5THg77oNS55fFWZsnAq+r6af4/EbhmcUExh5RHYTq
 gi4MSPntZaXyx3xfp7Hfct6HDmljtWrEoBfyIT0mn/O+uZHmiswSz0trobcnVC++uzgqs6xdWzt
 Q3E/3
X-Gm-Gg: ATEYQzzexBMKxtODaMduFA27AaNa4aotPRoxU4w7lEa+YSAJzY3Gnqk8hcds0vvIF0E
 IzYHJuQFH8DnigB9CEN5M9F6kzJivHfcheNWN4E2ER9NF+8Ba+qw7W+Lrwfw7eNw1kZlWvUpcyw
 HsxvF81DfaDDjhrJXj+Rc9HZHH2cRdDGmhFVs9lCMVax6lMuZXNtC7tHRA/86gFbeFt4ibzU0pq
 TWv2NPWgEpwKQR0ktzMg6L3SkxI/qzmUBfp+R5R/ceQApnWKU+tsr7xFyteGt5sKtUJIu5NapUK
 05tx1+1YP5TaKZ38uAORTcCT6VhBPOTvQS3fjdhupW8OgVJArCY1N4OzE3UhTXQ1n5b3EbPFEy9
 nE3AVdEd5Q02nIrQHhDX7gqmpAc64oEIipZCF6MQL9PlEc9giYQow9Gr+Hb9Fh3wiy/ExqWPNYP
 s07HkYC8Gp+MoMlCwyKSEw10RjENJnz11AZ6Q=
X-Received: by 2002:a05:7022:125:b0:128:ca6f:adf2 with SMTP id
 a92af1059eb24-12ab292f131mr8641405c88.32.1774904098844; 
 Mon, 30 Mar 2026 13:54:58 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ac09e3872sm9617510c88.13.2026.03.30.13.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:54:58 -0700 (PDT)
Date: Mon, 30 Mar 2026 13:54:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org, Zijian <zijian.oerv@isrc.iscas.ac.cn>, =?UTF-8?B?U3Rh?=
 =?UTF-8?B?bmlzxYJhdw==?= Kardach <stanislaw.kardach@gmail.com>, Nithin
 Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>
Subject: Re: [PATCH v3] node: lookup with RISC-V vector extension
Message-ID: <20260330135456.3064ee41@phoenix.local>
In-Reply-To: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
References: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
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

On Fri,  6 Feb 2026 16:16:35 +0800
Sun Yuechi <sunyuechi@iscas.ac.cn> wrote:

> Implement ip4_lookup_node_process_vec function for RISC-V architecture
> using RISC-V Vector Extension instruction set
>=20
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> Signed-off-by: Zijian <zijian.oerv@isrc.iscas.ac.cn>
> ---

Since RISC-V changes do not seem to get looked at, did AI review and it
found several things that need addressing.

Review: [PATCH v3] node: lookup with RISC-V vector extension

Errors
------

1. Macro redefinition of RTE_LPM_LOOKUP_SUCCESS and
   RTE_LPM_VALID_EXT_ENTRY_BITMASK (ip4_lookup_rvv.h lines 8-9).

   ip4_lookup.c already includes <rte_lpm.h> (line 14) before
   including ip4_lookup_rvv.h. Both rte_lpm.h and this header
   #define RTE_LPM_LOOKUP_SUCCESS and RTE_LPM_VALID_EXT_ENTRY_BITMASK,
   which will produce compiler warnings for macro redefinition.

   Remove both #defines from ip4_lookup_rvv.h =E2=80=94 the values are
   already available from rte_lpm.h.

   (The upstream rte_lpm_rvv.h has the same issue, but that file is
   included from rte_lpm.h itself, so the include ordering is
   different. In the node header the double-define is unavoidable
   without removing them.)

2. RTE_VECT_DEFAULT_SIMD_BITWIDTH change is too broad
   (rte_vect.h: SIMD_DISABLED -> SIMD_128).

   This change affects every DPDK subsystem that calls
   rte_vect_get_max_simd_bitwidth() on RISC-V, not just the node
   library. It globally enables SIMD code paths across all libraries
   and drivers that gate on this value. This should be a separate
   patch with its own justification and testing, not bundled with a
   node-library feature patch. If a RISC-V platform cannot actually
   execute 128-bit vector operations at runtime, this default would
   cause failures.

Warnings
--------

3. Duplicated LPM lookup logic instead of using rte_lpm_lookupx4().

   The NEON and SSE implementations call rte_lpm_lookupx4() which is
   already vectorized for RISC-V via rte_lpm_rvv.h upstream. The
   new rte_lpm_lookup_vec() in ip4_lookup_rvv.h reimplements the
   same tbl24/tbl8 lookup logic. While the wider LMUL (m8 vs m1)
   enables larger batch sizes, duplicating LPM internals means any
   future LPM bug fix or optimization must be applied in two places.

   Consider either:
   (a) Using rte_lpm_lookupx4() in a loop (as NEON/SSE do) with a
       scalar tail, or
   (b) Adding a variable-length bulk lookup to the LPM library
       itself (e.g., extending rte_lpm_lookup_bulk to use RVV
       internally) so the node code can call it without duplicating
       table access logic.

4. No prefetching of packet data.

   The NEON and SSE implementations prefetch both mbuf object lines
   and packet data (Ethernet + IP headers) for upcoming batches.
   This implementation has no prefetch calls at all. For large
   bursts the L1 miss penalty on the rte_pktmbuf_mtod_offset access
   in the IP extraction loop could be significant. Consider adding
   rte_prefetch0 for the next batch's packet headers.

5. Stack arrays sized for VLEN > 256 may be excessive.

   RVV_MAX_BURST is 64, giving 3 * 64 * 4 =3D 768 bytes of stack
   arrays (ips, res, next_hops). The comment says "can be increased
   further for VLEN > 256" but the current value already exceeds
   what any in-tree RISC-V platform uses today. 32 would be more
   conservative and still handle VLEN=3D256 (m8 gives 64 elements at
   e32 with VLEN=3D256, so 64 is correct for that). This is minor but
   worth noting for stack-constrained lcore contexts.

Info
----

6. The patch is a nice addition bringing RISC-V vector support to
   the node library. The use of vsetvl for natural tail handling
   (no scalar remainder loop needed) is a good RVV idiom.

7. The fix_spec logic uses bitwise OR accumulation across the batch
   rather than the all-equal AND chain used by NEON. Both are
   correct =E2=80=94 the OR detects any mismatch. The NEON approach detects
   exact same next-hop for all four, while the RVV approach detects
   any difference from next_index. The RVV approach is actually
   slightly more precise since it checks against the speculated
   index rather than checking all-same.

