Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EF3CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 10:17:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3242B4026D;
	Mon, 10 Nov 2025 11:17:53 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 7F859400D6
 for <dev@dpdk.org>; Mon, 10 Nov 2025 11:17:51 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4lw04fb1zJ46px;
 Mon, 10 Nov 2025 18:17:20 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id B7A261402FF;
 Mon, 10 Nov 2025 18:17:49 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 10:17:49 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <wathsala.vithanage@arm.com>, <honnappa.nagarahalli@arm.com>,
 <ola.liljedahl@arm.com>, <dhruv.tripathi@arm.com>,
 <david.marchand@redhat.com>
Subject: [PATCH v3 0/1] ring: correct ordering issue in head/tail update
Date: Mon, 10 Nov 2025 10:17:16 +0000
Message-ID: <20251110101717.233685-1-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002174137.3612042-1-wathsala.vithanage@arm.com>
References: <20251002174137.3612042-1-wathsala.vithanage@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100006.china.huawei.com (7.182.19.111) To
 dubpeml500001.china.huawei.com (7.214.147.241)
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

This patch fixes a subtle ordering issue in the ring code that can lead
to incorrect behavior under certain conditions. The change adopts a
solution that balances performance with compatibility for dependent
libraries.

For background, motivation, and validation (including Herd7 litmus
tests), see the accompanying write-up:
https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/when-a-barrier-does-not-block-the-pitfalls-of-partial-order

V1->V2:
  * Switched from squashing unsafe partial orders (solution #3) to
  * establishing a pairwise happens-before relationship between the
  * producer and consumer heads (solution #2).

V2->V3 (Konstantin):
  * Added Fixes and CC to stable
  * Extend patch to cover HTS and RTS mode

Wathsala Vithanage (1):
  ring: fix unsafe ordering for head/tail update

 lib/ring/rte_ring_c11_pvt.h      | 9 +++------
 lib/ring/rte_ring_hts_elem_pvt.h | 6 ++++--
 lib/ring/rte_ring_rts_elem_pvt.h | 6 ++++--
 3 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.51.0

