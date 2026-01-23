Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A205D6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 05:01:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C4F040262;
	Fri, 23 Jan 2026 06:01:56 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 9C21D40262
 for <dev@dpdk.org>; Fri, 23 Jan 2026 06:01:55 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so24464075e9.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 21:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769144515;
 x=1769749315; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11FRdbjkpJGkMzwczYKZmlazgo+koEveaJdfPYvOTN0=;
 b=Lr8/0jw0PLPLKmmT8Sb1ZDwyz16hiExo56PTAiVZM5RU4nCL8XlKaq+OWwQNuzpgJE
 d5jhx3oUORdDPMU6H7CfD2+XJWjFWxQHG7vFFjjPEQaDeiONQ7m2xkAZ0K7tar1+YL0o
 be9QCzXt3oKXIsrV5bWqLMbFVrUD3eHPPJ0pS+QpIat/pkB4I9QlTUiLXlah6tCX/H+J
 wNAi+tymxjXgZMGdvXsWmZ33Tx5H8Ns6DtNQjgnhUswzxsAOu/ozUgs57N7poIu6Sj9X
 ieJ1gzTL3Eo4DV0AZlAf+8ETZ845D06nU6u2U+Un256l35zvj5LigsnGwTvD7yRAVHEH
 QHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769144515; x=1769749315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=11FRdbjkpJGkMzwczYKZmlazgo+koEveaJdfPYvOTN0=;
 b=tiCV+zE8xorviwo8j47dLV8RfK6mnxSxZhmfWjMtILdIG2b3KhCQJqtVSu3FHc+gqf
 0J9nW8kXkHEZJQFmWK4gYJtHESEvVnA8An8fsCQuUjq15xjwrSqLGGxPppuTc6v5hqbC
 WusDXU4T4kTpRSeTMQg0EItSMLv5HXJzEhS96EikhgDKRU4NHcDAwU6k5xnZgEklMO4a
 hiSMnFDjtBig1J/xgiCpPZRR7YN/AIdPajgl2rtc1RU8lRO6NJ1EEsUu3VWUuCMsVPG8
 uJgoDcobWhX9UrnXiH1ysKiEemM/mhnx6tBovna9d+HjI2tCrz/N04HtPg7iHDEBlZp9
 hrzQ==
X-Gm-Message-State: AOJu0Yy4rYuVQ8Gz3eDYWm0kcZeXFa53J0A9Dxb+Y58P6NUFYjjlQUM2
 2mger/GQCHvqy2RAtfBReVpKNffrDF+kjvYYOwPTLZA7cylFwxRqPgW7sooz4IOcUPM=
X-Gm-Gg: AZuq6aL5jHTerG/RzKbFzYAkj3F/OysMs1wfTFzHTBTJtvuq++50605jf1AJX/w//Fs
 7adA+FHOUAD7w+iO65Cz07A0YjSPalEipt9xIwMvmCFgy8Qh0ZlT5eOrtpkIX0Lo8+rwFDDnFHk
 ixUdCa3qYyYAhSCVpeG1eGuphFGctTIwuRLVK7W0kMQIYM6ptrrdJ8GNrIiDXTlQPwXE74H1/16
 dLv0EmDvBCsjUryKkjdRR2X+tLwT/Ny3IWNKpYLAl2mizzi/ys4j7272Hehs9S4dD8jXNs2jr2J
 3Vnk+ldOHQ4oyhThmNnKmGHvH/TpFtWyXg3yzPiAcMbWonbYCFRlAGWCuCqo5Pn9WdVTh0DkPY2
 DDlz2ZSO8WlZwJS92U1OkkbQ9vY8UD12uII9PgOHFb7D44L2w3ljVtiv4mySZKI4pKQrr9//adP
 CYlCrxEvALpy/JMZY7NiQ+VVS4GtUH/NjHYnvzlhOFSNWHTiKKB4FQAT7MSU0svEg=
X-Received: by 2002:a05:6000:2512:b0:430:fdfc:7dd3 with SMTP id
 ffacd0b85a97d-435b16058a7mr2821325f8f.50.1769144514910; 
 Thu, 22 Jan 2026 21:01:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e7156dsm3524877f8f.20.2026.01.22.21.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 21:01:54 -0800 (PST)
