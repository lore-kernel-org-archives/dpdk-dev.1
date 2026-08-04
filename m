Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A01EC55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 13:46:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4C56402D1;
	Tue,  4 Aug 2026 15:46:34 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012061.outbound.protection.outlook.com
 [40.93.195.61]) by mails.dpdk.org (Postfix) with ESMTP id EF00540285;
 Tue,  4 Aug 2026 15:46:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4DlfIwxDMYxt2ICrLZSfiH+6Y89pz4IKntDV6pDtkkY0wznZAfbOLrRbjLks+QA9cSzvBtnYbNSe4k3RkS6uCl47oqGUpwSPTVPQHCavWM1eoKyhPfcgbmKCc7UYH5yHPqH91POUK2tqylM8ZVB7AWQMkUk73dSgrPhAr6v0vNE+xAYtQ70uK5ztaLz95lqhiDH7bPsZwi91cTptkgpGEB2qqr5kE5+lMHdKPoHMAkHfCflrZ87e4eNnsHXSYJpE8HBbD/48lLP4GTLreGo4NPU0px9Pf//jJg6zEFnlEdzcZHsHPwBMdCaWlvUTBsZ60mmpNSDBJ1S4YgG5cH3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKuMeSCmjpZAteL3wfxbiTdKKyznp5TicJQ/0t+UZW0=;
 b=RWialC7YDaaMnWZo+7Q9vfO5p/M+Mx+dvXfcVkUQC/ellchiVQv0FVU0KYHFTXWxgYCUAKKQXFZDpbLuicn8ZWLTWpxlnBwxiQjQSz8oHseTv/Ge0OvE/LNvpc/8cMoUm5Fwv+REjEhfIfpPsn5AlhDk01i0Cm5MYsI/iRAvLk9Tzn5RUnJd9i8r75fBLjoUjlkin5Ez7+zHzoJ67IVI5BkvTsC7AjhPC+8WJ5977/qdn+k/583OMluM2/GilrXiBzQMaG4dGJTHSAmFpD8ueh7tYyIcVdKY9I8+oPaX8J55se0TIbeFxlsp1FnSdXQmqwBBdLajtfRDu5oMPhB1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKuMeSCmjpZAteL3wfxbiTdKKyznp5TicJQ/0t+UZW0=;
 b=Ang4QvY+ZzB7qOmhqz3Qh58XAIqP2lpqY6tDpOdHLY9Mr7o14qqvJ30AE706yQE8H1Ubulm9TNI7qb/Pi0209/h9jAFxEdLsPOy0ETElFYQDGZxgQh2Hr3G4EcB1Fsk2zku/UULKnh+dWeiAzW7D7QAINDrQCHPoQ5WdonChN+vYWKDzih2dLm1a5DrDNXY8uFfcOYWIjSYRZN4pkt6AQp87LuZM6UiCyQOK9CzdRNNFmstCb7RIEjRrdJouP5okn7QBnJ1f9KFT8tDpzUqVh6+fuS9vcWJDy0ZXm8fbnvvpZMQze58Eswc1Fn/xZJOz5fwRzJlDz05VgYy8uOfeyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 13:46:27 +0000
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d]) by SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d%3]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 13:46:27 +0000
Message-ID: <c49e8480-5d4d-459d-bf8d-c73321c42abb@nvidia.com>
Date: Tue, 4 Aug 2026 16:46:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.7 patches review and test
To: luca.boccassi@gmail.com, stable@dpdk.org, dsosnowski@nvidia.com,
 maxime.peim@gmail.com
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 sbadawi@nvidia.com, waela@nvidia.com
References: <20260727094306.41797-1-luca.boccassi@gmail.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20260727094306.41797-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To SJ2PR12MB9212.namprd12.prod.outlook.com
 (2603:10b6:a03:563::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9212:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 095105ad-562f-40db-026b-08def22ec7bf
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IZCd8p78GLCurMLByUk/95Ym2Euvk+Iv/3uXXJKJAciP7XsChfRFuXXcPXSEUNyeyaKZgN11nuXY1Ch+w7RnNedOQlgS2TSvI3VaNPhDtyYY4GNIDAJO4qwdOaQCecvnefpbdzSn+jVGqSmq08d0CBLecmV/T31wNtstRM1T91E4YD408eEKeTWtt+hq09N2s9ugz23Mvpcwy0oiSgQ7Fa7Wz+JQZ0IyJyAwPve7CMWohTi/x2J8BxdY5p4p3pQfCnim5IPYJcXr9dN2R+bEZFDNLQTTSI0F7k9jR+jshK2ZxcPVXAGCh+HxeFqgdbSiGWckaWlF7ZyATLNqPbRQleU8iIkfxWrirlE5irMoyl42wseJYYA1Ho5NZP3jS0QwpDrjtAspgGteBNdXRGGlhlB6FNHoRMmO1cjrSMYb8PPQZmg1vhokS0pEqrlaB3gxp9OCoUlow45/vs3ySMMcxhooHQx27JzBuijpnrKgqj43GVHCC0b3h4X6M7TUL8C5ZEsxkLp01mjTAJ0poyfRF2h0IINmNJHkXk3VxgRU1pNUW9A4OyKQHafPsA0AntbFLN4c9Za14veyQiAj+UfxKfi2tyPZUhkVPy+fh+8eza/Qu+YKXc412YfhQ/H1tXBIaz0FpjfwOzQ/MR0sBqhltCUxxKw2+NXjC8MmEzRWPiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzQ5b1BNYkxCYkFqakZ1cEF4cDhsVGJGekRkMHQySkh5QThGN2U5UnVNc3dG?=
 =?utf-8?B?dENJaUlBaVNxTnNrdGpvNlVPdkRqSnVXTVVKbEZKbVVNSC94Q1RNdmswMHN5?=
 =?utf-8?B?Y1E4SllpY0pqWVcrM2JjdExYQnhkMnVqeURZTzB1RENnUDE0VzIzVHU5eGhx?=
 =?utf-8?B?T3RKS0VnQzl5SEZrZTZEbU9BM3JJZloydjVsRWkyNkwwWjcyWnloYnJWVXJQ?=
 =?utf-8?B?L2FoY3pYNlJlVHBlS2tZWGtDa0R2YUJCVFYrVXhvZkZtUlc5Y2xHSnE1V3Ni?=
 =?utf-8?B?dytLeXNhRHA2bXVwTHJYTGZLWGVSV0dPTXkzN2RZb0xVTVE0ak9haFRmc0Rz?=
 =?utf-8?B?dFJtaURzanVaZU1VVUpPQURsNnBuWkt0ZUFGayt3MyszcU9pcUlUN1FzWFE1?=
 =?utf-8?B?WnhUd1Y2ZUgyWkFhdW1RYXJubTNvUDh3YWdIOTk1UFlud2FkeGRZaVZwUGZS?=
 =?utf-8?B?Sm1YY1BMSzV0c2l1YjVDS1J0RzlwL2lvc0VleHpkb2lQeGxwZWVlU2ZXVTFk?=
 =?utf-8?B?dThEa2lway9uUW9Ra0srYWdEajZtaTRXTEIxdE1OaEdvdFlMSE5RRWN2aW02?=
 =?utf-8?B?NExiakE2MTFwZFpWOHFkVHd6TmI4WldWSXUvNHZ2YzJXTU1uNjEwYmJvN0ZK?=
 =?utf-8?B?Mnh5OTlqcWJXK2xRTTdVUFVMRWIvV0VTN3BHeklidENsVHhyaTQwQ0NaVGxD?=
 =?utf-8?B?azhqY3B0Wm82Y2psV0xKZUFhMFpoNisvUlgxRll3VVNwYkVYb1E1WjNEY2I0?=
 =?utf-8?B?U0ZoLzNtZ3dZWktSMFBPT2FBcC9IaDlvQW1aQWwxMGo1MlpZSDI0S0Fkd1B6?=
 =?utf-8?B?RC9FZ3ZLRzhqMHpwcXhSaDNaYW0yY21rc3ljRlVNaC9CZ1hpQ3N6RFl3ZmN3?=
 =?utf-8?B?cTl6cmpURklZYWxWV29KZjFXQUxPM2UyaFl6NmZmL0V0ZjVpTXRFeXpJWFRM?=
 =?utf-8?B?UjU0ejRyVm1XYmZPakpvZGtJZThxVFVtYytjd0V3OWQvN1h1eU5kZXdDODlM?=
 =?utf-8?B?bFdOaGZwNjJGMURIM2hRWHNQZTlaUlk1RnFjNlNlLzZ3ZzRWQTdRRUY3cm1w?=
 =?utf-8?B?dDNDbWR1a2xkeGlqK0ZwRjdFVVIrTmlMK0h5Ukd5cmNBVlBha1ZWUHJWNDdB?=
 =?utf-8?B?eDh6cy9zczBoOGJLVTZMNitBZHU5RVFoUVNwV3JESVh1UytPR3o2VFZSTXhi?=
 =?utf-8?B?VzBDL1hjalVjRnJJSGRUYnZ5WW5EamlLVS8xbnhVVjBsY2F0MklVZmJ6U3F6?=
 =?utf-8?B?SUFQRG9GSWg1NzJGY2FkU1BmN2ozMllIMHVwNVQrNFZzU3FWWW5UZmJoODJG?=
 =?utf-8?B?OEN1RnZ5S3dpZDk4QUM0dFJHNkp0ZHQrN0lkc2xrMTBMbHZSQkJwT0VmeTRB?=
 =?utf-8?B?cEc1elFxNGtNMExrMHprUzFFa1BFZVU3YnJzd0dZWE9oc0pKcjJoN2pKVTI4?=
 =?utf-8?B?NWtuc0krU2xTSHE5MDJ5dnNsVGtwUWNwY0VQN2MrOHRpS0YrbVhQQ0EvVU55?=
 =?utf-8?B?M3NFUzdCOW5zVFAzc2tTQWpmazBNR3ZCSVc2NFFSWGpKdlpYUDhMck8wc0pV?=
 =?utf-8?B?NDBMd1BJYnh2RTVSemFhUkZxVWpDdTYwcVFDV0hVd1M2MEJocWx4TkhKNWpn?=
 =?utf-8?B?QUdTZTF1elpNclhlTWlPWXNJR1QzTkpyMmEvWTZrYkFJc2RLaks2SlZYYXJn?=
 =?utf-8?B?UXozWUZiZ3dFSWduM21ZTk1ldGpuU0JyTFkxNDgvNWgrdWJFcXRFZEd2KzF1?=
 =?utf-8?B?dEZGY2pYMDZmbkc1S2hhMTU3UEtYQ1cwR29HR1locU5XMFhobWxQWS9pZWw1?=
 =?utf-8?B?cEp0T3hwVVRaYUxBVml4SGt2bkR5bVU5Q3BMeDlHcUJRNDk5eEphVlRWbXZ4?=
 =?utf-8?B?VnlrVTBNc0tIdmhxdlRLVmNYT09VYWtwQTZ2MlFnZFd2bTNveE5HcGZkUHlG?=
 =?utf-8?B?dno3elpLMGptWEdQYldIOGpyRzlrTFNwMGtVU3lKYmlWdWUrVFljUVRsTk5V?=
 =?utf-8?B?aEN6RnArMHhmTEhMQ2Z6bDE2dGhvQkR2L2VpU1lub2JoQm4zV2RxOTU1OStx?=
 =?utf-8?B?WEUwczl3aDREeDdIdWN5bkRqNkpLOUFGMVQxdGFUWit3d0VwZFR3YW9TbUFC?=
 =?utf-8?B?akRhWEgvMlV1bFM5NUloT1VEeUoxdGhtcGNhbHhoZFdzVGZlQmdqSU13V0RX?=
 =?utf-8?B?NXREM1k0SkJJTTNFQnVVb2Fhc2N5Tk9iWWMvQ3l5Z3FVUVNLenlIMEZBZVFt?=
 =?utf-8?B?cjhlaFRaL2NlYm9IQUJRMDhhUzJCMGFicUhOSmRLOTNsN00zcHpoMnRWTG8r?=
 =?utf-8?B?THZtUEs0YVBCZ1Y1ODMrYUdGUmI2dTBOeE53YkFjZUd2Ym1YNVdFZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095105ad-562f-40db-026b-08def22ec7bf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:46:26.8904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShA7ApN0opmSuK7FWlVNczf4wsL9v/AErtf7Qf/6JkrG3mRVOaG7mCpMzVFAXnDJ8q2Tx5Fn+na2TC9TtINqlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
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

On 7/27/26 12:43 PM, luca.boccassi@gmail.com wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 24.11.7.The planned date for the final release is 2026/08/10.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.7-rc1
>
> These patches are located at branch 24.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Luca Boccassi
>
> ---
[..]
> Maxime Peim (1):
>        net/mlx5: prepend implicit items in sync flow creation
[..]

Hello Maxime, Luca,

Commit 471350f6cd ("net/mlx5: prepend implicit items in sync flow 
creation") on 24.11 regresses eSwitch HWS when representor matching is 
disabled (repr_matching_en=0): traffic that should hit PF NIC Rx rules 
after FDB transfer is no longer received.

The backport dropped the priv->sh->config.repr_matching checks that 
previously gated implicit REPRESENTED_PORT / REG_C_0 prepending. That is 
correct on upstream main after repr_matching_en was removed 
(c41f621786), but on 24.11 the option still exists and, when off, TX 
representor tagging is not set up. Unconditionally prepending those 
matches then scopes NIC rules incorrectly.

Dariusz volunteered to send a fix.

We will send our full report soon.

Regards,
Ali

