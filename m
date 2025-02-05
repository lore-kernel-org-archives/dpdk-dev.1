Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0EAC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 20:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1013D402B3;
	Wed,  5 Feb 2025 21:16:57 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by mails.dpdk.org (Postfix) with ESMTP id 8520D40290
 for <dev@dpdk.org>; Wed,  5 Feb 2025 21:16:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrASEcF34cDzNUpQ1lTW6RZseDv0UvRFNRV/rPvMKmRjz8kjibrriT3T9e/G5RlAX77mrLdEUGROH9JyKz3KtD2EiDwrNz+Otax2X5PdsEaIZq8kPD9oLl/56O4g1PoW6mhi34OFbsGbOQkN7uv4sbEJglXKrU4jUgYA3m8ZuZDOBwh43F6xw/R2qZZSwTi3JyzRZmk6muXtSPjdpFosNyrzeoaTE+WQdJvg7V2nU611SeAGFw4LAXOWEaOUHkrqx/c0aNqd28HiGGDboFe9yzp/TlQY6jAZXx/J/iLIKuSHwFADFxSdSZpuyrSvXBDTEhIc5IZMCFkFsF0WQcp9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3OATVkNBe/5su0p7+WiTXaADduvYv1u4FXLHY+k0og=;
 b=sVXGgNYIWr/pshxiZ9tXv9MRuM6N00U8nqPghha2cA+rLI/uMtojRNPk7qfKHfPSnf/anhJ1cTMcVHbvCwk2xnmWnFIlm7kPbygl25kidUNxkLqN4vGPmBhmn57Q1uKrMvsUQZ1nE4xMtsCcTYKnHENP3BkmaKVYE0mZ1iNtw7S+lSfDPIBhrekZAS7eIzQLEupa48ToALuY4GbY8HyVOfJQxVQq73SYY0I+707cmRKBt1XIzuL66EIu1YfvZECv7vZfM++8eHOWUgB8j96k3LYmNq3Rk8IqtMiYVj4H+Pd1Iuhh/1tSRLvMqFnInzoAVcuRbQClaY8Yzz/VP48Mfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3OATVkNBe/5su0p7+WiTXaADduvYv1u4FXLHY+k0og=;
 b=Yc0JFLTjJKGbYBR8aw7R6kYL4iL4yXgC7QCXI8LxnwjlqjIm9YqvnULeE0cy7/pVNpuK1sBueIYnLhzubD1Iwgr6SKtoDm4btRgZ65nJ1jkhrF3rbw7e6LEYzjHT4q3x6DNWnKebw0a9FhY0O63qyhfhagTzezWjTJa5gZ3PPzFQrP6K3mwsigS4vI1+6jitbW8qqQNPQxi1Qgpm3GsRnXYF9x33AesRsd8vlOLdZ1gE17m9VBcD6iy65t4cTweB4NpZtxLLPdgjM5LCcL0GnkdKXDFVs6osfMumcp+sWY9F2NFF5bRnAPX2evdl+cRk0/vYmeWMs0pkLK/cMXM5wQ==
Received: from SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 20:16:48 +0000
Received: from SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784]) by SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784%7]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 20:16:48 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Tyler Retzlaff <roretzla@linux.microsoft.com>, Parav
 Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Hemant
 Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@intel.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz
 Duszynski <tduszynski@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>,
 "NBU-Contact-longli (EXTERNAL)" <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Bruce Richardson <bruce.richardson@intel.com>, Kevin
 Laatz <kevin.laatz@intel.com>, Jan Blunck <jblunck@infradead.org>
Subject: RE: [PATCH v4] bus: fix inconsistent representation of PCI numbers
Thread-Topic: [PATCH v4] bus: fix inconsistent representation of PCI numbers
Thread-Index: AQHbcitqrFX8S5R050u+BzY3Knp28rMt8G0AgAsCg8CAAAJ8AIAADxkwgAATigCAAAHKoA==
Date: Wed, 5 Feb 2025 20:16:48 +0000
Message-ID: <SA1PR12MB9491CD983750DF0D7A15E453BFF72@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20240708165145.1405107-1-shperetz@nvidia.com>
 <20250129085416.226718-1-shperetz@nvidia.com>
 <20250129082518.47630942@hermes.local>
 <SA1PR12MB94915F840D6A2D631AA02E1ABFF72@SA1PR12MB9491.namprd12.prod.outlook.com>
 <20250205084202.264d9781@hermes.local>
 <SA1PR12MB9491A6FDB9AD2FC28CC5A0BEBFF72@SA1PR12MB9491.namprd12.prod.outlook.com>
 <20250205104600.3bf2afdc@hermes.local>
