Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A320C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 02:00:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D15E40298;
	Thu, 13 Aug 2026 04:00:45 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id BC1374026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 04:00:43 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3811f512167so2092615a91.3
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786586442;
 x=1787191242; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BlF/yriVl19i5mWf3LOnsrrI4ZxLjKHc1WsnYmxCevk=;
 b=hV+duGTxGaYgQb1DJmLZfn8A/Fd+M2qgZltUzap8Tc3iNhNwIIwa8lJN4o694JH03p
 2z+PTY6/6rZsLY1amOIBLnXfVK/kT8uA1DDHq+3aRQZBW8t0BT9fyIF5rc2eJ9EPTqDB
 UCeEGG5lWEFZn+2VEonFMGE+qV5+Cpe4bEMzYkgGq9jO7im0weYrUnnXUMrxyO0Wqc1y
 dQKYEVeDNRzjmsTWS21jxHsLxVnezZEeWUFpSCptjBfUZCKICxjey8oM/raBRPvQ/3o+
 /XWRMh2kDQobQs22Ypzk6yHGLPtTycxHVq7BbBtJiO59GkaZqqUrRyIBsAE/V74OAoBn
 kkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786586442; x=1787191242;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BlF/yriVl19i5mWf3LOnsrrI4ZxLjKHc1WsnYmxCevk=;
 b=LeD5IKcEcy1AST6bPj9ivR4oFTe1+clx1vfd2WhNsl3iGzgLpYeq7PZw9fnWmVzdTQ
 iLao2IYt+UlJzN8bZay2dRdjjMtCjrE12GT/v2N3SqCoWAJwWX3gQiqjvrn/PnPOu9gz
 sWiwxGATDXMnFyMwgybO8H5L4HsIgOZvv6JlPicSeA9wiekGBV6Vby1iVbjD3/Ui+L2l
 APzT7VzIK5tmVrv9J1ugPMQl1eRQO8B4EJUgfZMYtwcrIG2BVADVw9I9jdPtPyECkOaY
 9E03jDOYu591xclsOLcAoJR92492W0Lv0QQHgmydYWjsAbnrKqxxLB6INjSeWIUhWkv+
 YZAA==
X-Gm-Message-State: AOJu0YxT3rTFPPVN2MkuPk/hLH6Mno3dS5V3GSZp3jB9kCmgIH+DtjKA
 p3zaNDiWnViSsKIHdwkJ9dCtFKeqO6BByWRRWvpUHxezo3c9fwgoENvHgPrvQPEj40E=
X-Gm-Gg: AR+sD12bik/3a7zZyOtrd8/kiZ1HPCF+4BVmYOGadHQcyTgcWSL+2YolIZnv52mjWpO
 UEa4epE3qk/lFRDxIxOSvLtZdXDs836vFYGzFrS6Oyy/xPfgK/7crn2CVmJIfxn7t93Uq0fuK3W
 9rttYWPXjzot64NFL1L7JQIgU3p7y/C4U6lZFhA15lMdZNyE/2zc+Ps7Ga//h/2onEl7ICpXJ1b
 8i+ekpXMc/reWR000VU/IvU8uwIwWlKm3rmzEz0H7mqfxI1ue6ri3isdVXU7NcNVObmd8t/Brpn
 1sEROEfVH5MlHi7URMfHo2EodiGUM5q860vahxHQTujaXpqsOPuIqyv4kWkPjAmK6VYYtl/xbTz
 tl3m3RcQOVb2O9ygJb9lCtSh0h1HzmsvNeZKx/sLjNsWc1u7VXOMYnrepZGQLXNUfweHQm1AQow
 /GzHIHSNhTD6LcUItPRdTFoao4uEKWN6MP0VyPXGrZHiJSgatWbHCsPmNS98OV/br2R/u0h5rp7
 rg6LQjqwsd8f3DO3iz47lfbOZPtiA==
X-Received: by 2002:a17:90b:264d:b0:38e:6d4c:14e6 with SMTP id
 98e67ed59e1d1-3931dffbf64mr3196865a91.3.1786586442421; 
 Wed, 12 Aug 2026 19:00:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebcb6a97asm1807125eec.7.2026.08.12.19.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 19:00:42 -0700 (PDT)
Date: Wed, 12 Aug 2026 19:00:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v8 00/14] net/enetc: add new features for ENETC4 on i.MX95
Message-ID: <20260812190033.707fd480@phoenix.local>
In-Reply-To: <20260812113317.693144-1-g.singh@nxp.com>
References: <20260811074745.3655334-1-g.singh@nxp.com>
 <20260812113317.693144-1-g.singh@nxp.com>
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

