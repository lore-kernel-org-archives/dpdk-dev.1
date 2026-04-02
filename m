Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35AFD6AAFD
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 19:13:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7A4E4028E;
	Thu,  2 Apr 2026 21:13:12 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 74EEC4027A
 for <dev@dpdk.org>; Thu,  2 Apr 2026 21:13:11 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-128e4d0cc48so1470061c88.1
 for <dev@dpdk.org>; Thu, 02 Apr 2026 12:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775157190; cv=none;
 d=google.com; s=arc-20240605;
 b=HWK3RokKSjUkBwrwyQxcdNUHhtPqq0he/HVLG0DZuiZjLStT1CpJ+7Wymi5OSwVmjQ
 kOieziLxLZx5LIKvC+CUDAXuJ8TAnvUguVuuSiZLqtdKYJaasGkuAsdGiBMTpY9sLaaI
 q1H4KJ8UoDZaWozrJnMM9l90gl/ik2AcExancYo7gbd88E/9T8CaCrvw7JSTdSnqxQA5
 qwQHBOFYlg9rOQs/i1LvoEDSHnzcgmakIDngn7IAtToTale/pg/IA7s9L/X9OdDsRfbf
 MaNqVsL1/r61UAQO3i+Wr1Wj0PUnXxVGigYqySo8L2MT0aH9mEsAvHjbZlopR1UJikuG
 Rvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=pIXt1cqUcdmKx2M69ZoexsO/nw0iEgz3na/oVhLlhSA=;
 fh=v1VvrYYXadeTNy4HjH40pmjV0YiJYq6WpclLqfUi2B4=;
 b=cni1/T8f2/cQFtIT2+yOpHyBSXPkPbEuMAVJNqAfNA8RVwXxxsxzXehn+lQ9yl4tmZ
 u/j+vKGvqI0z19C24qA1pEeIBaOswEgDc1Ai80gRhjTDvIJROoxD7gz8WlAtmeNgqf1U
 15U81yzbuv2SNso/aH4xsUhmV4BmPWpTMt8anMlqkd0Wsm5X4lKgnHDrBpSrc9Zk62P+
 QnwG5mfEIUMvmhz/M0mWxb2N+UdbUMhGuDZCe91vfw8TB/iEhQl3A4rPIEkLVJ5SOxNA
 i+4WRstqvW4HIJTL8voNdJMgKQ45kHE2mswVvk+Xv0scgX8SYgtUCaQlh4B7EnB2HI4Q
 pQHw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775157190; x=1775761990; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pIXt1cqUcdmKx2M69ZoexsO/nw0iEgz3na/oVhLlhSA=;
 b=Vz/5rXhRi+tHDT0fAadKqOdXaT32/sAkw+s5tNo4cKinMpfyhamcdipDkK8p2fixer
 uKngKnqYa/HGYCGdbjcHyt1ty+DIcVDF7e0jAsxRGn1No3HzM8USnQj4IoYTXHY6Jlu0
 MZQG4aYmBT9SvMzMWH8wsOkofWIBTl9GWZtWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775157190; x=1775761990;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pIXt1cqUcdmKx2M69ZoexsO/nw0iEgz3na/oVhLlhSA=;
 b=bmKlrrAkc4vgtlfkaggEEIr6rybp7gIZ3jKkXIRES+53FLlOEnAKwCrTnDgFTObsE+
 PKqWzVSbLRaX77DvyNadPQJ8Jclo8ilyxdQMeb4Vm/I4GU9JedZ+tR2hdsJnSdEp0IVa
 yDpKsUJyxAqB6hOxBxgGnW4jt4/NvhbwSkfw7Hdq8GGJ3UY7g00rprkpOxQxS5TpGpRq
 1YQUt1IzgJOARHbHkrtrKSYtnCSlMH62F43H5yWAOHQUoXpvqPNG2FKvdXCJ2oIUUFQe
 4Al8Yb57HPBv4MHvafhHqhyFeTanVYPFc/PQB1ha9fN5ozbzB9aw+7ZQMbo1XuOjHkF9
 CvLA==
X-Gm-Message-State: AOJu0YwjzLbpfS5kzqdpJoLvb+WVBc7q16247Oych7kAONbMbQrNDc3K
 YB8oimRIWvd49E25I6UUqIIYOE9xIRgYVWOgNZycVKKpavx26XGD5A/Rn9IYHvAOUZLT/DHfSO3
 Pkv91DOglFLuXThbXfTzqBI7eEmnLzg4DG2Qi/h0LCQ==
X-Gm-Gg: ATEYQzwoCrZaLiGbpEmCHk11rNwvn+sbE4KmJW1/QZk3OfUFQDaxtbs9yuH0QOkJqHg
 8XaZ4+t+k3Ee9QwEu7G9YtVj/1kJS62IRc6xxx9o5RPsRu2jHcplt9LPPsMQHeL912dbz0dYR4N
 LBzrlQfXJgVefstc6IXAYyQ0/b0jB1Yena90vpXfiK6VnQaaOQ70RRm2vdpam1fCb9AhWb2jxWE
 tOy0E59yjsQyz96DOiexiOgXVPROIY5kodE+l5maLT8VM7YnT6wpkYROHjRVcNE2vMPVwtGjA1y
 floqzzGI44iF+H5Efl+KSSR9tuzFVJV6vd0BXcEZWc+A7SQ0hqot3A==
