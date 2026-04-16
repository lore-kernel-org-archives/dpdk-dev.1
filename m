Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36DBF8A14D
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 10:50:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B20CF402B0;
	Thu, 16 Apr 2026 12:50:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id B437640297
 for <dev@dpdk.org>; Thu, 16 Apr 2026 12:50:54 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AAE425E1;
 Thu, 16 Apr 2026 03:50:48 -0700 (PDT)
Received: from [192.168.100.251] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90E2A3F7D8;
 Thu, 16 Apr 2026 03:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776336654; bh=N2UArgH+UV8c1WURS9VvvO/b4DEjYh7IK1HCkUwxK/A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=m8rjrq9ITPCvrkkjQi0GqSFuKc5aPf+xgMmgsXTuZU3R5SLQ6El/jGjBIPrxUmuuT
 I1ONDgwmS0j3paKU2BpgHZpIeF+jizf7J7PnpXm/2xzzLoIwARYjEzSyb1Na9Q47Ym
 4giZCZk+wqK2U09L00OIRXr+6CPYYvDQfUwCcCSE=
Message-ID: <8033150d-2ce1-488a-a7cf-841791a78ed4@arm.com>
Date: Thu, 16 Apr 2026 11:50:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: ConfigurationError not thrown due to lack of next
 default value
To: Riley Fletcher <rileyf@linux.ibm.com>
Cc: dev@dpdk.org, patrickrobb1997@gmail.com
References: <20260414152116.277497-1-rileyf@linux.ibm.com>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260414152116.277497-1-rileyf@linux.ibm.com>
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

Hi Riley,

Thank you for this fix! Looks good to me, this is obviously a bug. It 
needs the Fixes tag referencing the original commit, so that it can be 
retrospectively fixed on the LTS versions. The CI would complain about 
this if the commit subject would be correctly phrased to something like:

   dts: fix port info getter when port is not found

Luca
