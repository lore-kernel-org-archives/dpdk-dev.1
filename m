Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B01C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:32:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA66B40EE1;
	Fri, 21 Aug 2026 21:31:08 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 3688340678
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:04 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-848643382fcso1302514b3a.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340663;
 x=1787945463; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4eJUm0hlE5+G9Uj0m9Y4ZJRN3aqrSCJwDQdpYkNj0iY=;
 b=KDegHOWMvdj8lYtedWbvrJsJl++5iizHTAA73MDXuAnRoHGMcf2rKsQJnzYT6kWoOg
 SdcZ48zdsL8uT0NgAOgwPajDU/COTcYJnKBPa8wkRBmLYM2TG1ryevezpJmP2XGL46WV
 vpBZri1wxXh51mwZPb6ImnADG93Hrj7SS29B6vCD2F1dIjhaWah/Pb/NHp+5bqRqWdK0
 dib/cDZfL6orh5oTcVLU2tUR3svHZle4yTW9QP9K2k5PDcV9mRAXYI8qPbHUXGtuTz/h
 zf7+sG666DMmuQR28Dtzu9tfPdIcd6HXLPobIDAW6Gjt1qQc0P39edTiJIi+x51EeWnz
 KwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340663; x=1787945463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4eJUm0hlE5+G9Uj0m9Y4ZJRN3aqrSCJwDQdpYkNj0iY=;
 b=fUjYYrAU9OGG4piIQ8Fi00ZF6Ig/PzXxMZv5seUmYu74VglljRc3eDRWwmmBxe8H2u
 iGkHq4ufpc21jqmjLK0hS8puP4ERLu9T2Z1+sAS+j2+eZMzLpaiHFoUJPfdPyImwitYQ
 YYjTMtMt9JGpTx/eGoKdcCvrNbfiGQ048lwvhPEFIVnwI3oD8tJdZXKSywi4Nemd9bzm
 b/zTSy4qaSVoObu9+OlJqV1uuW2Ke7ki2j/0IJo3tS4sSeHuo7YP3G1SLkzzIjHle15r
 J2gR9fo/E7GtKdMw6GrPB7S5Y6m9GTiSqLYiN3s7u9myGg724EejPNorTJPxOSxKC5hn
 hyxw==
X-Gm-Message-State: AFuF++kNxtN7kwLyj+qb4xcyHaXBNIwC0XvP2eZv9pNaXpOV5MNE15f9
 5RQTjQugZ6adpNDBWjYblTSYxaCQ8Ivf4hYLoYK5mSgD8j3govupEbULWKVKtvrV4RKNfA3bl6T
 4Qpwibys=
X-Gm-Gg: AR+sD11+rBjNQDAlZ7SmWXpM3YGEnqmMlk+BUsXqChjD3GUjwI2/KTTSgzhmPVg4U5h
 a8daddMU7XbdZ5ewPSLAXMjZw02foTKwIi0RCpns23yfs+oKagEFB/xgeZZhAaJ1saRXecuKAI2
 kvVkH1/7xZSjP0X7nhjVLYC8sBZkTrk+duiHhK4fsD6A85lRfFcSF7XxWedd4Q3NiF9fM/k3lDi
 PH2qPLmDEA28ZceC2twecb1yJ4wGQ9uOBHs3LpsbYAObkWjTUlAHXfAJWjUdjllL0aLYYRDbBIs
 G61X9X2nLQlEyKOwbIRDy1eGeflR3kopDvfg+xb5bUEHH/c9fruvL0Ry7iiAUYZBbtmFaDqgRSa
 +gmOKUFiMWDmE8FrWPr2G+QmO6MSf+QFYToKU7xBLjX1TScX6PxoUfx0bugWuTwgI9lcSBKnyno
 b5SMaC23xbgXfK+odluj4lE4aiagHtEL9a4v1IvMhIvXyuCnowVuRUhyVmz4WCR6a27EVnI0oSH
 eiFs4klG7j310luhiT0ZlVePMk=
X-Received: by 2002:a05:6a20:6f04:b0:3c4:1916:9d3c with SMTP id
 adf61e73a8af0-3cd301428ebmr18228851637.15.1787340663452; 
 Fri, 21 Aug 2026 12:31:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH v2 53/68] net/memif: use memcpy for fixed size data
Date: Fri, 21 Aug 2026 12:24:48 -0700
Message-ID: <20260821192646.146382-54-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

