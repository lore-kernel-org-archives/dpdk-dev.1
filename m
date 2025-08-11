Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E00C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:10:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95681400D5;
	Mon, 11 Aug 2025 12:10:33 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 6AE064025D
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:10:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru E9ED46B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1754907032;
 bh=vRf2wlfHV7tPloNqITK/SPSCPgVsP3FeLwK7zIV/ELs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=wppfjTEesnM3sFPiua89bs3u4p90Ph9dIMAIt5VWGMsZmkndYASMkyiGQQ4UnAn51
 ZVMLmQFIHAPF1y7TL6ixkVBhfrrVyhpP+XPECclZ5iYItBkDu+JwI4UhmtYRW8/l+L
 pR/h5jFJEE2LF3eGxMr1DNGyRmwnDsqDigYfw68k=
Received: from [192.168.1.41] (unknown [188.170.86.252])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id E9ED46B;
 Mon, 11 Aug 2025 13:10:31 +0300 (MSK)
Message-ID: <5199fed8-cc11-4d8e-b70f-970df88babf5@oktetlabs.ru>
Date: Mon, 11 Aug 2025 13:10:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/14] ethdev: make sure all necessary headers included
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
 <20250808165843.39075-3-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250808165843.39075-3-stephen@networkplumber.org>
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

On 8/8/25 19:55, Stephen Hemminger wrote:
> Best not to depend on other EAL headers to include stuff.
> Some of the later changes had build failures on some platforms.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

