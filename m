Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FB9C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 07:27:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C87F40264;
	Wed,  8 Jul 2026 09:27:13 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8BDE640264
 for <dev@dpdk.org>; Wed,  8 Jul 2026 09:27:12 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-51c2cce930cso2861831cf.0
 for <dev@dpdk.org>; Wed, 08 Jul 2026 00:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783495632; cv=none;
 d=google.com; s=arc-20260327;
 b=gxX5dsgEBUdZTrVQrzqBBqnua14Vob7PgiJfSBYcdsvo0cLgAOPCh4QBx980mUwWo2
 HZ/RYexhEDB2iBa5KaHOBW3Vvh4MZ8irql+SnGFHSF0RZutTOl03BcvulGwKQv8f5kRE
 Ul5U7bfvk8B24MQtzlbtgtUgUZPJTw+/9ak3HSeEoW+SO3481g6zckh7u/vxOnY70Jlg
 cT2fY2FRmIv/75ms+8m/hv51BDJLEv42VjmSHKxzhGwfkVMfMcAQCopLQKR05E8cMBFP
 0QyV9TlwfzZl/cKEXxacc4eKGiMcsdaoPvAhSm0dRHdRK5wLJqk0dyryBE3uc+Pw+2P0
 Ni4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h54Nu6KTKsg+t4tLfwq7mTT1Jk6zAEPmHITrMbOqw2A=;
 fh=rZZ1Ewxz5HIjG0zJzoh7t/3GPP3sRix3QQW44jxDzSM=;
 b=R9ZkPm9RQqZSoCiPhjUMORcxKtex+pCumK3dZzZ2E14q9ZXPJ12dsjTFReLwRpR4lL
 G80aHwR2Nhs+6+GNJbaUh0zkizQHd2+wmQRojj+zmS1PEoH9CECqpa7r32oK1um0C7ns
 /7Y+DYJRlcXct0wikZPUNb88ec3chGJSUJpkeVdgt90YnnTiqIQN8Yp6gXn3Ho3ycLGE
 v7IYlNRZJUYZdVh/k6ySBD3lY81JlLvQvNhk9x5bL9Hsgfvc1jrqHApZcdBU3LzcaLdQ
 vow4ygS0GYPLaSeawZE2RORV8tXW2/h5WG22xEeLdIYl6su6h2r5IHznSRgXWVNAL1LJ
 QTLw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783495632; x=1784100432; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h54Nu6KTKsg+t4tLfwq7mTT1Jk6zAEPmHITrMbOqw2A=;
 b=S/mHh+JAwSwl1lHnT8kDOLUkiiC4uh9f255wZQuAaIKSV+jPCFlMTBUOkNh8LCSmJc
 4dtECbThp87nVQRo2Kw78J9pcPJ+aM2RKrWfwOpQ+9L/vYyDh2YLALfrhfbb6E7v0Tro
 VNNf58ym5xZG7/GCWVN3rxpwgF4EnxiROFu9kTXKcO6a5PnNu0W1Wr+90hO+Fex5+KLQ
 EB+AL3MySE392u/+8kIFuFmnAJa2mn1WSq+VSMhbiOxR77qPxfv4L2sa8FC7RG8Ae/xV
 2TgiI6Bx7iWicYzZhELA4ZCiKCpOTlSnRTOx5ebhZMrXS8MuPeT/BSHzjTNH+ev94TPA
 C7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783495632; x=1784100432;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h54Nu6KTKsg+t4tLfwq7mTT1Jk6zAEPmHITrMbOqw2A=;
 b=GkLJ6YgMdaDUt1Hw09/pM8xXM1/O0MwYI5TfXDGu0jKS0+EHK4U5u8HXPVbDXSSyWK
 cW854CSmob7qQ+jtbbpiuO7O962Nt/Klv9Y8x8yRntcxFALsxyXQEsu5LgjioG9hjdIP
 ksMOcP9I0ERRNF+ec+/9QuQaG33sZIdy5c6eNIGeyPrQB6G4lXlHpbC/CSipPR8KB5IL
 eSyDbDmlGhoAlgZKEiUKLzvF5roigjGz+9xgAZOjqwLNGHsdbxDKXJpwQBGikaOv3yJ/
 zrMQnWv7DjtpnX1NYu/GmQtcK+kqt/BzlJVDGhiGJY/WzpfkgMeSDuE2SSP/FTkyIV8H
 TrEQ==
