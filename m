Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7C6CC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82C8F402DF;
	Thu, 15 Oct 2026 17:46:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 05A64402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 17:46:37 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BB3314BF;
 Thu, 15 Oct 2026 08:46:33 -0700 (PDT)
Received: from [10.122.30.95] (unknown [10.122.30.95])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C8A13F7B4;
 Thu, 15 Oct 2026 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792079196; bh=63IwzHXfsqCMMplGCjtNHJB2dgCkw+Ae/7BwnpKw+GI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rBQFZGqe3labXGC2ztnDggO0hBc18JmyrslQR1jJ5zRaA1E3JxztvBluMdLEJ4euy
 RnBu5Nkil0kDo3qvIrw9RXfK1mo0+OwdGpU/uuRsvBLZ5Ygu5E932tzY2MbUjdoD8f
 pCVA3rRmPHLDYHmOp6qIUQEG/KxbU2oobJFbOiFY=
Message-ID: <68a2da9f-81c6-451e-806f-ddfbfcd67361@arm.com>
Date: Thu, 15 Oct 2026 10:46:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] crypto/ipsec_mb: require minimum version 2.0 for IPsec
 MB
To: Thomas Monjalon <thomas@monjalon.net>,
 Radu Nicolau <radu.nicolau@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 John McNamara <john.mcnamara@intel.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, jyotsna.chitri@arm.com
References: <20260811112636.4106950-1-radu.nicolau@intel.com>
 <1ZyWCFPKR3SU1pTJ1PHaEw@monjalon.net>
 <6ecbe3c1-0925-4392-afd8-53c777495175@intel.com>
 <fjUyopQLSkieZRyFov00PA@monjalon.net>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <fjUyopQLSkieZRyFov00PA@monjalon.net>
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


On 10/14/26 09:42, Thomas Monjalon wrote:
> 14/10/2026 14:44, Radu Nicolau:
>> On 14-Oct-26 1:16 PM, Thomas Monjalon wrote:
>>> 14/10/2026 11:37, Radu Nicolau:
>>>> On 13-Oct-26 8:51 PM, Thomas Monjalon wrote:
>>>>> 24/09/2026 13:18, Akhil Goyal:
>>>>>>> From: Nicolau, Radu <radu.nicolau@intel.com>
>>>>>>>> Increase the minimum required IPsec MB library version to 2.0 As a
>>>>>>>> consequence, clean up the aesni_mb PMD code.
>>>>>>>>
>>>>>>>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
>>>>>>> Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
>>>>>> Applied to dpdk-next-crypto
>>>>> As usual with Intel IPsec MB, it triggers a compilation failure on Arm:
>>>>>
>>>>> drivers/crypto/ipsec_mb/pmd_aesni_mb.c:24:32:
>>>>> error: 'IMB_CIPHER_SM4_GCM' undeclared
>>>>>
>>>>> I have to drop this commit while pulling next-crypto in main.
>>>>>
>>>>> Please find a solution.
>>>>> I'm still advocating to merge the Arm fork.
>>>> Hi Thomas, the root cause of the build failure on Arm is their library
>>>> fork which lags behind, being at 1.5 release which is at this point
>>>> almost 3 years old.
>>>>
>>>> The only solution in this release cycle is to drop this patch and rebase
>>>> the ones adding support for 3.0.
>>>>
>>>> Considering Arm lack of support and contributions for these PMD over the
>>>> last couple of years, the only long term solution I see to avoid PMD
>>>> code littered with ifdefs and supporting very old releases of the
>>>> library is to drop the Arm version altogether.
>>> No.
>>> The only solution is to work with Arm.
>> Indeed that would be the ideal solution.
>>
>> If anyone @Arm is still watching this space, please chip in.
> Adding Arm folks

Hi Thomas,
We are looking into the  build issue and how best to resolve it.
Also, would be happy to start a conversation on how we could work on a 
combined fork.

--wathsala

