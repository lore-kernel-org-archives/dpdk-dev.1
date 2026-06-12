Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8E1CD98CE
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:49:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63BD043353;
	Fri, 12 Jun 2026 16:49:19 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id D569F40279
 for <dev@dpdk.org>; Fri, 12 Jun 2026 16:49:18 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 510D4140005D;
 Fri, 12 Jun 2026 10:49:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Fri, 12 Jun 2026 10:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781275758;
 x=1781362158; bh=mpKf7xBClj1zsfZKHwl7e0YJYaKYL7fduejsSfRO+Qs=; b=
 AsHGb/xlxN6aMmGiTs2D+12x7JY4EJ0tBp0VNCVMwsZXVwfcenAkSxUomM+IViSU
 AkqEwlEtWh52B45Lm0D1KVcxWJ185ECDC+DkoWUtFmMaz5WgTxyDYz1W8GIkLzxR
 AmFD5pakUo/haYN9moICEQZ7/esdU/iVNHhsjFB1ZdWeJccaYF7ZXnf+iBy2ihkg
 Sn2DDWjyylwXEq/+xxDJIRKlkm+IcbNXTMEk/RYyIc4Xh3TNwnUB80ImnBYwqHKs
 DJ7HchCfdsAo21hmauEkIQjVGjpXwd6GUbb81evgqu/mjZNZTQEush4beRc11Joz
 5ZxbrLMs8bNynCgUTUzCIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781275758; x=
 1781362158; bh=mpKf7xBClj1zsfZKHwl7e0YJYaKYL7fduejsSfRO+Qs=; b=A
 AG71sZoGoGI27QGQ0XDB0Rsjroxw0Zszy7oPuCER8G45s7cRp9d5HzloT+i5+he2
 XC7XoCGz4wUo0ISWStoNHLL9RsozVe0Dp5rtPAL9+KCR6dA6VS+JNLAFGqSS9VZY
 zx9ek9gTn11yYjWu9GuKDRFOIYmJ/NzN7f3SjF/6djEtYgUL7E/8cGzayg4pJpfv
 QcDjjryEoL8rZVcrRdKEhK/LWbMJ5ZD6Y2EIB9bmFd+Mbkfr6mrZhjqOuPfLcYYU
 pq/zrYu3NhB+k52ffoUz1RsqXf4sDWSqABvCPa3URDcidhTxgq4XSnuXUwG5BKCq
 MGL2hYA0LYNT0yiVX6ZPg==
X-ME-Sender: <xms:bRwsahrOmdCbjdbO64P2nzVGpEPNoBgke_ORjdWnM_X8Wdncnu7q3g>
 <xme:bRwsajyeMZc6fk088ZfB1b3x2tjDrQfbW4P_J-G0PobBFnqbF3sgkjgH9OrP8v_Xi
 6kdws6uU-9CGcXHpFcHUBjHoiA_a9mLYaDRUyfm0u0MRs76X_aueA>
X-ME-Received: <xmr:bRwsamJRbUmwP_nInGvJkMhWmTzDzm2oKRWwnA6uO8b4ePsbNIlO_VUs8TqiimMK-bUrSYdyfue49NSHEcj1C9Q7TA>
X-ME-Proxy-Cause: dmFkZTEGUgRHpcBJytOE5+FSJa1sEHSRDeBMX0qR8jeecFT9CfW+4pLVkIqv3ETUa+IKeF
 JtCbaAfRRzlewFyDg56i10GPVL3MPriv3D2xGU4rQcRQEK4F8XFidvU9/TYcnZK/aESXB5
 NUd1cXYEyr69n7G9CAPoFFiiZoBW/IVV8lEbQEgEKOQFrL1i3d22VRWIQBwNx3i3It8nbp
 KU/UVtIOAzF65z9UVsj0DOkwUAwchIrUjaWQs/Vxry1Ms8eqb4DqPcyrJfKyo1CtiNbyPK
 njd4vq74pwSIUCRbLR+SdbOmCtatQXTsnAVWQFDSGE+rKek3hQaKctCdg3bypp0niivVVN
 YpXIETw/CA/VlDR7KAcrJNYrZtxnTBm0gj2OOmLt4zW5SKA1fWhY+Im4sxjpI08ZrOmElt
 KpfbodFH13+DW8lD2JNa7wC3P37PCtEjIAshn9USTPpUijTgxa/oIb6ZM35zy2XR8Alvp1
 xM3vzJewdXnaDrrchlWR1TqWtdm53jBhB2Ldkh8AwjU1NOyTSCOp6BlQnZaIB2gKfLKQj0
 S5ddaTyYTqyeLkX+1tqK8bk9yGSVCSNSsjt11qLfZ0QT2pFyMl7mY3N33zsfoE/FrHqu1B
 F1eoSX3eCXU0ywSuk717KEJXE0IORCJHqltpynCuwyog0/8fYysyl/EZBcVw
