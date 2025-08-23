Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64C8CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 Aug 2025 18:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4DCF402AC;
	Sat, 23 Aug 2025 20:43:17 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by mails.dpdk.org (Postfix) with ESMTP id B1AD34027A;
 Sat, 23 Aug 2025 20:43:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZavrekS1g7dP07coyr+NYHY+VOGXbamcQ9whPwyf3+zXpdTpl8RByCqy0/RQafHhX/e1rjmm+Kj1x7vjjYvTUmZxSGfThQqQXbJZGq7D5ib2SSHC5Pk9RtGAfTJfjleaXbV9gii2ANHX6iJo3LaJFRl6MS0G9P/ayZeW+t34tdKKwyeLSspOtjtg2oSXo/JIHP0jfaJvNKRgIcOmmV50E3M8+PHSitvw08ERux8tZ/ptRObMAGHu5to+mBk3juoydI6dz8t5si1lW/KiOk6GfmJAiIWbXbI66Pq3glyONP7kfZCECBlVWR1JHyJA/iXBpoPa8+HZtXMFP6rf+hf6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH1gcC1nf5pceWsMAqSThvqhmXlBPs/QHgd2RDt83wY=;
 b=NNuccrOjVQQIMkHlCtwMhKNs7ji9i/UXo+ailcofrecv4k9to8dT+Fhlg3/CL+HZcubfHJJI8wPxmDO6nqjDW+L+In1zZyONDddAKhBVQGjWwux0zIJROD765P9qD0E0UmwATxZ1rTqxyNRmBf3sKV9HBUVycT8qWJug+7UXcHhKCxVIIWROGO5eFv/xR43ybbOmuogVOiA72Dj+nS/Q6q14V9knhNOTCgYw9N8zLdKSk7sjdChppsVTCn2NnozZPXuEzdWIcKOPrDktU/HRuaN5Ok6rS2YupEmDNgF5Xbpe0LK1nCJMNuDrZmyOy9qSEPEQ2YxsZLiJxyzAC9YXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH1gcC1nf5pceWsMAqSThvqhmXlBPs/QHgd2RDt83wY=;
 b=fhymmwyJOXoG9BgH78e5JdsH6FTxhUFJ32Eo5g0KoOsFVxdlUP0k+C8mwINDzTSPGwugG65RzC3DvTkH8WOxEiEX5t3OFf2XosK51RrAQJM6CsI6Iy0CBwjfhhw30bg3llG7Xd8ZmAwHzwusWw6y+Fh/TOXCjKUkeaYMvoiSn0s/Fr7vU+MH0HAHM3ZMmzNlla6PhgyPlrZuCxe0GvTi9e9FsZNbCi/zlYMgZTRZl3eXhWgWnNUHUaunru47M3HFwmIHyPa0oElZJlkNHwVEsCnOEEaybHAhAnHnRFuIv7oaH87nGfwz1bYL801S34KFUrU7wQiSvIyYInClShiKvw==
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 18:43:12 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%4]) with mapi id 15.20.9052.014; Sat, 23 Aug 2025
 18:43:12 +0000
From: Xueming Li <xuemingl@nvidia.com>
To: "Xu, HailinX" <hailinx.xu@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>, David
 Christensen <drc@linux.vnet.ibm.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, "Mcnamara, John" <john.mcnamara@intel.com>, Ju-Hyoung
 Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>, Luca
 Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, Raslan Darawsheh
 <rasland@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 "qian.q.xu@intel.com" <qian.q.xu@intel.com>, "yuan.peng@intel.com"
 <yuan.peng@intel.com>, "zhaoyan.chen@intel.com" <zhaoyan.chen@intel.com>
Subject: Re: 23.11.5 patches review and test
Thread-Topic: 23.11.5 patches review and test
Thread-Index: AQHcCsXBAV2qxzmDY0WUtvSeMh56KLRsWtEAgARLHvo=
Date: Sat, 23 Aug 2025 18:43:12 +0000
Message-ID: <CH3PR12MB8658F59F28BD7C9F93E44E84A13CA@CH3PR12MB8658.namprd12.prod.outlook.com>
References: <20250811134220.45579-1-xuemingl@nvidia.com>
 <IA3PR11MB90406E8B9EA24FD7028AEBDA9F32A@IA3PR11MB9040.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB90406E8B9EA24FD7028AEBDA9F32A@IA3PR11MB9040.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8658:EE_|DS7PR12MB9041:EE_
