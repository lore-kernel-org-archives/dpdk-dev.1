Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436C8C36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 09:53:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17F43402C3;
	Wed,  9 Apr 2025 11:53:52 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by mails.dpdk.org (Postfix) with ESMTP id 41ECC402B7;
 Wed,  9 Apr 2025 11:53:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qy0IgbI5ieievI2K8gJmcY2aU/lehX4QGecY/PGkDrblpaHIlM6gC1xNEtlAdjpF0A5wBd/IbeeicAXLQOO5ALg++/OmC7uZ0mW60Jy7qq4/U9fdOPKPy8Ekm8gd73ZHeIJM4dWQa2tzpP/WPrWRK9w/WIDv9vHbeHSjt/u64xxufeXW9q4qJZXtyFZXFjocRSfFC34kFkpVtZu4IhGArMjHgVvpYL1MU9Rsh1HWJWjwTcoeOLAZQNAiLEqaGzHeuIYHXzcqBBQCRKloDQfGhm0PzWMfMaT4xsF3Kc8LLjCNXmmRQ3ncyg0nc0bVUfRVD7GSp0tuVTwVbdo5hABhag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afLhITKBplocJ2Ke1RYnMp8GFbk8k8EhjdUMn23v7dE=;
 b=VK6dzcMSMfa71Ew1fAwrDw1hbmNGyfNrcgpyF7oHUzYeSCt4ryzxUx4dK8asmOcofNvpy/7wpWWUqJPRqBFqPnfv3CpOpzKa30P5NehstxWu08Ys57O1SBVr3/liaj9Pm7oN5N9Aeh8YGu5GR3AoaRw31ZlhJ2dKHdqVVaOfZSKQs+SzQ+0F2Wk60+hml+9j+9vdFaCutdU/W8astdAjvKWhyfYafEkDTJtYfFLc9wBzo/oVcrx+7dtfLIpGQF7vJMkEzFxyyCl9OzznrHxcd3McjG0DG7sazSumkfdh3lXPxZEv7eA9HqOBgPvB0G3hmKCjBMRZZjzvfhAuGFHfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afLhITKBplocJ2Ke1RYnMp8GFbk8k8EhjdUMn23v7dE=;
 b=fVtAD8mtfD/HGBT5SeGDPl4JwHj1z7jcVcfP3uCpSJLtoznUsX26P5GBM4YbivFRjFX1OmOYzafCOksb1EZobiAEiLmzU9u6VZDeBn9lSvv8L1KwiNRNpCewWBEsXTcpEhCYuz9bgja2MbO8WAa27Lxl5dffC/m4HRUdvdH2Cj4=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 09:53:48 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%6]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 09:53:48 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>
Subject: RE: [RFC PATCH] build: reduce use of AVX compiler flags
Thread-Topic: [RFC PATCH] build: reduce use of AVX compiler flags
Thread-Index: AQHbnap+toVmyOb4LkGBn3uRVxEYc7OFmwoAgAAdWwCAABSTAIAVYZ0Q
Date: Wed, 9 Apr 2025 09:53:47 +0000
Message-ID: <PH7PR12MB859614316DC742F0C8A12B3082B42@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <Z-QposchDMAmn83I@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB76@smartserver.smartshare.dk>
 <20250326122036.6cc7c02e@hermes.local>
