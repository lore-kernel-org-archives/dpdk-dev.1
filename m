Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C889BC54FB3
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Jun 2025 17:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96CB54026F;
	Sun,  1 Jun 2025 19:14:49 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id CD87F40268
 for <dev@dpdk.org>; Sun,  1 Jun 2025 19:14:47 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-309fac646adso4282742a91.1
 for <dev@dpdk.org>; Sun, 01 Jun 2025 10:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748798086; x=1749402886; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=awZ5GZPLsXfEvXinOX60wN4Om6iCYD11XTpjH/cRcEQ=;
 b=gSz1pS3i/dbon8lbHgSqGSHIsc2h33YD/dVJTcCa9zvP1FcBIilf8zDGFYXKuNqQ9V
 iXYH9RNtZ81F1DP+YxBRv3scd606UOphaHP7Wsg7Pr8NihCvYaI0RAsh6EM+LFJNcryL
 hPzds+BXJZvRSjoNBHhXtHVJGSG+45HAmpdrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748798086; x=1749402886;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=awZ5GZPLsXfEvXinOX60wN4Om6iCYD11XTpjH/cRcEQ=;
 b=bhHCEXWweMdnyhF8Q5PtDu/mk/PZxXd4HQPo8ICsLdXqaVJMcwUatahgBE/7F173cn
 YvxgcL49lbenKqQgBrOz5MXD+UIRxDySDfwLKCxxpeG9QGAbN3HWVFkE3wLKG2i9VRjl
 Qp7KFnpo1NMAIRXYxnMaso9+X6oEhDOMFFNWXx4oBuNiB4uOw39KhOqNYCDq/hpf4VZZ
 R8HfRpP4NTg9e3VfLau2hqRjL1gn/kBLyZVQQ1rx8T6NYRl0hQpWyl6lgD/Gzm01+Dxt
 xbCI1QkD9hUabxBITfhMG5F+ATg4XoW38nvqk9qjsOYImM+/B7wYUMIC9vKJC/mEzAP2
 Va4w==
X-Gm-Message-State: AOJu0YxS8tqo0WjPTYjfbetqeE8cd+Tf+0df4CFt1vo1qv5Mn6WPz6ja
 reipOVYtJ/dg+cAYHKtNwFwJ00BBtICB2K1o5t+l7POjeM+ZX3i69KFoZRbkoUJ8op2+koZdg7Q
 XlzLuUDng+K4jSvHiNoDzjMckjFrRhQDoPvR53pSiII60VvAyBmvhydNZfw==
X-Gm-Gg: ASbGnctxZwFJUML8tQwqixwQKCwvkYnzB3kK6RMzNQm5F6kG0CCS6MPurU93ZhjEi3I
 vBjxIpSIheLoUqxMesyIzqgW1TLyG/MfGtNgXFnTKXYUdkmYWE+rP7qEm4MWzwqZSnkT2OmEY7y
 Wq2Z4IDGnQ5+IRyKclZrDGwK0v6rvSkim4ubZHUbL6GTsmm/INxahy+XHmUfIwv8WYdQ==
X-Google-Smtp-Source: AGHT+IFyUD426lQElarhHcnAzPVFVFwPzWW5LaIprYxcd2hqY/FHKAW6Y0sv59nnDdtR2q4ZIg3xirusHkON8QurC8s=
X-Received: by 2002:a17:90b:180b:b0:311:be43:f09a with SMTP id
 98e67ed59e1d1-312460ed63emr13138156a91.9.1748798085945; Sun, 01 Jun 2025
 10:14:45 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 1 Jun 2025 13:09:47 -0400
X-Gm-Features: AX0GCFthBcH6KPpRQQDPrJ0c3U3ee5okpanTDtdnLyKgrukfrlAO7N6fzFbSZds
Message-ID: <CAJvnSUDnag=QrgXriWEgj4a9X7BpTrBkMz-DH9nmr9=LM1=VXQ@mail.gmail.com>
Subject: DTS WG Meeting Minutes - May 22, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b27348063685c86b"
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

