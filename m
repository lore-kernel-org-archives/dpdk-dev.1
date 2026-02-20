Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB23C56201
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 15:40:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47470402E2;
	Fri, 20 Feb 2026 16:40:53 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 7597A4027B
 for <dev@dpdk.org>; Fri, 20 Feb 2026 16:40:52 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso19112605e9.2
 for <dev@dpdk.org>; Fri, 20 Feb 2026 07:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771602052; x=1772206852; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RmuIc4HVGEYDws3/fZXw4SNVYLKFh3eHnUckWn16HMU=;
 b=ITmIHspeuoD8lfHlcDLWLRh99WthyFJ0vpPVdXOz9s5/04US7czYyejdVsxSzLJR6V
 Z2UjUGTh1Ah09Cs9qy4m4qNB2Pxkf0ngzceQumOJzFySh1XqFDw8t1KVhk0ZQH6yRTRT
 IGAhMKXDnaSAEhE6aUhAUY4eAVM91FUt5h8Hk2JRuyLmZm+th9Qor4Qzcu4j2LQW5yY9
 eBoPekjhDpWy/pqBA18W/PBaHGK9H+I7HatGlgJhPyFhkN2tuYP7S4myWFXH6NLi/v7H
 ZogcmPfDtJ9ylCUUZycDkivqCnMbrg91A7UiSmEnRKNtzmv7UDHRo8NBF3DzJo7QfiqR
 8rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771602052; x=1772206852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmuIc4HVGEYDws3/fZXw4SNVYLKFh3eHnUckWn16HMU=;
 b=IePoQ2zzARJXY4MI7h+WIiUO9MZa0o1Wcc+oPyhh9Yb6ldHIMX4x+Q7MBzAy5+nbdg
 OIOEKdsjm9RtN50g13MoL3Dt3PLcoqXmZGxAy3fHGjUMYZi6WEWOlrQePF9CAzpIYGHu
 pYF1F1DGtayokX0ifelzLfGotANwZT2LHhPvYxZjcbyE6EGmaC7k9uT2L7ATf3WtGk1E
 NPutMMcPyprv2sB/xmy1Gq2yJbJyxZ+k0iOqrXHopOoJN+fo70i3UzwU/TbG1xANatla
 OB84Wd785bIhC7uFMBaSpx53a0HWTDkFY8hw/ZtO4qsUHJxgyVIEz07j3eENhTRKJgHh
 4x6A==
X-Gm-Message-State: AOJu0Ywh9edsBcawBVDCDlESQ9rrgsC+YHDNFRfpxzpHIgqnOtwR9stJ
 rfMoBLBHIl2Me0cVcs50IfqTsL7RWZnOAIJjZ63uZfe5TkxMXB3iJn0dTMxSInuo
X-Gm-Gg: AZuq6aIYdkkEwOfl+r9pfQjULUQQxOJ2Rc7p4mblrUxtzMlFsNlIlcUGMUX2lGsMds2
 UCUXf/l94YRUUbj1bx2/MOxvP26kQjjOt1jYKSfonpqCuaM3cj3NI1B5N74axsGKMY2cKh1rd+b
 2quoBbkvWjSYJ0v0UmkU1bTrp0CeX4/wSGaIXHmZ4zGK866EEmKzYZHRyRZIk2DYvDaZJtzFwuc
 YVY7MbabFqi+GmSd9D5b/g0p8Y22rWR+9xDIJxe80W00RCu8s4HnEa7yJYa8Vhh4urfRJeyvvtU
 BDBrpjpOb8qaWPo6mFegtraFqldLgJi2Uyt30nTC9X1fMAf+LnY9pAZBcqlvWAPKkS1oI1UFaxO
 eHvWb5851wqhqgECvDNtN4on1K6cWMTk0657WWjahhna1080vO7Y6yyRqP7UQBU6wf2daBSWyJJ
 3PnLeMBuig+NWU50jmbMhh1BU4OXyz
X-Received: by 2002:a05:600c:828c:b0:480:39ad:3b7c with SMTP id
 5b1f17b1804b1-483a541db0fmr46001115e9.16.1771602051711; 
 Fri, 20 Feb 2026 07:40:51 -0800 (PST)
Received: from localhost ([2a01:4b00:d036:ae00:94d5:cf43:9418:cadf])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-483a31b1d79sm143890965e9.3.2026.02.20.07.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 07:40:51 -0800 (PST)
From: luca.boccassi@gmail.com
To: dpdk <dev@dpdk.org>
Cc: dpdk stable <stable@dpdk.org>
Subject: please help backporting some patches to stable release 24.11.5
Date: Fri, 20 Feb 2026 15:40:42 +0000
Message-ID: <20260220154044.1704312-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi commit authors (and maintainers),

Despite being selected by the DPDK maintenance tool ./devtools/git-log-fixes.sh
I didn't apply following commits from DPDK main to 24.11
stable branch, as conflicts or build errors occur.

Can authors check your patches in the following list and either:
    - Backport your patches to the 24.11 branch, or
    - Indicate that the patch should not be backported

Please do either of the above by 02/27/26.

You can find the a temporary work-in-progress branch of the coming 24.11.5
release at:
    https://github.com/bluca/dpdk-stable
It is recommended to backport on top of that to minimize further conflicts or
misunderstandings.

Some notes on stable backports:

A backport should contain a reference to the DPDK main branch commit
in it's commit message in the following fashion:
    [ upstream commit <commit's dpdk main branch SHA-1 checksum> ]

For example:
    https://git.dpdk.org/dpdk-stable/commit/?h=18.11&id=d90e6ae6f936ecdc2fd3811ff9f26aec7f3c06eb

When sending the backported patch, please indicate the target branch in the
subject line, as we have multiple branches, for example:
    [PATCH 24.11] foo/bar: fix baz

With git format-patch, this can be achieved by appending the parameter:
    --subject-prefix='PATCH 24.11'

Send the backported patch to "stable@dpdk.org" but not "dev@dpdk.org".

FYI, branch 24.11 is located at tree:
   https://git.dpdk.org/dpdk-stable

Thanks.

Luca Boccassi

---
f82b3ed6ab  Anatoly Burakov  net/ixgbe: fix pointer handling in IPsec
ab797d5bcf  Bruce Richardson dma/idxd: mark portal pointer as volatile
77bb34e047  Ivan Malov       net/sfc: avoid speed reset when setting FEC in started state
e0f92e31f7  Kishore Padmanabha net/bnxt: fix statistics for high number of queues
bd2f563dbd  Rahul Bhansali   common/cnxk: fix duplicated branches
2e79349dcd  Song Yoong Siang net/e1000: fix igc launch time calculation
