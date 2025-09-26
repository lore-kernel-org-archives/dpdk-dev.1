Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37434CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 16:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BF1E40647;
	Fri, 26 Sep 2025 18:25:40 +0200 (CEST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 42DDF40262
 for <dev@dpdk.org>; Fri, 26 Sep 2025 18:25:39 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b256c8ca246so475241366b.1
 for <dev@dpdk.org>; Fri, 26 Sep 2025 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758903939;
 x=1759508739; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OoBRVvy/G2dC7cDf9MaZHP3VKp5UwAMBI6GbCZE4ftM=;
 b=T3T+9VY63JvA7G/Cc5mxeoB5psnd97Mj0E3aL/kgN8cFG3eyhYmSr/MfY2Q63M5gkT
 y6wC42q+NM+ADW4OtDKM9t2w9wPJVHw5AEkotCbYmaY45hy/yAx98c3AsycYJ0LB67FX
 yoRg2C/ebcoXfytpfj/FLig2lAvNG5spnxnJ+gato3TMIN4FSCB2Dcpc21YxEzK/erN1
 v8B3G2K884rdsKlxql5DwkEpIKQAxMQ3OEAMpzokIbuLgH+wcUKzTNWDPCQ9VGSDTwp5
 0keIEk5txiiNNwZxHdqI4DmZkls4CrI7Ab2oK0Duz98WUyGVd+WMOmnnwElSz9BFO8sf
 4p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758903939; x=1759508739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OoBRVvy/G2dC7cDf9MaZHP3VKp5UwAMBI6GbCZE4ftM=;
 b=LuUvOHJ+N4rj/7Z1LS1g2Yd3Jsfg84SFj7EVLy7r/Kyk65zl79rZXqwItGJNxlp9NI
 wT0o+l4AhopkKRlfESyh8lahyU57ZueWfaWNL+hoQombDdey300ImjRKYRGFhrMswrqc
 HrAj6PN/ga2lNd1Emr6vhE4SIh5PJShgK90ld+IQVMGz7Qq87s71tPyhMPyBc7l6FE9s
 TNJxC3J7Z5ehssx63JXrzdzmQZuuJcLDHzu1Gi0SHrkls+4mt4N2d8ZaUmbcB0aVaKQR
 I7eGi88pVo2udQdgJ2iZLhNDoU5il9NT9ErO8a/M2ASz2zVJFdKz3pX16b6jnJBAs20O
 OUHQ==
X-Gm-Message-State: AOJu0Yy7ZnOQzoCXMs1JhHnQQUFTzMiFSxdipS5VbRni9zr/MsV1UoA3
 trCXPWWBerIvyXJg3DU/LxvxrlFcuBaH9PdwVqKB5GqHOHhbvqR7TrDFmYZxJlMsJ+UfgGOVjmw
 l1AAacsI=
X-Gm-Gg: ASbGncvd2PJYzFYEuVeEs3ynrY5JlGkD3exig6EB1gcl7zEUJpXA+fqAX/JLQJpD/cX
 +1vgxh4r7GZYzJUVmDHB4bbU0Fto1tFqybU2dlTsr9I3EySKuVUeQhWSDE2tMXyNi0CZVlmUP+K
 +9nzbgSqcrKtybzK49nay+1wbETrJazAVbL6pKeq8E8xC3yvspJmjyxOrHG+MzP8uqMpKFflPqT
 B3h5jk0ezm0wIf7E4OxqMG//BBAYXLxxSbi1uEIqX2NGS3QkOdMjQZnW5fZHwtR8IZ2hEA5nU/s
 dV3uDGInFPAF1CH2/xhiutr3aDrG2NwyGxe0gqh1NgAFQkOBYC4Qt1Job1XDLbXz38ZQBREhIMK
 veTRpMyVLvJARsHz3NGLtf/T+9RatAfayOvG3hhjdFQj4rBwewiBl6VQKtiWmFmaCkpktS65vOU
 gCgT8lvg5FK1PUIJptl89485+ATA==
X-Google-Smtp-Source: AGHT+IFeZggE1yO9Rw6j4dQN8xiNoepOl4iXn7BIpvNSSlRwgzhrrewI5NYgTQomLYIMRkknH38Zsg==
X-Received: by 2002:a17:906:c108:b0:b17:ec4a:4f2f with SMTP id
 a640c23a62f3a-b34bb700989mr965864266b.27.1758903938804; 
 Fri, 26 Sep 2025 09:25:38 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353efa406asm386638866b.23.2025.09.26.09.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 09:25:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/3] net/ntnic: prefix global symbols
Date: Fri, 26 Sep 2025 09:24:45 -0700
Message-ID: <20250926162534.401577-1-stephen@networkplumber.org>
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
Errors-To: dev-bounces@dpdk.org

The ntnic driver in next-net is not consitent in prefixing
all global symbols.

Stephen Hemminger (3):
  net/ntnic: rename nt_log_ types
  net/ntnic: rename hwlock
  net/ntnic: make flow_lock local

 drivers/net/ntnic/include/create_elements.h   |  2 --
 .../ntnic/include/stream_binary_flow_api.h    |  2 +-
 drivers/net/ntnic/ntlog/ntlog.h               | 16 +++++++-------
 drivers/net/ntnic/ntnic_ethdev.c              | 22 +++++++++----------
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 10 ++++-----
 5 files changed, 25 insertions(+), 27 deletions(-)

-- 
2.47.3

