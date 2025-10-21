Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F7CCCD19F
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 04:01:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 590AE4025D;
	Tue, 21 Oct 2025 06:01:43 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
 by mails.dpdk.org (Postfix) with ESMTP id 9D03F400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 06:01:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUt/9o2CsOEXsKTD1WkLvv2/7XrU/CyWh32VE2jBGd1ZP8+C6SiufmwLgiaAHhrXRYkhDgjwKBrwq5vaDlKIz5yqH1QuFA0/jyQXl4/l20noWEtvWpmxFRg0UbfI4+IyXYcS1WpGTSFOUoq8dFt4rko6Yv4OlNMF46XPmQaImey+NdaV+OULGlR02MxJyB/jkwhRT/RHM/HoWq0KDeQNs/5FdwSKyZPNmluJEYIZs17fbtJ0OtXvURLsx82ywtiUugSj7rKp5bAYZlx6hQE3xXdCLjCbeUCIphhEEEH7ty7WHU6YgKJyUIT3WBbnZACGZ8YdBpg5QLkY19OSNamjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AeNtAH/0bVjvOZ/C6Ezfq4fsKW2ca6wo8FAqoOsAXs=;
 b=m+D2aTylUpI5C5gFpxFMbVd1eW7r9BgqUmg7wsQ6UiL6QCdlf3FSXRGnSUYBRC4bxkJ4FNsuqQfJLvRrOeHsM978VXr+Gll2j8bSNrSGicWvKJ5ke4pz08MzVKttdnzcFd4K1/fBerxKIC7REdtuhf0nsoKI1Rk7qvClfUDAJfAOOHbbjlOmNz0fB6UZGxMK9gKCCfnHOUQEHhG9uggH9pArWNP8Wf7s15E8sQqDY0+DI4j46Im3Mkb9HTzkpwBM6YLmlk3m67GHczWcQ8FPME9uzviRFImBwC0tWP78jgOFp01xy3k9Oxn37EpPK9TLvB5jIKdYiogO76+gpureMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AeNtAH/0bVjvOZ/C6Ezfq4fsKW2ca6wo8FAqoOsAXs=;
 b=GQrin7bc7sjGhVy6THBs3tyvwzgspMSBqO9OyOAcu8XT5YtU9Vt+TE1ZdMBCfWEZPsl7+sE4AliCuJNECtWfm4W0E56Dc3L2Q9z8nYY7XGJbUg3h5KVWl0yPbPpEmLX/Z2iqON63ZVJJl7LClkyagxOIoJ63ErOW3omfQdumWfU=
Received: from SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Tue, 21 Oct 2025 04:01:40 +0000
Received: from SJ0PR12MB8615.namprd12.prod.outlook.com
 ([fe80::220:c7d1:9e75:8fa6]) by SJ0PR12MB8615.namprd12.prod.outlook.com
 ([fe80::220:c7d1:9e75:8fa6%4]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 04:01:40 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 2/2] mailmap: sort mailmap
Thread-Topic: [PATCH 2/2] mailmap: sort mailmap
Thread-Index: AQHcCHCftF1pOQDiNECaekgjC6rkjbTDO6+ggAABlQCACTCP0A==
Date: Tue, 21 Oct 2025 04:01:39 +0000
Message-ID: <SJ0PR12MB8615FD66226E62FFA3BAE53482F2A@SJ0PR12MB8615.namprd12.prod.outlook.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20250808142721.408998-3-bruce.richardson@intel.com>
 <PH7PR12MB8596E4E3C090C148BA8A528582E8A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aO9QFopivyfSCal_@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aO9QFopivyfSCal_@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-21T04:01:17.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8615:EE_|DM4PR12MB6110:EE_