x-ms-office365-filtering-correlation-id: 48ea3a92-44f3-4a04-2007-08dde274ea08
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|13003099007|38070700018|8096899003|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?X/ctmPGQl9tJKzoTQN5EAnrlVFEDBdS6T9mUTfI3+ItuzI1U7GlC0yUWj9Iq?=
 =?us-ascii?Q?jAO0sjE7usa8z0A/9yt/EWfCF8Qh6DAlRLiUFZ2KU5NYPkbzyMaM8E9/nF6Q?=
 =?us-ascii?Q?m9ZmYsarTUoD3ctx/jtk68j0kFvsug2QbH3sA5BrLYdX2ht89usti+LIZoRK?=
 =?us-ascii?Q?WGDNoaw7PZzA542SOnZFCpGi7ienC39OwBnhe/5Pdi91T/tGKpLshSzP17sT?=
 =?us-ascii?Q?Kh9JVVuGsE6V3H9h+RVGkbd/NfHVyMmW/eWJ6CI9FRNnN0kthVcwTe+aBNxM?=
 =?us-ascii?Q?pjK++ipQ+F2nXA9DOsi/BPtxqtVOJGjDTjcNOcpeWh06qn3mK+eOmDXr4gNE?=
 =?us-ascii?Q?wG/lgb6FO1UF6+c1KQpo836q/SrC+li69H6BwDIOGGduXea31oifn+h6h6ED?=
 =?us-ascii?Q?sgsR6sD7lME6mJMViVSG6OzB5lJwp62Fvuv4uGeyRC5B/pc6K4U4wVWg+Cds?=
 =?us-ascii?Q?LHliLQZdIgh5uQXwFH0IzN4VII3VI3PcuHN8yKqrkEDIDPJ1TTyTHsiR8eMg?=
 =?us-ascii?Q?xzuIVuvCtS445aa8swCxP39khvwbfnDtvT8F9jz1Zsket8HTwZ6+vHmTJkAf?=
 =?us-ascii?Q?I2zMWA5T9bWM79dZewMtrANuCxiQHmt6KawFlR3p7ZNJXbpdZcrftucuR8xN?=
 =?us-ascii?Q?vjsa7y+ISGOgaMFpcv93LzSOt6+HuGN0XzyTcCXDFC52Pa+dXkcoQUAw+3I5?=
 =?us-ascii?Q?Wuuy6RMeugbC5jOe7tTAfcmuiqtRkEnymf8vzNYVQ3r6o+FdiQgTBc9gnwJ5?=
 =?us-ascii?Q?vnjUAw1l3jpxkWhtt2bHyreyvr0Ux+h9/9Ovz+bHaiRaILtHLqdQ/2DuZ2i6?=
 =?us-ascii?Q?G4XuKAQSVF0KEisMs3BQSej4a+ZQ179kOe9rBT6ltuUS+SPHXrAe/dOzwH6V?=
 =?us-ascii?Q?1afrilh56DrfibTXEyGOl9B7BaAAN9bDX4pQBQJMeoTMXHwrKF5xowP93O8s?=
 =?us-ascii?Q?me0oN9hOH+hOK/MWB9MmIYxt6ou6G+jL74RuhnFNn1UKRFQbf8FNxL21En3b?=
 =?us-ascii?Q?1DC3qs4mgpO+Fdvls+iMk/AOpIfbvczaJz7EXqD1sNEWi636YTooFae5CVoo?=
 =?us-ascii?Q?Inxp+5rO7cJnZ26qu9Xj1K+bSGt8xkb9y3tag23I5X2l720JJkInZ7c5tSUQ?=
 =?us-ascii?Q?/wZB92tkhk/kLxAgPgXdZLPoPJdcp8rtEk4GYHPaPsFOkucD5rUUb1peI3c/?=
 =?us-ascii?Q?74DDa0AvhkY7I7zG+Qq3KF7Hvn+zFqhvd2WSfYNA92jWxrrs0Bcc8QEzrcgY?=
 =?us-ascii?Q?aiaToBpXxikwx7KLTENWd0OA++sYwXwLh8mnvlhUctLPHcjVhhBndVxDRRIs?=
 =?us-ascii?Q?z3iPWQKB6M0W/U0gov3ecpW7nYmxRlczTT/zmGTUveTHFSdNkpeoxQPjQR1K?=
 =?us-ascii?Q?lDNhxG05z4xUwVPUpEby9jmoa1CJrLm71g2XTKreeOTGTvAH0lFGNBCX28Ie?=
 =?us-ascii?Q?fblLjxObJhz5KLgjgefxjOzB9VdV5hr//taYXycg7lQDHg91evRnPb4XPVPz?=
 =?us-ascii?Q?+CMXZgaH7MLLXag=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8658.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(13003099007)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VVJfmJ0hbxqzVGQI5D4OgeG0MTKhvJ2cO/gfb5o6l1bgDNxdnidJIa7n9m6O?=
 =?us-ascii?Q?s3Rj13401jEBnLlncQKXR7Qceo/51AwgTmv5wV1zxUH4VKSvvkAa7yRCyLcb?=
 =?us-ascii?Q?NmU3dFXHLacp66k9pz7CMi1HvVxhCY7tYcJb1zsJD7JdZBoBbnIM8PdKKOe2?=
 =?us-ascii?Q?22Kk5QG5hYnoTIWSU/pnLDPIVc8C7ajpdwvWv5QUzGzUPFO30LW71cTCt6Rw?=
 =?us-ascii?Q?glxu5Jk3BrNV1T2tiP3T0oeXVeG4GollvnUTiSubhAEwOMATpQ4n7IoBWP5z?=
 =?us-ascii?Q?9YhokgwxBfG9V1lGfhmQfbHxNnxfMwc8VXPXpGnsPn7FdqvagKLLEA9wn2AK?=
 =?us-ascii?Q?uPFLvXEGn0phAcXnEZoFjQlOENV6pKh11bOdbiaBq4Ze/fTFTOfnKRMt8pLL?=
 =?us-ascii?Q?Z/hbGbNxCdxkZcfkRtPzNoyxYEoIw37ISAHBoET2KB4NwbqsPybOQZLAlsuG?=
 =?us-ascii?Q?7cVIFAdUlEYYm3lDAFDlyU/72MT7mFR871XJsziGmN/lKbe+8CWQQIYVd71K?=
 =?us-ascii?Q?rHWzyDfIuLL3nPNCkiEWcpMvs/tGl5qOraAiHI0NXPjgSCoONTa/tMJ4Z6fD?=
 =?us-ascii?Q?4a2rE/LMNsBL6S1yjtNTDy04xHvXTiuUQ+BKgzqWGO+oUFeUbzPOsg9X7JV/?=
 =?us-ascii?Q?29Yk7iBDRp+NM2XWQc4UkVsojoj4cVQYNHFBjrdi6jBUkgSQx0pcRRwGmbMX?=
 =?us-ascii?Q?V0Zcwmx+KQTI/7V7o+/unpMiGZG8IGLWc/YnsZF2TJaUvlex9HHCiS76LykO?=
 =?us-ascii?Q?NhYIEo806BGj1/6k0PKa7KyXz/kbQnftXw5GxLHnVjOLmK6O8tL1tc1U00uf?=
 =?us-ascii?Q?OxITBbugLYu+3tIGcxYaEqyrDHZpsiQ/phxNTH3dI2nyj0AI+OT2HkpbxjrQ?=
 =?us-ascii?Q?IQWIIAcxT4+1ISLWNCdx8G2N6VAqrOEqCs4FizjQ5HPN3FZagTSvTKbQsaqB?=
 =?us-ascii?Q?Oj1Jb44owfh3eZoJdBC96zk3l7k9i4DEt/Ewxm/XPPWRQzIYpKCreHLlEGb8?=
 =?us-ascii?Q?8BNJFJVpwYWl9ctlwgrlLA+5Ud42sAX534yBwWNNUJzUUmt572mgvG5xO01n?=
 =?us-ascii?Q?UEx5mXdRKAoyMRZGJtWJBAP0lB50sHBkxuDKFt7BnOEAvJBhP6I0N/g595VT?=
 =?us-ascii?Q?XTxSvFwre02dDkZo0Ziw7mpuuXN2TI0nu/WyV5b/l/cY+PDFu6erLnuk0wVt?=
 =?us-ascii?Q?93QQYKgVTZU9upHaeThRgdc4PYmxjGcqURaKTMQCC6PkYdDfLIv4mfAlKo4z?=
 =?us-ascii?Q?tgO7ltg1On5WnmiHiUIteLF8D066Tk98PdGFNX+B0rPv3xOfpNa4Nju1M9/V?=
 =?us-ascii?Q?v7XQe2FsnuTl3/fWJ3a704fW2b6EM1S8XBXiusWUzJ+ZITA6JNclaxwHBqTq?=
 =?us-ascii?Q?x6wW1/f6cso5L4p09up5Aqwb0JrNzcDE6WaAPKGMAGq5uebok/GwwVNLHSfw?=
 =?us-ascii?Q?jR6sDmbLhWyEvNAR6MW7V2XE28BTmD+yQ3RB+UhtTnmPHiMKdU36Pjwu9MQ3?=
 =?us-ascii?Q?iz4n88aeaOgH8X663laFK+rwnC7qPg2hQGXkQLeCc5XBdRP7uIl1F9N+qKox?=
 =?us-ascii?Q?ZFXkgrxMzGozzvjpgYY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8658F59F28BD7C9F93E44E84A13CACH3PR12MB8658namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ea3a92-44f3-4a04-2007-08dde274ea08
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 18:43:12.6450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGwRFxJ5JoUTnMiC6MUuQ3CoYplUuXeANjkuKWmt9RuKxLw2rxooBG9wfysrXp9HGNEI19sGWivPj747de17IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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

