Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9395AC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:18:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDD1140EE4;
	Tue, 17 Jun 2025 17:18:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DDE33402C5
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:18:16 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 329BF150C;
 Tue, 17 Jun 2025 08:17:55 -0700 (PDT)
Received: from [10.1.27.84] (JR4XG4HTQC.cambridge.arm.com [10.1.27.84])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6715D3F673;
 Tue, 17 Jun 2025 08:18:15 -0700 (PDT)
Message-ID: <8b266009-ff64-4052-aadc-9364159f8702@arm.com>
Date: Tue, 17 Jun 2025 16:18:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dts: fix devbind initialization bug
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250612201220.614724-1-dmarx@iol.unh.edu>
 <20250616183859.646384-1-dmarx@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250616183859.646384-1-dmarx@iol.unh.edu>
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

Looks good to me. just a small nit:

On 16/06/2025 19:38, Dean Marx wrote:
> +        test_run.ctx.topology.setup()
> +        self.test_run.ctx.topology.configure_ports("sut", "dpdk")

no need to do `self.` here. Outside of this:

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
