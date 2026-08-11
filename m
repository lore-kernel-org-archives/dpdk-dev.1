Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C925C5AC67
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 20:24:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73FD640E3F;
	Tue, 11 Aug 2026 22:24:38 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 541584025F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 22:24:37 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cee9b74ee1so2963645ad.3
 for <dev@dpdk.org>; Tue, 11 Aug 2026 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786479876;
 x=1787084676; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JmIb3Ilo6Zh16GPUw9lzks8nKeElzMasvGo25B1npdo=;
 b=jo97OZ4NCfP40V7qtYCTsfjM6DOkq3EurLdJ2BKY6VYvdJ3PExReIQ4ASWE+WtsqwT
 wRtA/OHLt68WeYA4v014IWOSB2DFS5CL0IYjVTRjDWProvT3HISGl7L8GxXNgAKqp6zv
 i9QtOQqLUO213YYU1QrquxGchlY6AaVk3nipkC2hNsl5p9R5IO/hEN6EPkYYjPRoF4hC
 erGm/XioZ6gUEmNUFge+mOhPQjFWhC/X3hy2WO1/CXe2Gc1FJgi1BAZGIn0f4dHEEbSD
 frblg0GiKLEMOPC3UAzvy6PUMWF1fUgoZEgXj5cmDb3QUUStQ1wFasTvjnIMKB+GZRzK
 oYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786479876; x=1787084676;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JmIb3Ilo6Zh16GPUw9lzks8nKeElzMasvGo25B1npdo=;
 b=gjCf44WKyuks4bHGiBqxvfK8lQydaSWT7ysn577uCof3YssCTwRRXukSX1R3GNqEaq
 8S1IaZxbFInElvtZ0gPyj7D7SSqnGljnyqzqLDtoXK0pVSSa1BGbYkog3ocJJf/AehwI
 Ju6EnH+U0sjLGQ7PNtwOpmFuEzplWnUR0LAR9oVHTiznRWlILgGXYWwuBdB7m5dp1Gew
 UJxwunJPsVr8UV/ypK3JGbJSnIkMBFEBUA0Gq2UAA5fenNYlotjZlHioFN58UJOhGcN+
 BvgxFgehmz/qh0IbY/oflcYJeAkfmC4L0RbGANcH9cUJBnJCsmH5qe5+lOTXK3PaRKPa
 w/Xw==
X-Gm-Message-State: AOJu0YzHGwtivhcX/lEE6B+E8hkgJ74JtAUaWGEaem6cUKA0IxDAdvIc
 okAANtWU3xzLiDAoxJwLJfI1AdaBpYHYdYWO4876EWDwXoSf1ohiM9WqbEdcz8xOLhI2Ln8j1Al
 5CWcA
X-Gm-Gg: AR+sD13G0IU3yPTIHdCC3jxdRPRxynLAXkGvVY2gCBSWFvurFgS1XmmhgQoTsmXeUVg
 6WgD8UImAhmCIW/Mrt+meX6v6mOnzTCIW19pKXrEE7IWgp8kC26XkIJDkdTW/vQDQg5xC2NuJlY
 +21d9A6MgD1q/W8KIWODHMhU76HxHXIqTHOieVr2vDxZxXpBYubbscxg9OAAjyU1yhBiukd/YUP
 tvqFWiA/UzhSKzAY4wwGgjWE0Gneoi/P6fd24PK+uh7MlCM7/0+PqI8tfX5lai7tVaonYFGTw1x
 KQ6TDgvLSBthAE3IMJ8zZNHztKo09LdxTTSMozFyBsgDREEdri0rkyf5JHqGCGOtGMVXi63yMfj
 x/yBB4bBK+GFc1gbu1e5ttXyKL4d709vpKvnE7YMkeq41RItnaOtIWpufnkN6+HcviJxBkPnvmG
 vdI0LiieKAAfaXBZOwj8c1dmhOyq73l910l12MIM9oQT1eXIPJgJ2I+XntMX4+aBnvf7c+70rWQ
 LaHmANrKZmTya3pnYZ6dgt6LA7H/Q==
X-Received: by 2002:a05:6a20:2d13:b0:3c4:1916:9d46 with SMTP id
 adf61e73a8af0-3cc2bac42a9mr7902853637.27.1786479876388; 
 Tue, 11 Aug 2026 13:24:36 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14124454d3csm2446852c88.2.2026.08.11.13.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 13:24:36 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:24:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, Viacheslav
 Galaktionov <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 0/3] net/sfc: miscellaneous bug fixes
Message-ID: <20260811132433.6f4551f2@phoenix.local>
In-Reply-To: <20260811174913.8961-1-ivan.malov@arknetworks.am>
References: <20260811174913.8961-1-ivan.malov@arknetworks.am>
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

On Tue, 11 Aug 2026 21:49:10 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Three independent fixes. The first ensures that Rx queue
> type flags are derived from scratch on every queue setup,
> preventing flags from a prior configuration persisting
> when an offload is disabled.
> 
> The second patch removes an erroneous static qualifier
> from a flow RSS iterator variable, which incorrectly
> shared state between multiple interfaces.
> 
> The third patch corrects reading of the advertised
> autoneg capability. When the user disables it, the
> corresponding bit was re-added upon the next
> link-state query.
> 
> Ivan Malov (3):
>   net/sfc: set Rx queue type flags from scratch on queue setup
>   net/sfc: drop wrong static qualifier from iterator variable
>   common/sfc_efx/base: fix reading advertised autoneg ability
> 
>  drivers/common/sfc_efx/base/efx_np.c       | 11 +++++------
>  drivers/common/sfc_efx/base/medford4_phy.c |  6 +++++-
>  drivers/net/sfc/sfc_flow_rss.c             |  2 +-
>  drivers/net/sfc/sfc_rx.c                   |  2 +-
>  4 files changed, 12 insertions(+), 9 deletions(-)
> 