--000000000000b27348063685c86b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
May 22, 2025
Attendees
* Patrick Robb
* Luca Vizzarro
* Paul Szczepanek
* Manit Mahajan
* Dean Marx
* Matthew McGovern

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* Nick Pratte from UNH-IOL is doing an internship outside IOL this Summer,
so he will not be working on DTS as much as expected
   * He still wants to submit some testsuites this Summer, but all his
framework side work (like perf tg (trex) support) will go to Patrick or Dea=
n
   * He may be back to working on DTS more regularly at the end of the
Summer that is TBD
* CI Lab items:
   * We=E2=80=99re still debugging some of the failures that we saw on the =
cx5
before DPDK Summit, which took that testing offline in our public reporting
system
   * Dean is adding some new NICs to the public testing
      * Broadcom 25g
      * Broadcom 100g (p2100g)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* Rte_flow: https://patchwork.dpdk.org/project/dpdk/list/?series=3D35269
   * Dean has updated the flow testsuite, adding a flow validate step
   * If flow validate fails, skip the testsuite
   * If flow validate passes, then flow create fails, fail the testsuite
   * If flow validate passes, flow create passes, then run the testsuite
and validate the flow behavior (pass or fail based on testsuite assert)
   * Dean added a verify_skip method to the testsuite class used for
skipping testsuites at runtime based on some condition
* Per test suite config docs:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35240
   * Doc update towards explaining how to leverage the per test suite confi=
g
* Perf tg support:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35239
   * Patrick is picking up this series
   * UNH people will ensure that the forwarding test metrics align with the
results we get from legacy DTS, which is considered stable
   * The legacy framework single core forwarding test had some effort done
towards supporting different traffic mixes/profiles, and we should examine
this for the new testsuite, but the MVP will feature basically a uniform
set of packets
* L4 packet matching:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D3522
   * Luca provided a few nits
   * Nits are resolved, so Patrick can test and merge
* Improved port handling:
https://patchwork.dpdk.org/project/dpdk/patch/20250506131657.1576152-1-luca=
.vizzarro@arm.com/
   * Patrick needs to review ASAP
* Packet capture testsuite:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35163
   * UNH guys need to provide a review and test on our hardware
* Tmp dir dpdk tree dir:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35049
   * UNH guys need to provide a review
* Patrick needs to resolve a docs error from the stats testsuite

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* DPDK-Pktgen
   * Patrick should share the pktgen notes and code example the CESNET guys
shared at a future meeting
* Cloud testing
   * Matthew is setting up an environment on Azure to experiment with DTS.
* Group looked at roadmap status DTS 25.07 Roadmap
* Luca will be gone for 3 weeks, and will be back in the 2nd half of June
* Next meeting is Jun 5, 2025

--000000000000b27348063685c86b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>May 22, 2025<br>Attendees<br>* Patrick Robb<br>* Luca Vizzar=
ro<br>* Paul Szczepanek<br>* Manit Mahajan<br>* Dean Marx<br>* Matthew McGo=
vern<br><br>###############################################################=
######<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>General Discussion<br>* Nick Pratte from UNH-IOL is doing an i=
nternship outside IOL this Summer, so he will not be working on DTS as much=
 as expected<br>=C2=A0 =C2=A0* He still wants to submit some testsuites thi=
s Summer, but all his framework side work (like perf tg (trex) support) wil=
l go to Patrick or Dean<br>=C2=A0 =C2=A0* He may be back to working on DTS =
more regularly at the end of the Summer that is TBD<br>* CI Lab items:<br>=
=C2=A0 =C2=A0* We=E2=80=99re still debugging some of the failures that we s=
aw on the cx5 before DPDK Summit, which took that testing offline in our pu=
blic reporting system<br>=C2=A0 =C2=A0* Dean is adding some new NICs to the=
 public testing<br>=C2=A0 =C2=A0 =C2=A0 * Broadcom 25g<br>=C2=A0 =C2=A0 =C2=
