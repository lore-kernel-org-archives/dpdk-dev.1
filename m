Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39243EDF146
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F180F402BE;
	Fri, 13 Feb 2026 11:09:10 +0100 (CET)
Received: from authsmtp.register.it (authsmtp14.register.it [81.88.48.37])
 by mails.dpdk.org (Postfix) with ESMTP id 9815A40287
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:09:09 +0100 (CET)
Received: from DESKTOPPE5KR91 ([95.231.224.119]) by cmsmtp with ESMTPSA
 id qq6mvhDbbXx9aqq6mv1u2X; Fri, 13 Feb 2026 11:09:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outsys.org;
 s=key_65m6du3g3t; t=1770977349;
 bh=lZtH1Umr/5W4wqzya3R/i0lznhrz7IN/qNJi0cPK25o=;
 h=From:To:Cc:References:In-Reply-To:Subject:Date;
 b=P2sYjNrc56RE7LxX8/9jIkkcRYRiXzsFGUlcgm2WHY/FR48wwiEH2xxJaEMCEwhSB
 egM6uIi4BJgwl3fDWXh8pj+fDxb2PzGMoc2S+dZ795OZBfz3TQ+rBqryHRnEZ/lgUz
 npByL/uf34puM6CDMfhvj5CvN8qDGOjehYNFpR3epJ13QZNRIVnePJ7LdbbLYcGybJ
 RYNn1SW+SYsnmmjKEcZ5FutRlgMvvXV703Nh2ZStAPbhGT3+RogvxTidutHqwAzqib
 94e6GD7JSyQjk3WUYNP4HRlshOegPBZED1RNaEUXaFObbcpQUmZIWrKaVBOP+Bz2DS
 fKi+PRzFmDUIA==
X-Rid: smtp@outsys.eu@95.231.224.119
From: "Ernesto Ruffini" <eruffini@outsys.org>
To: "'Ayshathul Thuhara'" <ayshathul.thuhara@iwave-global.com>
Cc: "'dev'" <dev@dpdk.org>,
	<yasu1976@gmail.com>,
	<users@dpdk.org>
References: <PN0P287MB25319528772B121E0E380747C561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <039201dc9cc5$acd5dee0$06819ca0$@outsys.org>
 <PN0P287MB2531B462677B1BDBAE41AA15C561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531BFD1D63007182EFA3E5CC561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <PN0P287MB2531BFD1D63007182EFA3E5CC561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
Subject: RE: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)
 with DPDK v23.07
Date: Fri, 13 Feb 2026 11:09:11 +0100
Message-ID: <03ad01dc9cd0$cd2cfb00$6786f100$@outsys.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_03AE_01DC9CD9.2EF24D60"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHmp12vaPmWbH42Sqkb0yX68nXeOAGes56SAuOHRIcC8/Jiu7UwoEkg
Content-Language: en-us
X-CMAE-Envelope: MS4xfPownyXNTi9FLAUVHxPfKqIock3In16iucw5xyZ5cgCCdblSLmcj49JIhICcVQ9av94OlwJTpMDtlRGiM2mNSoMec/2AEHfhRq4QskgxHE6I7/SGU4H+
 GidRKTwjLi4AE0HPg2zQQt4ryWl6vvsQzJK1HAEAKE2R2T1tP8neGM0z5gWMOxHHGC1N8EVcQU+Xaa/FbEsd2OPPKzHesx/0JWP3xYAOptWR3ZdWsGYagwGX
 GemkTeYGnHL34PDoQne0VhofqJcmdQxmSDasaEE3nvydf040MiWsAJFxydlnJQAG
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

This is a multipart message in MIME format.

------=_NextPart_000_03AE_01DC9CD9.2EF24D60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ayshathul Thuhara,

l3fwd parameters in the doc are important: they say how many cores/queues to
use.

Try playing with them, adding testpmd specific parameters.

 

sudo ./build/app/dpdk-testpmd -a 01:00.0 -l
0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 -- -i --rxq=16 --txq=16
--nb-cores=16

 

Regards,

               Ernesto

 

 

