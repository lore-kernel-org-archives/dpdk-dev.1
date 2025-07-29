Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A981DC87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 12:26:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68B8A4026C;
	Tue, 29 Jul 2025 14:26:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 59863400D5
 for <dev@dpdk.org>; Tue, 29 Jul 2025 14:26:56 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 775871516;
 Tue, 29 Jul 2025 05:26:47 -0700 (PDT)
Received: from [10.57.3.118] (unknown [10.57.3.118])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AA863F673;
 Tue, 29 Jul 2025 05:26:54 -0700 (PDT)
Message-ID: <0c3b2d19-8d0a-439f-8dcd-5ac6c8f7af59@arm.com>
Date: Tue, 29 Jul 2025 13:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dts: rewrite two link topology requirements
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250722171901.199958-1-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250722171901.199958-1-dmarx@iol.unh.edu>
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

Thank you for this! Could you please group this patch with the one link 
default one[1], in which case the @requires decorator here could be 
removed altogether?

Best,
Luca

[1] 
https://patches.dpdk.org/project/dpdk/patch/20250723135021.218084-1-dmarx@iol.unh.edu/
