Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D8EEEA869
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 22:55:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 271B44025F;
	Thu, 12 Feb 2026 23:55:53 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 21BEC40041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 23:55:52 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-483337aa225so1473385e9.2
 for <dev@dpdk.org>; Thu, 12 Feb 2026 14:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770936951;
 x=1771541751; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QbotkPfVgVwb/3wyenJXJhz+hiIuBcqXoGj+dVrscM=;
 b=AbBOr1ubvxtYAJMQxsXVWk+eybH7gnHZxPr7Dkllz/0eSEPIJAcS5q9rWKUcJG5Hx7
 SNbh6bheSbAhgIUkD8cZhfMRdUMwymYprWz7v90V4nadZe5wQnu5YVFxNBLdgsSmQL+L
 bYs3nAYkS3K+yCF5O2BmhQC1R0wJuIa9slpKfbj0OqXazDKM85NxUzvFx+r+XrEHR6yW
 y8o3z+sagTDKvUuqwI+m7uKvwwPleGvN4yUkOITob+2dly5GHCM4Svb06erlDiA5WOWB
 7ZQyqHMrCuE2J9qCHT1KzMTjbBCcIeOXCkr6GNOVifIqvz3SOkh7tR5UuZehAsbak4/u
 pnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770936951; x=1771541751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6QbotkPfVgVwb/3wyenJXJhz+hiIuBcqXoGj+dVrscM=;
 b=vCslrmATZimJ8xlDj8epInLhJLKVAXpoCbJye/CXUP3UW8GSc4XVE76B8hvzbvFqKe
 PWWy3xvndXQV61tCvCrCkv5IzqikW7aycyBCUJH3d1MaPKzuCB0Vjufc+A2B6lA0qUyj
 rOE7NKiGkca1oVMNI+bPIJZdnGTKwZHxFnG5urX8u3ZAZTx7I9iHrMPT6F523QEAEFL/
 YUMVNPgGEsJI3ertJgaStM7mBauDuKKkcUe7AZdHCkQI7mX98Fji6u5fhz7qktIh+Ltc
 sXIEsA+rtTMHnPoaMqsuaifP/I/cFI++A2422CQHNAJ80UIIWxQ8LJOaBg2PfQP/vZyx
 dUvw==
X-Gm-Message-State: AOJu0Yw0SXHG5eMSLiHxY2M0N7aOYq9rTrmTMTJEpDHGlO2hkx9Zypju
 QvGao+0lTtPN5mwY3ehzVZjtMSE6ksR2Q0/nUMEaPHw3cS5a7GUOGaO2y3xp4FSTFFE=
X-Gm-Gg: AZuq6aL/X9HNx/4sdMfqQsACgELqGJCaH6J3agInTngjr0mZ/DQsH7cBHT4oi5xC/6m
 /wQZSThF+QzH6P7TVI6roh0lCln3cruwGo265jKuXDdGcSyYtbvPhrtH77j6ne5TvQGmRGcU+TO
 +5Lnv6A3llbzTamiBVwEh6UQ+Au4wi8/nnaWcR2x3mW+rllLIlfN8nwku9D3ljUO0e4ojz7Yxpt
 cIbdtJYVxHtm7noZSd2SE76gCzWJkNxIyb8aPTArqXh1YdEGnVg52KIFDuy8LCpK3q6x9ELIWd8
 sfIOoqsxImW9C6T4ND1BDGGY/Hzjo1KIZpKXZvcUoEUv+fJ6HRl2B/U1arOsWBQHMBGWVtgAp9W
 0SRHkL618gIaEhOV6HOCgxrs6b6PRa5tJslBRfy3a0rO5NCNSybtpiJgt1uJeQOP71gdq2BRjsO
 PItHC60f/MNemAe5F+LGAFBocunqst0ZACggw8Y/WOWrlK/EWmZ3QX1M56J8NO70Y/
X-Received: by 2002:a05:600c:4712:b0:483:885:f0b0 with SMTP id
 5b1f17b1804b1-4837104de29mr11353225e9.35.1770936951259; 
 Thu, 12 Feb 2026 14:55:51 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d994670sm122231455e9.4.2026.02.12.14.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 14:55:51 -0800 (PST)
Date: Thu, 12 Feb 2026 14:55:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk 0/2] hash: safe data replacement on overwrite
Message-ID: <20260212145545.79d661dd@phoenix.local>
In-Reply-To: <20260212213313.1376294-5-rjarry@redhat.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
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

