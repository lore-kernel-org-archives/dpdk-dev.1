Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB33C19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 17:22:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2092440E36;
	Fri,  7 Mar 2025 18:22:13 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2119.outbound.protection.outlook.com [40.107.102.119])
 by mails.dpdk.org (Postfix) with ESMTP id 72A2840E34;
 Fri,  7 Mar 2025 18:22:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1gKRDD7PdFt1xEr7p0A+U111a35jODLf/phIYV/+7I3qpBu9em5bfel4f/66lxvmWKMknfxrpj1JUahyBYuC9yrRUYr4RTcoLS1Qyb/6rxP0qMFxtbgpp5hmfL7xb1gKX3lfaeyK12rD5M3/DFizzlENXuz9hstzFfyceIDKPkRSSZyWmH3HBRdi5tA8puw6lnllbNDMn8PODhGFHl3/gm/Fn3MrT+N/ZhMKsof0PD0W3fOhLBjopfbbSlRLbZc5JP3bA1RUH+CKHEvC48O+KxjgFh41OgNN0s99Ch/WYv3de+xuGdkaRES5S3Nw5Od0xiKSOxMQHDkKhP8Qaonow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga5IE04BEFFd5MGjEaeHaJ2sTanVow+ACgRDfgfZn9Y=;
 b=gItC0TDMeCJbrDSnnIDgeFIS7KAYTxORkBjo+e/x7N1/g2JUrDk1E2be/24jeu+WNrakqNMiyMGSmt0K0KJj3arLgDdx/l5CYyoh0GRkPLzlCg26Y6lyML8Gl4/00k828U8z+Qk+op1ByIPXg7ru//pM1IvdBbkSR68CRuqFIwXIfACGX3q5j7CbDgignjwxl2JoqldbZoM3JGCVlTyaKrIrdekJ95aA9R8RHgiTZuhzUYc6iQ5nfrZrGZcT25fcgKglzGYxi7lsHcpPOXFf2F5yXV1GCbeU8dEHOIcQD9OWqcv6LOp6Og46D1yFvkkTsxiKCdMvpyEWbgq6zDBRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga5IE04BEFFd5MGjEaeHaJ2sTanVow+ACgRDfgfZn9Y=;
 b=VMNdR0SSjBs2fpIvtJ3DeYM79AEeU0QYh5gsfpUnTLGMQEhuqs+mjnqWiN83Kg+kucFtyHLYojcrjqzAltDPRcGX7uyOKJ7eWd9Z5eTsO68BKZ6k4sqAL6k2lE3wkowAX6WI+EsHZmMHBGU0kEpAUyEX8kdK6GOnf/6ESBcgLME=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by BL1PR21MB3139.namprd21.prod.outlook.com (2603:10b6:208:397::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.11; Fri, 7 Mar
 2025 17:22:10 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8534.012; Fri, 7 Mar 2025
 17:22:09 +0000
From: Long Li <longli@microsoft.com>
To: Wei Hu <weh@microsoft.com>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>, Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] net/netvsc: add stats counters from VF
Thread-Topic: [EXTERNAL] [PATCH] net/netvsc: add stats counters from VF
Thread-Index: AQHbgkn2LvmISjpuHUeN7DhAp037F7NOJc+AgBngSfA=
Date: Fri, 7 Mar 2025 17:22:09 +0000
Message-ID: <SA6PR21MB4231D4FF5AA7380EF4581D79CED52@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1739913199-8988-1-git-send-email-longli@linuxonhyperv.com>
 <OSQP153MB13079AEE64F785EE8EB9F75CBBC52@OSQP153MB1307.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <OSQP153MB13079AEE64F785EE8EB9F75CBBC52@OSQP153MB1307.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4d371c9d-53b4-42aa-bcab-4bcb3c4f69ce;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-19T06:10:54Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|BL1PR21MB3139:EE_
