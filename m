Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F82EC87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 09:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3889940E22;
	Tue, 29 Jul 2025 11:51:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E619C40E21
 for <dev@dpdk.org>; Tue, 29 Jul 2025 11:50:59 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 652451516;
 Tue, 29 Jul 2025 02:50:51 -0700 (PDT)
Received: from [10.57.3.118] (unknown [10.57.3.118])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5083F66E;
 Tue, 29 Jul 2025 02:50:58 -0700 (PDT)
Message-ID: <f80063c1-a5a9-43c5-8284-4e1b2dfc8fef@arm.com>
Date: Tue, 29 Jul 2025 10:50:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dts: call hugepages configure at node setup
To: Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org
References: <20250725200553.1262542-1-probb@iol.unh.edu>
 <20250728213209.1834486-1-probb@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250728213209.1834486-1-probb@iol.unh.edu>
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

Hi Patrick,

thank you for the quick v2! I am afraid you may have placed the call in 
the class constructor instead of the setup method :')

Luca
