Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEF7C9EC8D
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 16:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33B45402B5;
	Mon, 12 Jan 2026 17:03:49 +0100 (CET)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 6CB9740156
 for <dev@dpdk.org>; Mon, 12 Jan 2026 17:03:47 +0100 (CET)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-88a379ca088so72502066d6.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 08:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768233826; x=1768838626; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HztIkd3sqOJocgSdhV4MJOI3rL1Ay0k8/q15iB6FdSM=;
 b=VChW/TfY68CWsd/zG1LNWMSFOUbGrDfCh72O/Vb/9Af2CJ5SPhhgpe8ro4WxTvHk1A
 JEAKwO9zVM8jXKJ/bDRx5TBjsrIGfdo/xSV/A+b2nGRZe6DZdt6NJJ+qwOVMyWFlfP8P
 qi1gChdj39K/G6trN9j1wTqI9WsMw9gGsZm1o0o11REjHUkIs5y++2jpAJrFiH37m3r6
 TZpSHszEpKyZpzAmhBxw90Jj9J6uStgO/rSfNK0IIhq640ivffZmG5Rn9yuvES1DfRRo
 +muzUxYRAX49WSyaSTrfc+U5v36WVgrmsWH5aOcb+TK1WayNMwX/4axHBFuR83QI22nd
 28uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768233826; x=1768838626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HztIkd3sqOJocgSdhV4MJOI3rL1Ay0k8/q15iB6FdSM=;
 b=m5rq39+Yy6AxKc/dbCS+IYwcsOqP23kUjJ1kKwdXI7YJBS7Njcuw6ll/6zVhLThTgo
 ibAoz22PvhbjMgzBp9jggp5WjsRmRMpsTomRAmgrEGVr24a434ElxqFA/HxvhBsXIJn6
 JyiA+XZYr6vj1DMcI6Z2oco+/n4AsSJCVEpXGFI1v1qxv4SxlYxBXk/RyqtRADgR/7Uq
 S/mCfBxp+PGZMsMq6UZ2ho+7icp7ULoNdWsdtLXMncqmdgVoaqhgwZIHkHmHoxrWbxnO
 2W9qryZ5U11+nRiZDkrWex07cgNepiZNhB/XHAqxP4JNTV1xy4xAyGh7Rjv3O4POhuCd
 1MGA==
X-Gm-Message-State: AOJu0YzuNLfe+QpOQFuZmZxYbBCqZFFYE1gIdxofdSviIk0gKntdCqv0
 ULWlk/JHzJLX2zyfhJY84dpYoMYaB3p4JZq8EUrmU/+1tYj5Wb+iainjfVjJbw==
X-Gm-Gg: AY/fxX43tVAEv0rISkdSx6OAUpY9dpyrAm0xFTAE+1pHUkE0JK6NJpIGbK+yOmudkff
 aYbwfldFaWZB2iXAc1rCPSleM/YU8pCK/AcWgIn3IsWa3F78cyR98Or7jVEQKsPVyC3+BdFMbyc
 HeYRrODm47h23UOtHtHqAWQcP2nKGWjHISei0vtCYhva//valRVQ4Sx3abRXgqufiZPJcU2+HdU
 CGf+mcC3RDo5bU36CPY6w+jym+rUdE9LW06MDkn3v7zo0NrU/hfHtnwzlMCxQxVkCxvsIVIATgb
 +/nZ+hDhmfZIVQwE55clgxl0mBPSHBtuxIdNkiuMQ7pLi3reW3rvc/C47ZfdyZUO7QZ8kYWMk1Z
 PYJPXjDc0EWt+n1yTVkEUv485CQYa9CxsBKRTnXgLJgphnuLPtSxp2yze6N/VpbhcifxOFJA52c
 iUIKmX39/P8WdTFEfLm3qm5TUmZm9FuUEFA9Ddm7Q4GzyKt/DBQ3si
X-Google-Smtp-Source: AGHT+IHQ3xhlluNjfdH4BNZzqTpjI5jwwVGkeq2uf9Jsmmsy1MG5aS5Co0vShI0Ogs77hQyIgvnCaA==
X-Received: by 2002:a05:6214:450b:b0:88f:ce04:3261 with SMTP id
 6a1803df08f44-89084179b90mr296238646d6.6.1768233824866; 
 Mon, 12 Jan 2026 08:03:44 -0800 (PST)
Received: from st47p01nt-relayp02.apple.com ([2620:149:13c1:500::12])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890770cc6edsm138000286d6.4.2026.01.12.08.03.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 08:03:44 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com,
	Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH] mailmap: add Scott Mitchell
Date: Mon, 12 Jan 2026 11:03:42 -0500
Message-Id: <20260112160342.38297-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

Add email mapping for consistent git attribution.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..a0987fc3c7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1437,6 +1437,7 @@ Saurabh Singhal <saurabhs@arista.com>
 Savinay Dharmappa <savinay.dharmappa@intel.com>
 Scott Branden <scott.branden@broadcom.com>
 Scott Daniels <daniels@research.att.com>
+Scott Mitchell <scott.k.mitch1@gmail.com> <scott_mitchell@apple.com>
 Scott W Taylor <scott.w.taylor@intel.com>
 Scott Wasson <scott_wasson@affirmednetworks.com>
 Seán Harte <seanbh@gmail.com>
-- 
2.39.5 (Apple Git-154)

