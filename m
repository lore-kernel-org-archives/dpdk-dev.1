Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC3BCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 01:07:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A318402A2;
	Wed, 30 Sep 2026 03:07:44 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 171B3400EF
 for <dev@dpdk.org>; Wed, 30 Sep 2026 03:07:43 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=37ELJdDe8djxRjXHMmrYUmPuF/p4PaD1Rg9bspWnPJ4=;
 b=mYM67amJOHpI+cuEY016duo1y3glV8kQS1hDqegenXhsPHW0psjVCPO19ar15gDHP7bHA7vyo
 M701SOCKmNuUlLTCZs2VJ3nLEmuxHJwmK6+T7iOv68G3jtyju2hLhCUG27VkivXiX/xWhf21Zug
 fTt4qZNnfknPFAJsI7kKHq8=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hvc6D0z4SzmV8H;
 Wed, 30 Sep 2026 08:55:32 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id C814440572;
 Wed, 30 Sep 2026 09:07:40 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 30 Sep 2026 09:07:40 +0800
Message-ID: <bb64c4f2-e7a9-4d6f-ae4e-343637e04851@huawei.com>
Date: Wed, 30 Sep 2026 09:07:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/61] kvargs: add hexadecimal conversion helpers
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
 <20260929163800.1108305-4-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260929163800.1108305-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 9/30/2026 12:36 AM, Stephen Hemminger wrote:
> Several device arguments are documented as a bare hexadecimal mask, with
> no 0x prefix, such as the ice hw_debug_mask, the cxgbe filtermode
> and filtermask, the hns3 dev_caps_mask and the ark Pkt_dir. Each
> open codes strtoull() with base 16, and each gets the validation
> wrong in a familiar way. ice checks errno but not the end pointer,
> cxgbe checks errno without clearing it first, and hns3 checks
> nothing at all, so dev_caps_mask=junk is silently taken as zero.
> 
> The existing helpers cannot be used for these. They read base 16 only
> when the value carries an explicit 0x prefix, so a documented bare mask
> containing a letter, such as "ff", would be rejected outright, while one
> which happens to be all digits, such as "10", would be reread as decimal
> and change from sixteen to ten.
> 
> The second case is the dangerous one: it silently changes the meaning of
> a working command line instead of rejecting it, which is the one kind of
> breakage the rest of this series is careful to avoid.
> 
> Add rte_kvargs_handle_hex32() and rte_kvargs_handle_hex64(), which are
> the same as rte_kvargs_handle_u32() and rte_kvargs_handle_u64() except
> that the value is always read as hexadecimal, whether or not it carries
> a 0x prefix. Expose the underlying rte_kvargs_to_hex() for a mask
> narrower than the target type.
> 
> A sign is rejected, as it is for the unsigned handlers, so a mask cannot
> be given as -1.
> 
> Only the 32 and 64 bit widths are added, since those are the only ones
> any caller needs; the family can be extended on demand.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

