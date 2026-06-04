Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66C6CD6E6D
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 13:18:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ACEA402CC;
	Thu,  4 Jun 2026 15:18:33 +0200 (CEST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mails.dpdk.org (Postfix) with ESMTP id 23888402B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 15:18:32 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-48611addcfbso238745b6e.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 06:18:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780579111; cv=none;
 d=google.com; s=arc-20240605;
 b=Yr1FDUfZr2kNTiBL+i6/uPm3qNKkF1yospQDWIjYJCNIxv7vPs/qnvY91LrLKTXaP6
 UNjFyRfCd3MeGY3zGSETQImCFyCFqkoDik76UoIhg//6UffV8bMwvzfS4L0gpke4ie8A
 AP8CwZm1+JYvezIMhFdOwCjuIJpZW1MINGcQ6rGPOpGH9sHM6N2Iv5+f+Wyxek5cP8Sj
 Ek5gItwKvf2pdNNjgofqJMHGCtcrjCTMlC5w2pvjzwZKcq+Lj1LQMA/y5f+dopYJG3Pq
 SwxmaBAgQ4u6KcpheDHEVNjAO2pTV2VNIOrAZa28RW5cNIOrHM+5tM3cTsF5Ub68JSek
 723g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=sHfgjR1Ck4aDty+Qkux1ncqTXyzuD9Qj4mkWjQqFT3w=;
 fh=SmeAyABM4rfT32CZ90spRvJxp9TgPXvzIvi7t3j/5Mk=;
 b=lQKNPbyNuLSCxD6QKsHqlY6XimnOD5IavW/08hSufvG1PMqlFnOTeqK4D4SWl15Rb+
 Pxogck7Rtjli5ssA+6L7rIp8F3vH8WJFrTlQdDj3cbsbd3EilddszmSLoyL487d4kiRg
 PVSJM/Kj+zDVqLGU+opMRMPEF9HybTNl+rQ29iksWk9WNdvHlloBhUGPMbk/xIelyQr+
 4mKIGyyLGFw1gDa0AnGTgCpOtqGmbt8sHXXHtXxPFXA/6R8vwxtoXstSZCpbpumC1Rm8
 35HJeiPKi8sBavwVSe6ALMlzJisWhOpCSaCa+hKC2F4OfBECE1xNAPX/xMgVIz9stx9I
 RMxA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1780579111; x=1781183911; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sHfgjR1Ck4aDty+Qkux1ncqTXyzuD9Qj4mkWjQqFT3w=;
 b=U2IpqyMwPbtawN+GeT8c//qTqMiZprGlhkxMGQizaOY0xMisWU5MPveP6d9QcpNbW+
 2615htDk0LhjxaIEfvJxqd2PR+gp/dCTygfcYY9xsQEdKvA/rbI+/7J5IhnVs54FC1et
 zGejO+G/JaAINBFLZ1kmTNce+jgW5WZDTPzmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780579111; x=1781183911;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sHfgjR1Ck4aDty+Qkux1ncqTXyzuD9Qj4mkWjQqFT3w=;
 b=NAM+aG9Zz9/R7ddqZkIw3PoEbNE3WeiuHBGhfrJ/S0PORjL1aRQ6pU6IH/TBarNhhc
 r4miWszxzxCKUVqMrM42xU7JKfRXBq8Inq+TDahQFTbI9gesY8zTQFFMBkMUXKe1S5B3
 38vgS4duaF19LfhRTYLGSXeJpWdztFiX/m44dtZdFNzpYtxgW+U3fXAal2DeeXNxo2GO
 0fAUuHoCnwvPZoavnBjYS61wyQzDWtwuL4DfSfXJzDbsKGDRv6yVj+r8DsoVpnwXNTaR
 ttywItLEdQuyoWeK2ESQvlY1anvf49jXDxiNkvE3xmQiwwgD+uLZWdIXcA44gTDCKVQB
 WJXA==
X-Gm-Message-State: AOJu0YwGd6Fhdwd6lSQW0JmxtAGtWBMNL3WpTArC7ZvJYGCfx+Fn2z6E
 KV4xThYFh+4b6hOmWiDHXTuTy3TUpZPYVOBb2MNIQBNrUTnmRU7KwEvfIfvZ1JAUWVuLJIZEFRL
 WR26EBf1gLsGzCDfUnqWV2RLdlXXt2766kOGh5tk6RfyYv9PSfJVL36bcJg==
X-Gm-Gg: Acq92OFxbheLElxxGIs6TTrQrpfLSdZfiimmM4TidybNLggxLV4LTuV/3cT9lk0NKUX
 EjTNkT2tLhOUGabZbcxu1JgDvkqwqUo6+hLRH7rgHKtP8ot7SPVltvGRD9hcnSjfbBXRo55cXtd
 Z5eDfjPjtxy0Jg6BblH5HPioETIWc8WzIBbEnFwjte3UVAb/0bf6WIHcY84zA9bMmMKb96o0eNW
 GmHVtgDA+ZD7OIew5xZqw/01qL7Nge5eXS/oGlJdhEA/UmTbB7PSVFZAur6+tTcpMyxokVIw0XB
 tusPahq9K+Z39aECCJRb6PV61yUa
X-Received: by 2002:a05:6808:159d:b0:486:33db:ef58 with SMTP id
 5614622812f47-4865ab9d968mr4704227b6e.35.1780579110981; Thu, 04 Jun 2026
 06:18:30 -0700 (PDT)
MIME-Version: 1.0
From: Lincoln Lavoie <lylavoie@iol.unh.edu>
Date: Thu, 4 Jun 2026 09:18:20 -0400
X-Gm-Features: AVHnY4Luvlaq1f0uR1gFESe6a3vFtC9ZFc_lbe-5c7lxWbpNYRbRmT6cBJqd6_E
Message-ID: <CAOE1vsP9ZqSTMzKzdu3d7+Uo7YENyx0GwEpZKuvwhiF0uXBpxg@mail.gmail.com>
Subject: DTS meeting / status
To: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000067a36b06536d6146"
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

--00000000000067a36b06536d6146
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello All,

It seems like we're not really getting critical mass from the community on
the DTS meetings, while a few key participants are on leave.  I wanted to
provide a status update on a number of patch series, so we can make sure we
are staying on target for the July release.

Below is the current list of DTS patches, where many are planned for the
July release, if some are able to help provide reviews, that would be
appreciated.


   -

   report dut/NIC info during DTS run
   -

      Needs review
      -

   add code coverage reporting to DTS
   -

      Needs review
      -

   add retry loop to trex traffic generation
   -

      Needs review
      -

   add directory for test resources
   -

      Needs review
      -

   clean cryptodev environment after a test run
   -

      Needs review
      -

   update parsing for cryptodev latency
   -

      Needs review
      -

   update test suite names to be clear and consistent
   -

      Needs review
      -

   add ipgre test suite
   -

      Needs review
      -

   fix topology capability comparison
   -

      Needs review
      -

   move exception module from framework to API
   -

      Needs review
      -

   fix port info getter when port is not found
   -

      Reviewed by Luca, no comments, April 23
      -

   ConfigurationError not thrown due to lack of next default value
   -

      Needs to be marked as not active, replaced by =E2=80=9Cfix port info =
getter
      when port is not found=E2=80=9D
      -

   update modprobe command to be privileged
   -

      Reviewed by Luca, no comments, April 9, 2026
      -

   update verbose output regex for VXLAN packets
   -

      Still pending review
      -

   port speed capabilities test suite to next DTS
   -

      Reviewed by Patrick, no comments, May 30
      -

   add default values for queue info
   -

      Reviewed by Patrick, no comments, May 28.
      -

   refactor flow suite with generator pattern
   -

      Still pending review
      -

   add support for no link topology
   -

      Comments from Patrick on May 30 need answer
      -

   add PVVP case to virtio suite
   -

      Still pending reviews, marked ready on April 10, 2026


Cheers,
Lincoln
--=20
*Lincoln Lavoie*
Principal Engineer, Broadband Technologies
21 Madbury Rd., Ste. 100, Durham, NH 03824
lylavoie@iol.unh.edu
https://www.iol.unh.edu
+1-603-674-2755 (m)

--00000000000067a36b06536d6146
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_default" style=3D"font-size:small=
">Hello All,</div><div class=3D"gmail_default" style=3D"font-size:small"><b=
r></div><div class=3D"gmail_default" style=3D"font-size:small">It seems lik=
e we&#39;re not really getting critical mass from the community on the DTS =
meetings, while a few key participants are on leave.=C2=A0 I wanted to prov=
ide a status update on a number of patch series, so we can make sure we are=
 staying on target for the July release.</div><div class=3D"gmail_default" =
style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">Below is the current list of DTS patches, where many are pl=
anned for the July release, if some are able to help provide reviews, that =
would be appreciated.</div><div class=3D"gmail_default" style=3D"font-size:=
small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"><sp=
an id=3D"gmail-docs-internal-guid-f412543b-7fff-7af3-86bc-dcadc6326484"><ul=
 style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-s=
tyle-type:disc;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0)=
;background-color:transparent;font-variant:normal;vertical-align:baseline;w=
hite-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;mar=
gin-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;backgro=
und-color:transparent;font-variant:normal;vertical-align:baseline;white-spa=
ce:pre-wrap">report dut/NIC info during DTS run</span></p></li><ul style=3D=
"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type=
:circle;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backgr=
ound-color:transparent;font-variant:normal;vertical-align:baseline;white-sp=
ace:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bot=
tom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-col=
or:transparent;font-variant:normal;vertical-align:baseline;white-space:pre-=
wrap">Needs review</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-=
type:disc;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);back=
ground-color:transparent;font-variant:normal;vertical-align:baseline;white-=
space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-b=
ottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-c=
olor:transparent;font-variant:normal;vertical-align:baseline;white-space:pr=
e-wrap">add code coverage reporting to DTS</span></p></li><ul style=3D"marg=
in-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:circ=
le;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-=
color:transparent;font-variant:normal;vertical-align:baseline;white-space:p=
re"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0=
pt" role=3D"presentation"><span style=3D"font-size:11pt;background-color:tr=
ansparent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap"=
>Needs review</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-type:=
disc;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backgroun=
d-color:transparent;font-variant:normal;vertical-align:baseline;white-space=
:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom=
:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-color:=
transparent;font-variant:normal;vertical-align:baseline;white-space:pre-wra=
p">add retry loop to trex traffic generation</span></p></li><ul style=3D"ma=
rgin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:ci=
rcle;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backgroun=
d-color:transparent;font-variant:normal;vertical-align:baseline;white-space=
:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom=
:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-color:=
transparent;font-variant:normal;vertical-align:baseline;white-space:pre-wra=
p">Needs review</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-typ=
e:disc;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backgro=
und-color:transparent;font-variant:normal;vertical-align:baseline;white-spa=
ce:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bott=
om:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-colo=
r:transparent;font-variant:normal;vertical-align:baseline;white-space:pre-w=
rap">add directory for test resources</span></p></li><ul style=3D"margin-to=
p:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:circle;fo=
nt-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color=
:transparent;font-variant:normal;vertical-align:baseline;white-space:pre"><=
p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" r=
ole=3D"presentation"><span style=3D"font-size:11pt;background-color:transpa=
rent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">Need=
s review</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-type:disc;=
font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-col=
or:transparent;font-variant:normal;vertical-align:baseline;white-space:pre"=
><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
 role=3D"presentation"><span style=3D"font-size:11pt;background-color:trans=
