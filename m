Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62979CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 08:21:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D7294026A;
	Tue, 12 Aug 2025 10:21:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E882740264
 for <dev@dpdk.org>; Tue, 12 Aug 2025 10:21:08 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDFB42934;
 Tue, 12 Aug 2025 01:20:59 -0700 (PDT)
Received: from [10.57.2.91] (unknown [10.57.2.91])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7904F3F5A1;
 Tue, 12 Aug 2025 01:21:07 -0700 (PDT)
Message-ID: <5da4fdc1-a9ba-4180-b8c6-dbb20bd90607@arm.com>
Date: Tue, 12 Aug 2025 09:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dts: add artifact module
To: Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250725151503.87374-5-luca.vizzarro@arm.com>
 <CAJvnSUCHuZWuGbDokC8=qfQj=OXhPcA+36LMv5zVbVN-nTr6Ug@mail.gmail.com>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CAJvnSUCHuZWuGbDokC8=qfQj=OXhPcA+36LMv5zVbVN-nTr6Ug@mail.gmail.com>
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

On 12/08/2025 04:26, Patrick Robb wrote:
> Oh yeah - is there a reason why we don't call touch in the init 
> function? running touch should be idempotent so we aren't worried about 
> it being called too many times. I was reminded when I saw in the softnic 
> testsuite that it is being called in the testsuite setup. Maybe this is 
> extra work on the testsuite side for no reason.

The idea is that an artifact is just a definition of a file. We use the 
constructor to define one, and we use the methods to actually operatore 
on it. I originally implemented this behaviour, but there was a case – 
which I can't remember right now – where this wasn't wanted. Overall, it 
should be clearer to the test writer to calls operational methods 
explicitly.