x-ms-office365-filtering-correlation-id: e9b6b0a9-5bea-4974-778c-08de105689e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Tgo5oduL8jhyIe+9JWf8rMpugpKotBz4X6ew1Op8AXitAwVUChDiZI6hre10?=
 =?us-ascii?Q?Xpf91FMA1G7mlw3JJtEpUD3zOM+BeEuYZL52niwhIvDSWXajEyWYLUVFbzi9?=
 =?us-ascii?Q?hUayxdJoPrhtaeJnQrgLyWJRbZ+uk9bTG1Rp9o0GWbe0qJ+hZN6KS6FjXJBT?=
 =?us-ascii?Q?tyOxKUAwiUjZXM3i13TbsRkbuyVb3jtcsBmq7XsCO8C1D/1iwbJeu/BnZZ4R?=
 =?us-ascii?Q?u4APe63+/ZYcViqtMh0e5Jd2fLlh+mo1q+w//Ko+S4870AXyX0QsA+3qlHjc?=
 =?us-ascii?Q?uvbSRjcB2Fpkj6TT4wqezo2xYW13jelbRUytUjApzASg9iNYLZf4N+6dFve4?=
 =?us-ascii?Q?2f+/lRgEEjxO79vDeDrnMte+fQfXlbzud3lpNIFSUQ5MOYX3CzUpYRipu4nd?=
 =?us-ascii?Q?mriBBs1mJZTq2ATIpPr1la+cl82UvGLEpVlHdhsLjpLM/bPfldjncLKf657p?=
 =?us-ascii?Q?hH6mE3qOLs97eFaxFkAnPXeAi4LoRSMgSUBtxz30rpF6rQ9QlILUVdEH/0sj?=
 =?us-ascii?Q?OlN/E9FzFRS7xzw6FaHmH3DCs26zK6en2awUJLmGNvJr6RXlFBpqCmKU82W6?=
 =?us-ascii?Q?GKXcpqx+42dpHvMyd/LuveQsbNk6u7iFaS5a+3V0Yxka3dXwgsTUr9IApC8Q?=
 =?us-ascii?Q?VcEBQwh2perEYyay+0GGlSreEgXt0tJcoocCYios43f5NjH63/JiO4xsB3Ag?=
 =?us-ascii?Q?TdLJGqOvqfaphWerGPwAu5s3Am1/pnVTWXVRd4lWKcCYsZHxnGUN44AKr1aZ?=
 =?us-ascii?Q?fQoIXg2zev57B5g+5IXaL4047gEIKXwpL2sQ5zAHsTODfn4GBQHaZtHrX4nJ?=
 =?us-ascii?Q?pbcSkTY/WsiD1TY84naB7Jm1QV4UiEQWYszCQM4DhC+1LCbo4IB7nSvL8Fnj?=
 =?us-ascii?Q?h0d0ThRdU0c70kzvM8d6Q48D63SHfFPvQbPv3CXOz4PSZOeSjD3mRuRhl5Dg?=
 =?us-ascii?Q?Ge3hfZj7CjVGCpNbGV8OdYo0EoX1GtdUSxR7JCK836D/QubibxrYm8r+ky53?=
 =?us-ascii?Q?ZXjukYUx9eJQRe2TajsqIC8GnFwHn1onSWCGWBNW72AKw+M/huh95+wpNhLD?=
 =?us-ascii?Q?pSp3kf4RsfHEjWVXD+87I9jLB1A5P8Pn1bQSs+gDIUwsyDC8bfbmseZyZ8wx?=
 =?us-ascii?Q?Lv67pTLBP57wr7dE1q5IUsm+ODeZS2y8x/VRcDvSHlBuxQNEUtw9B9FJSmjj?=
 =?us-ascii?Q?2oQC3viT0F4UkU/SypCd1ojSusRGM5n8aJnOcGljDPbmn/TFzlr3agdViszr?=
 =?us-ascii?Q?Pr6kUIaYCoocRFs4jMSRmIJUC02sP93Znkwq35ofPBqTQeelugDHV9cEPxku?=
 =?us-ascii?Q?oIR1A5JeSW5DgnQp/9kLyQvqZny/8ORjYCkFMzADJi5uzhBp1wCVzQp00yk7?=
 =?us-ascii?Q?D3YGFBZC78KvVBJINYrUxqBM3eIIgGfoB4H8x0dYt+tTaetDTT7QyHst9Wl0?=
 =?us-ascii?Q?rEXJdU+WpZQI/NymyMf0oc9dPkxZ9hppYM2VFQvA6h0k5aH2zBRiNlyeBgPO?=
 =?us-ascii?Q?zGEJ34q/qzb4nEgal/AJTNisZZrWTLMiopTl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fKZGNOXvxgZSbst0ewSL5quXsvf8Em7+ca4Sev5AIwYnuMBWKhA9FUVPyU/b?=
 =?us-ascii?Q?niP3tOtzP75GQjEZMXhfOcATFjQ806zw+3rn65e6t3AE4fZUV+zzLE2oUsRZ?=
 =?us-ascii?Q?t7SWnskSPKocXCO1o0uWwpucYF9eGvPSuzx1WG+mDT0UjoSd4qeIxiUUWqlh?=
 =?us-ascii?Q?7BojPgwkT5prGdvEYeibPqNqVOKUmos37shr+HNqGtjCIJKTHhciu85euhYW?=
 =?us-ascii?Q?Ik4AKeVYJS54W0dI8/lI6BQY0dJ2U97xwHOMhxGiMv+LlgDpV0LWhrFeLmHv?=
 =?us-ascii?Q?hJWB3qkIkJnUyNhWblFBsOu90fW3QSY0KL4xY6qVCfEB27f5ctJhRaKEhK2E?=
 =?us-ascii?Q?hVaACChsJunczZOoeVcQ8VuTntdss1pUDSME7v5z/FQFlbm9DqbX9xdlNEnv?=
 =?us-ascii?Q?RJvmuclyJrnc+AJyqKHndF7rWt9oaRPS0RXgyOTRElkVwTANGPMPOuIvGluw?=
 =?us-ascii?Q?FFTk+GnJdXt8XwLmbKTCyW3ObnmBxcBjChuFs24g2U0A5s8uuJsIJWRnc1FQ?=
 =?us-ascii?Q?Vannx8/ahTUGXeDEfct/2sm5Oc2LRmuC4GZ7svLt56RYIHXASDwHjcj1Kyag?=
 =?us-ascii?Q?4rhLJcHc67yRaZKo2mqdNUk4vjgO0b/VJBh5WH0wSLuAA+4E2Ke+LxazXTAj?=
 =?us-ascii?Q?p4oVDIin4UG23vdjNN5ex4bvJYvUkXKkRy0gga4Su4dKnFV9F77AvaMPq89x?=
 =?us-ascii?Q?TAA2nC4Bz1y4U5tGvqszI1UWLrm5+mser9CubGR4klnXRNtgUXgN30XQGEOg?=
 =?us-ascii?Q?iy0UCchCHLDdG0u4LHq7a+9UohxuU/w4/kZprlVYSAgU/uEPp2mwl/iZC8oN?=
 =?us-ascii?Q?LE9NMKxFRkwGpa18mN4yfRS3DCLQP0P/8+STdcrDmyJ6KTzn8G/UC1DGo6jU?=
 =?us-ascii?Q?/cBWCeLbFjsp7GS0e0F3K9UCqduOMtal6qpxaZHAw7ilcZx5uwG5lzOc9oFs?=
 =?us-ascii?Q?jDYysiCtKp+2iUGoP5Hkkany5jjhTnidD+JqpGNXYqics4kmfcDPhHc5HVu7?=
 =?us-ascii?Q?+bPDwE+FuigBUBEQ8j2RrEt7cI6XSQ1ehdqbwvgMRHyUIV3u6Ra9KBNhVSZr?=
 =?us-ascii?Q?eRLQrZ9qe+Vk23YPWX3aJlu55X0b+dyPqXNuh31wMMXzEVogvfBUYL6p73T2?=
 =?us-ascii?Q?VOxUgvnFP4hHmooxFzMpGvmiofVCPF4YOFSkj38CFZvsHYlZ+kbsH2ufyDaK?=
 =?us-ascii?Q?tJvP2Ikr1pBgne+oG8h39BVJwMMf4D6TtAHQr3hDGgjjMwZukRSS44u72dUg?=
 =?us-ascii?Q?c6X+KC+nhyBo9g2LuM20oR2ouoacivu5MKI+jYnLZyaZdjrX8hyAUyWQAGxF?=
 =?us-ascii?Q?mCgPtRz2FnghySjRxDKtBESxbD4l+W6eRO3STaXsGsV+834OL+JAg8pHPL6/?=
 =?us-ascii?Q?X4K8NTSp4kelQ91r/0kzXgdGAoDqelT2VnBJ9umn1bRu0Y4Ei9XmYr51cvWW?=
 =?us-ascii?Q?RMTPFR0/a/N++qGxdfgbbFHIA3V51+aVo8kitnvgz9xLpbmcGpJ9DTlz5MWa?=
 =?us-ascii?Q?5Ce/8ADKNkWy1ICGolpge1PQMJw3utEDHTmNrpoCAtlNm/aqI1lCmQXWawsi?=
 =?us-ascii?Q?D+nR9koxK5k+j1QLU/U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b6b0a9-5bea-4974-778c-08de105689e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 04:01:39.9847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ak8JG1c2SBtMhrqTcpNUfrSzyQk5cVdA2cpjiQXr8f7fmSoyaNh0xAeWZMJvwCMq6amxas/EcPDzTrsA2GwWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Wednesday, October 15, 2025 1:11 PM
> To: Varghese, Vipin <Vipin.Varghese@amd.com>
> Cc: dev@dpdk.org
> Subject: Re: [PATCH 2/2] mailmap: sort mailmap
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Wed, Oct 15, 2025 at 07:38:32AM +0000, Varghese, Vipin wrote:
> > [Public]
> >
> > +1 for the change
> >
> > > +Vipin Padmam Ramesh <vipinp@vmware.com>
> > >  Vipin Varghese <vipin.varghese@amd.com> <vipin.varghese@intel.com>
> >
> > Should we update, ` Vipin Varghese <vipin.varghese@amd.com>
> > <vipin.varghese@intel.com>` to ` Vipin Varghese
> > <vipin.varghese@amd.com>`
> >
> I don't think so. That would result in all your commits made under the ol=
d email
> address being counted as written by a different person. The map entry is =
to map the
> old email address to the new one.
>

Thank you Bruce, I learnt something new today.

> /Bruce
