Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48EFC36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 18:31:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F08C94026B;
	Tue,  8 Apr 2025 20:31:46 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by mails.dpdk.org (Postfix) with ESMTP id 45E3F40267;
 Tue,  8 Apr 2025 20:31:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4LX7HT5yjHIukKYOk2CdpQNElaMY5zEERnlYyDOaUYXLOI2q0HcrQfRQ1UyjbuWxkb79p742h8IUnmQux3Yh9iZx7VWyU68EppMU32NbEpXMgNVLFDrdZBpPnEpRYbJLfp6lBOf4qe3TP3fA6O1QIdZYgY+OO+6VibhprwQVPJ6rb0ReV/gpDlSJ88HPl2bdy7EatgXP6x6kNAVb6vUi9R3brjadiJisehmz0J9SPw1yP4vQrDangDEQlrubqiSRqDIa4a2lrsKiGFvllPLx25GFCS1MTSJYOvjUAkVIfVBETIwaDH0KVwiE4vbhRmmFKjqw63oTGfJV2MRbPVq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP1MAyf7oL/49nS+AgwXQfbA/HK8oSVHI0z2Vt7+S8Y=;
 b=eY5aBsmsVIcjPR17PGXp06S95F8UxwAUwLuoaAVqR6fqAhB1q8g70LkZGUa9dq3XlxtpYvdJGWYG5LAd0mZaQep1nvsBB3hIginviZAr5AGe98xZSzw9cDZmSzXrOIVMsWsa8bS0bz5lcnAbZU99PV2BlcOFSZ+tKMS7noysRXMij3t3S/nvOXGR0Dj4TkjtGttGI80AubP2tJYbDY9zDjp5jIXAd9qRu9nVyvnkne7izIwGznMRoMVUJf5FVVpJFTWNXhSNUBxxGmV2n7WjHWIzBr0luJPqZGij6Pp25ndjAxxrH19OBUK20PXwNnmWJInx5mmncbF2eW/07rh6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP1MAyf7oL/49nS+AgwXQfbA/HK8oSVHI0z2Vt7+S8Y=;
 b=XwQQ5043KVz8rVd9XYXIwjvEisnpbu1N3aLK9XqFG2V/zEtclXjPNx16mYTf6R/XOr8m3XbcLwRmOEqSb6feu6oJ2zN1+KN79t4WmtsKu1OLZNrEdlohLA+rebuPtIYKs1Cckk9yNbNmRpyZhE9HcTjRMZ4AJUTCPkLQj3SLg6CPhn9iY7KEXde6MidR85Ha+1vQ1haaGfG32g6bXVLS3pAmnQnNsDgs9V7aGBEmpmlYBKwFrV1pID1JKlgYcTF9sPejBUR7wW6ospEdKKjM4LmE0UoajOBVsSnpUQkp66elfblddaCmPsxzU5wCoCIG1PbY31kgTsK2HIhhpdKWrw==
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Tue, 8 Apr
 2025 18:31:41 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 18:31:40 +0000
From: Ali Alnubani <alialnu@nvidia.com>
To: "luca.boccassi@gmail.com" <luca.boccassi@gmail.com>, "stable@dpdk.org"
 <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, David Christensen <drc@linux.vnet.ibm.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Kevin Traynor <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>, Pei
 Zhang <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Yanghang Liu
 <yanghliu@redhat.com>
