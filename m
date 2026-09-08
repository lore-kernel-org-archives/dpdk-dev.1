Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B435C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 19:16:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E446402D8;
	Tue,  8 Sep 2026 21:16:44 +0200 (CEST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41]) by mails.dpdk.org (Postfix) with ESMTP id 77ADC4028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 21:16:42 +0200 (CEST)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5b5e18f0439so4766924e87.2
 for <dev@dpdk.org>; Tue, 08 Sep 2026 12:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788895002; cv=none;
 d=google.com; s=arc-20260327;
 b=Lz4zjxLUtJFnz4m3zQ6GiJ1gIFMeUU53asmg7F9S3OKhnQSQw9ow488hRuRAAXq99Z
 Q/+EbgtUdO7NjfKWIkQofNYZkIPU5SidPdABu36SoWN4+oAk+yuhhz69b29Cp4+zYkmo
 VmsKkuzwmdIe4YC2aT9HAdGzjUSRckkvCesUHwcHsb3PPgBSFjqAUfFbldp2JnxOuo1p
 T1aLiFDeBnBCXPXSKOA1TwKwmG8jSKgYOmBO9q/8n2tUcjotpPPd5HVwx0ZqAgjoUUtC
 KCEsTxhDlXqUszytHFR3x28TxJl67+FC/h+fRoEAI6Yg8iP8VcQDDexVJgEzO6fy8mjS
 crMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D/et0W9d2xizY6ys0RdDOeV+E81LfKIQgSnk4ehXHqc=;
 fh=rHjwnsV+bR1GBmOpaP6i2gksBeFMGz+cAg/cY8zwF0I=;
 b=WF+8WjTNebN4rHzyiaK8KiywOOXMlKbkyyiz5adbN+0xbSr+r0PLY7nv/efHSEPW8Y
 WddnFYKH8duS7CXuGzGW8khRY6KcudLDOwjJLOj3Ew9bgyPz1IRcd67wsrBIM2rxQXzl
 ni6BDwnbiOL0Pv2T9sZHEGPE7mNhaNyKLcMKbBlXnsxnc+Ela7WRvYQiu2MYTIzNwk+Z
 QI2L4jd5sZD251UhaVjywj/RRWNTCXCl2Zo0YSedwqmY+mjNeb9hilTp6rfjxyWjiIlH
 Q11+HzrqS8IsT/RcwCo/17C/GLALRCiTyMfTJ8lMJSh3fSAGQrLACZuiGnEePP+LMa75
 b+xw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788895002; x=1789499802; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D/et0W9d2xizY6ys0RdDOeV+E81LfKIQgSnk4ehXHqc=;
 b=L1U8ybYloDtMJeHeCn1qJZ3lRmrthgfsQ24K2i2lBNt+hQxIdGumZjIKGIbJ5Das/b
 ORUuB1+tZBA92tbma+kHN/YIeicDy3ZSWk9ZqRCQ8RKUwqqRj2xdBPAZbRtvL7rKs5bW
 +vK9i31DM00QxVAxxbC9GIJmbb1A8fSuxsoqOYjawubFNHQkE9HJ/fGjLLpbWRPte7lm
 Fe0x8AjUkOjgcJdjSAr1W8PfXSI4mC7pjHUPjXoiLoXldQHg2YeKOyNNiL1nMkUXdQG3
 ogQicl8DnfbT/TEKFKKDlKbmZFw/01aBCCsHCjQg4lnh4VHnF8U6riYYR0kIvWloSm/E
 QOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788895002; x=1789499802;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D/et0W9d2xizY6ys0RdDOeV+E81LfKIQgSnk4ehXHqc=;
 b=E/lh6Tz2b0zqcv5IONt9Lq1SIVc3MnRORSzk0pUjAXdZ7f3VNTH/ppJBGTPGnmAzqk
 svrAIN/i35i5GaL7inekyG0MCHbzYYBZBJdBTIRYM1XDAXxxkiVlazZqDYxSeZIVOFEv
 cargUW4xwMh+okd/J+Xo+8ycAF8g+fOrbRRPqoINOz/Ts1BUvrJEw6etYVfHyj0ubJuD
 F+UKd3UD6UF7YWEn0t87ZjxQAJclsW/+VlZ7BMMCQ+k+UyBtqigB8JMVoyzGytFntgcO
 8JDtw85jziE1AR1Vh6EJv7SoT2FWEpQCif/wfBhY3xeshDX/VQ1nfvzfKtjWfaF2a74Y
 gYLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzG95JBFNzZk4L2HqIREAQIhI5JEpdMrL+0d7ZB9rwIIZeV3vSiuznjreIk0sTTOgZoYt8=@dpdk.org
