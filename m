Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80D3C61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 05:13:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E69340666;
	Mon,  9 Jun 2025 07:13:02 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by mails.dpdk.org (Postfix) with ESMTP id EAF2A40661
 for <dev@dpdk.org>; Mon,  9 Jun 2025 07:13:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVn8CBcvU7SSLvJtuq7iOrarUT8M6g9/k2qOdwt2yD2Mf5R7lckaeANnTnaBsWFG3j6EgySVmn4fLcA/HIbjBuu1eFAJILlbmOX1IR6lAGdsLKL6mjkpa5fEllo6H16AkPuclpLlOdBShoS9dXXPgZgU6aLQC+1lQmdyUQ/n0dLAE/08CaNMWOnT2+ymQGGQM+yL5bveCnKXX5YGQLIo0JeMEkdVAaiZRDBexK0gGTIo6RtxtTcGQ5A6HYx6gtM7SqtvwQ/Bc5m50iSJwGrCG/jpTKHDW6i1vDp4m+g88nOPolenRkHGcamAHtv3aHgA9lYbelvwktNyUPHoaUJtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujkykS9NiDRTzUJ2SD0cC0BJreGLCK9pWJ9ZqDoTd0Q=;
 b=S6cuISBox10HXF8XXZObOlErxbjEaMJblgZRof49fWNc5KyR8GDF4uylcorGJThn2dP3xR0FVjsuitliUoHTRl8/5YwczfGEmckqYaiF1QaKaCAI7CQcUISoKv1wdvfUlP3kRgvXxmBk9TRr+QEo54EWJEBJ8FDZx2RTrYJj+GhxeupbicvEmGidqajbUrITkQARs+d19g/ojj7VQtBGZR8qjw1KuZ3bvJFwpSM0yMp8T5vNIRfrSLKaniq4d0tx7QwpVAvo8UkdvwYo837iqu7BQDO55vhmeF1eHAWn3o1yAu7kTilUIt/lAx57TUuMM/lwBDJqq2QEMXyx3umKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujkykS9NiDRTzUJ2SD0cC0BJreGLCK9pWJ9ZqDoTd0Q=;
 b=T6ocYEa2O7m6RdHutEuErrie7ucSDF+vSXQdhreRrq4n8venltXA6um0jkhvIRr8z0E7eWX0CsSIoE3Sh3EjkbmXRebpRD+Mv2FrrPid/mpU04tkz6LLyLkvj//4Rr5ZFLahpvWbVni3zhTaSrKfAfbT4V5Zz4tuhHuvuMZNcbc=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by SJ5PPF6D27E3EA3.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::998) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 9 Jun
 2025 05:12:57 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 05:12:57 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH] net/intel: allow fast-free to empty cache
Thread-Topic: [PATCH] net/intel: allow fast-free to empty cache
Thread-Index: AQHbkb/5/lZ+cDcd2E6r08yYmebLr7Nse+GAgBxB8QCAchYxcA==
Date: Mon, 9 Jun 2025 05:12:57 +0000
Message-ID: <PH7PR12MB85964A4F15AF14E7486EE85D826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FA63@smartserver.smartshare.dk>
 <20250310132540.1341258-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FADC@smartserver.smartshare.dk>
 <Z-a3ELVHCCbvyDIl@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z-a3ELVHCCbvyDIl@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a3e451df-3f11-4e4d-b877-3a713b25360e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-09T05:03:00Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|SJ5PPF6D27E3EA3:EE_