parent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">cl=
ean cryptodev environment after a test run</span></p></li><ul style=3D"marg=
in-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:circ=
le;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-=
color:transparent;font-variant:normal;vertical-align:baseline;white-space:p=
re"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0=
pt" role=3D"presentation"><span style=3D"font-size:11pt;background-color:tr=
ansparent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap"=
>Needs review</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-type:=
disc;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backgroun=
d-color:transparent;font-variant:normal;vertical-align:baseline;white-space=
:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom=
:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-color:=
transparent;font-variant:normal;vertical-align:baseline;white-space:pre-wra=
p">update parsing for cryptodev latency</span></p></li><ul style=3D"margin-=
top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:circle;=
font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-col=
or:transparent;font-variant:normal;vertical-align:baseline;white-space:pre"=
><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
 role=3D"presentation"><span style=3D"font-size:11pt;background-color:trans=
parent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">Ne=
eds review</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-type:dis=
c;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-c=
olor:transparent;font-variant:normal;vertical-align:baseline;white-space:pr=
e"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0p=
t" role=3D"presentation"><span style=3D"font-size:11pt;background-color:tra=
nsparent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">=
update test suite names to be clear and consistent</span></p></li><ul style=
=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-t=
ype:circle;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);bac=
kground-color:transparent;font-variant:normal;vertical-align:baseline;white=
-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-=
bottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-=
color:transparent;font-variant:normal;vertical-align:baseline;white-space:p=
re-wrap">Needs review</span></p></li></ul><li dir=3D"ltr" style=3D"list-sty=
le-type:disc;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);b=
ackground-color:transparent;font-variant:normal;vertical-align:baseline;whi=
te-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margi=
n-bottom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;backgroun=
d-color:transparent;font-variant:normal;vertical-align:baseline;white-space=
:pre-wrap">add ipgre test suite</span></p></li><ul style=3D"margin-top:0px;=
margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:circle;font-siz=
e:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:trans=
parent;font-variant:normal;vertical-align:baseline;white-space:pre"><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=
=3D"presentation"><span style=3D"font-size:11pt;background-color:transparen=
t;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">Needs r=
eview</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-type:disc;fon=
t-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:=
transparent;font-variant:normal;vertical-align:baseline;white-space:pre"><p=
 dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" ro=
