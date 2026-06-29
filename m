Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D53DC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 16:51:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CC3A40299;
	Mon, 29 Jun 2026 18:51:02 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 00BA940150
 for <dev@dpdk.org>; Mon, 29 Jun 2026 18:51:00 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-13a97ffb312so290664c88.0
 for <dev@dpdk.org>; Mon, 29 Jun 2026 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782751860;
 x=1783356660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1sNHRn8/oOYpG/A6g3PG9wKl7h06gLNAKx2Jor2RT0k=;
 b=QW8Uiq9EFnneWa1gSk3N7xEhnaNjrUct+RZ2D3EaS7BtO9LrrPks+acPOonG+1whpX
 Zoa+fT+Hr7WdE7BUGMLC6vMeXNExWfmN+GTFF8g131Dx9ggEMHG2tj/s8hvwbRJByxdL
 3PcO62lkNWJ9513ui4R0jy49i9lCM8ad9Vpw6UwKEOyORvEK6pl/7R7a2XEMiNPfoG34
 flPqrzunKMM5k18nNxg2b6dLsIhQ5NjmiSH6oOsPgXRuSd8H1YeitZZyPyhHSkC+D81x
 R6/hx/OdG2HON2Te7Zq79OZvr/9r4DVDtm1X6pJzSKquIrQTkQ34dMg8NTmq+BxeWipQ
 OuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782751860; x=1783356660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1sNHRn8/oOYpG/A6g3PG9wKl7h06gLNAKx2Jor2RT0k=;
 b=QK7KnU6KkPZUVEYjVWq1KpGc12u8Mu/thnmxfYQC9CRkmAd8sh1iH15NwTIrWk7ISf
 /PjQpkkcvSGOzfiCd50oDAP8sTUVbx8iuNuzeUDzc1lpxQxJNusI3Q40P7uQOfcf482g
 uQDLaM44nEJoou3UnJjQjZ9EmO/ZPTvnYogQbgIIrP2E7fQz8+KiRq0cwuvaIbMup4xl
 P55rdlO16GmT3v9F/tiC+0+HbhFy0/qghkxCcmC48JUvedKWXBbygxnfZwzmjxAe6v93
 BFIoVNCEiDXVMAg/tCWX7C1yqOczNaD9mU8EDNGqDKd14vlTy58LyMahxuOPPVajFMhd
 n5kw==
X-Gm-Message-State: AOJu0Ywsh+UKdVgmhxPS89hCDR4odRpraL07nVVlcYfpUq3sxO8a3pSx
 z4i4vQ+F8Mdpi7q9FBz+a8FV/9qvAoSGaUcDEsQt0CP5p3abaCkJox3qPW2wO2gHwQA=
X-Gm-Gg: AfdE7cmOi9cNI4qzBGGjNmVK/+qJRP5y1XZSFRyn6Xd+hfeVSqKEbOJiNuLqBtVtXEq
 4hivNbNZjnkmtRwnn/B3Ww1vZzRQT8UCe77iB3wAHOCH6QW3RYoZOnJVbJqUfFvCxWXQIcOz5eQ
 YGqqG+JmZfmW+KpXPFVT8VL+ZT6qwb7j63SpPfqVJAn9FCTeeQsbNpPtJqgrsEdVEq2xbQktVLZ
 y+dxISTtmiaH0OkVM85I3/PV65tAF9bCuH0ok46V+3LBu/NBiXd5jkUJ+cl3zZsMUcLdxvOPy78
 wXmfZXuQPUfoEcyXFT7afrsunimZu9OyRLkgvUSbmlfw1F2AKLreA5JIuoEzOmPKmTL3xYgTg/F
 yQXjajf1BFCUByD5S6n8/UUMMtsBrMj6vnKZ1OhYMFSkAOefKtDtQVW7RZ+ZhgNWrN9PHt2NkAG
 A3/MKDA3wfV1E/S50DtbZuJnSfYkAfuPvbaaF6yH7uOLLqyeSl5jIbog==
X-Received: by 2002:a05:7022:2389:b0:139:78a4:f57a with SMTP id
 a92af1059eb24-13b2a1c4ecfmr129028c88.23.1782751859487; 
 Mon, 29 Jun 2026 09:50:59 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fcf63021sm14747751c88.0.2026.06.29.09.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 09:50:59 -0700 (PDT)
Date: Mon, 29 Jun 2026 09:50:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, marek.kasiewicz@intel.com, thomas@monjalon.net,
 mb@smartsharesystems.com
Subject: Re: [PATCH v6 1/1] pcapng: add user-supplied timestamp support
Message-ID: <20260629095055.58620f0c@phoenix.local>
In-Reply-To: <20260629093942.983145-1-dawid.wesierski@intel.com>
References: <20260624215858.710217-1-dawid.wesierski@intel.com>
 <20260629093942.983145-1-dawid.wesierski@intel.com>
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

On Mon, 29 Jun 2026 05:37:33 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> Add a timestamp parameter to rte_pcapng_copy() so that callers with a
> hardware PTP or pre-captured timestamp can inject an exact epoch-ns value
> directly into the packet record.
> 
> Timestamp handling:
>  - ts != 0: caller-supplied nanoseconds since the Unix epoch, stored as-is.
>  - ts == 0: TSC captured at copy time with bit 63 set as a sentinel.
>    rte_pcapng_write_packets() detects the sentinel and converts the TSC to
>    epoch ns using the file's calibrated clock.  The TSC will not reach
>    bit 63 for centuries, and epoch-ns values stay below bit 63 until 2554,
>    so the bit is safe to use as a disambiguation flag.
> 
> Adding the parameter changes the ABI, so rte_pcapng_copy() is versioned.
> 
> rte_pcapng_tsc_to_ns() is added as a new experimental helper.  It exposes the
> same calibrated, drift-compensated, divide-free TSC-to-epoch-ns conversion
> used internally by rte_pcapng_write_packets(), allows callers to convert
> a TSC captured at packet arrival time before passing it to rte_pcapng_copy().
> 
> Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---

Looks good, I would like to make some follow on patches to replace
the tsc_to_ns routines with something in EAL since it is generally useful
to get time in nanoseconds.
