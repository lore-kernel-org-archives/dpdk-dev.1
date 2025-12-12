Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43147D59D8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 20:11:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 455AB4068E;
	Fri, 12 Dec 2025 21:11:22 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 337C54027D
 for <dev@dpdk.org>; Fri, 12 Dec 2025 21:11:21 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-34c27d14559so230326a91.2
 for <dev@dpdk.org>; Fri, 12 Dec 2025 12:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765570280; x=1766175080; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rlqujGESX1+jgLj+5YHh/fLJP/26T2K5JI4+ZBgVmEo=;
 b=XjrAktUrXMpxQvWuBTfFFMDaUNBmCCgLyLZ/3/F0uOJSeAKnHpHAefxqyoXQwomeUN
 U1DFxxKvWC8wHRPS8MaheP8DQKqCXLDHm00M9U/zWACJHvK26cuoXwK5OLW3NLouIsWw
 cInNO/wHq0M/m07V/9MEzlwUXba79iWFW/rQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765570280; x=1766175080;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rlqujGESX1+jgLj+5YHh/fLJP/26T2K5JI4+ZBgVmEo=;
 b=CMztX8XGSC6g8WbNQbArsfGZJhNGQHzgpx6VaFdHVEHTJi8Yry588UeGzzDOAo91KO
 d6R7Z2KnBW2VRjBQIQa3pLJToxi23GsltE5985lZQmRb3Xdg8LimYivsbfBeyVVTondb
 uYZxw+3kOHD9ihJM3l8/BtxEerD6C1d6MAI/ECXrBlEdrcus1TsWONItUnl2HLD8mb/z
 TmiEqKXz1NhjYbjsjVmoTCHHHup2Xv/bWLaeZ6AezROm9sz5h/UDjnPzHjtr3VPmKUlr
 YbgEImtS5jwD8irAmbEmSLjgnDRDWFuasqFyttcDgmGFx3Ts89FQGYiYRJApPNOcLVTm
 /t6A==
X-Gm-Message-State: AOJu0YyPl8CZz+ONtLNosGEuWX8bpXIJxyjpWIKh7NwFO87A2nI8lNrZ
 i2STnIOnSs1n3eXPP9NyybHapU/sEjU634tPURQjeMezAXYCiU2MYoWHFYtLqhyrVoliL1UylbT
 ciGco2xuG5F2ihs7RpPquoMeny9HEMN2Dy4u9AIrVnS+eXLcFDqyCBO2RcA==
X-Gm-Gg: AY/fxX6x2guEVwQGH8TSkjcLvWz3xKjBLoq8oZbWjs9y2dA5KMwTdUaEHMqt1aYkmeh
 xOKwuyPYBdOgCJM27xK5D21b/doWSAMkFq4xW5H2xkpXf8V0QqMu/62uriNKmNaEXj9CqxBLFy6
 WmfzNvBvKNjvpOCZnJ1Ihe6aZWx0TnbPgO3MWqRwbXRxzbkmjUm0trqBxZNz88HtWsMtgIrYnJm
 KrxR99mYKATDMLUi/TvlXL4dX25bBwc+Ah2lpxOwbhJwdaKkfpqWnQN+/QLz3Zpfth+cebvjfHW
 Z2Bh9xxntqS+qLtmuiGbfBIgYJ6F
X-Google-Smtp-Source: AGHT+IF6KCYsH+467l27+7LIdJINgSPj5AvkmVBaFEOSJJH+5onkpWtiCUu8Z+z6FVEtonps5Vsjr9KAezRmuLa/W0c=
X-Received: by 2002:a05:701b:2212:b0:119:e56b:98be with SMTP id
 a92af1059eb24-11f34c18fd7mr1750605c88.37.1765570279932; Fri, 12 Dec 2025
 12:11:19 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 12 Dec 2025 15:09:37 -0500
X-Gm-Features: AQt7F2pT779vT3CRXsoaNfTBdG4442z0D8KvH5qc9FwnnpyKWim0EINKLOhE4RQ
Message-ID: <CAJvnSUB6w6ipyyTuP6fGXiO+qg-pN0+S2KVQDAXNC1qyfVXd1A@mail.gmail.com>
Subject: 26.03 DTS Roadmap
To: dev <dev@dpdk.org>
Cc: Dean Marx <dmarx@iol.unh.edu>, Andrew Bailey <abailey@iol.unh.edu>, 
 Lincoln Lavoie <lylavoie@iol.unh.edu>,
 Paul Szczepanek <Paul.Szczepanek@arm.com>, 
 Luca Vizzarro <Luca.Vizzarro@arm.com>, ci@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000005c98110645c6dd24"
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

--0000000000005c98110645c6dd24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

The DTS group has met and agreed on the development goals for the 26.03
DPDK release.

