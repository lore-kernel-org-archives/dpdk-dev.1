Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8B0D6CFBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 06:01:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AADE44021F;
	Fri, 23 Jan 2026 07:01:50 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id A64F9400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 07:01:49 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so24861935e9.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 22:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769148109;
 x=1769752909; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5CJENW5Vu0a5U3csPsTdF731V5IQGIIJR8zSqNP7dg=;
 b=esiVXGDsT8sS9x/97OtcLMJ8dT59JtnNsy9YIXZiSjUhfX4LbFYLDUMpax5u+FiyXP
 SDSA5cCxSPvOXeC0tiPrgrBaFudgDRM55ZIkm5g1lL647ulgOOarP9DSqJMFu5TQ4ZIZ
 TGGXyKt+ZYpIPPVunpklbRYaY2rQK/HwcTOPjEmLwwQrLfaZrGrFaRfn4Tcw0cXhwGL2
 z70DggJr4VXUyCgj2e7FHtsf4GYTUNhcKUU1POS2YrbqBQ+H9HZ2WBZXniFAuca/vUs0
 DE9WoTlkvw7VidW0CQsDotO+MxYefspx9FwSRF9zIohYVetJjw46aXVMfYfW2b0+ArtS
 6UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769148109; x=1769752909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J5CJENW5Vu0a5U3csPsTdF731V5IQGIIJR8zSqNP7dg=;
 b=lhCFyuBa3M8eFuDb4Qu2SVSrOyooDtOe4QY/U+zGdBWkX5Ew1byf6B4aVVTGq6e4zJ
 RHRBpx6jz+87F4A11FfpS2cALBnBVeTVTLf0xZ6wyGFeBYlRrbal6ku2Nc10MuIzVjw7
 jxpvlaZPeeThawzBLXdCCmZTsH6vvYb6D3LazMUTQYcd0jU1PCI8rZHyKvTGXuyYrbf1
 To7SRq0fJv7gZWHwObDUKENYGg/PSnS2A8YbikXroIKJT3ZV4YgeP+KsFyQIimfv1yZc
 a2xY7ApBZ/ydExvL9rXm9su7SwPhlxLLsHexnZWLkkSJ9y4EfCXzqwaIK5IFxrmqzFdO
 EKOQ==
X-Gm-Message-State: AOJu0Yx4BQNkrSqQSq3zoPCgZuOj0wfiNTZqGSlZsu4JqwwyWT3URXgj
 2sdFKi4WwoLks7GxSJAhuUcxVsJjddfZAKkHO7P3pOgJVrFMoJu2ABbdLIdBHBbc4tE=
X-Gm-Gg: AZuq6aJEJBU6We80zyIGXt/kLr7d7gX87ixDEI8kGCtFPwRtN+kuaJgEBN+v27fjq2E
 mEK4jgxuTT/ut0K0tTbgaM+e8eQ0D5dRkPmV5QpXrp0QROlFdSogxpWf7mYuQy5WzbZ812zgR3t
 zhTwXqjkublX8X+cxsOqU6eEk0I0ovjHSH97KwMCC3LWqagl6FGy9AeHT1bzib1/Zmicb2cVXyO
 lWk4bF+brsaXUFRBWmfW99oNvvzY4ahUspkk8H9nqVO0nr1ek6JBykwI2saTpMxxdoLbojvJwxZ
 plxic7H0UKqlcQIoJfjNruSLXN4MxEASZolyfpJ064HiCzNNykozluZdJhujrRj/3AxSRd8A3W2
 4hqeEXgtyC2l8lEQbuaFhNCE3zCGcYpm07lo3fX0PhwSU7b47dASiCcYzw3RXsBEkF6eBf4Na2W
 tspy5u83hSqiImTZzMc+9p68R+1q7auqAJfxtJkp2iV070wcjhEU+/
X-Received: by 2002:a05:600c:8b04:b0:480:4a90:1af2 with SMTP id
 5b1f17b1804b1-4804c9d0102mr36296595e9.35.1769148108527; 
 Thu, 22 Jan 2026 22:01:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cf1acsm117034695e9.14.2026.01.22.22.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 22:01:48 -0800 (PST)
Date: Thu, 22 Jan 2026 22:01:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Cc: <dev@dpdk.org>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <hofors@lysator.liu.se>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, David Marchand <david.marchand@redhat.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: Re: [PATCH v6 0/7] Optionally have rte_memcpy delegate to compiler
 memcpy
