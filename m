Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECBFCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 08:51:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBA6E40267;
	Mon, 18 Aug 2025 10:51:03 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 8EA0C4013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 10:51:02 +0200 (CEST)
Received: from debian (unknown [78.109.68.228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id C3659E0C1B;
 Mon, 18 Aug 2025 12:51:00 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am C3659E0C1B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1755507061;
 bh=TcbiezARarh/yr9nL3HJyhgdO1UHwazYrH12whd19ZE=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Lq4QkRSm7yefrY/MphpoafcxLHa08hoWMXhRnT87R/D7N0etNB3B4h85DD1bHkoQ0
 Tr7IAGH7WcTYOj0/vzUR4L0bnPd97lKRZbtxRvyH/IN/alUVJEaPvJLV8mLuVYZWYA
 d4Kds22GHe5mp0YYOSVQBnU2lggJJEnmhlZiwwbvvnxN4sCBVl/eH1wlGaHMp+F8nV
 riZTz2FhcK8W7RHfHJDEG9VBMKuVUktt343MBVfPh7lrudB2zrvU0uIpatTKem4uL4
 GCmv+oVitja3LRs2R0F6wnQL2fMk88hnwqJxjkmbMwyGgcqyc984WCBq7jvihjEp/H
 ogCuig3UP9/ug==
Date: Mon, 18 Aug 2025 12:50:59 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: =?ISO-8859-15?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
cc: Sunil Kumar Kori <skori@marvell.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 1/1] ethdev: add support to provide
 link type
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE44@smartserver.smartshare.dk>
Message-ID: <8aca52f8-2fe9-9de5-2611-45919272bd46@arknetworks.am>
References: <20250813084508.1446318-1-skori@marvell.com>
 <20250814081215.1904078-1-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE35@smartserver.smartshare.dk>
 <20250814091556.6db159d0@hermes.local>
 <CO6PR18MB3860FCC393EF51C8664B364BB431A@CO6PR18MB3860.namprd18.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE41@smartserver.smartshare.dk>
 <3f847399-a91c-a6c1-48db-33f83fca9994@arknetworks.am>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE44@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-653001001-1755507061=:11764"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-653001001-1755507061=:11764
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 18 Aug 2025, Morten Brørup wrote:

>> From: Ivan Malov [mailto:ivan.malov@arknetworks.am]
>> Sent: Monday, 18 August 2025 10.13
>>
>> Hi Morten,
>>
>> On Mon, 18 Aug 2025, Morten Brørup wrote:
>>
>> <snip>
>>
>>>
>>> Ethtool has both NONE and OTHER:
>>>
>> https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/tree/uapi/linux/eth
>> tool.h#n2242
>>>
>>> Ethtool doesn't have a 3rd value UNKNOWN, and I think having a 3rd value
>> complicates things too much.
>>>
>>> I still think we should consider OTHER==UNKNOWN, and that NONE (having no
>> connector) cannot happen and thus should be omitted.
>>> Having more than one of these adds complexity, and I fail to see the
>> benefit.
>>
>> I can imagine the user having a 2-port NIC (and 2 PFs exposed to the host by
>> default), with only the 1st port having a cable plugged into it, where some
>> traffic received by the 1st port is intercepted by a 'transfer' flow rule to
>> be
>> redirected to the 2nd PF. While the 2nd PF in this case serves some fraction
>> of
>> traffic, its LINK_TYPE (or, maybe LINK_TECH) is still 'NONE', as its own
>> associated network port (the 2nd port) has got no cable.
>
> In this scenario, although the 2nd port has no socket to plug/unplug a cable, I would consider the 2nd port as connected by internal (on-chip) wires, and use the "OTHER" connector type to describe that on-chip connection.
>
> But what happens if a cable is also plugged into the 2nd port... now it has two connectors simultaneously. The same could occur to a NIC that is exposed to DPDK as a single port, but is actually connected via a port multiplexer (e.g. a 5-port switch chip) to multiple physical ports.

That 'flow' connection still cannot be considered a full connector, as it cherry
picks certain traffic, I presume, so still doesn't fall into 'OTHER' category.

However, how about 'null' PMD with 'no-rx' option passed? Is it 'NONE'? There's
also file-based use case of 'pcap' PMD, but that may be recognised as 'OTHER'.

Thank you.

>
>>
>> Also, perhaps port representors for VFs that can act as 'patch panel' to, say,
>> set MTU on the target VF, but do not expose Rx/Tx to the DPDK application can
>> have the link type indicate 'NONE', but this is a bit of a stretch, of course.
>
> Yeah, "NONE" might be appropriate here.
> So the question is: If "NONE" is only relevant for exotic cases like this, should we omit it for simplicity?
>
>>
>> Maybe I'm very wrong in fact, so feel free to disregard my notes.
>
> Good, creative input!
>
>>
>> Thank you.
>>
>>>
>>> "Because Ethtool also has NONE" is not a good argument. Linux has plenty of
>> obsolete stuff, which we don't need to copy to DPDK.
>>> However, referring to the reason why Ethtool also has NONE (in addition to
>> OTHER) might reveal a valid argument for having it in DPDK too.
>>>
>>> Anyway, if we have more than one value (in addition to the actual physical
>> connector values), they need good descriptions, so it is crystal clear what
>> the difference is between NONE and OTHER (and UNKNOWN, if we proceed with this
>> 3rd value).
>>>
>>>
>
--8323328-653001001-1755507061=:11764--
