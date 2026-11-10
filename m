Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73D606A336
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ud4skZFt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDEC740281;
	Tue, 10 Nov 2026 12:49:53 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 318264027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 12:49:52 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A7361516;
 Tue, 10 Nov 2026 03:49:48 -0800 (PST)
Received: from [10.57.17.170] (unknown [10.57.17.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CA833F632;
 Tue, 10 Nov 2026 03:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794311391; bh=JHdD6kq76Z3dX7Cm7yF8ya15wRg7EafFmzbhxkU0mzA=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=ud4skZFtWBGb0yXiVZHp3qLCRpKsvNar2kiFtzHXEPjzVkqw9T2ZDfO2pDdnhjpxx
 Cac5azqNjPKq4aCom3apaFQfILw8RRx0iVVtfUFnNjU7wv6tqOd0IgsABzpfqcCwnI
 z5k09ZaGJr3XC0qeslzTZHBKlBiiXYxR/BA+IAkc=
Message-ID: <3bc8c54b-76fa-48d9-8d53-4802a439a85d@arm.com>
Date: Tue, 10 Nov 2026 11:49:48 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dts: update single core performance test configuration
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu
References: <20260805153658.345207-1-abailey@iol.unh.edu>
 <20261026190818.45530-1-abailey@iol.unh.edu>
 <7c2b0a1e-7c9f-48b4-bb75-efc507818049@arm.com>
Content-Language: en-GB
In-Reply-To: <7c2b0a1e-7c9f-48b4-bb75-efc507818049@arm.com>
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
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/2026 11:46, Luca Vizzarro wrote:
> Hi Andrew,
> 
> I'll accept this for now, but I'd appreciate if you could send a new 
> patch to enable validation to the custom configuration with Pydantic as 
> originally intended. This would probably be only for `test_parameters`.
> 
> Luca

Furthermore, I note that many perf test cases share the same parameters 
therefore I'd propose hold a common extendable config for perf suites, 
rather than duplicating every test suite's config.

Luca
