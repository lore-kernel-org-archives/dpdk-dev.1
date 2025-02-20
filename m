Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A69C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 09:49:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E5CA4014F;
	Thu, 20 Feb 2025 10:49:26 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by mails.dpdk.org (Postfix) with ESMTP id C991340041;
 Thu, 20 Feb 2025 10:49:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+4NwUUby/xYMt/nQmKvDNnGaICXnvzXE4zB2zPSCoE16wYpeDXpFrr3VKUXq+OG99P1XGnjgE5J2lCfdEdjB8UEeXNGCbTVmtmChoRPXlfqNalCBQCXCB92pIEx18Hvp6WtCqdFCgtSNGRGXD3DAcSlvFlglNjOV2Rzz+MEa+nE0vD+5JFnUxBQaYjnimafJHPNN8RJYjV1aG7hZHK7lBjU0P821hPhpNMAIq3gME5DhGJmtWRPUoGnOKctStuIBv3hB4dkf61+29FVLSPK9zfzGEI4NhZhN5GaJQQyDSPfWQZLCp6i0aIhaGfTY51FuOZLegVsWJalCC8F/wlmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l9Dy4xWx8fIJiq+izL3sw+KlCKxRwwpPxFbitwUos8=;
 b=I1Hgb+HCzUT8LvEWu88lIHvVQm7eCYVePdEnp7ABrUdw/Bjxixmz5Yf7mhRQTJD0I4teXnpfO9MxEzyWiQK7qSb5jxo4XmyvWmC1+rY6Ox0HwWOiVAEQ3weqOPgd8+z5hab8W0OAX/8Ad1AM2c3Yt31o7YEeYblipzxnFl6y8R12VfMvoLWYlk/+p4wZ1VQi+VizUQPX30LuI5TcMnd+bYkFeCc7iRzg9/oB9rFad8LMkvZQBoRw8XnOC7cf87vx2e3ZasADV8saUSlUIvi1jw/gQF8y0sAfxNrm6IUfCMKt0+lq72hdsOmDXJ3LiF14NBm4/JU3vo5rQKNcwnvVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4l9Dy4xWx8fIJiq+izL3sw+KlCKxRwwpPxFbitwUos8=;
 b=nFos2sYq0ggGAtPtFj4Afr7FJxdKl8Z/lI8Z4tGErVcaYDkCRuouxVfXCo/KN+nb2rJQ8gkPdrtkk+HVVNqPkP3WTtFDhAILgIAeMgrKpa+/aSo1okEFipIjTY67FtkIIKO7/UOWD7Vmh3zeN7OTRNgwkLbJB0y8/aGvEBFY6VpXClYW1SHWS33Gy+CxHszw/XaYjgXTskEm424AdDUIPxSL/1kpjNN+FIp1ABpihuDT582t2fYyFOMv4zg77+6PbH+DHLm5n2o/BmQoh9i16J0B+QXTEoyxM+/f9imJm9fneD8DOWBdAMpcs1tHeEHhirnsPoc7uT0CvN92FPbAtQ==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 09:49:20 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 09:49:20 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Junfeng Guo <junfengg@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, "Minggang(Gavin) Li" <gavinl@nvidia.com>, "Jiawei(Jonny)
 Wang" <jiaweiw@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/mlx5: fix err message overwrite for actions
 translation
Thread-Topic: [PATCH] net/mlx5: fix err message overwrite for actions
 translation
