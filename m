Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09234D31A0E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 05:07:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B6DC4028F;
	Wed, 14 Jan 2026 06:07:36 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 6298C40289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 06:07:34 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso33626105e9.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768367254;
 x=1768972054; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lo+WNA5AqiheVW6xLxj+HqkMQJD0h7jR94ciObmHRBk=;
 b=fvc5gq3FjVog7+zOfL6eUeOSzO9TWtxsUbsNrNTuV87imPVyQImO0yENRNbTSpD9Ct
 hT3voE3HvCBuBCgOVUQ06COvrxhrNuZXLiLDii09OF4xgfryTsCOvvX2+EA6T8zAVlR5
 POUbbULAv3QVuVhb5KW0oaUVEbA41Ovz2LufSNBQqY8W+dtV1JU+hCx9ADsMkCteLCAS
 S1lC8fiBKiPpPQFxqmHjHs8/Kgo8BjmoFzoMEMRJWOeA4b7TvKRWcZnBi0IndlHK6f9a
 25QpRaj17DBU34ak1w7f1Xi8fYfXU8dcreIvjwmUOIfQx9rlSCusSYHJJSWF8SoADS+T
 xh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768367254; x=1768972054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lo+WNA5AqiheVW6xLxj+HqkMQJD0h7jR94ciObmHRBk=;
 b=TTmq+sIkcp+dhpD3Z56XTBdqaiLxoozu9u7QceyFTTbby6sFA9BWYN2Ny1pK/1hAaR
 2VLyN65hXfe5V/mTfv3L+aA0bpdl5AvC3Yx7dBAFZ7ChRUDLs3kDJlE4FHFmL4ooLWDc
 Xb0WaXQ21x6pkR9TKjaQmWcZSjsP/sNJI+YEe/5hbM/OAkRBrKz7qu9qBVcOF0OXj7QK
 U9Z4EWf3XEboFf5JxDEFabiwae0yQCWpmz2HyysNL/2IKeLABlnbYZnbH9Au4OIHijKm
 GYa115IQRtCtT8JVPY7vZmzhHIih8swRMpDiiPo/gKhWKVSmje6KyS898EL2buTuhMz8
 VsSg==
X-Gm-Message-State: AOJu0YwtvwQ2FIbK+8FvuHHAdhWeYKOtSjTY5p1rk3IWpgU+g6KSdWz9
 YrEyJSOj0TzMNGpDiMC+kkrFnhbnVlmgM6eJgSdiNo5YRAXgYT7k/YHcYptwobV88AM=
X-Gm-Gg: AY/fxX54MT2M0ihiI6lh1V2C88AffGq6vQ3KwU43+62Kb0CId6d0h2T2Spawiseoz+g
 0WYl1zBEdLJzUgGztY6CoEGogiL/YRgHA5iaDPmv++MGSSKFBxfeiJszg1wr8mWpnMmM9FvwkZy
 LybWAOTHCU4koS8eUa785uA+y5GHClFgDHoD0qiUnRpsMP8WsGNwq8fm2CAdOq63jlGtIEnbBS4
 I+UaDWF/dh1pnM88qHab6LIi8srnkWFWv8Gs6Fjdy9MhY5k49oY8SOtm+4c/ByuHhMS6jDwObZI
 7CA2+PBC7hM2QlwcAF6WSgAWcNw6FSWNO2B7BR5vkkvz6Qpba9SXiZVKeq4laz4R8h+AW5iOzu9
 bqqiCxbuDWUO7ORXBsO1rq7biFsdB0g+oH4H2jijuk4UB+4K2KtU0F7Y/Rp+USyjETzjNgGocB9
 324F2ZgEXSkLEZLEN5+WgH8Iyr5VqRzIdH01F8RlkNuP+FkaSLJvg5
X-Received: by 2002:a05:600c:c16f:b0:47e:e20e:bba3 with SMTP id
 5b1f17b1804b1-47ee3318aaemr11159755e9.7.1768367253964; 
 Tue, 13 Jan 2026 21:07:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee0baf482sm14028955e9.2.2026.01.13.21.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 21:07:33 -0800 (PST)
Date: Tue, 13 Jan 2026 21:07:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, david.marchand@redhat.com
Subject: Re: [PATCH RESEND] malloc: fix allocation for a specific case with
 ASan
Message-ID: <20260113210727.5a902757@phoenix.local>
In-Reply-To: <20241017100207.1207-1-artur.paszkiewicz@intel.com>
References: <20241017100207.1207-1-artur.paszkiewicz@intel.com>
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

On Thu, 17 Oct 2024 12:02:06 +0200
Artur Paszkiewicz <artur.paszkiewicz@intel.com> wrote:

