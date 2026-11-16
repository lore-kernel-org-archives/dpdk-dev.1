Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA420606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=XaIlIXBi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAC5A402ED;
	Tue, 17 Nov 2026 08:58:24 +0100 (CET)
Received: from pmg.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTPS id F370E400EF;
 Mon, 16 Nov 2026 12:16:55 +0100 (CET)
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
 by pmg.amicon.ru (Proxmox) with ESMTP id 60F7010191F;
 Mon, 16 Nov 2026 14:16:55 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
 by pmg.amicon.ru (Proxmox) with ESMTPS id 3B718101909;
 Mon, 16 Nov 2026 14:16:55 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1794827815; h=from:subject:to:date:message-id;
 bh=bdCA0D3/rJPxSLOF3BNctgQ71QI3P+M0nwfJl+5b+dE=;
 b=XaIlIXBiW1wTpKjDV+LW+tT6YeuHlhFvghLrstEE/AEdpV7NsWOVsFjDOaDH2XRsx2OZRfmbyGf
 6L38QUc+WSCaJspHlQzIfWtF340xM5ec7dDFytcqytBw+gmt1CDrIxiKIFosgNPmKD/vd7QaAH+Nb
 oD5ZvIed3dhwFnJiq9eeWos5HlGCjGd7YspFYJbQ17UqcqqouLjx2D7QRWGEg9jswB6+cc95CkbGj
 jHbGzyWB/v9YLq3MYLrrBa8YqanlXOtZTlOfarZY3CZ0df/agRhREVPFzkAYoYkIRXqUa5xAjEzeF
 w5jfShLyFqZTrRzYPhUR+SuDOkDrzdEhCSxA==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 16 Nov
 2026 14:16:54 +0300
From: Artem Novikov <naa@amicon.ru>
To: <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <anatoly.burakov@intel.com>,
 <stable@dpdk.org>, <rrv@amicon.ru>, Artem Novikov <naa@amicon.ru>
Subject: [PATCH] net/ice: use snprintf when dumping switch data
Date: Mon, 16 Nov 2026 14:16:48 +0300
Message-ID: <20261116111648.27734-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:58:20 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

covert_byte_to_hex() converts each input byte into two hexadecimal
characters and writes them into the output buffer.

The function currently uses sprintf() for every byte. Although the caller
allocates a large enough buffer for the dumped switch data, using
sprintf() triggers diagnostics. Use snprintf() with a size of 3 for the
two hexadecimal characters and the terminating null byte.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0d8d7bd720ba ("net/ice: support DDP dump switch rule binary")
Cc: stable@dpdk.org

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/net/intel/ice/ice_diagnose.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_diagnose.c b/drivers/net/intel/ice/ice_diagnose.c
index 4946ace7ae..8c41b44e3f 100644
--- a/drivers/net/intel/ice/ice_diagnose.c
+++ b/drivers/net/intel/ice/ice_diagnose.c
@@ -430,7 +430,7 @@ covert_byte_to_hex(uint8_t **outbuf, const uint8_t *inbuf, uint32_t inbuf_size)
 	uint32_t i;
 	uint8_t *buffer = *outbuf;
 	for (i = 0; i < inbuf_size; ++i)
-		sprintf((char *)(buffer + i * 2), "%02X", inbuf[i]);
+		snprintf((char *)(buffer + i * 2), 3, "%02X", inbuf[i]);
 
 	return inbuf_size * 2;
 }

