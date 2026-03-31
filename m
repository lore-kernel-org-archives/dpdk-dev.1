Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1308D1061B21
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 03:07:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C91540285;
	Tue, 31 Mar 2026 05:07:00 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 7C0D34025E
 for <dev@dpdk.org>; Tue, 31 Mar 2026 05:06:58 +0200 (CEST)
Received: from ar (unknown [42.177.178.249])
 by APP-03 (Coremail) with SMTP id rQCowABXO+JQOstpCZBiDA--.9661S2;
 Tue, 31 Mar 2026 11:06:56 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: Re: [PATCH v3] node: lookup with RISC-V vector extension
Date: Tue, 31 Mar 2026 11:06:56 +0800
Message-ID: <20260331030656.2599255-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330135456.3064ee41@phoenix.local>
References: <20260330135456.3064ee41@phoenix.local>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: rQCowABXO+JQOstpCZBiDA--.9661S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5C7k0a2IF6F1UM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
 6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
 1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAa
 Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4
 A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7xRtq2NPUUUUU==
X-Originating-IP: [42.177.178.249]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBwsDAmnLGIWF4wABsV
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

Hi,=0D
=0D
I've addressed the first two points in v4:=0D
- Removed the duplicate macro definitions from ip4_lookup_rvv.h=0D
- Split the SIMD bitwidth change into a separate patch=0D
=0D
For the remaining suggestions (3-5), I don't think changes are=0D
necessary at this time. If any human reviewer feels otherwise,=0D
I'm happy to discuss.=0D