X-Received: by 2002:a05:7022:1005:b0:128:cf5c:535a with SMTP id
 a92af1059eb24-12bfb6f4e06mr148132c88.11.1775157190336; Thu, 02 Apr 2026
 12:13:10 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 2 Apr 2026 15:09:45 -0400
X-Gm-Features: AQROBzDVME58Xp_cmSx92LE4id8LJb6Wssa6iUlslmvH7wf7aNM8ZraLzKtLR6I
Message-ID: <CAJvnSUCZ3nSsvu6zJCif0uEZo-3c4Oacx0Z-7Zya8c8ASECvxw@mail.gmail.com>
Subject: Community CI Meeting Minutes - March 5, 2026
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>, Adam Hassick <ahassick@iol.unh.edu>, 
 Lincoln Lavoie <lylavoie@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000c0310a064e7efdd6"
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

--000000000000c0310a064e7efdd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

March 5, 2026
Attendees
      12. Patrick Robb
      13. Aaron Conole
      14. Matthew Labrecque
Minutes
General Announcements
      * AI Code Review:
      * How should the emails to test-report be formatted?
      * First idea: Result is PASS if AI code review was run, WARN if the
AI code review was not run because it did not pass one of the smoke checks
      * If WARN, add a 1 line body which states which smoke check did not
pass
      * OR (and this might be a better idea, and one Aaron will bring to
Stephen) We can have the AI code review itself indicate a PASS or WARN
based on whether it identifies significant issues in the patch. FAIL is
reserved for when the AI code review is not run at all because one of the
smoke checks failed.
      * Otherwise, we have written up our implementation plan and are good
to proceed with the implementation on Jenkins.
      * Aaron to come into the UNH Lab soon to review the AI code review
process with the team.
      * RC1 was released last week
      * Ali sent a patch forcing pw_maintainers_cli.py to always return an
iterable:
https://patchwork.dpdk.org/project/ci/patch/20260305103052.1086957-1-alialn=
u@nvidia.com/
CI Status
AWS Lab
      * None, running normally
UNH-IOL Community Lab
      * Still debugging issues using large pages for dpdk-test on the
server 2025 machine, so that individual test is remaining on server 2022
until we work it out. Patrick to take a look.
      * 25.11-staging:
      * We initially forgot to add the 25.11-staging branch to our internal
UNH DPDK Lab rest API / database which caused Kevin=E2=80=99s initial runs =
to fail.
Now it is working fine.
      * It is very important that these branches are ready in good time,
and in this case we added support late for 25.11-staging.
      * We discussed a few ways of approaching this issue. For now, the UNH
team will explicitly document in our procedures confluence page actions to
take when LTS versions release in Nov, with step by step instructions for
enabling ABI, adding the new LTS branches to Jenkins, adding them to our
rest API, etc. etc.
      * FreeBSD is upgraded to 14.3, and sometime next week 14.4 will
release and we will upgrade again at that time
      * Dpdk-minimum-kernel:
      * The minimum supported kernel version got upped to 5.15, so we are
planning our upgrade of our dpdk-minimum-kernel test machine to this kernel
version.
Intel Lab
      * None
      * We met Manju from Intel last week at the DTS meeting. He is working
at Intel and running DPDK testing (for internal use, not for CI reports)
and he is moving over from legacy DTS to the new DTS now.
Github Actions Robot
      * Aaron has been on PTO but will return to the code coverage work
Loongson Lab
      * None, running normally
DTS Improvements & Test Development
      * Cryptodev:
      * Latest version looks good and is running on both QAT devices the
lab has
      * Patrick can provide one more review and additional test of the
latest version
      * Flow Offload:
      * Latest version looks good, but Patrick is sending a few nits.
      * Dean is adding a new version which adds flow rules for VXLAN
packets - if we run out of time we will just merge the version without the
VXLAN flow rules.
      * Patrick is going to send some tiny TREX fixes that we have noticed
on some systems (i.e. no more forcing 10 cores for TREX, let the TREX
config file decide this)
      * Andrew sent a patch which adds a multiline comments to nodes.yaml
and test_run.yaml explaining the optional fields

Any other business
         * Next meeting is Mar 19, 2026

--000000000000c0310a064e7efdd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>March 5, 2026<br>Attendees<br>=C2=A0 =C2=A0 =C2=A0 12.=
 Patrick Robb<br>=C2=A0 =C2=A0 =C2=A0 13. Aaron Conole<br>=C2=A0 =C2=A0 =C2=
=A0 14. Matthew Labrecque<br>Minutes<br>General Announcements<br>=C2=A0 =C2=
=A0 =C2=A0 * AI Code Review:<br>=C2=A0 =C2=A0 =C2=A0 * How should the email=
s to test-report be formatted?<br>=C2=A0 =C2=A0 =C2=A0 * First idea: Result=
 is PASS if AI code review was run, WARN if the AI code review was not run =
