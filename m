Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A629BCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 05:55:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7696140264;
	Fri,  7 Nov 2025 06:55:44 +0100 (CET)
Received: from MA0PR01CU009.outbound.protection.outlook.com
 (mail-southindiaazon11020117.outbound.protection.outlook.com
 [52.101.227.117])
 by mails.dpdk.org (Postfix) with ESMTP id E9CCB4021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 06:55:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyy70tjFxBHn0zu0m6QRGM50RZZwXFiDDlREnEISg0vEu+LndgV4Pt0nD35YWN4bfhzaSjzEC3Z8XGGiMvwqWO6mVPn0s1WPOLaIaQDV5JjyvBRGeZXKh7TUlHHkTsOsqsXe1/gXneVHbC5ud/yLtLA2oH+yXI6lGOMyq/mrLaP3DjggDwu81xR/UGu1weS2E3iL4r3kWsDsgC5ymBXTClLl+lezgUikF3uFeKYDtN68MRhmZKqxNV4euYg+duSzJS47JW79kTVsAqcbIFb73sH17KNyxt/j9q8fFaCJncefjnz+XZhJgCjEU87ICwBDl4qfXFewf/y1LmuwyETsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMAq5jGOwNKNsmmo8Bw7Yc2PN8k1sodDVfeVuBB7bOM=;
 b=dhDYsUdDS/mbS8uCydUM5A2h+gzyvzxKBig5gQ9czH+x1+Kv6guFhXm5yszWgGElllrRRqQkrXs1aNeBcWxyq7+8KypusGtx8eN6qy67VK2IoXs4BF1Uawnk+NraEriNEY/ZPqB/jtVLo4gn9kX7CWh9O+LmJoXRHN/3/Gu4Jl7X6SgWSIiTDmluQVWor9HL7qlXsuW/Ix+ht99ioWsAT81vbBCNdxmOv23yF4y0gYlZUOX0ZzELfjX2daWTzl+QVfMXPG0hXa8LSe3svmgCgMjQa+rTajz40tW/F0ALTJ5K573arHErOiy8VcHSOGJ83djl63wiFy3sUAIoHKiIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMAq5jGOwNKNsmmo8Bw7Yc2PN8k1sodDVfeVuBB7bOM=;
 b=QuU5ZU239nZKLDnaydaBkS8r0KbHtujve3vgrqFdD1o44J6xaLlpJlhPyExg5BsY2Bbi41y46R9+2rRIXO+MBKpMR71rXwOG3fnvO4+PbRvNjlr+hzOhHuN5Q6W3ViMlnIiQO8ZZGbT2kJUqVRJcgVNJP3eWXV1IZtDQ/qQ+JB2PBzLPbrupFrH8tXt5BpPFNdKWwbouVRGWUC+lO/ZZQ5O/C8lkJDqsXREIVN2Huv96JtvTN+5CsY0vZXK33++R6o1WDPQtklwvoceqn0gQZ1vqQxSWAcnOExB9VIfuMHiACe6u1UfLuDZ9pPN5E1k+a3Lmln2B/3kmRFUGeRq+Ag==
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ff::6)
 by PN0P287MB1316.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 05:55:39 +0000
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44]) by PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 05:55:38 +0000
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Chaturbhuja Nath Prabhu
 <c.prabhu@iwave-global.com>, dev <dev@dpdk.org>, Thenveer Poolakkanni
 <thenveer.poolakkanni@iwave-global.com>
Subject: Re: Virtio-PMD in Windows
Thread-Topic: Virtio-PMD in Windows
Thread-Index: AQHcQllTOt/KxgpIwU6HUkaaP8NWhbTMN1BhgAkzIm+AAyS8aYAAJfOAgABcWhmAAae8AIAHqaQQgAHn9ACAAA9PxoACdkhZ
Date: Fri, 7 Nov 2025 05:55:38 +0000
Message-ID: <PN0P287MB2531A72E564A4E37B27D7ACAC5C3A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
References: <PN0P287MB25316B273566FD2CDDF0D83AC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531616EDF3F92036B4E01DFC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531AEA71C2E1A6B25D15680C5FCA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB25314E093834DFBAA35898A5C5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <1c5cad85-1408-4458-9e32-08f45f36c130@gmail.com>
 <PN0P287MB2531E4AB73A84D84E5F3A2DFC5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <20251030131318.GA15405@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <PN0P287MB2531E1E798D9799241E9E9C4C5C4A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <20251105152044.GA3941@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <PN0P287MB2531E96B01827A3A26F4B4B6C5C5A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <PN0P287MB2531E96B01827A3A26F4B4B6C5C5A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2531:EE_|PN0P287MB1316:EE_
