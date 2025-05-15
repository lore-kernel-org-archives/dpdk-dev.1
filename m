Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2568C54754
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 07:09:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 109A040B8F;
	Thu, 15 May 2025 09:09:45 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by mails.dpdk.org (Postfix) with ESMTP id 37D7340B8D
 for <dev@dpdk.org>; Thu, 15 May 2025 09:09:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIPUxA7Z2t5xTTYaIYPoPtJD5pmZt/WOkhLn7WYadVPEgv53lnmFzHiiazkVvkzOxPxYGaA1Dp3Kj5pdPTscMIPQy6TNubiNmh4MQC7Qc3kZ9EPZGtCSR1tBcR4MmwEtnJwU4tDcTUIX3X29Bgh7uJ82mhTK6TSnfFeufw6B2A8UzBIX5NG8Dc1cyx+q2y3K2hMurE0VnMOSthACcnAhdqmZKwndv4SfGGunqyMeNXV18dbMjO3/nF85fgDYTuJUcpOCMbitUU1Lv32Lz2D32Fe7xYj5OfPvFdLCtBxp0wp+k76LCU9K2kgtio5FaZ/edYtibDffaAHXSeUMjWIwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSNxl21HL95A4QzLvr7fd6MuHklCsSk+Ywj8xtjDHMI=;
 b=zS0QJOKW1AktTU737vYAF3frm2SuFy45Sf0w10jgPk04yvjO9yogjNLwbzOJ6VDDv+F2CaZw+DPa5R+g2qLf/CYjEOYYK8W6UrvKmahXGUCSPpBit5Y5MKWZdBkcHrM85tlOK5uirpWJ/hUp0R5UPVBfky3Szoq5j3Be2jkQdO+k7cZntDsxP4uheor3FdlacuQf1JsqXoIEj+TnTwL0K80g+jCkdHVoUzr2jOKXWZFNIT1C5bLPEEZixfAHA8bWEx/Qm3zfRMvdxoHoxQ+G/qgpIxzDdRxLmsRqEGP+/ZHc1sheY0vvzXbSPvIm4ksipQTZxfde9O2bGrvFzjjA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSNxl21HL95A4QzLvr7fd6MuHklCsSk+Ywj8xtjDHMI=;
 b=IGOIR7wOvioovnVXPgCaw0XKY+NIibHCYOfBdMSCU6k+DMyMYUzo9kjbOmePMvR3YWsplxLOLnyFx810qY1r1a1bZM6rK+ZiBUTs78nAK+K+Vfnd6Ehejflcfy62JmoLfoYpqTzZNGF3q7mEp8/WGVj6dFOzdQh3q6C1IhrE7a2lzKQnxRl9s4aziHhfBSQKNu/rHzogtv7GOYVQ8/Fk10U7bpH7mqJNa0C/jTFFdu3EzeiPxxSmQhBuDncvyM8TIui/VoYiOjs8YNKf+CbYjjWw3y96IWfSvFuQfur1BzMo5zb3/nehboamS/5Y3d1Smf3OsQcdaMGLCdQmuqm9Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 07:09:40 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 07:09:40 +0000
