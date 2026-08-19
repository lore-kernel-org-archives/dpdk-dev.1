Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AEEC5DF85
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 19:10:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 526664064C;
	Wed, 19 Aug 2026 21:10:51 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 13E9B4064C
 for <dev@dpdk.org>; Wed, 19 Aug 2026 21:10:49 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d530328efbso12527575ad.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787166649;
 x=1787771449; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7WzVn9PtCSgBrOHWuu9AGXN3tdFpz+2SGkHbY3meVWM=;
 b=xj3zeVnOP1AQuOjWlDm3w1RfYvDzowhHZfo5ISLDzmV1a9/DaJVXfZiDYsk+myEGOx
 lZAUAjgJaRq0nsx4s2lvkBCA0O4fMweNpPnGOrWL01xSAkVkXcqRt86IY6mNeWD9O8c0
 y68PiBShs8Tx4+HIP51kS/6aFuHQZzEsRNGBiP6jiLILXjvQEgKGXqa1BT/4hoew5+Pc
 r/KWsffFasfOxfvJ3ieuKdhRWmamrSc9uNYTId5FPhL6HcJDw0cOiDITf/pC6NjD1/NZ
 SpA/vXGW0NgNo4xUdVvYuIIOqj/o09hnDT0AwhFXAmBG730XRH94CbuUqpdT5ibNgK1T
 rrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787166649; x=1787771449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7WzVn9PtCSgBrOHWuu9AGXN3tdFpz+2SGkHbY3meVWM=;
 b=h0hzBKH3BzZ6Mrv6EI3AJeTMgQc7EtaOaVJ97OmLNUVQUeR1eclo2QQi22sRoSErSJ
 2BjE5wkDY1qmBCnymoVFXOh6zNbYgu/025j/MnfarlkaCvZITO3O/8h7ccp19IxHr16p
 5q+0AQLWkQKxGWnGmstKCkQAJX5dhAJquggv3o6+vEtC5IrqP3NGdBLOKjgLi3G0Xzj1
 kCR5U2ZUjs1VdLD998sWzjJf/20LGxcvvtFG27rVu/dh8k4qNdmrA7xRMHEGB+M4H54e
 lxpJ98PstdVNs8oIZ2QqVudCdjCB36R4r4YnLv7j3CTkW+LWQ+0qyADrNmzbuV+pHxdy
 3+Vw==
X-Gm-Message-State: AFuF++n/K25/FPUzQQCSt7YSZ6jpXTUlGKRbuS+XlUOfAHzWwqXPCEOi
 NRYXdKP0doidB1FaZYj01WhtKhDLFm2TI9aqUBV99IqvD4TQdcZyrcH06s46Mm+AtsRNXSpVNOP
 HfSn4
X-Gm-Gg: AR+sD11WtNTXW44Tmk6JKN8+f7CpMMptxAKo7zwOxAz19inn6dHxkOjNV1sVUOhYZi5
 tSnUkUzMOwKPsoL1IObKXPh10Eudzt0BG02CEvng7xazQRlNPkxLLlFUEnnOMzqMvJ913sBjyVS
 3pRBK0/CHMH5gTtFB/yhvnBQjz5dxNjIziuRStk8xhGBdFskTe4Hvz1wjHRsOTWi2a58Wg6gfpd
 oS8TNojMyjCTfEeC2sGNNumXeF1nY/XFxk8VZKjyPbx80b+UBjWeSQuyvqVFIZYkdXXWUN/+C2A
 3dXHa9az+DnIArR7p6ac9YeaftfLzFKBtKlZIEPpo0sAxcDiZbDSiS9LpN0ia94iH55Wej+mZtJ
 e/QAGDHKz8D2B3uylxMKmKGcH7fcOVdi/csPOL57nlj9HYhytdj4wa6WnNir8OHnX60y8monV/4
 NSL8vOpDqS471OwglFDZQi7iHSzZ1fpIhcm9NgUhHFdZPDPEpJh3gyU6svycExTDfNjHuTSWspH
 HaF3v8xjPS0HWKIyUYgtjjubME=
X-Received: by 2002:a17:902:da86:b0:2cf:8131:75e8 with SMTP id
 d9443c01a7336-2d601eb5ceemr108364935ad.13.1787166648862; 
 Wed, 19 Aug 2026 12:10:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef77fc0sm17305416eec.8.2026.08.19.12.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 12:10:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Long Li <longli@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Randy Tice <rtice@cisco.com>, Thomas Monjalon <thomas@monjalon.net>,
 Jianfeng Tan <jianfeng.tan@intel.com>, Jeff Guo <jia.guo@intel.com>
Subject: [PATCH v5 1/4] eal/linux: filter uevent Netlink in kernel
Date: Wed, 19 Aug 2026 12:08:50 -0700
Message-ID: <20260819191036.679330-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819191036.679330-1-stephen@networkplumber.org>
References: <20260817201602.120526-1-rtice@cisco.com>
 <20260819191036.679330-1-stephen@networkplumber.org>
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

The EAL uevent only needs/wants messages from the kernel.
Better to let kernel side do the filtering to avoid any overrun
issues in DPDK interrupt thread.

There is no exposed API definition here. The convention
is kernel is 1 and libudev uses 2.

Since kernel is now filtering can remove step in uevent parsing.

Fixes: 0d0f478d0483 ("eal/linux: add uevent parse and process")
Cc: stable@dpdk.org

Reported-by: Randy Tice <rtice@cisco.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .mailmap                | 1 +
 lib/eal/linux/eal_dev.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..9b7713b6df 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1380,6 +1380,7 @@ Ralf Hoffmann <ralf.hoffmann@allegro-packets.com>
 Rami Rosen <ramirose@gmail.com> <rami.rosen@intel.com>
 Rami Rosen <ramirose@gmail.com> <roszenrami@gmail.com>
 Randy Schacher <stuart.schacher@broadcom.com>
+Randy Tice <rtice@cisco.com>
 Rani Sharoni <ranish@nvidia.com>
 Ranjit Menon <ranjit.menon@intel.com>
 Rasesh Mody <rmody@marvell.com> <rasesh.mody@cavium.com>
diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index ec408649d0..666967667f 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -29,6 +29,9 @@ static bool hotplug_handle;
 #define EAL_UEV_MSG_LEN 4096
 #define EAL_UEV_MSG_ELEM_LEN 128
 
+/* Listen only to messages from kernel (not libudev) */
+#define EAL_UEV_GROUP_KERNEL 1
+
 /*
  * spinlock for device hot-unplug failure handling. If it try to access bus or
  * device, such as handle sigbus on bus or handle memory failure for device
@@ -116,7 +119,7 @@ dev_uev_socket_fd_create(void)
 	memset(&addr, 0, sizeof(addr));
 	addr.nl_family = AF_NETLINK;
 	addr.nl_pid = 0;
-	addr.nl_groups = 0xffffffff;
+	addr.nl_groups = EAL_UEV_GROUP_KERNEL;
 
 	ret = bind(fd, (struct sockaddr *) &addr, sizeof(addr));
 	if (ret < 0) {
@@ -164,9 +167,6 @@ dev_uev_parse(const char *buf, struct rte_dev_event *event, int length)
 		 * check device uevent from kernel side, no need to check
 		 * uevent from udev.
 		 */
-		if (!strncmp(buf, "libudev", 7)) {
-			return -1;
-		}
 		if (!strncmp(buf, "ACTION=", 7)) {
 			buf += 7;
 			i += 7;
-- 
2.53.0