because it did not pass one of the smoke checks<br>=C2=A0 =C2=A0 =C2=A0 * I=
f WARN, add a 1 line body which states which smoke check did not pass<br>=
=C2=A0 =C2=A0 =C2=A0 * OR (and this might be a better idea, and one Aaron w=
ill bring to Stephen) We can have the AI code review itself indicate a PASS=
 or WARN based on whether it identifies significant issues in the patch. FA=
IL is reserved for when the AI code review is not run at all because one of=
 the smoke checks failed.<br>=C2=A0 =C2=A0 =C2=A0 * Otherwise, we have writ=
ten up our implementation plan and are good to proceed with the implementat=
ion on Jenkins.<br>=C2=A0 =C2=A0 =C2=A0 * Aaron to come into the UNH Lab so=
on to review the AI code review process with the team.<br>=C2=A0 =C2=A0 =C2=
=A0 * RC1 was released last week<br>=C2=A0 =C2=A0 =C2=A0 * Ali sent a patch=
 forcing pw_maintainers_cli.py to always return an iterable: <a href=3D"htt=
ps://patchwork.dpdk.org/project/ci/patch/20260305103052.1086957-1-alialnu@n=
vidia.com/">https://patchwork.dpdk.org/project/ci/patch/20260305103052.1086=
957-1-alialnu@nvidia.com/</a><br>CI Status<br>AWS Lab<br>=C2=A0 =C2=A0 =C2=
=A0 * None, running normally<br>UNH-IOL Community Lab<br>=C2=A0 =C2=A0 =C2=
=A0 * Still debugging issues using large pages for dpdk-test on the server =
2025 machine, so that individual test is remaining on server 2022 until we =
work it out. Patrick to take a look.<br>=C2=A0 =C2=A0 =C2=A0 * 25.11-stagin=
g:<br>=C2=A0 =C2=A0 =C2=A0 * We initially forgot to add the 25.11-staging b=
ranch to our internal UNH DPDK Lab rest API / database which caused Kevin=
=E2=80=99s initial runs to fail. Now it is working fine.<br>=C2=A0 =C2=A0 =
=C2=A0 * It is very important that these branches are ready in good time, a=
nd in this case we added support late for 25.11-staging.<br>=C2=A0 =C2=A0 =
=C2=A0 * We discussed a few ways of approaching this issue. For now, the UN=
H team will explicitly document in our procedures confluence page actions t=
o take when LTS versions release in Nov, with step by step instructions for=
 enabling ABI, adding the new LTS branches to Jenkins, adding them to our r=
est API, etc. etc.<br>=C2=A0 =C2=A0 =C2=A0 * FreeBSD is upgraded to 14.3, a=
nd sometime next week 14.4 will release and we will upgrade again at that t=
ime<br>=C2=A0 =C2=A0 =C2=A0 * Dpdk-minimum-kernel:<br>=C2=A0 =C2=A0 =C2=A0 =
* The minimum supported kernel version got upped to 5.15, so we are plannin=
g our upgrade of our dpdk-minimum-kernel test machine to this kernel versio=
n.<br>Intel Lab<br>=C2=A0 =C2=A0 =C2=A0 * None<br>=C2=A0 =C2=A0 =C2=A0 * We=
 met Manju from Intel last week at the DTS meeting. He is working at Intel =
and running DPDK testing (for internal use, not for CI reports) and he is m=
oving over from legacy DTS to the new DTS now.<br>Github Actions Robot<br>=
=C2=A0 =C2=A0 =C2=A0 * Aaron has been on PTO but will return to the code co=
verage work<br>Loongson Lab<br>=C2=A0 =C2=A0 =C2=A0 * None, running normall=
y<br>DTS Improvements &amp; Test Development<br>=C2=A0 =C2=A0 =C2=A0 * Cryp=
todev:<br>=C2=A0 =C2=A0 =C2=A0 * Latest version looks good and is running o=
n both QAT devices the lab has<br>=C2=A0 =C2=A0 =C2=A0 * Patrick can provid=
e one more review and additional test of the latest version<br>=C2=A0 =C2=
=A0 =C2=A0 * Flow Offload:<br>=C2=A0 =C2=A0 =C2=A0 * Latest version looks g=
ood, but Patrick is sending a few nits.<br>=C2=A0 =C2=A0 =C2=A0 * Dean is a=
dding a new version which adds flow rules for VXLAN packets - if we run out=
 of time we will just merge the version without the VXLAN flow rules.<br>=
=C2=A0 =C2=A0 =C2=A0 * Patrick is going to send some tiny TREX fixes that w=
e have noticed on some systems (i.e. no more forcing 10 cores for TREX, let=
 the TREX config file decide this)<br>=C2=A0 =C2=A0 =C2=A0 * Andrew sent a =
patch which adds a multiline comments to nodes.yaml and test_run.yaml expla=
ining the optional fields<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <br>Any other business<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Ne=
xt meeting is Mar 19, 2026</div>

--000000000000c0310a064e7efdd6--
