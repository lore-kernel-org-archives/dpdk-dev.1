Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CE8CED240
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 03:40:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 999604027D;
	Tue, 18 Nov 2025 04:40:30 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
 by mails.dpdk.org (Postfix) with ESMTP id 6CC764026A;
 Tue, 18 Nov 2025 04:40:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o53qnpWByjHYoAD5JKqkkt8l3tzqyDqf2EK9zfeQu+uGS8Df+BKq/HBGCmfkxS5VvZ65USU6aGC9U78DSVbGFEoKsLPuXvSJIC/Ivl0HFhi6rt/32ecT/27zK/NogssMPJYYBgVPeWF6eynyDJy0AHkAv61nKeVWnh1iWGzoy0EbVs+/s6ubky9Zzu32YKiVsI1piZd0glnFqLelqeVSh9mVM0ew9EpBn40hnwYgQY0AKcC3GXKjwXBPT3KVDjxBz80QL1D4gw3GX0Zk9JH+ajenPbCqZzx0J/OVK76o9I0Gv5tvj9ZIUPO+tgLaBycjRTrkA07N4yyCG6tpuEhVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlk6pWjpp44O1K30VggXxXajUte7L2xx+qFshFXs1P0=;
 b=Ayysi9dEwO1bYNScVzobg/I1nATV4dKXML1/ZZ4RggN91N8PNPMfA/XKdB97kFnCB6YCSnNvSx4/WAc0+EJZdGFmq1OR5d1aLEYdNl368B/AMAiZNgoiCdvV3qkX/Vs5bF7pAVB9Q3f2GVfmBcvgRQfG5aNrDBiKEXnecz85ZChgEYj7lek1UUCpTfafyTJKRR09Br5D1hu9mVmBnQ+hPxX7F90qNmgSztkforCQ3GEsPaBgUmxDkeoYzSk1IZ0iwy5x40hdLKLCNXYzgVzIA576mMZBhKf/R1t13ZMPraGueS+jAcdlEynX2KF8BACIebV+nqFTWTBxub5b6alzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlk6pWjpp44O1K30VggXxXajUte7L2xx+qFshFXs1P0=;
 b=GcpZi/NY069rlgDRyPOciBU9lV0doOwGB7H2lEs05KZ95clCDOoU3ysb1RqhJaD0OTHpKGwqnZhJbLp4sUr4WRfyVwR2oiLCo8v6TFhoNy9UZsPZPvTyezveYKocZzho1C+foBzGjARu6ExJQMCzQ+371dV0oshkIOEqqJPX29g=
Received: from CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 03:40:25 +0000
Received: from CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::278f:5cc5:549c:3515]) by CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::278f:5cc5:549c:3515%7]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 03:40:25 +0000
From: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
To: Alexander Kozyrev <akozyrev@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>
CC: "jerinj@marvell.com" <jerinj@marvell.com>, "kirankumark@marvell.com"
 <kirankumark@marvell.com>, "ndabilpuram@marvell.com"
 <ndabilpuram@marvell.com>, "yanzhirun_163@163.com" <yanzhirun_163@163.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "ktraynor@redhat.com" <ktraynor@redhat.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "konstantin.ananyev@huawei.com"
 <konstantin.ananyev@huawei.com>, "konstantin.v.ananyev@yandex.ru"
 <konstantin.v.ananyev@yandex.ru>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "maxime.coquelin@redhat.com"
 <maxime.coquelin@redhat.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "aconole@redhat.com" <aconole@redhat.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix spurious CPU wakeups caused by invalid CQE
