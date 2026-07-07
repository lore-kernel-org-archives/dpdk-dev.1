Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48772C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 12:01:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51FD440264;
	Tue,  7 Jul 2026 14:01:37 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 619A44025F;
 Tue,  7 Jul 2026 14:01:36 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DCE6176A;
 Tue,  7 Jul 2026 05:01:31 -0700 (PDT)
Received: from [192.168.100.239] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D23073FAF5;
 Tue,  7 Jul 2026 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783425695; bh=JXZYh6YweU/wf+WTZxpF6ouccDZJNejBnf8jRXSB0rk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uKSLUIRYME5nWflkvDHGJSNjLSm/dWIfcybG+skH1tlGyndJhlNJ7fTF9gC9JrO6V
 Zjx6Jal6QscyMKdSMkn1pW4/r7NkMz2yggLEx6EVL5nhgfyxayhWzwIosFGNz8LIR0
 ZfBR8ALytlPcnYtdPRYy8J872qt3J7gCBIdoyMbc=
Message-ID: <da926a64-c2f1-4471-b147-071e1362079c@arm.com>
Date: Tue, 7 Jul 2026 13:01:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: fix topology capability comparison
Content-Language: en-GB
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Cc: stable@dpdk.org, Patrick Robb <probb@iol.unh.edu>,
 Dean Marx <dmarx@iol.unh.edu>, =?UTF-8?Q?Juraj_Linke=C5=A1?=
 <juraj.linkes@pantheon.tech>, Jeremy Spewock <jspewock@iol.unh.edu>
References: <20260510194935.182258-1-thomas@monjalon.net>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260510194935.182258-1-thomas@monjalon.net>
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

Thank you Thomas for this fix. Looks good to me

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
