Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221C610F2843
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 15:39:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 238E440E49;
	Fri, 27 Mar 2026 16:39:52 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id DBBD8402C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 16:39:50 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12732165d1eso3448405c88.1
 for <dev@dpdk.org>; Fri, 27 Mar 2026 08:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774625990; cv=none;
 d=google.com; s=arc-20240605;
 b=BBJ6QiKitGpMa4XiwesB2J/YWm7biCjQaUWA3rA9GoiBvwUpQcqJamMRbWb51wafA0
 ZW0uKpiVkUsMJNKMxn764Wc/6T/Ji1hEhVylT1LKVnnmECwsNIKK88QDJGRg/qw3hPO4
 scYj4hSOR693E4juGL0TmrgFOdgaAusq+czIOLHnNKTG3jaZcV+Q39xG2bgZJ6r7kg19
 CQVqKEAr87pV335bNqImcsdbz9IExS1s2uyCmHpvPQiPfTExEQjeyJAkL+COf+thXcXh
 Lg5MPKLGqjqaScP2y5lXjtqKjIaFakIVH8QnYkDIbw8bEmaxWmucbE9DW0p5B0yHn+Lo
 N14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=2vPkXqQA3cCB7EMl3f8INWbbNgbXKk0R/a+CZMCeNs4=;
 fh=HQbt6FW1ReDg/OGHvz0+a19juuxN7umT8LYBRQSKaU4=;
 b=VERCLKHjLbufiCg6xDSwEEONwr1nbAhZ2UbIIzGskOu2NVwq8zIrhijNnL+gcn83U5
 daV8xtuhCcjAYpY2aN5Y8CneyI6jm+rRL8LUKYhAlxh8sjMh4rf+nNDo2V5fIQgKZ+9G
 6N6XVpUfKHKiIx3V4VmFj6r5iKHD0qrCP5YoSmE5GgCK44KFi0z+IdD9+eJsIwmfAbSE
 QGlmMYDDYU2IOoHNfWVob90iw6QrTSpru/rIE6+czLa0+xMPlHw6FEw3KWvhm7g2NHWy
 3gDZ/27Zhr0ywn4HET5oZah5AnfKtS9qnK4AlrZbDQmsyC3+hHktPA83/BIw4X1qmzYD
 79Gg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774625990; x=1775230790; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2vPkXqQA3cCB7EMl3f8INWbbNgbXKk0R/a+CZMCeNs4=;
 b=b7pcYsFCDJZ6F3h1zmVZr5EIsFEB/ipcXE44dCdSdhoq4p9XlV9lIY0mjCQ7XjRZ9E
 dBtgabEvhSBLkTqg7PoeWB1ilVY1tQlvU3KPyUkvA4kW+RNQ3jhC0Wv1x/wg8XPuUnZL
 zUEs0RdViSDwcePkhecqnzQJ7XhpMm88GYO1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774625990; x=1775230790;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2vPkXqQA3cCB7EMl3f8INWbbNgbXKk0R/a+CZMCeNs4=;
 b=d7yCeZ5Nlh80T5w7JaCzJ+E4ZFlnaZo14mqV5H3FlwKG4L/SbsLPeuaLxF2V8qMVN+
 VM4BifdHx7HqH+24e7RZCsH/wKDpWBwSLXjPbBfmBQNxa0L6mFLvMFi5cJX3RZP0ASaY
 +fbg5+gY5nqfHImVhkz9GMo94T2RHhHFmtbZxDrNkEZpMi+aKItwYC7IJY67i6XbhZTt
 6vfJQZHXBDRMZLg+jcAZ44QJ/2ZYYdOvNju693vuakQtA1tRBXWeeIWQLSPYnVzK+JXW
 B6U5M1RjjkuDuBTFfAU+qma3UNYXazGXWYr7DBWcryhF//M7563uK1XLTYkyer2zBHrh
 UPaw==
X-Gm-Message-State: AOJu0YyAEwb/t14GchGirnqViqxdkMzUZhIeQr6nwh4RspM0Uf8dN0fd
 ZE0H6Axam2TxAPDT/gc/gKog1kOUnu+skHjn+ZADI4QTzEQKhwxuyIWZTomW6vzh/CTZgOMtA8q
 YGowDPAGqqkaFSib/4a1tuVEWeXpyolkOB9HrdFm0vA==
X-Gm-Gg: ATEYQzwkAizUGMcLBhN60peydd1D5JwR32AxSgKpMNNyaw3eZMpwlw8zJeHbmcisBWf
 fjCaZFHLTBNnEimnQONgqBYlUy5LdpiZ4Nq9xijgApyfCpxsBOJLq+geXHj0VEYdO2bZusZxXMI
 kRfIEMlZYHdFOSRZgIzZIUnugBTTYVNemLA5qmFTZJDaQ6kHJZI1uNji3HmKY7D2yN2xvhj4MYu
 yUL1AVr+cIyvEyvOyI/DTddwgGnPwDGI3vBPM+v/GMGcRuL4ss5J5PbC3bmYWwI2Vk1kh8grVp3
 vaIdL6A5TYTNSQlP7pBsoBpFd6xvYZ68TwZsN0V8WaqyKR0sR4Hkwg==
