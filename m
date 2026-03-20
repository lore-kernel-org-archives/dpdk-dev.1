Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A419E1093179
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 05:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84072402B2;
	Fri, 20 Mar 2026 06:44:17 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 58F38402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 06:44:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 177FA38
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1773985455;
 bh=2ugwA8WAU7CAwe522nAsb8IWSYWgNajdNhItdwVYo6k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SaNyZL7iMgPsZGaNnEnNc1NwdmPpAbkijHDRUTzcNYEFw5IEK54aTI2UBY2/WQlGA
 uyvxSfdOrSVsYKE0HEd9sMImVkjH5vfgjgOFmkCXHCb0xhqbmXL+Hww2OfvAnJl2wp
 sKRzb+h0j2rwfwtmkWgYJk3xGm3OfQassymzBd20=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 177FA38;
 Fri, 20 Mar 2026 08:44:15 +0300 (MSK)
Message-ID: <8f5e4d96-2e8b-43f9-bfe8-c79095813352@oktetlabs.ru>
Date: Fri, 20 Mar 2026 08:44:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: remove obsolete mempool creation advice
To: Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
References: <20260319091300.652853-1-mb@smartsharesystems.com>
 <abvmHkNQ8s_i38pB@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <abvmHkNQ8s_i38pB@bricha3-mobl1.ger.corp.intel.com>
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

On 3/19/26 3:03 PM, Bruce Richardson wrote:
> On Thu, Mar 19, 2026 at 09:13:00AM +0000, Morten Brørup wrote:
>> The descriptions for the mempool creation functions contained advice for
>> choosing the optimum (in terms of memory usage) number of elements and
>> cache size.
>> The advice was based on implementation details, which was changed long
>> ago, making the advice completely irrelevant.
>>
>> This obsolete advice was removed.
>>
>> Also fixed a copy-paste bug in the rte_mempool_calc_obj_size() function
>> description.
>>
>> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
>> ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

