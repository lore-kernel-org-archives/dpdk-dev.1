Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E1BCD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:36:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D42514025F;
	Mon,  1 Jun 2026 11:36:33 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 559F64025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 11:36:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru F19FC6B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780306593;
 bh=e2WvFTBw5xlDwmIM51oUAGvPE13IZO3uBecdJbgButM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pmNAthdxumrFXeJYQykfVWV7nh4jEk1bSVmhgD8rsP3IscDnVAXqvBDVnBcu463Sn
 u/sX4EZs8tdSJZDn0naEqbYXkYd9xzEESkCrVaZRm7cQFcF8gukoMV1drAf6lTcZBu
 FQx9vtZ4Dq/f/27fmBGcephrO25z2NM0386RE7ZY=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id F19FC6B;
 Mon,  1 Jun 2026 12:36:32 +0300 (MSK)
Message-ID: <325b0030-f3d4-4900-b13d-a518c164e95a@oktetlabs.ru>
Date: Mon, 1 Jun 2026 12:36:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] ethdev: announce VMDq capability
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260506123554.2524136-1-david.marchand@redhat.com>
 <20260506123554.2524136-3-david.marchand@redhat.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260506123554.2524136-3-david.marchand@redhat.com>
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

On 5/6/26 3:35 PM, David Marchand wrote:
> Let's mark VMDq feature availability as a per device capability.
> We can then enforce API calls related to this feature are done on device
> with such capability.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

for ethdev
Acked-by: Andrew Rybchenko@oktetlabs.ru>

