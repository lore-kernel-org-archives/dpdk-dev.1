Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E37E83057
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 06:54:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0083240281;
	Tue,  3 Feb 2026 07:54:23 +0100 (CET)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44]) by mails.dpdk.org (Postfix) with ESMTP id AA7DC40281
 for <dev@dpdk.org>; Tue,  3 Feb 2026 07:54:22 +0100 (CET)
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-948b3d7e85fso1203462241.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 22:54:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770101662; cv=none;
 d=google.com; s=arc-20240605;
 b=Tl3Lr3ez4bguDEEOVnebeOiIP/uZ39Mq925Ij0Q/rjkaPoEo7OERjYFSrQTEYY+Frp
 lJfOFv0vBpMeEmVE9XhqIlOgy6NXR95ylHOi/SM22dfJNVobaBFhTSKtaRut34pjU7EP
 Cr6MMrIqgmxWDJMmNobYUVWbkW2fTWOYrI9mJwaoykzbt5yFiRiDrPzh8L7C2mFUm34J
 GWaoQz9m+7ZWhbjmw0DWMxse+s0CbhEeojCci38Q77B85dC41qkHLiqQFcSbLsx9neEA
 R9AwgaiX1E8rV7gtJ7aEWRp8kAobMQBxz1r6g3zJ/I+V6hHu7J4m1qkfo4SmXvhtrtZA
 IMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=foL13wlMAtnYq0xnb0cPyY6vlYcoQKq2LZD1x88EMKM=;
 fh=iueenIqB6CrKimgktdL/oMaSgF/U5LADhTXdexkL10o=;
 b=ZahL9eabNbMGZCXsH8T4LLqfP+iJo1zIF6yZtlVWqda6zFuwfhZ3X3hQUUe2bpOjm5
 kehlULqAWNCPbV3j33somqJg2cfI0CggK+BV4mhv/uU4WKeTsy5DTcbnIh1tUmWV5Dmv
 Jb46soUEBlkyVICczS3AI2Ci3YXybk6iixzJhbHKkxF69Dz/4ZY87MWOSmhLHblcL4Bk
 B9BQCIHg56MwMD5H7RNeEt5f2aG4G6yTXC8IL2FzHfhkyVl8o7aRJ0ulfrvJqEE+WXeE
 IEMNuKwIuqcnGA2z7wuAvPEpkCCPEIRHeUkVbnUKAmaxq+1zZyEoN9AduzgpX76zm4su
 cl5A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770101662;
 x=1770706462; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=foL13wlMAtnYq0xnb0cPyY6vlYcoQKq2LZD1x88EMKM=;
 b=SGFoYEjQ8hB5nVSbKR1ziWu00tv+puAMtpUl1CM6cMpHS59Ab+JuYnkmIpAx4XbnAx
 8hXUdmQHnFzUBo3Jmrzu6VUJrqDG3n1v3xEeglQt19oym/p+Mhqc2uKzAjJLuPOj173T
 oOHWZIcUkB365oX88MYPvH5u5VovNYKo761Nxrj/Hr7J7y39xeZwJXkzZUNsPI41OUD8
 8NhRcNGJ0Z7Ic8k2jyekUEzOz+RheovPY1i1uGwF+aAqmddO2idCKxDgjEKnu6wQ/wFr
 /sAvfuvcFQOwt/VKKe8+hczdncS0rdCsm+0A1AMvgwpriF1I7Zc+xZPzJgRDoEb7pNaZ
 kgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770101662; x=1770706462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foL13wlMAtnYq0xnb0cPyY6vlYcoQKq2LZD1x88EMKM=;
 b=W4K4CcG5jzUpw73D+fE/csH1DbjQcn4+k9tjmcczjaaaKwIS5tHriMZ4nRAaIt4FHB
 Nr8fXSQWCX/CjHkWgTDGDkoPamPJ+dnFg4ihsZkwQFXOpFT8oENQFf01WmaAYy+eIn46
 56L/XPRK1ki549JUFJdotS0e7E8X41yPhjqvMtPV5r5Ra+QJql/js0hY2+ZKspvno9nj
 w6Ssk6PHlTwd4JwN9pdIEvx/C3h0tehQ4TGXnh1I4pbwEKtfBI+mFsNNl6Tvyx3ugriF
 oC1Yyl5PRvStYy8p5JfCXH4cjdFnyVGJSOwDK0WQVlu1/7fKWFxr1qYk6c6LaYftOi6c
 Hj4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5TDxDgfNjtJWUybwvcg2aOEF8z3Jic7iIEr42DCn90l0/5NMW3Gk+N8R+848u10JccyE=@dpdk.org
