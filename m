Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A23CC9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 06:12:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 121C1402C0;
	Sun, 18 Jan 2026 07:12:23 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 9E4FA40270
 for <dev@dpdk.org>; Sun, 18 Jan 2026 07:12:21 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so2752691f8f.0
 for <dev@dpdk.org>; Sat, 17 Jan 2026 22:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768716740;
 x=1769321540; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMTqI+nYzyANAo1B/vFEKgDDJpxBYy99hAgSh+XwASU=;
 b=WZJU08amNEAFeyZ4iz6jsKU1BJHZI/5u8/eFwHojlOozdqGbk+vPH9+fbuoBufNRRk
 otB7ZgYuSdyoS2hjARaCaV/0lfsyaIilfaHH9ahg7j8JmGbn1Dv9bZl8IgjN9kpRp02Z
 zOE0h8mgV3gnsLzWjUeVgb1RrsOVmhZqBu73y3OFcHwLJqTYKJfFj3MtN9r28bx3GZhg
 QSuGAFdd0lz6owhhENewKUPSEzDpR3ixmfTqWMALz01wEMULjim4nA7YIEAk8BGmA4kg
 y4z0ZAqgvSIMihm5Tpf54g878eA0mEwbbaWoCMdZMwAAc79KgqDn2jMgobTjJ/P7F8dr
 veLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768716740; x=1769321540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MMTqI+nYzyANAo1B/vFEKgDDJpxBYy99hAgSh+XwASU=;
 b=PRiMKUSSDuRBXgM1JLjNTZ+kLzhVZR5eBFlBNawVH5+TgzodxDfaMQtLb8CdqJend4
 Fn9cAvdA55EZwbmdRKEFKXHW/J5dBtY1kOahRacpo611o5TBfofKrYVBVfS8bdUDXp23
 gCuV8Hqb7BTr3JHOkFaTOx0y8IJw90yE5ph7f8oZeWgYm8sV5pVUMRGUQ/4/ficsYQAj
 RrRSLNyTOKIl/o2Fc4WJfEA/xP4wAjWIebNPOFmC5UfH+tkjhBiq6m+x5Xvhs0vWIi1P
 9ZlnPCxS/Qu2MBimKy+li0Hd+FZhiIJI6vm3tz8ZNZz0dW6I3u3Evx7xY860GfvK8eRE
 L8Iw==
X-Gm-Message-State: AOJu0YzdPmu87V7Z5doBNiYRO8oFJortzKNXESLNgnC0Gi9/mA/OtYx0
 q07sbS7uBMR753c0d16z7+p+MM7xl1m3ApK3eQSWn2owfz5QU2tqF2PGYAFJ/WMExw8=
X-Gm-Gg: AY/fxX4TirSaoRfjPToEyyPAA/Dy2aGwkyS4EcwtAVwU0vtrf1WIWJXj3DW9FpnXAvH
 zI5qbkFse/85aFmYGLst3oSZnE1VKmxgSsZp1RfXZnDLe6GR3Y5OQtM/wq56VSszuSDGnuD+n0Q
 7ElLRJbUNDWBwqizXnA5kneJpoPx5f6Gj6kf9JnbF3FeQ93Mcoukf8/VogOgKkLOMQGfqYN96H2
 At7tlk4zH5rRlhQJsU2uwpBfU6ulzEwpvcPvtT4mxLozPJ1lLKkSCT+gvA1uyN758nJe6M3Osxp
 laEVabOS56jkBnum/+/Mgj4HtwXFKz2tmRyMVoId5fAWMHOzPb4/Jr4RBXmDd9TMyDSDCskBRX4
 Dynna8d8M4WgxqeyABjJikd0/gH6gqRFNBEOdHooLIyCBalk+o5qPbDDLUliMU5Er/tRNAzx+QN
 hqd+u7YHVBUzgJpjMtodkTFpl9ZQ8JIJflPVu7/1ChLdltUHKv14U+FgpCrCgzm08=
X-Received: by 2002:a05:6000:3110:b0:430:f40f:61ba with SMTP id
 ffacd0b85a97d-43569bbaf11mr9449099f8f.41.1768716740457; 
 Sat, 17 Jan 2026 22:12:20 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921da2sm15149043f8f.1.2026.01.17.22.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 22:12:20 -0800 (PST)
Date: Sat, 17 Jan 2026 22:12:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com, bruce.richardson@intel.com
Subject: Re: [PATCH v9] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Message-ID: <20260117221211.57755069@phoenix.local>
In-Reply-To: <20260117210322.5419-1-scott.k.mitch1@gmail.com>
References: <20260116231907.13895-1-scott.k.mitch1@gmail.com>
 <20260117210322.5419-1-scott.k.mitch1@gmail.com>
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

On Sat, 17 Jan 2026 13:03:22 -0800
scott.k.mitch1@gmail.com wrote:

> +/* Main test function that runs all subtests */
> +static int
> +test_ptr_add_sub(void)
> +{
> +	int ret;
> +
> +	ret = test_ptr_add_sub_integer_types();
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = test_ptr_add_sub_pointer_types();
> +	if (ret != 0)
> +		return ret;
> +
> +	return 0;
> +}
> +

Ok, but if you add more tests consider using the unit_test_runner()
in test.h. Mainly because it makes it easier to pinpoint which subtest is failing
in a big test.