x-ms-office365-filtering-correlation-id: 48912265-9141-4b78-fb2f-08de1dc246e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|38070700021|8096899003|7053199007;
x-microsoft-antispam-message-info: =?Windows-1252?Q?/hmmmejVmE30FHTlRck+u8hEiAi764hnhrQ0UK/CI6FADXorvdbP2hk4?=
 =?Windows-1252?Q?DwCnq9x0xdf86orVVr5FPagLZCM/w3d1Q9uqvZVJITOOaf1dl9UKytni?=
 =?Windows-1252?Q?ZxKjDQvwLrDPTI36JY5CEmZ6RnXwUJxl1YHOVLZEUg53I3Uh3xI5Xx4v?=
 =?Windows-1252?Q?jyKU+ar71KqwdwX+8WKC8P/VOLwUpuAQ7jXv1m7FnWJWp2uCK3iT7pgX?=
 =?Windows-1252?Q?1SpxEAPthpn/ba1gzmr9TkKKdBr+0KBZBmfxdEL5n4+nqp6Sf7+N64HK?=
 =?Windows-1252?Q?MaeyHPgMPpWDWaXPIeY9aH3KK15qry4DIjBKUloQRv+IEAdelqO+kEBK?=
 =?Windows-1252?Q?Amn5QqbMCWMPlujMvNseY1qHWMJF1Z1AEVm1kmllfIUkY0uB7yE+eP6Z?=
 =?Windows-1252?Q?0ch1l7cXcifsoivu3+1VwFdTq/hEKDVe1MI9KLTr87To4SPvf09P4YhS?=
 =?Windows-1252?Q?AijTqUEcUNV9jtDN8sHqECcrcny6RgeEne4WfUu+aL3Ek+i9JScozoQy?=
 =?Windows-1252?Q?2wJA7R/wyGelFcdgI2Qz6wwhu81Yf2pBBlNd93u9vKbVQ7+2w1ugUXvG?=
 =?Windows-1252?Q?xF4H8Uc1Oy0o2/oHaYG8pJlo7lP4rvElf0YFBs5QPCu2ACoxi+6oqzWz?=
 =?Windows-1252?Q?IgaeL0mTDdyvr/9NdZSZNXqveefMuGkgUCVUU7yxDizo6pdXz2hkUc5F?=
 =?Windows-1252?Q?BF0wBsxSs2KcMupP/bknC2eOZCFgFvA6nZj5JLdHWsKrnuWrpdx5ZorD?=
 =?Windows-1252?Q?7uLJ6ZA9WmnWaCVgP1A9iSSLpKBCNCxdYk4XBwCabKW01Smn95tpjhmc?=
 =?Windows-1252?Q?jGCrBwcnji76izhWMelKOnQQZQLC+o/SRabYbm6kgE0afHh9XrxyYuor?=
 =?Windows-1252?Q?+kVfNCgqRBwPqTGIcnv7cezpv85+QKvto5VqTC+4eZSMOWU5l6vFXluT?=
 =?Windows-1252?Q?gH4bQVhXeYZizNsA0NlilB1yqgrZW+Itqx9AUDeA6U2vcYXtSvKfDNw9?=
 =?Windows-1252?Q?xg8DBTRumz/zIaajSt75jT3hko9zXWv0UVt30JcUMXNh9d5DSBIYlyme?=
 =?Windows-1252?Q?1+aazN1w1FxGdJuw+Li2hMxV+6+MWMhYlAWYZ+VyZtYBjQRq0Csfkh+t?=
 =?Windows-1252?Q?On2bB7qgAokuZ/1/PrWLP31SXi3KZlAKaxpsl+AOlubSvlzpUZEdmbWT?=
 =?Windows-1252?Q?9cex/Dg0BZYNyCeg/tSSAel6rERzr5kf8xDApcadSCyQ/picyyE8m7E/?=
 =?Windows-1252?Q?dr6R3RQXoj9LqsjwFxKvBV9tnWkbONbDJltcrO3xflZg+yYvlgNyM3rQ?=
 =?Windows-1252?Q?M8crtGX+kPme9pxt0BnreeqmW8w9alqzOAFHe6/sKjClTyBhqHhwztzN?=
 =?Windows-1252?Q?gRWhABtn9RtX1YUDLeaKZRkN0SPLWgWV5C131dY/7YkuZxEj6zxu08q1?=
 =?Windows-1252?Q?pS2fMHgDPGxQktEgkm58ORf0Fc/U1tTgzAAE/sxljOjcCgbraalzopa7?=
 =?Windows-1252?Q?OnN77xlkDPzUu8HfcH61wN/vhzjvWbM5KoTZuLXRfrlpVCD2pU953si9?=
 =?Windows-1252?Q?nz89ceTU8CpcZeXtOPbdjnr9JrDdHlEkoka8sA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN0P287MB2531.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?RgTXmAP8JfjZF2RFGIxod2FLZJ+QZnf/f/1+nyyct7aJqpk2gGMgvle3?=
 =?Windows-1252?Q?7X2LIO+DZ5KUMQo0AFYtxCjB92r8UeUxLlaIakJVfttxCe/FUQS8fXCB?=
 =?Windows-1252?Q?XsVnWO/cTDb2Kg4XYBaUAJXgDUkn8xA/iADpnq5N1Ri9tQfLn+kZj/+C?=
 =?Windows-1252?Q?4JnZDg4V01E2rkX4tdgb2xuq4ULaORFKpVijScy0t8bxwpSBC5X3DcF5?=
 =?Windows-1252?Q?cDevMYkDBc0B7Wf6R40TprbuYc91Sdkq3qR6Eh75jLbXCf5flbWOJETV?=
 =?Windows-1252?Q?1gAUf7MrtmMRngdMC7xyyyCYYoCbnn/IvIT11gesfv1fC9b+aEqSYgMO?=
 =?Windows-1252?Q?j/9m1t28DUBvKfe9JT8sbmhnVyWItwL0HTa2uLWCniqvcIxJYhdmZmEw?=
 =?Windows-1252?Q?djffJHxtdw8XdKgu1A4S+48xONmU0rfUx30VgpG34U8pQ1mXg/WmPIzD?=
 =?Windows-1252?Q?KnSbdA0yZXYk8yrYjFFCdaTzE4gpHTTwY7MjNPhvDJt5iMFtLqRKM9lo?=
 =?Windows-1252?Q?l0W11JFK8q2N/6sPVkOqSyh1rOGpbzP1HfalvAP9yVY3ceMPIJ6n/dLT?=
 =?Windows-1252?Q?ApzYg0kHz1nOOGZpxIjcv/eL4UUf/mt+rcec7pLFRuH/rV9xY50aXFir?=
 =?Windows-1252?Q?Rwoq54B8PEl8ZBz68MWuSOGmkk/MEBK+PinCYi5NlHZNQlsP580wPEj6?=
 =?Windows-1252?Q?6Of2SrZSFUJql7qcmG0fMr/jkkkst4bq99wvJLvZw4p4vo0PmEh9wgUA?=
 =?Windows-1252?Q?w0NqPmgHNMS6bu/U4w2ZcDYqyqz/rj7A1kNbwuPn2k76Otd2ZfwYO6uN?=
 =?Windows-1252?Q?gegM2hR0MRrln2sRe+n5cwUrmKvGP+qkEeOoffGnu8bcCG3psfQm+5OW?=
 =?Windows-1252?Q?1HZAcX92SoOQ+PmFzjnCoGdsXMpviIJzZGWFepkDEChguQIkzoCrfydK?=
 =?Windows-1252?Q?iq5i7tI+A2der6UM8t/yP4BKpCoKMAG9wwgZ75bp178hTwHVRfUC5JiA?=
 =?Windows-1252?Q?EyQCsGanSxHsanMFHgnpbFhyWsWXdyk3OPqq5YuB7eLbpab0+FMuivFc?=
 =?Windows-1252?Q?UozkeOqVNKM7V6uGecG3oUJ3wFyvWwyiqqnXjTmm+6VPU/LqFmgUIfxN?=
 =?Windows-1252?Q?PPYPZXc/T5JO/jSGi/4Z/yp359gb8fHlPlNMlaApKzJqGKW+P8qkzOv4?=
 =?Windows-1252?Q?hpJQZ3s3EjxleChbhwtVDkW1r7b/XSp/B/X+z81OfTwwkTdTA/ydlPfm?=
 =?Windows-1252?Q?odtXtfcG20PZyo2aPeGbRqohM502PPsCU84cMB2RBrZzNmIt8FN0IJb5?=
 =?Windows-1252?Q?0rqtzQHX+a6VSvpa0Gx3dtYNGQk9B2iKnpILfIUwNQNbpuUuxGmvvOj0?=
 =?Windows-1252?Q?PGWTPRGtXbmDMOMVsjhNNGbQ9SnaLrMgU3lG1I96EecBG1YOWRppTAtP?=
 =?Windows-1252?Q?AslE2wD+tG5HudNXh1lwoYMQ/gJPzqv29ZjW3xELSKTCewhqNKTXB7bY?=
 =?Windows-1252?Q?uFqb9w82dTk8UxHi74QRWbSewYtsDETcs4YB31xoKqjkzLXTHd9bP9qZ?=
 =?Windows-1252?Q?qTCl/9jY4Si3G+HdWdtnv/4AEyO6PDYLa+54nshkESttPGNj/2+XOGda?=
 =?Windows-1252?Q?KSMUbZh0VbbfILZTQzjqZ/RDrqvYntBGVMr0W/ZGwp+zFsprbRH8nuzj?=
 =?Windows-1252?Q?dqXYPst0AlSr+GPvPbmVZ/YarlXBCblQdfj7xkWhB7UUR/gnzjaRrQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN0P287MB2531A72E564A4E37B27D7ACAC5C3APN0P287MB2531INDP_"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 48912265-9141-4b78-fb2f-08de1dc246e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 05:55:38.3074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DCjF/Uplhat6Yx71rTbRcK7/uQIyVI0/qhfgFM9i4T33TXU2vWL4xWnsHtv3qn9bJdFJqEn4H+byP08VUBws82xvBDWt6v8UFjXsTUQsAGywhvhUeuH11QksbZ/WRe/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1316
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

