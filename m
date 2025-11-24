Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38EFCFA466
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 14:32:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5E3C402E5;
	Mon, 24 Nov 2025 15:32:10 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65]) by mails.dpdk.org (Postfix) with ESMTP id B1F2B402B1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 15:32:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGZMB2do49npM/MB0QQuM7XHNVa7/JACNfl+qNolTKiU/jD3G3eS9IL/Vi2xjnLojv1RemdyeR2FMgkS5gFiv1L7WKuoneyfhJyZhv1dgEFXFhADAZHOYkBrG0C/TxySS1kdfj56rGwWqmA673IqVypNMwSrBfYjHxHVPN6sTyjRZUllf9eB2HBVheB+Wv99NnuacsDDCAHZqtqEdOsEnL7I4pOz+6DcELiwl492bHIKk8GFtLQ82C27gjXemQIPXevV9H9MVJQde3tLA+EnOXPhOEK6mpugyPAgm00K2ujwI6oauWbFSwyehYikxSD3SN+d0+T7twgRnMDG/cO8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIxIpYjwMUXaMT8GBJy6gjBazSaOsoet1TcmztzeeM4=;
 b=yg1J7NM38/rcMwl25pnO5RzgDbEhzlyhk7Xp0lLyc2yr+S8e2HCQ3KZgWUvRe7ZUhtP8mSYnSrXeXgtyuCnoAWB6vXG4P8W8U2MAeiPn6FzsjKGfaeUjrRyHB7G5PhixE32/zu/vx8z5hC7XeYm1f5dKADQRr9biop2Fk94bYtSmtzyX385C8X8wPSL2VYJmmJ4FyN0d7kP3+tI73IFBkW+Z64x09Z7gudlch7ryqVLQQWMWdR03rXsYasm/H6Ia0gUZ//hLJfMRl6YnbK9vhFljK7+1/UODDPQn40iMWoLQKlCsckV97jjMEsRnXV9Ghz5JFpa/KBDgMSr0qpxUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIxIpYjwMUXaMT8GBJy6gjBazSaOsoet1TcmztzeeM4=;
 b=NfuUoFcBykr0+/zeO8WzyAYDDTtIpBl/LfGtC4g6QQ4yQYertfFeFNShgHLzvl3uRhCSwWCdEkrRe+Wb0PctaxaKvEnoE2KjeY+9DvIvXprx9QrfqU9+ghAzZg4q1cRetGgeI0fMi/vCRcgnoPLD8PwBSFRK0n2uFFZg/gMQH6yjL1EK+JXOeAFY4DJeNO73BLk1+6UfMsg6M2zuwS1VW4/z/iULzBUpeZgUNKxsT0Z2INAF6pLq4uLkwXFd6aE46YA83J6OSdhwiDwJvLegA1IoGJbAAsgBjvybLY4YZ9FuLUGKhd2Kj1tvrb6w9N2lt05YrgC2n+QSOUuYzc+ohw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Mon, 24 Nov
 2025 14:32:06 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 14:32:06 +0000
