Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89BFC9832F
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Sep 2026 16:08:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 670DC402A4;
	Sat, 26 Sep 2026 18:08:32 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id A7DAB4028B
 for <dev@dpdk.org>; Sat, 26 Sep 2026 18:08:30 +0200 (CEST)
Received: from ar (unknown [42.86.133.105])
 by APP-03 (Coremail) with SMTP id rQCowAAXHjz97bdqMRjXCA--.59417S2;
 Sun, 27 Sep 2026 00:08:29 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3 3/5] eal: make unaligned really unaligned
Date: Sat, 26 Sep 2026 09:08:28 -0700
Message-ID: <20260926160828.964021-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907183239.629053-4-stephen@networkplumber.org>
References: <20260907183239.629053-4-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXHjz97bdqMRjXCA--.59417S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5W7k0a2IF6FyUM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
 6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr
 0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r4UM2AIxVAIcxkEcVAq07x20xvEncxI
 r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
 Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
 c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
 026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
 0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
 vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
 6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-Originating-IP: [42.86.133.105]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBwQCAmq31FojPQAAsO
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

This is a fix for RISC-V, thanks.

Acked-by: Sun Yuechi <sunyuechi@iscas.ac.cn>

