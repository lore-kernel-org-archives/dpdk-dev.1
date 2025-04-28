Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47469C369D3
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 09:24:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 733554065B;
	Mon, 28 Apr 2025 11:24:41 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by mails.dpdk.org (Postfix) with ESMTP id DA66D40156;
 Mon, 28 Apr 2025 11:24:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0f4AH9sMl0YdAlb/PQ+gYneDG6CjqZWocLcTv6msw/tvqYDpO/+PQj2vvkB7a+xYc5aVQ/HctQ4m+/59XxVeQGcfIXgkIV6tUaVbY95h0vvH0m7zVEga+kNmzTClbKfydVnZaR2cFGfDjrnith1l0qD7Fm6zITP8K2frImcC6wvewKmn0lVNOCsT1MjFHxNYFMSheCqF+IdZmQObOO2UHX4mrleac0h3RV89zy0386DtMUMJw6Zcb4n7e/vLlADv5gKyNYdTw8gbH6LfrkFd5RGRn2cjQjLW5Klt3DJLwLqxRDZ93u4BEEWKZSP1mNrECfRpdSyqZMGy6LRsYA50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tXhv8NZ+D54JqYf6P8YgJ1soJf0H/nyVSBuBM0uppo=;
 b=FLUH1HYM9xMY91Tmw0pq6rz0gePj0L1R33Aoc2nl+HJY3txf9Gsyw6Jv4sZLl3VpDh7++Oc5m2GxcyOzfXE6VunOAYmj/uwpEcPa5KlWVXaRYt+57Cw1l6056UOJBW5gLLBTj4O125DZeXWWX0r8Ur1gqjGwkZvbBKxSALJ+RpzCLoQxC4LbzQqWxh+hHJEqBTRGOiKb24BWk2KAa4z/J14f6zi9D7nDhqLhdnAst5NjngpjxioXBWAwexUyxFN/F9WMYsS6j66BGY0Ql2s8fiv0/nOxl8vOnio+9IHquxilD9661qb0QaC9BVlbj6vfyto0bYpjp1Ubx76Te4QMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tXhv8NZ+D54JqYf6P8YgJ1soJf0H/nyVSBuBM0uppo=;
 b=o4lj3M2GI7+M1e39u5++wWtGLGA+hnAif4LcYVkYOO2TTbu6t9INoIyx5CF37gCfsd3AOcejBC4E9FF84PKWGnlrtrgCKyrctFp6AhJ0TELGD1pflBwZrVtsF3Q3kldp830pQgfF5g8BB0hRNvxcbiJ+Wb/pcwWPwmfC2yGH6j3p80jf/TNd2GVQloqswNrG2ikhwCKgebZXG3p4dOlfZ/iPRYyQTV1lbCI6P/sCJ4g4/ljZeXogtQnCky5dzyL8XQ+6FdXQvv2YXq/Q3eI4VATYZHe4caf9EBhzTbaiNQeNlSD+U3EcpcDftR3/oTRHGrReJ95KIzYYGbDZW3Japw==
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 09:24:35 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 09:24:35 +0000
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
Subject: Re: 23.11.4 patches review and test
Thread-Topic: 23.11.4 patches review and test
Thread-Index: AQHbsshe9/Ee4Q0AZUuPVFwM3IIB27O4w+YAgAAVG1o=
Date: Mon, 28 Apr 2025 09:24:35 +0000
Message-ID: <CH3PR12MB865810D1C6208CFC6A2345C7A1812@CH3PR12MB8658.namprd12.prod.outlook.com>
References: <20250421141920.622156-1-xuemingl@nvidia.com>
 <MW4PR11MB591237692FC1241E2C8221BF9F812@MW4PR11MB5912.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB591237692FC1241E2C8221BF9F812@MW4PR11MB5912.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8658:EE_|SJ2PR12MB8873:EE_
