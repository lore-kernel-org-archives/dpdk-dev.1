Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6520C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 23:29:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 220B3402E5;
	Fri, 14 Mar 2025 00:29:59 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3CFA34026B
 for <dev@dpdk.org>; Fri, 14 Mar 2025 00:29:57 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2255003f4c6so28112685ad.0
 for <dev@dpdk.org>; Thu, 13 Mar 2025 16:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741908596; x=1742513396; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xFFtnx9rwHcFuEymntsE+6TUS2INCk16MR/TJg4DIBE=;
 b=ijqQWsffCk4FAy3Slzu4/WcotI73U0v/pfAA3zwkpx11TJQNn/opKSK7HR5fpZsUFR
 Ui4rWxcK53YkppMmCn3EYjPu4v3zPw8Ektj3L/cPdnRCCkZLOuZGiuwq8RDfsXQe9MEh
 9pAjp28OygHU3xyRusbVBxkjKeIwtYJ5i49E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741908596; x=1742513396;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xFFtnx9rwHcFuEymntsE+6TUS2INCk16MR/TJg4DIBE=;
 b=GIo3y0T2rUWuFS9YWtFV0DV81yET0wD9Ek5pvJozCbIZeeiDroD+xo1q8Y9ZRCklXl
 hs8rrpLXGCJVWrqdAaf5o3jLBhiBz/IkCqDu5wGmgUeg7lE+ZrenbP4WhCFzvOrwsxNr
 BnqR50oZxAbKLHZcAHGFw+O0i9ZudJCGp1kYjALPNWZF9vPNdHTAs9ThS0ZGn93ov4se
 eeI4CdItoCGd8J/oV8A9uxFuxYBGcXqnnlCPVh1hg+L/66Y6NkdQ18CcjlSc2WLhugm5
 gcO2EtGH6q+yEgV0LFR1eFsYFyuf9dblH0KZVGI8HsX+dI7FjkkcQHPOKJQ2ZW5Ln6L5
 Eh8w==
X-Gm-Message-State: AOJu0YzVbNTDMe/EuYMWZGcaaemXFF2gmkhx2uKchnBk1fhAH04ukZRV
 8iT4nMr0KQrkesTNrZGuAi2hvW1oezZEgY958qvWviDk1q4IFG9zAfl4KsIGnWEngRm5LhohLb9
 oSwjbo5UC01W4uCHCOXwlwaw0+bE9nXMaYLP8PckgqtHSBv/CUaRAIg==
X-Gm-Gg: ASbGncuVBOwBOH0imB/nuqGpRwQj3JqRNdDJZqV9XC//ViJKSpYulJxYY7+brr25qHp
 0zzqJVeVzXuBlNCvtrZiJ2GSvlgQVYhRcG8ujuirJHe6ghXmozxsgDS4hgsvl5SN9gp6W1bfV9F
 hFJmei61a2FgvrvKUeSYqiGl6P7V7/Kglzmsi/48wQ/1UaG5KKjnTgr8UdiiZi76jNKnsEhg==
X-Google-Smtp-Source: AGHT+IFw6G2Bdn2FFpu9NAe3PFMIq/A9cZiRDnNtZluVFq3eGqPZSuAcMWhv7voMaxWM3FqNee2lrXyoRpJQUzXyN+s=
X-Received: by 2002:a17:903:98b:b0:223:5e6a:57ab with SMTP id
 d9443c01a7336-225e0af040amr5611195ad.39.1741908595621; Thu, 13 Mar 2025
 16:29:55 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 19:26:13 -0400
X-Gm-Features: AQ5f1JoJQ9QQRof2IgHyhefAbK4zFf1pyzsYsAyyTjN64Q4b4NZG91lWl-dJuWM
Message-ID: <CAJvnSUAfEvQp_NxBo9fFE0=0RDR+14UaXUfgC93KN0+dyhkOeQ@mail.gmail.com>
Subject: DTS WG Meeting Minutes - February 27, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000012dfd4063041b38c"
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

--00000000000012dfd4063041b38c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
February 27, 2025
Attendees
* Patrick Robb
* Paul Szczepanek
* Luca Vizzarro
* Ian Stokes

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* RC2 is Feb 28, 2025

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* VF port support: Patrick is trying to refactor this, with these
assumptions
   * 1. Port class gets a new attribute, virtual_functions, which is a list
of VFs (type Port). From looking at a couple VF testsuites we want to
provide, it seems that having the PF -> VF(s) relationship handled in this
way is sufficient.
      * VFs will automatically have the mac attribute assigned
      * Will not have the logical name attribute assigned (does not exist
in linux for VFs)
   * 2. Still unsure of how to handle VF #
      * 2.1 One option is to just check
/sys/class/net/{device_logical_name}/max_vfs and set the maximum number of
VFs possible per physical port at physical port initialization
      *  1.2 Or, set VF as a capability on testsuites or testcases and