X-Gm-Message-State: AFuF++nLZmr3cflsOQAN1rGTBSHqlwTJKKtA8FdZvSRwTF1HpFUe5iUm
 wRqMjc09lToBpA3rc3gR+uVS2U/ndwYOVCenkrq9WOSwt2YKU2uQCR2uwb7j0zGfIh4oVxu/7Iz
 E1XUDbpCmhtfDCd003ZN2Q2SFqKcoMz8=
X-Gm-Gg: AYBFou2wgppacpgdR3bAzX9eyahe6RwnCxB0a1s+gg25MVWvuv9Jb1imxkAhf9+MRxh
 5r85iwtb1A55ecoOWhIFxb4QHJdL1G7UhftQFD2fNvWN053LQ+6ajWWXMnWup9RXnmh0aEbUj0+
 EkBtbhgotQHAehpx61jeHQMvBGokSQi6rHsiG8lJklBzstExSALEpXv5BHulfUNSlQH/nD6Y7qU
 ym4tU7Z5Vcb+n+mQX+ghjgGBYBz8iUCpRy7xVv9ekX7sAuD7aJJSHrwdsJwmRS5mCTIML9OzGMa
 +NopXuyrHxZ5QjZsHeXdtZdaUFhh36CBJPBjzu6z2BDjYzeYAGTZp+9ExeQEkXhWp3smfDvBQ0A
 JHlY=
X-Received: by 2002:a05:6512:398d:b0:5b6:4ae:5b77 with SMTP id
 2adb3069b0e04-5b616f4bda3mr4539698e87.26.1788895001482; Tue, 08 Sep 2026
 12:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260414025137.91776-1-p31andrei@gmail.com>
 <20260731133739.223235-1-p31andrei@gmail.com>
 <20260908111022.25fd9aac@phoenix.local>
In-Reply-To: <20260908111022.25fd9aac@phoenix.local>
From: Andrei Petre <p31andrei@gmail.com>
Date: Tue, 8 Sep 2026 22:16:29 +0300
X-Gm-Features: AcwNN1XoogwKp8mdRZ8XRxDgg_ZLnSJn36-Nj4l7cGLFtJsMNLv6WvraRrYLipg
Message-ID: <CAOmzyKcJdpx1sLBjzL1JKydnYw1iigfzNeaB3S9odL-HtcUitQ@mail.gmail.com>
Subject: Re: [PATCH v2] examples/l3fwd: fix compilation when DP debug on
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: konstantin.ananyev@huawei.com, dev@dpdk.org, stable@dpdk.org, 
 sean.morrissey@intel.com
Content-Type: multipart/alternative; boundary="0000000000001a9bfe065afd9363"
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

