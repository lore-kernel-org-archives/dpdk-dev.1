Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BCECD6E57
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:27:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D29E24042C;
	Thu,  4 Jun 2026 11:27:51 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
 by mails.dpdk.org (Postfix) with ESMTP id CFBF740270;
 Thu,  4 Jun 2026 11:27:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+TGalIij2mKIkmZrzRVoulU5dRj7t4I3rnCiqK6caTHVcfWMCYlZaHxWELV8SaZpfl4D50yCHlC9T138fyWL+tV5W10M+uoV0i3vE+QJtibCbcOz078vxsGFCFvXySTaqWI5AF5KwJ9c67xGbLV/q+QZr104hG1ohL6G+5WjWe8jptweDB0nT5jaWxeCFLl54y28PETLPe9PWWhtTcd2zBgqHzr2k2NMCTJmaIxkTH4YjnBWyYOjAODo2HngO+VSreT6hkMVzkbEdzZDngnMy+l6WbQO2SUEDmhADnszkbdwCsEj2hZ/Mmo5FiPdTmfCikSwR9Ib/5B8e/tl8JG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQTV4pXPWx7r/tsAr1ju1gvC9RnBECvgoc9GtTIRaqU=;
 b=d6M0XLSPfbbxGupoVlHa/i/ak+mZ+mCEmKkLoI+he5NGfQxdYTZOSg7PH++/deVeEOyRnTnYO6/RRiDy5zHNj7KUZDIX7uXj18k1QnnxfzUx/nRzcC9bEZ7b55kFKj7x9hFJfpdSsd9x4stJiGcbWiv+PuUNxCCtNh17IFe8V41UvRMSpFTq7zhl04UZjJJLbRumr5gLXMIocfjlVwIgRB1cdo6ivrKNfDp+Q+cAURaIpWmrdXKyEKijj9vzzndzdE5LGWotNPCdfgaP/dNwfzlMN2zqnukHLvsV6madGvTh1uSfIXLMAP9zjNKyATwy/l4bF8L3TTsIEECdM9mC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQTV4pXPWx7r/tsAr1ju1gvC9RnBECvgoc9GtTIRaqU=;
 b=ACQTkZraz8t383tneIM31g5LB/FCpBaFesZ4gGzh9E9DCaFYIcNkwTF8P32zKE+IzbOlJrfZNFoXCJswVDP4aOoiiCPrD+hBkVY3BvA1znLXRI8dT7P9Ns4z2pW5unB6LwTPU2wzPOonYJz5aBOfceWjlCfosBEjBXSNfQnMVLBjSPnU+H6owkAFdOjGn2cnjNGZs1unIQtNPW111O5oXMgJmtwPwUfj1EergDSxVbZuITDk4vwIEThCVys46rU70IZ6W2QsgFiXpXUdPXL+c1fVb8+bljKp7zoDzmFc2ZAJzJ4FC9OPVpm/ywOl19JyY3gSP4dePmC9BSnGTlarAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 09:27:42 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:27:42 +0000
Message-ID: <f0769344-1a23-46ac-9c0d-96102bfc157c@nvidia.com>
Date: Thu, 4 Jun 2026 12:27:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net/mlx5: fix crash if malloc FCQS fails
To: Yunjian Wang <wangyunjian@huawei.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, viacheslavo@nvidia.com,
 dsosnowski@nvidia.com, jerry.lilijun@huawei.com, stable@dpdk.org
