Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6416FC5ACD9
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:38:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 751DA402AA;
	Fri, 20 Feb 2026 18:38:31 +0100 (CET)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50]) by mails.dpdk.org (Postfix) with ESMTP id B561C4026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:38:30 +0100 (CET)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7d4c85307b2so1386063a34.0
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771609110;
 x=1772213910; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkedIZVpK/tAsJz76i3RqqY78r4t/wr+BFC7d+FJurc=;
 b=eeneB2DKu4p5bM0o4DiF/OcJmDrOJOmPNFXalHDknUvk5mJvTVpdVTbsne6hzxkpse
 wj5haKDONBV+MON14GBKhfM6IPKdHcuHQ5XB7UHa+zVON2f3gQpf7fGtbdGsGzAHsZpZ
 /qSJx4Uy6xQJoUg5ty0FdVSJXIwz3gYVfPDrkFIlT/UoujjoLOa4RnFOE7yUI8nmJEXT
 Sjhs2n78kPpp/A1yewNQqrDd4fyw8B4LIyTIvMvNXsOlphlS4zS9dQSVcAyedtv8l8Ou
 sUIy46yT0k4nlQ6FAisgqAgkg5Y6b7cW+Pk7EpbEeqH1YFDkXBEYMN8OI7hwW/IvBKR7
 yGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771609110; x=1772213910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XkedIZVpK/tAsJz76i3RqqY78r4t/wr+BFC7d+FJurc=;
 b=XdzSYYb4wqCjmNOm4BJGa+1ty1i6fhZ4JTd32izQwrt3M0nr6uGn1pyJXWtWfIODku
 kS1nXKhRK4iG7c+0ITw0LlPadgkOYZEUJu+ETvvnDPqD1Tj7ZYWvDIHVtI1VX/aEtzxO
 T26EytGN0JOdkNFeikx719HqPDVJYMwZx7PTDSbbZUlgci2P1QomNbSO6ZBR0xDmEL08
 +0xOWgjYrRfeYo4PbxQ33M9yMKkX39x2C+ENXIkj8jXqKGXjLdfAWbc8/hX/yHdX9WE3
 fugWQ+GtfP8dafJ2N465qfg06ur9czY8vb1EvpRU4cZZ8o5ixJnYCB+DqOzO/t71SRSs
 dGHg==
X-Gm-Message-State: AOJu0Yw+rWJXd4KNaMrByGSfEI0Z/2cCRtbwkeo3CpvPcoXL16pppN1k
 3tOG4FdlMh/QmTDsHzzu3HAMktwPtzgF5lxuxBIYf/llWjOnbb7L1ILPIbneOfIblzo=
X-Gm-Gg: AZuq6aLQwmb7lWOVDp19RCE7RuVNNuK4BuiTjmaWDLKpHhpjq2E0H1fqiv4FQKmTZg7
 RmifwElb8KUpmBVRiQSolYUN5od42xY2mSkbZNCKtwXQdOPRPRVIWSIqEGbHkodpN54F5SxK36J
 pXD0Us4BvQ83AQtv3yotxAsn8Kmi4h2UIbBsPwTg3vEQ7vyWaWPplKS3Sw/4hY6nWFI6eUZ+xnE
 GaBN95TKDlv6fou55SUP2LzOcrUqN/btpElfYSi6bHnUs2wOKQ7yuk0sUMFh7CDfo4cVlOu3Nve
 yr59ci3IqpISbcEvpg3V3REMJRkQlZzg6CFhmpomGJrZxPwguxqFZ7uZjHg6WI1/v7rE2Oe++3o
 Y0I1q3owLaJJrOp2jwV48vmFS0v8LU2dGFFHke26t5gXskwkB/ljjUs7xOp6iTY8AbGjQf7ndTV
 NukDzEnBMlhiOi6AArKNjSexsX5iypCwBA7BL1X+tJMRb6pqEyYvcWbcazNsbHtvy1
X-Received: by 2002:a05:6830:378d:b0:7c7:69c8:2ce with SMTP id
 46e09a7af769-7d52bf966bemr313537a34.27.1771609109519; 
 Fri, 20 Feb 2026 09:38:29 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78736sm107007a34.5.2026.02.20.09.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:38:28 -0800 (PST)
