Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D72AC02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 10:56:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFFDA402A0;
	Tue, 18 Feb 2025 11:56:25 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by mails.dpdk.org (Postfix) with ESMTP id 885094025F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 11:56:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9N4CdOxsLINALfAubhTjJhugwCtAUWFZUJXfCGTNSrGlWLNSE8yKDTFYGvVzkIsJnQJLQCIBr5bAVsL8q84BrNb2x1COBfhJGgng4Duhf6oGPpM1xD/w3wH/i+L6xvfsAlvfz8eCeo9gyaTluGu6jb1W+F/zmT6QMzJvWxgXpCMxuAPFSMBDlph9JvrlG8lEwQvWBGkQnc6jLrCvTPreycEEg6VhqftnTahj81NzrcSH9gxtLqX3cm9OnJCcGPuLJffuR/E0orMaM8EFF+D82c+VPuM21IkeMHrQgBFz/upGeInRcmXAbjfZ6Vl6BTG3tAFB7mBR7tgymcYLPCM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg0WXU3ZSBJ8b1rGM19s3REoZQj7ZrgKnS8MICLo5G4=;
 b=tjGALqPr+MRHpq3PFJOfP6G6Yv7WQ2gcFD3FZOMiwdbPevfqjJlAVlAWamo81A+e5YzhnMK9JifnqHyrxmq75VFnL8fLbWwJpjbfI5hQm64OB8IJW66tKM0na89FoM7Fx+Sex2HVceEhPYqcIFznzurppp5MBWrmOEyVhb37Q4u8W1n1eLb6CqbtWutma3+JYvIegg2GIruFWmsWm4i9H+L6C28f50w3Xe7macX2THyjDXdxsiBXhpM1H2aN72vxarDUjmmpwnCosNvScy1TWcJCKfEHl1PN4weMgLKyRoNziLQicrfTuWxw582O4QQitQWWrSMwa/xo1OhxSups1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg0WXU3ZSBJ8b1rGM19s3REoZQj7ZrgKnS8MICLo5G4=;
 b=HvNmYH7FB1YKb+y368pr17h3LfRgShqPJDKijagwyBWRLXJousdIA3ZyAqhtgke7rY2CupWZNSuriLz4Bq+GBnIOgYVZ4kGRsweDwDn7RkMnHCcjCHWTZq/Bz/GIc1UWLmmw04EBw4IUjIopMW+o/ug2GT3OF/YmpmrW6Hd/HzoqPzFgrjQEb6x0lmIReAcikI/kcdERbEVuXxqUfRLIFiZcbn9Gshg5+qkk2SbMQ2DiByiWzUzcKaW8F6nt3eTuFfq7PazOwUjB0h9X8CAeqcLbytzpperRv68gb2LXurjuhOq9pxRBHXk9OWuQtIMBjuADb2J6rBBwLHNEbxvQzw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 10:56:22 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 10:56:22 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: "Minggang(Gavin) Li" <gavinl@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Alex Vesker
 <valex@nvidia.com>, rongwei liu <rongweil@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH 1/2] doc: fix mlx5 VXLAN matching limitations
Thread-Topic: [PATCH 1/2] doc: fix mlx5 VXLAN matching limitations
Thread-Index: AQHbgfCf4uDl/wtsXEWhkow9eqNxcLNM43tw
Date: Tue, 18 Feb 2025 10:56:22 +0000
Message-ID: <CH3PR12MB846070CD15C2D7CA93195F5BA4FA2@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250218103322.166461-1-gavinl@nvidia.com>
 <20250218103322.166461-2-gavinl@nvidia.com>
