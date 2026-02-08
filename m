Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AFFEF06E1
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 16:36:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A615402C6;
	Sun,  8 Feb 2026 17:36:27 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
 by mails.dpdk.org (Postfix) with ESMTP id 65BE74028C;
 Sun,  8 Feb 2026 17:36:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3rlCNTe6ErgYAHkRPEL2N0w2MS8CJU+Ko65l63wxV6ATr8LvJGYu05rX918lu9WF8psM8JDpSaiQ5GV8vTESdR2AzfzJrs7enfsS6xq2D7v+F9bWu3s+1x3A2dbY5TbM7E5Q1GYdDXckWySXog3cRlswbcFyG2/K4nl68BZEs5zV4XbM1LGCvZZAahMNTOVYzzBnMZfyaQU8jYkl+m4H4PXSfqWD3U4AeJaflX2AdCjNi7xsSsecOxFOTRCQU0KKFh5e3ocrS5w/ABpfiJyqC6Yc2u7Yw64AG6Tn/OtB7zx/hj9UoR9sjxlxCB+fr1nzHeVA5wVSAa4ujVSFCUuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74sZJOVTd1S+LlE8sLqvdknuTWAwX11TURTf4LRB35Y=;
 b=PvbD1nLvEStoucueg2x2N+fglI8FE/aT4m2zwkq4kaf7KTNUHAhgXsBuyLzq189fp4lQtbLhHX/TAVSR64aO1Eyn5Gv5LCAm9vaVR3wX0pqaWrbPOFGOuoqecIxbdaoEfzeMO3x3U3JvYzPxwjPsRB2qovttnxZL9qITBoydOTawmb66WRT8TPEhGAQbUcWmzUQwrmlEffKS8wGF4MrklqV6CjE5s5ZbyRKc2hKr3VQESQpxAV88thQFaiMSz93QHHteW1XZiNXeVHD1mvpiytqm3okvcp/Xd7la3P6DK8tH9AqsuY8nOsB1mSSDcDrZHQrnVh8hV+OEIYeYEnyc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74sZJOVTd1S+LlE8sLqvdknuTWAwX11TURTf4LRB35Y=;
 b=cW8V2Q30X1gRzf9CPErTdn4gXNo8NQLcp6RbCy3uX2xdI+hkzdXCCaO/Qi8s+6pkWzc00Xmvu70DVxJoUiSmwWK0qV/R6ByRSH+wguALf/MRLjJA00xQLoOvlMc/qUWPwW6XHRxe0o4Bw/Qmf+OHqEjRjkMmCwsRiUu8+ZHLkw0jo/hcKOWIgRItadO9+XMvYsY4MDQDqEzNnnIweizmS1+nn1H3hfUJObSDhWNMNv5Wu9jehzYinGu8A9MJgEpp5aP99ihS40yKpVbHM2U15aBiekOB8k6LkP1Ok2ThRAjoo17jRYjbUGqOAlCXwYfbwGg7w7cV7lHZTyyIaoD6yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:36:23 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 16:36:23 +0000
Message-ID: <8a880378-71f7-4f61-8089-4b44ea54d2c2@nvidia.com>
Date: Sun, 8 Feb 2026 18:36:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] net/mlx5: fix port down in link detection error
 branch
To: Yang Xu <xu.yang3@zte.com.cn>, thomas@monjalon.net,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com,
 yao.chenghu@zte.com.cn
