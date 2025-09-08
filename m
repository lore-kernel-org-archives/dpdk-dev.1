Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C671CA1013
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 10:03:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E1D040264;
	Mon,  8 Sep 2025 12:03:42 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 036A2400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 12:03:41 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 196F31BCA;
 Mon,  8 Sep 2025 03:03:32 -0700 (PDT)
Received: from [10.57.57.199] (unknown [10.57.57.199])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9C93F66E;
 Mon,  8 Sep 2025 03:03:39 -0700 (PDT)
Message-ID: <77838cba-0bf4-4764-8094-664265162081@arm.com>
Date: Mon, 8 Sep 2025 11:03:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: add dpdk shell warm up period
To: Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu
References: <20250908014154.82938-1-probb@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250908014154.82938-1-probb@iol.unh.edu>
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

Perfectly understand the situation, I am just afraid that adding a whole 
5 seconds every time an InteractiveShell is spawned may slow down 
everything by a lot. These are spawned a lot of times, so it will stack 
up. Is there no other way to test for readiness?

Also I think we are providing the ability to run shells outside the 
context manager as well for some scenarios where it's needed, so this 
approach won't cover that case unfortunately.

Best,
Luca
