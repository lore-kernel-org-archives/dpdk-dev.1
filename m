Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F9AC36014
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 07:10:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60E544067E;
	Tue,  1 Apr 2025 09:10:05 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 50C26402EE
 for <dev@dpdk.org>; Tue,  1 Apr 2025 09:10:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 0F5B138
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1743491402;
 bh=M5Scj/fT2Vyr52/LyqY/sJ5BhrAcmiIDW7GIhGmWL3I=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=KES3UHyigv+YGl+fa5WnLvedmMO16aJJ9FHf2w5UyQncR81P67bc7//0T9VZ4CaxU
 YIqg+kZo29seXojZYsVZHS05hojcq2cm9Mc6b/YhSWVZl9lXhWSeUC+qejZbhw7Y4c
 Z5CBUW0po68Ki+EIU0IIu8aenqmemYR2r6AMSvag=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 0F5B138;
 Tue,  1 Apr 2025 10:10:02 +0300 (MSK)
Message-ID: <6d5cadb8-55e4-45bf-8c61-dad1ff176a49@oktetlabs.ru>
Date: Tue, 1 Apr 2025 10:10:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] common/sfc_efx: use common base code build handling
To: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <20250331161000.9886-3-bruce.richardson@intel.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20250331161000.9886-3-bruce.richardson@intel.com>
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

On 3/31/25 19:09, Bruce Richardson wrote:
> Use the base code build handling logic in the drivers/meson.build file,
> rather than re-implementing it in the driver itself.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