X-Gm-Message-State: AOJu0YzURkpqD9GTsJeSZy0Okn73PVpNbUj4kD5PIXRbNRv/rU/HR0tz
 /lPOgK6OKr57Wo8tO+a/uiKwEeqXLimFe6jXvSqIHPFdIqMe7SSw+7rx9pvFjahKeSa5cS6MgLr
 Sq20rhd+haZPh4S+Tov4dfKsVzPiw9lM=
X-Gm-Gg: AfdE7clbAUpNYQ8vT3fQoXMThrlVaWA//+RjDjWxTrnP5vJ+z3hjulrFQGzpdR+MzS8
 ynoGrM7IuVRacewG0rlVCPfk1fmnGy8AfeS38vgW4lTxhpT/zEQE12axCjAWL+9WztgarTfarFD
 oJniepvFgKaBTaEyE5xnbHCJA6RGf4akFbUlm+/0O2Zd+4rNHNTP5BLU7XVx9fcLMdIqDe4YS+C
 bqO8aTes+t4WgxxorbNCJzf/Sl4cOa+xr8ZYpMDOnIEBCprfTAwc3fNJsA7zHOJ1ugk5RZw9dYD
 UtS6lw3z6g==
X-Received: by 2002:ac8:5fcd:0:b0:51c:1568:3a53 with SMTP id
 d75a77b69052e-51c8b39902fmr14402021cf.16.1783495631652; Wed, 08 Jul 2026
 00:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <1f2b21bd87a24610bc09b3b8da8100b5@huawei.com>
 <20260618063242.99189-1-spiderdetective.ss@gmail.com>
 <20260703074132.2a718abe@phoenix.local>
In-Reply-To: <20260703074132.2a718abe@phoenix.local>
From: su sai <spiderdetective.ss@gmail.com>
Date: Wed, 8 Jul 2026 15:26:58 +0800
X-Gm-Features: AVVi8CdTuh6m3P5cnk8-lsBpftNWrZlGcHd97uqJobBQQSMdp0L0fWq9G5cDJrg
Message-ID: <CAFQeoKgF7t-UjrkUi+NTywuL8JKkrhovWibUw=8VbejWWEaV+Q@mail.gmail.com>
Subject: Re: [v4] net/cksum: compute raw cksum for several segments
To: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000009549970656146f0b"
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

--0000000000009549970656146f0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rename test_l4_cksum_multi_mbufs to test_l4_cksum_mbuf_chain, resolve
double-free issue.

On Fri, Jul 3, 2026 at 10:41=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Thu, 18 Jun 2026 14:32:42 +0800
> Su Sai <spiderdetective.ss@gmail.com> wrote:
>
> > The rte_raw_cksum_mbuf function is used to compute
> > the raw checksum of a packet.
> > If the packet payload stored in multi mbuf, the function
> > will goto the hard case. In hard case,
> > the variable 'tmp' is a type of uint32_t,
> > so rte_bswap16 will drop high 16 bit.
> > Meanwhile, the variable 'sum' is a type of uint32_t,
> > so 'sum +=3D tmp' will drop the carry when overflow.
> > Both drop will make cksum incorrect.
> > This commit fixes the above bug.
> >
> > Signed-off-by: Su Sai <spiderdetective.ss@gmail.com>
> > Acked-by: Marat Khalili <marat.khalili@huawei.com>
> > ---
>
> Still one error in the test.
>
> Error =E2=80=94 double-free in test_l4_cksum_multi_mbufs() (app/test/test=
_cksum.c)
> The segments are chained into one packet (rte_pktmbuf_chain sets
> m[0]->next =3D m[1], m[1]->next =3D m[2]), but cleanup then calls
> rte_pktmbuf_free_bulk(m, segs_len) over the array.
> rte_pktmbuf_free_bulk walks the ->next chain of each array element, so
> index 0 frees the entire chain (m[0], m[1], m[2]), and indices 1 and 2
> then free m[1]/m[2] a second time. This fires on the normal success
> path every run, and on the fail path whenever =E2=89=A52 segments were ch=
ained
> =E2=80=94 a debug/ASAN build will abort on the sanity check, and a normal=
 build