On Thu, 12 Feb 2026 22:33:15 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> When rte_hash_add_key_data() is called with an existing key, the old
> data pointer is silently overwritten. With RCU-protected readers still
> potentially accessing the old data, the application cannot safely free
> it since the old pointer is never returned.
>=20
> This series provides two ways to address the problem:
>=20
> * Automatic: when RCU is configured with a free_key_data_func callback,
>   rte_hash_add_key_data() now automatically defers freeing the old data
>   on overwrite. No caller changes are needed.
>=20
> * Explicit: a new rte_hash_replace_key_data() API returns the previous
>   data pointer via an output parameter, giving the caller full control
>   over the old pointer's lifecycle. No automatic deferred free is
>   performed in that case.
>=20
> Robin Jarry (2):
>   hash: free replaced data on overwrite when RCU is configured
>   hash: add replace API returning old data on overwrite
>=20
>  app/test/test_hash.c                   | 214 +++++++++++++++++++++++++
>  doc/guides/rel_notes/release_26_03.rst |  12 ++
>  lib/hash/rte_cuckoo_hash.c             | 146 +++++++++++++----
>  lib/hash/rte_hash.h                    |  75 ++++++++-
>  4 files changed, 417 insertions(+), 30 deletions(-)


Subtle change, so fed to AI and got.

Here's the deep dive review. The two most substantive findings:

1. Fragile overwrite/delete discriminator in
__hash_rcu_qsbr_free_resource =E2=80=94 The dequeue callback uses old_data =
!=3D
NULL to distinguish overwrite entries from delete entries, but the
enqueue side already sets key_idx =3D 0 as a sentinel for overwrites.
Using key_idx =3D=3D 0 would be more robust, because if an application
legitimately stores NULL data and overwrites the key, the current code
will fall through to the delete path and try to recycle key index 0
(the dummy slot).

2. Leaked old data on rte_rcu_qsbr_dq_enqueue failure =E2=80=94 The enqueue
failure in __hash_rcu_auto_free_old_data logs an error but the old data
becomes permanently unreachable. This is consistent with the existing
delete-path pattern, but it's a real resource leak on error. The
overall design is solid =E2=80=94 the split between automatic RCU free (pat=
ch
1) for existing users and explicit replace API (patch 2) for
fine-grained control is clean, and the interaction between the two is
correctly ordered in the overwrite: label.

Long review.

# DPDK Hash Library Patch Series Review

**Series**: hash: free replaced data on overwrite / add replace API
**Author**: Robin Jarry <rjarry@redhat.com>
**Patches**: 2
**Date**: 2026-02-12

---

## Patch 1/2: hash: free replaced data on overwrite when RCU is configured

### Summary

When `rte_hash_add_key_data()` overwrites an existing key, the old data poi=
nter was silently lost. With RCU-protected readers still potentially access=
ing the old data, applications had no safe way to free it. This patch adds =
automatic deferred freeing of the old data pointer via the RCU defer queue =
when a `free_key_data_func` callback is configured.

### Correctness Analysis

#### **Error =E2=80=94 Potential use of NULL data treated as "no overwrite"=
 (Medium confidence ~60%)**

In `__rte_hash_add_key_with_hash()`, the overwrite detection relies on:

```c
overwrite:
    if (saved_old_data !=3D NULL)
        __hash_rcu_auto_free_old_data(h, saved_old_data);
    return ret;
```

If an application legitimately stores `NULL` as the data pointer for a key =
(which `rte_hash_add_key_data()` permits =E2=80=94 `data` is `void *` with =
no restriction against NULL), and then overwrites that key with new data, `=
saved_old_data` will be `NULL` and the overwrite path will silently skip th=
e auto-free. This is probably fine for the auto-free case (freeing NULL is =
a no-op anyway), but it means the code cannot distinguish "no overwrite hap=
pened" from "overwrite happened, old data was NULL." This becomes more sign=
ificant in Patch 2/2 where `old_data` is exposed to the caller =E2=80=94 se=
e below.

#### **Error =E2=80=94 `__hash_rcu_qsbr_free_resource` overwrite detection =
uses `old_data !=3D NULL` sentinel (Medium-high confidence ~70%)**

In the dequeue callback:

```c
/* Overwrite case: free old data only, do not recycle slot */
if (rcu_dq_entry.old_data !=3D NULL) {
    h->hash_rcu_cfg->free_key_data_func(
        h->hash_rcu_cfg->key_data_ptr,
        rcu_dq_entry.old_data);
    return;
}
```

