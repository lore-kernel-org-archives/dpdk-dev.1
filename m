Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFA8CD6E44
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 11:00:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63BDF402EE;
	Thu, 28 May 2026 13:00:13 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 88FC04021F
 for <dev@dpdk.org>; Thu, 28 May 2026 13:00:11 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 13A58140018C;
 Thu, 28 May 2026 07:00:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Thu, 28 May 2026 07:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779966011;
 x=1780052411; bh=WJFaqviAVDnncVu6NdCikJbwURB3zP2pY9Crv4QnlWY=; b=
 KFrzH8y1sKaNHA4qdH7GPAGpCsubJkRmXYc+oqaYapbj6pL4FDzOGRICnM3XOhnb
 VVXrS0q4KWU8J2jU58d1aQgmb3y5dyEuCuZUEpaIbCUJ2K05GUV3hmDtzjXLkHwP
 joaXuMvYAVIrgm2imiAIYEM403KWweUIkopZKsqsINjJW5OjOY/qo/MkM5uGVwmy
 UYD7bUrktXxKMghloXWujpVboyFACEaybpLHP6RCrbUtSC7kKZzRccjUefgzIY/U
 Vj2XVxcw7zjE7Tos/XSh51mqMvQLt40NGFcF3mQW9i2ATOIPfMDbqBwpOslclFaN
 xM1ZcEN2R9LY3rB/7p7yzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779966011; x=
 1780052411; bh=WJFaqviAVDnncVu6NdCikJbwURB3zP2pY9Crv4QnlWY=; b=H
 kW6dBsbjT93loxqufdACMglIA2J3FiZpyJDWUICpIQsaC9CaLJJ/CiVmmYLMiiRo
 3YcKbdhx/Lbama1jt78IWWfdBxohNco8RWJZF85yoWsdgpHJQvuB68RZod62RnqP
 D2vtefeZZWVJK6jvFv6NZVwWMib496LsSkTRojGQehVINQo+05CmZmil5fGUJuDM
 E10pkb7D3Ebi+frQqQsRbKB+RbQwPJDcrSEZ/VP62EEjse81Zk4ya8tDwZnObeoQ
 Z2HrToraT6EGByG5+CZ2Fcs8OJB14fh/PbdLH/iIsAHEQyx9ad0Ku4M/cUIv1mvW
 lg7zD9PZvqTz8Ndn6DJGg==
X-ME-Sender: <xms:OiAYaqsPYZwrHOmQEqz0AlOROIcR5710ZJ5lxE9RKLoElNJq98sgNA>
 <xme:OiAYajw5oyKVKnW591BMr8wlD7rLbFHGOyKkxpDRiXapzLqdfYmRHd69zHliPhuro
 oU4NkuHlWo9VbgXXQ9kSpC36uLNubDU1ui4qRYS3r7mvNvPCY63fkM>
X-ME-Received: <xmr:OiAYak75zwux0yVp0unwp_1nMdP6IDmZwt14_hr3XuUd5sFBr8Cyp1LCSAArYNccDs-Zbdt_oTMNLCEsTkHT7xVMLw>
X-ME-Proxy-Cause: dmFkZTGqOHX7RlStASAHwom6qqaDoR0q1lvavmKw8jd1J+m/s9JSo2NzfL18Frc4UB5jaL
 uXUj8nDnlH1pbnQJFtxL2mhu+Xa2scgdcpOcZcK6dv6PmTRoN4PkZkKpCJMDW5keBi49Kn
 CLFRZ19xhCIo8xR+ShtocEVKxbkyF2v+FgFT4AYmnH/IxbjkKUQ1tK85AMt7bTqGq190k1
 zgS3f3EkZBVc8lLZkEuDMcImnnmQY9XkURjw3KZ8Ea4eQDZTRtjSAjrbHs5XULXh48JQZu
 YWvlM2PQWYdAt0wb16A5+93bhNvHeXW1Tam5tNXUpYob2ekSGnHx0NfSIzn+V3tcIoV+kI
 LixGZz00AnP+w5orPsWxTkISbFQSn99/Zg7yoZ6NwPHTOm8u68/+G+1gLEsRxb2Uuz5oOA
 AXxh9Th9pdKZCll74bHjSePdxjniWYPUAhEH7yYlLcH2lk+t9J+nst3Pc3d0XIG139g6jG
 ObNokY8XQpx9aYBMd6EBc65M20KuUFy7kxWKS1TcjCtW5ANYKJ9ydJQZftQXS1oSBfR5gR
 11rdzWsnD+ixtFCQvuWXBLtAhsay0kIWCe8bcQCre560Q09D54q/n+ckk8p9/SNviGWn2U
 acCL/xxVdeTLQOJ80uwOjytimJHJSDOezYUuVKf+qL0voiQ8ncuba0Du7pNA
