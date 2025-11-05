Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A52CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 16:17:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5E5C402E4;
	Wed,  5 Nov 2025 17:17:35 +0100 (CET)
Received: from MA0PR01CU012.outbound.protection.outlook.com
 (mail-southindiaazon11021076.outbound.protection.outlook.com [40.107.57.76])
 by mails.dpdk.org (Postfix) with ESMTP id 845A84021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 17:17:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwwSte3piYRe/hNTje8Sce7eJi8B5wkMZcul4DYKHwnS1AfwF2C73GGEd+3IWelpn2zBtIb9mGbrQjTzRKZ261kiCbQExA/RcM7FVzillIvPVJihE60kkGECvSk/5Avz8E6HlA4VBV+PgQzoMepNaiRlI13xwqqLxRIUnCgOI3mzsad3CYtjm+LdNcBE3m8HY+beWnlw3YX7dQk8MVbMPyl7uBs55FE2Dgvtgh9DW3sYuAoJbLOcGgsBsSv5Zy7jDGiXPN/XPpZ26gfxmrLaLQcWcyIMEvYV7YKwAenlfwqTs+CKAuNBJE7JLgtjcPEX/Z1+g/Bg1ugw8lP0hP6flA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTIIoqsG0phQrO650UE1kisHwQ94vU+5OO02FWAQVCE=;
 b=m/Uk3/UwsvX5OFrovgDjMWIft/udBkKTpri3+n0HXobVeChZpww0GMJWBy7aSwfXFjzTxa696lF1BMpPuiK1Gmh5ViCYsTZfB9dTAanJKgjL9QxWDxKEeVaefe82Zt6MDwNOBLNtERySqXchEz0SHj7KxtJZZk/XUcIkqIZQxcBEiGF8B0b8zvnwAHsDD9VDTmPhbiJuB0jkUbmsN+iCy2grg696jaHl0k/oZ8p/tJ4BKbhFXIU2FatQ2e04kArdy5VUJgnZiGmxknqD6VcvbjrNaQWdss9wJ7iRInudR5qCkQjKcFZL+DaWORyzoTxvzN9qERUbraaYWr248p5TIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTIIoqsG0phQrO650UE1kisHwQ94vU+5OO02FWAQVCE=;
 b=qT1HyphJeaTmX4AUMpykfONEx5a+beYmDmM8z8P/AT8qf8kMdEZpuwhlCL5j5vg+fzviTWypi3MaFOEA3pH0P6x7WL3ni5jlElmTi118Mxo6KRUxtquXFJVvU0wf5tbPO81JvLvHObNv3SJAjAMJVRJa4+W6lbaxfFlvGZ6MrBmX6UCf+u1Z/MBudn+yzYI9o6h8R4uc5d1/TVhhqn+nlMqvXWJSMB+j3St8+RGKxPPTq2hX7C4PaNarlv62rPqNiErAlEcEvu+bbVY2XqFavSA10wJeqq9AkV6ccGZbuK4X8eyJgEBlymB33Y1Hxx4QIoFWtcjBeAcKDCdlzC5qaw==
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ff::6)
 by MA0P287MB1009.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 16:17:26 +0000
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44]) by PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44%6]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 16:17:26 +0000
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Chaturbhuja Nath Prabhu
 <c.prabhu@iwave-global.com>, dev <dev@dpdk.org>, Thenveer Poolakkanni
 <thenveer.poolakkanni@iwave-global.com>
Subject: Re: Virtio-PMD in Windows
Thread-Topic: Virtio-PMD in Windows
Thread-Index: AQHcQllTOt/KxgpIwU6HUkaaP8NWhbTMN1BhgAkzIm+AAyS8aYAAJfOAgABcWhmAAae8AIAHqaQQgAHn9ACAAA9Pxg==
Date: Wed, 5 Nov 2025 16:17:26 +0000
Message-ID: <PN0P287MB2531E96B01827A3A26F4B4B6C5C5A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
References: <PN0P287MB25316B273566FD2CDDF0D83AC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531616EDF3F92036B4E01DFC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531AEA71C2E1A6B25D15680C5FCA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB25314E093834DFBAA35898A5C5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <1c5cad85-1408-4458-9e32-08f45f36c130@gmail.com>
 <PN0P287MB2531E4AB73A84D84E5F3A2DFC5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <20251030131318.GA15405@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <PN0P287MB2531E1E798D9799241E9E9C4C5C4A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <20251105152044.GA3941@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20251105152044.GA3941@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2531:EE_|MA0P287MB1009:EE_