x-ms-office365-filtering-correlation-id: e36354bf-883f-47ff-4593-08dd86367dc7
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|8096899003|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UMPlc45pM7aQDNBhRTFJjSJBG7Acaf1q3ue+6k5o/+XF4ERdpK8FVOwUKNfd?=
 =?us-ascii?Q?tu7f7NLWSU8g9P2HvUUb0on7JqUVMVkG8ZS2Zk8Rbm/0HHq1e0+GeapYme+H?=
 =?us-ascii?Q?HzcUa1JFrS568JrJCquyWqjKhHnU2KYGLUtLCbVRpgSqgHp4gi3yXEAgv+kK?=
 =?us-ascii?Q?+qHGwA1bwMMMiHYScsQ7BcOXR1ApGd6D2rHzt1pu+BW4ZXMEdxTSjxGFxweW?=
 =?us-ascii?Q?HY1buvu5tWFZ0IJb1mPgRX2QlsnTZfAnjWt0B+F1vggC3KA+8VKZI3UT/65w?=
 =?us-ascii?Q?K9M5shX+ywYv8k6Zvh0LUaYSCXVsxp49S7+WZcQzJnUS/at81VHs5Lb5qSmi?=
 =?us-ascii?Q?YwrmmZJ/D/iengQV2Qs05AsrJTeUfxmcUkMWMG5u3VEyqKC8rGBLeiOd+Ifg?=
 =?us-ascii?Q?y3y1FKZ7YhDZ4Iqd0avB+kegAwI+coZKjPrwx0gSBkBqPdaxSiCBnMTYFOu5?=
 =?us-ascii?Q?70NWgtB6XqBUsetH6PiFQmqeTD89Kgm3pqZlY4LDQ+Y1Oz/KJ8j5e5bPALr3?=
 =?us-ascii?Q?Zc/Z49m1ViC/PzXqm0SXeg5oo/xn2/pOQAniDOYpsZH0V3A9ak4U2xGVN/FY?=
 =?us-ascii?Q?L/6RmzzFBruJj4/92Q/BRCalpSe09l26G7GdYTa4Y6gl133fwBnLkURc68Ij?=
 =?us-ascii?Q?LCsueqIgpBHu7xgwC/6fCjVw8jXSehj0iiLIXaZgmvIp4aG/gg9si2/pJt6N?=
 =?us-ascii?Q?t6KHI4PVGQ8Wua12nh473YmYxzjO9uZmrbXp4Q/J1ZLh7gZm2bg3eJQE0Bv7?=
 =?us-ascii?Q?EEX/XiTYFL4iPoDwfGyTwEeVN4lcZEWoDKjGnRqxGqQpuUwol/zNe9d/xvdh?=
 =?us-ascii?Q?eMWNUDpXnJT90CGdLjxdZYEDVZLYT+yxu7uUa+b9Qcn21R9+h3HWQEw8wkc4?=
 =?us-ascii?Q?NvvEzJG8o02UcrsPoQydJOISTJfDgxUWwycHfn8YXdsUVcMwQrA7KcK/EcXJ?=
 =?us-ascii?Q?TTG0ovbZ3qatSexEgIfP7FcW7WfgAg/q+YyHyrV3Eeywkiw8YoRvcEZwVo/m?=
 =?us-ascii?Q?0jsTcaZuq2+lqsbFhPt3aTLofQFOLWYsa2ha0FNtftBPra9Wl5TUp/QCVPtE?=
 =?us-ascii?Q?j67/xsiqR52484xLRv4YWtjOAKV4w5Pgasdg977SAsDLkFfO2CyCP2EV+ZEm?=
 =?us-ascii?Q?ErCItDxaboPCQISggSN9LD0Qi/0ipl9uQPOMuCtT/fM7iCUSvTH6cOmLhlCd?=
 =?us-ascii?Q?1zMxJy24GTODkE7khzH+PMY+HQkezzAijFsCBmFtZz0VrGH/9II4JGpmjFfa?=
 =?us-ascii?Q?GtrnuTCtZD+pbU7DDNsq0PRKs4toLrY5sFaKHk6QDnJawZy8ZNCfW2NwUMNn?=
 =?us-ascii?Q?Ti0o6jaTRkNJpPjVwC6nnbndfYJSus1ZGSKjmm/qTi+2TAndMzMrAKpG7Bf4?=
 =?us-ascii?Q?PmYK3ddPKl0+e6DmU642hG0rYFPkzu4PNSp06XRkK8K1ak9MdbMkjeVzkmpT?=
 =?us-ascii?Q?k6o95MlaHWayW0Tq4BJHlvBrop6ORm4pqdJ+XJt2WG0q0IlCw2OB3LvcaeNJ?=
 =?us-ascii?Q?zDX654TTZKEwiA0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8658.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(8096899003)(13003099007)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lz8WJ37YTcAEvhbBbz6lqzzdPhla10Z4a03NQxKVYsSQb0obXZ/finOimnQ5?=
 =?us-ascii?Q?PEAHmpFm5eNCy4/Hu3ax/IZpIGZuaWoiGRrKVyR+xkSKpjM9Q71o8PUSO4yU?=
 =?us-ascii?Q?rAwIFozBKOEEoQgVL0F7YS7P9ZXBC7k7nc2cYxSwS2KLh+H7qGl6qGjN3amw?=
 =?us-ascii?Q?axATjkhAbu1sqcqICtFracbztTPEuPTYZA+U5BzLG/oNaEloqUx1/KHIMt01?=
 =?us-ascii?Q?QMfKdubiIwFN2qAJvSkQdBPBU512qsnedFBf8k02p+QHckM6GcNl5ayJaosr?=
 =?us-ascii?Q?pmIyprUMDsbqvwLbe0EdzXtH3XHETPG8L4+2r8/tbiUGg7X0UNELvyBEIB/N?=
 =?us-ascii?Q?cGQXqVMQgwE28cWIRM2nZWCI85rNzdNUFVtSMFRS1UR09NhIT7ktMhcXP2hu?=
 =?us-ascii?Q?vwS1HTZl12fVUQwdM4PgFxPRoL/nDWY0C6EapFvKaErKqP8OGeFxM4rCA/NW?=
 =?us-ascii?Q?Jp2Em0nF7R+vMrmef/HOBdsqmMcxBfBTvODVP0nnpAdKj5MnpLISY3KFCJ4l?=
 =?us-ascii?Q?J8Nf0BuZphRYssqLcSI1g947gtfz+lHntil141mjwWaE9YnD7yUFv4eEeu1D?=
 =?us-ascii?Q?HBwyhtsSJGm2JCxUZfaHYTJNtCeBwbjBoKnTpZqn89REFNlkoWSMvOj8lMTr?=
 =?us-ascii?Q?KobS7eZ3tKaHiI812SSpn23dRU2z60NnWymV0de96zLoTKvd5x+EVQR+NON4?=
 =?us-ascii?Q?/2QE4dS0t3NL9ctDvDrZd0f4OpB+NLpiXnCVtZAxdj0ShuHDrWA/YOdauTWu?=
 =?us-ascii?Q?lgQkq1GjefD00qZ8WuNxQuT4dW69A+ilZOQ+0DaEr3hF5Jps8Fk6S0LsjWQS?=
 =?us-ascii?Q?134isl1yoDuiOUgT7+YyzYH0Vw3sxijuXCgbjE2J8uRmDLbu8o3U85gzdQ6u?=
 =?us-ascii?Q?RYFKCqu917CxfcJkpdhnCVq0tFgOsyTT2yzZGhzudirVBzg7U2J1kh35Dfhl?=
 =?us-ascii?Q?2tgpjjX/fYvCzdM4iayb+Yp8HZnRgNxHzQD8yyJg2DeZpRWHFYXQ+L9EKpmh?=
 =?us-ascii?Q?WNKfTmyemNIk1pDPs00h2qySMDuocnU4cV+uHa8DfrVQfnX3MULlx6mkFWal?=
 =?us-ascii?Q?q76AYLISi9XX6prxYJDgcxPd/HvN+lV1xQtwlvfJCwX5ArT7HYlTd+Fsb6X7?=
 =?us-ascii?Q?2RsnpouZ9zNHajhQ5ZZckV+c1hBdoFisM5VFQfaEsyHU9sbGTySpxD8ptato?=
 =?us-ascii?Q?ivfs3R0NyOR+pVCvL4WgFg5LL88bGlhHM3TgoOg3yPTmlBAsvIkayl/4J1mN?=
 =?us-ascii?Q?Etw7eltkEW5pJinnKObFz2NeCnwJ3qxJ6ZBuTWKsm9dTJKt1B5Racvw7ekxf?=
 =?us-ascii?Q?ZfO6v8YUYZmqCftFi401Xjd7hLp2CxzuOrR3tAc9GJWEDrwqIbn+jlC8Qght?=
 =?us-ascii?Q?drn+0nhQHFsuQhQ2c20HP9Q/kaveTtDjXRXx9eW9xsPVLIdbcymFbXV41FQ4?=
 =?us-ascii?Q?BqHdXLCLs0nlu2DtUMg0loL16fyV6hh6YOZqleb6akK4dRm1bZOK+wX23AOa?=
 =?us-ascii?Q?ugiCqU+3RdPWFdrZ0p8pVZeZndBqp1Dik6RtZOfZBsKl7PIlfUEoOfPq2l6G?=
 =?us-ascii?Q?sv5eMngGTPd85hG461hbUle7l0YFDtZ3s0Ip1taS?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB865810D1C6208CFC6A2345C7A1812CH3PR12MB8658namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36354bf-883f-47ff-4593-08dd86367dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 09:24:35.2639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DjuvUQLFRVgStjfWDVuu8G/xgqX+3yM8vdaciKkAbzdKhV8s7iGW0kT/njEDeh8IBEhEKmHIqi5ri3j51sG3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
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

