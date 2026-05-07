Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9384CD342C
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:51:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CB1E4026D;
	Thu,  7 May 2026 04:51:33 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 475BE400D7
 for <dev@dpdk.org>; Thu,  7 May 2026 04:51:32 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2f03d6cf77bso456488eec.0
 for <dev@dpdk.org>; Wed, 06 May 2026 19:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778122291;
 x=1778727091; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98s62DVVhmeBu2HCiEVPpsi5vF50GWdvhOa1SiQPp7I=;
 b=008EOphqjqKJEqzXCkGeRoGKLVWyOXQmXAQtz8211dSCDyyvttXSpxA2nDc8/oB1W0
 aB5zbwsOHVF9sk21+kNebkHmp6x8nH4DizmYtvGq9Fr0JtKH6n3cz+QdVfCdt4Ikv+2s
 MXYavKMnlDEYW80zx8NKIKOajNYp53Q63ODsJNnChVXYl6VRKwG9EzGAnJ3n50JcqOuk
 aZFNq20G8zuhL9mEd32o/wKZ5nxbX7gyF1Kv6r3BtQCXwFXO2M2YJUB4RDvzdsUrsL9X
 +WyXVzRg9ibUnOI99kHNM6Gd+i5s9H0XgUbkcBL4inQ3+2qr6HZpmTXTBsRByXEoRNoH
 mMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778122291; x=1778727091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=98s62DVVhmeBu2HCiEVPpsi5vF50GWdvhOa1SiQPp7I=;
 b=UUTBLVSJ6igIU6x5mrfdIL8SC2n1AP3MC/jdm+KkeoEe6qLLd9EqeBTkpKJhs7V8er
 QG4dqytVnA9U0AeYsgim9oFZz3SvSRFech/+Bgeg4V7zFlOn/+G2Zvrjf8wJWQKb8qVT
 JdjbHUprhmv21U74+Hz1BaFTUd12Kv+1zy3A90xlI3kByAfHvDLyHexsptSLkHIfNxh0
 Or0UvA4TG2Pg0590CjkI2ZWkdmwvx8HeXanq3JzoqmLKebko28CIgk4P3sWAeFnACj5B
 oy7JJcxF1IhV1DD+6b2zQx96p7PsRlE0ctejvyuOIq5uTBN5Qb386Zil3YS67IEhs+9s
 LRFg==
X-Gm-Message-State: AOJu0Yxep7oOdH2+fa6tkEa4kVAajw4R8GnBBo6tLfWibg8SaK1bIPYc
 +/vCRgQwo+PP0HgtoqemAgKCJU4DVjgltyoaEa4d3V50KyWyNP8t+3vi/QK2/rcHVdY=
X-Gm-Gg: AeBDieu3v+Lsw4BXSUdh+P7MSP6m1QuoB2psHCNguLrolp5E0Hrg1XlhvXVO+Q7wBmi
 cG7PMnd1BcZSiuSTIUueWFihvh7DSoHSETG9nxPplpkSv8Q9tT8fsDlXhM+EqpUHd8Y4RzdItG4
 TuXgXzm7UmzMxDgRaFXKl07xplA4lXuiE+Hxg5gcMyocx0ow2ugcxvFk6pP4MXVBTi/MNyab0ES
 o6YHgD94GswBfjQL7k+3bi/juE6Nc+FMNBRZRgAZmkyGRyuAFuUJMpKS1NMlTW307SWbnqqndl3
 U4Y4qpdZoNZE+W+MyLs9LtweDSExUGIkd9yKrXk+PB85lcqYb01v7Ex3dAdSrCw9gPIwfqpU3BI
 dmp7IR3ymNOB8BXBphxLky1CU2ng/gbUUasMdnXQPD7SEY5E0fiQDZqbjtlr+6rXQs6OqYtq2+7
 mZ4aeA6L3lt0yK6FTCVbwCuhitr7hcLtqqeX+yWEsjIbnY2tuQF/KJ06DZ
X-Received: by 2002:a05:7300:d704:b0:2ed:75d:fe40 with SMTP id
 5a478bee46e88-2f54958a6d9mr3344790eec.15.1778122291062; 
 Wed, 06 May 2026 19:51:31 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56cec592asm6786571eec.5.2026.05.06.19.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:51:30 -0700 (PDT)
Date: Wed, 6 May 2026 19:51:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/5] Remove limitations coming from legacy VMDq
Message-ID: <20260506195128.68d47ed2@phoenix.local>
In-Reply-To: <20260506123554.2524136-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260506123554.2524136-1-david.marchand@redhat.com>
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

On Wed,  6 May 2026 14:35:48 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Since the commit 88ac4396ad29 ("ethdev: add VMDq support"),
> VMDq has been imposing a maximum number of mac addresses in the
> mac_addr_add/del API.
> 
> Nowadays, new Intel drivers do not support the feature and few other
> drivers implement this feature.
> 
> This series proposes to flag drivers that support the feature, and
> remove the limit of number of mac addresses for others.
> 
> Next step could be to remove the VMDq pool notion from the generic API.
> However I have some concern about this, as changing the quite stable
> mac_addr_add/del API now seems a lot of noise for not much benefit.
> 


