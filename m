Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF130CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:38:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73DBC40264;
	Fri,  7 Nov 2025 11:38:22 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4DB584021F;
 Fri,  7 Nov 2025 11:38:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvyCwG5FXBB8gUq++zauOo4j54jTmMOYOnmKqjyy0v8T5dBy6cLTLGwF6iqOYvmk1JAZKmhNJk+ZPiRz7NxjWlZ5TgXdOfMEtMt9RWWza6nn9LXhq4f7lfnld8LXpRcni3fNDufQSJHZnLhq8RVs+w4U1pJQ/OUrmNZe19q83bu8hx9k3gdrLfWOjW712HRUy/RsiCe2ue3ZsHsYlNX5Y0/EVZaGeeNKE2q8naoj2RwnmYloXStV8mYkpU0gsS3ALbMrvqbmDP6qDGKADvhX/NjDdpZ/rP7hfhLYFnoQE1VcRoDrKoPF25mLb4NBuxqFYmhoK8+I/WdJz4VqG3eTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO9o9BuSF05LuSgtEOuOJ9oXeiPwXIvRxIupRmcDHr0=;
 b=QWbwkW32Hd8aTSOUJHArkT1DORAcxQkap7ByJ7SzKjeWtMtOeYsAd6VebTNrlH4+wbcr8QDi1We3GeLvSQqipYH9X8sZ6pLmfRySOGoktNEz0ldE2MWov7F8KeeOU/Rcrn9sjTPG+Quvb47iUjBU7NQAS8ibYzPP1GpunDzMk8HnBNY2TFxO1SplQ4SJHIN0xb9zAaJfF/UNuHCNwX+TI2QSXpnX7fYSCviSYRStM/Sb4lU8R/6KHEtaSphVKG43O/rn8HE40CzWxHyB17qiDiFoHtUWvDsX+K3rumnkRWEvQ4m7MwPPlrVcmIIehpv2ZCF7awObKYixs2tyWUqFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO9o9BuSF05LuSgtEOuOJ9oXeiPwXIvRxIupRmcDHr0=;
 b=k7UuqTrVwve/VYiKeutxGC/P+0+SZtTPqNMU+DHByMNPAHgNYiGvUwwxnKDUbVzNrh2VxNIeMxzjKJgXgDVrid1HtNvDAKS6uYbGQj0sHBdJoXS6NUhYaOz0h5l4fFVB6fjrvq4rqHBSc/I3N/STGUIzzGrYZ5GqV5QAHZYiOuit6yXm7ktzHG+nPGxqmTaOuxGbR1LdZbE4NzvCvth3jb199e6uFTWwpcRnGXe0fYTluAb57NhhRvGFMUzSWzp9nIlfKbmcFN7zRl3NQTkXLFIeCdWV9CnbNdKXJC7FEg+1jvCsWkEPbuADuqObmpDSy0Xf0BjsgAt0EvpELwWYDA==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM9PR04MB8668.eurprd04.prod.outlook.com (2603:10a6:20b:43f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:38:19 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 10:38:19 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Maxime Leroy <maxime@leroys.fr>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jun Yang <jun.yang@nxp.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 2/3] net/dpaa2: clear active VDQ state when freeing Rx
 queues
Thread-Topic: [PATCH 2/3] net/dpaa2: clear active VDQ state when freeing Rx
 queues
Thread-Index: AQHcTzvLM2vj4rdCVUOfv2Fq6K7TTbTmCMmAgADw74CAAAz+8A==
Date: Fri, 7 Nov 2025 10:38:18 +0000
Message-ID: <PAXPR04MB932863FE46BB04B56A4BCFC489C3A@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
 <20251106163807.201451-2-hemant.agrawal@nxp.com>
 <20251106112911.0c50107b@phoenix>
 <CAHHRULVJe45=gNq1in6eHo5yEq-+QguxeDGfVHeC8D3KgMDdqQ@mail.gmail.com>
