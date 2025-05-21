Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86125C54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:05:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D74C42D9D;
	Wed, 21 May 2025 16:05:49 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id B803E42D9D
 for <dev@dpdk.org>; Wed, 21 May 2025 16:05:48 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-6f0ad74483fso72080806d6.1
 for <dev@dpdk.org>; Wed, 21 May 2025 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747836348;
 x=1748441148; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKd0QMICYu7xI7b47RGuTy0PDihiGH4ai5oYn+2AE1o=;
 b=H0/dUw7Gb7KZXpVT2HSwLFt+cgU5r8fjfkKQb/6ajobEG26nHUykQQhmNdNF9pyOwc
 Z2wqlYP6GHrENjjr3kiB77AIeF9jDlkPvNgY6czCMVFDLAW2bLeQxCY9g+qOAR+XyUi/
 VypoZCEbLCY7oYRgdUUIL8nJWG1Wrzl2YXrk745tOgzTGMO4C6cmB+ertED4lMQw+xZP
 gmAnjhx6qUPOqfIfD/5utZ09rBRyj4c3C6zkjpg5oK922g1opBSTvDVHZD9KwWTTB8sX
 fgGpjXseKNusiiIa2YT0YtXi6Nciry/sxBZtmbHCoFm9As2IzCO6XL1/sPsv3e8j9bie
 Txtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747836348; x=1748441148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKd0QMICYu7xI7b47RGuTy0PDihiGH4ai5oYn+2AE1o=;
 b=H5ImMwIuF2PaPvCmYCcKQ4f/5i0oqcSZkKJBYlm09ClIeA2dQMOX2LGH438S8zUwfL
 VnV4VzMffh/Ouk5Y/l6qx5WjvXD8gECBLM/vH5s30HD4qLJA9TAx0NoBkorQ9Y61WAEz
 GVE5Epa787hgnWKBh3QUYyicdd5RhGxrJbixjrdRyLYmiv4Jv/s1tK8XrNobq9T26HYf
 B6TpArfKjvLNvFeEgTQ4/5WXeHT+2sKnGrlFrBce+rqGvk5cxcsRqLAESEKirUyNMU/M
 vwjWNeTXFo8xDuKTQRMANdeBU9ThraqWhe3oTZzfJik9uFLdJB4XKhKY9LYVxPkguERM
 Pq0g==
X-Gm-Message-State: AOJu0YwSEi4LlVHR6fr5LcqNvEVyyLpdpimGObKUecQhemGhWy2Mefco
 6wIxPIcsq/NOlhxLW8C4VDuxHUXw5jnNLXmIMg3Vxy6oRAIZM5+4y6tSEkAoESf2kfc=
X-Gm-Gg: ASbGncurXMHR2889rOCE60CFzkiqYMCSj+PIFZvhqMrHEuvdy7+pMP31pF53kDuB5sV
 nd8tvwYfaQeqMStotYPMKea+qwS/YJFYnpS643RcS83Uia0O1nAA8WjNYpbQUzdIfr8NtlMJigT
 R3n3oY803qablRuc0r1WAbPpoSAvam+fVCqlcSiFM1ek+jQYlhfC2r7C7uY/plmxPXVgLOJBZ1y
 s4lKbyuVY2m0/N9HcOZ8foC/XL91I/8OIuPSrxnpfBe6NAk6cIQsjFz6BzKHaZHwF+8pLoKfgxd
 HGXD73qyqB9uNUpHq3aEw+eBgV0iuUTvO1t2uGN9WxWXZMjXiE+37LzhCa1R+ltX830Skcg0+cJ
 aX5dg360I2/wtVJ5oOBjmN9cMqdrpt5ExA8PfgIo=
X-Google-Smtp-Source: AGHT+IE16om08B374z4at5vn0L3V4/FprbGbIDE4eMIyq/mDmX5MiySWFVjxRy8ekYC95+R0XQmnHg==
X-Received: by 2002:a05:6214:f05:b0:6ed:1545:65c3 with SMTP id
 6a1803df08f44-6f8b07db221mr356374806d6.2.1747836342553; 
 Wed, 21 May 2025 07:05:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f8b0883f20sm86438806d6.22.2025.05.21.07.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 07:05:42 -0700 (PDT)
Date: Wed, 21 May 2025 07:05:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 2/3] cmdline: add floating point support
Message-ID: <20250521070538.29f64bc2@hermes.local>
In-Reply-To: <b9f8ac77e4eeecd67a83d72cdf52ef3e08539bab.1746631324.git.anatoly.burakov@intel.com>
References: <ec8528874aad76348f27c551289e1729b2fdcd25.1746631324.git.anatoly.burakov@intel.com>
 <b9f8ac77e4eeecd67a83d72cdf52ef3e08539bab.1746631324.git.anatoly.burakov@intel.com>
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

On Wed,  7 May 2025 16:22:11 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> +NUMERIC_TYPES = {
> +    "UINT8": "uint8_t",
> +    "UINT16": "uint16_t",
> +    "UINT32": "uint32_t",
> +    "UINT64": "uint64_t",
> +    "INT8": "int8_t",
> +    "INT16": "int16_t",
> +    "INT32": "int32_t",
> +    "INT64": "int64_t",
> +    "FLOAT_SINGLE": "float",
> +    "FLOAT_DOUBLE": "double",
> +}
>  

Is it really worth having both single and double versions.
Seems like unnecessary complexity at this point.

> @@ -291,6 +302,25 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
>  			return -1;
>  		}
>  		return ret;
> +	/* float parsing */
> +	} else if (nd.type >= RTE_FLOAT_SINGLE && nd.type <= RTE_FLOAT_DOUBLE) {
> +		char *end;
> +		double dres = strtod(srcbuf, &end);
> +
> +		if (end == srcbuf || !cmdline_isendoftoken(*end) || isinf(dres))
> +			return -1;
> +
> +		/* we parsed something, now let's ensure it fits */
> +		if (nd.type == RTE_FLOAT_SINGLE) {
> +			float flt = (float)dres;
> +			if (isinf(flt))
> +				return -1;
> +			if (res) *(float *)res = flt;
> +			return end-srcbuf;
> +		} else if (nd.type == RTE_FLOAT_DOUBLE) {
> +			if (res) *(double *)res = dres;
> +			return end-srcbuf;

Space around - please
