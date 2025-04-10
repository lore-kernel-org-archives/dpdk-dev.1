Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218CFC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 12:29:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 933E340684;
	Thu, 10 Apr 2025 14:29:02 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 7BD9540666
 for <dev@dpdk.org>; Thu, 10 Apr 2025 14:29:01 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-306b78ae2d1so694875a91.3
 for <dev@dpdk.org>; Thu, 10 Apr 2025 05:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744288140; x=1744892940; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ynvSHrhiRzlcA+M+J4qLXHtHHcRoMOs541ykS5G9rR8=;
 b=I6yBGXNDZncirYXWDXznKRE7tm2eOrbAnx5L20ROVuBGizPfuQW1U4YcI/r34Q3nia
 pOBq8g6/xlXPa1ikvhxtxdKEXu1SKGiVmNK64YVl3k6DfCqlAvUSSIbPn4MMsWxKsHo6
 rVEGqp98cwy+WQW5L1HVNVYgqarHdFn9oZ6kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744288140; x=1744892940;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ynvSHrhiRzlcA+M+J4qLXHtHHcRoMOs541ykS5G9rR8=;
 b=aKNPlKh1ecq732Kjufbs72/NIQ7jtBHajLYDO6owvsImOWI5ytqBOgzsPWXYtYEDLR
 5Zq/Wytj4XBI8kGW46Br7qTCsUIr5ddsXY410CUaOS9trl/8GSLJbxXJ5q5Y+bSWgGWy
 4THZUG98iUaxtlq2ywAULabRgkEr3+ooWt3Xev07hDeP4B2grNIuExYH8G84pwlNoOsP
 CCHOIL2/tr5C7ss5CJnqSlDjsq4ynq6/bKiVXJxu+4CHNh6L3OTmV9wK7LnvaPmp6CNY
 mPhcxkcpxwHH5rzls6pc6iU8pLVqnNqzNe79V5ASK87FWpgAB+d00TMdHz+jSIMARyKk
 v0Ig==
X-Gm-Message-State: AOJu0YywA4KiihFKctyrOAZMSlilypU9pizfNCRnYRrsXpQ0AghmoMad
 dBp3NSPE0Rt4Pj28vARnC03GoREpzscmDxRGcsYtc/7MxVyPjIEUV83RroQTXiWys9trxpX5o6Y
 1a5DGqyve5CFTN7T0KPUl7CjDqgtJKyyau9MA3w==
X-Gm-Gg: ASbGncuJklKxs6AUCWMVceqaJ9nwjrzrIVHORahKfqM1+cdb0U5XZ17sYiA7skx+LNb
 CPyIx+U8sQajTG2U56w2mYgZW/+UjLDCJZAzf0ReqCef443lsD11AQaBj4TTQHN31+jPuv2/iEw
 cWlM0pUICmmT8GzWXn6wllaTGfloGqiJBAmbTrkOeN330BCHFCd7/X1oM=
X-Google-Smtp-Source: AGHT+IGzViJwRT8X6/VVXQqF3vYSzW+E9V9QQnl9oRebeRwyFuB1fTyZ9wAUz79TuMqE9w5h5EeSb8Znvoz6Ntz8lDA=
X-Received: by 2002:a17:90b:2e42:b0:2f9:d9fe:e72e with SMTP id
 98e67ed59e1d1-30718b8444dmr4556247a91.16.1744288140221; Thu, 10 Apr 2025
 05:29:00 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 10 Apr 2025 08:24:50 -0400
X-Gm-Features: ATxdqUEbTbBKU2y9FVrmVkWOmoe1BlnKmJD4p4sZ-2gxzX14XPbtXDE_obSOubY
Message-ID: <CAJvnSUCB4wicXzKsgewF70dgaoE=AoFpCbzzPr0nABwYLvgU1g@mail.gmail.com>
Subject: DTS 25.07 Roadmap
To: Paul Szczepanek <Paul.Szczepanek@arm.com>
Cc: dev <dev@dpdk.org>, ci@dpdk.org, Luca Vizzarro <Luca.Vizzarro@arm.com>, 
 Nicholas Pratte <npratte@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>, 
 Thomas Wilks <thomas.wilks@arm.com>, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
Content-Type: multipart/alternative; boundary="000000000000fc01b606326bba8b"
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

