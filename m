Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE122C531C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 13:35:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B05314029B;
	Fri, 24 Jul 2026 15:35:43 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 544A740276
 for <dev@dpdk.org>; Fri, 24 Jul 2026 15:35:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 3F58641
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1784900141;
 bh=clrGWuAwQDHZ9RhAhevcMDFzS19aTRInsEM+II4GYyc=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=ZTza1Ocvr+rIDki6o5w0I9cR1Gp9wS4QC31cvmEZcj/0XiPwFsXTelYTWjKbDKLxD
 wYxAeZjGIHYStiIpWKBmllIvUcd6Bbtmb74yXN7LCQhJqAn94IHcfiMBL2+GTcPQYI
 OvcLNyNyaI/4QkdmAZFAomFZibdpbbZxVgMSmlps=
Received: from [192.168.1.42] (unknown [188.170.84.73])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 3F58641;
 Fri, 24 Jul 2026 16:35:41 +0300 (MSK)
Message-ID: <ea5825bf-abdf-474f-b98b-ad42c56acc98@oktetlabs.ru>
Date: Fri, 24 Jul 2026 16:35:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mempool: remove cache flush threshold
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, dev@dpdk.org,
 Jie Liu <liujie5@linkdatatechnology.com>
References: <20260724120747.33981-1-mb@smartsharesystems.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20260724120747.33981-1-mb@smartsharesystems.com>
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

On 7/24/26 3:07 PM, Morten Brørup wrote:
> mempool: remove cache flush threshold
> 
> Removed the mempool cache flush threshold field (``flushthresh``),
> which was obsolete and marked for removal.
> 
> Reduced the size of the mempool cache objects array; it was double the
> required size.
> 
> Also fixed a couple of commments.
> 
> The sxe2 driver was updated to use the ``size`` field instead of the
> ``flushthresh`` field; it contains the same value.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

