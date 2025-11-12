Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D03CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70166402EE;
	Wed, 12 Nov 2025 10:37:07 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by mails.dpdk.org (Postfix) with ESMTP id 44D80402E1
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:37:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtFomX1TwzBn6Oi3cgX1ixqNSts8D2SLJC6aSsOrmF2ES6KzXoro91l1ZLuINjuemWxfKIOboStpoNTOAMju2St4xOwlYdF0mhyZmM9+Gl0my/yD1QMvHjid5CfKFdjhGyuTo0oTABoBZnnK2fzraaGwcF3ELrPJSgb50RmSfjhjwnYrUBDV2zxUwVkeLswX0lxxbLyqChHaDxTLbw4X788/UvCPPrsiiMOjCHL0dOM1GCagYiq5phur3GHDrAMqg/DA/Oc8sKXEvrEUEVehJcL4pdmD69U+AM3/3yGH+19AnZPqQFfV/Q/gYP2M0Qj5FKG7lJkpvFmx+c+no4WEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWau0w3KEZ1Wxo4RoNhftVHFWf/KEPp5OLzJEIizWCs=;
 b=QAATyKbCOUIUyOukCw1cc8YYw1hqD24yUCP+y8JxFsk5KioxLnTe+8mWS3DQ1vd7po1LQNi9IY3JcU+NM68quGzmUeCyTKsWgUN5gHIBt6F+ex/DT70UrhQghSg05Uwccmfs3K5rDGjMzb1zisKLQVS2vEOIIEH4PI8jRnvP0/VZl9qd2Z/cZp6QFpsWRCmWMWGf4au4HIIKRzJwSFRbuGrZBDGnGPOLzuKowAenE5AneRt6d0NyP8CyW0DbAoXuMMY+KMrPl/ZvPP4EZEt72cE9+bn5dHOpeFOziLQb4at5zUD6lm3k3pKkNNVLbY1t5nIRaA/hOe8MOjabYxLUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWau0w3KEZ1Wxo4RoNhftVHFWf/KEPp5OLzJEIizWCs=;
 b=HlucIjLOcTGO3hsrvWuQabHesBAU9g8qbyR7KorFy5eRI2NfdhMy1mUiuniTpCSUIWoYKJpHoUnNrFAs+1gmkBiyLwg6IvtQBwXE5t2rGs+BZ7jIGyElU2Zdpw9k0iDMNlKPW0mIU54Ubpm+oiHVjmdk/q7f2wjPImkq9gv+8YlOFWjTx2x3hPy9hfko7gAFjY9iWb510BhX6ozHXQS+QpPTnRdX6gGskSJurHWc99p4/qA36fga7WMmYJ1HsWkVaSuYzmFAlq0XLWdhuA9HrF2buSb5UifhfQMNIIyywGjpBl43AjmEslCXe3GU804NxF5sW4gicYbO8GK8cNh6dw==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 09:37:03 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7%2]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 09:37:02 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Yang Xu <xu.yang3@zte.com.cn>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava
 Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "yao.chenghu@zte.com.cn" <yao.chenghu@zte.com.cn>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/1] net/mlx5/linux: set down if detect any anomaly
