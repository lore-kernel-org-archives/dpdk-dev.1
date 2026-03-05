Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3665EFCE4D
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 00:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C89EF4029D;
	Thu,  5 Mar 2026 01:04:21 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 008E34027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 01:04:20 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1270adc5121so9362299c88.0
 for <dev@dpdk.org>; Wed, 04 Mar 2026 16:04:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772669060; cv=none;
 d=google.com; s=arc-20240605;
 b=d89NWfDQ40QIhbthw139F7R+YEclTmaXb77a1m69Pw1CAn/hcj2VJqfXhI3nLgNZSU
 TukdMui6KEmJcW3LlMskg6076Sm0WNpnrWUdKvxI5bOhF4zqq/ZqgB+P2pPpglIDCS1P
 8QSIAnCZ2YqqJwq1Dkp+Ic5gQfn3lJMDOHjAgBGbWopMGBXcotzc0ieaHLTc63UWubHa
 MjiXLDMeMUdWi3PQ0famf2l0tZQTCznK5iIYinF7wo9nFGn6y3iAXU0M0ZuZJiI4J3T7
 90zhjp0I7LeiBk2ZsqNtZrvMYcz2yBw+tmiKEgoDkuVI0w0f1CIAfYbyGuuZ1K3cGH9E
 7Cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=KdS5xod89lrNS6TB0D+0tR+vsfPbnqDTbA3/u4FE5mU=;
 fh=GhayERS89y8XlsU0jCunHUZrR1bOebE7jTVoJL+2ldM=;
 b=LyQaPZaKwRAU7AYXQJY8beFJ1R6DiZcBwGtrGUwons4aqrAgCyLnKyvNDf/Q3ghywK
 h1t60E37wIz28ySkC2qwhY3nJRDLqJeKQ1OF/8WF19iPy5+dNuSXruUWSNCwcQ3tt3X0
 ZeoWszfhYr7RR5SMYphPZ0sr8HJpiKtWdakVZWj8qvXYBXagcMsLAQPKzpmQk96BYzLq
 hHdvdD3ASxRtX+M5tlRYBsZmV9+Z14eZpeB+d82+ddLo6Ftj56w5cAAu951CcjCPo9BY
 2ZUKbOtIk73hjYibTFGRWcjDp0EqJQOmFKriZDJ7cIC73pfpHpITNxmCNmYQKOa223Vp
 CB8w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772669060; x=1773273860; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KdS5xod89lrNS6TB0D+0tR+vsfPbnqDTbA3/u4FE5mU=;
 b=VljN5jU7KquTOqIwStaOY36TbUtLn4AW994w7csauBlplLfhZlhlk6Pus2FROH7zLx
 uUvTo3GPmuzSA29Ey+63YzPtZdX4SIPCguAJzU881j201XlLqeoRSO4eSST/qhJliNOM
 nsn+8k+R1mKvtO85j8jZWYAqV0zEaM+nJ4Juc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772669060; x=1773273860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdS5xod89lrNS6TB0D+0tR+vsfPbnqDTbA3/u4FE5mU=;
 b=AVIq/f6q9n/1eEPk+jn7nG7Hd3PZvIvu/MgYCI2q+Pz5zHcOZWuQ2KX2KfyyKZwV2r
 TFV6IED2Dt6XpbcdkiLIrKoYniRZEpNj2vYsTEzXw007Yr5/go7eR5htwrSmyp0MNCNk
 2qHU/FMz+mUqgNcq9ckMWZTUbTPkyCkTOYBXPZSFOQEeHtFNgPfa/pKf65likwFNM3HU
 A8M297BQjP4uvsr67GXjdWPK1yeWDmsmBvKXKL8CqWExtuppiRf91lwwOBzNYcRIlMLR
 5O3Mt1PFyDUIm5DPNXIWBaZUSUPeO2x5uenJUzGVeHMNHfQL6n36G2sB/N0y4+tdyyVm
 pIoQ==
X-Gm-Message-State: AOJu0Yz6r1znI1hxw69YdtqrQnULakdHnCCbyV1DXVSOnQ0Wp8/5F8lJ
 /Urg8rwkxmhOezwc/A7Q4OK/Kaim4yec88X6bbPH+KnwRE2L9zH+p9FVkLfMqS5Uwem+SihZsO0
 zsQNy8E3uDaBTuVrK5Gh891UaqBjdB9QjS1yWqrUJr6btN+COJHX1ddCEFw==