In-Reply-To: <20250205104600.3bf2afdc@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9491:EE_|LV2PR12MB5992:EE_
x-ms-office365-filtering-correlation-id: 7cc25325-5f6f-4623-e7d9-08dd46220508
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?b1UzdHlmbk5udWpPaUdydVVKaFh4alhSMWtGNldUejczZ3h3aEk1OTY5MTdW?=
 =?utf-8?B?YWVkTTBYZG5tQU1QbDN3S1QyK3RqRXFJZXFaUHo0cUJiZkFZOWZ3NzRBcmlE?=
 =?utf-8?B?YmRua1NxNWdpd1R4aHd0Vys0aUVyTWFHemxlNDBqV2s5aVQxbFZLVWl2Nkd4?=
 =?utf-8?B?VnNRR05wcC9FNVVSYjBLOURXNldnaVRPa1kzeUZEQ0pQYXZsT1lLQUZlN2VD?=
 =?utf-8?B?ajRsd3JQd1lacGlSNzREUG8yQ3VEVSs2ZUtWUkZoN3JONElZZlNPRlFPNTUw?=
 =?utf-8?B?bzRNZlhQSkRZVmh0N080S0EzOHhaY3R2MFVTOEdkdzFrTUxNa2cwSTRiRk9Z?=
 =?utf-8?B?TkZWL01vRU45YkhGdDNUTU9MYlVpQmY0RndWQXVXS2lhSThpa2N2ZGpwSnJW?=
 =?utf-8?B?di9wRVdaQmZKSGpkNWJ0bzlERTlXc1A0ekhGbVhyTGNlRkE5aklwcVRnZVN3?=
 =?utf-8?B?QzBma2k5T1VBc3ZQeWkwbzN6L2ljOTZVYUZZODFndHRuM3JYbDRRQzBUZTlJ?=
 =?utf-8?B?RC9QWTh5OWJ4bWU5VmkzeUR6S0ZvaXphQ1JWL3pYTWE5VHhQQXRKN0hzM04z?=
 =?utf-8?B?UU0wMGV3SlV5cVB1RlBqbTBUZ1BvZjRSeU03TUx1SzBGSUZiVWlhZlpGbjI3?=
 =?utf-8?B?cW5FT2lxWEpuT2M5RFVWZFFvai9KMENrOGlSMzlDS3dqSkZFRlFRL1pPb2k2?=
 =?utf-8?B?UXdhcDhLSGFBWTdHaUIzVmlad05ORmpzSkFmNVQ0cytwMk1ydkZ4alVMS1pD?=
 =?utf-8?B?Nm1ySVZ5eEdaRkpZbG1FdEQ2bEx4NjU4cnAvanpvbXNZZnlqa1R0WGd6RGJB?=
 =?utf-8?B?c3gwbzluWktaaVpVSWtGR3NlcWFVWjhmRVpIVVpzL29yUzVMeG43MmdjNW1B?=
 =?utf-8?B?OW1NRWJOeWJUMjNxbjhKeEdSZ2JNL0pWWlY2c2dQZjIrdWpjb1BtdUg4cUZ3?=
 =?utf-8?B?SmZ4WTUrMmRjbDlUbDNYNVRKZ2k2d0FzMkNmOTZ1MTNrZnNyOWovYUhFUTVz?=
 =?utf-8?B?WndmR0htSTR2V2NVMFF6Z1lTdE5wL1VKOXJTRTdqN1ZOOEgvVGl5Mmw0Z0JJ?=
 =?utf-8?B?Y1BxRk5ybzh6SEluakpBZmpIemVVS3lCc3lJWC96Z3p5MUtCVmJHUXNHR3Ft?=
 =?utf-8?B?bTdZb1FUR3ZMTEhMODZoYVltYUlzQnV2bVRJSUhMM0ZPN2NXVFRhSUhyV3Na?=
 =?utf-8?B?bEpIaDZZV1ZRQi9vbmRoRW5TMDIwU3Vyb01ZbUF4U1lVa1pDL1BGRS9zd21E?=
 =?utf-8?B?cVFkMlVxdjBzVktmYWxwV1Z4a1NGYTNCZlF2dEhHVGo1RER5STl1aTNQTXBh?=
 =?utf-8?B?TFJWSXcvdDFzQklJS0thZmZ2SUI1RDh6Y21Tb2w0RW5CM3IvSmRSNExxcUoz?=
 =?utf-8?B?dlY4dEJ3bzQrWWNKOHlSeXhOSEJ0cTNZRGxvMzVzM1I1SXhMK2M5UmxZVjRF?=
 =?utf-8?B?L0NtNnlKRU85cXhhakg1b0ZZWXd1N1JMcWlLTFREUTl2YkhqVGd6U2kva01K?=
 =?utf-8?B?Nzd1T0g1ZXlBU2VCbnl5aFVyaityanllUEd6aWFhS2NXaE43dkgxQ3QxajdB?=
 =?utf-8?B?MFM4NHFQb1lBSUN2eUsybTEvVDRjQW91bzVyOEdZdHJDMmwwdVFESVFlcDBy?=
 =?utf-8?B?YnV5V3lNUkt2M1o1MzY2YW9Wdjg1d2pzK0NqN0U3Z1RKc001ZnIvdHdNVnV6?=
 =?utf-8?B?cDVkV3dCQzFVSzVacDZGVFRQNVZzUDR5Zk1FSlpWY0tqbk96ZHByRXA4RXBS?=
 =?utf-8?B?UmdrM1orbldIem9WRnRkek5xZUEwMG1lUHVVaGxFS0l0N0t6enBTOG5XRC9X?=
 =?utf-8?B?WGk1NHBJWWFWZ0VNOHR6eVFKb0hmbGhoUUlGVXFpdDJIL2gxQmFESk5JbWlj?=
 =?utf-8?B?NDdMN1ZkVEJRUXlEVk5BYmM2THRjU29DUS80RjZoQjBNNmtoaERoTjVvRHVY?=
 =?utf-8?Q?h2vsQEDobqSo2Zf0AlVqHMqRR/HgGkRB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFR2SjhJQUxOVXBDSm9BNnBsSzg2WmowVmYzY0d4ZTNZZy9mV0RQSkhYNzJn?=
 =?utf-8?B?Yjl4TWVML0N1Sm5EODNBa1BtVGU0N2t6NTFtQUo3TkdlYmYzN0RMNG9pNnFG?=
 =?utf-8?B?Slp1eHllZGh2OUR0REp6bzYxSUdTbzBzNG1sRU0rVDlVZXpoNi9yMFpVSUEv?=
 =?utf-8?B?a1RiVU1oSUxUYWpVOFFkVXgxVHdsUHNTa0hIK3dHNVQxeS9ldFpFWDF4dzYr?=
 =?utf-8?B?L3pncGZiSzhXdVdobTVsNG9LVDVIeTBrMlRBNDVPVEJIT0JUN1I3WnhYY1pU?=
 =?utf-8?B?R2ZBdkJkbDBXRDVvRU0zZ1dJaTRIN0J3Ym5EejJLM0ZzM01pTXhHWmVORDND?=
 =?utf-8?B?TUhaenMyd1hLeHRtdVg5TFJCcWdsT09IaVcrTE9ZQk43SVNoZ0Vpck0yYVhX?=
 =?utf-8?B?c3BjaHAvOHk4V2lIZXZkSnVyMFgyeGc0NFBZengzM3lqZGJkMDEzRi9pdXdW?=
 =?utf-8?B?OEI2S1lNbU45aVVNc3gzdHZkazA3cWxNemwvbW5lbU0yTVNaaEhhcGw5aXJF?=
 =?utf-8?B?b2tsZ0FtdW1OcFNMek5mMGduaDVCS2NaNWxtM2ovN3BDVTRnUU81dG1oSk96?=
 =?utf-8?B?a3dvU2dGUGpyczZGYUxiN0ljSmtwdW9Deld2OWo4bnF2c2lTVk1oaHlYWjZj?=
 =?utf-8?B?RWtLajEvaEtsQ1JCU0d3YmZNTmxVNnVkb1lrLzh2Um1JUGRaQ0lWTWZvUFpi?=
 =?utf-8?B?M3NJeUFyaER6UTQxbHRwaGNWWEw5TS9sL2RnRG1qODRwMFpnQzhKckh2dW5B?=
 =?utf-8?B?QjZXQ1JHMjBjMzdGUmlXc2UvbWpNUGtBN0xPNWJxaEZwUHFyNERjTTR3bVFl?=
 =?utf-8?B?c01QcXZUU0lGdVBlRXZDR3ZuUlRoTTlnZWlOVllXK3ZNMVM5RXhJMGtrSDRa?=
 =?utf-8?B?RXovOTI3RERVcVJpTVBXL1YzdC8rcVdKRFg1Vk9DZVdPVHYzWSs1NzJtR0pH?=
 =?utf-8?B?RTZFTG1zT2krcUMraTUybzZZcEkwakRmcWp1YXc2Q3ZqT0dleXl5REx0czlF?=
 =?utf-8?B?MWg0Znp2cm8weExIcUlEcTYzTkpvLytqYmY3MWRVbU5EcDBSZ25uNkJNNUR5?=
 =?utf-8?B?Wjg5Rk9JMFB3QlV3NkJZbk1rSGVBM2QwUkJjUmlkSHJydmRBRmxUcE9RRUY1?=
 =?utf-8?B?SFZWeDE1aGh1dUIwclJlLzROalRxd1FNSGJJMGtDMkJoQS9NYVJFN0F6ekVQ?=
 =?utf-8?B?bkdtZ1hWOGhpVnczT3BpU2xkajhkdGZMOXhCeUdFdEpGZmVKNDRHL0NhTktn?=
 =?utf-8?B?cUlaL0lNN3M5NGpjTzUwcnZWVGRjbWpCV2FqaFB0V3lzdzU1M1p2RmNLNXp1?=
 =?utf-8?B?N0U4WnJuR1duSnRrWk9MZytqMDhDelYzcVUybWZLdExFZDZia01kaERCemFX?=
 =?utf-8?B?Y2JtckdnSXJnbGkzTzhvbFUvTXZKMU5xcy9RMFJxYkx0QVgxcnJhbENRa1Rx?=
 =?utf-8?B?VC9RWGVDTVRVeGlIZUFVNGszRU5lckxKVWMvNzVObDN2MXhHbHoybEU3ekVy?=
 =?utf-8?B?Yk1LVHppaXpoOWd0VFFTZDVIU2MrdUh0eDhwZjBrZ1ZRRDRRemg2Y1JLeU02?=
 =?utf-8?B?UkR5a2llYi82RG5ZbGRGb0JTWDZxaUc3RmhCT1FBYlZIWHBWdzhmMld6U3gr?=
 =?utf-8?B?MFN4b3Zkam1XTWNtb1hmeG1BZ0lUMS9YcGwrK2paVTJteUpOR0JCL0RjakRG?=
 =?utf-8?B?R3ZyK0JSL29BUEZvNUhOSTdscG96QzNldENCS0hmSU5qVlk2eEtrWXA3dTU4?=
 =?utf-8?B?K0F6SWJIclNtcDFXYlNGdDhmYnM3K0VVTU0wRHcyS1BCS1oyMll4NGMyZWg2?=
 =?utf-8?B?WHdnKzdrWTNOM2lFbXlNbERJUFp1bGpnWUpMRndPcVgxQWVTWWZadTFmZ0J0?=
 =?utf-8?B?Si9CN29YVE1yT0hkMmIxTVFRR1UzQ3FSRzk4RitvOHVWNHdveHkrcmRmQjRx?=
 =?utf-8?B?ZFRGVGlvenhwdXAxSWIrelZYU29nRFJBRGxRbVo2SUdWWWc2dTk2ZWZyUnVt?=
 =?utf-8?B?ZXEzSjRhSmwzdjVrT0JtOVZ1MXZRQWozOUNlUVQ1UUdLaXVvNVlPampqckkw?=
 =?utf-8?B?YVFsN3EyUVVPMUJ2V01xNXdwU0Vuc3lTSm5pcFpPbnQyRkhJZ3UvOFhWUUZB?=
 =?utf-8?Q?CiLYcwiH4VxgKOD0X5JWSDOMT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc25325-5f6f-4623-e7d9-08dd46220508
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 20:16:48.3410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3EfvuZ2ajsFX0iyWawvE7S5vzuwJti/+qlxWnJt7KrazuUf3Yipr4AdSLsI0ZRdftmpw2bFJFd3ruemmM7Gog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIDUgRmVi
cnVhcnkgMjAyNSAyMDo0Ng0KPiBUbzogU2hhbmkgUGVyZXR6IDxzaHBlcmV0ekBudmlkaWEuY29t
Pg0KPiBDYzogZGV2QGRwZGsub3JnOyBOQlUtQ29udGFjdC1UaG9tYXMgTW9uamFsb24gKEVYVEVS
TkFMKQ0KPiA8dGhvbWFzQG1vbmphbG9uLm5ldD47IFR5bGVyIFJldHpsYWZmIDxyb3JldHpsYUBs
aW51eC5taWNyb3NvZnQuY29tPjsgUGFyYXYNCj4gUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPjsg
WHVlbWluZyBMaSA8eHVlbWluZ2xAbnZpZGlhLmNvbT47IE5pcHVuIEd1cHRhDQo+IDxuaXB1bi5n
dXB0YUBhbWQuY29tPjsgTmlraGlsIEFnYXJ3YWwgPG5pa2hpbC5hZ2Fyd2FsQGFtZC5jb20+OyBI
ZW1hbnQNCj4gQWdyYXdhbCA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT47IFNhY2hpbiBTYXhlbmEN
Cj4gPHNhY2hpbi5zYXhlbmFAbnhwLmNvbT47IFJvc2VuIFh1IDxyb3Nlbi54dUBpbnRlbC5jb20+
OyBDaGVuYm8gWGlhDQo+IDxjaGVuYm94QG52aWRpYS5jb20+OyBUb21hc3ogRHVzenluc2tpIDx0
ZHVzenluc2tpQG1hcnZlbGwuY29tPjsNCj4gQ2hlbmd3ZW4gRmVuZyA8ZmVuZ2NoZW5nd2VuQGh1
YXdlaS5jb20+OyBOQlUtQ29udGFjdC1sb25nbGkNCj4gKEVYVEVSTkFMKSA8bG9uZ2xpQG1pY3Jv
c29mdC5jb20+OyBXZWkgSHUgPHdlaEBtaWNyb3NvZnQuY29tPjsgQnJ1Y2UNCj4gUmljaGFyZHNv
biA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+OyBLZXZpbiBMYWF0eg0KPiA8a2V2aW4ubGFh
dHpAaW50ZWwuY29tPjsgSmFuIEJsdW5jayA8amJsdW5ja0BpbmZyYWRlYWQub3JnPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0XSBidXM6IGZpeCBpbmNvbnNpc3RlbnQgcmVwcmVzZW50YXRpb24g
b2YgUENJIG51bWJlcnMNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5n
IGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gV2VkLCA1IEZlYiAyMDI1IDE3OjM3
OjU0ICswMDAwDQo+IFNoYW5pIFBlcmV0eiA8c2hwZXJldHpAbnZpZGlhLmNvbT4gd3JvdGU6DQo+
IA0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFN0ZXBoZW4g
SGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gPiA+IFNlbnQ6IFdlZG5l
c2RheSwgNSBGZWJydWFyeSAyMDI1IDE4OjQyDQo+ID4gPiBUbzogU2hhbmkgUGVyZXR6IDxzaHBl
cmV0ekBudmlkaWEuY29tPg0KPiA+ID4gQ2M6IGRldkBkcGRrLm9yZzsgTkJVLUNvbnRhY3QtVGhv
bWFzIE1vbmphbG9uIChFWFRFUk5BTCkNCj4gPiA+IDx0aG9tYXNAbW9uamFsb24ubmV0PjsgVHls
ZXIgUmV0emxhZmYNCj4gPiA+IDxyb3JldHpsYUBsaW51eC5taWNyb3NvZnQuY29tPjsgUGFyYXYg
UGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPjsNCj4gPiA+IFh1ZW1pbmcgTGkgPHh1ZW1pbmdsQG52
aWRpYS5jb20+OyBOaXB1biBHdXB0YQ0KPiA8bmlwdW4uZ3VwdGFAYW1kLmNvbT47DQo+ID4gPiBO
aWtoaWwgQWdhcndhbCA8bmlraGlsLmFnYXJ3YWxAYW1kLmNvbT47IEhlbWFudCBBZ3Jhd2FsDQo+
ID4gPiA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT47IFNhY2hpbiBTYXhlbmEgPHNhY2hpbi5zYXhl
bmFAbnhwLmNvbT47DQo+ID4gPiBSb3NlbiBYdSA8cm9zZW4ueHVAaW50ZWwuY29tPjsgQ2hlbmJv
IFhpYSA8Y2hlbmJveEBudmlkaWEuY29tPjsNCj4gPiA+IFRvbWFzeiBEdXN6eW5za2kgPHRkdXN6
eW5za2lAbWFydmVsbC5jb20+OyBDaGVuZ3dlbiBGZW5nDQo+ID4gPiA8ZmVuZ2NoZW5nd2VuQGh1
YXdlaS5jb20+OyBOQlUtQ29udGFjdC1sb25nbGkNCj4gPiA+IChFWFRFUk5BTCkgPGxvbmdsaUBt
aWNyb3NvZnQuY29tPjsgV2VpIEh1IDx3ZWhAbWljcm9zb2Z0LmNvbT47IEJydWNlDQo+ID4gPiBS
aWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT47IEtldmluIExhYXR6DQo+ID4g
PiA8a2V2aW4ubGFhdHpAaW50ZWwuY29tPjsgSmFuIEJsdW5jayA8amJsdW5ja0BpbmZyYWRlYWQu
b3JnPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NF0gYnVzOiBmaXggaW5jb25zaXN0ZW50
IHJlcHJlc2VudGF0aW9uIG9mIFBDSQ0KPiA+ID4gbnVtYmVycw0KPiA+ID4NCj4gPiA+IEV4dGVy
bmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+ID4g
Pg0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgNSBGZWIgMjAyNSAxNjozNjoxMSArMDAwMA0KPiA+ID4g
U2hhbmkgUGVyZXR6IDxzaHBlcmV0ekBudmlkaWEuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBTdGVwaGVuIEhl
bW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+ID4gPiA+ID4gU2VudDogV2Vk
bmVzZGF5LCAyOSBKYW51YXJ5IDIwMjUgMTg6MjUNCj4gPiA+ID4gPiBUbzogU2hhbmkgUGVyZXR6
IDxzaHBlcmV0ekBudmlkaWEuY29tPg0KPiA+ID4gPiA+IENjOiBkZXZAZHBkay5vcmc7IE5CVS1D
b250YWN0LVRob21hcyBNb25qYWxvbiAoRVhURVJOQUwpDQo+ID4gPiA+ID4gPHRob21hc0Btb25q
YWxvbi5uZXQ+OyBUeWxlciBSZXR6bGFmZg0KPiA+ID4gPiA+IDxyb3JldHpsYUBsaW51eC5taWNy
b3NvZnQuY29tPjsgUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPjsNCj4gPiA+ID4gPiBY
dWVtaW5nIExpIDx4dWVtaW5nbEBudmlkaWEuY29tPjsgTmlwdW4gR3VwdGENCj4gPiA+IDxuaXB1
bi5ndXB0YUBhbWQuY29tPjsNCj4gPiA+ID4gPiBOaWtoaWwgQWdhcndhbCA8bmlraGlsLmFnYXJ3
YWxAYW1kLmNvbT47IEhlbWFudCBBZ3Jhd2FsDQo+ID4gPiA+ID4gPGhlbWFudC5hZ3Jhd2FsQG54
cC5jb20+OyBTYWNoaW4gU2F4ZW5hIDxzYWNoaW4uc2F4ZW5hQG54cC5jb20+Ow0KPiA+ID4gPiA+
IFJvc2VuIFh1IDxyb3Nlbi54dUBpbnRlbC5jb20+OyBDaGVuYm8gWGlhIDxjaGVuYm94QG52aWRp
YS5jb20+Ow0KPiA+ID4gPiA+IFRvbWFzeiBEdXN6eW5za2kgPHRkdXN6eW5za2lAbWFydmVsbC5j
b20+OyBDaGVuZ3dlbiBGZW5nDQo+ID4gPiA+ID4gPGZlbmdjaGVuZ3dlbkBodWF3ZWkuY29tPjsg
TkJVLUNvbnRhY3QtbG9uZ2xpDQo+ID4gPiA+ID4gKEVYVEVSTkFMKSA8bG9uZ2xpQG1pY3Jvc29m
dC5jb20+OyBXZWkgSHUgPHdlaEBtaWNyb3NvZnQuY29tPjsNCj4gPiA+ID4gPiBCcnVjZSBSaWNo
YXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT47IEtldmluIExhYXR6DQo+ID4gPiA+
ID4gPGtldmluLmxhYXR6QGludGVsLmNvbT47IEphbiBCbHVuY2sgPGpibHVuY2tAaW5mcmFkZWFk
Lm9yZz4NCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0XSBidXM6IGZpeCBpbmNvbnNp
c3RlbnQgcmVwcmVzZW50YXRpb24gb2YNCj4gPiA+ID4gPiBQQ0kgbnVtYmVycw0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3Ig
YXR0YWNobWVudHMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gV2VkLCAyOSBK
YW4gMjAyNSAxMDo1NDoxNiArMDIwMCBTaGFuaSBQZXJldHoNCj4gPiA+ID4gPiA8c2hwZXJldHpA
bnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICtjcmVhdGVfcGNpX2Rl
dihjb25zdCBjaGFyICpuYW1lKSB7DQo+ID4gPiA+ID4gPiArICAgICBpbnQgcG9ydF9pZDsNCj4g
PiA+ID4gPiA+ICsgICAgIHVpbnQ4X3Qgc2xhdmVfbWFjMVtdID0gezB4MDAsIDB4RkYsIDB4MDAs
IDB4RkYsIDB4MDAsIDB4MDAgfTsNCj4gPiA+ID4gPiA+ICsgICAgIHN0cnVjdCBydGVfZXRoZXJf
YWRkciAqbWFjX2FkZHIgPSAoc3RydWN0IHJ0ZV9ldGhlcl9hZGRyDQo+ID4gPiA+ID4gPiArKilz
bGF2ZV9tYWMxOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVXNlIGRpZmZlcmVudCBpbml0aWFsaXpl
ciBhbmQgeW91IGNhbiBhdm9pZCB0aGUgbmVlZCBmb3IgY2FzdCBoZXJlLg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArLyoqDQo+ID4gPiA+ID4gPiArICog
R2VuZXJhbCBkZXZpY2UgbmFtZSBjb21wYXJpc29uLiBXaWxsIGNvbXBhcmUgYnkgdXNpbmcgdGhl
DQo+ID4gPiA+ID4gPiArc3BlY2lmaWMgYnVzDQo+ID4gPiA+ID4gPiArICogY29tcGFyZSBmdW5j
dGlvbiBvciBieSBjb21wYXJpbmcgdGhlIG5hbWVzIGRpcmVjdGx5Lg0KPiA+ID4gPiA+ID4gKyAq
DQo+ID4gPiA+ID4gPiArICogQHBhcmFtIGRldg0KPiA+ID4gPiA+ID4gKyAqICAgRGV2aWNlIGhh
bmRsZS4NCj4gPiA+ID4gPiA+ICsgKiBAcGFyYW0gbmFtZQ0KPiA+ID4gPiA+ID4gKyAqICAgTmFt
ZSB0byBjb21wYXJlIGFnYWluc3QuDQo+ID4gPiA+ID4gPiArICogQHJldHVybg0KPiA+ID4gPiA+
ID4gKyAqICAgMCBpZiB0aGUgZGV2aWNlIG1hdGNoZXMgdGhlIG5hbWUuIE5vbnplcm8gb3RoZXJ3
aXNlLg0KPiA+ID4gPiA+ID4gKyAqLw0KPiA+ID4gPiA+ID4gK19fcnRlX2ludGVybmFsDQo+ID4g
PiA+ID4gPiAraW50IHJ0ZV9jbXBfZGV2X25hbWUoY29uc3Qgc3RydWN0IHJ0ZV9kZXZpY2UgKmRl
diwgY29uc3Qgdm9pZA0KPiA+ID4gPiA+ID4gKypuYW1lKTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IEl0IHdvdWxkIG1ha2UgbW9yZSBzZW5zZSB0byBtZSBpZiBuYW1lIHdhcyBhIGNoYXJhY3RlciBu
b3Qgdm9pZA0KPiBwb2ludGVyLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIGRlc2lnbiBtaWdo
dCBiZSBjbGVhcmVyIGlmIGJ1cyBhZGRyZXNzIHdhcyBtb3JlIG9mIGFuDQo+ID4gPiA+ID4gdHlw
ZWRlZiB3aXRoIGEgcG9pbnRlciBhbmQgc2l6ZSB0b2dldGhlci4gVHJlYXQgaXQgbW9yZSBsaWtl
IGFuIG9iamVjdC4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gT2theSBzbyBqdXN0IHRvIHVu
ZGVyc3RhbmQsDQo+ID4gPiA+IHRoaXMgaXMgdGhlIHN0cnVjdCBJIGFtIGFkZGluZzoNCj4gPiA+
ID4NCj4gPiA+ID4gICAgICAgc3RydWN0IHJ0ZV9idXNfYWRkcmVzcyB7DQo+ID4gPiA+ICAgICAg
ICAgICAgICBjb25zdCB2b2lkICphZGRyOw0KPiA+ID4gPiAgICAgICAgICAgICAgc2l6ZV90IHNp
emU7DQo+ID4gPiA+ICAgICAgIH07DQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgaXMgaG93IEkgcGFz
cyBpdCB0byBmaW5kX2RldmljZToNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgc3RydWN0IHJ0ZV9i
dXNfYWRkcmVzcyBkZXZfYWRkciA9IHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIC5hZGRyID0g
ZGEtPm5hbWUsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAuc2l6ZSA9IFJURV9ERVZfTkFNRV9N
QVhfTEVODQo+ID4gPiA+ICAgICAgIH07DQo+ID4gPiA+ICAgICAgIGRldiA9IGRhLT5idXMtPmZp
bmRfZGV2aWNlKE5VTEwsIHJ0ZV9jbXBfZGV2X25hbWUsDQo+ID4gPiA+ICZkZXZfYWRkcik7DQo+
ID4gPiA+DQo+ID4gPiA+IEFuZCB0aGlzIGlzIGhvdyBJIHVzZSBpdCBpbiBydGVfY21wX2Rldl9u
YW1lOg0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICBydGVfY21wX2Rldl9uYW1lKGNvbnN0IHN0cnVj
dCBydGVfZGV2aWNlICpkZXYxLCBjb25zdCB2b2lkICphZGRyKQ0KPiA+ID4gPiAgICAgICAgew0K
PiA+ID4gPiAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHJ0ZV9idXNfYWRkcmVzcyAqZGV2Ml9h
ZGRyID0gYWRkcjsNCj4gPiA+ID4gICAgICAg4oCmDQo+ID4gPiA+ICAgICAgIH0NCj4gPiA+ID4N
Cj4gPiA+ID4gSXMgdGhhdCB3aGF0IHlvdSBtZWFudD8NCj4gPiA+ID4gQWxzbywgSSdtIG5vdCBz
dXJlIGlmIHRoZSBzaXplIGlzIHJlYWxseSBuZWVkZWQsIGJlY2F1c2Ugd2UgY2hlY2sNCj4gPiA+
ID4gdGhlIHNpemUgb2YgdGhlIHBhcnNlZCBuYW1lLCB3aGljaCBtYXkgYmUgZGlmZmVyZW50IHRo
YW4gdGhlIHNpemUNCj4gPiA+ID4gb2YgdGhlIG9yaWdpbmFsIG5hbWUNCj4gPiA+ID4NCj4gPiA+
DQo+ID4gPiBJdCB3b3VsZCBiZSBiZXN0IHRvIHBhc3MgcnRlX2J1c19hZGRyZXNzIHRvIHJ0ZV9j
bXBfZGV2X25hbWUgcmF0aGVyDQo+ID4gPiB0aGFuIGhhdmluZyBpbXBsaWVkIGNhc3QuDQo+ID4g
PiBOb3Qgc3VyZSBpZiB0aGF0IGlzIHBvc3NpYmxlIHdpdGhvdXQgYnJlYWtpbmcgQVBJIHRob3Vn
aC4NCj4gPg0KPiA+IEkgdGhpbmsgeW91IGFyZSByaWdodCwgYWxzbyBpdCB3aWxsIHJlcXVpcmUg
dG8gY2hhbmdlIHRoZSBzaWduYXR1cmUgb2YNCj4gPiBmaW5kX2RldmljZSB3aGljaCB3aWxsIG1h
a2UgaXQgZXZlbiBiaWdnZXIgY2hhbmdlDQo+IA0KPiBDb3VsZCB5b3UgcG9zdCBwYXRjaCB3aXRo
IHNvbWV0aGluZyAiZ29vZCBlbm91Z2giIHRoYXQgYnVpbGRzIGFuZCBwYXNzZXMNCj4gdGVzdHM/
DQoNCllvdSBtZWFuIHdpdGggdGhlIHJ0ZV9idXNfYWRkcmVzcyBjaGFuZ2Ugb3Igd2l0aG91dD8N
CldpdGhvdXQgaXQgaXQgd2FzIHRlc3RlZCBhbmQgcGFzc2VkLiBXaXRoIGl0IEkgb25seSByYW4g
ZmV3IHRlc3RzIGxvY2FsbHkgYW5kIHRoZXkgcGFzc2VkDQo=
