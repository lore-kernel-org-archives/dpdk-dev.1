Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F829EF06E3
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 14:37:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2534F402F1;
	Sun,  8 Feb 2026 15:37:45 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by mails.dpdk.org (Postfix) with ESMTP id 8B9EB4028C;
 Sun,  8 Feb 2026 15:37:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAlDWAWleFfo+yM3ePOTNov9AGuPFvL+o80QXwTKqor8FYqakroRXaQzXmjW5Qx8/+JtGQOb6BzrWjbYXihAfIguU3RK+OvTxkYa2nXHVYa6vm7SZuYRCrGnlb/ij5VXePwW8HfLUmrem1kfINujgWkbm4cvc5RS5yHwgM1kwcy5vghSjA4e2oTEM9SSePhCcXUvOSn6wB8ECxk4AFW/S++K9ObKEKNguLJgM2NIK1SSYeDPFXo1h659aD3GVoPCJm75DdI9BkOfi8dzzUP7tpLJ5yls+kxsb5Et22FGbh9OIGHuLzPlDEu8MEIbzQubU594SSXbuQo/vUsc6AGStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q++k/CcQCh32BF44F1Cx7XpQtIr6e4uQJLoy5cbm/A=;
 b=AqB8N9rKkOWt2QEI4iqZnI7C9KpeBy/SAHUxnT7AsSdTR/DdzOI/jWYsHMUnzvRkvcW4rrEPgcG8p6YhKpZaK1sfYn8gwmdswMkxsYaFZvDr1MOl3BlFUzk4aVfmPV+uVtcXloEjV4wInvX6phi5ztFjD1hPxN9EOvojc+EJBUxP+pRd0M7sNFUeVxkTOxdZtPG5vFh4VvpLjNm7YLQ+C2srkBz8YBg7ETJYWTiGrnLnLcJY65Pd4oueGLILneJVgrlt/g5DANeq+Mo3KMYrN1PHl6DEpfBDUMmDGTNKPwshyxLmb7RkDOuog80hZ/onttOIs0CJoIAjEIq8z7aE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q++k/CcQCh32BF44F1Cx7XpQtIr6e4uQJLoy5cbm/A=;
 b=ELFeaZSq88k2dw5J0Le8olQnlMch+C7PSV7XJbh+1HRDzE3UZgXTjVerxaYakG8nF15xMiDTgXOHmSl+oILNBwdF1Ki61EFwPxrxumLzdrhZmppDaDxChnJCU5HqXKb+h3PB61sVRj7JU5y6IuRP1AgZdruuqaFOOnkpm5Z1GXPzCObiEkED4At+WqkYs+jJrHoC5hlkXtvrfITXxortiK2h6ezxRXnEHgVQ99KdMoPTyN6ZkrVOzBHdiGnV5/zucvQlhqrC7LTq6DM92KJKX8fZLl7sAFXXw4X1IwsNUwWfcqZYq2Z/gkfWtd+AQQBAygXCfuaQGjUurY8L2AWxsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Sun, 8 Feb
 2026 14:37:40 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 14:37:40 +0000
Message-ID: <d1bf307d-c0c8-4490-a878-085f4c60bea1@nvidia.com>
Date: Sun, 8 Feb 2026 16:37:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: allow MTU mismatch for running shared Rx
 queues
