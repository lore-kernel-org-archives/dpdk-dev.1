Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8C7FF885A
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 07:12:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EDBC40270;
	Mon,  4 May 2026 09:12:00 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id BA4C24026C
 for <dev@dpdk.org>; Mon,  4 May 2026 09:11:57 +0200 (CEST)
Received: from [192.168.50.151] (unknown [119.114.153.107])
 by APP-03 (Coremail) with SMTP id rQCowADn9cy6Rvhpyt0GEA--.42492S3;
 Mon, 04 May 2026 15:11:55 +0800 (CST)
Message-ID: <965a04fe-b50a-4096-b45c-937994694b19@iscas.ac.cn>
Date: Mon, 4 May 2026 15:11:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] acl: add RISC-V vector extension implementation
To: dev@dpdk.org
Cc: Zijian <zijian.oerv@isrc.iscas.ac.cn>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260201160957.1898027-1-sunyuechi@iscas.ac.cn>
Content-Language: en-US
From: sunyuechi <sunyuechi@iscas.ac.cn>
In-Reply-To: <20260201160957.1898027-1-sunyuechi@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: rQCowADn9cy6Rvhpyt0GEA--.42492S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4xKFy5Cw48XF4kAr1kKrg_yoWfuFg_KF
 48Gr97WFWDJF4DZFy3trn5CFy8C3ykZF15JFyUJa47XFsrGw47tr1kJw40vF47WrWqka4F
 ya4xGr97A342vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb28YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUuc_UUUUU=
X-Originating-IP: [119.114.153.107]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCRERAmn4KcE0WwAAsd
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

On 2/2/26 12:09 AM, Sun Yuechi wrote:

> Implement ACL classify function for RISC-V architecture
> using RISC-V Vector Extension instruction set.
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> Signed-off-by: Zijian <zijian.oerv@isrc.iscas.ac.cn>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---
>   app/test-acl/main.c                    |   4 +
>   app/test/test_acl.c                    |   1 +
>   config/riscv/meson.build               |   1 +
>   doc/guides/rel_notes/release_26_03.rst |   6 +
>   examples/l3fwd/l3fwd_acl.c             |   4 +
>   lib/acl/acl.h                          |   4 +
>   lib/acl/acl_run.h                      |   2 +
>   lib/acl/acl_run_rvv.c                  |  18 ++
>   lib/acl/acl_run_rvv.h                  | 326 +++++++++++++++++++++++++
>   lib/acl/meson.build                    |   2 +
>   lib/acl/rte_acl.c                      |  34 +++
>   lib/acl/rte_acl.h                      |   1 +
>   lib/eal/riscv/include/rte_vect.h       |   2 +-
>   13 files changed, 404 insertions(+), 1 deletion(-)
>   create mode 100644 lib/acl/acl_run_rvv.c
>   create mode 100644 lib/acl/acl_run_rvv.h
ping

