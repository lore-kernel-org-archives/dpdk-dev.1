Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B360FCA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 16:19:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B39C3402E4;
	Tue, 26 Aug 2025 18:19:44 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11020116.outbound.protection.outlook.com [52.101.61.116])
 by mails.dpdk.org (Postfix) with ESMTP id D2DB6402D8
 for <dev@dpdk.org>; Tue, 26 Aug 2025 18:19:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOJIY0kVYmyoePbHOIZdIyLKByRLlC7NF8WM5dqnPmZtgx4jh7U8dRE06WNZ46aKByVYTO+ngakWeCizXOgjJ3GXl/jIrthxTrMB/lCWOvaGTw+pS3ZjJFL1zCYHFQINTtUxPEvTTw5eSx0QHj468S6OpILvKszFyCm79Xothz+8o7FamtaXt0EwH3/v4yT7Odbs9sSqoP+o+cb2kq/9Bc9JLW1BnRE+ZOF3WEMLq8OZxQ0nnaIc7RB8LN2GKjwfxST7m29SkVpSbVmiN/GVGj/tc+JL7B8v1bsDmEDmXm/+J6EusKZW668Yb0QSyHpfh6Vc93yY/d4Ph8/g2aN5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfu6b0ftLukexXp1cf2YT5s0F7zhuKwqcGvSQjk5S6g=;
 b=vMbr/HE9bW1e13K0cEgRhYAbOoZIRK211gcDBSO8LkRKG+qdZr/qbQGN6DAnFFZFdUtFRy2L0AEQ+Qnh758fdQavdX5TlJmh5aXylaLrGpidFr+uhQiFvl0tcFcCSUg5hxLSZKc4x5K8b3eK9S+lfYC1RV2UcsT5q4ydSC1UYN1rCPqAs4Fugegfirq4RDOhl0FLjSNXrSFIMzBh2YEkx6UWbIFG2GSpbWp533zCC2++EfWRs8IVYSN+IiW2lsZuoFznCrsFVuXGA19wVc4jGkTSZgAXgwSHVyrKHLN9ZnbLMLJwTiezQnOLNGletSY7l6TbppR6hQR+il/k2/F9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfu6b0ftLukexXp1cf2YT5s0F7zhuKwqcGvSQjk5S6g=;
 b=cUA3RT79WvwzUHIi7KrLDCt0e6ePBkwQi6kNZtewsQMzwu468MHZ8OrJsrDWok0GQ3croW36C9iNc2ETSK9MJbt3tPR7GzKEw4f8N7/dtBPD59MMP13I2Yzmd1c/0NIyNNGiL8fExSqIN6A5+DSBptDHM7cRmmgAkPTtyPj219Y=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS7PR21MB3269.namprd21.prod.outlook.com (2603:10b6:8:7d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.3; Tue, 26 Aug 2025 16:19:40 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983%6]) with mapi id 15.20.9073.006; Tue, 26 Aug 2025
 16:19:40 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Wei Hu <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH] net/netvsc: cache device parameters for
 hot plug events
Thread-Topic: [EXTERNAL] Re: [PATCH] net/netvsc: cache device parameters for
 hot plug events
Thread-Index: AQHcFpEx8h7+KYdA0Uu3XBkwstXfNrR1HS1A
Date: Tue, 26 Aug 2025 16:19:40 +0000
Message-ID: <DS3PR21MB57356440D86EDBAD82AE24BDCE39A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1756170959-19822-1-git-send-email-longli@linuxonhyperv.com>
 <20250826065606.13738b90@hermes.local>
