Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77FCCAC582
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 05:59:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B273C40658;
	Fri, 12 Sep 2025 07:59:57 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 56B97402D4
 for <dev@dpdk.org>; Fri, 12 Sep 2025 07:59:56 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-81f9cfa70deso106041585a.1
 for <dev@dpdk.org>; Thu, 11 Sep 2025 22:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757656796;
 x=1758261596; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ak2aE0J8X3sGkGV50B1OuA0LkEFwcTaCPXMlio2fep8=;
 b=KWpeM8FSyCoQgktfvLLG5bT8jy86BI8pAtVoLxa+1ijkAA+Nq1JJTN8MYwyfv6qXBS
 U38xt0cKAXZQqlqZd1ESWAy0N++sMYGGlma2uYK1LzkBKSNECkgBbrC3X0CsfwbCQTjB
 tIxsrj0Szpo5nZbLZ1MoyQDAW1L8LrPNOCn0u4883v4I4sdCUto2a03vhDLpSqMbef1f
 ejYnUOnWIyvKzTBJEu8M54isM+9wv8fSH3WJxT/fsPIDiAXKBjZaa4NIsC/sPyfR7+5Q
 SPLJLZr7V+GujxibHuv1MJt4VYuGz/AcwIlBLmkRDYWebdORsR3CHKPpAAruWNDWhfk9
 qIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757656796; x=1758261596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ak2aE0J8X3sGkGV50B1OuA0LkEFwcTaCPXMlio2fep8=;
 b=UW7KHRe/pqIS9iZT4D969XZu03JBBXtcw15P0CXRBtZuKLWBG3r4kmR1kl7ZWmBARG
 DpJjoeiLRydkMUSQwpS13H+L2qNEyCw/I39D89JualpEIyuZpiYkEInAcbZUOqgQPfPO
 XLzda+JGTLNfe0eS8zcTsHrwvcEjJZkGYBHkrho0dnyrKiNv/vjdeigcRz23ivF7Jbt6
 7tfJL4yEIBDzCHzUoWfdc5XfbJ6XRnt1i/fNqEW8mQIsX/ZFxckLMO8jO+QCY1O1moov
 mVny7BwJ8eMN9t8qwNT8FJxn5C1cjz4V7jan36XrD5giJ+JBSUg0QwIvC8/XAxCGXtcp
 0m8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqVjQImhp2+Isnzk+n1PAFOdo0a/1bBqqnfGf2sINvTn6RXkJKxmRvqcc0221QaTryPpQ=@dpdk.org
X-Gm-Message-State: AOJu0Yyytu2PSOxRaSsoojlUEhBdy5MmIGu3bwv/nPY9mhTvnST9NMwt
 g2bVrXaJdEq9O9lsNhD7LZ5cASjy0VV4G/HFkhk1dCRFjT8xPjG2w/5P90aFQuR0HsNLYIdN0e0
 49hKJ68RaO9kbyZWpL6E9QZapelmPb0nzgIPxso4FIQ==
X-Gm-Gg: ASbGncsubGsAXDTRMSpkQ20+Wm2SyfVoo0xpxdgRgUzcODI7urKZLTcAZwRdPPf+JRQ
 hWFZgdlmg8lj3fnWoWkiH1HwFE0kvA3PZl9BjVgOKxPGKdPpJ3M4Qy8KT3aF4JNJGFsw3qBo75D
 BrKITCCWJ3YPn+ZHH36ixQ1DgsxEFxMAvxHwzMSGUlhcdGBw3cHfAYdq2GlNETszt71occbmRuM
 5NiTUqkgl0E7V3t4aKVK16q4GLRhOqgSdlfKeOL6hy1JmV06mOkhr0p+dh+tY4Ef/XdI/2rRto+
 2qEwJPHgBdvD8oiNaGRMy2kD
