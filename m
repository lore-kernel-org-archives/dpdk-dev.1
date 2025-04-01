Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18170C36014
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 13:08:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9676402C8;
	Tue,  1 Apr 2025 15:08:17 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by mails.dpdk.org (Postfix) with ESMTP id A32BA40275;
 Tue,  1 Apr 2025 15:08:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frN+nFIMn0M97idONeEGgI+CuWQV+DZN++P9ZzoJlUaZNC/ie+5uLwT0tQmZZVup0tmdFyJNPFShX8QrvUnDR6XKqC0a8lJt84OQCdAUvq18aJOP0A9hmLxGKguw5IUnllkzpB31A6SjSGeOIL2R53387oYrbpSNJ1M4O01qvFEs4zzbAYy2qQqngyisksqbge/D+ZPTjOJxhQPbnD1Rx3JZecQ2FVmbJdd6gSk6EE3dmF/nVxdk3ks1MZVWcTpSRxP/ydb7wgOCcdqqBKlhThu0K1bn9AcE7hr5Zg6BTp6GDvqg2/MhXuLL3G77eQuNACuDHAYo9Y8uqSFpFaw95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWSLcJWwsnVnU7y4yC3hSroin0HjVyR22c6h+0ymdcE=;
 b=kXAPUWcsXBXxFW9uT1TZLTSGGRMVOEFBYuGax2PDlOdQkN+N7s3laAP88jxHYT0JJDseZhmb9OgGozL8zacSOVJLkxtkgVVTKKKTaxAPiEDIl1EGYOkd36c5nSsDUxdO5t4HzboSFj8pVKn80z7eEOdlWjzvA7L3+TnXoBQRy3YD9885/OqwUX8NDVj+CQYRgBCMClp805qtnDOMlY1t05HydhxKaPcR0z6+zcyNNIU9NUzHKC4aqVT6Vr88l5zHE3JkbQUEaASO2lBDkisgN+RjxDh5T7abJyjdvVSwD0IhRn8XKqDZY7fyWSy8L6HUlIhdESlTZG0JeEd6L/V6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWSLcJWwsnVnU7y4yC3hSroin0HjVyR22c6h+0ymdcE=;
 b=ZfYQLWfT7Bbi6PgY2504QJn8fIHMvYoDqbY1Jo4v/yOa7Q28xc4Ei2JWRnspsgix4ucDCfHYge1cYY/JaxKFE3L0UIhbk0Sq7fV/twNzzf/Mpwu+RHKFjh3b6oTfrPmC3r2jo3CeEiYmd8YahhW1M0h6LWed/3ftGbeaGdQMONOEX2/t6GtAMMqagF20fu8l9MqjcJ78dQUosJuEXWpSe2tvzxGUYzkxpEQLeri84OKLi9xwfmGfax9s2/XbxeDqVc20j/XnvLNAUB5rXBt5f9zxue9W0nOMGvzcVyCr/6KAcNLGoXtRfCUNHl3H+l7qTAGrSsYI5MKq3lGSuuYE2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 13:08:14 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::bffb:daa0:6f62:f5de%6]) with mapi id 15.20.8534.045; Tue, 1 Apr 2025
 13:08:14 +0000
Date: Tue, 1 Apr 2025 16:08:09 +0300 (IDT)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
cc: Bruce Richardson <bruce.richardson@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 "Etelson, Gregory" <getelson@nvidia.com>, 
 =?ISO-8859-15?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, dev@dpdk.org, 
 techboard@dpdk.org, thomas@monjalon.net, mkashani@nvidia.com
