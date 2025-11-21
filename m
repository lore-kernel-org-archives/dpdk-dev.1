Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AF8CFC50F
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 22:48:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1AAD40280;
	Fri, 21 Nov 2025 23:48:30 +0100 (CET)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by mails.dpdk.org (Postfix) with ESMTP id 1355F40269
 for <dev@dpdk.org>; Fri, 21 Nov 2025 23:48:29 +0100 (CET)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-78802ac22abso27363147b3.3
 for <dev@dpdk.org>; Fri, 21 Nov 2025 14:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1763765308; x=1764370108; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pxRakzH+q7ZSNOZ59VO0GM0PdDKRYinRxEGgIFyBJT4=;
 b=QzEDGVzwwvShUcUFtjh73rbZsH6jRlUgHToz6Yy3KZkp3rU/qspQQ+KPT3vEGKqu23
 QEQHCw7V3QZsYbQ37V2f9PI9gNfwX+BoZQwZ9kg6f6jIHp22Ae3KSpnhPy5MJchm3i9e
 90UGRFQa/R25FaxJiIqVF1A22nBcBGooO3zEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763765308; x=1764370108;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pxRakzH+q7ZSNOZ59VO0GM0PdDKRYinRxEGgIFyBJT4=;
 b=cw41zgLJUba2R1xIA0jnBoi01QtXBwwwo+deStKga0YA1D6z6e+LzWVEj9xLEOTdo+
 HJKwzEV4SimCb+oiFMldr9ZMQ+SUp/y8CUa0d1qrWl5bKq3JEaZWJyMuNyTW3wZ2Y9fw
 7U1Hb7nXPNgWZ1yLQBJ60U1cSfCw+/soY4Bdft4EVKlaVZVdk3pdw6RezLuUYaLGEbeS
 uYIFh6wJv9H/nPNdu5WwOwToCAR1WqqcnS8IYgGqHVkM8EecmPCKMCmTD5zwLne4jhBZ
 4ZrdCB4aqs3MLuGEpqBiVLiWwjpu+nT6eASHGp3u6gZPSGG7sg29qiZEJaYNwcKHLcYc
 G8Sg==
X-Gm-Message-State: AOJu0Yy9SGwi7wglwwhRG8BzC6tSgufxUxxN1X2CS6z5VRQtIF7n00KX
 D9f/1dNqG2PY5Snn/FGEisNbohlrKd9s7NWswHvSjmrXgWkp2wdLFAIiiAS3oyblIlhCex7QXnv
 HCV2MVZhJFEXxrLfvkA3Fwr51YWc6OczlhJLzJq3UNHd4Ah9CD61mogE=
X-Gm-Gg: ASbGncsJYsAcZY8aR0OE8ZWMKxUwxcJlFyZj+hE2ZcjCc6KqqTpBYN+cnSKo7RwHXdZ
 2RjLeX+UfOuGetH78/C0N/tU4dxNzCZQhCh42c8fNw3+1eYkI2LnxPUYv+gJyNuyuJBMtnUf+Q4
 xWVZsyXsJPUDkq1IWKZEt1FUZPzKeXsyzsCll8p+VTvqPPj9kZ+ZXBaYaNlfe66XDnjE5oSHo6J
 XhICZ2+ZfqggDb20g1oQx68FZ0TLmREpufSzc6LIAIYmjrJxduCDVyaOg6ik0o9AAthPMjfGswC
 Dp+C5zXgzwyQKhbv0Y0HqrgOZgVOpKaUA/iIBstPXjlxVztT
X-Google-Smtp-Source: AGHT+IHeu32AWT0dyZ4Eh6HjV6e6PBorU7DsSXNBddvyvg1ifmBNFfI5yMdvB0EHLsUpF0Pi+djJP+P9i7RH9AGGn6o=
X-Received: by 2002:a05:690c:e3ea:b0:788:22de:a8cb with SMTP id
 00721157ae682-78a8b47c746mr30992857b3.10.1763765307922; Fri, 21 Nov 2025
 14:48:27 -0800 (PST)
MIME-Version: 1.0
From: Nathan Southern <nsouthern@linuxfoundation.org>
Date: Fri, 21 Nov 2025 16:48:17 -0600
X-Gm-Features: AWmQ_bmdjBTUAKcZaOpv5pmm--vsSUuT2g68Uoi2M21vFzap2_Dit97SE7Q4Eps
Message-ID: <CAKoDjhznzGDqGRoKpO7QmSgSABToZ=cvZ--2gurw-kbMVWRUhg@mail.gmail.com>
Subject: Seeking Asia Pacific Contributors to assist with community building
 on DPDK
