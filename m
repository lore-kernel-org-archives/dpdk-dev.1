Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572D6109C058
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 19:11:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A8894161A;
	Wed, 25 Mar 2026 20:11:49 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by mails.dpdk.org (Postfix) with ESMTP id 4EE96406BC
 for <dev@dpdk.org>; Wed, 25 Mar 2026 20:11:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysl+mltXwN/upsVQxQ8L65pMdgYv58+4TPfbFebqfZe2YszyH1QVMQrzoS5i7qmSI6kQ310seohNFSQysSCZv42Aw3mV/DMNIBcLqpZOqhDW95gs6KIT/ZQDiSVDRbKNSNbh1aFO24kBuvvnI7rlgo9iXZMk61r+Ghg0ivN1zJaD8A3aXwl3s5HeAILrA8A0ocI9DyEx6EKJttGoxp2JhRgNLxyAJ3N1drMJi3tb76TWHLKvZv/hP9OIefLmdkTVVBBgPfcXD43nxaY/JiQ/utevzbQjVDlDf9F/N4Xs998nehN9/Gx9FHrfwKJ1iJHoESou8txWRlhpPsBKZgTO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oMrW0n4iQXaRRtT+QIbSOOj+elvzRqB1150UWBalzU=;
 b=M2ei0dhbVVEJg1uEB72nfU8gbuHDZz0C/X+qViK6/3HFTnm0CtYm3UIWXrD3J815veLLGRVYKuKsGdsIuwF0UhrVi73klbnwtNbgtLB4W0v+CaTSFySu17JPDhSH4BSxRQRt+XWfuRsSGP8rGW5kL82rSuMwWpYoZQODkhGxrI7yUSFAWLzVJbnC5N7PZY036L9Mh/NSWmUoCej8VkR4/bNDjRyNhrL9riPUYDTTU8Sj19WBs2xI6BnjUjej+OJke/v8343DT+w3hoimNky3ws0l/i2qt1ghDl+p2Ypk/kptvz+LWJYA8pGFWeuthSbrnubxrUkvkd/ha3JVNZPZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oMrW0n4iQXaRRtT+QIbSOOj+elvzRqB1150UWBalzU=;
 b=Bm0oMGOp2IUJLE1yPZxEizkbjaKhRzbdA6r973Utbo7yv6w1AUslO7E2lfFa2ztxrT47Pp+7bKKCf5aOokuA9e49OPsCupDL/I/JNb0kgugBOLPDum9XpS5sGnWcFyRxyI7+9HRWTThCC9worzsp3/yi7Zwr2Swa53KxeeFpE/wf7opvzglq57J4syisGHBQBQs7bNkQg8JLT0TnHFnCL+zt+eXuR6/ESpxErfDNnpXq2EgFs1Gr9eCHoE9M/T7acXQmFjcdzvYTqahiIQtebt/WvczDfQWB+5ucAdVgs1etxgVyEi519yHfQQzf11pWfZKsO9U7yuraEllglmPW/A==
Received: from CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 by CH1PPF2C6B99E0C.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::609) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 25 Mar
 2026 19:11:44 +0000
Received: from CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837]) by CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837%5]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 19:11:44 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Aman Singh <aman.deep.singh@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Raslan
 Darawsheh <rasland@nvidia.com>, Adrian Schollmeyer
 <a.schollmeyer@syseleven.de>
Subject: RE: [PATCH v3 1/2] app/testpmd: assign share group dynamically
Thread-Topic: [PATCH v3 1/2] app/testpmd: assign share group dynamically
Thread-Index: AQHcvIHDyaRmvmHvhEG0OPlb1hk+mbW/l8GAgAAFkzA=
Date: Wed, 25 Mar 2026 19:11:43 +0000
Message-ID: <CH2PR12MB954129699272336B2CA653EEA449A@CH2PR12MB9541.namprd12.prod.outlook.com>
References: <20260324165657.23945-1-dsosnowski@nvidia.com>
 <20260325180255.57489-1-dsosnowski@nvidia.com>
 <20260325180255.57489-2-dsosnowski@nvidia.com>
 <20260325115127.0326795f@phoenix.local>