X-Google-Smtp-Source: AGHT+IHCJcIoUx/SvVhucpQ8kHp4lXy38YWOXibzudXyaWe56Jq5XBlJqVKon7N2Dye4VId61mkxyf501+y2WY0XQAY=
X-Received: by 2002:a05:620a:7101:b0:815:c19f:d140 with SMTP id
 af79cd13be357-823fa3f8f50mr268179985a.19.1757656795620; Thu, 11 Sep 2025
 22:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911102501.473167-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250911165058.31fd0101@hermes.local>
 <CA++2-x5zZJaa_FcX8dzg13Pvmh1gSosmg-xmzAQVL2d51Yrisw@mail.gmail.com>
In-Reply-To: <CA++2-x5zZJaa_FcX8dzg13Pvmh1gSosmg-xmzAQVL2d51Yrisw@mail.gmail.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Fri, 12 Sep 2025 10:59:43 +0500
X-Gm-Features: AS18NWBjVtToM-sIvd2TvaCtaklmQkmE76qRKfwACBdeABX7Di87unUcVWoyvwQ
Message-ID: <CA++2-x76rDc-jF3goTY55mf_7oxxFNsNE36nDFfC+n=DMq9L4w@mail.gmail.com>
Subject: Re: [PATCH v2] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Aman Singh <aman.deep.singh@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>, Lijun Ou <oulijun@huawei.com>, 
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000f0b508063e945cca"
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

--000000000000f0b508063e945cca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 8:27=E2=80=AFAM Khadem Ullah <14pwcse1224@uetpeshaw=
ar.edu.pk>
wrote:

> Hi Stephen,
>
> On Fri, Sep 12, 2025, 04:51 Stephen Hemminger <stephen@networkplumber.org=
>
> wrote:
>
>>
>> Ok, the Windows #ifdef was confusing me then looked more closely.
>> This patch is adding a set of rings so that primary and secondary
>> can communicate, the adding one command.
>>
>> The idea is good, but there is a better way to handle this.
>> There already exists a way for primary and secondary to communicate
>> through the mp service. This is used for hotplug and pdump and probably
>> other things as well.
>>
> Yeah, agree. Testpmd have also hutplug callbacks, I have tried that too,
> but it is in lower layer to call any stopping fwd_engines.
>
>>
>> The communication can be either way, for example I proposed patches
>> to pdump so that primary can tell secondary to participate.
>>
>>
>> https://patchwork.dpdk.org/project/dpdk/patch/20250814165307.12786-7-ste=
phen@networkplumber.org/
>>
>> This of testpmd can be done in similar way.
>> The handler in secondary should be able to act same as
>> when SIGINT is received. Set the flag f_exit which will cause the main
>> loop to exit.
>>
>> This can then happen immediately, and the proc monitor alarm function
>> is only then needed to handle when primary process crashes.
>>
> Yeah, we can try that, my only concern is that if it can handle and stop
> any numbers of secondary processes fwd_engines as the current solution ca=
n
> stop.
>
> Please check the __handle_primary_request in
https://elixir.bootlin.com/dpdk/v25.07/source/lib/eal/common/hotplug_mp.c#L=
225
,
testpmd is calling this api during hutplug callbacks.
I had tried a similar one as proposed in pdump but could not call
stop_packet_forwarding from this lower layer as given below.
There is only eal_bus_cleanup(), and local_dev_remove support. We only left
with the ring solution
to used if for IPC as in
https://elixir.bootlin.com/dpdk/v25.07/source/examples/multi_process/simple=
_mp/main.c#L75


git diff
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 0f58a31eb5..9155453efa 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -72,6 +72,7 @@
 #endif
 #ifdef RTE_NET_MLX5
 #include "mlx5_testpmd.h"
+#include "hotplug_mp.h"
 #endif

 #include "testpmd.h"
@@ -3634,6 +3635,11 @@ pmd_test_exit(void)
                        printf("\nStopping port %d...\n", pt_id);
                        fflush(stdout);
                        stop_port(pt_id);
