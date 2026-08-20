Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FEC5DF89
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E574E40685;
	Thu, 20 Aug 2026 16:04:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C3CDC40616
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:04:35 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 351B9153B;
 Thu, 20 Aug 2026 07:04:31 -0700 (PDT)
Received: from [10.1.36.55] (JR4XG4HTQC.cambridge.arm.com [10.1.36.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB50B3F85F;
 Thu, 20 Aug 2026 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787234675; bh=N1Nbf7TqK+ndwEB2B03QYD4x9FABuWNHKmP3Tf6S/f8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WFrOK0hIGOHi2joFr4qWjcZo3EtpSgzsdsJNOAML61fbZyONX2YMwef0TaQWhPAa9
 PZ4C+/lYfn5AxMPwx3g1z0XMv4gnARKVVf62xjJpdul0qC4HM+3TsgDBSVd9Y81oiz
 390eGwwH8bj3Ut37zeGtFHBw+yfzi57PPUuzBslM=
Message-ID: <bb5e1cb6-22f7-459b-b965-a6fc9a6035b5@arm.com>
Date: Thu, 20 Aug 2026 15:04:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] dts: remove imports from framework in test suites
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Dean Marx <dmarx@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260807161642.122310-1-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260807161642.122310-1-abailey@iol.unh.edu>
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

This still needs some refinement. I couldn't give a more thorough review 
because I can't apply it on main so it also needs some rebasing.

I see the CI also fails on the imports, so that also needs fixing.

Luca