From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com> 
Sent: Friday, February 13, 2026 10:04
To: Ernesto Ruffini <eruffini@outsys.org>
Cc: 'dev' <dev@dpdk.org>; yasu1976@gmail.com; users@dpdk.org
Subject: Re: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)
with DPDK v23.07

 

Hi Ernesto,

As an additional observation, I tested the setup using iperf3 and was able
to achieve throughput of approximately 92~95 Gbps. However, when running the
DPDK-Testpmd application, the throughput does not reach similar values.

Thanks and regards,
Ayshathul Thuhara

 

  _____  

From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com
<mailto:ayshathul.thuhara@iwave-global.com> >
Sent: 13 February 2026 14:24
To: Ernesto Ruffini <eruffini@outsys.org <mailto:eruffini@outsys.org> >
Cc: 'dev' <dev@dpdk.org <mailto:dev@dpdk.org> >; yasu1976@gmail.com
<mailto:yasu1976@gmail.com>  <yasu1976@gmail.com <mailto:yasu1976@gmail.com>
>; users@dpdk.org <mailto:users@dpdk.org>  <users@dpdk.org
<mailto:users@dpdk.org> >
Subject: Re: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)
with DPDK v23.07 

 

Hi Ernesto, 

 

Thankyou for the suggestion.

I will look into
"https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance_report.pdf
" , but here the tests uses external device for traffic generator.

 

Yes, with ethtool it shows 400Gbps.

The module can support upto 100Gbps. But it should have increased more than
10Gbps. I will disable AN and check once.

 

Thanks and regards, 

Ayshathul Thuhara

 

  _____  

From: Ernesto Ruffini <eruffini@outsys.org <mailto:eruffini@outsys.org> >
Sent: 13 February 2026 14:19
To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com
<mailto:ayshathul.thuhara@iwave-global.com> >; users@dpdk.org
<mailto:users@dpdk.org>  <users@dpdk.org <mailto:users@dpdk.org> >
Cc: 'dev' <dev@dpdk.org <mailto:dev@dpdk.org> >; yasu1976@gmail.com
<mailto:yasu1976@gmail.com>  <yasu1976@gmail.com <mailto:yasu1976@gmail.com>
>
Subject: RE: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)
with DPDK v23.07 

 

Hi Ayshathul,

I think the best is to follow
https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance_report.pdf

Did you check with ethtool or similar the actual connection speed? ethtool
linux-nic-name | grep Speed

Maybe your module limits it to 10Gbps. In case try to disable
auto-negotiation

 

Regards,

               Ernesto

 

From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com
<mailto:ayshathul.thuhara@iwave-global.com> > 
Sent: Friday, February 13, 2026 07:36
To: users@dpdk.org <mailto:users@dpdk.org> 
Cc: dev <dev@dpdk.org <mailto:dev@dpdk.org> >; yasu1976@gmail.com
<mailto:yasu1976@gmail.com> 
Subject: Guidance Required to Improve Throughput on ConnectX-7 (1x400G) with
DPDK v23.07

 

Dear Team,

I hope this message finds you well.