Date: Fri, 20 Feb 2026 09:38:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linux.microsoft.com
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, Long Li <longli@microsoft.com>
Subject: Re: [PATCH 0/8] fix multi-process VF hotplug
Message-ID: <20260220093825.079fa673@phoenix.local>
In-Reply-To: <20260220010859.595260-1-longli@linux.microsoft.com>
References: <20260220010859.595260-1-longli@linux.microsoft.com>
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

On Thu, 19 Feb 2026 17:08:51 -0800
longli@linux.microsoft.com wrote:

> From: Long Li <longli@microsoft.com>
>=20
> This series fixes multi-process support for DPDK drivers used on
> Azure VMs with Accelerated Networking (AN). When AN is toggled, the
> VF device is hot-removed and hot-added, which can crash secondary
> processes due to stale fast-path pointers and race conditions.
>=20
> Patches 1-3 fix the netvsc PMD:
> - Prevent secondary from calling unsupported promiscuous ops
> - Fix rwlock misuse and race conditions on VF add/remove events
> - Add multi-process VF device removal support via IPC
>=20
> Patches 4-5 fix resource leaks:
> - MANA PD resource leak on device close
> - netvsc devargs memory leak on hotplug
>=20
> Patches 6-8 fix a common bug across MANA, MLX5, and MLX4 drivers
> where the secondary process START_RXTX/STOP_RXTX IPC handlers
> update dev->rx_pkt_burst/tx_pkt_burst but do not update the
> process-local rte_eth_fp_ops[] array. Since rte_eth_rx_burst()
> uses rte_eth_fp_ops (not dev->rx_pkt_burst), the secondary retains
> stale queue data pointers after VF hot-add, causing a segfault.
>=20
> Long Li (8):
>   net/netvsc: secondary ignore promiscuous enable/disable
>   net/netvsc: fix race conditions on VF add/remove events
>   net/netvsc: add multi-process VF device removal support
>   net/mana: fix PD resource leak on device close
>   net/netvsc: fix devargs memory leak on hotplug
>   net/mana: fix fast-path ops setup in secondary process
>   net/mlx5: fix fast-path ops setup in secondary process
>   net/mlx4: fix fast-path ops setup in secondary process
>=20
>  drivers/net/mana/mana.c             |  14 ++
>  drivers/net/mana/mp.c               |   6 +
>  drivers/net/mlx4/mlx4_mp.c          |   4 +
>  drivers/net/mlx5/linux/mlx5_mp_os.c |   4 +
>  drivers/net/netvsc/hn_ethdev.c      | 288 +++++++++++++++++++++++++++-
>  drivers/net/netvsc/hn_nvs.h         |   5 +
>  drivers/net/netvsc/hn_rxtx.c        |  40 ++--
>  drivers/net/netvsc/hn_var.h         |   1 +
>  drivers/net/netvsc/hn_vf.c          | 122 ++++++------
>  9 files changed, 397 insertions(+), 87 deletions(-)
>=20

I didn't see anything wrong, but AI review spotted some issues.
Address these and resubmit.

Prompt: Using AGENTS.md, do a deep dive patch review of this patchset to DP=
DK VF support in Azure


Here's a summary of the key findings across the 8-patch series:

Errors (must fix):

    Patch 2 =E2=80=94 __hn_vf_add and __hn_vf_remove use double-underscore =
prefixes reserved by the C standard. Rename to _unlocked() variants.
    Patch 2 =E2=80=94 Resource leak in __hn_vf_add: if configure/start fail=
s after hn_vf_attach() succeeds, the VF is left in a half-attached state (c=
allback registered, ownership held, vf_attached =3D true) with no cleanup p=
ath.
    Patch 3 =E2=80=94 netvsc_secondary_handle_device_remove uses hv->vf_ctx=
.vf_port to index rte_eth_devices[] without validating the port is valid in=
 the secondary's address space.

Warnings (should fix):

    Patch 2 =E2=80=94 __hn_vf_remove leaves vf_vsc_switched =3D true if hn_=
nvs_set_datapath(SYNTHETIC) fails, meaning Rx/Tx fast paths keep trying to =
use a dead VF.
    Patch 3 =E2=80=94 netvsc_mp_req_VF naming violates DPDK lowercase conve=
ntion; relaxed memory ordering on secondary_cnt could miss a recently-attac=
hed secondary on ARM; netvsc_uninit_once can tear down shared infrastructur=
e prematurely if a probe fails with other ports active.
    Patch 4 =E2=80=94 ret from ibv_dealloc_pd shadows the earlier return va=
