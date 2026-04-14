Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3F4F9D0F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 20:22:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D78C34028F;
	Tue, 14 Apr 2026 22:22:17 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 812F94028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 22:22:16 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso8293045eec.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776198135;
 x=1776802935; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsR6WUZ7FuCvnV1HXpB0rBJu8uPNpXf5pcmRL0L0w2A=;
 b=OLkN5QGbNG7LnNKWJMjrEH0mjQXjoZFhmktvyK4Z48PImQyj2Kmw1W789Uim6k7XtR
 MRp0QuumVN1SWcBPCjfcchawao05A49Xv0QWZyyKBr2BE7+zs140LAPt7NfFD6HVEPmf
 QGiwLSSMefzQigzftC7s7tE3Fmy+JokmzpXQHG1OK9iapawt8DgOq8w3XGC7YAr44/F6
 A6u65v/VZVeRI9mICbHi9YL6eHHaSKlVoxbNISc7FFQ6Lvg1LzdcCNhlPhLKqAimzQQJ
 bskbazyEjRoeHQELyf9HEbQd3NjS+TicDCiYzTT2F6aCL+lvYSL3so+h2DwLYUTk+FOl
 0Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776198135; x=1776802935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZsR6WUZ7FuCvnV1HXpB0rBJu8uPNpXf5pcmRL0L0w2A=;
 b=rganS06HbNvBPf2YuSdxvxu/tmO1nXxKDKQJvVtazf4qDsKM/XaltjNy/oG6nt6qt7
 RZZDg9L/TgQXzXO2B2ZkIpZpdiQxoC/XZAtzBKU+Cx1/AZIns7GzyjviA65MePhRtC0S
 /i8v53vlHAH5NVmYdJXNa4tVT3DRAvarTp6BMViLwAHKZ0UzLApdMEKRvKc8F8leWiIU
 IawUy3bfQKRyL+YRv6uek+u97BOpB8ptMlLAkuB1W/jUJXVTvUp6QJT1QnGNcmytvc4q
 OxaiEqE2IjXP52dXvZmQNwvm5+1lglJw3mJTzjqdA388Kbei4U4V+5V4HvVPhUS7A0ZX
 EL3w==
X-Gm-Message-State: AOJu0Yx7xalYXZf9EYaiXhexjqfiDGsHFwzfJTAYcxnNSpR3/zzDq98M
 hH6FcE51cFceQ1Fm61lIram0rdyq7KE+8h+RKtx07RVgvkRTMf3MKta28M9szzinDqo=
X-Gm-Gg: AeBDietx+EFF9Hgx6CjCxHji/j1lpDcQiqgLN5IXT2YESUhLIpSp/8AbzmitQd+ngAz
 QEw8GaRaRySpGuFKStTi62oJdR9XlwImRvvSoaL1zRztbXc1s1gdqUTyMhJ04x00JX2sAbICZqb
 PSRAfy+rnoJx/H32Z78SBu7kvlRQxiUTWZ3+ca2+flkCSEyPFPRjfqXNEAz92pMq0xGMDGagrqJ
 wytYLgZPUwzzoIN/liywrE8KU7sUCM/aiheN6j7dMzD++4SUmwAGREelXVfrW/B4nszCaEuLxem
 RCG/Y3eUUp8iNDBUSAwUPXqcCgG+dL/Q4ZzQ+U1qpGaE3Q7bRLJiHwa18KwlF2+JYRjrTckL/89
 ZiteYP6a6OH05vaCiCddOGqSNt/hZUKzu8A5gLTZeTNpTiznaYFaKhYbNNMp5bQaoxcAc4Yt/Od
 mBr34Unxz7lgmiAnYpI6of2ukiIF3vIWutur+A+FvZYcCkRBaT8Hwsx6qT
