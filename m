Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35DFC021AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:27:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF58E4014F;
	Thu, 20 Feb 2025 03:27:31 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 6304740041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:27:30 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-220e6028214so7821835ad.0
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018449;
 x=1740623249; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Dc/Qm7IiVVlhG6W9ZfdFETY4Z41pLAyhIsgN6LOQcw=;
 b=pK/5bSw21wa1w+Lr08cynrh0cJkUH+rQZFn6xqtTGlubZQtRHjXGqyEveHbX1qmmxr
 TN+kk/Y6/mnYi3S8DR/XJE67hc9CAG/WzWIaXwSS1cOlae6tLM4RQ4bSZtzdC8iSkrc1
 QlK7502CL6Rjk0nB396cvpncfqGWx9FIaOYh1nfQdzBxPLx0npkl6kJF+1pURc7MAFbo
 yC4+ibTnZBLgcGCnS6/Ct9ETPsh9VJr1vyZDHNrU9PLtkeV0+FkDFJEabQO+njZDsM7X
 17aT1Sj6/W7fO0rGdJ/+qHeLBFuqTOo+GQbRRW0UUp//ceXENzEmAQl9OXA2gHzv3fEW
 mjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018449; x=1740623249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Dc/Qm7IiVVlhG6W9ZfdFETY4Z41pLAyhIsgN6LOQcw=;
 b=g4jcksF85QUd/lSU1nK/6bHyeAEVNG62nh1QeFT4qMrUsMeJiBNxEOcFIRmq0BdMNl
 gSP0P4YmIaNEJrK9emauj+bgoKdlkOZGvgMYBJzhLryieA2yHKpeWOPs3psl9UPCLRmx
 RGanYSBNB8S2FXGtaLH2145P+OhknD/eGrEIolcL1rNTsU6QKoJl742GNhtVr7g8uSCr
 CqEQJDg0WXrvquMzP6M11L/4EM/MFztfsZ0Xx7iczdBwQkoHlR6Jk69BqsBlkd/MF3NE
 vFasBRbZV0pWDYeOq99NOwDHBCm+f8k6qsGTL0VKbuPJfPi6jnCyHWxeZX4bmIgP7lrX
 gWng==
X-Gm-Message-State: AOJu0YwSwA8CD2e1jvtkF2L8V32jqopozQnnbeBZZD32/01iQ2+yWWtK
 i0iICUV3ld62ysaWOil5n1J71shOtWCKfHqfb/SLynUKJxyscHc+kk/naI+bXZM=
X-Gm-Gg: ASbGncsIn6XGswFRr6whkqBdBOQ49OOtQR5KdoiP775CN8N27pZLOQ1vS0lkD9NHAjQ
 xQRKfbGjxSm0a/XLuXNkt/O62je40pKy0Lyr6W2mCz9I3yg8mGF/Jsz0jG2gK8uVUHY34T23yZ/
 4KjEHjnChVOcjTjNuf/nkiIwlNXPbstvU2yy4AITl8NKEz/s9duV0KDNdZyKK7QrcjJoeCUXuNl
 Xsd7XtiHnSK1ER/8aJxLW+DnKJ91HxMab8mnKYPp+sw5ciIJlj4F6HKI+rTQfYH20JfKFRXfoLv
 Q5zfhjXrH49dUZ4zqA3jy2+RJ/WHd4otr7VWWZK9xzj/eMOR3LYjXupxH0dezppdOEG+
X-Google-Smtp-Source: AGHT+IGUjeeFbLYfLh3AU2y0GwgKCmgExC0qSlV4EOE4EIkvwIuth9Z41RxJ0BudHNLfS242XxL9GQ==
X-Received: by 2002:a17:902:ea06:b0:220:e63c:5b10 with SMTP id
 d9443c01a7336-22190690192mr10347725ad.34.1740018449500; 
 Wed, 19 Feb 2025 18:27:29 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22120093e41sm64353095ad.93.2025.02.19.18.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:27:29 -0800 (PST)
Date: Wed, 19 Feb 2025 18:27:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v3 01/10] eal: add workaround for __builtin_constant_p
Message-ID: <20250219182727.18c1d798@hermes.local>
In-Reply-To: <1740016899-2817-2-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740016899-2817-1-git-send-email-andremue@linux.microsoft.com>
 <1740016899-2817-2-git-send-email-andremue@linux.microsoft.com>
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

On Wed, 19 Feb 2025 18:01:30 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

>  
>  #ifdef RTE_TOOLCHAIN_MSVC
> -#define __rte_constant(e) 0
> +#define __rte_constant(e) _Generic((1 ? (void *) ((e) * 0ll) : (int *) 0), int * : 1, void * : 0)
>  #else
>  #define __rte_constant(e) __extension__(__builtin_constant_p(e))
>  #endif

Probably worth some explanation as to what is going on.
