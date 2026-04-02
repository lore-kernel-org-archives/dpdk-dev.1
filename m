Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F4BD6AAFD
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 19:15:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A050040E24;
	Thu,  2 Apr 2026 21:15:40 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 4FEBE4027A
 for <dev@dpdk.org>; Thu,  2 Apr 2026 21:15:39 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1274204434bso2051530c88.1
 for <dev@dpdk.org>; Thu, 02 Apr 2026 12:15:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775157338; cv=none;
 d=google.com; s=arc-20240605;
 b=Z6f1vCUepGkFfhmrLxhsT9NGuUN/TooDEDEVqvtFSr+o63fEGH3k3GottriR78+RNk
 poIt5lFawxBUvKXROlOiHlAVsn4ioBRP93w91r0KXOQdCy2OnrxGXmnjglPFy5z+a8MD
 t5Wq9fAG9UWk7O3bB6cBI2DOHzHcDtZPo1ekGcN9U/97Eo0TniJk5DZ3aW7gFdnOdmrl
 w95NuIOklYINhODs8+jCHacSDoVO+K9HxPFDe9z6FUDmEg7V3RclVTDWiUprWKn/JSgg
 TvyzfVzNK1sopu3vJV0rENa6JznpdPjZQF3mClxzwtBwL2yOIybmswC1kNagfQ+dFG+W
 QLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=soy+sxgHgOeDJzj/8yeQauGAxFn3Fz+a+gO5JTieh6E=;
 fh=X/Yh7i/4mFvWnIwFObODSI+4JzdHZxfp7u7nFf6L14w=;
 b=aUTGQFMoqpUQRTai/RH1eUDPeq1fBo+EigMY3o0wOA/PEeCy4crCwjU5/ANPYYntFU
 0SEUuv7w1lqRggrJ2dMXVKdHtLKIT2avB0l9Y5tWuzgQuw27c1WnsDSyPPX3vTCD7jg/
 HQOCiyTG4zHGEQX+ggv+//hO96cU+956T6C2ElcnYnlQahCBlQjVyqPZgd5vBRT20d+/
 MepNCZ0yWO2E0HGCSt/Z+089GSZkzJ8GE68nzvNAkq+/oMiddHdXouSNff9pEPam5AAE
 tSd4mOy7Mr40IEASev+kpPph4af7k07N2aDi6QgRkDGfEHgtyHynTJShftHDBwCLJXzT
 j+uQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775157338; x=1775762138; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=soy+sxgHgOeDJzj/8yeQauGAxFn3Fz+a+gO5JTieh6E=;
 b=KR1bnzC69byUOMTYiBY7ylZNSSbEqETfugEu8XqsaONGp3y9ol6jIewQbx4BiyzYxF
 rcdoFOgxIeB8y06kNQ/fCfGvLnyBW3C5OMIgJijV+zN4i8lA265H0bBmukStfkapuvF5
 uUeQqeIJS9eWJB8Avn/aWkpTOiqCeqR/djXak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775157338; x=1775762138;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=soy+sxgHgOeDJzj/8yeQauGAxFn3Fz+a+gO5JTieh6E=;
 b=LjUSOW5M+zotR7Hx5c8Z2VoCbIFVYdqEFsdYGzegqimO5n4f41WeS1eTJeix6rpshJ
 0b5pqHNxzGhKqhGS1lyXq13GhAVkVpfhPWEDfpj7DhMIWEe5l51MtVoHffxkZe0n9rA9
 i8qrv4FZ4Si0sJc2kfqLPsRCPi1nPe1Rrt+hgsMu8tlBuObHpZXd62271VQnVucVr6ts
 C8kqLHFJgXtblkJZEaovBwh5sI0C7VJWgSnR/ULZR7ERqNFP2W6KwYdm7RPHXA04H112
 TAs/4H9tvgbDIxmhjE4nH8WH3dIbhYMYfTK5lDIU6N2FErecibeiXq+sucAtIXpOIaox
 PXvw==
X-Gm-Message-State: AOJu0Yw093mhZNh2Dpv7xtC0qRIJrwpnO9sxLlViwA9K4eFvkLdLSRUw
 lFEGfeCTn1MpIsnIC/Ow6IqvpQ8wHXlIWQFod3j1C3fJpt9M3h08hyqsXy7lZU5CxNO681gOvMB
 Hshx0TMLfq782G/aSYL0Unz3Xl3N3buQKD7XkHz51VmwRFwjY+e0VH3cLEg==
