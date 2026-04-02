Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39B3D6AAFD
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 19:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 299C340E1B;
	Thu,  2 Apr 2026 21:16:48 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 07EF34027A
 for <dev@dpdk.org>; Thu,  2 Apr 2026 21:16:46 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-127380532eeso3511925c88.1
 for <dev@dpdk.org>; Thu, 02 Apr 2026 12:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775157405; cv=none;
 d=google.com; s=arc-20240605;
 b=cpfJjTd+DcJi1GQ7b/jRbdoIchhpWlFDAnTJS3/FOy5K7Rf9KKchZsroNocThbt2fK
 u7LLtwXfGSR3NfVEOhW0eeO5j5c8TFcBzE7j9QBF6fCLOjNsaBcMnhVV+SPoHD2UmFkK
 uNOqPfj7ouG1gVtNRtBqAnIEo+2VxUFnI/KFnTp2khXfA/GbtbxxR+F/U1e0KpaFQJ4n
 hqChTc/X4xi6p3RT2/o2BROwKgE+Hcl2o0W7+lhErawXTBS5CT4Od13D5c0reg63RPpm
 +JjHB1SMlY8CHj/LrRaDQm4I8ZQuPMXtPubfPd1Z4+CpcMqGoCrUnWv8EZUdtpW+onSa
 S33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=V9cFFxKINMeAphu2smIxt4Fvz+SH45tmlXOyaf78yZY=;
 fh=v1VvrYYXadeTNy4HjH40pmjV0YiJYq6WpclLqfUi2B4=;
 b=QLi+a0wkCuCF5VNZlDIecrY1RVFh3ENWMjbVVBLX4+OeV73Iwd/HGMUqCSYgHqs0xr
 vVTvqxKq1RqRpTKuhwjLjbb+6L39maNYoCam6TgOv9/1P30Ermo2a68h9cgrToFzOeQb
 364cZkKIRwg4FKzcoZw5BdGoRe6f0uH5T6Wx2zjopfbiFJxsxFx7zWOPn42GmBs+QpUv
 0CuT/Of6Jq5nsRS217Q3qjqnRZ+9QVTI7SXAOeEE14nkT3kBZrFR8Hpr795DzcwMFkc5
 tDqv6K69mhGXOwBjryjkpyO3JjLF+inWlSE8mNc77bRFcIAg2iXarG3ZGYuDwBcftcEX
 BAEA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775157405; x=1775762205; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=V9cFFxKINMeAphu2smIxt4Fvz+SH45tmlXOyaf78yZY=;
 b=jQsoQMpeFCoAjtUbsuPFJ8YdKGyiRTSncvD/AkCd0ThZQ01wlyuNHsFLdFk/9k0UFv
 7QUEe+F3Q1scX0ZGsu2DtUjvWJHrfKrOMSWS1pQB90yR8Xabbx3fmfm1pp6AKkwwunTc
 tmTs91dRFJtajS4ZFVlmIykfUWA0MhMce6WCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775157405; x=1775762205;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V9cFFxKINMeAphu2smIxt4Fvz+SH45tmlXOyaf78yZY=;
 b=fweEM84FMftWU2lDyFjS9CtcJcNlKf6pcUWBjVU4tu9FYtlaTBOSk+SkGyEB7Ky3IJ
 Jv/1Ktn18NxikFtlS/o7vDWbajhZkLXWcok4Igb0xmjMz2bdPbnYrOcNmndpGpAyztU9
 6na9QF+SutWa48Cpp2H+++lVXLswTS/ZSKRzp/XVVs1eERlleHMMrveXrbnlA1s6YOHk
 6HR+7fysdyM8iBCTmEtI1nDdGDRK5/iWwwwhzGYOTejyxuHQgHJtCUL1yAAfQAu+9VRq
 Pw1+skIB724YpFdWk0VImkmG9vrW2zOhaHYcflWCW6cBJ/rn4YZCQLJxWvnjpil75AEK
 ho8Q==
X-Gm-Message-State: AOJu0YzRYTmABJ3phDoy+zqcDhOZ9HoAzUfk82buAWCQ3D3b6186z4a7
 a7/m4bxu9WpdO5N2KW3cYBGYVngDak7s5eehzX6W6Jepbw4cJEmU7zFggT5wOLUJQTKmRdBHlIT
 RneWIcpB/vqKnIHX6r39Lsr22OJ2kqEfhyz0m+akBxJvKTMPoZ3+taUzbmg==
