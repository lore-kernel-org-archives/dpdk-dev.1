Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D50F483DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 18:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F86B40268;
	Mon, 23 Mar 2026 19:11:27 +0100 (CET)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 219624025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 19:11:26 +0100 (CET)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8cd8c6e365eso293363485a.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774289485; x=1774894285; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BACLfmA5sDPiOeD2CL6HB/8hncMmo+krhON/oZNjqeg=;
 b=UHyO5GBNnIMRF6DRkhuA8ZfE0UuDgACXJ5UqSGr0i03dm/TrrZcToG5MfmBPJOWqLb
 k4GvRGLpQJ5WsTE40duGfmvgcjO/wtkERANNztTxesJhvA046Uqs+iOO9gAtCFyNr+mC
 vJTmfoJ3pQ9DGPqjDZpR4w6azhk93ZpyAvzvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774289485; x=1774894285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BACLfmA5sDPiOeD2CL6HB/8hncMmo+krhON/oZNjqeg=;
 b=FBycBhJry4B3C86GFBIYBFAFcDLSswX30e/Dx1KQxrj6B67YswfLuP5uyVufFBJZUv
 +s9gEkKoWbudvJGiMR35fRwGNUbcMAQ2+cKj78djI9GMAz0O4apYHbmqp0/eRnmb/lUQ
 dGMX0ALNcBUp0SgzCVfTuHuZvj6IfOPY0rSh6G9mIhLjNCD2lIEBzTJenafrY1XiiFvz
 q85zopT/qVUCnXcZjnTsvaOVOG8w6ie+o/OITaMA/vBWQIexc476ZDTU4UWczWlV1aMv
 oo59aLIgj0uucNMTruMIDsg6/MDT/BMp9t17qBw+jqPUqKUPjyjjlx+vpSBL7leMkP6T
 7gsA==
X-Gm-Message-State: AOJu0Yx6XkCPjGlKZjJBYQCUw1whPY9kdH3JVnKGdbrS0Z3Tp2iyTJEF
 XOsBCzyziRDyXeuYBvY2eUX8OOO87vrMrdNTnp22kvB98ahXp2tj8JD5VYpl0pBcj1I=
X-Gm-Gg: ATEYQzymDN05Ko2FF2FMrFFTSbE81FHLPevXhi0q4nxAjjSEvoPoUXAYq/QZbdp4nmA
 ir/AOypy2To0vEHuWrmwuc9oOye0KoTamDCJi0LEzYlqk/BZIiW19nXzlgWqj0vykDCG1/J+2JO
 BbO8a741K+ITcV+QxvUKnQaCmNz6sl4W2k8qO5S2S7IDMGTBOmDhLs4rGv+caKhOfB3b4ZSz8ES
 NcdIIJJ0RRotzcvbbn6U6H0W0A2wiZFbvlMoA0r6mapQXBBP+3s02NZEjmw1Pp6In6gL65knq9N
 HQURekGPY+PGnAmDqkp8IXZ4A3ThQghqqyKnJ7JXz0v3k+DaRAhde0cDLKOTj6dVt67y3Xm3UYl
 6YgVHDXOub44ArcbI+6e91AVuwVbGQhcIt87OLOk7ybrWlUchNxwQ8UBoFQDoI9UapGoqfwyZPl
 rXiOgSv1/jpPF1o33fP41MVwX1QeakBxvr4DKCuRWtu/bXJLnQpDlxP+9rflXWPWf6cd4XWqirk
 bJ0KqphRDwgSxIwE35dORM=
X-Received: by 2002:a05:620a:408c:b0:8cd:871c:909d with SMTP id
 af79cd13be357-8cfc7f6edd3mr1917773185a.53.1774289485308; 
 Mon, 23 Mar 2026 11:11:25 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc908d8cfsm841462885a.28.2026.03.23.11.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 11:11:24 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, dmarx@iol.unh.edu, knimoji@iol.unh.edu,
 Paul.Szczepanek@arm.com, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v1 0/2] dts: dpdk shell bug fixes
Date: Mon, 23 Mar 2026 14:08:16 -0400
Message-ID: <20260323180818.674041-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

Support for the dpdk-test-crypto-perf application in DTS was added
recently. This work introduced a new bug (incorrectly setting the EAL
port allowlist when checking ethdev capabilities) and also exposed a
pre-existing bug (insuffient time delay between dpdk app runs causing
resource conflicts). Both of these bugs are resolved by the patches in
this series. The patches are very small, but also important for the DTS
user experience, so if there is time for these to be merged in for RC3 I
think it would be a big benefit. Thanks.

Patrick Robb (2):
  dts: always use ethdev ports to check capabilities
  dts: avoid dpdk resources conflict

 dts/framework/remote_session/dpdk_shell.py | 14 ++++++++++----
 dts/framework/testbed_model/capability.py  |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.49.0

