Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1036ACCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 03:12:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9D6140150;
	Fri, 24 Oct 2025 05:12:57 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
 by mails.dpdk.org (Postfix) with ESMTP id 7E13A40144
 for <dev@dpdk.org>; Fri, 24 Oct 2025 05:12:56 +0200 (CEST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ct7J65pggz5PM3J
 for <dev@dpdk.org>; Fri, 24 Oct 2025 11:12:54 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
 by mse-fl1.zte.com.cn with SMTP id 59O3CUiN003794
 for <dev@dpdk.org>; Fri, 24 Oct 2025 11:12:30 +0800 (+08)
 (envelope-from chen.qiguo@zte.com.cn)
Received: from localhost.localdomain (unknown [192.168.6.15])
 by smtp (Zmail) with SMTP; Fri, 24 Oct 2025 11:12:31 +0800
X-Zmail-TransId: 3e8168faee96009-c4b1d
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: chen.qiguo@zte.com.cn
From: Qiguo Chen <chen.qiguo@zte.com.cn>
To: dev@dpdk.org
Subject: retest
Date: Fri, 24 Oct 2025 10:56:47 +0800
Message-ID: <20251024025647.1563088-1-chen.qiguo@zte.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021065607.1418203-2-chen.qiguo@zte.com.cn>
References: <20251021065607.1418203-2-chen.qiguo@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 59O3CUiN003794
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: chen.qiguo@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 24 Oct 2025 11:12:54 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68FAEEB6.000/4ct7J65pggz5PM3J
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



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="



--=====_002_next=====--

--=====_001_next=====--

