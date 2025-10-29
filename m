Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFD3CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 12:09:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 833A44029A;
	Wed, 29 Oct 2025 13:09:34 +0100 (CET)
Received: from MA0PR01CU012.outbound.protection.outlook.com
 (mail-southindiaazon11021085.outbound.protection.outlook.com [40.107.57.85])
 by mails.dpdk.org (Postfix) with ESMTP id F3B6940288
 for <dev@dpdk.org>; Wed, 29 Oct 2025 13:09:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUUn613ly3HF7+Yuxq3SAxEVUIlmHNgFiu6iLIQy04TcLT+Ev0B3y9mFbvJm50eSEDkl+z/BbxlKxOjjrK+ZbRCl4X/RaTr8iZ2nDOmkI8g5+Pf7PMT2E1sHVTxcQKQ9ukfLpvIyG0Zvp7kFhWvFotOK3pjG3IThSs2Jv36jM0HHYd5+LLIYSE5z/UpmPmA0LlQ0zXEGiHiKxgUVsGx+iovHmEp5h9qxxl1yTvuzsZt4RZwBps4YMXMqkrg7EjUj44dJyGuvswU21JtY/JPFibw5UVpVtstxgMTG4iyTJec7gdRrJ/kyE/hgW/pAuPpiL07/PShCXwXUuXu2V3Ebuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw1ERZC/SIg0ezN7L/Efw9deLoRIk49cv3LgI+lbe1M=;
 b=GrDaB1L713Jw/MSf4eJzt/kwXwE48i7gGDB+cZx7zhmcMD+mLd1NfO90hXMO9MS5F7rTi2vdUPyNs1EAUZg/O9LzO0ItdG8ijatwa0E5oM5nY1WJCLE9Ie0py5HlQ3pVzMWuanfG3fhc7CAFALwDxOED73N20e6XhrO58xdHhVGMGH5nbG/eHQwMdPEAIszLSE715sAVMX3Gy/SZFDdTv636GkJuVXMzwHCpd8OZKaUgl8OA8Rzs+SH8dHaMCmLYk3Q3wggIpG6uHoNawi28OVnrdhenJZYoZS+++kkQBRMeJNNHZZ0JqOMV2sUSGBP3AEZlN2V0IcFrWbaOj96bxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw1ERZC/SIg0ezN7L/Efw9deLoRIk49cv3LgI+lbe1M=;
 b=YWFEMcVNNkbBRGh2aRPkp8L5NALz2LprTy7Foe7/pApz5sA5SGk261efSZDkEC4KcMPfVX9puyZuikqS+kbcoi5GsAPUFiYdDfOllzhtiy6QjJgJvwb4Mi8TjXZpzwQIOfrCsYDcMmjGJlkEqYtc1qzaP/7hVzhsIK8LRhBBhXQCK2HKHDTEeDQevLWYBGeLJMF8msBotVuW64GOqIxWsXz/spNvdKy8D+RIh/17f48H229JSQJ1yNN7ol2SYPpY+XbYwUGgktDZVshTpunFh0kN08L6NSLuMnzhj84plbxkYhspJrH/YgMEifSKuNhClX+1CT3NPgML0gHaxbEE6w==
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ff::6)
 by PN4P287MB4843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 12:09:28 +0000
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44]) by PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::1c15:d45a:75b0:af44%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 12:09:28 +0000
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
CC: Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>, dev <dev@dpdk.org>,
 Andre Muezerie <andremue@linux.microsoft.com>, Thenveer Poolakkanni
 <thenveer.poolakkanni@iwave-global.com>
