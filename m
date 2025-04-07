Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEDEC3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:23:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BD5340A81;
	Mon,  7 Apr 2025 17:23:46 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 232AD40A7F
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:23:45 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ad51f427054so3035916a12.1
 for <dev@dpdk.org>; Mon, 07 Apr 2025 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744039424; x=1744644224; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1eX0WO61WjMoaQ3Z2im27JqTbjIpVQji+ba3K67m9e4=;
 b=SOCicea1WoonVNJEBJkcZixjACwoLb6yVEoqig8+WskbrFUrZ5oqLsWoNMOBGECoXM
 09nrwKWL4hC9Y2D18rpX4bUVeWoVxDl3a6dtF9v8meYVSqodryLbpqKtijsEcGTcA4zn
 qQFmia9nqgK++hAoTjibk73i3dI/VjObN8974=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744039424; x=1744644224;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1eX0WO61WjMoaQ3Z2im27JqTbjIpVQji+ba3K67m9e4=;
 b=mzTNUK4mIIitZum9NkSgjweMvh3KzpF25mzhDqcZBIbiD4VOQoWYW/a/d+vnmWj85T
 gNg5Ymhm241F9ogOaZD3NhBv5NJeQkflxzkAn011cTRpfYbIY2hbm0lDR01c8y48N7Pv
 ++PPJPFHdL8qugXe9pSnkHWnwcKDH9nU9XVDk6ogW3o9djyJ/tnyYZp1tnZ9tTNvFluF
 yZ2jqfI6aJRh4cWzRypLG6jSxkg9XXtitsY2qnMTqgQ1mGbuYS8NxWQT4SQpnxaRQT8i
 7m1C9S3ZJ9s6H3MvFHTwGKiaL4LPm2S/sqFkzg7bLefwlzCD57JYdCcws7g2yBGqEAeD
 vOsQ==
X-Gm-Message-State: AOJu0Yxx1vEMAS4liGN31J5Mg3LzQxOwoR2duXSHF6/A9IWwxG2f0hdp
 QFGk0J21AaK3+OaX1ZM8vGYCldXkeLejVz+j9mUdTSafEe6Xxp2I5KMTuDLyqbqqaWGURrIErws
 ICAiabmnIyZlJF908D9mBZ2dIo6AmW1YUPLjdYQH+HIRT7bD6pb5B6g==
X-Gm-Gg: ASbGncvgrz+/KNa4p0sHEGBb42ZkuEtLxwnN9cprBHfhaZ9ppcDzAF5jgCPbzIW+628
 js8vLq6DPpniscXMlKEZtlwoT01fLDqNNAmVV/Yx6GeVKrJgi/pdcnsrG4AbaTfudGVc61VHKMm
 amfART9uc01Slrval1C+oN6BiSzPtNT2ia6gEhuPbxiVDIVKfaxWI0miFAKPA=
X-Google-Smtp-Source: AGHT+IG2IhzuXYSKXBIl46JQ3CPFwN5dg1JF6C0T8kAYf42yFf/MB13jsSGc3SWOyWEoFZy2xF8DFerg8kBeFsM49+c=
X-Received: by 2002:a17:90b:514e:b0:304:ec28:4437 with SMTP id
 98e67ed59e1d1-306a4b70e72mr15736124a91.22.1744039423075; Mon, 07 Apr 2025
 08:23:43 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 7 Apr 2025 11:19:35 -0400
X-Gm-Features: ATxdqUHEiwDuVev3axTxZ9QzlOP-t_Ctc637mLELEYJpqCCNcxVdgcB9duYc0kI
Message-ID: <CAJvnSUCrpSU0+exv_P6aqPev8cW7mARAdRSOmrLXsX378+K6Ew@mail.gmail.com>
Subject: Community CI Meeting Minutes - April 3, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000049828e063231d20c"
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

--00000000000049828e063231d20c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
April 3, 2025
Attendees
1. Patrick Robb
2. Paul Szczepanek
3. Luca Vizzarro
4. Aaron Conole
5. Manit Mahajan

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* Can we reschedule this meeting to account for daylight saving time?
   * Will move the call 1 hour earlier going forward to account for
