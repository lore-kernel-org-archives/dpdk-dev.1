Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28023CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 03:03:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4353940270;
	Tue, 12 Aug 2025 05:03:50 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id B46F64026C
 for <dev@dpdk.org>; Tue, 12 Aug 2025 05:03:48 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4b06d6cb45fso63747801cf.1
 for <dev@dpdk.org>; Mon, 11 Aug 2025 20:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754967828; x=1755572628; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4hpDx+OaV1hI5Mg9CROwdPrxHLPyQgHONQWJiSfTqOw=;
 b=h9rWZDymoPpY2Xy9AX7kc8p5DJbqakmN8z6aiEFyPFwU3te1R4Mk2n3wYNkPreIL9M
 WlVVo/Socj3d5unqIgx5of1KfWXUQsw3UKO69k8jBsv5QmC2/7UNSDkCzecFw/xaVCks
 5zHfhtI/52DVC/O0JoZtF4nBeaXqis38GQdFj/U2nkGAyaHzejHH8gEc9BYnC4/Uii12
 X27vKlxoOKaJLHYls/7tO2dKAHiZCG3m2YEUS1Qd6CebV2pj4IEB+jmQLF3D2iZ1mAjO
 2fvqS+2gVJ47UxRiNkCH4QFDNMqJVhFYvQWHKfwIsuNM57V0SZ0mwfYch867p0d1Hk/X
 pfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754967828; x=1755572628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4hpDx+OaV1hI5Mg9CROwdPrxHLPyQgHONQWJiSfTqOw=;
 b=YzCXY7PPf8x3x1yAgfgzsyaLjdqMwt3kSCmuyKFMMZMjT7b+hShQjCI32TahtRRS8T
 CiCzy34Kr+nkMywU4GJpbsb7pH8lYyzaB+2V5/kT0jckB81zQXhi0Yn+lc/he2UFqsHB
 gHB35Bzd6RwUB/CetPkPDNB+0OsHpKJ+7RenKdLT0aotpvxodh6NN+i1xQcHjOYQGGPX
 9BetBsfD6AGzbeCQy2JlFV92JcVPygdwS1J1fco11dXjw8zCcwy6+KY63AoARAmII4rF
 LLqMuFDHwKBpxWiuesEqRzI9H4zEUl+TgHDSvJlmvfJyDHEkbFZLSyqhwYBfgklgkFjm
 sgAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLYQvPDY+/NNpimoVUdO+N5/xw8KRYLactIfyBL+6r5jtW/zk2N9PR6D4xG5I6cd0O2HY=@dpdk.org
X-Gm-Message-State: AOJu0YxjpUFMB9TX8NwqjSbch4y3XmVtDmNZT9P9bRBHvS1b/Mi7gmMZ
 9a9jLWz0D+gUTBhs9qte7hUMaUmCekFQeLzJJU8WYVLi0lRZVK0OI1iniM4v6n2IUx9qnGg05BA
 alxCe+OYOXimUXCgeC394tQ1wL5hfLhA=
X-Gm-Gg: ASbGncuXiplgVFRt5FFZqBQuJhcAXcjUZ1bXNih2Dahmwud59ii676+xcYMjFr5Xr+p
 64WHKGMf3SN76u7W+NlqL4QMV83H+izbAwa5cC17cYjqlmjwxXulnJTCHjqeh5SJvrwhg3WuDTq
 YUgawLCb3n4p1Svkh105GwaqyLCSeZUG+pvYipLRfKvUPMXX1lqhyUjoW6FlOtAhoYPyGDkJXHe
 /lnlXc+2g==
X-Google-Smtp-Source: AGHT+IFJ5IfFrMV0ousJdRaOfyccoxaFZQEkTojdGDbFXo6K7T8MPjEj/WyLOG5OwUj+urOS+OfMsE5ddWda01ypoEM=
X-Received: by 2002:a05:622a:18a6:b0:4ab:66c5:b265 with SMTP id
 d75a77b69052e-4b0ecaeac57mr35082701cf.0.1754967827871; Mon, 11 Aug 2025
 20:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250803090837.15589edd@hermes.local>
 <20250804035430.4058391-1-spiderdetective.ss@gmail.com>
 <4313463.1IzOArtZ34@thomas>
