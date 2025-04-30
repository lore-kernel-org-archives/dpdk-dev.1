Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B1DC369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 11:12:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C76DE402F0;
	Wed, 30 Apr 2025 13:12:56 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by mails.dpdk.org (Postfix) with ESMTP id C2BC7402A7
 for <dev@dpdk.org>; Wed, 30 Apr 2025 13:12:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDtgklA89Hm3S/5QBw94hwaCUdXFrCPFOHDVA2Umc6UCAmCiOjsOxNabUJO36CecetENvpydj7GCyO+/9iFWrBfbOWxLljUrzCBJt5/TMhm2L1ztMewleHKc/Sd9AriaggjooK9CqR7pleNNFJvPcJixb3I1TgDEC/mYP8bPIA3Z1/IwyyjqFuMekvc+RQe93QlnShU6DjXKTXWQyJIF2ZCCb4fmi4GDk97LPBIsUNnk+553PFMy/g/4hGq7SmlpnbsT1zHeLXMuF9CJKIugjk0d2guSGV7XjMlWuBNfqJDMLunQ3tVk1XVq80O7u4+6xk9f7yHOkQEccQovKs5OXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwdiI8hH2Ah09zsJucuh+WrRriq53JzbLBYWBzErhh8=;
 b=a16f39QFUaNh3uwQsFK4/gmXezsmY1FkZARwnJ9uqjZ4kKjN7xe4QN9776/AgXgmHZXCJHEmmcIkEEfRNqNdvztE1m0gy77USBp1vu99E2wS0GEy4QCnZbVSa+UPoK94tNdq97zMYJgyh4v5btoCgunDh+GNOpw3A6lUA+LZRvFCSlddWhIybD/d8KDhgQZ3Zoilx7hOV7RNXM1TJGB3F+PtUaRUOCoCplQfgSqh7WRrEom64A/JhtuFjIdyE+haDvU6RqxQvWhyRqgh9z43Pcyc3gV7SbtosoojxG/a5E8H29bGzxWuvbDa9NJCXexyPN1dPirvRtZePj43bNvWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwdiI8hH2Ah09zsJucuh+WrRriq53JzbLBYWBzErhh8=;
 b=YqDESvLN00l/Hz7GrCNsl5pQjzG8/PuPrFqMuQjVgI+r0nIZMGFn051KfuzlUTvqtzk2k347+Ob5A6aM5++khmpsugjWW1e4a+ZjfjdBlDZPZDuBIRyDIF6xr3cwQewOxPo16LRImsj5G4qedFm4IkGf0WmQeFDZd7nrTkJRjFpzahEaVi8sfdTssL6CrXwuMY8Mh0ilko+3bQWXAS5Yx5a0yyt78YZ/qwQTakBgaMygYaF9+bJUYGQ6YdOvJroNeJZIwyy6ZXsloJYPlP8hFUulTmkmQDgDbAqQQ+IZcGsp36qPud0zOw5J3ad+v1Wk1v2sc+ZnNCmYIGigLZLBQA==
Received: from SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 11:12:51 +0000
Received: from SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784]) by SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 11:12:51 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>, Chenbo Xia
 <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>, Chengwen
 Feng <fengchengwen@huawei.com>, "NBU-Contact-longli (EXTERNAL)"
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Kevin Laatz <kevin.laatz@intel.com>, Jan Blunck
 <jblunck@infradead.org>
Subject: RE: [PATCH v7 2/4] lib: fix comparison between devices
Thread-Topic: [PATCH v7 2/4] lib: fix comparison between devices
Thread-Index: AQHbfWyk6u++8mW2M0u7nGCEK4IWvbNQkOMAgBXbKoCAESYEgIBE9Cgw
Date: Wed, 30 Apr 2025 11:12:51 +0000
Message-ID: <SA1PR12MB949189CD2B76C82E0C3F0EE2BF832@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
 <20250212163836.178976-1-shperetz@nvidia.com>
 <20250212163836.178976-2-shperetz@nvidia.com>
 <20250220103300.7148ddd8@hermes.local>
 <SA1PR12MB9491E12CFD0E551E742ABCDBBFCA2@SA1PR12MB9491.namprd12.prod.outlook.com>
 <20250317071121.4508a7e6@hermes.local>
