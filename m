Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F20D59D8E
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 19:53:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCCD940651;
	Fri, 12 Dec 2025 20:53:50 +0100 (CET)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 17C0F4027D
 for <dev@dpdk.org>; Fri, 12 Dec 2025 20:53:50 +0100 (CET)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-bddba676613so1115277a12.2
 for <dev@dpdk.org>; Fri, 12 Dec 2025 11:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765569229; x=1766174029; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TbL2IPSug1Cn5igOSlQxzavdBOTD9kEfrWphSc/jioI=;
 b=Th0UHaYj4Uv86XYcXHLn4osqF+jwWUBh02JQthUyXnrxPpDeSjJXIRISyrqauz7z2k
 f5lFkllO1nWQxyyoMMHNlid0qdO5ikekomkWtfL7wEa8FWPD74qMrpfGgKaiAqJkJVR2
 55jkwKcf+Gh1aLO1otsjn0T5eJ8I+kCXVQSiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765569229; x=1766174029;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TbL2IPSug1Cn5igOSlQxzavdBOTD9kEfrWphSc/jioI=;
 b=f3gjLSUWQ9EoLltRFU/G8VIJhLHdfoSpnbrGUihN1GrKawNy82yAZChC9pZrwjwVNd
 saKk51M1KZxgPpgCOHUKrhFU2lfsKSBq3qdULfn3uggvkWYxkICJqlQ7eu+nQORJRm8L
 yRNfnJ4ZVNjxcPbPzfRB+rK/Dr7A1RdxHLH5fEFew/g/SW2e/fzkdNVZwAGbxRsKeUyk
 8zpNspye5qIcCazeXb4SzW6vSIcQkcoIzdEj+lzlse8F4LrZEoNYdvfLBrXze3nNIKGE
 faKbORvWlpV+ePnmegOnn40LU/S2vfnT7yeN5kXeh9mz9O+1SjyzOzwkGqTrZmotKFer
 YKDQ==
X-Gm-Message-State: AOJu0YzAXAEe1kUk5rlq0imdQrOvy3j40VNlYnyiGrZ3ndqD7R0CXgi/
 oR3uGVNpXopPuRRtGQgcCf/uiE/vs9QLNo+ICGRs3z+Hcuw8bu1d+ww1jkeVK1lxMQ1c+H4/0Ex
 AW7TosyqdYZvuKsOL99ExF1ZDpu+CpyqNL99NTpYJFCTw9Lchxdf9ldAZkg==
X-Gm-Gg: AY/fxX48ywFPR9TNvunG3YjJZqcwGp7VBiRQItQCbrx2CTRdJj/4fI6s7HwmlpJS2iS
 c7M9v5tTL7mwRc/7roLYbjvPXEbW4JpiDpicxJydiYbrRvfZ9rVzKvQb3eH+7SW4QEqhW3IDkuB
 Vc0cQqujlszSRQEs4b1FfxfrDe1gVsL2geOqBk6x1/5EC7hPUSk5jb5Eg4AHd8gs+HbaIQxCUlO
 bjQ3YsoJfhNmTV7xOdMFroQznt2XioRMlWfTlA6kWV4SH/odIny5fV1dA2XDYyqKlFey/qfuP1g
 08BdJtq46E8EgSKicWaPfB1ZdcWJ
X-Google-Smtp-Source: AGHT+IFgbUL6xwDSStJ5jELqXmp/7Kiy0mzChh2zPOjeJ2JP5EMZHOFSH0HmRWFo7/gEyFgT33DzEgfY889LmY2cE5I=
X-Received: by 2002:a05:693c:40cc:b0:2a4:3644:4be3 with SMTP id
 5a478bee46e88-2ac3010f968mr2530922eec.27.1765569228756; Fri, 12 Dec 2025
 11:53:48 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 12 Dec 2025 14:52:06 -0500
X-Gm-Features: AQt7F2pl5P4Sf91hwOqWHMfK9D1H9Anv6fbLnBl3noLCNP8kHU7RjMElecYikek
Message-ID: <CAJvnSUAb41bDcOf5q7H7cO0Hms+8JTG3FwEaAbGp3NkMem=f2g@mail.gmail.com>
Subject: DTS WG Meeting Minutes - November 20, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b4ea710645c69e4d"
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

--000000000000b4ea710645c69e4d
Content-Type: text/plain; charset="UTF-8"

November 20, 2025

Attendees
* Patrick Robb
* Andrew Bailey
* Paul Szczepanek

Minutes

