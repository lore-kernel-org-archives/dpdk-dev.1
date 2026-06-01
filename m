Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9375ACD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:32:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3CDB4025F;
	Mon,  1 Jun 2026 11:32:26 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 71B584025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 11:32:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 94DF96B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780306344;
 bh=EJ9WsR1Pslqzh62Kb0qCbngx46X1NNFP0KW0OOrhedY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rOW7D+c4uoL1W9ZYxeeoji4G0/PL1EtUIWrNdCFvRjxV3uEd9TMaWdvsuBR6QKf6N
 48/Pbvb0dcXofE8F9nuMDj3PhmZyEc/Z06ASP6tI3LXPbsFCHa+W2WSgvPMNa/Eoi8
 d0MdTOtCKuJrsfbtAvJAudgtHTUWaXHgpZjeuJhA=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 94DF96B;
 Mon,  1 Jun 2026 12:32:24 +0300 (MSK)
Message-ID: <e2346aec-e13c-4b05-97b7-f82dafe7e705@oktetlabs.ru>
Date: Mon, 1 Jun 2026 12:32:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ethdev: announce VMDq capability
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Rosen Xu
 <rosen.xu@altera.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260403091836.1073484-3-david.marchand@redhat.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260403091836.1073484-3-david.marchand@redhat.com>
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
> Let's mark VMDq feature availability as a per device capability.
> We can then enforce API calls related to this feature are done on device
> with such capability.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

for ethdev
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