Subject: RE: 22.11.8 patches review and test
Thread-Topic: 22.11.8 patches review and test
Thread-Index: AQHbnkVzFiJ5QVyHJ0OBmrTla3Q4ibOaLGsA
Date: Tue, 8 Apr 2025 18:31:40 +0000
Message-ID: <PH7PR12MB91732CDFC77ADDF91DA22727DAB52@PH7PR12MB9173.namprd12.prod.outlook.com>
References: <20250326115132.1444530-1-luca.boccassi@gmail.com>
In-Reply-To: <20250326115132.1444530-1-luca.boccassi@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB9173:EE_|MN0PR12MB6175:EE_
x-ms-office365-filtering-correlation-id: 6be52862-a130-420f-7252-08dd76cb9b19
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Z2lNWUNaMUNyRW4wODRuUXBQZmZ5L3krV2VIQ29paFMvdVQ4S0J6ZzFjUDlC?=
 =?utf-8?B?VlhjU3dIOGwrUDZLdnBCdFBkbE51bzdFaVpMTTVqQTZsbGFIVTVuYzBsQnVr?=
 =?utf-8?B?ZkRxU1JFQVJlWVBjeVM1TGlnRTdWNGRRbVNFRVd6aXRKd0MvcEtxRkR6dHJL?=
 =?utf-8?B?bHFETkcwdk5DcVpYR0tMK0N3VFMzL1B4LzczcUlwWm9aTkVrbTNhL0JtdXli?=
 =?utf-8?B?dWdKeWFQa2pDY2ZOK3NySUovalJaNzM5emo3K0R5Q1AwejI3WWhWaUpDUktw?=
 =?utf-8?B?NUF5cDJhMjl3WHp0enJIS2VUOGErcTdwVnVWSi9BWlZmTGJYNWRxTEJqSGZl?=
 =?utf-8?B?SStYb0txMGZ6cGd4TXBiS0NJdGV6bngxMS9KOExTOU1ZcmZtcWpYMmNOaEVy?=
 =?utf-8?B?bXlrWXgxcDBrVEVpUmNyMEpYM3FibG9xL2F4YzBubDc5WjduRy9ZYm9meFhq?=
 =?utf-8?B?N3RteUYvWGJpOVkrRzdtL0dlL3VLT2cvbXVGdm1hUjdtSHJJZ3FuaWVNbVVP?=
 =?utf-8?B?VklNOG1MSTFjbFhXaUEwSFY3cmE1UFZodTlBUkdxVWVFQXM0UC92U1JyWkdW?=
 =?utf-8?B?VW82b2FZSFNoeFFhQTBxU2p4MU9yK3haa1h1ZEJnSkxhT1BhbGpUbjEzM1ZL?=
 =?utf-8?B?RDNEbzZGdzFrQUQ2WnVvTUZDUi9vZ1FCK09zZkdhY2ordFRzSTlkendhVlQz?=
 =?utf-8?B?Qnp3OE9xZHY3VzlPTEhGYXlJSExsRkN0YnQ3NVpkc1VEUFVHdytmSGhuM2pL?=
 =?utf-8?B?MmFkWjVjNkExdm5kS2pHOS9paE5SN3V5Y3pBS0pBZGl0NGNMRkkyNTVkR25m?=
 =?utf-8?B?RW0xSVFSd1UyM2VZSURlajBoTUlORjdJbHhTemFpdVcwS3ZXOE1XOGhsYjg0?=
 =?utf-8?B?MVRaZEJQVUUveFVEbll2eVlqbXNlOUQxbU95TXd6WWFaZldhc29RS2U3TlNB?=
 =?utf-8?B?cWVNbkRQWkJYYVlka2lqazd3c3YzQVBlVWJOWG1OckRDM09Hbk1RT2ExWGcv?=
 =?utf-8?B?Tk03bzZRN1pFaHdtYWszZElwVmlMVnJROW5lM1ZMa25GYXRQL0pmQW41VENr?=
 =?utf-8?B?bjQvYnJuL09OVFk2L3ZiVS9zZ1E4YkFnR2hzTFlQMjlNdE1KeWF0M013OE5J?=
 =?utf-8?B?bkJWY2VCV2dlWWdSR0xSMC9ZVU1WOFRUWTlUVTFGeTdRbnU0Skd6T3oyVHZM?=
 =?utf-8?B?RGdkbHQwdzNEU2MxZkRMUkdBemEzZXE4R1ZLU2NweUJ0TU5zK08wRHpLa3B3?=
 =?utf-8?B?c1kyMkxpcVNUVHpJaDhOWUIzcUZTaGxaYUVoZ0VoUkg2OWZpS3hKc2JuKzNn?=
 =?utf-8?B?eGNkNzltbHZBQ3MvTHQvMGliOU01SXpYUldvOEZoVFZJM0ROc0VBbDRCUkMv?=
 =?utf-8?B?c3RLVVg0Tmh1MklNK2FIK1hROTFoaUp6UHA4WjFUTjlCTGxuWUt0UjMxS2Fr?=
 =?utf-8?B?K0RPdStZbXlabTJFZTNWTlp0UDdUR0RTbHVrWk80c0JDb1dTZlFqVjRnK216?=
 =?utf-8?B?bzJiTkxNL0xEa3pOSUpaeFhmS3kzbXZOTUg5M2ZUaUZxWmN1V2k2TEpiVUxo?=
 =?utf-8?B?VWhMY1dNeE1Sd2pEVWlaYmhBQVY3WjlXQnBwVU0rM1I3VTgwU0NRNFRFdFhK?=
 =?utf-8?B?SHlhdmNWODlOWHFKc3cydmFLOG5YV2hXWE83UUxSS3VJQ3Q1TWZ4UVYrblRl?=
 =?utf-8?B?SVlhc2dQdFZNRUhnQlFqUjZkV1ZsdThWdjN0SmJXMFJPd0M2MEF3RW9NdGIy?=
 =?utf-8?B?MFZqNzhMd3NocUhnYmpoV2lLUFB3QTVPMlQxR0tIS00zQjZLcDdQRTA0TVFD?=
 =?utf-8?B?QysxZUsxSU1qVWNHeUs5NExjbTZuLythRWZxRm5tb2pTdjV1dVV5dDh4eEhF?=
 =?utf-8?B?T01Yc2R0eE5VU2NnUW1LbEhMNm5OdStYMUM0WkZnZXhuK0dKQjRCNkY1N3M5?=
 =?utf-8?Q?dLjGu8F75Y2GqF/iso3pt8avVHjFZUek?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDFhajFEc3YzVjc4bXFyRjFnc0ZhczAvY0YrbnJ2KzQ1MUpSVG5WOXkySlU4?=
 =?utf-8?B?VVYyU3ZDb3dpeXNuV2pLeEhhZ3NNWC9TL3l3eCtpM0tGL1RacU1Qbm5YSCsz?=
 =?utf-8?B?K2RTY0orM3hWTDg4cURGNk5CazV6Y3cxT3VTMzcwczlzWjJpVytwVWJmT3JL?=
 =?utf-8?B?NGp5aDIrZ1Vrb2ZOSXdZNDJZN1NUVVBtTStjd3ZVazJJR3V3eU5aWnBhQWZG?=
 =?utf-8?B?aXhqQk1JZEZYUVpjckhqUXFPOEErZkdySk4reEU0SzVsYjFhQVViZWtUWUJj?=
 =?utf-8?B?ZTJnOFo3d0M2OWwrOUZmT0VjS3Q3L3V0S3l4aDBjbDBFbUJ6b2JsaXMzcVAy?=
 =?utf-8?B?dksvQlZKQVV6NE9EZmtZWFNhclc2M0IvS0ZzUzRqc0VoeXhMc3ROYnpTTzA5?=
 =?utf-8?B?VnFKa2V3eWhVQjlQYVlpOHZQN2pwVmlzOHY5WWd4b2QvQzJPQU9hUTVqZWE5?=
 =?utf-8?B?VWw0SE5NWldyS1ozd3NYQUJwZldlaVYrV1F3clBuU3U4aVRHeE1HMEJ5eXZz?=
 =?utf-8?B?b2h0cjVibkhPeHhCYTVnL1B3Z08wRmtKa2RxaGIrNU56bjIvc3Jyc2p1c1FG?=
 =?utf-8?B?dGswZGpoeEVrRUxJM2lkb3pTMUc3a1FlZ1Z1akpDNmZucVVUUXhoUDFwYWhr?=
 =?utf-8?B?Q29Nc04vRHNWcjVDaUg3VTJkSVpuNm93OFpGZmxXYXJkM3lxUmUwbm5vbVpU?=
 =?utf-8?B?MExUQm5hOTlDS1RvbzZ0WlQ5QjVVNnVOeHFtSCtCajR0NlJaaW51YUR3NnQv?=
 =?utf-8?B?b2FQRTdBa3BIdDBQRTBkY2VMSnM1Mm90OVEvWm5aOGN5d0Q0WWRlSmdSMWpj?=
 =?utf-8?B?RFZGbWJpeU01eUwwaEpjRndITTZjL0Y4UnJEZkNFdEhocHFzT2lzT3ZKcWtp?=
 =?utf-8?B?eEp2VHlDUFdvWGVCanM3STVYTDUxVTRCWmRUcjJuaERuTmJsaXFvZmswd0w5?=
 =?utf-8?B?VXViQ1ZDWDNObUJaS0JVOC9HWmxydTRYVHBZc3pVckUvZDJqWUdMZVFvNFlP?=
 =?utf-8?B?NTZ3NzJsa3p2N1Q5OWpQWk56eVQ5YUprcU9KaGJQOGE1ZUc2K1JPdTVydjFp?=
 =?utf-8?B?bWVtOUVwc3kweHQ3eW04OThPc1ZnWEtHMTRMSWNSVUdOU3JsNTVzbGsxQWtX?=
 =?utf-8?B?My9xV240dFpBaEt0RG1RblJMK3hOa3BFRk9BREZ4VGtxMDBEOU9DTlNoeFVB?=
 =?utf-8?B?TFE1cTNwQ0J1RFdST2hlTURsTDU1VGFhdjI2K2l2WmxoQk52Nzc0OEVIenM2?=
 =?utf-8?B?aEJ4L2EvS0RZYlJoYlZkeGNMaWYzd2RDZi9BL0ltN2I5OFIvTWM1Z1QyLzRF?=
 =?utf-8?B?WkVsODBJczhENzBoWmJxajViWlRqOE0rcklhcUp3YnpGNTNuU1g1Ykd6OHlV?=
 =?utf-8?B?b0t2NDNpbGhuVG1uRUhHY1g1WkJsY2ZqY2F3MXNsZDR6b1N0cStpT05VR2lJ?=
 =?utf-8?B?ZSt0ZmZYTFQrS3NhMVI5VUwxYUQraW9tMGRFVzQvY1JVazdJZmVtQjlON2hr?=
 =?utf-8?B?Zi9BekZrV0owT0xCUkxNL0tVSVQzTWNzQllMRFI4dFVxNGRjOFZ1ODA0Rit2?=
 =?utf-8?B?NW1DRU9Yb21zUHZTeE1URDJJYnpLVEEzc204UDliajkraVliQmYxM2N2clZw?=
 =?utf-8?B?QjJKUUorYWNueEUxa0djUFFCR1AvMzdBMDJaU3gvazUya1d6VkdjR3lKM0RN?=
 =?utf-8?B?ZnJPQ2lFSkhSYmkrY3ZFSWFlZVdTK3ZPY1VpWWI1WU5oQWYwVFpMMDBmQ2s4?=
 =?utf-8?B?NXd1YjZkYjBya3ZJU1h6eUJxN1NMdmE3ZTRsRjROVEh2Y0g4aDhHK2NMWWx0?=
 =?utf-8?B?Tk1pVEpiZHNVaE9pNHdxM3VCUTZNQ3gwSGRFdXVaVGZObkJYUldCRld1MUtX?=
 =?utf-8?B?OEFRalkxZlFJdnRXZEYxMjZmeGU4aS9HZ1g0RDBQWk5mdU8zZjhBQjQwdldx?=
 =?utf-8?B?ZjdTSlJLWlRCcGZiZ1U3cFhOUE55Z0pwZWxic0tkSE90cVJRZTdRQTFUblZM?=
 =?utf-8?B?L21pQ3p6V3N3MjJUM3VZOG5aM2pXdjNFRW05ZUVyUjVRaStWSzEvUWtRSmxq?=
 =?utf-8?B?NklRRmE0VDlGRkFDRmNEc2JPMVlYbC9KcHByTWdMWlNnVFpzbGxzR0NVaWZG?=
 =?utf-8?Q?G7wM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be52862-a130-420f-7252-08dd76cb9b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 18:31:40.8765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBKI7Fy9o3ihb+3l0YwoCNEDsxOUYM97gZHyYs6j86DWds7znxtF1jWzbRQpUd2VRZMGa6s7sGtZT/+BvNFmUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsdWNhLmJvY2Nhc3NpQGdtYWls
