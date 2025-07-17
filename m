Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0CCC83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 16:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68EF14013F;
	Thu, 17 Jul 2025 18:50:22 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 35D7D400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 18:50:21 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so795967b3a.3
 for <dev@dpdk.org>; Thu, 17 Jul 2025 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752771020;
 x=1753375820; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQbmnR/WLlvpiSVZETd1muuqEHDA7uzGdbTt8msPMc0=;
 b=EbDrn6HKAAiIt8mPIhgTQdTcvaCfUpBPZzyL8VGWxtFziEhZ1EjgOEKyGgIKlPVhzm
 GZvqrM2cojZPdV/lBkW4i1w5jK2/SeF70CPCRM2SEDsrYlnD69NdlJLXkdErfkHBFIaz
 drpPTaP45TSBAyB3qvnRDgY8cp+I423okEHyi9A1zX/EePE76ZL3jlucXR5DIjOmch4g
 KGYzHhuTxnquh+4VY47IiILJmOvEYosWMbIclSRM/vxmQZAlfV9dpYHVjB4SwubCdjIJ
 rjzQohIplw8ukTZUu65CsW5R8ewXBbLAweuIdBbLQDCAf394ZnIHEVIgnIsxTg4gHdID
 aGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752771020; x=1753375820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQbmnR/WLlvpiSVZETd1muuqEHDA7uzGdbTt8msPMc0=;
 b=KF6B1Blj7+e9nlsvHj7RjqQAqQ8qjBIT5lgP2i1j1WNARhYikS/YEOda3r3goTWXvw
 H7auH4x0XQpkfJ8kPgf4R8DGt4v8Z9BQRX3Y0iV6i+BMMfrQ0AA8TXc1lUMzw6NJFKHH
 CiPYnraKSSsQpSKgZiwbRuq2UkgOH+6IXb3EGYwSaxIE11e7N7ru7oMew+B19DIwUqVQ
 77auvIq432vmVer3Yl2TTXcq339S2aO3awWpk5J1XwM+A0bWMAorUb9ROCdje2/ZVcOH
 rFqRcEBkP+KiiwcbB255BIJqx/H04VevE7mHDm8CamgP4JTyKiVOl8rxw3+lVcF9U7IZ
 /uTw==
X-Gm-Message-State: AOJu0YzbL1EOrgYmkvpIT0KGJAu4gSYl4lPpxkCwzSEPanvzivoLOVwm
 2m/a29QVVz0eYszaLbqOux6Wq2mvbYPBcmiAgkOdUfOxNDuav5HEOjbozzMrZcikjJTEe7aiAAq
 gkB89
X-Gm-Gg: ASbGncufJwl1DDz5J2bhYSzr0K0wjNejhTZuvXBXW6fDgFB+/TtiVGDeLiZJeaImZru
 lAVrfFlSHo8I05dvjct+SUTUHwpwaxlHH5Baq8awObJXkUd1XuVe/FfgSBd9sriG6IglTdgRa13
 ZOsyiY0RRn24t6xGgBij3rH+jSMq62fOBypFc2oIufw2HlYUof3cBIsPYBqDYOVuV7aHV8jdZE7
 DJ16zymVSydzeUjO1aDklb892UIbTb6D0AHo+b6JIaw2FYljtgmJSdywP1mvCx1URGixOf5bkyj
 fTkyrHKJ76Jcd6NyJ9FCV6/l7nlYnFW7MOVCGEvyKY5tFZbzSgfmFyfb7DmG6Da8sKN8Mcdaw1x
 cO+X6aeASvwdVzduQJIz5enRxKuK5QsODvx5r90BlwCYe/GLM/S8h8PJ7dNrOpCcjzTe1x95RRi
 0=
X-Google-Smtp-Source: AGHT+IG1mSKPAVyGsS7SZf3Z3G6eDaJgGTMJ80L1u4dWPyPeTF87XFA/FT6J30Dv3vf2vq/zpoNSTg==
X-Received: by 2002:a05:6300:8a03:b0:238:3f54:78ef with SMTP id
 adf61e73a8af0-2383f548d6bmr7514287637.45.1752771020274; 
 Thu, 17 Jul 2025 09:50:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe6c77basm15988579a12.40.2025.07.17.09.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:50:20 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:50:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 02/14] net/sxe: add ethdev probe and remove
Message-ID: <20250717095018.1c4da740@hermes.local>
In-Reply-To: <20250716082930.83026-2-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-2-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:18 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +static s32 sxe_hdc_cmd_process(struct sxe_hw *hw, u64 trace_id,
> +				struct sxe_hdc_trans_info *trans_info)
> +{
> +	s32 ret;
> +	u8 retry_idx;
> +	struct sxe_adapter *adapter = hw->adapter;
> +	sigset_t old_mask, new_mask;
> +	sigemptyset(&new_mask);
> +	sigaddset(&new_mask, SIGINT);
> +	sigaddset(&new_mask, SIGTERM);
> +	ret = pthread_sigmask(SIG_BLOCK, &new_mask, &old_mask);
> +	if (ret) {
> +		LOG_ERROR_BDF("hdc set signal mask failed, ret=%d", ret);
> +		goto l_ret;
> +	}
> +
> +	LOG_DEBUG_BDF("hw[%p] cmd trace=0x%" SXE_PRIX64 "", hw, trace_id);
> +
> +	ret = sem_wait(sxe_hdc_sema_get());
> +	if (ret) {
> +		LOG_WARN_BDF("hw[%p] hdc concurrency full", hw);
> +		goto l_ret;
> +	}
> +
> +	for (retry_idx = 0; retry_idx < 250; retry_idx++) {
> +		ret = sxe_hdc_packet_trans(hw, trace_id, trans_info);
> +		if (ret == SXE_SUCCESS) {
> +			goto l_up;
> +		} else if (ret == -SXE_HDC_RETRY_ERR) {
> +			rte_delay_ms(10);
> +			continue;
> +		} else {
> +			LOG_ERROR_BDF("sxe hdc packet trace_id=0x%" SXE_PRIX64
> +					" trans error, ret=%d", trace_id, ret);
> +			ret = -EFAULT;
> +			goto l_up;
> +		}
> +	}
> +
> +l_up:
> +	LOG_DEBUG_BDF("hw[%p] cmd trace=0x%" SXE_PRIX64 "", hw, trace_id);
> +	sem_post(sxe_hdc_sema_get());
> +l_ret:
> +	ret = pthread_sigmask(SIG_SETMASK, &old_mask, NULL);
> +	if (ret)
> +		LOG_ERROR_BDF("hdc restore old signal mask failed, ret=%d", ret);
> +
> +	if (ret == -SXE_HDC_RETRY_ERR)
> +		ret = -EFAULT;
> +
> +	return ret;
> +}
> +

This whole method using Unix semaphores and signals is non-portable and likely
to break some 3rd party application. The driver should not be doing this.
Not accepting driver with this logic.

If you must have another thread to do setup, the use DPDK EAL control
thread and block on an eventfd or pipe.
