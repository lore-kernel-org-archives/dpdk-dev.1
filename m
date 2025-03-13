Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD7FC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 13:07:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC1C340FDE;
	Thu, 13 Mar 2025 14:07:30 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
 by mails.dpdk.org (Postfix) with ESMTP id D325740EF1;
 Thu, 13 Mar 2025 14:07:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMQa0gVAkdOU+ERRZDT9zMtzAPFAP0G38Zfh9AE8H4px4nFujr/aGvkIoMNJBjuQ5sfwVzHXvO+H1iP5lrd08oOS9JnBWRW7xiJvkC3ZBtOhUo/W7Mi0qqflFWGwsDfiNg4wBZ3hbibC1sRbhAQ4agIxSzy1jV+DstuDP4+fj3ZfGal/xpyFQ4OivqSu1D2w6KSyFr55N0GKlRrlVpYjn9UEaswR29IDm5SmpdY6wepfOxZPrxZ56OPIwo+3VEIk9MyOltBg+RPT6Wctx3iTRjdzluGgi9l/MFYYH44nq8egKAu6jCTxUgw9kOTBWgI3atJflt+ek0EaqCc9wyIGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P78j4Yc6jcF8NP3po9hGkz8Cp67Qf6mis2UDRO0smtM=;
 b=IyKlWtWPH5cwsvMmpwViW/MFO6G56Dt0M1bHxD/KAKorCYhcDI7z94ql4eQqq9g4UzlBJaSMJudi05KX1UM8Hpqs2pezUAH5bMouJ47RvHfCzyoCrX9pFQ/17yzkGbqELa8prGnQWV9gasps5nsLO2a4XFHIF7oxsSd7BQAN5IWgnXJKnKtYUI+dmyRDkx5qpd54iFTRTBTlX1FU50rC6NjAwl5VSy3vQaGkDCwuelRcmGm8Mth1L5NjJ4QiWIVIeRKpoL3JB+tiPpjPoajMwQQtwb0HPc1TjzcfNRo8aUIEIG9+AimpmUsAm7Itjn3V1sNy/kMhgiwSgAvwbaUb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P78j4Yc6jcF8NP3po9hGkz8Cp67Qf6mis2UDRO0smtM=;
 b=NNLnZIFyjFI69SGNgFlrQdhbNJ7jiRVDsFnDna7anDudsZ5rIprx/R9LpPkgzab5A2jECwM7lnOWM1+HOT3qbCkjUuLmf/WOviodo3u5/wfsoUFOA/u8ExfFWIolCRmg4CX+G9Aii6fL0nyfzl9rWtOsjS2OnvVpoAD0FrjgnMlEwZ8j1CUQht5Z02uO7pT1U7j39RiwdWebZC8RUi8Ce7Kajkaacu56U9diOCpQe8n2JASLOlG/+7EqW8GCOaggx8Xz6X+9vz3jU2gkD1FgT2EQWsbP6EXJTybEi7FPvwrWPnIcPLRPdHuQ+n7mFINa7b52cGwFo29C26FsotQX7Q==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Thu, 13 Mar
 2025 13:07:27 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 13:07:27 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maayan Kashani <mkashani@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix mark flow action validation in FDB mode
