Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF6EC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 14:07:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75B9C40E4F;
	Tue, 17 Jun 2025 16:07:13 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 9024540BA4
 for <dev@dpdk.org>; Tue, 17 Jun 2025 16:07:12 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-6fafdd322d3so61446556d6.3
 for <dev@dpdk.org>; Tue, 17 Jun 2025 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750169232;
 x=1750774032; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lr6rlvtE8k/0itljiEairVX5jR9t9FMHH7yt3lwvQWI=;
 b=IcjcSfEKOFYOHRiYmwAvK8Os9ZP0fyEFUh1KpEUuXDR3MG940zFx3+XGr7yIbrdHWB
 wnJUM/KkAJQC1MkPrjePtoHqKrTbIHYBi8xR3O6yIFrV7kQQ++JVSL+nCk4N1IK4LZAm
 3icBC8cq7SFSW8ii1yiwZTAIBOAXBLeMEguc0AEKpvBViP6YLq/ur+ZBoYAEGkW0w9N2
 Iim6wIuUcMjwmHRLZGjsQ52ilEjcAt1XOr0oT1Jf5E2+rznKSwTuDexvgNDT2Pp0uYeb
 Ez5+YGAXhYbfRZMw4TTK+4M751vgsJG9786lgPlKwpWyqmZ1KixiYWj6aJhxSJmZ908n
 kOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750169232; x=1750774032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lr6rlvtE8k/0itljiEairVX5jR9t9FMHH7yt3lwvQWI=;
 b=GBp+daT/chIfaB0H96RGzSOh5yl383SQnJwasj719vq4r12nYL7PI8VqK1uEGCvqeC
 M9Luz8nFTF0vHvs3g3CriMcHcFTw0j7QehWiheF6bBnd9fEFTRvyGxf5zys/bJjgauAC
 snbFeHnJxQG/dwotQk6SWG/0bmEdozXjR+GpGtGSh+IT5rCMI6YEORu2IBdWqkCrvPoT
 irPBaMXc8GPUcnmMorqaGHaEwDNctOFy8lcJTSlSc3dm1mBlb2W+SEwiEQHv6100ljCD
 lxxL4asyrwvoK7Bn01i1azcH965msgnXzVispcAtq1/2qjklIGxX4aaIYlx3Jzj+TwT0
 TLxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfYnbgDHf1+qBJM5zgBIEw7vaRH1+0102iM4UAsEcG7CeJD8V/JkQqN/Ud7VcZW1spcGY=@dpdk.org
X-Gm-Message-State: AOJu0Yyf5g+iTt8R41SJslHTvB04Ki6StYE0SxQAz39KycK/9LU2pfUb
 /dOYigrsCLF18Ztsn2WvDj7fN1W0KzZIMzQV31jWYUKyJyAOJMuXSef32rOCbXWq35w=
X-Gm-Gg: ASbGncsKgDbBi6BwWKgxSNte4pMbbIM0GTJ2iqi4OoYOZJMHEmf/Pv0A4Ec1mFmvU8G
 xhY9VufyUmbFKyyOzThVqYNw19DBG9WjQ/ZrylbmjQCRSS4bJBISTYSDv0LhiNce22MfAz5FnU5
 yJh9rB9LOwez+OyrHtYDfrC40VxTqQyU7d9V4ehg8UUxOPS6V0Sk7UV5Bn5OqGMIQZ/LO+zkLPl
 vd7zWuCHxn4slOtOqWb65FCpud6tNUfozUO1Is2kZy8b9Qd421fsy2iW0eRjH/qYbGNhQkOZZf5
 wC8csG4anwBxPwWsL5ZJCLilKFE4GXGgCdge6jMrSdh4z3RsKLo1obg+/6vtewbvDNNxJ4oRPQ6
 5wCMCQ8vJkx/fh96P7VG3StIOdEnaTUT0/5eXbXE=
X-Google-Smtp-Source: AGHT+IGuhI9gNb6tZG2xSwgPkLJVC2n55vM7dIBj3l//Qe/rs0QBj3hP9MBWKLdWwy+VHMx4w2It/Q==
X-Received: by 2002:a05:6214:ca5:b0:6fb:414:77af with SMTP id
 6a1803df08f44-6fb47735c9cmr248689576d6.7.1750169231681; 
 Tue, 17 Jun 2025 07:07:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb565058fasm22284856d6.31.2025.06.17.07.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 07:07:11 -0700 (PDT)
Date: Tue, 17 Jun 2025 07:07:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1 1/2] net/zxdh: npsdk add flow director table ops
Message-ID: <20250617070708.10c146c2@hermes.local>
In-Reply-To: <20250617093225.3570498-1-chen.bingbin@zte.com.cn>
References: <20250617093114.3570444-1-chen.bingbin@zte.com.cn>
 <20250617093225.3570498-1-chen.bingbin@zte.com.cn>
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

On Tue, 17 Jun 2025 17:32:25 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +static uint32_t
> +zxdh_np_agent_channel_acl_index_request(uint32_t dev_id,
> +									uint32_t sdt_no,
> +									uint32_t vport,
> +									uint32_t *p_index)
> +{
> +	uint32_t rc = ZXDH_OK;

Odd indentation here. Should either align, be nested or use one less tab.

static uint32_t
zxdh_np_agent_channel_acl_index_request(uint32_t dev_id,
					uint32_t sdt_no,
					uint32_t vport,
					uint32_t *p_index)
{

OR

static uint32_t
zxdh_np_agent_channel_acl_index_request(uint32_t dev_id,
				uint32_t sdt_no,
				uint32_t vport,
				uint32_t *p_index)
{

OR

static uint32_t
zxdh_np_agent_channel_acl_index_request(uint32_t dev_id, uint32_t sdt_no,
					uint32_t vport, uint32_t *p_index)
{