Thread-Topic: [PATCH] net/mlx5: fix spurious CPU wakeups caused by invalid CQE
Thread-Index: AQHcPdlB9K02x4aBhkyabObrZChQDLTnpNwAgAQmlsKAC7PZAIAAfZH4
Date: Tue, 18 Nov 2025 03:40:25 +0000
Message-ID: <CH3PR12MB82333CE7927B231FDCA1B55886D6A@CH3PR12MB8233.namprd12.prod.outlook.com>
References: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
 <20251107175936.4yr2quzngd5gnp2l@ds-vm-debian.local>
 <CH3PR12MB8233444042288DA4196F222A86CEA@CH3PR12MB8233.namprd12.prod.outlook.com>
 <DM4PR12MB75014E5717803AB195001082AFC9A@DM4PR12MB7501.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB75014E5717803AB195001082AFC9A@DM4PR12MB7501.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-18T03:40:24.810Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8233:EE_|SA1PR12MB6704:EE_
x-ms-office365-filtering-correlation-id: 6a0b57b8-f742-4ac0-8c3d-08de265435ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|7053199007|13003099007|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BueghZXd/AI33BK+KL06efBwJ+xQPlmsRvOHJqxPVuyZsm9mPphEJFS7V0?=
 =?iso-8859-1?Q?mhEUHVSHvs3IiVtrcOsThRn13/VK3q4TPw2VNbHNDB1Dzf2nguwSo98pm1?=
 =?iso-8859-1?Q?e5URZJVSkARWaU+evaMSpKsE+G4fiuNhXgCphpMdF/efMfnSKBgj1ABXAe?=
 =?iso-8859-1?Q?NHzTMYJ0IHEYAs7a8qTzhvjNHHeX01pQfZlOTZUFOlZGYpRX3hGwf9xZC/?=
 =?iso-8859-1?Q?zpx85vk9cOnhnIsui9YC6Y34rNpPazGNL4mrtPvT3EtL09dXONjA2NqC1I?=
 =?iso-8859-1?Q?sYyKdubPAW765qpXa+gGnPlLFzOIiP+PNY4NraeERoWmd0B1V1df2FSTKI?=
 =?iso-8859-1?Q?Ubb0QfvCmocBCkBHplSydeUbO1XFhNwJ5xlyITX2cEEU45wb7gjJWdu2CN?=
 =?iso-8859-1?Q?M/BDvhcflKuf6Tswq5zaY8CZo6Mt1k7CSrBIcRJlBEQVmPL+HuLnG3d8hg?=
 =?iso-8859-1?Q?1NZQE5mCrSF/p4onYyhK9aY+hjNckOkPBTnIi3dRnqGB6MV+VwJVv5G0bP?=
 =?iso-8859-1?Q?IkcTHiME/1qV6f3K7BgU9Tf88WuXSQV4cl263FCsop4I+Z9ZDhjpiJMZLW?=
 =?iso-8859-1?Q?xiGUQ6uyyKRQH6MX6ZF/+MVdjJnXRaUuRChviIHf0wC+GAwGou/6u0v0QG?=
 =?iso-8859-1?Q?MdxRRzNzP+QZxpYTDu/L6wFiuXqCNqzWTOJvEbj8CGVz13oU0FIAFh/HZP?=
 =?iso-8859-1?Q?PM8dWLaYpqxwXBXxh/8V+rCkplr7asc6O97wZZFsdkxqY5c1BFIHhcjJrX?=
 =?iso-8859-1?Q?pRFc/b8CpWUiPkrnchtcMA8sHlgMDLqfaZ4Zxag04+KXj1aASEsc7/cCx8?=
 =?iso-8859-1?Q?gCbt3fpIw/puMzGyR3ApOvEsJcNwbXf7ETpBhpQkPB9TR6Hqc32JQ5U1Kg?=
 =?iso-8859-1?Q?xI5F3C8uVVxJONb+mInwPva5kruDBve26CSDyAdWFAPXBgvfYNo5Cpjcyw?=
 =?iso-8859-1?Q?yMyfa9g2ncFcH+Oa0ciKOO2NU/J9+P/JcuyLF3ed4ieP9x/ZsM/5vlmRMO?=
 =?iso-8859-1?Q?ZHZykqtPgG+DHLxbtLnC0mGLuKSj3+cg2ahA4F7qMIWctNwZhQoVfGz0zo?=
 =?iso-8859-1?Q?lG7d3gq0ZAelUNTqI1fWF2G8b2YpZpsGqTgKdz+hzJ8X1gmui9//Fiixid?=
 =?iso-8859-1?Q?uz+nYuNmOdavxvPAWz4e5tae8BUriAoubk+DKuUrZhc+rBU4OLNef9DCBK?=
 =?iso-8859-1?Q?GHKo8S1lP75bm01aXehBDq8MSjWWYGMz09L+4VImYFACNRBdmN+gxPlyq3?=
 =?iso-8859-1?Q?M0pxUUy/cWeQVo8wDvEw28yy3TiG/prmewBD8Umg0J+Buk3dQjPsoIuFZ7?=
 =?iso-8859-1?Q?7SAj5CXWA4cwh8ZVuyVNc8kfvyasddR+LMFlPPgSC3+62n6F0iPefHfmvl?=
 =?iso-8859-1?Q?PBJ0759VCl1TroCg2ZseHIMnWyi6CMM/0kJlnrSdlio1doeu0mAVtPAkFN?=
 =?iso-8859-1?Q?PTJcEhhGmATnuYwcHhsfbmARVMyB9sBUjEA3L5+jE7aLDwZRLaTRO9ffk3?=
 =?iso-8859-1?Q?/qjC9VF32zI8tI541+7KWLQhTL6TA9lbbdeJuXMsvmXPF5kG5N5TzdOhdf?=
 =?iso-8859-1?Q?DdFh4bqeEfu0Ysduhqk7uSKy6Wrr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8233.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(7053199007)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P42hGerGcDchbv3LDNLmUMMPSsq/+1YPWuiMqMrxQMsLKJqndjCK7xbCU0?=
 =?iso-8859-1?Q?4suytd/xDS1pDvhbLvFLgzcTc6vfEJHq0VE/Xo4uGji+r2PNYaHSh3JzGg?=
 =?iso-8859-1?Q?T8YkCQ0KnBXmWfOyBXRxb1spFBX0aGH6CfUYh3z0Drm3MtNwZWEMV+hnjx?=
 =?iso-8859-1?Q?FEZA1uNiU3GMj2rUCEx82MUNPpvm3980QF6FgoIDOFcpdvzQM2Fx20aiM8?=
 =?iso-8859-1?Q?rmXjppiRp44pnJwZof28KMu30bR0EOpkLCl5QY8ky6JKchNgbs397I6zRI?=
 =?iso-8859-1?Q?bwuqenGHegURbbfX3WxbOeE0i7W/eoaKG9VkVxtvUCkAT2bIa4ohwf8ete?=
 =?iso-8859-1?Q?A+Dl+w5PLIRnoGcJlT+RWp+HmjyxxMPfbv8IFlLGp3xSEACgXhbUy7i7Iy?=
 =?iso-8859-1?Q?Y6mCSh3l645pdkew8hoaczmTraWIjO2V9FihqEdduFwbanFiQiz6s4uY8W?=
 =?iso-8859-1?Q?IQpXFSWjszaJVnn/LYc+PX97DT5Gp3virogAALPmVDwXunexT4sRiSbABX?=
 =?iso-8859-1?Q?w8c6KfG2kvrbY1RHXv+bY2xleh2lhVEZYKiurp8MddnndyB4Erx8CZfyb8?=
 =?iso-8859-1?Q?8G0jDy3sOxZsFywJasOnYXMUFHzL4U652TQx7ZyBpoZm+syG5lVbZbtxmi?=
 =?iso-8859-1?Q?FtxuWvup2EsNhEZwJTwjVbIWYDDFgsunMLZO5w6LwDegHVTXHbURvFrWfr?=
 =?iso-8859-1?Q?f+ph/oqXAEaQIiyrjVTPH7w/70p7yPQ4h4nHlzkSPIQTk+wR8Ts9R3Xj99?=
 =?iso-8859-1?Q?MUULjSORH7B4OIGmpZsw3BCwvlTs9Syu0D0GhwYwuAuEAne2WdhdAcWvcu?=
 =?iso-8859-1?Q?bTK70G4C+M9N1t77zXtG9ng98c8ZJXnCsCK8vYWqR7d9kVMRa4NmR9mHjx?=
 =?iso-8859-1?Q?zBG1ucGjKevIVFp0PiCArpNkKfHA0o8xP9iaaXTdPmKlykaRCNJH8TMQbL?=
 =?iso-8859-1?Q?8nuK5TaBb+hZJSS6dYeDebhs8yReL4lBqIaL4Tt22bUgBEprcnSdCI1Q5A?=
 =?iso-8859-1?Q?CztmSJSlEgugjCL0B+GqmZgiXnK22UupH1esvzunbiFnmlR6v0jplHfpOH?=
 =?iso-8859-1?Q?WnwSr3v+H6VBoEHmghK+AsEeRl65AGWRUfZSHuUkMtFFGAQ9OYFM1ij7pc?=
 =?iso-8859-1?Q?HJW6ecugN3izsu7yAn8jw5ThCeOYn70N9BcYBu3KEch8CKNoYsnY2k2OvB?=
 =?iso-8859-1?Q?Y2nYGp6sPBD3wtIhtiqpalxqF9ykA10WGr7VKgTGuI+SMTMosYi5veedHt?=
 =?iso-8859-1?Q?OBVTCbbs2kaC1i//jWLxealOP8Ev2T5lVzrHNnzQgvFWHPGYPDkUBpgp13?=
 =?iso-8859-1?Q?Dz4XHzl6q2vamuwO7B7S8tx+qGkIbWHbckRBF8/FesU+Bs11f8+8pDsEwf?=
 =?iso-8859-1?Q?EZOBBdfkjpGm5b2SLoTQXJEweOIOqHTjmT3Yx1Q+2yYm6Z1gcgpXGsX+YK?=
 =?iso-8859-1?Q?XgBgRx4WvnRO5sgPVWx5s42c8tajRypiX9fZZMy2kwHESkteGjJiBg0MTe?=
 =?iso-8859-1?Q?kD74vLtm+jUelFoRKK+EAA9xJdIotwMbFkX4gLcjHLfilGtIC8Ts/VGXii?=
 =?iso-8859-1?Q?i6t9q+dr9CSWiVzrRqnBpqr8BANevoIMSNQSbdHBq24tYHMmMoU1ieogiz?=
 =?iso-8859-1?Q?QzSbclQUzN0Sw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB82333CE7927B231FDCA1B55886D6ACH3PR12MB8233namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8233.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0b57b8-f742-4ac0-8c3d-08de265435ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 03:40:25.6722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yw5UrZ+jAH5gyUsaffjfvs1itexrsvGphVKXTXiuKDWjlz6M2c+wTZsNkvtw8Q6MS45rMsHsvx5ehJkxzsDjkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
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