To: dev@dpdk.org, Ben Thomas <bthomas@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000a569380644229ced"
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

--000000000000a569380644229ced
Content-Type: text/plain; charset="UTF-8"

Dear DPDK Community Members,

In recent months DPDK has seen an upsurge in the amount of ecosystem
activity related to our project, across the Asia Pacific region. In
addition to numerous drivers included in the new release that were created
by Chinese startups, we're seeing logarithmic surges in the number of
website visitors to dpdk.org from China (up 110%, with 45,000 users since
January) and Singapore (up 885%, with 15,000 users since January).

We'd love to find a way to harness this energy by organically building our
community across this region - for example, by organizing and holding
regional user groups in Beijing or Shanghai or Langzhou. Or, another option
would be to work with our marketing coordinator, @Ben Thomas
<bthomas@linuxfoundation.org> , and begin sending him Mandarin-language
articles that are pertinent to our APAC community, on a quarterly basis for
our LinkedIn newsletter. We would also benefit from having someone run and
monitor our WeChat page for DPDK.

These are just three examples.

We're also exploring the idea of doing a Q3 or Q4 Summit or co-location in
Asia next year - likely to be held in China - but would need local
assistance to help spread the word beforehand, through Mandarin-language
social media platforms.

If you're based in that region and are interested in helping out with this
on a volunteer basis in any of the ways I've described, please get in touch
with myself or Ben Thomas; we'd love to discuss further. We would also be
grateful for the help.

Many thanks,

Nathan Southern

Nathan C. Southern, Senior Program Coordinator

Data Plane Development Kit (DPDK)

The Linux Foundation

248.835.4812 (mobile)

nsouthern@linuxfoundation.org

--000000000000a569380644229ced
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>Dear DPDK Community Members,</div><div><br></div>=
<div>In recent months DPDK has seen an upsurge in the amount of ecosystem a=
ctivity related to our project, across the Asia Pacific region. In addition=
 to numerous drivers included in the new release that were created by Chine=
se startups, we&#39;re seeing logarithmic surges in the number of website v=
isitors to <a href=3D"http://dpdk.org">dpdk.org</a> from China (up 110%, wi=
th 45,000 users since January) and Singapore (up 885%, with 15,000 users si=
nce January).</div><div><br></div><div>We&#39;d love to find a way to harne=
ss this energy by organically building our community across this region - f=
or example, by organizing and holding regional user groups in Beijing or Sh=
anghai or Langzhou. Or, another option would be to work with our marketing =
coordinator,=C2=A0<a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" href=
=3D"mailto:bthomas@linuxfoundation.org" tabindex=3D"-1">@Ben Thomas</a>=C2=
=A0, and begin sending him Mandarin-language articles that are pertinent to=
 our APAC community, on a quarterly basis for our LinkedIn newsletter. We w=
ould also benefit from having someone run and monitor our WeChat page for D=
PDK.</div><div><br></div><div>These are just three examples.</div><div><br>=
</div><div>We&#39;re also exploring the idea of doing a Q3 or Q4 Summit or =
co-location in Asia next year - likely to be held in China - but would need=
 local assistance to help spread the word beforehand, through Mandarin-lang=
uage social media platforms.</div><div><br></div><div>If you&#39;re based i=
n that region and are interested in helping out with this on a volunteer ba=
sis in any=C2=A0of=C2=A0the ways I&#39;ve described, please get in touch wi=
th myself or Ben Thomas; we&#39;d love to discuss further. We would also be=
 grateful for the help.</div><div><br></div><div>Many thanks,</div><div><br=
></div><div>Nathan Southern</div><div><br></div><div><p style=3D"margin:0px=
;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;He=
lvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-alt=
ernates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;fo=
nt-variant-east-asian:normal;font-feature-settings:normal">Nathan C. Southe=
rn, Senior Program Coordinator</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">Data Plane Development Kit (DPDK)</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">The Linux Foundation</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">248.835.4812 (mobile)</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal"><a href=3D"mailto:nsouthern@linuxfoundation.org">nsouthern@linuxfound=
ation.org</a></p></div></div>

--000000000000a569380644229ced--
