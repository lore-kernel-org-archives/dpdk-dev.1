Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F034C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:52:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA66040649;
	Mon, 11 Aug 2025 12:52:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 54AA1400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:52:25 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F9C152B;
 Mon, 11 Aug 2025 03:52:16 -0700 (PDT)
Received: from [192.168.50.107] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 3B6963F63F; Mon, 11 Aug 2025 03:52:24 -0700 (PDT)
Message-ID: <24090f6e-eda9-4e47-ad87-8d083721a5ae@arm.com>
Date: Mon, 11 Aug 2025 11:52:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dts: type hints updated for method arguments and
 return types
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
References: <20250806162900.273571-1-abailey@iol.unh.edu>
 <9e6a703e-7662-401a-a318-235bdc0bd937@arm.com>
 <CABJ3N2XQ+B0hLroTPmj2dW+MQiE7O4SJ_oxUZ4oquFY=2--CcA@mail.gmail.com>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CABJ3N2XQ+B0hLroTPmj2dW+MQiE7O4SJ_oxUZ4oquFY=2--CcA@mail.gmail.com>
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

Forgot to mention that, like I originally said, the commit description 
is used to explain what you did and why you did it. The explanation 
you've just given me should naturally go in the commit description. This 
is so when one person reads your patch, everything is justified 
appropriately and in the future some code changes will be clearer.
