Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD2DC83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 11:31:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A27F40430;
	Mon, 28 Jul 2025 13:31:54 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A2B064026C
 for <dev@dpdk.org>; Mon, 28 Jul 2025 13:31:52 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7DE2152B;
 Mon, 28 Jul 2025 04:31:43 -0700 (PDT)
Received: from [10.1.35.56] (JR4XG4HTQC-2.cambridge.arm.com [10.1.35.56])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C117B3F66E;
 Mon, 28 Jul 2025 04:31:50 -0700 (PDT)
Message-ID: <b46a313b-048f-4a16-a274-3db9342d48fb@arm.com>
Date: Mon, 28 Jul 2025 12:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: call hugepages configure at testrun setup
Content-Language: en-GB
To: Patrick Robb <probb@iol.unh.edu>
Cc: dmarx@iol.unh.edu, Paul.Szczepanek@arm.com, abailey@iol.unh.edu,
 mmahajan@iol.unh.edu, thomas.wilks@arm.com, dev@dpdk.org
References: <20250725200553.1262542-1-probb@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250725200553.1262542-1-probb@iol.unh.edu>
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

Really good catch Patrick! Thank you for this!

Would it make more sense to place setup_hugepages under Node.setup()?
In that case the method can also remain private, involving a single line 
change.

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
