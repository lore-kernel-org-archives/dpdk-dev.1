Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB96CA0EC0
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 09:26:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DF3040668;
	Mon, 11 Aug 2025 11:26:07 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 3FA3F400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 11:26:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru E024075
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1754904365;
 bh=O51iFAZ8spUpThEz7RKAetmJdNQfgNqStnQxNcotAj0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sn15mVq2nHYj0pLBOVjVyQ9Z0uVThUiXdC9yuXAIcsTYVpQtnfRP+UCNcB/jY1jiw
 LVMT8lwntacuuoMftN/cC/L+rhGS6lmFGgDhi0u1UxCzmHbJMCeFGTrDdGZ38puskF
 KEVjNanI1gJATdDSzyHI6e3VXjN2mOEqiIboEilU=
Received: from [192.168.1.41] (unknown [188.170.86.252])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id E024075;
 Mon, 11 Aug 2025 12:26:04 +0300 (MSK)
Message-ID: <49b0646e-6ee4-448c-ab03-8dd749cfc5b2@oktetlabs.ru>
Date: Mon, 11 Aug 2025 12:26:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX
 offload by default
To: Ivan Malov <ivan.malov@arknetworks.am>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250803194218.683318-1-mb@smartsharesystems.com>
 <95547628-7d62-56c4-c775-4d554250b9a2@arknetworks.am>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <95547628-7d62-56c4-c775-4d554250b9a2@arknetworks.am>
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

On 8/11/25 11:41, Ivan Malov wrote:
> On Sun, 3 Aug 2025, Morten Brørup wrote:
> 
>> Enabling some offload by default may conflict with a manually configured
>> offload.
>> Specifically, the mbuf fast release TX offload, which conflicts with 
>> multi
>> segment packet TX offload, was enabled by default.
>> Therefore, mbuf fast release TX offload (the only TX offload which was
>> enabled by default) is not enabled by default anymore.
>>
>> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> 
> Acked-by: Ivan Malov <ivan.malov@arknetworks.am>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

