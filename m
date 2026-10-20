Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81D0606D548
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qE91Eu4L
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDA3840297;
	Tue, 20 Oct 2026 18:47:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E2F1B40283
 for <dev@dpdk.org>; Tue, 20 Oct 2026 18:47:38 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFEBE1596;
 Tue, 20 Oct 2026 09:47:34 -0700 (PDT)
Received: from [192.168.68.53] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 553563F7D8; Tue, 20 Oct 2026 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792514858; bh=GV08LP66CzT195R9BXeUCeUPAmYUZSxHmZGUF2ZvUuY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qE91Eu4LDU7jwjqjDvM/Mbh99lqne8OWUMfPubHJB/89ABW4KYxlfP3UyD13ELxwg
 T7YG98czJ0ZBSeSjntaO9eLT/E5OKzpRDMau+nxhJcxLPp1LOl/Lzkf9YJ4CFU2udN
 gC8OQ+iuAfIjyQ01aebnAGzZUZVw9M73LoQy+hh4=
Message-ID: <3aff31c2-1154-4aac-9fcf-c1935c7057d1@arm.com>
Date: Tue, 20 Oct 2026 17:47:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] dts: add verify coverage for cryptodev testing
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com, dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260514172553.191331-1-abailey@iol.unh.edu>
 <20261019202252.907692-1-abailey@iol.unh.edu>
 <20261019202252.907692-3-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261019202252.907692-3-abailey@iol.unh.edu>
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

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