On Wed, 12 Aug 2026 17:03:03 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V8-changes:
>  - Fixed Warning RBMR RMW races between threads by adding lock
>  - Fixed `static const` arrays in `enetc.h`
>  - Proper pthread_mutexattr_t intialization added as suggested by AI
>  - VSIMSGSR stale re-read race is eliminated
> 
> V7-changes:
>  - added missing 14th patch.
> 
> V6-changes:
>  - fixed free() on memory allocated with rte_zmalloc().
>  - fixed eventfd and vector-list leak on interrupt teardown
>  - fixed Rx ring doubling still bypasses
>  - fixed VSI-PSI transaction issued from the interrupt handler
>  - fixed the free-and-reallocate of msg is unnecessary churn
>  - fixed unsynchronized access to tx_pause_active and RBMR
>  - fixed signed shift overflow in the register-dump version field
>  - fixed the fw_size == 0 early return reports the length of "0.0"
>  - unwanted blank lines removed.
>  - parse_txq_prior() returns updated.
> 
> V5-changes:
>  - Patch 1 Build fixes which includes:
>     'prev_seg' undeclared fixed.
>     redefinition of 'dev_rx_offloads_sup' fixed.
>     Error: duplicate rx_enable declaration fixed.
>    PF loses Scattered Rx and Multi-segment Tx
>  - mbuf leak in enetc_xmit_pkts_lso() fixed.
>  - fixed conversion on ENETC4_TXBD_FLAGS_F issue.
>  - fixed link speed decode has no upper bound.
>  - fixed mailbox ops added to the no-VSI ops table.
>  - new devargs documented.
> 
> V4-changes:
>  - fix doc build issue: WARNING: undefined label: pmd_build_and_test
> 
> v3-changes:
>  - fix doc build issue.
>  - fix compilation issue on fedore:43-gcc-minsize
> 
> V2-changes:
>  - compilation fixes.
> 
> V1-changes:
> This series adds new PMD features to the ENETC4 driver targeting the
> NXP i.MX95 NETC IP.
> 
> The series covers:
> 
>  - KEEP_CRC Rx offload: preserve the Ethernet FCS in the receive buffer.
>  - TSO: TCP Segmentation Offload for the VF Tx path.
>  - RSC/LRO: hardware Receive Segment Coalesce for PF and VF Rx paths.
>  - Link speed code: extend the PF-to-VF mailbox field from 4-bit to
>    8-bit to support speeds beyond 10G.
>  - Firmware version: report the NETC IP version via fw_version_get.
>  - Register dump: dump SI, port (PF) and BD ring registers.
>  - Ring parameters: implement rxq_info_get / txq_info_get for the VF.
>  - Link-up interrupt: refresh the cached link speed on each VF link-up
>    interrupt so that link_update returns the current speed immediately.
>  - Stats reset: software snapshot/delta approach for VF counter reset.
>  - Per-queue Rx interrupt: MSI-X per-queue Rx interrupts for the VF,
>    enabling interrupt-driven receive with l3fwd-power.
>  - SI VLAN: hardware port VLAN insertion/removal for PF and VF.
>  - VF link status bitmask: switch VF link status to bitmask encoding
>    to align with the PF and newer kernel driver conventions.
>  - TX PAUSE: VF sets Rx congestion mode when the PF signals TX PAUSE
>    negotiated on the wire; adds Flow control = Y to enetc4.ini.
>  - WRR Tx scheduler: per-ring WRR weights via enetc4_txq_wrr devarg.
> 
> Gagandeep Singh (14):
>   net/enetc: add keep-CRC Rx offload for ENETC4
>   net/enetc: add TSO support for ENETC4 VF
>   net/enetc: add RSC (hardware LRO) support for ENETC4
>   net/enetc: extend PF-VF link speed field to 8 bits
>   net/enetc: support firmware version get for VF
>   net/enetc: support registers dump
>   net/enetc: support ethtool ring parameters
>   net/enetc: refresh link speed on VF link-up interrupt
>   net/enetc: support stats reset for VF
>   net/enetc4: add per-queue Rx interrupt support for VF
>   net/enetc4: add SI-based port VLAN insertion and removal
>   net/enetc4: update VF link status to bitmask encoding
>   net/enetc4: enable Tx PAUSE via VF Rx congestion mode
>   net/enetc4: add WRR Tx scheduler devarg for VF rings
> 
>  doc/guides/nics/enetc4.rst             | 100 +++
>  doc/guides/nics/features/enetc4.ini    |   8 +
>  doc/guides/rel_notes/release_26_11.rst |  21 +
>  drivers/net/enetc/base/enetc4_hw.h     | 128 +++-
>  drivers/net/enetc/base/enetc_hw.h      |   6 +
>  drivers/net/enetc/enetc.h              | 132 +++-
>  drivers/net/enetc/enetc4_ethdev.c      | 454 +++++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 860 +++++++++++++++++++++----
>  drivers/net/enetc/enetc_rxtx.c         | 530 ++++++++++++++-
>  9 files changed, 2062 insertions(+), 177 deletions(-)
> 

