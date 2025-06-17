Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5A2C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 21:15:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D71A6410F6;
	Tue, 17 Jun 2025 23:15:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 65CB6400D6
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:15:10 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HD5OOC023009
 for <dev@dpdk.org>; Tue, 17 Jun 2025 14:15:09 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47b8xhh5vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 17 Jun 2025 14:15:09 -0700 (PDT)
Received: from m0431383.ppops.net (m0431383.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55HLF9on001712;
 Tue, 17 Jun 2025 14:15:09 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2131.outbound.protection.outlook.com [40.107.96.131])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47b8xhh5vn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 14:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mk1/ZsvW0wirnEc54ZuAnR5Rr3QTexQbaM6Z7bG1yscNwEt/82H/PeNPb6C1wqe/EPkSClLaxvpGGPSmvPouxwhdGp2990NzZp82cu4C5KNXwRbHU7p71Hk+cLERjgKBll55XOtxMCqeXlDg1TCnEovE6I6l+ERtM51O1kzdihvJSt8FtwoWY3qPs4EofMOBYhVAxSD3ADHdnl93JvWt5vt2wJyGzC6AToM47TwCLf0k4/VmHttuEMoEY84QicCM5oG977cfJVB7JY0p4p9j9cVD70CvnTUd213lEl4Dj4Ha9AMDrcbzmDEG4kNpzYdf5WKF8AUDzSabV8nAYGHTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CQVOFEejsyObaP04PR8K6wxUOySkXQpqsWlg0bFdLA=;
 b=IPsxbNc/oSF25QcrF5hzOYKwG0SIeJNia+nbtixdkrrU1NBisxzDBEXhhjIIWIkTwQ+fWrVk80283gnM7TpScp/PM3mkNkMoQ3BI+mBK8Pu4gOj1/BWens0MUUW5aUeSRqt6PQH/iujHB2JcEBMfQM2Q1RAbz0/BHuwSTQEGQMzTRPfsOmV0a8ZmOkmL/wsMmt/GGPgMaWbYOi9Aukf5DvqzQRZmE52WSzOuJXl5tC5Yo1hnfzoU+a5XCSkroxdRt36fnYsaItvSHkkrxlcZIhMM3TPF3gqUoPoftFFgboqLDd6XKvM1Me//S2PNOujlElqJuCphc4yDbltVNa16CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CQVOFEejsyObaP04PR8K6wxUOySkXQpqsWlg0bFdLA=;
 b=ivFEiywYXMZPnol02RLdNcBIpTF5r+PEVjuxsFrwDqotz34rQvZpa9CaM6+QvPc4b9+OnoBEGPJj/kozIspCvt3IXwWk2tXKXyURpFRq6wzCUimTQe1vEluNKAjptvGWdZp1vgU9Rjxeo5j5FANa3lq7iZLj6iS8hHiSfQwWBFQ=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB5755.namprd18.prod.outlook.com (2603:10b6:408:1ad::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 17 Jun 2025 21:15:06 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:15:06 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v1 1/1] compress/zsda: code cleanup
Thread-Topic: [EXTERNAL] [PATCH v1 1/1] compress/zsda: code cleanup
Thread-Index: AQHbz6PcE3QTUs/AZE+Og8fKH0gA+bQH+mBw
Date: Tue, 17 Jun 2025 21:15:06 +0000
Message-ID: <CO6PR18MB4484595536E3C359B7CED37CD873A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250528073553.2567982-1-li.hanxiao@zte.com.cn>
 <20250528073553.2567982-2-li.hanxiao@zte.com.cn>
