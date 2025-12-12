Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837A3D59D8E
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 19:56:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4786740651;
	Fri, 12 Dec 2025 20:56:05 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 070B74027D
 for <dev@dpdk.org>; Fri, 12 Dec 2025 20:56:04 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2956d816c10so19190905ad.1
 for <dev@dpdk.org>; Fri, 12 Dec 2025 11:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765569363; x=1766174163; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nHTDIa3J2LoRx/EUx6jocI7XdEUZ0UDcca+fIbPi/+E=;
 b=fgsK+pADWP011vHxHoXly4EQXCIGe5zK81c9hyokyCyYVh4kdLTn+QIWEIqQ1HKVWZ
 uYHqWVTC0I8w/ZD6Kq1s61e37XSfopSlmM3aHS/SkiigvMnNFd9wqETEXysmGEfzMtS4
 ENxeDncwVmog9bsjD5QSi7AmAc+sAqgE5UwGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765569363; x=1766174163;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nHTDIa3J2LoRx/EUx6jocI7XdEUZ0UDcca+fIbPi/+E=;
 b=SUCYoun0KRuPTGUq9grxluRVXf5Bb/G3tM/9T3N5x7twiYNq4r3kfuqSNXi0T+1pbW
 /5u8YGuYgOua444qVbsHyaWwUAIYMb27Zae4tL+euYoYy478yRTWLD8D3Tsxuw6A2df/
 mIo5bcf2phuMu3B/n+gfixAHI5BJ8lYz9OeFvOQcHS+cqCZ7sCqXuxg8RjGkRht5mep6
 22GNEdV8tFAu0hh559Y2ofudzLVNf3XWWDaW+HA6b8xbEfjMVENmypdT9eeHYNABF6HL
 ZwQsRjlxu+ahMfO9wbChm7SvFBMb+8ArORCeOfgmPuKN1doS13ij3O/8moFVpdsfvLOn
 bwJQ==
X-Gm-Message-State: AOJu0YzMjja16w8RPP1lLmrHzHnWyp0F0fXsm/jwVqsMklYUIjioG0Qz
 fuwZGodc6uU3Vs3Bpgqr0OgM1IsvRA4NQOUBW5v7cyZjVSL7A/gPb+ziN3HWtgdhqIUld6BFh7S
 QszS58WCBdcxhEJZRD9siSqZ3ij2PBgnltOLZsAyVF1Tc1j0iVRTBje8EXw==
X-Gm-Gg: AY/fxX5PME3T2hgTBm/pvuYgE6cwrV1fRU7FRcvyodro/ypCbiUmfGxXMDPwsI0kvzB
 dF1eZYQbqO/2qo1mW1Nfm6Bc2ykiK5SiaFxcejKKt6eAnVMSCHXrjMHwYOJSClaT3GRc8OxHcki
 xoWNghV24DIWRUE+l0z8LvaAHssY/2Az/o5ox4ZnPliNfnuGNXd5nYAN2AKWKrMkxPFFEmeGcNy
 cl+JjpfOj6lCKhe6DIogV3wJ6gIIkPbG7STxj5pV29vcRJX+lcdoNfmdUbRApZ8oBEd/G6qyeIs
 6x53sroqrmL9QmotbArNrYOfyjxr
X-Google-Smtp-Source: AGHT+IG+Sg0U+sDbaf1BfkGXjMrqvm44l5XrlZjQfZGjgtPHnfgQn7V7tQhjK4VjnEmBb1f58Ikyk1Mrfyvn1rQOqdg=
X-Received: by 2002:a05:7022:ea54:b0:119:e56c:18a8 with SMTP id
 a92af1059eb24-11f34bc6f6dmr1598168c88.16.1765569362611; Fri, 12 Dec 2025
 11:56:02 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 12 Dec 2025 14:54:20 -0500
X-Gm-Features: AQt7F2rBAgQtasgplyJUqb76o3AL4dJpDbSO-foi2uqlqKbC2vkY1kiNvWuyMfw
Message-ID: <CAJvnSUDz1j7H4hgYFHtwTpR593N8=O48_NHi+isKvDK4jSc6ng@mail.gmail.com>
Subject: DTS WG Meeting Minutes - December 4, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000af61df0645c6a63f"
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

--000000000000af61df0645c6a63f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

December 4, 2025

Attendees
* Patrick Robb
* Andrew Bailey
* Paul Szczepanek
* Luca Vizzarro

Minutes

General Discussion
* DPDK 25.11 has been released
   * UNH can now begin using the new single_core_foreward test in its CI
testing
   * Patrick to rebase on main, push to for-main
* John McNamera
   * Asking about running testing for the flow rules offload
   * UNH should run the flow suite, share the results back to PMD
maintainers
      * Dean can do this

Patch discussions
* add test case docstring checks to format script
   * Patrick can merge
* Automate loading vfio-pci module:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20251126141650.367633-1-abail=
ey@iol.unh.edu/
   * Patrick to review
