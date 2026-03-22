Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9511D58CAA
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 20:59:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1A95402DB;
	Sun, 22 Mar 2026 21:59:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0761B4021E
 for <dev@dpdk.org>; Sun, 22 Mar 2026 21:59:30 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 627581570;
 Sun, 22 Mar 2026 13:59:23 -0700 (PDT)
Received: from [10.57.77.15] (unknown [10.57.77.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C1963F73B;
 Sun, 22 Mar 2026 13:59:27 -0700 (PDT)
Message-ID: <506a6ca2-8bb2-4d7b-bea0-4ba9a31630e5@foss.arm.com>
Date: Sun, 22 Mar 2026 20:59:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH] doc: deprecation of OpenSSL version 1.1.1
Content-Language: en-GB
From: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
To: Akhil Goyal <gakhil@marvell.com>, Emma Finn <emma.finn@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "kai.ji@intel.com" <kai.ji@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Anoob Joseph <anoobj@marvell.com>,
 Raslan Darawsheh <rasland@nvidia.com>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>,
 Andrew Boyer <andrew.boyer@amd.com>, Vikas Gupta <vikas.gupta@broadcom.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>,
 Matan Azrad <matan@nvidia.com>, Jay Zhou <jianjay.zhou@huawei.com>,
 Hanxiao Li <li.hanxiao@zte.com.cn>
References: <20260211121916.2598788-1-emma.finn@intel.com>
 <CO6PR18MB4484DB317E6B27712F68EC2BD86DA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <6174edf4-ca48-4ac7-b1f4-811b5d5aa84d@foss.arm.com>
In-Reply-To: <6174edf4-ca48-4ac7-b1f4-811b5d5aa84d@foss.arm.com>
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

On 22/03/2026 20:57, Jack Bond-Preston wrote:
> On 17/02/2026 14:40, Akhil Goyal wrote:
>>> OpenSSL 1.1.1 reached end-of-life in September 2023. Future
>>> releases of DPDK will require minimum of OpenSSL 3.0.
>>>
>>> Signed-off-by: Emma Finn <emma.finn@intel.com>
>>> ---
>> Acked-by: Akhil Goyal <gakhil@marvell.com>
>> Adding more PMD maintainers for acks.Acked-by: Jack Bond-Preston 
>> <jack.bond-preston@foss.arm.com>

Apologies for the misformatting...

Acked-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
