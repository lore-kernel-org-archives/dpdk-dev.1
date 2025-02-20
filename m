Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E62CC021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 23:32:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79A0C406B4;
	Fri, 21 Feb 2025 00:32:57 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11023140.outbound.protection.outlook.com
 [40.107.201.140])
 by mails.dpdk.org (Postfix) with ESMTP id EA5924026D;
 Fri, 21 Feb 2025 00:32:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhXxIG05J98gfq4Ar1Fp2zAYO6Qfm/K1V9+U7tACivP1U5FWBWA2KGXv2kZyE3QAhoK5S+7k3o15FKP8AWWyAaKBzqLmzF/x1Nh9y/NZN23peDteapXxB8j3aHER9hQjj/QIIvYlucvKgKZgNmXPw3P2B6vMeQ13YE+GoEVnAHatG/Btuur3aTrxFfCXbQ0wSwtKyrxKGbi9DqyNCh+DrXfbMTs6PnC9eh6fGEgHQ3J0o8oy48jLbRM2nK6u+Yq+SivPl/e/7H3CaWv2lYZKYGr2h7nGTl/bNBCoX69A6jP54LsTD5cFr7xOqvq0PDdDeZbnQbwJxy3zmY1dTRecfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0R5gm9Rjs3qjz1pADw0PqvrEQcZzLQY/EqIIgnILco=;
 b=tvnRF9ecjigxznOgG8unpQgwrtsKq6+hJHiG2MgODOtpL1TbOuO3PY5R+khZ0crieLHTInaYkRDdmQPdk28usnLPklfzBxTgIQiBJ4uKZ59vPFARlxWyPRLXQ85ZS+dChuCQ0uEJDTey/I+Nr4Q2L1m7w/OkTQXN8WMd3W30UJvaoTglz/omVl6Kq+i+aO8Lr4N0pwymwA8UoxuwkEhxD+TtIFX9He/BXQMTS6Sj2+xTTxjIVQ5uy5wtaBP4kDuTw7T2h/0K2nJ3wq7tOScfzyc9pDiOGgiD+Zacu1zTHtbfA04OjxzPZt9M2d27oaTnBLwJosy4/1/zS6cqKXVvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0R5gm9Rjs3qjz1pADw0PqvrEQcZzLQY/EqIIgnILco=;
 b=Uc8fW2i9rBj2H/8XIWVRgSBjNTQEFBpD/3/SFF/Dg1QU+oLD4MnF2qb2xn37+NZRseP/tUPSZ+WWGJq+WnHu5BwtXaw7GohatwhUk7jsJAkSyoD6qFfWIL73UH1+zfm1dnvrazNHP9CCyVN56yuSE4GSSijBjTdisezjN7qqL6g=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by DS1PR21MB4474.namprd21.prod.outlook.com (2603:10b6:8:205::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.10; Thu, 20 Feb
 2025 23:32:53 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8489.009; Thu, 20 Feb 2025
 23:32:53 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
CC: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [Patch v2] net/mana: use mana_local_data for tracking
 usage data for primary process
Thread-Topic: [EXTERNAL] [Patch v2] net/mana: use mana_local_data for tracking
 usage data for primary process
Thread-Index: AQHbgkgEGURs4tGijk2bI8zHEmrkULNOlDmAgABhb4CAAeUwcA==
Date: Thu, 20 Feb 2025 23:32:53 +0000
Message-ID: <SA6PR21MB4231765B563802AB6679081DCEC42@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1739912366-6052-1-git-send-email-longli@linuxonhyperv.com>
 <OSQP153MB1307B222A37066A4D6746147BBC52@OSQP153MB1307.APCP153.PROD.OUTLOOK.COM>
 <20250219103555.7e44aa91@hermes.local>
In-Reply-To: <20250219103555.7e44aa91@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4fad423d-1973-42b0-887b-b5b903c58c5e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-20T23:32:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|DS1PR21MB4474:EE_
x-ms-office365-filtering-correlation-id: 81b8c6ac-32e4-48b4-3f14-08dd5206e5e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6PNwhCjngYZyox0q+0F488DjfE2v+a+QzU1ilKODMS8zHJZpNSfla8BZBj6z?=
 =?us-ascii?Q?LWzfVLFkmkHctHCN3bdv/IV8TuLpT+NnfVIqafqD9eIR1c+uMAj1jTRW1g6+?=
 =?us-ascii?Q?qou+Id3D0dG0FScrLjC51lc3TKUYGHCu5nj2W6OKZPBsp+88eCJ/fXSyrHmN?=
 =?us-ascii?Q?oYkTIJkQrw6+2IFltAgIrHtIIHwtqWJL/sYrKcw9U/4BMC6Yed8gb+NnFSjk?=
 =?us-ascii?Q?LRaRSo4n+HsQ6jZ+J4j/6wSGCuJh7JDlkMbB0aDIT+jALsKQIWYgA4iELknB?=
 =?us-ascii?Q?fqJ0GMISKNtcfGsyEnqgSwmvTFjvFT33VOXJ71Ww+DpFbFO215cGPWl58h+6?=
 =?us-ascii?Q?E2bAYK1+1v+OyN9zo1KhT09xUmbtKU8uD8NSmPUChsbGNVp2eHrFw528NfSz?=
 =?us-ascii?Q?2sTJBOX+UDF2yTzbUGFjBqqd3dOAMmw52SbVjwXkKlPxPlIxmFHe+k90+VDb?=
 =?us-ascii?Q?Xnr1Wa4LjAr6ZcxZXGe4wIzXQmdNA3zOL5qvDqn5Hwrq3Op6B+6YDW0F4ZLl?=
 =?us-ascii?Q?xFi8BvCtrThPEWKU2f1BQignGhdlS8UWAvBb8+vTU5wYACavSR7Ghwf42XYq?=
 =?us-ascii?Q?NoCnB8aBrD0dhe5D26OlbH2mCU49D9mhiL7uY5VCicVN5s1DUWFZZwoMqdJn?=
 =?us-ascii?Q?FqJCq19eZ/fLGFJLWkKktJLcEO/WKDV/vVapjSpNh7ERQCk/ljMLm0jWWmMC?=
 =?us-ascii?Q?lTKLquslVGEwG6vg/uCCooO67Ph7vMh6zjGrpsskI9Y1oHAr3dfs8g6JqM82?=
 =?us-ascii?Q?j3cwSvrC1W2l/Whok8GXfAXaEXaFwJVDJz0C5CoPu7/2aBoLFZmPApgIFJGm?=
 =?us-ascii?Q?/FVz/drsS8opwB+Me18YH3iDcPMbipUNmse8roZHnjw8FXyq5MqM+Nn4ZYnU?=
 =?us-ascii?Q?89Wc6KIPCYbq2ZrJ7Bs4olwe9amN1akFFouniNF3h8gYLClxaTon5bWglNoQ?=
 =?us-ascii?Q?sbjuE6sLJYToniiuf3EM06jtwrJOz+eSeZC+vgui4aOYv5q8F7w1pMLAea69?=
 =?us-ascii?Q?QHz1XXTdjyJczfu4QLYajQvpURhzLeY91PcZwbzIY0y98ip4awHxpny4tOAh?=
 =?us-ascii?Q?klJbwA/qX03MYcG9Q3SNkvv+fCYQy21Tl6RUBn72Ea6SS10d9RAUpkjeTsQH?=
 =?us-ascii?Q?eBZgRS5uo7bJhgYQjT8clAQLWd9DNJ3Tbx1RKsZgLXC5ITw7if4EtmV5EGe6?=
 =?us-ascii?Q?sYSm0jx/yMcdeeNdQF3PhcVxSUttLqjmoRUk25XJskbYUY7D2f8a+x0nJJNa?=
 =?us-ascii?Q?0EXJaPwe3bAoeQIfcDBscKUH6ZvoUV4EHjeisPaRUdPJMef7GasreSMSoPqh?=
 =?us-ascii?Q?c40Z9ya+RIOlYYTJc6nTlGhZe+544MvQ+4CFprBcmm7K5dDzwoGQla0GO3xn?=
 =?us-ascii?Q?nAhxsRi2c9LbksD2oPucptqc8STlfZ1DNhte00/66gXHgP0F6LuYFM48RsW6?=
 =?us-ascii?Q?KcuST63byOs5e9pAj5aKvIbitHmrps3l?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W7jpogQBCNqyiQG/1FIq+gB1mRVDN8VOPEBnC2fwReqsWcyQ0AVfV7mvtXao?=
 =?us-ascii?Q?oULf9Ni2X0sKW1PKK6+5e0nhti+UE7OyuonmrNEFdHQ6AyT51TDYAYmWuexA?=
 =?us-ascii?Q?NRgtigbrmDRR+pnjWiXv7Yn8wOFqawQ3S/ZliApni24p/kj4jtWc2AqYkVNK?=
 =?us-ascii?Q?ItUQKldvyLLHQR3u1g/yS6QJxKH/+VqzVaXHeVq7u17yIDerWWBg7Pof+w6W?=
 =?us-ascii?Q?oKjEQ4JoNXSJYjCWOZysw19G94kgczEMxzjUhUjdol9ldtZx0e4wvtKOXqFk?=
 =?us-ascii?Q?BtPXFEt5MLLpO/2+mSPVfvdEqQ5d8YZKK17K67d47B3+1LVcVCGlIya5dQ1m?=
 =?us-ascii?Q?TjpIX1ZAEZwN7STGnfFsFgoUJxX6W+Ovd/GkQTrBzaDn2jOhTc0nsSYM3q7u?=
 =?us-ascii?Q?YTfM2ZRvlTzsTCoeHjcfcMWrrSjprKa6T4lfu7JKkWFp/WR3NnWpxzNqmPwe?=
 =?us-ascii?Q?Q6jpUt+gXjtXra4tWWL4KwxZyDVKCmf5RhPXbcXxqdJLv3ks4QVQxR0l/xMx?=
 =?us-ascii?Q?9kV/IpMhOwMX2rQ3B9kEyxFD1CwqWzcCHH0aBa0mWIhkNRz+mQBDG9pmbM8+?=
 =?us-ascii?Q?d51rpCIuQgKO5zEFyf+SbYVh17EoewWzooSaDj85sOQeZ7thJAQFTFKmEhQe?=
 =?us-ascii?Q?IZILRutqUNSOiSDurZqiLFtQokWDNhelAf/622Wc/LwicZDiSCKgawKq5t0M?=
 =?us-ascii?Q?KqAZcC8djkfu4f1aMEJjMGSRUodNPRJwtyX2Y4EOzi0OhLU8TxSRNbkNB9PX?=
 =?us-ascii?Q?oZutvp+xXNpcnIcfiQycaDH8aY0zXk1qxP3a/qPNm83YFMJwjSEbHYyhA5Un?=
 =?us-ascii?Q?2WdCBQXGOC8tAnbiq9/QTGEbzPLOLjlBWZ9P6PCcr+Uw7zNByzRrPOKR+tHN?=
 =?us-ascii?Q?XGWtoH6MzRKdZks2UH9PjUsNvho7iaM4Klj50wCGQ13tTMMkBB8mN+XPl+rG?=
 =?us-ascii?Q?RTBgP3THT9c0MP/gh52Wk20fBJsV9B3LZJhVFtaMK8fGYfA6+PX19NIKnLZ5?=
 =?us-ascii?Q?8XiNJQZht4bguY/4ijt8GynOjnns8CdLTPf/F7tye/IW3zL9HjcSRJodxvdt?=
 =?us-ascii?Q?8VhCeJuG9OgsCK5bxeMyuWtNNnePMkBW96ifBbTjDFtXEnaC/kDwPT6Hl6Ij?=
 =?us-ascii?Q?7mXhE1bUTjeFMhSqM2vXJTCngDihbl/1K9aEbqXwFLMC29zJs6kuxnDP5aNj?=
 =?us-ascii?Q?uTstdqNXwAE8kbGv7bK1E2j1zMq3g+J41GrVgaf6JMZMcTxM+xzBvWheCzSG?=
 =?us-ascii?Q?QH5Rg5TKdChriSYwKwa8euzlU79ht35ssluFZaZhWKfAkNYptTpHW6JjcgVq?=
 =?us-ascii?Q?2Q5+5eyywG/AWGGBwO+CbDuVJvMqIq8zVuoFOQg8hpNrta7ZIj8KQSSWcpFX?=
 =?us-ascii?Q?LEuvtX9BeNRzXBCAdN4CoNsnaF9Tys2ekdb8oFNcDLWxWdnOIPKAb5MuFr3B?=
 =?us-ascii?Q?BCP4JQgCWVcD/Pb1JJO7XxOAU/vHgfKh0wWR18dh5vLctZMhlEYlNQOi76fU?=
 =?us-ascii?Q?4oXq3koZSrJm6RGKDKe+sSEyWOwjtMJX34PLGVkqBfoysWwVguvSqMLD0sbU?=
 =?us-ascii?Q?0dfkvJXNMkFvSCgnxr1gR0xA0lCCaGhbMsF+NJc6iwejFNemXA2fN3cxUNZV?=
 =?us-ascii?Q?y1GCiwgkmfRKNwaK2mOa1Vr30u+n4hKpbsueTNND1R6l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b8c6ac-32e4-48b4-3f14-08dd5206e5e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 23:32:53.6491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZE2EoLGtRWVbP2IaS8x88yQ+CNeu1ns+r2l0el2qVgQRbuj/BGsytebcIO3NZgxmAHU1B0Vv5vnxEdhY/+fChw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR21MB4474
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

> The DPDK has converted to using the C11 atomic's so this should use that =
(i.e
> RTE_ATOMIC() etc) instead of the older atomic primitives.
>=20

I have sent v3.

