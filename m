Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D283108B8E9
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 10:41:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F092402B2;
	Fri, 20 Mar 2026 11:41:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9D4F940272
 for <dev@dpdk.org>; Fri, 20 Mar 2026 11:41:10 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C822E1682;
 Fri, 20 Mar 2026 03:41:03 -0700 (PDT)
Received: from [10.57.12.84] (unknown [10.57.12.84])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAB4D3F778;
 Fri, 20 Mar 2026 03:41:08 -0700 (PDT)
Message-ID: <2e433dc1-2dbc-422b-911f-bb633350fed7@arm.com>
Date: Fri, 20 Mar 2026 10:41:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dts: update overall result pass/skip logic
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org, Andrew Bailey <abailey@iol.unh.edu>
References: <20260313155601.112819-1-dmarx@iol.unh.edu>
 <20260313182240.130379-1-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260313182240.130379-1-dmarx@iol.unh.edu>
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

Hi Dean,

Thank you for your patch. I agree with Patrick on this one. The overall 
result is indeed obtained by doing max on the results, which would yield 
the maximum severity found. Technically speaking we could indeed say 
that SKIP is less severe or important than PASS.

If we have a test suite with only SKIP the max will be SKIP, if we have 
a test suite with SKIP and PASS, the max will be PASS.

The rest of the logic would remain unchanged, meaning that if we have 
SKIP, PASS, FAIL, then the max will still be FAIL.

Therefore, I agree that the solution to this is as simple as re-ordering 
the IntEnum, by swapping SKIP and PASS.

Best,
Luca
