Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFCC606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NmyCCdpe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 116F140284;
	Thu, 29 Oct 2026 13:02:20 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C4C4F40265
 for <dev@dpdk.org>; Thu, 29 Oct 2026 13:02:18 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF37A1BB2;
 Thu, 29 Oct 2026 05:02:14 -0700 (PDT)
Received: from [10.57.15.224] (unknown [10.57.15.224])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C7C83F59E;
 Thu, 29 Oct 2026 05:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793275337; bh=ozPXMNdqPrV/9nnVms0yEVtJci8tbGpj4u5pX3+xsQc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NmyCCdpefDkLYtVyqS6oJF6jE+CkqdUSocnpZmCAfm/D+gmB0o9plGikq9VswM8Hy
 mc9sVH38+VYZGEJM5BpHw88hhI5WVaDIumLvAU8RQRUlJ6pLezoR2gYyn8SsB20eYs
 ubFaepYHJ8kxTSeUSrJFPCiLsUlzHEmjgn+D2zd0=
Message-ID: <cab33e44-40fa-47af-a10f-9711e8d41e5c@arm.com>
Date: Thu, 29 Oct 2026 12:02:15 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: update cryptography dependency to avoid test
 discovery failure on ppc
To: Riley Fletcher <rileyf@linux.ibm.com>, probb@iol.unh.edu
Cc: dev@dpdk.org
References: <20261022220400.398135-1-rileyf@linux.ibm.com>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261022220400.398135-1-rileyf@linux.ibm.com>
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

Hi Riley,

thank you for the patch. I've adjusted your commit subject and body and 
applied to next-dts.

Luca