In-Reply-To: <20250317071121.4508a7e6@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9491:EE_|IA0PR12MB9048:EE_
x-ms-office365-filtering-correlation-id: f755ffd4-73de-49ce-28ba-08dd87d7f2b8
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?N0xWVTdOOG83SHNMYVVhbXgwVkhmbGczd0NkTFJ3aWl0aU5ZSlFxWUQ5Rllz?=
 =?utf-8?B?dlNhSitQZTd3c0dDb2xwd2dQSUk1ZmlMQjVDTzJOTnhzQkZPWVZaV29ad1g4?=
 =?utf-8?B?ekJHTy8vd24rZlhQSHM0dTB2aC9pT3VmYjE2YXExMzdJL1R0amQ5bTlTbTk2?=
 =?utf-8?B?R0JkczBnTUJDVGQ2OXQ4TzBkTlNCaitrQjVReW5KNS95WGtGS0oyY2xWN2VU?=
 =?utf-8?B?cEdDYUxhL2lvRTd6akg1aHlmVjF4bEdsUldzREZmYU8rcEl0UGt2TDV1dzQy?=
 =?utf-8?B?NFlQN2lsbTFzNURXZUlwNGVTeUU5R20yMVpuTCtXKy9seExjT3MwaEo0YXJV?=
 =?utf-8?B?em1peG53bmhTOHlUWmMycWJod0dvaDNEeWNyUXA1Z0RRVUhLaW5NNmY2SUIw?=
 =?utf-8?B?Zkl2amU3Vm02ejR5cmE1RUhMWFRHYVdTY3dWaUxHM1ZiKzQyWkwzb2lLVXJr?=
 =?utf-8?B?RjZYUnh3ZnRDbFNrRDQ3aS9JR0wvNDZSWlFWYXNoWU80b2dmMjVUNmJNaGZy?=
 =?utf-8?B?V0R2TldQRFNiaC9ETlk2TC9FSXBrc2Q5ZzdWUTFPN1hJRjFkaU93STRKa0dG?=
 =?utf-8?B?UG1UNUpQZjREbkVZMjkrVFAxdGh2UjJWc0tOK0NDMDh6U3pBK05zQ2hPbk5U?=
 =?utf-8?B?dmtSSEgzN0hvcXl4M2lzdURLQm5SZUZ4WlZyWWZiV0NzZzNCa0ExWnJaeVJS?=
 =?utf-8?B?U29uOWxBRU9OZzJ4YW5mdkR6WE5JWEtkQ21sc3lxY1AwL1FJZ1lZRWlaUXVa?=
 =?utf-8?B?ZGp5dWhBT1Nrd3N6dStTNE84VXQ3SktiMnFLVW0ra1V3TDRoWDMxeWJ2aFdP?=
 =?utf-8?B?aVBmWUFxQnZiVTR5Uzhwd2d1ZGdlVU56cWtIVGRUZCtHS21Oazl2VWdrT0tJ?=
 =?utf-8?B?Ynd4Umx4S2NzU1MzZzc4aTdBa1VJdVhMVVh2RC9OT0k3ZTJRWFo1MU5hUGsx?=
 =?utf-8?B?bVp4bG5pWHlwMzhZSmpaUEpKZ1FhM1lVWTNlU2VMSnVvOTRFay93WEF0aFRv?=
 =?utf-8?B?V0ZsUW9WUjdab3hURDl3RlJ3clFZK2lZK0NsMUZNVFd0aE9RUjB3ampwSFZP?=
 =?utf-8?B?M1lMU3ZaYWNPMFF0RWpqd0xBRVlXNTF1elF6bGFJWm5SeTVoTVd5UHpGL3Zk?=
 =?utf-8?B?UWk5N0JsN3MyVXJpZEJtbzJSbDBUenB3SmJIdzFydkRoRTZDZ2JSOU5mUkh3?=
 =?utf-8?B?QjZPb3pJVFlwZlRoTmJ5OS8rbWdDTEpXQVV3VFNENXJDVGtuc1NsdC9kYXVC?=
 =?utf-8?B?QWFGd1lrbThYczBUR3pXRTIyYTFsbmVrdFpQOXhUcWI1T00xYlEwbW1GMzNa?=
 =?utf-8?B?R0RVcmtlL1pOb09KK2xlYjY5djVRdGJSa0hOT1lJMi9tRThCT3p4R3dpUm1i?=
 =?utf-8?B?LzR0TUlqYVNYZzl4SlRwMXhTYWVaVzE0aktyUWp3aFhTOFNLenVOaGgrZWtX?=
 =?utf-8?B?SVIvbmowa1hvWk5ReXFLZDkvOWFLRFJzcndmUDM3c0JrQUtkQVUwY0VSUFBt?=
 =?utf-8?B?Y0pQSEN0YldIWHFzVmFTYXcxNUR1Q0N5ZkhaOUtjbzU3WXZnd0RzK21ESTZk?=
 =?utf-8?B?MkxvcVB0WklFUzErRkJrOVdScGhWS2V1WXVXYW9jdytNQzRWRFVad2dDUGl4?=
 =?utf-8?B?Rk02ZGFQWnU1U3c3T0lxQjhqQXZUTnpWRmJ2U3F0WlpUdDhFTmh0NFhLT3FN?=
 =?utf-8?B?RHRKdllhTldQNXpuU0VUQWEvaDlNNHhqdjZpZHROcmdOMENJb3hyZFpqWTQ4?=
 =?utf-8?B?YmE2T0RzSkQybVQ2RDE1Rk1ZaWp2bXdDYS9nU0NZbW5oMGo4c3JnS2dXdE9q?=
 =?utf-8?B?Y0NPZDJZNUQxZDhLd3llMzk1L29ESXdHbEluN1l5aXFqalVsRDhXbmg3QUtN?=
 =?utf-8?B?YkUxeW5hZkxhcHdhZy9ua3JQSlU5MHdqMnNzZlIxeDhqOWk3VWhXZUlCeWtT?=
 =?utf-8?B?dDZZU0JRNVZVUXpCQWY1dmhzUUxkQUxiSnoyNHZZZkNteTIwTlRnb3lKNWpY?=
 =?utf-8?Q?GQue3Mv+A5fbd5GHnz8bKdwjMlhNDU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXdMemF4VGRBbjdmZEY3aVg4WjRha2xDOFF1TmpzKzdlMEQ0Vjc0dzEwdEgz?=
 =?utf-8?B?MXpqV1UwNWcyd0RVOFQ3eFlvZGM3OERZRmV6emNtMFZhMlJubWI2OCtuSDZC?=
 =?utf-8?B?YWNLZXZRS2hLK0plc0xYTE05VUZOTGg4QmRPbkxXcE5nSnJYUXhtN3lVaEd1?=
 =?utf-8?B?dDhiSUlOR0REN3hoYXN4Y3FWSG1VMjZkUlV2Z1ZSZWZkSG9IRGk4WStldzh0?=
 =?utf-8?B?cEFCYXkrbEZvT0ZwNUwxVkFzL2NOL2c3dlIxVkJtaEFRT2t6VEd3ZmJlcnha?=
 =?utf-8?B?dnNPcEhlbmUvcTRUMzJJbk5iYmVOSXFicHhqcnJPWGRsV0RKdlRGSlAxdGhm?=
 =?utf-8?B?U0VTbXFYODRwaS84bnRqcU13VW8veDhaWXREaStVajVpUzZBTFlnV21Obktn?=
 =?utf-8?B?Q2VNY3QvZTRXS0dLcXcxbkdtVjZWN0lwVVkwbXVLYk1VZFcxcHJBcXhlSGlm?=
 =?utf-8?B?ZTZSTE1jMzdXeVEwMXpudExXQXg3aW9DMEk2enhySHc0MVk2TGVsZ2VCM2dW?=
 =?utf-8?B?RG5HaG4vV3gxZXFsVVVxeEZDanNWS1AwYjMxSnd6RTNnRHJHQmw1anRRTktQ?=
 =?utf-8?B?cXpTRjF4UnBuL010Y2ZKVXFRSGR5bUg0M0dyeW1HUnUvYUJxVVhhV3dDa1FE?=
 =?utf-8?B?MkVvUXdGUVFnSFBTMllpaU9lV08vdk1yL0dVOEZYbllQT3RHM3ViYThodHF0?=
 =?utf-8?B?SlE3Wk85eGdOSXo1WjZWMjErakRTZktmNy9mTkxYNDlHZU8rbitBSVdVUU9w?=
 =?utf-8?B?YUJrNGhGcVdVUmNLUWxQbWNaQ0ZIUmo4OG1NQWpST1dYSHVhRy80eUN5QWxT?=
 =?utf-8?B?VklGM0NYdzRudkpCUmkveVdYUmxMTGs5REpQeU84RzN2V3ZNQmhxZXlxZnNy?=
 =?utf-8?B?UE80RjNBNkd4VlpJQ1JtejZDeDNRbHJWQk95WndsclNYUkNvdmVadlVFbVhI?=
 =?utf-8?B?d25aR1lHWkRnK0JiT2ZqT0xuMlBCcWIwVnNGamwyWXdKc3hkVk1QVmo3dTVV?=
 =?utf-8?B?YzYyRmh3MlJXbFhoWVV0NDlRbHY0YmV3MWpBS05IMnJxVE85V3hGdC9qd1Vq?=
 =?utf-8?B?cmhXditNbk84blVSbkNWZS9zcHlkaG1NT1k3cTE3MDBUbFFGZHAvUzhzZ2x2?=
 =?utf-8?B?NkFtOGVlMEs3SHVXYkY2ZFl3VU80T2NNYVN5WWsyMFNyLzBzRW83YVdHV283?=
 =?utf-8?B?RUFhWTJBekk4N0FRcHJ2V2E0aWFaWEppZnNWeW1SUHhWQTVZYjJYb0xja1hn?=
 =?utf-8?B?ZTZIYWdZeHRYc1k1U0Y4UkJoWE4yT09qTE9XaUZ0NzhRMml1bEs5NUpKKy82?=
 =?utf-8?B?SGptNVpvTjF0R05McFp0NWw1Sjl5U2FFeE1sUW43Znp4NFU0UE50VFVkMnkz?=
 =?utf-8?B?ZVgvUWFsQjJ0N29OM213L29ZaHNUMXpxaUw2S3BLTjVKRnErY0JsN0xOcTJL?=
 =?utf-8?B?NDYyaE5RK3ZWUnlaZTZ5TXRYeFErcUltbkNMV29SMzV5bDVSUkhBcGlIbHdm?=
 =?utf-8?B?cm9mdnFyUkNhTThWdC9nYlVxMGxwamprVWdCaXhUbGxoSlhtb2VVVEw0amRj?=
 =?utf-8?B?MEJSTFM1ckFSSkRvU0NITVhhcEdKSFNQbXlUYVMvNkxqd21wb0Yzc0dYZmsx?=
 =?utf-8?B?eUxqaDRWT3JDVUg2dFAwVnBXa3NPbmtxUno5aXNXWnVsUUYzQzM2QnBidmpZ?=
 =?utf-8?B?T1JKTTR6eW9GemNGK2VaUUtMZGtTRDF1cjlBVlB5WVp4THVwQWRSRXpIWitR?=
 =?utf-8?B?Z20rYVljZWdOM0JoK0hDb0Y4U3owMFQraCtjcVBrQ040WVBLekxmLzVtcHpP?=
 =?utf-8?B?diswZDE5UlFMUm5xN0xqeklNZGdreVEzY2N4VUJHWVprTDlLbVNzdmlBVmpN?=
 =?utf-8?B?T3NUdEZBekJoc0xNa3U2ZytpUDVXVk0vVGFUb3Q1dWhzcVY2VnA3SVlucDcx?=
 =?utf-8?B?OElWQzJzZTlvWDNtaUtyQXNpMHBTRWVoQXY0RzcvaHhrSTl6S2dISW52RVh3?=
 =?utf-8?B?Y0F3OGh2Tk1iWGY0UHE3bldPdFJyZFNuYlpVb2trMFphWnZJTkZaV1lvcG1F?=
 =?utf-8?B?dDdOeEJ3Vlk4YzdvaURwK1N5YTl2bU1SK05USVZBYkg3NDVYR1VVaTJNbk5B?=
 =?utf-8?Q?PYuW2iMqmInO4DqUGoUHWGuby?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f755ffd4-73de-49ce-28ba-08dd87d7f2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 11:12:51.6077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uA7bIBOKiqySRhOEFIaR59FCl47hlRlD2coygcj63bDKC2NNb7XFto2uS9MMC2lf0qZUCMtjrq3iW2srBIlBlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
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

