Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23752C0219D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 09:33:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E14E040268;
	Mon, 10 Feb 2025 10:33:02 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
 by mails.dpdk.org (Postfix) with ESMTP id 3631840150
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:33:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUY7XqTuhO810k6d557zi3oy6zL6E+4RWstaa4tf1qQixxuyZqLHXdCyYzfuz15suIkga2v3vJNctnT66QoBIbhINNVpFVZzVHWrdCVEeZCiajIgtzgft1xXXTm8EVFKnlxXBHDuahEd/IkzfQs2840suEh+QhbBpfBryG0MfTZLPXJPyQUFc80yiELIltbEguO2vi+H1lYxz7ZnaWan4JCF0jM5hBM8WGS/D7INyFkMMqCCbZvzJwoKeNXKYok7qiz4+baP7EDCayixKvX5ff2N446R4kWdxrataaV+lYd2vFGFT8oWKWJDKgSb6BnXRXdQ5YRdgRIdcy3Ln6zpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQDgysam6LhwXbZ5qVNUf9lmzUhXWYP/w1bU7/DJ0rA=;
 b=jElyBXrUp92/vsDYMitG4DRyqu4zhVqvSJZku6i5YG1u+2CJBDRr5/kIMkPhqTKuWTVH4n0FVISQDXrJEY1ofPyPC2VrK2gT+Lyx+CIp8EBRLpCAfl3ucd0iqbqnGqqQ6/fwZfPSsZHjXXDz4WVnYkgz8Cu2imNCdhksGjCrb4ncyMoeukngDQG+zAnEV0xymKxh4l8SPaf8BXhT5XNs7nUXWzRlN9yonMsSAJZyMuUKNrjBkYAUU4Nei8poi3r8ofFNJbwSBcDhkHn5ng8heRRM2WYJqJ9LmdgP0tMYGMEmQqbjHSNrXRxy56dqK/XLk4bjkW3W5tjMKUiSuNwY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQDgysam6LhwXbZ5qVNUf9lmzUhXWYP/w1bU7/DJ0rA=;
 b=WgSSCIUoaTrkQhflgkDh1ABcgoRWiQFWWwO/iVTLVVvQndA9WxidAZAE3UZ2XgamRlas4ORRU2H5CzUEJQICcGMerJOHWRhVnCmxzWyI/Yr8mV9xsqC+hQT2iG99xTh9iNNNLD9wPkDWTBt3kif2dXQtHIaTwqRCTMrYZnCMiLcC25U97ndzDB0SNSef9JgB/saBzwBKYyvj2M2epqViJiKOVRaxVVHTauiIohwabDotlVLvGj43agi6SN40z9EzvpLExgDANHW+Ho50IazZ2fKTHCwdxfBrzGKegzJmU04Y4QfEm2SrhlZuvIiy4s20DF/Nbrwx5q+65ZuY4JiRlA==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 09:32:58 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:32:57 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Alexander Kozyrev <akozyrev@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Slava Ovsiienko <viacheslavo@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>
