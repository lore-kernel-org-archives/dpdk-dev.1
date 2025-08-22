Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA30CCA0EFA
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 02:48:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA4AF402A2;
	Fri, 22 Aug 2025 04:48:10 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 95FD840292
 for <dev@dpdk.org>; Fri, 22 Aug 2025 04:48:09 +0200 (CEST)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LN1ZQ4032751;
 Thu, 21 Aug 2025 22:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=j
 8hr82Zmi9HcMEBTevu3pWhAn3g9dduM6FIQqkf5IZA=; b=COhFaYJgwXCkIal7E
 lnYojndGuT3ZjKshsFOESYGDyGe6kEU0dErlNA58GmfqIcw0/4JjTm8uEzaVenPu
 0hGXtmObBpKl+I/k0oCcGRtWD8Vx1oJuaIwrrzpErq5RTaD3XjT+YvKwY/HoQ1XP
 r/tsoPI8zfiizVhFIW/Xa0LL/YvgW6BzxPSk46DDP74KdqR/HGwBzgXaQqebkH5c
 nNvudqTisVnwI02l4mSFy9eiAsZ0AkXdYksBDx8eelBch/KO+eL/aemPEJ07hwg/
 laLItiCR1k6c1lWMEZ57hJIu4TbY9ssxX2JHG9RLYXorO2Q62z7vNK7PIlJDB6OA
 iqWwQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 48n0v6pt9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Aug 2025 22:48:08 -0400 (EDT)
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LLIuS9023631;
 Thu, 21 Aug 2025 22:48:08 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 48p6gtf4ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Aug 2025 22:48:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+hNMtkmDEko57twuMfGpdWnxyQf3RB6qaarZ+DDDsGP3h64NiunmYPLisEnXtE5N+LOc19yPjMQ0ZnJISipRiW2uqr000MPzPtNJD0WYm2kIkkOdYiZI/+ZCC+tu66XqlqNcbxa3Sdtsj24JSLmYokLbXuS0jPPtSjOHG27/sJyaKHFmPB4F9yUrU0UGyFTUgKAm7eMQHtHUFjTN4h+ROIZjQgCBtcnzrM/uYKX2rwZhmMUJt2xXT3QVuxIj32F3ypucV3c9c5rKX1pCZ3Sl+Mpg3uAl3Ow80uxeFg4TYNl7pOpI67qDiwbegutS6xdh0PmVa5zVxYRygG4i2IjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8hr82Zmi9HcMEBTevu3pWhAn3g9dduM6FIQqkf5IZA=;
 b=eCwCmbIEE9Rg3ZnluQ7J1JQh4DB8+0KtuCg4aOs4JnvuxFPXrOZcLhb9SRVq9z7WBYeO1EjoimRnpjNCpxvavpszOmBLTo06oSouuAk6hiIlZRMy6NhIPrRiktjRCrVvyXBFFiMCLclypw2LR8vliQh3982jo74UjsM3zk7KY3+Y47/Vyny6/NPLKvxI8Pmzcgo4xhMSzByKYzgaW9rL1JYxo1kE4Tw1GMzo/7tAYbhbZGbg5ulxZ9Y2dRTOBx0/DmekCrx2Mxd0+Xp6ImnVZ9uApYtvlnp/UOnwMiE8kYqgFXW3eXLbERNPDQpi8XDwP7j/GYfAq+TYOJE7eLtbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by DS2PR19MB9220.namprd19.prod.outlook.com (2603:10b6:8:2d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 02:48:04 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 02:48:04 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pravin.m.bathija.dev@gmail.com"
 <pravin.m.bathija.dev@gmail.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>,
 David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH 0/3] vhost_user: configure memory slots
Thread-Topic: [PATCH 0/3] vhost_user: configure memory slots
Thread-Index: AQHcCzGgtkGye+sTHE2EwlyJqW9UY7Rp5H4AgAQgPWA=
Date: Fri, 22 Aug 2025 02:48:04 +0000
Message-ID: <SJ0PR19MB4606D8D898219FE2296C7FB4F53DA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
 <15537925.JCcGWNJJiE@thomas>
