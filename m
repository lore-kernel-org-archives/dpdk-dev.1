Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA0B606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rHrl0CP3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0976940616;
	Tue,  3 Nov 2026 17:56:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id B655B40265
 for <dev@dpdk.org>; Tue,  3 Nov 2026 17:56:06 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAD151595;
 Tue,  3 Nov 2026 08:56:02 -0800 (PST)
Received: from [10.57.16.57] (unknown [10.57.16.57])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DB703F628;
 Tue,  3 Nov 2026 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793724966; bh=yOwGBe0DNOOdU5R8+JHy9ZtviwXKX43Ji6SkVRWvQmY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rHrl0CP3WTuzTIiZ7Wk5BHiOf3F+BE2eGFuuljxCm70w7pvEtFnL+y8C/N9+6x9JY
 nYxM2oRuU23QbhYa6isPIY1WkMq2UnmOz9rKbALBRVk6d/HGSO6h9o3kD2h17ACr40
 FbhkQ1D9ikc1B6GcKvq3iUiAOV4t+rRYGOLocdAA=
Message-ID: <68014fe6-83eb-47b8-8063-46e31c57a66b@arm.com>
Date: Tue, 3 Nov 2026 16:56:03 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dts: resolve trex driver binding issue
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260811185509.1650102-1-knimoji@iol.unh.edu>
 <20261029152216.401924-1-knimoji@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261029152216.401924-1-knimoji@iol.unh.edu>
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

Hi Koushik,

Thank you! looks good to me. Applied to next-dts

Luca
