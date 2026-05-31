Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF25CD6E55
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 May 2026 22:34:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F50140264;
	Mon,  1 Jun 2026 00:34:10 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 8EBCB4025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 00:34:09 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304c520fe9aso9192342eec.0
 for <dev@dpdk.org>; Sun, 31 May 2026 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780266848;
 x=1780871648; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YA/KhI+PcKDTGtr3kIvRpuAkduM3oZHcxRtOfGTzwTg=;
 b=kT87ME60pWPlTuBei/hxpArgNWRpNPsGtDZA4l590p9GuN3128t+Ntiugpsf+Dkd3G
 bJ5qIaDZvZGQ/MTGuK5Qu21qWAlbhJawJyzmyF0gIcscfrlwk6m6JjOxf6UStbkRipyM
 yFdi2hXhT92SlXzSZBPSVtZVFDsu3x3no924kYwOmdfuf/NobaGJXuNLI8kS/gOmvg87
 RYh7Pn2S+akMgwo+AGC8p6KCK5EI1mmqm75lHq4He7+m4dv1AhH8IfcpyguPjV9ovNjm
 oMEnQHXs6PdDW8wFs5BFIh2uLSTZZqNSKkDP0aBFBsKIX0fXbPsshypikuvLd2zz69qH
 U/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780266848; x=1780871648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YA/KhI+PcKDTGtr3kIvRpuAkduM3oZHcxRtOfGTzwTg=;
 b=G85o+EWa7Qv2vgfWNNGk9o4GOeaeBFd2oPGikNJS47s8GdVg/wiKQhXOv6ptYFbLVv
 vV0UNGJsozpFE53wHcCDtr/xHFjaW0/voBtcfv+FyORHo9uiC1VLXWTgIlnIIWsF9sj7
 l8dmiwFrj1/OIWQAjC4Csg4Ox9EYkl8f742xUGy63ZR4b41oR4AbU+y14XY2MqErrJsu
 OW+HhCltrFAilaameqKQTBOKwOSzE0+twHt3RTtqcYI/JIxFyCvZai8vfgEG8rLbFVq9
 2XDncalqvSoOm0VTBRW+GUfYmAtvVv1OZig3n9t5dGZ+afxADnYVy8dyp9zR5MUjKgti
 7wtg==
X-Gm-Message-State: AOJu0YwboJpeaAw45MYSTUkjfldN8LIgMMUjqREUWJLezVnG8AG0qpq0
 j3/ldblNq5GumvQwiY08335ebNEjfaIO6BWo/wg6m2nwxjZTMdsIVRjT23rifqCHP2AXZ99C+SP
 Aoz/D
X-Gm-Gg: Acq92OHqmFUwve9DIaECkVxCwaibsR4LuiKsPviVAjRI5FiX0Uz0bil1I/8jIlf5a0V
 AuCBaJnXAh36yCPKMq8Flk3qYtHbcv01NGYb9CAMSSlOMbBStF75RtGP6fOqvJSI3v2g3S4m7km
 smo9uyG51YHNTx4i1cwXChcToed27wpdlyWDRmjJPFejNfI9uELnGG0ilXeGQ2oZTEOj6Q4ULgy
 0lejZmWpWlUZsZsAYEF/gNCBi94Lwr60L9Ib6yILBNMLHXw0DBoBhmT6kCqKCEugrfQvHq4MHZb
 +zMFtcd8VITs78DDEFmckMce4wzlIw1IWHg7LpgJRSUqTpM/RbYazd1tY0liiqHxzBmujJJVYeC
 i9B31I8Fj4vnOPbkR3PMwyslC95Q6yAGprPnRii0qwMs19oyF+u+UbOCe/iryqIuUPKBBeXVfrl
 gIcWjtfr29Cy7zDXdVhmkimD2FekC8fZAMRF/f4uHuGqCP0V686KgHqmQ7RMMtrWYlk+wkOyKLe
 MA=
X-Received: by 2002:a05:7300:a887:b0:304:df0e:9db0 with SMTP id
 5a478bee46e88-304fa4fcd06mr4181127eec.15.1780266848316; 
 Sun, 31 May 2026 15:34:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c10c1sm7033495eec.1.2026.05.31.15.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 15:34:08 -0700 (PDT)
Date: Sun, 31 May 2026 15:31:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 19/20] drivers: add testpmd commands for private
 features
Message-ID: <20260531153155.1067686f@phoenix.local>
In-Reply-To: <20260530184625.480938-20-liujie5@linkdatatechnology.com>
References: <20260530184625.480938-1-liujie5@linkdatatechnology.com>
 <20260530184625.480938-20-liujie5@linkdatatechnology.com>
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

On Sun, 31 May 2026 02:46:24 +0800
liujie5@linkdatatechnology.com wrote:

> +RTE_EXPORT_INTERNAL_SYMBOL(sxe2_common_mem_event_cb)
> +void
> +sxe2_common_mem_event_cb(enum rte_mem_event type,
> +		const void *addr, size_t size, void *arg __rte_unused)
> +{
> +	struct sxe2_common_device *cdev = NULL;
> +
> +	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
> +		goto l_end;
> +
> +	(void)pthread_mutex_lock(&sxe2_common_devices_list_lock);

Cast to (void) is unnecessary clutter here.
