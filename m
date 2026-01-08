Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD160D232C3
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 22:43:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84F3F40661;
	Thu,  8 Jan 2026 23:43:23 +0100 (CET)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 03EE2402DE
 for <dev@dpdk.org>; Thu,  8 Jan 2026 23:43:22 +0100 (CET)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-121b14efeb8so1146993c88.1
 for <dev@dpdk.org>; Thu, 08 Jan 2026 14:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1767912201; x=1768517001; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=efw446mrmvehY30TCSNsQ+ZYixEigKGDd1rX3LRpyCs=;
 b=E4FB7FwomxB0KqW7WMyYf1isGxHlmCjUiFYd8DcM0SvZi3sJdCfVtnbJfISe+INbAz
 oS8XeTvPECDofBiErcaSeskWMRNX4KB8U9pmkuJY8POaus4li5FDL1s/iNxL4ZVp64CJ
 9x0hLvFqt5s8VvMC2aURhPsTld+mmMxIWqZ9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767912201; x=1768517001;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=efw446mrmvehY30TCSNsQ+ZYixEigKGDd1rX3LRpyCs=;
 b=izve8gJpAyS9Ophm6bdwMAkoFc/IEsT9wc/t0SzHhW+f1n+pqicGgM5M2O9p6ppGIN
 1CdXhtxW0ef/mVgnO351lx+ikCrji3+aMnaoR6Z1VSkcOCXrBMmzilXNsBzxZIyiKe56
 09duWf4ct0gNRKCD3KJQV8xzbcBpA+ayhz0NbY1lKh1wKXBcMH8EbUl4d6OjSwmC2fN9
 wxoJDBKbd03PnCgOfc+5W4DN3rZTHuQisPNCRKG2BM3QyMo5QIYMrim2mAeMyMGG2G0z
 Kc2nJznPqsmpjvH9ymjpwBwsbL1NapZbN8ZTrspgtSaIYjcHswjsn1G24TBUiKWOTrmp
 sgRw==
X-Gm-Message-State: AOJu0YyuSMx2DgXWIS8mWcH1DO5bHpf/TtCLE0kTezzmbKBgGUdOU0xj
 VU0tFKQ5IYzY3R8ZaaCwh+PCtVMMUQXtIKRd1IJsSBliY6hrrm5k8VNiMMGopozmPiCMOsvD/CK
 zm68T/QKWf+EhuKPZSYtyxJcyllHT6FQKWWDcRfbBIyVM5a2161yaWaw=
X-Gm-Gg: AY/fxX4hznYQlGgo6RxZX1LVVEaGm2VNEwPa1j9io6xNwQQSIo1CAMPNUXXWhPowz4J
 kBkvdu6sQ5YQG2+E3TZEWXf+q0Ppb6hOSONYvM+usRbM03WVwDAXkufXWMnNQooJu9Rs0e0y6l/
 4VT644GyFYzLslfMqPH3uGmkK3gWfyVqosGlZlQ0ZtI5CphD7QSdu56Aq/19FpPxtheUFS6si19
 iPymgc/4Q090IZjhmRaJ1TIvSNousdHyTMLx3QF3iC8Rjw8ZozHE5tjCzpl1szrJpgN0L/7oEal
 oKpqTZwxmQ==
X-Google-Smtp-Source: AGHT+IHgL9w3OrMcI1wzwuqwCz6cIjxxjj1AKkXmvootTiQkkCAaZPubjNL62gWvKt8QCISA/LkP0zsnhCGKqnRak6g=
X-Received: by 2002:a05:7022:238b:b0:11f:2c69:32 with SMTP id
 a92af1059eb24-121f8ac97b2mr6510080c88.7.1767912200299; Thu, 08 Jan 2026
 14:43:20 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 8 Jan 2026 17:41:14 -0500
X-Gm-Features: AQt7F2rIPRY7-_vIKkSWhnBvneB1UV7SGyQi0UYWBWaHuVGMyOw5WMZXlrpjHwg
Message-ID: <CAJvnSUD2j=EswBAEAbsNVZHcD6AYm_4ANO58dyMm+zm=kTG2mw@mail.gmail.com>
Subject: Community CI Meeting Minutes - January 8, 2026
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000b17a210647e822a1"
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

--000000000000b17a210647e822a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

January 8, 2026

Attendees
1. Patrick Robb
2. Aaron Conole
3. Paul Szczepanek
4. Andrew Bailey

Minutes

General Announcements
* Patchwork has been slow yesterday/today and timing out on some API
requests, which may be affecting the CI Labs. Patrick emailed Ali asking
about this.
   * In December Ali made various suggestions to CI labs regarding how they
could reduce their requests being made to patchwork, and to the best of our
knowledge all the labs completed these improvements.

CI Status

AWS Lab
* Running normally.

