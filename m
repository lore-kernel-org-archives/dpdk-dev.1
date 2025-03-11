Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB12C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 11:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 647C84027F;
	Tue, 11 Mar 2025 12:35:54 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 001E940263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 12:35:52 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FED81063;
 Tue, 11 Mar 2025 04:36:03 -0700 (PDT)
Received: from [192.168.1.203] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 7A2723F673; Tue, 11 Mar 2025 04:35:49 -0700 (PDT)
Message-ID: <6fb3ef90-4af1-4c2d-acb3-97a4777cda58@arm.com>
Date: Tue, 11 Mar 2025 13:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dts: add tmp directory facility
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
 <20250224132823.196509-4-luca.vizzarro@arm.com>
 <CABD7UXNmGggR7MMysLVcyF=80WzOaee-eDcenVgFNoThrdPa4A@mail.gmail.com>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CABD7UXNmGggR7MMysLVcyF=80WzOaee-eDcenVgFNoThrdPa4A@mail.gmail.com>
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

On 05/03/2025 23:29, Dean Marx wrote:
> This makes sense, I noticed though that nothing is actually stored in
> these placeholder directories yet, and dpdk is built in a separate
> folder. Is the plan in the future to move this to the placeholder
> directory? Or is there a different use case?
> 
> Reviewed-by: Dean Marx <dmarx@iol.unh.edu>

This is used in this patch series in `dts: enable build-less DPDK driver 
binding`. But yes the plan is to move everything to use a dedicated tmp 
folder. We don't want stray files/folders.
