Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF68C36010
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Apr 2025 05:49:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BD6D40270;
	Fri,  4 Apr 2025 07:49:24 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013025.outbound.protection.outlook.com
 [40.107.162.25]) by mails.dpdk.org (Postfix) with ESMTP id ABDA34026D
 for <dev@dpdk.org>; Fri,  4 Apr 2025 07:49:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIxdIbj/jJL1EOhpEOjrHj9jJGiJLLcIiTdEwsTSeAuMbdIJ4LCq2RGpeOP/ygIgdjYX7D18JuJYE+Mn+bAOR//M+u/McBQQWayN2y54H+5uOo3hNcZsXFTrqC35ct6B/2FiPTkCowOOi5Z3D0YLq8EeKYHGLIg+4T8f5y/dbT4+qyoQtFrmJNUYW4o1e4yfSXDmBPwxtUNi+gpYvchdwewBmQY0JoOGmg38nLsVqFhPg5SALCFAs66Axho11eChP5Zlto1szgZ603Ii4uVLdYkbvmVBL9FtkBvZ4PixrJpKYs0tqdriGmeT1MEk6Wy/4rtmx3Pj2G7jzYAm6ZZFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeaZYyRMGtyDL3pyBXnuU9VF90K2XZ5qPO8MP7q5gnI=;
 b=asF0VVc8BFcYutmsol0tpJ3/wjdpI0N7Exd+bLjlGXG7WDcDvJSfrnSPlf5YU80xllnsFe/HYo3CjDHMiJ9qXzBrwZciNWcWokhetC0QeBlcyWGQ3S+g5AiS6Wgc9iFxxgCrDZdCP02FJukvA5wyTnE4DvO/6spA3L/RwvifElVghDWaDPtUXWEsDQ3+DVQkRMaQyUeZxNQXaj2O1zjasb8/m7dIxH9pe+znDLXLHNB0Ebl42jtGcb3qJ6mavK9x8uobOptOjSsZjGN9Y8VUS/w3iFZtEq9kNjXUK+C0UQ8zIgmOaozf/hJC2dEddEfq+5yYL48UgQZMH943IXQ5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeaZYyRMGtyDL3pyBXnuU9VF90K2XZ5qPO8MP7q5gnI=;
 b=hMRCB1myEq3/LgdLFAHKMrYC0Xvlcrzun+vU6i2K1CrLpVect2cez4a8J/POGvE3ZM2xMiwtmYfMfVGGkEfX3W2WfHousrNudCvr3LQ07sotLDTbIrgOQojFRZwcckG+kHFd1lNZUOt5hCMVHgGCzAspiEbAn9V9FO1zWk9d6esAedrH9XJLcxZ1IeCBTRLY3E4YIxiLAM4qR3acjL4Cysoc/s8z/pi8b1q9LHUvSTry001TkfRgDbXxP8ozvN7OgcSykd7Kfk3RmM+hDbdFNr2pU0e4c6DgVTXZpffXCuHvyP3TyJ5pjoGuu5qh3e0S5QkQhjnmDMQApLdQcRP7uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 05:49:21 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%6]) with mapi id 15.20.8534.045; Fri, 4 Apr 2025
 05:49:20 +0000