> corrupts pool accounting. The array-of-independent-mbufs contract that
> free_bulk expects doesn't hold here because the elements alias one
> chain. Free the chain once through its head:
>

--0000000000009549970656146f0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"color:rgb(0,0,0);font-style:normal;font-vari=
ant:normal;font-size-adjust:none;font-kerning:auto;font-feature-settings:no=
rmal;font-stretch:normal;font-size:16px;line-height:24px;font-family:ui-san=
s-serif,system-ui,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI E=
moji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;padding=
:0px;margin:0px;background:none 0% 0%/auto repeat scroll padding-box border=
-box rgba(0,0,0,0)"><div style=3D"font-style:normal;font-variant:normal;fon=
t-size-adjust:none;font-kerning:auto;font-feature-settings:normal;font-stre=
tch:normal;font-size:16px;line-height:24px;font-family:ui-sans-serif,system=
-ui,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&qu=
ot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;padding:0px;margin:0p=
x;background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,=
0,0)"><div style=3D"font-style:normal;font-variant:normal;font-size-adjust:=
none;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;fon=
t-size:16px;line-height:24px;font-family:ui-sans-serif,system-ui,sans-serif=
,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Sy=
mbol&quot;,&quot;Noto Color Emoji&quot;;padding:0px 0px 0px 8px;margin:0px;=
background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,=
0)"><div style=3D"font-style:normal;font-variant:normal;font-size-adjust:no=
ne;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font-=
size:16px;line-height:24px;font-family:ui-sans-serif,system-ui,sans-serif,&=
quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symb=
ol&quot;,&quot;Noto Color Emoji&quot;;padding:0px;margin:0px;background:non=
e 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0)"><div style=
=3D"font-style:normal;font-variant:normal;font-size-adjust:none;font-kernin=
g:auto;font-feature-settings:normal;font-stretch:normal;font-size:16px;line=
-height:24px;font-family:ui-sans-serif,system-ui,sans-serif,&quot;Apple Col=
or Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot=
;Noto Color Emoji&quot;;padding:0px;margin:0px;background:none 0% 0%/auto r=
epeat scroll padding-box border-box rgba(0,0,0,0)"><div style=3D"font-style=
:normal;font-variant:normal;font-size-adjust:none;font-kerning:auto;font-fe=
ature-settings:normal;font-stretch:normal;font-size:16px;line-height:24px;f=
ont-family:ui-sans-serif,system-ui,sans-serif,&quot;Apple Color Emoji&quot;=
,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Em=
oji&quot;;padding:0px;margin:0px;background:none 0% 0%/auto repeat scroll p=
adding-box border-box rgba(0,0,0,0)"><div style=3D"color:rgba(0,0,0,0.85);f=
ont-style:normal;font-variant:normal;font-size-adjust:none;font-kerning:aut=
o;font-feature-settings:normal;font-stretch:normal;font-size:16px;line-heig=
ht:24px;font-family:ui-sans-serif,system-ui,sans-serif,&quot;Apple Color Em=
oji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto=
 Color Emoji&quot;;display:flex;padding:0px;margin:0px;background:none 0% 0=