X-Gm-Gg: ATEYQzxgyVtrqPRwwIXeXkwF8Ybr8VUGXEd8khm/alDryTWyV4nEf2IRQ+GC7egvPFZ
 6FQkjG83VDnDbU36w6e14EhHthOVaWnnqFXSUjzHL8HkSSTI12SEWqGgFiYXm8vgcoRsTCCqabm
 6VQBPwK+MsOhs+3Hm+zv5ao8sYHxAvJ80ZZdp9wI+7RjQyz+gl3EqQYjXjtJ8xe6HUOZ4WwB5u6
 TBfK3EDRPZhSMvqDuIdeALQSDJGcaP+LOnj2ibH9AC9Pica1F2TBU2aoiE1TEGsxyuIk3H7+IiV
 RR9totxd7mA7bIwyfXmYYYeM9esJFSg1095VIGqsrbM6b0GzrenGtA==
X-Received: by 2002:a05:7022:f8f:b0:129:1d25:f1da with SMTP id
 a92af1059eb24-12bf059a670mr1527101c88.3.1775157337774; Thu, 02 Apr 2026
 12:15:37 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 2 Apr 2026 15:12:10 -0400
X-Gm-Features: AQROBzCrocg6pxrl4rI8pPPPZFfvgq-5mxKSyVY_p2FE9uJt0LVH9DV87tSvKOU
Message-ID: <CAJvnSUDPfBayb2BU2dYV9bk5VGe9sot3htiXXu1mBNCm8-EygQ@mail.gmail.com>
Subject: DTS WG Meeting Minutes - March 26, 2026
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org, Adam Hassick <ahassick@iol.unh.edu>, 
 Lincoln Lavoie <lylavoie@iol.unh.edu>, Luca Vizzarro <Luca.Vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="00000000000089ed65064e7f06e2"
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

--00000000000089ed65064e7f06e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

March 26, 2026
Attendees
* Patrick Robb
* Luca Vizzarro
* Adam Hassick
* Manjunatha
* Paul Szczepanek
Minutes
General Discussion
* RC3 has been released
   * Next-dts patches were pulled in for RC3
   * Plan is for no DTS patches to go into RC4
* Patrick will be resigning from his position at UNH-IOL on April 2, and
starting a (non-DPDK) role at AMD
   * Patrick will email the =E2=80=9Cbroader DPDK community=E2=80=9D sharin=
g this news today
   * Lincoln Lavoie will chair the DTS and DPDK CI meetings for the medium
   * Patrick is interested in staying on as DTS maintainer in his personal
capacity
      * Should still be able to do:
         * Code review
         * Submit some patches
         * Test patches on hardware (I can use the UNH hardware over
VPN/SSH, just like all other members of the DPDK community)
         * Work on DTS roadmaps for each DPDK release
      * Probably will not be able to join DTS/CI meetings in the future
   * Patrick will still travel to DPDK Stockholm to give his scheduled DTS
presentation
   * DTS staffing will not be affected by this change - we will still have
2 students allocated towards DTS development
      * Currently we actually have 3, as we have a new student (Koushik)
who is onboarding to DTS.
* Manju is going to setup DTS on one of his DPDK systems in the coming
weeks/months and if he has any issues the students at UNH can help
* Reminder: now that our patches for better supporting 1 link testing are
merged, UNH should run testbeds of at least 1 of each =E2=80=9Ctopology=E2=
=80=9D type
Patch discussions
* Merged Patches:
   * Cryptodev testsuite
      * Merged
   * Packet Sniffing
      * Merged a patch that forces the sniffer to only sniff incoming
packets
      * We used to have this but lost it in the most recent DTS sniffer
rework. This was noticed when we were further testing the single link
   * One link default topology:
      * Merged
   * Add missing crypto driver:
      *
https://patchwork.dpdk.org/project/dpdk/patch/20260319145525.294352-1-abail=
ey@iol.unh.edu/
      * Merged
   * Update PASS/SKIP logic
      *
https://patchwork.dpdk.org/project/dpdk/patch/20260320182126.35724-1-dmarx@=
iol.unh.edu/
      * Merged
   * Test suite filtering (filter out testsuites which have had all of
their testcases filtered out by capabilities or config)
      *
https://patchwork.dpdk.org/project/dpdk/patch/20260320210216.259728-1-probb=
@iol.unh.edu/
      * Merged
   * DPDK shell fixes (fixed some issues introduced or raised by adding the
cryptodev shell)
      * https://patchwork.dpdk.org/project/dpdk/list/?series=3D37730&state=
=3D*
      * Merged
