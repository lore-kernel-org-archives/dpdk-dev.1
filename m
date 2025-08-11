Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0363EC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:14:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C82C40691;
	Mon, 11 Aug 2025 12:14:38 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 70A99400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:14:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru EF0DB6D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1754907275;
 bh=+veMBPEcbQZCsD3a4ii9YURoCTlJwAghLeEAJwn4EG4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=j8uAiS69yJDeY1NghWr4OsQU7px0YOszXcVxNCL8oaLobYNZ4/4j5yGJeW0w/+Zfo
 UAgjHl87xkRYKRmekGMQtHt/vfPGIDeuZU44YMsbTxI9xbQTntxCblmOmOpjQwlVhL
 bhYf0+/Sp8Xp7ygSQZeFB/upLAA0pkPuPwX1EJZA=
Received: from [192.168.1.41] (unknown [188.170.86.252])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id EF0DB6D;
 Mon, 11 Aug 2025 13:14:34 +0300 (MSK)
Message-ID: <a0ad909b-e00f-4af7-b4d3-a3ab45d04f4b@oktetlabs.ru>
Date: Mon, 11 Aug 2025 13:14:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/14] ethdev: reorder bpf and ethdev dependency
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
 <20250808165843.39075-4-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250808165843.39075-4-stephen@networkplumber.org>
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
> In order to allow use of BPF in the mirror code in ethdev.
> Need to switch so that ethdev library depends on BPF library.
> 
> Since meson doesn't allow co-dependency, move the BPF ethdev
> callback portion into the ethdev lib. And cleanup usage
> of VLA in that code.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

