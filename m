Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D141BC19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 18:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6D8540E50;
	Fri,  7 Mar 2025 19:15:32 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by mails.dpdk.org (Postfix) with ESMTP id 572B040E36
 for <dev@dpdk.org>; Fri,  7 Mar 2025 19:15:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRR/XoICzA+CDfe7WRBCS9wFfxgaKzgjrkaHeOnXInLwl+xhiI3vyQ/7ILDmfVuTRvMITM9zTbq+knTHljW3r8JRpV3DawxxbbsN9W7pX3ds8m3JUcnNcFxkVtPc/xzpuLKMM7/3E6FLkgLmAgRoY2daGIuB5MmUS1UHuysrrlkPIdzDuUvOmHMv4Wkh+6Mb8hn4WaqHv3EMqCmr1E4sDSj/WPfN4S+fsD0ROWjSzWcTVxHRK0X72fLUevbXUIxquEjqy17NSNCju2Ci7czh+HLQXWlv9v3KGlVyIkRQA0rreNv1vXpArZImqb0TdnAzQ8tLLsHa4kZUJgdDKUwlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzdHl9ZhqbqdkZ7fKvUSblBcU15OfbQ3BK+2K0BQ9Hk=;
 b=R958YsMk7tlND3nNqQ5BDWhGc2huqNRhVK8I9Cz2/Oe4+EEqqZmI9rFkUqnSWopMyts/qFzy6pADZJsDAr7OJ84VCBRwTVrUwRyF1gYaDpp7sZzi/KfClVYDjmMtUAmgPZpfiULC94McujiiP5XXhCjGymuhxKMGktNxXnUvtR1qf19Ias/JdGQVophJBT3vm38U/8xyxLS/wtq4Snrqrd+7RCW7w/rgpYlCaBXmBXtXfmuX1l2FaEPev6hyiurjzvkr9E45q4h9fJDXwWCabI8IE2KagMmP+XTJ/09Nr6HrduAuQFroQaNDqpXw76Dkj3jlYagq2x4EIgt7q35jxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzdHl9ZhqbqdkZ7fKvUSblBcU15OfbQ3BK+2K0BQ9Hk=;
 b=b8dt1+Vxub1oJjvUJfsPvBfO4o4h3zQppI9A09cR3ZPpmDlqKvOrteNh/6XEoECFuHtKd2pNh5dniexZ+QkJos+xchnSeW8SyJUXLDxX32rylVlGxaRy8QC1iNuSDFsKApFfI1CPxalAoIn1o8E6BEzqIREylyn8PwzlgoN+zVGiVOzNygz0nkDMKXmbnV4BrVT0O8nI/QTkjdC7+buUMFFrpqIwAJhEroWSs60GtiJLVIzW5vuLm540icALAMEMrVn9Vba5QWVtL3+35ztM2376TIp3fsIqN7nRRvH0/Fqu7rTlOnN0bnPGjcaf5Xt7rumzotGM5NKNBV6LBMULgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 18:15:28 +0000