X-Gm-Message-State: AOJu0YxP+U6kjFWWZne5y5gNmSL9WSKx+cRX8socnT8ltg3lYuT2ncGn
 25fhNSO0X8En203TkXwHp99orRzY5oEce6p6gV+0Q4g8yOw0tSs+SkBnBkuSZwz6k6jOxbCOy4z
 qpMryy35NS6J1w8E1UNpt99jN3Yfru2F9ISJV1aUe2w==
X-Gm-Gg: AZuq6aLiMsx7Vss7BBVsLVjFy19J993pZnm19gaV32FCdg8Q7caUNDF4x40/zYxgEVP
 5jC/l3/cT9nRHMFbqcGgqEp6drqTcVLZxXY8720SnXg0jTFvfRld/uBH03w5Kb/gx+uR+SMFNHK
 do/nraSCbaB9s7p4FcOFXhlYdJd8C76WSj9oeq7zruUeXFGJ0Bi8Gqm/cq7vKB7IhJlA4sABYH0
 fUOZrkwSUAVTywmQcAvjwmWdKj2I83yFLq8bI2NjubIUeSm0HT5Cgusd8XNgoMX/FLyJ9KrGB61
 JJ9Lu48=
X-Received: by 2002:a05:6102:3f05:b0:5f5:48df:b85a with SMTP id
 ada2fe7eead31-5f8e26c1742mr4198840137.40.1770101661755; Mon, 02 Feb 2026
 22:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20251030033619.3386064-1-dimon.zhao@nebula-matrix.com>
 <20260115032744.62449-2-dimon.zhao@nebula-matrix.com>
 <20260120203613.6f292ccf@phoenix.local> <5502163.GXAFRqVoOG@thomas>
 <cf2f08da-4ffd-414c-9ae3-5a6ecb404c06.dimon.zhao@nebula-matrix.com>
In-Reply-To: <cf2f08da-4ffd-414c-9ae3-5a6ecb404c06.dimon.zhao@nebula-matrix.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 2 Feb 2026 22:54:10 -0800
X-Gm-Features: AZwV_QgYNCVu0iyJWvO-8mZtLEHUmOaUTiNXcOdZzC8c7uNXRof21FT8tCCBZ9Y
Message-ID: <CAOaVG14zbrQJbFUpX1Hw8trb0C8g6KyxVwaEURxN=2Pnaq456g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] net/nbl: fix issues reported by Coverity
To: Dimon <dimon.zhao@nebula-matrix.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>,
 stable <stable@dpdk.org>, 
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon <leon.yu@nebula-matrix.com>, 
 Sam <sam.chen@nebula-matrix.com>
Content-Type: multipart/alternative; boundary="000000000000c3f9490649e5e8fb"
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

--000000000000c3f9490649e5e8fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Send a new series and I replace the one in next net

On Mon, Feb 2, 2026, 20:01 Dimon <dimon.zhao@nebula-matrix.com> wrote:

> Hi Thomas,
>
> Thank you for the feedback about splitting the Coverity fixes patch by
> issue type.
> You're absolutely right - it addresses three distinct problems and should
> be separate commits.
>
> Now the patch is already queued to next-net, and since then five
> additional nbl driver fixes have been merged:
> net/nbl: improve mailbox exception handling
> net/nbl: fix mbuf double-free in queue cleanup
> net/nbl: fix mbuf headroom usage in packet Tx
> net/nbl: fix memzone leak on queue release
> net/nbl: fix hardware stats interrupt nesting issue
>
> What should I do? Should I ask Stephen to help revert these 6 commits and
> then resubmit them?
>
>
>
> ------------------------------------------------------------------
>
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AThomas Monjalon <thomas@monjalon.net>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2026=E5=B9=B42=E6=9C=882=E6=
=97=A5(=E5=91=A8=E4=B8=80) 04:29
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9ADimon<dimon.zhao@nebula-matrix.com>
> =E6=8A=84 =E9=80=81=EF=BC=9Adev<dev@dpdk.org>; stable<stable@dpdk.org>; K=
yo Liu<
> kyo.liu@nebula-matrix.com>; Leon<leon.yu@nebula-matrix.com>; Sam<
> sam.chen@nebula-matrix.com>; Stephen Hemminger<stephen@networkplumber.org=
>
> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: [PATCH v3 1/1] net/nbl: fix issues report=
ed by Coverity
>
> 21/01/2026 05:36, Stephen Hemminger:
> > On Wed, 14 Jan 2026 19:27:44 -0800
> > Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:
> >
> > > Address multiple issues reported by Coverity static analysis:
> > >
> > > Check return values of ioctl() calls for NBL_DEV_USER_GET_BAR_SIZE
> > > and NBL_DEV_USER_CLEAR_EVENTFD. The original code tested the return
> > > value without capturing it from the ioctl call.
> > >
> > > Move debug log statement after NULL pointer validation in
> > > nbl_dev_configure() to prevent dereference of adapter before the
> > > check.
> > >
> > > Cast u16 operands to u64 before multiplication when calculating
> > > buffer sizes and offsets to prevent potential integer overflow.
> > > The num_txq_entries, num_rxq_entries, txq_buf_size, and rxq_buf_size
> > > fields are all u16 types, and their product could overflow before
> > > assignment to size_t or u64 destination variables.
> > >
> > > Coverity issue: 490942
> > > Coverity issue: 490943
> > > Coverity issue: 490946
> > > Coverity issue: 490947
> > > Coverity issue: 490949
> > > Coverity issue: 490950
> > > Coverity issue: 490951
> > > Coverity issue: 490952
> > > Coverity issue: 490953
> > > Coverity issue: 490954
> > > Coverity issue: 490955
> > > Coverity issue: 490957
> > > Coverity issue: 490958
> > > Coverity issue: 490959
> > > Fixes: a1c5ffa13b2c ("net/nbl: add channel layer")
> > > Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
> > > Fixes: 93b38df5a2ec ("net/nbl: support basic configuration")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> >
> > Queued to next-net
>
> After another look, I think it deserves to be split per type of issue.
> Maybe 3 commits?
>
>
>

