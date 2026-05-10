Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F75CD3447
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 15:04:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C94E40272;
	Sun, 10 May 2026 17:04:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A30CB40270
 for <dev@dpdk.org>; Sun, 10 May 2026 17:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778425451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pGgwxueozESERci/r+85NONbnHJ9p1HzN2aCUeyE7I=;
 b=Iab+ihyUx7UGE9BgEVLd/4hGTa485ApKIHI4WJDgAO9EzwOWg5pxNCKKX4d3LZemdCfwd7
 pqe1wIoVY05xRFjPahSBGjloxlkh/gsJeX5vUGVJWEbt8+37JgUykehVg01v5dgJ0YCJnf
 tMuvEk15AvexHEAZ67hwPpSmPd0c8h8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-83JMyGd2PYmWDS41_eyMWg-1; Sun, 10 May 2026 11:04:10 -0400
X-MC-Unique: 83JMyGd2PYmWDS41_eyMWg-1
X-Mimecast-MFC-AGG-ID: 83JMyGd2PYmWDS41_eyMWg_1778425449
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a898609ca2so1826024e87.3
 for <dev@dpdk.org>; Sun, 10 May 2026 08:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778425448; x=1779030248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pGgwxueozESERci/r+85NONbnHJ9p1HzN2aCUeyE7I=;
 b=dtb9An0e1Aj4TUzYIOzODVlzC8ByRn+AGn7kqoCWuL6SD2U1eBatRlp+PiWh6dkSiY
 NuWJ3AAy9zHXLFdxKCF+lrok9QJLnQFheUvnWqfArhOSgX0kbEwGW1S2xOim09JK8+OC
 CeoXUZXAJA6ONrWrVeK0DXc8KcV99/Vcli3rVzvDnXUQWQmaQVEaC8Ha3nSb9HWsa3cm
 1xAqDp9gFk6/q6uq1W6UABAb3a4cGbQ6icB/z8MKbGvYrnE9gCKzmoezT8b9QvHZBywx
 goRGS5rgOSZsO50pvD2vq0KwF1maqQJcWvgl7/cSGRTzYTdu5JHNN+peh43AMvd1cXP3
 ji4A==
X-Gm-Message-State: AOJu0Yw0AeAfsa93PIRPc+Hoz5ByJjwWwNx7OdwgaxuzR9DKxxN3bO8g
 g3SawovVqE0v943PZtnTaAemF7Wz98D8I1ijX7Ld+RW1CoT3RhvU8obFvkRO1Lfo5IyVJDP1n9t
 d4PtUEvkngpzrEOg5fUd1t+ZWTiQJfcDSzyn1LM3M7vld5HFuRX29EAvYLp2DmOrlcSpRk5Iv+h
 5TRZNYQMvhf0EMeiOlhyfuFdZ7PPs=
X-Gm-Gg: Acq92OES5JLlLgsEET4dgn3dY1xicQRETTW1ihxm+NXuisZdS9JqxrF6vEPuHq7n+2L
 ACoew0nvVXVfyF/4M7yFsT+fDo5WirzQfLeQmt3ri0wm5HBCJBjbqwsja+j1KiKgj0yczXkVm7U
 djAuJMYMCDb11OxoMyXLd+ylVLD9Q1u+W1CjR1gwc9EWfOiHbHdodmrCLXkX7VJ6UFKYc2cE9I0
 GnkVq9+TrleHTFJgysH6NZTQhRKfbHkWFM1CXx86Q88In8m6lfWLmJaDAR4AamZ/k6fvA==
X-Received: by 2002:a05:6512:3a81:b0:5a8:65ce:e832 with SMTP id
 2adb3069b0e04-5a887ceb5ddmr6763745e87.36.1778425448569; 
 Sun, 10 May 2026 08:04:08 -0700 (PDT)
X-Received: by 2002:a05:6512:3a81:b0:5a8:65ce:e832 with SMTP id
 2adb3069b0e04-5a887ceb5ddmr6763740e87.36.1778425447913; Sun, 10 May 2026
 08:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260506123554.2524136-1-david.marchand@redhat.com>
 <20260506195128.68d47ed2@phoenix.local>
In-Reply-To: <20260506195128.68d47ed2@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Sun, 10 May 2026 17:03:56 +0200
X-Gm-Features: AVHnY4JtUD6JFuqr7T8_ZU_RJQFzIn6qjXqosGSYYgSiFpIDRX-vIvtp4QXtYuQ
Message-ID: <CAJFAV8z0Tqf0XXnes7mGMwN6wOj6aByhvmy_L1gPHjjGvNY=vw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Remove limitations coming from legacy VMDq
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wham7-D6LyPFCudbRt2xhUWjIsG5OknUti0zRs6u7Cs_1778425449
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello Stephen,

