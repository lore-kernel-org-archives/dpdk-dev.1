Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30E8606A336
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UYJ6zYem
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49E9540A70;
	Tue, 20 Oct 2026 14:11:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 887494066C
 for <dev@dpdk.org>; Tue, 20 Oct 2026 14:11:34 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A1981596;
 Tue, 20 Oct 2026 05:11:30 -0700 (PDT)
Received: from [10.57.16.49] (unknown [10.57.16.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D95A43F7D8;
 Tue, 20 Oct 2026 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792498293; bh=mGGurrwuc/5ijboYPSlMDPVjm8g4v2N2hVksEMLsIrk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UYJ6zYeml0jB+DmPEbPHrWrGryuh2TujBDPsicKWQnbm4TthKYv+65n6bh59rSgr8
 VMdq3ef9Ll5Q0kGxdYkiOhVii1rQjNYZHO43be0SJr/0eOK+qDeLl6TnQA75d2xTxK
 beJA7dahnmKqkx8wYaDC2OO7b7GPldTGXbDCMM+I=
Message-ID: <241b21b0-9cff-43d4-98dd-14e8dc5fffa1@arm.com>
Date: Tue, 20 Oct 2026 13:11:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dts: add directory for test resources
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com, dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260514172553.191331-1-abailey@iol.unh.edu>
 <20261019202252.907692-1-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261019202252.907692-1-abailey@iol.unh.edu>
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
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19/10/2026 21:22, Andrew Bailey wrote:
> The crypto verify test suite being added in this series requires an
> input vector file. The two vector files added in this commit are
> relocated from old DTS to new DTS. This will allow the crypto verify
> test suite to access the required vector files for verify testing.

Hi Andrew, this patch is fine. The commit description isn't, once this 
patch is merged there is no concept of patch series, so the description 
should be able to describe what it's doing on its own.

> 
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
