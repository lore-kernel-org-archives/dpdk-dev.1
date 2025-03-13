Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CE0C35FF1
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 23:32:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6DF9402E5;
	Fri, 14 Mar 2025 00:32:04 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 25DA040289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 00:32:03 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so3351630a91.0
 for <dev@dpdk.org>; Thu, 13 Mar 2025 16:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741908722; x=1742513522; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+PWLcczrtFJWXvEN3pm7O8BGEFBdgfo+xrNdBrNREtA=;
 b=aT2OwiXmVlU9cRE15xVWtUEVgSmdW17slA2g5QVaXgY6+QIhp0jJUJ0W1wTjdLZPkl
 jC3oE22b0eb/hW1oHFEOir8UMf04ODSiIiaJ0olQtm0EstbWA+eVjbuJfdWoQZoIB03+
 /2EeIR6wenAJvryfugCZAQ3LVCjO7kBMkROaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741908722; x=1742513522;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+PWLcczrtFJWXvEN3pm7O8BGEFBdgfo+xrNdBrNREtA=;
 b=qzNbtkSCyeDiD/OaJBgvYXLGgreUrK3ZdZURjqgP9i5UhSNM0viTqrZqQe9eWxCxjp
 aUBEXIfU3cQEDiCLytmuzx6H667ECyzhHiAF8y8fEFtFdfWAP47tuGuHT4G+V7i3lV9R
 1YZ1Zw4LeMerixt/VcbGWOjrEgbddDv8wcPsygaPqbvat/FlKfKE6D9sQldd2lIKHpgC
 CrGa74i7p2Ynu671JM62pZJn0QXr+tK53Nzm5rfTVKy9AUJjUwGJCrys9CFGnEkMGRhR
 bLK4o//rmw+9643cDRfYeGyjfaoCoTrTH/RvHDUr1VPLWvBjwo5m92HvQmEURTiqGL1y
 LtvA==
X-Gm-Message-State: AOJu0YxxnXxmSvLoKt5D2iro7nieYRXKsApK2ee4uK560gslx4Y//IsT
 1AaUCw1vw1JNyDFlNODSkemv4T8ipI2QttMLycsgxCv0QApfDlAGTrKibLdssKhpf96ZIe3lDcr
 4MVBR4XclUWUVaEsCpyMH14QQpXI7UGZq4GQk25qyPyrHig5cis37ng==
X-Gm-Gg: ASbGnctggtTfogMBRUEZkV7ic0Z1BqpnqpXBJMHL2xee/UWNNGJOoRt2yJ73HK+hkBt
 4Cjpr6xVD5ACyyZ6IeLfdrbvBG9V5QOIkGwLGXPQJFPwn7aH5Pon6L2m+ufGLRgdQxR7xb8ihfL
 7xZ+ezZM5BwHze9x7oBjIaVNA4q2E9W14JmjcZnJX1Yl7e+WF+qWSfLTNQV+c=
X-Google-Smtp-Source: AGHT+IELdQ4/biyU0mZDhMsyLmdG2DOlms3BoHgcWnYamDDtuQaYuoymoktDM03h4cJAMWWz2zk5LL4CRQKB5/sRvpc=
X-Received: by 2002:a17:90b:3a08:b0:2fe:a515:4a98 with SMTP id
 98e67ed59e1d1-30151d650cemr388952a91.31.1741908721920; Thu, 13 Mar 2025
 16:32:01 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 19:28:19 -0400
X-Gm-Features: AQ5f1Jo4jmsfEa4Xn00shAjDy3x7WpSP3vSE4Hr00KVIDBN3h_ynY0C85DPKpWk
Message-ID: <CAJvnSUCGxakrcRpko1t2_SH2acOeesq07w+FL61e-OxzN+rU9Q@mail.gmail.com>
Subject: Community CI Meeting Minutes - March 6, 2025
To: dev <dev@dpdk.org>, ci@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000009a0649063041ba92"
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

--0000000000009a0649063041ba92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
March 6, 2025
Attendees
. Patrick Robb
. Paul Szczepanek
. Luca Vizzarro
. Aaron Conole
. Andre Muezerie

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* DPDK Summit Prague is May 8-9:
   * The CFP has been extended to March 9
   * Aaron will submit a CFP for the patch submission policy in DPDK. This
