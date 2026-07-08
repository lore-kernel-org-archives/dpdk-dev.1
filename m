Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A952C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 17:25:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC228402CF;
	Wed,  8 Jul 2026 19:25:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 05E6940268
 for <dev@dpdk.org>; Wed,  8 Jul 2026 19:25:52 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3A611A9A;
 Wed,  8 Jul 2026 10:25:46 -0700 (PDT)
Received: from [10.57.80.210] (unknown [10.57.80.210])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13F533F905;
 Wed,  8 Jul 2026 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783531551; bh=B6D8J+9eai7qQ2BjdCSJJs0J0fteES5RtcEQeDUOCxg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pzzPcJ+ffoDRSALv5/e7YwtQgMxlULgHRdLY2bMplJV3WSnuSvLe/5yRRhL/Eszmz
 rqnTiuDB9L1oZa/fh8zkaz1XLXed2MhJmRwHkgNkzuuewgZjjcbaqyN0RqbMr1CXQ8
 0JmbOkOx2YsiBg7IrPs5pTP6yPdxUK78bM25uAuk=
Message-ID: <1fdd3b4a-32ad-4e6e-b0eb-20380b1e72b4@arm.com>
Date: Wed, 8 Jul 2026 18:25:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dts: update test suite names to be clear and consistent
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, knimoji@iol.unh.edu,
 ahassick@iol.unh.edu
References: <20260508141319.52648-1-abailey@iol.unh.edu>
 <20260511160013.78676-1-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260511160013.78676-1-abailey@iol.unh.edu>
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

Applies to next-dts, thanks