In-Reply-To: <15537925.JCcGWNJJiE@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-08-22T02:36:27.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|DS2PR19MB9220:EE_
x-ms-office365-filtering-correlation-id: 634b4f4d-543f-42a1-cd74-08dde1265185
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-7?B?Y0l4cmFmS2tpMW1QV2F3WDc1TXJqUGtDNjU2bWd5WHFLcXVmOWJmSmM0SGw5?=
 =?utf-7?B?dmY3cGUrLUJhU2ZjKy1WcnFPMUk3NDZTeHdPbFNKZGFIYmFTdlJ4RHNwaC8=?=
 =?utf-7?B?L2YrLWZuR09QVnVwRDRURGtDaWRoVzBQMmxxdFo2VEZ3alR1VjdXdWNtUDhH?=
 =?utf-7?B?ei9nSUl3NnlldlZqZ2JzTkU4MjFMeU1RNGVuM3lNbms0L0VzcnphUkZKSFlr?=
 =?utf-7?B?TTJYeFdwdlRGa2R4bXFYRWh0TTBmS1VDcy9pT2VCaTNCdWk2RDZLVTlkSFNS?=
 =?utf-7?B?R0hnWXhpUVJCYVU1cElDWjJRaUVIUHhNOG90SGZCUklyZVVybmRuNjdjdjJz?=
 =?utf-7?B?TEFkaWsxaTF5MjZGbVNWb09ZMzluNEJVSWNRVW9WbnQ0Rk9IUHZ4eEJ1Z1k0?=
 =?utf-7?B?Ykc2NVFiM2FEa0M5eld1NmVnZy9aRnBFVVcyRkxyaHhxNFRZZGpua3QxbzVj?=
 =?utf-7?B?R3RyY0FlNjRXMmR6MExVejV1bGxUaFVOeFlBZkhlUzhZdFZUcW51VHh2Y3p2?=
 =?utf-7?B?bHIrLUdySjVpdystZVl2Z3RoYXhYSDM1RystWTlFQUJ0WldHUWxaNlNlWnpx?=
 =?utf-7?B?LzBhY1NBSkxnREo3ZjN4VU9jVXZkUy9SSTVjNjllMGxjdE5mOUZHL1p0TGJu?=
 =?utf-7?B?MnVXYnh6azRTSDFoWU56OWtrVGNFVEtxbmZveHphdUp0T2xEQWZnYnZpUUQv?=
 =?utf-7?B?MUphN2xWS2Z0a2dyYUhkbkFvanExdnVrelp5b2FQR3ZBWGE2TGZNbEduSkF5?=
 =?utf-7?B?TWVWbmhKTkVPbnBzUzRWNnRyaGtHSDJELzg3UHpZd0dheGhlcGlnVEUwWE93?=
 =?utf-7?B?bzk1a293bEZKL01iTXRtMVU2aHhJQnJ2TzBYY3pkY09HN2R3TmJaTFJOckxy?=
 =?utf-7?B?cEJvV3JQYWN1UHJKUHdTZmlkaVI1MEZNdzl2dkM2WmkxS0ZKanVPQm9RWXlH?=
 =?utf-7?B?Q3k4anBsT2J0VzZLUDdpeVVFUm9vWSstRXVXMnc1anBhcll6a0huc1dVbjNT?=
 =?utf-7?B?YU5wKy1PNGxQTFk0WXhoWlM2cDNsV3JWTnN0QnJoWVBpbjJ4bTRUcVFCU29V?=
 =?utf-7?B?bzdLNmhyVlFkSnNRbHNma3dzQUE1MjdTcVRraHVscEdPQmY3T1loSXJoMSst?=
 =?utf-7?B?blE5MzFTbnlaajhtUlJqaVVmUlBPMDZsUHRYalZMcm1xdHBkN0N2VTc3SGJT?=
 =?utf-7?B?WTFKdEpVb0ZqaWJvUTl2cDRCUTdUZEltNm1PUW5jTUdZNEVXRUhwelVxNDBI?=
 =?utf-7?B?UTVRN2NaOTIzdWtDS1k1dFREZU81NWxsRk1vVndFRGdqL3NtNE44dnpVTHI=?=
 =?utf-7?B?Ky1ybzc3SEZvRFBHeU9mblFRS2xGVEdPVHdxSldQUnFwdExPUW05SDNlQXZX?=
 =?utf-7?B?NTVuN3hwbXJrbWN3d29ndjR0QWV4emN5aEZlUTBOc0lUUTRqSmw4dXNNbDVB?=
 =?utf-7?B?LysteWNPREpnVFliMkV1bm9aaDAxRUM1MGhUb3VNQXNjVkFXclNZaDN2RkVM?=
 =?utf-7?B?MzJGVDlLOXdtd0tDbUcxV2tUSDNXY2xBVHFyU3Y4Ky1KdTVlZHc1cVpnYUFo?=
 =?utf-7?B?N2Z3VFQ3SjU2OVhaSUdSNGcvL3pMMm5mU3YzYy8yOXcrLU82aEpVRTFDdEV6?=
 =?utf-7?B?akpJL0lRYzBGd25XdWJ3UFhzaVpFang0TEtHNkZLU1NXMmw4cGdRSEVKSG02?=
 =?utf-7?B?b1ZvSENaaURia29yMG42TzNNQ0h5SWpZRHNkMGJPR25aQjFFQ3N2ZjV5Ky1L?=
 =?utf-7?B?L1V4WmpCd0NWTHpicGxOaUFjbzRudjBuelFSU0U4RSstOVFZb0M5MTFIRUtr?=
 =?utf-7?B?VzZDWTZtTmFjSUNPU0RwMSstd2ZJdjVqa1NUbVEvaVVEaGNuZWNHb1VYck90?=
 =?utf-7?B?ZG1COWhxNUtDMzdjQTV3N3VUUUlpY3ZrUzBycDNOeG1WUEpXaS9nWWczQkJv?=
 =?utf-7?B?SGlza1AyNjVtMkFzWElneWYrLTAyWldld2M1YSstU2xoSFRyVFViQmx6eWYw?=
 =?utf-7?B?RThMM2VqQ2FYSDVDS24xU0wyKy1IZjNLNHRYQWtBK0FEMEFQUS0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?dFNoRG9OQTl3UystRThkRW15MzRlMDFuRUlXVHk3TmwrLTZEYXZJTmVlVUg1?=
 =?utf-7?B?R01QS08xbEFXUkVhTmtsUjV2T1pwVFI4OXZ2enVjbGdiNGlRUlVBL24zTldP?=
 =?utf-7?B?dUV5QUE2MktKMzZwV3pTYTBGT1BwZDVyKy16N0RLdDJVbTBkbUszTE9RNVVR?=
 =?utf-7?B?RzY5UUExTmpPaWpmVlJaOTM3dTRLdWt2cmxHUWZzb2g3clhOZ1pNYXhpMGx2?=
 =?utf-7?B?RnN5QmN1WVFQRU5IdENLck1mdnRwemhhWnJTUXpid3ZsZDF4aG55Yk1ic1J2?=
 =?utf-7?B?MGgvWXJwMXpSNjhoeXpiY2s0MDRLOUU4b2RZTG1lbkZNaElib3UxTHlza1N6?=
 =?utf-7?B?TlFFVUtTUEdhckZtSFk3QmJWVTYvME9RemkzZCstUkFrTW9SdTUxTm5idmlx?=
 =?utf-7?B?MUo5d3BLOW9iR1FpUkRBQkE0dXNwNmxFWWxlRVNRNjdXc2xDN2djV3hGUEpG?=
 =?utf-7?B?clJXQm0ya1hVejFpRXZjd2hoam8ySGRNZmJKYlM2R2J2M2dDZk8wOWxpZlZt?=
 =?utf-7?B?Qmo1eXI0SXNjSFAvYnNHRllEbmlwZ3UrLVVSUEs0TDJGQW5GRVBoNENhTUFQ?=
 =?utf-7?B?R094OEYyRENsMnFUSWhGMGhHbTB6RDByMjZybWpsaXFHNUhSTFNVM1FTbzUx?=
 =?utf-7?B?V1NLcmU5UGFjbzYyZjdBN0J3eUtWS1I3MSstVnN4R05XSWJDbGgyUVF2aUhP?=
 =?utf-7?B?MWtoQUVCS1dtVmxpdU1SSlJWY2FHMEJSNkJIekI4eHJSaVRxS1dHRG5SSGlM?=
 =?utf-7?B?Y1IxSm03NXBnaVg0LystSnlxVWl5RWtmWGhub3k5RTNDQUNLNzYvU1pYNUY0?=
 =?utf-7?B?NFFGck02UFVHOGZ6T3RwbjFHUGlVNTNaSjN6b2YvSVdidG1LMVR0TC9ndktT?=
 =?utf-7?B?cjJkZ052TlRXUDJJclhCeTRQL05NU2ZQemZoei8rLUJlcS8xNG42ZDVYR0NP?=
 =?utf-7?B?S0FEQTk0cU9nVkc4SmFySExvNTI4dHBCOVVKM3A4c2ZXKy1aMTV2OUo5SWlx?=
 =?utf-7?B?WmJDMWpNaistbU1JL0ZtV2JCNDd6Qk9jTzEzeEZQUE5Hb1N6WnYxVE1TNXZu?=
 =?utf-7?B?OEx0ZzRYemNCNU03ekxyWHdJdHo5cjY1NlpYKy1HUmRvTlVlTkVnRjZIYnh0?=
 =?utf-7?B?cEZnejFwZ1kyZFA4NXZqMHB0a3c2V0FYRktSQnBZYTg4Um12MXpwaGw1d2Uw?=
 =?utf-7?B?b0E0WHNwMDZZUFFaQkhTTk5JLzlmM2loRm5TTXpjQXZsaHJuVlltbThXcFJM?=
 =?utf-7?B?YU9NaWJPdXdhNVlZdmJUdmtnUkVBTUJEMFBQMkczWGpHdnBvamVtRlhBT00w?=
 =?utf-7?B?MnBwYVRTL1NwRVlLR1B0M0FKVjVDUEl1NmtyaDRQclpZVUFPSC9ZRlNPZFV2?=
 =?utf-7?B?bzREeHRhNUx6cDdIdDJEbTZxYkQyMkQ2N2NjeVdvRUEwcmFTOWcyTHh4RkZi?=
 =?utf-7?B?RkhLN0paUTd0Z1RZWkI5YkxUck5hencrLXpMVVNVTzNuT2VQTm9ya0lYeWln?=
 =?utf-7?B?Q3h1Ky10eUQvMzRUSUhUbHVtNm5Yb280SFBZWjY2aTAzRHJoNWdyMVJZbTE2?=
 =?utf-7?B?aCstWUNpenNJcUtEaWhKQSstd09DMGw0Q3dSZXhtN3BRaFpzZzMzYkxob1dL?=
 =?utf-7?B?eUdxbC90SjVYaThpZEI5TU9LTjlGbnp2TVk4bzNEYWxURmlGUUNUWXJtdFVF?=
 =?utf-7?B?Mjl2WkdnVHgyVHFjbXk5VExXeFZsdDc1dU1QbWYzeENaRSstN3NlRzAxbmhX?=
 =?utf-7?B?NlQzM0xoek9FZnFNUXErLVNWZDVSaENYNUl0TzViKy1sNWFvZFowT05UWUJP?=
 =?utf-7?B?RXI0Ky03WEJhZkR4TmduajI3Ynd5Rkt1bG8wVm42UUpHMEQ1aEJONWtweFRs?=
 =?utf-7?B?WDVDLzZkckFtRnVwcWVFdGV0TGUyRkJQMmZZb2R6NWZ3azBHZFdqZVhqVko3?=
 =?utf-7?B?UXA5YnQzWFZyTnRwd0g5TldsNUpyTzQzYTRUcnkyaDJrYmM2VlhmbDhFZHpn?=
 =?utf-7?B?L1FlTDdSZ1l4MWQxL2pIMXFIRVdGd0M1VldBYVZSRlZaaDBVT2p5L2lWMnB2?=
 =?utf-7?B?ZS90QVBCVDF0M2NIVjl6MjY2RXdwWHdaQ3lCMXkxZFVrd0F0RldFdGt0eGtK?=
 =?utf-7?B?MmxKYzdNaWdSQ04wdjlRZTdpNDN4eUptb2pQdU1xc0RvalF1cVhxcDNQc0M=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634b4f4d-543f-42a1-cd74-08dde1265185
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 02:48:04.8652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGzCZDoYmCsNFlx/fFV0PZkE0wn9dpgXBYY9zK5CLrbXfgnJ37EMvrJmyA59lM4/nVMI5OoDERX/NPTgTFPuNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=847 spamscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508220025
X-Proofpoint-ORIG-GUID: GO5tj10K8ySvGYwB2ojIzkloQ74vPECF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDAyNCBTYWx0ZWRfXzubaND6oRUHr
 bYe1c/c9O4bMkBeD7Z89ra36YNsrnptxqMPzq6D9YX1LYA+ViOPFmMYu3fLzm64gb4iA+2OYuQY
 nD6CICIiaj/FjKfDBerlc251BYRMbUU+20xN6cU7kmo8zhTvq9Uz0N2n2qkCbuhC6G4RKkd0t5M
 nFhmjFYx/vaYcH3GfT7WRE117nn63EktYtp5qBZPsQa6bWWI3AkNzem0SCu97SAHkGft8Ub6S95
 gQwrwMVjJLPzxyXFxNyQxbj0RH7LB0ZdAEkCQlBOmdttXEpq2+zptT/I15UxCHeAWKBt+A6yc3Q
 wQ/DLxQUlD9DHi6TobsozzTAAe3x5t/QU+s9nsb2LP2D00cbfFNiAjtiXCAbOgeY+bnJM8toL41
 iyDrlk0q/Cor6C/Ix/YtI5lZF5LOfCNLq7ZCuDzgCQMAKOHwYZt4+zOiOaeApb7/ghljOlJc