In-Reply-To: <20260325115127.0326795f@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9541:EE_|CH1PPF2C6B99E0C:EE_
x-ms-office365-filtering-correlation-id: 9434302c-975a-4ed0-8974-08de8aa25a85
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: nEW05ohvsv7019DNAm6SP6Qh9vCgXCfJHQ6IImMIj8v/QCrRb84BVWn+BNF7XeT/EU1eUGv1fk6FXcUDIM57tjjehvLyo+p1VxiV4mDvkXvcJMN+AH6WDXXaoDkTmuFwJwpwwvs5fEbDIYTULbJ18l1P+y4wEwOVEMu10+Xk9sC2gQT3mbiizs4FsK1QCkou/zWo4pBSjZ5PJlUJPWPn5UI6uEuVf2eJqhvV9NtTUqPF++b9OYKJJfnG4WHBtYxgw099G1/H25mVPr22Old9CEuIKNMWAm7AG0GMqfEa8eyl872hdeSseZf3gmJbGv7vziDwTX/ixTGMnGPmrgkx+qZmhkneBpsLa3K+n/8WoHzD1zRz/apmTY2tXiy+1X8qgofdRl3lDjEY2MtGYhV/mztumAnXJgWINvuNb6h9PSPqySWUSgWKgIa/N1mTqlrfDlKFrIBQaBNizvzJUrM5VJuQG5hLq7vyiqA6UoCkOMiYtBry1Kz+rCV4ychkLz21TQEmf4fJ6NEAPZpeULkaXrynTi8+WRdvmx6VqHC09Xek9HPjYaqcmQt68B3Gbs5Yk5YN1nqI70S6eyTPvQVTqe2FxPW94dCrpO1NG52BZQnDs1S41ojwaS/C/txplb7tx+ZbZf5i0j+/ljrymuxdF69fyAU5bUoQ1dIxwLARuR6RpROD7V0CkW5AQTusd/amOIEG8CJhB3W1wPnwxj0HvLsgJ3GQczJ/Zm4TRRfYbPo+xnulGkWxlLnOjqfSZrnGprpQUsegR5O7zmIkA/xCvGCwjTE6a7YdtAiGz8yPWik=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9541.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lMozXAUDYMEvS2zFleqNyaP5BJVmu8Eg4HvC4WjzlK0GEugNedNAqjyGYMT2?=
 =?us-ascii?Q?+tCY0Wbb/7+o+sH4dQaHoc3q+IenGz86EadMiL/Af+VZsx5Oy7VgJ2Ah1g04?=
 =?us-ascii?Q?r4EHsHH5UeTeTxn/e71xIJw8EiRzY7TwOOIRL0y6eLMEcUKT7VJZPE6NuwOP?=
 =?us-ascii?Q?3AWOhkNStATOOl+PSwGRW+Gg4HYiKypMoMOT7ldQCod56Y2vhTkl4FJ4njJN?=
 =?us-ascii?Q?cr18fpNRvJCvedKHgPqUUDACpMqxtHs7dA0/6a9pv0T3D87002hRlarYXpIi?=
 =?us-ascii?Q?1tnh0tqQCjj6u+1EkjNHiELksjpM7UdjwzuG0KZybu26ntEJCarQ7iyM3pl4?=
 =?us-ascii?Q?P7ypynPPm/n9Px6t5/k+uISwbQISEqlQO/TusINsjtEPehOrKDNlvxzsXq1+?=
 =?us-ascii?Q?OKUJPGGXjzMSGX0gwEintzzsk5fkUWbN8j+3zubg5EaQ9GdfAY4S9gcZ1hak?=
 =?us-ascii?Q?2IwBAMoWvJwOgD396wc/BYfNxXLqVj2SoOTtrS5e8DBoKx3B77Mq/IUaRWs3?=
 =?us-ascii?Q?zvym0tRawztGNqz/eSHYrauZwqjsWtdhmKHfSsmj+tpgzuGeTIyTf4EVwySG?=
 =?us-ascii?Q?kBgVIriTHUlvqfY8l8G1nsCICxUvCg8h3NOKDEIYaftY9sfdJ9FanjobBVHb?=
 =?us-ascii?Q?ltZKSFpd9BpyDuA2fGGmcCSLUcnWXUTSK6w9nOXxMkMRgDLxzIpygF1QGej1?=
 =?us-ascii?Q?fUM62b+NN8QW+tDI7KNooNAhGQU5/zlNChgBZxmQp6oWDzA90Ku1mL02rBcR?=
 =?us-ascii?Q?ePz2zGm0L/gfVZkckqBdT5MdQ0CrVdblHi3Z8sQNG3VOmjY2w9IWwopSoED/?=
 =?us-ascii?Q?Q5a8+1R//KucYsixuP8+k0xdRIl5nrOZF9ygKb1tPxCYgqf3IhSVQbTXkAB8?=
 =?us-ascii?Q?1tN2Howxc9nE5Uzi6hLCeKsPAGYW77ocREBcbrOTKYroM9TPOMoX3oVP7F2f?=
 =?us-ascii?Q?pFEoBWqyB+5OsjHiLtPbRdcABYHww7mxUS+vZ7kewNBmMLWS3rFOggm815oF?=
 =?us-ascii?Q?0HNvjbbMU+RZVCGZl+jZuJ4XZ/spMryDuZaJ/4aomtcGqddz/AQu8qXKT2/1?=
 =?us-ascii?Q?wJKRtAiKKzmggkRCx/wLrI14ZbV5taEvSMsvcvBK0wJT2PWf0oo55pPaiJE9?=
 =?us-ascii?Q?tEWuxYMOPncky9PovphDnCSj9qNf2LENRrr4h4H5HIkP+JH+mNmj1qoNFkn3?=
 =?us-ascii?Q?0UVR+Aksg8PkusQJcYbxq4CgGHSygcK2mn21Tmt90O7rvJoGz8j4mp5B1V55?=
 =?us-ascii?Q?B67GZhLW6kyKnTtj8J9AbhxL6MCTvAoyKPTBfXezPcho9G0TMf/OHTfV+x1w?=
 =?us-ascii?Q?O7hktXRR+NnAQAIbhntT9HsBiI5KPScqg2UYgpHB7SlbdwpK97ghpbZG3Dac?=
 =?us-ascii?Q?yHTk7NSDMDGe/xtNafYvuu4WpfnZw4NvirPbyhVr4MudqKMARVfTDQU4w8ae?=
 =?us-ascii?Q?1YKoTJ2UyRPVHtIfVnmYFEfz2Lt5x3g/ljZhWqwsBUlwZ+cl8kmmfVqZV8Sw?=
 =?us-ascii?Q?YmLOaHS2rgVNnXIPZbHR8bCh1qYBNijLsFjpMOVnoqUoPSgaQQ282LL7/DLQ?=
 =?us-ascii?Q?eYv4NNqVsBMrb7kK0B0vtMabcise2bcXgo44ZllLBcfk9wK2vJaZw5fNsrJ6?=
 =?us-ascii?Q?E/kMo/R8FEi14BBQrhck+dBgpZlc314nrJuvWchxIaNPjivzi5i1sX8SGg1I?=
 =?us-ascii?Q?hKRpkecvDehGIlW0rSn+ZxODLVJi7OzHOEVBQ0JtK5w8h0y7yZuKuzVWjEQK?=
 =?us-ascii?Q?RPDPYil6Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9434302c-975a-4ed0-8974-08de8aa25a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 19:11:44.0146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/+GiZnGy23ZHWycrcuxrZEhC+1UrFpy7Isw6VwAs17bL7YifQySvhghZadPe2dQWaOmDqiJDXuT8UT5vSwUag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2C6B99E0C
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday, March 25, 2026 7:51 PM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Cc: Aman Singh <aman.deep.singh@intel.com>; dev@dpdk.org; NBU-
> Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; Raslan
> Darawsheh <rasland@nvidia.com>; Adrian Schollmeyer
> <a.schollmeyer@syseleven.de>
> Subject: Re: [PATCH v3 1/2] app/testpmd: assign share group dynamically
>=20
> On Wed, 25 Mar 2026 19:02:53 +0100
> Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>=20
> > +static void
> > +try_release_share_group(struct share_group_slot *slot) {
> > +     uint16_t pi;
> > +     bool group_not_used =3D true;
> > +
> > +     /* Check if any port still uses this share group. */
> > +     RTE_ETH_FOREACH_DEV(pi) {
> > +             if (ports[pi].dev_info.switch_info.domain_id =3D=3D slot-=
>domain_id
> &&
> > +                 ports[pi].dev_info.switch_info.rx_domain =3D=3D slot-=
>rx_domain) {
> > +                     group_not_used =3D false;
> > +                     break;
> > +             }
> > +     }
> > +     if (group_not_used) {
> > +             slot->share_group =3D 0;
> > +             slot->domain_id =3D 0;
> > +             slot->rx_domain =3D 0;
> > +     }
> > +}
>=20
> Just add a return and skip the group_not_used boolean.

Fixed in v4

Best regards,
Dariusz Sosnowski
