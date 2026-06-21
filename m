Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2444CD98F0
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 11:04:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2B234028F;
	Sun, 21 Jun 2026 13:04:43 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 5C7974028A
 for <dev@dpdk.org>; Sun, 21 Jun 2026 13:04:42 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C8F59140010E;
 Sun, 21 Jun 2026 07:04:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 21 Jun 2026 07:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1782039881;
 x=1782126281; bh=Ud9VLmTfkIWv7XVS13Jznt2op7cPB8cAcPUKxUqJyII=; b=
 IWQHvs7TtaG7UBVzqKagnS0iGFmNpXhwDdq1IZu1w3LsGuRIQnVTIoZM85ByysQI
 BRJnX0FsViVSjYU2QiRfajmZvsJgadXGewZ4M4iyj4fNJFYtwhTwgm+X8H6ND8wF
 Ky9tniC6vlYIuSOyf9H2UhHCH587/fZnLUrL+u0sHv4W5nN0TLsGkcfD601S3+CM
 XWKlMVHbZSD2Tzl9i2UJGuDEAjSszkwzL5MAIDGH09cKQaB4ao5Ivt5IQt+6Nlcs
 q4LqNiGty1n3P219nzWC2yEVu6LIClM0nCXmIV+wNsiCCX5SwYSnV95kVVrKmY8J
 E6iNIaKc4F+RUse2XtkCPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782039881; x=
 1782126281; bh=Ud9VLmTfkIWv7XVS13Jznt2op7cPB8cAcPUKxUqJyII=; b=i
 Qx+4zwMi8p5D6Ld8UQoYBYgvIbzF2HFAHTxVK9gmUkkNXZ0RChhbwiugiaiDrFvC
 HBZnGz0SU8xIOWkFVMQkHwy+Tj/qxY/cdBVNBiJlJ8UQc04cptI4D2K5BHAiIqfC
 ScT4oeHRuLbNx9Kc6l7C7j4zbjAcHSeKT2cXzmulGXnNXYSV0EHoqf20rJE9XBhi
 SsDWqSEBsNLH5vjAJVzNbiR2PvNJ4kIzgv3JfMrxxlsqUabcvmEu61laa9oDD1Rc
 IucihCN+/EH8ZlQ7jXYxqITU7+5Jz4tyn4Ln/rxX35b8Hl1fTnuxGGAuly09tHXm
 +UIl+Jlz+BOlc2h+aybpg==
X-ME-Sender: <xms:SMU3amyonhd8D94cBlDPtBfuoxK3jSWrr7WRpXC38JxemjqTswWxFQ>
 <xme:SMU3arMXa4kfzfqK2FoDDnGzak9QT4iuvuWnk7uDtCANc40Lg_VUySU5XVQn0E4KD
 qYlTIScicJbyAOJUR-dnEiKcFJaz1DwpT_xIcPuaG5qXsedBe2ZcJc>
X-ME-Received: <xmr:SMU3aj4xISO6vr6P6xaArMMOinWoRGgnYqO-JCHNJpVu-B9zXVcqcZtj-81LYNI5Kbd6WmkngqiS1DzkG3fni60Z-A>
X-ME-Proxy-Cause: dmFkZTF9Fn0QpO4ki7bYanOVdez5KQ1fOTzx+5NPwWzg2W7sEy2amuGe2yCH9KIiHkqNVc
 oG8wdgt3E53LaYI55IgezSTYrPRNMmq7CzALuT/TeQ+kwLcGm384cfXmONoT0sKUv7zaGF
 etgmeCPaOgmkLiApzBgUmmH0CkIer6Rxx1w00txFXkHbW0PeaB2Ykj648ZXU4dz2QqXxUb
 T8edlvUHwZLg0QxzceAlQFw5jcus/MG7EW5ArYNk/xUjxYh9mFqRRWREepJB1/PVFO3Ebj
 iPbek78kvtkXP5lke/D+pmT1YO3P8BoBKvDGP5OOrA8wxoYuklAJLHVUyUDjGgB5jSKqW3
 SAayqJ9HNp/V/2Ad/BK2K64A2YgOxibFTe62pKs9KINZ95fd33bhkl+I4HRR2yDbBWJJvC
 LeLxx+Mm9Lfq9/wQLx1amrD+JNqMoqEB8YmZCSrhcK/lv08E/Za1iVHjZygUxFppq/Cu2t
 NBT+sNJnev3Q3CuqXlHiimsG/nR0aYmpxOfxPKPKIcyfOeZhs9ca3M6DL3qeTcW6CjX9jJ
 iiS+9461QsXZKpeVC+DlCA3+bJv7rX5p32bg9UTL2nvUwmKAZ+6V3b+1elU+yKY8AoNGe0
 DVWC+7CNEUhJ44RzPQqtZdVFXUaGWtQ1RJDM/pxChr7dBkNyOJBVj9QNdVvg