pertains to the frequency of patchseries submissions, patch size, and the
importance for developers to do some basic testing (like compile testing)
before submitting to the CI. One issue is that patch volume is so high that
the dev mailing list is more of a =E2=80=9Cwrite only mailing list=E2=80=9D=
 than one which
a human can reasonably read and provide reviews for.
   * Patrick will submit a CFP for a talk about UNH=E2=80=99s experience ru=
nning
DTS in it=E2=80=99s CI automation

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* UNH has added a 32 bit x86_32 cross compile test (debian), using a cross
compile target Bruce R added during 24.11:
https://git.dpdk.org/dpdk/tree/config/x86/cross-32bit-debian.ini
* Robin Jarry (redhat) has reached out to ask if the DPDK graph router
(Grout) that he is developing can be tested on UNH lab hardware. We
discussed it with tech board yesterday and unless there are significant
hurdles which will require lots of man hours at UNH, we should do this.
I=E2=80=99ve reached out to Robin with some initial questions and gotten th=
ese
clarifications:
   * 1. We could test 1x/week on the nightly build
https://github.com/DPDK/grout/releases/tag/edge
   * 2. The initial testing would be for functional regressions only. Once
they do performance optimizations, they may be interested in perf testing.
   * 3. Test reports can be sent to the grout mailing list:
https://mails.dpdk.org/listinfo/grout
   * 4. They have some tests currently, which may have to be adapted
slightly for bare-metal, but can be used by UNH:
https://github.com/DPDK/grout/tree/main/smoke
   * 5. Robin indicated any recent NIC is okay (X710, E810, CX5, CX6)
   * Patrick will try to stand up Grout on the hardware to investigate the
basics, and send any further questions to Robin. Then we can loop back to
tech board and seek their final approval for using the lab resources for
this.
   * Aaron has highlighted that the grout guys should complete most/all of
the scripting, so that the UNH resources (which are really for DPDK CI
testing) are not exhausted in efforts to maintain grout testing
* Arm Grace had an infra failure yesterday which cut the performance
numbers in half for runs in the 2nd half of the day. I didn=E2=80=99t have =
time to
do a deep dive in this case (just restarted the machine and triggered
retests) but we=E2=80=99ll keep an eye on it.
* Dpdk-test: per_lcore_autotest had a spurious fail in UNH CI - documented
it on Bugzilla https://bugs.dpdk.org/show_bug.cgi?id=3D1668
   * David has a suggestion for what the issue is: =E2=80=9Cit starts a cal=
lback
that wait 100ms on a separate thread, and thinks that nothing will disturb
the main thread.=E2=80=9D
* lab.dpdk.org got an update to the code coverage report page, which allows
the coverage reports to be opened within the website, instead of the user
downloading the .zip and opening locally:
   * https://lab.dpdk.org/results/dashboard/code-coverage
* Cody is updating our XL710 testing, recreating the test on a newer
testbed (Intel Xeon 3rd gen processor). This will probably run silently for
the rest of 25.03, then we will shift over to the new server with the new
release.
* Had some false failures for new DTS because we rebooted the server
without modprobing vfio-pci before triggering new CI tests. Legacy DTS
loads the DPDK driver, but we elected not to for new DTS in order to allow
space for users to load vfio-pci with custom params. This is fine, I am
just noting here that this is still on the user to do before running
in-repo DTS.
Intel Lab
* Reported some failures yesterday, I think they were accurate but Patrick
should double check to make sure.

---------------------------------------------------------------------
Github Actions
* David added a patch which adds windows compilation for the github robot,
which has been running for a few weeks. It=E2=80=99s a server 2022 VM runni=
ng the
MSVC compile toolchain.
* No new news for FreeBSD

---------------------------------------------------------------------
AWS
* They are working on their test-report email templating script

---------------------------------------------------------------------
Loongarch Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Can we make a =E2=80=9Cdev=E2=80=9D branch on dpdk-next-dts. Indicate to =
maintainers that
they should pull from for-main?
   * Patrick can email Thomas and David asking for approval
* VF creation:
   * Can be pushed to next release
   * Mellanox VFs seem to work fine, but Patrick is having some issues
forwarding packets with XL710 VFs, even with promisc=3Don
* Per testsuite configs:
   * Update to run DTS, enforcing a single =E2=80=9Ctestrun.=E2=80=9D
* Build-less driver binding:
   * Are the temp dirs being used?
https://patchwork.dpdk.org/project/dpdk/patch/20250224132823.196509-4-luca.=
vizzarro@arm.com/
      * Yes, we are copying the dpdk-devbind.py into these dirs
      * This also stages some future work, like the artifact manager. We
