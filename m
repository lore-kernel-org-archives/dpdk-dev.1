Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A40C83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 11:31:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F5A9402E6;
	Thu, 31 Jul 2025 13:31:42 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 2FD39402AB
 for <dev@dpdk.org>; Thu, 31 Jul 2025 13:31:40 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-31ef50d8d57so612892a91.0
 for <dev@dpdk.org>; Thu, 31 Jul 2025 04:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1753961499; x=1754566299; darn=dpdk.org;
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fVR37GBOhhSd83j6V14EKFdEetw4YPyUfcZYUVVou5M=;
 b=AXqFbWODndXuiNS1fwOTz0tkbgmN6i9LZNxgzWoO84cqpfOqI4/om5x6f0FggaDcwq
 IXhg9Mv/hIk73Nn6lweJwvpx6UaDRngPhct2Y9hg5HwmsQ5GSmDEjZ+c1DdKt7vmoEL/
 gisSANLyyJ/PU+SGq8BNWC/nvuSnN+mM1ZixG8Cel7YOPWOBD/uPmdfrAIOJi3XPyZWL
 OXyUvMC49VhVOgyzcWaHdYDZo3Kmrk2O108QYTyaTms5i0pEs3aENkYmi/qGAZnvRsMQ
 QnMe+yHXspbBk9cQUdZjHy/IlaXbLMbW16TNhnFPuQ5mpCQ+LeKAffvEOs72rfTzJvpR
 PuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753961499; x=1754566299;
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fVR37GBOhhSd83j6V14EKFdEetw4YPyUfcZYUVVou5M=;
 b=ewj02bXhnNmUrgbL+veWrVX7UEpuZxLE9+5YP8512baYUf8iPJsZkKqgKXr3pQlob9
 tY5FXwg25RawD7sH672beBLghGltqKcxPr1XFjK51EZMWySsxhWsz1m2a06EsAPGkdhe
 Qy8vt/i2nW/Ae5lH1/1dZLygPcFLLET8SX8EDGJfMbIpZt9QGKebPSEByG3F4rI1v14j
 uBZvKdGArGsRXEmcB+qi/rSCONR0pOhq6DIdT05p7FEPyzvxAdNGu6Bzf5u5JsJQGcnC
 WP+0BBiWfXuzDUPApTzhVhHinEd6e6DInRFk3GnUwRmYXKiTqPLkahMe2lGVVjBH2YOz
 IgCQ==
X-Gm-Message-State: AOJu0Ywpj+rBTWRrEqrOsZd1U5KX8W/g8TlYn78RpBbVmCYZnE5ofedh
 CZwTixNWDTSmST8ii203uBuFxww+rHBpDqEA7NibiWsGe9GTI9d9gjOEUkWMjwe98/o81aWMaej
 9TqwfLcTeI8FQhSk70ijVjeqvithL+fxqIqLDViyDAQ==
X-Gm-Gg: ASbGncsqlQB4zvtab2A071nqiJt5ruUgM/VDGRsiFEK2DVM0dPUNLewriBg20DKn9rz
 khXrelRx+67MQFIptzbKYNcSZBTnEdATwqLK1sPHLvyWgnMeSWS1W4bzdcru3psbtrSGCsyWrhV
 0IVYYgePkJHkIAYF/86JPOyv8/7WDH5WSiVQIGd3tHQOuu+W+bqCS1X2aHspk4ecZn7gxpBKh9d
 OTbJS4qxuzHi+tvUgwQ
X-Google-Smtp-Source: AGHT+IEThAmo4RWBqtzY7eNj9OxrBpke/hyEaZhTWv7xyVfpiCFCir+ZNVLkf06zzyzWgFcKvZF8ijuS3Iq7EkbDaJE=
X-Received: by 2002:a17:90b:55c8:b0:311:f05b:869b with SMTP id
 98e67ed59e1d1-31f5de58622mr9377645a91.30.1753961499142; Thu, 31 Jul 2025
 04:31:39 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 31 Jul 2025 04:31:38 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 31 Jul 2025 04:31:38 -0700