Subject: Re: [PATCH] doc: document hash RSS limitations with CQE zipping
Thread-Topic: [PATCH] doc: document hash RSS limitations with CQE zipping
Thread-Index: AQHbYubKA7/w5UkDKEur4hESyOQZvLNAd6fX
Date: Mon, 10 Feb 2025 09:32:57 +0000
Message-ID: <CH3PR12MB846071BEB4F3B0DE30095498CFF22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250109223432.3222546-1-akozyrev@nvidia.com>
In-Reply-To: <20250109223432.3222546-1-akozyrev@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|MW3PR12MB4412:EE_
x-ms-office365-filtering-correlation-id: 5a5c1ba9-b06d-4c1f-19ad-08dd49b5e779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?R+a59WeCwUGwz+07JMDjUZN5OIZgDzZlBMqwFOaqbpzx+6yBDQIJgy2rZ0?=
 =?iso-8859-1?Q?5Zz1/VWFTUsJPJbloOYhAepV06uCEWhki4AZ3BnGwuL+tej5Ud8Y96fbS8?=
 =?iso-8859-1?Q?uKquAlZ59IMCMVkkkA85nPix0LUWYYUnSrtg1N3D6XEntR/SjO47+4fwe8?=
 =?iso-8859-1?Q?JUwHa3w8/3vUXNkic3tVtyx+3a+UlIENtrB4fwVHQMqQAAx8kzUX+ZAjbU?=
 =?iso-8859-1?Q?P3khsSWAtQXs5Wo2k/lCLspLzUAg3Ju1MCl3U9stSe0lT4J7EaAtqBQDMB?=
 =?iso-8859-1?Q?pQ08YtKV/OprnCwcK/IR32aCE/9hCMZkHwH1AAHmD5edjtcWN7M6rldG4b?=
 =?iso-8859-1?Q?cdpPWUhAmWJyMtNHlc84b3QUw3M3IlJtvfD2NCHtFj+e6pb43t7ISnCmz8?=
 =?iso-8859-1?Q?p6IOvgECnYKh+4Kl5o5bF58igeA1Xq1jyWh+6uvfFjXc1Ltvv93gWlMQIA?=
 =?iso-8859-1?Q?Bt+6ok8dlDsuJOrOTrbGXeYFcUDF1uCSwTM8C9rhmOBEWQ1MfXk2/WTRAj?=
 =?iso-8859-1?Q?4PReyOqIh8vo7GrpZORIXsRaQGhK8jffWyAbSefEE6BmJVutPLXPCs+oIl?=
 =?iso-8859-1?Q?pd3DKF7ck6Xr0/fSVnMN+8LItE1m0AP/on2Nsa+qtgrmt4GTYiWpiKgJ29?=
 =?iso-8859-1?Q?g7VUED7UwaNziAKhzJH0rLD09/WxgLO+xFSAqI3wL2rD9u8JROyGmfb6qR?=
 =?iso-8859-1?Q?lQd30/hUgm29zxza5UrgDs5XdtpwXfod1RkQ6sV20QUlsfGsuN3/6Ml9xD?=
 =?iso-8859-1?Q?LVHyO8V8WF22asgHahZBFqs18eIYhmDagzPCM++0PdgeN+tSeFxz8KZdfn?=
 =?iso-8859-1?Q?kfjerdebgGJtzHxOKzhTW3spqL5yPC5PhUCUvuIJTM/hpGNbIN5kPmSSkJ?=
 =?iso-8859-1?Q?qzNyuTYblgzzxbBOO/NDb2vAYos6m+QdC63BnggHlor5AQNZ3ha/3WuPuz?=
 =?iso-8859-1?Q?4OywnldUuXVx69DAjItgh/c3jA4/peZIXgLMZ6evKl/SfFJLPP6jht05Pm?=
 =?iso-8859-1?Q?znjYKaqgXz+w2hdzoIcsMRGce1alaZS6d5gE/xYqjk99zZM63Giy/NjcRX?=
 =?iso-8859-1?Q?rTy7VlIQWbSJWjMbBep1tjIPw5qjVfulB7My0lA/v0wn03Td5i+SKlQrg6?=
 =?iso-8859-1?Q?S5bJnRaCis5gctFZDB9mNGgKr2Y2gXdYoA4z01KYR7uZiJGm0wtDdt7gh9?=
 =?iso-8859-1?Q?2BANV7z1t4HUqhTpaR9s4i1950mshdsTnObwIIAC4pP6Vl1VYDsz4XBF75?=
 =?iso-8859-1?Q?97YzkmVVU8xL6NvFNDXnAZahbFFXwHGcMy4hZqXBlRlXEI9VplG5xgmPCm?=
 =?iso-8859-1?Q?Gvh4FXLENBSkPoKDwJ1a2nn2VcHOCYQDEpwXWEIMl+FLC5fXwpx+e4xYEL?=
 =?iso-8859-1?Q?lo6OLSTaNnJWvhFpacgXQT88vKyyCpUK9t6aMgH46oBo8RxyDUTHo2510A?=
 =?iso-8859-1?Q?7jk2domFHB4fDiwTVCdci1xHZvTO0m658IHb/GXc5ECxlG7DRdG0ZFGepH?=
 =?iso-8859-1?Q?/yUyxWT7VOEXg5wd5Ak/S4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xXgBAgQ0Vz13OjRkmwGw2JDbDvzEeo4WXcR0MhmDjJ/OJwzfrVV5S61z+c?=
 =?iso-8859-1?Q?aqQvUNIVOgv0bozNnx3cB/us7CwOqEWKXGXcYvDke+J8j0QqrB2zUkJUFO?=
 =?iso-8859-1?Q?9Sg5PPJXQISmelJnP/WW3A3RLr3oUGJ34ErJtBYUlE3BJZeGMRauDyfgU3?=
 =?iso-8859-1?Q?OdHVJAijw3/llRPCOycqR/LmyklY6PqR87qfX1+c9Rc2+KaOz2OX5G82xz?=
 =?iso-8859-1?Q?mRu3EoDuAGxuyE+Qpbi89D5BhdxasJJM+MXAVGQp7pa/r0jNcRlx3WXz8I?=
 =?iso-8859-1?Q?e7XZOcKRLHP0IQK2dkCE75Cyse+gs5hNqkHWN7P8tOmPe5I9PzpjfDFZ+x?=
 =?iso-8859-1?Q?RA6bNZnpl1BotgbeJA9+CPnmhuKbC715cKfVBlyp9WiazgOHSRm4AXLZ5G?=
 =?iso-8859-1?Q?9Ona6A298y1d3H4sVO7nBLYYdtUnhE2whWqDEZ3dh68rknGW5f31w7ByYX?=
 =?iso-8859-1?Q?4/Ju+XcTEz63P8GWC/g3bZlUFgZ+RKX0IUp1YpF0Z/smxyCQ1FBDUrUTUc?=
 =?iso-8859-1?Q?ql+Jka9Ta+6VLeieHQvBKslJ6V41lQo/kEnCL75/VjTrAjQNKD2guW6EBl?=
 =?iso-8859-1?Q?Nt+8WcMEvybRkDWjwMamGLwQoeI+cY6DPfIjB90JzjoOw/SuaozG63hTVW?=
 =?iso-8859-1?Q?Kc5/n5ZkUwCXLAkGq4kaSrZmMGYbNeflFMzEkW4SJFKO0MHQY5ghFYJZpU?=
 =?iso-8859-1?Q?hHLcSK7BYNKjfWuuKbQ5EsCxTKO/UenzlRByhJJlf7FmU3QxEWq9ZtUPEf?=
 =?iso-8859-1?Q?X+F4Gasa57e/H5DWH/8Uif/AeHNzIE/8gYg727+LTDmEpAgjwAbFAJ0mgV?=
 =?iso-8859-1?Q?4zdifRudfr4ZrtRPf8xlOBIIx0O4oDsEjsDDZZzBcF/Jrvas37v4gIokgx?=
 =?iso-8859-1?Q?NGVFWk+ZHLNVyj1wp+O3AAdGQICBlA/DM46fq0mMlCJkvLmAAYHH/zqaSJ?=
 =?iso-8859-1?Q?OBKt8MdoSfEe96DXQtkU7/6RgxSuUKYInWGL4yrBpa34vqOg/qZTuQMLtm?=
 =?iso-8859-1?Q?vhtt+5Ghl3FCzs+MrwB3fdPoRuk7dKrBxMlG1TDYXMbN8ZoQoIGDyEAcw9?=
 =?iso-8859-1?Q?tCbxOeXJAdA8eJoXp3cPOJAodgrK0yrKqwjQpgGtZqS44HZFT2C59mgT0J?=
 =?iso-8859-1?Q?j4KT6khwzzwPlrIxm/yOy5ApQP/EoTIhoWNp6N/cO5qcTLmpXJQNOrDWTj?=
 =?iso-8859-1?Q?+sN/nGFKqUnac1AG68AWLVeP49a14GTs5R5hL7RB8XqCQXCscTBMXmnf1v?=
 =?iso-8859-1?Q?vtN4m2Hg8+tjY0PmHtabb/+Pl88RNy905smFq0pZzMcD4rjCBbS+fcq1AH?=
 =?iso-8859-1?Q?47l7sx5p8UscNOeL8gMUZWEb85Xtvcq5AAOrLvIt0IDZHKf+ZwMWPP58hV?=
 =?iso-8859-1?Q?JHdnliyEFqRP4KY0tYqcgUYe+OzFEasaxOtetyp+rgImPO0/epCL5H1jEK?=
 =?iso-8859-1?Q?HHxS7Auqm/pnUszl52qqY6rTgkiMIai6aNjWytOlux76QGhgcw/OnAZEb/?=
 =?iso-8859-1?Q?nQNaQ8iZyIx05a9QL6h5H6I5fiDqjmDFfDNs8zRPMP7mU4zk14eF8CrxVs?=
 =?iso-8859-1?Q?56TcVgbpNJq/4G1bHiWa+Q6bmxzrU73KXxPytD/vZnM4FpTscDCYhuvGLv?=
 =?iso-8859-1?Q?xSk10vSErnPco=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5c1ba9-b06d-4c1f-19ad-08dd49b5e779
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 09:32:57.7318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANFcjpfI00/NGwteQSWZHi0OoLudW+0XjDEf7NWrUMTZ5QnLfU6PjVYclqsvGFkWvy3+0qEOcvlTpfZwXJvNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
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
From: Alexander Kozyrev <akozyrev@nvidia.com>=0A=
Sent: Friday, January 10, 2025 12:34 AM=0A=
To: dev@dpdk.org=0A=
Cc: Raslan Darawsheh; Slava Ovsiienko; Dariusz Sosnowski; Bing Zhao; Suanmi=
ng Mou=0A=
Subject: [PATCH] doc: document hash RSS limitations with CQE zipping=0A=
=0A=
RSS hash is only fully supported when the Hash RSS format is selected.=0A=
Update MLX5 documentation about lack of RTE_MBUF_F_RX_RSS_HASH flag for=0A=
some packets in case of any other CQE compression format is configured.=0A=
=0A=
Signed-off-by: Alexander Kozyrev <akozyrev@nvidia.com>=0A=
=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