will have to discuss at the start of the 25.07 development cycle.
* Luca has picked up two old patches:
   * https://patches.dpdk.org/project/dpdk/list/?series=3D32704
   * https://patches.dpdk.org/project/dpdk/list/?series=3D32888
* Performance testing:
   * Nick experimented with running TREX from .pcaps which can be written
from Scapy, and saw no benefit as compared to our initial approach (run
from /stl python defined traffic profiles)
* The testpmd patch which adds the L4 port # to testpmd verbose output is
on next-net.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting Mar 20, 2025

--0000000000009a0649063041ba92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>March 6, 2025<br>Attendees<br>. Patrick Robb<br>. Paul Szcze=
panek<br>. Luca Vizzarro<br>. Aaron Conole<br>. Andre Muezerie<br><br>#####=
################################################################<br>Minutes=
<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Gener=
al Announcements<br>* DPDK Summit Prague is May 8-9:<br>=C2=A0 =C2=A0* The =
CFP has been extended to March 9<br>=C2=A0 =C2=A0* Aaron will submit a CFP =
for the patch submission policy in DPDK. This pertains to the frequency of =
patchseries submissions, patch size, and the importance for developers to d=
o some basic testing (like compile testing) before submitting to the CI. On=
e issue is that patch volume is so high that the dev mailing list is more o=
f a =E2=80=9Cwrite only mailing list=E2=80=9D than one which a human can re=
asonably read and provide reviews for.<br>=C2=A0 =C2=A0* Patrick will submi=
t a CFP for a talk about UNH=E2=80=99s experience running DTS in it=E2=80=
=99s CI automation<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>CI Status<br><br>---------------------------------------------=
------------------------<br>UNH-IOL Community Lab<br>* UNH has added a 32 b=
it x86_32 cross compile test (debian), using a cross compile target Bruce R=
 added during 24.11: <a href=3D"https://git.dpdk.org/dpdk/tree/config/x86/c=
ross-32bit-debian.ini">https://git.dpdk.org/dpdk/tree/config/x86/cross-32bi=
t-debian.ini</a><br>* Robin Jarry (redhat) has reached out to ask if the DP=
DK graph router (Grout) that he is developing can be tested on UNH lab hard=
ware. We discussed it with tech board yesterday and unless there are signif=
icant hurdles which will require lots of man hours at UNH, we should do thi=
s. I=E2=80=99ve reached out to Robin with some initial questions and gotten=
 these clarifications:<br>=C2=A0 =C2=A0* 1. We could test 1x/week on the ni=
ghtly build <a href=3D"https://github.com/DPDK/grout/releases/tag/edge">htt=
ps://github.com/DPDK/grout/releases/tag/edge</a><br>=C2=A0 =C2=A0* 2. The i=
nitial testing would be for functional regressions only. Once they do perfo=
rmance optimizations, they may be interested in perf testing.<br>=C2=A0 =C2=
=A0* 3. Test reports can be sent to the grout mailing list: <a href=3D"http=
s://mails.dpdk.org/listinfo/grout">https://mails.dpdk.org/listinfo/grout</a=
><br>=C2=A0 =C2=A0* 4. They have some tests currently, which may have to be=
 adapted slightly for bare-metal, but can be used by UNH: <a href=3D"https:=
//github.com/DPDK/grout/tree/main/smoke">https://github.com/DPDK/grout/tree=
/main/smoke</a><br>=C2=A0 =C2=A0* 5. Robin indicated any recent NIC is okay=
 (X710, E810, CX5, CX6)<br>=C2=A0 =C2=A0* Patrick will try to stand up Grou=
t on the hardware to investigate the basics, and send any further questions=
 to Robin. Then we can loop back to tech board and seek their final approva=
l for using the lab resources for this.<br>=C2=A0 =C2=A0* Aaron has highlig=
hted that the grout guys should complete most/all of the scripting, so that=
 the UNH resources (which are really for DPDK CI testing) are not exhausted=
 in efforts to maintain grout testing<br>* Arm Grace had an infra failure y=
