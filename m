Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC8606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CEZ+/Mq0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81DB84025A;
	Thu, 29 Oct 2026 20:46:29 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 8CFBB40151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 20:46:28 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3ae1d0caaedso1276315a91.2
 for <dev@dpdk.org>; Thu, 29 Oct 2026 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793303187;
 x=1793907987; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FmQsG2X7u7Gux6u5kJEZQGGJhupgLAzthz5yBFWz/kU=;
 b=CEZ+/Mq081CkstBpYNLlxW5ats9c/IuSEncHIJeV8p5YR5OcEvSeWePSoPCG4tfG+o
 FNpDcLbcAKG0IaUcgs6nm/U4/2e39rdyJK4mx/2ixxwNo/3m/XUPhTEMT5Qi9LbHUgEj
 qNXunLTOIIBAVe4fveAonzywd3A+aTshvJVh4XCZHTwqJN90ULVJyy3bXQ9szzGLNzwn
 hOR46NiaILvAam82I+3Tw5oboTQQxzP13+RdiM3PiZGCI7ONax/TqLHd/R0leWfRLPEi
 yceheLkXidDCYtjkd687mBZpmbMIYLY3mf58/5R6odPD19xlH5ochiI6gB7jszoPXBYZ
 6hOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793303187; x=1793907987;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FmQsG2X7u7Gux6u5kJEZQGGJhupgLAzthz5yBFWz/kU=;
 b=VxFBp7FCgzX+8hAE8wDSVdftfm4vg9jDbI+J/Fbzi1Zj+QJD6Yo/AbpIr3qWgA01r6
 8LsW2udFi2ie6z4n5rLmYv7xUGj5cVY96cIr3Axork6iDqDypDrMctDipjDfxVZ7Wb0i
 QdecS3/lnuIuvaFchje5QfDMEjhkCkaizvRUevVbCPJSUG0LIfU8GAM07tLDnsftYxAa
 pi4pRwo/SHHY5ABV/jSJU7WNdU8MeFIWxkVj1wEjRLNIo+ZwL2s166MgEXXZpjbmNsDX
 fnmi5fZepEdrbDpLGQky2wvo5T8Qr6kJCWeafSwxvLTMZwszTkm4Je/eulN58fcA878k
 VpZA==
X-Gm-Message-State: AFq9FYJlxesBnElHBZyDZ6+QCx02XP56nB94PTY/EetlMKz8EjbkQYN+
 WN4+ciucy2AW8sumKZ9o5x+ORXYG/nyfjLgK9W6t/Bl0Ldg/uyIKxW1ZRRIS7+ughSX4d05Iwoh
 PCOTn
X-Gm-Gg: AYBFou2thUQjUHnpdzV5XQp+5iCbkU3XHLaNUq64vzsibmCc1aArcxniSggfgb7EV0k
 +nR7tM/jpuSEeVz5M0nHURXackkyBr22jmOfpi0quu9VdrrFLZRGbXTlBbAsT8wveqeb+KwMJYS
 Bq0rePh1/MmsaWDVC0wBJclXVK+uVB2MjID2nYv3Fdaso7gRRMPV+2SxsHRcR1piycd/iT7TKws
 Kq52q87un6gEAGshdCyHcSM534YOH6Ibc9Ko7Wx9NPg84N/IngKvOPRkOSb5bvubQnD22FaPw7I
 VzG3C7233Vu8M9vpYkd3M1Bu2gVzQMDXrbQhCs2neULkxW6sdJudQxCBTKNFC+rXO1Lqnl3c7NP
 gXomfS3AVqiFhorTiZl5e8VbRfZi2qthM69x1p6WuBWAILpBf19Ok0yTyXsdM0j1rG0NRcFq/bT
 nR0NncmclZniYi+PwqGviYtRcHc9YmIyx5+Dh0HHpuxl0wFZhrbnvaY8CRMXkrxJX2fxVQhO09j
 LV4qWuW+fzge8JgwZ55sSPCXrq5+K+G/PQclpc63RkcL7jEJrB7mLhlSWYYar7wfeXHi/urb8E3
 3lHeQ5wRV45dogfcJGucun6CQ3ra4CzCqLjH5r4+DsKeazJLK28xGFG3Q6YRdid44mfw0jI=
X-Received: by 2002:a17:90b:4a11:b0:3ab:188b:c5bc with SMTP id
 98e67ed59e1d1-3ae896f7fc4mr10935a91.14.1793303186782; 
 Thu, 29 Oct 2026 12:46:26 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9583c1sm5783813a91.10.2026.10.29.12.46.26
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:46:26 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:46:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Next-net for DPDK 26.11 is now closed
Message-ID: <20261029124624.6799c1c2@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I will be unavailable next week, and will not be reviewing or committing any more
patches for 26.11. The last patch under review is the eeprom ones.