x-ms-office365-filtering-correlation-id: b30d1630-3aad-43a8-0aa2-08de1c86cf3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7053199007|38070700021|8096899003|13003099007;
x-microsoft-antispam-message-info: =?Windows-1252?Q?Ju3/D97MC6Qz+/3DrSOp8F6f8XPmFZ9DbC8MyrQqFV8AfqV1Zwheew6M?=
 =?Windows-1252?Q?7OXoCdVW2byU5aAwiaIWkcRHOkdPd7t2fbkTbdatH+zk+oVm4PNL5xzr?=
 =?Windows-1252?Q?MZ8OVl0EZM8Kp/2nMjZhJAMCy5duOJNQKumnnxLIfl++FmDsFmETWLjp?=
 =?Windows-1252?Q?idlJCwjBgcyV3dN5J+miks+l4/dLGCiP7ljG/FsVG68iaOP9vkZloiyl?=
 =?Windows-1252?Q?YnkDgsPHJMVujwy6wvPzuGBES2AM4x32sSMV1vVKU3oDpAi9Ep8J092N?=
 =?Windows-1252?Q?UoQmAHtJrirruhJQwEIYlhv+w5sJ1hvTc+/3hztpfshnN+RBn7cW09wO?=
 =?Windows-1252?Q?NpYR8aVTqE5PFJGM3g3agIZtjyCAmt9n0wHf2weZRPIY3SdIaYvpglH2?=
 =?Windows-1252?Q?w6t8FbF2A3HiqapKgY8gnBdGA8Mxp2rfR53PE7N0nWU/IKzT6bAGMFkk?=
 =?Windows-1252?Q?/yFoIC33DYI+zs38cU1tgc9VKh5+hBA28l+etrkgKfqrFTxdFAxvF47A?=
 =?Windows-1252?Q?nI+D1vBB2sqAVWFpzXZcPsnXGFAiiX9f+ahqjEvQQ2zmWjEtjvXoV2nO?=
 =?Windows-1252?Q?kx7X5H5KngYhELeJueeBD7yNZ53EcLajpKak9GQD3OYmfpzbaz7gulzQ?=
 =?Windows-1252?Q?48rdbEG4M/ZikudTfWTqkd6Oj9yZfk6tG4nHWEkAKXdpuVu77pO378ke?=
 =?Windows-1252?Q?yENk9Z5JQemjBl1DNSxfrUaIoqJHy6tOn+axn1QgPC6TcBenjrSMN6OK?=
 =?Windows-1252?Q?nrZ85l/AyD/p24jFt7jHsD1mweEJTcjXcuGpTYSIkOu9lUt3oZGSlddd?=
 =?Windows-1252?Q?ZNU403idt1VKPLrwD/LIl1diPaTuJV9v2L63aL5K44ZMODf3kx3SZK5r?=
 =?Windows-1252?Q?2abf5v+5O9bHa/zxgyygo60Xr3h/6CxXpU7+IesagB+ZesjZMEv4iT3/?=
 =?Windows-1252?Q?xLFslQwfperOzycBAgSrLeQQpd1jDUb1brCd9Vk3VyQP526TS9RFu3gV?=
 =?Windows-1252?Q?8WC/wc9+AGWYEGn6ZawxRBKcwUVc+57kd2RX/2rAW85kpfqpGTmLQ2xC?=
 =?Windows-1252?Q?ZoPMiIn3Cj4mDQTml2v2fdlt7Krg4Bm/0F9TVt8O78cWjHLEZAWk+X8H?=
 =?Windows-1252?Q?GQRD61CSIyPpSXCarTGqXzyfFkvDbyPPnWn7VW5vKBdeAtviaDoOZSEC?=
 =?Windows-1252?Q?v8WzK5utnfvL0r1I49xfhcyCV9QToKKk8qeuU3XZQWnM3fX9mLiPhxiJ?=
 =?Windows-1252?Q?g2oX75+s5q1R+nxZr1Bt4XLdOQ2iAuqzdmEeydKO/iM8Z06rDHnd2XqO?=
 =?Windows-1252?Q?Jt5pb3kh/xy7IA6V7mVfcoz1xgIHIdO4MxsRLCkmKwPL/O73NHGAHW47?=
 =?Windows-1252?Q?uIoJmBnoAhKtbdLjZGl1X6qYLPbNMKdg4+blalOl9c5NfP4P02GTJGwV?=
 =?Windows-1252?Q?2b5nvTFDTsENQOLD7dh3am6UWEyJqv2FfVArJSM6QopFacA0yicH0a9n?=
 =?Windows-1252?Q?H98Udd93M5tfKPr6mpkcNO/3zKU21ltllgiMj0Hy1mIj4C5RlEXY67/n?=
 =?Windows-1252?Q?L43KKHcsIT0Ii0PEK7x2MM4KEjJPA6jEpXxoMQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN0P287MB2531.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007)(38070700021)(8096899003)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?cqO3xVr5o1lMjao2ep1hhPCVnHAajee+P9siFDA+rlGS5GFLqmdIWRGj?=
 =?Windows-1252?Q?RiaVbU5rwuldRrwg3fp+qY0MKpwYFqV6EZ8wvfslwn3w9gqbsZUb25Fn?=
 =?Windows-1252?Q?sJ7w8UZbThViBG4MCl+6AOwhCybUgoKLM5m1uC1vjwKvqqf51qKgrDMi?=
 =?Windows-1252?Q?Xcomq43qqD7vYZuC9b4vfhAYtTCSMzC/GdXqhDmT4x751WAVrBluZtNd?=
 =?Windows-1252?Q?bRr6npxrasiTRL6NOHGq27TiZpshz5CeccevrRVuiiwILqmJ6wkiSRPt?=
 =?Windows-1252?Q?Xif7Zy/5bJVXFooXdRQuTuLVthWGIqslGb9X63KXCBvuZlVNdZiDB9R6?=
 =?Windows-1252?Q?hegR7+JfglKbshPgkmLP8dAvADnxa/LYCyNQUiZbu34kw8cu0DaEuxSm?=
 =?Windows-1252?Q?oNMkn+TR5vsAvSWpfmObqLijNE6qOlFD5BP5xejfflvUxaCIrRDVZdNI?=
 =?Windows-1252?Q?5GDsXuIZc+RvUlDl9yLxccQFpy3oOpwTFhx0Oh61ZI3DFN7qxiBoSAzn?=
 =?Windows-1252?Q?ks6WGT1hBB0ZchEj5z37UCtgUEbxE4+RDAuvd7WIqgjXoRPYdxbL2OlU?=
 =?Windows-1252?Q?Z8mXyZvm0ImNDADSKrIg4G2Y4J+LVZeghj5EtdmhFT5aANqa/X4K8O0n?=
 =?Windows-1252?Q?k6PhCyPkQnhO8GYjUeEVK51aPwbr4mvCAn+6J8/b3rFfnuA3+zAlCk6U?=
 =?Windows-1252?Q?/mqq7XxJtS9OCU+erQHr8vKKSHs3uDNeh9R+yJmRzGsUjtMUCSPukC8z?=
 =?Windows-1252?Q?aA9l0rz8/hl+oyEROdca23hR4dzm0YQlIQVYxz0ywSuFYTBL9e5vtD0F?=
 =?Windows-1252?Q?E97WbhgrFX1kM7e+qTsI3imAeeboGXHcqgOI1ak12vBVGgBBL/g0k39A?=
 =?Windows-1252?Q?hj4VztCJv0oJXxHlrlDmB6MTpbSyIFdkK1jGG2ZFkUyatsQwsm22zFa2?=
 =?Windows-1252?Q?jLEB6winBxtbEjiGCnDlFnOdMKHjkW7ECZkHJlpmYQ+ygkWcnn5s5iLl?=
 =?Windows-1252?Q?oOFMZUOEp2SYo/XP74gMkQCKQ1bK5gK0Tvnm9wFq+ImfUnAPwzXr9EcA?=
 =?Windows-1252?Q?E07T0hjIbGT7r7D0k+g0syk/Vh575523urm6gjhYZqFg5JYOsGXY1hcW?=
 =?Windows-1252?Q?1/0JhJg9rZujuNY0/zRyXRy2urKFbP8jDdZklOCdkiIKhtfarbq7Kzhb?=
 =?Windows-1252?Q?cO4ScuvV5fVdXqcweLB6VpxaqeOzCXMvdnL/TGBF030pknCifC4Re0eb?=
 =?Windows-1252?Q?TrqmFP4XeCkBQbeHQXILyBEoYjAvMR3SUN0aChPzniddi6PQw8ut7Ys3?=
 =?Windows-1252?Q?MHvpnuVyoRpIMn9bOc66KR5JVwQ8DrCKjnjbb9gPxLfZSZBp7ga6QR1a?=
 =?Windows-1252?Q?CkUBjnrUNHheebDg946nj6cOWgIrq+Pcg+9gYqemLDE3iBRAjl1dg1lu?=
 =?Windows-1252?Q?pOrDDsJEXmbdpDHJ39j1JrpHZiBVU9L1FQDStt6kp7qkmyT1oxEh5oGt?=
 =?Windows-1252?Q?xVM8FlY99rf2oMWBsTLAqVCfGQK6K9NybFCv0fVI+OAlpisdaf982ZiR?=
 =?Windows-1252?Q?vnpD+YU+cfCtWOUmdWdiPf83Fp6PWBTEQ6Ufaj393ukLnGSBQb+iTngx?=
 =?Windows-1252?Q?Js05rHpMJ5Hd6Yxhem+7wjp9jsuxJLUluEchZGC/Bw0LbzKTpT0w9mj5?=
 =?Windows-1252?Q?IlxgBFm0XdvPFScb+aFTQPyygbYpOgtm9VUugHukVq38FusVo1k+JYZ4?=
 =?Windows-1252?Q?HC35jUetmXwUSFbIacV9G3SJ/j5nKATjDiv8t9IMBBaUfS8A5RuARSsF?=
 =?Windows-1252?Q?0OnnXscARmnqG/JL3WOa9AiUjLk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN0P287MB2531E96B01827A3A26F4B4B6C5C5APN0P287MB2531INDP_"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b30d1630-3aad-43a8-0aa2-08de1c86cf3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 16:17:26.0902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RItdMAQsgyWvKrBrXkWT1GeMBfoTcLMN2zmYbK2ixq+EoDTzuRSbq+8HxLpwTlDRwN2RJwrU4tLsIDYg4VXsvGu3Zhkr6GrfZuXPybVYGIqSeGzF5y0mRmA19FhuokyI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1009
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

