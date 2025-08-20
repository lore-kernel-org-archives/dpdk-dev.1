Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFF7CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 16:16:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA5C5402DD;
	Wed, 20 Aug 2025 18:16:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2D37E402CC
 for <dev@dpdk.org>; Wed, 20 Aug 2025 18:16:03 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E3B21D31;
 Wed, 20 Aug 2025 09:15:54 -0700 (PDT)
Received: from [10.1.30.49] (JR4XG4HTQC-2.cambridge.arm.com [10.1.30.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8C6F3F63F;
 Wed, 20 Aug 2025 09:16:01 -0700 (PDT)
Message-ID: <9b104aa4-c5e1-427a-ac23-6e196c9470d7@arm.com>
Date: Wed, 20 Aug 2025 17:16:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dts: add missing type hints to method signatures
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
References: <20250818165054.447127-1-abailey@iol.unh.edu>
 <20250820151850.484576-1-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250820151850.484576-1-abailey@iol.unh.edu>
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

thank you for your v4! Looks good now.

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>

On 20/08/2025 16:18, Andrew Bailey wrote:
> diff --git a/dts/framework/settings.py b/dts/framework/settings.py
> index 3f21615223..74dd96daa9 100644
> --- a/dts/framework/settings.py
> +++ b/dts/framework/settings.py
> @@ -251,13 +254,13 @@ def error(self, message):
>                   )
>   
>           print(f"{self.prog}: error: {message}\n", file=sys.stderr)
> -        self.exit(2, "For help and usage, " "run the command with the --help flag.\n")
> +        self.exit(2, "For help and usage," "run the command with the --help flag.\n")

nit: bad change, I can fix it myself (or Patrick) upon merging, so I 
wouldn't worry about it.

