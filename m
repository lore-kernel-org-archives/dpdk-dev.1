Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683C0CD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:39:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A91D74064A;
	Mon,  1 Jun 2026 11:39:18 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 1590F4025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 11:39:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 6C9E966
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780306756;
 bh=aDmqlM8tqHHXhDyt/vX6VXZrmIJrczGMofePELap8Nc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=e/UhcPnO+5tktodKeVKoBlu54ex0dtz0dej/k77giSscqzyCPSNPl2hf2aHx/rV4n
 JphYA/bAuzGIFShBNbcZG0Zu75pxrLwsTUr3MFGR9qQhxejuJFHLUvQ5ksYHD+ZnNj
 1jd8Ca2q8qcLh4YviM4QLgfw3ruzWKpga4OHoQ5I=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 6C9E966;
 Mon,  1 Jun 2026 12:39:16 +0300 (MSK)
Message-ID: <0daff062-acfc-4e5b-8925-859bb6f84004@oktetlabs.ru>
Date: Mon, 1 Jun 2026 12:39:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] ethdev: hide VMDq internal sizes
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260510170306.3406045-1-david.marchand@redhat.com>
 <20260510170306.3406045-4-david.marchand@redhat.com>
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Content-Language: en-US
Organization: OKTET Labs
In-Reply-To: <20260510170306.3406045-4-david.marchand@redhat.com>
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

On 5/10/26 8:03 PM, David Marchand wrote:
> Hide RTE_ETH_NUM_RECEIVE_MAC_ADDR and RTE_ETH_VMDQ_NUM_UC_HASH_ARRAY
> in the driver API as those (ambiguous) macros are only a driver concern.
> 
> In practice, this is only used by the bnxt and ixgbe (+ clones) drivers.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

