Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8288C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 06:26:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A088340270;
	Mon, 14 Apr 2025 08:26:07 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2123.outbound.protection.outlook.com [40.107.237.123])
 by mails.dpdk.org (Postfix) with ESMTP id B194740265
 for <dev@dpdk.org>; Mon, 14 Apr 2025 08:26:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvM11QnEXdTenPp3VgPmY/whTyAlUtIZimcf68y6mHtYAwRaGleSxIbTxLlEFGSIWAWCjAJQ/oqy6MNVyCnWjR8MV7RbgY4nJPi4rqsN8eNZVzMyjkm5qB14rN3P/OloJW8EpT3Aw5JBWgGlOwCvzPSZbUXdiMOSzfAh8w/TCh32mV3z3JkVh2YBY1Do6W35zUx+owEfwGhVSwfAts0g1nTK0LIuuLQVPKlqBMG1wAiPqATLGIRA5sNIjiulWwIzz6hj1hrO9YWgOF9N9if+DJMtigCQ8/DB8yXGUMDyXqyamd9fGBv94YDadB/zuytdP6ydXQx3yIMf+41W3xVpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzf80A6UNl0c+AeuquEEdkgx4bFh8TXtW1tqBqMXe6E=;
 b=Euq3JSOracsJw7lsxQQGWt9glftAiIp+RpSvqdvu5O3udA2pgfPK3ZtPtYmOyC1AzGQyfjOq7wiHqWxGu9bcVkBdUBpVTb05TVENGbnGimxU5JdGsPBCf8cdaqqipvOqi6A2ZmxP99sF/BP73BeGapyQ5eMQ5pDusjlxQwDGCctwaNLX8ASsfRH7Yb9X/PeA9fHT0uOX93EcV90xUZRIYpBuX51oy4t5lyEwpkSSJrizpLTuZsggqM1cDOlGncPKNqMhW+rscRvO+TCevHQSxZx1jjmPA9YiY+mVFTixrCHbwoS8PkUyhv+RrZ57+G9UwVXCnXOT0g1r8AnESg2F5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzf80A6UNl0c+AeuquEEdkgx4bFh8TXtW1tqBqMXe6E=;
 b=gkQiV24EiGecB3pU7h0XstIYJl6WrQlU9dmlKBVi1zxuKVF10nkCslUJZUISb5c8i/Pi+FKin5eZnkqzxjy7XIbi7M1iynZ3+8XOtqI39HI1DhFoGg5gW5/FGjKZ6qiY3bTGQfrO7DvDmtBHa2sYx/zYdXFCdrb6T1KAUVz7zsE=
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SJ2PR13MB6355.namprd13.prod.outlook.com (2603:10b6:a03:564::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 06:26:03 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%6]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 06:26:03 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, oss-drivers <oss-drivers@corigine.com>,
 Long Wu <Long.Wu@nephogine.com>
Subject: RE: [PATCH 1/3] app/testpmd: add/remove multiple VLAN filter IDs at
 once
Thread-Topic: [PATCH 1/3] app/testpmd: add/remove multiple VLAN filter IDs at
 once
Thread-Index: AQHbqrky8iVl0cYnc02cahTWZWVi2bOep6qAgAQOTLA=
Date: Mon, 14 Apr 2025 06:26:03 +0000
Message-ID: <SJ0PR13MB554515437957D578195B64CE9EB32@SJ0PR13MB5545.namprd13.prod.outlook.com>
References: <20250411081005.1133509-1-chaoyong.he@corigine.com>
 <20250411081005.1133509-2-chaoyong.he@corigine.com>
 <20250411092703.688a1b65@hermes.local>