le=3D"presentation"><span style=3D"font-size:11pt;background-color:transpar=
ent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">fix t=
opology capability comparison</span></p></li><ul style=3D"margin-top:0px;ma=
rgin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:circle;font-size:=
11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transpa=
rent;font-variant:normal;vertical-align:baseline;white-space:pre"><p dir=3D=
"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"p=
resentation"><span style=3D"font-size:11pt;background-color:transparent;fon=
t-variant:normal;vertical-align:baseline;white-space:pre-wrap">Needs review=
</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-type:disc;font-siz=
e:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:trans=
parent;font-variant:normal;vertical-align:baseline;white-space:pre"><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=
=3D"presentation"><span style=3D"font-size:11pt;background-color:transparen=
t;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">move ex=
ception module from framework to API</span></p></li><ul style=3D"margin-top=
:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:circle;fon=
t-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:=
transparent;font-variant:normal;vertical-align:baseline;white-space:pre"><p=
 dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" ro=
le=3D"presentation"><span style=3D"font-size:11pt;background-color:transpar=
ent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">Needs=
 review</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-type:disc;f=
ont-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-colo=
r:transparent;font-variant:normal;vertical-align:baseline;white-space:pre">=
<p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" =
role=3D"presentation"><span style=3D"font-size:11pt;background-color:transp=
arent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">fix=
 port info getter when port is not found</span></p></li><ul style=3D"margin=
