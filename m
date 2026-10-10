Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C55CA9EBD
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 02:43:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC6A2402B4;
	Sat, 10 Oct 2026 04:43:37 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 0E3C34027C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 04:43:37 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=pPsQdSE/vBkmLLFBUAyF6LAX/KAYze8GCtp7xZ9Xzg4=;
 b=hZAaYWfE3cZACYrqAmaMyYu1VK7lo4P508XUcjX01CBj6+5Z9ohwReTF5trwEDirKV4FpQkQ+
 63koMlXpjoKr6Jcuv0hlTAZOmt64zoiEbyUTCLKN05JK2Je6vF3e4qiPhc4KU9w3W3MHm17a55F
 rFZfJ7q0XhNGAh3+FgDNvYc=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4j1nm653yPzLlSh;
 Sat, 10 Oct 2026 10:31:18 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 6CBB84055B;
 Sat, 10 Oct 2026 10:43:34 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 10 Oct 2026 10:43:34 +0800
Message-ID: <6bc4a7f2-7374-4d2e-b23b-3d040a082daa@huawei.com>
Date: Sat, 10 Oct 2026 10:43:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 60/65] net/hns3: use kvargs hex helper for capability
 mask
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Xingui Yang <yangxingui@huawei.com>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
 <20260930224340.58580-61-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260930224340.58580-61-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 10/1/2026 6:41 AM, Stephen Hemminger wrote:
> hns3_parse_dev_caps_mask() does no validation whatsoever: strtoull() is
> called with neither errno cleared nor the end pointer checked, so
> "dev_caps_mask=junk" is silently taken as zero and "dev_caps_mask=-1"
> wraps around to enable every capability.
> 
> The value is documented as a hexadecimal mask, so use
> rte_kvargs_handle_hex64(), which reads it as hexadecimal with or without
> a 0x prefix. The documented form "dev_caps_mask=0xF" is unchanged, and
> so is a bare "F".
> 
> Note that hns3_parse_devargs() discards the rte_kvargs_process() return
> value for every argument it parses, so a malformed mask is now reported
> but still leaves the default of zero in place rather than failing probe.
> Propagating those errors is a behaviour change per argument and is left
> for a separate patch.
> 
> HNS3_CONVERT_TO_HEXADECIMAL loses its last user here, and
> HNS3_CONVERT_TO_DECIMAL lost its own earlier in this series, so remove
> both.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

