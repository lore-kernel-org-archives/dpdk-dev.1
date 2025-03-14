Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A70C28B2F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 19:13:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1410740263;
	Fri, 14 Mar 2025 20:13:04 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by mails.dpdk.org (Postfix) with ESMTP id 06F86400D6
 for <dev@dpdk.org>; Fri, 14 Mar 2025 20:13:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cD56RTnmuciS58Cpvm3KoqNmrlQ6TWjZWLwRM34dZ82RQjBD4rrq6I9daTGOMXzPcAOHwdL081Ya1/HEPM3T+YXgtJv1i95jdAKvIATp18vLtFN0KYyQF9oiUV9pt7BR8ITwK8c1up+GbQbI+lL+Cq8r1uHQb16CtBpS17pQePwH1RxZZ7IdzkzkNBv7DmROGu5kWxnpIOu/8IKtLZJksBmkBiQh6lK+vE5cT8Tj+rdMU5nshaDkAMoooP5tTzBFpJbexjbF9vLDCtdzWFL6r/f9nrVUkyrAQttvuOnfTOyHgklCie19/5PQW/tNxA7inqfl3atMXKYmTa0FE0SRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MGDK2Q8PX7XDOFbG5TkKqX4nd2tuz3htj2m5IrYsPg=;
 b=sxTdHSaC5gWtvKMCRS0M7vc2pXCDRVwskt7UnDywM/UswMSnVzzkidbPwUlcg8eehBBlS7SubyKFxAdaTfIFPr4AgfhKZGXOqedCESBPivWL+qimRMoK9+Y+NjzPqAWudrvAY6nfzw2ElpLScPgb4Zh/2Zte2QkJVo2nWU6YqCSr62WCcbnmiQtNwltWeARAaPSxyB3z9HyLZSabyz/960u4XPYVHqFPOT1L8HbbgiJLCAOIfitESYd3FvUGutuGzraRsO5pFOwcdlzBPnqp9CB/wuS3pcR1qVTG7jHeb4sZq4jzCFIHDXYydL8cY7kY00Sj3MjOeR0h+2U4IMPmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MGDK2Q8PX7XDOFbG5TkKqX4nd2tuz3htj2m5IrYsPg=;
 b=ZgyMhTQtlsyZ0N/VamPnI7pN/gxQdy3RKEcfUigG54ce3681ewMZwZ0M+xnhyTT9l5UXzasNBe/dUtSzPzn9Pp1jlNhk95QjV/AlS6hVMflYVud/GE6z6amun7JkZJAOVHU2NM8x9iitU0FglJP3ErjfMRdni6IFl02S3tnhoqyhwfApo40QtpTfEesyDXB5VdLK194Jvo8YQ6bPGOvB4QKznmybufiDHLPInIEbp5kR6nymSoLGqYa7YCqpG7Rw1xolTGb/veqD0WOdUeSBirZZRxekFGs3JicyxlpYNz0KSNzbCenXvHKJS5LJszw5K+KU9RoL8N5wxIX+kCHOpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 19:12:57 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 19:12:57 +0000
