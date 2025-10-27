Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2D7CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 13:52:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B4F1402A6;
	Wed, 29 Oct 2025 14:52:42 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id F12404028C
 for <dev@dpdk.org>; Mon, 27 Oct 2025 17:59:12 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-339d7c403b6so4903982a91.2
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761584352; x=1762189152; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Cu+3t/eyT8ZIfY9IFqomNhmzJgRnnNblNo8MmxxL8kA=;
 b=JDV9IWtn0pCSKaya28ZVs4JP3uS9J41yRgQK6HfoNyvkJusF3zmV7vlf2XVLal8sFs
 9chzvJUpVnapSa5/mdEpAuhrzx7dGCVMfCWwk3R0cpqOnnUDe1X0zBj5I1+LyIb4lxgo
 sKacVSwHjzYtqapqH3G5TIOmsA5HWbM5RO6EuFUvaZ7Tu2dSXPDtv9f+KYjxXtHRU0LJ
 x+MCXhgf47xlvwWOpics9eh8siFmSsmAbn3bxOyeLoeSp+OQCRU3R5hxDJB0TSpKoy5E
 2zAWWm8pQsuWqn9oemL/Nbbn6iFUvtkHK5v2F6D9K3zj9UYdsB8JT6SfHoyIg7WbatTa
 812g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584352; x=1762189152;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cu+3t/eyT8ZIfY9IFqomNhmzJgRnnNblNo8MmxxL8kA=;
 b=rwgx4053dABvnX+jz5TqKxTNfwq626cU6qpSI+5ceib72373naevk1uFaweDXoyBmu
 uWOVYC1qw+AYzfo/dZUVOLg2pGhVYxlNTALUuGO6il/n70fq/rryG6F8RVke280LcF5h
 2lUM+R8pefb/on6LvrMO1XPOr0cmn5z5Cb14hVrAsu9T2IDVSVETThwe7nDelEREwQwN
 8dkMl/xdZk4Nu48Jrf3V1xsai8LWPGfn2fjkQTCs9d+c0ioibJRh4VmZjw4uy9eegtUc
 FlLGYT4PW+rPbF0eMMBqQ6hdgDmAZwpVc7yKc5StzJxyWZSoMWVZm2tw2PDkvpN61kqL
 0Pzg==
X-Gm-Message-State: AOJu0Yy7ugYed2MO7H1SW5qRJLn3MRiOgiNrbP2tAbz0OPFJf0M9xk+g
 S1H5uV1SNn+sCguxohSUTT+nM8OGRGXx+PaFvLWsX3GqUHMVVBFwVeyunOZwFsSFjiaBfl2pi7V
 ex/rvYLFT2KSrPrSAeQbthfpBEANXl8IXoBQqLt+q
X-Gm-Gg: ASbGncvmRGyad2YCq8x6RbY3q9V6iwWjiaw4ulaA8QEgXKUQuFwPGVSol3XURDZ3aX/
 6PflOmtEsjI69BE2ouBFOAkTlrANfaGeDf1/yVXrbJJqroKsLDACNgWWYkU42CKVmBsm0uKvcgG
 ztFX9Wz+IJRY0qdD9Srrk+SIBqK3n8e803MT1+JP7qly+MgE7YLIywYEUTpGa4n3ocbbjawBF+N
 q9t4gK4HmFGJ6C9NAclYqPFYYzgg81IO+6wDDo1dQi7kg5fSKkUBafw1Wss3lrzf+SxJw==
X-Google-Smtp-Source: AGHT+IHOQzBhdXPTY6wwhsD8voN3QYyRkP77X8hZDSufDomrbpcPjc9B2mKQTQrkpkLiPm2jbcCly4tgKQXeL57Jrec=
X-Received: by 2002:a17:90b:514f:b0:33e:30cb:216e with SMTP id
 98e67ed59e1d1-340279e5393mr523088a91.5.1761584351795; Mon, 27 Oct 2025
 09:59:11 -0700 (PDT)
MIME-Version: 1.0
From: Shoaib Choudhary <shoaibsic@gmail.com>
Date: Mon, 27 Oct 2025 22:29:00 +0530
X-Gm-Features: AWmQ_bk-NNqJtJtS-BqOX5RfowRd0FVsKzsapSkBvlaldNPsgOAxIHlIS-FHWRI
Message-ID: <CA+Hr-XBQmZWkZ=Q19soD6ugN=nLzAsYEpGkMpfcV3xcNq3_inA@mail.gmail.com>
Subject: Segmentation Fault in IPsec_MB PMD When Resetting Crypto Device Stats
 After Upgrade to DPDK 24.11.3
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000087e258064226d1c3"
X-Mailman-Approved-At: Wed, 29 Oct 2025 14:52:41 +0100
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

--00000000000087e258064226d1c3
Content-Type: text/plain; charset="UTF-8"

