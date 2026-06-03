Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9036CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 16:32:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05CE7402CC;
	Wed,  3 Jun 2026 18:32:42 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id E163D402BC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 18:32:40 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-45eedc94d37so3549595f8f.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780504360; x=1781109160; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lLz9sidqz/NR4tEKCYEbsYleAcZMwKs1NvU/8doHgU=;
 b=GU44jmHchzx3EZyZR4MVteevDz5KVJN/dKCxSiju4lnDGDM71XqJeVroXXL1IfYkWn
 0Y8ePT2LDJ8cPHKmNAOOSzR7u5sJZqmKjfjjV/g4u1r+L8fjvyOWjXfQ8wdkGMsl3ivt
 ShVhBq7OcQvxFkUMbNms2RbKQekKEJlF2z28rLbSqF4F5hdWJ3x/nCZv8fg58LI1wBdj
 /X+xZnnIIbQ6pOJ7eNc/DkJ0+izKfC74w2G9bVnD5OkORMMJ0GwE1YdbWD0J67/trDpD
 RkxLTkgSc7MVFBZ63WK56kZUw2gaC4uHz6YbmFEQDLDCHPfLCabCfxSyI9OhaFw1H1fj
 9CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780504360; x=1781109160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5lLz9sidqz/NR4tEKCYEbsYleAcZMwKs1NvU/8doHgU=;
 b=HaQ5gq1SVHAoDbSo945sThH2BQHvrhkq90H2M0tkabqBeuDk7dwRcLcbSm3yHemXH7
 rR16mIHWBQvHxsILXQ/L8WiDQW7pEjOfJr6JwzBruBLfK3QapVnCdllMzrdGlM1GVIWZ
 UcA1l//XxQqgXhq5mZf/3oP5cMvkMsgfSx4zDEYyM0awwzi2Phqf4FcO/qk2/leRIJdG
 EGtTtj4TOr63W0qkaHHR4q0MVr2+z0IR0zbU6Rr3mPjROCEIVlV+gzVPiNpsRGgMeBWB
 GCFuTyQdwfCJHaAc8I+C93Xwt9HJmXDjGVZRQx1ZexnR4lUYH8e9mDuZrrMFK5ya5nZ0
 zVng==
X-Gm-Message-State: AOJu0YyaKOx3xMSUKHB3tmXch86kuOKUlaDq5ZSZyciVV5i2SQa6sz+3
 JROSukkLsX/MxraGBBSngARyJ2TZWwri0yU0IgDLBZghL99329fd1jyPDsJm96mY
X-Gm-Gg: Acq92OGzO2FDBLGyGFPMQrQQseran83dZWfz/juFm+kn+VaSZShRlSbDkOvDCHsIL1U
 C7diZI9EfbAs3krDu8DPKcIH3YJtYmWC02RaoKc3T8F9FNNc7btZpLOLUr4uORZOJzO9L8K/nS1
 iuz1YbOyltGbXCISRwM1nUBO7ecCUsVC0w7vB3YVj/6x2s1WnRSzwCPqVkQGDF5IhmDpygBMj3Z
 fWBHWWf0i7U3kLJX9UPKSj9ElaAS0s7bzZ8I2QiqSJSeVjAoQO4zUMoyYoNJiahn9yD7PQMQSH4
 XD2qcAWYQ5KhINonVHsLJmSm6GtpPdIl2vXmZLgecYujutq5FU27pfzxJ1vU7Il5FsWEyQbH0L7
 L3YfOTPxPNrPy9SttvQTZN+KMxzz8ofq+q7jkjlGWziuQzYDAZQuJyDeif6vXEHTWXcWFIBJdTK
 tGOF+cggCr4I7XroXBKvOSO+WJDtDzWo7OYX4O61XR05cnGpVtwkx556S4
X-Received: by 2002:a05:6000:46da:b0:441:2aee:d561 with SMTP id
 ffacd0b85a97d-4602185a303mr4335932f8f.28.1780504360236; 
 Wed, 03 Jun 2026 09:32:40 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2eadefsm9096836f8f.11.2026.06.03.09.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 09:32:39 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, stephen@networkplumber.org, stable@dpdk.org,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH v3] net/ark: fix null dereference on allocation failure
Date: Wed,  3 Jun 2026 19:32:15 +0300
Message-ID: <20260603163215.207413-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260603053214.119296-1-denserg.edu@gmail.com>
References: <20260603053214.119296-1-denserg.edu@gmail.com>
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

rte_zmalloc_socket() can return NULL when memory is exhausted.
The result is passed directly to memcpy() without a NULL check,
leading to undefined behavior. Add a NULL check consistent with
the existing check for mac_addrs allocation in the same function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bf73ee28f47b ("net/ark: support single function with multiple port")
Cc: stable@dpdk.org

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
v3:
  * Use a single-line error message without "!" and "Exiting"
v2:
  * Fix Fixes: tag to use 12-char sha1 (checkpatch BAD_FIXES_TAG)

 drivers/net/ark/ark_ethdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index 8b25ed948f..546a44704f 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -445,6 +445,10 @@ ark_dev_init(struct rte_eth_dev *dev)
 					   sizeof(struct ark_adapter),
 					   RTE_CACHE_LINE_SIZE,
 					   rte_socket_id());
+		if (eth_dev->data->dev_private == NULL) {
+			ARK_PMD_LOG(ERR, "Memory allocation for dev_private failed\n");
+			goto error;
+		}
 
 		memcpy(eth_dev->data->dev_private, ark,
 		       sizeof(struct ark_adapter));
-- 
2.50.1

