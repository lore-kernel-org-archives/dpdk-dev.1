Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22177606A31F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LM7nUEEH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B26A4064C;
	Fri, 27 Nov 2026 22:08:15 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 6C4E4402CE
 for <dev@dpdk.org>; Fri, 27 Nov 2026 22:08:12 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3ac9f49b984so4758014a91.1
 for <dev@dpdk.org>; Fri, 27 Nov 2026 13:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795813691;
 x=1796418491; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DivFkBqlEK/R3TLeBT2ax1oE2yGupqQvjyyBYib3MH0=;
 b=LM7nUEEHSgaIbN9X0uTMBmla16hiLiGrkjafbQ110EqE/B/3GrWHQ7mztn/1OSodsN
 coWnnjCBXuZhfuXtEjXrasUr2PjYUGQukDS0ZermaoWBGkFMB5/kAUwBl4Q/VVtec0X9
 Nvv1tzz6GzhiYMukLUQNr7V4wHWh4uYI41bfa/kDETrZ6IM0XJbTVYMepk5gVwrgN1To
 UbZH1+34EZvPyVqMcLtJ/1gTouw+wIRUXEI01k9SR/wIEs+9QXEldQR/DW/uSQdhujWx
 vp+RFx4Y+ZLAiE7UAxB+a+qvUSC/EkM3aWI+IoGZ6WQgneivNHVMqeR1lDp3Kt7eb5yC
 f90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795813691; x=1796418491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DivFkBqlEK/R3TLeBT2ax1oE2yGupqQvjyyBYib3MH0=;
 b=DZ0SHOCaCAHGRxAEuILnudpZkSQU0OXGZcT4gpQyp+AuzvjIut0arXNtKtpOd4HS7t
 D4E6+5QGAv2p7CgdJIG2aVUSLAa7g5C1feKv/p92SC8JXQ/YEH0NeVcHfnO/94F3cJzU
 wPOh3haUJjnrpAMBe6DXCfSG0E31wryDSrU6XHuYHN8Og2foaExDfsUTchP5p7dI+Try
 Lpb7/dhS5aqeCqqlPbEYCEDVFRT2x1V1zo7u2ccvRP1JgcDOvjGlJ64a/i8Q/ET1Vn8C
 DiCjMZGZVEEWnT8iCIcvYamfk5+CzZXpSnvtXmdgAW1iGASnXlXq6E0f18AT4IbOjnWD
 VQPw==
X-Gm-Message-State: APuU4Z+86x6p2ymxos7/N4oi5FJugrUfEMg8QR+9m5iDvZupZuPxyURt
 Lx1HK9xiewOi3f9qjQPpBU3UFJY2pV/FRkUeQLCg3b7rFgU6vdK/+pU8fylJTeVF9T0HnZXNEnm
 DlnbsnKA=
X-Gm-Gg: AZFdTZeK89xVQSWqrC1sRpaPZTt0Ie5WsPd1TLMqkCI0fcrGFRW/x3NMy+rLbxrPxNE
 Rz38zKQd2DqOlI+gML3Bw+CZ2XSj24u35YK0c914URk8ljDEeBUox9yo82JLDQUhofNmkI8D4om
 kYONoOJx2BWZPDtFA0sQYRqANyTcmvUXUbMc4WSqERwsAVu+MWKbto2mWqs+HgKDNAJXlsUaupt
 wSfgS6eRg/kPeQm7ebqzKSDiX1jUVuANST+tXoAlafW3jqGmPgV598c/3xqSSv2h+BIlPQ3eLFF
 PcqkNLZRBe7NOP5ycI/2d1ji/nK3y49TTgSE4KmfNNDKHGzPPyjtUII5sVob9rKt6purAzjBs7o
 5pcjr5sFXS3D6EtawbRvz2VOEz9BVYvNex82hKUzEF8oNPPmlRHv3FE/Nthxk4Np82G7pSVgihg
 ooWaTC/E0mVME1L04kZFJmRRvfH9KI2/MdCcyNPBdRURrNXyN0jchRK2MMNhQdytTHjhVGYZDir
 g4Hv/McdQeSx9avRHhu16j8Lp4kwQgmZYGH3O1M0Ngx7YrvQFo0HZusKEV/5/P8KolfzTl/vwh6
 nnmdIZecdk5U7O8iaGlyzYR1q1KMr5QRgVHWks7rNXen83O/IFDIiNPJuYo7LO1bVnoc
X-Received: by 2002:a17:90b:3d4d:b0:3b1:6689:a016 with SMTP id
 98e67ed59e1d1-3b41c9082famr17260126a91.16.1795813690722; 
 Fri, 27 Nov 2026 13:08:10 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ffa98esm42457179a91.17.2026.11.27.13.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 13:08:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 1/6] ethdev: reject hairpin queue in add first Rx callback
Date: Fri, 27 Nov 2026 13:07:03 -0800
Message-ID: <20261127210806.318387-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127210806.318387-1-stephen@networkplumber.org>
References: <20261028141750.310963-1-stephen@networkplumber.org>
 <20261127210806.318387-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rte_eth_add_rx_callback() and rte_eth_add_tx_callback() refuse
hairpin queues, but rte_eth_add_first_rx_callback() was missed.
A callback installed on a hairpin queue is never invoked.

Fixes: cf5516696d77 ("ethdev: add hairpin queue")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/rte_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 13c82a2783..60dc8aa2c8 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -6234,6 +6234,11 @@ rte_eth_add_first_rx_callback(uint16_t port_id, uint16_t queue_id,
 		return NULL;
 	}
 
+	if (rte_eth_dev_is_rx_hairpin_queue(&rte_eth_devices[port_id], queue_id)) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
 	struct rte_eth_rxtx_callback *cb = rte_zmalloc(NULL, sizeof(*cb), 0);
 
 	if (cb == NULL) {
-- 
2.53.0