LmNvbSA8bHVjYS5ib2NjYXNzaUBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2gg
MjYsIDIwMjUgMTo1MSBQTQ0KPiBUbzogc3RhYmxlQGRwZGsub3JnDQo+IENjOiBkZXZAZHBkay5v
cmc7IEFsaSBBbG51YmFuaSA8YWxpYWxudUBudmlkaWEuY29tPjsgRGF2aWQgQ2hyaXN0ZW5zZW4N
Cj4gPGRyY0BsaW51eC52bmV0LmlibS5jb20+OyBIZW1hbnQgQWdyYXdhbCA8aGVtYW50LmFncmF3
YWxAbnhwLmNvbT47IElhbg0KPiBTdG9rZXMgPGlhbi5zdG9rZXNAaW50ZWwuY29tPjsgSmVyaW4g
SmFjb2IgPGplcmluakBtYXJ2ZWxsLmNvbT47IEpvaG4NCj4gTWNOYW1hcmEgPGpvaG4ubWNuYW1h
cmFAaW50ZWwuY29tPjsgS2V2aW4gVHJheW5vcg0KPiA8a3RyYXlub3JAcmVkaGF0LmNvbT47IEx1
Y2EgQm9jY2Fzc2kgPGJsdWNhQGRlYmlhbi5vcmc+OyBQZWkgWmhhbmcNCj4gPHBlemhhbmdAcmVk
aGF0LmNvbT47IFJhc2xhbiBEYXJhd3NoZWggPHJhc2xhbmRAbnZpZGlhLmNvbT47IE5CVS0NCj4g
Q29udGFjdC1UaG9tYXMgTW9uamFsb24gKEVYVEVSTkFMKSA8dGhvbWFzQG1vbmphbG9uLm5ldD47
IFlhbmdoYW5nIExpdQ0KPiA8eWFuZ2hsaXVAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogMjIuMTEu
OCBwYXRjaGVzIHJldmlldyBhbmQgdGVzdA0KPiANCj4gSGkgYWxsLA0KPiANCj4gSGVyZSBpcyBh
IGxpc3Qgb2YgcGF0Y2hlcyB0YXJnZXRlZCBmb3Igc3RhYmxlIHJlbGVhc2UgMjIuMTEuOC4NCj4g
DQo+IFRoZSBwbGFubmVkIGRhdGUgZm9yIHRoZSBmaW5hbCByZWxlYXNlIGlzIDIwMjUvMDQvMTAu
DQo+IA0KPiBQbGVhc2UgaGVscCB3aXRoIHRlc3RpbmcgYW5kIHZhbGlkYXRpb24gb2YgeW91ciB1
c2UgY2FzZXMgYW5kIHJlcG9ydA0KPiBhbnkgaXNzdWVzL3Jlc3VsdHMgd2l0aCByZXBseS1hbGwg
dG8gdGhpcyBtYWlsLiBGb3IgdGhlIGZpbmFsIHJlbGVhc2UNCj4gdGhlIGZpeGVzIGFuZCByZXBv
cnRlZCB2YWxpZGF0aW9ucyB3aWxsIGJlIGFkZGVkIHRvIHRoZSByZWxlYXNlIG5vdGVzLg0KPiAN
Cj4gQSByZWxlYXNlIGNhbmRpZGF0ZSB0YXJiYWxsIGNhbiBiZSBmb3VuZCBhdDoNCj4gDQo+ICAg
ICBodHRwczovL2RwZGsub3JnL2Jyb3dzZS9kcGRrLXN0YWJsZS90YWcvP2lkPXYyMi4xMS44LXJj
MQ0KPiANCj4gVGhlc2UgcGF0Y2hlcyBhcmUgbG9jYXRlZCBhdCBicmFuY2ggMjIuMTEgb2YgZHBk
ay1zdGFibGUgcmVwbzoNCj4gICAgIGh0dHBzOi8vZHBkay5vcmcvYnJvd3NlL2RwZGstc3RhYmxl
Lw0KPiANCj4gVGhhbmtzLg0KPiANCj4gTHVjYSBCb2NjYXNzaQ0KPiANCj4gLS0tDQoNCkhlbGxv
LA0KDQpXZSByYW4gdGhlIGZvbGxvd2luZyBmdW5jdGlvbmFsIHRlc3RzIHdpdGggTnZpZGlhIGhh
cmR3YXJlIG9uIHYyMi4xMS44LXJjMToNCi0gQmFzaWMgZnVuY3Rpb25hbGl0eToNCiAgU2VuZCBh
bmQgcmVjZWl2ZSBtdWx0aXBsZSB0eXBlcyBvZiB0cmFmZmljLg0KLSB0ZXN0cG1kIHhzdGF0cyBj
b3VudGVyIHRlc3QuDQotIHRlc3RwbWQgdGltZXN0YW1wIHRlc3QuDQotIENoYW5naW5nL2NoZWNr
aW5nIGxpbmsgc3RhdHVzIHRocm91Z2ggdGVzdHBtZC4NCi0gcnRlX2Zsb3cgdGVzdHMgKGh0dHBz
Oi8vZG9jLmRwZGsub3JnL2d1aWRlcy9uaWNzL21seDUuaHRtbCNzdXBwb3J0ZWQtaGFyZHdhcmUt
b2ZmbG9hZHMpDQotIFJTUyB0ZXN0cy4NCi0gVkxBTiBmaWx0ZXJpbmcsIHN0cmlwcGluZywgYW5k
IGluc2VydGlvbiB0ZXN0cy4NCi0gQ2hlY2tzdW0gYW5kIFRTTyB0ZXN0cy4NCi0gcHR5cGUgdGVz
dHMuDQotIGxpbmtfc3RhdHVzX2ludGVycnVwdCBleGFtcGxlIGFwcGxpY2F0aW9uIHRlc3RzLg0K
LSBsM2Z3ZC1wb3dlciBleGFtcGxlIGFwcGxpY2F0aW9uIHRlc3RzLg0KLSBNdWx0aS1wcm9jZXNz
IGV4YW1wbGUgYXBwbGljYXRpb25zIHRlc3RzLg0KLSBIYXJkd2FyZSBMUk8gdGVzdHMuDQotIEJ1
ZmZlciBTcGxpdCB0ZXN0cy4NCi0gVHggc2NoZWR1bGluZyB0ZXN0cy4NCg0KRnVuY3Rpb25hbCB0
ZXN0cyByYW4gb246DQotIE5JQzogQ29ubmVjdFgtNiBEeCAvIE9TOiBVYnVudHUgMjIuMDQgLyBE
cml2ZXI6IE1MTlhfT0ZFRF9MSU5VWC0yNC4xMC0yLjEuOC4wIC8gRmlybXdhcmU6IDIyLjQzLjI1
NjYNCi0gRFBVOiBCbHVlRmllbGQtMiAvIERPQ0EgU1cgdmVyc2lvbjogMi4xMC4wIC8gRmlybXdh
cmU6IDI0LjQ0LjEwMzYNCg0KQWRkaXRpb25hbGx5LCB3ZSByYW4gYnVpbGQgdGVzdHMgd2l0aCBt
dWx0aXBsZSBjb25maWd1cmF0aW9ucyBvbiB0aGUgZm9sbG93aW5nIE9TL2RyaXZlciBjb21iaW5h
dGlvbnMgKGFsbCBwYXNzZWQpOg0KLSBVYnVudHUgMjIuMDQgd2l0aCBNTE5YX09GRURfTElOVVgt
MjQuMTAtMi4xLjguMC4NCi0gVWJ1bnR1IDI0LjA0IHdpdGggTUxOWF9PRkVEX0xJTlVYLTI0LjEw
LTIuMS44LjAuDQotIFVidW50dSAyMi4wNCB3aXRoIHJkbWEtY29yZSBtYXN0ZXIgKDllOWE5NTcp
Lg0KLSBVYnVudHUgMjQuMDQgd2l0aCByZG1hLWNvcmUgdjUwLjAuDQotIEZlZG9yYSA0MSB3aXRo
IHJkbWEtY29yZSB2NTEuMC4NCi0gRmVkb3JhIDQzIChSYXdoaWRlKSB3aXRoIHJkbWEtY29yZSB2
NTYuMC4NCi0gT3BlblNVU0UgTGVhcCAxNS42IHdpdGggcmRtYS1jb3JlIHY0OS4xLg0KDQpXZSBk
b24ndCBzZWUgbmV3IGlzc3VlcyBjYXVzZWQgYnkgdGhlIGNoYW5nZXMgaW4gdGhpcyByZWxlYXNl
Lg0KDQpUaGFua3MsDQpBbGkNCg==
