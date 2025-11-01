Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B021ECCFA00
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Nov 2025 18:07:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78A1D40270;
	Sat,  1 Nov 2025 19:07:04 +0100 (CET)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 37A9140261
 for <dev@dpdk.org>; Sat,  1 Nov 2025 19:07:03 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-781206cce18so3645876b3a.0
 for <dev@dpdk.org>; Sat, 01 Nov 2025 11:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762020422;
 x=1762625222; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/JI4DdXL3oDQjXhW22iwXceFR4RBz/JayrwY6GZApQ=;
 b=ikC6misdCn7aGsn2lSiTI5KTYAa8FrG9BEfH82Fjf3fdPq9hcO9JIqXzoeceZhjggB
 g6nSg7fqCDvHCRJwbOrywPl1b5C+q5ZoMw+v//2qyP5ASBkY77jsQlGIy5ZJBj1T1N2f
 1dRnfam/ec91yYK+svGQZAwPJAyivGQVw5hvo3aQQfs0hJPahDNjy8aQwoX9L9u/hexz
 wu9+I7OAo2q35DCiA9vAHeTuzbzgOMsJ9Y+u9F87ky7CWxFdOOHsfvirqZotF83To//7
 zfVCWlBqL1gz84/qeIaPTVNW25m0VaRY8BOZL0ketypSFgWWSHVebz/ggyFo6tNb00DO
 ikjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762020422; x=1762625222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/JI4DdXL3oDQjXhW22iwXceFR4RBz/JayrwY6GZApQ=;
 b=C0Z7dmCvzSjMJ6SbafyCdnHX2mlImxVyLxg29C+0xpUv0hRkW69Hzhznvj9OYt6mID
 ygL9rHMGBH3sDmp9zML/UUCzfTOudlhP+En0gJguf706oDtde5jWkV8MAsR+B6GsMUxM
 jJ+9fJV9SQGhQXCfjn97yjTD6N+drtDdtpU5Wx5ryjsXVwSy2rraH+MC9DIwNNo0JcC4
 1Ar2WCtMv1iqlMzPmcJ76V+Ae3W2cIDrB0lqNEq7/DRC9DTox625B5lOA7G+CbRJaRx2
 sDN4F6Mw3+8IOEpXBiDymaG0twjl+Bf/YmHi7L5rU8xVpdqhFfnHsGuCbLH8wmCHyOnU
 Qg1w==
X-Gm-Message-State: AOJu0YzNuUpu1Xwe4/0Bve6A46eD8gcx2ZK0E2eLVig9rpdeGK/i+Fbj
 +JMxGu84DAXVFsF/Z4EjYLsf+XMi+Tc/UMluWiwBSHT1bPyy9tv2YrbHC0BsB13hSACS6Zfv0qp
 Ed2Qy
X-Gm-Gg: ASbGncv7QQWwHRzkE6bljzA3URWGAZhq4Kh7LG2w3qq75DHlXfMfMFETxYWafanBsQo
 l4SBfJhSR5CgSHctFO0yO/ouqfjGBdKl7xLOGweoJN5FnUhWf9wm3e4NrD/hClCqdu0aMxSvlOm
 7VjeRmdkXj6MY/Eax00eqrojqFkmAseWE8aO+une98oQGopK9py4WKm4v9TSNlNHtDl6/Q8yGOd
 aEk2nj7TNe8RUqqUJWuhEoByOE1fh8ao0+phtxFpYdraJ6KfHePu2yFvLxjSiXEymNvE+HXIyUW
 xGLorsBYjKhyPXsjCIIx2NRQhTq0Dz1/IqABQMc+6VbWtbW9NWUkVziTt8Ew8wJar+XKCPjttd0
 j4lCAnmGWrzl4jeXK2o2qEv3D0rtYhBswF0+MuaBlrTtuvFyZRioIHkr2Sfj33HVlgSjAUqVB3T
 w35vDqBu6r62t6ywXVnC6Tk1cvSeKGceTtCfPzakM=
X-Google-Smtp-Source: AGHT+IH0Ntkk1wlsfIafJk1DG60pgVKEkja4IzJ/hJHkieGlZ/S/BRt8x/NuIPjaDUUcfnU0Y0lHDQ==
X-Received: by 2002:a05:6a00:9507:b0:7a4:24af:e16f with SMTP id
 d2e1a72fcca58-7a612eb8487mr14018440b3a.3.1762020422078; 
 Sat, 01 Nov 2025 11:07:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db0a019csm5861606b3a.42.2025.11.01.11.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 11:07:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/5] BPF enhancements
Date: Sat,  1 Nov 2025 11:04:42 -0700
Message-ID: <20251101180659.43883-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030173732.246435-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
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

This is a series of fixes and tests for BPF functionality.
The new tests for Tx and Rx filtering require the infrastructure
to build a bpf program (clang) and the tool to convert object
file to header (xxd). If missing the test will get skipped.

It is disappointing that there were no examples or tests when
the code was submitted.

v3 - do not depend on xxd -n flag which is not present on versions
     before Oct 2024

Stephen Hemminger (5):
  bpf: add allocation annotations to functions
  bpf: use bulk free on filtered packets
  bpf: add a test for BPF ELF load
  bpf: add test for Rx and Tx filtering
  bpf: remove use of VLA

 app/test/bpf/filter.c    |  53 +++++
 app/test/bpf/load.c      |  62 ++++++
 app/test/bpf/meson.build |  53 +++++
 app/test/meson.build     |   2 +
 app/test/test_bpf.c      | 451 +++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_pkt.c        |  84 ++++----
 lib/bpf/meson.build      |   2 -
 lib/bpf/rte_bpf.h        |  11 +-
 8 files changed, 677 insertions(+), 41 deletions(-)
 create mode 100644 app/test/bpf/filter.c
 create mode 100644 app/test/bpf/load.c
 create mode 100644 app/test/bpf/meson.build

-- 
2.51.0

