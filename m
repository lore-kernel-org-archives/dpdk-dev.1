Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16320109192A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 22:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D5AA402AC;
	Thu, 19 Mar 2026 23:11:28 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id F205B4013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 23:11:25 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so15329095e9.1
 for <dev@dpdk.org>; Thu, 19 Mar 2026 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773958285; x=1774563085; darn=dpdk.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bQIzybsiYul/Hm9qdOP7mat4fvRZM0S6XRKU3JrPcVs=;
 b=lnGJhzMgqtbJvVjskby10jgX1MAYiaTkSAPrvqtPf26IkqwQKLqHdC5n7qpUHqVYpt
 DYpxxxS8nTs9m1v9tgi5jMyZGigEAWOmW3EoIOoSSYcHkOR9/WKXuOy1bWuDac0+swci
 D4x1vwlk3jFMQQIzSl0Z2vtGmEa1sgk8MwjxCsIvCGJxmS/mrUvS6hEvxJcTfJCeaFzH
 7iWhyRyWCic2SpDJN0wIMOlfIWi0dw55QNVHepviYGLXkRkw22uU+/R2hDgbqEtLAlYb
 yeSiUMd1DbZjh+d7R0xUaZOyzvDvdwl8b1TCE9uKN7LLfhvQMRTsNUBClUXbxSHW4Gle
 nwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773958285; x=1774563085;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bQIzybsiYul/Hm9qdOP7mat4fvRZM0S6XRKU3JrPcVs=;
 b=D1bGNf6Z+Nrmd5g4dsJV7zgX5bEz54l9ibyaE9ecoYEjY1s0mAEERtWxPylBro5ER+
 C7+P6zk978LKQgKSlstH90X9V29cb9zJqCHM6HFNaTdbxrof2LDmA8A6zfbkMCFzVKCY
 i/6+75lyPlW3h4dnY+moQzUVxBO1KzDPNbCUntzs1zzwK8rInMlClSfrGv/Q0YtADqBF
 XDpUnA7YRX7fluPuZHqi/J6OnFOui7HSXZXxQmoaO3pIuWHRy4rUjJ4t6qIlcZnplSUi
 4MslzYyiCyQPmrZMV1cs8IjnbxVBU8enE5+Wwomn6r3ZPuuOFuVi8sbrL7EIPurzh2GR
 4JlQ==
X-Gm-Message-State: AOJu0Yz2tyMqqo8VNX7oohaCZJAWMvKJhK7IYnM3NVO69OH+DSOr4Szy
 xNmU4De5io8p32jdpxNot8o831adCYYdzRBC8paSqFzzxdi6YluXaYq4
X-Gm-Gg: ATEYQzwAeuE6xfpcoBPK3xz8hZh0qx8fl0vugPMuCThBzqyNdyinqsp6LNYSJ18txpX
 R8HRIZ7wX6fFt2G9bP/2Zn1D6aA5ilJ+EdRwOi9inZH8trILXiQQib0GJGVFB5/jhUY3zp9GQtJ
 7U2nh4lVYaJHZKbXTKt6Fl5DdNg9HarsjQcqL1snnkhuY/LMi21o6YRYa+TBKkKBWgZOupPhRo6
 N8TERKnUtMOMRowu+86DWPj7Au4Yc6PPb2ROllS5cHsWgfXzbYklJGdr89hzrvqukdPM1obdlXM
 HghnHBUCm0QrKi3WvAxQXu8m560bN8svjXIECaU2mO5NlcdX3bBDl6DZ/UMApbcOwWfP0miiaNR
 aT3bXDRaH+587HkVlXV9tBOXTf2IOeUhpcftsVP/5ySHVwITSggzvwBLEH5BMlxUDPE1uxA3gEq
 4l2qoZcz6NG3Z/5C8nlesiC43a1mrc
X-Received: by 2002:a05:600c:5250:b0:485:304a:58cd with SMTP id
 5b1f17b1804b1-486fedab733mr11736165e9.4.1773958285443; 
 Thu, 19 Mar 2026 15:11:25 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:d0e2:31a1:5c2c:69ec])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-486f8b949a5sm85524055e9.11.2026.03.19.15.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 15:11:25 -0700 (PDT)
From: luca.boccassi@gmail.com
To: dpdk stable <stable@dpdk.org>
Cc: dpdk <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Bing Zhao <bingz@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Helin Zhang <helin.zhang@intel.com>, Jingjing Wu <jingjing.wu@intel.com>,
 "John W. Linville" <linville@tuxdriver.com>,
 Keith Wiles <keith.wiles@intel.com>, Long Li <longli@microsoft.com>,
 Matan Azrad <matan@nvidia.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Ophir Munk <ophirmu@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Pascal Mazon <pascal.mazon@6wind.com>,
 Reshma Pattan <reshma.pattan@intel.com>, Shaiq Wani <shaiq.wani@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Suanming Mou <suanmingm@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Venkatesh Vemula <venkatesh.vemula@intel.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Wei Hu <weh@microsoft.com>,
 Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Subject: please help backporting some patches to stable release 24.11.5
Date: Thu, 19 Mar 2026 22:11:13 +0000
Message-ID: <20260319221114.1071955-1-luca.boccassi@gmail.com>
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
Reply-To: dpdk stable <stable@dpdk.org>
Errors-To: dev-bounces@dpdk.org

Hi commit authors (and maintainers),

Despite being selected by the DPDK maintenance tool ./devtools/git-log-fixes.sh
I didn't apply following commits from DPDK main to 24.11
stable branch, as conflicts or build errors occur.

Can authors check your patches in the following list and either:
    - Backport your patches to the 24.11 branch, or
    - Indicate that the patch should not be backported

Please do either of the above by 03/26/26.

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
2f7cdd821b  Dariusz Sosnowski net/mlx5: fix probing to allow BlueField Socket Direct
f741298f70  Long Li          net/netvsc: support multi-process VF device removal
5a9362386e  Stephen Hemminger examples/vmdq_dcb: initialize all configuration structures
abacc3b2da  Stephen Hemminger net/tap: fix handling of queue stats
c67f59508d  Stephen Hemminger net/tap: fix Rx descriptor vs scatter segment confusion
77f831b6f1  Stephen Hemminger pcapng: handle packets copied before file open
b3b8301dee  Thomas Monjalon  net/idpf: fix commas instead of semicolons
3ed9a05bff  Xavier Guillaume net/af_packet: fix receive buffer overflow
