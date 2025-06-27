Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5DDC7EE32
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 02:05:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5F46402AE;
	Fri, 27 Jun 2025 04:05:20 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by mails.dpdk.org (Postfix) with ESMTP id 1632C40283;
 Fri, 27 Jun 2025 04:05:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlEI3SN10O09WEL+Ea4IR92ePwpTwH74/K911yXqFrPt4IcCFk4eJTrEX+G3kXVm92fbne+3GUS0/om7EjXBS7R4OQjQm+SyfN0n7Ygg3wA7i9jL58h7uBWIzsTWA27s8RJpMo3K/JA4UvowvydJt5yDTsh53GLSwofMrvC9tPS082kkL5i+YFvCe9T645J9TLlBarV/D/uC2mkqohcfBoqZkhFLW+GyXSufMcLpYJO4hR2HxOEZIIUHoCBAxe3cT1b8R34KKaJP69swGcZqxHnwCTG1Zyhm1WRFDXtJ7/0/AVsysWdrVpUbHPSAR6kt1wgKB8L86IszmIJAtYDzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtUd8v1pSburXy1HhW8aJMbUQXvF33ada4bPdSaOemI=;
 b=fDNGh9yw70pD4Ae88xajoye8WLQ/lXG7Jjy7LLVRVYao1Iyezf5F60v/Er8FK36Nd0d6azDptbvvsdHu4a86EgdCLlcNw/DRgmD1ydTvO83gxAo/nbALKYAey41wM+mI83Jv3lXxRs2uVxmBIE+eCOC2wOagwg9rcenYlViIg2elCMrgQ7VS8sHwxbJh/iyulh9yYxHH1ck4KD6JzLdv8RfLE5uNrpVay5kKDoP7mtQj59YcAFEdRdZWnOf8ot+HWCOmr+g+MmREeBIRFUzjakSypBx1OyNETt6yPDEJlS3/2L73oqyjKcLRriPiVkr6/LHs7KpmPWd6YqoN7F8Lsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtUd8v1pSburXy1HhW8aJMbUQXvF33ada4bPdSaOemI=;
 b=MpBeD8Gj6HcyksCs0qlwYMaq7n7e6gFZcT8GhrkgS4fhVTmWl21t/nqSqnm/0Tc7jUZb6PB4+o7ViK80/sgBujPxleKxD/fVmxUikd8av+ch4fghk8ktFyLNd7L10fb+WcQPSgxxij7OZVV3E/dHleC7x30avJicAFr6L5q7Q+0=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 02:05:16 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8835.027; Fri, 27 Jun 2025
 02:05:15 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>, 
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3 1/2] latencystats: fix receive sample MP issues
Thread-Topic: [PATCH v3 1/2] latencystats: fix receive sample MP issues
Thread-Index: AQHb35j5h2KFwSmgmEiRGtNbIfhR77QTxYQwgAHRn4CAALjvUA==
Date: Fri, 27 Jun 2025 02:05:15 +0000
Message-ID: <PH7PR12MB85964FDB5AC5A6C86D60FAFC8245A@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250613003547.39239-1-stephen@networkplumber.org>
 <20250617150252.814215-1-stephen@networkplumber.org>
 <20250617150252.814215-2-stephen@networkplumber.org>
 <PH7PR12MB85960D943C91FE608DBA4C2F827BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250626080117.24bb3cc7@hermes.local>
