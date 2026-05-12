Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EF8CD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 14:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E9884042E;
	Tue, 12 May 2026 16:38:23 +0200 (CEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8F435402C1
 for <dev@dpdk.org>; Tue, 12 May 2026 16:38:21 +0200 (CEST)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-3922b35e69cso47734281fa.0
 for <dev@dpdk.org>; Tue, 12 May 2026 07:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778596701;
 x=1779201501; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPmLzCazn8gmJiLRfGM5mRXj2g/700WlLwVNA7thUC8=;
 b=R5APHGZ9iQKKfEaflsLncpz/MIcDDeCxMWxUEvisRzEtW03Z5Veeb/HA/y3IfJljNq
 B744YNEYmgkd3aQbD6qDhhk81lptVgCXx4711Dnf94jh3izYjfyLd8j5u4MEs3DOeHSh
 rtH3XjLICne16ZbOSTRFvrsDyveYMbDXxQjIgIOKqraAid8pn0n8xNH4ADLZ2SwqiGwi
 RSw4yRcJi0nyAIEX7RZ0FijQAZdJnH8u2kuLwc1EWiX0BWyZEy0NA2gErgwdWFANa+OY
 N9SJVNTSE+5ti7h7gdqIT3WPQ819QVIWzJ/k+LvbDiWf8XvGUz/Gn67rjjuHs3QPJjGp
 nkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778596701; x=1779201501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XPmLzCazn8gmJiLRfGM5mRXj2g/700WlLwVNA7thUC8=;
 b=Fj20Gb+nf7TAAgfeNRD709VNyRBV37dxIYzKVtGXh06HFyHnzNthyNfWwkv9LNEOic
 T1FEHKnkbnVHuUyuj/3QkHEYdX2VmD/2RUMbJFod7IYfFYkkhaEPnxi7pq25HgGnUnpu
 Ck2AcZTJ9ZNbYezrwC9mGAjSipD0R+CizJHH13w4PqIvpOO4elxDupqmEpRPsrUEFYFh
 w2O2aHM6ly8pfVtvkLXoJCNUxmVtpsvpJfQTJawX9Wu8CzRBv7FB2rI+dRUT/zRqwMIT
 FUS6QZIjCR5uIecRLl64HdV0vi3Gv3yqJZdnbL9gSqbcqYKffoiGEm84ogvyC5Zd6F2n
 hksA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6IVSvKsUALQCsiB+ODWqdBga55n5MpCG46nwBxeWzQyXvxM+NWSDAUFqiBEa002Td9IQ=@dpdk.org
X-Gm-Message-State: AOJu0YyjfvVuIWWfCz4XXTEckKRSpqeWBO1l0iNkjtO0i4TEr6cg10E9
 PJkOjM+2ivRsTHsJ7E9bEkadyb2BFfC+VuxU/k/ut35BCwp36aWQG9L8pjJF0WSUw6Y=
X-Gm-Gg: Acq92OGvKqKvcv3iuq1lmGp1xg5sUvJlgQ6z4FdgxfrtsAcM+gPunpCjDe+2YSf+t81
 DaIvpm80Q+OFjQs0ArSNZfn6wX+6eJDDQqGlhu7i5q+TCeKZZcHK3buM6a7VFCT/1HOuZlIFflT
 Mc27tNojVh1pO00eXrTY7bxeOzayaT0T8nr8r6OOKDX2ZRSpeofnkjPBJpQ3j4hJcsQqi0OpqTM
 YgEHD0mfeAjmMcjVwXDpAygB3ZO9Gqzf3OhlcRPmrBtHoQ7gefgffui+REHKYZggYVjxuja9/SD
 jsCU+8d3zuiqkGFfpeYksd8ZlEkydPPzDI0hTnC82nCGsM4lx/G2qmJRIwXYA+yoI4y3FUt/fVl
 SGegR7x0mqZ5c/Ut0ngHmSr06wKrCB23rm3BWciPsWsjQEosxqFZzIdYDK81944IiJwfILWe/H8
 MbD9i9cVi32JtuO9BZ0Zpk/AXBPchd1il8ecAUN1piiVkZNRWoRFY=
X-Received: by 2002:a05:651c:e18:b0:393:a7d7:7e84 with SMTP id
 38308e7fff4ca-3943cbd0bebmr11879251fa.24.1778596700592; 
 Tue, 12 May 2026 07:38:20 -0700 (PDT)
Received: from stephen-xps.local ([62.119.255.230])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f60db67esm33612871fa.24.2026.05.12.07.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:38:20 -0700 (PDT)
Date: Tue, 12 May 2026 16:38:18 +0200
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v1 0/4] Introduce generic cache stash API and PCIe TPH
 implementation
