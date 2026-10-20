Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14EB606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=reZaf8vo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 099184064C;
	Tue, 20 Oct 2026 19:53:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 508B140151
 for <dev@dpdk.org>; Tue, 20 Oct 2026 19:53:07 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 562F31576;
 Tue, 20 Oct 2026 10:53:03 -0700 (PDT)
Received: from [10.57.15.12] (unknown [10.57.15.12])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6C503F7B4;
 Tue, 20 Oct 2026 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792518786; bh=APIJFGo8uu9fZPtn31DKlUOrHP5VtEq1QYlN+bxYOlo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=reZaf8vo6AXNRY4ELlR73xdh4jCdaygpLdiXSCYaWVaHrmmlw8UQqpkpLG4fPA402
 zBHAIK83AFIOayREOFtokEEEH/1zxq56XxJwS4f98Wmi1ddmYNjCxQS4f5Yn7RM2Wl
 4KZNwk3Qof69dhTCEvZjMcer3OvwNjO3Bi4llEEA=
Message-ID: <5c257d44-cff7-4ac8-acdc-90791884f8ec@arm.com>
Date: Tue, 20 Oct 2026 18:53:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dts: remove crypto test type
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com, dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260806164505.642928-1-abailey@iol.unh.edu>
 <20261019201342.903235-1-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261019201342.903235-1-abailey@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

This changes look mostly ok to me. Can you address the issues raised by 
the AI review for me?

Also the example file wasn't updated to remote the crypto field.

Best,
Luca
