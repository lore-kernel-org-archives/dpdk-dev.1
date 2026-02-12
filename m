Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2DAEEA848
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 18:36:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A98D4025F;
	Thu, 12 Feb 2026 19:36:02 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id AD55840041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 19:36:00 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso1242115e9.1
 for <dev@dpdk.org>; Thu, 12 Feb 2026 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770921360;
 x=1771526160; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuI4u+Un8Ot7I6tME8rCaO28r0vwzd96lCgt2PtEdYs=;
 b=XZIqSrVp47UustsO3w9Epn18BCswnV2SkXx7uXreMGz1Ws/OEprBsF+Gxu2RHYX/Kd
 31iDK4za+1+2l30DwvucGbwOKPGFbLQC7T+jMxD6vqJwHoy8/PLQl5u0d4eQogtjHgsv
 ls7Jfti57XbIWcDKyxaevEObIWYsCNV8/OdmLUGl7XSRvLdaWsX8u1fGaXV9HeCUrCr/
 ihmI91OjTFY1v0owIIZVzh+Ef47zmI3Wcp+32XoGeP9U9joCTBaUlJ8p5d42OVIvKbc8
 fTP4d2tztS0UUYXyRJ8uZMsuqtipW6NOzmZou6xX5SoAsJiydranilRdSdhU5ta6SRAV
 Dy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770921360; x=1771526160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wuI4u+Un8Ot7I6tME8rCaO28r0vwzd96lCgt2PtEdYs=;
 b=hK2WxgS9aBcqwX0+8ig3YaJVHbX1W/tw+w/fViLkJSCJeJSM8ltBMkb0OGpX7xDYTF
 ZEAwLnEKpqZSgpID5fU/QUyMIbuv+pW4TJzYZ77BXeIJrruS2BFlxXmrwhdkrnHYBYfF
 d33iB4LXMz/W4muCaDjMN4vWY/c/Mok9v5Ljj8T8ovXgCKb9i8Nn7eY0qH3oEyopduso
 yaw5iI5CkTIrUdtkDDgODIe1QjCE12jDOrbf/ZfKYaiQbl4F55q+rz41MOpIJjSKrTdv
 ki+tTRRE2a8m24hEP5iPH7SheSsUvhMMQuBURmx43z2PlUhmfoRHfQvOAfj50o/bFvqM
 74PQ==
X-Gm-Message-State: AOJu0YwA9VA2LK4cfsRz7I4Jq9N/CLdXqGnzfm3QNCgBJHp8wA8Ijcvc
 hK/6nLBtiuKoz06I0XY1KuJh0/q5P24vsvc1cl073/BgwKFZsT5rVJH9zIonkzr2XsU=
X-Gm-Gg: AZuq6aJOwFxoelWPtxIjCktaa+lCGOgkJpVnj4tkWfj6bj8g2kT534+aOJK0doLQb1u
 oDLVSNJABILNJRtIX0iSc3w1obRGCkS+8M3eGBt4GrRTlW9PQLe4uWHsJ2LtOhAjC8O+ZiSgpLp
 cztlX3hfmfPpkrRLq2zVMuC3B+PaF5lN6xLwokHlgg6O7N/bf+lngw8wBX+1yztlVIxtLIDIebb
 SALP3/2odNUkjXktGM1vJzRy99/QEzMRQ1O6jYiK1yiR8P1UKmV509jUuIa7mw7hxD30ZmVctl2
 UAtZ9k2V4Ixjkdeo6lYs6TsniBX/Ku6nQQORaWXPd4uVIIRGNVjR6A6ducpgBtoVNyBnjpG1r7T
 KM8WTMndzmFG+JiB5ejTPiseB4WisOu2bqgAlZvbzPWwortdQHQHZi/UUU5x674zwUgC+wZAHPm
 DadFIBVeGNkFRCqc0SJ1HEcrIEWSF5Gj7HxVybkF9B0DdzU31ytCQPJgv5MGREl7yU
X-Received: by 2002:a05:600c:1f84:b0:483:3380:ca11 with SMTP id
 5b1f17b1804b1-48371045681mr1037375e9.33.1770921359943; 
 Thu, 12 Feb 2026 10:35:59 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e5c93asm12597076f8f.39.2026.02.12.10.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 10:35:59 -0800 (PST)
Date: Thu, 12 Feb 2026 10:35:54 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v7 0/8] net/nfb: rework to real multiport
Message-ID: <20260212103554.25cdeb4e@phoenix.local>
In-Reply-To: <20260204123137.123171-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260204123137.123171-1-spinler@cesnet.cz>
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