--0000000000001a9bfe065afd9363
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 8, 2026, 9:10 PM Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Fri, 31 Jul 2026 16:37:39 +0300
> Andrei-Niculae Petre <p31andrei@gmail.com> wrote:
>
> > Update l3fwd example app to fix compilation when building dpdk with
> > RTE_LOG_DP_LEVEL=RTE_LOG_DEBUG in config/rte_config.h .
> > Move l3fwd_acl.h include above all #ifdef L3FWDACL_DEBUG checks,
> > as previously one ifdef would evaluate to false all the time (as
> > header include was added too late).
> >
> > Adapt maintainers line from previous examples/l3fwd-acl (removed in
> > 6de0ea50e9b9) to examples/l3fwd/l3fwd_acl* after l3fwd-acl app
> > unification into l3fwd. In 6de0ea50e9b9, a line with maintainer
> > expertise was removed.
> >
> > Own testing of the l3fwd example:
> > 1. It now compiles with "#define RTE_LOG_DP_LEVEL RTE_LOG_DEBUG" in
> >    config/rte_config.h. See Bugzilla ID 1318 comments for full error
> >    seen before this patch.
> > 2. I ran the l3fwd app with IPv4/IPv6 ACL rules to see the prints (when
> >    RTE_LOG_DP_LEVEL RTE_LOG_DEBUG is set) in the application around ACL
> >    work as expected. See extract below (I added \ to format to 72chars):
> >
> > // dump_acl4_rule extract:
> > Packet Src:192.168.1.100 Dst:192.168.1.101 Src port:2048,Dst port:1846 \
> > hit ACL 1 - 192.168.1.100/24 0.0.0.0/0 0 : 65535 0 : 65535 0x0/0x0 \
> > 0xffffffff-0x1ffffffe-0xf0000001
> >
> > // dump_acl6_rule extract:
> > Packet Src2001:db8:1::100
> > Dst2001:db8:1::101
> > Src port:32768,Dst port:21005 hit ACL 0 - \
> > 2001:0db8:0001:0000:0000:0000:0000:0000/64 \
> > 0000:0000:0000:0000:0000:0000:0000:0000/0 0 : 65535 0 : 65535 \
> > 0x0/0x0 0xffffffff-0x1fffffff-0xf0000000
> >
> > Bugzilla ID: 1318
> > Fixes: 6de0ea50e9b9 ("examples/l3fwd: merge l3fwd-acl example")
> > Cc: stable@dpdk.org
> > Cc: sean.morrissey@intel.com
> >
> > Signed-off-by: Andrei-Niculae Petre <p31andrei@gmail.com>
> > ---
>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e99a65d197..6b6446a998 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1756,6 +1756,8 @@ F: lib/acl/
> >  F: doc/guides/prog_guide/packet_classif_access_ctrl.rst
> >  F: app/test-acl/
> >  F: app/test/test_acl.*
> > +F: examples/l3fwd/l3fwd_acl*
> > +F: doc/guides/sample_app_ug/l3_forward.rst
>
> I don't think all of l3_forward should fall under the ACL maintainer
> bucket.
>

Hi Stephen,

I totally agree, but I didn't know of a better way to do this given all the
info was merged in a single file post l3fwd unification. Do you or
Konstantin have any better ideas how to do this instead to avoid losing
information re ACL maintainer?

Thanks for checking the patch also.

Andrei

>

--0000000000001a9bfe065afd9363
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">On Tue, Sep 8, 2026, 9:10 PM Stephen He=
mminger &lt;<a href=3D"mailto:stephen@networkplumber.org">stephen@networkpl=
umber.org</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_contain=
er" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, 31 Jul 2026 16:37:3=
9 +0300<br>
Andrei-Niculae Petre &lt;<a href=3D"mailto:p31andrei@gmail.com" target=3D"_=
blank" rel=3D"noreferrer">p31andrei@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Update l3fwd example app to fix compilation when building dpdk with<br=
>
&gt; RTE_LOG_DP_LEVEL=3DRTE_LOG_DEBUG in config/rte_config.h .<br>
&gt; Move l3fwd_acl.h include above all #ifdef L3FWDACL_DEBUG checks,<br>
&gt; as previously one ifdef would evaluate to false all the time (as<br>
&gt; header include was added too late).<br>
&gt; <br>
&gt; Adapt maintainers line from previous examples/l3fwd-acl (removed in<br=
>
&gt; 6de0ea50e9b9) to examples/l3fwd/l3fwd_acl* after l3fwd-acl app<br>
&gt; unification into l3fwd. In 6de0ea50e9b9, a line with maintainer<br>
&gt; expertise was removed.<br>
&gt; <br>
&gt; Own testing of the l3fwd example:<br>
&gt; 1. It now compiles with &quot;#define RTE_LOG_DP_LEVEL RTE_LOG_DEBUG&q=
uot; in<br>
&gt;=C2=A0 =C2=A0 config/rte_config.h. See Bugzilla ID 1318 comments for fu=
ll error<br>
&gt;=C2=A0 =C2=A0 seen before this patch.<br>
&gt; 2. I ran the l3fwd app with IPv4/IPv6 ACL rules to see the prints (whe=
n<br>
&gt;=C2=A0 =C2=A0 RTE_LOG_DP_LEVEL RTE_LOG_DEBUG is set) in the application=
 around ACL<br>