X-Gm-Gg: ATEYQzymiQ2yQWwKM3PSJT8BXytyPYhC/Zp6R5Z9vsWOXA0NCpPHJEKeYWaFFrUoHtT
 agc4izHhvIHUTtLqcACILpUyyu9zJSIs2bMLwO8YHUAHj0aiHGwdGXKZtc9dYgJttL7h+9K+xim
 ADWmimOD0S47uHLnHI5D7Co8g8AOKEvmOL4DELuJyE6TuWUM0ok4j4GRvqFp2dVyd1PTZw+EfjN
 z3IDo1VgREEkab9qoUUyS/e6c6XiRjb10rvKu3nn7RSyFWY36ZsEFw3Smy8QC+BeyHqHgftpY20
 yXn1jAs7/Yt3CmeiLhFx2yjlia5hcMOsOiMUYQXopVeFGVfty7LTpQ==
X-Received: by 2002:a05:7022:fe08:b0:119:e56b:c74b with SMTP id
 a92af1059eb24-12bfb708680mr152335c88.16.1775157404673; Thu, 02 Apr 2026
 12:16:44 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 2 Apr 2026 15:13:19 -0400
X-Gm-Features: AQROBzBewtYZ_3ZQ9u23B98-yp2aUm8RbMoUDOuN5RGg97_W0N4jsGT1xvoq8LQ
Message-ID: <CAJvnSUATz4ob0-NmYhZHZ1SuRhXfkb7tKHbFySkTmq92j_RRTQ@mail.gmail.com>
Subject: Community CI Meeting Minutes - April 2 2026
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>, Adam Hassick <ahassick@iol.unh.edu>, 
 Lincoln Lavoie <lylavoie@iol.unh.edu>
Content-Type: multipart/alternative; boundary="00000000000086b85a064e7f0a01"
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

--00000000000086b85a064e7f0a01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

April 2, 2026
Attendees
1. Patrick Robb
2. Adam Hassick
3. Lincoln Lavoie
4. Aaron Conole
Minutes
General Announcements
* AI Code Review:
   * Has been live since last Friday, sending AI code reviews on a per
patch series basis to test-report@dpdk.org
   * Mailing list update and next steps:
https://inbox.dpdk.org/ci/CAJvnSUAtn7mUqkjoPHsEyiZLMe0w4kkg2n9SfB2OL=3DPR4v=
ozGg@mail.gmail.com/T/#u
   * Tech board discussed the matter yesterday:
      * It is borderline but based on the spending we are seeing right now,
we will most likely spend less than the $100 cap given the current size of
our AGENTS.md
         * Aaron will also test Stephen=E2=80=99s AGENTS.md
      * There was also discussion about sending 1 monolithic AI code review
per series vs splitting it out into multiple patch emails, whether to mail
to test-report vs dev mailing lists, etc. We are going to let people
experience the current method of AI code reviews for a few weeks, and then
Tech Board will circle back and provide a final decision on these questions=
.
   * DPDK-Web
      * Patrick will try to summarize the AI Code review status for a
dpdk.org website patch today
* DPDK 26.03 has been released
* Today is Patrick=E2=80=99s last day at UNH-IOL
CI Status
AWS Lab
* None, they are running normally
UNH-IOL Community Lab
* Cryptodev testing:
   * Running in CI
   * QAT 8970 running fine. There was 1 issue with the config files for the
QAT 41xx testing, and Andrew will fix this today
   * AMD CCP:
      * UNH has an AMD CCP device in one of the new AMD processors at the
lab, but it is =E2=80=9Cphysical function only=E2=80=9D and our new testsui=
te is written to
only use virtual functions.
      * Andrew to figure out if they are locked in on PF vs can they
support VF in the future, and if they are locked in on PF one option is to
update the DTS testsuite accordingly
* Intel 40G:
   * Moving the performance testing of the XL710 Intel 40G over from legacy
DTS to new DTS today. The testruns have been complete and look good, we
just need to merge the pipeline change on Jenkins
* DPDK-Minimum-Kernel:
   * New minimum kernel version supported by DPDK is 5.4
   * Lab has deployed a new Ubuntu 22.04 test system, set to Kernel version
5.4
* DTS failure ticketing:
   * Dean at UNH has tracked the =E2=80=9Ctip of DPDK main=E2=80=9D DTS fai=
lures which
exist on NICs at the lab and is documenting these issues on the Ethdev
component in Bugzilla
* Arm Grace E810 test for Jay Wang at ARM
   * Requesting single core performance, multicore/multiqueue (with receive
side scaling). The first (single core) we can get via DTS, the second
(multi-core / multi-queue) we need to test manually.
      * If someone is requesting multi-queue RSS performance testing does
that mean that we should write such a performance test into DTS in the
future?
* Addings new distros:
   * Most of the distros are working, but newest Fedora will not build with
DPDK
      * It may be an issue with Python 3.14 (ships with newest Fedora) and
