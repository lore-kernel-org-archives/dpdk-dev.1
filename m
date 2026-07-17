Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C7FC44515
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 16:23:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C39140653;
	Fri, 17 Jul 2026 18:23:15 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 73A2440297
 for <dev@dpdk.org>; Fri, 17 Jul 2026 18:23:13 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 616A01476;
 Fri, 17 Jul 2026 09:23:08 -0700 (PDT)
Received: from [10.57.2.27] (unknown [10.57.2.27])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94CA13F905;
 Fri, 17 Jul 2026 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784305392; bh=pSUUQXu1pTRpoop0qlJtlsLGDkWQ7zG14idKfBwGBXw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZscXCARR2BxT2hKIgshUUmWSqYSn1otD2GKV/YcuylRJf6CM3M6jKleCCizF4KDNw
 hmv1Oj9xvwffrEoc7PS/NNsNAHXaO0IrgxkZ+GWSJ4VAjWWX3iezP5SUvz+Ovejtob
 T8T2cqDE+91hxhAXpzQVt88DDuXKYNGFEgJDP5js=
Message-ID: <843bf1cd-4094-4cc3-bdae-dd5a9840fa3c@arm.com>
Date: Fri, 17 Jul 2026 17:23:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dts: resolve variance in performance reporting
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>, patrickrobb1997@gmail.com,
 dev@dpdk.org
Cc: knimoji@iol.unh.edu, llavoie@iol.unh.edu
References: <20260717144933.515139-1-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260717144933.515139-1-abailey@iol.unh.edu>
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

Applied to next-dts with Claude's suggestion and a check to ensure that 
repetitions is always greater than 0.

Thanks!
