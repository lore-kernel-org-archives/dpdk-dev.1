Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06ABCD13D2
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:58:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 167C140648;
	Wed, 29 Apr 2026 19:58:02 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by mails.dpdk.org (Postfix) with ESMTP id 874B7402AC;
 Wed, 29 Apr 2026 19:58:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dbzv3Ls/xfMW7kBNp69ppraRRUwsTl1VR8CGT6pNx8cObnDUZdmJXhFcViGJ9nlxLHHy3bg8DfJjNzgn8QAZZj5cS73p/wxlKDEwv6JHvewmOP1gfTQvWTolFR6tzhdKVoZCxbnqeio3h+HPL2lqNuVb+d01DfMQvVa1cOtWPDtw+UGxU9e09PsZWKgtSVmS4bpnL6RAo4OR/aT7O6Gin+n6wq3TQPU9bgwi48nxQNawfbFBkkIj64lcZYOC+xbMY+SkhZdQtZ8+NAVvdyRQVVmDH+/K41R9rE3zBGMQEKlRkQ3xyDg9thzdX6WKjxTDF8N/sUJhSwds+KcTa1VKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RjLY7Yck87sKyFhR3wgSOcGKH+7XGuxsF/RwpG4yeQ=;
 b=vJjPWpdU6vBMzXYq6aJ8eyZBv6tcxpUrpe36oKtU2qnW3lCWnNn24X7Dc7kohTI7AQHj6rDpSIbt83gxmGHfQxS2g4B065EHQ1iO+9zL2t4CpwcoQ9ylcGNV0FjHepJzp2umDSAhjSaYU61f9DLCKtgZXdqF9j/ZXPLo4u6JEd/585IUQAuLIBhFJY8/bajp1HEetExEyd7yhkFv7PwEEjfoaI3H+PKBnw1Xa9AjMgt+J1TsKbl8ntE8xk1LuPYRiMMVv4gKYwN7QjAunDmHfs3eMEfwvZ9SoBZn5whk9ncXQFfSO0ol2QwWZsz12mqAlzDBA0ltLU+UnnFF68VI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RjLY7Yck87sKyFhR3wgSOcGKH+7XGuxsF/RwpG4yeQ=;
 b=Q0UyNvse3O5IK2nzG3fE2et2AwN7UJThYgkEONVlxFYEZAtWYRecdswG2A7zON0aTgTx2pfXz4d5lIs734UM+A987AnVXZUaiKOwBYIjr+2vH7FMf8Fb5vuG3Sl7CkTD2mARctoOKWry1AQnRJxUVovEWPbxGkuRfgEI65miG9WgukJVbG4V6DMyUUr37pi+TDWKb59+cr76HD8+m0rbNlBu7UaSFFU3C6LTxwum7WQRr/k8Hw+gc6myaLh2EUDZFNH1eo83BG2ldZCRaLDCKhKYH/8UdOPQ1/KD0IrdCKTidrpeLwvM54lap9O4l8iCguU+kexXLqbxIulAhm/6Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 17:57:54 +0000
