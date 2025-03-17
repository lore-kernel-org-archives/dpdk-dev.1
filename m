Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1598EC282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 10:47:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCED9402D1;
	Mon, 17 Mar 2025 11:47:58 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by mails.dpdk.org (Postfix) with ESMTP id 1FD16402BB
 for <dev@dpdk.org>; Mon, 17 Mar 2025 11:47:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nv+nSQtodocTwmAKzW+2UTnzbSMcq/tB0FYuWV+lbGa54gHBfQvlYFCrBbKmKN0IP0SJXz2Z0otxZLMmsz6lQQDHbwxJ++CNaYcJhw2RZqwKVr8quhf5k4dKQL5egur9nxfxHkQIJ4a2AYARQ2KN8I5XMgoVxHyd7/MLYB0vIKM8GouaLBy1eXm2I97dqQOpmzslP8d/p8uWX9eejmjgGmV2SrU+U2aTo5u6NfrQEugtNWq2j6Mn3d/GevcPz0ownd/Ub+SwV3iNfu5o7sj9rb43z1ZYVctlBw/KiDUvWEJ0Fa3DGhbtPo335lDeBIXoibw76jkB6duVmTKVkkpdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tChy9eDL/+R0zBjCgYXuSm1nTbk5NwM12ZN1+B38+H8=;
 b=dDWPPXq/CV6PB3nAqLyqwN/MNUhmkrofeAq1/HwooP01dRnCNPRCKR9Z27y+a33AYxFmHjApyXYvJkj2SwWB+RacrdRQMUMEGE02xhF+f5t7jIyM81QfMKY4RpE4qVcxrRyVIx4Zp3fnYvkJe/zmX1OhDaeT1iJTd62dG9T/4qu7xjebez+NBsCvdpvvg9SzQWgWuI4cuNLgV6NOB2b6nliyek9293p+3KyS50apS1oPyrdER2yNY1spIgRUlHyyQbb3X4u773MHkJuz0faTA3ew5lOMBP2zCSEN3bP/M8KYGjSzDusR1UxIM/CMiMu4A51EZMx+Vse0Asxykko1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tChy9eDL/+R0zBjCgYXuSm1nTbk5NwM12ZN1+B38+H8=;
 b=sw29eAJoR4PTzeuXLE+GlytLA2Ir8E1cklC/Wl2+TmwDdbG32vYdKX8es/Hplg/7xdG7THmjpEXDScI83y64TcbDMzeE/H58xLpj4dY4hK25kyWp66mtdW+IJGcUiFyAr0wpJtELLKAvREGFWVXpnmEYgIXqh39wwM1LZ23gaYJECApnrMQRzeT+UUdqda5Wjk9tH/B9ulQxDpYIRanxWOFcYSOsPCbRaXsRYPyvSIwvfV6OejU+nxEj9opYJTHUOt6gcnzjXsoayY12W6gYzanHTH8MZk9RXCS8L03n0V405JuidrjCeNptkQCHCS9XheoES9O3BTwhu2WcPi1AKA==
Received: from SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 10:47:54 +0000
Received: from SA3PR12MB8762.namprd12.prod.outlook.com
 ([fe80::4d77:2c63:4aad:8caf]) by SA3PR12MB8762.namprd12.prod.outlook.com
 ([fe80::4d77:2c63:4aad:8caf%6]) with mapi id 15.20.8511.031; Mon, 17 Mar 2025
 10:47:54 +0000
From: Matan Azrad <matan@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maayan Kashani <mkashani@nvidia.com>, Raslan Darawsheh
 <rasland@nvidia.com>, Michael Baum <michaelba@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>