--_000_CH3PR12MB82333CE7927B231FDCA1B55886D6ACH3PR12MB8233namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Alexander,

________________________________
From: Alexander Kozyrev <akozyrev@nvidia.com>
Sent: Tuesday, November 18, 2025 1:35 AM
To: Tummala, Sivaprasad <Sivaprasad.Tummala@amd.com>; Dariusz Sosnowski <ds=
osnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>
Cc: jerinj@marvell.com <jerinj@marvell.com>; kirankumark@marvell.com <kiran=
kumark@marvell.com>; ndabilpuram@marvell.com <ndabilpuram@marvell.com>; yan=
zhirun_163@163.com <yanzhirun_163@163.com>; david.marchand@redhat.com <davi=
d.marchand@redhat.com>; ktraynor@redhat.com <ktraynor@redhat.com>; NBU-Cont=
act-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; konstantin.ananyev@hu=
awei.com <konstantin.ananyev@huawei.com>; konstantin.v.ananyev@yandex.ru <k=
onstantin.v.ananyev@yandex.ru>; bruce.richardson@intel.com <bruce.richardso=
n@intel.com>; maxime.coquelin@redhat.com <maxime.coquelin@redhat.com>; anat=
oly.burakov@intel.com <anatoly.burakov@intel.com>; aconole@redhat.com <acon=
ole@redhat.com>; dev@dpdk.org <dev@dpdk.org>; stable@dpdk.org <stable@dpdk.=
org>
Subject: Re: [PATCH] net/mlx5: fix spurious CPU wakeups caused by invalid C=
QE

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.

