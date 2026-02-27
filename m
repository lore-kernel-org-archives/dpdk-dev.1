Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B3FD5306
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 07:31:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA059402C6;
	Fri, 27 Feb 2026 08:31:21 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 7BDF04028E
 for <dev@dpdk.org>; Fri, 27 Feb 2026 08:31:20 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-506a3400f30so15685301cf.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 23:31:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772177480; cv=none;
 d=google.com; s=arc-20240605;
 b=ITDmXLlVjP54OcfnmK5f/vtg/HRHAh57HpRcRM1a1M+Z7kqUvFEwsew/sm9k+g/oCE
 6RTF1NYOtOpwLug/CtFt6ssbUuMrbfQ2OffbIAwmVX0xZuJIhvoF+jXNmua9Y3o7z4/O
 HMoAi1/J9nmysbdunQibgndu2xGRAfR3RUQgrA2U2fI0IE0sX9UQgKAn2f2Xl0LU2d9B
 ivZrqEfawV18tYEhQrjgDELEv2S0uzBL4DJVyFmJtn4D1qIVSYMN9k0v5HGek9icyiqn
 +GPdhgh/abt03sIjg+Nnu516Jclgk8unuTGTvzQBmWf9e79VfFyRCb9fix8+pHIzWALm
 8qUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ktPloNwSCxCn/al0V5w2Rc1tqMmZ2Nz+trxWlCJUiQE=;
 fh=XJW9krIRjJm5x451r3+wMdO5rh40UjllqEXSLwsg67k=;
 b=TOixV/tAXcuKIPn/2K/z4jwVrSLvnFwtW3dsdO8CK7SnMU2+Pb5ERvLJFrDQW+3WSA
 ir+5c8VclLGD76lB//gxdLNziOQOqfUltYUN68qRFyof7j76TcZny689jmjAyZNtOMIa
 AcRWYwhXCEhXlBGOoZ1yT/JR5iNqn6ErUGWWIgiQHpDevb4uU+Foe6ckPUu/iI4Ie85n
 3w3csyi8ZRIrFCczxij1yxCLfkyUjJxvR/jijwPa9b/6hHRtZMvaofY6kB+Z6rPPIp4h
 gEk+XfJvnFCPMqkqwwYs5/Inre/rokZKrMPcv9SOiZIWBbb27+o8+wvaJ5QAvlTWyELp
 Nknw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772177480; x=1772782280; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ktPloNwSCxCn/al0V5w2Rc1tqMmZ2Nz+trxWlCJUiQE=;
 b=MebNp/5AGi6g55mkIzXhmYy5kyFQTj1EspwfqOANjuKtOqC5jDw1qsRc4SyKtEOhEs
 y2F7rUvu3QhHQdR/IpBKKYiS+mbtLMkJCm/orlKg37oZzdib7aLlFMfIob+Elmpke1yn
 tmZcRZrZd64rPE1QlLOyz65+ATa5jD4r5hPgdkPSOEozgDJ7QmCCkKha+sW5lyRyszyJ
 POvBBn7iIZbUTAMIne6CFP5CLWldDFIp1v+cbvwLxEAwSwxiu1KghEsF9l3v3BA3WA2T
 dQ11JAktpdBRFlJkBdPsr6cxo81QiprvV095KYASXtEjkDW6fRwL2ezGNQ55fbyRxY0Z
 dN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772177480; x=1772782280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktPloNwSCxCn/al0V5w2Rc1tqMmZ2Nz+trxWlCJUiQE=;
 b=JgOGILlXPuc/gGgSeD9QsEidERMLZ0UssbBVNZHqRdLevWheVZcX+jwYsdH1GcgHB/
 7wA+Lqj2kAweMDTP61qoeJl1XNycfsRwSKF4P9mNTiAlSNTSf8nIHY4wC/XoO1GdmEHy
 n92OQhtAiDlHp2RIDeB6w/OoXwm3c882d1AR8Ckk/Aq5yMKOeu6mA7MIGBPc6pGjqC9+
 IoA3U3jeBHvgIWbyn+vxzTrNleMNMp7sU3FP/qE/y+W5EB/TXUTZ7PFP6LwWxtKoBJMM
 lcMidrN87dQL9VLcEGSA0P7g1q/C8OtPYiVit6zNqKaoB13n76La3oQuA8DheV6NbH7K
 WUQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBIDdVhKI8FWEaCV2HUn27q1V6aZ9FcwznW3JD5MKKd0GR3GFsu22pVMBGrpfec3Waq7s=@dpdk.org
X-Gm-Message-State: AOJu0YzeocgOC9HY9xO0fbUU/IXvRuQi2YbCeOTH/QsrK8T0nqp3XtNp
 FsRRK8LqSfh39BnVvtK+7dyeP0+adZSc/NpcnHHQRzxQkIhX0BmbfqNuS3nqR7CppyRNM3KbNpi
 PlWb45CVSr1bNsWYTJtkLF7rGUWwlr1Dhpd6R
