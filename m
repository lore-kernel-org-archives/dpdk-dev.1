Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32448106705A
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 15:55:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3964240613;
	Thu, 12 Mar 2026 16:55:00 +0100 (CET)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by mails.dpdk.org (Postfix) with ESMTP id 9B443402AC
 for <dev@dpdk.org>; Thu, 12 Mar 2026 16:54:58 +0100 (CET)
Received: from L30177.local (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id C8D146013B;
 Thu, 12 Mar 2026 16:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773330898;
 bh=FU1Z/x4fEGURAEiwYKlAPLh5TeWadj2OV7u3oo7WLrs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m0Bb+V1iVN0rbcQsXyVKcPcJD63Yt27sPFUbaJqk93RBf0aBcnt5T145c1gqCSQtf
 kIbWMegqjCYVJaz48LtgzYjcWBEVyei9j5T4dMq0maJ9a3lNoUj4gZcYULnkq38KuK
 KH1yS7VaC7zq/WeSffInai5+pEFFaFqTSjUo4u4w/phMhr5DQ7etWGGZMeKZXeLDA+
 3+EwM944AbUyLHZ5i1EH5hiuJ17EjYxAThoxLs+DmplPBa5zKdAN37NThpAqWBzHO1
 il0FxoxpjKNrfoMyhFdLMPNRf1H3chYgwf/FlaJJJvtEsvqiftLHJlrDk11WFO31G0
 EX66Th2zL8qWg==
Date: Thu, 12 Mar 2026 16:54:45 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH v2 08/10] ethdev: add getter for per-queue Tx rate limit
Message-ID: <abLhxcU98iNuyXjN@L30177.local>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
 <20260310232653.2935764-9-vjardin@free.fr>
 <20260311092648.7f22eb67@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311092648.7f22eb67@phoenix.local>
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

Hi,

Thanks for the review, see below.

Le 11/03/26 09:26, Stephen Hemminger a écrit :
> A couple of observations about this new API.
> 
> 1. The queue index validation is duplicated in both ethdev and mlx5
> driver. Since this is a new API, the ethdev layer should be the single place
> that validates queue_idx < nb_tx_queues and rejects NULL output
> pointers - the driver callbacks should be able to assume these
> preconditions are met. The same applies to the existing
> mlx5_set_queue_rate_limit() which re-checks bounds that
> rte_eth_set_queue_rate_limit() already validates. Remove the redundant
> checks from the driver.

You are right. In v3, I'll:

- rte_eth_get_queue_rate_limit() - validate queue_idx
  and NULL tx_rate pointer before calling the driver op. This is the
  single validation point.

- mlx5_get_queue_rate_limit() - no longer check queue_idx bounds or
  NULL -- it trusts the ethdev preconditions.

- mlx5_set_queue_rate_limit() - also set a redundant queue_idx bounds
  check that duplicated what rte_eth_set_queue_rate_limit() already
  does -- removed as well.

The only driver-level checks that remain are things the ethdev layer
cannot know about and whether the HW supports packet_pacing since
it seems a bit specific. Later on, it could be revisisted.

> 
> 2. The new rte_eth_get_queue_rate_limit() API uses uint32_t for the
> rate. Since this is a brand-new experimental API with no backward
> compatibility constraint, use uint64_t for the rate value to
> accommodate future devices with rates exceeding 4 Gbps. This applies to
> both the getter and the setter callback - adding a new getter that
> already needs a type change next year defeats the purpose of getting
> the API right now.

No, it would break API symmetry which I do not like.

The rate unit is Mbps, not bps. This is documented in both the setter and getter,
and matches how rte_eth_set_queue_rate_limit().

uint32_t in Mbps covers up to about 4.3 Tbps. Current top-end NICs are 800 Gbps
aggregate; per-queue rates are a fraction of that. We are more than
three orders of magnitude away from saturating uint32_t.

Changing the getter to uint64_t would break API symmetry -- the existing
setter is:
   int rte_eth_set_queue_rate_limit(uint16_t port_id, uint16_t queue_idx,
                                    uint32_t tx_rate);

The day per-queue rates approach the Tbps range, both setter and getter
would need to evolve together as part of a broader ethdev ABI revision.
Until then, let's keep it consistent.

> 
> Surprising to me, that AI review found nits, but totally missed
> several architectural issues.

+1, AI helps, but it is appreciated with the human reviews too ;) so we can have our flavours.

Best regards,
  Vincent
