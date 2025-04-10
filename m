Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8ACC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 03:49:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAAC540663;
	Thu, 10 Apr 2025 05:49:24 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by mails.dpdk.org (Postfix) with ESMTP id B2CED40288;
 Thu, 10 Apr 2025 05:49:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+SasDwoo7pavBezWKhPAJoixzItNUXXpWQ7vXbuzk4k8EZVfhaldwHS+9N1EUSEL7qRaArTtMfGQXAKqvK9sFLbEdbKaZNJKgk4EicQjcO05VoDTiiVp9vvrhRGOVgPO/VLCELr4tAGeTDNZPjDKjTAkjgy0YihDUMHSFWLQdNGzWqF0Sa0ojaS6W6F5gkSyIOnTKmgLKA14KXHhc5X/chi4fuq4Dyjl1c5+h1QHGHxhRrSalZWTrWXJW7bIdQszmdFXMrJtRTZ3hYI414IDHl9Azlka2t3p+m7L5ldh7wo3W+Fpd2k+3yJA8lxmBjzA9Qn5BqqsApT7Xu/dfaMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0evwX72pkatVgbm9PKCoiIKGcTeZeQahy+X7YztoVs=;
 b=GeUVS0M6SJiOo8WF3+VGJM8OblWOaGft2WsVztTQuHOnNmFoQWaOZ9cVGeFmeb44vEByiJ1ptLn/zy8SIPhmhDNk8SgA9amQvzDuhmoaMZlFFWPz4Lq/k/kfuqHowXMhv3cG3lfKmeuw6FHRIUmXZQonhq/rgPsUFlPJA7szMyTlqJsoKkzs58hg5dQMrA1536lnJKZ7C6eR6sT2CeqUpiCuCaf/G8pdUu+7tZd56aBZa+tX5Aym6b6Hw2BzBcxGcteLEn+sWLy5395EBMjK1f+Z5kZFOgU13xQc39FK6iXPaGboJTx5gXqVrCl7G1iXUOloy93qNaWbQSw6tvXtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0evwX72pkatVgbm9PKCoiIKGcTeZeQahy+X7YztoVs=;
 b=jtGRcRIIE9H+G01vplNr3DN1c8M/3/r2YKR7AtGa+c3XTaSwsQX9U9Xqixv1w0MdN6Elbz0CggTSvqGA7RTimjTdHToM+lUEub3HVwJoIF+eulF0RSmfGLW0p60vInaEN1bgIvHOenpaAzGwk2ux32F0W57Xo79BCB6jRGZlYAc=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 03:49:21 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%6]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 03:49:21 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: Stephen Hemminger <stephen@networkplumber.org>,
 =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>
Subject: RE: [RFC PATCH] build: reduce use of AVX compiler flags
Thread-Topic: [RFC PATCH] build: reduce use of AVX compiler flags
Thread-Index: AQHbnap+toVmyOb4LkGBn3uRVxEYc7OFmwoAgAAdWwCAABSTAIAVYZ0QgAAb4ACAARD00A==
Date: Thu, 10 Apr 2025 03:49:21 +0000
Message-ID: <PH7PR12MB859635945A7F4BB864A406D182B72@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <Z-QposchDMAmn83I@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB76@smartserver.smartshare.dk>
 <20250326122036.6cc7c02e@hermes.local>
 <PH7PR12MB859614316DC742F0C8A12B3082B42@PH7PR12MB8596.namprd12.prod.outlook.com>
 <Z_ZagNDgzV-yl5dy@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z_ZagNDgzV-yl5dy@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d6774ea4-862c-4a21-9455-74d3fa98e582;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-10T03:48:14Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|CH0PR12MB8485:EE_