Meson .57 / Meson .61
Intel Lab
* None
Github Actions Robot
* None
Loongson Lab
* Loongson is requesting to setup a =E2=80=9Csecond CI Lab=E2=80=9D for a n=
ew set of
systems that have a different ABI system:
https://inbox.dpdk.org/ci/CAJvnSUBCj3ji2ShqyR=3D2e-FmXgKFf33eEVQOSPOhtiNwbq=
0Dbg@mail.gmail.com/T/#t
   * Loongson/Loongnix has two ABI systems, system 1.0 and 2.0, and a
person from a separate Loongson lab (from the existing Loongson CI) is
setting up an ABI 2.0 system and would like to report compile and unit
tests from that new lab with a new set of labels,
loongson-compile-loongarch64 and loongson-unit-loongarch64
   * Patrick asked on the thread whether it is possible to use a
service/system email instead of an individual person=E2=80=99s email to sen=
d the
reports (so if the person leaves the company and the email is deactivated
reports continue without issue)
DTS Improvements & Test Development
* Tech board indicated it would be okay for Patrick to remain maintainer of
DTS in his personal capacity after he is no longer working at UNH-IOL
   * Patrick will send a patch from his personal email (
patrickrobb1997@gmail.com) changing his MAINTAINERS file email in DPDK from
his UNH-IOL work email, to his personal email.
* DTS Roadmap:
https://docs.google.com/document/d/1WcAQS1IdUx9ilhWOK-Yy_CnCiG4REAgYw3gyTzy=
MnCs/edit?usp=3Dsharing
* Speed capabilities testsuite to be merged in 26.07
* Set VLAN TPID testcase:
   * TPID rewrite by ethdev/testpmd is only supported by Intel XL710 and
will not be supported by ICE (at least during 26.07) so it does not make
sense to write this testsuite.
   * If the feature is supported by other vendors in the future, the
testsuite can be added.

Any other business
   * Next meeting is April 16, 2026

--00000000000086b85a064e7f0a01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>April 2, 2026<br>Attendees<br>1. Patrick Robb<br>2. Ad=
am Hassick<br>3. Lincoln Lavoie<br>4. Aaron Conole<br>Minutes<br>General An=
nouncements<br>* AI Code Review:<br>=C2=A0 =C2=A0* Has been live since last=
 Friday, sending AI code reviews on a per patch series basis to <a href=3D"=
mailto:test-report@dpdk.org">test-report@dpdk.org</a><br>=C2=A0 =C2=A0* Mai=
ling list update and next steps: <a href=3D"https://inbox.dpdk.org/ci/CAJvn=
SUAtn7mUqkjoPHsEyiZLMe0w4kkg2n9SfB2OL=3DPR4vozGg@mail.gmail.com/T/#u">https=
://inbox.dpdk.org/ci/CAJvnSUAtn7mUqkjoPHsEyiZLMe0w4kkg2n9SfB2OL=3DPR4vozGg@=
mail.gmail.com/T/#u</a><br>=C2=A0 =C2=A0* Tech board discussed the matter y=
esterday:<br>=C2=A0 =C2=A0 =C2=A0 * It is borderline but based on the spend=
ing we are seeing right now, we will most likely spend less than the $100 c=
ap given the current size of our AGENTS.md<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* Aaron will also test Stephen=E2=80=99s AGENTS.md<br>=C2=A0 =C2=A0 =
=C2=A0 * There was also discussion about sending 1 monolithic AI code revie=
w per series vs splitting it out into multiple patch emails, whether to mai=
l to test-report vs dev mailing lists, etc. We are going to let people expe=
rience the current method of AI code reviews for a few weeks, and then Tech=
 Board will circle back and provide a final decision on these questions.<br=
>=C2=A0 =C2=A0* DPDK-Web<br>=C2=A0 =C2=A0 =C2=A0 * Patrick will try to summ=
arize the AI Code review status for a <a href=3D"http://dpdk.org">dpdk.org<=
/a> website patch today<br>* DPDK 26.03 has been released<br>* Today is Pat=
rick=E2=80=99s last day at UNH-IOL<br>CI Status<br>AWS Lab<br>* None, they =
are running normally<br>UNH-IOL Community Lab<br>* Cryptodev testing:<br>=
=C2=A0 =C2=A0* Running in CI<br>=C2=A0 =C2=A0* QAT 8970 running fine. There=
 was 1 issue with the config files for the QAT 41xx testing, and Andrew wil=
l fix this today<br>=C2=A0 =C2=A0* AMD CCP:<br>=C2=A0 =C2=A0 =C2=A0 * UNH h=
as an AMD CCP device in one of the new AMD processors at the lab, but it is=
 =E2=80=9Cphysical function only=E2=80=9D and our new testsuite is written =