UNH-IOL Community Lab
* UNH missed testing on a significant amount of patchseries over the
Holiday break, which it is now backfilling. There are still about 10
patchseries remaining, but we should be caught up on results tomorrow.
* DTS:
   * Nic_single_core_fwd: Moving CI runs of this testsuite from legacy DTS
to new DTS. This should be all done by the end of next week.
   * Other than that, the only remaining DTS testing coming from the Legacy
framework will be cryptodev, but Andrew Bailey is working on this currently
for 26.03, so we should be completely off of the Legacy framework after
that.
* New Distros:
   * Fedora 43
   * Rhel 10
* DPDK LTS build failures on Fedora43
   * Stephen Hemminger mentioned on Bugzilla there will not be patches
backported to fedora 43 to resolve this
* We have moved all the testing over from our Windows 2022 machine to
Windows 2025. Andre Muezerie is trying to get us a Windows 2025 License key=
.
   * Our unit testing pipeline for Windows is failing for 23.11 and 24.11
LTS due to the fact that it is using the new devx environment variables.
Resolution is probably simply switching the environment variable name based
on whether we are testing <25.11 or >=3D25.11

Intel Lab
* Akhil mentioned on Slack it is problematic that they dont publish logs
alongside failures
* David mentioned this has been mentioned in the past and that they have
not had the bandwidth to address it in the past.

Github Actions Robot
* Sonnet Claude Code Review:
   * Did a pass against a DPDK patch Stephen Hemminger sent:
      *
https://patches.dpdk.org/project/dpdk/list/?series=3D36859&state=3D%2A&arch=
ive=3Dboth
   * Coderabbit (the agent previously tested) was just creating noise, but
Claude seems to be performing better
* The SQL syntax issue for the new SQLite version and Ozlabs https
patchwork issues from December has been resolved, so the testing is back
online

Loongson Lab
* Patrick to check in with Bibo about whether they have reduced their
requests being made to patchwork for the recheck framework scripting.
DTS Improvements & Test Development
* Cryptodev:
   * Should the cryptodev stats printing methods be staticmethods or module
level functions?
   * Patrick has sent reviews on =E2=85=94 patches, will send the final rev=
iew today
   * Need to automate creating the virtual functions on the crypto devices.
      * Also, strategy is to create the max number of possible VFs for each
cryptodev physical function based on the value within sriov_max_vfs
* Flow Offload:
   * Dean sent the RFC for the new extensive flow offload testsuite
      * Uses the generic generator for creating flow rules and the
associated packets for DROP, QUEUE, and MODIFY actions
      * Uses explicitly written rules and assertions for the JUMP rule
testing
* Virtio:
   * RFC has been sent
* Misc:
   * Patches to be merged:
      *
https://patchwork.dpdk.org/project/dpdk/patch/20251106181355.209706-1-dmarx=
@iol.unh.edu/
      *
https://patchwork.dpdk.org/project/dpdk/patch/20251126141650.367633-1-abail=
ey@iol.unh.edu/
      *
https://patchwork.dpdk.org/project/dpdk/patch/20251215214049.694604-1-abail=
ey@iol.unh.edu/
      *
https://patchwork.dpdk.org/project/dpdk/patch/20251217165716.705128-1-abail=
ey@iol.unh.edu/

Any other business
   * Do we have an ARM machine with E810 in the labs (driver patch)? There
is an IAVF issue with ARM and E810.
   * Yes, we do. Patrick will connect with Jay from ARM on how the UNH lab
can verify their fix on E810.
   * Next meeting is January 21, 2026

--000000000000b17a210647e822a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">January 8, 2026<br><br>Attendees<br>1. Pa=
trick Robb<br>2. Aaron Conole<br>3. Paul Szczepanek<br>4. Andrew Bailey<br>=
<br>Minutes<br><br>General Announcements<br>* Patchwork has been slow yeste=
rday/today and timing out on some API requests, which may be affecting the =
CI Labs. Patrick emailed Ali asking about this.<br>=C2=A0 =C2=A0* In Decemb=
er Ali made various suggestions to CI labs regarding how they could reduce =
their requests being made to patchwork, and to the best of our knowledge al=
l the labs completed these improvements.<br><br>CI Status<br><br>AWS Lab<br=
>* Running normally.<br><br>UNH-IOL Community Lab<br>* UNH missed testing o=
n a significant amount of patchseries over the Holiday break, which it is n=
ow backfilling. There are still about 10 patchseries remaining, but we shou=
ld be caught up on results tomorrow.<br>* DTS:<br>=C2=A0 =C2=A0* Nic_single=
_core_fwd: Moving CI runs of this testsuite from legacy DTS to new DTS. Thi=
s should be all done by the end of next week.<br>=C2=A0 =C2=A0* Other than =
that, the only remaining DTS testing coming from the Legacy framework will =
be cryptodev, but Andrew Bailey is working on this currently for 26.03, so =
we should be completely off of the Legacy framework after that.<br>* New Di=
stros:<br>=C2=A0 =C2=A0* Fedora 43<br>=C2=A0 =C2=A0* Rhel 10<br>* DPDK LTS =
build failures on Fedora43<br>=C2=A0 =C2=A0* Stephen Hemminger mentioned on=
 Bugzilla there will not be patches backported to fedora 43 to resolve this=
