Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F323ACED61A
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 11:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0925F40265;
	Tue, 18 Nov 2025 12:30:30 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012057.outbound.protection.outlook.com
 [40.93.195.57]) by mails.dpdk.org (Postfix) with ESMTP id CF7DB40150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 12:30:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGgXvt1by6cg7BuYyOdsvqIPuyf8jfQEZCRzAGh6ZmmKb+hAYSALi+b/HY/+XktA7wfdQ77MPyBOwdEjq4kj4cJLsq4U7ALUZspiKqlVfia9rqHyezJLjLJIiwIwYjyN9SPEeqfKBlE0QpwGf/v0UIwKWCzim+gv9B5qagEoW9nbFglcz3omV0EZwgvCessdkdSimYhAsmkTZmnfxiagHdE7r3jzXb34QNUFOql/OPg/iBsHfJmiPdms/NF2+nyWasH3n73o1I0pNtLEVNiCgRimVS9xADEyct7OhZa2sJHOuC0PyA3NCIty2l6c40ECjCpjmir4k06jiybDBf/U3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe4jzj87+qs8rdb/u6kCgXeJibQcWEnG8Oec3HanbDA=;
 b=uTiBww4yf09gBfY3bFn30Rm18qquuFrpYcGLOK5/n7BSz9pOEKYZoz4UKQ2iDikQtFrpKBV/Bn43UzdPGGC2hHUz1aAcy34P8FzpcSf7IvktxS8Rubb7L/76fc8nz+qcGL+gGOaOGMrucU/tI8YjWF/ymsV+3VDY28U4KzjWfpKZ/DteW1+uPaUzSYz01gDT3XgGNne5gtqVc54JqBJT51wBq2A7BpCGgKyvmKpwJ1PWTZdWYK+WPJuIulAJ2Hjw8LkgpMRrjE/H9r0F9GrpunNgypXuqFGxcj123a/I9iuhxXbHBWVLyLdr1/LAM2Jc4AY9CtYmBEqbBGvtrX9FIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe4jzj87+qs8rdb/u6kCgXeJibQcWEnG8Oec3HanbDA=;
 b=mpEvvQ/2vhvo62HOzpQ/jTgDmumCQJX7HEqLHu0c19XuIccIZe7m1Soz0hxPhYWC/w8MkZWEwOA9QjGj+q90OEj5hYyC9AaQsbNDQ91dczf1y/u7XZOmK21ExB0fL3xcYNSsabah4BRNAUHhNy0/CeFam3VxyP2J1d7aoM1QzMh2qAKqhrp6raowKDdSSyS6bjjgXT7t1kxUFQNwGl9PkpWLFdJie3Tn9XArqZkbTXHKYxKQUBQFS3ynw1A8HZW/0sOM/Ia8bX0u7kr4OnuKmsSMLd9VvS016+TtcfLMoxR0Zo5qFO7Kc+6Jbb/xRDe9zrYou0F8l+Akeg+rBkMqlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 11:30:26 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 11:30:26 +0000