References: <1777027713-91888-1-git-send-email-wangyunjian@huawei.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <1777027713-91888-1-git-send-email-wangyunjian@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::20) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9c905a-f638-4a63-aaa4-08dec21b8724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: sDPunX/1Ezq22Wi+6/mAqF3KXJWNvr+OoleY9BixbGLeinFvIDoT9Ky5Tr4oRhGFBeMPaR0TBwRVAChpozXTdONiTPg0DtbfD/mLlBlCEobs2SRn8NgepO+JCSqeVDf9Vj50N/qZTsxv3SgdICyVbYfx5ugE7E/ZXF0HxfaDmNPUF/HemEoNXxUab2zReKB662tesEDI2N35HwEOSo/sSm/Bo3CW4EV/kgQdGnFwaT66DpDBPoPJi0i9CyRQBn24+BwOqTl3kz49WtA4xaPk1s8Uz87pzxp+/YBMZC3fyx1qA2HyPns7OnD15vTxWrCN77x191NoNWhCqx9WXiEQNdtz41ZFYMBHYkQjgQoFSX3gq2FOrrrZFYxVs71nbXYUFkbcIFYElpGj+FDZ1PC/4x7zTfBuWwrkR4ZnswePrG20I08Fv0UGd+ul7KzvFL9Wznj8mJ3p6Pq6ajwpSDuMJ2OrSAld+jTnIo+ItAHSWyhdbuqF3SI/SfFDaksp5Or8ouSDk3AztSw+Hrw/4ntoJ8qLr87fAMTdO8ZCKIZlLEvx0VI2QOwxBqrkmHUPOZ5kF7Wn9k+aOKvfOrdD+6Ktzrfk48jJVarcmO3PfhzuUC1JtTDIP5AzAFK38vjQK/4rK7vlc5vjADQ5NNPmQf3KXyitTNhwyZ4vrGydvw/TPZuGxoWjN7gGLMxf5dvgehoZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SThWZGozaGZ6QU1BRkJuY1FNWHVMRjJjQ2RPdVRxY2puZkpSSk5LS1NTaXlo?=
 =?utf-8?B?TnNTUDFhZVJJSXB4aXNDbVA3dUQwZndtZUpXNXk1NUhEMGF6UkUzRW9mVkNW?=
 =?utf-8?B?MG1EUDZvMk80TWo4eDA4azRxblkyb0VCaTBtTW9VbFBPOEpnUjlZbzEydjNV?=
 =?utf-8?B?d0lvemtTUjk3cC9QZDM4ZzVGbFUzaExhT2VYQkdvV2Z0S1o4OUUxUFZCL1NZ?=
 =?utf-8?B?VnJQMVl0aXlqdUpHcGlEcHFXem5pVC9sUVY2eFczYnMvd2Y0NFQrUmo1Y1Jr?=
 =?utf-8?B?ZjIvdklRNVpKWldEWlRzYW1JMnhDcDBzcjBaSmJyN2k1dHhmS2ZZdXo0cDdp?=
 =?utf-8?B?TW1NRFBOVUM4aTZMRWxZNWJnYXRRbDA2M1QxVWhDS1pieVNVOVhtbjgxdU5Z?=
 =?utf-8?B?Q1pJb0hkRVZ3bVV6UzJNZ2xHSkEwS2gwb2xlYkdtZ3gxdFVWZUlFOHNEU2pL?=
 =?utf-8?B?V1l5b3JGb0NubElBYnBvMUhXYkNrYkp3UFMzdU9BNmNWZzZPWjRNODZweC9j?=
 =?utf-8?B?REZtQ3NPVFh5UjZ3YldMQm1zNkJtTlljb1AwUi9nRCsxZ1h5Z3pkOStYVXFZ?=
 =?utf-8?B?dGxnR1NJVEMxTGY2SWNlYkhqdk16SnE2R0N0THd5c05zalFjNkJ1aHNvZzBl?=
 =?utf-8?B?S2JJUWtNUmh0NXNSNVFpaHV0b3NLY3k1czI5YzVCSTRESktzdGhRWUQvNllz?=
 =?utf-8?B?RkhxeGZ5UnNkYlZVM0duQWFtZnA4dkMvRncxRnUySi96UmtVZDdnN25BRkZQ?=
 =?utf-8?B?M3NpUGJmRUNwSUx4dndiV1JHY0U2dGFPT29Ka0VMalpHSlorZmVRS05KcnVn?=
 =?utf-8?B?Z1JNUUkxWkhQeUNpY0plZzlRc2k3NnVIeksza0tZR0ViU1VzT1JoVStNTy9v?=
 =?utf-8?B?UTZhQnBNK2FlZ2xJYUhGbFp2eW1UZVZ1WTlKbjJjOFUrWWtBVUVaeUxjT0Zx?=
 =?utf-8?B?WExma1BaU2ZsTTlhVDVMby9uK2hvRGw1NlZSTVFSS09MZnAvSWhNWXprM0FW?=
 =?utf-8?B?VllFcXYraGVsbExyM0J3QXY5N3NRNzNYQnUxVEhrRFpMQ0RBbnhOQlpmTHBs?=
 =?utf-8?B?QUMrcEpyZXdwamFpc0lPZU1tdmh4c2poTVVXdE9ma09vYVZSa0RyYTY5eVZ3?=
 =?utf-8?B?MFVVdlFQNlQ3NmNoVTdkT3NJZHZHSUxUTzVwVTJPSkV5TzBOTHVlWXVISzJ4?=
 =?utf-8?B?YUtLNy9ubFNzUzlTRUJVTkYrYnZKZWZLMlAxampZamFwY3gvd2lvZ2N4VXZN?=
 =?utf-8?B?SVBXSk1EVjJwSjI0Nm1vQ2pLRVNVWkoyekZ0QTYrWU9DYS9mNHBFYnZIZ0Za?=
 =?utf-8?B?TGloV2l0T2ZEVDhuL2E3aHkwbnNCK0g3a0EvM1FBMExlY25sUitJWXcyNW4x?=
 =?utf-8?B?YkxyOTA1eWFob3MrWHRnMnJ2Tk9MQ20vVHkvNGg4RnhQaUdJYnhXV0ZYQ01H?=
 =?utf-8?B?QUN1THN4WlRrOUsvamszTm93TlhEYUhDV25OZnZ0elpJdFZCQU9XTHZtdE9j?=
 =?utf-8?B?TEJScnpkVVA5dUNSTUFndlhoUEM0U1hOYzNiY2Z3bnZIanBqNXZDTnBwY1BD?=
 =?utf-8?B?U3V4Z3FhR0NpZHYwNVNGaFZ5RlRNQnBtYWJnTFUxMmdHUVBYMGpvL1ZmT2RM?=
 =?utf-8?B?Q2dpeURPSHVPRUp4dnllcmwwWWh4Ym1UV3JTdXJNLzB1VXFFYTY0YXpseENJ?=
 =?utf-8?B?U0djZThKeUtVMDRDTXB2M25vYW1aZjlINHFCaXBiemFLVXE2ekUvRkpwSEM1?=
 =?utf-8?B?bHZkSkI2TWNiWVpxcUJ1NjczdDA0UzJ6bzc1SmdEek1sZHd2YWtYQUtuOVpM?=
 =?utf-8?B?K3BmaytWOXg5SllGL3ZTY0VBMmpYak9ySk0wL1huWDM0S3BjMWV2VE0xcmxB?=
 =?utf-8?B?NzBMM3ZFQmtNYlNCU256R25nRHJ4OFlHWWtLWVd1a08rVEc0WkpnN3hiRDlJ?=
 =?utf-8?B?NlY5NUhwQVh4ZmYxUjBkVUhJSkY2QmNRWUI3STJHTVl1RjF5Z1hDUzVvSXJo?=
 =?utf-8?B?SXMrdkk5T3hnR2g1QktEY3NSNTZjbEo4OWRsR0ZGR0pTcm9HYzNYRFRxMGJ1?=
 =?utf-8?B?dElxUDJJQldWc2xjRUVKcEY2UkF5d3dMQ3JvYW9ieWFEYUI4SDR6ZENoY09B?=
 =?utf-8?B?SXdEbmhhRTVGbEQ5bEpWaHI0Vmp3RTZLQWFoTzZVQ3JMTWFpQ1lYOW9pQlRr?=
 =?utf-8?B?QzNPM1ZXRWFPMi9rTXBNUkJiSUI3L1NNaE0zSTdxVVpha2IzS3Vkc3ZaY3Jy?=
 =?utf-8?B?Y2pTWmlYTkdyYUY4VEE1TlZGUkJBOFI3blovL2pwU3FPZ3ZkVHNoeXNubzdB?=
 =?utf-8?Q?qR4nIgQx1pfK4/9YHw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9c905a-f638-4a63-aaa4-08dec21b8724
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:27:42.3334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkBUcbSwCl/cI8hkdYCIX0LNgNM+XYtn72ERIW4RO2gEMDodq+v8rcjHpIO2a03/D7YcwJ5STzCj+hpcQvCalg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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

On 24/04/2026 1:48 PM, Yunjian Wang wrote:
> A crash is triggered when memory malloc for FCQS fails. Currently,
> the abnormal branch releases the txq, and it removes the 'txq_ctrl->obj'
> from the linked list, but the 'txq_ctrl->obj' has not actually been
> added to the linked list yet. This triggers a null pointer reference
> issue.
> 
> The call stack is as follows:
> Program terminated with signal 11, Segmentation fault.
> 1210			LIST_REMOVE(txq_ctrl->obj, next);
> (gdb) bt
>   #0 mlx5_txq_release
>   #1 mlx5_txq_start
>   #2 mlx5_dev_start
>   #3 rte_eth_dev_start
>   #4 member_start
>   #5 bond_ethdev_start
> 
> Fixes: f49f44839df3 ("net/mlx5: share Tx control code")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

