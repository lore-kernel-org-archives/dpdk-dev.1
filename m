Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD446EDF04C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 07:57:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7A114027A;
	Thu, 12 Feb 2026 08:57:07 +0100 (CET)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44]) by mails.dpdk.org (Postfix) with ESMTP id B8B2140268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 08:57:05 +0100 (CET)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-59e61e94e1bso1246195e87.0
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:57:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770883025; cv=none;
 d=google.com; s=arc-20240605;
 b=AI3K2YM5QTXMdSIteq8BpFNWMn+69knOuupNDa3j+7InKZoOT7vMWUg1EI67ajf2Nb
 0vmN5dBLkVwc6VjcHP9R7v77cCrlkd4Zm9z13zG6PoMGc6hiH+CRt4FewiShiJCAMnHq
 oG20beRiobMH8JoEtwnHPOFnr8N5lCMrkqP/R0uiAh8IfQ6aNZWaN5EYYRegFAmMFH89
 bjGZ52GTudoe8kATc4gKHYwJ5h/1sGmO4v2omyw9cTuJIkCQCUfQ72YP+vogcIXbD4ZK
 DY8iAAYrvYSzv4V6Su5t3N7E5+aqx4WX6YbXcbReBDhXnQG0QzFkVm68OHqh/7G2jRqR
 +bZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4+kiSRiVHovfNMQSs483Ofxq3TpFc/Rl999RImlR3ac=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=WWNNwSS20rrSnolx6aL7bI7xAznxG9iw0deZ1lXR+4XiAzPCLpIMD4yhWAyDRidY/k
 KWg8NWts3MHmIvaXSvqxlt43J9OTW1Tp6DgOBeTfz/5dstY8a8p15LTQL7wNe+LAjklS
 4wmMbtg0lXWgrYRNLmP+fDhFcOUVx58Isu9ShUXmMn9BkSn7EAraMSjVGXIupDmo3EGf
 WT+IU4CwgWxkC0jU1MIxfcPWj0BcnzcKvWvzgXUjMl+/uN9iNxrHnil4ewpl+TzXxmH9
 Xj3E8vNm0PUNg/hdSPFaakMLpO5Ft6db2nFeR5AL1dR25ddNlKOqM4kjSBnWtMTqb+lB
 y7oA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=i2i-systems-com.20230601.gappssmtp.com; s=20230601; t=1770883025;
 x=1771487825; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4+kiSRiVHovfNMQSs483Ofxq3TpFc/Rl999RImlR3ac=;
 b=xJbv5yTSHg1Yhnu6rkOX3Ym/s1pHIfT+/uIMJVat12wmoXOXTV5nWaGM3Ic0smeBKp
 B5X4xZ174Zy6iCp7pewo50tdCJEIUxe4uuEQpUtlAWjN1Z97kAFk84a4LfZ0AKHTMYDR
 c8Kfyf5fWKdc8y/NhhFl0g+7cz6peqYxYebsErzB7m2CkLGHDBq5WGGw8no0P9qQNgAe
 rrn+gG+juUpmmNxrv5bl5HXTwFCYRZT2BvDqTZGNyrFQyRXVDm/LXl39enw21JlzXYKn
 9QX82d4uQzMb3q4JCrgeDT1W3QtViyPMUdKPPKNIpwGcroGnb80MXObrt06EQxbUGFXG
 o+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770883025; x=1771487825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+kiSRiVHovfNMQSs483Ofxq3TpFc/Rl999RImlR3ac=;
 b=UmKCUQsCShCo4GyEOOSWTn38edBiTHkeY3Kmq9Z4tOnb3kCCV/Z93HDJ6OpU5h4coP
 m1RFWblzD0g3/mkm9VS/QPwrEqdoT8qyo6cDp0eOZGfIPN+7+cKwloHZXZwYxxrQ9wC1
 m0Jup9lNpb61Njb/tmp4Rw2gHbUSAqtdyEqnGxS5vlwhg7UjOvghNlwQyoZRfsaVyxRF
 By9Qya5AEYLRqNuml1F01VuuRrawihywW0K0PYBOsNXTHHxiHvbVDDIVTgpcYASeUbed
 zcHi/JShNB6wKceizfMB71XX6+tcX77cqh2z2LuS/9Ps+3czn0+S4KD8HltHoRpIOxw9
 TfJw==
X-Gm-Message-State: AOJu0YwAbEjYYuywyqb/2KTnqFsk6fCGfXa67lltxdV5rvcBtPKtbH4i
 K6Lwl5wZuHv6rjO/7WNB8GekH0eXGJ90D0cmhk4y4ngV5oxyElp+F44E2ovTik9Hhn6rUD2ybby
 E4Aj+PAkmVrnFkSSN2AfHK1sjRFQM8noTN96hTnlSPhDAoqAmkg9DhYf5G5sImPa/e3+iz2OZ5d
 UiTwiY/K8fp9MlHtZ7+C4XYB0=
X-Gm-Gg: AZuq6aJshneqrS2m4XKamdeAbTnAAUHsed2r6SB1wegt7RndCgJLWF9NeneQ0X3sNy5
 4QQ1HDhrl8e5ULTXC0d/JJyhBBDtE1od0f8DF64kY/rQeuG3/ZrLdsONekqWwM5F86hahYREawo
 Jg6AfBl35GvR1nMsRf7NgI7iO+N7vZxnEG01dnADqvfMtOKY4B7X0pPq+/FKwYE4TtbecDK8ol1
 ra5wUjtOTr+vavIwtwQYNzjUdYBSL86Y2r+ak8z/R6bN37HOE/YYNiuRe9avcTJ4cJUqIB8uh+H
 dxxwO/M=