<br>* We have moved all the testing over from our Windows 2022 machine to W=
indows 2025. Andre Muezerie is trying to get us a Windows 2025 License key.=
<br>=C2=A0 =C2=A0* Our unit testing pipeline for Windows is failing for 23.=
11 and 24.11 LTS due to the fact that it is using the new devx environment =
variables. Resolution is probably simply switching the environment variable=
 name based on whether we are testing &lt;25.11 or &gt;=3D25.11 <br><br>Int=
el Lab<br>* Akhil mentioned on Slack it is problematic that they dont publi=
sh logs alongside failures<br>* David mentioned this has been mentioned in =
the past and that they have not had the bandwidth to address it in the past=
.<br><br>Github Actions Robot<br>* Sonnet Claude Code Review:<br>=C2=A0 =C2=
=A0* Did a pass against a DPDK patch Stephen Hemminger sent:<br>=C2=A0 =C2=
=A0 =C2=A0 * <a href=3D"https://patches.dpdk.org/project/dpdk/list/?series=
=3D36859&amp;state=3D%2A&amp;archive=3Dboth" target=3D"_blank">https://patc=
hes.dpdk.org/project/dpdk/list/?series=3D36859&amp;state=3D%2A&amp;archive=
=3Dboth</a><br>=C2=A0 =C2=A0* Coderabbit (the agent previously tested) was =
just creating noise, but Claude seems to be performing better<br>* The SQL =
syntax issue for the new SQLite version and Ozlabs https patchwork issues f=
rom December has been resolved, so the testing is back online<br><br>Loongs=
on Lab<br>* Patrick to check in with Bibo about whether they have reduced t=
heir requests being made to patchwork for the recheck framework scripting.<=
br>DTS Improvements &amp; Test Development<br>* Cryptodev:<br>=C2=A0 =C2=A0=
* Should the cryptodev stats printing methods be staticmethods or module le=
vel functions?<br>=C2=A0 =C2=A0* Patrick has sent reviews on =E2=85=94 patc=
hes, will send the final review today<br>=C2=A0 =C2=A0* Need to automate cr=
eating the virtual functions on the crypto devices.<br>=C2=A0 =C2=A0 =C2=A0=
 * Also, strategy is to create the max number of possible VFs for each cryp=
todev physical function based on the value within sriov_max_vfs<br>* Flow O=
ffload:<br>=C2=A0 =C2=A0* Dean sent the RFC for the new extensive flow offl=
oad testsuite<br>=C2=A0 =C2=A0 =C2=A0 * Uses the generic generator for crea=
ting flow rules and the associated packets for DROP, QUEUE, and MODIFY acti=
ons<br>=C2=A0 =C2=A0 =C2=A0 * Uses explicitly written rules and assertions =
for the JUMP rule testing<br>* Virtio:<br>=C2=A0 =C2=A0* RFC has been sent<=
br>* Misc:<br>=C2=A0 =C2=A0* Patches to be merged:<br>=C2=A0 =C2=A0 =C2=A0 =
* <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/20251106181355.2=
09706-1-dmarx@iol.unh.edu/" target=3D"_blank">https://patchwork.dpdk.org/pr=
oject/dpdk/patch/20251106181355.209706-1-dmarx@iol.unh.edu/</a><br>=C2=A0 =
=C2=A0 =C2=A0 * <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/20=
251126141650.367633-1-abailey@iol.unh.edu/" target=3D"_blank">https://patch=
work.dpdk.org/project/dpdk/patch/20251126141650.367633-1-abailey@iol.unh.ed=
u/</a><br>=C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://patchwork.dpdk.org/proj=
ect/dpdk/patch/20251215214049.694604-1-abailey@iol.unh.edu/" target=3D"_bla=
nk">https://patchwork.dpdk.org/project/dpdk/patch/20251215214049.694604-1-a=
bailey@iol.unh.edu/</a><br>=C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://patchw=
ork.dpdk.org/project/dpdk/patch/20251217165716.705128-1-abailey@iol.unh.edu=
/" target=3D"_blank">https://patchwork.dpdk.org/project/dpdk/patch/20251217=
165716.705128-1-abailey@iol.unh.edu/</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <br>Any other business<br>=C2=A0 =C2=A0* Do we hav=
e an ARM machine with E810 in the labs (driver patch)? There is an IAVF iss=
ue with ARM and E810.<br>=C2=A0 =C2=A0* Yes, we do. Patrick will connect wi=
th Jay from ARM on how the UNH lab can verify their fix on E810.<br>=C2=A0 =
=C2=A0* Next meeting is January 21, 2026</div>
</div>

--000000000000b17a210647e822a1--