-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:circle=
;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-co=
lor:transparent;font-variant:normal;vertical-align:baseline;white-space:pre=
"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt=
" role=3D"presentation"><span style=3D"font-size:11pt;background-color:tran=
sparent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">R=
eviewed by Luca, no comments, April 23</span></p></li></ul><li dir=3D"ltr" =
style=3D"list-style-type:disc;font-size:11pt;font-family:Arial,sans-serif;c=
olor:rgb(0,0,0);background-color:transparent;font-variant:normal;vertical-a=
lign:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;mar=
gin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D"font-si=
ze:11pt;background-color:transparent;font-variant:normal;vertical-align:bas=
eline;white-space:pre-wrap">ConfigurationError not thrown due to lack of ne=
xt default value</span></p></li><ul style=3D"margin-top:0px;margin-bottom:0=
px"><li dir=3D"ltr" style=3D"list-style-type:circle;font-size:11pt;font-fam=
ily:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-var=
iant:normal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation=
"><span style=3D"font-size:11pt;background-color:transparent;font-variant:n=
ormal;vertical-align:baseline;white-space:pre-wrap">Needs to be marked as n=
ot active, replaced by =E2=80=9Cfix port info getter when port is not found=
=E2=80=9D</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-type:disc=
;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-co=
lor:transparent;font-variant:normal;vertical-align:baseline;white-space:pre=
"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt=
" role=3D"presentation"><span style=3D"font-size:11pt;background-color:tran=
sparent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">u=
pdate modprobe command to be privileged</span></p></li><ul style=3D"margin-=
top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:circle;=
font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-col=
or:transparent;font-variant:normal;vertical-align:baseline;white-space:pre"=
><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"=
 role=3D"presentation"><span style=3D"font-size:11pt;background-color:trans=
