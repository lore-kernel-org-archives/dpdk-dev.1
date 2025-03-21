Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEFDC35FFF
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 09:48:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0567640A7A;
	Fri, 21 Mar 2025 10:48:48 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11013009.outbound.protection.outlook.com [52.101.67.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0F90B40A7A
 for <dev@dpdk.org>; Fri, 21 Mar 2025 10:48:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNUIzyN5m+fbgo6ZpYTu177AUXIVlIguO8wEaGWnHO3eTbVQ7UQfAFRgbeVZAhIrz/cKWUmJ7DF/pAxhwyCpXO94+WSbyE3JEd99kO6dkSorQfoKcWDTVPvGKvh3LKf3BryWEXSA6OJj/ROTWndYuipZ8YRpHI4xk7b54s0gzonz/3ydChtTvfagRxmAyqrH+udbqYLroGBzYuQHgk/mLudZfd4Ys0hjNZr/Z/Izo7bD8JbuGMvY8vNkNi7jzLBVq9vn3w4CZOXTtTLep9SfRwZQyPs62Tmvk72GCkht2U0prN20k34CzE2My9g1kO8ODE6IiFosU9IZzXltsMOQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wgg6LClTds0AWOl0+Z0bOui/NbWXjx7K4mDXQbhCaDA=;
 b=PfITkSSFBzsseXcd/xO/rC0OZ9lXjomIFCiXmUjGpZHHetJF4/+7i+4uiYQQWc4X+mlgJTJ0IWEo6km4GKyCqVg+pB+M1jYVlyEFruxKOhKcg/43+vhPZaw3AqxrXqrn1+AaShBsXuetxFAkNeJQ8G6LVqUKCgOFFZd8ovo3cpDj2cV2VpvmRr6UqvpweFkLnA45rmUmULeG9fLwaEBwH3WlEztBqi6ewpWC9hdDhMVkARl3sW74PZFtEQG6nXq7Pfr/eLSN5g7KpRCcpW9aA1Oj68PFMkwbNrJ4JC83ffRvAhV58E7o6B8ySNpfO9+83Rg5MOfpil8MWLN/9/Z6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wgg6LClTds0AWOl0+Z0bOui/NbWXjx7K4mDXQbhCaDA=;
 b=FuyCHhbPRHtISdX11XYkJfQB16is6NSr1Nglteqhk8YZvRrDeK9gPkfoBdfK+19E9ocgT+XQoXJob1gY1+CfjRdtRAMEpZqGga1lTQnArppON/jqjWqsP53CY/ILwjjxxa/8VnNnG94n6HXdN42163fAKQICuzO+zEOkXzYCmELh2fcraNnecfQi+DK23f5OELxcBA8JnciNpwk4oPRMKDsbeRS9+4TcYUKpIQVhDCAU9ohxVF43aXjLqJeMF/ffohq/YDTGL0BbFeMVDckV0NoqNTihvA6tPm5CvoJ5R6KXGo4nE0uTeSk5S1Oq9ZaJLiQBudyrNo62c249w37Z9g==
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by AM7PR07MB6978.eurprd07.prod.outlook.com (2603:10a6:20b:1bf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 09:48:45 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 09:48:44 +0000
From: "Ming 1. Yang (NSB)" <ming.1.yang@nokia-sbell.com>
To: Bing Zhao <bingz@nvidia.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [External] Re: [PATCH 2/2] net/mlx5: improve log file path
Thread-Topic: [External] Re: [PATCH 2/2] net/mlx5: improve log file path
Thread-Index: AQHbTUDoXuwex0wocE+NAgehMiIQ47NjAUYAgAn+WgCAAlP2AIAIvtqAgAZl14A=
Date: Fri, 21 Mar 2025 09:48:44 +0000
Message-ID: <VI1PR07MB9898FC46B0DDC0CA2C16325AA3DB2@VI1PR07MB9898.eurprd07.prod.outlook.com>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20241213092444.2987-2-ming.1.yang@nokia-sbell.com>
 <SN7PR12MB69096FB0FD4930E9CE8A8F80D0C82@SN7PR12MB6909.namprd12.prod.outlook.com>
 <20250310075948.56109517@hermes.local>
 <b415f31f-2816-4689-9294-fd385880ba9c@nokia-sbell.com>
 <SN7PR12MB6909C36BA0735332C81624EAD0DF2@SN7PR12MB6909.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB6909C36BA0735332C81624EAD0DF2@SN7PR12MB6909.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: VI1PR07MB9898.eurprd07.prod.outlook.com
 (15.20.8534.033)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR07MB9898:EE_|AM7PR07MB6978:EE_
x-ms-office365-filtering-correlation-id: fa4d8a84-1e2a-465c-ab15-08dd685d9220
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?K1cwZ3llaDVGeHZpejBENmpWenhYZHYvUjJJNUN3SjR3a0JiU0hid2hHbVZY?=
 =?utf-8?B?Sk56YzFTVXVyNXpjYnFkY056U2pXTTVKVG5NQ1VIQzdUSS9xVTN5cjhIZVZu?=
 =?utf-8?B?aEhrWXRNT0NFb3BOVE5NenFxcVdnaHF5WjZUcVVJbzh1TXl6ZGJHaDcwbFc0?=
 =?utf-8?B?WWk5UjU0TlhwWEtaYWw3MFp5UmlIdnhnSDh5emQ1ZnhhaHd4dnVIWDM0bjNL?=
 =?utf-8?B?YllrSFFpdXlVWHJ6U3ZYdzZpZzRhazNmU0UxZk04UTdnYU5zRkNFcDRwS0x3?=
 =?utf-8?B?MTNDdnpjZkhxaHJRTnltUml3bjRXYWt2d0VHeUVucU9rMzQ3YWlleTlVWXp5?=
 =?utf-8?B?Rm1BY1E2YjcyUHAxWjIvV0lncjI2MEhXeFBFTXQ0SGVQOXRpMVlzdzU1ZnR3?=
 =?utf-8?B?Q2ZPaUNHZTJCZTExSjBBR05MLy81VlBsa2hyYUFFN0ZPQ21WSHdXSWtWN1p4?=
 =?utf-8?B?aFc2a09mYzl2U0tIQVlxek8xTzBrTTYvRTNsSGdZZE41SnNNZlF6YzhEd3Zv?=
 =?utf-8?B?SXBKQnBxdWJYSFlmc3lIRHJTZ1RhVEsvWmVxNjdaY3lXclRqT2NHSHhYMWxX?=
 =?utf-8?B?eWtCbll0US9JV0d0YVFKSXUxbmNFeldobmw5T3B6OUtSRnJxcjExRWpYMGF0?=
 =?utf-8?B?VDE3TFZSejd0djJYOHZmWitGRGFHcXRqL1pKSzhXMVhzUjBBanU4bWIwNnM4?=
 =?utf-8?B?My84SXlzWVNjK2J1VTRFbytPMHJFQngybzVjblZ4bzQ4SkVPSFZwSXBGWm5i?=
 =?utf-8?B?ckRlcUVjeGpNQzU3eCtTZTVyK25zdHVtNDMxNkIydXlBR2QvUHFSNm5XQ1Vu?=
 =?utf-8?B?R1F3TGpVSjQwKzcvN09ZaHFURzROcm9NRVlIZG90aC9BZTBBSTd2aWlyZks2?=
 =?utf-8?B?ejZKOXNBM01Obi8wU1BENUNCdEtDU0YzcTZUTjZoZnl0Y1lJRXZ1ZC8xR2U3?=
 =?utf-8?B?KzFwc3BBQU1MV2F1Z3ZVL0xvcEUyWmM2MlBCN0ZMbC9oR2FMeUxMVEVTMzNZ?=
 =?utf-8?B?WHFXOU9TUEhCRmdZSjFuQ1JxZXZhci85cHFCUVo5MFA5QkhubnF3Y3ZERHhi?=
 =?utf-8?B?U2hJazNZTi9YNjFDbi9rbVRBRlFnanQ3cVBORzErRXZ6Q1VRMjBkdjZJL0NC?=
 =?utf-8?B?Vjg5aGlXOU1nLzNCUjVkeUpVSEE2N0RMZ1IxRXVyRDhsSEZUcTVkMHduc1Jl?=
 =?utf-8?B?NDRuanBFcG1ESzBUZFJ1UTdnV1BiVEtCS2xBZnQyZmdaZnVtRTdjNExwbDZw?=
 =?utf-8?B?dGVnYmlqVkJBcG5ESGExMk1DT3U5UFR4WDdFOFRCcXhiZ1V0bDNuRkMwREIv?=
 =?utf-8?B?dXoyb0szdys1SEtYYzlwVG01aGo1eU1Ud0FCZzdqVTlYbmZEb3pKbitLT016?=
 =?utf-8?B?UnQ4NURDYkk0Qlp6SGI1ZVYxZnU0cDBLRFdFMVh3RUVRYjJmRG53TW5GbXhM?=
 =?utf-8?B?NTlCemF5d3hEQnJvTVNWTjcxVjF5alJzaDQ2OWdMbkNIQXVsSWp2N25xMk8w?=
 =?utf-8?B?Z0xXcTZ0VTlLTlJWa0ZuU1MrS0h3L3JZT0tKL1k2eXY1K2tEcndCbW9LdWFi?=
 =?utf-8?B?alluTjk3UHR5czJQa0NTOUlrdjJjMzFOVUdVdndqdG51d1RLZUNHQkVNQUE0?=
 =?utf-8?B?bXE4ek5XOWhNSlY3eWNNdWc5L1BZY1FtQkZNOW1DL2c4STJGQ2ZiQlNuWWhx?=
 =?utf-8?B?NUNtTlkvR2lRUVhFQTJUVGRTQ3dHS3lkQ0RQZkozMDJkTG5EK3ZqRElZR3Bw?=
 =?utf-8?B?amdNM0lYYm1GendhLzJvMDl3aHhEWWowanlFM3lvLzgvbWlZSzZUeWhKSTVY?=
 =?utf-8?B?S2lIRmpsNnpKaXpVWHJucWJBRDd3OGlpVGkzeW1RVC9aMmVGNktCMjRLM1k5?=
 =?utf-8?B?UWx3OENtTHNMU3hldnM1RHJzL0w3eHVVMm05L0V4bU9Bek9ualhjL1BmdkZl?=
 =?utf-8?B?RjVjK3VtaHZXamJ0c0d2dnM1UnhHaTQ1WnpoNVJBZS8vR05Qd0FMY1ZnYlRB?=
 =?utf-8?Q?NMOA9KHm8cc5uwPu/1L+F0anpzOE+0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFZMOVdFR014aWtURFBLTkVpNDg2eUNlbTE4aXRJM0h6TTRCVWpMRFFWMHlG?=
 =?utf-8?B?b1NnNzRCWG9acXgwSlJodXEwTzRNSzNoZmRlLzlVZHRPcWFGVzZVQ1FiT1Rt?=
 =?utf-8?B?M25tbG94YlBYQzZxS21pdkZzRlFOcUg2NHJ1WEVLSnJyUGVtcXRCSElMSFV0?=
 =?utf-8?B?UG1CK05VWldwZitMNU1BQ28yWXowTHdIall6Zjh0cWtrTS8yQjkrMzBjN0th?=
 =?utf-8?B?citGaXlUdzVsWmNvVU5obFdtbTRCaUtDUHE4WW9iOENZaExTSVpMcUtnVUZR?=
 =?utf-8?B?aHZIbjhkOXg4dmpMMzZGbmpuTjBxN3czb3Z5anFhZFVFNmk2WHFieDVKWkxy?=
 =?utf-8?B?SEFoQjd1WU9qbUsyemNwTUpIUkdxMDBPOXJ0bDh2Rlh5RS9NN1pqUldiT2d4?=
 =?utf-8?B?K0l0RG04MnRBMmJET2c4YXhXRlcrK0h3YWQ1cmswTFBxUDFKYldFaGlub2NX?=
 =?utf-8?B?V2kybmZ1M1gwdmgxS3A0M1Q4alRQa2oxcVRKcXA4REFHaTZYajA4YXRmMWJ5?=
 =?utf-8?B?c0xlbzF6S2VPclV3Um8vczdUbVdEME9mdEppc05JQnppendpSXZreXJrcE5m?=
 =?utf-8?B?SndMM1NCR2toVGVFbXIzTFZDbXRlN0hheFJGZ0txNGRaZCtJMGZ1RURrcENz?=
 =?utf-8?B?UUpsNVlnN0c2V2NZY3VjMUJuUFVQeWpLemJrNkZBSFR2dE9ERk5SSGlQek1Q?=
 =?utf-8?B?REhBOWpxWUIrTTNwRzdjTVZUTVpDKzdIWlZuVVZMd3o0WVM3Yk5abENpTHNv?=
 =?utf-8?B?NTRvdG5kL1pIN3dtQ2JvVlN6bC9Mbm5lVFJKMWlQUjRKYUtFK1Q5bjR5dzhI?=
 =?utf-8?B?TVhLYStndU9GUVV0NzFacGxxQ2F1UStKZFlDUlE5UmcySXFPdjR2SVpTbW5I?=
 =?utf-8?B?OFFId0tTUVBzeCtpVW5UWUVuMGV3VndRRVMydnUvaHJMWnJwMm5xYkloNjJM?=
 =?utf-8?B?VnZ6aUhxRXlOUDRpbTZRSTRsekQ3bVhHc0JYU2xNV2FxL3lESnFsKzlKR3dh?=
 =?utf-8?B?MmZMZTBhRzJ1SUl4b3BxSEtYRzR2dUR0UkxUNjdGbEdFVW9aRTRuS1Exam92?=
 =?utf-8?B?TFNwZkpzZ0E4NTMxTW4rTDdYVVBxdnFOZXpFK3p6SmdNZzFackdJZThZOHNm?=
 =?utf-8?B?NnY2REw0Z3R2NHFENzBGVWM0N3Z4Q2FMU25xajlPSStZUUQyRGhGdUxrUXhM?=
 =?utf-8?B?N3I3MWg0YVFqRy9mck9tRkp6VmlCUVcrbWs4L083TWhPcHVtTW41aFNxTVQ3?=
 =?utf-8?B?NFdRSzJpdkJrbE0zMmxib0QvOXRnS2gvTmN1WjZMbTVQN0JDMVJOdWMzZ3pI?=
 =?utf-8?B?VXFmUnNNcG1PdmFNRS9jaWJEazgrYjZ2T05IMnM4bGRadThlYUVIcVAyYVox?=
 =?utf-8?B?Sm9lREVBQkFkNGxVWlRHd3Z0b2FNRmt0VTkrSFJxaUVIMTRrdHBvMnlyalA4?=
 =?utf-8?B?aGZaNWl1aWl2WFYwS1MzS0JXSDBPeHdBbVl4MW1vK1RuUTRmaUVsUUdTOS9B?=
 =?utf-8?B?SmludlE2QUQyb2FNcXk4Uy8vWHhsKzlQT2RkN2xxZXZBZjVyK25hNkdIRmFu?=
 =?utf-8?B?Mjc2YVVUcWh5MDFuQmgyWFBLd2xGS1BTb3hVbGlTa1V6eXdHd3o3VVpZYlJT?=
 =?utf-8?B?NVlCR01JOFZGQ2FtYUFBYXhEVm1rdUhLVHRCd2VuYUVmM3BSUGdNK0VTeWVi?=
 =?utf-8?B?YWt6MW5qYmpJVWtqZ1o4RUZJT1ZQS0xMc0FhbFlRdExuRStJVmQ5SUxnN2pq?=
 =?utf-8?B?VnJqVm84bnJRQWV6dGZIUE1qSmtJcVNBWW5MdGZsY1dxcGZrOWZSdDZ0bVNQ?=
 =?utf-8?B?TmozYk1xVXBWRkxEaWN0R3NoTUtRM2swbVRCLzlJcnpHQzIxUWIvMWRaNmhq?=
 =?utf-8?B?cHRKLzJnNExRZFZzdHJxMG1EdVpuaFRWcGo0TnV2SzhCNFB4TFAxVEo0UGNl?=
 =?utf-8?B?VUlqUkFjV2plWitvbUl5UHNTSlRERkJ3N0hQcW0zNkNxb2Q3Mko4eDdvVXRX?=
 =?utf-8?B?bUVkVFpIQnhsd3M2dlIxZ2dNVTlORW1jVnJSaGNmTHRmNHNmb0l2TUhhZ1pu?=
 =?utf-8?B?V2UzVENRaC9LclZjVEM1Y1VqSmY2VHF4eGxHSElBdTlidnkwQmNhb3VTM05N?=
 =?utf-8?B?UmEvMGNkc2I0RzdFaWQ3SUFmWVJwODlvT0laNFJ4cTgvQ1FvU3JoZ1RxN05J?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BACEE23F8254F46AB8302DABFB5ACA8@nokia.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4d8a84-1e2a-465c-ab15-08dd685d9220
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 09:48:44.9236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4+eXcQFMb3AdYdvwnends5BNzy6yiEzV6x3M9t8vkAZL+KleV8Ris7/aQSmwadk5ifIw2d5cYXpa/V0nLzsJ4GsP/Goj9IUS5hOFcGmwzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6978
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

DQpPbiAyMDI1LzMvMTggMDA6MDUsIEJpbmcgWmhhbyB3cm90ZToNCj4gQ2F1dGlvbjogVGhpcyBp
cyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNraW5n
IGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSBodHRwOi8vbm9rLml0L25zYiBmb3Ig
YWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4NCj4gSGkgTWluZyAmIFN0ZXBoZW4sDQo+DQo+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJvbTogWWFuZyBNaW5nIDxtaW5nLjEueWFu
Z0Bub2tpYS1zYmVsbC5jb20+DQo+PiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDEyLCAyMDI1IDEw
OjMzIEFNDQo+PiBUbzogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnPjsgQmluZyBaaGFvDQo+PiA8YmluZ3pAbnZpZGlhLmNvbT4NCj4+IENjOiBEYXJpdXN6IFNv
c25vd3NraSA8ZHNvc25vd3NraUBudmlkaWEuY29tPjsgU2xhdmEgT3ZzaWllbmtvDQo+PiA8dmlh
Y2hlc2xhdm9AbnZpZGlhLmNvbT47IE9yaSBLYW0gPG9yaWthQG52aWRpYS5jb20+OyBTdWFubWlu
ZyBNb3UNCj4+IDxzdWFubWluZ21AbnZpZGlhLmNvbT47IE1hdGFuIEF6cmFkIDxtYXRhbkBudmlk
aWEuY29tPjsgZGV2QGRwZGsub3JnDQo+PiBTdWJqZWN0OiBSZTogW0V4dGVybmFsXSBSZTogW1BB
VENIIDIvMl0gbmV0L21seDU6IGltcHJvdmUgbG9nIGZpbGUgcGF0aA0KPj4NCj4+IEV4dGVybmFs
IGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+Pg0KPj4N
Cj4+IE9uIDIwMjUvMy8xMCAyMjo1OSwgU3RlcGhlbiBIZW1taW5nZXIgd3JvdGU6DQo+Pj4gQ2F1
dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3
aGVuIGNsaWNraW5nDQo+PiBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgaHR0cDov
L25vay5pdC9uc2IgZm9yIGFkZGl0aW9uYWwNCj4+IGluZm9ybWF0aW9uLg0KPj4+IE9uIFR1ZSwg
NCBNYXIgMjAyNSAwNjoyMzowNiArMDAwMA0KPj4+IEJpbmcgWmhhbyA8YmluZ3pAbnZpZGlhLmNv
bT4gd3JvdGU6DQo+Pj4NCj4+Pj4gSGkgTWluZywNCj4+Pj4NCj4+Pj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+Pj4+PiBGcm9tOiBZYW5nIE1pbmcgPG1pbmcuMS55YW5nQG5va2lhLXNi
ZWxsLmNvbT4NCj4+Pj4+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTMsIDIwMjQgNToyNSBQTQ0K
Pj4+Pj4gVG86IERhcml1c3ogU29zbm93c2tpIDxkc29zbm93c2tpQG52aWRpYS5jb20+OyBTbGF2
YSBPdnNpaWVua28NCj4+Pj4+IDx2aWFjaGVzbGF2b0BudmlkaWEuY29tPjsgQmluZyBaaGFvIDxi
aW5nekBudmlkaWEuY29tPjsgT3JpIEthbQ0KPj4+Pj4gPG9yaWthQG52aWRpYS5jb20+OyBTdWFu
bWluZyBNb3UgPHN1YW5taW5nbUBudmlkaWEuY29tPjsgTWF0YW4gQXpyYWQNCj4+Pj4+IDxtYXRh
bkBudmlkaWEuY29tPg0KPj4+Pj4gQ2M6IGRldkBkcGRrLm9yZzsgWWFuZyBNaW5nIDxtaW5nLjEu
eWFuZ0Bub2tpYS1zYmVsbC5jb20+DQo+Pj4+PiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBuZXQvbWx4
NTogaW1wcm92ZSBsb2cgZmlsZSBwYXRoDQo+Pj4+Pg0KPj4+Pj4gRXh0ZXJuYWwgZW1haWw6IFVz
ZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4+Pj4+DQo+Pj4+Pg0KPj4+
Pj4gMS4gL3Zhci9sb2cgaXMgaGFyZCBjb2RlIHdoaWNoIGlzIG5vdCBhIGdvb2QgY29kaW5nIHN0
eWxlLg0KPj4+Pj4gMi4gL3Zhci9sb2cgbWF5IGJlIG5vdCBhbGxvd2VkIHRvIGJlIHdyaXR0ZW4g
dmlhIGNvbnRhaW5lcidzDQo+Pj4+PiByZWFkLW9ubHkgbW9kZS4NCj4+Pj4+DQo+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBZYW5nIE1pbmcgPG1pbmcuMS55YW5nQG5va2lhLXNiZWxsLmNvbT4NCj4+Pj4+
IC0tLQ0KPj4+Pj4gICAgZHJpdmVycy9uZXQvbWx4NS9tbHg1X3J4dHguYyB8IDMgKystDQo+Pj4+
PiAgICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+
Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L21seDUvbWx4NV9yeHR4LmMNCj4+Pj4+
IGIvZHJpdmVycy9uZXQvbWx4NS9tbHg1X3J4dHguYyBpbmRleCBlYWRhZGNkZmZiLi5hMGRhNzNj
OWMzIDEwMDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvbWx4NS9tbHg1X3J4dHguYw0KPj4+
Pj4gKysrIGIvZHJpdmVycy9uZXQvbWx4NS9tbHg1X3J4dHguYw0KPj4+Pj4gQEAgLTEyLDYgKzEy
LDcgQEANCj4+Pj4+ICAgICNpbmNsdWRlIDxydGVfcHJlZmV0Y2guaD4NCj4+Pj4+ICAgICNpbmNs
dWRlIDxydGVfY29tbW9uLmg+DQo+Pj4+PiAgICAjaW5jbHVkZSA8cnRlX2JyYW5jaF9wcmVkaWN0
aW9uLmg+DQo+Pj4+PiArI2luY2x1ZGUgPHJ0ZV9lYWwuaD4NCj4+Pj4+ICAgICNpbmNsdWRlIDxy
dGVfZXRoZXIuaD4NCj4+Pj4+ICAgICNpbmNsdWRlIDxydGVfY3ljbGVzLmg+DQo+Pj4+PiAgICAj
aW5jbHVkZSA8cnRlX2Zsb3cuaD4NCj4+Pj4+IEBAIC0zMTEsNyArMzEyLDcgQEAgbWx4NV9zZXRf
c3dwX3R5cGVzX3RhYmxlKHZvaWQpDQo+Pj4+PiAgICAgICAgICAgfQ0KPj4+Pj4gICAgfQ0KPj4+
Pj4NCj4+Pj4+IC0jZGVmaW5lIE1MWDVfU1lTVEVNX0xPR19ESVIgIi92YXIvbG9nIg0KPj4+Pj4g
KyNkZWZpbmUgTUxYNV9TWVNURU1fTE9HX0RJUiBydGVfZWFsX2dldF9ydW50aW1lX2RpcigpDQo+
Pj4+IEkgYWdyZWUgdGhhdCB1c2luZyB0aGUgZml4ZWQgUEFUSCBpcyBub3QgYSBnb29kIHByYWN0
aWNlLiBDYW4geW91DQo+PiBlbnN1cmUgdGhhdCB0aGUgcnVudGltZSBESVIgaXMgd2l0aCBSVysg
cGVybWlzc2lvbnM/DQo+Pj4gRHJpdmVycyBkb2luZyBhbnkga2luZCBvZiBjdXN0b20gbG9nZ2lu
ZyBpcyBiYWQgcHJhY3RpY2UuDQo+Pj4gVGhpcyBzaG91bGQgYmUgaGFuZGxlZCBieSBFQUwgbG9n
Z2luZywgbm90IHByaXZhdGUgZnByaW50ZidzDQo+Pj4NCj4+Pg0KPj4+DQo+PiBIaSBTdGVwaGVu
LA0KPj4NCj4+IFllcywgSSBjb21wbGV0ZWx5IGFncmVlIHdpdGggeW91LiBUaGUgRFBESyBkcml2
ZXIgc2hvdWxkIHV0aWxpemUgRUFMDQo+PiBsb2dnaW5nIGluc3RlYWQgb2YgZnByaW50Zi4gV2Ug
aGF2ZSByZWNlbnRseSBhZGRyZXNzZWQgYW4gaXNzdWUgd2hlcmUgRFBESw0KPj4gd2FzIGFwcGxp
ZWQgaW4gYSBjb250YWluZXIgd2l0aCBhIHJlYWQtb25seSBmaWxlIHN5c3RlbSBtb2RlLiBJbiB0
aGlzDQo+PiBtb2RlLCB0aGUgL3Zhci9sb2cgZGlyZWN0b3J5IGlzIHJlYWQtb25seS4gSG93ZXZl
ciwgd2hlbiBEUERLIGlzIHJ1bm5pbmcsDQo+PiB0aGUgZGlyZWN0b3J5IHNwZWNpZmllZCBieSBy
dGVfZWFsX2dldF9ydW50aW1lX2RpcigpIG11c3QgYmUgY29uZmlndXJlZA0KPj4gd2l0aCByZWFk
LXdyaXRlIHBlcm1pc3Npb25zLiBUaGVyZWZvcmUsIHdlIGhhdmUgbWFkZSB0aGlzIG1pbm9yDQo+
PiBpbXByb3ZlbWVudC4NCj4+DQo+PiBQbGVhc2Ugbm90ZSB0aGF0IHdlIGFyZSBub3QgdGhlIGRl
dmVsb3BlcnMgb2YgdGhlIE1lbGxhbm94IENYNC9DWDUgTklDLA0KPj4gbm9yIGFyZSB3ZSBhZmZp
bGlhdGVkIHdpdGggdGhlIG1hbnVmYWN0dXJlciBvZiB0aGVzZSBOSUNzLiBBcyBzdWNoLCB3ZSBh
cmUNCj4+IHVuYWJsZSB0byBtYWtlIHRoZSBpbXByb3ZlbWVudHMgeW91IGRlc2NyaWJlZC4NCj4+
DQo+IEkgdGVuZCB0byBkaXNhZ3JlZSB3aXRoIHN1Y2ggY29tbWVudHMuIFN1Y2ggZHVtcCB3aWxs
IGJlIGdlbmVyYXRlZCB3aGVuIHNvbWUgZXJyb3IgaGFwcGVucy4gV2Ugd2FudCB0byBzYXZlIHRo
ZSBpbmZvcm1hdGlvbiBpbnRvIHNvbWUgZmlsZSBmb3Igb2ZmbGluZSBhbmFseXNpcy4gSSBjaGVj
a2VkIHRoZSBjb2RlLCBjdXJyZW50IFJURV9MT0cgcm91dGluZXMgZG8gbm90IGhhdmUgYSB2YXJp
YW50IHRoYXQgc3VwcG9ydHMgc3BlY2lmaWVkIG91dHB1dCBzdHJlYW0gYnV0IG5vdCBvbmx5IHN0
ZG91dC9zdGRlcnIvc3lzbG9nLiBPbmx5IGdsb2JhbCBQQVRIIGNhbiBiZSB1c2VkLiAoY29ycmVj
dCBtZSBpZiBJIG1pc3NlZCBzb21ldGhpbmcpIElmIHRoZXJlIGlzIGFuIEFQSSBjYW4gc3BlY2lm
eSB0aGUgb3V0cHV0IHN0cmVhbSBpbnN0ZWFkIG9mIHRoZSBnbG9iYWwgc2V0IG9uZSwgdGhhdCBz
aG91bGQgc2F0aXNmeSB0aGUgbmVlZHMuDQo+DQo+IFNhdmluZyBpdCBpbnRvIHNvbWUgZmlsZSBp
cyBhIG11c3QuIEZvciBleGFtcGxlLCBpZiB0aGUgY3VzdG9tZXIgaXMgdXNpbmcgYSBtb25pdG9y
IHdpdGggVkdBIGRpc3BsYXkgaW50ZXJmYWNlIGNvbm5lY3RlZCB0byB0aGUgc2VydmVyIGRpcmVj
dGx5IG9yIGEgQk1DIHNpbXVsYXRlZCBjb25zb2xlIHRlcm1pbmFsLCBzb21ldGltZXMgdGhlIHBy
ZXZpb3VzIHByaW50cyB3aWxsIGJlIGZsdXNoZWQgb3V0IG9mIGJ1ZmZlciBvZiB0aGUgc2NyZWVu
IGlmIHRoZXJlIGFyZSBhIGxvdCBvZiBsb2dzIHRvIGJlIHByaW50ZWQuIFRoZXJlIGlzIGV2ZW4g
bm8gc2Nyb2xsIHVwL2Rvd24gY2FuIGJlIHVzZWQgbGlrZSB2aWEgU1NIIHZ0ZXJtLg0KPg0KPiBB
ZnRlciBzb21lIGludGVybmFsIGRpc2N1c3Npb24gd2l0aCBvdXIgZXhwZXJ0cywgd2UgdGhvdWdo
dCBpdCB3b3VsZCBiZSBiZXR0ZXIgbm90IG9ubHkgdG8gY2hhbmdlIHRoZSBQQVRIIGJsaW5kbHku
DQo+IEJ1dCB3ZSBjYW4gZmlyc3RseSBjaGVjay90cnkgdG8gd3JpdGUgdG8gdGhlIGRlZmF1bHQg
Zml4ZWQgUEFUSCBhcyB0b2RheS4gSWYgZmFpbGVkIGR1ZSB0byBubyBwZXJtaXNzaW9uL25vIHNw
YWNlLCB0aGVuIHRyeWluZyB0aGUgZmFsbGJhY2sgd2F5IHRvIHVzZSB0aGUgcnVudGltZV9kaXIo
KSBpbnN0ZWFkLiBBbmQgdGhlbiBub3RpZnkgdGhlIHVzZXIgd2l0aCBhIExPRyB0aGF0IHRoZSBm
aWxlIGlzIHNhdmVkIGludG8gW1BBVEggeHh4eF0uIFdEWVQ/DQo+DQo+PiBCcnMsDQo+PiBZYW5n
IE1pbmcNCg0KSGkgRGFyaXVzeiAmIEJpbmcsDQoNClllcywgSSBhZ3JlZSB0aGF0IHRoZSBmYWxs
YmFjayBtZWNoYW5pc20gaXMgaGlnaGx5IHN1aXRhYmxlIGZvciB0aGlzIA0Kc2NlbmFyaW8uIEl0
IG5vdCBvbmx5IGFkZHJlc3NlcyB0aGUgaXNzdWUgYnV0IGFsc28gbWFpbnRhaW5zIA0KY29tcGF0
aWJpbGl0eSB3aXRoIHRoZSBvcmlnaW5hbCB1c2VyIGNhc2VzLCBtYWtpbmcgaXQgYSBiZXR0ZXIg
c29sdXRpb24uIA0KSSB3aWxsIGVuaGFuY2UgdGhpcyBwYXRjaCBzaG9ydGx5LiBZb3VyIGFzc2lz
dGFuY2UgaW4gcmV2aWV3aW5nIGl0IHdvdWxkIA0KYmUgZ3JlYXRseSBhcHByZWNpYXRlZC4NCg0K
QnJzLA0KWWFuZyBNaW5nDQoNCg0K