Cc: dev@dpdk.org, stable@dpdk.org
References: <20251119060222.2814478-1-xu.yang3@zte.com.cn--in-reply-to=20251119060222.2814478-1-xu.yang3@zte.com.cn>
 <20251126050948.3030776-1-xu.yang3@zte.com.cn>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251126050948.3030776-1-xu.yang3@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c19961e-8194-468e-93ea-08de6730324a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1FzZGRwYmhpSXNQd0g2dU45bzFCbHJtUTdGMGpJTEl6SENJcW1kNktUQkpx?=
 =?utf-8?B?ejExbDV3c3RVZkxTdUN5SFViUVdoVm9tcDlFd0N5SlJoVld3TnN2QjkrV0F6?=
 =?utf-8?B?VVBYamhPTDM4R3BPMWNIMldlOWRQeGtIZStJM1ppL2M0K1VKZTROU2NyVUpL?=
 =?utf-8?B?eHR1NnBzNGlwYXdCQ2tGSWsybWxweWlmcHJsaHBzYmRiOE9kYU1SVm56d1pB?=
 =?utf-8?B?OXI2UzJxcUlvVkxVSDQwK2dsaGVDWXFYTmhFRkhRNmRsQzAvc0t5OVJKQ054?=
 =?utf-8?B?SUZKalpUUXlhR01ycmlOSEYyUTJYcVJVT0hIVG9IcHN5bE1sWTc3YzJwNUlp?=
 =?utf-8?B?cC93MC9ONm1DcjFJQUhGdGNUUzhqRHFEQ04rMjkwaFRLVnVzWEhZUG85M3hO?=
 =?utf-8?B?NW92LzFCcDJ4NktKUHNBQVRXaTB5MkN5SWlrdXBxd2ptblUrRExKME9Mc2Ev?=
 =?utf-8?B?ZTB6R3NGWkpZbnB3QlFscjdwbmxOaUQxMWl1TXZXdW5La2s4SGZpcTdDalFq?=
 =?utf-8?B?dmorUTZ6UFhvaFo1bkpqYTRVSENFY0dOWmRCTEJWR2dsa3ZVd1dsZW1wRWdS?=
 =?utf-8?B?OHRhQld2MGJ1eE1KUG5NOXNMTGpueGNDTVg5ZXQyQk5UbkpkZ1loTE1VME1z?=
 =?utf-8?B?WnZFSWdQZGd5N05ueExCbkROZVE3bjZlQ2FOQzFsQWRXUFBtQkIyK1FDZDBP?=
 =?utf-8?B?cWhiVjhsMnk5UWtHUTRKQjB1aTZwNEdmTVh1bE1CMnh4bVRncnFHY3Rndk95?=
 =?utf-8?B?eFZ2SjNPWks1ckxoUXlySGh3S0UxVGFQVEx2cHAzSnpscWJCbVN6MDVwa2FX?=
 =?utf-8?B?dGdZRWI3ZXF4MlZZVXVPK3JjYitvV0RpSnh3dDhIcEtFRXYyUU1WbmxUTENF?=
 =?utf-8?B?VFZndGFaK0FPT2ZNcTA0VmZ5bmd2RDExSlhLcHAzRDM5SGNBRG9BdzdUeWVx?=
 =?utf-8?B?cjJVUHc0MU5rYU9scFVHMmNLY3lWd2lBZWFFNkZ4clVsY1J0d0JBYmNUTXRa?=
 =?utf-8?B?SlBIRVN5WG4wa0JyaU5kdmNLclo1ajRySTdRclduNHhCL1lFOUEyMXBQcnBR?=
 =?utf-8?B?ZGdoRGR6VDRLakFhUllhcDRQMWFPWm81TlNXaVlNQUh3Mko4VVpGWUF1SjUy?=
 =?utf-8?B?TkdvN00yZW10QVpKemJ0Y3FET3NCU295amM0eXdTeGVzZW1wMU44aE5zakcz?=
 =?utf-8?B?MTZQK1dKcVVyejk1SUYrWUxBVjYwMVJIU0JaUUV2SWNHeFovYnhLNTFJcjdw?=
 =?utf-8?B?S1FERHlpeXIyYjN0K1ZHVGZ1WVhtdHR4Ujl5T2orbHo1a3h2ZVpHVE0yVUF2?=
 =?utf-8?B?d0Q0amx4TlhPcHRUbS9LZHRERGVYWjcyUTlDQVgvajlyUTdyT1lkWVpmcW5X?=
 =?utf-8?B?ODgrQk1PVkxPTjVpbzVwOWhmSU5BS0VUZXhlOWx5bFlzYTFFUEhCZHpLYytW?=
 =?utf-8?B?WjQ1TVJFVVpOUG84aGMvVmZHQ3RFSHdHczFTSXNKQXlhVGk4R3orQjBVYWMy?=
 =?utf-8?B?M0F4dW50QUJBQzROQXIwRi82R0c5WFhTT2ZNMkQzek9GRklhR3dYamNJT0NW?=
 =?utf-8?B?NEcyamRXMkhmLzFXRVRVckRMUGN0U2tqcWxOWjBaZHhac1pQRTRZblFpdzZS?=
 =?utf-8?B?NXlpUW5Gc1k2TWxMR3FWKzg3di9RMmZRR1FLVFd4cCtyKzlKOHphaFBMWmFp?=
 =?utf-8?B?YWwxY1Y4czBFeFZweW9ZdHg5V3p6dW9na3lqbmIxS3NET040ZXVKVllLeS9C?=
 =?utf-8?B?dW9LRXQ1RWhtb1N3OTZlQitSSnJlQ0tVeUFhaEY5YVh2NUs5SHlKZGN5MXRU?=
 =?utf-8?B?b1d0YlJsWUFSaU1BUkFOSklKczY1U1lmYU1pUGo3bmVmbmdybkI2WDZtOGdk?=
 =?utf-8?B?R2oxL2JEYnRnblpvZngrTDkzQ3hqVHZvRmNibFhEZFliN2N1MU5udjJhMmxS?=
 =?utf-8?B?L1Jkb3JDbDRUcitMOGlPNlhSRnh0Vi8xY3BGN3pBV0ZkNDVnMmhSYndSeE1V?=
 =?utf-8?B?RVZqaUt6WElUdDNEZHRndFZ1cGkybUthZ0xuSGRQeEtJakNTcEFoZlJieFJJ?=
 =?utf-8?B?bHQrb3c4a0xzRytxK2NvYVUvODJZOTdITVpDQ3lOalBwU3Vrd0hWRGV2c3pT?=
 =?utf-8?Q?airU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkRaTHhraXZzd3NKakVILzJxTGlzVnR2UXBXUjBmRVBrQjVZS05mREFuUUhG?=
 =?utf-8?B?OFEwcFNCM3BtLzFZUkZIMU94MUdKUzlmMFZQRktQQlh2Y01xOFNsaEwvcFhS?=
 =?utf-8?B?c3pZYmltRGQyQzNWdnhOYzRrMjQ2Y3lXcm5QRnF2Zm1mSjgyK2JKQ2JvTGRZ?=
 =?utf-8?B?Ky91eGJGRDdhZ0x5UUZYcjd6Y1M4STJjODBZWGhnL2RKcmdOZTdkV2V3RmY3?=
 =?utf-8?B?MkxYUW1BcHVTS3VQdXpGOGRsN0gvV0pndTUwR3RIOS9aQlNzTzdUUEx3U05w?=
 =?utf-8?B?eWM3TjhsMFk0KzFmditYRmhiOVpOTk9YVURSQ1NLQVp6bU1CbktyY3lCUXhZ?=
 =?utf-8?B?VlVLbDc3ZzZDSnVoeDM1dHRUaGhMZzRIRnZQTWFQTmVaeE5tc3NGUWF4MTli?=
 =?utf-8?B?YnRGTTFKcW5xbDJhbUd5YlQ4SmY0NFBxUE5CY3k4bnRwcUxXV3hLV3BocTIy?=
 =?utf-8?B?ZnhwUWs3TWxmVjdKY1Y5UDlmczd3d2RPYTNOdjJoR3ZJM2pyYzkvZzhSYXlL?=
 =?utf-8?B?TS9oYkp4b3JBN2tLUkpRNkxoaENLKzJHRjhiS2ZXNXRVNkNiYUIvc0FTVVpI?=
 =?utf-8?B?TjVYeUFQeFI3OUI0L2pid3drb2JiS1hSVnFLRDcreDd0S0t2V3FGTDJrbnJQ?=
 =?utf-8?B?N00wK2VFVVc5R2pUeUpVWFAzK2JiVHF2NVJjeStPY0QzMXF1VXFiNUM3eG1J?=
 =?utf-8?B?YXFYa21weEcvWUlMVUtSdDFuN0dhRVNXQWpOL3ZRRXBtNFlsVHdrK0J1blU4?=
 =?utf-8?B?eTFBc2llNnpPdUdmbHVUOUJkc3krNTdTS21NMklGZ2ZHTk9JNTdHUlV2Z25S?=
 =?utf-8?B?bysrbWMzVHJvMWdhV3FGNFZ4UUg2am9YUHFkU2lOY2ZSZG9sNUxmdityNitF?=
 =?utf-8?B?ZklOQXhPdWNMamxmU2d2eU42TExIRS9iUzVzak4wd1JnNFRjRnNYamtPaDBo?=
 =?utf-8?B?MUVhTDBOdS9oTnRSUVdiT3k0dlN6RkVUMFBKdHBaQW9UOUdyVjh4WnhqTnJq?=
 =?utf-8?B?cldDWE5nQlpoMGZaQTJCZytEY3NqLyswN1Y0U01QTWxUc21Tb2RzcnZMcXlN?=
 =?utf-8?B?RzdVbzJDYVk3enFHTCtQeWZNR1ZZVzY4WVBoM29DZVYwMG42SGo4TkZhRjNa?=
 =?utf-8?B?NWRlZlJZK1RmTzJCUGQ5TDUxYmc4b2JHb0RSMHl1a3dRK2hmc0xUZG5UVjNv?=
 =?utf-8?B?TkVWMm1EZThoWDVuTWJZWERRY051Kzh3VEhqVFVsemxKZ201UzRROUlIblVr?=
 =?utf-8?B?dXV4b3J2RG9kbkJ4eS9QNmlHNXd5ZmJodEZDVDBqeHp2bm9QOU1ubFRHUWpP?=
 =?utf-8?B?ZGk0LzlPSTlUWldQeE54Szc1NkNLakNmbERZRzNYTDhLdnM2QlArK0pucXJh?=
 =?utf-8?B?SGxmNWVJR1cvQkgvN3IwS0pFK1NiT0E5eUhNY2g4SVNLanl1eWt2c1VITlJP?=
 =?utf-8?B?Y0wxZHNxVEZIQmxESFpONE00eUtXSmhMYjh4V3ltMWJkUkNFK2I0YVN2dHFW?=
 =?utf-8?B?VGRZK2ZSVzR6dHdNdGZEWnFqSG83dHQ1cnJxNWpoSzBnSG10TDdpRFhBTnZy?=
 =?utf-8?B?SXNkY3g3RzdFMTVMN21Gd2hFcEtRNDl3c25rYWpqTGtySGVMWjQ4bGZTL3pk?=
 =?utf-8?B?K1RwWEg1TmJpWEgydmc2UkNULzdQTXpqK2x3bTE2cTA1bnhpUXpiQWJBL2hK?=
 =?utf-8?B?Q3UvVmdqOGxtalZPQTFnU1pSdkhtMTNETzhEMEJsNThEU0g1R1pVK05GekNM?=
 =?utf-8?B?L2o5T2FqN2FadHFYZVFtV2hFOCs2V0RlenR0TUZteXdhbFhHa2JHdTlONGpx?=
 =?utf-8?B?OXE2UVB6R3JkSGZVb3Z5TjhITW9LZ3ZZdCt2U1JMY05oMlE3ait5anpYa0l3?=
 =?utf-8?B?bi94R0wvSFdJbmVteHU4L0NERldyRk1OM1FaWVExZTZtZU5yUjgvUzM3SDgr?=
 =?utf-8?B?QWFicVYzQ2J2LzdoMjF2LzhBM0tqWjMrQnlURTRqWHc3V0oxT1N5TDhXOHZC?=
 =?utf-8?B?NmEzaitUSm5Iem5IOFdET0lkazVIK0hOUWdqdkJPK0VRZG55clp3eDByVTdn?=
 =?utf-8?B?SHI1WEJhQklhbkxLb093ZWR5Z2c5aERMN29lRm14OTM4MThGRXNmTHRDNTA0?=
 =?utf-8?B?aWZGL1JUcUJWbVNoYjRyVGFISFluTFJtR1pxNUdkNHg1K29jVFpvejcyVWMx?=
 =?utf-8?B?aE9keTZocEFGZDJaOGRGUDFNL21RejdQU0s1QkN3eitQR2xpTTNuQTNTNkVM?=
 =?utf-8?B?V1RENm1RZ2ltMWpmVWFoR2RRZi9qMXVSNWlCRnY1LzhOZGRhUHhpQzRxSVRZ?=
 =?utf-8?Q?b7rOMpxIANnCDs1Pbs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c19961e-8194-468e-93ea-08de6730324a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:36:23.4061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW9KFjtczSimM7VybSJxyOumBxI5fOl3oY5TrYgfWzpJcQ4AsapZHrRLn5pJclOh3tv/YLHvyuT7uHNd25OYug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962
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


On 26/11/2025 7:09 AM, Yang Xu wrote:
> The port down state was not initialized in the error branch of link
> detection when MLX NIC link status update failed (ret < 0).
> This resulted in incorrect link state reporting, as the device
> retained stale link status instead of reflecting the actual down
> state under error conditions.
> 
> Fixes: 1256805dd54d ("net/mlx5: move Linux-specific functions")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yang Xu <xu.yang3@zte.com.cn>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

