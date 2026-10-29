Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30591606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=RRkq3v9u
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98BA740284;
	Thu, 29 Oct 2026 13:17:54 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5B4B440265
 for <dev@dpdk.org>; Thu, 29 Oct 2026 13:17:53 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 542A81BB2;
 Thu, 29 Oct 2026 05:17:49 -0700 (PDT)
Received: from [10.57.15.224] (unknown [10.57.15.224])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BF103F673;
 Thu, 29 Oct 2026 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793276272; bh=td2kW8+ZNELXXQTysP7O559DQ1WwEBvOIf5PEqvztsc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RRkq3v9ueWTb6nGK4uC2oWPx7jxK2gsy7nGFb0saTWzNXLhaWce3lmPj5qnO1RpIv
 B/U+mp/acf7AUsydvGzC+dFtEyVq7B7V7iIavbGR/O8oGWsd26nYWHht0U5m4pP32P
 yu0KYplv3zVTzvvni15JLU0EkJUFbLmyBeup6jrM=
Message-ID: <a526f7b9-753c-448b-9569-d0997198c443@arm.com>
Date: Thu, 29 Oct 2026 12:17:49 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dts: remove crypto test type
To: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org,
 patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu
References: <20260806164505.642928-1-abailey@iol.unh.edu>
 <20261026200158.66094-1-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20261026200158.66094-1-abailey@iol.unh.edu>
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

Hi Andrew,

Thank you for the updates. Applied to next-dts.

Luca
