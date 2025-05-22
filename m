Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A49C54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 11:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 038B4402D1;
	Thu, 22 May 2025 13:04:53 +0200 (CEST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44]) by mails.dpdk.org (Postfix) with ESMTP id 1B17140144
 for <dev@dpdk.org>; Thu, 22 May 2025 04:45:26 +0200 (CEST)
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-875b8e006f8so2110064241.0
 for <dev@dpdk.org>; Wed, 21 May 2025 19:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747881925; x=1748486725; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4miqewFuR94tYynevwTvBygbzHl08rz+CQi8cN/4sm4=;
 b=FrCnTohCoDGTP5eAk2+QsaXtqST1mSaFQ/A7gtHEEP6nLQb0t5Cg43wd9jhjO0rUS0
 3tS8Njx713T9nVvVbAVLdRF1KtaDbodt13bEPKTymPV1WBxgXuCXWnLQrLDLQ+Bi/Qnd
 j6EqaqT8MS9pty2DHC5QR7tm37RWHdktoRP9UMk8rZjegM26keBvnFWj2UkhS159o4uQ
 jmGUQvxsXjuxjmz/ywTtMdE8wGdiTZ8Np+0xLVhmF9eQgDjEb+FlJvFli444HF0Fby2e
 iSrwrD1MiABRa3DS8w6q9izgGeLcbxK70mYt7slAq5Rtc2vPQq4iZY5w2xQWKEygfyQ7
 RVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747881925; x=1748486725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4miqewFuR94tYynevwTvBygbzHl08rz+CQi8cN/4sm4=;
 b=HeHiBxPZPlQT0wT1fk6F2NopGhSPtDKktkn9lBcOp8waeuUnjww/IK3w6KGCXRdQE8
 4cWQVfATxo411c0JGBal+GwOIV6PIqKZNs0a1U5DPw/grg4Mq9wNpRF5DY33xwXaYZQ/
 c9T7W2B6z3qoACdtNXL8YMCZNKiUf35OnZFMu/7qA268Amndf5eVqW1TjWglNLsvJWI8
 R1ytqBJCpBmJHWFQsaxIU6QrC7Gxuzao47dPD2eKN0wNp205yHummDE79YOvRgtceM8b
 NcEwYUTARi39wnZoZSc2CrfU47fU4XlNILt2i6RCA9Uyg6urPLu2vuKRLj2eIQTAWY5C
 bPkQ==
X-Gm-Message-State: AOJu0YyNjmUu0TbzDQoD3ANxqm8g9wVbZOBv5K9oPiwXn7AejTclp9Gz
 YSfwclKO0pR00QVgkrbabTgHWir/BHA0G5IMasR+CAc+xk/aZi7jDdkYcuan5AsDWbmXgT3+Xyy
 bs8fb0nofQbB/ASMx+W4aRAq7cv7Ngsg=
X-Gm-Gg: ASbGncs6KyVvys3S/C7Pn5wZvip92fc6I7zWR7ePLhuuGfwp1Tbm9YEvcdG4osPVwkG
 GciKjWURzFLbI9sUxjUtUJgYjGPRs+YZIjaVYEigoOJ0lnioSghNEGKKkfoxMcAR6N0cK93P4Vq
 UkRJNKE6nAkhkMMYKP9gcy+wEUEhfg6R1r
X-Google-Smtp-Source: AGHT+IEXrmwe59cqKpQcblgbyZUhkAm5e0A7OIJKiId1siCJANb2AsYz99rJF4pQFJyCcDGH4KBXBZIpx8xcoNPoiGk=
X-Received: by 2002:a05:6102:4194:b0:4b6:5e0f:6ddc with SMTP id
 ada2fe7eead31-4dfa6bc7682mr20242784137.14.1747881925148; Wed, 21 May 2025
 19:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+xuiv2jL934JR_QyLC1M5A+5dGPzw5L0=4RoS98eRjueA+9-g@mail.gmail.com>
 <20250521071845.50d6f9e1@hermes.local>
In-Reply-To: <20250521071845.50d6f9e1@hermes.local>
From: farooq basha <farooq.juturu@gmail.com>
Date: Thu, 22 May 2025 08:15:14 +0530
X-Gm-Features: AX0GCFvZtW7Pss4DU-HxZVexqkydNTMgFHkpeOeN8FI2CYjnEXZsS2C0O99bOCg
Message-ID: <CA+xuiv0gKOp=Ukd=Nd-b=CV3YvA8P+HpR3PiH4h+9Dus9-vK1g@mail.gmail.com>
Subject: Re: [dpdk-dev] Regarding HQOS with run-to-completion Model
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000004208a50635b079e1"
X-Mailman-Approved-At: Thu, 22 May 2025 13:04:52 +0200
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

--0000000000004208a50635b079e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Stephen for addressing my queries , and it is helpful.

    One more follow up question on the same ,   Can DPDK HQOS be customized
based on Use case ?

    For example: Hqos config for one of the use cases ,  *One Port , One