Subject: Re: DPDK for rust
In-Reply-To: <CAMw=ZnRoc8n-FMi6F0vLtGnZGwcqAgXc3h=35wqNkKK1qc3BQw@mail.gmail.com>
Message-ID: <543d395e-bb31-f6fe-4bd2-a0bbdfd0b912@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB79@smartserver.smartshare.dk>
 <461725d-3c36-9b7f-c02d-f630dc8bc725@nvidia.com>
 <Z-V6GohKhnK0ywu2@bricha3-mobl1.ger.corp.intel.com>
 <2e308be8-8ef3-963-cbb2-5cf68a3d3b3d@nvidia.com>
 <20250328122516.733217af@hermes.local>
 <Z-pcP_sbk5T-e7EE@bricha3-mobl1.ger.corp.intel.com>
 <CAMw=ZnRoc8n-FMi6F0vLtGnZGwcqAgXc3h=35wqNkKK1qc3BQw@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 27404b40-b646-421a-221b-08dd711e42b3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+nQyl2bzCmI7yod6W8FJwrWllfDRZB5X42vhCyvF3WZXF4G6OVp0xgRzbmj8?=
 =?us-ascii?Q?dF7kuD4vNX+SjubyvEm79fz7n5YvYB6Im2GQxOQhDgc92oVl2CtX8GIWj8h4?=
 =?us-ascii?Q?NmrbFAO3opAQPA7YQ+/n3yGhOj/BmqKES0xdX/YpeJ8W6uhEM1DvOjBmGZ30?=
 =?us-ascii?Q?9hsvsX88nZdrg1cp6/Lzke5Tkm9x3cPDt/r3WAht8zAZnWmb79/9/y3xb2iu?=
 =?us-ascii?Q?bnfYVSk0MKy5n/TUFyB3Lb83YSghO0aQ7bY4c459Oyk5rw/oh0uMUw8KpdoI?=
 =?us-ascii?Q?qTdIv5T0WVnu4WB2wk63xlqyr2+uNqT0v61sHzwIA3kf8nUq9w+pK5FHUppJ?=
 =?us-ascii?Q?RRB+tsIn0Krhty1uiUE/o5qtLG4VROxp/re0/BTJ/uMJmC3hQTx7Lmj7WIYj?=
 =?us-ascii?Q?Q4EV2F9Pf1k2e2W5futWY5jPTQh5+iJwpLsoyGjVAnm6+C/kkKlAS9fbrWUu?=
 =?us-ascii?Q?oDSfXT3T7BEbB1O1x9r/jtfzb7NF7esLcDB9X1eaaHvRn7DsnBULusNRbQkN?=
 =?us-ascii?Q?PYUDs7yuLbZS8SWFNwLKAyMdmv2eFmgyGNYn8HnkKVhnxKz3PCZsK4nXykAn?=
 =?us-ascii?Q?mgP2/c46xmR41AhyIQKb9dhWQQjAVLR18AS811/4XKA/tje40pj45oxUv8Ev?=
 =?us-ascii?Q?OeqFa03K0kIYSpQWlV/qsVEnRQFZxVsmtKDXmzmGulnZViuydm0we1QPMR2a?=
 =?us-ascii?Q?OmCye4nQnifQVrb6KBYl0d2uQS55CszrpFI14Dil6X4ilEtoC0LtTZuw8rm2?=
 =?us-ascii?Q?brUa4zgGWkgGx5eRz3IpkeeLcn6fJbwtqyn/i65O+oBTKKTZK3IG7+ffrsat?=
 =?us-ascii?Q?yXBQK1gJCpo0lSYqnwQFapXHh94l/4rd+1bAn9N4bVJyy3iFPS38HPfIWfy5?=
 =?us-ascii?Q?thgdcdDSNrQB7qv9gvrHxiXZFwkqfcgqp5190NpbUA/PboMovbo+tYvrPy2x?=
 =?us-ascii?Q?fMQIlw0t5JqEoXqozQ+sgHDs1QrfxrgpCWM/2R0NEIO1gtii3c1zp9lElo3E?=
 =?us-ascii?Q?vv7kXOTvRLjAa1dpEFuR8S06hfMXkrlgtIFtkqq7sDhRaqm7qf0PlEnv7+Co?=
 =?us-ascii?Q?FOr1Zg3wkqPxxejBgot8zqZ//IABZltLF2s0bjcs+dH77fsZjpWO3wAThQ5q?=
 =?us-ascii?Q?7D6VNwC4bSjKvegRCiHFfqD+pFPGX6LTV54Dobec+pSddltuM/ZUP6z5G1sN?=
 =?us-ascii?Q?NKyco4yG/H3e6wXIlY8KN3Cn57timoBFJ8KiQSIbPsy0jVuCca4CgMic2enU?=
 =?us-ascii?Q?1oP898g0ThByb6FuTjHBJ3cgYzRFCMxsZPTKMwNS762w5VVmjzU+8sgbjR5j?=
 =?us-ascii?Q?Rq00gzcQOxtOsOfRbkp/2yvTzcCosnHPJNt9maDAdJ+S7KPJUzTCMGA+c8zO?=
 =?us-ascii?Q?soqikcVhLCdk9GlPo9Yj3Vya02nl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BFQeZA7HJJVUMli33ZHaMsuWNAl+YiFINEHylKGRDufnOayovuBnt+WIj3Xk?=
 =?us-ascii?Q?epxjnr563+OOGFNn2pStTqoLt1gYkRwCv9FAvXkotCl7GAeBRr3WOBAe5Vmk?=
 =?us-ascii?Q?swxkDNjeMpwgrYMmAVHBqJZVomM+LhX6nZhGJzZHDl5t/b6vq8rGlzCtHIYu?=
 =?us-ascii?Q?woZ0TYjSTMBB96fS2ti6pt95B2Lpjyyz1zdkvysTLtHjNS1nCa7N0afDlYZ9?=
 =?us-ascii?Q?fpImu8oYWwGU17qGCuDVRoTlr+O4H2SZc8AW5+QCFGf/99nnAamrXF/k7Vzm?=
 =?us-ascii?Q?THPI9T0TYwIx9CboKAzX2iyxGaHJ4z5M29E/UEEtYUdpDAoK4z1fDa24bn84?=
 =?us-ascii?Q?+E9EOwDVXbexF6gpCagnkYIPo7noANd9Y8ZtbmBNI0zX5O4HXl7DJ6JqXmQi?=
 =?us-ascii?Q?iFFlnKir7f+LmlXlg0HfogzMQtK8RSODwTK8c+RrY4sy04vMwh8Nq0x0G2iu?=
 =?us-ascii?Q?zM8oZzgnunvDBIN31Rh/YGR02rgDQp6Rw6ifb5Tlu2XG+v0By1HzkE9iPjbc?=
 =?us-ascii?Q?MEt0jdOi7c4YX9fq+U7vs5u86XR3lwGdomzn7JRZRelK/z40PhwTUQ1Hu6kW?=
 =?us-ascii?Q?FHtD0hIQweyd5+FgxaRt5on8D1hATdXv1DaRzE+CRj0VVOhgoV/lFZKOmPqM?=
 =?us-ascii?Q?3HTzn3TlzlwZ7UGqfxQVyNFcO6WqBW1EMf1Sj4DSEetEwB00FtwNhEdGZG2S?=
 =?us-ascii?Q?loHRd6OhohLS15/l3XXHJKHZHDIdFZMkFCxQjtpJxPH0tECXuARjcVRepHXr?=
 =?us-ascii?Q?rI/cLpj9sBuj3BDS7SLvvzLrC09BNOA+0cyIpqEXRT9P4PDhodZ5Op0KAUE6?=
 =?us-ascii?Q?JNVj0nQUS4FZJ/dVQC9I7AFqvcLb0rz5gVF4gMnqrr7uX92vOzaZX+i5OU97?=
 =?us-ascii?Q?e6KU1wZLXFIAgdwxqzfLCDhXRx3tNYtxENwGGY7SHfgdj1dk1Z3V0VjHLGnq?=
 =?us-ascii?Q?8GfjtJ0wgvorbOmFMB7H8QnVXYWW9jljbr3tJ/zplyYjDz8AtLzOwvJIABcc?=
 =?us-ascii?Q?hi9CwFq7kXVlL1/YqFBU4tyqda49NFadnp3oPgGiPYSl9PEVrk9TgWOHb0SA?=
 =?us-ascii?Q?zHhe9KXu+hqHmU/kDlOpZQ8j5uYcbw840vHomX4DY3osePm7GGw31mc7sqKQ?=
 =?us-ascii?Q?DvT8k4ZsNLC7zzAoOSXCcubv8O1iAJ6hw3lRowiBztMWwwhsDcZvwzcE3ueo?=
 =?us-ascii?Q?QvNFxuKR5Gc8N1uPcG+84gepdeOdvya6jZ+WKXjAz7VQYHib/FGyplwrDbwi?=
 =?us-ascii?Q?6NH1Fd72LbFlaISWPSkVd1gksbJs7Fvdmlv/ZcgbpnQ7Oyk7gMSCeXsqsumk?=
 =?us-ascii?Q?sOstziYiLFLrNUCwPifuglIr9DW8opfoqvHzk2N9DyIxNy8W0wO+dRUBb0K5?=
 =?us-ascii?Q?MZx9T3wbYRJN67crnW2C6mG1znmDRg/DlIM6oN7q7Ll65bAA3+uJ166fdo+h?=
 =?us-ascii?Q?LQcLgq71AJB/6EExzg50b9BE1vluD7lQoS4bcm2avTFYEZ2hLHH9AHUjWjys?=
 =?us-ascii?Q?j/K/HBZYAPy22IyihQHOeU3p/2BpTMHAuPgccc+3zxlBs5xmoiGzMdprtlN2?=
 =?us-ascii?Q?mpXwiMAcGXvmCDo+EycduldjrsPydmrKjYxNoghO4qKTyRHy/vR4qI66oDPd?=
 =?us-ascii?Q?8xdNdA5ODYcWqozrG/IsQ5gTivCWCJNNR+HSawTbmnpg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27404b40-b646-421a-221b-08dd711e42b3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 13:08:14.0063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmMnXm+aXAe6EvJkv1mTkZcb5GZqTJGfnKGZywviZBtz5rSQHRpYkX4Ad2iZJOIbhRPujxkOoIcE33cuLywTKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
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

Hello,

I pulled the raw library bindings out of DPDK source into a dedicated crate and 
cleaned up compilation warnings.

Also I started a testpmd like application - runpmd.
At this stage it can receive buffers and insert flows with very limited items 
and actions coverage.

The total patches are big - over 69000 lines.
Is there another way to share these patches, except the mailing list ?

Regards,
Gregory