>>> Fixes: a8f0df6bf98d ("net/mlx5: support power monitoring")
>>> Cc: akozyrev@nvidia.com
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
>>> ---
>>>  drivers/net/mlx5/mlx5_rx.c | 17 ++++++++++++++++-
>>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
>>> index 420a03068d..2765b4b730 100644
>>> --- a/drivers/net/mlx5/mlx5_rx.c
>>> +++ b/drivers/net/mlx5/mlx5_rx.c
>>> @@ -295,6 +295,20 @@ mlx5_monitor_callback(const uint64_t value,
>>>       return (value & m) =3D=3D v ? -1 : 0;
>>>  }
>>>
>>> +static int
>>> +mlx5_monitor_cqe_own_callback(const uint64_t value,
>>> +             const uint64_t opaque[RTE_POWER_MONITOR_OPAQUE_SZ])
>>> +{
>>> +     const uint64_t m =3D opaque[CLB_MSK_IDX];
>>> +     const uint64_t v =3D opaque[CLB_VAL_IDX];
>>> +     const uint64_t match =3D ((value & m) =3D=3D v);
>>
>> Could you please rename "match" variable to "sw_owned"?
>> This name would better relay the meaning of the checked condition that
>> CQE owner bit value signifies that CQE is SW owned.
>ACK! Will update this in v2.
>>
>>> +     const uint64_t opcode =3D MLX5_CQE_OPCODE(value);
>>> +     const uint64_t valid_op =3D (opcode ^ MLX5_CQE_INVALID);
>>
>>IMO the usage of bit operations here (although logic is correct) is a bit=
 confusing.
>>Could you rewrite it in terms of logical operations so it's easier to
>>follow? For example like this:
>>
>>        const uint64_t valid_op =3D opcode !=3D MLX5_CQE_INVALID
>>
>>        return (sw_owned && valid_op) ? -1 : 0;
>>
>>This also would properly describe in code the required condition:
>>CQE can be parsed by SW if and only if owner bit is "SW owned" and CQE
>>opcode is valid.
>ACK! Will update this in v2.
>>
>>> +
>>> +     /* ownership bit is not valid for invalid opcode; CQE is HW owned=
 */
>>> +     return -(match & valid_op);
>>> +}
>>> +
>>> int mlx5_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond=
 *pmc)
