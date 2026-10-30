Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C22606A33B
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=O66ZGDjh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F145540289;
	Fri, 30 Oct 2026 12:52:57 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8E2A640285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 12:52:56 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B73071682;
 Fri, 30 Oct 2026 04:52:52 -0700 (PDT)
Received: from [10.57.14.181] (unknown [10.57.14.181])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA6643F7B4;
 Fri, 30 Oct 2026 04:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793361175; bh=Wfw5MzukeWQd1k11UtgjSy5wmi/9QtoeKXEVGMXGMnk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=O66ZGDjhwfuE/OsU/X/FKpxN8JxdVtofMHf8wBonhkeUhKuwYxabupXnaJN4eGW+h
 YqK5d3adKa1VP1MIVnd2VQWaKOn9iByERzmp4a1Q+OLqtLH6eMIbzv6/2co6XbXl7N
 B7zwkpOnW+6oFHKtH6h2vxHb+M0saifIJ+i+ZOmk=
Message-ID: <63b5c4bc-e6ad-4a53-8045-afc48cfbe6fa@arm.com>
Date: Fri, 30 Oct 2026 11:52:53 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dts: refactor cryptodev throughput test suite
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com, dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260827172208.139769-1-abailey@iol.unh.edu>
 <20261019200424.898640-1-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261019200424.898640-1-abailey@iol.unh.edu>
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

On 19/10/2026 21:04, Andrew Bailey wrote:
>   class Config(BaseConfig):
>       """Performance test metrics.
>   
>       Attributes:
>           delta_tolerance: The allowed tolerance below a given baseline.
> -        throughput_test_parameters: The test parameters to use in the test suite.
> +        test_combinations: List of test combinations with cipher/auth algorithms and parameters.
>       """
Hey Andrew,

The refactor looks mostly fine. Even though it was previously merged 
like that, can we use this refactor to appropriately define the 
configuration of the test suite. Given this is not a simple TypedDict, 
you could perhaps use a Pydantic model to define the fields. just a 
dict[str, ...] is too vague and compromises configuration validation 
upon startup. Moreover the Pydantic-based configurations will render 
appropriately in the docs, so the user will know better how to configure 
that way. You can have a look at the config module to see how it was done.

Luca
