Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA17D3C536
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 12:28:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F89C4028F;
	Wed, 10 Dec 2025 13:28:52 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013032.outbound.protection.outlook.com
 [40.93.196.32]) by mails.dpdk.org (Postfix) with ESMTP id 8E39F40285
 for <dev@dpdk.org>; Wed, 10 Dec 2025 13:28:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y797hNJx8VtuBL2Rmv2bijMuheGfhIX0A2P7HTjgsiphfM3bQTSILNbOU/Q3C74+lRc0D5H79chBH1+7OjAP6dmQEDxMVkTvhvsyHKrQ7sHNEnH+8YJ8UEYQznYzkS/R0sRcI7/qDVC3ZRv4ibZpbHa3wJ9ZahM+PSr1AmFSY2YOJu9w3KmlXVb1JSIOLF/aIrS/u+dhJq5gdTzSSGI9IWi5/w/47PdW28DOjyUDNjN4c2n9yUDYp4c6r6dDeD2McXfrOootl0RfMf+D3Taa1EMHraLgiHZ2I+O0W36rdwj0hvw2wAE3/nhZNRI3lTq1VJEeoY65jo0jKc7exat7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNv7AVqzYvwUDXkUCdeVPxWBFGE0i6lz/odQvhwaI6E=;
 b=ImtSbUnx/zIWG3hw8C+cc/zklDuaAIgsb2c5QwoPVr4085GE/FS3XDWp6s+sSJgmoqE/FM2UEitu7Tovp0x7Nu9M3Nl8KCFFojhr0wnoyye5h3bShjUQ++mn+tP9DTbHMOQcUBC098NyRP94SG5wm3jjZJOwtWAWFVaHErJE7HLlkWBFlRxnE2RdJ5VhEX6vcLVQbZRgn4OpSsNgOhEncfViIxZw7XZ45hiMUNDWMitB3sCClBD8g9jf6ZghQyF/Ov4P0ykVvxr6ZWk+kqFyeA4JehpHUGWw4qmuz85srQVj5Hf0NKzvD4saIRNTQGGf6qUSOHExx4qL89SQf736rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNv7AVqzYvwUDXkUCdeVPxWBFGE0i6lz/odQvhwaI6E=;
 b=TRijo6P5PDtL1cMtaQReedya6F+bNSRAa1DTpTu1ningIX2HzxwbHteh5QSu/tpNSa/M5xFNcOKUUA56U9E03cF/uHnZ1N8TA/2gZWVANiD88DZpyXJMQjs1yu9OsIf3eN0XnJ6FjuRnT8SX8GmgGXLa6Td20LXOKa2s04yqsEFn84hrJlB8tjZG1itdKwOj0925TliD2fJlBdG6JaSakNDcAn95kWSE45l5DzKOK4i1CAw6gWcN5DtezVsz+Zx120M4xJXMmSIINhZv5s3/ssPas35u1zHiNjNweZQWCu8Wg607haATIgEpX4abVwh3AW91MA+s7To/5jyLpyDasQ==
Received: from MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 12:28:46 +0000
Received: from MN0PR12MB6053.namprd12.prod.outlook.com
 ([fe80::3613:eed0:83aa:6997]) by MN0PR12MB6053.namprd12.prod.outlook.com
 ([fe80::3613:eed0:83aa:6997%7]) with mapi id 15.20.9388.003; Wed, 10 Dec 2025
 12:28:46 +0000
From: Asaf Penso <asafp@nvidia.com>
To: Kevin Traynor <ktraynor@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Shani Peretz <shperetz@nvidia.com>, Luca Boccassi <bluca@debian.org>
Subject: RE: New LTS maintainer?
Thread-Topic: New LTS maintainer?
Thread-Index: AQHcSPF3VL+U0UYzl0aU+lIDf067F7Ua8WMAgAAdtbA=
Date: Wed, 10 Dec 2025 12:28:46 +0000
Message-ID: <MN0PR12MB60533543EC745C2CA1ED6F62CDA0A@MN0PR12MB6053.namprd12.prod.outlook.com>
References: <356e655f-582d-4f67-8a36-c6284ec7c2d5@redhat.com>
 <5a74618a-0f23-4ddb-92a3-610054689b6c@redhat.com>
