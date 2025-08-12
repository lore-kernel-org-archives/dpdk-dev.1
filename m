Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE72CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 18:18:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BFD340270;
	Tue, 12 Aug 2025 20:18:25 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 67DB4400EF
 for <dev@dpdk.org>; Tue, 12 Aug 2025 20:18:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 21D8875
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1755022703;
 bh=afuYwyuzXPW6sT7OF36KhpiRn5KGO22iv+KUf10b8mY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QCwyzMad/q9RWvCp84g7uD90MhzeqmoEBFkHBcGZqWbLSTdRW8qqoyPtZQGWH2jgP
 yW1qSrGKGSGsbNclOvjZnh+TJqkDsaQi/A8vjFZW2ZzSB3JaaoEvG/hhCS4IK6KYno
 xONm3hzrDyfOOp+QPknjwDgVqpc73m/w1HDedZss=
Received: from [192.168.1.41] (unknown [188.170.86.252])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 21D8875;
 Tue, 12 Aug 2025 21:18:23 +0300 (MSK)
Message-ID: <4b1cd668-abca-404c-b1a0-79e91e908ab8@oktetlabs.ru>
Date: Tue, 12 Aug 2025 21:18:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ethdev: add link speed 800G
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Cc: Aman Singh <aman.deep.singh@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
References: <20250812144249.316120-1-thomas@monjalon.net>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250812144249.316120-1-thomas@monjalon.net>
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

On 8/12/25 17:42, Thomas Monjalon wrote:
> There are some devices supporting 800G speed,
> and it is well standardized in IEEE.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

