Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7BCFD8FF5
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 18:32:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B76A24028F;
	Thu, 26 Feb 2026 19:32:17 +0100 (CET)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 25FBF4027F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 19:32:17 +0100 (CET)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so907122eec.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772130736;
 x=1772735536; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkzeNdo4gLgagaRfeLaIdZFmxJ5Hg0B6djb9KHn4rkQ=;
 b=2lOFV7wCaYWZflcuvc7nY0pfwxw0/iQ0zjniVT+pTUGS/UEl3WOnLi3wSoJhDQpCp3
 aIxe85mQ6MP8CYxjLi7iKtX+pZl2rPiyD4lSPWTHuRyiiKOc5T9WJl0ivJ4quDOznLog
 EuLksqgLNv3ZgpO9ggMMJ6ZQQqzhl//+hN248ks0vnu7rEWIWaqVyPUQY2zlY/pMId+p
 CshGUo4tdk2WeldluYmXBbytXh2cm5mAnulEZ4UFugX+MNqqYYA/xCtNgKuORBci+GkG
 27VbrYH6L6ckWcFYRlyY5Bryy/d7xd/sIyvoGaomvBV8U1j060j/OY/s7pf4V4I2v+V2
 d/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772130736; x=1772735536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BkzeNdo4gLgagaRfeLaIdZFmxJ5Hg0B6djb9KHn4rkQ=;
 b=GPSvSlUrjR86Fa1aCxS+3705uzx3TT3AqsCCToMMArr7XzVUZXUCqIrIkV19ZJwf8O
 S+AUvpUEHJKb9VsAxZvrMeDjPbKAlyWJ3dGXE+cE5maW4KGSPP1Z7V764NPuoDQ4bTGA
 V4k2DrqRkMYBYwPMiQIvDXlVbG8wYxNS7kZJ5ItefUi5Bdb4J+OyOzg09lhAP0F1CrLk
 H5eG6M8A5gIOexNIYikxiJyq5UYrCJlVKVaANo5E0gk9evFkVMVugjWPR0Eck2B1NzMd
 DunyFSyT4gZMV7H7YkWZk0OTbRHPVcYVL/OULpOslN+gsALx/I0CLKz2loj17IE1fMVU
 yYaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBnrwjdfeMhctzMmiEh864shClphw9a3H3SR4VolZQZOomCniS1VmwqYqeAxTLw7ujlUQ=@dpdk.org
X-Gm-Message-State: AOJu0YwhPNp8TK3uQBXg3mbRKsj9Nwo5YazEQWJ2QSRgIM5rmsbA73IK
 I43HYctllMAcAvWqAptWqW6aI9Amq+3jbXBHQn/rJexpGlOUDUo3ntMJOTXpyaNRQho=
X-Gm-Gg: ATEYQzwrQskF01DSYtK34/u6FE/Qx4WJ/O0ibCQyFJWnDpVFQB5FrJOj5xkbygyRcol
 Glh5+1CIoNXTvwF2WlugU5ShM8le2poirIr7FJu+sow7Gu9ucbvQFBtLfLyrCKqp7y+fWe6Zvka
 Ofxn9y+2leuota73r//cMPlkODv6Sxga3JfZjv6UkgVbCQ/OBGAbfi6rL/7eFNildeBglc1E1nL
 IhPEiDNvVPex45AsJC68LgEcKkNU2HrwECAoYa0rPl4+04O0ITHRtTKgIScmvm0RxSlzcd15en3
 V9wG0l5h0P6hbQsV5c+vkM6vNONKMf2j/edak5kKPbJLHWyIF08AGtXKjU/tOYR43J1Hb6IymR9
 zOySJhXf4Jt/5kt1J5yCUEnp4CEuH2xT8/2wfeDwdP2z60Qap9V+A4Desk+/TeX94STf4StBGnp
 a8LfI0uLYvepReKGNo0GjBKHthm82C1jU/yKRGpfFuz9E8SGWlZYSL3rGbbMOkr95h
X-Received: by 2002:a05:7301:1008:b0:2b0:4c5f:c05c with SMTP id
 5a478bee46e88-2bde1b4dbe9mr33548eec.4.1772130736178; 
 Thu, 26 Feb 2026 10:32:16 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f68de3sm2372516eec.29.2026.02.26.10.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:32:15 -0800 (PST)
Date: Thu, 26 Feb 2026 10:32:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: P1erreCashon <2022302111412@whu.edu.cn>
Cc: Stanislaw Kardach <stanislaw.kardach@gmail.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>, Sameh
 Gobriel <sameh.gobriel@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, dev@dpdk.org, gong-flying
 <gongxiaofei24@iscas.ac.cn>
Subject: Re: [PATCH] hash: add riscv vector support for 16-byte key comparison
Message-ID: <20260226103213.39571856@phoenix.local>
In-Reply-To: <20260226064939.2362323-1-2022302111412@whu.edu.cn>
References: <20260226064939.2362323-1-2022302111412@whu.edu.cn>
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

On Thu, 26 Feb 2026 14:49:38 +0800
P1erreCashon <2022302111412@whu.edu.cn> wrote:

> +/* Functions to compare multiple of 16 byte keys (up to 128 bytes) */
> +static inline int
> +rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
> +{
> +	const uint8_t *p1 = (const uint8_t *)key1;
> +	const uint8_t *p2 = (const uint8_t *)key2;

Casts of void * pointers are unnecessary in in C (only in C++)
