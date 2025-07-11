Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48385C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 17:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 465724021E;
	Fri, 11 Jul 2025 19:56:30 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id C8A6A4013F
 for <dev@dpdk.org>; Fri, 11 Jul 2025 19:56:28 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-311da0bef4aso2442829a91.3
 for <dev@dpdk.org>; Fri, 11 Jul 2025 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752256588; x=1752861388; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gsyMcG/XVxMtYRl3zDpHI4jhjXtJ9II42KeJTpnc/5s=;
 b=WlZddKQ5YaMRKDNTMvR7xXUeA9nrPCVkoYETqaGHynQoHnlleie0hNFUgbNpnuabQZ
 BwOywpHfq5z+cgcXZ/5rXTJO20n01LjrUmU8evuz7vvGwXrCWdAoZZkif4mJ/426FKjG
 SMvaHC1IhKtz1H+DzLm0+G5nbmUDf7cDNxb5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752256588; x=1752861388;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gsyMcG/XVxMtYRl3zDpHI4jhjXtJ9II42KeJTpnc/5s=;
 b=OmBkwqBNMReOYun2DnmgFBHVQzOAsETw1pIM6MXYsse01ayr4xAn4RSvHiutJip7f0
 o9n+Lht+j2xbAwITieXcTa2E4S2jwRFpPGowBHL0x9RCzkAmXU7dGqkR+dYn4cMraOG8
 7pkdmTmdu2+IR62fLPYJZtVCyOWS+/Vt4kepTutxS5gGT87byZph3VpKFWQnIoAcwfhV
 jPXXZ9aUfzos7fMK1+ErxvBzZ3MQ3TeoK2TQaPEN5umpnUSIdS0fqNDyM0yHcMyBSj0/
 VCSPlxrUUCVgbFpIUtAcBFtn4kbNyJQ4jEdzP9YxcjbXT78ebyUx9OsDeCv8itdtOyfW
 eYEw==
X-Gm-Message-State: AOJu0Yxgyjp4+9GILmFfonZMYsLWe0cEAg07WSBuLZ0dhJ1h0uUFDXjY
 ZQC85/wG0BWBS2CDj2dMVN8SmhVTdzS4BOv4+Pb8q4Qy8hVrF3u2G07oZsfazp6BkcLkU60ZiWf
 TgGYP2+wkcI77YcNtZaYtZj9fYn05Dmnae8Rc30yX8w==
X-Gm-Gg: ASbGncucBH8lVJ7IvAe2EENkN5liedut9izPIQIxoyL+ZZV8QWnlVXXSSpiQycJBbow
 DmbeQLDjXA07pLcen2cfmNo6oV8uYgX5zK9GGaiMXYsrPTNJWvmctwfeAJBbklR7jffLrT4YkQr
 1f8O42SXYcMIWkUUtltAOFks3KlVLaCH/lRNjUBKNo5ScQqGmeq2U880AXaRg9CmVcw8dlBxN2l
 Up18Whzp5QDhLm7hqcuvWTib+TGgeGo0Cv3vBam
X-Google-Smtp-Source: AGHT+IGZjkRHuM13LLU92Ni6PX3iWaqFZ79oCeo8QmjeewlzHULv2nlVbHvCRb4QfM7Z05k3LtJ8fSQDUyALcE6ElFc=
X-Received: by 2002:a17:90a:e18e:b0:31c:38f8:7efb with SMTP id
 98e67ed59e1d1-31c4f573322mr6319276a91.18.1752256586760; Fri, 11 Jul 2025
 10:56:26 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 11 Jul 2025 13:50:41 -0400
X-Gm-Features: Ac12FXyjRngfRcBnLXEKVutTtxzdlQggL5DumDcTqoBPThxHGFxN_qZdcdaXeMs
Message-ID: <CAJvnSUAQ3JQh_Zc-aOy5dgbGhYpbPXrsO4OYTYsag0iHH0Wqow@mail.gmail.com>
Subject: Community CI Meeting Minutes - July 9, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>, Aaron Conole <aconole@redhat.com>,
 Dean Marx <dmarx@iol.unh.edu>, 
 Adam Hassick <ahassick@iol.unh.edu>, "Brandes, Shai" <shaibran@amazon.com>, 
 zhoumin <zhoumin@loongson.cn>, 
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>
Content-Type: multipart/alternative; boundary="00000000000068d93a0639ab07c2"
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

