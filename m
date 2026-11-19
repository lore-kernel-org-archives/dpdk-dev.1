Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24862606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cOP/6Bze
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3828C40151;
	Thu, 19 Nov 2026 19:41:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 74341400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 19:41:20 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFACC1575;
 Thu, 19 Nov 2026 10:41:16 -0800 (PST)
Received: from [10.57.17.170] (unknown [10.57.17.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C45383F882;
 Thu, 19 Nov 2026 10:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795113679; bh=nKYO66MGCSfBeqBrWwso+wem8GYy4GaqBwgZv2Z++Rk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cOP/6BzeLjpSoIYw4+86qNEj5Sa1uvI9Hk/+Q+w59YhLA8ruNskX/B7+pQpkQHh+W
 Wb/YjYndHQYZ6abYIzNpqw5bHB+YzV1qwKeGC9K1UtDfWyLPOH1hrxOF0cjZpBhVmG
 WE2dyXaau67mC7mO1ELom3KR79GhV+mKfN4ZctQw=
Message-ID: <b03c740b-38b6-4bba-bf36-96a249f92ca5@arm.com>
Date: Thu, 19 Nov 2026 18:41:17 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dts: create default performance test configuration
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261112210009.1620168-1-knimoji@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261112210009.1620168-1-knimoji@iol.unh.edu>
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

Hi Koushik,

thank you for this. Accepted to next-dts with minor doc changes.

Luca