In-Reply-To: <4313463.1IzOArtZ34@thomas>
From: su sai <spiderdetective.ss@gmail.com>
Date: Tue, 12 Aug 2025 11:03:36 +0800
X-Gm-Features: Ac12FXwubw3sYXzHU-4EFQHLn_-1MJDlZpsgRKj5iau-2jUo8Ondd35sC2RTzuU
Message-ID: <CAFQeoKi8W8WAYUY1OuSn+qMgG1c2V7PjLjEH608m894TpLOVvw@mail.gmail.com>
Subject: Re: [v3] net/cksum: compute raw cksum for several segments
To: Thomas Monjalon <thomas@monjalon.net>
Cc: stephen@networkplumber.org, dev@dpdk.org, 
 Marat Khalili <marat.khalili@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000f8fec7063c2249b3"
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

--000000000000f8fec7063c2249b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas Monjalon,

First, let's describe the scenario where we discovered the problem at that
time as follows:

This error can be reproduced as follows:
1. In the client ECS with an MTU of 1500, initiate traffic using the
command "iperf3 -c {dst ip} -b 1m -M 125 -t 8000". It will trigger TCP
segmentation.
2. On the host machine, TCP segmentation is performed through the
'rte_gso_segment' function.
3. After the gso, a packet in one mbuf will be split into multiple segments=
.
4. When calculating the TCP checksum using the 'rte_raw_cksum_mbuf'
function, it will enter the 'hard case: process checksum of several
segments' of the function. At this point, a calculation error may occur.
5. In the destination ECS, the InCsumErrors statistic can be viewed using
the command "netstat -st | grep -i csum". The erroneous packets can also be
confirmed via the tcpdump command.

The following is a detailed description of a captured erroneous packet.

The hex stream of the packet is as follows:
00163e0b6bd2eeffffffffff0800450000a50d7a40004006b94bc0a8f91dc0a8f91ed5d2145=
146f9d990e10d6a2d8010020040a200000101080a95ac86ba091145d3ffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
ffffffffffffffffffffffffffffffffffffffffffffffffff

This is a packet in the format of Eth + IPv4 + TCP + Payload.

Taking the above-mentioned packet as an example, the calculation process of
'rte_raw_cksum_mbuf' is as follows:
1. Due to the small MSS, TSO fragmentation was triggered, generating 3
mbufs.
2. The data_len of the first mbuf is 66 bytes, containing the Ethernet
header, IPv4 header, and TCP header.
3. The data_len of the second mbuf is 61 bytes.
4. The data_len of the third mbuf is 52 bytes.
5. When calculating the checksum of the TCP header for such an mbuf chain
using the rte_raw_cksum_mbuf function, the 'tmp' value obtained during the
calculation of the third mbuf is 0x19FFE6.
6. After applying rte_bswap16, tmp becomes 0xE6FF, with 0x19 discarded.
This results in an incorrect final checksum.

Second, Not all multiseg packets will cause calculation errors in the
'rte_raw_cksum_mbuf' function. There are two cases that can lead to
incorrect final results.
1. If the value of 'tmp' is greater than 0xFFFF, 'tmp =3D
rte_bswap16((uint16_t)tmp)' will drop high 16 bit.
2. Both 'tmp' and 'sum' is uint32_t, if the value of 'sum' is greater than
0xFFFFFFFF, 'sum +=3D tmp' will drop the carry when overflow.

Third, in our online cloud network, we found that the problem only occurs
when there are 3 or more segments. I believe that the aforementioned issue
may be triggered when there are 3 or more segments, but a test case with 3
segments is sufficient to detect this problem.

On Mon, Aug 11, 2025 at 10:42=E2=80=AFPM Thomas Monjalon <thomas@monjalon.n=
et>
wrote:

> Hello,
>
> 04/08/2025 05:54, Su Sai:
> > The rte_raw_cksum_mbuf function is used to compute
> > the raw checksum of a packet.
> > If the packet payload stored in multi mbuf, the function
> > will goto the hard case. In hard case,
> > the variable 'tmp' is a type of uint32_t,
> > so rte_bswap16 will drop high 16 bit.
> > Meanwhile, the variable 'sum' is a type of uint32_t,
> > so 'sum +=3D tmp' will drop the carry when overflow.
> > Both drop will make cksum incorrect.
> > This commit fixes the above bug.
>
> Thank you for the fix and the associated test.
>
> Please could describe the exact condition to get a wrong checksum?
> Does it happen with all multiseg packets?
> 3 segments is a minimum? Any other constraint to reproduce?
>
>
>

