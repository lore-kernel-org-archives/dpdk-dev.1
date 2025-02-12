Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621D2C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 15:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 750D842707;
	Wed, 12 Feb 2025 16:47:38 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 26A3F4114B
 for <dev@dpdk.org>; Wed, 12 Feb 2025 16:47:36 +0100 (CET)
X-QQ-mid: bizesmtp78t1739375248thckz56u
X-QQ-Originating-IP: 0zG84maZWtvNZvx/Kfa9I87OE41dT5OJi6n6DfFdTqo=
Received: from LAPTOP96V0OHHN ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 12 Feb 2025 23:47:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5425765666255977971
From: "11" <caowenbo@mucse.com>
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <yaojun@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>	<1739263818-59770-13-git-send-email-caowenbo@mucse.com>	<20250211073503.78f084ff@hermes.local>	<89E4C0CDD2F99463+001a01db7cfd$4210f7e0$c632e7a0$@mucse.com>
 <20250212073743.7fdd6d53@hermes.local>
In-Reply-To: <20250212073743.7fdd6d53@hermes.local>
Subject: RE: [PATCH v9 12/28] net/rnp: add support link update operations
Date: Wed, 12 Feb 2025 23:47:27 +0800
Message-ID: <F24F757C0B9C654B+001f01db7d65$6bf5c780$43e15680$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLqICmjQftEF0oQ/zI69QXbQqbszQIbDFRwAY6R32gByd7b1wC38gWMsPUtQfA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MBifQ06ZiQEtSDGNt9gBdTMfylNozltGNe/WjblQX1Tii5C5lUUDnqx+
 PrAVwNlW7DWE4FNB+ov9gt8KcWhUhWY5HScXuaQ2b9VgdcPnPBNlGvq3RKDZgCbJ+igr99y
 RZJEyT/fqvZQkG7DMWwRKnlaDr1yoYnU8AaOj3fyhn5bVnfp4UDLTsJL3n2wB/9xDurnBQu
 UwYNQQcfKSkEXgUdkqGPpPSwtHEy+SjfZoDSsrk1FyL/k9ryR+bEJc+Xj0GNcyNucSst2eb
 JzZBjgIx+ow77ReV1wdEus1z+sY21L0O5uIhp1NPji5/YTRx7D2VrLm2K6qu26Aql+HcBj+
 rpobEEuqqJ1iY3wOH+3BMuHpWcHIKCRg4Qa7w24ID1JmkbdBQ/+Dnb2ISVynlPpvGNYbs5P
 pANkpxJy7Cmqb78ejkBQVSk+Y6yQ5GOtWKcLd3l1ApVtCbrhmhFTCs/i0zN6hEmD3WM0o+u
 wtlDDjOGzWm3IASruDQLQgA7Pw+32Sjdh9wJJ4pUYgWT5VDhhS9UL3wfAjmkIoqKe0K0+31
 LQ2aynHTkmOFgpA5elEgU5GPAJOqT/FxcTnNfDH5sBSGj55EaOl9VUsrxKK8OlMNlvotZVB
 9TRF1TPnDHbfz0e8Q+8ehY0Ul+2fJSEDl2MKVQacWTMW8t5d2kDe9xZycKw8KMzE7s5X4lk
 BQuJSrflm4LGs477IOR1J9BH0Gcupdq9nMSqp2jJ/8Ftyf//4vYHKSK7QKReqM2i2ieQRU6
 tNAMvZtD1HHBA+valJn9s6Zg005ncgp7smqNs5ILm6f3PzAQT2UHH24JxYuqPaD8VFZS/EA
 lqXNz/5ZM8FVly65Vb0TJ+xQk8eABQ8w8zeikuPFoFBUS0T1by6VGOOVL3YNn7g0+ttoAkf
 HJjVgNn2Q9l+H5wbPSJEtOrdQatksbyUyMsWVds76BlACTLRUCt2vYKp2UmFHkpdsVLpfES
 cB4XvUL+9TBNgxIvBXd8+xJBT
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
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

Hi Stephen,

Thanks for your explain abort the memcpy,  on Fedora41  I had I =
understood
why
rte_memcpy will cause compile fault. I will be carefull to use memcpy,
when a address of src or dst is not alignment.

Regards Wenbo

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 2025=C4=EA2=D4=C212=C8=D5 23:38
> To: 11 <caowenbo@mucse.com>
> Cc: thomas@monjalon.net; dev@dpdk.org; ferruh.yigit@amd.com;
> andrew.rybchenko@oktetlabs.ru; yaojun@mucse.com
> Subject: Re: [PATCH v9 12/28] net/rnp: add support link update =
operations
>=20
> On Wed, 12 Feb 2025 11:21:49 +0800
> "11" <caowenbo@mucse.com> wrote:
>=20
> > Hi Stephen,
> > For memcpy what ever base code or other code all used memcpy not
> > rte_memcpy ?
> > Even the memory is malloc from rte_malloc/zmalloc ?
> >
> > Regards Wenbo.
>=20
>=20
> The documentation doesn't make it clear but rte_memcpy is the same as
> memcpy.
> It only exists because for some cases (like older versions of Gcc and
differences in
> alignment assumptions) when running micro benchmarks rte_memcpy was
> faster.
>=20
> All new code should only use memcpy() unless there is a benchmark test
that
> shows a noticable difference. The reason is that tools like Coverity, =
Gcc,
Clang,
> and PVS studio all treat memcpy specially and can do checks for access
outside of
> range.