In-Reply-To: <20250528073553.2567982-2-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB5755:EE_
x-ms-office365-filtering-correlation-id: c1c4dc4d-78e8-4758-23d2-08ddade4089b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TDhYQmZaV0J0WUlXbWhLUTB1ZkhUelpaZ3dYUktHWmFHQzdxWWx3L3pZVkxv?=
 =?utf-8?B?WUM3cjNTOUgzZy9ra0swcisxK3pXbUVhVTNwV3lySnZEbEJ6TG9pNTA4RHJT?=
 =?utf-8?B?WDBjU2ZTdCtiRW96dnZheUl6SjhnOHRGQzFHelJ1bkd3QjlCSjArVHV5U0Fv?=
 =?utf-8?B?VGJyOTNwdExZKy93clV4UWZxa1Q3N2t6M3FQeE1rK2dFVktJSTBDUWVRS0Q2?=
 =?utf-8?B?dGlBYjJFdzVCMnhwMDFvYVNPSkpsYkwwazF3TGZtTjIyaFNuZ3FheTc1aWJi?=
 =?utf-8?B?aUFrZ0t1cDlzUldvVHM3TUVQbU93UGQzOHh6elkxdDZNZzFJM1JGdEhITmdq?=
 =?utf-8?B?anc0Yk8zc0NOVkptYXBVc1M0bHN3YWsybUxXUk5MalB1LzQvM09DcDNvZ3FU?=
 =?utf-8?B?djhYK3hFenY4RkgrT1VobnVSdTBsZk9EZnYxM0JMSjhpeDAwS1RPanIvWG93?=
 =?utf-8?B?cUwrVTBhL3dxd3g0S2hnR1R4d2pEZ1FRTGx6b1RCNjh3b1diVmFVQlo5dm1Z?=
 =?utf-8?B?UGdqOERUOWZXVnZVaGppeW1yb2V4ZjIveG00YnV4TitsWHdBd21lMHZ3KzU3?=
 =?utf-8?B?V3lwaUJLcit0TUIvdUpCYTI2dUhRSFZDbzNlWjhuOVNmc2ZvdkkzVVhLbjVo?=
 =?utf-8?B?b0ludnZRNnU0U2h4b1BCMlpRZTRFcTdwWVJaSlJNbVlKYWZrWDZ2alR4cFk1?=
 =?utf-8?B?NWlrclRXL2RsQ3lwTGlYRHVzTklBSncyMWI0bllMdDhMRUI4U25GclB3dEd2?=
 =?utf-8?B?Ujg4eWtQaG92VUZSaVZrNm4xMTQyS1FmOVljemV3TGRlY2loYktLRmkxRWJx?=
 =?utf-8?B?WUpDSUFrWUo4ZlF6NGU0SjBtaEJXT3pjRW5ZREJUVTJwWUR4amU0MHUxTDNR?=
 =?utf-8?B?REVFazBTc0R4bHQ1MXArUVJqdnFTWFNxd2EwNE1jcEM0aDVScU9vSFV5OHNl?=
 =?utf-8?B?SmxvMStRK05pblpIUDVkcWZxcmdqelpHd3gyWmlBU1JkTFdxV1JKLzFFMEx5?=
 =?utf-8?B?dHZmdGFTRWZ4SWlYRVN4NmpvQ1Y4aEE0VFFaRkdwYzkyck55Y0t6YTlOZlhK?=
 =?utf-8?B?dkFMc092TlR6TGwwbkEySnRXVXV4empNSXNXaWRBdXVFbkF0OFVab3RPUWl1?=
 =?utf-8?B?UWF2TlFheDVDQi9MdGQ0eFBSVTNaOFRPZFFWZkRtTzJ5SzkvQUtKeCtOUkNI?=
 =?utf-8?B?NmhKWHppTXJ4bU42RW9pRktxVWJ3eDIyRkQrc2RtWlFCVHRTakd2QitKRkNu?=
 =?utf-8?B?YkUrVzRMRUZSMHhLekJqMUlCRDBKQjdYd0pnMjR0UWxKSGVTNmpIQkU5aE4v?=
 =?utf-8?B?MFZiMWxsZjY5YUFyd0RTR2o1T3ZzNHN5Nnd0VWVtZFdNaENObld6WmFTdTZk?=
 =?utf-8?B?VjErTUhaZWY3OEx3OE9TanlTbmoyNjZUbVlLZXVvU0lRM1IvNjhJVkNTMUYv?=
 =?utf-8?B?YnIxZEgyMlh5bWl4aUV4dmN0ajRnTkZsdFdOUTBQTGFQT3E2cjVrNzU0aU1m?=
 =?utf-8?B?Rkh4VXR5Y1YzZ2lPaXY3Q3RBbk1rMERNUmgyYTNsMTB6T1UvYjhaWXUvc1Fo?=
 =?utf-8?B?M2lueFI0bEhuSC9Ib1NCMzJQN1ZDQjhyTldYczlqdmxBRjY2ZWlQTWMranYw?=
 =?utf-8?B?R2cvaVMyeUpNRE1tZFNNTkh6VUVYSUliUHdLUnBVMjAvRSt2WkY2OEFKV3U3?=
 =?utf-8?B?dS9UUGh6MDAyZVN3K2cxVXFKVHN4L3BIRG43SlYvZlIvL2c4TW5vY2VvYmEv?=
 =?utf-8?B?RWZTQU5JNEJ4Uk5ZZlJIY3BEMWlEbEhjazVPa3JyaThQMjBkYW9FUklNM3Ri?=
 =?utf-8?B?d0hJblgvYWJySmhFOG01dUhFS0FudTVSUDVDcjlHR3RLdmNHNjhBS01Lemw5?=
 =?utf-8?B?bFQzbUVDa2ZwQkNCNVBVRVFia3dRWlpyaXpmQWhtSDcwZERMTXo3c0lLNkky?=
 =?utf-8?B?TTFBcTk2S1JUeXhzandPcE1jdE4xTnlSdGo1bEY0ek5XZkxuM2dlQldNbFAw?=
 =?utf-8?B?eFNXc0hWOEFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1FOUG5QK3lKVWE1TGdHdnhaWHpjTHNqVzZEYktKM0wwYXdZZU55ZWVBRVAr?=
 =?utf-8?B?enBhWEdCNmpXdWRTRFkrd0VraHRNSVBDSzhOa3paeWUwS3JEdmVKbGhEZzdz?=
 =?utf-8?B?OFNuUnlqUXJLM3RWM2UwTGRNSGIzMFdpSFlRdlB6N29qQU1EaW1NUTlMeHEx?=
 =?utf-8?B?K0ZKZy9JUDlJQTNDaWd5Y1lNeG1vMXBSRU54Szd2a2JXN09EdGN1WkppUmQ0?=
 =?utf-8?B?Y3hHaXIyL3Ard0lScUtKQVVoUEYrbFg2ZEh2NnFsQW5XczZ6ajkyNStvQ1li?=
 =?utf-8?B?c2NyLzFmVU9vQ2FTYmp0enNWR2NwbllzaU4vZDJHY1dtYVVaenpXNWEzREVT?=
 =?utf-8?B?MEQzVmxwWElhQWpQYjdLZVBPSjl4eUJUV25kTTc0WEE2NExmRUNxZUppOGxa?=
 =?utf-8?B?cEJQdEhJV2psYXpzY0xWMi9HVWczelMvem1ONTVDZXJ3dUdueFFaZlNkMFZD?=
 =?utf-8?B?Z3g0L0IyRHZhbFcxVzcrcjRabGNRQ0d5NS96RnFnekZwQW1kRnVPZVM0WXZ2?=
 =?utf-8?B?T2J4Q2s0YVlYL0NVdlJJazdnMnY4QnhhMHRlWHpvVWg5U3AzYnZWYVBZck1a?=
 =?utf-8?B?OUt6SndmL1dWVW1UYWFlVlU0RnRhOEV2Vi90RHZTR3Rpa2VpcmdUdFI4RXRL?=
 =?utf-8?B?OVNPUHpLNWw0OWo0UVZFUmsxWnNndXI4NzBWSzMxRE0rZXlpOW82MXpTM3gw?=
 =?utf-8?B?Mm5vL1pYWVZOb3JkZEhCV0ZIR0IvYnUwWm1GcDVhZEcxMERxSURjOWZnd29P?=
 =?utf-8?B?NzZzZkg1djhZWUppNzZ2MGp5UXI0cVJMbFlxWDg1dHlSRjVpTzFvQkFNNVdx?=
 =?utf-8?B?TU80RVNncE9YdVRMQ1hxank4eURmbDBySlViOUZ5K25iMC9HSDhLTmxWNXFD?=
 =?utf-8?B?czN2dGtycGlWaSs5Y3h1TUoyVTVnb0QxRzlzUVNadERCendWNTcxNk9kWUJH?=
 =?utf-8?B?a0FCN0ljUmpLU1VxNWNIWnZ1OTdwQU1oNHNpRWRZU1lwRlQweGg1c2FYWVFv?=
 =?utf-8?B?NEFhbXJpT0g3ckRURGh5eExGNDdMY0hkRHRudWI4dkgxZkhQT2NUbGdNbHVV?=
 =?utf-8?B?MUtqVnRtbVJsL2R4dkZ1eE8wYk5QUUwyaW1jZmFsd2NWTlZ2S3g5S0g0V2Ez?=
 =?utf-8?B?WDlKSkFSejZ1RTJ4bW9mUUxuVzU3Y0MzeWlDMXIybWFUMVQ1c2NiUU93bmRj?=
 =?utf-8?B?a0NuVTU2emo3emtRNEJybjZmam5aaW9VbU50djVlS0dHa09rT1lXV2pSZlZl?=
 =?utf-8?B?OUM5TCtzRUZXUXF3K3VwQ0Y1eElxa2ZVNnM1cm55NjVvTXNjK3BKQnN3bjk1?=
 =?utf-8?B?ZTBmTU16MFNmQjRZbXEwaFY1b2tDZVU3dFlSUGRjYS95cUpuVG1NVWdBMEVO?=
 =?utf-8?B?bWRUSzRmWFkwZ2hzaUQ1QkJVSU44Wmt4dmJLRi9hMExlZEplaFFrYVcxM2Zt?=
 =?utf-8?B?blo1TjBqUUJQYXN6c0hVTTljb1hFVnp4SDFxcGdkdjFPMHYxOTQzUHRrQVNU?=
 =?utf-8?B?SldMdXErTDA4Q3FaUnF0WTZ5UXZ5VEZQdzhVOFp0NFoyZ0FQMFZ2NzBiYUNa?=
 =?utf-8?B?QnVVMHQzMGx4b1N1aE82bUtUMzZuRWw5YjhSd0p2K2YrcDNkZ1pJK2JqdlpJ?=
 =?utf-8?B?SDA3N1RuTGFUZG9tb3RWTGF6cmNQdTFwVDFJa0JEblZoMnBFcWZqcUZtSFZN?=
 =?utf-8?B?L0tSTCtya1ZpSzhaOHdoK1RpeFM5Unhnb2tQc0xZU29EY01pekV4Vi9UVU9w?=
 =?utf-8?B?YlByUlgweW5BZTdISnJDWnRqZEh6dWhwWndJOU1aa2lITEt6SGdsZFpXNG4r?=
 =?utf-8?B?VnE1OXdpakt5Q0NxT21zTm1yeC8yRHpoOWRxRjV2dCtFMExIS3prK0dsTnVX?=
 =?utf-8?B?dldYa1Z0OUVpSkQyT3lFTzBGaFR3T21MSytTMDFJMm9SYWhCSnJITnpUVGJK?=
 =?utf-8?B?VzJ2VHEyZEdOYlhjTk8rR1Q3T1hBaVgwU2g1QXlDV3BGdW5NQWhjMkN1RkxT?=
 =?utf-8?B?L2RYa091dGkrbS9rZ1RvczA4c08zeUNzYVNybm5RL0NRbndrSEEvWWhHa0dM?=
 =?utf-8?B?Qk1pY05zNHJ2R2pEeEFFM25ySWhBZGRCVFpadjRNU3FkV3ZJWGJwMlRpa0Ry?=
 =?utf-8?Q?rk2g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c4dc4d-78e8-4758-23d2-08ddade4089b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 21:15:06.4949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjwLeLbQbDdr+oqPpuIfqCvOixaEqwNUCBcrRtUToOonJlpRWj93i3+V/C9rs+qksBv6YO+M0whd8cL558ujyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5755