esterday which cut the performance numbers in half for runs in the 2nd half=
 of the day. I didn=E2=80=99t have time to do a deep dive in this case (jus=
t restarted the machine and triggered retests) but we=E2=80=99ll keep an ey=
e on it. <br>* Dpdk-test: per_lcore_autotest had a spurious fail in UNH CI =
- documented it on Bugzilla <a href=3D"https://bugs.dpdk.org/show_bug.cgi?i=
d=3D1668">https://bugs.dpdk.org/show_bug.cgi?id=3D1668</a><br>=C2=A0 =C2=A0=
* David has a suggestion for what the issue is: =E2=80=9Cit starts a callba=
ck that wait 100ms on a separate thread, and thinks that nothing will distu=
rb the main thread.=E2=80=9D<br>* <a href=3D"http://lab.dpdk.org">lab.dpdk.=
org</a> got an update to the code coverage report page, which allows the co=
verage reports to be opened within the website, instead of the user downloa=
ding the .zip and opening locally:<br>=C2=A0 =C2=A0* <a href=3D"https://lab=
.dpdk.org/results/dashboard/code-coverage">https://lab.dpdk.org/results/das=
hboard/code-coverage</a><br>* Cody is updating our XL710 testing, recreatin=
g the test on a newer testbed (Intel Xeon 3rd gen processor). This will pro=
bably run silently for the rest of 25.03, then we will shift over to the ne=
w server with the new release.<br>* Had some false failures for new DTS bec=
ause we rebooted the server without modprobing vfio-pci before triggering n=
ew CI tests. Legacy DTS loads the DPDK driver, but we elected not to for ne=
w DTS in order to allow space for users to load vfio-pci with custom params=
. This is fine, I am just noting here that this is still on the user to do =
before running in-repo DTS.<br>Intel Lab<br>* Reported some failures yester=
day, I think they were accurate but Patrick should double check to make sur=
e.<br><br>-----------------------------------------------------------------=
----<br>Github Actions<br>* David added a patch which adds windows compilat=
ion for the github robot, which has been running for a few weeks. It=E2=80=
=99s a server 2022 VM running the MSVC compile toolchain.<br>* No new news =
for FreeBSD<br><br>--------------------------------------------------------=
-------------<br>AWS<br>* They are working on their test-report email templ=
ating script<br><br>-------------------------------------------------------=
--------------<br>Loongarch Lab<br>* None<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Developmen=
t<br>* Can we make a =E2=80=9Cdev=E2=80=9D branch on dpdk-next-dts. Indicat=
e to maintainers that they should pull from for-main?<br>=C2=A0 =C2=A0* Pat=
rick can email Thomas and David asking for approval =C2=A0<br>* VF creation=
:<br>=C2=A0 =C2=A0* Can be pushed to next release<br>=C2=A0 =C2=A0* Mellano=
x VFs seem to work fine, but Patrick is having some issues forwarding packe=
ts with XL710 VFs, even with promisc=3Don<br>* Per testsuite configs:<br>=
=C2=A0 =C2=A0* Update to run DTS, enforcing a single =E2=80=9Ctestrun.=E2=
=80=9D<br>* Build-less driver binding:<br>=C2=A0 =C2=A0* Are the temp dirs =
being used? <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/202502=
24132823.196509-4-luca.vizzarro@arm.com/">https://patchwork.dpdk.org/projec=
t/dpdk/patch/20250224132823.196509-4-luca.vizzarro@arm.com/</a><br>=C2=A0 =
=C2=A0 =C2=A0 * Yes, we are copying the dpdk-devbind.py into these dirs<br>=
=C2=A0 =C2=A0 =C2=A0 * This also stages some future work, like the artifact=
 manager. We will have to discuss at the start of the 25.07 development cyc=
le.<br>* Luca has picked up two old patches:<br>=C2=A0 =C2=A0* <a href=3D"h=
ttps://patches.dpdk.org/project/dpdk/list/?series=3D32704">https://patches.=
dpdk.org/project/dpdk/list/?series=3D32704</a><br>=C2=A0 =C2=A0* <a href=3D=
"https://patches.dpdk.org/project/dpdk/list/?series=3D32888">https://patche=
s.dpdk.org/project/dpdk/list/?series=3D32888</a><br>* Performance testing:<=
br>=C2=A0 =C2=A0* Nick experimented with running TREX from .pcaps which can=
 be written from Scapy, and saw no benefit as compared to our initial appro=
ach (run from /stl python defined traffic profiles)<br>* The testpmd patch =
which adds the L4 port # to testpmd verbose output is on next-net. <br><br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other busi=
ness<br>* Next Meeting Mar 20, 2025</div>

--0000000000009a0649063041ba92--
