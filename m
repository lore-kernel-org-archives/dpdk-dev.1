Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD451C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 11:17:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F1824042E;
	Mon, 11 Aug 2025 13:17:21 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0D4BF4013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 13:17:21 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 260201D13;
 Mon, 11 Aug 2025 04:17:12 -0700 (PDT)
Received: from [10.57.2.91] (unknown [10.57.2.91])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABBE33F63F;
 Mon, 11 Aug 2025 04:17:19 -0700 (PDT)
Message-ID: <4a3540f3-7756-4300-b62c-405b20c8f4fa@arm.com>
Date: Mon, 11 Aug 2025 12:17:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dts: introduce abstract class for TG and SUT DPDK
 runtime environments
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
References: <20250808182152.356879-1-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250808182152.356879-1-abailey@iol.unh.edu>
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

I am not sure where these changes stem from. From my understanding, this 
enforces the creation of a DPDK environment for the TG, regardless if 
it's needed or not.

The only scenario I can think of this being useful is when paired with 
T-Rex. But like I've mentioned before, since the TG node is managed by 
the traffic generator class, I don't see why DTS should concern itself 
to setting up DPDK on the TG.

Logically, what I am thinking is that if T-Rex has an underlying DPDK 
requirement, then it should be the duty of the T-Rex Traffic Generator 
class to manage this. This behaviour should be agnostic to the overall 
test run, who should only care about our DPDK testing environment and a 
traffic generator.

Please let me know if I am missing something.