Roadmap:

* DTS API

* Remove all existing framework imports and replace with imports from the
DTS API

* Cryptodev testing

* Adding a new cryptodev package to the DTS API for handling
dpdk-crypto-perf app arguments

* (testsuites) : Encrypt/decrypt workloads with the various supported
algorithms on DPDK crypto cards.

* Supporting DTS testruns on 1 physical host:

* Provide additional documentation and framework updates for testing on a
single host with a single NIC

* Virtio testing support:

* Enable additional testing topologies and scenarios (e.g. add a PvvP test
which is structured similar to the existing PvP test)

* Flow Offload Testsuites:

* Add a new testsuite which categorizes network protocols and their
respective valid field values by OSI layer, and creates all unique
combinations of these as flow rules. This should create =E2=80=9Ccomprehens=
ive=E2=80=9D
coverage of flow rules where previously we just had the minimal set of flow
offload rules tested.

* Asynchronous API testing

* Additional functional ethdev testsuites:

* Ethertype Testsuite

* QinQ testing: Extend this testsuite to validate that IDs are being stored
in the correct TCI / OUTER_TCI via testpmd verbose logs

* Add support for producing code coverage reports from a DTS testrun (so,
show how much of the DPDK code the testsuites are touching)

* Misc QoL improvements (e.g. update testsuite names for clarity)

--0000000000005c98110645c6dd24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font color=3D"#000000">Hello,</font><div><font color=3D"#=
000000"><br></font></div><div><font color=3D"#000000">The DTS group has met=
 and agreed on the development goals for the 26.03 DPDK release.</font></di=
v><div><font color=3D"#000000"><br></font></div><div><font color=3D"#000000=
">Roadmap:</font></div><div><span id=3D"gmail-docs-internal-guid-7ce0ce7f-7=
fff-13e6-0917-1556e9671c91"><font color=3D"#000000"><p dir=3D"ltr" style=3D=
"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-fam=
ily:Arial,sans-serif;background-color:transparent;font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-a=
lign:baseline">* DTS API</span></p><p dir=3D"ltr" style=3D"line-height:1.38=
;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-family:Arial,sans-se=
rif;background-color:transparent;font-variant-numeric:normal;font-variant-e=
ast-asian:normal;font-variant-alternates:normal;vertical-align:baseline"><s=
pan class=3D"gmail-Apple-tab-span" style=3D"text-wrap-mode: nowrap;">	</spa=
n></span><span style=3D"font-family:Arial,sans-serif;background-color:trans=
parent;font-variant-numeric:normal;font-variant-east-asian:normal;font-vari=
ant-alternates:normal;vertical-align:baseline">* Remove all existing framew=
ork imports and replace with imports from the DTS API</span></p><p dir=3D"l=
tr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-family:Arial,sans-serif;background-color:transparent;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norma=
l;vertical-align:baseline">* Cryptodev testing</span></p><p dir=3D"ltr" sty=
le=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"fon=
t-family:Arial,sans-serif;background-color:transparent;font-variant-numeric=
:normal;font-variant-east-asian:normal;font-variant-alternates:normal;verti=
cal-align:baseline"><span class=3D"gmail-Apple-tab-span" style=3D"text-wrap=
-mode: nowrap;">	</span></span><span style=3D"font-family:Arial,sans-serif;=
background-color:transparent;font-variant-numeric:normal;font-variant-east-=
asian:normal;font-variant-alternates:normal;vertical-align:baseline">* Addi=
ng a new cryptodev package to the DTS API for handling dpdk-crypto-perf app=
 arguments</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0p=
t;margin-bottom:0pt"><span style=3D"font-family:Arial,sans-serif;background=
-color:transparent;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-variant-alternates:normal;vertical-align:baseline"><span class=3D"g=
mail-Apple-tab-span" style=3D"text-wrap-mode: nowrap;">	</span></span><span=
 style=3D"font-family:Arial,sans-serif;background-color:transparent;font-va=
riant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates=
:normal;vertical-align:baseline">* (testsuites) : Encrypt/decrypt workloads=
 with the various supported algorithms on DPDK crypto cards.</span></p><p d=
ir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><spa=
n style=3D"font-family:Arial,sans-serif;background-color:transparent;font-v=
ariant-numeric:normal;font-variant-east-asian:normal;font-variant-alternate=
s:normal;vertical-align:baseline">* Supporting DTS testruns on 1 physical h=
ost:</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;marg=
in-bottom:0pt"><span style=3D"font-family:Arial,sans-serif;background-color=
:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;fon=
t-variant-alternates:normal;vertical-align:baseline"><span class=3D"gmail-A=
pple-tab-span" style=3D"text-wrap-mode: nowrap;">	</span></span><span style=
=3D"font-family:Arial,sans-serif;background-color:transparent;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norma=
l;vertical-align:baseline">* Provide additional documentation and framework=
 updates for testing on a single host with a single NIC</span></p><p dir=3D=