From: Su Sai <susai.ss@bytedance.com>
Mime-Version: 1.0
In-Reply-To: <18bc89bd254340f0b15653be473b0979@huawei.com>
References: <CABsP7wOFAsE2-BmnHZW1c3rOkkrUWfox7qrbim6zmP6gbmJqzg@mail.gmail.com>
 <2b98417ad1da4df2ac4e577b9c3938ae@huawei.com>
 <18bc89bd254340f0b15653be473b0979@huawei.com>
Date: Thu, 31 Jul 2025 04:31:38 -0700
X-Gm-Features: Ac12FXzKjyOqqBpU6nmuYmLiS7lUg4vawhT0mzzbOQS_ZCrk999-NLmXIQ5mYfM
Message-ID: <CABsP7wPvp1VFJ2+5VVp5o+Ne38CGbTX6-ftFWJG1N6kH0-sr3w@mail.gmail.com>
Subject: Re: [External] RE: [PATCH] net/cksum: compute raw cksum for several
 segments
To: Marat Khalili <marat.khalili@huawei.com>, 
 "jasvinder.singh@intel.com" <jasvinder.singh@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000001b5118063b37fcb4"
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

--0000000000001b5118063b37fcb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marat Khalili,

Thanks for your comments.

We found small TCP checksum errors pkts online, then were traced to issues
within the rte_raw_cksum_mbuf function.

This error can be reproduced as follows:
1. In the client ECS with an MTU of 1500, initiate traffic using the
command "iperf3 -c {dst ip} -b 1m -M 125 -t 8000".
2. In the destination ECS, the InCsumErrors statistic can be viewed using
the command "netstat -st | grep -i csum". The erroneous packets can also be
confirmed via the tcpdump command.

The following is a detailed description of a captured erroneous packet. The
hex stream of the packet is as follows:
00163e0b6bd2eeffffffffff0800450000a50d7a40004006b94bc0a8f91dc0a8f91ed5d2145=
146f9d990e10d6a2d8010020040a200000101080a95ac86ba091145d3ffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
ffffffffffffffffffffffffffffffffffffffffffffffffff

This is a packet in the format of eth + ipv4 + tcp + payload.

The process leading to the error is as follows:
1. Due to the small MSS, TSO fragmentation was triggered, generating 3
mbufs.
2. The data_len of the first mbuf is 66 bytes, containing the Ethernet
header, IPv4 header, and TCP header.
3. The data_len of the second mbuf is 61 bytes.
4. The data_len of the third mbuf is 52 bytes.
5. When calculating the checksum of the TCP header for such an mbuf chain
using the rte_raw_cksum_mbuf function, the tmp value obtained during the
calculation of the third mbuf is 0x19FFE6.
6. After applying rte_bswap16, tmp becomes 0xE6FF, with 0x19 discarded.
This results in an incorrect final checksum.

Meanwhile, we have also found that when enable jumbo frame, the payload
becomes longer. In the process of rte_raw_cksum_mbuf handling an mbuf
chain=EF=BC=8Cdue to the relatively large value of tmp, overflow will occur=
 in the
accumulated sum.

From: "Marat Khalili"<marat.khalili@huawei.com>
Date: Thu, Jul 31, 2025, 19:04
Subject: [External] RE: [PATCH] net/cksum: compute raw cksum for several
segments
To: "=E8=8B=8F=E8=B5=9B"<susai.ss@bytedance.com>, "jasvinder.singh@intel.co=
m"<
jasvinder.singh@intel.com>
Cc: "dev@dpdk.org"<dev@dpdk.org>

Sorry, sent the previous email too quickly.



> -----Original Message-----

> From: Marat Khalili

> Sent: Thursday 31 July 2025 11:52

> To: '=E8=8B=8F=E8=B5=9B' <susai.ss@bytedance.com>; jasvinder.singh@intel.=
com

> Cc: dev@dpdk.org

> Subject: RE: [PATCH] net/cksum: compute raw cksum for several segments



> > +static inline uint16_t

> > +__rte_raw_cksum_reduce_u64(uint64_t sum)