Message-ID: <20260512163818.2a5859eb@stephen-xps.local>
In-Reply-To: <20260508092855.51987-1-fengchengwen@huawei.com>
References: <20260508092855.51987-1-fengchengwen@huawei.com>
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

On Fri, 8 May 2026 17:28:51 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> This patch set introduces a generic ethdev cache stash framework,
> provides PCIe TPH (Transaction Processing Hints) implementation
> on PCI/VFIO bus, enables TPH cache stash support for e1000/igb PMD,
> and adds testpmd command line configuration.
> 
> The patchset is organized as follows:
> - Patch 1/4: bus/pci: introduce PCIe TPH support
>   Add generic PCIe TPH APIs and VFIO backend implementation,
>   with stub implementations for BSD and Windows.
> 
> - Patch 2/4: ethdev: introduce generic cache stash API
>   Define unified cache stash capability/operation/config abstraction,
>   support device-level and per-queue stash management.
> 
> - Patch 3/4: net/e1000: add cache stash support via TPH
>   Implement ethdev cache stash ops for igb PMD based on PCIe TPH.
> 
> - Patch 4/4: app/testpmd: add TPH stash objects configuration
>   Add testpmd CLI option to configure stash objects and
>   automatically apply stash enable/disable on forwarding start/stop.
> 
> Note:
> 1. This implementation references the Linux kernel VFIO TPH uapi
>    series (v8 version), which is not yet merged upstream:
>    https://lore.kernel.org/all/20260508064053.37529-1-fengchengwen@huawei.com/
> 
> 2. The API design and cache stash model learn from the prior  work
>    by Wathsala Vithanage: "An API for Cache Stashing with TPH".
> 
> 3. The e1000/igb PMD is enabled as the first user of this API
>    because it is the only PCIe TPH capable hardware available
>    for testing at this time. The generic API design is extensible
>    to other NICs and future cache stash mechanisms.
> 
> Chengwen Feng (4):
>   bus/pci: introduce PCIe TPH support
>   ethdev: introduce generic cache stash API
>   net/e1000: add cache stash support via TPH
>   app/testpmd: add TPH stash objects configuration
> 
>  app/test-pmd/parameters.c               |  20 ++
>  app/test-pmd/testpmd.c                  |  81 +++++++
>  app/test-pmd/testpmd.h                  |   1 +
>  drivers/bus/pci/bsd/pci.c               |  50 +++++
>  drivers/bus/pci/linux/pci.c             |  48 +++++
>  drivers/bus/pci/linux/pci_init.h        |   9 +
>  drivers/bus/pci/linux/pci_vfio.c        | 272 ++++++++++++++++++++++++
>  drivers/bus/pci/rte_bus_pci.h           | 112 ++++++++++
>  drivers/bus/pci/windows/pci.c           |  50 +++++
>  drivers/net/intel/e1000/base/e1000_hw.h |   2 +
>  drivers/net/intel/e1000/base/e1000_vf.h |   2 +
>  drivers/net/intel/e1000/igb_ethdev.c    | 221 +++++++++++++++++++
>  lib/ethdev/ethdev_driver.h              |  37 ++++
>  lib/ethdev/rte_ethdev.c                 |  40 ++++
>  lib/ethdev/rte_ethdev.h                 |  95 +++++++++
>  15 files changed, 1040 insertions(+)
> 

The longer AI generated review


Subject: [v2 0/4] PCIe TPH and ethdev cache stash - review

Review of "PCIe TPH support" / "generic cache stash" series v2.


Patch 1 - bus/pci: introduce PCIe TPH support
=============================================

Error: pci_vfio_tph_query() extracts the ST Table Size with the wrong
field mask:

	*st_table_sz = RTE_FIELD_GET32(PCI_TPH_LOC_MSIX, cap) + 1;

PCI_TPH_LOC_MSIX is 0x00000400 (bit 10, an ST Table Location bit). Per
PCIe Base Spec, ST Table Size is bits [26:16] of the TPH Requester
Capability Register; Linux defines this as PCI_TPH_CAP_ST_MASK
(0x07FF0000) with shift 16. The current code returns 1 or 2 instead of
the real table size and the result is meaningless. Add the proper
mask/shift, e.g.:

	#define PCI_TPH_CAP_ST_MASK	0x07FF0000
	#define PCI_TPH_CAP_ST_SHIFT	16
	*st_table_sz = ((cap & PCI_TPH_CAP_ST_MASK) >> PCI_TPH_CAP_ST_SHIFT) + 1;