* Change default topology to one link:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20251121195511.322005-2-abail=
ey@iol.unh.edu/
   * Andrew has resolved the build error by updating a type hint
   * Patrick to do a review
   * Luca to review as well, and check the function decorator signature
* Extending Flow Offload Testing:
   * For the extended flow offload testing, we are categorizing network
protocols by OSI layer (l2, l3, l4), and their various valid field values
(i.e. IP src, IP dst, etc.) and creating flow rules based on all possible
combinations of these. Then, a helper method parses the flow rule and
creates a scapy packet based on it, which we then transmit from the TG to
the SUT in order to validate the flow rule.
* Virtio testing for 26.03:
   * 1. Add a PvvP test, which will work just like the existing PvP test
(based on the virtio exception path example on the DPDK docs) except that
it will have two vhost backend instances.
      * So, the port order will be set to 1 (virtio), 3 (vhost loopback), 4
(vhost loopback), 2 (virtio)
   *  2. Otherwise, we need to ask Maxime what coverage he would like to se=
e
* Cryptodev:
   * Now using dpdkruntimeenvironment to run the cryptodev application with
.run_dpdk_app()
   * Making param enums for the application, just like the testpmd approach
   * Able to form the EAL and app arguments now, and run the
dpdk-crypto-perf application via DTS
      * Having a few more issues with a couple remaining arguments
      * Then, Andrew will set up usage of the textparser for processing the
output of the dpdk-crypto-perf application
   * DTS should automate the creation of the virtual functions on the
crypto device
      * Can read the max_vfs file for the correct number of vfs to make per
PF, and then write that number to sriov_numvfs

Bugzilla discussions
* Andrew and Patrick pruned the tickets

Any other business
* Roadmap discussion (WIP):
   * DTS API
      * Remove all existing framework imports and replace with imports from
the DTS API
      * https://bugs.dpdk.org/show_bug.cgi?id=3D1788
   * Cryptodev testing
      * Adding a new cryptodev package to the DTS API for handling
dpdk-crypto-perf app arguments
      * (testsuites) : Encrypt/decrypt workloads with the various supported
algorithms on DPDK NICs.
   * Supporting DTS testruns on 1 physical host:
      * Ensure the documentation for testing on a single host with a single
NIC is up to date
      * Framework updates
   * Virtio testing support:
      * Enable additional testing topologies and scenarios (i.e. adding a
PvvP test which is structured similar to the existing PvP test)
   * Flow Offload Testsuites:
      * Add a new testsuite which categorizes network protocols and their
respective valid field values by OSI layer, and creates all unique
combinations of these as flow rules. This should create =E2=80=9Ccomprehens=
ive=E2=80=9D
coverage of flow rules where previously we just had the minimal set of flow
offload rules tested.
      * Asynchronous API testing
         * (question) is this the same functionality as the synchronous
API, or a subset?
   * Additional functional ethdev testsuites:
      * Ethertype Testsuite
      * QinQ testing: Extend this testsuite to validate that IDs are being
stored in the correct TCI / OUTER_TCI via testpmd verbose logs
   * Update testsuite names for clarity:
      * https://bugs.dpdk.org/show_bug.cgi?id=3D1826
* Next meeting is Dec 18, 2025

--000000000000af61df0645c6a63f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">December 4, 2025<br><br>Attendees<br>* Patrick Robb<br>* A=
ndrew Bailey<br>* Paul Szczepanek<br>* Luca Vizzarro<br><br>Minutes<br><br>=
General Discussion<br>* DPDK 25.11 has been released<br>=C2=A0 =C2=A0* UNH =
can now begin using the new single_core_foreward test in its CI testing<br>=
=C2=A0 =C2=A0* Patrick to rebase on main, push to for-main<br>* John McName=
ra <br>=C2=A0 =C2=A0* Asking about running testing for the flow rules offlo=
ad<br>=C2=A0 =C2=A0* UNH should run the flow suite, share the results back =
to PMD maintainers<br>=C2=A0 =C2=A0 =C2=A0 * Dean can do this<br><br>Patch =
discussions<br>* add test case docstring checks to format script<br>=C2=A0 =
=C2=A0* Patrick can merge<br>* Automate loading vfio-pci module:<br>=C2=A0 =
=C2=A0* <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/2025112614=
1650.367633-1-abailey@iol.unh.edu/">https://patchwork.dpdk.org/project/dpdk=
/patch/20251126141650.367633-1-abailey@iol.unh.edu/</a><br>=C2=A0 =C2=A0* P=
atrick to review<br>* Change default topology to one link:<br>=C2=A0 =C2=A0=
* <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/20251121195511.3=
22005-2-abailey@iol.unh.edu/">https://patchwork.dpdk.org/project/dpdk/patch=
/20251121195511.322005-2-abailey@iol.unh.edu/</a><br>=C2=A0 =C2=A0* Andrew =
has resolved the build error by updating a type hint<br>=C2=A0 =C2=A0* Patr=
ick to do a review<br>=C2=A0 =C2=A0* Luca to review as well, and check the =
function decorator signature<br>* Extending Flow Offload Testing:<br>=C2=A0=
 =C2=A0* For the extended flow offload testing, we are categorizing network=
 protocols by OSI layer (l2, l3, l4), and their various valid field values =