In-Reply-To: <5a74618a-0f23-4ddb-92a3-610054689b6c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6053:EE_|LV2PR12MB5848:EE_
x-ms-office365-filtering-correlation-id: 5e5fb172-29f6-4565-c0a5-08de37e7aa45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?aGUwb1FYMWVGK3YyWit3Mk1NSVMySDRxTW1RRXpwdjVFTWdWL2hrbEVGYlhM?=
 =?utf-8?B?UmNmN0lnV1NmZGNuV0xHdGhuNmliVjNaK2U0ZzQ4ZWg5akNjSkFQYjc2RU93?=
 =?utf-8?B?S2xIMHFtdDYwdHIzcURLUE9LY1h1WWt2Znk4TFJHcUVndk9hRWt6c1hqZCt3?=
 =?utf-8?B?eVFuUWQ0NXc1K2x1L2dhbzFnSnNpbDJDVGRUN2orYWphaW1JV09lK1J4UlZ2?=
 =?utf-8?B?RXNOSS83aTJZMGtvR1VQL25kc3ZubW9Pdmp3MFJ0eTNKRjJXU3czNkRCemYx?=
 =?utf-8?B?MTh2eE9qRGt0akYxVVlnN2RTdXc4WmprZzd1SFVDbnVlNXRMYVlEWVErTnpy?=
 =?utf-8?B?SllHWTRoUjM5SnpHQ2Z0Ujl6MFhkUUg0ZTJhcnVHT1l2K1FDSGpPVXlxV0Vm?=
 =?utf-8?B?bEtUalk2Z2VpL0c1RWZIdTlHSW9HOFBSUlkyUXhIU3B2VHVETU9oSlpmUjdo?=
 =?utf-8?B?RzZWZHdVNTcyT2dYaW9ZK3BMNnNIQ2lHQmZ5aUZJTUMvWFAxM0ZwaTVDYi9N?=
 =?utf-8?B?bUlkQWt0d1NiTDJlMEpTUmZYNFBQNEpVc3dkSjdHaGQ2Y25GNmp5Y1c3ZW41?=
 =?utf-8?B?UnhpOENmSVNhb0Nya0lGcThCUzFsOXdMNyt6MXZMc1A3UHpST0c2UDlHOWhq?=
 =?utf-8?B?UE1ITGhyRmt0STk5ZStZcXFrNGJOa0xNTGpPanNxcExESWhvRDRWOUxyZm1C?=
 =?utf-8?B?dlpYNmVzVGZaNWVUaU5TSjM2SnErTTg2YmtmK2wrTmdOcVo1Y1lnWnpMMSt6?=
 =?utf-8?B?cDdqaTJkZ3hYMmd2aGdjUFlpKzF2bjhNSVVJc2J0QjB3cTRuZTZseldCZFdj?=
 =?utf-8?B?V0QwWTNpUGYvYk5yK2F5NWJzKzFoMHpMdHV2dGlaVE9QQUxtcTUrMHNpWXlG?=
 =?utf-8?B?emJ3a290TGR5YWVNeVRPSndUc2lRMnJpV2wwekd0N2ZKVlpXMkhlRjE3QS9V?=
 =?utf-8?B?NUd2T0NTU1I4TkhqWFZWcGlNdVk1aWcveDAzMnBLWXBYWTV0VVFaNDJZSUpm?=
 =?utf-8?B?R0RlSFJNaTUwcGZuZVJvN09TeFZ3Z0czTk1OM01TU1VDMzZOK0pnQUJDT1gv?=
 =?utf-8?B?ZGpDSHFMWUVEYnk4VkxTS2lYaE00TWVPNW9FeWVZbkVPbWh3MHRJV2hUM042?=
 =?utf-8?B?dTZ6TVZ3c0pNcUNYMFozSXlVRmtwRVhEV3Y4VUdva21aaTIyRitSUHFtUnZq?=
 =?utf-8?B?bzlWbXY3aVlsM1Q4RHgrQjEvMzFNcUJ3NzRSOTFkQmhzeVFsVFBpRkN3Z2VF?=
 =?utf-8?B?TGxrVmZTNGpIMmR2Q2U3UmQ2elh5aGFKT3NXaHZqMXg4TlExVGltOFowR1RL?=
 =?utf-8?B?a2phUUlBRmZHTENBK0ZLbnQvdkhub0xMelYvUCtXbUt5K25iaXJ4bmIwOHdl?=
 =?utf-8?B?cXNIdERZWGI2M2lQLzhPR0VDQjRuV0hWR2JlWDlZYXRIei95Sy96d2dFRTZi?=
 =?utf-8?B?VzJnNW1yMVJxVURFQmdyT3N6dkpFcHp2UFBVelQ3NjQ4Q0FwREl5YzZVekZr?=
 =?utf-8?B?Nm9xRkxjS2NQbG1mL1R2UktFWmlscEw3aTQyOFhlcHNnL3hGYjdRd21ZQ212?=
 =?utf-8?B?K3pxdzdLbDlVR0VSMjlkOVNxQnBES1ROM1dCM3pFdFAvajM3T282TEF2WXlC?=
 =?utf-8?B?OG82bGRzc01yRFRIbkFnSlYxN0U0cmVzZWI1L0o0Qk5uYWZYYmQ4THZWdFVO?=
 =?utf-8?B?UDBWRGtMUW45R0hoUDM1bjB1cUF5ZDRVZXk0ZGo5WXo4L1ZLY1Z4OWxld0dI?=
 =?utf-8?B?YS8xUDE4Z2JMc1kyNDlOUXBjUFp5c3dMNlRQbU1haUhHczZaMzdpd2ltMG4v?=
 =?utf-8?B?SGVlNUxqdGtHdXhyYzB5bE52cUZoWWFVbFV5bERmVUplY0VYVmJmNlFJQkxl?=
 =?utf-8?B?eXVHcVZ0anBWTE5BZmhZR1Q0aDhjOHBqK2hxZFdEWVQrcVFmSU9LZ0NjVjFx?=
 =?utf-8?B?ZjhvQm1oVzhOUHZqNm1HclJMa1J0RTUvRUk0SmtaQ3lNd2tuTTBTakhBOFlD?=
 =?utf-8?B?QWd4VHlObmppSHkrbUhRODBMTTVwREJvNlBnRENIdTd1MTlTbzBpUmxGZU9s?=
 =?utf-8?Q?LYfQ+t?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6053.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGQyVEM2dkxRdXZ1S2hzbVZyWjc5QjViU2lRc2ZOZi9LbGc1TGozdG4vTzJj?=
 =?utf-8?B?eEdZS1R1UExqamk2WTVJeHBGbGlxbEp3aFVwZS90RW1VaDZuOFF3RjgyVy9B?=
 =?utf-8?B?SStQYW9UdFBFMGE5My94eklHeS9pVE51ME1pTDZBbE1ocHBFYVJMUkFQdlIw?=
 =?utf-8?B?c0NTQXZSMkkrNUNCVGR4V1dqTmsrdHljbGs3TWw0ZVpscU13TVBPb0g3SDVP?=
 =?utf-8?B?UmFIbnpjbXhsckx4U2htTXRRMzJMOFJvejNqa1NCZ29sSk1nUE1Damw4Ti9Q?=
 =?utf-8?B?U2Q2WXFYNjFReWVSUTd0c3B3QVpHRGFQeXFuS1pCeG9ud2piZlhRMzdHTDA2?=
 =?utf-8?B?TjRrbm1wMXlHeUZFOHNSUnNGYk45SFJvTVVsMnZud0oxQzE4d3AvNElaa24y?=
 =?utf-8?B?QU9DampXbjJrOHVnam5yeWMzV3FHOXgxRGdZekNxMTZ2RXdSQTQwWEpmcGhO?=
 =?utf-8?B?UWdocGdjekptVTFQUVNPUG9wcFdyVGlpQ0hNNGV4WEczWDA5cHhhcXZYd1dp?=
 =?utf-8?B?bk93VFRpVGpiRmMxTzJsUnVLU25OZW9kSU1haU1yYnlPekhCVnhRZWl1YUxi?=
 =?utf-8?B?cHJoNVNNVlo2OThTS3BwTTRFTkxHVlVrbytzZDFSZFJkdjhSTC9DM3liWEJn?=
 =?utf-8?B?ZkxlWjU1cEZsb1V3RUVDa1NqN3NYRWRTWEtRSlN5c1YvbGtkYXcvSnZnTkVp?=
 =?utf-8?B?UVFBZHRFVGZubUdpbzhQQVAyM0srMnl3V0c5M21VVEg5QVZwbHZlVU1hU0ti?=
 =?utf-8?B?VmIwR2ZWZDZSR0hmL21WMFhXcDM5TWxZSHh2YjMza1ZjSmh1VkxIM1lXSGt2?=
 =?utf-8?B?amtjS3FPV1JGc1FYK3pYMlovdHZGNzBUS2drSTNBcVM1Rjc2dmtNcE82YytZ?=
 =?utf-8?B?M0d2WWJtb2N3THZ1MEdlRktnLzMxZGtzb1QvYWVqNmdtZCsyMkNXaFVEN2lm?=
 =?utf-8?B?WjF4SXRrdHFiK3RrQlBKbVhoelU3ZDRramROM0lMVW4rdGs3REpKaTN5aTB6?=
 =?utf-8?B?VjNnVk1WQVFCdzdPQ0tHc21jMldYUFcrbkdNa1VqRENTOFVQNVZCVVZ5aTJJ?=
 =?utf-8?B?UXAxNjdLcHlDclkxUTBoN2Y5ZjhzSXo1K3B1Zml6ZHVKdFExcDZyMHRqcjRl?=
 =?utf-8?B?Z1AxMEwrcGxpblVZdkNRbXIxMk1GT3c0dVpHdm1sQ1JIUU5YTGpCWHFjdnlS?=
 =?utf-8?B?QmgvRkN6R2NnNWlZSHhFV2Q2WjdBakxuOURmQ05IVzE5NlJZTlVwZW55ekc2?=
 =?utf-8?B?MERoR2Qxcm9ydFlmQjgwZXkvbHgvQWg4Uy9mUDBkTWtaNytneFpBSUpHMWcr?=
 =?utf-8?B?RGRGVXV0SzNHTVV6S2Y4dlpsZ05DWjRmK29RWm1RTldwWWE5a3pScm9KQVB0?=
 =?utf-8?B?eDNCbXd5TWozT1BrWUtHb0ZJc05iMHNVVGdvSE1xNmVOS1BCbldrOXZyaU5N?=
 =?utf-8?B?d1pKSFh4SmJpRm5JNFpnT2V5YW5TNlhkMDJlS0pQR2txb2c4R2ZnTGdCWHhQ?=
 =?utf-8?B?MllQR0R4SUdjTlBhd0c0eGlucjB1ZCtxbDVFZ3VxTWJSaGw1Q1NIcERiNlY2?=
 =?utf-8?B?VmtYRit5Z1BKeWNpaUFaOExQKzhKUVlNbWtYOWNvR2NPMzljSGxvUnJMU3hQ?=
 =?utf-8?B?L2MrZlBJdWxIV1ZyQXU3dzREU0crZjFQZ1h2NmQzQWYzdjhoSFpja1d1TGhJ?=
 =?utf-8?B?WW1CcnpNQUpUSXBmT1JuRWR0YXc1SlEyWGpHcFUrbTB0MGg2TDMrS3gzVWpX?=
 =?utf-8?B?TnZKNnJVYkg1TnAwSlI0V3huZWtmVDZvb3ZaOEptb2Mwa1d2TlpDMnkyWGNa?=
 =?utf-8?B?cjQ2cG9QWUY5Mm03enMyVDN0cksyNU9HQlFDS2MweTlZTW12ZXZGcStFL2Jw?=
 =?utf-8?B?cEJaRHpmZCt5OTF2cEhPMnNMNkxzZGdBb0lVSHpsVk9WZzhRdVdjVVV4VVcz?=
 =?utf-8?B?amppTWZRdjh0YXJUWHZseU9WcDkwVGFjcHZ4U2NVQm0rdUhIY2VKZjhzblBv?=
 =?utf-8?B?V091Y2JUVmtmSGhIekZSVGxPeSs2TUdlcmgwRjI5VXk1cjcyenhKeVJxbDFH?=
 =?utf-8?B?cTY1NTIrZytzWS8rNEZXd3N3bENRdXY2WXNzZllyanRYU3E3VDVCRXljVTdz?=
 =?utf-8?B?V3VDQmtHQU5LWGF3SDFoNXp2WlFqNUtXazVNU2dxUDRsY255N1llbDRjWGJC?=
 =?utf-8?Q?YTkOuFLQAafQuz3g5zFLx0vXmA5hZXUEj6nDrYzVCCNg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5fb172-29f6-4565-c0a5-08de37e7aa45
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 12:28:46.6801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZ/lg508hAMoweBkG+FJJfsJ2D7FG+p7T7kMJLg2mgo9v5dxiiT2ai208on811cKKfuOel3634xVqd+IcTII2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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

