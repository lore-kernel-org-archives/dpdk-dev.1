Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3C860A3822
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=I1C5gEC4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C99DD40A7D;
	Fri, 30 Oct 2026 12:53:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D8FE840289
 for <dev@dpdk.org>; Fri, 30 Oct 2026 12:53:14 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00D6F1682;
 Fri, 30 Oct 2026 04:53:11 -0700 (PDT)
Received: from [10.57.14.181] (unknown [10.57.14.181])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C5393F7B4;
 Fri, 30 Oct 2026 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793361194; bh=cjIDB3dqAU1YFX06bfmk0caW2AO7byXOiAns+iig0mc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=I1C5gEC4QUnOiVwcXEL4Cjwuc8GAlhmH2ZH86Fd5Zt+UjYFEQ+O3EV6wXP46Bu82Y
 duvtMMQNCNAgm4921N2SMD8tmYjQXy3+nt6TBhWQ326wdAnc5op/KXtlg33XC21Bmm
 IJjdRn91oe03Qd8qaTnw/h+v9XrcAfowwdM1GU4s=
Message-ID: <787c1a43-3851-419d-9274-5dc89b7ef1f9@arm.com>
Date: Fri, 30 Oct 2026 11:53:11 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dts: refactor cryptodev latency test suite
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com, dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260827172208.139769-1-abailey@iol.unh.edu>
 <20261019200424.898640-1-abailey@iol.unh.edu>
 <20261019200424.898640-2-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261019200424.898640-2-abailey@iol.unh.edu>
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

Hey Andrew,

same config discussion as 1/2.

Luca
