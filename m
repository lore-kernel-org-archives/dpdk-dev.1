Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4BDF532ED
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 08:44:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBAE1402BE;
	Tue, 24 Mar 2026 09:44:31 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
 by mails.dpdk.org (Postfix) with ESMTP id 3413D4025F;
 Tue, 24 Mar 2026 09:44:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0hkAku0yw4p7e6mmqg/rfg+TDxewXlQqq5xCDJGKL6ImZn7n+4s/mnGmDM75ptzJKe0IYxOTklKKeH3wUKARZcZSnEJcvYdQuTH07R+UDTMocoesN1X/D2KAsJB8NvVSWMPvhQXzp1NfFwJcYkHeeUU1eXtRRBxqG6gTiUumhvLtiKCB9ent2jFu7b0WJytx8gsgplvurIUFK/+Hq/7kMYACSzcHyd+1u64UTlO4UbSDHIVyF9pK8HjxA9TxP4fmG6Hx7dUSDg9mTTD5XVZqm+5ucb9b43xJlZ70VganebxnU6WazxSCXpRhEasr7wyuNlYjT9fedrgl7J/Svc/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv985UAQZZNxqyVVbC/jGB6C2dL1TuDtkxIMgO+H9DE=;
 b=ITcM3nQvzr7vHboQPUJ8QTqdVaBuH3HIDFjSu8lFDKPfeOFQHXCZQIpO7gQr02JBbyVUeRtcJfYGXdUU9TrC8P555X97sUBDLP4pi0DNPa9am088PWzgS+9SyuzUjujXX3N0G4XK+WH4Keelbo4JvMyCYxyB5f85DncAgCKGMciawrBjhYyESSZIaN+I2U+GNxdcrVGn6u/C1EE5n02D+KTzhzj/esANwt4KeMGgT1uBhK1HzJowH44zhmS+Yvk69gyBTs0ot+oT1nOOaiIzp+xbBWUjW5QWzBrIbAY32g92RGpWqRIpuHK98MCp8ntnjTlluW1mzVBJZ95EP9eWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv985UAQZZNxqyVVbC/jGB6C2dL1TuDtkxIMgO+H9DE=;
 b=gO1W5xbIRUHO1oey4Cl6+4iW3sc4xBmWbvqpLuEgMinQz4a6p25HLU/5nSh35GYGVU1syolJoNxmvGxj7Urii85DsxlDD7Gl2hkDqwuf7RLFMZZjqJvK7U7s5R5B4ac9Z73srxRQQtERUwcO7hIED4f9x9Fwo9X5wAgCvDr2oKzjTC2G8JhEKgAVuDnukvM1ASw/eW6PKw2Qh8bdHEFL+OiiEYQdeb8yA+Nz8jt7XPN4pBRKHutV/0sf8rHF1EakDTe0cHCKFxXDOKIozRclsEwTXy93UcKTxGc25dkYwVAVL5ZHt4GHmKi4UUYxF+CGX7doabQzBJahb17ZnsHmVw==