Thread-Topic: [PATCH] net/mlx5: fix mark flow action validation in FDB mode
Thread-Index: AQHbkoOzPMCj0TH7nkO74759x5W6ZbNxDJcU
Date: Thu, 13 Mar 2025 13:07:27 +0000
Message-ID: <CH3PR12MB8460F6E94BF2491F94A2737BCFD32@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250311124635.1262066-1-getelson@nvidia.com>
In-Reply-To: <20250311124635.1262066-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|DS0PR12MB8217:EE_
x-ms-office365-filtering-correlation-id: ea0905f4-616d-473a-bf0f-08dd6230010c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GECIj5I/u+sAG553ArXE+/4Znr5gRGgI57LjDcyAQKF+5OUpH/tL0Gh72p?=
 =?iso-8859-1?Q?U7xvYgwVVti4p0WiGXKtl2a5MTJzkkGZRaR2k3PjOgMxwK4HhNTOf9JUiC?=
 =?iso-8859-1?Q?D7UDdEUWSOnCNccMHJF1rj1I6wlu8+Fwn0OYdx2wnftbfRPEIQKU9U6l+1?=
 =?iso-8859-1?Q?mi1nid/iiaTDyWlpUIe5EDmIOFJLNi1KuhGB+5K89OmEeXbymnBJYK6n+p?=
 =?iso-8859-1?Q?DTMevHcgN2K+Amky2xWpzZm2kDHLvn5/yy75FQ1THgjP7BkRhtOXf8vSqI?=
 =?iso-8859-1?Q?VCktxkz0ymum0tLx7Un2annD7uXRCWTPkGERyrCg5Nyi8GJVVURyhQkcrW?=
 =?iso-8859-1?Q?NNh3V/06/0ENfwm2saoCIAud87AzEtKznBJu7ZisVbgXJJl9IbWnGECzsL?=
 =?iso-8859-1?Q?PmG3kXG5iwTKcsnQVzXdcKVmf7VhkhiFtSlAJMhWziWB8hjFeu7VPIo9Wd?=
 =?iso-8859-1?Q?/GD+McgPN7UdnCj6L1gTN9pZg6xjR/9q+HV4EFkq1tJa9puXj3UIJyzUlB?=
 =?iso-8859-1?Q?QGqFFKJoD5dHbyphcMIAw58RnE24BalPip4Zn6agv0575GGE5auVPopjQ/?=
 =?iso-8859-1?Q?d1lDN4y5+H8EsGeVlSnlwFAjQKdWGgHf6ktPxh6dDRju/paB5irN7vvFM1?=
 =?iso-8859-1?Q?p/RNy3UbiEH3eYuyNnCk+x71qImbEzT8yroRZDdIyLDOpJZhjgn+zKb6j7?=
 =?iso-8859-1?Q?Mjqb7gwceijW3WClUerd99ydq8bZivIfNanuRzkRFSarojf03ZGYHqYIid?=
 =?iso-8859-1?Q?b74HLjymBfvMrdkI/ZP3sAH8MCBVXuzWVyqPJQOdiXRlKcYOavhHkqai0l?=
 =?iso-8859-1?Q?rtNiUOZf3s33ojEF1YzmeX1bTBb1QZjkaTN2asILXkFEv0+BsThNYhlcJN?=
 =?iso-8859-1?Q?QWrS6PDvnEVS5IfOG85KtHKC53DqMUkDc0l0EZSvxwHg5t0j4RUolQt9+g?=
 =?iso-8859-1?Q?zzLVrWuOFcER8eN0awJMo0UcXQZcPQJp1CWwHCqw/s2WxTYLrBX8RErbcm?=
 =?iso-8859-1?Q?W0QYkQmyxAh/dBxQFTBDonaKPLdixCAAQ5WQNEkPYKgNozyV5OZozkshd9?=
 =?iso-8859-1?Q?MEOsVEnCWS1Fj2xFAfDVpC1yVzzAVz3eL62vBiqXZbuZGYJILZvpPeXflp?=
 =?iso-8859-1?Q?djqRuAOR2muv3w5CTtEG0epJ58/2Do3+y//NIoNDRmy0GKOh3pOketsqpX?=
 =?iso-8859-1?Q?KRdquRzlDB5JjEfPBhxEV9UvuNVoVwGQ1261W2sS109cbWqqyyx+M/2LY5?=
 =?iso-8859-1?Q?ySoypwd2kw7fqyuj5C53HAQdNRGXAxqA81maBIgm1GAC5vNl7JjBvAL7rW?=
 =?iso-8859-1?Q?B/tc/lV05xVCkDEW90P+DJWdngQ2wWNBC+15qmWUeP6pjQCdwFtzWNjrUL?=
 =?iso-8859-1?Q?+AtP6T3NXyp2bjhwAiXdyaAPrksIvBlPOSiFgo7Lq+gaz4EhritgeQNPji?=
 =?iso-8859-1?Q?K/nWP0TQITbVFvD8uiqI1uE+YsqfepWPv7YlvCdzI81xIWNjyyC8cFtO+M?=
 =?iso-8859-1?Q?jPTVHcjXXKLVD9lInEEHnt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9dYfcNScScx3RIX7rrKzbufW6k38opkfw44qnMXxJkvGslU6+kE4VVCXTK?=
 =?iso-8859-1?Q?zyFUdEQcgSNVzz8xViIhsqNCpMKGyjyr/ZfYcPpLf1Bo8+wHOH70Y7Ep9C?=
 =?iso-8859-1?Q?qUdQQfswARnhDxG7GGVfgPrIjff/C3cXN9bNuGKDa4si4q3WdSbA+v7SFl?=
 =?iso-8859-1?Q?TSvpavWjqLAtGbOymtnaJSqI4J5EG38HTf8QjZ8BOWTF1BM24n0DvWQHIN?=
 =?iso-8859-1?Q?b0fZxgHbLDxAXJBaBtz/HVpOJ9H2H5chYAlFhj1+mAxZ9KF9oToGDeFAnQ?=
 =?iso-8859-1?Q?ENOZGJfHcZaXoXO8q07v0jjtJAQOoLNivi9yrMAUe9pK0kUj7i/L50IR54?=
 =?iso-8859-1?Q?h3E5ynZWXFfz6OX/oNSZhYsi6zaS76CLb+8O8YYfzwfkLGMdy8nyOD4zLS?=
 =?iso-8859-1?Q?0NRSs95Dr3k6QkHl8Pw4n1pzbZWbmnd7BTO42Kenn/YY7dCeaD9DeJSih1?=
 =?iso-8859-1?Q?ExsczDu8zp8eFXbJjI5PaE86L/PXOcJmg0+sgemDFGVhy5jKJsqPmoIQjb?=
 =?iso-8859-1?Q?S0oCfZ0j1FzHoUUAx4Rv2Lchd+Srslv8a6/NHr7KYVaFZ6NX9i1UK0C32w?=
 =?iso-8859-1?Q?O4hJwiR6YkzlYThlyHI1No3r1q/1BcKJ+7XW1NBXczsMblrRcw1fwb9gcE?=
 =?iso-8859-1?Q?Mmj1pg2p9wLqTajh1aR/ue6U6Pl8DmjtPl++zABWhc9fJwryp7e0WiIvD1?=
 =?iso-8859-1?Q?KAu7N4G/xn8dV0e7o5pf+GLYouzDHrzlSLwbO24cmAcsTNZG7wjL0OsUOL?=
 =?iso-8859-1?Q?mch+7t3SBW9RM1NU2qcrLQP+Dr9Kioenory1YiJn2+kXAjKWwITGSjXVSO?=
 =?iso-8859-1?Q?p9vZI/NwSK0Nz+EPmNe2OdBMGg2P9YxeoZ/YQ1EWeVlcHe3CXQ1CEUEIqW?=
 =?iso-8859-1?Q?XBQ+KwoTwooDg2kMIHWK+SOB05xYC7xBA9J7Qxw3wIt1+IjIt7xugQSwxm?=
 =?iso-8859-1?Q?sr5+UnFiTLMwMVMZx3Us0xnIyDCUQ7wIqfcyNeWa1zfln4gNS5eAHyzX3o?=
 =?iso-8859-1?Q?gx3v8KPV9eEpJvCI1bullQ+lwd9VjnAlMoJREq9b1q6WAIbU5g3pN74BUl?=
 =?iso-8859-1?Q?oyis4/GS3BT1zsZLBiIP7ziTRFz7SW6LN8x9+X6HAud0VhMcNSAw4vs6Bf?=
 =?iso-8859-1?Q?I8SSSS08oGi2gvQ2dK3+7eZzgHyGyyWah2Q4WDKmqSRmUDzBGW3unwS+hH?=
 =?iso-8859-1?Q?rTKY6aLhJNHAyysnJgzKuQU0yeRwh6ixYtLWD/Ps2xilZEKtPDNQoYr5AU?=
 =?iso-8859-1?Q?UIglqozOyAjAzL8Ssma4lY03Ez+FAZmvBh2OtmKaAEZw77q61SihMTHQ8Z?=
 =?iso-8859-1?Q?Q7dgKTdw8agjQ1evdvxN8rE8LzoDZBlskEXdCpD2EnxJHeK/Qyy8q4ZIsg?=
 =?iso-8859-1?Q?6ed5PzCNGoRStCVqDN0di/maxcmWLjj8HK7eORThsEat5Oks2C+gA6QB+4?=
 =?iso-8859-1?Q?5Sn8uUyw3MjyykTxn1FWijTD04zNdJUAq9U9FhX6oY3yS8vgqbtLeYKNZQ?=
 =?iso-8859-1?Q?D+U/2pFUfc11+OGx+eBavT3Y2IwVqFCm7Xy5fqx7u63GAq7p7QoxMIRR6P?=
 =?iso-8859-1?Q?RhsCYpUjvocNxadiqDKRWpbF5pqCvJQ4UMLG4HJT47bw1XJVnQWA+ioaMb?=
 =?iso-8859-1?Q?yGk+rlLad86mJ+j4UHvQ5gWPjnIZvcv5zs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0905f4-616d-473a-bf0f-08dd6230010c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 13:07:27.1950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kz9lFtD4OV9QgH+WwLP9bOCuDdXjDg0tkGngv2DfM7jcyqtq0qWgrYfw6a1C9VGjBMq54X5WESOErErjyYkAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
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

Hi,=0A=
=0A=
From: Gregory Etelson <getelson@nvidia.com>=0A=
Sent: Tuesday, March 11, 2025 2:46 PM=0A=
To: dev@dpdk.org=0A=
Cc: Gregory Etelson; Maayan Kashani; Raslan Darawsheh; stable@dpdk.org; Dar=
iusz Sosnowski; Slava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Az=
rad=0A=
Subject: [PATCH] net/mlx5: fix mark flow action validation in FDB mode=0A=
=0A=
The MARK flow action is supported in FDB SWS mode, but it=0A=
was not supported in the early FDB HWS implementations.=0A=
=0A=
The current MARK flow action validation reflects=0A=
the original HWS functionality.=0A=
=0A=
Recent MLX5 FW supports the MARK flow action in FDB mode.=0A=
=0A=
The patch clears the MARK action for both SWS FDB and HWS FDB.=0A=
=0A=
Cc: stable@dpdk.org=0A=
=0A=
Fixes: d6dc072aeb12 ("net/mlx5: validate flow actions in table creation")=
=0A=
=0A=
Signed-off-by: Gregory Etelson <getelson@nvidia.com>=0A=
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