*Description:*
After upgrading from DPDK 24.11 to 24.11.3, we are encountering a
segmentation fault in the IPsec_MB PMD (librte_crypto_ipsec_mb.so.25) when
attempting to reset crypto device statistics
using rte_cryptodev_stats_reset(). This issue was not observed in DPDK
24.11.

*Reproduction Context:*
The crash occurs during automated traffic tests that exercise GTP loopback
scenarios on a DPDK-based system. The test suite covers both fragmented and
non-fragmented packets, and uses multiple crypto algorithms (AES, SNOW3G,
ZUC) with Out-of-Place (OOP) processing enabled and disabled. Traffic is
sent through the datapath, and statistics are collected and reset as part
of the test flow. The segmentation fault is consistently triggered when
resetting crypto device stats after such traffic tests.

*Crash Details:*

   - Faulting function: rte_cryptodev_stats_reset() (called from
   application code)
   - Faulting library: librte_crypto_ipsec_mb.so.25
   - Fault address: 0x58
   - Only occurs in DPDK 24.11.3; not seen in 24.11

*Workarounds Attempted:*

   - Added device validation and error handling before stats reset
   - Implemented workaround to avoid direct stats reset (using baseline
   stats), Crash persists despite these changes
   - After implementing logic to skip rte_cryptodev_stats_reset() for
   IPsec_MB, SNOW3G, and AESNI_MB PMDs, the original segmentation fault was
   avoided. However, we then observed a separate crash during subsequent
   crypto device operations (such as session creation or device configuration).

*Request:*
Is this a known regression in DPDK 24.11.3? Are there any recommended fixes
or patches available? Any guidance on further debugging or mitigation would
be appreciated.


Regards,

Shoaib

--00000000000087e258064226d1c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">

<p class=3D"gmail-x_MsoNormal" style=3D"margin:0in;font-size:12pt;font-fami=
ly:Aptos;color:rgb(0,0,0);font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;word-spacing:0px;white-space:normal=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial"><b><span lang=3D"EN-IN" style=3D"border:0px;font:inher=
it;margin:0px;padding:0px;vertical-align:baseline;color:inherit">Descriptio=
n:</span></b><span lang=3D"EN-IN" style=3D"border:0px;font:inherit;margin:0=
px;padding:0px;vertical-align:baseline;color:inherit"><br>After upgrading f=
rom DPDK 24.11 to 24.11.3, we are encountering a segmentation fault in the =
IPsec_MB PMD (librte_crypto_ipsec_mb.so.25) when attempting to reset crypto=
 device statistics using=C2=A0rte_cryptodev_stats_reset(). This issue was n=
ot observed in DPDK 24.11.</span></p><p class=3D"gmail-x_MsoNormal" style=
=3D"margin:0in;font-size:12pt;font-family:Aptos;color:rgb(0,0,0);font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial"><b><span lang=
=3D"EN-IN" style=3D"border:0px;font:inherit;margin:0px;padding:0px;vertical=
-align:baseline;color:inherit">Reproduction Context:</span></b><span lang=
=3D"EN-IN" style=3D"border:0px;font:inherit;margin:0px;padding:0px;vertical=
-align:baseline;color:inherit"><br>The crash occurs during automated traffi=
c tests that exercise GTP loopback scenarios on a DPDK-based system. The te=
st suite covers both fragmented and non-fragmented packets, and uses multip=
le crypto algorithms (AES, SNOW3G, ZUC) with Out-of-Place (OOP) processing =
enabled and disabled. Traffic is sent through the datapath, and statistics =
are collected and reset as part of the test flow. The segmentation fault is=
 consistently triggered when resetting crypto device stats after such traff=
