Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54399F483E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 19:05:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D92B402D6;
	Mon, 23 Mar 2026 20:05:45 +0100 (CET)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 5787A40268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:05:44 +0100 (CET)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2c0bb213b16so7952047eec.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774292743;
 x=1774897543; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U4fCTFpZzKTRI7EHkBWa7NcCGr1MWQsFq67eeZxSLvI=;
 b=l4OX8+IGNOL6PTt2c2YzyAU1xJrk4RJfLES08DrbaKwkYWhKkruiJ5oXS+higwMMXm
 wl+NpV1014AGMywvtJupo+w6JsOJn072EKQ2QYYBMeM40JljQMtQc/3hCziQLso2V9ok
 QAo90VHbrWzF5RjkwP3EZ/mdhbYexovN+uWJrI4t3L2ZbTWzKGKStdfBM52MXd9RU+05
 pVy4ELMl0QpiWieKsmwGk1cBZ8RVSVzKiA5kTJ7lHQopmNy5jni69fU1uKV2hhSMwF2a
 4xshuREOAzmGi0oXg+RyqxFtZJRalz1ZZUhqFs2ur1yxbHUZgMT4ko+onHCpKu4iZCTn
 tVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774292743; x=1774897543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U4fCTFpZzKTRI7EHkBWa7NcCGr1MWQsFq67eeZxSLvI=;
 b=qrb5ZR69bH5jWs1fyRf0iGR3aft0OtKpzzD1LStYye+cf98jbRGl+X1YY4hDDYFS9g
 /v/X4TLJcb56sgcBE07KPLe5Jw3K7KHmj1rWD/QYtGscc44bLFIRDPde2xBfh7AlJwmE
 JXCA0UuPjD3EkooT6Rf5d6AhFnVOKAjcHB7Z1BfKpSw8dfTLmhGjh6IZRCmLOInqMEwb
 oeHbvy6cFfy1asU/H2Dk3PE9HSndY0AB5NbXQNho6Mn75IFX/OMEoJn5wtN41fpNXIBl
 3/0B4Gl6Q37CgB1TFgvR09ve6jCgI16h4LBcv0GjSZc4GBU58dIEGq1N897V03Igbx0g
 /RKQ==
X-Gm-Message-State: AOJu0YxXGKUvYlNXYkttKyokIlXLCeJtdjasattRMz4sq2KxJPQjgy/J
 MPRdSWSw9dSvPfCW6XblVvauoJTaIoAEKeAJ8IYrhL+XAHnHrB2VyUFnV2WMixbNM1g=
X-Gm-Gg: ATEYQzzXfWSVZ1v1FndTvq1eFfV1Zem+AM030dyQ0oT4ZKTUEsNQki5tHkbhJGbEMh2
 RAQA4qZ08NtG290GxegxJp3DAeOKPRkujWvcXhxV3t355gecCCn8Z2iLMN+dTsfoEswSGc4MjYT
 +qlS5bhOJmeZe4pdhS9gWsMnSYo57aBj2IRRg8GCdNZWAj6OQrjeJyR8wgslq9ZyNXmUTDT/GZS
 O07yAyHy0jLGRY1oZWktTwTRbx+5ZIG0Y7O4T4mzt9VOeM/BUbx83EOeNHn8nxM0Ehc4JU+nJrl
 AM+aOV2znFHqJjWAiwyRU0oyk8yd78gePRHonSEO89AWnKxVwFtrYFC6yLJ2f/vd/pNERe0uZF8
 hg8fRao3uYdre9B/+Ny0H+IQR6plxNv7qQedJp6u0clWbfNBalf3YA2ZZ+PTUHuZawmo8ebl9RI
 DEkCLkcxNsqL6X/L9j/i00qszIiCZ/Q8AmQqY=
X-Received: by 2002:a05:7300:d51b:b0:2c1:27c:75bc with SMTP id
 5a478bee46e88-2c10975fde7mr6241670eec.23.1774292743164; 
 Mon, 23 Mar 2026 12:05:43 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10aefd778sm17323701eec.0.2026.03.23.12.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:05:42 -0700 (PDT)
Date: Mon, 23 Mar 2026 12:05:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, nsaxena16@gmail.com,
 mb@smartsharesystems.com, adwivedi@marvell.com, jerinjacobk@gmail.com
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
Message-ID: <20260323120540.2d247ece@phoenix.local>
In-Reply-To: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
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

On Sun, 22 Mar 2026 15:42:11 +0000
Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:

> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
> allowing a single FIB instance to host multiple isolated routing domains.
> 
> Currently FIB instance represents one routing instance. For workloads that
> need multiple VRFs, the only option is to create multiple FIB objects. In a
> burst oriented datapath, packets in the same batch can belong to different VRFs, so
> the application either does per-packet lookup in different FIB instances or
> regroups packets by VRF before lookup. Both approaches are expensive.
> 
> To remove that cost, this series keeps all VRFs inside one FIB instance and
> extends lookup input with per-packet VRF IDs.
> 
> The design follows the existing fast-path structure for both families. IPv4 and
> IPv6 use multi-ary trees with a 2^24 associativity on a first level (tbl24). The
> first-level table scales per configured VRF. This increases memory usage, but
> keeps performance and lookup complexity on par with non-VRF implementation.
> 
> Vladimir Medvedkin (4):
>   fib: add multi-VRF support
>   fib: add VRF functional and unit tests
>   fib6: add multi-VRF support
>   fib6: add VRF functional and unit tests
> 
>  app/test-fib/main.c      | 257 ++++++++++++++++++++++--
>  app/test/test_fib.c      | 298 +++++++++++++++++++++++++++
>  app/test/test_fib6.c     | 319 ++++++++++++++++++++++++++++-
>  lib/fib/dir24_8.c        | 241 ++++++++++++++++------
>  lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
>  lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
>  lib/fib/dir24_8_avx512.h |  80 +++++++-
>  lib/fib/rte_fib.c        | 158 ++++++++++++---
>  lib/fib/rte_fib.h        |  94 ++++++++-
>  lib/fib/rte_fib6.c       | 166 +++++++++++++---
>  lib/fib/rte_fib6.h       |  88 +++++++-
>  lib/fib/trie.c           | 158 +++++++++++----
>  lib/fib/trie.h           |  51 +++--
>  lib/fib/trie_avx512.c    | 225 +++++++++++++++++++--
>  lib/fib/trie_avx512.h    |  39 +++-
>  15 files changed, 2453 insertions(+), 396 deletions(-)
> 

AI review found several things

Review: [RFC PATCH 1/4] fib: add multi-VRF support
       [RFC PATCH 2/4] fib: add VRF functional and unit tests
       [RFC PATCH 3/4] fib6: add multi-VRF support
       [RFC PATCH 4/4] fib6: add VRF functional and unit tests

Overall this is a well-structured RFC that adds multi-VRF support
to both the IPv4 and IPv6 FIB libraries with AVX512-optimized
lookup paths and comprehensive test coverage. There is one
significant correctness bug in the AVX512 gather paths, several
design points worth discussing, and some minor issues.

Patch 1/4 - fib: add multi-VRF support

Error: Signed overflow in AVX512 32-bit gather for VRF IDs >= 128

The VRF_SCALE_SMALL path (num_vrfs in [2, 255]) computes the
tbl24 index in 32-bit arithmetic as (vrf_id << 24) + (ip >> 8).
For vrf_id >= 128, vrf_id << 24 sets bit 31, making the result
negative when interpreted as int32. The _mm512_i32gather_epi32
and _mm512_i32gather_epi64 intrinsics sign-extend 32-bit indices
to compute byte offsets, so a negative index produces a read
before the start of tbl24 -- a buffer underflow.

Example: vrf_id=128, ip=0 gives index 0x08000000 << 24 =
0x80000000 = -2147483648 as signed int32.

This affects all nexthop sizes in both dir24_8_avx512.c and
trie_avx512.c.

Fix: Either lower the VRF_SCALE_SMALL ceiling from 256 to 128
(so VRFs 128-255 use the 64-bit path), or switch to unsigned
gather by pre-scaling the indices into byte offsets and using
scale=1 with unsigned arithmetic.

In dir24_8_avx512.c get_vector_fn():

  if (dp->num_vrfs >= 256) {

should be:

  if (dp->num_vrfs >= 128) {

Same change needed in trie.c get_vector_fn().


Warning: ABI break -- public function pointer typedefs changed

rte_fib_lookup_fn_t and rte_fib_modify_fn_t in rte_fib.h (and
the corresponding fib6 typedefs in rte_fib6.h) have new
parameters (vrf_ids/vrf_id). These are installed header typedefs
used by applications setting custom lookup functions via
rte_fib_select_lookup(). Changing them is an ABI break that needs
deprecation notice or ABI versioning.

Similarly, adding max_vrfs and vrf_default_nh to rte_fib_conf and
rte_fib6_conf changes the struct layout.

Since this is RFC, this is expected, but it will need to be
addressed before non-RFC submission.


Warning: No release notes for new experimental APIs

Eight new experimental APIs are added (rte_fib_vrf_add,
rte_fib_vrf_delete, rte_fib_vrf_lookup_bulk, rte_fib_vrf_get_rib
plus the fib6 equivalents). These need entries in
doc/guides/rel_notes/.


Warning: No testpmd hooks for new APIs

Per DPDK policy, new APIs should have hooks in app/testpmd.


Patch 2/4 - fib: add VRF functional and unit tests

Warning: Resource leak in run_v4() -- conf.vrf_default_nh not freed

In app/test-fib/main.c run_v4(), conf.vrf_default_nh is allocated
via rte_malloc() but never freed on any path (success or failure).
Same issue in run_v6() in patch 4/4.


Patch 3/4 - fib6: add multi-VRF support

Error: Same signed-overflow AVX512 gather bug as patch 1/4

The trie_avx512.c VRF_SCALE_SMALL path has the identical issue:
_mm512_slli_epi32(vrf32, 24) produces a negative signed index
for vrf_id >= 128, causing the 32-bit gather to read from a
negative offset.

In trie.c get_vector_fn():

  if (dp->num_vrfs >= 256) {

should be:

  if (dp->num_vrfs >= 128) {


Warning: Potential 32-bit truncation in trie helper functions

build_common_root() computes idx_tbl as uint64_t but passes it
to get_tbl_val_by_idx() and get_tbl_p_by_idx(). If those helpers
take uint32_t index parameters (the original code used 32-bit
indices), the upper bits will be silently truncated for large VRF
counts. The helpers should be widened to accept uint64_t, or
confirm they already do.

In practice, large VRF counts (hundreds+) with IPv6 trie tbl24
would require terabytes of memory, so this is unlikely to
manifest, but it is a latent correctness issue.