X-Received: by 2002:a05:7300:1489:b0:2d9:9f55:25c8 with SMTP id
 5a478bee46e88-2d99f5527d7mr5233006eec.0.1776198135179; 
 Tue, 14 Apr 2026 13:22:15 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d5629b31f5sm22153169eec.24.2026.04.14.13.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 13:22:14 -0700 (PDT)
Date: Tue, 14 Apr 2026 13:22:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vipin Varghese <vipin.varghese@amd.com>
Cc: <dev@dpdk.org>, <sivaprasad.tummala@amd.com>,
 <konstantin.ananyev@huawei.com>, <wathsala.vithanage@arm.com>,
 <bruce.richardson@intel.com>, <viktorin@cesnet.cz>,
 <mb@smartsharesystems.com>
Subject: Re: [PATCH v5 0/3] eal/topology: introduce topology-aware lcore
 grouping
Message-ID: <20260414132212.1726f08d@phoenix.local>
In-Reply-To: <20260414193850.1696-1-vipin.varghese@amd.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20260414193850.1696-1-vipin.varghese@amd.com>
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

On Wed, 15 Apr 2026 01:08:18 +0530
Vipin Varghese <vipin.varghese@amd.com> wrote:

> This series introduces a topology library that groups DPDK lcores based on
> CPU cache hierarchy and NUMA topology. The goal is to provide a stable and
> explicit API that allows applications to select lcores with better locali=
ty
> and cache sharing characteristics.
>=20
> The series includes:
>   - EAL support for topology discovery using hwloc and domain-based lcore
>     grouping (L1/L2/L3/L4/NUMA)
>   - Topology-aware test cases validating API behavior and edge conditions
>   - Programmer=E2=80=99s guide describing the topology library and APIs
>=20
> The API is marked experimental and does not change existing lcore behavior
> unless explicitly used by the application.
>=20
> Changes in v5:
>   - Addressed review comments from v4
>   - Fixed ARM cross-compilation issues
>   - Cleaned up domain iteration and error handling
>   - Updated tests to cover domain edge cases
>   - Documentation refinements and API usage clarification
>=20
> Changes in v4:
>   - Corrected domain selection semantics
>   - Updated example usage
>   - Fixed naming and typo issues
>=20
> Changes in v3:
>   - Fixed macro naming (USE_NO_TOPOLOGY)
>   - Minor cleanups based on early feedback
>=20
> Tested on:
>   - AMD EPYC (Milan, Genoa, Siena, Turin, Turin-Dense, Sorano)
>   - Intel Xeon (SPR-SP, GNR-SP)
>   - ARM Ampere
>   - NVIDIA Grace Superchip
>=20
> Dependencies:
>   - hwloc-dev (tested with 2.10.0)
>=20
> Patch breakdown:
>   1/3 eal/topology: add topology grouping for lcores
>   2/3 app: add topology-aware test cases
>   3/3 doc: add topology library documentation
>=20
> Future Work:
>  - integrate into examples
>   -- hellowrld: ready
>   -- pkt-distributor: in-progress
>   -- l2fwd: ready
>   -- l3fwd: to start
>   -- eventdevpipeline: PoC ready
>  - integrate topology test
>   -- crypto: yet to start
>   -- compression: yet to start
>   -- dma: PoC ready
>  - add new features for
>   -- PQoS: yet to start
>   -- Data Injection: PoC with BRDCM Thor-2 ready
>=20
> Tested OS: Linux only, need help with BSD and Windows
>=20
> Tested with and without hwloc-dev library for
>  - Ampere, aarch64, Neoverse-N1, NUMA-2, 256 CPU threads
>  - Grace superchip, aarch64, Neoverse-V2, NUMA-2, 144 CPU threads
>  - Intel GNR-SP, 6767P, NUMA-2, 256 Threads
>  - AMD EPYC Siena, 8534P, NUMA-1, 128 Threads
>  - AMD EPYC Sorano, 8635P, NUMA-1, 168 Threads
>=20
> Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
> ``
>=20
> Vipin Varghese (3):
>   eal/topology: add Topology grouping for lcores
>   app: add topology aware test case
>   doc: add new section topology
>=20
>  app/test/meson.build                   |   1 +
>  app/test/test_ring_perf.c              | 416 +++++++++++++-
>  app/test/test_stack_perf.c             | 409 ++++++++++++++
>  app/test/test_topology.c               | 676 ++++++++++++++++++++++
>  config/meson.build                     |  18 +
>  doc/api/doxy-api-index.md              |   1 +
>  doc/guides/prog_guide/index.rst        |   3 +-
>  doc/guides/prog_guide/topology_lib.rst | 155 +++++
>  lib/eal/common/eal_private.h           |  74 +++
>  lib/eal/common/eal_topology.c          | 747 +++++++++++++++++++++++++
>  lib/eal/common/meson.build             |   1 +
>  lib/eal/freebsd/eal.c                  |  10 +-
>  lib/eal/include/meson.build            |   1 +
>  lib/eal/include/rte_topology.h         | 255 +++++++++
>  lib/eal/linux/eal.c                    |   7 +
>  lib/eal/meson.build                    |   4 +
>  16 files changed, 2773 insertions(+), 5 deletions(-)
>  create mode 100644 app/test/test_topology.c
>  create mode 100644 doc/guides/prog_guide/topology_lib.rst
>  create mode 100644 lib/eal/common/eal_topology.c
>  create mode 100644 lib/eal/include/rte_topology.h
>=20

