Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C623CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 23:56:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E509B40264;
	Mon, 18 May 2026 01:56:17 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 159B140261
 for <dev@dpdk.org>; Mon, 18 May 2026 01:56:17 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-134fe980658so1963743c88.1
 for <dev@dpdk.org>; Sun, 17 May 2026 16:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779062176;
 x=1779666976; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lneKP1p9vWjhL+oNKcb1FTGkXCDx0JVWqlFCAyCczik=;
 b=yFI93YJnMEHs+vL2vrVYSrHkZnxJVzj77A3laxPEQ62GbSoICTDxRIKXN+hCRlaUx0
 9R83fcTpkBq4mmn2Kq0Y171psoH+zJkEcuCUtZLEh+pz4xGkEX4t5nkGE8ROLF8gPPTr
 38j3tZX7VZ6/3OPs8GKkMbvADJwMhks+xq3zeGxzXS8TdIV+0IHlX8ra1mZVxxSVAm8y
 q5c18m4vGgId5LKv1TkTugfA5CsC9dtvS/jEij3fxBAXW9JHUu+wB7b1sGjbfWn8W7Sv
 1TOHUYcHOS+eFO2Fh7UmGbXE2LoV+aJI9NZgmmMARUP5v/Q+CPnq2p8rCICpNCoZt4LK
 hG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062176; x=1779666976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lneKP1p9vWjhL+oNKcb1FTGkXCDx0JVWqlFCAyCczik=;
 b=dV+NH8vAKrR8LtGquhQPxQfPQn8EB22PGilHnKLjRMzirqW+jdF54kn/ZMkQ6QUoyf
 QjFthqQAGankKxJ5lKSjrvu73bMYksgS3vjqP70AEz7Qyyll1bj+ovLW9Tln0FJMtYW1
 OchXBb9G0s0U6bwVRCueGpifscRtN31S9yALw/x7dU0/GCW5A/wXQf/mkKAyzXd4Pq+N
 oaD0q/kfhGQZxofVKkUHI/j+6WPETOIlLQhJz3oooz4LRLJ6Mks3Dl2tw+RWDsH2oxbp
 7BgngYRMs34vsiT5C3KQHbHIxIIfGXzJw9tRhyQJHpLP0ktrDWsAmavwGbSFy281248S
 rt4g==
X-Gm-Message-State: AOJu0YwjRJ0ULZ9b+OFYRTBe7ND44vfB0fDCbjjM0Pwtx2bNj95xZng4
 DqfAqPFh17Vfd1fmuPVwBB7B2nPy7s+G7uMm6ait5N51VRybiYCvbZojVfOFpI1KiU/OKToKvCh
 Sclxi9Xo=
X-Gm-Gg: Acq92OEE2xh3cuFif711Iy5oLPDKaZdaazzc2jZwqEICLR8xH72o77UWDJbon0OwFa6
 mQ8cObq7N9DMJDdWpLJyrIO+ctGLBJa/tK0N3V+SdKX2rYUE1bstE6PKwSt1FW4Qi8vcPjxxlNE
 FqN2sN6iTXRv32Ep/rJYv1Zh4/rdxetUiiyZoah2rX/zF3jI1aLNTmC9jPYXjodNO476ykZWkDs
 FpPb3PHE5oWML2fPEEWPd0Qh58EAFn9C7p3GXc8t5he8J7Tl/wsxtCxP1IRvGSjuipAo9PLdqCk
 r/BmIjTivWxKX6bNrFqdAxZQzdavCoIWCGifh+6QQQpxmkM7nKeGO8yCU8l85v3lCSr6GVJPXOn
 4CaiWrzyxAoACAj/zPmkibOm7aMhmHNQi4LrDKeQP6T7QH+2Ap0dTrRgmEgehzAaxRczN8vq8BD
 5RXIrqBFMTI0SYJ1nOR9MxGmtuSmQj9e21gyY=
X-Received: by 2002:a05:7300:6c12:b0:2ef:8b72:1b9 with SMTP id
 5a478bee46e88-30397bc0584mr6012540eec.0.1779062176013; 
 Sun, 17 May 2026 16:56:16 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc8ddsm12189379eec.21.2026.05.17.16.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 16:56:15 -0700 (PDT)
Date: Sun, 17 May 2026 16:52:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v4 16/20] net/txgbe: fix SFP module identification
Message-ID: <20260517165225.6ba8b774@phoenix.local>
In-Reply-To: <20260511103604.19724-17-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-17-zaiyuwang@trustnetic.com>
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