--000000000000f8fec7063c2249b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Thomas Monjalon,<br><br>First, let&#39;s describe the s=
cenario where we discovered the problem at that time as follows:<br><br>Thi=
s error can be reproduced as follows:<br>1. In the client ECS with an MTU o=
f 1500, initiate traffic using the command &quot;iperf3 -c {dst ip} -b 1m -=
M 125 -t 8000&quot;. It will trigger TCP segmentation.<br>2. On the host ma=
chine, TCP segmentation is performed through the &#39;rte_gso_segment&#39; =
function.<br>3. After the gso, a packet in one mbuf will be split into mult=
iple segments.<br>4. When calculating the TCP checksum using the &#39;rte_r=
aw_cksum_mbuf&#39; function, it will enter the &#39;hard case: process chec=
ksum of several segments&#39; of the function. At this point, a calculation=
 error may occur.<br>5. In the destination ECS, the InCsumErrors statistic =
can be viewed using the command &quot;netstat -st | grep -i csum&quot;. The=
 erroneous packets can also be confirmed via the tcpdump command.<br><br>Th=
e following is a detailed description of a captured erroneous packet. <br><=
br>The hex stream of the packet is as follows:<br>00163e0b6bd2eeffffffffff0=
800450000a50d7a40004006b94bc0a8f91dc0a8f91ed5d2145146f9d990e10d6a2d80100200=
40a200000101080a95ac86ba091145d3fffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
fffffffffffffffffffffffff<br><br>This is a packet in the format of Eth + IP=
v4 + TCP + Payload.<br><br>Taking the above-mentioned packet as an example,=
 the calculation process of &#39;rte_raw_cksum_mbuf&#39; is as follows:<br>=
1. Due to the small MSS, TSO fragmentation was triggered, generating 3 mbuf=
s.<br>2. The data_len of the first mbuf is 66 bytes, containing the Etherne=
t header, IPv4 header, and TCP header.<br>3. The data_len of the second mbu=
f is 61 bytes.<br>4. The data_len of the third mbuf is 52 bytes.<br>5. When=
 calculating the checksum of the TCP header for such an mbuf chain using th=
e rte_raw_cksum_mbuf function, the &#39;tmp&#39; value obtained during the =
calculation of the third mbuf is 0x19FFE6.<br>6. After applying rte_bswap16=
, tmp becomes 0xE6FF, with 0x19 discarded. This results in an incorrect fin=
al checksum.<br><br>Second, Not all multiseg packets will cause calculation=
 errors in the &#39;rte_raw_cksum_mbuf&#39; function. There are two cases t=
hat can lead to incorrect final results.<br>1. If the value of &#39;tmp&#39=
; is greater than 0xFFFF, &#39;tmp =3D rte_bswap16((uint16_t)tmp)&#39; will=
 drop high 16 bit.<br>2. Both &#39;tmp&#39; and &#39;sum&#39; is uint32_t, =
if the value of &#39;sum&#39; is greater than 0xFFFFFFFF, &#39;sum +=3D tmp=
&#39; will drop the carry when overflow.=C2=A0<br><br>Third, in our online =
cloud network, we found that the problem only occurs when there are 3 or mo=
re segments. I believe that the aforementioned issue may be triggered when =
there are 3 or more segments, but a test case with 3 segments is sufficient=
 to detect this problem.</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 11, 2025 at 10:42=
=E2=80=AFPM Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net">thom=
as@monjalon.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Hello,<br>
<br>
04/08/2025 05:54, Su Sai:<br>
&gt; The rte_raw_cksum_mbuf function is used to compute<br>
&gt; the raw checksum of a packet.<br>
&gt; If the packet payload stored in multi mbuf, the function<br>
&gt; will goto the hard case. In hard case,<br>
&gt; the variable &#39;tmp&#39; is a type of uint32_t,<br>
&gt; so rte_bswap16 will drop high 16 bit.<br>
&gt; Meanwhile, the variable &#39;sum&#39; is a type of uint32_t,<br>
&gt; so &#39;sum +=3D tmp&#39; will drop the carry when overflow.<br>
&gt; Both drop will make cksum incorrect.<br>
&gt; This commit fixes the above bug.<br>
<br>
Thank you for the fix and the associated test.<br>
<br>
Please could describe the exact condition to get a wrong checksum?<br>
Does it happen with all multiseg packets?<br>
3 segments is a minimum? Any other constraint to reproduce?<br>
<br>
<br>
</blockquote></div>

--000000000000f8fec7063c2249b3--