--00000000000068d93a0639ab07c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
July 9, 2025
Attendees
1. Patrick Robb
2. Manit Mahajan
3. Dean Marx
4. Luca Vizzarro
5. Shai Brandes
6. Aaron Conole

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* Expected remaining RC schedule:
   * RC3 - July 9-10 (today/tomorrow)
   * DTS HEAD has been run with the check scripts, done a docs build, and
run some PF and VF tests (all working)
* Tech board will have a discussion this morning about =E2=80=9CVLAN tag an=
d QinQ
stripping in DPDK.=E2=80=9D
   * The behavior is not clearly defined, and should be standardized.
* Results from the =E2=80=9Cwhen to meet=E2=80=9D survey:
https://www.when2meet.com/?30965992-3ijyI
   * Basically, options going forward are Tuesdays from 12:00 UTC to 14:00
UTC, Wednesdays from 13:00 UTC to 14:00 UTC, and Thursdays from 12:00 UTC
to 13:00 UTC.
   * Next meeting will be at 12:00 UTC on Thursday the 24th
* DPDK-CI Test Recheck script has been updated to capture the =E2=80=9Creba=
se=E2=80=9D flag
for rebasing onto specific branches by developer request:
   *
https://patchwork.dpdk.org/project/ci/patch/20250611205849.72165-1-probb@io=
l.unh.edu/
   * https://core.dpdk.org/testing/#requesting-a-patch-retest
* /events/ PW rework
   * Agree: support project filtering for /events/
   * Adam Hassick and Aaron to work on this.
      * Aaron will come up to UNH in a few weeks to attack this, and ensure
it works for multiple projects he is involved with

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
AWS Lab
* Test recheck support plans:
   * This has been implemented, and should be live now.
   * We will need to update the DPDK website to indicate the support is now
live
   * If no rebase flag is included, they re-test the original artifact.
   * Some other labs report new results with the retest count, and Amazon
will aim to do the same
      * The value is that it=E2=80=99s not obvious from the UI whether the =
recheck
has happened/is complete.
* AWS infra failures:
   * Apply failures are sending a generic fail, and also running unit tests
and reporting the unit test logs
      * Correct behavior is to stop testing when the apply failure happens,
and send an =E2=80=9Capply failure=E2=80=9D report to test-report mailing l=
ist
      * Status: Solved
   * David noticed some failures due to timeout on the telemetry test,
other CIs extend the timeout with the -t arg:
      * Status: Using -t 60 now
* Review on apply failure on .rst files discussion from the previous meetin=
g
   * They are skipping the release notes in each patch.

---------------------------------------------------------------------
UNH-IOL Community Lab
* Apply patchset process: Skipping making a tarball if the patch is a docs
patch only.
   * Labeling as =E2=80=9Cnot applicable=E2=80=9D on the lab dashboard
   * There were some patches with code in them which were marked as =E2=80=
=9CDOCS
ONLY=E2=80=9D by create_series_artifact.py. We have overridden this by putt=
ing in
testing for these series, and we are debugging the script.
* Windows Builds:
   * Status: MSVC drivers enable had a compile failure due to MLX5.
      * This is because the drivers enable series has a series dependency
which has not yet been merged.
* Arm Grace E810:
   * There were some failures for the E810 NIC for an ICE PMD patch because
it updated the 16byte ICE PMD descriptors flag for Meson, so it was no
longer getting used by our testing and consequently MPPS was reduced about
6%.
   * There were some unrelated infra fails for this system yesterday. We
resolved the issue and put in retets. PW is =E2=80=9Call green.=E2=80=9D
* Patchwork polling:
   * Manit is working on refactoring our patchwork polling series.
* DTS:
   * Some new testsuites have been merged, and will be pulled into mainline
for RC3 imminently. We need to add these new testsuites to DTS configs at
the lab.
* Our CI server fell over last Thursday, which caused us to have to rerun
testing all Thursday patchseries on Thursday evening. We were caught up by
Friday evening.

---------------------------------------------------------------------
Intel Lab
* Did not get any responses from the Intel lab maintainer to the =E2=80=9Cs=
chedule
a meeting=E2=80=9D poll.