X-Proofpoint-GUID: xSzUgO5vt-tHK1GBQESXDFu9RQTmOaHD
X-Authority-Analysis: v=2.4 cv=GJsIEvNK c=1 sm=1 tr=0 ts=6851dadd cx=c_pps
 a=+Vue+MaR3QDe/O8RMkujnQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=1RTuLK3dAAAA:8 a=iuu9Buti6KDp6XAk59UA:9
 a=QEXdDO2ut3YA:10 a=tZuXPeWvWlAA:10 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3MCBTYWx0ZWRfX7NHIOrWFWpSc
 FoWP0mHfptojvd1r5THH6Ejv670F6S919Mfu7m8gmW5RHmyosPkNwDf13AipLDQKC6pH7iujOqf
 pOp7ballpsvRjBlJINFBfMqRDBcKeA2pS71ujnrbIi5xNRbKxN+n7D/orYwLCSsA68uizmbYHAj
 MX7O2Y+p9VokfREYPXPac8ibHNPAL/bK7OEWZ6+wFmijkh7uO+UnWhD2o6mKqBa5A2RnXivzBs5
 j7K4hSuMSLGXayeOWIN60/NZB8fwiqRmZ8AzZ4xqzIgLqkfPjCy0Fd3nycBU/wQAFnekRElUMMD
 kDuxRLqM1cIo6fRDUqHkOYYZ4YlYv5w69MYejXInLbWyVEFicoSrmfJutSk49p1s6oMHqL2h74j
 hOG9DjeCLX4dfO+sTIW9LHlPRhzp9ap0kI7Wj8+Dl/saq6h1QDtKzWj2LKGcKrQbCweVxVJo
X-Proofpoint-ORIG-GUID: nbTxwCe8jo3tsuyJDNjbAU1xjM8Wfp5k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
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

PiB6c2RhIGNvbXByZXNzIGNvZGUgY2xlYW51cC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhhbnhp
YW8gTGkgPGxpLmhhbnhpYW9AenRlLmNvbS5jbj4NClBhdGNoIGFwcGxpZWQgdG8gZHBkay1uZXh0
LWNyeXB0bw0KVGhhbmtzLg0K
