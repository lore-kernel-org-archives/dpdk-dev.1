Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D63FFD9E01
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 19:37:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D8634042F;
	Thu, 26 Feb 2026 20:37:30 +0100 (CET)
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by mails.dpdk.org (Postfix) with ESMTP id 145374027F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:37:29 +0100 (CET)
Received: by mail-qt1-f193.google.com with SMTP id
 d75a77b69052e-506a1627a09so7414501cf.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772134648;
 x=1772739448; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHbKcsm7iJ3GTi1mjXSkiSs4xlIfmwQ/+YrZjNzoho8=;
 b=SyhqMID8T2kNMJZ0MNGkmGbrvVYt9HDwiYu02QnsjC/2xr7bvpTROKhth71vY1FKpw
 ebt8xond+yb1mS9MoVd38thFSzQNMQCxXF6blTx2S/XIrxnk++McOGKYE9KwuNyhUtG5
 kUYBCj9T9YOGI8HHayaH0W6m4OCTAKkUgckI/jeSDRZQ8Alie/glyFiVIKxFUSWrUE11
 krkzLGoutAGfK5OI8ZUcDAOaoJwOfHZN2IprCdSZ4J9E/TDlDC9j2OPB1dQ7u9CaBPEa
 rhj+qfZDIPXq3AEAE/yET0xyBGQhsvfpsOkCYoj4jb/2KqubbuG3ooTv6gQwCn/w3I3n
 v63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772134648; x=1772739448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yHbKcsm7iJ3GTi1mjXSkiSs4xlIfmwQ/+YrZjNzoho8=;
 b=YPWhUBgonXDVn5gdLTMdUDuZzzn9QAHKNEcdXtfUQFRy19A0n1rQg4MYtYdDWVOeIe
 xTnwsw/CztqLfVdonig4wWZIn6714Fj6MYaMtwLnK4X6pEN4Yp+UTk4U46IC4nHGdLyQ
 zIxXFltg4iQwef3u+UKD6YPQ++8ns1tKE4RjXsyKR5FN/CyPA6JQ+Q5YiDjnJf6/waSW
 ece1yJ/DisaAZT3iG1kIx6rZ2NV3J8D+1Agrff4WUEvkQz9+aGe7D40vPQHLuVgPnekQ
 n0YvDwEVpOj3rIqXoat0+M4xmIGAjUQ07+vOJ0f2PmdzJ3lQemMUMl0KVvn4TS5P7+Wl
 GiaA==
X-Gm-Message-State: AOJu0YwZ5pErp4qAZ2ZAMcWVflSl9xLGgyUAZGBLzxilnWYfeX8fHSYQ
 CBf7oR2FK71rXWSehysMKIqen18mNUb8cFrGlU59OOR34rDzgsBZ8mEfAlIvaxqCPZQ=
X-Gm-Gg: ATEYQzzMwDGHoFMVcCmDRBHfdcg43ZF3e8tdaedRgrPGv+ESDPom/4GkADoFjY0e9eY
 9FJTMc3Htqy1yl1imV/Ka90oTDAZbTdAtjIBn8kKvrjSsYyc9n8HQQ8VS/9RowviP4dyx8Knd0Z
 XHfTuhgGGGsh8kHgooHp1m6h2tOb7HgD9reMR0B++zC7XUBtEdmzYnBaM4JoJvpqmfnCi4OccH8
 OhM0cKNKY5PWWcNOu69tqLhsxhCapBi22AZ0VGd46aSPRtVcfmw8+NDNb8DBVn3vhkw/rSoYLfa
 z+YRuiuNaEHPPwVb73uZ/uHw8jctv/q9R6qJKGSIuXHHDz1/9zsgANV4bdDMS58NK1DP/CFCHNz
 JtYuSOWQhfu1zSl6oTrwL+IlA6snLI2u711QZv1e3zDJmkF0DpFDxcpm+OqWVKRV8eiVPxaX19z
 eJRH+gPFU83J+H+0URaaE+36kX5xcs44/8VyPNBjF599H6yhyUokcTjj5YhsCjKzLX
