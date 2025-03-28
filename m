Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F9BC36013
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 18:30:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A4BB4028B;
	Fri, 28 Mar 2025 19:30:33 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by mails.dpdk.org (Postfix) with ESMTP id 58D594021E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 19:30:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xD/IhPgQnkY6SG+lm7yW/+aTwbpGCyCKhVZg8+eQYNifRLekdbjB9+HYK6dBcVXi32fTPWQtDacxvOzjkhDbYiPQXF9bJW6ekQdqk8f8AQ89GeAfOfuGsWiNww9Cn7ffkldbe/qD6IoSMq6wiqiyv4Zwy3RSYdhJ9YVy2LRFzsAtOH+vVT2babxM0EpEBLJ2sOcliG7FBQTmS87SNFVB+ItghlnZIhqauF4bne5zabMhplDtqM3gmp7aK7CeUebkjAmNZuOQLV6Mp27DPUqk0e7a1dOiKjkC6pWUWYx2OjNzY46R6+hwjJw8oi3WdvGrCwuUECjMs8+yzT+ano4Jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJEeCckoz4E4PBVLMDdNIdCyHB+4JEiuliRGKOLTvyQ=;
 b=YBEG9b54TSt9qjWYiOHLOg3d669SvxmvlzgqsG9aomdHXDQ442lwjSPmW0QZ64lZggOa/ywvr9sk5VoR5yKa+cfx9p6Z8nhaypUuzFs9lOHnzniD1/FWZLCK/0dgTVgnwXTLOs9EJ9dex0XzQipyT4Px+5Z1oXTutOvp4o48jrhnBW1E+LVNibt615fDU6lE7rxYwDHnEwLbwKxS/U/XFmkhKE5rBAaHcxDoFvgyrtGbLvXYj2tT73d++G4b604EXJf01zTyykmN71aS/3C3TghOzpCiDwkxFyHcNap5pRkM6Efavnu/O7zDFtkCVqnNIVxMkFkQGu2BDv6sX91Hhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJEeCckoz4E4PBVLMDdNIdCyHB+4JEiuliRGKOLTvyQ=;
 b=dbs/e49MOps4WLj72yOvwgMu9hubFgcXo2LHB168huE8G0jruGvwIWbyClFtVOkuE88yAhYFTtXhB9/myQyM4H8oR+Zi5PwtXQz3wgW7gcZLxa2osvJXvPVYt1/bnoMaxybggM6ebV+cQRamuo40XB478UtbLRgy3IqeGyFFn6XGC1GLPl7N3KHpMukPR7zC1SVxP03kz+tDjd4JP+3HcyPWxYan5ABR65tFAlocLc8DTDRU5ubA293vv5+Z2FV0lKt/eCwVfSFZouBbjxllR1HHO77iPqNvN2Jw1lugShpo0cqYTcoIpyB6S6yP9LzAK4v9jV8+MZsEGhFHHhaiog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 18:30:29 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 18:30:29 +0000
Date: Fri, 28 Mar 2025 21:30:25 +0300 (IDT)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
cc: dev@dpdk.org, dsosnowski@nvidia.com, harry.van.haaren@intel.com, 
 igootorov@gmail.com, mkashani@nvidia.com, stephen@networkplumber.org, 
 thomas@monjalon.net
