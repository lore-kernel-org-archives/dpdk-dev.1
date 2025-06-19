Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA6BC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 05:44:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C10BD427E4;
	Thu, 19 Jun 2025 07:44:31 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
 by mails.dpdk.org (Postfix) with ESMTP id 186424279F
 for <dev@dpdk.org>; Thu, 19 Jun 2025 07:44:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agK+tD4pCTiZnwltyYnTYgoNnJ7QrnESk7HilznKfvg+7b6Dk7x3DgUKVgMnWZqRqoKU1tsyvupj8BjXP7/s/vXUzeABT/JwQXY1P9sNlmWU9aiacHuRnAdH/52oF286XVFwcF6s5AY/M5qW2ZhsCs3Edfowq4+Q37khTt5Vy4Q0lImAWxILhujRg5ulLJgl3AOpNa/xo0bxjmRqNU8qj8YmiUytTsAqUaG6TiE+zy4tfAcba/fD38QU0ZYLNsTymY4/6EAh1y6vtzmj3GcAyL23PtkV+FpYqDb7AWDy3sbELS/u1wxdKgQFD9+ufWgVF9Vsc6PPbr1qzKbWlUK9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vvw4coYyJ2q3cRijNTePmrj3m84kOOnYX+A29YhP28M=;
 b=KBXWN0uikK3Qvp6GluHlC359L7s/umcTEn/kzhqaTNZPCViOPOtgg/cNW0EIi0xshgNt4gXmA7ZonjlqvE1cupbWM8xqjXxpHxRn+0HsrPKW0tG8zG9Ju8Zg9ekXplt1RRWDSyY3WrNnYXTeQNKfzV1KDQvY8d8rXOC+GwUnEvC4jnWBT18j9IdYV1Lg+eOYMXGE8FuFmqv9xAFGe1Jj/0oVAa3dDAAblkINI+sOFPDVKCH13bm9fiq+imVBd9Xsmpq2JLz6kPbMTvjNJzFrRRTG+MCN84+F3aK9ZF78TUaueiqDQV9stRpImH3yaM+dFsWE8r0YCvgBJpwyMFDw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vvw4coYyJ2q3cRijNTePmrj3m84kOOnYX+A29YhP28M=;
 b=VijLUHwsdwAvG+awc+NxjMw6AJNyvEH83FTuDbcYyT6DKO1C1r8IicgrDVuqFeqyt38/WeRJgHMRCVxk9fCxfkWKXCrP0677Hn2OJbw7xVVBeFbFQzcF1HxGg+SRIJxTtDSLi46t18ZNk2UGLRJkLRUPqiP68i5TaSP02MCAKQI0jJuK545yfHztu6JHqzeZrDsqR2hSiVsa4APbATm2v6KHNW6WUtIj0bVYeXij5BkWA0qipVeOmb0Y8q3Dj57FawIbBgKsBtDDI6k/sRkSntRlQIbW2qiwskjOJa1tZsTxVa8+3xO7+Nl6PZNa36kiS9VkKcGuYHujc8kXPR1ORQ==