ic tests.</span></p><p class=3D"gmail-x_MsoNormal" style=3D"margin:0in;font=
-size:12pt;font-family:Aptos;color:rgb(0,0,0);font-style:normal;font-varian=
t-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:=
normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0p=
x;white-space:normal;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial"><b><span lang=3D"EN-IN" style=3D"b=
order:0px;font:inherit;margin:0px;padding:0px;vertical-align:baseline;color=
:inherit">Crash Details:</span></b><span lang=3D"EN-IN" style=3D"border:0px=
;font:inherit;margin:0px;padding:0px;vertical-align:baseline;color:inherit"=
></span></p><ul type=3D"disc" style=3D"margin-bottom:0in;color:rgb(0,0,0);f=
ont-size:15px;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;white-space:normal;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;margin-top:0in"><li class=3D"gmail-x_MsoNormal" style=3D"margin:0in=
;font-size:12pt;font-family:Aptos"><span lang=3D"EN-IN" style=3D"border:0px=
;font:inherit;margin:0px;padding:0px;vertical-align:baseline;color:inherit"=
>Faulting function:=C2=A0rte_cryptodev_stats_reset()=C2=A0(called from appl=
ication code)</span></li><li class=3D"gmail-x_MsoNormal" style=3D"margin:0i=
n;font-size:12pt;font-family:Aptos"><span lang=3D"EN-IN" style=3D"border:0p=
x;font:inherit;margin:0px;padding:0px;vertical-align:baseline;color:inherit=
">Faulting library:=C2=A0librte_crypto_ipsec_mb.so.25</span></li><li class=
=3D"gmail-x_MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
"><span lang=3D"EN-IN" style=3D"border:0px;font:inherit;margin:0px;padding:=
0px;vertical-align:baseline;color:inherit">Fault address: 0x58</span></li><=
li class=3D"gmail-x_MsoNormal" style=3D"margin:0in;font-size:12pt;font-fami=
ly:Aptos"><span lang=3D"EN-IN" style=3D"border:0px;font:inherit;margin:0px;=
padding:0px;vertical-align:baseline;color:inherit">Only occurs in DPDK 24.1=
1.3; not seen in 24.11</span></li></ul><p class=3D"gmail-x_MsoNormal" style=
=3D"margin:0in;font-size:12pt;font-family:Aptos;color:rgb(0,0,0);font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial"><b><span lang=
=3D"EN-IN" style=3D"border:0px;font:inherit;margin:0px;padding:0px;vertical=
-align:baseline;color:inherit">Workarounds Attempted:</span></b><span lang=
=3D"EN-IN" style=3D"border:0px;font:inherit;margin:0px;padding:0px;vertical=
-align:baseline;color:inherit"></span></p><ul type=3D"disc" style=3D"margin=
-bottom:0in;color:rgb(0,0,0);font-size:15px;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;=
white-space:normal;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial;margin-top:0in"><li class=3D"gmail-x_=
MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos"><span lang=
=3D"EN-IN" style=3D"border:0px;font:inherit;margin:0px;padding:0px;vertical=
-align:baseline;color:inherit">Added device validation and error handling b=
efore stats reset</span></li><li class=3D"gmail-x_MsoNormal" style=3D"margi=
n:0in;font-size:12pt;font-family:Aptos"><span lang=3D"EN-IN" style=3D"borde=
r:0px;font:inherit;margin:0px;padding:0px;vertical-align:baseline;color:inh=
erit">Implemented workaround to avoid direct stats reset (using baseline st=
ats),=C2=A0</span><span lang=3D"EN-IN" style=3D"border:0px;font:inherit;mar=
gin:0px;padding:0px;vertical-align:baseline;color:inherit">Crash persists d=
espite these changes</span></li><li class=3D"gmail-x_MsoNormal" style=3D"ma=
rgin:0in;font-size:12pt;font-family:Aptos"><span lang=3D"EN-IN" style=3D"bo=
rder:0px;font:inherit;margin:0px;padding:0px;vertical-align:baseline;color:=
inherit">After implementing logic to skip=C2=A0rte_cryptodev_stats_reset()=
=C2=A0for IPsec_MB, SNOW3G, and AESNI_MB PMDs, the original segmentation fa=
ult was avoided. However, we then observed a separate crash during subseque=
nt crypto device operations (such as session creation or device configurati=
on).</span></li></ul><p class=3D"gmail-x_MsoNormal" style=3D"margin:0in;fon=
t-size:12pt;font-family:Aptos;color:rgb(0,0,0);font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0=
px;white-space:normal;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial"><b><span lang=3D"EN-IN" style=3D"=
border:0px;font:inherit;margin:0px;padding:0px;vertical-align:baseline;colo=
r:inherit">Request:</span></b><span lang=3D"EN-IN" style=3D"border:0px;font=
:inherit;margin:0px;padding:0px;vertical-align:baseline;color:inherit"><br>=
Is this a known regression in DPDK 24.11.3? Are there any recommended fixes=
 or patches available? Any guidance on further debugging or mitigation woul=
d be appreciated.</span></p><p class=3D"gmail-x_MsoNormal" style=3D"margin:=
0in;font-size:12pt;font-family:Aptos;color:rgb(0,0,0);font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-sp=
acing:0px;white-space:normal;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial"><span lang=3D"EN-IN" style=
=3D"border:0px;font:inherit;margin:0px;padding:0px;vertical-align:baseline;=
color:inherit"><br></span></p><p class=3D"gmail-x_MsoNormal" style=3D"margi=
n:0in;font-size:12pt;font-family:Aptos;color:rgb(0,0,0);font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-=
spacing:0px;white-space:normal;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial"><span lang=3D"EN-IN" sty=
le=3D"border:0px;font:inherit;margin:0px;padding:0px;vertical-align:baselin=
e;color:inherit">Regards,</span></p><p class=3D"gmail-x_MsoNormal" style=3D=
"margin:0in;font-size:12pt;font-family:Aptos;color:rgb(0,0,0);font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;word-spacing:0px;white-space:normal;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial"><span lang=3D"EN-I=
N" style=3D"border:0px;font:inherit;margin:0px;padding:0px;vertical-align:b=
aseline;color:inherit">Shoaib</span></p>

<br></div>

--00000000000087e258064226d1c3--