On Wed,  4 Feb 2026 13:31:29 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
>=20
> This series implements real multiport for better user experience.
>=20
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.
>=20
> ---
> Depends-on: patch-37245 ("doc/nfb: update release notes for nfb driver")
>=20
> v7:
> * Rebased to patch-37245
> * Removed timestamp update info from release notes
> * Added missing ctype include for isdigit()
> * Updated style: removed extra brackets
>=20
> Martin Spinler (8):
>   net/nfb: prepare for indirect queue mapping scheme
>   net/nfb: create one ethdev per ethernet port
>   net/nfb: add vdev as alternative device probe method
>   net/nfb: add device argument "port" to limit used ports
>   net/nfb: init only MACs associated with device
>   net/nfb: add compatible cards to driver PCI ID table
>   net/nfb: report firmware version
>   doc/nfb: cleanup and update guide
>=20
>  doc/guides/nics/features/nfb.ini       |   4 +
>  doc/guides/nics/nfb.rst                | 187 +++++------
>  doc/guides/rel_notes/release_26_03.rst |   6 +
>  drivers/net/nfb/meson.build            |   1 +
>  drivers/net/nfb/nfb.h                  |  56 +++-
>  drivers/net/nfb/nfb_ethdev.c           | 445 +++++++++++++++++++------
>  drivers/net/nfb/nfb_rx.c               |  30 +-
>  drivers/net/nfb/nfb_rx.h               |   9 +-
>  drivers/net/nfb/nfb_tx.c               |  27 +-
>  drivers/net/nfb/nfb_tx.h               |   7 +-
>  drivers/net/nfb/nfb_vdev.c             | 107 ++++++
>  11 files changed, 622 insertions(+), 257 deletions(-)
>  create mode 100644 drivers/net/nfb/nfb_vdev.c
>=20

Improved the AI review process and it saw this.
I think you should fix and retest before merge to next-net.

Here's the review. The most significant finding is in patch 2/8:
Double TAILQ_REMOVE =E2=80=94 nfb_eth_common_remove() explicitly removes the
entry from the list, then calls rte_eth_dev_destroy() which invokes
nfb_eth_dev_uninit(), which also does TAILQ_REMOVE on the same entry.
This will corrupt the linked list. The fix is to remove the
TAILQ_REMOVE from nfb_eth_common_remove() and let uninit handle it,
since uninit is also called from the dev_close path.=20

Other notable findings include unbounded loop counters when populating
queue maps and MAC arrays (patches 2 and 5 =E2=80=94 trusting firmware
consistency without defensive bounds checks), strtoul with base 0
allowing accidental octal parsing of port numbers (patch 4), and a
"DYNANIC" typo in the documentation (patch 8).

The overall architecture of the series is solid =E2=80=94 the indirect queue
mapping, per-interface ethdev creation, and TAILQ-based device tracking
are well-designed patterns for multi-port NICs.

Full report is:

# Deep Dive Review: NFB Multi-Port Patch Series (v7, 8 patches)

**Series**: `[PATCH v7 1/8]` through `[PATCH v7 8/8]`
**Author**: Martin Spinler `<spinler@cesnet.cz>`
**Delegate**: Stephen Hemminger

---

## Series Overview

This patch series transforms the NFB PMD from a "one ethdev per PCI device"=
 model to "one ethdev per physical Ethernet port." This is a significant ar=
chitectural change requiring:

1. An indirect queue mapping layer (DPDK queue index =E2=86=92 firmware que=
ue ID)
2. Multiple `rte_eth_dev_create()` calls per PCI probe instead of `rte_eth_=
dev_pci_generic_probe()`
3. A TAILQ-based device list to track all created ethdevs for proper removal
4. A vdev probe path for non-PCI (simulated/virtual) devices
5. Per-port MAC initialization instead of global
6. New PCI IDs and documentation updates

The design is generally sound =E2=80=94 the libnfb framework's `nc_ifc_map_=
info` provides the firmware-side port/queue topology, and this series maps =
it cleanly into DPDK's model.

---

## Patch-by-Patch Analysis

### Patch 1/8: `net/nfb: prepare for indirect queue mapping scheme`

**What it does**: Adds `queue_map_rx` / `queue_map_tx` arrays to `struct pm=
d_priv`, allocated as a single `rte_calloc` block. The RX/TX queue setup fu=
nctions now look up the firmware queue ID via these maps instead of using t=
he DPDK queue index directly.

**Correctness findings**:

**Error: Potential out-of-bounds access on `queue_map_rx` / `queue_map_tx`**

In `nfb_eth_rx_queue_setup()`:
```c
qid =3D priv->queue_map_rx[rx_queue_id];
```
There is no bounds check that `rx_queue_id < max_rx_queues` before indexing=
 into the map array. The same applies to `nfb_eth_tx_queue_setup()` with `q=