AI review reported lots of possible correctness problems:


# DPDK Patch Review - bundle-1843-topology-v5.mbox

## Overview

This patch series introduces topology awareness to DPDK, allowing applicati=
ons to select logical cores based on CPU cache and I/O topology. The series=
 adds a new `rte_topology` library with APIs to query and enumerate logical=
 cores within topology domains (L1/L2/L3/L4/NUMA).

---

## Correctness Bugs (HIGHEST PRIORITY - report at >=3D50% confidence)

### Patch 1/3: lib/eal/common/eal_topology.c

#### **Error: Resource leak on `eal_topology_map_layer()` failure**

In `rte_eal_topology_init()`, if any call to `eal_topology_map_layer()` fai=
ls (returns < 0), the code calls `rte_eal_topology_release()` which frees p=
reviously allocated layers. However, the `hwloc_topology_t` handle `topo_cn=
fg.topology` is **NOT** destroyed before returning. This leaks the hwloc to=
pology handle.

**Location:** `lib/eal/common/eal_topology.c:685-712`

```c
for (int i =3D 0; i < 5; i++) {
    *layers[i].count =3D hwloc_get_nbobjs_by_depth(topo_cnfg.topology, laye=
rs[i].depth);
    if (eal_topology_map_layer(topo_cnfg.topology, layers[i].depth, layers[=
i].count,
        layers[i].ptr, layers[i].total_cores, layers[i].name) < 0) {
        rte_eal_topology_release();  /* frees layer memory */
        return -1;  /* BUG: topo_cnfg.topology NOT destroyed here */
    }
}

hwloc_topology_destroy(topo_cnfg.topology);  /* only reached on success */
topo_cnfg.topology =3D NULL;
```

**Fix:** Destroy the topology before returning on error:

```c
if (eal_topology_map_layer(...) < 0) {
    hwloc_topology_destroy(topo_cnfg.topology);
    topo_cnfg.topology =3D NULL;
    rte_eal_topology_release();
    return -1;
}
```

---

#### **Error: Potential use-after-free in `eal_topology_map_layer()` on par=
tial allocation failure**

In `eal_topology_map_layer()`, the code allocates `dm->cores` for each doma=
in. If a later allocation in the same loop iteration fails (e.g., for domai=
n `j+1`), the function returns -1 immediately **without freeing `dm->cores`=
 already allocated for earlier domains**. The caller (`rte_eal_topology_ini=
t()`) then calls `rte_eal_topology_release()`, which expects `layer_ptr[j]`=
 to be non-NULL but `layer_ptr[j]->cores` may be uninitialized or garbage i=