This uses `old_data !=3D NULL` to distinguish overwrite entries from delete=
 entries. But overwrite entries are enqueued with `key_idx =3D 0` as the se=
ntinel:

```c
struct __rte_hash_rcu_dq_entry rcu_dq_entry =3D {
    .key_idx =3D 0,
    .ext_bkt_idx =3D EMPTY_SLOT,
    .old_data =3D old_data_val,
};
```

The `key_idx =3D=3D 0` check would be a more robust sentinel since key inde=
x 0 is the reserved dummy entry in the cuckoo hash. Using `old_data !=3D NU=
LL` means that if someone stores NULL data and then overwrites, the entry f=
lows through to the delete path which will try to access `keys[0]` =E2=80=
=94 the dummy slot. The consequences depend on what's in the dummy slot, bu=
t it's at minimum semantically wrong. **Recommendation**: check `key_idx =
=3D=3D 0` instead of `old_data !=3D NULL` as the overwrite discriminator:

```c
if (rcu_dq_entry.key_idx =3D=3D 0) {
    /* Overwrite case */
    if (rcu_dq_entry.old_data !=3D NULL)
        h->hash_rcu_cfg->free_key_data_func(...);
    return;
}
```

#### **Error =E2=80=94 Missing error check on `rte_rcu_qsbr_dq_enqueue` (Lo=
w-medium confidence ~55%)**

In `__hash_rcu_auto_free_old_data()`:

```c
if (rte_rcu_qsbr_dq_enqueue(h->dq, &rcu_dq_entry) !=3D 0)
    HASH_LOG(ERR, "Failed to push QSBR FIFO");
```

The enqueue failure is logged but the old data pointer is leaked. The overw=
rite has already happened (the data in the hash table has been updated), so=
 by the time we reach this point, the old data is unreachable. If enqueue f=
ails, the old data will never be freed. This is a resource leak on a (presu=
mably rare) error path. The existing delete path in `__rte_hash_del_key_wit=
h_hash` has the same pattern, so this is consistent with existing code, but=
 it's worth noting that a failed enqueue here means a permanent memory leak=
 of the old data.

#### **Warning =E2=80=94 Behavioral change in the ext-table duplicate-check=
 path**

In the extended-table section of `__rte_hash_add_key_with_hash`, the origin=
al code jumped to `failure:` when a duplicate was found (which unlocked and=
 returned). The new code jumps to `overwrite:` after explicitly unlocking:

```c
ret =3D search_and_update(h, data, key, prim_bkt, short_sig,
            &saved_old_data);
if (ret !=3D -1) {
    enqueue_slot_back(h, cached_free_slots, slot_id);
    __hash_rw_writer_unlock(h);
    goto overwrite;
}
```

This is correct =E2=80=94 the unlock happens before the goto, and `overwrit=
e:` doesn't attempt to unlock. Just confirming this is safe. The change fro=
m `goto failure` to explicit unlock + `goto overwrite` is necessary and cor=
rect.

### Test Coverage

The test `test_hash_rcu_qsbr_replace_auto_free` is well-structured:
- Creates hash with RW_CONCURRENCY_LF and RCU QSBR in DQ mode
- Registers a pseudo reader
- Tests overwrite + reclaim, then delete + reclaim
- Verifies the callback receives the correct old data pointers
- Proper cleanup in the `end:` label

The cleanup path correctly handles the case where `rcu.v` might be NULL (sk=
ipping thread offline/unregister). `rte_hash_free(NULL)` and `rte_free(NULL=
)` are both safe.

### Documentation

Release notes entry is appropriate and well-written. The API doc updates to=
 `rte_hash.h` clearly document the new behavior.

---

## Patch 2/2: hash: add replace API returning old data on overwrite

### Summary

Adds `rte_hash_replace_key_data()` and `rte_hash_replace_key_with_hash_data=
()` =E2=80=94 variants of the add APIs that return the previous data pointe=
r via an output parameter. When the caller provides `old_data`, no automati=
c RCU deferred free is performed; the caller takes ownership.

### Correctness Analysis

#### **Error =E2=80=94 `saved_old_data` initialized to NULL but not reset b=
etween paths (Medium confidence ~65%)**

In `__rte_hash_add_key_with_hash`, `saved_old_data` is initialized to `NULL=
` at declaration. The function has multiple `search_and_update` calls, each=
 of which may or may not set `saved_old_data`. If a first `search_and_updat=
