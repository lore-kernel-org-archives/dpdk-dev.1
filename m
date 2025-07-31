Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8148C83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 10:08:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 805154026A;
	Thu, 31 Jul 2025 12:07:59 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id E06A44025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 12:07:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru BD3F738
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1753956478;
 bh=0eoAOdOfpy3CghePcVyIxhr6J03PYJ3OOd5l6VOoKDk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vdUzK4/bqGdaHI+cS5hEj0E2+d/fE/Sy+80YbMRoQji8ShTJKxfJitiFpj1mspttx
 r4hiRFAIgbRt4QlNGdJdJlQduJa0GdT1pGy0cSpxKTgNYnyQfazvvUkN6C2pEqTXoO
 KGAURIwA3EgVDiSAtNzf7tw0WsGszwuCGhwK824g=
Received: from [192.168.1.39] (unknown [188.170.87.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id BD3F738;
 Thu, 31 Jul 2025 13:07:57 +0300 (MSK)
Message-ID: <e18b32c7-2aef-47ce-b9d4-e971d61b03bf@oktetlabs.ru>
Date: Thu, 31 Jul 2025 13:07:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ethdev: Reject conflicting TX offloads configuration
To: Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <aIs2O169emw39bQZ@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <aIs2O169emw39bQZ@bricha3-mobl1.ger.corp.intel.com>
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

On 7/31/25 12:24, Bruce Richardson wrote:
> On Thu, Jul 31, 2025 at 09:07:31AM +0000, Morten Brørup wrote:
>> When an ethdev port is configured for fast mbuf release, the driver can
>> use a TX burst function relying on the fast mbuf release preconditions.
>> Thus, also configuring this port or a queue on the port for transmitting
>> segmented packets is prohibited.
>> Checks for these conflicting configurations have been added to the ethdev
>> library, so the drivers don't have to implement them.
>>
>> Also, the descriptions of the RX and TX offloads have been improved, to
>> reflect that they are not only for device capability reporting, but also
>> for device and queue configuration purposes.
>>
>> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
>> ---
> 
> Maybe split into two patches, so the offload descriptions are separate from
> the conflict checks.

+1

> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>