daylight saving time. This brings the meeting to 13:00 UTC.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* New DTS:
   * We are missing some DTS results (for Intel XL710) from this week due
to a dpdk tarball naming conflict on the DUT. This failed =E2=80=9Csilently=
=E2=80=9D from
our perspective because we were not checking the DTS exit code and flagging
non-zero codes in our CI alert system. We are adding that now and Dean will
put in retests for the XL710 later today.
* Minimum Kernel Version Test:
   * The UNH Lab is running build and unit tests off of a VM which is set
to kernel 4.19 - the minimum tested kernel version according to DPDK docs.
* QAT Crypto Test:
   * Cody at UNH has setup a dpdk-crypto-perf test (from legacy DTS) on the
QAT crypto device which came with one of the Intel Xeon CPUs added to the
lab in 2024.
   * We will share the performance metrics with Bruce Richardson/Intel and
then enable reporting for this test
* Baremetal testing maintenance:
   * We are moving around some NICs to newer systems, updating drivers, and
other normal maintenance that we do on baremetal systems at the start of a
release dev cycle
* We are now reporting the dts-check-format label to patchwork

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions
* Aaron has a pre-req patch ready to go for the recheck count. This is for
the PW-CI project.

---------------------------------------------------------------------
AWS
* Patrick will reach out to Shai for an update

---------------------------------------------------------------------
Loongarch Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Smoke Tests Testsuite bugfixes:
   * There are two issues, one pertaining to a keyerror on the tests_config
dictionary and the other pertaining to the regex which is used to capture
the driver NICs are bound to from dpdk-devbind.py -s
* DTS Packet Sniffer update:
   * No updates, but this is reviewed from Dean and Patrick
* Performance TG update:
   * DTS Configuration and TestSuite API notes:
      * 1. Test_run.yaml:
         * app location
         * trex configuration
      * TestSuite Class facing functions:
         * define a packet X with scapy
         * call TestSuite.assess_performance_by_packet(packet X, duration Y=
)
         * This returns an instance of a new performance stats dataclass
   * TG internals notes:
      * Imports a series of TREX stateless API components
      * A set of one STLCLient, Stream and PacketBuilder are created.
      * Once created, the STLStream is started using the given duration.
When completed, stats are gathered via stdout and put into the
PerformanceStats dataclass.
* DTS Roadmap
   * 1. TG abstraction rework (to facilitate performance TGs), testsuite
API additions for perf workloads, and TREX class implementation
      * Luca raised that it may be best to leave the perf TGs as child
classes of the current tg abstract class and simply not implement the
capturing methods
      * Luca also raises that his asyncsniffer patchseries adds some new
methods of collecting packets, such as collecting until a stop condition is
met (like seeing packet X). This may split out packet send and packet
capture from send_packet_and_capture(), making them independent.
   * 2. Write testsuite perf_single_core_fwd
   * 3. Write testsuite rte_flow
   * 4. Port VF support
   * 5. Docs improvements for new users
      * Luca has indicated that Thomas Wilks will contribute to this
   * 6. Rework packet send and receive functions in the Testsuite API
towards supporting IP networking in an L3 environment
   * 7. DPDK Testsuite API: This will provide a stable API which will not
be broken going forward (except at agreed upon intervals)
      * Moving existing testsuite functions to the context hierarchy
   * 8. RSS Support Testsuites
      * Work for this is basically done - reviews needed though:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D34713
   * 9. Update TestResult module in order to give a more human readable
summary of the testsuites
   * 10. Improved interactive shell data collection and logging.
      * Add a file which exclusively logs the shell interactions
   * 11. Add dedicated file manager to handle passing files and artifacts
between the test engine and nodes in a path agnostic manner
      * This will be a component of the new DPDK DTS API
   * 12. Flexible port binding
      * Give the opportunity to test suites to use all or part of the