---------------------------------------------------------------------
Github Actions Robot
* AI initiative (patch review bot):
   * Based on sourcery.ai
   * Aaron has investigated the GH rest api about Pull Requests, comments,
etc. And he thinks it will be possible to pull the comments for a hunk
which has been added, and send emails to the mailing list (or at least to
the offer) with review comments. These emails can include links to the
github comments.
      * Will require setting up an alternative mirror repo and giving the
robot extra permissions on this repo
   * Status: In progress, but may require more feedback from Jerin, David,
etc.

---------------------------------------------------------------------
Loongson Lab
* Patchseries recheck support: Min Zhou has tested out the new version of
the get_reruns.py script, and has indicated he will use it to support the
rebase argument.
   * When this happens we need to update the DPDK website testing page to
update the supported labs list
   * Patrick Robb can submit the website update.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Merged since the previous meeting:
   * Virtual Function testing:
      * Packet forwarding from DTS created VFs is working (on mellanox and
broadcom, still figuring out if our Intel NICs are misconfigured for
promisc mode).
      * Important decisions to clarify:
         * The way that it works is that it sets 1 (and only 1) VF per PF,
and re-sets SUT ingress, SUT egress to the new virtual functions.
         * It runs the exact same tests as the PFs
         * Some testsuites are decorated with a specific PF_Required,
capability, meaning those are forced to skip.
   * Rte_flow testing:
      * There are some cases where Flow validate says =E2=80=9Ccan create t=
his flow
rule=E2=80=9D and then flow create says =E2=80=9CI cannot create this=E2=80=
=9D for various PMDs.
Dean is going to document these on Bugzilla and CC Flow and PMD
maintainers. This is pretty low hanging fruit.
      * There are some other failures on some devices which are more
involved, and will be documented separately.
   * Add generic blocking app class (now superclass of DPDK blocking app
class)
   * Rework test results series
      * It provides the =E2=80=9CReason=E2=80=9D for the failure inline alo=
ngside the
result in the results.json and result_summary.txt
   * These should all get pulled from next-dts to mainline imminently.
* Moved to the next release:
   * Single_core_forwarding test and TREX support:
      * This is running fine but the review of the v3 suggested changes
which were too significant to resolve at the end of this development cycle.
   * Qinq Testsuite
   * File manager / abstraction moved to the next release
      * Most straightforward solution (lazy approach) is using sftp
* DTS Roadmap:
   * Work on the roadmap at the DTS call next Thursday.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting Jul 24, 2025

--00000000000068d93a0639ab07c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>July 9, 2025<br>Attendees<br>1. Patrick Robb<br>2. Manit Mah=
ajan<br>3. Dean Marx<br>4. Luca Vizzarro<br>5. Shai Brandes<br>6. Aaron Con=
ole<br><br>################################################################=
#####<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>General Announcements<br>* Expected remaining RC schedule:<br>=C2=
=A0 =C2=A0* RC3 - July 9-10 (today/tomorrow)<br>=C2=A0 =C2=A0* DTS HEAD has=
 been run with the check scripts, done a docs build, and run some PF and VF=
 tests (all working)<br>* Tech board will have a discussion this morning ab=