reset at runtime.
   * 3. Users will specify whether the testrun is a physical function
testrun or virtual function testrun in the testrun config
   * 4. It may make sense to run PFs and VFs across the same testsuites
instead of splitting a test plan into 2 testsuites (like vf_l2fwd and
pf_l2fwd)
   * 5. Possible footguns: promiscuous mode can behave differently for VFs
vs PFs. VFs may require additional configuration in order to trust traffic
which does not match the VF MAC.
* TREX perf TG support:
   * 1. Users will be expected to create a trex config file, and provide
the path in their config
   * 2. In legacy DTS perf tests started first by launching scapy, and
using wrpcap() to write some pcap files in the DTS dir, which would get
picked up by TREX later. Nick is investigating but soon we will have to
determine whether these pcaps are needed, and if so whether we prefer to
write them to the system at runtime or simply provide them as =E2=80=9Chelp=
er pcap=E2=80=9D
files in the repo.
   * 3. Nick will evaluate trex dpdk_nic_bind.py vs dpdk-devbind.py but
most likely they are the same
* Dean is refactoring some old testsuites:
   * Port stats check: done (Patrick needs to review)
   * rx/tx_offload: nearly done
* Ethertype:
   * VLAN/TPID Filtering testcases for the ethertype testsuite cannot be
run on some devices in the UNH lab due to
https://bugs.dpdk.org/show_bug.cgi?id=3D1464
      * UNH guys will work with the Intel and Broadcom PMD maintainers to
resolve these filtering issues, and then circle back to this testsuite for
25.07
* RSS tests up and ready for review
* Paul proposes renaming context to "DTS" and make it a stable API
   * Rename Context to DTS, pass in as dts argument to test case functions
this contains the tg, sut, logger and other context needed by the testcase
   * Users import DTS (module) and not framework
   * Anything required by test writer is proxied by DTS - this becomes a
stable API we promise to maintain, not affected by framework changes
   * Calls should be intuitive and match hierarchy
      * E.g. self.send_packet() -> dts.tg.send_packet()
      * With TestPmdShell() as testpmdshell: testpmdshell.start() ->
dts.sut.testpmd.start()
      * dts.tg.log(), dts.sut.log()
      * Dts.verify etc. it=E2=80=99s clear you=E2=80=99re making a dts call=
 not call to
your own testsuite class
         * Can use python assert instead of verify
* Per-test-suite configuration
   * Keep configurations of individual test suites in distinct files?
      * Considering a new test_run field to specify a glob-like path
      * E.g. ./tests_config/{test_suite}.yaml
      * Could potentially make it easier if we keep different configs in
the same folder, but different test runs: e.g. func.{test_suite}.yaml,
perf.{test_suite}.yaml
   * Do we provide overrides for individual test suites?

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
* https://bugs.dpdk.org/show_bug.cgi?id=3D1464
   * Dean sees the error message for VLAN assignment in i40e driver from
the verbose logs, and we will forward this along to Intel guys
   * Need to produce verbose logs for Broadcom too
   * Noting that this issue does not exist on Mellanox

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Roadmap status:
https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWt=
xnko/edit?tab=3Dt.0
* Next meeting is Mar 13, 2025

--00000000000012dfd4063041b38c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>February 27, 2025<br>Attendees<br>* Patrick Robb<br>* Paul S=
zczepanek<br>* Luca Vizzarro<br>* Ian Stokes<br><br>#######################=
##############################################<br>Minutes<br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Discussion<br>*=
 RC2 is Feb 28, 2025<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>Patch discussions<br>* VF port support: Patrick is trying t=
o refactor this, with these assumptions<br>=C2=A0 =C2=A0* 1. Port class get=
s a new attribute, virtual_functions, which is a list of VFs (type Port). F=
rom looking at a couple VF testsuites we want to provide, it seems that hav=
ing the PF -&gt; VF(s) relationship handled in this way is sufficient.<br>=
=C2=A0 =C2=A0 =C2=A0 * VFs will automatically have the mac attribute assign=
ed<br>=C2=A0 =C2=A0 =C2=A0 * Will not have the logical name attribute assig=
ned (does not exist in linux for VFs)<br>=C2=A0 =C2=A0* 2. Still unsure of =
how to handle VF #<br>=C2=A0 =C2=A0 =C2=A0 * 2.1 One option is to just chec=
k /sys/class/net/{device_logical_name}/max_vfs and set the maximum number o=
f VFs possible per physical port at physical port initialization<br>=C2=A0 =
=C2=A0 =C2=A0 * =C2=A01.2 Or, set VF as a capability on testsuites or testc=
ases and reset at runtime.<br>=C2=A0 =C2=A0* 3. Users will specify whether =
the testrun is a physical function testrun or virtual function testrun in t=
he testrun config<br>=C2=A0 =C2=A0* 4. It may make sense to run PFs and VFs=
 across the same testsuites instead of splitting a test plan into 2 testsui=