> > +{

> > +        uint32_t tmp;

> > +

> > +        tmp =3D __rte_raw_cksum_reduce((uint32_t)sum);

> > +        tmp +=3D __rte_raw_cksum_reduce((uint32_t)(sum >> 32));

>

> What if this addition overflows?



Realized it cannot actually overflow, my bad (maybe still needs a comment).
Now this function looks good to me as well.



> > +        return __rte_raw_cksum_reduce(tmp);

> > +}

--0000000000001b5118063b37fcb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div id=3D"editor_version_7.48.0_nDeKuLrb" style=
=3D"word-break:break-word"><div style=3D"margin-top:4px;margin-bottom:4px;l=
ine-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">Hi Marat Khalili=
,</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6=
"><div dir=3D"auto" style=3D"font-size:14px"><br></div></div><div style=3D"=
margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=
=3D"font-size:14px">Thanks for your comments.</div></div><div style=3D"marg=
in-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"fo=
nt-size:14px"><br></div></div><div style=3D"margin-top:4px;margin-bottom:4p=
x;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">We found smal=
l TCP checksum errors pkts online, then were traced to issues within the rt=
e_raw_cksum_mbuf function.</div></div><div style=3D"margin-top:4px;margin-b=
ottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px"><br><=
/div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6">=
<div dir=3D"auto" style=3D"font-size:14px">This error can be reproduced as =
follows:</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-hei=
ght:1.6"><div dir=3D"auto" style=3D"font-size:14px">1. In the client ECS wi=
th an MTU of 1500, initiate traffic using the command &quot;iperf3 -c {dst =
ip} -b 1m -M 125 -t 8000&quot;.=C2=A0</div></div><div style=3D"margin-top:4=
px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:=
14px">2. In the destination ECS, the InCsumErrors statistic can be viewed u=
sing the command &quot;netstat -st | grep -i csum&quot;. The erroneous pack=
ets can also be confirmed via the tcpdump=C2=A0command.</div></div><div sty=
le=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" s=
tyle=3D"font-size:14px"><br></div></div><div style=3D"margin-top:4px;margin=
-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">The=
 following is a detailed description of a captured erroneous packet. The he=
x stream of the packet is as follows:</div></div><div style=3D"margin-top:4=
px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:=
14px">00163e0b6bd2eeffffffffff0800450000a50d7a40004006b94bc0a8f91dc0a8f91ed=
5d2145146f9d990e10d6a2d8010020040a200000101080a95ac86ba091145d3ffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
ffffffffffffffffffffffffffffffffffffffffffffffffffffffff</div></div><div st=
yle=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" =
style=3D"font-size:14px"><br></div></div><div style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">Th=
is is a packet in the format of eth + ipv4 + tcp=C2=A0+ payload.</div></div=
><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=
=3D"auto" style=3D"font-size:14px"><br></div></div><div style=3D"margin-top=
:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-siz=
e:14px">The process leading to the error is as follows:</div></div><div sty=
le=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" s=
tyle=3D"font-size:14px">1. Due to the small MSS, TSO fragmentation was trig=
gered, generating 3 mbufs.</div></div><div style=3D"margin-top:4px;margin-b=
ottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">2. Th=
e data_len of the first mbuf is 66 bytes, containing the Ethernet header, I=
Pv4 header, and TCP header.</div></div><div style=3D"margin-top:4px;margin-=
bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font-size:14px">3. T=
he data_len of the second mbuf is 61 bytes.</div></div><div style=3D"margin=
-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"font=
-size:14px">4. The data_len of the third mbuf is 52 bytes.</div></div><div =
style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto=
" style=3D"font-size:14px">5. When calculating the checksum of the TCP head=
er for such an mbuf chain using the rte_raw_cksum_mbuf function, the tmp va=
lue obtained during the calculation of the third mbuf is 0x19FFE6.</div></d=
iv><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=
=3D"auto" style=3D"font-size:14px">6. After applying rte_bswap16, tmp becom=
es 0xE6FF, with 0x19 discarded. This results in an incorrect final checksum=
.</div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6=
"><div dir=3D"auto" style=3D"font-size:14px"><br></div></div><div style=3D"=
margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=
=3D"font-size:14px">Meanwhile, we have also found that when=C2=A0enable=C2=
=A0jumbo frame, the payload becomes longer. In the process of rte_raw_cksum=
_mbuf handling an mbuf chain=EF=BC=8Cdue to the relatively large value of t=
mp, overflow will occur in the accumulated sum.</div></div><div style=3D"ma=
rgin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto" style=3D"=
font-size:14px"><br></div></div></div><div class=3D"history-quote-wrapper" =
id=3D"lark-mail-quote-175396149"><div><div id=3D"lark-mail-quote-175396132"=
 class=3D"history-quote-wrapper"><div class=3D"adit-html-block adit-html-bl=
