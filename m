Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF5D112584F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 15:56:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7D714060A;
	Wed, 11 Mar 2026 16:56:54 +0100 (CET)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by mails.dpdk.org (Postfix) with ESMTP id 433C84060A
 for <dev@dpdk.org>; Wed, 11 Mar 2026 16:56:54 +0100 (CET)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-467161c4b89so20094b6e.3
 for <dev@dpdk.org>; Wed, 11 Mar 2026 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773244613;
 x=1773849413; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ML0gsN0G9I6I1MMgG+WJOVkQ1Kl6PJMUtRLXha8J1ew=;
 b=BYKWcH63bhaA7FY4JgZqIwKtQUU4DLa+kK6C+v+UZce26arWGmIgNsAYnGBs6QYwuV
 WZmJd2VBoIB96jwVA3BpC2ws+6J+i7LiYHwwgnSA7UAlbkvIYpeMkRBKMzi6JHrfd47l
 zmVJOVQvdSrL5PckBbpcrm4B3ORZGhOM2l7aWJs0FtlOQfSN51Aw4VPyIryFw/T6fRxo
 iI23YXfv+GgLcIGa3Sqlak3qgJkWFAqiuOPggeLNeLPt7NvBxg2ZDgib1zJOhV5t8M9R
 ZoFMQehZI98pEhzBrK+8LnrqVyygNg6TGtJUuMCjyYqYC9l0f+6h98+10ygleJtEJSzS
 1yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773244613; x=1773849413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ML0gsN0G9I6I1MMgG+WJOVkQ1Kl6PJMUtRLXha8J1ew=;
 b=QHSy3KUec3diM1le0y1mv34wAHB55pEqeuCcRtW26dMUK12b/GE90WzIUiWrzF1zrm
 B49ftBWK/LE8F2f7iTSxw2KqYhrsMI8WMOublHsWAzZj4tvhC+myI2FILL7Guxe2kAXa
 Erc4lZeLpCqyhli8lGfjaX8EoMX7oWRo9Yg2RerVo4PutXLCdeirC/3DokWq9affwvbK
 U4qJS1eV03RRECamykZKJvSwRDIC5t4yBKqezMmgKqv7UXr4Qqp3DnH3uMzDU2beutxZ
 gH2WLckorHdDmtIVqoSH+6W2/lUgX7zZ6gzHnUiF8z709geevsa1RIGRHuAof1Un4b9Z
 HSCQ==
X-Gm-Message-State: AOJu0YyQmFb8T4GaHPvtMpbvY31ACaiT1Wpxr3hgwdC13Ee/QkmcBipl
 ORXQFM4lePv+UXE521PqW2JGkinDoDARoDJE3SgCc9jb1p0muUfKaNfR8XK5iqDURIo=
X-Gm-Gg: ATEYQzzzEM/giuqUz4Xkievqkdf1w10lYrhTS+LTjXJJMqqboOn+PDrAmoA41R9LazL
 69O/Z78a0+w62tOt++yBCUPKofD1VhnstTplyETbIeokvdJSEeMDABO1KZr4FS73+i2TMH7+gWv
 eslawEzX7WYfIfYZc2IKV5izWUlaN6hmsQ1wPvMbFFhgyFpT5ems4yZydIauHvYSrE7pYWqpNyO
 tJzdDSJEv3WNO9ADH5ZSvNtsNlvfGlP1c19D3cAp4T77vuCXXmkzb4aOdXF2ajXjAa5w2DV+ayF
 oojeNCLd0bV3tCNwY2FgzfwSekJILa5pWU8WGZNeqIpRgGgqFSkyutCjBiLaD2xjJQC5Gej+9/+
 ZzOz/LyU+jS1Umt479l1XCZRzpZg0QcxgqlSAKhfdvkS/Rt2tQmFz9PatIczMDaSriXCfSp7hMm
 vUetD5Uu+TQt1+KydETtr436ibSmXveTO1KKI=
X-Received: by 2002:a05:6808:1304:b0:460:fce5:2fbd with SMTP id
 5614622812f47-4673343a802mr1658381b6e.23.1773244613237; 
 Wed, 11 Mar 2026 08:56:53 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e64a931sm2581932fac.14.2026.03.11.08.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 08:56:53 -0700 (PDT)
Date: Wed, 11 Mar 2026 08:56:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 shaiq.wani@intel.com, stable@dpdk.org
Subject: Re: [PATCH] app/testpmd: fix DCB forwarding TC mask and queue guard
Message-ID: <20260311085649.25c2c354@phoenix.local>
In-Reply-To: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
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

On Wed, 11 Mar 2026 08:37:51 +0000
Talluri Chaitanyababu <chaitanyababux.talluri@intel.com> wrote:

> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index c33c66f327..3fb9b940eb 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -3682,6 +3682,19 @@ cmd_config_dcb_parsed(void *parsed_result,
>  		return;
>  	}
>  
> +	/*
> +	 * Update forwarding TC mask to match actual configured TCs.
> +	 * Must query after init_port_dcb_config() to get updated nb_tcs.
> +	 */
> +	ret = rte_eth_dev_get_dcb_info(port_id, &dcb_info);
> +	if (ret == 0 && dcb_info.nb_tcs > 0) {
> +		dcb_fwd_tc_mask = (1u << dcb_info.nb_tcs) - 1;
> +	} else if (ret != 0) {
> +		fprintf(stderr, "Failed to get DCB info for port %u: %s\n",
> +				port_id, rte_strerror(-ret));
> +		return;
> +	}
> +

That function already called get_dcb_info only a few lines before?