In-Reply-To: <20250411092703.688a1b65@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR13MB5545:EE_|SJ2PR13MB6355:EE_
x-ms-office365-filtering-correlation-id: 930c8dd7-bb2f-4a47-3bbc-08dd7b1d3b50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9EI4lRZnPDRXhqS8Q4etgvSNnJ9YARhXll1cFisfc5ez4FsdoXrrI++1512k?=
 =?us-ascii?Q?/HLMwWbsZK4dg4cVSv21hr3F+PfxnuU/lh6e0+zLtDXe/6ozwfMSmlwTkCSU?=
 =?us-ascii?Q?WJJHuRyYDvAXs4wr41J+kogrAnX2nsLoOJ0Lb37sr5b4FY8lZmIRpbSdS9Kq?=
 =?us-ascii?Q?au2D98F8mXe+hQeQPO5L3FEhOVkf/23r7HMQ7Jn5FCRcLwa04a3i3WvNLdQQ?=
 =?us-ascii?Q?kSS9TNETTHfEUUj5Yw7KMXprC1p1GixJWWOTXcFSZYgZZCX8QXLzwLDdNAS6?=
 =?us-ascii?Q?FsiWSTOoTTDFPzFLsr9DZ8c+dfkCMrOUMtNILJa/5aUe7YOsweniffBbJTDV?=
 =?us-ascii?Q?cv3sbUOWBAhthU09mMkVRNNWM/EZJ8GQzPfBx7qhppwFN403FH7h9YE6WWeR?=
 =?us-ascii?Q?64qs7JWqqOJONTKfPxGpr8Sd2CCikVPIv6FY9BKSBwmECYJmZasLlZrrf29T?=
 =?us-ascii?Q?y6Ze2xE/zQQM6Jrt2pP008U8HwyC/xTiVKtrLgRzbRGLCifq8gTK5fcZj3K6?=
 =?us-ascii?Q?ygRb1lR4KOhEN6YC943ee+7/0nUDbJbsZ6T+gYsPiJmyOlueXkePkFIMHbF/?=
 =?us-ascii?Q?9QuKLfaIOBx5aFW15nyRK6IBjQR93mUNJUz+JGIVhy9pT2VQ+j5pnoK683Gm?=
 =?us-ascii?Q?XWv2EcafK3CLdmK8r2ZaQm69Empe5YSD0tcd0iwDnArmZc9iZYpETlAHOxPs?=
 =?us-ascii?Q?YmpNh+2AXdj2q6W7Eeqk3zxEFjPo0SJy1trJZt4vqSIltkCXgglsAqxjX4t/?=
 =?us-ascii?Q?Oc6ApdTnNZAsTlHupknbBjbb/4A3/DLymQmCxh3n/3KQPH+nm7aUdsgD9GZ/?=
 =?us-ascii?Q?MvvYEO0ofzQnBtO5p7n1aNbiEmFrNohgz7T3LfssxxHB9Z75KGQTKsdhJoUs?=
 =?us-ascii?Q?Ong9mxwc6WCvNy0YbNGWc8jOCll/ICm/uioNtu6XS0vEaYOjyT2jw4whcgv9?=
 =?us-ascii?Q?xq+cTvDl5AQR97PCHp2B+PoaCWrQwFajfBouWk4aXW1+eLVML185js+kjK+O?=
 =?us-ascii?Q?VqYCC4W36tqDQ1/K8+Hk9aKm0sCa0N7ffMYVHSa+QzntGMww2TR4IHvuuh1K?=
 =?us-ascii?Q?OAdLnwyoe9VcP3C92w+Ngd7B5g6DjqzeN8p9XffYipRpcnOaMiSH2FYUYYjH?=
 =?us-ascii?Q?fvSHu8W8qmYOzqvNW5872QvDlxT8mCl0PGr/8vvVlTvbkY8oa7Tp4Wpdfs5n?=
 =?us-ascii?Q?J8X0VlXYHkIJ+wczG2H/4nzpUJqX+2s5y57a+HO4n5BL6ym0OZfY7PI2nf+b?=
 =?us-ascii?Q?JtecSsT6+XOvWUpvYbS87GR3rT7u29g41CxtAnvisGg0pxH1gQddrSxwk9Dk?=
 =?us-ascii?Q?2O3V0L0hz3KC8ijq/7KQ53jxOYQoxeRZNqQtBbiDcC+2G0aq4Aoelpou8jKG?=
 =?us-ascii?Q?xtwYUCqX/n6PXRyBqPXVFlBjdDpCjncS0EwiFiBGrdANO7/wpJyDk8Rnhwhq?=
 =?us-ascii?Q?qpCcX7XH3N4LzapqjPKe827XqMCI4eQBZ/0hQRiWl1VkQ8gE4eH3Cg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BnW6QX3PPuequxxJWvzSrnKqRJLP6v4k44BbyT86lh0L5skCzbhzNCKDEiAB?=
 =?us-ascii?Q?eTGkcGA3uvOWPcwXYwTfLqZ4cxJQ0S/R2RZOKWS3YUTOl1j7n1HQ5xMhL2SL?=
 =?us-ascii?Q?ycU4NUryEnLI1XXdonLkhX8nVjrK87fSkWTpARFmFFaw/wZ2/ZQlhEh3f4io?=
 =?us-ascii?Q?QHnSMOmPrkZxSUS/8auSBeamYxKrioUhOi5W++MX5IBVWmNpH3n4HH5HuM86?=
 =?us-ascii?Q?PBTIPpvvMSx1xd2xB7m4Kvw/hOxozT0kKLxdA55VnGR7UCrW/gE7YKo2gyR4?=
 =?us-ascii?Q?JXk15u2tu20V6U0ppAJ3wHEX+YbDDLXXWHfyxPsitna5pa7tOjQstPoyPrZx?=
 =?us-ascii?Q?Vw58e8Sf+SdNU/mjnv3BBgYqvgpjL/wxaWEyLhS2EX9VYRKEv1MixcQC6K5s?=
 =?us-ascii?Q?e8FyCARgDiABxEdrJ75AijqcbTDINLfSlKsKFytcVo6hVETGDm/jSt5YGcFd?=
 =?us-ascii?Q?RcmAOH1XrKDCl0lTPvSs8R5U1nxM7dypFKLIq1rZNtGdVUXiMJktGMS3rvR3?=
 =?us-ascii?Q?iHsWJP2drPylzjRbjmN0i00LI5kd4C7KfJNN5XcyHnsKOfbYWFmehM/DPl0b?=
 =?us-ascii?Q?14IzymtuzFXyy1iSxrPObsM7jsrIHaKr6u/RjlnOktwM8A1WB6mLXeiHJOAk?=
 =?us-ascii?Q?393hvomhVa0Rnn0j8QM1UqOEL0YZVAe+c0u+uJHCfVpOuykg8HMfmsAOdOwj?=
 =?us-ascii?Q?9nDOlXXmOP4zezQ1Ce0gCKBRIXCvkvcRTObBkKKc56/tGAKMYhx6xF9K130T?=
 =?us-ascii?Q?OvNrJfT5F+sHbNaOlGg/B65icXbj9apvGfkZTW7RRzCIp9gS+DKwwidBecAr?=
 =?us-ascii?Q?R4jIvmFUfY4NbOcZOGpfOVlUcfT4Xtod2bSyd5jNWnZ4a7C4A1jhNC0iXTgZ?=
 =?us-ascii?Q?jWlBj/UL0h34cWbUsZr9FCBoaFZWg1EgPJEJhmVInCWrWgNDKMhBA8CgPqeZ?=
 =?us-ascii?Q?zA4z6Ohr/iN1Sxel6QWftuWDeqkwKXgy1kfBt3vmiFxgG1ge5sZKaE7n1St+?=
 =?us-ascii?Q?KvWuXJ9SggS5rkp2TLrrKS6x/NaRc0t/R1RUZ0xkAuue4KeW/V6iHaZnN+Ik?=
 =?us-ascii?Q?wyFEehEtB5IHjVbnAR0fMcNuJTKQPchRn/ID+tR98Usmm1XUqIQ/m6RVjGx6?=
 =?us-ascii?Q?0pqBVo/2DK/29VH0vlw7tK0zxiuSwyixTh2xcoKFiP52qScM3odMuz0vp6hm?=
 =?us-ascii?Q?h9G6YMsPkqjQlZSG+37FBdbFnr9Qt6iwnHmg6O61VSitPHdFbphxC2SjCtko?=
 =?us-ascii?Q?gFi6pJquu7NI658JRo6pB8/8QU7ZF442RyDDRpf1L5tFqXBEAIfsfW7TEKeo?=
 =?us-ascii?Q?SbfUCeDOdKqwcrEaVzi5CZ8PREClqB41DS8QfBUA3Y4DVYkgbYm3nllYJ7lQ?=
 =?us-ascii?Q?2OwOfrtthuYXGpVg3EfgFDXMyMv1Y9RrwaArshYe5VZ6BukhvsYxRJPwDoh8?=
 =?us-ascii?Q?eHJypB45ZSv9zI/Gh/iWc947gF6I/RAXvfwAJnAE+v6UYJqzk4QPFs/UAL87?=
 =?us-ascii?Q?uQ8fvGFhCExkKgssWDT+VbtjzZOx+gLF09709xZfBz4mQZePqvfuzdGr2Ltt?=
 =?us-ascii?Q?dVBZtswU6ZSxbiyVBrvuotmNjDZ//slD3Dps8ItS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930c8dd7-bb2f-4a47-3bbc-08dd7b1d3b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 06:26:03.5264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86W6Oa6vP8M3MvmXKfsYWmaolX345wR1hnHOpLDsNotbOpr67Us+c0irnzYbZDVCbzS7w2Qbq7frvuWDuvFqvd/gA1svT6a0d8Qt8A9lYNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6355
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