* Port speed capabilities:
   * 100% ready, so will merge this early in the next DPDK release (26.07)
   *
https://patchwork.dpdk.org/project/dpdk/patch/20260309202928.200755-1-abail=
ey@iol.unh.edu/
* Re-naming testsuites:
   * Has a doc failure from the Intel CI Lab
   *
https://patchwork.dpdk.org/project/dpdk/patch/20260202170924.398261-1-abail=
ey@iol.unh.edu/
* PVVP Virtio testcase:
   * 100% ready, but need to communicate this is going to be merged to the
virtio maintainer, and then do so
   *
https://patchwork.dpdk.org/project/dpdk/patch/20251217195155.32350-1-dmarx@=
iol.unh.edu/
* Support for no_link topology:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20260224163200.39360-1-abaile=
y@iol.unh.edu/
   * Fixes a couple bugs associated with running DTS in =E2=80=9Cno link=E2=
=80=9D mode
      * This is relevant for the first time, as cryptodev_throughput is our
first actual no_link test (actually a 1 link test right now by necessity)
* Flow offload:
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D37646
   * Adds support for validating VXLAN packet flow rules
Bugzilla discussions
* Andrew continues to do a great job keeping tabs on the tickets and making
updates
Any other business
* 26.07 roadmap: Patrick to work on this tomorrow and share the draft
roadmap out to the DTS group, then we will finalize next Thursday at the CI
meeting.
* Next meeting is Apr 9, 2026

--00000000000089ed65064e7f06e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>March 26, 2026<br>Attendees<br>* Patrick Robb<br>* Luc=
a Vizzarro<br>* Adam Hassick<br>* Manjunatha<br>* Paul Szczepanek<br>Minute=
s<br>General Discussion<br>* RC3 has been released<br>=C2=A0 =C2=A0* Next-d=
ts patches were pulled in for RC3<br>=C2=A0 =C2=A0* Plan is for no DTS patc=
hes to go into RC4<br>* Patrick will be resigning from his position at UNH-=
IOL on April 2, and starting a (non-DPDK) role at AMD<br>=C2=A0 =C2=A0* Pat=
rick will email the =E2=80=9Cbroader DPDK community=E2=80=9D sharing this n=
ews today<br>=C2=A0 =C2=A0* Lincoln Lavoie will chair the DTS and DPDK CI m=
eetings for the medium<br>=C2=A0 =C2=A0* Patrick is interested in staying o=
n as DTS maintainer in his personal capacity<br>=C2=A0 =C2=A0 =C2=A0 * Shou=
ld still be able to do:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Code review<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Submit some patches<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0* Test patches on hardware (I can use the UNH hardware=
 over VPN/SSH, just like all other members of the DPDK community)<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Work on DTS roadmaps for each DPDK release<br=
>=C2=A0 =C2=A0 =C2=A0 * Probably will not be able to join DTS/CI meetings i=
n the future<br>=C2=A0 =C2=A0* Patrick will still travel to DPDK Stockholm =
to give his scheduled DTS presentation<br>=C2=A0 =C2=A0* DTS staffing will =
not be affected by this change - we will still have 2 students allocated to=
wards DTS development<br>=C2=A0 =C2=A0 =C2=A0 * Currently we actually have =
3, as we have a new student (Koushik) who is onboarding to DTS. <br>* Manju=
 is going to setup DTS on one of his DPDK systems in the coming weeks/month=
s and if he has any issues the students at UNH can help<br>* Reminder: now =
that our patches for better supporting 1 link testing are merged, UNH shoul=
d run testbeds of at least 1 of each =E2=80=9Ctopology=E2=80=9D type<br>Pat=
ch discussions<br>* Merged Patches:<br>=C2=A0 =C2=A0* Cryptodev testsuite<b=
r>=C2=A0 =C2=A0 =C2=A0 * Merged<br>=C2=A0 =C2=A0* Packet Sniffing<br>=C2=A0=
 =C2=A0 =C2=A0 * Merged a patch that forces the sniffer to only sniff incom=
