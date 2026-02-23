Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E3FEEC28C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 21:42:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 000B3402D8;
	Mon, 23 Feb 2026 22:42:49 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11020128.outbound.protection.outlook.com [52.101.46.128])
 by mails.dpdk.org (Postfix) with ESMTP id BFDF8400EF;
 Mon, 23 Feb 2026 22:42:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpuuKGiewY5wqPDpt9bt4biT5zol7198XxOLdQP6P+bm2T6SD3umByomGDpALP1CMNaE5tQYOQbZq36vUtWJemsNmOFWUp8KBmgIOnPMhj4k7Be6w6ZcT1C2fDVuzOR9y/uuhMBhhcv24YqEvsBI12VD0oNC8eB04OL0JnqgGAZUvn7uqsFgYQHR43ZEBAlINLlfcj4zST2fe/q1wJU1Coc1eQ2suVYFw3oq8komVguFpoJNS/kOv5pDSCcJexdTfCAuvFftWOMHzsXT3QQkCkdRsW4oT7Mv7GeT7//85cGCouIOlhYdxT0w6aL/MZ8MA2Wa2kPNB+bThgtz+WIZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJP+SrKlAEwQbuE+JV3FnJ9pz5fKfB4MEKJOV1lb27o=;
 b=Jfa6OD5HVPhXIA+SIDQkntKnsec66AKEZvdzlCzJrp5hGgIJlkmULDYDIIPcsZSwt3rnrJzzkp354uez4E8EchbPRLmRZT8OeDx2YljuzRXaI91KxZuc2szZHxJE3GQ6R6FjHFudsnNzX6Yzr3yuDxf+HKCDOcRzAqvA/dhGbRy5CjOv/PbhH9pdzpLTYgztLtKbQi1MxDxZfiyqbObBvBzdXL4qIJxroi7dL4JhtJ0fxxrzJrdY6kU2Uegm2jTjDCh/frOUUUTVahxR3vIYxMg821J+7uKG1zTYxdZqSyzxDvsGU6NfqFVUjDmyerO3RLzBoBl7MRehzVQYj7jvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJP+SrKlAEwQbuE+JV3FnJ9pz5fKfB4MEKJOV1lb27o=;
 b=NdyZRSU2a5+IeijAsS65cE4xhc7GXAQxHpBpwlb2hNIvA40Y3frQIctYGpECcZ/uD7OHVBj0NH5WcACK/T2LNtW3t/rcljOs1waTGLnpjmr9Py8+ZIu4UMSz16oMBvMbk2m0VtQueKZ3uAhK6cR25K3Aq23PSAML2kBtMJY5nFw=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS4PR21MB6284.namprd21.prod.outlook.com (2603:10b6:8:308::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.0; Mon, 23 Feb
 2026 21:42:45 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9654.007; Mon, 23 Feb 2026
 21:42:45 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Matan Azrad <matan@nvidia.com>
Subject: RE: [EXTERNAL] Re: [RFC] net/vdev_netvsc: check for NetVSC device
 before auto-probe
Thread-Topic: [EXTERNAL] Re: [RFC] net/vdev_netvsc: check for NetVSC device
 before auto-probe
Thread-Index: AQHcpEavzlNbZvRdU0qrElmj4yBvvbWQ0PHw
Date: Mon, 23 Feb 2026 21:42:45 +0000
Message-ID: <DS3PR21MB5735AEF2A98A5E9D57F508D8CE77A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260222204813.773962-1-stephen@networkplumber.org>
 <20260222140034.3675188e@phoenix.local>
In-Reply-To: <20260222140034.3675188e@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7aa3709c-997a-4384-9918-baeb2fb0f029;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-23T21:38:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS4PR21MB6284:EE_
x-ms-office365-filtering-correlation-id: a4bcec2e-de9f-4a47-3895-08de73247b23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?fY3JjgjzTo9Sz3hKnCV87goMJpl6E2D2wLokFUq96nMKFGmvmMUdn1MI6Rbo?=
 =?us-ascii?Q?sx0JSieNIoY0dj2v54rwwUYS1qZlkk9YEwPlxffQr8n6DJbDPPBOkm//V+wy?=
 =?us-ascii?Q?q3qALTghqdbsdttzA5v+G73OPY5Vgh9WZj4vA6H5JmS6qmZaYhm2r+Vd0lpu?=
 =?us-ascii?Q?0j0G/D0oYohCQnyspYxKNp+XV4rk0JcUwVnvTbQkeJvOOYP9SYAFYaY5Bkzy?=
 =?us-ascii?Q?X2GgVPxrICSwrsrXiOOwrY9Q44v/oWytTXbrvm7B6o76N9OL1LPEg8xHjBso?=
 =?us-ascii?Q?MSD0CZC+hqp+C/pImCWc1Hgk9MEYqdzHFzWNFPyB+mjeOfrwsvaTehkv3f+t?=
 =?us-ascii?Q?rzYgAH5uiGXDGSEt6v6g3Dcy1XXPwunri9xx9x/xvepU743HnsCC9jRAlCuU?=
 =?us-ascii?Q?dZP6AldUgU5SsQPMjmhB07sYEjJK0KvzdENMp0utrddckb9KDQ5i4C3v4Rut?=
 =?us-ascii?Q?g0+KACScLQu5sDS6ZSN2Q+9pkBhIGh2SxrOWnAoRydlQX0Ysd2MXiIeXT75Y?=
 =?us-ascii?Q?8kP0jOvlYawENOGYJ9waVoA/Gk4kBp0Fk9+joujnZ/NvT7wsX/1pz9o/2K4K?=
 =?us-ascii?Q?N5AL868k+d1Bn2qi9+VK+P+nkTAi3O5qMWtjp/Iy0BsD+x7wcKWyPQWo4yDf?=
 =?us-ascii?Q?K7J33+w6tPZ+CE8MF0fbj3KsiomXN0tZciaPm6cS65TiPuN8NFpcRjae2QrH?=
 =?us-ascii?Q?ZB0uhU6ktRxPzhA3Cpx/Ov+jRJBW6oGygtTRly4C8CxZ2D76L8agDUaWWj5e?=
 =?us-ascii?Q?DYINm7JoKNW/jztnadjKqWyWGAxLwRFCNYWUbfC4zk0f3HlmHTG1UIIEiDJk?=
 =?us-ascii?Q?CtHU51NFMqzMV3tolMPRHmPJ8A8CbKKKPKPx+dSEkGgF4UYJ2gaSIN4XZsKd?=
 =?us-ascii?Q?VvZ/xy/UHrDLRfaxvgjTEI0zlwpXFf3Pl06a2lmYVKtyE2wUwWeFuaS2Lsp7?=
 =?us-ascii?Q?qEMC4XxPbhNvrX+rCV+uHdH5nqjUL6bhbuJzj7TyCFV8+xrhh5y5MOHB0Djx?=
 =?us-ascii?Q?lpC7wg+hdvWt1ZVutrpg7U7XGvTHmCjzV7NN7vWtAIJ7hMhlV9zQ2fkFy3eP?=
 =?us-ascii?Q?TmJBD03yER8kTaIJSu+Z4y7V1ark4uEMksg/VKT80WkZO8T84RLjeKhiAjF5?=
 =?us-ascii?Q?epYAlXdW6njdDfE0LJlXU9uE3gMjjR4lcDMEO7MqJih2BkFCQnDxFacVGeuv?=
 =?us-ascii?Q?1fVc/gxYChvhaw3nT14XQLiTwTgX8p+Eh217+5UQEefGKCdduJEsVT4yJF4K?=
 =?us-ascii?Q?tXDlogWsjeQsUn4XxRywb8t7EzJUqIgmseL+my00Oc5z/SmyQHyARDiBkUd6?=
 =?us-ascii?Q?43zJ8mNohq0dP5YttkdgB+nfkQrHPwlVcoPh6mMTMq58KtA3v2jtkkoRGttR?=
 =?us-ascii?Q?S4bXvjX0jusZlMAYWAxDv8ij/+xQjrqLTeTJLMO8s5oAV2VJjCZnBDi9BE77?=
 =?us-ascii?Q?kWQnq9H2/m2sw/VUwPPRhXZPfI5gkhJ2ycgbwopo8VR9asl+IjTJY9hp/1p1?=
 =?us-ascii?Q?lFvD48c62/2CCJpiJzhEJ3ddQwieFR7s9BrjA+UvjNRQtmKaUq+rz8WYhKsK?=
 =?us-ascii?Q?BGoeLx1RdOpGZFlTvTvEVRmv1BZ0OJ4WPr+JIxkkR9eavw099/ql/vnTwlpu?=
 =?us-ascii?Q?GqhR8LnmY1zhiEG0KiysL4s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cITkxpW2PAfki20BQMOAJmtZsGaZieFRmQLIOVuskoEmv/NTwFKYxSRFFVmc?=
 =?us-ascii?Q?5f/p7b7XD65oMrCfLIvtBtT/hfKDMLUbeENDzZfMDnJePhjxX2+YOiFUim1/?=
 =?us-ascii?Q?sGEwSMr+BLzMCU/M8t0oPhkpcFT/Z3cI/6VLhQH0cS0FepIGiEk1sm5e9Py8?=
 =?us-ascii?Q?GFVhrImrWxGFJcR7qdM2R+MhCB2umEWWHe+NYu11cy7Xl7TR6lBGXHw3hGvJ?=
 =?us-ascii?Q?ws9tOfsHZpbRTMJBEyESx4Ij0CIoeFGffntRYNZhr34uwlxUGGPJfYUiPq+N?=
 =?us-ascii?Q?pHvRC9L1krS8A21aXzaH/gfyxS0Eo/2SxXRwjDRgJJGZHem7o/p75ebZBkwd?=
 =?us-ascii?Q?H+QWM3qyxYsJyDvTYm/8kXcGzaUuCFN7x+9tWVMrJP0tEYr1wSbhfr2sXnZF?=
 =?us-ascii?Q?z+MQIaz5fLIabrn1wcud7MB0SfO4oD4swfq3abbVdWltgPowl1iBB9PCqPKk?=
 =?us-ascii?Q?pnArlao7ldooxrDwkwAQ7VXowZrU/4+p7OnTBIIMWX1BGlhtSkJJSD//phsO?=
 =?us-ascii?Q?RcZLrUaL4i9mIIT4UbeDLLxCojAZK7KALWyjn7dwhvGQx358vwbNzmGyccQr?=
 =?us-ascii?Q?bJxCA3x8ZSrls7J1RQsWuh/mPl77s4fdK1MhzadbaOAppZMOBkIoveC2vi8b?=
 =?us-ascii?Q?VshlsV4KY2j9dYDrfnbYRp273PvhrU6vF8zGJfnBTIYCyShtrrxMr8OvtgB+?=
 =?us-ascii?Q?XXG9B9/Rw96X+8/t31JZvgsotOobdi0qXAk1ReWDISxOOY582swmHCK+aDhd?=
 =?us-ascii?Q?Z8Ms3Egu+YZcClAsQ3EZm9OEYHD4CSf8gM9D1cZGPUq45UlChK2UZufkMMFh?=
 =?us-ascii?Q?u2AiPiNWFDwrAYtWhmq4xdZwlFfo14G/7kZg8z0N/dLStfTVTscgQrvyZgEK?=
 =?us-ascii?Q?o6J7gwfwo36DM4UXS6m2fYe5rvzVsCu/3JpDNaJH65HEzRV5HNlWBjCLbAgs?=
 =?us-ascii?Q?Qwx+oB3rKzn1JTLVCwERa6ttaFRrgAoYttCsGpfG+VId0pSOLKvSZZ6btA5H?=
 =?us-ascii?Q?N3s9E6TOAD49MZE/dI6+RrMzEtpnhywDfhxCi7KGDJ9Ih92sQI4dFFOSGgMx?=
 =?us-ascii?Q?2a0/deF9mQn6t730+5VLim3cIiMe/4ZkdYF4I/eyrvmyc0QR+/UEK5R5Nd7S?=
 =?us-ascii?Q?kaJPXAW/TCntd2EzxpNypGseYgPpK+Y2RBW7aeC0QyGPGCZX8GaaqZfHUzRN?=
 =?us-ascii?Q?BYrhgwnbP/FxTDCzPHg0MdhgQeIoYzvG232oIhz+g776yqkTlJeYVijb9xcB?=
 =?us-ascii?Q?weND/qcHPLtpThc1JPA2/SdLCy1BE3SoQ8jRyuDOSAD5ak/GZptC0as9L3Eb?=
 =?us-ascii?Q?YDgnLSXnEyT2kqdhNLVEOfC5bjp68RSNdPVcBWXYvc4Isva2hvz8nYP6u3Vp?=
 =?us-ascii?Q?MUuxJyzZhIjEbqnvO9WpXLOqNqJeJ/wQvCWPsxNIBKibEVG95GmIP1JJ2yB0?=
 =?us-ascii?Q?wvZfPxipgKqEGEHO8vna6wUs5MAc+mXUXI9Nc1g9VH2LoNAkFPcJzjJlII+h?=
 =?us-ascii?Q?Nq/BTKmIuUtDTqgPAlhVhR2/Z6wmYXSE5V1S5njJrAUxRc9fhFWlM5NFskpj?=
 =?us-ascii?Q?3bcxIinTTsNWIfkIDBMxgyc0j17Xr1vXfrD4sl0/3c+UkGf313s+giRNsQ47?=
 =?us-ascii?Q?4uQ7gXNRDrfBrYpvFVI8Cnemi8aoGibAMBl4L3hpKNYmS6yDJoPoyiSiut5s?=
 =?us-ascii?Q?CUyMQzv+1Eq2u/aqmMrRKB+i5cMGRERNjBhBx6SAoaf98aDu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bcec2e-de9f-4a47-3895-08de73247b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 21:42:45.4960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m52gUAY4bkSWfsYLhp1ylZ4jtMtm4LxqtALbLkXxpa5vsg++ok4nd2pJo168z+qA7QXWwVuwG9KFOSCdSdfjBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB6284
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

> Subject: [EXTERNAL] Re: [RFC] net/vdev_netvsc: check for NetVSC device be=
fore
> auto-probe
>=20
> On Sun, 22 Feb 2026 12:48:13 -0800
> Stephen Hemminger <stephen@networkplumber.org> wrote:
>=20
> > The custom scan callback unconditionally injects net_vdev_netvsc into
> > the devargs list on any Hyper-V system without checking whether NetVSC
> > interfaces actually exist. This causes the eal_flags_vdev_opt_autotest
> > to fail on GitHub Actions runners (which are Azure/Hyper-V VMs)
> > because the vdev bus probes both the test's intended vdev and the
> > injected net_vdev_netvsc, which fails to initialize on systems without
> > NetVSC interfaces.
> >
> > Check whether at least one NetVSC interface exists (via the sysfs
> > class_id check the driver already uses) before adding devargs in the
> > scan callback.
> >
> > Fixes: 56252de779a6 ("net/vdev_netvsc: add automatic probing")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
>=20
> This is not sufficient to fix the github problem.
> The container still has an interface, and cloud-init has given it an addr=
ess. But it
> has no route to outside (in container).
>=20
> It looks like the whole automagic vdev_netvsc model is so brittle it shou=
ld be
> removed.

Can we set up a default config of not auto probing net_vdev_netvsc? Or some=
 kind of flags that says a driver should not be auto loaded.

Most customers are running "vdev" arguments to load them in their DPDK appl=
ication.