X-Received: by 2002:a05:7022:6987:b0:12a:67b7:53f8 with SMTP id
 a92af1059eb24-12ab283c72cmr1689856c88.8.1774625989765; Fri, 27 Mar 2026
 08:39:49 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 27 Mar 2026 11:36:30 -0400
X-Gm-Features: AQROBzCyw4C9KLx94qBqf6u0Movki57Gzn7-7O6Np6kftqN1J-5A7q6BR2E0-Bk
Message-ID: <CAJvnSUAtn7mUqkjoPHsEyiZLMe0w4kkg2n9SfB2OL=PR4vozGg@mail.gmail.com>
Subject: Update on per-patch AI code reviews in CI
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>, 
 Aaron Conole <aconole@redhat.com>, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, 
 "O'Driscoll, Tim" <tim.odriscoll@intel.com>
Content-Type: multipart/alternative; boundary="000000000000bab85e064e034f2a"
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

--000000000000bab85e064e034f2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BFHi all. I have enabled per-patchseries Anthropic AI code review re=
ports
(sent to test-report mailing list, available on patchwork) in the UNH CI
system, so you will start seeing those come in for patches in the future
which meet these conditions:

1. Applied cleanly to DPDK
2. Build test succeeded
3. Ran dpdk-test fast tests, and <=3D 3 tests failed
4. Patchseries does not make any modifications to AGENTS.md (protection
against malicious prompt modification in CI)

The reports look like this:
https://mails.dpdk.org/archives/test-report/2026-March/973793.html

A PASS status means the AI code review was able to run and report without
issue. A WARN status means the AI code review could not run (because it
failed the gating conditions explained above).

Aaron Conole came over to UNH yesterday and we went over some additional
features for the automated reviews which the UNH team is working on adding
now. These include:

1. When a gating condition fails and we report a WARN with no report,
indicate in the email which gating condition prevented the report from
running.
2. Instead of emailing 1 AI review report for the entire series (sent to
the last patch in the series on patchwork), parse out the AI review into
smaller chunks (one per patch) and send individual AI review emails to each
patch, including just the comments for that patch.
3. Allow for maintainers to override a WARN AI code review (i.e. force it
to actually run the code review on a series which was skipped) by sending
an override string to the mailing list as a response to the respective
patch.
4. Migrate to using the upstream AGENTS.md (to be merged into DPDK in the
future). Right now we are using our own out of tree AGENTS.md (which Aaron
Conole worked on) until DPDK has its AGENTS.md merged.

--000000000000bab85e064e034f2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=EF=BB=BFHi all. I have enabled per-patchseries Anthropic =
AI code review reports (sent to test-report mailing list, available on patc=
hwork) in the UNH CI system, so you will start seeing those come in for pat=
ches in the future which meet these conditions:<br><br>1. Applied cleanly t=
o DPDK<br>2. Build test succeeded<br>3. Ran dpdk-test fast tests, and &lt;=
=3D 3 tests failed<br>4. Patchseries does not make any modifications to AGE=
NTS.md (protection against malicious prompt modification in CI)<br><br>The =
reports look like this: <a href=3D"https://mails.dpdk.org/archives/test-rep=
ort/2026-March/973793.html">https://mails.dpdk.org/archives/test-report/202=
6-March/973793.html</a><br><br>A PASS status means the AI code review was a=
ble to run and report without issue. A WARN status means the AI code review=
 could not run (because it failed the gating conditions explained above).<b=
r><br>Aaron Conole came over to UNH yesterday and we went over some additio=
nal features for the automated reviews which the UNH team is working on add=
ing now. These include:<br><br>1. When a gating condition fails and we repo=
rt a WARN with no report, indicate in the email which gating condition prev=
ented the report from running.<br>2. Instead of emailing 1 AI review report=
 for the entire series (sent to the last patch in the series on patchwork),=
 parse out the AI review into smaller chunks (one per patch) and send indiv=
idual AI review emails to each patch, including just the comments for that =
patch.<br>3. Allow for maintainers to override a WARN AI code review (i.e. =
force it to actually run the code review on a series which was skipped) by =
sending an override string to the mailing list as a response to the respect=
ive patch.<br>4. Migrate to using the upstream AGENTS.md (to be merged into=
 DPDK in the future). Right now we are using our own out of tree AGENTS.md =
(which Aaron Conole worked on) until DPDK has its AGENTS.md merged.</div>

--000000000000bab85e064e034f2a--
