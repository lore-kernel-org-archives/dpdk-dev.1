Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19A1D31A02
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 01:51:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F1FC402A7;
	Wed, 14 Jan 2026 02:51:56 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 03C7E4029D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 02:51:54 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so89536345e9.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 17:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768355514;
 x=1768960314; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BY5lbjXB7y76DWe02Equ6s+/5DLYn6lzMkqJoIsjWk=;
 b=lrfUsUWyEA73qLvJ9mluf6h52l2n6mIK1FLRB0F4rs17BFy9TnbMxsU5PFkL8k1Z0w
 3/UVdYBPURycwtuk1B3gOVO1zVfzrSfVnb7RIOI/oCJqn2ocSZmnZdydZzXlcekXt0Bl
 pgvz428bYLk0kB5DcNL+qfXg7GEr/e6yJpyEdBqMwKDdDlaUqp+L+RsTKzK8Tpa9RrhU
 T47CPJylsc7cLQNXdOORLjoyIiXjIcLhX8u0xXO6kmyd2UTjz3Sbei3aGoA83PqFM3WR
 SsOdSfesPEaOfUkDsCaYlqoI8V6djtfHYmx0taCb7Rn3KPM3aC5GDe2HU6hgi2ukxOZi
 zS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768355514; x=1768960314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8BY5lbjXB7y76DWe02Equ6s+/5DLYn6lzMkqJoIsjWk=;
 b=h3RhMGKXWLMj3CyuGGTLowQrRq5yHfCvJX1ByzNSQrAwPTnXM18QDU1xXPV1tPmoX5
 sgsQ0tw52wjd2O3/OtWon5OjZjFFoYrjXtf5C7cD+3tJHFn6quTC/vUIracRi0K0riDg
 yJHAj7nJxuKS7m+h4qus10mkOUDf2HHwgGyhbc4qzthnOtxYXgpN9TZIpIxuYihP/Ivf
 zk/orGgtis0bl4zts1d8oCwUR0/uhBrwRhvxwwOoCwhDFp6Q7pYewYDWdQcZJfQZ9zt0
 QSAayyZz8J9RqSBG4YFp4SlKlbgVpZOTQ/0zhIBa6EKGLXdvcOVINKbyd+PEt4BOau7V
 0Icg==
X-Gm-Message-State: AOJu0YyJxmdi1j7yJgD6pM62MMJCbKObEyifSg+t+fhsRPqaGw3BBktb
 gwqgGyXjvMK/RqRByFwuvrnDiKog8QSkP2oa8aKa3JZYDaS7STbSPKwGPkoXy/74bv4d/gnmsKD
 /PXvt
X-Gm-Gg: AY/fxX6mc2TMKHehEL8U/PBQzbkjHog+oVCKu7FGrmuA5Xn5lo4ZmhGaF38vK6d3Rja
 6oxvmjf0sT/Mm9hgjiDZPtfKv7qZCLSCfbCdvgbVb656ip6+lRmpbUMtTqoUu39I9DkTXrp4I4s
 Nln51ynV5XyX1MDyvx5giDB4A8uEwpb3cv1iQmAv0a/YNk0sH/k4uZWTAYQM8f6oFNyweMuTPxc
 wLxG3M2bRHprxgnXllPALdmURb5u1XP8a0wsjACLfThLo3RvdUCXhRiR4/ILiHMAeyeDg/2bx6S
 SlnE5iq1yVHAb6BwE/K7rgRESoB/4iHh80uoJIb7/mdCn6vqtysXf0J7jsV9ekZ7hfQxIGe3w2h
 aSJLkBHI8k/5z8dZbywy4n6LPPoQszEFIQtwAFQyKzM2urPidgAjw9agXrIjPc0y0eGkS6w/AYq
 Qh+uACPSdD67/P/r/XsUFVr+ppsWBKFMIFgtFpaekyx4XcPkmmwg==
X-Received: by 2002:a05:600c:314f:b0:47a:80f8:82ab with SMTP id
 5b1f17b1804b1-47ee335e701mr10646475e9.24.1768355514273; 
 Tue, 13 Jan 2026 17:51:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e1adbsm47619810f8f.17.2026.01.13.17.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 17:51:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/3] common/cnxk: remove variable length arrays
Date: Tue, 13 Jan 2026 17:49:58 -0800
Message-ID: <20260114015149.70983-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023194237.197681-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series removes the use of variable length arrays (VLAs) from the
common/cnxk driver, allowing the VLA compiler warnings to be re-enabled.

VLAs are problematic for several reasons:
 - They can cause stack overflow with large or malicious inputs
 - They prevent certain compiler optimizations
 - They trigger warnings when compiled with LTO (-Wvla-larger-than=)
 - They are optional in C11 and removed in some C dialects

The first patch addresses the AES cipher function which always operates
on 16-byte blocks. The VLA is replaced with a fixed-size array using
the existing AES_HASH_KEY_LEN define, with an assertion to verify the
input constraint.

The second patch fixes the MSIX IRQ set buffer allocation. The original
code used a macro that expanded to a runtime function call, which the
compiler could not evaluate at compile time. This is replaced with
PLT_MAX_RXTX_INTR_VEC_ID, which matches the EAL's maximum interrupt
vector limit (512). This is consistent with how the EAL itself handles
the same buffer allocation in eal_interrupts.c.

The third patch removes the no_wvla_cflag workaround from meson.build
now that the VLAs have been eliminated.

Stephen Hemminger (3):
  common/cnxk: replace variable length state array
  common/cnxk: replace variable length array
  common/cnxk: re-enable vla warnings

 drivers/common/cnxk/meson.build    | 2 --
 drivers/common/cnxk/roc_aes.c      | 3 ++-
 drivers/common/cnxk/roc_platform.c | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.51.0

