Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E0FD9E1F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 00:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D47E40657;
	Fri, 27 Feb 2026 01:03:22 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11020082.outbound.protection.outlook.com [52.101.85.82])
 by mails.dpdk.org (Postfix) with ESMTP id 60AF640265;
 Fri, 27 Feb 2026 01:03:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uhs7vSzx3A5xx8SV7b/iapMEwTLJo5yD47qMFluInvt0HHQRqJq4qcWmBj+BDoM3fb/wgcf699AwjaLG6Ph2k+tY0BYwQJUKvI/9NHJsFBfiKFFLVLKQf3TA6RFEkuhpHz+YRyBEhpgzSQNl/MKDRTlAc+PXGIc0G3rHYhgoA3M3i7gpEltLWEs131wq8Lo7JhphaK398JrFbvGeyuxiWVU6t4fk50ouGPGjtFtu3SJL4GFCHvBiXaE7BrudHHpEUwXwLzRcb2bhOPGN3+mXCITmClyrY6QR+u+K6ikPJVklW3OXs16WZJk0NUSFSaXa/fpp8+Hskhqpnl/yvhUzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2zYa7NpDBXIRatHPm64r+THFz+hFdQ/HsWwfrH3yhg=;
 b=dlpRCdEkn+i7Sn1/35p2KWN1YZjaFYZuk2CcSZHZZGeniIUa4ond+mpqibeFiIAEOA4XSNDEnaxFGQJpFYuxPtLOWg7s5hDWed9Qha2ssGZiUN29zwy2vFubjxKVoFI0bB6N7t6tDcOQbAtePKF9q9oL1g4oQce5QE4nwZDz3RlZOiIYyNk4nuNkq8gwVfkB7zk4RypqZQlA1CLPFJrTXT7VKGrvbznREDPLoycuzIVbH0m5TH6I6wtIHs/zWJQlK3OE2XQmF7/0J35rqGaOyDn1yQW1NwuB8Oqhq4ZpZj7XGhrYq+zsiKyVj7BXNo//6V5ZQoJpzxeqFJ6aqS2SdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2zYa7NpDBXIRatHPm64r+THFz+hFdQ/HsWwfrH3yhg=;
 b=KfE8oVDWY0ExTiJGR12R3b8ILaa7cGYs3OrTACTAfPDaY0WUWcWdrrT7JNIQZepT2RgbUhJ+lwe4vLPEpARkFgI0/2SsvNTu9WbgtyP8dR7ygKFLDpHZvd7vHr5HWzOZbDvFsRDS0/qyDMCAD55PZ3gYrlrGyetdCn1VwtF9Dgc=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS4PR21MB5393.namprd21.prod.outlook.com (2603:10b6:8:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 00:03:16 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 00:03:16 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 "longli@linux.microsoft.com" <longli@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 2/7] net/netvsc: add multi-process VF
 device removal support
Thread-Topic: [EXTERNAL] Re: [PATCH v4 2/7] net/netvsc: add multi-process VF
 device removal support
Thread-Index: AQHcpskwDy6mOHm02Ue9qVLncXBGKbWVVC+AgABU+sA=
Date: Fri, 27 Feb 2026 00:03:16 +0000
Message-ID: <DS3PR21MB57353C604452E0A0A27FAACFCE73A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260226023940.961844-1-longli@linux.microsoft.com>
 <20260226023940.961844-3-longli@linux.microsoft.com>
 <20260226105113.45bbdf8f@phoenix.local>