--000000000000fc01b606326bba8b
Content-Type: text/plain; charset="UTF-8"

Hello,

The DTS group has met and drawn up a development roadmap for the 25.07
release:


   1.

   Performance tests traffic generator support:
   1.

      TG abstractions rework, testsuite API additions for perf workloads,
      and TREX class implementation
      2.

   Testsuite additions:
   1.

      Performance tests: Perf_single_core_fwd
      2.

      Functional tests: rte_flow, Rx/Tx offload, port control, ethertype,
      stats checks, RSS Reta, RSS hash, packet capture
      3.

   Virtual function support (VF creation and handling for tests)
   1.

      PW: https://patchwork.dpdk.org/project/dpdk/list/?series=34851
      4.

   DTS Docs review and updates for helping new user onboarding to DTS usage
   5.

   Rework packet send and receive functions in the Testsuite API towards
   supporting IP networking in an L3 environment
   6.

   Add DPDK Testsuite API: This will provide a stable API which will not be
   broken going forward (except at agreed upon intervals)
   1.

      Moving existing testsuite class functions (what is essentially the
      current API) to the context hierarchy
      7.

   Add a dedicated file manager to handle passing files and artifacts
   between the test engine and nodes in a path agnostic manner. This will be a
   component of the new DPDK DTS API.
   8.

   Improved interactive shell data collection and logging.
   1.

      Add a log file which logs the shell interactions exclusively
      9.

   Update TestResult module in order to give a more human readable summary
   of the testsuites
   10.

   Flexible port binding
   1.

      Give the opportunity to test suites to use all or part of the
      supplied port topology with the kernel drivers (instead of DPDK).
      11.

   Add a pseudo-shell which handles background services.
   1.

      PW: https://patchwork.dpdk.org/project/dpdk/list/?series=34865
      12.

   Update certain functional tests in order to switch their packet matching
   strategy from mac address comparison to L4 port # comparison:
   1.

      PW: https://patchwork.dpdk.org/project/dpdk/list/?series=34805

--000000000000fc01b606326bba8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>The DTS group has met and drawn =
up a development roadmap for the 25.07 release:</div><div><br></div><div><s=
pan id=3D"gmail-docs-internal-guid-3015275f-7fff-0e74-30e7-e3665e742bb3"><o=
l style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-=
style-type:decimal;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,=
0,0);background-color:transparent;font-variant-numeric:normal;font-variant-=
east-asian:normal;font-variant-alternates:normal;vertical-align:baseline;wh=
ite-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;marg=
in-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;backgrou=
nd-color:transparent;font-variant-numeric:normal;font-variant-east-asian:no=
rmal;font-variant-alternates:normal;vertical-align:baseline">Performance te=
sts traffic generator support:=C2=A0</span></p></li><ol style=3D"margin-top=
:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:lower-alph=
a;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-c=
olor:transparent;font-variant-numeric:normal;font-variant-east-asian:normal=
;font-variant-alternates:normal;vertical-align:baseline;white-space:pre"><p=
 dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" ro=