%/auto repeat scroll padding-box border-box rgba(0,0,0,0)"><div style=3D"fo=
nt-style:normal;font-variant:normal;font-size-adjust:none;font-kerning:auto=
;font-feature-settings:normal;font-stretch:normal;font-size:16px;line-heigh=
t:24px;font-family:ui-sans-serif,system-ui,sans-serif,&quot;Apple Color Emo=
ji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto =
Color Emoji&quot;;display:flex;padding:0px;margin:0px;background:none 0% 0%=
/auto repeat scroll padding-box border-box rgba(0,0,0,0)"><div style=3D"fon=
t-style:normal;font-variant:normal;font-size-adjust:none;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:16px;line-height=
:24px;font-family:ui-sans-serif,system-ui,sans-serif,&quot;Apple Color Emoj=
i&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto C=
olor Emoji&quot;;display:grid;padding:0px;margin:0px;background:none 0% 0%/=
auto repeat scroll padding-box border-box rgba(0,0,0,0)"><div style=3D"font=
-style:normal;font-variant:normal;font-size-adjust:none;font-kerning:auto;f=
ont-feature-settings:normal;font-stretch:normal;font-size:16px;line-height:=
24px;font-family:ui-sans-serif,system-ui,sans-serif,&quot;Apple Color Emoji=
&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Co=
lor Emoji&quot;;padding:0px;margin:0px;background:none 0% 0%/auto repeat sc=
roll padding-box border-box rgba(0,0,0,0)"><div style=3D"font-style:normal;=
font-variant:normal;font-size-adjust:none;font-kerning:auto;font-feature-se=
ttings:normal;font-stretch:normal;font-size:16px;line-height:24px;font-fami=
ly:ui-sans-serif,system-ui,sans-serif,&quot;Apple Color Emoji&quot;,&quot;S=
egoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot=
;;display:flex;padding:0px;margin:0px;background:none 0% 0%/auto repeat scr=
oll padding-box border-box rgba(0,0,0,0)"><div style=3D"font-style:normal;f=
ont-variant:normal;font-size-adjust:none;font-kerning:auto;font-feature-set=
tings:normal;font-stretch:normal;font-size:16px;line-height:24px;font-famil=
y:ui-sans-serif,system-ui,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Se=
goe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;=
;padding:0px;margin:0px;background:none 0% 0%/auto repeat scroll padding-bo=
x border-box rgba(0,0,0,0)"><div style=3D"font-style:normal;font-variant:no=
rmal;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;f=
ont-stretch:normal;font-size:16px;line-height:24px;font-family:ui-sans-seri=
f,system-ui,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&q=
uot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;display:flex;=
padding:0px;margin:0px;background:none 0% 0%/auto repeat scroll padding-box=
 border-box rgba(0,0,0,0)"><div style=3D"color:rgb(0,0,0);font-style:normal=
;font-variant:normal;font-size-adjust:none;font-kerning:auto;font-feature-s=
ettings:normal;font-stretch:normal;font-size:16px;line-height:24px;font-fam=
ily:ui-sans-serif,system-ui,sans-serif,&quot;Apple Color Emoji&quot;,&quot;=
Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quo=
t;;padding:0px;margin:0px;background:none 0% 0%/auto repeat scroll padding-=
box border-box rgba(0,0,0,0)"><div style=3D"font-style:normal;font-variant:=
normal;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal=
;font-stretch:normal;font-size:16px;line-height:24px;font-family:ui-sans-se=
rif,system-ui,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji=
&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;padding:0px=
;margin:0px;background:none 0% 0%/auto repeat scroll padding-box border-box=
 rgba(0,0,0,0)"><div style=3D"font-style:normal;font-variant:normal;font-si=
