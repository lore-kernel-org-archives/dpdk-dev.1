Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F81FCCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 08:54:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42B05402C8;
	Mon, 10 Nov 2025 09:54:18 +0100 (CET)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 3B81C400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 09:54:17 +0100 (CET)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-88244d1559eso13914716d6.0
 for <dev@dpdk.org>; Mon, 10 Nov 2025 00:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1762764856;
 x=1763369656; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=egZ5UQSEgmNm+QYgeaiYzneq1dhiEEDvX60OlFvhN+M=;
 b=i6eKp3juk79OLumLYczHr+Uk03SyPRWL1tY5XA1fMSJ+wfShSloDdHAG2K1ndHIkNK
 9v08H2orM37AMcVpn6niGEtKgLROix3MB3tjEqSKbYcab1fwlOcx9HR2AR98+Pu5Ind1
 tfWaKwpuMc816OCJnL/tTEIPH13jna9ZMcMLa+g6rnPBrm8Gi//GAoRiaU/neZpHnEWA
 R4RPOgIfNst5CHj12RVfGX5tUpMKRVtQ7Z5AKprw0J0CLHwoskqCUVZ86ce/nywppmjZ
 2h7FcQeWBQKojCZKp9XF5YUruB/+GmU9DtfkWkrBQgmHmArxVVbZXN30jaZIdj/f7uw/
 gNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762764856; x=1763369656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egZ5UQSEgmNm+QYgeaiYzneq1dhiEEDvX60OlFvhN+M=;
 b=OQFlo88kswTYQtHQEPDME1JGZ2S5JSs6BgOC6BtoxREIc8rUOfbOt3NjFateeoQ0Tf
 57E1wWaaxaZlJu3B37d9brJFKDJBddoDt5kDO8NjN74UYC71J0BhPjxYBjQXgt9agwoA
 gPlrGItyHtVMnBwXX6e7ZAuf27R9LUQqCfQROi0kUE/8ltjp6Y/WSdjuYNI3n7v3zBNh
 fvbCpZtgHuoKoBwfVfYAceBdce14GLzOUAtz5er+2LPolSNdZNPEe25KnLvddcMz5u/e
 8zA2/sb37+BrBB8P+d/2hofrf31g/b+1YUm7Ctqgcqe2+UDH/uJJPQxegQcTO/AhsXda
 WOiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7msFlJDCQYZM+YmhKQlCKvt0kF0hPbow+3RbSF7M4wIzjcu9ISPGHBYyODy9PYyfbjfo=@dpdk.org
X-Gm-Message-State: AOJu0Yw/ahxIaxyq5lORs5S6V67Eb3qNV8jDFkZsD1/HJcPsnc5CXexT
 +1Jl4EuzbfTWvZ7qWBgKFQ5Md1t+E7vGI5kHu81M6KaAeQ21tpliowNogxYW5m2AA5HG8I9tcXQ
 hKRrIo/FrhmXW+oI4tErf0Wc5xJae398GcCBKiZV/Q1PcpMAYQyTVmgJGSA==
X-Gm-Gg: ASbGncuLJbfJdR3vYRukdl3tb8EIZRG91z3loyfDOulpwAMoliKkqRUH1F/qcQvqoWM
 9fV1uz0JuJ7y7fSeFYTql8LYCOCglzmarKGbqNzQ06alcVBhbLn4Fj0AwmrTi9WwYXWHXlHxRQO
 MCMp7W+NxY25legmEBEcl70+oqIz1XOfjhKLc+nt7dKe8RpjykRNxwKJmkF2074d/FUCPx3hTnB
 pM7PbM5yh7TtKUFRtTG2MECkEBZClyLMtZVViYYOSOygwUe6cBXhrZbfY0ZF9hFAntbJ5kg1oYU
 Wm8fwszddysLFujXcXVpu3l9Lah8feBWxbtJFnMKnRMRUJ4YBfoq0x6WDQ==
X-Google-Smtp-Source: AGHT+IHZwaeJKlFYcAHTCZSN0rVIk6qvedMbjb1dtbPQHolqPR0XrtGMn0Cbbgfiqv1le1rjfOKbdQXBU7XaNTdIg1g=
X-Received: by 2002:a05:6214:2428:b0:880:5126:1e20 with SMTP id
 6a1803df08f44-8822f345fd7mr134775006d6.0.1762764856445; Mon, 10 Nov 2025
 00:54:16 -0800 (PST)
MIME-Version: 1.0
References: <be773672-77bb-4c2d-ba12-43b75ff29507@cesnet.cz>
 <20251107080727.13e201a1@phoenix>
 <d3e9d94a-c6e3-48cd-a7cf-a1ea77216f0a@cesnet.cz>