Message-ID: <2d4ee0d1-2121-4d46-9a0a-f7da4ad62ece@nvidia.com>
Date: Mon, 24 Nov 2025 16:32:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net/mlx5: update flow devarg handling for future HW
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20251106083817.166689-1-mkashani@nvidia.com>
 <20251106083817.166689-2-mkashani@nvidia.com>
 <IA1PR12MB807706F52B5D84500C3F78C7B2D0A@IA1PR12MB8077.namprd12.prod.outlook.com>
 <CH3PR12MB8074386185825633E3F6EBEBB2D0A@CH3PR12MB8074.namprd12.prod.outlook.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <CH3PR12MB8074386185825633E3F6EBEBB2D0A@CH3PR12MB8074.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: c99cf2e7-9a1d-4c3e-17b5-08de2b663e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUIvZFM5aWFRNmNBWXlBZGVMUEY4a1c0cUN5LzdTeE5uSi9ONHpUOG9lejB1?=
 =?utf-8?B?dXE1Y0owV0tyTmE4Y25MY2IybHA1TnEycGc3VzdCNkdTZkV4Q2d5MWsvUHVK?=
 =?utf-8?B?aXpPWW1JMWluNjBET09FYUpYMXNzekxpZ2hRNEJrSnBzNmh6SmdxTDNVREoz?=
 =?utf-8?B?TTY1eDg1NjJwdlA2ZjVNTklyOGl0cEoyVzV0VWhQdFl0blQ4OFFaUitoREZ2?=
 =?utf-8?B?cWV4MEdtOHVIMzM0Q016V1N2Y2FrZTRINUsrS01GVFpMOHBPV3lXNkFDQ3Z0?=
 =?utf-8?B?L3Njcm5YanVoZ3FKV25TQnBHMWdBK3V0ZWR5czFCOFRxek84L2RoUjJwNjNP?=
 =?utf-8?B?SnZDLysxRTZ2aFBpN1VPdXJ4TVd3cGcvZDBxK3FrYkFQZ3k3dTJ1MjlKeHQy?=
 =?utf-8?B?QnVXcjYxTEJ1NnRJblRWWWFTYURyUzdqK05HbnpKNVBiRmQ4VHNBZlVRVS94?=
 =?utf-8?B?QXQ3TkR5RE5NZ1Q3MGxRRHcvc0FBU3RVbDk4a2x6UE1XOXJWd2QrV1p5clpI?=
 =?utf-8?B?NVRFOHNuSUhFbkc4cG5VV3lOTEV1ZWFnUHBoU05kNTN3ZHBtdmlOVWhoRTUz?=
 =?utf-8?B?Zkx3T3Y4UHI3aFFlejRnQkgwOTBLRm0wa1BFOXpVRm4wemNpMEREL3U5bU9W?=
 =?utf-8?B?cEZtQlpnY1lFaEJ4NmhRK0IxMU9OUkpoN0gwMWxkc0pqOXBtQjNkUkZHTExk?=
 =?utf-8?B?Q2Q1aG5VaGJzTFlFSDhTRCsxZkR0WlFtNmpKZ1FpZk1Wc0dUazE1amRraDBu?=
 =?utf-8?B?ZkN2d2RBSUJCWGY0Q3ZJTWl2VG8xR1cwWkErNWZBRWhwOGZ5d1VWTFVvaWlv?=
 =?utf-8?B?dks2K2d4dDl3QW0zNTVIUEExSjB4Y1lLZzJTZkNBWXBZbk5ZYmgvMjRMTlQ0?=
 =?utf-8?B?ajJLZ0FaRjVKakFvcDNuM0w2U3VvTkR5TFZRVXkxUDIrY3M3eGd1Tk5NVW16?=
 =?utf-8?B?Ui82TDlBckNGSlhOMUhzVW5sZGlTR0RPUEJHVGc4SDJldzdRK3ZSZWRIQTZ6?=
 =?utf-8?B?d0lXL21qd1NjTGsrbWlZMVBpclJNZkRRRTVrbWovUkV6SVhYRE1WTWxhZkZu?=
 =?utf-8?B?MTFYVHZzT3lpakNVZ3ZFOFN4eVRSaThqd0RkdDkyYi9tQ0h3L0srb1U1R1lq?=
 =?utf-8?B?SGYrUHBONEEzZmt0UTJjL05YM1hDYXpOb0g4WUFpWXdKUTROUTN4U0xwbjdl?=
 =?utf-8?B?VUJRUzhvRGNuVlBBT2luTlJZOXFNQllBSjg0OTFwOG5JWW0xZWsrZ09Bckoy?=
 =?utf-8?B?OG1SRENkejdwbzlmVzg5ekFCdW0vVlRYTFV6UUF6anEyVWJtMkQ5QTA0bVR4?=
 =?utf-8?B?WWNNNFJ0bGEzYjBBVTdQR08xZ1crdmJOYVRUTVhpM0N0dGtoU20xc2FmajBG?=
 =?utf-8?B?N3o1VWFOQ00yeWhXSnY5elN4SzBudXBITU1SenpiV0E2YUVNQm5wR3pCTDJu?=
 =?utf-8?B?WE5Ud3pINTJ3ZU5SN29aS1V6QktEcGdCcVhhcHhhRWFoeno3d2VxbkgrVWFl?=
 =?utf-8?B?WkJLVVEvT0ppUmtJamUvUWhDUmJpbXcvUW5VeVBOeGhBanloN2dZMUMwMDJj?=
 =?utf-8?B?VmRiZGF1Y0NEZUJwN1NFWEVUSVZld0lYS1VtYlQ0MXl6cUlPUjJ4K1VGRUdt?=
 =?utf-8?B?MWRUZDNyR3ZLdUxHY3NYTFYzWHlZakhtYTNBdER4NjNLVG5hYUxEdkl5VUF6?=
 =?utf-8?B?d2oxdDkrcGFEdFRqOTZIa0ZuT081dDUxUko0T3pmOGUzZUhzSExSZUgvQW9N?=
 =?utf-8?B?M3ZWUGFaVEFGUFR1d3V1aU9aQVZLQ2ZJSGFOZmpkTVlTVDByeGtHNmp3NmV0?=
 =?utf-8?B?ZGFOcVhMNkt4THBkcEJmWFB6Q2pBbURNSC81TWJ3bm14L2tlSlBjcGQyemc3?=
 =?utf-8?B?SUUzcnVuWWx1YXlSaTB3a05EOFFDaUsxN3BZQ1EwRXMyUVlxQ3djVGlMY2dP?=
 =?utf-8?Q?t+EcWVXjFhnibzJaPDLK/TphYukj6dNe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clhzc3JlaHk0V3QvU3N3VmVIWVAwZUEyMm92RkZSRXB2ZW83U2YwTmxDeG5E?=
 =?utf-8?B?dHdkMmdRTFh2aVo1K2d5dHE1MHZvd0RUUWFmdTdtRnA3dHJvazFFcnhIVHJm?=
 =?utf-8?B?OXNtekhscHZBQzcwUkdUTFBFa1I0VkVIS3ZuQysrcnVhYmdHZ1kxdmFmeUU3?=
 =?utf-8?B?SVBPUnVJZ3B3Y2F1ZHc5RDJRS2g4UFl3SkhHYW1SbDUveFpOby82cVRsSjRv?=
 =?utf-8?B?cWZ6UEk0dDlHcmNUYnNWNm84citjc01RVDdGRkpmYTVSN0Rkd2JZTUs1b2tZ?=
 =?utf-8?B?QW1pclltN09Fam05SkxGZjA4SldKb1o4eVRBTVp4TWVXbXVrMXJDVFN6YkF3?=
 =?utf-8?B?TGpHRit4Z3FtVWh5UnZVNTNXOCtuMUswdW5Vd2d5TnZOcGFocGlNeHBOMjZO?=
 =?utf-8?B?NzhZcUFKSms2QzYxTmVobmNiNDZ4d0txN1VZYVJ2TmloZ1NndkJmdlNGZjVH?=
 =?utf-8?B?Um15WG1WQ01xNm9uR3pNQWMza1VHSDY4aUgvNDhEbG1TR01wZHNiU3RkdjNC?=
 =?utf-8?B?RHl2Z3dBWFplMDBOaS9OdnhZSVJ3dlNSblpSNFhOSEtXaTZjd3phUUo0aXRP?=
 =?utf-8?B?U05ycnpwNVM2bUVnL3ZzRkNHZnRSemppb0xDZE1MSG1iMlE1MjFFVzVYRklx?=
 =?utf-8?B?eGFoNHFmVGpXR2FEQ2x2NVNMN0E2TWdIVERTb3c3Qk5ZdFZ5anp1OUtDMU03?=
 =?utf-8?B?RU44czZFU201K0hvSVBpYVNKWlp6dXNtcjkxWXNCUW42R2g1dzRLSkRvb3p0?=
 =?utf-8?B?Z1pvajRtUis2TDBHcDVnb3N6aGR5bmYva3dLS2xXZTVDYnRKMmtmaWhVSVRQ?=
 =?utf-8?B?U25USDcvdjNZeURkVEJKZTJzTTh3VWpPTjlvNE9tRFBVUitnWGFKNVN1cDFD?=
 =?utf-8?B?VitvYnlEeTdUUmlOMkR0djB6YXptcXdLaVBvOXdpOU1TM1RYVGdzWDJIVE1y?=
 =?utf-8?B?NzYrS2UwbHY3MTJmV29ZSlhZRlVBY0pEaUFGWExuM0xyNmhRYVRRNnFQeUs1?=
 =?utf-8?B?Z3gyL1BPV2FaVHlFNXVQUUtsa2IrTzlSNHVXQVBCekIzTERGSWN0WXZXQjQ0?=
 =?utf-8?B?ZVdHN1pYbUtWdDFPV2dXYlhZRWd4OGRodjN4M3VZZGdmcm1ybE9QL1FWeDh3?=
 =?utf-8?B?RlJZWTlOT252UkdjVTBHRnVTbjlUazhCVlN2WDRHYUpVT0d1cXh6UFRZdzgr?=
 =?utf-8?B?T3ZXRU5pRE4vQTdvWjJUaFNvajF0NGVVSFVxK1FXUEtvaktWSXZVenZuNjR6?=
 =?utf-8?B?aU85MlFOSE1QNThmQllLNi8vNkV3Q05lYnh1VGJSVnhDcGZkRlEwSGhEaHh0?=
 =?utf-8?B?VmliUFdZenA5ZDEzZkF4Y2Fob3pEQ0pJcHZkWlVJSWsyM053VHhSMm5qbitP?=
 =?utf-8?B?dkFleFN5TUtTYVlIZnVOOXlDZks5anR1VnBPYVZrTWdpaGltZGVudEdLNVBN?=
 =?utf-8?B?UWNtazhjdHJvdmlJdGg1OG4zWTRjZ0NDeEZxOVdzK1ZseHZUMkJIc3NpRExZ?=
 =?utf-8?B?RTI2WFU2K1BCOUV5akNnMlE3RW1CcnZjWFl0d1lkOCtmdWxUa0Fwb0VtR1Rz?=
 =?utf-8?B?bHZyZE1RWnFmNk9QUkdLVjZjeXN6MGZzU0lUM2F1cEZPOFZqbEpsOXF5d2NK?=
 =?utf-8?B?MU9MWHFWZDFnZGRGdXppeEJhNVdKNm5iN1hkeXljeFFFUGx3VHZXRzlWSHpP?=
 =?utf-8?B?UHd2bis5ZzdRbVJiaVM0M292M1ZoRzMrZW9HRUs2KzY0WnZZMXJqRWZ5RG04?=
 =?utf-8?B?VkkzZmxYaG1WVW5vMFJIdFJmdzJhbmJBREx3RmIvRERsSlUvNUo5THpLUzhj?=
 =?utf-8?B?WUNuMGQzVUZTa0hiQW5Kc2lxVEZKNDV0L1NDa29rY2lPOGk3L0lROG5KcElv?=
 =?utf-8?B?UmQ5cy9ZS3diUGhoOHZqMW9PN1lMK3JkdzZKVjNvQnRPVkpGTitvaDFzOEJa?=
 =?utf-8?B?enVjTGREeUJUanJLYWF6U0Fvd29iV1lPalJ3RERjYkJ2OWZYakpMa1JVd0NZ?=
 =?utf-8?B?WlJrL25RZW5lb2k3MmNKZWduZ2JXMmZpUVROZkR2alBPZzJUMzJmUVNiUHpL?=
 =?utf-8?B?WW9oaUJEVXN3Yy8zWUk0Q0llWEExZTVKWiszeVBidytCTUsxMHBKUlpqcUpj?=
 =?utf-8?Q?XPMzMnbR71saKHdwT3jC/HEe5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99cf2e7-9a1d-4c3e-17b5-08de2b663e1f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 14:32:06.4842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LtmM55bobdRn+3tk5Qh1wK3zuBUZIymRsBWaGrTlVJed5UCcswvnJMAIvSIB6/D0xzllbmwyqdW3uumK7jsTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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


On 24/11/2025 11:01 AM, Maayan Kashani wrote:
> The series should be reverted,
> the series is handling untrusted VF's/SF's same as CX9,
> Using HWS engine and causing a degradation
> (failed to probe 1K SF's cause memzone segments exceeds maximum 2560).
> 
> Regards,
> Maayan Kashani
> 

Reverted on next-net-mlx,


Kindest regards
Raslan Darawsheh