Additionally, per PCIe spec / Linux pci_get_tph_st_num_entries(), the
Size field is only meaningful when the table is located in capability
space. When the ST table is in the MSI-X table, the entry count comes
from the MSI-X table size, not from this field. The branch that returns
the same value for LOC_CAP and LOC_MSIX is incorrect for the MSI-X
case.

Error: pci_vfio_tph_st_get() and pci_vfio_tph_st_set() return raw -1 on
the vfio_dev_fd lookup failure and return the raw ioctl(2) return value
on ioctl error. ioctl() returns -1 with errno set; the function loses
errno and reports -1 to its callers. Return -errno (or a meaningful
-EXXX in the fd case):

	if (vfio_dev_fd < 0)
		return -ENODEV;
	...
	if (ioctl(vfio_dev_fd, VFIO_DEVICE_FEATURE, feature) < 0) {
		ret = -errno;
		free(feature);
		return ret;
	}

Error: kernel/linux/uapi/linux/vfio.h adds VFIO_DEVICE_FEATURE_TPH_ST
= 13 and the surrounding vfio_device_feature_tph_st structure. The
in-tree uapi is synced from a specific upstream kernel
(kernel/linux/uapi/version says v6.16, where the last
VFIO_DEVICE_FEATURE_* is BUS_MASTER = 10). Picking 13 ahead of an
accepted kernel change is risky - upstream may take 11/12/13 for other
features, creating a permanent ABI clash. DPDK uapi headers should only
mirror accepted kernel UAPI; please rebase once the kernel change is
upstream.

Warning: rte_pci_tph_st_set() doxygen uses "@index" rather than
"@param index", and the description "Array of entries with CPU IDs and
index indices to program" reads as a typo. Also rte_pci_tph_disable()
says "negative value on error" while the rest of the new API says
"negative errno value on error" - please make these consistent.


Patch 2 - ethdev: introduce generic cache stash API
===================================================

Error: RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_cache_stash_get, 26.03)
and ..._set use ABI version 26.03. The tree is currently 26.07.0-rc0
(and patch 1 correctly uses 26.07). 26.03 is a past release; new
symbols added in this cycle must use 26.07.

Warning: rte_eth_cache_stash_set() does not validate op against
RTE_ETH_CACHE_STASH_OP_BUTT. An out-of-range op is passed straight to
the driver, where the switch default just returns -ENOTSUP - validate
in the API:

	if (op >= RTE_ETH_CACHE_STASH_OP_BUTT)
		return -EINVAL;

Warning: the API uses the legacy dereference style for dev_ops
function pointers:

	if (*dev->dev_ops->cache_stash_get == NULL)
		return -ENOTSUP;
	return eth_err(port_id, (*dev->dev_ops->cache_stash_get)(dev, capa));

Recent ethdev code uses dev->dev_ops->X == NULL / dev->dev_ops->X(...)
directly; please match.

Warning: RTE_ETH_CACHE_STASH_OP_BUTT is not a typical DPDK
sentinel name; existing code uses _MAX, _LAST or _NB. Same for the
enum: rte_eth_cache_stash_type uses RTE_BIT32(0) values (a bitmask)
while the cap field that consumes it is plain uint32_t supported_types
- either keep the type as a flag enum and store flags in a plain
uint32_t (and rename the enum so it does not read as a value type),
or use #define constants like the RTE_ETH_CACHE_STASH_OBJ_* set.

Warning: the queue-level config carries a single queue_id with a
bitmask of Rx and Tx objects in the same call. There is no way for a
caller to say "stash Rx queue 3" versus "stash Tx queue 3" - they share
the queue_id field. Either split into separate enable ops or document
that OBJ_RX_* targets queue.queue_id as an Rx queue and OBJ_TX_* as a
Tx queue (with the caller required to make two calls for both).

Warning: missing release notes entry for the new public API.


Patch 3 - net/e1000: add cache stash support via TPH
====================================================

Error: supported_objects advertises TX_DESC, TX_HEADER and TX_PAYLOAD,
but eth_igb_cache_stash_queue_enable() only reads/writes
E1000_RXCTL(queue_id) and never touches E1000_TXCTL. If a caller
requests Tx stashing the call silently succeeds and does nothing.
Either implement the TXCTL programming or drop the TX_* bits from
supported_objects.

