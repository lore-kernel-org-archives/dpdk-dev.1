Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C42C021A4
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 02:48:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DC8B427DA;
	Tue, 25 Feb 2025 03:48:28 +0100 (CET)
Received: from lf-1-13.ptr.blmpb.com (lf-1-13.ptr.blmpb.com [103.149.242.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0224B427C6
 for <dev@dpdk.org>; Tue, 25 Feb 2025 03:48:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740451700; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=2rDXOT53RD+tUt7fRB4qpi93dcqzlFw1d7jl6jRR/Lk=;
 b=GiLIjcMvKk3NDdd6f0VGoQVJ9rAwiLYFLkdldF/vH8x4pJQwrMqBQpvoD7p1AQs4slbXuF
 tDfzSrK/z647uES/7/hKfX++ed7XKbMik/uppIQvs3ndPrMMd3YxHLoES+/hnkoM+pr+i/
 WG+CLlfSEhWEXX6sSl680YHFrCiQVgGoliQ2kwbRQWo8kzwclY2oyPsu2r51RnUJlZP7IT
 AL1sZt5UmOSzEJttl5QE67u5DOaYvafvZiuhYSbL2EoSOi4WRA2qqnprkAqCj0LkmtY4Qo
 pgO53Cv9pszPwINw+DvR0bF4CR8gt0Ov0mqaVKEtWmDmB6vGW89772SS6rgjDg==
To: <dev@dpdk.org>
Date: Tue, 25 Feb 2025 10:48:17 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Tue, 25 Feb 2025 10:48:17 +0800
Mime-Version: 1.0
X-Lms-Return-Path: <lba+267bd2f72+79324d+dpdk.org+wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Message-Id: <20250225024810.2489747-1-wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Subject: [PATCH 0/2] net/xsc: Resolve warnings from PVS
Content-Transfer-Encoding: 7bit
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

This patch series resolves two warnings reported by PVS studio.

---
Renyong Wan (2):
  net/xsc: check possible null pointer dereference
  net/xsc: suppress assign the same value warning

 drivers/net/xsc/xsc_rx.c        | 6 +++++-
 drivers/net/xsc/xsc_vfio_mbox.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1