x-ms-office365-filtering-correlation-id: e4d139e3-b5f1-4a7f-0c6d-08dda7144c4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EzR3qCkvMv1bfzX0h0IPbHd0yRjJg0Ocx48H7G80PidEKl6GdfQW2JCcaF?=
 =?iso-8859-1?Q?9EffwnuZi5h6W5/5Ze28GyG8FiN3enDgkrVLAzDzpTUDqMEas/Hvh5hWx7?=
 =?iso-8859-1?Q?l4BnocoF3DXl/eWRryc/roCUCXHYks4wF7+ZC00HTDju+KsrORQc5o2hte?=
 =?iso-8859-1?Q?sChXwP79Swe+W7tu2roUqy3pAUgTZxHaNBrACqqF7V+JQhqKyVA0lWCIO8?=
 =?iso-8859-1?Q?sN6R6ZM3f+FshkDTvSbaCPW+urbVEcU+t0xUhXvWcmeMLllxaakVTKZnyH?=
 =?iso-8859-1?Q?WwinM+PlX50R4p3Ah3pgxYgTXtbc+zwdWU1uYBBYw0NDC0YFK6KGmWVRAj?=
 =?iso-8859-1?Q?281daGZFU8degGiwkSxBqeLW0Dv4OX+fWH3Zggs8exNWKgOkVBkN8dZDIm?=
 =?iso-8859-1?Q?04nzVpZQBXes+TOznKCyRWcCceHxjfGFabxaSVXlb/YC7HizFMnrY1AZEa?=
 =?iso-8859-1?Q?/Xyse2xHXo/4ZFTXzMdrlkKfzb5n52QIXHkvGZY9dbrsxE5aDEYQAIV9of?=
 =?iso-8859-1?Q?AzcSdrlFmFzMNmXs7WlJN5PaBacL/V3nyuTOJZRrQEWUiZBy/ldWsYk9rB?=
 =?iso-8859-1?Q?6wiZ/25UQVcidMuxTV9bTMCLcV90kS9Gl7u3/yAih92WalNF+ElUfpcsif?=
 =?iso-8859-1?Q?ZCX/sjNKlk4tI7anOTxnTdZ9qzxoP5FBPMXoe5yZto8Mjyb8bYcyTblVlt?=
 =?iso-8859-1?Q?sXKFZTU0fcZB5aCqIkMbaTwh30gScNC7L87eU2dqP+gua5JHLoZBUw+HFX?=
 =?iso-8859-1?Q?aAvI69jvJ9D9QMWqZcvFHHZjv9QSXCEDn0cEyMQ0A04l3dEENrDaVX4pCu?=
 =?iso-8859-1?Q?Bjwd5hA9zzr2Q9XZj5W9aZ87NXTYWRk/qtOgq8YaVe6yKnth7CAZY4or7g?=
 =?iso-8859-1?Q?i/sVSfBrSYhvpqkn+TI03lW2oJ9li8UW+PAovh/o9fLvUMcz8A0Z881Ht+?=
 =?iso-8859-1?Q?6v4ZWum4YCpSc7N5M7I5KAYWI2bMKNdp7DKI9PwVbWMnrDTd9xjhK24m/9?=
 =?iso-8859-1?Q?dSpTXfLBzER7aHVuJunmXxSGqaTbGIeLv5m9lE/lvDh/sbSRkT/8u4LC4T?=
 =?iso-8859-1?Q?La5fMkMFovoa1NfxG3xSggGBhN5k1a5n1s388ZHYIeWaUS+EkVtKTFfok8?=
 =?iso-8859-1?Q?6j6fR1+gllQ1MLKR0g1ByobDOj+M5FpKDAQY3iZrfQ5IZ5SAnWpBrbyOpu?=
 =?iso-8859-1?Q?jEY96i6EEPrMJpShqjHjVAE3Oxgxse1VBW8TqnU6yjjeBbr+cMIEtftlBK?=
 =?iso-8859-1?Q?tjm9VivPAPoHL6yL0gdEKQaHSzYHPO+g2BCrWRbr95+npvvVNQBTB1FJUg?=
 =?iso-8859-1?Q?AENel59v8zEByS79ufRLHgro5GyQaa+Wqu33EpGRqsWoq0N02iu4/TIEvk?=
 =?iso-8859-1?Q?jZmriJLO84Qup7WvLD0gby4PUImhX88fLLCzX/F1WoSI4XT2/uU4kPbx2C?=
 =?iso-8859-1?Q?CxQt/sye3w0oOwNDEXNLqxlnB5QsTb00U8nSb8+OBSimOFxTSzfheqnhO9?=
 =?iso-8859-1?Q?ZJNTSyEyuUeLxLUA7EeaA4vMjRhnxpn7d6cclrcfXN7g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EcQAjjBc2mnpwB0dfxMeDq17RSNvQrlWgfCjJG3rzG0n0r+rq6K6e2269/?=
 =?iso-8859-1?Q?C5kDEalFIVpJ5pmeXxtzn4G8lnAk6eCps9+EniFH/fKsEru6aq1rdvjq8+?=
 =?iso-8859-1?Q?zVO1qKZyD6a1f13wyxMAsNTdAqgeRaLY7MWcUw2sdJsyCMVErVnJghqgDW?=
 =?iso-8859-1?Q?UlvnQ0i2L+LCJcBW3J8zEmhgN8RZIP9GhmJOEUC2CUOx3O00rK0rv4dzFJ?=
 =?iso-8859-1?Q?raQeInN6b9X8Hsw4aIO5LBVr8+Aq1/o8kL1N7iBdaceKl3VUCbry1MJVUw?=
 =?iso-8859-1?Q?lag/Ei9Vf9DMt8YRZHHX70EMtQSuzZ9glYl1t8CfzXgiVk9YGzCEd3L2XN?=
 =?iso-8859-1?Q?XQEWH+NgSBDDHxfLin084MONMusYLLTwWrd/5alk7ng0Lj44Kw5+waCUl2?=
 =?iso-8859-1?Q?YS8hJKV08sHfTKULgt/X2bUTdC8Y/ncy95pX4F/uV4P2KJX/2ySalbt0LX?=
 =?iso-8859-1?Q?GrqCUfRAhs+J4wo7r75oGIL/iGEF8Dfe40Y/jfTF15pI7WjFoTgj8Q4Xar?=
 =?iso-8859-1?Q?xL3eYanrStxHKDdjBXz3j/so2rmZrtLvruOyt9oVCm0GeQqLNZeUXeHpx2?=
 =?iso-8859-1?Q?A16pHBmekpU9P/Yd/HpAyO3Di/f7Xw+qrlikGfiJ/cP/VHav6kLcOBoNRX?=
 =?iso-8859-1?Q?Z696efJnde9JRXEEoJ2MZ6W6bincUG6K+ujexT1zYNpZySGJ4GxTZC68UV?=
 =?iso-8859-1?Q?9pIK6nYFBrwSLzDkeBHjP81dC3PJigHxkwjEYawat3BH0HVU+gkW3YwwEM?=
 =?iso-8859-1?Q?81nMapyruZYbnw4FlgXjpwW1KAICU4C1j4qWYqrdALGKYRpLGk9CfgVUE4?=
 =?iso-8859-1?Q?2vNc+kwFvFHHUnwTkCeZSYxWqeoTvnwlOsxhcatoxVP4+mEiuU6dDSbZ41?=
 =?iso-8859-1?Q?uhd/Hz+DZ0LNN7kHryLpUpNlGGA+FI03iAFpFaE7xupLLVBb18iuO/w0D/?=
 =?iso-8859-1?Q?hbxn3TXJ8Q5X72Vzh0Wkzb3gsUxcgSKscdnngb669Z1DHzbIhyXgmLmiR3?=
 =?iso-8859-1?Q?rwKYbGYYcP2nQB2KVJbpIOIefQrW4Z3BWqPBlke9+En4Rm1HhYwWTMtjOt?=
 =?iso-8859-1?Q?OdOtkBr6jWyqTIm7uQ+2HJkPnUWMOApZ5PbXmMzy2TKxiyl+lTNAkSG/eg?=
 =?iso-8859-1?Q?JDbz9aKFXN3rOtk1PRvfqFz9yNanSmldTX6PYjfuz6U3pFiJB2aQrCXEjS?=
 =?iso-8859-1?Q?xpkWdyldTiRsscF7zg3dyGxqqFMsvwXh6m3hpjVkZunF+wGsUbu4YsDi4N?=
 =?iso-8859-1?Q?icYyMnnSGx0BhIew+A851BtmEAt6UUlaDyBY/q9KySpbEtALDoSmo27FJQ?=
 =?iso-8859-1?Q?KNIAfvckug2AO5Ld6ErWXNyKMQZfQ9aIjcm+8tBmOqlLVZvgffKYufLUS6?=
 =?iso-8859-1?Q?7Almn8FoTQnJzJ/r+DYl/CvOZq88WhmCr7UnsPaqBlX8Ck3RauGXxoVcK1?=
 =?iso-8859-1?Q?Up2JZL/yPfhKZY0x6Ewxsj9I8X5NcV12zgxqe9WtFYl0qjp7o6tZmvbFOe?=
 =?iso-8859-1?Q?aLTWKHBDG3xWBK+6eieLDDT73Z5Mnqwkd0XXsWEIji3kCorgIYeCL57lL0?=
 =?iso-8859-1?Q?wvSnSGL2eRHemszGMvpl1Xss+IihZp0GEQxw3hVdjCsW/O+53O967vFnlj?=
 =?iso-8859-1?Q?V/MaUYVnLVYE8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d139e3-b5f1-4a7f-0c6d-08dda7144c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 05:12:57.7438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msvTQB1hPfhnHFD+s2idlfd8bMd47ifCDaskUmRcLnvtIerMw9YNZoM2vKvmazIOwGNBSAPVmRUpqOVqP6GhTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6D27E3EA3
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