Received: from PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8]) by PH7PR12MB6811.namprd12.prod.outlook.com
 ([fe80::8f8e:db0b:ddfc:a5b8%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 18:15:28 +0000
Date: Fri, 7 Mar 2025 20:15:23 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
cc: "Van Haaren, Harry" <harry.van.haaren@intel.com>, 
 Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "mkashani@nvidia.com" <mkashani@nvidia.com>
Subject: Re: [PATCH] rust: support DPDK API
In-Reply-To: <Z8sczC2L6zRKvGk4@bricha3-mobl1.ger.corp.intel.com>
Message-ID: <170e1f75-782e-4717-c5ed-8aecea25132d@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <PH8PR11MB6803599C6A152CD6B70465A7D7D52@PH8PR11MB6803.namprd11.prod.outlook.com>
 <Z8sczC2L6zRKvGk4@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: LO2P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::13) To PH7PR12MB6811.namprd12.prod.outlook.com
 (2603:10b6:510:1b5::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6811:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6ff590-55e3-4b85-0f03-08dd5da409d9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9qq3bxmb6cf9TvviR+2CVKG7cW8W2lCebynocUHa9gY3eA1nmkMgEBUCY7Gh?=
 =?us-ascii?Q?meRG2EebjsY13OxTBtdStQmZ2DpBCoSI30804ZG0/mXQwVTV/q+vvhZdO79+?=
 =?us-ascii?Q?wvgx/ssZr8CdRjFeiA60iJriTl6tZKL9874IOHRf/mkzfpLBPRA3LHrdo0xC?=
 =?us-ascii?Q?Rn9dPoLAxLnXaHT4oWtFeAPVuNLomrfDDYD8esi7KwU+emnRqIqFz7HbwdSo?=
 =?us-ascii?Q?0DVEzPUqHAdccTCsNf6pcNP3bh43X+WfdV6neSBV5mycBQHlMtvvWvW8KYNj?=
 =?us-ascii?Q?hRtIT79p0MZgM0pTf1547BsqQYN+I//E0zeyR+Rf7PMMgTKBxRA9mlY48j1o?=
 =?us-ascii?Q?RLa4NkE9NfzWFv8vwn7uFdPGnIOI5i2v0hb7KupcNMm67pIyJwCPCXRhhH0L?=
 =?us-ascii?Q?4H1bSS1+KrzccMABEwgrG/m4FjVDWpr69hY1N3WWkNaP6IxlUPR1jeoiFInb?=
 =?us-ascii?Q?LoWIG+BcuuMrLNBdRPRkIGTk5pjkKmALHYr19jB/P6b8vOO62lotfr9dgltw?=
 =?us-ascii?Q?eHj8QZm4UnrCn+IsJo6LQKg+Oj/ljD08mw8Ihyv+27Xavyy11PJLZr3NZ1rd?=
 =?us-ascii?Q?t67PXu9q4Bq4+6eMlH6RaVwGhNOcXlDS2+SkiA7jr2jA5eeqtUTLkjEyC4sD?=
 =?us-ascii?Q?A0IgmDzlq9gv+l//n600SP320cnl6u59ihyu76glzRTijQvQh4TLffwq12+3?=
 =?us-ascii?Q?yOaNzRGAYhm5s26Ur0St6VcJrc+xfSaxgKdu4bDjpSAS08kYuBeLbMBymCTK?=
 =?us-ascii?Q?Apth/zbpnOujpeSC+zpBWrxB7ZvfEJkjAzCQ4hrVayl7TK8lZdL6rn1gR4D3?=
 =?us-ascii?Q?VQIfItKVHbC18Vw7zUuINVpj6mYf8S4UsJ3hjVQez2EWU7ahSQXyS6C61wli?=
 =?us-ascii?Q?QJal6NTGS8nJALJS9bn6LzNkTtNhdcfUToNTV4HHY1iSXF7/u1ipo9mP8Y49?=
 =?us-ascii?Q?nLsrYWzjjTx0dQcowqduFiSCBLcvGTorfLnj5wS8/Zpquxbz1Cs5FnXR7cI4?=
 =?us-ascii?Q?tp31wCQkpJeClImgickdGjvf14PnondqH3I7bwoY/ayS6W2yH9sgjRVsLnbO?=
 =?us-ascii?Q?06Be9qbo9kOiQpgNNfMVT6uD3uaPjyyd8k3q41rNcU1upl3brWnRJXLHqVki?=
 =?us-ascii?Q?sVlIi/ru0mA/w6LJ0KXnZZGcJk7cVHbuiCuNJ8zjMg5+gmOY+4eP7wJnq1ua?=
 =?us-ascii?Q?zznH/1hQekg7Pa54NvAH5p3jGrFDo2tb+OiSs7wcrtzzx7ooUs3IxaFiorSw?=
 =?us-ascii?Q?YBtk9wR1kPNbTP97TL/fa0gbbtHUywRvclcrYSttoz+PXfZ7iAIcYEE+0bye?=
 =?us-ascii?Q?0k6BXRLc0wVXMz+YAEAuq6FDJn+vARjsoWt8CIV5uSkYv7wJUZO7nRy02C/M?=
 =?us-ascii?Q?rzcbvL4B+NwDfQrROp6metNSY1ev?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6811.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?psEnGYiR3S15M4dKBvFEf7g22rkh4F7Z0wIbnx+wo6rTLQmYVUW4lrqt7gSd?=
 =?us-ascii?Q?oY4z9NCzGarOcCMy/VYtAx5pL+QqGwshpVBfanuzVGSN7uG0AJY/00mkjn0K?=
 =?us-ascii?Q?YsBoLTcWqR2zfnQDQF2jX4Y8cRQS+MDSZxu+4+W4s37gcgQu8zxnr0SPvwjD?=
 =?us-ascii?Q?bxPb1PYu4poFy1hYo2YjDOOjw9mNkNO+JOEthvdMGC3/R9oM2mxygITlenZz?=
 =?us-ascii?Q?WLWO+cql6KL/uo5vdksOwtcEQIAGNmsolziRGVH0QY1a2MtUbiaIt+92J9qG?=
 =?us-ascii?Q?RRg/6zY5iApLdK9Su4Peb626orichXEkFX2JzBKmUW/wgb8cOEkyy+yHoET3?=
 =?us-ascii?Q?ZVsW93WaxR4TMCpKnSXandPiRT/1MMva+/vzmK7NNhonx+zNBGEnJ8aurRE3?=
 =?us-ascii?Q?HdkMDN0tmlVPNnWdroC7rUl18AU92+3Xv4GeG0KI4xmLSKg+KhNge1DrEcUM?=
 =?us-ascii?Q?f7EUA3xHYi7QVwCv/E8I5D5Gjc4mGn128uVmsZi1ocGlmlEicNTThkFDe5Yf?=
 =?us-ascii?Q?BXvAu/Cekx/31hTciag1WQzZJKWnE94kxWOB6RwqwGsmBJJmXabkU2NtKc/8?=
 =?us-ascii?Q?JmIDLjtzNhRmV0zW9KOp+OUwleq+tyXR1xlCT/dsAT2sDVo0iOD4ne9UODSY?=
 =?us-ascii?Q?EwcBXYpUM1f0GTc3posbDyjxvRj36AtSwzhJB25mU/LpOTdNWA8cR/96/Dou?=
 =?us-ascii?Q?YMIPhSDUttgH4OWsHnQ0kJc4f4L75EY9kqhx2gX7m7Cik0k8O4xCmmHgNJf3?=
 =?us-ascii?Q?VFaW4cFnXzV4Pykk0o/RIsaP36EBb/223rEEZm84OgVH5ItWzsMKv+eW4TFm?=
 =?us-ascii?Q?9/ZzMoCMe9LQO0FUrGae9xGHo+cX/4xm8vgEMT6Me01B0dhk7y/rmMC2Dkvu?=
 =?us-ascii?Q?7ot2XgdKARYBi24DCzHXb/q5rT258+psjX++PG07CRMYiMa2MNQNvNdwTCp3?=
 =?us-ascii?Q?yDlg7ldeI+EWJbjp3po2utTCc5P/OTgtFiSZ+yPww2KujRFgy0CTGzsEIDZi?=
 =?us-ascii?Q?0JZC6n+TMemeZohBwaO/Rf50ePMVhiubHI4+hy8vq2EtjO3+GiXWuY+RGs0l?=
 =?us-ascii?Q?NPjChK/h8c6k8nfXsuQdiNsZtZA4w+FBh6NxfRw8D6gNAR+CNzKGxOB0igo/?=
 =?us-ascii?Q?e9czc4LzFn/zC6DmRxlr4JBMX6J7idUcJspJf/ZsMVbGhVYJqbxCYvKka5ZN?=
 =?us-ascii?Q?yui5brENGnoqEpZFa0O351IhpQ5caqy0g6sMZP+5O0HVtUYG4/GpZ2hnv/GS?=
 =?us-ascii?Q?U6i+SwR+fU//mNRcTmZ8Rd7OU0RNfZK9f7E5MhkHjLvaFLnLPk8kYsvKfkVA?=
 =?us-ascii?Q?9JY2Pqo7HeWwVad9n6wxAWomipKjjdMRe78AQOif5MBm6Rdcdzb+c99G9wJp?=
 =?us-ascii?Q?BcuoT6hqp+mYdhwWkJCTPV8GQYggyWbjp4stMmMYe2QmhtW66vStaze6ypxO?=
 =?us-ascii?Q?eCSrtZkrdK2eQCMoWUoJZkql8aQFqSRcVxoca5N/O5EQzzAsE76+GwIjF2XI?=
 =?us-ascii?Q?IpuvzXp3jV4uBMg2ywJB/giixDyEuOa55KgxzmjS1NX4XQUcWdo/KGvysyCr?=
 =?us-ascii?Q?v9ncCsMSFbJsncHrQXasye2q6BO3sfGDJ7RmLPf+bfIPZNKn5xbsFzShOFSv?=
 =?us-ascii?Q?EwkfVFVvSn2mVdG+KnCnLT0ieMjjbt9PrY7AgF3+biYt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6ff590-55e3-4b85-0f03-08dd5da409d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6811.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:15:27.9424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cjxu3rGseJdXezELK4KVBlAuYzq2FoEE6gCnewjMNRMUDbUrBlG313mOJ4h9O1PSPUTMHVUfIdt5mgJbOOFGVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
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



On Fri, 7 Mar 2025, Bruce Richardson wrote:

> External email: Use caution opening links or attachments
>
>
> On Fri, Mar 07, 2025 at 03:54:33PM +0000, Van Haaren, Harry wrote:
>>> From: Gregory Etelson <getelson@nvidia.com>
>>> Sent: Thursday, March 6, 2025 1:37 PM
>>> To: dev@dpdk.org <dev@dpdk.org>
>>> Cc: getelson@nvidia.com <getelson@nvidia.com>; thomas@monjalon.net <thomas@monjalon.net>; mkashani@nvidia.com <mkashani@nvidia.com>; Richardson, Bruce <bruce.richardson@intel.com>
>>> Subject: [PATCH] rust: support DPDK API
>>
> <snip>
>
>> +
>>> +use dpdklib::rte_ethdev::{
>>
>> As per first reply, I'd like to see the end-result safe-Rust namespacing be shortened.
>>
>> This can be easily done by renaming the name= in Cargo.toml, and
>> removing the "rte_" prefix at bindgen output stage for each file.
>> dpdk::ethdev:: { RTE_ETH_NAME_MAX_LEN, ... };
>>
>> Perhaps its a good method to put the generated (unsafe, raw-C-bindings) in this
>> namespace, and build a safe crate (with the dpdk::ethdev::* namespacing) over it.
>> Thoughts?
>>
>
> I love naming discussions :-)
>
> +1 to separate namespaces for low-level DPDK wraps, and more rustic
> higher-level APIs. However, that doesn't mean that the names get to be
> ugly! Let's definitely remove the "lib" in dpdklib (or libdpdk), and the
> "rte_" prefix from libs.
>
> How about having "dpdk::raw::*" e.g. "dpdk::raw::ethdev" for low-level
> wraps and "dpdk::*" e.g. "dpdk::ethdev" for higher level apis?
>

I think that is good idea.
Application can use ether dpdk::raw::* or dpdk::* API depending on internal 
logic.

> /Bruce
>
