Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F91C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 01:40:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC8BE40280;
	Sat,  8 Feb 2025 02:40:51 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11020097.outbound.protection.outlook.com [52.101.56.97])
 by mails.dpdk.org (Postfix) with ESMTP id A4BFE40270;
 Sat,  8 Feb 2025 02:40:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXKm/X6g++FYjYEpuoDb5iN/99TI2xrCmlPHnYaC0gpw9zk999gFDseMfe56+SkbqBQcPh6LxO8lVsnzMO1Gdzco+XXzaxqp4fqJXAepDb54hbuIKVZvovDMcgdU+llzzc2R90FvDlkKMk5IbQTrSetZpJkrADcyqma/4fMKy1MVCK5EaSeXQp5IR2CT87fAmRZvztwSjaM3pSojlsbaqz9g7bW7AKGKHzr58dGFQBJSPlJugVJ7xsbwRSvatMzesln0Uv84OWRST3BDtZFHlFS1+whGSwu8mloXVpmxk8RiiWpoMxhLdd2z6rVkoHpuulEOIzQ8DNjs4rmirKIBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ox+PlrOkohTe3KYxNGBn97M3/PWqytfYsynA8uhvCw=;
 b=yhx3sWPP+ZNFaamLAoyorkS9nB2TDZadEkwEvfkWicbQceGZfeHQnNIKzGmDCSR8NZdvJQlFixR09UhlwCfIThK7hjG9Gu42xClsrAlykqxhmbUbwxe/NSfIaeZ3+jLw4XneM2SGteUByFO80JrZrDWjeNx4V/DHh2q/Ns1r1/Nd8yXFwTONNesjzHXg4cfxbS+Jpm6CsDqCp3lAv+fG+KD0HFDKn9IPHgVJ0ohZmVkO6GOAf/HJUNK7k6DAGNcU6Sn3337qQfs1c/H0XnAjoGvo7Yzl1mqc5qUVdSg0EW0jYVTSobrn2i9sbz5SdbTVPNY1/YvHtfmQs3eeCNpPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ox+PlrOkohTe3KYxNGBn97M3/PWqytfYsynA8uhvCw=;
 b=RftOVi7WGflGr+fGe1a7COAsONZfTwn8W0sV4DoO+1ThjjkSGQBGtjqT51qYOxIsK3KhU/LPgJmnRnoRDWKSFyVF3V3LQ85fc3Snkta8MjxeWPPJv2mBDQDRBJ2TSMkJAsVh1qTFf9ih3zDqlr4L9okOWQMhWDGBhkZTC+eJBK4=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4180.namprd21.prod.outlook.com (2603:10b6:806:411::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.8; Sat, 8 Feb
 2025 01:40:48 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%3]) with mapi id 15.20.8445.005; Sat, 8 Feb 2025
 01:40:47 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Wei Hu <weh@microsoft.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH] net/mana: use mana_local_data for tracking
 usage data for primary process
Thread-Topic: [EXTERNAL] Re: [PATCH] net/mana: use mana_local_data for
 tracking usage data for primary process
Thread-Index: AQHbeb9nGqnNRjPQ1U2/8xYH1X/NSbM8kuuQ
Date: Sat, 8 Feb 2025 01:40:47 +0000
Message-ID: <SA6PR21MB42319E6E18AC3411729727BACEF02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1738970505-7864-1-git-send-email-longli@linuxonhyperv.com>
 <20250207162124.112f0c00@hermes.local>
