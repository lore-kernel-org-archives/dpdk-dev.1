Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26741CAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 07:55:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 337E240288;
	Thu, 18 Sep 2025 09:55:10 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61]) by mails.dpdk.org (Postfix) with ESMTP id 0425D4027A;
 Thu, 18 Sep 2025 09:55:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8gxeAOMEvhMxJIJ3LeWBIcf7rdecC3vSG/YQ/dgpmvlFzj/ToOEDnzMgmKgDfyTDkUu5xKETYIAMMBmKPX9eXZ7AYauDE2n2eVPv7oPdVjx/hp/f1pRhWVCZ+VJ5WQ6WkQHeN0XCJGFotCQKVMEO7PRx6TQRdZ6kDxAiHhMtiNRIVj9MtAO7W4yiW5Igk4PdDsw1tpOYi/8PkA9AOIB+t/ysaqGPO6RUsT/OWFwJleM1fM32fS7+fsc+RhH2ZF2XaPy5VkZqUrfg1d4n0e/ZHs6FsmYRG+QB1hk2fQNRA+1bO8wIpSUrD3vjuae8RgZWiYSAJZifAu+CjWRMWhjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXm9RcUfP5pYjojVYbcN3sSNxwTUi6GLgK/Ht4bVxe0=;
 b=Xw1kR/EwXzPNJhmvDfatAm2mblVwmKxYB0AtAYXpBv64tNMsI7zVhTSRMN4A0vNjLkulcvcQGm2Tmoat1wNk+mCTYBKKx6Jkq1cPDODkZhkAaA4Be0uewODKk0EHnJA6JXY/FPMixYm6WIQioxh/kNHXIunHvRsGVDQnYzYDD1kdPBUkhGKWxSU3N6oi7WWwzNIyRmmMHX0bCAQngbuzKHkZk6CVsnBbhRk89fsmHhKTBn0camIH4Y3cXliSpSQfJQAJIrOxXy+DbLx7PFl/6Pf6PwMH9cAmBlCJXkcJ3MbTjdtLu/syi9nbfaLNfWu7Pl22dgNX3zmlikbaOLHZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXm9RcUfP5pYjojVYbcN3sSNxwTUi6GLgK/Ht4bVxe0=;
 b=pdYeuSBPSKoGWgYFwB6epiAEaP4vic9aLcPhXatpTp1zlL/vtn8GeSMCrtCSoBsLIQJCmzg2YuvymYeO2C4ZhdaaYIq1jk6IJHQCrMt4q/8SSGG2EbleHIMDdS+RjEd45E5aeOucYga4u5JvXZwICvK5Y2fsT3Lrl8i8DCFyT8PgvM+qB4hMDBL4+au+R7YGeY9CWpJR2tMBkDPhMft1iojI3seygHgwoFvHi9/xopE9i0wEdepBXABU/scMD1ZnisvmjcjX10cikOVzlMbVjd0jSsG9wcaV9WOgzLRU//p2DiccLNnXYVRoEBwzhKZkV4Vuz4mShkaBcItQZR5Tzw==