ueue_map_tx[tx_queue_id]`. While ethdev may enforce queue count limits conf=
igured via `dev_info`, a defensive check would prevent corruption if the up=
per layer has a bug.

**Confidence**: ~60%. Ethdev's `rte_eth_rx_queue_setup` does validate `rx_q=
ueue_id < dev->data->nb_rx_queues`, but `nb_rx_queues` is set by `rte_eth_d=
ev_configure()` which should match `max_rx_queues`. If a mismatch ever occu=
rs (e.g., bug in configure path), this would silently corrupt memory.

**Info: Clean refactoring of error paths**

The conversion from:
```c
if (ret =3D=3D 0)
    dev->data->rx_queues[rx_queue_id] =3D rxq;
else
    rte_free(rxq);
```
to the `goto err_queue_init` pattern is cleaner and more consistent with DP=
DK conventions.

---

### Patch 2/8: `net/nfb: create one ethdev per ethernet port`

This is the core architectural patch. Key changes:

- `nfb_eth_dev_init()` signature changes to accept `void *init_data` (for `=
rte_eth_dev_create()`)
- `nfb_eth_common_probe()` opens the NFB device, gets interface map, iterat=
es interfaces
- TAILQ list tracks all created ethdevs for removal
- `nfb_eth_common_remove()` iterates the TAILQ to destroy matching ethdevs

**Correctness findings**:

**Error: Double TAILQ_REMOVE in `nfb_eth_common_remove()`**

```c
RTE_TAILQ_FOREACH_SAFE(entry, &nfb_eth_dev_list, eth_dev_list, temp) {
    if (dev =3D=3D entry->eth_dev->device) {
        TAILQ_REMOVE(&nfb_eth_dev_list, entry, eth_dev_list);
        rte_eth_dev_destroy(entry->eth_dev, nfb_eth_dev_uninit);
    }
}
```

`rte_eth_dev_destroy()` calls `nfb_eth_dev_uninit()`, which also does:
```c
TAILQ_REMOVE(&nfb_eth_dev_list, internals, eth_dev_list);
```

This is a **double TAILQ_REMOVE** on the same entry. The first `TAILQ_REMOV=
E` in `nfb_eth_common_remove()` unlinks the entry, then `nfb_eth_dev_uninit=
()` attempts to remove the already-unlinked entry again. Depending on the T=
AILQ implementation, this could corrupt the list or cause undefined behavio=
r.

**Confidence**: ~85%. The `nfb_eth_dev_uninit()` always does the TAILQ_REMO=
VE (it was added in this same patch), and `nfb_eth_common_remove()` also do=
es it before calling destroy. One of these must be removed. The cleanest fi=
x is to remove the TAILQ_REMOVE from `nfb_eth_common_remove()` and let `nfb=
_eth_dev_uninit()` handle it exclusively =E2=80=94 that way `dev_close` =E2=
=86=92 `uninit` also works correctly.

**Error: `nfb_eth_common_probe()` opens NFB device twice**

`nfb_eth_common_probe()` opens the NFB device with `nfb_open()` to get the =
interface map, then closes it. But then `nfb_eth_dev_init()` (called via `r=
te_eth_dev_create()`) opens the **same device again** per-interface:
```c
internals->nfb =3D nfb_open(params->probe_params->path);
```
Each ethdev gets its own `nfb_open()` handle, which is probably intentional=
 (each port needs its own handle for independent NDP queue operations). But=
 the probe-level open is done solely to read the interface map and is then =
closed. This is not a bug per se, but worth confirming the design intent: *=
*N+1 opens** for N ports seems intentional.

**Confidence**: 50% =E2=80=94 this is likely intentional but should be conf=
irmed.

**Warning: `__rte_internal` in header file**

```c
__rte_internal
int nfb_eth_common_probe(struct nfb_probe_params *params);
__rte_internal
int nfb_eth_common_remove(struct rte_device *dev);
```

These are declared in `nfb.h` (a private driver header), which is fine for =
cross-file use within the driver. However, per AGENTS.md guidelines, `__rte=
_internal` should be alone on its own line before the function =E2=80=94 an=
d it is here, so this is correct. The `RTE_EXPORT_INTERNAL_SYMBOL` macros a=
re present in the .c file. No issue.

**Warning: `nfb_eth_dev_create_for_ifc()` queue map population may write be=
yond allocated bounds**

In patch 2, the queue map population loop:
```c
cnt =3D 0;
for (i =3D 0; i < mi->rxq_cnt; i++) {
    if (mi->rxq[i].ifc =3D=3D ifc->id)
        priv->queue_map_rx[cnt++] =3D mi->rxq[i].id;
}
```
The array `queue_map_rx` was allocated with size `max_rx_queues` (which is =
`ifc->rxq_cnt`). If the firmware map reports more RX queues for this interf=
ace than `ifc->rxq_cnt`, `cnt` could exceed the allocation. This depends on=
 the libnfb library's consistency guarantees between `ifc->rxq_cnt` and the=
 actual count of `mi->rxq[i].ifc =3D=3D ifc->id` matches.

**Confidence**: ~55%. If `nc_ifc_map_info_create_ordinary()` guarantees con=
sistency, this is safe. If not, a bounds check on `cnt < max_rx_queues` wou=
ld be prudent.

**Info: Static TAILQ without synchronization**

The `nfb_eth_dev_list` TAILQ is a static global with no locking. This is sa=
fe as long as probe/remove are only called from the EAL main thread (which =
is the normal DPDK model), but worth noting.

---

### Patch 3/8: `net/nfb: add vdev as alternative device probe method`

Adds a vdev driver (`net_vdev_nfb`) for non-PCI devices (simulated/virtual).

**Correctness findings**:

**Warning: `nfb_default_dev_path()` used without NULL check**

```c
params.path =3D nfb_default_dev_path();
```

If `nfb_default_dev_path()` returns NULL (e.g., no NFB device present), thi=
s will be passed to `nfb_open()` which will likely segfault. The "dev" argu=
ment parsing later may override it, but if no `dev=3D` argument is given, t=
he default path is used.

**Confidence**: ~65%. Depends on `nfb_default_dev_path()` semantics. If it =
always returns a valid string (even for non-existent devices), this is fine=
. If it can return NULL, a check is needed.

**Info: Mixed `free()` and `rte_kvargs_free()` cleanup**

The error paths correctly use `free()` for `strdup()`'d memory and `rte_kva=
rgs_free()` for kvargs. This is correct.

---

### Patch 4/8: `net/nfb: add device argument "port" to limit used ports`

Adds ability to select specific ports via `port=3DN` arguments.

**Correctness findings**:

**Error: `strtoul` with base 0 allows octal/hex input =E2=80=94 potential u=
ser confusion**

```c
port =3D strtoul(value, &end, 0);
```

Base 0 means `port=3D010` is parsed as octal (8), not decimal 10. For a por=
t number argument, base 10 would be more predictable:
```c
port =3D strtoul(value, &end, 10);
```

**Confidence**: 70%. Not a crash bug, but a usability issue that could caus=
e silent misconfiguration.

**Info: The `nfb_eth_dev_create_for_ifc_by_port()` validation is good** =E2=
=80=94 it checks for empty string, non-digit start, and out-of-range values.

---

### Patch 5/8: `net/nfb: init only MACs associated with device`

Replaces the global "open all MACs" approach with per-interface MAC initial=
ization.

**Correctness findings**:

**Warning: Uses `calloc()` instead of `rte_calloc()` for rxmac/txmac arrays=
**

```c
intl->rxmac =3D calloc(ifc->eth_cnt, sizeof(*intl->rxmac));
```

These are pointer arrays (not DMA-accessible), so `calloc()` is actually ap=
propriate per DPDK guidelines (don't use `rte_malloc` for non-DMA control s=
tructures). However, `nfb_eth_dev_uninit()` is freeing the `internals` stru=
ct with `rte_free()` while these sub-allocations use plain `free()`. This m=
ixing is fine =E2=80=94 they're separate allocations =E2=80=94 but worth no=
ting for consistency.

**Error: `nfb_nc_eth_init()` doesn't validate `cnt` against allocated array=
 size**

```c
intl->rxmac =3D calloc(ifc->eth_cnt, sizeof(*intl->rxmac));
// ...
rxm =3D 0;
for (i =3D 0; i < mi->eth_cnt; i++) {
    if (mi->eth[i].ifc !=3D ifc->id)
        continue;
    intl->rxmac[rxm] =3D nc_rxmac_open(intl->nfb, mi->eth[i].node_rxmac);
    if (intl->rxmac[rxm])
        rxm++;
    // ...
}
```

The array is allocated with size `ifc->eth_cnt`, but the loop counts matche=
s of `mi->eth[i].ifc =3D=3D ifc->id` without bounding `rxm` against `ifc->e=
th_cnt`. If the firmware map has more eth entries for this interface than `=
ifc->eth_cnt` indicates, this overflows the allocation.

**Confidence**: ~55%. Same trust-the-firmware question as in patch 2's queu=
e map population.

**Info: Early return for `ifc->eth_cnt =3D=3D 0` is good defensive coding.**

---

### Patch 6/8: `net/nfb: add compatible cards to driver PCI ID table`

Adds PCI IDs for NFB-200G2QL secondary endpoint, FB2CGHH, COMBO-400G1, and =
generic CESNET-NDK.

No correctness issues. Straightforward PCI ID table additions.

---

### Patch 7/8: `net/nfb: report firmware version`

Implements `fw_version_get` ethdev op.

**Correctness findings**:

**Info: Good NULL handling for `proj_name` / `proj_vers`** =E2=80=94 both a=
re defaulted to empty string if NULL.

**Info: The return value semantics are correct** =E2=80=94 returns 0 on suc=
cess, the required buffer size on truncation, and negative on error, matchi=
ng the `fw_version_get` API contract.

---

### Patch 8/8: `doc/nfb: cleanup and update guide`

Documentation rewrite and release notes update.

**Warning: Typo in documentation**

```rst
Ready-to-use demo firmwares can be found on the `DYNANIC page <https://dyna=
-nic.com/try-now/>`_.
```

"DYNANIC" should be "DYNANIC" or more likely "DyNANIC" or whatever the corr=
ect product name is =E2=80=94 but the URL suggests it might be "dyna-nic", =
so the display text appears misspelled. Worth verifying the correct brandin=
g.

**Warning: Feature matrix additions should match implemented features**

The patch adds to `features/nfb.ini`:
```ini
Unicast MAC filter   =3D Y
Timestamp offload    =3D P
FW version           =3D Y
Multiprocess aware   =3D Y
```

"Unicast MAC filter" and "Timestamp offload" were presumably already suppor=
ted but undocumented. "FW version" is added in patch 7. "Multiprocess aware=
" =E2=80=94 the series adds `rte_eal_process_type()` checks in some places =
but the full multiprocess story should be verified.

---

## Cross-Cutting Concerns

### Thread Safety of Static TAILQ

The `nfb_eth_dev_list` TAILQ has no locking. DPDK's device management is ty=
pically single-threaded (EAL main thread), but if hotplug events could race=
 with probe/remove, this could be problematic. This is consistent with how =
other DPDK drivers handle similar lists, so it's acceptable.

### Memory Allocation Strategy

The series uses an appropriate mix of `rte_calloc`/`rte_zmalloc` for data i=
n the DPDK-managed dev_private area and plain `calloc`/`malloc` for driver-=
internal control structures (MAC handle arrays). This follows DPDK best pra=
ctices.

### Error Path Completeness

Error paths are generally well-handled across the series. The `goto` cleanu=
p chains in `nfb_eth_dev_init()` are consistent and cover the allocation se=
quence.

---

## Summary of Findings

| Severity | Patch | Finding |
|----------|-------|---------|
| **Error** | 2/8 | Double `TAILQ_REMOVE` =E2=80=94 `nfb_eth_common_remove(=
)` removes from list, then `nfb_eth_dev_uninit()` (called via `rte_eth_dev_=
destroy()`) removes again |
| **Warning** | 2/8 | Queue map population loop lacks bounds check against =
allocated size |
| **Warning** | 5/8 | `nfb_nc_eth_init()` rxmac/txmac population loop lacks=
 bounds check against `ifc->eth_cnt` |
| **Warning** | 4/8 | `strtoul` with base 0 allows unintended octal/hex par=
sing of port numbers |
| **Warning** | 3/8 | `nfb_default_dev_path()` return value not checked for=
 NULL before use |
| **Warning** | 8/8 | "DYNANIC" appears to be a typo in documentation |
| **Info** | 1/8 | No bounds check on `rx_queue_id` / `tx_queue_id` before =
indexing queue maps |

The **double TAILQ_REMOVE** in patch 2 is the most significant finding and =
will cause list corruption when removing devices. The fix is straightforwar=
d: remove the `TAILQ_REMOVE` call from `nfb_eth_common_remove()` and let `n=
fb_eth_dev_uninit()` handle list removal exclusively.