In-Reply-To: <CAHHRULVJe45=gNq1in6eHo5yEq-+QguxeDGfVHeC8D3KgMDdqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|AM9PR04MB8668:EE_
x-ms-office365-filtering-correlation-id: cb0f326f-b87d-481d-4282-08de1de9c447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?djBvZWc2b1BtZG92RkhRU2N5TDhYTG9id0xLb3NoUXVUdlhIcHh2WGVsZ0NV?=
 =?utf-8?B?MHlXbGpFOEt2ZXNreDZORHNXVi9pYXQxVit0cFllTU84dWhIekRvNVp1UXhS?=
 =?utf-8?B?a1RnMzhmbnFrSm41Rzlzb1ZCQ2h5NTVPeXJBODFmeUhqVmUzWWhFbURKTUtJ?=
 =?utf-8?B?Y01mWm1FRDVoU3FzeTNHVG9tWEQ3MFEvZzQyay9ueUVzd2RTb1haQ2xYeXJa?=
 =?utf-8?B?aVNmN0l3a3NMbHBMOVZITkQ1VUwrMFpMTVoxMU1Kc3k0bCtLQUI1MnNPNnRY?=
 =?utf-8?B?RThKSCtDdktVY3lkTHZzdlVkRHV5WDBkOTROSkNPYy9MaFcrNVNFSVA5Skli?=
 =?utf-8?B?eENrYXhVeXlUMjBJWkxCRk1EYlMzUVZsM05SUWJ4bDZxU3RRd0pxRHJjdXhp?=
 =?utf-8?B?K1p6dkp2Q1FxUmVqQnlXazdnNzBmVnVKTDlvZng4UU9zZVFYU1BtcGd1Nnl2?=
 =?utf-8?B?K0NvYmJ2QTRqMXFJSG9zSitWVEtzZG5HSmppZnd2N3EwTjdIS0FGbElFVDkr?=
 =?utf-8?B?anc5VXFyek1jUVdWREdBS2x3Q1JrWnorS0JOYzVHMFhUTFNEYm0yWTRMQWFL?=
 =?utf-8?B?dElGUFczSGJwYkF0YTZSRmRISFNsRnQxbFpXKzMvWWF2MCs2a2lzcEdVZkFr?=
 =?utf-8?B?YUljUTFkOENMeWNJa1BOd0RVYWM1WWlvZnM1akRQVzA0NTkyRzhMaEZsQjhk?=
 =?utf-8?B?ZFBjNlF0QmFBVzY2QXdVeHAxMEYxTkFpa1pReXJYVHhINWJuWWZMTHJIZG50?=
 =?utf-8?B?c29xZkNQYWpaeVZ4TG5tdlBQTnlQUjhwSHR5L3ZnZzN3RmdyREMzTjlkM0oy?=
 =?utf-8?B?MFZXcVRhVlcyOGZyL1NpK1l2ZUllZjdNT1FGRkYzNlZ6eUZ0eEFaenZJTVFB?=
 =?utf-8?B?aC9JUUFJczMxQWxMNUlZdWREMVVYRTlwamNaTEViU2NiTHBPMUY0VXFUbCsr?=
 =?utf-8?B?ZEhFU25sV29SZTdrYmgxZ2F2WkNmajFBanZuSmZxNjNoUEVvdTFGcm0rd1d0?=
 =?utf-8?B?MVVTd3JGSmpHZVBGT2pHRGV6NlZ1YUsvQ0xoeHFoRkhrUDd6WU5WUnhzRkFv?=
 =?utf-8?B?NXlGalh3SEFxS3dSak1DdUJyZEdwbWVTY3MzckZKVGZFdGpSMWtxTk9GNm9v?=
 =?utf-8?B?eVluOWdCL2tpanZveW03QWFTNUlpOEVGMiswMU9rVUplOEVhQ0RjWk9yYm5r?=
 =?utf-8?B?eWVtWFJ6bXhaNWFkM1NzU2NLNElSVW0vZ1c2ZHJ3YWMyelZnNHBsZit2SXFl?=
 =?utf-8?B?cWJ3MUhjSXIxVnk4N1BVallhMlpkRVBta0FaZnVGVlpwTjRZRDE3UHU1dDhL?=
 =?utf-8?B?ZWZxMzBFckV6dWY1VVhpRzhqdzNDMTIxU01WL1BNWFZZQ21sdnhBWGd2ZnB4?=
 =?utf-8?B?bUpCTkY0ZmdNdUFVUUYzeGZQMUlXMGxnZEIvZStVWG9KTUZrYXRlNkcyUnla?=
 =?utf-8?B?b1liNGxKdm1pcHJBNEVJdDZhYThmd0J2THYrUkFZM2QwVUlXa2xVTXRUa1o5?=
 =?utf-8?B?azAyQStIcW0xUHBLckx1c0VQRm5xSjAwWmx6ZWxtSzV1a0c4endveUJ6VVFq?=
 =?utf-8?B?RDF3dU9qNWtRZUZKTXAzOUNhc21SNGNMVGZYbEdSU000Tk9yeWgyVHBXTkxx?=
 =?utf-8?B?eWJRcUthWUQyWE11aFduNWoyajRQZitzQ042YnBpVzV6bmVrRTVlTXg5cU1S?=
 =?utf-8?B?TmsybjJtZG5MbExsQi9WV3Rmd1NSazg4MlczYTUxODgvRWh6MzFRT1JmeDIr?=
 =?utf-8?B?amJ5M0ZLSU40S25WUkxjQ2V1YitSQlVzN2ZvaSs0Y2tnSWExZ2szaTJhdjdK?=
 =?utf-8?B?VmVrSTdUN2RIelVvbE9VNzdaM1B1aFkzSmNvY2Y0WjlKd1o0SDM3WmZnR0Vz?=
 =?utf-8?B?TzFnNlJjVG9rTk5zd3VTbjF0aHNLM3dWalNoVFlBZ2ltSEl2ZEt0WVFlMjRp?=
 =?utf-8?B?ZnQxVnlROVFLUXU5b3FEVHZTbER5SXBwNXEyWXk2QWJPN3M0MEF1alFqREJG?=
 =?utf-8?B?U21zdUxjM3RSK2dCQjVpSVVHTXVuMm5PWi9QaVRtN2JoUmsrVjlsdVUvb2NF?=
 =?utf-8?Q?a7ehfW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2w1MDNtYnhRZ1hOVjlzNEorWG9BdU9LUkgvdnorNWY5eS93MjljUnVWKzZi?=
 =?utf-8?B?cEZiMkZzM1VwSGFNZkFTVlVuL0JvbEljZUNGYW5vOXlxdG9RMnVacU9QR0F6?=
 =?utf-8?B?RlozWC9BNEgrWWtJcTNIYWlzeXVlc0pkbnllbWNFQVdiTjI5SGo3a0JiOXMy?=
 =?utf-8?B?TW9Ta1FONzdGZll6LzN3VFAxNW1iT0tEdE9xQ0NwcnBNY2RyTmdQMGpBUm9V?=
 =?utf-8?B?S2p3M2piZzdIMGV2K21pVXd3cC9RNkRFb2poWmVLTkpjUUVESXRVYW0wYVJi?=
 =?utf-8?B?ekJReStWTVprSGZnYXp1NGVIdllPWEVHRXdqSmxFdEZwODFrRXlHUFZNWTMw?=
 =?utf-8?B?dGM3YUpOQXhzOE5NRlJyL3YrMWNidG82SHY4SDVPczd1ZG5maU5mb2tFUlFa?=
 =?utf-8?B?d3cxV0tFTDZJYi9QeldsTEVDWUI3czJPRHN4SHZoWU5POU52L0RZakFkUG9h?=
 =?utf-8?B?RGFXR2R6NWg3ZXIvc0NuNGZFNmo1a3NONzFvZjNRK1I2RkFyNDdGU1paN0E5?=
 =?utf-8?B?T1BXbVZkbFUvajZmWTdpY1hGaDVaYjRVR1E2TGJqNmFMSFZRRHpkbXZzak1I?=
 =?utf-8?B?L3NJU3BPQkRzZkttK0RyRlZyMjhFUGtkT051bENzQzYvQmZtTEtQQ1YvUzJG?=
 =?utf-8?B?d05ISkZaVGV2RjhCWkkvbDVOSU9yNmcwOCs1VUU1Wm9ybVRSRGQzRzBwMHB3?=
 =?utf-8?B?M0ZuaTl5VXZqc1Zyd2tEU0RwYXVCQnVFZmNjdHJLWHpVREp4YzhXZGJoWnhO?=
 =?utf-8?B?akppdTI4MklEcHVyR2pQdUpPaVF3M2Q4U0tVQlVzWERIdTRET0NlYVRMdEJS?=
 =?utf-8?B?eUpwOFR4OFVSV2YwOGNBSVdoa3dYQ3ZTOFV4WERnUTVZZDIyTFU5UkhiTzZZ?=
 =?utf-8?B?ejJkRXhYV1lJYkxMaG5xODJGQWNDdmVDeldNd28rZU9GM0R5ekgrdCtWbjE3?=
 =?utf-8?B?NDFqTVFQUm5DbHNoc3BEMk1aTjBWT2I1Zk84N0VDWGhUZ1hDMDFCdng3RzJR?=
 =?utf-8?B?M1IxZkNVMWFVSkRUWisrYnRDTVFwaGNwNjNYYlFXRnJWVFR3T0M4NzB2a0FR?=
 =?utf-8?B?ZExYdG1wZVh1VFU3VjBFY1l0WXpqN1RDQm5pMmdNMkZwcjFCRzlGT01malMx?=
 =?utf-8?B?N0cwOW5Qb3h5NXNYS01TQ1J4aHpTNHdrVE5oQTlrT2d2OTdnY2dPMFJJUXA1?=
 =?utf-8?B?aUJZMmJPU1NMa2FFVjY1d1FqelpFQkEveGdSZ3pUdGNVVFVQa09hd0ErSUtr?=
 =?utf-8?B?cU1NSWgxN1lMMHVjK2NKWW8wa3JKelBHRTdMbDkvb3RFSE9EZEVOVFlxd2RV?=
 =?utf-8?B?d1ArZ2l5WFRRYjJoMFFIa1Q3SHFva1lJNGtlNERJVVg1NlBpelNiMjVxSFFG?=
 =?utf-8?B?VnB1aW9ROVVHVzQvbGNvMDdIR3RHQlJkWGFxcUlQSWh3TTV1VW5DblJiMEda?=
 =?utf-8?B?YkdYRnYreUI5QlZ5ZktoVHpIVkFvalVnSUwxeXRCWFBtOVQ3UFVucVBQU0tq?=
 =?utf-8?B?OE9KbnMzYk5DNm5sY3hnbjAzSmFxbEozK3VPTWQvSDRMcHhjK3ZlL2ppcUlF?=
 =?utf-8?B?dFFFUUVTQ0paeGZ6a2d1NTViMjRSQ3hCb0dRYnpkc3N6VUMwZVBZN2J0VzRI?=
 =?utf-8?B?OE1wQllmSEk3aWd0a1hqRmtmOUdkcXE5VFBaeEZxUFAwZHQ4UzUxYUlaWWtC?=
 =?utf-8?B?QzRuYk54MEk1cnF3UW83WGRlSU0xUWNVaG1IRkV4VHNpR0dHVjF6YXBpdGdi?=
 =?utf-8?B?K0ZIUSt0NjNDM3l2Z0pEWnB3VURra3NJb3JBaEdPa3JsWkFaK09HTUN4V0dI?=
 =?utf-8?B?am0wV3dGNVZzU3pqTUpOQm9EYWtaSlNCTEtNK0pGRmRLUXRwS04rdlJVUVVZ?=
 =?utf-8?B?eEt0bVFrMGppYldsY2ZzdzBpdnl0MkltcGFGb2dpckZscWdVcC83S0J1L3Na?=
 =?utf-8?B?a0ViRXE3djAreVdIWVY4RjcvYWxtcVRlOWM2Y0haVko5bXlkUURjMFUwc1R5?=
 =?utf-8?B?alFsMEh4ajlQdW9pUWJScFdIUGxUWmJ3emJVODl4ZlZmbjVEMUlaR3V4bWpU?=
 =?utf-8?B?K3hGU3dLL2crd1lROHVYbmVUclp1ZkFScE5EcjNMWEg0aVBIWEs0N01nYTNh?=
 =?utf-8?Q?Jzyc4MezMLs1We9gN0DnCB7zR?=