General Discussion
* RC3 has been released
   * We are mostly done with DTS patches, but we can merge a couple more
such as the devtools docstrings check script and the formatting fix
patchseries

Patch discussions
* add test case docstring checks to format script
   * We are permitted to add this for RC4
* Pydantic build fix was merged.
* doc: add test case docstring example to dts rst
   * merged
* Virtio:
   * merged
* Single_core_fwd_perf:
   * merged
* RSS:
   * merged
* QinQ:
   * Merged

Bugzilla discussions
* Andrew and Patrick will update UNH DTS bugzilla tickets

Any other business
* Roadmap discussion (WIP):
   * DTS API
      * Resolve leftover parts
   * Cryptodev testing
      * (framework): Adding a shell class for the dpdk-crypto-perf
application
      * (testsuites) : Encrypt/decrypt workloads with the various supported
algorithms on DPDK NICs.
      * Can be implemented as a set of functional tests or (pending
community discussion) can support crypto performance baselines
   * Ensure the documentation for testing on a single host with a single
NIC is up to date
   * Virtio testing support:
      * Enable additional testing topologies and scenarios
   * Additional functional ethdev testsuites:
      * Ethertype Testsuite
      * QinQ testing: Extend this testsuite to validate that IDs are being
stored in the correct TCI / OUTER_TCI via testpmd verbose logs
   * Flow Offload Testsuites:
      * Add a new testsuite which creates a huge combination of patterns
and actions for rules, and tests them all.
* Next meeting is Dec 4, 2025

--000000000000b4ea710645c69e4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">November 20, 2025<br><br>Attendees<br>* Patrick Robb<br>* =
Andrew Bailey<br>* Paul Szczepanek<br><br>Minutes<br><br>General Discussion=
<br>* RC3 has been released<br>=C2=A0 =C2=A0* We are mostly done with DTS p=
atches, but we can merge a couple more such as the devtools docstrings chec=
k script and the formatting fix patchseries<br><br>Patch discussions<br>* a=
dd test case docstring checks to format script<br>=C2=A0 =C2=A0* We are per=
mitted to add this for RC4<br>* Pydantic build fix was merged.<br>* doc: ad=
d test case docstring example to dts rst<br>=C2=A0 =C2=A0* merged<br>* Virt=
io:<br>=C2=A0 =C2=A0* merged<br>* Single_core_fwd_perf:<br>=C2=A0 =C2=A0* m=
erged<br>* RSS:<br>=C2=A0 =C2=A0* merged<br>* QinQ:<br>=C2=A0 =C2=A0* Merge=
d<br>=C2=A0 =C2=A0<br>Bugzilla discussions<br>* Andrew and Patrick will upd=
ate UNH DTS bugzilla tickets<br><br>Any other business<br>* Roadmap discuss=
ion (WIP):<br>=C2=A0 =C2=A0* DTS API<br>=C2=A0 =C2=A0 =C2=A0 * Resolve left=
over parts<br>=C2=A0 =C2=A0* Cryptodev testing<br>=C2=A0 =C2=A0 =C2=A0 * (f=
ramework): Adding a shell class for the dpdk-crypto-perf application<br>=C2=
=A0 =C2=A0 =C2=A0 * (testsuites) : Encrypt/decrypt workloads with the vario=
us supported algorithms on DPDK NICs.<br>=C2=A0 =C2=A0 =C2=A0 * Can be impl=
emented as a set of functional tests or (pending community discussion) can =
support crypto performance baselines<br>=C2=A0 =C2=A0* Ensure the documenta=
tion for testing on a single host with a single NIC is up to date<br>=C2=A0=
 =C2=A0* Virtio testing support:<br>=C2=A0 =C2=A0 =C2=A0 * Enable additiona=
l testing topologies and scenarios<br>=C2=A0 =C2=A0* Additional functional =
ethdev testsuites:<br>=C2=A0 =C2=A0 =C2=A0 * Ethertype Testsuite<br>=C2=A0 =
=C2=A0 =C2=A0 * QinQ testing: Extend this testsuite to validate that IDs ar=
e being stored in the correct TCI / OUTER_TCI via testpmd verbose logs<br>=
=C2=A0 =C2=A0* Flow Offload Testsuites:<br>=C2=A0 =C2=A0 =C2=A0 * Add a new=
 testsuite which creates a huge combination of patterns and actions for rul=
es, and tests them all.<br>* Next meeting is Dec 4, 2025<br></div>

--000000000000b4ea710645c69e4d--