--_000_CH3PR12MB865810D1C6208CFC6A2345C7A1812CH3PR12MB8658namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Hailin,

Thanks for the test and feedback, will collect.

Best Regards,
Xueming
________________________________
From: Xu, HailinX <hailinx.xu@intel.com>
Sent: Monday, April 28, 2025 4:08 PM
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
Subject: RE: 23.11.4 patches review and test

> -----Original Message-----
> From: Xueming Li <xuemingl@nvidia.com>
> Sent: Monday, April 21, 2025 10:19 PM
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
> Subject: 23.11.4 patches review and test
>
> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.4.
>
> The planned date for the final release is 25th April.
>
> Please help with testing and validation of your use cases and report any
> issues/results with reply-all to this mail. For the final release the fix=
es and
> reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.11.4-rc4
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Xueming Li <xuemingl@nvidia.com>
>
> ---
Update the test status for Intel part. dpdk23.11.4-rc4 all validation test =
done. no new issue is found.

known issues: fix patch has been merged into main, but they not merged 23.1=
1 LTS, so this issue still exists in 23.11.4-rc4
  1. vm2vm_virtio_pmd/vm2vm_vhost_user_virtio95_pmd_with_mergeable_path_wit=
h_payload_valid_check: start dpdk-pdump in VM with virtio-0.95 protocol fai=
led
    - has fix patches: https://patchwork.dpdk.org/project/dpdk/list/?series=
