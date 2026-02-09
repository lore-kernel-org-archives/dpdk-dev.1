Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53C3E7E0D0
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 19:05:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A29294042C;
	Mon,  9 Feb 2026 20:05:42 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 0E21B402F2
 for <dev@dpdk.org>; Mon,  9 Feb 2026 20:05:41 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso46117085e9.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 11:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770663941;
 x=1771268741; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0aCo7op5PCDSz9SN1FWynX03l7RrwqYVnHOiP5q0gwI=;
 b=y8A8VPd68zEK3DPppegfHqRRH2eVJQQM/F3UVJ6sJj1mODVWPSg+g143r6WqSHXCeN
 9OQEF3ryAqcyMSpJIjxi861nZMlezCy3Rq9lYuoacKq8FVInFTFszV/DIp7l9wX4yVz1
 13bcJdtYgRirLsxiyTe1anEDcznQAjtGXpPSvmFQ060Rb1gZItlP4ifKnhR9/eM+TAD4
 SAENU5Ya6SEyEnBE9a+FEEFPSEuMLc/A2DJXh9GU2LjWMI/2v/3aR0gXaug9kuYPQKOw
 fq4c6M30HhX8HvDfM3tmzvSoLzZtSKLIDXmk95XvTqVIfChX7mVJAnRuLX90pbXH8kAZ
 gHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770663941; x=1771268741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0aCo7op5PCDSz9SN1FWynX03l7RrwqYVnHOiP5q0gwI=;
 b=T2oPgYf//0LHf9EPl/GRWU59YaQFbKnrRuf3Up0cz3EgSOLC4r1KecpwS2SaQ9mz8I
 cAxOYZ9Grzlk/dteAXSo1fduElGB5e5k2shqihBw4cxlSfPdCEQQTapn5lySE4srfRD0
 f8R4YX7zoXxEhnjNkTLG3abja9jf96KV7JrJJTbG4FHeizHcIfnNoroOjPQF7IzTr6r0
 udwUiyhls8o8VdnUhVg+F/Js1H8krE7o74uIc/gOSVtj5PKdMDRv53g4yeuamG8kW2Nu
 XdUZKUe8g5Fbl7iAhBNXUUvPDr9ROVG6A/HxzygQ3HqxX5JLwpz3/5T3VMoOrIZUTbVO
 ZHUA==
X-Gm-Message-State: AOJu0Yx3BSS0gGRmTVHoMCRQG7bqJ2LHFrN0pzeu5ovCLYj0iO2b5mIc
 /4Y4O+PyV2gNqCdifKqMBVIRzrL1DTT7iNB1sbRPEOVuq9iYRR0ElO9eeacYTpYTtcg=
X-Gm-Gg: AZuq6aL7j85PeLxOXlgUzp3Rrs0UTaUGnApDH4HtdxASe2k1PdTL3QWiIY9u6/+QiWs
 GHj6BwkH2uAWkEt0+C5WGjB0nwEHliEbMGyobgwoiIPmGfSw2RGnCbuA7HMYBLMGafs/ms0pzAB
 GH7rn+Ggi8Kxrr9a8ohq6XxMP2rId1an6pd3d22P5/v4vYjW6U48dom13uPPEVsxmuo7vJYK5D7
 iGRvUa0pzUQxBRUFHwr8C4DChaYpP811TvsGNgdJD360WUJnTzwMT5MuzsqtlJwwYP0qY0gLdMZ
 5VzSMjA8a/TJtnXxqbs3by+J+SJt4w8iR0C3YevAlLu2JmsW71w+h0b9mSGoMEPTLT3WfaNQd/D
 bEylReEb6fnSWnWdxA8zV8JyFVQjCqxo7KYCgjE+HKKIJRp2JOowRZXi7oX6WS3ITWT/A6bLczL
 p6rAPsxq9nAqurQjLHqPWsyMJtzUy5tw9PCW1XwEyLU87c5F4fQTrY
X-Received: by 2002:a05:600c:1daa:b0:47e:e452:ec12 with SMTP id
 5b1f17b1804b1-4834d836d1amr6928985e9.15.1770663940594; 
 Mon, 09 Feb 2026 11:05:40 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm8676995e9.6.2026.02.09.11.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 11:05:40 -0800 (PST)
Date: Mon, 9 Feb 2026 11:05:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v17 02/13] net/sxe: add ethdev probe and remove
Message-ID: <20260209110534.2e0b390d@phoenix.local>
In-Reply-To: <20260209012458.506200-2-liujie5@linkdatatechnology.com>
References: <20260208115626.146863-13-liujie5@linkdatatechnology.com>
 <20260209012458.506200-1-liujie5@linkdatatechnology.com>
 <20260209012458.506200-2-liujie5@linkdatatechnology.com>
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

On Mon,  9 Feb 2026 09:24:47 +0800
liujie5@linkdatatechnology.com wrote:

> static s32 sxe_hdc_cmd_process(struct sxe_hw *hw, u64 trace_id,
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

Drivers must not use or manipulate signals. Doing so could break applications.
Several years ago DPDK broke a Network Appliance vendors app from the signal
manipulation in TAP device.

This is a blocker for me.
