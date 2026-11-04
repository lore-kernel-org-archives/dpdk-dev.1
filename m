Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24EF606A331
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 09:34:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A52E4026E;
	Wed,  4 Nov 2026 10:34:08 +0100 (CET)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTPS id D0FAD40151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 10:34:05 +0100 (CET)
Received: from ar (unknown [113.239.72.160])
 by APP-03 (Coremail) with SMTP id rQCowAD3BZcJ_Opq5RlHAA--.3906S2;
 Wed, 04 Nov 2026 17:34:02 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 0/2] acl: avoid vector spills in the RVV search loops
Date: Wed,  4 Nov 2026 01:34:01 -0800
Message-ID: <20261104093401.3574400-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cac350a9-9d40-41d7-a136-0eb32a3813c0@yandex.ru>
References: <cover.1793520104.git.sunyuechi@iscas.ac.cn>
 <CAOaVG14=ECO921X+DmupfY60Dpo9r2xq=Y4+QC22G=AQ0kALQA@mail.gmail.com>
 <cac350a9-9d40-41d7-a136-0eb32a3813c0@yandex.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3BZcJ_Opq5RlHAA--.3906S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5C7k0a2IF6F4UM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
 6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxV
 W0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAa
 Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4
 A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU86OJ5UUUUU==
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCRIBAmrq6dJOhAAAsp
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The default DPDK build is unaffected.

Some distros package DPDK with buildtype=plain and -O2. Where ACL is used on
RISC-V in such a build, the gap between -O2 and -O3 is very large. A gap is
expected, but not one this large. The optimization level is the integrator's
choice, and a library with hand-written vector paths should not lose this much
because of it, so I would rather fix it upstream.