"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span sty=
le=3D"font-family:Arial,sans-serif;background-color:transparent;font-varian=
t-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:nor=
mal;vertical-align:baseline">* Virtio testing support:</span></p><p dir=3D"=
ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span styl=
e=3D"font-family:Arial,sans-serif;background-color:transparent;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norm=
al;vertical-align:baseline"><span class=3D"gmail-Apple-tab-span" style=3D"t=
ext-wrap-mode: nowrap;">	</span></span><span style=3D"font-family:Arial,san=
s-serif;background-color:transparent;font-variant-numeric:normal;font-varia=
nt-east-asian:normal;font-variant-alternates:normal;vertical-align:baseline=
">* Enable additional testing topologies and scenarios (e.g. add a PvvP tes=
t which is structured similar to the existing PvP test)</span></p><p dir=3D=
"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span sty=
le=3D"font-family:Arial,sans-serif;background-color:transparent;font-varian=
t-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:nor=
mal;vertical-align:baseline">* Flow Offload Testsuites:</span></p><p dir=3D=
"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span sty=
le=3D"font-family:Arial,sans-serif;background-color:transparent;font-varian=
t-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:nor=
mal;vertical-align:baseline"><span class=3D"gmail-Apple-tab-span" style=3D"=
text-wrap-mode: nowrap;">	</span></span><span style=3D"font-family:Arial,sa=
ns-serif;background-color:transparent;font-variant-numeric:normal;font-vari=
ant-east-asian:normal;font-variant-alternates:normal;vertical-align:baselin=
e">* Add a new testsuite which categorizes network protocols and their resp=
ective valid field values by OSI layer, and creates all unique combinations=
 of these as flow rules. This should create =E2=80=9Ccomprehensive=E2=80=9D=
 coverage of flow rules where previously we just had the minimal set of flo=
w offload rules tested.</span></p><p dir=3D"ltr" style=3D"line-height:1.38;=
margin-top:0pt;margin-bottom:0pt"><span style=3D"font-family:Arial,sans-ser=
if;background-color:transparent;font-variant-numeric:normal;font-variant-ea=
st-asian:normal;font-variant-alternates:normal;vertical-align:baseline"><sp=
an class=3D"gmail-Apple-tab-span" style=3D"text-wrap-mode: nowrap;">	</span=
></span><span style=3D"font-family:Arial,sans-serif;background-color:transp=
arent;font-variant-numeric:normal;font-variant-east-asian:normal;font-varia=
nt-alternates:normal;vertical-align:baseline">* Asynchronous API testing</s=
pan></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bott=
om:0pt"><span style=3D"font-family:Arial,sans-serif;background-color:transp=
arent;font-variant-numeric:normal;font-variant-east-asian:normal;font-varia=
nt-alternates:normal;vertical-align:baseline">* Additional functional ethde=
v testsuites:</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top=
:0pt;margin-bottom:0pt"><span style=3D"font-family:Arial,sans-serif;backgro=
und-color:transparent;font-variant-numeric:normal;font-variant-east-asian:n=
ormal;font-variant-alternates:normal;vertical-align:baseline"><span class=
=3D"gmail-Apple-tab-span" style=3D"text-wrap-mode: nowrap;">	</span></span>=
<span style=3D"font-family:Arial,sans-serif;background-color:transparent;fo=
nt-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alter=
nates:normal;vertical-align:baseline">* Ethertype Testsuite</span></p><p di=
r=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span=
 style=3D"font-family:Arial,sans-serif;background-color:transparent;font-va=
riant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates=
:normal;vertical-align:baseline"><span class=3D"gmail-Apple-tab-span" style=
=3D"text-wrap-mode: nowrap;">	</span></span><span style=3D"font-family:Aria=
l,sans-serif;background-color:transparent;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;vertical-align:bas=
eline">* QinQ testing: Extend this testsuite to validate that IDs are being=
 stored in the correct TCI / OUTER_TCI via testpmd verbose logs</span></p><=
p style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-family:Arial,sans-serif;background-color:transparent;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norma=
l;vertical-align:baseline">* Add support for producing code coverage report=
s from a DTS testrun (so, show how much of the DPDK code the testsuites are=
 touching)</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0p=
t;margin-bottom:0pt"><span style=3D"font-family:Arial,sans-serif;background=
-color:transparent;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-variant-alternates:normal;vertical-align:baseline">* Misc QoL impro=
vements (e.g. update testsuite names for clarity)</span></p></font></span><=
br class=3D"gmail-Apple-interchange-newline"></div></div>

--0000000000005c98110645c6dd24--