Received: from MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 07:55:06 +0000
Received: from MW4PR12MB7484.namprd12.prod.outlook.com
 ([fe80::5a5:56d:2ea4:ee25]) by MW4PR12MB7484.namprd12.prod.outlook.com
 ([fe80::5a5:56d:2ea4:ee25%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:55:06 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 "stable@dpdk.org" <stable@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Alejandro Lucero
 <alejandro.lucero@netronome.com>
Subject: RE: [PATCH v2] eal: fix DMA mask validation inconsistency in IOVA VA
Thread-Topic: [PATCH v2] eal: fix DMA mask validation inconsistency in IOVA VA
Thread-Index: AQHcKGg2b5KTM2QRYEu5xTyaa7mWOLSYj9tA
Date: Thu, 18 Sep 2025 07:55:06 +0000
Message-ID: <MW4PR12MB74846210744CD9A67CAC7A92BF16A@MW4PR12MB7484.namprd12.prod.outlook.com>
References: <20250908163456.420268-1-shperetz@nvidia.com>
 <20250918064754.6116-1-shperetz@nvidia.com>
In-Reply-To: <20250918064754.6116-1-shperetz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7484:EE_|SA1PR12MB8162:EE_
x-ms-office365-filtering-correlation-id: d31284b6-d54c-48dd-b25f-08ddf688aead
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?L3BSSlNmM3N2cDlxMHdaSkVieGI4UzFpL2ZOdDZuN040LzNYT1RWR0xsTjJG?=
 =?utf-8?B?UHc5Yks4UWpzQy92eUxsb2NubThoWnJlelk0OVpPUThGOWlSNDhHYXRnSUZT?=
 =?utf-8?B?TDAvMlk5QXI3SlhURlBwR2t0dUlYanc1SmFDYkJaS3R1b3JyZHc4RFRWN0FH?=
 =?utf-8?B?RkYrU0dRM2tvYTAyZ2J5U0g2MjZ6SkN0ZTZPNU5rL2lQWGRFUzd6STQ2bUZE?=
 =?utf-8?B?K0ZxRHlJQ3ZDMXNKUlVrQUw0eG83KzVIYWNucmhVKzhHcG8rVHpxSm1GOXJN?=
 =?utf-8?B?RHV2Q0VrQWFZMHlEbEt1dlcxZWlhZHJ3c000TEVsOVFqL2QvUlJyOEpVRURT?=
 =?utf-8?B?QVZaWFF5MUl0Wm84NXNKM1BXSmYrRmRnS1FqVE5KdUw0MDBzcC9DMDlXT3VY?=
 =?utf-8?B?NTVmOU5FSnluUVVkSGpOeldOSkVCeGxBNVFBckdNRTlteTcrc0pOR3RMVlVY?=
 =?utf-8?B?L2E1OVJ6cU5WdWRMMGZUY3ZMWjBrY25xeGVkODlBQWFzS0YwaXJxSUJLb0xM?=
 =?utf-8?B?SmhuWjhGOWpmMXBwTWR6MkNRd3NXTmM1azBQZ0NjWE44RjBUV2hoMFlwWTB3?=
 =?utf-8?B?TkJ3Q2l6VVMySXRaS2I2V216QW9HL1NHTHgzTVErNmdhUWl6SkdiU1hzc3RP?=
 =?utf-8?B?TXE4Mk85eHRDMU5NSU9IdzJWc3RUMVZONzdCUWtVYkVHY25NTFFzUWd3NmpR?=
 =?utf-8?B?QVNaUVZPVG5GdEwwMDF6U3RQT3NFVSs3QmlTTGRDeThCbjVPNW5MS2Qzek9R?=
 =?utf-8?B?MXd4d0ZNeHBFNnVoSnd3b1NBQVUveWhnTnNRdXlSaUZmSXZUYlhCaStjZ1FK?=
 =?utf-8?B?QmdrTDdGYWN4UVdBaUlNbE8vMjBobS9obVdORnFhV2pNS1MvWklvRGZJbXkw?=
 =?utf-8?B?OEtsc3Rndjh0dFp5dm5aaTRuM1c5ZGM0TEJqQk9JdTZYeFEyd2o3SktlSFZD?=
 =?utf-8?B?V2hlcUNIblI3ZXQvdEF5MTB2YU8xUjdoWE5SYjh2N2JwZHZodGd4UVBZeHg2?=
 =?utf-8?B?NFdyTFJpYWlPUmxOdVVtVXBVNzhOTm9Cam9BalUyZENGbzVERHVlbjRCdVRu?=
 =?utf-8?B?WWsvT0oraEpkRFpwVldVb0c3RWw5TTlnSlFTNVZ4SHE4WGRhWUt5dEc0ZHRx?=
 =?utf-8?B?eXl5OWxVM0hsbEJRQ2U4anJ6QXFxWk1KajhYYWpSbVZEbFppZ29BUVBLeDJi?=
 =?utf-8?B?ZGd2bitXM25iL29QR1ZHemtEdzlIQUtGV0FBSkk3ZzIyS1VGVjg5cWQwVm05?=
 =?utf-8?B?UlZLbFU3UmJ6SVM1elMwWk1Mb01vQTMzOG11WjZKV3RNdmJHQ2VYdnQxUmUw?=
 =?utf-8?B?cGR6TFJxZm1XZFBIU0xjc1ZnN015V2RESld3SzVuTjRoWHlmamdKQ3dYUWp6?=
 =?utf-8?B?Vm5MajZVYzBxeGN3N0YwVXpHcmpuTjhkdXNGdnBKa2ZlVUJ5Sm5OWk9iOFZn?=
 =?utf-8?B?NUZoUzNHUXkxZk9RTVBub0Y1bkRkNFJzRGhGZjk2NFJDc0FhQXRlZ2s0SDVh?=
 =?utf-8?B?dXAvcUtTZ1VFSHpSZFQ3RTJNcnI0NCsxWlRNRWgyMS92WjRMY0FqVFdxdVVj?=
 =?utf-8?B?bHI0OVhobXpYbGNXOXNiZGc5cEY5UDZLRllPamw5Vm1Pd0J4SkhmTG1SU1kr?=
 =?utf-8?B?RCs5MEEwMG5yaFNmVGJqaktwSGI5dU1CbldES1BhL29VVkwxVUVlZnFrUlo4?=
 =?utf-8?B?dVBYUjU3K1B0OEZuWC84d3pIRUFENTJGeU5sNWpBQ1EzM2NLWUJCZVJPNzc5?=
 =?utf-8?B?MjQxUDRUWkRNQlNEUEYxMHZwMFhYdklOQmJnbWw4dm5ibDZaLzJtVHNRMzJw?=
 =?utf-8?B?ZnJPaWZDUjR6SkVXZHNHQWJJa1R5UFdQWTNtVklFTFN3UHowK3RqRzRHQmRZ?=
 =?utf-8?B?dWFWdmNLRGtoczFSa2xoRE1IVUprS1hDejdoTFVxZlR6NXVVUjNkcHNtWHNo?=
 =?utf-8?B?eEZHckY4S0hJTTMzUElmL2tXNHJaUDlTeWhlS1AyS1Q4TUVTSWhxbmZLZXFt?=
 =?utf-8?B?bDlIMUNZOFB3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7484.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFppdnBYOVM0NU1BMUtES2s0YWI2N1BoQjR1Njl3R2ZGMm4vM2RoVkUrWVd2?=
 =?utf-8?B?N2VGeUU2bnJDWmh5L2p5L1hBRU5VcHh5c2xNTnVmeUNLSVE3WnV5WE9UenpF?=
 =?utf-8?B?NytMcHRqY3BPb1VjWFRkY2pmdmtobWJyTkd4eTBMVmR1aENrd0pWa2hzWDZC?=
 =?utf-8?B?MFRGaGoxQTFOUnhvYXFlWjNCVlFTT0RvY0RDeDRuWEZkMmF0bnJBRmZyaWZz?=
 =?utf-8?B?Z2ZKRnBHYjVtdSs2LzMyT3hIL2xUbkFJdXRsWXh2V2NhVk45dGJIczJWT0hT?=
 =?utf-8?B?Z1JBOHVWT3BGaDJFd1JuR2daTXF3dU5MbTRaYzUyaWN5dkVCSDNJTVRMWWsr?=
 =?utf-8?B?cS9OU2MySzhEMFpJVjFiNFJDVURaQlZBRklBbE5WeUg2OWdwRUpqdVNUbUtF?=
 =?utf-8?B?QlJpL0hha2lWK0ZPclhmL0NmbitQbjJ4SFdtWmR0TExUUlNVaDNIejY0VENL?=
 =?utf-8?B?QUlBRTVrK2RSaXN1VHZObGpGd2g0VHZ6V2ZpeHpZaTNUWXdrRU5HL0FpblZi?=
 =?utf-8?B?Ly9TZm1sWXk1aG85UWpPdlhMMVJCZ05pS3VHNDkyTUdPNjY1eTBSbE5sZEpk?=
 =?utf-8?B?eG1IUkFsN0JzRWp4VktWUWZlb1FyVWdVUzFXSk84U204OTBNNzkvVE42NU9Y?=
 =?utf-8?B?a2N5Q1FRdW14K2RnOXFwekE5QlZOMmRvV3ZmLy9tSlRlMXJGaTUxOHlKdDBH?=
 =?utf-8?B?bHNuN2JFZlI1UjJENlVqeHM5M01tL1BBcG5nN015ZVV4TXc3RE5UTkxFS1Vm?=
 =?utf-8?B?YUhnVlU2ZU1TWHNJUVJQbWZBaUw5cUJKcnAyamdmSnROMDZCODg0ckhsNW5V?=
 =?utf-8?B?cG5KSTdhZERPT0FUdDgybmFmUEd3ZmJXc3k2dTBKUWZFbUhCd1B5VG5Qcnd6?=
 =?utf-8?B?Z0FGZTUzdTZIbVhIQlh6QnRYYkREYzZHdnRyYkF0TXFWRjJ1QW9pZ3padjNW?=
 =?utf-8?B?b0FwaVJ5eFVMRmdpOURKQW9ObllENkNhUVEvemg0UGUrVkZudkJSK2hnODN0?=
 =?utf-8?B?NXFtWC9iUXJZUEd3R2JIZ3N6ek16WXRGNGUzZlN4MExCMjgwbTlscDhXQW9k?=
 =?utf-8?B?RGtKc1hGWlJkcjA4cit4ODdtbnpSUTlBTTRIbzNJMGhXU0tQMEpOTFFIeFV2?=
 =?utf-8?B?dnd2OHI0Tk5zMERmWldMakh0bHBCWGcwRXNPU3FZS01OTUlabkt0VUVHaTFN?=
 =?utf-8?B?SExzaHoxR0gwWmViMlhsRjRHa0NlSlhRMWlDeXlVWVBjdTdNN29aaVE2VTBF?=
 =?utf-8?B?S3JvYXVUeEtQZWpXRXNTb3l5QlgzUGJrdXRKWFNUREpROTFyVlhFUzJQQXBZ?=
 =?utf-8?B?S1hMOEUyQzIwUjlvWDBlNkhoQS9zNGZlY1hRMHdadTNXMCtQNkVkejVOSnd6?=
 =?utf-8?B?enlpNDNXczl4TkRyODBUTWVHTGZvNGMrKzhDcFFaaExTWVhyQmlQbnkrZDRZ?=
 =?utf-8?B?S2RoaS8wZWkzOEdLK1M2SDBNQjg1b0Q3KzVPWm5oYTJTSG5CYmgrTGxKVGlZ?=
 =?utf-8?B?ZnBVSnlHVHlHRmdLYUJuNnhsSlFTZ1JpSk15S0wwRnlVSjBXcnpmQmE3Rnpj?=
 =?utf-8?B?RzRKRktubzJPVGpIVlVwZ1ltRFExcGc0UmZ6NTBrMGNyL2VSSzZsSGRNZDdX?=
 =?utf-8?B?WmV2RmdXMzZsTHBwdllBMk5XS2xxQ2NJbWk0S3hwdW9LTVZ4S2NlUmJmWmhQ?=
 =?utf-8?B?cDV4L3lTbTJJMTZ6bk5nTUpXS01XcmdPM1Bkak42dnJTYVBsaXJOTnFEb3E5?=
 =?utf-8?B?aUVrM2pIZU5aYUJUeWxVbXNSdVNjaEJxSXFDbmVHSVROM295ZGZyamhiSFJp?=
 =?utf-8?B?TlFJNzJpa2hqcUpwdU5tcWs1T0xMTStPRnBNaVIyNVVHa0t0UlY4N0UvQzY4?=
 =?utf-8?B?bDRjcyt2aUc2TG80VmpTakozMHBhOWgzV08wRTdqMzFoeHpFMDJNNk1MVkRp?=
 =?utf-8?B?UkJMdXdwS28rRFVHOTZJTnVOMmFFci9UdU9UQm9TcEV0NjRGRjFuMEJBT05n?=
 =?utf-8?B?MmN1K1FFY25VT254TjR1Rk9sbVI2N3JOTEVMNzhUVXgrSzRPenFoVmNlcExN?=
 =?utf-8?B?STY5allNbVViQmF0cktralh6R0FlN0hRYy9QV1M5NjNWZ0pNbno1aXVaS1FE?=
 =?utf-8?Q?1wds=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31284b6-d54c-48dd-b25f-08ddf688aead
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 07:55:06.2954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xJhZp827s0DJPE7NRz8BiSIEVSYPWM3OQ7FE7K8nmGuwa3FgR4Xpz2IKZYDQxAO7MdL6dhWhWLZ8huUUAOT8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhbmkgUGVyZXR6IDxz
aHBlcmV0ekBudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgMTggU2VwdGVtYmVyIDIwMjUg
OTo0OA0KPiBUbzogZGV2QGRwZGsub3JnDQo+IENjOiBOQlUtQ29udGFjdC1UaG9tYXMgTW9uamFs
b24gKEVYVEVSTkFMKSA8dGhvbWFzQG1vbmphbG9uLm5ldD47DQo+IFNoYW5pIFBlcmV0eiA8c2hw
ZXJldHpAbnZpZGlhLmNvbT47IHN0YWJsZUBkcGRrLm9yZzsgQnJ1Y2UgUmljaGFyZHNvbg0KPiA8
YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+OyBEbWl0cnkgS296bHl1ayA8ZG1pdHJ5Lmtvemxp
dWtAZ21haWwuY29tPjsNCj4gVHlsZXIgUmV0emxhZmYgPHJvcmV0emxhQGxpbnV4Lm1pY3Jvc29m
dC5jb20+OyBBbGVqYW5kcm8gTHVjZXJvDQo+IDxhbGVqYW5kcm8ubHVjZXJvQG5ldHJvbm9tZS5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gZWFsOiBmaXggRE1BIG1hc2sgdmFsaWRhdGlvbiBp
bmNvbnNpc3RlbmN5IGluIElPVkEgVkENCj4gDQo+IFdoZW4gLS1pb3ZhLW1vZGUgaXMgZXhwbGlj
aXRseSBzcGVjaWZpZWQgaW4gY29tbWFuZCBsaW5lLCBETUEgbWFzaw0KPiBjb25zdHJhaW50cyB3
ZXJlIG5vdCBiZWluZyB2YWxpZGF0ZWQsIGxlYWRpbmcgdG8gcG90ZW50aWFsIHJ1bnRpbWUgZmFp
bHVyZXMNCj4gd2hlbiBkZXZpY2UgRE1BIGNhcGFiaWxpdGllcyBhcmUgZXhjZWVkZWQuDQo+IA0K
PiBUaGUgaXNzdWUgb2NjdXJyZWQgYmVjYXVzZSBydGVfYnVzX2dldF9pb21tdV9jbGFzcygpIHdh
cyBvbmx5IGNhbGxlZCBkdXJpbmcNCj4gSU9WQSBtb2RlIGF1dG8tZGV0ZWN0aW9uLCBidXQgdGhp
cyBmdW5jdGlvbiBoYXMgdGhlIGltcG9ydGFudCBzaWRlIGVmZmVjdCBvZg0KPiB0cmlnZ2VyaW5n
IERNQSBtYXNrIGRldGVjdGlvbiAoZS5nLiwgSW50ZWwgSU9NTVUgYWRkcmVzcyB3aWR0aCBjaGVj
a2luZyB2aWENCj4gcGNpX2RldmljZV9pb21tdV9zdXBwb3J0X3ZhKCkpLg0KPiANCj4gVGhpcyBj
cmVhdGVkIGFuIGluY29uc2lzdGVuY3ksIHdoZW4gY2hvb3NpbmcgZXhwbGljaXQgbW9kZSwgdGhl
IERNQSBjaGVja3MNCj4gYXJlIGJ5cGFzc2VkLCBidXQgd2hlbiBjaG9vc2luZyBhdXRvLWRldGVj
dGlvbiBtb2RlLCB0aGUgY29uc3RyYWludHMgYXJlDQo+IGNoZWNrZWQgYW5kIGVuZm9yY2VkLg0K
PiANCj4gVGhlIGZpeCBtb3ZlcyBydGVfYnVzX2dldF9pb21tdV9jbGFzcygpIG91dHNpZGUgdGhl
IGNvbmRpdGlvbmFsIGxvZ2ljIHRvDQo+IGVuc3VyZSBpdCdzIGFsd2F5cyBjYWxsZWQgZHVyaW5n
IEVBTCBpbml0aWFsaXphdGlvbi4NCj4gDQo+IEZpeGVzOiA0Mzc0ZWJjMjRiYzEgKCJtYWxsb2M6
IG1vZGlmeSBlcnJvciBtZXNzYWdlIGZvciBETUEgbWFzayBjaGVjayIpDQo+IENjOiBzdGFibGVA
ZHBkay5vcmcNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoYW5pIFBlcmV0eiA8c2hwZXJldHpAbnZp
ZGlhLmNvbT4NCj4gLS0tDQo+ICBsaWIvZWFsL2ZyZWVic2QvZWFsLmMgfCA2ICsrKysrLQ0KPiAg
bGliL2VhbC9saW51eC9lYWwuYyAgIHwgNSArKysrLQ0KPiAgbGliL2VhbC93aW5kb3dzL2VhbC5j
IHwgNSArKysrLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2xpYi9lYWwvZnJlZWJzZC9lYWwuYyBiL2xpYi9l
YWwvZnJlZWJzZC9lYWwuYyBpbmRleA0KPiBjMWFiOGQ4NmQyLi4wZjk1NzkxOWQzIDEwMDY0NA0K
PiAtLS0gYS9saWIvZWFsL2ZyZWVic2QvZWFsLmMNCj4gKysrIGIvbGliL2VhbC9mcmVlYnNkL2Vh
bC5jDQo+IEBAIC02NzAsMTIgKzY3MCwxNiBAQCBydGVfZWFsX2luaXQoaW50IGFyZ2MsIGNoYXIg
Kiphcmd2KQ0KPiAgCSAqIHdpdGggYSBtZXNzYWdlIGRlc2NyaWJpbmcgdGhlIGNhdXNlLg0KPiAg
CSAqLw0KPiAgCWhhc19waHlzX2FkZHIgPSBpbnRlcm5hbF9jb25mLT5ub19odWdldGxiZnMgPT0g
MDsNCj4gKw0KPiArCS8qIEFsd2F5cyBjYWxsIHJ0ZV9idXNfZ2V0X2lvbW11X2NsYXNzKCkgdG8g
dHJpZ2dlciBETUEgbWFzaw0KPiBkZXRlY3Rpb24gYW5kIHZhbGlkYXRpb24gKi8NCj4gKwllbnVt
IHJ0ZV9pb3ZhX21vZGUgYnVzX2lvdmFfbW9kZSA9IHJ0ZV9idXNfZ2V0X2lvbW11X2NsYXNzKCk7
DQo+ICsNCj4gIAlpb3ZhX21vZGUgPSBpbnRlcm5hbF9jb25mLT5pb3ZhX21vZGU7DQo+ICAJaWYg
KGlvdmFfbW9kZSA9PSBSVEVfSU9WQV9EQykgew0KPiAgCQlFQUxfTE9HKERFQlVHLCAiU3BlY2lm
aWMgSU9WQSBtb2RlIGlzIG5vdCByZXF1ZXN0ZWQsDQo+IGF1dG9kZXRlY3RpbmciKTsNCj4gIAkJ
aWYgKGhhc19waHlzX2FkZHIpIHsNCj4gIAkJCUVBTF9MT0coREVCVUcsICJTZWxlY3RpbmcgSU9W
QSBtb2RlIGFjY29yZGluZyB0bw0KPiBidXMgcmVxdWVzdHMiKTsNCj4gLQkJCWlvdmFfbW9kZSA9
IHJ0ZV9idXNfZ2V0X2lvbW11X2NsYXNzKCk7DQo+ICsJCQlpb3ZhX21vZGUgPSBidXNfaW92YV9t
b2RlOw0KPiAgCQkJaWYgKGlvdmFfbW9kZSA9PSBSVEVfSU9WQV9EQykgew0KPiAgCQkJCWlmICgh
UlRFX0lPVkFfSU5fTUJVRikgew0KPiAgCQkJCQlpb3ZhX21vZGUgPSBSVEVfSU9WQV9WQTsNCj4g
ZGlmZiAtLWdpdCBhL2xpYi9lYWwvbGludXgvZWFsLmMgYi9saWIvZWFsL2xpbnV4L2VhbC5jIGlu
ZGV4DQo+IDUyZWZiODYyNmIuLjNhMGM5YzlkYjYgMTAwNjQ0DQo+IC0tLSBhL2xpYi9lYWwvbGlu
dXgvZWFsLmMNCj4gKysrIGIvbGliL2VhbC9saW51eC9lYWwuYw0KPiBAQCAtMTA0MiwxMCArMTA0
MiwxMyBAQCBydGVfZWFsX2luaXQoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiANCj4gIAlwaHlz
X2FkZHJzID0gcnRlX2VhbF91c2luZ19waHlzX2FkZHJzKCkgIT0gMDsNCj4gDQo+ICsJLyogQWx3
YXlzIGNhbGwgcnRlX2J1c19nZXRfaW9tbXVfY2xhc3MoKSB0byB0cmlnZ2VyIERNQSBtYXNrDQo+
IGRldGVjdGlvbiBhbmQgdmFsaWRhdGlvbiAqLw0KPiArCWVudW0gcnRlX2lvdmFfbW9kZSBidXNf
aW92YV9tb2RlID0gcnRlX2J1c19nZXRfaW9tbXVfY2xhc3MoKTsNCj4gKw0KPiAgCS8qIGlmIG5v
IEVBTCBvcHRpb24gIi0taW92YS1tb2RlPTxwYXx2YT4iLCB1c2UgYnVzIElPVkEgc2NoZW1lICov
DQo+ICAJaWYgKGludGVybmFsX2NvbmYtPmlvdmFfbW9kZSA9PSBSVEVfSU9WQV9EQykgew0KPiAg
CQkvKiBhdXRvZGV0ZWN0IHRoZSBJT1ZBIG1hcHBpbmcgbW9kZSAqLw0KPiAtCQllbnVtIHJ0ZV9p
b3ZhX21vZGUgaW92YV9tb2RlID0NCj4gcnRlX2J1c19nZXRfaW9tbXVfY2xhc3MoKTsNCj4gKwkJ
ZW51bSBydGVfaW92YV9tb2RlIGlvdmFfbW9kZSA9IGJ1c19pb3ZhX21vZGU7DQo+IA0KPiAgCQlp
ZiAoaW92YV9tb2RlID09IFJURV9JT1ZBX0RDKSB7DQo+ICAJCQlFQUxfTE9HKERFQlVHLCAiQnVz
ZXMgZGlkIG5vdCByZXF1ZXN0IGEgc3BlY2lmaWMNCj4gSU9WQSBtb2RlLiIpOyBkaWZmIC0tZ2l0
IGEvbGliL2VhbC93aW5kb3dzL2VhbC5jIGIvbGliL2VhbC93aW5kb3dzL2VhbC5jIGluZGV4DQo+
IDRmMGExNjRkOWIuLjI1MDJlYzNjM2QgMTAwNjQ0DQo+IC0tLSBhL2xpYi9lYWwvd2luZG93cy9l
YWwuYw0KPiArKysgYi9saWIvZWFsL3dpbmRvd3MvZWFsLmMNCj4gQEAgLTM0OCwxMiArMzQ4LDE1
IEBAIHJ0ZV9lYWxfaW5pdChpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ICAJCWhhc19waHlzX2Fk
ZHIgPSBmYWxzZTsNCj4gIAl9DQo+IA0KPiArCS8qIEFsd2F5cyBjYWxsIHJ0ZV9idXNfZ2V0X2lv
bW11X2NsYXNzKCkgdG8gdHJpZ2dlciBETUEgbWFzaw0KPiBkZXRlY3Rpb24gYW5kIHZhbGlkYXRp
b24gKi8NCj4gKwllbnVtIHJ0ZV9pb3ZhX21vZGUgYnVzX2lvdmFfbW9kZSA9IHJ0ZV9idXNfZ2V0
X2lvbW11X2NsYXNzKCk7DQo+ICsNCj4gIAlpb3ZhX21vZGUgPSBpbnRlcm5hbF9jb25mLT5pb3Zh
X21vZGU7DQo+ICAJaWYgKGlvdmFfbW9kZSA9PSBSVEVfSU9WQV9EQykgew0KPiAgCQlFQUxfTE9H
KERFQlVHLCAiU3BlY2lmaWMgSU9WQSBtb2RlIGlzIG5vdCByZXF1ZXN0ZWQsDQo+IGF1dG9kZXRl
Y3RpbmciKTsNCj4gIAkJaWYgKGhhc19waHlzX2FkZHIpIHsNCj4gIAkJCUVBTF9MT0coREVCVUcs
ICJTZWxlY3RpbmcgSU9WQSBtb2RlIGFjY29yZGluZyB0bw0KPiBidXMgcmVxdWVzdHMiKTsNCj4g
LQkJCWlvdmFfbW9kZSA9IHJ0ZV9idXNfZ2V0X2lvbW11X2NsYXNzKCk7DQo+ICsJCQlpb3ZhX21v
ZGUgPSBidXNfaW92YV9tb2RlOw0KPiAgCQkJaWYgKGlvdmFfbW9kZSA9PSBSVEVfSU9WQV9EQykg
ew0KPiAgCQkJCWlmICghUlRFX0lPVkFfSU5fTUJVRikgew0KPiAgCQkJCQlpb3ZhX21vZGUgPSBS
VEVfSU9WQV9WQTsNCj4gLS0NCj4gMi4zNC4xDQoNCg0KUmViYXNlZCBvbiBsYXRlc3QgbWFpbi4g
UGF0Y2ggd2FzIGFscmVhZHkgYWNrZWQNCg0KQWNrZWQtYnk6IEFuYXRvbHkgQnVyYWtvdiA8YW5h
dG9seS5idXJha292QGludGVsLmNvbT4NCg==
