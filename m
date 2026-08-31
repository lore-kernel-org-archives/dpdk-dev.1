Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03643C624A5
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:41:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF3AB40269;
	Mon, 31 Aug 2026 17:41:03 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
 by mails.dpdk.org (Postfix) with ESMTP id 01E0F4025A;
 Mon, 31 Aug 2026 17:41:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8bN0BcGsxZnd3mDu94E7+iAKVJT0jAqpoQP9j9VTXKY9HTbrGvii2CbA3nHK7cJMsSpKx8JhwkHI3Pe0lTIwS5erVm+9PLC1FnLm/6BwsIrpoGnQ29nBBlaF7ofW+Mx6vcKmtn7faEoeGDel1YSU3/fmJYmNC1gdGPteUSLAnFWg5h9zxtsCWWq4eXlN/GmT4a9vRsPnNsKB/QFL1LrAp4ov9j4/djA9OJ8rHunvZ1IojwTLKpMWx1JqwdswsiQH9T+f+TRvr7qahTNduswDS87WcNRvY6t10GLEuBKpyuuiBcilKOSvinuGa808aJyugIv3H9IlD+khvJVC+/Q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvJa4ekA2mjcKCc1pcVgSgjidzw4BLSJ8s9EiUXMAcU=;
 b=bWHJSEOjPla8NRcHJl3wpse1Cg0GrH5bc3+wOwbago3zAYG6ISoyJe0DGf0iCWiCrr+3W/Z1O2/CZ9M5a7IigRjXJoexHSSvpGeiPH3YWnCwLpFNQCtymYcE/uLNLuyRIL5xrPResnVoXa8W2hCgM+zcH9x5gUq9hOTEudyRPhLhXp8sI/dJi+u1/pp0VD9ikT3h9b0UuVWmix0ltibpZGEmPEIeVZAmLcSkqRz5OYvbyjvygU1+wkN+/6MdglgljcSP1H5BUnRnMPiKCRe5hBWJxn3pngxgSIKIFxIfA1SmkC/aQcZW6fXqNCrcSSUq4CXK8WI+xUjf3ssShfd92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvJa4ekA2mjcKCc1pcVgSgjidzw4BLSJ8s9EiUXMAcU=;
 b=LJA+3oxunnODckzAOMZL6hngNivyCw7iDzxf4Mf47M8U7IACnxfT7Q5FA9l1Qzztl+PwyNm2WnIolovevn7D/gDEpcdsnLxcZBD6AM4cDS9Rwg3vGA5aJAWI1/L1XrmrSq6vHF4s/pdRAmvYhsCbSSX+7jvWYzS4NSmAjCW9NrPsJpaaVcf6dNRcIsHnT2BhF77nOu8bfDwzGLKkggoBvR1KTfHFoyQWyXEFoK+RXDuoolKY4Wav1KimZR0u+j73yOKhPF2SOtYxMKsZS/vgF3f/29NHiXBvKqxl0eBniGUHgsFMrj6IqWM4uwrJFp/V6gkecVaSQTfhpZVi5XexGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:40:54 +0000
