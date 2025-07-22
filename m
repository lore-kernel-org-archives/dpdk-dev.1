Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D48C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 16:26:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B58A640269;
	Tue, 22 Jul 2025 18:26:47 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 98E894003C;
 Tue, 22 Jul 2025 18:26:46 +0200 (CEST)
Received: from debian (unknown [78.109.70.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 66682E0710;
 Tue, 22 Jul 2025 20:26:45 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 66682E0710
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753201606;
 bh=dubuS3ObryigNuJA35Vw48ohW67lQiJWE3vayJCqbNQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=uEbd42ETmjgS+vmot/U0bPh530mYzqHY7M3ezm8Uu8tNaVK51rbUZZ8vHzT8uxsJI
 sZ5WFlHd/M0ER9U0G4LxnW4CUuAL237mqzSmRz7ZgAnp8bqEsugFQnSecKZ1iSgCZj
 dbsglWlANvEdPDwW0aARUmBpj00zmG2gX2JBUJseMKPDe7DAd3HU+89nln1b4x6Y4m
 d7bvNzdXt0k5a2J4jZvWkWJVwbmQJKZQYN3+bTgi0CIRQDwgg8bd/3gE/tV9PSfW9N
 4FcFDVJrNgf2ngEU+LlpepyXoGSEtAdhroYR8RVh4GhYZ1PnzWMhkSpvi36SvSd8t6
 CgduPi6H/6QBw==
Date: Tue, 22 Jul 2025 20:26:43 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
cc: Thomas Monjalon <thomas@monjalon.net>, 
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 rasland@nvidia.com, stable@dpdk.org, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix crash when secondary queries dev info
 after primary exits
In-Reply-To: <20250721140127.r6orvsqsox7ytlhb@ds-vm-debian.local>
Message-ID: <6d86669d-b277-584d-047f-c5cd1f5d0e55@arknetworks.am>
References: <20250721073851.963141-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250721105819.2ci66fl7bzikwb22@ds-vm-debian.local>
 <b0c702cc-1213-d773-0ee0-804542a07e28@arknetworks.am>
 <3358342.oiGErgHkdL@thomas>
 <20250721140127.r6orvsqsox7ytlhb@ds-vm-debian.local>
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

Hi Dariusz, Khadem,

On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:

> On Mon, Jul 21, 2025 at 01:59:59PM +0200, Thomas Monjalon wrote:
>> 21/07/2025 13:46, Ivan Malov:
>>> On Mon, 21 Jul 2025, Dariusz Sosnowski wrote:
>>>
>>>> + mlx5 maintainers
>>>>
>>>> Thank you for the patch.
>>>>
>>>> Could you please include other PMD maintainers (or other maintainers, depending on changed code)
>>>> in the future patches?
>>>> There is a script which automatically adds maintainers while sending a patch.
>>>> It is described in: https://doc.dpdk.org/guides/contributing/patches.html#sending-patches
>>>>
>>>> On Mon, Jul 21, 2025 at 03:38:51AM -0400, Khadem Ullah wrote:
>>>>> When the primary process exits, the shared mlx5 state becomes
>>>>> unavailable to secondary processes. If a secondary process attempts
>>>>> to query device information (e.g., via testpmd), a NULL dereference
>>>>> may occur due to missing shared data.
>>>>>
>>>>> This patch adds a check for shared context availability and fails
>>>>> gracefully while preventing a crash.
>>>>>
>>>>> Fixes: e60fbd5b24fc ("mlx5: add device configure/start/stop")
>>>>> Cc: stable@dpdk.org
>>>>>
>>>>> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
>>>>> ---
>>>>>  drivers/net/mlx5/mlx5_ethdev.c | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
>>>>> index 68d1c1bfa7..1848f6536a 100644
>>>>> --- a/drivers/net/mlx5/mlx5_ethdev.c
>>>>> +++ b/drivers/net/mlx5/mlx5_ethdev.c
>>>>> @@ -368,6 +368,12 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
>>>>>  	 * Since we need one CQ per QP, the limit is the minimum number
>>>>>  	 * between the two values.
>>>>>  	 */
>>>>> +	if (priv == NULL || priv->sh == NULL) {
>>>>> +		DRV_LOG(ERR,
>>>>> +		"mlx5 shared data unavailable (primary process likely exited)");
>>>>> +		rte_errno = ENODEV;
>>>>> +		return -rte_errno;
>>>>> +	}
>>>>
>>>> I don't think it's an issue on PMD level, but rather on
>>>> ethdev/multi-process handling level.
>>>
>>> I may be very wrong here, but can't the PMD use its internal 'shared' state to
>>> somehow memorise the fact that a secondary process has attached, in order to not
>>> let the primary process close in the first place (before the secondary process
>>> detaches)? Or is this going to violate some established convention?
>>
>> It looks to be a good idea.
>
> I agree with idea of adding these checks, but not entirely agree with
> it being at driver level, since all drivers would have to duplicate this logic.
>
> Drivers already have to go through ethdev library when port is probed
> on secondary process - rte_eth_dev_attach_secondary() must be
> called to retrieve port data local to the process and device data shared
> between processes.
> Memorizing whether a secondary process is using given port can be added
> to rte_eth_dev_attach_secondary(), and relevant check for primary
> process can then be added to rte_eth_dev_close(), so that all drivers
> benefit.
>
> What do you think?

Yes, in general, the idea would be to have a "secondary reference counter" field
in 'rte_eth_dev_data' and have it incremented/decremented/checked in some
generic places. The issue is that, in addition to 'rte_eth_dev_close', a device
can be "closed" via its respective bus 'remove' method. Yes, there are drivers
that invoke 'rte_eth_dev_close' inside the 'remove' implementation, but not all
of them, unfortunately. For example, take a look at 'af_packet' and similar.

On the other hands, there are drivers that use 'rte_eth_dev_create' and its
counterpart 'rte_eth_dev_destroy' in the implementations of bus 'probe/remove',
but that is also not consistent across the 'drivers/net' tree.

Given all these issues and the fact that ethdev is not the only possible device
type, may be 'rte_device' can house the reference counter, with 'rte_dev_probe'
and 'rte_dev_remove' augmented to do the inrement/decrement/validate thing?
And, since 'rte_eth_dev_close' invokes direct ethdev 'close' method, also add a
check to over there (and may be to 'rte_eth_dev_reset', too)? May be I'm wrong.

However, all of that might still make no sense, given the fact that the primary
process can just die. So, may be I am indeed very wrong and, as Stephen has
suggested in [1], this issue it to be addressed by clarifying the documentation.

[1] https://mails.dpdk.org/archives/dev/2025-July/321865.html

Thank you.

>
>>
>>>> When primary process closes the port, ethdev library zeroes and frees
>>>> device data shared between processes.
>>>> ethdev port data (rte_eth_dev) on secondary is not updated so it now points to
>>>> invalid data. rte_eth_dev_info_get() is not the only API call affected.
>>>>
>>>> If the primary process closes the port before exiting
>>>> (like testpmd does) and it exits before the secondary,
>>>> the any driver call seems invalid because of that use-after-free behavior.
>>>>
>>>> @Thomas, @Andrew - Do you happen to know if doing anything on ethdev ports
>>>> in secondary process after primary has gracefully exited is supported?
>>
>> No there is no statement about whether it is supported or not.
>> I think we should at least return an error instead of crashing.
>>
>>
>
