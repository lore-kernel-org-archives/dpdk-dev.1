Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C7CCD98E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 17:38:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E6FD4025A;
	Sat, 20 Jun 2026 19:38:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C52CF40151
 for <dev@dpdk.org>; Sat, 20 Jun 2026 19:38:31 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29EE72403;
 Sat, 20 Jun 2026 10:38:26 -0700 (PDT)
Received: from [192.168.1.169] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 ED7483F763; Sat, 20 Jun 2026 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781977110; bh=FYS8UH/DIfs5syAPzHKj3zBsxty0vfu8dW5Es54b3CA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HfdsPDT7ndr6wgjc4sEGYMPkW7aeveVEu7pXVRVc0vIJ1SzmHL0VDpnTJW6HxYDYP
 A5cGJ8ctwt2sP840BPOU6Q68ZWbXUKdCn8LOmnWVKDak/gMcL7H8sg38Jn1fYwRD8T
 B/Wm9HoD+/i31dXmr8vZpQjK00pBrMbQSTE/IJqY=
Message-ID: <1eb241f5-3cef-4814-ab3c-13246a452513@arm.com>
Date: Sat, 20 Jun 2026 12:38:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM v8 rte_power_pause
To: Hemant Agrawal <hemant.agrawal@nxp.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Maxime Leroy <maxime@leroys.fr>,
 Gagandeep Singh <G.Singh@nxp.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F658E5@smartserver.smartshare.dk>
 <GV1PR04MB10750E293DBDCCDF9FEEFE00289182@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <09dbd9b1-f4a6-48e2-9424-546eafdfa01b@arm.com>
 <GV1PR04MB10750F8AC96BEFB29C1DD13BD89E32@GV1PR04MB10750.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <GV1PR04MB10750F8AC96BEFB29C1DD13BD89E32@GV1PR04MB10750.eurprd04.prod.outlook.com>
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


On 6/18/26 01:17, Hemant Agrawal wrote:
> Hi Watshala,
> 	I think WFET is not available on A72 core.
> Can you update your answer w.r.t Cortex-A72/Arm v8.0 architecture?

WFET is not available on A72. We enabled it in DPDK selectively for this 
reason.

>
> Regards
> Hemant
>
>
>> -----Original Message-----
>> From: Wathsala Vithanage <wathsala.vithanage@arm.com>
>> Sent: 17 June 2026 17:27
>> To: Hemant Agrawal <hemant.agrawal@nxp.com>; Morten Brørup
>> <mb@smartsharesystems.com>
>> Cc: dev@dpdk.org; Maxime Leroy <maxime@leroys.fr>; Gagandeep Singh
>> <G.Singh@nxp.com>
>> Subject: Re: ARM v8 rte_power_pause
>> Importance: High
>>
>> Hi Morten and Hemant,
>>
>> YIELD is a NOP on non-SMT CPUs, such as Neoverse.
>>
>> WFE is universally available on AArch64, but it comes with a caveat: the CPU
>> can remain in a low-power state indefinitely unless an event is triggered. That
>> event can be generated explicitly via SEV/SEVL by a different CPU, or implicitly
>> through address monitoring (LDAXR).
>>
>> WFET is the safer variant because it includes a timeout, so explicit or implicit
>> event-register manipulation is not required.
>>
>> --wathsala
>>
>> On 6/12/26 01:11, Hemant Agrawal wrote:
>>> Hi Morten,
>>> On Cortex‑A72 (ARMv8), the only architectural primitives available are
>> YIELD, WFE, and WFI:
>>> 	YIELD is the only deterministic, low-overhead option (pure CPU relax,
>> no entry into low-power state)
>>> 	WFE can be used as a low-power idle hint, but it is event-driven and
>> not time-based (it may return immediately)
>>> 	WFI depends on interrupt wakeup and is therefore not suitable for
>>> tight latency loops
>>>
>>> For ~1 µs latency targets, the practical approach is a hybrid strategy:
>>>
>>> Short waits → spin using YIELD
>>> Slightly longer waits → opportunistically use WFE for power reduction
>>>
>>> A simple implementation could look like (not tested):
>>>
>>> static inline void rte_armv8_pause(unsigned int iters) {
>>> 	if (iters < 64) {
>>> 		for (unsigned int i = 0; i < iters; i++)
>>> 			asm volatile("yield");
>>> 	} else {
>>> 		asm volatile("sevl");
>>> 		asm volatile("wfe");
>>> 	}
>>> }
>>>
>>> @Wathsala Vithanage — would appreciate your thoughts, especially if there
>> are any micro-architectural nuances we should consider.
>>> Regards,
>>> Hemant
>>>
>>>> -----Original Message-----
>>>> From: Morten Brørup <mb@smartsharesystems.com>
>>>> Sent: 03 June 2026 17:26
>>>> To: Wathsala Vithanage <wathsala.vithanage@arm.com>; Hemant Agrawal
>>>> <hemant.agrawal@nxp.com>; Sachin Saxena (OSS)
>>>> <sachin.saxena@oss.nxp.com>
>>>> Cc: dev@dpdk.org; Maxime Leroy <maxime@leroys.fr>
>>>> Subject: ARM v8 rte_power_pause
>>>> Importance: High
>>>>
>>>> Hi Wathsala, Hemant and Sachin,
>>>>
>>>> Over at the Grout project, we are discussing power management in the
>>>> context of 100 Gbit/s latency deadlines [1].
>>>>
>>>> rte_power_pause() is not implemented for ARM v8 / Cortex-A72.
>>>> Syscalls such as nanosleep() have too much overhead, and cannot be used.
>>>>
>>>> Any suggestions for a power-reducing method to make a CPU core "sleep"
>> (i.e.
>>>> do nothing) for durations in the order of 1 microsecond?
>>>>
>>>> [1]:
>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit
>>>>
>> hu%2F&data=05%7C02%7Chemant.agrawal%40nxp.com%7C06a651571db
>> 545d47d7a0
>> 8decc67908e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C639
>> 172942353
>> 967617%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYi
>> OiIwLjAuMD
>> AwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
>> C%7C&s
>> data=7NCh3%2BS3TAu1sRLYgqGNAaTwqdgwjqhAs2awPixIeEM%3D&reserve
>> d=0
>>>> b.com%2FDPDK%2Fgrout%2Fpull%2F624%23issuecomment-
>>>>
>> 4602036364&data=05%7C02%7Chemant.agrawal%40nxp.com%7Cdbff5f2e
>> 8db1406f0c4008dec1671791%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
>> C0%7C0%7C639160845728472826%7CUnknown%7CTWFpbGZsb3d8eyJFb
>> XB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTW
>> FpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=DRpJWjm2yaF3Cnhk0b
>>>> bFFhmGbKRweOOiWdsWco2NbX0%3D&reserved=0
>>>>
>>>> -Morten
