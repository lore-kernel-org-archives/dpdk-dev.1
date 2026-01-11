Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740F6D2502D
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 15:59:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D640402E5;
	Sun, 11 Jan 2026 16:59:26 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id E16DC4028F
 for <dev@dpdk.org>; Sun, 11 Jan 2026 16:59:25 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so928021966b.2
 for <dev@dpdk.org>; Sun, 11 Jan 2026 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768147165;
 x=1768751965; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Bh44e0to1+MV/jdf7Tc1vu97TmSvkSpPAc/YQFlsrI=;
 b=VHTl/aY7BksDfNYz/DOuWj9eC60rsZeOokAOq3ukNJxRzGrZYP00kXywaZsbUZUuYN
 IDlABI9P0kev0l/Qe13RP0Cot8nm/t/JwdJ8y0kT1Bbuehvov6YeTxuJ3PlTP4QlCG/9
 2ZVyI809LMEpG/eYJaJQ3RFv0yY1O8mPqVkcYhGYZIfPNVkc8tmjrDdayRDoiKxxfnxG
 rHemvOk8sJ5uvhn7BLs1X1wjM0UkMKh5oH7aKuiVVKiAT5evtK3pPBMGjKE9obhGt/Iw
 nQgq83EHFOtscwoGeOvPLTws0HhZ8URJKO+hsUlXc9PGwcc356vm6PQgi+yMyGmkwwrY
 0n6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768147165; x=1768751965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Bh44e0to1+MV/jdf7Tc1vu97TmSvkSpPAc/YQFlsrI=;
 b=cVShci8J2Kb8cgrMTK8r/VZ9HIr647U57scOeFnWdzggbPniaQt9asASBZOujLVdUy
 e6JCGgJjHs2jhrIX3/vgcx3/cRQ25ks1he2MnNlJ1ZSq+FfihKkXVtRmqpjer9jIS8CI
 3ydRRFGX4o3nYaxZ9eEyeMVna38JxuGz6VDRpshjlx+HviUBLJKxTBGVf+NTL1qBx07G
 Nkl8yrejqtiGTSZXNBKvQEoC55Asa9y3nnu9TlxToJ3zP1B+a/u10TZLQbcxMFz/A/H/
 UXBsbBWWSjLOEWudJnf9e34hRMzZQ7PxooJw9esr01D2dWywhWOs6DUYu88HcXLTKbMN
 KoQA==
X-Gm-Message-State: AOJu0YxsXQ9OGdoaJaTr+tMBm0bEFwb+Xt8oweIWbINJP8ahQDGdhVyy
 MhVfnXqq0Tw+cosRpG/mLAI51wHy6wQvPa2hsI9RqN6cybS/fyuyqHhCFmCe0tIiCHo=
X-Gm-Gg: AY/fxX6EvDLDLqz67kq0EGXfXfMWTNr2RERt6O/XEw2XiOBayDIXifZ4AuyMq6BcZTm
 TnOwKvNznzyq9hyp7T0AXi2UfBbEuM6tbU8vIVgPk9CRklNnAVQwVJg4Fnb0+VC/UM8AmSEIqKb
 2PcfJyzVyr4Hiz7Oez+k+5WMmZMbdJvxjIoIBYFVxHQPmISIw18TfeSoSHCNR66GvWvnrDAbB/o
 KiCZrFMdv3/w8ZmV//oflWH+2ilO6CzbbFUFtXZGgCPAftvIDBcyxij0z20KySRAYxaowxPcUZr
 E5BGrQcX/jjgHWfMWHSahFRllado3yADG4J5gicoBF5uKS4aFdS0INTk42vrcwH5CObmIoyQIHR
 bq+LBwxpFi+R+xQ8J+M6LSbX/Hj5urHMcxW1yet14XpjWvvbjanETLRunm6af703QjhY9cWtHqQ
 oxyaRwVWcseiBJ3ONQp/+qfRqSHYjKeFdIlR1CGFf0YgKcNxe/CJ11
X-Google-Smtp-Source: AGHT+IGL/qONmmVX/nduL3CwqkF5hfgSxNghl7yjAvMXBIKCeoR5D0XuD5Jk3aIzH7UiG6ZExfMBew==
X-Received: by 2002:a17:907:c0e:b0:b7a:6f9d:8661 with SMTP id
 a640c23a62f3a-b8444c59a00mr1582750766b.12.1768147164897; 
 Sun, 11 Jan 2026 07:59:24 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm15466138a12.30.2026.01.11.07.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 07:59:24 -0800 (PST)
Date: Sun, 11 Jan 2026 07:59:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH 1/2] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Message-ID: <20260111075919.082d12b2@phoenix.local>
In-Reply-To: <20260111150033.81760-2-scott.k.mitch1@gmail.com>
References: <20260111150033.81760-1-scott.k.mitch1@gmail.com>
 <20260111150033.81760-2-scott.k.mitch1@gmail.com>
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

On Sun, 11 Jan 2026 10:00:32 -0500
scott.k.mitch1@gmail.com wrote:

> +#define RTE_PTR_ADD(ptr, x) \
> +	(__extension__ ({ \
> +		/* Diagnostics suppressed for internal macro operations only. \
> +		 * Compiler type-checks all _Generic branches even when unselected, \
> +		 * triggering warnings with no external impact. */ \
> +		__rte_diagnostic_push \
> +		__rte_diagnostic_ignored_wcast_qual \
> +		_Pragma("GCC diagnostic ignored \"-Wconditional-type-mismatch\"") \
> +		/* Uses uintptr_t arithmetic for integer types (API compatibility), \
> +		 * and char* arithmetic for pointer types (enables optimization). */ \
> +		__auto_type _ptr_result = _Generic((ptr), \
> +			unsigned long long: ((void *)((uintptr_t)(ptr) + (x))), \
> +			long long:          ((void *)((uintptr_t)(ptr) + (x))), \
> +			unsigned long:      ((void *)((uintptr_t)(ptr) + (x))), \
> +			long:               ((void *)((uintptr_t)(ptr) + (x))), \
> +			unsigned int:       ((void *)((uintptr_t)(ptr) + (x))), \
> +			int:                ((void *)((uintptr_t)(ptr) + (x))), \
> +			unsigned short:     ((void *)((uintptr_t)(ptr) + (x))), \
> +			short:              ((void *)((uintptr_t)(ptr) + (x))), \
> +			unsigned char:      ((void *)((uintptr_t)(ptr) + (x))), \
> +			signed char:        ((void *)((uintptr_t)(ptr) + (x))), \
> +			char:               ((void *)((uintptr_t)(ptr) + (x))), \
> +			_Bool:              ((void *)((uintptr_t)(ptr) + (x))), \
> +			/* Ternary with null pointer constant: per C11, if one operand \
> +			 * is a null pointer constant and the other is a pointer, the \
> +			 * result type is qualified per the pointer operand, normalizing \
> +			 * const T* to const void* and T* to void*. */ \
> +			default: _Generic((1 ? (ptr) : (void *)0), \
> +				const void *: ((void *)((const char *)(ptr) + (x))), \
> +				default:      ((void *)((char *)(ptr) + (x))) \
> +			) \
> +		); \
> +		__rte_diagnostic_pop \
> +		_ptr_result; \
> +	}))

Good idea in general but the macro is way to big and therefore hard to read.
The comments could be outside the macro.

Any code that adds dependency on a pragma to work is brittle and likely
to allow bugs through. Please figure out how to do it without.
