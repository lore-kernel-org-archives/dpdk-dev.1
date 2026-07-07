Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A9FC43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 12:43:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E66240264;
	Tue,  7 Jul 2026 14:43:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DA5524025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 14:43:49 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA7721713;
 Tue,  7 Jul 2026 05:43:44 -0700 (PDT)
Received: from [192.168.100.239] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 128F73F7B4;
 Tue,  7 Jul 2026 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783428229; bh=5T8vPFcAHjhz0ar3MF1gFbK7BdX28qS8j6abpaBsxlg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HO7npVZ5opqBi+TpYNtKQC4E47JVQqXMxMpAvDOlk1VBizSyyPvweCJ1w7zMQF8c2
 wka5XnA90oJnFPBkOFQcwUHoZbY1xZaK4Pw89qteW4gu2TU93/4lQnQHPxhVz9mLDL
 G1VIxCCL4KmFLxJshu+83d5/hbGAAoDCrDyYSt0I=
Message-ID: <e135faa6-020a-42f1-a09f-e21e90dde010@arm.com>
Date: Tue, 7 Jul 2026 13:43:42 +0100
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

Looks ok to me. Thank you Andrew.

The only thing I'd suggest is to use `git mv` next time you rename 
files. The diff is quite chaotic and not easy to read unfortunately.

I would prefer if you were to send a v5 doing that just to be extra sure 
that no bugs were introduced in the process.

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