tes (like vf_l2fwd and pf_l2fwd)<br>=C2=A0 =C2=A0* 5. Possible footguns: pr=
omiscuous mode can behave differently for VFs vs PFs. VFs may require addit=
ional configuration in order to trust traffic which does not match the VF M=
AC.<br>* TREX perf TG support:<br>=C2=A0 =C2=A0* 1. Users will be expected =
to create a trex config file, and provide the path in their config<br>=C2=
=A0 =C2=A0* 2. In legacy DTS perf tests started first by launching scapy, a=
nd using wrpcap() to write some pcap files in the DTS dir, which would get =
picked up by TREX later. Nick is investigating but soon we will have to det=
ermine whether these pcaps are needed, and if so whether we prefer to write=
 them to the system at runtime or simply provide them as =E2=80=9Chelper pc=
ap=E2=80=9D files in the repo.<br>=C2=A0 =C2=A0* 3. Nick will evaluate trex=
 dpdk_nic_bind.py vs dpdk-devbind.py but most likely they are the same<br>*=
 Dean is refactoring some old testsuites:<br>=C2=A0 =C2=A0* Port stats chec=
k: done (Patrick needs to review)<br>=C2=A0 =C2=A0* rx/tx_offload: nearly d=
one<br>* Ethertype:<br>=C2=A0 =C2=A0* VLAN/TPID Filtering testcases for the=
 ethertype testsuite cannot be run on some devices in the UNH lab due to <a=
 href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1464">https://bugs.dpdk.or=
g/show_bug.cgi?id=3D1464</a><br>=C2=A0 =C2=A0 =C2=A0 * UNH guys will work w=
ith the Intel and Broadcom PMD maintainers to resolve these filtering issue=
s, and then circle back to this testsuite for 25.07<br>* RSS tests up and r=
eady for review<br>* Paul proposes renaming context to &quot;DTS&quot; and =
make it a stable API<br>=C2=A0 =C2=A0* Rename Context to DTS, pass in as dt=
s argument to test case functions this contains the tg, sut, logger and oth=
er context needed by the testcase<br>=C2=A0 =C2=A0* Users import DTS (modul=
e) and not framework<br>=C2=A0 =C2=A0* Anything required by test writer is =
proxied by DTS - this becomes a stable API we promise to maintain, not affe=
cted by framework changes<br>=C2=A0 =C2=A0* Calls should be intuitive and m=
atch hierarchy<br>=C2=A0 =C2=A0 =C2=A0 * E.g. self.send_packet() -&gt; dts.=
tg.send_packet()<br>=C2=A0 =C2=A0 =C2=A0 * With TestPmdShell() as testpmdsh=
ell: testpmdshell.start() -&gt; dts.sut.testpmd.start()<br>=C2=A0 =C2=A0 =
=C2=A0 * dts.tg.log(), dts.sut.log()<br>=C2=A0 =C2=A0 =C2=A0 * Dts.verify e=
tc. it=E2=80=99s clear you=E2=80=99re making a dts call not call to your ow=
n testsuite class<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Can use python ass=
ert instead of verify<br>* Per-test-suite configuration<br>=C2=A0 =C2=A0* K=
eep configurations of individual test suites in distinct files?<br>=C2=A0 =
=C2=A0 =C2=A0 * Considering a new test_run field to specify a glob-like pat=
h<br>=C2=A0 =C2=A0 =C2=A0 * E.g. ./tests_config/{test_suite}.yaml<br>=C2=A0=
 =C2=A0 =C2=A0 * Could potentially make it easier if we keep different conf=
igs in the same folder, but different test runs: e.g. func.{test_suite}.yam=
l, perf.{test_suite}.yaml<br>=C2=A0 =C2=A0* Do we provide overrides for ind=
ividual test suites?<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>Bugzilla discussions<br>* <a href=3D"https://bugs.dpdk.org/=
show_bug.cgi?id=3D1464">https://bugs.dpdk.org/show_bug.cgi?id=3D1464</a><br=
>=C2=A0 =C2=A0* Dean sees the error message for VLAN assignment in i40e dri=
ver from the verbose logs, and we will forward this along to Intel guys<br>=
=C2=A0 =C2=A0* Need to produce verbose logs for Broadcom too<br>=C2=A0 =C2=
=A0* Noting that this issue does not exist on Mellanox<br><br>=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Ro=
admap status: <a href=3D"https://docs.google.com/document/d/1doTZOOpkv4D5P2=
w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=3Dt.0">https://docs.google.com/docum=
ent/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=3Dt.0</a><br>* =
Next meeting is Mar 13, 2025</div>

--00000000000012dfd4063041b38c--
