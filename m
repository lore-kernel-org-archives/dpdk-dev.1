Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37D9EFCE53
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 23:57:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A663B4029D;
	Thu,  5 Mar 2026 00:57:55 +0100 (CET)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id E00494027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 00:57:53 +0100 (CET)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1275910b930so4664988c88.0
 for <dev@dpdk.org>; Wed, 04 Mar 2026 15:57:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772668673; cv=none;
 d=google.com; s=arc-20240605;
 b=NIAlrqf5dJB78dy+BH+lW/6p120rMf/4+K8VptHc2H3XToC67ykKxi3vWv6NVPBFzx
 oWRkvwCbDyjl4TMuRv3W1wNsdXkAs9hZpazcJkdYsHDaqR/792iLSenjpmkNH+rlE5cy
 Q0r674eaVEprhm0gVqeiyb1KktoPbPy6posEjDiH8mpV3ExyTe/+tNp4vomT2AnZhDi6
 gyU3utOsz9vUYGns7v7Qdf3X1jTd9KF4vIXF9kKDIrlMX+iDwg+rGhslZsguPQQpGH63
 ZK9p4BTscxknEm7vd/I1P2qHGrLFCB1qCa8A/ElKCN7+AbAI1+ZA0cccwcc7+VcdeWPn
 +mSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=AVFS7OjXdWIJCU/Mj7lBhxzBd5AS9G2QyifBDRPoJvQ=;
 fh=GhayERS89y8XlsU0jCunHUZrR1bOebE7jTVoJL+2ldM=;
 b=edLvWZQzCTLkp2B1Uaxzi1H+shtVDnod2C+iNAG9uAaMw/08LslGrtcEUya70uzfh3
 I3rEtAZBkwuubVDY0JUycBlWjAJ5R2vsLgOzeOwzENREzE8qQDrRAWNzQpA4ciwS6cZI
 fMwC4WSO0yKXwd5WXjGT1WTolNJFK+fR2KXixqJSUaThKxKE7RNQlLnJ5R0isKZ7/PiO
 n8sfOAWcPiFXsRYXEKKDA0NI3AFm/6P7vxDoYBSRF7wGTAJnS6jnoirTD2lrpX9oX0li
 A2VWWeq9qlQ51H+xo6mR+iVeS9zZaBLjSoUwiKL610Fq3RhKDgK0XuZxY2HoEs1+jezg
 AH7g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772668673; x=1773273473; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AVFS7OjXdWIJCU/Mj7lBhxzBd5AS9G2QyifBDRPoJvQ=;
 b=aa++MdKIrYFCqpHMTsNewW7+mDXmTsMBO9hWe/omhgQTCxsEsS3t2KLWEok9r7xnxw
 SD+F/cX8bvyGlV60JR9Pea9bWNRFaWWR0L0eAHRvsaLjPFlckQXp3mRDcpORuJ0xe/CS
 KrjOHiFzjCapqYCZPmb/PbGvHIBe8VRIMU7P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772668673; x=1773273473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVFS7OjXdWIJCU/Mj7lBhxzBd5AS9G2QyifBDRPoJvQ=;
 b=oTtP3ebIEVb7rWVisnujPDPHa2AlkKN4/34HPE+plzxRUvPj9YOjSUxl89orTPtEFF
 QP7o6vo7xQd9hZeqiUYMIKW59gDTrXu8GQhvkWNyR0N4EJ80Rt84RVdnAK/IiPYObNDf
 67Y/XAAK1bGTaVNke0HWKogVh8NS9Z5PWGhb7Ud+pcmf7DhrGjLekTa6oFb7C3s+adyU
 Ly58m1hVFiVVcssFF1IewV1SY5T6d26ELqJORkPLPQ7JkTx1uYYPZZSPC8FnSjL5D7/u
 5zg0qXyAoScILRNrvQrNmJjdPNuIRB7w4+n9WuPbVHhbeJwDnOtonMYO9MdDuHzgOc+4
 ETxQ==
