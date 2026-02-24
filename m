Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63930EFB7FD
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 06:50:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 474ED4027F;
	Tue, 24 Feb 2026 07:50:21 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 2F34F400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 07:50:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru A976D56
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1771915818;
 bh=d23y8GSQDkGO6vnhPwMA0RdrVAVYDzXwzWcM9jXLh+g=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=b57WpK3NOkTflYuDb5366Oh7P1PpBm5S1kjc6SlcjsB677JW9q1oKxau3hWCYAWXO
 oaUCXH5OVONc8ACmlBmgh9eFf+haVeYFapZhxqYM6JQX7gl269zHJQHayamZkf/UCO
 1L2lsCXAz6Q03RFhXdv9eik4ZjMT2aE/6uDeBzbc=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id A976D56;
 Tue, 24 Feb 2026 09:50:18 +0300 (MSK)
Message-ID: <d7eb9f68-8084-41ec-b6d5-5873e8d53852@oktetlabs.ru>
Date: Tue, 24 Feb 2026 09:50:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mempool: introduce statistics reset function
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org
References: <20260223102054.336350-1-mb@smartsharesystems.com>
 <6af4bdb3-0a0c-4d99-9852-376bf93d1a16@oktetlabs.ru>
 <98CBD80474FA8B44BF855DF32C47DC35F65740@smartserver.smartshare.dk>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65740@smartserver.smartshare.dk>
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

On 2/24/26 9:38 AM, Morten Brørup wrote:
>> From: Andrew Rybchenko [mailto:andrew.rybchenko@oktetlabs.ru]
>> Sent: Tuesday, 24 February 2026 07.29
>>
>> On 2/23/26 1:20 PM, Morten Brørup wrote:
>>> Populating a mempool with objects is accounted for in the statistics.
>>> When analyzing mempool cache statistics, this may distort the data.
>>> In order to simplify mempool cache statistics analysis, a mempool
>>> statistics reset function was added.
>>>
>>> Furthermore, details about average burst sizes and mempool cache miss
>>> rates were added to the statistics shown when dumping a mempool.
>>>
>>> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
>>
>> I'd like to see thoughts about consistency after reset taking into
>> account that reset will likely to be done from control core whereas
>> stats are updated from data cores. Results could be very interesting.
>> I guess it is not the reason to introduce locking or any other kind
>> of synchronization, but user should be warned as the bare minimum.
> 
> When used for cache statistics analysis, the reset function will be called once only: After everything has been initialized (mempool created and populated, and ethdev Rx queues preloaded with mbufs), but before the data plane is started.

Thanks I see now. May be these assumptions should be mentioned in the
function description? Or is it too much?

> I don't think the end user should be warned; this may be normal behavior for an application.
> In addition to the trace event, I'll add a DEBUG level log message in the function.>>
> And a warning about potential inconsistency in the function description.

Sounds good.

> Good feedback, Andrew!
> 