Message-ID: <6a992595-fdf6-4f64-b505-f7b01ed659de@nvidia.com>
Date: Tue, 18 Nov 2025 13:30:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: skip Rx control flow tables in isolated mode
To: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org
Cc: orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, thomas@monjalon.net, Nupur Uttarwar <nuttarwar@nvidia.com>
References: <20251117050557.8481-1-bingz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251117050557.8481-1-bingz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 06946ad8-e115-4d50-4cc1-08de2695de90
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHh1MmE3dVpWWEpJdmQzdXVxQkF6amNxUngvZEl4UXdBVTRNVitoMDdkYk1H?=
 =?utf-8?B?RkJ3ZW5SV1VPc1FadjR2WFBMUFcyMTcxbzdRajhkcWxRdVJZeTN5ZTYyNGFa?=
 =?utf-8?B?STl2Y1BzN0p1UUxBYU1pbzdTNTVtV1RGNmQ4RTd1ZlBIZm4wWDl0WWJJRjlr?=
 =?utf-8?B?MU42VUl4MkU4Y0F1Ny9iZ1V2dXM2TUtvRWZBSUdLSXRnK2dzQWJjUlRheWJS?=
 =?utf-8?B?aDhNOGxGZXU3Z2FxYUNQd2d2amxFTE8yTDdBamRYMG14Z1J1dkZySVpaQ0pa?=
 =?utf-8?B?WWl3cTc1Zkt0QS9yclY1NjY0bzVMMmtpMlNSUUtZNDBubHRXS0NLZW5GbGE2?=
 =?utf-8?B?UlZHT0FQdE44TTF1dm5TODQwQ3hvM0J5dmxoaUx3b1BvaHhJTERtT1E2ZjF1?=
 =?utf-8?B?YlN4UTJKUXlGM3RNZ0FoUEVBUzNsQnJ3bDdvS1MrTGlnLzlvaGtYcVl2WUhV?=
 =?utf-8?B?VEJ1S3pQamVnSEZ2U20zSmoyZUJzV0ltTUZGb0NLV3lFcVlNQ0R6ZGo4TDl4?=
 =?utf-8?B?MGJwQ2cwRVFJNDVIdEtUd0Qrd0tlejUyNnR0cDBTMUNxb2RWYVpmc1dkTXZT?=
 =?utf-8?B?bXRsRmp6V3RBRkJmbFhTOHZWeUFYVEpSVEpKelRoQXQwdWhseE1CVUJiSXhV?=
 =?utf-8?B?YW12QjIwQlVzV3BVVUd2dG5WVGV6NVFUVGJnZmNJdWlhekJzR0RJZVM1N0ln?=
 =?utf-8?B?QlBaU2dLTXZCeHJrQWdsM2VPY3dyWEh5ZVRYak5wMnBKd3FqSW1YRThodmZi?=
 =?utf-8?B?Yk54aG5qSTl5LzRiTHYydklBRDZnaHB3RmRkMk9FVHlhaDVMa3l3VTA0OG1Y?=
 =?utf-8?B?V0JWR2Z3eTlkNEpUakplUnIxK1JkSWNBSk56azU0THc4YVVQK0M1dzB2clRV?=
 =?utf-8?B?d0g4bUp1amRpWEtBYlBJQkdKVlp1Q2M1eHB4NWVoQVltZlY3cVRJUVJUYWxJ?=
 =?utf-8?B?Y0ZHUWlsVjdBM3pmUVhHQ05aay93L2hydnJSSEFQVG1CRmRDenNYNk1JSkpp?=
 =?utf-8?B?ekNxMVNLa3RTV0E1NUI0Mllod0VxL0pHYUd0NFRNMUx3MXVSOUxYb0VMWml6?=
 =?utf-8?B?RzR0V2VMejRMSng3UFVhdXhxUTA2OExCcENQR1NUNGdQZDA5RWs4bkE4ZjYr?=
 =?utf-8?B?TVBRaGlaR1NSMGV4TFhIKy9teFZHTFlMMTlIVlRJVm5KMFJqM1B3M2dvK01k?=
 =?utf-8?B?ZEpkSjJhSFVBMk0yb2NublNUbjkwdmYxT3QvZ0dPdTZhNFVXZHVYbkVzRVpn?=
 =?utf-8?B?MG0xdnRHVkdIS1d2ZGRHS2RoRjUwb0hqMnBkSnBOekZaVXAyKzNDSWM1UThE?=
 =?utf-8?B?WTgxSFF0ekZ5Z1ZUM2VvMHRnd01WaTBRL0FIaGlJTXZId0k1dnd5MG40Mkt5?=
 =?utf-8?B?bzNsR3RnUXQ2TWw5MWdZUDhTSGlOLzl0SG9nN1I1SGhSRmRzV3hQVzlHVVV3?=
 =?utf-8?B?QjBpWklXYXhOZFlVWE1ncFYyTlhsSUVoVTMrekxHelIxa0RNRnhxS2pPaEJU?=
 =?utf-8?B?cDBkZUNTd3RpTnliZFc2UWdrQ0FwVStWTExRRTNXMWN6R21QTklHOVZaSVdN?=
 =?utf-8?B?UzN5NUswMkhjRGVrTWJBOWovUFY3aHU0ZVRSbTA4Q3RqVHZDMEtDa2NNL3Q1?=
 =?utf-8?B?V0JGVEszd0FFRDgyZHZHUjVIR3VvU3BpN3RNdzErbFpHcFoyaDVvNDQreExD?=
 =?utf-8?B?U2pMdGRIWEJqeDlGQ3k3ZFVRTkZGT1BMNWNBOFY0cmI5Sjl5Uk5ndjA5bVZ1?=
 =?utf-8?B?Rkg1QW45UGw3SUcwT2tzazBFU3M2UWpZbnZZQjZYSkRkWDI3Yy9WRHV3N1VZ?=
 =?utf-8?B?QS9wUGlWMlk5ZjIxOGQ5MWY1TjYxdXpoODdHMkVCMEs2NDRLSmN3bnk4eHRN?=
 =?utf-8?B?a3F5TVMrSnE3dTlVUFZMZFpPMHIwejBJOXd6WFp6Ylo1MDA1ZHl4WWxVU0lt?=
 =?utf-8?Q?Xyq7vdlpZAZstV6T9yD1stSaDH9Q6pi3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnpMb2JGWHF2Ky91MmsvVWVKWmlMUXZnYk5WazFlU0lnNXBraXgvZnREcUMy?=
 =?utf-8?B?RzBrZnhLMnRxTVZybWQ0WGRZZDExSGVnRWJrL1VzRHp1WWJyQlo4b0lNQ3pv?=
 =?utf-8?B?WWk2elZBM0dJcGowVWc3eWpBT1QvV1lQbG0rNDhSRlNDVldJVTduL2t4eGd4?=
 =?utf-8?B?Y0ZuYXRvakptd1lOR05MYm4vK1g1NmUxcUVSUjlTcDRHN2Z1U3NleWR5bXBS?=
 =?utf-8?B?anl4aTRFSWZFSHkzaC9iRklRa0luOHM0Y0NaTmQ1aXRzVnpiTG0rRDB2UEtW?=
 =?utf-8?B?VEdUQmRQa2NSRjFDRG1IamlPR1FRYTNvc3Q3dWVrMVV6eGkvL0xZTFBDRDds?=
 =?utf-8?B?SVlLVWJRenJYQ2xkSm5nb1E3amlZTzB6ZktIMDZNcS85T0RsVXRpNFRpZzRs?=
 =?utf-8?B?NEswdFlGR25aNGNncmlKa1I3bU9Ra29hWkFCZVpLRUM5NXk1TTRqOXlyYW1i?=
 =?utf-8?B?U044K3hyR0FvUTVlRnVqczFiQ0Zwa3lITEdtenJObE8reExsd3k2Wm9FN3pV?=
 =?utf-8?B?cUMwRFNTL0tpbnZnOE5BbmxWMjkvWm1UcnJUendmZG0zM0QzM1VkUm0yeDFP?=
 =?utf-8?B?MUhlbmQ0MG9RQXExQmdRNmF0MUE3NStackxwK1h6K001d3ZkY0UxeXI2VExJ?=
 =?utf-8?B?NU43R3B6ZVhmaENiRU9NckJkeGFZWWE5SDcwenp0b2lwc3oxekFkWmhHUGdj?=
 =?utf-8?B?ME5VRXVEWnExd0RiWTQzdysvYzU1VTBpY2lnTW5LS3UwQVJsWTVtdVliTk0w?=
 =?utf-8?B?bmc5WmVUTGMvSHpScmQwSk5wNzR3NzlJaGxSSHJpSmZ4YjVBK0NtWXZMNUdQ?=
 =?utf-8?B?R1cyb1pFMnRCRFlnTldjaHlKMytsY0ZCRnZqeG1TZitZdFY2OWo1K0taTEZP?=
 =?utf-8?B?U0U1UUtSZzlHS25aUlpELzR6NHNCcDZWQjRWR016bnFIMTdTZlZKRGgxNVRD?=
 =?utf-8?B?VFRBWDA0eFVlMmdjem9UY000dnR2RXRXVGxYVkM0REtWbExHRFhGK2tjRFly?=
 =?utf-8?B?dDdHbVZBQkp4N0p1NjJxeFpnL0pJL29vUXcrR2doblliU3ErYjNYZDc5RmVG?=
 =?utf-8?B?V1lrZm51M2Q4YTQ3UExnbzBEYWV4WkhYL3BKbTBWV0loWFQrRVVIQjFNdzdt?=
 =?utf-8?B?RFRtNENhbUxsSWdwNG80azdPeTJOeENUdlU2aXVRbVAvM0h0c3FQMGZMMHlx?=
 =?utf-8?B?MG5xajduZmxVV2YrQWFmclVjcFcxQmw5YVliRXY2Yy9iSFBzSTdRUHJGZDJW?=
 =?utf-8?B?UG9ZZmZjQ3RSbmZrUlNsVnMwRTkxUm5BQjZBQ0VXZGJnU3hrSDdFQU84REF0?=
 =?utf-8?B?eTlucTdEK1FhSkxyY3cyWlV3NnNDQ1Z3ZjVHdHZEVVNRTjRRcU1RRTNhdmtt?=
 =?utf-8?B?dlVBQzZiMG1vNnF2VDVBcmU3NnBQcVdic1pLdmpFaEhhSW1nVGdBenYzUDMx?=
 =?utf-8?B?cjdZblNkMUZKTFlUb3lCMnlaY1FWcmNXaXRseEVLL2Z4TXdsejN2bVdXSWJY?=
 =?utf-8?B?czgxUkxmMEtPZVBBdlRqY1Vuc3pKcEJTOXRCcUdWd2VVQnRFeUUrRi9Ha1Rk?=
 =?utf-8?B?M3RoZm0vNXZDaDRxcnQ0ZTd4NS92djRaUkhyK2tYTjg3Ykd6cm9QTTRwbFBH?=
 =?utf-8?B?UnFuYkJDOHp4UkY4emxCTm0vVjdrTTQ3UURBOG5naUF3UFNZQm1KOWhGOUdG?=
 =?utf-8?B?NHV3dTUvM1JsSFNweXlUZFpTSG0zcDUwQjhQRys5S3RhSDlmY2VOREVVL29X?=
 =?utf-8?B?M2g0ZnR4WThrYm5jQkpsc2ZGcFpqb0hkNWd4b3IzL0d1UnRhcEJiMGhzcHp3?=
 =?utf-8?B?ejdxZTFMVm1xdFVOZUlmSk91V2pUN2k1VS9YL2NEMWJhaEJjQWZkaGtQQzVP?=
 =?utf-8?B?NG5yWlYzQXg5bWlQWFdkOUFqR1BTdGFHYmtyS2g3Njdqa0NUcTQwK3p4a0Ja?=
 =?utf-8?B?dUJnN3J2MW9mNi9TVThXUlJZK2xTY0lDMi9JM3l3RzhET0wwbGU4OWwySUVh?=
 =?utf-8?B?SDcvaEhnQTRZZmZyb2N3U2IyOWdxdVl6WHhtWi9nZFpSSzJ4SXU4Y0Nhbk4z?=
 =?utf-8?B?TTdBdnVLN04wWGxlYVBXT0V1eC9jUDVJSWY1ZW8xZHJ4Q2hGS2NaTHlTb3JZ?=
 =?utf-8?Q?uhxyPdgBES+e9daWWYPffjyKr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06946ad8-e115-4d50-4cc1-08de2695de90
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:30:26.1797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JD4qCgJJzCS+vsI4WeO/n90eTLcWHTSt2yfT04UW3S+9CeLeuW3cF/E/HvcDwKJuHno2UYrAs0ZSNLX7qgF2mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
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


On 17/11/2025 7:05 AM, Bing Zhao wrote:
> From: Nupur Uttarwar <nuttarwar@nvidia.com>
> 
> If flow isolation is enabled, then skip flow_hw_create_ctrl_rx_tables
> because these are not used with flow isolation. This is used to save
> the unneeded resource allocation and also speed up the device startup
> time.
> 
> Add Nupur Uttarwar user to mailmap in the meanwhile.
> 
> Fixes: 9fa7c1cddb85 ("net/mlx5: create control flow rules with HWS")
> Cc: dsosnowski@nvidia.com
> 
> Signed-off-by: Nupur Uttarwar <nuttarwar@nvidia.com>
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