ze-adjust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:=
normal;font-size:16px;line-height:24px;font-family:ui-sans-serif,system-ui,=
sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;S=
egoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;padding:0px;margin:0px;ba=
ckground:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0)=
">Rename test_l4_cksum_multi_mbufs to test_l4_cksum_mbuf_chain, resolve dou=
ble-free issue.</div></div></div></div></div></div></div></div></div></div>=
</div></div></div></div></div></div><div style=3D"color:rgb(0,0,0);font-sty=
le:normal;font-variant:normal;font-size-adjust:none;font-kerning:auto;font-=
feature-settings:normal;font-stretch:normal;font-size:16px;line-height:24px=
;font-family:ui-sans-serif,system-ui,sans-serif,&quot;Apple Color Emoji&quo=
t;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color =
Emoji&quot;;padding:0px;margin:0px;background:none 0% 0%/auto repeat scroll=
 padding-box border-box rgba(0,0,0,0)"><div style=3D"font-style:normal;font=
-variant:normal;font-size-adjust:none;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:16px;line-height:24px;font-family:u=
i-sans-serif,system-ui,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe=
 UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;pa=
dding:0px;margin:0px;background:none 0% 0%/auto repeat scroll padding-box b=
order-box rgba(0,0,0,0)"><div style=3D"font-style:normal;font-variant:norma=
l;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;font=
-stretch:normal;font-size:16px;line-height:24px;font-family:ui-sans-serif,s=
ystem-ui,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot=
;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;padding:0px;marg=
in:0px;background:none 0% 0%/auto repeat scroll padding-box border-box rgba=
(0,0,0,0)"></div></div></div></div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 3, 2026 at 1=
0:41=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplum=
ber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Thu, 18 Jun 2026 14:32:42 +0800<br>
Su Sai &lt;<a href=3D"mailto:spiderdetective.ss@gmail.com" target=3D"_blank=
">spiderdetective.ss@gmail.com</a>&gt; wrote:<br>
<br>
&gt; The rte_raw_cksum_mbuf function is used to compute<br>
&gt; the raw checksum of a packet.<br>
&gt; If the packet payload stored in multi mbuf, the function<br>
&gt; will goto the hard case. In hard case,<br>
&gt; the variable &#39;tmp&#39; is a type of uint32_t,<br>
&gt; so rte_bswap16 will drop high 16 bit.<br>
&gt; Meanwhile, the variable &#39;sum&#39; is a type of uint32_t,<br>
&gt; so &#39;sum +=3D tmp&#39; will drop the carry when overflow.<br>
&gt; Both drop will make cksum incorrect.<br>
&gt; This commit fixes the above bug.<br>
&gt; <br>
&gt; Signed-off-by: Su Sai &lt;<a href=3D"mailto:spiderdetective.ss@gmail.c=
om" target=3D"_blank">spiderdetective.ss@gmail.com</a>&gt;<br>
&gt; Acked-by: Marat Khalili &lt;<a href=3D"mailto:marat.khalili@huawei.com=
" target=3D"_blank">marat.khalili@huawei.com</a>&gt;<br>
&gt; ---<br>
<br>
Still one error in the test.<br>
<br>
Error =E2=80=94 double-free in test_l4_cksum_multi_mbufs() (app/test/test_c=
ksum.c)<br>
The segments are chained into one packet (rte_pktmbuf_chain sets<br>
m[0]-&gt;next =3D m[1], m[1]-&gt;next =3D m[2]), but cleanup then calls<br>
rte_pktmbuf_free_bulk(m, segs_len) over the array.<br>
rte_pktmbuf_free_bulk walks the -&gt;next chain of each array element, so<b=
r>
index 0 frees the entire chain (m[0], m[1], m[2]), and indices 1 and 2<br>
then free m[1]/m[2] a second time. This fires on the normal success<br>
path every run, and on the fail path whenever =E2=89=A52 segments were chai=
ned<br>
=E2=80=94 a debug/ASAN build will abort on the sanity check, and a normal b=
uild<br>
corrupts pool accounting. The array-of-independent-mbufs contract that<br>
free_bulk expects doesn&#39;t hold here because the elements alias one<br>
chain. Free the chain once through its head:<br>
</blockquote></div>

--0000000000009549970656146f0b--
