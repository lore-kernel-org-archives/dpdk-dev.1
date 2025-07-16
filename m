Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4028C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25BE940666;
	Wed, 16 Jul 2025 22:16:30 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id AD43A4065A
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:16:28 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-748e81d37a7so227400b3a.1
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752696988;
 x=1753301788; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWrDi17fznET4M3x0QSk+DPasaWNeG7Ag1UR1H52oaU=;
 b=FqUmpA2++hpJjBxTkk7CfuHivwzVIlplZdq1nHRZCPQHUdbxQ7D2Uv46EF4omNESsG
 b2iWjQYfXahDHIFhSAFIVIIZoKJmMpEFg07+wvOGp4kXnbwBNiR3aRNWG5WhpeOmFXVI
 PTUeBSR+TqXQY/BpCHxojnURu+UplL8aJwYVcbKywnwOzQk2X1T8XRKBPJhEx/JUKWob
 5pNiNw7qoRc1jGoFg29DMgd4mNpGvtBd6z9Rb9IquaXpK2XpLlUUtJwbgv/feeQVs38X
 8SxbalF+dtDUsbDn7XxGGGKuh8g48RERigwRdN9xgSJ3JPIx0ADF13lo6L91iYf5E9iP
 OePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752696988; x=1753301788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWrDi17fznET4M3x0QSk+DPasaWNeG7Ag1UR1H52oaU=;
 b=TRCDErtQzzaMo8/AzoXeIpLFyaA7mgXVsegeOhB25H9I8i5xVjd9lXvh6wM4dr75Ke
 gC0z/RLLayjGozmOCAlQKW/mK0JM6r4W4fVndQ3sk9G+KwAa2wugfDTQAEi02N4qIuWb
 JSm36Ob8yoxBaXiNji1sR9jzEzPqPYAPPpPvTWD/emKE1VLLaxEsNVKq8ELi0u8mqXxw
 1G7FGtXr0wFBAfdvFxqmHXn/MSaSjeFAVNMZgCCzIBa1G1UgLptq/9eC7Uun3bfJw5n/
 Dxkul0MDgzl5nMcA21xRvS3fbUP//cBjPOBRgN+4kiugze53Rg8tu7cVyLYIKpRuLI1m
 y0dg==
X-Gm-Message-State: AOJu0YzZPwi2e+sgaBA4f+DQpKn5zM7Jj0GRak1Bis7A1XoJOy2Jjjcd
 MIKtADtJ8hZP6wk85btmrnSz1W1dGwaQqZGPo58ImgTyigF7C1BPcYIRuO3smhSOKzw=
X-Gm-Gg: ASbGncu2xVhj7slJdus0nsKvKrzgdNTl8xMptkYjr7M65fVCL3az7gcqbyAZ9j19GH9
 LxGzN2Z00MtpYoeyZmxHt+kr4A47Zvjp0jP8QXD4W1d+7llpCXV1Tevytgd84UK32KEY5UrzmvN
 6A0/Uad6uuv8cKfgToem21OFRgfFv5v/0zzdBf2O/rR8tSRPQ26b6kXE3r3uwFgv1/uulQECRih
 KmHN42VW0p4kxsdK2kgxg+0ec5biqBCKsLhdtQiJ9NY8VpaeEj9BaSzRc7jhI57KYK32+w9aFfG
 I+gWvhMqaEJAnW0WbOHps2+i4VzuN2Jk65DiaziRCn3uFi+IE/TbqJw6SCd8KfU2TlsCwjAW6Qm
 /9xFCtHrFnXedxhD6Kb1rcwW/zxfJDxO5wU/wtbXFcZL7uPCon8Qd7aSyacI1SeHNCYTfLw0OCR
 Y=
X-Google-Smtp-Source: AGHT+IG9Y/WICfxwE9FhtYztGRcy71FxdmRxrhE79mXTp8BhlB+b751Pib/DY24RDcMOCw22/fFVzg==
X-Received: by 2002:a05:6a21:514:b0:215:dfd0:fd24 with SMTP id
 adf61e73a8af0-237d754720emr7763026637.31.1752696987777; 
 Wed, 16 Jul 2025 13:16:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe579b0esm14231805a12.22.2025.07.16.13.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:16:27 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:42:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 03/14] net/sxe: add tx rx setup and data path
Message-ID: <20250716104257.2a031b0b@hermes.local>
In-Reply-To: <20250716082930.83026-3-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-3-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:19 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> diff --git a/drivers/net/sxe/meson.build.rej b/drivers/net/sxe/meson.build.rej
> new file mode 100644
> index 0000000000..33c394b21f
> --- /dev/null
> +++ b/drivers/net/sxe/meson.build.rej
> @@ -0,0 +1,8 @@
> +diff a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build	(rejected hunks)
> +@@ -19,4 +27,4 @@ sources = files(
> + includes += include_directories('base')
> + includes += include_directories('pf')
> + includes += include_directories('include/sxe/')
> +-includes += include_directories('include/')
> +\ No newline at end of file
> ++includes += include_directories('include/')

This file should not be in the patch.