Message-ID: <20260122220142.21bda930@phoenix.local>
In-Reply-To: <20240920102716.738940-1-mattias.ronnblom@ericsson.com>
References: <20240724075357.546248-2-mattias.ronnblom@ericsson.com>
 <20240920102716.738940-1-mattias.ronnblom@ericsson.com>
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

On Fri, 20 Sep 2024 12:27:09 +0200
Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com> wrote:

> This patch set make DPDK library, driver, and application code
> optionally use the compiler/libc memcpy() when functions in
> <rte_memcpy.h> are invoked.
>=20
> The new compiler memcpy-based rte_memcpy() implementations may be
> enabled by means of a build-time option.
>=20
> This patch set only make a difference on x86, PPC and ARM. Loongarch
> and RISCV already used compiler/libc memcpy().
>=20
> This patch set includes a number of fixes in drivers and libraries
> which errornously relied on <rte_memcpy.h> including header files
> (i.e., <rte_vect.h>) required by its implementation.
>=20
> Mattias R=C3=B6nnblom (7):
>   event/dlb2: include headers for vector and memory copy APIs
>   net/octeon_ep: add missing vector API header include
>   distributor: add missing vector API header include
>   fib: add missing vector API header include
>   eal: provide option to use compiler memcpy instead of RTE
>   ci: test compiler memcpy
>   vhost: optimize memcpy routines when cc memcpy is used
>=20
>  .ci/linux-build.sh                     |  5 +++
>  .github/workflows/build.yml            |  7 +++
>  config/meson.build                     |  1 +
>  devtools/test-meson-builds.sh          |  4 +-
>  doc/guides/rel_notes/release_24_11.rst | 20 +++++++++
>  drivers/event/dlb2/dlb2.c              |  2 +
>  drivers/net/octeon_ep/otx_ep_ethdev.c  |  2 +
>  lib/distributor/rte_distributor.c      |  1 +
>  lib/eal/arm/include/rte_memcpy.h       |  9 ++++
>  lib/eal/include/generic/rte_memcpy.h   | 61 +++++++++++++++++++++++---
>  lib/eal/loongarch/include/rte_memcpy.h | 54 +----------------------
>  lib/eal/ppc/include/rte_memcpy.h       |  9 ++++
>  lib/eal/riscv/include/rte_memcpy.h     | 54 +----------------------
>  lib/eal/x86/include/meson.build        |  1 +
>  lib/eal/x86/include/rte_memcpy.h       |  9 ++++
>  lib/fib/trie.c                         |  1 +
>  lib/vhost/virtio_net.c                 | 37 +++++++++++++++-
>  meson_options.txt                      |  2 +
>  18 files changed, 165 insertions(+), 114 deletions(-)
>=20

AI code review had useful feedback on this. Please address.

                                                                           =
                         =20
## Overall Assessment                                                      =
                         =20
                                                                           =
                         =20
### Errors (Must Fix)                                                      =
                         =20
1. **Patch 6/7**: Copy-paste error in `.ci/linux-build.sh` - both if branch=
es set `use_cc_memcpy=3Dtrue`
                                                                           =
                         =20
### Warnings (Should Fix)                                                  =
                         =20
1. **Patch 2/7**: Include order could be improved for consistency          =
                         =20
2. **Patch 5/7**: Long line in meson_options.txt description               =
                         =20
3. **Patch 5/7**: Extra blank line in release notes before "Removed Items" =
                         =20
                                                                           =
                         =20
### Info (Consider)                                                        =
                         =20
- All patches have proper Signed-off-by tags                               =
                         =20
- Subject lines are within 60 character limit                              =
                         =20
- Commit messages are well-written and explain the rationale               =
                         =20
- Proper use of Acked-by tags from reviewers                               =
                         =20
                                                                           =
                         =20
The critical bug in Patch 6/7 should be fixed before merging - the else bra=
nch should set `-Duse_cc_memcpy=3Dfalse` instead of `true`.

--- Full Report ---
=3D=3D=3D Patch Review: bundle-1682-opt-memcpy.mbox (via Claude) =3D=3D=3D
# DPDK Patch Review: bundle-1682-opt-memcpy.mbox

This patch series adds an option to use compiler memcpy instead of DPDK's c=
ustom implementation, along with several prerequisite fixes for missing hea=
der includes.

---

## Summary

The patch series contains 7 patches:
1. event/dlb2: include headers for vector and memory copy APIs
2. net/octeon_ep: add missing vector API header include
3. distributor: add missing vector API header include
4. fib: add missing vector API header include
5. eal: provide option to use compiler memcpy instead of RTE
6. ci: test compiler memcpy
7. vhost: optimize memcpy routines when cc memcpy is used