to only use virtual functions.<br>=C2=A0 =C2=A0 =C2=A0 * Andrew to figure o=
ut if they are locked in on PF vs can they support VF in the future, and if=
 they are locked in on PF one option is to update the DTS testsuite accordi=
ngly<br>* Intel 40G:<br>=C2=A0 =C2=A0* Moving the performance testing of th=
e XL710 Intel 40G over from legacy DTS to new DTS today. The testruns have =
been complete and look good, we just need to merge the pipeline change on J=
enkins<br>* DPDK-Minimum-Kernel:<br>=C2=A0 =C2=A0* New minimum kernel versi=
on supported by DPDK is 5.4<br>=C2=A0 =C2=A0* Lab has deployed a new Ubuntu=
 22.04 test system, set to Kernel version 5.4<br>* DTS failure ticketing:<b=
r>=C2=A0 =C2=A0* Dean at UNH has tracked the =E2=80=9Ctip of DPDK main=E2=
=80=9D DTS failures which exist on NICs at the lab and is documenting these=
 issues on the Ethdev component in Bugzilla<br>* Arm Grace E810 test for Ja=
y Wang at ARM<br>=C2=A0 =C2=A0* Requesting single core performance, multico=
re/multiqueue (with receive side scaling). The first (single core) we can g=
et via DTS, the second (multi-core / multi-queue) we need to test manually.=
<br>=C2=A0 =C2=A0 =C2=A0 * If someone is requesting multi-queue RSS perform=
ance testing does that mean that we should write such a performance test in=
to DTS in the future?<br>* Addings new distros:<br>=C2=A0 =C2=A0* Most of t=
he distros are working, but newest Fedora will not build with DPDK<br>=C2=
=A0 =C2=A0 =C2=A0 * It may be an issue with Python 3.14 (ships with newest =
Fedora) and Meson .57 / Meson .61<br>Intel Lab<br>* None<br>Github Actions =
Robot<br>* None<br>Loongson Lab<br>* Loongson is requesting to setup a =E2=
=80=9Csecond CI Lab=E2=80=9D for a new set of systems that have a different=
 ABI system: <a href=3D"https://inbox.dpdk.org/ci/CAJvnSUBCj3ji2ShqyR=3D2e-=
FmXgKFf33eEVQOSPOhtiNwbq0Dbg@mail.gmail.com/T/#t">https://inbox.dpdk.org/ci=
/CAJvnSUBCj3ji2ShqyR=3D2e-FmXgKFf33eEVQOSPOhtiNwbq0Dbg@mail.gmail.com/T/#t<=
/a><br>=C2=A0 =C2=A0* Loongson/Loongnix has two ABI systems, system 1.0 and=
 2.0, and a person from a separate Loongson lab (from the existing Loongson=
 CI) is setting up an ABI 2.0 system and would like to report compile and u=
nit tests from that new lab with a new set of labels, loongson-compile-loon=
garch64 and loongson-unit-loongarch64<br>=C2=A0 =C2=A0* Patrick asked on th=
e thread whether it is possible to use a service/system email instead of an=
 individual person=E2=80=99s email to send the reports (so if the person le=
aves the company and the email is deactivated reports continue without issu=
e)<br>DTS Improvements &amp; Test Development<br>* Tech board indicated it =
would be okay for Patrick to remain maintainer of DTS in his personal capac=
ity after he is no longer working at UNH-IOL<br>=C2=A0 =C2=A0* Patrick will=
 send a patch from his personal email (<a href=3D"mailto:patrickrobb1997@gm=
ail.com">patrickrobb1997@gmail.com</a>) changing his MAINTAINERS file email=
 in DPDK from his UNH-IOL work email, to his personal email.<br>* DTS Roadm=
ap: <a href=3D"https://docs.google.com/document/d/1WcAQS1IdUx9ilhWOK-Yy_CnC=
iG4REAgYw3gyTzyMnCs/edit?usp=3Dsharing">https://docs.google.com/document/d/=
1WcAQS1IdUx9ilhWOK-Yy_CnCiG4REAgYw3gyTzyMnCs/edit?usp=3Dsharing</a><br>* Sp=
eed capabilities testsuite to be merged in 26.07<br>* Set VLAN TPID testcas=
e:<br>=C2=A0 =C2=A0* TPID rewrite by ethdev/testpmd is only supported by In=
tel XL710 and will not be supported by ICE (at least during 26.07) so it do=
es not make sense to write this testsuite.<br>=C2=A0 =C2=A0* If the feature=
 is supported by other vendors in the future, the testsuite can be added.<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>Any other bus=
iness<br>=C2=A0 =C2=A0* Next meeting is April 16, 2026</div>

--00000000000086b85a064e7f0a01--