--_000_PN0P287MB2531E96B01827A3A26F4B4B6C5C5APN0P287MB2531INDP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Andre,
Thank you for the clarification. That was very helpful.
We will ensure Secure Boot remains disabled only within our DPDK test envir=
onment and review any compliance implications before extending the setup fu=
rther.
Best regards,
Ayshathul Thuhara

________________________________
From: Andre Muezerie <andremue@linux.microsoft.com>
Sent: 05 November 2025 20:50
To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>; Chaturbhuja Nath Prabhu <c.p=
rabhu@iwave-global.com>; dev <dev@dpdk.org>; Thenveer Poolakkanni <thenveer=
.poolakkanni@iwave-global.com>
Subject: Re: Virtio-PMD in Windows

On Tue, Nov 04, 2025 at 10:22:27AM +0000, Ayshathul Thuhara wrote:
> Hi @Andre Muezerie<mailto:andremue@linux.microsoft.com>,
> Thank you for your message. I am currently reviewing the details.
> In addition to my previous queries, we would like to confirm whether disa=
bling Windows security features for DPDK testing could potentially impact o=
ther Windows applications (eg, System update mechanisms, Enterprise Managem=
ent Software,..).
> As we had to disable Secured boot (BIOS) in windows to disable driver sig=
nature.
> Thanks and regards,
> Ayshathul Thuhara