>>>  {
>>>       struct mlx5_rxq_data *rxq =3D rx_queue;
>>> @@ -312,12 +326,13 @@ int mlx5_get_monitor_addr(void *rx_queue, struct =
rte_power_monitor_cond *pmc)
>>>               pmc->addr =3D &cqe->validity_iteration_count;
>>>               pmc->opaque[CLB_VAL_IDX] =3D vic;
>>>               pmc->opaque[CLB_MSK_IDX] =3D MLX5_CQE_VIC_INIT;
>>> +             pmc->fn =3D mlx5_monitor_callback;
>>
>>Alex, Slava: Just to double check - in case of enhanced CQE compression
>>layout, should both CQE opcode and vic be checked?
>>Right now only vic is checked in power monitor callback for that case.
>>In Rx datapath both are checked to determine CQE ownership:
>>https://github.com/DPDK/dpdk/blob/main/drivers/common/mlx5/mlx5_common.h#=
L277
>
>Sorry for the late reply. I think we should check opcode in both cases.
>mlx5_monitor_callback can be updated with the opcode check for enhanced CQ=
E compression layout,
>instead of having 2 separate callback functions. Could you please prepare =
a follow-up patch for that?
Ok, I can extend this patch to also cover for enhanced CQE compression case=
 as well.
Right now, the new call back was added to avoid additional checks in the ol=
der callback function.
I can rework on this as needed.
>>
>>>       } else {
>>>               pmc->addr =3D &cqe->op_own;
>>>               pmc->opaque[CLB_VAL_IDX] =3D !!idx;
>>>               pmc->opaque[CLB_MSK_IDX] =3D MLX5_CQE_OWNER_MASK;
>>> +             pmc->fn =3D mlx5_monitor_cqe_own_callback;
>>>       }
>>> -     pmc->fn =3D mlx5_monitor_callback;
>>>       pmc->size =3D sizeof(uint8_t);
>>>       return 0;
>>>  }
>>> --
>>> 2.43.0
>>>
>>