DQpIZXkgU3RlcGhhbiwNCkFwb2xvZ2l6ZSBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UgYW5kIGFw
cHJlY2lhdGUgeW91ciBhc3Npc3RhbmNlLg0KSSBwcmVwYXJlZCBhIGRvY3VtZW50IG91dGxpbmlu
ZyB0aGUgYnVnIGFuZCBpdHMgZmxvdywgYWxvbmcgd2l0aCB0aGUgdHdvIHNvbHV0aW9ucyB3ZSBk
aXNjdXNzZWQuDQpJIGhvcGUgdGhpcyBkb2N1bWVudCBwcm92aWRlcyBhIGNvbXByZWhlbnNpdmUg
b3ZlcnZpZXcuIENhbiB5b3UgdGFrZSBhIGxvb2s/DQoNClRoYW5rIHlvdSENCg0KaHR0cHM6Ly9k
b2NzLmdvb2dsZS5jb20vZG9jdW1lbnQvZC8xTG1NbEozMVAxRzc3SzBUR2tCZlhXejBERWo2emRw
clAwYkc1cF93dTc3dy9lZGl0P3VzcD1zaGFyaW5nDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJl
ci5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgMTcgTWFyY2ggMjAyNSAxNjoxMQ0KPiBUbzogU2hhbmkg
UGVyZXR6IDxzaHBlcmV0ekBudmlkaWEuY29tPg0KPiBDYzogZGV2QGRwZGsub3JnOyBUeWxlciBS
ZXR6bGFmZiA8cm9yZXR6bGFAbGludXgubWljcm9zb2Z0LmNvbT47IFBhcmF2IFBhbmRpdA0KPiA8
cGFyYXZAbnZpZGlhLmNvbT47IFh1ZW1pbmcgTGkgPHh1ZW1pbmdsQG52aWRpYS5jb20+OyBOaXB1
biBHdXB0YQ0KPiA8bmlwdW4uZ3VwdGFAYW1kLmNvbT47IE5pa2hpbCBBZ2Fyd2FsIDxuaWtoaWwu
YWdhcndhbEBhbWQuY29tPjsgSGVtYW50DQo+IEFncmF3YWwgPGhlbWFudC5hZ3Jhd2FsQG54cC5j
b20+OyBTYWNoaW4gU2F4ZW5hDQo+IDxzYWNoaW4uc2F4ZW5hQG54cC5jb20+OyBSb3NlbiBYdSA8
cm9zZW4ueHVAaW50ZWwuY29tPjsgQ2hlbmJvIFhpYQ0KPiA8Y2hlbmJveEBudmlkaWEuY29tPjsg
VG9tYXN6IER1c3p5bnNraSA8dGR1c3p5bnNraUBtYXJ2ZWxsLmNvbT47DQo+IENoZW5nd2VuIEZl
bmcgPGZlbmdjaGVuZ3dlbkBodWF3ZWkuY29tPjsgTkJVLUNvbnRhY3QtbG9uZ2xpDQo+IChFWFRF
Uk5BTCkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPjsgV2VpIEh1IDx3ZWhAbWljcm9zb2Z0LmNvbT47
IEJydWNlDQo+IFJpY2hhcmRzb24gPGJydWNlLnJpY2hhcmRzb25AaW50ZWwuY29tPjsgS2V2aW4g
TGFhdHoNCj4gPGtldmluLmxhYXR6QGludGVsLmNvbT47IEphbiBCbHVuY2sgPGpibHVuY2tAaW5m
cmFkZWFkLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAyLzRdIGxpYjogZml4IGNvbXBh
cmlzb24gYmV0d2VlbiBkZXZpY2VzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24g
b3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIFRodSwgNiBNYXIgMjAy
NSAxNjoyNjo1MCArMDAwMA0KPiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5jb20+IHdy
b3RlOg0KPiANCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBT
dGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+ID4gPiBTZW50
OiBUaHVyc2RheSwgMjAgRmVicnVhcnkgMjAyNSAyMDozMw0KPiA+ID4gVG86IFNoYW5pIFBlcmV0
eiA8c2hwZXJldHpAbnZpZGlhLmNvbT4NCj4gPiA+IENjOiBkZXZAZHBkay5vcmc7IFR5bGVyIFJl
dHpsYWZmIDxyb3JldHpsYUBsaW51eC5taWNyb3NvZnQuY29tPjsNCj4gPiA+IFBhcmF2IFBhbmRp
dCA8cGFyYXZAbnZpZGlhLmNvbT47IFh1ZW1pbmcgTGkgPHh1ZW1pbmdsQG52aWRpYS5jb20+Ow0K
PiA+ID4gTmlwdW4gR3VwdGEgPG5pcHVuLmd1cHRhQGFtZC5jb20+OyBOaWtoaWwgQWdhcndhbA0K
PiA+ID4gPG5pa2hpbC5hZ2Fyd2FsQGFtZC5jb20+OyBIZW1hbnQgQWdyYXdhbCA8aGVtYW50LmFn
cmF3YWxAbnhwLmNvbT47DQo+ID4gPiBTYWNoaW4gU2F4ZW5hIDxzYWNoaW4uc2F4ZW5hQG54cC5j
b20+OyBSb3NlbiBYdQ0KPiA+ID4gPHJvc2VuLnh1QGludGVsLmNvbT47IENoZW5ibyBYaWEgPGNo
ZW5ib3hAbnZpZGlhLmNvbT47IFRvbWFzeg0KPiA+ID4gRHVzenluc2tpIDx0ZHVzenluc2tpQG1h
cnZlbGwuY29tPjsgQ2hlbmd3ZW4gRmVuZw0KPiA+ID4gPGZlbmdjaGVuZ3dlbkBodWF3ZWkuY29t
PjsgTkJVLUNvbnRhY3QtbG9uZ2xpDQo+ID4gPiAoRVhURVJOQUwpIDxsb25nbGlAbWljcm9zb2Z0
LmNvbT47IFdlaSBIdSA8d2VoQG1pY3Jvc29mdC5jb20+OyBCcnVjZQ0KPiA+ID4gUmljaGFyZHNv
biA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+OyBLZXZpbiBMYWF0eg0KPiA+ID4gPGtldmlu
LmxhYXR6QGludGVsLmNvbT47IEphbiBCbHVuY2sgPGpibHVuY2tAaW5mcmFkZWFkLm9yZz4NCj4g
PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMi80XSBsaWI6IGZpeCBjb21wYXJpc29uIGJldHdl
ZW4gZGV2aWNlcw0KPiA+ID4NCj4gPiA+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVu
aW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+ID4gPg0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgMTIg
RmViIDIwMjUgMTg6Mzg6MzMgKzAyMDANCj4gPiA+IFNoYW5pIFBlcmV0eiA8c2hwZXJldHpAbnZp
ZGlhLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBEUERLIHN1cHBvcnRzIG11bHRpcGxlIGZv
cm1hdHMgZm9yIHNwZWNpZnlpbmcgYnVzZXMsIChzdWNoIGFzDQo+ID4gPiA+ICIwMDAwOjA4OjAw
LjAiIGFuZCAiMDg6MDAuMCIgZm9yIFBDSSkuDQo+ID4gPiA+IFRoaXMgZmxleGliaWxpdHkgY2Fu
IGxlYWQgdG8gaW5jb25zaXN0ZW5jaWVzIHdoZW4gdXNpbmcgb25lIGZvcm1hdA0KPiA+ID4gPiB3
aGlsZSBydW5uaW5nIHRlc3RwbWQsIHRoZW4gYXR0ZW1wdHMgdG8gdXNlIHRoZSBvdGhlciBmb3Jt
YXQgaW4gYQ0KPiA+ID4gPiBsYXRlciBjb21tYW5kLCByZXN1bHRpbmcgaW4gYSBmYWlsdXJlLg0K
PiA+ID4gPg0KPiA+ID4gPiBUaGUgaXNzdWUgYXJpc2VzIGZyb20gdGhlIGZpbmRfZGV2aWNlIGZ1
bmN0aW9uLCB3aGljaCBjb21wYXJlcyB0aGUNCj4gPiA+ID4gdXNlci1wcm92aWRlZCBzdHJpbmcg
ZGlyZWN0bHkgd2l0aCB0aGUgZGV2aWNlLT5uYW1lIGluIHRoZQ0KPiA+ID4gPiBydGVfZGV2aWNl
IHN0cnVjdHVyZS4NCj4gPiA+ID4gSWYgd2Ugd2FudCB0byBhY2N1cmF0ZWx5IGNvbXBhcmUgdGhl
c2UgbmFtZXMsIHdlJ2xsIG5lZWQgdG8gYnJpbmcNCj4gPiA+ID4gYm90aCBzaWRlcyB0byB0aGUg
c2FtZSByZXByZXNlbnRhdGlvbiBieSBpbnZva2luZyB0aGUgcGFyc2UNCj4gPiA+ID4gZnVuY3Rp
b24gb24gdGhlIHVzZXIgaW5wdXQuDQo+ID4gPg0KPiA+ID4gQ291bGQgeW91IGdpdmUgYW4gZXhh
bXBsZSB3aGVyZSB0aGlzIGhhcHBlbnMgcGxlYXNlPw0KPiA+ID4gU2hvdWxkbid0IGZpbmRfZGV2
aWNlIHN0cmluZyBhbHdheXMgYmUgY2hhbmdlZCBpbnRvIGNhbm9uaWNhbCBmb3JtDQo+ID4gPiBp
biBmaW5kX2RldmljZSBoYW5kbGVyPw0KPiA+DQo+ID4gVGhlIGZsb3cgSSB3YXMgZGVhbGluZyB3
aXRoIHdhcyBhdHRhY2hfcG9ydCAtPiBydGVfZGV2X3Byb2JlIC0gPg0KPiBsb2NhbF9kZXZfcHJv
YmUgLT4gZmluZF9kZXZpY2UuDQo+ID4gVGhlIHN0cmluZyBwYXNzZWQgdG8gYXR0YWNoX3BvcnQg
d2FzIHRoZSBzaG9ydCB2ZXJzaW9uLCBkaXJlY3RseSBmcm9tIHRoZSB1c2VyLg0KPiA+DQo+ID4g
U28sIHRvIGNsYXJpZnkgLSB5b3UncmUgc2F5aW5nIHRoYXQgZmluZF9kZXZpY2Ugc2ltcGx5IG5l
ZWQgdG8gYWNjZXB0IHRoZSBzdHJpbmcNCj4gaW4gaXRzIGNhbm9uaWNhbCBmb3JtPyBXaGljaCBt
ZWFucyB3ZSdsbCBvbmx5IG5lZWQgdG8gZml4IGxvY2FsX2Rldl9wcm9iZSB0bw0KPiBicmluZyBp
dCB0byB0aGUgY2Fub25pY2FsIGZvcm0gYmVmb3JlIGNhbGxpbmcgZmluZF9kZXZpY2U/DQo+ID4g
SSB0cmllZCBpdCBidXQgdGhlbiBJIG5vdGljZWQgdGhhdCB0aGVyZSdzIG5vIGZ1bmN0aW9uIHRo
YXQgZ2V0cyB0aGUgdXNlci0NCj4gcHJvdmlkZWQgc3RyaW5nIGFuZCByZXR1cm5zIGl0J3Mgc3Ry
aW5nIGNhbm9uaWNhbCBmb3JtLiBUaGUgY2xvc2VzdCB0byB0aGlzIGlzDQo+IHBhcnNlLCBidXQg
d2hhdCBpdCBldmVudHVhbGx5IHJldHVybnMgaXMgbm90IG5lY2Vzc2FyaWx5IGEgc3RyaW5nIC0g
aXQgY2FuIGJlDQo+IGFueXRoaW5nIC0gZm9yIGluc3RhbmNlIHBjaV9wYXJzZSB3aWxsIGdpdmUg
eW91IGJhY2sgYSBzdHJ1Y3QgcnRlX3BjaV9hZGRyLg0KPiANCj4gTm90IHN1cmUgYXQgdGhpcyBw
b2ludC4gVGhlcmUgYXJlIHR3byBvcHRpb25zLiBPbmUgd291bGQgYmUgZml4dXAgaW4gYXR0YWNo
X3BvcnQNCj4gdGhlIG90aGVyIHdvdWxkIGJlIGFsbG93aW5nIHNob3J0IGZvcm0gaW4gUENJIHBh
cnQgb2YgZmluZF9kZXZpY2UuIFNpbmNlIHRoZQ0KPiBzdHJpbmdzIGZyb20gY29tbWFuZCBsaW5l
IGFyZSBwdXQgaW4gY2Fub25pY2FsIGZvcm0gZm9yIGRldmFyZ3MsIGl0IHNlZW1zDQo+IGxvZ2lj
YWwgdG8gZG8gaXQgaW4gYXR0YWNoX3BvcnQgcGF0aC4NCg==