out =E2=80=9CVLAN tag and QinQ stripping in DPDK.=E2=80=9D<br>=C2=A0 =C2=A0=
* The behavior is not clearly defined, and should be standardized.<br>* Res=
ults from the =E2=80=9Cwhen to meet=E2=80=9D survey: <a href=3D"https://www=
.when2meet.com/?30965992-3ijyI">https://www.when2meet.com/?30965992-3ijyI</=
a><br>=C2=A0 =C2=A0* Basically, options going forward are Tuesdays from 12:=
00 UTC to 14:00 UTC, Wednesdays from 13:00 UTC to 14:00 UTC, and Thursdays =
from 12:00 UTC to 13:00 UTC.<br>=C2=A0 =C2=A0* Next meeting will be at 12:0=
0 UTC on Thursday the 24th<br>* DPDK-CI Test Recheck script has been update=
d to capture the =E2=80=9Crebase=E2=80=9D flag for rebasing onto specific b=
ranches by developer request:<br>=C2=A0 =C2=A0* <a href=3D"https://patchwor=
k.dpdk.org/project/ci/patch/20250611205849.72165-1-probb@iol.unh.edu/">http=
s://patchwork.dpdk.org/project/ci/patch/20250611205849.72165-1-probb@iol.un=
h.edu/</a><br>=C2=A0 =C2=A0* <a href=3D"https://core.dpdk.org/testing/#requ=
esting-a-patch-retest">https://core.dpdk.org/testing/#requesting-a-patch-re=
test</a><br>* /events/ PW rework<br>=C2=A0 =C2=A0* Agree: support project f=
iltering for /events/<br>=C2=A0 =C2=A0* Adam Hassick and Aaron to work on t=
his.<br>=C2=A0 =C2=A0 =C2=A0 * Aaron will come up to UNH in a few weeks to =
attack this, and ensure it works for multiple projects he is involved with<=
div><br></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>CI Status</div><div><br></div><div>---------------------------------=
------------------------------------<br>AWS Lab<br>* Test recheck support p=
lans:<br>=C2=A0 =C2=A0* This has been implemented, and should be live now.<=
br>=C2=A0 =C2=A0* We will need to update the DPDK website to indicate the s=
upport is now live<br>=C2=A0 =C2=A0* If no rebase flag is included, they re=
-test the original artifact.<br>=C2=A0 =C2=A0* Some other labs report new r=
esults with the retest count, and Amazon will aim to do the same=C2=A0<br>=
=C2=A0 =C2=A0 =C2=A0 * The value is that it=E2=80=99s not obvious from the =
UI whether the recheck has happened/is complete.<br>* AWS infra failures:<b=
r>=C2=A0 =C2=A0* Apply failures are sending a generic fail, and also runnin=
g unit tests and reporting the unit test logs<br>=C2=A0 =C2=A0 =C2=A0 * Cor=
rect behavior is to stop testing when the apply failure happens, and send a=
n =E2=80=9Capply failure=E2=80=9D report to test-report mailing list<br>=C2=
=A0 =C2=A0 =C2=A0 * Status: Solved<br>=C2=A0 =C2=A0* David noticed some fai=
lures due to timeout on the telemetry test, other CIs extend the timeout wi=
th the -t arg:<br>=C2=A0 =C2=A0 =C2=A0 * Status: Using -t 60 now<br>* Revie=
w on apply failure on .rst files discussion from the previous meeting<br>=
=C2=A0 =C2=A0* They are skipping the release notes in each patch.<br><br>--=
-------------------------------------------------------------------<br>UNH-=
IOL Community Lab<br>* Apply patchset process: Skipping making a tarball if=
 the patch is a docs patch only.<br>=C2=A0 =C2=A0* Labeling as =E2=80=9Cnot=
 applicable=E2=80=9D on the lab dashboard<br>=C2=A0 =C2=A0* There were some=
 patches with code in them which were marked as =E2=80=9CDOCS ONLY=E2=80=9D=
 by create_series_artifact.py. We have overridden this by putting in testin=
g for these series, and we are debugging the script.<br>* Windows Builds:<b=
r>=C2=A0 =C2=A0* Status: MSVC drivers enable had a compile failure due to M=
LX5. <br>=C2=A0 =C2=A0 =C2=A0 * This is because the drivers enable series h=
as a series dependency which has not yet been merged.<br>* Arm Grace E810:<=
br>=C2=A0 =C2=A0* There were some failures for the E810 NIC for an ICE PMD =
patch because it updated the 16byte ICE PMD descriptors flag for Meson, so =
it was no longer getting used by our testing and consequently MPPS was redu=
ced about 6%.<br>=C2=A0 =C2=A0* There were some unrelated infra fails for t=
his system yesterday. We resolved the issue and put in retets. PW is =E2=80=
=9Call green.=E2=80=9D<br>* Patchwork polling:<br>=C2=A0 =C2=A0* Manit is w=
orking on refactoring our patchwork polling series.<br>* DTS:<br>=C2=A0 =C2=
=A0* Some new testsuites have been merged, and will be pulled into mainline=
 for RC3 imminently. We need to add these new testsuites to DTS configs at =
