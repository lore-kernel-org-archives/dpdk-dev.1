Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A46E9B248
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 09:57:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E597D4027F;
	Tue, 24 Feb 2026 10:57:17 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id A55FD400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 10:57:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru E8E6556
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1771927036;
 bh=88UJQtUDZctWYzjMzau1w5MGGOrw1uOqa1pogNeeEDg=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=rHlCki/GDl+9xtT63OwcfS56mlVNQbKuWb6HR3C0THJNGWvC2zGOc3J44+su4An9f
 tYgdHpH2n7Ut4+QGivslEhD7KjroaFV4kQziUi2kO7tA6JGO9vIdGpKAKuzzb3N2sl
 DHkunHweoPt8/GarPVksFKzNYewERv4AmHxNZBR8=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id E8E6556;
 Tue, 24 Feb 2026 12:57:15 +0300 (MSK)
Message-ID: <b2fa41c0-aed1-420f-ad89-775fe0024dce@oktetlabs.ru>
Date: Tue, 24 Feb 2026 12:57:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mempool: introduce statistics reset function
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
References: <20260223102054.336350-1-mb@smartsharesystems.com>
 <20260224092802.359592-1-mb@smartsharesystems.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260224092802.359592-1-mb@smartsharesystems.com>
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

On 2/24/26 12:28 PM, Morten Brørup wrote:
> Populating a mempool with objects is accounted for in the statistics.
> When analyzing mempool cache statistics, this may distort the data.
> In order to simplify mempool cache statistics analysis, a mempool
> statistics reset function was added.
> 
> Furthermore, details about average burst sizes and mempool cache miss
> rates were added to the statistics shown when dumping a mempool.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