In-Reply-To: <20250826065606.13738b90@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=846fc6e0-a0b6-4fe1-bc97-2ba8e8042a8f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-08-26T16:19:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS7PR21MB3269:EE_
x-ms-office365-filtering-correlation-id: f7592d02-5e66-46c7-d12f-08dde4bc5bca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bzA5WkhueGdDajlpYi94L1d6bGZqQ2dLajBIQU5BMW5nTEFGMFBGcHNCVExy?=
 =?utf-8?B?UmV3alljZFlqWWMwS3R1Vjl6UFNwd1ZROUVGeGNycTc1SjdqaWVKMXE1Yzlo?=
 =?utf-8?B?V1plcHNhSGRVaDVaOU9Pd25tbW55VmtzUFoycWptQmlYNUZXc29FOEZNaWx0?=
 =?utf-8?B?NTNreGZVTFpDVFh3SFJJMjl1U2cwaktqSVpvOGwyL1NSTnJpaFErWHQvQkFQ?=
 =?utf-8?B?OXpzb3c5R2JyUG9rOGNYSStFcWY1NUd1Q1FIby9zbTRGblpoTHhuWUNydk04?=
 =?utf-8?B?Q2M5bWhoc2ZUN3Zmall3OFNWcVBES1lTSW96eGtVUS9kUmQwQjhoMG0vaUU1?=
 =?utf-8?B?ZHNIZ2dvQnZReGpXNVdRUmZ5MDdUTWpxSFArT2tiS0lWVlhjZ3gwenRQQllT?=
 =?utf-8?B?SFZBNHdDZ0Vma2FqVFlRTTZlQVlEL1I1aGZicXpMcGd5Vk91c09CS1hWeFNW?=
 =?utf-8?B?cXhSVFlUR3ZhY0JYeE80THh2MTk2K0ZESGROaWVQbXVxM2VUZTJzWW80RzdR?=
 =?utf-8?B?bzlsdEpSSWZVUlBOY2V6N3I5OWtIVUtCaTBFRlVFL2YrVFZtbCtrZSt0SGZH?=
 =?utf-8?B?NXNZblR4SHhDWnBLMDVVSEJuZXpaY1MrQi9VSHE2aU03c2NvVFN1V0drVjZZ?=
 =?utf-8?B?TVZKZXFFelIyVDNac3crbVoyTzZwTWVBNm9hMUd1SkxscjlRdW1YdTE4UDZO?=
 =?utf-8?B?VkJCU04rUmlBL29yOFpJaks1UXZrSnZqUHhndDM3QWtoU1V2WEIyVm1TUkE0?=
 =?utf-8?B?a2RLdkZtMkhQQTJpS0VNVXNiVWJBMWEvY1o2eDhGREtiUmFWRkZXc2VodmtG?=
 =?utf-8?B?d3FFODlaaFExODY2UGgwMEJ0NC92K0JKdjd6Rnd2aTVEaXo1MFpra1FpUGJD?=
 =?utf-8?B?RG1PRDd4a0paVE1nOE80emx3N1FPd0tvMFVpQVNGOUZBRE03RlBXeWlsUFJK?=
 =?utf-8?B?TVEySFFCVkJYMVhCdlYwZGtQejJiYno2d1VYWTJ1TEROaVhvUVFRQ2Rmblp3?=
 =?utf-8?B?a0hRV1NwUFBrSE9uemErUWlxSjV4QmNjejg2cGVoUi9hRHRCQmxybXF4Q1ZQ?=
 =?utf-8?B?cnlZbldoUUx4OTJCSW1GRjJ4TFBrVWI1cDUvL1pWem9LU0lzQWE0c0lTZSt6?=
 =?utf-8?B?U1BNWTY2WWpkQTU4RzNwK0tKeUlPU29kRmhpMXBranRsRWRjZTM2MVhla1BT?=
 =?utf-8?B?UFZ0bzY4NS9XazJCMGZ6ZVJTQzVxNGZSWHA1NGh6Q3hGM0M5Nmd6dnA5eHZN?=
 =?utf-8?B?SGtnT2dpdXcwMTZMMUlhOVc4T3lyTU5MSzg4N3dkYU9YOGk4U1lLbGZyRTNN?=
 =?utf-8?B?YytkRDBPRjVvR2pBN0xvN3ZkLzRoenRIcm5mOE5OT1ZIN3FCVlBGNVdLR1or?=
 =?utf-8?B?STVwdVdyVzQrekFBWWRLcDR2ODRpK3U2T0NnSnhrS3JtR1lReU9wSHFkQ0xq?=
 =?utf-8?B?c3JFam5EV3Z5dkJkaW5pdkswMUx1U1J4VTNXcUtUMUlDRU1UZzFOVENQMVpK?=
 =?utf-8?B?Yy9TZlJaUmN0WkJveWN1UVN4Z1ozKzBqeDEwTzhCRDkyaXdCR3lFSzhJTDNH?=
 =?utf-8?B?Rm1zMFJITEZZOUpoQUV0N25zd0JkclJpb1Zma1dRaHVDL3ZrZEtndm83bkdX?=
 =?utf-8?B?czlGeG1BbEJMZ1ozREVlelY0UmlkN3hsekZqdjZOZjljWTVUMlBFbTR3Ui9C?=
 =?utf-8?B?dkNXc1AwZzRIWi9zUkF5OE1ObUZGOFlJenZQeVh4MXU3Z0loS0FDR0V2UGkx?=
 =?utf-8?B?U0JhcHFKZGc2U211Y1plVXNvS2VLV2lUcFNxRjB1YTRlTUxzNEJkVU1USjUv?=
 =?utf-8?B?bjIwTytGVUg3bWVvcE4velAvVm1LQlNST3NvdUtjVzhobTZhTmcvL0o4OCsz?=
 =?utf-8?B?ZVR1T01HV0hmM3huL09QTFFjWVJUUjJ4REVzVmFhZVpOR21iRlNYSHVCeTAv?=
 =?utf-8?B?OEtoeGkvRVBNaE4zMkhvUEpDUDJ2M3E2cFU2NjZzMDdnNDRjaVB5djJOOFdU?=
 =?utf-8?B?bm1vV3BVZit3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3NKUXJGOFllQXpaRFFwMDVTZ2xnNlhMRDYveEV3Nlk3Wmk5SDdUTWlGcTJI?=
 =?utf-8?B?RHdFUkJ6dzlMRVJ3OXZKQXN6SEZMWjBTNk5QdkczUTZSV2JuZ2ZpSnI5MWZ4?=
 =?utf-8?B?TGd2eWdzYUczZTR0RHF5UnByWTMyN092cmZGZnZvQUwxMzhLUFViSkR3WGJz?=
 =?utf-8?B?RVd6MGZ5dW1rOE5DaVZDUEJkL3RSMG5GRENaT2NiVkZienR0cG9LMjFQZzl3?=
 =?utf-8?B?NmZ6U0FYU01BTnJjcUtRZEVXTnVLSnlueVlDLytOaS9sOS9UUjRQVlNxZWhp?=
 =?utf-8?B?bkRrZHhtRDZTMVFWeDBoaCswM0N4UXZpcDIvWE1LcDNlYktuRE1Fb21oRTBw?=
 =?utf-8?B?OGt3ZGpWM1J2amxwYnVmNEg1ODhNaVk1dWVUUVdSaHNhYlFMYXIvanBiOGtI?=
 =?utf-8?B?KzMycXBBd2FsWWZMSGRZbWFITTV4TlZSVE5wZ3JkQ1ZPVi9acUFYUExsRWFF?=
 =?utf-8?B?cnhpQTBJSElLVmxlazk0azVnWlZUYlA3bWNzcU1SekVwS1hiS24wSUtHQlJa?=
 =?utf-8?B?ZXZSQnRNNDRMcklmY0dnaXFKUCtJYlViMVVySldRRVFPbnZqZ0VMVEZIQ3pp?=
 =?utf-8?B?ZThjSHIyUjZtSm1STUFCeUtleVcwYXNUa3RwY1EzOXJtNk92ZnZ3dElud3FV?=
 =?utf-8?B?STZBbDBLQlUzY3prVEF3eUd5ejFlbnRKajJieEJ5eWdVT1ZUaFAwQWRTaFIz?=
 =?utf-8?B?L09TNGJVOTcvSWNYdXFMek1wd1dFSXp2Yitvemx1ZmcyWjllakxXSDQzZkY5?=
 =?utf-8?B?MUxBcG1mbzJqS3NhVnJKK1ZJRzBVZjhMRXBMMUVJaHFaWUhQL3BoWFZjS0hy?=
 =?utf-8?B?ZmRIdmxsRkNTblZGWXRBcy9tMUFwbHh2czJFNUZNRm1mMlRBaUd6QzRNYkdJ?=
 =?utf-8?B?Y2pVOWtleWZVREpJbWJzb3dkcWplcHBGOVQyWFhucC9VTWV5S0R1S01qSVl1?=
 =?utf-8?B?a1FvODVkdEFrenVXUVM0ZHJCTkN0c29kU3lNZnRrdUV0STRqZGpjY2ZZZHNw?=
 =?utf-8?B?cFE1c0hLWW1oT1QvbVNjRy81cW5sR05QVlphSXRudHhGM20zNm9hSGhRZEU2?=
 =?utf-8?B?WVNFM0xERXoxcmZBY0FlSUVWcG1xQ2lsY1krdDF3ZkhUUUFsR3FJSGFlR01n?=
 =?utf-8?B?aGRZRm8vdWJYOTBodEhjSmtvR2ZxbjZKWEpZM0EvL2JZZkw3VzZENmtFN1Mv?=
 =?utf-8?B?U0VDd2g4cnlGeFdxTVV3ZFo4VHpLVXU2UEZOaHRGQ1NLMG5sNTR4OFNybUpC?=
 =?utf-8?B?UE5EWWk1RGRHS21Xb3RsV1BFTkNWdHZiVUtuNFVXUVk2SkdVT0tJTHN3Ykc1?=
 =?utf-8?B?V0pIdFdXdVpQNjZreFBDeEVORU9xMHlMTWdldWU0VzVTMkpRWmdOamhLYSs1?=
 =?utf-8?B?OWRLazBnRDdtOUNqSVBWSitPbTBmc09Wa0VhcUpWTExSbXJxMzdhc0pnQzU0?=
 =?utf-8?B?N21ueEtvZHpYNnlUUmVrdHNZZFh6M0ZkSVFaR0kwZ2pHMXpyaEk5NzBWYmVO?=
 =?utf-8?B?NUNyOVZ0T2NSditIc2ZGWnZyTEFGYUl3UlExVXp3a1JLY3ZhVkFPWWhSUEh0?=
 =?utf-8?B?aklCekhuaDFWSkVEWm42Z3d5K3lxYzRKRW9POTk1S3hldlZRMFpDNnlEa3BV?=
 =?utf-8?B?ZU9UYWJlRnBiY0Rvd1JMRVFvSWNucXZGL2JxcjQzaDQvQzdreUV1enQ0T2RS?=
 =?utf-8?B?Ny9QZitVN1Q1cTdKdnNMd2RNYXl4V2JuaTE0RWlIMEhSNTdDUks5YWNpSWFI?=
 =?utf-8?B?VlJ3MFN4MVNEREhxVkdQTFJ6NTBFRVpaUzRjd00xd2xxS1dDUkJySlNIL3pR?=
 =?utf-8?B?VnpQdDJPUDhoaGdrMHhsQ1AybXZYaW1mVi9mN29FVzVreDBlbXN2QTduNmtk?=
 =?utf-8?B?U2p6V0VWZFVkWEplUGJ3ZlBQU0cxWXNzK1krTFgwMHlqNUl6V0UvZjdiVC9C?=
 =?utf-8?B?TXE0b3JEMEVLdFhDbVN6VGhGZC94blJZSE9SNEsyaG8wS0Y5QnB4MXVuK1NL?=
 =?utf-8?B?WHFHZ0FURjZ1M3VnV1dKREl4ZVQwa3dZYVlIMXpUWnhkMmtzbXAzTS9TK2tS?=
 =?utf-8?B?TnRib2JORkxmQzZJSDF1Z1AwUldpRU81a2tWT0J4aXo4RnlnL0liRXVSK1Rw?=
 =?utf-8?B?L09MUEJGOEVqNStBajNnRnNEb2FaMys3T1p1Wk1nNXF0dy9OWUFDRmE3OExi?=
 =?utf-8?Q?rPQa2Ac89mnysYHwUtgPkHENiQGM7qoB5Vm9aK4YwOhy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7592d02-5e66-46c7-d12f-08dde4bc5bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 16:19:40.1331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXQSgdUjgsUPMxiW0ZlE594qptSZoJKdxIHtFdIkVk5mNYAIzr0FyRFgoAXV4IOFEtoxctyzl7YrCL+0pQUpxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3269
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

