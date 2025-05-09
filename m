Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90008C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 02:47:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EFA84026C;
	Fri,  9 May 2025 04:47:32 +0200 (CEST)
Received: from lf-1-128.ptr.blmpb.com (lf-1-128.ptr.blmpb.com
 [103.149.242.128])
 by mails.dpdk.org (Postfix) with ESMTP id 29B0B4026C
 for <dev@dpdk.org>; Fri,  9 May 2025 04:47:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1746758842; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Z3akpusGKcNGfQLkJIzPxvf9lW7d5ja1QNHQ3aQDVKA=;
 b=V0F6IIlSgxip+IDHovKySfWB4Hx5gOatcH11IBmdGcrjy+mspJiDEA5Ga/PMDqylGImb2i
 R4gRqj5Z86Ex27iqc1Ld4bGUvrOgwGbZS2E7eJDRFg1clXRWIZK45OFLTbnu1gA1mHqOfY
 7dQfJN8F+yGaEDJqgWvuuZNR+gdJzT++8lY8N6mN33HsxGRJbHpDHheLty23yX6bEOz0cb
 C2RazzqXPtN5mBc11/A8l1srnJNHxplX6rMFZRxCWrUdkP8r0U9Zl+bZQkoI33F04cbj0w
 JJZF7dVRlSaPkktK9KgzT1C4n4TjX9Lrxm2WTdN/Zy43cLJ4Pj4/kXvCrph8gw==
Date: Fri, 09 May 2025 10:47:19 +0800
Message-Id: <c1596ea907d851ffbd1575ff29659e6991aff8dd.58f5f4d6.9bb4.4898.b252.62380bcbd42a@bytedance.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>
Mime-Version: 1.0
References: <20240411061740.16495-1-hepeng.0320@bytedance.com>
 <20241007105407.51e6d4c3@hermes.local>
X-Lms-Return-Path: <lba+1681d6cb8+da60f0+dpdk.org+hepeng.0320@bytedance.com>
Content-Type: multipart/alternative;
 boundary=2022e3103cf89737a4d071d3d25963c5d6012813d8cbb60b883bcd8f70d3
Cc: <dev@dpdk.org>
Subject: Re: [External] Re: [PATCH] mlx5: fix race at mlx5_dev_close
From: =?utf-8?q?=E8=B4=BA=E9=B9=8F?= <hepeng.0320@bytedance.com>
In-Reply-To: <20241007105407.51e6d4c3@hermes.local>
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

--2022e3103cf89737a4d071d3d25963c5d6012813d8cbb60b883bcd8f70d3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

It's 1ms, not 1 second.=C2=A0
It's a workaround, just to provide a fast and dirty fix for someone who nee=
ds this.


From: "Stephen Hemminger"<stephen@networkplumber.org>
> Date:=C2=A0 Tue, Oct 8, 2024, 01:54
> Subject:=C2=A0 [External] Re: [PATCH] mlx5: fix race at mlx5_dev_close
> To: "hepeng"<hepeng.0320@bytedance.com>
> Cc: <dev@dpdk.org>
> On Thu, 11 Apr 2024 14:17:40 +0800=C2=A0
> hepeng <hepeng.0320@bytedance.com> wrote:=C2=A0
>=20
>=20
> > From: "hepeng.0320" <hepeng.0320@bytedance.com>=C2=A0
> >=C2=A0
> > mlx5_dev_close currently will set priv->sh->port[priv->dev_port -=C2=A0
> > 1].nl_ih_port_id to RTE_MAX_ETHPORTS to avoid mlx5_dev_interrupt_nl_cb=
=C2=A0
> > to use the port's dev_private, because later the rte_eth_dev_close=C2=
=A0
> > will free the dev_private and set the pointer to NULL.=C2=A0
> >=C2=A0
> > However, since mlx5_dev_interrupt_nl_cb is running in another thread,=
=C2=A0
> > I think the race still exists. So perhaps an easy fix is to wait for=C2=
=A0
> > 1ms to avoid this race.=C2=A0
> >=C2=A0
> > Signed-off-by: hepeng.0320 <hepeng.0320@bytedance.com>=C2=A0
>=20
>=20
> Not the pest way to handle this. Adding a one second delay on shutdown=C2=
=A0
> hurts some availability scenarios. Looks like mlx5 needs a more coordinat=
ed=C2=A0
> shutdown to be safe; adding big delays is not the correct fix.
>=20
>=20
>=20
>=20
>=20
>=20
--2022e3103cf89737a4d071d3d25963c5d6012813d8cbb60b883bcd8f70d3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div id=3D"lark-mail-quote-fcb3b6654ee1dc14474e242=
3579e8480"><div id=3D"editor_version_7.41.0_79ImNuPy" style=3D"word-break:b=
reak-word;"><div data-zone-id=3D"0" data-line-index=3D"0" data-line=3D"true=
" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=
=3D"auto" style=3D"font-size: 14px;">It&#39;s 1ms, not 1 second.=C2=A0</div=
></div><div data-zone-id=3D"0" data-line-index=3D"1" data-line=3D"true" sty=
le=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"a=
uto" style=3D"font-size: 14px;">It&#39;s a workaround, just to provide a fa=
st and dirty fix for someone who needs this.</div></div><div data-zone-id=
=3D"0" data-line-index=3D"2" data-line=3D"true" style=3D"margin-top: 4px; m=
argin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size:=
 14px;"><br/></div></div><div data-zone-id=3D"0" data-line-index=3D"3" data=