X-Received: by 2002:a05:622a:48e:b0:506:a320:e458 with SMTP id
 d75a77b69052e-5075296e835mr1283211cf.41.1772134647989; 
 Thu, 26 Feb 2026 11:37:27 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449630absm27663631cf.5.2026.02.26.11.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 11:37:27 -0800 (PST)
Date: Thu, 26 Feb 2026 11:37:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linux.microsoft.com
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Long Li <longli@microsoft.com>
Subject: Re: [PATCH v4 0/7] fix multi-process VF hotplug
Message-ID: <20260226113724.3b5ca20c@phoenix.local>
In-Reply-To: <20260226023940.961844-1-longli@linux.microsoft.com>
References: <20260226023940.961844-1-longli@linux.microsoft.com>
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

On Wed, 25 Feb 2026 18:39:31 -0800
longli@linux.microsoft.com wrote:

> From: Long Li <longli@microsoft.com>
>=20
> Fix several issues with VF hotplug and multi-process support in
> netvsc, mana, mlx5, and mlx4 drivers:
>=20
> - Fix race conditions between VSP notifications and DPDK device events
>   during VF add/remove, with proper locking of VF-related fields
> - Add multi-process communication infrastructure for coordinating VF
>   removal across primary and secondary processes
> - Fix Protection Domain resource leak on device close in mana
> - Fix devargs memory leak during VF hotplug in netvsc
> - Fix fast-path ops (rte_eth_fp_ops) setup in secondary processes for
>   mana, mlx5, and mlx4, preventing segfaults on VF hot-add
>=20
> v4:
> - Patch 1: Check hn_vf_add() return value in netvsc_hotplug_retry
> - Patch 1: Track fresh_attach to avoid tearing down original VF
>   attachment when configure/start fails on an -EEXIST path
> - Patch 2: Move counter decrement and netvsc_uninit_once() after device
>   cleanup in eth_hn_remove() to prevent use-after-free of shared data
> - Patch 2: Clear netvsc_shared_data on init failure paths to prevent
>   dangling pointer
>=20
> v3:
> - Fix review comments from v2
>=20
> v2:
> - Initial rework of VF add/remove locking
>=20
> Long Li (7):
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
>  drivers/net/netvsc/hn_ethdev.c      | 300 +++++++++++++++++++++++++++-
>  drivers/net/netvsc/hn_nvs.h         |   6 +
>  drivers/net/netvsc/hn_rxtx.c        |  40 ++--
>  drivers/net/netvsc/hn_var.h         |   1 +
>  drivers/net/netvsc/hn_vf.c          | 148 ++++++++------
>  9 files changed, 431 insertions(+), 92 deletions(-)
>=20

Looks to be in good shape, you may want to address these errors
flagged by AI review.

Critical Finding Summary
Patch	Severity	Issue
5, 6, 7	Error	START_RXTX handler does not restore rte_eth_fp_ops burst func=
tion pointers after STOP clears them =E2=80=94 secondary Rx/Tx broken after=
 STOP+START cycle
3	Warning	PD deallocation order: parent freed before child may cause EBUSY;=
 reverse the order
1	Warning	switch_data_path failure leaves VF attached/started but unused
1	Warning	eth_hn_dev_init ignores hn_vf_add_unlocked error (pre-existing)
2	Info	secondary_cnt atomics use acquire/release where relaxed suffices


# DPDK VF Hotplug Patch Series v4 Review

**Series**: [PATCH v4 1/7] through [PATCH v4 7/7]
**Author**: Long Li <longli@microsoft.com>
**Reviewed against**: AGENTS.md DPDK Code Review Guidelines

---

## Summary

This series addresses race conditions and resource management issues in the=
 netvsc/mana/mlx5/mlx4 drivers around VF hotplug, multi-process coordinatio=
n, and fast-path ops setup. The locking rework in patch 1 is substantial an=
d well-structured. The multi-process infrastructure in patch 2 is a signifi=
cant addition. Commit messages throughout are excellent =E2=80=94 clear roo=
t cause analysis, well-documented change rationale, and honest notes about =
limitations.

