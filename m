Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F33CD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:35:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E07154025F;
	Mon,  1 Jun 2026 11:35:01 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 3F8744025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 11:35:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru C1D236B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780306499;
 bh=TITa4O9B0isZ5zHzMNeb05T4QiuYJKgWW//y0azoA2Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NC1ZDsbwL/J838mfCUF83H7GOA9fRXHkmbM88cHaVIUKbhm8r8dXa5O8U6t1NW8tP
 pzCjGIkN0Qz4/WLMgXKSazQuPH6S+9EZ1SwkyHth1O0TbWioDgo1vgYXFxo3EN/PkR
 OfaQxJ4plxNi2GvvqoSD1tXtqyAu6Z/spIFE3Tks=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id C1D236B;
 Mon,  1 Jun 2026 12:34:59 +0300 (MSK)
Message-ID: <91ff34be-87fb-4d92-8682-300e77d28468@oktetlabs.ru>
Date: Mon, 1 Jun 2026 12:34:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ethdev: hide VMDq internal sizes
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260403091836.1073484-4-david.marchand@redhat.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260403091836.1073484-4-david.marchand@redhat.com>
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

On 4/3/26 12:18 PM, David Marchand wrote:
> Hide RTE_ETH_NUM_RECEIVE_MAC_ADDR and RTE_ETH_VMDQ_NUM_UC_HASH_ARRAY
> in the driver API as those (ambiguous) macros are only a driver concern.
> 
> In practice, this is only used by the bnxt and ixgbe (+ clones) drivers.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