To: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org
Cc: dsosnowski@nvidia.com, a.schollmeyer@syseleven.de, stable@dpdk.org,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Xueming Li <xuemingl@nvidia.com>
References: <20251117073937.1514124-1-shperetz@nvidia.com>
 <20260129081323.4713-1-shperetz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260129081323.4713-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::10) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4e7dc1-e7a1-4f20-daeb-08de671f9c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm01NVpzcXVmeHNoN1V4dEF3ZVRFenVWN3dqekFycHFZcXMwMlJVV3c0dGpI?=
 =?utf-8?B?VzNiMnEva3BIZXBacDZRR0xGRVhLY2xKWlNHSkZVWWkxN1ZpcTNSRXhnWTcv?=
 =?utf-8?B?K2FJUTYwL3BXKzQyaFZ5ay9hUHNROU5JUGp5aU5ZcU1WSEdzVCs2VWJFeVpF?=
 =?utf-8?B?alFkUk5zM0FLZytpdEYyQjJYRDZDZDA4aXpJSnkvSFdlQllLWElrNUhtd01p?=
 =?utf-8?B?R1QxV1JGbXIyN0lNUS9tMng0SENQTVpQOHFJcW5lMlBYdjhLRUlzUVdQd3dW?=
 =?utf-8?B?alcyQzhpcGQ1U3NKc1VHNTY2VjliclhTSXBYN00ydERQaWVZbUg5YmtSSkNS?=
 =?utf-8?B?TVFOVDNjYUR4amgrRis2L1hzNnNjM0NLU1pEalB2dExnSFl3bitzejdJbUNR?=
 =?utf-8?B?M2ZwOTV3ZFFKWDdzWStxM3QyRm1ZVFZmNFRkbURnd0MzQU9DNzVyZUdSaGFq?=
 =?utf-8?B?QTZUUi9UTVQ1OW1OazJtazJwa0U0WGVWYytRRUNTS2swdEgvTDlMaFZEWjdZ?=
 =?utf-8?B?aSsxdW1vYnM1RlUxb2hlSTk2NjUrR2NsdXNnanlvT25LZTlodStkV3RmNFFY?=
 =?utf-8?B?cTdJUWxudlQ5Und2dlRTTUMxcjJNVnNhUlBzUHFhUWFHUnd4SmFnL1FNQU12?=
 =?utf-8?B?WTNNTnJPZXNXOHVncmUzeE5hMmpobEYvV21NeHJMdXRzOFJobHRjQkg5V0tL?=
 =?utf-8?B?Nm0vQXFYODU2b2EyRE9KdkNBdzQwcE5FdHdhSHcwSkpkY29BOUJDZ2xYcy91?=
 =?utf-8?B?REJLZkVCeWxFMDZxMUMwNHFJdUJoUUpZVUZvZ1FZWnlPeTZZemgrWW1heGF4?=
 =?utf-8?B?Ui9icndBa2V6Y1BrNWI5cEN2cjFLcUd3cE9Cd1R1NHdGcmZVTEY1alRZMHNq?=
 =?utf-8?B?OFdrWkhQbTg2aG1ybFpEZzIwMGt0RURTaFduNUk0dTZVc3VKSmxTNmQzZVI2?=
 =?utf-8?B?emxiMXdSdFowV3dQV0VLTGZZMEM4ZWs5UmVsYkFrb0p2d1hsYVhXQy9vTG1U?=
 =?utf-8?B?cU40b3BEUTFNQ2tlMm9wbDRvU1k3WHpVRGQrS2o1N3d1M1F2am9VSHQvUWNF?=
 =?utf-8?B?NlkxTFN1OWduMDlQQTRNZTRjYUhZbXFuRFJEM1pUZmt6a1RkYmVHV1ZKV1VT?=
 =?utf-8?B?d2FyVU1oVy9FUnI5VC8xeEpWMVRqay91d2dpWEhKZEJiRWxtdENmVTdWMDFL?=
 =?utf-8?B?SFFncWtkQ1VzWnR5dExhYXNrSWlnVktqenR1aHN4dlllQXRaM1pkWGFjd3Rt?=
 =?utf-8?B?UmJ4MXVqSzBaajVaWkhxNVVmaFBiOVZUcFFaaS9pL0M1bElIVHQvRU5LVjBq?=
 =?utf-8?B?dGJOMzZCbHMydTFJbHFxcUlwSUdNR2JRM3gwMVVuTXZTYWZnQTBMY0pHK0dj?=
 =?utf-8?B?RElKZSt5eHRVNFpDeTBOaTZ2MjRoMUNiOEh1Ulc3aWFDU1N0YWdMaEhLbjRl?=
 =?utf-8?B?ODFHcGg2Y01NT240VlBvQkVrR1BCeHdtOHBWRS9UbVIyWlZNQXFJOTN5bmFa?=
 =?utf-8?B?N3ZGSWlVYVZkd1V3WUxObGxteHVZMDU2QXV6YllLLytqeURzbnpnKzJ5amc3?=
 =?utf-8?B?MU5DWURXbGptN1J5YU12RjR4MTdxYngvQVViMzVTZjZTWUFLVmtjeW1EdDBY?=
 =?utf-8?B?NFVlczltNTNIektDTWxaYUlYOFF0bEVXbldvSXVqTGd1aGx4SW9FeWpyTzIy?=
 =?utf-8?B?UjJBVW1xa0RwYUd0NWtUUkNNOHNCS1Q3S1IyWG5uK0NYSTQ2aHlQMExCZVRK?=
 =?utf-8?B?a1FrOXBrZTZoYmZkVkQ3dU1kdjVpVVhoR0ljVzZoYTdIOG9EdVZMMVZaSVQ0?=
 =?utf-8?B?VmZWbVdIaWJqb2Z4Q0pMWGtUUGxSWmhMQkFVU0ZRc1g4a2U2elZZYmUvK2tv?=
 =?utf-8?B?UC9hR0U0R2h2UEdIbjE5aWtXeEg2bDRBQmxjc0NsUVpleHVUSHBxSDNQSU52?=
 =?utf-8?B?NHhPeGlHZ0loSm1vb0tMQ2g1LzlrekMzWnRBL2JKRzAveHppaGcyUmpnWi9E?=
 =?utf-8?B?ZVBjSkFxMnVFWXZtQU1RZC9PK3c4cGQzTVJiL3Z5TitDMzBsRG5KWnlLRG9s?=
 =?utf-8?B?SmZZTnFxQUlXSE5DZVRWVDJaK2VwV0JyUTlBS3JzVDE1Q3piSGtKZ1RWcVh5?=
 =?utf-8?Q?skeM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGlaUUlldXdVNDBjY2hDUkZ2MmduRTlqai9SbjhSa0tTQmp1SDJPYUVidmdQ?=
 =?utf-8?B?dHZWN2NHUWlFNXJKSC9JRXZOZnBReWh4eE5BeTFNL1lucHI1eTRoSXpmSDdr?=
 =?utf-8?B?d3JRYjRkYytMWm5BRGI1WXFQSm1kWlNwN0c1dlI2a1B3cUxzcDQxZ3g4Q2Vx?=
 =?utf-8?B?UEp6enoyNVlFOGZkb0pQM2FFMnhxd3N6bVBISWVNRXZFR1huM2JWS21hUUdP?=
 =?utf-8?B?VUZyVklJVTJORG0zSkREdVIySC9hY2twMDVBdi9HangxeFVLaFhZN3cvYWRj?=
 =?utf-8?B?aUFHbERKeWVoSXZucy9sS0dYQWUrNnFoS3Z4ZXh4aDBxYjdKM3N2V1dmdko4?=
 =?utf-8?B?cjZjb3VWeFhzOE03enFSbzcwdDdHcFNWa213ZGNOVEdFYzhmN1FFL1VLdkdi?=
 =?utf-8?B?VGJDalFuSEEwMW11NzIySFlZYkxzMmRIcTlUT3p6NmJjbHB3dVRvblpIOUtE?=
 =?utf-8?B?WHpFeTZrNEE2eUpqbjFkRTlaUEQzbzFXL1U2aytFNEQ1YlFIRllKM0ZEcUJq?=
 =?utf-8?B?cXhHQXI5eHgrOU8xSldrMWdJdWdkOGtNOW5VejFvY0ZBSXZNYmVlNk5pVHlK?=
 =?utf-8?B?Q3RrWDg3VU1iekdtWXRCUXpVRTZJQXlreXRzZkJaaVNTbFhubXdPQmtGUk5v?=
 =?utf-8?B?R2oxWjZpa3hTbkJCZGJrbmZXaWQ1Qmpvbmd0YXdZSzA5Y3YzNWJHem5ZQU1K?=
 =?utf-8?B?QUhXZ25TUVpDY1Z1MXZlWlRxNE92TmVaODVaNjJ1QnUrUzhrckdWeWhHUkwz?=
 =?utf-8?B?eXV4SURaTWM4WmRmZzF2YjFCZU8yc1pPWmQ1VHh3OGpURmQyOWpIV20rTDEr?=
 =?utf-8?B?emxYdk85dzFBVnU3N2NyNFlJSEMvZkQ3R2d6Q3FjSUdsZU9WaXNzSFU4NUhP?=
 =?utf-8?B?Q0FMRStDMUVHekhSWkpuSzNEZTh0WTVHNUhmMHVKVUVNZ042MTNvN2lhTkY5?=
 =?utf-8?B?cjY0YmRCK3VONk9nVFJJS3JiMFQ3M2lsMjAreDlrYmU1ZWZrV1JrZjJ4Snpv?=
 =?utf-8?B?Z2FHNVd5WFVhLzBWcEJLTGI3Vkk3VlAxNW9taFBRbjVHbkd4NkxkL0I2eUpL?=
 =?utf-8?B?MVZIOC9BSDZmbWxzam5rdE5ZdFVVQUhsWTJoRDVhc3hzRlhLUVpFaWNMTnhi?=
 =?utf-8?B?aGsycHQyYm5xMlZ6bXFVY0VTa2xLTnNnVmZVdm5BL0dqcHhKN0todjQ2RHVt?=
 =?utf-8?B?OFJIdURmUDdydzdNMjBnOVhwbnlQaDhxUDZuRDYycy96clpDWDJwcHZiWGxn?=
 =?utf-8?B?L3dHRGkxaittQUtkWmJYUDlCOU5ZSXI2M3B0bWdPMUhXa1BpVnJwVG9CeEgy?=
 =?utf-8?B?VHI2MkRGaXUzcG9pZkFXQlpsdnZqUW01akNIZllNNTR6SnRWblNCa1pSOFdH?=
 =?utf-8?B?RmhRWjVxVFpLVHVaWGJid0JnMUM3WHhVQ3VXV29wQjZFSTZrWXhTQldTQllW?=
 =?utf-8?B?aWI2eFJ2MSt1bERJK3hJUjVXNmpQa3JsZWJmc3NyL2pjZ0tObXN5V3FMZ2R3?=
 =?utf-8?B?eTVDemhSZHZtUFRaSys3UERIQlNEU2tmd1R2c05OV05sNFZYeTF0N3V1RDhU?=
 =?utf-8?B?cXFSN01aTVpwTHp4cGxPdkd4cTVZWUgycXZwL21XbkJsR3laaW9ZRVRQb1dE?=
 =?utf-8?B?UzFQNlVhMmpvT1Q1L2xwbmRkWWZsUkxpclNUQlVYSTZlRUc1T2FkMVJsem9h?=
 =?utf-8?B?WlpoVXkyK0ZGT2RJTWN2NUZleHN4WjQ2ZHI5cGZVSmViWkJSS3hySGxnWG5n?=
 =?utf-8?B?NXlZMmRyRms0NjgzTXVTZUtuU3FsZWVKQmRGMGYrWFBoa3VkWlNxYnJjLytZ?=
 =?utf-8?B?b0QzeTEwaWI5ZGprZm13UUVHaXo2YVNDL0VvaHN1NWg4U1ZOMTJKalpBb0JF?=
 =?utf-8?B?LzY4WmV2SWEySnFITWd4OTZDWjBCejIrYjhSU0ZQWHQvNERxeStSWEpQZHpU?=
 =?utf-8?B?VW0yUVV6bGsvREMyR1lwT2JoQy9WUjlQeklrOVFrTFd6QkFnSDgyMVhkdUE3?=
 =?utf-8?B?a0plNUxZWU1iVmZMQXUyQ2lVelcyRTFGcVpZZ1lRRDdUbkI1dUJJOXBrNVJT?=
 =?utf-8?B?WTVkWWJzQnFLZW1OTkFuK3YyNEFMRUFsZ2I3RUs5cENLcldtQXh2b2d5TEdV?=
 =?utf-8?B?eGVCLzc0WFc2WmhuMFdzdHh4eStQN3N5UjNUdjhWdm5wdjZaczVabXUvd2pk?=
 =?utf-8?B?TkdvOVVraDYycUtqckNTNjhqZndUSlQ4Q1ZxTmdoRnExekE0S0IyVkNHRzQv?=
 =?utf-8?B?ZEVHNURtU0NJT2hGVUVrdC94RWxCbktHUUFDVFlWV2MvcDRLL3RuVTdrb1JK?=
 =?utf-8?B?VG13dmozckhyY0NlY0w0ZUtqcjRqakhneWMrQ2Rucmtyang0djJFdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4e7dc1-e7a1-4f20-daeb-08de671f9c63
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 14:37:40.1806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDqFdAciHFTbyGL7YmVWryfHIQBB9AXDtksYQxQHp/TPJovewt2YxY+oQDauEHjrQ/jfk798xyXaf4bneOgorA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171
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


On 29/01/2026 10:13 AM, Shani Peretz wrote:
> Previously, mlx5_shared_rxq_match() rejected any MTU mismatch between
> a port and the shared RX queue, even when the queue hardware was already
> running. This caused failures when hot-adding representors after runtime
> MTU changes (new port has default MTU=1500, but running queue was created
> with MTU=9000). It also prevented proper port reconfiguration scenarios.
> 
> The fix allows MTU mismatches when rxq_ctrl->obj != NULL (queue is
> running), since runtime MTU changes via rte_eth_dev_set_mtu() only update
> software bookkeeping without recreating hardware resources. Stopped queues
> still enforce MTU matching to trigger proper reconfiguration.
> 
> This patch also removes the redundant priv->mtu field and uses
> dev->data->mtu consistently for MTU tracking throughout the driver.
> 
> Fixes: 4414eb800708 ("net/mlx5: store MTU at Rx queue allocation time")
> Fixes: 09c2555303be ("net/mlx5: support shared Rx queue")
> Cc: a.schollmeyer@syseleven.de
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