R29vZCBsdWNrIFNoYW5pIQ0KDQpSZWdhcmRzLA0KQXNhZiBQZW5zbw0KDQo+LS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBLZXZpbiBUcmF5bm9yIDxrdHJheW5vckByZWRoYXQuY29t
Pg0KPlNlbnQ6IFdlZG5lc2RheSwgMTAgRGVjZW1iZXIgMjAyNSAxMjo0Mg0KPlRvOiBkZXZAZHBk
ay5vcmcNCj5DYzogU2hhbmkgUGVyZXR6IDxzaHBlcmV0ekBudmlkaWEuY29tPjsgTHVjYSBCb2Nj
YXNzaSA8Ymx1Y2FAZGViaWFuLm9yZz4NCj5TdWJqZWN0OiBSZTogTmV3IExUUyBtYWludGFpbmVy
Pw0KPg0KPk9uIDI5LzEwLzIwMjUgMTY6MzAsIEtldmluIFRyYXlub3Igd3JvdGU6DQo+PiBIaSBB
bGwsDQo+Pg0KPj4gdGw7ZHIgd2UgYXJlIGxvb2tpbmcgZm9yIGEgbmV3IExUUyBtYWludGFpbmVy
Lg0KPj4NCj4NCj5BIGJpZyB0aGFuayB5b3UgdG8gU2hhbmkgUGVyZXR6IG9mIE52aWRpYSB3aG8g
dm9sdW50ZWVyZWQgYW5kIHdhcw0KPnVuYW5pbW91c2x5IGFwcHJvdmVkIGFzIHRoZSBuZXcgTFRT
IG1haW50YWluZXIgZm9yIDIzLjExIGF0IHRoZSAxMnRoDQo+Tm92ZW1iZXIgdGVjaGJvYXJkIG1l
ZXRpbmcuDQo+DQo+PiBXZSBoYXZlIDMgbWFpbnRhaW5lZCBMVFMgcmVsZWFzZXMgYW5kIGEgbWFp
bnRhaW5lciByZXNwb25zaWJsZSBmb3INCj4+IGVhY2ggb25lIGFzIGxpc3RlZCBhdCBodHRwczov
L2NvcmUuZHBkay5vcmcvcm9hZG1hcC8jc3RhYmxlIC4NCj4+DQo+PiBYdWVtaW5nIGhhcyBkb25l
IGEgZ3JlYXQgam9iIG1haW50YWluaW5nIDIzLjExIExUUyB1cCB0byBub3cgYnV0IGlzDQo+PiBz
dGVwcGluZyBkb3duIGFzIG1haW50YWluZXIgZHVlIHRvIGNoYW5naW5nIHdvcmsgcHJpb3JpdGll
cywgc28gd2UgYXJlDQo+PiBsb29raW5nIGZvciBhIG5ldyBMVFMgbWFpbnRhaW5lciB0byB0YWtl
IG92ZXIgMjMuMTEgZm9yIGl0J3MgZmluYWwNCj4+IHllYXIgYW5kIGEgYml0Lg0KPj4NCj4+IFRo
ZSBtYWluIGl0ZW1zIHRoZSByb2xlIGludm9sdmVzOg0KPj4gLSBHZXR0aW5nIGEgbGlzdCBvZiBm
aXhlcyBmcm9tIG1haW4gYnJhbmNoIHRoYXQgc2hvdWxkIGJlIGJhY2twb3J0ZWQNCj4+IHRvIHRo
ZSBMVFMgYnJhbmNoIGFyb3VuZCB0aW1lIG9mIGEgbmV3IERQREsgcmVsZWFzZQ0KPj4gLSBCYWNr
cG9ydGluZyB0aGUgZml4ZXMgdG8gdGhlIExUUyBicmFuY2gNCj4+IC0gUmVzb2x2aW5nIGFueSB0
cml2aWFsIGNvbmZsaWN0cyAoYW5kIGNvbXBsZXggb25lcyBpZiB5b3Ugd2FudCkNCj4+IC0gTm90
aWZ5aW5nIGF1dGhvcnMgb2YgZml4ZXMgdGhhdCBjb3VsZCBub3QgYmUgYmFja3BvcnRlZCBhbmQg
cmVxdWlyZQ0KPj4gdGhlaXIgYXNzaXN0YW5jZQ0KPj4gLSBOb3RpZnlpbmcgYXV0aG9ycyBvZiBm
aXhlcyB0aGF0IGFyZSBxdWV1ZWQgdG8gbWVyZ2UNCj4+IC0gRW5zdXJpbmcgdGhhdCBDSSdzIGFy
ZSBrZXB0IGdyZWVuDQo+PiAtIENyZWF0aW5nIHJlbGVhc2UgY2FuZGlkYXRlcyBmb3IgdGhlIHZh
bGlkYXRpb24gdGVhbXMNCj4+IC0gV29ya2luZyB3aXRoIHZhbGlkYXRpb24gdGVhbXMgYW5kIGF1
dGhvcnMgdG8gZ2V0IGEgcmVzb2x1dGlvbiBmb3INCj4+IGFueSBpc3N1ZXMgdGhhdCBhcmUgZm91
bmQgZHVyaW5nIHRlc3RpbmcNCj4+IC0gV3JpdGluZyB1cCByZWxlYXNlIG5vdGVzIGV0Yy4gYW5k
IHJlbGVhc2luZw0KPj4NCj4+IFdlIGhhdmUgbWFueSBzY3JpcHRzIGFuZCB0cmlja3MgdG8gaGVs
cCBzZW1pLWF1dG9tYXRlIHRoZSBzdGVwcyBhYm92ZS4NCj4+DQo+PiBMdWNhIGFuZCBJIHdpbGwg
Y29udGludWUgYXMgTFRTIG1haW50YWluZXJzIHNvIHdlJ2xsIGJlIGF2YWlsYWJsZSB0bw0KPj4g
aGVscCBzb21lb25lIHJhbXAgdXAgYW5kIG9ubHkgYSBwaW5nIGF3YXkgZm9yIGFueSBpc3N1ZXMu
DQo+Pg0KPj4gSWYgYW55b25lIGlzIGludGVyZXN0ZWQgcGxlYXNlIHNlbmQgbWUgYSBwcml2YXRl
IGVtYWlsIHJlcGx5IGJ5IE5vdg0KPj4gN3RoIGFuZCB3ZSdsbCBwcm9wb3NlIGNhbmRpZGF0ZXMg
dG8gdGhlIHRlY2hib2FyZC4NCj4+DQo+PiB0aGFua3MsDQo+PiBLZXZpbiBhbmQgTHVjYS4NCg0K
