Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A21EF48ED
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 08:49:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F23A9402B2;
	Fri, 13 Feb 2026 09:49:32 +0100 (CET)
Received: from authsmtp.register.it (authsmtp08.register.it [81.88.48.58])
 by mails.dpdk.org (Postfix) with ESMTP id AF5F0402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:49:30 +0100 (CET)
Received: from DESKTOPPE5KR91 ([95.231.224.119]) by cmsmtp with ESMTPSA
 id qorhvyYeREQSXqorhvwNbU; Fri, 13 Feb 2026 09:49:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outsys.org;
 s=key_65m6du3g3t; t=1770972570;
 bh=UYKyg0BE7T6nnH+G/YxuWV49EFA4k3gQz8ng7QFj7Do=;
 h=From:To:Cc:References:In-Reply-To:Subject:Date;
 b=OAO0R8qmX96z0khewXfDWkrxYkLzC5/jn3sp/J2lv6F31eWjSw+K6aAnF4XUnbbKE
 qWPZh2NIcp72OmSljLpuZhTmlgI7Sv5BBLwpWVHLNP4byPTDW/kTi420y9t/xPGZq+
 LIXQF34/aV4GSn/OVdly2U1WQtptNt/05hoHa6ZT6qid0egqnJLUpwWbhi+D+L9/Wm
 QnkvI2gJ9UvxrsFsnbw3Xu5k3xDeBtz1uLVfwORZmbAvaRyMhspub9kP1vtPXvtgK5
 Z7M7LkrsXp5/uKKSu7FVdpX9JXy9qX/0D6tHOdyo3WrQnu8uZOOhpYQzBtTMuF6y/y
 +0d73l4zNULtg==
X-Rid: smtp@outsys.eu@95.231.224.119
From: "Ernesto Ruffini" <eruffini@outsys.org>
To: "'Ayshathul Thuhara'" <ayshathul.thuhara@iwave-global.com>,
 <users@dpdk.org>
Cc: "'dev'" <dev@dpdk.org>,
	<yasu1976@gmail.com>
References: <PN0P287MB25319528772B121E0E380747C561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <PN0P287MB25319528772B121E0E380747C561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
Subject: RE: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)
 with DPDK v23.07
Date: Fri, 13 Feb 2026 09:49:33 +0100
Message-ID: <039201dc9cc5$acd5dee0$06819ca0$@outsys.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0393_01DC9CCE.0E9BA670"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHmp12vaPmWbH42Sqkb0yX68nXeOLVsOtMA
Content-Language: en-us
X-CMAE-Envelope: MS4xfJFirSFvJgncLKZWODCgbLmIU3IdoP1cK/Np43zZ9dwfyGVZ3GGJPdJ7yS4HwS3gtU9H3s1c4vjK7t9OScjlQ7d3KpW+3f5tZ46krrGA1vcPjJ6u/isN
 4Lc6AfY2KG+m50d+SlO8qokPGUgvPCHH1sCHzDqccOSlEBzAJpGEBIFX8lZaTmWD+bqbHye+t9iWV5m9bSisrSGsqclVZqNc9nJFf6Go7nfnNilyPDP3BAG8
 k8QLXHa5nh0eyuP2nENOYAQHwBmwTlQSF0PAm/Lfl2qSYIf9C0xG00RmtigO3qc1
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

------=_NextPart_000_0393_01DC9CCE.0E9BA670
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ayshathul,

I think the best is to follow
https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance_report.pdf

Did you check with ethtool or similar the actual connection speed? ethtool
linux-nic-name | grep Speed

Maybe your module limits it to 10Gbps. In case try to disable
auto-negotiation

 

Regards,

               Ernesto

 

From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com> 
Sent: Friday, February 13, 2026 07:36
To: users@dpdk.org
Cc: dev <dev@dpdk.org>; yasu1976@gmail.com
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

 


