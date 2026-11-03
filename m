Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EBD606A327
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qoIRDpZv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AC8440656;
	Tue,  3 Nov 2026 16:47:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 25CE640265
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:47:45 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E7A11595;
 Tue,  3 Nov 2026 07:47:41 -0800 (PST)
Received: from [10.57.16.57] (unknown [10.57.16.57])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6688B3F673;
 Tue,  3 Nov 2026 07:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793720864; bh=kLSpBbVCjseuNrGEIkEBjPvvRoRAZPqS7Mqv+tUF2IY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qoIRDpZv8lAdDc4BFXtTNXRjA8tYA8XbIbjdfCvQS+cTf1G/amM0ImMdpP7tTJIvD
 z/lC1l+jb2WV180McDeC353Nw0HfttJcj7JrEp/gwuQERbivloeKtOHCkt/Fq/ABsT
 0gEX2hfoDL5MR6x9Sx43UvWMA8E9XX9OR+e4WUMU=
Message-ID: <5412e441-d415-4c66-a481-35fbc4b73c03@arm.com>
Date: Tue, 3 Nov 2026 15:47:41 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dts: add pvp multi paths virtio performance
 testsuite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, dladd@iol.unh.edu,
 abailey@iol.unh.edu, lylavoie@iol.unh.edu
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261020173029.162255-1-knimoji@iol.unh.edu>
 <20261020173029.162255-2-knimoji@iol.unh.edu>
 <cd6f3102-3317-4f0a-b984-b4c9a793f24b@arm.com>
 <CAKYPG+z88eQG1zPcSZpQ-jKhsfKuBATcnqoS9wUq0=cKe+Fn4Q@mail.gmail.com>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CAKYPG+z88eQG1zPcSZpQ-jKhsfKuBATcnqoS9wUq0=cKe+Fn4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 03/11/2026 15:37, Koushik Bhargav Nimoji wrote:
> Hi Luca, this is the virtio single core performance test suite, very 
> similar to the vhost single core performance test suite. The difference 
> between the two is that in this test suite the virtio virtual device is 
> provided one core while the vhost is provided two cores, and vice versa 
> in the vhost single core performance test suite. I will apply the 
> changes mentioned in the 1/2 in this patch as well, and send new 
> versions in shortly.

Oh, alright! Thank you for clarifying! The difference was so subtle I 
struggled to notice! In that case the comments I made for the vhost 
patches apply here too as, as you picked up already.

Luca