--_000_PN0P287MB2531A72E564A4E37B27D7ACAC5C3APN0P287MB2531INDP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Andre,
Apologies for adding a few more queries.
Do we need to modify the SmartNIC design (FPGA shell) to support Windows?
Will the same design work for Windows as it does for Linux, or will the PCI=
e section require modification?
Thanks and regards,
Ayshathul Thuhara
________________________________
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Sent: 05 November 2025 21:47
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>; Chaturbhuja Nath Prabhu <c.p=
rabhu@iwave-global.com>; dev <dev@dpdk.org>; Thenveer Poolakkanni <thenveer=
.poolakkanni@iwave-global.com>
Subject: Re: Virtio-PMD in Windows

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

--_000_PN0P287MB2531A72E564A4E37B27D7ACAC5C3APN0P287MB2531INDP_
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
Apologies for adding a few more queries.<br>
Do we need to modify the SmartNIC design (FPGA shell) to support Windows?<b=
r>
Will the same design work for Windows as it does for Linux, or will the PCI=
e section require modification?</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks and regards,<br>
Ayshathul Thuhara</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ayshathul Thuhara &lt=
;ayshathul.thuhara@iwave-global.com&gt;<br>
<b>Sent:</b> 05 November 2025 21:47<br>
<b>To:</b> Andre Muezerie &lt;andremue@linux.microsoft.com&gt;<br>
<b>Cc:</b> Dmitry Kozlyuk &lt;dmitry.kozliuk@gmail.com&gt;; Chaturbhuja Nat=
h Prabhu &lt;c.prabhu@iwave-global.com&gt;; dev &lt;dev@dpdk.org&gt;; Thenv=
eer Poolakkanni &lt;thenveer.poolakkanni@iwave-global.com&gt;<br>
<b>Subject:</b> Re: Virtio-PMD in Windows</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"margin-top:1em; margin-bottom:1em;=
 font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica=
