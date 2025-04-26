Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23F9C369CB
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 16:20:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFF1840156;
	Sat, 26 Apr 2025 18:20:23 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 079DC400D7
 for <dev@dpdk.org>; Sat, 26 Apr 2025 18:20:22 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso40108995ad.3
 for <dev@dpdk.org>; Sat, 26 Apr 2025 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745684421;
 x=1746289221; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87/dxoZu4LC5her3T6cP8ZW7CrvdHcY0gauGdPPcNWg=;
 b=VF+JHtc1b6qkms58OYfP6lwpGC43J7JCnIo4GBczBFLUqxsT+JWd7BFkjpe/TQ+VCC
 qanr9/IZm9WoKqXFJhh5RAhgPSPsLOelRMLDg/V79a5VdFhV+o/JgOPZ3llCWzAuoLrs
 21Mc07ecIDr0TSXfQLRF2SzlAaryFe0/A0WL2v9srM3DweEVqeRYGNMjv4Ff2bOiXTMS
 cauPwsc8qQVJ4i4Nm7RbJe2/34/JVfyzvKArgKuC2EkITzwW87kq5zV2o+w2s7Knl/Ip
 6fJZZ8JaX4Gjp+11E7f7undpx4mfmWZ0OqUycgfUvjncS7vEdTUBrA85N2yyhYLBdqw9
 lHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745684421; x=1746289221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87/dxoZu4LC5her3T6cP8ZW7CrvdHcY0gauGdPPcNWg=;
 b=tioZ5kHcTb9DhbjK4hDwOJXIyF0i4ErgNECJDa7fDuPBKjMN0Bfb4mhOIHfgxv0Mea
 pHqug+7UBJlXIV3Ouh2NhQ36Liu8LvoPpKP1qVlhZfq2++Q5YzVNr7GlE7RNhB+ePX+5
 BUZZzjCgt6dWC6drw5h0l0NOSgPy1iuDgfOD+66O/YmYFHD90vIWLrGtgTMjTSbXDSde
 nfYoQsSa4zWk2F1P6XtKqB2jKj6sjTiX+8Kd4S/15Z4YiD3UoRvBPYIcSNOhY9O53pld
 LxYVX1cyseJWltA0JIn5uS4t2NGg5oqZoNcEZCZ0NeEP1++FPLJBHqqafR2PaZTZZVny
 ULGA==
X-Gm-Message-State: AOJu0YwXYig9lAaoyOh8aVFqbk8YlaOlVAvc0fathsLzYTUj1hZo9TUI
 PouS+E7b7So4rp0gbS/Rj349A+/zpoEuIKEzsafCmpAGrffIye45E77uhvAfhxo=
X-Gm-Gg: ASbGncv4RTHwsZWc5zekWDi8tR4nf3Dk3MRD5P7cx2YY8duJxwBkVVsKZz31KDgaMln
 mZRT0oM52NsQ2i7/vKqJgAZyyu+YsR2BogORn+OcMqm69JBpUgFVBXmS2rmHTt2Hd5Bpav+VXdT
 LlTNbaKcZOgW+U+xdajyTg7BLNNCIk9z87GSkcc8pQS6m+m1sH/mwGewKMbOTTX0nVB68vJgXzY
 a969mp2BcZXYVEIj702zwMTjQrgHdWQdrwEqh/lZuUL+KG0G9R2DnWxperLeOyPPVIe3CNaFiL2
 aEB6lsO+498Fy9KkGpc3m/U2uzjBcBPyDgkdlOeGm8moS1nf6LJAFmcj5Hes0m+EQNqYA2HgJYH
 aCGLNMEaK9ZjdtB3L
X-Google-Smtp-Source: AGHT+IGZIugfWtQ5NIc1jEXUeKCmGvLUzYStjCURXzHtc1nWLspPOSnV2P7ghnyMRWdgJzi5WTFl1A==
X-Received: by 2002:a17:903:1a23:b0:223:5a6e:b20 with SMTP id
 d9443c01a7336-22dbf4db4b2mr80729345ad.7.1745684421058; 
 Sat, 26 Apr 2025 09:20:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5100c4esm51613915ad.173.2025.04.26.09.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 09:20:20 -0700 (PDT)
Date: Sat, 26 Apr 2025 09:20:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 03/13] net/sxe: add tx rx setup and data path
Message-ID: <20250426092019.204da149@hermes.local>
In-Reply-To: <20250425023652.37368-3-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
 <20250425023652.37368-3-liujie5@linkdatatechnology.com>
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

On Thu, 24 Apr 2025 19:36:42 -0700
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> new file mode 100644
> index 0000000000..2a5711367d
> --- /dev/null
> +++ b/drivers/net/sxe/rte_pmd_sxe_version.map
> @@ -0,0 +1,5 @@
> +EXPERIMENTAL {
> +	global:
> +	rte_pmd_sxe_tx_loopback_set;
> +	local: *;
> +};

The version map has been replaced in current main branch
with RTE_EXPORT_EXPERIMENTAL_SYMBOL macro.