e` call doesn't find the key (returns -1), `saved_old_data` stays NULL. A l=
ater call that does find the key will set it. This is correct. However, con=
sider the path where `rte_hash_cuckoo_insert_mw` returns 1 (key found durin=
g insert):

```c
ret =3D rte_hash_cuckoo_insert_mw(h, prim_bkt, sec_bkt, key, data,
                short_sig, slot_id, &ret_val,
                &saved_old_data);
if (ret =3D=3D 0)
    return slot_id - 1;
else if (ret =3D=3D 1) {
    enqueue_slot_back(h, cached_free_slots, slot_id);
    ret =3D ret_val;
    goto overwrite;
}
```

On the `ret =3D=3D 0` path (fresh insert, no overwrite), the function retur=
ns directly without going through `overwrite:`. So `old_data` is never set =
for fresh inserts via this path. But `rte_hash_replace_key_with_hash_data` =
initializes `*old_data =3D NULL` before the call, so this is safe =E2=80=94=
 the caller sees NULL for fresh inserts. This is correct.

#### **Warning =E2=80=94 New experimental APIs missing `__rte_experimental`=
 annotation validation**

The new functions `rte_hash_replace_key_data()` and `rte_hash_replace_key_w=
ith_hash_data()` are correctly marked `__rte_experimental` in the header an=
d use `RTE_EXPORT_EXPERIMENTAL_SYMBOL` in the `.c` file. This follows DPDK =
conventions.

#### **Info =E2=80=94 API design: `old_data` is required (non-NULL) for rep=
lace functions**

`rte_hash_replace_key_with_hash_data` validates `old_data !=3D NULL`:

```c
RETURN_IF_TRUE(((h =3D=3D NULL) || (key =3D=3D NULL) ||
        (old_data =3D=3D NULL)), -EINVAL);
```

This is a reasonable design choice =E2=80=94 if you don't want old_data, us=
e the existing `rte_hash_add_key_data()` instead. The semantics are clean: =
replace always tells you what was there before.

### Test Coverage

`test_hash_replace_key_data` covers:
- Overwrite path: verifies `old_data` returns the previous value
- Lookup after replace: verifies the new data is stored correctly
- Fresh insert via replace: verifies `old_data` is set to NULL

The test intentionally sets `old_data =3D (void *)0xdeadbeef` before the fr=
esh-insert replace to verify it gets zeroed. Good practice.

**Note**: The test doesn't cover the `rte_hash_replace_key_with_hash_data()=
` variant (with precomputed hash). Since it's a thin wrapper that delegates=
 to the same internal function, the coverage is adequate, but a dedicated t=
est for the hash variant would be thorough.

### Documentation

Release notes and API documentation are comprehensive and clear. The doxyge=
n comments properly document the ownership semantics (caller owns old point=
er, no auto-RCU-free).

---

## Cross-Patch Observations

### Overall Architecture Assessment

The design is clean and well-thought-out:

1. **Patch 1** adds automatic RCU deferred free as a "zero-effort" improvem=
ent for existing users who already have `free_key_data_func` configured.
2. **Patch 2** adds an explicit replace API for users who need precise cont=
rol over the old data's lifecycle.
3. The two features interact correctly: when `old_data` is provided (replac=
e API), automatic RCU free is suppressed; when `old_data` is NULL (existing=
 add API), automatic RCU free kicks in.

The priority of the `overwrite:` label logic in the final version is:

```c
overwrite:
    if (old_data !=3D NULL)       // caller wants ownership (replace API)
        *old_data =3D saved_old_data;
    else if (saved_old_data !=3D NULL)  // auto-free via RCU (add API)
        __hash_rcu_auto_free_old_data(h, saved_old_data);
    return ret;
```

This is the correct priority ordering.

### Key Finding Summary

| # | Severity | Patch | Finding |
|---|----------|-------|---------|
| 1 | Error | 1/2 | `old_data !=3D NULL` sentinel in `__hash_rcu_qsbr_free_=
resource` is fragile; use `key_idx =3D=3D 0` instead to discriminate overwr=
ite vs delete entries |
| 2 | Error | 1/2 | Failed `rte_rcu_qsbr_dq_enqueue` leaks old data (consis=
tent with existing code pattern but worth noting) |
| 3 | Info | 2/2 | No test for `rte_hash_replace_key_with_hash_data()` vari=
ant specifically |

