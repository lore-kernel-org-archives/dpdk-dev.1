Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BBBCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 17:46:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DD47402E2;
	Mon,  6 Oct 2025 19:46:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 54455402D1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 19:46:02 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CF861515
 for <dev@dpdk.org>; Mon,  6 Oct 2025 10:45:53 -0700 (PDT)
Received: from [10.122.1.97] (unknown [10.122.1.97])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92DA93F66E
 for <dev@dpdk.org>; Mon,  6 Oct 2025 10:46:01 -0700 (PDT)
Message-ID: <9428c18d-fec7-4400-a4f3-b2614b7fb058@arm.com>
Date: Mon, 6 Oct 2025 12:46:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mbuf: optimize segment prefree
To: dev@dpdk.org
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20250827161726.24cebd9c@hermes.local>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20250827161726.24cebd9c@hermes.local>
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


On 8/27/25 18:17, Stephen Hemminger wrote:
> On Wed, 27 Aug 2025 21:35:34 +0000
> Morten Brørup <mb@smartsharesystems.com> wrote:
>
>>   
>> +/* GCC only optimizes single-bit MSB tests this way, so do it by hand with multi-bit. */
>> +#if defined(RTE_TOOLCHAIN_GCC) && defined(RTE_ARCH_X86)
>> +#undef RTE_MBUF_DIRECT
>> +#define RTE_MBUF_DIRECT(mb) \
>> +	(!(((const uint8_t *)(mb))[offsetof(struct rte_mbuf, ol_flags) + 7] & \
>> +	(uint8_t)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> 56)))
>> +#endif
> Complex enough expression that I would prefer this be an inline function
> with some more temporary variables and more comments.
> Like the magic 7 for mask??

+1

--wathsala

