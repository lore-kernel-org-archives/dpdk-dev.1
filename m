Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD02CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 17:30:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EFEC402B7;
	Mon,  3 Nov 2025 18:30:31 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8D9CB40270
 for <dev@dpdk.org>; Mon,  3 Nov 2025 18:30:29 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16EC01D14;
 Mon,  3 Nov 2025 09:30:21 -0800 (PST)
Received: from [10.122.34.113] (unknown [10.122.34.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96CFE3F66E;
 Mon,  3 Nov 2025 09:30:28 -0800 (PST)
Message-ID: <b435dd1d-c56f-4d56-9f73-30ee1ec99eac@arm.com>
Date: Mon, 3 Nov 2025 11:30:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] eal: correct memory ordering in MCS lock
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org,
 Ola Liljedahl <ola.liljedahl@arm.com>, vattunuru@marvell.com
References: <20251023184724.1759497-1-wathsala.vithanage@arm.com>
 <f08a5a55-2a46-4f8c-9658-f7c320de57f2@arm.com>
 <20251103090717.2d181d95@phoenix>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20251103090717.2d181d95@phoenix>
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


On 11/3/25 11:07, Stephen Hemminger wrote:
> On Mon, 3 Nov 2025 09:12:39 -0600
> Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:
>
>> MCS lock is broken, it's just a matter of time it will run into a deadlock.
>>
>> drivers/dma/cnxk is a user of MCS lock.
> I am surprised that a driver would use mcslock.
> MCSlock is targeted at case of large number of CPU's with lots of contention.
> It will likely be slower than spinlock or ticketlock for the use case of driver.
It appears in |drivers/dma/cnxk/cnxk_dmadev_fp.c|, perhaps the 
maintainer can clarify.


