Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC21CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 08:45:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A59B4025F;
	Mon,  1 Jun 2026 10:45:24 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id C9B054025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 10:45:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 7DEDA66
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780303521;
 bh=esFn+TJyf5HEiGzY6F89ptMQMagGrYdND6HT+tPfaH0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ecKXNG74nnPYw2ooDYtNm/OJWiFHbhhdS+hJnidOrfwSicGTSs94GnWmktk3VAqyX
 YCHLDE+6NQKJjdqlAoSAvexjjCJcY+D4hREncXiIEVe99z3bP35MfgO5HMMilcj0xu
 wS1AMGhVqogqu8068GM806Ux4Jm8vhrwn1mjnQyI=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 7DEDA66;
 Mon,  1 Jun 2026 11:45:21 +0300 (MSK)
Message-ID: <139a30df-6ad8-4fc1-84fa-819fe5973744@oktetlabs.ru>
Date: Mon, 1 Jun 2026 11:45:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/7] ethdev: remove support for queue stats mapping
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260530161151.873199-8-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260530161151.873199-8-stephen@networkplumber.org>
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

On 5/30/26 7:10 PM, Stephen Hemminger wrote:
> The support for queue stats mapping has since 25.11 release
> by commit 2863cbd9ee6d ("ethdev: deprecate queue stats mapping functions")
> 
> This patch completes final removal from ethdev and documentation.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