Content-Type: multipart/alternative;
 boundary="_000_PAXPR04MB932863FE46BB04B56A4BCFC489C3APAXPR04MB9328eurp_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0f326f-b87d-481d-4282-08de1de9c447
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 10:38:19.0650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghYib/Z+C0uffmkfx0apItiOlNtlDynOgBGudiwZ5OJYS+anzw/cr+/6W1KCXCgTOFS872WkPEvLrdm1iFqexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8668
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

--_000_PAXPR04MB932863FE46BB04B56A4BCFC489C3APAXPR04MB9328eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpMZSBqZXUuIDYgbm92LiAyMDI1LCAyMDoyOSwgU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5A
bmV0d29ya3BsdW1iZXIub3JnPG1haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZz4+IGEg
w6ljcml0IDoNCk9uIFRodSwgIDYgTm92IDIwMjUgMjI6MDg6MDYgKzA1MzANCkhlbWFudCBBZ3Jh
d2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPG1haWx0bzpoZW1hbnQuYWdyYXdhbEBueHAuY29t
Pj4gd3JvdGU6DQoNCj4gK3N0YXRpYyB2b2lkDQo+ICtkcGFhMl9jbGVhcl9xdWV1ZV9hY3RpdmVf
ZHBzKHN0cnVjdCBkcGFhMl9xdWV1ZSAqcSwgaW50IG51bV9sY29yZXMpDQo+ICt7DQo+ICsgICAg
IGludCBpOw0KPiArDQo+ICsgICAgIGZvciAoaSA9IDA7IGkgPCBudW1fbGNvcmVzOyBpKyspIHsN
Cj4gKyAgICAgICAgICAgICBzdHJ1Y3QgcXVldWVfc3RvcmFnZV9pbmZvX3QgKnFzID0gcS0+cV9z
dG9yYWdlW2ldOw0KPiArDQo+ICsgICAgICAgICAgICAgaWYgKCFxcykNCj4gKyAgICAgICAgICAg
ICAgICAgICAgIGNvbnRpbnVlOw0KPiArDQo+ICsgICAgICAgICAgICAgaWYgKHFzLT5hY3RpdmVf
ZHFzKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICBjbGVhcl9zd3BfYWN0aXZlX2Rxcyhxcy0+
YWN0aXZlX2RwaW9faWQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgcXMtPmFjdGl2ZV9kcXMg
PSBOVUxMOw0KPiArICAgICAgICAgICAgIH0NCj4gKyAgICAgfQ0KPiArfQ0KPiArDQoNCldoeSBu
b3QgdXNlIFJURV9MQ09SRV9GT1JFQUNIKCkgaGVyZT8NCg0KRm9yIHRoZSBsb29wLCBJIGRpZCBp
dCB0aGUgc2FtZSB3YXkgYXMgaW4gZHBhYTJfcXVldWVfc3RvcmFnZV9hbGxvYygpLCB0byBzdGF5
IGFsaWduZWQgd2l0aCB0aGUgcmVzdCBvZiB0aGUgZHJpdmVyIGluc3RlYWQgb2YgdXNpbmcgUlRF
X0xDT1JFX0ZPUkVBQ0goKS4NCg0KVGhhbmtzIEhlbWFudCBmb3IgdXBzdHJlYW1pbmcgbXkgcGF0
Y2guIEhvd2V2ZXIsIHlvdSBhZGRlZCBteSBlbWFpbCBpbiAubWFpbG1hcCBhcyBhIG5ldyBlbnRy
eSDigJQgaXQgc2hvdWxkIGluc3RlYWQgYmUgYWRkZWQgYXMgYSBzZWNvbmQgZW1haWwgdW5kZXIg
dGhlIGV4aXN0aW5nIE1heGltZSBMZXJveSBlbnRyeS4NCltIZW1hbnRdDQpXaWxsIHNlbmQgdjIN
Cg==

