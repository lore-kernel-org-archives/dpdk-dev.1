Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6FCCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 16:34:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B887440647;
	Fri, 26 Sep 2025 18:34:39 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11021138.outbound.protection.outlook.com [40.107.208.138])
 by mails.dpdk.org (Postfix) with ESMTP id 977F140262
 for <dev@dpdk.org>; Fri, 26 Sep 2025 18:34:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrWLWtTrGIyvHwEhaHrw3AjLAeg233aK3UBCe/siTDuHSZHM584wAIpteFXazoIS/sRpyoMHH//e767AiZr0Koch9gEaogcFPflEeOGGgR2BJ/7pirtpHs676HR6pd7BmHE/xtgRlKkAh8Lxv+tmNphJveLM8/wYifiH+0l/ts7ZRB9siM23yEpEqV8eX/PsU8pZ26vHGNakjXQHzf6/92jlEoUBPKBSqQw6bfOqSCOdRCGB4DNVHDrlrHBwso1aPVCcxIQMSkLhAG46XR7SToauBFqyH7AoGy7kEDyh+3JG4YIKYO0JuYqxTOH2vbbU75nUy1TTSN1HRfQrcIR0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSS57WHRb7gyNau2ahIJKocJE+IEbN/z6taN34TmdWo=;
 b=oIG9+DLAfkhYj16V0o6JHv4bpQuk073sDtR2JoH6yIc++80HHX8r47Un8FpIap52DMkSLiu3kWR8XqJ3JiC1dBeufxZFJv6iQTbs9uGEfIFm4N7SS96HSlE0LRehWfbztuXl/tUG5HfJF/hcskGYsQVYiPtTBG7YRXIPB5GV7or5MOVyYF6kMFfZceGR4ATHYRrj+9Pimgo/im1WUIowh3xA6G6mfLNLoQJ+25nWz5diLpFdrEJfcuTovSpPf4xCJnUqY98JGO0SekyI5AozfaSCkDbgJVoc+2A1nNUMNv7+a/0gID0R4XYZxHuKlNL7WC/2LKWglVVa3PwAqKjeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSS57WHRb7gyNau2ahIJKocJE+IEbN/z6taN34TmdWo=;
 b=ZYccTA1gVMegj9uxTEEI2BhlVjYPpVjXJjtfzySSdGV4/4GNED6sPbxEb4jLpb78Wt/1HqN3tFHrEXw4X2zdX0F9g+ksYyJiYXBTMjC0cALUAq02K5f5wh4rmX8sIO3Nu15GkEYmvV1sds1NkiWa0K+xh5YJcWB1lU90o75uM78=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS2PR21MB5255.namprd21.prod.outlook.com (2603:10b6:8:2bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 16:34:35 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983%6]) with mapi id 15.20.9182.005; Fri, 26 Sep 2025
 16:34:35 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 1/2] net/netvsc: make da_cache_list local