------=_NextPart_000_0393_01DC9CCE.0E9BA670
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
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
span.EmailStyle19
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
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>Hi =
</span><span style=3D'color:black'>Ayshathul</span><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>,<o:p></o:p><=
/span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>I think the =
best is to follow <a =
href=3D"https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performance_=
report.pdf">https://fast.dpdk.org/doc/perf/DPDK_23_11_NVIDIA_NIC_performa=
nce_report.pdf</a><o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>Did you =
check with ethtool or similar the actual connection speed? ethtool =
linux-nic-name | grep Speed<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>Maybe your =
module limits it to 10Gbps. In case try to disable =
auto-negotiation<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'><o:p>&nbsp;</=
o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>Regards,<o:p>=
</o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Ernesto<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'><o:p>&nbsp;</=
o:p></span></p><div><div style=3D'border:none;border-top:solid #E1E1E1 =
1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><b><span =
style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'>From:</span><=
/b><span style=3D'font-size:11.0pt;font-family:"Calibri",sans-serif'> =
Ayshathul Thuhara &lt;ayshathul.thuhara@iwave-global.com&gt; =
<br><b>Sent:</b> Friday, February 13, 2026 07:36<br><b>To:</b> =
users@dpdk.org<br><b>Cc:</b> dev &lt;dev@dpdk.org&gt;; =
yasu1976@gmail.com<br><b>Subject:</b> Guidance Required to Improve =
Throughput on ConnectX-7 (1x400G) with DPDK =
v23.07<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3DMsoNormal><span style=3D'color:black'>Dear =
Team,<o:p></o:p></span></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3DMsoNormal><span style=3D'color:black'>I hope this message finds =
you well.<o:p></o:p></span></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3DMsoNormal><span style=3D'color:black'>I am currently performing =
testing on ConnectX-7 with 1x400G hardware using DPDK v23.07. However, I =
am unable to achieve data transfer rates beyond 10 Gbps. While reviewing =
the DPDK mailing list, I came across your previous responses in the =
related discussion (<a =
href=3D"https://mails.dpdk.org/archives/users/2024-July/007767.html" =
target=3D"_new" =
id=3DOWAe131b2f8-ca05-2ff3-d67e-40e6b9de2cd3>https://mails.dpdk.org/archi=
ves/users/2024-July/007767.html</a>), where you mentioned achieving =
throughput of around 250 Gbps and above.<o:p></o:p></span></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3DMsoNormal><span style=3D'color:black'>Could you kindly advise on =
the configuration changes or optimizations required to improve =
throughput in this setup?<o:p></o:p></span></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3DMsoNormal><span style=3D'color:black'>For reference, I am using =
an OSFP loopback module for testing, where the same port is used for =
both transmission and reception (single-port loopback =
setup).<o:p></o:p></span></p></div><div><p class=3DMsoNormal><b><span =
style=3D'color:black'>CX-7 Firmware: 28.45.1200</span></b><span =
style=3D'color:black'><o:p></o:p></span></p></div><div><p =
class=3DMsoNormal><b><span style=3D'color:black'>CPU : Intel(R) Core(TM) =
i7-14700</span></b><span =
style=3D'color:black'><o:p></o:p></span></p></div><div><p =
class=3DMsoNormal><b><span style=3D'color:black'>Command used : sudo =
./build/app/dpdk-testpmd -a 01:00.0 -- -i</span></b><span =
style=3D'color:black'><o:p></o:p></span></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3DMsoNormal><span style=3D'color:black'>I would greatly appreciate =
your guidance.<o:p></o:p></span></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3DMsoNormal><span style=3D'color:black'>Thank you in advance, and =
I look forward to your response.<o:p></o:p></span></p></div><div =
style=3D'margin-top:12.0pt;margin-bottom:12.0pt'><p =
class=3DMsoNormal><span style=3D'color:black'>Thanks and =
regards,<br>Ayshathul Thuhara<o:p></o:p></span></p></div><div><p =
class=3DMsoNormal><span =
style=3D'color:black'><o:p>&nbsp;</o:p></span></p></div></div></body></ht=
ml>
------=_NextPart_000_0393_01DC9CCE.0E9BA670--