Date: Fri, 14 Mar 2025 21:12:53 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>
cc: Gregory Etelson <getelson@nvidia.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>, 
 "dev@dpdk.org" <dev@dpdk.org>, "mkashani@nvidia.com" <mkashani@nvidia.com>, 
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "igootorov@gmail.com" <igootorov@gmail.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] rust: support raw DPDK API
In-Reply-To: <PH8PR11MB680333949B01E4316CF44E29D7D62@PH8PR11MB6803.namprd11.prod.outlook.com>
Message-ID: <f4d3691a-489d-6767-8246-26291564640d@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250308185031.979893-1-getelson@nvidia.com>
 <PH8PR11MB680333949B01E4316CF44E29D7D62@PH8PR11MB6803.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a834b7-708c-4816-e418-08dd632c3a8f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RSXgI5mlU8enTbV2qEbAZRUcytJM2V9j87Dbqy1tm1tLYYcgQ3Y1aTHN0rtz?=
 =?us-ascii?Q?sEKd7fGbvlYTV/aSuwCSVxvTrAkWmipfUK5uaHBKQYYKdMaa0lQKezEslVT1?=
 =?us-ascii?Q?tVqBiRKnNjfaBtY052a0bLG4zVKmFoYzhfR5NFMqYPIqovvRXFFnrZSArG73?=
 =?us-ascii?Q?zheDx+3iqsyUHzBB8eiDM8SJw2hxaejO8gyx5gXrQw9z1APiZHG69OS9Y6I5?=
 =?us-ascii?Q?uW/s99weQuscSviOVmUmoZVkx06gnltE0mt2b8rUDf4pjjuEJDZL4V29es+6?=
 =?us-ascii?Q?1Ts7+B+gHcZGgGsbPkd1eKGCVu2UtHxl7Ci9iquE4QGY18NPdroAfLLddJSj?=
 =?us-ascii?Q?wHAwb4Kwgc6/nN8i8rCHgOqF/oHo7ybtOhnFut77eKQu4fSwP3FNyPrCk9Xp?=
 =?us-ascii?Q?cyTzoY1Mqz+pPKokg800e/cQaenAddhcUno++L6Gk3gBW8479xmktms1uyJj?=
 =?us-ascii?Q?LAArqj1eRA1iD+/rcsvR6IkLtsEDnwWDjwaMmBFULuR5S5x2+KcPmFTMalOA?=
 =?us-ascii?Q?k8SQNSSWLdC39pUTRStnFQjMPutFpm6MK9K+ArvLinbns6khZiqZh6KOxoGO?=
 =?us-ascii?Q?Rd9gYuP6CyBeCbkoyGvFdmZq/FAzwsl+ALhEtTQk0VzhTnHg310f1qX0fL76?=
 =?us-ascii?Q?sTxsEhSOmYxrb+n2c9Yqe6ZM2L+YJcEmzRGQiHVJ6M3SmNb/d8+59ihA7sFX?=
 =?us-ascii?Q?sWFTbnLzM+tBrY90X/xeUKPmHelNl54VvsZ7rLRmXtldpvVFtSgjWSM3GydT?=
 =?us-ascii?Q?9p+fsXbUetsoAehhgThq9YGBwMMH7ASW8wFShFqLTGsuq8/llbjL51cmXdUg?=
 =?us-ascii?Q?Ivjte1wl6KWSTlduVg+9FC1ksynBp1BeJaozBiM9ajAR/DzC/NhB6JkvYZep?=
 =?us-ascii?Q?LiRXnng+Zae4YupW7PqnSCvC3fXRiZPTcA3iXh78UO9C3KwkN5mjsRPe+XyI?=
 =?us-ascii?Q?ze78YEr3d94oCTAqDRN0sl216NeoSc+RukW/KKwsrxWyWwWl7tZlAEUpS4Cu?=
 =?us-ascii?Q?2hD4E0+V8KCNOCG+OUeU50E981zAaBPAB/ohfHX+8UPaUVi+WoIo3eCYuVzm?=
 =?us-ascii?Q?2FxzS/hAvGjCtTdZqXoJmQw3drQFg9dgy2JWavoxYiCE89HIvZqpWAnNoyGf?=
 =?us-ascii?Q?rAsvApcFyYGbZkzRPBhDvZmI+TtnkKbHBY6jCRIKFqtHKSAWwOvMknohnfg3?=
 =?us-ascii?Q?mnzX7wxW8Aw5LUNcOH6bbRCmewAe1d8wDhHJakt/XSL7eq/XVxwys0b/nbbB?=
 =?us-ascii?Q?WdzfehAOnHFp5EZaaANv4/vUf/09M9+uQQMviUacUbu++PU0uf2dOn3ZgO8X?=
 =?us-ascii?Q?wGi2jnhohlPZ8XEJaS4xT7hUN4fBWvHvY9gTfSgulWisOwnvrH7/KJNKs/ad?=
 =?us-ascii?Q?1h3TQ8iNPD1TTUMeIxVdgvZ3xZN5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I6UFuE5o1h+S4GYT9laGP3G71d0RdOz1j6E2A08tYy46uRyAGmNGSP7LesR9?=
 =?us-ascii?Q?lE/jofcOhGlkeLkvdAEDfmtiFAauWJQE/HsA/hw36AQ3gFNp7HeNjX6Fic3v?=
 =?us-ascii?Q?yqEFmdhU/BQmM8ZcRxLb3/kYXkWP5VDPSLNFz6QPvi+dOPTbBNvhsBlEYWsL?=
 =?us-ascii?Q?QQXDrzG929Yw6uqi6c8m/TffYEE080Ez5lcVMHI65foPOKLen2G03ivfO6jE?=
 =?us-ascii?Q?T7WSPCO2qZqlxDU4mT5BiBbdEWZ2BVS5T1OcpgJpuXoFZ8hwqYSb/oiCnsAq?=
 =?us-ascii?Q?HHCz2r5c0uxCDXgZ0tA0xo7ge39oQuwlspIpjB9B9uYnYllP+Nb7EwjLnutZ?=
 =?us-ascii?Q?OShyWVsigfRNgZFM55Ph4s1bQ03sEQxkT3ffxHLa/PO8Cy2oJUpMePnU35QQ?=
 =?us-ascii?Q?1rTY+i5T/tJMJdBj+G8L9mTyDskIc9LTvlRE4DnseJu7xDmA6WIdWkABkSpD?=
 =?us-ascii?Q?sYuzUf2Vuzc+t48gvOfssvgyKgN8XZ850mKKIR1bc6unzfn5LmL8ioOqie/W?=
 =?us-ascii?Q?zBT62IuFLnhPtii0V2nk0uJ2CQF8rUbgB9eLjoD67NOtUEIqAfOM3yMvEPlc?=
 =?us-ascii?Q?85gLo8Gsn6PIFFjmnuFtjMo19DZ3VedG8vXZojLDbsTyDOb9TR7S29DAIef2?=
 =?us-ascii?Q?hbA0CPEPvto4odafcwM/Am62VTdINgRX6gIvnLZYVrK4It08N21Vx0tWTt0e?=
 =?us-ascii?Q?WQkzhV2LBCa3zVrfZKFoyaYislfP7M7zDp9LJX5McJ0PIuy0vfkNxCVr89wE?=
 =?us-ascii?Q?zQMwf+l75lzIfVF8+CAvtlBk9remRMDzu4s5qx6J2PLWn0XCjo+CNu2mMwh/?=
 =?us-ascii?Q?NrfqEXrI5iq/bTM1cS8zyGrs9XU8ojJVqQyx1bsdnjPvm85h8fu//392VoOx?=
 =?us-ascii?Q?c2Nsx4+HPGay2YZQUcsIGLCOjtuCBS7Tug2gwA6sjkssReFgWhLClrOUeCnJ?=
 =?us-ascii?Q?ZBau7utrx//wbLY5YzstQUO5+xIsDImOSmrH0gwlHj7t4M2rFTqB9d3cBgNd?=
 =?us-ascii?Q?R5rCovyMijm96Km7pJbAqjor4Fa2Dwcv7fy6MxdCK0YRiztBzknzaoyA2aPT?=
 =?us-ascii?Q?Kn+prpJvt/joB//pixwFZdb1SVzrukEQJNX6GAwhR60CLMcWAnz3y3juPm09?=
 =?us-ascii?Q?Xe1nhGG74FDgNtEewAdij2h+xX4L6VD+387nVVbDzP3eTTjdNXHvccwM/sap?=
 =?us-ascii?Q?KNf5dIHp97p1tBWmPTQks3wgbdess1+Vo2jKw/EZ9HlMLBZl0smCx6TKjCWG?=
 =?us-ascii?Q?TgKhUYS7vhCkGn5rZ+j+cBds5Rb6EZMO7qSuEocTBwUfTg0tEM/2PwdbdQl9?=
 =?us-ascii?Q?QC9cWvu89XJGbaHVP0TPf3VVEyYiGwAxwJXIChQ2vzm1Qr9EJrcP5exOr8XV?=
 =?us-ascii?Q?DZz3elHuXkNj0NPf4aKgoLcojohHHCG2ZNdlaPHr6H82Dcp0dqjlxoklpK72?=
 =?us-ascii?Q?EXSgQik/jVf2jkhOyx8/rHKcaCSetPsKb1CeRkzuUpYVzyp0o0g+XTHpyKPD?=
 =?us-ascii?Q?LK0lrXcyrZ5pNe76aM9rzwDbPxRu+Isx/70UJ7lyFW48AvwjDVZGAzZynKnH?=
 =?us-ascii?Q?Wl2LBVtqe+oynuTw5InP5TUfds9m/NrxX3oa4BFh7FGi9GAHT2v0u23upTih?=
 =?us-ascii?Q?Lk/kAD8c/+RVdjAfz6Y8eKzvXV97pmKSQv18NTHcEnPW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a834b7-708c-4816-e418-08dd632c3a8f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 19:12:57.0642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCBdczk0VMoy+i8ZO77QYbQUNr2SrQkrUZa0drFRc2Zbwso8KboR+1OoyjJUYQp6Q6HvkxU6A4qhElFxUwz3xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
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


