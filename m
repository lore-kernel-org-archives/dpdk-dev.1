Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F637C5B552
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 09:47:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 679504042E;
	Wed,  4 Jun 2025 11:47:06 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by mails.dpdk.org (Postfix) with ESMTP id CB4144029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 11:47:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5jAwXiNd/Vm+fQ1fxd1lTKjSjez0ONoQOcZyz1B9S6m6xp8JLJ8XunCqNEyfq4NPo2HIZF9yF6U51Dh3G1wyHtqauY8t9sgs0bB7xL1ILV92mMIwBX0PAOaB051seByrxnMyjuSNRr9IwOyyp5lrhjd3PdghPHe9yKRKi28FY0WOrWWjdClj+xS1HXcIHsC4GgmfnWE5CsFNBpeFNZrMSARyAzj5gUsGc/GVkGlaCPNCFW2gWGTyoqbhdvSuakaS+ri8EZlxA85/pn58tM4LISbTSicCrPtKNhXjdyfUy+6YlE778KjzSrxMNx+P0UM5Z+m15NrU7LH9Ov+Gdp0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8PAIEbg/DrT6nWMbeGUH0/+fk5qPWBUapvSk/SC4xA=;
 b=TFhxs25c8/WC92h82253bsk3nU8Ss/8Rirbxw0eL9XwH13lFAydmYe79hXy6NNM2bVrGKchIXF/4lPTp8zqbcvoav430ytRK9I8PYEGhJQmsYzR+7gBPzLmWyaZskQ18VARaomGJN4Slok6P3oS2w/7dkbd7fTiwy3dnYOtQ6shyqgWgmU9W14jIuUNen9i32la2VV5e8apEGXpPvVwDqr/kG9XFonTZ3RqOLbY4CakdGSsuHs+fj2kTix/UiJuG+2AT1UUmrFeBnR/TJlulp7CENI4K1edWG7XqO8ESH/8MxPTlk04YDXZUaO3XgCuEI6sgLmM3GWntVqSROnZa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8PAIEbg/DrT6nWMbeGUH0/+fk5qPWBUapvSk/SC4xA=;
 b=MJ2TSp0HhVRhZeOS+VDoqkudhmeNR/sdB49Zevn5bB7coVQlsE8irQjCjYQZRJExwaF4eaVC+vKJBw3cJd9G2WcJUGlDtZM4T5OzNMATnxiLwqSlV+rNLC1+cbKtlRP0aX/EqNGZfMzhvd/2nxaBCRUT5muB3Qt4ZgCoqE3OpqdEKTYrSY/ZLfUIg8md6/qJIJtAmqt7NWy10sdsPTheG/RaudvxGpqWFKPRtH5B0xbZS3WLnhLggqZ7mGNKhP8WD0pKH6NVRS8erfZ8zh3LoAGrAyQ1Z12RQoUt1m93UaFankIJwcbSy0NKcN5gDfr8FDryOg4gDrPP1wmlB+ek8g==