On Mon, 11 May 2026 18:35:58 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> Some optical modules were not correctly recognized due to ambiguous
> classification in the original detection flow. Rework the module
> identification logic to cover all module types. Also narrow the
> I2C lock scope to avoid potential race conditions during module
> access.
>=20
> Fixes: ab191e6d9189 ("net/txgbe: support new SFP/QSFP modules")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

Lots of AI feedback here.
Note: not all this is required; like the request for extra release notes is=
 AI being picky.

# Review of Patch 16/20: net/txgbe: fix SFP module identification

## Summary
This patch refactors SFP/QSFP module identification logic and adjusts I2C l=
ocking scope. The changes address module type detection and claim to fix ra=
ce conditions.

---

## Errors

### 1. Resource leak in `txgbe_identify_sfp_module()` - multiple error path=
s missing unlock

**Error paths that acquire lock but fail to release on error:**

At line 836, `hw->mac.acquire_swfw_sync()` acquires `TXGBE_MNGSEM_SWPHY`. S=
everal error paths after this point fail to release the lock:

```c
err =3D hw->phy.read_i2c_eeprom(hw, TXGBE_SFF_IDENTIFIER, &identifier);
if (err !=3D 0) {
    /* ... */
    hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);  // OK - releases
    return TXGBE_ERR_SFP_NOT_PRESENT;
}

if (identifier !=3D TXGBE_SFF_IDENTIFIER_SFP) {
    hw->phy.type =3D txgbe_phy_sfp_unsupported;
    hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);  // OK - releases
    return TXGBE_ERR_SFP_NOT_SUPPORTED;
}

err =3D hw->phy.read_i2c_eeprom(hw, ...);
/* Multiple read_i2c_eeprom calls follow */
```

**After line 894**, there are at least **4 read_i2c_eeprom() calls** (lines=
 ~895-930 in the context) that can fail with `goto out;` - but `goto out;` =
is removed in this patch. If any of these reads fail now, the function retu=
rns immediately **without releasing the lock acquired at line 836**.

Example at line 1000:
```c
err =3D hw->phy.read_i2c_eeprom(hw, TXGBE_SFF_CABLE_SPEC_COMP, &cable_spec);
if (err !=3D 0)
    goto out;  /* This label is REMOVED - now falls through or returns */
```

The old code had `out:` label that might have handled cleanup. The new code=
 removes this pattern but doesn't add `hw->mac.release_swfw_sync()` calls b=
efore each early return.

**Impact:** Lock held indefinitely on I2C read failure, blocking other thre=
ads.

**Fix:** Add lock release before every early return after line 836:
```c
err =3D hw->phy.read_i2c_eeprom(hw, TXGBE_SFF_CABLE_SPEC_COMP, &cable_spec);
if (err !=3D 0) {
    hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
    goto out;
}
```

---

### 2. `txgbe_write_i2c_byte()` removes STOP condition - probable hardware =
protocol violation

**Line 1299 (old) vs 1299 (new):**

Old code:
```c
wr32(hw, TXGBE_I2CDATA, byte_offset | TXGBE_I2CDATA_STOP);
```

New code:
```c
wr32(hw, TXGBE_I2CDATA, byte_offset);
```

The `TXGBE_I2CDATA_STOP` flag is removed from the byte_offset write but rem=
ains only on the data write. This changes the I2C transaction sequence:

- Old: Write byte_offset with STOP, write data with STOP
- New: Write byte_offset (no STOP), write data with WRITE+STOP (via `txgbe_=
i2c_stop()`)

**Analysis:** I2C writes to EEPROMs typically follow: START =E2=86=92 devic=
e_addr+W =E2=86=92 ACK =E2=86=92 byte_offset =E2=86=92 ACK =E2=86=92 data =
=E2=86=92 ACK =E2=86=92 STOP. Removing STOP from the byte_offset phase may =
be correct if the hardware requires a combined write transaction, **but thi=
s is a functional change to I2C timing that is not explained in the commit =
message** and could break module writes.

**Impact:** Could cause I2C write failures or data corruption on SFP/QSFP E=
EPROMs.

**Fix:** Either:
1. Verify via hardware datasheet that single STOP at end is correct, docume=
nt in commit message
2. Restore `TXGBE_I2CDATA_STOP` on byte_offset write

---

### 3. Removed validation logic without replacement - SFP vendor checking d=
eleted

**Lines 1025-1070 (old code, removed):** The old `txgbe_identify_qsfp_modul=
e()` read vendor OUI bytes, checked for Intel vendor, and enforced "allow_a=
ny_sfp" policy. This entire block is deleted with no equivalent in the new =
code.