--_000_PAXPR04MB932863FE46BB04B56A4BCFC489C3APAXPR04MB9328eurp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6ZHQ9InV1aWQ6QzJGNDEwMTAtNjVC
My0xMWQxLUEyOUYtMDBBQTAwQzE0ODgyIiB4bWxuczptPSJodHRwOi8vc2NoZW1hcy5taWNyb3Nv
ZnQuY29tL29mZmljZS8yMDA0LzEyL29tbWwiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy9UUi9S
RUMtaHRtbDQwIj4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250
ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPG1ldGEgbmFtZT0iR2VuZXJhdG9yIiBj
b250ZW50PSJNaWNyb3NvZnQgV29yZCAxNSAoZmlsdGVyZWQgbWVkaXVtKSI+DQo8c3R5bGU+PCEt
LQ0KLyogRm9udCBEZWZpbml0aW9ucyAqLw0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpNYW5n
YWw7DQoJcGFub3NlLTE6MCAwIDQgMCAwIDAgMCAwIDAgMDt9DQpAZm9udC1mYWNlDQoJe2ZvbnQt
ZmFtaWx5OiJDYW1icmlhIE1hdGgiOw0KCXBhbm9zZS0xOjIgNCA1IDMgNSA0IDYgMyAyIDQ7fQ0K
QGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpEZW5nWGlhbjsNCglwYW5vc2UtMToyIDEgNiAwIDMg
MSAxIDEgMSAxO30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6QXB0b3M7fQ0KQGZvbnQtZmFj
ZQ0KCXtmb250LWZhbWlseToiXEBEZW5nWGlhbiI7DQoJcGFub3NlLTE6MiAxIDYgMCAzIDEgMSAx
IDEgMTt9DQovKiBTdHlsZSBEZWZpbml0aW9ucyAqLw0KcC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1h
bCwgZGl2Lk1zb05vcm1hbA0KCXttYXJnaW46MGNtOw0KCWZvbnQtc2l6ZToxMi4wcHQ7DQoJZm9u
dC1mYW1pbHk6IkFwdG9zIixzYW5zLXNlcmlmO30NCmE6bGluaywgc3Bhbi5Nc29IeXBlcmxpbmsN
Cgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCWNvbG9yOmJsdWU7DQoJdGV4dC1kZWNvcmF0aW9u
OnVuZGVybGluZTt9DQpzcGFuLkVtYWlsU3R5bGUxOA0KCXttc28tc3R5bGUtdHlwZTpwZXJzb25h
bC1yZXBseTsNCglmb250LWZhbWlseToiQXB0b3MiLHNhbnMtc2VyaWY7DQoJY29sb3I6d2luZG93
dGV4dDt9DQouTXNvQ2hwRGVmYXVsdA0KCXttc28tc3R5bGUtdHlwZTpleHBvcnQtb25seTsNCglm
b250LXNpemU6MTEuMHB0O30NCkBwYWdlIFdvcmRTZWN0aW9uMQ0KCXtzaXplOjYxMi4wcHQgNzky
LjBwdDsNCgltYXJnaW46NzIuMHB0IDcyLjBwdCA3Mi4wcHQgNzIuMHB0O30NCmRpdi5Xb3JkU2Vj
dGlvbjENCgl7cGFnZTpXb3JkU2VjdGlvbjE7fQ0KLS0+PC9zdHlsZT48IS0tW2lmIGd0ZSBtc28g
OV0+PHhtbD4NCjxvOnNoYXBlZGVmYXVsdHMgdjpleHQ9ImVkaXQiIHNwaWRtYXg9IjEwMjYiIC8+
DQo8L3htbD48IVtlbmRpZl0tLT48IS0tW2lmIGd0ZSBtc28gOV0+PHhtbD4NCjxvOnNoYXBlbGF5
b3V0IHY6ZXh0PSJlZGl0Ij4NCjxvOmlkbWFwIHY6ZXh0PSJlZGl0IiBkYXRhPSIxIiAvPg0KPC9v
OnNoYXBlbGF5b3V0PjwveG1sPjwhW2VuZGlmXS0tPg0KPC9oZWFkPg0KPGJvZHkgbGFuZz0iRU4t
SU4iIGxpbms9ImJsdWUiIHZsaW5rPSJwdXJwbGUiIHN0eWxlPSJ3b3JkLXdyYXA6YnJlYWstd29y
ZCI+DQo8ZGl2IGNsYXNzPSJXb3JkU2VjdGlvbjEiPg0KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7
Ym9yZGVyLWxlZnQ6c29saWQgYmx1ZSAxLjVwdDtwYWRkaW5nOjBjbSAwY20gMGNtIDQuMHB0Ij4N
CjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbi1ib3R0b206
MTIuMHB0Ij48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+TGUgamV1LiA2IG5vdi4gMjAyNSwgMjA6MjksIFN0ZXBoZW4gSGVtbWluZ2VyICZs
dDs8YSBocmVmPSJtYWlsdG86c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmciPnN0ZXBoZW5AbmV0
d29ya3BsdW1iZXIub3JnPC9hPiZndDsgYSDDqWNyaXQmbmJzcDs6PG86cD48L286cD48L3A+DQo8
L2Rpdj4NCjxibG9ja3F1b3RlIHN0eWxlPSJib3JkZXI6bm9uZTtib3JkZXItbGVmdDpzb2xpZCAj
Q0NDQ0NDIDEuMHB0O3BhZGRpbmc6MGNtIDBjbSAwY20gNi4wcHQ7bWFyZ2luLWxlZnQ6NC44cHQ7
bWFyZ2luLXJpZ2h0OjBjbSI+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5PbiBUaHUsJm5ic3A7IDYg
Tm92IDIwMjUgMjI6MDg6MDYgKzA1MzA8YnI+DQpIZW1hbnQgQWdyYXdhbCAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmhlbWFudC5hZ3Jhd2FsQG54cC5jb20iIHRhcmdldD0iX2JsYW5rIj5oZW1hbnQuYWdy
YXdhbEBueHAuY29tPC9hPiZndDsgd3JvdGU6PGJyPg0KPGJyPg0KJmd0OyArc3RhdGljIHZvaWQ8
YnI+DQomZ3Q7ICtkcGFhMl9jbGVhcl9xdWV1ZV9hY3RpdmVfZHBzKHN0cnVjdCBkcGFhMl9xdWV1
ZSAqcSwgaW50IG51bV9sY29yZXMpPGJyPg0KJmd0OyArezxicj4NCiZndDsgKyZuYnNwOyAmbmJz
cDsgJm5ic3A7aW50IGk7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArJm5ic3A7ICZuYnNwOyAmbmJz
cDtmb3IgKGkgPSAwOyBpICZsdDsgbnVtX2xjb3JlczsgaSsrKSB7PGJyPg0KJmd0OyArJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7c3RydWN0IHF1ZXVlX3N0
b3JhZ2VfaW5mb190ICpxcyA9IHEtJmd0O3Ffc3RvcmFnZVtpXTs8YnI+DQomZ3Q7ICs8YnI+DQom
Z3Q7ICsmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtpZiAo
IXFzKTxicj4NCiZndDsgKyZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtjb250aW51ZTs8YnI+DQomZ3Q7ICs8
YnI+DQomZ3Q7ICsmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDtpZiAocXMtJmd0O2FjdGl2ZV9kcXMpIHs8YnI+DQomZ3Q7ICsmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
Y2xlYXJfc3dwX2FjdGl2ZV9kcXMocXMtJmd0O2FjdGl2ZV9kcGlvX2lkKTs8YnI+DQomZ3Q7ICsm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7cXMtJmd0O2FjdGl2ZV9kcXMgPSBOVUxMOzxicj4NCiZndDsgKyZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO308YnI+DQomZ3Q7
ICsmbmJzcDsgJm5ic3A7ICZuYnNwO308YnI+DQomZ3Q7ICt9PGJyPg0KJmd0OyArPGJyPg0KPGJy
Pg0KV2h5IG5vdCB1c2UgUlRFX0xDT1JFX0ZPUkVBQ0goKSBoZXJlPzxvOnA+PC9vOnA+PC9wPg0K
PC9ibG9ja3F1b3RlPg0KPC9kaXY+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPkZvciB0aGUgbG9vcCwgSSBkaWQgaXQgdGhlIHNhbWUgd2F5IGFzIGluIGRwYWEyX3F1ZXVl
X3N0b3JhZ2VfYWxsb2MoKSwgdG8gc3RheSBhbGlnbmVkIHdpdGggdGhlIHJlc3Qgb2YgdGhlIGRy
aXZlciBpbnN0ZWFkIG9mIHVzaW5nIFJURV9MQ09SRV9GT1JFQUNIKCkuPG86cD48L286cD48L3A+
DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwv
cD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRoYW5rcyBIZW1hbnQgZm9y
IHVwc3RyZWFtaW5nIG15IHBhdGNoLiBIb3dldmVyLCB5b3UgYWRkZWQgbXkgZW1haWwgaW4gLm1h
aWxtYXAgYXMgYSBuZXcgZW50cnkg4oCUIGl0IHNob3VsZCBpbnN0ZWFkIGJlIGFkZGVkIGFzIGEg
c2Vjb25kIGVtYWlsIHVuZGVyIHRoZSBleGlzdGluZyBNYXhpbWUgTGVyb3kgZW50cnkuPG86cD48
L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48Yj48aT48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjExLjBwdCI+W0hlbWFudF0gPG86cD48L286cD48L3NwYW4+PC9pPjwvYj48L3A+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48Yj48aT48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdCI+V2ls
bCBzZW5kIHYyPC9zcGFuPjwvaT48L2I+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQiPjxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9i
b2R5Pg0KPC9odG1sPg0K

--_000_PAXPR04MB932863FE46BB04B56A4BCFC489C3APAXPR04MB9328eurp_--