X-Gm-Message-State: AOJu0YwlBAxqO3YYTirhDV8sGw/40FzFUU2PiLTqG/VabSuV+cl0wZRs
 zMdjHknl4wU6lIL2gf1QnW2UKoC69HkVgFl7XZSZA2YDZKR/NHjqPc+mNRtcH1Hq2IWg8XePjIK
 YmGRNGeiKwPBHISwtNM2PK9CfGhxCR7jwY66KVCWRlK7fk95REj5oO7XAzg==
X-Gm-Gg: ATEYQzxtRd/OCK0zYUehDp3K3kg3ANvlTHgg4PNPVJYGEv6GS2L3Gv/+1oySx+v6FA8
 lf5Tcz0VbQma55n1xC3Ivb41eHPsR+E7mBAagi1vErthsXmMt1NTy8NiNNOH38jEOkFhzWKrpA0
 lZrcoxx02zFL/C7zVuT8sIbMIs8Cr9QQV8febYzBbji2pEs44pIS5imbnmR/t1NyJtW3UKlYT3/
 chjnsXugflx0b+OG3rJPi62ka+h95s0W4823IDxe6Ui9jjDfFVHdkVUMmAV5/z0+RdC0SH84hW0
 pula0I1pdlN5LkyjGLPoH3RFWn2eJxFQiJZ5GSJC9i2Ya0Rfw/6PZ/KTSFBLEHkCd9woHCD3h+T
 OupgLhcM=
X-Received: by 2002:a05:7022:458b:b0:124:9acd:3160 with SMTP id
 a92af1059eb24-128bbe95a3cmr245111c88.0.1772668672843; Wed, 04 Mar 2026
 15:57:52 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 4 Mar 2026 18:54:56 -0500
X-Gm-Features: AaiRm51wbedbQnJjTQOgtf2xD282OPC5j9tnzzsJLvG6ENoRe_KJ1HpcdPEtWQ4
Message-ID: <CAJvnSUD-Q138GJ6jyhUHh1Cm17+cvmtStx0Oh=k7Ja3tBG440A@mail.gmail.com>
Subject: Community CI Meeting Minutes - February 5, 2026
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

February 5, 2026

Attendees
   1. Patrick Robb
   2. Aaron Conole
   3. Paul Szczepanek
   4. Matt Labrecque

Minutes

General Announcements
   * AI Code review:
   * Community is looking for a place to host the scripting which
drives the AI reviews. The Community Lab is one candidate.
   * Tech board had discussion yesterday about what is the best place
to send the AI reviews? Test-report mailing list? Dev mailing list? A
new mailing list dedicated to AI reviews?
   * Thomas sent the API key to Patrick, it is being stored securely at UNH
   * Policy Discussion:
   * What are the conditions which should result in the AI code review
being triggered? Aaron Conole suggested that all CI checks (from the 4
CI labs) should be passing before the AI code review is triggered
   * David Marchand added on that there should be a way for
maintainers to manually override this / trigger a test
   * Aaron sent an initial patch with the scripting and prompts that
drives the AI code reviews, and this will need to be reviewed and
merged
   * Where will the prompts be stored? Should the community have
access to the prompts so they can locally run the AI code reviews?
Tech board says yes. So, they will need to be stored in a place which
is accessible.
   * Concern: If someone submits a patch that modifies the prompts and
that patch gets picked up by AI, that malicious submitter can send
arbitrary (possibly malicious) prompts to the AI code review system.
   * Aaron idea: If we are about to submit a review request, if the
series modified the prompt files at all, don=E2=80=99t submit. However, if =
it
was modified, and a review comment sender is contained within the DPDK
MAINTAINERS file, we assume the modifications are not malicious and
the AI code review is submitted.
   * Once the initial Jenkins scripting is setup on the UNH side, and