> Allocation would fail with ASan enabled if the size and alignment was
> equal to half of the page size, e.g.:
>=20
> size_t pg_sz =3D 2 * (1 << 20);
> rte_malloc(NULL, pg_sz / 2, pg_sz / 2);
>=20
> In such case, try_expand_heap_primary() only allocated one page but it
> is not enough to fit this allocation with such alignment and
> MALLOC_ELEM_TRAILER_LEN > 0, as correctly checked by
> malloc_elem_can_hold().
>=20
> Signed-off-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> ---

Looks like this patch got stuck in limbo because of the sporadic CI test fa=
ilures.

AI code review likes it bu has some suggestions:


## DPDK Patch Review: malloc: fix allocation for a specific case with ASan

### Summary
This is a well-crafted bug fix patch that addresses an allocation failure w=
hen ASan is enabled and the allocation size/alignment equals half the page =
size. The patch is concise, well-explained, and correctly structured.

---

### Errors (Must Fix)

**None identified.** The patch passes all mandatory checks.

---

### Warnings (Should Fix)

**1. Consider Adding `Cc: stable@dpdk.org`**

This fixes a real allocation failure that affects ASan users. If this bug e=
xists in stable branches, it would be a good candidate for backporting. Per=
 guidelines: "For stable release backport candidates: `Cc: stable@dpdk.org`"

**2. Consider Adding a `Fixes:` Tag**

If this is a regression introduced by a specific commit (for example, when =
ASan support or `MALLOC_ELEM_TRAILER_LEN` was added), a `Fixes:` tag would =
help identify which stable branches need the fix:

```
Fixes: <12-char-sha> ("original commit that introduced the bug")
Cc: stable@dpdk.org
```

If this is a latent bug that existed since the original implementation, the=
 `Fixes:` tag may not be necessary, but `Cc: stable@dpdk.org` would still b=
e appropriate.

---

### Info (Consider)

**1. Test Coverage**

Consider whether a unit test could be added to `app/test` to verify this sp=
ecific allocation pattern works correctly with ASan enabled. This would pre=
vent regression. Example test case based on the commit message:

```c
/* Test allocation where size =3D=3D align =3D=3D pg_sz/2 */
size_t pg_sz =3D 2 * (1 << 20);  /* 2MB */
void *ptr =3D rte_malloc(NULL, pg_sz / 2, pg_sz / 2);
TEST_ASSERT_NOT_NULL(ptr, "Allocation failed for size=3Dalign=3Dpg_sz/2");
rte_free(ptr);
```

**2. Code Comment**

The fix changes the allocation size calculation logic. A brief inline comme=
nt explaining the worst-case alignment scenario could help future maintaine=
rs:

```c
/* Account for worst-case alignment: header may need to be padded up to 'al=
ign',
 * plus the element size, plus trailer (non-zero when ASan is enabled).
 */
alloc_sz =3D RTE_ALIGN_CEIL(RTE_MAX(MALLOC_ELEM_HEADER_LEN, align) +
        elt_size + MALLOC_ELEM_TRAILER_LEN, pg_sz);
```

---

### Checklist Summary

| Category | Status |
|----------|--------|
| Subject line =E2=89=A460 chars | =E2=9C=93 (50 chars) |
| Correct component prefix (`malloc:`) | =E2=9C=93 |
| Lowercase after colon | =E2=9C=93 |
| Imperative mood, no trailing period | =E2=9C=93 |
| Body wrapped at 75 chars | =E2=9C=93 |
| Body does not start with "It" | =E2=9C=93 |
| Signed-off-by present | =E2=9C=93 |
| `Fixes:` tag (if applicable) | ? (see warning) |
| `Cc: stable@dpdk.org` (if applicable) | Missing |
| Code changes are minimal and focused | =E2=9C=93 |
| Changes are consistent across both files | =E2=9C=93 |

---

### Technical Assessment

The fix looks correct. The original calculation:
```c
RTE_ALIGN_CEIL(elt_size, align) + MALLOC_ELEM_OVERHEAD
```

...doesn't properly account for the case where alignment padding before the=
 user data could push the trailer beyond the allocated page boundary. The n=
ew calculation:
```c
RTE_MAX(MALLOC_ELEM_HEADER_LEN, align) + elt_size + MALLOC_ELEM_TRAILER_LEN
```

...correctly computes the worst-case space needed: the header (or alignment=
, whichever is larger) plus the actual element size plus the trailer.

---

### Verdict

**Ready to merge** with minor suggestions. This is a clean, focused bug fix=
. The only recommendations are:

1. Add `Cc: stable@dpdk.org` if this should be backported
2. Optionally add a `Fixes:` tag if the originating commit can be identified

The patch could be accepted as-is, but a v2 with `Cc: stable@dpdk.org` woul=
d be ideal for ensuring the fix reaches stable branches.
