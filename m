Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAC1C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 16:25:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5F7A406A2;
	Tue, 11 Feb 2025 17:24:49 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 965254068A
 for <dev@dpdk.org>; Tue, 11 Feb 2025 17:24:48 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fa488351ffso4923358a91.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 08:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739291088;
 x=1739895888; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQ294bFbJH4zXBMKTHLaYVTNVUl5RZXSb/LBSGTuTcI=;
 b=YOyTWrPqopAFdXzbDdSSi/C/VWrtuTVv0Jqoj6cO4H/drgK+XHgZjuYSKjZzyCxAxB
 NNCSQpI7/5VIG0/4KNKwqK4WJpJMmm+nYQRHH8xuVC69xhS6nIBSn3EFPxxYylTfZAZu
 JphAjEpW5eX4sHXHoeJwmeHSpDpmk6nmltG1VTVgD6bLs/WdnStn9fxkrPwc2dT4/0DC
 5OSgsxzvLZFpWvBBdGZWNIcQyK0mEMi9v5MuSaAMlCaO6Gur2vDo6U6GZ7R7DLsYU/LB
 P4H6LhyN7PsAZzJlj8TShA53bS+iDRT/sQ6Or6J/RZenQBSPBVv7jN8dRmOC3vkyfPFJ
 uPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291088; x=1739895888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQ294bFbJH4zXBMKTHLaYVTNVUl5RZXSb/LBSGTuTcI=;
 b=HEMYAGUFgLQKnxdJ3l1E3gHwJ+qYkBQCzyieW14BjmDMQLmm/h425uckVfeUyCRZcC
 Sx4DbWU9pO1Q+LCkU4Q3KbtM1XoyWaerDxCURbm9AoFlfRGREFa7n3oi6zBjBR1IukXF
 oGa28wDP7Z9FUx6jfJ5HepCZoftXelw2mVPyulSIONYjIqLkcrNjCPiBvnM0tFKeE9Yu
 JZgxrDIXQxuV3++35o4BwFfT48KN62+gR3J04Ta/Xa09/Dmr1aVe6c9I2S/Fyxk3DzEw
 69c2ql+JOi9rUu2JRdzXi2U91Go03S5qqpLrEzkRdtJrPXm3dBieSu2yLdRMoQBOxf0x
 GfLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa9H4C8VxWxNrkrNqC5wTYBVf4IYTSCeBKhSen0kvq4jCvRTO5cXunQITJn6gkSau3qE8=@dpdk.org
X-Gm-Message-State: AOJu0Yyak+N5MI5IRerfJCEBZ+DGfhILfoniGwEjYvTUSRKNanu/04bg
 3kKpW4cdw6JOBaEnfHV1iLtn8rlai19/Bd0fWqPC1mmy6M3RL9/HFEvMsGHG21k=
X-Gm-Gg: ASbGnctJ1sQChwdEa1KccYFGxNhGwjgbXnmpvykvj1ZUwMmGyeJpoID9jpbID11MAMZ
 DSU28pXFF78XYXe9E4OdQIfuDWkCKmu+SeJqox/wAPkH3tpy74keRXvJLMfR60ua6gNt75ec9Cn
 JFFmrCYZpETgZwK3c1sQVbnPjmHbEyG+RW8MNs+P9GoEIkBHygM+v6y6Oy6W909Jan0KhPcr6gg
 E/Umsjo/dTQQz5Ubg2fZmQhboe8a30G5a+UTy+lup92X0SYeUKZmHXiH3EvhiaKa5im6Cg2nago
 BuhLVrRHK0M4HHdHsX3PilzpD3N9QmhU9EXkgXzrffa0sUERVyM2L2AM4jwHHuxMzOVK
X-Google-Smtp-Source: AGHT+IFNYGVxjmYSQCfJ8ZryQQD4Ml8e3j26H4O32gqj6MQIAUXAD3wEItiq6JTmDdLE6dYow49DyA==
X-Received: by 2002:a17:90b:4b0b:b0:2fa:ba3:5455 with SMTP id
 98e67ed59e1d1-2fa23f55dcdmr29115383a91.7.1739291087799; 
 Tue, 11 Feb 2025 08:24:47 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa2d831a1csm8617326a91.44.2025.02.11.08.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:24:47 -0800 (PST)
Date: Tue, 11 Feb 2025 07:31:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v9 04/28] net/rnp: support mailbox basic operate
Message-ID: <20250211073110.61ab967d@hermes.local>
In-Reply-To: <1739263818-59770-5-git-send-email-caowenbo@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
 <1739263818-59770-5-git-send-email-caowenbo@mucse.com>
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

On Tue, 11 Feb 2025 16:49:54 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> +static inline u32
> +rnp_reg_read32(void *base, size_t offset)
> +{
> +	unsigned int v = rte_read32(((u8 *)base + offset));
> +
> +	RNP_PMD_REG_LOG(DEBUG, "offset=0x%08lx val=0x%04x",
> +			(unsigned long)offset, v);
> +	return v;
> +}

Why not use uint32_t here?
Why not use const?
Why the extra parens?

static inline u32
rnp_reg_read32(const void *base, size_t offset)
{
	u32 v = rte_read32((const u8 *)base + offset);

	RNP_PMD_REG_LOG(DEBUG, "offset=%p val=%#" PRIx32, offset, v);
}