le=3D"presentation"><span style=3D"font-size:11pt;background-color:transpar=
ent;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant=
-alternates:normal;vertical-align:baseline">TG abstractions rework, testsui=
te API additions for perf workloads, and TREX class implementation</span></=
p></li></ol><li dir=3D"ltr" style=3D"list-style-type:decimal;font-size:11pt=
;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent=
;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-al=
ternates:normal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" sty=
le=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentati=
on"><span style=3D"font-size:11pt;background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norm=
al;vertical-align:baseline">Testsuite additions:=C2=A0</span></p></li><ol s=
tyle=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-sty=
le-type:lower-alpha;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0=
,0,0);background-color:transparent;font-variant-numeric:normal;font-variant=
-east-asian:normal;font-variant-alternates:normal;vertical-align:baseline;w=
hite-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;mar=
gin-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;backgro=
und-color:transparent;font-variant-numeric:normal;font-variant-east-asian:n=
ormal;font-variant-alternates:normal;vertical-align:baseline">Performance t=
ests: Perf_single_core_fwd</span></p></li><li dir=3D"ltr" style=3D"list-sty=
le-type:lower-alpha;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0=
,0,0);background-color:transparent;font-variant-numeric:normal;font-variant=
-east-asian:normal;font-variant-alternates:normal;vertical-align:baseline;w=
hite-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;mar=
gin-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;backgro=
und-color:transparent;font-variant-numeric:normal;font-variant-east-asian:n=
ormal;font-variant-alternates:normal;vertical-align:baseline">Functional te=
sts: rte_flow, Rx/Tx offload, port control, ethertype, stats checks, RSS Re=
ta, RSS hash, packet capture</span></p></li></ol><li dir=3D"ltr" style=3D"l=
ist-style-type:decimal;font-size:11pt;font-family:Arial,sans-serif;color:rg=
b(0,0,0);background-color:transparent;font-variant-numeric:normal;font-vari=
ant-east-asian:normal;font-variant-alternates:normal;vertical-align:baselin=
e;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;=
margin-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;back=
ground-color:transparent;font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-variant-alternates:normal;vertical-align:baseline">Virtual fu=
nction support (VF creation and handling for tests)</span></p></li><ol styl=
e=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-=
type:lower-alpha;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,=
0);background-color:transparent;font-variant-numeric:normal;font-variant-ea=
st-asian:normal;font-variant-alternates:normal;vertical-align:baseline;whit=
e-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin=
-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background=
-color:transparent;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-variant-alternates:normal;vertical-align:baseline">PW: <a href=3D"h=
ttps://patchwork.dpdk.org/project/dpdk/list/?series=3D34851">https://patchw=
ork.dpdk.org/project/dpdk/list/?series=3D34851</a></span></p></li></ol><li =
dir=3D"ltr" style=3D"list-style-type:decimal;font-size:11pt;font-family:Ari=
al,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-nu=
meric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;=
vertical-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-heigh=
t:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=
=3D"font-size:11pt;background-color:transparent;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-ali=
gn:baseline">DTS Docs review and updates for helping new user onboarding to=
 DTS usage</span></p></li><li dir=3D"ltr" style=3D"list-style-type:decimal;=
font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-col=
or:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;f=
ont-variant-alternates:normal;vertical-align:baseline;white-space:pre"><p d=
ir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=
=3D"presentation"><span style=3D"font-size:11pt;background-color:transparen=
t;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-a=
lternates:normal;vertical-align:baseline">Rework packet send and receive fu=
nctions in the Testsuite API towards supporting IP networking in an L3 envi=
ronment</span></p></li><li dir=3D"ltr" style=3D"list-style-type:decimal;fon=
t-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:=
transparent;font-variant-numeric:normal;font-variant-east-asian:normal;font=
-variant-alternates:normal;vertical-align:baseline;white-space:pre"><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=
=3D"presentation"><span style=3D"font-size:11pt;background-color:transparen=
t;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-a=
lternates:normal;vertical-align:baseline">Add DPDK Testsuite API: This will=
 provide a stable API which will not be broken going forward (except at agr=
eed upon intervals)</span></p></li><ol style=3D"margin-top:0px;margin-botto=
m:0px"><li dir=3D"ltr" style=3D"list-style-type:lower-alpha;font-size:11pt;=
font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;=
font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alt=
ernates:normal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" styl=
e=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentatio=
n"><span style=3D"font-size:11pt;background-color:transparent;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norma=
l;vertical-align:baseline">Moving existing testsuite class functions (what =
is essentially the current API) to the context hierarchy</span></p></li></o=
l><li dir=3D"ltr" style=3D"list-style-type:decimal;font-size:11pt;font-fami=
ly:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:n=
ormal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line=
-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span =
style=3D"font-size:11pt;background-color:transparent;font-variant-numeric:n=
ormal;font-variant-east-asian:normal;font-variant-alternates:normal;vertica=
l-align:baseline">Add a dedicated file manager to handle passing files and =
artifacts between the test engine and nodes in a path agnostic manner. This=
 will be a component of the new DPDK DTS API.</span></p></li><li dir=3D"ltr=
