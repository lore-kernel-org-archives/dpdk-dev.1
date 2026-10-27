Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C8606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JY3be5Uu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 050B5400D5;
	Tue, 27 Oct 2026 01:14:51 +0100 (CET)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 7738E40041
 for <dev@dpdk.org>; Tue, 27 Oct 2026 01:14:50 +0100 (CET)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-91b83459526so44348016d6.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793060089; x=1793664889; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mOmWEJxiLFKvYyaktbJ32wbBNC7jMKSFf+RcAQ58Oyg=;
 b=JY3be5Uu6wKlL74CiEW7JI9bh98Djn2rSNPLgZTkz/AQE/vRnj7VevL1ngD0ECb6rZ
 nwy3K/iCZ9m/MeXVxe768BGly8xPrIwzXVpTEW+bVNEhIVn67Y3EhNbOH1udga2+M18n
 VzmT+CKiXmzntiYNp3dpr/7Nwt/z/dGP7qS3oKl6rmGEkzhwtniDde1bHlGb5YzpgoZb
 4kC6q/lDZFT8HtIVEoVpHeXmvBiscC2kHMu6rw5htiRSzBDxZeNTOhKXP8RIi4Wr0uKQ
 vnvAUdJd+M9VQ3kOZ/i04cR3OaoK96rsKZz8ioJiVfgZSXJK3FKi6xj0txrjBLWu2yOU
 0zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793060089; x=1793664889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mOmWEJxiLFKvYyaktbJ32wbBNC7jMKSFf+RcAQ58Oyg=;
 b=FoIU+3mFpLl+Kl07tnBpaWiYkTcM1c/W20FoK1yv2cfb3f+oGD1jwpOUYOBXroQW6W
 4Mw/y5czKigL3/T4Q0lo9zKl8pjv80pady18BcARNbyOiVklPAFrsHP3bW2E55OfzoyP
 e4oyFd4PyhSNeMU5ua9XEhUP7Q68ty94/QUlFylGZhM6YLm4zat8UjlmDSm1uh6JGeZ4
 OrH+D/Km4feJhZkXSbt0kbusCD5BrhFuoxvR8Gzox4m5/HfklQLZVR7Gl0kUa5G3Lwiu
 DARnPF9CRyY2jxtwHoDc+AqnPdVU4r7pPs8GbP7mknM0P0fPqxF7qxHsBkWDv0cFN70r
 j8wA==
X-Gm-Message-State: AFq9FYINdsRZ/Kr6//LfPcPCRyF2gzCa/sBdej41ugr+ENw6KSCzCmtS
 ulCAWZ7ilQJ4WyH++9+lpUvDrOEVVsMlsfAwxWpkBajV0QPIufmBlNnFWDlk2Q==
X-Gm-Gg: AYBFou1HSV6N//+a7te4/Q6FAR62wyceilcQAjOhs391O25WYqPuca0BJTZNQzxLpTT
 drkoVbwpeeFaMCJQ4x7hJB47sg5E8iAbYp7qyXDvc/Kd3w1dpLSW8pO28b/qpnRKsSAcUd6KmAs
 LehxCiq4e/WE4iM5ZZrdoBYSK1as1QLdx4J707OLEL4K97Oq19zxJVuicUMoMhi/N9GSdPD8Ff/
 +UMnYZtuoTNuW8Gd/Wk/qrIuHIjBz0G1ra67DZ9D+zdVARB4YdWOM5VwBLY2aKHtDJbr2YGhpV/
 mBf6qkYCZmT6xkQbGEGj//wRczkAYXzmFDhMISQt9Uv19jCshppYwDkTJ7nZfVZw4kwDhgXWxyB
 NwZpvgGxvc4aAmouPYI5SqAWn5XuFSv3Bvz39YHrrTbtOi7K8tCxv3ffRtJa5XcBdkYeH24DpLi
 VinU8uQ2WfMrVaBopNrcfQJDJk1mRzOAxbDOwCNb/ZBecqIdGG1o5QCVwFNBylm3dir7RjnCpMc
 PRECMAIfIY+7urKH802HWergDMS32xzs9zzOiDLhUtgrlg4O2R+YG0734qscFYr17RWWWFeBgva
 rZQfYRDLltOHUUz08GOxFevZLpQCDDK+/c6iJqrf/azhYPK2L8MLOQTQ5oN2E3Ao8xBaGYOJswO
 8F43+WZ4jkDRMhPafTFFvgcBGtgpp
X-Received: by 2002:a05:6214:262f:b0:91b:9496:6a18 with SMTP id
 6a1803df08f44-91c48e85405mr153090736d6.37.1793060089163; 
 Mon, 26 Oct 2026 17:14:49 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c65ef7b0fsm31449136d6.19.2026.10.26.17.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 17:14:46 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
	Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v1 0/4] fib: fix full table overwrite on address wraparound
Date: Mon, 26 Oct 2026 20:14:19 -0400
Message-Id: <20261027001423.3028072-1-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

Both FIB dataplanes can overwrite their entire lookup table when a
prefix whose range ends at the top of the address space is added,
deleted, or has its next hop changed, while more-specific routes cover
its range up to that point. The call returns 0, so the corruption is
silent.

One real-world trigger is a default route coexisting with explicit /1
routes: with 0.0.0.0/0, 0.0.0.0/1 and 128.0.0.0/1 installed, deleting
0.0.0.0/0 makes every lookup miss. IPv6 behaves the same with ::/0,
::/1 and 8000::/1.

In modify_fib() (dir24_8.c) and modify_dp() (trie.c), the branch that
skips a route starting exactly at the current left edge has no
wraparound check, while the branch that installs a gap does. Patches 1
and 2 add the missing check. Patches 3 and 4 add unit tests that fail
without the fixes and pass with them.

Robert Sanford (4):
  fib: fix full table overwrite on address wraparound
  fib6: fix full table overwrite on address wraparound
  test/fib: reproduce table overwrite on address wraparound
  test/fib6: reproduce table overwrite on address wraparound

 app/test/test_fib.c  |  94 +++++++++++++++++++++++++++++++++++++++
 app/test/test_fib6.c | 103 +++++++++++++++++++++++++++++++++++++++++++
 lib/fib/dir24_8.c    |   6 +++
 lib/fib/trie.c       |   6 +++
 4 files changed, 209 insertions(+)

-- 
2.34.1

