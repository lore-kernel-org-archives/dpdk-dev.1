Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F19C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 13:43:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D04BB4029F;
	Wed, 26 Feb 2025 14:43:33 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by mails.dpdk.org (Postfix) with ESMTP id 44A624026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 14:43:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suaZ3bOdv/JmBT8eTM3yJKQ6twX6LBIASeSqTThNE9dwPrkbkTjlgzYUgn2N1f+3/fsHe/ZxoVQxMk0s2+0WiWULCWfXaVm2SQMXbAxbFhO9kyY3LiIbrFrLw9Ne38qOh5/PmL3J6bFRX/SID+kGBHkD+4rX8p4gPIe/6hekSUK0aDFs5/2kRO8LFaLI/Mp49a4lkgacrGMkuh/LnVh/bELCP5W/99FSgWRMdS4tgsYVK6jFKmU0isVznrDOzVObbSTwC36bRkDNEHy72lNtUxuTDmkm7FDYMF8qs7rqgcQIcsvskbaMwQaGI4BSBW8z9WQNMyVp3SBz7kpK0xNhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbHXw5jsJr/q1S7Kk0wF9gdT7WHX4+J6ps/9+TN5+Gg=;
 b=QaNtkVajbvQUUkpRKTPUDo+hc2czy8H8ojgInFqlp9I9bY59lkCKTl/NxRGPxqGW9M+uqyokLd7sfON2C5vkRHfDys3+l7JO5mcF1UeyJdn8EPpwSLo4AOhNdV8lGQ5WlvmzoyvGc6SI/7G4bHYBfwvj9LVVCk5w+gfBZ35dip2uzc2N4gxZaRrpJnUOzqdqNGF6j7TkQQyo7bS6TMmha+iF+/twkpbcuZOyYEa80cpVgJR6aw7StRRoCRjooxnsJ6yeid7F9K5Z9+aQT3Bd/qSsUsWaT5zKL4NFCYZCWNbXgD0L58/yxBlj8gB4YBmfMaM8ZW3q1t/QfR5GzpSyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbHXw5jsJr/q1S7Kk0wF9gdT7WHX4+J6ps/9+TN5+Gg=;
 b=QWs8PXN4I4cAZ+dTBXmIGaPsBK5ca7znsxH6kmBJ3p3kDqQ6auR/+uOXIPMmBUguOKFuTh90LohFz5/wSyjxBl36L2CJdSJ1d5Qq4vPDiHcixFJU48liPXxvezmdMuO96DqgsOAqs6+2rHvsYzKdLvAFxVgOXr62BKr/6LtXOeASryR/QGYyDUqSdhCwK2ZeAkr2+5Inc+Q3KqqLGkwYBHh13X5mm4+s5kdnDLAKCMi1/cbO7WGX4BMjywmCQUOqy1RthI1B1+z8hBU500O+aPj03lrDKRwP00ANRLfgp0NoJrxsYsThP7CpZNLHqPw+VtccrzZTIwBBQ4OXYYoYbg==
Received: from PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 26 Feb
 2025 13:43:27 +0000
