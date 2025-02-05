Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA088C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:36:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 319EE40611;
	Wed,  5 Feb 2025 17:36:16 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by mails.dpdk.org (Postfix) with ESMTP id F390F402F2
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:36:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K85rN/ZDaYAN0GnbD9iMr0Nwz4l5CTBLpN8sCcAB8QsCCmUA9XUHkN1sok4xChfTHE7xqEvH6zj3uYOErVQj5bP6RJvEHsoOm+LfNVjqKU9L1fA+j8fMRydE4tFY2d30Ak0cTIKdY8riwPhJoJzkCAary6R28LyPLO9qp7DJkMSZF4ikOVGNVJBH0FIZWl24I9FPLiHqdHyclyvxKKefmCN2L+Wwr1Ehk7rfFTU2DmNFCi0JDPkIo6NHbqPgH8LGhPwUmtcylo0TUCIlIKUSngjKFVwrunOHiH6EkYl19SLSFIf+iph9Wjv1AzfciORHgamJS+MIkCMpif4iMjrm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bykMQSlaXj1q9iYkbmGjSTUZVQ+/R8eh0GjGXA8uqE=;
 b=I2YxuGBVJbBbvpCyI1+/NK3eImYel34WYTQ0kyQOh9h+oNjE1pxbzo4lRFGb7d2l9Jq4W7Nct/xjdeHzp5GFOwEAWmM26BsGzMlz15l8ofxJqRdFgSg9+1b91vaOYKa2CwALVyx6xVpvyJmzl1lUq3k7wgodPmVAmMQjvCMDy8YGE9aHu1uFCHJm1lmq+a5DMeO9xefI5K+UVO0+xyRHFSBwCUgazC6fCFmR2Tk9SeoW7G0VH0Waf7uOI7ml8guZnymyamUs83pVTNAHdaHqSfhP+5k6xJnoss004x2X8N485zPjv1QA2alcCZ6NoKLx46Ga58feWxpdtjCErNHtEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bykMQSlaXj1q9iYkbmGjSTUZVQ+/R8eh0GjGXA8uqE=;
 b=EjNuR793ffm8gvhhNP9Ed4GUNg1PhseuC2I0QR2kYul5V+x1prUGPpFXuUIVJC2Frcu4YSY+Nbzh7rvs2EPx2W2grxLQKgW+t3djy7c1Leffpo3nO4v3Lz08dC2NETugytcR5e43Nzo+w3t+DAb4TiS/ufRlitoV5/nFZYvNO7ZJumUxdzw7gfdTaLvtYG5ry2C16/cUWLBjXada7rWGsfIDvmvusHaKH0VsUQw0IjiC644RjX17f4diCZ35CGUK8Ev3SAAFfFs71lukXsojUD9CbWH299zVa56euGZwSJFCS0dYcXhWULG17AvMOHq5Nn5HprlDbXePS23ySzWKBA==
Received: from SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 by MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 16:36:11 +0000
Received: from SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784]) by SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::83e7:75dc:5128:784%7]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 16:36:11 +0000
From: Shani Peretz <shperetz@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Tyler Retzlaff <roretzla@linux.microsoft.com>, Parav
 Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Hemant
 Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@intel.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz
 Duszynski <tduszynski@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>,
 "NBU-Contact-longli (EXTERNAL)" <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Bruce Richardson <bruce.richardson@intel.com>, Kevin
 Laatz <kevin.laatz@intel.com>, Jan Blunck <jblunck@infradead.org>
Subject: RE: [PATCH v4] bus: fix inconsistent representation of PCI numbers
Thread-Topic: [PATCH v4] bus: fix inconsistent representation of PCI numbers
Thread-Index: AQHbcitqrFX8S5R050u+BzY3Knp28rMt8G0AgAsCg8A=
Date: Wed, 5 Feb 2025 16:36:11 +0000
Message-ID: <SA1PR12MB94915F840D6A2D631AA02E1ABFF72@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20240708165145.1405107-1-shperetz@nvidia.com>
 <20250129085416.226718-1-shperetz@nvidia.com>
 <20250129082518.47630942@hermes.local>