X-ME-Proxy: <xmx:bRwsalJzMOB3e2945XPvxy3XQIQ8qhxtR8c-JFivuXCQ1mN2bJdApQ>
 <xmx:bRwsarvTvtVIoSLOVqNqBsTX_LCMCGVa5_agZ8NHb-BWQrm-uW1E0w>
 <xmx:bRwsaqQ2_qf1EwuzvTvhc8nTD1t8aF-JpfI225Ql785BFPVaTiEP0g>
 <xmx:bRwsapPRxTAFjhHzGnxOPSRThfYpfAwOaDDiod1pMQfX7bcdYwd2hg>
 <xmx:bhwsamTlkANY2N3BTKti8Q-IbnvRkLgSZqElf-GibfNCXft1CfQDr9mI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 10:49:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: =?UTF-8?B?6K64546y54eV?= <lingyan.xu@metax-tech.com>
Cc: dev <dev@dpdk.org>, eagostini <eagostini@nvidia.com>,
 =?UTF-8?B?546L5Yas5Yas?= <dongdong.wang@metax-tech.com>
Subject: Re: =?UTF-8?B?5Zue5aSN77yaW1BBVENIXQ==?= gpu/metax: add new driver
 for Metax GPU
Date: Fri, 12 Jun 2026 16:49:14 +0200
Message-ID: <VJ0LOsEwRLSFadcujOiwrA@monjalon.net>
In-Reply-To: <2a306d48-351c-473e-b049-43e10e53617b.lingyan.xu@metax-tech.com>
References: <6c18e957-c1c2-4b43-9b2c-b36424c1e9af.lingyan.xu@metax-tech.com>
 <CNjXKdTGQx6A6BPVH44M4w@monjalon.net>
 <2a306d48-351c-473e-b049-43e10e53617b.lingyan.xu@metax-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Would it be possible to have a direct download link
not requiring any registration? At least for the library?
Do you have an english version of the website?


12/06/2026 09:19, =E8=AE=B8=E7=8E=B2=E7=87=95:
> Hi,
> Thank you for the follow-up. Please find the clarifications below regardi=
ng the kernel dependency and availability:
> 1. Kernel Dependency
> While it is not upstreamed into the mainline Linux kernel, it is actively=
 maintained by Metax to interface with our hardware.
> 2. Availability and Download Link
> Yes, both the proprietary user-space libraries and the corresponding kern=
el modules are freely available for download. You can access them via the M=
etax Software Download Center:
> Download Link: https://sw-download.metax-tech.com/ <https://sw-download.m=
etax-tech.com/ >
> How to obtain the files:
>=20
>  *=20
> Register and log in to the portal.
>=20
>  *=20
> Navigate to "SDK Development Kit".
>=20
>  *=20
> Select your specific GPU Type.
>=20
>  *=20
> Choose your target OS. We currently support Linux (aarch64 & x86_64) acro=
ss mainstream distributions, including but not limited to:
>  *=20
> Ubuntu (18.04 - 24.04)
>=20
>  *=20
> RHEL / CentOS / RockyOS (8.x / 9.x)
>=20
>  *=20
> Domestic distros: KylinV10/V11, OpenCloudOS, TencentOS, etc.
> Best regards,
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AThomas Monjalon <thomas@monjalon.net>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2026=E5=B9=B46=E6=9C=8811=E6=
=97=A5(=E5=91=A8=E5=9B=9B) 17:17
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A"=E8=AE=B8=E7=8E=B2=E7=87=95"<lingyan=
=2Exu@metax-tech.com>
> =E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Adev<dev@dpdk.org>; eagostini<eagostin=
i@nvidia.com>; "=E7=8E=8B=E5=86=AC=E5=86=AC"<dongdong.wang@metax-tech.com>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [PATCH] gpu/metax: add new driver=
 for Metax GPU
> 11/06/2026 09:10:
> > Both libmcruntime.so and the corresponding gdrapi libraries
> > are proprietary user-space libraries provided by Metax.
> > They are not upstreamed to the DPDK mainline repository.
> > However, please rest assured that the current patch interacts
> > with them via standard dlopen (dynamic loading) at runtime.
> > We do not link directly against their source code
> > or require them as hard build-time dependencies.
> > Therefore, this approach will not introduce any additional
> > compilation dependencies or licensing issues to the DPDK main tree.
> What about the kernel dependency?
> Are libraries and kernel module freely available for download?
> Can you provide a link?
>=20





