Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5353606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IemJViaW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1687140285;
	Tue, 10 Nov 2026 16:28:00 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id BE72340281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 16:27:56 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1876B1477;
 Tue, 10 Nov 2026 07:27:53 -0800 (PST)
Received: from [10.57.17.170] (unknown [10.57.17.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 377083F85F;
 Tue, 10 Nov 2026 07:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794324476; bh=oZpHcAmR55Jdn4QEyGlsU5KgTiKrYMFFAWC4mRXo6HA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IemJViaWZsIs9F9AuvXGt/3LmgVXNp25HOzytJJffts3qc+NkGlHT29emX4MMtrFH
 FSqxV8dPnpHc3bHddUMe5N9L6IcIZzwxnRSA+aGprZWctyFy0CrKdwVXNxgJ5l7A7r
 SH0Y4OrB5dvtWR7C9/cGTVBXGxZCEysNtleZSZEA=
Message-ID: <d552af6e-cd0e-4793-b026-ea1488e06555@arm.com>
Date: Tue, 10 Nov 2026 15:27:53 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dts: restore unbinded ports to initial state
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260812194428.296334-1-knimoji@iol.unh.edu>
 <20260929134920.330389-1-knimoji@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260929134920.330389-1-knimoji@iol.unh.edu>
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

Merged with minor commit rewording. Thanks
