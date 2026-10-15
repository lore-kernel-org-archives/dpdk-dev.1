Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF164CC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 16:29:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEC4B402F0;
	Thu, 15 Oct 2026 18:29:19 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7DF11402DF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 18:29:18 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88CA614BF;
 Thu, 15 Oct 2026 09:29:14 -0700 (PDT)
Received: from [10.57.10.51] (unknown [10.57.10.51])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50A173F871;
 Thu, 15 Oct 2026 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792081757; bh=TpO6HQF1NDqzpOPP+/PpnJrLOiGMeec3dWvip/VdBBk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hSCVy9qIYeb0c03YOZ/Yh1SsJ2Xd8gYBxlz2JnhtwFN3ikM0PZK5E1i55jgPOp/bX
 7KSOfodTmau4iGJ6buHBEcP4zxVa51Es9oTJOQF1crhtgrCBdZV4jIzxflSAWSnVWP
 9WJJUIWussVHZmDRSrjn/O99JXbFtsioLQ4Zog68=
Message-ID: <f5ca583d-eefc-4817-bdf2-5c482d0d1459@arm.com>
Date: Thu, 15 Oct 2026 17:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] dts: remove imports from framework in test suites
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Dean Marx <dmarx@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260902181333.461556-1-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260902181333.461556-1-abailey@iol.unh.edu>
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

thank you for this. Merged with minor changes (some missed doc bits) and 
a random print.

Luca