--000000000000c3f9490649e5e8fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Send a new series and I replace the one in next net</div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Feb 2, 2026, 20:01 Dimon &lt;<a href=3D"mailto:dimo=
n.zhao@nebula-matrix.com">dimon.zhao@nebula-matrix.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div style=3D"fo=
nt-family:Tahoma,Arial,STHeitiSC-Light,SimSun"><div style=3D"clear:both;fon=
t-family:Tahoma,Arial,STHeitiSC-Light,SimSun"><span style=3D"font-family:Ta=
homa,Arial,STHeitiSC-Light,SimSun"><span>Hi Thomas,<br></span></span><div s=
tyle=3D"clear:both"><br></div><div style=3D"clear:both">Thank you for the f=
eedback about splitting the Coverity fixes patch by issue type.</div><div s=
tyle=3D"clear:both">You&#39;re absolutely right - it addresses three distin=
ct problems and should be separate commits.<br></div><div style=3D"clear:bo=
th"><br></div><div style=3D"clear:both">Now the patch is already queued to =
next-net, and since then five additional nbl driver fixes have been merged:=
<br></div><div style=3D"clear:both">net/nbl: improve mailbox exception hand=
ling<br></div><div style=3D"clear:both">net/nbl: fix mbuf double-free in qu=
eue cleanup<br></div><div style=3D"clear:both">net/nbl: fix mbuf headroom u=
sage in packet Tx<br></div><div style=3D"clear:both">net/nbl: fix memzone l=
eak on queue release<br></div><div style=3D"clear:both">net/nbl: fix hardwa=
re stats interrupt nesting issue<br></div><div style=3D"clear:both"><br></d=
iv><div><span>What should I do? Should I ask Stephen to help revert these 6=
 commits and then resubmit them?</span></div></div><div style=3D"clear:both=
