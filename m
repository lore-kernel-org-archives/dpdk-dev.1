Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8922EC3ABCC
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 15:42:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97488402DC;
	Wed, 14 May 2025 17:42:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 3FE60402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 17:42:05 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EFD2150C;
 Wed, 14 May 2025 08:41:53 -0700 (PDT)
Received: from [10.1.26.67] (JR4XG4HTQC.cambridge.arm.com [10.1.26.67])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 988EB3F5A1;
 Wed, 14 May 2025 08:42:03 -0700 (PDT)
Message-ID: <251e5f57-9a4b-49b3-a495-3f8444e365b4@arm.com>
Date: Wed, 14 May 2025 16:42:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] change verification field in unified packet suite
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu, npratte@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250306214747.579340-1-dmarx@iol.unh.edu>
 <20250306214747.579340-5-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250306214747.579340-5-dmarx@iol.unh.edu>
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

The changes look fine, so this is for them:

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>

But the commit subject/body need amendment. The `dts: ` component prefix 
is missing in the subject

On 06/03/2025 22:47, Dean Marx wrote:
> Changes the unified packet testing suite to use layer 4
> destination ports as packet verification IDs.

and the body is not following an imperative form. This actually also 
applies for the commit 2/4.