---

## Patch 1/7: event/dlb2: include headers for vector and memory copy APIs

### Info
- Well-structured commit message explaining the issue and fix
- Proper Signed-off-by and Acked-by tags
- Correctly formatted subject line

### No Issues Found
This patch is clean and follows guidelines.

---

## Patch 2/7: net/octeon_ep: add missing vector API header include

### Warning
**Include order issue**: The `<rte_vect.h>` include is placed after `<ethde=
v_pci.h>`, but according to AGENTS.md guidelines, DPDK EAL includes should =
come before DPDK misc library includes, and there should be a blank line se=
parating groups.

```c
#include <inttypes.h>
#include <ethdev_pci.h>

#include <rte_vect.h>
```

Consider placing `<rte_vect.h>` in the proper order relative to other DPDK =
includes.

### No Other Issues Found
Otherwise clean patch.

---

## Patch 3/7: distributor: add missing vector API header include

### Info
- Clean patch with proper formatting

### No Issues Found
This patch is clean and follows guidelines.

---

## Patch 4/7: fib: add missing vector API header include

### Info
- Clean patch with proper formatting

### No Issues Found
This patch is clean and follows guidelines.

---

## Patch 5/7: eal: provide option to use compiler memcpy instead of RTE

### Error
**Release notes formatting issue**: The release notes have an extra blank l=
ine after the "destination buffers)." line:

```rst
  destination buffers).
                        <-- extra blank line here
Removed Items
```

The blank line should be removed or the section should end properly before =
"Removed Items".

### Warning
**Line length in meson_options.txt**: The description line for `use_cc_memc=
py` may exceed typical line length conventions:

```python
option('use_cc_memcpy', type: 'boolean', value: false, description:
       'Have the functions of <rte_memcpy.h> delegate to compiler/libc memc=
py() instead of using custom implementation.')
```

This is a long line (approximately 119 characters). Consider breaking it.

### Info
- Good use of `#ifdef __cplusplus` guards in generic/rte_memcpy.h
- Proper SPDX identifiers maintained
- Good documentation in release notes

---

## Patch 6/7: ci: test compiler memcpy

### Error
**Copy-paste error in linux-build.sh**: Both branches of the if statement s=
et the same value:

```bash
if [ "$CCMEMCPY" =3D "true" ]; then
	OPTS=3D"$OPTS -Duse_cc_memcpy=3Dtrue"
else
	OPTS=3D"$OPTS -Duse_cc_memcpy=3Dtrue"  # <-- Should be false
fi
```

The `else` branch should set `-Duse_cc_memcpy=3Dfalse`.

### Info
- Good addition of CI coverage for the new feature

---

## Patch 7/7: vhost: optimize memcpy routines when cc memcpy is used

### Warning
**Brace style inconsistency**: The `if-else` statement uses braces for the =
`if` block but not for the `else` block:

```c
	if (len <=3D 256) {
		size_t left;

		for (left =3D len; left >=3D 32; left -=3D 32) {
			memcpy(dst, src, 32);
			dst =3D RTE_PTR_ADD(dst, 32);
			src =3D RTE_PTR_ADD(src, 32);
		}

		memcpy(dst, src, left);
	} else
		memcpy(dst, src, len);
```

According to DPDK coding style, when one branch has braces, consistency sug=
gests the other should too, or both should be without braces if they're sin=
gle statements. However, the DPDK guidelines show examples where this mixed=
 style is acceptable.

### Info
- Good performance documentation in the commit message
- Proper use of `__rte_always_inline`
- Good use of `restrict` keyword
- Appropriate use of `__builtin_assume_aligned`
- Well-documented rationale for the optimization

### No Other Issues Found
This patch is otherwise clean.

---

## Overall Assessment

### Errors (Must Fix)
1. **Patch 6/7**: Copy-paste error in `.ci/linux-build.sh` - both if branch=
es set `use_cc_memcpy=3Dtrue`

### Warnings (Should Fix)
1. **Patch 2/7**: Include order could be improved for consistency
2. **Patch 5/7**: Long line in meson_options.txt description
3. **Patch 5/7**: Extra blank line in release notes before "Removed Items"

### Info (Consider)
- All patches have proper Signed-off-by tags
- Subject lines are within 60 character limit
- Commit messages are well-written and explain the rationale
- Proper use of Acked-by tags from reviewers

The critical bug in Patch 6/7 should be fixed before merging - the else bra=
nch should set `-Duse_cc_memcpy=3Dfalse` instead of `true`.

