Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BABC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 11:33:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DCDF4027F;
	Tue, 11 Mar 2025 12:33:45 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6298840263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 12:33:44 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E239A152B;
 Tue, 11 Mar 2025 04:33:54 -0700 (PDT)
Received: from [192.168.1.203] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 C46583F673; Tue, 11 Mar 2025 04:33:42 -0700 (PDT)
Message-ID: <277e2496-42ed-4995-8e93-3d73220f2db6@arm.com>
Date: Tue, 11 Mar 2025 13:33:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dts: use topology in smoke tests
To: Dean Marx <dmarx@iol.unh.edu>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
 <20250224132823.196509-3-luca.vizzarro@arm.com>
 <CABD7UXNL5n0EKxh_XiM+N6jWjCmw_mdY5KH8_hupGsENt5P-dQ@mail.gmail.com>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CABD7UXNL5n0EKxh_XiM+N6jWjCmw_mdY5KH8_hupGsENt5P-dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 05/03/2025 23:26, Dean Marx wrote:
> On Mon, Feb 24, 2025 at 8:30 AM Luca Vizzarro <luca.vizzarro@arm.com> wrote:
>> The smoke tests where wrongly using all the node's ports for the smoke
>> tests. Ensure only the ports specified in the current topology are used.
> <snip>
>
> Should be were, not where
argh, good catch! thank you!
>
>> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
>> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> Reviewed-by: Dean Marx <dmarx@iol.unh.edu>