Received: from AS8PR04MB8979.eurprd04.prod.outlook.com (2603:10a6:20b:42e::7)
 by DU4PR04MB11340.eurprd04.prod.outlook.com (2603:10a6:10:5d2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 05:44:29 +0000
Received: from AS8PR04MB8979.eurprd04.prod.outlook.com
 ([fe80::d766:4f5d:d928:866a]) by AS8PR04MB8979.eurprd04.prod.outlook.com
 ([fe80::d766:4f5d:d928:866a%4]) with mapi id 15.20.8857.022; Thu, 19 Jun 2025
 05:44:29 +0000
From: Vanshika Shukla <vanshika.shukla@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: RE: [EXT] Re: [v4 02/10] bus/dpaa: add FMan node
Thread-Topic: [EXT] Re: [v4 02/10] bus/dpaa: add FMan node
Thread-Index: AQHb2vEFeJgxWwhMuUKDN8bY+oUmArQKBG8w
Date: Thu, 19 Jun 2025 05:44:28 +0000
Message-ID: <AS8PR04MB8979F17D474E4DC437BD0BA6F47DA@AS8PR04MB8979.eurprd04.prod.outlook.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-3-vanshika.shukla@nxp.com>
 <20250611095058.19efbede@hermes.local>
In-Reply-To: <20250611095058.19efbede@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8979:EE_|DU4PR04MB11340:EE_
x-ms-office365-filtering-correlation-id: ee8f84d9-0f33-4d38-b6ea-08ddaef45bb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aEJGMG1qT3NBdUpYdm1uK3h3T3ZvYzFDWXhRMWNieVMydFNZQ0hKYUx3cUd2?=
 =?utf-8?B?aHVHQnI5VzNUWDRzbGRiWllLczNTZUFpdWxCYU5PM21ZQ1FqZlorV29ybjNv?=
 =?utf-8?B?b3hFcUdoM2dSWXBWeHhSMmgwbE5lLyszQlhFSCtWUjViR1lVSTlqWDJ2OTE1?=
 =?utf-8?B?dng4NjhKWURQbjR1QW1ZZFYvZVRHRVR1NnZqT0p4cHNIaWRMTDZjWUI5emI4?=
 =?utf-8?B?cFptUnU2bXZiNUZ4bE5rRDJ5N1R4bTRobWt0MkxJZ3paQ1B5bnlXQjYxWjVz?=
 =?utf-8?B?YmNFTi8rQ1l3RjhSNFV4Y0VqTmVVYk9jSnFQaEo3eVd6ekExWkhlWEcva3Rj?=
 =?utf-8?B?SHVyOGgwdjRGaXQwOFlwMkhLdGlDRFB6a1FtSElpbHZzVUN4Nmw0S0dxTmw5?=
 =?utf-8?B?VmtOT3JhMEM4WENjVVJoTDErWWFTSFdlbGlwZGVxRU04SmRVMmFZTTU0dUx2?=
 =?utf-8?B?dG5HOW5vSXVMT2VqcDdTbmdLekhsSDJQYVk1Q2YwektJRGh0dDJqbEZDQkRX?=
 =?utf-8?B?NFZERys4NUVxK1pqTWljb01BakxScmk1TWMwVmswNGVmL3dvazh2SW9hRTla?=
 =?utf-8?B?YkVqSVpZRUlvTzlscHpDUjVqVjdNMTNxaDFxT09yNTA5NTk0VDNpZTlHQ0xj?=
 =?utf-8?B?aStMVDdEMGhMRVZEOE5WQnA5SzRUc29HZ3RBUGliR0JscWZub0tJKzBYUmk3?=
 =?utf-8?B?NlNCS2ZnRmdXeFNPR01iT2cvUkx6Yy8wYkdjZHVIWnFUTURIYnBSYjdWRm9J?=
 =?utf-8?B?NUt5b3RiVHR2a05VV2xPamZuY3JrQVBUU01hSlRCVjlLTHFvNjVNN09JVnQw?=
 =?utf-8?B?ZllDaU9Sdll4Mmh2VDN0cnlZN2Z6SDBjYlVycXM2QmprZDc0VEtWNDBUcURW?=
 =?utf-8?B?djdCdlI0aTZnL0duWkJRVmtXdTRPY3U0MHhYdUk4SmRmb2lBc2ovMExQV3dh?=
 =?utf-8?B?dExLZys0Tzh5czZUbWxEWWI5dHBCS3Vkc25BV3NSVkVFVzZOQ2o3a0NIWW1k?=
 =?utf-8?B?U3JpWGUvT1F3ODQweUczQ0ZCUk5Gc1Riem1QM1JSbEorRzJvVU9FNWkwOHBG?=
 =?utf-8?B?T1R0ZU9PZWJERVBRMmRqYXNTcUNKUTVka0w0OFRVUkg4cFpRcHo2SUJBTVdP?=
 =?utf-8?B?MktWQVg5UFc4MHF6Y2dIMnhtQVQrc1QxZmdnNG9mYm11TGhsWFoxNnVRY3VP?=
 =?utf-8?B?YlBqL1dFWC9HalVlcEVPNDkzWDJiZHhVQm82VEd5YnA3WnRLTk90SE5ia2Zz?=
 =?utf-8?B?LzBscXl6SW5zWC9iYzFVSGhBcytBUFp5bWluS0ZVRlFURDhMaU9ocFhKdkcx?=
 =?utf-8?B?QjkxdjF0OEFTQ1NJZ1RhaGhQVmRiTjlGd0puRGhrRDB3bzJHTVdIcnVOWmhp?=
 =?utf-8?B?VHRoR2Jna2ZjMWxNbTdKK2ttRWdyVHpXOVpoZXZjdGFMMTdUeFBWNHoyM3Bm?=
 =?utf-8?B?M0tndWZQV1JUcHcvVCtEWmowc0YySndXWWpGaGdqTDhKOURpakJMeHFpdFMw?=
 =?utf-8?B?UERGdXYyTmJUNVFYOUNuMExGcHNkdk53WEtPN0pjYlVqKy8rdlpXUmlHejlr?=
 =?utf-8?B?SmpJOEg2dkpzenpuV2JIUUwrR25MbnNNcE9tY3hoZ3BCb2Rqd0ZmYjVVcUt4?=
 =?utf-8?B?cjhTZ1EzeXlVc08vK2p0Nkp2bnpRd2FsV05aZyt3NTdidktVY3NXcCtiRUR6?=
 =?utf-8?B?UWZYSnNnSEdwUElNYnBaTmVwZXBlRDNwbzRZZUJ6KysxWFFMZ0RTVU1hMi90?=
 =?utf-8?B?Q29jWE9IakFVdzk3eTVNYW43WFdBcm9Mdlh2Uy8rWTdESkdPZjJvV0JPMU9v?=
 =?utf-8?B?Qnp0aUROSlRkSEhhdnl3bHhDS0thODkveFo3dnNOSlNEdDJNTWZzcGFndWpo?=
 =?utf-8?B?bFNkVWhBQ2NPeUJ5aXAwRFpURkhTODhkeEppemZPcW1zSmY1RXk1T2tENzVO?=
 =?utf-8?B?S0wyNEJrQmU2UkVKZTFndVlGR243UWtZZ2RpeVZtQjVNS3BWWjdHWVN5enhp?=
 =?utf-8?Q?P7iDTpMLuUUTa3IcSIs2zWHERxceDs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8979.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zi8zMVpJUGFUMTN4T3FhVnNhU3Ewck9NUThVT1Z4dkJXd09iMHVzV0RSODUr?=
 =?utf-8?B?ZCt1YlN3UFRPMUZVWW5vdFNqM3pBcS8wTUNTeEVCUE9rQy9ZVG5DZnRTYzB3?=
 =?utf-8?B?cEVXcFpRQmFlUFpNMWMxTytyeDZoWEFKa2J2VGtRb3I5akMraUwzQnFjY2xG?=
 =?utf-8?B?MGNRZU9CSmZVZmVwSlRVR21ONCtvWHNKTjdGRDVYS1YvZEc3T1lCWVZWdlZv?=
 =?utf-8?B?bXhxbURMTmhud3VTZy96OU1iS2lwbWp5WW1yV3hLZUVPR1BKKzY3cWJqVm1I?=
 =?utf-8?B?T1VYT1NHeUNvWi82U2JEZnVEVnY5bU9aa0YyNDY5RVIrUzdXS3o0NklteVpk?=
 =?utf-8?B?SmdIZUxLU2g5R002WEI2NUpFTVdKZnl4WlBycEx0dEFpV3EybWNmR21zQjdB?=
 =?utf-8?B?RS8rbnI5STlsZlNmTW5ZOEh1NG9PdXMvbE5nQ3UvZXRDTXlKSC9aTjJ2VVdM?=
 =?utf-8?B?QWlMeXpvRXk1eFNFR2pCZXU0eUtWZ1JPM29JbmpySlB5clgzTGJ5cStwbkt4?=
 =?utf-8?B?TThYTkJtV2Y2S1VWSzlCamFlUnNrN0NKckp0NkJBbExSRGNIQUtrNHE4Zml6?=
 =?utf-8?B?UjRaN2VxOThzOGxtRmFadC9wcW51SFU2NGFrdHVpOHYyRGxxNEV6Q2pVUU5E?=
 =?utf-8?B?dW5BUitublRZVDEyTTBVSS9HM28zY1lGU0tEU0pXZkVKa2RYQmxLOGE1aDRH?=
 =?utf-8?B?K3diQVQ4MktzVUQ4Um9IbXBuTXFHdXB0Z3lId2pmNmEzMjEySzVacnhWTG0r?=
 =?utf-8?B?Z2xxdldJZ1JMZ3c1bEZVZmxxR2o3MlJOVjBoZzc5S2ZkWDBJZlJvT084YUNk?=
 =?utf-8?B?RFVVV1ptYUFGUXlBSGVCUnF3cis5cklFUTJPS0tGaW9PYWp3dExhYjkvQWR6?=
 =?utf-8?B?eWNQZnRnZ2hTL0EwSnl2UmpCUkgvUFMyVGpmbTFJcy9rTjNHYnZFSnlNRnVs?=
 =?utf-8?B?aTVtOEowSEdXeFBzQ0MxYmc2cFFWK2NyK1hiSmgrZnc4UVErZFVCM0k1Q2Ny?=
 =?utf-8?B?QjhVRThnSmNuejgzem16QVJ4VENGa0pjWjBmUE1aTmgzcWUwNEZQOWdvOS8v?=
 =?utf-8?B?eWlFSm1xdTlyQ2FVS2lNcVlObGNpaGQwcmJyTmozY21MNVYrWVNCT21LeWVk?=
 =?utf-8?B?ZnphRUFpZ3gxdy9TTWZsN0hRYm5tdHJRN1RBNUN1YzE5TmNwdFpGMWNQOWhi?=
 =?utf-8?B?ajVOUWUwdU5zVSs0V2dJdFVERWQvbzFXTm5vbFc2TmdUOE1vajQxTDhnSStt?=
 =?utf-8?B?RFVjMzJ2TnlPWUswMmEyU3h6eFR3c1N0anYvOFhrbEJiNHVsS3NJRDRjbWRh?=
 =?utf-8?B?YkRUcExkdWowaThVUnd3R0JvM0NYYzU3b05MamgvejFPQ2ZaZDRIcklzQjNn?=
 =?utf-8?B?b0IzS0dQV0ZVeXVqbm83Y0pQZEZZb25ZVGRMSjMrdlhHSHZHUTZwMDVKZ3B1?=
 =?utf-8?B?QVJUTTFXRDNJa09zOU1pVm84QTJOYkNvYThsUUNQbnMwK0tkdjhFQTZuMktN?=
 =?utf-8?B?QTdCV2hHK25UbC9KZ0RaQ0xxM29xbncrZVZ5KzFpMUxPbFcwNGdweGlLSjlX?=
 =?utf-8?B?aWEvbG5CaUFCUG1pT0Q3M0ZiMnNFcUR3R0N1SXNiMlRFQ2l1MlE1MjA5RlFP?=
 =?utf-8?B?eFU1WXFLcFk2RUNiWksxN0NVTkxLQTB6WTNqaGR0K2VsYnJLMzVFeVZ5eVN2?=
 =?utf-8?B?b1MycGlSdlJkcTBxa3cwaTRLblplRXBDN24rRklwZE5qSDFnQ0tldzFtOWNz?=
 =?utf-8?B?U2V4ZDB1K25qYjFOUnYwNmxkN3UxMWJsY3FXajBVNHlsalFJNkIxVjkxaGVW?=
 =?utf-8?B?dnNzQVFnMEFXZU5pL1ROd25naFcvNTM1MlcxVEhTdXEwdjQweXJITHlxSlgw?=
 =?utf-8?B?TzFCNWY2SktHOGhhQUMvMmQzQ3cxVFVLMkcraE16SFZVNUpGeXRWbHU0Mi9I?=
 =?utf-8?B?WXFvVlhVdjkydy9hTFlnNkVRcmZsSHNWRVBQaDdEcWc0M0FDdDRNTkF2bmhS?=
 =?utf-8?B?UXVHcmtYcXNwV01zQ0VXNTdhUVFlWldUUENKUytnbTM5emdFLzhkaU9EYmo1?=
 =?utf-8?B?K0xxY0hldFV0cy9ubWdVeWg4TmJPRWcxS2dRSlYxMENKTXQzT2lMejRUMURw?=
 =?utf-8?Q?3bWBWkC7RuAM4HZkyjgc/msa6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8f84d9-0f33-4d38-b6ea-08ddaef45bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 05:44:28.9490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4TGWMCKV7Z6l140X82HWTy4+NvKdFjFW9YJdu0e7n+xD64jficAL6yWbRpztw58hk8pTnUjml2l2BrTb1/PFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11340
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

SGkgU3RlcGhlbiwNCg0KUGxlYXNlIGlnbm9yZSB0aGlzLiBUaGlzIGlzIHZhbGlkIHdydCB0byBE
UEFBLg0KDQpUaGFua3MhDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNlbnQ6
IDExIEp1bmUgMjAyNSAyMjoyMQ0KPiBUbzogVmFuc2hpa2EgU2h1a2xhIDx2YW5zaGlrYS5zaHVr
bGFAbnhwLmNvbT4NCj4gQ2M6IGRldkBkcGRrLm9yZzsgSGVtYW50IEFncmF3YWwgPGhlbWFudC5h
Z3Jhd2FsQG54cC5jb20+OyBTYWNoaW4NCj4gU2F4ZW5hIDxzYWNoaW4uc2F4ZW5hQG54cC5jb20+
OyBKdW4gWWFuZyA8anVuLnlhbmdAbnhwLmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6IFt2NCAw
Mi8xMF0gYnVzL2RwYWE6IGFkZCBGTWFuIG5vZGUNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4g
ZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0K
PiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2Ug
dXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gV2Vk
LCAxMSBKdW4gMjAyNSAxMjo0MDozMSArMDUzMA0KPiB2YW5zaGlrYS5zaHVrbGFAbnhwLmNvbSB3
cm90ZToNCj4gDQo+ID4gRnJvbTogSnVuIFlhbmcgPGp1bi55YW5nQG54cC5jb20+DQo+ID4NCj4g
PiBBZGQgRk1hbiBub2RlKHMpIGFuZCBhc3NvY2lhdGUgRk1hbiB0byBpdCdzIGludGVyZmFjZShw
b3J0KS4NCj4gPiBUaGlzIG1ldGhvZCBkZXNjcmliZXMgRk1hbiBhdHRyaWJ1dGVzIGFuZCBhdm9p
ZCBhY2Nlc3NpbmcgRk1hbiBmcm9tDQo+ID4gcG9ydCBkaXJlY3RseS4NCj4gPiBMb2dpY2FsbHks
IHNvbWV0aGluZyBsaWtlIElFRUUgMTU4OCBpcyBGTWFuIGdsb2JhbCByZXNvdXJjZSwgd2hpY2gg
aXMNCj4gPiBpbiByYW5nZSBvZiAweEZfRTAwMOKAkzB4Rl9FRkZGLg0KPiA+IFBvcnQgc3BlY2lm
aWMgcmVzb3VyY2UgaXMgaW4gcmFuZ2Ugb2YgMHg4XzAwMDDigJMweEJfRkZGRi4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEp1biBZYW5nIDxqdW4ueWFuZ0BueHAuY29tPg0KPiANCj4gVGhpcyBs
b29rcyBsaWtlIGEgdHlwbw0KPiANCj4gIyMjIFtQQVRDSF0gYnVzL2RwYWE6IGFkZCBGTWFuIG5v
ZGUNCj4gDQo+IFdBUk5JTkc6VFlQT19TUEVMTElORzogJ2NvbnRleHRBJyBtYXkgYmUgbWlzc3Bl
bGxlZCAtIHBlcmhhcHMgJ2NvbnRleHQnPw0KPiAjMTQ3OiBGSUxFOiBkcml2ZXJzL2J1cy9kcGFh
L2Jhc2UvZm1hbi9mbWFuLmM6MTI1Og0KPiArICAgICAgICAgICAgICAgICogU2V0IEEyViwgT1ZP
TSwgRUJEIGJpdHMgaW4gY29udGV4dEEgdG8gYWxsb3cgZXh0ZXJuYWwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eDQo=
