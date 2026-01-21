Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6617C44503
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 11:08:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9F94400EF;
	Wed, 21 Jan 2026 12:08:05 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 8344E400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 12:08:04 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A3244140017C;
 Wed, 21 Jan 2026 06:08:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 06:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1768993683; x=1769080083; bh=mbA1oCzuyWgW/SjDDY1bV
 IaXObVays7AMph6yOJT3ZA=; b=iXKYu59ZzIUDOL++ySjLmXQsYVIZW2LkjE2Eh
 rW1xfh02B0mNXskGXz8uzXLh9LVIqm/iTQ3MWdZzHY9IR8rgnx9LXYuTGdOEiHzC
 ntS6NqgapI319NjpQxjL+UPcKWlKPfdLwVlnkY1mvsYxm+DHz1KxwwEJZYl3PbRr
 3UG2C4a2OLzVjdAULznnOUVeEnH1c+PP4MgImc71ILx3WnUG7flYqSn+l0e95+pQ
 eaNgcXW+nwupf2LymSo+AHX7Nr102Dm8UOV8kQ952YetE8SDckL0hEkau1kkzBt9
 natTA/hyjukYCntxtEEFshgSPao3XnQPRSNvZ+8HuyAIBN+Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1768993683; x=1769080083; bh=mbA1oCzuyWgW/SjDDY1bVIaXObVays7AMph
 6yOJT3ZA=; b=lpH/3KrIqEUjOaGlgzHZP4fNk2/SJvIe4zLwRIHJ6rJ29rMmSD1
 NkhGKCyfG+jO6m9m6g1YiKhHb/rW69cXVZcyosXqg0cn/T3lQXf6ERe4cKL1o002
 zEP5dK+HRIw99O7fyiO76ghT9CWel2haxUgiBeGRv1nY/6xQv7fSLKIqI+EP7lXj
 C5LLWiolxaz94dSrbEfSEqgCzusMOZxpnK82rlHq6jH46y6JT41tipV6PzrWZtCV
 jSYpufZ8KAt0oxAy8+bw0WTTDlQRK2dphlG9pHgNU0r+kpS3ByTdSR8Ma8UG7ide
 okqv1STmyhi35uYmf7cU4Z57BP+qGbTb2Dg==
X-ME-Sender: <xms:k7NwaQd-4yIOadC3-I7taMzoaVX3xqlPqpLyG5HReG8HM1T-XRi4hA>
 <xme:k7NwaWjeIhwythqrAbCLD8t8i2o1LejLaXlsPGIWzBV9IUh3uOpq2h9f_OPd08zh8
 LxOW8d14Y6zHNFUuqa__5KdJ-OVyAXyxaOKjD0j10y-iu49frc_>
X-ME-Received: <xmr:k7NwaQrVHmKbQN8obj81tReFv6T9Z0JZ4ypAAXEvnS5hfDXUlt6Q-AkVd_7GLo4C0XxUXP97ArjzBaGjIXxZlETl--kHFsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefuddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
 dtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhn
 jhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepveevfeevieeihfetudekgeekle
 eigeffueekveduteeuffeiudevteeiudekfeelnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvth
 dpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggv
 vhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvggu
 hhgrthdrtghomh
X-ME-Proxy: <xmx:k7NwaeGokT1FPHpsf6akOllnlvM9vgULW8FTe8BHOCpLfk-61ansmw>
 <xmx:k7NwaSkWqRYDjBf0fGmNOtQTTqkacY6NDnKr8GL0hxfBVf61DegzBg>
 <xmx:k7NwaRnJfXQ_rK92el1ep3TkgmIEfOvzgLD81MaLmtWRY89GYfSOuQ>
 <xmx:k7NwaTuRqBcs6jBB39SiqAOk9WjPnz_ce2YXpZ09ByK9NemQzSnXEw>
 <xmx:k7NwaQfTgtolzUC3I7lNznGsSU8QtrGrGFC0IhlTztHVQXQiIBF6enNy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 06:08:02 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	david.marchand@redhat.com
Subject: [PATCH 0/2] More fixes after enabling -Wshadow
Date: Wed, 21 Jan 2026 12:05:59 +0100
Message-ID: <20260121110757.1948723-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
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

The drivers mvpp2 and mlx5 for Windows
were not checked when enabling -Wshadow.
Here are the missing small fixes.

Thomas Monjalon (2):
  common/mlx5: fix variable shadowing
  net/mvpp2: fix variable shadowing

 drivers/common/mlx5/windows/mlx5_glue.h | 2 +-
 drivers/net/mvpp2/mrvl_ethdev.c         | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.52.0

