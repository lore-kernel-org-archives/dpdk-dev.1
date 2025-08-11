Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36456C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 07:52:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E80914025D;
	Mon, 11 Aug 2025 09:52:14 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 85342400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 09:52:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru C203A75
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1754898732;
 bh=87MiCHanw8/m9tFRGItgmInx+OARIKerXDvmt/8ruY4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=abzBCo+6lN+o9UhQ8s3Uy9Qu/O1wyBDbC69sZ2H8JhXN0B+amIKw9mYUHfKUUWb+I
 wO7ygh0XO5OTE+csk2llJ7c7VAe2o+dvkh1Fsa5AVxYOpvpR3QBlbt38KW8T3hGCJo
 fsaWPRm7azrYbsJ8A6U3Zd/patr8Gbcl5a0uCnw8=
Received: from [192.168.1.41] (unknown [188.170.86.252])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id C203A75;
 Mon, 11 Aug 2025 10:52:11 +0300 (MSK)
Message-ID: <0c4cb82f-7ffa-4f7c-9b07-3274d130a2be@oktetlabs.ru>
Date: Mon, 11 Aug 2025 10:52:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] common/sfc_efx/base: enable parallel detect via
 netport MCDI
To: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
References: <20250810044605.7911-1-ivan.malov@arknetworks.am>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250810044605.7911-1-ivan.malov@arknetworks.am>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On 8/10/25 07:46, Ivan Malov wrote:
> When autoneg is enabled, also enable parallel detect, to try
> to discover link tech/FEC settings that result in link up.
> 
> Suggested-by: Andy Moreton <andy.moreton@amd.com>
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

