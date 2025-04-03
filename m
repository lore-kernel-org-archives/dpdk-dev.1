Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F00C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 13:45:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A096B4060C;
	Thu,  3 Apr 2025 15:45:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A8563402A0
 for <dev@dpdk.org>; Thu,  3 Apr 2025 15:45:10 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7653106F;
 Thu,  3 Apr 2025 06:45:11 -0700 (PDT)
Received: from [10.1.35.62] (JR4XG4HTQC.cambridge.arm.com [10.1.35.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 697D63F63F;
 Thu,  3 Apr 2025 06:45:08 -0700 (PDT)
Message-ID: <98bbf31f-adda-43e0-acbe-f4e4765883db@arm.com>
Date: Thu, 3 Apr 2025 14:45:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dts: include smoke tests in tests config
Content-Language: en-GB
To: Patrick Robb <probb@iol.unh.edu>, Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, npratte@iol.unh.edu, thomas.wilks@arm.com
References: <20250403023059.1762841-1-probb@iol.unh.edu>
 <20250403023059.1762841-2-probb@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250403023059.1762841-2-probb@iol.unh.edu>
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

Hi Patrick,

this looks good, easy and quick fix. I am afraid that you can't append 
to an `Iterable` type though. I've also confirmed this with mypy:

   Unsupported left operand type for + ("Iterable[TestSuiteConfig]")

I guess the easiest fix is to just change the argument type to `list` 
from `Iterable`.

Best,
Luca

