Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60398CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:24:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEA274067D;
	Wed,  3 Jun 2026 20:24:16 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 903A740669
 for <dev@dpdk.org>; Wed,  3 Jun 2026 20:24:15 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-307263ad0cbso4677281eec.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780511055;
 x=1781115855; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGH7zcMIkner59Dw85Hzzvf4XoS4afVNq0PzXCWeWAI=;
 b=T/iOBLqyqlAL3+LdYAXAAC8RZGxeIc15s88WBazV4Yo/b15NsuO7fhpyRYqCEh7BtX
 faG9hmb7m5vIYD+YsjYhA63i6NnFYQBae2LRWia9ySKHZ3B6yJhta5VLvUjT+xK4hMYE
 WX8WW6r/8QL5scHW+6oAal/XGm1l85GclOfBeB2jcDeeIa3o8Pw2TqwbSQC0eKgRfJXt
 WXZuTKaXfB2BH2ozP0pwr5+QDbzeOkkOu6RVkPbtcGhhLyAuiSiu6bxJaY9cPwS0fZtx
 WwngYYNjVOxlLLYL3DcW6x8lJ85uGYqNNPmmz+S6rjJDA4JeXbgQU8uCm8f00estX2PS
 CpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780511055; x=1781115855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nGH7zcMIkner59Dw85Hzzvf4XoS4afVNq0PzXCWeWAI=;
 b=MRdoY57dcM++GfYcZgTei33uvEH/aVC2nFSUkisQFfnpsIZxWX+cmx8KdVqS3gK618
 wDX/PRY+do2Z/Nxk/EtDuPd7R0Vp91fO6atAX7+E1+umFdE4QP93c/Oa8YudjovIPQjL
 ERFLHKvLI9zSgMtr/IdVIP/nna2B/dhHPAh5jNcLJlnJ1cLAnpeEg/2tkSviarWadBF7
 81jDyCQyaZWHlXY0rNRYF+Kk0H9Drc7gEEOvX3mrZiXEma/AVW38n6CO0SdiJo4hJVrK
 vmH4B+76jvbAP3ITiCP7YKjlu4MK/wT7BYZZFinNKdJvN5e6FnDzwm0L05B8q7QNVqHM
 3Beg==
X-Gm-Message-State: AOJu0YyVjweOpSsDl2K5Bs3dd/UUeIf+M44xa05fT/B0U+EZp5IiJ/zS
 dlitpvSKMB28qIoQpSRFFdnc7dpzz60NTpscNVmPF04jEgGxGodDsHjRCKEafwTVqoc=
X-Gm-Gg: Acq92OEAHVJWtyrueZaGeq0k/Qe5aladP0NAfOJ0wXEg8Bv5O0pEZCS0WOrN/BRFsSS
 ZiHuX98WD2iQ4LQIiTRoovEKi6hV7Sp7ykiNX6LxEKp+LNV+HZWyF9L32u+TnUlvhUeBh3xG/4g
 nrqmoa0omMvrIoH4eiAqsloes0kYLq9VvyGh4CYv4hq4el2py1NZpCmpJg884iskPANUzZ26rA4
 x51ipKlJirYhrgK+PMh+yl2FILsCclzpgNQFfevlX2+s1W9J6B9E46bzZs5VNQDJs45Hrh15gIl
 eUndqmcoff0h4fehl54sASjB1NzC6zOp4rdT2JvTVPkgyZVaOSiikfg3jFfML+6ayWE5CiXAwKr
 fvsU44YNRovSMwWIL8QJxlbMzrONS4lswiVL0hmdQc8gfrFb2tXd5IFjnIrLSVmDuRwzGq6rYRF
 yUnUe2+k9mPKsKJYnRIj+PEh8yDfUihh2D6q+E5QTO1/8qrXwZez9RSp8iDXcoK7oTt/z4Pn9uf
 BAiUWSc685v1w==
X-Received: by 2002:a05:7300:7fa6:b0:304:4f23:542d with SMTP id
 5a478bee46e88-3074fa79e8cmr2286663eec.11.1780511054544; 
 Wed, 03 Jun 2026 11:24:14 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df805d1sm2682632eec.28.2026.06.03.11.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:24:14 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:23:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 19/20] drivers: add testpmd commands for private
 features
Message-ID: <20260603112325.7eb2a705@phoenix.local>
In-Reply-To: <20260603062945.1253672-20-liujie5@linkdatatechnology.com>
References: <20260603022150.1140722-21-liujie5@linkdatatechnology.com>
 <20260603062945.1253672-1-liujie5@linkdatatechnology.com>
 <20260603062945.1253672-20-liujie5@linkdatatechnology.com>
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

On Wed,  3 Jun 2026 14:29:44 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Introduce private testpmd commands and implementation files to enable
> debugging and testing of sxe2-specific hardware features (such as
> packet scheduling reset, UDP tunnel configuration, and IPsec ingress/
> egress offloads) directly within the testpmd application.
> 
> The parameters are parsed using the standard 'rte_kvargs' library during
> the PCI/vdev probing phase. Documentation for these parameters is also
> updated.
> 
> During memory hotplug events, the SXE2 driver needs to track memory
> segment layout changes to maintain internal DMA mappings. However,
> existing memseg walk functions (rte_memseg_walk) acquire memory locks
> and cannot be called from within memory event callbacks, leading to
> potential deadlocks.
> 
> This commit introduces sxe2_memseg_walk_cb() as a helper that walks
> memory segments using the thread-unsafe variant
> rte_memseg_walk_thread_unsafe(), which is safe to call from
> memory-related callbacks [citation:1][citation:3][citation:5].
> 
> The implementation follows the standard rte_memseg_walk_t prototype,
> processing each memseg to update driver-specific data structures.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

WARNING: [TYPO_SPELLING] 'thw' may be misspelled - perhaps 'the'?
#  drivers/net/sxe2/sxe2_testpmd_lib.c:90:
+  			cmdline_printf(cl, "\thw flow id: %d\n", hw_flow->flow_id);

total: 0 errors, 1 warnings, 0 checks, 2371 lines checked

18/20 valid patches