<snip>

>
> Looking at the above parts of "Port abstraction in Rust", I'm not sure it really adds anything.
> It feels a bit "middle of the road" (aka, adding some "abstraction", but not going far enough).
>

Current helloword example is a POC for the raw module usage.
It content can (should) be updated once the API will be more stable.

> What if we took an even smaller step: remove the Rust struct concepts, and just call the "dpdk::raw::*" unsafe
> functions directly, as if they were C code. No "struct Port, impl Port", and no "Iterator<DpdkPort" concepts at all.
> That would show "correct" usage of the raw generated bindings, and provide raw API unit-tests.

In cases when helloworld is activated with more than 1 port, dedicated structure helps to keep track of resources.
Maybe that example was not the best choice for "helloworld" introduction.

>
> In a future patch, we can start to build "Safe Rust" essential-basics of EAL, and Ethdev. This is to abstract over the
> "dpdk::raw::*" APIs, "compiles == correct", end-user documentation, etc all as is normal in Rust ecosystem. Example:
>
> Today: V2 patch (note the "Port" struct in Rust):
>  pub unsafe fn init_port_config(port: &mut Port) { ... }
>
> Future Raw API (note the raw u16 like C APIs):
>  unsafe fn init_port_config(port: u16) { ... }
>
> Future Safe API (mockup, this needs thought):
>  let ports = eal.get_eth_ports();
>  for p in &mut ports {
>     p.initialize(rxqs, txqs, ...)?;
>  }
>
> Thoughts?

The raw API links rust application directly with DPDK libraries.
Such application can achieve the same performance as C application.

DPDK can have additional rust module - dpdk::native, for genuine rust 
interfaces.

With 2 rust modules, DPDK users will have time to build application logic
while DPDK developers can safely experiment with new API.

I see the raw module as a temporal solution before DPDK will have native rust 
API.

Regards,
Gregory

