Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01BAC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 16:26:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C543F406B6;
	Thu,  6 Mar 2025 17:26:55 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by mails.dpdk.org (Postfix) with ESMTP id AF1114069F
 for <dev@dpdk.org>; Thu,  6 Mar 2025 17:26:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6ICTfJkMweSCqz2nSimB4yGyT7oaSuChz5M/Ww8/K+8bgPlSkgy6gVkVAB9SMMydvmURRJvEzecMq/egTq7nv9oc6EBmFXdhoUETsN1pKqsZjxzUxStao0ym+JYy0moVFMPKXY5Q843SEgFVLNA0tLx1eh12Mcxz6E47urFCNKbrDobg7/JhgsbVIjZLGWi/yrwqB1gGBosCS2e56hmhL8eNetcqpQ1zYsYDk0XvqhSNGG71we2AwZq3t8Zg6zF2oE5TGxw3Z1clK8fivgwm8abzGmONApszmZ9N2iduIcDXE4oR5jxNvtUWCDxz+lRhBrDfWxuXLGlM8XAgzBi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+DkufJKdmoVigtzCS2MuOaj4mBwfRjRbpVyzO0AsiY=;
 b=W44ETzZxVWHbmXIf5J0CHQMtOFga5wbp9vOKmmwodCvuTmO+VWKfWxzE6eje2EqnlHMwoNHh/ELoxZhsz+JGPdL7r4Nf1su31iThLfjEpDYw/BHSobRxqULIWWB3myPDoYE2Ega582vxHE/oQF5o1Akd3nSpLJ6LNvQ/FOYfik4jX2d1ibgk8dqc7DfYzBsIxso2aF2FBJ5EkI5OAllFAZvdtSftzweLvTFZGU9FB5DUtZcNMvfPAA1t0lCJDxeJf5X29djj7+ns0L4YH4Mu3c1rI6a3OtTgEglhZw7ks84tqW1ItGSFdYZ06SOsIzIB/Cl3WkNthQwW3XYUYZhM6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+DkufJKdmoVigtzCS2MuOaj4mBwfRjRbpVyzO0AsiY=;
 b=qacNuZ0Ogi9OkyZtCzh1OHLN9JiwrXw72sRlRv3+hkolSPZgWKkpG7V9+nQqACNib5lGW2E4euqylDSORxjANKkaCSKjTmn2YNrTnaw5ESNYct2s2jP0BloyVvAkzscPZcyyaVNya1U9c9b70nLIFMiJuD2ZIVRGawc24CnI+cPLm6+JxG5olyqxZlgmBCZOwBMJgcajPXcJI7iTv2IMTcKB9O+s+1hZd0UertQ2nJHNeoXuwKnsJpEngk2q3cBEVSH2PnhVe5+2ViknDqOii30BHSiCfNBWpR3oV9B0pQcp0sGl3wScbPTcjIlGykYrQbhBBFxpK2IpguC/hV8beQ==
Received: from SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 16:26:50 +0000
Received: from SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784]) by SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:26:50 +0000
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
Thread-Index: AQHbfWyk6u++8mW2M0u7nGCEK4IWvbNQkOMAgBXbKoA=
Date: Thu, 6 Mar 2025 16:26:50 +0000
Message-ID: <SA1PR12MB9491E12CFD0E551E742ABCDBBFCA2@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
 <20250212163836.178976-1-shperetz@nvidia.com>
 <20250212163836.178976-2-shperetz@nvidia.com>
 <20250220103300.7148ddd8@hermes.local>