In-Reply-To: <20250129082518.47630942@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9491:EE_|MW4PR12MB7189:EE_
x-ms-office365-filtering-correlation-id: 0b2751a2-5121-411b-0411-08dd4603330a
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VmNzSDJTS0Fna1h1d1NSV0hXNU00WGxRRjZxUW5jKzhJZFpydWxnL0ZsUHVj?=
 =?utf-8?B?YmI3N0Z1NE1YY2FkcEVUSUUvZFBFWkxEeDFnSlV5NEg5elcyOHhKQlNoVTJz?=
 =?utf-8?B?Wnc1Nkk2QkI1ZkFvdks2ZHlEbERkRU5VQ04yNUVwNG5nbkNpQytUOUhKNWVP?=
 =?utf-8?B?b04xVHpRVmdLc3RaSjhpNFFtdTlCZXNQZjRkSXdPendvQldnRlpjY3pzeWoy?=
 =?utf-8?B?WC9JRlJBUjNMcHVJcklxcUExKzZhak10UTN3NURMaWVPbjJJN1c4aVQ5azkr?=
 =?utf-8?B?aURESzB3NmN0VHV2OVhJUWlBQU9FZFNLVk90TFE4VHFyNGJvRTM1Tkw0bTZD?=
 =?utf-8?B?a1E1dlhrUkR1UkZidHpEQ1BvaWJJb3FCbHJvUjM2czlneHkyTFVNVGNiWHRW?=
 =?utf-8?B?VEJkd0R5NGFyWXpaLzluVm9uVldwTzc5QkI4aUlhcllnSDlld3RDNkdrUGxG?=
 =?utf-8?B?elNzR1V0ZjljN1liZVd6SlRKRTRSUEFyc2FyVjNXNXBTRDJIUU1raXMxbmtU?=
 =?utf-8?B?OS93UlR2K0FtUEcwZnRxbWd1N2d5MXo5cGh4Q2NicHU0OTlZNjRNYmpPZ3dE?=
 =?utf-8?B?eXk4bFN6QkdJTW5sN1JrU2FuVGM0bWR0ZUVTTWp6UDdFZjdSM1ZXY1AzME1S?=
 =?utf-8?B?YWFQWUlZOURFWm5ZZHAvNC8ySlJZV2Z2QUwxWkg2Tk1DSjdYWWowMlNRWUho?=
 =?utf-8?B?bFJZYmNJL3FzNlVJREFCWFhLaWo3K0UzVGdoN1lNbjZMbjlVSlphLzh3TFNE?=
 =?utf-8?B?MWk4SXN6Y3hCc0FaZWUrenZpUG5PYlFTUXJNK1lIbTMwbU9SdWduSTJSOU1W?=
 =?utf-8?B?MkkxVHgxa1BLKzBzMUpYRWN0SEpwQjR2LzgvRFBJM05IeWJwaFRQaVdoYWhP?=
 =?utf-8?B?WFlWNlRMRE5ZanBUT0FpZXpJVXVLV05HYVkvc09TYTh2aXhaYytFMGg1Q2RB?=
 =?utf-8?B?dEViLy82Z3oxTFBpZk1ienNmUlFzL29jRUhaaHkrVks0cGVxMUw4WWxPRjhj?=
 =?utf-8?B?K2dCRnJIenZ4WVl6MlBtTmpMSGUvSmx3Qy9VdENMSHhaaXlCcXpaVDlTbTdC?=
 =?utf-8?B?SThvT3FUZEVuc2pLSUFCVjRmTmNFLzNLd243Y084L0VranNkUlRCeU9ueWF4?=
 =?utf-8?B?MkN4ZmZHdVUrRWZHUGVkTHdxQjFXYXV2REtSa2RwMEphUWVFUzlheVcraGEv?=
 =?utf-8?B?R0FqV3hDcGJqQzNFS2JNbmkzcWJnSk54eW9TakdRTy9hek9kSjcwVDliSllw?=
 =?utf-8?B?dUZ0cGRkZisvL1N4SW1IaWxRS3lCN0pUZVRsd0JWdWpUU2g2amtvUExVRUFz?=
 =?utf-8?B?TEkwYW1HSEs1MzE2cWVkWmF6eDUrQVo3WHpUTzZRZkFRY21KV0hlYklkNVhL?=
 =?utf-8?B?dlRtU0g0WUI2Z0I5U3o3ZFVGcnhZS1c3ZEorYXFtb0VGa0xYRGtPZVV2dEMy?=
 =?utf-8?B?d1h4TnBmVVNJOXgwSHRicmU4SjIzUS9IMjFGb0QxcjNmVENBLzc5RWlTQ1VF?=
 =?utf-8?B?RU9xc2hnTU1KV1Y1SFpMa01DSkZORGlhVUQ1enZvbUtqRTZreko1RHcxMWFP?=
 =?utf-8?B?WlBxSUJ2WFBzLzN1TDFJbVFORlZPWlNhM0ZkMVVYYnlOM2ZFMWZqMG9DWlFN?=
 =?utf-8?B?OWg5V3lhZWQrMG5UOWhFcUJiYk5FSytNMFZoczVQNFdLVzRRdGtGYUc5ODFC?=
 =?utf-8?B?MnBhMFdVdGFhYm1IL0s1N1p4OVpNNXFML01wWXF0NTJjTDdDSkVwRnZGdkRr?=
 =?utf-8?B?V1lTc1pWazJSemxRb2YvUXFQZTRtQmo3V05WdDlFcTdmb3FKOWRYMXJydWJB?=
 =?utf-8?B?T3ExSXFPQzAwOFNFRmNIcGRUNElLWmtLdGVocFVsZk5sbFdtTlFjUzFhVUNy?=
 =?utf-8?B?VUJVREpPQUJaS1NtQWNSS0YyWDU5cVBBeC9BbklpWEE1WVB1ZjVZVXJEd2N4?=
 =?utf-8?Q?LuREDb2q04pG3joI5s2JnZnoggRlOt25?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB9491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVduZ1I3Y3VxRFlFQmRMUkRXam4wS2pkd0ZyQ29IMC9SZ1RqSlZYdUd3QXg4?=
 =?utf-8?B?enY4bjQ5aTF3eW56eG9VdEpzcTJKUVZRU29IeXVwb3NCcGkyL1BvSGZEeUF2?=
 =?utf-8?B?eXR0ZWdvUVdsbTNwcXNXMU9jTExKWHJoQ2E0cXFoQWEwbG1YZUwxcWMzalU2?=
 =?utf-8?B?b1d0ZGROdEhmWEZSOG54NklLWjhmNG1SR3B1ay9DSDBRODAwMmtDeHlxcnBm?=
 =?utf-8?B?bEVRSC80VlRhVmhQaVFFd2djMWNkbDZ6RWhjMDUzWHk0SjRmNmVIcHhwZklY?=
 =?utf-8?B?WWRZOTI2MUdsWmJrTGh0L2dQWm94Mjd0MHRWRnFQTGduQ21xNmtXR05ncU1p?=
 =?utf-8?B?aWtMSjhBMGlXc1BOUVJFNGY2SVUxdTRtNCtFeFFDZHFNQkM4RHYzRWREbDVO?=
 =?utf-8?B?cjI2cW11aE9LQjc0Z3pubUdoUnpac04yV0oxbnYxeWw4MFlCVVpqNTBLckJv?=
 =?utf-8?B?VW91MHZ6emNYYmZtVjdydXZGTk5oSVY2WmpmVGxkVkdLRGY5bnhCSXMzMlow?=
 =?utf-8?B?TmxsekZhQVZqSTg1VTN5cVNyeXppK0lhZG1yaDlXMjhjUi9zcWlUMWxRTSt3?=
 =?utf-8?B?clZEWjk5bzVoTUJad2JHNVd3b2JPTUpYdDBUQ3JCYVN2bWlJdXJKZ2RBZ1NQ?=
 =?utf-8?B?M1RIeTlLblFlSkcwSzR2M3pBUnROaGpNRUlzSzQ1Q3hHL0xCNGV1ZkQwbVlG?=
 =?utf-8?B?cGVkbWlSWXp2ZG9aTnRRY3dzTzIyRHlpR0xjRkxDdWxPaFJqeDRBd0Fhb1dH?=
 =?utf-8?B?QkppUHFBMkk0ajNSbVB3Nkd0Y3d4MXZER2RQbU1TZDhETC9NdlpDRTUrczlX?=
 =?utf-8?B?dkdFY0U0WGRMbmRJc3k2STdSVDk5TmF4ZDc2dmN5TmpYUm8xRytiVlF1VENx?=
 =?utf-8?B?QytINVh2U1N0VTkveEEwSnR4SWVyYTR3YUJGaWJtL1FJMmplVVFpWWZPYlBo?=
 =?utf-8?B?b3p4aGtzc3ExOEZSUUxCQnpsN1FpRTZRR3FmQ3lObWRwUk4zcHBvMzU0UXk0?=
 =?utf-8?B?b2hUa1ZTNFRrS24wYkhFK1hncTVjWUYydGh6bUJ2Tm9LUmlUZEd3U2pDdEgr?=
 =?utf-8?B?a0lDRXdQN3ZZelU3dkFHMjVna0FORHZZTVdReWxKNE1YemxGbkxxY04vZWky?=
 =?utf-8?B?S1ZuZi8rdVE2Nll5VXNhSDZPOGtFRS9kcTMzeGl5WGRmd0wyZ0t1Yi9oSSs4?=
 =?utf-8?B?VVdPOUo0VHcvQ05nbmxsbVRQZWc3TG9sZStLQ3RUMTVwc2ppSzkxeVAyaElR?=
 =?utf-8?B?d0N3aGVKVTc1ZzFXVHJwZFBPYm45MDh5UGFiNzFTbUJ0dnBrQk9vQVFRcUZZ?=
 =?utf-8?B?V2hzdUZpUC9TbnVZR1BpL2FLUHZmbEJlQWs0aDVydWx0QUxmRTNnZnNLTHB6?=
 =?utf-8?B?ZUNLVmgrQVpUdzduSFk1d1g3K0hNM0hvS1R1OUxRWjNGVzBGQ2dWOEE5MEk4?=
 =?utf-8?B?RXdRSkhxM1V4TzNFNStpMjFVU2VIMVBkYi9kSDYrL1NUa2Z6Nk41UVl1OWRh?=
 =?utf-8?B?aDlDbHhNVU1ZVWlyWXFJOEVzdWhLRWt6VERsMm1oa0JYckx4b0dmNnlkU0VH?=
 =?utf-8?B?MVNwR2ZtTThtYUJKTkdYNUV4bXVqdDk1WDFGelN1K3hoREd3RW1USG83Vytw?=
 =?utf-8?B?RDJ4S3hDTDBjRnAxWGVucWtZNDdwaUQyRjZtTFhhWnRUWEVIRlFsUk9zN1l4?=
 =?utf-8?B?RVJvcUJOd096dU11R29kak02OS9CTFFCRWpjZFFrVVRiTU11bFI1UDF1QllG?=
 =?utf-8?B?SVRxc3dEWmhwenBQZGd4MUxONnJiSytjbjBDNHdJNnRXT2p2aXVpRzZtVmY2?=
 =?utf-8?B?Ny8zRGJZRUNlcVJPTmxLUXBqSk9lTnNpWVc1NTFQNm1mb0xJWEZwRVBydUJR?=
 =?utf-8?B?VWU1bWZiOGpUWGtrNS9Lemc4TldOdmpWMTFqYm9BQmhpZzFvOGo5dXhFVWRW?=
 =?utf-8?B?bFZBUGpBVlkzZ1R2TURkTEVnYnNDZ3huczFmclRWbnRRUEtQbFZRLzRaWUM5?=
 =?utf-8?B?a0dCUFpwenJNYVNtNW1nalgzV3NHaWliMFdoTzZNaE4xbVVZODlaT3lWUVdI?=
 =?utf-8?B?MWw4NFpwY096aU9LYXBYdWdkUWpsZEdjRDZ2YlBLdjYxbWl0ZEtFdlJpbWYv?=
 =?utf-8?Q?l2+RHl8syorAFnJO2wSJJxV3v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2751a2-5121-411b-0411-08dd4603330a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 16:36:11.1052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jw8oRur54rqBT+JQ56RqyIbjMn1mNH5Uo+ZgjpgCyDhTyFQHsmArCgZAznApByxFL/bBThMpD/+Tvz14EiB8gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBIZW1taW5n
ZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIDI5IEph
bnVhcnkgMjAyNSAxODoyNQ0KPiBUbzogU2hhbmkgUGVyZXR6IDxzaHBlcmV0ekBudmlkaWEuY29t
Pg0KPiBDYzogZGV2QGRwZGsub3JnOyBOQlUtQ29udGFjdC1UaG9tYXMgTW9uamFsb24gKEVYVEVS
TkFMKQ0KPiA8dGhvbWFzQG1vbmphbG9uLm5ldD47IFR5bGVyIFJldHpsYWZmIDxyb3JldHpsYUBs
aW51eC5taWNyb3NvZnQuY29tPjsgUGFyYXYNCj4gUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPjsg
WHVlbWluZyBMaSA8eHVlbWluZ2xAbnZpZGlhLmNvbT47IE5pcHVuIEd1cHRhDQo+IDxuaXB1bi5n
dXB0YUBhbWQuY29tPjsgTmlraGlsIEFnYXJ3YWwgPG5pa2hpbC5hZ2Fyd2FsQGFtZC5jb20+OyBI
ZW1hbnQNCj4gQWdyYXdhbCA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT47IFNhY2hpbiBTYXhlbmEN
Cj4gPHNhY2hpbi5zYXhlbmFAbnhwLmNvbT47IFJvc2VuIFh1IDxyb3Nlbi54dUBpbnRlbC5jb20+
OyBDaGVuYm8gWGlhDQo+IDxjaGVuYm94QG52aWRpYS5jb20+OyBUb21hc3ogRHVzenluc2tpIDx0
ZHVzenluc2tpQG1hcnZlbGwuY29tPjsNCj4gQ2hlbmd3ZW4gRmVuZyA8ZmVuZ2NoZW5nd2VuQGh1
YXdlaS5jb20+OyBOQlUtQ29udGFjdC1sb25nbGkNCj4gKEVYVEVSTkFMKSA8bG9uZ2xpQG1pY3Jv
c29mdC5jb20+OyBXZWkgSHUgPHdlaEBtaWNyb3NvZnQuY29tPjsgQnJ1Y2UNCj4gUmljaGFyZHNv
biA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+OyBLZXZpbiBMYWF0eg0KPiA8a2V2aW4ubGFh
dHpAaW50ZWwuY29tPjsgSmFuIEJsdW5jayA8amJsdW5ja0BpbmZyYWRlYWQub3JnPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0XSBidXM6IGZpeCBpbmNvbnNpc3RlbnQgcmVwcmVzZW50YXRpb24g
b2YgUENJIG51bWJlcnMNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5n
IGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gV2VkLCAyOSBKYW4gMjAyNSAxMDo1
NDoxNiArMDIwMA0KPiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5jb20+IHdyb3RlOg0K
PiANCj4gPiArY3JlYXRlX3BjaV9kZXYoY29uc3QgY2hhciAqbmFtZSkNCj4gPiArew0KPiA+ICsg
ICAgIGludCBwb3J0X2lkOw0KPiA+ICsgICAgIHVpbnQ4X3Qgc2xhdmVfbWFjMVtdID0gezB4MDAs
IDB4RkYsIDB4MDAsIDB4RkYsIDB4MDAsIDB4MDAgfTsNCj4gPiArICAgICBzdHJ1Y3QgcnRlX2V0
aGVyX2FkZHIgKm1hY19hZGRyID0gKHN0cnVjdCBydGVfZXRoZXJfYWRkcg0KPiA+ICsqKXNsYXZl
X21hYzE7DQo+IA0KPiBVc2UgZGlmZmVyZW50IGluaXRpYWxpemVyIGFuZCB5b3UgY2FuIGF2b2lk
IHRoZSBuZWVkIGZvciBjYXN0IGhlcmUuDQo+IA0KPiANCj4gPg0KPiA+ICsvKioNCj4gPiArICog
R2VuZXJhbCBkZXZpY2UgbmFtZSBjb21wYXJpc29uLiBXaWxsIGNvbXBhcmUgYnkgdXNpbmcgdGhl
IHNwZWNpZmljDQo+ID4gK2J1cw0KPiA+ICsgKiBjb21wYXJlIGZ1bmN0aW9uIG9yIGJ5IGNvbXBh
cmluZyB0aGUgbmFtZXMgZGlyZWN0bHkuDQo+ID4gKyAqDQo+ID4gKyAqIEBwYXJhbSBkZXYNCj4g
PiArICogICBEZXZpY2UgaGFuZGxlLg0KPiA+ICsgKiBAcGFyYW0gbmFtZQ0KPiA+ICsgKiAgIE5h
bWUgdG8gY29tcGFyZSBhZ2FpbnN0Lg0KPiA+ICsgKiBAcmV0dXJuDQo+ID4gKyAqICAgMCBpZiB0
aGUgZGV2aWNlIG1hdGNoZXMgdGhlIG5hbWUuIE5vbnplcm8gb3RoZXJ3aXNlLg0KPiA+ICsgKi8N
Cj4gPiArX19ydGVfaW50ZXJuYWwNCj4gPiAraW50IHJ0ZV9jbXBfZGV2X25hbWUoY29uc3Qgc3Ry
dWN0IHJ0ZV9kZXZpY2UgKmRldiwgY29uc3Qgdm9pZCAqbmFtZSk7DQo+IA0KPiBJdCB3b3VsZCBt
YWtlIG1vcmUgc2Vuc2UgdG8gbWUgaWYgbmFtZSB3YXMgYSBjaGFyYWN0ZXIgbm90IHZvaWQgcG9p
bnRlci4NCj4gDQo+IFRoZSBkZXNpZ24gbWlnaHQgYmUgY2xlYXJlciBpZiBidXMgYWRkcmVzcyB3
YXMgbW9yZSBvZiBhbiB0eXBlZGVmIHdpdGggYQ0KPiBwb2ludGVyIGFuZCBzaXplIHRvZ2V0aGVy
LiBUcmVhdCBpdCBtb3JlIGxpa2UgYW4gb2JqZWN0Lg0KDQoNCk9rYXkgc28ganVzdCB0byB1bmRl
cnN0YW5kLA0KdGhpcyBpcyB0aGUgc3RydWN0IEkgYW0gYWRkaW5nOg0KDQoJc3RydWN0IHJ0ZV9i
dXNfYWRkcmVzcyB7DQoJICAgICAgIGNvbnN0IHZvaWQgKmFkZHI7DQoJICAgICAgIHNpemVfdCBz
aXplOw0KCX07DQoNClRoaXMgaXMgaG93IEkgcGFzcyBpdCB0byBmaW5kX2RldmljZToNCgkNCglz
dHJ1Y3QgcnRlX2J1c19hZGRyZXNzIGRldl9hZGRyID0gew0KCSAgICAgICAgICAuYWRkciA9IGRh
LT5uYW1lLA0KCSAgICAgICAgICAuc2l6ZSA9IFJURV9ERVZfTkFNRV9NQVhfTEVODQoJfTsNCglk
ZXYgPSBkYS0+YnVzLT5maW5kX2RldmljZShOVUxMLCBydGVfY21wX2Rldl9uYW1lLCAmZGV2X2Fk
ZHIpOw0KDQpBbmQgdGhpcyBpcyBob3cgSSB1c2UgaXQgaW4gcnRlX2NtcF9kZXZfbmFtZToNCg0K
CXJ0ZV9jbXBfZGV2X25hbWUoY29uc3Qgc3RydWN0IHJ0ZV9kZXZpY2UgKmRldjEsIGNvbnN0IHZv
aWQgKmFkZHIpDQoJIHsNCgkgICAgICAgY29uc3Qgc3RydWN0IHJ0ZV9idXNfYWRkcmVzcyAqZGV2
Ml9hZGRyID0gYWRkcjsNCgnigKYNCgl9DQoNCklzIHRoYXQgd2hhdCB5b3UgbWVhbnQ/IA0KQWxz
bywgSSdtIG5vdCBzdXJlIGlmIHRoZSBzaXplIGlzIHJlYWxseSBuZWVkZWQsIGJlY2F1c2Ugd2Ug
Y2hlY2sgdGhlIHNpemUgb2YgdGhlIHBhcnNlZCBuYW1lLCB3aGljaCBtYXkgYmUgZGlmZmVyZW50
IHRoYW4gdGhlIHNpemUgb2YgdGhlIG9yaWdpbmFsIG5hbWUNCg0K
