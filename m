Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4267C87FD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 12:31:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9865B40BA4;
	Tue,  5 Aug 2025 14:31:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8CA9F40A4B
 for <dev@dpdk.org>; Tue,  5 Aug 2025 14:31:02 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E20E6150C;
 Tue,  5 Aug 2025 05:30:53 -0700 (PDT)
Received: from [10.1.30.58] (JR4XG4HTQC-2.cambridge.arm.com [10.1.30.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D6943F738;
 Tue,  5 Aug 2025 05:31:01 -0700 (PDT)
Message-ID: <1d393fdc-6fd7-43fa-a4b9-3e2fe1c319a9@arm.com>
Date: Tue, 5 Aug 2025 13:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: update hinted return types of various methods
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
References: <20250804200019.219458-1-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250804200019.219458-1-abailey@iol.unh.edu>
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

Hi Andrew,

you may have noticed that the CI failed. It is worth running the 
following scripts prior to submitting:

- devtools/dts-check-format.py (in a Poetry environment)
- devtools/checkpatches.sh
- devtools/check-git-log.sh

mypy specifically fails in some occasions because of missed faults as a 
consequence of disabled type checking. It'd be really appreciated if you 
could also tackle these type issues with your patch.

Best,
Luca