In-Reply-To: <20250220103300.7148ddd8@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9491:EE_|MW4PR12MB6803:EE_
x-ms-office365-filtering-correlation-id: 8114b271-88b5-40b2-c4a4-08dd5ccbb2d7
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NGo0T21aV2pBaHZSNkJzQ09jQUliSkdUWmFBejRCditCUnN0VklYRWpSNnJj?=
 =?utf-8?B?Si9jcTBjcWR4RzM5aklqWEFMTk9YNTFSdG1VQnduT0xLU3h5NkpiditEdCt3?=
 =?utf-8?B?ZFRzT0x2QkNVL3ZrUjJ0MVlHbHByS3lyeGZESXkrNUJob2wxdGJYZldkT2NW?=
 =?utf-8?B?UFpGQjBSeElYWFdzQldiZHBoV3FVL0VVc0Y0Vk5hcGF2c3dCRFg3VlNoMVll?=
 =?utf-8?B?RTB0YlFqV0VIcWNSd3Q1RVNsTDA5b2dhQThmdWdvWGVHTTFaVzJFSGJQblhV?=
 =?utf-8?B?NkxtRDFBcE5vcEtaZkNBUjM3dnRINGRtMlRKNk1KKzZ2dy9RdHFDVUhhUFFR?=
 =?utf-8?B?bEFDU0szaGt6eHpTVWFZcHAwb1AyR0tUT09ycExvYkVTWjY4OEYrTXlsQ0lr?=
 =?utf-8?B?cnphdkZkQkJrdHExMFZtMzFHWXlpNFZmaDZGaGxxQ1NTTEtyL2VqMFVwKzhC?=
 =?utf-8?B?SnZSZXdJeEpQT1V5Tkc3Z3dCR0dCSlZ3RVVidTU1YmlvZmpIWm96MzE1Z2d2?=
 =?utf-8?B?bktqMy9XM0tlRnppTFhLM25kZ1c4UXFReXF3YVdYMGR0UGVEU2dlQkJYUXdy?=
 =?utf-8?B?QXluMFUvWmhUam5UU2VDRHJpYkpWUXVNcUdzak9oM2EyR25vQ1loQWxjd29z?=
 =?utf-8?B?WVJaa0MyNzRrMmZMSnVSZXBpVFVLSVhGbGpDbHgyeDBtc2xjQkFlazNYa1Va?=
 =?utf-8?B?eUxsbC9TTDNlME5uR2gvS3dCWll4RnRlL3dlbXJGZnB6b3RKdXJLRWRxUmp5?=
 =?utf-8?B?TzlLMmpZMktkcTFWNnc3MkdPZmlTRSs2WlJXbjFSUXZpSlZZS1lFMWZPZjZ1?=
 =?utf-8?B?b2RkTEN6OWlLN0xzWExIQ2R0Z3Nqd1EyK2RtNUVVdUgrTERqM3lWay9haXIw?=
 =?utf-8?B?TDdBQXl5cEdTdVE4VTdFSzd0OTY4Sy9vcFUwaTI1dU94MnZjK0MzZlJMcTBR?=
 =?utf-8?B?ZnU1VzlIYUFIcUhxTGFCNUR3VVluYlpUZTY5azJvUVNIa0VtN0xSUXBIR2pM?=
 =?utf-8?B?dXAwT3FZelgxdlI1WHp2QlFXV3RRb3Bhd1BwMktOSUNTSGxEUmY5c3JqY0Vu?=
 =?utf-8?B?c2VVamphb0lDQmlVSE9KSTFHRGVqZzBvSW1VelV3ZjZ1cWtDdkdIMGptV2Ux?=
 =?utf-8?B?UWIxMXFyRFc4ZkhuOXduQzBhdVFlcVNXWW9reEorUnd1SktGbU5NL1R2Wnhx?=
 =?utf-8?B?aXcyUld0ZGYxY1RZZ1hWdGtxRzRTdnl3ZDlwV0QzMEhwL3hLZXlUWlpYTitO?=
 =?utf-8?B?Q3kzRnJzMHJHOHJsYS9HMXlMMkY0NktJcVZ1NHkxZTJhSjQwK1ZYR3dlOGUz?=
 =?utf-8?B?OEtDODByZVo1OGxWQ3ZmaW5vTVZqRGRnNnR0bUordFpTVjNJMUVLRTV3YjNr?=
 =?utf-8?B?L1RlZlo2bFFycStrdDVBSHZ2NVQ3KzFxcm5NamxqN09aM05hSjlvakc5K3Vk?=
 =?utf-8?B?YVQrQm9NS3NqcEx5Qm0rMkt0akR4bjFpOEFVbFFyZG1ib0t2RnplcDFDbTZn?=
 =?utf-8?B?THRJSmVWQWRVaEJldVlGcnFFK1E2bUduR3hTV2RYeUxKcEVmSDZ0TWRDb29M?=
 =?utf-8?B?eVZhS0VLT05vUHV4cWRIbmJPNUFGWTRENUg4aGhnWVlRcVRMYW9IMUtVYTRo?=
 =?utf-8?B?d081enBxN2hlTkhENkk3ODVRc01pcmliSS9yeFdDOCtLbGRySjI5UFFQSHFk?=
 =?utf-8?B?elk4a0FEWWt5MXF6WGdramg4RGZlNXd6K2w4QlI3TFllQ00vSnAvVnJNT3lW?=
 =?utf-8?B?d1h0UDdZSUE4SVgrem4rL2Q0a2NrNXZVU2o0aTFhL0xkWXdoRGNVOXB6azA3?=
 =?utf-8?B?Q29KMEpXZ3Bmcm5vVUxCTmFKSFRGZGVOKzZBM2tQK2Nra3JOOG1TR2N4SlBE?=
 =?utf-8?B?WnRrY2FXUjd6WGVVd2JRYmRuM1pDWTFOaUJCK0F4RmY5a3llcnQ2V1lIdXJq?=
 =?utf-8?Q?tVzU19yIF/afIS/t/yrWcIiQgycEN2Cf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVl1YSt4cVNrYU4yaGxiR1dGWkoxaUwyMTRlcTIzME5lcHlob21yWGhsTVAw?=
 =?utf-8?B?bzJlYVAzQkJkZjZSUFh5UWY2MEh2S0FCV1lXdStIZG5qdFRIZlFxMzIwajFJ?=
 =?utf-8?B?WTVVMk80RFBEODVaelJGU3oxSWZMQnhJa2NJUkpVdlJSWXdVeTZmZGhaMHdv?=
 =?utf-8?B?T20wQ2dDNWc1cnQ1QzBvcjVhK0FiOXdCTWZjdzluR1VZc3ZqcCtPVGdtMmd2?=
 =?utf-8?B?bm9pWk1hQ3VLUGZmdzRDckV6RjFmY0tZUjVON2ZWUjZoTk1kaVRlVytZekFm?=
 =?utf-8?B?Wi8rZjVkRng0NWpDTUw0M2l5akkvWjc5Q2FiR3BiSTF2Ujg1dnNqTmdhdEFC?=
 =?utf-8?B?eFREbzlLbUJTeDBGV0VOREE1TzdKT01PT0RKdjV6K2xGZWlEVU82U1A1TVN5?=
 =?utf-8?B?TmhKeWE3WHZ1S3pSZTRVOGJMOXFHczJYSlhtc3FMMmI5cnhJSG5rQ0wxMTNy?=
 =?utf-8?B?L0QyZzBkUFRHUEtzZURNU0xDL0NxMW1vTC9Ya2RGMUgwMERQQytJSUN0UUFC?=
 =?utf-8?B?RUJwN2MzT1VabVhxSlBxWUpIRnhOZURack02TVhKMXM0UHQ0UkxISkNHbUR1?=
 =?utf-8?B?bnliZUw2RlFSOE4yY09YT0JHdGJNWHZGbmliY0NodXJhRlFqRE1ZYkdQakFR?=
 =?utf-8?B?QlN4OUxZWG82QjFla1lyVlkwcmhpcDh1M3ZzdTNHZFJiUU9rY2dNYkVQK1Js?=
 =?utf-8?B?VUE5SjNnMXF3aS9oZElRT0c2eFhrSWtTTVNJcnliUG00RTZKMStjMk12VVNG?=
 =?utf-8?B?bzVyU3lPM2tNcW9sNDRhNVpDZkhkbk92cmNWLzk5R0xBU3BMK0M1bXdJVENs?=
 =?utf-8?B?dVkzMlhjQWNaOHduZ1JmOTl1M3dyVHU3M3UrbGxMM0MraTlFdjRMWTh3MEcv?=
 =?utf-8?B?SWdpc0JUUitndTA4d2tkRVNtNUUxZGtTdjBxYkxUYmtOWng2M3YxWUh6UmYr?=
 =?utf-8?B?ZndkelJoZHpEUGZFeGNpb01hV1ZUODNCQXhiZ1pWemVSeVhNeVNxVTYybmR4?=
 =?utf-8?B?OW13aTlnbnZUb051QituVVdmc2JMZHNjT0h1NVRDcGFlL3BzYkJBdzg2TUhL?=
 =?utf-8?B?dWo3aUJBU21hSHdiRDZudk82WXJiSXVpZnM5VUcyTEJ5ZXJ1aDFHVmVTYzZN?=
 =?utf-8?B?TVVIb3VPK0NSd0tXS3d2a1pUZVFVU0pIWFliV0t5WWpoY3RNaHRhWHBEaFBC?=
 =?utf-8?B?QXNiRnd5dXM3RFBzd1Z1OHY5MFd5WXFaV1hILy9GNG0zdm9mRlAxbVlrcjVF?=
 =?utf-8?B?akREMU5FQjRIVmJoMGxwUnkzanJ2aUd4UDhlZ1lleXNqMUF1SEpOc05WZ0Qx?=
 =?utf-8?B?b0xhdG4wUW1RMG5yNW1Gd3VyZ0d6OC9DQm1Vci9GeURFb0VZajVTaGtBOUF4?=
 =?utf-8?B?R2paSjhhN2ZSWDc0eXRyQ1dZZnQ2VDNnd2xSRlUrYlVtZUF0bEFlcThwYWYw?=
 =?utf-8?B?azd4YVNHTkpIZ3lIVGV2Yy9kTWxLdTFDSjBIcUlTTU9hT2ZRVzc2YnhsTldt?=
 =?utf-8?B?d1FPZ3gyK2JncU4vV3dWSEJSRHFlSnFzTERMSGVTYTNnZzMyMnFlRDVvdjlv?=
 =?utf-8?B?dmxFeS9rUTBGbmVDMzI3Vnpwa0cwQWVXdG9uVEUzU1dlZkdZNDNQYzJxWTJB?=
 =?utf-8?B?cGlXZVpPUDRSY1hKOWFySzAzUzdwS3IxSERaL3VMcXlJeDdDcVBpZ2tTV0lL?=
 =?utf-8?B?S2FvbDJiQXJSTisvbTRaTTREV0VvNDNOa2R1SjgyQm5hcnNHT1FYSEFEUzRu?=
 =?utf-8?B?SlArenlLVXdlZFNEM1ZVOFFadFNnWkt3TkI2SHpzZXgvZE1GdW01ZDloS0o1?=
 =?utf-8?B?ekpScWVFZDlPaUF3cWQyaUxuL2cxb1NhSXl3MEl3RzU4Y0RmZ0w4dktpRHpY?=
 =?utf-8?B?UUtPZjRNS2tMVFpwL3hWYUtmVTZOY2pFM1Z5TmQ3ZHFYcDFITk1oUElmV0ZX?=
 =?utf-8?B?Ykg4QUI4Lytkb0lkaytrUkpuOTc0L0pzOGEzaEhmRzhISUxuS2xNa1laR3J1?=
 =?utf-8?B?UnZha2VkeHZoQkM3SHNZRGZjM2ZRSDVEQjBucldwTGcxL2hBeHorZUs2WU5o?=
 =?utf-8?B?VmhybVUwUlRrSVh0ek5vdWd4bWsvajMzN2lhL2x6V3hRblg5NHlYcFB1WFoz?=
 =?utf-8?Q?5dnVEFRYTP3+bRY5PclVBIk9O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8114b271-88b5-40b2-c4a4-08dd5ccbb2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 16:26:50.4550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIoj1SC7ZJ+CF8uSc+HOXGbV7F53dWkW55FrhB5HUsk05TX/GsQYZp3GHIm9VVity0rnGJKQWZixMzQRs3P20w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gSGVtbWluZ2Vy
IDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIDIwIEZlYnJ1
YXJ5IDIwMjUgMjA6MzMNCj4gVG86IFNoYW5pIFBlcmV0eiA8c2hwZXJldHpAbnZpZGlhLmNvbT4N
Cj4gQ2M6IGRldkBkcGRrLm9yZzsgVHlsZXIgUmV0emxhZmYgPHJvcmV0emxhQGxpbnV4Lm1pY3Jv
c29mdC5jb20+OyBQYXJhdiBQYW5kaXQNCj4gPHBhcmF2QG52aWRpYS5jb20+OyBYdWVtaW5nIExp
IDx4dWVtaW5nbEBudmlkaWEuY29tPjsgTmlwdW4gR3VwdGENCj4gPG5pcHVuLmd1cHRhQGFtZC5j
b20+OyBOaWtoaWwgQWdhcndhbCA8bmlraGlsLmFnYXJ3YWxAYW1kLmNvbT47IEhlbWFudA0KPiBB
Z3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPjsgU2FjaGluIFNheGVuYQ0KPiA8c2FjaGlu
LnNheGVuYUBueHAuY29tPjsgUm9zZW4gWHUgPHJvc2VuLnh1QGludGVsLmNvbT47IENoZW5ibyBY
aWENCj4gPGNoZW5ib3hAbnZpZGlhLmNvbT47IFRvbWFzeiBEdXN6eW5za2kgPHRkdXN6eW5za2lA
bWFydmVsbC5jb20+Ow0KPiBDaGVuZ3dlbiBGZW5nIDxmZW5nY2hlbmd3ZW5AaHVhd2VpLmNvbT47
IE5CVS1Db250YWN0LWxvbmdsaQ0KPiAoRVhURVJOQUwpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT47
IFdlaSBIdSA8d2VoQG1pY3Jvc29mdC5jb20+OyBCcnVjZQ0KPiBSaWNoYXJkc29uIDxicnVjZS5y
aWNoYXJkc29uQGludGVsLmNvbT47IEtldmluIExhYXR6DQo+IDxrZXZpbi5sYWF0ekBpbnRlbC5j
b20+OyBKYW4gQmx1bmNrIDxqYmx1bmNrQGluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjcgMi80XSBsaWI6IGZpeCBjb21wYXJpc29uIGJldHdlZW4gZGV2aWNlcw0KPiANCj4g
RXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMN
Cj4gDQo+IA0KPiBPbiBXZWQsIDEyIEZlYiAyMDI1IDE4OjM4OjMzICswMjAwDQo+IFNoYW5pIFBl
cmV0eiA8c2hwZXJldHpAbnZpZGlhLmNvbT4gd3JvdGU6DQo+IA0KPiA+IERQREsgc3VwcG9ydHMg
bXVsdGlwbGUgZm9ybWF0cyBmb3Igc3BlY2lmeWluZyBidXNlcywgKHN1Y2ggYXMNCj4gPiAiMDAw
MDowODowMC4wIiBhbmQgIjA4OjAwLjAiIGZvciBQQ0kpLg0KPiA+IFRoaXMgZmxleGliaWxpdHkg
Y2FuIGxlYWQgdG8gaW5jb25zaXN0ZW5jaWVzIHdoZW4gdXNpbmcgb25lIGZvcm1hdA0KPiA+IHdo
aWxlIHJ1bm5pbmcgdGVzdHBtZCwgdGhlbiBhdHRlbXB0cyB0byB1c2UgdGhlIG90aGVyIGZvcm1h
dCBpbiBhDQo+ID4gbGF0ZXIgY29tbWFuZCwgcmVzdWx0aW5nIGluIGEgZmFpbHVyZS4NCj4gPg0K
PiA+IFRoZSBpc3N1ZSBhcmlzZXMgZnJvbSB0aGUgZmluZF9kZXZpY2UgZnVuY3Rpb24sIHdoaWNo
IGNvbXBhcmVzIHRoZQ0KPiA+IHVzZXItcHJvdmlkZWQgc3RyaW5nIGRpcmVjdGx5IHdpdGggdGhl
IGRldmljZS0+bmFtZSBpbiB0aGUgcnRlX2RldmljZQ0KPiA+IHN0cnVjdHVyZS4NCj4gPiBJZiB3
ZSB3YW50IHRvIGFjY3VyYXRlbHkgY29tcGFyZSB0aGVzZSBuYW1lcywgd2UnbGwgbmVlZCB0byBi
cmluZyBib3RoDQo+ID4gc2lkZXMgdG8gdGhlIHNhbWUgcmVwcmVzZW50YXRpb24gYnkgaW52b2tp
bmcgdGhlIHBhcnNlIGZ1bmN0aW9uIG9uIHRoZQ0KPiA+IHVzZXIgaW5wdXQuDQo+IA0KPiBDb3Vs
ZCB5b3UgZ2l2ZSBhbiBleGFtcGxlIHdoZXJlIHRoaXMgaGFwcGVucyBwbGVhc2U/DQo+IFNob3Vs
ZG4ndCBmaW5kX2RldmljZSBzdHJpbmcgYWx3YXlzIGJlIGNoYW5nZWQgaW50byBjYW5vbmljYWwg
Zm9ybSBpbg0KPiBmaW5kX2RldmljZSBoYW5kbGVyPw0KDQpUaGUgZmxvdyBJIHdhcyBkZWFsaW5n
IHdpdGggd2FzIGF0dGFjaF9wb3J0IC0+IHJ0ZV9kZXZfcHJvYmUgLSA+IGxvY2FsX2Rldl9wcm9i
ZSAtPiBmaW5kX2RldmljZS4gDQpUaGUgc3RyaW5nIHBhc3NlZCB0byBhdHRhY2hfcG9ydCB3YXMg
dGhlIHNob3J0IHZlcnNpb24sIGRpcmVjdGx5IGZyb20gdGhlIHVzZXIuDQoNClNvLCB0byBjbGFy
aWZ5IC0geW91J3JlIHNheWluZyB0aGF0IGZpbmRfZGV2aWNlIHNpbXBseSBuZWVkIHRvIGFjY2Vw
dCB0aGUgc3RyaW5nIGluIGl0cyBjYW5vbmljYWwgZm9ybT8gV2hpY2ggbWVhbnMgd2UnbGwgb25s
eSBuZWVkIHRvIGZpeCBsb2NhbF9kZXZfcHJvYmUgdG8gYnJpbmcgaXQgdG8gdGhlIGNhbm9uaWNh
bCBmb3JtIGJlZm9yZSBjYWxsaW5nIGZpbmRfZGV2aWNlPw0KSSB0cmllZCBpdCBidXQgdGhlbiBJ
IG5vdGljZWQgdGhhdCB0aGVyZSdzIG5vIGZ1bmN0aW9uIHRoYXQgZ2V0cyB0aGUgdXNlci1wcm92
aWRlZCBzdHJpbmcgYW5kIHJldHVybnMgaXQncyBzdHJpbmcgY2Fub25pY2FsIGZvcm0uIFRoZSBj
bG9zZXN0IHRvIHRoaXMgaXMgcGFyc2UsIGJ1dCB3aGF0IGl0IGV2ZW50dWFsbHkgcmV0dXJucyBp
cyBub3QgbmVjZXNzYXJpbHkgYSBzdHJpbmcgLSBpdCBjYW4gYmUgYW55dGhpbmcgLSBmb3IgaW5z
dGFuY2UgcGNpX3BhcnNlIHdpbGwgZ2l2ZSB5b3UgYmFjayBhIHN0cnVjdCBydGVfcGNpX2FkZHIu
DQoNCj4gDQo+ID4gVGhlIHByb3Bvc2VkIHNvbHV0aW9uIGlzIHRvIHV0aWxpemUgdGhlIHBhcnNl
IGZ1bmN0aW9uIGltcGxlbWVudGVkIGJ5DQo+ID4gZWFjaCBidXMuIFdoZW4gY29tcGFyaW5nIG5h
bWVzLCB3ZSB3aWxsIGNhbGwgcGFyc2Ugb24gdGhlIHN1cHBsaWVkDQo+ID4gc3RyaW5nIGFzIHdl
bGwgYXMgb24gdGhlIGRldmljZSBuYW1lIGl0c2VsZiBhbmQgY29tcGFyZSB0aGUgcmVzdWx0cy4N
Cj4gPiBBcyBwYXJ0IG9mIHRoZSBjaGFuZ2UgdGhlIHBhcnNlIGZ1bmN0aW9uIHdpbGwgbm93IHJl
Y2l2ZSB0aGUgYWRkcmVzcw0KPiA+IHRvIHdyaXRlIHRvIGFuZCB0aGUgc2l6ZSBvZiB0aGUgcG9p
bnRlciwgaW4gYWRkaXRpb24gaXQgd2lsbCByZXR1cm4NCj4gPiB0aGUgc2l6ZSBvZiB0aGUgcGFy
c2VkIGFkZHJlc3MuDQo+IA0KPiBUaGlzIGxlYWRzIHRvIG1vcmUgY29tcGxleGl0eSB0aGFuIG5l
ZWRlZCwgdGhlIGxheWVyaW5nIGhlcmUgaXMgYSBiaXQgb2YgYSBtZXNzDQo+IGFscmVhZHkuIFdh
eSB0b28gY29tcGxleCBhcyBpdCBpcy4NCj4gVGhlcmUgaXMgY29tcGxleCBuZXN0aW5nIGJldHdl
ZW4gZ2VuZXJpYyBidXMgY29kZSwgcGNpIGJ1cyBjb2RlLCBrdmFyZ3MNCj4gcHJvY2Vzc2luZyBh
bmQgZHJpdmVycy4NCj4gDQo+IFdoeSBkb2VzIHRoZSBQQ0kgY29kZSBuZWVkIHRvIGJlIGNhbGxp
bmcgZ2VuZXJpYyBjb2RlIGZvciBwYXJzZS4NCj4gDQo+IA0KPiA+IFRoaXMgd2lsbCBhbGxvdyBj
b25zaXN0ZW50IGNvbXBhcmlzb25zIGJldHdlZW4gZGlmZmVyZW50DQo+ID4gcmVwcmVzZW50YXRp
b25zIG9mIHNhbWUgZGV2aWNlcy4NCj4gDQo+IE5vdCBhIGZhbiBvZiBob3cgd2lkZSB0aGlzIGNo
YW5nZSBlbmRzIHVwIGJlaW5nLiBXb3VsZCBsaWtlIHRvIGtlZXAgaXQganVzdCB0bw0KPiBQQ0ku
DQoNCg0KSSBhZ3JlZSBpdCBiZWNhbWUgdG9vIHdpZGUuDQoNCkFzIEkgc2VlIGl0IHdlIGhhdmUg
MyBvcHRpb25zOg0KCTEuIEFkZCBhIGZ1bmN0aW9uIHRoYXQgcmV0dXJucyB0aGUgY2Fub25pY2Fs
IGZvcm0gc3RyaW5nIG9mIGEgZGV2aWNlIGFuZCBjYWxsIGl0IGJlZm9yZSBmaW5kX2RldmljZSBp
cyBjYWxsZWQgKGluIGxvY2FsX2Rldl9wcm9iZSBmb3IgZXhhbXBsZSkNCgkyLiBBZGQgYSBjb21w
YXJpc29uIGZ1bmN0aW9uLCBwY2kgYnVzIHdpbGwgY2FsbCB0aGlzIHNwZWNpZmljIGNvbXBhcmlz
b24gKHNvbWV0aGluZyBsaWtlIHdoYXQgSSBkaWQgaW4gaGVyZSBodHRwczovL3BhdGNoZXMuZHBk
ay5vcmcvcHJvamVjdC9kcGRrL3BhdGNoLzIwMjQwNzA4MTY1MTQ1LjE0MDUxMDctMS1zaHBlcmV0
ekBudmlkaWEuY29tLykgDQoJMy4gVGhlIGN1cnJlbnQgcHJvcG9zYWwNCg0KV2hhdCBkbyB5b3Ug
dGhpbms/DQoNClRoYW5rcyBmb3IgeW91ciBoZWxwLCBhbmQgc29ycnkgZm9yIHRoZSBsYXRlIHJl
c3BvbnNlDQoNCg==
