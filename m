Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B6606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ENHewPA9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C204A4028F;
	Mon,  9 Nov 2026 20:00:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 25F6F40270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 20:00:23 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2761D1477;
 Mon,  9 Nov 2026 11:00:19 -0800 (PST)
Received: from [10.57.17.170] (unknown [10.57.17.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AB013F85F;
 Mon,  9 Nov 2026 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794250822; bh=NukPKKVNfsCjOF+ZoltOChSsFADNGvg+KPWDIMDKxOA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ENHewPA9LEWY7Bj4EZrc65G7kqYSGQDp7QuA9q888sK5ac1na7D7iEzea3N8g/Z3+
 lgnm7I0FYsyQmo5uDzUFRtgtuLqW9Ji9H2xuNBZJpTym2stbcIzeVjs/6L8AKhearP
 /DuoLRMdmIEURqox4mu6fdC1NLn9GuySnjjyz4s8=
Message-ID: <cedc5c26-a229-4cf5-ba76-ec4be5bac3d1@arm.com>
Date: Mon, 9 Nov 2026 19:00:19 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dts: refactor cryptodev throughput test suite
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, dladd@iol.unh.edu
References: <20260827172208.139769-1-abailey@iol.unh.edu>
 <20261104213544.410065-1-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261104213544.410065-1-abailey@iol.unh.edu>
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

Accepted but amended with the necessary corrections.