On Thu, 7 May 2026 at 04:51, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed,  6 May 2026 14:35:48 +0200
> David Marchand <david.marchand@redhat.com> wrote:
>
> > Since the commit 88ac4396ad29 ("ethdev: add VMDq support"),
> > VMDq has been imposing a maximum number of mac addresses in the
> > mac_addr_add/del API.
> >
> > Nowadays, new Intel drivers do not support the feature and few other
> > drivers implement this feature.
> >
> > This series proposes to flag drivers that support the feature, and
> > remove the limit of number of mac addresses for others.
> >
> > Next step could be to remove the VMDq pool notion from the generic API.
> > However I have some concern about this, as changing the quite stable
> > mac_addr_add/del API now seems a lot of noise for not much benefit.
> >
>
>
> AI review (manual not automated) saw these:
>
> On Wed,  6 May 2026 14:35:49 +0200
> David Marchand <david.marchand@redhat.com> wrote:
>
> [PATCH v2 1/5] ethdev: skip VMDq pools unless configured
> --------------------------------------------------------
>
> Warning: duplicate-add no longer returns 0 in non-VMDq mode
>
>    } else if (vmdq) {
>            pool_mask = dev->data->mac_pool_sel[index];
>            /* Check if both MAC address and pool is already there, and do nothing */
>            if (pool_mask & RTE_BIT64(pool))
>                    return 0;
>    }
>
>    When index >= 0 (MAC already present) and VMDq is not configured,
>    the early "already there" return that existed before is now skipped
>    entirely. The driver's mac_addr_add op gets re-invoked and
>    mac_pool_sel is no longer updated for !vmdq, so subsequent calls
>    keep re-invoking it. Pre-patch behaviour was idempotent (return 0).
>
>    Suggested fix:
>
>    } else if (vmdq) {
>            pool_mask = dev->data->mac_pool_sel[index];
>            if (pool_mask & RTE_BIT64(pool))
>                    return 0;
>    } else {
>            return 0;       /* MAC already installed, only one pool */
>    }

Yes, good catch.


>
>
> [PATCH v2 2/5] ethdev: announce VMDq capability
> -----------------------------------------------
>
> Warning: capability advertised even when max_vmdq_pools may be 0
>
>    The capability bit is set unconditionally in several drivers where
>    VMDq availability is conditional on hardware variant or runtime
>    configuration:
>
>      - net/intel/e1000/igb_ethdev.c: max_vmdq_pools = 0 for e1000_82575,
>        e1000_i354 (no setting), e1000_i210, e1000_i211.
>      - net/intel/i40e/i40e_ethdev.c: max_vmdq_pools is gated on
>        (pf->flags & I40E_FLAG_VMDQ).
>      - net/bnxt/bnxt_ethdev.c: max_vmdq_pools is set to 0 when there
>        are not enough resources (see "Not enough resources to support
>        VMDq" path).
>
>    With this patch a user can pass mq_mode |= RTE_ETH_MQ_RX_VMDQ_FLAG
>    through rte_eth_dev_configure() because the new capability check
>    passes, but the driver has no pools to honour the request.
>
>    Suggested fix: gate the capa bit on max_vmdq_pools > 0, or set it
>    per-MAC-type / per-flag in each driver.

I realise now that this new device capability would also break VMDQ
with failsafe on top of VMDQ-capable ports.
In the end, as suggested here, max_vmdq_pools is already a gate and no
new capability is needed.


>
> Warning: VMDq capability advertised on VFs that do not configure VMDq
>
>    ixgbevf_dev_info_get() and txgbevf_dev_info_get() now advertise
>    RTE_ETH_DEV_CAPA_VMDQ, but ixgbevf_dev_configure() and
>    txgbevf_dev_configure() only handle RTE_ETH_MQ_RX_RSS_FLAG. The
>    feature matrices doc/guides/nics/features/ixgbe_vf.ini and
>    txgbe_vf.ini do not list "VMDq = Y". A VF is itself a member of a
>    PF VMDq pool; advertising the capa from the VF is misleading.
>
> Warning: ipn3ke advertises VMDq=Y in its features file but is not
>    updated by the patch
>
>    doc/guides/nics/features/ipn3ke.ini has "VMDq = Y" but the patch
>    does not add RTE_ETH_DEV_CAPA_VMDQ to ipn3ke. Either update the
>    driver or correct the feature matrix.
>
> Warning: missing release note
>
>    The new RTE_ETH_DEV_CAPA_VMDQ public bit and the new rejection in
>    rte_eth_dev_configure() (returning -EINVAL when an application sets
>    a VMDq mq_mode on a non-VMDq device) are user-visible API and
>    behavioural changes. release_26_07.rst should mention them under
>    "API Changes".
>
> [PATCH v2 3/5] ethdev: hide VMDq internal sizes
> -----------------------------------------------
>
> Warning: public defines removed without deprecation cycle
>
>    RTE_ETH_NUM_RECEIVE_MAC_ADDR and RTE_ETH_VMDQ_NUM_UC_HASH_ARRAY
>    were declared in the application-facing rte_ethdev.h. Moving them
>    to ethdev_driver.h removes them from the public API. Per the DPDK
>    API/ABI policy this normally needs a prior deprecation notice; at
>    minimum it warrants a release_26_07.rst "API Changes" entry.

Mixed feeling about it.
I can add a note, but I think it is noise.


>
>
> [PATCH v2 4/5] net/iavf: accept up to 32k unicast MAC addresses
> ---------------------------------------------------------------
>
> Warning: dead store in iavf_add_del_uc_addr_bulk()
>
>    for (uint32_t i = 0; i < nb_addrs; i++) {
>            size_t buf_len = sizeof(struct virtchnl_ether_addr_list) +
>                    sizeof(struct virtchnl_ether_addr) * list->num_elements;
>            ...
>            buf_len = sizeof(struct virtchnl_ether_addr_list) +
>                    sizeof(struct virtchnl_ether_addr) * list->num_elements;
>
>    The first initialiser is unconditionally overwritten by the second
>    assignment before any read. Drop the initialiser (or move the
>    declaration to the use site).

Good catch.. rebase damage on my side, I dropped some
experiments/changes but forgot to update after.


>
> Warning: missing release note for max_mac_addrs jump
>
>    max_mac_addrs goes from 64 to 32768 and dev_data->mac_addrs is now
>    allocated at RTE_ETHER_ADDR_LEN * 32768 = 192 KiB per VF port. This
>    is a notable behaviour change for iavf users and worth a
>    release_26_07.rst entry.
>


-- 
David Marchand

