Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C7ACCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 23:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 794F340280;
	Wed,  5 Nov 2025 00:30:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 27B7A40269
 for <dev@dpdk.org>; Wed,  5 Nov 2025 00:30:27 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5844F175D;
 Tue,  4 Nov 2025 15:30:18 -0800 (PST)
Received: from [10.118.106.37] (u104515.arm.com [10.118.106.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E90233F66E;
 Tue,  4 Nov 2025 15:30:25 -0800 (PST)
Message-ID: <88e99e93-6633-40ca-99ea-ab1b9343092b@arm.com>
Date: Tue, 4 Nov 2025 17:30:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] eal: correct memory ordering in MCS lock
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org,
 Ola Liljedahl <ola.liljedahl@arm.com>
References: <20251023184724.1759497-1-wathsala.vithanage@arm.com>
 <20251103154846.07be1aa0@phoenix>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20251103154846.07be1aa0@phoenix>
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


On 11/3/25 17:48, Stephen Hemminger wrote:
> On Thu, 23 Oct 2025 18:47:24 +0000
> Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:
>
>> Fix incorrect memory ordering in the MCS lock implementation by
>> adding proper synchronizing edges to establish clear happens-before
>> relationships between threads invoking lock() and unlock(). These
>> synchronizing edges prevent potential deadlocks caused by improper
>> ordering and are documented in detail through in-code comments.
>>
>> The previously relaxed load of the successor’s lock object pointer
>> in unlock() has been upgraded to a load-acquire operation. This
>> change ensures that the successor’s initialization does not
>> overwrite the current lock holder’s update to the locked field,
>> which could otherwise lead to deadlocks.
>>
>> Remove two unnecessary fences:
>>
>> The acquire fence in unlock() had no matching release fence, making
>> it ineffective for enforcing memory order. The associated comment
>> suggested it prevented speculative reordering, but such fences (data
>> memory barriers) only establish memory ordering and do not control
>> instruction speculation.
>>
>> The release-acquire fence pair in lock() was previously justified as
>> preventing reordering between the load-acquire loop of me->locked
>> and the store-release of prev->next. This is no longer needed, as the
>> new synchronizing edges ensure a chain of happens-before
>> relationships between memory operations of threads calling lock() and
>> unlock().
>>
>> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
>> Reviewed-by: Ola Liljedahl <ola.liljedahl@arm.com>
> Thanks for the good explanatory comments.
>
> Could you please add a Fixes: tag and Cc: stable@dpdk.org
> so it can go to the right stable releases as well.
>
> I noticed that Progress64 has same effective code.
>
Yes, the P64 MCS implementation is aligned with the DPDK version
after these changes.
Ola’s verification tool confirms that the P64 implementation is correct,
so this should be correct as well.