AI review still discovered some things.
ENETC4 v8 series review - 14 patches

No Reviewed-by; two errors remain.

Fixed from v7: vsi_lock now uses PTHREAD_PROCESS_SHARED;
enetc4_msg_vsi_send() returns the latched VSIMSGSR via out-parameter and
all call sites parse from it instead of re-reading after the unlock;
RBMR read-modify-write serialized under vsi_lock in
set_congestion_mode(), rx_queue_setup(), rx_queue_start() and
rx_queue_stop() (VF only, PF correctly skips); tx_pause_active dropped
to relaxed with the comment updated; the BDR register arrays moved out
of the header into enetc4_ethdev.c with extern declarations.

I checked for lock-ordering problems from the new RBMR locking.
set_congestion_mode() releases vsi_lock before the subsequent
get_link_speed() reacquires it, so no recursive acquisition.


Errors

Patch 11 - VF vlan_pvid_set fails on every successful command.
The reply check compares reply_msg->class_id against
ENETC_MSG_CLASS_ID_CMD_SUCCESS (0x1), but class_id carries the command
class from VSIMSGSR[15:8], which for this command is
ENETC_CLASS_ID_SI_VLAN_ISO (0x24).  Never equal, so the function returns
-EINVAL even when the PSI accepted the command.  enetc4_msg_vsi_send()
already validated the class; every other mailbox op matches the class
first and then switches on status.

Patch 09 - VF stats_reset baseline underflows on counter wrap.
SIROCT0/SIRFRM0/SITOCT0/SITFRM0 are 64-bit counters on 8-byte stride,
but enetc4_rd() is rte_read32(), so only the low word is read.  The new
delta stores that in a uint64_t baseline and subtracts, so once the low
word wraps the result is ~1.8e19 instead of a small wrapped value.  At
10G a 32-bit octet counter wraps in about three seconds.  Either read
the full 64-bit counter, or mask the delta to 32 bits.  SITDFCR is a
genuine 32-bit register and only needs the mask.


Warnings

Patch 13 - "Flow control = Y" added to enetc4.ini with no implementing
ops.  features.rst requires flow_ctrl_get/flow_ctrl_set; none of the
three ops tables provide them, so rte_eth_dev_flow_ctrl_set() returns
-ENOTSUP.  The congestion mode this patch adds is driven by PF link
state and is not reachable through the flow-control API.  The other new
entries (Rx interrupt, LRO, TSO, FW version, Registers dump, CRC
offload) all check out.

Patch 08 - no primary-process guard in enetc4_vf_dev_init().
rte_eth_dev_pci_generic_probe() calls dev_init in secondaries too, and
the secondary attaches to the primary's dev_private.  A secondary
re-runs pthread_mutex_init() on a mutex the primary may hold, which is
undefined behaviour; PROCESS_SHARED makes cross-process locking valid
but not double initialization.  The same path re-runs dev_hw_init() and
the devarg parsing, overwriting the primary's txq_prior/txq_wrr
pointers.  An early return for RTE_PROC_SECONDARY in both the VF and PF
dev_init covers it.


Info

Patch 12 - the pre-existing reply_msg leak on the "Wrong reply message"
path sits in the if/else this patch rewrites; cheap to fold in.

Patch 10 - "ret = 0;" in the efd_enable failure branch is a dead store,
overwritten by the following rte_intr_enable().
rte_intr_callback_unregister() can return -EAGAIN; the return value is
discarded on teardown.

Series-wide - six functions declare int vsimsgsr_* mid-body after a
block of top-of-function declarations, and enetc4_vf_dev_init()
declares pthread_mutexattr_t attr after several statements.  C99 mixing
is allowed, but each of these functions is otherwise declarations-first.
