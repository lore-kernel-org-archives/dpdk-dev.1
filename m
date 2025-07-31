Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82215C83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 05:43:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 518CF4026A;
	Thu, 31 Jul 2025 07:43:45 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id BDC994025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 07:43:43 +0200 (CEST)
Received: from debian (unknown [78.109.79.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 2D66DE0400;
 Thu, 31 Jul 2025 09:43:42 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 2D66DE0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753940622;
 bh=+k0EFRSYOoK2wK+pOq2PgW1mlI044bH7mJvNdESsLv0=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=wS4gVl028jLpY7QUvhXKYFDm7nk9YMNWRGd1YJ76kqgFXRoAXOeatuh9v0QTgoXz0
 Q+9oHN3MBUjKZ2Sb8Rbf8CXMIAVJlEiqlRCaDfwA3vO2jIcGOrAJgRtbOC34GTSZqP
 7xBjyXuF90GSA3S8J2XS1jb5bQIDuoF52gr2F3u+64eAQVwoMhgEUzfrDtr4zlLXX8
 /2Uw/aKiLgV9oCfKHLYR8kXqvIoN8sAEVRNyDSsAyjeE8wzKpst+7mq2O+se/CEYfo
 k3DC5sro14ELg9R/85E41B6hAOR+lOVbbl4OnC2WdTcdMQLuctPM2tbu/OUfr+TnLL
 SDFf1d/Q8y/rQ==
Date: Thu, 31 Jul 2025 09:43:40 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Shaiq Wani <shaiq.wani@intel.com>
cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com, 
 Jeff Shaw <jeffrey.b.shaw@intel.com>
Subject: Re: [PATCH 2/2] net/ice: count drop- all filter stats in Rx stats
In-Reply-To: <20250731044132.110174-3-shaiq.wani@intel.com>
Message-ID: <d0ef66ef-b148-8b3b-b2e4-1b20a5307a62@arknetworks.am>
References: <20250731044132.110174-1-shaiq.wani@intel.com>
 <20250731044132.110174-3-shaiq.wani@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Thu, 31 Jul 2025, Shaiq Wani wrote:

> Packets dropped in the receive direction are counted as
> "rx_unknown_protocol" (GLSWID_RUPP),these packets need to be added
> to the "ipackets" and the GLV_GORCH/GLV_GORCL counters
> need to be added to rx_bytes.
>
> Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
> drivers/net/intel/ice/ice_ethdev.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 513777e372..0ebe58f858 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -6383,12 +6383,13 @@ ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
>
> 	stats->ipackets = pf->main_vsi->eth_stats.rx_unicast +
> 			  pf->main_vsi->eth_stats.rx_multicast +
> +			  ns->eth.rx_unknown_protocol +

I may be wrong, but shan't drops and discards contribute to 'imissed' instead?
According to [1], 'ipackets' is 'Total number of successfully received packets',
and per-queue version of 'ipackets' also exists, hinting at the host Rx nature.

[1] https://doc.dpdk.org/api-25.07/structrte__eth__stats.html#ac14b69830000494630c8897b70c5fc54

And if, say, they contribute to 'imissed', then no update to the 'ibytes'?
Please correct me if I'm wrong, -- I really prefer just to clarify this.

Thank you.

> 			  pf->main_vsi->eth_stats.rx_broadcast -
> 			  pf->main_vsi->eth_stats.rx_discards;
> 	stats->opackets = ns->eth.tx_unicast +
> 			  ns->eth.tx_multicast +
> 			  ns->eth.tx_broadcast;
> -	stats->ibytes   = pf->main_vsi->eth_stats.rx_bytes;
> +	stats->ibytes   = ns->eth.rx_bytes;
> 	stats->obytes   = ns->eth.tx_bytes;
> 	stats->oerrors  = ns->eth.tx_errors +
> 			  pf->main_vsi->eth_stats.tx_errors;
> -- 
> 2.34.1
>
>
