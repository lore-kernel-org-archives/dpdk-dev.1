Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFE606A334
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Nov 2026 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lQG1sCPg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39F4D40263;
	Sat, 21 Nov 2026 17:53:18 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mails.dpdk.org (Postfix) with ESMTPS id 49ED8400D7
 for <dev@dpdk.org>; Sat, 21 Nov 2026 17:53:15 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3ae7626d14aso998958a91.2
 for <dev@dpdk.org>; Sat, 21 Nov 2026 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795279993;
 x=1795884793; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k1EVkJULBZm3Yx7Evp5tqlVbecDSklvvpWpjAQGAifE=;
 b=lQG1sCPggGsUHJSEM6uiTYAMbB/jmZEp8u4xRakZ0M+ta/v8xIt5q64gn3wvpHOKG1
 KlH1e1I3lP5eRcI9uKpxDWheCv4W/vilzYhUV2bnSw+2VXwGVcRCp4jrRxLcdL90gl+3
 iGmlOhlaL44k3IpRAKDxatuaV5rUUtFppZtecc1brV05prgaEtD0KM3et5Uf9sv4gl7d
 KsHIyZQ17nxbQlNWshDA+Lkjl+yZ9hFU88TBtFmRKQClWI8ofCCTVqLACnxYrP6BE85Z
 DJyOm+plPPW3N3JCV+NgtQFH0hitI1nH6tzbzQOUnv1mE5IQlBoUS14Ry2L/pElsrxmj
 oFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795279993; x=1795884793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k1EVkJULBZm3Yx7Evp5tqlVbecDSklvvpWpjAQGAifE=;
 b=LrQNsPQ4XYZ2VhonUhvPRjdCLvvfuSO/nIRIVIBG4f7yGZYS1mJTLlCQXXjxahskG8
 sqm+XiGBwu/ZI3sYS6FjXmmGkZN9rnz0BmsCieCyN9/j+BCmLFsRZaMunlT4Ew4odY/+
 loKOLT3JGD5/FoCENPQnBBmwpRhsQpL2HQw0Xp5iVEBFLnojlppO04txrQaKRN7OdOn8
 ZTYL0H7kcIDcYjKB16vWW0yFkFYifaX3Fk8cFmNbfho9AsBaO4Wo/KJsP25Vv+R6QglC
 0xeH/dtn0HIY6dpqVYQAA/vVdD9WnSY7tBzCtAJ081NMx9Z1I4ng/TZmPIoocP3vrZsy
 WMxg==
X-Gm-Message-State: APuU4Z+vFqob4xhLby5ok4MzSkNxAkrLLLRD99L5fQnXcfDfWcJ0nyfF
 jzIpxoFKBxypWW19QMZ3LpQVfJn8x9hd9DKH1NhxXniiG2gXT+DGmSfEtGKEndBdZWUAv88fDt3
 locdwQig=
X-Gm-Gg: AZFdTZfOKe5Oer5XCQ04+N/LazrRlioss/mCMWRJzSMobq6Q7Oi9NcsTot2Juz0JqFM
 yVKSBkk4Al4J88f5FiWFo5Zv4lrrvOWZgcv4ZPMtneJ+uQ+p7oRwYZxmKSZfh0ENd/q8aCa+D4B
 XyTRYhZ0IW9kyceYxPwJxBRVYjeHIhXxHDl8SFCDhbTlzJB+whhLonoIZkln+Eluvb9Od8bJ6Tq
 kbhvqUaWEulCKjZy2fTP/iySh99Aa5iUKTQJo/nE8tIh0NQ8/gtkgd5tIgznshp+6gMrZa7ABX9
 bilS6eg8qZxXOOYJgXfk3IO5dOeBVYcCFdtAep6NhVguyQG3iejHT741gQc5LDyizvA0lmQTgBw
 rTDHlR1KWvQSreFk4c0YC60sXuFiloobDeJihEC+KthZqMgIA7H25J6BVtvT89EojwDnjdNHkn0
 hEXMEpjxcVb+YG2NM69Ao1lqY0dgKlkTbyxcMfOden6S4+LN2FwxyXOOxPjbQ4cIAXMVtLa1560
 Y8mF71t/szFp8mMC1QPYObWzcgDPktSFtaw+zDM7Yeftn0Ero7A5WnpwlTZetDHo0XLlQVyfSiw
 B6pGDu7UVIid37VteMVwnUwpv67KGJpSXbdSh/e+sI+uRl/Nu8zBV1xJJBLqO6EpgequHw==
X-Received: by 2002:a17:90b:268f:b0:3b3:a421:7e00 with SMTP id
 98e67ed59e1d1-3b41c8d4831mr5753757a91.16.1795279993515; 
 Sat, 21 Nov 2026 08:53:13 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ec698dsm12104874a91.14.2026.11.21.08.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 08:53:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] ip_frag: fix IPV6 frag id
Date: Sat, 21 Nov 2026 08:51:51 -0800
Message-ID: <20261121165311.1547352-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DPDK ip_frag library was not doing IPV6 fragmentation headers
correctly. Found by OSS Scanner.

Stephen Hemminger (2):
  ip_frag: generate a fragment identification for IPv6
  test: add test for IPv6 fragmentation id

 app/test/test_ipfrag.c               | 54 +++++++++++++++++++++++++++-
 lib/ip_frag/rte_ipv6_fragmentation.c | 14 ++++++--
 2 files changed, 64 insertions(+), 4 deletions(-)

-- 
2.53.0