;font-family:Tahoma,Arial,STHeitiSC-Light,SimSun"><span style=3D"font-famil=
y:Tahoma,Arial,STHeiti,SimSun"><br></span></div><div style=3D"clear:both;fo=
nt-family:Tahoma,Arial,STHeitiSC-Light,SimSun"><span style=3D"font-family:T=
ahoma,Arial,STHeiti,SimSun"><br></span></div><div style=3D"clear:both;font-=
family:Tahoma,Arial,STHeitiSC-Light,SimSun"><span style=3D"font-family:Taho=
ma,Arial,STHeiti,SimSun"><br></span></div><div style=3D"clear:both;font-fam=
ily:Tahoma,Arial,STHeitiSC-Light,SimSun"><span style=3D"font-family:Tahoma,=
Arial,STHeiti,SimSun">-----------------------------------------------------=
-------------</span></div><blockquote style=3D"margin-right:0px;margin-top:=
0px;margin-bottom:0px;font-family:Tahoma,Arial,STHeiti,SimSun;font-size:14p=
x;color:rgb(0,0,0)"><div><div style=3D"clear:both">=E5=8F=91=E4=BB=B6=E4=BA=
=BA=EF=BC=9AThomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net" targ=
et=3D"_blank" rel=3D"noreferrer">thomas@monjalon.net</a>&gt;</div><div styl=
e=3D"clear:both">=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2026=E5=B9=B4=
2=E6=9C=882=E6=97=A5(=E5=91=A8=E4=B8=80) 04:29</div><div style=3D"clear:bot=
h">=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9ADimon&lt;<a href=3D"mailto:dimon.zha=
o@nebula-matrix.com" target=3D"_blank" rel=3D"noreferrer">dimon.zhao@nebula=
-matrix.com</a>&gt;</div><div style=3D"clear:both">=E6=8A=84=E3=80=80=E9=80=
=81=EF=BC=9Adev&lt;<a href=3D"mailto:dev@dpdk.org" target=3D"_blank" rel=3D=
"noreferrer">dev@dpdk.org</a>&gt;; stable&lt;<a href=3D"mailto:stable@dpdk.=
org" target=3D"_blank" rel=3D"noreferrer">stable@dpdk.org</a>&gt;; Kyo Liu&=
lt;<a href=3D"mailto:kyo.liu@nebula-matrix.com" target=3D"_blank" rel=3D"no=
referrer">kyo.liu@nebula-matrix.com</a>&gt;; Leon&lt;<a href=3D"mailto:leon=
.yu@nebula-matrix.com" target=3D"_blank" rel=3D"noreferrer">leon.yu@nebula-=
matrix.com</a>&gt;; Sam&lt;<a href=3D"mailto:sam.chen@nebula-matrix.com" ta=
rget=3D"_blank" rel=3D"noreferrer">sam.chen@nebula-matrix.com</a>&gt;; Step=
hen Hemminger&lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_b=
lank" rel=3D"noreferrer">stephen@networkplumber.org</a>&gt;</div><div style=
=3D"clear:both">=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [PATCH v3 1/1] net/=
nbl: fix issues reported by Coverity</div><div style=3D"clear:both"><br></d=
iv>21/01/2026 05:36, Stephen Hemminger:<br>&gt; On Wed, 14 Jan 2026 19:27:4=
4 -0800<br>&gt; Dimon Zhao &lt;<a href=3D"mailto:dimon.zhao@nebula-matrix.c=
om" target=3D"_blank" rel=3D"noreferrer">dimon.zhao@nebula-matrix.com</a>&g=
t; wrote:<br>&gt; <br>&gt; &gt; Address multiple issues reported by Coverit=
y static analysis:<br>&gt; &gt; <br>&gt; &gt; Check return values of ioctl(=
) calls for NBL_DEV_USER_GET_BAR_SIZE<br>&gt; &gt; and NBL_DEV_USER_CLEAR_E=
VENTFD. The original code tested the return<br>&gt; &gt; value without capt=
uring it from the ioctl call.<br>&gt; &gt; <br>&gt; &gt; Move debug log sta=
tement after NULL pointer validation in<br>&gt; &gt; nbl_dev_configure() to=
 prevent dereference of adapter before the<br>&gt; &gt; check.<br>&gt; &gt;=
 <br>&gt; &gt; Cast u16 operands to u64 before multiplication when calculat=
ing<br>&gt; &gt; buffer sizes and offsets to prevent potential integer over=
flow.<br>&gt; &gt; The num_txq_entries, num_rxq_entries, txq_buf_size, and =
rxq_buf_size<br>&gt; &gt; fields are all u16 types, and their product could=
 overflow before<br>&gt; &gt; assignment to size_t or u64 destination varia=
bles.<br>&gt; &gt; <br>&gt; &gt; Coverity issue: 490942<br>&gt; &gt; Coveri=
ty issue: 490943<br>&gt; &gt; Coverity issue: 490946<br>&gt; &gt; Coverity =
issue: 490947<br>&gt; &gt; Coverity issue: 490949<br>&gt; &gt; Coverity iss=
ue: 490950<br>&gt; &gt; Coverity issue: 490951<br>&gt; &gt; Coverity issue:=
 490952<br>&gt; &gt; Coverity issue: 490953<br>&gt; &gt; Coverity issue: 49=
0954<br>&gt; &gt; Coverity issue: 490955<br>&gt; &gt; Coverity issue: 49095=
7<br>&gt; &gt; Coverity issue: 490958<br>&gt; &gt; Coverity issue: 490959<b=
r>&gt; &gt; Fixes: a1c5ffa13b2c (&quot;net/nbl: add channel layer&quot;)<br=
>&gt; &gt; Fixes: dc955cd24c8f (&quot;net/nbl: add coexistence mode&quot;)<=
br>&gt; &gt; Fixes: 93b38df5a2ec (&quot;net/nbl: support basic configuratio=
n&quot;)<br>&gt; &gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_bla=
nk" rel=3D"noreferrer">stable@dpdk.org</a><br>&gt; &gt; <br>&gt; &gt; Signe=
d-off-by: Dimon Zhao &lt;<a href=3D"mailto:dimon.zhao@nebula-matrix.com" ta=
rget=3D"_blank" rel=3D"noreferrer">dimon.zhao@nebula-matrix.com</a>&gt;<br>=
&gt; <br>&gt; Queued to next-net<br><br>After another look, I think it dese=
rves to be split per type of issue.<br>Maybe 3 commits?<br></div></blockquo=
te><div style=3D"line-height:20px;clear:both"><br></div></div></div></block=
quote></div>

--000000000000c3f9490649e5e8fb--
