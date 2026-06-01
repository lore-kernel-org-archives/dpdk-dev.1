Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D71CD6E4C
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 08:07:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D3BB4025F;
	Mon,  1 Jun 2026 10:07:51 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 2648F4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 10:07:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 52A7866
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780301268;
 bh=kTDCroKGTlXVGtx0uwEeOqDGfbXzYvx6yDpNkvoetJA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FTYdg8X/9i00BETZUZXimltrBYHrYjmPMuXk52F01rbB6bvXH+ZzCy+7KXjjUpuqw
 x4qSdWXTuegy2TWO/ywAcsdmX5GwIqxbLS3wevJA9UHCpW0ml91si31T0JA7E32Y6q
 g7qHH95IpjcFIee9Uidx2pkD0nOGp02J72f4H3Zo=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 52A7866;
 Mon,  1 Jun 2026 11:07:48 +0300 (MSK)
Message-ID: <b7a3b21d-a474-45ac-b039-ab2ee5cff092@oktetlabs.ru>
Date: Mon, 1 Jun 2026 11:07:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] ethdev: introduce selective Rx
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260529133522.2646044-1-thomas@monjalon.net>
 <20260529133522.2646044-3-thomas@monjalon.net>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260529133522.2646044-3-thomas@monjalon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/29/26 4:33 PM, Thomas Monjalon wrote:
> From: Gregory Etelson <getelson@nvidia.com>
> 
> Receiving an entire packet is not always needed.
> The Rx performance can be improved by receiving only partial data
> and safely discard the rest of the packet data,
> because it reduces the PCI bandwidth and the memory consumption.
> 
> Selective Rx allows an application to receive
> only pre-configured packet segments and discard the rest.
> For example:
> - Deliver the first N bytes only.
> - Deliver the last N bytes only.
> - Deliver N1 bytes from offset Off1 and N2 bytes from offset Off2.
> 
> Selective Rx is implemented on top of the Rx buffer split API:
> - rte_eth_rxseg_split uses the null mempool for segments
> that should be discarded.
> - the PMD does not create mbuf segments if no data read.
> 
> For example: Deliver Ethernet header only
> 
> Rx queue segments configuration:
> struct rte_eth_rxseg_split split[2] = {
>      {
>          .mp = <some mempool>,
>          .length = sizeof(struct rte_ether_hdr)
>      },
>      {
>          .mp = NULL, /* discard data */
>          .length = 0 /* default to buffer size */
>      }
> };
> 
> Received mbuf:
>      pkt_len = sizeof(struct rte_ether_hdr);
>      data_len = sizeof(struct rte_ether_hdr);
>      next = NULL; /* The next segment did not deliver data */
> 
> After selective Rx, the mbuf packet length reflects only the data
> that was actually received,
> and can be less than the original wire packet length.
> 
> A PMD activates the selective Rx capability by setting
> the rte_eth_rxseg_capa.selective_rx bit.
> 
> This new capability bit is inserted in a bitmap hole
> of the struct rte_eth_rxseg_capa,
> but it needs to be ignored in the ABI check as libabigail sees a change.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

LGTM, thanks

Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