Subject: RE: [PATCH 1/2] common/mlx5: add device duplication function
Thread-Topic: [PATCH 1/2] common/mlx5: add device duplication function
Thread-Index: AQHbk/K85dNJ1vlvEkeI2xr8xQaJ4bN3LAxQ
Date: Mon, 17 Mar 2025 10:47:54 +0000
Message-ID: <SA3PR12MB8762821F93E85C58DAE30DF5DFDF2@SA3PR12MB8762.namprd12.prod.outlook.com>
References: <20250313083351.25559-1-getelson@nvidia.com>
In-Reply-To: <20250313083351.25559-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR12MB8762:EE_|DM4PR12MB6010:EE_
x-ms-office365-filtering-correlation-id: 9e2b7e94-2fbb-47f4-0312-08dd65412c39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VlIzTEcvajVSMzIwc0pKUzNDZFh1UDR3RTVNbzkrNmVpd2lvOTZqZ25ZTlNS?=
 =?utf-8?B?T0RYMEpXL1EvMVFTcUFFVU4xN2xqQmpkWHNiTkQrVHZ4UlplSnRlMlZGOTlI?=
 =?utf-8?B?ODN3NUl4cGtra3Rtd1M3azNFc3NCekJwT0h4SmMrT3ZhdFdWYjZ2VXZ1WVEy?=
 =?utf-8?B?ZHhyUGUwV0d0SUpSWUVYYnJ2UzA3V1VvVFRXZjIrVW12Q0l6ZkRwNGppSzJD?=
 =?utf-8?B?L1kyZU5oUmFKSVAyeWtZSmU0SEZ3Wm9WOXcxWnBSTDBkak9OcTNjY3VtNjV2?=
 =?utf-8?B?UVhManMvcW5oRnp2TUVFZjJCYk1Yc2hCclB1NkJKMWdaZktZUUdPaHJMdXR3?=
 =?utf-8?B?OVJ5elEyTUdmejNzMXBSTXc0d2pRSjZwYkFid1dKVksvTXNadDF0eHVPdWZI?=
 =?utf-8?B?SzdjR3BjNWRLQVE3NVgza1NqMVVCS21INW5vMjFVdTdJVmZDTXlodzhUK1p5?=
 =?utf-8?B?RTZ2OGFiTE1CT2d1U1ptcGJHeTVUYnJ3MjVOYlFPZjJtVjBMNEFGcFF2MlVP?=
 =?utf-8?B?WHRyaW50SWlaMzRhR3hyeUhKb1kzeG9HbTFlRTY5VExWMEo2ZWZaSWFhTnNX?=
 =?utf-8?B?UWNyWkZXTGJpb2VUVDhZNWc3bVE2QTVpd2p5M25EK3VURHVIZ3kzOGwrWGJz?=
 =?utf-8?B?eUU5U2U2QndNUEgvUzN6aXppVXN4UUJJR1VVU0h6SU91ck5zQy9WSDFKTzRt?=
 =?utf-8?B?MElnTkU4b05CY2xEMzRIY25CUVJhTldvR1lsaUVVWnBrcVl1M1FtTldpZ0dI?=
 =?utf-8?B?THk0eWxVcTZhTmhvbTZ4VWNPdTFVZUlHcE1ZV01PeXBVdTNVcVlxUGRvL05p?=
 =?utf-8?B?NC9XSnJXbm1ZZmxEenFtbnB6VEpSSUxXdDVKZTdzUjdwM2RvVGM2NjBrZXZp?=
 =?utf-8?B?eEpxRXltK0o4Y0FMVms2VWRUTkVjOC92K0x4MXljNmJid2xPZWN3NmFUZSs5?=
 =?utf-8?B?RG13cXdxQ0xZMVpBUTc2aStyU29OZnVEV1JIcDVxTnByRUtFT1hMMTBxNHdu?=
 =?utf-8?B?dGhjcHJzNC91VXdIMUU3Wm9XNFNTVGVsaHZxQy92aUJ3QVp2bnhLZENDSlFP?=
 =?utf-8?B?R2NkWHBxSGZsVGZER0JqMHJtMW81aFdIek15eDNtRE01ZDZkQVlLc1dOK0No?=
 =?utf-8?B?cCtzNG1pejBTa2FDQXA5L3RPL1ZRSWRYK1dkSkpVVGliczJGN1dXbUNMUUJi?=
 =?utf-8?B?K3ZkQWV4dHF0cmZUTytKNlZhM2t0Zm5hTkNKYzRSZldxTFVUcDE1dUJYT2s0?=
 =?utf-8?B?a0EwQjVTSUV0c0lyd29wbThTZHFiYWY5d1FBejVMTTVkVHpRUVdrYVF3QjZh?=
 =?utf-8?B?MmFab1lJSGovUlY4WVljaFIyQXllUkRWbTV4M1I1S3hmVWYwdGRzYnViL2Ir?=
 =?utf-8?B?VTJYaTVMUnhoTHRLUXdtaG83Q1dhd0ZFY3JTRXhBclNoNVlpOExlV3RsWTFo?=
 =?utf-8?B?WEowS3VGS1JlT2p0TVVOT0ZQVUdKVWQzL3c3Z3dMVDhicjdoQzU4dGh2bFZj?=
 =?utf-8?B?ekExVldveTM3WUowaWVSa0o2ZU1IWEQzeGlvcEh2V2VXSFpzUnZEMkFGZGhG?=
 =?utf-8?B?SDNMNWNWV2NFVTdYSTI3a3Q0UnBIekoraHA2OVdPM0VXOXh0MTdlM0gydjFo?=
 =?utf-8?B?dW1xdzBqZnRQM1Y3bkpnY0prcFRCYnFkamFUNEdLRnFoRlVBUGI2YXNSaGN0?=
 =?utf-8?B?WnlLWlhVaWVEUVMzTTB0WDFlYXFCRlB4T0tCbUQyMTkzb1lUWEl6ODB3T2c1?=
 =?utf-8?B?Tmd2Z2t3SEc2ZFQwTkpReTYwWC9WdXJVZ1ByK2htQ0Z4UTlPRGlMUVF0OTky?=
 =?utf-8?B?ZytISlg0YUhzS3E0RFg3TlBSbEJJYmRhcjJ6V3ZPWVNGWHlsNTAvV0toL3RK?=
 =?utf-8?B?b1B0eEsxUmpVeG1lL0NrQXFSMXF6bktxbERRakd0Y3ZIN1VQampTYjdZTjlu?=
 =?utf-8?Q?0K22uNdYzntfDBc9jV4IvkJb9TreXpmV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB8762.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkRmbVIwSVcrc3J1T2VneG1uTWJPcEswUzVhVm53aEZYamkxK2ZwV0o3aHJr?=
 =?utf-8?B?R3ExUmJveEsvUWU5QnVBR3lvZXd2OStJOUV4NUxBNmhCbnIxTHZpWmVUM05Q?=
 =?utf-8?B?MG9BajR2R2ZnWFViR3FTMjhaWjNwQmFLR1VKbVVUbGNUWXl3ajl1NU5zOG9X?=
 =?utf-8?B?d05ickt2MGFBeHUwVG8wc0MwTkRTeFRyZEpRRSt4eFNPTHpaMHhsSG5KSElr?=
 =?utf-8?B?aks2WEZ5bmJVL0pzbUtGLzBETWttYnFZUDZ0WDFkYTB5ZmVoY0hpZUVkbFI0?=
 =?utf-8?B?djdTYnpvVW5iWERGMXNMMGhyYjFQbWV6R01maU16SjlFUk10eHpybXFZQ0ty?=
 =?utf-8?B?YUdUVElFTmNBSVcyMlF2M1R4MXBzVC9jOFpvNmRETFdIN3dHbkRPa1JRaWtm?=
 =?utf-8?B?SDdzQmx1U3FtdXN2ODlYM2x2N3o2OVMwTCtvY0tOdVBvZDZwcnpNb0l3aTVQ?=
 =?utf-8?B?WDloKy9TV2pzQ1V4Rk13cy9FT21jOUxidWxGM0dDNUJqaytlMVdOVDdvYnJD?=
 =?utf-8?B?UlJjR08yeTRzNldpU0UzQW5OMGloSXZBZUNKbXR4Q2dZUENYUzhFS1d2ZWxE?=
 =?utf-8?B?TjVMSm1lVHNxbnViR3pkZ0psN2xUZWcxUkxLNUk2OE5NdktRNTgxZWhQUVND?=
 =?utf-8?B?Mkc0T0xHbDk3WVZQTUNjYjhWV3Z0WE9VRkFVcTBianc3NUhRbmQ2UjRZc3I1?=
 =?utf-8?B?dkVIQVBXR21vZVlVNXRlYTdWNTdSYzhUNi8vemFtTTlDWC9TM1lZcTRFcFRI?=
 =?utf-8?B?bjQ5ekFrYUpVSlE5Nkp3eTNLOFlteGxFR2w0OFl1VmVyYktaOGQrVTk0d1JS?=
 =?utf-8?B?ZzVoRVZiMmMxbVB5K3Ayc3Z4NENwdnZSVE9NTSs0REE1blpKS29ybFEzSUdY?=
 =?utf-8?B?THpKcVNsUCtndXRYSTgyVUVuTitPd05NYXF0eVF6RExRT3h2V3Ixd2FzL0tz?=
 =?utf-8?B?STVJMC9Tc2VPWStxWHpyb1dzOUlKU0JoSlNRMUdKbFlFdHFTNTRLamdFdTEw?=
 =?utf-8?B?eXFHUWk3OWpXbXdhbFd4aHZnb1JuODhmZllmYmlZakpGZjJOSU1oRWZhcXRI?=
 =?utf-8?B?WTlWUnNNVGdUTU1YSkd4aWNiZWlhWjE2NUdJRkNvSGl4U0ltbGFXbU5TanJm?=
 =?utf-8?B?c0dLVHlBUVBFTFdPeGJ3Z253cmk5RUlndXdobGkvZWtCSGdTZEQ0Kys0R3Mw?=
 =?utf-8?B?cVVPaGJ6d1R5T2JkYnp0WTF2Q3k5OXdoT3hqbGRHL0xIV0FJaEdrKzQwOXMx?=
 =?utf-8?B?ZHBkRmEwRzNEMTkyZ1VXNEpLcmxmU2o2VWp0SU5obldKU2Z4aG1jazBaTFJE?=
 =?utf-8?B?MmpQQW14VTZUSGZIZWZ0T1M5QVFSTURTdUgvRGpnUDVweWhWRXpxYjgwQ2VG?=
 =?utf-8?B?VW5nUk5PSytpREZaeWpiZUp2ZUFYbDRuT1o3Q2JvVXRDaXhjL0JZMklDbGFX?=
 =?utf-8?B?Vk9TSkc1ODNjOVd3Ukh1Ty9TbXdCRTQrdC96RUdKVk1ZQmhSYzBzNWlRU0VQ?=
 =?utf-8?B?RkUzM0psbVh5V09OVnZxVEpkbnVGOXhibnBsbmFIWmNneU5SZ3JLVUhmR3F0?=
 =?utf-8?B?UEh2bzRpSjNpZ1Q2L0ttUkFsb3B3U01LUU55T29NWkdCcFF1YnZ4WU5GS3Rn?=
 =?utf-8?B?bDF5N2hWcHZGM0F1NG5LL3QvZStRQjAvQTlRL2N0bDg3bWlIVzByUFRkV1NQ?=
 =?utf-8?B?QmRQR0MyWjAwb3F5WXNaWnJrbStkaUhkblFnMjNBT0hYK04yZEp3UUhnNThR?=
 =?utf-8?B?VERTaFowVXNFSGpxK00valZuR05oVkUvRVd0Z0NsMUhKdDJkTDJwQkt6bE5v?=
 =?utf-8?B?OUpyamptN3dwbDFiUFYzaXZIa3hNMXo0V2xhRU04Zm9JdzdlWFI5TXJPdXAx?=
 =?utf-8?B?alJjQW44cWhvQzlncUJIZDNIcHBMWXE5a1VEdUdOem4yMkRkR2QxL2x2Nkw3?=
 =?utf-8?B?SStXaEF2NGQwc0dUZXJQNFdid2hBMnMwY0JubVRmS3FJdXcwb2I1RG82dWw2?=
 =?utf-8?B?amJpYW00S1lqN2xza3hwckZacmc3T05BR1V6cDB3dldNT2s3a25oRVpBNHpO?=
 =?utf-8?B?ZmoyM3hWeGV3bnBBZEhLQ2hkMWszTk9jNHNLN3RWRTZYTXJBdnp4cEFhMStS?=
 =?utf-8?Q?nLIw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2b7e94-2fbb-47f4-0312-08dd65412c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 10:47:54.5596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hvEBlu6TntagCdLnE7niU7mMLknYQDUNohKaOvPimJGHaUzuxrWdlEbUcVVd30syLRTjI61mXy1xPLj/1GZ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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