Subject lines are all within 60 characters, Fixes tags all have 12-characte=
r SHAs, tag ordering is correct throughout, and commit body line wrapping i=
s clean.

---

## Patch 1: net/netvsc: fix race conditions on VF add/remove events

### Correctness analysis

The locking redesign is solid:

- **Rx/Tx fast path**: Moving the lock acquisition outside the `vf_vsc_swit=
ched` check eliminates the TOCTOU race where the flag was checked without t=
he lock, then the VF could be removed before the lock was acquired. The old=
 double-check pattern was racy.

- **`hn_vf_close`**: Upgrading from `rte_rwlock_read_lock` to `rte_rwlock_w=
rite_lock` is correct =E2=80=94 the function modifies `vf_attached`, which =
is a write operation.

- **`hn_vf_detach`/`fresh_attach` pattern**: On `-EEXIST` from `hn_vf_attac=
h`, the `fresh_attach =3D false` flag correctly prevents `hn_vf_detach` fro=
m tearing down a previously valid VF attachment on configure/start failure.=
 This is a subtle and well-handled case.

- **Callback registration moved to `hn_vf_attach`**: Registering the RMV ca=
llback immediately on attach (with rollback on failure) is cleaner than the=
 old placement in `hn_vf_configure`.

### Warning: `hn_vf_add_unlocked` does not clean up VF on `switch_data_path=
` failure

If `hn_nvs_set_datapath(NVS_DATAPATH_VF)` fails at the `switch_data_path` l=
abel, the function returns the error but leaves the VF attached and possibl=
y started. The VF sits running but unused (traffic goes through synthetic p=
ath). The self-healing retry mechanism (re-entry through `hn_nvs_handle_vfa=
ssoc` or `netvsc_hotplug_retry`) would eventually retry, so this is not a c=
rash bug, but a `goto detach` on data path switch failure would be cleaner =
and avoid the VF running in a wasted state.

### Warning: `eth_hn_dev_init` silently ignores `hn_vf_add_unlocked` error

```c
rte_rwlock_write_lock(&hv->vf_lock);
if (hv->vf_ctx.vf_vsp_reported && !hv->vf_ctx.vf_vsc_switched) {
    PMD_INIT_LOG(DEBUG, "Adding VF device");
    err =3D hn_vf_add_unlocked(eth_dev, hv);
}
rte_rwlock_write_unlock(&hv->vf_lock);

return 0;  /* err is ignored */
```

The `err` from `hn_vf_add_unlocked` is stored but never checked =E2=80=94 t=
he function always returns 0. This is pre-existing behavior, but worth noti=
ng as it could mask VF setup failures during init.

---

## Patch 2: net/netvsc: add multi-process VF device removal support

### Correctness analysis

The multi-process infrastructure is well-designed:

- **Shared memzone** for `secondary_cnt` with proper atomic operations
- **Spinlock** protecting the one-time init/uninit sequence
- **`rte_mp_request_sync`** with timeout for reliable cross-process coordin=
ation
- **ENOTSUP** handling for single-process mode

### Info: Memory ordering stronger than necessary

The `secondary_cnt` atomic uses `rte_memory_order_release` for stores and `=
rte_memory_order_acquire` for loads. Since this counter doesn't guard any o=
ther shared data (it's just a "should I bother sending MP requests?" optimi=
zation), `rte_memory_order_relaxed` would suffice. The current ordering is =
correct but unnecessarily strong.

### Info: `netvsc_mp_primary_handle` is a stub

```c
static int
netvsc_mp_primary_handle(const struct rte_mp_msg *mp_msg __rte_unused,
                          const void *peer __rte_unused)
{
    /* Stub function required for multi-process message handling registrati=
on */
    return 0;
}
```

The comment explains this is needed for registration. This is fine =E2=80=
=94 the primary currently only sends, never receives. If future message typ=
es require primary handling, this stub is the extension point.

---

## Patch 3: net/mana: fix PD resource leak on device close

### Warning: PD deallocation order may be wrong

The code frees `ib_parent_pd` before `ib_pd`:

```c
if (priv->ib_parent_pd) {
    int err =3D ibv_dealloc_pd(priv->ib_parent_pd);
    ...
}
if (priv->ib_pd) {
    int err =3D ibv_dealloc_pd(priv->ib_pd);
    ...
}
```

If `ib_pd` is a child/derived PD of `ib_parent_pd`, `ibv_dealloc_pd(ib_pare=
nt_pd)` will fail with EBUSY because the child still holds a reference. The=
 error is logged and the code continues, so `ib_pd` gets freed next, and `i=