=A0 * Broadcom 100g (p2100g)<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>Patch discussions<br>* Rte_flow: <a href=3D"https://p=
atchwork.dpdk.org/project/dpdk/list/?series=3D35269">https://patchwork.dpdk=
.org/project/dpdk/list/?series=3D35269</a><br>=C2=A0 =C2=A0* Dean has updat=
ed the flow testsuite, adding a flow validate step<br>=C2=A0 =C2=A0* If flo=
w validate fails, skip the testsuite<br>=C2=A0 =C2=A0* If flow validate pas=
ses, then flow create fails, fail the testsuite<br>=C2=A0 =C2=A0* If flow v=
alidate passes, flow create passes, then run the testsuite and validate the=
 flow behavior (pass or fail based on testsuite assert)<br>=C2=A0 =C2=A0* D=
ean added a verify_skip method to the testsuite class used for skipping tes=
tsuites at runtime based on some condition<br>* Per test suite config docs:=
 <a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=3D35240">h=
ttps://patchwork.dpdk.org/project/dpdk/list/?series=3D35240</a><br>=C2=A0 =
=C2=A0* Doc update towards explaining how to leverage the per test suite co=
nfig<br>* Perf tg support: <a href=3D"https://patchwork.dpdk.org/project/dp=
dk/list/?series=3D35239">https://patchwork.dpdk.org/project/dpdk/list/?seri=
es=3D35239</a><br>=C2=A0 =C2=A0* Patrick is picking up this series<br>=C2=
=A0 =C2=A0* UNH people will ensure that the forwarding test metrics align w=
ith the results we get from legacy DTS, which is considered stable<br>=C2=
=A0 =C2=A0* The legacy framework single core forwarding test had some effor=
t done towards supporting different traffic mixes/profiles, and we should e=
xamine this for the new testsuite, but the MVP will feature basically a uni=
form set of packets<br>* L4 packet matching: <a href=3D"https://patchwork.d=
pdk.org/project/dpdk/list/?series=3D3522">https://patchwork.dpdk.org/projec=
t/dpdk/list/?series=3D3522</a><br>=C2=A0 =C2=A0* Luca provided a few nits<b=
r>=C2=A0 =C2=A0* Nits are resolved, so Patrick can test and merge<br>* Impr=
oved port handling: <a href=3D"https://patchwork.dpdk.org/project/dpdk/patc=
h/20250506131657.1576152-1-luca.vizzarro@arm.com/">https://patchwork.dpdk.o=
rg/project/dpdk/patch/20250506131657.1576152-1-luca.vizzarro@arm.com/</a><b=
r>=C2=A0 =C2=A0* Patrick needs to review ASAP<br>* Packet capture testsuite=
: <a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=3D35163">=
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35163</a><br>=C2=A0 =
=C2=A0* UNH guys need to provide a review and test on our hardware<br>* Tmp=
 dir dpdk tree dir: <a href=3D"https://patchwork.dpdk.org/project/dpdk/list=
/?series=3D35049">https://patchwork.dpdk.org/project/dpdk/list/?series=3D35=
049</a><br>=C2=A0 =C2=A0* UNH guys need to provide a review<br>* Patrick ne=
eds to resolve a docs error from the stats testsuite<br><br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Bugzilla discussions<br>* Non=
e<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any o=
ther business<br>* DPDK-Pktgen<br>=C2=A0 =C2=A0* Patrick should share the p=
ktgen notes and code example the CESNET guys shared at a future meeting<br>=
* Cloud testing<br>=C2=A0 =C2=A0* Matthew is setting up an environment on A=
zure to experiment with DTS.<br>* Group looked at roadmap status DTS 25.07 =
Roadmap<br>* Luca will be gone for 3 weeks, and will be back in the 2nd hal=
f of June<br>* Next meeting is Jun 5, 2025</div>

--000000000000b27348063685c86b--
