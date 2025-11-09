Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D3FCCFA13
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 14:36:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 701BD40268;
	Sun,  9 Nov 2025 15:36:05 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 5BC7C400D5;
 Sun,  9 Nov 2025 15:36:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 068D087
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1762698963;
 bh=YCM4c5/PYUO1CN0/JnccW1zBvGxjqF1xn254DxD0Zz8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sjpmsZv7PUwoIGyH6LS59+joKNacHhXxqiPhz0+f3EK2AtZcgjMbLBx+M4wxYpvah
 G3gmPiSRQsVaQRHd2cmVkydMmpQFw7IT32TxxSiD3HGZGExko4AlgXVMv7G06UjCyU
 +J4a/SGBkwOp0caSCcWOd6Rgv2rsJWp8D33IFllk=
Received: from [192.168.1.42] (unknown [188.170.87.245])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 068D087;
 Sun,  9 Nov 2025 17:36:02 +0300 (MSK)
Message-ID: <a2ca938a-dbc5-4abf-b162-d0d4e2276a55@oktetlabs.ru>
Date: Sun, 9 Nov 2025 17:36:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/33] ethdev: fix variable shadowing issues
To: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Declan Doherty <declan.doherty@intel.com>, Rosen Xu <rosen.xu@altera.com>,
 Huisong Li <lihuisong@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
 <20251107155034.436809-4-bruce.richardson@intel.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20251107155034.436809-4-bruce.richardson@intel.com>
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

On 11/7/25 18:49, Bruce Richardson wrote:
> Remove unneeded extra variable definitions, and rename variables as
> necessary to ensure clean compile with -Wshadow warnings enabled.
> 
> Fixes: e489007a411c ("ethdev: add generic create/destroy ethdev APIs")
> Fixes: 1bb4a528c41f ("ethdev: fix max Rx packet length")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

