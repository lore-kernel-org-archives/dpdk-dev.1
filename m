Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C15C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:52:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D66942DDE;
	Wed, 12 Feb 2025 17:52:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A2CF542DBB
 for <dev@dpdk.org>; Wed, 12 Feb 2025 17:52:47 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0D8E12FC;
 Wed, 12 Feb 2025 08:53:07 -0800 (PST)
Received: from [10.57.11.32] (unknown [10.57.11.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 672C43F5A1;
 Wed, 12 Feb 2025 08:52:46 -0800 (PST)
Message-ID: <41dd3fe7-ca21-4975-82ad-1149142ce06f@arm.com>
Date: Wed, 12 Feb 2025 16:52:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] dts: revamp framework
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <CABD7UXP1rU9ZC8uQK33B4H5QR6noQiu9agwR1yapEOpn81EZ5Q@mail.gmail.com>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CABD7UXP1rU9ZC8uQK33B4H5QR6noQiu9agwR1yapEOpn81EZ5Q@mail.gmail.com>
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

On 04/02/2025 21:08, Dean Marx wrote:
> Hi Luca,
> 
> I saw in the meeting minutes that the main purpose of this series is
> to implement the separation of concern principle better in DTS. Just
> wondering, what parts of the current framework did you think needed to
> be separated and why? I'm taking an OOP class this semester and we
> just started talking in depth about separation of concerns, so if you
> wouldn't mind I'd be interested in your thought process. Working on a
> review for the series currently as well, should be done relatively
> soon.
> 
> Thanks,
> Dean

Hi Dean,

For starters all the major logic was held within the `runner.py` file, 
which is not ideal. When some logic touches the same object too often, 
maybe its an indicator that it actually belongs to that class instead. 
For example, the test suite and cases are configured within the 
configuration. Anything configuration should be kept within the 
configuration, the runner should assume that the configuration is final 
and is ready to be fed to the classes. For this reason, I've moved the 
test suite and cases filtering logic there. Test runs are a whole 
concept on their own, and they have their own logic. For this reason it 
is a better idea to have them individually in their own dedicated class 
where they can control themselves. As opposed to having a runner.py 
basically dealing with every part of the framework in the same place. If 
you were to make a graph with all the linked classes to runner.py, I am 
sure it'd look like spaghetti. We don't want that. We want a hierarical 
and structured approach. Separation of concerns will aid this by keeping 
things where they belong, minimising import/export. This will also help 
with circular import issues.

Hope this provides some insight!

Luca