the lab.<br>* Our CI server fell over last Thursday, which caused us to hav=
e to rerun testing all Thursday patchseries on Thursday evening. We were ca=
ught up by Friday evening.<br><br>-----------------------------------------=
----------------------------<br>Intel Lab<br>* Did not get any responses fr=
om the Intel lab maintainer to the =E2=80=9Cschedule a meeting=E2=80=9D pol=
l.<br><br>-----------------------------------------------------------------=
----<br>Github Actions Robot<br>* AI initiative (patch review bot): <br>=C2=
=A0 =C2=A0* Based on <a href=3D"http://sourcery.ai">sourcery.ai</a><br>=C2=
=A0 =C2=A0* Aaron has investigated the GH rest api about Pull Requests, com=
ments, etc. And he thinks it will be possible to pull the comments for a hu=
nk which has been added, and send emails to the mailing list (or at least t=
o the offer) with review comments. These emails can include links to the gi=
thub comments.<br>=C2=A0 =C2=A0 =C2=A0 * Will require setting up an alterna=
tive mirror repo and giving the robot extra permissions on this repo<br>=C2=
=A0 =C2=A0* Status: In progress, but may require more feedback from Jerin, =
David, etc.<br><br>--------------------------------------------------------=
-------------<br>Loongson Lab<br>* Patchseries recheck support: Min Zhou ha=
s tested out the new version of the get_reruns.py script, and has indicated=
 he will use it to support the rebase argument.<br>=C2=A0 =C2=A0* When this=
 happens we need to update the DPDK website testing page to update the supp=
orted labs list<br>=C2=A0 =C2=A0* Patrick Robb can submit the website updat=
e.<br>=C2=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>DTS Improvements &amp; Test Development<br>* Merged since the pre=
vious meeting:<br>=C2=A0 =C2=A0* Virtual Function testing:<br>=C2=A0 =C2=A0=
 =C2=A0 * Packet forwarding from DTS created VFs is working (on mellanox an=
d broadcom, still figuring out if our Intel NICs are misconfigured for prom=
isc mode).<br>=C2=A0 =C2=A0 =C2=A0 * Important decisions to clarify:<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The way that it works is that it sets 1 (a=
nd only 1) VF per PF, and re-sets SUT ingress, SUT egress to the new virtua=
l functions.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* It runs the exact same =
tests as the PFs<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Some testsuites are=
 decorated with a specific PF_Required, capability, meaning those are force=
d to skip.<br>=C2=A0 =C2=A0* Rte_flow testing:<br>=C2=A0 =C2=A0 =C2=A0 * Th=
ere are some cases where Flow validate says =E2=80=9Ccan create this flow r=
ule=E2=80=9D and then flow create says =E2=80=9CI cannot create this=E2=80=
=9D for various PMDs. Dean is going to document these on Bugzilla and CC Fl=
ow and PMD maintainers. This is pretty low hanging fruit.<br>=C2=A0 =C2=A0 =
=C2=A0 * There are some other failures on some devices which are more invol=
ved, and will be documented separately.<br>=C2=A0 =C2=A0* Add generic block=
ing app class (now superclass of DPDK blocking app class)<br>=C2=A0 =C2=A0*=
 Rework test results series<br>=C2=A0 =C2=A0 =C2=A0 * It provides the =E2=
=80=9CReason=E2=80=9D for the failure inline alongside the result in the re=
sults.json and result_summary.txt<br>=C2=A0 =C2=A0* These should all get pu=
lled from next-dts to mainline imminently.<br>* Moved to the next release:<=
br>=C2=A0 =C2=A0* Single_core_forwarding test and TREX support:<br>=C2=A0 =
=C2=A0 =C2=A0 * This is running fine but the review of the v3 suggested cha=
nges which were too significant to resolve at the end of this development c=
ycle.<br>=C2=A0 =C2=A0* Qinq Testsuite<br>=C2=A0 =C2=A0* File manager / abs=
traction moved to the next release<br>=C2=A0 =C2=A0 =C2=A0 * Most straightf=
orward solution (lazy approach) is using sftp<br>* DTS Roadmap:<br>=C2=A0 =
=C2=A0* Work on the roadmap at the DTS call next Thursday.<br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>*=
 Next Meeting Jul 24, 2025<br><br><br><br></div></div>

--00000000000068d93a0639ab07c2--