the scripting and AI review processes are submitted/under review for
the DPDK repo, Aaron will most likely visit UNH to flesh out the
process with the DPDK Lab team
   * DPDK Stockholm:
   * Patrick sent a draft RFC proposal to DTS folks about a talk which
would demonstrate integrating DTS into the DPDK dev process, using the
example of a flow offload update and the flow offload testsuite.
   * Aaron is planning to submit a talk about the new AI review scripting, =
etc.
   * Stephen Hemminger is working on a new python checkpatches script.
This will be merged to dpdk/devtools.
   * Since the existing checkpatches pulls from linux kernel
checkpatches, it is doing some checks which we would prefer not to and
send noise to the DPDK submitter. So, we have outgrown this. So, we
can continue to try to modify the checkpatches output, or just start
from scratch and write our completely separate checkpatches script
which only does what we want.
   * Also, python is nicer to work with vs perl, which means that the
barrier of entry for contributions and maintenance will be less
   * The performance of the perl script is worse due to our =E2=80=9Chacks=
=E2=80=9D we
add onto the checkpatches script
   * There was some discussion about trying to convince the kernel to
integrate our new checkpatches approach, but Aaron raises that this
will most likely not work because there are many, many other projects
consuming the existing kernel perl checkpatches
   * Example: OvS is maintaining their own checkpatches and this has
worked well in this community.

CI Status

AWS Lab
   * None

UNH-IOL Community Lab
   * Tech Board: Fast Free does not mean no multi-seg
   * UNH guys will keep an eye on this for the performance testing, if
the single core forwarding test needs to be updated so that it still
works =E2=80=9Cnormally=E2=80=9D i.e. enable fast free via a testpmd runtim=
e command
in the test if it moves to disabled by default, we can do so.
   * Meson: When UNH runs testing jobs, for linux systems we run the
.ci/linux-setup.sh script which sets the system to the =E2=80=9Ccorrect=E2=
=80=9D
version of meson at runtime.
   * This means that when the meson version is bumped, no coordination
with the UNH lab is required.
   * Windows: UNH guys need to add simple conditions into our windows
build pipelines that sets the meson version according to the DPDK
version
   * We are migration off of our existing Red Hat FreeIPA server,
which will require a little downtime in the near future. Patrick will
schedule this.
   * For users who want to use the

Intel Lab
   * None

Github Actions Robot
   * Aaron started an implementation which would allow his CI to build
an lcov/gcov code coverage report on a per patch basis
   * Needed to pass some options to force usage of atomics instead of
standard increment decrement
   * fprofile-update=3Datomic
   * Will be incliuded as an artifact on the CI job for a patchseries
   * Eventually, Aaron would like to add post processing that will
actually check whether new code is covered by a test vs not covered by
a test, etc.

Loongson Lab
   * None

DTS Improvements & Test Development
   * Cryptodev testsuite (performance and functional):
   * Akhil emailed back with some further guidance for Andrew
   * =E2=80=9CFor Symmetric algos, 10 million is good and would be complete=
d
fast. But for Asymmetric, 100K (or 10K for some cases.)would be good
enough.=E2=80=9D
   * =E2=80=9CIn some of the drivers, cipher-only and cipher-then-auth have
different path altogether. I would say, treat the cases as separate
cases with all supported list of algorithms. If it takes too much of
time, we can stick with the commonly used algos which are supported By
all PMDs. You can check
https://doc.dpdk.org/guides/cryptodevs/overview.html For the list of
supported algos.
   * Andrew is adding an additional =E2=80=9C@crypto_perf=E2=80=9D tests de=
corator,
beyond the existing @func and @perf decorators, since the crypto perf
tests do not require a performance traffic generator to be setup.
   * Flow Offload:
   * Patrick reviewed - Dean working on the next version currently.
   * DTS docstrings format script:
   * Merged
   * Missing Qinq rst file
   * merged

Any other business
      * Next meeting is Feb 19, 2026
