Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300A60A2620
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GYEN9O7N
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01B0040285;
	Tue, 10 Nov 2026 13:51:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id EBD0240281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 13:51:07 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D2DA14BF;
 Tue, 10 Nov 2026 04:51:04 -0800 (PST)
Received: from [10.57.17.170] (unknown [10.57.17.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 426CE3F85F;
 Tue, 10 Nov 2026 04:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794315067; bh=Sl8odBVcEP2L0bzGaTGIdCIFZP6T7nml7ksYNRZhkBw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GYEN9O7NptnzsCmkUVDMO4mkMv0wiWAJJswwAqhgGE7CeobdlLmP8kyyIqPvHAG1w
 NmoMiXJSh9/cOaKW4KLjeTRW24ufZDKzlCBpVLpGhDQjB5Pt4LH7p+LbwfAF/2tI+1
 Pm6ZOrEuCtmD0Ag65tj7NUeeAKjq1oa/2lUNOW28=
Message-ID: <e2724be2-a513-4038-b564-b266eb6950ae@arm.com>
Date: Tue, 10 Nov 2026 12:51:04 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dts: add pvp multi paths virtio performance
 testsuite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261103220218.902765-1-knimoji@iol.unh.edu>
 <20261103220218.902765-2-knimoji@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261103220218.902765-2-knimoji@iol.unh.edu>
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

As the test suites are very similar, the same comment as 1/2 apply here.