X-ME-Proxy: <xmx:OiAYatUxQwsSIzA-DfQ9OWVjihzqShII-JVYHANF_-vWlsO39m1l6Q>
 <xmx:OiAYag2eOwVpOpsB705y1OazHV09evgwq9ZmDm9VHaup1gR_Ns5glw>
 <xmx:OiAYai19KK2SK0c_ot1rTkvPj0mAqYEGbAafNlqQC9O5IfTL3vcxdw>
 <xmx:OiAYar81kfCk3D-QJ4ATdWhAYo0AEBd_Udn01lAAlHZJEpHbFUtzUg>
 <xmx:OyAYavaRuGoYsT3E42z3kJf4ll5N9j8MISdq4S5wxZADADi-wT9wmaNN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 07:00:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Jie Liu <liujie5@linkdatatechnology.com>
Subject: Re: [PATCH] net/sxe2: fix 32-bit SSE build
Date: Thu, 28 May 2026 13:00:06 +0200
Message-ID: <nJulkBcHR2iTEoS8DREvpQ@monjalon.net>
In-Reply-To: <-b1vJiPdTrqtGy9X39oH8Q@monjalon.net>
References: <20260528084717.1754057-1-thomas@monjalon.net>
 <CAJFAV8xY0uM=RbcR64ZMc-eOTVkzZc0PFTCBCaQkNNE7uuvZeg@mail.gmail.com>
 <-b1vJiPdTrqtGy9X39oH8Q@monjalon.net>
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

28/05/2026 12:58, Thomas Monjalon:
> 28/05/2026 11:47, David Marchand:
> > On Thu, 28 May 2026 at 10:47, Thomas Monjalon <thomas@monjalon.net> wro=
te:
> > >
> > > Seen in OBS on i586 Debian:
> > >
> > > from ../drivers/net/sxe2/sxe2_txrx_vec_sse.c:5:
> > >         In function =E2=80=98_mm_loadu_si128=E2=80=99,
> > >                 inlined from =E2=80=98rte_memcpy=E2=80=99
> > >                 inlined from =E2=80=98sxe2_rx_pkts_refactor=E2=80=99
> > >                         at ../drivers/net/sxe2/sxe2_txrx_vec_common.h=
:233:2:
> > >         /usr/lib/gcc/i686-linux-gnu/12/include/emmintrin.h:703:10: er=
ror:
> > >         array subscript 8 is outside array bounds of =E2=80=98struct =
rte_mbuf *[32]=E2=80=99
> > >
> > > The important options to reproduce are "-m32 -O2 -march=3Dcorei7".
> > >
> > > In 32-bit build the pointer array done_pkts[32] is smaller:
> > >         32 * 4 =3D 128 bytes
> > > so an SSE access  would be outside the bound.
> > >
> > > The libc memcpy does not trigger such warning
> > > and is a good choice to copy an array of pointers.
> > >
> > > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> >=20
> > I reproduced and checked Debian 13 32 bits build with OBS.
> > Tested-by: David Marchand <david.marchand@redhat.com>
>=20
> Thanks for testing.
>=20
> I forgot this:
>=20
> Fixes: 885647d31504 ("net/sxe2: fix 32-bit SSE build")

Of course I meant

=46ixes: ac60f302cbef ("net/sxe2: add vectorized Rx and Tx")