Error: eth_igb_cache_stash_dev_clear() loops over
max(nb_rx_queues, nb_tx_queues) and writes E1000_RXCTL(i):

	nb_queues = RTE_MAX(dev->data->nb_rx_queues, dev->data->nb_tx_queues);
	for (i = 0; i < nb_queues; i++) {
		...
		reg = E1000_READ_REG(hw, E1000_RXCTL(i));
		...
		E1000_WRITE_REG(hw, E1000_RXCTL(i), reg);
	}

If nb_tx_queues > nb_rx_queues this writes RXCTL entries for indices
beyond the configured Rx queues. Use nb_rx_queues for the RXCTL loop
(and a separate TXCTL loop with nb_tx_queues when Tx is implemented).

Error: eth_igb_cache_stash_queue_enable() and _queue_disable() do not
bounds-check config->queue.queue_id. E1000_RXCTL(queue_id) is just an
arithmetic register offset; a bogus queue_id writes to an arbitrary MMIO
address. Reject queue_id >= dev->data->nb_rx_queues.

Error: config->queue.lcore_id is passed directly to rte_pci_tph_st_get()
without validation. Use rte_lcore_is_enabled() (or at least
config->queue.lcore_id < RTE_MAX_LCORE) before calling.

Error: drivers/net/intel/e1000/base/e1000_hw.h and base/e1000_vf.h are
modified to add "u8 tph_mode". The base/ directory is a snapshot of
Intel's vendor base (see base/README) and DPDK-private state must not
be added there - it will be lost on the next resync. Put the field in
the DPDK-side adapter struct in drivers/net/intel/e1000/e1000_ethdev.h
instead. Also, the patch touches the VF copy of struct e1000_hw but the
implementation only lives in igb_ethdev.c (PF) - the VF addition is
dead state.

Warning: log uses %u for an int errno value:

	PMD_DRV_LOG(ERR, "Failed to get device queue=%u st of cpu=%u ret=%u",
		    queue_id, config->queue.lcore_id, ret);

ret is int and is negative on failure; print with %d.

Warning: magic bit literals in RXCTL programming - RTE_BIT32(0/2/3),
RTE_SHIFT_VAL32(0xFF, 24) - should be named per the I350 register layout
(e.g. E1000_RXCTL_RX_DESC_STASH_EN, _HDR_STASH_EN, _PLD_STASH_EN,
_CPU_STAG_MASK/SHIFT).

Warning: comment "I350 must encoding st in high 8bit, and ST in
config-space is no needed!" - grammar aside, the intent is not clear;
please reword.

Warning: doc/guides/nics/features/igb.ini is not updated for the new
cache-stash capability.

Warning: missing release notes for the new e1000 capability.


Patch 4 - app/testpmd: add TPH stash objects configuration
==========================================================

Warning: start_tph_stash() returns early on the first port that fails
the capability check or DEV_ENABLE, but ports with index < i have
already had DEV_ENABLE applied. Those ports stay enabled with no queue
configuration and will not be disabled on stop until a full
stop_tph_stash() runs. Either roll back already-enabled ports on error,
or skip just the failing port and continue.

Warning: queue-level enable failures in the inner loop only print to
stderr and forwarding proceeds with a partial configuration. Worth at
least returning failure from start_tph_stash() and propagating so
start_packet_forwarding() can refuse to run.

Warning: no entry added to usage() in app/test-pmd/parameters.c for
--tph-stash-objects. Users have no way to discover the option or its
accepted values (rxdesc, rxheader, rxpayload, rxdata, rxall).

Warning: no documentation update (doc/guides/testpmd_app_ug/) covering
the new option.

Warning: user-visible message "don't support tph stash" -> "doesn't
support tph stash" (also in the second fprintf). Minor.

Warning: "lcoreid_t  lc_id;" has a double space; "int i" should be
unsigned to match the portid_t/nb_fwd_ports loop bound type.


General
=======

The kernel-side dependency is the central blocker: until the matching
VFIO_DEVICE_FEATURE_TPH_ST is in an accepted Linux UAPI, the uapi
header import in patch 1 (and by extension all of patch 1's VFIO
ioctl plumbing) is speculative. Please post or reference the upstream
kernel patch so the feature number and structure layout are stable
before this lands in DPDK.