Thread-Index: AQHbg2ZjDpTHFvSA10G4Tz2kr3H5j7NP8nsQ
Date: Thu, 20 Feb 2025 09:49:20 +0000
Message-ID: <CH3PR12MB84609772E3F121103312F3C9A4C42@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250220070850.6661-1-junfengg@nvidia.com>
In-Reply-To: <20250220070850.6661-1-junfengg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|SN7PR12MB6981:EE_
x-ms-office365-filtering-correlation-id: 6d4fa0e1-c7c0-401b-ac50-08dd5193d980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZSt4K1JsYjJVYkFrY0RFWmJXTjRqMjllZjZQeEFObjE1Tm1sc3FWSFJVdzdo?=
 =?utf-8?B?VEdYdThWcm1zTjBNR015VTlINHRqQUdsNW04bUpGMkoybG5xbXFZK0llZWZY?=
 =?utf-8?B?bjM3SW5pdjErbzVwenBEaGQ1STlYcTEwTVRtNzc3YStUbEx2enVieDdRMFNs?=
 =?utf-8?B?aVlaM2prTEdxN0ZkYnpWRU91T3lCMjBxSjRia1VtWkV5V2RPY05tNjRYNlI4?=
 =?utf-8?B?QWdWK1dQS2gxZVczQ1B5RVFnejN5c2ZQdk9ZM2gxaEkzclVjRWIzb2twc1l3?=
 =?utf-8?B?cWdZZDE2ZExYZnJRY0pjcFJsVmJYalFIYWU5SjNrQ1dFbE1XeHI3T3A3VFJQ?=
 =?utf-8?B?N2ZmSjNFZmxSbDV2Y083SVU2NjBRbENHSU9SaVpWNEdJZVJ3QlovbnBkL1E1?=
 =?utf-8?B?TFhvTGszNGxrMkZlazQ5bGpRYnZkcGU3Vzd0UG5tdVRueENIZW1PMUcxZi9R?=
 =?utf-8?B?bW1vNUZPUFhrU3NXRDJ2MlpiZ0F2am43S2JRUnNDSnlSUEpnYXBkRzd3aHAy?=
 =?utf-8?B?eDNCbFg1VTRrR2p5dkI4ZG1pV0dkUzAzK1hucWEvSXhsTzYzRzc4aTNZcUI1?=
 =?utf-8?B?NWpJSFYxY2hjN1RVYmg3bnFOZnlvUzhsMk0rdnhLSDJ6ZS9YYmxWYVlMUWdo?=
 =?utf-8?B?TGR3cEtzQVBpc2JHNE1FekVOU2hEeVdGTTFvRTRuRmhCTFRpSTU3Zy9FNWJy?=
 =?utf-8?B?YlU4MXRwN3lBYlBpSHUzb0gyakU2bUFhb2t4bEFZM1dUQnNnTTZSblJqdElo?=
 =?utf-8?B?Zm5Md2U1elIvRWdlSXBGSGs2WmU5L0RhQzdOci9sd3gwMUZ5TVluNFVlS2pU?=
 =?utf-8?B?a2F3dkkzVkpGUmVZdTNrN1pyNjA5aVpVdFNlL05ycXdXQVVpQy9TUGlKcXk4?=
 =?utf-8?B?cTQrOXJ2bEhJZEcvSGpWS3lxVjZ6Q3V1MmxMcndaSWE2TVRIeWxnY2RvekRN?=
 =?utf-8?B?UUtEL0VRMjNrY3plZ3g4ZEczNlp4T0hxWW1LQ3hmWExjSDNRaDVLeUQvNEY2?=
 =?utf-8?B?TXRCOWxqZVVkZDlZMHhpZ3FqSTU2V0dvUXJTaXNaSnZyVHU2ZWZuaWdlVmdj?=
 =?utf-8?B?M3ZiY2wyYkg2ZEo0UzJNaWJlNUJ5enFCMGMwWVRIN2U4amkxcC9vNENZTmRO?=
 =?utf-8?B?YUV0ZEpjWVJPZytJNmhxb3lPNkh1M2pucFpwUENSNEJ3a3JMT2ZpTHQ0bDN2?=
 =?utf-8?B?b2l0WjBrTE5WR0pRZCtFVDFwYlZGMUFiTTJmRlhZcFo5WFRTbXcrVTcwSW1Z?=
 =?utf-8?B?cDRwWThsNldxVUxqWDQ2T2Z6RmJvSmdBTmdDVjhrcWFZT3d5eFRKUDRDU2E4?=
 =?utf-8?B?TmNnSmpEQWYvZlkvU0xESCtmVHk3TXFnUEU2OFltdzUwVzA0ZmtHWENPL0JL?=
 =?utf-8?B?YmEyZzZzYkpiaXEzVjgwTnZoaG8rM255eWdJeUpQdHZoOENzdVFmYWpFUjln?=
 =?utf-8?B?b3pxdTlCUHpab3U1VnIrUE5RbjBGN3hCZ2srYmRCR0JQT1JUQmg0WTl4UVNE?=
 =?utf-8?B?OEVNdUlDbmlybXRZSTNUMFRuZ2RvQVhRV3hackhEQjMwL2h1K1ZEcWRpeGxS?=
 =?utf-8?B?UTFLSEorbGlsMnNEZStBWXlndGNpNVg2VWlvWUV0TWpHK1g4Wkozc25pamRV?=
 =?utf-8?B?aXBuTUM3eXl6cVo1a0E2Y2RhMjhlUHRFN1dseVJ5L0hLc3pjenJSRHBuN0Zi?=
 =?utf-8?B?VXRYcDNwVWZlM0EzTEdpT1hhUzdPcjZGbTRFSjVGb1lZbFVTSUloS29MWXI0?=
 =?utf-8?B?Q1Y3SFRPMXNlSWxWVjhZZVFXOHYxWGFORnJKUXRYemRnbHFNWXJPYjVwazFw?=
 =?utf-8?B?U29DblVwQmoycktXTm4wbTZRY0RWblNyRkU0blk5MXFreFlGOVQ4ZHVlZW12?=
 =?utf-8?B?S1F0ZWQ4UjdwUUkwb0o1VURleUl5N0oyeHZJbUV2cUZGK1ppMmJ2R29HOEpj?=
 =?utf-8?Q?5F11CNTYWAfOEal58NSu7GlM19Hz3+xs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0JMTVdVS1RidXZzcVYyR29OSFJldHFyT2lpK3VYc3hCU3BJcUUrNUdxYXBP?=
 =?utf-8?B?Qkt5dHU4VERja3BmdHNIdi9Ha3oxWmdYUkRxZzFrSEJydUllSzlpN0FGOFU0?=
 =?utf-8?B?Wk9laUhwQnVSMmNiTjNxa25WUGFxdjJtNDlpWlhIUnBadDhubWdjaUpIVkZm?=
 =?utf-8?B?eE5TTmpSUnRPbWFCNjFRelpBbGNKbnNJQzV6ckIvcGdRYjFTa2VvR3FtM0xk?=
 =?utf-8?B?b21PTkR2NjhPVmQ2OWs0d0VUMEhEdWlZZnNmdW1pbUVlK2FpVk9qOFA2R2d0?=
 =?utf-8?B?K1Y5ZUNPNm5neUd5R0JCOFNxNjdhc2oxQlBKcXR0VjVsY1lvdDBOSVh4UHJs?=
 =?utf-8?B?YlpkZ0gwWWtUMmxlZ3FEQmpOQ3Z6clJVTEhYeGFsUHhwL2lPR0h6bWlodms4?=
 =?utf-8?B?NkxsVXZKM0ordGFkUTBzaHI1S3paaEVwRzlrMEMyWGxyL3dhVktScDVHeHpI?=
 =?utf-8?B?SFIwdzkwL0s1NktwL2JXQVI1Qk5Ld0dERTdraXdQY1ozcEQ4SmYyVHNwd2hn?=
 =?utf-8?B?SXFOS2hZL0hqNjNYMnNreXVMSlkxb0o5MG5ZVjFKMktlY09QUlBTTmZLczJW?=
 =?utf-8?B?aFZJUUt2SjhEeHAxV2RKeitIU3lFa1lGU2dpYTNPb1V5NXc4VWoxamV1ZnpJ?=
 =?utf-8?B?NlBBU2ZsMXBaOGVTOXpzRGpkQVIvcVRNbysyOWhJUkl2OG1YYjJ3UGEyWE1h?=
 =?utf-8?B?N3gzQy9WT3pXUyt2dk00RGI1enEyUHVHa0ZONzRXTktFWDd6QTVDa0lXTklD?=
 =?utf-8?B?b0JEcng1SFFMMFhyUDNCQU52YlhOSWdJaThSSnN6QVRKTmI2WFp4dzVGTTRN?=
 =?utf-8?B?YmthYTlFeVdSMDkrUEFuM0M5NTZJTmFjVUc2ODMxb2ZDRVJwMGlyUW5yS3RL?=
 =?utf-8?B?TEVYVytpRzBTY3Vndmo4Mmo0TnlxLy9ha01RQnZVK2I0b2xkNjRmVUtLTDFz?=
 =?utf-8?B?amVvNDMwMVdYc2dSRUdLMlpGZ2tpbW1ZN3F6dHMxbjh3cDMvK01UNVk4czAz?=
 =?utf-8?B?Sm5pczhyNWZBZHBjbkpNV1dTSjAyM0FKREg5UzlMWlNucW9FSVJYSTlSSW85?=
 =?utf-8?B?LzlPS2hXc3NHd0drZVVvb0xYSXNsa2ZodEpiUkNWaEdDNVVqNGwxNmNuNnFX?=
 =?utf-8?B?L2dtWHVyN25VNEs0VmR1ckFoS3Zidlhlak1yODJ3VTlYWUNGbzNJekUvZmpD?=
 =?utf-8?B?Z0tuM01rSTVZU0xFMGtSWTR4N0RpNnpSeWRyUXNTNXJteE1zYmxBbkVxdDdH?=
 =?utf-8?B?SmJmSHVFVUw5OVBCcXV2cm5CcTh4UUs4bUxkc2xGbzlhQkJNQ1hiZDFzUkds?=
 =?utf-8?B?dnllVzk5WGJzdm5NWTBOTVhIcy9sc205eG9IT3VlTFZ6NHJtdWZNZlFvYzBS?=
 =?utf-8?B?S0t0UEtiUVMxNDl3eUpCaHVxNVhMSzR2aUsyeERBR3ZVS1BqbElxWFJEOHFO?=
 =?utf-8?B?QU55dGw1b1k3MDU4d1Q0YzhSczZ6Njd4ZTIxNmxSY0ZqbDR2YTNVdXFUcVp1?=
 =?utf-8?B?amZicHNHam1CdGYvdGVJRU5xSEF3ak9MdnZTNi9DY2F5M0lqVFhidm56cHlB?=
 =?utf-8?B?ZkVXaUpwUVhPZmoxTGQyemFaYy9DT0d3VzV2QUpXRjhyc1BBUDh5MFZPMDdh?=
 =?utf-8?B?a3FPbW83REtmTjRHbWtJK3ZIWmk5RWZuTFBJVnJOODVTRWZlaTdOaWJKc0FY?=
 =?utf-8?B?U0JwS3JVU0M1Ujc3QTYrTjFFWXI0dGJGRlZ4aWF0bGMyK0piVGFNdURpeDBu?=
 =?utf-8?B?K2ZlbE1ZY0F6ZzhUWWplOFdqay93SE1tRkFrZlhwd0VpL3FXS0dzaW5FWGVx?=
 =?utf-8?B?MjJlUmlCRXJIUXMwajNKR0ZGUnppYnMwTVpLL3RUeHlxV1BDdHdMSjRKN2tZ?=
 =?utf-8?B?RGlpTEhGbFMyUzh4djBTeG41UStBc1FvWStHMzRhK2pEaTNtK1RkR1NJZTQr?=
 =?utf-8?B?ZktCSGdOTW45UjBRYWZCcmd3NTM3bzJoK2lYQWZDY1NNZmRuZXpBT2V0STVy?=
 =?utf-8?B?WlB5RlpiTGtzSktYaS81TUQ2Z3pOV3VsRmRyWnlFOENTZWpCVm9ZY0I0L21I?=
 =?utf-8?B?anR3SDB0eUdwOWVWMk90aGsvbUlEcHRFK2gzdEhWUExsY1dybmUvc01Tc1ZX?=
 =?utf-8?Q?9aEW3LQZ4rKTSZeY6uoQkNatG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4fa0e1-c7c0-401b-ac50-08dd5193d980
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 09:49:20.6999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3pdHmxPS+QhXxDjrBVrPE8wk6HQnX0WcRj6/2Yoafrqp5IWWoVtLehFttJJyDBTTyXmOUWfKVl5F2x4L+ZekQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSnVuZmVuZyBHdW8gPGp1
bmZlbmdnQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyMCwgMjAyNSAw
ODowOQ0KPiBUbzogZGV2QGRwZGsub3JnDQo+IENjOiBEYXJpdXN6IFNvc25vd3NraSA8ZHNvc25v
d3NraUBudmlkaWEuY29tPjsgU2xhdmEgT3ZzaWllbmtvDQo+IDx2aWFjaGVzbGF2b0BudmlkaWEu
Y29tPjsgQmluZyBaaGFvIDxiaW5nekBudmlkaWEuY29tPjsgT3JpIEthbQ0KPiA8b3Jpa2FAbnZp
ZGlhLmNvbT47IFN1YW5taW5nIE1vdSA8c3Vhbm1pbmdtQG52aWRpYS5jb20+OyBNYXRhbiBBenJh
ZA0KPiA8bWF0YW5AbnZpZGlhLmNvbT47IE1pbmdnYW5nKEdhdmluKSBMaSA8Z2F2aW5sQG52aWRp
YS5jb20+OyBKaWF3ZWkoSm9ubnkpDQo+IFdhbmcgPGppYXdlaXdAbnZpZGlhLmNvbT47IHN0YWJs
ZUBkcGRrLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIG5ldC9tbHg1OiBmaXggZXJyIG1lc3NhZ2Ug
b3ZlcndyaXRlIGZvciBhY3Rpb25zIHRyYW5zbGF0aW9uDQo+IA0KPiBGdW5jdGlvbiBfX2Zsb3df
aHdfdHJhbnNsYXRlX2FjdGlvbnNfdGVtcGxhdGUgY29udGFpbnMgc2V2ZXJhbCBlbmNhcHN1bGF0
ZWQNCj4gZnVuY3Rpb25zIHRoYXQgYWxyZWFkeSBoYXZlIGludGVybmFsIGVycm9yIGhhbmRsaW5n
IHByb2Nlc3MgdmlhIHJ0ZV9mbG93X2Vycm9yX3NldA0KPiBmb3IgZWFjaCBjYXNlLg0KPiANCj4g
VGh1cyB0aGUgb25lIChydGVfZmxvd19lcnJvcl9zZXQpIHdpdGhpbiB0aGUgZ290byBzdGF0ZW1l
bnQgYGVycmAgYXQgdGhlIGVuZCBvZg0KPiBfX2Zsb3dfaHdfdHJhbnNsYXRlX2FjdGlvbnNfdGVt
cGxhdGUgZnVuY3Rpb24gbWF5IGJlIHJlZHVuZGFudCBmb3IgdGhvc2UNCj4gZmFpbGVkIGNhc2Vz
LiBBcyBhIHJlc3VsdCwgdGhlIGVycm9yIG1lc3NhZ2VzIHdvdWxkIGFsbCBiZSBvdmVyd3JpdHRl
biBhcyAiZmFpbCB0bw0KPiBjcmVhdGUgcnRlIHRhYmxlIiwgbWFraW5nIGl0IGRpc3BsYXllZCBh
dCBxdWl0ZSBsYXJnZSBncmFudWxhcml0eS4NCj4gDQo+IFRvIHByZXZlbnQgYWJvdmUgZXJyb3Ig
bWVzc2FnZXMgb3ZlcndyaXRlLCB0aGlzIHBhdGNoIGFkZCBhIGxvY2FsIHZhcmlhYmxlIGBzdHJ1
Y3QNCj4gcnRlX2Zsb3dfZXJyb3Igc3ViX2Vycm9yYCB0byB0aGUgZnVuY3Rpb24gYW5kIHBhc3Mg
dGhpcyBgc3ViX2Vycm9yYCBpbnN0ZWFkIG9mDQo+IGBlcnJvcmAgdG8gZWFjaCBzdWItZnVuY3Rp
b24uIFVuZGVyIGVycm9yIGhhbmRsaW5nIHByb2Nlc3MgKGBlcnJgIGxhYmVsKSwgaWYNCj4gYHN1
Yl9lcnJvcmAgd2FzIHVwZGF0ZWQsIGNvcHkgaXRzIGNvbnRlbnRzIHRvIGBlcnJvcmAgYW5kIHJl
dHVybi4gSWYgaXQgd2FzIG5vdA0KPiB1cGRhdGVkLCByZXR1cm4gZGVmYXVsdCBlcnJvciBtZXNz
YWdlIChgZmFpbCB0byBjcmVhdGUgcnRlIHRhYmxlYCkuDQo+IA0KPiBBbHNvIHJlZmFjdG9yIHRo
ZSBsb2dpYyBmb3IgU0VORF9UT19LRVJORUwsIENPVU5UIGFuZCBBR0UgYWN0aW9ucyBpbiBhYm92
ZQ0KPiBmdW5jdGlvbiB0byBhbGlnbiB0aGUgZXJyb3IgaGFuZGxpbmcgcHJvY2Vzcy4NCj4gDQo+
IEZpeGVzOiBmMTNmYWIyMzkyMmIgKCJuZXQvbWx4NTogYWRkIGZsb3cganVtcCBhY3Rpb24iKQ0K
PiBDYzogc3Vhbm1pbmdtQG52aWRpYS5jb20NCj4gQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSnVuZmVuZyBHdW8gPGp1bmZlbmdnQG52aWRpYS5jb20+DQoNCkFja2Vk
LWJ5OiBEYXJpdXN6IFNvc25vd3NraSA8ZHNvc25vd3NraUBudmlkaWEuY29tPg0KDQpCZXN0IHJl
Z2FyZHMsDQpEYXJpdXN6IFNvc25vd3NraQ0K