--_000_CH3PR12MB8658F59F28BD7C9F93E44E84A13CACH3PR12MB8658namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Hailin,

Thanks for you help!
________________________________
From: Xu, HailinX <hailinx.xu@intel.com>
Sent: Thursday, August 21, 2025 9:09 AM
To: Xueming Li <xuemingl@nvidia.com>; stable@dpdk.org <stable@dpdk.org>
Cc: dev@dpdk.org <dev@dpdk.org>; Abhishek Marathe <Abhishek.Marathe@microso=
ft.com>; Ali Alnubani <alialnu@nvidia.com>; David Christensen <drc@linux.vn=
et.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>; Ian Stokes <ian.stoke=
s@intel.com>; Jerin Jacob <jerinj@marvell.com>; Mcnamara, John <john.mcnama=
ra@intel.com>; Ju-Hyoung Lee <juhlee@microsoft.com>; Kevin Traynor <ktrayno=
r@redhat.com>; Luca Boccassi <bluca@debian.org>; Pei Zhang <pezhang@redhat.=
com>; Raslan Darawsheh <rasland@nvidia.com>; NBU-Contact-Thomas Monjalon (E=
XTERNAL) <thomas@monjalon.net>; Yanghang Liu <yanghliu@redhat.com>; benjami=
n.walker@intel.com <benjamin.walker@intel.com>; qian.q.xu@intel.com <qian.q=
.xu@intel.com>; yuan.peng@intel.com <yuan.peng@intel.com>; zhaoyan.chen@int=
el.com <zhaoyan.chen@intel.com>
Subject: RE: 23.11.5 patches review and test