X-ME-Proxy: <xmx:SMU3asns-Oe45vJgGoDsigIiKHTeWHOr4uz4w5z-pldlSLKR1GmOTg>
 <xmx:SMU3akTCyEn_02fTnKaeave4U2RHqa7KYTUmdMXRzB_YGg00RYLhyA>
 <xmx:SMU3arE-obvj4KAd3G2e-CrpPrl5qPK_2SSVMMbXaAU2-t37u1IC5w>
 <xmx:SMU3apGGnHGIhGI9yMCtCHKv5vIx2iFpKdA83U9hPPZp04sdqMFEkg>
 <xmx:ScU3ajpVm4RZ44npvCRpIh52k7ix2DA5bfYwtZeGgl3GiKJ_ZJyRTjCy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jun 2026 07:04:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Huisong Li <lihuisong@huawei.com>, andrew.rybchenko@oktetlabs.ru,
 dev@dpdk.org, zhanjie9@hisilicon.com
Subject: Re: [PATCH v1 0/5] prefix lcore role enum values
Date: Sun, 21 Jun 2026 13:04:37 +0200
Message-ID: <e6ViscOLTtCt9nQzc_qZSg@monjalon.net>
In-Reply-To: <20260620094220.10047bf2@phoenix.local>
References: <20260617102834.2343356-1-lihuisong@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6592C@smartserver.smartshare.dk>
 <20260620094220.10047bf2@phoenix.local>
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

20/06/2026 18:42, Stephen Hemminger:
> On Fri, 19 Jun 2026 22:11:02 +0200
> Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
>=20
> > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > Sent: Friday, 19 June 2026 17.40
> > >=20
> > > On Fri, 19 Jun 2026 09:54:51 +0200
> > > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> > >  =20
> > > > > > The problem with this patch it causes build failures now with a=
bi =20
> > > > > diff.
> > > > >
> > > > > It is probably a bug of an old version of abidiff.
> > > > > I recommend updating. =20
> > > >
> > > > With the #define's the ABI has not changed. It's probably too =20
> > > indirect for abidiff to understand. =20
> > > > If we absolutely want to please abidiff, we could keep the existing=
 =20
> > > enums and #define RTE_LCORE_ROLE_RTE ROLE_RTE for now. =20
> > > > But I'm in favor of what was done already. =20
> > >=20
> > > The build failures on github, not in my local builds.
> > > https://github.com/ovsrobot/dpdk/actions/runs/27789889172/job/8223596=
50
> > > 90
> > >=20
> > > It makes looking at patchwork dashboard difficult, all patches show up
> > > with red mark =20
> >=20
> > So maybe we can choose the path of pleasing abidiff...
> > Keep the existing enums, and #define the new RTE_LCORE_ prefixed varian=
ts, and use those in the code.
> >=20
> > Later, with an ABI breaking release, we can swap.
> > Or maybe we just wait until an ABI breaking release to fix this.
> >=20
>=20
> Since change is cosmetic, not functional. I think it should be reverted f=
or 26.07
> to get github CI to pass on all platforms.
>=20
> It can be added back in 26.11

Yes I did the revert.
Sorry for the inconvenience.


