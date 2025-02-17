Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FC2C0219E
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 10:26:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45425400D6;
	Mon, 17 Feb 2025 11:26:26 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 11432400D5
 for <dev@dpdk.org>; Mon, 17 Feb 2025 11:26:24 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73F22175D;
 Mon, 17 Feb 2025 02:26:43 -0800 (PST)
Received: from [10.57.11.32] (unknown [10.57.11.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 677D03F6A8;
 Mon, 17 Feb 2025 02:26:23 -0800 (PST)
Message-ID: <1e3962f9-65f4-414c-8270-f665b06ae52e@arm.com>
Date: Mon, 17 Feb 2025 10:26:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] dts: revamp runtime internals
Content-Language: en-GB
To: Nicholas Pratte <npratte@iol.unh.edu>
Cc: dev@dpdk.org, Dean Marx <dmarx@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250212164600.23759-1-luca.vizzarro@arm.com>
 <20250212164600.23759-7-luca.vizzarro@arm.com>
 <CAKXZ7eh5EHbJ1mNEQ2+ht-8R67CrM-dqSCzR2kGP6nEC0O33Kw@mail.gmail.com>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CAKXZ7eh5EHbJ1mNEQ2+ht-8R67CrM-dqSCzR2kGP6nEC0O33Kw@mail.gmail.com>
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

On 14/02/2025 18:54, Nicholas Pratte wrote:
> This definitely cleans things up a lot!
> 
> Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>
> 
> <snip>
>> @@ -217,9 +218,7 @@ def get_supported_capabilities(
>>           )
>>           if cls.capabilities_to_check:
>>               capabilities_to_check_map = cls._get_decorated_capabilities_map()
>> -            with TestPmdShell(
>> -                sut_node, privileged=True, disable_device_start=True
>> -            ) as testpmd_shell:
>> +            with TestPmdShell() as testpmd_shell:
> 
> This is probably a needless concern, but should this change
> technically be in the last patch in order for it to stand on its own?
> Not sure if that really matters or not, but figured I'd bring it up.

No, not really, because the API change happens here. I removed 
privileged because it's redundant, and disabled_device_start as it 
seemed problematic for some things. We should handle commands stop the 
ports with @require_stopped_ports, so that we have a consistent 
execution. This is how I discovered the problem with the Mellanox and 
the MTU setting.