+                       printf("Stopping secondary process...\n");
+                       struct eal_dev_mp_req req;
+                       memset(&req, 0, sizeof(req));
+                       req.t =3D ETH_REQ_STOP; //EAL_DEV_REQ_TYPE_DETACH;
+                       eal_dev_hotplug_request_to_secondary(&req);
                }
                RTE_ETH_FOREACH_DEV(pt_id) {
                        printf("\nShutting down port %d...\n", pt_id);
diff --git a/lib/eal/common/hotplug_mp.c b/lib/eal/common/hotplug_mp.c
index 17089ca3db..d324db428f 100644
--- a/lib/eal/common/hotplug_mp.c
+++ b/lib/eal/common/hotplug_mp.c
@@ -239,6 +239,11 @@ static void __handle_primary_request(void *param)
        memset(&mp_resp, 0, sizeof(mp_resp));

        switch (req->t) {
+       case ETH_REQ_STOP:
+               printf("__handle_secondary_request called "
+                       "for secondary processes fwd_engine stopping...\n")=
;
+               //eal_bus_cleanup();
+               break;
        case EAL_DEV_REQ_TYPE_ATTACH:
        case EAL_DEV_REQ_TYPE_DETACH_ROLLBACK:
                ret =3D local_dev_probe(req->devargs, &dev);
diff --git a/lib/eal/common/hotplug_mp.h b/lib/eal/common/hotplug_mp.h
index 7221284286..7a46285994 100644
--- a/lib/eal/common/hotplug_mp.h
+++ b/lib/eal/common/hotplug_mp.h
@@ -19,6 +19,7 @@ enum eal_dev_req_type {
        EAL_DEV_REQ_TYPE_DETACH,
        EAL_DEV_REQ_TYPE_ATTACH_ROLLBACK,
        EAL_DEV_REQ_TYPE_DETACH_ROLLBACK,
+       ETH_REQ_STOP,
 };

--000000000000f0b508063e945cca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 12,=
 2025 at 8:27=E2=80=AFAM Khadem Ullah &lt;<a href=3D"mailto:14pwcse1224@uet=
peshawar.edu.pk">14pwcse1224@uetpeshawar.edu.pk</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div>Hi=C2=
=A0Stephen,<br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Fri, Sep 12, 2025, 04:51 Stephen Hemminger &lt;<a href=3D"mailt=
o:stephen@networkplumber.org" target=3D"_blank">stephen@networkplumber.org<=
/a>&gt; wrote:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Ok, the Windows #ifdef was confusing me then looked more closely.<br>
This patch is adding a set of rings so that primary and secondary<br>
can communicate, the adding one command.<br>
<br>
The idea is good, but there is a better way to handle this.<br>
There already exists a way for primary and secondary to communicate<br>
through the mp service. This is used for hotplug and pdump and probably<br>
other things as well.<br></blockquote></div></div><div dir=3D"auto">Yeah, a=
gree. Testpmd have also hutplug callbacks, I have tried that too, but it is=
 in lower layer to call any stopping fwd_engines.=C2=A0</div><div dir=3D"au=
to"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><br>
The communication can be either way, for example I proposed patches<br>
to pdump so that primary can tell secondary to participate.<br>
<br>
<a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/20250814165307.127=
86-7-stephen@networkplumber.org/" rel=3D"noreferrer noreferrer" target=3D"_=
blank">https://patchwork.dpdk.org/project/dpdk/patch/20250814165307.12786-7=
-stephen@networkplumber.org/</a><br>
<br>
This of testpmd can be done in similar way.<br>
The handler in secondary should be able to act same as<br>
when SIGINT is received. Set the flag f_exit which will cause the main<br>
loop to exit.<br>
<br>
This can then happen immediately, and the proc monitor alarm function<br>
is only then needed to handle when primary process crashes.<br></blockquote=
></div></div><div dir=3D"auto">Yeah, we can try that, my only concern is th=
at if it can handle and stop any numbers of secondary processes fwd_engines=
 as the current solution can stop.=C2=A0</div><div dir=3D"auto"><br></div><=
/div></blockquote><div>Please check the __handle_primary_request in=C2=A0<a=
 href=3D"https://elixir.bootlin.com/dpdk/v25.07/source/lib/eal/common/hotpl=
ug_mp.c#L225">https://elixir.bootlin.com/dpdk/v25.07/source/lib/eal/common/=
hotplug_mp.c#L225</a>,=C2=A0</div><div>testpmd is calling this api during=
=C2=A0hutplug callbacks.=C2=A0<br></div><div>I had tried a similar=C2=A0one=
 as proposed in pdump but could not call stop_packet_forwarding from this l=
ower layer as given below.=C2=A0</div><div>There is only eal_bus_cleanup(),=
 and=C2=A0local_dev_remove=C2=A0support. We only left with the ring solutio=
n</div><div>to used if for IPC as in=C2=A0<a href=3D"https://elixir.bootlin=
.com/dpdk/v25.07/source/examples/multi_process/simple_mp/main.c#L75">https:=
//elixir.bootlin.com/dpdk/v25.07/source/examples/multi_process/simple_mp/ma=
in.c#L75</a></div><div><br><br></div><div>git diff <br>diff --git a/app/tes=
t-pmd/testpmd.c b/app/test-pmd/testpmd.c<br>index 0f58a31eb5..9155453efa 10=
0644<br>--- a/app/test-pmd/testpmd.c<br>+++ b/app/test-pmd/testpmd.c<br>@@ =
-72,6 +72,7 @@<br>=C2=A0#endif<br>=C2=A0#ifdef RTE_NET_MLX5<br>=C2=A0#inclu=
de &quot;mlx5_testpmd.h&quot;<br>+#include &quot;hotplug_mp.h&quot;<br>=C2=
=A0#endif<br>=C2=A0<br>=C2=A0#include &quot;testpmd.h&quot;<br>@@ -3634,6 +=
3635,11 @@ pmd_test_exit(void)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;\nStopping port %d.=
..\n&quot;, pt_id);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fflush(stdout);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_port(pt_id=
);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 printf(&quot;Stopping secondary process...\n&quot;);<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stru=
ct eal_dev_mp_req req;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;req, 0, sizeof(req));<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eq.t =3D ETH_REQ_STOP; //EAL_DEV_REQ_TYPE_DETACH;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eal_dev_hotplug_re=
quest_to_secondary(&amp;req);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
RTE_ETH_FOREACH_DEV(pt_id) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;\nShutting down port=
 %d...\n&quot;, pt_id);<br>diff --git a/lib/eal/common/hotplug_mp.c b/lib/e=