parent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">Re=
viewed by Luca, no comments, April 9, 2026</span></p></li></ul><li dir=3D"l=
tr" style=3D"list-style-type:disc;font-size:11pt;font-family:Arial,sans-ser=
if;color:rgb(0,0,0);background-color:transparent;font-variant:normal;vertic=
al-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38=
;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D"fon=
t-size:11pt;background-color:transparent;font-variant:normal;vertical-align=
:baseline;white-space:pre-wrap">update verbose output regex for VXLAN packe=
ts</span></p></li><ul style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D=
"ltr" style=3D"list-style-type:circle;font-size:11pt;font-family:Arial,sans=
-serif;color:rgb(0,0,0);background-color:transparent;font-variant:normal;ve=
rtical-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-height:=
1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D=
"font-size:11pt;background-color:transparent;font-variant:normal;vertical-a=
lign:baseline;white-space:pre-wrap">Still pending review</span></p></li></u=
l><li dir=3D"ltr" style=3D"list-style-type:disc;font-size:11pt;font-family:=
Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant=
:normal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"li=
ne-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><spa=
n style=3D"font-size:11pt;background-color:transparent;font-variant:normal;=
vertical-align:baseline;white-space:pre-wrap">port speed capabilities test =
suite to next DTS</span></p></li><ul style=3D"margin-top:0px;margin-bottom:=
0px"><li dir=3D"ltr" style=3D"list-style-type:circle;font-size:11pt;font-fa=
mily:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-va=
riant:normal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation=
"><span style=3D"font-size:11pt;background-color:transparent;font-variant:n=
ormal;vertical-align:baseline;white-space:pre-wrap">Reviewed by Patrick, no=
 comments, May 30</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-t=
ype:disc;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);backg=
round-color:transparent;font-variant:normal;vertical-align:baseline;white-s=
pace:pre"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bo=
ttom:0pt" role=3D"presentation"><span style=3D"font-size:11pt;background-co=
lor:transparent;font-variant:normal;vertical-align:baseline;white-space:pre=
-wrap">add default values for queue info</span></p></li><ul style=3D"margin=
-top:0px;margin-bottom:0px"><li dir=3D"ltr" style=3D"list-style-type:circle=
;font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-co=
lor:transparent;font-variant:normal;vertical-align:baseline;white-space:pre=
"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt=
" role=3D"presentation"><span style=3D"font-size:11pt;background-color:tran=
sparent;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">R=
eviewed by Patrick, no comments, May 28.</span></p></li></ul><li dir=3D"ltr=
" style=3D"list-style-type:disc;font-size:11pt;font-family:Arial,sans-serif=
;color:rgb(0,0,0);background-color:transparent;font-variant:normal;vertical=
-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D"font-=
size:11pt;background-color:transparent;font-variant:normal;vertical-align:b=
aseline;white-space:pre-wrap">refactor flow suite with generator pattern</s=
pan></p></li><ul style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr"=
 style=3D"list-style-type:circle;font-size:11pt;font-family:Arial,sans-seri=
