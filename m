Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573DAC61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 14:09:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69F5840150;
	Thu, 27 Aug 2026 16:09:25 +0200 (CEST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by mails.dpdk.org (Postfix) with ESMTP id 5462D4003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 16:09:24 +0200 (CEST)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-836cb2fa1bcso36494597b3.1
 for <dev@dpdk.org>; Thu, 27 Aug 2026 07:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787839763; cv=none;
 d=google.com; s=arc-20260327;
 b=iKqpzbcL3UETXqRlenOM29s/ikv1/EQOO3H69Z2rLN6aQGpfz7C+6Szd+Vets+J0nZ
 0qYkAaoTT0rSLOdnPyP/jJZtIpsaBb2nm66832XuZ6BHWrd+blRlCSLCzX8Cc6yvIy3L
 tAzddclRxcJUphPeLwPnFTbkzjwePH8SQBJG/MZJ7jM629Ls2jt8pnBd7Te11cPqYEAt
 t/xufXo/iSrxZTW0zfsjGaIdyfcGlrOpS70QEY3YuPs82UAC8vteccDGgzSV82tBtxGr
 0SU+gYICB0cLQKcLpm0rqsXZryht/ghWZs73IZ+vGLgUf2YAgJAMGiVJn2NJT8wfxYDn
 +aog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=FPUHVdzP/lBzwUKFDyb7y9gMvePsPEYNcGadt7iBu80=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=F3glEaQABlyW9mFLHCieJzs8w+NFxnYROcFnSxzYjtN/ySLNsq8pJADcKHmb+OLyA+
 +GXzX0mSqyvIvRSc/Y43pztas4g1jL+yMkUQdKaPwkqYn/g66NfjTEP1YexNJ2GMdV28
 La4wbAbxhrwlYWRbayELtWTgZpIM3Uo0Lqu7gSB/htNQqSdDvLFcgdh6snSVnpQzerBP
 6eBP3XdrJBQhxoC9+zj6b+u5C0jDs8kBt8R+ArJUWFT6NATogm1PJ1N8256Dm64KcCot
 iVrvrodV41251MfLk8nVax2PGhWPx5+wOOIH2AWVXIralxihDqhFNl0If7Mqjmo7tES/
 pyQg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1787839763; x=1788444563; darn=dpdk.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FPUHVdzP/lBzwUKFDyb7y9gMvePsPEYNcGadt7iBu80=;
 b=L+7MGO/sApKWl9++NlEKjQdaWhuCE9MgcQ/vj6SGBGIWUancp6rKNP4iiq7pgNKDuW
 D5DlEWuQ6rQgr/f3bVGuL0Jwi/1rLuZ8mFIXD8E2M7lmf1nR2cil0X55HuRegLEJpPIw
 wDr1xSJM5E92MuzW1aJKj9Bq7YfyBNbPttzv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787839763; x=1788444563;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FPUHVdzP/lBzwUKFDyb7y9gMvePsPEYNcGadt7iBu80=;
 b=mZUavQgZ8JPFscy9x5bg6Xbyr+7B0NfvKDrJ2YzT1a9XST2dX96ThI9tHmAyib18AI
 1usReJOouqxWEUJaZLaCJghFTdmvvpLe7ez+iADsO23w3FnlVO37f+VW5Onc/XjPo6Bm
 BFVliMONWD/SygFJ/g8mXF+Djlqu2A6Xb/T6FZipywis0YbeRSXafQQ4dkY/a1HJrxTk
 qIcjreBsUhEs1eLUkNtjVnvK/6Fri96RMIhGQJBdb5nrD49xG/LITy5H+413tp+LnbvD
 +sNWfkYKqsdkr9MMupaIZfRrorDZQ1c8o+0rmcH4qHNcJgCbrq5XcOHyEGjx+2o9/+tY
 f62w==
X-Gm-Message-State: AFuF++le2UiHOui6NcFZHLX4dwPiq14vZV5755zoOcR+3jpwVZFIuDPG
 5+R3ylfl6GnaCvmS8bCP3VBuZuAPzVAYT8LR1N43ogntU/Gl3G77A+boG2+aWKeyA6cC64U0WsK
 P2VAKXYonkC9VxSW8D8JF/hMbmu1kLid0jqF+ZLXFyZnAy121hEKE9zW04w==
X-Gm-Gg: AR+sD11er8THbdDiaQOVGOC1fgOixvKcnlZchv2r9k+QwqlxnNrLcY9t46QKH8X0ZXR
 Lry/37Q/Hv94JN5uRfQkNxOOTBZp7By3gy1Oj/XjybZsnsssyN9w2Y3Mw5K5xwfdr2GcosN6X+I
 TUpH4zMTBoNpez5BUdY83Qxd7QY50W3GOTGYV4KO7Xp1hq3kHI3JvWPInoLQSCaj4AqZyO5IKY2
 IdzxSEm6EOR4St0S/PHm3Qo8CipYfpaWAK/f00ViqXg9HYq/nzK8mT69unxurcDCCDzvJUk5f0G
 B6TJCGOAN14khxN5t6j2+MJa10TNraD7r/kaHgFXOou5Ka/Dlghu8r1nNSalJgiC8PkcbZGH6bT
 k1d99BKMdcnM=
X-Received: by 2002:a05:690c:7091:b0:845:a433:c337 with SMTP id
 00721157ae682-8573d78d6f9mr75971997b3.0.1787839763354; Thu, 27 Aug 2026
 07:09:23 -0700 (PDT)
MIME-Version: 1.0
From: Dillon Ladd <dladd@iol.unh.edu>
Date: Thu, 27 Aug 2026 10:08:47 -0400
X-Gm-Features: AcwNN1XsSPqJeaDQKxMgJL6LqliJU1NXsVQh880X89z5cxL5F35HqWgi6HKo8UM
Message-ID: <CAJA6v3xoq00oVzr1cJoM6zdYwNc5eN1Ane1-r0TvQ-rTaX488A@mail.gmail.com>
Subject: August 27, 2026 DTS Working Group Meeting Notes
To: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Lincoln Lavoie, UNH-IOL
Dillon Ladd, UNH-IOL
Andrew Bailey, UNH-IOL
Koushik Bhargav Nimoji, UNH-IOL

General Discussions
==============================================
Patrick is reaching out to Thomas about the code coverage patch being
merged to main.

Patch Discussions
==============================================
[v7] dts: refactor flow suite with generator pattern
https://patches.dpdk.org/project/dpdk/patch/20260811170433.517663-1-abailey@iol.unh.edu/
Pending Review

[v1] dts: add PVVP case to virtio suite
https://patches.dpdk.org/project/dpdk/patch/20260811171235.519323-1-abailey@iol.unh.edu/
Pending Review

dts: update verbose output regex for VXLAN packets
https://patches.dpdk.org/project/dpdk/list/?series=38925
Pending Review

[v1] dts: update configuration for performance test
https://patchwork.dpdk.org/project/dpdk/patch/20260805153658.345207-1-abailey@iol.unh.edu/
Pending review

DTS: Rebase from Dean (API updates)
https://patches.dpdk.org/project/dpdk/list/?series=38902&state=%2A&archive=both
Reviewed by Luca, needs some adjustments.

[v1] dts: fix TRex packet stream handling for line rate testing
https://patches.dpdk.org/project/dpdk/patch/20260805192732.464422-1-dladd@iol.unh.edu/
Merged

[v1] dts: remove crypto test type
https://patches.dpdk.org/project/dpdk/patch/20260806164505.642928-1-abailey@iol.unh.edu/
Pending Review

[v3,3/3] dts: add verify coverage for cryptodev testing
https://patches.dpdk.org/project/dpdk/list/?series=38682
Pending Review

[RFC] dts: restore unbinded ports to initial state
https://patches.dpdk.org/project/dpdk/patch/20260812194428.296334-1-knimoji@iol.unh.edu/
Pending Review

[RFC] dts: resolve trex driver binding issue
https://patches.dpdk.org/project/dpdk/patch/20260811185509.1650102-1-knimoji@iol.unh.edu/
Prioritize review, sizable change of DTS and it would be helpful for
Koushik to have feedback sooner opposed to later.

26.11 DTS Roadmap
==============================================
26.11 Roadmap Document:
https://docs.google.com/document/d/12ZR59qHriYcdCINc7r-jLv0TxYyZXEChxqZiIH5ozSs/edit?usp=sharing

Andrew has recently finished extending cryptodev to allow for
configuration of algorithms and amount of operations, this patch will
be out soon.

We got the go-ahead from Thomas to work on porting over the following
test suites:
eventdev_pipeline_perf
pvp_multi_paths_virtio_single_core_performance
pvp_multi_paths_vhost_single_core_performance

Any other business
==============================================
Next Meeting: September 10, 2026
