Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD2ACA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:38:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DD66402EA;
	Mon, 12 Oct 2026 22:38:41 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id CD1AA40041
 for <dev@dpdk.org>; Mon, 12 Oct 2026 12:50:29 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-15354aa70e8so833278c88.1
 for <dev@dpdk.org>; Mon, 12 Oct 2026 03:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791802229; x=1792407029; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UfLeCT72MUQ/qkVGmQtbpaBIAhc+viL0Pa2beoOODq4=;
 b=a9x01VR6RwtpiAs94zzCxn/0qiOoRYCjCCrjvFVeRS2BZJRLMHCVHpsXckP0mtlgsx
 la4i9AFn8fgedQxkrSVGPZA+MDuCLNWMMVnJQg8xS+/iMqcuJaGN01uxOYkYkkVuV3qJ
 0hUZ4spDUbxgtTpnF0UEabmCP+2M/e4pTOO+cGOPYdJn4NhpanUSmMh4ixFMoODTvcpL
 BrRslUs+/DcKPI1UBhoHduyX3IsIPKu57hnwn+Sxiyw+lCmzTJPgV+VIduK+IeWreIZH
 O4qYszmsUMT1B66d19HfHZ+q1+kYiHW7aY9OPCexoWJwNBh1U7nUleOJPSbsUs6d79tw
 73wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791802229; x=1792407029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UfLeCT72MUQ/qkVGmQtbpaBIAhc+viL0Pa2beoOODq4=;
 b=GeNmtkHAqxp2lTX4lkhTfS9yXLG3ZPE/8mM/Lsi3Akz8gRVFZZ7FlV0ahCpunupKHq
 6FLlKmcrVK8DVhDWrXBtpvKh/KKSLr7beb6sMq4ZUAwedUyqpME79reQtKDURdINhtCu
 F6RL4Y03/ZvLT21iRQw9WJdmSV/EbTVFutT9E9wIIfH89FnLwdhFICkywsSjqGSTtd4G
 ZmVGWchDOP6NqNb8/lqhkmFpbmE56L3vUFHGWipPS/97fNpUfENcVsTNXd9pf1gmT28s
 07hB8BifUYivocz+jzT8/Ay9E1UIQmPR9UxKtNgnMONQpoGa6ns0EDpOAbiq6Ll2EKeM
 oBig==
X-Gm-Message-State: AFq9FYLQfwB7/93JNw3ltgEs2FFatBN96Tk8/6k2l3/4x+M0cxcH0V8X
 ZDDIW+m4PI1U7KboepLRLtSNNk3IaQnzoPjBkXC/VhJOvAnc0qWPUP98asCZSw==
X-Gm-Gg: AYBFou1zEfFRKUsEOz6xN+8ZOnBIGTi4xx8YqnC9fhBRmAYp0NTgN4ncPUtAxbxpIyK
 gr2syt1Usrb+VfcdbYaMlY3f2FBEdni7TOEifpo9IfMjYWNRjKIykhhqFr4uc7hAFx4rqZNZPLV
 CitzKZ7AmMWT0NBfZwZf7hdixI9afDsCUSMvXzzoFlztWLhX49C6BcFrzVz38Z9mK+VUPtIZkfi
 qqghVG0y4AjHiey1SZ8mUc/Mh3/trm9BkIWW3EoUOm+QokknsbEXRoAIOhv1oGKzB1qubQYFh5C
 s8JuBXQwr9vsOYoGCbAFHe57WMnaUBQFyQqZAF7kDjlyDE3zFN3UQjszJMP7D8UECb5DNHpPJLE
 wdqUdX6pKKsDr6Jcvs0xHIm2eTvbKLn4Zt2+5SKZJFVZmqLfbK/Fm+aFVhlHS4Zfmp6O+BQOZDO
 61q6bszaZLNCeZXmhRigTAXV3eh4izQ7WYqqhU/sS+c4bDTOVOVRQ4lPmFHrgbvNxp7T0gW/qg
X-Received: by 2002:a05:7022:7f05:b0:149:49c:22b with SMTP id
 a92af1059eb24-16a57733270mr11614247c88.1.1791802228645; 
 Mon, 12 Oct 2026 03:50:28 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm36875760eec.17.2026.10.12.03.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:50:28 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com
Subject: [PATCH 0/4] net/gve: fix TX queue stalls and sync DQO RDA with Linux
 driver
Date: Mon, 12 Oct 2026 10:50:19 +0000
Message-ID: <20261012105023.669486-1-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 22:38:37 +0200
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

This patch series aligns the Google Virtual NIC (gve) DQO RDA transmit path
with the upstream Linux kernel driver (drivers/net/ethernet/google/gve/) to
resolve transmit queue stalls and hardware validation issues:

1. net/gve: fix DQO descriptor cleaning loop bound
   Fixes the off-by-one error in gve_tx_clean_descs_dqo()
   ("while (--nb_descs)" -> "while (nb_descs--)") and avoids stalling
   the completion queue on unrecognized descriptor types.

2. net/gve: fix DQO TX queue stall on multi-seg and TSO
   Tracks descriptor intervals with last_re_idx per packet against
   GVE_TX_MIN_RE_INTERVAL (32) instead of counting packets at burst end,
   preventing descriptor ring starvation and queue deadlocks under
   multi-segment and TSO traffic.

3. net/gve: add cacheline overlap margin to DQO TX ring
   Enforces GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP (4 descriptors) margin
   in ring space checks, avoiding CPU and device DMA cacheline collisions.

4. net/gve: add packet and TSO hardware constraints for DQO
   Augments gve_tx_validate_descs() (which enforces the 10-descriptor
   limit per packet or MTU segment) with the remaining hardware length
   constraints: [17, 9728] bytes for non-TSO packets, maximum MSS limit
   (9728 bytes) to avoid 14-bit field wrap-around, and validates header
   contiguity and payload presence on TSO packets.

Tathagat Priyadarshi (4):
  net/gve: fix DQO descriptor cleaning loop bound
  net/gve: fix DQO TX queue stall on multi-seg and TSO
  net/gve: add cacheline overlap margin to DQO TX ring
  net/gve: add packet and TSO hardware constraints for DQO

 drivers/net/gve/base/gve_desc_dqo.h |  3 ++
 drivers/net/gve/gve_ethdev.h        |  2 +-
 drivers/net/gve/gve_tx_dqo.c        | 80 +++++++++++++++++++++--------
 3 files changed, 62 insertions(+), 23 deletions(-)

-- 
2.43.0