Received: from SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d]) by SJ2PR12MB9212.namprd12.prod.outlook.com
 ([fe80::af42:fef1:1367:7d1d%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 17:57:54 +0000
Message-ID: <c7db1005-ef22-4e54-a09d-474d6cee77b6@nvidia.com>
Date: Wed, 29 Apr 2026 20:57:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: 23.11.7 patches review and test
To: Shani Peretz <shperetz@nvidia.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 benjamin.walker@intel.com, David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 qian.q.xu@intel.com, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 yuan.peng@intel.com, zhaoyan.chen@intel.com
References: <20260421064637.2506152-1-shperetz@nvidia.com>
Content-Language: en-US
From: Ali Alnubani <alialnu@nvidia.com>
In-Reply-To: <20260421064637.2506152-1-shperetz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To SJ2PR12MB9212.namprd12.prod.outlook.com
 (2603:10b6:a03:563::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9212:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bebb800-51ad-4b2a-0213-08dea618d68d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: sp9VRIanUwCkIkZXSk9oPi1CuvLBr+lsZsRavxT+J0jkPekviT+IFYy+KNvBZRWGlP7ILWEhDihz5GCqJqLiRZNgSkMLcWKM5PL5mWHRlJRywfZFVGl/dJiR4HzsK2z43EIpYxm5Ox7oJ647I66GtaHr+1TCGP3ExcqqKQ60Wy2aonbUyv3Hy3ty6h+q/eKGZfaKJ4KIHo5rkq9WYPJaXVnNgVP0VbCt1A4Ae9IW8G+8n3H7iMeBvd4tM3gzFhyGfYNP863bkwO1+GTrsQvDjKxzz3HuLRRnGpAEHDJoUB9kNL9hrJ6ckkro07/F6ceEYiSa9ih1arua3sOqsxMSbcvbotbGO8jQEr1lHToAIZWArsrWKySm4uLVDts5/scpCGBnCqpcvIFA4XQ4QZaPLMxZfa78u8JWAgNVxvIEHESrifrXmHMNV53u6uXiGO0nQrUulJBZDNl1nuqLz5wObZuJYWxpaWUIAm6013x/ToKahWYagF2UmE7sYkKDFXRVjN17qqtcipNRMHMgBEMd8/S61ezWPyNrrSPXDr26VQjdQL8EkzYZSGNA24el4YApZlUmkTH99VsEbTEq4I5oJMLE5DBBMjTJwUsIwkwAT+/Q5jIDomuV2fM0plOgGAbmEVeVFxrkypOuyqahGcy8FnqXhMjX8vOdPKzvQX+aoO2yPZBrc7u8kLJXSPEJ5yNUJwscO6elXYGHnyh/hAQjGjT0Y+qFlDsmKURYUqjnUug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zll1dDJDalhBWVRpYk5MTlRrS3Q1djFoZDMycjhsbDhkSFRLcEtKSitFU2Na?=
 =?utf-8?B?OHZPZzZ5Vk4vSzZxaFRoQU5nQ0szVWZuZnJuOEVEWHhDdHl2d2J5ZUNua2ds?=
 =?utf-8?B?K2VMOGFxN0E2WHp3czdJZitodTJDdExrUG5RSzBVWHZGUlpxRXV3VTBDcG1l?=
 =?utf-8?B?TmFJZTZxNTYrMmpCWVdYSGdja2daMTdBa2RlbFRKRDZpZE1idzBSWHJ4NDdk?=
 =?utf-8?B?NGpMblZQcjZyc1RUdXhMNEl5T2FQa29aaVJEbW15K0d5NXN4VHFlMExwSUdE?=
 =?utf-8?B?b0lHZG1CV0pqQUxqTUxROFo4dDgvNUxQaDlmY0Y5aGZWZGFobWNrQjR6ekY5?=
 =?utf-8?B?V1NjRWNvb3Bkd2x1eFJVMDloQmNiVzAwRnRIYzJGck8rQTJyMDRsQTJOV3Rl?=
 =?utf-8?B?RXhhZSt6MCtlOWhxcERGeWpIZGZrZkpOMkZ5WC9UUUJQWnRNaFZhUjJwQi9j?=
 =?utf-8?B?U3pPQkxDS0JOc1lvV1ZTcEJMcnBTUmF4bFB2ams2Q01Ta0UzSFpjYzBnV1RO?=
 =?utf-8?B?Tk8ycTFaWEFVcWxIOWpXQzVDU1d1U1ZRSlhzbnFWbUpxek9XeEd2UlFZR2RD?=
 =?utf-8?B?aFEzV1hjWElRYXlPTHJjVkFKdE5CbE16UEoyZ3ROZWpQazUwbmpFYjkrQkk2?=
 =?utf-8?B?YjdhaUdYSmU0bnM5aTI4TlNmZlBZWXp6dWFPN0s5UXBhdWFjUE1kYTVyZkY3?=
 =?utf-8?B?M0Y0SlBlUWYvaWtGZThwSUQyMC9SeTlBQlpLY0J4YVdTWTJ2OWxQMzh6ZVNV?=
 =?utf-8?B?VXVWOG1kcXBPVWdwcXJzVjVaTkpsQ1puaTU3aVZzNWhETXlsOGJ6R0VsQUVP?=
 =?utf-8?B?cGJhVzROOERla2F2a2o2TVI3eGRORHZ5azQyVTYzWVo3UHdBcjFsS0tHdnhY?=
 =?utf-8?B?YU1FVk91NFRZR0FsVUhGa1dyRlI1NVBNQnRoNzhueElJb2FQdE8zRHNBS3Bz?=
 =?utf-8?B?bkVFVS9GaUtpak94ck9VbXpYam1nZVVmNmFvb29YUXpTSStwYW4wQ20vUFFZ?=
 =?utf-8?B?ZkpoZUZiV0ZGT0pEQ09BYS81Q3duOGlsbmN1M0oyTi9uU3dsZWQ0cmZROHFF?=
 =?utf-8?B?UnVpZzR6TGJ3Qmt1VDVBYTBOWFpBSERlbjVvekVPV1lPa1dDcjFHNVNxWFIz?=
 =?utf-8?B?aUJBeUE0ZU1Tc095TENObmZFWFBGRzZsZzB0QWtXSGt2NUxHT1MrSVA3OGIw?=
 =?utf-8?B?bnUwL1VEci9uZmVxelhRckJjRThtbGIxcVNnWFZLdzNMOVJBYnQwYk9xUzBm?=
 =?utf-8?B?bVNaWXVqWDdrRU9tSDNBSzJiKzBSQlY4NkN2cHNMaWRWM0g3YkRqU2RTRFly?=
 =?utf-8?B?c3VRdEJCSE9tQUZaQW9BeFNhNjN1VGZBYkdOcWg5S2hyRzVOVWFZZlhhd2Q2?=
 =?utf-8?B?aC8wQXRGc2ZoMFJwdGd5VlR2UVlicnVHWnpWN3VBS01JY09mWkNlZWpIZG95?=
 =?utf-8?B?ZDI0bEY5bHVGWEc4YWVVMERNaEk3UzhHZkdqMEhaQU14ZFpkakszVlMybTVv?=
 =?utf-8?B?N0xyU1J0eXdDQURDMWRaaXZYZ3J4djRGSFdJOHpHcG9BL2JBZmhoVjFqK1dY?=
 =?utf-8?B?c0tGdzhQb3FpaXZFbEtodW44aTRwaDRkNHdRY3lqczFXUW5ldEVudjNQa2xx?=
 =?utf-8?B?OGdCTWoyWFA2OWlqYXd1SjRtSlZsQzVnN0VjdVJkaUt3cmhIVXp0R0laRUJB?=
 =?utf-8?B?NnZVRXR4RHd0UHZpU200TEREZHQxM3c2cENwR1Z1UENYMmYwaGY2dVNtZTJM?=
 =?utf-8?B?eDF1VWhKUWQ1NUk1MWtxL3gzR3dJQmNqQTZGczNqN1M0OEwwWnNmdyt1eVQ3?=
 =?utf-8?B?TXJlMDRFK294T0RKVHlKRGdXb0JlMHo5enQ2bHZmME1lZkJUaFZNM05IZEx5?=
 =?utf-8?B?MThVWG1ZK2dCQmVYVFQ1ZDJpT200bXpOVzdiWVVwZzcrMnVGSkZIaVhoc0JT?=
 =?utf-8?B?UkpsdDcyMTN5ZkdUTGpjOXM0ckxpQ28vRlprVHd6Ym9DNWMrdnhPSStlenJJ?=
 =?utf-8?B?Wko2c2h6QktadGdVOVF6MC83SWdmN1Q1NjhJMmlOM2xaOEpEWFdSakYzam5x?=
 =?utf-8?B?QTd0UkxDRklaNUFUaDJFSER4b3FSODFWbi9SMUNZbzNWTDFwN3BZdlJmSHZF?=
 =?utf-8?B?MTJQdkIzQ3k3MUdlMjBFMzJOZ0txbk1VREEzV1VEWFhidlpZT0swcDdOZFVi?=
 =?utf-8?B?R3VwcVQzaUtuMkRlTUM5enkvU1B2QktsdjlYS2puQUYzUUgvS20xSVFsdWJu?=
 =?utf-8?B?UktyU0d6WEhsQkhlcjBtWVRWbks3c2YvVXdYMWZibEkvUkJ5TE44Y1Q3dkd4?=
 =?utf-8?B?MFR6T1VpanVJYjRwMHVKaEtpVFVHYWdTVlk5MXJkanRzbEpDTkZiQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bebb800-51ad-4b2a-0213-08dea618d68d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 17:57:54.4871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jycFYkumkPi9dnoA/BjSCOG5HIE3agA3olS/emdNDiT0PsG4X0DjJ8qz7gsjIXZ/v9pyNTHuVYhERiojItUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
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

On 4/21/26 9:46 AM, Shani Peretz wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.7.
>
> The planned date for the final release is 30 April 2026.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v23.11.7-rc1
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Shani
>
> ---
Hello,

We ran the following functional tests with Nvidia hardware on v23.11.7-rc1:
- Basic functionality:
   Send and receive multiple types of traffic.
- testpmd xstats counter test.
- testpmd timestamp test.
- Changing/checking link status through testpmd.
- rte_flow tests (See https://doc.dpdk.org/guides/nics/mlx5.html for 
supported features)
- RSS tests.
- VLAN filtering, stripping, and insertion tests.
- Checksum and TSO tests.
- ptype tests.
- link_status_interrupt example application tests.
- l3fwd-power example application tests.
- Multi-process example applications tests.
- Hardware LRO tests.
- Buffer Split tests.
- Tx scheduling tests.

Testing environments:
- NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-23.10-6.1.6.1 / Firmware: 22.39.5124
- NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: 
MLNX_OFED_LINUX-23.10-6.1.6.1 / Firmware: 28.39.5124
- DPU: BlueField-2 / DOCA SW version: 2.5.5 / Firmware: 24.39.5124

We don't see new issues caused by the changes in this release.

Thanks,
Ali