**Impact:**
- Unsupported vendor modules are now silently accepted (security/quality ri=
sk)
- `hw->allow_unsupported_sfp` flag is no longer checked (user configuration=
 ignored)
- Warning messages for untested modules removed (users not informed of risk=
s)

**This is a functional regression unless the validation moved elsewhere** (=
not evident in this patch).

**Fix:** Restore vendor OUI check or document why it's safe to remove.

---

## Warnings

### 1. `txgbe_identify_qsfp_module()` GPIO config runs unconditionally

**Lines 1098-1099:**
```c
/* config GPIO before read i2c */
wr32(hw, TXGBE_GPIODATA, TXGBE_GPIOBIT_1);
```

This GPIO write now runs **even when media_type is not fiber_qsfp** (the me=
dia check is after the GPIO write at lines 1108-1111). The old code had thi=
s GPIO write inside the `if (hw->mac.type =3D=3D txgbe_mac_aml40)` block, a=
fter the media check.

**Impact:** Unnecessary hardware access, potential side effects on non-QSFP=
 ports.

**Fix:** Move GPIO config inside the `if (hw->mac.type =3D=3D txgbe_mac_aml=
40)` block or add media_type check first.

---

### 2. Missing error propagation - `txgbe_read_i2c_sff8636()` page select f=
ailure ignored

**Line 1215:**
```c
hw->phy.write_i2c_byte(hw, TXGBE_SFF_QSFP_PAGE_SELECT,
                TXGBE_I2C_EEPROM_DEV_ADDR,
                page);
```

The return value from `write_i2c_byte()` is discarded. If page select fails=
, the subsequent read at line 1218 will read from the **wrong page**, produ=
cing incorrect module data.

**Fix:**
```c
s32 err =3D hw->phy.write_i2c_byte(hw, TXGBE_SFF_QSFP_PAGE_SELECT,
                                 TXGBE_I2C_EEPROM_DEV_ADDR, page);
if (err !=3D 0)
    return err;
```

---

### 3. Implicit comparison on pointer

**Line 1123 (in `txgbe_identify_qsfp_module`):**
```c
if (err)
    return -EBUSY;
```

Should be explicit:
```c
if (err !=3D 0)
    return -EBUSY;
```

---

### 4. Release notes likely required

This patch changes module detection logic and affects supported module type=
s. API behavior changes (vendor validation removed, new module type support=
) typically require release notes under "Fixed Issues" or "Known Issues" if=
 compatibility changes exist.

---

### 5. Function pointer assignments removed but functions still defined

**Lines 2912-2913 (txgbe_hw.c):**
```c
phy->read_i2c_byte_unlocked =3D txgbe_read_i2c_byte_unlocked;
phy->write_i2c_byte_unlocked =3D txgbe_write_i2c_byte_unlocked;
```

These assignments are removed, but the commit message doesn't indicate whet=
her the `*_unlocked` functions are deleted or just unused. If the functions=
 remain defined but unreferenced, they are dead code. If other drivers refe=
rence `phy->read_i2c_byte_unlocked` as a function pointer, this breaks them.

---

## Info

### 1. Simplified I2C locking approach is clearer

The removal of separate `*_unlocked` variants and the move to caller-manage=
d locking (acquire once, multiple reads, release) is a good pattern that re=
duces lock churn.

---

### 2. New SFP type handling for 25G/40G modules

The patch adds proper detection for:
- 25G AOC modules (`txgbe_sfp_type_25g_aoc_core0/1`)
- 40G QSFP types with Ethernet compliance byte checks

This appears to address the "ambiguous classification" mentioned in the com=
mit message.

---

### 3. Consistent use of `read_i2c_sff8636()` helper

The new `txgbe_read_i2c_sff8636()` helper centralizes page-select logic for=
 QSFP modules, which is good for maintainability (despite the error handlin=
g issue noted above).

---

## Final Check Summary

**Errors (must fix):**
1. Lock leaks in `txgbe_identify_sfp_module()` on I2C read errors after lin=
e 836
2. `TXGBE_I2CDATA_STOP` removal in `txgbe_write_i2c_byte()` changes I2C pro=
tocol, not explained/verified
3. Vendor OUI validation removed without replacement - security/quality reg=
ression

**Warnings (should fix):**
1. GPIO config runs before media_type check
2. Page select error ignored in `txgbe_read_i2c_sff8636()`
3. Implicit comparison `if (err)`
4. Release notes likely needed for behavior changes
5. Unused function pointer assignments removed - check for dead code

