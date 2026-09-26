Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91121C9833D
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Sep 2026 14:38:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D6DE402A4;
	Sat, 26 Sep 2026 16:38:17 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 8FD2D4028B
 for <dev@dpdk.org>; Sat, 26 Sep 2026 16:38:15 +0200 (CEST)
Received: from ar (unknown [42.86.133.105])
 by APP-03 (Coremail) with SMTP id rQCowACXokDT2LdqfO_UCA--.57825S2;
 Sat, 26 Sep 2026 22:38:13 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Daniel Gregory <code@danielg0.com>,
 Daniel Gregory <daniel.gregory@bytedance.com>
Cc: dev@dpdk.org,
 =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC PATCH] eal/riscv: add support for zawrs extension
Date: Sat, 26 Sep 2026 07:38:11 -0700
Message-ID: <20260926143811.334693-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20240502144149.66446-1-daniel.gregory@bytedance.com>
References: <20240502144149.66446-1-daniel.gregory@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXokDT2LdqfO_UCA--.57825S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyfWF1UGF4rKw4DXF4kXrb_yoWDKFXE9F
 95K3srKwn8AFW0qrs2kr4rCrZI9rWvgryUWr4qqr12vFn7ZanrXwn5Crn5Xw4rJay8Arna
 9rWSvrZay3W29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb2xYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
 80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
 zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
 8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4oUDDUUUU
X-Originating-IP: [42.86.133.105]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAMCAmq30-IAXgABss
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

Hi Daniel,

This RFC has been sitting for a while. I tested it on an RVA23 board
(SpacemiT K3, Zawrs present) and it works: over a 200 ms wait, wrs.nto
woke up 53 times vs 14.6M spins with pause, hand-off latency is the same,
and the lock/ring/atomic autotests pass.

To move it forward it needs:

- rebase
- build-time detection via __riscv_zawrs, like the V extension in
  config/riscv/meson.build, instead of the manual meson flag; this also
  answers Stanisław's question about extension detection
- int memorder -> rte_memory_order memorder
- RTE_WAIT_UNTIL_MASKED: the alignment assert is inverted (!= 0 -> == 0)
- do a plain load before taking the reservation; always starting with
  lr costs ~10% on the uncontended MP/MC ring path (ring_perf_autotest)
- release notes and a note in cross_build_dpdk_for_riscv.rst

If you are still interested, please send a v2 within a month (a short
window only because the patch has been idle for over two years; if you
need more time, just say so). Otherwise I will send a v2 with these
changes, keeping your authorship.

Thanks,
Sun Yuechi