X-Received: by 2002:a05:6512:2348:b0:59e:1813:76ae with SMTP id
 2adb3069b0e04-59e6415021dmr629982e87.44.1770883024860; Wed, 11 Feb 2026
 23:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
 <20260116154256.206571-1-kerem.aksu@i2i-systems.com>
 <20260211162325.0d96e524@phoenix.local>
In-Reply-To: <20260211162325.0d96e524@phoenix.local>
From: Kerem Aksu <kerem.aksu@i2i-systems.com>
Date: Thu, 12 Feb 2026 10:56:28 +0300
X-Gm-Features: AZwV_Qjig4416SkKTlYrVK0dlI1MKzr_LD34IqgiIzDH02qs9iA6yLfGwtu9ThY
Message-ID: <CAHqJCAm=4Xd0T0q8T8D8QM5iroQDt1h7X3VKGvnX-_xUjyc19g@mail.gmail.com>
Subject: Re: [PATCH v3] cmdline: update clear screen behavior
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000a34e4b064a9bd5c0"
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

--000000000000a34e4b064a9bd5c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Feb 2026 at 03:10, Stephen Hemminger <stephen@networkplumber.org=
>
wrote:

>     Release note entry is placed under "API Changes" but the public API
signature is unchanged =E2=80=94 this is a behavior change and may belong u=
nder a
different section.

I couldn't figure out where to put the release note and looked for similar
changes in previous releases.

>     Pre-existing missing spaces around operators (i=3D0 ;
i<rdl->prompt_size) in touched function =E2=80=94 good opportunity to clean=
 up.

I avoided changing style of a decade old code since I don't know how DPDK
wants to handle these situations.

> Applied to next-net after fixing the release note and rewording the
> commit message.

Your email got lost so I can only get back to you now. Thanks for the good
work.

--=20
Yasal Uyar=C4=B1:=C2=A0*Bu elektronik posta bu linki kullanarak ula=C5=9Fab=
ilece=C4=9Finiz=20
ko=C5=9Fullara tabidir:**=C2=A0**https://i2i-systems.com/email-disclaimer/=
=20
<http://i2i-systems.com/about-us/email-disclaimer/>*

--=20


--000000000000a34e4b064a9bd5c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 10 Feb 2026 at 0=
3:10, Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org">s=
tephen@networkplumber.org</a>&gt; wrote:</div><div dir=3D"ltr" class=3D"gma=
il_attr"><br>&gt; =C2=A0 =C2=A0 Release note entry is placed under &quot;AP=
I Changes&quot; but the public API signature is unchanged =E2=80=94 this is=
 a behavior change and may belong under a different section.</div><div dir=
=3D"ltr" class=3D"gmail_attr"><br></div><div dir=3D"ltr" class=3D"gmail_att=
r"><div>I couldn&#39;t figure out where to put the release note and looked =
for similar changes in previous releases.</div><br>&gt; =C2=A0 =C2=A0 Pre-e=
xisting missing spaces around operators (i=3D0 ; i&lt;rdl-&gt;prompt_size) =
in touched function =E2=80=94 good opportunity to clean up.</div><div dir=
=3D"ltr" class=3D"gmail_attr"><br></div><div dir=3D"ltr" class=3D"gmail_att=
r"><div>I avoided changing style of a decade old code since I don&#39;t kno=
w how DPDK wants to handle these situations.</div><div><br></div><div><div =
dir=3D"ltr" class=3D"gmail_attr">&gt; Applied to next-net after fixing the =
release note and rewording the<br>&gt; commit message.</div><div dir=3D"ltr=
" class=3D"gmail_attr"><br></div><div dir=3D"ltr" class=3D"gmail_attr"><div=
>Your email got lost so I can only get back to you now. Thanks for the good=
 work.</div></div><br></div></div></div></div></div></div>

<br>
<div><font size=3D"1"><font color=3D"#808080"><strong style=3D"font-family:=
&quot;Times New Roman&quot;,serif"><span style=3D"font-family:&quot;Trebuch=
et MS&quot;,sans-serif">Yasal Uyar=C4=B1:=C2=A0</span></strong><b style=3D"=
font-family:Arial,Helvetica,sans-serif"><strong style=3D"font-family:&quot;=
Trebuchet MS&quot;,sans-serif">Bu elektronik posta bu linki kullanarak ula=
=C5=9Fabilece=C4=9Finiz ko=C5=9Fullara tabidir:</strong></b></font><b><span=
 style=3D"font-weight:500;color:gray;font-family:&quot;Trebuchet MS&quot;,s=
ans-serif">=C2=A0</span></b><b><font color=3D"#0066cc" face=3D"Arial, sans-=
serif"><a href=3D"http://i2i-systems.com/about-us/email-disclaimer/" target=
=3D"_blank">https://i2i-systems.c<span></span><span></span><wbr>om/email-di=
sclaimer/</a></font></b></font></div>
<br>
<img src=3D"http://i2i-systems.com/wp-content/uploads/2025/12/MWC26MailBann=
er.png"><br>
--000000000000a34e4b064a9bd5c0--
