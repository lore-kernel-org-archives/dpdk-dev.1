Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CDEC5516E
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 18:38:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8823140276;
	Thu, 30 Jul 2026 20:38:51 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 8C5D740276
 for <dev@dpdk.org>; Thu, 30 Jul 2026 20:38:50 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so113946a12.1
 for <dev@dpdk.org>; Thu, 30 Jul 2026 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785436729;
 x=1786041529; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zjXfKGrh8OkAYUYzWGOlReYcLhb3O12UK7Nxwn6Fd6k=;
 b=d7z8C/evM9ZHJHaVsDUrL9oOBIMqkNU4GKCUVOGnjELOj2vPAKgsSnyN4yXmBow2WN
 NTgVN2zrKIZzoxVJO1nVo2Cx7lXJWWqOOBIOnqA6mkXOeVjlqMdldWoD9B0PqZzBWRVQ
 eh7r2vn2kXr82virpbG/4RUdMSCOC0LTKoGEGfmHqrQfnHm7nZXQ1RnjQdYNm+htdGdd
 3AVuncHR18OffSuYMwfZ6KAJgYYgJUuhybSnHXwq3SN7iu0Z0UHR2k2Yvvp9+qf1uOOI
 9T5sWlb/2c/Bq1xs6fogvli6/ctUZAPypcyljCLBzO6RtrRfP0VmKH0u74LM+Y4AuJJz
 Ff/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436729; x=1786041529;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zjXfKGrh8OkAYUYzWGOlReYcLhb3O12UK7Nxwn6Fd6k=;
 b=Bgqdn0uFIXofmwSITUpOmwoH4VDcrnteU0dgrXb85h0LrsYsU9igXOU/avRczatN9N
 97HsgKB0ltk0OVs8bZapyHHbuOvqDMI8FvwV5Q9Nlerxl7OhcMUbj6QjC8ITpXPx3Ohn
 tSkDJCDeEDk9EZchiKr9h0eI/KqcyNZiSX00ZWZBaskzKhlC+BtuxOJQyBghgvG3M1Wo
 l9lMfDbVcYjFUuG/kO4QaQXeTqJBve/h2QLYNSWvT+AjqJOcqLVoM34y8RSez4WCjlhw
 DtFtB77zjtumn0iAEIuUVx53Xb/Zqd9hJydNbV/QIany8lLI/N77AORG0enf4A8yW36X
 qvlw==
X-Gm-Message-State: AOJu0Yy0KvLtNIMvUiGwmcmLaGtaDgPTIysaeqdbXI02VU7+MB2xAdcY
 SK8k3nSjiDtNsrPURCDQocmuLapr4NURd5dQGVtCWr3LJ9al1xeQZq9F5Dh4Mz2sApS8HGng0sB
 9u4hJ
X-Gm-Gg: AR+sD11l62I7VmXbqKqmWR9g2EEKpKRFXqyVRtf/d1zQaUyVW//8CsdJjiGa2j0cE/a
 IynnJ1JFAMpI8W/HjioJauyvX1DIoZ7Xo5JK5uHYBTidZq63eP+3aFSCe4knpH8XfpSvJBgzAsV
 BcPzMWCTIX2wky6vDv6UXLHw8sSysCg1Ske4Nz+CIJJm7ODoVac6dUE8KU+30+p7unhsSICYcYb
 0/5Pb5MlIjvmK4mxY5AQwWKeMzactLvjnIoaTdnyUajNrBQG+kAyh5IkuMoK2rpmqC+o/mNfpDl
 /iUu1VhglS9jgVbOpl5U6LLcz9FSm0bDhh9G+9udd40MIBMG59OhUXKU2PZ04bym2/1DriToGPH
 k4XUpDIu4anoeEEcLDSzHsdrv7NYxdE7b6+xh4P3Gaat/T+szcfBY0ejtatiRxelWLho+qS9v4Z
 b3SMw0vpLNzBldPoilfTrjlnfOfo5gC9473OhcBbdY+XiK/QrJ3iEvDFSE3J3olWVfvgWx9nZRg
 A70d8dv3VcNnc3hbgqgmTA6Ib7i3g==
X-Received: by 2002:a05:6a21:1393:b0:3c3:7fa2:9618 with SMTP id
 adf61e73a8af0-3c9008d2550mr3524055637.37.1785436729411; 
 Thu, 30 Jul 2026 11:38:49 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7263cfd9sm34920684c88.4.2026.07.30.11.38.48
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:38:49 -0700 (PDT)
Date: Thu, 30 Jul 2026 11:38:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: stdio is not a spelling error!
Message-ID: <20260730113846.25d8568e@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Is there a way to get stdio  into the allowed dictionary for codespell in CI.

CI reports this (a lot), I fixed it locally by having a revised codespell dict.

WARNING:TYPO_SPELLING: 'stdio' may be misspelled - perhaps 'studio'?
#347: FILE: lib/capture/capture.c:13:
+#include <stdio.h>
           ^^^^^

WARNING:TYPO_SPELLING: 'stdio' may be misspelled - perhaps 'studio'?
#1610: FILE: lib/capture/filter.c:6:
+#include <stdio.h>
           ^^^^^
