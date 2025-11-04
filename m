Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3F4CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 10:22:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DF1D4029A;
	Tue,  4 Nov 2025 11:22:39 +0100 (CET)
Received: from MA0PR01CU009.outbound.protection.outlook.com
 (mail-southindiaazon11020089.outbound.protection.outlook.com [52.101.227.89])
 by mails.dpdk.org (Postfix) with ESMTP id 69B594028C
 for <dev@dpdk.org>; Tue,  4 Nov 2025 11:22:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJzMpgFRCPZ2iIq1IRAtmbdp4TRXEZSU/9UDmg2DqWvQrxSm+75woQG97B8VQLcs1XN4YMNHKN8hEAY/+97mW6U5kIdV2P+8auwDCMA/W2SPg5l6xPND7r2vv3cKxC5sfp74rqc6qwHWyS4Oa+9eL8CE+v2pj+CD1GR1E1lgR1V4bgOaY7ld2ZeOetYE3BMx/5yLGO3DNxlMdUKx5qEYMEdGNmb0xRLqRq1qCq0LqSRLgdsGhip8axwH20Uhmw0shANQ5lU8tw4CWaFCvkU10W+PEw1ZahKiQX4O9Z8txiRyQUzwaly3TJTMl2zLJiYENH5akRVyBnk/bS1a/EJNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgb8D4ROuW9I4FnkgregVG7zFFRhdR9Y0arPhp+A/+s=;
 b=YBx6Dp0E1VoSjU/3kezHNhHJgliWK9xotwAtJvWH6wxaiO8zRmN2DoUo2iO6uZCO6OMVEavlvnDphTclTkmImUjL6FSnDdt2y1ROIuUP9z72nSqCBQwjOLQL88i83s8okTW1bR9JsuL8xI7cQ1MmdESzgMkpuzZbZ3KRWxMQrmyeibv8tAluyHoAPfy5DMlPl5gzw3T4ZIssFGD13z/IFwe7C9AtA7NQKMjNIgdSe7d1O1pJ4jbkTh88PFnGxhKOigFCckqWYUhdDXdklNuy169Pdr71B3KQQmbwYNo6fTMhMuy09s2mVSAAOeeVnGNL04Nx3hwrOgJyopoC7k90mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgb8D4ROuW9I4FnkgregVG7zFFRhdR9Y0arPhp+A/+s=;
 b=oSs47kRdnjSEjrrdL3+AwX0wePyMNvN7z1AkxdYHpnk6IcbIOLjIHwZR3JzAB//kcHlssssTgOioZyyMRxqYQ5Nvt/f7+83hFCab2+4Gn0u4S4BLfWhtLVgE6YOBRNNF228vDn/l9kExeh+KXB74DXwWqyGO2ZVBphUSmiiWzhktRpG/6YE6rdFCfE34yaMphDZxdupqG0hdVA52jdaZ3Vsqi8yUU7glZPqIxnauIPdwpBamYl5PV2QMZTJZDU8OSzBGcNIt5hYmdYrla+DMflOHS2AYpTjC/IEBSffl0TmH9LmDnnPVVwJ0wQ/EeK6R48JT4Vodg71WJEEhWmJdDQ==
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ff::6)
 by PN0P287MB0787.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:147::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 10:22:28 +0000
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44]) by PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 10:22:28 +0000
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Chaturbhuja Nath Prabhu
 <c.prabhu@iwave-global.com>, dev <dev@dpdk.org>, Thenveer Poolakkanni
 <thenveer.poolakkanni@iwave-global.com>
Subject: Re: Virtio-PMD in Windows
Thread-Topic: Virtio-PMD in Windows
Thread-Index: AQHcQllTOt/KxgpIwU6HUkaaP8NWhbTMN1BhgAkzIm+AAyS8aYAAJfOAgABcWhmAAae8AIAHqaQQ
Date: Tue, 4 Nov 2025 10:22:27 +0000
Message-ID: <PN0P287MB2531E1E798D9799241E9E9C4C5C4A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
References: <PN0P287MB25316B273566FD2CDDF0D83AC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531616EDF3F92036B4E01DFC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531AEA71C2E1A6B25D15680C5FCA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB25314E093834DFBAA35898A5C5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <1c5cad85-1408-4458-9e32-08f45f36c130@gmail.com>
 <PN0P287MB2531E4AB73A84D84E5F3A2DFC5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <20251030131318.GA15405@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20251030131318.GA15405@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-Mentions: andremue@linux.microsoft.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2531:EE_|PN0P287MB0787:EE_