X-Gm-Gg: ATEYQzySpSu8hopItYtk5JY1ZKpiIvKynwnc0Ki1/EDqP3cXRO3prINR2hr7aI4Gj8u
 xBaAmTHS+OCOfmvJdt/oEw+tigmG+z9z1Hkj8R4yaFZFpfDax9NWk7Zq4nK+vmEQ8L8Zpu6h3KC
 iTgtdFwyWp0vqsZ9/8L3g2e0Ro4X+PghRWHxw2pS3ZME6Tz3trv3RE6yzGKy6QsPKA1mHUJcmka
 G4lENNKO7gsmxazXg2OW4dOpdBTuSzSPvgT+HvshwpF/7UlYF9LvDFXzTtEroA7DRqAWky9UNWz
 ii7kK92uUk4UiIjRGSZs7nUivbC+kXBjFHWB5cOirb4lac1jCjjB603uUsoMRu+x7zAWSytp
X-Received: by 2002:a05:7022:92b:b0:119:e56b:989d with SMTP id
 a92af1059eb24-128b7086babmr1686522c88.4.1772669059814; Wed, 04 Mar 2026
 16:04:19 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 4 Mar 2026 19:01:23 -0500
X-Gm-Features: AaiRm53eA9y4kFySouAyKakb2qrdJ3g9iRQDp2rXoSBd8Wg0F2qHZVwG6bMbnLk
Message-ID: <CAJvnSUCXra+Brudn8p8PqDUBKa4U+AhS6B3PYf=mAGP5GrLXsw@mail.gmail.com>
Subject: Community CI Meeting Minutes - February 19, 2026
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

February 19, 2026

Attendees

1. Patrick Robb
2. Aaron Conole
3. Matthew Labrecque

Minutes

General Announcements
* AI Code Review:
   * Andrew has reviewed the python scripting for the anthropic client
   * Patrick is reviewing currently
   * Matt Labrecque and Patrick to meet and run the scripting, produce
a review from Anthropic
   * Current plan is to send the AI reviews to the test-report mailing
list - will be picked up by Patchwork
      * Can tweak later as needed
   * Need to write up the formal =E2=80=9Crule set=E2=80=9D and document th=
at
somewhere. DPDK testing page?
      * UNH Team to send a dpdk-web patch with the rules:
https://core.dpdk.org/testing/
   * The UNH team can start setting up the Jenkins scripting now.
There is no need to wait for Stephen=E2=80=99s scripting to get merged into
DPDK.
* DPDK Stockholm:
   * Stephen and Aaron to give a talk about the AI Code Review
   * Patrick giving a talk about DTS integration into developer
workflow and the new flow offload testsuite
   * 1 week CFP extension
* RC1 was released earlier this week
* CI project on Patchwork:
   * Some patches wer not tagged correctly (accepted, superseded,
deferred, etc.) and Aaron has updated these statuses
   * Aaron also working on some scripting so that when he applies a
patch, the patch status will update at the same time

CI Status

AWS Lab
* None

UNH-IOL Community Lab
* PRs under review for using buildtools/get-meson-version.py for
FreeBSD and Windows pipelines.
   * Let=E2=80=99s do a dry run run of these and check for correct behavior
   * Matt to check in on the powershell version on server 2025 (the
only windows version we test with, as we use only latest)

Intel Lab
* None

Github Actions Robot
* Aaron working on the code coverage automation

Loongson Lab
* None

DTS Improvements & Test Development
* Cryptodev:
   * V3 is out, Patrick to review:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D37360
* The DTS patches which we have merged so far this release were merged to R=
C1
   * Otherwise, RC2 should release March 5. Aiming to have all new
testsuites merged by that time
* Flow Offload:
   * We did an internal review and reached the conclusion that real
world applications will write flow rules that match on 1-2 protocols
for a packet, not more than that. Got a list of =E2=80=9Crealistic=E2=80=9D=
 scenarios
to test for and applying those to the flow offload testsuite. It will
still test a broad set of hundreds of flow rules, but these will be
more targeted towards real use cases.
* Code Coverage Reports: Working on a patch now that adds a config
option that will add the code coverage argument to the meson setup
command.
   * Question: If we start and stop testpmd on the SUT N times during
a testrun, can we have the coverage reports from all of those testpmd
runs be =E2=80=9Cappending=E2=80=9D and provide a total code coverage repor=
t, or will
it produce a large number of reports which we cannot merge together in
a way which is reasonable for humans to read? Need to check this out.

Any other business
   * Next meeting is Mar 5, 2026
