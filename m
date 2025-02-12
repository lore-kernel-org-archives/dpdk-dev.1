Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EA8C021A4
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:47:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F92342DBB;
	Wed, 12 Feb 2025 17:47:41 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 03BD942D9D
 for <dev@dpdk.org>; Wed, 12 Feb 2025 17:47:39 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C5B512FC;
 Wed, 12 Feb 2025 08:47:59 -0800 (PST)
Received: from [10.57.11.32] (unknown [10.57.11.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9B1A3F5A1;
 Wed, 12 Feb 2025 08:47:37 -0800 (PST)
Message-ID: <ea754e1e-62e0-47df-b649-0572f163d745@arm.com>
Date: Wed, 12 Feb 2025 16:47:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] dts: revamp framework
Content-Language: en-GB
To: dev@dpdk.org
Cc: Nicholas Pratte <npratte@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>, Paul Szczepanek <paul.szczepanek@arm.com>
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250212164600.23759-1-luca.vizzarro@arm.com>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250212164600.23759-1-luca.vizzarro@arm.com>
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

Forgot to mention that I've also removed the distinction between SUT and 
TG nodes. These are now all the same nodes. Runtime configuration for 
DPDK and TG now lies within the test run.