x-ms-office365-filtering-correlation-id: 86599dc6-8f92-4ae7-325f-08dd5d9c97a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9FRdqp3xSsViYxiT522pccCUUv9ajAgjTrqdpXN2BviewXmoSTOrs/67w6d4?=
 =?us-ascii?Q?hWCuNBMQ48V/myC1TBJmoPTglL6x/tbugalK7667dJzVTigQa3P/31dhdOMu?=
 =?us-ascii?Q?XCNUAzOWaJ59CkRQl9dCvE2CKKQY1fUsTSQNS7+INMEdyxg4npHQiLZ3V2yI?=
 =?us-ascii?Q?UqkM/qAvwBSd4o7jrOyZKw0F7gmSaO+9Z8J5so2VNFLnjPbwPGLY2/jYR/fz?=
 =?us-ascii?Q?P4ARMMnIE5HQfdsQ9e9Vh/M38gqLk0mZXAntUKqlj8Wp75XDdGqmGAbotpfr?=
 =?us-ascii?Q?H6JM98r5/jsEoG/o14Q7aYrzXnx0vrfQXilXYsqaHYV6AhSTSL+bi0lbMUvO?=
 =?us-ascii?Q?jPAp0vYEr6HYvfQ/36WQKBAwg5B4vwxQP5pGfJe/+KHEmtlUnMqKE9b8wRMe?=
 =?us-ascii?Q?RtZm1OAhV6YjTle6F5MVyDlO7cShjb3ZIsl4ChgA7ul2fTPmCXz4Gd3uHsEx?=
 =?us-ascii?Q?ENMsCjqoeNggv/faO6clWC8bdYyvmtLiX1KbRtAR6XzEiiKR7FABOdL2Jm3c?=
 =?us-ascii?Q?WkLkIDGV2O6AMQWijXtgt76vyAphacY5JuQ9iRozc+rni8Av6YKRog1vLHJQ?=
 =?us-ascii?Q?v7D7IC5NhvdeW87Zzq3xB/9mr7x2doEaxULvyuoFsxse0f6fmPjrzM7314WR?=
 =?us-ascii?Q?kIEjRNELklA6kmdgkYM/SDNZs0Nl6PpSabqCK72bnRzvFDnDgRzUJgLjaej6?=
 =?us-ascii?Q?O63319eJZ3eFA6RVdYb6eTjLQa3/0+GGWxmTW/loEFV9nZB/+x4fChn7VmV0?=
 =?us-ascii?Q?poHU7LHks6Bghj8z2EbqOX1O+o4vUZFbR7qA8yuL5oCLw7Smvel4RGg9YN4e?=
 =?us-ascii?Q?yM5gsVhNpnkSinTFjHKtIss57cgoXXWlk65YqAbK/Mq/a4Atj1nxkYVIFebz?=
 =?us-ascii?Q?SP4yhDP4Nbt6N427pxSDIqm41RNdKSBHmMDEZjVjNFVCX0uwmgJctxjODOUU?=
 =?us-ascii?Q?9nEPAr8ZzCuvcgeP+cIZFrenQEJSrhTOhfcATryDIJj9QvOE3jEmaZGCk62L?=
 =?us-ascii?Q?nyrnWGlTl45EFHzoWXIzsa3/x5xIgWT850wvehgvoInsDtFgEyaciSj7YQ3E?=
 =?us-ascii?Q?+5Z6Zh4Qk00aaQwIbzO1nF0Wb8zISpC1lP+6nAYs/vtPx14Bc9bC1LBjg9QO?=
 =?us-ascii?Q?+ep+M4CE8hV5Z8rRR5HhcG2cCRc52/F6sXNi2In1X2RX6nzHDY+xB3YU51ov?=
 =?us-ascii?Q?jOd7TX5dPCI+qQoByG0yO+K6DOoNi49+9TPi2mczQSlT1U9PQ6ayVdTYW2Ww?=
 =?us-ascii?Q?hyVSkVQtoifdm0TQp1473x9Na6NyOwOOzFjU/OJNedSurF04yEALnrujS/N9?=
 =?us-ascii?Q?2S0Buj346SP51L2/+P1XK8RSU9N/gRZRBTeuPWwQBU5NYpXLofhOqmEO/fza?=
 =?us-ascii?Q?lV+04VQrWOvBZCac2NvFoN3F6fIqMkPKb45L1YmTp2wPWZpHuQbxX4sZMVR8?=
 =?us-ascii?Q?GhXDlG0iNPCsVnSlD0uVnVv1LMCi/1s9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D1KdS5jpLTH9oY5UiKipZtULWIqUfX5hBRtt9fvJqhMkwCQTJqqKwtQtpMZG?=
 =?us-ascii?Q?hWNSBAOeXH987/nc8ZWf/X5gAPBsgTYxI9KlN4EHwtrs5n8+Y1gxo84Uw3jj?=
 =?us-ascii?Q?ATPK47HR4ec+dd4uCH4MgQOM4KSLiuhTbo3k4/RsKEqk3ifLNpvlHi/lpJ84?=
 =?us-ascii?Q?Hdg+zfIQAuqjFtzT79JDNUzVw9emN9B64XOSCX53j/85Kz9kbA2ectHqfzBr?=
 =?us-ascii?Q?rgJsVbpOm9rH8RT5eWrV+oVb0Osxrsll+DK8M8iJDkVWLfrBr5EBmn5JHgRB?=
 =?us-ascii?Q?snupHB+L0RYj2FjX/ZOczg1ZNG/740N7464k09pu/zN6tka6JbNdo3WcseO6?=
 =?us-ascii?Q?0JckSYOyyc5C4hO9YRJ6ORSBCkDA6lS9Ux9EftFNxyvWU/rDDvfFPhUgVKEj?=
 =?us-ascii?Q?ZJvml/TS1dpVmegNt4pNhJ28C4wqpzV8+DxTUpxqabSA3DR8tx7h/LogdihW?=
 =?us-ascii?Q?F5YhgS9YU9wXHCNzVtUG06boLwh3c5s7JPQgPHPj7dhyC3tdkx73kqLONsF+?=
 =?us-ascii?Q?kxgNYRHNMjFKQuXtNWIE4ifsn6qU+95Gh0ivO3gxr3Wbt97JZWXJXjWubbpu?=
 =?us-ascii?Q?tc+aAd3DrmJ9y7dmZdOFWv5qylb47ryORR0Lb8cxcsoenhtzpfLTYpkyVwny?=
 =?us-ascii?Q?lh4/zIgjI0FCG3/Ucc0yIDtB21J/rmZzr9cpv/9CSsplDGb2jlEpH5EnJH3w?=
 =?us-ascii?Q?dpCmz0Ol3B54dTF+n/GQvWXnxMWvKetnC2ha4+My8Il3lCRCda41UMevM4O9?=
 =?us-ascii?Q?QWk9AI1YjRGqzYwqTANXofXKTD1crmV+Dq6x4qrab5jMdm51Th8OhFo9AVtc?=
 =?us-ascii?Q?ozp8Ny/Kny8jjyjTu8aR+DFYack2EfEiz/y0UIMyFdwP+yZN0SnWNZoMJ8w/?=
 =?us-ascii?Q?YMaerm9rzScXPMZfn6ChohdWy48ui47CTQPt5edw7Rf5dKNROdpS6H8NvwNg?=
 =?us-ascii?Q?rrpgfDHzKbVSmiL5p6lEc5ish3EHVV3paqLe/GNDKjLIgwjI5ReR5jHxbvtp?=
 =?us-ascii?Q?PMIliL8g6QXDEybSUNKCNpvxO7sp6kxFs3HOeUEzUXmFPGTqX/hNTojvZ99V?=
 =?us-ascii?Q?SB6mQ2wspz4Sw7W6LYUP3hR4BenSiZxc05e9e+IgBFUHvA9aA0ME2IX/cyw0?=
 =?us-ascii?Q?VHaOGAWPH8JTNn4a1x1Mkxn0EenRoxZ2DQNiZUfYzS1lisUksgCNZm7rdZGh?=
 =?us-ascii?Q?YJyTNR49MdBI1aoMJYvL3cafgjc6nMOhHAx+sDjQbPhOPbvfcPtgQt+FRryE?=
 =?us-ascii?Q?mRNUW73U7mCBBlI7foDK4fYElUosZYUmfoQE/pn20zgAQBuz/DL5+0knOSVI?=
 =?us-ascii?Q?8FoSg3GyESyM0us9bMcceADURKaijLE5X/VPcuwmrDKG4iu1VUouq5a+fwjd?=
 =?us-ascii?Q?9M5yMbLr0vXgNpfVcRNgtHxC9ujq/pTxu17PSrFgpj9hL4VoOEK7pN5XGVfO?=
 =?us-ascii?Q?jT25OSQNvSEpouUe9YTAfYjpaDiSPK5EcbLjo5bV7xjZc19yPhofrEBmfpl5?=
 =?us-ascii?Q?bxtfKnEjy1NqWaist4Xen7J3lYiMWiKB0JYHqeWrmY31hHzgnZmiM5RqSL2L?=
 =?us-ascii?Q?MqRkchadwlbfxaCMBMMguDaIcSB88QazGMeEyUjT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86599dc6-8f92-4ae7-325f-08dd5d9c97a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 17:22:09.6970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fTM5T7O6f2RYnto5lWaEPE6PVvmoCqCtXsN297NgSz8b+fO6XNrZdgIGDJWTagLpzSFgX3vSbXnrO3PWCVyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3139
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
> From: Wei Hu <weh@microsoft.com>
> Sent: Tuesday, February 18, 2025 10:12 PM
> To: longli@linuxonhyperv.com; Stephen Hemminger
> <stephen@networkplumber.org>
> Cc: dev@dpdk.org; Long Li <longli@microsoft.com>; stable@dpdk.org
> Subject: RE: [EXTERNAL] [PATCH] net/netvsc: add stats counters from VF
>=20
>=20
>=20
> > -----Original Message-----
> > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> > Sent: Wednesday, February 19, 2025 5:13 AM
> > To: Stephen Hemminger <stephen@networkplumber.org>; Wei Hu
> > <weh@microsoft.com>
> > Cc: dev@dpdk.org; Long Li <longli@microsoft.com>; stable@dpdk.org
> > Subject: [EXTERNAL] [PATCH] net/netvsc: add stats counters from VF
> >
> > From: Long Li <longli@microsoft.com>
> >
> > The netvsc driver should add per-queue and rx_nombuf counters from VF.
> >
> > Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
> > Cc: stable@dpdk.org
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/net/netvsc/hn_ethdev.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/netvsc/hn_ethdev.c
> > b/drivers/net/netvsc/hn_ethdev.c index 988c51928d..069d603d90 100644
> > --- a/drivers/net/netvsc/hn_ethdev.c
> > +++ b/drivers/net/netvsc/hn_ethdev.c
> > @@ -824,8 +824,8 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev=
,
> >  		stats->oerrors +=3D txq->stats.errors;
> >
> >  		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> > -			stats->q_opackets[i] =3D txq->stats.packets;
> > -			stats->q_obytes[i] =3D txq->stats.bytes;
> > +			stats->q_opackets[i] +=3D txq->stats.packets;
> > +			stats->q_obytes[i] +=3D txq->stats.bytes;
> >  		}
> >  	}
> >
> > @@ -841,12 +841,12 @@ static int hn_dev_stats_get(struct rte_eth_dev
> > *dev,
> >  		stats->imissed +=3D rxq->stats.ring_full;
> >
> >  		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
> > -			stats->q_ipackets[i] =3D rxq->stats.packets;
> > -			stats->q_ibytes[i] =3D rxq->stats.bytes;
> > +			stats->q_ipackets[i] +=3D rxq->stats.packets;
> > +			stats->q_ibytes[i] +=3D rxq->stats.bytes;
> >  		}
> >  	}
> >
> > -	stats->rx_nombuf =3D dev->data->rx_mbuf_alloc_failed;
> > +	stats->rx_nombuf +=3D dev->data->rx_mbuf_alloc_failed;
> >  	return 0;
> >  }
> >
> > --
> > 2.34.1
>=20
> Reviewed-by: Wei Hu <weh@linux.microsoft.com>

Hi Stephen,

Is it okay to merge this patch?

Thanks,
Long
