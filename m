Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF7FC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:13:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A88040673;
	Mon, 11 Aug 2025 12:13:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6B26A400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:13:09 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85DE1152B;
 Mon, 11 Aug 2025 03:13:00 -0700 (PDT)
Received: from [192.168.50.107] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 1BCC23F738; Mon, 11 Aug 2025 03:13:07 -0700 (PDT)
Message-ID: <87039a93-a29f-4692-8e35-f7c2e1509deb@arm.com>
Date: Mon, 11 Aug 2025 11:13:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dts: type hints updated for method arguments and
 return types
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
References: <20250806162900.273571-1-abailey@iol.unh.edu>
 <9e6a703e-7662-401a-a318-235bdc0bd937@arm.com>
 <CABJ3N2XQ+B0hLroTPmj2dW+MQiE7O4SJ_oxUZ4oquFY=2--CcA@mail.gmail.com>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CABJ3N2XQ+B0hLroTPmj2dW+MQiE7O4SJ_oxUZ4oquFY=2--CcA@mail.gmail.com>
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

On 08/08/2025 21:49, Andrew Bailey wrote:
> Thank you Luca for the review,
> 
> Regarding the changes to the enum in utils.py, adding type hints to the 
> extension method revealed an underlying issue with its interaction with 
> mypy. Using self.none.value within the return fstring causes an error 
> and I will send the details over slack shortly. I had tried to get 
> around this by not calling value on none but could not maintain the 
> functionality of this method while simultaneously keeping mypy happy. 
> Within my patch is the only solution that I had that worked, where 
> calling self.tar.value was fine with the linter when using auto().
> 
> Regards,
> Andrew

Oh I see,

In cases like these the problem is not changing up the current 
definitions :D, but figure out why the problem is happening.

It looks like this is happening because we are trying to access another 
enum member from the instance instead of the class. This should solve it:

   none = type(self).none

for readability's sake you can also split it across multiple lines 
instead of the inline if.

A note for future replies, a mailing list should be treated like an 
online forum. If we quote the entire message, and that message also has 
more quotes under it, the thread will become quite congested and hard to 
read. On forums we quote a part of the post and reply directly beneath 
it, as it follows the logical reading order. This is referred to as 
bottom posting. There is also the part where a lot of junk will fill up 
the mailing list archive and the maintainers won't be happy. There is 
this resource which is concise that I highly recommend:

   https://useplaintext.email

When you have the time please review the kernel's contribution 
guidelines on which the DPDK contribution guidelines expand on:

   https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Best regards,
Luca