[Public]

Snipped

> > > When freeing transmitted mbufs, there is no reason to send the freed
> > > mbufs directly to the ring if the cache is empty - only if it is
> > > zero size (in which case the cache pointer is NULL). Therefore,
> > > remove the empty check and only check for a null cache pointer.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  drivers/net/intel/common/tx.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/intel/common/tx.h
> > > b/drivers/net/intel/common/tx.h index d9cf4474fc..d361fe64ab 100644
> > > --- a/drivers/net/intel/common/tx.h
> > > +++ b/drivers/net/intel/common/tx.h
> > > @@ -143,7 +143,7 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq,
> > > ci_desc_done_fn desc_done, bool ctx
> > >             void **cache_objs;
> > >             struct rte_mempool_cache *cache =3D
> > > rte_mempool_default_cache(mp, rte_lcore_id());
> > >
> > > -           if (!cache || cache->len =3D=3D 0)
> > > +           if (cache =3D=3D NULL)
> > >                     goto normal;
> > >
> > >             cache_objs =3D &cache->objs[cache->len];
> > > --
> > > 2.43.0
> >
> > Yep, it did look strange.
> > Reviewed-by: Morten Br=F8rup <mb@smartsharesystems.com>
> >
> Applied to dpdk-next-net-intel.

Reviewed-by: Vipin.Varghese@amd.com
Tested-by: Thiyagarajan.P@amd.com

At AMD we tested the code change on the platform `AMD Siena EPYC 8534P usin=
g Intel E810 2CQDA2`.

- simd: AVX512
- TEST: DPDK-TESTPMD in tx mode
- cmd: `./dpdk-testpmd -l 15,16,17 --force-max-simd-bitwidth=3D512 -a c1:00=
.0 -a c1:00.1 -- -i --nb-cores=3D2 --nb-ports=3D2 --rxq=3D1 --txq=3D1 --rxd=
=3D1024 --txd=3D1024 --forward-mode=3Dtxonly -a`
- Before vs After
-- TX-RX Desc 1024, TX-RX 1Q: 117.12, 117.13
-- TX-RX Desc 1024, TX-RX 2Q: 117.13, 117.17
-- TX-RX Desc 2048, TX-RX 1Q: 117.16, 117.18
-- TX-RX Desc 2048, TX-RX 2Q: 117.13, 117.15

>
> /Bruce