In-Reply-To: <20250207162124.112f0c00@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6bbf1b65-20fb-4a6a-bf5c-b740a1025acb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-08T00:48:45Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4180:EE_
x-ms-office365-filtering-correlation-id: b8b64cf1-cb4b-4818-4f6e-08dd47e19cbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MmtjiXM21pcODxN6kuYap6ZRNd5fvMRu1O/jmAX8DYPJX7cZ7BlhOjkTXIUS?=
 =?us-ascii?Q?mYV5lc7bmS+rxNhsNGyCT/1HiFMJHk9xJj4MEM825jG0qrcnCuH50ZunSPV6?=
 =?us-ascii?Q?ETDPwZAgZaufEeQX9UJpevlPSs718E9fcRWbzFHzL2iUiZiaScTmrHfME0M/?=
 =?us-ascii?Q?oNicUop5f2UBiwyC7KYIijmODcYsKj4/mGEAI81O1XQkyQ+bJ1WhugqTcBtp?=
 =?us-ascii?Q?gkHnxv/xwVw/MHrsTngmER9p0gk6mZsas+4SaOM02DAYs9D/NX6M5/DIVONY?=
 =?us-ascii?Q?qNgujWc6G98I+Gw2UnfBSaNXCDw3rd0utHmzDl/OoHIIqWr++ZYaxg7LW5b3?=
 =?us-ascii?Q?6SkSPF3P76Q28Pu+rgI9QpNylDnZoYLW9LSIIPH8i0P848e7R24+RvmmXIHl?=
 =?us-ascii?Q?u/ghBVwdIyxd21WBVQlTE9J0RIaDL47sptM729Ip24RODvvo0sI/CbUsjgcw?=
 =?us-ascii?Q?F+C/SHnGLag9Qhcv81yF1eLpK3x6s0AKuHiYAuYe13p9eR5rMijVxynx0PT4?=
 =?us-ascii?Q?h4bI3s0IqHv0NI4TbAc1YrTzUlaNhfCrI88Q53cowh1VzLa0SNWyigz1xAEi?=
 =?us-ascii?Q?0i4VwA6XHHzecCYbUZCaqYPlypqx4fx/Wpt7RD6MRiyFz8XYuHJB8gY4krso?=
 =?us-ascii?Q?8kBeNtDNt7KC2ha5ZynsCnOAlpKKVeOcwVs3FEeY+EYXeBTZLKt4EQmr68jD?=
 =?us-ascii?Q?Ox5rw9M67gd57+9lXeyi5ajrnvzlq8tE4y0SCckrmXqnTBhUlfIZ2RZrp/5Z?=
 =?us-ascii?Q?J6D6TzCBEoEzsIkmOoI4fhmApRdPNQJXeQb+FZhlN/ezASmssPPAFZhY68Gh?=
 =?us-ascii?Q?q7z163+/lcJdzfQYtRLGmYM84LEWFoPfMB876sUwx2Ex0RWn7n8xmiy2qXOU?=
 =?us-ascii?Q?YbQRTHf3sKz2Y6G8s3xWMVK6U7Wrs8U2bnc1je0ExAg1OaAZhQg6Rr+x8S1x?=
 =?us-ascii?Q?G2cLEYGfRgW05zdLAxSb5iTUmHdpqsyHkm59xK3V7GylwCqOZMgg/GSQ4bfZ?=
 =?us-ascii?Q?7kiY2y37mLB57QcMG9U5gvr7iSKIamJ7DRBpMYqEJgSb3E0ZKtQXgrDRyCCH?=
 =?us-ascii?Q?TI7LuIFurt6UsjCS+vdp8LWfoZZkCJwBx3HQCcN66CxlxZc2ZWnHOF5UHkkJ?=
 =?us-ascii?Q?Et3+v36FBmMtjg9vPKtAqByYpOOXAwmQTpkJk4RQu+Z0X99YUjCm/hfFJeHD?=
 =?us-ascii?Q?0TmmgH7MQ1NK8Sw/GgSYpG2WL1K1eZO+7Xo5duDykWSGS82OFTe9vQj3w71T?=
 =?us-ascii?Q?ipKxkxcpUJcqc/bqiz956uS9ouFo4PXJ5YtwcISG8Tfm+7Xlv0jjPmbC0cOk?=
 =?us-ascii?Q?+HMR4ctgnRHCmYuSixu1ZBJCGuwe+WnzeJHwwasMuVlRaRXXH3cqigGQXxs8?=
 =?us-ascii?Q?/h68+HtXQhOIknXHnM8omRh1BF3NMKgbjlvjyDWieRWIKh+Yg5SFMObHkiao?=
 =?us-ascii?Q?pbNT54KI67girFKEG2XrYvbkMLXetu7T?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ckIoOR5nOcJDub99NNlIN4BZaZZFAA7WiHbAeHet6F5hjmGkYpBXa8hyG0v?=
 =?us-ascii?Q?E8sWXZG7jj2y0KXuDg6FDUYflfI7vbWD1XgzEXmvOzl8Lz0z6uK4h2IpigLz?=
 =?us-ascii?Q?GrQK7ui8QzAw3Qo5QHFEyfIYYB+GVTJERhMK5Wji7fmxahCRh6fzWLyTmk+l?=
 =?us-ascii?Q?whGId7DMe+HzT+TZu5lLzc/HHs3q1so1TTlW/+U6Gkz2ie9NeHOF9CBUUCqM?=
 =?us-ascii?Q?Yw53NSJ8+18MuKSGl4+f0hTzeaOPNzWoTaw3Sf5en2mWYyJWgBteFAaWzPZx?=
 =?us-ascii?Q?DPjlTIqJ0wx7KAkgHIw6ePghmXatrl0bN73tF45XdAXwjarpKNFHLteJRRjT?=
 =?us-ascii?Q?9TI4piAG29NdbK6u/xhLwtAmWE85XltySqsHDGb134SCva4K1hmRy9QEDawx?=
 =?us-ascii?Q?fh/ThlI2UdrJH4IFnm2nDiQ0EmKcgXnt/DnEU5AOBf6HXAHocL+jrf8a+EsD?=
 =?us-ascii?Q?r+9H6OZwltOP+ES2cutUQ5CyGxLoiQsDqssDBviBZsjVM7Etab0KWYur3SSo?=
 =?us-ascii?Q?CM3GURKjBt5emsXs7Eereadtnhj3g+WFzKHFsydM0tW84ChAigGQakXoaTO6?=
 =?us-ascii?Q?IvZttV25kOcLxiBSFaDYY1idZ0J9MFoP+bCgfQXcmqNIk1ftzCNWbNxQryrm?=
 =?us-ascii?Q?DLfEN7R7I9mxcgkusy5k32Owdr2PW6UGqk4lQn061Hvr4Q1RPLGjlC8LuvX0?=
 =?us-ascii?Q?DQFJGeLr25dM/E+q7/wJNviAUX3wWuU2SO7nrxTZjar5mP1iq9+2VJzA35RO?=
 =?us-ascii?Q?TqqFOee/f8g1uKbNFKvX2jNSsI3Vp2r6rhieo03fKA7/dEdhYvJ9vYwI/k6u?=
 =?us-ascii?Q?FC36gjdXF+6m7yq+R+pD1OaYLw5eRI1MTPvB+Bw7KYhdg2Qi7P2V09T1x5ly?=
 =?us-ascii?Q?LzIFdp3uJRUNyZIXIO+336ygbBxHsDCFdAhQedzKhvJGk4fqQuDLGBjuRSKv?=
 =?us-ascii?Q?7LW3hrChHvzhygkxRVO9g35F+7dIInwH02iV25rBAJzR3/rYJ3B+csi4UPSv?=
 =?us-ascii?Q?5qxzMiy3BIadIZOK4oQyRCkmX/WJLnR06w/QZ/cCAq6ae2hrOUETFLRVVdLU?=
 =?us-ascii?Q?gcjARiN6zCmiZ2LSRcW3rcFtMQNEHmF5liflAhv4dYr1EHduyd8spnCe18HP?=
 =?us-ascii?Q?fw7pG17lVk9G6/QSz6lfv+Vy0kA7L2MS4fv861L3SZjCZ9JP+wcgV37c8FpJ?=
 =?us-ascii?Q?dIOIVyENUYb9BTYEu55hwdJ5N9+qvFLqxIvNpiaExmL6M30JI8eL07YfpXRB?=
 =?us-ascii?Q?DJsOnFOMDO807W8nXhdnxlKoFUPnTETn40OvXXbOz1W/EvVvUl2ZoZiQ+mM8?=
 =?us-ascii?Q?bPUkp0cpCZE9ESsPbY5sppVMRT9TONVXC4nIiyv2Q9Mr+eHxzp1sLmqq7kZ2?=
 =?us-ascii?Q?mGafyWm2o/CD98aPnxUXu1ZbfIfKuDzD5edTdBtR30zbty93NJfx7brA1Q5g?=
 =?us-ascii?Q?oSibs+LT8zUGnbTkyrR7asUBFMBULjTZrjCYMV8I00l0QKZdRt60wqfjH07A?=
 =?us-ascii?Q?Ru/MKkG8+FPgTfmXcQU8ubeWWdTKeGMYER3+47HvxwjpA7NOQzfbutRmpcRL?=
 =?us-ascii?Q?spTMP8TawOGB6pMKVjU47XYV95uz7cfp9P+4nH+Mkn4WVFLKWjgO1Jo9imM8?=
 =?us-ascii?Q?5GP9WPzFSziFKQt8jM/4eAF6a8u9lYXkNPl2byWpHi6t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b64cf1-cb4b-4818-4f6e-08dd47e19cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2025 01:40:47.9071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cULlXATtr64tZq9L2nufJGPOMmlzPxzy5YXYvNcv7g0/IBLcFYpMhCqpQ1lLO+WpOLPBdON9e9jUttujvafcXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4180
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