Date: Thu, 22 Jan 2026 21:01:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>, <honnappa.nagarahalli@arm.com>, <jerinj@marvell.com>,
 <hemant.agrawal@nxp.com>, <drc@linux.ibm.com>
Subject: Re: [PATCH v1 0/4] ring: some fixes and improvements
Message-ID: <20260122210148.13684289@phoenix.local>
In-Reply-To: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
References: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
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

On Wed, 21 May 2025 12:14:28 +0100
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> First two patches are =E2=80=98low risk=E2=80=99 ones.
> Third one touches some core functions within rte_ring library and
> would probably requires extra reviews/testing from different vendors.
> 4th one enables C11 based code on all x86 platforms by default.
> The stretch goal for it =E2=80=93 make all supported platforms to use C11
> based code and get rid of legacy code in rte_ring_generic_pvt.h.
> If there would be some issues with latest two patches =E2=80=93 we can li=
mit
> ourselves with just first two to apply.
>=20
> Konstantin Ananyev (4):
>   ring: introduce extra run-time checks
>   ring/soring: fix head-tail synchronization issue
>   ring: fix potential sync issue between head and tail values
>   config/x86: enable RTE_USE_C11_MEM_MODEL by default
>=20
>  config/x86/meson.build           |  1 +
>  lib/ring/rte_ring_c11_pvt.h      | 29 ++++++++++++++++++-----------
>  lib/ring/rte_ring_elem_pvt.h     |  8 ++++++--
>  lib/ring/rte_ring_hts_elem_pvt.h | 14 ++++++++++----
>  lib/ring/rte_ring_rts_elem_pvt.h | 14 ++++++++++----
>  lib/ring/soring.c                |  2 ++
>  6 files changed, 47 insertions(+), 21 deletions(-)
>=20

This patch needs work before being seriously considered.


Lots of feedback on this series is not addressed. No longer applies to main,
and AI had more to say.

=3D=3D=3D Patch Review: bundle-1678-ring-fix.mbox (via Claude) =3D=3D=3D
# DPDK Patch Review: bundle-1678-ring-fix.mbox

## Overview
This patch series (4 patches) addresses ring synchronization issues and int=
roduces runtime checks for the DPDK ring library. The series includes bug f=
ixes for head-tail synchronization problems discovered on ARM platforms and=
 enables C11 memory model by default on x86.

---

## Patch 1/4: ring: introduce extra run-time checks

### Errors

1. **Missing SPDX license identifier in modified files**
   - The patch modifies existing files but doesn't show the license headers=
. Assuming they exist in the original files, this is acceptable.

2. **Double space in commit message body**
   - Line: "return meaningful  *entries value" has two spaces before `*entr=
ies`

### Warnings

1. **Subject line could be more descriptive**
   - Current: "ring: introduce extra run-time checks"
   - The subject is acceptable but could specify "RTE_ASSERT checks" for cl=
arity

2. **Missing Cc: stable@dpdk.org**
   - This patch adds debugging assertions which could be useful for stable =
releases, though it's primarily a development aid

### Info

1. **Good practice**: Adding `RTE_ASSERT()` checks helps catch programming =
errors during development
2. **Code change in rte_ring_c11_pvt.h**: Moving `*new_head =3D *old_head +=
 n;` before the early return is a behavioral change that should be document=
ed in the commit message

---

## Patch 2/4: ring/soring: fix head-tail synchronization issue

### Errors

1. **Missing `Cc: stable@dpdk.org`**
   - This is a bug fix with a `Fixes:` tag, so it should include `Cc: stabl=
e@dpdk.org` for backport consideration

### Warnings

1. **Commit message body line exceeds 75 characters**
   - Multiple lines exceed the 75-character limit:
     - "I believe that we are hitting the following race-condition scenario=
 here:" (72 chars - OK)
     - "Note that this issue happens only on the second iteration of" (61 c=
hars - OK)
     - But several lines like "One extra thing to note =E2=80=93 I think th=
e same problem potentially exists" appear close to or exceed the limit
   - Lines with em-dashes (=E2=80=93) and technical content should be wrapp=
ed properly

2. **Use of non-ASCII characters**
   - The commit message uses em-dashes (=E2=80=93) instead of regular hyphe=
ns (-) or double hyphens (--)
   - Example: "i.e. =E2=80=93 when we use" should be "i.e., when we use" or=
 "i.e. - when we use"