Subject: Re: Virtio-PMD in Windows
Thread-Topic: Virtio-PMD in Windows
Thread-Index: AQHcQllTOt/KxgpIwU6HUkaaP8NWhbTMN1BhgAkzIm+AAyS8aYAAJfOAgABcWhk=
Date: Wed, 29 Oct 2025 12:09:28 +0000
Message-ID: <PN0P287MB2531E4AB73A84D84E5F3A2DFC5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
References: <PN0P287MB25316B273566FD2CDDF0D83AC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531616EDF3F92036B4E01DFC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531AEA71C2E1A6B25D15680C5FCA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB25314E093834DFBAA35898A5C5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <1c5cad85-1408-4458-9e32-08f45f36c130@gmail.com>
In-Reply-To: <1c5cad85-1408-4458-9e32-08f45f36c130@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2531:EE_|PN4P287MB4843:EE_
x-ms-office365-filtering-correlation-id: b174339a-98f8-4ca0-b66d-08de16e402a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|13003099007|8096899003|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?JbnXlMlyOIg47Y0QlHNmgFKL5gaHcav5FGSQqiJdzwOsJRz2kF3iVJznXohZ?=
 =?us-ascii?Q?GaZ8KBHzu4cJzqYhKFxt59QckvIYRFOVpf77NgBN7Iuzq+tDNcuN5HcoYJ5V?=
 =?us-ascii?Q?VS1QIGT2AN26+fgO83a18QJmLVAAmfmBGj7YTGxOw9u6KoKd2+yL+Juwu2hN?=
 =?us-ascii?Q?avKKYKOMTh78pJWRgjMGTf/roOQ0n4Z/Iizem3oXhxYcWuuNHFlqLXNO6gVL?=
 =?us-ascii?Q?UBbR0fWuCchPNaemkR7gkEfv7FjcTkulSUQBWohrxHIviOUtzmUq3jItXoTe?=
 =?us-ascii?Q?oejExIMUX0713Vv8EK9w+A/RoImjD1sk/U7FuL2FpBkVxsZzWMqMSuUJuXoL?=
 =?us-ascii?Q?AlY8hHSgU8fsNyAcOv60HEafe2825QdcLtD43O/lsS5FPVOwv4aeyQuN1Aa9?=
 =?us-ascii?Q?adQpSLxMTAQrCtKSG12+3woI58C4hTUV90DJmcKoA3br/YHd5DZER95NfrKV?=
 =?us-ascii?Q?IHc8AYpOZiqNw7pRDFgtZYMBGKiLHsRKsCGA0NvLAdD58iYHbTkaNAgCC4Nu?=
 =?us-ascii?Q?gDpGWya3xnFoZ+89kXAX0SvefPF1HYj20J1pRXDmVd4bPseY8tAi4shk2pS/?=
 =?us-ascii?Q?LT5q9vAW5OPp+P+WiJmg/P/gxZa7MHxp2VDLPv2VxaEoonDro4arPX1Kwh50?=
 =?us-ascii?Q?IIdwHGaiP2j/nLS2Z2eerYY2NLJYS+FN52FGRqFzUSaEit2GrFs82Elxkc+n?=
 =?us-ascii?Q?PhAP3WDOp0kXfywfL+Oz+P+2HG2k+/aAgAuMhtoOH27G084ufx79xxkVRgWT?=
 =?us-ascii?Q?Jv5XSwN0+FKqFjKwndww9U12SP4bIvR+nmyuPK69Cm6SyyH04a8BpC/h80vv?=
 =?us-ascii?Q?UHukl/0Nn5jrScWiuqA4XxLiZpAA9mQdNKxjnuh0AL3m4ykZol6qz8QUPhH0?=
 =?us-ascii?Q?Yc5t3bYBR78zxnNH9hKOm3WKaqiEWhYcLn5lxxTiht+UpU5UaDnQcYZ08av+?=
 =?us-ascii?Q?MUYuY2+GdWHU6sAMpxcSLcp+2U2+nSTy27EpWvRfxwl6N30xgUz2Ki6zIH1v?=
 =?us-ascii?Q?aZQqoyMxS89ZYGLcYZx79l280RYPUfYk9fHWotGdR5DNw36XH9eFfHgPtwp5?=
 =?us-ascii?Q?jwa9H+NeeJXQCp8usi6/tDLk86HIZ6MyjQiKTHFIikRsD8JmvDMKmdG+IPy6?=
 =?us-ascii?Q?FYwH/INTZcgqa15E3THT4EugVO0Ms28d2FpuVOCwr1iXJhsgWZddAW4nQ/bA?=
 =?us-ascii?Q?40ITM0LkOVicbrtYuYHZN0KibFWyy4SX39XN6v9Q7984WkFbMtMRpjC1ODPp?=
 =?us-ascii?Q?6CPN6IVrnH7sR1WnedcOw5ZhE5YYbnU7qiB0ROdSHRF39lSQhZSgWbreMvgf?=
 =?us-ascii?Q?F/hwtT5T7ucupY0nhZn01A+Ddijst/SJuIyOzSaGRoHEHR2bJqWr0TDdhPYI?=
 =?us-ascii?Q?b7UC1GNGts9Cm/7ewsUlhQYOeVKXAoDCOOosPRl+Z85vAW5CVCzGMzEdw0++?=
 =?us-ascii?Q?U2DXBOeTfklnLiH35T4DDBH0715Lx/5W3JFM17Xqgr8TMY0c82K2UgUFtrOC?=
 =?us-ascii?Q?dKwjH+ptdiPfr9D1FTW9+sSIOPmkrxFiBxu8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN0P287MB2531.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i0oEii42PejykfYe1ZOM/zDY+cr6TKGUgCGIYNPtsurJao4voaOct+bU+B+U?=
 =?us-ascii?Q?7T/twNjoHp0gGrAmglcFYG9gPesoXq2hukbuv6Jg0NmjeQCnZWk4F/1JbNO1?=
 =?us-ascii?Q?pSVVHCj+w2PULZ8V3v9V1J6iUWoDDLkOjrBju3Q2jAc68Rhq+6LnzhK39X1o?=
 =?us-ascii?Q?O8ftm8jP7UyC7vaaR8ijzIwQare3g/BhDaZRtKJ2X3USlT/NNFG4/s0IbkFF?=
 =?us-ascii?Q?qxdpaBYZ09DdB3gfM2lqQLC1cTthH6iQQnsSx9sx6r71YEmyekIe/BBe4+js?=
 =?us-ascii?Q?KXy2JfpuqPckPrDh/uZuFFGXqrGbNZqZdhPTWwkXZVmqO925PCMa2UfkzxfB?=
 =?us-ascii?Q?aCeTkR837HrryCxBJKkbDjAA1pDfWTyg4EIxJxJZZ47zB1SQI3WQTREN3Hfb?=
 =?us-ascii?Q?t/SFaSdxpLsRXS+hiLUzSQNwz9ieKfZtBJwOhKFhVwYvua9bVBSwEK+LxLFi?=
 =?us-ascii?Q?S5S1yz6zSMTcJYDwdZ/zXIqup6KJfSCKYIj4JIHYz5GRx0i0io/pruP4pyyX?=
 =?us-ascii?Q?8QdZ6ahcpN557qmXuc+j7GMMsWPnyMS5Sb2a5zFCQvmh8Cb4JFsA4ebzT1KM?=
 =?us-ascii?Q?y4mIyPIEx81rI6JcsGg1YErJZoLB0PeEUWkrM0fxywdJc5A45n4WUOq0MR5m?=
 =?us-ascii?Q?mdDBVhX0zHM4eaJGUK7MX4t5qG83S8JPi5qCw8u9bwrajADhZRBsn1uXKmA/?=
 =?us-ascii?Q?VwqUOJongNKElVLJ0EfilbutmnvRo9L/0ezdcTsClns1lZAJlplqTd9ySbCQ?=
 =?us-ascii?Q?898VOhG49K0eERMMfAOvGjVJBVBADaEt42hhDOX13JjWg2NhmXA7s9GNIAmz?=
 =?us-ascii?Q?uMnvY4HeX4GMggESe/skYiH61TNYNKaRhEoPL1sJoRbtyvoWDbucJBQsv9xp?=
 =?us-ascii?Q?zq+4PsuS3kp4qTo9RTuB+chWDiJE1CCtmZhlzI3u/8I/dMkNzpp+1V8j9FPK?=
 =?us-ascii?Q?mUTQebwCAO1+iwct14cKGZM0ga4APV93QheJM9djPmkbv3Bnp2A8avbXCKlz?=
 =?us-ascii?Q?3v5gSHQc9tOR7N7+4eG920HcO16cz7yJpX6DVmVLP3elWlddQ3evsroGI5J7?=
 =?us-ascii?Q?rcDkl5A0iDiyFsBemDNHVzYwGMC70uj/eiXc8zSgO7jr43H4NhYMKsXfg1nM?=
 =?us-ascii?Q?cf3oVDGRs7Jej5hQZl2oKhGwaBGhgIvrm9NTcKRfvwXu5U4zGZzKUHp+4Wm5?=
 =?us-ascii?Q?Icuy7xtlmAA818RPTpJGj4wIuF6MWdBtHYAFMyDXB7asSeXY32Ad0/1Pt6ue?=
 =?us-ascii?Q?LtBxnxA8q0TPMrTqRrpd+HI4CYU0JJSoBBJnSGUYxqmLHMWAT4gE1Xw87axh?=
 =?us-ascii?Q?F2dlNTBvbc6qWKwVdoCsBi8KUvq80EbXT8Sqw7QhaeSgu4GyW2246zk5hZ2t?=
 =?us-ascii?Q?IyvokgrJWDJYX1JBL/hMe6TSLBO326W7RDiDKOmGEzG9huLXtxw2zpN+40ib?=
 =?us-ascii?Q?e+2nES5PzvkSeYYHynDD4E37BP5Nu+F/pUiDVohfWC0W2UcBLnRcjS6Wi+U3?=
 =?us-ascii?Q?4XJBxYDHG/JVhuVno4o0OnhPBigTn4yMjQ0xnywqRmlm0Pw5SUauhoOUo1aY?=
 =?us-ascii?Q?7GRiniq2xI2muwuXpVvek/y/EY7eYsvlqPdtT9VRZWZt0rJOYlyMIx4io4lr?=
 =?us-ascii?Q?tw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN0P287MB2531E4AB73A84D84E5F3A2DFC5FAAPN0P287MB2531INDP_"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b174339a-98f8-4ca0-b66d-08de16e402a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 12:09:28.5887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YEsEt0qNGboI3G8TmJjiG+RTi0PnluHPBBXLwsdc67ptLH6fA/kL+FZBTM1aKSEsUXEwxhZbkIRuarvZYEIEdQyWCBsN8OAd60sBcMX1ciTri1/LjhPsLwfCEM37ppD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN4P287MB4843
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

