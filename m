Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CCCC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:51:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AB1E4067A;
	Thu, 10 Sep 2026 15:51:15 +0200 (CEST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5A25840274
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:51:14 +0200 (CEST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-8623b1e7cb2so53330307b3.1
 for <dev@dpdk.org>; Thu, 10 Sep 2026 06:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789048273; cv=none;
 d=google.com; s=arc-20260327;
 b=I0tqNfRCeWJR732LTFeOQ51hNvUnaHuAhYrw3zPM5ovljvwogHK901XQSETojIZKwA
 0p3+YeEH3GIp3NczFLweM8BWSYjtf1veuRgqd42vWsf2cvhU3pjobolux1CVhr40Qdj/
 AHjSG6QLsF+5A2x0BLhYxTsIooKlAiflWTBV3sYUaxGQtD1G9IckyryUWDUYxtgmIrEn
 HeRZihJCw6jsBVG0Ft6YrAeQNd3XBHrCcibrfDGgYN6u3ZBPpjhciNEjNfNBHvYMwAOR
 GIhYvIhgBDRKWbW1iL0wzLWNzeScgI5RnHdsTrqOzw3jm9JKo8t1zPMxTh4QA9qNtmG9
 c0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=ZsBfhYyZlDDTDZBjCqep+9FsMazELPc6BCaixZ6Hq6c=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=ShDy2wiNRKmeJKWAN3zcdq7uZ2gSe3jZ3inQsNuOJqelDYoWX1Gjx16Wc4kF+KKYev
 91UBB7k2JiJd9ncyqPhiliJ19NZwAtVViwf5r4weUu3DHwjU1ythTR0tPvINiFPyRGG9
 MfxxmVhm0DXfQL2hAE//FPlaH6/OnZDHvq40YcMuVUCJmRyyfxHRzsjIvaBpVuGm1aXm
 XsyJRZ9ciVzH0RNNPpNdFyB0/344xQKHh4LsIxqsbKgd9Xl/okF+qFsk0VOLqeGoJBhj
 aO08kVm2hXgz8GrEZWVpbbdnwMvpGSxuduTrwSYKYxTtCUE5VccklroxtGO3PqONIDlS
 jjIw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1789048273; x=1789653073; darn=dpdk.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZsBfhYyZlDDTDZBjCqep+9FsMazELPc6BCaixZ6Hq6c=;
 b=FSeWlB3kudbNuYsml8gbLVU3bf7n4RfQi2bK86enzEQGeHec7aiCj3FqgGU2Mz2aZb
 SEMJVSSDoXbD8lwDDJE2iu1LnyupnAY7p/3wQLPS7dEaiFGpORLllJ8hIbYyLNkdN7Ft
 cV0cOOcKFt/VCHdyXDpuRGSgAbUDhxA8OF9yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789048273; x=1789653073;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZsBfhYyZlDDTDZBjCqep+9FsMazELPc6BCaixZ6Hq6c=;
 b=K6ZYUAnerLNHI63qEbHL4yEjnNzaDo4G+VR9Ub1HdYtHepCaubTHmm8tSZVFDd+hqm
 8vmrqq85zOFHu5OnbZ/lkpH6+1g0xIcx622+cFhvTmIEcLFOWr5vumHosGF+CMMawNmV
 bw4gvCL8FIcB5Z0pd+mO6UigoQF2GXpRDMcpawJ+ehRJkLC/2+n/KmI12Ogog3UlZ4oC
 zNCwp/DibQ2j9fbsrfeShY5VL2B6OgaI5sPE1KcLXpWXXd9ctaR2O8d8q2XPD/z1IuJY
 F9C2vncP5hbTOg8Tcbz68QcCv0IX18F4bWL/D71MzQOcViSc9+NDR/qutNcoQDzbWvrV
 1HSA==
X-Gm-Message-State: AFuF++mUYXLUK9i0Mhk14crgfUz7byXBnVE7hnxK2FmDIC3M4G6aJarY
 kHz77MsoYLILT2Fq37+iA8JcdIPjjf+OqjaNmHC5NMROzwuo0Vz/xrQFTsrqx5SC46hNlGoFt+L
 tmiLZcj+qH4xmUR5Sas0oiDcnY661bvfFaRR+2vrMPJCmgNEnudc4gwk=
X-Gm-Gg: AYBFou0FPhnInhhScgD6Av5iWg1OgfKaCNB0zTZf1/sVFpXYycb+b/YBSGOFr6CYHbP
 2J4W21e2KbeptM5u+pvHUu52R4MLg/ckp9tk/2xnKklA5+3u56w9+lOygzXZK6uaHjnTtV1YJyj
 bteKH68CRdBosHBmOBEoXzcaCC1+GKF0Hjs+1lesXXw9RFUvJZCpSQ/tobXAIwoVleXNt1CYGaj
 BsT4VUkMrk9N/nuJSVQa8djV6POqaAXA0tELn4vXODZznE+ay4FziwQ4D3dbKRYt5vyoa2T5qyB
 q1RQQzYZuA2OvWU6WQ/0ILPD+tw6udx4G7XpLwbU4BssCXPjr6kYeN+H5IozOJyTpDlhbzKY/ad
 vhABz/QksXVDyrQ==
X-Received: by 2002:a05:690c:f04:b0:84a:ffa1:8118 with SMTP id
 00721157ae682-871288defc1mr162792237b3.31.1789048273297; Thu, 10 Sep 2026
 06:51:13 -0700 (PDT)
MIME-Version: 1.0
From: Dillon Ladd <dladd@iol.unh.edu>
Date: Thu, 10 Sep 2026 09:50:37 -0400
X-Gm-Features: AcwNN1Xzha4tFmIOMFSlFCjWBBO34rlqvSlzt6xUZ5YAtTjWM5tqyh-bHKdJLcU
Message-ID: <CAJA6v3xSCDiPKgWq5dmDnbQ+YJQbjsS7kcnJa-U1qt_VV667HA@mail.gmail.com>
Subject: September 10, 2026 DTS Working Group Meeting Notes
To: dev@dpdk.org
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

Attendees
################################################
Dillon Ladd, UNH-IOL
Koushik Bhargav Nimoji, UNH-IOL

General Discussions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patrick reached out to Thomas asking to merge code coverage into main
early, waiting on a response.

Patch Discussions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Andrew put together a list of patches ranked by priority for review:

DTS Framework:
---------------------------------------------------------------------------=
-----
1. DTS: Rebase from Dean (API updates)
https://patches.dpdk.org/project/dpdk/list/?series=3D39153
Andrew has made adjustments from Luca=E2=80=99s feedback, pending review.
2. [RFC] dts: resolve trex driver binding issue
https://patches.dpdk.org/project/dpdk/patch/20260811185509.1650102-1-knimoj=
i@iol.unh.edu/
Prioritize review, sizable change of DTS and it would be helpful for
Koushik to have feedback sooner opposed to later.

New Suites:
---------------------------------------------------------------------------=
-----
3. [v3,3/3] dts: add verify coverage for cryptodev testing
https://patches.dpdk.org/project/dpdk/list/?series=3D38682
Pending Review
4. [v2] dts: add pvp multi paths vhost performance testsuite
https://patches.dpdk.org/project/dpdk/patch/20260908144707.862960-1-knimoji=
@iol.unh.edu/
Pending Review
5. [v1] dts: add pvp multi paths virtio performance testsuite
https://patches.dpdk.org/project/dpdk/patch/20260903201155.817724-1-knimoji=
@iol.unh.edu/
Pending Review

Test Suite Extensions:
---------------------------------------------------------------------------=
-----
6. [v1] dts: refactor cryptodev throughput test suite
https://patchwork.dpdk.org/project/dpdk/patch/20260827172208.139769-1-abail=
ey@iol.unh.edu/
Pending Review
7. [v1] dts: update configuration for performance test
https://patchwork.dpdk.org/project/dpdk/patch/20260805153658.345207-1-abail=
ey@iol.unh.edu/
Pending review
8. [v1] dts: add PVVP case to virtio suite
https://patches.dpdk.org/project/dpdk/patch/20260811171235.519323-1-abailey=
@iol.unh.edu/
Pending Review
9. [v7] dts: refactor flow suite with generator pattern
https://patches.dpdk.org/project/dpdk/patch/20260811170433.517663-1-abailey=
@iol.unh.edu/
Pending Review

Bug fixes:
---------------------------------------------------------------------------=
-----
10. [RFC] dts: restore unbinded ports to initial state
https://patches.dpdk.org/project/dpdk/patch/20260812194428.296334-1-knimoji=
@iol.unh.edu/
Pending Review
11. [v1] dts: remove crypto test type
https://patches.dpdk.org/project/dpdk/patch/20260806164505.642928-1-abailey=
@iol.unh.edu/
Pending Review
12. dts: update verbose output regex for VXLAN packets
https://patches.dpdk.org/project/dpdk/list/?series=3D38925
Pending Review

26.11 DTS Roadmap
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Finalized roadmap is out:
https://mails.dpdk.org/archives/dev/2026-September/345096.html

Any other business
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Next Meeting: September 24, 2026
--=20
Dillon Ladd
Technical Manager, Open Source
21 Madbury Rd., Ste. 100, Durham, NH 03824
dladd@iol.unh.edu
https://www.iol.unh.edu