> On Fri, 11 Apr 2025 16:10:03 +0800
> Chaoyong He <chaoyong.he@corigine.com> wrote:
>=20
> > From: Long Wu <long.wu@corigine.com>
> >
> > The command of setting VLAN filter IDs can only set one VLAN filter ID
> > at once. For example:
> > testpmd> rx_vlan add 100 0
> >
> > This is very inefficient in some case because it forces the user type
> > this command as many times as the VLAN filter IDs they want to set.
> >
> > This patch supports the user set any number valid VLAN filter IDs just
> > through one command and it is also backwards compatible.
> > For example:
> > testpmd> rx_vlan add 100,102-103,200 0
> > The VLAN filter IDs 100, 102, 103, 200 will be added to port 0.
> >
> > Signed-off-by: Long Wu <long.wu@corigine.com>
> > Reviewed-by: Chaoyong He <chaoyong.he@corigine.com>
>=20
> Not sure if this is really worth the effort.
> Testpmd is intended to exercise drivers, not as a production forwarding
> application though users have tendency to be lazy and use it for that.
>=20
> If consensus is to implement this, then DPDK should really have a way to =
parse
> a range of values (already needed for cores). Then the library code could=
 be
> used here, rather than special parsing code only for VLAN's in testpmd.

Okay, we can wait for this one.

Then how about the 2/3 and 3/3 patch?
Which are add a 'show' command for the VLAN filter IDs and I think they can=
 split from this one.
