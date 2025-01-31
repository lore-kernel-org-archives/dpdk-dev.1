Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E976C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 19:38:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E0B7400EF;
	Fri, 31 Jan 2025 20:38:13 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5C5A3400D7
 for <dev@dpdk.org>; Fri, 31 Jan 2025 20:38:11 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4677fcf112aso2782481cf.2
 for <dev@dpdk.org>; Fri, 31 Jan 2025 11:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738352290; x=1738957090; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/xAynTIJ966HHukwdQGNYXM+SpAOK3AfzNZbHQ5LLJw=;
 b=N/1EuiFXSzuhsbXOz521l+UV1q7zEmQ/C41YFaHhSeXuKxbCVHvnvm6bRx87UceHsW
 ToTcmSOd0hX4sH0nfQKo3x9bMrEZT7yvtqNa3gNJ4eb8cBdncpz7Ug4WsEDfjx1o+OWu
 poY9FqM4MfyrvuxZB9AyYXMMstqzgdsJQmsSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738352290; x=1738957090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/xAynTIJ966HHukwdQGNYXM+SpAOK3AfzNZbHQ5LLJw=;
 b=wQCi5TLjk672Wg0jzgGGAzZHmzDBqkPHzd+2vQktX17euSJKfCpzJ9JXFDuAUNWV6R
 TMh+vtz8mvi5TN2PoSSoGR33ScN4igkzDow6WGJUiZUl4O9xRc/qXjZ/Ldv1XZxyvFLC
 59OEzJxJ9xj10UiuuHISnZJI1m/Pq/peNeO3U8EX8sZUTgpPz3ZGPHOYRX8ZZYvxHgZe
 buzimgTeCu8u2SpbEAltEDZ36uf/c/HQbXakHn2bubn7DduNE4kQQ6zW8GolnuV7wOC4
 41bDCoRLCltaWvxAHvmggdSJNaJlZu8XoeQRz/ao92SP6mV25PKCFlxPQjeHfRo90+uw
 89bQ==
X-Gm-Message-State: AOJu0Yxohcuhg5MsszMoV8e2Q2wxmpRZISnitziSvpyFB1+OxBxYnJQY
 WL9yfQ3Lu121nsgY7nfqiS5EzbglNMIaK8rvPQrTrAOGXKLZDBvUSiSOyOehOQg=
X-Gm-Gg: ASbGncshN1WeRnpi72/Lgx+nLD+I6Q+eRAsabLybBGXb9gjJEOQb+XbEkLFhpvcTk8h
 5tRoB36XXOPrAyoQRfKWlFWrqonk96rF2Q7dU23LVerWoT1BcsCez2dSMR4hJZNegUD389mzCWm
 mNYrbXMwCXAieGUUtovqkIKJpFb2j5OvfeYoRAo6lEtdjZ8HeQ5ypjmSc4KIsLy22IvPNMkWjk+
 AG7pwmSS3pZzWVWZRGa1xVaURPsW9eN+brssNGCds0QCK3NRO3DHM2KWyCrAPDbaYw/RtfRVf2i
 575DXZ4AhmMBySQtCE25KMFHz0mg/UfAXE9BteJfTktgc1NbDetXx36u
X-Google-Smtp-Source: AGHT+IGpiZCYMW5lGeTAK5Ydk3kh+xnmnb92NkvAYn3r4amMGV4VP75ZCy2JYLHFhX94spgFSygciA==
X-Received: by 2002:a05:622a:13c6:b0:467:54b3:26f9 with SMTP id
 d75a77b69052e-46fdda31e17mr46199571cf.5.1738352289538; 
 Fri, 31 Jan 2025 11:38:09 -0800 (PST)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf18a67dsm20743411cf.72.2025.01.31.11.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 11:38:08 -0800 (PST)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: yoan.picchi@foss.arm.com, thomas@monjalon.net, luca.vizzarro@arm.com,
 probb@iol.unh.edu, Honnappa.Nagarahalli@arm.com,
 stephen@networkplumber.org, paul.szczepanek@arm.com, dmarx@iol.unh.edu,
 thomas.wilks@arm.com, ian.stokes@intel.com
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [PATCH 0/2] remove 'requires_forwarding_restart' from framework
Date: Fri, 31 Jan 2025 14:38:01 -0500
Message-ID: <20250131193803.168498-1-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
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

While I initially thought that this would improve the cleanliness of
future test suite writing, because of the various nuances of each
testpmd run-time command, having the framework managing forwarding when
needed introduces far too many additional challenges, such that, it
simply is not worth the time implementing this.

Arguably, it also makes sense to have these mechanics (such as
forwarding restarts) written explicitly within the test suites.

Thank you Luca for pointing out this issue and its potential
side-effects.

Nicholas Pratte (2):
  dts: remove 'requires_forwarding_restart' from framework
  dts: rework run-time MTU adjustment test case

 dts/framework/remote_session/testpmd_shell.py | 26 +------------------
 dts/tests/TestSuite_mtu.py                    |  8 +++++-
 2 files changed, 8 insertions(+), 26 deletions(-)

-- 
2.47.1

