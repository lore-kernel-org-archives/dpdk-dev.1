Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29871606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N5clYPzJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7BA4406BC;
	Tue, 17 Nov 2026 17:07:33 +0100 (CET)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTPS id DF546402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 17:07:31 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8b3577deeb0so2487575b3a.3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 08:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794931650;
 x=1795536450; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1Y7C1eQAbjY5IUYaWqEIB8P96seFddjf4tXC3+IiVrU=;
 b=N5clYPzJc+GljZhUCQVemxJ1r33UGYlIrJZ9WweQAj5JeRy2fv9MoBsjH+BG93JL65
 D2YISL8Y81XzDWCj8dQ88foFToJ0hBcvDtkZF0yrKDJHDK38AOb/97nSXd8Al/ITWHZ9
 rYxAJtKt1BPUK+g6kVK8zvszWXyxkdu6cAYDGTTIe+6DyW3weNcJq6c5qgGS5GoquehO
 RJUTClF+EAth+4QMumDOJt3pmPJcJe4tDwfQx67PRG1qR8aaVal+/Pbv20DlGbDBhOl6
 Jq2Pog26aC7rTQdGs/MDiUJzMdVl26UE2qc5k5Y6SEncKMf54rF7XKU1NfUfCiGFCGXg
 0cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794931650; x=1795536450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Y7C1eQAbjY5IUYaWqEIB8P96seFddjf4tXC3+IiVrU=;
 b=r9CIjCoRMPnYGvsijwF2Ps3CaXKMV1M6OBDIljuwfLA9HEm4HQ/rc/qrZJnEDxG3FI
 0lVR5YQ5Wn7REKq3n1Pb5dVh97xapFWon+7dHnec4ITVw/mcpgjGwsRY9n9ZnBMqeSGw
 Q5Df+PLsbgnhanK3weMaiV2GeWLiW4L+h792TxRa85FMFIsBEkN/uudeG3dWHjlQTmrd
 d9Y95QjjPDVORzTkV902IUoZRxr+suouB7PuBG38w0aJEw1gjoM5qWac36BDwrcyuZXE
 8UqXvW8+ebl+hHzEW9ESHgRZ5wiLgjsT2D0YHguPksWe4TCyLvnpQPo+fIQVXpPigcwI
 hrqA==
X-Gm-Message-State: APuU4Z+Jnwu4XZaLa5XVGEfgIRvD1rwmPWUevCULDkYtHGPgrSKj9WTw
 H5zYnbFkeZwau3FPuvAEwcGBZ6qDv4uBabYlRnNJedMBsQzxjMxFw70L0aADtMxyOYHtlbcBW9x
 Z+SW10lY=
X-Gm-Gg: AYBFou1BF63cpZorf9NzsI3QEn/toHQimQhXYY0pluOLOjZqom7RNZ2zW4wMnf/L3eP
 9a8/7zYScilgMwkzPLgiua7nyppZI85h81LG9YKz5EuVDcMm6rRgOFrgXPPEaQKUfeuE4ikFwfJ
 qJE/LtMDPdTGk0So0r6GCiLClpdMeZzqEoXgqNYpumwbIvJGm7Nux8KZEFLy8W9SH2urYTmSgqa
 7yQP7tCyPiEMnmJ0EUpobvE1THTaf+xejII3kOWheyuqvGdSfcIZgZ5V59ycUaWQuF3OsQkkyrx
 fxZLfyYWi6DMgJVEiWveT43Y/gZji1liAB100VrB+0aX2G5x/SPsUg+0PxQ1TtnayJ8MzkBKD1g
 fMvTEiTBJHZJf9wIrDnM1fLFfAQaT920UqLAEJ/8mcXnAA40WbTG6OZkvEglp8+AGgJvklmNULP
 HqgTPEv9nWdtwUbLdDay1Z/hnuFuPrfL6zD82ueKUGmx0eg9deOvPo7Xvv15IG3YeOTGpVLhElm
 sNLhq5WATpt61Jub85fwFIRLTghLueaJOz5twjZoPDvNi8KyWlqnVEFsXYI1fvYeDBdLFAIHU0E
 d9WCYpruTNTKIrlde3F8IOzYh74fyyBH8hMoHzK81xODzQKOJXGav9SVHT0WcDi5ZmuIcaE=
X-Received: by 2002:a05:6a00:2d0c:b0:8b1:d612:e945 with SMTP id
 d2e1a72fcca58-8beb753a01fmr12920186b3a.52.1794931650165; 
 Tue, 17 Nov 2026 08:07:30 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5b40c3d33sm9403b3a.49.2026.11.17.08.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 08:07:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] app/dumpcap: assorted fixes
Date: Tue, 17 Nov 2026 08:06:18 -0800
Message-ID: <20261117160727.388470-1-stephen@networkplumber.org>
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

Som patchs for 27.03.
These came out of benchmarking dumpcap: capture for 10 seconds, count
how many packets landed in the file. The numbers would not line up, and
the reasons turned out to be in the stop logic.

The last patch is unrelated cleanup from reading that code.
The error handling could call rte_exit before rte_eal_init was run.

All four are candidates for stable.

Stephen Hemminger (4):
  app/dumpcap: fix packet count overshoot
  app/dumpcap: fix capture duration
  app/dumpcap: fix pcap timestamps
  app/dumpcap: do not use rte_exit before EAL init

 app/dumpcap/main.c | 87 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

-- 
2.53.0

Stephen Hemminger (4):
  app/dumpcap: fix packet count overshoot
  app/dumpcap: fix capture duration
  app/dumpcap: fix pcap timestamps
  app/dumpcap: do not use rte_exit before EAL init

 app/dumpcap/main.c | 87 ++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

-- 
2.53.0