AI review (manual not automated) saw these:

On Wed,  6 May 2026 14:35:49 +0200
David Marchand <david.marchand@redhat.com> wrote:

[PATCH v2 1/5] ethdev: skip VMDq pools unless configured
--------------------------------------------------------

Warning: duplicate-add no longer returns 0 in non-VMDq mode

   } else if (vmdq) {
           pool_mask = dev->data->mac_pool_sel[index];
           /* Check if both MAC address and pool is already there, and do nothing */
           if (pool_mask & RTE_BIT64(pool))
                   return 0;
   }

   When index >= 0 (MAC already present) and VMDq is not configured,
   the early "already there" return that existed before is now skipped
   entirely. The driver's mac_addr_add op gets re-invoked and
   mac_pool_sel is no longer updated for !vmdq, so subsequent calls
   keep re-invoking it. Pre-patch behaviour was idempotent (return 0).

   Suggested fix:

   } else if (vmdq) {
           pool_mask = dev->data->mac_pool_sel[index];
           if (pool_mask & RTE_BIT64(pool))
                   return 0;
   } else {
           return 0;       /* MAC already installed, only one pool */
   }


[PATCH v2 2/5] ethdev: announce VMDq capability
-----------------------------------------------

Warning: capability advertised even when max_vmdq_pools may be 0

   The capability bit is set unconditionally in several drivers where
   VMDq availability is conditional on hardware variant or runtime
   configuration:

     - net/intel/e1000/igb_ethdev.c: max_vmdq_pools = 0 for e1000_82575,
       e1000_i354 (no setting), e1000_i210, e1000_i211.
     - net/intel/i40e/i40e_ethdev.c: max_vmdq_pools is gated on
       (pf->flags & I40E_FLAG_VMDQ).
     - net/bnxt/bnxt_ethdev.c: max_vmdq_pools is set to 0 when there
       are not enough resources (see "Not enough resources to support
       VMDq" path).

   With this patch a user can pass mq_mode |= RTE_ETH_MQ_RX_VMDQ_FLAG
   through rte_eth_dev_configure() because the new capability check
   passes, but the driver has no pools to honour the request.

   Suggested fix: gate the capa bit on max_vmdq_pools > 0, or set it
   per-MAC-type / per-flag in each driver.

Warning: VMDq capability advertised on VFs that do not configure VMDq

   ixgbevf_dev_info_get() and txgbevf_dev_info_get() now advertise
   RTE_ETH_DEV_CAPA_VMDQ, but ixgbevf_dev_configure() and
   txgbevf_dev_configure() only handle RTE_ETH_MQ_RX_RSS_FLAG. The
   feature matrices doc/guides/nics/features/ixgbe_vf.ini and
   txgbe_vf.ini do not list "VMDq = Y". A VF is itself a member of a
   PF VMDq pool; advertising the capa from the VF is misleading.

Warning: ipn3ke advertises VMDq=Y in its features file but is not
   updated by the patch

   doc/guides/nics/features/ipn3ke.ini has "VMDq = Y" but the patch
   does not add RTE_ETH_DEV_CAPA_VMDQ to ipn3ke. Either update the
   driver or correct the feature matrix.

Warning: missing release note

   The new RTE_ETH_DEV_CAPA_VMDQ public bit and the new rejection in
   rte_eth_dev_configure() (returning -EINVAL when an application sets
   a VMDq mq_mode on a non-VMDq device) are user-visible API and
   behavioural changes. release_26_07.rst should mention them under
   "API Changes".


[PATCH v2 3/5] ethdev: hide VMDq internal sizes
-----------------------------------------------

Warning: public defines removed without deprecation cycle

   RTE_ETH_NUM_RECEIVE_MAC_ADDR and RTE_ETH_VMDQ_NUM_UC_HASH_ARRAY
   were declared in the application-facing rte_ethdev.h. Moving them
   to ethdev_driver.h removes them from the public API. Per the DPDK
   API/ABI policy this normally needs a prior deprecation notice; at
   minimum it warrants a release_26_07.rst "API Changes" entry.


[PATCH v2 4/5] net/iavf: accept up to 32k unicast MAC addresses
---------------------------------------------------------------

Warning: dead store in iavf_add_del_uc_addr_bulk()

   for (uint32_t i = 0; i < nb_addrs; i++) {
           size_t buf_len = sizeof(struct virtchnl_ether_addr_list) +
                   sizeof(struct virtchnl_ether_addr) * list->num_elements;
           ...
           buf_len = sizeof(struct virtchnl_ether_addr_list) +
                   sizeof(struct virtchnl_ether_addr) * list->num_elements;

   The first initialiser is unconditionally overwritten by the second
   assignment before any read. Drop the initialiser (or move the
   declaration to the use site).

Warning: missing release note for max_mac_addrs jump

   max_mac_addrs goes from 64 to 32768 and dev_data->mac_addrs is now
   allocated at RTE_ETHER_ADDR_LEN * 32768 = 192 KiB per VF port. This
   is a notable behaviour change for iavf users and worth a
   release_26_07.rst entry.