I am currently performing testing on ConnectX-7 with 1x400G hardware using
DPDK v23.07. However, I am unable to achieve data transfer rates beyond 10
Gbps. While reviewing the DPDK mailing list, I came across your previous
responses in the related discussion
(https://mails.dpdk.org/archives/users/2024-July/007767.html), where you
mentioned achieving throughput of around 250 Gbps and above.

Could you kindly advise on the configuration changes or optimizations
required to improve throughput in this setup?

For reference, I am using an OSFP loopback module for testing, where the
same port is used for both transmission and reception (single-port loopback
setup).

CX-7 Firmware: 28.45.1200

CPU : Intel(R) Core(TM) i7-14700

Command used : sudo ./build/app/dpdk-testpmd -a 01:00.0 -- -i

I would greatly appreciate your guidance.

Thank you in advance, and I look forward to your response.

Thanks and regards,
Ayshathul Thuhara

 


------=_NextPart_000_03AE_01DC9CD9.2EF24D60
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><!--[if !mso]><style>v\:* =
{behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.elementtoproof
	{mso-style-name:elementtoproof;}
span.xelementtoproof
	{mso-style-name:x_elementtoproof;}
p.xxmsonormal, li.xxmsonormal, div.xxmsonormal
	{mso-style-name:x_x_msonormal;
	margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",serif;}
span.EmailStyle26
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DEN-US link=3Dblue vlink=3Dpurple =
style=3D'word-wrap:break-word'><div class=3DWordSection1><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>Hi Ayshathul =
Thuhara,<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>l3fwd =
parameters in the doc are important: they say how many cores/queues to =
use.<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>Try playing =
with them, adding testpmd specific parameters.<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'><o:p>&nbsp;</=
o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>sudo =
./build/app/dpdk-testpmd -a 01:00.0 -l =
0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 -- -i --rxq=3D16 --txq=3D16 =
--nb-cores=3D16<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'><o:p>&nbsp;</=
o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>Regards,<o:p>=
</o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Ernesto<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'><o:p>&nbsp;</=
o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'><o:p>&nbsp;</=
o:p></span></p><div><div style=3D'border:none;border-top:solid #E1E1E1 =
1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><b><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>From:</span><=
/b><span style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'> =
Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&gt; =
<br><b>Sent:</b> Friday, February 13, 2026 10:04<br><b>To:</b> Ernesto =
Ruffini &lt;eruffini@outsys.org&gt;<br><b>Cc:</b> 'dev' =
&lt;dev@dpdk.org&gt;; yasu1976@gmail.com; =
users@dpdk.org<br><b>Subject:</b> Re: Guidance Required to Improve =
Throughput on ConnectX-7 (1x400G) with DPDK =
v23.07<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3DMsoNormal><span class=3Delementtoproof><span =
style=3D'color:black'>Hi Ernesto,</span></span><span =
style=3D'color:black'><o:p></o:p></span></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3DMsoNormal><span class=3Delementtoproof><span =
style=3D'color:black'>As an additional observation, I tested the setup =
using iperf3 and was able to achieve throughput of approximately 92~95 =
Gbps. However, when running the DPDK-Testpmd application, the throughput =
does not reach similar values.</span></span><span =
style=3D'color:black'><o:p></o:p></span></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3DMsoNormal><span class=3Delementtoproof><span =
style=3D'color:black'>Thanks and regards,</span></span><span =
style=3D'color:black'><br><span class=3Delementtoproof>Ayshathul =
Thuhara</span><o:p></o:p></span></p></div><div><p =
class=3DMsoNormal><span =
style=3D'color:black'><o:p>&nbsp;</o:p></span></p></div><div =
class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><hr =
size=3D2 width=3D"98%" align=3Dcenter></div><div id=3DdivRplyFwdMsg><p =
class=3DMsoNormal><b><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'>F=
rom:</span></b><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'> =
Ayshathul Thuhara &lt;<a =
href=3D"mailto:ayshathul.thuhara@iwave-global.com">ayshathul.thuhara@iwav=
e-global.com</a>&gt;<br><b>Sent:</b> 13 February 2026 =
14:24<br><b>To:</b> Ernesto Ruffini &lt;<a =
href=3D"mailto:eruffini@outsys.org">eruffini@outsys.org</a>&gt;<br><b>Cc:=
</b> 'dev' &lt;<a href=3D"mailto:dev@dpdk.org">dev@dpdk.org</a>&gt;; <a =
href=3D"mailto:yasu1976@gmail.com">yasu1976@gmail.com</a> &lt;<a =
href=3D"mailto:yasu1976@gmail.com">yasu1976@gmail.com</a>&gt;; <a =
href=3D"mailto:users@dpdk.org">users@dpdk.org</a> &lt;<a =
href=3D"mailto:users@dpdk.org">users@dpdk.org</a>&gt;<br><b>Subject:</b> =
Re: Guidance Required to Improve Throughput on ConnectX-7 (1x400G) with =
DPDK v23.07</span> <o:p></o:p></p><div><p =
class=3DMsoNormal>&nbsp;<o:p></o:p></p></div></div><div><div><p =
class=3DMsoNormal><span style=3D'color:black'>Hi =
Ernesto,&nbsp;<o:p></o:p></span></p></div><div><p =
class=3DMsoNormal><span =
style=3D'color:black'><o:p>&nbsp;</o:p></span></p></div><div><p =
class=3DMsoNormal><span style=3D'color:black'>Thankyou for the =
suggestion.<o:p></o:p></span></p></div><div><p class=3DMsoNormal><span =
style=3D'color:black'>I will look into &quot;</span><span =
class=3Dxelementtoproof><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'><=
a =
href=3D"https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance_=
report.pdf" target=3D"_blank" =
title=3D"https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance=
_report.pdf" =
id=3DOWAeff86e8d-ad77-3696-fe19-ea870b99fa63>https://fast.dpdk.org/doc/pe=
rf/DPDK_23_11_NVIDIA_NIC_performance_report.pdf</a>&quot; , but here the =
tests uses external device for traffic generator.</span></span><span =
style=3D'color:black'><o:p></o:p></span></p></div><div><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'><=
o:p>&nbsp;</o:p></span></p></div><div><p class=3DMsoNormal><span =
class=3Dxelementtoproof><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'>Y=
es, with ethtool it shows 400Gbps.</span></span><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'><=
o:p></o:p></span></p></div><div><p class=3DMsoNormal><span =
class=3Dxelementtoproof><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'>T=
he module can support upto 100Gbps. But it should have increased more =
than 10Gbps. I will disable AN and check once.</span></span><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'><=
o:p></o:p></span></p></div><div><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'><=
o:p>&nbsp;</o:p></span></p></div><div><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'>T=
hanks and regards,&nbsp;<o:p></o:p></span></p></div><div><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'>A=
yshathul Thuhara<o:p></o:p></span></p></div><div><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'><=
o:p>&nbsp;</o:p></span></p></div><div class=3DMsoNormal align=3Dcenter =
style=3D'text-align:center'><hr size=3D2 width=3D"98%" =
align=3Dcenter></div><div id=3D"x_divRplyFwdMsg"><p =
class=3DMsoNormal><b><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'>F=
rom:</span></b><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif;color:black'> =
Ernesto Ruffini &lt;<a =
href=3D"mailto:eruffini@outsys.org">eruffini@outsys.org</a>&gt;<br><b>Sen=
t:</b> 13 February 2026 14:19<br><b>To:</b> Ayshathul Thuhara &lt;<a =
href=3D"mailto:ayshathul.thuhara@iwave-global.com">ayshathul.thuhara@iwav=
e-global.com</a>&gt;; <a =
href=3D"mailto:users@dpdk.org">users@dpdk.org</a> &lt;<a =
href=3D"mailto:users@dpdk.org">users@dpdk.org</a>&gt;<br><b>Cc:</b> =
'dev' &lt;<a href=3D"mailto:dev@dpdk.org">dev@dpdk.org</a>&gt;; <a =
href=3D"mailto:yasu1976@gmail.com">yasu1976@gmail.com</a> &lt;<a =
href=3D"mailto:yasu1976@gmail.com">yasu1976@gmail.com</a>&gt;<br><b>Subje=
ct:</b> RE: Guidance Required to Improve Throughput on ConnectX-7 =
(1x400G) with DPDK v23.07</span> <o:p></o:p></p><div><p =
class=3DMsoNormal>&nbsp;<o:p></o:p></p></div></div><div><div><p =
class=3Dxxmsonormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>Hi =
</span><span style=3D'color:black'>Ayshathul</span><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>,</span><o:p>=
</o:p></p><p class=3Dxxmsonormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>I think the =
best is to follow <a =
href=3D"https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance_=
report.pdf">https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performa=
nce_report.pdf</a></span><o:p></o:p></p><p class=3Dxxmsonormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>Did you =
check with ethtool or similar the actual connection speed? ethtool =
linux-nic-name | grep Speed</span><o:p></o:p></p><p =
class=3Dxxmsonormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>Maybe your =
module limits it to 10Gbps. In case try to disable =
auto-negotiation</span><o:p></o:p></p><p class=3Dxxmsonormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>&nbsp;</span>=
<o:p></o:p></p><p class=3Dxxmsonormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>Regards,</spa=
n><o:p></o:p></p><p class=3Dxxmsonormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Ernesto</span><o:p></o:p></p><p class=3Dxxmsonormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>&nbsp;</span>=
<o:p></o:p></p><div><div style=3D'border:none;border-top:solid #E1E1E1 =
1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3Dxxmsonormal><b><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>From:</span><=
/b><span style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'> =
Ayshathul Thuhara &lt;<a =
href=3D"mailto:ayshathul.thuhara@iwave-global.com">ayshathul.thuhara@iwav=
e-global.com</a>&gt; <br><b>Sent:</b> Friday, February 13, 2026 =
07:36<br><b>To:</b> <a =
href=3D"mailto:users@dpdk.org">users@dpdk.org</a><br><b>Cc:</b> dev =
&lt;<a href=3D"mailto:dev@dpdk.org">dev@dpdk.org</a>&gt;; <a =
href=3D"mailto:yasu1976@gmail.com">yasu1976@gmail.com</a><br><b>Subject:<=
/b> Guidance Required to Improve Throughput on ConnectX-7 (1x400G) with =
DPDK v23.07</span><o:p></o:p></p></div></div><p =
class=3Dxxmsonormal>&nbsp;<o:p></o:p></p><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3Dxxmsonormal><span style=3D'color:black'>Dear =
Team,</span><o:p></o:p></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3Dxxmsonormal><span style=3D'color:black'>I hope this message =
finds you well.</span><o:p></o:p></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3Dxxmsonormal><span style=3D'color:black'>I am currently =
performing testing on ConnectX-7 with 1x400G hardware using DPDK v23.07. =
However, I am unable to achieve data transfer rates beyond 10 Gbps. =
While reviewing the DPDK mailing list, I came across your previous =
responses in the related discussion (<a =
href=3D"https://mails.dpdk.org/archives/users/2024-July/007767.html" =
target=3D"_new" =
id=3DOWAe131b2f8-ca05-2ff3-d67e-40e6b9de2cd3>https://mails.dpdk.org/archi=
ves/users/2024-July/007767.html</a>), where you mentioned achieving =
throughput of around 250 Gbps and above.</span><o:p></o:p></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3Dxxmsonormal><span style=3D'color:black'>Could you kindly advise =
on the configuration changes or optimizations required to improve =
throughput in this setup?</span><o:p></o:p></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3Dxxmsonormal><span style=3D'color:black'>For reference, I am =
using an OSFP loopback module for testing, where the same port is used =
for both transmission and reception (single-port loopback =
setup).</span><o:p></o:p></p></div><div><p class=3Dxxmsonormal><b><span =
style=3D'color:black'>CX-7 Firmware: =
28.45.1200</span></b><o:p></o:p></p></div><div><p =
class=3Dxxmsonormal><b><span style=3D'color:black'>CPU : Intel(R) =
Core(TM) i7-14700</span></b><o:p></o:p></p></div><div><p =
class=3Dxxmsonormal><b><span style=3D'color:black'>Command used : sudo =
./build/app/dpdk-testpmd -a 01:00.0 -- =
-i</span></b><o:p></o:p></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3Dxxmsonormal><span style=3D'color:black'>I would greatly =
appreciate your guidance.</span><o:p></o:p></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3Dxxmsonormal><span style=3D'color:black'>Thank you in advance, =
and I look forward to your response.</span><o:p></o:p></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3Dxxmsonormal><span style=3D'color:black'>Thanks and =
regards,<br>Ayshathul Thuhara</span><o:p></o:p></p></div><div><p =
class=3Dxxmsonormal><span =
style=3D'color:black'>&nbsp;</span><o:p></o:p></p></div></div></div></div=
></div></body></html>
------=_NextPart_000_03AE_01DC9CD9.2EF24D60--