f the allocation failed before that point. This can cause a use-after-free =
or double-free when `rte_eal_topology_release()` calls `rte_free(d->map[i]-=
>cores)`.

**Location:** `lib/eal/common/eal_topology.c:537-557`

```c
for (uint16_t j =3D 0; j < *layer_cnt; j++) {
    hwloc_obj_t obj =3D hwloc_get_obj_by_depth(topology, depth, j);
    int cpu_count =3D hwloc_bitmap_weight(obj->cpuset);
    if (cpu_count =3D=3D -1)
        continue;

    struct core_domain_mapping *dm =3D
        rte_zmalloc(NULL, sizeof(struct core_domain_mapping), 0);
    if (!dm)
        return -1;  /* BUG: leaks layer_ptr array allocated by caller */

    (*layer_ptr)[j] =3D dm;
    CPU_ZERO(&dm->core_set);
    dm->core_count =3D 0;

    dm->cores =3D rte_malloc(NULL, sizeof(uint16_t) * cpu_count, 0);
    if (!dm->cores)
        return -1;  /* BUG: leaks dm (just allocated) and previous entries =
*/
}
```

**Fix:** On allocation failure, free all previously allocated entries befor=
e returning:

```c
if (!dm) {
    /* Free all previously allocated entries */
    for (uint16_t k =3D 0; k < j; k++) {
        if ((*layer_ptr)[k]) {
            rte_free((*layer_ptr)[k]->cores);
            rte_free((*layer_ptr)[k]);
        }
    }
    rte_free(*layer_ptr);
    return -1;
}

/* Same cleanup for dm->cores allocation failure */
if (!dm->cores) {
    rte_free(dm);
    for (uint16_t k =3D 0; k < j; k++) {
        if ((*layer_ptr)[k]) {
            rte_free((*layer_ptr)[k]->cores);
            rte_free((*layer_ptr)[k]);
        }
    }
    rte_free(*layer_ptr);
    return -1;
}
```

---