Received: from CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:44:27 +0000
Received: from CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837]) by CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 08:44:21 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Shani Peretz <shperetz@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
Subject: RE: [PATCH] app/testpmd: fix memory leak in port flow configure
Thread-Topic: [PATCH] app/testpmd: fix memory leak in port flow configure
Thread-Index: AQHcu2XEUuYug/57ekqcmfbsykNA/bW9XdkA
Date: Tue, 24 Mar 2026 08:44:21 +0000
Message-ID: <CH2PR12MB95412CE2E2A9F424CFDDC3DFA448A@CH2PR12MB9541.namprd12.prod.outlook.com>
References: <20260324081045.6022-1-shperetz@nvidia.com>
In-Reply-To: <20260324081045.6022-1-shperetz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9541:EE_|SA0PR12MB4445:EE_
x-ms-office365-filtering-correlation-id: 09b5edc0-0f14-463e-2495-08de89818b1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003|7053199007;
x-microsoft-antispam-message-info: M6VkUEFyoF26ilwSvWZusIq0BJW01JpCTbiB8VOmqS8ZKZXfHWVnxjfUcEa4mCFaa2L3uPx1+B3Wb1/zOYqY2a/RQ3Tzed+F15Nn3Arjyu6OE+w4wuY7X9LJdCL9D2c4ZRR9lGFsSlGgACFi/hT80WOBcabgJzq17LLsT3bO1I2z9881I59KgbE6KEzCj5Nwb1kgmdJ2uTnnl5oJYhHukxZqrc6gJ0izQqltr3T+dZbV2WwTnl0uR+zG1FADSi+/7HlY3f9ozsJn/0EWXo83HpyNH4HWvgLovPBjWyqezEtEYIKQ/dihUyFf9m1LHC/xapCgEhCe+OTEmS8h7nKdQLOygezh/huE+xfYorQfR1HFgfU09d82265giqP7YpJFnVMRlpqRVRsExA4Ljw6rElIh3u5d7czwFNKC/QJsjc1grRp4XtoYXu6qvK0+9CUAF/JrfdphMpL1QAFwZ2Nkf71/5SvmOjV3qCPmfkHEnbLj22Gbpn1KSpSX9istd59lM1VNeVMnxsvv7W7M+MXOinq9q2BXX/lJqBt38lM/BBuc7/KJ3Ay+HAz9acrzY3wsEZsLpTmvZjbVW5ENrGadM4uYDZcWgSdUUY1BG+MlFglk6JNP1ush8kSuzKPI9Psbe9hdiST/1LfU0jWK+cmSBfoegGNXjaC1md6xH2ce/PUwZZju8mPv7MY3gLFXqUOQtG2cCe4t4WnrlJGProrNijpRMy+j0vbHoAsGmyiB1mOmakKeQmEtg6hBBv1TRagjYCOoTxpKvlXCC4mUaWeW9UKwo49xVJUimEd+MyGli/U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9541.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zyXo+XvDTOtptnzZywdALQYvUKDe+t9PVJd6OOCyhcyQpmxgVpnnJsLXfXiN?=
 =?us-ascii?Q?em8F+u0XPlDLvoVxT5TTO9z9BCF4luGgKFUshwhjkvQHKjVeP7ET1PrWraAQ?=
 =?us-ascii?Q?h7vuzpk363iTbtMvaPKb/W809vH/mqAKwQJ7hkKl5sPCBBWN6DTwIs/9knCr?=
 =?us-ascii?Q?FjImBe0j7iOSu2ytCGV0pT/1xvZ6YujCyxoVDB8Li1hSeL0gEoFe7T3UvovX?=
 =?us-ascii?Q?SjJXgIUutMvHu3ChcPHcK94nfNO6wlGtdLyxK5zjJG2G4lXQL+Vhl0CmAZQu?=
 =?us-ascii?Q?r0cgiIGpXKOHCxe5JTcQgohR7aEQdB8CaTAIAfIt5scfuouUe/inJzppC5qg?=
 =?us-ascii?Q?5VKaCFIIxTPIUw0994zQ86D/lH/tYqx61r9PDFt/i6fAbxZ8AFCEMCisTyBD?=
 =?us-ascii?Q?1SNqJMZy7wCXoXl69BebdgBQ1jfbcz999DLVLMrzEW9BgLoZS49YJj4ZtPcd?=
 =?us-ascii?Q?UjK/kw+f2NZ+9wCBrzg/6nr5tnfIAnVz5S0IqDF91Uw+aa+Tl93Z2oxv4taq?=
 =?us-ascii?Q?zlZQ0n4smr7gYvmzv7vpNESBwJ+aWbd2J3SY9hqz2Jmz9civ8rDXrXUJaj3U?=
 =?us-ascii?Q?wgMp8GKmm2ia71SZWKfcDnSJClKwd+433lDVYenRTuk5U7Gc037hTONYQgVZ?=
 =?us-ascii?Q?+VZ+P0YR5ojH4wGOgNHLldSwBfvVxVXgfp4vuD8nh6E+LDd8A9a/ibz564Sg?=
 =?us-ascii?Q?5Lb3Y6D8h6qRyw+WiK4Lgswho9d3ujyEtn2dJixjBDVFumzHVVV/uq27VMqS?=
 =?us-ascii?Q?Nyfx5SEuqh6ZXM8Yc/O3/XAlE7LmWOzRsiDwVh/4mf7WRXN+n0SsL7VTPi+0?=
 =?us-ascii?Q?U3ThxzDfS0zl8u8lDUqqAy7VDG8932l6PLjX8967zPq2K7VJ7mwmLgHUVnYv?=
 =?us-ascii?Q?DXoeWWu5zftk7Ka/YZbHd5KQ8BQqgAPWiTR1elPVcEzt/smQ+cx+ZTpB8dfj?=
 =?us-ascii?Q?3Z/9P7JNAgKnmOknklPcvK0P8UAKF7LdSXJiMY2D+7GX6zTU1hc1POdO5ejV?=
 =?us-ascii?Q?9MHEWEWf6NYKJhh3MNW8w5Bx2Dgb6+1ytJmbNKvtXxncwKceilBHeDcd50PJ?=
 =?us-ascii?Q?FkFd0wTRWtxu2FjUFJHzBs4RWsLP48ehQf7A7sADRAJUHJKwMfIjs3IjQmy0?=
 =?us-ascii?Q?n3xl6Xi2HoYHjABeDmREyplEK+BeYS/uFoslHzNIbZ9cCxw1p79IMGS9yhIZ?=
 =?us-ascii?Q?t5Scq9nT8+IzlsnForkohmfu60CGoZP7LoX5QMrqAwa6z1wyDP+N9qtPhdcI?=
 =?us-ascii?Q?Kx9ZX6dxO4mjE4zi4R9hmwa5HlbfsRuNH7kscnm6ExAj9uh92Y0RNekGiEgv?=
 =?us-ascii?Q?1LO2FuM7iHWVH6/kE0M2sUKRPAHsbTRh5UCQqryoPI5qstCXCfpN51/TiaH1?=
 =?us-ascii?Q?ss8vmet5Mvr5bZzd2oq1jpzP/l/oLF/FTBu1bizzq+/3erDuObrAYVbG+zL+?=
 =?us-ascii?Q?Zeye6tIPnmAIZbOT+zIquMkcRlWJJzuExKhamYluh9W2MPdt8PEOOANjYo5A?=
 =?us-ascii?Q?AOM5EcX9wR/MRkOziiRSpSG7MtYSm893mW+BEl+Y8/wbpldoWxxYbjv4KEjv?=
 =?us-ascii?Q?ykike7YZhctkXbYo8WL1rvcLGcN1o+VJlGg1Tb9fizMaC4fnArukeksH0RLc?=
 =?us-ascii?Q?xLfC/xXexsbkO3k38zC/oEiJul53OcG1T2OJ7tvBD3N7ItRXWH0Jp8hYvBvF?=
 =?us-ascii?Q?Gi09wYJsw9nPmrbDpmL1YKR0UbUiXOkiGzEo3ycksppEoAFzx57LVK9XhenU?=
 =?us-ascii?Q?jW1Jy9wAbA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b5edc0-0f14-463e-2495-08de89818b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 08:44:21.0815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sq0zvhMRrd22yt4U0uwv/uPaH7uKrOE7e1JFqlShll65ACU2+mqkDrHfYG7Eq8g8BWVet0XXYB9HkOONMl1S/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
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
> From: Shani Peretz <shperetz@nvidia.com>
> Sent: Tuesday, March 24, 2026 9:11 AM
> To: dev@dpdk.org
> Cc: Shani Peretz <shperetz@nvidia.com>; stable@dpdk.org; Aman Singh
> <aman.deep.singh@intel.com>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>
> Subject: [PATCH] app/testpmd: fix memory leak in port flow configure
>=20
> When "flow configure" is issued multiple times on the same port,
> port_flow_configure() allocates a new job_list via calloc() without freei=
ng the
> previous allocation, leaking it. The old pointer is simply overwritten.
>=20
>   testpmd> flow configure 0 queues_number 10 queues_size 256 ...
>   testpmd> flow configure 0 queues_number 10 queues_size 256 ...
>=20
> The patch fixes this by freeing the existing job_list before allocating t=
he
> replacement.
>=20
> Fixes: df503d757b36 ("app/testpmd: fix flow queue job leaks")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Reviewed-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