supplied port topology with the kernel drivers (instead of DPDK). Could be
achieved with a decorator
      * This will require the Topology class to be aware of what=E2=80=99s =
truly
available for DPDK and provide only the right ports for it
   * 13. Add  pseudo-shell which handles background services.
      * https://patchwork.dpdk.org/project/dpdk/list/?series=3D34865
   * 14. L4 port packet matching:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D34805

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting Apr 17, 2025

--00000000000049828e063231d20c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>April 3, 2025<br>Attendees<br>1. Patrick Robb<br>2. Paul Szc=
zepanek<br>3. Luca Vizzarro<br>4. Aaron Conole<br>5. Manit Mahajan<br><br>#=
####################################################################<br>Min=
utes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Ge=
neral Announcements<br>* Can we reschedule this meeting to account for dayl=
ight saving time?<br>=C2=A0 =C2=A0* Will move the call 1 hour earlier going=
 forward to account for daylight saving time. This brings the meeting to 13=
:00 UTC.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>CI Status<br><br>------------------------------------------------------=
---------------<br>UNH-IOL Community Lab<br>* New DTS:<br>=C2=A0 =C2=A0* We=
 are missing some DTS results (for Intel XL710) from this week due to a dpd=
k tarball naming conflict on the DUT. This failed =E2=80=9Csilently=E2=80=
=9D from our perspective because we were not checking the DTS exit code and=
 flagging non-zero codes in our CI alert system. We are adding that now and=
 Dean will put in retests for the XL710 later today. <br>* Minimum Kernel V=
ersion Test:<br>=C2=A0 =C2=A0* The UNH Lab is running build and unit tests =
off of a VM which is set to kernel 4.19 - the minimum tested kernel version=
 according to DPDK docs. <br>* QAT Crypto Test:<br>=C2=A0 =C2=A0* Cody at U=
NH has setup a dpdk-crypto-perf test (from legacy DTS) on the QAT crypto de=
vice which came with one of the Intel Xeon CPUs added to the lab in 2024.<b=
r>=C2=A0 =C2=A0* We will share the performance metrics with Bruce Richardso=
n/Intel and then enable reporting for this test<br>* Baremetal testing main=
tenance: <br>=C2=A0 =C2=A0* We are moving around some NICs to newer systems=
, updating drivers, and other normal maintenance that we do on baremetal sy=
stems at the start of a release dev cycle<br>* We are now reporting the dts=
-check-format label to patchwork<br><br>-----------------------------------=
----------------------------------<br>Intel Lab<br>* None<br><br>----------=
-----------------------------------------------------------<br>Github Actio=
ns<br>* Aaron has a pre-req patch ready to go for the recheck count. This i=
s for the PW-CI project.<br><br>-------------------------------------------=
--------------------------<br>AWS<br>* Patrick will reach out to Shai for a=
n update<br><br>-----------------------------------------------------------=
----------<br>Loongarch Lab<br>* None<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Development<br>*=
 Smoke Tests Testsuite bugfixes:<br>=C2=A0 =C2=A0* There are two issues, on=
e pertaining to a keyerror on the tests_config dictionary and the other per=
taining to the regex which is used to capture the driver NICs are bound to =
from dpdk-devbind.py -s<br>* DTS Packet Sniffer update:<br>=C2=A0 =C2=A0* N=
o updates, but this is reviewed from Dean and Patrick<br>* Performance TG u=
pdate:<br>=C2=A0 =C2=A0* DTS Configuration and TestSuite API notes:<br>=C2=
=A0 =C2=A0 =C2=A0 * 1. Test_run.yaml:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
* app location<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* trex configuration<br=
>=C2=A0 =C2=A0 =C2=A0 * TestSuite Class facing functions:<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0* define a packet X with scapy<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0* call TestSuite.assess_performance_by_packet(packet X, durati=
on Y)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This returns an instance of a =
new performance stats dataclass<br>=C2=A0 =C2=A0* TG internals notes: <br>=
=C2=A0 =C2=A0 =C2=A0 * Imports a series of TREX stateless API components<br=
>=C2=A0 =C2=A0 =C2=A0 * A set of one STLCLient, Stream and PacketBuilder ar=
e created.<br>=C2=A0 =C2=A0 =C2=A0 * Once created, the STLStream is started=
 using the given duration. When completed, stats are gathered via stdout an=
