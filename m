Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6BF606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=eJUZLHXw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0374C4026F;
	Tue, 17 Nov 2026 07:39:36 +0100 (CET)
Received: from lf-2-51.ptr.blmpb.com (lf-2-51.ptr.blmpb.com [101.36.218.51])
 by mails.dpdk.org (Postfix) with ESMTPS id D355940150
 for <dev@dpdk.org>; Tue, 17 Nov 2026 07:39:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794897565; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bOgQoTgqbJsl1In52mOPMDwaYnMfq20z/k/+5SAaGAc=;
 b=eJUZLHXw+ghUvg3jWUNnfQMg5LV6lVYztIv08/ZImXdLRv5WQkIdVJxWrmX2H6Zu40AQHw
 0cKLoWtpaYvbLudx1Q97aDfA05X38j9vpnYPONaJmt8elBv6iJDUOVVwf+uOZzkDMeYRLv
 ckUoWBECHH1FClYet/FBhE96rwHplHUH8Bua8VHptmUmVi+e/wDOrMcujqdYSYRd0zr50u
 Bepbjv6awjZSLcXLwdwUyMUskfnRonMZWVwrWJOLUEx9fOLCeMfQAx6FAHnLmaPFg/jt+g
 finYKkf3cQoHSIQ+2EUapwD+9iAB7VcyWdknI26hs2attdH35rCH1+jSDE2FBg==
To: "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, <nana@yunsilicon.com>, <qianr@yunsilicon.com>, 
 <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Date: Tue, 17 Nov 2026 14:39:22 +0800
Message-Id: <1794897445.3@yunsilicon.com>
Subject: Re: [PATCH v2 0/3] net/xsc: fix issues reported by GCC analyzer
From: "WanRenyong" <wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+16afbf69b+db18a7+dpdk.org+wanry@yunsilicon.com>
Content-Type: multipart/alternative;
 boundary=1c5ce656a099329f480ca2b196969d5d9ecbeaf5b2da2fde140448db0a14
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--1c5ce656a099329f480ca2b196969d5d9ecbeaf5b2da2fde140448db0a14
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On 2026-11-16 10:46 -0800, Stephen Hemminger wrote:
> Error: the leak is not fixed. xsc_dev_uninit() is only called from
> the probe error path in xsc_ethdev_init(), where the jumbo buffer
> can never have been allocated (rte_zmalloc'd xdev, port never
> started). The normal remove path is xsc_ethdev_uninit(), which does
> not call xsc_dev_uninit(); it frees xdev directly:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret |=3D xsc_ethdev_close(eth_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 xsc_dev_pct_uninit(priv->xdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_free(priv->xdev);
>
> So the buffer still leaks on every device removal.

Hi Stephen,

Thanks for the review. Noted, I will send the next version of the series
shortly.

Thanks,
Renyong
--1c5ce656a099329f480ca2b196969d5d9ecbeaf5b2da2fde140448db0a14
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div id=3D"editor_version_8.5.0_qgvZ154O" style=3D=
"word-break:break-word;"><div data-zone-id=3D"0" data-line-index=3D"0" data=
-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1=
.6;"><div dir=3D"auto" style=3D"font-size: 14px;"><div id=3D"lark-mail-quot=
e-946017c2cf9f2631f7763c8de9cecfb4">On 2026-11-16 10:46 -0800, Stephen Hemm=
inger wrote:</div></div></div><div data-zone-id=3D"0" data-line-index=3D"1"=
 data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-heig=
ht: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;">&gt; Error: the leak=
 is not fixed. xsc_dev_uninit() is only called from</div></div><div data-zo=
ne-id=3D"0" data-line-index=3D"2" data-line=3D"true" style=3D"margin-top: 4=
px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-=
size: 14px;">&gt; the probe error path in xsc_ethdev_init(), where the jumb=
o buffer</div></div><div data-zone-id=3D"0" data-line-index=3D"3" data-line=
=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;">=
<div dir=3D"auto" style=3D"font-size: 14px;">&gt; can never have been alloc=
ated (rte_zmalloc&#39;d xdev, port never</div></div><div data-zone-id=3D"0"=
 data-line-index=3D"4" data-line=3D"true" style=3D"margin-top: 4px; margin-=
bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;=
">&gt; started). The normal remove path is xsc_ethdev_uninit(), which does<=
/div></div><div data-zone-id=3D"0" data-line-index=3D"5" data-line=3D"true"=
 style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=
=3D"auto" style=3D"font-size: 14px;">&gt; not call xsc_dev_uninit(); it fre=
es xdev directly:</div></div><div data-zone-id=3D"0" data-line-index=3D"6" =
data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-heigh=
t: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;">&gt;</div></div><div =
data-zone-id=3D"0" data-line-index=3D"7" data-line=3D"true" style=3D"margin=
-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=
=3D"font-size: 14px;">&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret |=3D xsc_ethdev_=
close(eth_dev);</div></div><div data-zone-id=3D"0" data-line-index=3D"8" da=
ta-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height:=
 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;">&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 xsc_dev_pct_uninit(priv-&gt;xdev);</div></div><div data-zone-id=
=3D"0" data-line-index=3D"9" data-line=3D"true" style=3D"margin-top: 4px; m=
argin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size:=
 14px;">&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_free(priv-&gt;xdev);</div></di=
v><div data-zone-id=3D"0" data-line-index=3D"10" data-line=3D"true" style=
=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"aut=
o" style=3D"font-size: 14px;">&gt;</div></div><div data-zone-id=3D"0" data-=
line-index=3D"11" data-line=3D"true" style=3D"margin-top: 4px; margin-botto=
m: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;">&gt=
; So the buffer still leaks on every device removal.</div></div><div data-z=
one-id=3D"0" data-line-index=3D"12" data-line=3D"true" style=3D"margin-top:=
 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"fon=
t-size: 14px;"><br/></div></div><div data-zone-id=3D"0" data-line-index=3D"=
13" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-h=
eight: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;">Hi Stephen,</div>=
</div><div data-zone-id=3D"0" data-line-index=3D"14" data-line=3D"true" sty=
le=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"a=
uto" style=3D"font-size: 14px;"><br/></div></div><div data-zone-id=3D"0" da=
ta-line-index=3D"15" data-line=3D"true" style=3D"margin-top: 4px; margin-bo=
ttom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;">=
Thanks for the review. Noted, I will send the next version of the series</d=
iv></div><div data-zone-id=3D"0" data-line-index=3D"16" data-line=3D"true" =
style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=
=3D"auto" style=3D"font-size: 14px;">shortly.</div></div><div data-zone-id=
=3D"0" data-line-index=3D"17" data-line=3D"true" style=3D"margin-top: 4px; =
margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=3D"font-size=
: 14px;"><br/></div></div><div data-zone-id=3D"0" data-line-index=3D"18" da=
ta-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height:=
 1.6;"><div dir=3D"auto" style=3D"font-size: 14px;">Thanks,</div></div><div=
 data-zone-id=3D"0" data-line-index=3D"19" data-line=3D"true" style=3D"marg=
in-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div dir=3D"auto" style=
=3D"font-size: 14px;">Renyong</div></div></div></body></html>
--1c5ce656a099329f480ca2b196969d5d9ecbeaf5b2da2fde140448db0a14--
