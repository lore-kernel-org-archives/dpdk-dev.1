Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2144CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 09:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1A9D402E6;
	Wed, 29 Oct 2025 10:16:40 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 60EDC40288;
 Wed, 29 Oct 2025 10:16:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 5598338
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1761729398;
 bh=4p1+CnkQ9WPXnQ3h5NJnSCa0+SP1k+lTB7ag6AzMNmo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NQW+PH9wmGTI8H3GrkDtPoX7qiJXwhkZtS2KF79qaYE/K7ACw6y2jwolN9iFFEg3B
 ADGNzns67E+M1Le6Rs7HD4S3RhOotoRfDQUL5tltuWf5s8tqR0IH09st2/QrniB57v
 hJPHqT7exBtUBcF6s9qQrCUg0nLjAATFQ3wyolJU=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 5598338;
 Wed, 29 Oct 2025 12:16:38 +0300 (MSK)
Message-ID: <157addba-7dc8-4f0c-8b86-4ca8d057cdfc@oktetlabs.ru>
Date: Wed, 29 Oct 2025 12:16:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fixing MBUF_FAST_FREE TX offload requirements?
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>, Shai Brandes
 <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Ron Beider <rbeider@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 Wajeeh Atrash <atrwajee@amazon.com>, Gaetan Rivet <grive@u256.net>,
 yangxingui <yangxingui@h-partners.com>,
 Fengchengwen <fengchengwen@huawei.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Rosen Xu <rosen.xu@altera.com>,
 Andrew Boyer <andrew.boyer@amd.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Wenbo Cao <caowenbo@mucse.com>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>,
 Ivan Malov <ivan.malov@arknetworks.am>, Thomas Monjalon <thomas@monjalon.net>
References: <98CBD80474FA8B44BF855DF32C47DC35F65442@smartserver.smartshare.dk>
 <aMvMNUxSslnM68OR@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65446@smartserver.smartshare.dk>
 <f3d8956d80814d82a450abc263349ea7@huawei.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <f3d8956d80814d82a450abc263349ea7@huawei.com>
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

On 9/18/25 5:12 PM, Konstantin Ananyev wrote:
> 
> 
>> Subject: RE: Fixing MBUF_FAST_FREE TX offload requirements?
>>
>>> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
>>> Sent: Thursday, 18 September 2025 11.09
>>>
>>> On Thu, Sep 18, 2025 at 10:50:11AM +0200, Morten Brørup wrote:
>>>> Dear NIC driver maintainers (CC: DPDK Tech Board),
>>>>
>>>> The DPDK Tech Board has discussed that patch [1] (included in DPDK
>>> 25.07) extended the documented requirements to the
>>> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
>>>> These changes put additional limitations on applications' use of the
>>> MBUF_FAST_FREE TX offload, and made MBUF_FAST_FREE mutually exclusive
>>> with MULTI_SEGS (which is typically used for jumbo frame support).
>>>> The Tech Board discussed that these changes do not reflect the
>>> intention of the MBUF_FAST_FREE TX offload, and wants to fix it.
>>>> Mainly, MBUF_FAST_FREE and MULTI_SEGS should not be mutually
>>> exclusive.
>>>>
>>>> The original RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE requirements were:
>>>> When set, application must guarantee that
>>>> 1) per-queue all mbufs come from the same mempool, and
>>>> 2) mbufs have refcnt = 1.
>>>>
>>>> The patch added the following requirements to the MBUF_FAST_FREE
>>> offload, reflecting rte_pktmbuf_prefree_seg() postconditions:
>>>> 3) mbufs are direct,
>>>> 4) mbufs have next = NULL and nb_segs = 1.
>>>>
>>>> Now, the key question is:
>>>> Can we roll back to the original two requirements?
>>>> Or do the drivers also depend on the third and/or fourth
>>> requirements?
>>>>
>>>> <advertisement>
>>>> Drivers freeing mbufs directly to a mempool should use the new
>>> rte_mbuf_raw_free_bulk() instead of rte_mempool_put_bulk(), so the
>>> preconditions for freeing mbufs directly into a mempool are validated
>>> in mbuf debug mode (with RTE_LIBRTE_MBUF_DEBUG enabled).
>>>> Similarly, rte_mbuf_raw_alloc_bulk() should be used instead of
>>> rte_mempool_get_bulk().
>>>> </advertisement>
>>>>
>>>> PS: The feature documentation [2] still reflects the original
>>> requirements.
>>>>
>>>> [1]:
>>>
>> https://github.com/DPDK/dpdk/commit/55624173bacb2becaa67793b7139188487
>> 6
>>> 673c1
>>>> [2]:
>>> https://elixir.bootlin.com/dpdk/v25.07/source/doc/guides/nics/features.
>>> rst#L125
>>>>
>>>>
>>>> Venlig hilsen / Kind regards,
>>>> -Morten Brørup
>>>>
>>> I'm a little torn on this question, because I can see benefits for both
>>> approaches. Firstly, it would be nice if we made FAST_FREE as
>>> accessible
>>> for driver use as it was originally, with minimal requirements.
>>> However, on
>>> looking at the code, I believe that many drivers actually took it to
>>> mean
>>> that scattered packets couldn't occur in that case either, so the use
>>> was
>>> incorrect.
>>
>> I primarily look at Intel drivers, and that's how I read the driver code too.
>>
>>> Similarly, and secondly, if we do have the extra
>>> requirements
>>> for FAST_FREE, it does mean that any use of it can be very, very
>>> minimal
>>> and efficient, since we don't need to check anything before freeing the
>>> buffers.
>>>
>>> Given where we are now, I think keeping the more restrictive definition
>>> of
>>> FAST_FREE is the way to go - keeping it exclusive with MULTI_SEGS -
>>> because
>>> it means that we are less likely to have bugs. If we look to change it
>>> back, I think we'd have to check all drivers to ensure they are using
>>> the
>>> flag safely.
>>
>> However, those driver bugs are not new.
>> If we haven't received bug reports from users affected by them, maybe we can
>> disregard them (in this discussion about pros and cons).
>> I prefer we register them as driver bugs, instead of changing the API to
>> accommodate bugs in the drivers.
>>
>>  From an application perspective, here's an idea for consideration:
>> Assuming that indirect mbufs are uncommon, we keep requirement #3.
>> To allow MULTI_SEGS (jumbo frames) with FAST_FREE, we get rid of requirement
>> #4.
> 
> Do we really need to enable FAST_FREE for jumbo-frames?
> Jumbo-frames usually means much smaller PPS number and actual RX/TX overhead
> becomes really tiny.

