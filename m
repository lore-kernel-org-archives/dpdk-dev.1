Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C17CA1013
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 12:41:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AB84402BD;
	Fri,  5 Sep 2025 14:41:07 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 900024021F
 for <dev@dpdk.org>; Fri,  5 Sep 2025 14:41:05 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-7211b09f639so22763746d6.3
 for <dev@dpdk.org>; Fri, 05 Sep 2025 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757076065; x=1757680865; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ji7/0YUfEb7w80UAAeFM2wfGH4dzagCszMREoTp/cew=;
 b=QLmvvGfGPzgUv6Qz2NVJujdQJgskxRsnZFlHappnXv5MEXTF6369hAITkRQva9k3r9
 Z1yNLLUKkWmW5FxhTQQTCeCjoJTre9QLG7M4pkbeQM+sT8n+LctjRUuIDGQLVwMrCOZY
 3vr9swVxYP+1U/xBfPBYUFWIAbQHKAJXY0kgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757076065; x=1757680865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ji7/0YUfEb7w80UAAeFM2wfGH4dzagCszMREoTp/cew=;
 b=Qp97rAI87nYQOiUQmg/wciL22f9yNpYiRZKHwCxbbdtvZfNt9IHmJ3sB2E13ikiVw6
 YrxKp0kt0cflBnhRsX8fDpL9RR/Y9KgjtVEdg5KFjE3cZ5WbvbPidYtHKVn8xbIYqX9B
 t4zTyNxph9/lSwgx6VR/2Nr3+gaUXRLlHHc35ODTrY2xulv8kX9kwg3CHs7arYRig0Mg
 F1Z9MKanx1PvRYKmzzNJuL6J6s3uO7hp/kLYLFvrohkTHaWGWvghV3s9KMMJQWGhV4Kp
 kbFZBwuwzGu0B7I/ipep/CgTvDWEvpFVBmacVd5uXUXHhj90DdAaS12KfH3kEnecLVR/
 KAEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA/bHuflUV+Y2l1Ma0CETyTQ+c8r7A7s9K8ebmic5nuppjsHWLx7vgi2M9o46unq1utws=@dpdk.org
X-Gm-Message-State: AOJu0YxMvuHtg2ObxuIgTMVW1cHjE1T/PD0TDjBNs5R4wjVWH0gEyihU
 KDe3Q3u+nh8DVIs7hgcw0IGK9KuKSVWeSiKcgcXNi4e59Hnphg3rjf58v0vvFiRvqNg=
X-Gm-Gg: ASbGncukWKR4mDv1R/zwpKfDAVfoMOLQcHh6ldnC86OgDTOjE/G5ogZ8rpQ40OSX9T/
 qisvZZs6/nN+3nLj//A04JYJ1PDDEL6gHPSkGkh4NzUlR24Ar8SrWFR/4UPn1LnfIHfnaR1jAt4
 DjLMBWNu4g2tGSP74q/SdOeewayJRTBXR/V5dKAuzRjCJT5e649QkJww2L/NzNXi6qbn31XoPcx
 pV/K5s54bLhXbl+Sj5ECqPfxXn7P/ZJixgjCu9ecS9mirgD22wbPv6zpetqIzUltnwjSL319anx
 ek/gSHJpvr8g/mLDr7j1EavL6RBXnnhxykcHnk4I3Vvc1wPfTadm9vDp764hJ9JE7r4T6PFWxUu
 jrJZP3u7BYI3kxmyKr8kVhjJeTAHveLKgzpa6H8LrGPRdEN5IFjCJOIjRixWX2qztRg==
X-Google-Smtp-Source: AGHT+IHvDW5+SPkNtcsc4miOXZXTHjYvjFSojpybboO7e/EMDh5SWGYOlVKC0N/1gp6s+K/Epuq2Bw==
X-Received: by 2002:a05:6214:cc4:b0:723:5bc:e16f with SMTP id
 6a1803df08f44-72305bceda3mr112531766d6.3.1757076064498; 
 Fri, 05 Sep 2025 05:41:04 -0700 (PDT)
Received: from dhcp-10-21-133-214.unh.edu
 ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-720b4665fcbsm63947056d6.37.2025.09.05.05.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 05:41:03 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v5 0/1] dts: add missing type hints to method signatures
Date: Fri,  5 Sep 2025 08:40:57 -0400
Message-ID: <20250905124058.174777-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806162900.273571-1-abailey@iol.unh.edu>
References: <20250806162900.273571-1-abailey@iol.unh.edu>
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

v5: The only change made in this patch was replacing a method
argument that I had removed in v4. The kwargs argument in
the traffic generator class seemed to be unused and was removed which
caused the v4 patch to crash and now is put back to how it was prior.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>

Andrew Bailey (1):
  dts: add missing type hints to method signatures

 .mailmap                                      |  1 +
 dts/framework/context.py                      | 10 +++---
 dts/framework/exception.py                    |  8 ++---
 dts/framework/logger.py                       |  6 ++--
 dts/framework/params/__init__.py              |  8 ++---
 dts/framework/remote_session/dpdk.py          | 16 ++++-----
 dts/framework/remote_session/dpdk_shell.py    |  2 +-
 .../remote_session/interactive_shell.py       |  6 ++--
 dts/framework/remote_session/python_shell.py  |  2 +-
 .../remote_session/remote_session.py          |  2 +-
 dts/framework/remote_session/shell_pool.py    | 10 +++---
 dts/framework/remote_session/testpmd_shell.py | 14 ++++----
 dts/framework/runner.py                       |  2 +-
 dts/framework/settings.py                     | 11 +++---
 dts/framework/test_result.py                  | 10 +++---
 dts/framework/test_run.py                     | 36 +++++++++----------
 dts/framework/test_suite.py                   |  4 +--
 dts/framework/testbed_model/capability.py     | 10 +++---
 dts/framework/testbed_model/cpu.py            |  4 +--
 dts/framework/testbed_model/node.py           |  2 +-
 dts/framework/testbed_model/os_session.py     |  2 +-
 dts/framework/testbed_model/port.py           |  4 +--
 dts/framework/testbed_model/posix_session.py  |  2 +-
 .../testbed_model/traffic_generator/scapy.py  | 14 ++++----
 .../traffic_generator/traffic_generator.py    |  7 ++--
 dts/framework/testbed_model/virtual_device.py |  2 +-
 dts/framework/utils.py                        |  6 ++--
 dts/tests/TestSuite_blocklist.py              |  8 ++---
 dts/tests/TestSuite_dynamic_queue_conf.py     |  8 ++---
 ...stSuite_port_restart_config_persistency.py |  2 +-
 30 files changed, 113 insertions(+), 106 deletions(-)

--
2.50.1