In-Reply-To: <20250326122036.6cc7c02e@hermes.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=4ae1cc40-2442-4c4f-b8a7-f2bb802d1d12;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-09T09:51:38Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|DM6PR12MB4401:EE_
x-ms-office365-filtering-correlation-id: ec211b26-2270-48ee-87ae-08dd774c6ca1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZE1WS2wyaFByWUwwbXk0NkxJVytyVklqZGV5bFBpMVcrdXFkeTBSQjdjNzNK?=
 =?utf-8?B?NktOdCtGMCtIM0dFYml2WTZRYmV5Zk1zYk9mOGJkdnlCeTE3VlQ5bmlxMGJp?=
 =?utf-8?B?cmVraFM3WVhsTXN2R296cHZMVVpwUUs0VlRYUTEyQzRTcnpKd1VHd0M1Vnhz?=
 =?utf-8?B?bm9INlYrcEdva2NLZE1UeUNFbWpoTVZMRVZWci9TcE14ZmtMejl6MW5yNjN3?=
 =?utf-8?B?R2xHZ2FjTGlLUm9hY29xK2JQSERveHM1SVJGb1pEdmNvYXV6OFpJODBRZGtZ?=
 =?utf-8?B?bGJmWWpVNFRENTE0eEdvaDlGMW5CQWdHSkI5eUNMTExoelpKRlNiZlQ5ZCtY?=
 =?utf-8?B?ZkVuWWViS2pOeGFqbTJVOHFaS0pPWkl2eVpFckxPaS8wSktQTERwd0RiZ21F?=
 =?utf-8?B?QktpQ2lJN01vRzZhVFBTa09LT29sRWhidEd3cmJMTVZMOGRieSt0RmppUC91?=
 =?utf-8?B?RlRDRjRkUGREQzNvZDZkbS9sTVRnVHdUUlNEL0tWNldsR0dxKzdoNmxqMVRz?=
 =?utf-8?B?WVBuVTNGeXBqSnlLY2FubjdzT3pqcmZ3citNTWZQN3JpcGU4emNqQXM1MFFs?=
 =?utf-8?B?Zlg5bUZ3RWFRcHNnWS84VU1saDFSK0JZMTZoYk5uRUduOXhTYTNwYnVid1di?=
 =?utf-8?B?VFZabEVWay9tejhyMHJBcm1Wem8yUEk5cXlRbkNNSkRxZkpJMEh0a2ttZ0xz?=
 =?utf-8?B?NGptejN5ckNFRDMzWUgyVmczaWVLUUZqVU1LRytSOFlqK3YybFNSbFlOdlI1?=
 =?utf-8?B?NEYvZ2JqSFd0cFFhQmIvV1FCTjNaSnVuL3gvVGV1aG80c3RNTGZ0OElXQnlY?=
 =?utf-8?B?eWp6b3dabm9HZ09TemNrOFFRVy9hMTYvN3UyMng4dHZwbTBaL0JRSHBTTEk3?=
 =?utf-8?B?dTRZQVFyTlg4RHRJbDVVUGE2cDZyYjNjc1hRMENLc1Q5RndWMTJncHNxY3Jz?=
 =?utf-8?B?TWZhT2Y0VXdEU1hFM1pjeVN2OXorSVdLMUNrSHRQZ3NLWW5lbEJDOUllRFdk?=
 =?utf-8?B?M2tWdVBwSDM1eGE4WTJxa211MS9hNk5NdWxyaGk0RkxlUWdwN2hJeGJOeXlv?=
 =?utf-8?B?enZlTTMxZEZ2aUlwemRXNXE0TGtNbUZvU0VEVGhPbm1UOEorZTdoUXorQW0w?=
 =?utf-8?B?aW93cmdrYjZPYy9BNVpkNW9zb1RRRERydjMrTk41bVRKamI4WW1tMno0SHhE?=
 =?utf-8?B?VGJTZEZTSW40ZCsvVjIxdm55NjZ1a3pSNEd6VmxLWmd3VWZmM2tnbTdxWGhr?=
 =?utf-8?B?aUNqVCsvbllvL3IxQTVFdTFGYVp5dS80YU44Y1NJOXdZR1l6WGdmMVlXWlc2?=
 =?utf-8?B?aUpwZ3VPZkhGNEl6RkxIY0xqanVEbE0rYmNIRFNDM1JJcEQ4VUhHS25ISGNt?=
 =?utf-8?B?U0tDUW9meENlS2twa0NIUCtZaHpxaUYzTzYzNWNsZ0lwOWRqQUtld2FsdW5B?=
 =?utf-8?B?RjYyOTM3c3lFK2J2Q3ZPMU44WlBRVGN6cmdraitveXl4bmFCaHhGc0NLNk1U?=
 =?utf-8?B?czZTbWxjVzFzanMybXp3Y0pQUGxJNTRTOTYvQ1BvM3ExWnRYS1JaUlZvY2w4?=
 =?utf-8?B?RUhzVE5HcWxSM2tKRjFHQXFuUkJuQ0xISXdwazVrU3I1WWQyVXlmRm9PVDlm?=
 =?utf-8?B?ZlN6NDJCcVMrcVljTGxIcThCWXpzRXplL24ra1Rid0dGMEpDbGNESW4rcTJi?=
 =?utf-8?B?Y3lkTFNSVjdudHh0Y2QwbnNUY0N5K0tqNW1LVnFERVpvbm9nZ2V1VVRvTk9j?=
 =?utf-8?B?cHVVMmN3YVhaalE5em9UbVY5YkZYV051Tzl6Nlh6bEgrSlVWRDRWUW5QNG1i?=
 =?utf-8?B?MjhoVXI0VmRPRFF5UWF1Wjg1N3dYbGdKR0RPSXJBbWw2YzdUVVZYQ0pGd1lX?=
 =?utf-8?B?MFNURVpVQ2hHZmRzdjByd0hQbWJ3NVNqOHZLajJtVi9IYUlWOTF0NGVkUjNj?=
 =?utf-8?Q?yPjRM/djsWubpIOAZWOMGMtzE4VPbMun?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1BWV0gxcmhCcEZZb3JPNXNxUmgvRmZ0ams2YTlyODhjUGJXQ2RXdU1aZnNE?=
 =?utf-8?B?djdSQlVlbGxlY2NLTHZiN2lRMklvS1dlVGpZYU9uVGxaYlM1M1NaWEdodytz?=
 =?utf-8?B?ZElUSkpmZFBTSzB6NzZFZjZIWndWNElicXdYTnNVNzZHTHVtdXdWYjNGREFo?=
 =?utf-8?B?Rmk5N2VzNldrNnA0dlhLN2F3ZnY5R3NhNCs1UlZwMHJUVFV0eTA5ZnByQVRO?=
 =?utf-8?B?cjdHTWljOVVOM0R5aXkrNms0aVV4enM5Y2ZDanppQW9PTVV0UFo0NFVCL1FY?=
 =?utf-8?B?TDREYXpvdlVocGdNSFZERTR0N3BkVWtFWkRZeHdOZzBWbUpzZVRBdXZXZ0NM?=
 =?utf-8?B?ZXVvcFdxbjJkYWZJUVlzRlNzR25tdDdhUlR3NUljeENEd1R0N3c0WWMyeUg0?=
 =?utf-8?B?d0VVNk43Y21DZGhUY0xjV29DL21GK21pRkk5UCtqdmxkUnA5cDg0MU41bDhT?=
 =?utf-8?B?RVd2WjgvQm1KRjh6OG52NGNwYmNjK0lRV01KWWlvUWd1TUxsaDROcGhjSXA5?=
 =?utf-8?B?VzBlR2ZDQzFpSDVocTV6ejdKaUR1dEllcE9GVFFBUXJTRSs4NjFaTlB3MVVV?=
 =?utf-8?B?ZWVGd3NHbmcvSGtkcmNGcitaQWFrR3c1cEdod0MvRGlhZ000ZmtHTnBaNmFw?=
 =?utf-8?B?bko2a0ZtNVNYZUZhbmlpUFZWVU1ONjB5aFFJbnJhRmcyN2tSQU9idGpWMXdJ?=
 =?utf-8?B?VUVUMGFPWmQ5T2x2YThmSUc4bVRqUnYxdjJNcGRXeFhQQWFNdlFGOEJhN1k3?=
 =?utf-8?B?YmxQRVIyVWlnYjZTL3h1V2dZTkdxY3BvbVNYZUI2TjFpa0U1KzZ4bWFPU296?=
 =?utf-8?B?bWF4NzlDYVJUVU1GZTFZUC9hZDlaV1RNLzhGNHlMY2x6NGxVdFRvL0FObWlp?=
 =?utf-8?B?SWczSkdtaVdxSnY5MWlnS29qUWNQaE9QMkdNaEZZSzF3b29xU2pNNTRvMVdq?=
 =?utf-8?B?TTEyM3h1RzZJTFhjVTFMY094OVFYdXFod1lCMzViTlh3VEZmRmF5S0N6UkdC?=
 =?utf-8?B?aEExb3VxWlBualRLMXdxNkZTWGQ0VU5VN1FEZ05jN2N3SXU5Q05NUUV4dXJI?=
 =?utf-8?B?UzJiaU44akRGQmx5UFplZi9rdHlxL0pkTDdiSis2RStuaitQMGU2SHhRMFVH?=
 =?utf-8?B?TGZqeSszS3B6UjlpemhUbWVlRUdGUjNGNVVBbXJFSzFFM015eUl1K251eFMz?=
 =?utf-8?B?cnZRMmt0bVcwbGZUT05KcC8wUFc2MXA2cWs1MHAzYkJ4NlNXeDRyZ2dqeGQv?=
 =?utf-8?B?Z0gwRFJVVXZ2V2JJbXl6ekVzd2l4ZkFyREZJUVI1ejRWNUtQNW1HREtGWHZ6?=
 =?utf-8?B?THpmUFFHNjhhRjFNWWZoTHJ4MnZkTWRxN3dBTjVYN0c4WGE0Lyt0dWlTeWs2?=
 =?utf-8?B?TExMTEt1YXRldlZCUnJ4ZnVwOWo2dXk3ZG1LUDBtS2pQMVJSRXJZSHlmdGRG?=
 =?utf-8?B?ek9DZWpRaDhpR2FnUG1iZGtLL2wwTjF0NGIwR2pLeWlmNGpjelNPTVBCWjZI?=
 =?utf-8?B?N0QxcjB3S1VtUjZHMW5rbjEwa1MvMmc1dnpjYjlFZDgzM1V4alQyRm5SVTdR?=
 =?utf-8?B?SytLNlJmMzJGVmRZeTNaNFRyTk11dGxJYmRsM0VaY0d2d3drQkI2R2VMU2Rw?=
 =?utf-8?B?UTR6MERZM3hnWDU4eVJDbm0xamlqc1A2ZW8vS24yQ1krWWJ0aVBDTERwYmVw?=
 =?utf-8?B?UWw2SytpazUvQm8rdXVVeE9oN3g5eFJJMkJ1bTNUSys1QTNkby8vYitpbUJ3?=
 =?utf-8?B?RThodzRJTGlQNnNzazZHeU5sSDZFSVA2TDAraldBTWRNRHV2WGZFU2J3cDUx?=
 =?utf-8?B?d2FDTG9rZ21kb29RWk03ci8xWDZEdjBOSVl5SDBjVkFEMEl0NitLbmk5YWdE?=
 =?utf-8?B?RHVsSXJTS3RtanhUVjZQazJ5VmJmMU5HUnJZUVd4ZndVTVpINXN2aE5mUG5o?=
 =?utf-8?B?MmI4ajRwOURLV1lIUnBGazdHUkZ2OVpUNmFXc1padWxZUXhJNnMrV0tlMnhI?=
 =?utf-8?B?QjdFMlo5bE5GV0hlaTFMN3Zqbko5NHRPbS9pY2dnSVNjaWt3clk1ZC9Va1Vx?=
 =?utf-8?B?Y0ZCMm1zWkxZdWJBdHVmY1lTS2w3MnhobmtBeS80VGJZNVBNb2dBZm9HT0Rs?=
 =?utf-8?Q?e0I4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec211b26-2270-48ee-87ae-08dd774c6ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 09:53:47.9835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SttApPxoLaeq+tT/8oG2BzfFMYh918EQzLL98fG+jBa0HufD/N3ynrBduTkzlopwyk9fNjFv/tHQwjWyThIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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

