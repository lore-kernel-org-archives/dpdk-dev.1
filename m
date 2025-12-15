Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934AED5B872
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 21:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E2F7402D3;
	Mon, 15 Dec 2025 22:40:56 +0100 (CET)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id BCC294026C
 for <dev@dpdk.org>; Mon, 15 Dec 2025 22:40:54 +0100 (CET)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4ee13dc0c52so34164171cf.2
 for <dev@dpdk.org>; Mon, 15 Dec 2025 13:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765834854; x=1766439654; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F59kQnptSJZTKDlGOPYR1PWb26hAEAlitzAawNI24Bw=;
 b=gkiZW5E4EII9AYgN8Vg3qPhCJwZomvG92UXvXcfh9LVmkO+p8NkeDWBb8DJFKTQbd4
 O9supApgYM1yMXdMXN0KdZl001RVNv5Z33tKpZbTl8SBYsXpCg0Nt+scDnJ8/YFjuROy
 X9FvHKoZrlPrVcq7wWt1NdaXn98Qyeie36Gms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765834854; x=1766439654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F59kQnptSJZTKDlGOPYR1PWb26hAEAlitzAawNI24Bw=;
 b=Fb1tRYv4OysKwxvG+s1tUc5uoJOmbcqnJgcpBSia3m9hWG8jpABnNHm101By8j8GXH
 8Y5TvowwmRTwYU8LlYHdMe99DKcL9QknDMJtACc1FpcUpCVltAiJLuwldmKRo7P3ECte
 FfpDeOuGKEW1CcnSsaUGftGJ7tnO5MHmv66Mijo/Bnq6EtxlgeeeTAn3dGvQrZzztXRJ
 j+OMd5Wt7V6UMivGej6ceukO24OJ6kAj1y29VIQWa1XXYg1NPSaWXkgo/1VXRm3qRkgq
 yRfv+9Yy+Q8R17MotklcOeWjL3Bt7qxAJImqR4wc2PGECy9TJ6FBTPC1Ga9G7ySKp5As
 VvsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6MtSJnem9Q6USFsGN/nEkRNDwkgnqSQKx47RNEf5+kyhQVR5qEc/poNFb6W+NPNSJcaw=@dpdk.org
X-Gm-Message-State: AOJu0Ywpe/uH27oXBiaJEBll+jNwbY8kPxo8/nFNNiarPCskiNRsgYb4
 xpR9hJ9hDeRDs3g2ZSh8LwMV4oQQ4Tq8RSLVy/hU9z8nuV/8zMT1JKEcf7vtyvR4iyQ=
X-Gm-Gg: AY/fxX71j/vk6tNLxgYavCiQ2torTj+YptZblh9fz6KYg994LrLFSRvj4vdPz+P+1Ij
 d7G9jYVFpqTiu4oj4mmucuZ1+PxrNQEvIPJZ6dNaPsb/A2wDCubYMJ9YhtehAGFs4aIfphhMBsn
 LE1vz+uJ3pcdsfhsWdjRvV3tFnWQ9JrSiv6WU9QjLR8/8KEOQValgjYnO15rxngGJvJt56cehev
 1VmHw5BwjcCDEN2XHa5B7LIoAyZBjtTxFRdpZQ0198AHg4lhwHAuBVEvq0tv/Exc54LW/j9dqOS
 6TX9tFvXeLYOFpFgoVp3psUpwA+58qwqAmZ2FiaD0JYEi4+MtuCKZzH277ibOs1Cp3O7Qunoc5F
 7527oBY9Etcg4nThpyLM/fv4Tx9tXlqECUiYhtOZ54NfqpiZ136W+hw1Ot4cTqdGPdbWNdxhLiR
 9HXiZFvTyZDDnVwa+U2triMUI=
X-Google-Smtp-Source: AGHT+IEIzvRVWYQv4+ioh00aCAyCL+DTM+RvSYCezlmppHpVuEdFPTo4Jr2NZXXO4M5CTOImtkiFoQ==
X-Received: by 2002:ac8:7fc8:0:b0:4ed:ae8e:cc73 with SMTP id
 d75a77b69052e-4f1d0625feamr179840941cf.65.1765834853809; 
 Mon, 15 Dec 2025 13:40:53 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f345b16f72sm3508241cf.3.2025.12.15.13.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 13:40:53 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, paul.szczepanek@arm.com, dmarx@iol.unh.edu,
 dev@dpdk.org, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3] dts: show missing NIC capabilities in DTS logs
Date: Mon, 15 Dec 2025 16:40:49 -0500
Message-ID: <20251215214049.694604-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251212210142.669766-1-abailey@iol.unh.edu>
References: <20251212210142.669766-1-abailey@iol.unh.edu>
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

When a test was skipped due to a missing NIC capability, the logs should
print the name of the missing capability. This has since changed to show
only the integer representation of the missing capability. This patch
restores the previous behavior of printing the name of the missing
capability to the user.

Bugzilla ID: 1803
Fixes: eba657ae3c3c ("dts: move testpmd module from framework to API
directory")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/capabilities.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 243759668f..2d0cd65854 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -219,6 +219,10 @@ class NicCapability(IntEnum):
     PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP = auto()
     QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP = auto()
 
+    def __str__(self):
+        """Override the default string representation to return the name of the capability."""
+        return self.name
+
 
 def requires_link_topology(
     link_topology: LinkTopology,
-- 
2.50.1