=3D30356&archive=3Dboth&state=3D*

* Build & CFLAG compile: cover the build test with latest GCC/Clang version=
 on the following OS(all passed)
  - Ubuntu24.10/Ubuntu24.04.1
  - RHEL9.4/RHEL9.5/RHEL10 beta
  - Fedora41
  - FreeBSD14.2
  - SUSE15.6
  - OpenAnolis8.9
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

--_000_CH3PR12MB865810D1C6208CFC6A2345C7A1812CH3PR12MB8658namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Hailin,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for the test and feedback, will collect.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Best Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Xueming</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Xu, HailinX &lt;haili=
nx.xu@intel.com&gt;<br>
<b>Sent:</b> Monday, April 28, 2025 4:08 PM<br>
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
<b>Subject:</b> RE: 23.11.4 patches review and test</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: Xueming Li &lt;xuemingl@nvidia.com&gt;<br>
&gt; Sent: Monday, April 21, 2025 10:19 PM<br>
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
&gt; Subject: 23.11.4 patches review and test<br>
&gt; <br>
&gt; Hi all,<br>
&gt; <br>
&gt; Here is a list of patches targeted for stable release 23.11.4.<br>
&gt; <br>
&gt; The planned date for the final release is 25th April.<br>
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
/tag/?id=3Dv23.11.4-rc4">https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.=
11.4-rc4</a><br>
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
Update the test status for Intel part. dpdk23.11.4-rc4 all validation test =
done. no new issue is found.<br>
<br>
known issues: fix patch has been merged into main, but they not merged 23.1=
1 LTS, so this issue still exists in 23.11.4-rc4<br>
&nbsp; 1. vm2vm_virtio_pmd/vm2vm_vhost_user_virtio95_pmd_with_mergeable_pat=
h_with_payload_valid_check: start dpdk-pdump in VM with virtio-0.95 protoco=
l failed<br>
&nbsp;&nbsp;&nbsp; - has fix patches: <a href=3D"https://patchwork.dpdk.org=
/project/dpdk/list/?series=3D30356&amp;archive=3Dboth&amp;state=3D*">
https://patchwork.dpdk.org/project/dpdk/list/?series=3D30356&amp;archive=3D=
both&amp;state=3D*</a><br>
<br>
* Build &amp; CFLAG compile: cover the build test with latest GCC/Clang ver=
sion on the following OS(all passed)<br>
&nbsp; - Ubuntu24.10/Ubuntu24.04.1<br>
&nbsp; - RHEL9.4/RHEL9.5/RHEL10 beta<br>
&nbsp; - Fedora41<br>
&nbsp; - FreeBSD14.2<br>
&nbsp; - SUSE15.6<br>
&nbsp; - OpenAnolis8.9<br>
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

--_000_CH3PR12MB865810D1C6208CFC6A2345C7A1812CH3PR12MB8658namp_--
