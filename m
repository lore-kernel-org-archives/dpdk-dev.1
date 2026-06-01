Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8815CD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:07:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B4374025F;
	Mon,  1 Jun 2026 11:07:28 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 450BD4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 11:07:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru C8C6466
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780304846;
 bh=yTezJyYJ9mKhHKi4/xmBNinSSo3xJDyJt2ZQDior4eM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XKTauAuoHoK+wcqwNEEp8sjFYFgNJdK19UETQt4qlvm+G1EY8ADbmAVnaO8x8LZ5W
 E9GsBj0egJf5YymN0wHBuRyVfGyLH1u8SJrs0YAiqtBnfJvMlaHxfu5NCmzpyX+1f2
 mj+YEx8qlOjYH0rzOPmEcYSG198vtDiik+fUMDBQ=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id C8C6466;
 Mon,  1 Jun 2026 12:07:26 +0300 (MSK)
Message-ID: <af98b02f-6564-4fd2-8b29-754bb1e5ace2@oktetlabs.ru>
Date: Mon, 1 Jun 2026 12:07:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ethdev: promote experimental API's to stable
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
References: <20260527144407.160830-1-stephen@networkplumber.org>
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Language: en-US
Organization: OKTET Labs
In-Reply-To: <20260527144407.160830-1-stephen@networkplumber.org>
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

On 5/27/26 5:44 PM, Stephen Hemminger wrote:
> Several API's in ethdev have been marked as experimental
> (some as old as 19.11). There is no firm policy but any API
> that has been experimental for since the last LTS is good candidate
> to be stable.
> 
> APIs added in 25.11 or later are left as experimental for
> another release cycle.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

