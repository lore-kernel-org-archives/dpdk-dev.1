Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E5C19F32
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 02:17:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03E7A402A0;
	Thu,  6 Mar 2025 03:17:48 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5C15040275
 for <dev@dpdk.org>; Thu,  6 Mar 2025 03:17:46 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 61EE821104AD; Wed,  5 Mar 2025 18:17:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61EE821104AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741227465;
 bh=Q0RvR0PyVSHvQazKYjpF+Sc2k3qgylnVfitFKfZf3XQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bm8h9iDDkQDJnjJrpb4p+Qam4TaeF/G/PzXI1tc4cm01ugiK9ChsgBnYvHVzRutrC
 BCkbc5KQ2V6sG/nAYS126ms8EBVpiX5PMispOmaiErYlZZDGa1p7Of8rWKfyAvKjEI
 mQ8Ur1l1d5WnCy9CLY8n1HFqASfLMTqBghhx2PzA=
Date: Wed, 5 Mar 2025 18:17:45 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: longli@linuxonhyperv.com
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] net/mana: avoid the use of variable length array
Message-ID: <20250306021745.GA9956@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1741135052-2039-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741135052-2039-1-git-send-email-longli@linuxonhyperv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Tue, Mar 04, 2025 at 04:37:32PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> The pathname can be defined as name[MAX_PATH]. This makes the driver
> compilable using MSVC.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/net/mana/mana.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
> index c37c4e3444..d12dff6ce1 100644
> --- a/drivers/net/mana/mana.c
> +++ b/drivers/net/mana/mana.c
> @@ -36,11 +36,8 @@ static rte_spinlock_t mana_shared_data_lock = RTE_SPINLOCK_INITIALIZER;
>  
>  /* Allocate a buffer on the stack and fill it with a printf format string. */
>  #define MANA_MKSTR(name, ...) \
> -	int mkstr_size_##name = snprintf(NULL, 0, "" __VA_ARGS__); \
> -	char name[mkstr_size_##name + 1]; \
> -	\
> -	memset(name, 0, mkstr_size_##name + 1); \
> -	snprintf(name, sizeof(name), "" __VA_ARGS__)
> +	char name[PATH_MAX]; \
> +	snprintf(name, PATH_MAX, "" __VA_ARGS__)
>  
>  int mana_logtype_driver;
>  int mana_logtype_init;
> -- 
> 2.34.1

Did you try to remove the line below from mana/meson.build?
That line prevents the compiler from complain about VLAs. If
the driver is VLA-free after this fix it would be great
if the compiler was allowed to complain about VLAs (default
in DPDK project).

If the code still compiles without this line then it should be
safe to remove it:

cflags += no_wvla_cflag
--
Andre Muezerie
