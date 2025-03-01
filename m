Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD9AC282C6
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Mar 2025 09:28:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16967402A9;
	Sat,  1 Mar 2025 10:28:32 +0100 (CET)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9AED540281
 for <dev@dpdk.org>; Sat,  1 Mar 2025 10:28:31 +0100 (CET)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-52361a772e7so1159157e0c.1
 for <dev@dpdk.org>; Sat, 01 Mar 2025 01:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740821311;
 x=1741426111; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4kZYa9sijgZbLZIilOWBS529JyFp/3iiuvYBsS6ixx4=;
 b=Mn9ExeECgMCzcB/X858qj1ss86J0Td+/LViw2a2ljNXD7rXijA1z+akPqdVDoZXWV2
 SqkNI++SXfWombZbaIQ3+qwS4Uf80Euqflx2Eodoglb/SrFDivyj8nuyJLfuAzYsEbdK
 +i5z1MZzs9UKjIC5r9oucfjcz3Nyy0WyfEkBFwV489BQCH2zWPmNyc1iO9nXjEnoZJ4g
 UvH56THv20+MKQJoi3a0HBbxD3NGG8vSU/etY3lwMk2u7CRgnoQC6JTG/3qHekSiA4uo
 7mEolHn6eC5oCS56JrbKId2DFdpqbzuTLtVAY5W+N/6vEgDCFL6M/6v8rPtaoCVIC6Tl
 8QPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740821311; x=1741426111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4kZYa9sijgZbLZIilOWBS529JyFp/3iiuvYBsS6ixx4=;
 b=b1niXKDQHbnuJABmgR5cOgaIrI6w+GkEJtkZcSccieS9MoeMjGm2VFH52+FwLEQkVp
 BZDFMP0KHUGxvdm9M9A6SHg51Gcd6XMzGCtrLs2iK2Gs9EzZVmTpS64q5CsYAugpSi8C
 gfHTd5Y7p8eNfcWtp5oWi89BU0bbOln9IjHP+O6oUFm7P0XzQzyg443R3Z1UraZMQeVr
 8Ha33juvPmnma+FD7Ia94iEr0fUq1FEFboW4ye4paW3mHflWF/t3MgM40q6VHazUu0bo
 srkfaOlCPKwrmdWeXfgSCW/SU4q8X2ctPsiQjXAjQf9WYDOMEm19Ro1zjuDb5S6/DD+F
 oxIQ==
X-Gm-Message-State: AOJu0YzuiW1wQeaIqV87C5CXI6vmbsLMlx1mivGg4p/KfCdOFP5wTsWK
 3CYpK/oMay5Da3zSjzsXnqrYEM8M/+mqsxgD6xI4GjzO90wKprgYFNRcQdaEzRrkUMaMIaIHiLd
 OT0W8iZ6AKdr347WkSVjcCQtZyJ2wAA8plZQ7XEjpi19EbEDlSwk=
X-Gm-Gg: ASbGncsKBboPyw+NgmTi9HzgoxdlF6uiATBzko35NG8UAYnKCbyQeSRYexPE67dgfNw
 gPKXOIJGMjpUvMkujpIzAuwCnwBsXmApjBFwl9DjWSDQgKT/QsNmhVlui6tn+JvXS5qii0wKmZT
 ULTzdRIN2QmElrkjv2aaRDFVww/A==
X-Google-Smtp-Source: AGHT+IHF+T0OKFUX9XZ8uYyzy2cJwkGoGl7uftyaKg5XF2ti3rTm94f5pUkXwOS71Jeiu9sHIhEypUiqeBRZRMPjsfo=
X-Received: by 2002:a05:6122:f07:b0:51e:ffd1:67f3 with SMTP id
 71dfb90a1353d-523592a0767mr4402768e0c.7.1740821310808; Sat, 01 Mar 2025
 01:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20250228142005.1052bd2d@atlas-11>
In-Reply-To: <20250228142005.1052bd2d@atlas-11>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sat, 1 Mar 2025 10:28:21 +0100
X-Gm-Features: AQ5f1Jq0YDSm-PNfqeHLfoSZIsMncavzujkkyIJtt1bu5Brs4bVONDUvn3212V4
Message-ID: <CAOaVG14ZUZwNNkBGgD8phDnib7O6_cS476P2Z53dUnjTsxTLWQ@mail.gmail.com>
Subject: Re: DPDK support in libpcap
To: Denis Ovsienko <denis@ovsienko.info>
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000d947c7062f448ba2"
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

--000000000000d947c7062f448ba2
Content-Type: text/plain; charset="UTF-8"

Last time I looked at that code it was really ugly, and messy. But more of
importantly it was the wrong use case. Very few users will want to have a
NIC dedicated to capture only.

The whole thing should be rewritten so that tcpdump/ Wireshark can run as
secondary process using existing pdump API.

On Fri, Feb 28, 2025, 15:20 Denis Ovsienko <denis@ovsienko.info> wrote:

> Hello all.
>
> libpcap has been implementing DPDK packet capture support for some
> time, in that a contributor added this support using DPDK 18.11.  This
> code stopped working with later versions of DPDK and still remains
> broken.
>
> Would anybody be interested to upgrade pcap-dpdk.c in libpcap to the
> latest stable release of DPDK, to confirm whether it works as intended
> and maybe even to keep this module better maintained in future?
>
> --
>     Denis Ovsienko
>

--000000000000d947c7062f448ba2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Last time I looked at that code it was really ugly, and m=
essy. But more of importantly it was the wrong use case. Very few users wil=
l want to have a NIC dedicated to capture only.<div dir=3D"auto"><br></div>=
<div dir=3D"auto">The whole thing should be rewritten so that tcpdump/ Wire=
shark can run as secondary process using existing pdump API.=C2=A0</div></d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Fri, Feb 28, 2025, 15:20 Denis Ovsienko &lt;<a href=
=3D"mailto:denis@ovsienko.info">denis@ovsienko.info</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Hello all.<br>
<br>
libpcap has been implementing DPDK packet capture support for some<br>
time, in that a contributor added this support using DPDK 18.11.=C2=A0 This=
<br>
code stopped working with later versions of DPDK and still remains<br>
broken.<br>
<br>
Would anybody be interested to upgrade pcap-dpdk.c in libpcap to the<br>
latest stable release of DPDK, to confirm whether it works as intended<br>
and maybe even to keep this module better maintained in future?<br>
<br>
-- <br>
=C2=A0 =C2=A0 Denis Ovsienko<br>
</blockquote></div>

--000000000000d947c7062f448ba2--