lue, though in practice execution falls through.
    Patches 6-8 =E2=80=94 Direct writes to rte_eth_fp_ops[] from driver cod=
e bypass the ethdev abstraction layer. Correct for the immediate fix but wo=
rth a follow-up ethdev helper API.

Patches 1, 5 look clean. The mlx5/mlx4 maintainers should ack patches 7-8.

More detail:

# Deep Dive Patch Review: Azure VF Hotplug Series (8 patches)

**Submitter:** Long Li <longli@microsoft.com>
**Delegate:** Stephen Hemminger
**Series:** VF hotplug improvements for netvsc, mana, mlx5, mlx4

---

## Patch 2/8: net/netvsc: fix race conditions on VF add/remove events

### Error: `__hn_vf_add` =E2=80=94 double-underscore prefix is reserved by =
C standard

The new public API function `__hn_vf_add()` (declared in `hn_var.h` and def=
ined in `hn_vf.c`) uses a name beginning with double underscore. C99 =C2=A7=
7.1.3 reserves all identifiers beginning with `__` for the implementation. =
While this convention is common in Linux kernel code, DPDK is a user-space =
library and this creates undefined behavior per the C standard. More pragma=
tically, it could collide with compiler/libc built-ins.

**Suggested fix:** Rename to `hn_vf_add_unlocked()` or `hn_vf_add_locked()`=
 (matching the pattern used elsewhere in DPDK for locked/unlocked variants)=
, and similarly rename `__hn_vf_remove()` to `hn_vf_remove_unlocked()`.

### Error: Potential resource leak in `__hn_vf_add` on configure/start fail=
ure paths

In `__hn_vf_add()`, after `hn_vf_attach()` succeeds (which sets `vf_attache=
d =3D true`, `vf_port`, and registers the callback), the function proceeds =
to configure and start the VF. If `hn_vf_configure()` (line ~259) or `hn_se=
tup_vf_queues()` (line ~265) or `rte_eth_dev_start()` (line ~275) fails, th=
e function jumps to `exit:` and returns the error. However, the VF remains =
in a partially set up state:

- `vf_attached` is still `true`
- The removal callback is still registered
- Port ownership is still held
- `vf_vsc_switched` remains `false` (data path never switched to VF)

This leaves the netvsc driver in an inconsistent state where it thinks it h=
as a VF attached but the VF is not operational. Subsequent VF add attempts =
will get `-EEXIST` from `hn_vf_attach()`, but the code treats `-EEXIST` as =
success (`if (ret && ret !=3D -EEXIST)`), so it will then try to configure =
the already-failed VF again.

**Suggested fix:** Add a cleanup path that reverses `hn_vf_attach()` on con=
figure/start failure =E2=80=94 unregister the callback, unset ownership, an=
d reset `vf_attached`/`vf_port`.

### Warning: `hn_vf_close()` upgraded from read-lock to write-lock without =
explanation

The change from `rte_rwlock_read_lock` to `rte_rwlock_write_lock` in `hn_vf=
_close()` is correct (the function modifies `vf_attached`), but it's a beha=
vioral change that could surface latency issues if other threads hold read =
locks during close. This is the right fix, but worth noting in the commit m=
essage since it changes locking semantics.

