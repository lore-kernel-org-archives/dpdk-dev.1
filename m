Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64574CD6E43
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 00:27:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1EB140264;
	Fri, 29 May 2026 02:27:22 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id D047D4021F
 for <dev@dpdk.org>; Fri, 29 May 2026 02:27:20 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=L8Dwdn/ft3eQQbEqU2lYiyL8odYoDUX/HJK6ZfM/li0=;
 b=VDwAzeTSqJ0R5sfa1VZCKbNBO+NvoY0Y6O4GcPivAiPP8b7pTChls141GaY0NEdg9UWf1MXeK
 V+Z3w4ZocjOyZxjiYFPmCRABZPp2yf8doGAqPvbD5OUxrVhnSn+aXXyBSUXfv37mJ4hbP4nzC5v
 OZOd4Ca4c1gyDXdsauCtbSc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gRP9w2vdhzRhRN
 for <dev@dpdk.org>; Fri, 29 May 2026 08:19:32 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B08A640571
 for <dev@dpdk.org>; Fri, 29 May 2026 08:27:18 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 08:27:18 +0800
Message-ID: <c97b0929-b80b-4b37-9902-1cd874e28648@huawei.com>
Date: Fri, 29 May 2026 08:27:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] usertools/telemetry: add help support
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
 <20260522133714.133268-1-bruce.richardson@intel.com>
 <20260522133714.133268-4-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260522133714.133268-4-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 5/22/2026 9:37 PM, Bruce Richardson wrote:
> While the telemetry infrastructure supported using "/help,/<cmd>" to get
> help on specific commands, with the addition of script-specific
> commands, we needed better help support to explain the use of FOREACH,
> and to allow e.g. "help /<cmd>" using space separation, which is more
> intuitive. This patch adds that help support.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  usertools/dpdk-telemetry.py | 61 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/usertools/dpdk-telemetry.py b/usertools/dpdk-telemetry.py
> index 8b976160e0..2c88b91517 100755
> --- a/usertools/dpdk-telemetry.py
> +++ b/usertools/dpdk-telemetry.py
> @@ -25,6 +25,26 @@
>  ALIAS_FILE = ".dpdk_telemetry_aliases"
>  MAX_ALIAS_EXPANSIONS = 32
>  
> +BASIC_HELP_TEXT = """Basic usage:
> +    /<command>[,<params>]      Send a telemetry command to the app
> +    FOREACH ...                Run a compound query over list items
> +    help                       Show this help
> +    help /<command>            Show app-provided help for a command
> +    help FOREACH               Show FOREACH usage and examples
> +    quit                       Exit the client

Please add help alias to show ALL loaded command alias