Subject: Re: [PATCH v4] rust: support raw DPDK API
In-Reply-To: <Z-V7UmCfYEbkWOeY@bricha3-mobl1.ger.corp.intel.com>
Message-ID: <adf06aa-e6f4-4721-329b-b9d023254b3@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250322105911.12378-1-getelson@nvidia.com>
 <Z-V7UmCfYEbkWOeY@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 710a39d5-c49e-4986-5346-08dd6e269d9a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vG8z5cA+ehEiAmwDvczb/fRzpNMhz3BdcCvU3+jzDRqIvlB809kMV9zmh+AT?=
 =?us-ascii?Q?icY3NfpoRfaYWQZlBQJFB63wNey9KRs+d8E35sgkhdeWOjHG/oTfua64FEs/?=
 =?us-ascii?Q?w1q8ByvhPWzXNu4wkm+sUh0T0bqpS7CcZ46szN7Za2GAVShrYOHG2cwG1PdG?=
 =?us-ascii?Q?mLre5HWgPg3+YNFxb/QcrKiht5YYfCkysl+HEkKQ6neIh5HjuXPQXlCXyg4x?=
 =?us-ascii?Q?CNxYHtoCwFdEf930Ddzdm0Kc16ZfC//k/z5bqGifKMot7K+PLfgAT+ggv/Wt?=
 =?us-ascii?Q?VZst9D6BIwiuksmE0BWG55ZHOQAJRiVVUuTehpNWzTUHpQJ5ybilG0Vg1loy?=
 =?us-ascii?Q?3MidKDzVGLaqPW8p8aGTbHSX2jKcsLOgfe9jrZ6p7sScThNKbOxZvPx4W+0x?=
 =?us-ascii?Q?5Y01j3lgoIufWLrx+sj1SNmsArAv6t4p50sjwDxevp+O3xti0HdPIRtEblHB?=
 =?us-ascii?Q?4vB2p3tbSKdjhTfa93mTqQr2fxHpAAiQXOTLO8KDe5IdgHCgCzT/dyZKe9ly?=
 =?us-ascii?Q?+rEjAmHhKAAL8FXd/XI8KTYNQZeTlujGwQY8lCQ/sQaWvueSCu6mAq9ZJfQm?=
 =?us-ascii?Q?PrXuxUFUGMnPqG26Ebzj19ZYd7Hd4HZl7NnJWqafNxMLcKxyPL3AvicJ7VD5?=
 =?us-ascii?Q?+RyH0ky3+pDMcip4FDoaaqV0akZGCLvFM9gMRYx0/cfKz3Csg9o5vxpcgRPk?=
 =?us-ascii?Q?gY9vhxdPR+Iz1reS+vuP7HF6qrQirnOfNAfFzWCbte15wpvoh0HI+ZNCW38e?=
 =?us-ascii?Q?nJDalpPN5Mug08XCyJ0tu5Pw457RVv37/3RFTsICoyuVg/E/xL1/WIHmGECZ?=
 =?us-ascii?Q?sd27RY9mtJVo6w22xZacnnTtuZ8WpcHqmdvrpsq3mrnaMcO10Y+DlrCowISn?=
 =?us-ascii?Q?Yje0KC572+GP+ZtAJXRxsrlfgtWwtEBgo4nuyoeZWRjxG6Y95IV9tKdFcPKK?=
 =?us-ascii?Q?dWNqVvTJDMkWnFGaotnv4NwAeRGCLGhFGSbfAWBhRViz6F8B55h9L3vEjtji?=
 =?us-ascii?Q?LsPnnJ4xPp87/51U+z4aiLbvmErbrjpK/scaCiN21Dk0pYVZo8XfGk835YQv?=
 =?us-ascii?Q?XXpFhYs77Ihik3MSH1aHmKsQHqYKiO2kqO8OnsgjEjq5tu/vgnBbhl70io6C?=
 =?us-ascii?Q?VQZejZmJhew8/oyYSP/RF1JNAhTDqm5Zj8lW746DqF1Wvq+SLszqr1Vde2qi?=
 =?us-ascii?Q?HxHpujsWYpRqw65hhlBZb9jkJHSukvedlOhkuYyoPYeXFXVTcqyRhFkth3DD?=
 =?us-ascii?Q?FAQ1Bxz5y5PYSis6motH3SDBCpaHxe4OfEpLVaV9xQhYB0NpbvrOE1fBE9So?=
 =?us-ascii?Q?dFudOL4Excnv9Ar3aHkpT75M/Q/vNpEZXq5BhbKgubV4keRcT5AIXKrbtGZ1?=
 =?us-ascii?Q?E/sY6+FHUfabsZxlaMQ8zQTj+CE6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dYLnmwzwmA/wBUnMzr3n2KYMlwOA2oraomqY2d5I/5mYRp2T3vYOH0X3HzAY?=
 =?us-ascii?Q?06/m9qTKgURusZV806vnYwcud7BFxpeO/YlvWBHRl7kCOaCp15YFjV2CqPVZ?=
 =?us-ascii?Q?vX7jd5D/AOM4FZ6RS1SntaTZ2lny6aUZ+dppak5RXUHT5s5eqgQMEv6UKz4x?=
 =?us-ascii?Q?NIfzvcaNYwxC+PXVkeGnXqontyn+RA51oxT87UnznJ9IilordDsrfmH4x21X?=
 =?us-ascii?Q?kCQO+jMu36K+iMHPd3jGtZFF/LtNL5xhAlt7yGIRlTV+3HFSFz8cjx2tOTaB?=
 =?us-ascii?Q?jwSg/ytubbLVpMNFAYbqEtykHJJlC0pZu+BcPuxCjPoLomRpfqYm5ZIpU4iV?=
 =?us-ascii?Q?ZZVZcVNB6RIGhXCAEbbhHL3X8+oS2zO/mY8iuBmnP9ujL/y7UN7ZeuPp/cdG?=
 =?us-ascii?Q?SDXQQMWE0AHu0GR2c9VROWQWh4tW6/SA1ZuHPygSrPy5YAs2cAKnpZfKigSr?=
 =?us-ascii?Q?nM7yJODMf/1qquhgCsBx/EWAhcTaBzaZ6OtCbTyxzP5joF4cLmYY9YZgrO7p?=
 =?us-ascii?Q?U/4t24dNMI4CqgLK7o/AtlMCZpAzKnmqv34b7lfMUVvhLlQD/xGS+qbNa/Lp?=
 =?us-ascii?Q?xgItz7zWSFwsWwwkBqV41OXw63I+ryqRQtNl8pGPoOABxtKUgcaUpMYk3lnq?=
 =?us-ascii?Q?GvEWbBcwP6WjuLZNpBWdFXYpiLzq7+yScsY94Jp7XmWrdPKr2rv0HvuN/71b?=
 =?us-ascii?Q?osXWbyjDGLUFa2NEUqZkmQ6F7hYzXKQCQfs2HBSLojpAzm9iyR7B3p9H7MJ3?=
 =?us-ascii?Q?7GGZrM/XbU0FP4T2hBgwEpG/0eu5l9AjBJ5/RL1EJf8jcThjBD+axhljWed0?=
 =?us-ascii?Q?iADA1RnwVaR8PSpRvn7xbWSXzRxH3gFKrSVTVy7vymYO20fbFeexWjRS+3Aj?=
 =?us-ascii?Q?8LC9mQYyyqIoiDXpNgiIPgz3VzWWFECLbO4ZpEpAgo9Dg99wIwEFVoohTnYy?=
 =?us-ascii?Q?efA2hC8AHLN7ZWGiXSEkZM0HQp1++lPkOO0fqnoitvKWQs2/b66lgAtMEH+P?=
 =?us-ascii?Q?yE2mmXy+48becM63n8DGkVaWg7yoIMIahZfivzUzoSoNeCttQVWjb5Wx0JsV?=
 =?us-ascii?Q?dSfh6lwwDq34EX7ykDQX5VZOBEcA91hu4SzJupm9LMQPuLKwQb8UUF/MFBew?=
 =?us-ascii?Q?UxUjtIRyk1v1BfhvfQhmJL7DE7teK1MQj2DX6SZ9pzvvY0AFgMq68Uu9WnCC?=
 =?us-ascii?Q?0ZEjTk70hAWei9Q1Rne9v6h5Mj3w1zTz1f+UE1lUiGogGmHLLVieQ1VqQj9v?=
 =?us-ascii?Q?5F1CFL53xSLCfE3TBiSikXYq1HdJQLeBHPUbaFpX4JSjoMNeHMfqDIFfI5jo?=
 =?us-ascii?Q?NV2ILOA91+cdY+QsohkVRU9LHGvhGy7h5/yPKii33c6AXCxss0w7ggpzUudd?=
 =?us-ascii?Q?b08mIXcdyzv7yHQXe66NFWCH6WUwQGfkV5ZPC0D6oeUVfp9mDqS8U8uawhpL?=
 =?us-ascii?Q?RfrSgMtuLF3Y9SsJY9hO/BdNBBGaeTovM9SfRSxR6y4uM7/Xqs7likeMdTn0?=
 =?us-ascii?Q?OnD+37lX7G1pl2Nu6dWj9CwlWR07+Vrsv9o/xY7C1AwBi4NCn5ZX4WoeIMpK?=
 =?us-ascii?Q?SX1YzbyaaClxM1B9iWW2WKY6srKS+ayZQ83hLsV0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710a39d5-c49e-4986-5346-08dd6e269d9a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 18:30:28.9819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xjj+OuT8frXAfKmNeaV3JUjHdR74w2FyXwyxOYxS3/aDwZjEvUI4VAvkbNjPXSk0RAZnE9adMXy2Dmm2yX3jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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

Hello Bruce,

>
> When using bindgen, are we better to take the approach (as in this patch)
> of running it on everything in the headers and just excluding some things,
> or taking the opposite conservative approach of just listing the functions
> and defines we actually do want exposed (with wildcarding as necessary)?
> When playing with rust apps on top of DPDK myself, I've tended toward the
> latter scheme, but maybe for this effort we may want the former.

The current library produced a lot of warnings during compilation.
Many of these warnings were result of symbol duplication.
It looks like removing unnecessery duplicated symbols is the right way.
However, I could not activate regex symbol match in bindgen-0.71.1 cli utility.
At this stage I translate files from a shell script. This way I can translate
a single file on demand.

>
> I'm not convinced by having this done as a post-install script. Instead I'd
> tend towards having a rust crate hosted somewhere that does the bindgen as
> part of the rust build.

I'm already implementing that approach.

>
> <snip>
>
>> +
>> +    match pkgconfig.args(["--libs", "libdpdk"]).output() {
>
> This work of using pkgconfig should not be necessary in the application
> build.rs file. If we switch to actually producing a proper crate, the
> pkgconfig handling and linking should be covered there (I would hope,
> anyway).
>

I need pkgconfig for dynamic linker.

Regards,
Gregory