In-Reply-To: <20260226105113.45bbdf8f@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=04a6886d-1a29-4796-a5bd-b2258a8a85bd;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-26T23:55:21Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS4PR21MB5393:EE_
x-ms-office365-filtering-correlation-id: bcdfab3a-9dc8-4ece-95cb-08de75939bb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: b+0Y7K6aBg5KNoaz808/6hZJ0BtK3Fe7todi+f4W1EDvRS8+9Cl0nhLS/Howx1PPI5ROOShCeWzVCEDzQ9lmc/YJSVjn+ygLVHc/UqlznEGOnLDYXEA/rZL2L8XwWD/ielSOjnDsZH/uUnDVrCMFhPA/dS/+/sPoPCnnaVtR3AH/iVISd0UPd+ejXIEdnLe5/pGE+8NdPydNo7+AhA7v/FSkjnU5c4+SdyM61wfPcKvBYnm4wdPo5MIcRxJcRUOtjhGQIzAcVYIFPWkV0WoXc7485pOqdKc0HQbRPJLHVmmaOoXebQAQpV61ItZX6z2qZz2mI51MeDGu24ym3oaZHBhPXBuVPco4i9atRR9rIBLUcIOnEZQleXuv08ivoudXAxHLy6c2m0fl04ogwm3nB7UwFEX4JDUn2wQfRfDq3/twTDBB+T3lgws7YwraReYsdkspV6xBDrKl/ilEnNpCsuE+K5NWj631JsCWrRFNWxcqiU8Ev3rccCkFXkPxHL62c9TWQKHUgiAkp1nrQ4/6ZpobSU9E4/oycrQ89uxFcpeMF+Gwx1e9Mhw4Nhx2MoGceYQK2IJ9EuzXIY03tAVeiB6JSBTLSmFDW9D2Wu9f1hR1omn//zh9cu7Aujk/CSBJgevPGmzxFM3/zP5gjNNukdTWG6KUtCGgPTogVU1evugVxlYsn6rKv6Ay+F1aolZ01684yvjyUb6KDvk+zL0H9C9iGQpjxf/W4/ZFoddOzlepkS5A2OokwL3lj+HX3ENrvay86s4u0lZIDxdAo7o1SS+TTj7K0e/XuREXHKLU2LE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5XEhQBjOISrV/tPkXe4NQ8TcOErMMQp5/jUrZ2k8l32/0Y+wvriMcYXtC15S?=
 =?us-ascii?Q?HUgA+LGzGHbDO6R92imiusnj2exROmayZyz7HSHdFp1tkk9DzovZbi87qhIK?=
 =?us-ascii?Q?7/IH72SoCYtHutSYewqzbiw1RpPaxrJx/5cFoBIXB7DdQKDDr4CxiHoJtLBP?=
 =?us-ascii?Q?igY7r+mJcOl9ziQDWtvykNGxIrl1atKDkUBgv53w7H3m26IDB4Sr/qK1BheF?=
 =?us-ascii?Q?6xF7b+t3IK6E2EPytim6Ut0kd9Pxx8PjtdCzdHd1pqv7g8WQqX/lOYCbCCll?=
 =?us-ascii?Q?g/82m8OSqMTenhPnwoPFyrg48gyiOidBkR9+fMsLNMsqJaFMwrh+ByTdziFi?=
 =?us-ascii?Q?qw81uE+SS0ubaqZy44YILGPA9FrdOCpT1iGCqku3RmcAS1IoXLHcCVkb3doQ?=
 =?us-ascii?Q?hQoDNFSBsE1J8GRlX98+7Nbh5qvJIgZlcN+ifJdw5H/eBRYYzvC0j0QHTvqK?=
 =?us-ascii?Q?OfXdlgBF1aOQ6bnLKHXGRpWwtasMcfZXZQBQR1ught4dmha3BHQpRiMi2I3m?=
 =?us-ascii?Q?tE6izs/+mJtEppqW/GPXXLAAXb+1a4JGx4jbhwiWAP3khU17b6RAcaiwmX2Q?=
 =?us-ascii?Q?b5cGwavDSANyaW9KYRG71yEp+153OmTfasYlECiBK0L7chcM/arEPcWN8yRJ?=
 =?us-ascii?Q?MyaLNQcR8UeVcpMETpf9TffzB9r2ZilJxFjFJHzwLYgfZGwbOrNfnJF+NyHU?=
 =?us-ascii?Q?vFZkA8DoDErZGgiz1ouQgWlfaUFK0kPKrHsXnBEGDeFZwlRx1toCVmHjztZ7?=
 =?us-ascii?Q?KfNYRXX7Tmn6ffkhda1BmA+oDc/oZ3MC+rX/LGQvEjlRAfk5hHhWKDEXn5Jv?=
 =?us-ascii?Q?kzitiV1SfrptXUIDHKPc+Xe1X5eLbA7VRnnPHGZt/JTBXzCSq4vJbeigB+xw?=
 =?us-ascii?Q?WXaL/4pPgA6k0UBE7PGiwRLMRPOllwvYKKyjYczzVjt4Lx23ZW8YWXtxhpjX?=
 =?us-ascii?Q?gOUBD5UtXGyOLr8sGRIt2+X4VQAIa21a0EBd+UbjQ12nyX9c5TPFdKTe7pnA?=
 =?us-ascii?Q?hvi5IksjSQqZTrIKGON666xXFRPNEBKgWhzEoj0s3yGM4nbBuDHpviorucqq?=
 =?us-ascii?Q?21YHQim35yetJ8ayj9hQeJd0JiMh3mXGMBYPvXF2orvdYs4WA2QDBQASYL/e?=
 =?us-ascii?Q?4Mk/DpGYMZsWen+rtraZFqIQJUexrg+cUxqnCglMWaXijir7jONkD/E+aiST?=
 =?us-ascii?Q?WAbP2OEiyLiFJNvr1DtODA4oq4RDdiW+G3A+63rQSNXQZtXjjq2ONngiA6P2?=
 =?us-ascii?Q?y9SOl8ldjUkX4SFuyqhu4yFm7Dnu5N0VWeh2X/Jox4RP6asoQLBvjjqYhomI?=
 =?us-ascii?Q?dE1K8HnOZFK2USj6NwdpqNxEVAFSKq/TBtrZzX9VB8dREgGf3AnuTQoAzpm1?=
 =?us-ascii?Q?lXtVacwpLF36OA9Oq6opew3xlV7r+q7AqWNxCYZMrGVt2SKgDRldnvgXhDKj?=
 =?us-ascii?Q?l2Q9erDkcdUvccF6iI20sKrzIP184P3Kil1l7BwfnO7+IKA1zXzDX8Y9MbIk?=
 =?us-ascii?Q?dfypmTt95a2Uky05PHT7isdXd1f7Qi+iUoHDQ2oNUvXcu16t9cdDAR2LMMSZ?=
 =?us-ascii?Q?tPXIzlTAxMJRMy9xlFDyTKckOcL667u8uQ4Xp9OspoPn+9tpbtIawh3mtMg0?=
 =?us-ascii?Q?gr4iqu1/krVTy/A5+s70EYsT21EqmW+6YfMlQdJzpFOjFgGUpRYNSMvi++Ze?=
 =?us-ascii?Q?tEjS3wZ28AyeYYtsxHPOLMDCHcORjUMMEg8MPDFVe4sInXaP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdfab3a-9dc8-4ece-95cb-08de75939bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 00:03:16.5874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qFE3YgTgrZ9bqe9ugiK7y7f3TcsxtXNqi1a7v72/aB0Qvnb8CYvfxGRX/jAJ55KHRqZT7X13V9MhHDqWsGYFcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB5393
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

> Subject: [EXTERNAL] Re: [PATCH v4 2/7] net/netvsc: add multi-process VF d=
evice
> removal support
>=20
> On Wed, 25 Feb 2026 18:39:33 -0800
> longli@linux.microsoft.com wrote:
>=20
> > /* Spinlock for netvsc_shared_data */
> > +static rte_spinlock_t netvsc_shared_data_lock =3D RTE_SPINLOCK_INITIAL=
IZER;
> > +
> > +static struct netvsc_shared_data {
> > +	RTE_ATOMIC(uint32_t) secondary_cnt;
> > +} *netvsc_shared_data;
> > +
>=20
> This looks a lot like a sequence lock (spin lock + atomic).
> Might be clearer with that.

The spinlock netvsc_shared_data_lock also guards other shared data initiali=
zation.

MLX4 and MLX5 use a similar pattern (they have mlx4_shared_data_lock and ml=
x5_shared_data_lock, similar design)

I suggest leave this code as is.

