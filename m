Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D6606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eIczdSvx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 687DE40289;
	Fri, 30 Oct 2026 12:59:41 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A069640285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 12:59:40 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBDC71682;
 Fri, 30 Oct 2026 04:59:36 -0700 (PDT)
Received: from [10.57.14.181] (unknown [10.57.14.181])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECF9B3F59E;
 Fri, 30 Oct 2026 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793361579; bh=LQnTGfW03DqLtxySJJRZIZjhvSi8PHaNVg7gSKwc5fQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eIczdSvxlwJhb0VvuiOiIAkASnMIE/asloKFXgqF1KxvIGNnmIkD2fykpX+uDT20+
 +l9e0GW1er7WKOywn8WN5KRyJJNaI5k+7SSTxqURUdDSqZi9wFCouG/0RInHgBaqvp
 aKOC/cFVlhqvc1OClewkGpOYlwH88wnQUOdqrgY8=
Message-ID: <42f34325-47cc-4685-b871-2fdcaa5ce2c0@arm.com>
Date: Fri, 30 Oct 2026 11:59:37 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dts: refactor cryptodev throughput test suite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>,
 Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, patrickrobb1997@gmail.com, dladd@iol.unh.edu,
 lylavoie@iol.unh.edu
References: <20260827172208.139769-1-abailey@iol.unh.edu>
 <20261019200424.898640-1-abailey@iol.unh.edu>
 <CAKYPG+wWtzvvNCaDfwQV8tGSb4bQ=A5zfA6=fXNXWx9kbsKYWg@mail.gmail.com>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CAKYPG+wWtzvvNCaDfwQV8tGSb4bQ=A5zfA6=fXNXWx9kbsKYWg@mail.gmail.com>
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

Hey Koushik,

Because you are not actually quoting any part of the email, when you 
reply can you please delete the entire quote as it pollutes the thread 
and the mailing list. In other words, when we attempt to read on a plain 
text platform (like mutt) or on Patchwork, a lot of the page becomes 
mostly quote which is entirely replicating the original message 
unnecessarily. When giving reviews as well, we tend to snip the quote 
and limit it to what the replies are actually referring to, including 
some context around it (like file and line numbers). This would be quite 
akin to online bulletin boards if you are familiar with them.

Similarly, generally mailing lists tend to use plain text emails only as 
HTML ones won't render on any platform and make the messages heavier for 
the mailing list archives.

I highly recommend having a look at this resource as it's quite nice: 
https://useplaintext.email/

Luca