PiBPbiBNb24sIDI1IEF1ZyAyMDI1IDE4OjE1OjU5IC0wNzAwDQo+IGxvbmdsaUBsaW51eG9uaHlw
ZXJ2LmNvbSB3cm90ZToNCj4gDQo+ID4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5j
b20+DQo+ID4NCj4gPiBJZiBhIGRldmljZSBpcyBob3QgcmVtb3ZlZCBhbmQgaG90IHBsdWdnZWQs
IGl0IG5lZWRzIHRoZSBzYW1lIGRyaXZlcg0KPiA+IHBhcmFtZXRlcnMgdGhhdCBhcmUgcGFzc2Vk
IHRvIEVBTC4gSG93ZXZlciwgZHVyaW5nIGRldmljZSByZW1vdmFsLCBhbGwNCj4gPiBFQUwgZHJp
dmVyIHBhcmFtZXRlcnMgYXJlIGZyZWVkIGFzIHBhcnQgb2YgdGhlIGNsZWFudXAuDQo+ID4NCj4g
PiBDYWNoZSB0aG9zZSBkcml2ZXIgcGFyYW1ldGVycyBmb3IgZnV0dXJlIGhvdCBwbHVnIGV2ZW50
cy4gQmVjYXVzZSB3ZQ0KPiA+IGRvbid0IGtub3cgd2hpY2ggZGV2aWNlIHdpbGwgc2hvdyB1cCwg
Y2FjaGUgYWxsIHRoZSBQQ0kgZHJpdmVyIHBhcmFtZXRlcnMuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gDQo+IFBsZWFzZSBmaXggdGhp
cyB3YXJuaW5nLg0KDQpXaWxsIGZpeCBpdC4gVGhhbmsgeW91Lg0KDQo+IA0KPiAqQnVpbGQgRmFp
bGVkICMxOg0KPiBPUzogT3BlbkFub2xpczguMTAtNjQNCj4gVGFyZ2V0OiB4ODZfNjQtbmF0aXZl
LWxpbnV4YXBwLWdjYw0KPiBGQUlMRUQ6IGRyaXZlcnMvbGlidG1wX3J0ZV9uZXRfbmV0dnNjLmEu
cC9uZXRfbmV0dnNjX2huX2V0aGRldi5jLm8NCj4gZ2NjIC1JZHJpdmVycy9saWJ0bXBfcnRlX25l
dF9uZXR2c2MuYS5wIC1JZHJpdmVycyAtSS4uL2RyaXZlcnMgLQ0KPiBJZHJpdmVycy9uZXQvbmV0
dnNjIC1JLi4vZHJpdmVycy9uZXQvbmV0dnNjIC1JbGliL2V0aGRldiAtSS4uL2xpYi9ldGhkZXYg
LQ0KPiBJbGliL2VhbC9jb21tb24gLUkuLi9saWIvZWFsL2NvbW1vbiAtSS4gLUkuLiAtSWNvbmZp
ZyAtSS4uL2NvbmZpZyAtSWxpYi9lYWwvaW5jbHVkZQ0KPiAtSS4uL2xpYi9lYWwvaW5jbHVkZSAt
SWxpYi9lYWwvbGludXgvaW5jbHVkZSAtSS4uL2xpYi9lYWwvbGludXgvaW5jbHVkZSAtDQo+IEls
aWIvZWFsL3g4Ni9pbmNsdWRlIC1JLi4vbGliL2VhbC94ODYvaW5jbHVkZSAtSS4uL2tlcm5lbC9s
aW51eCAtSWxpYi9lYWwgLUkuLi9saWIvZWFsDQo+IC1JbGliL2t2YXJncyAtSS4uL2xpYi9rdmFy
Z3MgLUlsaWIvbG9nIC1JLi4vbGliL2xvZyAtSWxpYi9tZXRyaWNzIC1JLi4vbGliL21ldHJpY3Mg
LQ0KPiBJbGliL3RlbGVtZXRyeSAtSS4uL2xpYi90ZWxlbWV0cnkgLUlsaWIvbmV0IC1JLi4vbGli
L25ldCAtSWxpYi9tYnVmIC1JLi4vbGliL21idWYgLQ0KPiBJbGliL21lbXBvb2wgLUkuLi9saWIv
bWVtcG9vbCAtSWxpYi9yaW5nIC1JLi4vbGliL3JpbmcgLUlsaWIvbWV0ZXIgLUkuLi9saWIvbWV0
ZXIgLQ0KPiBJZHJpdmVycy9idXMvcGNpIC1JLi4vZHJpdmVycy9idXMvcGNpIC1JLi4vZHJpdmVy
cy9idXMvcGNpL2xpbnV4IC1JbGliL3BjaSAtDQo+IEkuLi9saWIvcGNpIC1JZHJpdmVycy9idXMv
dmRldiAtSS4uL2RyaXZlcnMvYnVzL3ZkZXYgLUlkcml2ZXJzL2J1cy92bWJ1cyAtDQo+IEkuLi9k
cml2ZXJzL2J1cy92bWJ1cyAtSS4uL2RyaXZlcnMvYnVzL3ZtYnVzL2xpbnV4IC1mZGlhZ25vc3Rp
Y3MtDQo+IGNvbG9yPWFsd2F5cyAtRF9GSUxFX09GRlNFVF9CSVRTPTY0IC1XYWxsIC1XaW52YWxp
ZC1wY2ggLVdleHRyYSAtV2Vycm9yIC0NCj4gc3RkPWMxMSAtTzMgLWluY2x1ZGUgcnRlX2NvbmZp
Zy5oIC1XdmxhIC1XY2FzdC1xdWFsIC1XZGVwcmVjYXRlZCAtV2Zvcm1hdA0KPiAtV2Zvcm1hdC1u
b25saXRlcmFsIC1XZm9ybWF0LXNlY3VyaXR5IC1XbWlzc2luZy1kZWNsYXJhdGlvbnMgLVdtaXNz
aW5nLQ0KPiBwcm90b3R5cGVzIC1XbmVzdGVkLWV4dGVybnMgLVdvbGQtc3R5bGUtZGVmaW5pdGlv
biAtV3BvaW50ZXItYXJpdGggLVdzaWduLQ0KPiBjb21wYXJlIC1Xc3RyaWN0LXByb3RvdHlwZXMg
LVd1bmRlZiAtV3dyaXRlLXN0cmluZ3MgLVduby1wYWNrZWQtbm90LQ0KPiBhbGlnbmVkIC1Xbm8t
bWlzc2luZy1maWVsZC1pbml0aWFsaXplcnMgLURfR05VX1NPVVJDRSAtZlBJQyAtbWFyY2g9bmF0
aXZlIC0NCj4gbXJ0bSAtREFMTE9XX0VYUEVSSU1FTlRBTF9BUEkgLURBTExPV19JTlRFUk5BTF9B
UEkgLVduby1mb3JtYXQtDQo+IHRydW5jYXRpb24gLVduby12bGEgLURSVEVfTE9HX0RFRkFVTFRf
TE9HVFlQRT1wbWQubmV0Lm5ldHZzYyAtTUQgLQ0KPiBNUSBkcml2ZXJzL2xpYnRtcF9ydGVfbmV0
X25ldHZzYy5hLnAvbmV0X25ldHZzY19obl9ldGhkZXYuYy5vIC1NRg0KPiBkcml2ZXJzL2xpYnRt
cF9ydGVfbmV0X25ldHZzYy5hLnAvbmV0X25ldHZzY19obl9ldGhkZXYuYy5vLmQgLW8NCj4gZHJp
dmVycy9saWJ0bXBfcnRlX25ldF9uZXR2c2MuYS5wL25ldF9uZXR2c2NfaG5fZXRoZGV2LmMubyAt
DQo+IGMgLi4vZHJpdmVycy9uZXQvbmV0dnNjL2huX2V0aGRldi5jDQo+IC4uL2RyaXZlcnMvbmV0
L25ldHZzYy9obl9ldGhkZXYuYzogSW4gZnVuY3Rpb24g4oCYcG9wdWxhdGVfY2FjaGVfbGlzdOKA
mToNCj4gLi4vZHJpdmVycy9uZXQvbmV0dnNjL2huX2V0aGRldi5jOjE0Njk6NDA6IGVycm9yOiBh
cmd1bWVudCB0byDigJhzaXplb2bigJkgaW4NCj4g4oCYc3RybmNweeKAmSBjYWxsIGlzIHRoZSBz
YW1lIGV4cHJlc3Npb24gYXMgdGhlIHNvdXJjZTsgZGlkIHlvdSBtZWFuIHRvIHVzZSB0aGUgc2l6
ZQ0KPiBvZiB0aGUgZGVzdGluYXRpb24/IFstV2Vycm9yPXNpemVvZi1wb2ludGVyLW1lbWFjY2Vz
c10NCj4gICAgc3RybmNweShjYWNoZS0+bmFtZSwgZGEtPm5hbWUsIHNpemVvZihkYS0+bmFtZSkp
Ow0K
