Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791E9CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:24:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D85684065E;
	Wed,  3 Jun 2026 20:24:08 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 4C1A14065E
 for <dev@dpdk.org>; Wed,  3 Jun 2026 20:24:07 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-304545f5206so17739904eec.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780511046;
 x=1781115846; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEFZs+/JJ6o964osXkBWSOSGCgPsTYfEZgJp7wWgbxE=;
 b=Nyd+BsbUM/xxB3mnwBToW+JcE2T0T6SZz44t2ISxLiMTIEwSg9jdAhz41HCJb7se1L
 jsuXunhUUMXAWVYV+wSt5Jk90GHqvxH6xXmg2r5mj+WnwgPnv/AdQN+RaP/77yOFHdAU
 4jAV5Aqv3W2Kpbg509aWDfHV5FD0qxmqEKtKptSIELxg4b4BA9dVHD3aXErXKo9oXifl
 Gl3TXmH/9g+WrEDdUbiGIL1TclIjKKGrsGwzEFjTamZ2W4of65Y/vPDZdMnv1xh6Gy/P
 Al0oyD5vI/FVLIrTTe/Qn/J92vx/kmzW6HkVFQzcow5oAzLPhiJO1Ht2Du27PZkGjVjq
 NtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780511046; x=1781115846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AEFZs+/JJ6o964osXkBWSOSGCgPsTYfEZgJp7wWgbxE=;
 b=TbizaCVd0YgwcJj1ykJaeg2IkwcCf8d5H2Fm4HNTrAe7tNsH+OzjVJ3ePY8uNz3tvT
 csnvRQIUBHQMe2c7A6Q4BW57vYkJph1VkJlOjnz11jGtHgJkFCROtQA3mnFbZybmrnKm
 drLk9C+6MMy8dKnl6NYKcUEiO5jXig2HzI0ckXpZ7oyXCknDraLgBnGOcAB0QyrI9DUy
 MaIECm7bOVmDhGry62hC7r/yt4SD5L9HrrgJC2Uxq2ZNLlCuDOHq8yqDCpuGAEtUl6Qg
 Qnqnw3dBpjRWyKR9Jug2qW86zXQ/AVPnoAb2CPFWrLKwmraTfCwDwNPCyu22RatudV0Y
 0nXg==
X-Gm-Message-State: AOJu0YzsEXQrGyh5Fb8sQOaJOM1/byAn9yQh9101hpg4CxRXuIpA9Ekz
 CTQ2NTUaWRV7JdLX8g5MfHQQZoYBQvP5Eh945s2xGC+u8LKmIn/fbj84/OiY/dY/Zqs=
X-Gm-Gg: Acq92OHzgrfBGbbSBU/e1LQCsd83yALvZBOtZgW2wwtkz9qwGIHSY/yTTzeTo6OWaCW
 o3+afCvr5PDC6tvCXVLZ8WuFgXz32mOpjzh8geQ3LneNEhdetAG1AXlFRQxDbkC43PPiVnZH+r8
 qtq09y73QgXDnJ5eLZ6jbNzs2LODFQNQWpy5kRE9SubprLjHTa+AD/9idQE+B19MMy2KwaAZ4pz
 MpNOl5h6DomQ+VuQGpl+KJLkd87I7Nti1e1dEc9pmwEngJC350k2Fj2VG019R4D53uQ+maztxIo
 edICj35tXHtlTjc4IXV0ESYhevlEaE9fIRmke60+uwMGOsOVA6UO3n86hWiIv2PS3TukUFIaxBO
 Xj0GNX9zhptwB97lGTZUN3EIk8tvj3f3Q81Vx/awnHJsKtiTyhMayQZwUSCZxl0AVc9OBA9sfCL
 UxvJY3Hitvgm5h8XGLkiQXzi4t+WkopBaz090eh0JOe6oyH/jmh0Jnroff/D2gtn9Jfh/mvaTQD
 BY=
X-Received: by 2002:a05:7300:dc92:b0:304:b93a:511a with SMTP id
 5a478bee46e88-3074fbd5411mr1942047eec.28.1780511046329; 
 Wed, 03 Jun 2026 11:24:06 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df805d1sm2682632eec.28.2026.06.03.11.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:24:05 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:22:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 11/20] drivers: add support for VF representors
Message-ID: <20260603112234.7b4f9912@phoenix.local>
In-Reply-To: <20260603062945.1253672-12-liujie5@linkdatatechnology.com>
References: <20260603022150.1140722-21-liujie5@linkdatatechnology.com>
 <20260603062945.1253672-1-liujie5@linkdatatechnology.com>
 <20260603062945.1253672-12-liujie5@linkdatatechnology.com>
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

On Wed,  3 Jun 2026 14:29:36 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Add support for VF representors in sxe2 PMD. This allows the host
> application (e.g., OVS-DPDK) to control and monitor virtual functions
> through a dedicated ethdev on the PF (Physical Function) side.
> 
> Key changes include:
> - Added representor enumeration and identification logic.
> - Implemented representor-specific dev_ops (link update, stats, etc.).
> - Configured back-channel communication between PF and VF for control
>   messages.
> - Supported the "-a <DBDF>,representor=[0-N]" EAL parameter to
>   instantiate representor ports.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---
### [PATCH] drivers: add support for VF representors

WARNING: [TYPO_SPELLING] 'macth' may be misspelled - perhaps 'match'?
#  drivers/net/sxe2/sxe2_flow_parse_pattern.c:1786:
+  					"Invalid pattern spec miss macth mask for rule.");

WARNING: [TYPO_SPELLING] 'macth' may be misspelled - perhaps 'match'?
#  drivers/net/sxe2/sxe2_flow_parse_pattern.c:1787:
+  			PMD_LOG_ERR(DRV, "Invalid pattern spec miss macth mask for rule.");

WARNING: [TYPO_SPELLING] 'macth' may be misspelled - perhaps 'match'?
#  drivers/net/sxe2/sxe2_switchdev.c:197:
+  		PMD_DEV_LOG_INFO(adapter, DRV, "current switchdev mode miss macth");

total: 0 errors, 3 warnings, 0 checks, 6571 lines checked