ock--collapsed" style=3D"border-left:none;padding-left:0px"><div><div style=
=3D"padding:12px;background:rgb(245,246,247);color:rgb(31,35,41);border-rad=
ius:4px;margin-top:24px;margin-bottom:12px" id=3D"lark-mail-meta-sxFgpl8f3"=
 class=3D"adit-html-block__attr history-quote-meta-wrapper history-quote-ga=
p-tag"><div id=3D"lark-mail-quote-c30bb8b0ac376c844ff90352a50e58a0"><div st=
yle=3D"word-break:break-word"><div class=3D"lme-line-signal" style=3D""><sp=
an>From: </span> <span>&quot;Marat Khalili&quot;&lt;<a href=3D"mailto:marat=
.khalili@huawei.com" style=3D"white-space:pre-wrap;word-break:break-word;te=
xt-decoration:none;color:inherit" class=3D"quote-head-meta-mailto">marat.kh=
alili@huawei.com</a>&gt;</span></div><div class=3D"lme-line-signal" style=
=3D""><span>Date: </span> Thu, Jul 31, 2025, 19:04</div><div class=3D"lme-l=
ine-signal" style=3D""><span>Subject: </span> [External] RE: [PATCH] net/ck=
sum: compute raw cksum for several segments</div><div class=3D"lme-line-sig=
nal" style=3D""><span>To: </span> <span>&quot;=E8=8B=8F=E8=B5=9B&quot;&lt;<=
a href=3D"mailto:susai.ss@bytedance.com" style=3D"white-space:pre-wrap;word=
-break:break-word;text-decoration:none;color:inherit" class=3D"quote-head-m=
eta-mailto">susai.ss@bytedance.com</a>&gt;</span>, <span><span>&quot;<a hre=
f=3D"mailto:jasvinder.singh@intel.com" target=3D"_blank">jasvinder.singh@in=
tel.com</a>&quot;&lt;</span><a href=3D"mailto:jasvinder.singh@intel.com" st=
yle=3D"white-space:pre-wrap;word-break:break-word;text-decoration:none;colo=
r:inherit" class=3D"quote-head-meta-mailto">jasvinder.singh@intel.com</a>&g=
t;</span></div><div class=3D"lme-line-signal" style=3D""><span>Cc: </span> =
<span><span>&quot;<a href=3D"mailto:dev@dpdk.org" target=3D"_blank">dev@dpd=
k.org</a>&quot;&lt;</span><a href=3D"mailto:dev@dpdk.org" style=3D"white-sp=
ace:pre-wrap;word-break:break-word;text-decoration:none;color:inherit" clas=
s=3D"quote-head-meta-mailto">dev@dpdk.org</a>&gt;</span></div></div></div><=
/div><div><div class=3D"msg-t6C4UMzUURoWpfR lme-line-signal">