--_000_CH3PR12MB82333CE7927B231FDCA1B55886D6ACH3PR12MB8233namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Alexander,&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Alexander Kozyrev &lt;akozyrev@nvidia.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, November 18, 2025 1:35 AM<br>
<b>To:</b>&nbsp;Tummala, Sivaprasad &lt;Sivaprasad.Tummala@amd.com&gt;; Dar=
iusz Sosnowski &lt;dsosnowski@nvidia.com&gt;; Slava Ovsiienko &lt;viachesla=
vo@nvidia.com&gt;<br>
<b>Cc:</b>&nbsp;jerinj@marvell.com &lt;jerinj@marvell.com&gt;; kirankumark@=
marvell.com &lt;kirankumark@marvell.com&gt;; ndabilpuram@marvell.com &lt;nd=
abilpuram@marvell.com&gt;; yanzhirun_163@163.com &lt;yanzhirun_163@163.com&=
gt;; david.marchand@redhat.com &lt;david.marchand@redhat.com&gt;; ktraynor@=
redhat.com
 &lt;ktraynor@redhat.com&gt;; NBU-Contact-Thomas Monjalon (EXTERNAL) &lt;th=
omas@monjalon.net&gt;; konstantin.ananyev@huawei.com &lt;konstantin.ananyev=
@huawei.com&gt;; konstantin.v.ananyev@yandex.ru &lt;konstantin.v.ananyev@ya=
ndex.ru&gt;; bruce.richardson@intel.com &lt;bruce.richardson@intel.com&gt;;
 maxime.coquelin@redhat.com &lt;maxime.coquelin@redhat.com&gt;; anatoly.bur=
akov@intel.com &lt;anatoly.burakov@intel.com&gt;; aconole@redhat.com &lt;ac=
onole@redhat.com&gt;; dev@dpdk.org &lt;dev@dpdk.org&gt;; stable@dpdk.org &l=
t;stable@dpdk.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] net/mlx5: fix spurious CPU wakeups caused =
by invalid CQE
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<table style=3D"direction: ltr; width: 100%; box-sizing: border-box; border=
-collapse: collapse; border-spacing: 0px;" cellpadding=3D"0" cellspacing=3D=
"0" align=3D"left">
<tbody>
<tr>
<td style=3D"direction: ltr; background-color: rgb(255, 185, 0); padding: 5=
pt 2pt;">
</td>
<td style=3D"direction: ltr; background-color: rgb(255, 248, 229); padding:=
 5pt 4pt 5pt 12pt; width: 100%;">