ing packets<br>=C2=A0 =C2=A0 =C2=A0 * We used to have this but lost it in t=
he most recent DTS sniffer rework. This was noticed when we were further te=
sting the single link<br>=C2=A0 =C2=A0* One link default topology:<br>=C2=
=A0 =C2=A0 =C2=A0 * Merged<br>=C2=A0 =C2=A0* Add missing crypto driver:<br>=
=C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://patchwork.dpdk.org/project/dpdk/p=
atch/20260319145525.294352-1-abailey@iol.unh.edu/">https://patchwork.dpdk.o=
rg/project/dpdk/patch/20260319145525.294352-1-abailey@iol.unh.edu/</a><br>=
=C2=A0 =C2=A0 =C2=A0 * Merged<br>=C2=A0 =C2=A0* Update PASS/SKIP logic<br>=
=C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://patchwork.dpdk.org/project/dpdk/p=
atch/20260320182126.35724-1-dmarx@iol.unh.edu/">https://patchwork.dpdk.org/=
project/dpdk/patch/20260320182126.35724-1-dmarx@iol.unh.edu/</a><br>=C2=A0 =
=C2=A0 =C2=A0 * Merged<br>=C2=A0 =C2=A0* Test suite filtering (filter out t=
estsuites which have had all of their testcases filtered out by capabilitie=
s or config)<br>=C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://patchwork.dpdk.or=
g/project/dpdk/patch/20260320210216.259728-1-probb@iol.unh.edu/">https://pa=
tchwork.dpdk.org/project/dpdk/patch/20260320210216.259728-1-probb@iol.unh.e=
du/</a><br>=C2=A0 =C2=A0 =C2=A0 * Merged<br>=C2=A0 =C2=A0* DPDK shell fixes=
 (fixed some issues introduced or raised by adding the cryptodev shell)<br>=
=C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://patchwork.dpdk.org/project/dpdk/l=
ist/?series=3D37730&amp;state=3D*">https://patchwork.dpdk.org/project/dpdk/=
list/?series=3D37730&amp;state=3D*</a><br>=C2=A0 =C2=A0 =C2=A0 * Merged<br>=
* Port speed capabilities:<br>=C2=A0 =C2=A0* 100% ready, so will merge this=
 early in the next DPDK release (26.07)<br>=C2=A0 =C2=A0* <a href=3D"https:=
//patchwork.dpdk.org/project/dpdk/patch/20260309202928.200755-1-abailey@iol=
.unh.edu/">https://patchwork.dpdk.org/project/dpdk/patch/20260309202928.200=
755-1-abailey@iol.unh.edu/</a><br>* Re-naming testsuites:<br>=C2=A0 =C2=A0*=
 Has a doc failure from the Intel CI Lab<br>=C2=A0 =C2=A0* <a href=3D"https=
://patchwork.dpdk.org/project/dpdk/patch/20260202170924.398261-1-abailey@io=
l.unh.edu/">https://patchwork.dpdk.org/project/dpdk/patch/20260202170924.39=
8261-1-abailey@iol.unh.edu/</a><br>* PVVP Virtio testcase:<br>=C2=A0 =C2=A0=
* 100% ready, but need to communicate this is going to be merged to the vir=
tio maintainer, and then do so<br>=C2=A0 =C2=A0* <a href=3D"https://patchwo=
rk.dpdk.org/project/dpdk/patch/20251217195155.32350-1-dmarx@iol.unh.edu/">h=
ttps://patchwork.dpdk.org/project/dpdk/patch/20251217195155.32350-1-dmarx@i=
ol.unh.edu/</a><br>* Support for no_link topology:<br>=C2=A0 =C2=A0* <a hre=
f=3D"https://patchwork.dpdk.org/project/dpdk/patch/20260224163200.39360-1-a=
bailey@iol.unh.edu/">https://patchwork.dpdk.org/project/dpdk/patch/20260224=
163200.39360-1-abailey@iol.unh.edu/</a><br>=C2=A0 =C2=A0* Fixes a couple bu=
gs associated with running DTS in =E2=80=9Cno link=E2=80=9D mode<br>=C2=A0 =
=C2=A0 =C2=A0 * This is relevant for the first time, as cryptodev_throughpu=
t is our first actual no_link test (actually a 1 link test right now by nec=
essity)<br>* Flow offload:<br>=C2=A0 =C2=A0* <a href=3D"https://patchwork.d=
pdk.org/project/dpdk/list/?series=3D37646">https://patchwork.dpdk.org/proje=
ct/dpdk/list/?series=3D37646</a><br>=C2=A0 =C2=A0* Adds support for validat=
ing VXLAN packet flow rules<br>Bugzilla discussions<br>* Andrew continues t=
o do a great job keeping tabs on the tickets and making updates<br>Any othe=
r business<br>* 26.07 roadmap: Patrick to work on this tomorrow and share t=
he draft roadmap out to the DTS group, then we will finalize next Thursday =
at the CI meeting.<br>* Next meeting is Apr 9, 2026<br></div>

--00000000000089ed65064e7f06e2--