#### **Error: NULL pointer dereference in `eal_topology_map_layer()` when `=
hwloc_get_obj_by_depth()` returns NULL**

In the second loop of `eal_topology_map_layer()` (lines 560-620), the code =
calls `hwloc_get_obj_by_depth(topology, depth, j)` and checks `if (!obj || =
hwloc_bitmap_iszero(obj->cpuset))` to skip NULL objects. However, in the **=
inner loop** (lines 579-618), the code calls `hwloc_get_obj_by_depth(topolo=
gy, depth, k)` and assigns it to `obj_core` but does **NOT** check if `obj_=
core` is NULL before calling `hwloc_bitmap_weight(obj_core->cpuset)` on lin=
e 581. If `hwloc_get_obj_by_depth()` returns NULL for domain `k`, this will=
 dereference a NULL pointer.

**Location:** `lib/eal/common/eal_topology.c:579-582`

```c
for (uint16_t k =3D 0; k < *layer_cnt; k++) {
    hwloc_obj_t obj_core =3D hwloc_get_obj_by_depth(topology, depth, k);
    int cpu_count_core =3D hwloc_bitmap_weight(obj_core->cpuset);  /* NULL =
deref if obj_core =3D=3D NULL */
    if (cpu_count_core =3D=3D -1)
        continue;
```

**Fix:** Check `obj_core` before dereferencing:

```c
hwloc_obj_t obj_core =3D hwloc_get_obj_by_depth(topology, depth, k);
if (!obj_core)
    continue;
int cpu_count_core =3D hwloc_bitmap_weight(obj_core->cpuset);
if (cpu_count_core =3D=3D -1)
    continue;
```

---

#### **Error: Incorrect second argument to `rte_topo_get_nth_lcore_from_dom=
ain()` in `get_same_l1_domains()` (test_ring_perf.c and test_stack_perf.c)**

In both `app/test/test_ring_perf.c:290` and `app/test/test_stack_perf.c:258=
`, the function `get_same_l1_domains()` calls:

```c
id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L1=
);
```

The second argument (`lcore_pos`) is `0`, which is the same as for `id1`. T=
his will assign **the same lcore** to both `id1` and `id2`, causing the sub=
sequent check `if (id1 =3D=3D id2) return 3;` to always trigger. This is a =
logic error: the intent is clearly to get two **different** lcores from the=
 same domain.

**Location:** `app/test/test_ring_perf.c:287-290` and `app/test/test_stack_=
perf.c:255-258`

**Fix:** Use position `1` for the second lcore:

```c
id1 =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0, RTE_TOPO_DOMAIN_L1=
);
id2 =3D rte_topo_get_nth_lcore_from_domain(domain, 1, 0, RTE_TOPO_DOMAIN_L1=
);
```

---

#### **Error: Iteration condition in `test_main_lcore_in_domain()` uses wro=
ng domain type for lookup**

In `app/test/test_topology.c:211`, the loop iterates over `domain_count` fo=
r `domain_types[d]`, but the call to `rte_topo_is_main_lcore_in_domain()` u=
ses `RTE_TOPO_DOMAIN_NUMA` instead of `domain_types[d]`. This means the tes=
t only checks the NUMA domain regardless of which domain type `d` selects (=
L1/L2/L3/L4).

**Location:** `app/test/test_topology.c:206-216`

```c
for (unsigned int d =3D 0; d < RTE_DIM(domain_types); d++) {
    bool main_lcore_found =3D false;
    unsigned int domain_count =3D rte_topo_get_domain_count(domain_types[d]=
);
    for (unsigned int dmn_idx =3D 0; dmn_idx < domain_count; dmn_idx++) {
        main_lcore_found =3D rte_topo_is_main_lcore_in_domain(RTE_TOPO_DOMA=
IN_NUMA,  /* BUG: should be domain_types[d] */
            dmn_idx);
        if (main_lcore_found)
            break;
    }
```

**Fix:**

```c
main_lcore_found =3D rte_topo_is_main_lcore_in_domain(domain_types[d], dmn_=
idx);
```

---

#### **Error: Infinite loop risk in `rte_topo_get_nth_lcore_from_domain()` =
when `ptr->core_count` is 0**

In `lib/eal/common/eal_topology.c:296-318`, the function enters a `while (1=
)` loop that increments `new_lcore_pos`. If `ptr->core_count` is 0 (which t=
he code checks earlier but does not return immediately), the loop will wrap=
 `new_lcore_pos` back to 0 indefinitely, never breaking. While the function=
 returns `RTE_MAX_LCORE` if `ptr->core_count =3D=3D 0` before the loop, the=
 logic flow is unclear and the loop body does not have a clear termination =
condition if the core count is 0.

**Location:** `lib/eal/common/eal_topology.c:283-318`

**Fix:** Add a sanity check inside the loop to prevent infinite iteration:

```c
unsigned int iterations =3D 0;
while (1) {
    if (iterations++ > ptr->core_count * 2)  /* safety limit */
        return RTE_MAX_LCORE;
    /* ... rest of loop ... */
}
```

However, the real issue is that the code already returns `RTE_MAX_LCORE` if=
 `ptr->core_count =3D=3D 0` on line 287, so this is more of a defensive-pro=
gramming note. The function should be refactored for clarity.

---

#### **Error: Missing NULL check after `get_domain_lcore_mapping()` in `rte=
_topo_get_next_lcore()`**

In `rte_topo_get_next_lcore()`, the code calls `get_domain_lcore_mapping(fl=
ag, lcore_domain)` and checks if `ptr` is NULL on line 350. However, if `pt=
r` is NULL, the function returns `RTE_MAX_LCORE`. This is correct, but the =
subsequent logic on line 381 calls `rte_topo_is_main_lcore_in_domain(flag, =
lcore_domain)`, which internally may call `get_domain_lcore_mapping()` agai=
n. If that call also returns NULL (which it will if the domain is invalid),=
 the function `rte_topo_is_main_lcore_in_domain()` will return `false`, whi=
ch is safe. However, the logic is fragile and should explicitly handle the =
NULL case to avoid relying on transitive safety.

**Location:** `lib/eal/common/eal_topology.c:381`

**Recommendation:** The code is technically safe but could be clearer. No c=
hange required, but consider restructuring for maintainability.

---

### Patch 2/3: app/test Topology Tests

#### **Error: Macro `RTE_TOPO_FOREACH_WORKER_LCORE_IN_DOMAIN` declares vari=
able in macro expansion (shadowing risk)**

In `lib/eal/include/rte_topology.h:243-248`, the macro `RTE_TOPO_FOREACH_WO=
RKER_LCORE_IN_DOMAIN` declares a local variable `main_lcore` inside the mac=
ro expansion:

```c
#define RTE_TOPO_FOREACH_WORKER_LCORE_IN_DOMAIN(lcore, domain_indx, flag)  \
    lcore =3D rte_topo_get_nth_lcore_from_domain(domain, 0, 0, flag);  \
    uint16_t main_lcore =3D rte_get_main_lcore();  \
    for (lcore =3D (lcore !=3D main_lcore) ? \
        lcore : rte_topo_get_next_lcore(lcore, 1, 0, flag);  \
        lcore < RTE_MAX_LCORE;  \
        lcore =3D rte_topo_get_next_lcore(lcore, 1, 0, flag))
```

This can cause a compiler error or shadowing if the caller already has a va=
riable named `main_lcore` in scope. Additionally, the macro uses `domain` (=
line 244) but the parameter is `domain_indx`, which is a typo and will caus=
e a compilation error.

**Location:** `lib/eal/include/rte_topology.h:243-248`

**Fix:** Wrap in a `do { } while (0)` and use a uniquely-named variable, or=
 document that the macro must not be used if `main_lcore` is already declar=
ed. Also fix the typo:

```c
#define RTE_TOPO_FOREACH_WORKER_LCORE_IN_DOMAIN(lcore, domain_indx, flag)  \
    lcore =3D rte_topo_get_nth_lcore_from_domain(domain_indx, 0, 0, flag); =
 \
    uint16_t __topo_main_lcore =3D rte_get_main_lcore();  \
    for (lcore =3D (lcore !=3D __topo_main_lcore) ? \
        lcore : rte_topo_get_next_lcore(lcore, 1, 0, flag);  \
        lcore < RTE_MAX_LCORE;  \
        lcore =3D rte_topo_get_next_lcore(lcore, 1, 0, flag))
```

---

### Summary of Correctness Bugs

1. **hwloc topology leak** on `eal_topology_map_layer()` failure
2. **Resource leak** in `eal_topology_map_layer()` on partial allocation fa=
ilure
3. **NULL pointer dereference** in `eal_topology_map_layer()` inner loop
4. **Logic error** in `get_same_l1_domains()` (same lcore assigned to `id1`=
 and `id2`)
5. **Wrong domain type** in `test_main_lcore_in_domain()` (uses `RTE_TOPO_D=
OMAIN_NUMA` instead of `domain_types[d]`)
6. **Macro typo** in `RTE_TOPO_FOREACH_WORKER_LCORE_IN_DOMAIN` (uses `domai=
n` instead of `domain_indx`)
7. **Potential infinite loop** in `rte_topo_get_nth_lcore_from_domain()` if=
 `ptr->core_count =3D=3D 0` (mitigated by early