DQoNCj4gRnJvbTogTWljaGFlbCBCYXVtIDxtaWNoYWVsYmFAbnZpZGlhLmNvbT4NCj4gDQo+IEFk
ZCBmdW5jdGlvbiBmb3IgY3JlYXRpbmcgYWRkaXRpb25hbCBDVFggZm9yIHNhbWUgZGV2aWNlIGJh
c2Ugb24gZXhpc3RpbmcgQ1RYLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBCYXVtIDxt
aWNoYWVsYmFAbnZpZGlhLmNvbT4NCkFja2VkLWJ5OiBNYXRhbiBBenJhZCA8bWF0YW5AbnZpZGlh
LmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9jb21tb24vbWx4NS9saW51eC9tbHg1X2NvbW1v
bl9vcy5jICAgfCA1Mg0KPiArKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9jb21tb24v
bWx4NS9tbHg1X2NvbW1vbi5oICAgICAgICAgICAgfCAgNCArKw0KPiAgZHJpdmVycy9jb21tb24v
bWx4NS92ZXJzaW9uLm1hcCAgICAgICAgICAgICAgfCAgMSArDQo+ICBkcml2ZXJzL2NvbW1vbi9t
bHg1L3dpbmRvd3MvbWx4NV9jb21tb25fb3MuYyB8IDMxICsrKysrKysrKysrKw0KPiAgNCBmaWxl
cyBjaGFuZ2VkLCA4OCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
b21tb24vbWx4NS9saW51eC9tbHg1X2NvbW1vbl9vcy5jDQo+IGIvZHJpdmVycy9jb21tb24vbWx4
NS9saW51eC9tbHg1X2NvbW1vbl9vcy5jDQo+IGluZGV4IDQxMzQ1ZTE1OTcuLjJmNTAzMmYwZGEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY29tbW9uL21seDUvbGludXgvbWx4NV9jb21tb25fb3Mu
Yw0KPiArKysgYi9kcml2ZXJzL2NvbW1vbi9tbHg1L2xpbnV4L21seDVfY29tbW9uX29zLmMNCj4g
QEAgLTg3Myw2ICs4NzMsNTggQEAgbWx4NV9vc19vcGVuX2RldmljZShzdHJ1Y3QgbWx4NV9jb21t
b25fZGV2aWNlDQo+ICpjZGV2LCB1aW50MzJfdCBjbGFzc2VzKQ0KPiAgCXJldHVybiAwOw0KPiAg
fQ0KPiANCj4gKy8qKg0KPiArICogQVBJIGZ1bmN0aW9uIHRvIG9idGFpbiBhIG5ldyBJbmZpbmlC
YW5kIChJQikgY29udGV4dCBmb3IgYSBnaXZlbiBjb21tb24NCj4gZGV2aWNlLg0KPiArICoNCj4g
KyAqIFRoaXMgZnVuY3Rpb24gcHJvdmlkZXMgYSBwb3J0LWFnbm9zdGljIElCIGNvbnRleHQgZm9y
IGEgcGh5c2ljYWwNCj4gK2RldmljZSwgZW5hYmxpbmcgdGhlDQo+ICsgKiBkZXZpY2UgdG8gY3Jl
YXRlIGFuZCBtYW5hZ2UgcmVzb3VyY2VzIHRoYXQgY2FuIGJlIGluaXRpYWxpemVkIHdoZW4gYQ0K
PiArcG9ydCBzdGFydHMgYW5kDQo+ICsgKiByZWxlYXNlZCB3aGVuIGFub3RoZXIgcG9ydCBzdG9w
cy4NCj4gKyAqDQo+ICsgKiBGb3IgTGludXgsIGl0IGltcG9ydHMgbmV3IGNvbnRleHQgZnJvbSB0
aGUgZXhpc3RpbmcgY29udGV4dC4NCj4gKyAqDQo+ICsgKiBAcGFyYW0gY2Rldg0KPiArICogICBQ
b2ludGVyIHRvIHRoZSBtbHg1IGRldmljZSBzdHJ1Y3R1cmUuDQo+ICsgKg0KPiArICogQHJldHVy
bg0KPiArICogICBQb2ludGVyIHRvIGFuIGBpYnZfY29udGV4dGAgb24gc3VjY2Vzcywgb3IgTlVM
TCBvbiBmYWlsdXJlLCB3aXRoIGBydGVfZXJybm9gDQo+IHNldC4NCj4gKyAqLw0KPiArdm9pZCAq
DQo+ICttbHg1X29zX2dldF9waHlzaWNhbF9kZXZpY2VfY3R4KHN0cnVjdCBtbHg1X2NvbW1vbl9k
ZXZpY2UgKmNkZXYpIHsNCj4gKwlzdHJ1Y3QgaWJ2X2NvbnRleHQgKmN0eCA9IE5VTEw7DQo+ICsJ
aW50IGNtZF9mZCA9ICgoc3RydWN0IGlidl9jb250ZXh0ICopY2Rldi0+Y3R4KS0+Y21kX2ZkOw0K
PiArCWludCBuZXdfY21kX2ZkOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBEdXBsaWNhdGUgdGhlIGNv
bW1hbmQgRkQgdG8gcGFzcyBpdCBhcyBpbnB1dCB0byB0aGUgaW1wb3J0IGRldmljZQ0KPiBmdW5j
dGlvbi4NCj4gKwkgKiBJZiB0aGUgaW1wb3J0IGZ1bmN0aW9uIHN1Y2NlZWRzLCB0aGUgbmV3IGRl
dmljZSBjb250ZXh0IHRha2VzDQo+IG93bmVyc2hpcCBvZg0KPiArCSAqIHRoaXMgRkQsIHdoaWNo
IHdpbGwgYmUgZnJlZWQgd2hlbiB0aGUgbmV3IGRldmljZSBpcyBjbG9zZWQuDQo+ICsJICogSWYg
dGhlIGltcG9ydCBmdW5jdGlvbiBmYWlscywgd2UgYXJlIHJlc3BvbnNpYmxlIGZvciBjbG9zaW5n
IHRoaXMgRkQuDQo+ICsJICovDQo+ICsJbmV3X2NtZF9mZCA9IGR1cChjbWRfZmQpOw0KPiArCWlm
IChuZXdfY21kX2ZkIDwgMCkgew0KPiArCQlEUlZfTE9HKEVSUiwNCj4gKwkJCSJGYWlsZWQgdG8g
ZHVwbGljYXRlIEZEICVkIGZvciBJQiBkZXZpY2UgXCIlc1wiOiAlcyIsDQo+ICsJCQljbWRfZmQs
IG1seDVfb3NfZ2V0X2N0eF9kZXZpY2VfbmFtZShjZGV2LT5jdHgpLA0KPiArCQkJcnRlX3N0cmVy
cm9yKGVycm5vKSk7DQo+ICsJCXJ0ZV9lcnJubyA9IGVycm5vOw0KPiArCQlyZXR1cm4gTlVMTDsN
Cj4gKwl9DQo+ICsJLyogQXR0ZW1wdCB0byBpbXBvcnQgdGhlIGR1cGxpY2F0ZWQgRkQgdG8gY3Jl
YXRlIGEgbmV3IGRldmljZSBjb250ZXh0Lg0KPiAqLw0KPiArCWN0eCA9IG1seDVfZ2x1ZS0+aW1w
b3J0X2RldmljZShuZXdfY21kX2ZkKTsNCj4gKwlpZiAoIWN0eCkgew0KPiArCQlEUlZfTE9HKEVS
UiwgIkZhaWxlZCB0byBpbXBvcnQgSUIgZGV2aWNlIFwiJXNcIjogJXMiLA0KPiArCQkJbWx4NV9v
c19nZXRfY3R4X2RldmljZV9uYW1lKGNkZXYtPmN0eCksDQo+ICsJCQlydGVfc3RyZXJyb3IoZXJy
bm8pKTsNCj4gKwkJY2xvc2UobmV3X2NtZF9mZCk7DQo+ICsJCXJ0ZV9lcnJubyA9IGVycm5vOw0K
PiArCQlyZXR1cm4gTlVMTDsNCj4gKwl9DQo+ICsJRFJWX0xPRyhJTkZPLCAiSUIgZGV2aWNlIFwi
JXNcIiBzdWNjZXNzZnVsbHkgaW1wb3J0ZWQsIG9sZF9mZD0lZCwNCj4gbmV3X2ZkPSVkIiwNCj4g
KwkJbWx4NV9vc19nZXRfY3R4X2RldmljZV9uYW1lKGNkZXYtPmN0eCksIGNtZF9mZCwNCj4gbmV3
X2NtZF9mZCk7DQo+ICsJcmV0dXJuICh2b2lkICopY3R4Ow0KPiArfQ0KPiArDQo+ICBpbnQNCj4g
IG1seDVfZ2V0X2RldmljZV9ndWlkKGNvbnN0IHN0cnVjdCBydGVfcGNpX2FkZHIgKmRldiwgdWlu
dDhfdCAqZ3VpZCwgc2l6ZV90DQo+IGxlbikgIHsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvY29tbW9u
L21seDUvbWx4NV9jb21tb24uaA0KPiBiL2RyaXZlcnMvY29tbW9uL21seDUvbWx4NV9jb21tb24u
aA0KPiBpbmRleCBlN2JkNGM2ZWM0Li5iZWExMzgyOTExIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2NvbW1vbi9tbHg1L21seDVfY29tbW9uLmgNCj4gKysrIGIvZHJpdmVycy9jb21tb24vbWx4NS9t
bHg1X2NvbW1vbi5oDQo+IEBAIC02NTEsNiArNjUxLDEwIEBAIG1seDVfZGV2eF91YXJfcmVsZWFz
ZShzdHJ1Y3QgbWx4NV91YXIgKnVhcik7DQo+IA0KPiAgLyogbWx4NV9jb21tb25fb3MuYyAqLw0K
PiANCj4gK19fcnRlX2ludGVybmFsDQo+ICt2b2lkICoNCj4gK21seDVfb3NfZ2V0X3BoeXNpY2Fs
X2RldmljZV9jdHgoc3RydWN0IG1seDVfY29tbW9uX2RldmljZSAqY2Rldik7DQo+ICsNCj4gIGlu
dCBtbHg1X29zX29wZW5fZGV2aWNlKHN0cnVjdCBtbHg1X2NvbW1vbl9kZXZpY2UgKmNkZXYsIHVp
bnQzMl90DQo+IGNsYXNzZXMpOyAgaW50IG1seDVfb3NfcGRfcHJlcGFyZShzdHJ1Y3QgbWx4NV9j
b21tb25fZGV2aWNlICpjZGV2KTsgIGludA0KPiBtbHg1X29zX3BkX3JlbGVhc2Uoc3RydWN0IG1s
eDVfY29tbW9uX2RldmljZSAqY2Rldik7IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL2NvbW1vbi9t
bHg1L3ZlcnNpb24ubWFwIGIvZHJpdmVycy9jb21tb24vbWx4NS92ZXJzaW9uLm1hcA0KPiBpbmRl
eCA4MzAxNDg1ODM5Li44MTllNmI5NmNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NvbW1vbi9t
bHg1L3ZlcnNpb24ubWFwDQo+ICsrKyBiL2RyaXZlcnMvY29tbW9uL21seDUvdmVyc2lvbi5tYXAN
Cj4gQEAgLTE1MCw2ICsxNTAsNyBAQCBJTlRFUk5BTCB7DQo+ICAJbWx4NV9ubF9yZG1hX21vbml0
b3JfaW5mb19nZXQ7ICMgV0lORE9XU19OT19FWFBPUlQNCj4gIAltbHg1X25sX3JkbWFfbW9uaXRv
cl9jYXBfZ2V0OyAjIFdJTkRPV1NfTk9fRVhQT1JUDQo+IA0KPiArCW1seDVfb3NfZ2V0X3BoeXNp
Y2FsX2RldmljZV9jdHg7DQo+ICAJbWx4NV9vc191bWVtX2RlcmVnOw0KPiAgCW1seDVfb3NfdW1l
bV9yZWc7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jb21tb24vbWx4NS93aW5kb3dzL21s
eDVfY29tbW9uX29zLmMNCj4gYi9kcml2ZXJzL2NvbW1vbi9tbHg1L3dpbmRvd3MvbWx4NV9jb21t
b25fb3MuYw0KPiBpbmRleCAyYjYwNThlYjNlLi42OGYxOTgxMTkzIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2NvbW1vbi9tbHg1L3dpbmRvd3MvbWx4NV9jb21tb25fb3MuYw0KPiArKysgYi9kcml2
ZXJzL2NvbW1vbi9tbHg1L3dpbmRvd3MvbWx4NV9jb21tb25fb3MuYw0KPiBAQCAtMjY2LDYgKzI2
NiwzNyBAQCBtbHg1X29zX29wZW5fZGV2aWNlKHN0cnVjdCBtbHg1X2NvbW1vbl9kZXZpY2UNCj4g
KmNkZXYsIHVpbnQzMl90IGNsYXNzZXMpDQo+ICAJcmV0dXJuIC1ydGVfZXJybm87DQo+ICB9DQo+
IA0KPiArLyoqDQo+ICsgKiBBUEkgZnVuY3Rpb24gdG8gb2J0YWluIGEgbmV3IE1MWDUgY29udGV4
dCBmb3IgYSBnaXZlbiBjb21tb24gZGV2aWNlLg0KPiArICoNCj4gKyAqIFRoaXMgZnVuY3Rpb24g
cHJvdmlkZXMgYSBwb3J0LWFnbm9zdGljIGNvbnRleHQgZm9yIGEgcGh5c2ljYWwNCj4gK2Rldmlj
ZSwgZW5hYmxpbmcgdGhlDQo+ICsgKiBkZXZpY2UgdG8gY3JlYXRlIGFuZCBtYW5hZ2UgcmVzb3Vy
Y2VzIHRoYXQgY2FuIGJlIGluaXRpYWxpemVkIHdoZW4gYQ0KPiArcG9ydCBzdGFydHMgYW5kDQo+
ICsgKiByZWxlYXNlZCB3aGVuIGFub3RoZXIgcG9ydCBzdG9wcy4NCj4gKyAqDQo+ICsgKiBGb3Ig
V2luZG93cywgaXQgY3JlYXRlcyBhIG5ldyBjb250ZXh0IGZvciB0aGUgZGV2aWNlIHJlZ2FyZGxl
c3MgdG8gZXhpc3RpbmcNCj4gY29udGV4dC4NCj4gKyAqDQo+ICsgKiBAcGFyYW0gY2Rldg0KPiAr
ICogICBQb2ludGVyIHRvIHRoZSBtbHg1IGRldmljZSBzdHJ1Y3R1cmUuDQo+ICsgKg0KPiArICog
QHJldHVybg0KPiArICogICBQb2ludGVyIHRvIGFuIGBpYnZfY29udGV4dGAgb24gc3VjY2Vzcywg
b3IgTlVMTCBvbiBmYWlsdXJlLCB3aXRoIGBydGVfZXJybm9gDQo+IHNldC4NCj4gKyAqLw0KPiAr
dm9pZCAqDQo+ICttbHg1X29zX2dldF9waHlzaWNhbF9kZXZpY2VfY3R4KHN0cnVjdCBtbHg1X2Nv
bW1vbl9kZXZpY2UgKmNkZXYpIHsNCj4gKwlzdHJ1Y3QgbWx4NV9jb21tb25fZGV2aWNlIHRlbXAg
PSB7DQo+ICsJCS5kZXYgPSBjZGV2LT5kZXYsDQo+ICsJfTsNCj4gKw0KPiArCWlmIChtbHg1X29z
X29wZW5fZGV2aWNlKCZ0ZW1wLCBNTFg1X0NMQVNTX0VUSCkgPCAwKSB7DQo+ICsJCURSVl9MT0co
RVJSLCAiRmFpbGVkIHRvIGR1cGxpY2F0ZSBEZXZYIGRldmljZSBcIiVzXCI6ICVzIiwNCj4gKwkJ
CW1seDVfb3NfZ2V0X2N0eF9kZXZpY2VfbmFtZShjZGV2LT5jdHgpLA0KPiArCQkJcnRlX3N0cmVy
cm9yKHJ0ZV9lcnJubykpOw0KPiArCQlyZXR1cm4gTlVMTDsNCj4gKwl9DQo+ICsJcmV0dXJuICh2
b2lkICopdGVtcC5jdHg7DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogUmVnaXN0ZXIgdW1lbS4N
Cj4gICAqDQo+IC0tDQo+IDIuNDUuMg0KDQo=
