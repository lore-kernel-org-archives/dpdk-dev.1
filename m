Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CC4CC6B2D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:10:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3A7340615;
	Wed, 14 Oct 2026 19:10:46 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id B7922402A4
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:10:43 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so844318a12.0
 for <dev@dpdk.org>; Wed, 14 Oct 2026 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791997843;
 x=1792602643; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XXADsu8p7ha69l4qnjY2pfvn5y4J3xsON3VlSCpKf34=;
 b=AQ/zrQMyofco2Eaf6fXDQHPUOHN1dTLAcbuPGoUInRe8XqpOL/N1mMY8dvXgQXZg3s
 SvwXwo8AHdjJpEJPxZABEi498aPtS13rC8KhXoPT86vmsuswCTp+IK22UlxZSpggA5iX
 oQxSzmKVcFNSttLbCzE2uCg9CqvI4LvHsVUe7Pzo8OeOV6x/9cOr4bXYErat56fsRQw3
 CttCLUem5tibyl9RLgkmIjQxjJEE+5cxcQt8zmeLYkoUI16WwJXAlPMTAXf9PnpW4BzR
 s/rzw2UKQEHGKqAnbb/9HkbJIPm83qwatlVuEoartKPNs9x7UUHG1NE+Ii7QWT1K1JRV
 7ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997843; x=1792602643;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XXADsu8p7ha69l4qnjY2pfvn5y4J3xsON3VlSCpKf34=;
 b=Kpsfz/GPDAIDPR/03d3zkJth2t6I5J8Y4y5TtCfatimcXl+4r50K+wutN4QaNFQtAf
 SCzek8dhTAUSiTLX6+an8E3GD5INpaJCvRVxGIcRBWrGmCftz6WWr1hQiiqEtAr66bQ9
 Hf004NjYbNC9N9i4dtRg8a8uBfO73tgNLinBzmV3Wu+6vNisAIyq+aRGm/z05EZnOP4E
 2+NidlEcuU6bSfOR5OBhp44WkdI0BHaNUDWNaJni5rVQ4jaqyG1QeHH+Q02dKWAgP31Q
 DIYPdo5g1dtkip/gz52cTGDYnCKMcbhnsrFTXi2/TZWwrU/ka9cZh3HDiFnEozEfseav
 LKgg==
X-Gm-Message-State: AFq9FYJ75fdGLY3CHHE98HeLgdyxcR6Y1+S5uZ5s6KBE7bbEjkf2QJc6
 EZaeNrqLUXSEFV99sa0JDL9w+GDYfxEdZ9jCJvYc4S4up8qG/nCi304Zz3yOjG1C1LA=
X-Gm-Gg: AYBFou2XvGd3mJ+t9XEbfzUFtzGtoqHVex66JkOQNuTtn3GqXqcu+eoUDtppmjIL5hE
 Dji79HrL2SYJo4szwb2xP4F44+U6U4J/iVb+cwijcuZ9o6FZQEop9axZBBJkEtn/1rtYmjNUuzb
 d3DIUclHv1iZ2f1Vt6DLjgfkM5BXWwgVPlf17N4RtX39NPZ9sEuzJALTULyD0GnME+iiFTOYcOO
 jKLv5rEQ/n3CBF/+lTCC2b5ETIaDsfpdaAF7XZpEI/aEx5GSfwJJtnVcY+F1K2xjncJTyySh34u
 op9oO32VXb3OkNaNTjFxTSuQ3eYeA45Uf8MIKhCSzmQqrOmNSOfElcpUzU8LWrzI8/sGgKjkHvb
 UYzzWnBRjXtVJOQjUFPI0Mu65qbK3NCVSLEJHVYGHbJHw8MHQICntFXLXJvDNNLzth3mHibm+ye
 AewRXGSJiN175bvYfPyjCqcAVqQvA7Dk+p0CDRvYzYPa86ii2SL4I5fD4gvwW90zuLmh4eT//Es
 VUYtTeo6RmPjh7XGzBjAT8eXkye7L/fg1NC3dIx
X-Received: by 2002:a17:90b:518f:b0:3a4:b0a1:c7ed with SMTP id
 98e67ed59e1d1-3ab3a90e667mr13613706a91.13.1791997842436; 
 Wed, 14 Oct 2026 10:10:42 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac943e7a98sm302933a91.6.2026.10.14.10.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 10:10:42 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:10:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Cc: dev@dpdk.org, Gaetan Rivet <grive@u256.net>, stable@dpdk.org
Subject: Re: [PATCH v2 0/5] net/failsafe: fixes for sub-device removal and
 configuration
Message-ID: <20261014101037.37385ed9@phoenix.local>
In-Reply-To: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
References: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
 <20261014221604.128677-1-sandeep.penigalapati@intel.com>
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

On Wed, 14 Oct 2026 22:15:59 +0000
Sandeep Penigalapati <sandeep.penigalapati@intel.com> wrote:

