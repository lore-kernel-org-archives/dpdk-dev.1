Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1034EFB7FD
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 06:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C179E4027F;
	Tue, 24 Feb 2026 07:29:27 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 63543400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 07:29:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 5499356
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1771914565;
 bh=aCvIta8EEMizWyISgLi8caaWJGlBblzGZ7i3TWCyU5Y=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=iyEi+dlmIMolls/v3KwkYjhy7EE0v/LT8pN4MKGZbZ4GT74W4ENJzlpkXogXpUDoh
 v2bte2dQnjqMSt6MdyoJgozp/V6N5lf+Thso3ZblsGc173Ih1UHkQA+GyYgUT8X2XZ
 9uzEw5WViHieY1doc1ZULhNbPUaBgGqfCKr/Xmx8=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 5499356;
 Tue, 24 Feb 2026 09:29:25 +0300 (MSK)
Message-ID: <6af4bdb3-0a0c-4d99-9852-376bf93d1a16@oktetlabs.ru>
Date: Tue, 24 Feb 2026 09:29:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mempool: introduce statistics reset function
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org
References: <20260223102054.336350-1-mb@smartsharesystems.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260223102054.336350-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/23/26 1:20 PM, Morten Brørup wrote:
> Populating a mempool with objects is accounted for in the statistics.
> When analyzing mempool cache statistics, this may distort the data.
> In order to simplify mempool cache statistics analysis, a mempool
> statistics reset function was added.
> 
> Furthermore, details about average burst sizes and mempool cache miss
> rates were added to the statistics shown when dumping a mempool.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

I'd like to see thoughts about consistency after reset taking into
account that reset will likely to be done from control core whereas
stats are updated from data cores. Results could be very interesting.
I guess it is not the reason to introduce locking or any other kind
of synchronization, but user should be warned as the bare minimum.

