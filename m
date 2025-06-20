Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40190C71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 08:54:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EB0B42E9D;
	Fri, 20 Jun 2025 10:54:16 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 46361400D7
 for <dev@dpdk.org>; Fri, 20 Jun 2025 10:54:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 8121F84
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1750409654;
 bh=B2xHdmHqfOffAHFKsCxRyKd/nAZz3oewVOn+kbcftOI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kZchGDbuhSNJtlHyRxpx8xCfNetT+aw96C0tXxBfF4tDCK7zY0vXBQUZUi8Y+xH0c
 SSSkoSRAOiXydhfuCwW40RbESTItVusgvK5W7HXyui2O85sP7kNzFtj4AgYHzJ8Nej
 A11BC7s6+kZ89G841G6BRDWD0l7ohtvD8UhCzfks=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 8121F84;
 Fri, 20 Jun 2025 11:54:14 +0300 (MSK)
Message-ID: <bb488214-301c-413e-b3cc-2d0e09bbe2cb@oktetlabs.ru>
Date: Fri, 20 Jun 2025 11:54:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] test/mempool: fix test without stack driver
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-4-david.marchand@redhat.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20250619071037.37325-4-david.marchand@redhat.com>
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

On 6/19/25 10:10 AM, David Marchand wrote:
> In a minimal build, the mempool/stack driver is disabled.
> Separate the code specific to this external driver and rename unrelated
> variables.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

