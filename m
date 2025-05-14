Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0494AC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 15:37:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09120402DC;
	Wed, 14 May 2025 17:37:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9E974402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 17:37:11 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A546B150C;
 Wed, 14 May 2025 08:36:59 -0700 (PDT)
Received: from [10.1.26.67] (JR4XG4HTQC.cambridge.arm.com [10.1.26.67])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB0093F5A1;
 Wed, 14 May 2025 08:37:09 -0700 (PDT)
Message-ID: <24088821-c762-47b4-88f9-8e36312016e9@arm.com>
Date: Wed, 14 May 2025 16:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] dts: add layer 4 port field to verbose parser
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu, npratte@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250306214747.579340-1-dmarx@iol.unh.edu>
 <20250306214747.579340-2-dmarx@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250306214747.579340-2-dmarx@iol.unh.edu>
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

looks good to me. Just a minor optional nit.

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>

On 06/03/2025 22:47, Dean Marx wrote:
> +    #:
> +    l4_dport: int | None = field(
> +        default=None,
> +        metadata=TextParser.find_int(r"(?:Destination TCP port=|Destination UDP port=)(\d+)"),
> +    )

the regex can be simplified:

   r"Destination (?:TCP|UDP) port=(\d+)"
