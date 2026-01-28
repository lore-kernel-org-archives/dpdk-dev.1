Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0862DD35697
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 10:34:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6CAB40274;
	Wed, 28 Jan 2026 11:34:06 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id DF4C4400D7;
 Wed, 28 Jan 2026 11:34:05 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 7D81BEC00D0;
 Wed, 28 Jan 2026 05:34:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 28 Jan 2026 05:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1769596445; x=1769682845; bh=kSO++nrSUVqJPUw+5+1bU
 QJAZBSFZ2jxm2SMyzad9UI=; b=D3DyIms80lRKbD4Q6ElklPiGxJ71KMOWvACV5
 crFuo0WRLLckQU5iSL1sKto9ApckMAK3vXteYh6Ccq3vHZp457RNWBstbvcqPNmV
 S/Z/+Fzv+CPHKX72CfbjuIO4JQZ+Y8C+U8ty1mAsaWwJcyyqKQfuttbqGIMeIGEF
 sbcESblwbg34OAGQ3u62QNALQuWaCTlUaRQQUAhfJ4ddJ96BYMBKdhCwmrZJCA86
 9y3Vvq6fKTkYt1s8Al2ULey8dmsBCCgahpcz71nu/E6RPN8V/5cT+kaSYafcJQQY
 7P5LDps/g6QerQNpRIoQnr3fkVrMMglcZXM0BHRwBDEBbAMdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1769596445; x=1769682845; bh=kSO++nrSUVqJPUw+5+1bUQJAZBSFZ2jxm2S
 Myzad9UI=; b=dz4BQsLDhBGJ5/JT8yIWlZ9R91sSGzQ/zrvj8k+JNsStVCL2Cyn
 S4TEs0RzAr6WLMvEmnJwIyGhtl7mylzVaxne5cXZrXRxnNccQL+SI/+U3dc29yyn
 AfZdUpl5MwvbC9xBwIOOjJILlIUlsfGmadhnE977YZffS5bsx0MmIXakK0fvt5fs
 vP8OdW5EiczYCDNEy5j0/3wc7nidSz9qWyGMtzdQ0Uk6qbtDvk6hmOphS9r1XZzU
 N3zy1OgI6TSOQ7e3cEAJvuLQ4KMoGbbYrgz6zJ2KXinlgxr9zkmq989uZeJruLyq
 1NrxbB5Y4W1tu9KTrWlAol+3wW2d81tpvxA==
X-ME-Sender: <xms:HeZ5afQPSUmvbNbgyKmUtTu7D-yBsKe32ufmr0ovhanic3s2HtD-5Q>
 <xme:HeZ5adHvC-c1GsEbx7AjCT090EvHHddch6MJz70UwcnXKPDJ0Z-KetIXRHV5HPg4r
 rIwLBI35exROzSo2S4hJKIQkVOzaI2NR3CQhYweALLi4w85x_u4>
X-ME-Received: <xmr:HeZ5aXnrNXsY5YPlr-4JhazlzAPIjmaa57Vq40LaqYLC_JQbOX1XICYcJiZ1SB9cc6ojNU2vlkeo4j7f3cfFHmaA9NcjxjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefudegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
 dtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhn
 jhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepveevfeevieeihfetudekgeekle
 eigeffueekveduteeuffeiudevteeiudekfeelnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvth
 dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggv
 vhesughpughkrdhorhhgpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:HeZ5aQ2Yo8GS1s5A07AHProzsEA0wyod_DCxWQJCNmc_KLrIVKPflA>
 <xmx:HeZ5abRhiBPnlIMzWx52YdujqUsR5zH6gDGP0szYKHxxXvP4gmbq1w>
 <xmx:HeZ5aauaoyoyifExCW4yC0rjXCX1sXazuq2lBmQsIetLhJSSP7YGVA>
 <xmx:HeZ5aYb6CO7KAznGfJqv5AKm0Cx49vSQKCfUp4TsLeaRElzCjYP1aA>
 <xmx:HeZ5afsn8QXCEOymWNN8J2I_xsRtQiZhs8AT4cYlhCFnIVM5amHmysjf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 05:34:04 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH] examples/ethtool: fix error message about ports limit
Date: Wed, 28 Jan 2026 11:33:50 +0100
Message-ID: <20260128103350.2730104-1-thomas@monjalon.net>
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

The error message about the number of ports was swapping
the desired and maximum number of ports.

Fixes: bda68ab9d1e7 ("examples/ethtool: add user-space ethtool sample application")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 examples/ethtool/ethtool-app/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/examples/ethtool/ethtool-app/main.c b/examples/ethtool/ethtool-app/main.c
index d380f69cea..b6bbae70d2 100644
--- a/examples/ethtool/ethtool-app/main.c
+++ b/examples/ethtool/ethtool-app/main.c
@@ -288,9 +288,7 @@ int main(int argc, char **argv)
 	if (cnt_ports == 0)
 		rte_exit(EXIT_FAILURE, "No available NIC ports!\n");
 	if (cnt_ports > MAX_PORTS) {
-		printf("Info: Using only %i of %i ports\n",
-			cnt_ports, MAX_PORTS
-			);
+		printf("Info: Using only %i of %i ports\n", MAX_PORTS, cnt_ports);
 		cnt_ports = MAX_PORTS;
 	}
 
-- 
2.52.0

