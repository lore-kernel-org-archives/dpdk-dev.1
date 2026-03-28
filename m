Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD97210F3DCE
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 12:04:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 994B14021F;
	Sat, 28 Mar 2026 13:04:45 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 9C851400D6
 for <dev@dpdk.org>; Sat, 28 Mar 2026 13:04:43 +0100 (CET)
Received: from [192.168.50.151] (unknown [42.177.178.249])
 by APP-05 (Coremail) with SMTP id zQCowABnvhHZw8dpsonACw--.35603S3;
 Sat, 28 Mar 2026 20:04:41 +0800 (CST)
Message-ID: <9500721c-fea6-4794-82d3-87b5b3c5d4c4@iscas.ac.cn>
Date: Sat, 28 Mar 2026 20:04:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acl: classify with RISC-V vector extension
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 P1erreCashon <2022302111412@whu.edu.cn>,
 =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, gong-flying <gongxiaofei24@iscas.ac.cn>
References: <20260309122818.661741-1-2022302111412@whu.edu.cn>
 <ff8d34eecbea40208537696b4ece33ed@huawei.com>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <ff8d34eecbea40208537696b4ece33ed@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: zQCowABnvhHZw8dpsonACw--.35603S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYF7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
 6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
 kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8I
 cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
 CY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
 x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
 CaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k2
 0xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
 UI43ZEXa7VUbrMaUUUUUU==
X-Originating-IP: [42.177.178.249]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAgAAmnHko5rqgAAs1
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

> There is already an acked by me patch:
> https://patchwork.dpdk.org/project/dpdk/patch/20260201160957.1898027-1-sunyuechi@iscas.ac.cn/
> that provides identical functionality.
> Can you probably explain why a new one is required?
> BTW, if you did spot any issues with the patch above, please
> provide your comments.
> Thanks
> Konstantin

I asked about this two weeks ago. This was an accidental duplicate. 
Going forward, if there are any issues, they will reply directly to this 
one:
https://patchwork.dpdk.org/project/dpdk/patch/20260201160957.1898027-1-sunyuechi@iscas.ac.cn/


