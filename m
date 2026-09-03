Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06DCC61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:30:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32DC8427CC;
	Thu,  3 Sep 2026 16:30:17 +0200 (CEST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by mails.dpdk.org (Postfix) with ESMTP id C2E34402D8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 16:30:15 +0200 (CEST)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-836c8bde2dcso27238027b3.0
 for <dev@dpdk.org>; Thu, 03 Sep 2026 07:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788445815; cv=none;
 d=google.com; s=arc-20260327;
 b=SaIoDq/A9DOCTN6h45GGYfuzvyMzQf2JgGfqVyVR7aIudNn0BJ7imQBb9nEBrY5ivF
 WJ6PJqucVpVlxoYyGx6lR+AlsTEO8RQfmf5FjGWr4RSDiFtdU4tfjM9Hf+7aaJrSOZpQ
 Xl5qX5zqr4bRsgqk31GRAsDbqhGjXNNEXoVaRch+Bp4rFDfUOwMZ/Cnwnhy+swK/FyvC
 Z4GCn6hauXppwQXbuAfPFeORKuQrD9TuACNjzRcpvlACeNZxq2U4ngJwIziFTMnnJSq2
 +Y2ZlDVELrFlxiIa+IGrThihAm9g5e3U308EuwTbY85BXzm7N262qoRwxuZojYhq+wlM
 vAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=K0DEyJFZVBzzmuphu2OqJmGQhU9EXvE7CYubg1ewd2E=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=U7VB26vEM9/YKABVDCty09mGwybmwB49ce2eTjjWfcKxTJJ4VEZrZ3tkiawqcZnlcv
 5NInAClkq0nE5F94uX0v+BXaeVUGFkgxayWt+gRarGhP2ildZpxej0ullX5d1PouTqJ9
 svEi4KTED2wUwdcT5ZRRLn86CGB2M1/PuqAug+/lIyd2sE7v91JLWadL+p4vFxYFaqQr
 iM4LnHGzlO472955dPe4nTArs4Wm3F007xnrYx7P6+9kMQFpkC+38QlaoA8KMo3eWsgN
 ubxOCrYS2REy0EiBuzCW853KwYJdviBiAgLd1Cd7/hj6kpwUbtfGCw9ivJlfq7WVrNPa
 4dUw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788445815; x=1789050615; darn=dpdk.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K0DEyJFZVBzzmuphu2OqJmGQhU9EXvE7CYubg1ewd2E=;
 b=X4NkxlkS5WJO6tShJdn469z7hpFnH5CtpiafsMpgZ7k8KMfxs4ARzW1rBrVgpAsuNJ
 uDqcN4rV020I2HF5hzgYcqve7+mgSBd173Y2A3FHVcXwwJI2pVNW0Xmy7sXCwuOjuhC+
 1sHnMwlI0rhi4VGr171jMJt1DVSLFerlv9tZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445815; x=1789050615;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K0DEyJFZVBzzmuphu2OqJmGQhU9EXvE7CYubg1ewd2E=;
 b=qlaYvXuSU8e4/vb+e0UapjT975Gmx/VaBvfe0UeETpRWFLHE4KFAKiYH+HLGN225eZ
 MC668yodArZ9uxAcgxQ9TEztyINJM99gsBQfsdDFAGJDD37as/2rc3gT6rSb9VdkSYSb
 qQCSVWiNRXTA8RqLYgK7diFNWMKZcoy9F7rBYJG8VBMTaTY/xnuuVvyoTn0mSDpSIObr
 OYWONQ+HnrzX7pYGjwxBxw1U3EVBSKs0weVE0tjgJ0/zpKYysdSPBzhnZbJaODMdvtwG
 04b1xvlvmZmJfTz0GVcmEW44JokR636dBL0s6EFWxqU3pAduNoWzXnukmUF1jmnyviSg
 w0bQ==
X-Gm-Message-State: AFuF++k4MhhTl5FDH0JiZwzLYHxrk8xwRUoA2HbBwpPZrp5e7Y88V+yD
 5uHwAMGZ5jQqheBszqyK9sF1X2QoRHZJtszflRAk9clZGFk+9WUmzl8VfFfnNKIy/sx3ddb8xQ9
 KTKPUIRd1Jtfq7tucUnH1YDla0QMRh2XmF0dqtNllnwbBYXhn87xk6So=
X-Gm-Gg: AYBFou3qxuWLyiuNKN2j04zl1w9HV3+xqIPLnRoKJ8pD87XMPY8pqVR2pNbD8h4QtnP
 j3YGjDGSOzaUjkO4Gy+8VyK32loOCIgIwcahT082k0I8J++pdqYajT126SO5OcUly95Qdxi2g0z
 M8xA4YXGjN0/YgQpwQgtQpEjlkrh9lzNeBnoXf5u81NXSN6UGT+EyFM/UpdOJopmWsz+MX6/LbV
 fMFpmmZ/JjapUk3f7SZguU/2YgRxQWDznjBTscb1THzvQZZeoh7pbR+UUls7Q0RvqYyWtEUua3s
 VBFRaTZ/MnR4LHTvthvurSIL3GcY27VKJwud8Mx6QaM435YDQNQm7ZucQda2Obcv
X-Received: by 2002:a05:690c:660a:b0:836:3dfb:dd0e with SMTP id
 00721157ae682-86c4ee9be75mr71205937b3.11.1788445810012; Thu, 03 Sep 2026
 07:30:10 -0700 (PDT)
MIME-Version: 1.0
From: Dillon Ladd <dladd@iol.unh.edu>
Date: Thu, 3 Sep 2026 10:29:33 -0400
X-Gm-Features: AcwNN1UgP9Ucprlhd_TV1_q1N7jaE0raVOCpOxX12gQMgJSHNmhvY-ioxCoFiLY
Message-ID: <CAJA6v3zzAOMT8O66PoYc=wtqsks1hK9SpX0M+ifv1TFEGSfbOg@mail.gmail.com>
Subject: DPDK 26.11 DTS Roadmap
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

Here are the roadmap items for the 26.11 release:

1. Allow setting per-packet-size pass / fail performance metrics / tolerance.
2. Port eventdev_pipeline_perf testsuite from old DTS
3. Port pvp_multi_paths_virtio_single_core_performance testsuite from old DTS
4. Port pvp_multi_paths_vhost_single_core_performance testsuite from old DTS
5. Extend algorithm coverage for cryptodev testing
6. Add PVVP case to virtio test suite
7. Bugzilla Items:
     a) Remove crypto test type decorator: https://bugs.dpdk.org/show_bug.cgi?id
     b) Resolve packet loss on Intelx710 performance tests:
https://bugs.dpdk.org/show_bug.cgi?id=1977
     c) Introduce long term stability testing configuration to
performance tests: https://bugs.dpdk.org/show_bug.cgi?id=1978
     d) Remove framework imports from test suites:
https://bugs.dpdk.org/show_bug.cgi?id=1788
     e) Support functional + performance testing back to back on non
mellanox NICs:https://bugs.dpdk.org/show_bug.cgi?id=1979
     f) Resolve driver bind error: https://bugs.dpdk.org/show_bug.cgi?id=1983
-- 
Dillon Ladd
Technical Manager, Open Source
21 Madbury Rd., Ste. 100, Durham, NH 03824
dladd@iol.unh.edu
https://www.iol.unh.edu