Thread-Topic: [EXTERNAL] [PATCH 1/2] net/netvsc: make da_cache_list local
Thread-Index: AQHcLv5df39Qw91dy0eQR2gUpXAaO7SlqMgQ
Date: Fri, 26 Sep 2025 16:34:35 +0000
Message-ID: <DS3PR21MB57359DDBB05C1339C07FCD27CE1EA@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20250926155802.398869-1-stephen@networkplumber.org>
In-Reply-To: <20250926155802.398869-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1a4826e0-752a-4eee-80c8-febf6342f7dd;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-26T16:34:09Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS2PR21MB5255:EE_
x-ms-office365-filtering-correlation-id: cc57c88e-9c7a-4c1d-4547-08ddfd1a9426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?hqXSXtMUnq6ezBJtcoFz2c5JTDieVJUIWncuxz02wuVRQwAyGg239MB0Um3k?=
 =?us-ascii?Q?FrRzLsp0MQX3K66kGE1SJTy04x09DgJFpGPXw+A75JB64jPKoGxmIoUgDfrr?=
 =?us-ascii?Q?JnNPfRKJinxorrvvPSHBlVBXQ9hrhkwd9BtVhT4rYs6k33+dhLotK7FNQk3V?=
 =?us-ascii?Q?G8In6g7sKYKgdoOe8I72EgGc7SNJZaooQPW50Lel6Dzl5DnhV2nzn6lFy+eK?=
 =?us-ascii?Q?8hM8AJIftduVfKqz6lgtNIsyKAKseEKvPiJxjwvU4iocHs3tQCrrqZv6awpz?=
 =?us-ascii?Q?eKRiUzZrkTKTJLuWcwqrhXRi5sjc/aqw2krEjUbmW/5pisUKBx91RnbHMUOj?=
 =?us-ascii?Q?lbwfMxEldjJZkgIxU0JQMICcOcwdC2F5wf0WKCrjwBR8OvUFTx3XhUYyFXTg?=
 =?us-ascii?Q?oNymBQVa/Pa1Si0p3NAsAgQbTC0hs2wh4AntBaMG3c5AAKB884mXiLMQquAu?=
 =?us-ascii?Q?48knkv7AaagnEYSmyCHUS471TDnT1rWjwj2hHo5OpjJO3Tnhq+nE6V0owgMq?=
 =?us-ascii?Q?0dw/LfKDrXTI5xfO607JbGGlTZz9B1GghzqMKvrrf6P4ryPQfJ59IVwIUP4F?=
 =?us-ascii?Q?bFhEUTUQqPWqlGmXPTrjI8O3sbKkE8isckM06oZiIJ1eSzP0q2kzpO+SYc84?=
 =?us-ascii?Q?2wnwMfWecvgAZuAfHy/xHiwjFpEnWLkE/ZSq5hMxYO3dx0ky7bgGYfH1PbwS?=
 =?us-ascii?Q?jO/L2WKNG1fwRCmT2wJajYzpOJpgCYzE9YxezeChNKTtM51dQ+IW18VvAKQz?=
 =?us-ascii?Q?OIfFT1fltBP6V67uIJVh1cSErI4dYURhRJrRp8vHosyx4gnBxX7ZGInOR88N?=
 =?us-ascii?Q?GsOMrtlWAT7IITxTZ5ujFAmcGF7Tm7JLd2VIlOoNKrTqYlUElOfI925tGXIU?=
 =?us-ascii?Q?e6sqBCiwZ162b4dFFBAgrEYc0J2vvBHBUO58ZtGSDJyH/opqw/aoCdf7Bk3o?=
 =?us-ascii?Q?OD3a5Wp1Tx8bx1fnsDoEUE+UQGRikdh2UKUwbYGyN/G7G9XQKBJ+Cwbh8qdp?=
 =?us-ascii?Q?yayaFfFJby5MeTkZpxzZe0qUorAEgX5Fd5YTzaeHZKCJhlKwwLxqCSvMvs/4?=
 =?us-ascii?Q?zk51k6L1hg4oD321xXtQJvh3GtMXnFFt6TjEmFMOagQmu9aZJQ+mUvQ6DxtX?=
 =?us-ascii?Q?Ukvng3afHsLiNkCquDrKWykJRBuFp9eePdUumkA0txRmgUyYR50utXWZS6T3?=
 =?us-ascii?Q?zy5uGNuYVBffB9jVjDMPFHY4+kQLOn0tXCf3HHO4B0cXcUzHHIHkyg6wovFn?=
 =?us-ascii?Q?WNc9357x12IXxL+6YJ+Q4UusjCgSTo3Smty3PWuR2YqnFtbuwyePuVZjzHi/?=
 =?us-ascii?Q?MMlF2wWCMTyZdmXu7nW61fep1ETZJIkKnHgKmPHN8SyTqj10ij9TMLwv325R?=
 =?us-ascii?Q?UglDQKfG2wri1CCNYQIKVWqEPZ3w/OUS/SKs6YJaWaWkMla9c9Galh0+aXgD?=
 =?us-ascii?Q?cbaQ9lbO99fsuobMc0GbdacdHoE/UlJvEg1qgpcQxQkn/4QTfly3URm7RCny?=
 =?us-ascii?Q?nApqAtY+RivgjR2ft8fCjYqaoNbegLGGpqQR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PZpaDTDw1feMe4F015uQJTa6X+PhG5tJyXzyOdmHi8ePGCxuSvHU4ConkGPn?=
 =?us-ascii?Q?PwPovJX2lj6QOTn5O3z32/Y/SYJn+yoliB1rCTv/APoL0N8cxZ6CAa353zWm?=
 =?us-ascii?Q?PlkPxLn/OCe450HzgElAyyU2co+gK+OVU9Avi3p3DOqU0X8AHZwEwSBmCtoP?=
 =?us-ascii?Q?q93ZKySUS9Nv1G5mWpuhFvmwjHzIUpFk1ZDZfxAUdJgD8KYb+MZVkLJ+KLJO?=
 =?us-ascii?Q?ZjrZCWTCMxBby37vL9YkcGQ3ygJKNnwd3MAXqpxDlwo/uAwyiBTY2vQovJkp?=
 =?us-ascii?Q?1qiKZVhHxuQyWkLFK7o/qLHHPzkR26lJqQK8l826yUN48dJwh0eLOn0aA1j1?=
 =?us-ascii?Q?dPlKUUzeqbeIM8PUCEqp+VWdsiMS6nF1j5GaQh86ddUlsBHv+vv3x5l+hnEv?=
 =?us-ascii?Q?0eDv3wm+WsS+nKbIiVXXUlkq4RsLHyJ/v3kS4nOPVn0FyXdPuesinI63+TOX?=
 =?us-ascii?Q?yCNzUz1vCqPs2ECo0tVRAKvZSr9+8VZ1J2d7o3KE903y4vJ75PEVAdmZhkOB?=
 =?us-ascii?Q?ctI7xwwDW+l3SVoFdGtxRL0Sf9s+kYGoPTK/ynNODeUePHAYnL30+h5u6QtE?=
 =?us-ascii?Q?wSwPyobdmbJbf9vpUOUpEEfyCbhdpN0IVk/R6YCB3I5Q41PaakSChMfcCRH8?=
 =?us-ascii?Q?xZAIg+kbOWVgClpPnynosFrLt1YA71p39Mg7XL4OzB3yxdmfbm8CQ6wJBON5?=
 =?us-ascii?Q?RUGiCJ/zXIdNxeBDhxLHbV0nbZ3RcnhH8Yl/MSV39vSExtAYt/Qvz4GOJJY8?=
 =?us-ascii?Q?ae3i7R4ZQ8+Ab3vGxBSfkgJA20iub0LjYuzQkkeA6YQbzv44Fsqzu5LDYvMI?=
 =?us-ascii?Q?TecGCPsbHUFVBXVE2kYF9FMv+xQmvQwvTWd30ND+zLp1akFKenIL40vU2hkA?=
 =?us-ascii?Q?wPL7aYKFLe58WUHRZTcFYpnPO2XyJgr54rI/JmQFyrV2gMQvqHQ/PKRqnsdQ?=
 =?us-ascii?Q?pLoa0Kg+oGLjjHcv0INtkP5yEwi/8DSyoVr+dnIrCOS8WkSxigudxyZ/ZE5t?=
 =?us-ascii?Q?Bnz31IpZHRzeW6c5TKEGkd8xxSLEWEjDAvQ7KEcp5y3N/ivYHl7xblqeDEzM?=
 =?us-ascii?Q?k0D/D/s9rbVEOj2wX04a9GDgYeqlXBxLSjzdlO4h7AdjkSeFuY+tfoPZk4pM?=
 =?us-ascii?Q?q4MqWLzjSW+dc1WMHC8CZm6QYmvwMNpOYTnNMOVnLAEb3EVR2uMrs6CTwc5J?=
 =?us-ascii?Q?4o0Nxarqcu755hnu7PS5jIDhiT3XHuxMatVHOhk9hkWDytVaed6kDERxypDx?=
 =?us-ascii?Q?V46ybXS1L6yivJ+SFu22A7cKJp1iPOu3SLO8vvEfSAcDxrA7JgaRD0YQyjtQ?=
 =?us-ascii?Q?P+PAb08NKu4qHiO9HQ5R7IPZ955Tq9hi1yWbAelB8h9IHMmNmZp74J4wf3o3?=
 =?us-ascii?Q?1Cfci9Q29gJFLgItiQgQMVwSGxb+oMcd5Xfwl7e/UjVyPFd7a4BFWOQfRxNd?=
 =?us-ascii?Q?NKgWuzJzi5KV+xqAFPqwCY+VzvWWDMMNELkmiSdBnvvvTGx5R+6/fdw9068w?=
 =?us-ascii?Q?YKnachOjyVe15w9TkNGhjZ9t1yF5YDyEI1y32FSEp60eQ4EeB9miRWTMubtR?=
 =?us-ascii?Q?osSKzU44PRV2Laqc5QQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc57c88e-9c7a-4c1d-4547-08ddfd1a9426
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 16:34:35.2747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rf4AmuJ6ZT5YMg2gpF44rjdKDYxTvIWbx6VpeDfVyUxSS1jbTqXgaAI3avGmB8pwj8E+BO3h20y5pcGPTX4HiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5255
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

> Subject: [EXTERNAL] [PATCH 1/2] net/netvsc: make da_cache_list local
>=20
> The list of devices is only used in one file and does not follow naming p=
refix
> convention. Make it local.
>=20
> Fixes: 9a9d038c782e ("net/netvsc: cache device parameters for hotplug eve=
nts")
> Cc: longli@microsoft.com
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/net/netvsc/hn_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethde=
v.c
> index 1d788f3fb7..5b9b54c068 100644
> --- a/drivers/net/netvsc/hn_ethdev.c
> +++ b/drivers/net/netvsc/hn_ethdev.c
> @@ -102,7 +102,7 @@ struct da_cache {
>  	char drv_str[];
>  };
>=20
> -LIST_HEAD(da_cache_list, da_cache) da_cache_list;
> +static LIST_HEAD(da_cache_list, da_cache) da_cache_list;
>  static unsigned int da_cache_usage;
>=20
>  static struct rte_eth_dev *
> --
> 2.47.3