Received: from PH8PR12MB6747.namprd12.prod.outlook.com
 ([fe80::f9de:30f4:4c5e:9da8]) by PH8PR12MB6747.namprd12.prod.outlook.com
 ([fe80::f9de:30f4:4c5e:9da8%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:40:54 +0000
Message-ID: <4deac670-704e-4529-8b15-2289ec77616a@nvidia.com>
Date: Mon, 31 Aug 2026 18:40:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/mlx5: fix promiscuous inconsistency on port start
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Adrien Mazarguil
 <adrien.mazarguil@6wind.com>, Nelio Laranjeiro <nelio.laranjeiro@6wind.com>
References: <20260731092332.3833632-1-david.marchand@redhat.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260731092332.3833632-1-david.marchand@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0369.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::9) To PH8PR12MB6747.namprd12.prod.outlook.com
 (2603:10b6:510:1c3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6747:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: e177b5e4-f4e4-41a0-b843-08df07763e49
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sCoV61Zh2KvkuZkRakUoKXqwsOcj93i4JhfnE4wjyEqfd25x+fcfE1GVZWIrFOvrK309LG38inu2dRLuD3T8xht2T8eaN3/usw6vS6OLorQVWuwsDzRnZ1N81Dii+f0cekCx9CBbws66CRK7zUuHw8e1SPo9p4FzhnJPL2he+NOJs1/VXKh8sJy64JmT8O/V98cbuYYm2QI+LsPKkW2d9zLtQQRFDNYxAVAec/bVfKVjnWh8l3O90XDKyq9Qfi8W69kK7uSCQxvAc1YyXxzoK5kaysny/+8KgGTyGw6StzZbrY7S66wWRmL+C01e5BU8vF/0Bjz+lpFPkYPaPDruMiwfKeT0/vLeKA6hOYMPFOi9Gn4fXHUku0piucNa+CMrslg1pbdj9mlnwbmsqTPaYwDWxMX9bYueVSEaiyADIOq5GVXydWiYWAZPVByZ8Lyq0NlCEpBIBHvws2y3S+EiD6KTYQe2Vxq+uS13uPLl9INNLTJzvuVA4TBbaca83aFGnMrBI/Rm4adkqok7nRzf57JKspoBj9WF5z+N9EyQ4/4mlU9cKbzmoiT45UUnUFfI8NcwXlifP6weF/wgNeZT0WZDED8unURn4uKhyyMI6RV5hKlLjcKVG6AAt4VN0pi5fynfx4a6bqHtrbXPeb7OQIDzrGSNxXamO+f3nflzbfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6747.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YndETkxwdkU2NjVhWGtHYmcrNyt2VXNFVU1qdi90ZzA0bmppZ0pjOG1QQzV5?=
 =?utf-8?B?YkUwcW9VeW9NNDMzY04zZTNPV1BqMWs1TmorMnlnSjk1TzJ3QlhvVldZQmp5?=
 =?utf-8?B?aFJjME5XVXp1c0NxajNWbXR2Sm04K0RNRks5TmNaVEdPaUdhaWFvQ1dzOG84?=
 =?utf-8?B?dkNSbUhmTEt2dkJZUTU3WUsvTUNkR29uWGtMMU9mZDBDNzF2NUpCWXJXZU5U?=
 =?utf-8?B?YUJmVUpvRGRYQ1pXanJVMXJ4eThJQXBkUGtKZWR0Q2EzRkhCMDJGYVczTTds?=
 =?utf-8?B?SEluZWw4ZTYrZk9YdGRRRUt1NzBFWEtMRXJTWkZHYWJGS2hPeEdmSTNlSGxR?=
 =?utf-8?B?R3I3WVE2RDV1VGNTNjJITm9aN0JTSThwZzVWRTdIUmJxWWF0SmFKWElrR3BL?=
 =?utf-8?B?ZDNVY1A2MzJrMXVHM3ZIWHYvdWRtRzB5NGtCNDFFVHNKNnY1b3F5Lzk4L1pB?=
 =?utf-8?B?Z3hWTVB1QTJLUFNUdmZRVmNHR0FaRDhzdkUwc29QRTk4QTdLbDdydExtUCtt?=
 =?utf-8?B?Q0pNQlBPYjZHc2ZMNTR0eVFpaVRSeFo2MENhVzFUeUhUVkVLVXFOWU5mZVA4?=
 =?utf-8?B?bU9RQ003Q1JiY0txS0hWWVVMZjNJMU9SL05vZ3VlVmRNSUV5a210eVo0MFN0?=
 =?utf-8?B?OTNYRVhxZ21nL3BSZU11QjZKOHRTdjgxOUdhZnJDT3BnREhieVNpZnJrYzY4?=
 =?utf-8?B?cWJWNVFuS0N4amZYQ0tTclAvRFFtazNHTFN0d0tzYnovajJyb1FmMEdMMTVX?=
 =?utf-8?B?Z05NalRZdVdhMklmVDRra0NReEVCakVYczBsY2hGbWpMVE5ndGR0QVQ4T0x6?=
 =?utf-8?B?QjFvS0RXdGZ2dE1vZ0VCTlBKUnhrUGI2ajhpamxPSlUxb3JnUWlpVGpkcm9y?=
 =?utf-8?B?Y2o1czRiaitZcnUwd2ZENjFvNWQrWmFJMFVHY2doUkowVlJOSjlmU0UyT3Zu?=
 =?utf-8?B?VmQxdFJ4QWhxYmhscFhtUzBoSnZsRndjVThZS016Z0tWWGNlRzJHYW9yVFll?=
 =?utf-8?B?Rk8zQmhaTTFBc0RwczZyNFZEQzRKSHNIb1BVczFQdnlIeS9hTHRoTDNOUS9V?=
 =?utf-8?B?WU9Ta05BVllxUS9oZ2IxVms3Kys0L1FJdGs5cHRWYm9qYmlQcVdXYTlvODds?=
 =?utf-8?B?NVZiZlczYnIxL1J1dnBYUk82KzB6ZHU5TFNRNnY4b2Y5RVYwZ1hYcnBkenlr?=
 =?utf-8?B?clN2eW5EcThpeHdmbkJaUFVTNGx6QjZ6VGRXb0JUaWFveEE5RmNITXRnK1E2?=
 =?utf-8?B?UnBodmJiSDNWTHg5MEh3aEY2OURhOUh6bW9rT1VpZ0RWM1VESlRITmpCQm1S?=
 =?utf-8?B?bWk4Kyt2VkhreWI0dXZwYlhZOXlydDVsaTdOOU01a3pKdTFZNUEyd0RxaDJy?=
 =?utf-8?B?em9UWnM2Ti90VU1ZNk9Yakc2c2hHWUJMTzVrZG9xYXZnajNWMHBkanNIMXFa?=
 =?utf-8?B?bjlkTzcxSXRUaEdZa3YvYWs2MUJ5em1MUlVLdzBDMGVJRzRCQjlmekJuOU5i?=
 =?utf-8?B?bW01cWV4MTlUV2FtbG5KeEVIOGRaWG13OFNhd0VBMklIMFRRKzZxWlA0S0o4?=
 =?utf-8?B?ZGhlY0dHeDJ1YXBHRy84RldLWmpSOGlPVXZiM3A0Sm5TY3BDQ0pkZzk5dzQw?=
 =?utf-8?B?UlJBeFFjVTFxL0hrZm10WU02c1g1c2RGWjlJUVpOeEluNW5leG94aUV1ZUM3?=
 =?utf-8?B?OFNoR21NU2FTdGYvTlFUWHlHZmlEQStTVE1QcWgvbjBHbXJEckxEb1BhL01B?=
 =?utf-8?B?cWpNOE1rSXF2Q09BTzJOaG1sSENOVHFRL0xGRGk4aDJ1ODVYbm5DcUdaTkRD?=
 =?utf-8?B?UUxvV2VnOXlwc0hOWDJybnZjdWg4eVhBMlRSY3ZLZEpKdGlLY1hqcURBdmJl?=
 =?utf-8?B?MUtMeThQeHRwWkpCODRFbzFBY1hXRWh1OW4wbmo4NmtpNGNsYnpGWmNNZnVp?=
 =?utf-8?B?SDFjSnBBNndvb0pTSHVKOGxmYzVGcEVDdzF1RnBMV2ZUQ081N05OaGlreW1M?=
 =?utf-8?B?SGNpSEpDaVVsL1V4N2dsWWZGMkhiOTNSRFJwMFF0bHFJSGZQK1lvVUJNVTZ4?=
 =?utf-8?B?akZieGNOYjZERFFIeVIwVjlJVTFNTEplNmpFNTB6OVdIT090TUJNVUR2QjFL?=
 =?utf-8?B?UFRiOC81L1dlRXorSFRNZ1czNzFKYlN1NnM4MHpEYXZneCtyaG9qSER2bU1S?=
 =?utf-8?B?YURGdk5ILzFiSnplOGw2L2pJSmNFbkVPRTFLNHdDaVRSYWNLREhxa1Y3bHph?=
 =?utf-8?B?YU1LZVd0bU5ROURIRkFLRXl3em9ySWhaaVAzTytuZ0w4WUtWb2srNjRxdWdm?=
 =?utf-8?Q?cYsYLwfV7HqLxUS1EX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e177b5e4-f4e4-41a0-b843-08df07763e49
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6747.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:40:54.4889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saaOhAbatOHS+SkiydAdGQo/IBsq26uEr5ae/XPGmiFBu278EAVJQXY2g9TxcmBTIT3BPjypIWmGtfvo0i7iVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028
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

Hi,


On 31/07/2026 12:23 PM, David Marchand wrote:
> The kernel netdev promiscuous or all multicast mode could be enabled
> before DPDK starts the port. This would cause an inconsistency between
> the kernel state and DPDK's expected state
> (dev->data->promiscuous / dev->data->all_multicast).
> 
> Add mlx5_os_get_promisc() and mlx5_os_get_allmulti() to query the
> current kernel state via netlink. On port start, compare the kernel
> state with DPDK's state and sync if they differ.
> 
> On Windows, these getters always return false as there seems to be no
> API for getting the states.
> 
> Fixes: dd4bb90bc3cb ("net/mlx5: use Netlink to enable promisc/allmulti mode")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Series applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