x-ms-office365-filtering-correlation-id: f00cc195-df99-4c8b-c422-08dd77e2ad72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?d7YEPyN3Nlejl9uX8gKqFO9sRm0ZdRd3Hgaa1g1XVgLl6FXKFSdSuGPT9F?=
 =?iso-8859-1?Q?dUzdK5WpQSmqpB5IWdmD4DUXj1g6uNKnkepcxBNx4DCLhNaFjYkErwsXJJ?=
 =?iso-8859-1?Q?h6OG2wVHoMfDZ2oybmUBumIARTbAVLwW5sV4gRgmpikf2DP+mosgacIqj4?=
 =?iso-8859-1?Q?m8mEM8k4X+9UHiDVPandbVjUvtTBa6rNIDcQXjGoffT/VmmqqcGZeO5Ftk?=
 =?iso-8859-1?Q?9OTXQd+21FmM1gDtGFKKMzzgWymgoQTwRpBn5BsrkGt68XRs6+w4NRmfht?=
 =?iso-8859-1?Q?AQw7R3/lUW+VtXWCIWmVAfxrwCJz5yOpewodk+UpEVuYCYdBqyKHzXr8Vu?=
 =?iso-8859-1?Q?26yDjqlbrYcRWdIYW/STlitM0tZFvd7LLjooqIVdNGjI09lKJwL6kiuSOO?=
 =?iso-8859-1?Q?Umwimtm5OKSmgLxyHpegqCTiw+fFZHY8enpt+PFf9Rn/VBqQcZ+DWr18iK?=
 =?iso-8859-1?Q?EYIIH/g116JXOp3w9UlzRRmfqE9t3idm8Rly8gj0R8CgyCNRmHxaaWxomV?=
 =?iso-8859-1?Q?QWpeme4u/yXCanlYM85974HITkbw6vjIZFCdOn6R7MBxIu4sQWmghUvJA/?=
 =?iso-8859-1?Q?FCn6q1bxShhbJHAll58ZC5zAtjKtJ8ehq1m7x+CrvWrSnwqFu6JMi5UGXb?=
 =?iso-8859-1?Q?ZJ3ToNf8i9K3+YbvXSQTxcZtz0GOfLbDKcPOr+pKWENSqkpZStzxwyjbi5?=
 =?iso-8859-1?Q?H6RNxL/LYCry2qZ1uBDwGz8oyKAin09jfVhkzLqc4uXClqZFJiCd/hvz7V?=
 =?iso-8859-1?Q?GJ7zIx7o7cZqbyzQftTmxfIG8hUKmIkB1xz/ibI9BD2s64/MeMr/ewYPDK?=
 =?iso-8859-1?Q?h0ep7hpx21yin6ggfq1xPEkoLjl2ydwrT864Ae10Nl8snXi/0AxO5LkZWN?=
 =?iso-8859-1?Q?WFpuJpe2tDdN9eRXHWWZ0Gnfn7pmJsG94m2ARic7RfBKlP0lSTjXVyRayq?=
 =?iso-8859-1?Q?p1j7uZ5ozhiqZlnHIE3ISS0KWd6xPAvyqdq436XaEpVMRzQbxBFEoV30VE?=
 =?iso-8859-1?Q?eEA2WmbMcYzpTszZPKOuEqJeLCGtmOGUdZBVoS7JzPG1sqVwH+zhjZ8biR?=
 =?iso-8859-1?Q?bPCNHMQb6L01HwWF/dBQjDrOKibEW0niMXH59zkgmfG8cJunk2CsL+3Fst?=
 =?iso-8859-1?Q?T+SQGuajg4UZWTlDfHWjnnHu0N6a+GMD34Q0MXCPBEkDitgydnIzqvObUp?=
 =?iso-8859-1?Q?vUzIpHiUJ6i9rOJrlOGHZvwlc3uJbNsGfe5QGuCjNayzBlYfNqIQVLulJI?=
 =?iso-8859-1?Q?LcM9nTVAsFZvDt+kQjr1AHWKa4WT2+gUBCUmj220kjRvk/bLrEcy/2nPyc?=
 =?iso-8859-1?Q?Nwtz84pb8SBWrEaNGu26iD3h6A8dpCHXXrVu5xPcvHjyEZlqBhso9j+34t?=
 =?iso-8859-1?Q?kW2ER9qoohAP77j5pYq0VqqiumioOKwglAyaRD2vjfqJed5uK7O2mlI5Rp?=
 =?iso-8859-1?Q?A8OUnKGBWfyblfeBFwuFvwzYGUDfM5T1kWBGMbBMovVSqFtQB2MeD9mUj0?=
 =?iso-8859-1?Q?vGwhK+3p2fmMDRWHXchRynTt5XdURqlPzpMQ4GqP6ftg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iut5OZpaaqUDWeC6CT2JWdypQf1NJuB4ur2sB5XRAYepPKd26DnizEj/uU?=
 =?iso-8859-1?Q?aILkhBLdzFoQctXwKEmPyyt8oikdkBz1jl1LsHzg9IQXJ1kxjWYOANKGoL?=
 =?iso-8859-1?Q?5Cu4DzPiqfdRv/RRa8cuLfkC5meSc192VzcXaZf12feY1MxTNOGm1AYMZz?=
 =?iso-8859-1?Q?IVt5VnRczkbZd/+0Qu8rLVz9+jgklIyc+ZxrfMBbRZ6sAcF3DypXS1b/1j?=
 =?iso-8859-1?Q?gsdtkNeewQnAcr4378aOizyJF3C3ZCLP/hAnYtVlaCBYeujzYHPjTtuiUW?=
 =?iso-8859-1?Q?4C351UB8RwFFXVUhKUDGpbeOaVDBESM7K41qgJ0AopmCKd/f0IcoDi3OOf?=
 =?iso-8859-1?Q?snwiLt9tqtxS4WOlXdBfAP3tVO/Kn2Rs71qfO/v18qdK/HeD7rMsUOVn7s?=
 =?iso-8859-1?Q?DqcVPXrs11DTKiVHP6OvrOW73zhDqT7h3uVToaE4L9zrye9sKNLqZZ16UP?=
 =?iso-8859-1?Q?LQm0Z5aY2bsoZxCBHoyqcGm2i1jy92jKDoTBs1FcydVL5H0IcML+1Bj/bf?=
 =?iso-8859-1?Q?YWYZEcJeYDNCHN/FbKoyDAOr5h/wVOmps/1iqd9JeS/gGcmfSyR2b2TksM?=
 =?iso-8859-1?Q?rfEbPJ/dLdh5MBMg+Xx4sThsg9lALcgjXuMiOese/a8w/MBN9Y6WXdkG74?=
 =?iso-8859-1?Q?QBMK0wPeeRhxmGWRpKvRPvfLRi2a2r6W5J1GYDsnnbgLkOv0+8kRZ2jDCS?=
 =?iso-8859-1?Q?0ctcuxkBwHOlt/z5O/mVWJ9BIXJvvfC1F+aLuBhuQSV4wSIU/y0ijAhqOq?=
 =?iso-8859-1?Q?NStKhzmHSmVmZ5L4hac+ECiFhH9fS8o52D8ITU3/vj1CA5AYSMdcvfJwN8?=
 =?iso-8859-1?Q?4jaQRT93YxMpgaMuy1I7QddrVtMMX3IALurwFKoT59tShlT6fYgLlMBhNj?=
 =?iso-8859-1?Q?7YN70q8QFyiJ2MYxtppgPRhoXHBCjqXxB97IUOuTTWAbHBbvOUitIPhWEt?=
 =?iso-8859-1?Q?KTNiabG46Dp7L7pqCfTAdae50hpZ+7ms6u6m1veZeSpjtUXqSfS+S7yVib?=
 =?iso-8859-1?Q?hhgjG5rKoHh+iiLsyRl28y3YqBu+RaXS9jmTyLsIUpsZ5ZXYshuAX4v1Ow?=
 =?iso-8859-1?Q?DZD7Erbsteg9uxweKhmgOZbaf56hZlsEUa2767Qmwu/TFIqXv6hG4IjrMV?=
 =?iso-8859-1?Q?VYAgOCf3bz66YSpM8t+7PtvDs0hntBQ66M4fRuXe23MpnQJr2SHWvUx0dO?=
 =?iso-8859-1?Q?bnJhhGeLeUkowcAETBLEucuwIC5Vgp+45bwelyhHgilK5MYmH5ojL5HVSt?=
 =?iso-8859-1?Q?v+bg4nQWxqXXvBXkJWHMOAkeLU4xhKqxz2Ez7itHwgbV937Et9D7W2vxfq?=
 =?iso-8859-1?Q?qBzTq8KKnG+0yOpQHXtIjwWWpKObFmXcE73S24vqGJygiTFL1IvncPZVsv?=
 =?iso-8859-1?Q?XbZHkysP95tBLnxqAURlHB9Ce8dXTiBAptXD9sU0WijEbRRE+NHdjy5hPr?=
 =?iso-8859-1?Q?1kq1AYh06JdLbsDjxgIZxgljwxJlw1jDBIj9orSBd53jG+StbH10RPCPUD?=
 =?iso-8859-1?Q?NPBNzu5y4aXxxiSBzEIP3WpsGOW9c7JDRWil5Sx400y2Wi78DOAyE160+a?=
 =?iso-8859-1?Q?L/3Yiu7yu34hJa4DcO4ptkUVYLw+/VyWLmxppcplqxmXY5HUED5PVm+opj?=
 =?iso-8859-1?Q?yE8MiKlj7ZVaAoI4gsaZAe4WUvrmfubAxF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00cc195-df99-4c8b-c422-08dd77e2ad72
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 03:49:21.2390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AesI7s0C4SaCNPdCGPaoxt2WQW4fG5lMOUPcrqEtHZvhAin7wGOtrNXs88LKqQ+rOrqKYTZ+jVc810rM+03NMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485
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

[Public]

Snipped

> >
> > > > > > When doing a build for a target that already has the
> > > > > > instruction sets for AVX2/AVX512 enabled, skip emitting the
> > > > > > AVX compiler flags, or the
> > > > > > skylake-avx512 '-march' flags, as they are unnecessary.
> > > > > > Instead, when the default flags produce the desired output,
> > > > > > just use them
> > > > > unmodified.
> > > > > >
> > > > > > Depends-on: series-34915 ("remove component-specific logic for
> > > > > > AVX
> > > > > builds")
> > > > > >
> > > > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > Hi Bruce,
> >
> > From AMD end we have tested with gcc 12, and 13.
> > We tried cross checking with and without patch for libraries such as `l=
ibrte_net_ice
> and librte_net_i40e`.
> >
> > We did not find much changes in the assembly code generated.
> > I hope this is expected? Can you please share any pointers?\
> >
> Yes, it's expected. This is a simplification/consolidation, not an attemp=
t to optimize in
> any way.

Thank you Bruce for confirming, we are going ahead assuming this is correct
.we will run for any performance regression at our end and share tested or =
+1 soon.

>
> /Bruce
