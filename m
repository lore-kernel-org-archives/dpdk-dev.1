Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555CA10A62C4
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 13:00:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C58D42D8C;
	Thu, 26 Mar 2026 14:00:08 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 3790C4026A
 for <dev@dpdk.org>; Thu, 26 Mar 2026 14:00:06 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-486fda2a389so7575575e9.1
 for <dev@dpdk.org>; Thu, 26 Mar 2026 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774530005; x=1775134805; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8/w1U32pOrGTUunWGxr35O+qN+48SNmimWkvj6UdKic=;
 b=k/FHiUTedvYMjVwv3TXrUdyO2hammz6yHBm4eB65Po5516J7kcA2dc4JCBGqcfmoxy
 H65i5ZUrm43qfDpU0JVqNWyxj1ViIxNDx4YCnt4OHTCdEA7A8LbR27MPW14eDCioq/ax
 prlN4x7O4vCqJxhCIYZ+KI6zkykZEw1frUYfF5vZv6/LGIEEzOHzjgzeC5bTdjm/01Ju
 BMuWLVihD++y+WGcx5i6HG5XxugjBxtkX4B1exxSiU3NGTzmVRNa5Y/ewQAC7wim99eN
 MIUbUJAodh0MWwH3Bw2gDsBN65PUcY7trA1umiZ5oNw3ndFF4f6S0dHGVbztdifFKcOd
 10LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774530005; x=1775134805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/w1U32pOrGTUunWGxr35O+qN+48SNmimWkvj6UdKic=;
 b=k6Yoa9l28ymW0OVuIUBy0LwFhuPnB3rnoqbY/Y1HDdwq3dPUn1YHdJYKleRPGWjjKZ
 Wg3sKJUPlsPAF+WWlnp3szhAsVZruHq+iMILoERfcJseWr+Rjo1QRFq6tEAMi6O07dAe
 +/DOrlLqPYGXkeTgbfn0HfnLnTQs3gvdpAOmaT+bDsBYmwv41Y0vdRYbufQD01FdkIVQ
 1UsvtFRzKklg1u/wUVZOZuCsDvtcCgG7PDaxN+Hp1P79aaTvQU2oeiSvAPGUAFQgT1DL
 UZv5VfF1FccMPC9J0pNo+wjT1cxCq6Zz5leGQ8qqxtzx8k+g0no2knpH3jgDuxVqvtqW
 c0fQ==
X-Gm-Message-State: AOJu0Yxe6egac7a64Y58mq6s4XQgOWRomIJKpIXfm26CbkdV06ijmhIJ
 WgUOqL276z/ZB9a/1dgaulRZcvJlf3OYqSfAUi/JvsRuSN3VzJjK367NQQzB0A==
X-Gm-Gg: ATEYQzxdgntTLfy/g1fdEZIn+BivQ5PEiBE8lPSc/3K9GAQzAtrKBlYEwVxLhvaG67Y
 BQ+Z+YPM+jQGmPPGE0R1OXLied4S8RH7cMa434qG/SKGzOf2e9C+vbAvr7qDVK6kRe8muKE8GHL
 h/M4xL5dO9aZ2q0nj23ciWuImyRMYIfcs4F3d2s858oPb+3XmkpjDrEXh56AayGX1KMoz5GCuQ7
 6nhzYzt/Uj4KIjWwh87MEOEIMuQv9nOj+D/SwPhUzfOHrqVci0MeQMkfzrZWngbGv0D93aJdl6J
 6MpPkdCgDo0kukZX4PRKwcCMU8jsDbiaXLTWgAF4PfRU/Q5TJbsjHSJ0+hL763bv6d73SkzZ2zf
 /mGZXLxxk/1XBI0Q2lm1iFaIOaHpwU2Fv3Vy4awMrNz0mvxmukDG06uN4sas5qXGklNz1MxlDCS
 W29V6ad1+IkqKmSdGFrxLRUBuzaiXH
X-Received: by 2002:a05:600c:4e41:b0:483:703e:4ad9 with SMTP id
 5b1f17b1804b1-4871605644fmr108783775e9.19.1774530005324; 
 Thu, 26 Mar 2026 06:00:05 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:184e:f28c:b6ff:a0cb])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-48722fa8dc6sm53989955e9.1.2026.03.26.06.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 06:00:04 -0700 (PDT)
From: luca.boccassi@gmail.com
To: dpdk <dev@dpdk.org>
Cc: dpdk stable <stable@dpdk.org>, Andrew Bailey <abailey@iol.unh.edu>,
 =?UTF-8?q?Juraj=20Linke=C5=A1?= <juraj.linkes@pantheon.tech>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>,
 Vipin Varghese <vipin.varghese@amd.com>
Subject: please help backporting some patches to stable release 24.11.5
Date: Thu, 26 Mar 2026 12:59:58 +0000
Message-ID: <20260326130000.2254853-1-luca.boccassi@gmail.com>
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

Please do either of the above by 2026/04/01.

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
874312e261  Patrick Robb     dts: avoid resources conflict on quick stop/start
bc15a33eee  Vipin Varghese   doc: update AMD EPYC guide