" style=3D"list-style-type:decimal;font-size:11pt;font-family:Arial,sans-se=
rif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-a=
lign:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;mar=
gin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D"font-si=
ze:11pt;background-color:transparent;font-variant-numeric:normal;font-varia=
nt-east-asian:normal;font-variant-alternates:normal;vertical-align:baseline=
">Improved interactive shell data collection and logging.</span></p></li><o=
l style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-=
style-type:lower-alpha;font-size:11pt;font-family:Arial,sans-serif;color:rg=
b(0,0,0);background-color:transparent;font-variant-numeric:normal;font-vari=
ant-east-asian:normal;font-variant-alternates:normal;vertical-align:baselin=
e;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;=
margin-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;back=
ground-color:transparent;font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-variant-alternates:normal;vertical-align:baseline">Add a log =
file which logs the shell interactions exclusively</span></p></li></ol><li =
dir=3D"ltr" style=3D"list-style-type:decimal;font-size:11pt;font-family:Ari=
al,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-nu=
meric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;=
vertical-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-heigh=
t:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=
=3D"font-size:11pt;background-color:transparent;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-ali=
gn:baseline">Update TestResult module in order to give a more human readabl=
e summary of the testsuites</span></p></li><li dir=3D"ltr" style=3D"list-st=
yle-type:decimal;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,=
0);background-color:transparent;font-variant-numeric:normal;font-variant-ea=
st-asian:normal;font-variant-alternates:normal;vertical-align:baseline;whit=
e-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin=
-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background=
-color:transparent;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-variant-alternates:normal;vertical-align:baseline">Flexible port bi=
nding</span></p></li><ol style=3D"margin-top:0px;margin-bottom:0px"><li dir=
=3D"ltr" style=3D"list-style-type:lower-alpha;font-size:11pt;font-family:Ar=
ial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-n=
umeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal=
;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-heig=
ht:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=
=3D"font-size:11pt;background-color:transparent;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-ali=
gn:baseline">Give the opportunity to test suites to use all or part of the =
supplied port topology with the kernel drivers (instead of DPDK).</span></p=
></li></ol><li dir=3D"ltr" style=3D"list-style-type:decimal;font-size:11pt;=
font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;=
font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alt=
ernates:normal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" styl=
e=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentatio=
n"><span style=3D"font-size:11pt;background-color:transparent;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norma=
l;vertical-align:baseline">Add a pseudo-shell which handles background serv=
ices.</span></p></li><ol style=3D"margin-top:0px;margin-bottom:0px"><li dir=
=3D"ltr" style=3D"list-style-type:lower-alpha;font-size:11pt;font-family:Ar=
ial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-n=
umeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal=
;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-heig=
ht:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=
=3D"font-size:11pt;background-color:transparent;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-ali=
gn:baseline">PW: </span><span style=3D"font-size:11pt;background-color:tran=
sparent;font-variant-numeric:normal;font-variant-east-asian:normal;font-var=
iant-alternates:normal;vertical-align:baseline"><a href=3D"https://patchwor=
k.dpdk.org/project/dpdk/list/?series=3D34865">https://patchwork.dpdk.org/pr=
oject/dpdk/list/?series=3D34865</a></span></p></li></ol><li dir=3D"ltr" sty=
le=3D"list-style-type:decimal;font-size:11pt;font-family:Arial,sans-serif;c=
olor:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;fo=
nt-variant-east-asian:normal;font-variant-alternates:normal;vertical-align:=
baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-t=
op:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11=
pt;background-color:transparent;font-variant-numeric:normal;font-variant-ea=
st-asian:normal;font-variant-alternates:normal;vertical-align:baseline">Upd=
ate certain functional tests in order to switch their packet matching strat=
egy from mac address comparison to L4 port # comparison:</span></p></li><ol=
 style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-s=
tyle-type:lower-alpha;font-size:11pt;font-family:Arial,sans-serif;color:rgb=
(0,0,0);background-color:transparent;font-variant-numeric:normal;font-varia=
nt-east-asian:normal;font-variant-alternates:normal;vertical-align:baseline=
;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;m=
argin-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;backg=
round-color:transparent;font-variant-numeric:normal;font-variant-east-asian=
:normal;font-variant-alternates:normal;vertical-align:baseline">PW: </span>=
<span style=3D"font-size:11pt;background-color:transparent;font-variant-num=
eric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;v=
ertical-align:baseline"><a href=3D"https://patchwork.dpdk.org/project/dpdk/=
list/?series=3D34805">https://patchwork.dpdk.org/project/dpdk/list/?series=
=3D34805</a></span></p></li></ol></ol><br></span></div></div>

--000000000000fc01b606326bba8b--
