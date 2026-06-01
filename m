Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D46CD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:30:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC6C64025F;
	Mon,  1 Jun 2026 11:30:33 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id B6E094025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 11:30:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 3A1DA66
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780306232;
 bh=0F7Ab0kr4ZOOjLy+vQPw0x1GqwhiJ4AUJcSUO8duQvA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dp0eQJv655yjBNu5iCSSyXJYqqzxhLNal3AWLJHwrFb6Kl/lCAxkMdjIkA2iYNPXo
 SLA1RgVPhZvnRAOe8SMJ4+DsrKHJbMtfXJ7qibbmV0bDSzvG+bANOoMQnOPfqqaxbR
 rgkKyYpbcocu4wPyWezcrqWv/RrK00+7IKVs8bzk=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 3A1DA66;
 Mon,  1 Jun 2026 12:30:32 +0300 (MSK)
Message-ID: <7004c56b-35dc-47ac-b703-ace3d5e8b826@oktetlabs.ru>
Date: Mon, 1 Jun 2026 12:30:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ethdev: skip VMDq pools unless configured
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Thomas Monjalon <thomas@monjalon.net>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260403091836.1073484-2-david.marchand@redhat.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260403091836.1073484-2-david.marchand@redhat.com>
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
> The mac_addr_add API describes that only the 0 pool should be passed
> unless VMDq has been enabled, though there was no validation so far.
> Add such a check, then cleanup the related operations (adding, removing,
> restoring).
> 
> As a side effect, the net/cnxk does not need to manually reset the
> mac_pool_sel[] array.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

