Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB661C44532
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 13:26:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0912D4042F;
	Tue, 21 Jul 2026 15:26:23 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 90AED402A7;
 Tue, 21 Jul 2026 15:26:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 59D2A41
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1784640380;
 bh=mIuSACysoN6FY+fbgPBcrV9LU4B6cq3Tfd9o05r8vHw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Wi3uW6g93ueO6fKpoEBsLQdMgKt+rFmP+ilUMY58S4657Bx05dlTtkez7ghgOcj97
 /Ye9/9f1+iz86ghyZSXG7rjlBLtyLSEnWVKnDe8D/N1INC/m83XoS3I+Slipe9ZrKq
 YXZ5VGIFLCnCARl49BEupH67/8ly38Gdx50kxRTs=
Received: from [192.168.1.42] (unknown [188.170.72.157])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 59D2A41;
 Tue, 21 Jul 2026 16:26:20 +0300 (MSK)
Message-ID: <e11f32cc-471c-43c2-840b-7d66eda20e02@oktetlabs.ru>
Date: Tue, 21 Jul 2026 16:26:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ethdev: remove use of strncpy
To: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Harman Kalra <hkalra@marvell.com>, Ferruh Yigit <ferruh.yigit@amd.com>
References: <20260623141930.704771-1-bruce.richardson@intel.com>
 <20260623141930.704771-2-bruce.richardson@intel.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20260623141930.704771-2-bruce.richardson@intel.com>
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

On 6/23/26 5:19 PM, Bruce Richardson wrote:
> The use of strncpy is not generally recommended, so replace it in code
> tokenizing the representor list. Since its use in the function is not
> involving null-terminated strings (we know that copied block will
> not involve a null value in it), we can replace strncpy with memcpy
> rather than a string function. This keeps the original intent of the
> code.
> 
> For extra safety, also add in an explicit bounds check on the length
> value before doing the memcpy.
> 
> Fixes: 9a9eb104edf6 ("ethdev: parse multiple representor devargs")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