> -----Original Message-----
> From: Xueming Li <xuemingl@nvidia.com>
> Sent: Monday, August 11, 2025 9:42 PM
> To: stable@dpdk.org
> Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
> Ali Alnubani <alialnu@nvidia.com>; David Christensen
> <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> Ian Stokes <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>;
> Mcnamara, John <john.mcnamara@intel.com>; Ju-Hyoung Lee
> <juhlee@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>; Luca
> Boccassi <bluca@debian.org>; Pei Zhang <pezhang@redhat.com>; Raslan
> Darawsheh <rasland@nvidia.com>; Thomas Monjalon
> <thomas@monjalon.net>; Yanghang Liu <yanghliu@redhat.com>;
> benjamin.walker@intel.com; qian.q.xu@intel.com; yuan.peng@intel.com;
> zhaoyan.chen@intel.com
> Subject: 23.11.5 patches review and test
>
> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.5.
>
> The planned date for the final release is 15th August.
>
> Please help with testing and validation of your use cases and report any
> issues/results with reply-all to this mail. For the final release the fix=
es and
> reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.11.5-rc1
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Xueming Li <xuemingl@nvidia.com>
>
> ---
Update the test status for Intel part. dpdk23.11.5-rc1 all validation test =
done. no new issue is found.

* Build & CFLAG compile: cover the build test with latest GCC/Clang version=
 on the following OS(all passed)
  - Ubuntu25.04/Ubuntu24.04.2
  - RHEL9.6/RHEL10
  - Fedora42
  - FreeBSD14.2
  - SUSE15.6
  - OpenAnolis8.10
  - AzureLinux3.0