X-Gm-Gg: ATEYQzx/NEIi/I6r2vnVU7/1Pt6Vm6ONkAUVqS/KU9JMn3NXh4t0S189rRJhMM5jhN8
 qffoBAgXAfepMHIqioTseWcWBiClo+Rb5QmsMujwdPK2UiHS23lZMkBz2L2CoSnwb/pM6PKdcms
 Iuy566tTmVPZ0AMfAxWmgBL8j4UOBEKqOXb3gNvTpIv1iyAj1OkC9iLp0VjRmkds5WXxLUDSUQ3
 sari3O0eaDnob0dyb3GRkc3jeLWzbVwFWr+lDF4jARnxN+yBol6Vss87h8IaggNlhyDGPjDugmv
 QS5aBCekzg==
X-Received: by 2002:a05:622a:553:b0:4f1:83e4:70d0 with SMTP id
 d75a77b69052e-50752459446mr20044071cf.34.1772177479717; Thu, 26 Feb 2026
 23:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20250803090837.15589edd@hermes.local>
 <7c1a559c1d4d4e9bb58c318a95399138@huawei.com>
 <ac1777c39e66443789e6d45fb1b9d7fd@huawei.com> <33965644.t2Qszz9eOc@thomas>
 <f33de0e613c44887a26fe8bf90022d2d@huawei.com>
 <db2579eb3b0a4476bd53d867ea1a8d04@huawei.com>
In-Reply-To: <db2579eb3b0a4476bd53d867ea1a8d04@huawei.com>
From: su sai <spiderdetective.ss@gmail.com>
Date: Fri, 27 Feb 2026 15:31:08 +0800
X-Gm-Features: AaiRm51VW8MPEowAwSN9fhYxSUeQiLSwg_d7juJ90sM4gQYyI-lW18xBUmvoBK4
Message-ID: <CAFQeoKjHvNLp4hBm=HXGGhHh0T7h_XXdwALCVD_s6D9Z1cAe6Q@mail.gmail.com>
Subject: Re: [v3] net/cksum: compute raw cksum for several segments
To: Marat Khalili <marat.khalili@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000285585064bc93957"
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

--000000000000285585064bc93957
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As noted in Marat Khalili's analysis, we identified this issue in the
production environment. Meanwhile, I simplified the problematic scenario
into corresponding test cases and added them to app/test/test_cksum.c

On Sat, Feb 21, 2026 at 2:35=E2=80=AFAM Marat Khalili <marat.khalili@huawei=
.com>
wrote:

> > I can suggest my condition to get a wrong checksum, which does not go
> into the details of how it was
> > observed in the wild:
> >
> > Function rte_raw_cksum_mbuf may produce incorrect result when multiple
> segments are present in the
> > checksummed range, and some of them have odd checksummed length. More
> precisely, if any segment except
> > the last one begins at an odd offset from the start, and arithmetic sum
> of its 16-bit words overflows,
> > the part that has overflown will be lost. Cases when there is only one
> segment, or all of the segment
> > sizes and checksum offsets are even, are not affected.
>
> Apologies, rushed to send. The "except the last one" condition is
> unnecessary. Corrected version:
>
> Function rte_raw_cksum_mbuf may produce incorrect result when multiple
> segments are present in the checksummed range, and some of them have odd
> checksummed length. More precisely, if any segment begins at an odd offse=
t
> from the start, and arithmetic sum of its 16-bit words overflows, the par=
t
> that has overflown will be lost. Cases when there is only one segment, or
> all of the segment sizes and checksum offsets are even, are not affected.
>

--000000000000285585064bc93957
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">As noted in Marat Khalili&#39;s analysis, we identified th=
is issue in the production environment. Meanwhile, I simplified the problem=
atic scenario into corresponding test cases and added them to app/test/test=
_cksum.c<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Sat, Feb 21, 2026 at 2:35=E2=80=AFAM M=
arat Khalili &lt;<a href=3D"mailto:marat.khalili@huawei.com">marat.khalili@=
huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; I can suggest my condition to get a wrong checksum, which d=
oes not go into the details of how it was<br>
&gt; observed in the wild:<br>
&gt; <br>
&gt; Function rte_raw_cksum_mbuf may produce incorrect result when multiple=
 segments are present in the<br>
&gt; checksummed range, and some of them have odd checksummed length. More =
precisely, if any segment except<br>
&gt; the last one begins at an odd offset from the start, and arithmetic su=
m of its 16-bit words overflows,<br>
&gt; the part that has overflown will be lost. Cases when there is only one=
 segment, or all of the segment<br>
&gt; sizes and checksum offsets are even, are not affected.<br>
<br>
Apologies, rushed to send. The &quot;except the last one&quot; condition is=
 unnecessary. Corrected version:<br>
<br>
Function rte_raw_cksum_mbuf may produce incorrect result when multiple segm=
ents are present in the checksummed range, and some of them have odd checks=
ummed length. More precisely, if any segment begins at an odd offset from t=
he start, and arithmetic sum of its 16-bit words overflows, the part that h=
as overflown will be lost. Cases when there is only one segment, or all of =
the segment sizes and checksum offsets are even, are not affected. <br>
</blockquote></div>

--000000000000285585064bc93957--