-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1=
.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><br/></div></div><div dat=
a-zone-id=3D"0" data-line-index=3D"4" data-line=3D"true" style=3D"margin-to=
p: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"f=
ont-size: 14px;">From: &#34;Stephen Hemminger&#34;&lt;<a class=3D"quote-hea=
d-meta-mailto" target=3D"_blank" rel=3D"noopener noreferrer" href=3D"mailto=
:stephen@networkplumber.org" style=3D"cursor: pointer; text-decoration: non=
e; color: inherit;">stephen@networkplumber.org</a>&gt;</div></div></div><di=
v class=3D"history-quote-wrapper" id=3D"lark-mail-quote-174675883" style=3D=
"word-break: break-word;"><div class=3D"history-quote-meta-wrapper adit-htm=
l-block__attr history-quote-gap-tag" style=3D"padding: 12px; background: rg=
b(245, 246, 247); color: rgb(31, 35, 41); border-radius: 4px; margin-top: 2=
4px; margin-bottom: 12px;" id=3D"lark-mail-meta-MTGnq2nyh"><div data-zone-i=
d=3D"0" data-line-index=3D"5" data-line=3D"true" style=3D"margin: 0px;" cla=
ss=3D"history-quote-line quote-head-meta-line"><div class=3D"" dir=3D"auto"=
>Date:=C2=A0 Tue, Oct 8, 2024, 01:54</div></div><div data-zone-id=3D"0" dat=
a-line-index=3D"6" data-line=3D"true" style=3D"margin: 0px;" class=3D"histo=
ry-quote-line quote-head-meta-line"><div class=3D"" dir=3D"auto">Subject:=
=C2=A0 [External] Re: [PATCH] mlx5: fix race at mlx5_dev_close</div></div><=
div data-zone-id=3D"0" data-line-index=3D"7" data-line=3D"true" style=3D"ma=
rgin: 0px;" class=3D"history-quote-line quote-head-meta-line"><div class=3D=
"" dir=3D"auto">To: &#34;hepeng&#34;&lt;<a class=3D"quote-head-meta-mailto"=
 target=3D"_blank" rel=3D"noopener noreferrer" href=3D"mailto:hepeng.0320@b=
ytedance.com" style=3D"cursor: pointer; text-decoration: none; color: inher=
it;">hepeng.0320@bytedance.com</a>&gt;</div></div><div data-zone-id=3D"0" d=
ata-line-index=3D"8" data-line=3D"true" style=3D"margin: 0px;" class=3D"his=
tory-quote-line quote-head-meta-line"><div class=3D"" dir=3D"auto">Cc: &lt;=
<a class=3D"quote-head-meta-mailto" target=3D"_blank" rel=3D"noopener noref=
errer" href=3D"mailto:dev@dpdk.org" style=3D"cursor: pointer; text-decorati=
on: none; color: inherit;">dev@dpdk.org</a>&gt;</div></div></div><div data-=
zone-id=3D"0" data-line-index=3D"9" data-line=3D"true" style=3D"margin-top:=
 4px; margin-bottom: 4px; line-height: 1.6;" class=3D"history-quote-line"><=