* Function tests: All test done and passed.
  - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW/TSO/=
Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.
  - IXGBE-(82599) PF/VF: test scenarios including basic/RTE_FLOW/TSO/Jumbof=
rame/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.
  - ICE-(E810, E2100) PF/VF: test scenarios including basic/Switch/Package =
Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descript=
or, etc.
  - IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test=
 - QAT&SW/FIB library, etc.
  - Virtio: both function and performance test are covered. Such as PVP/Vir=
tio_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESX=
I 8.0, etc.
  - Cryptodev: test scenarios including Cryptodev API testing/CompressDev I=
SA-L/QAT/ZLIB PMD Testing/FIPS, etc.
  - DLB: test scenarios including DLB2.0 and DLB2.5
  - Other: test scenarios including AF_XDP, Power, CBDMA, DSA

* Performance test: All test done and passed
  - Thoughput Performance
  - Cryptodev Latency
  - PF/VF NIC single core
  - XXV710/E810 NIC Performance


Regards,
Xu, Hailin

--_000_CH3PR12MB8658F59F28BD7C9F93E44E84A13CACH3PR12MB8658namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Hailin,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks for you help!</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Xu, HailinX &lt;haili=
nx.xu@intel.com&gt;<br>
<b>Sent:</b> Thursday, August 21, 2025 9:09 AM<br>
<b>To:</b> Xueming Li &lt;xuemingl@nvidia.com&gt;; stable@dpdk.org &lt;stab=
le@dpdk.org&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Abhishek Marathe &lt;Abhishek=
.Marathe@microsoft.com&gt;; Ali Alnubani &lt;alialnu@nvidia.com&gt;; David =
Christensen &lt;drc@linux.vnet.ibm.com&gt;; Hemant Agrawal &lt;hemant.agraw=
al@nxp.com&gt;; Ian Stokes &lt;ian.stokes@intel.com&gt;; Jerin Jacob
 &lt;jerinj@marvell.com&gt;; Mcnamara, John &lt;john.mcnamara@intel.com&gt;=
; Ju-Hyoung Lee &lt;juhlee@microsoft.com&gt;; Kevin Traynor &lt;ktraynor@re=
dhat.com&gt;; Luca Boccassi &lt;bluca@debian.org&gt;; Pei Zhang &lt;pezhang=
@redhat.com&gt;; Raslan Darawsheh &lt;rasland@nvidia.com&gt;; NBU-Contact-T=
homas
 Monjalon (EXTERNAL) &lt;thomas@monjalon.net&gt;; Yanghang Liu &lt;yanghliu=