> This series collects fixes for the fail-safe PMD found while testing
> live migration of a VF-backed sub-device (iavf) paired with a virtio-net
> standby sub-device.
> 
> - double release of the sub-device port on hot-unplug;
> - NULL queue-release op on sub-devices that do not implement it;
> - MAC address pool size off-by-one and replay of zeroed MAC slots;
> - unsupported link-status control (-ENOTSUP) treated as fatal;
> - sub-device removal not detected without the RMV interrupt (e.g. VFIO
>   device release), now handled through a bus device-event callback.
> 
> v2:
> - patch 2/5: add an explicit ETH(sdev) != NULL check before dereferencing
>   in fs_rx_queue_release()/fs_tx_queue_release().
> - patch 5/5: clarify in a comment that a secondary process detects the
>   removal via the shared sub_device state checked by fs_rx_unsafe()/
>   fs_tx_unsafe() in the burst path.
> 
> 
> Sandeep Penigalapati (5):
>   net/failsafe: fix double release of sub-device port
>   net/failsafe: fix queue release without sub-device op
>   net/failsafe: fix MAC address pool size and replay
>   net/failsafe: ignore unsupported link status update
>   net/failsafe: detect sub-device removal via device event
> 
>  drivers/net/failsafe/failsafe_ether.c   | 40 ++++++++++--
>  drivers/net/failsafe/failsafe_ops.c     | 29 ++++++++-
>  drivers/net/failsafe/failsafe_private.h | 13 ++--
>  drivers/net/failsafe/failsafe_rxtx.c    | 83 +------------------------
>  4 files changed, 67 insertions(+), 98 deletions(-)
> 

More detail semi-automated AI review had some good ideas.

Subject: Re: [PATCH v2 0/5] net/failsafe: hotplug fixes

Series applies to main (eb903f407c) and builds per commit with
-Dwerror=true. Patches 3 and 4 are fine. Comments on 1, 2 and 5.

The most important point is in 5/5: the removal of the safe/fast
burst switching is the real fix for the hot-unplug crash, and it is
mixed with a new feature under the wrong rationale and Fixes tag.


[PATCH v2 1/5] net/failsafe: fix double release of sub-device port

Warning: commit message describes the wrong release path.

For a sub-device in DEV_ACTIVE, the first release is done by
rte_eth_dev_close() (it calls rte_eth_dev_release_port() since
fbd1913561 "ethdev: remove old close behaviour"), not by the bus
remove. The bus remove path only owns release when the sub-device was
DEV_PROBED and never configured. The code change is correct for both.

Also say what actually happens: since 36c46e7381 the first release
sets eth_dev->data = NULL, so the second release dereferences NULL in
eth_dev_fp_ops_reset(rte_eth_fp_ops + eth_dev->data->port_id) and
decrements allocated_ports twice.

Suggested body:

  The sub-device port is already released before fs_dev_remove()
  calls rte_eth_dev_release_port(): by rte_eth_dev_close() for an
  active sub-device, or by the driver remove in rte_dev_remove()
  for a probed one. The second release dereferences the NULL
  eth_dev->data and crashes.

  Remove the redundant call.

With the else branch gone the remaining braces can go too:

	if (ret < 0)
		ERROR("Bus detach failed for sub_device %u",
		      SUB_ID(sdev));


[PATCH v2 2/5] net/failsafe: fix queue release without sub-device op

Warning: wrong Fixes tag. The unconditional SUBOPS() call is in the
original driver; 7483341ae553 only changed the callback signature.

  Fixes: a46f8d584eb8 ("net/failsafe: add fail-safe PMD")

Info: the v2 ETH(sdev) != NULL test is dead code. sdev_port_id is
set at probe and only reset to RTE_MAX_ETHPORTS in fs_dev_remove()
on the way to DEV_UNDEFINED, so ETH(sdev) is never NULL for a
DEV_ACTIVE sub-device. The other FOREACH_SUBDEV_STATE(..., DEV_ACTIVE)
loops in this file do not check it either. Drop it.


[PATCH v2 5/5] net/failsafe: detect sub-device removal via device event

Warning: two unrelated changes with different stable status; split.

(a) Dropping failsafe_set_burst_fn() and the _fast variants is the
actual crash fix, and the commit message gets the reason wrong. It is
not "no longer needed because removal is now reported reliably". Since
c87d435a4d79 ("ethdev: copy fast-path API into separate structure"),
rte_eth_dev_start() copies dev->rx_pkt_burst/tx_pkt_burst into
rte_eth_fp_ops after dev_ops->dev_start returns. fs_dev_start() ->
fs_switch_dev() -> failsafe_set_burst_fn(dev, 0) installs the _fast
variants, which then get copied. The later switch to the safe
variants in failsafe_eth_rmv_event_callback() only writes
dev->rx_pkt_burst, which the data path no longer reads. So after any
removal, RMV interrupt or not, the application keeps calling
failsafe_rx_burst_fast(), which skips fs_rx_unsafe() and dereferences
ETH(sdev) == NULL once the sub-device is gone.

This part should be its own patch:

  net/failsafe: fix Rx/Tx burst after sub-device removal

  Since burst functions are copied into rte_eth_fp_ops at start,
  replacing dev->rx_pkt_burst/tx_pkt_burst afterwards has no
  effect. The fast variants installed at start stay in use after
  a sub-device is removed and dereference the removed device.

  Remove the fast variants and always use the checked burst path.

  Fixes: c87d435a4d79 ("ethdev: copy fast-path API into separate structure")
  Cc: stable@dpdk.org

(b) Registering a bus device-event callback for sub-devices without
RMV interrupt is new functionality. It cannot fix a46f8d584eb8; the
rte_dev_event API did not exist when fail-safe was added. No Fixes:,
no Cc: stable.

Info: the device event is raised automatically only for VFIO (via
the req notifier). For UIO sub-devices it comes from the uevent
monitor, which the application must start with
rte_dev_event_monitor_start() and rte_dev_hotplug_handle_enable().
Worth one line in the commit message or in fail_safe.rst.

Info: failsafe_dev_event_callback() can call the RMV callback with 0
as port_id; the argument is __rte_unused and PORT_ID() plus the cast
only adds noise:

	if (type == RTE_DEV_EVENT_REMOVE)
		failsafe_eth_rmv_event_callback(0, RTE_ETH_EVENT_INTR_RMV,
						cb_arg, NULL);