Thread-Topic: [PATCH 1/1] net/mlx5/linux: set down if detect any anomaly
Thread-Index: AQHcD9hKqoirZEcigESCB4sqQfzrjbTvTttg
Date: Wed, 12 Nov 2025 09:37:02 +0000
Message-ID: <IA4PR12MB9763D815B41A246BF8648C6ED0CCA@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20250818003223.2098419-1-xu.yang3@zte.com.cn>
In-Reply-To: <20250818003223.2098419-1-xu.yang3@zte.com.cn>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|CY5PR12MB6574:EE_
x-ms-office365-filtering-correlation-id: 7dacb6ea-6548-47ba-9d65-08de21cf0907
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?VlhEOEtZNThHODIvTnY4TmtGRUJpRHBhV2d3ay9qY29NblJsaWhJL3liUDFO?=
 =?utf-8?B?TllDbnZydlZFa2VpZjlhc1psSjV1Z21LNklVOTdia0NOQ3pGTHdiTDdDVFl3?=
 =?utf-8?B?bzQ4a2hnMXBQUm9CNkw3S0lmT3Q1R0JwYklUblIrSUx5Y2RKTXdPcEppaE1j?=
 =?utf-8?B?WmU2Z3EzM0c2ZVFkZ2lLZ3JGTlNtSXdDVEp0b2RFRjJaSFFGV3pEdnpYKys2?=
 =?utf-8?B?VGMyeWl0enBycEFLYWJ4WDZ5YlZPVU14c0JZQkV1T3BNZjZRNkNaWVZnNDRG?=
 =?utf-8?B?VnpZVXR5bjBZcXFZQlNMaGFYaUViSFg4Z3BKblNMMXNuSFdNUmlHTy9ibFBo?=
 =?utf-8?B?bU5GRUtaTUxHdnhkcFBVbjhQT3A2bmJpYkticnpZSDRkZXVjVHYzcWFNRlly?=
 =?utf-8?B?R2JSZ2owTEpVQU9TcmhJOUpWUStyS3ZPTUlDYTU1RjZES1MxcFFwTnY4aDY0?=
 =?utf-8?B?Z21ndjhLYmZwaG9lSlM5ZkI5WWlqalgzL2wwNUpHcE5lUU1DQWpGeGpmRk1H?=
 =?utf-8?B?SmpGZEFjNC81RExheVB2VGx0QmZYSUdFNUtlYlV3UkgrRnBIYkI5cnNQUElX?=
 =?utf-8?B?UGRoOEhFWlMzbWo2QlhRenpiT0oyTFBySnFQWEFmeUpxcDh6dTRQVzVCbzRJ?=
 =?utf-8?B?UUQvYzhrWTVlcDRPQWRSZmZuc0tmQnkvNXlSTEthZXJwSjJnUHJYZHB2TEZn?=
 =?utf-8?B?aU5MZm1USUlzWm40NW9JMktsc1pCR0Z6REhHMUNhbDZnQVVHbU95Q3VLSnFM?=
 =?utf-8?B?bEdtbC9QRHpTMUF0QVZIazloU1dQeXhGT0RuSDBwVndPL3lTVGFza21ZU2la?=
 =?utf-8?B?YXVDSEdYcFNQR1JOZ3BvZHg0UXl3eXBYVTRiWDVjNldmcGt2WmF6NTg4dlg5?=
 =?utf-8?B?Y01YZGduL2w4Zk5Rd2MwREFGb0RyZmdjRW9UVmUzNmFRMDVZbGRqNVFwaGY4?=
 =?utf-8?B?THlCZFU3dFFKWEJ4ZEJJNTJhbGlHakZWUnhhNFVDclVzb3RaQ2RseGVKSmtv?=
 =?utf-8?B?Ylk5YUoyQmRvRlVodGx6UnhybU1kbENVUnFybDVuRGNlb3hFVFluOXJnT3dQ?=
 =?utf-8?B?Z2lmUG16ZW1QUmttTlo2R0NuektGYmN0TCtVQm43RUI4MjQzSHprMmV1ZkRN?=
 =?utf-8?B?N0F0VGpnRlVGc0p6eUdiWEorMUpML3pOZVliMzRxUXZSNHhCU0R6amduUGJv?=
 =?utf-8?B?VXROTUVOZjQ2NWNIYmkwVzNsRnNVb3lUdi9RVXhHZTZMNjBPVkh4SUFra3RT?=
 =?utf-8?B?M2xQd05XQ1BhaUM0NVM1bzYzQVlzTFdxK0ZMWXVZdnpEMjRXbGNaVGlrZnNs?=
 =?utf-8?B?TTB6Uy9jMzVqZlBxZm82VFNMU3dEVGVLc0dkRjJCdnpCejBNTzEweG1lZDU5?=
 =?utf-8?B?MTJGWDY1Tnc0eU5RN2tpKysvY3d3VnI1T1licUpiaGM4Y0oxNENCM04rSnJr?=
 =?utf-8?B?WkIzSXZMOXNBdWVONDBTQ2E4Ykp0UTF5b1IrL1d4VVZHaVFvU2hsOGZPUWkx?=
 =?utf-8?B?ZmwxcXVFTWJvd3JrcE80eXVVUnUzQWFLRFFUK24xNnBraGtJN05yUk5mUDVC?=
 =?utf-8?B?STVaVUJTYUZHa3BUSkZIYlRqRjhSUjE5Y1pWU1ZvNGV1R3JJUTIxaXVDK0xv?=
 =?utf-8?B?Q3JSVUxQVnhOZy9BOTE3eXdLeEZiaUlRNzdoT1BldjdIQVJvNG11N242TEFB?=
 =?utf-8?B?K04zbzNGaWZvS0ZaVTQvbXpweUlPanFaaW5LZGZCOGdHWXlKWE5lYnc4MDlw?=
 =?utf-8?B?UU1XR2pYeWFTUTV3Ym5ZT09OWE1Ld2luWWdMVXJHcnV3N3htTmxpK21ad3c2?=
 =?utf-8?B?cUc1NlVIQ2p5VmxYZ21QcnRyMnVLRE1hWGZNWVp2SEFEVnU5TSt1Z1lXSnFy?=
 =?utf-8?B?UjkralVOVzNmWk8rcHZTU2NvVDJZVVNLblBJKzFvSXBZbDN6V1hqZDlhV1JX?=
 =?utf-8?B?ejBrcUdBWjl0NElTWG1WdFdQaHlGYWRhMTErbCtEUWFWN0FBS2w4UTBpbDV6?=
 =?utf-8?B?NVFKZUl4WmhiNTAvYmZzUWQwSE1URmIwK1g1VDk1dEdXdGQ5YldIWDVlQnU1?=
 =?utf-8?Q?CgaXrN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlAwOEltTmVodXl2a1U0b08xOU9FYlVPVk4xRjlJRG9lRDY5T0lmVnJ3ZUZ6?=
 =?utf-8?B?NzlFM1pnc2RvMWRnUk5jZmlwVlBNdEtxbG9RQjZFMHFUeEtyazFJQUhUdHZv?=
 =?utf-8?B?d1IwMXFFUm5JeHNYdnFRWGZmampvVjFBak9lV3VnckdoNkFTVjRPWnVPeHJi?=
 =?utf-8?B?Ykt2ZGpwamFWZFhzWDJRTG1HdzF3d0djUUpKaUpPZjNyY1BQOENTbjFMVkgw?=
 =?utf-8?B?dCtUTVhvdTh6NFFQM0d3Q1QwRnpsTUdQMmlPS1RMN3pFa1RhYlRjS1pBSmtj?=
 =?utf-8?B?YlBTNUhlZmhsQUx1ZmF2QktkUURhNXRDMythYnRoZFFBamJzdytJQ1gzWlE1?=
 =?utf-8?B?Z0VjSk5Ka1NLSHA3bEJwM2kvL0svRzhZU2VEQjBGNTlhclFKRjRYei9SN3dn?=
 =?utf-8?B?RFhJUXhmWUpEZDlnc3ZuVS9Pd0s3QUw0eGEwTFpuZ0g0VXUxSWlSc1c3Nm5s?=
 =?utf-8?B?NjFaeFZ2R3VPZXNEeU5tOVNHNVRTN0hzbnZ4UGZ6cVdQa0QvOVJkcUhSTHBS?=
 =?utf-8?B?eVp0SlFGa3ZPa0E1ZGxJSkM4TDBzOTd6eUhRVkpWR21xdWN4STJRbFdhNzJo?=
 =?utf-8?B?VzBWRWJVR2VxOG9pNms5Qktza0VqWHc1U0NHbWg5ajhZSGJoQXQyR2g4N1JR?=
 =?utf-8?B?M3c4VXBYWDN4WVFOem9zTlUxRDVCUUhaOW9KMk5JQk9GYXZwdXd2MHE3cVV0?=
 =?utf-8?B?WjcvbkhYS3pYRDMxQnR2dzVTWU93dXdKb3Jyd0NGZ3lTVENqdWkwaFB0YU80?=
 =?utf-8?B?dTRDQkJWUm9qT0pRZTIySnBrbndCVFVjRXVyREd1ZHNFVWpLcG1aY1oyUXFw?=
 =?utf-8?B?eTFZT3hSblp5d1FnSUpTYUl6UnZySWxLVzA1UjU1bXhWc1VXZkN0V3d3Z2tn?=
 =?utf-8?B?UWVzbjZkc0Evc3gwRzAyZlVFdExXeDljRDNoWGNoU29uY3JEQ2czdzdJaWNj?=
 =?utf-8?B?M2RMbW5jbGt6MjQvSVIxV2pYNHpHelptTklKMjFvT0FySVRlT0dRaC9pS1JZ?=
 =?utf-8?B?UGJHRUFJTlpZRUhEMWZ6NkJ5V2Y2RUVhT1pJNlhoYnZYOVpmd2dVOGFOcXBy?=
 =?utf-8?B?bll2c2ZLcXlaUDZMZmlPd2ptWHJUOS9yS3pQQmg0RjFwMktGeG1lU25wYTc3?=
 =?utf-8?B?bGNuUFdYK05PdXdUUU1pL2gyZmgva2ZnTEc3MlBuZVhQc1cwMUJuM1hPOXNI?=
 =?utf-8?B?SmFsS1ZtMmVtZW9EK284K2t3cUtvKzhGamFOcFNMWFNScGNwUWVNMVBDTnhE?=
 =?utf-8?B?NEJ0dEhkK05MY3RkMWlQSzZWaHU2Q21mUzlrMnZYUmUrN3kzNnA3RU1qc1Vo?=
 =?utf-8?B?NXZKUWRCdkpWVmU4Y3RUSndnYkJ1b0pzaXhlTVZWUjgrZWRCUVdyQWxpOVBp?=
 =?utf-8?B?TGk5bGNKeTdySzFVMFNJV2FCb0w3cDNISGx3WXlQSjZodUkvbVcwMUVFSzh6?=
 =?utf-8?B?TGkxdHhJdWVQVDlkQTdYZDUyeWhqVW1xV2xoZ1liUlNSbDA1RllsajZJUHJX?=
 =?utf-8?B?VVg0Wkx4dnV6c1pDcVg2R0FNbXhmWkt4WEtUMDNhcDlsZWpUa3BRRU5kanlC?=
 =?utf-8?B?aGZLWHZyMjlCV0t2WG5lajZiUGNkMVQvdmpFTXZKSW5xa05FRThPRDZQRWtl?=
 =?utf-8?B?Mk9ubWRHM3JaSUY1dVI4WHFaRnVQUEYwb3cwVkNmMUlsQVpBTUhxcW8xZnEv?=
 =?utf-8?B?TUcxMHV3SXpmcWYxa2Q1ZmlOSzgwZE1LOG52L3Q4Z29LNm1meS9jVngrSExu?=
 =?utf-8?B?V1plYm5wL3llcHV2dWZxSDNpV0xKYVZublUvWUZMcDNUaENQRU44dTg1REpt?=
 =?utf-8?B?STUxSVRTWVFkN1NkT0t3dWxQVEVrQ3BTZTJnUEt3WUMwaVYvSnRVaUM5ZExq?=
 =?utf-8?B?MmlRWUUwYXBMNTFNNkpkckc4MXJubVE0cjd2SUtFZlpRcEE0dU80Q0lmUjl0?=
 =?utf-8?B?cElydHpoa21TYnUyUGhoWXBtZ3poRzhYRTZTa1RoK0ZaZHg1aFJpRXBzT25j?=
 =?utf-8?B?bGNjdEh0R3BHOE01Zk9ncXp5dktrclhyOU9IYW91TXV5UWhGTURhUDNZd1lU?=
 =?utf-8?B?K08vVkpXOVIvc3dpM2ZBK2NYckdFaTM4dzl2aXdEckV0ZjI5dVhiTWhPQWk2?=
 =?utf-8?B?d2dhWmwydTg0WVRiWnJ5NFcreEdrT09EWHN2WXlLR2Q1Q3ZEQWtkTUJsZFE5?=
 =?utf-8?Q?x/YGu83h8GjVzmB6evjsJcc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dacb6ea-6548-47ba-9d65-08de21cf0907
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 09:37:02.6417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gonlRsOnDi29wMSFYknFw4fY7ejlGbRoIcpL8IxD+DbCAvl3cLza9i0PuAl72jRob0ksb/pS951yrJL+TfGR6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
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

