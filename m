Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9B3CA9ED2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 13:10:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B71B4028B;
	Tue, 13 Oct 2026 15:10:05 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1D0DD4027B
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:10:02 +0200 (CEST)
Received: from ar (unknown [42.86.129.104])
 by APP-01 (Coremail) with SMTP id qwCowADHmu6fLc5q5THDCg--.4558S2;
 Tue, 13 Oct 2026 21:09:52 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jan Viktorin <viktorin@cesnet.cz>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v5 0/3] eal/topology: introduce topology-aware lcore
 grouping
Date: Tue, 13 Oct 2026 06:09:51 -0700
Message-ID: <20261013130951.3959832-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <MN0PR12MB624886A9D6D326FEFE773805829F2@MN0PR12MB6248.namprd12.prod.outlook.com>
References: <MN0PR12MB624886A9D6D326FEFE773805829F2@MN0PR12MB6248.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADHmu6fLc5q5THDCg--.4558S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYq7k0a2IF6F4UM7kC6x804xWl14x267AK
 xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
 6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gc
 CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
 r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
 Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIE
 c7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GF
 yl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
 67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
 8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
 wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
 v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7GYLDUUUU
X-Originating-IP: [42.86.129.104]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBwATAmrN7c3OUQAAsO
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

Hi Vipin,

Tested v5 on two RISC-V machines, no RISC-V specific code needed.
topology_autotest passes on both. L3 is detected where the firmware
describes it (SG2044), and empty where it doesn't, same as on ARM.

Tested-by: Sun Yuechi <sunyuechi@iscas.ac.cn>