(i.e. IP src, IP dst, etc.) and creating flow rules based on all possible c=
ombinations of these. Then, a helper method parses the flow rule and create=
s a scapy packet based on it, which we then transmit from the TG to the SUT=
 in order to validate the flow rule.<br>* Virtio testing for 26.03:<br>=C2=
=A0 =C2=A0* 1. Add a PvvP test, which will work just like the existing PvP =
test (based on the virtio exception path example on the DPDK docs) except t=
hat it will have two vhost backend instances. <br>=C2=A0 =C2=A0 =C2=A0 * So=
, the port order will be set to 1 (virtio), 3 (vhost loopback), 4 (vhost lo=
opback), 2 (virtio)<br>=C2=A0 =C2=A0* =C2=A02. Otherwise, we need to ask Ma=
xime what coverage he would like to see<br>* Cryptodev: <br>=C2=A0 =C2=A0* =
Now using dpdkruntimeenvironment to run the cryptodev application with .run=
_dpdk_app()<br>=C2=A0 =C2=A0* Making param enums for the application, just =
like the testpmd approach<br>=C2=A0 =C2=A0* Able to form the EAL and app ar=
guments now, and run the dpdk-crypto-perf application via DTS<br>=C2=A0 =C2=
=A0 =C2=A0 * Having a few more issues with a couple remaining arguments<br>=
=C2=A0 =C2=A0 =C2=A0 * Then, Andrew will set up usage of the textparser for=
 processing the output of the dpdk-crypto-perf application<br>=C2=A0 =C2=A0=
* DTS should automate the creation of the virtual functions on the crypto d=
evice<br>=C2=A0 =C2=A0 =C2=A0 * Can read the max_vfs file for the correct n=
umber of vfs to make per PF, and then write that number to sriov_numvfs<br>=
<br>Bugzilla discussions<br>* Andrew and Patrick pruned the tickets<br><br>=
Any other business<br>* Roadmap discussion (WIP):<br>=C2=A0 =C2=A0* DTS API=
<br>=C2=A0 =C2=A0 =C2=A0 * Remove all existing framework imports and replac=
e with imports from the DTS API<br>=C2=A0 =C2=A0 =C2=A0 * <a href=3D"https:=
//bugs.dpdk.org/show_bug.cgi?id=3D1788">https://bugs.dpdk.org/show_bug.cgi?=
id=3D1788</a><br>=C2=A0 =C2=A0* Cryptodev testing<br>=C2=A0 =C2=A0 =C2=A0 *=
 Adding a new cryptodev package to the DTS API for handling dpdk-crypto-per=
f app arguments<br>=C2=A0 =C2=A0 =C2=A0 * (testsuites) : Encrypt/decrypt wo=
rkloads with the various supported algorithms on DPDK NICs.<br>=C2=A0 =C2=
=A0* Supporting DTS testruns on 1 physical host:<br>=C2=A0 =C2=A0 =C2=A0 * =
Ensure the documentation for testing on a single host with a single NIC is =
up to date<br>=C2=A0 =C2=A0 =C2=A0 * Framework updates<br>=C2=A0 =C2=A0* Vi=
rtio testing support:<br>=C2=A0 =C2=A0 =C2=A0 * Enable additional testing t=
opologies and scenarios (i.e. adding a PvvP test which is structured simila=
r to the existing PvP test)<br>=C2=A0 =C2=A0* Flow Offload Testsuites:<br>=
=C2=A0 =C2=A0 =C2=A0 * Add a new testsuite which categorizes network protoc=
ols and their respective valid field values by OSI layer, and creates all u=
nique combinations of these as flow rules. This should create =E2=80=9Ccomp=
rehensive=E2=80=9D coverage of flow rules where previously we just had the =
minimal set of flow offload rules tested.<br>=C2=A0 =C2=A0 =C2=A0 * Asynchr=
onous API testing<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (question) is this=
 the same functionality as the synchronous API, or a subset?<br>=C2=A0 =C2=
=A0* Additional functional ethdev testsuites:<br>=C2=A0 =C2=A0 =C2=A0 * Eth=
ertype Testsuite<br>=C2=A0 =C2=A0 =C2=A0 * QinQ testing: Extend this testsu=
ite to validate that IDs are being stored in the correct TCI / OUTER_TCI vi=
a testpmd verbose logs<br>=C2=A0 =C2=A0* Update testsuite names for clarity=
:<br>=C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://bugs.dpdk.org/show_bug.cgi?i=
d=3D1826">https://bugs.dpdk.org/show_bug.cgi?id=3D1826</a><br>* Next meetin=
g is Dec 18, 2025<br></div>

--000000000000af61df0645c6a63f--
