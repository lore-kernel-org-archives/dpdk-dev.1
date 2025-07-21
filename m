Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184D0C83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 11:46:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 336CE4021E;
	Mon, 21 Jul 2025 13:46:52 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 5BE284014F;
 Mon, 21 Jul 2025 13:46:50 +0200 (CEST)
Received: from debian (unknown [78.109.70.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 32579E06DD;
 Mon, 21 Jul 2025 15:46:48 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 32579E06DD
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753098409;
 bh=S+nzttmQxpAx6h4LiOS6BR0oYdbQw2wCnFvG7ZdD/WY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=bdNvb3D8yPvLOFb9mp6SuNU/T+uGrejM5bHCqIygIcmrg2BNXlYWJOzvSG94cCgnm
 /26QveA39RbhoqVvespVxotijW4pIkDx7zmlIoWP2bPWGLI6PTeZP1Eqy7dSEIRsZg
 gpRikWy6AmH255gXvskGwumJtcaKS4gTGMvmy+RhHXY/yMFSVPOzrFoHswfVW9sHby
 NgLnNB7ceEMCYJgSC82MSRe/w6O+KK0Oh0OrcpUwcykN5ioOsJJ6NNPrxVKpmzjwMj
 21vPeA1Vr/HizmK9958ygWrhFiYVGdn2jUGnYQ/fCPiElGTX12ovxkPc++g2Au70mw
 33GmKs79ntuZw==
Date: Mon, 21 Jul 2025 15:46:39 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
cc: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, 
 Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 rasland@nvidia.com, stable@dpdk.org, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix crash when secondary queries dev info
 after primary exits
In-Reply-To: <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
Message-ID: <b0c702cc-1213-d773-0ee0-804542a07e28@arknetworks.am>
References: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
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

On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:

> + mlx5 maintainers
>
> Thank you for the patch.
>
> Could you please include other PMD maintainers (or other maintainers, depending on changed code)
> in the future patches?
> There is a script which automatically adds maintainers while sending a patch.
> It is described in: https://doc.dpdk.org/guides/contributing/patches.html#sending-patches
>
> On Mon, Jul 21, 2025 at 03:38:51AM -0400, Khadem Ullah wrote:
>> When the primary process exits, the shared mlx5 state becomes
>> unavailable to secondary processes. If a secondary process attempts
>> to query device information (e.g., via testpmd), a NULL dereference
>> may occur due to missing shared data.
>>
>> This patch adds a check for shared context availability and fails
>> gracefully while preventing a crash.
>>
>> Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
>> ---
>>  drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
>> index 68d1c1bfa7..1848f6536a 100644
>> --- a/drivers/net/mlx5/mlx5_ethdev.c
>> +++ b/drivers/net/mlx5/mlx5_ethdev.c
>> @@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
>>  	 * Since we need one CQ per QP, the limit is the minimum number
>>  	 * between the two values.
>>  	 */
>> +	if (priv == NULL || priv->sh == NULL) {
>> +		DRV_LOG(ERR,
>> +		"mlx5 shared data unavailable (primary process likely exited)");
>> +		rte_errno = ENODEV;
>> +		return -rte_errno;
>> +	}
>
> I don't think it's an issue on PMD level, but rather on
> ethdev/multi-process handling level.

I may be very wrong here, but can't the PMD use its internal 'shared' state to
somehow memorise the fact that a secondary process has attached, in order to not
let the primary process close in the first place (before the secondary process
detaches)? Or is this going to violate some established convention?

Thank you.

>
> When primary process closes the port, ethdev library zeroes and frees
> device data shared between processes.
> ethdev port data (rte_eth_dev) on secondary is not updated so it now points to
> invalid data. rte_eth_dev_info_get() is not the only API call affected.
>
> If the primary process closes the port before exiting
> (like testpmd does) and it exits before the secondary,
> the any driver call seems invalid because of that use-after-free behavior.
>
> @Thomas, @Andrew - Do you happen to know if doing anything on ethdev ports
> in secondary process after primary has gracefully exited is supported?
>
>>  	max = RTE_MIN(priv->sh->dev_cap.max_cq, priv->sh->dev_cap.max_qp);
>>  	/* max_rx_queues is uint16_t. */
>>  	max = RTE_MIN(max, (unsigned int)UINT16_MAX);
>> --
>> 2.43.0
>>
>
