Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E115E9DE6F
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 09:05:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40936402D3;
	Thu,  9 Apr 2026 11:05:42 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 657624028F
 for <dev@dpdk.org>; Thu,  9 Apr 2026 11:05:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 1D37C38
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1775725539;
 bh=s0x/8N3sJ3l/tMA0yIVDylcEKCUl7gdC0lyZNGk2qTU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Rx90jbxMSnsu8XPdbIrGkQQTgbqQgJz7We88Os89lgOq7bGgXUJCXoDUqmUO+EXz7
 H+vDdOGxKKaTU/fEMKz8h+MA54+OaikpUReu3p0QYCRoC/oOD6Z5qhEzY9bOdYQg3I
 hBl0MAHm1bwYqr8UD4AedCfdrvZje3X3Vu83ZVbI=
Received: from [192.168.1.42] (unknown [188.170.74.13])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 1D37C38;
 Thu,  9 Apr 2026 12:05:38 +0300 (MSK)
Message-ID: <445dc90b-081a-4ab0-bd3f-924557dcac9a@oktetlabs.ru>
Date: Thu, 9 Apr 2026 12:05:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260409013658.965613-1-stephen@networkplumber.org>
 <c04d3145-d6e9-4583-b49c-82341ea9b0aa@oktetlabs.ru>
 <addcKzXuZYV19F3P@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <addcKzXuZYV19F3P@bricha3-mobl1.ger.corp.intel.com>
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

On 4/9/26 10:58 AM, Bruce Richardson wrote:
> On Thu, Apr 09, 2026 at 09:59:04AM +0300, Andrew Rybchenko wrote:
>> On 4/9/26 4:36 AM, Stephen Hemminger wrote:
>>> rte_eth_dev_get_name_by_port() uses strcpy() into a caller-provided
>>> buffer with no bounds checking. A mistaken caller that supplies a
>>> buffer smaller than RTE_ETH_NAME_MAX_LEN can overflow the buffer.
>>>
>>> Add a size parameter and replace strcpy() with strlcpy(), returning
>>> -ERANGE if the name is truncated. The copy is now performed under
>>> the ethdev shared data lock so that the name cannot be mutated by
>>> another process between reading and copying.
>>>
>>> The previous ABI is preserved via symbol versioning (DPDK_26) with a
>>> thin wrapper that delegates to the new implementation with
>>> RTE_ETH_NAME_MAX_LEN. The versioned symbol will be removed in 26.11.
>>>
>>> Update all in-tree callers to pass sizeof(name) as the new parameter.
>>>
>>> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>>
>> with notes below fixed
>>
>> Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
>>
>>> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
>>> index 2edc7a362e..586a56bd46 100644
>>> --- a/lib/ethdev/rte_ethdev.c
>>> +++ b/lib/ethdev/rte_ethdev.c
>>> @@ -721,12 +721,9 @@ rte_eth_dev_count_total(void)
>>>    	return count;
>>>    }
>>> -RTE_EXPORT_SYMBOL(rte_eth_dev_get_name_by_port)
>>> -int
>>> -rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
>>> +static int
>>> +eth_dev_get_name_by_port(uint16_t port_id, char *name, size_t size)
>>>    {
>>> -	char *tmp;
>>> -
>>>    	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
>>>    	if (name == NULL) {
>>> @@ -735,19 +732,46 @@ rte_eth_dev_get_name_by_port(uint16_t port_id, char *name)
>>>    		return -EINVAL;
>>>    	}
>>> +	if (size == 0) {
>>> +		RTE_ETHDEV_LOG_LINE(ERR,
>>> +			"Cannot get ethdev port %u name with zero-size buffer", port_id);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>>    	rte_spinlock_lock(rte_mcfg_ethdev_get_lock());
>>> -	/* shouldn't check 'rte_eth_devices[i].data',
>>> -	 * because it might be overwritten by VDEV PMD */
>>> -	tmp = eth_dev_shared_data->data[port_id].name;
>>> +	/*
>>> +	 * Use the shared data name rather than rte_eth_devices[].data->name
>>> +	 * because VDEV PMDs may overwrite the per-process data pointer.
>>> +	 */
>>> +	size_t n = strlcpy(name, eth_dev_shared_data->data[port_id].name, size);
>>
>> As far as I know typically variable declaration and code are not mixed
>> in DPDK.
>>
> 
> AFAIK That used to be the case because early versions of DPDK targetting a
> very early C standard. More recently, we've started allowing this sort of
> use, which makes the code more readable IMHO and easier to work with too as
> commenting out blocks when debugging leads to fewer unused variable warnings.
> 
> /Bruce

Bruce, thanks for the clarification.

