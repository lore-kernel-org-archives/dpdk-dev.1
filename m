Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B221606A31F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p6y+UPI/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69CB240689;
	Tue, 20 Oct 2026 14:12:19 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 028344067A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 14:12:18 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FD881596;
 Tue, 20 Oct 2026 05:12:14 -0700 (PDT)
Received: from [10.57.16.49] (unknown [10.57.16.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 723993F7D8;
 Tue, 20 Oct 2026 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792498337; bh=GV08LP66CzT195R9BXeUCeUPAmYUZSxHmZGUF2ZvUuY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=p6y+UPI/cYecuLV5Ezoy31kZI8y0bfqSyGxnZ5Q8AOuEZSt4nBr8HrdAvOb3umssx
 aIqbBCJhAlrhyX7jTu15aKUD0oetIUHzeNgv44QHRLitm7714fqgJxk7eLLC9uuokt
 ml+Kt4yDakGuw2xuiP+XvHXyzvpnidylOICK9KiE=
Message-ID: <bd8e24f3-9be6-4535-b2bc-1aa102ad59cf@arm.com>
Date: Tue, 20 Oct 2026 13:12:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dts: fix cryptodev verify parsing
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com, dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260514172553.191331-1-abailey@iol.unh.edu>
 <20261019202252.907692-1-abailey@iol.unh.edu>
 <20261019202252.907692-2-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261019202252.907692-2-abailey@iol.unh.edu>
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