X-Proofpoint-GUID: GO5tj10K8ySvGYwB2ojIzkloQ74vPECF
X-Authority-Analysis: v=2.4 cv=fpiFpF4f c=1 sm=1 tr=0 ts=68a7da68 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=2OwXVqhp2XgA:10 a=bt5KbKNvAAAA:8 a=iLNU1ar6AAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8
 a=QyXUC8HyAAAA:8 a=6-dRa9qSAAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8
 a=QEEkIeqjAAAA:8 a=XlRjxQ70AAAA:8 a=BXszkKfDAAAA:8 a=XFJw1KJJAAAA:8
 a=RXc22uv1prqeS9pRFPIA:9 a=avxi3fN6y70A:10 a=gbU3OgOOxF9bX48Letew:22
 a=a-zEBD5cKgE7DNtTSb7C:22 a=YjdVzJdQTyZRADMV7wFX:22 a=NZk92sZ4hQKp_Sw8PGvT:22
 a=7k9nRlTqVbDGZ3p5_T00:22 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
 a=1uMOUU2w0DxzEe95gQqD:22 a=duu7wrcty9prphiCz_fF:22 a=DKZDSSD9H29Cdu8kcpdD:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=837
 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508220024
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

Comments inline:


Internal Use - Confidential
-----Original Message-----
From: Thomas Monjalon +ADw-thomas+AEA-monjalon.net+AD4-
Sent: Tuesday, August 19, 2025 4:36 AM
To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
Cc: dev+AEA-dpdk.org+ADs- pravin.m.bathija.dev+AEA-gmail.com+ADs- Maxime Co=
quelin +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- Chenbo Xia +ADw-chenbox+=
AEA-nvidia.com+AD4AOw- David Marchand +ADw-david.marchand+AEA-redhat.com+AD=
4AOw- Bruce Richardson +ADw-bruce.richardson+AEA-intel.com+AD4-
Subject: Re: +AFs-PATCH 0/3+AF0- vhost+AF8-user: configure memory slots


