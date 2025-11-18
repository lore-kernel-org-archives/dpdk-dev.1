Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C150CEBF8D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 02:22:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10FBA4027D;
	Tue, 18 Nov 2025 03:22:40 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 882A84026A;
 Tue, 18 Nov 2025 03:22:38 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=/YyiaxX+PK2zMMi/nq2bboo5vMva6bdEOoFtFGoEX3Q=;
 b=YNchI2nwE9wdXbf3QkUicKCihyTVCIlBhEzu1f9b3ptIqIIVohuAZdoSUYL6JkGorT3eB+/cn
 Xjd3YBclqZuwJVlKkU7BNuzgvRzF6/RTsCOSOR7xoVVDyOvNQToo1aFHZVOFhvVWFXnUpiMCNAj
 uMlQWm1OTy4Y4MZJhAarB+M=
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d9SyY2K5KzRj1c;
 Tue, 18 Nov 2025 10:20:53 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id E16D218048D;
 Tue, 18 Nov 2025 10:22:35 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 10:22:35 +0800
Message-ID: <79049dc3-8c0b-41f2-bb02-73c18766377c@huawei.com>
Date: Tue, 18 Nov 2025 10:22:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] test: fix impossible format-truncation in cfgfiles
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251117175332.14014-1-stephen@networkplumber.org>
 <20251117175332.14014-6-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251117175332.14014-6-stephen@networkplumber.org>
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

On 11/18/2025 1:52 AM, Stephen Hemminger wrote:
> Although, it is not possible on Linux (which always uses /tmp)
> the compiler complains about possible snprintf() truncation.
> Simplest fix is to just increase the size of the filename variable.
> 
> Fixes: be22019a58c4 ("test: restore cfgfile tests")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_cfgfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/app/test/test_cfgfile.c b/app/test/test_cfgfile.c
> index b189d9d7a5..823b48e1fa 100644
> --- a/app/test/test_cfgfile.c
> +++ b/app/test/test_cfgfile.c
> @@ -148,7 +148,7 @@ static int
>  test_cfgfile_realloc_sections(void)
>  {
>  	struct rte_cfgfile *cfgfile;
> -	char filename[PATH_MAX];
> +	char filename[PATH_MAX + NAME_MAX];

there are many other function invoke make_tmp_file(), such as test_cfgfile_invalid_section_header.

I think we could modify make_tmp_file(): snprintf(filename, PATH_MAX - NAME_MAX, ...).

>  	int ret;
>  	const char *value;
>  

