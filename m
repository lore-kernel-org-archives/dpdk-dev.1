Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FCFCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:12:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9989440671;
	Fri, 24 Oct 2025 19:11:36 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2431F4066C
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:35 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-781010ff051so1551022b3a.0
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761325894;
 x=1761930694; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAWscVnzfd4JBtctkydhUeaFqgtDJF1bB+18LYQGviw=;
 b=q4LiiuRUFzkQNNHIIriREhQLagxLRGrqXFFnND+H1UVAGC/G+AUxmat/GREPGyuliU
 VXc44fVW6vyTG8Jiu/rMWklGXttQ59ZZfRrIh6H8eNgbLnaNxiWIjnTXTOJQ1rH6b4qL
 Jgw/ZPMIF48EPLvrljoRZSxdPYLUJCpQEKkcprYH0PEYr2Y92wlU6AMwWCmqEjNE3/M2
 7v6yGGpXs40L6VWUkyX+VXD0TBPQhxxcPxRhZn/fL+7hGw5ETapdq3SkuGJBy9FiUlzZ
 YqJQQmPfUinYgEZbaz+GD7IHwY5p/IkkldtTkLBHTPakhKlG0zRQvvZhGDvILi6ZKYLy
 NSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325894; x=1761930694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RAWscVnzfd4JBtctkydhUeaFqgtDJF1bB+18LYQGviw=;
 b=XJQ7OFnClWmrkby20JJ7TTgF4VglPzT7mrbmlE6cRBcqKGSgHHR1vDu+fGCHz7yO0p
 oFCSXad8TJNikZU9g0+QE+wFBx3htLvCMcg3iQB/5PRVNDNNptaROXxmCjkfGsnG/SXL
 zzBhRH0Hwcny9QR4mCsGKlkUgx2fhqVep1n6O5glIbFC1I5lG0dLYNgmAthyjJhMDIJk
 0j+TQKL5xpIlBXfY94TpjvJy5Zrdo32bum16KAhm+qaJdR4PIS/x8FZcenEFdTGqhml4
 2fVPW2jPR79rTAvvQnTsssdiNiYxqMl4f7J/xhtF5VRB1Tis1pAkJlKq7hNjyjfM21GY
 dNQg==
X-Gm-Message-State: AOJu0Yx5ClvfXrR6vdlxWHb6NypBeqG3oYXrnz5B6Ue/xks9ukwJQfmb
 t7uLlfateobMx3RjujuLVA9LP7mfLco6Exqdbr7QGM97tgpWDYFKIdARgMmvCbYUzuM=
X-Gm-Gg: ASbGncsDai8iMzRy9qKDjj++3Y74eOJjjHXF+4KgHMAT0DjeP+WqN471BGiLaPKL0r+
 wblHeuHvWO2SMFqvOpOihDcOR0OiXvKlywb/IFPO71JbZilbYpNMimeey5QVhmdfSToWq2pP5Jl
 AXl+/BUZurqr0ow52fjMJ6rJjW7IrFaAnv8rQu4eAJx3j+i1o4IT0LxJq7bwa57usINfMRF55He
 twZ9AD1XLYaOKv2y1yMSFaZATsmvTmNoYv4Pay+0fzV+VyyVcHNvJk8DKHGLPJpVHOm5zeBqnyu
 7h0aKEfsszSW+wUF5cOwPnUdeH6f/9rKzgo13ycLogR8M6BxBl/tGCQUwFqQPFrhaBSnhsIh85B
 mnwc6kw0RSVZ3Y7vfJ+cvwNqkUcBgcCqqeQiV3U5edpI12AkZYMkP4UQTyo0gXS9NyHl78vm768
 Of/nJNkQWMnIEmcNVL0Vuh165Itc/pCNMM+SqVPyjfrwPs
X-Google-Smtp-Source: AGHT+IEpbQsV4ua8J2W4q6so7FrC/NcffhN1KcF2Cnvf10Jq8Hoq9RyiTh+RgErf628wEUCU2061nA==
X-Received: by 2002:a05:6a00:1397:b0:781:275a:29e9 with SMTP id
 d2e1a72fcca58-7a274e2ea73mr8160883b3a.16.1761325894275; 
 Fri, 24 Oct 2025 10:11:34 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a27d583970sm4669776b3a.51.2025.10.24.10.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:11:34 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:38:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 08/13] net/sxe: add dcb function
Message-ID: <20251024093848.0f4139bb@phoenix>
In-Reply-To: <20250728090517.1811244-8-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-8-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:12 +0800
liujie5@linkdatatechnology.com wrote:

> diff --git a/drivers/net/sxe/rte_pmd_sxe_version.map b/drivers/net/sxe/rte_pmd_sxe_version.map
> index 957a753738..ef7887e591 100644
> --- a/drivers/net/sxe/rte_pmd_sxe_version.map
> +++ b/drivers/net/sxe/rte_pmd_sxe_version.map
> @@ -4,5 +4,7 @@
>  EXPERIMENTAL {
>      global:
>      rte_pmd_sxe_tx_loopback_set;
> +    rte_pmd_sxe_tc_bw_set;
>      local: *;
>  };
> +
> -- 

DPDK no longer uses version map