Received: from DS7PR03CA0260.namprd03.prod.outlook.com (2603:10b6:5:3b3::25)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 4 Jun
 2025 09:46:59 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::94) by DS7PR03CA0260.outlook.office365.com
 (2603:10b6:5:3b3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Wed,
 4 Jun 2025 09:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 09:46:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 02:46:46 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 4 Jun
 2025 02:46:45 -0700
Date: Wed, 4 Jun 2025 11:46:31 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: =?utf-8?Q?Jarom=C3=ADr_Smr=C4=8Dek?= <4plague@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] doc/guides: Mention needed kernel option for mlx5
Message-ID: <20250604094541.am4qvptj75x3ah4m@ds-vm-debian.local>
References: <CA++ArTjpo7QE5t4F0eevDsiuWtB_WN12FU9nxakxQ2a=nFxp5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA++ArTjpo7QE5t4F0eevDsiuWtB_WN12FU9nxakxQ2a=nFxp5w@mail.gmail.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d12693-519d-4d8e-093a-08dda34cbfbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmpablVNSUQ4dmhmOCt2NktrZFc4OSsya01vQ0U5ZThRRHR4NmQ5TEk4V3dK?=
 =?utf-8?B?c016Qm1jWHZGdnNrWXN5QWRFc1FOQUtKSHpRbmFFQWIrVmdLa3dBVE5xV1pi?=
 =?utf-8?B?dVd1WWhneE9YR0V5bG1GZitRVFRaUzZSUGpxdFlCSnJWRklYeEJHZzlRSFRR?=
 =?utf-8?B?NDBDbWNmYU1lKzRQUzl1cFUwaGhWZnc5ZU5vUkRCdm95VENlSU5yUmYzZnlk?=
 =?utf-8?B?eEFSMVk3VERFUHRNdVlTSHBBc3QzZ294STc4Z0hTbTlsNGVNREZYZjFuSE1K?=
 =?utf-8?B?WXRNZis2SDZJZkp6MktibnFieEE3NmttbHdFME9sZkJGTXhCWnNlcDdYTlNw?=
 =?utf-8?B?Q1gxcFNtR1NhSkdTOFlqVFJYQUhHM2NsNDdvbnVzam10bTlDd2ZYOXpuTDRY?=
 =?utf-8?B?dWFuUWtsN2dvZjBEOHNnbUJaZW5SenhzQWxuOGVlVGNUZ3hycDFoRVJxdWRn?=
 =?utf-8?B?cmVXU1VRU25WbGRienFsUWlyV25QOGR1a1pCTkZmK0t5ejEraWFwUFpEQmFF?=
 =?utf-8?B?MW5KNm1Ud2dRRUo4Y20wR2dtdHE1ZTF3UTVSdFhxV0FQRDdlK3k5ZFhQMTFl?=
 =?utf-8?B?TWV1K21LdmZsMTdXQ29CZEg5Qmp1QWg5SlpEcTZ6NlEyU1hGQTZSOHRNa2xh?=
 =?utf-8?B?N1VYK1lHcVJDNktzV3JZbXpkUXdQdFF0TCtRNHhGcVg3UUNXY1d0ZzJhWW1Q?=
 =?utf-8?B?M0I0UHVZcHV4TFpBbGdsUmg4djU1dndaOFc0VWc0VGU2UjZQUjFpZDBsbHpP?=
 =?utf-8?B?NkQxbmhEcnhQQjluYU1GZ2NnU2ZKOGdrOU03M1dKVzZiQVNvRDRtN3BzWGEw?=
 =?utf-8?B?V2VBL2ZVMWFvcjREYUFpSzdDWXZBdXJDb2ppWEZqY0wzclBKM1VidURGQy9L?=
 =?utf-8?B?WXJTNytPdU5wY25YS2lFa2JIVEl6dGttWTBuTzVXd25Ta1dNZGREeG14OTFU?=
 =?utf-8?B?eUFTQVBXeC80QjlvNCthbUlsR0pDWXlXZU5kWEhCUlVNZWY0Ukc2ZDA1Q3gv?=
 =?utf-8?B?YXFsY3orYWRVM2lkZGxjeDZITGdsUE13d1ZEc1YwcDk1bEl3WXY0QzljQm93?=
 =?utf-8?B?QnlZeFZ2Z1hOVU5QazNkY2NGQ2hjYy9yZEIyY3BjOHNTUmtxcEJYZERSTncz?=
 =?utf-8?B?VUNmdW1uUURjMjJRdnJRVUoyWDZuL0FQWjFpVU9PUFVIREtRcTRSYlcrREp2?=
 =?utf-8?B?VkJCSmVxM2ZNVzF4eVlmRnpqZWFRZzI2dnZKRStRcjdiWXY1b0NvMXJJYjN1?=
 =?utf-8?B?ZTNEc3VGdEhPNjAxYVVVRFZzSVNZNG1Jbm03YWMvTDBnNzFnTlN2czkzU3cw?=
 =?utf-8?B?ZWpWTVZGUU5rK2xDSk8vV0ZzY2pZd0dHNnA2dTRDS2hwVm5xWVhlWnNjMDM5?=
 =?utf-8?B?M1pjeWtQN25vRkdhcFAweGtIdStkaFQyQkNWQUpIaFFabEl1YnNDN3A1eUF0?=
 =?utf-8?B?SUFjN2MrTjRWSEF1VHp4VE00WU1xUDc2dlNxOCs5RngxbkhuNjd3MG1ncHBv?=
 =?utf-8?B?TmNIS1ZLWDkrQVhGVFlKRlRGYkxqTmtaM3NXR2ZQeUUrUkVzQ3NxQUt0VXho?=
 =?utf-8?B?SDF6WUNpWGhNZEQ0c0FybDBwRmVZd3ZMMEFsa3o4T0tzYkZ1NkVEQmpZeUJC?=
 =?utf-8?B?RjBwejNDWG5oMVpuSzlicmg1QmdKMFZpaTVRQWhzOGJ6b245RGRueDRJZDJv?=
 =?utf-8?B?Qkd4K0RUZThJZS8xQlN4SjRocnN3VjhVK2pOZFZNUzRkM2V5Umd6NUpzeXo2?=
 =?utf-8?B?K1RsbVlVdThWbzl4QzBzNmZYRTRvYmhDUXU4V2x0MGs1OCtyWTFBVHM3OTQ5?=
 =?utf-8?B?OHFvQ2pEUWFJNHp0WXYyUHg3N2tac09GR0JsbVZCR09nR2pyUjZvM2x6OTBX?=
 =?utf-8?B?elkrMDNDeTlhdmdUOUozY2tkK1pvaU5vVWo4VFhmR3FIUzhiTElmVmNESjgx?=
 =?utf-8?B?aTJ2V282cjIzS25ZOCtjbndIbEE2ZVdHRHQ2SmE3Z3NSeWYyUFhoOGJ4b0pM?=
 =?utf-8?B?SHZwY3BqZ0IyaUxqVnZnZ0kxUjEzY3hoNndkNE9OMGYyMEh0cmp5MUVnQ2JJ?=
 =?utf-8?Q?UNlqX9?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:46:58.4579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d12693-519d-4d8e-093a-08dda34cbfbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
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

On Thu, Mar 06, 2025 at 10:09:08PM +0100, Jaromír Smrček wrote:
> On some kernels (Debian 6.6, 6.9 and 6.10 tested),
> there is a missing option for "TC recirculation"
> that prevents MLX5 driver to include CONFIG_MLX5_CLS_ACT
> in the compilation, thus preventing PF1
> from properly working in multiport-eswitch mode.
> 
> Fixes: 11c73de9ef63 ("net/mlx5: probe multi-port E-Switch device")
> 
> v2:
> - Added additional MLX5 kernel option
> - Fixed patch formatting
> - Added "Fixes" tag
> 
> Signed-off-by: Jaromír Smrček <4plague@gmail.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