SGksDQoNClBsZWFzZSBjaGVjayBob3cgdG8gdXNlIHBsYWluIHRleHQgdG8gc2VuZCB0aGUgZW1h
aWw/IEFuZCB0aGlzIGlzIGEgYnVnIGZpeCwgcGxlYXNlIGFkZCBmaXhsaW5lIGFuZCBjaGFuZ2Ug
ZGVzY3JpcHRpb24gb2YgdGhlIHRpdGxlIGxpbmUgYW5kIGNvbW1pdCBsb2cuDQoNCkZyb206IFlh
bmcgWHUgPHh1LnlhbmczQHp0ZS5jb20uY24+IA0KU2VudDogTW9uZGF5LCBBdWd1c3QgMTgsIDIw
MjUgODozMiBBTQ0KVG86IE5CVS1Db250YWN0LVRob21hcyBNb25qYWxvbiAoRVhURVJOQUwpIDx0
aG9tYXNAbW9uamFsb24ubmV0PjsgRGFyaXVzeiBTb3Nub3dza2kgPGRzb3Nub3dza2lAbnZpZGlh
LmNvbT47IFNsYXZhIE92c2lpZW5rbyA8dmlhY2hlc2xhdm9AbnZpZGlhLmNvbT47IEJpbmcgWmhh
byA8YmluZ3pAbnZpZGlhLmNvbT47IE9yaSBLYW0gPG9yaWthQG52aWRpYS5jb20+OyBTdWFubWlu
ZyBNb3UgPHN1YW5taW5nbUBudmlkaWEuY29tPjsgTWF0YW4gQXpyYWQgPG1hdGFuQG52aWRpYS5j
b20+OyB4dS55YW5nM0B6dGUuY29tLmNuOyB5YW8uY2hlbmdodUB6dGUuY29tLmNuDQpDYzogZGV2
QGRwZGsub3JnDQpTdWJqZWN0OiBbUEFUQ0ggMS8xXSBuZXQvbWx4NS9saW51eDogc2V0IGRvd24g
aWYgZGV0ZWN0IGFueSBhbm9tYWx5DQoNCkV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVu
aW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzIA0KDQpNTFjCoG5ldHdvcmvCoGludGVyZmFjZcKgY2Fy
ZMKgbGlua8KgZGV0ZWN0aW9uwqB3aWxswqBzZXTCoHRoZQ0KaW50ZXJmYWNlwqB0b8KgYcKgZG93
bsKgc3RhdGXCoHVwb27CoGRldGVjdGluZ8KgYW7CoGFub21hbHkuDQoNClNpZ25lZC1vZmYtYnk6
wqBZYW5nwqBYdcKgPG1haWx0bzp4dS55YW5nM0B6dGUuY29tLmNuPiANCi0tLQ0KwqAubWFpbG1h
cMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB8wqAxwqArDQrCoGRyaXZlcnMvbmV0L21seDUvbGludXgvbWx4NV9ldGhkZXZfb3Mu
Y8KgfMKgMsKgKysNCsKgMsKgZmlsZXPCoGNoYW5nZWQswqAzwqBpbnNlcnRpb25zKCspDQoNCmRp
ZmbCoC0tZ2l0wqBhLy5tYWlsbWFwwqBiLy5tYWlsbWFwDQppbmRleMKgMzRhOTlmOTNhMS4uMTRk
NmVlOTNkZMKgMTAwNjQ0DQotLS3CoGEvLm1haWxtYXANCisrK8KgYi8ubWFpbG1hcA0KQEDCoC0x
ODkxLDPCoCsxODkxLDTCoEBAwqBab2x0YW7CoEtpc3PCoDxtYWlsdG86em9sdGFuLmtpc3NAc2No
YW1hbi5odT7CoDxtYWlsdG86em9sdGFuLmtpc3NAbGluYXJvLm9yZz4gDQrCoFpvcmlrwqBNYWNo
dWxza3nCoDxtYWlsdG86em9yaWtAYW1hem9uLmNvbT4gDQrCoFp5dGHCoFN6cGFrwqA8bWFpbHRv
Onp5dGFAbWFydmVsbC5jb20+wqA8bWFpbHRvOnpyQHNlbWloYWxmLmNvbT4gDQrCoFp5dGHCoFN6
cGFrwqA8bWFpbHRvOnp5dGFAbWFydmVsbC5jb20+wqA8bWFpbHRvOnp5dGEuc3pwYWtAc2VtaWhh
bGYuY29tPiANCitZYW5nwqBYdcKgPG1haWx0bzp4dS55YW5nM0B6dGUuY29tLmNuPiANCmRpZmbC
oC0tZ2l0wqBhL2RyaXZlcnMvbmV0L21seDUvbGludXgvbWx4NV9ldGhkZXZfb3MuY8KgYi9kcml2
ZXJzL25ldC9tbHg1L2xpbnV4L21seDVfZXRoZGV2X29zLmMNCmluZGV4wqA5ZGFlZGE1NDM1Li4z
NjRiMDI0Yjc3wqAxMDA2NDQNCi0tLcKgYS9kcml2ZXJzL25ldC9tbHg1L2xpbnV4L21seDVfZXRo
ZGV2X29zLmMNCisrK8KgYi9kcml2ZXJzL25ldC9tbHg1L2xpbnV4L21seDVfZXRoZGV2X29zLmMN
CkBAwqAtNDg2LDbCoCs0ODYsN8KgQEDCoG1seDVfbGlua191cGRhdGUoc3RydWN0wqBydGVfZXRo
X2RldsKgKmRldizCoGludMKgd2FpdF90b19jb21wbGV0ZSkNCsKgwqDCoMKgwqBzdHJ1Y3TCoHJ0
ZV9ldGhfbGlua8KgZGV2X2xpbms7DQrCoMKgwqDCoMKgdGltZV90wqBzdGFydF90aW1lwqA9wqB0
aW1lKE5VTEwpOw0KwqDCoMKgwqDCoGludMKgcmV0cnnCoD3CoE1MWDVfR0VUX0xJTktfU1RBVFVT
X1JFVFJZX0NPVU5UOw0KK8KgwqDCoMKgbWVtc2V0KCZkZXZfbGluayzCoDAswqBzaXplb2YoZGV2
X2xpbmspKTsNCsKgIA0KLy8gSSB0aGluayB0aGUgaW5saW5lIGluaXRpYWxpemF0aW9uID0gezB9
IHdpbGwgYmUgZmFzdGVyLg0KDQoNCsKgwqDCoMKgwqBkb8Kgew0KwqDCoMKgwqDCoMKgwqDCoMKg
cmV0wqA9wqBtbHg1X2xpbmtfdXBkYXRlX3VubG9ja2VkX2dzKGRldizCoCZkZXZfbGluayk7DQpA
QMKgLTUwNCw2wqArNTA1LDfCoEBAwqBtbHg1X2xpbmtfdXBkYXRlKHN0cnVjdMKgcnRlX2V0aF9k
ZXbCoCpkZXYswqBpbnTCoHdhaXRfdG9fY29tcGxldGUpDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuwqAtcnRlX2Vycm5vOw0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB9DQrCoMKgwqDCoMKgwqDCoMKgwqB9wqBlbHNlwqBpZsKgKHJldMKgPMKgMCnCoHsNCivCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBkZXYtPmRhdGEtPmRldl9saW5rwqA9wqBkZXZfbGluazsNCg0K
Ly8gT3IganVzdCBzZXQgdGhpcyB0byAwIGRpcmVjdGx5IHdvdWxkIHNhdmUgc29tZSBjb3N0PyAN
Cg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm7CoHJldDsNCsKgwqDCoMKgwqDCoMKg
wqDCoH0NCsKgwqDCoMKgwqB9wqB3aGlsZcKgKHdhaXRfdG9fY29tcGxldGXCoHx8wqByZXRyeS0t
wqA+wqAwKTsNCi0twqAgDQoyLjI3LjANCg0KDQo=