> On Fri,  7 Feb 2025 15:21:45 -0800
> longli@linuxonhyperv.com wrote:
>=20
> > +	/* At least one eth_dev is probed, init shared data */
> > +	if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> > +		rte_spinlock_lock(&mana_shared_data_lock);
> > +		mana_local_data.primary_cnt++;
> > +		rte_spinlock_unlock(&mana_shared_data_lock);
> > +	} else {
> > +		rte_spinlock_lock(&mana_shared_data_lock);
> > +		mana_local_data.secondary_cnt++;
> > +		rte_spinlock_unlock(&mana_shared_data_lock);
> > +
> > +		rte_spinlock_lock(&mana_shared_data->lock);
> > +		mana_shared_data->secondary_cnt++;
> > +		rte_spinlock_unlock(&mana_shared_data->lock);
>=20
> If all you are doing is wanting a MP safe counter, use atomic operations =
instead of
> the overhead of a spin lock.

mana_shared_data_lock is also used to protect init_done, mana_shared_mz and=
 mana_shared_data.  That's why I'm reusing it for primary_cnt and secondary=
_cnt as those values are initialized in locked context at the beginning for=
 the local process. I think this will make the code look clean.=20

I can remove mana_shared_data->lock and use atomic for mana_shared_data->se=
condary_cnt.

Will send v2.

Thanks,

Long