In-Reply-To: <d3e9d94a-c6e3-48cd-a7cf-a1ea77216f0a@cesnet.cz>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 10 Nov 2025 13:54:04 +0500
X-Gm-Features: AWmQ_bmUa9CKunFlicmAMPkEpX-ytCvjR5r3rMZk53--1YE4d63OVeTqyMQaEmY
Message-ID: <CA++2-x4nx_a-6OJVRxu3zuAUWrvda2dWJhOUXK0ETj+U3bMzqg@mail.gmail.com>
Subject: Re: RFCv1: DPDK RTE Flow Rule Parser
To: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@cesnet.cz>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000017595a064339adbd"
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

--00000000000017595a064339adbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 1:11=E2=80=AFPM Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=
=A1 <sismis@cesnet.cz> wrote:

> On 11/7/25 17:07, Stephen Hemminger wrote:
> > On Fri, 7 Nov 2025 15:16:28 +0100
> > Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@cesnet.cz> wrote:
> >
> >> Hello all,
> >>
> >> ## Motivation
> >>
> >>
> >> Before taking either route, I=E2=80=99d like to understand the communi=
ty=E2=80=99s
> >> preference:
> >> - Do you even see it as a valuable contribution for customer
> applications?
> >> - Can you possibly think of an alternative way to solve the unified
> >> human-readable format conversion? Both on the code level and interface
> >> level.
> >> - Is testpmd code extraction the right long-term solution, even if
> >> disruptive? Should the private DPDK forks be taken into consideration?
> >> Or should I start with a separate lightweight parser and revisit
> >> integration later?
> >>
> >> Any other feedback is welcome


Hi Lukas,
You could try testpmd Command File Functions
<https://doc.dpdk.org/guides-25.07/testpmd_app_ug/testpmd_funcs.html#comman=
d-file-functions>
Rte_flows using this method can be created at boot and run time.

   - If testpmd started with the --cmdline-file=3DFILENAME command line
   argument testpmd will execute all CLI commands contained within the file
   immediately before starting packet forwarding or entering interactive mo=
de.
   - At run-time additional commands can be loaded in bulk by invoking the
   load FILENAME command.


 Best Regards,
Khadem

--00000000000017595a064339adbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Nov 10, 2025 at 1:11=E2=80=AFPM L=
uk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 &lt;<a href=3D"mailto:sismis@cesnet.cz=
">sismis@cesnet.cz</a>&gt; wrote:<br></div><div class=3D"gmail_quote gmail_=
quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 11/7/=
25 17:07, Stephen Hemminger wrote:<br>
&gt; On Fri, 7 Nov 2025 15:16:28 +0100<br>
&gt; Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 &lt;<a href=3D"mailto:sismis@ces=
net.cz" target=3D"_blank">sismis@cesnet.cz</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Hello all,<br>
&gt;&gt;<br>
&gt;&gt; ## Motivation<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Before taking either route, I=E2=80=99d like to understand the com=
munity=E2=80=99s<br>
&gt;&gt; preference:<br>
&gt;&gt; - Do you even see it as a valuable contribution for customer appli=
cations?<br>
&gt;&gt; - Can you possibly think of an alternative way to solve the unifie=
d<br>
&gt;&gt; human-readable format conversion? Both on the code level and inter=
face<br>
&gt;&gt; level.<br>
&gt;&gt; - Is testpmd code extraction the right long-term solution, even if=
<br>
&gt;&gt; disruptive? Should the private DPDK forks be taken into considerat=
ion?<br>
&gt;&gt; Or should I start with a separate lightweight parser and revisit<b=
r>
&gt;&gt; integration later?<br>
&gt;&gt;<br>
&gt;&gt; Any other feedback is welcome</blockquote><div>=C2=A0</div></div><=
div>Hi=C2=A0Lukas,=C2=A0</div><div>You could try testpmd=C2=A0<a href=3D"ht=
tps://doc.dpdk.org/guides-25.07/testpmd_app_ug/testpmd_funcs.html#command-f=
ile-functions">Command File Functions</a></div><div>Rte_flows using this me=
thod can be created at boot and run time.=C2=A0</div><div><ul><li>If testpm=
d started with the <code class=3D"gmail-docutils gmail-literal gmail-notran=
slate"><span class=3D"gmail-pre">--cmdline-file=3DFILENAME</span></code> co=
mmand line argument testpmd
will execute all CLI commands contained within the file immediately before
starting packet forwarding or entering interactive mode.</li><li>At run-tim=
e additional commands can be loaded in bulk by invoking the <code class=3D"=
gmail-docutils gmail-literal gmail-notranslate"><span class=3D"gmail-pre">l=
oad</span> <span class=3D"gmail-pre">FILENAME</span></code>
command.</li></ul></div><div><br></div><div><span class=3D"gmail_signature_=
prefix">=C2=A0Best Regards,=C2=A0</span></div><div><span class=3D"gmail_sig=
nature_prefix">Khadem</span></div><div dir=3D"ltr" class=3D"gmail_signature=
"><div dir=3D"ltr"><div><br></div></div></div></div>

--00000000000017595a064339adbd--