Message-ID: <ef319345-7e67-c539-4b03-39793caf311e@oss.nxp.com>
Date: Fri, 4 Apr 2025 11:18:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 5/8] build: mark exported symbols
Content-Language: en-US
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com, Nicolas Chautru <nicolas.chautru@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Andrew Boyer <andrew.boyer@amd.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Liron Himi <lironh@marvell.com>,
 Chaoyong He <chaoyong.he@corigine.com>,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>,
 Srikanth Jampala <jsrikanth@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ankur Dwivedi <adwivedi@marvell.com>, Tejasree Kondoj
 <ktejasree@marvell.com>, Gagandeep Singh <g.singh@nxp.com>,
 Kai Ji <kai.ji@intel.com>, Vamsi Attunuru <vattunuru@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Pravin Pathak <pravin.pathak@intel.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Chas Williams <chas3@att.com>,
 "Min Hu (Connor)" <humin29@huawei.com>, Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Akhil Goyal <gakhil@marvell.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashish.gupta@marvell.com>,
 =?UTF-8?Q?Mattias_R=c3=b6nnblom?= <mattias.ronnblom@ericsson.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Harry van Haaren <harry.van.haaren@intel.com>, Min Zhou
 <zhoumin@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Elena Agostini <eagostini@nvidia.com>, Zhirun Yan <yanzhirun_163@163.com>,
 Jiayu Hu <hujiayu.hu@foxmail.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Morten_Br=c3=b8rup?= <mb@smartsharesystems.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>, Gaetan Rivet <grive@u256.net>,
 Volodymyr Fialko <vfialko@marvell.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250403165845.1315380-1-david.marchand@redhat.com>
 <20250403165845.1315380-6-david.marchand@redhat.com>
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250403165845.1315380-6-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: 41201976-dc16-4e82-13bb-08dd733c71dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFEzTWN1QkZ1MmFSME43c3VsTUN0VmtXRzRZWTBhOTBNbGdvbEVSUnRHWmRR?=
 =?utf-8?B?M2t0ZlorbDlvM1FVZE1qYVVtVFUzYnhDY05zdnNHTCtJMndOSzc1OEthamxC?=
 =?utf-8?B?RmZVRHk0QmR2SGNENi8zRHUvMlcrWUtncVVlNkNCV0VTTWpXQzNlY25adUxz?=
 =?utf-8?B?ZVdtRFVQQlBwVkIrTFozQUxMZGZkcVYzdTh1aTB2NHJXQWw0M1NYb1ZESHZl?=
 =?utf-8?B?UjlTbXFLR25yQjR6dUE3Ri9JQnBNRFFTdHcvQ0p5M05FUTZVOU9UcjRLb1or?=
 =?utf-8?B?SEFrMGxmUFdkMkdLd0VnVU9nNzViaklZZHVRMnF0T1pidTVEOWUrUDVSYzZK?=
 =?utf-8?B?cHhzcjVJTGppZi9WNVd5UjAvdXg5ZEZzRTIveXFQdFJZMVJxR05WRUhsZStq?=
 =?utf-8?B?U1F5elVuUkZnR0Y3NU1hN0R1cFVkb0FGV3VBTHhINHBNdkdrOUlpOHhHb3la?=
 =?utf-8?B?bGxpdDBCYm8wK3ZJTGZ5OHF4dTgvUFJ2NStDRUtocUFZR1FoNzJBRUpuRkdi?=
 =?utf-8?B?RmJKUmZiSy85QUlCRTRFMHB6N3JubVExeE42ZVJWLy9zckVJVE5Fc0Rtb25T?=
 =?utf-8?B?UXEwQ01LNGl1a0hlc3BpWElLQzIyanU0b0FoVFF5cGxlREZnaEVXWFBadStv?=
 =?utf-8?B?cURQNklDcWxzN2JOKzNZTTMxelVHZWFyeE9SQUVCUmkvYlZzdTBTUlA2bWo0?=
 =?utf-8?B?TVk1S2tCUzlLWUxEUkNpTGxCVzZNR2Q3SEZIZ1hWYnBja2ZFRTJVN3U5U09W?=
 =?utf-8?B?TVk4ZnJmdVgzVUxnZVhkby9FMnoyQWRTZ1FxcWhEbHZsVHdRUWYvdTNnWDd5?=
 =?utf-8?B?L0lyZDFxTHNzUnZkUzBTYzZyU1ZacUg3eENMcVBRWnpSUU56SnE4b24ybTlT?=
 =?utf-8?B?ejhqYTQrc1VneEl2SkF5NFNnWFRVZWpHM3FpVXFaaTdnMmlCeDBvYnV1cUtP?=
 =?utf-8?B?amhWRjVnYjdJaC85WG9zd1lJZmN0RG9UMDhUZE5DcktjZnQ4RWl5blFKeUla?=
 =?utf-8?B?NE83eHNweHV1RkttcHR5ZEo5Rlk4SUxjVzI4eitnb1NxRXJGeHI0akNLNTdW?=
 =?utf-8?B?ckozMHFJMHRObUVyNWIxOWFaejhrbC94Uzh4ZW5uV1dja3pRbXBYZ3BMR2t0?=
 =?utf-8?B?V0x4aVlpbnZvWlV1ZkhOSThIQy9DenNTWlViK2JXYk5lSHQreHgvdjNjR3hU?=
 =?utf-8?B?VEg2VVAyUHNtRGdiU2Erd01KaUF3VE9hWnhzcXJFcmVEQmNCUVVncFhHNnVT?=
 =?utf-8?B?Y083UTZMNHYvWXh6RWtSVDg0ajhTVTNCZjNtQTk3UWdZK0dLbkZPTktNYTk4?=
 =?utf-8?B?WUhZbGlLalpGcGJEczlFRUNnRWhPT1p4TGxrUFZvY1VZTjhrd0V0cUZhRjBJ?=
 =?utf-8?B?cWlSNDNqTTdNdkUwd1Ivc3Q0QzllS05LOXl6bUNzUGZIYU14YjdXTkEwL0Zi?=
 =?utf-8?B?djQ4VHYwUC9ndGw3SUxXWSs0QkVuTkMzM2c5MVUxTStLeVRZa0ZzVWRFdmlk?=
 =?utf-8?B?dEdlamVFelAyWVlQVFBzUFQvZDc1dkNCMXlTRDkwY3Budk5OTVlzN0xvRlpt?=
 =?utf-8?B?VkFQam5JVHl2UU00a3RYMDZYVG8yYjdKUWtYRHBpSVZxT1lqNmQ3YVBYRzJm?=
 =?utf-8?B?bUlXVEdmakYvNU5ybVVVTnF6U29iQVdQVllCZ3diRGYxU25UcjU0V0huY0F5?=
 =?utf-8?B?Z2JONndwaEgrWFJQelNCai9aNlBkaDFRTXNBeVFNTkp4OEVyR1prVHVoSEFY?=
 =?utf-8?B?eWFhZ2RQOVQ2SXRRNlJMMmxtZS84M01GdTFpMmh5NFZ0Nk5nSXhpVEhkNkRz?=
 =?utf-8?B?Zy9pblYxK0pPZEFRZFIwbHlsdmpWdWtDVEtiYjJrUThhRnVvR0IwazhGbzYv?=
 =?utf-8?Q?bRV9guZDQM5Kf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE1NbXVORWlRTFJVK001MFBsa0xQdUlmSlhwc2xIdmVSMG92RlY1L2Z1LzY1?=
 =?utf-8?B?aGphMDBvTWx4OERDakQzOC80eTFzQmJjdHFQVmZNd1FPQzlMQUhRczQ1NkRi?=
 =?utf-8?B?anNxYzNvYTZDZXI3ZDNmNkdEdXpGMThTdUNBL3JGbHlvOVFQNnVOTkRVWVkv?=
 =?utf-8?B?Nlc5WjhZalowRHpMVGdTL3pzenVKbkhFQWhST1NxMFhtNENPeTZ2SVNjT2pR?=
 =?utf-8?B?blpQUmpSSzM4Wm0wdUR5RDNya2pockdrWk00R2FLbVpjL0VaaS9QNUZGZ2x0?=
 =?utf-8?B?eFo3M2gvLzZCckVySEtRV3Y1WVZSc29ZZTRCaktTNkRZSUxMY3ZRZ0FwMU5s?=
 =?utf-8?B?Q1JBWjdhb1llUmwxcHUwd250RGE3RnN0dDNHZjNLcU5ra1VYRkJGdnRNZ3lK?=
 =?utf-8?B?MmsvZS8xVW05SjRnQTVlelJidUJYQWZ6NTlSS1RmbVlOMlFvdUhldldnTG1O?=
 =?utf-8?B?VHZOaVF0Rnc2dUZMWTVVU2ZJQXEvQ1FUYjUwVllwejBSd0JFZ29meGpBcnFj?=
 =?utf-8?B?aFVLd25CQjZFRGVQVUdBYVVvWEQwajhETmdlWEM1S1gyeEtLUU5yR0hMbTN0?=
 =?utf-8?B?VG4yY1NJVy9rNXlzRUttb293Z2xzOHZQNmF2bGdCT1VsOGlXcEhCNDBjL0s2?=
 =?utf-8?B?U1loTThHRXk0VkVRT0JEZVJocGpjWkpwVE9Xc2tyVHJYOWIwcjdPQjZIdENz?=
 =?utf-8?B?bmUrWExNbDRsaXdDTDFnNnI4amQ5MnlLT3FVV3FiWEZ0dDNYT2pQMXgwOTlD?=
 =?utf-8?B?MjhFN1RpTGY1aWtaZnVWczgyWWhsY2lXdGFYWkltRVZBNnZnMXJNSHY1OFhV?=
 =?utf-8?B?Yk9wVGdIZUF0a2RUdUlGWHpUbXpIekxSMGlrTG93ZmlqZUVEdmtsM01YOTB5?=
 =?utf-8?B?c3NRM2ZReGxTMTRZY3N3SnMzZ3NnakhjdEpPOHA1dTQ5d3NaVVdQYm4xdjBP?=
 =?utf-8?B?c25NeloycTdQNHRhdnFuTnI2OHpaZE1sdzRHWmttVUdDOFhzd1AvbjQ0eXpa?=
 =?utf-8?B?blRPMjdtaHFhM2l2VnFqbEN6aWhLSVV0TzJwaU93NkR0SDY1dG81ZDJMMjMz?=
 =?utf-8?B?S0RUQVNNVjhqdHhoSW93akphMjZpWlIvenFtSzIwV3ZRd3YzM1dTMzRDZ2V2?=
 =?utf-8?B?YVQ5aXBmVXRnbUt2YXNTM0M0YkVFOXNNeURJQXF0TzdmM29TL1JSOUtlaCtP?=
 =?utf-8?B?dDljYW5XNzJMREt3YnhvWkljMVRLQ0NDdm1QSzBsVWlkWHFTa2hpWGY1cDVF?=
 =?utf-8?B?RDdJSzBLQ1FhOU5BbjFCMnR1NDAwcU8rSXRaU2ZHQkYrSWlTdmJHMTl6Z1ht?=
 =?utf-8?B?K2NmVFhsUnRubmVwSWc3RkM2dXZpZWFTNGMvTnV6dnB4SmE3Y1RnUHFEend0?=
 =?utf-8?B?aGJoTnMrendBWG5JN0tvN010RGtzdGVVQVpYdEhqS1k3WW9VUTVFd3ZqdGth?=
 =?utf-8?B?ZjRwSU4yYzZNYjBqVnJlbXN6OE1Mb0ZPSy83eFRhVVdtbnc0ditnM3B4c05E?=
 =?utf-8?B?UnNvWHhDOHRCR2JmZVdOOVppUnU4dzh3QVdXVEhlWjU5UWVZdU4rdXpTL1RQ?=
 =?utf-8?B?RWdCaC9IK0d0Vklxc0JPTFQzTUdvMmZ6VUU5enY3S3VSUkdGaHk1ZW5MVGxH?=
 =?utf-8?B?NjFFc0FWaGNCRExUY3d2cHd2QWkwYTRJY2ZPQmJ4ZFl5WDNTampGcFg3bzI1?=
 =?utf-8?B?NGNOU0psWTdwWTVPMGNJRFNvZHhWMTJ1b2lTeHVORlZZQnI5VmNKWVBOZzlC?=
 =?utf-8?B?eVlkWmxDTzBRYjZWbzVEU1BtODlMbVZYQmZwNjJFVWZGRmtTQXN0aWhiZDV2?=
 =?utf-8?B?WFErL0FrbDFQVXIvVWtHU3k0Y0RZeGlPdzg0OWVXNGJzRXdlb3NEMVVzNmda?=
 =?utf-8?B?ZS9sdWpQVzNyVnMrWExxZElxTWdEUENwRnhSLzJONHVxVlFRbXVtT0xXdHRy?=
 =?utf-8?B?MFBzYzFuR3UxZmZ4Q2hhUVhLSHBOTEdnUWIwdUJYaDRwWElzQmc4a1BFTmxa?=
 =?utf-8?B?cUw1VVc4YXBURy9HSVdDbjc4cHBXMnZwWWRUY0JGbjc4Q1cxM1B3cU5NUVFh?=
 =?utf-8?B?d2w4ZEdTMFI0YndDOTd6WmcveDFXVEJOQTgxTTdMdkFmUUljeXFOampnZG1S?=
 =?utf-8?B?VG1PQ0Q1andCYkJOVjV4aFhmT2ZFakJjTHhHUVFMNTFDNzM4bS9tV09FeExH?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41201976-dc16-4e82-13bb-08dd733c71dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 05:49:20.5320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7j+Q+C4cq2upj/SNE5UXdZXuaSrUwvYbPtu0Rz4TOf/YpNdmBBXHlZAOY8GschHbgCu2rExR3R/O2wq7WdWyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499
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

for DPAA/FSLMC changes

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

