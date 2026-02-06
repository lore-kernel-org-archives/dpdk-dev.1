Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F68EB28E3
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 08:18:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC6564029A;
	Fri,  6 Feb 2026 09:18:55 +0100 (CET)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id B23C440293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 09:18:53 +0100 (CET)
Received: from [192.168.50.151] (unknown [119.114.155.161])
 by APP-03 (Coremail) with SMTP id rQCowAAHHdTro4Vpa1DLBw--.6116S3;
 Fri, 06 Feb 2026 16:18:51 +0800 (CST)
Message-ID: <89e71421-91a2-4e9f-b780-90660131c067@iscas.ac.cn>
Date: Fri, 6 Feb 2026 16:18:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] node: lookup with RISC-V vector extension
To: dev@dpdk.org
Cc: Zijian <zijian.oerv@isrc.iscas.ac.cn>,
 =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
References: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: rQCowAAHHdTro4Vpa1DLBw--.6116S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5X7k0a2IF6F1UM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
 6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
 xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
 0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z2
 80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI
 7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
 Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
 6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
 AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
 1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7xRAo7tJUUUUU==
X-Originating-IP: [119.114.155.161]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAUKAmmFl3wvWQABsx
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

v3: rte_memcpy -> memcpy

