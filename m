Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABCAC53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:58:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07AF640BA5;
	Wed, 29 Jul 2026 19:57:40 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id D8A9C40A76
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:33 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so1022708a12.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347853;
 x=1785952653; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j+6++tilbNRJ6kg26GjuFzl8xP9OUNprHsnbNrRi+O0=;
 b=nDekkWY4L1OKu8Oq8T7en352OHa6Tt3/CwJYAnhASzzQBjerNYGmZEGNFkyN53672A
 Ip487aB6trpnLuUsTDulI5xXFoaVFL7CUSTtB8/E3nLCXxK1CtPwLF4AwPaCurbLi6oY
 cz88kZBcH0NzrUDitVHKUCdv72AA+6MmZSu3RFcItdDpfz8huTeTCjFp1SJrTXQ6qtfG
 f9zvqLrefAcv1KNkdGGjFv2XNLGMu4rWhhYEHuANXgYUZYM5NgdTGejXD5rBQg+8wuEy
 4+2GARPtcuC1E1FgoS0NpCdZ2U0SFk7CzG7hCT4gSQi/q9apXxcWNL4gCJ9wb64UwNc7
 4NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347853; x=1785952653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j+6++tilbNRJ6kg26GjuFzl8xP9OUNprHsnbNrRi+O0=;
 b=hP/fADzUrGPfZK3DWN6Fn2k+CRPzUPoEyKaH+bYrkQlA6Efd1DgHdy6q1wW2M1eowN
 w6LZ96I7qSG/7hMSKTeH6t3zB8ZjEr7QocsSoDS1selqfpIfzX36+6lHwF16byG6NNwH
 c621bIp6eZJrlhw3Z1HcDlbSjXuiqueM7kKUaD3C1Ew2GsP4Ad77jvd8Svi8GjX17exd
 LfalarS2W9lX+yx0C62065vzDXOiRPTVbXNhtsuVu+VyYDDiVD0/Eoo9EAEAD8m0Waio
 tTz8AWtEBtTC+bZzYtMbiL2Jvo+bQgagY811R4Hf1A9B2SuBe2gCUCAxrKtB3Itr2GP9
 ptGA==
X-Gm-Message-State: AOJu0YxkJ62GMUhupXHuAUGZ0bVsVPrVF0d5sXtM6gaXqvzKFLvhB/RY
 b9Dn5wpWz1GvLjVoGiRYwWslv58Nj+cI9GuqEov28bcXGinPlmELoZL8T6HcnuZVEjYjrWJPtE1
 bmrlx
X-Gm-Gg: AR+sD13fepWjRqW+xKTXn2hwVkOdXhETYXsFZENHEEWVTaYaQS8/D9dKO0xAHF7RY7F
 XhHhgdZoDPRsVFgSx0Yz1GFQDkhl8dfzvEsqz4WFGyiDAjaxZWLqp2n6xPLR/q6Ibpn+C5heBSN
 SOkR3XqBaPWsOnYB2hxBB+3R1gwH5DwZNKjutMKRVt5JIKdMs3MEasUGpb4fxfCIhdZSpuc961E
 wGf3aAcsgJyY9CMWSMAN1ayPKiFFwj9LOG1KQ8dI9sJ7DrE3/Ryk6Eq/96pL1Pd8KlgRilovlGv
 +73FjUHZ8kTij6/2wbTnvcl5c1Wu5by2bqA1YXHmCqRfv4hWA/IWCqOxRfpLYVumXpmlhNQKJNT
 BpC79IyYxzPpZ5qDdsHN38U/ye15QdZSFlmcZsyNT64dEPtL716ut41U71OJvKXRZIDpXGo/Lc5
 hCiQLeTZivBAkblGAmRfmAAFxm3lC80dwSOmZKH1QWb5lsl/e8TPYwD/b/Wy0hxHxytV0swUJur
 ZjqONfRn9uhT3Z00YlvLBm+L5/n
X-Received: by 2002:a05:6a20:a122:b0:3c0:9c18:d5a7 with SMTP id
 adf61e73a8af0-3c8ba6c55ddmr9288069637.68.1785347852991; 
 Wed, 29 Jul 2026 10:57:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jay Zhou <jianjay.zhou@huawei.com>
Subject: [RFC 14/32] crypto/virtio: update comment reference to rte_smp_rmb
Date: Wed, 29 Jul 2026 10:54:07 -0700
Message-ID: <20260729175715.165120-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

The rte_smp_rmb helper is no longer used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/virtio/virtqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtqueue.h b/drivers/crypto/virtio/virtqueue.h
index 97a3ace48c..23c001a8e6 100644
--- a/drivers/crypto/virtio/virtqueue.h
+++ b/drivers/crypto/virtio/virtqueue.h
@@ -302,7 +302,7 @@ virtqueue_nused(const struct virtqueue *vq)
 
 	if (vq->hw->weak_barriers) {
 	/**
-	 * x86 prefers to using rte_smp_rmb over rte_atomic_load_explicit as it
+	 * x86 prefers to using virtio_rmb over rte_atomic_load_explicit as it
 	 * reports a slightly better perf, which comes from the saved
 	 * branch by the compiler.
 	 * The if and else branches are identical with the smp and io
-- 
2.53.0