<style>.msg-t6C4UMzUURoWpfR p.MsoNormal,.msg-t6C4UMzUURoWpfR li.MsoNormal,.=
msg-t6C4UMzUURoWpfR div.MsoNormal{margin:0cm;font-size:11.0pt;font-family:"=
Calibri",sans-serif}.msg-t6C4UMzUURoWpfR p.MsoPlainText,.msg-t6C4UMzUURoWpf=
R li.MsoPlainText,.msg-t6C4UMzUURoWpfR div.MsoPlainText{margin:0cm;font-siz=
e:11.0pt;font-family:"Calibri",sans-serif}.msg-t6C4UMzUURoWpfR span.PlainTe=
xtChar{font-family:"Calibri",sans-serif}.msg-t6C4UMzUURoWpfR span.EmailStyl=
e21{font-family:"Calibri",sans-serif;color:windowtext}.msg-t6C4UMzUURoWpfR =
.MsoChpDefault{font-size:10.0pt}.msg-t6C4UMzUURoWpfR div.WordSection1{}</st=
yle>

<div class=3D"lme-line-signal" lang=3D"EN-US" style=3D"word-wrap:break-word=
">
<div class=3D"WordSection1 lme-line-signal">
<p class=3D"MsoPlainText lme-line-signal">Sorry, sent the previous email to=
o quickly.</p>
<p class=3D"MsoPlainText lme-line-signal">=C2=A0</p>
<p class=3D"MsoPlainText lme-line-signal">&gt; -----Original Message-----</=
p>
<div class=3D"lme-line-signal" id=3D"lark-mail-quote-b4c4f28bc71eb618fde98c=
2e56287d02"><p class=3D"MsoNormal lme-line-signal">&gt; From: Marat Khalili=
 </p>
<p class=3D"MsoNormal lme-line-signal">&gt; Sent: Thursday 31 July 2025 11:=
52</p>
<p class=3D"MsoNormal lme-line-signal">&gt; To: &#39;<span lang=3D"ZH-CN" s=
tyle=3D"font-family:DengXian">=E8=8B=8F=E8=B5=9B</span><span>&#39; &lt;<a h=
ref=3D"mailto:susai.ss@bytedance.com" rel=3D"nofollow noopener noreferrer">=
susai.ss@bytedance.com</a>&gt;; <a href=3D"mailto:jasvinder.singh@intel.com=
" rel=3D"nofollow noopener noreferrer">jasvinder.singh@intel.com</a></span>=
</p>
<p class=3D"MsoNormal lme-line-signal"><span>&gt; Cc: <a href=3D"mailto:dev=
@dpdk.org" rel=3D"nofollow noopener noreferrer">dev@dpdk.org</a></span></p>
<p class=3D"MsoNormal lme-line-signal">&gt; Subject: RE: [PATCH] net/cksum:=
 compute raw cksum for several segments</p>
<p class=3D"MsoNormal lme-line-signal">=C2=A0</p>
<p class=3D"MsoNormal lme-line-signal">&gt; &gt; +static inline uint16_t</p=
>
<p class=3D"MsoNormal lme-line-signal">&gt; &gt; +__rte_raw_cksum_reduce_u6=
4(uint64_t sum)</p>
<p class=3D"MsoNormal lme-line-signal">&gt; &gt; +{</p>
<p class=3D"MsoNormal lme-line-signal">&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint32_t tmp;</p>
<p class=3D"MsoNormal lme-line-signal">&gt; &gt; +</p>
<p class=3D"MsoNormal lme-line-signal">&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tmp =3D __rte_raw_cksum_reduce((uint32_t)sum);</p>
<p class=3D"MsoNormal lme-line-signal">&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tmp +=3D __rte_raw_cksum_reduce((uint32_t)(sum &gt;&gt; =
32));</p>
<p class=3D"MsoNormal lme-line-signal">&gt; </p>
<p class=3D"MsoNormal lme-line-signal">&gt; What if this addition overflows=
?</p>
<p class=3D"MsoNormal lme-line-signal">=C2=A0</p>
<p class=3D"MsoNormal lme-line-signal">Realized it cannot actually overflow=
, my bad (maybe still needs a comment). Now this function looks good to me =
as well.</p>
<p class=3D"MsoNormal lme-line-signal">=C2=A0</p>
<p class=3D"MsoNormal lme-line-signal">&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return __rte_raw_cksum_reduce(tmp);</p>
<p class=3D"MsoNormal lme-line-signal">&gt; &gt; +}</p>
</div></div>

</div></div></div></div></div></div></div></div></body></html>

--0000000000001b5118063b37fcb4--