div class=3D"" dir=3D"auto" style=3D"font-size: 14px;">On Thu, 11 Apr 2024 =
14:17:40 +0800=C2=A0</div></div><div data-zone-id=3D"0" data-line-index=3D"=
10" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-h=
eight: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" styl=
e=3D"font-size: 14px;"><span>hepeng &lt;<a href=3D"mailto:hepeng.0320@byted=
ance.com" target=3D"_blank" ref=3D"noopener noreferrer">hepeng.0320@bytedan=
ce.com</a>&gt; wrote:=C2=A0</span></div></div><div data-zone-id=3D"0" data-=
line-index=3D"11" data-line=3D"true" style=3D"margin-top: 4px; margin-botto=
m: 4px; line-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=
=3D"auto" style=3D"font-size: 14px;"><br/></div></div><div data-zone-id=3D"=
0" data-line-index=3D"12" data-line=3D"true" style=3D"margin-top: 4px; marg=
in-bottom: 4px; line-height: 1.6;" class=3D"history-quote-line"><div class=
=3D"" dir=3D"auto" style=3D"font-size: 14px;"><span>&gt; From: &#34;hepeng.=
0320&#34; &lt;<a href=3D"mailto:hepeng.0320@bytedance.com" target=3D"_blank=
" ref=3D"noopener noreferrer">hepeng.0320@bytedance.com</a>&gt;=C2=A0</span=
></div></div><div data-zone-id=3D"0" data-line-index=3D"13" data-line=3D"tr=
ue" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;" class=
=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"font-size: 14=
px;">&gt;=C2=A0</div></div><div data-zone-id=3D"0" data-line-index=3D"14" d=
ata-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height=
: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"=
font-size: 14px;">&gt; mlx5_dev_close currently will set priv-&gt;sh-&gt;po=
rt[priv-&gt;dev_port -=C2=A0</div></div><div data-zone-id=3D"0" data-line-i=
ndex=3D"15" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px=
; line-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"au=
to" style=3D"font-size: 14px;">&gt; 1].nl_ih_port_id to RTE_MAX_ETHPORTS to=
 avoid mlx5_dev_interrupt_nl_cb=C2=A0</div></div><div data-zone-id=3D"0" da=
ta-line-index=3D"16" data-line=3D"true" style=3D"margin-top: 4px; margin-bo=
ttom: 4px; line-height: 1.6;" class=3D"history-quote-line"><div class=3D"" =
dir=3D"auto" style=3D"font-size: 14px;">&gt; to use the port&#39;s dev_priv=
ate, because later the rte_eth_dev_close=C2=A0</div></div><div data-zone-id=
=3D"0" data-line-index=3D"17" data-line=3D"true" style=3D"margin-top: 4px; =
margin-bottom: 4px; line-height: 1.6;" class=3D"history-quote-line"><div cl=
ass=3D"" dir=3D"auto" style=3D"font-size: 14px;">&gt; will free the dev_pri=
vate and set the pointer to NULL.=C2=A0</div></div><div data-zone-id=3D"0" =
data-line-index=3D"18" data-line=3D"true" style=3D"margin-top: 4px; margin-=
bottom: 4px; line-height: 1.6;" class=3D"history-quote-line"><div class=3D"=
" dir=3D"auto" style=3D"font-size: 14px;">&gt;=C2=A0</div></div><div data-z=
one-id=3D"0" data-line-index=3D"19" data-line=3D"true" style=3D"margin-top:=
 4px; margin-bottom: 4px; line-height: 1.6;" class=3D"history-quote-line"><=
div class=3D"" dir=3D"auto" style=3D"font-size: 14px;">&gt; However, since =
mlx5_dev_interrupt_nl_cb is running in another thread,=C2=A0</div></div><di=
v data-zone-id=3D"0" data-line-index=3D"20" data-line=3D"true" style=3D"mar=
gin-top: 4px; margin-bottom: 4px; line-height: 1.6;" class=3D"history-quote=
-line"><div class=3D"" dir=3D"auto" style=3D"font-size: 14px;">&gt; I think=
 the race still exists. So perhaps an easy fix is to wait for=C2=A0</div></=
div><div data-zone-id=3D"0" data-line-index=3D"21" data-line=3D"true" style=
=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;" class=3D"histor=
y-quote-line"><div class=3D"" dir=3D"auto" style=3D"font-size: 14px;">&gt; =
1ms to avoid this race.=C2=A0</div></div><div data-zone-id=3D"0" data-line-=
index=3D"22" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4p=
x; line-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"a=
uto" style=3D"font-size: 14px;">&gt;=C2=A0</div></div><div data-zone-id=3D"=
0" data-line-index=3D"23" data-line=3D"true" style=3D"margin-top: 4px; marg=
in-bottom: 4px; line-height: 1.6;" class=3D"history-quote-line"><div class=
=3D"" dir=3D"auto" style=3D"font-size: 14px;"><span>&gt; Signed-off-by: hep=
eng.0320 &lt;<a href=3D"mailto:hepeng.0320@bytedance.com" target=3D"_blank"=
 ref=3D"noopener noreferrer">hepeng.0320@bytedance.com</a>&gt;=C2=A0</span>=
</div></div><div data-zone-id=3D"0" data-line-index=3D"24" data-line=3D"tru=
e" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;" class=
=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"font-size: 14=
px;"><br/></div></div><div data-zone-id=3D"0" data-line-index=3D"25" data-l=
ine=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6=
;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"font-=
size: 14px;">Not the pest way to handle this. Adding a one second delay on =
shutdown=C2=A0</div></div><div data-zone-id=3D"0" data-line-index=3D"26" da=
ta-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height:=
 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"f=
ont-size: 14px;">hurts some availability scenarios. Looks like mlx5 needs a=
 more coordinated=C2=A0</div></div><div data-zone-id=3D"0" data-line-index=
=3D"27" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; li=
ne-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" =
style=3D"font-size: 14px;">shutdown to be safe; adding big delays is not th=
e correct fix.</div></div><div data-zone-id=3D"0" data-line-index=3D"28" da=
ta-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height:=
 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" style=3D"f=
ont-size: 14px;"><br/></div></div><div data-zone-id=3D"0" data-line-index=
=3D"29" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; li=
ne-height: 1.6;" class=3D"history-quote-line"><div class=3D"" dir=3D"auto" =
style=3D"font-size: 14px;"><br/></div></div><div data-zone-id=3D"0" data-li=
ne-index=3D"30" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom:=
 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><br/>=
</div></div></div></div></body></html>
--2022e3103cf89737a4d071d3d25963c5d6012813d8cbb60b883bcd8f70d3--
