Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873BD606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oWVGMN/J
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03BDF4025A;
	Thu, 29 Oct 2026 18:01:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E86CA40151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 18:01:44 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 220D7153B;
 Thu, 29 Oct 2026 10:01:41 -0700 (PDT)
Received: from [10.57.16.241] (unknown [10.57.16.241])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B32D3F673;
 Thu, 29 Oct 2026 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793293304; bh=onx0SGfXAcelsLy8PjwheALJ5Hae4pioLblwKbdN2Cs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oWVGMN/JjIkZZ3YXUCqhS4TudkfL7Ngdbq5Hwe1aW6FSps5lMgTqHsQVFhhugZyk4
 GG63vgCR4S7j3KmuH+S4P8EmPrhdiXIAhwdIAFQ+zu62t6yxGcWTCbSF48KmGQCHuu
 yaXJJogSHEY06U6snfMLPekHCyOWv99Ag3f3gyts=
Message-ID: <cd6f3102-3317-4f0a-b984-b4c9a793f24b@arm.com>
Date: Thu, 29 Oct 2026 17:01:41 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dts: add pvp multi paths virtio performance
 testsuite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261020173029.162255-1-knimoji@iol.unh.edu>
 <20261020173029.162255-2-knimoji@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261020173029.162255-2-knimoji@iol.unh.edu>
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

I am a bit loss here. Is this a duplicate of 1/2?
