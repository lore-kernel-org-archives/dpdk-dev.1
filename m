Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EEAC5DF85
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 19:11:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2595E40684;
	Wed, 19 Aug 2026 21:10:59 +0200 (CEST)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com
 [209.85.161.48]) by mails.dpdk.org (Postfix) with ESMTP id 737C94067C
 for <dev@dpdk.org>; Wed, 19 Aug 2026 21:10:58 +0200 (CEST)
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-6b13496112cso1079100eaf.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 12:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787166657;
 x=1787771457; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+FEnBVimzddIZ4CARxhKUnd9IxZnpezeZxy3g2venyE=;
 b=rCT8Frjhe544syAcLvORB77OC8mAYB2SNOuBY7MEbh5B1lmbdBHMcH1nX9ebMvCfLX
 Ch3IGRW7tuO9IBtT0O/zhMqBj4yK8vLZFN13mMctBiGprv5D7JbWZ8jkLM4BFidVlDNM
 0LaaVMDIwQsWLNdq6k3bh/thZuqxRZA9fQ8qIuuwzLG/d7FdOfFBrw4dqDoBgQUuJ46x
 jtoFLeIQ2jriLZfBHEMWlNuJ+AHydwJVKP6TZf+pAXBfd6iuW4zi7gfwr7DytDnBHTJI
 nnaxZ9EgUW8GrOKrtbCPDcFg+w1ho2BuEuaXnXMd0i6N6unETfZPKx4W8eSeOCyw9xRr
 YuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787166657; x=1787771457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+FEnBVimzddIZ4CARxhKUnd9IxZnpezeZxy3g2venyE=;
 b=OTxHgYNrITYkzdavnGXJyLPptSliTl9jRyzUiB9//70vAiQ9SRyHlzp+jctI231st/
 onKBHNbg6HJCattgVPiGPSyrgjwlGHjJNyH9BwtkUv3LVn+uzlDCywLncnetTJrRzViV
 lkdfIlxesbSd6feglvRPmiobGFH3FChaUNvLpjWUWmfFThIEs8/iMwKhVqhzmSlNVUbE
 LZYsStgax1i8piTicPvqPDKz7G9ylj2eqOysxOj8pofIOJyZp9YJ/YkZE5pHp58lB6Bf
 ZjQCGikG4e6GQoIScCzUdCskAp8M+edg3CdEpaeO7OqcKoszlQ0FjRS+fMk1XlHAG9p0
 uOFA==
X-Gm-Message-State: AOJu0YxEAp1MmSEp7LK4ptCN+iuMHVrAEq+GR8WTs7tmBggov+P39tvU
 NJM/UGDNa0AXcz8JyiOnlprW9P25jXi18MjDHsJwtqRVK5oOwCqgJS6YMdaUBEMloyiO9caZMpn
 h37uC
X-Gm-Gg: AR+sD11q6uwQo7FfdTQ7atTZ5g7vh0fKgEMX+8jrPKBVsGOuMyy3MtaQiha54guKH7K
 FICCb8KY7yDKGNvdRRWeSwanAaT+YuyEpflEG6oCzO+NqDSGr5yNZdQ7sJgQNHhEtfN8CFhM7WJ
 aXtX/nasdA0NJ7K+aTCaFqyXc9GiMky/Y+dgliciS0PjO7Varh23HyTe6luGS+2WrjJ5LjdEBC0
 N9dZdaUv0erFrG3Dbxk5slaBBdO4bNn9QfBZrStkgDcAqzkiohr2S5t7pFSUjWOyWXZUoqpWcos
 YRoqr+65DiDTwp5Iwx3QXhtqtRyl3Sd8tVc7nZXbvEg/SrKAIjlsYC7XMKQdjx9wwF51r9qISyG
 SKelev7Gwqbe/QIPB16xjOM0t66i8qnCkomQvcQ8fRrtLqxzAksqzsgepTf+5qyiAJax3Nltbfh
 rqC62oRA42S/XDVRU2IqOkEGrMF3UDlIUu54lixejrP4Ewq3G56LS4QX8E6hZoSk4Lk6v6rRwHt
 8kFqq1gvGISzsu8wAy/dHjeKKU=
X-Received: by 2002:a05:6820:4c16:b0:6b1:858:28a9 with SMTP id
 006d021491bc7-6b13c3853femr6885930eaf.9.1787166657492; 
 Wed, 19 Aug 2026 12:10:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef77fc0sm17305416eec.8.2026.08.19.12.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 12:10:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Long Li <longli@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Randy Tice <rtice@cisco.com>, Jianfeng Tan <jianfeng.tan@intel.com>,
 Jeff Guo <jia.guo@intel.com>
Subject: [PATCH v5 3/4] eal/linux: report uevent socket overrun
Date: Wed, 19 Aug 2026 12:08:52 -0700
Message-ID: <20260819191036.679330-4-stephen@networkplumber.org>
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

Make uevent handler handle case where kernel netlink receive
buffer is overrun. If this happens the DPDK device state
will potentially be out of sync, but better not to give up.

The code already handles the case of kernel sending a zero
length message; it just ignores it.

Fixes: 0d0f478d0483 ("eal/linux: add uevent parse and process")
Cc: stable@dpdk.org

Reported-by: Randy Tice <rtice@cisco.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_dev.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index fb5c8bf070..b535122ff6 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -270,11 +270,20 @@ dev_uev_handler(__rte_unused void *param)
 
 	ret = recv(rte_intr_fd_get(intr_handle), buf, EAL_UEV_MSG_LEN,
 		   MSG_DONTWAIT);
-	if (ret < 0 && errno == EAGAIN)
-		return;
-	else if (ret <= 0) {
-		/* connection is closed or broken, can not up again. */
-		EAL_LOG(ERR, "uevent socket connection is broken.");
+	if (ret < 0) {
+		/* transient error */
+		if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)
+			return;
+
+		/* kernel netlink messages lost */
+		if (errno == ENOBUFS) {
+			EAL_LOG(NOTICE, "kernel receive buffer overrun");
+			return;
+		}
+
+		EAL_LOG(ERR, "unexpected error on uevent recv: %s",
+			strerror(errno));
+
 		rte_eal_alarm_set(1, dev_delayed_unregister, NULL);
 		return;
 	}
-- 
2.53.0

