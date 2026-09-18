Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85D6C982DA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 09:21:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88A0F4027C;
	Fri, 18 Sep 2026 11:21:49 +0200 (CEST)
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99]) by mails.dpdk.org (Postfix) with ESMTP id 1329E40276
 for <dev@dpdk.org>; Fri, 18 Sep 2026 11:21:48 +0200 (CEST)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a98505364aso799168a12.3
 for <dev@dpdk.org>; Fri, 18 Sep 2026 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789723307; x=1790328107; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=63DnUtbpJorAQK58/q4gE95oq4Cj/itqkBqbM1gn6v4=;
 b=U9uDbtuWFiJ+rNtOnGfioqSZDLPWQimtfJ0ioXDgzNnuubddJ0q1+lV17uQVS4a8Xj
 YCFiYN2MxFazz2nJXTrjxeGFvDekfDN9cY2tC8doKCi1g7QVu67OVk8za88RzpygMIcY
 0bO2s73KXDh3MeKDCmkqLhUoK3jZEwMngXPfw1eD2T2vq+S1emWQAba3am1KFVrAlSRA
 P9bldVbgLBpVFLVnchihNBHbsT+a7+zD1VGa4E6CjuIthh1caBG36rtnNNglT4heGUmo
 BRddiKLSPiKMMGm3xKJ71jn1Jp8Ep0Zlr2DLeuOKWCKbdGkt9Q33KU5mNDv6V2L7YjjK
 VIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789723307; x=1790328107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=63DnUtbpJorAQK58/q4gE95oq4Cj/itqkBqbM1gn6v4=;
 b=Wgdm5lQnB5WfczpDCeBiGrk4dqDmWzNHbJ0W8XbPwNe53YAj3kaObm2HCp/cckrUlk
 XDTEgQ9YJQZTCYteGdH/0wPvJvaS75r6pRv08XV5uyYaaEgRzzTUe/9FNfuosqDa+eRn
 bT5jdoFeE4EKXDE0BTmrCmu+lX5p+FYqb6RfhBJ+56MObP5UI7FRBB7h6WVJE19xzUzm
 W+cU+16ow9ouXw88qYhPgEYYqN+dFZrZCkCLMVZEQyGWZtDK16NxCu7icy1E0GjRJZRU
 PNoy39q0BiBvW6NSQdiiIIvHBd2aHwKM/wFA7T0vUqoYGjouownd13JpeTXxtBYG88fK
 O9fg==
X-Gm-Message-State: AFuF++nmQLloGeeRL0maXVykWtiQdpOv6vnuv1vgh6kOCPh3emWcW1Hh
 fqGCQrbw9LOzGLJuzZrwe8i49OqbSqc/h8n4XG2HCPx5by6zhVBCpDCQ0RHTrffns1Y=
X-Gm-Gg: AYBFou1uyeYoWL6+qJaAil6vfqERtqXzeVzW2aK2FwnschULw8gG5Y3D0CAWjNrC76g
 T82FQYvckd+H9MGEYxWqcwdFsJSnZgGcJyK2F2U9UVK8ePvpmF7mLGOLOOOr/EWpvFEb2l3b+OJ
 QWtyhoQGV1xO86tDaFOw8wJw3qHA5vE3k2OBuYdWKUb0u7N49YVosRP79FplQcHkgVt92q2SQLX
 JIN3AN9tzOIjwirgphntUmkr/EN46m/921M1CNfYusnw9ZriT7GCIG10lo9qZePLTT4hrFOOuUJ
 rH5gmJCjqA3m+I6yONo1pX16WU6MxYvd1EL+faG6xhDABlzt3GfIDvEZ0wqNj5MPUV6MyuxM5Io
 M+HYBGU1ar++WW/JSiHDRlBhmQRa6pYCQRF2uRbP1Jn803MxY9chBt2pE1vYkgNqAo84SjPRfp0
 LSoSXjk5FzUMZhqj7AgjCXdRq0IDqsEcNQE2kuDueDh67ev3qxea5m5Jk17Zk=
X-Received: by 2002:a17:906:c111:b0:c26:1691:b368 with SMTP id
 a640c23a62f3a-c2a157fab8amr189263266b.33.1789723307371; 
 Fri, 18 Sep 2026 02:21:47 -0700 (PDT)
Received: from dpdk.lxd ([89.101.57.120]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a1bb8a1desm37190166b.42.2026.09.18.02.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 02:21:46 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: 
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Subject: [PATCH v4 0/1] bpf_def.h cleanups
Date: Fri, 18 Sep 2026 09:21:15 +0000
Message-ID: <20260918092117.74231-1-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917151916.48749-1-qm2k21@gmail.com>
References: <20260917151916.48749-1-qm2k21@gmail.com>
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

The goal of this patch is to clarify the public/private status of the eBPF
definitions and prevent name conflicts. It achieves this by moving the
required public symbols into the public ``rte_bpf.h`` header with a proper
``RTE_`` prefix, and making the remaining ``bpf_def.h`` header private.

v4: reposting verbatim after additional tests involving external apps.

v3:
* Dropped part 2 (renaming macros) as there was no consensus on it.
* Added a release notes entry detailing the API change (bpf_def.h
  becoming private and public symbols moved to rte_bpf.h).

v2:
* Following the AI suggestion renamed `RTE_EBPF_FUNC_MAX_ARGS` to
  `RTE_BPF_FUNC_MAX_ARGS`.
* Rebased on fresh main hoping to overcome the unrelated CI issues.
* Cautiously re-posting without the RFC label.

Marat Khalili (1):
  bpf: make bpf_def.h private

 app/test/test_bpf.c                    | 79 +++++++++++++-------------
 app/test/test_bpf_validate.c           | 74 ++++++++++++------------
 doc/guides/rel_notes/release_26_11.rst |  6 ++
 lib/bpf/bpf_convert.c                  | 38 ++++++-------
 lib/bpf/bpf_def.h                      | 15 -----
 lib/bpf/bpf_dump.c                     | 13 +++--
 lib/bpf/bpf_exec.c                     |  8 +--
 lib/bpf/bpf_impl.h                     |  3 +-
 lib/bpf/bpf_jit_arm64.c                |  4 +-
 lib/bpf/bpf_jit_x86.c                  |  2 +-
 lib/bpf/bpf_load.c                     |  2 +-
 lib/bpf/bpf_load_elf.c                 | 10 ++--
 lib/bpf/bpf_validate.c                 | 44 +++++++-------
 lib/bpf/bpf_validate.h                 |  6 +-
 lib/bpf/bpf_validate_debug.c           |  6 +-
 lib/bpf/meson.build                    |  1 -
 lib/bpf/rte_bpf.h                      | 33 ++++++++---
 lib/bpf/rte_bpf_validate_debug.h       |  8 +--
 18 files changed, 180 insertions(+), 172 deletions(-)

-- 
2.43.0