&gt;=C2=A0 =C2=A0 work as expected. See extract below (I added \ to format =
to 72chars):<br>
&gt; <br>
&gt; // dump_acl4_rule extract:<br>
&gt; Packet Src:192.168.1.100 Dst:192.168.1.101 Src port:2048,Dst port:1846=
 \<br>
&gt; hit ACL 1 - <a href=3D"http://192.168.1.100/24" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">192.168.1.100/24</a> <a href=3D"http://0.0.0.0/0"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">0.0.0.0/0</a> 0 : 65535 0 =
: 65535 0x0/0x0 \<br>
&gt; 0xffffffff-0x1ffffffe-0xf0000001<br>
&gt; <br>
&gt; // dump_acl6_rule extract:<br>
&gt; Packet Src2001:db8:1::100<br>
&gt; Dst2001:db8:1::101<br>
&gt; Src port:32768,Dst port:21005 hit ACL 0 - \<br>
&gt; 2001:0db8:0001:0000:0000:0000:0000:0000/64 \<br>
&gt; 0000:0000:0000:0000:0000:0000:0000:0000/0 0 : 65535 0 : 65535 \<br>
&gt; 0x0/0x0 0xffffffff-0x1fffffff-0xf0000000<br>
&gt; <br>
&gt; Bugzilla ID: 1318<br>
&gt; Fixes: 6de0ea50e9b9 (&quot;examples/l3fwd: merge l3fwd-acl example&quo=
t;)<br>
&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"norefe=
rrer">stable@dpdk.org</a><br>
&gt; Cc: <a href=3D"mailto:sean.morrissey@intel.com" target=3D"_blank" rel=
=3D"noreferrer">sean.morrissey@intel.com</a><br>
&gt; <br>
&gt; Signed-off-by: Andrei-Niculae Petre &lt;<a href=3D"mailto:p31andrei@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">p31andrei@gmail.com</a>&gt;<b=
r>
&gt; ---<br>
<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index e99a65d197..6b6446a998 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -1756,6 +1756,8 @@ F: lib/acl/<br>
&gt;=C2=A0 F: doc/guides/prog_guide/packet_classif_access_ctrl.rst<br>
&gt;=C2=A0 F: app/test-acl/<br>
&gt;=C2=A0 F: app/test/test_acl.*<br>
&gt; +F: examples/l3fwd/l3fwd_acl*<br>
&gt; +F: doc/guides/sample_app_ug/l3_forward.rst<br>
<br>
I don&#39;t think all of l3_forward should fall under the ACL maintainer bu=
cket.<br></blockquote></div><div dir=3D"auto"><br></div><div dir=3D"auto">H=
i Stephen,</div><div dir=3D"auto"><br></div><div dir=3D"auto">I totally agr=
ee, but I didn&#39;t know of a better way to do this given all the info was=
 merged in a single file post l3fwd unification. Do you or Konstantin have =
any better ideas how to do this instead to avoid losing information re ACL =
maintainer?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks for c=
hecking the patch also.</div><div dir=3D"auto"><br>Andrei</div><div class=
=3D"gmail_quote gmail_quote_container" dir=3D"auto"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
</blockquote></div></div>

--0000000000001a9bfe065afd9363--