x-ms-office365-filtering-correlation-id: 97f46aaa-1b67-4339-5778-08de1b8c0e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|13003099007|8096899003|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?wcbpgOAnRtZaPUgMywYCDNflXRXxFFQkhSmqYNzXk5me4elTVqIUb/u973CM?=
 =?us-ascii?Q?L+sfpCV14y1h6IVqNSo0KpTkLcL92ZCfTVqmwtUCuB0WiOgxd8V8lhrgDEP9?=
 =?us-ascii?Q?UUyMwREWUHNHt2v0ncj4MKWw26HJ8H65iIHKOuFz9tZu6766/hvU4LyucOHC?=
 =?us-ascii?Q?PAI2kg0E3vkcyI3/hAMXI8Ay2+MnBPrhIhyHUUBnOCvGOsZ8lfwBg/AkaeQH?=
 =?us-ascii?Q?GdpfD5clNtPYAqNfsD9+GYvpu9s231G1mse7U/GlhKr9mx4Q8X/u2/in+Av2?=
 =?us-ascii?Q?hdMJNCDSult4flFZbcCKN1U718CKhenHgjSngtUQkNdmnm8GL7YVbnOv8nHR?=
 =?us-ascii?Q?JkDN8ZRkd99IkFIvIRw9K+jxABwxzvqNznxfYQU4jodrKvSW1Y4v4YNXw1cc?=
 =?us-ascii?Q?wz8moM9l/PDT3daTnKxm1XBU7rhgBIAwYqnumOK46FnKtIp+AuKjaQGE+0PJ?=
 =?us-ascii?Q?2ZcsUH6+PnGbZkz/QijeoJhpoDcjUoC0yvic5oO13cUZXVWsg2Hfy+Vn6+dU?=
 =?us-ascii?Q?8dAUvylRaLuEjUliIR0XTApT9Ji8FdIBcySDe1XSjFiO1Ym/21hhj5KE5Xlz?=
 =?us-ascii?Q?Y90Ru+isWUMqRGSpOoCCQ8NV/FuW5+ntG5fI7PtddsYhOwdsRWpTfrZxcSDv?=
 =?us-ascii?Q?5w7RgxgChXjXdw+R6aHmTaJ3VeGE0pIqtqEspekrI3iNJsylnanuDDmSveTJ?=
 =?us-ascii?Q?d9cjyabzeMq+jGZo7RwFID27TtyTxvJYjosDWV4LQfZ/zdd5a5+iLvOfHFo5?=
 =?us-ascii?Q?g+IfCPdR32lhOKuvAJInujF3yIsloK6W+zqvm2RnTke5I6LsEMvrhOh+EWSn?=
 =?us-ascii?Q?uWJVqYxGxA8ZJ4GYa88DXT6EuEtgZjE3fKV+8GX+QNchUt7xbVRF91fR6etz?=
 =?us-ascii?Q?NGKfrHgJBqJAJNo0JEgcbinn3Zi3IwY3N8mGnzWYEnyjSH+9i4UPmSyIAYyz?=
 =?us-ascii?Q?FI3qNUFLBPzIAnyZNwKfO9QvzFi3XkUVBVQqgYKCedJieUDrNvuc81cn+KgG?=
 =?us-ascii?Q?sDM55QuMveQuUwTntVNm4jUazFZ59lt6h+8LFiatwyabylBVSZZiCKfMNyLh?=
 =?us-ascii?Q?XicuGfMoqzgpqQp6el1CeRtRCyyYUO33yu/SlEeigTb1ZDnNmlq9FQBgUdTM?=
 =?us-ascii?Q?rKs9FuzrieLQUrTGs4LTCx6l0QekeJRwi+U4jaUjgBVCvQvrIKrFoOw6qtZX?=
 =?us-ascii?Q?DHY+aYPgFUp03/z6PqZCGQ/LiTTxPE6fQPwY5bNfcIdSolWTOEr9zYuxGx3i?=
 =?us-ascii?Q?wS2Vwf05LLig0E36pqYmAccelInMg8BWWXtTtWDezXuA4PULjecNohhkmv6y?=
 =?us-ascii?Q?vmnTZWONBOAGJOY/HF4wcU859bapTCG/DtDZRKCXMW/K+Uo5JaCoxKoZRPCY?=
 =?us-ascii?Q?W5kQLry3FDTubksCA4FZOc2dUD5MFQKYifV0aCxrse3W/XElmgrKq6eKr9eQ?=
 =?us-ascii?Q?2UWdSVQnwtlbAXengp4HH8hT+iZs/3FOhDUidojAlBFK/8ejJrZA8TZ0XHUk?=
 =?us-ascii?Q?wMLo29khuS/27qy6aTLvfv0Z/By+OZVAtTmp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN0P287MB2531.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xeZ8tHPmYDbt3TEXKUapaeOVc+vQMlbqRd/wgA1wTDs5SyUpqnTh1ctxDIIu?=
 =?us-ascii?Q?d+V7IxzG+S1ssP7QU2oe890fRoei1GQvA9JOmFyMekFo/hNvYmgIDojXjA57?=
 =?us-ascii?Q?qERrNnT3gKWnC0Iv4RSOKQxmGbbx9uqC7RS5s5GWlwbIbON2zZrjP01Ag+GY?=
 =?us-ascii?Q?5hvywniat/v9GCoLlDnUcX8xibXwNAlCFKPfwA1LQpd8U/unffiG33xA7lmp?=
 =?us-ascii?Q?BzJexHw+G5EBMgcTO75KtQ8vmekCpkPH+FavCRXqDzO03gs83YVwdIleP7oy?=
 =?us-ascii?Q?BlTEOE54sfwC2woXDg3L9wMnn9mNDdsUY2SCLB8kYOC/WrkKJ+63Ml7NPco5?=
 =?us-ascii?Q?v/jNjJ4kaL1wQsRIUEVA0ewuSOkB/RM7yuqvn4kJ50D1btYNOaVK5bJremyA?=
 =?us-ascii?Q?kseERsvPjMVKzzr9Y0byTZs2BnihuXPRokC2aGmeJSKYr8/UpP3yRtQfg1YY?=
 =?us-ascii?Q?cwXPlsdrsy85GfewlGt6MGE8K8BOpUNLJUe99dNhlkmdV3CWJmqUMgoGM2ZW?=
 =?us-ascii?Q?t1tHwWfIiYUNhmzp+YnuO6dTXjeXYaQgpRkqxUVUWsh75KX9majW3Kmu99Ai?=
 =?us-ascii?Q?SklVr6+WIUFUdSgVIX8zokQZPn86Mo7I6Ekesz9oMHzbfX54Xolm0ZIQlgH9?=
 =?us-ascii?Q?BM5m9Pa7mMWz+lWcZ8XqrSUTf4W+OpXqS3xbB9lIC/i5D1TqJ+Ovn8bQS/kf?=
 =?us-ascii?Q?W2EwaFUOiNhavDk9NaYe/S7+WCFWd0v8mN/rRQphp0KK44nKBiRSgI1/RZnn?=
 =?us-ascii?Q?3XHXA25/2ksEtQx8KdYGwQjvGQi+tupuBVs1gsVksVZYmJ/CuCR2he/kj0Z5?=
 =?us-ascii?Q?mVrYJb85KschN5sOWyGSFB9bUkEdITrh5Q/Qk+omuSOatCIzUl6wpDAFVMNQ?=
 =?us-ascii?Q?jLy6MqVdFuBfxfsvnkVO/ok4zCHFMpO/Z/CKNp/fuhvk5ok+VvmWGOHUS2Xg?=
 =?us-ascii?Q?mh3qTulfh5C3IAmEjWjl7wDaOgeL2NyhLsjTSg1CCMDpHG0gi/BF4x/0e+11?=
 =?us-ascii?Q?bJ2LC6PwU9v0dypE3KTiVlMEOAD/Jl4r/PGRE0ZK+ADTHH3Kh/mJSePhauSL?=
 =?us-ascii?Q?JoboerqEzQXXdBakLYW6YcPPiX3NqcWcIL2PTIqEVrfga+nN+jvBEM+Emzg2?=
 =?us-ascii?Q?8gOnIioxkASOGt/5qWN890t8gR1xqUBObq4Rf02QwOQiDtqta1OxiD9sq3nu?=
 =?us-ascii?Q?ZiH8xyyRgqeI4GA576dXRXTSg2S2kCIaCdnb7x+Yt6Fa4CibdwcSlKvMppYt?=
 =?us-ascii?Q?+UMQ6Mq+GK26XfRgsKWWTVuNBD+y/fD2bTCfptZ3plU+6SkiKV9s7F/bmsnY?=
 =?us-ascii?Q?dWC9JK9X0Wa8SjYlCriynMrWy2p9GtnWL/MA0ltjXx54X2ocPxi4dWTGE5qz?=
 =?us-ascii?Q?Fo9aBXQ0WfGfRaQx1IBA9IwXc8p5UGWgLOCBZSqe8WogdG3Gi/sYRMAPo1Uh?=
 =?us-ascii?Q?TKsa0TmHfSbpo2siKakUF/6XY0oXq6hBFbHv5TOGphUbHjTfmdrGq+H8Hh0m?=
 =?us-ascii?Q?7c31DrBr9ks4s0PysvbqCsPPyTcZws/XDrY9C2CA+0uwLaMcknQTByv7psGA?=
 =?us-ascii?Q?JNZA0UOYFDlTWjFpifZo0ZLiHxS1jgj3Q+f1WlRVbb+XuRwnbnDUbviMRFb1?=
 =?us-ascii?Q?8A=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN0P287MB2531E1E798D9799241E9E9C4C5C4APN0P287MB2531INDP_"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f46aaa-1b67-4339-5778-08de1b8c0e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 10:22:27.9430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pXiEWMpheBTVsdlOPOHjO/rDK8E6pIARrwTJ1Km80xHZd4bo8BLPRI04jHwgoe19/AhyTMCi0uFrr8SyrQuj/+azuAad3A6eA/UsyKBVpuw66vuuo/5zQR9YWII5E2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0787
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

