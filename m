Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1034EC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:19:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 218C140B98;
	Wed, 23 Jul 2025 15:19:28 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 2C47F402E2;
 Wed, 23 Jul 2025 15:19:27 +0200 (CEST)
Received: from debian (unknown [78.109.70.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 1DFDCE0568;
 Wed, 23 Jul 2025 17:19:26 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 1DFDCE0568
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753276767;
 bh=21qsyTadYjQNM1u9naayPkg4QXTytlDMQ8M8cXN0lsY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=KWp6+ZBzryXthW7Hc6e/y+o/4q4bB62OWx1tOcfmnxQ/udD2dCdhpf9Y8ipMS2j0x
 RFRmvxaQxu5fd0+evvFmURhznXHe5So+J4w/yJg2ixJ5kdTC78kkvNw60SFP61HLsn
 fXDR3G2rVtgBeTTcUjQQdcbLDFb6EPTi3JALHePxFzwlS4Zm7ULPAcMyyEhmJZJ13t
 GPYSoprO+N6Gso1dvAiT1lU//1kramrO7OHxt4753MXt1EhdX7PHOGMt7g8m7OHFbQ
 oHg863RrprRngy0QZKgStML14R6RFfnJ3sRn32+NCY4RfJe3vWtMp5I8q+DIfFw/3I
 Yqg4j8hAGVBow==
Date: Wed, 23 Jul 2025 17:19:25 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
cc: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com, 
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] [PATCH v3] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
In-Reply-To: <20250723131049.1703172-1-14pwcse1224@uetpeshawar.edu.pk>
Message-ID: <0792a0e5-dbbf-f3bc-527b-2fe7d33e8822@arknetworks.am>
References: <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250723131049.1703172-1-14pwcse1224@uetpeshawar.edu.pk>
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

Hi Khadem,

On Wed, 23 Jul 2025, Khadem Ullah wrote:

> In secondary processes, directly accessing 'dev->data->dev_private' can
> cause a segmentation fault if the primary process has exited or if the
> shared memory is no longer accessible.
>
> Secondary application not only breaking on device closing,
> but also getting segfault when we do "show device info all" from secondary
> after primary closes.
>
> This patch adds safety checks while using rte_mem_virt2phy(), with an
> unlikely() branch hint to minimize performance impact in the fast path.
> This ensures 'dev_private' is still valid before accessing it.
>
> Fixes: bdad90d12ec8 ("ethdev: change device info get callback to return int")
> Cc: stable@dpdk.org
>
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
> lib/ethdev/rte_ethdev.c | 15 ++++++++++++++-
> 1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index dd7c00bc94..343e156a4f 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
>
> 	if (dev->dev_ops->dev_infos_get == NULL)
> 		return -ENOTSUP;
> +	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
> +		unlikely(rte_mem_virt2phy(dev->data->dev_private) == RTE_BAD_PHYS_ADDR)) {
> +			RTE_ETHDEV_LOG_LINE(ERR,
> +			"Secondary: dev_private not accessible (primary exited?)");
> +			rte_errno = ENODEV;
> +			return -rte_errno;
> +	}
> 	diag = dev->dev_ops->dev_infos_get(dev, dev_info);
> 	if (diag != 0) {
> 		/* Cleanup already filled in device information */
> @@ -4307,7 +4314,13 @@ rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr)
> 			port_id);
> 		return -EINVAL;
> 	}
> -
> +	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
> +		(dev->data->mac_addrs == NULL)) {
> +			RTE_ETHDEV_LOG_LINE(ERR,
> +			"Secondary: dev_private not accessible (primary exited?)");
> +			rte_errno = ENODEV;
> +			return -rte_errno;
> +	}
> 	rte_ether_addr_copy(&dev->data->mac_addrs[0], mac_addr);
>
> 	rte_eth_trace_macaddr_get(port_id, mac_addr);

I see one more API has been augmented with the check. But community members may
still argue this is not robust, as many other APIs will also fail. So, even if
the task was to augment as many APIs as possible with the check, then the check
would still be required to be factorised/generalised somehow. What do you think?

Please also note that there are already macro invocations in many of these APIs,
for example, RTE_ETH_VALID_PORTID_OR_ERR_RET. Could be convenient.

Thank you.

> -- 
> 2.43.0
>
>
