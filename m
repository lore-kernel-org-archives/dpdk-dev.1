Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5F606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:12:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39D57402B2;
	Wed, 25 Nov 2026 12:12:07 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTPS id E704A4027A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 12:12:04 +0100 (CET)
X-QQ-mid: esmtpsz17t1795605118t1270f249
X-QQ-Originating-IP: blRvG2zCEfn502wpf6v2ltxNF1AIbWxQy9ua1UUiI5g=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.235.140.99])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Nov 2026 19:11:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 181325198320081245
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 0/2] ngbe PHY interrupt configuration
Date: Wed, 25 Nov 2026 19:11:03 +0800
Message-ID: <A3DA76B5B04DDFD1+20261125111142.12226-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N25Qk8HUPrRTVczFvm6ea8on+izOWTMoi5fIhfllfmu9sBPzCCtVqY/W
 LrcFSCnIrTMuqONBWtKliBsiVoIF0sT3G+hbOgFuO0IetBj7UZGpx5Wd4YEt+Hxq081gU4Q
 WEUAvKV4m8/t39LsJT6bfvvICKKD/+arW2t378OypNbO0OYNFe7eihOIn9/aCE8h6a2wcPb
 Kai93Avq2Dk4TZTbj4RhaOV49j8l/Z3Jr6Kwh0IbyrKxJCYt30Qr2c8rzLMmscBjxOv5Aln
 ChAuFRLKTKCHueGbOAdKQtLuPw/kPwalhKpRW3r6g5d2Rhad9A1QaKOgMVC5+3CokLBK5+k
 Yc7b4j1kefxNoREbqniS8fKYTct0b8Rjd8a9eTGDgToaK5ms/WEHE7uYg8kivjbyp/SCM6g
 CZNa7NW7yuTS34AzA3gJjbXk0bzNrz6p7pC2QIUWEW+G7fODQmiPH06G3AFm+zvLONmS5Wa
 u35cFIUZHZkNEImg3TuVMPyBO9crSQ2VQFb4K+AI2b3LukLZ00Go1gweddcK7gopvP6kBqq
 UrLz7edw7VijLv55ZlxtuUv2W9+qOelKnyt+g/S77OFwEzbOYoNOhVGShOkTHkyi9BtGbfI
 MmdV4urZWQyGalSWFWx2jfqmTot/7dS3sgV3iZZfs5bXKywbfge/AuxubOqjo29nD0/5ia7
 R70+V4XvBqwk5tNn37n5mgDMMoPwQJwWmskOHeHTtFP2qHXhnAVVck/bZDP9pmiIrvpEGvJ
 MSydccORKgVPxPRfP0pCCINqNRa0a3cegOul+G9fi5WGENxVQmnMQwFaVShP2ipPsuWTSWC
 I9nbdYISIMig/KuKuoqs/S6iZQBG3wF5GSgTLL5JyhrV5Ck/LdSqw/UClw86l9hbeReHxY5
 +ZWcx5iMtt0A1MQ67hcnoiptZHqpUzmAmYW5ZRUGS4Em1SwmRUgk5VvNrAonoOdpX+Okt7k
 lkHOZyHUJ3G35eyDr9HBqh/cDECFSaTJAX7j5ZoQMJwzek/W11TqQqmr8wiJq+CPHTiXUPL
 glqeBsbg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two PHYs have interrupt-related configuration issues, each fixed by an
independent patch in this series.

Zaiyu Wang (2):
  net/ngbe: mask unused internal PHY interrupts
  net/ngbe: fix YT8531S-CA interrupt in combo mode

 drivers/net/ngbe/base/ngbe_phy_rtl.c |  2 ++
 drivers/net/ngbe/base/ngbe_phy_yt.c  | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

-- 
2.55.0.windows.2