In-Reply-To: <20250626080117.24bb3cc7@hermes.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-27T02:03:11.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|MN2PR12MB4469:EE_
x-ms-office365-filtering-correlation-id: 0257b6ed-ed39-43c2-e40f-08ddb51f0f2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ws04XWc5DPKpwOxP5atBRRmqFiSj3e0m/Ce64AxwZL4ojHdI4+tJ4o+gCt79?=
 =?us-ascii?Q?sYv8UA3Xz704UOsSVj6bKeJUzFFBdW05fpYahvGRfX5ITLAddT0U7/ygFG1X?=
 =?us-ascii?Q?ni9B6LLqEfUIwylH7Trf1Tz7mzZIXqTAHo25VEbTPTJGKjnD0g7ORU3WvEn5?=
 =?us-ascii?Q?RXIB7w2jbrgplTYYbfnVqF5bqGoNSm/y+TKyv1NBVefgePD4UO7h2Co2PvIm?=
 =?us-ascii?Q?M7JoGVe1ELWEqHgeysU3LYbct8tRGc4uxvXiivNS+ocL4BbFqWSpKkVWvlo3?=
 =?us-ascii?Q?6G+MrEUdIHT8IBv9HsjdcTVqZW/zUfQXuxTyT4oPUblT6ygLE1fB6LZLRcis?=
 =?us-ascii?Q?7VdAih5DXbtmWWYubz2cg68Y5WzWarHc959sMdbqH59jXecZI9MxWGu0pDQO?=
 =?us-ascii?Q?XiDLncvTAvVC0asDprU5GLkyMAHJT46kQU8u9MQye15uDkcWhwmW8aEN7u20?=
 =?us-ascii?Q?socYn27UrDs96SrZarg8PSsNLOubIQ30sSAkeXPnwsfXFPeYPJixhx2XznbX?=
 =?us-ascii?Q?06iZeeqYsnrzTeJamlY8JUMNS0l1KRRGr1u+0toTkZo03EuGec01w+b//HfR?=
 =?us-ascii?Q?/owRCMLELM8DlCmLvBSE1xxVcItgf6FBckVMw3kMUeAa6mQGsuYGDNCTzUeO?=
 =?us-ascii?Q?8FudA10C+E7LYRDx11kyHE3cXyL96FTxK03rYH52Yc5STkw2sR9pm6YEF7cP?=
 =?us-ascii?Q?/zhYoxGQWb/1nbJt0l66gIrVQ3YjkbBmbKI3vAuQqY/CShqhpFeyovs6PEXD?=
 =?us-ascii?Q?bSQl1PopVbDCGUblzoUVffduyg32skKun1GFCq1OyC5dV00h8/URWP8t/tVy?=
 =?us-ascii?Q?Xwrw24QGbrj2jYfUI6ecKYWrc+ZSRFfuST3yR6nXnAf0YZQdOMcQcOGVDzLY?=
 =?us-ascii?Q?OErLeKUX0n/uW6KoesH+xhrTCQ0H//lKC5o0dTLdkkc597MFcc8JT5Ebm8f8?=
 =?us-ascii?Q?teRZPXWIg3WMLAaXauJrOckekPTohX6Tyo/1YAZpttdHnBjhAiZp4BCUBQi2?=
 =?us-ascii?Q?ta0qxHjnVTELDVh1GnzfBPKlkvvfz/rnMOOK7kvBSDCUvnSayiTw29tZglSA?=
 =?us-ascii?Q?JPXBK8GX03jB9ubapCerEoOngoMb3OJzVCfVSHa2HVh68nIVKQ2cV0t7reoN?=
 =?us-ascii?Q?Qydy8RuJGFjjk0hiioue/o7gY5gQ9GVMCoIgh0lNQqJdeMlGvo6fi3kmgHRZ?=
 =?us-ascii?Q?5R8z9WdLtCACgxYQNvnsCyA58eUZSGeWc4hpH6G5YmLd7rI/PIlFhrdWoXpn?=
 =?us-ascii?Q?Ba7n58jzODlXW9/fHdgAO5fUwJQXb76qfrpjIAqLx6/JszZe5prY0v2tFCna?=
 =?us-ascii?Q?P8gxo9KvVXT8o4XLwa6mrkkfQXLrtRLf/cNl4J/U1gSi1HyubP8oGQMHBgyx?=
 =?us-ascii?Q?2NRfLSBdgrWvO2fSkDo1GXF2VabOAWt7kqvZZd77Ha/qCLUEmg0dOIdYORg4?=
 =?us-ascii?Q?EirATCqhhABPV3Tt8Z2lyhYCYBbACPGrBpo+m0rbCNuPV9k2NCnxewF7yoM1?=
 =?us-ascii?Q?/oVOcXHJXCrhbPc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?djQwdmWjKmVEppdhexpstdB7mbh8Px9o56Vn8ljhzuyFQJMHIN4T6dFC0naA?=
 =?us-ascii?Q?Mv57FrYZnR9BqlJ4FhNl1QuJdnljFSeJJfj6vmT8xCRDdirLg8nNuJFlG9KQ?=
 =?us-ascii?Q?4Suulg8u7L9zT3hfpLgnblHR2qWqnufnBVreQ3ufkb0uf7utwUfFcfaMkw9H?=
 =?us-ascii?Q?ibNmUsNldH/V6igODfsEqeuGB2h4BKSHeWmV6WF9Y/vi4nyVFP646bx+G3i2?=
 =?us-ascii?Q?ON8fOsnX9ahFwgwLC2A9r6w2qlPyQzhamvfAIs3AcHSDOZ74jN4T3IPXsCeK?=
 =?us-ascii?Q?odUrlY0qR4KWoilZSRc9BdMgj9mporH8sDPPTBXOh9QvWOve5rZyPB+mB1WY?=
 =?us-ascii?Q?tf+Z668P8v3aYmPSiakXshGXvn7RGUOPRs4VdCkEzHooenLj4HS6CVEcUM00?=
 =?us-ascii?Q?7zHRa4NHWRBxIbd+FGqH950eLDyIE5MkobNu08XMjQ79KHOmLKfzIYgeiaD0?=
 =?us-ascii?Q?vhue9cOqF7BqLAkyXZUS5CkYS1EeGceDBh0Q3O4S7vPBXDpAchB6aKNGuf4e?=
 =?us-ascii?Q?BqZRFCfh4MXP1ILY9xGYwXOeGT6IN6uZhnhhLxxZLX8P0KkiJAxTK0mRJCAN?=
 =?us-ascii?Q?OpLBr4GzB1X8LaG3jLz7a8zC2kPtw5e5dJ/LURYPkeuFQmgh5BQREQUKhJWP?=
 =?us-ascii?Q?ndZGuD9D690sylcJbBo94IJeGEvqIq2i6W0mmto20eKT9X5w4Pu7E9yGWRta?=
 =?us-ascii?Q?21J8VN1yB/x+vP+2Hvd2F7p6sKBQxRaewzrkvZuueVw25MMRc1nW09Vfi5ZJ?=
 =?us-ascii?Q?ExmqmLxkSSIlV8SInaQUbewU1C7sJ4EfFz0YOOHeBk1uV3iGSiwMhBMaMRR9?=
 =?us-ascii?Q?TRfFC3Xh48P6GIcV8J5TGgXW8bZgOJG9eoVsmmP7dtvsxYoVbQ32SG8ERl4L?=
 =?us-ascii?Q?AIEfqgCB6zmzsMpSqVVhaH7gxCGXUMVDQRvhcBDlNNuvNMkFpC9+IZHfl1Mc?=
 =?us-ascii?Q?3jk/Nem6Md3Uf7XxX/lN/yNHiNglmZ7/Dq/NpZokaiU+gnFd1hVRWzBGLnbC?=
 =?us-ascii?Q?mgsSFpllWNn4i8fDXDrYbdHoXlIDAgii9ZNqnRibHkkmBRYdUlUYbnB0mffd?=
 =?us-ascii?Q?qA+7p6jjyBxG7h/x/ZRojeHVSdLrbTmj6jHTizgYVFf34e1Wj4OCyw9gvxYR?=
 =?us-ascii?Q?zAOfZNX1BI0JKdqX4sj/42EOmI5cAq74EMOFfmqW1Ju0/DioeG5kqxBhYUEN?=
 =?us-ascii?Q?vLVxEuqqVOdkZc8rFjGz+DVNaRxbvnryTJkrip539uS4AEka5U4YgGtHzeWe?=
 =?us-ascii?Q?5lUuRLsIIqOzLOHSDAAKH8darsVKa+uCOJRsjX3Z0G7jpoN18FQFpkHf/S4z?=
 =?us-ascii?Q?eeMt0WpHhRrH2mxH16+6+n4vrthYmoflCYa3fZFT6zgs2lvCC9l58QKM7oUw?=
 =?us-ascii?Q?5ju7f79+aoVSszNa+oUZ0ica3DP9LI6u6Q55tFFIf3ZuHmKzf8mfmwX+sleM?=
 =?us-ascii?Q?BjxEuWvc8gaT8kRfBM1fF/ThPsdWd7EiqYn6IWgckkw+rtfxMUzxp6prXc7t?=
 =?us-ascii?Q?6yU/VZFCejBVhmbbiPr+SsWOcRyNW8S/n2HxyZuzrjlQ7UU7YGmhL7P1gYdV?=
 =?us-ascii?Q?sWVGOF4kC2xDefJB3XnW6vdiomtjueI9TYWyVW0l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0257b6ed-ed39-43c2-e40f-08ddb51f0f2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 02:05:15.9060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iiYTp5ArDf9XuEiHLOxWZS3bOUztHoK71rquZWKXFDmXuxtUhB/5xBBQNZ5bt8FtyJyGv2dkVXbRvuAwutSlzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Stephen

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, June 26, 2025 8:31 PM
> To: Varghese, Vipin <Vipin.Varghese@amd.com>
> Cc: dev@dpdk.org; David Marchand <david.marchand@redhat.com>;
> stable@dpdk.org
> Subject: Re: [PATCH v3 1/2] latencystats: fix receive sample MP issues
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Wed, 25 Jun 2025 11:31:43 +0000
> "Varghese, Vipin" <Vipin.Varghese@amd.com> wrote:
>
> > Following are our understanding
> >
> > 1. increase in multi-queue latency is attributed by spinlock.
> > 2. the lower latency with patch for multi-queue is because the lowest o=
f all queues
> are taken into account.
> >
> > Question: will there be per queue min, max, avg stats be enhanced in fu=
ture?
> >
> > Tested-by: Thiyagarajan P <Thiyagarajan.P@amd.com>
> > Reviewed-by: Vipin Varghese <Vipin.Varghese@amd.com>
>
>
> It would make sense for the latencystats to be per-port/per-queue and avo=
id the
> locking, but it would be a significant API change. If you actually use th=
is then would
> be good to make it better.

Thank you for the update, we were thinking about measuring latency stats wi=
th RTE_FLOW QUEUE redirect. RTE_FLOW+QUEUE redirect is been used extensivel=
y in Virtual Ran and Packet core.

Hence we were inclined using per queue latency stats and jitter. As per my =
current understanding this will vary from NIC to NIC depending on ASIC and =
FPGA logic (for fixed function).
