Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8304CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:00:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACBD4402E4;
	Tue, 26 Aug 2025 16:00:38 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id C5D3E402E4
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:00:36 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a1b0c82eeso48563045e9.3
 for <dev@dpdk.org>; Tue, 26 Aug 2025 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756216836;
 x=1756821636; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWM2T6atFKXZ7dggdZkzM4H+tgdKdUOQPvkZrgF1+Uc=;
 b=gL+GVzDmrJHktfQzSZFaMurKHnsMNng3m9GHqbbb+KEZTSZUi1p7wtc7ImqT35g59V
 8MoyqJnraWhm0nONh7EJqQx3CJ7jVNoB/jqc3620EkcDJaF+ioP4y+GuOyPIaq8NUn/u
 iv3zgeTMlSPqjvNhTR2GpRArKMniZ1j7UiUR7BxCjOTuHGtor89zl2e1O+/f+SMhuzLF
 EbTjla8d2jIivGX2yxG/vnR/J0hra8MWAmQzY/sL8FMvLAjlaoKrK7cjpsBEPIXqBBg3
 nmaQY+j4lwx6lVEQmEiPY8jg7NZ7HNUSeHys2V3QEG8MbFgc9ktWwAeN7HUO485uQy9B
 m++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756216836; x=1756821636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aWM2T6atFKXZ7dggdZkzM4H+tgdKdUOQPvkZrgF1+Uc=;
 b=S26Y08/bQ+fLWVzFbQ8/ajrMHhlY2WAR+UyBBTwrHldY6bM99f/T1NG6+LN9LmooP0
 bZH4Ib8p0E2r2XVZynn5m/qKFq5EKfJNuTsRyi8Ak2rL+GKUPY7+BGJaPhgWectSKnlM
 Y8UkYeLj/vJ3t8xIBh5jSecmVgzMyr2wmGlZRltYkf9JyjqTAzD18C5GXGw4dxrN98ks
 upBKPxoMFl8Aftcv9XgczN18FZrm7c3WopqofnDNN2kuuL0f2rBZ0E3I1nResifzwPUY
 nfMxl3pHk14orqlBN5Sv3iqnv1aoRemMdM++PsXJeY1XB63l6orNthDNmZz5tNs6coer
 JzlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaq/WYDLjKUBCubcez7kv+Cuw0TzGNkE6f1CLwvehD9i2BzZTR1mbLFR0gAzHMl+4Oyww=@dpdk.org
X-Gm-Message-State: AOJu0YwchYj62l4/5yo5Y52bCc51/cGduRBIcstVMqcm3glUF8wyVWGF
 r9MmfzJ9STrQ+FUMSAPVr7RxPUFFDFjkU7jv6yxll0VID1Yjdd8YU1n7wlfsNCDLT4E=
X-Gm-Gg: ASbGncv5PsJjoYCEifPEYewjSOs82XcWvz6FbotWf3/Vzzsps7OxziwQGMfoIL4xplT
 xcQ/pKYBrv9eN52U7Ww3/CSpgzenf1TFow3aia8ht/l5Ei3cmfOvZi3ucdcD1dBJcWenlrLnEls
 ikrPqag9aci3E5+1dz6yiFzcWdy/Vq8a6PjVUBWIk+MdnpPAxdjb299iFmQhLRg+RvwdqW6IonO
 haoPURCFRP0i/F3dAaZbgpvH+5mbKKwMMtgL06FDfwIsfA8Fw1XrwbWqpcgBr5CO/4e8NoMRkQS
 1HxuE6iZ8/Suz2VZddMqpYm8ZHnuY6bnBAcapckfGTuI9sDGS5OQJXyyF/jfe0lp+kk66WV1fCC
 jeJcsfh8T3doFrAAmYCqy49EukQjQAqKEqN0h8v+rIPsoePuszWN0fFQOwCVgmg7lUvqsMjDizx
 Y=
X-Google-Smtp-Source: AGHT+IF489ZWjiaFvuUGGPi6UZgGRJ9TroeLhDbNKdkG9qBr1rMCCg012SFCwExnCQpywOTdYR77Bw==
X-Received: by 2002:a05:600c:1389:b0:455:f59e:fd9b with SMTP id
 5b1f17b1804b1-45b517c584cmr158812055e9.24.1756216835983; 
 Tue, 26 Aug 2025 07:00:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57492878sm151657685e9.19.2025.08.26.07.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 07:00:35 -0700 (PDT)
Date: Tue, 26 Aug 2025 07:00:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Cristian Dumitrescu <cristian.dumitrescu@intel.com>, Aman Singh
 <aman.deep.singh@intel.com>, Sunil Kumar Kori <skori@marvell.com>,
 dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] app/testpmd: validate dscp and vlan table entries for
 meter creation
Message-ID: <20250826070031.3428054f@hermes.local>
In-Reply-To: <20250822121430.2228507-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250822121430.2228507-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 22 Aug 2025 08:14:30 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> Add validation mechanism for meter creation. The maximum
> possible entries are
> [<dscp_tbl_entry0> <dscp_tbl_entry1> ...<dscp_tbl_entry63>]
> [<vlan_tbl_entry0> <vlan_tbl_entry1> ... <vlan_tbl_entry15>].
> Currently, testpmd allows any input table entries for dscp
> and vlan tables.
> 
> This patch validates the maximum possible dscp and vlan table
> entries for meter creation.
> 
> Fixes: 9f5488e326d3b ("app/testpmd: support different input color method")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>  app/test-pmd/cmdline_mtr.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/app/test-pmd/cmdline_mtr.c b/app/test-pmd/cmdline_mtr.c
> index e16c5b268f..1435645c1a 100644
> --- a/app/test-pmd/cmdline_mtr.c
> +++ b/app/test-pmd/cmdline_mtr.c
> @@ -85,14 +85,33 @@ parse_uint(uint64_t *value, const char *str)
>  	return 0;
>  }
>  
> +static int
> +validate_input_color_table_entries(char *str)
> +{
> +	char *token;
> +	int i = 0;

Useless initialization

> +	token = strtok_r(str, PARSE_DELIMITER, &str);
> +	for (i = 0; token != NULL; i++)
> +		token = strtok_r(str, PARSE_DELIMITER, &str);

Rather than parsing all the way to the end, why not put the max test inside the loop

> +	if (i > (MAX_DSCP_TABLE_ENTRIES + MAX_VLAN_TABLE_ENTRIES))
> +		return -1;
> +	else
> +		return 0;
> +}
> +
>  static int
>  parse_input_color_table_entries(char *str, enum rte_color **dscp_table,
>  	enum rte_color **vlan_table)
>  {
>  	enum rte_color *vlan, *dscp;
>  	char *token;
> +	char *temp_str = strdup(str);
>  	int i = 0;
>  
> +	if (validate_input_color_table_entries(temp_str))
> +		return -1;
> +

On error, this leaks the temporary string created (temp_str).