### Warning: `hn_vf_remove` =E2=80=94 `vf_vsc_switched` not cleared on `hn_=
nvs_set_datapath` failure

In the new `__hn_vf_remove()`, if `hn_nvs_set_datapath(hv, NVS_DATAPATH_SYN=
THETIC)` fails, `vf_vsc_switched` is left `true` (the `else` clause only cl=
ears it on success). This is arguably better than the old code which uncond=
itionally cleared it, but it means the driver now thinks the VF data path i=
s still active even though the host may have already removed it. Subsequent=
 operations that check `vf_vsc_switched` (the Rx/Tx fast paths) will contin=
ue trying to use a potentially dead VF port. Consider whether logging is su=
fficient here or whether the state should be forced to `false` regardless, =
since the VF is being removed anyway.

### Warning: Removal callback registered in `hn_vf_attach` before configure

The patch moves `rte_eth_dev_callback_register(RTE_ETH_EVENT_INTR_RMV)` int=
o `hn_vf_attach()`, which is called before `hn_vf_configure()`. This means =
the removal callback can fire before the VF is fully configured. If a remov=
al event arrives in this window, `hn_remove_delayed` will operate on a part=
ially configured VF. The old code registered the callback in `hn_vf_configu=
re()` after `rte_eth_dev_configure()` succeeded, which was a tighter window=
. Consider whether this race is meaningful in practice.

---

## Patch 3/8: net/netvsc: add multi-process VF device removal support

### Error: `netvsc_init_once` uses `ret` uninitialized on primary success p=
ath

In `netvsc_init_once()`, the `ret` variable is not initialized. In the `RTE=
_PROC_PRIMARY` case, if `rte_memzone_reserve()` and `netvsc_mp_init_primary=
()` both succeed, execution falls through the `break` and reaches `return r=
et;` at the end of the function =E2=80=94 but `ret` was never assigned in t=
he success path. This is an uninitialized variable use.

```c
static int netvsc_init_once(void)
{
    int ret;                    // =E2=86=90 uninitialized
    ...
    case RTE_PROC_PRIMARY:
        netvsc_shared_mz =3D rte_memzone_reserve(...);
        if (!netvsc_shared_mz) {
            return -rte_errno;  // error path: returns directly
        }
        ...
        ret =3D netvsc_mp_init_primary();
        if (ret) {
            rte_memzone_free(netvsc_shared_mz);
            break;              // error path: ret is set
        }
        ...
        netvsc_local_data.init_done =3D true;
        break;                  // SUCCESS path: ret still holds
                                // netvsc_mp_init_primary() return (0)
```

On closer inspection, `ret` is set by `netvsc_mp_init_primary()` and if tha=
t returns 0 (success), `ret` is 0 at the `break`. So in practice this works=
, but the code flow is fragile =E2=80=94 if the success path is refactored =
to skip the `netvsc_mp_init_primary()` call, `ret` would be garbage. Initia=
lize `ret =3D 0` for clarity and safety.

### Error: `netvsc_secondary_handle_device_remove` accesses VF port without=
 validation

```c
static int netvsc_secondary_handle_device_remove(struct hn_data *hv)
{
    uint16_t port_id =3D hv->vf_ctx.vf_port;
    struct rte_eth_dev *dev;

    dev =3D &rte_eth_devices[port_id];
    return rte_eth_dev_release_port(dev);
}
```

The comment says "VF is already locked by primary" but this runs in the sec=
ondary process =E2=80=94 the primary's write lock on `hv->vf_lock` doesn't =
protect secondary process memory. If `vf_port` has already been reset or th=
e port is invalid in the secondary's address space, this will access out-of=
-bounds memory or release the wrong port. There's no `rte_eth_dev_is_valid_=
port()` check on `port_id` here (unlike the caller `netvsc_mp_secondary_han=
dle` which validates `param->port_id` =E2=80=94 but that's the *netvsc* por=
t, not the VF port).

**Suggested fix:** Add `rte_eth_dev_is_valid_port(port_id)` check before ac=
cessing `rte_eth_devices[port_id]`.

### Warning: `netvsc_mp_req_VF` =E2=80=94 function name uses non-standard c=
asing

The function `netvsc_mp_req_VF` mixes snake_case with an uppercase suffix. =
DPDK convention is all-lowercase with underscores for C functions. Should b=
e `netvsc_mp_req_vf` or `netvsc_mp_req_vf_remove` (since the function curre=
ntly only handles remove).

### Warning: `netvsc_uninit_once` checks counts using bitwise OR

```c
if (netvsc_local_data.primary_cnt |
    netvsc_local_data.secondary_cnt)
    return;
```

Using bitwise OR (`|`) instead of logical OR (`||`) works correctly for non=
-zero checks on unsigned integers, but is unconventional and may confuse re=
aders or trigger compiler warnings at higher warning levels. Should use `||=
`.

### Warning: Memory ordering inconsistency for `secondary_cnt`

The shared `secondary_cnt` is accessed with `rte_memory_order_relaxed` thro=
ughout, but it's used as a synchronization signal in `netvsc_mp_req_VF()` t=
o decide whether to send IPC messages. Relaxed ordering means the primary m=
ight read a stale zero and skip the IPC even though a secondary has already=
 incremented the counter. In practice on x86 this is unlikely to matter, bu=
t on ARM it could miss a recently-attached secondary. Consider `rte_memory_=
order_acquire`/`release` for the load in `netvsc_mp_req_VF` and the stores =
in probe/remove.

### Warning: `eth_hn_probe` error path calls `netvsc_uninit_once` without m=
atching count increment

If `rte_dev_event_monitor_start()` or `eth_dev_vmbus_allocate()` fails, the=
 error path jumps to `init_once_failed:` which calls `netvsc_uninit_once()`=
. However, at that point `netvsc_local_data.primary_cnt` hasn't been increm=
ented yet (the increment happens after `rte_eth_dev_probing_finish()`). So =
`netvsc_uninit_once()` will see `primary_cnt =3D=3D 0` and `secondary_cnt =
=3D=3D 0`, and will tear down the shared infrastructure =E2=80=94 even if o=
ther netvsc ports are still active. This is only a problem if there are mul=
tiple netvsc devices and one fails to probe while others are already runnin=
g.

---

## Patch 4/8: net/mana: fix PD resource leak on device close

### Warning: Return value from `ibv_dealloc_pd` shadows error from `mana_de=
v_stop`

The `ret` variable is reused for `ibv_dealloc_pd()` results, overwriting th=
e return value from the preceding `mana_dev_stop()` call chain. If `ibv_dea=
lloc_pd(ib_parent_pd)` fails but `ibv_dealloc_pd(ib_pd)` succeeds, `ret` wi=
ll be 0 and the close will report success despite a deallocation failure. C=
onversely, if dealloc fails, `ret` becomes non-zero and the function may re=
turn that error instead of continuing to `ibv_close_device()`.

Looking at the code more carefully: the comment says "The close proceeds re=
gardless because ibv_close_device() will force kernel cleanup." But the cod=
e as written *does* fall through regardless because each `ibv_dealloc_pd` r=
esult is only logged =E2=80=94 the code doesn't return early. However, the =
final `ret` fed to `ibv_close_device`'s error handling may be wrong. Consid=
er using a separate variable for the dealloc return values.

---

## Patch 5/8: net/netvsc: fix devargs memory leak on hotplug

No correctness issues found. The fix is straightforward and correctly adds =
`rte_devargs_reset()` before `free()` in both cleanup paths.

---

## Patch 6/8: net/mana: fix fast-path ops setup in secondary process

### Warning: Direct write to `rte_eth_fp_ops` may break abstraction

The patches for mana, mlx5, and mlx4 (patches 6-8) all directly write to `r=
te_eth_fp_ops[]` fields from driver code. The `rte_eth_fp_ops` structure is=
 part of ethdev's internal fast-path mechanism, and drivers typically don't=
 manipulate it directly =E2=80=94 `rte_eth_dev_start()` and `eth_dev_fp_ops=
_setup()` handle this. While this works today, it couples the driver to eth=
dev internals. Consider whether ethdev should provide a helper API for seco=
ndary process fast-path setup instead, even if that's a separate follow-up.

### Warning: No bounds check on `param->port_id` before indexing `rte_eth_f=
p_ops`

In both the START_RXTX and STOP_RXTX handlers, `param->port_id` is used to =
index `rte_eth_fp_ops[]` without validation that it's within `RTE_MAX_ETHPO=
RTS`. While the port was already validated earlier via `rte_eth_dev_is_vali=
d_port()` in the mana handler, this validation should also hold true at the=
 point of use. This is a minor robustness concern.

---

## Patches 7/8 and 8/8: net/mlx5 and net/mlx4 fast-path ops in secondary

Same pattern and same observations as Patch 6/8 =E2=80=94 direct `rte_eth_f=
p_ops` writes. The fix is correct for the stated problem (secondary process=
 SIGSEGV on VF hot-add). Same warning about ethdev abstraction applies.

---

## Series-Level Observations

### The series mixes netvsc driver changes with mana/mlx5/mlx4 driver chang=
es

Patches 1-3 and 5 are netvsc-specific. Patch 4 is mana-specific (PD leak). =
Patches 6-8 fix the same secondary-process fast-path issue in three differe=
nt drivers. These are related by the Azure VF hotplug scenario, but the man=
a PD leak (patch 4) is an independent bug. Consider whether the mlx5/mlx4 c=
hanges (patches 7-8) need acks from their respective maintainers (Nvidia).

### Missing release notes

This series includes multiple bug fixes with `Cc: stable@dpdk.org`. While b=
ug fixes don't strictly require release notes, the multi-process VF removal=
 infrastructure in patch 3 is a significant new feature that warrants a rel=
ease note entry.