Subport , 16 Pipes & Each Pipe with only one TC*.
                         16 pipe config was allowed but changing the 13TCs
to 1TC is not allowed per Pipe.

    Can I still use 13 TCs but use the QueueSize as 0, Can that impact
performance ?


Thanks
Farooq.J



On Wed, May 21, 2025 at 7:48=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Mon, 28 Apr 2025 16:55:07 +0530
> farooq basha <farooq.juturu@gmail.com> wrote:
>
> > Hello DevTeam,
> >
> >     I am planning to use DPDK HQOS for Traffic shaping with a
> > run-to-completion Model. While I was reading the dpdk-qos document, I
> came
> > across the following statement.
> >
> > "*Running enqueue and dequeue operations for the same output port from
> > different cores is likely to cause significant impact on scheduler=E2=
=80=99s
> > performance and it is therefore not recommended"*
> >
> >  Let's take an  example, Port1  & Port2 have 4 Rx queues and each Queue
> > mapped to a different CPU. Traffic coming on port1  gets forwarded to
> port2
> > . With the above limitation application needs to take a lock before doi=
ng
> > rte_sched_port_enqueue & dequeue operation. Performance is limited to
> only
> > 1 CPU even though Traffic is coming on 4 Different CPUs.
> >
> > Correct me if my understanding is Wrong?
> >
> > Thanks
> > Basha
>
> The HQOS code is not thread safe so yes you need a lock.
> The traffic scheduling (QOS) needs to be at last stage of the pipeline ju=
st
> before mbufs are passed to the device.
>
> The issue is that QOS is single threaded, so lock is required.
>
> The statement is misleading, the real overhead is the lock; the secondary
> overhead is the cache miss that will happen if processing on different
> cores.
> But if you are doing that you are going to cut performance a lot from cac=
he
> misses.
>

--0000000000004208a50635b079e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Stephen for addressing my queries , and it is helpf=
ul.=C2=A0<div>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 One more follow u=
p question on the same ,=C2=A0 =C2=A0Can DPDK HQOS be customized based on U=
se case ?</div><div>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 For example=
: Hqos config for one of the use cases ,=C2=A0 <b>One Port , One Subport , =
16 Pipes &amp; Each Pipe with only one TC</b>.</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A016=
 pipe=C2=A0config was allowed but changing the 13TCs to 1TC is not allowed =
per Pipe.</div><div>=C2=A0</div><div>=C2=A0 =C2=A0 Can I still use 13 TCs b=
ut use the QueueSize as 0, Can that impact performance ?=C2=A0 =C2=A0</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>=C2=A0 =C2=A0=C2=A0</div><div>Thanks<=
/div><div>Farooq.J</div><div>=C2=A0</div><div>=C2=A0=C2=A0</div></div><br><=
div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"g=
mail_attr">On Wed, May 21, 2025 at 7:48=E2=80=AFPM Stephen Hemminger &lt;<a=
 href=3D"mailto:stephen@networkplumber.org">stephen@networkplumber.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mo=
n, 28 Apr 2025 16:55:07 +0530<br>
farooq basha &lt;<a href=3D"mailto:farooq.juturu@gmail.com" target=3D"_blan=
k">farooq.juturu@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Hello DevTeam,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I am planning to use DPDK HQOS for Traffic shaping =
with a<br>
&gt; run-to-completion Model. While I was reading the dpdk-qos document, I =
came<br>
&gt; across the following statement.<br>
&gt; <br>
&gt; &quot;*Running enqueue and dequeue operations for the same output port=
 from<br>
&gt; different cores is likely to cause significant impact on scheduler=E2=
=80=99s<br>
&gt; performance and it is therefore not recommended&quot;*<br>
&gt; <br>
&gt;=C2=A0 Let&#39;s take an=C2=A0 example, Port1=C2=A0 &amp; Port2 have 4 =
Rx queues and each Queue<br>
&gt; mapped to a different CPU. Traffic coming on port1=C2=A0 gets forwarde=
d to port2<br>
&gt; . With the above limitation application needs to take a lock before do=
ing<br>
&gt; rte_sched_port_enqueue &amp; dequeue operation. Performance is limited=
 to only<br>
&gt; 1 CPU even though Traffic is coming on 4 Different CPUs.<br>
&gt; <br>
&gt; Correct me if my understanding is Wrong?<br>
&gt; <br>
&gt; Thanks<br>
&gt; Basha<br>
<br>
The HQOS code is not thread safe so yes you need a lock.<br>
The traffic scheduling (QOS) needs to be at last stage of the pipeline just=
<br>
before mbufs are passed to the device.<br>
<br>
The issue is that QOS is single threaded, so lock is required. <br>
<br>
The statement is misleading, the real overhead is the lock; the secondary<b=
r>
overhead is the cache miss that will happen if processing on different core=
s.<br>
But if you are doing that you are going to cut performance a lot from cache=
<br>
misses.<br>
</blockquote></div>

--0000000000004208a50635b079e1--
