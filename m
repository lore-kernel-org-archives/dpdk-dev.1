Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA6ECCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 22:19:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EB9D40281;
	Tue, 11 Nov 2025 23:19:02 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 20A4840280
 for <dev@dpdk.org>; Tue, 11 Nov 2025 23:19:01 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7ad1cd0db3bso163351b3a.1
 for <dev@dpdk.org>; Tue, 11 Nov 2025 14:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762899540;
 x=1763504340; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMLGSCeL/4Vj/4SNS2ooDLsLggqe36Nzo64cXi8c6Ls=;
 b=MvkarMgbqADDm8Ng39ctFGg02+rV0sB78VSqREXhxvxLiFdruGZ+blTgLTyagD5gkz
 G8JExGl9K6VjLJ/LkngslLmpVK53bL0aK4g1z7HRSi/kZOoOIwZPOrG4O0KLgNpg265C
 7iMxfNBUJNXbxUzgBvHomqECc8yvg0VHsar5ljOUy+iSU5zIPl8mb7Unsd0Nq5lY3YVH
 GfaQVjDH6VCD6IyCoO9F7bvR4Mf+ZOCdGJxH1xVziYH5saW1vLjB7Kw0P5YO21KeQ3cN
 Fhf1AeVxQorasxConB5uXjuD+Bei6qVhuvKEZGXDfkNzJ30mcxIKJarwCDp1U01OV50/
 1n4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762899540; x=1763504340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YMLGSCeL/4Vj/4SNS2ooDLsLggqe36Nzo64cXi8c6Ls=;
 b=GcDKVLZ8sAAEX3zhmB9bXuygE0SJKHDuaZ0Dmx9YLuaoCFqN+aAM0Cwzy+tg0NJ2Qo
 /eGPtpfzxsaoW2xUNFVi7lGsNPW4Ca0cVeTXy1ZScAgD3xJOVFaY7JkF9TZppgcNy//r
 9luzwS//LJ6jZ+ztk5/V4hEuFA3lVzC5bnCbrh6+DI5EzgK84ekSnCbHAj3SHE2PhVfE
 4L+G5v9saYslrc9oIYJUVdYudlgBMBMvFW020gAM10KA/DNO21EbTn36p2H1J+sWJ4Qz
 MALAQ6m6QCUFvnCzCCX6S3EVRdak2RhmeiwD18SW+sssAKHld3oz0Q8Vd8EwRFsIal92
 FQSQ==
X-Gm-Message-State: AOJu0YyDjB0if7+M42W4dnbohQgl6wCOqe5SMajf1Z9ctiez3rMa28MO
 u1Rs63kkII1ZGqISQrSGxI37aiIac0PcvzqC0S1HAZL1zC3gRBXxFIHszDZFADGD6LSkj3aCjiW
 5aNUx
X-Gm-Gg: ASbGncsTkSx79XotBMj4/k966jVZy+O3ekUk3pXsfuihz6sKtHYHEKdxM0n3ClzZfMB
 gpvVTFN7BpjrdwcP+YOapfzy+bD7Kk5xOVAS6TwKuiCbR+WjxHwiK94eVvzgiN/YttT7Pm5i6BI
 C0L6dDjZEHYv/UXiWdle+SpIxs1rcdH5cUCkTMUSB7QCRbV1QUMJlpOCyVZ/cf5EL4KTDGLH+HG
 V7Dufkhe3h8CPjNOl9386oPdpHL8C+qidH5OhZubp8Bz/Zes7K03W/PV24TBXo7OCyqT0eWmcOq
 zmvCi8auIEZQhR5HkxO612pIlktxMWTgydI2bQePmUz4Kic+KKm1/yNexy5II5JUSIY8WAAjRks
 9PQY9rt06fJlGZthybxzEVKIqi8/emh3NmNjLZLKP3mi3OaDYqMuxOuwHpTwe4zg18z/gKCpxOB
 ezdunu2Ux9jj9IACkJ3AKzr8S2Z3DUnxQcoVjU0ss=
X-Google-Smtp-Source: AGHT+IGJ5ouyr2wHvZTcKm+Ak6aNQYTeeohHOArPc1UCk0tHdscA4EfVHTj4HGjYNqxtpTcxuGpaXQ==
X-Received: by 2002:a17:90b:4c43:b0:343:d70e:bef0 with SMTP id
 98e67ed59e1d1-343dde8c6b2mr861341a91.21.1762899540163; 
 Tue, 11 Nov 2025 14:19:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e072e5a5sm157001a91.11.2025.11.11.14.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:18:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/7] fix format-truncation warnings
Date: Tue, 11 Nov 2025 14:17:17 -0800
Message-ID: <20251111221857.443752-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110182209.104087-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
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

Enable and fix format-truncation warnings in examples and tests.

v2 - fix build warnings (more fixes needed)
   - do test as well (could be separate series?)

Stephen Hemminger (7):
  examples/server_node_efd: fix format overflow
  examples/vdpa: fix format overflow warning
  examples/ip_reassembly: add check before formatting name
  examples: re-enable format truncation warning
  test: refactor file prefix arg handling
  test: increase size of memzone name
  test: re-enable format-truncation warnings

 app/test/meson.build                       |   1 -
 app/test/test_eal_flags.c                  | 161 ++++++++-------------
 app/test/test_memzone.c                    |   2 +-
 examples/ip_reassembly/main.c              |   7 +
 examples/meson.build                       |   5 +-
 examples/server_node_efd/efd_server/main.c |   2 +-
 examples/server_node_efd/shared/common.h   |   3 +-
 examples/vdpa/main.c                       |   9 +-
 8 files changed, 77 insertions(+), 113 deletions(-)

-- 
2.51.0