Received: from PH8PR12MB7326.namprd12.prod.outlook.com
 ([fe80::6d76:9c33:d230:8264]) by PH8PR12MB7326.namprd12.prod.outlook.com
 ([fe80::6d76:9c33:d230:8264%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 13:43:27 +0000
From: Suanming Mou <suanmingm@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan
 Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH 3/3] net/mlx5: allow FDB RSS
Thread-Topic: [PATCH 3/3] net/mlx5: allow FDB RSS
Thread-Index: AQHbhx68KFAWzhVV60Oz0+2HzKzq+7NZahKAgAAufWA=
Date: Wed, 26 Feb 2025 13:43:27 +0000
Message-ID: <PH8PR12MB73268FD5C626A333580DD980C1C22@PH8PR12MB7326.namprd12.prod.outlook.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
 <20250225004527.2066812-4-suanmingm@nvidia.com>
 <PH7PR12MB690552DE1E8E766B1A208A19D0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB690552DE1E8E766B1A208A19D0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7326:EE_|SA1PR12MB6774:EE_
x-ms-office365-filtering-correlation-id: 76254392-0109-40f0-3960-08dd566b8ca4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JIyQR4Fw5UXkgfFWFtxEjMnHypmXQPu3vNfiXj5g2QY+xquQe0mV+xC1BRLC?=
 =?us-ascii?Q?uSzEKR5C86TIjqfsqxrGwNgTYZUdKCjpelTTbZtRiiQWxcUuF2qlPzDtzPbE?=
 =?us-ascii?Q?Yci0vsfk+sjLEmMUPnnRnGb3Xd+7IbLIL64vJ3ZCKj3sZN41PZV6KSVVjIrp?=
 =?us-ascii?Q?dPSU0rWvYxCgJBbzrTrp/Y4OR7WENnKNKq3m3HfPoki+20o8E6UnxUUAoJw1?=
 =?us-ascii?Q?8/F5cFaMwtaTaQNnUodLwJcChYu4E9yzCHWMlWoxXh9OdcCrj665XH+UZgND?=
 =?us-ascii?Q?QL/DN5vx/Q2UhjNGzxsfigg+JyhwQNpH3dPmsE3+/L0TS+NABsPJoTWpgDfR?=
 =?us-ascii?Q?mB6ep7fJ5rF58QyKC+eleYTP5fs9MwHhO0PeZmIg9vDEE2nePtOISsve+1M7?=
 =?us-ascii?Q?kssQef86AAj8wczsgYkXhFqski6fBxDYv720GPPNXLhu1/zlOVr5CT9hCcR6?=
 =?us-ascii?Q?AINruVyagJc8RWD4o1dXhgY5aN2BAVajYrWVsLM9sH3SndtOe5iWj5ZCDTh/?=
 =?us-ascii?Q?mD+7qc+Fg4ACrbthvuecJyIWbfJCrplZVfe3iIUSD3iHt7KY4H+HQmCW9JQc?=
 =?us-ascii?Q?iFx+6xY4Ene17bjIbWyFa97wPibh8J2eEBya1Cdh++IJwyJDn186+f38kbov?=
 =?us-ascii?Q?TP9Fhd+rLCRl5WF6WEW2LumfgTUrl6PET8t1F01FWbU6UvEB5RafV32PCgRm?=
 =?us-ascii?Q?E+bhv2vp+aPZZdQ9CvAXIp1XHf+rJhkzLgW+4/717gb8Uq5DpLvgl7VeC3Xg?=
 =?us-ascii?Q?zy1ktGT4Whk7UZ37EFO3a/t8RgjEx7ITE0p6Aal4yrRr7hm2kC7yygfV6yg7?=
 =?us-ascii?Q?/J6Sqyxh3E8wT+jsn8zBzGKmU1pZsaui82jHeqxAPct7I6vOPzsKQ9dnh5aH?=
 =?us-ascii?Q?OsN1Q5sNyjonRsny15TsxQwbyTtVAEP3+frbHq6CDq4GF9nBhaJeGK5N4nV6?=
 =?us-ascii?Q?Q9eX6q2ulhFxdhBoPHkpnTh5axtXsfszDOqtT0DaPV27pav3jRvpC6av1JJS?=
 =?us-ascii?Q?q7C8muaBkEltb0RLlCum7HnnlBjQeNevhCEq2uFKPGqgOg5u09deivlAtN7T?=
 =?us-ascii?Q?ReAUhumjzXZ3qVzmqVdoIDqhiSXHCWOBgkATWv9bhZelKDPaP7k/rstPPYgO?=
 =?us-ascii?Q?/vhB0Lr2/qDVE3JtLm4U5WEtTDReGddkyS4KnkBgs+JuwcV08AHT+Lzz2SH2?=
 =?us-ascii?Q?fItF29xFBbwnZK0io5PEOSyRnZj/v7kkQWln8UBvGGzCcx+ms+59078TG9xP?=
 =?us-ascii?Q?Cho7q213+4hElpGZQo5bu03zY4a+piH8XTHjoSzPA5vPATWRah6IjLRUMwMT?=
 =?us-ascii?Q?SgHjH7Wu2SMLmGQFJl2ldttH3PSivn4e1H1HesVz9DxcQTFVZBtIymyFkQ8l?=
 =?us-ascii?Q?tpTWvk1x8fAOosvj+qbQ1vQO+AM9+Pz0RWbyIWg2W/YWssxo9tHXRxT9skgy?=
 =?us-ascii?Q?c1VqlQixRTj25DSgmv5m81mzjfKNUYTz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ARbFKHi8h9ZwMVNK+y4q7gS/xljn9CbodzV5CsMZBWRtEfJ2nXvGwQhi3+j2?=
 =?us-ascii?Q?JFKXT1TuYo08W0iDcOSyDp069Y6PckfgRcHXeWbYTTh4ryzeL+B5P/GANO1g?=
 =?us-ascii?Q?1/EZKAW1dEjyG5spX4U2mBcGCBXydSip2l7OcZ1tVAJ7+/KCtnb8DrJH+XbB?=
 =?us-ascii?Q?pGNSmAWxqGAqvYvjUIlzi+r4a/GeSNzOsadXXlh+uJw98z2QDzai1FV4cXwy?=
 =?us-ascii?Q?Is4c+u6OnnWJf+5XwBNYobf+6KDJQxTBbOyq/ObU/u1whEdfrWziqJEKw3Wu?=
 =?us-ascii?Q?YVivlR4VRY5wVEmcLTdP29N5H887qpJeovsjkOpUBMTyHG7O0zEjPN16SxYY?=
 =?us-ascii?Q?0UV75u3r9dsGxY8mnnrUdhGI52dIl3Jcfj/rVgA0Xnm33I44gDy3VpSmHX0s?=
 =?us-ascii?Q?+p3Ffb+dFTCXXTSQZ1emoUdtcWdMrLKHjwYyAKJWCsB7DohPLlacRXlkByct?=
 =?us-ascii?Q?mqLLB+e44nR68pDxKMy6aKUPOi1fj+6rUH0h9g45+1ULnPp8pjmyiXNfldj+?=
 =?us-ascii?Q?7uPJSxUKxq8DKWQNxopxSvAC0XCMjFK66zGtB5lKtPL21LDuZV2YyRodA5Xr?=
 =?us-ascii?Q?Lfb2yaCmAsgBeRiSz1GPLLM3AwoDKKdUjlsMoZxweyfze9j2rrlVlZ1hFOkq?=
 =?us-ascii?Q?j0we/1fr0n6FOR3sox2K/+DEW6GWoT8zmrsLMBvDSJVig0xFxunD6MWX3Hv1?=
 =?us-ascii?Q?XmUQT5ygJVxVWqusChvqVxLFun8xfT6R+382KMZ+DVh3HHrzutSzOTHaZ4Xg?=
 =?us-ascii?Q?jwetnG1A0VLX3U85gc6a1kHbMDsOmumjfsIUf6VR+5yhoOZBMXt+NofMQdmd?=
 =?us-ascii?Q?zU9sZxpZqsjE3f/1Tntxy5UuwS8n4DsxLBUcfIHt90pA+ap6kTsgn+WQHXLP?=
 =?us-ascii?Q?gLe5W7K23lUWHybSesWLQxw3Y7gIDhObIwSbxt6vBLJPf9WjvfVYcRcDBnCH?=
 =?us-ascii?Q?/5xj3zkzzSpy8WGD9G8w+80zUPesBUu3g9o8Hy3oGX6/jt7ruKA3+dp+EJm5?=
 =?us-ascii?Q?YMN3zX/ByYLC1ltp3BD7fmqfMrGs8aqgonu2QObTcIVY4AFPXcVtHrOBbTkR?=
 =?us-ascii?Q?eQFAd9T87G70UA/emlynrhPG0G/GYFveN8wevXMk6LbVY8mCHgwp/kboE8Eu?=
 =?us-ascii?Q?3H3kzDjEsUvch0g6Y9LzPDNqFjWizatJa6wWw2KQxiJweRUVlZee91VoXzLT?=
 =?us-ascii?Q?QRGny8wTTw25KRgoMm/f6KjNWvnb9VKoO15mvu8YBcmUuHRAXYyVN+cJ22ql?=
 =?us-ascii?Q?NC+yUXwMfz93pMzr7jdlM036y/5laYAgUNjthSPEVlFEuQyaZK+mjM0dANFu?=
 =?us-ascii?Q?k5fXx5vIjKskzuFBK24q24A3iIPhTBuIVJMHOAVWXlkTKK+EYSSlRRPm1K/d?=
 =?us-ascii?Q?g61uiL5yaHyfKje4XNhBScV+LAHzX6m/Nn43iipVU8Ca1PNFnyYSZkJzQ9rF?=
 =?us-ascii?Q?pssIdwvJGQa0dmSr8rY9S3d8Et1L12+ViogqdHUFxTc4xIMG56HpfEu+85xr?=
 =?us-ascii?Q?spV4WCJPQxsma/vMbQ77hnlu3Z1B2pvOeF5iWvxRtdq+hTsMmvucIQlKhSnq?=
 =?us-ascii?Q?XPQWXPT66QSdG0P+IaVxTCZLAOJ/Osl6whFJAAOh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76254392-0109-40f0-3960-08dd566b8ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 13:43:27.6916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7o5D0SM/AusU1XXJu5YvTbrO1MJVdN8bLpR2iuxZl/Fgk5PPraa4SKt4g64V5W0MxUyhr2ypaJkaUY3sDZRT9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
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



> -----Original Message-----
> From: Bing Zhao <bingz@nvidia.com>
> Sent: Wednesday, February 26, 2025 6:50 PM
> To: Suanming Mou <suanmingm@nvidia.com>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>; Ori
> Kam <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: RE: [PATCH 3/3] net/mlx5: allow FDB RSS
>=20
>=20
>=20
> > -----Original Message-----
> > From: Suanming Mou <suanmingm@nvidia.com>
> > Sent: Tuesday, February 25, 2025 8:45 AM
> > To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> > <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> > <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> > Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> > Subject: [PATCH 3/3] net/mlx5: allow FDB RSS
> >
> > RSS can be used in FDB Rx rules when JUMP_FDB_RX action to allow jump
> > from FDB Tx to FDB Rx table.
> >
> > Different with NIC RSS, FDB RSS will not do the internal implicit
> > metadata copy.
> >
> > This commit enables the FDB RSS if JUMP_FDB_RX is supported.
> >
> > Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
> > ---
> >  drivers/net/mlx5/mlx5_flow.c    |  4 ++--
> >  drivers/net/mlx5/mlx5_flow_dv.c | 32 +++++++++++++++++---------------
> > drivers/net/mlx5/mlx5_flow_hw.c | 19 ++++++++++++++-----
> >  3 files changed, 33 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/net/mlx5/mlx5_flow.c
> > b/drivers/net/mlx5/mlx5_flow.c index 3fbe89a9d4..9c6a4f39fb 100644
> > --- a/drivers/net/mlx5/mlx5_flow.c
> > +++ b/drivers/net/mlx5/mlx5_flow.c
> > @@ -1977,9 +1977,9 @@ mlx5_flow_validate_action_mark(struct
> > rte_eth_dev *dev,
> >  					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, NULL,
> >  					  "mark action not supported for "
> >  					  "egress");
> > -	if (attr->transfer && mlx5_hws_active(dev))
> > +	if (attr->transfer && !mlx5_hws_active(dev))
> >  		return rte_flow_error_set(error, ENOTSUP,
> > -					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, NULL,
> > +					  RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER, NULL,
> >  					  "non-template mark action not supported for
> transfer");
> >  	return 0;
> >  }
> > diff --git a/drivers/net/mlx5/mlx5_flow_dv.c
> > b/drivers/net/mlx5/mlx5_flow_dv.c index 633c41e358..61d3101ce8
> 100644
> > --- a/drivers/net/mlx5/mlx5_flow_dv.c
> > +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> > @@ -8939,21 +8939,23 @@ flow_dv_validate(struct rte_eth_dev *dev,
> > const struct rte_flow_attr *attr,
> >  						  RTE_FLOW_ERROR_TYPE_ACTION,
> >  						  NULL,
> >  						  "unsupported action MARK");
> > -		if (action_flags & MLX5_FLOW_ACTION_QUEUE)
> > -			return rte_flow_error_set(error, ENOTSUP,
> > -						  RTE_FLOW_ERROR_TYPE_ACTION,
> > -						  NULL,
> > -						  "unsupported action QUEUE");
> > -		if (action_flags & MLX5_FLOW_ACTION_RSS)
> > -			return rte_flow_error_set(error, ENOTSUP,
> > -						  RTE_FLOW_ERROR_TYPE_ACTION,
> > -						  NULL,
> > -						  "unsupported action RSS");
> > -		if (!(action_flags & MLX5_FLOW_FATE_ESWITCH_ACTIONS))
> > -			return rte_flow_error_set(error, EINVAL,
> > -						  RTE_FLOW_ERROR_TYPE_ACTION,
> > -						  actions,
> > -						  "no fate action is found");
> > +		if (!priv->jump_fdb_rx_en) {
> > +			if (action_flags & MLX5_FLOW_ACTION_QUEUE)
> > +				return rte_flow_error_set(error, ENOTSUP,
> > +							  RTE_FLOW_ERROR_TYPE_ACTION,
> > +							  NULL,
> > +							  "unsupported action QUEUE");
> > +			if (action_flags & MLX5_FLOW_ACTION_RSS)
> > +				return rte_flow_error_set(error, ENOTSUP,
> > +							  RTE_FLOW_ERROR_TYPE_ACTION,
> > +							  NULL,
> > +							  "unsupported action RSS");
> > +			if (!(action_flags & MLX5_FLOW_FATE_ESWITCH_ACTIONS))
> > +				return rte_flow_error_set(error, EINVAL,
> > +							  RTE_FLOW_ERROR_TYPE_ACTION,
> > +							  actions,
> > +							  "no fate action is found");
> > +		}
> >  	} else {
> >  		if (!(action_flags & MLX5_FLOW_FATE_ACTIONS) && attr->ingress)
> >  			return rte_flow_error_set(error, EINVAL, diff --git
> > a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
> > index 83f55ed3e8..a063e5ac9c 100644
> > --- a/drivers/net/mlx5/mlx5_flow_hw.c
> > +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> > @@ -7026,6 +7026,7 @@ mlx5_hw_validate_action_queue(struct
> rte_eth_dev
> > *dev,
> >  			      uint64_t action_flags,
> >  			      struct rte_flow_error *error)  {
> > +	struct mlx5_priv *priv =3D dev->data->dev_private;
> >  	const struct rte_flow_action_queue *queue_mask =3D template_mask-
> > >conf;
> >  	const struct rte_flow_attr attr =3D {
> >  		.ingress =3D template_attr->ingress,
> > @@ -7034,7 +7035,7 @@ mlx5_hw_validate_action_queue(struct
> rte_eth_dev
> > *dev,
> >  	};
> >  	bool masked =3D queue_mask !=3D NULL && queue_mask->index;
> >
> > -	if (template_attr->egress || template_attr->transfer)
> > +	if (template_attr->egress || (template_attr->transfer &&
> > +!priv->jump_fdb_rx_en))
> >  		return rte_flow_error_set(error, EINVAL,
> >  					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
> >  					  "QUEUE action supported for ingress only"); @@
> -7053,9
> > +7054,10 @@ mlx5_hw_validate_action_rss(struct
> > rte_eth_dev *dev,
> >  			      __rte_unused uint64_t action_flags,
> >  			      struct rte_flow_error *error)  {
> > +	struct mlx5_priv *priv =3D dev->data->dev_private;
> >  	const struct rte_flow_action_rss *mask =3D template_mask->conf;
> >
> > -	if (template_attr->egress || template_attr->transfer)
> > +	if (template_attr->egress || (template_attr->transfer &&
> > +!priv->jump_fdb_rx_en))
> >  		return rte_flow_error_set(error, EINVAL,
> >  					  RTE_FLOW_ERROR_TYPE_ATTR, NULL,
> >  					  "RSS action supported for ingress only"); @@
> -8104,6 +8106,7
> > @@ __flow_hw_actions_template_create(struct rte_eth_dev *dev,
> >  	}
> >  	if (priv->sh->config.dv_xmeta_en =3D=3D
> MLX5_XMETA_MODE_META32_HWS &&
> >  	    priv->sh->config.dv_esw_en &&
> > +	    !attr->transfer &&
> >  	    (action_flags & (MLX5_FLOW_ACTION_QUEUE |
> > MLX5_FLOW_ACTION_RSS))) {
> >  		/* Insert META copy */
> >  		mf_actions[expand_mf_num] =3D rx_meta_copy_action; @@
> -12112,23
> > +12115,29 @@ __flow_hw_configure(struct rte_eth_dev *dev,
> >  	/* Add global actions. */
> >  	for (i =3D 0; i < MLX5_HW_ACTION_FLAG_MAX; i++) {
> >  		uint32_t act_flags =3D 0;
> > +		uint32_t tag_flags =3D mlx5_hw_act_flag[i][0];
> >
> >  		act_flags =3D mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_RX] |
> >  			    mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_NIC_TX];
> >  		if (is_proxy) {
> > -			if (unified_fdb)
> > +			if (unified_fdb) {
> >  				act_flags |=3D
> >
> > 	(mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX] |
> >
> > mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_TX] |
> >
> > mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_UNIFIED]);
> > -			else
> > +				if (i =3D=3D MLX5_HW_ACTION_FLAG_NONE_ROOT)
> > +					tag_flags |=3D
> > mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB_RX];
> > +			} else {
> >  				act_flags |=3D
> > mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
> > +				if (i =3D=3D MLX5_HW_ACTION_FLAG_NONE_ROOT)
> > +					tag_flags |=3D
> > mlx5_hw_act_flag[i][MLX5DR_TABLE_TYPE_FDB];
> > +			}
> >  		}
>=20
> One small question about the TAG action flags in this case. If unified FD=
B is
> supported, should only FDB_RX sub-domain of all FDB sub-domains support
> the TAG? Or FDB_UNI also supports it. And if no unified FDB, will the TAG=
 also
> be supported in the legacy FDB domain? Can we add some code comments
> here and update the limitation?
Yes, it is allowed only in unified FDB Rx domain. Let's do this.

>=20
> >  		priv->hw_drop[i] =3D mlx5dr_action_create_dest_drop(priv-
> > >dr_ctx, act_flags);
> >  		if (!priv->hw_drop[i])
> >  			goto err;
> >  		priv->hw_tag[i] =3D mlx5dr_action_create_tag
> > -			(priv->dr_ctx, mlx5_hw_act_flag[i][0]);
> > +			(priv->dr_ctx, tag_flags);
> >  		if (!priv->hw_tag[i])
> >  			goto err;
> >  	}
> > --
> > 2.34.1