Detailed AI review found some issues here.

Review of [PATCH 0/3] SFC bug fixes (Ivan Malov)

Patch 1/3 - net/sfc: set Rx queue type flags from scratch on queue setup

  Error: replacing "|=" with "=" discards extra type flags that callers
  seed via sfc_rx_qinit_info() immediately before sfc_rx_qinit().

  Two call sites do this today:

    drivers/net/sfc/sfc_repr_proxy.c:556
        sfc_rx_qinit_info(sa, rxq->sw_index, EFX_RXQ_FLAG_INGRESS_MPORT);
        sfc_rx_qinit(sa, rxq->sw_index, ...);      /* line 562 */

    drivers/net/sfc/sfc_mae_counter.c:870
        sfc_rx_qinit_info(sa, sa->counter_rxq.sw_index,
                          EFX_RXQ_FLAG_USER_MARK);
        sfc_rx_qinit(sa, sa->counter_rxq.sw_index, ...);  /* line 875 */

  sfc_rx_qinit_info() does "rxq_info->type_flags = extra_efx_type_flags"
  (sfc_rx.c:1663).  The "|=" at sfc_rx.c:1186 was what preserved that
  value; with "=" it is overwritten before anything reads it.

  Two consequences:

    - rxq_info->type_flags is passed straight to efx_rx_qcreate()
      (sfc_rx.c:822 and :842), so the hardware Rx prefix no longer
      carries ingress mport / user mark for those queues.

    - sfc_rx.c:1240 derives SFC_RXQ_FLAG_INGRESS_MPORT from type_flags,
      and sfc_ef100_rx.c:824 consumes it.  Representor proxy demux
      loses its mport field.

  EFX_RXQ_FLAG_USER_MARK is re-added at sfc_rx.c:1203, but only when
  RTE_ETH_RX_METADATA_USER_MARK was negotiated or flow tunnel is active
  - neither holds for the MAE counter queue.

  The underlying problem the patch describes is real: sfc_rx_configure()
  only calls sfc_rx_qinit_info() for newly added queues (sfc_rx.c:1837,
  inside "while (sas->ethdev_rxq_count < nb_rx_queues)"), so existing
  ethdev queues keep stale flags across a reconfigure.  The fix needs to
  reset only the offload-derived bits.  Suggested approach: record the
  caller-supplied flags in a separate field, e.g.

      /* sfc_rx_qinit_info() */
      rxq_info->extra_type_flags = extra_efx_type_flags;
      rxq_info->type_flags = extra_efx_type_flags;

      /* sfc_rx_qinit() */
      rxq_info->type_flags = rxq_info->extra_type_flags |
              ((offloads & RTE_ETH_RX_OFFLOAD_SCATTER) ?
               EFX_RXQ_FLAG_SCATTER : EFX_RXQ_FLAG_NONE);


Patch 2/3 - net/sfc: drop wrong static qualifier from iterator variable

  Info: the change is correct, but the commit message overstates the
  impact.  TAILQ_FOREACH() assigns the variable from TAILQ_FIRST()
  before the first iteration, and every return path returns a value
  produced inside the loop, so the static storage is never read stale.
  There is no observable misbehaviour to backport a fix for.  Consider
  rewording as a cleanup (unnecessary global state, not thread-safe by
  construction) and dropping the Cc: stable and Fixes: tags, or state
  explicitly that no functional change is expected.


Patch 3/3 - common/sfc_efx/base: fix reading advertised autoneg ability

  Error: the first efx_np.c hunk does not apply to main.  The patch
  expects the block

      if (lsp->enls_an_supported != B_FALSE)
              lsp->enls_adv_cap_mask |= 1U << EFX_PHY_CAP_AN;

  to sit after the LINK_STATE_OUT_ADVERTISED_ABILITIES conversion, but
  upstream has it before it (efx_np.c:432), and at the position the
  patch expects upstream has

      if (status_flags & (1U << MC_CMD_LINK_STATUS_FLAGS_AN_ABLE))
              lsp->enls_lp_cap_mask |= 1U << EFX_PHY_CAP_AN;

  from 70857163b72a ("common/sfc_efx/base: fix autoneg detection with
  netport MCDI").  git am and git apply -3 both fail on that hunk; the
  efx_np_attach() hunk and medford4_phy.c apply cleanly.  Please rebase
  on main and resend.

  The logic itself checks out on the rebased placement.  Removing the
  AN bit from enls_adv_cap_mask leaves only two consumers, and both are
  covered: efx_np_attach() (efx_np.c:1005) now sets the bit itself, and
  medford4_phy_get_link() (medford4_phy.c:43) restores it from
  ep_adv_cap_mask.  medford4_mac_poll() writes the result back into
  ep_adv_cap_mask, so the bit is self-sustaining, and clearing it via
  efx_phy_adv_cap_set() sticks.  Setting it back is gated on
  ep_phy_cap_mask (efx_phy.c:264), which attach only populates when
  AN is supported, so the preserved bit cannot outlive AN support.

  Info: the added local

      const efx_port_t *port = &enp->en_port;

  is used once and the file otherwise reaches through enp->en_port
  directly (line 33) or names the local "epp" (medford4_phy_reconfigure,
  medford4_mac_poll).  Suggest dropping it:

      preserve_an = enp->en_port.ep_adv_cap_mask &
                    (1U << EFX_PHY_CAP_AN);


Fixes: tags in all three patches resolve to real commits with matching
subjects.
