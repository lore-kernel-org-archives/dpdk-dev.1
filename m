Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10533C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:27:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE66440E49;
	Thu, 20 Aug 2026 07:25:53 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 5BAE840E38
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:47 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso6528955ad.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203546;
 x=1787808346; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4eJUm0hlE5+G9Uj0m9Y4ZJRN3aqrSCJwDQdpYkNj0iY=;
 b=JlAsuBSjwKO2zUl7Vi+yaD8Pk7ctR4IjbSnvqgrX0Z4TGu8huR3Lu0Y3TUJsOSE6WX
 oQWuuNu4q+2+e+LUbd0pkmIYDSodIzsHgV0w8nJ1Hs4IXvHHIYqtGGMWDHjPHJKOuBMS
 UxjWzmbVwZb1Go9wZPc1rtSKHFl27lIFHaeNlZmNIUkXFBcHGv8Z1JT1Ft2j9+NhvqLK
 qQhXvO8ZqLYI6QgAHklaIl1NHWDpLr7wUAIpAqmzPnAjSgTmZcSgEzTDXtwfvm0GTK6K
 fXDzo2Nh6I0xWf/XSRCSIxE8MfimrBtcX9BES4IMoYO2PZUobItFU+aUgvLx/l/6g9HW
 gToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203546; x=1787808346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4eJUm0hlE5+G9Uj0m9Y4ZJRN3aqrSCJwDQdpYkNj0iY=;
 b=mjJq2jF7SlZF4PDqkNzTV8SPiafVc66OcrwpaXOXstxH7dsPCRAX/AEbVjpfKR0Rgm
 2NpEC0f0/Stc2wueOTyx5i/MmdBQ6Hx1sJC/DqBuGDEggqc6wmDNw6OqnMjwaf4iaS9d
 7/T4juIzPKgOPkRSfLkvECqotczjSqEPRH3Onq8svJ8EfuP6u74RuGXdu1M21qzvL1Uq
 Pfxdy9eO49PpdwYtPPHmKvCCs5EdfTig1PMU9UA0dZRNnoMpFsNw3iwYFeuTwcDc9pQ2
 0JBjwPO+Kak0g8AnCB+BxTqmBwdm+Nk71SrANt+ceYfaPHjS9j49SdhJ8U5JZ7zkVH+N
 AQNQ==
X-Gm-Message-State: AFuF++lwu96FzqkKB6qHTXxrgzcraugAOidOFWdM1o83cbdpzcxLE6iD
 99f2c55nIJrwxw4fyJwA+SO6RUnAf6S1WqORKTdiJIbI7Ml9tsDV6RUtwV8x6qeu0IA16ERjPAX
 w489G
X-Gm-Gg: AR+sD10xPoA4zfi5NZ1D6ugHGV1mD8+5iwowuu11hDTq82uXyBiHBvj7QnwE5vhiX/M
 2ZyWpIC0gRE/9lzDSiUdTJ9DNGItMsb1F0wPBiXA2SoxhMKvv9lO+vFSxY31ASI6yPYscoxePJf
 fqzcFe3F3R62MHztt4N0/kyNFLc+uj7PDBHluU01GzxRrF0v19248sTivucJfujKUX06syZbIiR
 A67eIuiwgHiyw1+pTWFuYIZkEWHHeLVrG9y5AI7xY0WNJWonOFSngA0X5TWkWNrrxEczSWjAEUQ
 ia3Xsxlo7GSdN2/PnWIPp2VOMRa1r6a5KuakoREmAAD49qcyG7NhooCrlxtxZ+Ru2iiB958Mt2r
 XL1+UeIsZp1Ro4/A5jhkS0LthydzXSfaoB+ekTB4vwIIrl7OhPA/FtUrrEP6ZG3Wzfv0IQsJtxh
 iSPkYbuAVgnE0T4vAo/OBk5rJDCvGBJuG4/gjKLJMhgrb9JTa8ocrHk7AG4ZZs8fLuZgTTtJfSC
 J8Bgymm7LGmalApUXcPYBjvOeo=
X-Received: by 2002:a17:90b:2d0b:b0:38e:9784:dd47 with SMTP id
 98e67ed59e1d1-395a044f2c1mr5294430a91.1.1787203546432; 
 Wed, 19 Aug 2026 22:25:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH 46/61] net/memif: use memcpy for fixed size data
Date: Wed, 19 Aug 2026 22:12:36 -0700
Message-ID: <20260820052251.1453273-47-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

The regular libc memcpy is inline for fix sizes and has
better analysis coverage.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/memif/memif_socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 649f8d0e61..f5a3354c46 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -48,7 +48,7 @@ memif_msg_send(int fd, memif_msg_t *msg, int afd)
 		cmsg->cmsg_len = CMSG_LEN(sizeof(int));
 		cmsg->cmsg_level = SOL_SOCKET;
 		cmsg->cmsg_type = SCM_RIGHTS;
-		rte_memcpy(CMSG_DATA(cmsg), &afd, sizeof(int));
+		memcpy(CMSG_DATA(cmsg), &afd, sizeof(int));
 	}
 
 	return sendmsg(fd, &mh, 0);
@@ -675,7 +675,7 @@ memif_msg_receive(struct memif_control_channel *cc)
 			if (cmsg->cmsg_type == SCM_CREDENTIALS)
 				cr = (struct ucred *)CMSG_DATA(cmsg);
 			else if (cmsg->cmsg_type == SCM_RIGHTS)
-				rte_memcpy(&afd, CMSG_DATA(cmsg), sizeof(int));
+				memcpy(&afd, CMSG_DATA(cmsg), sizeof(int));
 		}
 		cmsg = CMSG_NXTHDR(&mh, cmsg);
 	}
-- 
2.53.0