--_000_PN0P287MB2531E1E798D9799241E9E9C4C5C4APN0P287MB2531INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi @Andre Muezerie<mailto:andremue@linux.microsoft.com>,
Thank you for your message. I am currently reviewing the details.
In addition to my previous queries, we would like to confirm whether disabl=
ing Windows security features for DPDK testing could potentially impact oth=
er Windows applications (eg, System update mechanisms, Enterprise Managemen=
t Software,..).
As we had to disable Secured boot (BIOS) in windows to disable driver signa=
ture.
Thanks and regards,
Ayshathul Thuhara
________________________________
From: Andre Muezerie <andremue@linux.microsoft.com>
Sent: 30 October 2025 18:43
To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>; Chaturbhuja Nath Prabhu <c.p=
rabhu@iwave-global.com>; dev <dev@dpdk.org>; Thenveer Poolakkanni <thenveer=
.poolakkanni@iwave-global.com>
Subject: Re: Virtio-PMD in Windows

On Wed, Oct 29, 2025 at 12:09:28PM +0000, Ayshathul Thuhara wrote:
> Hi Team,
>
>        Thankyou for providing this input.
>
> In addition we have a few queries while running DPDK in Windows.
> (A) On what scenario or an example,  can Virt2PHY driver be used?
> (B) After we bind the interface using netuio.inf file, the example applic=
ation testpmd.exe shows "No probed ethernet device". But in Device manager =
the interface shows available and bind with QDMA. Here we are using QDMA-PM=
D(https://github.com/Xilinx/dma_ip_drivers/tree/master/QDMA/DPDK) driver. T=
his driver works with Linux environment.(Please let me know if we need to c=
reate new mail for this).
>
> Thanks and regards,
> Ayshathul Thuhara
> ________________________________
> From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
> Sent: 29 October 2025 11:56
> To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
> Cc: Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>; dev <dev@dpdk.or=
g>; Andre Muezerie <andremue@linux.microsoft.com>
> Subject: Re: Virtio-PMD in Windows
>
> Hi Ayshathul,
>
> Adding Andre as currently the most involved Windows DPDK maintainer.
>
> Virtio PMD could work in QEMU-KVM on Linux host with Windows guest as PoC=
.
> However, the patches were never completed and merged
> because of a few toolchain-related issues that no one had time to resolve=
.
> In DPDK, the latest patch is this
> (check also the link in that message and the discussion):
>
> https://inbox.dpdk.org/dev/20210815145614.3826-1-u9012063@gmail.com/
>
> In DPDK kmods repository, you'd need to add PCI IDs to the INF file.
>

Hi Ayshathul,

I don't have further context on this, but let me know if I can help with th=
is.

Regards,

Andre

--_000_PN0P287MB2531E1E798D9799241E9E9C4C5C4APN0P287MB2531INDP_
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
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi <a class=3D"tWKOu mention ms-bgc-nlr ms-fcl-b" id=3D"OWAAM652473" href=
=3D"mailto:andremue@linux.microsoft.com">
@Andre Muezerie</a>,</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thank you for your message. I am currently reviewing the details.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
In addition to my previous queries, we would like to confirm whether disabl=
ing Windows security features for DPDK testing could potentially impact oth=
er Windows applications (eg, System update mechanisms, Enterprise Managemen=
t Software,..).</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
As we had to disable Secured boot (BIOS) in windows to disable driver signa=
ture.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks and regards,<br>
Ayshathul Thuhara</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Andre Muezerie &lt;an=
dremue@linux.microsoft.com&gt;<br>
<b>Sent:</b> 30 October 2025 18:43<br>
<b>To:</b> Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&gt;<br>
<b>Cc:</b> Dmitry Kozlyuk &lt;dmitry.kozliuk@gmail.com&gt;; Chaturbhuja Nat=
h Prabhu &lt;c.prabhu@iwave-global.com&gt;; dev &lt;dev@dpdk.org&gt;; Thenv=
eer Poolakkanni &lt;thenveer.poolakkanni@iwave-global.com&gt;<br>
<b>Subject:</b> Re: Virtio-PMD in Windows</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Oct 29, 2025 at 12:09:28PM +0000, Ayshathu=
l Thuhara wrote:<br>
&gt; Hi Team,<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thankyou for providing this =
input.<br>
&gt; <br>
&gt; In addition we have a few queries while running DPDK in Windows.<br>
&gt; (A) On what scenario or an example,&nbsp; can Virt2PHY driver be used?=
<br>
&gt; (B) After we bind the interface using netuio.inf file, the example app=
lication testpmd.exe shows &quot;No probed ethernet device&quot;. But in De=
vice manager the interface shows available and bind with QDMA. Here we are =
using QDMA-PMD(<a href=3D"https://github.com/Xilinx/dma_ip_drivers/tree/mas=
ter/QDMA/DPDK">https://github.com/Xilinx/dma_ip_drivers/tree/master/QDMA/DP=
DK</a>)
 driver. This driver works with Linux environment.(Please let me know if we=
 need to create new mail for this).<br>
&gt; <br>
&gt; Thanks and regards,<br>
&gt; Ayshathul Thuhara<br>
&gt; ________________________________<br>
&gt; From: Dmitry Kozlyuk &lt;dmitry.kozliuk@gmail.com&gt;<br>
&gt; Sent: 29 October 2025 11:56<br>
&gt; To: Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&gt;<br>
&gt; Cc: Chaturbhuja Nath Prabhu &lt;c.prabhu@iwave-global.com&gt;; dev &lt=
;dev@dpdk.org&gt;; Andre Muezerie &lt;andremue@linux.microsoft.com&gt;<br>
&gt; Subject: Re: Virtio-PMD in Windows<br>
&gt; <br>
&gt; Hi Ayshathul,<br>
&gt; <br>
&gt; Adding Andre as currently the most involved Windows DPDK maintainer.<b=
r>
&gt; <br>
&gt; Virtio PMD could work in QEMU-KVM on Linux host with Windows guest as =
PoC.<br>
&gt; However, the patches were never completed and merged<br>
&gt; because of a few toolchain-related issues that no one had time to reso=
lve.<br>
&gt; In DPDK, the latest patch is this<br>
&gt; (check also the link in that message and the discussion):<br>
&gt; <br>
&gt; <a href=3D"https://inbox.dpdk.org/dev/20210815145614.3826-1-u9012063@g=
mail.com/">
https://inbox.dpdk.org/dev/20210815145614.3826-1-u9012063@gmail.com/</a><br=
>
&gt; <br>
&gt; In DPDK kmods repository, you'd need to add PCI IDs to the INF file.<b=
r>
&gt; <br>
<br>
Hi Ayshathul,<br>
<br>
I don't have further context on this, but let me know if I can help with th=
is.<br>
<br>
Regards,<br>
<br>
Andre<br>
</div>
</span></font></div>
</body>
</html>

--_000_PN0P287MB2531E1E798D9799241E9E9C4C5C4APN0P287MB2531INDP_--