,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Hi Andre,</div>
<div class=3D"x_elementToProof" style=3D"margin-top:1em; margin-bottom:1em;=
 font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica=
,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Thank you for the clarification. That was very helpful.</div>
<div class=3D"x_elementToProof" style=3D"margin-top:1em; margin-bottom:1em;=
 font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica=
,sans-serif; font-size:12pt; color:rgb(0,0,0)">
We will ensure Secure Boot remains disabled only within our DPDK test envir=
onment and review any compliance implications before extending the setup fu=
rther.</div>
<div style=3D"margin-top:1em; margin-bottom:1em; font-family:Aptos,Aptos_Em=
beddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt=
; color:rgb(0,0,0)">
Best regards,<br>
Ayshathul Thuhara</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Andre Muezerie &lt;=
andremue@linux.microsoft.com&gt;<br>
<b>Sent:</b> 05 November 2025 20:50<br>
<b>To:</b> Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&gt;<br>
<b>Cc:</b> Dmitry Kozlyuk &lt;dmitry.kozliuk@gmail.com&gt;; Chaturbhuja Nat=
h Prabhu &lt;c.prabhu@iwave-global.com&gt;; dev &lt;dev@dpdk.org&gt;; Thenv=
eer Poolakkanni &lt;thenveer.poolakkanni@iwave-global.com&gt;<br>
<b>Subject:</b> Re: Virtio-PMD in Windows</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On Tue, Nov 04, 2025 at 10:22:27AM +0000, Ayshat=
hul Thuhara wrote:<br>
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
</div>
</body>
</html>

--_000_PN0P287MB2531A72E564A4E37B27D7ACAC5C3APN0P287MB2531INDP_--
