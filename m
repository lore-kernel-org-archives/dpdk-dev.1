Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3108AC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:13:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 429DD40673;
	Mon, 11 Aug 2025 12:13:53 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by mails.dpdk.org (Postfix) with ESMTP id 27FB1400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:13:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8tLVQvJKgIIkgyAggmIX74WElqDvnUGcv8oQi4vq46kPw32j6BiDz2BFTq+FgphY91Ky7fJg7BRHt/Yk6XgRiXyRIH2K4zDXlscSzYkMTCIUACMc7CiKmHmGMByeSRRDb+2YgWwT0shjJzWLHkJ64AqID5hzz2z+kFDBSd3hxQhAfTlx/nAyA3EVyn3gpn6gmdxpT2Zod3OzdWgOYVg4pX6ipp7O6fYZFKfXP2KAwLTN8fTOJTpPiGj9wGUB9qrgb6qWnHEf9eReFbodXxgwRzOOjsH6HNhuhsT66YmsZKGVxil0YOToYTCKQ9JZlWOGpp/6wJ4BcqjEZ3R1Ru5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rX0llXE0YGfUL4LCSF+gMWOuIui1k8jasWBt1jaU9Y=;
 b=JLqH2PsrtII6REjIQeoNrIQotnYEYlku72UbaD3UBMRPl1upN4wm7Fus/PwR5gA/o3vr+wnSMbKAKIVdMUnSDDOAREFOyPpOpp1kdyFTpwAaKRn36y94c+y2BeOm1SwVpBuFLZiIxqcQWnNqtGQLagjHYWSzEdgt4Yd2LvpDySZqJsyUNc1x58vNc6z/SB9FfVKERHWZTEh2ZKni7BP0IwbWNCO3hw5JE9t8SmKft6MDnwykwiMI9hwXfykNsGHSidcF+QFBCJ5rWrwVnJoV7VurYVPHMus10Hv6R/hQyhRGC+/w84w6p0VdF1MrVKR+LdP/0JmPcb8P1sd4ASmxOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rX0llXE0YGfUL4LCSF+gMWOuIui1k8jasWBt1jaU9Y=;
 b=lt7PSI1+OCK30XoN9APVgCYUX1+s+vDDnavne+SqifBTbBR+hl/faIYcJ3EnpbhsVwU/k6ntAAvikQt6hjBILK6uj5PfAMfBzLvX/nDNbLwGWUAt7txh4OHqGcV6Uj4TSahKKDaVHAjCj/CrFJRhvDEhKRilXtfGiJsQQfBAZomiPGH8Oo/me7x7S98jym8Vex/bHJFggAPwA73H6FDraeBtBmWOBM7Swb8QdC0spEtLxr6pZDuRwATFC4Yrp1++e58KT81XNBR1nEh91Mvy1h3YoM5vt+0yJioLXBXf2hGMrZrptrygu24t2RtUvbZvwoPjiSCpmP1+gPAVbDoSbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 by PH7PR12MB9150.namprd12.prod.outlook.com (2603:10b6:510:2eb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Mon, 11 Aug
 2025 10:13:46 +0000
Received: from IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::3f88:3ed7:341f:3d0a]) by IA1PR12MB6330.namprd12.prod.outlook.com
 ([fe80::3f88:3ed7:341f:3d0a%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 10:13:45 +0000
Date: Mon, 11 Aug 2025 13:13:40 +0300 (IDT)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org, 
 =?ISO-8859-15?B?oA==?= <mkashani@nvidia.com>, rasland@nvidia.com, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 Ophir Munk <ophirmu@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix interface name parameter definition
In-Reply-To: <20250810214420.1b1b8079@hermes.local>
Message-ID: <dad56eb6-f773-2e4e-e0e6-042eb3044341@nvidia.com>
References: <20250810132300.124429-1-getelson@nvidia.com>
 <20250810214420.1b1b8079@hermes.local>
Content-Type: multipart/mixed; boundary="8323329-1594641287-1754907225=:29294"
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To IA1PR12MB6330.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6330:EE_|PH7PR12MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 998c286e-7fa9-47d1-a67f-08ddd8bfc18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?iso-8859-7?Q?P2VCCn/pcXS7Y+h6sl6WtnfzAirL7xm4EVzl9WhUGOMyggRRM6hcBb1tmb?=
 =?iso-8859-7?Q?x3M858X8A1XsDqFVYOcVe8Xcyya9QPFBfxPlrV5i3zrLMxepgGIuCOWtNv?=
 =?iso-8859-7?Q?frsIlcYRWI+eZQprpg0cS0kUnIMZHbbV3YMqRm91i9q0npcStmPtEZrj0+?=
 =?iso-8859-7?Q?ba03i3WXLip6FLkRwR1FPvQR4ImOclFm5WjPMS02lAhjnUyndsP7LjaR60?=
 =?iso-8859-7?Q?mganZBstVj6EWOI7WMHD8k4tjLioiBp8fdX69MQfAZ0zHiNkFLD1tArVFT?=
 =?iso-8859-7?Q?osC6NzfUuzYzAGXRHPPniXzpWOt5c5IMYMVuej7ZBsGIphViabHp5sJiIf?=
 =?iso-8859-7?Q?JOdHNiwOiBPQwFnc8SfkSJFlrPpSZ1wquu6CwPclWBwNivSH0EOSH/W/A4?=
 =?iso-8859-7?Q?jmPwpp6FXh1XbRmTLL3pVNOGQciLlVzHivspQEoaEKLhWVoPs5/FNq1xOu?=
 =?iso-8859-7?Q?3VevgRW/6qdOU9Yk4DsVssMn6kbbWgqtTJRK+WmyzTYI/CLgZS+OFSlwCl?=
 =?iso-8859-7?Q?0vjDBETjIIQtLjDFvQOgrHCpb3Avv8yxPySOLVeCpMe4HKsntKUI7hHIGI?=
 =?iso-8859-7?Q?63Wh7IXTXlUvpEItlDVvTWzJhRwOwziQsQiXJuT+W79oKVgO9BagHR+Qy9?=
 =?iso-8859-7?Q?VSd7YbW56M9rxiJFtmXeAfTgQtPeumhG9BHgGnCEwO1w5g+SSaQ8Vj0FNW?=
 =?iso-8859-7?Q?8Y+qalwVMRxF/dhc5fsQWjiBwH0cG517Gntxw9pMs3BYbGbNPC7Jj9zGwG?=
 =?iso-8859-7?Q?aOTsUu/QIeAhkqPmrcimEWYeby2vI55aFLOHjiq1LoAREiACU9qbD3j+Tq?=
 =?iso-8859-7?Q?DkqvaQvfoKZ4nQ6PVLD7Cna2riciKgMsmA6znr/LY8JFl+PcSrz/Q8FCIZ?=
 =?iso-8859-7?Q?Uyf8SG4Sb8xEghgaKj9AM/ScjyGzer5B6hl5ahf2QiRDXEWY/jgZwMhR1g?=
 =?iso-8859-7?Q?5m5EZYmWI9c/i7+U8LrJ16+V7a4tzUi3yl2HvlN7Vdebt0ICKUCvAVD7Ni?=
 =?iso-8859-7?Q?8blzJT2fXVTVoXXOEty0OFOnOctNigp868awSrrIoz633SFdzQQeZ3YlxM?=
 =?iso-8859-7?Q?FtELqE5uggiepcWKSeDbFZzqKoOviAdCt6i5U8gty1A6MS9JFJGpqDaQIb?=
 =?iso-8859-7?Q?VcBzIaHJymrtJlSeXhCdx8l7sRcnlyb8f2a8aGVRfUf5dkWMWvniEA3l8h?=
 =?iso-8859-7?Q?f9XNc0kGREVJA7b8p30eUM9dyR9iIAtI2pa3peQ+P3KGyPv5N4c83WjUov?=
 =?iso-8859-7?Q?uMYmxlhtJRvDvNIvfpHI/qkOARx0rXxb2BapZnTpwI21lzlG0Z6fe6cyf+?=
 =?iso-8859-7?Q?OzbWf56sVaH+UVNA2DQp+g5lenXjtCXxF7X3TFHqd+UJN8mJi+W5trOhmK?=
 =?iso-8859-7?Q?IYCo03x/vD9ALJ24HhztkvQh2vG9GR18AH8IH8CVhBQJTEexTyqNn2reNl?=
 =?iso-8859-7?Q?jT36x2epzJ5/E1b8uJJ2LKdgcd7vBK0hQmVifxdjiqCLfsdg3/RyadQvm2?=
 =?iso-8859-7?Q?U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-7?Q?CgkVaCvTtKgdvtruYg/EL0VFAM/QbpJ7uqY6TdbyhgUi8MlQSB2RRCyC0G?=
 =?iso-8859-7?Q?yWqAHBQpdHxdwN2g+PGlCmP9nnzStTvyjMsrfOudD0mZdA2x0UR2O7vR98?=
 =?iso-8859-7?Q?vW9nZ8coiXkUw9y+KUbjp1yTrM9xpO9toeKcX5y0AXnwmMIlbkO2z7sS6J?=
 =?iso-8859-7?Q?VSRvrEIn3KMtoMzoMKH+cYVO4LR+cQNMvTbQjbJKhF1EP5SYQKhgYt4yeI?=
 =?iso-8859-7?Q?XYgyGOJWVw4tKgj0dlsn7Ht7s78MkvScAA5lU3Bmy8+eEv1vUFN9zslHaX?=
 =?iso-8859-7?Q?HeZcJ3uPziRhhQb3I8sNMQnVyS57wKpUfm7DhBA7Vc+6ZgKHOEZLuAqgWN?=
 =?iso-8859-7?Q?zpBJWCBtrc+c+M5G3c1itRr1xFfS4atYIrsnWqzlN0gmRpEQDm4vIESqAb?=
 =?iso-8859-7?Q?8owDCpBaJhnVSNGx0ktwoQp0JjKgjDpn/vu8nAcxAidBeQPHQgvjyPNHDy?=
 =?iso-8859-7?Q?c1545DQEsRhU/flig6FWTJeJ1cJ1/9CMaSzLaBbTU4jv8BLU3I6v39xHNP?=
 =?iso-8859-7?Q?0RqDLAeLWYt5omB1Um1oJPRNiSLI9dDY1oittGdXy7Ombo6ziuOpzOf6Ae?=
 =?iso-8859-7?Q?HV39RtJkS1ssM2MAfeORZMpEXzvP6RzgIITIn2mY0PyXTkbRulTr1Kh4Vu?=
 =?iso-8859-7?Q?7E0ZqPbpriVakVLcunTAEXawQD/HuLoPCXav9sR21UT1DRTAZ7Qgnh8wuK?=
 =?iso-8859-7?Q?lmlN7Jgpro1Ol2VSXERbYKWVSn+pkwDwl3lCbuL7Wjr920dpPodyJhsiCl?=
 =?iso-8859-7?Q?HQ9ucUqi6SVUduq3TsnXGorGelNuBDL4Hb8Ir/oqulkQzjhvx6uF8MMdoR?=
 =?iso-8859-7?Q?SXAyyR+KgtvRIRwcdOWTyMKb80Ol6xg7npmcCW4I75+q6jRQGTX1Yau4/l?=
 =?iso-8859-7?Q?fqfO/ke9WbpET1lcI2judrAQoX6bgEVQ41q4Kn9eZJUXnjSiS0HtPZMFie?=
 =?iso-8859-7?Q?xnc1DU7p/T+1ZavqMl+FtaLIIrta4FAQAlF5d/N0et1FPg7MyTXN6X3bUC?=
 =?iso-8859-7?Q?VNGNl+5cOEmYND4SoIN/iOTzJndm9pQj0gapZghaqoBlu+KEoMHK+Zb2dd?=
 =?iso-8859-7?Q?YD/4cwF45RjnAgvhgFQnOD6JXzio007FtAwWgM8aOIQh3Y+x/QFj516OtW?=
 =?iso-8859-7?Q?ew8Fo7dG9G4Sshl4jjOgBKH0RoTHuR/VyV3Dq6jootrfNOy4BnFYSQHih2?=
 =?iso-8859-7?Q?wJO1Cto1rwN7rZTbm8HwaKkey7lEYOZYz2wUZvSrSS5wt3AJvtT4/F4k6+?=
 =?iso-8859-7?Q?aEEq0UpxifWJ7y1Vbvt3A8riEZFbBooVb9sLmerou7s2fSYN1s1x8rWTeY?=
 =?iso-8859-7?Q?4jQAcffMb1Ans5+c8bgT/sobBox8F7oJx+t6d8qvrRFtL0MV1jBxB5RD66?=
 =?iso-8859-7?Q?sOwgczT8yNjqTVAzeRj9XGC60hqRbCrmj+y26YTNw8UV5Uxpeg7w54dkfk?=
 =?iso-8859-7?Q?keASw1fOJjiLIYBJZ7OiAU80acrFVHfWPmPGh2C7MeeChkKFW8OofRYYO7?=
 =?iso-8859-7?Q?ZGaxgg0U8URM98AvV6dZemh+vvraRGD62pGF4DBu6wf4MMkcJNtWHYmvSG?=
 =?iso-8859-7?Q?C1Qr57hU595F80qqSKfPlHWpLayDubDXEUuqL+c9JsuxHrOJluwQbknUuK?=
 =?iso-8859-7?Q?7CsvTfVAQhe5gEDQL+ZQ2ghIgIfn933Fo1gFYQHVpytBapJVwKxaSaf8Ed?=
 =?iso-8859-7?Q?6gOyeHGBiaizAuleL8UATK1Y8Y9EF2DldGC8RI/P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998c286e-7fa9-47d1-a67f-08ddd8bfc18c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:13:45.5820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0xdG6ZyjJr37KB00lqUGYvXVMZl03+wmxp+PplsmOFxC6yCUVGquyER2zltkIU0dkPZwtburmDyOaGAV30T7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9150
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

--8323329-1594641287-1754907225=:29294
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT

Hello Stephen,

>> The patch fixes `ifname` parameter as a character buffer.
>>
>> Fixes: 1256805dd54d ("net/mlx5: move Linux-specific functions")
>>
>> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
>> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
>> ---
>
> This looks better but did you know that the ifname can never be as big as MLX5_NAMESIZE.
> Kernel limits to IFNAMSIZ (ie 16). The largest allowable interface name in Linux is 15 characters.
>
> Looks like:
>        MLX5_NAMESIZE := MXL5_FS_NAME_MAX := IBV_SYSFS_NAME_MAX + 1 = 64 + 1 = 65
>
> Because Linux interface name length is fixed by BSD legacy ABI's it will never be longer.
>

The MLX5 PMD defines MLX5_NAMESIZE macro for Linux and Windows.

The Linux definition is in the drivers/net/mlx5/linux/mlx5_os.h:
#define MLX5_NAMESIZE IF_NAMESIZE

Linux API sets IF_NAMESIZE to 16.

The Windows definition is in the drivers/net/mlx5/windows/mlx5_os.h:
#define MLX5_NAMESIZE MLX5_FS_NAME_MAX.

The MLX5_FS_NAME_MAX macro also has different definitions for Linux and Windows:

drivers/common/mlx5/linux/mlx5_common_os.h
MLX5_FS_NAME_MAX = IBV_SYSFS_NAME_MAX + 1

IB verbs API sets IBV_SYSFS_NAME_MAX to 265.

drivers/common/mlx5/windows/mlx5_common_os.h: 
MLX5_FS_NAME_MAX = MLX5_DEVX_DEVICE_NAME_SIZE + 1

MLX5_DEVX_DEVICE_NAME_SIZE is defined by NVIDIA/Mellanox¢s DevX (WinOF2) 
user-space headers for Windows and is set to 64.

Regards,
Gregory


--8323329-1594641287-1754907225=:29294--