al/common/hotplug_mp.c<br>index 17089ca3db..d324db428f 100644<br>--- a/lib/=
eal/common/hotplug_mp.c<br>+++ b/lib/eal/common/hotplug_mp.c<br>@@ -239,6 +=
239,11 @@ static void __handle_primary_request(void *param)<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 memset(&amp;mp_resp, 0, sizeof(mp_resp));<br>=C2=A0<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (req-&gt;t) {<br>+ =C2=A0 =C2=A0 =C2=A0 =
case ETH_REQ_STOP:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr=
intf(&quot;__handle_secondary_request called &quot;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;for secon=
dary processes fwd_engine stopping...\n&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 //eal_bus_cleanup();<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 case EAL_=
DEV_REQ_TYPE_ATTACH:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 case EAL_DEV_REQ_TYPE_D=
ETACH_ROLLBACK:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ret =3D local_dev_probe(req-&gt;devargs, &amp;dev);<br>diff --git a/lib/eal=
/common/hotplug_mp.h b/lib/eal/common/hotplug_mp.h<br>index 7221284286..7a4=
6285994 100644<br>--- a/lib/eal/common/hotplug_mp.h<br>+++ b/lib/eal/common=
/hotplug_mp.h<br>@@ -19,6 +19,7 @@ enum eal_dev_req_type {<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 EAL_DEV_REQ_TYPE_DETACH,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 EAL_=
DEV_REQ_TYPE_ATTACH_ROLLBACK,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 EAL_DEV_REQ_TY=
PE_DETACH_ROLLBACK,<br>+ =C2=A0 =C2=A0 =C2=A0 ETH_REQ_STOP,<br>=C2=A0};<br>=
<br>=C2=A0</div></div><div><br clear=3D"all"></div><br></div>

--000000000000f0b508063e945cca--