--_000_PN0P287MB2531E4AB73A84D84E5F3A2DFC5FAAPN0P287MB2531INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Team,

       Thankyou for providing this input.

In addition we have a few queries while running DPDK in Windows.
(A) On what scenario or an example,  can Virt2PHY driver be used?
(B) After we bind the interface using netuio.inf file, the example applicat=
ion testpmd.exe shows "No probed ethernet device". But in Device manager th=
e interface shows available and bind with QDMA. Here we are using QDMA-PMD(=
https://github.com/Xilinx/dma_ip_drivers/tree/master/QDMA/DPDK) driver. Thi=
s driver works with Linux environment.(Please let me know if we need to cre=
ate new mail for this).

Thanks and regards,
Ayshathul Thuhara
________________________________
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Sent: 29 October 2025 11:56
To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Cc: Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>; dev <dev@dpdk.org>=
; Andre Muezerie <andremue@linux.microsoft.com>
Subject: Re: Virtio-PMD in Windows

Hi Ayshathul,

Adding Andre as currently the most involved Windows DPDK maintainer.

Virtio PMD could work in QEMU-KVM on Linux host with Windows guest as PoC.
However, the patches were never completed and merged
because of a few toolchain-related issues that no one had time to resolve.
In DPDK, the latest patch is this
(check also the link in that message and the discussion):

https://inbox.dpdk.org/dev/20210815145614.3826-1-u9012063@gmail.com/

In DPDK kmods repository, you'd need to add PCI IDs to the INF file.


--_000_PN0P287MB2531E4AB73A84D84E5F3A2DFC5FAAPN0P287MB2531INDP_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Team,<br>
&nbsp; &nbsp; &nbsp;<br>
&nbsp; &nbsp; &nbsp; &nbsp;Thankyou for providing this input.<br>
<br>
In addition we have a few queries while running DPDK in Windows.&nbsp;<br>
(A) On what scenario or an example,&nbsp; can Virt2PHY driver be used?</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
(B) After we bind the interface using netuio.inf file, the example applicat=
ion testpmd.exe shows &quot;No probed ethernet device&quot;. But in Device =
manager the interface shows available and bind with QDMA. Here we are using=
 QDMA-PMD(<a href=3D"https://github.com/Xilinx/dma_ip_drivers/tree/master/Q=
DMA/DPDK">https://github.com/Xilinx/dma_ip_drivers/tree/master/QDMA/DPDK</a=
>)
 driver. This driver works with Linux environment.(Please let me know if we=
 need to create new mail for this).</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
Thanks and regards,<br>
Ayshathul Thuhara</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dmitry Kozlyuk &lt;dm=
itry.kozliuk@gmail.com&gt;<br>
<b>Sent:</b> 29 October 2025 11:56<br>
<b>To:</b> Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&gt;<br>
<b>Cc:</b> Chaturbhuja Nath Prabhu &lt;c.prabhu@iwave-global.com&gt;; dev &=
lt;dev@dpdk.org&gt;; Andre Muezerie &lt;andremue@linux.microsoft.com&gt;<br=
>
<b>Subject:</b> Re: Virtio-PMD in Windows</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Ayshathul,<br>
<br>
Adding Andre as currently the most involved Windows DPDK maintainer.<br>
<br>
Virtio PMD could work in QEMU-KVM on Linux host with Windows guest as PoC.<=
br>
However, the patches were never completed and merged<br>
because of a few toolchain-related issues that no one had time to resolve.<=
br>
In DPDK, the latest patch is this<br>
(check also the link in that message and the discussion):<br>
<br>
<a href=3D"https://inbox.dpdk.org/dev/20210815145614.3826-1-u9012063@gmail.=
com/">https://inbox.dpdk.org/dev/20210815145614.3826-1-u9012063@gmail.com/<=
/a><br>
<br>
In DPDK kmods repository, you'd need to add PCI IDs to the INF file.<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PN0P287MB2531E4AB73A84D84E5F3A2DFC5FAAPN0P287MB2531INDP_--