bv_close_device` cleans up the orphaned parent PD. This works but is fragil=
e.

Reversing the order (free `ib_pd` first, then `ib_parent_pd`) would be clea=
ner and avoid the EBUSY error on the parent. If the PDs are independent (no=
 parent-child verbs relationship), the order doesn't matter, but the naming=
 strongly suggests a hierarchy.

---

## Patch 4: net/netvsc: fix devargs memory leak on hotplug

No issues. The `rte_devargs_reset()` calls are correctly placed in both cle=
anup paths before `free(hot_ctx)`.

---

## Patches 5, 6, 7: net/mana, net/mlx5, net/mlx4: fix fast-path ops setup i=
n secondary process

### Error: `rte_eth_fp_ops` burst function pointers not updated in START_RX=
TX handler

All three patches update `rte_eth_fp_ops[].rxq.data` and `txq.data` in the =
START handler, and update `rte_eth_fp_ops[].rx_pkt_burst` and `tx_pkt_burst=
` in the STOP handler. But the START handler does **not** restore the burst=
 function pointers.

After a STOP =E2=86=92 START cycle:
1. STOP sets `rte_eth_fp_ops[port].rx_pkt_burst =3D dummy` (newly added by =
this patch)
2. START sets `rte_eth_fp_ops[port].rxq.data =3D dev->data->rx_queues` but =
does NOT restore `rx_pkt_burst`
3. Secondary's `rte_eth_rx_burst()` calls `rte_eth_fp_ops[port].rx_pkt_burs=
t(...)` which is still the dummy =E2=86=92 **Rx/Tx broken**

Since `rte_eth_rx_burst()` uses `rte_eth_fp_ops` (process-local), not `dev-=
>rx_pkt_burst` (shared), the secondary cannot receive or transmit after a S=
TOP+START cycle even though `dev->rx_pkt_burst` was correctly set.

This may not manifest on the **first** start (where `rte_eth_dev_probing_fi=
nish()` sets fp_ops during probe), and it may be masked if the VF is re-pro=
bed during hot-add. But it will manifest on any in-place STOP+START cycle w=
ithout re-probe.

**Suggested fix** =E2=80=94 add to each START_RXTX handler:

For patch 5 (mana):
```c
rte_eth_fp_ops[param->port_id].rx_pkt_burst =3D mana_rx_burst;
rte_eth_fp_ops[param->port_id].tx_pkt_burst =3D mana_tx_burst;
```

For patch 6 (mlx5):
```c
rte_eth_fp_ops[param->port_id].rx_pkt_burst =3D dev->rx_pkt_burst;
rte_eth_fp_ops[param->port_id].tx_pkt_burst =3D dev->tx_pkt_burst;
```

For patch 7 (mlx4), same as mlx5.

Place these **before** the `rte_mb()` call so the barrier covers all fp_ops=
 updates.

---

## Critical Finding Summary

| Patch | Severity | Issue |
|-------|----------|-------|
| 5, 6, 7 | **Error** | START_RXTX handler does not restore `rte_eth_fp_ops=
` burst function pointers after STOP clears them =E2=80=94 secondary Rx/Tx =
broken after STOP+START cycle |
| 3 | Warning | PD deallocation order: parent freed before child may cause =
EBUSY; reverse the order |
| 1 | Warning | `switch_data_path` failure leaves VF attached/started but u=
nused |
| 1 | Warning | `eth_hn_dev_init` ignores `hn_vf_add_unlocked` error (pre-e=
xisting) |
| 2 | Info | `secondary_cnt` atomics use acquire/release where relaxed suff=
ices |