3. **Commit message starts explanation with scenario numbers but inconsiste=
nt formatting**
   - The numbered steps (1, 2, 3) are good for clarity but formatting varies

### Info

1. **Well-documented bug analysis**: The commit message provides excellent =
context about the race condition
2. **Alternative solution mentioned**: The commit notes an alternative fix =
approach (using Acquire-Release for CAS), which is helpful for reviewers
3. **The fix adds memory fences after tail updates** - this is a valid appr=
oach but patch 3/4 provides a potentially cleaner solution

---

## Patch 3/4: ring: fix potential sync issue between head and tail values

### Errors

1. **Missing `Cc: stable@dpdk.org`**
   - This is a bug fix with multiple `Fixes:` tags, so it should include `C=
c: stable@dpdk.org`

2. **Fixes tags may reference commits not in stable branches**
   - `Fixes: 49594a63147a ("ring/c11: relax ordering for load and store of =
the head")` - verify this is the correct commit

### Warnings

1. **Commit message body line length issues**
   - Several lines appear to exceed 75 characters
   - Technical explanations should be wrapped appropriately

2. **Use of non-ASCII characters**
   - Similar to patch 2/4, uses em-dashes (=E2=80=93) instead of ASCII hyph=
ens

3. **Incomplete sentence in commit message**
   - "But, so far I didn't manage to reproduce it in reality." - grammatica=
lly fine but informal

4. **Comment style inconsistency in code**
   ```c
   /*
    * on failure, *old_head is updated.
    * this CAS(ACQ_REL, ACQUIRE) serves as a hoist
    ```
   - Comment starts with lowercase after `/*` which is inconsistent with DP=
DK style (should start with uppercase or use `/* lowercase */` format consi=
stently)

### Info

1. **This patch supersedes patch 2/4's approach** - The series structure is=
 logical: patch 2 provides a quick fix, patch 3 provides the "better" fix
2. **Removes the fences added in patch 2/4** - This is correct as the CAS o=
rdering change makes them unnecessary
3. **Performance consideration noted** - Good that the author tested perfor=
mance impact

---

## Patch 4/4: config/x86: enable RTE_USE_C11_MEM_MODEL by default

### Errors

None identified.

### Warnings

1. **Missing documentation update**
   - Enabling `RTE_USE_C11_MEM_MODEL` by default on x86 is a significant ch=
ange that should be noted in release notes
   - Consider adding an entry in `doc/guides/rel_notes/release_XX_XX.rst`

2. **Potential ABI/behavior change**
   - While this shouldn't cause ABI issues, it changes the default behavior=
 on x86 platforms
   - Applications may see different performance characteristics

### Info

1. **Good direction**: Moving toward C11 memory model is the modern approach
2. **Completes the series**: This patch makes sense in context of the synch=
ronization fixes
3. **Subject line is clear and accurate**

---

## General Series Issues

### Warnings

1. **Series ordering consideration**
   - Patches 2 and 3 both fix the same underlying issue differently
   - Patch 3 removes code added by patch 2
   - Consider squashing patches 2 and 3, or clearly document in patch 2 tha=
t it's a "temporary" fix superseded by patch 3

2. **Missing cover letter context in individual patches**
   - Each patch should stand alone for `git bisect`, but the relationship b=
etween patches 2 and 3 could be clearer

### Info

1. **Good testing evidence**: The author mentions specific test failures an=
d hardware (Ampere Altra Max)
2. **Comprehensive fix approach**: The series addresses the issue at multip=
le levels

---

## Summary

| Severity | Count | Key Issues |
|----------|-------|------------|
| Error | 2 | Missing `Cc: stable@dpdk.org` for bug fixes (patches 2, 3) |
| Warning | 10 | Line length issues, non-ASCII characters, missing release =
notes, comment style |
| Info | 8 | Good documentation, well-reasoned fixes, performance considera=
tion |

### Recommended Actions

1. **Add `Cc: stable@dpdk.org`** to patches 2/4 and 3/4
2. **Wrap commit message lines** to stay within 75 characters
3. **Replace em-dashes (=E2=80=93)** with regular hyphens or double hyphens
4. **Add release notes entry** for enabling C11 memory model on x86
5. **Consider squashing patches 2 and 3** or better documenting their relat=
ionship
6. **Fix double space** in patch 1/4 commit message

