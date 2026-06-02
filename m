Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29EFCD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 17:15:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3ED5402AB;
	Tue,  2 Jun 2026 19:15:57 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 540D4402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 19:15:56 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1363e78746eso14774745c88.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780420555;
 x=1781025355; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xwb62932dMusDraesE47NZKpTd3MxVLjeUKmvAyh3S8=;
 b=f05/bmvNAVE1TpI/+TRHgF0WeoQPebNiferv5wmmfhDb3rcxkN3LQ4Yx2sTJJvHfQJ
 YfbgP5JB6bQGd/TdzebzjMWyQSZdPTbH5PfRdSDpqlNxscR3jZFiXj9v8K+ZDJPww65f
 y6PAUP4ev1f4mSscAGkjtnlEuRApJkp/ZwgTCFp7CIcwIMIdywI3tAPAF/m7KoNf2d9Y
 jZ10x5pnfUWrEmol6g30z+nU2zC1zGojPikYf5rRt0tIOMPC48/eOgAgTh2ag/MsmkV/
 WVyCschRG/bEJYa5G/QZK2voShe6nEhy42B3ZcWRB5RfjYEUThvqLIE7TF8n+V5niAsr
 mtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780420555; x=1781025355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwb62932dMusDraesE47NZKpTd3MxVLjeUKmvAyh3S8=;
 b=U/OAkNTZqeEwh5e4Txw6ZfWBj/KoG28UlNqPuGCi5Gxp++JS8ge4X4g20D6/p+QWLE
 rxGDSFNpAmyiEcwEPedcxgREA6ZtOAIIajNeduB5IkFCpyIIohTEeSLNDKUgn6eb9npo
 NU7pprf0BWSx55hkQNvDlxv8YLfGUBHCKBXROBqELxoI+Nz+ut1FPX+jthXsuJbnUPaw
 xPZO32gLIGm1Jd1yyjvm1qG88taPwZHnsqmUdoEKA6ujX855+V0aemtOGYIFxO4ZRrJ2
 PwE6KKwAjjkeDdxyfl8OHwINvmfS3o/712VguUnI8MqjIg+0iY1NraGQPgaRW6G1xZPY
 0jfA==
X-Gm-Message-State: AOJu0YwhnntFWCd65VgwOz03fTuqrEr8Z4LnAFv2smR5F8kh7+LrINgu
 FFJI2g0UaOBOMHVm+sUEtihhNdKDb+TfG23Up/yOCHRBfchDukGFlVhax+FpFExxQsqkg2TQJYd
 Qf4ie
X-Gm-Gg: Acq92OES9RwIlPvBRk6MCeF0YdkoV7Zb5PNObEJcfAgJIZnl8+ddxjFPhdj4KkhZX6D
 OH+5ywGJ2N+XbCBjgKi5poUI93NBJteudb+QzEpyx5xLkikMugQ25odflCm1C1q5j0II9WW+NJJ
 1n7HsK/6L/ZGveQx5y8n7SY/RkM5uOF4mHHTRcFDb39tUEjKgiifWy4H4W96UQJz7pN/RKWWqa+
 IIMjhrOVKXZ36/QZspE4q28AE6SZLosfRDKVC7RzBjCRiayc8spFZM5ItImtGNNTuqJ81twkK7q
 qaRSeYuGZfWKSo71ewgQZXxVFnyHAl2WpmBVMA3S2CjKiA7/zDUlzjy3Ue/rF+GyfiGjs08Rytj
 M0u5HJXZ6Ai4tkKNBYBTrkuspnUcddQhdWGhyThosO9YBK9Z0Iujv7VAWeRQr/ccZvHh24lmrEa
 RmU/89xdtn+SxE6fXJwOSWCzGbMdQtoVpnx7Spvy0IwxqThNogbev/YvsOqRQfNBnCThyFu6Tl
X-Received: by 2002:a05:7022:ea2a:b0:130:ca3d:f963 with SMTP id
 a92af1059eb24-137d42c375fmr6724338c88.41.1780420555105; 
 Tue, 02 Jun 2026 10:15:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5539432sm256095c88.9.2026.06.02.10.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 10:15:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/5] ring: convert to C11 atomics where practical
Date: Tue,  2 Jun 2026 10:07:26 -0700
Message-ID: <20260602171552.686349-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

This is split out from the atomic deprecation series.
Convert lib/ring off rte_atomic32 and onto the C11 memory model,
except where C11 version has noticable performance drop
on x86 with GCC.

The pre-existing C11 and GCC-builtin paths lived in separate headers
with substantial duplication.  After this series, only the MP head
CAS (__rte_ring_headtail_move_head_mt) retains separate implementations;
everything else is shared.  Patch 2 documents the reason for
keeping the GCC builtin on the MP head CAS.

The default RTE_USE_C11_MEM_MODEL selection per architecture is unchanged.

Stephen Hemminger (5):
  ring: split single thread vs multi-thread cases
  ring: use GCC builtin as alternative to rte_atomic32
  ring: use C11 for update_tail
  ring: drop unused arg to update_tail
  ring: use C11 for single thread move head

 lib/ring/meson.build                          |   2 +-
 lib/ring/rte_ring_c11_pvt.h                   |  61 +++------
 lib/ring/rte_ring_elem_pvt.h                  | 116 ++++++++++++++++--
 ..._ring_generic_pvt.h => rte_ring_gcc_pvt.h} |  62 +++-------
 lib/ring/rte_ring_hts_elem_pvt.h              |   8 +-
 lib/ring/soring.c                             |  34 ++---
 6 files changed, 161 insertions(+), 122 deletions(-)
 rename lib/ring/{rte_ring_generic_pvt.h => rte_ring_gcc_pvt.h} (63%)

-- 
2.53.0