Message-ID: <dd54d23e-5246-4e47-9c5f-9817b161396d@nvidia.com>
Date: Thu, 15 May 2025 10:09:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix error notification for large patterns
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20250506133206.379993-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20250506133206.379993-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e9c79d-9e9a-4670-cf31-08dd937f7570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjV3SG12S1N1ejd1dHR6WTRWbXFvaXowd1pyejZmTndHNmZ5bjJBTDlOMzdQ?=
 =?utf-8?B?cWEzemZ1WXliQzJsVVVkUE5Wc25kaXVVemJiWTd1cUxJVk0yUEJnMnFEN2xv?=
 =?utf-8?B?cDJta1JwV1FldmtRZ2FLaDEyZjdRT0N4U3dQQ1h0SVdXLzU0SE5aQnFXazRs?=
 =?utf-8?B?TnlHeW9jQnRXK2dUY0dIdW1hZjlpTmJzbDByQlNEaXJreldGcGU5MG5ZdTZl?=
 =?utf-8?B?bENsWW9mN1BvNXh1L1o2TGUyZVNYNlF0bzg0ZWJnNmR3NTl1d1kvb2JTQVd5?=
 =?utf-8?B?T0t2akhBRUhmbFFVT1FyTlhLYkpoaGlpNWZpZ1RMMG5GRExUdm5qS1gxTGpD?=
 =?utf-8?B?UnpXNzhlcjlFbnBGVnBOZ1ZOSkJwTnpIRStKQmkyQ2xBYzMvWVY0MWFXN1VP?=
 =?utf-8?B?d2U0WUdaTVE3cDJxU3lOUStRSHlJK1dYZ0k3cHNiZWRabWFDQXhnaFFkWVNw?=
 =?utf-8?B?UElybFZ1RG96Z3VUWFhSMHZZWHhWaHNoOWhPcUlZN3BlRFRWMDNydFU5T2VO?=
 =?utf-8?B?ZlNqT3BXalpVeDNic2pYV0FyU1JqVjcvRmd0SURSbkJ4MFZ4OFZHWlkyeC9a?=
 =?utf-8?B?cHBaV2xSNjlqRURKQmptajRsd0UxQWQ0SVFyNE1SWVpHcjBiSmpTckIwTDdw?=
 =?utf-8?B?U0tLTVFad3lVN2FRQnYxeFljRzZXQlBNTUErUFR4b2gvaVg4Wms2cFNWd09m?=
 =?utf-8?B?dGtiNU5qMVpINDg4ZFNYYjBleVJvV1ZYSXczN2NGSmxyQ2xxSytiTkVLWUZn?=
 =?utf-8?B?dnErZTVWUXJvOXN2Sk9OSzY4Z3RaVEJsRjdIOUtCYzZFb3pTdXRMdVc3ZmI2?=
 =?utf-8?B?OFhZZ29xOEJkZUtQRmZBbVMrM3phbTR0d1R6QUxsVm8wZ2d3WWljSS8zd2ov?=
 =?utf-8?B?ZjEyYS91czNCZXNiZlNhOFRMRkM2WVQ5Q0FkTkJHemFBVWs5U3BQMzIzMUI2?=
 =?utf-8?B?VzBXL0hCMkVCVll6WHNwelFTSzk0NUw0Ty81Tk9TNTFOUFBRNFdyQmtFVFB0?=
 =?utf-8?B?QjBzSENKc3orVWdwOE5NMWRzejJObzR5OUkvdHF2OEx0enovSTBIcUFjZTBN?=
 =?utf-8?B?ZVhqdDVoY2ZFRDFKTHJoWFlodVVhbjNJTVlHdWZWRnV4QzlsQjJDRmFTeXJS?=
 =?utf-8?B?WGdSZDh6UU9UL3dKc3ZhZzdWRDQ4ckdoSnF1NHhNMFVzSHowd0FXSWQ2d0pZ?=
 =?utf-8?B?RHBTZVdaWVBGUWxZajRhMU5pYUN6SXFuR2NpS2FtR053R0Z4Wmc0UFJGT2RN?=
 =?utf-8?B?SlgxWjNrTytMYlhsWmdrUXRnSjc2UXk0eUxTRVh3YUhudWVmSlVkY1drSFdD?=
 =?utf-8?B?bW03ZkIwTmtxS0JPM3owQzhnWFdDOWlIcThuZkV2QUdSVGVFUFowZjJPZ00v?=
 =?utf-8?B?TEZWSVQzelFiMERDTWFIVUpydlNnczEzNjA1eXAxeWpaTWZWNGNMSWIxbitF?=
 =?utf-8?B?SmExd3JsdlU5QXM5WTRiTXdMc2Z1OFREUkVVWjBjbWNnZWFKM21hYlJHZ2ZU?=
 =?utf-8?B?dDBjTmVVY0RFOTYxeGErTWR5M1dJQ1dBdlh2Q0Q2VXJUSFF4c3pTRHZOaUxk?=
 =?utf-8?B?OS85ZlRQTmlKaTRrNUx0Y3d0czJ1b3EvQ2tyd2NiVGR6d1d2WG12Q0xTckVM?=
 =?utf-8?B?TTBKZWFHYmRFL29zb093QXg3M1BmbGIxTWl4OGdoNW13RWp6SlJHSzlFMGNW?=
 =?utf-8?B?czJqMDNFVXg2N3lKNTRWM3lXR0ZGeUhReW1PamhUUTdFVERnMjlReHRQYUlS?=
 =?utf-8?B?VEFqb2tvWksvMGlBTC91TE5jUlFZdS9BOUpoOUdOcGhJdWMydVVJKzZEaVZF?=
 =?utf-8?B?ejg5MWRDRVp6Tm0xU3kzT3NsbUhxcUdBMG5zSDNlbGxOakdOZmRaMHZ6bVN6?=
 =?utf-8?B?bGJoQllzaFBWU1VTUmVXN3NITFllbzRkWnArcUVpdHhZU2UydTNRSGY1dVZl?=
 =?utf-8?Q?DAYojOcN5j8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm1mK0tRWjNVRHV6L3hPRW9nUlUyRVdMdnRURm1PajV6Rnl0K043NVFEVUQ0?=
 =?utf-8?B?Q2JPNXIvNXNzL2ZsZ2QrU0c5bzNRQlA3cldtZWpVTDRvbG1aYzJZdnVYNmlj?=
 =?utf-8?B?YUhnVXB1QmZKRkRBbGQ0bit2cnU1U3FOcmpGME54KzhXOVJMUEFnMkVKUU5C?=
 =?utf-8?B?ZDBqb1dlRmhpekVJaDFiN0pmT0VVY1lFSVFkV2NjOGhSZ0xVSVhUZ3hKT3lk?=
 =?utf-8?B?UmxmdFNFTHUwWUFscENLZ2FsR3hOWE4rcjlrVzNvYWpVRE1JNXlVQ3Ztd012?=
 =?utf-8?B?M3RBeWlmdDZQc2hOUGEvYmc5MDRsYTBOcllDSi9NSlk0TmhFYUZzNXAxNWI2?=
 =?utf-8?B?OFZvSHdKaUZ4MnNiSzBJUGl4UlRMWDExTFFZUXFNL2xIM0IzTDM1ZlBNYzgr?=
 =?utf-8?B?eE5reGR3eTdQbmdJSk9JdzdTb0NUR0UvNmhVc0MvRi9ST1lKRHYyMEpEU1Mz?=
 =?utf-8?B?U2djb2FsSmk5YllsWmFNSWczSGVxOXBUQU0zNE1pSnJMM3liTi9yYzQ1V3NF?=
 =?utf-8?B?cXQ3L3JZZnV4Z3hpeHNpY0xxZTZucERZeklFcnZUamoxbjQxYlBLbDVDdVVJ?=
 =?utf-8?B?YlhsaytkbU1EUUtMV0tIRm5UcDd3Qm8xWXlkQjFQajg5RlpjZ0Q3MVBDSWVJ?=
 =?utf-8?B?eFRSNHhuVnoycFVQOGUvM2xqb2pzcDR5V3VtaGVzdnJaeGllVThWa2ZiaEhr?=
 =?utf-8?B?SDFzZGVGM2p0SlZacFIzOGt6c254NzJXaUpwWlFGWmFnTE9iK2ZVTHFLT3c1?=
 =?utf-8?B?N281WW1XeURXM25BUkxGRlFJbGNBbGNkNXZoT21PcXNZV05PTnVGb3RGS3FY?=
 =?utf-8?B?dzltcGNQaUFKbmFKbEZFK283UFN5RGxqZWxwMU9DcjVtbytNcmtGd1lqaTBD?=
 =?utf-8?B?SjZlSCtTSS8ydEM0SnFvTmdmTmNueGxhcWJiWDE4ZnlUYml0V1hwbmtCS1pZ?=
 =?utf-8?B?OVU2b3RLTHV6R1Z6R1pvZURyNUQvUUgxbkRudTgwUFk0MWpuMUMyb3d2MVhD?=
 =?utf-8?B?UHhkZDRlUS9La3dSOUVCeDc5cUFIV2RtZ3FKOUVuN1NOdzdxeXJEL2hQNFlP?=
 =?utf-8?B?K0JkQW1VZStrWTVQMEtLWDJYSzJiMXA4UUp5L00rY0JNV1hGL1dNYTR0cTJS?=
 =?utf-8?B?dG5OU2J3MDRnUjh5MUVkVGx2MWxoVEV0bDZ1c080a3l0d2VWaCtoQm5xdVZu?=
 =?utf-8?B?d3BuVVlkOUYzU1lSVmgzcHdJclNzNWlONU5mRmRvOGUrOThGT0J1TDgvSzlu?=
 =?utf-8?B?aGMrRk1JRHdXcnBma2pDYzJmQlYxOU5kVG1RVnVYbFM4NUNLMW53dWZFUTYw?=
 =?utf-8?B?MGtVWXJsZHczSm15Z2F4U1JaQWtMYjB5RHNKWXhXMGNzcWpRRVhMcVFDUEJQ?=
 =?utf-8?B?ZVl5T1h6Y1Vubko5NEkwb09Sd0dtM0lwYUpZdGZLTmErTm9icmxCcXd3ZVlG?=
 =?utf-8?B?OG1xM1hsUG1ha1plOUlETmYwZk9jUk9UNXV3QVhaNXVlZWZzNFFXSXJaZEVj?=
 =?utf-8?B?ZVVOay9WQjZPdEZxMTYzbGQrT2ZyL2NHdGZ5WUVJWkxNUWxZU3BrcEYrVmlF?=
 =?utf-8?B?dXdyK3lPanFiLyttY0hBclA4LzAxNFZZZG5kK1dxcVRDaU5pYXpScG9OaytJ?=
 =?utf-8?B?eGYzbTJyWGhyVzdYY3BjOGRmQmdFZW5YczZtMlRkejBtTDdFZlZDTkFsaWgw?=
 =?utf-8?B?WlNBTDFLVldYc0I4aTB3L2JHM1VHeVV2Tm5HczlyaU1sSnhiMW8yaklnUGFK?=
 =?utf-8?B?Z1FuaFk2OG5jR2lha0h4SGxJbFBYTWZ4bUZDM1pMVTJXY0RIOUtLYk14VmN0?=
 =?utf-8?B?QTU5eFVqYS9VVXg0OEtGRzFVMmpuN081WEZpZnBIZFl1dmhwdms2RVVBNFIr?=
 =?utf-8?B?YzJoZWtobmthU2lYRXJEdG10YjM3aWc5dFFETGJaMi9YcmkyLzMzNUE5QzhO?=
 =?utf-8?B?WmZ5UjhwaFUzajNJWDFHQkJMMEliOHVzWE9nUDN5alJ5T3V6WHk5T1JTQTYz?=
 =?utf-8?B?N1hpUTdBVDRybC9iWU1BaGZLRE0wcS82ZGJRV1NYZW5KeDZQMkVZdHc3WXFw?=
 =?utf-8?B?aC9QSjBUYlcyRTRqOFBNdWpvSmUzSjNpNmZsakxoSmZLOW1WYlpQR0lYclha?=
 =?utf-8?Q?27ZNv2tZExuEG0KcMXCEyUiSE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e9c79d-9e9a-4670-cf31-08dd937f7570
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 07:09:40.0745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrWpWRuHoF67UjqGiP/Ezf6Gy0p42xwuK1J8Fuc7ItLz0Uu8ey9Llie85139B2k6urBE//qN6VLsIUGdyvyMuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
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


On 06/05/2025 4:31 PM, Gregory Etelson wrote:
> HWS has limited resources to translate flow pattern.
> When pattern translation does not fit STE, HWS translation fails with
> E2BIG error.
> 
> The patch verifies that the E2BIG error value is kept during flow
> error notification.
> 
> Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>


Patch applied to next-net-mlx,

-- 
Kindest regards
Raslan Darawsheh

