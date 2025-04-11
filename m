Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C07C3601E
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 00:05:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E46A4402DD;
	Fri, 11 Apr 2025 02:05:08 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 12F7640285
 for <dev@dpdk.org>; Fri, 11 Apr 2025 02:05:07 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1BD902114DAC; Thu, 10 Apr 2025 17:05:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BD902114DAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744329906;
 bh=s3gmsZWyMTNlq0z17B71c6aFKQeSGdcxfQ6Cs4iOdHw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rTKGCAAr42ercKlEw5ghEM+eOqv80OhdTDIDRoqT3BWvtuxO+IuggmkSCJ3bOyS2M
 vU4cl/Qka62Wh8nT0BV/dDTH6I6h4oONOQsBiG2NcUQ2cNxtlV64jU/WVamJAz8+Q+
 2VAOlHfW9iX+SXqZtZp0FWE2Vy/aNnssodxq8+h0=
Date: Thu, 10 Apr 2025 17:05:06 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH] app/testpmd: fix dump command list for MSVC
Message-ID: <20250411000506.GA10978@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250410160237.3067629-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410160237.3067629-1-david.marchand@redhat.com>
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

On Thu, Apr 10, 2025 at 06:02:36PM +0200, David Marchand wrote:
> Compiling with MSVC results in warnings like below:
> 
> app/test-pmd/cmdline.c(9023): warning C5101: use of preprocessor
>     directive in function-like macro argument list is undefined behavior
> 
> Construct token list at runtime.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Note: this is an alternative to
> https://patchwork.dpdk.org/project/dpdk/patch/1740414265-12217-6-git-send-email-andremue@linux.microsoft.com/
> 
> ---
>  app/test-pmd/cmdline.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index d10709f6bc..b4089d281b 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -9018,6 +9018,12 @@ static void cmd_dump_parsed(void *parsed_result,
>  
>  static cmdline_parse_token_string_t cmd_dump_dump =
>  	TOKEN_STRING_INITIALIZER(struct cmd_dump_result, dump,
> +		"" /* defined at init */);
> +
> +static void
> +cmd_dump_init(void)
> +{
> +	cmd_dump_dump.string_data.str =
>  		"dump_physmem#"
>  		"dump_memzone#"
>  		"dump_socket_mem#"
> @@ -9029,7 +9035,8 @@ static cmdline_parse_token_string_t cmd_dump_dump =
>  #ifndef RTE_EXEC_ENV_WINDOWS
>  		"dump_trace#"
>  #endif
> -		"dump_log_types");
> +		"dump_log_types";
> +}
>  
>  static cmdline_parse_inst_t cmd_dump = {
>  	.f = cmd_dump_parsed,  /* function to call */
> @@ -13961,6 +13968,7 @@ init_cmdline(void)
>  	/* initialize non-constant commands */
>  	cmd_set_fwd_mode_init();
>  	cmd_set_fwd_retry_mode_init();
> +	cmd_dump_init();
>  
>  	count = 0;
>  	for (i = 0; builtin_ctx[i] != NULL; i++)
> -- 
> 2.49.0

Acked-by: Andre Muezerie <andremue@linux.microsoft.com>