d put into the PerformanceStats dataclass.<br>* DTS Roadmap<br>=C2=A0 =C2=
=A0* 1. TG abstraction rework (to facilitate performance TGs), testsuite AP=
I additions for perf workloads, and TREX class implementation<br>=C2=A0 =C2=
=A0 =C2=A0 * Luca raised that it may be best to leave the perf TGs as child=
 classes of the current tg abstract class and simply not implement the capt=
uring methods<br>=C2=A0 =C2=A0 =C2=A0 * Luca also raises that his asyncsnif=
fer patchseries adds some new methods of collecting packets, such as collec=
ting until a stop condition is met (like seeing packet X). This may split o=
ut packet send and packet capture from send_packet_and_capture(), making th=
em independent.<br>=C2=A0 =C2=A0* 2. Write testsuite perf_single_core_fwd<b=
r>=C2=A0 =C2=A0* 3. Write testsuite rte_flow<br>=C2=A0 =C2=A0* 4. Port VF s=
upport<br>=C2=A0 =C2=A0* 5. Docs improvements for new users<br>=C2=A0 =C2=
=A0 =C2=A0 * Luca has indicated that Thomas Wilks will contribute to this<b=
r>=C2=A0 =C2=A0* 6. Rework packet send and receive functions in the Testsui=
te API towards supporting IP networking in an L3 environment<br>=C2=A0 =C2=
=A0* 7. DPDK Testsuite API: This will provide a stable API which will not b=
e broken going forward (except at agreed upon intervals)<br>=C2=A0 =C2=A0 =
=C2=A0 * Moving existing testsuite functions to the context hierarchy<br>=
=C2=A0 =C2=A0* 8. RSS Support Testsuites<br>=C2=A0 =C2=A0 =C2=A0 * Work for=
 this is basically done - reviews needed though: <a href=3D"https://patchwo=
rk.dpdk.org/project/dpdk/list/?series=3D34713">https://patchwork.dpdk.org/p=
roject/dpdk/list/?series=3D34713</a><br>=C2=A0 =C2=A0* 9. Update TestResult=
 module in order to give a more human readable summary of the testsuites<br=
>=C2=A0 =C2=A0* 10. Improved interactive shell data collection and logging.=
<br>=C2=A0 =C2=A0 =C2=A0 * Add a file which exclusively logs the shell inte=
ractions<br>=C2=A0 =C2=A0* 11. Add dedicated file manager to handle passing=
 files and artifacts between the test engine and nodes in a path agnostic m=
anner<br>=C2=A0 =C2=A0 =C2=A0 * This will be a component of the new DPDK DT=
S API<br>=C2=A0 =C2=A0* 12. Flexible port binding<br>=C2=A0 =C2=A0 =C2=A0 *=
 Give the opportunity to test suites to use all or part of the supplied por=
t topology with the kernel drivers (instead of DPDK). Could be achieved wit=
h a decorator<br>=C2=A0 =C2=A0 =C2=A0 * This will require the Topology clas=
s to be aware of what=E2=80=99s truly available for DPDK and provide only t=
he right ports for it<br>=C2=A0 =C2=A0* 13. Add =C2=A0pseudo-shell which ha=
ndles background services.<br>=C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://pat=
chwork.dpdk.org/project/dpdk/list/?series=3D34865">https://patchwork.dpdk.o=
rg/project/dpdk/list/?series=3D34865</a><br>=C2=A0 =C2=A0* 14. L4 port pack=
et matching: <a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?serie=
s=3D34805">https://patchwork.dpdk.org/project/dpdk/list/?series=3D34805</a>=
<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any o=
ther business<br>* Next Meeting Apr 17, 2025<br><br></div>

--00000000000049828e063231d20c--
