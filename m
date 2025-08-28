Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7566ECA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 15:18:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84C9B4025A;
	Thu, 28 Aug 2025 17:18:08 +0200 (CEST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id A5490400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 17:18:06 +0200 (CEST)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-619487c8865so4217061a12.1
 for <dev@dpdk.org>; Thu, 28 Aug 2025 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756394286; x=1756999086; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MAPs6Rhevapyk+NwRYx85qvTAPj3CCSbcGh4/TLLhUY=;
 b=bjkGiEh6jVS5anubrse0kq28wqcUW64Tws/H8Kw7TESomm7hEKeQPkFPrc/sb9zU82
 GTF59XBYvCgzomvoSCzEcCSuFX+UkLRaIrUK+kRztBJz1hj7VgfcmTEii3S3vWrRNfnK
 YvDItBp3JrL2MY6iCkqaLqwcuWtb99neQX8+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394286; x=1756999086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MAPs6Rhevapyk+NwRYx85qvTAPj3CCSbcGh4/TLLhUY=;
 b=fZtmtoIOeNR85gkYozGoiRu2taNuPvzmUgKEMcb9Zt8chWRC5S1WWldg17Xu0zyafb
 wcbaYtJkHpEQU9TDrNqMrva827r+WntbMMADSBV39xUyRv8mRoIIEHRTxsyyYOe0VuuI
 Npkl4Ql0960hmMpJOAU5u1w9KVsO1TNwvOFCyZaLfZJ0HV1yyqqCpkQO4yMYBjJlpsjb
 0V+VaA1WgD43rqS9x5gKIrLYzdcTMNVyTlM3tm7LzjwJGj9ZST9K0ByxATzk4gntXzIf
 436jGGwl6YTFo9VSIfnjjVyXmMpV74DDuK3y2ObkMobiHP7EDXubNMp6tKW32KbUWlyG
 m4gw==
X-Gm-Message-State: AOJu0Yy+BgWs9GC4tdpCsFSh//3VTjdm8OZObd+wR7limmCEiwRaw0l3
 nPq1b5PhreFjSUWC66K4HBG1qUbdfabV0pFFmP6CE5HOF07jwfOYxTsytvw+g0rAT0USo34wChk
 /r0zp6urXyV+QNfd55mRvjS60IBdQCIGIA42r1FUZQA==
X-Gm-Gg: ASbGnctk3GjMSPZ+IZi4K2BXyklPMNf9V/nNqHXhtldmlqFKa23HlrRgPDVmJOd1NmS
 YODbi75rBa8i414xr0K5AxYbbCDttIDa7n2ULrBvYGjdk1srHDcJmrzmB6LHjSDwqLtLNTSvT1P
 lDPPcEMXtPyfM+DxK+Bu+R3qmhEv8zv+YHcBU5NFLRAgyUOmLKLKErXJoCHKJanxECCxoqttUrR
 mT0V8/s
X-Google-Smtp-Source: AGHT+IGycJqsf2NH593kN2FtynWV8Vu84ph6lgkQ03YKKzDAs8JMLqQ2Pvmkvjj3XgTdHU98nduYEp0b7XUeoQ8K6n8=
X-Received: by 2002:a05:6402:90e:b0:61c:931d:ccce with SMTP id
 4fb4d7f45d1cf-61c983b81d2mr7450374a12.13.1756394286205; Thu, 28 Aug 2025
 08:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250808182152.356879-2-abailey@iol.unh.edu>
 <20250828123758.20451-1-abailey@iol.unh.edu>
 <175638514815.25987.9964104140534837687.luca.vizzarro@arm.com>
In-Reply-To: <175638514815.25987.9964104140534837687.luca.vizzarro@arm.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 28 Aug 2025 11:17:55 -0400
X-Gm-Features: Ac12FXz2aCoKYS-bkyKJW5_XUgzYOQXq9Ch9_IOvuIaG1wymrW8uvVNJ6oL51pQ
Message-ID: <CABJ3N2UY2N3dGL-Zj97RX5Vqs8pNcCHugUbCG=QmQeT_52CU=g@mail.gmail.com>
Subject: Re: [PATCH v3] dts: enable port binding on the TG
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000083e5ae063d6e6979"
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

--00000000000083e5ae063d6e6979
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Luca for the feedback,

Future version patches will be in-reply-to the v1. From v2, the only thing
that has changed is the body of the method is_bound_for_dpdk in ports.py.
Before, it would check if the current driver was the same as the dpdk
driver which is inaccurate for the TG node using mellanox cards. This patch
adds coverage for TG's using mellanox cards in this method.

On Thu, Aug 28, 2025 at 8:50=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:

> Hi Andrew,
>
> I see you've made a bit of a mess with the versioning. v2 was detached
> from the thread, so this is confusing me. Can you make sure that (as per
> contributing guidelines):
> - you always reply with new patches to the very beginning of the thread
>   (usually the cover letter of v1 =E2=80=93 if it was a single patch, the=
n a
>   reply to that patch)
> - you add a cover letter to your patch series explaining your changes
>   across versions. You can check other emails in the mailing list to
>   gather an understanding of this. Of course, if you are sending a
>   single patch, a cover letter is not necessary, but you'll need to
>   annotate your patch (the contributing guidelines who how this is done)
>
> Finally, I cannot tell easily tell what changed from v2. Can you please
> give a summary of the changes?
>
> Best,
> Luca
>

--00000000000083e5ae063d6e6979
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thank you Luca for the feedback,</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Future version patches will be in-reply-to the v=
1. From v2, the only thing that has changed is the body of the method is_bo=
und_for_dpdk=C2=A0in ports.py. Before,=C2=A0it would check if the current d=
river was the same as the dpdk driver which is inaccurate for the TG node u=
sing mellanox cards. This patch adds coverage for TG&#39;s using mellanox c=
ards in this method.</div><div><br><div class=3D"gmail_quote gmail_quote_co=
ntainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 28, 2025 at 8:50=
=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com">luca=
.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:=
solid;padding-left:1ex;border-left-color:rgb(204,204,204)">Hi Andrew,<br>
<br>
I see you&#39;ve made a bit of a mess with the versioning. v2 was detached<=
br>
from the thread, so this is confusing me. Can you make sure that (as per<br=
>
contributing guidelines):<br>
- you always reply with new patches to the very beginning of the thread<br>
=C2=A0 (usually the cover letter of v1 =E2=80=93 if it was a single patch, =
then a<br>
=C2=A0 reply to that patch)<br>
- you add a cover letter to your patch series explaining your changes<br>
=C2=A0 across versions. You can check other emails in the mailing list to<b=
r>
=C2=A0 gather an understanding of this. Of course, if you are sending a<br>
=C2=A0 single patch, a cover letter is not necessary, but you&#39;ll need t=
o<br>
=C2=A0 annotate your patch (the contributing guidelines who how this is don=
e)<br>
<br>
Finally, I cannot tell easily tell what changed from v2. Can you please<br>
give a summary of the changes?<br>
<br>
Best,<br>
Luca<br>
</blockquote></div></div>

--00000000000083e5ae063d6e6979--