+1
>> Since the driver knows that refcnt == 1, the driver can set next = NULL and
>> nb_segs = 1 at any time, either when writing the TX descriptor (when it reads the
>> mbuf anyway), or when freeing the mbuf.
>> Regarding performance, this means that the driver's TX code path has to write to
>> the mbufs (i.e. adding the performance cost of memory store operations) when
>> segmented - but that is a universal requirement when freeing segmented mbufs
>> to the mempool.
> 
> It might work, but I think it will become way too complicated.
> Again I don't know who is going to inspect/fix all the drivers.
> Just not allowing FAST_FREE for mulsti-seg seems like a much more simpler and safer approach.
>   
>> For even more optimized driver performance, as Bruce mentions...
>> If a port is configured for FAST_FREE and not MULTI_SEGS, the driver can use a
>> super lean transmit function.
>> Since the driver's transmit function pointer is per port (not per queue), this would
>> require the driver to provide the MULTI_SEGS capability only per port, and not
>> per queue. (Or we would have to add a NOT_MULTI_SEGS offload flag, to ensure
>> that no queue is configured for MULTI_SEGS.)


FAST_FREE is not a real Tx offload, since there is no promise from
driver to do something (like other Tx offloads, e.g. checksumming or
TSO). Is it a promise to ignore refcount or take a look at memory pool
of some packets only? I guess no. If so, basically any driver may
advertise it and simply ignore if the offload is requested, but
driver can do nothing with these limitations on input data.

It is a performance hint in fact and promise from application to
follow specified limitations on Tx mbufs.

So, if application specifies both FAST_FREE and MULTI_SEG, but driver
code can't FAST_FREE with MULTI_SEG, it should just ignore FAST_FREE.
That's it. The performance hint is simply useless in this case.
There is no point to make FAST_FREE and MULTI_SEG mutual exclusive.
If some drivers can really support both - great. If no, just ignore
FAST_FREE and support MULTI_SEG.

"mbufs are direct" must be FAST_FREE requirement. Since otherwise
freeing is not simple. I guess is was simply lost in the original
definition of FAST_FREE.

I'm sorry for the late reply.