@redhat.com&gt;; benjamin.walker@intel.com &lt;benjamin.walker@intel.com&gt=
;; qian.q.xu@intel.com &lt;qian.q.xu@intel.com&gt;; yuan.peng@intel.com &lt=
;yuan.peng@intel.com&gt;; zhaoyan.chen@intel.com &lt;zhaoyan.chen@intel.com=
&gt;<br>
<b>Subject:</b> RE: 23.11.5 patches review and test</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: Xueming Li &lt;xuemingl@nvidia.com&gt;<br>
&gt; Sent: Monday, August 11, 2025 9:42 PM<br>
&gt; To: stable@dpdk.org<br>
&gt; Cc: dev@dpdk.org; Abhishek Marathe &lt;Abhishek.Marathe@microsoft.com&=
gt;;<br>
&gt; Ali Alnubani &lt;alialnu@nvidia.com&gt;; David Christensen<br>
&gt; &lt;drc@linux.vnet.ibm.com&gt;; Hemant Agrawal &lt;hemant.agrawal@nxp.=
com&gt;;<br>
&gt; Ian Stokes &lt;ian.stokes@intel.com&gt;; Jerin Jacob &lt;jerinj@marvel=
l.com&gt;;<br>
&gt; Mcnamara, John &lt;john.mcnamara@intel.com&gt;; Ju-Hyoung Lee<br>
&gt; &lt;juhlee@microsoft.com&gt;; Kevin Traynor &lt;ktraynor@redhat.com&gt=
;; Luca<br>
&gt; Boccassi &lt;bluca@debian.org&gt;; Pei Zhang &lt;pezhang@redhat.com&gt=
;; Raslan<br>
&gt; Darawsheh &lt;rasland@nvidia.com&gt;; Thomas Monjalon<br>
&gt; &lt;thomas@monjalon.net&gt;; Yanghang Liu &lt;yanghliu@redhat.com&gt;;=
<br>
&gt; benjamin.walker@intel.com; qian.q.xu@intel.com; yuan.peng@intel.com;<b=
r>
&gt; zhaoyan.chen@intel.com<br>
&gt; Subject: 23.11.5 patches review and test<br>
&gt; <br>
&gt; Hi all,<br>
&gt; <br>
&gt; Here is a list of patches targeted for stable release 23.11.5.<br>
&gt; <br>
&gt; The planned date for the final release is 15th August.<br>
&gt; <br>
&gt; Please help with testing and validation of your use cases and report a=
ny<br>
&gt; issues/results with reply-all to this mail. For the final release the =
fixes and<br>
&gt; reported validations will be added to the release notes.<br>
&gt; <br>
&gt; A release candidate tarball can be found at:<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://dpdk.org/browse/dpdk-stable=
/tag/?id=3Dv23.11.5-rc1">https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.=
11.5-rc1</a><br>
&gt; <br>
&gt; These patches are located at branch 23.11 of dpdk-stable repo:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://dpdk.org/browse/dpdk-stable=
/">https://dpdk.org/browse/dpdk-stable/</a><br>
&gt; <br>
&gt; Thanks.<br>
&gt; <br>
&gt; Xueming Li &lt;xuemingl@nvidia.com&gt;<br>
&gt; <br>
&gt; ---<br>
Update the test status for Intel part. dpdk23.11.5-rc1 all validation test =
done. no new issue is found.<br>
<br>
* Build &amp; CFLAG compile: cover the build test with latest GCC/Clang ver=
sion on the following OS(all passed)<br>
&nbsp; - Ubuntu25.04/Ubuntu24.04.2<br>
&nbsp; - RHEL9.6/RHEL10<br>
&nbsp; - Fedora42<br>
&nbsp; - FreeBSD14.2<br>
&nbsp; - SUSE15.6<br>
&nbsp; - OpenAnolis8.10<br>
&nbsp; - AzureLinux3.0<br>
<br>
* Function tests: All test done and passed.<br>
&nbsp; - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW=
/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.
<br>
&nbsp; - IXGBE-(82599) PF/VF: test scenarios including basic/RTE_FLOW/TSO/J=
umboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.
<br>
&nbsp; - ICE-(E810, E2100) PF/VF: test scenarios including basic/Switch/Pac=
kage Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Des=
criptor, etc.<br>
&nbsp; - IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic=
 test - QAT&amp;SW/FIB library, etc.<br>
&nbsp; - Virtio: both function and performance test are covered. Such as PV=
P/Virtio_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWAR=
E ESXI 8.0, etc.<br>
&nbsp; - Cryptodev: test scenarios including Cryptodev API testing/Compress=
Dev ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.<br>
&nbsp; - DLB: test scenarios including DLB2.0 and DLB2.5<br>
&nbsp; - Other: test scenarios including AF_XDP, Power, CBDMA, DSA<br>
<br>
* Performance test: All test done and passed<br>
&nbsp; - Thoughput Performance<br>
&nbsp; - Cryptodev Latency<br>
&nbsp; - PF/VF NIC single core<br>
&nbsp; - XXV710/E810 NIC Performance<br>
<br>
<br>
Regards,<br>
Xu, Hailin<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH3PR12MB8658F59F28BD7C9F93E44E84A13CACH3PR12MB8658namp_--