<div style=3D"direction: ltr; color: rgb(34, 34, 34);"><b>Caution:</b>&nbsp=
;This message originated from an External Source. Use proper caution when o=
pening attachments, clicking links, or responding.</div>
</td>
</tr>
</tbody>
</table>
<div style=3D"direction: ltr;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);" class=3D"elementToProof">
&gt;&gt;&gt; Fixes: a8f0df6bf98d (&quot;net/mlx5: support power monitoring&=
quot;)<br>
&gt;&gt;&gt; Cc: akozyrev@nvidia.com<br>
&gt;&gt;&gt; Cc: stable@dpdk.org<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Sivaprasad Tummala &lt;sivaprasad.tummala@amd.c=
om&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp; drivers/net/mlx5/mlx5_rx.c | 17 ++++++++++++++++-<br>
&gt;&gt;&gt;&nbsp; 1 file changed, 16 insertions(+), 1 deletion(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx=
5_rx.c<br>
&gt;&gt;&gt; index 420a03068d..2765b4b730 100644<br>
&gt;&gt;&gt; --- a/drivers/net/mlx5/mlx5_rx.c<br>
&gt;&gt;&gt; +++ b/drivers/net/mlx5/mlx5_rx.c<br>
&gt;&gt;&gt; @@ -295,6 +295,20 @@ mlx5_monitor_callback(const uint64_t valu=
e,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (value &amp; m) =3D=
=3D v ? -1 : 0;<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +static int<br>
&gt;&gt;&gt; +mlx5_monitor_cqe_own_callback(const uint64_t value,<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; const uint64_t opaque[RTE_POWER_MONITOR_OPAQUE_SZ])<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t m =3D opaque[CLB_MSK_=
IDX];<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t v =3D opaque[CLB_VAL_=
IDX];<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t match =3D ((value &am=
p; m) =3D=3D v);<br>
&gt;&gt;<br>
&gt;&gt; Could you please rename &quot;match&quot; variable to &quot;sw_own=
ed&quot;?<br>
&gt;&gt; This name would better relay the meaning of the checked condition =
that<br>
&gt;&gt; CQE owner bit value signifies that CQE is SW owned.<br>
&gt;ACK! Will update this in v2.</div>
<div style=3D"direction: ltr; font-size: 11pt;" class=3D"elementToProof">&g=
t;&gt;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t opcode =3D MLX5_CQE_O=
PCODE(value);<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t valid_op =3D (opcode =
^ MLX5_CQE_INVALID);<br>
&gt;&gt;<br>
&gt;&gt;IMO the usage of bit operations here (although logic is correct) is=
 a bit confusing.<br>
&gt;&gt;Could you rewrite it in terms of logical operations so it's easier =
to<br>
&gt;&gt;follow? For example like this:<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; const uint64_t valid_op =3D opcode !=3D=
 MLX5_CQE_INVALID<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; return (sw_owned &amp;&amp; valid_op) ?=
 -1 : 0;<br>
&gt;&gt;<br>
&gt;&gt;This also would properly describe in code the required condition:<b=
r>
&gt;&gt;CQE can be parsed by SW if and only if owner bit is &quot;SW owned&=
quot; and CQE<br>
&gt;&gt;opcode is valid.</div>
<div style=3D"direction: ltr; font-size: 11pt; color: black;" class=3D"elem=
entToProof">
&gt;ACK! Will update this in v2.</div>
<div style=3D"direction: ltr; font-size: 11pt;" class=3D"elementToProof">&g=
t;&gt;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* ownership bit is not valid for in=
valid opcode; CQE is HW owned */<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return -(match &amp; valid_op);<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; int mlx5_get_monitor_addr(void *rx_queue, struct rte_power_mon=
itor_cond *pmc)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;struct mlx5_rxq_data *rxq =3D rx_que=
ue;<br>
&gt;&gt;&gt; @@ -312,12 +326,13 @@ int mlx5_get_monitor_addr(void *rx_queue=
, struct rte_power_monitor_cond *pmc)<br>
&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pmc-&gt;=
addr =3D &amp;cqe-&gt;validity_iteration_count;<br>
&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pmc-&gt;=
opaque[CLB_VAL_IDX] =3D vic;<br>
&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pmc-&gt;=
opaque[CLB_MSK_IDX] =3D MLX5_CQE_VIC_INIT;<br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; pmc-&gt;fn =3D mlx5_monitor_callback;<br>
&gt;&gt;<br>
&gt;&gt;Alex, Slava: Just to double check - in case of enhanced CQE compres=
sion<br>
&gt;&gt;layout, should both CQE opcode and vic be checked?<br>
&gt;&gt;Right now only vic is checked in power monitor callback for that ca=
se.<br>
&gt;&gt;In Rx datapath both are checked to determine CQE ownership:</div>
<div style=3D"direction: ltr; font-size: 11pt;" class=3D"elementToProof">&g=
t;&gt;<a data-auth=3D"NotApplicable" class=3D"x_OWAAutoLink" id=3D"OWA2e54c=
5ce-15bf-9840-085a-4ab66eeeeded" href=3D"https://github.com/DPDK/dpdk/blob/=
main/drivers/common/mlx5/mlx5_common.h#L277">https://github.com/DPDK/dpdk/b=
lob/main/drivers/common/mlx5/mlx5_common.h#L277</a></div>
<div style=3D"direction: ltr; font-family: Verdana, Geneva, sans-serif; fon=
t-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&gt;</div>
<div style=3D"direction: ltr; font-size: 11pt; color: rgb(0, 0, 0);" class=
=3D"elementToProof">
&gt;Sorry for the late reply. I think we should check opcode in both cases.=
</div>
<div style=3D"direction: ltr; font-size: 11pt; color: rgb(0, 0, 0);" class=
=3D"elementToProof">
&gt;mlx5_monitor_callback can be updated with the opcode check for enhanced=
 CQE compression layout,</div>
<div style=3D"direction: ltr; font-size: 11pt; color: rgb(0, 0, 0);" class=
=3D"elementToProof">
&gt;instead of having 2 separate callback functions. Could you please prepa=
re a follow-up patch for that?</div>
<div style=3D"direction: ltr; font-family: Verdana, Geneva, sans-serif; fon=
t-size: 9pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Ok, I can extend this patch to also cover for enhanced CQE compression case=
 as well.&nbsp;</div>
<div style=3D"direction: ltr; font-family: Verdana, Geneva, sans-serif; fon=
t-size: 9pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Right now, the new call back was added to avoid additional checks in the ol=
der callback function.&nbsp;</div>
<div style=3D"direction: ltr; font-family: Verdana, Geneva, sans-serif; fon=
t-size: 9pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I can rework on this as needed.&nbsp;</div>
<div style=3D"direction: ltr; font-family: Verdana, Geneva, sans-serif; fon=
t-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&gt;&gt;</div>
<div style=3D"direction: ltr; font-family: Verdana, Geneva, sans-serif; fon=
t-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pmc-&gt;addr =3D &amp;cqe-&gt;op_own;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pmc-&gt;opaque[CLB_VAL_IDX] =3D !!idx;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pmc-&gt;opaque[CLB_MSK_IDX] =3D MLX5_CQE_OWNER_MASK;<=
br>
&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; pmc-&gt;fn =3D mlx5_monitor_cqe_own_callback;<br>
&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pmc-&gt;fn =3D mlx5_monitor_callback=
;<br>
&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;pmc-&gt;size =3D sizeof(uint8_t);<br=
>
&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.43.0<br>
&gt;&gt;&gt;<br>
&gt;&gt;</div>
</body>
</html>

--_000_CH3PR12MB82333CE7927B231FDCA1B55886D6ACH3PR12MB8233namp_--