+AFs-EXTERNAL EMAIL+AF0-

Comments inline

12/08/2025 04:33, Pravin M Bathija:
+AD4- - add protocol feature support add and removal of memory regions/slot=
s
+AD4- dynamically.
+AD4- - this patch set has been tested with multiple instances of fio

What is +ACI-fio+ACI-?
Fio is an open-source tool to test I/O workloads on disks and file systems.

+AD4- connected via libblkio to spdk target backed unix domain socket.
+AD4- - please apply this this patch-set to dpdk mainline as well as versio=
n
+AD4- 25.03.0.

As mentionned previously, we don't plan to maintain 25.03.
I understand you need it for SPDK,
but I think SPDK should rely only on LTS branches.
Is there a specific reason why 25.03 is required in SPDK?

When we do sub-module init on spdk master, it uses dpdk version 25.03 from =
it's own sub-repo.
Our changes for vhost have already been pushed to spdk master. We have also=
 pushed the same dpdk
changes in the spdk sub-repo +ACI-dpdk+ACI- which is version 25.03. I was j=
ust ensuring that there is uniformity
in the 25.03 codebase, whether it is on the spdk sub-repo or 25.03 within d=
pdk repo.


+AD4- v2:
+AD4- - fixed warnings with e-mail address
+AD4- - fixed warnings with typos
+AD4- - there is a warning about +AF8AXw-rte+AF8-packed+AF8-begin not being=
 in pair with
+AD4- +AF8AXw-rte+AF8-packed+AF8-end which on reading the code turns out to=
 be false. It
+AD4- is an anomaly of how git-format generates the patch and how
+AD4- check-patch checks it.

When sending a v2, please use -v2 so it is reflected in the email subject.
I will remember this for next time. Thank you for pointing that out.

+AD4- Pravin M Bathija (3):
+AD4-   mailmap: add user
+AD4-   vhost+AF8-user: configure memory slots
+AD4-   vhost+AF8-user: support for memory regions
+AD4-
+AD4-  .mailmap               +AHw-   1 +-
+AD4-  lib/vhost/rte+AF8-vhost.h  +AHw-   4 +-
+AD4-  lib/vhost/vhost+AF8-user.c +AHw- 325
+AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-------
+AD4-  lib/vhost/vhost+AF8-user.h +AHw-  10 +-+-
+AD4-  4 files changed, 296 insertions(+-), 44 deletions(-)



