Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEB9C83F17
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Jul 2025 08:44:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13907402DD;
	Sat, 26 Jul 2025 10:44:54 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id D65EA400D5
 for <dev@dpdk.org>; Sat, 26 Jul 2025 10:44:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 350ED50
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1753519491;
 bh=ffGTspf/zgAsDlwWmQpM9tKomj0b0zr+I5XSxBquxgk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vlz6iUOJnm3xuTrsqZPzsOA+UI61watl9Hs726C0r3m9LPbYokwLIriBknJ/FCKah
 9vhbJ3Eez3OWK5W7yZTd0AgMbtjpA/SDgOxo4gEzQtCim5KUfmD3NGytuKyZPEpC05
 sWP8enu6i6yir2c7+SNjko99ajzPPE8MxZG+4M90=
Received: from [192.168.1.39] (unknown [188.170.87.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 350ED50;
 Sat, 26 Jul 2025 11:44:49 +0300 (MSK)
Message-ID: <48140af2-6d63-466e-9c54-22f241b86246@oktetlabs.ru>
Date: Sat, 26 Jul 2025 11:44:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ethdev: remove unnecessary type conversion
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 skori@marvell.com, Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, John Daley <johndale@cisco.com>,
 Hyong Youb Kim <hyonkim@cisco.com>, Jie Hai <haijie1@huawei.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Chaoyong He <chaoyong.he@corigine.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Jerin Jacob <jerinj@marvell.com>,
 Maciej Czekaj <mczekaj@marvell.com>, Jian Wang <jianwang@trustnetic.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Jochen Behrens <jochen.behrens@broadcom.com>,
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC46@smartserver.smartshare.dk>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC46@smartserver.smartshare.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/12/25 19:04, Morten Brørup wrote:
>> From: Sunil Kumar Kori <skori@marvell.com>
>> Sent: Monday, 12 May 2025 17.07
>>
>> As rte_eth_rx_queue_count() returns signed value to represent
>> the error cases but internally invoked callback is returning
>> unsigned value. Hence unnecessary type conversion is done.
>>
>> To avoid this typecasting from signed to unsigned, fixed
>> return type of callback functions.
>>
>> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> 
> Note for other reviewers:
> The tx_queue_count callback already returns int, and doesn't need to be updated.
> 
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> 
>> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
>> index ea7f8c4a1a..b3031ab9e6 100644
>> --- a/lib/ethdev/rte_ethdev.h
>> +++ b/lib/ethdev/rte_ethdev.h
>> @@ -6401,7 +6401,7 @@ rte_eth_rx_queue_count(uint16_t port_id, uint16_t
>> queue_id)
>>
>>   	if (p->rx_queue_count == NULL)
>>   		return -ENOTSUP;
>> -	return (int)p->rx_queue_count(qd);
>> +	return p->rx_queue_count(qd);
>>   }
>>
>>   /**@{@name Rx hardware descriptor states
>> diff --git a/lib/ethdev/rte_ethdev_core.h
>> b/lib/ethdev/rte_ethdev_core.h
>> index e55fb42996..4ffae4921a 100644
>> --- a/lib/ethdev/rte_ethdev_core.h
>> +++ b/lib/ethdev/rte_ethdev_core.h
>> @@ -45,7 +45,7 @@ typedef uint16_t (*eth_tx_prep_t)(void *txq,
>>
>>
>>   /** @internal Get number of used descriptors on a receive queue. */
>> -typedef uint32_t (*eth_rx_queue_count_t)(void *rxq);
>> +typedef int (*eth_rx_queue_count_t)(void *rxq);
>>
>>   /** @internal Check the status of a Rx descriptor */
>>   typedef int (*eth_rx_descriptor_status_t)(void *rxq, uint16_t offset);
>> --
>> 2.43.0
> 
> For the ethdev library changes:
> Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
> 

IMHO API consistency vs Tx is more important here. Moreover, since it
helps to avoid weird type casts in the next patch, it proves that it is
a step in a right direction. Basically I see no point to keep the
difference in return value of ethdev API and driver callback, it does
not add value. If driver callback always successful it can simply always
return non-negative values - that's it.

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