In-Reply-To: <20250218103322.166461-2-gavinl@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|DM6PR12MB4385:EE_
x-ms-office365-filtering-correlation-id: b7efd354-0202-44a4-c783-08dd500ae199
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TEkL//7HMxS1Kh55epa63ZXqFy6AivS2+RhraQh+M7pEhG8zZrwwLC50RT6u?=
 =?us-ascii?Q?SLYtWyOXWh8LGtu9FyYbByrMWz9l5+ZJ2anPKWbRTmGZ57LsChSoR1SCGWDl?=
 =?us-ascii?Q?lOtXvU9T1Gcx9bUHXDTg3RPRigIbygknvUO35eRKC/rXJZkRL0ICLjS1Vmlt?=
 =?us-ascii?Q?W3tfLKQ29mMXw968BBPc+V7GaCCOBoEGYJ5/pubtHeUVJm8qIpsvzpOmmVpi?=
 =?us-ascii?Q?jk5rpVDNgWoj+FizO0sE9GYBtCAQtRuul1dEW2G/GDJPaDXSncK+zxr4rxYg?=
 =?us-ascii?Q?L2YfXHg7N+lrSq5wsueeCR+h7uezJ8NgWJrctQw4yvky0i0nYO0aiOh81ZLX?=
 =?us-ascii?Q?JYOvNDfE8ZM/wHHfYn5KAUjxaWCkho/nekhWB2U8Lt0W0etzQhZTl8qjDkSs?=
 =?us-ascii?Q?GDkxCY3MYAq1ClpIYvBEgnmwynPE2t2c40P0X6sUs33KEecslxaffIvhUHaJ?=
 =?us-ascii?Q?3sIZCpSUDvIke9zg7RXTUT9I9tfKJwyxtileWRDb3K7KbLPJAqNxVwTdGLy8?=
 =?us-ascii?Q?gMTJfpHme+fUi9mpiomCj97dAEfvCA7wWWwmsl1vYA2seIg42ua7hQfP6ebU?=
 =?us-ascii?Q?j7zVOEnuA8PfPaOZNttCJAFyckYZP4qESNP40gu0arVFO20prUI279U1Pnv7?=
 =?us-ascii?Q?WBYFZC5xBjtzRKK+s5vZAwp+llsXEWYGwwXrelEtQu1gD5WWpeSccoImRTdf?=
 =?us-ascii?Q?eZumkHx6hv20u/Y6kLf95CU51Q5rY9VJBgTWM08KRSDS68HBuQ8M3bnQC1Bz?=
 =?us-ascii?Q?GAtQUMv4xkqy3CJJNYyJrYhrRf9YHZ0UC6UxmDw2jsjym6aFXFB6Tyb729d6?=
 =?us-ascii?Q?OhYUuQG8wKAOtAcX1r51xYStz3h4/yG2Yw5Z19218zVZGX9TrCrQe2ACvDxi?=
 =?us-ascii?Q?W6ThOup42Lhi4harpsFx1lsKJ/8dO5jTLbVPEeJNlMHR178ts20JRignwdun?=
 =?us-ascii?Q?MeJtj1yENqVCkbOZxOwXyK2GZQnIaJZ2h7V7sXxZoOd958GimACYycM05scZ?=
 =?us-ascii?Q?VwwN5UdFrJ87UKUgSMbB+J5AAs4Z9LS3qmaThC9yxqFAAOFSSTor8Apsid7b?=
 =?us-ascii?Q?C7R086SyFovrRVrL3QaXlv7h985b0LAU1vg6yrXzDWXgzxgyXnbeg20Zo9f8?=
 =?us-ascii?Q?gRO/bqTrzTW0D12TAuzbe7JiKhQ/dj4eIV/lHjAHNpGMIFzjmjXm+Ey+OWr/?=
 =?us-ascii?Q?kmixwL4sON9kWZime54G3i4Pebx++o5LiUyWv+8Lj4IuQua8Z3SCH0eUnU3y?=
 =?us-ascii?Q?FokiPcVELuQiBh5O8sO6DpgzPq0sGB/cRYpMvgdVMKICjjKD5i8QMuKdNMZy?=
 =?us-ascii?Q?2lROcs61gYauNq6jOCHW2OogqAukB9keyNdCP38tPxuzo1BtxDXmR70rMEMk?=
 =?us-ascii?Q?g7dSAhMIV9uNO6goGK2ks7IyAM8y0HCw53Nl/uTMW2qtCviuN1horzN3yxyq?=
 =?us-ascii?Q?Cb0WQDmiYoX8fGLc43JaDeerOGKdqOAK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UHPMiHaRtY7tEzg8JSJoEJQ8Calr0QP0F4O0acAovIj1PHgGzJTSUszDG7xs?=
 =?us-ascii?Q?yx59TcHvWiXWk02R0ZogUKQPfjjCBHNuqBrLhWIxvmalq3WU9MYhXSoMwIe+?=
 =?us-ascii?Q?baVwEY7owZD9AC+olUbt2M249cQSklukkOCWlJguvZgyDeo6A55ljoa59tza?=
 =?us-ascii?Q?2uzvrBEm6lhZZxxQDXItHPa36R3BWLL1egrNI58saWd3jQThWkN3j1zMElTQ?=
 =?us-ascii?Q?8wjS+QMWv4AAsbhwHP30R0qny+m5ygiK1VQ0VoEJaDzOiCQe+6M8o4fGWIVB?=
 =?us-ascii?Q?keaEDtHe/m4VQmYs4UUVzcPx+qJ6LkSWgAPba8I0lfBOTke2EBJU+13RrFrG?=
 =?us-ascii?Q?XwqKP0VzLB8iZ9eD8kTgjjKnDqjkAz0Pe3HWFAefTtujJbUqz1lvDU4KVHOZ?=
 =?us-ascii?Q?twi5cCWjub26WnMy6dOKAmaBM/bdZzl9oJLCkzjeZVSp8+29V365DpCeveDa?=
 =?us-ascii?Q?KVJLqEImnDI6xnu1aFDO4+3zk2aj7BdDDGRvHETAFN54ibszhD2dRXVvc42s?=
 =?us-ascii?Q?KoeoMjBHqlUlEkNVfm5q1/7gcpubWP/QNRh5VIOKMRyiGkXG6LXELmJaU19u?=
 =?us-ascii?Q?/H2drbzu0oIPC1JI6KIyWrJ7U4ZI4z3zaFPStqbdyevSHwH+ANIRTN1T6ya5?=
 =?us-ascii?Q?2pGUQE+C6cZOXtEUWF++QblBTzneiWPN18GHOLnAaYRaBAaxDRNYvvDZZn7O?=
 =?us-ascii?Q?Q1pdnK2YsvsBZYJR66i0e4l+uwaYyPReccxM0a0nqo19P7iqhg6KrdMznSAr?=
 =?us-ascii?Q?NiHZUeMjtSTUrFFkUx5MStzmPEmktx1CodFAmxqlelPklNuvDgXccr/a7VjC?=
 =?us-ascii?Q?1fDNkc7cyOIu3SSMHZAXS3KEiDVgOHi7COwHQDqA0K8Uor511cETseSxJD0p?=
 =?us-ascii?Q?Fo6ii7qggnb+ETxpefWlW4bPjhhRIrAZGFo7XR4Yu0ZPpHvzT0a1i14iL+Sd?=
 =?us-ascii?Q?mAWGebwz5Cn8nT4F2CjTpoxms8Pof6Ro4eGusUDAlrjBVVGf4+Atxs25MPRo?=
 =?us-ascii?Q?1SmHmp3Rivc3YRw2ASj29xAaBnLhRC5+W6vVXvMRLco0DUKXTEmvqK+nxkFt?=
 =?us-ascii?Q?Nv1Prvz1uCrgWL36B+ce1X0AyNxA9jOjJDrb0TMZJZHjN0ldTDSYHQ22D9sm?=
 =?us-ascii?Q?vvpWdbQozvwqtI21dKKS0wrf2gX/SCo0G3HSfBc5VAR8L6E4ddBk7f/lhHsP?=
 =?us-ascii?Q?gGN2tzPmLEnF8JeFl2fXbZXOsmq7Zqzokcp+usFM4E/fnXtTrsHCN5bkILwT?=
 =?us-ascii?Q?euSPDuhnioWc3ECbtMT3pe5DgZnbz3KUvwJZiBbU1AyJG/IovczFDiFUaU0p?=
 =?us-ascii?Q?hvAsCi7agGeT02bV54sAUBQhYp3EbFh8V+/z6StnIEDT4BWbC3pmVurGvCPu?=
 =?us-ascii?Q?DvWMG+nZbSXwNEICBapvGdYxL3aKBvLUH7zd1oHXKfLqquEYsLdqQYXxjS6a?=
 =?us-ascii?Q?OF22UxIuUUzt0dLr4/5sW7X2mrw9mgaPWB63+LGdRQzhNHmlIhJyY8+8yBF9?=
 =?us-ascii?Q?YrywmLtpn3OzKujK29fdNb2f+hFu0E2m4t0HJY0I5a0rT1mUWGOAMPn+nvV3?=
 =?us-ascii?Q?IYBtzThZP2TzKYM1NGigexEM2MikugYLzR2ciucC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7efd354-0202-44a4-c783-08dd500ae199
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 10:56:22.1124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIx9J58I9TAgriEazTg8Xq7P5k3aFADdnKYzoHn/5x+99orFvu8DNSu4c6UYek8LoeF274YHeJR/11c5HUBS0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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
> From: Minggang(Gavin) Li <gavinl@nvidia.com>
> Sent: Tuesday, February 18, 2025 11:33
> To: Matan Azrad <matan@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Ori Kam <orika@nvidia.com>; NBU-Contact-Thomas
> Monjalon (EXTERNAL) <thomas@monjalon.net>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Alex Vesker <valex@nvidia.com>; rongwei liu
> <rongweil@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH 1/2] doc: fix mlx5 VXLAN matching limitations
>=20
> P bit of VXLAN-GPE and G bit of VXLAN-GBP should be set when matching the
> protocols.
>=20
> Fixes: 49765b78c81b ("net/mlx5/hws: match all VXLAN fields")
> Signed-off-by: Minggang Li(Gavin) <gavinl@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