Hi Ayshathul,

Disabling secure boot does not block Windows update, as Windows Update does=
 not require Secure Boot to download or install updates. However, Enterpris=
e policies often require Secure Boot for compliance. If it=92s off, updates=
 may be withheld or flagged by management tools (e.g., Intune, ConfigMgr) u=
ntil the device meets baseline security.
Some organizations enforce Conditional Access or Secure Production Access r=
ules that block OS upgrades on non-compliant devices.

Regards,

Andre Muezerie

> ________________________________
> From: Andre Muezerie <andremue@linux.microsoft.com>
> Sent: 30 October 2025 18:43
> To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
> Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>; Chaturbhuja Nath Prabhu <c=
.prabhu@iwave-global.com>; dev <dev@dpdk.org>; Thenveer Poolakkanni <thenve=
er.poolakkanni@iwave-global.com>
> Subject: Re: Virtio-PMD in Windows
>
> On Wed, Oct 29, 2025 at 12:09:28PM +0000, Ayshathul Thuhara wrote:
> > Hi Team,
> >
> >        Thankyou for providing this input.
> >
> > In addition we have a few queries while running DPDK in Windows.
> > (A) On what scenario or an example,  can Virt2PHY driver be used?
> > (B) After we bind the interface using netuio.inf file, the example appl=
ication testpmd.exe shows "No probed ethernet device". But in Device manage=
r the interface shows available and bind with QDMA. Here we are using QDMA-=
PMD(https://github.com/Xilinx/dma_ip_drivers/tree/master/QDMA/DPDK) driver.=
 This driver works with Linux environment.(Please let me know if we need to=
 create new mail for this).
> >
> > Thanks and regards,
> > Ayshathul Thuhara
> > ________________________________
> > From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
> > Sent: 29 October 2025 11:56
> > To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
> > Cc: Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>; dev <dev@dpdk.=
org>; Andre Muezerie <andremue@linux.microsoft.com>
> > Subject: Re: Virtio-PMD in Windows
> >
> > Hi Ayshathul,
> >
> > Adding Andre as currently the most involved Windows DPDK maintainer.
> >
> > Virtio PMD could work in QEMU-KVM on Linux host with Windows guest as P=
oC.
> > However, the patches were never completed and merged
> > because of a few toolchain-related issues that no one had time to resol=
ve.
> > In DPDK, the latest patch is this
> > (check also the link in that message and the discussion):
> >
> > https://inbox.dpdk.org/dev/20210815145614.3826-1-u9012063@gmail.com/
> >
> > In DPDK kmods repository, you'd need to add PCI IDs to the INF file.
> >
>
> Hi Ayshathul,
>
> I don't have further context on this, but let me know if I can help with =
this.
>
> Regards,
>
> Andre

--_000_PN0P287MB2531E96B01827A3A26F4B4B6C5C5APN0P287MB2531INDP_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Andre,</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thank you for the clarification. That was very helpful.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
We will ensure Secure Boot remains disabled only within our DPDK test envir=
onment and review any compliance implications before extending the setup fu=
rther.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
Best regards,<br>
Ayshathul Thuhara</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Andre Muezerie &lt;an=
dremue@linux.microsoft.com&gt;<br>
<b>Sent:</b> 05 November 2025 20:50<br>
<b>To:</b> Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&gt;<br>
<b>Cc:</b> Dmitry Kozlyuk &lt;dmitry.kozliuk@gmail.com&gt;; Chaturbhuja Nat=
h Prabhu &lt;c.prabhu@iwave-global.com&gt;; dev &lt;dev@dpdk.org&gt;; Thenv=
eer Poolakkanni &lt;thenveer.poolakkanni@iwave-global.com&gt;<br>
<b>Subject:</b> Re: Virtio-PMD in Windows</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, Nov 04, 2025 at 10:22:27AM +0000, Ayshathu=
l Thuhara wrote:<br>
&gt; Hi @Andre Muezerie&lt;<a href=3D"mailto:andremue@linux.microsoft.com">=
mailto:andremue@linux.microsoft.com</a>&gt;,<br>
&gt; Thank you for your message. I am currently reviewing the details.<br>
&gt; In addition to my previous queries, we would like to confirm whether d=
isabling Windows security features for DPDK testing could potentially impac=
t other Windows applications (eg, System update mechanisms, Enterprise Mana=
gement Software,..).<br>
&gt; As we had to disable Secured boot (BIOS) in windows to disable driver =
signature.<br>
&gt; Thanks and regards,<br>
&gt; Ayshathul Thuhara<br>
<br>
Hi Ayshathul,<br>
<br>
Disabling secure boot does not block Windows update, as Windows Update does=
 not require Secure Boot to download or install updates. However, Enterpris=
e policies often require Secure Boot for compliance. If it=92s off, updates=
 may be withheld or flagged by management
 tools (e.g., Intune, ConfigMgr) until the device meets baseline security.<=
br>
Some organizations enforce Conditional Access or Secure Production Access r=
ules that block OS upgrades on non-compliant devices.<br>
<br>
Regards,<br>
<br>
Andre Muezerie<br>
<br>
&gt; ________________________________<br>
&gt; From: Andre Muezerie &lt;andremue@linux.microsoft.com&gt;<br>
&gt; Sent: 30 October 2025 18:43<br>
&gt; To: Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&gt;<br>
&gt; Cc: Dmitry Kozlyuk &lt;dmitry.kozliuk@gmail.com&gt;; Chaturbhuja Nath =
Prabhu &lt;c.prabhu@iwave-global.com&gt;; dev &lt;dev@dpdk.org&gt;; Thenvee=
r Poolakkanni &lt;thenveer.poolakkanni@iwave-global.com&gt;<br>
&gt; Subject: Re: Virtio-PMD in Windows<br>
&gt; <br>
&gt; On Wed, Oct 29, 2025 at 12:09:28PM +0000, Ayshathul Thuhara wrote:<br>
&gt; &gt; Hi Team,<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thankyou for providing =
this input.<br>
&gt; &gt;<br>
&gt; &gt; In addition we have a few queries while running DPDK in Windows.<=
br>
&gt; &gt; (A) On what scenario or an example,&nbsp; can Virt2PHY driver be =
used?<br>
&gt; &gt; (B) After we bind the interface using netuio.inf file, the exampl=
e application testpmd.exe shows &quot;No probed ethernet device&quot;. But =
in Device manager the interface shows available and bind with QDMA. Here we=
 are using QDMA-PMD(<a href=3D"https://github.com/Xilinx/dma_ip_drivers/tre=
e/master/QDMA/DPDK">https://github.com/Xilinx/dma_ip_drivers/tree/master/QD=
MA/DPDK</a>)
 driver. This driver works with Linux environment.(Please let me know if we=
 need to create new mail for this).<br>
&gt; &gt;<br>
&gt; &gt; Thanks and regards,<br>
&gt; &gt; Ayshathul Thuhara<br>
&gt; &gt; ________________________________<br>
&gt; &gt; From: Dmitry Kozlyuk &lt;dmitry.kozliuk@gmail.com&gt;<br>
&gt; &gt; Sent: 29 October 2025 11:56<br>
&gt; &gt; To: Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&gt;<=
br>
&gt; &gt; Cc: Chaturbhuja Nath Prabhu &lt;c.prabhu@iwave-global.com&gt;; de=
v &lt;dev@dpdk.org&gt;; Andre Muezerie &lt;andremue@linux.microsoft.com&gt;=
<br>
&gt; &gt; Subject: Re: Virtio-PMD in Windows<br>
&gt; &gt;<br>
&gt; &gt; Hi Ayshathul,<br>
&gt; &gt;<br>
&gt; &gt; Adding Andre as currently the most involved Windows DPDK maintain=
er.<br>
&gt; &gt;<br>
&gt; &gt; Virtio PMD could work in QEMU-KVM on Linux host with Windows gues=
t as PoC.<br>
&gt; &gt; However, the patches were never completed and merged<br>
&gt; &gt; because of a few toolchain-related issues that no one had time to=
 resolve.<br>
&gt; &gt; In DPDK, the latest patch is this<br>
&gt; &gt; (check also the link in that message and the discussion):<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://inbox.dpdk.org/dev/20210815145614.3826-1-u9012=
063@gmail.com/">
https://inbox.dpdk.org/dev/20210815145614.3826-1-u9012063@gmail.com/</a><br=
>
&gt; &gt;<br>
&gt; &gt; In DPDK kmods repository, you'd need to add PCI IDs to the INF fi=
le.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Hi Ayshathul,<br>
&gt; <br>
&gt; I don't have further context on this, but let me know if I can help wi=
th this.<br>
&gt; <br>
&gt; Regards,<br>
&gt; <br>
&gt; Andre<br>
</div>
</span></font></div>
</body>
</html>

--_000_PN0P287MB2531E96B01827A3A26F4B4B6C5C5APN0P287MB2531INDP_--
