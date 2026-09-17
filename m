Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE440C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 15:19:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D975F427E3;
	Thu, 17 Sep 2026 17:19:43 +0200 (CEST)
Received: from mail-ej2-f21.google.com (mail-ej2-f21.google.com
 [74.125.228.149])
 by mails.dpdk.org (Postfix) with ESMTP id 5100C427B2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 17:19:42 +0200 (CEST)
Received: by mail-ej2-f21.google.com with SMTP id
 a640c23a62f3a-c254fa663c2so130859666b.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789658382; x=1790263182; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gBgAfN4766KDpYi3Bqo6e2xv+rO4lGLazpMhTJ3lUVw=;
 b=IaA5x2w1rnrIZ9vnvIwnb6gYSqOorAz3DHiMe2UGmZ6d2BCPs/mziNl2epfGoJq7Li
 capoM6VAS1A7GFVNpn8OMPAZu+NqfXP2fZsfNMQjYrEGfyQMc51bcq/kXogQZ6gLJKhs
 sn2WPGdTjIQT8d9wyVKHGfCsZqb3FoPGZ6hD5ZzX7REGymYsjXzONlcL96nbZRPE8mYL
 c3sWQZJn0oi/Jmy89I+hB/YXi9RAtXSC+OPdoTqNTMF2sxVK++/HT2RACLl9p4+psEGE
 XcKp/svSdsMU2V9gnXm0INW1F6250OuGDO7R+XY+UBLh8I1+NKF9vTPmXJTLM6kqwnwf
 kC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789658382; x=1790263182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gBgAfN4766KDpYi3Bqo6e2xv+rO4lGLazpMhTJ3lUVw=;
 b=dgfNZ1tNa9QX6QTPAGarLoiblgzCJ9EejZDHeld24qNA9K71v20kTPfzPCR+vOQZLY
 JqejjG2Y7h+PX5dGkkyoHzBB60nxSttjSBm7XzTpkRO1izN1MGdVm13xkQRGv1AbQZJm
 ij5lPpcMvPulb7M1OwcbVxjOcktG1FkXY4TctO1XOKrYN7Y5Pcns/4t5yUic//0VQkLi
 2hcL1blH4YBt1LQVktGHHBCJZPf1J+H1vZLF3bFWOzgNribS7vaeNAXZqCXhi9ZzcJd+
 /9OT3CV6grHRSZ0hWIFmenzAR/pZJdSmUVk+G2zmYdfLCPHWYbIbMkKNpwtMH20ia6SV
 IjzA==
X-Gm-Message-State: AFuF++nP9Hrmycr1D89GIXCLYpxiu1itJcK6/5WmjSslWLmUzfUGmFWr
 4YEPzG0HqbV2O4/VOBm2UVYw3jLHzBgFA4p+OfDRRu4ND2z0WQthd0cNZcs7XGq0grs=
X-Gm-Gg: AYBFou3bjWNxIVDHeeBccJ4LzWptwHWZm2NHZbD8E2e+qwayUrj7zSGE8zk47T1NOY8
 xvVYNixkK8mRniwLeoLYtBgIhSa9VIH4R6QqZgBDkVss7jjVthQDF/0SIUjzi2TKs2eQEwVNVP/
 BOgmSpIx5hY/qRmSoae/w9HXxBlba5i+wRwmhtV7RDUYaOO/R7SnFVasDRPGM3Qrm3rJUY4jO7w
 68waYn87BmQ+9lJ7x7oEhit5eSW+EkMRNmTDJlpv8nW0qyh67BX4MgIj+mEDTkwSlXtDuLYrs4m
 M8UuakPTMNCtdtzlciX4/tuIfDi5hqGnrciXaIPJZBsahBgdUZg1XU6tk8ya+iYtwb3uGccgfSm
 rNx3X5/0qf7tqgncbW8m9Tt+uNZS6M6S4NtamahZ571e3rKzz1miwtCt3QFwc9Rt4EffVsPV9yN
 KTr5ujNRcaTrHEt5KPiei/yZKY+Klox7srP29KQrfN93QYJGOxd5e67hLmlok=
X-Received: by 2002:a17:907:9413:b0:c29:f5d5:5a91 with SMTP id
 a640c23a62f3a-c29f5d56155mr290558466b.27.1789658381694; 
 Thu, 17 Sep 2026 08:19:41 -0700 (PDT)
Received: from dpdk.lxd ([89.101.57.120]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de0851ebsm300904666b.4.2026.09.17.08.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 08:19:40 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: 
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Subject: [PATCH v3 0/1] bpf_def.h cleanups
Date: Thu, 17 Sep 2026 15:19:15 +0000
Message-ID: <20260917151916.48749-1-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911124414.63321-1-marat.khalili@huawei.com>
References: <20260911124414.63321-1-marat.khalili@huawei.com>
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