f;color:rgb(0,0,0);background-color:transparent;font-variant:normal;vertica=
l-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38;=
margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D"font=
-size:11pt;background-color:transparent;font-variant:normal;vertical-align:=
baseline;white-space:pre-wrap">Still pending review</span></p></li></ul><li=
 dir=3D"ltr" style=3D"list-style-type:disc;font-size:11pt;font-family:Arial=
,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant:norm=
al;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-he=
ight:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span sty=
le=3D"font-size:11pt;background-color:transparent;font-variant:normal;verti=
cal-align:baseline;white-space:pre-wrap">add support for no link topology</=
span></p></li><ul style=3D"margin-top:0px;margin-bottom:0px"><li dir=3D"ltr=
" style=3D"list-style-type:circle;font-size:11pt;font-family:Arial,sans-ser=
if;color:rgb(0,0,0);background-color:transparent;font-variant:normal;vertic=
al-align:baseline;white-space:pre"><p dir=3D"ltr" style=3D"line-height:1.38=
;margin-top:0pt;margin-bottom:0pt" role=3D"presentation"><span style=3D"fon=
t-size:11pt;background-color:transparent;font-variant:normal;vertical-align=
:baseline;white-space:pre-wrap">Comments from Patrick on May 30 need answer=
</span></p></li></ul><li dir=3D"ltr" style=3D"list-style-type:disc;font-siz=
e:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:trans=
parent;font-variant:normal;vertical-align:baseline;white-space:pre"><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=
=3D"presentation"><span style=3D"font-size:11pt;background-color:transparen=
t;font-variant:normal;vertical-align:baseline;white-space:pre-wrap">add PVV=
P case to virtio suite</span></p></li><ul style=3D"margin-top:0px;margin-bo=
ttom:0px"><li dir=3D"ltr" style=3D"list-style-type:circle;font-size:11pt;fo=
nt-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;fo=
nt-variant:normal;vertical-align:baseline;white-space:pre"><p dir=3D"ltr" s=
tyle=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt" role=3D"presenta=
tion"><span style=3D"font-size:11pt;background-color:transparent;font-varia=
nt:normal;vertical-align:baseline;white-space:pre-wrap">Still pending revie=
ws, marked ready on April 10, 2026</span></p></li></ul></ul></span></div><b=
r clear=3D"all"></div><div><div class=3D"gmail_default" style=3D"font-size:=
small">Cheers,<br>Lincoln</div></div><span class=3D"gmail_signature_prefix"=
>-- </span><br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D=
"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div d=
ir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"l=
tr"><div dir=3D"ltr"><div><b>Lincoln Lavoie</b><br></div><div>Principal Eng=
ineer, Broadband Technologies</div><div>21 Madbury Rd., Ste. 100, Durham, N=
H 03824</div><div><a href=3D"mailto:lylavoie@iol.unh.edu" target=3D"_blank"=
>lylavoie@iol.unh.edu</a></div><div><a href=3D"https://www.iol.unh.edu" tar=
get=3D"_blank">https://www.iol.unh.edu</a></div><div>+1-603-674-2755 (m)</d=
iv><div><img src=3D"https://www.iol.unh.edu/sites/all/themes/custom/iol2013=
/img/logo.png" width=3D"200" height=3D"55"><br></div></div></div></div></di=
v></div></div></div></div></div></div></div>

--00000000000067a36b06536d6146--