W1B1YmxpY10NCg0KU25pcHBlZA0KDQo+ID4gPiA+IFdoZW4gZG9pbmcgYSBidWlsZCBmb3IgYSB0
YXJnZXQgdGhhdCBhbHJlYWR5IGhhcyB0aGUgaW5zdHJ1Y3Rpb24NCj4gPiA+ID4gc2V0cyBmb3Ig
QVZYMi9BVlg1MTIgZW5hYmxlZCwgc2tpcCBlbWl0dGluZyB0aGUgQVZYIGNvbXBpbGVyDQo+ID4g
PiA+IGZsYWdzLCBvciB0aGUNCj4gPiA+ID4gc2t5bGFrZS1hdng1MTIgJy1tYXJjaCcgZmxhZ3Ms
IGFzIHRoZXkgYXJlIHVubmVjZXNzYXJ5LiBJbnN0ZWFkLA0KPiA+ID4gPiB3aGVuIHRoZSBkZWZh
dWx0IGZsYWdzIHByb2R1Y2UgdGhlIGRlc2lyZWQgb3V0cHV0LCBqdXN0IHVzZSB0aGVtDQo+ID4g
PiB1bm1vZGlmaWVkLg0KPiA+ID4gPg0KPiA+ID4gPiBEZXBlbmRzLW9uOiBzZXJpZXMtMzQ5MTUg
KCJyZW1vdmUgY29tcG9uZW50LXNwZWNpZmljIGxvZ2ljIGZvciBBVlgNCj4gPiA+IGJ1aWxkcyIp
DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEJydWNlIFJpY2hhcmRzb24gPGJydWNl
LnJpY2hhcmRzb25AaW50ZWwuY29tPg0KDQpIaSBCcnVjZSwNCg0KRnJvbSBBTUQgZW5kIHdlIGhh
dmUgdGVzdGVkIHdpdGggZ2NjIDEyLCBhbmQgMTMuDQpXZSB0cmllZCBjcm9zcyBjaGVja2luZyB3
aXRoIGFuZCB3aXRob3V0IHBhdGNoIGZvciBsaWJyYXJpZXMgc3VjaCBhcyBgbGlicnRlX25ldF9p
Y2UgYW5kIGxpYnJ0ZV9uZXRfaTQwZWAuDQoNCldlIGRpZCBub3QgZmluZCBtdWNoIGNoYW5nZXMg
aW4gdGhlIGFzc2VtYmx5IGNvZGUgZ2VuZXJhdGVkLg0KSSBob3BlIHRoaXMgaXMgZXhwZWN0ZWQ/
IENhbiB5b3UgcGxlYXNlIHNoYXJlIGFueSBwb2ludGVycz9cDQoNCj4gPiA+ID4gLS0tDQo+ID4g
PiA+DQo+ID4gPiA+IFRoaXMgcGF0Y2hzZXQgZGVwZW5kcyBvbiB0aGUgcHJldmlvdXMgQVZYIHJl
d29yay4gSG93ZXZlciwgc2VuZGluZw0KPiA+ID4gPiBpdCBzZXBhcmF0ZWx5IGFzIGEgbmV3IFJG
QyBiZWNhdXNlIGl0IGVmZmVjdGl2ZWx5IGluY3JlYXNlcyB0aGUNCj4gPiA+ID4gbWluaW11bSBj
b21waWxlciB2ZXJzaW9ucyBuZWVkZWQgZm9yIHg4NiBidWlsZHMgLSBmcm9tIEdDQyA1IHRvIDYs
DQo+ID4gPiA+IGFuZCBDbGFuZyAzLjYgdG8gMy45Lg0KPiA+ID4gPg0KPiA+ID4gPiBGb3Igbm93
LCBJJ3ZlIGp1c3QgZG9jdW1lbnRlZCB0aGF0IGFzIGFuIGFkZGl0aW9uYWwgbm90ZSBpbiB0aGUN
Cj4gPiA+ID4gR1NHDQo+ID4gPiB0aGF0DQo+ID4gPiA+IHRoZXNlIHZlcnNpb25zIGFyZSByZWNv
bW1lbmRlZCwgYnV0IGl0IHdvdWxkIGJlIHNpbXBsZXIgaWYgd2UNCj4gPiA+ID4gY291bGQNCj4g
PiA+IGp1c3QNCj4gPiA+ID4gc2V0IHRoZW0gYXMgdGhlIHJlcXVpcmVkIG1pbmltdW0gYmFzZWxp
bmUgKGF0IGxlYXN0IGluIHRoZSBkb2NzKS4NCj4gPiA+ID4NCj4gPiA+ID4gRmVlZGJhY2sgb24g
dGhlc2UgY29tcGlsZXIgdmVyc2lvbiByZXF1aXJlbWVudHMgd2VsY29tZS4NCj4gPiA+ID4NCj4g
PiA+DQo+ID4gPiArdGVjaGJvYXJkDQo+ID4gPg0KPiA+ID4gUGluZyBmb3IgYSBsaXR0bGUgYml0
IG9mIGZlZWRiYWNrIGZvciB0aGlzLiBBcmUgd2Ugb2sgdG8gYnVtcCB0aGUNCj4gPiA+IG1pbmlt
dW0gY29tcGlsZXIgdmVyc2lvbnMgYXMgZGVzY3JpYmVkIGFib3ZlLCBvciB3aWxsIEkgY29udGlu
dWUNCj4gPiA+IHdpdGggdGhlIGFwcHJvYWNoIGluIHRoaXMgUkZDIG9mIGtlZXBpbmcgdGhlIG1p
bmltdW0gYW5kIGp1c3QNCj4gPiA+IHJlY29tbWVuZGluZyB0aGUgaGlnaGVyIHZlcnNpb25zIGZv
ciB4ODYgcGxhdGZvcm1zPw0KPiA+ID4NCj4gPiA+IEZvciByZWZlcmVuY2UgR0NDIDYuMSB3YXMg
cmVsZWFzZWQgQXByaWwgMjAxNlsxXSwgYW5kLCBDbGFuZyAzLjkgd2FzDQo+ID4gPiByZWxlYXNl
ZCBTZXB0IDIwMTZbMl0NCj4gPiA+DQo+ID4gPiAvQnJ1Y2UNCg0K
