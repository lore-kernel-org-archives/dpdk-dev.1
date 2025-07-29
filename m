Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF5AC87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 12:46:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50E344026C;
	Tue, 29 Jul 2025 14:46:21 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0509C400D5
 for <dev@dpdk.org>; Tue, 29 Jul 2025 14:46:19 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 773631516;
 Tue, 29 Jul 2025 05:46:10 -0700 (PDT)
Received: from [10.57.3.118] (unknown [10.57.3.118])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 382663F673;
 Tue, 29 Jul 2025 05:46:17 -0700 (PDT)
Message-ID: <d1d7de1e-0499-404f-978e-993e9942fc59@arm.com>
Date: Tue, 29 Jul 2025 13:46:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dts: add steps and verify sections to docstrings
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250722171957.200698-1-dmarx@iol.unh.edu>
 <20250722171957.200698-2-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250722171957.200698-2-dmarx@iol.unh.edu>
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

This is fine by me, but it's subject to the discussion I've initiated in 
the earlier email.

As you can actually see, some of the test suites here used unordered 
lists (bullet points) to render the steps.
